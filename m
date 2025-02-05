Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F2C02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 21:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4066110E3FF;
	Wed,  5 Feb 2025 21:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHxGGMyP";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6559B10E3FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 21:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpoS6XfQd6eiLjAIzmRhEqTk3oRZRDCCNepMstrs3nsSCeWltY7UaULxW5TJwSQhjz5kQWp5ZRDHQtAukmm/WCv1ls1MJ0MglId4/mXTwOq1aaPc5VueUGJfd9plNY++N96voD1gq2rV/gqr+++CYAnpVx4kf/6lFb5BdmIgMXRbACBCDXm1hBrZRM3QiwNW9+mYixACdJtCyc+KH5a9w64eqndBf4x4xTk51DQJbdCHNnb8qmsXHhXArSQTTd+VLzwiCkgStLAYJj2wpkMvvXWtJgxwNmdlDTSSHpctYU5Z22AOUrsrgBbelGkh2DjGHcbHSzPakoKcHuFTq4wopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF+M3bjB9K6uONBjEi4o5/BjTylMXqmHs3/EIZ8mQpA=;
 b=cOYfHTOr4S4IFSd0pzvpzFqJp5C1gcTpr5R52FvFaaNMIL3+cRxdwGoFmUvw8d2lUWldKVgo9TxSf3Y64ECteizPC2v46+7/UsA0KuYrwkzK1/tbhangh+Zi2HAEGkZ+C45wQ+CKevDuysoLW5zKjCl3NoFauo2TTGUTYD1hyURan8jqQkSWh0WhDOYN64Wyg3uDF4oOhhAQp6Hixwd72lN8rSrzdg1Q3CRW/EvIttSuYDYkjhJsJVSm52dlbrrBuZDTXrWN3rIMTRZtSfyZjtramu0mOWTnQxFDJXM/9nBu5NBl38/E3KtQEwwwqdHgWRerjcRrWLVcyptueBeWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF+M3bjB9K6uONBjEi4o5/BjTylMXqmHs3/EIZ8mQpA=;
 b=fHxGGMyP2ZgVDFfy5BwgDnXfJ7m1KJ5li4WRHX10npU4ee5wZP1ABtLWO3VC4rRs+ABu56wVPG5am/34zumCtxsufaQ8acIHPH9sp/TT1k1ydNNhqPfA4TY3tGzBZub5q+i9952tImTYhDgvyDn4xv4P5NALYInIS3ZAt8+LRQE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 21:15:30 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:15:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Make VBIOS image read optional
Thread-Topic: [PATCH 4/4] drm/amdgpu: Make VBIOS image read optional
Thread-Index: AQHbd8KKe0D8M6guQkeHm3R9WW18Q7M5NoCk
Date: Wed, 5 Feb 2025 21:15:30 +0000
Message-ID: <BL1PR12MB514421942D8445245414812DF7F72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250205113832.1903614-1-lijo.lazar@amd.com>
 <20250205113832.1903614-4-lijo.lazar@amd.com>
