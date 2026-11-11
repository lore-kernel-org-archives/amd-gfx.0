Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A73606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A1mSVcYz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9233110FBDC;
	Wed, 11 Nov 2026 14:11:43 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B693010FBDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 14:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAahTvDzunzqY5zP7FLAtxUuUpwU+c/arcq34X3469JHvqsOl7zU5ODxXIDQyhuRdIS319K88Cd9XXo4gBB5gfs8Cn4Y4SFJ8PPy40vewjCZIAx8ak+pFrv8oFlmNVp/PssXbWMKpKqt9Z7Yp+1KHRnvByT4Uz1wHPzZGLezt8SGL2P8n00TbSHjW0JeIO6dcflUe7hsI6/+y/IwPy+Ku6y6Ak/6SPrBKJ/Zp42nJ7F6Fo9MfH2SiTQN/wJIf7B2ah242L/wW9rETYMSMI/ysVvMpVVIdteS2oZFswqm4gE42c4mwOQkstxE862w3W+yQN26rOEWWzUMRWEMQqWSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM92vaLRrl1QAlSqdkcQNgdPxqB3FMGmTVlVdx2EGmE=;
 b=fRD2DPfWQMBW3UN3Yl1/6VaY/dSEUr5+WbWxZM7ZWt1mTpyAK9h+CpeedC9hpYrIOEjtnWRXizHSMVhwgdelTxRyO3CatLKYZff3oeCHbtwDnkxaAIdiORMv97ze1NkdVIEIpKov7r9QQxGNXDmJhWOQMSoQNglkAxQse72zbKfAJR0bwGQ6OoIFglwcBk5ji/QSVEn1rGcyX/nNesaJB0aHd0Q/VO7WPTAWf2t9N2kwEYhKC6eSBbGHPSthXy/AsArkAmLVNZHNkPbpIN5KALXpkTMDfckb8xd6jXBA/i3NknxCxVSbt+z1UOVAA3a5PhlZd5n3kRl5Y9NdLXepJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM92vaLRrl1QAlSqdkcQNgdPxqB3FMGmTVlVdx2EGmE=;
 b=A1mSVcYzagdrcnVsW2MIXb1eCOvIKanuZZu+nsPv0UoHkJoiLQN4oOn7X/whv/Hqt70tBlgD7FlBDsrrZyP+eaPXAvDF3/ByCrbwfju9n8b4yDbKX64/UDVWwBaAwmlE0AYX6CJ4aKk87giej7HBnAsTAUs08jQKvja52Km7HYg=
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 14:11:31 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::3) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 14:11:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 14:11:31 +0000
Received: from MKMWIAITKEN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 08:11:30 -0600
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, Will Aitken <will.aitken@amd.com>
Subject: [PATCH] drm/amdgpu: Abort guest trn during ras reset
Date: Wed, 11 Nov 2026 09:11:15 -0500
Message-ID: <20261111141115.29283-1-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DSVPR12MB449095:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d0b18-ed9d-4821-e53c-08df3ffdaf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yb+VvkYVzFpGCY2jHPPE/0zW11Zuggs/eoqCJ3K6gTJL5L/zJvGgbVdrLk4gBRoAfq6iqQS+/KaStGIWb6qBql4rkzzeV9jlQtzeb6giFKrqKBmydlM57WJnl+vb9OC1pksJwRq4KSLVBI0ipOxboL1HL1LEZ9xTyEd2HP+x5/gXj4Im3FDP+ou70aROrtU4AEoLVmFWfn+CGKIqEaYXk1pZhtucGHEXbpolaFRbsShTqrPDOYUgCU4vrm+a+lVyO+quf2OZxLCQzMeQJ8WXH0zU4LXD45nq2i3UFJzbwq8HEUgVHFpuRjH6m865/k1G6q384P3OLe/HCX0UUQTpzUBimVheggkyoeGdWFtluCHR8idRE5g87W6eO6EERJ4t5zCHsHmZh/jY3BEi0CCwW/oDNIHCZnGgiMEmzG+s2QH6MBQsTNiPwk4CUcw912rUjwMKUQ1Qj53mJzGnMFNpTI/RwldgaXDDMIvNXG45Wlve4rjjOqLFQ9L+RwZ0ZMFBbnt1OeF6itQ5LOWPgLFWztCJRvCOUzAoQIANiqpK9zbTduWAbm20DcykyOrV8gKz+U58skdY40+2R4HToIpYPe8oJMpPff+MEfcq1ho24nPcvY6UpWiBTHkPOQiZSef35a0ZE7FbRIiUQJgdhZ6ajxLH4vQEaoKGHwx/2kTcc+UNXbFEa+f7udl5f3S28sUb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 82DST8gTLggAYNvrBKEQ4tq7xPAywXBKTHz0Z7J5er3HSb8YsfdbZ32Oar/BXPP242WifYgdLVbvGJXs7SLVRuyeV22AjoqyBYhDWrnwHkvdNYLvtFq7G9JtrkQdLq5r+sXwXGi3U+caEgCp68kh30zM0F5qSTEMyPDBSA5VZo9HSOFpP40O1OoU0PwlJScG1miy2Ukf9k43e38S5QM17r+wR3h05Uqc9B88k0lMYsQTETDJ/jgfnr4virrjxYrPNxnU24aj+TcHq/8x1gA8F0NWMBJfC/7xRVu6rityHRZpREZ4LJP+CHmm/6QiHBz5i5QLrYKIodmMmeFmwnnDcoEND5WHK/KWQW9vt+BncpHcsouDPGmu8xxEsNZsIbsGGPxGcswYoMXM5ispKefzlrVXt53w7/37GFA2od933kh5g9kDj8gxloIStlgyY2hS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 14:11:31.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d0b18-ed9d-4821-e53c-08df3ffdaf8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB449095
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Will Aitken <will.aitken@amd.com>

