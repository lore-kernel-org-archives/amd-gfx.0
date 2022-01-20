Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E42C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0ACF10E880;
	Thu, 20 Jan 2022 23:13:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1605510E814
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNcHYvzUePql2nOkpOrd4L3D0w+jooTC2DNooIpK2pumj3Rz36E9XCJZnIvgQDyCeNLhYr/HBixLVG4uS+udEGt+njjg/+UfqDAPYxbw6gLBoq+E18dwPEe6gijm9M91bz+JVi75DFEaRzLGHKf3fMF5p7ETbI2Ko0Rpr7ZSH7ydg1ywonZLLKpMhylqCkuK7bqd4RBxR0X6eZtiVyoYMC/Uixv/5D6TbVqMGTdu5qEyeI+VkzeaPhE+ijNkxL3DgAxvzkgS7C1zTYNsa6RGAqzrrQHs8NZcgHLu9cJThEqrbEriUDaE2JhwymXN1FmDHuahqYh4avx4PDEOxRnh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwKtTeUhTTNTf1ze2txaA4yKtHcZLTQe4ufDx8dzLw8=;
 b=ms1jbNlBXG0Du/g3kRvDDUVMa/A/2Mi05rWw1pas0HpCjnDxxKA0JfQ7iNpLrHqbutsOvPnVxk9I/lVFK14FQOryZeUHbhfVnNJ9BYJqcqB6gt/7zsvfo51QW+9hr669Ne/skVqcl/DsHik/gqbYSKSettTWylzE2Mdwcrvo/2vSfchdtgymD5rXC3UX4vdruSiBhihZxwNSBt3uxMIwGVGH8WGhliohg9Y7/7ZNoUhGFPZW07SbOdOVCz4CmlX6DCc5aQ2jK8WA7r8rIKQmrk80cXjpmeGeZURM72FskjYFc9ISSFKuORS61y5Cntj25jctXMIt5+xK4sH8G3pEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwKtTeUhTTNTf1ze2txaA4yKtHcZLTQe4ufDx8dzLw8=;
 b=evspQnjnrddB3ZMmvoBXUt0tUxmPxe+aXVhFORhcMg1NsmwsNpAKnfJq6qVMuc0TaXqcn03qk/FCeCwpEv1QkomATmjUS1ro6wdcygfsjz6WlzikWR9rYq83iWrGl6aOf0BGjcMxnT/X94c63qywLxDOUXdYIKnz9EX5oBQ7s/k=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 23:13:40 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b8) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:39 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:36 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/8] drm/amdkfd: Enable per process SMI event
Date: Thu, 20 Jan 2022 18:13:17 -0500
Message-ID: <20220120231322.10321-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a5b0a48-0221-448f-eec2-08d9dc6a7ea2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB425042C291867AFA4533B009E65A9@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T9IQQh42e6O6WNn5I66zttXQE4tHXQS9HQLwiLP1xf0OSqYoLFm0tZZQTV6L33yNVI+dAyUa6u0laLJxuSVHh4wT9GBUZ9Uij8o/1qSL7TwP/ySHiM2EhO7UGBIwwOQpbT4u3XSUEzo+5yzY5R2FRqPQBkt+UToqdmRo9HP3im9gFqDv2khPkkb/Yvv53uI00jvnhc3cJWIAPbNP7sFYNBwfOdjz7da2RRrya9ORbITBbBlL8lvRQq5NWXJfKJzCZIr/pUztqc6NSPSWmPuF/WgKzGIc05IjcUijhI7KvFlBjA9xlkELDql+pNnqw21N5rukXeOYYOxl62FyM3REZ3U/EZL92xs/eEgr2uRoFgOFi/iQKvNDpXpEc58MDUE9F4JC9kSHW8zfLnzl1G5sdgQLr1jePYBYCBhN8xU32gL9pP9kPe6qxOZ/IHLEz+ePUXq+RNo7SHMXQpx0K4EfwKjDK2q7Vqjhb8z+b8tbiE1rrfk5LbwAe+nolzSxs82VwVFFk2iIZzXcMGHTroHq5x94c6zILLJzxmlLQukXAJog9h/QVy25sUEzVPiKS7eY6qzMX4SoycqJASSwOV+WwRBiNHHL9HF7XzcW0nZOrfwnDHOQ33IE6yDT6+NDsHmHzsDkVPtXs/LOVtI53/LV22aaQkApnQyo3vrzQEz2A4/8YtjXULJtv4DUtXztDem3GwhopDi79PIWwgvXXme94neJq77okXDylF5PZVErMtx1/a9OppPD7LAOi+O+HCLcQFap9T98T+MRkhFjvMJ2NKM8iRiot1Pjt+MfDXxbb/csgjR/sG2oK12LPDEULqKsm4wG8y2/rlY0Oqr3rxL0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(508600001)(36756003)(86362001)(40460700001)(316002)(70586007)(54906003)(5660300002)(70206006)(82310400004)(336012)(356005)(2616005)(6666004)(47076005)(81166007)(4326008)(7696005)(426003)(8936002)(36860700001)(83380400001)(186003)(16526019)(26005)(6916009)(8676002)(2906002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:39.7168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5b0a48-0221-448f-eec2-08d9dc6a7ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Process receive event from same process by default. Add a flag to be
able to receive event from all processes, this requires super user
permission.

Event with pid 0 send to all processes, to keep the default behavior of
existing SMI events.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 29 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 18ed1b72f0f7..68c93701c5f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -37,6 +37,8 @@ struct kfd_smi_client {
 	uint64_t events;
 	struct kfd_dev *dev;
 	spinlock_t lock;
+	pid_t pid;
+	bool suser;
 };
 
 #define MAX_KFIFO_SIZE	1024
@@ -150,16 +152,27 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
-			      char *event_msg, int len)
+static bool kfd_smi_ev_enabled(pid_t pid, struct kfd_smi_client *client,
+			       unsigned int event)
+{
+	uint64_t all = KFD_SMI_EVENT_MASK_FROM_INDEX(KFD_SMI_EVENT_ALL_PROCESS);
+	uint64_t events = READ_ONCE(client->events);
+
+	if (pid && client->pid != pid && !(client->suser && (events & all)))
+		return false;
+
+	return events & KFD_SMI_EVENT_MASK_FROM_INDEX(event);
+}
+
+static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
+			       unsigned int smi_event, char *event_msg, int len)
 {
 	struct kfd_smi_client *client;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(client, &dev->smi_clients, list) {
-		if (!(READ_ONCE(client->events) &
-				KFD_SMI_EVENT_MASK_FROM_INDEX(smi_event)))
+		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
 		spin_lock(&client->lock);
 		if (kfifo_avail(&client->fifo) >= len) {
@@ -202,7 +215,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
 						dev->reset_seq_num);
 
-	add_event_to_kfifo(dev, event, fifo_in, len);
+	add_event_to_kfifo(0, dev, event, fifo_in, len);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
@@ -225,7 +238,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
+	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
@@ -250,7 +263,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
+	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
@@ -282,6 +295,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
+	client->pid = current->pid;
+	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
 	list_add_rcu(&client->list, &dev->smi_clients);
-- 
2.17.1

