Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B631C61DB2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1695D10E7F0;
	Thu,  5 Jun 2025 01:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mqTOZQtW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D01C10E87D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSRtTsWvuOSchDD+mi3JFpaKlnm3BXdq5q3Bmwcf0mZcgrhZGudUn9kfNhR4u4225RqiCyA0kE1fSZ6qfzTVXJGizNLrrEnDCqOFC4XQIKqky6roszw3/Y4VSUwYTUCdzhoyZQQygFSlrlcQogYNjqKwh/Yjn0FngB4ntXNxBcui/Uc+8BHbXhdEAw7myXq97c/Yts34vh/3jqXMcgvDHjdJ7C89jkz11gU3/LJ5+glgDpTwOKO60xuxbt0MQSGHwBUOpDKSWB0ufRMbHencWYJhkZ7S4ZdOi8YXLJXQqu5tuPJaAMIk3hSv8kHpPmJM2T0gq1q1nPs+dhXSwviKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5+X59AK7RhNdAn63RvPw0UVqXp0dHHrb6/rOR8KPo8=;
 b=lX4Q+W4KU0bGvpMltOVVtYUh1nIMzUrRE4LdYQGrl6oLUtUU10UwXni+PRa4DZTUh5rRl7lt89JFlOs1Kdc6Yk71f137sfaiORbE0gLww/O7Io804ucZsNtv0WXesH4ArjDEOXpNwWvmYRVionQ9JlQ7TAxsjeZ5tcjmJmIkpXw/OeUxeFLHPQVOOKheX4z158gHrxlJEMpNGAlsPMSTd/Y3lbpmDyFkSwjNJRAmJXb2Mwb7MLrI73dsslrerh58PqeQvbKvzogZH7F+jUI9+ABI9vZ3Sm/qqHfHvPFGnf0QjxHerSn0kW3VncFziK0IPU92CADPK9KDMLlqCJqcJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5+X59AK7RhNdAn63RvPw0UVqXp0dHHrb6/rOR8KPo8=;
 b=mqTOZQtWHYCo2T/Di2oO08QP99ILewdYXtif5yk2ZrBJZXd6U2J/F9WKlY6de0wt/qkkjGGPT6HcRydXjsRHQRKV1dpP+bx5irzdVg1+GIydwJ9tItNmuV9LmYblBkX3MbAgvdZeO6ywIQQeMl0YRard0Sy1kQzOneOVrztP5WU=
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Thu, 5 Jun
 2025 01:46:29 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7d) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 01:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/31] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Wed, 4 Jun 2025 21:45:43 -0400
Message-ID: <20250605014602.5915-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: e123223d-e24d-4c95-d64d-08dda3d2ca66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+We7+AXaJST+YXZS3k7WihbsqYfA9WSYzld2RBvMw0K3eelQ4NLetOdUxv0?=
 =?us-ascii?Q?YIzZ89NJlKVsuwAE+5RK15VdJwKfnY91gTgtMA2ILYnbOyjBJeM1wCPQqLVw?=
 =?us-ascii?Q?dSZP5MJauFQFe3wPRSyrdRvMOmlhxD8mu0hXsU9FbcugraUaJ+TX4xrg64l0?=
 =?us-ascii?Q?HE6Kr9E+O/QHBR09RcInQaiqE3X0bQnvmDcNljo1EkzSD5zaOqICjQLyePJC?=
 =?us-ascii?Q?rlg3niSyalM8x9UdK4sWoYnR4aaEk4R6xLqqWYk9Ulpf0EBOY/GMGqssyUDt?=
 =?us-ascii?Q?QccT77sn0tDHEphtnXQBdPv1C6lG+96WnWXr8Zo4cMkiPf4s4B3IS58wu7EV?=
 =?us-ascii?Q?W34BaBERF/eyin8raPjtVhhVXOfkurjSrDonM60HD52730rOedKeTI6kHoyL?=
 =?us-ascii?Q?GlLwZYYLrOBt/MXb5jcriPCgqeTVcsQdDqU1ZLod8fOMjmaAFr+koXakxWym?=
 =?us-ascii?Q?7hMU83JrVm7iNKPwdklPKuGGOxVZBG8ND1Gk3wRS70sYgKh4JUw5ZPSICOEt?=
 =?us-ascii?Q?2xD1VCZhe36o7qBfntMF1q0kmGm8pr5OrgDx40C3cQx+2GKdSzqD/6Y5vLPc?=
 =?us-ascii?Q?e/H+iUNJ62FglNw0jd38+jNlhuEr2g4mBZLs6gnmWDHdL8RBN7iUsS10uOv0?=
 =?us-ascii?Q?YQSYGZWOq5qdf3XBCIR9K+JFEXG1jC7XfS2vTWeGa6CDOR51gs67q8FbrV2Q?=
 =?us-ascii?Q?i6SF2MUqOIE9aclPBOHPkwhHRNpftngcgsTR1SwzKPouiCn1DGvwuugQ7Vwb?=
 =?us-ascii?Q?ClidIz5KDW7yTTnQwiKYUre5keSz2jHn+4CE2glwjXnTCHUhjfZR2KbaPpBw?=
 =?us-ascii?Q?jsZhf7H1DLzrFDFoCM6Ye24naI7hjjUvh9mg5cnFAEB6qumCfTPxddcrz4rX?=
 =?us-ascii?Q?4yb0fHmdo5NbRUkT80NvU6qdyXj7/ynrARWXU1+fjImWKj+wNlXo0+cw8vtM?=
 =?us-ascii?Q?QvfZOKhnx3bmz0YrIJqf/jsGMcmr3Dcd3IkspkhdHJsiQeQCsha6aFJreNvb?=
 =?us-ascii?Q?er9HoriGShfxOk5thBgOQVwS5wI/1U9vdgAib5pxqQYSKncdtUmtDHrRNPeB?=
 =?us-ascii?Q?mvLRLx/8D6T8cET9u2/zPa2ZpSdecY3Xg4Jx65iWBcPo24sEncjNm2OsfxgF?=
 =?us-ascii?Q?nBDI/C6D2Y+HUbSlXo3yd9Vq75Sxcsbc7PzghhJ6WJJnEZBRX/iBnSbVLwiK?=
 =?us-ascii?Q?zvYIGkIMd09E4tH4xrisqotfvWIadFg3ft9m3ZwkBE3lSwUGz4ymie72dB4u?=
 =?us-ascii?Q?KFnyMyoqqBeXMR0+mAwu0GR8CKuBvHIUn0fhFPIuAxgNgq3EQuy9dznwyqBL?=
 =?us-ascii?Q?/8JjWny2Z7f6FVB4JnM2pbLpwio22WWOPOrnibxYIQznbRdCcw1/D1mL3QcD?=
 =?us-ascii?Q?HTkXjoHoi94t7/9DD9aPrwKuRFSVggYEams3mHMxHCgdZK2ANgBvV53hrbwA?=
 =?us-ascii?Q?PUokNUKNTaGT4zwG9L1irY8tR6jC+b8x2VlHVvPLA2qKkZweeXxiuzdGvvuq?=
 =?us-ascii?Q?ZS2yOKq16o2su+XVPzMyy38RBYtZvBCPzKFh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:28.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e123223d-e24d-4c95-d64d-08dda3d2ca66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..0bf8613b937f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7216,13 +7216,14 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

