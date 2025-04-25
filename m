Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6752BC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 20:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58E810E013;
	Fri, 25 Apr 2025 20:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQRAMWGk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FE310E013
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 20:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLZESmZU0B43ipBri4TTVircS6dHbX9cEqBk+sLsIqrurRDnzd4iDm3PKlFvCGHpL59XqfENxkCCQfzIylNVQjsdS/EM44o01f5gxNncQ/EbOYy7HsjVdUXS/8iBIIUTWhkuJXlvdW8WHoPGS7I24By0jHl6S1f++XQRliGWqZ4GR3V1aJf+SbFdLuRCDLS1ckkZXT+beudB3tQH70sc60tb4/wKiQ4blRxu+uTyTEFCKP8N+zLIe5Fz4rSkG1Oa6esgUOTpULaURS36zJ5VdyPULEowCfRTblc5hMfi5o44z7MgT9reYnRwmq6vg76P+ppsE28SqT24zBM9w70sCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Wa8uqkF0r+AKU+AW2d49zKgAZthNLJFI347wTyoz9Y=;
 b=FI7n1RwylZrEWIrNpkK36G3rH6x9PJvIQ2oN64I9efnC8TifSHFu+Vz28d5c9yh3SoVCu8KKylQXk3MeBzsRPo00idn5TSQRDXwCvFQI5afSzmmakXmjk1I4N0IX34CQqn/C8cwAkYgNJdi8oeGBvHmsHYrtPoqyrXLscIdKTWgG6NxWv45Yt3lUm0SLgay9nvxYXHYpZe8juHQDVL5M8lv7aMO3l69hsUwyf16gGC+Aqmd1EsVtzTW/2p422XnXp28HMgSvaBX86ic3XEggDdYxkiWFP6hRRWvICGAxKn5whgkJUC2q2/YKREqOdYaMAvl9VGPuYAWcHm1ums/xuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wa8uqkF0r+AKU+AW2d49zKgAZthNLJFI347wTyoz9Y=;
 b=dQRAMWGk6bDiZ3C58F1dUK8Ht8i6FKQxF2ZFQqDv/YYBccgV+Ix6qGAgSjzt2i+bcjOIMDxUwCM030yP5BcNhuuq6IxtVnemsZIcKI+UoYs0GYS9xDAdygGdErrs9BKL21ltLZtekT82kg+6lFLFCSlkK2zYV84pQRtYaXzByP8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 20:22:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 20:22:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Gadre, Mangesh" <Mangesh.Gadre@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
