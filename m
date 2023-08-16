Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B7C25B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2A210E3CD;
	Wed, 16 Aug 2023 21:32:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C301910E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EchHxajYa7K6b/C6ACgGVChR8iJlSLduHy4+Gp2aJxRokQZQ1N4d9SsRleYkxPeQ/s/BDj0P77vlmcSu/hUiY9dkhxwDiBbcyX67/hB2JVLuGNJRmA88AMhfQdJ3JN+parQYFR3TPp+PMI6ELqcScs7V4JrckQ+/LOBk1fHAORqKfi8grnYBfahYmGYkvxwVVi0HF7yXScCPwIWMm2L3WcKCs6mWfA2Z7O+I/bQ1cJdObKdo41FvW/FpRwGiWAVWNvUTRwmPUvKxnkByO4x4zPakGzfymeolWbBKMcSxqG+ESc09coUbvmEa3RkItMsJubEzjRC3Xx9L1e4k1h2GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi8dEtK0iEiFuFM/OSQME+DmO/YnSJxsT9JS2Pdp4RM=;
 b=QfKfUlhiQuxJT6Pr/9wGqXKBz+5mV6re7s/9FYfNL/UUMkxB/yo2KWYifPcehe8dzuLuMz6Zu7mphwuomCBDcQ/MHw63rsNQw5292tHujWKYrYUIpaYSVKh/FlTS9cKhrvKSwH4pMxhDjbRUNY95jc1xIRPq0LexmB4WC2cGD4xEdqgvfdag416vQiVaCpu2V8FJChlbmu7UF7hulfKRgWN1VePRXXWScLQGBIUlrgV8rChl7Kkc/W3fosRMdSkVj/suJMsv87d5KP3As/rOGARwRsTZ6JIo9k5dvPFIKVjWZkcN+/imS5SQigsLJd2Mwa+EMAjG3XTeBSmrynSphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi8dEtK0iEiFuFM/OSQME+DmO/YnSJxsT9JS2Pdp4RM=;
 b=LRSAmDcBi3Hhi9Ok5suRxwgqlHCoDXtzTDjDj4vnKnigr9nhH2b5Af632jKxeJwY2XdQThIWsuQLEA9xE4QYonyIWA8lnbJqU+Xyd7dmLMPWLacF4qrAVuXXof4sO12yc4a/D4Ni8QFiPrgnKGhN6/PPNxeQ1J6FYsrcGn5O9H8=
Received: from CY5P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::38) by
 DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 21:32:25 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::84) by CY5P221CA0026.outlook.office365.com
 (2603:10b6:930:b::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 21:32:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:32:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/18] drm/amd/display: Add new set_fc_enable to struct
 dwbc_funcs
Date: Wed, 16 Aug 2023 15:26:25 -0600
Message-ID: <20230816212626.987519-18-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: ae34d196-fbe4-4aee-92ff-08db9ea048d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht1mH9E/coXntVCR1YHsOkrUQBZly2lIAUngaSZ0ni+ZDuqdT5rGDMHWKDdML6yoh4dYrvEcZbXyDOaaqMyATJMeYDXqCk3AkzTL3o8NBbfAlRrNSG63HfWBfjM73ePx138ED3TrgHhNVlO270auQSEyFo/kzyBL/5qemU7Vc/kXa+x9FJIGIZgUvF3xQm2pSaJo50rulv3fmWmE3cUbdckeuvqr4zZS1eJVyGVoLM4CM7Jq7I5PZeyCZfS7wnSLZoSELTcEhkocmSlWBPOo2ghzTu6lIg7y8b+kxBPE+xobBqytTY4/26VmozbBbNkjZgQJK3Sf1OnH85DSbHj7PHKObodP5A4gk+vhIJpuS2RxH0hxpOIN+bzdLY5cX80VhbKEj0psK1kWLhuBUzgLryo2YRfIYutboDome9jvapoUx7T/kWxfmU9KgYLql+YxOT9pioyMR6T0QVxqnZoBYV3/GD02yw8V9cephhA2ujGJ5kss5RnawnjZOh/Mf8/KB/jrshI1dZNXSs9BKJtol+OACGaeOmP3jHO2pslKZWfzZvi0AwK25Evh/4HYYg7pVzDZFdP0MF/CjyUpKo/oguulH/NaCt8Wy7xWLq3eUhiwcpmPLR4iCwDTBtwTJAA/Iff0k2pRJcLN1goSEelMoKdfdbPq5A5Fp7cFHrnHvPJ+0gwlTSa7ln8VarmFkm3T8pXUj52l1mXnXGiWYIY0i4e7QImN64AwdUu2wZXgnu3KaBPWzqHcxmeCu7fwtxPtA9V/UInGC9vQd2XtmudJ2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:32:25.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34d196-fbe4-4aee-92ff-08db9ea048d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHAT]
Add a function to enable and disable DWB's frame captures.

Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  | 23 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
index 0d98918bf0fc..1b9d9495f76d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c
@@ -130,6 +130,28 @@ bool dwb3_disable(struct dwbc *dwbc)
 	return true;
 }
 
+void dwb3_set_fc_enable(struct dwbc *dwbc, enum dwb_frame_capture_enable enable)
+{
+	struct dcn30_dwbc *dwbc30 = TO_DCN30_DWBC(dwbc);
+	unsigned int pre_locked;
+
+	REG_GET(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, &pre_locked);
+
+	/* Lock DWB registers */
+	if (pre_locked == 0)
+		REG_UPDATE(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, 1);
+
+	/* Disable FC */
+	REG_UPDATE(FC_MODE_CTRL, FC_FRAME_CAPTURE_EN, enable);
+
+	/* Unlock DWB registers */
+	if (pre_locked == 0)
+		REG_UPDATE(DWB_UPDATE_CTRL, DWB_UPDATE_LOCK, 0);
+
+	DC_LOG_DWB("%s dwb3_fc_disabled at inst = %d", __func__, dwbc->inst);
+}
+
+
 bool dwb3_update(struct dwbc *dwbc, struct dc_dwb_params *params)
 {
 	struct dcn30_dwbc *dwbc30 = TO_DCN30_DWBC(dwbc);
@@ -226,6 +248,7 @@ static const struct dwbc_funcs dcn30_dwbc_funcs = {
 	.disable		= dwb3_disable,
 	.update			= dwb3_update,
 	.is_enabled		= dwb3_is_enabled,
+	.set_fc_enable		= dwb3_set_fc_enable,
 	.set_stereo		= dwb3_set_stereo,
 	.set_new_content	= dwb3_set_new_content,
 	.dwb_program_output_csc	= NULL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
index fc00ec0a0881..72b9d9daa176 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h
@@ -879,6 +879,8 @@ bool dwb3_update(struct dwbc *dwbc, struct dc_dwb_params *params);
 
 bool dwb3_is_enabled(struct dwbc *dwbc);
 
+void dwb3_set_fc_enable(struct dwbc *dwbc, enum dwb_frame_capture_enable enable);
+
 void dwb3_set_stereo(struct dwbc *dwbc,
 	struct dwb_stereo_params *stereo_params);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 86b711dcc785..729ca0064e94 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -188,6 +188,10 @@ struct dwbc_funcs {
 	bool (*is_enabled)(
 		struct dwbc *dwbc);
 
+	void (*set_fc_enable)(
+		struct dwbc *dwbc,
+		enum dwb_frame_capture_enable enable);
+
 	void (*set_stereo)(
 		struct dwbc *dwbc,
 		struct dwb_stereo_params *stereo_params);
-- 
2.41.0

