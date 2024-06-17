Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA77C2BA18
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 14:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF48610E409;
	Mon, 17 Jun 2024 14:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C43bpf41";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4BF10E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 14:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF8X9PneD0IAluztSErp2YgQTdDB9EscFiAHowyDKV8YomEA7L5Up5pdeX30pcVrsEjsbdprHjTcQ0//Hnvf/3eLvrWBr42S/1oVLWT0u//UH5TuNeqZJkOwEpSG355x1mv/CrOGpCeYn4S29Bran8P+HluF0+PuguqedSA9IZRs6zyAiCNYGXGnLcYiLwFzH1oNBb31q++yG6TJsSGCidX/7nP2jmZTsnpJwd9ZZtRHfZyNxwJzfBJWbJ3R1t921V38ST+aEM1NWk+nA0SnL23eWU9jJK0vw1YvHnk5vz69g/x4dhAXP762i/Kgu+wvYnmkUGNT1hTVU+4C26qYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R25YfmYqFH2Dn7TW5c+DstCXzu2jjgMVk0o/2PGBGF0=;
 b=ITqs2rkHtH32qRWws/28w7OX6uXN189Y962wG3YDfmJZhr7BorDmLOVI3wbPvYdxz8syqytNgWckglvJjpfLfDx1VIjC55tnB8WGIgnQTil9+W9vv09RQrEVL3QNP69Bs5GPx75Av1Hmd+E0ePFpbeLiYAjSYSgTast2pDvuAFzL6JkgowAd03UtdD0n8YjuZYzPSMfLOkPhGDvxNWJHsYgq/l/RXbrT2JhePdMsRw688J8bjWvpmZHaELCbpT5SYur+quIY4Ncl/e9aC7Nms5ogjImlUR7HNH0/gtebfWgS3k+O9AShxJBcke1deeRMYznoJFT2sSx8do7/rGkGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R25YfmYqFH2Dn7TW5c+DstCXzu2jjgMVk0o/2PGBGF0=;
 b=C43bpf418CyitOdv0NvtgDFKimWqMzS/a/Jdjyxj0UVDudmopixURexQqcSVPpyBimUtEwgJIba4ULlaZUC0+rIwjDUoXQQZ30d2pn0Oj/76/ysnfGWf80R/VRc/rKunFUTGJodLgSxQikpy8i38Mcnvq2JZq+KY+jnVjG8ATl4=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:55:03 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ca) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 14:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 14:55:02 +0000
Received: from H-4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 09:54:59 -0500
From: Vignesh Chander <Vignesh.Chander@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>, <vignesh.chander@amd.com>, 
 Vignesh Chander <Vignesh.Chander@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: process RAS fatal error MB notification
