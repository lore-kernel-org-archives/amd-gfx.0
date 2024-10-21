Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D3D17130
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 20:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06FB10E58F;
	Mon, 21 Oct 2024 20:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYuNsFpK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2389D10E58F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 20:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFgI8cRNQb4T8DMEze9Wd+PjM4N5szjkCQQ/lEksIDURIUrqx/zRWaTo52j29Hu+ySgZJ8iz+2hSLen5b+TnC2Vw+wH2+lPr58p3zaaJ+TRiuD2/rxRrqvR6eZH4dan5TNFibLu3dnrCTDJp9g4132QcVHll8WM+15BFGPrxBXtZgjxCdJorv8WALBy65dZdCbpXVUEi6/HroSmPNEsX/uVH4Tm/JM72BBD1WwSpS7r3QMB1wXpXHnQ/EJAehKA2hWfwoTuMBGrqS/xSrN7kIHgduHsS6PGi3prHwuhdC/G+zZdqyZRuGfARUvJ+0LB2dUq8uQjSgNsX6xy5JUXAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeArvf9kH9DN+Dz6kPiJ710dFb+IgEmE52pUIOyOCyU=;
 b=FVcYD1Sx7v3Pt/025YWmfw4zTInjgVZgr32LKViHLGmJ61adVkZNlfr/gEN5NUrzixUN6QJ+KLquVpJ1OZFOypuv3NVrcxZ6FYqAQTT/2QUOlfNxOAGG3RMQ8BFkfvFlaK3yZ1WT4HTiihT7gxnYxmeeMWvzOizeKQIud8rry8svqWYry5LQS3r86EUrB5VpwL0Q0FT3WnmRNbjbaTIRG2HnVTUdktR4MdpjGKbYqvOJq89UepcDWCWTZxZqbX5yc5uaFMsiU7X62e3pElzpfq4Gi07dnyieFpUXU4wgRf2eJxwkKvYKNuTNTG/3+Mkc/pBc6Hc4iOHvNrzJIHfNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeArvf9kH9DN+Dz6kPiJ710dFb+IgEmE52pUIOyOCyU=;
 b=gYuNsFpKrQ/31Mx96IGCeVz1ms/D6tCOhXignlt1mOZ/PJh/jZIa29oWHUo+Abf2KyqlEMfh5zQncGprfNZQt42Cb1yXNUMuCPFvx72mBPenCmSoSDjP6rJVWrR7FRI2gZU4ZKb28RPqHtoun1QJlxqxYT8iZOJJtrKKUpzxlK4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 20:35:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 20:35:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
