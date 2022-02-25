Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6AAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CA710E907;
	Fri, 25 Feb 2022 18:06:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B34810E901
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoOSFvzYQxKV41iZP7UQS5dNJMj187gWbEVW22ve0gHuLOtz7/WhyjJ6kiUtlVdAIuTYMW/QQ4Z02PxiMOYjWzVD+6fAeTnx39Vzm1lIO8AXNcE9n447gq24bPGqbMNKHJvEJhm6Jlfr1TrZjRvzXju3dN6CfLnRt2an3qOLNovCk8mrhpCcqFfbYWbv2Bl7HNyf0OBChRh0oEeCS0+oEGHpua22E5PaqIgrZ4HFD+AUi9HWZr85r3D0wGqktw4+EtIvhVeLMvYzHtMBMwbrCrqbAWrzOwm6X4nc6ZX//OV6Sp0n60U3ePznU27m98zlE6u9EHtojxLnum38myXujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bbcdq3AOiAZNJ2Uk0qPhbsNevaAQPUbuhAjS3EkhZo=;
 b=YSFtWYlXenGr8pt0kQDEnD5ZPuuwnSot7VKP4GWcT6slQntbCoX+wyDQhXDR2RKeeenXXQSw/CUwFp9rF6FUttX6XvLmzlXEsT/xK916lJAwKr+VczvuOsRU1I9isMn6Vm26qBWF8ohKX2C1wVCGOmSTfQs4SwV8QFLDq7IAVzgKUQX/YIgK6WAfQEeVuiJvlI+caDSAB+f0bZ3QQtmDH1HMZ5i/87AfFZm/I0S+deP/u7iIe2pnhslCH1KF2TL6T51FcNG3QXkbqihMRSrW9RDYX27JetX3aeq96LVS8Ut6+xn4jHj+rTiUIZ2DuWjWuUM20VXXtPZX2jrze5Vg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bbcdq3AOiAZNJ2Uk0qPhbsNevaAQPUbuhAjS3EkhZo=;
 b=p0/Tvdp1tGANXgqaGcXniAsfxtrr8yayIhRlQAumPQ19zNhtKqOTsJzvlTjzQXNBdeUsFMOFILFaomy+dIkhUInESQL0KljAau1fS6MIxNRrxnxZEbCCdY84YE/zdh+V9kUrBrkAXBrzM3ZGgjBthWl4UTaadBqswBxozYRI4mc=
Received: from BN0PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:143::30)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 18:06:36 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::13) by BN0PR10CA0022.outlook.office365.com
 (2603:10b6:408:143::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 18:06:36 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 12:06:34 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/9] drm/amdkfd: Enable per process SMI event
Date: Fri, 25 Feb 2022 13:06:12 -0500
Message-ID: <20220225180619.21732-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225180619.21732-1-Philip.Yang@amd.com>
References: <20220225180619.21732-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88dda41-4a08-4227-5e04-08d9f8899027
X-MS-TrafficTypeDiagnostic: DM4PR12MB5746:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB574639DEAFCDAC12E277D906E63E9@DM4PR12MB5746.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0y/vyjFRhl/D6RZgL5nFkJdMFnQPgrZmHK4wZPGBPWFlN8rhoecSZffpDjQwt+FM4H5Dmi2bwxMSGw1auZgK/FVWycd19PTHVJrEkbCq3S1Cl/Py7Wq0UJ8n8iOf7krrUoQ9lihPlZkfjQK9rQO8DLswkYc3yGNeHYatZSjIn2TNAcqdlBmBwqRS/RZzD+nYicyzowkEEgDiEdBT97kZqqc9z4uqq+M9rggqJobWWMj3iuIsrG8zdQV85Z8uXtK2SPx7WE6eHn4OEBpjgqjjCWp1ZYB3ZHfwcKGeRdL9/CNsbDQxP4oVZHCIwXGdTY5tA/fwRCaF70yI0Mo0wri78FRKj9tAtEZnT9xwBOA2RSMBlblq4qM+5qeexzt5+8/Y8QH6nqAyvQVcsxzQBy/PTayqgGi5i6WMdoPxLgFRuU9yZb0TVmOcFhMDN8v1IfSaipvRdO6g80jCQfeiqg7DD3P+L1BTG7CnRdReJgH2SLLoc8TkroruAomyOH9ns7ASSgdD5F0QY9AtddrGHeAMe48X779bhtuN/IQhN1RS7BoIu5EQczrc/tacPRRClSdzOTk/MJ6xzJfHHzF1Mx806kwtbPOQNGCIbdok+4RHtOHw+6zB0xmAWGgTnuogGAxsomWO/NsqD9d3ge5FgVnFV4ZsrT//DLZIPI++bml1GMrofQ2TOA584J7MEnBEYRZChrm77H2NQNyKcsnMJOuiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(336012)(356005)(8676002)(86362001)(1076003)(316002)(426003)(54906003)(5660300002)(81166007)(8936002)(83380400001)(82310400004)(6916009)(40460700003)(36756003)(4326008)(26005)(2906002)(2616005)(16526019)(186003)(508600001)(47076005)(36860700001)(70586007)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:36.1717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88dda41-4a08-4227-5e04-08d9f8899027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

Event using pid 0 to send the event to all processes, to keep the
default behavior of existing SMI events.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 29 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index ce78bbd360da..6b743068057d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -38,6 +38,8 @@ struct kfd_smi_client {
 	uint64_t events;
 	struct kfd_dev *dev;
 	spinlock_t lock;
+	pid_t pid;
+	bool suser;
 };
 
 #define MAX_KFIFO_SIZE	1024
@@ -151,16 +153,27 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
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
@@ -203,7 +216,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
 						dev->reset_seq_num);
 
-	add_event_to_kfifo(dev, event, fifo_in, len);
+	add_event_to_kfifo(0, dev, event, fifo_in, len);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
@@ -226,7 +239,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
+	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
@@ -251,7 +264,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
 		task_info.pid, task_info.task_name);
 
-	add_event_to_kfifo(dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
+	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
 }
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
@@ -283,6 +296,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
+	client->pid = current->pid;
+	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
 	list_add_rcu(&client->list, &dev->smi_clients);
-- 
2.17.1

