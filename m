Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBBBC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 19:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5673210E226;
	Fri, 10 Jul 2026 19:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fptN+aXO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A82110E226
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 19:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FchtZ0kKnHEBUc9S6vtShQwwDT0gygVVDGX2Njwg9ONm4OElIBiTfGOrpPPUpaVM/re03fROnYyx8ldBb2bh7HIQhh1pQUbB59KPqUcNvMjMf8FQfcV0reeCpISYC94Hc1J3LfD2nscsQDoD5Q21oeB5oNQIjGsBRkXUnQQVvuurGT80ySmbv/7WMEFhvQfFwF3+4GcUiIGnCTkvVFYw51VHWoyBVwI0J+SK7pWyDjBqoqfw/oU55P9gFsngoaa+jalNzD5/wNQ0qBZGL8QasOvoGm0cUcVdFXR2cNNcRjtoVgKAA5DFwp/9lowp4jj6HwrhZdqRBzbP50Rnqc6Rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2CftPGsOPhoZrVHWNeuxBgylcilBb+aOxnn0ay/Y/o=;
 b=tYuxtjcULIxcKYGIi+Y702jFu95duaUnBJjKhv1PisLAJ6KIIf/OX9KDlfgHl4jTmMoOrUZtyIPuMx1HJbTyjfRFqrUzUF5WalTE7tFOa+KbSWihBGS6ongE1e9BDSk0uM6RFpP6Uk0StFACrFFqxWHZmM9yLUUGrD1i89EJo5zcgq5wcA+iE3CiHTp5tWI2g0uq9QHkbARi9TMOxYD4uaEDz+10l9suhaTGwfBhxHdIhSnbRX/WxzudSg/UJHrRrmU0R478TGgXmKbXhmOSYKk6MJYWaS5f7Govg5iEl0u8AplkWJElR3gyoti51zje+PE08vB6LFH08m0SEYG49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2CftPGsOPhoZrVHWNeuxBgylcilBb+aOxnn0ay/Y/o=;
 b=fptN+aXOHnGdgM+whNPLR3rB4lY4hDNKimR/UMoOhZQt+TuXOYzPZONm8+q4pWEsil5bOu1RvGqFccOcSetuVUgOWtQR5RrWa8gMVo5YQxFbmNffpzK3em6g2MOXRIzeNQTfUW9dqzZwKuhG2PoimBvVj1Q7Tx2FIHUDbTOq9Mk=
Received: from DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) by
 SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 19:50:39 +0000
