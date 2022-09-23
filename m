Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA7C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 09:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EC910E7D7;
	Fri, 23 Sep 2022 09:21:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2075.outbound.protection.outlook.com [40.107.212.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF11310E7D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 09:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liJ2+KIKZ3zyjNqnK0yHxF9TkCQjDO29PS91YvX0wvt9fT4qBN3Wng/EO1KqLUPPIVMTgYAr2uifxa3695RMMKKVBZ6KklTLjr3Kniocbqmq3SHmqPa1iG3DjOJABS68MN9opFye7G6HmbNvUFBpSCSr5xp/7aew/Hlv2ztd1BUpsIpmFrPjXdSK62TABlqsYPJB4smzSnl+0k5CYB8KdwXny5/nY5NYPzr/3/X3ZuXeQZnRW2HaiRU8kwZg4A0b+YHiJqfl8dsFe7Hr+sU04ABh8FE1sIYmJxN9IakipS7yAKVFVAAJlA07OOuPa7aRY2TI7Mrjwv+veqQBraVPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kSuQ/mjJaTTIfdgFWFZi1A9X123QCepLIAHNQvhklA=;
 b=DFFAfb3sPhYk+s/wyQRMl7OFHKnzodRmjagjLy6cGIxHWGpsOsvHsd84GYsiyk/wEW6LrkAMU35oF8kZMD7H6dtj79dsfnNcxGqkxp3bF1M+46vPt15cImpVb2dd3SHhNOotm+p9ZTJm3zibmdwLwhhVZLvy91vXPZtUvIc83U+du889mRPZsNCVnlztMO1YxX4wy9VPBuzmQ78jTCIcb17rJwGdeQ+36ZumWPetaQ2f1tllmW16vAbkRE/vwXvu27CTNpjKpQJAXjJay91V8UzclcNJm8a6vJ0CdBrK+sJ4aXHvi67qw6ygcOsIW6lzeXAEb4TzyiYHz4ZLx+csQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kSuQ/mjJaTTIfdgFWFZi1A9X123QCepLIAHNQvhklA=;
 b=w7F1gFwBUwllhjsuCp9XbxJygRMzZ71dFsJ3Zi5ttoHeaueCJ0IZ/Gx3Orbj10BcLGGLv/IGYCnEWIFR0++0RhKHb4FAVnZr+Z6J3dTHs3QorT2BlzAso7D4MmH5Hi9mZkUYP9QUCNq0/xwShSVv3YPIua763pY20PpI6J+hXXA=
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 23 Sep
 2022 09:21:30 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::39) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Fri, 23 Sep 2022 09:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 09:21:29 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 04:21:26 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add page retirement handling for CPU RAS
Date: Fri, 23 Sep 2022 17:21:12 +0800
Message-ID: <20220923092112.14141-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220923092112.14141-1-tao.zhou1@amd.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: b44a2059-17d6-4149-8142-08da9d44ff9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cp2LAGFIzNj8nswDogY6dByP5QfdAPOXMG6cBIZGarYBW8/ERYYi8QXVfo59GP0R85qVMK1iKJflsU/ZoWIsv6wB2xCy9RECz5gUhSywi40RMyc+HeFIuHHqfQ7Sdnb4tx1HXRZ78W+RrJpXgsr0VmpS8OYCAr4HS8X12RpIjE7wpAIpFdNyYgoXSubRKZ35cGkt7KiwuOtrs09zYVVKUZz/DPQ5t9EhF2166MKCTC6Z6YCzE7LlJfL+pG5YuPWqLj5XtxJeUybDiyLtPj/V68b+McKC7NB53/WAiKYYgo9YoFCkxyDMqeBy+m8/r0K5xWaSkPY/6KSyw4g1aefkBVo6b7VRBMzKk0NSGQLGxw9HLkMjqkzqy9aWw9CuvYNISdFno0XJN9KMwcSFxqW2KHvUGSfy8pg3tOX/GK/o0GJotI2gCDvivNtz02dg7tJIMBrwWt3BgPFoJlF/DzsCISQSMnseDGvnzlkfw3/NJwcZztslj0CarjVcESjxZnXRPwYkj5EpR47v05T5J9vxCVgMAIqAb6Z5bAfG9+M/k/rf3W0ZCIkw4nLfHE5J9wAoVQE3gL5+aw5z7uiF0n/YS1Gq3hwBDDwAuNoDBZGXu+zYnVrmqunnlVdkpk1NTKLgGv196BSSS0beWDHbMFsY+Yyb9+6gLJ0Ovash2nmRXfiOlDdygVksseFIOtRaxzX/34bxvUQ3L9BawLxITPeb6khLAhRqQCYUHcpd+6gvju+Vmsr15b0FB1EjnUcUpYi3KCbZZ/ser0BRrk0dBL1ALk/qvjEJ1fkc8uBxkRUqfm68NIdRniHX3/4Y66gHPnNX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(426003)(4326008)(47076005)(7696005)(16526019)(1076003)(40460700003)(186003)(26005)(70206006)(6636002)(70586007)(41300700001)(36756003)(2616005)(40480700001)(5660300002)(4744005)(86362001)(82310400005)(6666004)(2906002)(81166007)(356005)(478600001)(336012)(316002)(110136005)(82740400003)(8936002)(8676002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 09:21:29.5202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a2059-17d6-4149-8142-08da9d44ff9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do RAS page retirement in poison consumption handler unconditional.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c7b1a2dfde13..9e98f3866edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -756,11 +756,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
 {
 	struct ras_err_data err_data = {0, 0, 0, NULL};
 
-	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, reset);
-	else if (reset)
-		amdgpu_amdkfd_gpu_reset(adev);
+	amdgpu_umc_poison_handler(adev, &err_data, reset);
 }
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
-- 
2.35.1

