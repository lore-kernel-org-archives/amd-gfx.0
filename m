Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DEC5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A01A10F3CF;
	Fri, 21 Aug 2026 19:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CUQeJTC/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011053.outbound.protection.outlook.com
 [40.93.194.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19E310F3CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utgey+5sEZul6ZEyQNTrKcnN87JKoVnK0lYt7WOq7umQZr/lMMBvw2rr0qeqfRQCTsKhN6E6bJorpm9Wyv23OGwKRKBZ9Nq7S61vSqISkviddp2F4SwCRv/mE85mcGWsoG7D6lgIRr6N0cR9vgWrVUDPb/xz6EleuAaL9cMOSLZzX7h+bRduQyEiOix+0ZeB5+EetEZSXukqxhECgu+TptTYX6+3BEH/2MvJc+k7Ur57uuQo5PXInFEvFkz5tJzAOUJq2EqCscZEQ5HjjlXHJPBSd6+CjNHkIjggCrnpYm/p//Qjx8CLd3AyPxjg6VBNmd6ecriMzXfXDOljCHyYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTlQEYjvHjuuknDNZS7n5JzSIrItd4XI/976oAuOZrM=;
 b=oh0tyKo8qsrVu5kWrb6Z43SmbZLRl3Y3lPectcMxqC1e/LgSV8gspFy5ZXAZYpmW5GTZTm6uuhP7I6HkND2q6/39xnRlbUv5aqmlQXRC+HAi9agijOY0iIwRbt9tgWcylhc5IfkgNNhC+W1x8IGCiVbVe5tlBp96Q0rUiiaOZfKq9cEeNTs76h+8skn+vKzpDDlgOVpmDD7KBzkchT6/X2QxrFD9RgDPXSvaGC2N5KR00Fw5NJD2umtDO3B+4PJRQZWI3uGkrNideMHsE7aqBocANjJ9IlH12WkXpxDtNH0AFVg+8nJq6aRqP+BlongxryLOk2vmzdXeDhiv+v2SCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTlQEYjvHjuuknDNZS7n5JzSIrItd4XI/976oAuOZrM=;
 b=CUQeJTC/Bk2642fBlreKbIDtAnv2rEVHZpvQQ3Yrn5tcc3SYU+pEQM8/uWrj6Zm/yE/K1fhJ2rfkuRCQtQsR3aJoxuUjL+Vf9GmBMTlc8q2AHEbSvT6WI89L/Lz3zJdSgAzsbqmbXyMfSERp74zM9DSSSAQuuR3lSI+n7BbRQf8=
Received: from CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::8)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:59 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::1f) by CH5P222CA0004.outlook.office365.com
 (2603:10b6:610:1ee::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 64/95] drm/amdgpu: fix NPA-RELEASE race in UALink exporter
 cleanup
