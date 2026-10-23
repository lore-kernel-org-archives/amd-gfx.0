Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3967606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LjhvOEur
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCA5112A28;
	Fri, 23 Oct 2026 08:34:50 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A8F112A21
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV04/s6RFam54fwq7CRe7zqb06lsG071l+pFDx3FWLuWxe4CetBPR/C77KCt1eJf/JXUSMN8RRQtetTBkAjkLPGDsM0dSy+hJbOUIjHHxVZbrW6cHVdyzcalTglFqLg1SBLW6GzOMYvThZNrfl2UiIks5b8LpbNgUpd7XPDiQInhAVdsP41eBKvPdgCKxa4PehD/kHZOLJAYrXrhNpQlwIp2J+lBG0Zp0sPOzwlOvwASuQqZ4gNtg53Ni0EbYfPwRNNwuMHm2850Xsd03ycGFcvrARLDo4OMc4Aii4t8UfU7rd5M5cl272ozlBhgkMz6PTyFBtViiIX3ymJCeQpWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSuOtHiIyMX0pcxkDCWpdtCajaOYDcbhUsctecTwooc=;
 b=NMDVYhyl37L8T7v6Ujdn2uRgsJ1lIIhLY/ftDmijKD2tqLYjqsMLUZqHbHKWU+cbQb40XpwPCiNOecNcPU+DbctGnkPPG7PkrwTuc+/7NxJBtuKbb0SpFXe76dn87MEWSQqbdkvYxSyAxJ6Fm5AnnYstlIl0uAB+UTRz+tLKxh5d2FSAxMa+uvOrDLV+02vyVAUtDVw/clLmCS600yqk7WF8/HvqkV1eixNSMHPxAMH3V2xQ4VMMVpnrkXI3yvz5KYCP4U6D57UYgNc0Q4LFLkAjHnEbrDORuNNu1/gwkHQOr8JNlcZFpjX5o7oa6oxIbgnQ74RC9XnUPjz68TZ0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSuOtHiIyMX0pcxkDCWpdtCajaOYDcbhUsctecTwooc=;
 b=LjhvOEurexqiPO1evBusxHPiU4inauFWtn9f1hi3n8y8IPpQ3jEQ19eCV1CORoyw3BEy4ZD8CH+FSC04FAPd03IgU6FH76ubUM5j4VC7ElxCU4ndiysHFF1YeZM5F/bZbt7W0Mg1yBMSdRZFpreTFJivmM9V1zbodbyufS6bFpo=
Received: from BY3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:254::26)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 08:34:39 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::2b) by BY3PR05CA0021.outlook.office365.com
 (2603:10b6:a03:254::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4 via Frontend Transport; Fri, 23
 Oct 2026 08:34:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:36 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/uvd: don't allocate or lock BOs in the direct
 IB test
Date: Fri, 23 Oct 2026 16:34:17 +0800
Message-ID: <20261023083422.3049246-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c378186-65db-4dc6-623b-08df30e07a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|261022105027099003|261022075727099003|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rxnSYMxomvksz+ZwotD+MCQ9/ynVIIuKuVXHQ7gGKPBBl8i5WjrS2C7i2ZemskoNykYSZeHzDj7DV3nXc5m7NPUw7v1r50WxtnAaRkGgaoinKNwoLHbGjKJlE+wkWzV4o+ifrWk2QT9ev26gd35/K+4Dc8rUWphCT3ta4fcBbYd8AfZZnOMxg4jBwRB6dtg81BCHTul42+HbY43bIo1gWTkcruqTlFr44hr7qCjhfujwTyGI3rPcbHqlhsPhYHgnFQqi/6oVnKoNX7ezIbd4CNypozFFwcdWO86ggSwpLgDbaZ01FmgwKJeUR+Iby4mPb3dImkj0M5BRmpAMsINVVpPLTMOljVWyOR8Sb3+KKqZY1+yT1EaGZtWCixUmh9I0wOS7q2pVlaqFKkYV1eXIqGVB0icPqI4V8xLi5loC1vUVzB/njtmAg2GF4Z7zoBJRlQIi1thz61UB+19zN14/5usF1GJgCs0Pa94IPIEZux3RxuYkF8jVqYYJ6tj8srqLv56hqwkJ1eo18hyNxH4V5nytRGarOmTeKey1N7ORYDPdxjSB0esBDAi1C62KvZqMwhjOBZtI9OoSQwbbGMdEumLfszVxoh39ncoHhvXnEZaWsgvwlVxwGEeSZOFh1lWvwMzaqw8KdqlEbdiiaAS1R7XCaa1y425awu2yqtxqySNNwyZ7gcPCbINyH4RC7O3KiDqKOwRK0jeHEnx3ce4laQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7JWZE97DQvUo3SInrzeg5cFVBz8BMBRTCscuyooOvdg5YSa3WtaM6ipx6fjhxsi1brKNhIu59cdHuTJ3yOxwXcPt/FvAzHiLAskIU/Br6O/SQbVjgnX3fT3/i+rzCdVMxgwK0RD24qehr6fDzdw7FDAuq575Kb2K4yueasx5QuHdu+bGKu+fwqNX1DQeI6b+8VVfAUt9C11NXSVPgS5HW2Q++ejYUIVRY1zDcdY2dIfDinh3sgqfR/cmaT3A8I2OPaWL/IdFAK7GiGh0yE8PZOHETO6OZZpgscxb+Bs/UW6CtauTgdgP689w7+kH9SuZIErX0KNuT3o02znfRkeO3jfA+NykA7MHe6d5R4zXwXo5aTbOoekcB9/fD2ueOXKnNxyiprmxFd1rjMQEWSyLrH9y9vBNLt9sW2b2gQXGaS/OIyUYiHyqqgXN9F2PXx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:38.8021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c378186-65db-4dc6-623b-08df30e07a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IB tests run inside GPU recovery, which must not allocate memory with
reclaim, take BO reservation locks or depend on eviction. The direct IB
pool and the job allocation use GFP_ATOMIC for this reason.

amdgpu_uvd_send_msg() still passes the UVD scheduler entity for direct
submissions, so drm_sched_job_init() allocates a scheduler fence with
GFP_KERNEL that the direct submission never uses. It also reserves the
message BO and adds the fence to it, which takes the reservation lock,
can allocate a fence slot with GFP_KERNEL and falls back to a blocking
dma_fence_wait().

Only pass the entity for scheduled submissions. The direct message BO is
only used by the IB test, which waits for each fence itself, so only fence
the BO for scheduled submissions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index ecd7caa95d4b..bc15fed6fb9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1114,7 +1114,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED,
@@ -1159,11 +1160,11 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err_free;
 
 		f = amdgpu_job_submit(job);
-	}
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
+		amdgpu_bo_reserve(bo, true);
+		amdgpu_bo_fence(bo, f, false);
+		amdgpu_bo_unreserve(bo);
+	}
 
 	if (fence)
 		*fence = dma_fence_get(f);
-- 
2.34.1

