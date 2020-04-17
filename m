Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D8C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4919A21D93
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tpsJv70W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4919A21D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCFA6E215;
	Fri, 17 Apr 2020 02:32:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD9D6E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIQwtkFslQmxgYPzATnaiJ5b3vu4W0721AeRiakmuScROio6/ywfCMMSldN7XijD55jlxLZyz36/ZoFE5X/P1GVjcfAsDAZKSO+nYeQbB67s8TiisSRl7fn6+YZiutQQNyBj1RVgoazdLHv8hXp5MKTXQ73mH43g8d8Cm9NtjH74zM1iWlyMzw9KvOcIpqn59V4VCQ4p9YzHuvQ28Y0q3iWvBjiHldLG/VX2COgSJ5nvQ2t457h1hTGlr5+GWhGxMvS34qcZOORaPqlF+FQii5cPbDqQigmR+Rz7AlxKl5FG5AeZ6gPjGSGoDSiPw5IEvT7zw4k4y15iOcjPnkNHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwJO7JAkw3f6eKIFvzkXPFwC+WYSY33+4U9TQOQDg6s=;
 b=AjbRKuy0iRfBGX71x4xDbjCx8YlveMKxD8k97RLUCuBPoXToRz9/x0m7AmUcSh3i/AIdWfro/Fk8y0RrgMAGpYToGfNKlI0I7DCvcC4eyAt8l2othgH9zIvYe+U1/3WygjXIMR6l13NI6RP6cC/BCYXkkGD0qx+0bl99hLorhld9HA3uneTvTUVRZIv/V7Ji/ZAD8xe6wYL11K7OYMslMkV3izl+Je5kl05LTdCocz6Dgk/1WOobNYBcyXnouEHu2HW4C1pOX/f0ZldkwLMDL8E5RBmQ+l5VzSe35xKDLA3FgbknbKiCP3K0gA8p01xsKEta+XFDSmOEnYndK+5W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwJO7JAkw3f6eKIFvzkXPFwC+WYSY33+4U9TQOQDg6s=;
 b=tpsJv70WDaDABaI8gp18iW5YKo41U18+T/u7gM2AQEK3t0K7GEKGJwAE8h7YxAbH1smsFB9qJxJWi+vKh6Rkm4SdkyVF+yosJYRib5n6+iYAAZJMviKEpU8wYzI7L2MZ0oLVIastnWKA1ULflNks77djQxaJ6rLr31FG/UVyWnY=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 02:32:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 02:32:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
Thread-Topic: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub
 abm config table
