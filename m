Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7690ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 12:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E9710E03C;
	Wed, 14 Sep 2022 12:57:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADD010E08E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 12:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAnkQlKYCusWu5vN3folkT8uW72S7ArQ49iv/dYunaIF5Adhcsrr3cl6qBiDE2mgERbqSCNsDh22ynFOFgdjfqs1TrxAAWywxhLQf+/pH82/JO4Sm/V//e9mZmIr0dGmAhokDxhmgTelnLJIwnCil7tLiMJYIIuHgf0brDGmNXkf/URXI3uWe1abkGp8uoYF6a8uGvChpkbTyg14AeLNZdiW0wpWpqGn5p5vTa8bom96tw47RHfH3rwVm65Y6xksaVON4tSKOz8vemZu28toI+82xv/a+yLq8zLPwnHbVMB294dUKRZsY0dR3l4FNIRHd+/dqbkmwIju/4j3TTPQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJdVl1pZdxo1prndOhIG6vPFcbaRqkpcU+giaBC4Bs=;
 b=KR7oZdpQlrMQ1UgtbJhCYubzj66EuXSOPcZov8W4WZcfGvQ8hVoOxaxNNs8K4DqYF93blO3RpO0qfWY/WHQyr6k0urhDFvLSUuXmjKjzYi7sozAscFyflous1/11GDu7k6G6wLkVE6MvOJZyBvJ0l59tyFaqbaDNvyq/2N601AWGlsOitr6pO/dKAy0diYXyUWnwRUGODvmsZAuAb+fLTGIGqhc60tsGmr9kLO0ZyW7czPBoL2pec7ZXhiExKqy56Ypm9b6R+30GFoFmnUm/gZy01Pa6+SAJd24nxhCLWGJeOTTOSafYaK0M+e6BoOvACyPnr5kJC7q2pzSB3USN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJdVl1pZdxo1prndOhIG6vPFcbaRqkpcU+giaBC4Bs=;
 b=Mt2byXUBYdhkilb7xlo3FyhhBkMQsR1vyF1W52Ij0ddGFCVXtyBdkn6I6+aOSTV0WpqkLIWBseaneg7Owy7fcit4w8hMhz2oKBwNcMG0tno2pJaFBI9AJ8/udgaEYbWbLTZWEEWMMNPbsAVK0R62RlUbdYcAXmMsahctK/i/rbI=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 12:57:44 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::54) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.6 via Frontend
 Transport; Wed, 14 Sep 2022 12:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 12:57:43 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 07:57:39 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <arunpravin.paneerselvam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the lpfn checking condition in drm buddy
Date: Wed, 14 Sep 2022 20:53:31 +0800
Message-ID: <20220914125331.2467162-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fc031b-e6d5-4386-740b-08da9650b6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqmJFQO8ISD4E3Y3pNSxBfs4dFWPusklJKS888hzCOfAqbmHxTVxG/2hnB9Yx70wxf3tKHL6LUa0nviu4uRrtu8mZ9k1vOwNe6q9PJsp8YTXwYV5JeRjB5PGBashXX62jMyn9++HE3Mt26nEOufh1V67qqFFm3/PP3ZEuogCB0D7dqUd67PhrHKvYWNGB0hOrFVmFP2GQfZIt7hoRZGi5lXdvMNFWlQSHZjm+hiBV7M/0iwW0eDSlz6S9CgyTDKrNpyT9OAcmFuGedeVb/PQ+LMGX+kAcoH1QxkrYVO4zXJuaDGp6B4U3YlDBzxwmfR/WByScGzVF+H+sJBrw+cxNxtBoHOh2ya+LNTXAGBo3hzUl1LYiRkBvfJt6nUxxEKdwpN5z9p/zCxDHhpm/UnOOemuIrRQF0AZJbxrflyOzNP4wFa/WOvqEXxf5uDuGwud7wYqqK/Sidqd4Psk8FB9JkWDCDbTVMYJBWOnD/+IxAiLBB83WBh3stft0C2JIJJe19OL92d7EbY4WfxdelNVqkyoXlVjYXtr9dnmp8kSfWh+o/AanG2Ng7Qpq8zuvUf2ABHbgS3mhOI6WNzSqtWXQZVJulUhPgqIFCqzPzYlzAQ2yBdSlPDDEJTDiLwALJ1y67pUrSQm6Fi/9u6CgRxKOPvZ3MlrtqE2W0VPLe8+3WM5TL1lvIfb4OOEyDzTkCjrKm7RKZu7OUMoeXM7aljZpzxC3QIvLosa/iRNPKr5PYl8FaK9uuSYeTkssn+XpCf9zOXmK0oLqjJEPRO1Fm6oGelCx9aur/LAdG9z5qBBQSb13e6KRRTayWBp2NXXD9oS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(66574015)(8676002)(2906002)(356005)(82310400005)(16526019)(81166007)(40480700001)(86362001)(41300700001)(316002)(1076003)(186003)(4744005)(47076005)(8936002)(110136005)(6636002)(2616005)(70586007)(26005)(336012)(5660300002)(426003)(82740400003)(54906003)(83380400001)(478600001)(36756003)(36860700001)(7696005)(4326008)(40460700003)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 12:57:43.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fc031b-e6d5-4386-740b-08da9650b6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: alexander.deucher@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Because the value of man->size is changed during suspend/resume process,
use mgr->mm.size instead of man->size here for lpfn checking.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 48e3dc28b156..0b598b510bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -441,7 +441,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place->flags & TTM_PL_FLAG_TOPDOWN)
 		vres->flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (fpfn || lpfn != man->size)
+	if (fpfn || lpfn != mgr->mm.size)
 		/* Allocate blocks in desired range */
 		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
 
-- 
2.25.1

