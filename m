Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F79C5320E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 06:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B7410E4CA;
	Tue, 20 Aug 2024 06:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WfDypmB0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A06E10E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB4msTyj10biSgDrc0dP6c2ky78e+QXtEN0q2ujLhwTl8otRtEreN2Z181uMuqPmsuqYuqsi25PixneaD04JM2pOKPQDPT25CewZu6ArDv1qrWYGlasEc5I2r2yNMRpgR52XNlyPqkqT5e3cVt+8mUZUwbgPie84JbWndsZfh1PZwV4gnW36UhygIE2mM18k4b18jWagIXJmyn8Z1OSOIr7TU7iJyk8JJHA/WE8jiVZUAsYlYnF2wxxgwtx6igYx4B0NnB2lj/gZpT3D0oeThUVOijXEDyzQtjiDkNWnvAG0OTP0b6uGP5l3w8vaXJGasumehyoLFjt9Rz3/1jNzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbDbJH6cusSask3Xb+12wZbuSqKaYg83PJfqX8+v0r8=;
 b=XX6gQmMFiTYaT0quxINZHHjpRLIiv0aTQVJL1EWYN8SQci0yyLSOa5AbDCyRyeARwBSHRNvgf1ynU33+Zp19ZkSZbKqg+Wj2VlJjtaB6Vy6jQKFirR/YdJItjYCPchk9CHN48wLB/UCKjBEPJPxjkvFaOxcZbufhogKfvfEKCAEpKQdNLn/cs6Ugm0jPpChWsS5h/ON56fYx4t6pKWC+ZvdU98MsM8g38++G7JSQvTGB63Tv4CdVRZc8pqYHtD9VeKGJsN3mB9TqijSmEHRihKDyKko1n/soEE8WV9mhYCAEwsnQ+ptmnW//XqfJ2WcZYM1IagrX9gL8W02FjDo3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbDbJH6cusSask3Xb+12wZbuSqKaYg83PJfqX8+v0r8=;
 b=WfDypmB0YJJtQ4HOay4zRc+WBEI/MyVsj5PcmWI3NAQeAFGlsGWE325PxdHxymAmyiyBfivEoGqPYiUPu3m61Phyi9ZUNr5WrVy//vXykWIFkKCWQXOoX+QyZSP7A3tRpxZL4YVhFp9YmoWAGTG5/wDF1wy1ZnKcS8Ua5pBBt+Q=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:39:41 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 06:39:41 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Do not support swSMU if SMU IP is disabled