Thread-Topic: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1
Thread-Index: AQHbIZLXIQROmM7U2EKUrAXHvWwZyrKRrkGA
Date: Mon, 21 Oct 2024 20:35:05 +0000
Message-ID: <BL1PR12MB514479BC04F9CE88390562A9F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241018192027.622300-1-alexander.deucher@amd.com>
In-Reply-To: <20241018192027.622300-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-21T20:35:05.019Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6234:EE_
x-ms-office365-filtering-correlation-id: 8e0f5345-e78a-482e-c971-08dcf20fd8d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AzKJ8XDzc7I9vxyt1EFmN+m3cDHmod4/kZXGU6s12rYeqyyrdCIn1oNFvneH?=
 =?us-ascii?Q?gKA/sIeuC+JAl9CP2nwFjbsUYP9BfGqWKxAeZtDCqlY4YUQEEx/9sVqpjO6J?=
 =?us-ascii?Q?kOVmg4X9CgSkwJYzWFiMLAddaBiqBXT57NqYSPZEg1D0Dafyx17Jb3o8PpAz?=
 =?us-ascii?Q?oaEzQqptyuaaw/otVCUKwcjpg7nQyhRkPbmFF+jj4K12zPdmDP5PP1zlgsiw?=
 =?us-ascii?Q?bACxf3aiezM+HxXc0be4JOqtNJq6aaEjfl8q2G8yZuKqylILSxlt2gyXMvV6?=
 =?us-ascii?Q?xo2PJ31PCP2mIlrgxJiAy3bBVlAQk4qezIph663ClkJn2jYIRuGu2ds3ZLi1?=
 =?us-ascii?Q?0GaiGx7LQJEk+Ir2N2k1HxonQ/ke2QzqT0tfR4T71oHfnHx1h5kzXu3g40qQ?=
 =?us-ascii?Q?5rifmbUrylVDo5qFUajBVcPu4CoWFVbfFTBGtYYWIb/BhpAMbvpmI6n0HDtz?=
 =?us-ascii?Q?E3JVv+T6MldO94ZfSZHxJdbq9gA6W7itckUweRSvXrkbXhUv056ObkhROYjr?=
 =?us-ascii?Q?ZucA2b67w2QXNnQ+J5QNNJDRzEdTgAZYClHn3vmlPPVAtm8pbpqGXPc6rc3/?=
 =?us-ascii?Q?g/VclSXQi6H0cw6qE6/FxOrWYYer/uEqgGJI3mSifIfGp8BtIHuLZgh6y7vn?=
 =?us-ascii?Q?aggs2y8dMzTaONP8auzghGwZ0bQY272a2dp/zQXJKEQfPPzDIGW6FMQi791Z?=
 =?us-ascii?Q?51NLW3AIKfaf+mPITqW5fwXOO5SqIQO1tI5i/C6QMT+OgU+1Rygxt4seLIuw?=
 =?us-ascii?Q?o66pXUdpCtIq9/XP7rW6eJKe4nSVtlX3v0UC/FP9DMEZYBlSp54FpFMi/vz/?=
 =?us-ascii?Q?YeX/DjvkKSDRWtl9/KJm2aFpv1vdHnoS8lw41hXe7TlwdU7RL9R1GB6dmmts?=
 =?us-ascii?Q?m6XihjNHwDl0UElboW2xyVBzIG+Qq+We/IIAhVj2wn2tm7mO9ZR9EUT8sFpL?=
 =?us-ascii?Q?mPOgOap+Haky+LlhVOZ4ihOqAgFB5X9PenYcx+VAbdRQr0usHiOuKrO5mDPL?=
 =?us-ascii?Q?2K4sRE6IYXPB2Ou+Y4y+Mng0CWw01ZYOiMifWTJ0obEW63MgX8XlrG8v4hQm?=
 =?us-ascii?Q?utL1UhSzPQ83Y/5q7lT58leYFMdlmE1lw+3Uv1IwRTsz+NA5dtctNT6Etug4?=
 =?us-ascii?Q?DyilEiXQ58iSaSN7x+Z5SOSmbZ+hwfQX+3wfAKD2C0ox0Ovy7ISIqhSEoNZx?=
 =?us-ascii?Q?/YL50B3Q6t6LYcikIUuw84VTgmgF4954fzWmHyRrzhtazyPTs/JkDJ8FgyeC?=
 =?us-ascii?Q?uB25UoEfoGxkDJZNUAzigO+EDsFa+s+S9tOxpjDLoXVTX5DsW1l67/rNIqfd?=
 =?us-ascii?Q?Ct+27FR8mFQemD0iIJW3p989Txw2aFugWEuNS9by+ZTrWsgybnV6CtXBoE+L?=
 =?us-ascii?Q?wpdjpn8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCXfdVdmp2mQrA16MtmIClhEDi4PwrFdntmCcIhjB3dlW8PMAGrpp3AA3o6d?=
 =?us-ascii?Q?fb356JkifwfOX+8A3vEHc23iCVxzVIEEH6wBeKMBIzOTEwsSgE+SRALSZzga?=
 =?us-ascii?Q?NwzHMedrv5NdjEYdsjV9MPkHl1r4lBLr5C3/08HQuvSI4E3GHpLtSb8KF5e2?=
 =?us-ascii?Q?C2EW8E4kzHuQVmNJStLcVIcqj0KZaktsUeL+GaIHyitHmK4tdZgrYIDl2oNa?=
 =?us-ascii?Q?tfjjF+DPKcXi2S/l7I9qNAwKPTuGG/FRgZwSIx+dyGC/XM1HmUugh/XOZrjX?=
 =?us-ascii?Q?5QdY9McpaFIUeMToYemTPAAHtZN+qM+zjkOLmh1kfJmdznP8tqXhWKaGTNgt?=
 =?us-ascii?Q?cGE079bZ0MSOcqbuIKZ45HLf1NBc8RZ0Fd/EQt2kApei2wOwtrwigcuXtu+K?=
 =?us-ascii?Q?ZSwH7c9q5PtBkqemn810SQteOfnqTceI7Q2OWBIdqXh0hoW5qPTMM8KX+ooK?=
 =?us-ascii?Q?63U5IboegbR3gNWYIHftC2Px3W/d7PG1MeS0TlJult9GopB+xQtoTbdX35et?=
 =?us-ascii?Q?CI4CQ++S/nd3Apr+dNsP1vbYg8hrR8dL0Ycdu9H2QJlkilhbWsEfcxp0QezJ?=
 =?us-ascii?Q?+HzlHhijVq/Xb6k/KbK4pF8lUBOW78pUO1tF2owTVbJaCZu7gi/Ts676p4Lc?=
 =?us-ascii?Q?y5V31b8QzLQBbCvwneGPVXZtLAOgWllb4L8akvlAgqFMRvlryCd7/LnjjAKZ?=
 =?us-ascii?Q?xI7I7o9QXkD304cktaz5sH3tH6/kSgkAM9w8h+HFs3r0MHo0nlPjxX8HlmFo?=
 =?us-ascii?Q?kL2X5Nmk0ISYhP/LLw8/0ciLDK2XqS2sWN7IzXCq+WE8y3GKlrzd2IzIU9i8?=
 =?us-ascii?Q?qCAREqNwyUkYTVIbLLYe+IlOGZGwJEzrAR2V91AN3D+I2Fdpw/80f8wsFqjj?=
 =?us-ascii?Q?0pBc7JQ+Pb31MCnPnP8cLDo9FCyTMBHzaQXS5+H+bZVn9iY8oaP0hmkdGNOL?=
 =?us-ascii?Q?EJ87F+RwQKHPHn8hdvoZMsAWZle6tps+uxZPeyk4BSORl7uRCL6GuvrDditQ?=
 =?us-ascii?Q?XfIYXKDFh6TUWKi68vR/kfGYpZe7fcW7SncZew2aCcq+0HyVnvyx/1/T5dfV?=
 =?us-ascii?Q?laCSH4nQJMhoLLMpqDUQJAg5McohD7FRkCU56ECVDWI9xPx1fYYrlca+aBmC?=
 =?us-ascii?Q?z/COV28qdIZwciJo8LJJ+XRhYxJVWDe79Iddhs1HkB1n2QzrlNmdxXgZlx+m?=
 =?us-ascii?Q?35zrq2b6nGve6mA48Dah1kL72sgXKztAIx8dtZ0B8oD2pk3RZwAclDeF0/xf?=
 =?us-ascii?Q?I+qRwBlL3dNmftWixyUECMNc4feH0zOzRPy7Jav9YhlE7f/QXrHSWIJurrMe?=
 =?us-ascii?Q?zLbaYDJSUmCKdjCCDLUEDNVdZE9DRWaRlVg+BS6mGZT01ukp3JDLXY/fm+kL?=
 =?us-ascii?Q?agzauS0mketuVEfjmsKCWP+WgfewsRni2mXmPY4Tfv+sxVcpGlSBEwZtkD24?=
 =?us-ascii?Q?eb/DWItyumxibzuhU2Ggp3AWr0GeEGFhBFZyv/Pvj3UgPpBPTx//lB1FrWFF?=
 =?us-ascii?Q?14wiNK4y8FXWtyUIulraN9+mbCfLjIBT1DYiNxQP8a8+8ZFnhnYRiYXUPlca?=
 =?us-ascii?Q?1F0KmNKurlLt99RrcAk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514479BC04F9CE88390562A9F7432BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f5345-e78a-482e-c971-08dcf20fd8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 20:35:05.5774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lhya0vRbW3C4eaXDDJW+FE50SrftIuWceQc9sZP9+PJAmuUp/suavnyMSS7YTPlSSmlTrpaMO51Le61QUcLxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

