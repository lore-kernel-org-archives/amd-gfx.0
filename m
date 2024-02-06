Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8872DC4829E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4216112CAE;
	Tue,  6 Feb 2024 15:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y/i2XELf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064CF112B47
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDnh486ofS54+H6VpRG87vhtSpZL7Id3qYMnuwp+4Na5Q9N1o0CRUkDV8/XXCbHlnTdemlLsJXIdl9CrLqpKqoaXFL1L0tw/8qhpmPvwYjAONBGVjxcCIkXB+CmmlZFbwuF4lGK541j5W0OP/51JxH2lRoQ8uwuDiJHuMTtuD+SU9CAInqBof1ZydTSPzCqXW7QQhWa2a7n9jgTZTesHiCLW7mOb1baGTd7OKjDl0X4sB9qbCMPdNQz7Aq0DWXbiASWDVyg7+1r46oRY5VN+xh+EF2WjWyM1XK04OQyTeE0ofZ1FxRr2dAP35myoblrDVFtJHbxWJ/JXL31FFqPhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkA/y58q48p0wE1YB93db97TGHFVFvWsJYeZDvb6khg=;
 b=HXyNxU8JBkePuUjEeVsSFQijBPCeB0HLDEdJ3gGLk44jL0VRMgv4qONzVjEMX6yiFxG9lPtfa035D+GNeNpjbhyg5Z3Efvk3ii2SiUi+FNM7Y42r8yzE5OkSpJHqMvCGN5KGk9+9q/AEUsNIckKDSM2Cm5QDgnClO0XoB+CBGiSgJahozIQ24z3kwNoVHCY7U+NjYRfjW+gPWYei+Q3snHQCSaoYrJAmFyh4o8sV6R/1LF9TvOakJxyYUyhWm2xMUF/c9QVy6LelYRUD1/TY6nwwVEQa0WX5JeTdptOmlUzUxzABBUtL1PXfD3ITiTFkntB2woyMIc7pMpbTci8zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkA/y58q48p0wE1YB93db97TGHFVFvWsJYeZDvb6khg=;
 b=Y/i2XELfDmUhN67VMPRxkL8Bv8Hc4QV0u7W4JUFoBOzSQqGn1kunG6HvteMfDXeJy+6eoxNfPcYBFInGnGaOIcxoR82bZOEGC7XU/Gu31B0g80LMliIdB+A3YpPtma1BzroI5ZrXSyIQibRIZ23h7VVwqUE3HlRrn2DfQQS74f4=
Received: from BY3PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:217::18)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 15:59:45 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::6b) by BY3PR04CA0013.outlook.office365.com
 (2603:10b6:a03:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 21/24] drm/amdkfd: add pc sampling thread to trigger trap