Thread-Topic: [PATCH] drm/amd/pm: Do not support swSMU if SMU IP is disabled
Thread-Index: AQHa8sqImggUKXpNwUi49tNKucQg8bIvscmg
Date: Tue, 20 Aug 2024 06:39:41 +0000
Message-ID: <PH7PR12MB5997A21F13496F21CB4E81E0828D2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240820063041.6786-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240820063041.6786-1-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=aa9ac2e4-7b77-41ea-bb06-9c24ee83a3c6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T06:39:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6494:EE_
x-ms-office365-filtering-correlation-id: c9bea8dd-d6f7-45e4-717c-08dcc0e2deeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BHy1VznNcLZH1E0a8V+Wp7zxE1cz3OLjbfaq4wAQi66mEiCVyzth3PjAq+b5?=
 =?us-ascii?Q?ZSXFGVbABGXZ9jYQOP39SwEyfuCGFf/Sw5YgieX8pRoiFyeHYtYTKXCETnc7?=
 =?us-ascii?Q?XCY6ttuc7nyipTt/VfXk3J/nCEG1gx74+dcuoq0dE9Ut2P/RCI0iU9UHy/jM?=
 =?us-ascii?Q?ZIksUT667OFdHWt3O9WyjUo/zfYuSdZ1BBRywt+ULoHeigIZY7DswHaZ5rxk?=
 =?us-ascii?Q?2L74BlIiBRyjlOthHVwG1Su27b8DA8MRJAeCOE7taCerFACr/UNZMBrj5SrA?=
 =?us-ascii?Q?DHhc4k9Pqdv6zlKqDOK+vhXWei+2Di2QRTtXq9g+vxwvbS0llXQfslHB6ezk?=
 =?us-ascii?Q?HudGqoZzyLIDxmo4ngdQ0T1/HspaVnZLBGt6b7u8k7K2A9PHTbgsXr1xw194?=
 =?us-ascii?Q?xu/sQ4/rPmQpotZW0MCy0ZvfQ159O4jIgNERHoa0HKJXopNfOLU8SjThoHhH?=
 =?us-ascii?Q?nLQg4luBRg0p+tDPpraj0O363dSCaS61phq4HKqBUgb9ioVn35bF8L2em/YH?=
 =?us-ascii?Q?/N+8KQHi5KFvAZpPXt9KJmgK5NNEgsa/ia2AjcezK5E7vsHseyAWTwoY4qkL?=
 =?us-ascii?Q?6KCqkZ+5b1wJkRX3k8LenTnqcd0rnxEQ57EC7JcHY1xV5+i6AUjBSJKn51Kj?=
 =?us-ascii?Q?9GiAqCPUZ6+nLjHxX8CLPfy0cwz5ZNZHFgZaXWdR58/tDos5DPD1KYvu8ggh?=
 =?us-ascii?Q?PUoBUsrYLDT6Iavmiodmvyv4SnSvm0pLvQbf9B0sVazNM6UzJd5/RCIldNTX?=
 =?us-ascii?Q?uaCJi3KOkoEmteZXFtsT+n8yUzI/MiJQl6/rfn/f/8bNW1pyl1PFIOBqqWz+?=
 =?us-ascii?Q?v2ijBF2SapIILMu7Ax0ILWGhPXzYYmyhkhf4PJgrNj8pyAV7bW3vOVprQrbU?=
 =?us-ascii?Q?bsa5FUFLKov7PPlajgkoFLlZeE23z85fwqU+o+eS1H0IGVGIdM9SyDUhB+Ur?=
 =?us-ascii?Q?3ha9HrOTecNa4fbAMXmDl1CoSsSjXWRDpRJSTDbj5gWPaASvEeatCELvCXtD?=
 =?us-ascii?Q?Yh+Qd8SR4MRHHOcLh6zxsR8aepgJ9hNtWGIp4R1hHSG2Uitp55Kq1cv4Yl7r?=
 =?us-ascii?Q?kKvPt35lI2K2gcRWVi7DPnx8htB9qoPLSDQe+pwho4ICCZaER6UEtO1GmUCb?=
 =?us-ascii?Q?OuQl+HvnlqBQC9EP0dGAxl8ctkyq8C5S2Ra7dJ0EdAADo2BQpdP23oeVo4sp?=
 =?us-ascii?Q?2Qbn0meoy7w8PuJvJoEfZUCKZDwIY+0cmeyQl/bFTZMqgBKkiBhI1MxK1qHE?=
 =?us-ascii?Q?07cBDfxuhMYnOVQvFZjDwKHJjIxVt1pvRBVt/r0gpc9s222oMMEwNutCehmt?=
 =?us-ascii?Q?stQ15FEX7iIL/afgQepIPwNa4T3Dk2o3n5q4rYm3uz1pP8ID0hP2SVLB184j?=
 =?us-ascii?Q?zZdQQjljQWch3ZnkTOL3ty8wPPn1Nynvq2hM/Fnb7lSmK8mTVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aAp1OP9dm7MXFCjGe/YMf7IRIrpt8OZYc10OqCfyHXpyzzJ6l9rlwYyZ1vRG?=
 =?us-ascii?Q?uR2yRkCXYcX7b5IWRZWrT0VKRpOJdPMuGZTExl+jgsXfzwJaZMT7KMiTIbP4?=
 =?us-ascii?Q?uUpJWJwOE0RbxXCeyT2LJZbs8ZTYOaokDu/sUm5ssCqEbRaWe2q82WfjFwNs?=
 =?us-ascii?Q?AoN0dMANrdonhxHA5rtUiCz9kyZA3sCOksDk60rnriB87gPdNOmW4DS3AVJK?=
 =?us-ascii?Q?WAyRy4YncjZAHx8IyIkMsmwhgc+AT4mxwWBk2YSjrEK7+1X4iEA7f8fxMdEO?=
 =?us-ascii?Q?2xjn4rrKrfLw8jG6+lNaOnZ3zZhdfHQuh9LIMtgCC5wagovm5WCcWjtZ9GXw?=
 =?us-ascii?Q?WAKyrU+1ZBh/5PKFP+DfVBT+XeYm+MdZA0nXQTguXgEOhfWmdSe4QHC+o95a?=
 =?us-ascii?Q?EBH78qKYw4RWyGCRSTcI4772Sk0gh8CQ7Z0zf/WPq6094FPufGY/uT3bi4l5?=
 =?us-ascii?Q?IkTOuJvX2/7oVPGxwo0dDk3oxv0i7zVS5XWwt+5lrXYp33VuJO/s3DAi/ejJ?=
 =?us-ascii?Q?1c7FmVodY2VdIwWZFJxMvOKLk6xwq3lE3Rc8pXMTkkWyhoyjINtfjMEhNW6y?=
 =?us-ascii?Q?SI8/WyZ349sa06bmdIbQzMwEAKwl+u6H3GqEtGZTD/AIEpy10zcx/T+bR+yY?=
 =?us-ascii?Q?YATa8YfOOlGlgCYsbsbG9swd6fZLGJIilfSNWU1ucZjtM3SdYvTon/FPfxXD?=
 =?us-ascii?Q?wkP6yNTgfZrilnuHXKgZZWK/1bN+JJ4qfhuFXVw+WwlUY0UXF8WfZVBMh3aB?=
 =?us-ascii?Q?Fm017bq6F+TCxDcS+BcqNPBIJn1eywC3w5hfRll0hpB/3QXJHo9QF1GJ3mVd?=
 =?us-ascii?Q?akBCLGUHDibdVIvdjtRu27910CefbROywJz4yHM6Qd+LW462B5EyItjDqPVj?=
 =?us-ascii?Q?7mpVG6Q/fgBk64I1EaigiqmfGxy7PNuVsSRMgn8mHi8mkDqfouW/r1is/UXF?=
 =?us-ascii?Q?nCdcwcVk/RWu2IlstP+GGqaBFZnTsvjsmGLCbj3su1b5c16HYC2ppRZzaxn6?=
 =?us-ascii?Q?Y7HqPEkYYRQUTh09WOJp1qKy3682oTFhXUteExJKDg796zKRQnPkMjDywDo6?=
 =?us-ascii?Q?MgCbWEaMbygybIojlkaloH/l0fkie3AIig7o8sQVvgrYoKPl0qihQ3o9Dpco?=
 =?us-ascii?Q?fxlD9tiLGOB9XVa2cD0h/QAcUVr7qa8QBXspYd6UibfmVN2Uc4VkVDNIUxKe?=
 =?us-ascii?Q?rMbI1e+e0++AAOkf8XO7n8zxeMmOxLIl7dJ8tAGG7QJsX8R+3YHx1W8RNb30?=
 =?us-ascii?Q?g5gWwV117fI8N1OhCvoHQOwBH/CZHqjC9iqbzONPJpcZ6tUXCoYUTLvcPc54?=
 =?us-ascii?Q?hSCUxe1ckTZUck8HHhOugWp63DoIVFLdxvJLQi3Yx6jTg4kmelY3crYTwvSv?=
 =?us-ascii?Q?LDtMAEUeDVvxelegDxPHLL2h/X1ExIwIbDf3sCwrkRYIcupYjKs/bYI9s8k+?=
 =?us-ascii?Q?rzlrp0Hx1T3t2YJxcbB5fXqhuTd/h6yb+QUlfkLXsYHXV4l4FN/klK/RUPAQ?=
 =?us-ascii?Q?fcysRe69kAS9/kd9d2yFEp0OhfOBb2/3e18Z07lTBTSH86dQK9hhr9pBIqdr?=
 =?us-ascii?Q?NU36EYRlIwCBm7n5i28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bea8dd-d6f7-45e4-717c-08dcc0e2deeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 06:39:41.3714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSsiIPf+UYdXW1FcqR7XvG63F5iwAGa5itZIbKA5NCUYElqVCmTGmKIVzut90gZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, August 20, 2024 2:31 PM
To: amd-gfx@lists.freedesktop.org; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Do not support swSMU if SMU IP is disabled

When SMU IP is disabled by ip_block_mask, driver should not refer to any dp=
m/swSMU callback. Instead, any driver call into swSMU/dpm callback needs to=
 return error code EOPNOTSUPP.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index c803c903e47f..31943b4db276 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -549,7 +549,8 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
        if (adev->asic_type =3D=3D CHIP_VEGA20)
                return false;

-       if (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0, 0))
+       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
) &&
+           amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
                return true;

        return false;
--
2.17.1

