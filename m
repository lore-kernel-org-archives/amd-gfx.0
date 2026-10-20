Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF1606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vw2+Rn6x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452DC10E1E2;
	Tue, 20 Oct 2026 19:34:39 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7A510F796
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 19:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAgmvkpHRD8km40tZTPabZvbTUDIHLax7KbRIIWRuxLpxG/mEV315HHg+RNkoiKy84MqTP0cDfyKz5qWL7Vil8ktThNIBK9nAMiPblCW4XMACdD86GOV4IG4DfhQeGfGTcOgc1aNSxwUpFnkc2kqYe83wwMLcCKW8Q7nVO2iYShyStiTr4E58BVD6Btq1gMJdL3vJI1tRkUSch1Gy7uOi2re51BbbsisoQZPZ1YGaheIjYx5leg/h5ga1n1lF0Sq09nhsx8oFoZvZRJxLZe8w8WakieB9RmouRUIQZcGv/jjsWfq0S9jSeagBRcxNfXQmCiqbLZjnywfV39jLwQm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+wg9xenePshQlBLUqiVwT27la4zTIusf6LAEe5/2Q4=;
 b=lAVe+XcxaAsis9bVw4CrXJkyYSsYUH5mMn3d4Oi7cGElmOI47LBAmXFrWevPkoNFENK/FhBH7o53q86pI5wgR5oCmTYEA4O/AaDty1umeqJpZgwBNTqRKpjoVfj3UW9ZcrwDNE+o+RA3grAhtpquxwQp5xqB6uJtwTyZJ3DNQrM7yr2ogRFPIW4C2oyAm6bnQzPyjihTw8mKLDjquhuJEnxuXyRbaYxAs/GfO1gd9+O/w+KihBFGxtu+tPx+eqCnu5uBZQPoSR7QhJQwGC9DimJmY7THsfOcW5SqhZLHu/eFj9INQJodbWLpI9gPm5UZxJYTfP992O8SAk6vePCfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+wg9xenePshQlBLUqiVwT27la4zTIusf6LAEe5/2Q4=;
 b=Vw2+Rn6xr2G+3C/D/XCGdbVuLPiJaWHOrtMNIpklw455d/bOKfiRVWujrms2+JTIflFXCaGfMN6Uw2VOaRztxFI3eXKmjN3vRhhoQXcBIxOto6eWf24GCaymvl5y4UVwnEvo5qEwLRDtX1CCy3XSe5h11cKUqRXcRZ5VGfxc1SA=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 19:34:26 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::6) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 19:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 19:34:25 +0000
Received: from ubuntu-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 14:34:24 -0500
From: Leo Liu <leo.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "Liu, Leo" <Leo.Liu@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: cancel jpeg idle work on ring test
 failure in reset post-helper
Date: Tue, 20 Oct 2026 15:32:12 -0400
Message-ID: <20261020193212.19760-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020193212.19760-1-leo.liu@amd.com>
References: <20261020152701.18355-1-leo.liu@amd.com>
 <20261020193212.19760-1-leo.liu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 07230f58-4ea3-4dfc-38dc-08df2ee126a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|42112799006|261009221227099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1hUCOHoqHxf8ORpuyQUtYjw1DmeDNOvg4ZD8yZCHdt3hVGkvfw+WJXtsyaRiwoKrajpamq+R71JU0hkGP9pIA/jw2sc5+aFrEFpoyVoeLKYbaoXQgdWw2k2GAcUMIsUToDZ/LdA62wj96ROlqDGshkaGdgMH62Ix9i0PbJ3s0jKrYIPsARrX3qxWnuSEo6a5xR0eHM7IXkTGb4Xg/YMkafwGEh6/VPVwAo90U4tH0fNhiKY4EMLoQV+0M6lXStQVIPeY8luolh+6aV2OuGI7rW+DRW6Rdoyesl1h7QZrtXTcFljlBdKig2IfF1fs7/WsiU24IOfojHSMbnH6LCusR2O2BB3gX7aVTGwgg1XIgCEvRMwd1yYat5KwdFpVkDEVNkTuDrT2j0qdDh4jxdJklFoZFLdiO1dR55j/q5C5c6gx7VT3LnEFiLyYpShGaorsXB4cWRWhnIzkyx99YGb8zXoykTIDA9aDCA/LcUFzr13zS1aYLCujUwqsRNKLpFZ3PVv7VrdyGxeQPjO3avjbWaBbl7yHb5if4xa9wcrJGL6LSiwK3rZQvHpVC3b1dXI2HPzZ86u1zI1STzp8tEULQdphoNVSNUcq/9YbsScE4RFZAuV9lMnHYDwsIWzaDvW7AWgfFMzJ9HNY5J9eAkUkNgChuqGNskNkACVkMx+42RpfsTPjlfSP03CKdXvfYAV1GUbamDGcloSSbSnXuuU5gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(42112799006)(261009221227099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sm6EOWfgR972yOSTsdEL3CdWujV6BVHUooVMGNoTf69FaRjjS9wl/4w0IVSs/vUEF3LpeqiVHwQvu/6YKR8UNdeqMcdKTLDI4HdDIaO3tBtd5ILmGVp4LOQErKE83FUyOw+AcRShBAuFbZk4vkWP9skKge7SCkPLgXc3JcsHTdlFEapfoWwKB4Oat1YLRcbfLzIqYmgXheYBk1irlaDdQS9HYRRIQ3mDXCywjz+KlYs2PGYDsWGhcS8GUmOFZmR6kgj3cyTyQHEpHRIWuEZ/YGZEk/SBBhswSjlBNptSYUv6IqpcrigjSKOoCG0Fg8VWoyaTe6DNbLi0nB4BXlWZT292BHtkXkTao9POdGyCntOAv6YGB3xzf4ywouBlmR6cw0kdHXA96TEfScqaVpz2A3GFiOPXKiRnAfOIXlPD8e9H/7ld8DOqavA+VGDKc9Iv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:34:25.9560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07230f58-4ea3-4dfc-38dc-08df2ee126a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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

From: "Liu, Leo" <Leo.Liu@amd.com>

When amdgpu_ring_test_helper() fails in vcn_v4_0_3_reset_jpeg_post_helper()
and vcn_v5_0_1_reset_jpeg_post_helper(), the JPEG idle work scheduled by
amdgpu_ring_commit() inside the ring test is left pending without being
cancelled.

Although the subsequent GPU reset triggered by the ring reset failure
will eventually cancel the idle work through hw_fini(),
cancel it explicitly at the point of failure for cleanliness avoid
the work firing against a partially-reset JPEG instance before
GPU reset completes.

Assisted-by: Claude:Claude-Sonnet-4.6
Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 56fabca78ea4..78fa111c7112 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1720,8 +1720,10 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 				VCN_JPEG_DB_CTRL__EN_MASK);
 
 		r = amdgpu_ring_test_helper(ring);
-		if (r)
+		if (r) {
+			cancel_delayed_work_sync(&adev->jpeg.idle_work);
 			return r;
+		}
 
 		drm_sched_wqueue_start(&ring->sched);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index b35db4cc6aee..e634839d7e51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1366,8 +1366,10 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 				VCN_JPEG_DB_CTRL__EN_MASK);
 
 		r = amdgpu_ring_test_helper(ring);
-		if (r)
+		if (r) {
+			cancel_delayed_work_sync(&adev->jpeg.idle_work);
 			return r;
+		}
 
 		drm_sched_wqueue_start(&ring->sched);
 
-- 
2.43.0

