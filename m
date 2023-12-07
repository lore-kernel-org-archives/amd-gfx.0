Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351ABC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F6C10E9A9;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAD110E226
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE9c79rU9V8soxFFjZc92ACiAzpAA7Fd/X+r2zxN/tiF2Rbm7vlF4Cf/JuKskqkjoKu8Ui0uXc39/OGJeUf3diOlZdTZeYkpoayNDGlX81ZY1dzqtru9JmqK2nZEG83bDIpqSzEOfvj21W4Mj8/Z2s+fkl/Nm6b1hXNYYsvCNFlpzOaUSeQCX6MBxoePeBTMiqHeaqBuT7vfH4PsiNkHRpl7iJxEEnKDFfX/QSR7PqeV24BGBbU4QlaUA3U/7XxvkW6pvi+Lkx1AunonVK36FLySG6u6RbHNEQSZuqlCC4/7eSzjr4OJhze0J1ljx7D3vR0LUx4s1NJ6Rj4Xvix0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsXK2HFolkn63ViYFsOi2+rHv5HgXVI2YRdv5ogcH7g=;
 b=keekZ96q9vH72rBN8jLn9lotf6p0GWh+5jkZwPFN+ZamVvoZSQ0GUUbVuBjLsomd+EXNm2wPWzyDQcbTc8PpqTwUeoSmKiUndqKdSUeqAKhPW7ZWuUDauS3qfsyDunGZBXEtznThWFzXSi8LRRhQN7JGDw6vZDfirez01muZMGbqGd9kkQ7o1GQuUlSAun7XENZyXxkrXBBlfwCEd7pkliOw4oo0bgdrmuQIUW8lwYvUtLrGbk6TQdMaufss7lfqXCpWz8wxXMdAqaWLK3n9LzRoOwbkDL6d96Dh8e0Sj6FQY69AmzHxwjROUgfbc0KRBledwqPUpU3YDlwx2VPIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsXK2HFolkn63ViYFsOi2+rHv5HgXVI2YRdv5ogcH7g=;
 b=f7rKg7gWL3ZM3mplm2UsbDLGBw1sAxLLFQ+3kGSyHyh/Ujv4oYz1QTmhFTxRTwrv3jhyZuiuAR8FY9mXWW4GBmb0wKwyP4ViAC5FXrIzo7Sb7+Pencu7A+YVENY31XER9yZqdOvHoPVnyjGz2AQjNkWX96XNl6nxesRM+ofQ4QY=
Received: from DM6PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:40::38) by
 PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.38; Thu, 7 Dec
 2023 22:54:49 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::95) by DM6PR03CA0025.outlook.office365.com
 (2603:10b6:5:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:49 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:47 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 21/23] drm/amdkfd: add pc sampling thread to trigger trap
Date: Thu, 7 Dec 2023 17:54:20 -0500
Message-ID: <20231207225422.4057292-22-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: ef94ef82-0083-4e81-6395-08dbf777841a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZosoGNxjxSGo4lx9HqZ/dNJR34BJV+EwFRmGsIrnsoFoagZJQvRWZFRTS3CAHwPKE6a8hRRsZ+5SVpPZOfoBda3IvWwK7VafwF0togyqaELz4enfiaBs+ep7ucV7FAWFUdcDssY36cKJaHnSy60YvASehzVY1dJgh7XvXsMZ1QPXBIJ7247dV4GSbd7X1tKdy6+qPd+CRD4Bdl6HNerrQGtgAgLZLzCEPbfOMfgM4ueqsuQJZwfxVUAIYvPDD5wp148Ns8kQnEkjGRKfKRitzdfniz+G94OKSldNswnveWyLAXrYf4LGbInw3gwmpiFZZc3p6bZLmQfl811AQw49pV691XBYN48J6iOPF03obW84RmEX7lnqaBS1l+h8t83oPIDzG/O9LdTjZ+3ctB6cR2lkppEfstrVSAIK1ckIGVJqv4EGii/5Sl56EI7PCn9kJIgNGg11/Zl2zeb007qLf22IHBALXZhSgXuvxul9JV9YmaYnmxBFWTLHiiM4NZfsDEd4oMT3UCnw1ZFC3aKxrQcmyLncQyjhHM+eHG9RlUkETysoLJmfgBtO0SR6VyZkbENNgoDEAVj5ax7K3Yfq2DcYTUF8sqBLELouuHSpmjIdZ6kFPH8DkArUOjGB6FGPFl8hmN1xs39hseuLudE5EvFTjQgiRi3rxOGPYP4puXtveiqxaRwzO98kuwiuGXc8YzYz29GIYMHYtFmXpQQFDzcnLJiLiloI4XKmUSKMqGinFG72wG2/PRqmgyelB4D3UJ4qNq+WaigAJTDBffRSrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(316002)(70206006)(54906003)(40480700001)(426003)(336012)(70586007)(6916009)(4326008)(8676002)(8936002)(1076003)(5660300002)(7696005)(2906002)(6666004)(83380400001)(16526019)(26005)(478600001)(41300700001)(81166007)(356005)(47076005)(36860700001)(2616005)(82740400003)(36756003)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:49.1766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef94ef82-0083-4e81-6395-08dbf777841a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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