Thread-Index: AQHWFEiMkigmj+95nUiA1Y4wKByYlKh8l/XZ
Date: Fri, 17 Apr 2020 02:32:13 +0000
Message-ID: <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>,
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-17T02:32:13.145Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [172.58.190.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1a63a17-1ab9-43ea-9b6c-08d7e2778a0e
x-ms-traffictypediagnostic: MN2PR12MB4470:|MN2PR12MB4470:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44703C12DDBA34BF02E51EB5F7D90@MN2PR12MB4470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(66446008)(966005)(54906003)(110136005)(76116006)(55016002)(186003)(66556008)(66476007)(478600001)(9686003)(64756008)(8676002)(45080400002)(71200400001)(66946007)(81156014)(6506007)(52536014)(2906002)(86362001)(8936002)(26005)(33656002)(7696005)(19627405001)(5660300002)(53546011)(316002)(4326008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PefDYW7Bqg3JNcfvvRPdwp6UC2DQnB2UNxqXh9seDaqoKH7Bpvlgy5CLP/DpCIA1GNzgaFdbusOY5IpfQQYruFPVc8kdiUdWJerUxl0B0lnTVNV7/ndR9HCdhWlbd5mFjtBL0sEbhVTjNO+e9U0DKUCEr9uKsyZiwF1xN1UBLGSan3MK8SKUeEfSl2f3bpsmvKyHtSyaN7fkDEnTQpihr2RIurxm6gROpBwXr2dtDh9d2bl/5pNIwJR7x83WMCZMtnwzEJhLYlwMvAPjJL1TrfTco6R3q1FGPVmnMw76KF7cWqDHZ5RT4GWmvxyZ6fcgWExgna69oQpWMVtyJvxsgR2rpCJbdJy7k60EONBZJDOOFgTvc7T9Iel2MLNqxQTo+mvzjPU9NfxOTZaYqdOaT8wVBZHs9GZhVwxXRHv/7mnxsv3Vdp5RQY/+EEvHOd79MKpnl8KqQ3DBzyDK9feXTUV662dItzoUAveyjcVI5Y=
x-ms-exchange-antispam-messagedata: jeNEETJyR98/1R5bYV+Xd9FP9Oe3OeHckyXMUlYQ6HEjxWq0j+/07zs/jEQ947qt1Y8Kmm4Qz/3x5EN4MAoyOTaSeqMJWzbsGr3cS0w79P8p+OXJtBfDNfoWbF694Aw17Rkfv0iNyj+9X3LHrffTVQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a63a17-1ab9-43ea-9b6c-08d7e2778a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 02:32:13.9750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXt601d+vULzTzNwXaAkv9Q1TByNtlSKNmwmVYrypDmX/8pW4/IqvpxGaidvfT6gq6eL/TFN3Ec0OGpuAyzMLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "Wood,
 Wyatt" <Wyatt.Wood@amd.com>
Content-Type: multipart/mixed; boundary="===============0863297700=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0863297700==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488B2003904110CAE92E166F7D90MN2PR12MB4488namp_"

--_000_MN2PR12MB4488B2003904110CAE92E166F7D90MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

I would drop this patch unless it only applies to APUs.  On Linux, people m=
ay run the driver on big endian systems.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Rodrigo =
Siqueira <Rodrigo.Siqueira@amd.com>
Sent: Thursday, April 16, 2020 7:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentlan=
d@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wood, Wyatt <Wyat=
t.Wood@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Koo, Antho=
ny <Anthony.Koo@amd.com>
Subject: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm =
config table

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Since x86 and dmcub are both little endian, byte swapping isn't
necessary. Dmcu requires byte swapping as it is big endian.

[How]
Add flag to function definitions to determine if byte swapping is
necessary.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/power/power_helpers.c | 74 +++++++++----------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/dr=
ivers/gpu/drm/amd/display/modules/power/power_helpers.c
index dd1517684c90..edb446455f6b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -240,7 +240,7 @@ static void fill_backlight_transform_table(struct dmcu_=
iram_parameters params,
 }

 static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_paramete=
rs params,
-               struct iram_table_v_2_2 *table)
+               struct iram_table_v_2_2 *table, bool big_endian)
 {
         unsigned int i;
         unsigned int num_entries =3D NUM_BL_CURVE_SEGS;
@@ -264,10 +264,10 @@ static void fill_backlight_transform_table_v_2_2(stru=
ct dmcu_iram_parameters par
                 lut_index =3D (params.backlight_lut_array_size - 1) * i / =
(num_entries - 1);
                 ASSERT(lut_index < params.backlight_lut_array_size);

-               table->backlight_thresholds[i] =3D
-                       cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries));
-               table->backlight_offsets[i] =3D
-                       cpu_to_be16(params.backlight_lut_array[lut_index]);
+               table->backlight_thresholds[i] =3D (big_endian) ?
+                       cpu_to_be16(DIV_ROUNDUP((i * 65536), num_entries)) =
: DIV_ROUNDUP((i * 65536), num_entries);
+               table->backlight_offsets[i] =3D (big_endian) ?
+                       cpu_to_be16(params.backlight_lut_array[lut_index]) =
: params.backlight_lut_array[lut_index];
         }
 }

@@ -587,18 +587,16 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_tab=
le, struct dmcu_iram_parame
         ram_table->crgb_slope[7]  =3D cpu_to_be16(0x1910);

         fill_backlight_transform_table_v_2_2(
-                       params, ram_table);
+                       params, ram_table, true);
 }

