Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BBDC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 06:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8881010E2D7;
	Thu, 20 Jun 2024 06:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeiGCYed";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B524210E30B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 06:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE6xa9/GsdL5DTZSDBd+llFxzt+hJdiSbenyFTHjhdP1XJ9XkU3YZlMCX9WKI9uMaaBFEkVS2LnaWgT4Lw2zTGGd9IJaKyuNyc/pCv7hYRU0kZqlR5/pfs6BZU75i58alhxDxTcQjmWi+UaJZaB3F3paNgdKHHVKzuHui7J++NYKh9xYvqq+mBMLqoklN6tSm+LAd7pWbOwej6rQj4SfywUjFkrf6vo4Qv4jgKmFAln83sjIArIHyiZIXUFZ90HtUFq1xBPHQpuDXryaVbcsGvFGUlIwDZ7UauW/LOWcrtbowt9x0hNtcr3jlhKbxCUqTrdEvHdVfskWfvg+6yVZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5ItTYB8EdlzJzCFhFsafKvdgNDbwfVudXrkcafLoi8=;
 b=fZUxhFKFgBRJOLPS0aSeytUJsTI6pCpg41qKJ2vkSt4D2kr/spPAFupeLHwnZl7bNiun2d0E5KAP/dI6I0FR60XmcX+B++rKjV3viVeKlVntDM8Yh7NUzqpVqyldFUdTV7MdF5SRYof1+BVI3NGo9tA0E9hUqFy1P1WmvuKX65HIb30OZrsp4QVDZ7dRY3exxaASzHE+huIjjR/mU3zKnCbDzwf1EbQPmC4WzdFeaKKgkkwFP6IRDVZD333RLwNbAkgcL3xjufOsrcC3G4fC9Llo0bi8sLtTZuYAxkJffMtDYnM9i7BKE+4kRap26l7kzxaoskLhdGLpQqOLUyVx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5ItTYB8EdlzJzCFhFsafKvdgNDbwfVudXrkcafLoi8=;
 b=MeiGCYed952lHqVvfKGSLbfGSpCODoXjBetXbk0iuiOIcvVbSP2bNiEVpfolDU+RCm8qdputGFGvFPbPYEGfygzv2HgyGpQQ0t5vFhrIj8TmGZNbnjNSlSMODA60bn6dptMAN5ZwWFON7cik+TuMcqXGk6ewbbGlxZQBvmi4FKI=