Date: Mon, 17 Jun 2024 09:54:46 -0500
Message-ID: <20240617145446.593279-2-Vignesh.Chander@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617145446.593279-1-Vignesh.Chander@amd.com>
References: <20240617145446.593279-1-Vignesh.Chander@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 9317604d-fff7-4eb1-1b7c-08dc8edd77e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QPV7vraWIo9UxycGhqz32jIrT0SJwEiTbNnwN1HnUIFIjYwiuqeF22Kicbiw?=
 =?us-ascii?Q?2Pe0+J2wbVp499oYz5h29FMOrO2DZ4V5W5hm86gjg+HesbrGiACa0EXsFby6?=
 =?us-ascii?Q?KnydqCiWDmTDEX0jP0oBU1yVDOz6n1uGyhBaEhNlvKOkZhOa7XSHlPtUkdHD?=
 =?us-ascii?Q?9PUxxVbiGIbCRaa+ORsjS5JsCGdgnKY53MblWDTnrEKHprM2QfY8KHDI56k7?=
 =?us-ascii?Q?dkdnzaNa5cf/Buft8utxImrIDFN+PG+eymcz24KM87bdoge20T1zXzQHrVgc?=
 =?us-ascii?Q?lGB/85CwpM/wpsFJ8fQ4EJjDfWafrLzWuwbAI1oWOandjJv9F7fnvzbT2/sp?=
 =?us-ascii?Q?asJA5DSBqAWOrEFU650zERtG/QL7TSvpKWpBLWytCIz4Qv1821VlqeRUUXVV?=
 =?us-ascii?Q?Xh3Z0hS3cqQRRvYxCJbDmO8P59Zh2hRCtqBUNYEUgottsBgId8UOOikR6WYI?=
 =?us-ascii?Q?pkoso0Pw2T9m8kqofJbLbrESDLdkY5YyDtolsa7Tb7XvFYVWs7tn9lHo/qIi?=
 =?us-ascii?Q?x9xMs917gbvB9twVUM030ufGMkvAUjGg9YqPEW51JW0Dtsg1FyHnpSQOoirb?=
 =?us-ascii?Q?dGxuMnGaxnxRrEpqkDlS7MM9RS+lq944wXV2T5CCcbr9qifWuyYsAA0Fe96i?=
 =?us-ascii?Q?IXLUyuxMLftWH5Wjer1JdMmXEnDkTXfMb/y6PCGKOvG5VPZgKsAFtzP206M1?=
 =?us-ascii?Q?aTVWELvGgOLYpahGdJYpBcyAxK/N5fuKWctYQFrBSuPlwDUUjYmWO8TNgecF?=
 =?us-ascii?Q?1MlZNgLXdhEaI9l7Fn3Pm3nDnEVS21A2ykNMpdvwMmFeSoWy2Ntx1W3Mzzi5?=
 =?us-ascii?Q?nGB2aLs93YLRme9G/CoHnyTRvcbsYpUIhiUwcSin4c0UcI8L/ff5U1JBJiMZ?=
 =?us-ascii?Q?Lz72u+6MzfPgG1L+0ykxpRRIOZcunK7CV5JUJkaMkB7U+jo0DH9EyZqzE3CY?=
 =?us-ascii?Q?7ShhwOLpz1nwtPaU46pbXnI75oa/n3RLtMiP3sG9gpDf2R4Opn3NBWH4dk2C?=
 =?us-ascii?Q?RKJf6z16KAE84fS9ZOrOM2BvgSELG++TieZuQU3Dyf+mqBDBYEXCa1Jweirn?=
 =?us-ascii?Q?++BaNICT9BRoZ9ctCw2bx18ZRZX/dAaFDk6Inw7VyGTA4DJO00VihaztCjJg?=
 =?us-ascii?Q?as3fZqE3tDA02EervonmmfcyLpJtd+pEu7haSOEOOCVWNWXVYjnUFNrJAgFM?=
 =?us-ascii?Q?TCbtAqSibq1OjBwJzlbxExu0t069bFbrI8t18XdJ03T9HtB1ybtazeOEfKkN?=
 =?us-ascii?Q?LSAf6NzZB7J5tkr7aRNuHYh1AkIICgBfcbSdyk25R2CTAPeQMuppYANcQhiI?=
 =?us-ascii?Q?vGbhTqHExXnB8o27xoqi4NJATy8r3deOpGm3Za3zwLk5Zl5/Fxal06T5ad3x?=
 =?us-ascii?Q?4C2EQEVTlxMtfj69/oI+kPpjo+Nl7lXDR7ZV4W2vcBO6mXkzYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:55:02.8509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317604d-fff7-4eb1-1b7c-08dc8edd77e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
Change-Id: I364c417ce292bec6bf98671bc03ea882529361ac
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
index 65656afc6ed1c2..a2c0a43a02f351 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -196,11 +196,22 @@ static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
 	int ret, i = 0;
 
-	while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
+	if (amdgpu_ras_get_fed_status(adev)) {
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
+	return msg == IDH_RAS_ERROR_DETECTED;
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
index 17e1e8cc243752..67392356decd1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -225,11 +225,22 @@ static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
 	int ret, i = 0;
 
-	while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
+	if (amdgpu_ras_get_fed_status(adev)) {
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
+	return msg == IDH_RAS_ERROR_DETECTED;
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

