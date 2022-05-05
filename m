Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040A3C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C7A10E040;
	Thu,  5 May 2022 14:23:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A49D10E2AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arA2B+w4/BB/n/8aAD/kD1LYQBCjlBMp2C2w/GSTWy+B4wEg1AcctGGCo+w67s5cAc7BnGt2ziy68Aq/ygB4rmbDaqsMAay0KFClUk8GEasAWL4ydTo+fKGzaQcrpIdrOoNTh0n8dAvwRus1jmbsldi9yQAU5TmG2AJO6ElsQ5ISEIx4JQbh0rspiHB7m3jinAD+DIBffTo/78t63go9jfpk8THMaTve4vOM0AnAL8a6OrwQIDedj93cDDc4EF2HMSKwEVxFDwaFA9rIVMBKq5c+0Z4tudA80+4By11Oy+OY3dRhX2qCanzc/AwRKjWXFX1KU94m65ZHoqgtFCK2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysrfRoaPfkr6F2um+CpD8lIKDLPf88IhLw/fXala4jU=;
 b=AjMP9nbEb9ViHQYWHlFGDNroDf6JqjQG7ieWExztDWlaPA31RtZcBNWjVwngR3apAxqq4300Tac6cZ1xQXhhxfgiGPVAYaEaXJxb6E8WEfFqMWVTOQ4y7JuQx7DeJXcvT7eLgbSUtpWCtUbmIcCKt26UAYdhke7vJNrKkzKUB9KA4ZB4/J9NNBSR6uk/i9XbtmpE4n4rZdaq/p55EuSBoyHU2SeSAtEcHA1Df4r1gGbhWilq1eTO4jR1uorXN8N38R1FZIAL7OvHHTWDRKnG5VzatG5C+D6Gf5Z9AOx4Vb1nJbsBOYogWSU2lcb9CSHwB4/GPbB6jeo8bAzF+Es7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysrfRoaPfkr6F2um+CpD8lIKDLPf88IhLw/fXala4jU=;
 b=jb7nRJZw1j0I7TCgpnlhha3c1BSy9grq51cBGuBsxEpVFUDOevuz2jF9S8sJK1zka2Oe/NFmgo8M1UBH0H4x5wm3cE6IGbVz4tpDvyQuedzTqGsMvZD2era7n8LOL1gFB+f/9IHXgyL1vccSLjaQiU/+LRpZIDCkBgU3Zl64aMQ=
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 14:23:50 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ec) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 14:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:49 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:48 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/17] drm/amd/display: Passing Y-granularity to dmub fw
Date: Thu, 5 May 2022 10:23:13 -0400
Message-ID: <20220505142323.2566949-8-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e16360-a8b0-4d74-9153-08da2ea2dfc2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4967:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB496701DD453F4874846BFDE38DC29@BY5PR12MB4967.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWAUA8sF/oGcP6D8Q2BkMmM759Zc4+aXwqO74MP5aDFa+na1ElZAxuhao22aY6dyVj8xUVX9zfDly8JzDk9wxG8pMqACOnh5/PJZZkzccW2GKgTBq/GfOh4AORggNXQtUlX+0WxYyolnog22mgd6dzBt959PAha1iZQklbUOLJct6dulD6OSt0VJn642+96J0UTHXibJaRruzxOeS5E3S5IOlrvmYf/AxJc3YUMUXQqgHaCh4Gcvzp4PkJN9G1Bc0iYHxF5uRo9tVHFeoWfuJBIIAnaPv9yOHF/2avgaR6169khIDVzPzJBywYZVGOYPtC4AcwcqrFue8NkmiPm7BTu1LI6wrRU7t4AjV+r+A+Oy0/AhpDllu2GKNv3eKL1np3Hssy069fISKDYPmyeH2HFvjc27UN7cFfc1mBoP6HCiPHoT44P5jIhmAfQeK+4P7lVLYVFrspB/NnuO4kUloQBd9zisdadM9nJjL8Og/a1g45EcRS/AKfgZYtR2o/9Nerh+SoFieI108zQYfVnY/xZdjroL38a9sGed5gF9BD08qyI+GQ8KuT13X8eKWBgDG9/NXT1mYHmXrk2lg482loXc4xS5M6sHMqBnOLQHv/umMvPwz4TKz2hRi+Nz8i14017ap/6s9G75vr6zQTh761jWi9d32n6aI9oeRTD5vJjrRnXzFfXHVRcbwYJN1Bl1Wk15YEeOunB22otvKAWVMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(26005)(8936002)(8676002)(4326008)(86362001)(70206006)(70586007)(82310400005)(6666004)(2906002)(7696005)(36756003)(316002)(6916009)(54906003)(2616005)(508600001)(83380400001)(5660300002)(81166007)(47076005)(426003)(336012)(1076003)(356005)(40460700003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:49.8902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e16360-a8b0-4d74-9153-08da2ea2dfc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
The Y-granularity panel parameter indicate the grid
pattern granularity in the Y direction for PSRSU.

[How]
Send the Y-granularity data by PSR_COPY_SETTINGS dmub command.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b1811eb7609f..b750dae0a33b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3245,6 +3245,10 @@ bool dc_link_setup_psr(struct dc_link *link,
 			DP_RECEIVER_ALPM_CONFIG,
 			&alpm_configuration.raw,
 			sizeof(alpm_configuration.raw));
+		psr_context->su_granularity_required =
+			psr_config->su_granularity_required;
+		psr_context->su_y_granularity =
+			psr_config->su_y_granularity;
 	}
 
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 2ba9f528c0fe..d61ea3e2bfbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -672,6 +672,10 @@ struct psr_config {
 	unsigned int psr_sdp_transmit_line_num_deadline;
 	bool allow_smu_optimizations;
 	bool allow_multi_disp_optimizations;
+	/* Panel self refresh 2 selective update granularity required */
+	bool su_granularity_required;
+	/* psr2 selective update y granularity capability */
+	uint8_t su_y_granularity;
 };
 
 union dmcu_psr_level {
@@ -775,6 +779,10 @@ struct psr_context {
 	unsigned int frame_delay;
 	bool allow_smu_optimizations;
 	bool allow_multi_disp_optimizations;
+	/* Panel self refresh 2 selective update granularity required */
+	bool su_granularity_required;
+	/* psr2 selective update y granularity capability */
+	uint8_t su_y_granularity;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index f1411a22cf1e..6883dd5b80d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -333,6 +333,12 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
+
+	if (psr_context->su_granularity_required == 0)
+		copy_settings_data->su_y_granularity = 0;
+	else
+		copy_settings_data->su_y_granularity = psr_context->su_y_granularity;
+
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
-- 
2.25.1

