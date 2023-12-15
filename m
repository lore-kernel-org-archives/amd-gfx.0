Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE4DC46CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2B310EA88;
	Fri, 15 Dec 2023 16:00:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE6210EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3XnXJSuLU032ZasUqnAXBFJOAzc6TYysM8tWiFJkeDDSGIKlhs8fYHS5C6bsqZv9kj2sft9pqMo3zWrcT+s/J/Mr1e65J5SEIQKfT/iPIM4TL76jMXDYaHJ7z69DE7H5ZSGXbvQWJb5hdLDjQZq4Avj3MwjkynjACrwNujZMD29w9UPbxyQ+JVCS+WHi8n2935wpUEtnoHRS9Hu3O+MnDJDt6w82Gual+6zPACDG2/WdWqD48BdV7i4u97IveqRrf2NiZsG7fMXdUh1AunI9ubiK5UT5/WT+j0aBpaQN+nt9ZwtHqtmiknY/CVhQoW+AL77PVS5s6poHffsMxwFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeMEf/2KIaqpixZoAzfN3sUWoKU0KsXb5J3pvqn+na0=;
 b=X7C6n/ChRYRy0k5493aitSiVfgE2a4GMI6fpCXdpDaHxNVISnYzf7c3eUutp7M0LIhVKcb80zokT7YMNA33y0AtSS3WljGSKE37VG7nhHXJqOEivtMULx/KtH6FNlmcsYg9B81YxSYhWq2PfnJNSytsKz99U2VokBuiL0s4NgJ7EbYyl93P4kULSU0VhPwy5VEtT8XfAXueuhX8B7yjTOd/1UluFduBSE5SoWIwuE0FAOutu7V2bALYd/SKCqZVcTTEpFYpqc5uwioqVaQ06CENS4L4qB9ALk2PMjQET9ogFhglJDPTbuVbnUQs7xgX4OfWWpmDrqZAwCnIspKeymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeMEf/2KIaqpixZoAzfN3sUWoKU0KsXb5J3pvqn+na0=;
 b=iszgewIYaox6Ay0t2mcIAHYWfjGliRzbraEDYJx14stqdQ04gILeFlhJGBgj5OuMqNi4yYcTTOKhTYKr+l3tKVruVat8y9aEm7XVcwvigpoRtrL2tuLMM3J6vnsjntgfEeY1k7IUFy/JbChXu8/AbZ8GDz8Jc5OQ5ei9SD510wk=
Received: from SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 16:00:47 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::2b) by SN1PR12CA0087.outlook.office365.com
 (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:47 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:46 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 21/24] drm/amdkfd: add pc sampling thread to trigger trap
Date: Fri, 15 Dec 2023 10:59:48 -0500
Message-ID: <20231215155951.811884-22-James.Zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: d174bbae-f671-4d11-84b1-08dbfd870070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaNDlCy4w5NyWf6vXNuMkGlln3thZlpIZakW08YKmo7q1pkBsuHw9tqDf3i35gXwJS4ZPmwHb6GpvDbsMP3rzBy4u+xTJV/IencWVHGg2n0CIbK3oSPSS1CT2jCA++Nb5Qe6glmMnaIz2Qn6brAV0N3NxccMNyfDxheumYcG/uqYRu5rQSLpMQWIVLNQcR+KXSEzQpSwnxz9V+etqeE16B/cQMrRnHjNuo/xLMRg6AvK2DznTWNUgE+15a58P05Is9guY63PzJZdY7oEyvAoCUvgknt/7NFywCNIAH+FQ060wEHR7s/MuBYz9ZS7zYHPKnTch42jpyeNHXbRTGrU7GtY7I1b4anXtRwiwrJ9Q3yABPfv7LDBDGIcXcs8UthFK/DBZQnB2K3DLmIVlO3rvPSWyDlC1KIeeHUbJuGATKaIzdFA3QUi94cS/s1mV2pPVtTGzlgOmWL1ca/M1bc9xGwR8/zyznmgykgHOHORtgV6vB4KakbKsQgUdYH+XOY1yPj+lX+f5vMrjVLPCJd3W2bi7jOWw3ivfwzKkJLjK4Big3VAmpwA/oubY4Eu6odGftZlTQQ+16CztZ0aHQogm9ntalCq0xVnMbkRhldy3e1W4DXgX58VOlUjLgl01whgks+u/25uy8jtjA1uGrwlF2CuVU2sZz9tIokE9MWdRn19UU+sSlkZyJNhrJElvcMV+ZT1bid/mNQgyxvLoT/R2K8G+N6AoGkcRjkDWGnQJuV2JFy0QKzX8QxtszDkm4YJMuu/P+GuE65zcQrHtXdIAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(82740400003)(356005)(36756003)(86362001)(81166007)(47076005)(83380400001)(4326008)(5660300002)(36860700001)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(54906003)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:47.2218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d174bbae-f671-4d11-84b1-08dbfd870070
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
index 42282f130fc3..c95d9ff08f6a 100644
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
+	char thread_name[16];
+	int ret = 0;
+
+	snprintf(thread_name, 16, "pcs_%08x", node->adev->ddev.render->index);
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