-void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_=
parameters params)
+void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_=
parameters params, bool big_endian)
 {
         unsigned int i, j;
         unsigned int set =3D params.set;

         ram_table->flags =3D 0x0;
-
-       ram_table->min_abm_backlight =3D
-                       cpu_to_be16(params.min_abm_backlight);
+       ram_table->min_abm_backlight =3D (big_endian) ? cpu_to_be16(params.=
min_abm_backlight) : params.min_abm_backlight;

         for (i =3D 0; i < NUM_AGGR_LEVEL; i++) {
                 ram_table->hybrid_factor[i] =3D abm_settings[set][i].brigh=
tness_gain;
@@ -622,33 +620,33 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_tab=
le, struct dmcu_iram_parame
         ram_table->iir_curve[4] =3D 0x65;

         //Gamma 2.2
-       ram_table->crgb_thresh[0] =3D cpu_to_be16(0x127c);
-       ram_table->crgb_thresh[1] =3D cpu_to_be16(0x151b);
-       ram_table->crgb_thresh[2] =3D cpu_to_be16(0x17d5);
-       ram_table->crgb_thresh[3] =3D cpu_to_be16(0x1a56);
-       ram_table->crgb_thresh[4] =3D cpu_to_be16(0x1c83);
-       ram_table->crgb_thresh[5] =3D cpu_to_be16(0x1e72);
-       ram_table->crgb_thresh[6] =3D cpu_to_be16(0x20f0);
-       ram_table->crgb_thresh[7] =3D cpu_to_be16(0x232b);
-       ram_table->crgb_offset[0] =3D cpu_to_be16(0x2999);
-       ram_table->crgb_offset[1] =3D cpu_to_be16(0x3999);
-       ram_table->crgb_offset[2] =3D cpu_to_be16(0x4666);
-       ram_table->crgb_offset[3] =3D cpu_to_be16(0x5999);
-       ram_table->crgb_offset[4] =3D cpu_to_be16(0x6333);
-       ram_table->crgb_offset[5] =3D cpu_to_be16(0x7800);
-       ram_table->crgb_offset[6] =3D cpu_to_be16(0x8c00);
-       ram_table->crgb_offset[7] =3D cpu_to_be16(0xa000);
-       ram_table->crgb_slope[0]  =3D cpu_to_be16(0x3609);
-       ram_table->crgb_slope[1]  =3D cpu_to_be16(0x2dfa);
-       ram_table->crgb_slope[2]  =3D cpu_to_be16(0x27ea);
-       ram_table->crgb_slope[3]  =3D cpu_to_be16(0x235d);
-       ram_table->crgb_slope[4]  =3D cpu_to_be16(0x2042);
-       ram_table->crgb_slope[5]  =3D cpu_to_be16(0x1dc3);
-       ram_table->crgb_slope[6]  =3D cpu_to_be16(0x1b1a);
-       ram_table->crgb_slope[7]  =3D cpu_to_be16(0x1910);
+       ram_table->crgb_thresh[0] =3D (big_endian) ? cpu_to_be16(0x127c) : =
0x127c;
+       ram_table->crgb_thresh[1] =3D (big_endian) ? cpu_to_be16(0x151b) : =
0x151b;
+       ram_table->crgb_thresh[2] =3D (big_endian) ? cpu_to_be16(0x17d5) : =
0x17d5;
+       ram_table->crgb_thresh[3] =3D (big_endian) ? cpu_to_be16(0x1a56) : =
0x1a56;
+       ram_table->crgb_thresh[4] =3D (big_endian) ? cpu_to_be16(0x1c83) : =
0x1c83;
+       ram_table->crgb_thresh[5] =3D (big_endian) ? cpu_to_be16(0x1e72) : =
0x1e72;
+       ram_table->crgb_thresh[6] =3D (big_endian) ? cpu_to_be16(0x20f0) : =
0x20f0;
+       ram_table->crgb_thresh[7] =3D (big_endian) ? cpu_to_be16(0x232b) : =
0x232b;
+       ram_table->crgb_offset[0] =3D (big_endian) ? cpu_to_be16(0x2999) : =
0x2999;
+       ram_table->crgb_offset[1] =3D (big_endian) ? cpu_to_be16(0x3999) : =
0x3999;
+       ram_table->crgb_offset[2] =3D (big_endian) ? cpu_to_be16(0x4666) : =
0x4666;
+       ram_table->crgb_offset[3] =3D (big_endian) ? cpu_to_be16(0x5999) : =
0x5999;
+       ram_table->crgb_offset[4] =3D (big_endian) ? cpu_to_be16(0x6333) : =
0x6333;
+       ram_table->crgb_offset[5] =3D (big_endian) ? cpu_to_be16(0x7800) : =
0x7800;
+       ram_table->crgb_offset[6] =3D (big_endian) ? cpu_to_be16(0x8c00) : =
0x8c00;
+       ram_table->crgb_offset[7] =3D (big_endian) ? cpu_to_be16(0xa000) : =
0xa000;
+       ram_table->crgb_slope[0]  =3D (big_endian) ? cpu_to_be16(0x3609) : =
0x3609;
+       ram_table->crgb_slope[1]  =3D (big_endian) ? cpu_to_be16(0x2dfa) : =
0x2dfa;
+       ram_table->crgb_slope[2]  =3D (big_endian) ? cpu_to_be16(0x27ea) : =
0x27ea;
+       ram_table->crgb_slope[3]  =3D (big_endian) ? cpu_to_be16(0x235d) : =
0x235d;
+       ram_table->crgb_slope[4]  =3D (big_endian) ? cpu_to_be16(0x2042) : =
0x2042;
+       ram_table->crgb_slope[5]  =3D (big_endian) ? cpu_to_be16(0x1dc3) : =
0x1dc3;
+       ram_table->crgb_slope[6]  =3D (big_endian) ? cpu_to_be16(0x1b1a) : =
0x1b1a;
+       ram_table->crgb_slope[7]  =3D (big_endian) ? cpu_to_be16(0x1910) : =
0x1910;

         fill_backlight_transform_table_v_2_2(
-                       params, ram_table);
+                       params, ram_table, big_endian);
 }

 bool dmub_init_abm_config(struct abm *abm,
@@ -662,7 +660,7 @@ bool dmub_init_abm_config(struct abm *abm,

         memset(&ram_table, 0, sizeof(ram_table));

-       fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
+       fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params, false=
);
         result =3D abm->funcs->init_abm_config(
                 abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);

@@ -684,11 +682,11 @@ bool dmcu_load_iram(struct dmcu *dmcu,
         memset(&ram_table, 0, sizeof(ram_table));

         if (dmcu->dmcu_version.abm_version =3D=3D 0x24) {
-               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, param=
s);
+               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, param=
s, true);
                         result =3D dmcu->funcs->load_iram(
                                         dmcu, 0, (char *)(&ram_table), IRA=
M_RESERVE_AREA_START_V2_2);
         } else if (dmcu->dmcu_version.abm_version =3D=3D 0x23) {
-               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, param=
s);
+               fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, param=
s, true);

                 result =3D dmcu->funcs->load_iram(
                                 dmcu, 0, (char *)(&ram_table), IRAM_RESERV=
E_AREA_START_V2_2);
--
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637226772877797082&amp;sdata=3Dsa4MJoUY%2FjVgW3f4Q=
x1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;reserved=3D0

