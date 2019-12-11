Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF7C00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE542077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rkH1DbkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE542077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF84F6EB72;
	Wed, 11 Dec 2019 15:33:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D866EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpNEBX8vDKPCSQFCLhXNxHMNj/W6f/mve8sXaxssvsRVvGUD82s0NZAh8KYqD3aF975pmOXoMBtXNI+io2gQ6IvmEZBdi+9JgDp6MmiBIbtgiBM7xSJ2NKX8CwDPXGXlvQaLWjl/Av1N/Mt09FWbjNMWdJ5s0tCP2/Q3Vdo6ZDPZ2ls0T2oLP6xt6Jc3CICjS5VfIsSDz3vhqVee+kmI6ojIAkvVEMggJcMd2SWbqE3OKDQyrOH/YQs1+NOvNEshpz6a8svQ4DggT4owg+jaNwPW73zxeMcTema//fFx2R5Ccit4byrRnRiLjl9gUI4wa45vb+h8yypgWlAyKl5D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAJK8zAlWM+VTzHpUaZaDp7BNfFjrNzppCS8i/0tayI=;
 b=ag2MZqI5Hpb43sLs7NzGUtLI62PoD5T2wLsHg2aoRO7eN9tVKH30+IgTZaQbk2wcdg1CFbC502Cq8iTd7TEl0Msbp6fAKmBEsbikPKL237gCyevl3xNIpFXrFZQQS52VLWC105Z963Pbg6CZQXs66BYgVCaCtDtjbjc51SVqpHFsRqfFFnoAl9lhk9Kw7bpgPFtvsgcjTwt6FvcEaZbv0vNwgQRwrnIoAo0bu0dNIb2+8neQ/UX/yqj4bhwD+T+o3K51HrRdNsToFCr9bs5dUj+VOQV49rnX1aM/y5dNHLbGr2g53RIYcTCUbKl8bF+2Ll77aZVGYQljPcL7dr27nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAJK8zAlWM+VTzHpUaZaDp7BNfFjrNzppCS8i/0tayI=;
 b=rkH1DbkYEq35WBNFExKDeHQZpQeF8/1r/+N+Dd0Xuq/031x6hcvcOsmeITt5Cam10LWnwR2sf+DyaoMv0/7Xx72qwlTgLJy6xB9onC0vvQ4gqiX0JbtZWtm/4OS3aPRCMqL6OGMauZ/jpYmuzLS5tCY7tEoe0uCwlO7w+2akUMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2570.namprd12.prod.outlook.com (52.132.181.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:16 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:16 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/39] drm/amd/display: HDMI 2.x audio bandwidth check
Date: Wed, 11 Dec 2019 10:32:15 -0500
Message-Id: <20191211153253.2291112-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad9afcca-effd-4d4e-ee99-08d77e4f7122
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:|MW2PR12MB2570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257016591D0BCCB76196FB06985A0@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(54906003)(81156014)(81166006)(36756003)(66946007)(4326008)(66476007)(498600001)(8676002)(186003)(66556008)(6506007)(26005)(1076003)(52116002)(86362001)(8936002)(2616005)(5660300002)(2906002)(6916009)(6486002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2570;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7+pl8Q56sSHsAwjS5Lpa5HwhmC3a5ZcirWNOd3cKmU2J2Lq+HVbfh6wQPDfmS1iltM0wAfMFRVIOgMPNXdFafiROisENL0K8FHxfALOMEByKOh8ZE+AObY8h9KhAzd02QMlAIflKg10VdFRcokFGcUl/N9nGBO+TcPCxDenRuh8Nyed8WI65QU7BaiUOCTRBgyf5Keiksunbini5/5+qSf+OwrF7JChl7vWfYjyWMaFJfi3jBT9yg2SWw1f3W902zjEzl9VEpRh7bwNqAagKIUx8XB8WvPJ5b7xIc6RRkDyCJFbsOgA3bnIsVmfkhGjSUjZjVklXQdDyCode9HzmlsCADqwLzW6vuvsNCPtOsI/okO5sGr2P98RQUTDvvAd27Z+jnQeoan8QgWosOj8IK5lnbpuEjFhuKJn29DYcqtH4SIi4RpClO8Vefic4+3e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9afcca-effd-4d4e-ee99-08d77e4f7122
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:16.4314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8HITO0O4W6pv2ZnNzr0OlZjPcLqQRrkmK9rUmsTLWa8nOPyaYYN+Se4hBm8qvmL8MXrOnzBAXTty/DrXDn7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Chris Park <Chris.Park@amd.com>, Harry.Wentland@amd.com,
 Charlene Liu <charlene.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Add HDMI 2.x audio bandwidth check

Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  6 ++-
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 +
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 0c19de678339..6c6f5640234c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2811,3 +2811,51 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format)
 		return -1;
 	}
 }