Received: from BL0PR0102CA0041.prod.exchangelabs.com (2603:10b6:208:25::18) by
 IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 06:26:45 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::f9) by BL0PR0102CA0041.outlook.office365.com
 (2603:10b6:208:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 06:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 06:26:45 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 01:26:44 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>, <lijo.lazar@amd.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amdgpu: process RAS fatal error MB notification
Date: Thu, 20 Jun 2024 01:26:26 -0500
Message-ID: <20240620062626.619810-1-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cb63e4-227e-4e6b-b235-08dc90f1f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dk644HIN7ZhUJITUnOuqASZoj6HkLdZGSWRZ61rnJilBk3MWpLwBzhePRry7?=
 =?us-ascii?Q?gOTDSg/D6+eJgS9vBIiyF7rBJ2EeCws7qb5jS7vzvDQFLdnew158yG1+svt+?=
 =?us-ascii?Q?JpnEu3+IF3iPa9iNxaFcCGQ65TGoxMhg6ICe7h2pWtdYS89x4oAVmDWNubyM?=
 =?us-ascii?Q?12BLTEO6bPcIWNNPYw/yXOhBpiWLvGpURlmcASyxnelw9dxpppGP5XxtkuYr?=
 =?us-ascii?Q?T/qsCQvmeLBdSU27FaIQQH2xdKrSLKrCKQ8yELClPyPT/G6FIICriH3OAEN2?=
 =?us-ascii?Q?eay9sinOEO6ja1o2Kr1NIrzAiqWCVEclqVCLw+r8bb0myrF1aLAvXbRDS447?=
 =?us-ascii?Q?eanz0EPiJs/YAVqjhwVvA0MIYRE5m9OP1E2McpilTPjVPkPB4O8sgvDkLh+8?=
 =?us-ascii?Q?W4B7zugSLpQT0apg/sOl9p5u1k7YRqs5DyWi5X3ZsY7mpulL8FHsXqOHN0Yd?=
 =?us-ascii?Q?zkez1Qu7Jy5aA1ISkKLDmUw7QajekQZGJsPAa+47C7tVv8JvrGbMpy3n1gH1?=
 =?us-ascii?Q?uLdluXt3b+ajjFgmehXGlvlGyfVFhHhLivcZibnqUgCIxjzfNWzjnaImdNgv?=
 =?us-ascii?Q?oi51LvAMFS9BsL+4JKOakoC7PYe1+KjNVP8zWOfmQ7laujV1RmutRdxUwtLn?=
 =?us-ascii?Q?UIbfoQnUxSfNLZJDXhHkyDVwuIZ4ClmaQux2IdLfkC6n/eTnopQszeoepVo8?=
 =?us-ascii?Q?r+thJdgghfbgO7x2ZfAshQ0fbmM+siVYVV2L+21npULFuIiqbQFQ+/4HjRjc?=
 =?us-ascii?Q?37UmhSKDUPAPslk7foU9bxYFWtu6RqFuqPbHSks7OAtRjmFLkQpP0tSTJhMo?=
 =?us-ascii?Q?uSzjLyWWkNQaPGsT6JYvDOuNzdmPUYJNLGBs3YX/I/3qMlIBTSkRncaBnpyJ?=
 =?us-ascii?Q?TmclyQFGhA5lBtkdlB9QesPAlLkI6f1oj+HAWumGrHW3PeXNetjSs5Yot/Tj?=
 =?us-ascii?Q?U0t7S5uE1Q6yPMVu2T5sFN/1ESXI81C1FuBIMYc1iqMnETSXvXjHIUThXTOb?=
 =?us-ascii?Q?YK/RGplzsM0jNOnJUp5tJJIo1b0pCR9LEAZIpmCmX15T46GQUZrX1zsWP60l?=
 =?us-ascii?Q?WjefT08FwRglZRkdPhqzJ4gVFszPafw6noWzuq0bPEUKbfJ8zh7EDFskNRzy?=
 =?us-ascii?Q?uqCWDhpFGMoJ4GGokkp1Niba6fomUE3m6O68RBG6NZGRNy407PQeJ/vHqn9w?=
 =?us-ascii?Q?FgqjPchmlB1HxZPtDkDXk55jnTRoxwmnnX9ASbGd2fjOhR3fP6W2VLQvDuAO?=
 =?us-ascii?Q?7PU93/7kWhCRvWuaQH/MznqtyRSAeGdcbhML3Ty3Si9X1MZYI8f/OkEDOOnp?=
 =?us-ascii?Q?5Cb7WDAJVHCiMWijskyWXqspH3hNxmvm6g99zbdSq0WZggr57CSn+hxOWbzi?=
 =?us-ascii?Q?Sv/PI5VIg67pueCOdUu3IZQbvCV9VREzBuCG6U4Nby5KIju4wQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 06:26:45.6236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cb63e4-227e-4e6b-b235-08dc90f1f54e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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

v3: set host_flr bit and use wait_for_reset

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 25 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h      |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 14 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  5 +++--
 7 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7df5544ac9839e..1b204af9831d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5834,6 +5834,11 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_ras_get_fed_status(adev) || amdgpu_virt_rcvd_ras_interrupt(adev)) {
+			dev_dbg(adev->dev, "Detected RAS error, wait for FLR completion\n");
+			set_bit(AMDGPU_HOST_FLR, &reset_context->flags);
+		}
+
 		r = amdgpu_device_reset_sriov(adev, reset_context);
 		if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
 			amdgpu_virt_release_full_gpu(adev, true);
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
index 65656afc6ed1c2..2eba51b58ea88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -257,9 +257,13 @@ static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
 static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
 {
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
+
+	if (adev->gmc.xgmi.num_physical_nodes > 1)
+		timeout *= adev->gmc.xgmi.num_physical_nodes;
+
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) {
-			dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMPL after %d ms\n", AI_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
+			dev_dbg(adev->dev, "Got AI IDH_FLR_NOTIFICATION_CMPL with %d ms remaining\n", timeout);
 			return 0;
 		}
 		msleep(10);
@@ -408,6 +412,13 @@ static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev,
 	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
 }
 
+static bool xgpu_ai_rcvd_ras_intr(struct amdgpu_device *adev)
+{
+	enum idh_event msg = xgpu_ai_mailbox_peek_msg(adev);
+
+	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -417,4 +428,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
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
index 17e1e8cc243752..5854e8d2bbd4b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -294,9 +294,13 @@ static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
 static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
 {
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
+
+	if (adev->gmc.xgmi.num_physical_nodes > 1)
+		timeout *= adev->gmc.xgmi.num_physical_nodes;
+
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL) {
-			dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMPL after %d ms\n", NV_MAILBOX_POLL_FLR_TIMEDOUT - timeout);
+			dev_dbg(adev->dev, "Got NV IDH_FLR_NOTIFICATION_CMPL with %d ms remaining\n", timeout);
 			return 0;
 		}
 		msleep(10);
@@ -449,6 +453,13 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 	}
 }
 
+static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
+{
+	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
+
+	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -458,4 +469,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.wait_reset = xgpu_nv_wait_reset,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
+	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 1e8fd90cab4347..caf616a2c8a6c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -26,7 +26,7 @@
 
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
-#define NV_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define NV_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define NV_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
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

