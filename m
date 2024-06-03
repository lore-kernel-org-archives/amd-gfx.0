Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4F6C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 18:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BB710E1EA;
	Mon,  3 Jun 2024 18:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YUsMxiL5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB3E10E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 18:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T34FdULj20PUVi0285lmEPCpfzVfetSQxy/IIE9nDOizycvgU3l4fXDcD0uuAo4bVxWXYGxAYWp2za/MXO6v/ldZ1ikOzm/mgQoCLU57OkCBkG7SaaF6xYLESlVeysv47BYyZYrh2HZDyVbykG1GHHAM5pkkJwOhwec2IPYQpQ7gbjZAAvqOccCS4wKDG9fFCNny6J1qHxjJ8n/ERLikPMlsfVy7hRqa6D15inHH4/cxwouitmn5+bJNNCFlnxjF86HkcIZHYq8lowJ1TDGe0fNTN3XF0y2Xry+Dw7q29EZylQGQ4kYyjGRfUqMmgOYlSaFHQN2CSthqp/eYM6Q4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pftJ2lNuoC8qof9lXKaRxSuw2828e2GMKqsJaTvJxA=;
 b=PHlfbOVR3YW+L5iEn7eU5HmN9zjOLNhoH6/dKF9n+9T0cE3wSehvEOPDqhpjG3MVuvY16cRFXUXWOnOa8Z1aM4fwAYNIXTCgLaMjBocHVjEPUqMBLsPL3XRZGsUfCOsGoemOHpT1MINKdf59JJpQnd2Vb4ZyTsQuSosjv+cEKR66Af952Rf32MIfdAqjvu+u6JIEmyM1EsiRfkn/+8SJ5X8iA6pXkNtS37QOzyAwsRHr9SWt4QavPrvbSf5mgCMuutPZzcEkp0QG7E/yGA3ObkGvf8UeN5quq6c6oePirDrRRMnccVqfBaOM5fe/J1ahYefvq6vIjW5umDU7mzHo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pftJ2lNuoC8qof9lXKaRxSuw2828e2GMKqsJaTvJxA=;
 b=YUsMxiL5tRnLRs8/cXvrSw8PRpGXn1gowXzNve/szHSmz7b4fFGSU9LKiIb69w/WgClCn2yomtbYNH1xyul3u2XVEUpVGV5LCfeJ232uwrlGoRgLIP6bVYoZEjJ9+q79S6ibSZAjCa7mnCX21us/LgFrCrbizrx4MplM0LSYtFw=
