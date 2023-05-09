Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B26C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 14:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBF910E23E;
	Tue,  9 May 2023 14:03:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0AC10E23E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 14:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB/+gHBI0j+Ri9khwQhLOCzWelHP5C7YvHqP6hbTgC62laHoI0qluph20VZwOiD4CahbhJcY6NYy929SHI+1g3Ze6YuyAWvBPxy+CCAKEosV0N+8wxLScpNBM232uiMZEM515r2t7H07KYSS6cAMCiuluH0QeRc3kr3gSw6xGED5vt2PAhPovNs3dPGSqJh7lPqhbRI0Ygu738UXtsIu2wkzAmY7YHvNWhVS+Q2OF5fxoOsEMJKz4CxFAUMFfnrGxPVpL1ygkKOnmkbioTolSstWh6JLGNyZB4JY5ySUBcd5PIijoN9Tot3LUVkwLHjFIQ/v3E5JvOAdhRM7r0GISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHEiGnLgiM+kRfclJxqOnpqoixSH/hyvk75FK+dLfnc=;
 b=LZsCNgxCll59Pd7p7fxXMsbFxpNQkBlJFo09hoeQqAH82qSA1X/SOv1yXggwv8lamBqGGZ4ZSXS+gw3KZw+BdMPSMY9oK4KP8f5mTUA98PqE10+McrtcsLRqShylXGDRpleInV6ZnIRjWxPpdjCtbH1ziN+b5Y9bdbi7/W5Gb65Toss4JRSb5zXLrL0W5VD2531TSjU3+cHuRA/RLZGEBoe9h0/fPaPturajqQj87gsTlyYJZA5wH409MCiJfQ6nqsOwSidbkybJychIJICoBcaHblLkS+Z2U0a4l+jtm/vYt83HsUmkj4U6Gv/4yin8BShxUoBuTL5Epo5mhmw8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHEiGnLgiM+kRfclJxqOnpqoixSH/hyvk75FK+dLfnc=;
 b=pJkImqoJlL8/hCs3JWoOUhey/au/d5+wo+wRL/mT9rIumb4MKXIXAV+siOPkqHGs6JRw/msDFbAWxypvaAgf8x9JKfnSxU3adBkLiuK9IeZabLibk4dmO4DODeJvgqemqiPhPMkLb3iG2qjdwn0cxCO6JZWLaCJIYTydVj71R28=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:03:27 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::77) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 14:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 14:03:27 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 09:03:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu _object, _ring.c
Date: Tue, 9 May 2023 19:33:07 +0530
Message-ID: <20230509140307.1369211-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|BN9PR12MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6833bc-322d-48d3-f6e9-08db5096295b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbKNogxnz42y4hlwUa08E4zm0QU1D1m43/4+C58rvGJw/ElGT609kmxcwrkmpcdQvo49YmjpBb0Ef5HPB35VmSQQSJzWGmY4UjM+06gpN+6AGwyGgd4cZMTaEXUHYC8y+eepGjrtjMVG2DqU5m5156gFVerM+U6gyCE4Klb5h4hTFbn4ds+uLG5iwVUvla2AIKnknSOZnlwJavNwgFWbX+xmr/LzqG4KOsGE1oqY8xQO3OFvIye16JyQb/4MvhGE2sPP5XruMbr5B1OI75ynpG48PM6272MLDroPxDurICLPqnanq6qES/nIQHGVP96MvIJyda4E88gwZsfx4oF0S5hNVpqL5Ihv+iBSdlSe9u4b/1bz/Ky9dIQdFmPbLgGSakDwcMMTYMuQEqc80qqUZ48y0+YYwNtt2PTkXti31JX18J+U5adTk5bpbvdz+kw4coOFeI+hxM8Qq8YeH0tyPWZMnHBL+RubxHKB5dLqXSQTNrkFm9xvO5XWwa5Txapn0TdgIBJK0qqyOCQ0tAH1pvKQeQvX7u/uqQxDwQdu9vf1LLuVUa0dCaYp1hZ+BlqrSMMqCaO49cg7QDtmeKyVErGuP9GruvvdRlmX5/bKOorw44xB1uXCCBqMqG5Ik1i1mRrRhLW7nKO+tuvPO5jtko6mfGf3JTZk7yBS1Snd2c4C/f8WrTmRKFSGucpnkE9J/RYw+IMJdtEbe75uVzCL6X357908ZbrB+suIBbMrFgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(6636002)(4326008)(2906002)(70586007)(70206006)(86362001)(478600001)(44832011)(5660300002)(6666004)(7696005)(40460700003)(81166007)(1076003)(26005)(36756003)(41300700001)(82310400005)(186003)(16526019)(82740400003)(40480700001)(54906003)(356005)(316002)(8676002)(8936002)(83380400001)(110136005)(426003)(336012)(66574015)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:03:27.1797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6833bc-322d-48d3-f6e9-08db5096295b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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

Fix below warnings reported by checkpatch:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: static const char * array should probably be static const char * const
WARNING: space prohibited between function name and open parenthesis '('
WARNING: braces {} are not necessary for single statement blocks
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  9 ++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 7c9b788ae0a9..fbd906ac556e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -130,7 +130,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 	u32 c = 0;
 
 	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
-		unsigned visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
+		unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
 
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -935,7 +935,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, domain);
 	for (i = 0; i < bo->placement.num_placement; i++) {
-		unsigned fpfn, lpfn;
+		unsigned int fpfn, lpfn;
 
 		fpfn = min_offset >> PAGE_SHIFT;
 		lpfn = max_offset >> PAGE_SHIFT;
@@ -1016,7 +1016,7 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	}
 }
 
-static const char *amdgpu_vram_names[] = {
+static const char * const amdgpu_vram_names[] = {
 	"UNKNOWN",
 	"GDDR1",
 	"DDR2",
@@ -1148,8 +1148,8 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
  * Returns:
  * 0 for success or a negative error code on failure.
  */
-int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
-			    uint32_t metadata_size, uint64_t flags)
+int amdgpu_bo_set_metadata(struct amdgpu_bo *bo, void *metadata,
+			   u32 metadata_size, uint64_t flags)
 {
 	struct amdgpu_bo_user *ubo;
 	void *buffer;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a1d480b7fd1f..7429b20257a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -78,7 +78,7 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
  * Allocate @ndw dwords in the ring buffer (all asics).
  * Returns 0 on success, error on failure.
  */
-int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw)
+int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 {
 	/* Align requested size with padding so unlock_commit can
 	 * pad safely */
@@ -315,9 +315,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
 	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
 
-	if (WARN_ON(max_ibs_dw > max_dw)) {
+	if (WARN_ON(max_ibs_dw > max_dw))
 		max_dw = max_ibs_dw;
-	}
 
 	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
 
@@ -591,7 +590,7 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	char name[32];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
-	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+	debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
 				 &amdgpu_debugfs_ring_fops,
 				 ring->ring_size + 12);
 
@@ -601,7 +600,7 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 
 	if (ring->mqd_obj) {
 		sprintf(name, "amdgpu_mqd_%s", ring->name);
-		debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
+		debugfs_create_file_size(name, S_IFREG | 0444, root, ring,
 					 &amdgpu_debugfs_mqd_fops,
 					 ring->mqd_size);
 	}
-- 
2.25.1