Thread-Topic: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status
Thread-Index: AQHbtbHHP90CnwptR0K0bKnrhppNmLO01Adc
Date: Fri, 25 Apr 2025 20:22:17 +0000
Message-ID: <BL1PR12MB5144B7D9A1586AB203B89523F7842@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250425071447.922183-1-lijo.lazar@amd.com>
In-Reply-To: <20250425071447.922183-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-25T20:22:17.249Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8160:EE_
x-ms-office365-filtering-correlation-id: 544970d2-d94b-404b-a2f2-08dd8436dff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KSoJTX401wOYakTwFM85N4J22vnDG780wFrhnYmjcZamcUCvKboupif+X+8j?=
 =?us-ascii?Q?WzAm3J/aPghX+wFtcNVZS7cuxqITMRe16HY5Zyc4P80y29FDGXoviMhSaTLt?=
 =?us-ascii?Q?LdAUw287YsvtHfwq3UcJ8Zh7ZWAM0NBcF+12CgXSgr2Cl8XGGI/Wiuh6VUuc?=
 =?us-ascii?Q?yYFCXSbp4h0POj3fHSN2lMBimHESEWElgMZidExPxwLpjM6u/K7/PhT/qVBz?=
 =?us-ascii?Q?M0Q0MIDs3ETD11RZC0QHlrd/z9FdhxNFrq4EkGapXEgmiDEqGsDj9rrN2Wgi?=
 =?us-ascii?Q?qPmISPwPufwtFv7fjL1gr561wOljq59zB+fldkicMxZsnB/wcRprnzhDmfdB?=
 =?us-ascii?Q?NVg9pk77kmAQAFcHf6GxbPeDMmoohYWd8WeCYrGC0Z3ES+s59fwHUGewnwSp?=
 =?us-ascii?Q?EHLchirfmh9071+68g1RTXnYEuSMkwfkYB45qiMyOglQLhrBodBLHn36PCzG?=
 =?us-ascii?Q?vvPv7EbuWddotoRDVha4C59k9nmwhPHIj8R7LfFjYZP/z2ZcwWRxQwZUVcaj?=
 =?us-ascii?Q?g/h+BsXcamcrpek6MaOSnUpBCHEV4jzokiaXMaTyRRQ+Syhn165LpLH3C+T5?=
 =?us-ascii?Q?rQK2xHlGFQ29aDvq8iZyMMKcaZJDf1gB8iuwjf7RYdMtuIGbgEPvkMkGTAxY?=
 =?us-ascii?Q?ET/Iel5YGxHG2t4qBOsDTV+SXesLLlBy8vcMYKoA8rvuAWRpKXIecfrKsd0E?=
 =?us-ascii?Q?gA7AVXAGL7/XvMLIDwJSjbMGhLxxQzC3bNQBr/40y/v96/n9HWvxiXFIihUj?=
 =?us-ascii?Q?ld+UN/NPquZ8ESPQPUfRf/A2nFtsev3CCmPcke2Zqro4ewaj1VAp8wJBiPSa?=
 =?us-ascii?Q?t9APkET8AThyF0c2+TO3weURYjmIi2II0xEI1Jc/KS9BZMGjkiyL3bu9kSQs?=
 =?us-ascii?Q?KH8UBUKEUaTjmIPVim8NtHFdY00Snrzr0thHuhNXfazHZPT6VdN9fgPHn+g8?=
 =?us-ascii?Q?XEwXt7ENg/ttanLV/e5Z37GQbv5lOHJelprr5k7itsf8xXn4ZvUiCEEXi1Eu?=
 =?us-ascii?Q?578OF8zkyZ4s+oKr1J8hb7cWHmx42v6XEf7An6TUiFRv9lIkhlOtXtU71U67?=
 =?us-ascii?Q?DbjcwH2FM/Nx3fdeCWnzF/mxu/2BWnz4mCch5NKd7Vg9TnQZitUYmbIdBVT3?=
 =?us-ascii?Q?+1GsBsILUm9AdrRynIdmXKvTHo/3kr2G5w5gj5owd/kuGE1UUgRQBR3aQ/Zt?=
 =?us-ascii?Q?ng4SvQ9/IfEFYGxAJE4xCYFP4VRuSG1MJjan2gdFIAWb3NBRE/PLBR7L1TCI?=
 =?us-ascii?Q?HsC8GgUD7xQNnUqOKkF05Kzx0iBy4XBARy3Yu4vPmqriM105PNDc00/m4GDz?=
 =?us-ascii?Q?KcMR8Uh0sZ0vSank6W4omXS1jUXtLFPieNJTB9lesIG+JnWj1gwIQokI32Vk?=
 =?us-ascii?Q?f/WvsIoByZV66Cl8K1mXCDU09i1wetK8cEM9lptofZ4KjTtZ78nM+6oo3omE?=
 =?us-ascii?Q?hSoxVaki/C2IO2ZFP41DKlDJ4BEMzuyWcYAweF5i2ebF9x5UMeVR2O135Qxs?=
 =?us-ascii?Q?+OZ7FP5fLitjr3g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TP0NvBlWVPLiXLADNd+04/1FPiRhPBs2GFrWRfbmhDZR16e1xXgrs0yP9Uji?=
 =?us-ascii?Q?szcl9whKT9wYKdRGfqH95cQLysBmzOdQzbIs1Nbs3l/Z2hsvtjVwJiMIpHLj?=
 =?us-ascii?Q?j5nQjts6IR1Znqlhdywhh9A+A12WONcg3uFHl0yA9sC9aScdN9Tnal6k0oNf?=
 =?us-ascii?Q?nFcRacUYc0pSyJagbufoihwl21QyGCNwCEBUebBlk3ekV7JZrqZJuVP5MWRQ?=
 =?us-ascii?Q?oZ0HpLWUepv3wwySa5BKxCc2RNiuFU1uV0fVaRVLqiOQNjk3y5zCtCNF3LAc?=
 =?us-ascii?Q?qxHV0DWfFta8JUBf4N+M4+vjdbwKwvRQXDnrsNawAqaaW+yuUcbM3iAbcXpV?=
 =?us-ascii?Q?d5xeUQIF+BI1tHRHp8my1ladat+2tA8yVltoYYiE+gx3yot3YS4qmSCeUQ9a?=
 =?us-ascii?Q?nIw7kyDMTUV36smJD6YhGgXVpu+UeK8pYBV/BHPo5KHVh4p/XvQik6EYAXVD?=
 =?us-ascii?Q?+qztyjoapHMGxcXbZxEbUqrWOEFeUWLZqJmN5iyl83zz2PXX9LqfdGLlV4K1?=
 =?us-ascii?Q?PmW8wevYJhli1DY/ZQylvCXQSjlokXy9oLr//q2ZLxdPTQ3pKStcL4qkdH2b?=
 =?us-ascii?Q?a3g/jjw5LVc5Ms1Si5lhmSb3xw96hP1CmZhlwV68hPLuI1saYeOvoI6y4Q8y?=
 =?us-ascii?Q?nHmJ1nUiTEx3ImLyjTGPBBiAmb8Qh5DnarvftLpHjxhVeSUrRDs9hsGHoH3c?=
 =?us-ascii?Q?+QpbRJFGLzNsL2j7FsL2qtm8wMQgCdNPGswMw36X7bTkfKkabJnDSvvDNM51?=
 =?us-ascii?Q?uYyLJI7mOtcq/DMh1oCjI8DWANYom+RJtxc0KZivDzFkweTWAkT+2WnoibIJ?=
 =?us-ascii?Q?Jjgg+zVpUW58xxe7dsCdUeJ3xQtfLnqladUZ2LEWG+cpd/mVr7H5XeMfRyqD?=
 =?us-ascii?Q?/l0MIeG6AI1InE7Lo+haeRlDQsJt1HG0a+za0PVvS2dfuNeKmTcDCFRL5ik+?=
 =?us-ascii?Q?B9OGwXVaZ3+oB6pAJgL3wkwmN4OLFrxsssvgoKkFYY/na51YtFx2ZhD+bGCo?=
 =?us-ascii?Q?SwNzYZi1FmQgOFWIWfnNFXM2VIkLCCje/Qgp6g/BBBEKq+ubZAyQ6tTiVfjb?=
 =?us-ascii?Q?Usku346tqeJuBR9cIvXSI3ppmGO3wz0lDF2XnTRrWbF0VxD0ZJllz7OWS5Rb?=
 =?us-ascii?Q?93lVbLFqNtZXTfStgr/61jYQSf6rdYjzCxyeGuKMrEMAutZA3FzjLlH7wEcQ?=
 =?us-ascii?Q?oHh5UQKpQyF+7otpXxsmn/AfDHxdonqyTmYmbxY6nWhdvGALEmJYLn8K3df6?=
 =?us-ascii?Q?3oqyryfl4IJEMYETvwwAsx6CAHMuQJgb4eC0ue6dAuNLgS75Mxpy71DnS4Rd?=
 =?us-ascii?Q?ALSPs/scu1dMMnak8V3AypHu1yQ8+XE8+0OlU1d1zaoYm5LDEukVQZ3Ptqci?=
 =?us-ascii?Q?RB+C6jLqtdQS/Ys+yJXFMf1W10XbawiYC8ClIV0ouiieIzPYbuU5tzpYqaz/?=
 =?us-ascii?Q?4ZrmK3/oIUz0oTLR13Mf0zG4ge3b9pphm21j+Nik9U8ZL8aVz0fOv6XWCRLf?=
 =?us-ascii?Q?DkX8faaIBpMgKTb0alVIXKRyJKiY+HQZF/nKAF+mju9vTJ8QIhrRNk90k8Zo?=
 =?us-ascii?Q?LCBUyFt1LA24jNY4Z1Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B7D9A1586AB203B89523F7842BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544970d2-d94b-404b-a2f2-08dd8436dff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 20:22:17.6676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZsnBwgisDILl9WiU/v3+vgrD2AT+X7ZEMFSEo/zXU0tbBSIUiLveO9QqHlHTpVx7f0ImED2/nwpPgT7dtsSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

