Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EBDC48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B578D61364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B578D61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4336EE33;
	Fri, 11 Jun 2021 07:06:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C821C6EE32
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:06:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzO8qz1/kORzMRvWM1X1PmMZVix5MSOCYcoeyvG3OZyEQ3BEzl9xwIQAZQCAbEJ4/yRMHYuhEKzGcu7Q4A+n2/eacXDnx+E8Cc8kpiKVHLnNuh2YpL3q8N4AWEw9bvynZTA3ejLF7Q0cIB6SBHED0Oqh7CwPM3NroYLJo6/5HBFjIDrnx6K4MSmXP3M3RtPDfFScat8cCeY3hXZKz0Qoxf8GRvf+LqmWWDB9ia79Oxl+Mi5fwFxwH5dXA43D0z57wpYNCNU6ou6mIMOv2H/7qe7KxUYiNuI+h+/wmdJM92FD/iWaRO5VDlTul46gp1ueGteyPPqsMrf0u2Tna6bscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1ZJ2S9eNZlgLOTPVD7o8gBJYqPZ8Qm3dnytYxgOtlY=;
 b=H3v+snKpjxgBdKKvSvxzi2ccLH7YC5xeoAEU+KHrxcSTMKzPNwKkH1zVhWYydb1QujbSZ3m8EAQHGVNdf+jTE15pxKZ+O7zTjvmmRLTXHxX0BVcynlz/n2eydhkUdhZXPqxQSNv1pdvRBJklceiKfXW9Dn3scjKnVIWcT5NApKroQ3f7+8KwE2yP5/V9wgTU4l5x4AzyeoCJiQQ9P86bEQD+0fyt/hsxgkmrd5Xd8CLcNjMFnR/456YGS4IvjuuUgvzMztbw7WCt82sz6EIOWq/qW6PobQ+Jvud6JMsbCoNwcWo4IiyZvYbo6y3rzaG01M7SQJrEs472i73fyESrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1ZJ2S9eNZlgLOTPVD7o8gBJYqPZ8Qm3dnytYxgOtlY=;
 b=VLlhxgzN686d4VDxDKSd0uUTGGwM/g1T1JPwRvwk5G6HwPfpylc2PuPMoLcN2lw6leXK7ST7Fyu4NiIgbX3L9eUuSslvTJlCEuUHyN6jRSZ5/SDl+FlTH0z6A5gM0aCt5YydtIAVo2oS8278g6TbTRaFCOGJnViZcmE3V7bovA0=
