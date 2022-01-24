Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26874C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 06:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A724B10EAF6;
	Mon, 24 Jan 2022 06:44:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1FA10EAF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 06:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFEvwOcfxNg/j23HlGedWTGfouLX3A/l+MdQlQ6Sji3XjDbnz8hWPcFABdtb4b7WcqDLX4ZEQNLMgPrh9dE2ok8WsktAQMa8Q59SZBCys53F7MYx6RGthIecJlaPNzmYSFqZhAoZVe5n1v1lDgZAeIdl05twvfv9qpm9QY1PlyghdZSEiV3AVhtOkysYYp2OEGglH5XGa6bV4JuKFZ8us96FV0A3/VDuXscNOzEV0pheI9Gk0cQ872B6KrOyWFANJ/7UNIvm5qharLC+tt5LZ9auSOT3vYhoRnQXNq6ReWfLXLmVxpyFEP9xwxG7xKe6ELfVxUUtTK6MF4xG3UNN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGNczNI2CkQoYkw12GqHj9seQd/R+WuyTUgoZf3+R5M=;
 b=QnRHWSnPOTlqC7tcV03debulFjNAkWqvpnxzvpi4pt5Q7kPcD+nmanNw8JYCs1XXurhSKAeqhDMfb6qLs7jljURL3Ze3eF10A8imirHp62IusMKUNxqehkHEN9st8HKDZ+uHR3WL6vKXVwvihDUzR5FwDLc5Gl3z0MAlWCi7aVp0eTlwP5Zl1tUu4+2uu/+wr3wXxWpF20XVcXAf2w7HhTuX6BpHs5bF9PyK4jS82TdkdhTzZv2FbQrCuqF0jMb8TI/bOD2/gZxHcQWgLXuWzh5hgEY64Q6tKz9/aCX02bUOJpVYzaJstRKxqfLCvDoRp75J8hauRXknX+I+7A9S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGNczNI2CkQoYkw12GqHj9seQd/R+WuyTUgoZf3+R5M=;
 b=Z7GczrWdknV9goX3vqP5ZVWTeyHVxj5dyQiW7AyVzqoLYJVznAFGWxglSo5cHqAuYyxrrfmQRotCD9WNbOYl3XzgfnSk1HoL6MEKKVeMnC/TCwe7ti+o0p6uuKGEG9D0HXQiCDayoYE2I+KuWecIrkkjn6sN2HeFYM02bhxvmoU=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 06:44:02 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e8) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Mon, 24 Jan 2022 06:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 06:44:01 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 00:43:59 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: add get_dpm_ultimate_freq function for cyan
 skillfish
Date: Mon, 24 Jan 2022 14:43:41 +0800
Message-ID: <20220124064342.273055-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4568d0d-3b52-443e-2b53-08d9df04e7ca
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3303296497B0E3F498187CF7FB5E9@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt6Iq2B4Wg8dj8118do69kSL8WfxTQ970TtQM8MGSJIBJ2Xbygn5H8u8LFDW8cDDDUD5QKDH//yCxzPGrRM2b5x3hJaoQM+NqwUjB5XZhyH7L5eZ5Id0vYhUWKl1z0VcTzcmgdw41amHcpZsEJDDpQBEcDsDXn4R9OxrBxzWxi1w2K9pOQqEntp5cKrDEfFCFZpIdEk4JH2AAwHN4rDcx/RsN9DMrh74KvJgXhzYo3IRCH64kTzdf3SZ/G6EnUqXfCktOtbcQlDjc0l09d8buq0vtOQ4GN5Jr79khM0m65n+Q/q/kcanc0+mDSP5R4CB+0y6QE3/0tiDOcCUVzuG8Dt05XEbgE/vp4c27od2pzdVmfnUDJmbNn8YispCgokDnegkWT0iV7BgahYwgBRWH/uBeYms6Apd+N9vUdrtQonBVx/6OC0xHJ/tGVsrKBdeUbEWaZLQxLG8m71xakVtYm1PNckZsvOTFb+Vg69dYtRoM144c61y2TEb4jFD5V+UGgrGdptCQXxmKKM3jtCU7Ds9qGXSIQ9yQUwkhpHoLAV1pSvnkyKxuqABHn8ixwgyuKSQaKBVqKw9QV5WCf8BMX/mxhUsJegtevQWKEhGCxE3O4fWSd9DtjjM+eD7VpWYgDeDpblz+OTekXoAPaAHpOwx6huh3X8Qua4HjSH5trIDyCRJiNyDMp+SVDozhmuh3RNB/Ul/1d5XKwtsriKOLpB6qZ0ov8daiiAybqQiYIfbSsOv4H9GCja/LM6nyK/D4Is1BgE4JATTXK4UNAsbB1U4rQTfwuOX/O2CQe8ALGg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(36756003)(336012)(2616005)(4326008)(16526019)(316002)(70586007)(36860700001)(40460700003)(70206006)(7696005)(8936002)(8676002)(1076003)(83380400001)(6916009)(86362001)(426003)(54906003)(81166007)(356005)(26005)(2906002)(82310400004)(5660300002)(508600001)(47076005)(6666004)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 06:44:01.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4568d0d-3b52-443e-2b53-08d9df04e7ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some clients(e.g., kfd) query sclk/mclk through this function.

Before this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           0Mhz

After this patch:
 # /opt/rocm/opencl/bin/clinfo

 Max clock frequency:                           1500Mhz

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2238ee19c222..665905a568eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -552,6 +552,14 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
 	return ret;
 }
 
+static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *min,
+						uint32_t *max)
+{
+	return cyan_skillfish_get_current_clk_freq(smu, clk_type, min ? min : max);
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -565,6 +573,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 	.is_dpm_running = cyan_skillfish_is_dpm_running,
 	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
+	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-- 
2.25.1