In-Reply-To: <20250205113832.1903614-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-05T21:15:29.844Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL3PR12MB6451:EE_
x-ms-office365-filtering-correlation-id: 1e125457-058d-4e22-a28d-08dd462a3841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?doxWECPzjCHlI3nLVXldQrDCJ4Fw6GlyARGRq728IQKHVJkTwxwJP2W9j/U6?=
 =?us-ascii?Q?oYBtBbwT98Mzh9KDNwL+AI8vhdn0L9tRSUzHEqRSFpN8+bqJwf/3GZCzEv9H?=
 =?us-ascii?Q?HWI3R/+fd7FPkiKK64jokx3pcbON4gQbiGUFyu5ZVooKDmPXA5sJP3RucKIq?=
 =?us-ascii?Q?u24ddj4d4jcmop3OJ2v7Eokj8krMND6E7D8zf7VDafyPVH81Fe1x9kv0gqcW?=
 =?us-ascii?Q?SAVvbaUdJz0myZZCbU9K4277l6p+foRLvFttffVLrD0/0meQVacNiz0sG6vF?=
 =?us-ascii?Q?o0VO+sbL3jkSuraU0cAE3okh0YXXBykoxDWyUnkmPJ3ZIOrpkoh1unFwwfLj?=
 =?us-ascii?Q?5h1/42Q/uw9dGpaqN3S0TxuligaXKMUv7NBypG6bIsh9+6doiOE9Uqg+wiBo?=
 =?us-ascii?Q?vjc/ez1i7UOub5YDlV28Z6CAH2jWkF3r98L10pXbcwTAT7y91/5ZW6VVJK12?=
 =?us-ascii?Q?DavkXEzFAh20gOUVs3E7tM7nPM1LxbNYIdOLab0N/y1F6iQWjpCM9JXTJAuR?=
 =?us-ascii?Q?wBpnQAsAdNwb4dSJ7q6xkDjckXuicfckHKb3VLHAK4+OHF0DLyDkx8Yjc2eQ?=
 =?us-ascii?Q?6AUooCcxggMHYMoGDJoFRoXK5rdAyvS7YlaVyjyPvN/9xceEBTZWq7BATl3Z?=
 =?us-ascii?Q?utTxhPBJ6TRASN1WvrOLYMYjES7ntXkvnNbgBY5xwYUxKSQuHK7VwQpKd6B9?=
 =?us-ascii?Q?NRVgTUkoi5KQEE90mwTsqQ90fVYDM/H1nM9iuWRUPMQXNS6JjBE4GIJLrxOF?=
 =?us-ascii?Q?S2K3WllFAFbqhyAU8fUEGnCPCYcunla+LpNOoPOqyGKHXfTh+xQyyC8/1Wqq?=
 =?us-ascii?Q?JFGFbMvxFVksCTaEJ9D4yAL5zG38Zd3qr3HElGuo8tIceuUzOETb06bkNsRT?=
 =?us-ascii?Q?ybVfgVbqnks4YF5ShVsHuDjakpn/aNackZSD2BQmmxKnbNTWNXqFK3tUn5A5?=
 =?us-ascii?Q?pCNHwLd4PJaJqC2vdv8A8Y5SjBeWKLVJoWyoMEqLRW9KJcrKSgfd5QnPH3as?=
 =?us-ascii?Q?t+BVz5Z2ZbMKBZjLQy5sjrY/H3C2cdiroOR4hZt8TIHT+ORGroNQEoR6YD0A?=
 =?us-ascii?Q?JC4UikCXqBtH29VUj3oXXs8mZ52Q1h3RE3f9T91p3flvPBsGEmHZbe+YBV36?=
 =?us-ascii?Q?BkrJwCDn2KW1yJl+kObD8gAgmNUEZk2UloNrxsmEBxWDC07qYWy3h3d/EOSJ?=
 =?us-ascii?Q?7fIAOfULKITPARKvOEodc01bJCcyCuOXjWkQAW7X9JmesN6PXOiahUJSQd7y?=
 =?us-ascii?Q?52ACpJUZc+4/Sb9BWfApIqpEvWxBhsCnfdHYOl6o2fzXCOU0t3+rOlHurpr3?=
 =?us-ascii?Q?i1IfsSfrXI1wt2IC+9QcTYBjuQCqrLLyF6GwH4e+vOXl2JC41/dUHd/9vNSH?=
 =?us-ascii?Q?8rp0YA7Q0Wwbq1lHTavP2gbTJuwxZ1hNfK/R6cDewZfZRZO1WnOZ3HVBBCLs?=
 =?us-ascii?Q?8kTLM+QqcBEAEGuwnXdf1GA42i0l5Sx0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gyqRL138JwxL8UXeC2h0qBi8iLO8OXsQaFMVMaTt15hNufYV/iftpxJDswfN?=
 =?us-ascii?Q?0/3TKPzRf19GNrC6ZLjhi+EEg8tjjDSecfvWv3yzJIfUri3JYFqUDoqsvb5z?=
 =?us-ascii?Q?spiWhzJbdFxT8JluJ4y0/x7cyXdQ22rmd0vJywBcbmRTZeHJNiRb8QiVr5Nu?=
 =?us-ascii?Q?ezGRz+3D/kP992ITQlFAjhP94XkZ0i8sncvfKVswkBF5g2Lgwk0aE0PJzpjg?=
 =?us-ascii?Q?AlRudF8U4cD8xG/DybLxic09zIfBJfsmD1zQvQUpdjUkWxyXo8josCpyaYc7?=
 =?us-ascii?Q?DbXVi6O3Fj6BOWGTaTEcF/XmrLHHP1IFHSM0foUR7GVbThzrFLwqO/UMRNrn?=
 =?us-ascii?Q?kcdNlTasFvG2vWPrEFzQTuJKVZK8/8H2R6yE6UPL/stRF0IgRc+WjwmtA4qe?=
 =?us-ascii?Q?rR3bV2dWSjkuvhSTSyWE1YiYlT7R0SthA8r6HsUkzK/9dC+ox1ruAqp5C03+?=
 =?us-ascii?Q?x1GE08DYrS2+z7tCkCbtGU8q4/pH+AZjUWSkjhKzUI7b0nIi746xEDokKgmr?=
 =?us-ascii?Q?0DR1BmrxUCGd+EYpuAiLqM5X4pw7Yb8UBNyU3gqCguetoQvsei4eqLpXreAQ?=
 =?us-ascii?Q?5yQGX6Es6bZEDCxIipexYrEorVbBkoRTvwaqnR5UednpaOhkdBITZu46unxN?=
 =?us-ascii?Q?6c3XVDmnMs/pQFGREaIsCOCBV6K/ZUUNfE8/Fkx99EIowWfcw6xkw/jJ95T5?=
 =?us-ascii?Q?euwgVeG5o4KTuPOxKv6MhAOD9g8YxDBVfi7f4vtgnoiz3uSddvENRDM307pt?=
 =?us-ascii?Q?JggWvktgpuhrKtbLeJsGb7NKHjqla9C78N0CDiNaAjpreM7qyS+dXkacyajh?=
 =?us-ascii?Q?U4/YKu5dCmjV75p0O7bbj4R9gi/cas6ChPbA8jR6a+MaeQLA1hLQscg3jjLK?=
 =?us-ascii?Q?H8uMlmWo0PSsP4JVO0AvnrdF2V9Ds2gJlY6UnvLfpfgj/oGmhG8gWxWph+Ck?=
 =?us-ascii?Q?irlwdLPgE80ldfcAa4xNeTgUMvOl+E57WqRE3DxaH707EGkMeziY57pLuRe+?=
 =?us-ascii?Q?nzjQ+g6HvVlryhY9ZGF/kDSfKVoD3V71aiI8e1krGdFJrcmnojsUFtnghzYY?=
 =?us-ascii?Q?wrUjFpkMPdqZUsqXdce4yUc5ngHvT8GJED/MkuOVRtt7hyJxn9u4rZoAuPH2?=
 =?us-ascii?Q?4ZRJFxt8jCGVTOgsBgFTidpljdCOaaSMTxzhoNz3xfa4LjAlgGMmZEDmKg+K?=
 =?us-ascii?Q?HfHnYenwHL4PU1hXZ/pzMMdHPGbK0jcgrblGr1FJSk8wRxqzLJPkLKGj7yn3?=
 =?us-ascii?Q?Hi2vvKpxnhwjw5fl83WLZSfETxnP+CSGhWG/TutvxJ0dIZi8PzUUd16BH7J/?=
 =?us-ascii?Q?rB88FEAg4q4DY2SWrUTbZmgY8E89totgqP6+sw5HLzlPWeNwMS6yugV6p6I0?=
 =?us-ascii?Q?c5wwRtc0rZizQM235JmciW0D5IEOU7XRFLQ8sofgXmje+mIIARx66cLlr5sF?=
 =?us-ascii?Q?NDv0+4pjcwIa7ovShhjfz8Ejy6L5zw5hlfQfHRs5fQWMfgYGMd4eJckTYT2U?=
 =?us-ascii?Q?mAHwZACJBjq2JG0yavAs+KEkfljMdueK/Du8ytSygWWLRC9FG+IYuijWySox?=
 =?us-ascii?Q?IiLhvlhXaK8jMp3OuDI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514421942D8445245414812DF7F72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e125457-058d-4e22-a28d-08dd462a3841
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 21:15:30.2720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fc3mSzeIRlDCwlqBIANXQIyYsrhuhQnFzbXVtgkpMEcj5GJ/2XjmSAXDFh+KyNlwtdk9sDwDjcouEmwK/b/gkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

