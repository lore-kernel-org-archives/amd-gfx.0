Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D16ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 09:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F69388EA1;
	Mon, 12 Sep 2022 09:01:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5488B88EA1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 09:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS/uwwm90Nf600Zb3uo0Tga/2yqd2ZdHw1RS3zv+4xAf8fIV7wt6TjAL0zCAmlychNtEAwXJIaeeniaeJKa6sRTcmfLROHEewbH2ZwvaeijlVERUhWXTgD9Xc1VYHasZ4hYfdw1Fpk3xcn17HxVz2XVaz2e0we2VHKtC7qD3+sUg0CpMQb7K1DnrZXyGkW00sandwdaWLUOvf6GmLbmK29qgAcmhdeTfbcctaFJSRLruEz61uyHAJFQFE1ja8Fh0EFfANcaVDDdqyV9DBHvqIGom9MR1g8prOLP5ssGJDvSUjfMjkAIq/xgVbG6p1IQUaT2Ap15R6O9st/Ghg1uSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zd35jp8tqqlCo4/H5dGpr1EuRgILNyBUiTCZHFcaqM=;
 b=lmhtWgN6b0SQF3zAmoMY1UxVhmOKp5U1zlcSMUO4LW3l2PVucnR9ZXwM+v+CuhbdzQnuQmjjVbctwdaoE35i0lM0P8f8Iln9/7Zw9kUX/TVJqOrXOG34UvL0R76PB4HVbd1lG74u4srF5r+HK3uePKdiTVFqTY0ja1UTBMBdgyTScJCtO/Hz+kNOqCwpNRs+cloAJpWsnojbDMc0B0D8NRkey4M7faS/7QVmefcBsB/Jf1hFykOIo+Me8Z3VdMQRL0jSzCqy9fDo9Kv0IfBZQu6d40s+QuRBm1iurt1/CrUjcS7sp0L39y0R8KTIZtrY6VAZ53r/M6b9CD3iiprDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zd35jp8tqqlCo4/H5dGpr1EuRgILNyBUiTCZHFcaqM=;
 b=Qk3Op6RAbmhrReWxo/AZ2Dxu6UNc56ZlaAVGUfQThgNdUu1X7ZoIeIn8GdPd3GDR+/bmGxRtrMKrTXhp3i60YDv+gwU8BSziEPhPcG5lTRMIG/AweR/+tlkvhS/IGH99gsUpDzGuDfsDo6j5tAH5k1U35O08Px1U3beENWj9l/c=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 09:01:40 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7c19:cd7:3478:8fe5]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7c19:cd7:3478:8fe5%9]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 09:01:40 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 02/27] drm/amd/display: Optimizations for DML math
Thread-Topic: [PATCH 02/27] drm/amd/display: Optimizations for DML math
Thread-Index: AQHYwt/tFk12LcQ8CkS/HsGcl+WiyK3bhoVf
Date: Mon, 12 Sep 2022 09:01:39 +0000
Message-ID: <CO6PR12MB5489C7CF3966567777C22E2BFC449@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
 <20220907173232.11755-3-pavle.kotarac@amd.com>