Received: from BN9PR03CA0970.namprd03.prod.outlook.com (2603:10b6:408:109::15)
 by BL0PR12MB4692.namprd12.prod.outlook.com (2603:10b6:208:82::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 07:05:59 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::2f) by BN9PR03CA0970.outlook.office365.com
 (2603:10b6:408:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:58 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:57 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu: disable DRAM memory training when GECC is
 enabled
Date: Fri, 11 Jun 2021 15:05:46 +0800
Message-ID: <1623395146-2162-8-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d5e675-e019-4d6b-a944-08d92ca75d9d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4692:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4692F936027CCD0884489A8BFC349@BL0PR12MB4692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffOnI9lDJPeiYYsv2W6fqr/uKwAFnQOhRmeHt62ILu/k0LX2tVuCqm3/WIsYwhVMqHvaJR2lvjWvQfvZhuBBEKhTGIaaOpVBccBzlAQHmlXtVyEEuucUSMnv3iT20HbhFD8YUX4L0fiZGTEmVjC0GvbayYxIsqagbSAWFd74CtdnrmedxmK2ZM3HLFIkrMQNv1hpxc/ja94/G109TcDE3MskUwsJszzGznCckmM0jGYM4NNXXFKCdhurlRbGfOODan1zvewxe4hBFXh+3VcuNPVGB2UCtloS45KS0v/NeJZhRj0MFXlXOQb7S1mtQbJZ1w9KLRwLalZFTEZuE4aMLZovd4/8aqak0+hQVTLdqX2Y5hJqkXLGRf94XjI8P0JlMsiu9CX+IPVpfzcDlpY1RujwdTT+5621r8YR6rnV4cXV6uy40OTQejP07e7H9HzfUu8k24nSZxt4K/nKw8dtOEjz0erV8Vrc8oXrbemYhe9QgoKXYvhe8/WCUteIpOLnrcq+vuwsPbHT1afRlGDfXMdMFRrk/HA06NeAl5caKTcXFJ/yEMcyR0hdKZx/8Pv4iRo50pZ9Nve6siJJCNNbaxXgypqSOK6bDwvF2s8XCMdCnd4ca/bNnjqh/1OflUWvs/Lzxf958z0myiZac59++Y9ch3gK1uRWlIBIywJRAYPtXhpoa5VfAFGgbDxob5Mm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(2616005)(5660300002)(82740400003)(36860700001)(6916009)(4326008)(70586007)(26005)(336012)(186003)(7696005)(426003)(47076005)(2906002)(316002)(6666004)(8936002)(36756003)(81166007)(8676002)(356005)(86362001)(70206006)(82310400003)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:59.0970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d5e675-e019-4d6b-a944-08d92ca75d9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4692
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GECC and G6 mem training are mutually exclusive
functionalities. VBIOS/PSP will set the flag
(BOOT_CFG_FEATURE_TWO_STAGE_DRAM_TRAINING) in
runtime database to indicate whether dram memory
training need to be disabled or not.

For Navi1x families, two stage mem training is always
enabled.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 47 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 28f95c5cd373..7e0e676a9959 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -238,6 +238,7 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 	struct psp_runtime_boot_cfg_entry boot_cfg_entry;
+	struct psp_memory_training_context *mem_training_ctx = &psp->mem_train_ctx;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		ret = psp_init_microcode(psp);
@@ -250,18 +251,36 @@ static int psp_sw_init(void *handle)
 	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
 	if (psp_get_runtime_db_entry(adev,
 				PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
-				&boot_cfg_entry))
+				&boot_cfg_entry)) {
 		psp->boot_cfg_bitmask = boot_cfg_entry.boot_cfg_bitmask;
+		if ((psp->boot_cfg_bitmask) &
+		    BOOT_CFG_FEATURE_TWO_STAGE_DRAM_TRAINING) {
+			/* If psp runtime database exists, then
+			 * only enable two stage memory training
+			 * when TWO_STAGE_DRAM_TRAINING bit is set
+			 * in runtime database */
+			mem_training_ctx->enable_mem_training = true;
+		}
 
-	ret = psp_memory_training_init(psp);
-	if (ret) {
-		DRM_ERROR("Failed to initialize memory training!\n");
-		return ret;
+	} else {
+		/* If psp runtime database doesn't exist or
+		 * is invalid, force enable two stage memory
+		 * training */
+		mem_training_ctx->enable_mem_training = true;
 	}
-	ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
-	if (ret) {
-		DRM_ERROR("Failed to process memory training!\n");
-		return ret;
+
+	if (mem_training_ctx->enable_mem_training) {
+		ret = psp_memory_training_init(psp);
+		if (ret) {
+			DRM_ERROR("Failed to initialize memory training!\n");
+			return ret;
+		}
+
+		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
+		if (ret) {
+			DRM_ERROR("Failed to process memory training!\n");
+			return ret;
+		}
 	}
 
 	if (adev->asic_type == CHIP_NAVI10 || adev->asic_type == CHIP_SIENNA_CICHLID) {
@@ -2676,10 +2695,12 @@ static int psp_resume(void *handle)
 
 	DRM_INFO("PSP is resuming...\n");
 
-	ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
-	if (ret) {
-		DRM_ERROR("Failed to process memory training!\n");
-		return ret;
+	if (psp->mem_train_ctx.enable_mem_training) {
+		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
+		if (ret) {
+			DRM_ERROR("Failed to process memory training!\n");
+			return ret;
+		}
 	}
 
 	mutex_lock(&adev->firmware.mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2bd85b505f2c..0b514ba31e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -224,6 +224,7 @@ struct psp_memory_training_context {
 
 	enum psp_memory_training_init_flag init;
 	u32 training_cnt;
+	bool enable_mem_training;
 };
 
 /** PSP runtime DB **/
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
