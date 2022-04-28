Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F78C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151C910EA27;
	Thu, 28 Apr 2022 18:54:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8916F10EA27
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8jLkp/PdE7WXOAtFvOR76pvS8yeTTCOutPqRKiLN/LX5ia3ghGWd3J7kDj0LNy5uYLIdJFW/tsuN6qcvQlOyAUw/3i4YTGSG+swPIdjdx91qQGYXMqyr8AA1eAkmE/k/5QRaiwxqvHf+ZBTm8bc17D+g3XcidlaETF4BCyRBEUBEuvgebEVxXSD3Gx+mINUDobUV5uOAianRKO+LoF+QrUJvYneestciexcxmg6ATmkeAAmA5xmjExf7Ordc/c05D5TM4WkTOozpnqhqCNYoNI6cTtEd8i64d4Y+YQvG0MGKmQGvoF5TfoiAJlnH11djUccTtx9RtwyLX9tUnZIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI/7ymsiW+OEzfurNgzRlnjO0mGNqDlkPZjAU8dZ97I=;
 b=iLaH+o+ML5f1EJ0sofzPCIi4uKsdpwHArBuWzXMOHjkZUX/rA5zef32lNWNvS7/eI1ImwS/cdL6DlblX/TnMXRMPsDyUAgjJKrCbzwUFVwCB35dkAa2OZT1XE9kRf9BIAQvSHZ7YWCqVoWmT62r4aGzNZmypEho2claIKpurZ7O1A/J7JXz8oASyuldXWtL9GV/ffT8+tdiVy6txdUFkSsXBu2Y6Gwjzx9BzWcvaL41lzrPHLtZmnvPJLDeHWWQS14aeKWLkw8pFd4spwC+7UjONekqwXNqZ4DF7JB0V4lveO6yJw4glkqFnJ8rAQIjgngpgLCXfNqskym1vKD2AAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI/7ymsiW+OEzfurNgzRlnjO0mGNqDlkPZjAU8dZ97I=;
 b=DGkqIgXXgjPRwXBd/0qP8ZjSJLAg1HlDJzR7/iNo2m0u1TBLXeC1NyfHToQi/8WeGvpQzJDvlOkFRUSFhbh02jPkin6WC4IEL6mLBhvhKOSiwKIXG6rfQu8u8huEM/UENC12KYeb4aZGmZ/bs9OJcB+dUGrkg/9zNYDP49w02k0=
Received: from MW4PR03CA0115.namprd03.prod.outlook.com (2603:10b6:303:b7::30)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 18:54:01 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::e8) by MW4PR03CA0115.outlook.office365.com
 (2603:10b6:303:b7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 28 Apr 2022 18:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:54:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:53:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: save the setting of VM_CONTEXT_CNTL
Date: Thu, 28 Apr 2022 14:53:47 -0400
Message-ID: <20220428185349.672503-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d8d8ff7-fb6e-4e97-2218-08da29487586
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB41456281FCC64FB9374BA240F7FD9@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nhWtdnhXJg0Q4wuqm1qyp6f2LNF77cQB7VJ9IJ80L8zpnmXiNpC9k+Hci/BDM34gPUaDdSwc2lmXUEQdgRcwKDib60DKJhArvO34cjWUtEXWqz0GlcTsxKhhyUpGDu59s3Nt5bNK7HR2JAaKiz40Eal5Mxce2xiu6c2mYf/ITbFdwfx3sDgbdndmsLbUOnAw6F0HERO3W3GFyD77383QhQzMD24XCNeU0Om/bGBCzZyivtO+h6lrCtqZ4WuwsPEFKp8BZjMkGP63cWhPFNEG8vb6NFarRzKSvepUfe3PFRLtIc48EF+LBdViQ4yKxiuTGCQ5R1irP66dgs13424XmpFoDvU43iR5/08OIKxgOAi1q5DpnyfGVIL/ioVtj10r8q882b5Tt81tqedx4+Ri3+KgZJznRfk70KIYmH5I+hBhriXOpAimNGrIuSdqgaBnYQZSEeOq9UMTAq0SAV/06/7skw8d5oMkn3SBv5lQG2m2YNKyNegCYkYbU9nJKk78LZT1+/2uo6jXRjkDs9lQPbscnJ/MSd8aogwOr5M/A/GuojSsGb/nBmgeaopTwNzzRYn1ghfXeOAw95BiyNWeNC4H3VQD/rGmKd1BUPltsqbp3wtH3B13trgG0TtZEj3lYHjxhT0Utk1/xtrreci/9qPbsvfBaqBynFiKe8LDzQ1vNNzUhBf4cizwGWq/WCAUy5Xu60yIN/3J7cChr2IBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(186003)(2906002)(40460700003)(81166007)(2616005)(1076003)(426003)(336012)(47076005)(86362001)(36756003)(316002)(16526019)(82310400005)(356005)(7696005)(6666004)(26005)(70206006)(8936002)(4326008)(8676002)(6916009)(54906003)(508600001)(70586007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:54:01.0580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d8ff7-fb6e-4e97-2218-08da29487586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

MES firmware needs the setting of VM_CONTEXT_CNTL to perform
vmid switch. Save the initial setting when hub initializing.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c  | 2 ++
 7 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 4be6b657944a..008eaca27151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -100,6 +100,7 @@ struct amdgpu_vmhub {
 	uint32_t	eng_distance;
 	uint32_t	eng_addr_distance; /* include LO32/HI32 */
 
+	uint32_t        vm_cntx_cntl;
 	uint32_t	vm_cntx_cntl_vm_fault;
 	uint32_t	vm_l2_bank_select_reserved_cid2;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 6e0ace2fbfab..34513e8e1519 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -325,6 +325,8 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index ff738e9725ee..d8c531581116 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -334,6 +334,8 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 47f0e4daa466..5eccaa2c7ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -335,6 +335,8 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void gfxhub_v3_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 636abd855686..4d304f22889e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -408,6 +408,8 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ff44c5364a8c..1b027d069ab4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -324,6 +324,8 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void mmhub_v2_3_program_invalidation(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 74b5b2f2dfd3..08a85a0cd334 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -361,6 +361,8 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
+
+	hub->vm_cntx_cntl = tmp;
 }
 
 static void mmhub_v3_0_program_invalidation(struct amdgpu_device *adev)
-- 
2.35.1

