Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CF2C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 21:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A0210E178;
	Tue, 18 Jun 2024 21:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtMHyJv5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9210110E178
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 21:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBJCHXwH8eSibg1XWzHGlzQHfpy8ddkG0VwyWmay6zv9Q1A2+CFfUPmIR8Kjwk7B1/5QjijzhyP6+xbA8wOyOMJlCvKon3Zu73Ha6KfsX+3jZ61oUMEFK2pxokeHWvpPp/ozW2KS760lpZKY3pBwBeruqHdlLNX5eqHvHuY/GLqS1eJYhRtZxF/1jASLwd2YAU2MUDxqnj+w5rnwur5yqX/uXii7sP+qRFoFbTCKR2EVrOK9j0GoZUzKEMXMfYuxgAXbLBhKqRXY5qTaDvYVaK1sCUHIVFM43uxcupMUD1cyOFyoAN6ynX+FJiE2lcgKNKYPjrkR3s6ZjoLP0Ukb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUJWXeRyp4j+Cmxjd9jPPk7lWM0b3HF+las8CaByes0=;
 b=DYMc4+bHPe8Fz14WmA7LZNgU5m65iEJGPvgBTm5ngRlxsrIKvex0/7RrGet3BR0a+VdJF0FwGdgjFDZxp9jDMV3msnGN1GTPhtafXgnbHmLz4vcLw0VJ+E+gnUPSWG0ovtwx+S2PU9EH5YKefx7ryC9TAGH+NvJ/3f/GtA4HZ0UU5RniHMB+P1QE5mhRPXtx8pi/ELC9ijaG+oJGpscSZQB7hIUSijnKK64POyyBzPQYW7B+9TefG7gmzQDQhP1QHcANHG9C9AQLStQi0BZoyLjLCcNStIFl2XzbPmvskrPtDO6wPMoiEp5TGX21Wp9knyUObUCCy7RTDK2j/Kk9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUJWXeRyp4j+Cmxjd9jPPk7lWM0b3HF+las8CaByes0=;
 b=WtMHyJv5oeDP58GaSULpwXAzyKfV1lsDPSSS9RaBrg1FWNFlvJ7dG0hC7jrTbnW+JHjMzO7XUJ944N3yBdATQFugJaKtRoJvw5k+d84tBCj5a/f8K9rb5ftb4SJy06l1Nf1UesqK5dG4KWY7XQgKRI1JvHyQUd0uWNyEdUS/v4U=
