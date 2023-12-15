Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDB7C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F28810EA67;
	Fri, 15 Dec 2023 16:00:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D90B10EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgwSI8ma4ZHQ0XSzD59MRWQgSNE+Z+1geGM2WwsB04wWMYxlpRmo27PJeccBZopTF5s7o95oYGKxjIh4bAfgG1OoCicsaJU5RMBjr3nIPIhK8c9LMZgWQYrfawoJj/lQ4gc6sKPF1kQeapGP4Xvm/SlXGy9D+6MMyaE82TkCZa7RGlx1rEVqq9lwUBiQSkMzxMOBjq5hAVpWhFt+teob4tncHREhD5s4yXweqhlops5g7CCXtA2i1Upeo+CA3CQWXSWr2vRviE2o7IGMgu0x++H6Vq8xSDL87rk+O/GgBvKaqj+3QFgpHdwZ0jaMnSWlogflXS3dZebtaRXtiZgwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aApHdycYmQ1OP9W3K9tXgcm2T5rmsjT/0cFbxStjHEQ=;
 b=gPHg5eJQohj3GlWfAd/TkYJtedXaO3xLf8WXBnMf4lnTZGQkAsK8hbSdRrT4LtrH1ALI9IQfYiVF90cCxtFInqvXpWhrPmDo2jSOjLdFv9w1aLH7eY1s9o1oDbBn5o4Y13X6UHo4njGMtWhnzkOmKBUcx5ZSPs7Q4dUjLDVXxcjcalEr1vWD8xDJYmFEFDK5s3gvmUIEbsg5LML9CGqSjQ0rmUmhE6wWZ+61r+7n+Q9Hlrm/psRwFvxMaXPOvAWYAW0RVYiBFiKLt9xszNPGTUZl7SipjZjeo4HkrJbHty3wD28miMAbWsn1w2tced3fBkbZN3r2uEH7CT4CjaEo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aApHdycYmQ1OP9W3K9tXgcm2T5rmsjT/0cFbxStjHEQ=;
 b=yY4p1T6fQIvLtXA0+OAisRAI3S0MerTqjwZttnb++wacGYxsUa5SfZBeUaIAuRmcJdLtF5u/VhonqQBnTbAoBwIEAIGZfdCfrT4oFL39QV8ZBQTZKxu1lF1likVSQR4umXPJsRQbB5mYNMECrypPqcvxKuErH9Td5sPfepP5cz4=
Received: from DM6PR06CA0014.namprd06.prod.outlook.com (2603:10b6:5:120::27)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:43 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::32) by DM6PR06CA0014.outlook.office365.com
 (2603:10b6:5:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:37 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 06/24] drm/amdkfd: add trace_id return
Date: Fri, 15 Dec 2023 10:59:33 -0500
Message-ID: <20231215155951.811884-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0d0bd3-f1b1-4afe-c6aa-08dbfd86fe04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g9bjkCWjD9KjKD6uGXqVW6lr6hhgPyT+KWH2kjCgfCd1C/Ii69EusYAf1jBkfH60wnZhq3hxiTeLozoWkBT661IdJBmMR8s+7OujbplrrmWPsV6yS/QHhza2X3k/uoQ8BqG64XkX/aezntCEk/dSthRKNXh0NY+x8TzuKUftz5mM1hVjsQeoXHxvmTtjC/4RgnePSGS5YHUrIm+Ux0LrpT1iPZbmUyqnyGRUBhRzMJsYXI4jI6aZp8X0ViRsEJL8ypGSVnBlkTRazuDmEqEdQ0RgIsZXaGugO9IC5kNemp5ldOpz6wAwGKw2JZ0+1nU3t8GtrCMw/WCZelPXZ4STAWxi6HeJWE1l0M4xxdn72H6kSwQGCmgLWDUJs4zfLmMp3ROk7R7xoSNgmSknVThUbqcv/BO/Gx7LvUeCUuWt/NyB/BlALScoVNNStZ87utdB7rTyXJpXigU9AC3eAXs41DmGX+Dm1PX1imZlm8mnGja+rWwp52eBclhpZxqT817j9XraycBrlhOnfr9+Pb1BNSY1oIGpg9KfUDc4cS2R4IiBcn/qFArA0YNQnhp3wvpYpWeMLd9MmXlwZ7yGb15FKvsDvasQWRdRsMbG0rAoFDSSVC2k0v5WwMDFzO4yl9+gdxxjTaTQWJzgbx6NkQox9wyGDOIfOVvk3uKEX24sultb7gpb2dN6xw7rMg96bUHf3KFpqjsvDEUewnsCExXrBQt8phbvWJDS2JHENc0VNaugAxT3c+gNGZULKEFk0Bu5YpPxEqFdbAWlZD0oJALUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(36860700001)(81166007)(356005)(47076005)(2616005)(16526019)(83380400001)(26005)(1076003)(336012)(426003)(40460700003)(36756003)(86362001)(82740400003)(7696005)(6666004)(478600001)(6916009)(316002)(54906003)(70206006)(70586007)(2906002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:43.1134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d0bd3-f1b1-4afe-c6aa-08dbfd86fe04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add trace_id return for new pc sampling creation per device,
Use IDR to quickly locate pc_sampling_entry for reference.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e24e011f66b..bcaeedac8fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
 static void kfd_pc_sampling_init(struct kfd_node *dev)
 {
 	mutex_init(&dev->pcs_data.mutex);
+	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
 }
 
 static void kfd_pc_sampling_exit(struct kfd_node *dev)
 {
+	idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
 	mutex_destroy(&dev->pcs_data.mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 106fac0ba1b3..0ea51330acd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
 	struct kfd_pc_sample_info user_info;
+	struct pc_sampling_entry *pcs_entry;
 	int ret;
 	int i;
 
@@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 		return ret ? -EFAULT : -EEXIST;
 	}
 
-	/* TODO: add trace_id return */
+	pcs_entry = kzalloc(sizeof(*pcs_entry), GFP_KERNEL);
+	if (!pcs_entry) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return -ENOMEM;
+	}
+
+	i = idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				pcs_entry, 1, 0, GFP_KERNEL);
+	if (i < 0) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		kfree(pcs_entry);
+		return i;
+	}
 
 	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
 		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
@@ -148,6 +161,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	pcs_entry->pdd = pdd;
+	user_args->trace_id = (uint32_t)i;
+
+	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index db2d09db8000..7ca7cc726246 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,7 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
@@ -756,6 +757,11 @@ enum kfd_pdd_bound {
  */
 #define SDMA_ACTIVITY_DIVISOR  100
 
+struct pc_sampling_entry {
+	bool enabled;
+	struct kfd_process_device *pdd;
+};
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/* The device that owns this data. */
-- 
2.25.1

