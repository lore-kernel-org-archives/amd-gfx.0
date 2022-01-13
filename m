Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34D8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 03:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BB210E48E;
	Thu, 13 Jan 2022 03:20:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF47A10E48E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 03:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7I06M0Ba9/CAePtH88zUWvsdyOdICf915uCpTF68JwrwG6NPQSBLmdM3Lh82HSH124tmcF7y5pkoJaEwdpjFTJH/snXcbKT7BS5oxT2b0HNsSu7HkICl4KtScnAbOqIg6LvG0SCumPFK7E9K2TfOwS+nsy2mMppt6+K7hYXF5EaBVYEPCGTr23Yp/irYS6yWbe60KjaQSDhmTPI3oEcEAZ1WEd8uH/MhFqgNmWOchSug0RvVjkpAN4Y7BYYXtF/CQGyt7ugnpXAa3+xTTZkFurkhnccQMycqD0jmuVv60Am4z1kGoFKB1BqOB1omz3kuyi9/SLa8dcpupBCYcgS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irWBgSUwgZHX1cVPmnyKnUFe4BfFn48ZwoFp0QTvXDQ=;
 b=P3hB75KWmYJco2e6LBYsJHTBz3vi+/lBioSLkHn9F2q0RKyKXWBUo8xt8X7M7drmvSzKcmQVBKHN5HNl2pdMZFTZV+kpEl1snzVyo3bsFhAMIJPjN+Yvy1cTL5WrkYbketxMgCfgos4YegyPNTQjifuNLb1FeVWPU394ThSTM4nCaD5FBoiXT/NDYL14+PV/xbGco7EkB9vWIsfYX6iqpK0fq5wYcXB3rKdzpwPGV/pKToFGOKa4evvZOdNjuIAYzMzS+Y3aFAoybVMqXls5NGYmDOHx2WKrZxH25kH8IWeuPH78GPfKC03L3ZzWi3VMrQOXDg0PU6j2Nxg08+IDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irWBgSUwgZHX1cVPmnyKnUFe4BfFn48ZwoFp0QTvXDQ=;
 b=xynxS6XEHEaBDlFq9KyNDxJSnFPXkPInhMDknR7cHI/vMhi4mMoc0Hjgab8eCP1/8zSuwAR8HziHLGSHO/vB5CD/P6s7E5bgL0zGMJUcjCGLSxP+vfhtgmIkPntO9xZjtyc3eDD43WIg7l9JdX9O8dBHvSaVJA6060u5eexzLkw=
Received: from CY4PR12MB1767.namprd12.prod.outlook.com (2603:10b6:903:121::9)
 by CY4PR12MB1847.namprd12.prod.outlook.com (2603:10b6:903:11c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 03:20:16 +0000
Received: from CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::1909:ffc6:461a:5727]) by CY4PR12MB1767.namprd12.prod.outlook.com
 ([fe80::1909:ffc6:461a:5727%9]) with mapi id 15.20.4867.012; Thu, 13 Jan 2022
 03:20:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/2] drm/amdgpu: Add ras supported check for
 register_ras_block
Thread-Topic: [PATCH V2 1/2] drm/amdgpu: Add ras supported check for
 register_ras_block
