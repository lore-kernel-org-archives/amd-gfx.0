Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B2C4743C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB3660FF2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB3660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E7989B97;
	Tue, 22 Jun 2021 01:13:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32FF89B97
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 01:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYyYjmoy4m7xUlcrx39CtWIo4RU8VgGe/qby7fH4pGEHN/5xEHMxQ18wATW+tf50Y6b2U6B7O1e3sc/ssxXxIJX50KPVjACTUj+EqtjpQBLkDK8ZaOSnoEQ5PVEQ238vUtUNbWn4hS1R9or6rGLeUAnL8NJJrntlcUtrrc3cciDSvlJMikJxMHYsGbjVrxspXSJKdMqTEZZFVyrcXr8WOqLnZj96oo9kB5CzCF3q8Hyn0iC2MhzVrMbfpOFoP2SGGxLJ4sBN9yR8olCB7JwX+aevsjUUw58/SHgdvBdpRz7MOcFr8K2FR/07AKiw9bQaHErldxlF0ZGLunOrttftAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTXw8RCOd0+bpjkwUY78j+HBrBMII8rqxJoPKyg6MNE=;
 b=Kzel3H4x73h8gAtNBbjWwdDJjqP91lMw3AIOU/1nJVC72AT5ZwLHkORMagGcovtJcORSgZNNYc0Axjt25n5ZpyjhqVYlA2cGnOQrACmYlC0Y4p/VwTgdWXpWFetJRFMqVWUAd/ZtBJJWesgIReSzY3GXFzwp2SbZImyV43kHU5/Xq8HcVkhrQzJYEbMXqn74ryUioxRZKmGKsGdGyBB92+Vgj6Lt648UIZMJ5iwvlUxLzreFvsxkC7DqfyP9uyS/HwY8A9ccXHuzJv9x+pwSMCCm3fwMxh8vwUio5HlASIxu2l1pwbOxRIAfDp9rftgFLWidXxVFZz+7hPiJRtlpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTXw8RCOd0+bpjkwUY78j+HBrBMII8rqxJoPKyg6MNE=;
 b=ajLm6qT7bRUi3pAK9TSDYYO2o+LmVhYwCqe/AT/t7Uo/KMD9kv2FhP3jtjRZcJtERpVqyFUvJn6Mlncvstefhv2O/EWabB2rXE5aYUQ10Pf1TIMN8IcobEaWvXqJrSxc/m6qwGONeN/IaLJ/Qn68Wfv98A8KJliJxfjSAGvJROs=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 01:13:36 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::3478:6aaf:336b:395d]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::3478:6aaf:336b:395d%2]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 01:13:36 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij, 
 Nikola" <Nikola.Cornij@amd.com>
Subject: [PATCH] drm/amd/display: Enabling eDP no power sequencing with DAL
 feature mask
Thread-Topic: [PATCH] drm/amd/display: Enabling eDP no power sequencing with
 DAL feature mask