In sriov, if the guest tries to send a message just before the host
begins a ras wgr recovery attempt, the host will never see that message
since it is busy with the recovery. The host then completes the reset
and is waiting for the guest to recover.  Meanwhile, the guest spins
waiting for a response to its original message until it eventually times
out and proceeds with reset recovery.  This patch prevents the guest
from sending the message in the first place by peeking the rcv mailbox
before sending. If the bar is down it means a reset is underway and the
transmission should be dropped. Doing so prevents about one minute of
idling in this scenario.

Signed-off-by: Will Aitken <will.aitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 30 +++++++++++++++++-------
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 4b1b42fee6b4..d0c08c7bbc92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -102,7 +102,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 
 	if (virt->ops && virt->ops->req_full_gpu) {
 		r = virt->ops->req_full_gpu(adev, init);
-		if (r) {
+		if (r && r != -EBUSY) {
 			adev->no_hw_access = true;
 			return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a2c1aa838737..19594e761094 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -106,7 +106,7 @@ struct amdgpu_virt_ops {
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	void (*ready_to_reset)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
-	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
+	int (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
 	void (*ras_poison_handler)(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fec08f235b92..32398eb884da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -116,7 +116,7 @@ static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 	return -ETIME;
 }
 
-static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
+static int xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 	      enum idh_request req, u32 data1, u32 data2, u32 data3) {
 	u32 reg;
 	int r;
@@ -158,6 +158,8 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
 
 	xgpu_ai_mailbox_set_valid(adev, false);
+
+	return r;
 }
 
 static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index eb537b2ae685..5c984653df58 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -82,12 +82,22 @@ static uint8_t xgpu_nv_peek_ack(struct amdgpu_device *adev)
 	return RREG8(NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE) & 2;
 }
 
+static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
+{
+	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
+
+	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
+}
+
 static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 {
 	int timeout  = NV_MAILBOX_POLL_ACK_TIMEDOUT;
 	u8 reg;
 
 	do {
+		if (xgpu_nv_rcvd_ras_intr(adev))
+			return -EBUSY;
+
 		reg = RREG8(NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE);
 		if (reg & 2)
 			return 0;
@@ -136,7 +146,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 	return -ETIME;
 }
 
-static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
+static int xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
 	      enum idh_request req, u32 data1, u32 data2, u32 data3)
 {
 	int r;
@@ -149,6 +159,9 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	 * will return immediatly
 	 */
 	do {
+		if (xgpu_nv_rcvd_ras_intr(adev))
+			return -EBUSY;
+
 		xgpu_nv_mailbox_set_valid(adev, false);
 		trn = xgpu_nv_peek_ack(adev);
 		if (trn) {
@@ -170,6 +183,8 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
 
 	xgpu_nv_mailbox_set_valid(adev, false);
+
+	return r;
 }
 
 static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
@@ -187,7 +202,11 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 		goto out;
 	}
 
-	xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
+	r = xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
+	if (r == -EBUSY) {
+		dev_warn(adev->dev, "Ras interrupt detected, dropping request 0x%x\n", req);
+		goto out;
+	}
 
 	switch (req) {
 	case IDH_REQ_GPU_INIT_ACCESS:
@@ -573,13 +592,6 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 	}
 }
 
-static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
-{
-	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
-
-	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
-}
-
 static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)
 {
 	return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_ERROR_COUNT);
-- 
2.43.0

