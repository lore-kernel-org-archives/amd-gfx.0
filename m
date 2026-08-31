Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3BC61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEBD110EA6E;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EkK5d+8b";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A3110EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkl1WJCPIM6ebtV/afjsNee4ubqLya6fgOGTmobJMVvfjhLWDba7mwLjDMwAEK6XRSNMBUtNPwk/qI0/X3qbKVTcC6RaVvejocVgX3EY/NGIjzWZTXNVmiwYMdE6++SqjYNeLJIcP36RljF/tDAt4xb7PfDGPOTQ+/+ipZVilDQ3irMsrZwxJBW/m3k7KflbB4tVm39IJjkXCyqk1cnseImmblQndNR8jgCS7BbkK4V8PSwaLCU3P/qNHBdm6jh9Pd39zVBbXZknf2RMgiGTHwdAmjINO6dbtv7jX9FFw925IIBtgr1/rajExwN3j9/jRiEawvfejW+yanDN/QiHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66UWUFAlwGvkXWYa5cejL/TSOuiss/U8BV2jco7tDIs=;
 b=mPB9mHhJ01U3iEyUnpovp7QT8OoD3mOph2fcFbkSB9Hw0LnnWXGVI2rA76z+C3e03MQ2rLzbJlUh+MHdCuMIOMmqfR04O3v9Ka68TqpviBiM7W5NHSfcCUxglgnSsIzk92ibxwFfHrbj91Z0nVoRWQjSXFUMh+/lWCGx1VXmAzVN6QTqQEVSsvQJWtZtSUJAb6wZkvNY30Sr3j7XzRpUGjN3JyTBbbliIruKmNDGcKWC2gHhvGrcaI/0+yGWDGd7TC6s3C0QTVZMLoBPWefZWc72pg2saEtGWGyPwRcDFTBWz+1JkC1X1qzs1RsHtb9Y4CrvmfIpNCmuj9Joe8CEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66UWUFAlwGvkXWYa5cejL/TSOuiss/U8BV2jco7tDIs=;
 b=EkK5d+8bvFRv0yauyUiS1Rn2itojNsNlAsHn0F4jPqmMsSe0sWEbJJBluFtIFfcOMnBRwDEfBbme8txiWWyEn/4RIj0rzGRXm1pYM4fseRMGJCOe8770zS8dzYylM/YmlBDz4JJHXmJviKbIdAugZnzPR8DRsGPZNJ+7k+V8zj0=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:52 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::66) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 48/95] drm/amdgpu: Add connection state management