In-Reply-To: <20220907173232.11755-3-pavle.kotarac@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-12T09:01:39.219Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|DM4PR12MB6279:EE_
x-ms-office365-filtering-correlation-id: a519d4e6-3f7c-4832-44c7-08da949d67e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIKRX7BBgRYf8YlRU+mt4WtC0eHTRn13ehaXSxr4Iwd/L9mC3JXAtciGEl1uSc82RbEFzzohHA3Gk3/WXBHvVVUl/pWJhlTXbLLEGwy1W4rT26cLk5dCveqdw0eOCUsLIvQqMoKtzQ542s3yXoLNKcuv+Zxf70qfn6RhFm6d78Gash+GyEaLdtZcrlnnZMVkJc/oiIcL+Kwd5dA4egxUsT9GJhxNtfNtRVpC0JjiMMgpwYtjtiVQ8r2srfPNhgMrbdYoVaNnD0hO/Y/qSk+MjcCT+xQsqr4dJ9ICSNhXixfOVzVcPcuB+J5dtsePdc0ydRjJYsvf0skyf5iRA8iF0Mztr1L7uDY9IBl488MD6+nRRycFsuGR7d26SC6eba6YGZ4NrWhy5eV+aR5QutjA5MzKAbtmmGBZa3LJelNJzWFDuqKZN0cw9m7sMExMZg5hbbW9dSupbaUEChotK7nBQyloRfRMWvIJNiJIPAh9cjiZYGTwOjQZM3OSADfF0dqOIz2xyNp1ZlvdSRhZqE4yrwQxvOyMShkafFhmqTANkEV3PWZhNZCJCLCcdC9SDZGfVdpEQjgI1vtsg9SHYKH6KU2U6QziqghLMI9BaG5Y7bwAH7mKStR/yX383DmIdUasILUMEBuFWBjurLymJyXP5fWqinQipyJlbxu34Sg1tMYBGWmcngtFLnKHkv95cjPCH0WR18eMvkm0cE7NQwWXpub7mnWNY+Bex3f9DMtSy89omr2MVJMpJhcaZcNf1S3g/XUH6N6zzsFxZDHYQUt/slm5d8yVwaVAg6kCAA5Onkc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(54906003)(122000001)(38070700005)(110136005)(86362001)(186003)(316002)(83380400001)(71200400001)(19627405001)(91956017)(66476007)(76116006)(30864003)(52536014)(5660300002)(8936002)(8676002)(478600001)(4326008)(64756008)(66946007)(41300700001)(66446008)(9686003)(55016003)(66556008)(7696005)(2906002)(38100700002)(26005)(33656002)(53546011)(6506007)(559001)(579004)(44824005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYowsQcuVjXPy4cKpp65OcQXIJg3VPQ5lbO3YMSsWF0yJndW1Z0tDOHs5/Ml?=
 =?us-ascii?Q?vwHLE8FUWto25VjwIrP/whbQOdtT0+RMXFk7LdVjYl21LkZEJKY/247XoAoB?=
 =?us-ascii?Q?7F6hR44Bu+JWeBED7Fbgc8Cim3SY/cgPlgYBVrIQZeA6wlUTFqvRZdvZ8r+d?=
 =?us-ascii?Q?AGXYWBAtdYC1qoUR+9DvX3X7ZnGqEQ/bbO8IJFhNn6ERYkP0uPn6vq5lCP9g?=
 =?us-ascii?Q?earzlHzmsLj+f9OfPoc8Cordg+CLOrllP/PnRTqa/YFWRLavWW+DnIitTLgN?=
 =?us-ascii?Q?gE3cZmek71jqwoaJ4Bd2+eMBM77GaMkmNrjiMPv9HoNfKcsPqxchYUTJAPzU?=
 =?us-ascii?Q?HWXv4oV9hzliZlwd+GOBcBCfPiDOm6GS+47kWSUAEY25zj6BJhr4sjgzMrS7?=
 =?us-ascii?Q?jArXpvORlx5pEihaVd4etd3HeEFiNbOe3B498rP5iLRjlgov6CP/jbSnvjXR?=
 =?us-ascii?Q?Rnv07jEuVDhwBw52sL3ldIQL+e7x1oIoktIDJI/dXllGPcF8UTYlQos2mnl0?=
 =?us-ascii?Q?a/F3t+k0MljHJhbXXp8BgflP0ChzlwzOaYd5Sb4C9k8fkmpiL7xpazxbsZQo?=
 =?us-ascii?Q?crwSrL1LyRtdLr2eJjmolUpbHhkcsiU+lDy49UwXbggNu/b30bL5iVjXC7V7?=
 =?us-ascii?Q?oCT9veUg0zim6Vpgz9YIrV4X0TsDRLm+J8zPwIn6BMsDfy5lHBcbdgcGncgv?=
 =?us-ascii?Q?R+jdRJBr99QGWoXG3PCwXGT5cnMXI6Hkz9d4RUoS9X+YlFXNzIUgatMrKVG6?=
 =?us-ascii?Q?pcpBDncbEx/RyZBOQZX5vZyOIrgdzphtKoDpVwmKAOUwp3UDT8ezMtwuqgjB?=
 =?us-ascii?Q?7jiPBWmoUrlBwIQdvm97vQQPB7aCDz52MRqrR8TMxZqc4JQgcy6F2kBe9PL1?=
 =?us-ascii?Q?WhPsbtNCjohSx/gQP0pdM8KcjfTN3AE4f+/+1D6OrcktZ/6pi/C8n1KTOz1i?=
 =?us-ascii?Q?fjR44hnLgaJP2Syl3JhFePwpo0HqdpAICNNrLUJ8bmGVdxEtYVtJ7Axj7Ztm?=
 =?us-ascii?Q?DwfKnLSx99S1CBifyT/1ghLYeAbQAglTNp78oI/o9+KnUGd1RaAQEVs0XQqi?=
 =?us-ascii?Q?S3GHVTTlj5hXMiHO+QQHxCi80u+llvwVYis9cGQG/vhEOAShiXd32Qjx53uZ?=
 =?us-ascii?Q?Xa5UJveuGavPdZ4TE9sjcK70U3b8GIj7UC0QQwcb0XLOqnnV08wG7ZOAGrB7?=
 =?us-ascii?Q?0d0hBVPQ7IsE4gN3OcR28bzQD2baDlKR4zQge9oUwYYLV475pRhtz/OjZWb2?=
 =?us-ascii?Q?WR8i+7E3k9MjDtUvkgF4xzZPD2a2Y5bq9lE4I+nSiK2QdJf1bPcej4Tyk17v?=
 =?us-ascii?Q?3dXZRXuBrv9+E/Aj4/vl1b9DBGqdcNxXLhmIUHG7Swvzmh/JRlnb/PKTjfGj?=
 =?us-ascii?Q?frczQYwx+Wq7kL/cd6nvwdyxcyYbFF0MxRM5eevSf/aWKgO0hUb8+MaDq3wW?=
 =?us-ascii?Q?Rbk4sQra5do/gW4HmA27VRIr0KfETHIwQe+9aJF5bwSSJWfvkVNWLDFftFFL?=
 =?us-ascii?Q?7SWgXsZzth91J5BOWvhcYmaWNnA3tL0kALMx8khpKzCz3GYbiwxPq1OZZH1n?=
 =?us-ascii?Q?lE85Sys4zJdiMxJb+Ts=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5489C7CF3966567777C22E2BFC449CO6PR12MB5489namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a519d4e6-3f7c-4832-44c7-08da949d67e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 09:01:39.9848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPIyCGPWjIMtkXzwkHqNLz31EAxH3jflNN1GpQop8F+WYbmGCYcKjlGdLudKfhs/QiewHL52OlvZmCsT6bZOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
Cc: "Wang, Chao-kai
 \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Stupar,
 Nevenko" <Nevenko.Stupar@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB5489C7CF3966567777C22E2BFC449CO6PR12MB5489namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Please remove the file "/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_m=
ode_vba_util_32.c.rej" if it's not necessary.

Thanks,
Wayne
________________________________
From: Kotarac, Pavle <Pavle.Kotarac@amd.com>
Sent: Thursday, September 8, 2022 01:32
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Cyr, Aric <Ar=
ic.Cyr@amd.com>; Stupar, Nevenko <Nevenko.Stupar@amd.com>; Kotarac, Pavle <=
Pavle.Kotarac@amd.com>
Subject: [PATCH 02/27] drm/amd/display: Optimizations for DML math

From: Aric Cyr <aric.cyr@amd.com>

[why]
Conditionals in the DML basic math functions significantly impact mode
enumeration.

[how]
Remove conditionals for floor/ceil operations which are used frequently
in DML and add an assertion for invalid callers using zero granuality.
Fix existing callers that rely on 0 granularity.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../amd/display/dc/dml/calcs/dcn_calc_auto.c  | 22 ++++++-------
 .../amd/display/dc/dml/calcs/dcn_calc_math.c  | 16 +++++-----
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 10 +++---
 .../dc/dml/dcn21/display_mode_vba_21.c        |  6 ++--
 .../dc/dml/dcn30/display_mode_vba_30.c        |  8 ++---
 .../dc/dml/dcn31/display_mode_vba_31.c        |  6 ++--
 .../dc/dml/dcn314/display_mode_vba_314.c      |  6 ++--
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 31 +++++++++----------
 .../dml/dcn32/display_mode_vba_util_32.c.rej  | 12 +++++++
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |  9 ++----
 10 files changed, 65 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_v=
ba_util_32.c.rej

diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c b/dri=
vers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
index 41284e263325..288d22a16cf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
@@ -526,10 +526,10 @@ void mode_support_and_system_configuration(struct dcn=
_bw_internal_vars *v)
                                 }
                                 if (v->max_swath_height_c[k] > 0.0) {
                                         v->swath_width_granularity_c =3D 2=
56.0 /dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / v->max_swath_height=
_c[k];
-                               }
-                               v->rounded_up_max_swath_size_bytes_c =3D (d=
cn_bw_ceil2(v->swath_width_yper_state[i][j][k] / 2.0 - 1.0, v->swath_width_=
granularity_c) + v->swath_width_granularity_c) * v->byte_per_pixel_in_detc[=
k] * v->max_swath_height_c[k];
-                               if (v->source_pixel_format[k] =3D=3D dcn_bw=
_yuv420_sub_10) {
-                                       v->rounded_up_max_swath_size_bytes_=
c =3Ddcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+                                       v->rounded_up_max_swath_size_bytes_=
c =3D (dcn_bw_ceil2(v->swath_width_yper_state[i][j][k] / 2.0 - 1.0, v->swat=
h_width_granularity_c) + v->swath_width_granularity_c) * v->byte_per_pixel_=
in_detc[k] * v->max_swath_height_c[k];
+                                       if (v->source_pixel_format[k] =3D=
=3D dcn_bw_yuv420_sub_10) {
+                                               v->rounded_up_max_swath_siz=
e_bytes_c =3D dcn_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 2=
56;
+                                       }
                                 }
                                 if (v->rounded_up_max_swath_size_bytes_y +=
 v->rounded_up_max_swath_size_bytes_c <=3D v->det_buffer_size_in_kbyte * 10=
24.0 / 2.0) {
                                         v->swath_height_yper_state[i][j][k=
] =3D v->max_swath_height_y[k];
@@ -552,14 +552,14 @@ void mode_support_and_system_configuration(struct dcn=
_bw_internal_vars *v)
                                         v->lines_in_det_chroma =3D v->det_=
buffer_size_in_kbyte * 1024.0 / 3.0 / v->byte_per_pixel_in_dety[k] / (v->sw=
ath_width_yper_state[i][j][k] / 2.0);
                                 }
                                 v->effective_lb_latency_hiding_source_line=
s_luma =3Ddcn_bw_min2(v->max_line_buffer_lines,dcn_bw_floor2(v->line_buffer=
_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j][k] /dcn_b=
w_max2(v->h_ratio[k], 1.0)), 1.0)) - (v->vtaps[k] - 1.0);
-                               v->effective_lb_latency_hiding_source_lines=
_chroma =3Ddcn_bw_min2(v->max_line_buffer_lines,dcn_bw_floor2(v->line_buffe=
r_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j][k] / 2.0=
 /dcn_bw_max2(v->h_ratio[k] / 2.0, 1.0)), 1.0)) - (v->vta_pschroma[k] - 1.0=
);
                                 v->effective_detlb_lines_luma =3Ddcn_bw_fl=
oor2(v->lines_in_det_luma +dcn_bw_min2(v->lines_in_det_luma * v->required_d=
ispclk[i][j] * v->byte_per_pixel_in_dety[k] * v->pscl_factor[k] / v->return=
_bw_per_state[i], v->effective_lb_latency_hiding_source_lines_luma), v->swa=
th_height_yper_state[i][j][k]);
-                               v->effective_detlb_lines_chroma =3Ddcn_bw_f=
loor2(v->lines_in_det_chroma +dcn_bw_min2(v->lines_in_det_chroma * v->requi=
red_dispclk[i][j] * v->byte_per_pixel_in_detc[k] * v->pscl_factor_chroma[k]=
 / v->return_bw_per_state[i], v->effective_lb_latency_hiding_source_lines_c=
hroma), v->swath_height_cper_state[i][j][k]);
                                 if (v->byte_per_pixel_in_detc[k] =3D=3D 0.=
0) {
                                         v->urgent_latency_support_us_per_s=
tate[i][j][k] =3D v->effective_detlb_lines_luma * (v->htotal[k] / v->pixel_=
clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->swath_width_=
yper_state[i][j][k] *dcn_bw_ceil2(v->byte_per_pixel_in_dety[k], 1.0) / (v->=
return_bw_per_state[i] / v->no_of_dpp[i][j][k]);
                                 }
                                 else {
-                                       v->urgent_latency_support_us_per_st=
ate[i][j][k] =3Ddcn_bw_min2(v->effective_detlb_lines_luma * (v->htotal[k] /=
 v->pixel_clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->sw=
ath_width_yper_state[i][j][k] *dcn_bw_ceil2(v->byte_per_pixel_in_dety[k], 1=
.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]), v->effective_det=
lb_lines_chroma * (v->htotal[k] / v->pixel_clock[k]) / (v->v_ratio[k] / 2.0=
) - v->effective_detlb_lines_chroma * v->swath_width_yper_state[i][j][k] / =
2.0 *dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / (v->return_bw_per_st=
ate[i] / v->no_of_dpp[i][j][k]));
+                                       v->effective_lb_latency_hiding_sour=
ce_lines_chroma =3D dcn_bw_min2(v->max_line_buffer_lines, dcn_bw_floor2(v->=
line_buffer_size / v->lb_bit_per_pixel[k] / (v->swath_width_yper_state[i][j=
][k] / 2.0 / dcn_bw_max2(v->h_ratio[k] / 2.0, 1.0)), 1.0)) - (v->vta_pschro=
ma[k] - 1.0);
+                                       v->effective_detlb_lines_chroma =3D=
 dcn_bw_floor2(v->lines_in_det_chroma + dcn_bw_min2(v->lines_in_det_chroma =
* v->required_dispclk[i][j] * v->byte_per_pixel_in_detc[k] * v->pscl_factor=
_chroma[k] / v->return_bw_per_state[i], v->effective_lb_latency_hiding_sour=
ce_lines_chroma), v->swath_height_cper_state[i][j][k]);
+                                       v->urgent_latency_support_us_per_st=
ate[i][j][k] =3D dcn_bw_min2(v->effective_detlb_lines_luma * (v->htotal[k] =
/ v->pixel_clock[k]) / v->v_ratio[k] - v->effective_detlb_lines_luma * v->s=
wath_width_yper_state[i][j][k] * dcn_bw_ceil2(v->byte_per_pixel_in_dety[k],=
 1.0) / (v->return_bw_per_state[i] / v->no_of_dpp[i][j][k]), v->effective_d=
etlb_lines_chroma * (v->htotal[k] / v->pixel_clock[k]) / (v->v_ratio[k] / 2=
.0) - v->effective_detlb_lines_chroma * v->swath_width_yper_state[i][j][k] =
/ 2.0 * dcn_bw_ceil2(v->byte_per_pixel_in_detc[k], 2.0) / (v->return_bw_per=
_state[i] / v->no_of_dpp[i][j][k]));
                                 }
                         }
                 }
