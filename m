Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F97FC0342
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 15:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B77D10E339;
	Thu, 23 Apr 2026 15:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sx9z4d+W";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D494710E339
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 15:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3TfvJjnqGHk/o55hPViCcsV8APTMiNzXXHoUJ1eTMasjfW9HyrXEWQ0fTFITYpUtfDw8m3iyxe3Y1R2rALvPU6BIJej97WoADyuEtxnaTS1Ahvzu9rpdnSYDgo9osGnVNvBx1l3cWuS3mK4vehyi1VLVoKeGGyI1ksQigb0JOT05V2rsvkbA8EwNH5+rHI8kOBIQuhzlw+3yF+Iub/cLrjVZaLLZC8eeQ5NxWVApwsIyhKp6JDvYUoTC+ZHIChlDKypZMNNW1+QZSN/G0TQlbGhB5tg3rlBSQMDS6FfHHqU4Q79MgMgGiDVz5UX9JrBGRkN+ZRAgQZAHG1uQIBW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzEwsFpPbZrFKxEmJaagf1pK9z2Q8RDr53wtr0hjWao=;
 b=fMd5WRIFv4YPRYA+e3qHe+aeJ2QloUjxGb/Wxhp+K5p6W4ZoGaCcaHJZ1/wyNOoVbKEMxHGJuZGby5sHrQvzcnxuOBmUrm+Nd1BWFQWPbk/QBcNG8sXB4OcQLEK0t/l9Ys/0nTXg0GHyPsnr7Vsu/A6iIQI45yiS7NfjmSygh+MuxlivhQIw3PcimiMQj4BgfxmgWLs3sKgrszgBo9iBe3pRUiOrtMCXLsr+xVXTfYddWmz8VgpWgaC0U0a7zWx4NIIXygT1XWeSuWI5Ele/+nncRWifBM8akZRKUUsM+tDPRbAJIOhdh7gP9RM/pTkESwUNQZsROg1X0Ojvi6Ic6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzEwsFpPbZrFKxEmJaagf1pK9z2Q8RDr53wtr0hjWao=;
 b=sx9z4d+WM+MUDN0kJYK0uBhVKNIfY0PlpCgIbUpm9g0n3Rlu9sxa4chO55HrDL4klgoJ7ZYt+35Yxfu4zFNhBZYN5DomeuEIKg00A48Qi8g6wjdgyE4Zw9Yl1Awf7irj0b2vjrGlnfFOV5mlmbUkvaJamicqEiVsQXVeflwixHk=