--_000_BL1PR12MB514479BC04F9CE88390562A9F7432BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping?
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, October 18, 2024 3:20 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: handle default profile on GC 9.4.1

It does not support fullscreen 3D.

Fixes: 336568de918e ("drm/amdgpu/swsmu: default to fullscreen 3D profile fo=
r dGPUs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index accc96a03bd9..4b816c7e94fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
         smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 5;
         smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] =3D 6;

-       if (smu->is_apu)
+       if (smu->is_apu ||
+           (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1)=
))
                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_P=
OWER_PROFILE_BOOTUP_DEFAULT];
         else
                 smu->workload_mask =3D 1 << smu->workload_prority[PP_SMC_P=
OWER_PROFILE_FULLSCREEN3D];
--
2.46.2


--_000_BL1PR12MB514479BC04F9CE88390562A9F7432BL1PR12MB5144namp_
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
Ping?</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, October 18, 2024 3:20 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: handle default profile on GC 9.4.1</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It does not support fullscreen 3D.<br>
<br>
Fixes: 336568de918e (&quot;drm/amdgpu/swsmu: default to fullscreen 3D profi=
le for dGPUs&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index accc96a03bd9..4b816c7e94fe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -1267,7 +1267,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_COMPUTE] =3D 5;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_prority[P=
P_SMC_POWER_PROFILE_CUSTOM] =3D 6;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;workload_mask =3D 1 &lt;&lt; smu-&gt;workload=
_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
-- <br>
2.46.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514479BC04F9CE88390562A9F7432BL1PR12MB5144namp_--