Received: from DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02]) by DM4PR12MB6279.namprd12.prod.outlook.com
 ([fe80::ae9d:2bb9:f737:5c02%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 19:50:38 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/mes11: enable MES process/gang load from
 MES local mem
Thread-Topic: [PATCH 6/6] drm/amdgpu/mes11: enable MES process/gang load from
 MES local mem
Thread-Index: AQHdD3B6Ju0uzpX5HEayJMvRmZOTf7ZnKyqY
Date: Fri, 10 Jul 2026 19:50:38 +0000
Message-ID: <DM4PR12MB62797693F9260CF3ED6DAED994FD2@DM4PR12MB6279.namprd12.prod.outlook.com>
References: <20260709065856.472296-1-Prike.Liang@amd.com>
 <20260709065856.472296-6-Prike.Liang@amd.com>
In-Reply-To: <20260709065856.472296-6-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-10T19:50:37.010Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6279:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 41ff3943-66e0-4903-6675-08dedebc8461
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|18002099003|22082099003|8096899003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: QV3LlqLghNBKd3dmgFZAPdWcedVhjxsEPjtvAujFogKOOM7TdX49M0DGoXn2vACfwcc16ezEPdEL1YbZW87Rsfn77fMh+y3pHm4n5Kr0HTpRifOyjVfWjQ52IB4rr3vgrqXli6WtOdp1r/ceSCjeq1p2z/ek9QReQFe/DaF46qmfOX2z2kYxzTPsmraLTrcCJ07uNMroDIIHuVQLksXWk2TQ2G6k/62HoxiZFmvbtTwai4fDyn+gejNOPq2Eb6Tbaf2fQNCHp/HU+rckNuGItAZe/GtDyCKptJZGzYVLNT+rn8w8xBy5QKYCAA5tGDJV1Ca7LCfKGOk11ST/cOtQDWFMl8gN5/fnl4Dg9LcV4oFeFT5GX7MZQG3682Up07jXHiETiXniQ6CDI/pG2UNyujf4Ui5YsrM139iRn4YawKWuQW1FwLn8L29qtMGIgn40XN5eDHiokz1Pl+JNdZHO6VIlIQhRqiRsrPphCHYtcv3B/lHtubExjN2EcJtqmZ/8WK59PFHTHShkD5Vp7DotQc8ZkPZmY6CkXEEyFVCNfkpvfSpzKX6e3G5uF998paIKAkrdLymFbq1kNNjXI8hQpntYSwLemUfuVEEIb1qgLyNpfaS2FFGI0IkbyMPbzPzQ8io5TIZREBp3BvukqSEiPVc/yYEn2egXTDGlbhmkuiSfC5LZnURg69oAc2Ltpxi0JpeXgKiB/YgAagJqspTA3keiETVbxhbML9yhQQmzVL0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(8096899003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KQyU6RnU3B9YT4PvPVaVvAIFQx2Lxs+kOCWwzcPp0+FHk/Vumw8cGEQmtQba?=
 =?us-ascii?Q?1RVXJPfrwVqzDnPBGWKWc9rh58am4FFnoVJf3yz87hyd9650AwSU+DwRclBv?=
 =?us-ascii?Q?hMzzmmrgP3RexAh0lYeqHrjE1MNXAppMJq5zNoV0ughPGSShmEx6h2j0mGDt?=
 =?us-ascii?Q?/n+biFGZTH5WzOISPDYGvOaR5m/vN2M6hDN4X96BOQWVh/SyLhPU4J1AlrqI?=
 =?us-ascii?Q?0YaEkiSkwX3HJKUDN/4hekyuzO3TJc/kFg1mqmcOiTP9bbrTgdn1UaMyMFK7?=
 =?us-ascii?Q?QiYci4/6bH5Hrm71ZMFy8LK/YH/F80qz9H93BmLOX1L5Ed+LrIz/6EOCTzvf?=
 =?us-ascii?Q?4kMDgMXBugd07IrdwM0l/735yv50YlV/vahlTDhiDt27u4sjafdxgU2UC2P0?=
 =?us-ascii?Q?kHRKU76hhXPsEvke97mdwP95J0sCj6lHWVrDReXYODVaGPyQIIUlTNTPpP/r?=
 =?us-ascii?Q?gOJEZcSKBoRpq3LD4nkR5T9yPtNoaRKFlFiXNM44ryP2Br01zopTAu/OuDzR?=
 =?us-ascii?Q?hXi8R/XiXmX+XG2VrP1D5RVt3+fkAjJSsO9PeIY3VG/wv2YkviKeHj1IdpNO?=
 =?us-ascii?Q?KDWEAYffGKQLVoi1tktHyNdt2x/Cerh+s9EAtQcinOQ902Lbib20fSiCHzWF?=
 =?us-ascii?Q?tIv2w32yjUkRsi7hktp7pV0W8VJoOXIVHpsvoBTbF4aJ8n6FUito0ia7tw7K?=
 =?us-ascii?Q?XEnGNs4cW/oprFv4vfE03UCe2gxfyYqqi6CNdinzxyn6ReFpP4YNzMx4LWdp?=
 =?us-ascii?Q?1scrr7iQpBbPFe1L/V4ie5GPiG1BA8YpzECskj/wJ0VUygL9ySHwbk5xgddB?=
 =?us-ascii?Q?PjV/BuR912IeDcQnyVkvod81Lz5OBzXbTCKYdZ/TJnghZZQ5WGl4wdvflyFA?=
 =?us-ascii?Q?KrjYKw0pdYCIs1q+I0ZiONihry+afm+kzUcpMTJpF/BilTFB0i/3sscIKYGM?=
 =?us-ascii?Q?xTfchNAh3e97u7F9PC+eZEQfD37s2v3A/l1xKJZr1BxngNQEaKA7mfjnXB5c?=
 =?us-ascii?Q?44a8ralm6I0i++nyIUkyJR5DufGweF2x9JUOsMOkCgkjBd6HIXrhsWruopnm?=
 =?us-ascii?Q?6MGu6iTnNHChv4T45EscnFV3nuo9a3JDHrZAJt1oJa0/icO9rB74UoSNS73D?=
 =?us-ascii?Q?tolLpU8iuRLyfQNduL59E3rgTgaZAgGwkRV1KIzOjZAKnK1Az+WWYa1fjqaI?=
 =?us-ascii?Q?lyQv5zO8nEevBBXibK1rk7rnyumvF3pvCEfJ88Qn1C1sLp3xiDV2sKtxOblA?=
 =?us-ascii?Q?KiUtdfroUlHOyJpZlgfLMd6wDPY9cTLQVY1W9BMVP60l0FysGoseDIaqArCU?=
 =?us-ascii?Q?BEbU8Xy42OpfPdZMrwgEqgVz4X3EfvxqjYE//xHiFL985PeGjFD4UcTRIIKj?=
 =?us-ascii?Q?ZSIRz5elvzfR7rdXCZCNB24ihlHXhFe3IvejJJrmYhUX/w6Iasj955OO20lu?=
 =?us-ascii?Q?6K2n13s90XXm1GkuS+IeZu9f9iDjYoySNevQi6rI017tkVSjwXVbYE2OP1Dz?=
 =?us-ascii?Q?Z07m4N6BjGy5xFyiswxK4DA0+1LaXyoN8QCOfTrSHMsoYqgc4dd8nTveTkfl?=
 =?us-ascii?Q?Xg7qtvMHetf4h59Pieju8vz84423hPYTdMmP6PZ0d9PZCqFDAa4+Ci2dpNDZ?=
 =?us-ascii?Q?2W9Ud78BNK2gDEqsFm8m6qiT8XikV/+ytDSJm5YMgK3xlv9iaoMJjrCZtHTy?=
 =?us-ascii?Q?+shF/k/HM3tVXccbV8I+lG4RjPJuBq45oL3Z9peu35BfLRIp?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB62797693F9260CF3ED6DAED994FD2DM4PR12MB6279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ff3943-66e0-4903-6675-08dedebc8461
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 19:50:38.8788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15WTqP8rbo7V7OZRHNis7sfx86SizZpcuB7oSYiB9xt2GNCYTkl/xacpBAsmVrn/2/XeT0PlTm4/3sLLP9jUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

--_000_DM4PR12MB62797693F9260CF3ED6DAED994FD2DM4PR12MB6279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

The series is
Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Thursday, July 9, 2026 2:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liang, Prike <=
Prike.Liang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/mes11: enable MES process/gang load from ME=
S local mem

Enable the MES process/gang context load from MES local memory,
this will reduce the MES firmware and driver handshake latency.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index c2129ea6614b..a85387122b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1012,6 +1012,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_m=
es *mes)
         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
+       mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx =3D 1;

         if (amdgpu_mes_log_enable) {
                 mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
@@ -1945,6 +1946,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)
         if (adev->mes.ring[0].sched.ready)
                 goto out;

+       adev->mes.use_rs64mem =3D true;
+
         if (!adev->enable_mes_kiq) {
                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT)=
 {
                         r =3D mes_v11_0_load_microcode(adev,
@@ -1964,11 +1967,12 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block=
 *ip_block)

         /* Allocate GPU buffer for array size query results */
         r =3D amdgpu_mes_rs64mem_init(&adev->mes);
-       if (r)
+       if (r) {
                 dev_warn(adev->dev,
                          "RS64 local memory init failed (%d), "
                          "falling back to system memory path\n", r);
-
+               adev->mes.use_rs64mem =3D false;
+       }
         r =3D mes_v11_0_set_hw_resources(&adev->mes);

         if (r)
@@ -1985,6 +1989,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)
                                  "Failed to query ctx array sizes (%d), "
                                  "disabling RS64 local memory\n", r);
                         /* Continue without optimization - not fatal */
+                       adev->mes.use_rs64mem =3D false;
                 }
         }