@@ -1146,10 +1146,10 @@ void display_pipe_configuration(struct dcn_bw_inter=
nal_vars *v)
                 }
                 if (v->maximum_swath_height_c > 0.0) {
                         v->swath_width_granularity_c =3D 256.0 /dcn_bw_cei=
l2(v->byte_per_pix_detc, 2.0) / v->maximum_swath_height_c;
-               }
-               v->rounded_up_max_swath_size_bytes_c =3D (dcn_bw_ceil2(v->s=
wath_width / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_width_gran=
ularity_c) * v->byte_per_pix_detc * v->maximum_swath_height_c;
-               if (v->source_pixel_format[k] =3D=3D dcn_bw_yuv420_sub_10) =
{
-                       v->rounded_up_max_swath_size_bytes_c =3Ddcn_bw_ceil=
2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+                       v->rounded_up_max_swath_size_bytes_c =3D (dcn_bw_ce=
il2(v->swath_width / 2.0 - 1.0, v->swath_width_granularity_c) + v->swath_wi=
dth_granularity_c) * v->byte_per_pix_detc * v->maximum_swath_height_c;
+                       if (v->source_pixel_format[k] =3D=3D dcn_bw_yuv420_=
sub_10) {
+                               v->rounded_up_max_swath_size_bytes_c =3D dc=
n_bw_ceil2(v->rounded_up_max_swath_size_bytes_c, 256.0) + 256;
+                       }
                 }
                 if (v->rounded_up_max_swath_size_bytes_y + v->rounded_up_m=
ax_swath_size_bytes_c <=3D v->det_buffer_size_in_kbyte * 1024.0 / 2.0) {
                         v->swath_height_y[k] =3D v->maximum_swath_height_y=
;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c b/dri=
vers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
index 07d18e78de49..cac72413a097 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
@@ -23,6 +23,7 @@
  *
  */

+#include "os_types.h"
 #include "dcn_calc_math.h"

 #define isNaN(number) ((number) !=3D (number))
@@ -69,8 +70,8 @@ float dcn_bw_max2(const float arg1, const float arg2)

 float dcn_bw_floor2(const float arg, const float significance)
 {
-       if (significance =3D=3D 0)
-               return 0;
+       ASSERT(significance !=3D 0);
+
         return ((int) (arg / significance)) * significance;
 }
 float dcn_bw_floor(const float arg)
@@ -80,17 +81,14 @@ float dcn_bw_floor(const float arg)

 float dcn_bw_ceil(const float arg)
 {
-       float flr =3D dcn_bw_floor2(arg, 1);
-
-       return flr + 0.00001 >=3D arg ? arg : flr + 1;
+       return (int) (arg + 0.99999);
 }

 float dcn_bw_ceil2(const float arg, const float significance)
 {
-       float flr =3D dcn_bw_floor2(arg, significance);
-       if (significance =3D=3D 0)
-               return 0;
-       return flr + 0.00001 >=3D arg ? arg : flr + significance;
+       ASSERT(significance !=3D 0);
+
+       return ((int) (arg / significance + 0.99999)) * significance;
 }

 float dcn_bw_max3(float v1, float v2, float v3)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 63bbdf8b8678..edd098c7eb92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -4478,17 +4478,17 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(=
struct display_mode_lib *mode
                                                 locals->EffectiveLBLatency=
HidingSourceLinesLuma),
                                                 locals->SwathHeightYPerSta=
te[i][j][k]);

-                               locals->EffectiveDETLBLinesChroma =3D dml_f=
loor(locals->LinesInDETChroma + dml_min(
-                                               locals->LinesInDETChroma * =
locals->RequiredDISPCLK[i][j] * locals->BytePerPixelInDETC[k] *
-                                               locals->PSCL_FACTOR_CHROMA[=
k] / locals->ReturnBWPerState[i][0],
-                                               locals->EffectiveLBLatencyH=
idingSourceLinesChroma),
-                                               locals->SwathHeightCPerStat=
e[i][j][k]);

                                 if (locals->BytePerPixelInDETC[k] =3D=3D 0=
) {
                                         locals->UrgentLatencySupportUsPerS=
tate[i][j][k] =3D locals->EffectiveDETLBLinesLuma * (locals->HTotal[k] / lo=
cals->PixelClock[k])
                                                         / locals->VRatio[k=
] - locals->EffectiveDETLBLinesLuma * locals->SwathWidthYPerState[i][j][k] =
*
                                                                 dml_ceil(l=
ocals->BytePerPixelInDETY[k], 1) / (locals->ReturnBWPerState[i][0] / locals=
->NoOfDPP[i][j][k]);
                                 } else {
+                                       locals->EffectiveDETLBLinesChroma =
=3D dml_floor(locals->LinesInDETChroma + dml_min(
+                                                       locals->LinesInDETC=
hroma * locals->RequiredDISPCLK[i][j] * locals->BytePerPixelInDETC[k] *
+                                                       locals->PSCL_FACTOR=
_CHROMA[k] / locals->ReturnBWPerState[i][0],
+                                                       locals->EffectiveLB=
LatencyHidingSourceLinesChroma),
+                                                       locals->SwathHeight=
CPerState[i][j][k]);
                                         locals->UrgentLatencySupportUsPerS=
tate[i][j][k] =3D dml_min(
                                                 locals->EffectiveDETLBLine=
sLuma * (locals->HTotal[k] / locals->PixelClock[k])
                                                 / locals->VRatio[k] - loca=
ls->EffectiveDETLBLinesLuma * locals->SwathWidthYPerState[i][j][k] *
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 8a7485e21d53..d40d32e380f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -806,10 +806,12 @@ static bool CalculatePrefetchSchedule(

         if (myPipe->SourceScan =3D=3D dm_horz) {
                 *swath_width_luma_ub =3D dml_ceil(SwathWidthY - 1, myPipe-=
>BlockWidth256BytesY) + myPipe->BlockWidth256BytesY;
-               *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2 - 1, my=
Pipe->BlockWidth256BytesC) + myPipe->BlockWidth256BytesC;
+               if (myPipe->BlockWidth256BytesC > 0)
+                       *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2=
 - 1, myPipe->BlockWidth256BytesC) + myPipe->BlockWidth256BytesC;
         } else {
                 *swath_width_luma_ub =3D dml_ceil(SwathWidthY - 1, myPipe-=
>BlockHeight256BytesY) + myPipe->BlockHeight256BytesY;
-               *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2 - 1, my=
Pipe->BlockHeight256BytesC) + myPipe->BlockHeight256BytesC;
+               if (myPipe->BlockWidth256BytesC > 0)
+                       *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2=
 - 1, myPipe->BlockHeight256BytesC) + myPipe->BlockHeight256BytesC;
         }

         prefetch_bw_oto =3D (PrefetchSourceLinesY * *swath_width_luma_ub *=
 dml_ceil(BytePerPixelDETY, 1) + PrefetchSourceLinesC * *swath_width_chroma=
_ub * dml_ceil(BytePerPixelDETC, 2)) / Tsw_oto;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index b7fa003ffe06..c117a9724ae1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -6322,10 +6322,6 @@ static void CalculateSwathWidth(

         for (k =3D 0; k < NumberOfActivePlanes; ++k) {
                 enum odm_combine_mode MainPlaneODMCombine =3D 0;
-               surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k], Read256By=
tesBlockWidthY[k]);
-               surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Read256=
BytesBlockHeightY[k]);
-               surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read256By=
tesBlockWidthC[k]);
-               surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256=
BytesBlockHeightC[k]);

                 if (SourceScan[k] !=3D dm_vert) {
                         SwathWidthSingleDPPY[k] =3D ViewportWidth[k];
@@ -6365,8 +6361,6 @@ static void CalculateSwathWidth(

                 surface_width_ub_l  =3D dml_ceil(SurfaceWidthY[k], Read256=
BytesBlockWidthY[k]);
                 surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Read25=
6BytesBlockHeightY[k]);
-               surface_width_ub_c  =3D dml_ceil(SurfaceWidthC[k], Read256B=
ytesBlockWidthC[k]);
-               surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256=
BytesBlockHeightC[k]);

                 if (SourceScan[k] !=3D dm_vert) {
                         MaximumSwathHeightY[k] =3D Read256BytesBlockHeight=
Y[k];
@@ -6374,6 +6368,7 @@ static void CalculateSwathWidth(
                         swath_width_luma_ub[k] =3D dml_min(surface_width_u=
b_l, (long) dml_ceil(SwathWidthY[k] - 1,
                                         Read256BytesBlockWidthY[k]) + Read=
256BytesBlockWidthY[k]);
                         if (BytePerPixC[k] > 0) {
+                               surface_width_ub_c  =3D dml_ceil(SurfaceWid=
thC[k], Read256BytesBlockWidthC[k]);
                                 swath_width_chroma_ub[k] =3D dml_min(surfa=
ce_width_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,
                                                 Read256BytesBlockWidthC[k]=
) + Read256BytesBlockWidthC[k]);
                         } else {
@@ -6385,6 +6380,7 @@ static void CalculateSwathWidth(
                         swath_width_luma_ub[k] =3D dml_min(surface_height_=
ub_l, (long) dml_ceil(SwathWidthY[k] - 1,
                                         Read256BytesBlockHeightY[k]) + Rea=
d256BytesBlockHeightY[k]);
                         if (BytePerPixC[k] > 0) {
+                               surface_height_ub_c =3D dml_ceil(SurfaceHei=
ghtC[k], Read256BytesBlockHeightC[k]);
                                 swath_width_chroma_ub[k] =3D dml_min(surfa=
ce_height_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,
                                                 Read256BytesBlockHeightC[k=
]) + Read256BytesBlockHeightC[k]);
                         } else {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index d63b4209b14c..8753f94bdd79 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -6933,8 +6933,6 @@ static void CalculateSwathWidth(
                 {
                 int surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k], Read=
256BytesBlockWidthY[k]);
                 int surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Re=
ad256BytesBlockHeightY[k]);
-               int surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read2=
56BytesBlockWidthC[k]);
-               int surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Rea=
d256BytesBlockHeightC[k]);

 #ifdef __DML_VBA_DEBUG__
                 dml_print("DML::%s: k=3D%d surface_width_ub_l=3D%0d\n", __=
func__, k, surface_width_ub_l);
@@ -6945,6 +6943,8 @@ static void CalculateSwathWidth(
                         MaximumSwathHeightC[k] =3D Read256BytesBlockHeight=
C[k];
                         swath_width_luma_ub[k] =3D dml_min(surface_width_u=
b_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockWidthY[k]) + Read2=
56BytesBlockWidthY[k]);
                         if (BytePerPixC[k] > 0) {
+                               int surface_width_ub_c =3D dml_ceil(Surface=
WidthC[k], Read256BytesBlockWidthC[k]);
+
                                 swath_width_chroma_ub[k] =3D dml_min(
                                                 surface_width_ub_c,
                                                 (int) dml_ceil(SwathWidthC=
[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidthC[k]);
@@ -6956,6 +6956,8 @@ static void CalculateSwathWidth(
                         MaximumSwathHeightC[k] =3D Read256BytesBlockWidthC=
[k];
                         swath_width_luma_ub[k] =3D dml_min(surface_height_=
ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockHeightY[k]) + Rea=
d256BytesBlockHeightY[k]);
                         if (BytePerPixC[k] > 0) {
+                               int surface_height_ub_c =3D dml_ceil(Surfac=
eHeightC[k], Read256BytesBlockHeightC[k]);
+
                                 swath_width_chroma_ub[k] =3D dml_min(
                                                 surface_height_ub_c,
                                                 (int) dml_ceil(SwathWidthC=
[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHeightC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index fc4d7474c111..503d9ede0ac1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -7049,8 +7049,6 @@ static void CalculateSwathWidth(
                 {
                 int surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k], Read=
256BytesBlockWidthY[k]);
                 int surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Re=
ad256BytesBlockHeightY[k]);
-               int surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read2=
56BytesBlockWidthC[k]);
-               int surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Rea=
d256BytesBlockHeightC[k]);

 #ifdef __DML_VBA_DEBUG__
                 dml_print("DML::%s: k=3D%d surface_width_ub_l=3D%0d\n", __=
func__, k, surface_width_ub_l);
@@ -7061,6 +7059,8 @@ static void CalculateSwathWidth(
                         MaximumSwathHeightC[k] =3D Read256BytesBlockHeight=
C[k];
                         swath_width_luma_ub[k] =3D dml_min(surface_width_u=
b_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockWidthY[k]) + Read2=
56BytesBlockWidthY[k]);
                         if (BytePerPixC[k] > 0) {
+                               int surface_width_ub_c =3D dml_ceil(Surface=
WidthC[k], Read256BytesBlockWidthC[k]);
+
                                 swath_width_chroma_ub[k] =3D dml_min(
                                                 surface_width_ub_c,
                                                 (int) dml_ceil(SwathWidthC=
[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidthC[k]);
@@ -7072,6 +7072,8 @@ static void CalculateSwathWidth(
                         MaximumSwathHeightC[k] =3D Read256BytesBlockWidthC=
[k];
                         swath_width_luma_ub[k] =3D dml_min(surface_height_=
ub_l, (int) dml_ceil(SwathWidthY[k] - 1, Read256BytesBlockHeightY[k]) + Rea=
d256BytesBlockHeightY[k]);
                         if (BytePerPixC[k] > 0) {
+                               int surface_height_ub_c =3D dml_ceil(Surfac=
eHeightC[k], Read256BytesBlockHeightC[k]);
+
                                 swath_width_chroma_ub[k] =3D dml_min(
                                                 surface_height_ub_c,
                                                 (int) dml_ceil(SwathWidthC=
[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHeightC[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util=
_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index dc501ee7d01a..c385c54832cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -719,8 +719,8 @@ void dml32_CalculateSwathWidth(

         unsigned int surface_width_ub_l;
         unsigned int surface_height_ub_l;
-       unsigned int surface_width_ub_c;
-       unsigned int surface_height_ub_c;
+       unsigned int surface_width_ub_c =3D 0;
+       unsigned int surface_height_ub_c =3D 0;

 #ifdef __DML_VBA_DEBUG__
         dml_print("DML::%s: ForceSingleDPP =3D %d\n", __func__, ForceSingl=
eDPP);
@@ -784,21 +784,6 @@ void dml32_CalculateSwathWidth(

                 surface_width_ub_l  =3D dml_ceil(SurfaceWidthY[k], Read256=
BytesBlockWidthY[k]);
                 surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Read25=
6BytesBlockHeightY[k]);
-               surface_width_ub_c  =3D dml_ceil(SurfaceWidthC[k], Read256B=
ytesBlockWidthC[k]);
-               surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256=
BytesBlockHeightC[k]);
-
-#ifdef __DML_VBA_DEBUG__
-               dml_print("DML::%s: k=3D%d surface_width_ub_l=3D%0d\n", __f=
unc__, k, surface_width_ub_l);
-               dml_print("DML::%s: k=3D%d surface_height_ub_l=3D%0d\n", __=
func__, k, surface_height_ub_l);
-               dml_print("DML::%s: k=3D%d surface_width_ub_c=3D%0d\n", __f=
unc__, k, surface_width_ub_c);
-               dml_print("DML::%s: k=3D%d surface_height_ub_c=3D%0d\n", __=
func__, k, surface_height_ub_c);
-               dml_print("DML::%s: k=3D%d Read256BytesBlockWidthY=3D%0d\n"=
, __func__, k, Read256BytesBlockWidthY[k]);
-               dml_print("DML::%s: k=3D%d Read256BytesBlockHeightY=3D%0d\n=
", __func__, k, Read256BytesBlockHeightY[k]);
-               dml_print("DML::%s: k=3D%d Read256BytesBlockWidthC=3D%0d\n"=
, __func__, k, Read256BytesBlockWidthC[k]);
-               dml_print("DML::%s: k=3D%d Read256BytesBlockHeightC=3D%0d\n=
", __func__, k, Read256BytesBlockHeightC[k]);
-               dml_print("DML::%s: k=3D%d ViewportStationary=3D%0d\n", __f=
unc__, k, ViewportStationary[k]);
-               dml_print("DML::%s: k=3D%d DPPPerSurface=3D%0d\n", __func__=
, k, DPPPerSurface[k]);
-#endif

                 if (!IsVertical(SourceRotation[k])) {
                         MaximumSwathHeightY[k] =3D Read256BytesBlockHeight=
Y[k];
@@ -818,6 +803,7 @@ void dml32_CalculateSwathWidth(
                                                                 Read256Byt=
esBlockWidthY[k]);
                         }
                         if (BytePerPixC[k] > 0) {
+                               surface_width_ub_c  =3D dml_ceil(SurfaceWid=
thC[k], Read256BytesBlockWidthC[k]);
                                 if (ViewportStationary[k] && DPPPerSurface=
[k] =3D=3D 1) {
                                         swath_width_chroma_ub[k] =3D dml_m=
in(surface_width_ub_c,
                                                         dml_floor(Viewport=
XStartC[k] + SwathWidthC[k] +
@@ -848,6 +834,7 @@ void dml32_CalculateSwathWidth(
                                                 Read256BytesBlockHeightY[k=
]) + Read256BytesBlockHeightY[k]);
                         }
                         if (BytePerPixC[k] > 0) {
+                               surface_height_ub_c =3D dml_ceil(SurfaceHei=
ghtC[k], Read256BytesBlockHeightC[k]);
                                 if (ViewportStationary[k] && DPPPerSurface=
[k] =3D=3D 1) {
                                         swath_width_chroma_ub[k] =3D dml_m=
in(surface_height_ub_c,
                                                         dml_floor(Viewport=
YStartC[k] + SwathWidthC[k] +
@@ -866,6 +853,16 @@ void dml32_CalculateSwathWidth(
                 }

 #ifdef __DML_VBA_DEBUG__
+               dml_print("DML::%s: k=3D%d surface_width_ub_l=3D%0d\n", __f=
unc__, k, surface_width_ub_l);
+               dml_print("DML::%s: k=3D%d surface_height_ub_l=3D%0d\n", __=
func__, k, surface_height_ub_l);
+               dml_print("DML::%s: k=3D%d surface_width_ub_c=3D%0d\n", __f=
unc__, k, surface_width_ub_c);
+               dml_print("DML::%s: k=3D%d surface_height_ub_c=3D%0d\n", __=
func__, k, surface_height_ub_c);
+               dml_print("DML::%s: k=3D%d Read256BytesBlockWidthY=3D%0d\n"=
, __func__, k, Read256BytesBlockWidthY[k]);
+               dml_print("DML::%s: k=3D%d Read256BytesBlockHeightY=3D%0d\n=
", __func__, k, Read256BytesBlockHeightY[k]);
+               dml_print("DML::%s: k=3D%d Read256BytesBlockWidthC=3D%0d\n"=
, __func__, k, Read256BytesBlockWidthC[k]);
+               dml_print("DML::%s: k=3D%d Read256BytesBlockHeightC=3D%0d\n=
", __func__, k, Read256BytesBlockHeightC[k]);
+               dml_print("DML::%s: k=3D%d ViewportStationary=3D%0d\n", __f=
unc__, k, ViewportStationary[k]);
+               dml_print("DML::%s: k=3D%d DPPPerSurface=3D%0d\n", __func__=
, k, DPPPerSurface[k]);
                 dml_print("DML::%s: k=3D%d swath_width_luma_ub=3D%0d\n", _=
_func__, k, swath_width_luma_ub[k]);
                 dml_print("DML::%s: k=3D%d swath_width_chroma_ub=3D%0d\n",=
 __func__, k, swath_width_chroma_ub[k]);
                 dml_print("DML::%s: k=3D%d MaximumSwathHeightY=3D%0d\n", _=
_func__, k, MaximumSwathHeightY[k]);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util=
_32.c.rej b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_=
32.c.rej
new file mode 100644
index 000000000000..dff2badbf820
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.r=
ej
@@ -0,0 +1,12 @@
+diff a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c     =
  (rejected hunks)
+@@ -727,8 +727,8 @@ void dml32_CalculateSwathWidth(
+        enum odm_combine_mode MainSurfaceODMMode;
+        unsigned int surface_width_ub_l;
+        unsigned int surface_height_ub_l;
+-      unsigned int surface_width_ub_c;
+-      unsigned int surface_height_ub_c;
++      unsigned int surface_width_ub_c =3D 0;
++      unsigned int surface_height_ub_c =3D 0;
+        unsigned int k, j;
+
+ #ifdef __DML_VBA_DEBUG__
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers=
/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
index 479d7d83220c..072bd0539605 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h
@@ -76,14 +76,9 @@ static inline double dml_floor(double a, double granular=
ity)

 static inline double dml_round(double a)
 {
-       double round_pt =3D 0.5;
-       double ceil =3D dml_ceil(a, 1);
-       double floor =3D dml_floor(a, 1);
+       const double round_pt =3D 0.5;

-       if (a - floor >=3D round_pt)
-               return ceil;
-       else
-               return floor;
+       return dml_floor(a + round_pt, 1);
 }

 /* float
--
2.34.1


--_000_CO6PR12MB5489C7CF3966567777C22E2BFC449CO6PR12MB5489namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Please remove the file &quot;<span style=3D"color: rgb(0, 0, 0); font-famil=
y: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Se=
goe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Ne=
ue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(255, 255,=
 255); display: inline !important;">/drivers/gpu/drm/amd/display/dc/dml/dcn=
32/display_mode_vba_util_32.c.rej&quot;
 if it's not necessary.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 14.6667px; background-color: rgb(255, 255, 255); display: inline !impor=
tant;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 14.6667px; background-color: rgb(255, 255, 255); display: inline !impor=
tant;">Thanks,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 14.6667px; background-color: rgb(255, 255, 255); display: inline !impor=
tant;">Wayne</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kotarac, Pavle &lt;Pa=
vle.Kotarac@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 8, 2022 01:32<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wa=
yne &lt;Wayne.Lin@amd.com&gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.=
com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Kotarac, Pavle &lt;Pav=
le.Kotarac@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt=
;;
 Cyr, Aric &lt;Aric.Cyr@amd.com&gt;; Stupar, Nevenko &lt;Nevenko.Stupar@amd=
.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> [PATCH 02/27] drm/amd/display: Optimizations for DML math</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Aric Cyr &lt;aric.cyr@amd.com&gt;<br>
<br>
[why]<br>
Conditionals in the DML basic math functions significantly impact mode<br>
enumeration.<br>
<br>
[how]<br>
Remove conditionals for floor/ceil operations which are used frequently<br>
in DML and add an assertion for invalid callers using zero granuality.<br>
Fix existing callers that rely on 0 granularity.<br>
<br>
Reviewed-by: Nevenko Stupar &lt;Nevenko.Stupar@amd.com&gt;<br>
Acked-by: Pavle Kotarac &lt;Pavle.Kotarac@amd.com&gt;<br>
Signed-off-by: Aric Cyr &lt;aric.cyr@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/dc/dml/calcs/dcn_calc_auto.c&nbsp; | 22 ++++++-------=
<br>
&nbsp;.../amd/display/dc/dml/calcs/dcn_calc_math.c&nbsp; | 16 +++++-----<br=
>
&nbsp;.../dc/dml/dcn20/display_mode_vba_20v2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 10 +++---<br>
&nbsp;.../dc/dml/dcn21/display_mode_vba_21.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 ++--<br>
&nbsp;.../dc/dml/dcn30/display_mode_vba_30.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 8 ++---<br>
&nbsp;.../dc/dml/dcn31/display_mode_vba_31.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 ++--<br>
&nbsp;.../dc/dml/dcn314/display_mode_vba_314.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 6 ++--<br>
&nbsp;.../dc/dml/dcn32/display_mode_vba_util_32.c&nbsp;&nbsp; | 31 ++++++++=
+----------<br>
&nbsp;.../dml/dcn32/display_mode_vba_util_32.c.rej&nbsp; | 12 +++++++<br>
&nbsp;.../drm/amd/display/dc/dml/dml_inline_defs.h&nbsp; |&nbsp; 9 ++----<b=
r>
&nbsp;10 files changed, 65 insertions(+), 61 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_m=
ode_vba_util_32.c.rej<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c b/dri=
vers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
index 41284e263325..288d22a16cf2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c<br>
@@ -526,10 +526,10 @@ void mode_support_and_system_configuration(struct dcn=
_bw_internal_vars *v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;max_swath_height_c[k] =
&gt; 0.0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; v-&gt;swath_width_granularity_c =3D 256.0 /dcn_bw_ceil2(v-&=
gt;byte_per_pixel_in_detc[k], 2.0) / v-&gt;max_swath_height_c[k];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;rounded_up_max_swath_size_bytes_c =3D=
 (dcn_bw_ceil2(v-&gt;swath_width_yper_state[i][j][k] / 2.0 - 1.0, v-&gt;swa=
th_width_granularity_c) + v-&gt;swath_width_granularity_c) * v-&gt;byte_per=
_pixel_in_detc[k] * v-&gt;max_swath_height_c[k];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;source_pixel_format[k] =3D=3D dcn=
_bw_yuv420_sub_10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;rounded_up_max_swath_size_bytes_c =3Ddcn_bw_ceil2(v-&gt;rounded_=
up_max_swath_size_bytes_c, 256.0) + 256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;rounded_up_max_swath_size_bytes_c =3D (dcn_bw_ceil2(v-&gt;swath_=
width_yper_state[i][j][k] / 2.0 - 1.0, v-&gt;swath_width_granularity_c) + v=
-&gt;swath_width_granularity_c) * v-&gt;byte_per_pixel_in_detc[k] * v-&gt;m=
ax_swath_height_c[k];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (v-&gt;source_pixel_format[k] =3D=3D dcn_bw_yuv420_sub_10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;rounded_up_max_s=
wath_size_bytes_c =3D dcn_bw_ceil2(v-&gt;rounded_up_max_swath_size_bytes_c,=
 256.0) + 256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;rounded_up_max_swath_s=
ize_bytes_y + v-&gt;rounded_up_max_swath_size_bytes_c &lt;=3D v-&gt;det_buf=
fer_size_in_kbyte * 1024.0 / 2.0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; v-&gt;swath_height_yper_state[i][j][k] =3D v-&gt;max_swath_=
height_y[k];<br>
@@ -552,14 +552,14 @@ void mode_support_and_system_configuration(struct dcn=
_bw_internal_vars *v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; v-&gt;lines_in_det_chroma =3D v-&gt;det_buffer_size_in_kbyt=
e * 1024.0 / 3.0 / v-&gt;byte_per_pixel_in_dety[k] / (v-&gt;swath_width_ype=
r_state[i][j][k] / 2.0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;effective_lb_latency_hidin=
g_source_lines_luma =3Ddcn_bw_min2(v-&gt;max_line_buffer_lines,dcn_bw_floor=
2(v-&gt;line_buffer_size / v-&gt;lb_bit_per_pixel[k] / (v-&gt;swath_width_y=
per_state[i][j][k] /dcn_bw_max2(v-&gt;h_ratio[k], 1.0)), 1.0))
 - (v-&gt;vtaps[k] - 1.0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;effective_lb_latency_hiding_source_li=
nes_chroma =3Ddcn_bw_min2(v-&gt;max_line_buffer_lines,dcn_bw_floor2(v-&gt;l=
ine_buffer_size / v-&gt;lb_bit_per_pixel[k] / (v-&gt;swath_width_yper_state=
[i][j][k] / 2.0 /dcn_bw_max2(v-&gt;h_ratio[k] / 2.0,
 1.0)), 1.0)) - (v-&gt;vta_pschroma[k] - 1.0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;effective_detlb_lines_luma=
 =3Ddcn_bw_floor2(v-&gt;lines_in_det_luma +dcn_bw_min2(v-&gt;lines_in_det_l=
uma * v-&gt;required_dispclk[i][j] * v-&gt;byte_per_pixel_in_dety[k] * v-&g=
t;pscl_factor[k] / v-&gt;return_bw_per_state[i], v-&gt;effective_lb_latency=
_hiding_source_lines_luma),
 v-&gt;swath_height_yper_state[i][j][k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;effective_detlb_lines_chroma =3Ddcn_b=
w_floor2(v-&gt;lines_in_det_chroma +dcn_bw_min2(v-&gt;lines_in_det_chroma *=
 v-&gt;required_dispclk[i][j] * v-&gt;byte_per_pixel_in_detc[k] * v-&gt;psc=
l_factor_chroma[k] / v-&gt;return_bw_per_state[i], v-&gt;effective_lb_laten=
cy_hiding_source_lines_chroma),
 v-&gt;swath_height_cper_state[i][j][k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;byte_per_pixel_in_detc=
[k] =3D=3D 0.0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; v-&gt;urgent_latency_support_us_per_state[i][j][k] =3D v-&g=
t;effective_detlb_lines_luma * (v-&gt;htotal[k] / v-&gt;pixel_clock[k]) / v=
-&gt;v_ratio[k] - v-&gt;effective_detlb_lines_luma * v-&gt;swath_width_yper=
_state[i][j][k] *dcn_bw_ceil2(v-&gt;byte_per_pixel_in_dety[k],
 1.0) / (v-&gt;return_bw_per_state[i] / v-&gt;no_of_dpp[i][j][k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;urgent_latency_support_us_per_state[i][j][k] =3Ddcn_bw_min2(v-&g=
t;effective_detlb_lines_luma * (v-&gt;htotal[k] / v-&gt;pixel_clock[k]) / v=
-&gt;v_ratio[k] - v-&gt;effective_detlb_lines_luma * v-&gt;swath_width_yper=
_state[i][j][k] *dcn_bw_ceil2(v-&gt;byte_per_pixel_in_dety[k],
 1.0) / (v-&gt;return_bw_per_state[i] / v-&gt;no_of_dpp[i][j][k]), v-&gt;ef=
fective_detlb_lines_chroma * (v-&gt;htotal[k] / v-&gt;pixel_clock[k]) / (v-=
&gt;v_ratio[k] / 2.0) - v-&gt;effective_detlb_lines_chroma * v-&gt;swath_wi=
dth_yper_state[i][j][k] / 2.0 *dcn_bw_ceil2(v-&gt;byte_per_pixel_in_detc[k]=
,
 2.0) / (v-&gt;return_bw_per_state[i] / v-&gt;no_of_dpp[i][j][k]));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;effective_lb_latency_hiding_source_lines_chroma =3D dcn_bw_min2(=
v-&gt;max_line_buffer_lines, dcn_bw_floor2(v-&gt;line_buffer_size / v-&gt;l=
b_bit_per_pixel[k] / (v-&gt;swath_width_yper_state[i][j][k] / 2.0 / dcn_bw_=
max2(v-&gt;h_ratio[k]
 / 2.0, 1.0)), 1.0)) - (v-&gt;vta_pschroma[k] - 1.0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;effective_detlb_lines_chroma =3D dcn_bw_floor2(v-&gt;lines_in_de=
t_chroma + dcn_bw_min2(v-&gt;lines_in_det_chroma * v-&gt;required_dispclk[i=
][j] * v-&gt;byte_per_pixel_in_detc[k] * v-&gt;pscl_factor_chroma[k] / v-&g=
t;return_bw_per_state[i],
 v-&gt;effective_lb_latency_hiding_source_lines_chroma), v-&gt;swath_height=
_cper_state[i][j][k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; v-&gt;urgent_latency_support_us_per_state[i][j][k] =3D dcn_bw_min2(v-&=
gt;effective_detlb_lines_luma * (v-&gt;htotal[k] / v-&gt;pixel_clock[k]) / =
v-&gt;v_ratio[k] - v-&gt;effective_detlb_lines_luma * v-&gt;swath_width_ype=
r_state[i][j][k] * dcn_bw_ceil2(v-&gt;byte_per_pixel_in_dety[k],
 1.0) / (v-&gt;return_bw_per_state[i] / v-&gt;no_of_dpp[i][j][k]), v-&gt;ef=
fective_detlb_lines_chroma * (v-&gt;htotal[k] / v-&gt;pixel_clock[k]) / (v-=
&gt;v_ratio[k] / 2.0) - v-&gt;effective_detlb_lines_chroma * v-&gt;swath_wi=
dth_yper_state[i][j][k] / 2.0 * dcn_bw_ceil2(v-&gt;byte_per_pixel_in_detc[k=
],
 2.0) / (v-&gt;return_bw_per_state[i] / v-&gt;no_of_dpp[i][j][k]));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1146,10 +1146,10 @@ void display_pipe_configuration(struct dcn_bw_inter=
nal_vars *v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (v-&gt;maximum_swath_height_c &gt; 0.0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt=
;swath_width_granularity_c =3D 256.0 /dcn_bw_ceil2(v-&gt;byte_per_pix_detc,=
 2.0) / v-&gt;maximum_swath_height_c;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; v-&gt;rounded_up_max_swath_size_bytes_c =3D (dcn_bw_ceil2(v-&gt;=
swath_width / 2.0 - 1.0, v-&gt;swath_width_granularity_c) + v-&gt;swath_wid=
th_granularity_c) * v-&gt;byte_per_pix_detc * v-&gt;maximum_swath_height_c;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (v-&gt;source_pixel_format[k] =3D=3D dcn_bw_yuv420_sub_10) {<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;rounded_up=
_max_swath_size_bytes_c =3Ddcn_bw_ceil2(v-&gt;rounded_up_max_swath_size_byt=
es_c, 256.0) + 256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;rounded_up=
_max_swath_size_bytes_c =3D (dcn_bw_ceil2(v-&gt;swath_width / 2.0 - 1.0, v-=
&gt;swath_width_granularity_c) + v-&gt;swath_width_granularity_c) * v-&gt;b=
yte_per_pix_detc * v-&gt;maximum_swath_height_c;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;source=
_pixel_format[k] =3D=3D dcn_bw_yuv420_sub_10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;rounded_up_max_swath_size_bytes_c =3D=
 dcn_bw_ceil2(v-&gt;rounded_up_max_swath_size_bytes_c, 256.0) + 256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (v-&gt;rounded_up_max_swath_size_bytes_y + v-&gt;r=
ounded_up_max_swath_size_bytes_c &lt;=3D v-&gt;det_buffer_size_in_kbyte * 1=
024.0 / 2.0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt=
;swath_height_y[k] =3D v-&gt;maximum_swath_height_y;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c b/dri=
vers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
index 07d18e78de49..cac72413a097 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c<br>
@@ -23,6 +23,7 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
+#include &quot;os_types.h&quot;<br>
&nbsp;#include &quot;dcn_calc_math.h&quot;<br>
&nbsp;<br>
&nbsp;#define isNaN(number) ((number) !=3D (number))<br>
@@ -69,8 +70,8 @@ float dcn_bw_max2(const float arg1, const float arg2)<br>
&nbsp;<br>
&nbsp;float dcn_bw_floor2(const float arg, const float significance)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (significance =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(significance !=3D 0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((int) (arg / signi=
ficance)) * significance;<br>
&nbsp;}<br>
&nbsp;float dcn_bw_floor(const float arg)<br>
@@ -80,17 +81,14 @@ float dcn_bw_floor(const float arg)<br>
&nbsp;<br>
&nbsp;float dcn_bw_ceil(const float arg)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; float flr =3D dcn_bw_floor2(arg, 1);<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return flr + 0.00001 &gt;=3D arg ? ar=
g : flr + 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (int) (arg + 0.99999);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;float dcn_bw_ceil2(const float arg, const float significance)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; float flr =3D dcn_bw_floor2(arg, sign=
ificance);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (significance =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return flr + 0.00001 &gt;=3D arg ? ar=
g : flr + significance;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT(significance !=3D 0);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((int) (arg / significance + 0=
.99999)) * significance;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;float dcn_bw_max3(float v1, float v2, float v3)<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c<br>
index 63bbdf8b8678..edd098c7eb92 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c<br>
@@ -4478,17 +4478,17 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(=
struct display_mode_lib *mode<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;=
EffectiveLBLatencyHidingSourceLinesLuma),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;=
SwathHeightYPerState[i][j][k]);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;EffectiveDETLBLinesChroma =3D dm=
l_floor(locals-&gt;LinesInDETChroma + dml_min(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;LinesInDETC=
hroma * locals-&gt;RequiredDISPCLK[i][j] * locals-&gt;BytePerPixelInDETC[k]=
 *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;PSCL_FACTOR=
_CHROMA[k] / locals-&gt;ReturnBWPerState[i][0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;EffectiveLB=
LatencyHidingSourceLinesChroma),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;SwathHeight=
CPerState[i][j][k]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (locals-&gt;BytePerPixelInDET=
C[k] =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; locals-&gt;UrgentLatencySupportUsPerState[i][j][k] =3D loca=
ls-&gt;EffectiveDETLBLinesLuma * (locals-&gt;HTotal[k] / locals-&gt;PixelCl=
ock[k])<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / locals-&gt;VRatio[k] - locals-&gt;Ef=
fectiveDETLBLinesLuma * locals-&gt;SwathWidthYPerState[i][j][k] *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dml_ceil(locals-&gt;BytePerPixelInDETY[k], 1) / (locals-&gt;Retur=
nBWPerState[i][0] / locals-&gt;NoOfDPP[i][j][k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; locals-&gt;EffectiveDETLBLinesChroma =3D dml_floor(locals-&gt;LinesInD=
ETChroma + dml_min(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;LinesInDETChroma * locals-&gt;Required=
DISPCLK[i][j] * locals-&gt;BytePerPixelInDETC[k] *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;PSCL_FACTOR_CHROMA[k] / locals-&gt;Ret=
urnBWPerState[i][0],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;EffectiveLBLatencyHidingSourceLinesChr=
oma),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;SwathHeightCPerState[i][j][k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; locals-&gt;UrgentLatencySupportUsPerState[i][j][k] =3D dml_=
min(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; locals-&gt;=
EffectiveDETLBLinesLuma * (locals-&gt;HTotal[k] / locals-&gt;PixelClock[k])=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / locals-&g=
t;VRatio[k] - locals-&gt;EffectiveDETLBLinesLuma * locals-&gt;SwathWidthYPe=
rState[i][j][k] *<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c<br>
index 8a7485e21d53..d40d32e380f4 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c<br>
@@ -806,10 +806,12 @@ static bool CalculatePrefetchSchedule(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (myPipe-&gt;SourceScan =
=3D=3D dm_horz) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *swath_width_luma_ub =3D dml_ceil(SwathWidthY - 1, my=
Pipe-&gt;BlockWidth256BytesY) + myPipe-&gt;BlockWidth256BytesY;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2 - 1, myPipe-=
&gt;BlockWidth256BytesC) + myPipe-&gt;BlockWidth256BytesC;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (myPipe-&gt;BlockWidth256BytesC &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *swath_width_chr=
oma_ub =3D dml_ceil(SwathWidthY / 2 - 1, myPipe-&gt;BlockWidth256BytesC) + =
myPipe-&gt;BlockWidth256BytesC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *swath_width_luma_ub =3D dml_ceil(SwathWidthY - 1, my=
Pipe-&gt;BlockHeight256BytesY) + myPipe-&gt;BlockHeight256BytesY;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *swath_width_chroma_ub =3D dml_ceil(SwathWidthY / 2 - 1, myPipe-=
&gt;BlockHeight256BytesC) + myPipe-&gt;BlockHeight256BytesC;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (myPipe-&gt;BlockWidth256BytesC &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *swath_width_chr=
oma_ub =3D dml_ceil(SwathWidthY / 2 - 1, myPipe-&gt;BlockHeight256BytesC) +=
 myPipe-&gt;BlockHeight256BytesC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prefetch_bw_oto =3D (Prefe=
tchSourceLinesY * *swath_width_luma_ub * dml_ceil(BytePerPixelDETY, 1) + Pr=
efetchSourceLinesC * *swath_width_chroma_ub * dml_ceil(BytePerPixelDETC, 2)=
) / Tsw_oto;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c<br>
index b7fa003ffe06..c117a9724ae1 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c<br>
@@ -6322,10 +6322,6 @@ static void CalculateSwathWidth(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (k =3D 0; k &lt; Numbe=
rOfActivePlanes; ++k) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum odm_combine_mode MainPlaneODMCombine =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k], Read256BytesBl=
ockWidthY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], Read256Bytes=
BlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read256BytesBl=
ockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256Bytes=
BlockHeightC[k]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (SourceScan[k] !=3D dm_vert) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Swath=
WidthSingleDPPY[k] =3D ViewportWidth[k];<br>
@@ -6365,8 +6361,6 @@ static void CalculateSwathWidth(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; surface_width_ub_l&nbsp; =3D dml_ceil(SurfaceWidthY[k=
], Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], R=
ead256BytesBlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_width_ub_c&nbsp; =3D dml_ceil(SurfaceWidthC[k], Read256B=
ytesBlockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256Bytes=
BlockHeightC[k]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (SourceScan[k] !=3D dm_vert) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightY[k] =3D Read256BytesBlockHeightY[k];<br>
@@ -6374,6 +6368,7 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_width_ub_l, (long) dml_ceil(SwathWidt=
hY[k] - 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_width_ub_c&nbsp; =3D dml_ceil(Surfa=
ceWidthC[k], Read256BytesBlockWidthC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(surface_width_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read256Byte=
sBlockWidthC[k]) + Read256BytesBlockWidthC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
@@ -6385,6 +6380,7 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_height_ub_l, (long) dml_ceil(SwathWid=
thY[k] - 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k])=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_height_ub_c =3D dml_ceil(SurfaceHei=
ghtC[k], Read256BytesBlockHeightC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(surface_height_ub_c, (long) dml_ceil(SwathWidthC[k] - 1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read256Byte=
sBlockHeightC[k]) + Read256BytesBlockHeightC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c<br>
index d63b4209b14c..8753f94bdd79 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c<br>
@@ -6933,8 +6933,6 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k],=
 Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k=
], Read256BytesBlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read256Byt=
esBlockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256B=
ytesBlockHeightC[k]);<br>
&nbsp;<br>
&nbsp;#ifdef __DML_VBA_DEBUG__<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_l=3D=
%0d\n&quot;, __func__, k, surface_width_ub_l);<br>
@@ -6945,6 +6943,8 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightC[k] =3D Read256BytesBlockHeightC[k];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_width_ub_l, (int) dml_ceil(SwathWidth=
Y[k] - 1, Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int surface_width_ub_c =3D dml_ceil(Surface=
WidthC[k], Read256BytesBlockWidthC[k]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_wid=
th_ub_c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int) dml_c=
eil(SwathWidthC[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidt=
hC[k]);<br>
@@ -6956,6 +6956,8 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightC[k] =3D Read256BytesBlockWidthC[k];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_height_ub_l, (int) dml_ceil(SwathWidt=
hY[k] - 1, Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int surface_height_ub_c =3D dml_ceil(Surfac=
eHeightC[k], Read256BytesBlockHeightC[k]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_hei=
ght_ub_c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int) dml_c=
eil(SwathWidthC[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHei=
ghtC[k]);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c<br>
index fc4d7474c111..503d9ede0ac1 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c<br>
@@ -7049,8 +7049,6 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int surface_width_ub_l =3D dml_ceil(SurfaceWidthY[k],=
 Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k=
], Read256BytesBlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int surface_width_ub_c =3D dml_ceil(SurfaceWidthC[k], Read256Byt=
esBlockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256B=
ytesBlockHeightC[k]);<br>
&nbsp;<br>
&nbsp;#ifdef __DML_VBA_DEBUG__<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_l=3D=
%0d\n&quot;, __func__, k, surface_width_ub_l);<br>
@@ -7061,6 +7059,8 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightC[k] =3D Read256BytesBlockHeightC[k];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_width_ub_l, (int) dml_ceil(SwathWidth=
Y[k] - 1, Read256BytesBlockWidthY[k]) + Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int surface_width_ub_c =3D dml_ceil(Surface=
WidthC[k], Read256BytesBlockWidthC[k]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_wid=
th_ub_c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int) dml_c=
eil(SwathWidthC[k] - 1, Read256BytesBlockWidthC[k]) + Read256BytesBlockWidt=
hC[k]);<br>
@@ -7072,6 +7072,8 @@ static void CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightC[k] =3D Read256BytesBlockWidthC[k];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath=
_width_luma_ub[k] =3D dml_min(surface_height_ub_l, (int) dml_ceil(SwathWidt=
hY[k] - 1, Read256BytesBlockHeightY[k]) + Read256BytesBlockHeightY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int surface_height_ub_c =3D dml_ceil(Surfac=
eHeightC[k], Read256BytesBlockHeightC[k]);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml=
_min(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_hei=
ght_ub_c,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int) dml_c=
eil(SwathWidthC[k] - 1, Read256BytesBlockHeightC[k]) + Read256BytesBlockHei=
ghtC[k]);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util=
_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c=
<br>
index dc501ee7d01a..c385c54832cb 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c<b=
r>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c<b=
r>
@@ -719,8 +719,8 @@ void dml32_CalculateSwathWidth(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width=
_ub_l;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_heigh=
t_ub_l;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width_ub_c;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_height_ub_c;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width_ub_c =3D 0=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_height_ub_c =3D =
0;<br>
&nbsp;<br>
&nbsp;#ifdef __DML_VBA_DEBUG__<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: F=
orceSingleDPP =3D %d\n&quot;, __func__, ForceSingleDPP);<br>
@@ -784,21 +784,6 @@ void dml32_CalculateSwathWidth(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; surface_width_ub_l&nbsp; =3D dml_ceil(SurfaceWidthY[k=
], Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; surface_height_ub_l =3D dml_ceil(SurfaceHeightY[k], R=
ead256BytesBlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_width_ub_c&nbsp; =3D dml_ceil(SurfaceWidthC[k], Read256B=
ytesBlockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; surface_height_ub_c =3D dml_ceil(SurfaceHeightC[k], Read256Bytes=
BlockHeightC[k]);<br>
-<br>
-#ifdef __DML_VBA_DEBUG__<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_l=3D%0d\n&quot;=
, __func__, k, surface_width_ub_l);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_height_ub_l=3D%0d\n&quot=
;, __func__, k, surface_height_ub_l);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_c=3D%0d\n&quot;=
, __func__, k, surface_width_ub_c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_height_ub_c=3D%0d\n&quot=
;, __func__, k, surface_height_ub_c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockWidthY=3D%0d\n&=
quot;, __func__, k, Read256BytesBlockWidthY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockHeightY=3D%0d\n=
&quot;, __func__, k, Read256BytesBlockHeightY[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockWidthC=3D%0d\n&=
quot;, __func__, k, Read256BytesBlockWidthC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockHeightC=3D%0d\n=
&quot;, __func__, k, Read256BytesBlockHeightC[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d ViewportStationary=3D%0d\n&quot;=
, __func__, k, ViewportStationary[k]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d DPPPerSurface=3D%0d\n&quot;, __f=
unc__, k, DPPPerSurface[k]);<br>
-#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!IsVertical(SourceRotation[k])) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maxim=
umSwathHeightY[k] =3D Read256BytesBlockHeightY[k];<br>
@@ -818,6 +803,7 @@ void dml32_CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Read256BytesBlockWidthY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_width_ub_c&nbsp; =3D dml_ceil(Surfa=
ceWidthC[k], Read256BytesBlockWidthC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ViewportStationary[k] &amp;&=
amp; DPPPerSurface[k] =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml_min(surface_width_ub_c,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_floor(ViewportXStartC[k] + SwathWi=
dthC[k] +<br>
@@ -848,6 +834,7 @@ void dml32_CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read256Byte=
sBlockHeightY[k]) + Read256BytesBlockHeightY[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (B=
ytePerPixC[k] &gt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; surface_height_ub_c =3D dml_ceil(SurfaceHei=
ghtC[k], Read256BytesBlockHeightC[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ViewportStationary[k] &amp;&=
amp; DPPPerSurface[k] =3D=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; swath_width_chroma_ub[k] =3D dml_min(surface_height_ub_c,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_floor(ViewportYStartC[k] + SwathWi=
dthC[k] +<br>
@@ -866,6 +853,16 @@ void dml32_CalculateSwathWidth(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;#ifdef __DML_VBA_DEBUG__<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_l=3D%0d\n&quot;=
, __func__, k, surface_width_ub_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_height_ub_l=3D%0d\n&quot=
;, __func__, k, surface_height_ub_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_width_ub_c=3D%0d\n&quot;=
, __func__, k, surface_width_ub_c);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d surface_height_ub_c=3D%0d\n&quot=
;, __func__, k, surface_height_ub_c);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockWidthY=3D%0d\n&=
quot;, __func__, k, Read256BytesBlockWidthY[k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockHeightY=3D%0d\n=
&quot;, __func__, k, Read256BytesBlockHeightY[k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockWidthC=3D%0d\n&=
quot;, __func__, k, Read256BytesBlockWidthC[k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d Read256BytesBlockHeightC=3D%0d\n=
&quot;, __func__, k, Read256BytesBlockHeightC[k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d ViewportStationary=3D%0d\n&quot;=
, __func__, k, ViewportStationary[k]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d DPPPerSurface=3D%0d\n&quot;, __f=
unc__, k, DPPPerSurface[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d swath_width_luma_ub=
=3D%0d\n&quot;, __func__, k, swath_width_luma_ub[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d swath_width_chroma_ub=
=3D%0d\n&quot;, __func__, k, swath_width_chroma_ub[k]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml_print(&quot;DML::%s: k=3D%d MaximumSwathHeightY=
=3D%0d\n&quot;, __func__, k, MaximumSwathHeightY[k]);<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util=
_32.c.rej b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_=
32.c.rej<br>
new file mode 100644<br>
index 000000000000..dff2badbf820<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.r=
ej<br>
@@ -0,0 +1,12 @@<br>
+diff a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rejected hunks)<br>
+@@ -727,8 +727,8 @@ void dml32_CalculateSwathWidth(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum odm_combine_mode MainSurfa=
ceODMMode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width_ub_l=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_height_ub_=
l;<br>
+-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width_ub_c;<br>
+-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_height_ub_c;<br>
++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_width_ub_c =3D 0;<br>
++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int surface_height_ub_c =3D 0;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int k, j;<br>
+ <br>
+ #ifdef __DML_VBA_DEBUG__<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h b/drivers=
/gpu/drm/amd/display/dc/dml/dml_inline_defs.h<br>
index 479d7d83220c..072bd0539605 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h<br>
@@ -76,14 +76,9 @@ static inline double dml_floor(double a, double granular=
ity)<br>
&nbsp;<br>
&nbsp;static inline double dml_round(double a)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double round_pt =3D 0.5;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double ceil =3D dml_ceil(a, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double floor =3D dml_floor(a, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const double round_pt =3D 0.5;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a - floor &gt;=3D round_pt)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ceil;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return floor;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dml_floor(a + round_pt, 1);<br=
>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* float<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5489C7CF3966567777C22E2BFC449CO6PR12MB5489namp_--
