Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60498C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 06:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CF68B22D;
	Tue,  7 Dec 2021 06:47:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA33D8B22D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 06:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZF4SP9ZSuzJmtnnxbbo/8xVDZZTamF24eEc9qB1xOSgiKNcMscDvXVlW6G+bTHpTEBNEpcBqmDxVKXoEthLAYqdQWECM9JUSNCLc2Z6pt0dNY6zdNsX0vI9jaNj2Qh8fSNDWnEW8UVop5bFwuCzv/yScRxTS75u/vyefi7VYObNZDuirNUIvzzEWaoMRT00ENph+E8d397O+YDp5vjvO5bFzHU4Wdy6HNqPH1qYAUc9Eg4K6QxUR2GLIJL00eRwgvKlKa+BV8S07zS59WU9VnscWmqGF9+r0GdWyLi6o2BH/+cZSVjSP30lWMAObwrMotX2hGvjTxJJF3a9EptTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/Zxq5mq1pFXwoSoL0K6o1hMX647uP8XmOyXhBxaznA=;
 b=TStKV3T1YEL9maUCbYfhhlCsK+RLrxQQem2blJIOGCbTlJRz5Yz0T+09VSMAHhVwARkjtlWBgzKESKMi6eMZ0irILVNdzgIUUjo1ZtRUslN0MGU5C5ukevl0oeC15RUdDZ1JxWrXD/tR+P9cMfbzRNsYtJ+jJxQ0fOGb5I7GqAALFCJDpG6Fw7I60F4ywLxggLrcOcb5Xr8whtay/fMp0oNdnethrPJ/CYCnN+vR1y8ZZF8PyjSI9BOMrEm/jQH5HKVWl1P/13uYUk93PuFnVbrvwG2b9jfVQ+xZE/vknseDVSD+z/hFX3hosVig2DQFlOyevkoOIma7NBb1hI21XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Zxq5mq1pFXwoSoL0K6o1hMX647uP8XmOyXhBxaznA=;
 b=Kjh9v4Q14SGpVUxQZH6fql5t2qjU1drYoPu5VhclovNDcDyxyZQmyLCTDQO7YcH7ipsLswpOgqRmhbH6aviNDO1YAAYlTWRY+Xd+ardStQWeKj5PIt/pN2sXwff3wUumcEwbUgajFR+x5ma7w07js//r6WqL8nI/2lko2RjRiOI=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4905.namprd12.prod.outlook.com (2603:10b6:610:64::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 06:31:43 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 06:31:43 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Topic: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the
 unified ras block data and ops
Thread-Index: AQHX5qGzAMl6NBiq7UqLumwBwC2HgawlD/IAgAFH9NCAABqZgIAAGJUw
Date: Tue, 7 Dec 2021 06:31:43 +0000
Message-ID: <CH2PR12MB4215038CC522DBECC20FFBF5FC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-3-YiPeng.Chai@amd.com>
 <DM6PR12MB46507136C714550B974B682EB06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
 <CH2PR12MB4215017BC0C393FEA8BB694AFC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
 <DM6PR12MB4650549B4CC9AB4DA48C81B0B06E9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4650549B4CC9AB4DA48C81B0B06E9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:03:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f91674a0-640b-4147-8237-7e6e1c20c707;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69323c8-2604-4973-4f33-08d9b94b3c5b
