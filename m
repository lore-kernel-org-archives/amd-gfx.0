Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB4FC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D236F10F428;
	Fri, 21 Aug 2026 19:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ilJWuJeS";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF1110F423
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4NctcrhCi8KHw6jNZfHVcFgierCsZdPEm4sidUfN34xeFplILWO1sBy7TQIrNX+nWYjZsBGp9G9sAq21JmkKM5f0oyP87oe1/4gE/UaybRyyWWoAObegJCaQuIkLdKyB9raO9WvXmFInLx078i20pvqNea4dQd5TJhCgM9Te8sdSaufny99POwxDKDBHabu07JhTTKi2pGE30AnBwS9qCuWP8PuoQVpHTwazsJZYRaNhK9T+q/oWgyrnOeJNXKPLPXkVsvZys0OA5z2hmsoO72dXQSIV/uEeas52o5bTzYfkwHovKlotl6NZlonNdesXRleJyzdjy4dAp4aUySAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqvyhnDmBe0DUBH7iIcjHj44ofW0idj+L16KOTSncfU=;
 b=sewy2NULFEevERNyf9vCLejKZtK6QNpwHKZwKC9yGF78fYPH5BsQnXwbhnZwULc2mG5UgCOKbLKhi0KEAzy3QgshA9btjvf+vK7NH2qBpBQsCwhGHdYe54SqfzLYpWTg+D2JJLJ9UM6lD+RycuAA4/vv4wNymZ9UskN0efbD8wY6LcO/ynOBa4faFtSNHecZquE/dl6Xu5RBLMh0PPED8yl3cPKTwr1au57S1NZZUO8y9bt+GA9nzt9qAFp7gnDz3htwbBW2w32OzXMXAt0Qj00sUY0g5PH5QWNMviWklr0HPYVPRSA5cH7tR3B8VHC3Mk4lqR+6qO28u8iFDYPCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqvyhnDmBe0DUBH7iIcjHj44ofW0idj+L16KOTSncfU=;
 b=ilJWuJeSNKps6fVApsn6TO7WE9tjm5iab+MX3Rv2j8zxI4O8/aOrmX778Xy8+/q+O8ZQPpTBgcunNNqQFp4j5ImWtV/GprnwbzOn7xmSlM2U5BZRuAxSG2W2PoJwNGxPpqRfAsB05wOXFJF4KAnfgSb5I+blsUwHyNskJIygaE0=
Received: from DS1P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::15) by
 SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 21 Aug
 2026 19:35:51 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::7b) by DS1P222CA0009.outlook.office365.com
 (2603:10b6:8:454::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 48/95] drm/amdgpu: Add connection state management
Date: Fri, 21 Aug 2026 15:34:11 -0400
Message-ID: <20260821193458.808626-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 98714c47-37ae-402a-233f-08deffbb6859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BwWzeRfwFmu77yVJ9JS+L72ABlDN1QAGS+jUv0A01G9bE26jA5FHisTY2a4Z7L+S986oy9+TEO4TbbVFJY4islvGMDWe5vSiP40JWYL0w2w1CgLhXMhASJFUo96ot7nvOJp6+OI5QYd0KuTquRC5z7GAX27JGhfCxAwl5nykzilBxpdvLHwf0/7nF0bwE85J9UnzgF8D/tzPMO3mfhOeKmRwoREVHzHLlKAWbf0kxK0YhkSOOUWwt7+rzvP2J2ASaXU2lVFyi2novBuPfMdwrCb28CGtHeRK9tKNWEn8NzahRGHYO9Em9Gnu2hAdgx4GOGKD0dbNclr1z31ftmcYfLmcOKwZ+1yailiApH6+VurQ0BwbIQSQLGV8oDwS0pFvBLA4DW6aVO1J+lVCCXj727jUuiCBKEdjsn2iOa5kRiG7edh+QgQXgWAxJ5BNbt5njyI1xkuR/BNjxQQYQS/Zhxg5EXSo7eqM3ulmqS53zqTH+ShmZVct01bujC0G+m/iNCRj9NKaLZ71MH//JayNCLqRpFROQZNsH6xCZpiA8AuBiRVbffW5g7Zvleg5MDbJMqERg6AYyuqVskiS0hqvwQg9EOX+RlXdfrYl22weJjhOKBW07QpCay3fuhqKleN61b80ASgIrG70mn6veRd5qrM7OZAkHNrRbQGrap1+5aG3xahBTNrKnlJWyjKRXDQPhUdYB/2eCB4hh2zlJxMGZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b3+bY5e7YgLBtfD2yf5M2aMWpIVybn0cmYVEV1UJQXZntT/23A7i4QyTqShGvrkf20xI+HfBP8aHrLWDwqI43c1jjX2wPQzKAsy7NkA8umCAMPvULU/O3BLJvbwFltOk7EMzVr1s3fEwTbPIY6p4ySFI4BvSBRKaR6dLMpl5M3QJvMD/novz/r6rAAOZpOvQJt7d0xNJAwHPAhjKonG0L4iOW2/ykmBq3AkIzUZWztU9+xVOJspaoU9/okAbig888BqCYOJo3AFJee9aVGXynmh9vUR2idmfTSKYZwcxVy8mNOwhDIqTFB6JeS5yWllVaZm8Igp9YekAFzPhYOenIEmItCfLC7cuuXEoIbpLehD0dsp1PH6LtquxfF4WrCvQMKMTiycuKXLOFfKD5TyP9DzdDdZ40TAElbXEx7+4MzRTgGbd4cQ+QvQrGFYk5rP/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:50.6981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98714c47-37ae-402a-233f-08deffbb6859
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 226 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  13 +-
 2 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 34c69de06e48d..9ef67d10aa963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -32,6 +32,9 @@
 #include <linux/string.h>
 
 static void deactivate_accelerator(struct amdgpu_device *adev);
+static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
+				u32 remote_accel_id, u32 dw0, u32 dw1,
+				u32 dw2, u32 dw3);
 
 static const struct drm_client_funcs ualink_client_funcs = {
 	.unregister	= drm_client_release,
@@ -1206,6 +1209,229 @@ static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
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
index cf9522e4f8a74..c8c37d4ee4b48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,12 +31,23 @@
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