Thread-Index: AddnA9EwMkD2iF5JRRSEtqinE3pAmw==
Date: Tue, 22 Jun 2021 01:13:36 +0000
Message-ID: <DM4PR12MB521425D1F9F673AE63ECFC789E099@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0c85870a-3081-481e-b0a1-dca89caddbdb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-22T01:11:15Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b0455d-dff9-4bbf-9c63-08d9351af64e
x-ms-traffictypediagnostic: DM6PR12MB5550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB5550B6DA9ABE27D469B50EBE9E099@DM6PR12MB5550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeBbVzAqm6GWzNjvQYArwnO/RergTb3WxXeCSKFtF6Y3qiveadvcz7T2YuQV3WNNU7LmNIxsZNifU5Q947wgAajeeR3WkB1SLJXoT9kVoG+9WfWpHzeO8xBhQhj5/nbRo3w4oyCaIfC91Vk0XuX0HsxbSwe2wfgPJdt+1iJ2EvEcoyyJesTfPnHeavx7lddLaVPRRbsoRyDetoQs2dXXITN882xlqn1/MYyWgxQFPCEibTxs6Q7efbGb+He4Ou8aONLTYcukQLrBmVMkvibuqeaYcO0fWu9pUpOldi9s9wFpAggiCjik0tGvaH/Q46Z5PrVkQNzUndihoZlyCGN5Recth5Aa3fAHfmbw0It5SD+s16Pufl0mV2ZV1HQ5gajMUWlJYQVOELL/vdTV4R684+lt8IToYxzoRbdkeqRjes6YtDA+Riw2j4/hA4Bq63AB7FbifrDIPBYmeOiKMBHuKkTtFaMRqFYnWhffGZVdAt/qHix+SO/7AVpJbuzMnc7Fq8wmGC2HCbkwUqgIzDKcagyj0Dio+rFz0W9OZI2j1dSyYwighHd8L+JnqZP+PnF8K+2M18r4cvak7vvOEhc1MTRhHp5LR80kIYP3qibVBPM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(38100700002)(122000001)(66946007)(55016002)(26005)(9686003)(76116006)(6506007)(316002)(186003)(83380400001)(52536014)(71200400001)(8936002)(2906002)(478600001)(7696005)(110136005)(4326008)(6636002)(66446008)(64756008)(66556008)(66476007)(33656002)(86362001)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xet6oYqmExaCTzpQBW84jQVAze0Y51z3LBc63yWeXoYfGbwMBV/IeQByfmmH?=
 =?us-ascii?Q?brdBnjv1eDXLVA/H/vp8nlZ+rWUVMYCrtIzUZfXvoaavpofCujIcK4Iwfps+?=
 =?us-ascii?Q?bNa2CYYP0IvaQ1as+cx6PM2Q/irORscaILLWXC2/9tnccX+MS7MKau7J+b3X?=
 =?us-ascii?Q?NPtMtcDSeqevulPtBCNk8Y58mLFQpsdPJ4lFiNGaqQiBnsq8jZKzs4Bcong3?=
 =?us-ascii?Q?X7oxDz/9PGn4T631MPlOHTxetWJYUMLfs+B1FvQ6lhNJhuIXYnKzVnRiC72+?=
 =?us-ascii?Q?E13JN62V0AXHqvL4PY8OS/B7nEaw9Duu7HYmV/PxAzXIoRCYI4MpjAV6E4bR?=
 =?us-ascii?Q?0XaR62Qnxt/qzvdVhsxQiK9JN2Vv/G1egDiXpgaGhOwyTY9p06SlRatsvJTm?=
 =?us-ascii?Q?XXwUwJeY+WS66a/4i9vrNmZMNQm09Gko9j88fIX4mmVP8AuKDXAh0xld1GMv?=
 =?us-ascii?Q?wtDaFMe1VfVQgtDXy/noghSv+pi94gySGRlb049J37WctibhB9QOXQcJxjwC?=
 =?us-ascii?Q?fhpu2kEIIg9OZeJmib8TgWpVX15DtWiszC+GzCjMcCuwe8spVvCGzbVvCHlT?=
 =?us-ascii?Q?/VgYtItmPHjQsJ5aLGjvtN+Q72avuBmUSa9QrsUsE2Xnc+IwxDjzv7gakISX?=
 =?us-ascii?Q?sbDPSgK7Ub0h5f8RfGgVw2fyJvI7Y99Kh+/Ok5+otO6l8lgfv/zEcDdiQtq+?=
 =?us-ascii?Q?l92/bSwfsJrX2n7u5sVt6JSxjzQPXVTPAhptRicoocuFbw2OcdqqOAq8mbbJ?=
 =?us-ascii?Q?gEZMqHg5MO8YeUv9Bbh8kG422RAC91CGcvNlTbmDq2eCBjZDxoAdkhaGNmNR?=
 =?us-ascii?Q?ZAFGYdhHR2HIKDMsc2lhZ8+dJy+FKEKCTH67TozACQotiPOUzNEm4iMYHfTL?=
 =?us-ascii?Q?SYSdDdajFZZV3NJrDuYLQYvH4/jvolNVlE3n6JXUeiXNtDHMXTLtxg1b6sjS?=
 =?us-ascii?Q?CIEa5WnSaeuFXw/5t0wXP4M4htQ/7Um87BpObEaLONQquNzYtJrolQ8EkjpT?=
 =?us-ascii?Q?UpuG31BV2tpwRgLDU6WaOY4WIWJycHx25oo47R9WEbDfmZ7VTMjkHX86Rk+Z?=
 =?us-ascii?Q?7TydJwY3qykC6huU742t/8hiKaXyytjoDhl48MB6zBuNY31mblpnRW8eQD+7?=
 =?us-ascii?Q?flDr3DFRONlm55R6rl5ox548gr5juUtAq72d3QTzxuB5tqXMXFsIePyn8tPy?=
 =?us-ascii?Q?yB99vtsK6dO5vTfMB35dZR020vlo1aZNIMjH4pZPD75CWdzu56aa+nOTZu74?=
 =?us-ascii?Q?CkX+hwEymYkDKd/gHvu/SAf0iYz2A0++IgDK34OPOjH8jKDYmsHdOWGgYbTo?=
 =?us-ascii?Q?QfGZsHvriyVcpVO5imC3LqXU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b0455d-dff9-4bbf-9c63-08d9351af64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 01:13:36.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjBEJQsyKBpFWdtnV/uli4j17/Ceu8noXVcByvLayWTDBwQe8aMJfzZimNmUeIiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