x-ms-traffictypediagnostic: CH2PR12MB4905:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4905DA1957F232B77B035AD5FC6E9@CH2PR12MB4905.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITmGW98mYoPbzEQERxi+IbzPhZgiBZqHHq055Ad46MrBGvY/QkzPQUK6/4bFN5hr6QHkhMPdAYzNAl649axwQyyA9EoDlZcYAzVQvLIddqQsIgJ1z08cWTPULxFVJzOMcJtWgBuHPIl433ewEm+gjmTKtCWmZOun9f+1I6uacr9bkahW8BauRImDv7cUL+Ne8ozoAMA7VgrkFY8ftC15nt2QSj6iOeZ1aoKLMQenac+Of8sQ7XSYpIfqP1UUyLS/5GpdeTpn2nAtQIj+N17DdixXVoffDQJQztobtq2Jn7pvS3BzcJJmbXf/LZLJgj4EoscA9WrjUn1iwHkJ/I88ah1OztrHn2reLKdinhIMlF+QfIOTwKlYcgYjjTqPZvryQtYIqxoJRiDMnoYMzX3Emucs2Xu9sjT/8nzTfXM9++Ku/qppvfXUtx0EmM6Wx4ttLRCQY33XoIKev2X1XUX4S+dv0JWCr7Zu2OLUUlVg/EHt0wiLv81ab/yC6M2aIYGP3EHb+U8tKWs68R5qZB6w+MpaicmESQJY6pGi6Z/IEhDgqk4JnpUWeSlrk9MCGFtrsuynQiImDIm8c7ctGRb+Xxm2R9qJmKnqFFBED4yDpEOmO2sM4mzCz3AQ4PrwQobKU8D4DTI68/UOMxLsYw4hP9bcHYNvTRJpR1eJfz9gw9MuHNsQcLXAK1doimvY3zpid1qTPUsZomeXyRJ+WPObnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(8936002)(7696005)(2906002)(86362001)(8676002)(83380400001)(26005)(38070700005)(64756008)(66446008)(30864003)(52536014)(55016003)(71200400001)(316002)(508600001)(5660300002)(33656002)(122000001)(9686003)(4326008)(186003)(53546011)(38100700002)(76116006)(110136005)(6506007)(66946007)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQlsmBC5rEzcD2bGgGW4XHiRetVZoSe5UBv1OfmXN7KxzhGke6JGkk7YNAYX?=
 =?us-ascii?Q?xPt/sneRdwkVdZsorNbNWtz43sMYljAG8QijXeBKRJvyQiHp5mtV0p9S0vMv?=
 =?us-ascii?Q?LITiTewi/k1JTOxNVsgz/AXTxoY4jqqikv+sq43uyASM5TSkAyod3TPmTDsb?=
 =?us-ascii?Q?DQuBfzKLZK89//d7uKgzWcE4VoIoEwPtmOZVnC4BGrqnteN8a6EdvQNKsmqj?=
 =?us-ascii?Q?8Oh0zkLKGsibzvvMj/w98lUwmrCWo2Ls0ESCCPuMrcJXOeGUqUWMf5bIYu3C?=
 =?us-ascii?Q?wVex6Q4GJ+N53HQwQm9wIpn4GpvZgKgjRGCOt09ElfQxgn3Jd9zu8Wo6awVo?=
 =?us-ascii?Q?RBv++DhDgjwVwxe3rvb+/FbMJXSZ5UUjBDjD82ZWYIQiUBG0g9zR7uZmBiGm?=
 =?us-ascii?Q?45KEtEJAukrrNww5c01qTtiyCtwQel/pkPPYFJYXE8Oh9nbMnY6+WUpjPOAF?=
 =?us-ascii?Q?W7Wa4/G143wMzNRDPzTOfEtwQyhJKGewhW3leDCmBjBOvPjbx+vPckW+RIJT?=
 =?us-ascii?Q?0gRmxQeSOgKD96ZgcGDSHkkMUk0usAW4COViAeobocvO6WTzJICwpKjSu/rj?=
 =?us-ascii?Q?WUC8YUljKQIBIvVy2qnUPwC0tcW/oa2f/+dfNesovCdf5MOm7LJUG2m8SJLT?=
 =?us-ascii?Q?B29RSjARpgQI+UVohx8rntl9P3Gg8O/eMf2e2ZafVpXRbmk9HyfyDe33orhF?=
 =?us-ascii?Q?EuJLlZZ37Uz4ydJFOW9zxyj6hpuqVVqbknnzgYcACj9+aRJ/3XQR5xzNeVgU?=
 =?us-ascii?Q?pd/VZVEEyGWXf0l/ecDXJwR1F4Flut7c6Ah6kvBu+xzB2CMGD5BQ0T3qkAjz?=
 =?us-ascii?Q?w30Dg5topiqAfyboREXArg4shr/qYZaLqN14aeVrZvnOHMd8h/udPadld5Vc?=
 =?us-ascii?Q?5BqbVmqIObZnAOjG/7O8FEBiwnEvWUaXNrWEb5Kn3JwJWL5jK3nt6Sr8o4Nf?=
 =?us-ascii?Q?9PnBhj94ahxE9WYqSi9q77P4WuU/wM/koBJYCN5T9DVPmXiK3i1VeMTSLhw/?=
 =?us-ascii?Q?bKcMMSwUQKLYaKHsj4dGAPoTq1rfc8JUNm3PB5Uh3EGy7KiTv/nwKMuhjJR1?=
 =?us-ascii?Q?i7ZLQG7z7h0nC9ia8wYm5aEuHjeQbNqNRHuSVHa5w18r12G5dLo5IGy2777F?=
 =?us-ascii?Q?c0TGzP+4xO0rnKNnFhB51+92rHWotGZ46BoGFkjJxweBYj81PihBBPYNsBbN?=
 =?us-ascii?Q?oRQZCje1QVPCS/o2ViWShO8sz6HYunLp42nxJTrkzgzca3pSElWYvHbMFq0Z?=
 =?us-ascii?Q?6MnYLZPT/XF1e5yLwmdmRbFD1s6RdAW1lsYKPPp7uSwySj2HdRtjcctR8f75?=
 =?us-ascii?Q?mQRrVY0hy0fgMjAUY3yRZvRvVdCQNzB6AOajcJaE2LSkkFr1jdxZ7dfPalaI?=
 =?us-ascii?Q?LsjBU9hfDC76Kl2RxRKOPOSv0fzS+ds3ntdu92TJkWCiFldA1Iwwe15qxKBp?=
 =?us-ascii?Q?zVgB1f6bHDxKRxd8i6QhHrLYfFCosaANYzHMh5OPyHpMVH/vlxEhOVZ4mhqi?=
 =?us-ascii?Q?1gpcSwO4Xe7Hns9RAM5/Ahbx8YaZDBwBAD060IyC22+dnlFTEMSzmePWCiBV?=
 =?us-ascii?Q?XahoK0m/lXimC9NdYKOsLuUru7Pj/G+M6Qyo9prgOB2y4q0m+o29Ugk+Z0RE?=
 =?us-ascii?Q?u0SORHsJWsi0L7/hT/hSrAE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69323c8-2604-4973-4f33-08d9b94b3c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 06:31:43.5001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /b6+b4RPrtS55bqlRAt+rU/OREkvgqiQKd/sUgehKxxDAkvS6701E5Qdc+sv91l7Z3XAPFc8RqN6KXW7cb69oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi tao:
     Thanks for your review. I  add another two comments behind your commen=
