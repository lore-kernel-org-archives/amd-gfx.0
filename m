Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F07C624DB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 20:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B1710E38B;
	Thu,  3 Sep 2026 20:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tnEZ0JsJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C9910E38B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 20:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX1mx+D8tzunMq+zzZ87IqGBTPtJsLTkgb/X36oX1gFi6gXHKwYvVHCltV6ZRrOIYrqogrnCxMgodhqeVZAHOy+5klQypSPFCd4Afy/hQuiJVvjDRsfT3mzxgMUELMVA6LdGmPgGLpeUoOKxph5ugVLccKA7SG2JOMRAgrlgqsVlXkjxUS73T2UnpDI0cET9oyJUE5hvJklloR0yM1NnW5l/jdRqpKqRruzyPmEYaT2kfGzzH2H7U5XUJDX5YkmWMelJDd9AZ552puiK3dZuZcQ5bPUuLbNo6oLB0EJ1ncwnH1c0wL6WQDcqEqTNxK2vlzwSNbYCp9/4xXrB7RriHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk7xPCWs0UWOdb2bRpVvwGWr+mQkgTjQrTGmfSkAi4o=;
 b=P0pAAIh1v8lAdRJMc5EybCnVnjJjC948qIqCjshV0a6P2EWPsCwphEBsOy447eaM7omPVrjxWPzg557wlGE6J90I0PDWxiG9V5E9yj+veIXcO9Lo3LbVDDAmE4w+XA46atIwr9ARTRJUOmyPX+183DSGJ5k3wUqn6//yK1RM5Z7U1Y4jXmpRJ6g4CS5wPxzj51UbSnnk0p2MHryWWEh6y/eMHnMhFCXWMP6l7VOeaf09o3rWop+p7D5O2A0Bf20rMluNcMbNed2jOaV8qsHDcgaBg7tStUN0DmhyWk5OpyYjLikO1uaLkpe7ldyCsfESG5pz+y7Jo0p1cbEf4ES0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk7xPCWs0UWOdb2bRpVvwGWr+mQkgTjQrTGmfSkAi4o=;
 b=tnEZ0JsJ2WA8zwFIizEqzNfz2UQhA74yv+SAkJ52C7nAHwgTi0IwUJf2BgnG+7/V/yz6+2OAB1sjCrHbiinvWGwB2vnwihPsgRbg3uQw2EGC3y0OmqNAmOYfyN3SIho67wMIuqgT5uRe/Ok/+ih6FXHZP+so25KiK4fN63IZmT4=
