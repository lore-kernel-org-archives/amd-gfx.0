Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F16CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 14:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913C28902A;
	Fri, 26 Sep 2025 14:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="21ypGRLI";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7DA8902A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 14:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fG7ypCwlk3x3e9VoTkH5QmX1ZJw5bG1vGnXY5ftBgW9ZWXIqTGbCjSdWgvirO31Ykhs0I4lvgPk5TuxBMY4v+2oxemgdFyK0zac/nPl2iKJ3CVWdcXHdBVsZoGMW8NJMUSTeSg9jMIVJZrJqdnsqGTwt8NiaGZNttoh47f/DINdK5rykTi9zzp4+pX0rUdU9LgLnJ5BWJsyWOK4AKhbnhJDwDhJbXLnohqrYHAzK8CHdiPqtucoNtNM/tiX5O+aPwtixAD3ZJ6Ai2BqdvVvnD0VAOZDsZ+ypeV7z7bXtTL7y8oqBCzvF5KKcNDRF0xQ1pyaGn2HU6TTy+3XKN44vGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx0LYDuJZPFJubB4+jHnH8KnWiGBE1KIqZBaQty5JmY=;
 b=xoCEFoZzBqj2pRlDn96NB84UtI9sC26y+sRgwT8VNRhhMFR1S+EUXal6AzuHjglRe1go1d+RrDC9EJ2DzSkGeyHaU8u24M18XQafz3iXOF/NJoT26FaGZ/PHktsKkeYVrbgfOwejMtBwjuBotVuYWCtN95VCgcIIr5W0+4R2SPP9YVV3mnXED/M/PdFNSJ8Kx6KiDOBzwto9jrha+fUfzJ2XA2F24ATVune9cr7aH2jjJ/LMBwwDjqp2t7drxAXR2Mcwp1fDALOFxLtyaPKbNTPxYqdSoqVd+GDoBpBGgAWqBM+ntfsDEBv2vrymxOu/ESDJ5mPTJXQVAB3XSjMKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx0LYDuJZPFJubB4+jHnH8KnWiGBE1KIqZBaQty5JmY=;
 b=21ypGRLIn6b6byjM6fhhZ2yKc1Ly+OoOj6sFtPlJg1ZSVJ/8jb5du8yOvCNMwqz7BQvlyeRJed2oLZRKC+GEfTlo+KHVruh5KfCOZjrva9iA77L1UvayHuSLsyKKZauCJ/jRd1QLw8/Vtng2V0XlbYygI1ibO7Ojpju+2CcyQ+g=
Received: from DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) by
 PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:29:40 +0000
