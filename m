Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 06:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D24010E504;
	Fri, 25 Feb 2022 06:38:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C0510E504
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 06:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTzyuBk9/H5o9T4VI9wnOiQMBVHuCq1fybQYysDKI8o1cZqQpmP4r5DAQHNNJj5JUz/NhrlDayf4zszD0+nzBiXGmOqpThKsQkK/UJ1G1R6yWylZR5R4LYTCQJFX0QYgIg0TGGO95o/WsRz/0YzyEUqE2kTDNfzhPGCtYHeu6OxPCcytspFDw+TX/nX1mHYuI4o/pFPl7MDVAqklnjv2PtDrWFA6tpA7iojDhbR4WsHxW5Ov3O6fyresz2GKi/YQond3U83QwFmwqKxCbHkWJPlJPXhzQ+v9+GiUwovKF8yR/D7/YTzUMJAsMDbnMa5sgPcnrBewgQfcctUmgOVWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGBAjazrFUatvHJPx4Cni8l0i375xHnsJ7UPgZk89VM=;
 b=n1YUtuW0yNEE4Y+ox2m/2+sI4zM2qn1AptyJW6DCItXOYeUqnwIR1kuWlNYfourZXHPRznwHy00ePCse8usfLknW1HN/MyVsDCvzDR5dYWYunq2b7aPisnp1JSRQPAarL1HkRERGegCT9Mmy54qsMr3CfMUT6uJ76PFTJ4A47ky/VfX+1DpX2Z2VpO70WTTP0SF31S1uSi0NJzWSM33+GDX9pHmsA7Dy/598MP7o9FKp9xquWbbbKIwrEKJGPWyLIdYZAyiGAS8w4yV1yOydaFEs5uhHTJhV+SdogEvgZtQkG9kLinsapLHM0GehDZsYC8WJe+UeO77Sf2tJswyjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGBAjazrFUatvHJPx4Cni8l0i375xHnsJ7UPgZk89VM=;
 b=PwQytvo0pVAnOa7nz4d7ZdnO/aTpLbpijH2it9rXqN6tQSvJ6Y6WNj1ztwjZuflVwRnZKK9PrDW2+epSR+wMP79wrtANl5g7w0vbEdgXpnvTQmCV+0qxKn/x0VCdIxJAHQHx/6U70yl9uv3N3BCVsqlF9GuRuWlxadjqP6ftX4s=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 06:37:58 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 06:37:58 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 03/12] drm/amdgpu: centrally calls the .ras_fini function
 of all ras blocks
Thread-Topic: [PATCH 03/12] drm/amdgpu: centrally calls the .ras_fini function
 of all ras blocks
Thread-Index: AQHYJwwq/IupgIgZY0+SuLqIMqm8PKyj1Y0w
Date: Fri, 25 Feb 2022 06:37:58 +0000
Message-ID: <DM5PR12MB1770DA2EB97B8C3572791AA2B03E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
 <20220221101620.3269611-3-YiPeng.Chai@amd.com>
