Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4ADCD8CA8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 05:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5C910E80F;
	Tue, 16 Jun 2026 05:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BwSwh2Fe";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C87E10E80F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSWXNmNAkDK5TkEWrdFVQt5mYamTV5W+FjXCWrOPlM53McwE/iVnBOpeECcY7Z3+XpjPGuUM3LLYZWNB7NQf+bq+NSz50ppDE5KXhAgf+DyDyUq5Dr0+t5xMDBweIlzXUZ6HiZdvqmp5UcYM0qOIP1rsuP/m9IAKVL0sdcrZvw1l+VWAi0NfUNlfTZCUrTtLTXhfqKXBA20/lYGy3ySQHfgCSrsNNaOO1J7NlBX+woTcd40yohfq+ajuZ/uFJ4GGhgirMajikfz2t0/aZDj4HOIDDzP9QVHCS+3xwuAW0W5yzBAMl4zqVvLJ/m5pvokJp/cGcmV+JjXe3pY2VxaMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQlrCpCbZt7hYc5NovH2sBtyaj2KB5ol9iWJkxbAoKM=;
 b=HU/j5xP1ndDdMLq7YgB9WLfcuxA8EEzrlSxI6xXLrKdXMJcvyR69xMXtNAm0j6EhIQTWKIwqPecJWK/tihgy3JsjXHX31wNXJYChBWoVYX2Zx/oSJABUR0y+cm9/Sb+aMNo5VgmfVikoRejEiS5Fkf2ZHYO7zCb9iApst9IFDYVborKv8fiuZIplsuqFOFsMp/kr/Fic3fH7FMBv32belaMiz2PLUbpqtH5X7RBdFsJGlpbd1v4j/oAMdgbUhKaMFDMwU5dVBo/UYq32FwiBh8yoju2HpZVI9IBjgv4v6jBRJW8AboibClJbi9/0lcX8Tiiwu64jobmjCbyB8hMAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQlrCpCbZt7hYc5NovH2sBtyaj2KB5ol9iWJkxbAoKM=;
 b=BwSwh2Fe0Fvs2jdxkXjEQ0eGcL9doPaVSK1bLpHyOKx3PxlRjH/MJMaoWThkLzMcAtGjRzDb0vtO8rZUkHY91gyD4OHR/NdC6/BPCkN1lcNUZ5QS/sDUIZH+rgFeTlpR4nx2HNrN7B/WM+v9vgFDBM/pil7QwPWfcus2XMS3I3s=
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Tue, 16 Jun 2026 05:29:52 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::5d) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 05:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 05:29:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 00:29:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check xcp_id in release_sched
Date: Tue, 16 Jun 2026 10:59:34 +0530
Message-ID: <20260616052934.354425-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: d11b79d6-9c65-4703-6578-08decb684a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: n+MSqMJzwrlOaR1yANFY66vuMeWuM4DQlv1njLmnew3FNGtdEhbwHswg3qC8JQXap0Rq6IzB0GQ5RUyZLBnur+GLIlPanyHba7/DJe2YFqFMUgdEp1H8eNCZe6ExfyeTcGMJumG1ZiWsc3cw59vV7OEKV54IRu9zOJDZQkJrLm0aOsz1X4GDmqCRvmZnJfeT0QttVzXHlo3nR8zs7fdgiVi80DYKHia1eszpNeyYebDkSQEqaRgGNOZqV17wSl+n4aUCEA64kVE2091URGY2/JA28a+BLccy0kSQ7rgC+VgXD0TJfINonW9Y3WAY7J9b27QtiHcGnNFLDXdESbC9P57+5xnBND1mtoaA2PdHTmgRnkyFspNE/emDiYONTFtqXJUXch2h/TzYtkz4jAqpf02xK9Y+bM1UHQUhedZDbKGgbdIgQhxcfL0O45qyim8GUgW90r+i+5sbsTqPiIjVK9b9nMWBshAB+jXQUd1cGVJl74BmXGLO378ybgVi3YJgYL9KAT5hnLwQYFlzHTbUioB1xRV+w0L8ED94h2UTpdkYIX9kMpdP5YMbBU+34tfjWBn15hRd1wIsEvwoFhrdpTg5zI1lZFDgSiZGY/VZY3iTj7qIBYzsBWbAW2V/OTXrrbMpJ06frj36rfdxDNpX+e9uwd0MsElPUkk6xrHuB8Sy1cK3SEJiDoLJUC5sgMrPkNvIAdhyChdSe02ZWnY+SMZAs19uyRHcJJjCjB3JXdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SyT9TKFqRvisPE92zpVTs6CX6+e1hgdXR09NsgPS01PNuwF/GbtHze4auwXsiyj8dV+/FmQMzGe6aBTmgN2uxCEPBEgbfSvkGRovHCGOpmcXBKBy1RFfFACm5Y7+NHoABVEgBXuFJiQAPm2+YD0S8omkkGktaNxOgBnzcnCzcdhST2TyV/xGo/MurKAd0UG/wocr88nmOlKdmqOR4li18vUUZNDlziZAUFcb2jsASd92sqGf7U4qlHed9oq/mhtF0nDP0y2igJzMe8wiWkTdK6zUtb0Lw6LQR0iaXvrbUo0jQux6QhRaW0oyGgD4zD0V51bqukm/NPDbpJ8bkI1ma96uk7VtCfXloRgVHk7q8qLdsjtgpaKOK04IIBzNFSwFTDpPPHORMIYC8g9IEe6nSjOcR0vA82jAGnZJPP1k4CTtjo9XhgATdodFYbb0mHlf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 05:29:52.0571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11b79d6-9c65-4703-6578-08decb684a92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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

Avoid out-of-bounds xcp[] access, e.g. when xcp_id is
AMDGPU_XCP_NO_PARTITION.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 389f69c7d5c3..14cef0264c17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -475,7 +475,8 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 	sched = entity->entity.rq->sched;
 	if (drm_sched_wqueue_ready(sched)) {
 		ring = to_amdgpu_ring(entity->entity.rq->sched);
-		atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
+		if (ring->xcp_id < MAX_XCP)
+			atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
 	}
 }
 
-- 
2.49.0

