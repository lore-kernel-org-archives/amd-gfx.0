Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D852C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 06:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0787D10E140;
	Thu, 18 Jan 2024 06:44:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D4E910E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyOOMCvI1XlRlI6QexADIewcr4iu6ozN0tke0+Pjq2kDaymS7NdkomBMK5yHTI7qqSeDH1Y7dpVy6KAO0mgnOzxW1qfOSvdRms6aOaWQESToUqrEjFVdQ/r/6lcSEcMFSegLjOmv85fKBl3Cn1AFq4+zpuspxFxZ7O/4IgWPwNARcbMFas6khiVgL0dhTxYuZDwdWsdJElLGvDoOzLUFEAP6mK1BGj5XeeIILlL3F5Dfw7dmXRCdA7ByI0MewWNeSz9pKS6qxnsIK6kGYkqxakOhoDgJZPFVj3oGSYzUDO7+VG417nYmYP8wDNzjbXJcIwEjIlAvNMh541W6tk7exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEJMzpmw1nr69mwA3IUL25LXtmzJeRC7JGO8IA594/M=;
 b=JwJdCH+XvkBBn3T+YATiZNmezu8o+oVRiLrqChUgbPJtEqLRxOJlXj5PRoebY2moZq1UzpMHnXz4LroIU+out7rMg//+FeoXewlmDBhGFHVI6MOX6VWi2A0qUJ/VoIoU2dR2hOZGMyJCO9TJgD0qI0Ex86kewSsyVg8eBOmczxYlZTaSMXGD0aldV8HFyylLdiEEoGN+IBNzYYHivB9V+NnszfISZxFI6KJbfac29Nf/gL9ZZ6WyxxXRpQ48YLRAuphJw6PCdyaGHq0X/QYyiMUr08L7EzuIS53yJOUnbtkSMxEvP2hteiDB3rrIumY0Y6JxhtbvM5rcUn2qSAytWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEJMzpmw1nr69mwA3IUL25LXtmzJeRC7JGO8IA594/M=;
 b=3stGYxmgJxedCU9FktRFB1L1u5OxMJFgRhS98NkAQWHQ0WdC81H6lroSb3IlLdgiEkzFPItGetb4Y+tElZFJsmrSA5z6NEDIOutDwgg2NZ1CRIAIwYW0vyoLlA9JJQztJPzXiG7kLkL4xmcHUaBa4xG6GXmC7uT38+tPn/Frr5k=
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 06:43:58 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::48) by SN1PR12CA0044.outlook.office365.com
 (2603:10b6:802:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Thu, 18 Jan 2024 06:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 06:43:58 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 00:43:34 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/5] drm/amdgpu: Prepare for asynchronous processing of umc
 page retirement
Date: Thu, 18 Jan 2024 14:42:54 +0800
Message-ID: <20240118064257.1951585-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM4PR12MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b3bc93-e3eb-4902-b75a-08dc17f0d951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDWz951DsYwz2wnNQYnowwRgEhaiu8QIHEHZ+a6mVWFM/Uttbd8KG/FmV091RdoxlF5NPYbmV9ITly53M5tWahPkbBRCWT92NmtzvZXqXFYE/pJzQdl2g8q9uJ3KddR+SR+lYk1/LauT14FpFLAjinDbQGvh8OCIKKdODcIslnZ9eBAAyUxIsUpiM2KBBUX7nb+V6nu7+VSt+bcqd5cAtRfXEm7HLeihnKODkJWgibceWK4eTdjFRyhuQeG47cW8Ov5n4Mm6P8KYP4RQ2usYlNTByDs0RXQ1BTk9cQvOiwmUBFuNGNMoKZcDl9Mp989tH7u7SX6pnOwkB7TJTWwLRXzL7rWsD68quVAi4YEXbAL5Dh89czYWm4gMcj+9uMKzDtRHyakj50N5NoKmcPcn3JfwF0uIiTf7xnqxo9Ca5vmqPF2sPSaQ161BoQd5ZDDHPaGCq0+z0AIiEMgeFL2XYozcyIWHDCa4kGXyPtmjN2uim7fEVSCH47/U3LHbaK0VuoDO1vsu2sb8UxX62jMMtmV2IkUwqgzBiS4rttGG1yzARrO2wmsguJ5oOmUrxfyego4vAks7uemTSognfkhAoD6eLl9zkSHKqDRd65frknFcFVKJn5bUqzQCw3CqyiahjPwHpgdpfvmcLBtuRhq288qYvzdtYEGVZymYGqnQll6NqrOC8MpliCxPo/9NyMsmbNkLZ8Ur5ml7dPVkoZZnE1mnbss4qiyO/CsEDd9ED0DjolLCRfju8KIX+LrOGMAPSHpUb9pB03tM9CO0XZWKwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(336012)(16526019)(26005)(1076003)(6666004)(83380400001)(426003)(86362001)(36756003)(7696005)(356005)(82740400003)(81166007)(8676002)(2616005)(4326008)(6916009)(47076005)(5660300002)(36860700001)(54906003)(41300700001)(70586007)(70206006)(316002)(8936002)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 06:43:58.4900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3bc93-e3eb-4902-b75a-08dc17f0d951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Preparing for asynchronous processing of umc page retirement.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 34 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a988360ce3e2..856206e95842 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2656,6 +2656,25 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	}
 }
 
+static int amdgpu_ras_page_retirement_thread(void *param)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)param;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	while (!kthread_should_stop()) {
+
+		wait_event_interruptible(con->page_retirement_wq,
+				atomic_read(&con->page_retirement_req_cnt));
+
+		dev_info(adev->dev, "Start processing page retirement. request:%d\n",
+			atomic_read(&con->page_retirement_req_cnt));
+
+		atomic_dec(&con->page_retirement_req_cnt);
+	}
+
+	return 0;
+}
+
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -2719,6 +2738,16 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		}
 	}
 
+	mutex_init(&con->page_retirement_lock);
+	init_waitqueue_head(&con->page_retirement_wq);
+	atomic_set(&con->page_retirement_req_cnt, 0);
+	con->page_retirement_thread =
+		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
+	if (IS_ERR(con->page_retirement_thread)) {
+		con->page_retirement_thread = NULL;
+		dev_warn(adev->dev, "Failed to create umc_page_retirement thread!!!\n");
+	}
+
 #ifdef CONFIG_X86_MCE_AMD
 #ifdef HAVE_SMCA_UMC_V2
 	if ((adev->asic_type == CHIP_ALDEBARAN) &&
@@ -2757,6 +2786,11 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	if (!data)
 		return 0;
 
+	if (con->page_retirement_thread)
+		kthread_stop(con->page_retirement_thread);
+
+	atomic_set(&con->page_retirement_req_cnt, 0);
+
 	cancel_work_sync(&con->recovery_work);
 
 	mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2cd89328dc73..9c3df9985fad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -461,6 +461,11 @@ struct amdgpu_ras {
 
 	/* Record special requirements of gpu reset caller */
 	uint32_t  gpu_reset_flags;
+
+	struct task_struct *page_retirement_thread;
+	wait_queue_head_t page_retirement_wq;
+	struct mutex page_retirement_lock;
+	atomic_t page_retirement_req_cnt;
 };
 
 struct ras_fs_data {
-- 
2.34.1

