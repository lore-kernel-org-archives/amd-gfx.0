Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D514606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W0MwSO+S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBCA10E070;
	Wed, 21 Oct 2026 20:48:44 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5EA10E070
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0mpUo5x5gobY8rtBA8psg8oDaeMvstVpogezXsTpk2+I6WH8WxpDBN9QYPiDD/Y0cMy6/IsvAOtBWl3no50MwTcMXIluPu/aAEs7B4p6Y+IfmybEyZi1rmkoiuJ2I++OctBJcrVKhFDR3XfAcmE42bMaMUwAEJvsNEuBI1TVzyMSIBmkkMTalamDiARCwm19oGkIYFmj+tTAc98EyQGZt1T4Pux0Ls8ISgAVWo9//J826nU4wUdHvBQnYAHj+H8icIVlYI3fqN4DPvHDwMNHCR9Weqaja3r9BXX+wopgmkiiEnpgyY642nYmcqvru5m84m+hJgylcWl/oL8D/xgog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG3f6zMgCPR6zpzL5vR2r6CsFxJxk5LkbLL2yCfJu88=;
 b=kTPmd8T1KS0gFmOiaqOeOCMtPnjsQ+y3NAgXWvHu1sD1zOdNS9cHqMN7WS+/mOwfOJkaVT0ThO/YoLHY7nmmMM9cTXQWpj7h52Ph3nRtOBFpnJvE5xxQQJYUADFTLrWFu+LzVZjbz2XxFjqNGd6j/ylWWfLjUBIlJS/Waz63rd3LYEHw50byBqKASNPuHDRcXF808RCwVBRT+rJsEgy33RxPDyKQQqtvQzuhfAxn9/ZX4xmul7HRQm0YrWTf/4axCoJAlUwB9w11nBoo2kS+/aH+nRa3ivSX/70A8eCVwBe9U4FoNd7upu4O5BD5lYav6xyJP6LQUYJnlid5tYxZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG3f6zMgCPR6zpzL5vR2r6CsFxJxk5LkbLL2yCfJu88=;
 b=W0MwSO+SBHOZ54p8Bq7kOZZwKbzEfHFzdtx4gd4FLSmLVon9pv8l3RdXoUK2E1DHnEAYwVWmTOWlp0gbp6UzBKyH/uLi+ZASW7/NEZRYQX96zqgtqAI0a5FpkmqKFQQisvfxPA5VWMNNFYLR3HmIGmmcrJsqKQlSjQh+t8wprtU=
Received: from BN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:e6::18)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 20:48:24 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::a8) by BN0PR03CA0013.outlook.office365.com
 (2603:10b6:408:e6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 20:48:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 20:48:21 +0000
Received: from heliosr-1b114-e03-4.mnb.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 15:48:20 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Zhigang.Luo@amd.com>, <Gavin.Wan@amd.com>,
 <Jeffrey.Chan@amd.com>, <yunru.pan@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix NULL RAS context deref on VF
 unrecoverable error
Date: Wed, 21 Oct 2026 20:48:08 +0000
Message-ID: <20261021204809.204454-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b18dc1-cd19-4d84-3f16-08df2fb4a4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261021121427099003|56012099006|261021135927099003|11063799006|261009223027099003|10067099003|18002099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: j4o2/UMwq1Stubgybf2fijojeo+BSEEXWcFb9s5VLRVXpmc+1Z0DEgP9gi6rCfZxdQnIRcxhXG2JoifjZ8lg+K2ThNBhnj2Od2W8hEc3tpFszEIZYEdvibt74JR8GR6qISyQ2m25y3FWRj7oD4m0FAJ9OfreF5Mdz9t5WBVCsQZ7vlb7s/I6LgG2iC3Y3XJpxtvYdK4bANyJkGfRUhBZLRu1NOFBFhOFOfBzAkJoVWKjsahv5/lxeZVJzSX6QIQhRl53WxhgxD7lZRAxAk2sliv1svIq/rSGn8uzJITK8vPkrfgoDcFwCH1RG7/UEJ1Xp+zZONUQ9JykWhBNs3o2CgFwsWbP1VUd9lYMwFDs+YA4o9DmGZwLmEZiEQ8Cm5kVxVRYTR7vePOEM0e8zdOUKHGc6eMwDGOwJUWf6EOdnZe9le7HBuuaA1ph5CJVVobiwsjRv4hDGqa6JqyLnLvTKuQQEh9Kg0q5EOtQL7pb+SkrRZJ+xoFzB98LyQq2PtDjQxqZ2esjYA5QSQTTRA9dzcwN32ZLmSAMr9g9RPPalj2eHdEIxA8gxIiR4KiuKH53ARgCsT+X/93D9SDvzrXmjG72YM77e1IRPXmKim44EqbScTHy99lZneL4tuBVRK8oI4iujibgN6fFH+nm0KuC/dmLxwpzx0UnPRWfiJJ9ndlF+BeD+l2jhNcmb6mHnCjinMMqTflpMfOsbBte2g1wJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261021121427099003)(56012099006)(261021135927099003)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X3LUoH48JEgK5tLFyioWx7CmTI2QMZezMqP+CkZdkOTVyPHh7g+eCU9Wu8XEm39wYM5Dn+1GnFmKYG0tGS/7eA/MEmzCcyev3Y01StcPcHh7PKgFI25t9eXB6hiz9IPWFilLdIclhNO9akVUA0rY+YXKesdCIPtgytPeGlU261SrBl5DQgOlHz7cRLXbrWunDikEFqp5/nCpNqZGyrx/0FyZve9fzAJi8FjnFAp50NFoxwA2An7mjqw06OMFTQYBFoXYjW03CmwxGOP3gl/rwJFWg+KZO7YVm18czUERIwjb3MZmt+hgDszTfPoDCcmbHWHZ7M/aa6X237IzJHeBCwCdoG27svnNjVF1TG4M/ZRYJyH5l+/WbUkwi8K9ELTW80hIPv9TA8of146vhgR5C7ykrrpaZNhlnqmFOJfah3AeFVlaiAF0AL0App5mlLNp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:48:21.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b18dc1-cd19-4d84-3f16-08df2fb4a4c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A VF has no RAS context when RAS isn't supported on it or
before RAS is initialized during probe. Handling
UNRECOV_ERR_NOTIFICATION in that state dereferences a NULL
amdgpu_ras pointer and panics the guest.

