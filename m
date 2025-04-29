Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049B4C3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 21:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9718710E464;
	Tue, 29 Apr 2025 21:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/3BfJ9l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D0B10E464
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 21:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j36CdmEPAzBoicI9egwdu23fLM4O59BsCAyxT61ZeE4qikzaJsA/6v8cG7MWAW/pHagzJ9djXQC9iy8fMdil0HA5hlxKpBTgJRsAHw88BUvxNtdCWbb9vmMDo+BYKMJuinICUc6ClRq6B1bis7uAz5j82Mp8gEwl+hZtPUKMT9POkg5A8EXc4V+uVZFe7RREd1omqXUY/wuaAKI8snoGUHhXJk59DuVYIoblrHdOlnsQbzuXKE36YmzqhK/sHmMnRXB2f8+TYfJfj7Vt604VOpKCnCejoVz2QHL8vgEDhwGmMKJfNe5+6vmfTMOLn2qVQ3uc3SUD9NBy+YjiioPN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwcLqu7d8v+AqeGiB8+rMQ6xkCPyzolt73yFB+lfrI4=;
 b=enVagD6dItsmk+lvqoddaLTSK1je3h5O7qsHL75vjn98cZMUDjLMso6LzOM9egSPCGzmQjkAAq7Xn/CAVRHLqc/3ZdpPKKs0ltiXEWttW5g3JU5DC7GLX6PDetiQ7eVsvOfJNS0SVDlgRLjA/mzIvVgYa4m8eQch/II+l1d+iGOwWRSwZxgwb3K3WgpsCzbMGCl5JItlDMxibAAWcpOTRdj8QAyaffm7KtV5Gt7i35JFUaKGcczd35v7MZn6YDGQYvir1Pf+7UbFulqHKaFZ7YC0cnzXL9MRzG7MxNYRm8Y4qc0FwjbvRtCw4dx19i8HtFKXUdNWxLy8DFWgmmS7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwcLqu7d8v+AqeGiB8+rMQ6xkCPyzolt73yFB+lfrI4=;
 b=v/3BfJ9lEsCQ59GKpHD0ZBB1DiDm0qyMKztmhjxUpxA9nLVOroRwF5mJjbOKlXMmSXPsSNGzsbbdWImuxXbaEyXx9Gcex1axm4bMdIwsHvSTO2yqCwkvPNpjXBkw4vZ9YOwwdroplE6te/2QMoGTm8Ku7rvDRwTibVijgsPMYCU=