--_000_MN2PR12MB4488B2003904110CAE92E166F7D90MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I would drop this patch unless it only applies to APUs.&nbsp; On Linux, peo=
ple may run the driver on big endian systems.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Rodrigo Siqueira &lt;Rodrigo.=
Siqueira@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 16, 2020 7:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &=
lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.c=
om&gt;; Wood, Wyatt &lt;Wyatt.Wood@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhaw=
anpreet.Lakha@amd.com&gt;; Koo, Anthony &lt;Anthony.Koo@amd.com&gt;<br>
<b>Subject:</b> [PATCH 05/35] drm/amd/display: Remove byte swapping for dmc=
ub abm config table</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Wyatt Wood &lt;wyatt.wood@amd.com&gt;<br>
<br>
[Why]<br>
Since x86 and dmcub are both little endian, byte swapping isn't<br>
necessary. Dmcu requires byte swapping as it is big endian.<br>
<br>
[How]<br>
Add flag to function definitions to determine if byte swapping is<br>
necessary.<br>
<br>
Signed-off-by: Wyatt Wood &lt;wyatt.wood@amd.com&gt;<br>
Reviewed-by: Anthony Koo &lt;Anthony.Koo@amd.com&gt;<br>
Acked-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;.../amd/display/modules/power/power_helpers.c | 74 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;1 file changed, 36 insertions(&#43;), 38 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/dr=
ivers/gpu/drm/amd/display/modules/power/power_helpers.c<br>
index dd1517684c90..edb446455f6b 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c=
<br>
@@ -240,7 &#43;240,7 @@ static void fill_backlight_transform_table(struct d=
mcu_iram_parameters params,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void fill_backlight_transform_table_v_2_2(struct dmcu_iram_par=
ameters params,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct iram_table_v_2_2 *table)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct iram_table_v_2_2 *table, bool big_endian)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_entries =
=3D NUM_BL_CURVE_SEGS;<br>
@@ -264,10 &#43;264,10 @@ static void fill_backlight_transform_table_v_2_2(=
struct dmcu_iram_parameters par<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lut_index =3D (params.backlight_lut_array_size - 1) *=
 i / (num_entries - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ASSERT(lut_index &lt; params.backlight_lut_array_size=
);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;backlight_thresholds[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be16(DIV_=
ROUNDUP((i * 65536), num_entries));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; table-&gt;backlight_offsets[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be16(para=
ms.backlight_lut_array[lut_index]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;backlight_thresholds[i] =3D (big_endian) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be16(=
DIV_ROUNDUP((i * 65536), num_entries)) : DIV_ROUNDUP((i * 65536), num_entri=
es);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; table-&gt;backlight_offsets[i] =3D (big_endian) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be16(=
params.backlight_lut_array[lut_index]) : params.backlight_lut_array[lut_ind=
ex];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
@@ -587,18 &#43;587,16 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 *ram=
_table, struct dmcu_iram_parame<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[7=
]&nbsp; =3D cpu_to_be16(0x1910);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fill_backlight_transform_t=
able_v_2_2(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params, ram_tabl=
e);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params, ram_=
table, true);<br>
&nbsp;}<br>
&nbsp;<br>
-void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_iram_=
parameters params)<br>
&#43;void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_i=
ram_parameters params, bool big_endian)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int set =3D param=
s.set;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;flags =3D 0x=
0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;min_abm_backlight =3D<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_be16(para=
ms.min_abm_backlight);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;min_abm_backlight =
=3D (big_endian) ? cpu_to_be16(params.min_abm_backlight) : params.min_abm_b=
acklight;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; NUM_A=
GGR_LEVEL; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ram_table-&gt;hybrid_factor[i] =3D abm_settings[set][=
i].brightness_gain;<br>
@@ -622,33 &#43;620,33 @@ void fill_iram_v_2_3(struct iram_table_v_2_2 *ram=
_table, struct dmcu_iram_parame<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;iir_curve[4]=
 =3D 0x65;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Gamma 2.2<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[0] =3D cpu_=
