Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64457C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Nov 2022 05:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAD610E18E;
	Sun, 27 Nov 2022 05:39:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B90110E18E
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Nov 2022 05:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKQHobtxCROmUY1u/gjY9P/Ix+bfa/XJbhSzsNmvJrtP98CbGWDNEz67kd0zaA8c1O3warhKba+AKocLB0XJUSuFgDt5AK9EiFfyrCscjHWpa8Z4E/jlni3JqY7ApJGJjuxWHR7SIe9pWI8dHi/HXr59VP7Mk+76vOP8ILyxWl3KWL5S19Gp9FYQ+Sxj3TeEHF3x0y9Tn3IqscheUlFuj5f+wIw7klBVazlhc0s/THPs5m9V3XXbiNZYaF42hgWgRL8naQHP2gD6AUoZehRXLrMtTqDQO69AXTu6opATXJLi2jM13oKVdoRt7jRB7Lx1N+pprEjAIw89TRJ3jBG/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0MjGhse2j8dg0FTh5Fr6z7rBqnUGq8/WCMNtVqH1m0=;
 b=SKMtOinp8DtARc8/jLE7CLwtiejvT0nzR+veSeDvSsP6hrGCs9NzTWO5LVwUQHuzNRJA7D7UeU3WD1PKxRdfOK4zUPZeOY2f1KnZghry/wwemvJPviQBwzwHyDdGzZ2tqqWU+qrn1Pi5G2uIATJiNv41nUBADjGWoQ6prLWxK7lpBZar1wqjpWkzRg4564nSl1i4NeNqhJicUUT6H9Kme8+dRleTbJu2qmM9GCTkdW42eol1r4+Yp2BVHKNBaG+U/zO6ddIfEdiuRNHppF+qwUXtXXuSrdl3p4NBkQ27svKDul7FlJWGBbwWnU9us+W6p5zD44M/eOSG0mnEAjks7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0MjGhse2j8dg0FTh5Fr6z7rBqnUGq8/WCMNtVqH1m0=;
 b=OQOhsNkVZPui+pzpfIfzGJDXWhI4vZOGg2Rs4s4aL0AfD9jPzjRxznkq2OhxMKgaTqOqWA1dwgA0CJRufAAnePeev6xK8bluKh/vuqarFJEOUwrtpuxD3aLQWyPoN+2F3C5ynl2zzwM4fVRrnVscRdb3+hKK3tsTJ8dZ8D6ybuI=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Sun, 27 Nov
 2022 05:39:41 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::6) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22 via Frontend
 Transport; Sun, 27 Nov 2022 05:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Sun, 27 Nov 2022 05:39:40 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 26 Nov
 2022 23:39:38 -0600
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: New method to check block continuous
Date: Sun, 27 Nov 2022 13:39:26 +0800
Message-ID: <20221127053926.119084-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EA:EE_|CO6PR12MB5490:EE_
X-MS-Office365-Filtering-Correlation-Id: bf589c9c-f42e-4c6a-8fe7-08dad039c79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0SqAs63/MP6LaTjcOx85oxZOpPVYZE71N3bEChMTQ7i5g5NvEj6aLYkdGKTzqx6YO+SM66nGQf6MbxPTMCdWLbvDRmLHaGYbbIlL01IYLqoesoF417vc604+QwuU4rnK1SjcDq7fYW1ypIC1iF7jcVfOq5NBNXR5VQ8O3kwKDcfRTAgPaCFSUCPDYzlfpgEOLXqnWvRYYEyd/wbORhT8Gjm///lNiEOV7EpcGUNjHhxMvX4FsXHuONSKFrrAvwQ9YJFq/OD9qD8QA/q4BDDLd5hXuS8W+hqFj6CCb85muzwNgExQyTjS4A3U83vjFBLp2ZM/7/P6/Qt8jFCvmfh7ZWHTvsRRDyoB8pDLFBhzYhETiwYlcDT3srYddXVQ5c4UrnGZPxdgn6JYTliv49wZRiDYFWqcos0D0xhxNJjelQ9izVwnxKR9Ap/rnXl8ZlOOUXe5lxSIi2H7yqUvDRiXbmLY2VJy1ey7A7+4CbLrCcx9IWIkbVKixAtpsdeGX4UDONdKjJNDnhbTKgZdXZhZkuqvcYMh5qc0ahfKx8puaav1EpMh2pwy3+SZ/hdsX+gthO/VU3/vn6muPWLeVnxF2Nsj/QOCgNhuyi4CiXHdie7g4SiqadttdxoeJaFmHtXRm8W/dIcKVQLEueBbCCu3ynehMWAj6qx8lv0E5/u9ds5MitDfHHwStc4yc3dj0IZTfbLJaLt+BIMEH7m1NQPWNrvdhh3ZrpQrOWj4tkEEdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(8676002)(4326008)(86362001)(83380400001)(41300700001)(40460700003)(70586007)(70206006)(47076005)(426003)(5660300002)(8936002)(82740400003)(54906003)(316002)(6916009)(36860700001)(356005)(81166007)(478600001)(26005)(7696005)(1076003)(40480700001)(2616005)(82310400005)(336012)(16526019)(186003)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2022 05:39:40.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf589c9c-f42e-4c6a-8fe7-08dad039c79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Blocks are not guarnteed to be in ascending order.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 21 ++++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 27159f1d112e..17175d284869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -59,22 +59,17 @@ amdgpu_vram_mgr_first_block(struct list_head *list)
 static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
 {
 	struct drm_buddy_block *block;
-	u64 start, size;
+	u64 start = LONG_MAX, end = 0, size = 0;
 
-	block = amdgpu_vram_mgr_first_block(head);
-	if (!block)
-		return false;
+	list_for_each_entry(block, head, link) {
+		u64 bstart = amdgpu_vram_mgr_block_start(block);
+		u64 bsize = amdgpu_vram_mgr_block_size(block);
 
-	while (head != block->link.next) {
-		start = amdgpu_vram_mgr_block_start(block);
-		size = amdgpu_vram_mgr_block_size(block);
-
-		block = list_entry(block->link.next, struct drm_buddy_block, link);
-		if (start + size != amdgpu_vram_mgr_block_start(block))
-			return false;
+		start = min(bstart, start);
+		end = max(bstart + bsize, end);
+		size += bsize;
 	}
-
-	return true;
+	return end == start + size;
 }
 
 
-- 
2.34.1