Thread-Index: AQHYB6CmrZcVYWqcv0apU7xE4xUg9axgSVNw
Date: Thu, 13 Jan 2022 03:20:16 +0000
Message-ID: <CY4PR12MB1767B01625773D702A124400B0539@CY4PR12MB1767.namprd12.prod.outlook.com>
References: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220112103832.2910237-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T03:18:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=15930266-bf10-4f2d-8e2e-6d57e6aca53c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-13T03:20:13Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 19c882da-f7c7-4c43-a160-752e7668edcb
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a60667c-9975-4c9a-779d-08d9d6439edd
x-ms-traffictypediagnostic: CY4PR12MB1847:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1847EE877447E2A38A9395C5B0539@CY4PR12MB1847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOb7eWq2pzCYifdATLaS71Df1gCtUIrvH7dALkci+t2Zj4yovOlDqQSUTWy07Kkd2XQKDL/mfRO6SwpCEREjFMSq5WZu3Ou8DtsdNk2qHzaX7ozJiKEq5JSUtNY448Nnhjbp9rIaJQ6l8GTv5i1zIb5Eujd//zxM6wV7/y9rmv041Fzwc97cj8XMxRx6Z6ygBIBU1rd9wUorY6O8hMm8k4efncORNIUtz4KFYuARerAL+FRJIWkPb8UFvgz8xML0Hy2DnNxjUPaxmfAif7rphCrdxcSUIIr2UUUmHjsGuApCdEhjNdJFXJdz4cKjfYiF/Cg5Ct2BEaQACdT7YBKQPVLNwlN41Do7cvF1NHQ9J9hIEFopHVUDM8MZQlFRfWwdr82Qr7JtQQDBKLta2h3ieWMz4g3PZmYLWWZGbLEdNpwS2cakzkw2PeH68Kvt7ww+xbKVM/r1tV3uNX8vsqSgI/uRR0Yo6HX8eB0D597Tih9/uZgnK37HQUCH5YUaGUw+W8N2KYCsMEnV4N2EEx+0WbE79HeLlThtA1aTzAFQ0hC2pLe1I0KQDevtCFnATGAweKI0V0oIodLINbVKxejSBvnJDQR0Y1TSdw7TIaRiX3MbhxkMUHzkchfd3aDVi0fk3uMW/A0uwJcg0FPETzv21XV3yxdOXF8DdtPIQJ6DyNFfP65/36i5DwB4Zq7olH7EQGvLBnhSpvoIbBXL0l/KCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(86362001)(110136005)(54906003)(55016003)(66476007)(66446008)(508600001)(9686003)(66556008)(52536014)(83380400001)(4326008)(122000001)(186003)(5660300002)(71200400001)(64756008)(53546011)(2906002)(6506007)(66946007)(33656002)(8936002)(26005)(76116006)(316002)(7696005)(38100700002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xPyvZgU2vItEZIJk/9X7ISUQ4UUhP2NUEpF+u8qcEkmvk1jFxROEMKm6kwRg?=
 =?us-ascii?Q?urAJkCT+Q8GnEAh3g0MjRgzwNPLnR2njjazw/u29dbgprXuz+xOdOG5bOBmF?=
 =?us-ascii?Q?IH6v6oQ9FNnYwge4MhrhQ+FqkNBIW7mcXwgI5jKQoUBSHJ3LekWH4EKtx9K4?=
 =?us-ascii?Q?XsFiPuSlbpIrRJ2U5mm5bmRUSrbGncMS4A/Vvb1A2CXjnNN680HRx+Fl1cKv?=
 =?us-ascii?Q?cyl8LS7i3/D9c+Gznx1gXoPYLtNKW0j9IM92Zh60/WfBR5O/CHCLmmHQL1E0?=
 =?us-ascii?Q?8OcSGcGUXbTijc0E3/puvOwN/xgi0ikbsBs4PSb1YKAB7go/4uwKpzcSYK5n?=
 =?us-ascii?Q?nrNV9vtlALylUyJFUYTYxV9T+pgSjYQRxvz/vDVibacpRGxu6WmmSd7bx9uO?=
 =?us-ascii?Q?nKDj+RynDNE8EO/ukx34jKamFwemENHXiVX4CB3VvrUnH03OlTyqkGz0h96Z?=
 =?us-ascii?Q?rWFdCO9jQRcnAkCM9V4+x93Pn0a6jAeptcVsPQTSmfqwfAVhWZQ3P7syMz/p?=
 =?us-ascii?Q?104g+vvFV3D27aiwLR9NKyWeL59KbiP8wmtUu6JVDaHjQaa0A4Nqli8TUxwU?=
 =?us-ascii?Q?rmpKnMZ12h5LL/ioBLP6Mr4JcSZTuGSijnKl0RHhPLaSutEYecOsFsRQOAto?=
 =?us-ascii?Q?4evD2/FRBpK+2RMfP/QhGDQLyMgwpgQPVXEcayc3gg0IwbpB+c5kiAahIEO2?=
 =?us-ascii?Q?fc4gEHpBmPuaTPKMRcLkeTKE1hD+T6LBOyCBj+BHNN9fthAnMM7rlPlbX8e6?=
 =?us-ascii?Q?LdrgfynFYR5CvHtbB5ei6wcm9ulnTDKU/n91gSBMv8PJ8lsRMdWupczzB98w?=
 =?us-ascii?Q?4pJDH4NXSvX4FV9Dp43GApQj5+k6ymKSc0b3ASR1Z70pO5hNE4RLkduyouDS?=
 =?us-ascii?Q?oKQtiPVKeLgXdMM6G/TTyhzLAK21xoTvIY325JhYJmVJLriWh/IFsna8iyTM?=
 =?us-ascii?Q?p9NaG/aF8c5ghZaBXxgzMFB0DVvc+y+ZQTbKhOMvcPYbpQKhArZ5dvtiyXWP?=
 =?us-ascii?Q?n7ci6km64oqGhhb8+kjMowOuDngk/skPrfWoke4ccYNgw61inWd6kGExkfSe?=
 =?us-ascii?Q?qvlIFgPJ/XG337kTFFdiIbGtLhx3A8jtNuxtQ+k+VldEahX6NS7q3/vCEiHR?=
 =?us-ascii?Q?nJgCRoeLCLu4gGKk0BualXNXSlXzI6mDDNygPgmqYE2g0AU0BLabMDddeS9t?=
 =?us-ascii?Q?N417yP/ESHcKSaFizF+cfXb2rTM+oZvQqQowl4d5STPn9H8CwOO0Yc1U58Qq?=
 =?us-ascii?Q?a4QDyr94QW84OpiopgCIzJH9ROwKcCtvWv6F0aRBd3daEZmowZZ1iiWCrChs?=
 =?us-ascii?Q?WFzOZlFZ3gwJaifCebhv9C523CmDfyNdpjNH4OD/q6UDEpomkz8c1qMVuHNc?=
 =?us-ascii?Q?UIe3BXRQLU2r3jbydgQeVr4jykezXgOF8r9rpi63TTLCXnOid0KRa5ge4cqE?=
 =?us-ascii?Q?yihDflBZGTsMR9PlkZYRk4vA2NzcMI5MEjjY2/RhMcp2CA9AdUhFNwDZm45x?=
 =?us-ascii?Q?Ap9Osj59XZMsUT8Fh/2Ekq3KmqQQoQOKNcS0UVGljGm2LMZ3SjT6ESGY2loX?=
 =?us-ascii?Q?6Qnn4EW+OKtAaJScb98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a60667c-9975-4c9a-779d-08d9d6439edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 03:20:16.4853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/sJMmp30nHzSgbQ/JQU8DwLBDmd5NMoSsO7Qlrv7klH9tiLs6KvGfyIhRz2aY8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 12, 2022 6:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 1/2] drm/amdgpu: Add ras supported check for
> register_ras_block
>=20
> Add ras supported check for register_ras_block.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b1bedfd4febc..614ae8455c9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2757,6 +2757,9 @@ int amdgpu_ras_register_ras_block(struct
> amdgpu_device *adev,
>  	if (!adev || !ras_block_obj)
>  		return -EINVAL;
>=20
> +	if (!amdgpu_ras_asic_supported(adev))
> +		return 0;
> +
>  	INIT_LIST_HEAD(&ras_block_obj->node);
>  	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>=20
> --
> 2.25.1
