Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18C606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R7iPb7jS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D68A10F8B9;
	Wed, 11 Nov 2026 01:41:05 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FDE10F8B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXRsNtSmcx8o5XYNqkSdM0FWlFB22jO7U6wScODffJgbzXjSRkokk4bbfW6jtBJhraQ8U3zLpr1oU3UBERYfh3hInN78TzRVezslboiHAv/EuXyxlyeJVx8BlMeHNwh0r0ftxLEakTx5kRQuhwoF0Znw0P4s24jiVWSBOkG6dhQ9ZOpSiuVoH5SWoO2utpSqkBehXJ43EDe+vBdWqQQ4Lh4C9HxjqBY1UQUD/huZp2VDz7SeVRBjhfIGVQS237zEZC4aJgIrC/oS2hNKtKJ/7WmkNUIdkT68tEMovijPhvzbU/K6ZwvhsDPDI2KfGtzkByq5jBCazFLqmNRykYEZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk8S8YAKykFulXrqzXZMJRR9LiOX8GT9F8RPr5xxIU8=;
 b=OtByTZXMKzp5kJECQCLY0x7rjdgJspbCA8JNEVCxu7x6wEiGZiKskdC3neZWLSbKpSlsOp9tA3ujW4Y2srC6EvOi/zsQoDJWthRxEAZ3kvSFrBgtfdo++r6tefLDJ9dN8ncDOD/rNgswozLxRKTG+VQ1KZdbt95d6agYbsuk/bNslostTiq1AtMDI+SYZAL6fmhMb3kkiST/ZBwmTwWs2YLRSRMjYrA4vPBtCAOPj6IE+2vGGV/h3xCjsFIxya3VyB8ezfOKGtxl6B5KHFm8ZvjTF1KQ32Caq8BA5/B2/xAznQk8rqgRlDU1liXZYwVyeSgdhZ1qxOYRwXrCdxegOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk8S8YAKykFulXrqzXZMJRR9LiOX8GT9F8RPr5xxIU8=;
 b=R7iPb7jSTdWJfc509CQvyzslW23UEAq3knllInCrlIOkn3NpkVXPkfgY6en0wBhQ1UQwjDu9DYKTrz/q3A1sJwdPaiNio6wEVceuh4nxvpE0XFDwd+6i9HVmcomknzR0+QbK4Qf90eWDLM8hLrspYM+1WaAlYgx/dtEaFQEgyxk=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.8; Wed, 11 Nov 2026 01:40:54 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::a1) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:53 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:50 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 08/74] drm/amd/display: Move HDMI FRL Polling Outside dc_lock
