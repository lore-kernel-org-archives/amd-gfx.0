Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4F1C6FD19
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 18:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9970510E31A;
	Fri, 10 Mar 2023 18:57:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D950310E31A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 18:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClQ3YkD/Q42wFAuEgi97fBN20CcnnOn06zLwGwod7DtkFa0/nDnbStGlJe0lwYUSFuOBd3XpV9cLLMdVMaEGYKDvSHW3Dws0IKAff6NBzpqD//SYpeWoGsFv90HL+ebPQmzgyv87nUIoFjBE99XFu/XKKtUnteb7k9xf9WWb5TYJXZiojaO6KHcdiByh1rvNq08GtxbhwPTkLrIxP/hWyF3jsAj0QjwTiAxRPjOfEkaA1p2DK+jVeUmOYcYdL+ys9cm2XPwDWnS6fx0JidTL1kk+sdLAi9SqXptJ9plkRChxvHthSqvkPF38soKr0TY4n3E2d5Sle08kTW7KNqrHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WTMgVN9vWhp1tjRKKjghBSqDtQ6SkFSQy/8WT3T/y8=;
 b=RSfH1hTc3ZEbx5wuQvUu1691mVKceEzBDE8BfjLRZN1TGCSrEzagamxKgrUFxkBvjKjRp2qNMSichYcrOCsbTD9xYmMvfESoGlon/OsQ5JcaYHPFsbRe8XP/KUlRlHL0523rzvq0hCmpW8PTW6KQQoBC7XhMhO1qxywcU9WzCzRTDYst3xGFeprYlARNGvI7TzehXnid0V+uxPDWOCa8tvgdavIwWzKi3LCQRK7H1j1jb+P0DFGyCz0GUoCstALPkZg5bJfPA4s2lGAn6V/2PJxaKmYpwTJaOx/vL90ZlJAxTzGoI1VB1+sJo5S7EtP6UvZfdu2cPf72srD96D2Wnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WTMgVN9vWhp1tjRKKjghBSqDtQ6SkFSQy/8WT3T/y8=;
 b=HR8HNrkEznhQpov3riiPLD5DGtIuiVgy+J4SucGeZwYwDj2hBq30EptOZ1tNXOzhdZPc+9WrvSgqio/y3hPD5t1VgL3kIfJsE3IaQTcDki9uMjJEq1Vce/0Jy5vKjVAN52//9uktCGyLnSkC8KXd6EvKPjI61onq3bDJe+GCrP4=
Received: from DS7PR03CA0311.namprd03.prod.outlook.com (2603:10b6:8:2b::23) by
 IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:57:25 +0000
Received: from DS1PEPF0000E643.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::3e) by DS7PR03CA0311.outlook.office365.com
 (2603:10b6:8:2b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 18:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E643.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 18:57:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 12:57:24 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:57:23 -0800
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 12:57:18 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix warnings in kfd_migrate.c
Date: Fri, 10 Mar 2023 12:57:02 -0600
Message-ID: <20230310185702.1150794-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E643:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c989540-1883-489e-ab9c-08db21994962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2Bxy2ctv+RSidA2tYPFnJ6SxnmubLnVIy2EQlHvvy6ZgWvxcEjc7LsXk+3ZuEAvIRo3GjVwFS0uPIbWUyh3+5Rps5HjFcLs9ItpnvEYWISPeM7NmijM6GstWoRLNSswLpgtF5S714fric8OMjS9DIsXxumgytoDyatcw34TrW0aJMgg+dCmGReq2Xj0UiZnMaYqYWYOCAHkCccPIJbfIW4IhopsCVYoLBs3ldH3a/hSUjKYhSZvI3Xpz9FkUYILdl9ZB8mWUOERMJCz3H5Ozu2sf2yKjO/iRvNihTd95MaGv4FKWYUXym2uYr9AO59nquD+/Ay1rn3Wx4LItrMNQUe+O2hauOqwQ4rocfLgWPxaXZSkHWwXfdj93ww2HGewC0otBe7kBOkEeLatn3pJCWSQUecuhXlKfuQCLB0cZ7E5XsPYOj+m6Hdky0olCJMbJZlQUG3tsqPRtaoytuLYQJoTj3kA5uZjehciQPCqrnYGIrrp2IBjv4WuZauDD3q4Xg7qYayM+2Tsc6YpyUdZlvB57Cj2RD8Plphtu++5zdYRpDtfdNNuMahK0TO8iLD6Ax6AI9s1yZ6HovQO72N9P6PT4z88BqZ8XfaIe5ynrjZVWKOnQOcLDyYstIfLBN5dUWZjzXH22wM7vFKabOGEh96bGtxLjC2UOQyb3LzWE3vQWGdeDAdn6D6Ip7YlWK05hkTvuxK6f1Bm/CKZh6f4i1NUUGTpCN11kbKdNtzZr6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(336012)(47076005)(426003)(83380400001)(54906003)(40460700003)(36756003)(356005)(81166007)(86362001)(40480700001)(36860700001)(1076003)(26005)(82310400005)(6666004)(186003)(2616005)(82740400003)(316002)(5660300002)(478600001)(4326008)(41300700001)(6916009)(2906002)(8936002)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 18:57:24.7191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c989540-1883-489e-ab9c-08db21994962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E643.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
Cc: alexander.deucher@amd.com, Xiaogang Chen <Xiaogang.Chen@amd.com>,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c: In function ‘svm_migrate_copy_to_vram’:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:393:1: warning: label ‘out’ defined but not used [-Wunused-label]
  393 | out:
      | ^~~
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:525:29: note: format string is defined here
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_migrate.c:40:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long int’ [-Wformat=]
   40 | #define dev_fmt(fmt) "kfd_migrate: " fmt
  525 |   dev_dbg(adev->dev, "fail %d to alloc vram\n", r);

Fixes: b0b7d79469d9 ("drm/amdkfd: Get prange->offset after svm_range_vram_node_new")
Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 734b4eeb0f3e..6a7dd6574646 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -390,7 +390,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		migrate->dst[i + 3] = 0;
 	}
 #endif
-out:
+
 	return r;
 }
 
@@ -522,7 +522,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 	r = svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
+		dev_dbg(adev->dev, "fail %ld to alloc vram\n", r);
 		return r;
 	}
 	ttm_res_offset = prange->offset << PAGE_SHIFT;
-- 
2.25.1

