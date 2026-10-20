Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B812606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5Lqj+s6f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E9110F833;
	Tue, 20 Oct 2026 23:38:59 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3DF10F833
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 23:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyoOXE1PFoxZh8Y6x5QMAddLO5mXZfkyPLGmudnuEUP/vpG+11EQnRiCWLXds9+O3LpObc91CsTcyfeBunwrCfEVK37c0KKu9eVYTWBNec3wlmS9IpEmtRL9knrYxar7VdutRX+/uuxURcqVC4UM0R1t8CWuyr3CnoLUTcG8LFI5HiER5JEmod/xeJ0l7TgoqKXGS5Jx05vF/Xy869VQ7oBHcd7fRhWaoxOJXW9kNE3Wk84RButBT3/7Za2qZiNVWW0VdqageE6nuZmgyIRhlcr7F4Jz5AtEOZ8/+Ihob0ZZbar901ill1CITtGXmVVXSxCfM/jnS2AcUwZieqf/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5wmk3ik4IRIqK3kLbw+nDPuhqUxO7pbhIE9LeptTdo=;
 b=nwl0eEL/n7+Pf4CnTYpRy5xqii5kpcaQjZYfQHKzt4ERgzWJmsUBwGQAAxJMtnCFy17SW5nqAf44jeVMOZ291/sxAZmR1sYID9Mn6menB6RNusPTWveWDrbKRmgdmTGfecyQ7MN8TWcZQzyXXUPJg63HC8acRUujRnPapYHNiuVIrZObYOfXAaVY48kTH5hC4G7xMsMQkSDYJKrhrUDxb6M4zUEdYxTOTeFuP/YWt6ZrtEpVIoCrVwn7vUXi6WrmrrDcT83qZyaeD/i1KmtfHOJbWsPFgzAXe4Iq3nQj4m5JAMsAY1OEO7bATGlyzQQyUyeseRb+5mgulnSnlLGK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5wmk3ik4IRIqK3kLbw+nDPuhqUxO7pbhIE9LeptTdo=;
 b=5Lqj+s6fco2WLFlUlWsDf1wjQbNeDBMjhZaG+C/7dhfPoqHAt7/ysst+dVsgyPYKsVu+OVsi0W42NwtCP89ETsoCc6c8yjUWBbHX58skWLzC+lXo+Zux4XQai3J2EX+EHn1pqj/lLdujGfb9cAkrDcyZVroVtCReML0fWq0r0cg=
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 23:38:44 +0000
Received: from CO1PEPF00018861.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::6e) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 23:38:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018861.mail.protection.outlook.com (10.167.249.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 23:38:43 +0000
Received: from yunxiali-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 18:38:42 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Resend full access request on timeout for AI
 mailbox
Date: Tue, 20 Oct 2026 19:38:18 -0400
Message-ID: <20261020233818.1548031-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018861:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f43dbc8-8e35-4656-a725-08df2f034748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|261009223027099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: hyQbrdj6VQD2tlQBDdG3CXUU2IPYIbAM/8uLVcikqWs1Fy92W1bZW8xjXa+BGYNNVhEXTi+GNVfhfjfOVieseX7g4sE+WOxzNhUYezMF9Q1HzkiX9i0XiXJO/PrDy+DX0nk5SDM5vLZAFlQYFJ4SRnuEYvPBMBlQpBW1F3t40nfMn3K8rlU4wIjSNzmpbOhlJyKUm2zfoyMzvJpvaNkkHljN5G27ADbCtGqF1cwlDTq0oaV5sYlQzzxyPvYSlyfpxMAZU79L4WrNukCIMCzJk88IcSk3/n+7e2YomMt5SOxhuMVKOnlHjwiLVMzB0BIaxWpRsgVpoti423Hxetn4BSVRXK29TMEuo5Qjv1e8vOuTUJOKif/PgaZoVShhdkUz8OEr5MXbQLR8mXoYhBXDdbhj3xLQZRQvE1QnDnMfsOcnVNnIRL0dpN5u/KxKZqYT7Kh4DxqxO+TobkQh5Oij44G1ix3iTSOeVxAAwb1hrOmuNFL4EGodZGveifl4Rf0D1IY2yV869depkGf0AoTYxm0tyLIKBN+neLUixRetw0iUwNVaWYV1UYfgIpLueeig4AYwjlH/RhRrc1GokswwULfREt9YmMT0AM2toJHStgn4y3MrjbCCnb2eEG+bOptRujLyXELYJOM8/NXIuWlyNkxkZGn7QkmTL/X8Rkp2/Dcwwvp+wUebzujtR9dEyREw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pi8DzPsylZzVe5vdc46aEa228VQcUZdqVKKE4ZkcfDPIDFA8yfPuVk9DTh9ixBmrAkxukbhjpL2NXd/+BbZvI26h+ILHH3KEZc+dhwKqjFKhXwCYQZZYAwGWFIqAsfn8M8/lmFFNN4d2ELkY/8KPePVxFFei1V+7A/+m/Qc2Ana/f26KdbaI7/P+Wpt12hr7FjnSA8iJw/B1e/UMwB779RELmJsJ4Dg1y9EjHMtNhZQMH66CpXn82QdLa+oh3DM5pwcBCmLSQh8v0Vg+OfWYsmh/TzvYzMiJUsUuGjVttHiM8YAFfLnr0U1TbNktUnVhve5yqQzzZJ7uUFd6PgOLDgwVvWFXTrchRe7DL8oHKoCxps1RKy0BYY4AYaoaI90WkVDsXdbrh9hmZYiaCkpgHlixMSH4qQNpHYiVSAU9EYkeALNT0MOlFEizxcgJ8vzi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 23:38:43.6470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f43dbc8-8e35-4656-a725-08df2f034748
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

When a VF requests full GPU access, the host may need a whole GPU reset
before it can answer. That reset can take longer than the 6 s
READY_TO_ACCESS_GPU wait. The guest then gives up, sets no_hw_access,
and the VF stays unusable until the driver is reloaded.

The NV mailbox resends the request after a timeout since commit
124e8b1990ac ("drm/amdgpu: Extend full access wait time in guest"), so a
request lost to a host reset is answered once the host is back. Make
xgpu_ai_send_access_requests() and xgpu_ai_poll_msg() follow the NV
versions: map the request to its reply event in a switch, resend up to
5 times, report the failure once after the last attempt, and use a
ktime based deadline in the poll.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 56 +++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  1 +
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fec08f235b92..cfddbb3225d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -100,18 +100,25 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev)
 
 static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 {
-	int r, timeout = AI_MAILBOX_POLL_MSG_TIMEDOUT;
+	int r;
+	uint64_t timeout, now;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	timeout = now + AI_MAILBOX_POLL_MSG_TIMEDOUT;
 
 	do {
 		r = xgpu_ai_mailbox_rcv_msg(adev, event);
-		if (!r)
+		if (!r) {
+			dev_dbg(adev->dev, "rcv_msg 0x%x after %llu ms\n",
+					event, AI_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
 			return 0;
+		}
 
 		msleep(10);
-		timeout -= 10;
-	} while (timeout > 1);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (timeout > now);
 
-	dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
+	dev_dbg(adev->dev, "ai_poll_msg timed out\n");
 
 	return -ETIME;
 }
@@ -163,33 +170,42 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 					enum idh_request req)
 {
-	int r;
+	int r, retry = 1;
+	enum idh_event event = -1;
 
+send_request:
 	xgpu_ai_mailbox_trans_msg(adev, req, 0, 0, 0);
 
-	/* start to check msg if request is idh_req_gpu_init_access */
-	if (req == IDH_REQ_GPU_INIT_ACCESS ||
-		req == IDH_REQ_GPU_FINI_ACCESS ||
-		req == IDH_REQ_GPU_RESET_ACCESS) {
-		r = xgpu_ai_poll_msg(adev, IDH_READY_TO_ACCESS_GPU);
+	switch (req) {
+	case IDH_REQ_GPU_INIT_ACCESS:
+	case IDH_REQ_GPU_FINI_ACCESS:
+	case IDH_REQ_GPU_RESET_ACCESS:
+		event = IDH_READY_TO_ACCESS_GPU;
+		break;
+	case IDH_REQ_GPU_INIT_DATA:
+		event = IDH_REQ_GPU_INIT_DATA_READY;
+		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
+		break;
+	default:
+		break;
+	}
+
+	if (event != -1) {
+		r = xgpu_ai_poll_msg(adev, event);
 		if (r) {
-			dev_err(adev->dev, "Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
+			if (retry++ < AI_MAILBOX_REQ_RETRY_MAX)
+				goto send_request;
+
+			dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
 			return r;
 		}
+
 		/* Retrieve checksum from mailbox2 */
 		if (req == IDH_REQ_GPU_INIT_ACCESS || req == IDH_REQ_GPU_RESET_ACCESS) {
 			adev->virt.fw_reserve.checksum_key =
 				RREG32_NO_KIQ(SOC15_REG_OFFSET(NBIO, 0,
 					mmBIF_BX_PF0_MAILBOX_MSGBUF_RCV_DW2));
 		}
-	} else if (req == IDH_REQ_GPU_INIT_DATA){
-		/* Dummy REQ_GPU_INIT_DATA handling */
-		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
-		/*
-		 * AI uses the GPU_CRIT_REGION_V1 layout in practice, so fix the
-		 * dummy version value to match the actual init-data format.
-		 */
-		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 874b9f8f9804..af4ef0fbdb86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -28,6 +28,7 @@
 #define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define AI_MAILBOX_POLL_MSG_REP_MAX	11
+#define AI_MAILBOX_REQ_RETRY_MAX	5
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
-- 
2.54.0