Date: Tue, 6 Feb 2024 10:59:17 -0500
Message-ID: <20240206155920.3171418-22-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 62933fdc-d463-4ec8-5acf-08dc272ca332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0QPMAdiEvWroD8ozUT+alY4FN68L+tO7MzISI+WZoBRhPKK2fqiHcxa/s1ed9dQGjYA+wsgs74Y/im7tFyWEE8LkK1aQfUMe4hHXlMidzTcZSS9zSyPKsmQWcrEYpSTaZS1TZeeRleIKj7dv55f2cUX69dESZBE/2F18rA+4U4Kii0I80YtTnm3zqH6JX8vK3mZgHCxOo7mJyVAYleVbMCRxt1c7E3PR3OyD58PZfdHROIme+xc/AYt4TNF83WCZiLK7wTFs4woBAa2ilmI9fqLYPvr9xNanpDS23S/BLKU6Gm/s2I4BT/mwTWWYrLVphcpDFshviNH5Z/k1h+/7FUSz3tUnok+0z3J1ilwFIp4/yVxudO/vXspvi0ALaCHWyCEln3GqdOXQBhYLQVpxdELqsh3vuaPRCU9CQSs686XmQDcFH+aaxPvBkejD6h0VzML8Dg2wy78RWoufHE3TvqD/0F6MXf/mTylV+eTbcsE+bFNsqXa8pHfcJiIuAfTGYEZDGuYSgehl/sU9z8miC3V0fH9ELPGYISu09DoPErSvii7lPpSvA1qY7NCmpAGcIdiZyIl1pBwUoVEgZ9ZzsYyhp6OObS3Xsj4UBl63oZ2lx2iGImZb5L7JiSzViXUb58rR1sbHmS7xph9A2CnnJ3muU7t8yuD8Sd2JXdo06YaZGwP4e09tAizhSBbP7VRxUd9ZOSNIkg9g51okVog84h33MmyuDPfUaf/bmvyl57M4uvO8v/qpaHFzNW8Zmq1ic8m+0VSs/kb2yv/8uzpCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(478600001)(16526019)(26005)(426003)(1076003)(2616005)(47076005)(356005)(82740400003)(81166007)(336012)(2906002)(86362001)(36860700001)(8676002)(70586007)(4326008)(316002)(6916009)(70206006)(8936002)(7696005)(6666004)(5660300002)(54906003)(83380400001)(41300700001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:44.8548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62933fdc-d463-4ec8-5acf-08dc272ca332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a kthread to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 91 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 6f50ba1f8989..ea9478c3738a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -39,6 +39,84 @@ struct supported_pc_sample_info supported_formats[] = {
 	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
 };
 
+static int kfd_pc_sample_thread(void *param)
+{
+	struct amdgpu_device *adev;
+	struct kfd_node *node = param;
+	uint32_t timeout = 0;
+	ktime_t next_trap_time;
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
+	while (!kthread_should_stop() &&
+			!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable) &&
+			!signal_pending(node->pcs_data.hosttrap_entry.base.pc_sample_thread)) {
+		next_trap_time = ktime_add_us(ktime_get_raw(), timeout);
+
+		node->kfd2kgd->trigger_pc_sample_trap(adev, node->vm_info.last_vmid_kfd,
+				&node->pcs_data.hosttrap_entry.base.target_simd,
+				&node->pcs_data.hosttrap_entry.base.target_wave_slot,
+				node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
+		pr_debug_ratelimited("triggered a host trap.");
+
+		might_sleep();
+		do {
+			ktime_t wait_time;
+			s64 wait_ns, wait_us;
+
+			wait_time = ktime_sub(next_trap_time, ktime_get_raw());
+			wait_ns = ktime_to_ns(wait_time);
+			wait_us = ktime_to_us(wait_time);
+			if (wait_ns >= 10000)
+				usleep_range(wait_us - 10, wait_us);
+			else if (wait_ns > 0)
+				schedule();
+			else
+				break;
+		} while (1);
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
+
+	if (IS_ERR(node->pcs_data.hosttrap_entry.base.pc_sample_thread)) {
+		ret = PTR_ERR(node->pcs_data.hosttrap_entry.base.pc_sample_thread);
+		node->pcs_data.hosttrap_entry.base.pc_sample_thread = NULL;
+		pr_debug("Failed to create pc sample thread for %s with ret = %d.",
+			thread_name, ret);
+	}
+
+	return ret;
+}
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
@@ -99,6 +177,7 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 					struct pc_sampling_entry *pcs_entry)
 {
 	bool pc_sampling_start = false;
+	int ret = 0;
 
 	pcs_entry->enabled = true;
 	mutex_lock(&pdd->dev->pcs_data.mutex);
@@ -112,13 +191,16 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
 	while (pc_sampling_start) {
-		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable))
+		if (READ_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable)) {
 			usleep_range(1000, 2000);
-		else
+		} else {
+			if (!pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread)
+				ret = kfd_pc_sample_thread_start(pdd->dev);
 			break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
@@ -141,6 +223,9 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 		KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
 
 	if (pc_sampling_stop) {
+		kthread_stop(pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread);
+		while (pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_thread)
+			usleep_range(1000, 2000);
 		mutex_lock(&pdd->dev->pcs_data.mutex);
 		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
 		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7bdcbe6be4fe..372727b5d945 100644
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