The fix is to track the notification in adev->virt.unrecov_err
instead of the RAS context, and amdgpu_Ras_is_rma() checks that
flags for VFs. Once the flag is set, mailbox reqs fail immediately
with -ENODEV and GPU recovery bails out. If the notification arrives
during probe, probe now fails cleaning instead of panicking. If it
arrives during unload, unload completes without accessing the HW.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 23 ++++++++++++-----------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 557baca454a9..8349b86ab932 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4925,6 +4925,9 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
+	if (amdgpu_sriov_vf(adev))
+		return adev->virt.unrecov_err;
+
 	if (amdgpu_uniras_enabled(adev))
 		return amdgpu_ras_mgr_is_rma(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a2c1aa838737..4a30306a387d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -358,6 +358,9 @@ struct amdgpu_virt {
 
 	/* hibernate and resume with different VF feature for xgmi enabled system */
 	bool is_xgmi_node_migrate_enabled;
+
+	/* PF reported the VF unrecoverable */
+	bool unrecov_err;
 };
 
 struct amdgpu_video_codec_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fec08f235b92..4dcfa256c9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -98,6 +98,16 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev)
 	return -ETIME;
 }
 
+static void xgpu_ai_set_unrecov_err(struct amdgpu_device *adev)
+{
+	if (adev->virt.unrecov_err)
+		return;
+
+	adev->virt.unrecov_err = true;
+
+	dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
+}
+
 static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
 	int r, timeout = AI_MAILBOX_POLL_MSG_TIMEDOUT;
@@ -345,7 +355,6 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_ai_mailbox_peek_msg(adev);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
 	case IDH_RAS_BAD_PAGES_READY:
@@ -360,8 +369,8 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 		break;
 	case IDH_UNRECOV_ERR_NOTIFICATION:
 		xgpu_ai_mailbox_send_ack(adev);
-		ras->is_rma = true;
-		dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
+		xgpu_ai_set_unrecov_err(adev);
+
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 					&adev->virt.flr_work),
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index eb537b2ae685..3062f1506760 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -103,11 +103,20 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 	return -ETIME;
 }
 
+static void xgpu_nv_set_unrecov_err(struct amdgpu_device *adev)
+{
+	if (adev->virt.unrecov_err)
+		return;
+
+	adev->virt.unrecov_err = true;
+
+	dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
+}
+
 static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
 	int r;
 	uint64_t timeout, now;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	now = (uint64_t)ktime_to_ms(ktime_get());
 	timeout = now + NV_MAILBOX_POLL_MSG_TIMEDOUT;
@@ -119,11 +128,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 					event, NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
 			return 0;
 		} else if (r == -ENODEV) {
-			if (!amdgpu_ras_is_rma(adev)) {
-				ras->is_rma = true;
-				dev_err(adev->dev, "VF is in an unrecoverable state. "
-						"Runtime Services are halted.\n");
-			}
+			xgpu_nv_set_unrecov_err(adev);
 			return r;
 		}
 
@@ -453,7 +458,6 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_nv_mailbox_peek_msg(adev);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	switch (event) {
 	case IDH_RAS_BAD_PAGES_READY:
@@ -468,10 +472,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 		break;
 	case IDH_UNRECOV_ERR_NOTIFICATION:
 		xgpu_nv_mailbox_send_ack(adev);
-		if (!amdgpu_ras_is_rma(adev)) {
-			ras->is_rma = true;
-			dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Services are halted.\n");
-		}
+		xgpu_nv_set_unrecov_err(adev);
 
 		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
-- 
2.43.0

