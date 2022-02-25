Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94708C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5FB10E909;
	Fri, 25 Feb 2022 18:06:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6165A10E901
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4RZTe5iPg+AaFRMaXdpa67gJRbqLFmk+F474n5T8xPAyYbNPPPk4B7VJfYxAwSyEad9AyryIctOSYQoIoXBbmJ6jP8Ypd3eT3ELkOVuO7OdsV38Nhg78glAJfRiWWxNPvY2+1TMTIFakotjApbIr5CceI91JPY8b5SXC9NEWPtEziBMAkXSwKBqgx4IdiSlNFc8mrBvwmSind+YKFHkKb1eQnNTapCvT3Ch7o9puiy5K+pgmeti6rMSr1amjhhRrM6mAegJG5ny/TEko/dQWVw1rbKshzIyBLTY/HoLZsuaB0lpyCp9FJ2z5kr/D1YxhLcbIxEY5a2+fw+qQttOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq2mL9C072YUY0RoucXNf5q4cU096cfXVlKSMnhafjA=;
 b=iGDl5hC959XKIyRqu556wGOg4Pu1fc4yUb57d63rttOLVdHQNrcnlsh4WzgOtC1X9ZA1t2AWhPfSTlpCJUXYhsT0bkCUz3NeYCO+VW7+rBC12Dsi2b9Z0U28IkrUwYhYGamNV6prJcka5xwHL7no332svZXDAtMMi5G5eo5thCEIgyHzRoS+wgw0mO/opFOJdcyg7R5w6gZ6cQZ1TzL1Jl0+IkOirQjSkgipjv5GASLkk2X3KMekCT1oHz6WSHsRt66WMJVmPTXslpYBtI1CjmDJTttOyRveV+j3KWHHbPloIsw4J29R7aUMxwFW1qH4wyV5yG5Fo81JFhMOZfDyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq2mL9C072YUY0RoucXNf5q4cU096cfXVlKSMnhafjA=;
 b=b4cm7izpFuaMoSBKVSi4zGmJkcsFJM71giVH3/LrgeeizuuCQciYYf5qit3t/JDKh6qu87KunA/DHDfVULoX++DpzyF2P8A6jzhwiAfPH0tcEpmUWmdZLgw0MUS3pCgDithKH3aylaM2T3JGu5f2sRtBFMsV4UsUCnB8TuR0kvg=
Received: from BN0PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:143::28)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 18:06:37 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::59) by BN0PR10CA0027.outlook.office365.com
 (2603:10b6:408:143::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Fri, 25 Feb 2022 18:06:37 +0000
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
Subject: [PATCH v4 3/9] drm/amdkfd: Add SMI add event helper
Date: Fri, 25 Feb 2022 13:06:13 -0500
Message-ID: <20220225180619.21732-4-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52cc5daf-250d-44c5-571c-08d9f88990a3
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5977C2AB45147FCD8D88FBC6E63E9@MN0PR12MB5977.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+vxhH6gtm4Vlq2cyfBaQqtTUElgvGY5V94/k2e7n6Ie4kBwOxm29X3l6L/TNsQECXx4HSmkAx+fhz/R/aNX6wK1s+KwPwhQcbetezpMMDLdcnL/NrmKZIWW+Ms2bVxFDeQl16Q91zVa3bmYIv7D2ibaEq/wPOv1n88DQUluFGkOLeUo9zXEwWvpPqwAXOaXCsjS8UdefY2ZhOfBMj0B68GiQWTrUlvhOhb6+Wa86CrMsBx4KydQ0OcSWmLZhEZuZ8rOweRcM9KoLK35/ROlLlNlIqaPq5Ol/zQQGttP2t5JiIxTP1B/XI7tgJeq9V67PXSka/XnKrLoX4hTtC2K3oe+cdrdNhlMVdRW21ct4abSUwxfaNaoGR87sF5egikBs93jLADSpywj+0oqGQcgH/7stUnrzadYt1zu4TRwpVQSg9LOQX2g/nD6VW3la6tsJjNCE2pI1+yTnmui68Jmoca2epUfR47y2xADZHTIEtPTjzmousMlrUBhpj+rWy5PPlySXXAZ1h0uPFtn1aVq6p6L+oY3ZuWWcMHhvRT7FEdudzc+RIQJRnvU0KXuYd3JKB8TO9fnetk6tTOnR2ecNsrjXcUDjx94GZvL0GkBF6LI62gJOJ39782nPkuczXyyjMeoGWzovg8/WWQyoJoDeCtowO+fkvcA2GI1F5ti1o0HOHEBfhnRsxmkmLqCaPssibZE8C4nOEOJQIcBPSEgig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(86362001)(81166007)(83380400001)(4326008)(426003)(16526019)(70586007)(82310400004)(70206006)(2616005)(1076003)(186003)(26005)(40460700003)(5660300002)(2906002)(8676002)(356005)(54906003)(36756003)(7696005)(316002)(6916009)(47076005)(508600001)(36860700001)(8936002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:06:36.9842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cc5daf-250d-44c5-571c-08d9f88990a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

To remove duplicate code, unify event message format and simplify new
event add in the following patches.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 66 +++++++--------------
 1 file changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 6b743068057d..2e0a26159662 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -189,22 +189,28 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
 	rcu_read_unlock();
 }
 
-void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
+static void kfd_smi_event_add(pid_t pid, struct kfd_dev *dev,
+			      unsigned int event, char *fmt, ...)
 {
-	/*
-	 * GpuReset msg = Reset seq number (incremented for
-	 * every reset message sent before GPU reset).
-	 * 1 byte event + 1 byte space + 8 bytes seq num +
-	 * 1 byte \n + 1 byte \0 = 12
-	 */
 	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
-	unsigned int event;
+	va_list args;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	memset(fifo_in, 0x0, sizeof(fifo_in));
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x ", event);
+
+	va_start(args, fmt);
+	len += vsnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
+	va_end(args);
+
+	add_event_to_kfifo(pid, dev, event, fifo_in, len);
+}
+
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
+{
+	unsigned int event;
 
 	if (post_reset) {
 		event = KFD_SMI_EVENT_GPU_POST_RESET;
@@ -212,48 +218,20 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
 	}
-
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
-						dev->reset_seq_num);
-
-	add_event_to_kfifo(0, dev, event, fifo_in, len);
+	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint64_t throttle_bitmask)
 {
-	/*
-	 * ThermalThrottle msg = throttle_bitmask(8):
-	 * 			 thermal_interrupt_count(16):
-	 * 1 byte event + 1 byte space + 16 byte throttle_bitmask +
-	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
-	 * 1 byte \0 = 37
-	 */
-	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
-	int len;
-
-	if (list_empty(&dev->smi_clients))
-		return;
-
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
-		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
-		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
-
-	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
+			  throttle_bitmask,
+			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 }
 
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 {
 	struct amdgpu_task_info task_info;
-	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
-	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
-	 * 1 byte \0 = 29
-	 */
-	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
-	int len;
-
-	if (list_empty(&dev->smi_clients))
-		return;
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
 	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
@@ -261,10 +239,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	if (!task_info.pid)
 		return;
 
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
-		task_info.pid, task_info.task_name);
-
-	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
+	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
+			  task_info.pid, task_info.task_name);
 }
 
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
-- 
2.17.1