Received: from SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 18:13:36 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ab) by SJ0PR13CA0090.outlook.office365.com
 (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 18:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 18:13:31 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Jun 2024 13:13:28 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Harish.Kasiviswanathan@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: add reset cause in gpu pre-reset smi event
Date: Mon, 3 Jun 2024 14:12:58 -0400
Message-ID: <20240603181258.170580-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603181258.170580-1-jinhuieric.huang@amd.com>
References: <20240603181258.170580-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b114191-99f1-47d7-6147-08dc83f8e00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKWKAfycqWAMVZNdGT26MqgN/1haXcau8USsUrnQEaGWBbhQtLDJ3VTV4CZA?=
 =?us-ascii?Q?eklKx/iXbAOFKgULNqUWVqLklRgA28j+/VTWSZOgTxQVN6jAtPq08xdVCSIi?=
 =?us-ascii?Q?3V/Zm0DDJMTVQP/Pdm8hR2Lf7Czk1yv/Eb1T4vYVRuC6+uM6oR2b/45IcHa2?=
 =?us-ascii?Q?80xfBp4Bx+mK+rmyKM55TTsiJpZb08UBe1dp0xVv/YlxcIf99cCRPU3Elveq?=
 =?us-ascii?Q?0PFSAX3BkXiM9L82ZurXhsylCVtW/2KlfQSaqr/7deegVmwVfZ1lwQKj1G1l?=
 =?us-ascii?Q?MB6XpNKowqt5hXZsqeG9wjLwQiQEDVUd/4U9yoRTzWUYOPsflX3n8jqQjnW/?=
 =?us-ascii?Q?WIsaO3tMU5fsi3j1EA+XOQeyqFnvrPLKR0+8xQlICR8qtfvzgFTf6KeXRGsJ?=
 =?us-ascii?Q?+slCA1a8peoxhFieyt2aRODq8Cdim968/6LXDSLCiVqq00h5FqbbpoYxEXXs?=
 =?us-ascii?Q?kzwP7pSGqsQ38DMYafIlJ2RvYFOHDWXMM4HCc+tT0qz1DUNW6jTE+tsstE8R?=
 =?us-ascii?Q?UY42aUhcDLhPuo8+LjL+9mC5ENqWke0aUJcASzvpJxytuWMOLqKUTicdZiaX?=
 =?us-ascii?Q?dOvE1BDrS5iCkc4sJLCR0lJDs1IECXcgPUL/UAvDyWQpBsCHeNMbJNusbSLS?=
 =?us-ascii?Q?v2jAFbwjymA/jf2+Rmqn1583Pvj2P/nYg9bBzsLBMnplKDZJwscTL5uGAs2r?=
 =?us-ascii?Q?WPWpwp2s6wGlCEiF9Tdfg/p53mlIxBGcQv3i+969D9EoywWjPr51XqEruVmS?=
 =?us-ascii?Q?T+CjiJQ3mqrAYlUeYKtJU9C1jqyULT5lhffzlrAqEomWYh5HjimOXegUl00b?=
 =?us-ascii?Q?OzCs10mzwzltmxChS2Sairl5FC9BnT3wYy4QbNuyf3Od2kXUzZYwiPeZPiAR?=
 =?us-ascii?Q?XpcTrbBvfYOJ/pnIBDQ0J7u8yhl9Dcjs2szFuwnfOxr0bPFcjU6FagZccdwy?=
 =?us-ascii?Q?HDARlKRIrWyNQOjjsBLGY0Lq41UC8/8fU58X6hD0mI4bWd0j9MkP4C+Q4uxC?=
 =?us-ascii?Q?TWdO/GTumaekkwem30RJZPo8JfJZB5RSzpP82MJmlUvAN8oVFQBbYmhLREVu?=
 =?us-ascii?Q?5FZUM2G0GZIZVzPhleEmX+8rAFOt5QUbz+lTpCBgDyZMyq0kBh6D30Nt8vo2?=
 =?us-ascii?Q?C4nJOCPDTCsSjk5LCQ8OsaRb5QynxLuIbPILKROD62KgNU5jPkIm5WHgGsGh?=
 =?us-ascii?Q?1X5ojJXBfeGehTCGtcFwyF5KcgX4bTw+Soe9lga/zv2U4N1bEmnHIYDPqbgc?=
 =?us-ascii?Q?6AqgtgIdK6CcP9wZT7iR/636COqKKhLxzbBYhF+vJjSrC1q+FJVoLKA6fArI?=
 =?us-ascii?Q?l+J8CjyqbNjHWV7m2EKkudfF2eCyWjXgnl5CAAi3VJlzIgHM35slJmHfQQFH?=
 =?us-ascii?Q?8LaIb3U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 18:13:31.2331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b114191-99f1-47d7-6147-08dc83f8e00b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

reset cause is requested by customer as additional
info for gpu reset smi event.

v2: integerate reset sources suggested by Lijo Lazar

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
 6 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e3738d417245..eb601b41d9d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
+	reset_context.src = adev->enable_mes ?
+			    AMDGPU_RESET_SRC_MES :
+			    AMDGPU_RESET_SRC_HWS;
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..7e945a4790bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };
 
 struct amdgpu_device;
+struct amdgpu_reset_context;
 
 enum kfd_mem_attachment_type {
 	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
@@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+			    struct amdgpu_reset_context *reset_context);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
@@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_pre_reset(struct kfd_dev *kfd);
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
@@ -459,7 +462,8 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
-static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+				struct amdgpu_reset_context *reset_context)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6711836054f9..4096cb3e937e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5775,7 +5775,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fba9b9a258a5..52be4e340fb1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	kfree(kfd);
 }
 
-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context)
 {
 	struct kfd_node *node;
 	int i;
@@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
-		kfd_smi_event_update_gpu_reset(node, false);
+		kfd_smi_event_update_gpu_reset(node, false, reset_context);
 		node->dqm->ops.pre_reset(node->dqm);
 	}
 
@@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		atomic_set(&node->sram_ecc_flag, 0);
-		kfd_smi_event_update_gpu_reset(node, true);
+		kfd_smi_event_update_gpu_reset(node, true, NULL);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..ea6a8e43bd5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -29,6 +29,7 @@
 #include "amdgpu_vm.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_reset.h"
 
 struct kfd_smi_client {
 	struct list_head list;
@@ -215,9 +216,11 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
 	add_event_to_kfifo(pid, dev, event, fifo_in, len);
 }
 
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context)
 {
 	unsigned int event;
+	char reset_cause[64];
 
 	if (post_reset) {
 		event = KFD_SMI_EVENT_GPU_POST_RESET;
@@ -225,7 +228,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
 	}
-	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
+
+	memset(reset_cause, 0, sizeof(reset_cause));
+
+	if (reset_context)
+		amdgpu_reset_get_desc(reset_context, reset_cause,
+				      sizeof(reset_cause));
+
+	kfd_smi_event_add(0, dev, event, "%x %s\n",
+			  dev->reset_seq_num,
+			  reset_cause);
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index fa95c2dfd587..85010b8307f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -24,11 +24,14 @@
 #ifndef KFD_SMI_EVENTS_H_INCLUDED
 #define KFD_SMI_EVENTS_H_INCLUDED
 
+struct amdgpu_reset_context;
+
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask);
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context);
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts);
-- 
2.34.1