ts, please review again.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, December 7, 2021 12:07 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for the u=
nified ras block data and ops

[AMD Official Use Only]

Hi Thomas,

Please see my two comments.

Regards,
Tao

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, December 7, 2021 11:37 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for=20
> the unified ras block data and ops
>=20
> Hi tao:
>      I add my comments behind your comments. Please review.
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, December 6, 2021 2:58 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for=20
> the unified ras block data and ops
>=20
> [AMD Official Use Only]
>=20
> Please see my comments inline.
>=20
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, December 1, 2021 6:53 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas
> > <YiPeng.Chai@amd.com>
> > Subject: [PATCH V2 03/11] drm/amdgpu: Modify gfx block to fit for=20
> > the unified ras block data and ops
> >
> > 1.Modify gfx block to fit for the unified ras block data and ops=20
> > 2.Implement .ras_block_match function pointer for gfx block to identify=
 itself.
> > 3.Change amdgpu_gfx_ras_funcs to amdgpu_gfx_ras, and the=20
> > corresponding variable name remove _funcs suffix.
> > 4.Remove the const flag of gfx ras variable so that gfx ras block=20
> > can be able to be insertted into amdgpu device ras block link list.
> > 5.Invoke amdgpu_ras_register_ras_block function to register gfx ras=20
> > block into amdgpu device ras block link list.
> > 6.Remove the redundant code about gfx in amdgpu_ras.c after using=20
> > the unified ras block.
> >
> > Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  6 +-=20
> > drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 15 ++---=20
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 80=20
> > ++++++++++++++++++------
> -
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 73 +++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c   | 39 ++++++++----
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 42 +++++++++----=20
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h |  2 +-
> >  8 files changed, 178 insertions(+), 81 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 1795d448c700..da8691259ac1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -696,9 +696,9 @@ int amdgpu_gfx_process_ras_data_cb(struct
> > amdgpu_device *adev,
> >  	 */
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX)) {
> >  		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_count)
> > -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> > err_data);
> > +		if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +		    adev->gfx.ras->ras_block.ops->query_ras_error_count)
> > +			adev->gfx.ras->ras_block.ops-
> > >query_ras_error_count(adev, err_data);
> >  		amdgpu_ras_reset_gpu(adev);
> >  	}
> >  	return AMDGPU_RAS_SUCCESS;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 6b78b4a0e182..ff4a8428a84b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -31,6 +31,7 @@
> >  #include "amdgpu_ring.h"
> >  #include "amdgpu_rlc.h"
> >  #include "soc15.h"
> > +#include "amdgpu_ras.h"
> >
> >  /* GFX current status */
> >  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> > @@ -213,16 +214,8 @@ struct amdgpu_cu_info {
> >  	uint32_t bitmap[4][4];
> >  };
> >
> > -struct amdgpu_gfx_ras_funcs {
> > -	int (*ras_late_init)(struct amdgpu_device *adev);
> > -	void (*ras_fini)(struct amdgpu_device *adev);
> > -	int (*ras_error_inject)(struct amdgpu_device *adev,
> > -				void *inject_if);
> > -	int (*query_ras_error_count)(struct amdgpu_device *adev,
> > -				     void *ras_error_status);
> > -	void (*reset_ras_error_count)(struct amdgpu_device *adev);
> > -	void (*query_ras_error_status)(struct amdgpu_device *adev);
> > -	void (*reset_ras_error_status)(struct amdgpu_device *adev);
> > +struct amdgpu_gfx_ras {
> > +	struct amdgpu_ras_block_object  ras_block;
> >  	void (*enable_watchdog_timer)(struct amdgpu_device *adev);  };
>=20
> >[Tao] Can we add " enable_watchdog_timer" function into
> amdgpu_ras_block_ops structure?
> >And I think using ras_block directly is more simple than=20
> >amdgpu_gfx_ras
> gfx_v9_0_ras structure.
>=20
> [Thomas] The ' enable_watchdog_timer ' function is not a common=20
> function. It is only defined by gfx_v9_4_2.c and called in gfx_v9_0.c.
> 	   I think the function pointers in the amdgpu_ras_block_ops=20
> structure should be the functions used by most blocks and the final=20
> goal of amdgpu_ras_block_ops structure is to eliminate explicit calls=20
> to special blocks in amdgpu_ras.c file.
>                  So, I think it had better that the=20
> enable_watchdog_timer function only use in gfx but not move to amdgpu_ras=
_block_ops.

>[Tao] I know your concern, it's a tradeoff. Take the following code for ex=
ample, I think struct amdgpu_hdp_ras can be dropped and we can use ras_bloc=
k directly.

>struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>	.ras_block =3D {
>		.name =3D "hdp",
>		.block =3D AMDGPU_RAS_BLOCK__HDP,
>		.ops =3D &hdp_v4_0_ras_ops,
>	},
>};