Received: from SA9PR10CA0018.namprd10.prod.outlook.com (2603:10b6:806:a7::23)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 21:41:13 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::6) by SA9PR10CA0018.outlook.office365.com
 (2603:10b6:806:a7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 21:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:41:13 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 16:41:12 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Jeffrey.Chan@amd.com>, <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>,
 Ellen Pan <yunru.pan@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Implement unrecoverable error message
 handling for VFs
Date: Tue, 29 Apr 2025 17:40:57 -0400
Message-ID: <20250429214057.93114-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e19b0dd-b7db-4e44-1eb2-08dd87669075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?odPJudDo/og5X8j+v9g5pgzhfhJeycz+tCqqjQ8vB06ZeHxUhfC18speXweS?=
 =?us-ascii?Q?AplRG7HpIYj9XQ6/627STrJiEQRtUcFXAauO//E2fUku7fOvxvAqVnER+T3O?=
 =?us-ascii?Q?fSs92YNl9PDZE+VYoaaQqys47Js8H9tFsL8lPqUV9XW55LU2ZaxKsXrWEi/s?=
 =?us-ascii?Q?7ZUtTsq1qypPKTQhKooEhLZ3WIjh3IZJSS33S+7zIdOt7jtWVgBCoIT8qb+Y?=
 =?us-ascii?Q?b3Q0Sl0fO2Ba1x7GEtWoSXlVyFopOS7PAQv2BlCJ0jBONG5TQG7G0WP2g/w/?=
 =?us-ascii?Q?j+y/2vh2j/ZPz0Z1DP7M1lFCmvOmGdnc3y3DmGCwA/oEAcmP0n+gDJB5rB2Y?=
 =?us-ascii?Q?qufhDEgXHHDGIx8IxKgTNUx03tl7WzSO7YgPrR3hj7YeREBmCTsPMxi6s1lr?=
 =?us-ascii?Q?XNtpIngOJasHsFQ0XE3NPfrcX5c7u8mlNxfJKmoPAoURTBw2f2iIr4RSYVDN?=
 =?us-ascii?Q?ZafCKhRZGx76iT1FiZE0c3grZjqdlNNDBvuOyCYmW1GGqDntremjaqtMs6ap?=
 =?us-ascii?Q?gAZy5JAZ7tbn+LCq+3JcSAazv5ucPbDSZ1SPEeeocgxDgjLiDHxCHV7guhLl?=
 =?us-ascii?Q?fOIkUi7vZnz3PmYKqAlf77yGzKs4MfwiPzvUzkcu1o3evILjmf+5jRoK7ilf?=
 =?us-ascii?Q?dNV8P3TEfqRYHGiLCMpMaOwAQnOzjLiQkhKF47dh7O2k/q9/U0C4YceoNcu3?=
 =?us-ascii?Q?nL12WV39tvGVgAXZhPWIXpL1WkaD6HDgJdB9rIN64uTURcFFRSy7IrWLbdAr?=
 =?us-ascii?Q?ljvmYiCy653VE4NepvP7dWlQurzK+Wal4jwzNnMEZxY3bXfydh7EjmoUINzq?=
 =?us-ascii?Q?CpcTA+GrjF53+7e5l5Bb4k2aGobMdyJjMe8e/6AP2CX0TQ2fkjUD4Rf0TbF/?=
 =?us-ascii?Q?QB4jRePhKMUbXA7AV6FQYg9+8HlEe9qvUNfSG4svwQ2/xAqZe9womqBN8R2G?=
 =?us-ascii?Q?lgHQ0ehDomWMLu6os9w23N3p/qczP+CddXep+GsYlmA3jIz9RXZUUkXhS1eD?=
 =?us-ascii?Q?JnJ2sBqgWBW2QvtSKCrEVltxG06jTakfaW8SgC5z8at4yO1R7rWytVt6O4CI?=
 =?us-ascii?Q?QbGnMC8nnXX8KMBa26gJserO5824YNqk2mPB+21hw9ez13Yvqq//4Ltl+UaO?=
 =?us-ascii?Q?TfmGetvF7SELuAlH6EUtH7SXMv6eOP8hNSl+dPTNggLsVVlbX3DHyXJhdLw7?=
 =?us-ascii?Q?YkIIWtjJs69C9FzaHAoEcf/9ZMiC58RyClsfxaq4fsmYSPwpdquASAh/h/Hk?=
 =?us-ascii?Q?4oweLqbUZJuTt1PetGYVDG6FGrOBRxsNm/g7q55O+JaVtLWLu4dPa5rMm0jD?=
 =?us-ascii?Q?CN/rsviTWqRlGvqMpRBoHd2NlNQ6f1c0hWjQBU5wt7eW5xBRcHOifyyVGzUX?=
 =?us-ascii?Q?jR/6C7iLyz8ySLPoImd3H2WaI6aS/WI/G/xugD6KQFdj1sMLppsSSsHQuWry?=
 =?us-ascii?Q?imw3fvfBb3fyjtGCHkt25npTiXXiYyRX5dXCsvvxyEz/xj3DZHRhOgdJneEc?=
 =?us-ascii?Q?h+gfm7gYF947NsNO2KGSB1lMAdISm55fKjIC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:41:13.5851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e19b0dd-b7db-4e44-1eb2-08dd87669075
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

This notification may arrive in VF mailbox while polling for response from
another event.

This patches covers the following scenarios:

- If VF is already in RMA state, then do not attempt to contact the host.
  Host will ignore the VF after sending the notification.

- If the notification is detected during polling, then set the RMA status,
  and return error to caller.

- If the notification arrives by interrupt, then set the RMA status and
  queue a reset.  This reset will fail and VF will stop runtime services.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 17 +++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 34 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h      |  1 +
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe68ba9997ae..0e9ff74d6b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6152,6 +6152,11 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
+
+		/* Bail out of reset early */
+		if (amdgpu_ras_is_rma(adev))
+			return -ENODEV;
+
 		if (amdgpu_ras_get_fed_status(adev) || amdgpu_virt_rcvd_ras_interrupt(adev)) {
 			dev_dbg(adev->dev, "Detected RAS error, wait for FLR completion\n");
 			amdgpu_ras_set_fed(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f2a74aa76b56..48101a34e049 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -324,6 +324,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_ai_mailbox_peek_msg(adev);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
 	case IDH_RAS_BAD_PAGES_NOTIFICATION:
@@ -331,12 +332,22 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 		if (amdgpu_sriov_runtime(adev))
 			schedule_work(&adev->virt.bad_pages_work);
 		break;
+	case IDH_UNRECOV_ERR_NOTIFICATION:
+		xgpu_ai_mailbox_send_ack(adev);
+		ras->is_rma = true;
+		dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
+		if (amdgpu_sriov_runtime(adev))
+			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+					&adev->virt.flr_work),
+					"Failed to queue work! at %s",
+					__func__);
+		break;
 	case IDH_FLR_NOTIFICATION:
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
-								&adev->virt.flr_work),
-				  "Failed to queue work! at %s",
-				  __func__);
+						&adev->virt.flr_work),
+					"Failed to queue work! at %s",
+					__func__);
 		break;
 	case IDH_QUERY_ALIVE:
 		xgpu_ai_mailbox_send_ack(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index efb452ad1700..874b9f8f9804 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -57,6 +57,7 @@ enum idh_event {
 	IDH_RAS_ERROR_DETECTED,
 	IDH_RAS_BAD_PAGES_READY = 15,
 	IDH_RAS_BAD_PAGES_NOTIFICATION = 16,
+	IDH_UNRECOV_ERR_NOTIFICATION = 17,
 	IDH_TEXT_MESSAGE = 255,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 74a50c0036ef..32ccb625025b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -67,6 +67,8 @@ static int xgpu_nv_mailbox_rcv_msg(struct amdgpu_device *adev,
 	reg = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
 	if (reg == IDH_FAIL)
 		r = -EINVAL;
+	if (reg == IDH_UNRECOV_ERR_NOTIFICATION)
+		r = -ENODEV;
 	else if (reg != event)
 		return -ENOENT;
 
@@ -103,6 +105,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
 	int r;
 	uint64_t timeout, now;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	now = (uint64_t)ktime_to_ms(ktime_get());
 	timeout = now + NV_MAILBOX_POLL_MSG_TIMEDOUT;
@@ -110,8 +113,16 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 	do {
 		r = xgpu_nv_mailbox_rcv_msg(adev, event);
 		if (!r) {
-			dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n", event, NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
+			dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n",
+					event, NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
 			return 0;
+		} else if (r == -ENODEV) {
+			if (!amdgpu_ras_is_rma(adev)) {
+				ras->is_rma = true;
+				dev_err(adev->dev, "VF is in an unrecoverable state. "
+						"Runtime Services are halted.\n");
+			}
+			return r;
 		}
 
 		msleep(10);
@@ -166,6 +177,10 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	enum idh_event event = -1;
 
 send_request:
+
+	if (amdgpu_ras_is_rma(adev))
+		return -ENODEV;
+
 	xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
 
 	switch (req) {
@@ -323,6 +338,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 {
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_reset_context reset_context = { 0 };
 
 	amdgpu_virt_fini_data_exchange(adev);
 
@@ -333,8 +349,6 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
@@ -380,6 +394,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_nv_mailbox_peek_msg(adev);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
 	case IDH_RAS_BAD_PAGES_NOTIFICATION:
@@ -387,6 +402,19 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 		if (amdgpu_sriov_runtime(adev))
 			schedule_work(&adev->virt.bad_pages_work);
 		break;
+	case IDH_UNRECOV_ERR_NOTIFICATION:
+		xgpu_nv_mailbox_send_ack(adev);
+		if (!amdgpu_ras_is_rma(adev)) {
+			ras->is_rma = true;
+			dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
+		}
+
+		if (amdgpu_sriov_runtime(adev))
+			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+						&adev->virt.flr_work),
+					"Failed to queue work! at %s",
+					__func__);
+		break;
 	case IDH_FLR_NOTIFICATION:
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 6d292a537c1b..5808689562cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -61,6 +61,7 @@ enum idh_event {
 	IDH_RAS_CPER_DUMP_READY = 14,
 	IDH_RAS_BAD_PAGES_READY = 15,
 	IDH_RAS_BAD_PAGES_NOTIFICATION = 16,
+	IDH_UNRECOV_ERR_NOTIFICATION = 17,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.34.1