Received: from DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::9456:1ddf:948:5d1d]) by DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::9456:1ddf:948:5d1d%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:29:40 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs
Thread-Index: AQHcLb3yVRpHXYBoB0CvNyYQlyukZrSliAcf
Date: Fri, 26 Sep 2025 14:29:39 +0000
Message-ID: <DM4PR12MB6279684DD538ECA0CB87E6CC941EA@DM4PR12MB6279.namprd12.prod.outlook.com>
References: <20250925014352.338578-1-shaoyun.liu@amd.com>
In-Reply-To: <20250925014352.338578-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-26T14:29:39.351Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6279:EE_|PH0PR12MB5606:EE_
x-ms-office365-filtering-correlation-id: ac4209f1-d100-4150-3502-08ddfd092092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700021|3613699012;
x-microsoft-antispam-message-info: =?us-ascii?Q?P6G7WZNUYxf6DnB1sxD6cBAqQREo4QDI24MdyRILmsOrJA/uAHxRrzgOytmM?=
 =?us-ascii?Q?2zI12aDWEvtRjQv+AYem/yx9VCv0mxGIPITHsc8JbO5HIi/C4n3dOh32Yoxs?=
 =?us-ascii?Q?ZpFW+3ehYPTKrxPlVTK7Ftw+HCx37D+QGaa7LQoCPjijy2uHqWlINSKa/DWS?=
 =?us-ascii?Q?73KWFdQy+rv/W63NB6L2U41jPUPTl8YMSTT+siIzTgdMKN+2SiX05Slg4QTd?=
 =?us-ascii?Q?zSp6rsFFxvjVHQdYTgSlkTt5643zl6NbJAhCMLsNwpZemPLR/ixYCmoGrQkn?=
 =?us-ascii?Q?mGPr/EwC2aLBGmEIer04dG8qn8M9gkwUr7Sxeirkw8bLOQ5O8pIz5IdS15UL?=
 =?us-ascii?Q?ZX+0TybseRHXCGVK4yRwK1+S4IbvUUmKtowPW1HHegbuVj537Mj9bjw7Lvk5?=
 =?us-ascii?Q?tbl7Bm/6f0U9Actn5KZQ77BBHp+JkAeqg+x+5jtRAdHPu7q8VxwuRbG8AkTl?=
 =?us-ascii?Q?1KKB/TYqksmpCQaxcWBgmfi5SfqzERb4s71hHqOnNRbmqbkcFzcNHdPhTbwr?=
 =?us-ascii?Q?eXsvj9TyyCG7iH8y6sRACglu7uzFsDDmO8ujFGFRXWQcYyhje89IXxQA25js?=
 =?us-ascii?Q?f1zxQzDXY9Njs/xJ0VyvFcrAfyEqYcImLB9v+UDpH6Ajs5c1TDheHwVKsjSp?=
 =?us-ascii?Q?+QkhvoFBPp3g5tetfQTH5j51UGuVT+nV9BxbeVg3pAPNVKO+FYD41Jndt1A2?=
 =?us-ascii?Q?4ks7HXM/+4lkec8lroY2RDMWSE8UECtLNHUydkYSraK+yiDX9ggsprlMWSvd?=
 =?us-ascii?Q?LYuRWaf+bVwPyUIkoh+S6RfXdJjS2WV3+0DeTr8hiPFfmFv7646B4D5ZFLun?=
 =?us-ascii?Q?rClZJaYV4SLCO6i0CHP5gulXSwu+R1hXC5RA0u6/sDD86vzPeXcB+yxXlw9C?=
 =?us-ascii?Q?TXsIBB1OEvt3Cq37R++Mvxt0PQQf9d1o40yclvTbGQIWdAMoFmA+lwKiPz4s?=
 =?us-ascii?Q?UIe9kPqEBU5lQwu+PDajeb9TpdD2gb56f15g//j7hjJONzk5IR174HmMqLHv?=
 =?us-ascii?Q?rraygHeWopcuS2R1bzeCUtJH7Fhej0vKa5j9Ch8pIyzjCO4ESVmwdI4Qv0cO?=
 =?us-ascii?Q?5aqtvXOR5HFks89M/q7/7HNb8Nw3CdpCx2iTiPTBxikTtuqMpolQum4+L+8C?=
 =?us-ascii?Q?umlmVn3GOb3IHrdqb4CX30LukVDo2E0HiFEQQXGCegLTaqneaI9CVSbKuI5U?=
 =?us-ascii?Q?lluGXgvh7Su38BMcunrqltdHAHTU1LDAKrrN1qMMxh/42hHAAYp33fpeFifn?=
 =?us-ascii?Q?+So8lkgCKQuNdSOYR76/YtlyG+sEoA02b28jivhTMwCV/BVATTWII60KfmO6?=
 =?us-ascii?Q?oQggtV5pucaW56LUft/YgPW3tmHz07QYco0uZm6gDjhvKPtxQ1X755oP6ftq?=
 =?us-ascii?Q?p/CruYT2vUBAVLDl7XDtngOI4LTURfvmqWWMk8P9fWIYyNzNpCYTLEpeuEzy?=
 =?us-ascii?Q?sEyQnSnrQUtmy8cKlQPvw1N/WBWZCMzh9XZ1b73jsZs2vcxImngOS5FXWzGW?=
 =?us-ascii?Q?ny2n2yE/G4DRIDPASSe8m5z4PSG22v3AQJQlW913KcdKI5H9gOIsYUOecLr0?=
 =?us-ascii?Q?rDhylB1aw3khDzPuWO0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700021)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vWNiyw25oWiMVDo1jQ78KJ3XE5lJRSUMuzbfJPYkL1yc0E4Sb5jpbJKA3gy?=
 =?us-ascii?Q?lwdlrwm+30uPJAYghncywsOvwgl20jcAFsam4Io/ol446gFwD+mwk8KfL8+7?=
 =?us-ascii?Q?nFFennD//MbmEhHU/5+Bpuq1xwvFhKc3pr5JMpfcb5muW2lZGUilPtZOI18g?=
 =?us-ascii?Q?0CHbpESsSlCDC36U7Ztu6udV1ufqvqR3zQXVHRTpMKIc2NeWwqqnGCNLYLCN?=
 =?us-ascii?Q?1GimyJOqzg77+hFl+j9n68GA/rLLq1pvtspjr9NujywYx47hWLbWR1PvLqT7?=
 =?us-ascii?Q?6Io5I437oqjzntZ3s/VjVU9qbxeomaqK8v0HrxHT1NWINOH5ihrMiEog7TtT?=
 =?us-ascii?Q?URpXtrRDCipEhVjpFNlAGqIhy9vzZuFvw1LsI7E8DPWkJ8j6mqMrFXjREoFO?=
 =?us-ascii?Q?PFr1ryW85p7N3GlYgyTiKViyZw88bJBhWBV8G75QRcAbF6Z8GneJZzYWxmRO?=
 =?us-ascii?Q?G8bJuvE4iKobmMIicyc530tt7Hnx7Q4rSFEXJJ3a3E/mCvglzZhVRyjUceqc?=
 =?us-ascii?Q?7mrT+q6rw/dCrjwq9SjrEMBi3SdAfc44P7Pg5g7F4Vxmwf70yzE0JPZhYpRT?=
 =?us-ascii?Q?XtkKWZwAXrfahSFk+QUGayBxI39fyztuOac9qQdDIi/kXm5OLl5LOjHc6yO1?=
 =?us-ascii?Q?Yo6u06tosXiQLGHJKLkkPYQ+amX5cEQMHY9NRTilt2X/g5bJGKlPjZM+nFmf?=
 =?us-ascii?Q?VqqmTseXSAgMa7J5yRCMZgUbC0ALvDJJl4kf3xuaZVa/5YXfAWQgAhzj/KXX?=
 =?us-ascii?Q?n6CZ2FFNTAEoQp2ZJnB5rS3Z+WfcEinfI1J/hq34K1+ETdNWusP9wJtsz44B?=
 =?us-ascii?Q?TW/cnGZMZj26r5/+tKyccM9HcttaLVKwBznEuaFBfs4B+hLDXuhEba+F3sYX?=
 =?us-ascii?Q?p/DEgvca6TfeT5zYA2nd5QmvU4RAe6tiVlLdIpJODd8MudrLzIRpewIFOUvg?=
 =?us-ascii?Q?14G3lsHv+jKl1FbHa8zk1RJ8idP1TmcCpflTruw2quMStH9Peyiwe7qoGpIr?=
 =?us-ascii?Q?S4J2YIA86gmYPPlLJ1mgpIvEJA08mVAUPCBpynHgIYDLiFFLaKh4+74LfO81?=
 =?us-ascii?Q?KPFgzGlJXGwal2l/zkKyRPrfJjedGFQS5+LP0RPxE1z7aofYn/1IGg/fUE6F?=
 =?us-ascii?Q?KM2YHqaL+EB1ESJ29KDpciAZUd50EBpJPCQvqfxLvs6cmjTXSbn/yUSiPQQi?=
 =?us-ascii?Q?R82QWcLW2VZ0l+TjHGlKFD4aa1Gdx6+PAKe5uC3+nGkOboufn1knMxttvbv4?=
 =?us-ascii?Q?I4uqut0Xpq7wxOP+Md+FAz9UQA+Y6wryzytNZGNgK5Jcci6mSCFKWXrK+TpW?=
 =?us-ascii?Q?VIuivcoAnRnwl3AFfT93C5KY3Jrc1oHGOtsSBC0wsRNKT00EGcJTvZuVOBKS?=
 =?us-ascii?Q?RJ8i3UVa1vHlMEMHteT2GUjFXilQPiq8O79B4pygfbWrE26qinKBtWw2zsxl?=
 =?us-ascii?Q?WXGTi+6gZMexcTpb2FD2fyEzeDKOms9t+75QKVeWd+Epf0G7B7Fo4KrCz1+B?=
 =?us-ascii?Q?iKxgAtNdYdcqY2ClPQPhZuPvmuWsL1z1+Z6T+xWwzAa/SnUjCvdqN+UKsM/l?=
 =?us-ascii?Q?PB4zTYNObrjcWKe5hwI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB6279684DD538ECA0CB87E6CC941EADM4PR12MB6279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4209f1-d100-4150-3502-08ddfd092092
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 14:29:39.8968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ8u3t9UMaPcbvf7E6yF1tXDRhzF2tGeGfKUs0h+RbR/JJARGRoBUPEuKOlpXKL8P22EXkJB3IQhEOemR1RoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
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

