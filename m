Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FA0C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED6310E5AD;
	Thu,  1 Jun 2023 19:32:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E02510E5AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT2SZDje16dEZQxbIqo35Sbtp6LJ9SzS5VZkP8PETtPyUVhuGQ+1qeWQYmRZoc7TJZwxZAvqUkPYkYqgbuRxbHMsMPiGjx8m1RKga6equ8rd41UdBo4GuRTVcxHC4hQvBxrqeUfrAZ9aR1ZygxquXX2dSxEUeZ5GjbUadoX2J4nIsKIwrHCfi4+c8qp8oFdY3ku+j53xYry7Qwp0WgsmsY0ocK7jZCJQZRweGTGWTP3SOBx9RMRRmJWPcLojv3DOPeycrz0tkIvm4YEWwMEhLec3uDH+oXCi65VbhF541GpDhDr3DxTzomNWkl9l20hVCiEqKgk1hHg4jGS4coSyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBsdghmuQ8oiGAt7AtTsuF+/LdCi52BbsceaEJllS+o=;
 b=RSgkvtdI4LmaOvWOfT78UtXhA8/DXAOjZm+5OZsaiqYslrSxvx13vK/ic7e6odAWlZ4pXpePjOvvY1q18YLS0vVmLRZcohNQBoTG4F/tk2T6bWvbeP5OIlZDTNxXz0oQHS04zu3KrwaFzHkmmZcW/Ep8awxpp5KSmGxt5oQ2c72mdJzN5zCrOhdauNOP/7Ny3+N2TRBinJZ2Weom/bc/JTdH3HLXRtlDqdPAWtM29noEXy7O55oEUB0Hv5aLFULQDL9BeDW8TxyAUia9vUYrK3jihlaQEfFxp4Wz0/YL5WT3IfcQyAwvgD7xIiqtX3Igk156U5WvIKRzRGO+K6j2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBsdghmuQ8oiGAt7AtTsuF+/LdCi52BbsceaEJllS+o=;
 b=b+E3YqKZcrppyTzui8hJPJS20F/yAmCRhlrsTTQFz8z8a8fUxiaXwk287EM+6IfFoAnWPR0O0wGfWxKXSAEk+O7qo810b9OWQvb731QmQshf0KE06qwiap+ETvGA5uIM5wamKFk2dwrcnmBplM4uFm52H2qHv53PrebHxnIvljU=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 19:32:14 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::ed) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 19:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:32:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:32:12 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush tlb
Date: Thu, 1 Jun 2023 15:31:15 -0400
Message-ID: <20230601193117.13143-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230601193117.13143-1-Philip.Yang@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 647b792a-93ad-4828-dee4-08db62d6e6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LufnustUCeQG5GxqMRrLISCtW+Zc6KwsL3Tvyuv3c1P6JvuUpGMM6+SwnfxV2JZFKFBA6ge353V2BN1RYr7YfZkTCEWAo2i9Z4UoaKjaB5aiI+UBBFsAwp3HPy6PUXxGUbwvaCXOqmH4RlVt92Ex9agrMl6Dxqfp3V9DmQHM5DhEj84/Gpqs2lhgBmimUgn3FxgO0wi65xnEAKF7z/tUPwV7iEM1vQzzP0wWkZvZ8lyWm7c7d4i5AQghkXIlSw+uxil7IB0UUF9szQZTasj+aZYP6EEWofZwDewkm3QVCN6BejzncZck4jM+Col+KGMZD6E7pYopxLzpaeQQ9zvNx/v0VVvVovaZgtEGZh00MOx0YemiLdDeD6PQ6ztFQtcjgflZfs2FdpRys8WSuJPaPlzLWl7VRBUym38sqQWx47HscKUdVoXi4eHbVCa0F1W9FYTpqb+w8BIKg09Y2muG5YkvefAI6tGRqy1i4PtKtVbGjf5k7oij/HtT3LFKJLaLW/GkH0zGyeIA9RmzgRrDEfdVcAAa1B7/UNYA7j6QOo+RFDPNg1SJczTKhntl2zWeMeEWOASOSijbyleWCbCvk0yDt9l4LGSgpRBeVw+89QwetosAguSoccEg1pcIUHjgMemTFD+4VwGowlaQ0LtouS4e21owI/kBJdv6fJG5g4y5sKP+CcCSqc1XiW5iwgH4jcFEZaZZBa/wV6jjgRkySWk+Nk/A+1zuT6xnkGFl125SqwuRNQoIJDW2aHGfzp9l2MCxr4LrSD49cSHh5h/7/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(186003)(16526019)(41300700001)(82310400005)(40460700003)(316002)(36756003)(7696005)(478600001)(5660300002)(40480700001)(8936002)(8676002)(54906003)(47076005)(1076003)(26005)(70206006)(82740400003)(70586007)(6916009)(336012)(86362001)(36860700001)(426003)(356005)(2906002)(4744005)(4326008)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:32:13.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b792a-93ad-4828-dee4-08db62d6e6f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To free page table BOs which are freed when updating page table, for
example PTE BOs when PDE0 used as PTE.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index af0a4b5257cc..0ff007a74d03 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 			amdgpu_amdkfd_flush_gpu_tlb_pasid(
 				dev->adev, pdd->process->pasid, type, xcc);
 	}
+
+	/* Signal page table fence to free page table BOs */
+	dma_fence_signal(vm->pt_fence);
+	dma_fence_put(vm->pt_fence);
+	vm->pt_fence = amdgpu_pt_fence_create();
 }
 
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
-- 
2.35.1