>The struct amdgpu_gfx_ras below can be also discarded if enable_watchdog_t=
imer is moved to amdgpu_ras_block_ops. The current implementation is a litt=
le bit complicated.

>struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
>	.ras_block =3D {
>		.name =3D "gfx",
>		.block =3D AMDGPU_RAS_BLOCK__GFX,
>		.ops =3D &gfx_v9_4_2_ras_ops,
>	},
>	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
>};

      [Thomas] I understand what your mean.  But if we still have the possi=
bility to add new ras functions for these blocks in the further, I think us=
ing ip block's ras structure to wrap the amdgpu_ras_block_object structure =
may be a better practice.  The wrapper can reduce code modification when ad=
ding a new ras function in the further.=20
=09

>=20
> >
> > @@ -348,7 +341,7 @@ struct amdgpu_gfx {
> >
> >  	/*ras */
> >  	struct ras_common_if			*ras_if;
> > -	const struct amdgpu_gfx_ras_funcs	*ras_funcs;
> > +	struct amdgpu_gfx_ras	*ras;
> >  };
> >
> >  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs-
> > >get_gpu_clock_counter((adev))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index 1cf1f6331db1..190a4a4e9d7a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -862,6 +862,27 @@ static int=20
> > amdgpu_ras_enable_all_features(struct
> > amdgpu_device *adev,  }
> >  /* feature ctl end */
> >
> > +static struct amdgpu_ras_block_object*=20
> > +amdgpu_ras_get_ras_block(struct
> > amdgpu_device *adev,
> > +					enum amdgpu_ras_block block,
> > uint32_t sub_block_index) {
> > +	struct amdgpu_ras_block_object *obj, *tmp;
> > +
> > +	if (block >=3D AMDGPU_RAS_BLOCK__LAST) {
> > +		return NULL;
> > +	}
> >[Tao] The "{}" can be dropped since only one line under the if.
>     [Thomas] OK.
>=20
> > +
> > +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> > +		if( !obj->ops || !obj->ops->ras_block_match) {
> [Tao]  Need a space after "if" and the space before "!obj" can be removed=
.
>=20
> > +			dev_info(adev->dev, "%s don't config ops or
> > ras_block_match\n", obj->name);
> > +			continue;
> > +		}
> > +		if (!obj->ops->ras_block_match(obj, block, sub_block_index)) {
> > +			return obj;
> > +		}
> >[Tao] The "{}" can be removed.
>       [Thomas] OK.
>=20
> > +	}
> > +
> > +	return NULL;
> > +}
> >[Tao] This is a generic ras function, not gfx specific, the code can=20
> >be moved to
> patch #1.
>     [Thomas] OK.
> >
> >  void amdgpu_ras_mca_query_error_status(struct amdgpu_device *adev,
> >  				       struct ras_common_if *ras_block, @@ -
> > 892,6 +913,7 @@ void amdgpu_ras_mca_query_error_status(struct
> > amdgpu_device *adev,  int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  				  struct ras_query_if *info)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D NULL;
> >  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
> >  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
> >  	int i;
> > @@ -899,6 +921,8 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  	if (!obj)
> >  		return -EINVAL;
> >
> > +	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
> > +
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__UMC:
> >  		if (adev->umc.ras_funcs &&
> > @@ -919,13 +943,17 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,
> >  		}
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_count)
> > -			adev->gfx.ras_funcs->query_ras_error_count(adev,
> > &err_data);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > +				get_ras_block_str(&info->head));
> > +			return -EINVAL;
> > +		}
> >[Tao] Can we put the check behind "block_obj =3D amdgpu_ras_get_ras_bloc=
k"?
> The same suggestion to all similar code.
>        [Thomas] OK.
> > +
> > +		if (block_obj->ops->query_ras_error_count)
> > +			block_obj->ops->query_ras_error_count(adev,
> > &err_data);
> >
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_status)
> > -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> > +		if (block_obj->ops->query_ras_error_status)
> > +			block_obj->ops->query_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > @@ -1012,18 +1040,21 @@ int amdgpu_ras_query_error_status(struct
> > amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> > amdgpu_device *adev,
> >  		enum amdgpu_ras_block block)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D=20
> > +amdgpu_ras_get_ras_block(adev, block, 0);
> >  	if (!amdgpu_ras_is_supported(adev, block))
> >  		return -EINVAL;
> >
> >  	switch (block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->reset_ras_error_count)
> > -			adev->gfx.ras_funcs->reset_ras_error_count(adev);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > ras_block_str(block));
> > +			return -EINVAL;
> > +		}
> > +		if (block_obj->ops->reset_ras_error_count)
> > +			block_obj->ops->reset_ras_error_count(adev);
> >
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->reset_ras_error_status)
> > -			adev->gfx.ras_funcs->reset_ras_error_status(adev);
> > +		if (block_obj->ops->reset_ras_error_status)
> > +			block_obj->ops->reset_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > @@ -1088,7 +1119,8 @@ int amdgpu_ras_error_inject(struct=20
> > amdgpu_device *adev,
> >  		.address =3D info->address,
> >  		.value =3D info->value,
> >  	};
> > -	int ret =3D 0;
> > +	int ret =3D -EINVAL;
> > +	struct amdgpu_ras_block_object* block_obj =3D=20
> > +amdgpu_ras_get_ras_block(adev, info->head.block,
> > +info->head.sub_block_index);
> >
> >  	if (!obj)
> >  		return -EINVAL;
> > @@ -1102,11 +1134,12 @@ int amdgpu_ras_error_inject(struct=20
> > amdgpu_device *adev,
> >
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->ras_error_inject)
> > -			ret =3D adev->gfx.ras_funcs->ras_error_inject(adev, info);
> > -		else
> > -			ret =3D -EINVAL;
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > get_ras_block_str(&info->head));
> > +			return -EINVAL;
> > +		}
> > +		if (block_obj->ops->ras_error_inject)
> > +			ret =3D block_obj->ops->ras_error_inject(adev, info);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__UMC:
> >  	case AMDGPU_RAS_BLOCK__SDMA:
> > @@ -1727,15 +1760,20 @@ static void
> > amdgpu_ras_log_on_err_counter(struct
> > amdgpu_device *adev)  static void=20
> > amdgpu_ras_error_status_query(struct
> > amdgpu_device *adev,
> >  					  struct ras_query_if *info)
> >  {
> > +	struct amdgpu_ras_block_object* block_obj =3D=20
> > +amdgpu_ras_get_ras_block(adev, info->head.block,
> > +info->head.sub_block_index);
> >  	/*
> >  	 * Only two block need to query read/write
> >  	 * RspStatus at current state
> >  	 */
> >  	switch (info->head.block) {
> >  	case AMDGPU_RAS_BLOCK__GFX:
> > -		if (adev->gfx.ras_funcs &&
> > -		    adev->gfx.ras_funcs->query_ras_error_status)
> > -			adev->gfx.ras_funcs->query_ras_error_status(adev);
> > +		if (!block_obj || !block_obj->ops)	{
> > +			dev_info(adev->dev, "%s don't config ras function \n",
> > get_ras_block_str(&info->head));
> > +			return ;
> > +		}
> > +
> > +		if (block_obj->ops->query_ras_error_status)
> > +			block_obj->ops->query_ras_error_status(adev);
> >  		break;
> >  	case AMDGPU_RAS_BLOCK__MMHUB:
> >  		if (adev->mmhub.ras_funcs &&
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 08e91e7245df..2ffde223c4f5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -817,7 +817,7 @@ static int gfx_v9_0_get_cu_info(struct=20
> > amdgpu_device *adev,  static uint64_t=20
> > gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);  static=20
> > void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring); static=20
> > u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);=20
> > -static int gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> > *adev,
> > +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> > +*adev,
> >  					  void *ras_error_status);
> >  static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
> >  				     void *inject_if);
> > @@ -2118,6 +2118,18 @@ static void gfx_v9_0_select_me_pipe_q(struct=20
> > amdgpu_device *adev,
> >  	soc15_grbm_select(adev, me, pipe, q, vm);  }
> >
> > +static int gfx_v9_0_ras_block_match(struct amdgpu_ras_block_object*=20
> > +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> >[Tao] The return type can be changed to bool and return value is true=20
> >or false
> instead of -EINVAL and 0.
>        [Thomas] I think the return type is int maybe have more=20
> scalability for a unified ops interface.

>[Tao] You can use int for the convenience of scalability in the future. -E=
INVAL means error but it refers to no matched block here, is 0 =3D=3D "no b=
lock" and 1 =3D=3D "find block" is better?

      [Thomas] In the linux kernel , the function usually return 0 for succ=
ess,  return less than 0 for fail.  We better follow this rule.

>=20
> > +}
> >[Tao] It's better to implement a general ras block match function in=20
> >amdgpu_ras.c
>        [Thomas] The match method of mca block is different from other blo=
cks.
> Others blocks only use block to match, but mac block should use block=20
> and sub block index to match.
> 	          But I can add a default match function in the amdgpu_ras.c,=20
> if ip block does't define .ras_block_match function, it will use the=20
> default match function in amdgpu_ras.c.
> > +
> >  static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D {
> >          .get_gpu_clock_counter =3D &gfx_v9_0_get_gpu_clock_counter,
> >          .select_se_sh =3D &gfx_v9_0_select_se_sh, @@ -2127,12=20
> > +2139,21 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs =3D=
 {
> >          .select_me_pipe_q =3D &gfx_v9_0_select_me_pipe_q,  };
> >
> > -static const struct amdgpu_gfx_ras_funcs gfx_v9_0_ras_funcs =3D {
> > -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -	.ras_fini =3D amdgpu_gfx_ras_fini,
> > -	.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> > -	.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> > -	.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count,
> > +const struct amdgpu_ras_block_ops  gfx_v9_0_ras_ops =3D {
>=20
> >[Tao]  static const?
>     [Thomas] OK.
> > +		.ras_block_match =3D gfx_v9_0_ras_block_match,
> > +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +		.ras_fini =3D amdgpu_gfx_ras_fini,
> > +		.ras_error_inject =3D &gfx_v9_0_ras_error_inject,
> > +		.query_ras_error_count =3D &gfx_v9_0_query_ras_error_count,
> > +		.reset_ras_error_count =3D &gfx_v9_0_reset_ras_error_count, };
> > +
> > +static struct amdgpu_gfx_ras gfx_v9_0_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_0_ras_ops,
> > +	},
> >  };
> >
> >  static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev) @@
> > -2161,7
> > +2182,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device
> > +*adev)
> >  		DRM_INFO("fix gfx.config for vega12\n");
> >  		break;
> >  	case CHIP_VEGA20:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_0_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_0_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2187,7 +2208,7 @@ static int gfx_v9_0_gpu_early_init(struct=20
> > amdgpu_device
> > *adev)
> >  			gb_addr_config =3D RAVEN_GB_ADDR_CONFIG_GOLDEN;
> >  		break;
> >  	case CHIP_ARCTURUS:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_4_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_4_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2208,7 +2229,7 @@ static int gfx_v9_0_gpu_early_init(struct=20
> > amdgpu_device
> > *adev)
> >  		gb_addr_config |=3D 0x22010042;
> >  		break;
> >  	case CHIP_ALDEBARAN:
> > -		adev->gfx.ras_funcs =3D &gfx_v9_4_2_ras_funcs;
> > +		adev->gfx.ras =3D &gfx_v9_4_2_ras;
> >  		adev->gfx.config.max_hw_contexts =3D 8;
> >  		adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
> >  		adev->gfx.config.sc_prim_fifo_size_backend =3D 0x100; @@ -
> > 2227,6 +2248,14 @@ static int gfx_v9_0_gpu_early_init(struct=20
> > amdgpu_device
> > *adev)
> >  		break;
> >  	}
> >
> > +	if (adev->gfx.ras) {
> > +		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras-
> > >ras_block);
> > +		if (err) {
> > +			DRM_ERROR("Failed to register gfx ras block!\n");
> > +			return err;
> > +		}
> > +	}
> > +
> >  	adev->gfx.config.gb_addr_config =3D gb_addr_config;
> >
> >  	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << @@ -2448,9
> > +2477,9 @@ static int gfx_v9_0_sw_fini(void *handle)
> >  	int i;
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->ras_fini)
> > -		adev->gfx.ras_funcs->ras_fini(adev);
> > +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +	    adev->gfx.ras->ras_block.ops->ras_fini)
> > +		adev->gfx.ras->ras_block.ops->ras_fini(adev);
> >
> >  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> >  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> > @@ -4888,16 +4917,16 @@ static int gfx_v9_0_ecc_late_init(void *handle)
> >  	if (r)
> >  		return r;
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->ras_late_init) {
> > -		r =3D adev->gfx.ras_funcs->ras_late_init(adev);
> > +	if (adev->gfx.ras && adev->gfx.ras->ras_block.ops &&
> > +	    adev->gfx.ras->ras_block.ops->ras_late_init) {
> > +		r =3D adev->gfx.ras->ras_block.ops->ras_late_init(adev);
> >  		if (r)
> >  			return r;
> >  	}
> >
> > -	if (adev->gfx.ras_funcs &&
> > -	    adev->gfx.ras_funcs->enable_watchdog_timer)
> > -		adev->gfx.ras_funcs->enable_watchdog_timer(adev);
> > +	if (adev->gfx.ras &&
> > +	    adev->gfx.ras->enable_watchdog_timer)
> > +		adev->gfx.ras->enable_watchdog_timer(adev);
> >
> >  	return 0;
> >  }
> > @@ -6841,7 +6870,7 @@ static void
> > gfx_v9_0_reset_ras_error_count(struct
> > amdgpu_device *adev)
> >  	WREG32_SOC15(GC, 0, mmATC_L2_CACHE_4K_EDC_INDEX, 255);  }
> >
> > -static int gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> > *adev,
> > +static void gfx_v9_0_query_ras_error_count(struct amdgpu_device=20
> > +*adev,
> >  					  void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data=20
> > *)ras_error_status; @@ -6850,7 +6879,7 @@ static int=20
> > gfx_v9_0_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	uint32_t reg_value;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -6879,8 +6908,6 @@ static int=20
> > gfx_v9_0_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >
> >  	gfx_v9_0_query_utc_edc_status(adev, err_data);
> > -
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_0_emit_mem_sync(struct amdgpu_ring *ring) diff=20
> > --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > index b4789dfc2bb9..2d816addbd4d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> > @@ -863,7 +863,7 @@ static int gfx_v9_4_ras_error_count(struct=20
> > amdgpu_device *adev,
> >  	return 0;
> >  }
> >
> > -static int gfx_v9_4_query_ras_error_count(struct amdgpu_device=20
> > *adev,
> > +static void gfx_v9_4_query_ras_error_count(struct amdgpu_device=20
> > +*adev,
> >  					  void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data=20
> > *)ras_error_status; @@ -872,7 +872,7 @@ static int=20
> > gfx_v9_4_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	uint32_t reg_value;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -903,7 +903,6 @@ static int gfx_v9_4_query_ras_error_count(struct
> > amdgpu_device *adev,
> >
> >  	gfx_v9_4_query_utc_edc_status(adev, err_data);
> >
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_4_reset_ras_error_count(struct amdgpu_device
> > *adev) @@
> > -1029,11 +1028,31 @@ static void
> > gfx_v9_4_query_ras_error_status(struct
> > amdgpu_device *adev)
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >  }
> >
> > -const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs =3D {
> > -        .ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -        .ras_fini =3D amdgpu_gfx_ras_fini,
> > -        .ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> > -        .query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> > -        .reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> > -        .query_ras_error_status =3D &gfx_v9_4_query_ras_error_status,
> > +static int gfx_v9_4_ras_block_match(struct amdgpu_ras_block_object*=20
> > +block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +const struct amdgpu_ras_block_ops  gfx_v9_4_ras_ops =3D {
> > +	.ras_block_match =3D gfx_v9_4_ras_block_match,
> > +	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +	.ras_fini =3D amdgpu_gfx_ras_fini,
> > +	.ras_error_inject =3D &gfx_v9_4_ras_error_inject,
> > +	.query_ras_error_count =3D &gfx_v9_4_query_ras_error_count,
> > +	.reset_ras_error_count =3D &gfx_v9_4_reset_ras_error_count,
> > +	.query_ras_error_status =3D &gfx_v9_4_query_ras_error_status, };
> > +
> > +struct amdgpu_gfx_ras gfx_v9_4_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_4_ras_ops,
> > +	},
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > index bdd16b568021..ca520a767267 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
> > @@ -24,6 +24,6 @@
> >  #ifndef __GFX_V9_4_H__
> >  #define __GFX_V9_4_H__
> >
> > -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_ras_funcs;
> > +extern struct amdgpu_gfx_ras gfx_v9_4_ras;
> >
> >  #endif /* __GFX_V9_4_H__ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > index 54306fd45ff1..2744709fa09d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > @@ -1644,14 +1644,14 @@ static int
> > gfx_v9_4_2_query_utc_edc_count(struct
> > amdgpu_device *adev,
> >  	return 0;
> >  }
> >
> > -static int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device=20
> > *adev,
> > +static void gfx_v9_4_2_query_ras_error_count(struct amdgpu_device=20
> > +*adev,
> >  					    void *ras_error_status)
> >  {
> >  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_st=
atus;
> >  	uint32_t sec_count =3D 0, ded_count =3D 0;
> >
> >  	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> > -		return -EINVAL;
> > +		return;
> >
> >  	err_data->ue_count =3D 0;
> >  	err_data->ce_count =3D 0;
> > @@ -1664,7 +1664,6 @@ static int
> > gfx_v9_4_2_query_ras_error_count(struct
> > amdgpu_device *adev,
> >  	err_data->ce_count +=3D sec_count;
> >  	err_data->ue_count +=3D ded_count;
> >
> > -	return 0;
> >  }
> >
> >  static void gfx_v9_4_2_reset_utc_err_status(struct amdgpu_device
> > *adev) @@
> > -1934,13 +1933,34 @@ static void
> > gfx_v9_4_2_reset_sq_timeout_status(struct
> > amdgpu_device *adev)
> >  	mutex_unlock(&adev->grbm_idx_mutex);
> >  }
> >
> > -const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs =3D {
> > -	.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > -	.ras_fini =3D amdgpu_gfx_ras_fini,
> > -	.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> > -	.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> > -	.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> > -	.query_ras_error_status =3D &gfx_v9_4_2_query_ras_error_status,
> > -	.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> > +static int gfx_v9_4_2_ras_block_match(struct=20
> > +amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint3=
2_t sub_block_index) {
> > +	if(!block_obj)
> > +		return -EINVAL;
> > +
> > +	if(block_obj->block =3D=3D block) {
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +struct amdgpu_ras_block_ops  gfx_v9_4_2_ras_ops =3D{
> > +		.ras_block_match =3D gfx_v9_4_2_ras_block_match,
> > +		.ras_late_init =3D amdgpu_gfx_ras_late_init,
> > +		.ras_fini =3D amdgpu_gfx_ras_fini,
> > +		.ras_error_inject =3D &gfx_v9_4_2_ras_error_inject,
> > +		.query_ras_error_count =3D &gfx_v9_4_2_query_ras_error_count,
> > +		.reset_ras_error_count =3D &gfx_v9_4_2_reset_ras_error_count,
> > +		.query_ras_error_status =3D
> > &gfx_v9_4_2_query_ras_error_status,
> > +		.reset_ras_error_status =3D &gfx_v9_4_2_reset_ras_error_status,
> > +};
> > +
> > +struct amdgpu_gfx_ras gfx_v9_4_2_ras =3D {
> > +	.ras_block =3D {
> > +		.name =3D "gfx",
> > +		.block =3D AMDGPU_RAS_BLOCK__GFX,
> > +		.ops =3D &gfx_v9_4_2_ras_ops,
> > +	},
> >  	.enable_watchdog_timer =3D &gfx_v9_4_2_enable_watchdog_timer,
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > index 6db1f88509af..7584624b641c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> > @@ -31,6 +31,6 @@ void gfx_v9_4_2_init_golden_registers(struct
> > amdgpu_device *adev,  void=20
> > gfx_v9_4_2_set_power_brake_sequence(struct
> > amdgpu_device *adev);  int gfx_v9_4_2_do_edc_gpr_workarounds(struct
> > amdgpu_device *adev);
> >
> > -extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
> > +extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
> >
> >  #endif /* __GFX_V9_4_2_H__ */
> > --
> > 2.25.1