In-Reply-To: <20220221101620.3269611-3-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T06:37:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0b0803b4-8ebc-480b-8c07-254e1e4b9052;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T06:37:54Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 21ceb4fc-9bcf-4657-b266-7cca59e9c44b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e5ec938-fddc-4b67-3afb-08d9f8295cd3
x-ms-traffictypediagnostic: LV2PR12MB5823:EE_
x-microsoft-antispam-prvs: <LV2PR12MB58233FC9437322B01AC750F6B03E9@LV2PR12MB5823.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfuevW9bfdFE61mMWqfw2YNvPHhSQqGMARPEaZu7bOJcmOB5C+tp5UAvcmDqI9BUZas51iVYDsIcCK59KuLsOjOysmQbPPuhmhz6TVK/4K3CPLNq1UMP4oxUlfXn9br11I/7SVbcBmEOfw+E4dZuNPxZ8H/AcpGVFyWVtqYocwISfRMBUd9RwQRwG2snm3Ll4YjJXEtXQsv95UZG8i+oJ119aoneCRK0xrxN7ijOTCaaTTVNWqs+4Q4QriHvCMcMBOqIdP5p8ew21iWJKSo/BPEUCxVxu+wt8uu9CJUu2T1dEXxS2LRttTm8J2tb6aAJXa9Ml8w8cesUNp+2Zm3eXkfH/FaUE2py7WL9Ig9+ENHUosNtU4azPJRQ/iCjl236/kEGOapJjCYiSHdciMoR4M6AvMmecNyQ/H6uggGlQcqE8S6Ow8Z80DAO8GxL9McmsNa3mRzqA97azCqX9JQugqmHkFQ8oEPLf1rwKSkwBQOxYFsOKlh9mXyxqu2CBAtdhU1ezryfTW9gOSS40xTl5oK8gyfEfW1ufcCk5nJQ0JR+lYMHi/n4UrodiIKb5XMlNoRIFdeNNKGEwqZPIwPwSUWNPwsj5KJ89JOw5du/JVO2crwcwgeipqq9Tim7JS2nyg8SUVRhCVZMBj2FDKv6FocmPpOisbjDIlSnWMIC1Xf9AsG4uGS0pkISTgDh1qUU6sAr6dmfqpBQw682i+CZTz5IvRgTZ/vEFKnB+Sbhjpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(122000001)(4326008)(38100700002)(66476007)(66446008)(66556008)(186003)(26005)(76116006)(2906002)(83380400001)(8676002)(66946007)(64756008)(52536014)(5660300002)(55016003)(33656002)(9686003)(6506007)(7696005)(86362001)(316002)(110136005)(54906003)(71200400001)(508600001)(53546011)(38070700005)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfxAXLEBVK2SNyLBV+sDLe7TY/FzodVF5EsLEJZnDHTPjSMde3MiNjof4yUG?=
 =?us-ascii?Q?PTGDLQLQU39L8jb/riBhbu5tH64FlaPVwi1ITKBoLKCV88ULDM/wlK2BbTXX?=
 =?us-ascii?Q?Q8FSIWariD/1BIS+pd6KHhJ8vcKZoGjDXzS85jdNOy1G/R4jHea3K8tPbiOJ?=
 =?us-ascii?Q?rUrJW1kqB8II53PQqBf64hOTtZzbkecrMZzN+6ssAp0e/XyuMRtLw8I2SxK5?=
 =?us-ascii?Q?eo0HGXsiAHCJ84uDbUSZSVaWjzxwuBm1XqsBA7vI8Bq8V1bbmv2PYPWb2+7C?=
 =?us-ascii?Q?2xQoEOMtb+nZ/GWmM5p3h6wYALOo4f/a28oZOnZW5cVD/LblD9Zi65EZjU0S?=
 =?us-ascii?Q?l4L5G2HCzb/Fsbv1QnIQuRjYLjQke54/yIbMIk9kk83hx1W09L+o24CReAWT?=
 =?us-ascii?Q?KpddE/CzglCRBRxeOoTylsTNm8BfCHpJ+672af8aWvRvZYqHp7XHPO6KJGTH?=
 =?us-ascii?Q?Ln1lr47f40vztsyQgHSrh2k+6H4rCWquqX5CRyPjzcXgHl9OpHEsc5D56vLf?=
 =?us-ascii?Q?M09CcYQY4DTK5LkiuZdddn2UAhWIrrYqp5nTOvjMo99+wC1liUfM+Q1Uf+FA?=
 =?us-ascii?Q?vy6QtLR7zU+o4jou8bN/dbZpppKJ1Pd0Vf5GevAGZmyHKkeQt5kuhRalp0MR?=
 =?us-ascii?Q?1r2eq0zfB10fmXjVZYxwGXPV/8owhcP6o5RBXjLGZWKRgH0rUtKqsU6MrWPj?=
 =?us-ascii?Q?DJ0xsvXNbprjs+HfY//3+UxqSBfAqqb5r2aMx/6GWC5gHlYwHPGUsTI3wAmE?=
 =?us-ascii?Q?aNeYesYelqegTqqQlOHsMJIr2nUl4oZ9oQhZ+SEyojaHuY4DP91ahB16UrWJ?=
 =?us-ascii?Q?fWhy0Cu8VByfA/CDkTNuyAXEPwbBT5WrBqcad6MF7wu/KhHRnrdZG0QlCjT9?=
 =?us-ascii?Q?Bs4o6rX7zSr6FRuTqpKlEeUWe1JxpkCetknfhQfcCx/1uxuvJ+BC27gyx96C?=
 =?us-ascii?Q?/Xcr9ZX+aB7pi+Q/RM2O03jg1vTgUV7a1kk7WQKMhEZKrt43z2XcNvvP11ib?=
 =?us-ascii?Q?TGoreRkptGZPfGJ/++XXbPMIaewmmHnVvWj6kkpnx7abWlH8S8eBDL+ZsHwI?=
 =?us-ascii?Q?y80Xmcoe6YWnRu/gahStR/PlE0juB55Ndh4g0NfjRB8bMCO0CvIiWGpz91Sg?=
 =?us-ascii?Q?Rl6cwzcMpqkhF6X0e3hNogqDng3ZFwWWX6lzP+0jsxtxiulFFCbkqd3+6pfO?=
 =?us-ascii?Q?cmH1pzQZ4ELPw4+1JfH6yuWwPjc0EdkCbIVoV8Y8Ba+DJJAdk/VjZGM9CMvZ?=
 =?us-ascii?Q?5lECaWhUm2GxlJ2XD3e2LTBFzDZCzvmSXseWKH/F3WhQ701SzONg6kwhWsUo?=
 =?us-ascii?Q?eEhhg8BHnBmM0wl8spxkSuzv8pe1ktM/RICDwlJn9VEaI9iGKt0dGSvHFGFs?=
 =?us-ascii?Q?wH8u2sLT+PrVsyPHho1QyjAmBM1hiLCgl351yYLR9bHj6lN5LX2ns/Y1wpAA?=
 =?us-ascii?Q?i2PowfZe2ilvz1UK68diZtCfV31+WvBnPni2MWWIwFvYhXdy1ulFMnqWqebQ?=
 =?us-ascii?Q?Oh768SJDK9klTxZ3GzABykxS2f22ExE76GikBt8W55zqvfXAcqFnO5NcqPh9?=
 =?us-ascii?Q?M7+DKY0ZP0U8jZHK8dc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ec938-fddc-4b67-3afb-08d9f8295cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 06:37:58.2924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvJ486ilJ7RV8v0kTlYNCDqzHJ9eeo1rcxptZU7QZUuFoxwY4Q3Yy16T6zd/3Hd5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, February 21, 2022 6:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 03/12] drm/amdgpu: centrally calls the .ras_fini function=
 of all
