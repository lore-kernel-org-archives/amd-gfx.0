Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A12C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 09:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A4810F136;
	Fri, 21 Jun 2024 09:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VOccfzYZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B7710F136
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 09:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmXEaGa0YzjAXo66yWHZ6r5iSu5f85GX7v8RDB2vod34BVw2E/QJVWF34RqKnCS7/BipKzteE7m8jQJyAlibwlzKaiB3sN/FnrRG2kwH3U6huU9oNLsHuXyCO+d9FhnQZ5Zti0w3ul/EXbGKDDAVrFka0zEdMlAosga0d/zloMIbDNqlqrRzzuWWXzJCqO5uVfe9S8A1yeXA5pphTbgok/Bsr9BE4AtjH6cGvYV3FPX8sMySd0mw3wOxzPq3PopwaZV8OUrpw4KP/w7cHkp5JXHTfg9KUxfkhimDDOtN5Wv1ABN3jDslR0nxft/ADVeKtPGv0EN9myHYYlt01656oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+ak3821sA3xQ4Ryvj3pwR+iB868FP/H3nfFG+y1HH0=;
 b=OuXwpkqE9FrEi84KL/Khcinr66Pd1yT3Zpi9/5yyf/rC5L2HvJjUs4Xvv9Md/OchuFEGJO33nirVt0ErZNs5LsVg6glTCakHNFSHq9qBi8Zq9lrBKBoPF2X/S2bIejJjwy45lRcYOg0C9Pn5JeL82lh+UG6agqdc8qRnH/YKQALYVtHfR8GDmC5Zg/KrhSHFzX1RvaWlmsVmeh596AwroveN1cUTMsyM/vtFAG8Y81VmYrh+DsIEDLKoDDTzB09fUbcI9HdGLlLRqmrTh7yAm/QXTSYkv8wgUvBF0AKpq+TtQFouMXfRHD2bwj35KfitmvA7LQKbA0z9dfxAD3oLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+ak3821sA3xQ4Ryvj3pwR+iB868FP/H3nfFG+y1HH0=;
 b=VOccfzYZ2S0IePcrLpkDLLCm2MY0vB2gQEI6Tz2xlcv3x/r1UOzj/cDtZGcDtOeRe1rfOvYs+5xMtuGN0genSK8ZKnzP12mLi0RWeaBT/mN3aVFtKK7AvrNbIbqgLnMZA96KdJpNJfcWLuA2dmMXlU0z3HSdllKrhiiMZlr2Pj8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 21 Jun
 2024 09:55:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:55:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Topic: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Index: AQHaw7CMWj1cxsKiGUqSKT1l8FsPr7HR5GEAgAAWaRA=
Date: Fri, 21 Jun 2024 09:55:18 +0000
Message-ID: <BN9PR12MB5257ACB8DD1DA1B370ED686CFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240621075629.27060-1-Hawking.Zhang@amd.com>
 <DM4PR12MB51811F4B16BD0D6A7F103604EFC92@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51811F4B16BD0D6A7F103604EFC92@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9940a3ee-9d2b-4b25-a5bc-7eb47433b69c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T08:28:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY1PR12MB8447:EE_