Received: from CH5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610:1f0::6)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:48:56 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2a) by CH5PR05CA0005.outlook.office365.com
 (2603:10b6:610:1f0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 20:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 20:48:55 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 15:48:55 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Don't ignore LSDMA copy errors during remote
 interrupt send
Date: Thu, 3 Sep 2026 16:48:40 -0400
Message-ID: <20260903204841.3485963-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ce2617-21ef-41a7-e09e-08df09fcc56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PpHbM4Aj2NhvuwJRpwgkvSvgrIc5hv/QVtEb2S1WNILVlq8Pc3fzG3Fow0PbmBIYJSEMwxqPc8VfodoOPT5LKLGc1NcBW4FvOf+DuaIPc2ZHcDqQMA/m8qHKMqsqSb+BBsFsyQLuEcDUTviMUxrRfzUrFcVdbNe0RwDWtcuMqiqtfZK1y04f/20B2CW1OGxI5YDsgaYepBIRnJBoXLp8i1RMLi4petNdQbP4L46I6+40CB2UYpoZeoFxC7CXRJk0mBD5G7piMAfEjJnx12lKRwHwplriLdSmxIdzlTzeYa14SAEBKNxPT1uWuQgahi5R5JfNz5Ys09uvOp34o8FLgp1+dXlkUEyX0mfOUnH88aFSck2/C6YWSeZqtQPAQcU7S0He6vVq1b7XUXi3hdlcJatw85sK0wetc6rLznpTWS4PlT/++5HJexdh9opjwWwOX3UNUa8JcNj4kq42cioAPF1V+C+4B68fitdsss66x8HiScDGiPZHZU1H3GU5Y7p1ZSbWUqqlRXWAm13zH3imblPmg88xknt9g43mfKVuozx5GI3Bmju535Z2ODBs93e8j5lZAe0z1oOTOp9fXDrw7c9AKRseFoHBHZEzFFoIfNPSdTR1Y5qRe2BlGr+RJDNgaZeQHpRVEOMIwqebCMZqChv9mXEwNjRZqhYzyic9HSe5r6Ogc/d8ITb4BhZ+PK8eVgj9ArWcY0O7lXlQ0sgRLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vl7DN/gw43a45K4J2f9VE5+aaYgB1/oJslCyznVkYsvTAMPHQoHbceZ3OLuNQrKkO9OqIOlj0JbZf2mKXuXyHWF9+8rWpxwpwO9KG8OHaAqAqjFY3xfx0Y9tH9m19iNe03gdd+7STfBgiWvjR2FM8OtU2TyJPiygt9GYtBXjmctQVhI6DnretFS3JvinjEtdu9MSrmziD8pPRVWvWHVHA0iIGwaZFJXMlxRedIQ+jmaVcdZ/xMjRmJ8Y3y7vyhOx/BvYm9P1cWCrfzLmiAD8jj/PTBrkpdbAfOgLcukUZldRJLjmkghFWQ9AwJsqEWY8swbwPRRwzq3/DwK0icNIaCAdBpKAhCjK3cUjNTfdtIRkm2l3osH7EClP1XqExi83cFJ0AOwAO0LosixJaDAyyawYx5OQ2VYLjskHfbpbS2kQZ6YAjcJsTyrGbY2WKaod
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:48:55.8145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ce2617-21ef-41a7-e09e-08df09fcc56e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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

On the LSDMA path amdgpu_ualink_send_command() ignored the return of
amdgpu_lsdma_copy_mem() and polled the remote completion for the full
timeout even when the copy failed. With a peer down, every NPA-REVOKE
send in amdgpu_ualink_exp_cleanup_worker() wasted ~2s, and the peer
stayed ESTABLISHED so each subsequent handle cleanup timed out again,
piling up past the 120s hung-task threshold.

Return immediately when an LSDMA copy fails, and mark the connection
NOT_READY on a failed revoke send so other cleanups skip the unreachable
peer via amdgpu_ualink_check_conn_ready().

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f5e1e5217fa5..f5865c5fe93e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2903,7 +2903,8 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	}
 
 	/* Send NPA-REVOKE to all importers which have imported this memory.
-	 * On send failure clear the bit (no response will arrive).
+	 * On send failure clear the bit (no response will arrive) and mark the
+	 * connection NOT_READY so other cleanups skip this unreachable peer.
 	 */
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 				 AMDGPU_UALINK_ACCEL_MAX) {
@@ -2916,6 +2917,11 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 				"EXP-CLEANUP: NPA-REVOKE send failed to remote:%u\n",
 				remote_acc_id);
 			clear_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
+
+			imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
+			amdgpu_ualink_handle_connection_reset(adev, remote_acc_id,
+						AMDGPU_UALINK_CONN_NOT_READY,
+						imp_entry->generation_count);
 		}
 	}
 
@@ -5623,10 +5629,27 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 		r = amdgpu_lsdma_copy_mem(adev, src,
 					  ring->rb_npa_gart + (ring->wptr % ring->rb_size) * 64,
 					  64);
-		r = amdgpu_lsdma_copy_mem(adev, src + 64, ring->wptr_npa_gart, 8);
+		if (!r)
+			r = amdgpu_lsdma_copy_mem(adev, src + 64,
+						  ring->wptr_npa_gart, 8);
+		if (!r)
+			r = amdgpu_lsdma_copy_mem(adev, src + 72,
+						  doorbell_npa_gart, 4);
 
-		r = amdgpu_lsdma_copy_mem(adev, src + 72, doorbell_npa_gart, 4);
 		amdgpu_job_free(job);
+
+		/* Copy failed: command never reached the remote, so no
+		 * writeback will arrive. Return now instead of polling the
+		 * completion for the full remote timeout.
+		 */
+		if (r) {
+			dev_dbg(adev->dev,
+				"remote %u lsdma copy failed (r %d), skip completion wait\n",
+				remote_accel_id, r);
+			mutex_unlock(&peer->lock);
+			return r;
+		}
+
 		goto out_wait_complete;
         }
 
-- 
2.54.0