Received: from CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 by SAWPR12MB999165.namprd12.prod.outlook.com (2603:10b6:806:4e1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 23 Apr
 2026 15:17:41 +0000
Received: from CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::2c04:6d3d:3291:a265]) by CYYPR12MB8962.namprd12.prod.outlook.com
 ([fe80::2c04:6d3d:3291:a265%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 15:17:41 +0000
From: "Varone, Dillon" <Dillon.Varone@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Khachatrian,
 Gaghik" <Gaghik.Khachatrian@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <error27@gmail.com>, "Li, Roman" <Roman.Li@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Chen, Chen-Yu"
 <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Fix unsigned underflow in SubVP
 vblank schedulability check v2
Thread-Topic: [PATCH v3] drm/amd/display: Fix unsigned underflow in SubVP
 vblank schedulability check v2
Thread-Index: AQHc0y7UAW3u1E1Dg0iyUkYhrPY8sLXswkJA
Date: Thu, 23 Apr 2026 15:17:41 +0000
Message-ID: <CYYPR12MB8962961F4E4A7A1DC47AAA5BFE2A2@CYYPR12MB8962.namprd12.prod.outlook.com>
References: <20260423143804.2445292-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260423143804.2445292-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-23T15:17:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8962:EE_|SAWPR12MB999165:EE_
x-ms-office365-filtering-correlation-id: 6ffa33b3-4299-42bc-85bd-08dea14b767f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: IX6Cd75LPd5TWxloIBRGtnBaqIHejRR2iWzA4qnh7oqMsvOqxnnriD8+J0FtDnsgo71IxJacii90MGR5RfENx5bC7hDPwsOgaTd4T750KkAhaex04ED1DhpW20cAslFwsjT7jdtAUgLAsAUQLByM7lSRiUCni/ulE82gTnHD+QNbUVY+xAiU8lKl5tEC9krZRARztC/w9YO5wBZYNCdsQGtvAIOaz2OTZtTztbV9A1UdZT/smbtKNZH3K0B9WrE9bl4MhE0NS+Ka4naD/0XqxlCd44HPL91WuoSts6jwQveA2MkqFkBFjCZs2qIug3OuseZds1LrKJOVoocb60uT+p1SjqbhlIMZwX5AUPhbmenKE5ZQ4Wq3m/axDXyzKmCmXG7jvmEDle2n5cAgdpvsUQmLh9I90ROr5rUlxtv5iqbGVpinOzIFdkyuY3nY6zKXC4SjRRu+dzKmuyukK9w4f/ONWrtlm7smTH1PpNaA0d8tWkyeuFD1BH490QNvlhqbwJPLI4tVMdYit5kSvQQ+aEi+1oVVokIk4hBG3akCGpRiwsEYriZot/Qk3DVCWDUVKOxZJggtVDqATsnP+DWXPU7putMFvszlAjF9TULJAOocNsZEKMGPoCv/tPrG22oPF3A183b62Q/T1KKRssy8JU1Xct/wG0iFyrAM5fshVlk200NbAlGG0Z3YVi1nMf8fICH55rse3d6YMJKjzjf7fJvSnbInrjSxRJZ2tzoFHuXd7gIXyMCeOf2Zo4Mr7bNjz5cX68embb/6EQxzzsNysP0jdyduEbWdatKqb7Cg/HE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oE365xtEMf7o9LK35HntUxGbDfK+rpuILyYMGzH31H7TDX5l/E3OV1rQwnoB?=
 =?us-ascii?Q?Cw0Iglypb1JqbsKDhIpVTiQ1tpqnomy/FOMqk4Wozwl09ms0k8a7EV99zsG/?=
 =?us-ascii?Q?u2DgL8z94Tg8HfF8FDMgY4+aznFrRhAwNNVy3CqiElsFkknPeUgLaiQlVJ/V?=
 =?us-ascii?Q?slcM6rOPCls9kEuNRJ0QiNbVc15slFCDhUo6LkzoqFZZ7Bittyc+BSFKYgPF?=
 =?us-ascii?Q?cLQcGGlNWqP3PfXlpiDqXtH39qDR1SeBmYrIU8JNvNY6BZgIuwJvW8G5Q3J4?=
 =?us-ascii?Q?yjjPw7L8KJQIVTjyYt9SXWUytasLCfWDtuhbbYWkuGdlpj0ngpijfdKP6ffD?=
 =?us-ascii?Q?PKL1/OdR9JN4aCFgpIoW0W+JvbFcc8L3+tUBZ+NLjv6fEzKggbp/jqqyNngO?=
 =?us-ascii?Q?Q+TzTMp+2AmWDmxqHmVCbX/mgX+1yztUgIdA/BqCHoIEuCbXiwwp2mZeYmyC?=
 =?us-ascii?Q?zsCehhPqZlYk5b1G3ZVx0GUnxzvPhXffslfcbk5Wbf4OFuj+q3ZoM0Ffel6Z?=
 =?us-ascii?Q?V7pENnaZQZDN2RxNSrmJ/ZP/F5hQWYmAovptBpbzazySJiOlgUHJRm6YYZVJ?=
 =?us-ascii?Q?j9TXajI3BM0m7u0wOVHed9deyXzUN2Htf3hUkc9kQKuIjt/U3RusjWezXGCC?=
 =?us-ascii?Q?eH2ge+C0Ars8UsRrlauZSTY2OUfrXF306kOstisvTPk69ctBeZdvCOuWGAOw?=
 =?us-ascii?Q?juXruR63SMrmLXEUIrC5Ht2FIRMusoPwmMFUfrmL+/ipAeFSnT2tlB3O8ZtX?=
 =?us-ascii?Q?9792YZ4CeeahfOR2Ht5DYgtcd+NDKTlvGs+tUwWRXuQEA2m38y6oHrs0+rnT?=
 =?us-ascii?Q?8e/2wCMYwEsiyZnaF+ljhQi0DfNv/QqoiR4giySJYIfLxWkS6qDA2z0a6JzG?=
 =?us-ascii?Q?AtHKA/+9bgC2vW/Liti0LcCA1WTVal2DgFoUJXy5oqF0Blk72tfd2ph9rR1y?=
 =?us-ascii?Q?KSqWo0dkV8nf7f63sHB60IQUU1KizpmVMdEZUONS5gegsH+/i+gRdPvlb1Wv?=
 =?us-ascii?Q?gTnpJ8BlXNAskM6k3LCm2sdXW5RS0EumHTzoNmOxZSJkt+M+dZsCiYduqbAK?=
 =?us-ascii?Q?T+GDUddPKwP8qXQZgxtlMOqhgCrcXlaF/4CLQsp4FqfzhGBD/N7B51LzkY0N?=
 =?us-ascii?Q?nDriQFH2ZOHeijvrOsFFp5yn7/jQ0VCFyc5j/Mr3wjPwvHbdVT1Om9S4Rn4s?=
 =?us-ascii?Q?Yt+k5dE56GjHg57QVyLMeiXpjqyH2PovlDmms5DzQNZdoMJ5D3dzK6B+NHEh?=
 =?us-ascii?Q?V2wOu/XDbAruhsOwMIFXFgaYnY5F9w88ffb4ZZG1rhJe8N4IFoMSyxTR9iwf?=
 =?us-ascii?Q?NRhxGMW1X28ZigvXV+AmJtUbM4MjjGyB2DgUXb3QJRXIwn8WBg9qGRnMi1Uw?=
 =?us-ascii?Q?2MfeM3Zz0grhkTCHWHHNaD/XjBG1e+fQFw2Q92rsVa+drx5vocWhjNkj0tyv?=
 =?us-ascii?Q?e83N5jQfyhhKSX27dI7OCVJb+FrBaSi697tTyWUs15IVOoH08fg0nC3z32ic?=
 =?us-ascii?Q?yFOd4Ies4AcFgfRsm0zpgfeL1p+zMcIybZ46PmyFPUIr0wUEPjxfpOvGFnMn?=
 =?us-ascii?Q?2hbNI2hI9/o1z5is4Tz/UQCk3zPHsqFAGxkUcTnIxKqTdO8EJ++dwZSlvilp?=
 =?us-ascii?Q?x6isdXMqyO80k0+k/641VRNGnym7FFMu1c+nhozAhNufsq4dn3R0nLG5e+Mj?=
 =?us-ascii?Q?h7ZVrX9Mr61NUCnqtjCCXizhV/rwFuu/EeZpWjuiex+HV10V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffa33b3-4299-42bc-85bd-08dea14b767f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 15:17:41.5465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU1uuSRJwbGazPRPZ4+vO/5kMU88W93yrlr9Z6s44W6kwBLyzg9mofwD4FH2ONKgex0ftAQ08uWhHfxgR2Nc5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999165
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

Reviewed-by: Dillon Varone <dillon.varone@amd.com>

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, April 23, 2026 10:38 AM
To: Varone, Dillon <Dillon.Varone@amd.com>; Khachatrian, Gaghik <Gaghik.Kha=
chatrian@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Dan Carpenter <error27@gmail.com>; Li, Roman <Roman.Li@amd.co=
m>; Hung, Alex <Alex.Hung@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Chen, Chen-Yu <Che=
n-Yu.Chen@amd.com>
Subject: [PATCH v3] drm/amd/display: Fix unsigned underflow in SubVP vblank=
 schedulability check v2

subvp_vblank_schedulable() checks whether the SubVP active region can fit t=
he prefetch time, vblank frame time, and the larger of the vblank blanking =
time and MALL region.

Commit 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries") ch=
anged the intermediate timing variables from u16 to u32. After that change,=
 the schedulability test:

        subvp_active_us - prefetch_us - vblank_frame_us -
        max_vblank_mallregion > 0

is evaluated in unsigned arithmetic. If the required time exceeds the avail=
able active time, the subtraction can underflow and wrap, producing a large=
 positive value instead of a negative result.

Fix this by comparing the available time against the required time directly=
, using u64 for the accumulated required duration.

v2:
- Use uint64_t instead of u64 for consistency with DC style (Dillon)
- Make all terms explicitly uint64_t in the accumulated sum & use
  single-definition form for required_us (Gaghik)

Fixes: 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I02bb3461afea3c34bcc0dda2d0a0c1d6a193e05e
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index fe667aea6ec8..4543a60a0683 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -594,11 +594,14 @@ static bool subvp_vblank_schedulable(struct dml2_cont=
ext *ctx, struct dc_state *
                subvp_active_us =3D (uint32_t)(main_timing->v_addressable *=
 main_timing->h_total /
                                (double)(main_timing->pix_clk_100hz * 100) =
* 1000000);
                max_vblank_mallregion =3D vblank_blank_us > mall_region_us =
? vblank_blank_us : mall_region_us;
+               const uint64_t required_us =3D (uint64_t)prefetch_us +
+                                            (uint64_t)vblank_frame_us +
+                                            (uint64_t)max_vblank_mallregio=
n;

                // Schedulable if VACTIVE region of the SubVP pipe can fit =
the MALL prefetch, VBLANK frame time,
                // and the max of (VBLANK blanking time, MALL region)
                // TODO: Possibly add some margin (i.e. the below condition=
s should be [...] > X instead of [...] > 0)
-               if (subvp_active_us - prefetch_us - vblank_frame_us - max_v=
blank_mallregion > 0)
+               if ((uint64_t)subvp_active_us > required_us)
                        schedulable =3D true;
        }
        return schedulable;
--
2.34.1