Received: from SJ0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:2c0::24)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 21:15:04 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ff) by SJ0PR13CA0019.outlook.office365.com
 (2603:10b6:a03:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 21:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 21:15:03 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 16:15:01 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>, <vignesh.chander@amd.com>, 
 Vignesh Chander <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amdgpu: process RAS fatal error MB notification
Date: Tue, 18 Jun 2024 16:14:46 -0500
Message-ID: <20240618211446.598261-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f794324-1310-4a78-3f85-08dc8fdbb8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LLAj5PluDuxCf7AlDcv5PGlU+jz556vJj0oNXbj2SGQW1mEl4evX/PnJTx7U?=
 =?us-ascii?Q?8WxmgKYCUbIZeCb/ISwAzKFeWCCELP7eiNG2PH/c7r+2si8iLyU97kvEd99g?=
 =?us-ascii?Q?3FSGKqAWXLXhlsxHWrFk7TJA2qe8RG2poIxj+qg/N9bn86iInPbZxG9qPTI+?=
 =?us-ascii?Q?Wtsa0wwiPobo9RQeHjQFYzDd/yoDqCozhrEJRR9/J79LHKtIF5qprcYqee2r?=
 =?us-ascii?Q?uqbRWuRl0Q09l/ekOSzVdHQkeqYlW+v1Y/58cuuptONzQRo3QkII21JEa0g8?=
 =?us-ascii?Q?K0zEVuSPsY89P2b0UIcWdkLAkCwpUbEAOaS2bkZor/uSMz5OQRjSI03JNLqp?=
 =?us-ascii?Q?OYttz8ssebCOY7Q7qzGRnM0nPHvB+xflkAfomJnDgg6MhQLl1t7HamA5R8zL?=
 =?us-ascii?Q?MYmA1SwxPAPhC6gRnZ6EkM6bjjilLLjeEoV9gaHwLOOwZ6eDsDBRvRvG7gG0?=
 =?us-ascii?Q?a0GbO4tKpw7BAafLEVUfgVFbvbpvc4wybGdM1CwBXqUr1wNwYFvP03OAy/u/?=
 =?us-ascii?Q?sa/HJDZCQjpcntLR1Vuqy/PKwRdWLv+5rol89KJQTm/VwVDJYFD61zO7dX4I?=
 =?us-ascii?Q?iVtttlE1nuEZ6CUfaA1mcFSB+ibaVNrYSWo3XCJo/CLbY7dejPhZqeTQ3XKb?=
 =?us-ascii?Q?7aCbx3ITdphDydL+MaAVHzCU8cVvGufDWZWSPtNVL64/YnkAwK+xZodiHUSc?=
 =?us-ascii?Q?XPN8p36tlua75CYfS6AUoxrU7d/K8IQezNS1vj9gDdB4Jvfmtb/QEVNnVZsb?=
 =?us-ascii?Q?aNf/vgQRMofVH8lgyBh4/IoZ4gX3Ck6DoTivSIobfWiipSpa5YCt2tN/Y9mX?=
 =?us-ascii?Q?42ZMEoCM1lIztA3Z8F7aIPwtbEy1GOfpmD41G8X7rO45R0hEn1PuJPNZHKkg?=
 =?us-ascii?Q?pAdIVFxmBTOyo8oI28klnex3cmqSk03hm+zNNJbGl88ky5ljny4St7twDyIh?=
 =?us-ascii?Q?CHn7pwO/rP7G5Nkcr9QjjgGx/XzEOe3b+fTfSl/oNcZriWA1GCsCpA+GvMlu?=
 =?us-ascii?Q?O3SeSIbM9q/BK74sG8X/QsnE3eLdtg3EFwUR5ITzblbDDfFREHTdpnwKxChJ?=
 =?us-ascii?Q?Jc/izJQbgKGwRngUkJN/vr1nA+XV/fpYkdvSp2IP6IZ1vJSQc/aGr40/36T0?=
 =?us-ascii?Q?hY2/+A5Titnmxv7BsRcti1yzGgfFebe3CMtWTWBPF/eyRbNErFYn1IBVCWWN?=
 =?us-ascii?Q?ObRNqo1fRiw3cxPqUpl2gN68lKXN3VbhwW70Z4qiKPZfA//if62XjHCkzZbq?=
 =?us-ascii?Q?3L3bDu/Euqds6pL8q4tPsk7IOuWpXaKpFc0hzhu9rN55Sm1szxk4JEct53VE?=
 =?us-ascii?Q?gNbmtKZc8DcvoTag1t3ZLvqq6+1K+dl4/pprUl7UaX2vMtM8MINdZPXfRtlo?=
 =?us-ascii?Q?CBXuh9kUJh26wKdABFcKGcG0JC+9wcDhZnOz18slBXRs2wERig=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:15:03.7987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f794324-1310-4a78-3f85-08dc8fdbb8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

For RAS error scenario, VF guest driver will check mailbox
and set fed flag to avoid unnecessary HW accesses.
additionally, poll for reset completion message first
to avoid accidentally spamming multiple reset requests to host.

v2: add another mailbox check for handling case where kfd detects
timeout first

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Change-Id: Ib501c653265883999c62a12a209ce5eb81c80846
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 25 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 22 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 22 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  3 ++-
 6 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 63f2286858c484..ccb3d041c2b249 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -229,6 +229,22 @@ void amdgpu_virt_free_mm_table(struct amdgpu_device *adev)
 	adev->virt.mm_table.gpu_addr = 0;
 }
 
+/**
+ * amdgpu_virt_rcvd_ras_interrupt() - receive ras interrupt
+ * @adev:	amdgpu device.
+ * Check whether host sent RAS error message
+ * Return: true if found, otherwise false
+ */
+bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (!virt->ops || !virt->ops->rcvd_ras_intr)
+		return false;
+
+	return virt->ops->rcvd_ras_intr(adev);
+}
+
 
 unsigned int amd_sriov_msg_checksum(void *obj,
 				unsigned long obj_size,
@@ -612,11 +628,14 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	ret = amdgpu_virt_read_pf2vf_data(adev);
 	if (ret) {
 		adev->virt.vf2pf_update_retry_cnt++;
-		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
-		    amdgpu_sriov_runtime(adev)) {
+
+		if ((amdgpu_virt_rcvd_ras_interrupt(adev) ||
+			adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
+			amdgpu_sriov_runtime(adev)) {
+
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							  &adev->kfd.reset_work))
+							&adev->kfd.reset_work))
 				return;
 			else
 				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f04cd1586c7220..b42a8854dca0cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,7 +52,7 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