Add a kthread to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 68 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 49b5d4c9f7e0..04cc25c79a76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -39,6 +39,66 @@ struct supported_pc_sample_info supported_formats[] = {
 	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
 };
 
+static int kfd_pc_sample_thread(void *param)
+{
+	struct amdgpu_device *adev;
+	struct kfd_node *node = param;
+	uint32_t timeout = 0;
+
+	mutex_lock(&node->pcs_data.mutex);
+	if (node->pcs_data.hosttrap_entry.base.active_count &&
+		node->pcs_data.hosttrap_entry.base.pc_sample_info.interval &&
+		node->kfd2kgd->trigger_pc_sample_trap) {
+		switch (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
+		case KFD_IOCTL_PCS_TYPE_TIME_US:
+			timeout = (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.interval;
+			break;
+		default:
+			pr_debug("PC Sampling type %d not supported.",
+					node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
+		}
+	}
+	mutex_unlock(&node->pcs_data.mutex);
+	if (!timeout)
+		return -EINVAL;
+
+	adev = node->adev;
+
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop() ||
+			!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {
+		node->kfd2kgd->trigger_pc_sample_trap(adev, node->vm_info.last_vmid_kfd,
+				&node->pcs_data.hosttrap_entry.base.target_simd,
+				&node->pcs_data.hosttrap_entry.base.target_wave_slot,
+				node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
+		pr_debug_ratelimited("triggered a host trap.");
+
+		if (signal_pending(node->pcs_data.hosttrap_entry.base.pc_sample_thread))
+			break;
+		usleep_range(timeout, timeout + 10);
+	}
+	node->pcs_data.hosttrap_entry.base.pc_sample_thread = NULL;
+
+	return 0;
+}
+
+static int kfd_pc_sample_thread_start(struct kfd_node *node)
+{
+	char thread_name[32];
+	int ret = 0;
+
+	snprintf(thread_name, 32, "pc_sampling_%08x", node->id);
+	node->pcs_data.hosttrap_entry.base.pc_sample_thread =
+		kthread_run(kfd_pc_sample_thread, node, thread_name);
+	if (IS_ERR(node->pcs_data.hosttrap_entry.base.pc_sample_thread)) {
+		ret = PTR_ERR(node->pcs_data.hosttrap_entry.base.pc_sample_thread);
+		node->pcs_data.hosttrap_entry.base.pc_sample_thread = NULL;
+		pr_debug("Failed to create pc sample thread for %s.\n", thread_name);
+	}
+
+	return ret;
+}
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
@@ -88,6 +148,7 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 					struct pc_sampling_entry *pcs_entry)
 {
 	bool pc_sampling_start = false;
+	int ret = 0;
 
 	pcs_entry->enabled = true;
 	mutex_lock(&pdd->dev->pcs_data.mutex);
@@ -102,11 +163,13 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 		} else {
 			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+			if (!pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread)
+				ret = kfd_pc_sample_thread_start(pdd->dev);
 			break;
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
@@ -124,6 +187,9 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
 	if (pc_sampling_stop) {
+		kthread_stop(pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread);
+		while (pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread)
+			usleep_range(1000, 2000);
 		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
 		remap_queue(pdd->dev->dqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 0839a0ca3099..f69d76c7a388 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -276,6 +276,7 @@ struct kfd_dev_pc_sampling_data {
 	uint32_t target_wave_slot;  /* target wave slot for trap */
 	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
+	struct task_struct *pc_sample_thread;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
-- 
2.25.1