to_be16(0x127c);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[1] =3D cpu_=
to_be16(0x151b);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[2] =3D cpu_=
to_be16(0x17d5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[3] =3D cpu_=
to_be16(0x1a56);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[4] =3D cpu_=
to_be16(0x1c83);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[5] =3D cpu_=
to_be16(0x1e72);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[6] =3D cpu_=
to_be16(0x20f0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[7] =3D cpu_=
to_be16(0x232b);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[0] =3D cpu_=
to_be16(0x2999);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[1] =3D cpu_=
to_be16(0x3999);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[2] =3D cpu_=
to_be16(0x4666);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[3] =3D cpu_=
to_be16(0x5999);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[4] =3D cpu_=
to_be16(0x6333);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[5] =3D cpu_=
to_be16(0x7800);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[6] =3D cpu_=
to_be16(0x8c00);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[7] =3D cpu_=
to_be16(0xa000);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[0]&nbsp; =3D=
 cpu_to_be16(0x3609);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[1]&nbsp; =3D=
 cpu_to_be16(0x2dfa);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[2]&nbsp; =3D=
 cpu_to_be16(0x27ea);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[3]&nbsp; =3D=
 cpu_to_be16(0x235d);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[4]&nbsp; =3D=
 cpu_to_be16(0x2042);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[5]&nbsp; =3D=
 cpu_to_be16(0x1dc3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[6]&nbsp; =3D=
 cpu_to_be16(0x1b1a);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[7]&nbsp; =3D=
 cpu_to_be16(0x1910);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[0] =3D =
(big_endian) ? cpu_to_be16(0x127c) : 0x127c;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[1] =3D =
(big_endian) ? cpu_to_be16(0x151b) : 0x151b;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[2] =3D =
(big_endian) ? cpu_to_be16(0x17d5) : 0x17d5;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[3] =3D =
(big_endian) ? cpu_to_be16(0x1a56) : 0x1a56;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[4] =3D =
(big_endian) ? cpu_to_be16(0x1c83) : 0x1c83;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[5] =3D =
(big_endian) ? cpu_to_be16(0x1e72) : 0x1e72;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[6] =3D =
(big_endian) ? cpu_to_be16(0x20f0) : 0x20f0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_thresh[7] =3D =
(big_endian) ? cpu_to_be16(0x232b) : 0x232b;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[0] =3D =
(big_endian) ? cpu_to_be16(0x2999) : 0x2999;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[1] =3D =
(big_endian) ? cpu_to_be16(0x3999) : 0x3999;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[2] =3D =
(big_endian) ? cpu_to_be16(0x4666) : 0x4666;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[3] =3D =
(big_endian) ? cpu_to_be16(0x5999) : 0x5999;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[4] =3D =
(big_endian) ? cpu_to_be16(0x6333) : 0x6333;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[5] =3D =
(big_endian) ? cpu_to_be16(0x7800) : 0x7800;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[6] =3D =
(big_endian) ? cpu_to_be16(0x8c00) : 0x8c00;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_offset[7] =3D =
(big_endian) ? cpu_to_be16(0xa000) : 0xa000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[0]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x3609) : 0x3609;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[1]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x2dfa) : 0x2dfa;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[2]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x27ea) : 0x27ea;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[3]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x235d) : 0x235d;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[4]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x2042) : 0x2042;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[5]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x1dc3) : 0x1dc3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[6]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x1b1a) : 0x1b1a;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ram_table-&gt;crgb_slope[7]&nbsp;=
 =3D (big_endian) ? cpu_to_be16(0x1910) : 0x1910;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fill_backlight_transform_t=
