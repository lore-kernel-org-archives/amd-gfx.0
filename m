Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0CDC43219
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2607810E41D;
	Tue, 15 Feb 2022 21:23:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8A010E41D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIO05ziGpbDwO9KdKNQ00ryA+qY7qc0HpIRZMClRgx4cbAcnpnrVASCZqCn14Xtl3sAVaRclA86ch8ifrQfw0VANTCqLtm4Hjtl4KE3tajZtXJT+j5sSdgYUx25EDt2ys2b3Elk89lkm5lpul7AdG+HfW0bpoesEcEaAji1ROmYsk2WZUK9HwwQ2tRgUg3JIy+prgV64nj6BY/0Mzmsq9t3+u2sM8BVqLMUUPh2ZoOaSq3gsLuTj0mC2moVjhb8U7TxAwQOO/qseRH1sdttazD+7O0zSI1ohVjOkGuh/8D4DMBj6b60DjfRZGwKa7R5eO7sd36FLyKBEYMo88+IUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bbcdq3AOiAZNJ2Uk0qPhbsNevaAQPUbuhAjS3EkhZo=;
 b=LWsJ4jdpESHjPpQBSRVc5AS76Pu/XrwiFPkvneWz9p9+eEPd6sNe9c2NYNLd9vv8TNUmPGvbDfp+FGsCa2TazAH2capw04XSI7L/1MiG+UCx6BCFjDmT7mNsVCKTMBuhjmduyd3/BCJVl1NDGOX239V6snQhju614aQ1FfKq7GcJfvEottS9r9yOOnwTQm1PbxlGHM2HSm5SMxCyIt9qhnE8LexnDorT9N6Dsmwasfy/ajziQFZZbKJF0v/VlO72u3eAfOD8nYfXxh1vaW+l2DKfqEV+ZVryBYzlzPrsvI2klJdiQNqeEutAM8g/KNRrcAVIv1BQs01SvOZCwrkBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bbcdq3AOiAZNJ2Uk0qPhbsNevaAQPUbuhAjS3EkhZo=;
 b=u0dvuieOnHo3lQLLR1nuDGFG/93QY5p0WJ9XZnwQsfNK9WeOgm6vJBuk76xB3d7bDUNi0sk/wzVuZ0TIPvUoEC8IXhTfN5o8tM7Eq4XUBSWXRv9bw7I6mZGawzLQkiVrc5NsBTq3wO2ozBEUajNY7V5IH+1N1PyMr8pOsetnRqI=
Received: from CO2PR18CA0060.namprd18.prod.outlook.com (2603:10b6:104:2::28)
 by BY5PR12MB5560.namprd12.prod.outlook.com (2603:10b6:a03:1d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 21:23:10 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::b7) by CO2PR18CA0060.outlook.office365.com
 (2603:10b6:104:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:10 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:03 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/8] drm/amdkfd: Enable per process SMI event
Date: Tue, 15 Feb 2022 16:22:42 -0500
Message-ID: <20220215212247.16228-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c8ac729-3bcf-43f2-ed4b-08d9f0c95dcb
X-MS-TrafficTypeDiagnostic: BY5PR12MB5560:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB556048F5A4C35752FF8CC1ADE6349@BY5PR12MB5560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0IE1kEAyFbrBgqot4O7+s/MsyleP00q78W39oK2pyHjjfCQ4kWxqUPF/N8BTUfRiuTfT27IskLXGCg1ohe38WqW7EaC+hk2BYfOUEaYYzzJIElyLPrbVzgeOOOi7pdoDPYygoXYl+TalPpG8P6fQ44EQdkrrE46t77KkJteroaPtRRrQQ2wViogUYQiyYtgvVtm8rNgGvfj3nVlUc7Xndqf64w3g3CKsvZdMpmh8+ohfzLBxsUkrkW7ujb6vd8VvlpJezbhdE+u50iXEiheOvYy/+2DNOXr8T9YE9C2wZ3+y/5j2tbVKFUpHINjAlKJLRTei093fPjONIyrMBG5YFPeiI7KhfVPzNcDwcoCcYeB/yarHxerenZQm0szcgUDYzTBmFDj8TFO49QTBTcYkEFEXuuvf0sKxAjsi33TZ4UAPZXCP2TJI0J9dHKPSQvtkcQkolfxdQ7s4ybQCzdWTmP59MhNlbzuiawoDdVwf7BPJqhcgwRc3TuUTS6imUVsjvtK9KScnzejnLMOvrM13GbxdfwVD2OIqFZ6kUxal9A+YJfyHqLlW5ofbb8mEW/E+ipXtd/h63O3tSFN6YloJAOev/v2GkGvJYq/174753xaGWOkvC0OQesvwFXuW5j0gVBHUnDKeEzEMRdeOMuumVAg2K4WFCRpZfexqi97t/2Yh5+x8FS/F2DqSATWvqcMa8hFwwpCKfDvlkcOb6xwdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(2906002)(2616005)(36860700001)(356005)(508600001)(1076003)(426003)(83380400001)(16526019)(26005)(186003)(336012)(47076005)(86362001)(70206006)(40460700003)(6666004)(5660300002)(36756003)(81166007)(4326008)(316002)(6916009)(54906003)(8676002)(7696005)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:10.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8ac729-3bcf-43f2-ed4b-08d9f0c95dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5560
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

