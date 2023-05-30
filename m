Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D76C77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 18:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C2A10E08A;
	Tue, 30 May 2023 18:49:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68B910E08A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 18:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTeVtfd84c7oYOnXCeJeOF+7Wx6A5+PUW01Zk9iYTtLRj32E4I8XsweKrxiyRKiOiMCzkGRXKFunUNjhzBmSISrsA1WAB9nX3ExUcK6DIXb15kCIy35v8YJn4QYFPFqAIVQsc8S0orimbb6ijjxAhpYI9mPmCh8Sl3esc3obUaztOOPmt5u6kC4hS9HYSpgMiB3ZHRA9gX/7xwybi5iPKf6X0zYmA3n5MZ3cBIrYfrPlmcS6fy0D2+kNeMFHqVK64CHFdsbaqxWl8eIgNaQwJbafiDaaUn4ZAEJIhWRaBzbf7Ys+okU+YGF01gVlS8pbIejs8CrehIonlO3YHaULgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZGmUaq09NChLlPz4HVUhovqJIMrmmj1VknhknlLne4=;
 b=FH+fH/NLQW2U5BfsPMPajntrICtdHcuiOI+nfeKp2A98TxD7h01qaiyfHDddB4aoFnwGSihjmf5k4Eat93bkWHMH0d95XxKP9dlT2+ifuOhMR6mJxXDJGaiVuPmx7nan5QhdExqZ1CjuNmHBVaHZUGWYP1fK0vsmhOfPU+QogKXddKcnoDqhTJLGr9N/fHRTE04yVhbr7938qsvCSXZszB07iPr+UOYzrrLjfjboN3uSnDEvZee6DiEKzuXtbRg+MrrAjWMq7Q4ZeD1Sx8YsAxvk46MuKG4dMLTfOJymqI8v1bDwHvCjYN5go4XNQdaR4GhEhgPhTTpzhMQ0e4LhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZGmUaq09NChLlPz4HVUhovqJIMrmmj1VknhknlLne4=;
 b=z+ORzTkeHEVXVUattBx7GnzroXnD5PUbGJYflwnU/kZ7Duq/tHbg3vhGylG3X6Hm9WqHWGDzGp7kKXSaRGFWf5hoKvsvWnlCH+z1IBjbWObg8BYI4by+K3bwG2rvvMocMZoJuqFB92AdEHtqKlUH58xMT3+cjh8umy2sVQndudk=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 18:49:35 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d1) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 18:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 18:49:34 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 13:49:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up kdoc 'ring' parameter in
 sdma_v6_0_ring_pad_ib
Date: Wed, 31 May 2023 00:18:46 +0530
Message-ID: <20230530184846.3108466-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a0e5b-15d2-49a7-a821-08db613e9cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3g0XsToniGqdqWjb68dD9rM+gaxcZzKZPcgUOXJyHys8borUQp4OQ5Mq9+DBOu21emLuJGSCr5Gir/WuZrnUrBqNM5JIEjpWgNO83OJ0XaOyg9QW6OB8lOJ+80VgcIisP1GOoYxTMaJdk3XPummG93q2h2ivO27wHszJYUNa04CVkCBi3ZRNojBnxkZjMArFXJZR/TMkVNCi4XEnpKzUDmze0RVShFJFlu3/hvPBWTptGrNIeneyEe9eo7ORSlFSBa/O6COKgboxF6biDRN7av0mKNSOw/NCBy53TNnFoOtMkFtR1o874c26zhiTpA7FNIpe/pAKsxA8HE2tUSeChcA9gjkgRhXXGCaW0UmH6W1eWZ16rag2gR8KKxKl4GvkDt5c6yP4BP6BeV8tLlVWuRAjLmh3gdaecbRt2lunzGlM4nqS40+yPLPWZoUcz5Lre2KMzLw+fvrxzddHLns04H4yrpBKuQquPTtoNxguPQAsXYT+9v5L28w4kZtLN+Nh/rNdDemlFIf1b/jK4/mlqIoyEe4gYL24HnIsuDE2WNPoPSJMNrzxxWkm8bQVD/hJXwsBberFnl2kkGC3H6E/t5TjNU4SZSt5v1BsJXAX5vBGEleyf5A6i6PLq45Uzn6b+sD9L8uG1zDfOy47NWs+GuvepCyrEswCgI2KzgORJU8urGifwa3cAFjI7p+4/i7yi0gEtFyE1zhRLg1AYP6qHho7NXZZlb2Bc4+Zv4XhEWqqjLX6QOkcxwei8wAgPri6FpHBZj+A1ENcnGu1DcPBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(186003)(1076003)(26005)(16526019)(7696005)(316002)(4744005)(6666004)(2906002)(36756003)(40480700001)(40460700003)(5660300002)(41300700001)(8676002)(44832011)(8936002)(478600001)(82740400003)(81166007)(356005)(36860700001)(336012)(54906003)(110136005)(426003)(4326008)(6636002)(82310400005)(86362001)(66574015)(47076005)(70586007)(2616005)(83380400001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 18:49:34.7848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a0e5b-15d2-49a7-a821-08db613e9cc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix this warning by adding 'ring' arguments to kdoc.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:1128: warning: Function parameter or member 'ring' not described in 'sdma_v6_0_ring_pad_ib'

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 967849c59ebe..3b03dda854fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1121,6 +1121,7 @@ static void sdma_v6_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 /**
  * sdma_v6_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
+ * @ring: amdgpu ring pointer
  *
  * Pad the IB with NOPs to a boundary multiple of 8.
  */
-- 
2.25.1

