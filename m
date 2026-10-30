Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F01606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jBKLtOL4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 790EE112620;
	Fri, 30 Oct 2026 02:48:17 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B949A112620
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 02:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkUYuPCQ5Gydwywjojcj7ah8stg/P4DvZCqrta5BAtvMoACFiACI6fYPMw0pObu+QEr2pBNlwJ0Q00bN1kzi6TCOP4R1s9ZXq5p3NzvF/BlwSoRhb6KOSvwMyuvrj2Tekv87QEkc3fr0wm1puXNF+dIJKckucXV6vJp7bbOIymtE/uSueVGX6pRlpd8lwVdIQDGB/avnk19OJUWdb8h7lY78wkcRLfUU1j1QyV8ji2jf623tEeWG3OUvqdShLTfcnK9k07QKB2XubFmpGGigF3zSLgrr7sR5j/V6bS1vBuXAe3iTlZJ8N5G4It/+o9ID+iWgU9BTIgwcFxqniOjDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3oMsWPNgVXsc4N1uiF2pql62UEZ+MkXtTM2brmhL0I=;
 b=FW+4gtQmI8AKkGLS2uAUIe4UhjoSgf8YpTFPOpOZ9x0pKpzE+MdnPrR7GmW47qs92IRnmgN/ZZVpKOCq0e2KjXRLPNhWF56N34DYA/Ho3yeqDinM4CiU4ogyize4jh4v/JZB8f6bYLvzcKE2qaycP+Elm52h63r9rlJ8h1XgkvUU9LxDEPevLxlwtPVh0d9n5aJk6NT5ta7aLZL8c8IDAcJhzlqYYN7Z3P2fEIv840Ych8Tn6HHxC6Iy5BBpYtr8NsJ0qZkHh6nKlj030LvanVpaFcqHYWT74478Xtaqm/ZTX5v8oJ9YSkMzplkLcfPjsGwrDUQXznown5WFUOFocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3oMsWPNgVXsc4N1uiF2pql62UEZ+MkXtTM2brmhL0I=;
 b=jBKLtOL4uxHEw4wAVXl2KPm1CxDXdMZrsUN0YwLI3j063HFrdXdTzDJBY5zj9sOJdG438RhxMq2a6aNZyH7Mk/0NOdHuVTWxdrWAqZjWipccGEAT+SWrS0ULpMiopSdHdxunt9LOupYeGUf0Qbb/bQR438WF0uwtA9Jd2121naU=
Received: from SJ2P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::17)
 by BL4PR12MB9477.namprd12.prod.outlook.com (2603:10b6:208:58d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 02:48:05 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::98) by SJ2P220CA0005.outlook.office365.com
 (2603:10b6:a03:5da::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 02:48:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 02:48:05 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 21:48:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/vce: don't allocate a scheduler fence in the
 direct IB test
Date: Fri, 30 Oct 2026 10:47:46 +0800
Message-ID: <20261030024747.3083509-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024747.3083509-1-Prike.Liang@amd.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BL4PR12MB9477:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e41fdb-4eec-46d8-bfa8-08df3630390f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|261009223327099003|261009221727099003|261009220027099003|261009221227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XemjaebL1rNwgMshg2WHF5y4WZmLblva0vrK4WMbWLncnT97zDAza8d7O9A7057ruda/6eNbMNSifJ7RWVV+kzGUaffB9SUgb4Y5S7JE3kpGEVqRyMhzkAXgtAuvOq2tRKphDH5Dx879Ba583GISS81dBPJaUss9ZK4ATZPqI9+Xt+mv/aRgQ+EAibXru29TcknOcCXCFqxyxsLEcn8OUTkSxjURMJtj6mK6js7e6C3AfwkkSyIFX9fBgt122qt/DW139mRqk7jlWHIpI/PcOyTebd9o8zyOd1uh3/5gem2182p4ChN0WF0NhfAXQK8Oe+ai34+wRwu5Y5X4OxCHBBtNb2s1YSx8avl7Q3RK0mlTFDNsX2MGVCYf5aQQDxsMB9B9Wi+UDbnaQCt3H5O47HokV6WW/CIBZgofS80/qJfdaAdUC64MpR15eyf6NifWhOVsgf1kNHqy/94tSyOqJPkF3NmA3XgQBbcMvgAckE5GiGptNpS6wlJwB21VV56ml65TJY8QWuk9OIFEz5GT5FY2uVWeb+Cfub+VP0atrZtXeU57ajK5qxBZ7SEjVbogpnNMlHIMKKeb3clGME1iCPNMnM+LbcIRVM/Y5vOMqdIlgtcr/D7kNJxHlk0b0NyS4rS1K4WyXHqMUgq2xLS3XagTfBOyOeUotqUT9TfrQdu7LNST4VrEfKkGo3R5dlrYK+wz4y/JlfiitP+cCxh8zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009221227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MnJqNK3adRV8ZKDaFtpAPvWA30co4JyYkQTJH9VNuwe/n8xnqZ83YYge6hdn5Fai41igexhyrBKvt5ztzGLsmkmjs176vTvwG5KqCRIV0kuw/Dum5fB+k3h6wSf0DRoe2JCaJoIRhXFeRjPreWEwBMr7is1DLVnYN5JImBjBZurIPhui/WAPaISH0geN4lMRdo82f1HvNEiROX1nlMnkCVegjZmD0cZ07RgxRlK2gkFa4rk4ju8+xPxs6iN4t3k6shM/fVEXmyD9V2xZdByLzdjofe2frMyKDGd3wKm/YIzA2Gv1MpNQBbGjsUA7gmKHEwkJrgUlrrtmLDVtpNNTeN7wGtnRNH9z1QNMHnOFZz4DVpp8j+KF5idS7HbZ2lfDMmuWpIcsose2CkffpjbS/NvlCj6Y4574dHRecqGvVMAKszo3YvaYY0DfOOwo/hx4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:48:05.2282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e41fdb-4eec-46d8-bfa8-08df3630390f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9477
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IB tests run inside GPU recovery, which must not allocate memory with
reclaim. The direct IB pool and the job allocation use GFP_ATOMIC for
this reason.

amdgpu_vce_get_create_msg() and amdgpu_vce_get_destroy_msg() still pass
the VCE scheduler entity for direct submissions, so drm_sched_job_init()
allocates a scheduler fence with GFP_KERNEL that the direct submission
never uses.

The create message is always submitted directly, so don't pass the entity
there. The destroy message also goes through the scheduler when the
handles of a closed file are freed, so only pass the entity for those
scheduled submissions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 3952af9ae115..dec3c6d9b6ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -471,7 +471,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
 				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
@@ -562,7 +562,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-- 
2.34.1