--_000_BL1PR12MB5144B7D9A1586AB203B89523F7842BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, April 25, 2025 3:14 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre, Mangesh <Mangesh.=
Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status

Keep the register offsets as per link order for querying XGMI v6.4.1
link status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 0666515023cea ("drm/amdgpu: Fix xgmi v6.4.1 link status reporting")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 95231de26cb1..f51ef4cf16e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -297,8 +297,8 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_r=
as_fields[] =3D {
 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int globa=
l_link_num)
 {
         const u32 smn_xgmi_6_4_pcs_state_hist1[2] =3D { 0x11a00070, 0x11b0=
0070 };
-       const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] =3D { 0x11b00070,
-                                                       0x12100070 };
+       const u32 smn_xgmi_6_4_1_pcs_state_hist1[2] =3D { 0x12100070,
+                                                       0x11b00070 };
         u32 i, n;
         u64 addr;

--
2.25.1


--_000_BL1PR12MB5144B7D9A1586AB203B89523F7842BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, April 25, 2025 3:14 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Gadre, Mangesh &lt;Mangesh.Gadre@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix query order of XGMI v6.4.1 status</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Keep the register offsets as per link order for qu=
erying XGMI v6.4.1<br>
link status.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
<br>
Fixes: 0666515023cea (&quot;drm/amdgpu: Fix xgmi v6.4.1 link status reporti=
ng&quot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 95231de26cb1..f51ef4cf16e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -297,8 +297,8 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_r=
as_fields[] =3D {<br>
&nbsp;static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int =
global_link_num)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 smn_xgmi_6_4_pcs=
_state_hist1[2] =3D { 0x11a00070, 0x11b00070 };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 smn_xgmi_6_4_1_pcs_state_hi=
st1[2] =3D { 0x11b00070,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x12100070 };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 smn_xgmi_6_4_1_pcs_state_hi=
st1[2] =3D { 0x12100070,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x11b00070 };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i, n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 addr;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B7D9A1586AB203B89523F7842BL1PR12MB5144namp_--