[Why]
Sometimes, DP receiver chip power-controlled externally by an
Embedded Controller could be treated and used as eDP,
if it drives mobile display. In this case,
we shouldn't be doing power-sequencing, hence we can skip
waiting for T7-ready and T9-ready."

[How]
Added a feature mask to enable eDP no power sequencing feature.

To enable this, set 0x10 flag in amdgpu.dcfeaturemask on
Linux command line.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Change-Id: I15e8fb2979fe3ff5491ccf1ee384693d4dce787c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 31 ++++++++++++++++---
 drivers/gpu/drm/amd/include/amd_shared.h      | 10 +++---
 5 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3de1accb060e..b588cf4398db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -159,6 +159,7 @@ int amdgpu_smu_pptable_id = -1;
  *     highest. That helps saving some idle power.
  * DISABLE_FRACTIONAL_PWM (bit 2) disabled by default
  * PSR (bit 3) disabled by default
+ * EDP NO POWER SEQUENCING (bit 4) disabled by default
  */
 uint amdgpu_dc_feature_mask = 2;
 uint amdgpu_dc_debug_mask;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c0a3119982b0..abba26c8f20a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1174,6 +1174,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
        if (amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK)
                init_data.flags.disable_fractional_pwm = true;

+       if (amdgpu_dc_feature_mask & DC_EDP_NO_POWER_SEQUENCING)
+               init_data.flags.edp_no_power_sequencing = true;
+
        init_data.flags.power_down_display_on_boot = true;

        INIT_LIST_HEAD(&adev->dm.da_list);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a70697898025..7f1d2d6f9de8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -297,6 +297,7 @@ struct dc_config {
        bool allow_seamless_boot_optimization;
        bool power_down_display_on_boot;
        bool edp_not_connected;
+       bool edp_no_power_sequencing;
        bool force_enum_edp;
        bool forced_clocks;
        bool allow_lttpr_non_transparent_mode;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 53dd305fa6b0..013d94c9506a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1023,8 +1023,20 @@ void dce110_edp_backlight_control(
        /* dc_service_sleep_in_milliseconds(50); */
                /*edp 1.2*/
        panel_instance = link->panel_cntl->inst;
-       if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
-               edp_receiver_ready_T7(link);
+
+       if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON) {
+               if (!link->dc->config.edp_no_power_sequencing)
+               /*
+                * Sometimes, DP receiver chip power-controlled externally by an
+                * Embedded Controller could be treated and used as eDP,
+                * if it drives mobile display. In this case,
+                * we shouldn't be doing power-sequencing, hence we can skip
+                * waiting for T7-ready.
+                */
+                       edp_receiver_ready_T7(link);
+               else
+                       DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
+       }

        if (ctx->dc->ctx->dmub_srv &&
                        ctx->dc->debug.dmub_command_table) {
@@ -1049,8 +1061,19 @@ void dce110_edp_backlight_control(
                dc_link_backlight_enable_aux(link, enable);

        /*edp 1.2*/
-       if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF)
-               edp_add_delay_for_T9(link);
+       if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF) {
+               if (!link->dc->config.edp_no_power_sequencing)
+               /*
+                * Sometimes, DP receiver chip power-controlled externally by an
+                * Embedded Controller could be treated and used as eDP,
+                * if it drives mobile display. In this case,
+                * we shouldn't be doing power-sequencing, hence we can skip
+                * waiting for T9-ready.
+                */
+                       edp_add_delay_for_T9(link);
+               else
+                       DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
+       }

        if (!enable && link->dpcd_sink_ext_caps.bits.oled)
                msleep(OLED_PRE_T11_DELAY);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 9ab706cd07ff..d326339cb3cd 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -223,10 +223,12 @@ enum amd_harvest_ip_mask {
 };

 enum DC_FEATURE_MASK {
-       DC_FBC_MASK = 0x1,
-       DC_MULTI_MON_PP_MCLK_SWITCH_MASK = 0x2,
-       DC_DISABLE_FRACTIONAL_PWM_MASK = 0x4,
-       DC_PSR_MASK = 0x8,
+       //Default value can be found at "uint amdgpu_dc_feature_mask"
+       DC_FBC_MASK = (1 << 0), //0x1, disabled by default
+       DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
+       DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
+       DC_PSR_MASK = (1 << 3), //0x8, disabled by default
+       DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
 };

 enum DC_DEBUG_MASK {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
