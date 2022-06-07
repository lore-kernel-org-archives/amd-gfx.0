Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1512C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 10:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6E911A28F;
	Tue,  7 Jun 2022 10:01:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2F411A28F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 10:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO7UIcuWTIntmrfVQAW7HIGTS8FCrPvNkX8SROLWQ0GHiBJXGfB5kkSr13OAnmgksBUo3IuQMpWqOfBAKkZuv0RL7uUlnyJb+XhYFeTEQkm7Rf9LNxdTHxAkAAbm0eQ01cX9HltvutoGLvxIwY7SFLEoViJZ/Ywtc3vzcj3cbt2IFCgtLM2lHdqsMo9VcgvWwMmbA+sEkgLKVYL8/A6QYBwuKkeW8Z7sBx9xz5Y0/ioOCG4g2IkZHaVpxNO/knUBU0IsnFHVrngBwN5rntt/5TUqjH0t7rl8NVRtud6T9U84X7PDj35gUqDALWXqoB4pYYNNBwz7eK2p97hdyihbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuUS0CmmRRrbGrP9KUdVkFprOU13M1yxbt+vSPbiTE0=;
 b=eD5BiMVNPhSPWw/URShEopBprpO8yymTy5mrs6YM/4JgAhpt2fW++B3v+YmMs7IiFrVjGSXYL/6T9Jy4xM0HygZmIbty+Xkq6GZWT9SSpGTnPo4nHDflOAjz55TD9Gbq2TRUQzd7jFwxDwADqttNBQlQZWY+Bhxb8NB75yBzilrMtAevJMlB4NhckCrOBVktwtKmpyPYRzg2WagZIum18JAh6Zv8KUsRLhHQZcNon/Hjebyh9mv9IxkPHvOLpwUG3CXH0IA1qf2ZOnLeisbQUlHVqm8u8h7Jo7/M2yO/RcC4ZJ+T0pDapyicV92I+tgeAbdgl9Ilmg25McwS8X9P8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuUS0CmmRRrbGrP9KUdVkFprOU13M1yxbt+vSPbiTE0=;
 b=s/yffA+atgkr5cMYgYmhjx4Q72X1dKSWI9un9gMgzrFV09kO58Ra5FuP1m4sOmVLE5BV7gNOzEZWd53AOW0kmkchn3W+yYNEJdlleTmj2PcvH22ySHngtINjanzTAS469oIXeSrdGiD2OzDEh2T80DJRx0dP3tusDY7d/0N3qdE=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 10:01:54 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::70) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17 via Frontend
 Transport; Tue, 7 Jun 2022 10:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 10:01:53 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 05:00:50 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: use existing VM helper for PD and PT
 validation in SVM
Date: Tue, 7 Jun 2022 17:59:47 +0800
Message-ID: <20220607095947.120493-3-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607095947.120493-1-Lang.Yu@amd.com>
References: <20220607095947.120493-1-Lang.Yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc756c4-3ec2-4943-b0db-08da486cbfd7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3198:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31982632E3FB750DE72AB698FBA59@MN2PR12MB3198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGKseoCCirKG1REFVTZOt4Fs59wUQuXJqZi3SiD6LBMq2/VHVUqAGzWtsUUNVwvy9QGIYnoaLvC1I1cuQfaPIwg2s4WHFDUBBx4aZ0+UPsI24WxcgDRRGcEXpVDhBYBVTLYwU1mXL3vy8ylryCo5nxkDEppNFyicvfaif9bl5TdhZaTUcbqEksIOTVb/wrodlH8tc3YrFWRH1bKsZOuHLlO19AdqE1oOb/zwKlRaaFSii3iYrSD/ItL8e+qRgkfqzyFqXQ2lD42K1mvluXhuk58mc375LBunRTzv3G0rgo/R95Dw0c3C5HCCCR/naZjP2FM1eLEaNkB/wdhCLLwaXaloV8E6dJ5bgC1OQaOoXbLZHlkG+1u8/8E0F4A4ocQKXPuba3dqI+0eeNlRngMtM/p2nGlgkZ7jN3+gRH9J9Sa2/5WkbrFuQjkxvs4tQUqj4WBLBPUN+VcukDTJxL6aI/CUbRssKQuLfsXM6iKh74kLfAQY56Yxqbwi3y4qjYg9hd/S1Z1OCB3wcSr7nUOJFSZH1J+9K5/K4AdT8fG4XVesJEzv5CL9zN3F38APjUcIsZePGn+57Jz3uwc0lYVWFeHDAuDXE1NwJdFIv4l0dTWyu3dgR3PXmPQzI3nvl5exrtsdWGVF7aFZ3UO2+AVD7b0FIdnewXMZj1y6NXkwX4RSmvHgd5dT27jgEujE1NKsQ8tk+06wyIng0wvL162+lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(36860700001)(81166007)(7696005)(26005)(82310400005)(6666004)(2906002)(8936002)(83380400001)(40460700003)(2616005)(86362001)(16526019)(356005)(336012)(1076003)(426003)(186003)(47076005)(5660300002)(70206006)(70586007)(6916009)(8676002)(4326008)(316002)(54906003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:01:53.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc756c4-3ec2-4943-b0db-08da486cbfd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This will remove some redundant codes.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d6fc00d51c8c..03e07d1d1d1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -625,15 +625,6 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
 	return kfd_process_device_from_gpuidx(p, gpu_idx);
 }
 
-static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-
-	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-}
-
 static int
 svm_range_check_attr(struct kfd_process *p,
 		     uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs)
@@ -1428,9 +1419,7 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx)
 			goto unreserve_out;
 		}
 
-		r = amdgpu_vm_validate_pt_bos(pdd->dev->adev,
-					      drm_priv_to_vm(pdd->drm_priv),
-					      svm_range_bo_validate, NULL);
+		r = amdgpu_amdkfd_gpuvm_validate_pt_pd_bos(drm_priv_to_vm(pdd->drm_priv));
 		if (r) {
 			pr_debug("failed %d validate pt bos\n", r);
 			goto unreserve_out;
-- 
2.25.1