--_000_BL1PR12MB514421942D8445245414812DF7F72BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

2-4 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 5, 2025 6:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Make VBIOS image read optional

Keep VBIOS image read optional for select SOCs in passthrough mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index ddccdceb1d2f..ade4d5cd45aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1397,6 +1397,9 @@ static uint32_t amdgpu_device_get_vbios_flags(struct =
amdgpu_device *adev)
         if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
                 return AMDGPU_VBIOS_SKIP;

+       if (hweight32(adev->aid_mask) && amdgpu_passthrough(adev))
+               return AMDGPU_VBIOS_OPTIONAL;
+
         return 0;
 }

--
2.25.1


--_000_BL1PR12MB514421942D8445245414812DF7F72BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
2-4 are:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 5, 2025 6:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 4/4] drm/amdgpu: Make VBIOS image read optional</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Keep VBIOS image read optional for select SOCs in =
passthrough mode.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index ddccdceb1d2f..ade4d5cd45aa 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1397,6 +1397,9 @@ static uint32_t amdgpu_device_get_vbios_flags(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hweight32(adev-&gt;aid=
_mask) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return AMDGPU_VBIOS_SKIP;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hweight32(adev-&gt;aid_mask) &amp=
;&amp; amdgpu_passthrough(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_VBIOS_OPTIONAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514421942D8445245414812DF7F72BL1PR12MB5144namp_--