x-ms-office365-filtering-correlation-id: ef067000-25ed-441d-0e60-08dc91d841e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?X5mpXbG6C02yvYFwkRz322I9hMMBqMzOo9ZGUpvbJLjMcSu/JORsd1/ZFFsA?=
 =?us-ascii?Q?k2gdIHsSHNeujElb8Hh0KC187gIA68WYQX8WW3ErcINLSnSksJOyUKCoeJlW?=
 =?us-ascii?Q?1N++QrkEAeFh+PngOz2s4uTLKRbDO+PTetcJ3ohsRF+2E3MgUTXd8QSN2Qlb?=
 =?us-ascii?Q?H7pd4FhFhyDbz04GTal5QYVCvwx9PKqf0D7i6f8alJKuqvYkSB4vh9+LPQNc?=
 =?us-ascii?Q?VxvGV8cddaVosVao0sTDf1+UTPgtFgQVZJmXl3Z3MrcF9Hk1WEVTUJipx7+d?=
 =?us-ascii?Q?ujCOkO45+/Pk3NKDND9hZRQyKQsIP4mBDrOGfnKTbOtPhhz35ytWKNdc/8S6?=
 =?us-ascii?Q?3dcu3pBWNIyIwmz9p5WByloXyXTyqMWH7RK1Vkel5SjkqdwGTBDFknwUB0JQ?=
 =?us-ascii?Q?o8VKBK1doXB95vDI46Ftm0M37dZZB1YqZcgXQDHNcqGkGm8C3cZ46NqfEJOe?=
 =?us-ascii?Q?PvaqKwVJm+EnPHMQ+Mr3XKkxVMr8SKTzR0mvwa0TSamt1fXqHF/dBX8CKjYd?=
 =?us-ascii?Q?WZQl/LUWFs04aAWsW1YvugFvEK8RA4JLZQHY79tRQAGpc+W71dz/iAaSlm17?=
 =?us-ascii?Q?swigm2PRrcKMKJDu7OtfDihyf3PySC3p42oMlKgB8jNwi+AqPZ1nLmv4gMV0?=
 =?us-ascii?Q?3xUzpQqookC+QcWVJRPOJPWvZXFwMtWbEXJUXs0X7/2GRLmASow/+8dLPLlV?=
 =?us-ascii?Q?AtsG9XJpXGKiPrnRWI1qgbrV+0yyX9X8reiO02/zxFFPjISMyC9fIr+waht/?=
 =?us-ascii?Q?+Y/8c/MlHNJn5je0kmP0j8q4lja9YGg0Exbr3m3oXnjPUNSYf/NikTiKhzgW?=
 =?us-ascii?Q?oWQphr5e+xD3F+ZQFGQMw6aFNYjRMz8DSC7LF0c6FMWSqtUglvGP+Bh/VFBM?=
 =?us-ascii?Q?ZvA+P3tq7bu3V69gcykHsE8kV1JEqiXk+F6aLXcTTyi3YubZhIdp6Qd0Mi8b?=
 =?us-ascii?Q?FRgB92rjQLpfgQsyhBRvHyyPek+iMtH1WrKcNo8DYQywvocci6UJrWGkT2BD?=
 =?us-ascii?Q?neQYhojE1UbVGV5oMJP8znMp675W3o2RMsr/wv4l0tdN2vtHodlpEx+a9ufk?=
 =?us-ascii?Q?gGsWwuWMjn8IDPOk59Ee2LgrkJMx7f5/RtnVf4RD4GYWkwLOkbJwvlGAkn4O?=
 =?us-ascii?Q?D3YQcQM9WTLgKgy4++lsZlh4z0cdFClgEgfmCm5+ZwppZZRA5KxH+82BRa/f?=
 =?us-ascii?Q?iAp+4tge4GL8RCce0rYxyjP1El5pcOSuWjr3GxZE/JIWcWnGajiWgKy1eN/J?=
 =?us-ascii?Q?c0eMUIYXe7lPSs990CEFNBjP8SRAzzmPxxiVSOwYgFVGnefR9Oe48ilZ9PuO?=
 =?us-ascii?Q?pqFL/LzRiqV/+iK8iPOiZ4P8gIPj27jr4vzgOqRx9WHHiMlkRPFkb2Xk7C6U?=
 =?us-ascii?Q?Stsfwrg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p+FqqRCvx7dXZj9xggADbCMMQJdk3eYF7Wt0O33aYUjsr9B8G6wPHP9MjI7x?=
 =?us-ascii?Q?BGOYnUH488wcxWtKJRB0hXWYElbqxQgTv1FPYX/K0rrdy8tycvHcHnRftxOS?=
 =?us-ascii?Q?8d54UsL/7fIxQVZYoNoJINBUjqaKnGhof90M6IBhfO9zOyk3sEdya1fQz4Hz?=
 =?us-ascii?Q?7TxID+7MsV8fE85yR15KT5MbQe1AvNsgqEW8nu1l2c5ZOmY3OXQVG9AU1mQa?=
 =?us-ascii?Q?2z37oy8zXd1GJFMw5dTeitB5rcmUKsQnEKzitzlN/Y5Cy9QPkiVZ35d2xUZG?=
 =?us-ascii?Q?kKZPorQIbBNQgYRFYLD3M7Ys+KqWvcOe/hmuKJsHjhzDD5YKK/dUSegIXC1g?=
 =?us-ascii?Q?N9d3o2GOblBJNeLZNHRsX3Z4geNYHIoknFlC+fdo0Ar+grtSBl0cNAGGM9It?=
 =?us-ascii?Q?she35rAPYGYueTTsyJ+mEs92fDbzmdu0p8G6OIf5fON5PPEaN5tSE5235HxB?=
 =?us-ascii?Q?JHHNfi0D4Md6IW+TPQecDcjLwQTGJQogaC5EZHS5++WbTrbLEqRliF9gtakY?=
 =?us-ascii?Q?yasXpwugh5DYf73SN4SMsyw8Fi7l7svySZnlnW/kfKsNJ4wZyB5a44ir10DS?=
 =?us-ascii?Q?o5Sd2V2V4dEJYXYy21BJfXkHEPIPPU+2AGpT2W1CuBE/Dj91axpmQuXQrEcB?=
 =?us-ascii?Q?y+dbOPeH2823xRvWZbY1hKfd8IQs+9Xi5zRZyGxQLf1bg0Z/TkqGLD6oz8A6?=
 =?us-ascii?Q?v/DpA3afL+Q0MIlQS9lcjQe+/gentAn0dWhUiTEPs47lXkGNnqusxDOVGjvm?=
 =?us-ascii?Q?YbQobHB3JTRC1zSp5aBBggw589ancWrKgbIGZfjXZrpt1jNtgWfAP7perp9g?=
 =?us-ascii?Q?7mCXKiCwk/1mUhsHjQ8AbEtn/HGZmJWQ8n3TgivVMaJvEARur+qQao1jcbPd?=
 =?us-ascii?Q?ymb/jww1MzT9WqYR887/GgMjp1XPA8LraxcE/jEzGkN32Y5d7dNh9v86AyTN?=
 =?us-ascii?Q?dZ2aoEFXUTQ56NwKFwYsxz8iMiL/YIKS/mUPh87TMZePExt6+dixsNb5OIYj?=
 =?us-ascii?Q?raeKcDVQuAY/WBPgT8kTELKj7/6QJ8NZNAx4LRpahMYRN2GwMM1up+Zmhtuy?=
 =?us-ascii?Q?yXN/zRiBhwWoKkunqSWugbRjIWrHWZo7EJUb/BKglV6U7GfO6WubIBthCNCg?=
 =?us-ascii?Q?6Btnq32lIKbQWRMMFeNfR/j52ngMMF6BIMYrms+QlU9gbOIXqtcUVy1o6orZ?=
 =?us-ascii?Q?RyqACnD+Ynpsp8+Lbn/ELPc1R2wq7Vj4SjSABVGKMyXGgKHTovO0g2Sn26On?=
 =?us-ascii?Q?6Ap3unGh/nnq0Tc3HD6jE8rRX+TFdMWxCm7iF5LuHgQJSMBAwK/Jcr4hGl44?=
 =?us-ascii?Q?ZmItM8OUbfsGeemz/bf8njj56p6xW0oSR1+V7pMh+gvMgDgBFV83qq8S2FO2?=
 =?us-ascii?Q?fFc/fVz3Y+D7wwIznnYET5Tckmsq7zhmM/cxvPftgUaPKKAhZt3Jdp25ePoS?=
 =?us-ascii?Q?QUEzEh4CeA6Wz+8kw/lGQJfU4Zvqiji/qrQInUcDFcdSdxLARxLy+qzbFeu3?=
 =?us-ascii?Q?p10ckC2O6UBlPPDNRpPNqygzIIBnDPkWTKq9DQ4nwPX/c+he4VvnYRN5IHzz?=
 =?us-ascii?Q?ysVnU3n/9omZCuTiDsmrOTTbWEPGlHszti2iIh9A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef067000-25ed-441d-0e60-08dc91d841e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:55:18.3999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiaCDBY0wJjUp1/W1B2LTV/KHTZ5Ocv0/XT7n+40+4La3fSsWO5uBorsofmzX53EAQYpAuWa6P65/QVuXnGuBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