able_v_2_2(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params, ram_tabl=
e);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params, ram_=
table, big_endian);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;bool dmub_init_abm_config(struct abm *abm,<br>
@@ -662,7 &#43;660,7 @@ bool dmub_init_abm_config(struct abm *abm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;ram_table, 0, =
sizeof(ram_table));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fill_iram_v_2_3((struct iram_table_v_=
2_2 *)ram_table, params);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fill_iram_v_2_3((struct iram_tabl=
e_v_2_2 *)ram_table, params, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D abm-&gt;funcs-&=
gt;init_abm_config(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; abm, (char *)(&amp;ram_table), IRAM_RESERVE_AREA_STAR=
T_V2_2);<br>
&nbsp;<br>
@@ -684,11 &#43;682,11 @@ bool dmcu_load_iram(struct dmcu *dmcu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;ram_table, 0, =
sizeof(ram_table));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmcu-&gt;dmcu_version.=
abm_version =3D=3D 0x24) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params=
, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resul=
t =3D dmcu-&gt;funcs-&gt;load_iram(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dmcu, 0, (char *)(&amp;ram_table), IRAM_RESERVE_AREA_START_=
V2_2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (dmcu-&gt;dmcu_v=
ersion.abm_version =3D=3D 0x23) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params=
, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D dmcu-&gt;funcs-&gt;load_iram(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dmcu, 0, (char *)(&amp;ram_table=
), IRAM_RESERVE_AREA_START_V2_2);<br>
-- <br>
2.26.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226772877797082&amp;amp;sdata=3D=
sa4MJoUY%2FjVgW3f4Qx1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C71bc54a1a7b7444439c208d7e25fab51%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637226772877797082&amp;amp;sdata=3Dsa4MJoUY%2FjVgW=
3f4Qx1N4KYpFY3QyqZPWVDbRoUmTxs%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488B2003904110CAE92E166F7D90MN2PR12MB4488namp_--

--===============0863297700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0863297700==--