+static unsigned int get_max_audio_sample_rate(struct audio_mode *modes)
+{
+	if (modes) {
+		if (modes->sample_rates.rate.RATE_192)
+			return 192000;
+		if (modes->sample_rates.rate.RATE_176_4)
+			return 176400;
+		if (modes->sample_rates.rate.RATE_96)
+			return 96000;
+		if (modes->sample_rates.rate.RATE_88_2)
+			return 88200;
+		if (modes->sample_rates.rate.RATE_48)
+			return 48000;
+		if (modes->sample_rates.rate.RATE_44_1)
+			return 44100;
+		if (modes->sample_rates.rate.RATE_32)
+			return 32000;
+	}
+	/*original logic when no audio info*/
+	return 441000;
+}
+
+void get_audio_check(struct audio_info *aud_modes,
+	struct audio_check *audio_chk)
+{
+	unsigned int i;
+	unsigned int max_sample_rate = 0;
+
+	if (aud_modes) {
+		audio_chk->audio_packet_type = 0x2;/*audio sample packet AP = .25 for layout0, 1 for layout1*/
+
+		audio_chk->max_audiosample_rate = 0;
+		for (i = 0; i < aud_modes->mode_count; i++) {
+			max_sample_rate = get_max_audio_sample_rate(&aud_modes->modes[i]);
+			if (audio_chk->max_audiosample_rate < max_sample_rate)
+				audio_chk->max_audiosample_rate = max_sample_rate;
+			/*dts takes the same as type 2: AP = 0.25*/
+		}
+		/*check which one take more bandwidth*/
+		if (audio_chk->max_audiosample_rate > 192000)
+			audio_chk->audio_packet_type = 0x9;/*AP =1*/
+		audio_chk->acat = 0;/*not support*/
+	}
+}
+
+
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2b92bfa28bde..2cce8ed014ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -598,7 +598,11 @@ struct audio_info {
 	/* this field must be last in this struct */
 	struct audio_mode modes[DC_MAX_AUDIO_DESC_COUNT];
 };
-
+struct audio_check {
+	unsigned int audio_packet_type;
+	unsigned int max_audiosample_rate;
+	unsigned int acat;
+};
 enum dc_infoframe_type {
 	DC_HDMI_INFOFRAME_TYPE_VENDOR = 0x81,
 	DC_HDMI_INFOFRAME_TYPE_AVI = 0x82,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 220d5e610f1f..dbf6a021d0d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -278,6 +278,7 @@ struct _vcs_dpi_display_output_params_st {
 	int output_type;
 	int output_format;
 	int dsc_slices;
+	int max_audio_sample_rate;
 	struct writeback_st wb;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 15b72a8b5174..66ca014a6b92 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -454,7 +454,7 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 				dout->dp_lanes;
 		/* TODO: Needs to be set based on dout->audio.audio_sample_rate_khz/sample_layout */
 		mode_lib->vba.AudioSampleRate[mode_lib->vba.NumberOfActivePlanes] =
-			44.1 * 1000;
+			dout->max_audio_sample_rate;
 		mode_lib->vba.AudioSampleLayout[mode_lib->vba.NumberOfActivePlanes] =
 			1;
 		mode_lib->vba.DRAMClockChangeLatencyOverride = 0.0;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 7a85abc53d05..5ae8ada154ef 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -177,4 +177,6 @@ void update_audio_usage(
 
 unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format);
 
+void get_audio_check(struct audio_info *aud_modes,
+	struct audio_check *aud_chk);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
