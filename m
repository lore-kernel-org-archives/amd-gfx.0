Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD1C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F81410E29C;
	Fri, 28 Aug 2026 09:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKreEfX5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69BB10E29C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWutmxmd/wV9OCBf6akZgA1Tib+WXZQOVx2I2FCg+xueRtfQBOm70sQ7oVwXtRvLUkiwm2mRVbHCzVoCpg+eWmxZ0u+QuujjPGJY0kV8k2r/PDCsXgRHbRpGsR53lkEc27mqvY3fQrCmE/HO97ELNcbLA1+S+FC80whgUcaaCeYRst0GymCsi/rg8VJ2xtWdliKVgdM6NrjIPZnDw2DUySuSJ4yAq+ZIA1jkslmtbZIKb0UgkwxTCk77kxvx5MbhDmuw+t7EtWYJ2a/4K+QpGS42Z/DMttaJLnifJdov46A2b0XRmZY55Mtyk+Kd5ce4UF7vxXSIOt8L4xfHJcZrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN4p3v7xzGQ9qbwtIuK6TxNT3W69vYsrjaS7+CTNgGY=;
 b=sj4Lb4naDF/F75voWOYdqT71ZkiFmhH7YTcvD9sv0hb9nN0ATjOzOHnNbvIHUnuudu7LVV10Uwh4fS336vZv5YMDewgV67OmALH2xxFo2IKwLHFaohqIBVk+7CITDwmWdU5aMiXVOWlXBVurDVD3g3YH1yuJ525nWYy68l+KyUxwKnLnhV4+8LYGZTRg6OqTqc3rr3zAqjazSQLuCfM1Gr4bTO8hasoDtswENgpkXIEe6ShcZr6VCZjjM99dWnHxcxdRVW3TLpRFFdN4SNB1SvPXqiH7dCajyS2M25DWzGY112zvD2aenJzV+zavls4f9SWc+7HkyA8h05YsIb3NHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN4p3v7xzGQ9qbwtIuK6TxNT3W69vYsrjaS7+CTNgGY=;
 b=BKreEfX5Snk/uFpCLq6hy7iRcVVTgknodAROJoPxwqkYNMfOQpFhdIxOaeIyOMQgb2WZWKo2CgBcpMKn91/x65SEob1/rdHo72AGOWpXA4dAM5aDDJn9/+nmWK6xWmXB8uTLGgIFQXJxQMI9F6Yank+tFUTmveN50iK1enjRiIY=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:53:50 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::8e) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Fri, 28
 Aug 2026 09:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:49 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:47 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: implement asynchronous userq destruction
 routine