--
2.34.1


--_000_DM4PR12MB62797693F9260CF3ED6DAED994FD2DM4PR12MB6279namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
The series is</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 9, 2026 2:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 6/6] drm/amdgpu/mes11: enable MES process/gang load =
from MES local mem</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable the MES process/gang context load from MES =
local memory,<br>
this will reduce the MES firmware and driver handshake latency.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 +++++++--<br>
&nbsp;1 file changed, 7 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index c2129ea6614b..a85387122b11 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1012,6 +1012,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_m=
es *mes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_=
reg_active_poll =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_=
level_process_quantum_check =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.oversub=
scription_timer =3D 50;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.use_rs64mem_for_pr=
oc_gang_ctx =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_mes_log_enable)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1=
;<br>
@@ -1945,6 +1946,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.ring[0].s=
ched.ready)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.use_rs64mem =3D true;<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;enable_mes_k=
iq) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD=
_DIRECT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 mes_v11_0_load_microcode(adev,<br>
@@ -1964,11 +1967,12 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block=
 *ip_block)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Allocate GPU buffer for=
 array size query results */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_rs64mem_i=
nit(&amp;adev-&gt;mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &quot;RS64 local memory init failed (%d), &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &quot;falling back to system memory path\n&quot;, r);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;mes.use_rs64mem =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D mes_v11_0_set_hw_res=
ources(&amp;adev-&gt;mes);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -1985,6 +1989,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to query ctx =
array sizes (%d), &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;disabling RS64 local=
 memory\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Co=
ntinue without optimization - not fatal */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.use=
_rs64mem =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM4PR12MB62797693F9260CF3ED6DAED994FD2DM4PR12MB6279namp_--
