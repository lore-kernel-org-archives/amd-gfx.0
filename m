Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38750C47073
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 15:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8939010E12A;
	Fri, 29 Dec 2023 15:12:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3F110E12A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 15:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEuXn1aBn1QABKmjj0Lm5Uj3bcBMKSp+2GeibgmQMxHJx+2NLRhBpshfsjLK27iEXN2gJ3OqSQh1557dXsGHb1GXqrCxlz4nI2ayMwdBCp3gA57oEErxso/ju+aK3hwSbPAfhMXSjcvbf2XAezPfwUVgGp7JB9qO1CfrVoGo54jPAVVQRWdIopskLZTHNGyUj+YxhJTK1/KOgIhfcAngTNRzA9/qG6eJSYghCmhxJwWC32JdjzhgPiPsy6pjYuDekv5tSJFfmIIqDq8jeT1iT06zyA+Ww6eew/AOsKoqUPmeTSSsUI9FnRhas/i+dVZMJCZOgdb1eDI1WoTVHDZ1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBPSOqIagcgumieAjKpmDKxUwoyHndWrOqBWKbmItkc=;
 b=UGj8JrSL2xJ4mRb/TKlpzBp7yXSaHNXK66t7I+CccOQq4Xvgn7T2vOeo/sTIoTqtBUP9nRbBbw/4Ln5KvdrkQYLiSm4lk1Js4k1ix26anN0wz6jbdzLWygisBYD53Pztdrr4q3M2SHsoc1b3z/pkHvIObH3kZBxUiNRdnnKWbMstzT9dpW+SSgZuOQ2yTHteVZJ9huLFwfL3BWtoBXY97Xr5Jk9YXmDZqQRlHfsOPT0RG4uxOwGF/vPYbGlSH4Pdwkwk5BWGWhXQfXNclssrmGSWftIZam1tDToORnKuwFEYq7xA9u0lk5YllXuZEU6q92jSV9VLxz06X8eSx0FUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBPSOqIagcgumieAjKpmDKxUwoyHndWrOqBWKbmItkc=;
 b=y0VG0AeIeO9dFGs8ccaH97kQqXvLpk884hgPfRgWnyixnX0yhx2GjhufmjJQlDOpZgoY69lFL8LErBK3W1o2cOVOYEzKIuhlUb37Mb+qioi3/sAqd/iIUp77f4hs46ybtBRQ56IPqjRvoospD6iDjN3xcqZQ8yutMfItnp0g88U=
Received: from MW4PR03CA0101.namprd03.prod.outlook.com (2603:10b6:303:b7::16)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 15:12:44 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::ad) by MW4PR03CA0101.outlook.office365.com
 (2603:10b6:303:b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Fri, 29 Dec 2023 15:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 29 Dec 2023 15:12:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 29 Dec 2023 09:12:41 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
Date: Fri, 29 Dec 2023 20:42:26 +0530
Message-ID: <20231229151226.175336-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b53619f-d9bb-4102-b879-08dc08809bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FUn1dN2InYKFOJNpbOe7zhNPN3WD+BRRp/D9D/cVRiMAZIgmqNV2SYkBEQNix6I7S93m00MEI1t4UxoNZIuW6qF3L9anRCxW4Vxq6mq/BW65p6F26KDvH3p6MyNNf9oxj35Q8sLK/YF9QTrzW1qlyvtseX1iZOp0dJ3wPfOK4+r46VRNMEkYdZaCgrA2xB+V2NQdrgqMfBED5G9J7SBJrYa2ybjBk0RvYMO3LfkK09hnFjvOxuqd18uBq8/b2ZWf1vCGriiFbSY7g5lozhzk2G00JxTDqhYAUNjjPWMhak3KXj2yviv/XLv/2NQ3EHzIuTZbfjtScqDApCORt6n5XBx9woWS8UqAGdQf6lMYA414tVEwrvlIv3b0t46xGCBNeTZH3UbRHNiJl3c7mlI+8zNQ9xQyux2+FX6boCyBs6V5iJJvRC6ayvcCO1sWx8EffOnXRhzDNbY0iFoux+4YEgyvgqUMQhtkdYD5sH9IMmgcZdzmbOIYl1E8ZIMbQJ19KDqwj4zvYcMf8QPzbWigWL8eUSCtG2WAurmUSEsJgRhSJJvT52SCchAItBcVhACQNhXPHDmkXh1yaDauwtxORRfnmqcKWSbNOIZNoFy9cc900vForAk5YCzWAqUKxVTewSjzmQG9v5UeijRTDOiVecueqbRk8SMfFtuB6ppxeVmxJkexPc0g8FyWNX6OluVn8t13UK2i/Rh7Kw5Du2QJ5hUjCOV5hmqrMm1P8Hui6KbrDUi2kdlJVfiG88/8YQNqYfQbI4jzXomiCbygk4cQUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(41300700001)(47076005)(1076003)(26005)(83380400001)(336012)(66574015)(356005)(81166007)(82740400003)(36860700001)(8676002)(8936002)(426003)(110136005)(316002)(54906003)(4326008)(2906002)(5660300002)(478600001)(16526019)(44832011)(6666004)(6636002)(70206006)(70586007)(7696005)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 15:12:44.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b53619f-d9bb-4102-b879-08dc08809bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return value of container_of(...) can't be null, so null check is not
required for 'fence'. Hence drop its NULL check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:93 to_amdgpu_amdkfd_fence() warn: can 'fence' even be NULL?

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 469785d33791..1ef758ac5076 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -90,7 +90,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
-- 
2.34.1

