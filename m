Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A6C2D0F7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B94206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dgxcv73x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B94206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39956E93E;
	Tue, 12 May 2020 16:44:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8963F6E93B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMrtsq42DRAJnJcGW6HoJdqJLq0IywBwXP4GTPrNMy40p8A3vGEV9NIReEaXlpUdd8pcIJLR4P7TaRGvk0tiTJg46WkoGNLAl0gbK3kbH7iWtJTvzysNaGBXthQLYl03c87TpnvSlowCszq+E5r+16WuyBE1PsAkJX/E5VaZuKxSu9do+WjTO+7SaeHIHNQtu3GolB2nqdXWk9xm5oDAkezCjmlC+obRxbfHRWe1rFNz0CfGO65Dhklh/zk5iLf9yJeC7RajlzQv9HlrAuHoreXzO1UMT5u+KLP5xL4EOljqY1KMTojwH72FdpeSyuJyIvF4rbp87oaAfbJtfnuwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKgivYnwzCXs5HUvKOcQXOE16VIPKFsjLazGEIIunC0=;
 b=JQQ2SKl/FNx+zfUcYxrfT4MIIQFOiT/yTS+tG4uWEDuA01E7NlcmjuI7CbnSe3nVMYOQWdCfr70AKwh4QoSJpAYVBYIA9MGBcOvz83zbh5oOXZ37e9PG/iJt4A5NDCMMika1NUfbwsJatBb0oVlV89ALkjLGVk9+yQPRnPTLUfliowaTjP/vrA+1aqTVTEpw2uZ5666q6ASP8p9hni2ssp+UYxtV0SlxuelpPwIrnw6X6SZvGy+RurmPJe6gfqYLTnKH4k+y7JSVEOekneBEVom6aNEcTbQr8amqDxgwmfHv27Kcov5uBn6RVBYnkPD0RfvkIGIE9CJBziQm/EqPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKgivYnwzCXs5HUvKOcQXOE16VIPKFsjLazGEIIunC0=;
 b=dgxcv73xgDiL65H8QENVsGqDdWIZ8h3wWaPmnYxNJXua4fm2B7sUzKvp58UJvCBdWqPMFcDlBHs64rVBXO82A0c8y4eNB3ywW78N7ciYH9XwhtMlSdwPj5uTzozX+mpA5Sbe+G6vjfhXrxEeP8RRMFvZU5jJoTFMGnRMO+bgtG0=
Received: from MWHPR14CA0023.namprd14.prod.outlook.com (2603:10b6:300:ae::33)
 by BN6PR1201MB0241.namprd12.prod.outlook.com (2603:10b6:405:58::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:44:38 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::55) by MWHPR14CA0023.outlook.office365.com
 (2603:10b6:300:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 16:44:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 16:44:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:37 -0500
Received: from hwentlanstrix.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 May 2020 11:44:36 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/display: Add DC Debug mask to disable features
 for bringup
Date: Tue, 12 May 2020 12:45:04 -0400
Message-ID: <20200512164506.26861-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512164506.26861-1-harry.wentland@amd.com>
References: <20200512164506.26861-1-harry.wentland@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(33430700001)(26005)(6666004)(186003)(44832011)(316002)(2616005)(86362001)(336012)(7696005)(2906002)(8676002)(8936002)(82740400003)(5660300002)(356005)(426003)(478600001)(81166007)(70586007)(33440700001)(82310400002)(36756003)(70206006)(6916009)(4326008)(47076004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae48ce99-e9aa-41e2-73d9-08d7f693c2a3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0241:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB024108765E7248742E81D6EE8CBE0@BN6PR1201MB0241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qRESWxdLa65lxfMwSQx2X00SiWHBRmbX2A11BEgwmUftWj1zB8o5Y7lEyPh+6rmQxnIVfBmjonmRpjhFgqVcp2GIllxb6AMGchcbQzbgajXdq8pfvEo7P6a4pCuqQcAuyPiD0+k8Jixfvyuj27A1GT+/gLFcCN3y9Vk5voqHtGvCmDcjI1QTANRuzSLocUvd4cnQX0H4bs6ZAxNg6TCzBDjzBob5aQ5boiBFuGw8+loccIshdlStJahmOd+mQ081TvlSyKDISwPe4tJc4vQ2hQBXO5C8z99cvNN4E2N9J59AnMhJ9W3hqfqd1zmch19x+RM8LahjAPwsFV8bLjdhezDXSC+o+12zPXvypVVrBTweiCMB0xGsbMD7onRFHWfnGhN0LFEJqXnJtdkIsxEfcdaQvnuKTq7ZaXB413A076E/w6UAQMyK/O7nudZCAPoJsF55ux6L1g4doD2r1ruiSxVObu7V+wzXNb40/qFm2xgjSAsyZVnsKn0Djj3jT4tWpg5jTxjZ7M0FlQEzmi+/EYTpWYAnyTh2v6oCVijubBX5AISqAExuY1rk8OKlFpZNmheiOZbV96+GE1oCQHiDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:44:38.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae48ce99-e9aa-41e2-73d9-08d7f693c2a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0241
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
At bringup we want to be able to disable various power features.

[How]
These features are already exposed as dc_debug_options and exercised
on other OSes. Create a new dc_debug_mask module parameter and expose
relevant bits, in particular
 * DC_DISABLE_PIPE_SPLIT
 * DC_DISABLE_STUTTER
 * DC_DISABLE_DSC
 * DC_DISABLE_CLOCK_GATING

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h          |  7 +++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a806cb55b78..13c8ccdb2948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -173,6 +173,7 @@ extern int amdgpu_gpu_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern uint amdgpu_dc_feature_mask;
+extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dm_abm_level;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 589000938ab6..76707491657e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -140,6 +140,7 @@ int amdgpu_emu_mode = 0;
 uint amdgpu_smu_memory_pool_size = 0;
 /* FBC (bit 0) disabled by default*/
 uint amdgpu_dc_feature_mask = 0;
+uint amdgpu_dc_debug_mask = 0;
 int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = 0;
 int amdgpu_discovery = -1;
@@ -714,6 +715,13 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
 MODULE_PARM_DESC(dcfeaturemask, "all stable DC features enabled (default))");
 module_param_named(dcfeaturemask, amdgpu_dc_feature_mask, uint, 0444);
 
+/**
+ * DOC: dcdebugmask (uint)
+ * Override display features enabled. See enum DC_DEBUG_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
+ */
+MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
+module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
+
 /**
  * DOC: abmlevel (uint)
  * Override the default ABM (Adaptive Backlight Management) level used for DC
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60fe64aef11b..bf347ca43064 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -918,6 +918,20 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
+	if (amdgpu_dc_debug_mask & DC_DISABLE_PIPE_SPLIT) {
+		adev->dm.dc->debug.force_single_disp_pipe_split = false;
+		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	}
+
+	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
+		adev->dm.dc->debug.disable_stutter = true;
+
+	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
+		adev->dm.dc->debug.disable_dsc = true;
+
+	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
+		adev->dm.dc->debug.disable_clock_gate = true;
+
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index d655a76bedc6..92126c54cb1c 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -150,6 +150,13 @@ enum DC_FEATURE_MASK {
 	DC_PSR_MASK = 0x8,
 };
 
+enum DC_DEBUG_MASK {
+	DC_DISABLE_PIPE_SPLIT = 0x1,
+	DC_DISABLE_STUTTER = 0x2,
+	DC_DISABLE_DSC = 0x4,
+	DC_DISABLE_CLOCK_GATING = 0x8
+};
+
 enum amd_dpm_forced_level;
 /**
  * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