--_000_DM4PR12MB6279684DD538ECA0CB87E6CC941EADM4PR12MB6279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Shaoyun =
Liu <shaoyun.liu@amd.com>
Sent: Wednesday, September 24, 2025 9:43 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix the mes version that support inv_tlbs

MES version 0x83 is not stable to use the inv_tlbs API. Defer it to 0x84 ve=
rtsion.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 404cc8c2ff2c..f4a19357ccbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
         int vmid, i;

         if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].=
sched.ready &&
-           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x83) =
{
+           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x84) =
{
                 struct mes_inv_tlbs_pasid_input input =3D {0};
                 input.pasid =3D pasid;
                 input.flush_type =3D flush_type;
--
2.34.1


--_000_DM4PR12MB6279684DD538ECA0CB87E6CC941EADM4PR12MB6279namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"text-align: left; margin-left: 5pt; font-family: Calibri; fon=
t-size: 10pt; color: rgb(0, 0, 255);" class=3D"elementToProof">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Shaoyun Liu &lt;shaoyun.liu@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, September 24, 2025 9:43 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Fix the mes version that support in=
v_tlbs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MES version 0x83 is not stable to use the inv_tlbs=
 API. Defer it to 0x84 vertsion.<br>
<br>
Signed-off-by: Shaoyun Liu &lt;shaoyun.liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c<br>
index 404cc8c2ff2c..f4a19357ccbc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c<br>
@@ -337,7 +337,7 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vmid, i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_uni_me=
s &amp;&amp; adev-&gt;mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &amp;&amp=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;mes=
.sched_version &amp; AMDGPU_MES_VERSION_MASK) &gt;=3D 0x83) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;mes=
.sched_version &amp; AMDGPU_MES_VERSION_MASK) &gt;=3D 0x84) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct mes_inv_tlbs_pasid_input input =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; input.pasid =3D pasid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; input.flush_type =3D flush_type;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM4PR12MB6279684DD538ECA0CB87E6CC941EADM4PR12MB6279namp_--