Date: Wed, 11 Nov 2026 09:28:14 +0800
Message-ID: <20261111014100.3596072-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b3d35d-6c49-44bc-8a5a-08df3f94d39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|11063799006|56012099006|261021121427099003|261022105027099003|261009223327099003|261028144727099003|261009221727099003|261009223027099003|261026140227099003|261009221227099003|22082099003|261021123027099003|261102123227099003|261009220027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9MarDKVE510k3s1tQxegN0wNplK+MooQHB4GsmZWJWdDJgsNlmiGL1qdZT0XBjvEghZkoq0QuFV9nUwL0Xhrt7JZUDv4j106TK+qR7v4xR1rAUfu1RteEnlLWQp7P/MOnwDMJyOseDju7Jjt+TAMspPEFbea/8xo7sY0Bis1l0Dkn3WwBqAHGfhy33VotVs6r+dOABhhh9Ck89gYiUWu3K5SPVhmXTCJdM0vNH1V9u2j6KCslo2x6/8PLqIzQSdPEke5dCH5tBoANK5b9guQrqdLuAxuqjaDNNjopEczR4H0WfAd/+ZtgLbsuWbYFzzbWE7iBUPCxv5RhzVozspz37tTh/hQ1R5IBAnzhYmDuZmm+VS8XUsnOg4cMJvCjbDwqi/DgZwHtJB97koCkOJERI4Wt/NSwH089lczflHbRRnJXhfdUOlnNw9x9Gi8+jD/7XbURuXJNSlGB5Ffk2kdoGIp3WzEjHXmmdVk3Di5Vmi1usDUtiJw/OVUdOOLqtSVGR7DrUnhJcNm+xQhqw7MlP8sdmWI1axYSSoC8HLTNUC4Rr87faNUwcFHG7Q9mzOV6kwsV6JWhqLeuVVsJDyrtoQUVjxX55r/3/yeKiC8ERt+Ub/GUO1xz3ewJ2Af52ujEitdgMr0hOtvPp/ATfSNPxM730AEsLqoz4Da2VqNcmul0G8tzlSG44CNeCUuwpKSgUOe6SKMKjzZvdkXPIsrzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223327099003)(261028144727099003)(261009221727099003)(261009223027099003)(261026140227099003)(261009221227099003)(22082099003)(261021123027099003)(261102123227099003)(261009220027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJzbqh+tlfrsKlmMpPu1cE7lRV1b+HwbJlv21YE2/Zq+v34ZlMQIhV5sFGF6TZHn6CgUWFwmK0DHRO45ZFkrFpYeyTyypA3+d+zTLIihqIvvYkfu+79pAX3NZJH1PejSardmXXvFuWTd1b8xzaDU+4p60HDLb/Xt63LT/aklFAzOtaYNFge8fP+8NqrOdHw8sRecSMtg2Li2AAMdLWAnaMXSBNVgEtrXa7CQ3Acafl1HjooDCsBZwOHxRV8zJL2eZh6WziCOxRAlVCBtnIdhIrbmug2fljlVyxlxmOfSxgEhGMjbGdz541r9vkgdAF0vf1rNhFTCLt55FtfetvcRpootPq7E1PJM/M73/J38hvN/oyKKPwN7L7ivEzzr/UT/GVKDTHPpdx/ko3Il3URWV72ZpkSxEtv7hzXD/pRy40zkWg85ZueHpma4OwxYPqXl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:54.6704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b3d35d-6c49-44bc-8a5a-08df3f94d39a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why]
amdgpu_dm_commit_streams() started or cancelled the self-rearming HDMI FRL
poll under dm->dc_lock. cancel_delayed_work_sync() can wait for a worker
that needs the same lock, creating a lock dependency that could deadlock.

[How]
Release dm->dc_lock after dc_commit_streams() and the idle-optimization
update, then scan the committed streams and start or stop FRL polling
outside the lock.

Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33c73ca9cff1..7fffbb609225 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4749,6 +4749,11 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
+	/* Allow idle optimization when vblank count is 0 for display off */
+	if (dm->active_vblank_irq_count == 0 && amdgpu_dm_is_headless(dm->adev))
+		dc_allow_idle_optimizations(dm->dc, true);
+	mutex_unlock(&dm->dc_lock);
+
 	bool frl_stream_found = false;
 
 	for (i = 0; i < params.stream_count; i++) {
@@ -4759,6 +4764,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 			break;
 		}
 	}
+
 	if (frl_stream_found) {
 		if (queue_delayed_work(dm->hdmi_frl_status_polling_wq,
 				       &dm->hdmi_frl_status_polling_work,
@@ -4768,10 +4774,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 		if (cancel_delayed_work_sync(&dm->hdmi_frl_status_polling_work))
 			drm_dbg_kms(dev, "200ms frl status polling stops ...\n");
 	}
-	/* Allow idle optimization when vblank count is 0 for display off */
-	if ((dm->active_vblank_irq_count == 0) && amdgpu_dm_is_headless(dm->adev))
-		dc_allow_idle_optimizations(dm->dc, true);
-	mutex_unlock(&dm->dc_lock);
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-- 
2.43.0