Date: Fri, 28 Aug 2026 17:53:44 +0800
Message-ID: <20260828095349.9797-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 84950661-0ccf-4acd-d4e0-08df04ea42ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aOAfFII7TGDqKkeuCCD+4IgP8AssUFbDZMASg5fsRS0OT4Zqx0bTsr8a9irpamrgL/nsNFGTayAzk5fb8LGbCm8lgVWsY42TRdz1cIqBhrhjjNoqR+tXeRRx0NKCi0iqUxPpUrxfUU4IX8QC/Mtx1ppLqt7UkxWsd3pbsKS+jije8oRUAfYV8dNtHOg8vuoXc4GnQQpFw8AvpnFk1zywQR+ETi6bZv/G6SG2aT/yay6/BjppkckPf/47A6sf/D2gesU4Syvle9nmk02kbePUe/r8Ct/Ftzb38mZnh9mJYSd7p6hB2w8uXzfJOPZFtNyzJ8jH054UkjDP6Mo6reKFoGIcFt4Rbv3pz+5ruuOfnby2LgzbnfJ/69zI9S6MREmB5RkQpyrfjyaXqs499Y64CY8JPVlkOIoJbX/rTYGmnrRW2CMAfpQcUhnkCnuEhHrbblVhY0UGcOiy0Zvg69R9RlDINMXPOlicPOMiVGxkg0B3I+0VOiKU6wjeG0Ijz53xng5W0ao5jjBHZAU/xU89KrLwj+AzRway0iems7vED7y9u+kX7ChKy2ZoXfPAFQwrOtMwXIxwK01N+oZZakknbmxES/l8LamZ9WwDSTF8/DYFGU3uaaL+niiwZqC2Zxjf7c6uU2cgq5yGVKLSqZNtht8+pvYbysGng5llFYhEUW4fDIgfAsH7WxZEWwOt8PGchXcxFnNJgoVor3izrmm3oQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQvL04F/wxAo5L4XjUMv9/67OEWaZXNc8TixaAoBMOBgA5JO4/PVyzUc/rTGHPpcNGSVq4Xo8spV1MR1+Kp5ftm5fMANP1FO7N08CDvbrkNNf2fNPAKShorA8h0x66yomjQSr5mbtvd9nlJEPX8PdjjIC3bOGePGIcCrCl5v0ADRGCjTuXjigh5zgTRWzVUypucX6VZoPYCHsJhFfZWNucOIULSe2UjQfcIkZTUaqdKA8l5979FTp+fj1SgXKyMRcJAPiGtDHMC0K9HWvYv42vxm/ylvrB8V/8+0lSja+S8UfWGoZ242nTovAcfSyq99WcuFSLTe2p2uYfxe5G5/yoHuSXYCK331H9bN4gv5/LK3tPUfJ6wC+ZrKuQtvzn8XoWPn0/JzwYz4nRKT+K7Koq/PgE8PbgjpLw/fGKbxKzzrglBcnSxvLqNGwEtdj6Nx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:49.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84950661-0ccf-4acd-d4e0-08df04ea42ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

The last kref of a user queue may be released
from a context where can not sleep or
require an alrady hold lock(reset_domain->sem, reset_mutext, etc)
in the same context.

This commit helps resovle these issues by refactoring
the user queue destruction function to a deferred
work item, so it does not conflict with the caller context.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  7 +++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index f398986a61a5..9fe20cb9af58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -596,11 +596,11 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	return r;
 }
 
-static void amdgpu_userq_kref_destroy(struct kref *kref)
+static void amdgpu_userq_destroy_worker(struct work_struct *work)
 {
 	int r;
 	struct amdgpu_usermode_queue *queue =
-		container_of(kref, struct amdgpu_usermode_queue, refcount);
+		container_of(work, struct amdgpu_usermode_queue, destroy_work);
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 
 	r = amdgpu_userq_destroy(uq_mgr, queue);
@@ -610,6 +610,14 @@ static void amdgpu_userq_kref_destroy(struct kref *kref)
 	amdgpu_userq_mgr_dec_refs(uq_mgr);
 }
 
+static void amdgpu_userq_kref_release(struct kref *kref)
+{
+	struct amdgpu_usermode_queue *queue =
+		container_of(kref, struct amdgpu_usermode_queue, refcount);
+
+	WARN_ON_ONCE(!queue_work(system_unbound_wq, &queue->destroy_work));
+}
+
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid)
 {
 	struct amdgpu_usermode_queue *queue;
@@ -656,7 +664,7 @@ amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
-		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
+		kref_put(&queue->refcount, amdgpu_userq_kref_release);
 }
 
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
@@ -724,6 +732,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	amdgpu_userq_mgr_inc_refs(uq_mgr);
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
+	INIT_WORK(&queue->destroy_work, amdgpu_userq_destroy_worker);
 
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index a13d8d4dd5c7..ecc450be7eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -87,6 +87,13 @@ struct amdgpu_usermode_queue {
 	 * Delayed work which runs when userq_fences time out.
 	 */
 	struct delayed_work	hang_detect_work;
+
+	/**
+	 * @destroy_work:
+	 *
+	 * Work struct used to destroy the queue when kref == 0
+	 */
+	struct work_struct	destroy_work;
 	struct kref		refcount;
 
 	union {
-- 
2.53.0

