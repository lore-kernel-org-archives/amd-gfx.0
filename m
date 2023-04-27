Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1782FC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 01:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F89410E04B;
	Thu, 27 Apr 2023 01:41:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0CB10E04B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 01:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLThR4+uTwMEizWmYyE0U/YVPUFpFos5kddlmrCBxTFOFA8L+8K+G5N+mxrw72nqS/zGPdd4CiN52qGuepzADQQepNQkkhazsrKjaTc+6/3uBWYdPPRdDPKd3XCesJXD1rEHhJELZjSPeySkxHn+mNs7mWT6jkju00c4vRIot1uC5Nu3oo8ZWkPwhLFgqPQUcSdmx6DiuU9yiDVCSRyzWXcEhbXrl8sgQwoZDGQaB7tIxen1HPbIE6UNWxXa28ml3a6T5jpYUC15QJNMbA68sNhUDYZlZZ10R+tDBAjt/vCRuleTNfS7EG8lT/AC4OPwS0es/HETQzohmZidwkYnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRkOFaqdOZHF9JBOjea7fgCHJtmu+UpTc4goYp0XYU8=;
 b=eGKE2GrAhNCe3vsOmyKD6L7FOIh2jw9V4P5qvkIrYYGkXv4QxvsWeSkGHpVkN/IO3LQt8ofTek+YqC3fExMCkLAzSRimLksXqBx5LRelvLEB1+Br+SXbw8K/OdWFktV8cpxK/eEwYDqjtbVgaN4xmPIck2v6ED4PkrHtHUzAwu4gFjWjHvr/Uibxl7HuS5yMxufXbhxIBqv1S3HygYY9Y/bloXiR0YYvPEWqejNgEnNkr5YXcoLBkjH/l3Q8kaLXbpFGX6FtwAIjubfzsKnvXOJPVslkTdmKYyel6sEbXuwSDUXiJMyIqfhhOiMaPHWXo8OJ4xBc8rsYwSTUTFQApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRkOFaqdOZHF9JBOjea7fgCHJtmu+UpTc4goYp0XYU8=;
 b=llk4jWBxe1uQT1/UiYgN/SvB4EwPZGK5pAVyyZgsNGj6+XOcGjEzaprs3qQwqE/0BZSET1UZQitL/kDm1uiNgEcBb99xnIQ7RIe+Dd7Zwm150C8u2R8Hh/H4aDkOMmVCzjmnROOyqc0Wa4YvLUNdv5BC8MkRUNvM0xPdzUFF1VY=
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 01:40:55 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::53) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 01:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 01:40:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 26 Apr 2023 20:40:50 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>, <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop redudant sched job cleanup when cs is aborted
Date: Thu, 27 Apr 2023 09:40:30 +0800
Message-ID: <20230427014030.754869-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: e15d1b64-249d-420f-daf1-08db46c07143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADB4xJg+5m+0mS7G8z4pczjb40Nzln8+9KiNmY/1PP1ZGnLIkTrInodF8VShrp253pLnZiHcc++mOtfnQSbHxWCg/FPKpAJPvP6mUBTYpFl13QVVfZslXSaQ4R/BtjD/AcCwZthVK6TX0uAt/n9izX7xqkYY+LwnvM0i7/PC0oWbLWkaoAxo7ESx+MF33/fwdEr9xYQwa42swd8PgqxXEugkM/1RyugwS0Rzs4KHqKM/nnv0OTbxnlCGnBIkden4B8d6+b5XQqPYmoJ530XHTatlewKs45m3q+HqiMvzP9xzrIVcjxmZkmtT0ruuEffxc2TB0sHG4BgUWAQlbfQt2RttZtBMwtsYXwcegMS+6QqeJYQU9S+43kZVjmQ1j8Um5xJvkR+12jb4pNGTYXYtRzz5SjYoIbo1FP7f1vKOcWLsLmSXBymTZi/ekhwA4Dva9u2UjJ/KIjhnardDd7I7oj34POcZnfwj7vEdae4SRSU/gWVhLpFXwauiXWxTdGNklJ0bm+wFcUkmzeh7vO69hvsb3FeeAm1osv2jCUyvN3Gla/wXCTsZG3foqf60W6Mn7pX+VpLaPSndTDTXsx5TtBJLKabH8MO5z2jc5CfWDmHRXoIursKQB3f4heGuqpoTvwgvexwyX9SlQvcg2UoA2coT6dhRen00RWmus/c64a6ZU92lE17k9VJa3WghWMAq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(2616005)(41300700001)(1076003)(26005)(5660300002)(36860700001)(8676002)(8936002)(82740400003)(83380400001)(336012)(426003)(356005)(44832011)(47076005)(2906002)(6636002)(4326008)(316002)(70206006)(40460700003)(70586007)(186003)(36756003)(478600001)(86362001)(40480700001)(16526019)(110136005)(6666004)(966005)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 01:40:55.0525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15d1b64-249d-420f-daf1-08db46c07143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once command submission failed due to userptr invalidation in
amdgpu_cs_submit, legacy code will perform cleanup of scheduler
job. However, it's not needed at all, as f7d66fb2ea43 has integrated
job cleanup stuff into amdgpu_job_free. Otherwise, because of double
free, a NULL pointer dereference will occur in such scenario.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2457
Fixes: f7d66fb2ea43("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 08eced097bd8..2eb2c66843a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1276,7 +1276,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		r = drm_sched_job_add_dependency(&leader->base, fence);
 		if (r) {
 			dma_fence_put(fence);
-			goto error_cleanup;
+			return r;
 		}
 	}
 
@@ -1303,7 +1303,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_unlock;
+		mutex_unlock(&p->adev->notifier_lock);
+		return r;
 	}
 
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
@@ -1350,14 +1351,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
-
-error_unlock:
-	mutex_unlock(&p->adev->notifier_lock);
-
-error_cleanup:
-	for (i = 0; i < p->gang_size; ++i)
-		drm_sched_job_cleanup(&p->jobs[i]->base);
-	return r;
 }
 
 /* Cleanup the parser structure */
-- 
2.25.1