Date: Mon, 31 Aug 2026 14:27:07 -0400
Message-ID: <20260831182754.1089811-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 639a2790-6eea-4cdb-56d0-08df078db584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +L2YGI0jtiknTJzCoRid2xAUc8Vqt5KGFVw7uKT4aHpA3YopZGwWY6u8txVviruXhfrkiC9OWhTeL6uYppGh8OBUByUdHcBKqPja1PhpkUydFqGY1FAMRokSsfpJFfg8LUTNfLUrnQXs+I0MUjUwLg4mcfs0nvqVGBGwcOV3IL52/ffr/EkzN+nVemx8dnGM+iB79JL2bU1bK4TjvyFYhlLFqnWEqKUQb35U5NB9ekBdQfTrAEqRN/xeOMcJoARL95SMw0lgirt516inoacNguFUbDyY+rPY9oGssIbtZYxGLhv/VMDHwGY+Je1gHzVgrn+rxkeBZXoDF3BWW/knjJgKeXx4RrqTJpFFvVkrKwpD2qakhRCSqVqBYB0NGb4lFLfGnHDDHBRxk+aqrymwtqYvztHjvwTtNJtQZmZm40s7ImXXmuTI1iZdXMlSb+ufZ4B1lFkZQaMxSkhENAZW2HZul/ipK8L06jPRe8jNSsX0cXlwoIzAPlThpn2hZ0r9DrAtU8/5TT5K6ordi21LVrl149C0S6C/Ke0io6LWDN9Didpc9SWdVHdA1nfTjA/f6PWXA3xeMn2H+Y8Gkc+pzan7SJ/azvx06cX1eLoRc0+wRd3z6q2V9PZQs1pKk8H7752wBGBOMGHJdnRhRZHyUacDjqYlgM7aP8qgC0PIUKs809A6DpXYexk2bvty6IvwhjNfxgRRW8IPygggqzGWkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ieC0qJE2J5G3oJl5lginkyAnx4jV242zlMOvES0/3efqAdyiVBSg0bJagvdsHwoXuoJoOsPHaGtTkJsS3S0Jzq5ddjpxkqulIo3lUGW6GHwG7vX875GEv1muKcgki6RaaWpUXDGgzyqA5vKu0RaG6pQRbHiXV0BPJsqrYbtQTM+OGI0wL/GL3K5Unx23j7/4CBZXPbdBaeQ2TPkC/5UJbN5BIAbBHvr0BotmzbBQz4xCpLANZMH/r3OLRJc+Q9x1/0JjqOxMxZvSNF4/zVIf/JkY6rbxP/TOQpRdsQlBaxKkTs3nMSET0pEZk9HEdliKymCifIwfc/S9FW4syCdP76v5wXWdJ8GFpGqgduZAy3lUI65WNwbiFwVqEdUj/eVxl5R4Ye2D6ACjtfo69eVsqu4kvaQNeXmRYUzkbTplae8czHh1Dr+7rXk1SmxnRg4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:52.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a2790-6eea-4cdb-56d0-08df078db584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add functions for managing connection state between GPUs
before import/export of ualink handles occurs.
These functions handle the lifecycle of connections between
GPUs,including handling GPU resets, in the NPA-based memory
sharing model.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 227 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  13 +-
 2 files changed, 239 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index fb698c15af909..45f17ce514493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -32,6 +32,10 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
+				u32 remote_accel_id, u32 dw0, u32 dw1,
+				u32 dw2, u32 dw3);
+
 static const struct drm_client_funcs ualink_client_funcs = {
 	.unregister	= drm_client_release,
 };
@@ -1252,6 +1256,229 @@ static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 		handle->handle_hi, handle->handle_lo);
 }
 