> ras blocks
>=20
> centrally calls the .ras_fini function of all ras blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ----------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c  |  4 ----
>  drivers/gpu/drm/amd/amdgpu/soc15.c      |  3 ---
>  5 files changed, 16 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4823c42e0e02..ab75e189bc0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -454,17 +454,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device
> *adev)
>=20
>  void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)  {
> -	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
> -		adev->umc.ras->ras_block.ras_fini(adev, adev->umc.ras_if);
>=20
> -	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
> -		adev->mmhub.ras->ras_block.ras_fini(adev, adev-
> >mmhub.ras_if);
> -
> -	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
> -		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, adev-
> >gmc.xgmi.ras_if);
> -
> -	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
> -		adev->hdp.ras->ras_block.ras_fini(adev, adev->hdp.ras_if);
>  }
>=20
>  	/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e5874df3c9ca..846f51b0c013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2572,11 +2572,27 @@ int amdgpu_ras_pre_fini(struct amdgpu_device
> *adev)  int amdgpu_ras_fini(struct amdgpu_device *adev)  {
>  	struct amdgpu_ras_block_list *ras_node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
>  	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>=20
>  	if (!adev->ras_enabled || !con)
>  		return 0;
>=20
> +
[Tao] the empty line can be deleted.

> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> +
[Tao] the empty line is unnecessary.

> +		if (ras_node->ras_obj) {
> +			obj =3D ras_node->ras_obj;
> +			if (amdgpu_ras_is_supported(adev, obj-
> >ras_comm.block) &&
> +				obj->ras_fini)
[Tao] the Tab can be replaced with 4 spaces. Same suggestion to other simil=
ar codes.

> +				obj->ras_fini(adev, &obj->ras_comm);
> +		}
> +
> +		/* Clear ras blocks from ras_list and free ras block list node */
> +		list_del(&ras_node->node);
> +		kfree(ras_node);
> +	}
> +
>  	amdgpu_ras_fs_fini(adev);
>  	amdgpu_ras_interrupt_remove_all(adev);
>=20
> @@ -2590,12 +2606,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  	amdgpu_ras_set_context(adev, NULL);
>  	kfree(con);
>=20
> -	/* Clear ras blocks from ras_list and free ras block list node */
> -	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> -		list_del(&ras_node->node);
> -		kfree(ras_node);
> -	}
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e8446967a4d4..dc6e6fe6c978 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2432,9 +2432,6 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
> -		adev->gfx.ras->ras_block.ras_fini(adev, adev->gfx.ras_if);
> -
>  	for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>  	for (i =3D 0; i < adev->gfx.num_compute_rings; i++) diff --git
> a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 222d25a0413a..d1d40bbb2892 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1995,10 +1995,6 @@ static int sdma_v4_0_sw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>  	int i;
>=20
> -	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
> -		adev->sdma.ras->ras_block.ras_fini)
> -		adev->sdma.ras->ras_block.ras_fini(adev, adev->sdma.ras_if);
> -
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>  		if (adev->sdma.has_page_queue)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 0631ebd39db1..496c4a6e23ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1214,9 +1214,6 @@ static int soc15_common_sw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
> -		adev->nbio.ras->ras_block.ras_fini(adev, adev->nbio.ras_if);
> -
>  	if (adev->df.funcs &&
>  	    adev->df.funcs->sw_fini)
>  		adev->df.funcs->sw_fini(adev);
> --
> 2.25.1