Sure, that works. Send out v2

Regards,
Hawking

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Friday, June 21, 2024 16:35
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Min, Frank <Frank.Min@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix smatch static checker warning

[AMD Official Use Only - AMD Internal Distribution Only]

Seems only need to deal with this on gfx v11, for gfx v12, it will judgemen=
t whether (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) before use imu funcs on=
 gfx_v12_0_rlc_backdoor_autoload_enable.

Regards,
Likun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, June 21, 2024 3:56 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Min, Fra=
nk <Frank.Min@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix smatch static checker warning

adev->gfx.imu.funcs could be NULL.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----  drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index b4575765d7a8..5c17409439f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4498,11 +4498,11 @@ static int gfx_v11_0_hw_init(void *handle)
                        /* RLC autoload sequence 1: Program rlc ram */
                        if (adev->gfx.imu.funcs->program_rlc_ram)
                                adev->gfx.imu.funcs->program_rlc_ram(adev);
+                       /* rlc autoload firmware */
+                       r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+                       if (r)
+                               return r;
                }
-               /* rlc autoload firmware */
-               r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-               if (r)
-                       return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
                        if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) { diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgp=
u/gfx_v12_0.c
index 460bf33a22b1..16fc5c5b15f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3258,11 +3258,11 @@ static int gfx_v12_0_hw_init(void *handle)
                        /* RLC autoload sequence 1: Program rlc ram */
                        if (adev->gfx.imu.funcs->program_rlc_ram)
                                adev->gfx.imu.funcs->program_rlc_ram(adev);
+                       /* rlc autoload firmware */
+                       r =3D gfx_v12_0_rlc_backdoor_autoload_enable(adev);
+                       if (r)
+                               return r;
                }
-               /* rlc autoload firmware */
-               r =3D gfx_v12_0_rlc_backdoor_autoload_enable(adev);
-               if (r)
-                       return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
                        if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
--
2.17.1