Date: Fri, 21 Aug 2026 15:34:27 -0400
Message-ID: <20260821193458.808626-65-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: f138bfeb-66a2-4a94-6027-08deffbb6d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: espRY51wRSGadRrZEqROerr02bjHgqC2rjnbD6SZF/FJ5fKlmC8GBoBkS1CXm+PthXO86gSB1pMV4dCzr43FD66I0MFGBoAOJJf53izz8D78NDNCwyLZGWL5nnSIdjuCbpIE6CbBoYTgv2Anr7y0Ruv2liN+1F9e7P7DRRU/+E9F4pqPhTwjovJuk/cTR3wqpabaAUEl3ze8RAk+Yza5QreDOXSHP96offSXirQ9YicctXmpQVLUMinzRpQu6m5UG3VuAx/kjMZx42JxY4Qv00LrWM201BaQQS0NXd5vyIUI5pe8xyNUl46kicqQz1gDginWb3fY7wGxmp60uX93jPoR+X39PYY6dKAIbgDB68OeDJfvrhdg1PNMGUGpWyF/VMurlF4L1PuHotYnSthI+1QpoSRppu+ZyH83cG21CzfK15lIh/eYfVKQlKVn/VPLninb42pXMG5OsA5WC3GlU46MGB39llxt/s7T7556GRmnghrMQ0rzQ/Prm3m+36YZ8W8Onlp3e07Gd9Sor3u0TfQRFCT1GHjH+mZdnlkCUyyjAAY0WxwiC6Y6L1QRYSUyY30Fcg0yonEXCccmmHhMSHwxHnB8AwG4YRcAGzjrAihalp3tT0wLuHWo6FD7PCCsPNUYBTkFb4TaOrP6+yTucuDkKGjTuZ/Tir0pbAlCCB9M/Q75N1F8rd/5PzIhPx6tkws9rse7WqFKhmJwV5qDRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3dbiKoMIkZKgLULJHu58dy1b5db+WYPxb1AEsPifJK1C6fmVVRyGlh8IerHNOzoAs/0y6WP+rfRZOyblLX9qRSycNXu7lWBIouLbxZKaoi8etXt36mKloXcd29I6ma0xEDZ9bkl8SVAXhNV+8Jbf3LnaxG7x1hrsqpaR8nBFFp/qqmGO99voNU2Re8pqMMUSLIV0mCIcpK8gp5R3HnaueH7NJdNW1LQ/t0LNi2q1cqZyxXwjdXMrwfUxiUjieif8gpBHnAYE5N+MqKaCbTWd9527FRJ9Dfx5LdlhoP+VxZrSv9qrbK6t6hVkWfLNvfF4kyHMIrNCQeNGFx8rxhmPcpbZtepNlQ+6umWgQnVY9D4DgYL1tEJPbwFOe3bpF2Dt/FRwMg36m6qZz5vXqL8Jk+ewFUPjW5jl6WU0paAVaxB5Wb6ce+paTjTIJ9tqhCS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:58.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f138bfeb-66a2-4a94-6027-08deffbb6d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

Processing of NPA-RELEASE messages can run concurrently with
sending of NPA-REVOKEs to all the importers. This can lead to
a race condition where the interrupt handler can signal npa_done
as soon as npa_release_bitmap becomes empty even though the cleanup
worker was still sending NPA-REVOKEs to all the importers. This would
prevent the cleanup worker thread to wait for all NPA-RELEASE messages
to come before freeing the NPA addresses.
Fix this by setting the importer_bitmap for all importers before sending
any NPA-REVOKE messages.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index e2f1829ab844c..2d1d4eae5b242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2268,7 +2268,7 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	amdgpu_bo_unref(&bo);
 	exp_xa_node->bo = NULL;
 
-	/* Send NPA-REVOKE to all importers which have imported this memory */
+	/* Build the full npa_release_bitmap before sending any NPA-REVOKE. */
 	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
 				 AMDGPU_UALINK_ACCEL_MAX) {
 		imp_entry = &exp_xa_node->importer_entries[remote_acc_id];
@@ -2279,10 +2279,17 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 			continue;
 		}
 
+		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
+	}
+
+	/* Send NPA-REVOKE to all importers which have imported this memory.
+	 * On send failure clear the bit (no response will arrive).
+	 */
+	for_each_set_bit(remote_acc_id, exp_xa_node->importers_bitmap,
+				 AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: Sending NPA-REVOKE to remote:%u\n",
 			remote_acc_id);
-		set_bit(remote_acc_id, exp_xa_node->npa_release_bitmap);
 		r = amdgpu_ualink_send_npa_revoke_msg(adev, remote_acc_id, handle);
 		if (r) {
 			dev_err(adev->dev,
@@ -2292,7 +2299,8 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 		}
 	}
 
-	if (!bitmap_empty(exp_xa_node->importers_bitmap,
+	/* Wait for the NPA_RELEASE to come back from all importers */
+	if (!bitmap_empty(exp_xa_node->npa_release_bitmap,
 			AMDGPU_UALINK_ACCEL_MAX)) {
 		dev_dbg(adev->dev,
 			"EXP-CLEANUP: handle:%llx:%llx NPA-RELEASE bitmap: %*pbl\n",
-- 
2.55.0

