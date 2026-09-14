Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D0C88E64
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 02:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFAC10E04B;
	Mon, 14 Sep 2026 02:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="px2cKI8U";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37AA10E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 02:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApF4scm/ppiMJ+VGtaN3fHNpvWNq4ldhCy1NxBnB47adBqjkYSn4XQuZgRrpKB081sP64YsBPogBnPRi+JP4dxJtHZ/GlV/44/mBGfLRO1O0ADB0/0ZBhrkFFaiPZthC3DUDmqfVfvqRP54dBOaFw2xUoR+V8EZk3uLmp0qONQN/E0HCyynSM1wmV7Gp+JPpTquv667HK3uy0JfNbd8Dl3I/bpEu+pf+z9D/Qs5KshPVPH8eqfhDKxdljZhq/CYaGfIqHyQvYfGkcApTU/O3RRenxOc2QOY0GebR+WXfh7DCylUAo1iWOUqdVOmISB2Ik7P0Rs2F6IdEJN8GgqPiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+N6DT/fLgD5WUVfr1TIWyjzsY0FR3g13PF7nTkM5C8=;
 b=GS6MoQ9PC0lYEkT0xtvVNIwfe8gbKb+G5ew/tuzI6lupkCNo6lYGMNnEYL0TkIMfKSFWrH7d9VVNJrzHYqz0ZxyVvRHgD/H6h2otBW748wNCRt+1rHlKLteSSns0WHV/8VNdDziFetZnSrNOXS9dmLMHkGCFh5n3fQZp2cdjDbBAjt8bD0qbIACBX9wbNNGZziv9DCjx5GBVG6CBII3jxn7KKm52Nm3Roe+ElPWAPqhUoPZ0G6i9AbKObLLJQGVTSJe00Va8mtXsrAbnCVm5mICnARNH4v5CY9FtNOYH1TNQ4hUFzi2FEbBMdgdwZnLX9aZzk8RDVmB8ndljYmBkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+N6DT/fLgD5WUVfr1TIWyjzsY0FR3g13PF7nTkM5C8=;
 b=px2cKI8UFt6wnQatiY0W5MYyiMr/wF06DlUBiYvIqHrn+BuRxHAfoLii1AXocnUamzdNZn5anUdgCDOw1Xng2l/Tiuop+5MGdgfyrKNmEf+NKNr6E/nw/Cv+D+lJnS/l48WXg72UKhsWU10e36QLJASf1ivJG8soh7RfmhwX1c4=
Received: from SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 02:41:39 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::96) by SJ0PR13CA0130.outlook.office365.com
 (2603:10b6:a03:2c6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 02:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 02:41:39 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 13 Sep 2026 21:41:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix sched entity leak in ttm buffer entity
 init
Date: Mon, 14 Sep 2026 10:41:24 +0800
Message-ID: <20260914024125.443258-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d64efd-9d45-4bd3-235f-08df1209b42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZgHYCCcIOfSgNiD6ltCqxPix/c+2eHLdldtZy97uN9vmE6oRakFzZc6fxly789llcoWwSH4eQ8HkkcWjn7+GVXovjPOMvACU3Bf8izDyX5jgOzZjn+9pSWF6s+XPy7ETuHWWwVzEfRxoa9WH/lsmGD7m3MSLVvVhWQWp7X3aY+CxnqwN7mEiVUyPwlOxvnnXLbS+cqM4zLQnN6UV4aEZNPKhZZgiM0cD4Y+IyubfwSYr9g2nAkwSFVtUvaon9QZHc+mCphxXZ/HeaOJlas+r7XU3300gL1CD21iUhKpnA971JSv2Y1avkXKWqriJbUuer88jnbDLRfbs7wRDfkNO+FtSbo1Pe6FapOVWOZWKbgSvaAzNSNpWzMVvbYCC97WY2Ctlp6DaJyBc0CSHp1uxVYfz52vbUnUP8dTN2xnvIYmLSx9WlWp8gT+rVjE2LHU84U+RsclVPOl0ryAU0Y2UlF68lFVDt97lEA37tnKCSGCJkzixiUfXfV0uXx5OcZF0Yo33hGpphX5fQn8hKVfm/CslfhJOqCZ6q+jpVx/WXMuPB4Ok5RCV3KNk8eCJWekIdbutErNMSHnOuRd/VwfNlPcgP6X4d9GiKe/mHtiMH0xG31o6sHvE6XvAHqV8GH9XVJ/tEb6R6lh8e/ErBeidDbCPH7Jm6ei4tfXAelGu2t2by3LXa3yGKGsr+I2kh+3A
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P60xymu3kID62QcJkMgFfWTq3xrY12Cmrq4cWyRGjH2KuLGvzb66j2wPtrsaMwNMkySJw9wEVRShM3V06pMqSdTGuaUFAPCQCzH70V/Hcmopm3aJv79PxgZ4rrr6PN1E/SwRvYkVAE4RTq9u7xtDHgQxahdvkWZRFfLzm8Sc0Hs+ADsuCwVTwwJ8HCfa2jVY3JXnrwpWfncPeM4fIPa5v9vE6Djd0lHeSARIGbMABUKpyZ82RJTXpeNfRxNa+PzEQJhci81vMG8opGwyBfnM0doQd6C7FXZ/olijn1xGVoMsHWZtInk+/r5Dib0uV1g/7dnVlfO6MMHtYDu+4699QDpvt8RnXTL0Qt/KQnyOLNq/ThcGTtjWymdUjr5ciqQ28Q3yt/pM9YH0a0DUsYSimOpwtkafguRmiR7Dy2tTWTBeR4S6+05nU3gc7B3J1BLn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 02:41:39.5512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d64efd-9d45-4bd3-235f-08df1209b42d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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

amdgpu_ttm_buffer_entity_init() checks num_gart_windows after
drm_sched_entity_init() has already attached the entity to a
scheduler run-queue. Returning -EINVAL from that check leaks the
entity.

Move the ARRAY_SIZE() check before any resources are acquired.

Fixes: 2c3725572561 ("drm/amdgpu: statically assign gart windows to ttm entities")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d620ec2937f..5465787f730a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2076,14 +2076,15 @@ static int amdgpu_ttm_buffer_entity_init(struct amdgpu_gtt_mgr *mgr,
 	int i, r, num_pages;
 	const u64 GTT_MAX_PAGES = (AMDGPU_GTT_MAX_TRANSFER_SIZE >> PAGE_SHIFT);
 
+	if (ARRAY_SIZE(entity->gart_window_offs) < num_gart_windows)
+		return -EINVAL;
+
 	r = drm_sched_entity_init(&entity->base, prio, scheds, num_schedulers, NULL);
 	if (r)
 		return r;
 
 	mutex_init(&entity->lock);
 
-	if (ARRAY_SIZE(entity->gart_window_offs) < num_gart_windows)
-		return -EINVAL;
 	if (num_gart_windows == 0)
 		return 0;
 
-- 
2.34.1

