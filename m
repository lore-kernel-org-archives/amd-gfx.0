Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AFBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 18:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39FEA10E011;
	Thu, 14 Dec 2023 18:59:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D5610E011
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 18:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSkxB55HntZYTWcfJazPzD2A0YmkzLkWTrUGe3zBWfssYioCU8yWjvQk/y+pdSH9J9A41W2wnjcB0/GGLM6T7kZ340n7ZImCpWWZ/TUhRJJXeQj0lZ66EjeuJADZyViIACaJImU8q3jZDJXSZXXuI3nFLjBuSji2ylJ32/doF07B8FUyz+10HxWR9UhqToZbnvnFsYupfdGP30rC3RX9lOEGsQQb9iy7yJxT8HMc4vYw4ayBPH0QYwZHtcHDv5iDQhHbgvGjAPpoVZwe+8kFHz3ClZQy13aFDUx8uIlZfTZtMlMIypzfG0A7FNxD7G0odobad6dJO3z+oy4g9gUPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHm+J/inHrOIQLMYqYFLyP96VpZFSHtLahFO4Ayr374=;
 b=PcVToxc/RdymiOdCIVES+GTse4TOVlXdfPthVm8QsLJb7U1zVyLf5Q2VRJPgBLDEMAswlXkRygvBk99iU7Makpr6xUDARYRnJa7SjASWW9nvd5WAvTI9xtpq4hDANqdEAcWk5XGn7paAvDfgpYyvh+eOAjLqrichQZIMgVP3FedsfxMm0f9ewq7L5j6LenZlgO6aZk9B3k88mI2wIDbRVB1E8KeRDZl4XS8TziRqxLqhNq7WTKv1cbcBCy2iMieV06TAD2AO2IdHntaMy9hVzDna6dWm7lspM5V2uc41GijVxa3dnIuAtTHrHuZ+BYW4BHmVNSTvfG2y+BmYG+AOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHm+J/inHrOIQLMYqYFLyP96VpZFSHtLahFO4Ayr374=;
 b=P8A+7+BNI5ufoKZAtTMRrJJ9oYiL7TS7KvNcte8NjnfIKWFm4/YvLYkTcvchyE/0BQmbzQ8yLqj+dvzACNunesRqK4H/YWaGVnhRXPoo7l3XmIf4c5SCYaMlr8Aq6Ayzb1SulnsbBwm09UgFDR6obL7jCnisgOTFqOKefKlUy7w=
Received: from CH2PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:52::11)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 18:59:01 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::af) by CH2PR04CA0001.outlook.office365.com
 (2603:10b6:610:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 18:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 18:59:01 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 12:59:00 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: svm range always mapped flag not working on APU
Date: Thu, 14 Dec 2023 13:58:32 -0500
Message-ID: <20231214185832.3355-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 1664db75-f2db-4e27-efa4-08dbfcd6bc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wlTzUifY6OxAset0j4IKxMswbRtrp/Pos/y3uY7WE7UseEIcoai6H7mZZsDuz0pNPxRq6ClYEUJveN47B40Qlc8CzpN72L78hDzF/j5T2HaUbtOw54Ufj4jfG+8GaIwlrUWNgYvIig9eTWU+RE+KSa0WVUJvMQkpWySmIE/77yDHE4AvPDjvJgkqQ3feMPgn5JAOKBjgvpxK7SLbqHO3lyb+w9l3I0oMqZwXGVUawxcn1kgcFw5zaRR/td03ku1h6ZmzFJGQN1bEhlnioWQc5Cmf6VSYAJdfhFKHOvPZqd80f8Pf4/yG3ib0KIhKDVfzMzW9DRoNcOsrKx/peCc224DyjcKWJWaIEw0vLdJb6GIFCkwC1VtaMV+pkU1IyXs+6AvcFau02e2qOFS58TIqQKKrlBa5hlzaT2bsOZMel2u7GaMsmj80htC6dV0xAatUjE98n3nANi1yr84WMkvjQylXTN4ywwjDXSO5YJkNEcNbq7CEHvpexbSN9IHseRe1UAN9w9sYiJCwe4lIRfj/rw+RXRgFacY+KoNagNcoAJeoopp735cmVK9EEh8qexefhg2QKXlDjLGojHPZpT/pYRqU3NRY8wHH9zC8V4uBVGz/IX9ZooOyPHnWSxLr45gIB3GzJISMnOota52Q+kczJfx7lIn7POmgObBxOKqfyjJla8s5U3PcyvbehCh0x2mTrR9Q0jZ6td7SHyyt5+QqQdRqmk+5IEeaiQxuybWbmivUQ35DgH8QTtm/0ZmhW6FqTQ2ze1Oot3/I21hvFai7KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(81166007)(86362001)(36756003)(356005)(40480700001)(40460700003)(82740400003)(41300700001)(7696005)(6666004)(478600001)(70206006)(54906003)(6916009)(70586007)(26005)(83380400001)(336012)(2616005)(426003)(36860700001)(2906002)(316002)(1076003)(47076005)(5660300002)(16526019)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:59:01.1751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1664db75-f2db-4e27-efa4-08dbfcd6bc20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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
 rajneesh.bhardwaj@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On gfx943 APU there is VRAM and page migration, queue CWSR area, svm
range with always mapped flag, is not mapped to GPU correctly. This
works fine if retry fault on CWSR area can be recovered, but could cause
deadlock if there is another retry fault recover waiting for CWSR to
finish.

Fix this by mapping svm range with always mapped flag to GPU with ACCESS
attribute if XNACK ON.

There is side effect, because all GPUs have ACCESS attribute by default
on new svm range with XNACK on, the CWSR area will be mapped to all GPUs
after this change. This side effect will be fixed with Thunk change to
set CWSR svm range with ACCESS_IN_PLACE attribute on the GPU that user
queue is created.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..41656e85ee57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1607,18 +1607,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			if (test_bit(gpuidx, prange->bitmap_access))
 				bitmap_set(ctx->bitmap, gpuidx, 1);
 		}
+
+		/*
+		 * If prange is already mapped or with always mapped flag,
+		 * update mapping on GPUs with ACCESS attribute
+		 */
+		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
+			if (prange->mapped_to_gpu ||
+			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		}
 	} else {
 		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange->mapped_to_gpu ||
-		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-			r = 0;
-			goto free_ctx;
-		}
+		r = 0;
+		goto free_ctx;
 	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
-- 
2.35.1

