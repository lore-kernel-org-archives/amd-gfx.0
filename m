Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E46C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5219D10F9BE;
	Tue, 28 Jun 2022 14:51:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251B910F9D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxXy6jLNpYgNKs3t8SMzecdAl4SFGjDPGwm+sqY018DgBuUNJPrGlbOhntRXHrD44ekukro9oDWQgjQO0OmCYRJVh3damTzYWsNwRq307Wm/4tT1eF90X5GEzJF2LbxGgF5d3MjqvoBqbK/Hdd/CIGvTZjNAZHjliAc/2fn9ku82d/eGFE5Uwp9zkTcB4wMV8PwbN5czsbRv8x72xDvyNlvAf3vXQvSJsXVOi47qt5H68lAGfW3TAlQ0dQs5whAzKunZkn0qIoa52EoZIAntnky73xkywb+Zqd6PNEr6FzyIBImhB7BDlEjoSE0PYUA2dtWPM1c1mr9KlzkpYQInew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dioVEv4UGJ6P3Kabr4Y38qLb12MFxrJb/kr1blJUC0=;
 b=JArVDaD3AUsJfMdpjeN7PTmt8JNOUU59a5Ozb3qn/5mE4MqkuavtKhhWt8mAFMgOJVZU9/wYTx5EEOV+33j+k2UCeibghA6i1v7LZkVWWZKv9H2dzLPDZp68W43Vl3zaEkCM03feDeK1mWeXwxmwoahq+qWnueCAEQeoyEd9bf78gFLxwnaR/8T2CBuMvsBLc+MwfiDcu74bFrNm2FQ/a/0MaQIVF8XlzAHGz52idhhNhgaSnXDZKSknp2nFZ3olHPygRnZJp87w6RoTaASTaBD9zEitzjXxIfX70GKF/BzYt5nNSjTF619nqg0G/8vwseqf78UUc4u5bhQ/HOrXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dioVEv4UGJ6P3Kabr4Y38qLb12MFxrJb/kr1blJUC0=;
 b=hw6U7cRUs2LvCTRUsW8hHt5/uRw1W56h3/D5FDWrTdaeMUOITAv/X5p8m+22409VdtnjwwGw3IWNp12GjSU6fgf9bRyox4ccxEaPcLIaDuwsTJ5NOyjCTp6Gib5EPTEuuAdSDSBWeLcVnKJVxQoDAvckcS1LUpecbDzgdMqXms8=
Received: from MWHPR17CA0085.namprd17.prod.outlook.com (2603:10b6:300:c2::23)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 14:51:23 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::e2) by MWHPR17CA0085.outlook.office365.com
 (2603:10b6:300:c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:22 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 2/11] drm/amdkfd: Enable per process SMI event
Date: Tue, 28 Jun 2022 10:50:11 -0400
Message-ID: <20220628145020.26925-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e0fe05-af20-42d8-44f3-08da5915ab3c
X-MS-TrafficTypeDiagnostic: MN0PR12MB6078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmH5+JJHvKcsGMgscIoBrjywYSKQGvGvqF/jqPlHtJrt90vnZHgTGeIsAUi7pwNQ9od39AHVldWPZfoefzsq7OzrR3BufdNUNYMe9Q4Yh90TMz7erzLg6cn7jo2r5bMfd2MpWl3RXDBdWjGWFUuqIU46M5ZXgIHOtuMDh1SOafWOFvDvFVPqCQWsN0cJsvKLr3dMgSprVSkvjaJgA2zuXhy9IWmMk8lTy9VLbgRR/BzY30XKX39I8JtPN9mnQhwcSl+gDkY6UCvAhhroxbALigdeyA5KS+LYnlKnk7xlVS7thQFZU0uWj1lIF+3q5WMv2gt8TUCPH4/zIGLtFJycRb+Z7Ip8CFlcvD3MRu5bPM7o/5is5XRXr0UuJgFWOag5WlOIFQyh+PAdzD++3+G1uBaEmAeVjtioXAybj/FAZ7+dFZlRbIpyV+yCZsCLceQdorDZ24INqGkJFafwCEhBsvwLv7mqVeoHjfSByaKh8du3CqdM/D7kezmcfNj5ArPfflDBDzInF4fjyl5VeGoMreHmcH6f2GTVh3pWuAU0iyAwIbVR5zvPhzwP/mAhu4RD7H4fYkIhEIBS444kQBstERl1IrDx8hIl4EodS/8T2h+6fpLIsTJSRGFaEUAW5E1XF3+D2bWyYfX09gxAFls9SMfAF7+NZ4B6kyUSgyUbr6dfutrnffxYf8AuAKzj/XuYrNKDv9MGqvLiXVI6S8thniGOHay8MfiUItERskV2xEalb+E9aQc41Z2UNw1IBJuPgIPFDhMAsRkswNyZK7d2bCScVgvmk8qHriJYNPw/HItdMoOvCkSrzFoSMNbK55n/yR4Sub4L7KY2Wmq4QyShfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(36840700001)(40470700004)(7696005)(70206006)(40460700003)(356005)(426003)(8676002)(47076005)(40480700001)(70586007)(83380400001)(8936002)(16526019)(81166007)(478600001)(26005)(82740400003)(36860700001)(4326008)(336012)(186003)(6666004)(2906002)(82310400005)(1076003)(54906003)(316002)(36756003)(86362001)(2616005)(6916009)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:22.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e0fe05-af20-42d8-44f3-08da5915ab3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
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
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 37 +++++++++++++++------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index f2e1d506ba21..55ed026435e2 100644
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
@@ -176,9 +189,9 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 	rcu_read_unlock();
 }
 
-__printf(3, 4)
-static void kfd_smi_event_add(struct kfd_dev *dev, unsigned int event,
-			      char *fmt, ...)
+__printf(4, 5)
+static void kfd_smi_event_add(pid_t pid, struct kfd_dev *dev,
+			      unsigned int event, char *fmt, ...)
 {
 	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
@@ -193,7 +206,7 @@ static void kfd_smi_event_add(struct kfd_dev *dev, unsigned int event,
 	len += vsnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
 	va_end(args);
 
-	add_event_to_kfifo(dev, event, fifo_in, len);
+	add_event_to_kfifo(pid, dev, event, fifo_in, len);
 }
 
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
@@ -206,13 +219,13 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
 	}
-	kfd_smi_event_add(dev, event, "%x\n", dev->reset_seq_num);
+	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask)
 {
-	kfd_smi_event_add(dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
 			  throttle_bitmask,
 			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 }
@@ -227,7 +240,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	if (!task_info.pid)
 		return;
 
-	kfd_smi_event_add(dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
 			  task_info.pid, task_info.task_name);
 }
 
@@ -251,6 +264,8 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
 	spin_lock_init(&client->lock);
 	client->events = 0;
 	client->dev = dev;
+	client->pid = current->tgid;
+	client->suser = capable(CAP_SYS_ADMIN);
 
 	spin_lock(&dev->smi_lock);
 	list_add_rcu(&client->list, &dev->smi_clients);
-- 
2.35.1