+static int amdgpu_ualink_send_hello_ack_msg(struct amdgpu_device *adev,
+					    u32 remote_acc_id)
+{
+	dev_dbg(adev->dev, "SEND HELLO-ACK: HELLO-ACK message to remote AccId:%u\n",
+		remote_acc_id);
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id,
+		AMDGPU_UALINK_HELLO_ACK_MSG,
+		0, 0, 0);
+}
+
+static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
+					u32 remote_acc_id)
+{
+	u32 dw0;
+
+	dw0 = AMDGPU_UALINK_HELLO_MSG;
+	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
+	dw0 |= (adev->ualink.info->ppod.accel_id <<
+		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
+
+	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
+		remote_acc_id);
+	return amdgpu_ualink_remote_interrupt(adev, remote_acc_id, dw0, 0,
+					      0, 0);
+}
+
+static u32 amdgpu_ualink_check_conn_ready(struct amdgpu_device *adev,
+					  u32 remote_acc_id, u32 gen_count)
+{
+	struct amdgpu_ualink_connection *conn_state;
+	u32 current_gen_count = 0;
+
+	conn_state = &adev->ualink.conn_state[remote_acc_id];
+
+	/* Check if the connection is established. */
+	mutex_lock(&conn_state->lock);
+	if ((conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) &&
+	    (!gen_count || conn_state->generation_count == gen_count))
+		current_gen_count = conn_state->generation_count;
+	mutex_unlock(&conn_state->lock);
+
+	return current_gen_count;
+}
+
+static void amdgpu_ualink_process_hello_ack_msg(struct amdgpu_device *adev,
+					       u32 sender_acc_id)
+{
+	struct amdgpu_ualink_connection *conn_state;
+
+	if (sender_acc_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev,
+			"HELLO-ACK: sender AccId out of range:%u\n",
+			sender_acc_id);
+		return;
+	}
+
+	conn_state = &adev->ualink.conn_state[sender_acc_id];
+
+	/* If we are in IN_PROGRESS state, then transition the connection
+	 * state to established and signal that the HELLO ACK is received.
+	 * Otherwise, ignore the HELLO ACK.
+	 */
+	mutex_lock(&conn_state->lock);
+
+	if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS) {
+		conn_state->state = AMDGPU_UALINK_CONN_ESTABLISHED;
+		conn_state->generation_count++;
+		complete(&conn_state->hello_done);
+	} else {
+		dev_dbg(adev->dev,
+			"HELLO-ACK: already connected, ignoring from AccId:%u\n",
+			sender_acc_id);
+	}
+	mutex_unlock(&conn_state->lock);
+}
+
+static void amdgpu_ualink_process_hello_msg(struct amdgpu_device *adev,
+					   u32 receiver_acc_id,
+					   u32 sender_acc_id,
+					   u32 src_acc_id)
+{
+	struct amdgpu_ualink_connection *conn_state;
+	int r;
+
+	if (receiver_acc_id != adev->ualink.info->ppod.accel_id) {
+		dev_err(adev->dev,
+			"HELLO: receiver AccId mismatch got:%u self:%u\n",
+			receiver_acc_id, adev->ualink.info->ppod.accel_id);
+		return;
+	}
+
+	/* src_acc_id is the AccId received in IH cookie. Confirm it
+	 * matches with the sender AccId.
+	 */
+	if (sender_acc_id != src_acc_id) {
+		dev_err(adev->dev,
+			"HELLO: sender AccId mismatch sender:%u IH cookie:%u\n",
+			sender_acc_id, src_acc_id);
+		return;
+	}
+
+	if (sender_acc_id >= AMDGPU_UALINK_ACCEL_MAX) {
+		dev_err(adev->dev,
+			"HELLO: sender AccId out of range:%u\n",
+			sender_acc_id);
+		return;
+	}
+
+	conn_state = &adev->ualink.conn_state[sender_acc_id];
+
+	/* Check if connection is already established. If yes, then receiving HELLO msg
+	 * triggers a reset handling scenario.
+	 * If the connection is not ready, and we receive a HELLO msg, then
+	 * transition the state to PENDING.
+	 * Otherwise, leave it IN_PROGRESS.
+	 */
+	mutex_lock(&conn_state->lock);
+	if (conn_state->state != AMDGPU_UALINK_CONN_ESTABLISHED) {
+		if (conn_state->state == AMDGPU_UALINK_CONN_NOT_READY)
+			conn_state->state = AMDGPU_UALINK_CONN_PENDING;
+		/* otherwise, leave it IN_PROGRESS to signal the completion below */
+		mutex_unlock(&conn_state->lock);
+	} else {
+		/* Set the connection state back to In Progress and revoke
+		 * all exports and release all imports corresponding to the
+		 * sender GPU. Added in later patches.
+		 */
+		conn_state->state = AMDGPU_UALINK_CONN_PENDING;
+		mutex_unlock(&conn_state->lock);
+	}
+
+	r = amdgpu_ualink_send_hello_ack_msg(adev, sender_acc_id);
+	if (r)
+		dev_err(adev->dev, "HELLO-ACK: send failed to remote AccId:%u\n",
+			sender_acc_id);
+
+	mutex_lock(&conn_state->lock);
+	if (r) {
+		conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
+	} else {
+		/* If we are in IN_PROGRESS state and we receivied the HELLO message,
+		 * upon receiving the HELLO message, transition the state to ESTABLISHED
+		 * and signal the completion.
+		 */
+		if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS)
+			complete(&conn_state->hello_done);
+		conn_state->state = AMDGPU_UALINK_CONN_ESTABLISHED;
+		conn_state->generation_count++;
+	}
+	mutex_unlock(&conn_state->lock);
+}
+
+static int amdgpu_ualink_setup_connection(struct amdgpu_device *adev,
+					  u32 remote_acc_id)
+{
+	struct amdgpu_ualink_connection *conn_state;
+	int r;
+
+	conn_state = &adev->ualink.conn_state[remote_acc_id];
+
+	/* Connection state management goes through different states.
+	 * The states are:
+	 * - NOT_READY: The connection is not ready.
+	 * - IN_PROGRESS: GPU sent HELLO message and is waiting for the HELLO_ACK.
+	 * - PENDING: GPU received HELLO message and is in the process of sending
+	 *            the HELLO_ACK.
+	 * - ESTABLISHED: The connection is established.
+	 */
+
+	/* Grab the lock and check if connection establishment was
+	 * already done by another thread.
+	 */
+	mutex_lock(&conn_state->lock);
+	if (conn_state->state == AMDGPU_UALINK_CONN_ESTABLISHED) {
+		r = 0;
+		goto out;
+	} else if (conn_state->state == AMDGPU_UALINK_CONN_IN_PROGRESS ||
+		   conn_state->state == AMDGPU_UALINK_CONN_PENDING) {
+		r = -EAGAIN;
+		goto out;
+	}
+
+	conn_state->state = AMDGPU_UALINK_CONN_IN_PROGRESS;
+	mutex_unlock(&conn_state->lock);
+
+	/* Send HELLO message */
+	r = amdgpu_ualink_send_hello_msg(adev, remote_acc_id);
+	if (r) {
+		dev_warn(adev->dev,
+			"HELLO: Send failed to remote AccId:%u\n",
+			remote_acc_id);
+		goto reset_state;
+	}
+
+	/* Wait for the HELLO_ACK to come back */
+	/* complete(conn_state->hello_done) should be called from the IRQ
+	 * handler when the HELLO_ACK is received.
+	 */
+	r = wait_for_completion_interruptible_timeout(&conn_state->hello_done,
+				msecs_to_jiffies(AMDGPU_UALINK_RESP_TIMEOUT));
+	if (r == -ERESTARTSYS) {
+		dev_err_ratelimited(adev->dev,
+			"HELLO-ACK: interrupted by signal\n");
+		goto reset_state;
+	} else if (r == 0) {
+		dev_warn(adev->dev,
+			"HELLO-ACK: Timeout from remote AccId:%u\n",
+			remote_acc_id);
+		r = -ETIMEDOUT;
+		goto reset_state;
+	}
+
+	return 0;
+
+reset_state:
+	mutex_lock(&conn_state->lock);
+	conn_state->state = AMDGPU_UALINK_CONN_NOT_READY;
+out:
+	mutex_unlock(&conn_state->lock);
+
+	return r;
+}
+
 static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 {
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 4efb0ece4d113..2ea01874554f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,12 +35,23 @@ struct amdgpu_device;
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+#define AMDGPU_UALINK_RESP_TIMEOUT			5000 /* 5s timeout */
+
 #define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
+#define AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT	10
+#define AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT	20
+
+enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
+	AMDGPU_UALINK_HELLO_MSG				= 1,
+	AMDGPU_UALINK_HELLO_ACK_MSG			= 2,
+	AMDGPU_UALINK_MAX_PROTOCOL_MSG
+};
 
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
-	AMDGPU_UALINK_CONN_ESTABLISHED			= 2
+	AMDGPU_UALINK_CONN_PENDING			= 2,
+	AMDGPU_UALINK_CONN_ESTABLISHED			= 3
 };
 
 enum amdgpu_ualink_type {
-- 
2.55.0