-#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
 
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
@@ -94,6 +94,7 @@ struct amdgpu_virt_ops {
 			  u32 data1, u32 data2, u32 data3);
 	void (*ras_poison_handler)(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
+	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
 };
 
 /*
@@ -352,6 +353,7 @@ void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
+bool amdgpu_virt_rcvd_ras_interrupt(struct amdgpu_device *adev);
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev);
 void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 65656afc6ed1c2..1bb8393ad6d358 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -196,11 +196,22 @@ static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
 	int ret, i = 0;
 
-	while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
+	if (amdgpu_ras_get_fed_status(adev) || xgpu_ai_rcvd_ras_intr(adev)) {
+		dev_dbg(adev->dev, "ras flag is set, poll for IDH_FLR_NOTIFICATION_CMPL\n");
+
+		for (i = 0; i < AI_MAILBOX_POLL_MSG_REP_MAX; i++) {
+			ret = xgpu_ai_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL);
+			if (!ret)
+				break;
+
+			dev_dbg(adev->dev, "retries left = %d\n", AI_MAILBOX_POLL_MSG_REP_MAX - i);
+		}
+	}
+
+	for (i = 0; i < AI_MAILBOX_POLL_MSG_REP_MAX; i++) {
 		ret = xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
 		if (!ret)
 			break;
-		i++;
 	}
 
 	return ret;
@@ -408,6 +419,12 @@ static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,
 	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
 }
 
+static bool xgpu_ai_rcvd_ras_intr(struct amdgpu_device *adev)
+{
+	enum idh_event msg = xgpu_ai_mailbox_peek_msg(adev);
+	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -417,4 +434,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
 	.ras_poison_handler = xgpu_ai_ras_poison_handler,
+	.rcvd_ras_intr = xgpu_ai_rcvd_ras_intr,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index c520b2fabfb9a8..ed57cbc150afba 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -51,7 +51,9 @@ enum idh_event {
 	IDH_FAIL,
 	IDH_QUERY_ALIVE,
 	IDH_REQ_GPU_INIT_DATA_READY,
-
+	IDH_RAS_POISON_READY,
+	IDH_PF_SOFT_FLR_NOTIFICATION,
+	IDH_RAS_ERROR_DETECTED,
 	IDH_TEXT_MESSAGE = 255,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 17e1e8cc243752..f2e5b38a64314c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -225,11 +225,22 @@ static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
 	int ret, i = 0;
 
-	while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
+	if (amdgpu_ras_get_fed_status(adev) || xgpu_nv_rcvd_ras_intr(adev) {
+		dev_dbg(adev->dev, "ras flag is set, poll for IDH_FLR_NOTIFICATION_CMPL\n");
+
+		for (i = 0; i < NV_MAILBOX_POLL_MSG_REP_MAX; i++) {
+			ret = xgpu_nv_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL);
+			if (!ret)
+				break;
+
+			dev_dbg(adev->dev, "retries left = %d\n", NV_MAILBOX_POLL_MSG_REP_MAX - i);
+		}
+	}
+
+	for (i = 0; i < NV_MAILBOX_POLL_MSG_REP_MAX; i++) {
 		ret = xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
 		if (!ret)
 			break;
-		i++;
 	}
 
 	return ret;
@@ -449,6 +460,12 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 	}
 }
 
+static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
+{
+	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
+	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -458,4 +475,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.wait_reset = xgpu_nv_wait_reset,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
+	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 1e8fd90cab4347..719a4c88615752 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -52,7 +52,8 @@ enum idh_event {
 	IDH_QUERY_ALIVE,
 	IDH_REQ_GPU_INIT_DATA_READY,
 	IDH_RAS_POISON_READY,
-
+	IDH_PF_SOFT_FLR_NOTIFICATION,
+	IDH_RAS_ERROR_DETECTED,
 	IDH_TEXT_MESSAGE = 255,
 };
 
-- 
2.25.1

