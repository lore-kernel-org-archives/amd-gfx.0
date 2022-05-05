Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA87C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 03:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019AB10F8F4;
	Thu,  5 May 2022 03:20:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2716810F8F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 03:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGbKHHck819qlq70u7St/mSHaf1PMFdYbxKLi2LYRuqprUSL2BD/KnciR+U8Qpkw8fZpbk1icJV9iH5EEBx5CI5I/GEASW7YGqcFo0KmjhUY4Yfps4cJjP0zms4KunaSVl0qtLev0ifKcvzc3qZ8d0SDZlVGiv0mCU/dluD757BwyERsn8VgZ7IEHnh+oTn8KjeJiVu5tUcCI4ywv6MaB4e7iE+WzZubrKOjXGGK7IrU9mTqkqGCvDhhXyUgwOi0W6id+ISU344vKuGQtlSbCY/6a0xdq86CJGPKjcuLz62YCt+bg9kLI2iBbel1zkG9nqVog+RJWDDW6IT8YQCrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+RvkJwyaVQJ0e+cq73DkEfQ5pn3TrXR6AGNX4ufHqA=;
 b=JCWPdzdf8OXUJ2SxZmW01jgFc96Tc43FxdcgUq0+/FoCSg3kLUKzVTdsEzgHVL7kY4da111338AE4OwJoiFAUE33/s1TA43UTS3pJ6/V8VIPwJeiY4K53Iome5nPkO4JNTt/SLJiT4gNOZ2t4ZQnWdHYOxk8CSxOi6I/O21LAOX+jASeMm8mnPpIyDZjSNR0iL0GtB9Ft4bJ3ZyMFqp3sQ1Zm6Myv4ZRJmCpyD3eZYw7Y2MbCp/3UEvTZFJAedW9BXUOtPc38G8IsqTSdCBidaSM0n9NC8Ohpys675VHzodqv4Rg4pNReit9h/4/I8o6YOJNofU5YmPgI2Mx3kMs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+RvkJwyaVQJ0e+cq73DkEfQ5pn3TrXR6AGNX4ufHqA=;
 b=0mjeY1GnUKUrrz3FjNNuweBloL9xhaZvy1ee4pOcEHPQTwtxl0sXv5dA1lOt9p2R2TTeYr6WWuNj0RT9bU/5nU59GS0mLV+px05rVeXIPw2VkeDHxMtq5xVDh66yCO8nyZZEnfzPdWzEKErUz7PwLALOiMQsTTpP0orPLgl6bCw=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 03:20:14 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::bf) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 03:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 03:20:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 22:20:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx11: remove some register fields that no longer
 exist
Date: Wed, 4 May 2022 23:19:55 -0400
Message-ID: <20220505031955.531751-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c247a5-7a2d-412e-33a6-08da2e462b99
X-MS-TrafficTypeDiagnostic: DM4PR12MB6160:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB61608813AA38003177F4FBECF7C29@DM4PR12MB6160.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9JLT+MMYXRvBgDIqVtvcHFFQjasyc8vZVywQuZ1dZPOSin8hqjy7Jy38HKnkX5OiicKZueazwBqIt92zMbPHPmBAoCi32yGjvPqqOGUW6DEunVz9IrpMgmHIYaxz4lCwhzDhqhbSOsQOpCkMi12HHJmD0Drs+0WaoekzzLEffaHzmaNnZaLeBUtUjOCSMZ39rk9+CAYL5ZpWgOTqv5yt9bj+3oIKLiEzj/NpIJJhOzebnB3FLI31iVr0uxj8B8/TZcVIZ9qT1RnkDx7j9fo0YPW8pHesMzJAJ1fWnzQEBTv31W77VPvXnOzHnZde51UehHeORguBujxI80mw0yDxJ/4uZIHJ3AO/TP0CLk/G7d85sFvF6AuD6kLbsVWOdkRjxVMN2HzpwnthG8ctiFsBvKUeGlFH1miQskuSebYb14EFBU/NLpY/akMjOsfE2ojycOu79B5hqGjmuFtzcyX4KiIA72L29spTLJorT1NBumt0hdnB+OZ+j6xMswiXzlGkQhO90w2RjBJ3+kwH000p10CdvN1PtiJqFjTCrKvF0nFO7QJUSvkl4AhRV6cQ5sYvkY0r6LOGS26NYEsUXhW60IJ0NlcKnSuHxLsp0GsTqpYV42XgurJa6OKNuEd0dPCLTwqnw9u21ILuAXeFVPF9iNnbiLb72b9Lzi28164oLwNGJJeIyxG2Mufn0Ty04V1bQdfI5Lwxz8kvzR56yC8OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(82310400005)(508600001)(54906003)(5660300002)(36860700001)(8936002)(2906002)(36756003)(316002)(6916009)(4326008)(70206006)(70586007)(8676002)(6666004)(7696005)(16526019)(47076005)(426003)(26005)(1076003)(186003)(336012)(2616005)(40460700003)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 03:20:13.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c247a5-7a2d-412e-33a6-08da2e462b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some copy paste leftovers for older asics.  They were protected
by __BIG_ENDIAN, so we didn't notice them initially.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f0f13eeb4b71..7c75fe51ec20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3452,9 +3452,6 @@ static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
 	rb_bufsz = order_base_2(ring->ring_size / 8);
 	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
 	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
-#ifdef __BIG_ENDIAN
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
-#endif
 	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
 
 	/* Initialize the ring buffer's write pointers */
@@ -4102,9 +4099,6 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			    (order_base_2(prop->queue_size / 4) - 1));
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
 			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
-#ifdef __BIG_ENDIAN
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
-#endif
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
-- 
2.35.1

