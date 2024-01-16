Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CACC4706C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 08:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3310110E44B;
	Tue, 16 Jan 2024 08:21:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63A510E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 08:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPwkjBw2mjnvkxGEb1+9XrvxsTMAM0fQzA8Ythg8S3a/ykfNt1zNF6iT7S4fFpvDeLk6GPZ3RGMl2mMxsPs772LbUqJqkvzHux0vuSdpEeMKHLQxOA8Er8MmCZZcIg9UmlegohDYJ5minA3X6DluwLhVlFRa9IrsZ5+irb5PYWQgOAms0UNIAXLJrrAnZNRcC+x8QJ06m8AAfkdscor+Rd8VVZY7pbW1j973SL3fvqtpeO5hiBjYKl5gGPUaZ93kPvrK/AnKn3ButJeS6o8yuLUb5Wo4HXNXsvSodQq7VvMLh/9dCGKoobodi5wYmRcr/ebgj9QADBogViJ2A0nBSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEJMzpmw1nr69mwA3IUL25LXtmzJeRC7JGO8IA594/M=;
 b=nJWvmPJzopZyJNSlsDjaWZ7vrvf8L6iRxCIEp9LQLtrQdcrjzGrs+bGASNiRqDrB06FMG0iyWddVMEL60zLYUpe6Jweqfa1EwvCA8x1lN2Zz5W+7OaGI5omqSNbFsDwKTepPaXjEH1zFDeh54Wof6QpfRrVhJZQ5+lw02P1kIY9u9Mb5fpek2FOOSsTkSeVWqRgxNSNuFbED8TGCxamtwAM828AK/hf6okyaQvNmEktSx88BqE07kLtG/aenMP/1Sd44hiSvudru3P7Hd8Z7iNnTVMtcKZr0y9ZmTEZzLYo1FgfR+txmCJfeSzAFb+45ioItVoetKJsi9hVqYg9Ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEJMzpmw1nr69mwA3IUL25LXtmzJeRC7JGO8IA594/M=;
 b=PZJ8sKvbZqwVle27Vdj+Y/puGR8fNU1V/uK8gyppLpvfw48vV6G615lWo12hVUZP2Qddgv1vsVY4N7R5AiFF8UfrOnJP/ikbztGFfd4KlRm0LCYGpIoxnFUPpcC6oLIem9CFS8rY8pNXBAET9PQK0qyGtZXv4yGVHExh6p2dots=
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 08:21:14 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::e0) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 08:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 08:21:13 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 02:21:11 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Prepare for asynchronous processing of umc
 page retirement
Date: Tue, 16 Jan 2024 16:20:31 +0800
Message-ID: <20240116082034.1739848-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bed0d2-1175-4b7f-fe4d-08dc166c1aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jks/K7ZPrzf9nYXsL1oFPaLWVDnXApaZFKOgovkng06bRIjgBvmUe8eGXFmAEtG1/AiePbeC+PcrF7AZowJTceqlXgjDOdbip7ESvvImHOAP/k3AzPCh7pSAhcwNtXbuIQJ1JE//ECDX5ZZe/WND+cK5VJ6wz1/j1Aql2Enph92hyQkeUTSF3uiavJi88FNNmumMEOX+O3OHLr6UbdvhSexyCl4bZvlMEh0FRaZw3AL31VzSlf0Fm3grf05zliKSIkqJr+NJ64H137mYI8OQ3nwe+s0ncCQAeEu+syF3InHW/P3tCHGhSEQ/g9KmH5GN5sZW61qt8qJFsfcuBupMYYRXkpWglYgKi7qRwfHcLf/idnJTJnAoA9CksawS9/RBO7IhgckVXitNA7FDwwY1wCQATfZNn8daej6XG+b2A+XuvPRHn6Wyb3Dnd7IOL+AJwopv2tF1DDE9Ekoy3i05ZWmIIjTp1qsnX8tsB/mDKkiiXqtgEVCoo7dJBIP9Pmfj4QLxP2EuRCsS9AtDw4sraEojfIsq8vqmF4S3aLu7EKkftJdg+tzHmxIQL5AmpmxI4qh0JW3FUCRkgaRrddCtqkSGtuJbCWLfYaOAD+XFwOOHCw3XYj6laX+5SFEeJvFL2U/kKGTix/y1wcuH5JXGXWLeekYui1WT1K2kDzxaWU/PNxOMRIjyRQM0gwhStoYbt9wi+jd5FJoNVkLPx7kwPTAnW7g+ZSa0Ci/yIfqDdxw6hjacAj9VZkxdk7/G5qWkDshGTwM7nSEz2cG1dQwKJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(16526019)(2616005)(1076003)(26005)(336012)(426003)(6666004)(36860700001)(47076005)(5660300002)(83380400001)(4326008)(2906002)(41300700001)(8676002)(478600001)(70206006)(316002)(6916009)(54906003)(70586007)(8936002)(36756003)(86362001)(81166007)(356005)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 08:21:13.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bed0d2-1175-4b7f-fe4d-08dc166c1aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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

