Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5DBC7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 09:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DDD10E126;
	Tue, 30 May 2023 09:17:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5A010E126
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 09:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtVRe2F/uV+VWwTy/RPTqvnHxGAbvk6j78+EY98yivHS6zTbma/FnLMTf4y+XD0ahDS98xg0RvQaEDT9d/AZl+1QXyuOLqvrU/dZUR2MHjASTL/3g1YK12njIAdPWhd6WAsd82Esxv7s9ruSHYNI0raCLvdxSp42dP19W0FAgq29nxhvemj4V/jtUF7+j24AIKqdamY4LJHFGK1FzjQduwCmh3n0yMchBQfcjcaNPvypzYcb5Wrec1lk4z1y+D6u9PgIs0CV235SWHtqWCeVHRLEeKGOqXTaciIZuWGfrToY6PU2q1xlFStg56ygKuY7KuaZ7uA5mXdX5B+2TZh4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjUg5xbvPcbvyq6+Tuqq5gqr5haGGF61z1oVZPVUKqU=;
 b=fBkol6bLz15ap+td8v3Dy6AaRLpxPfuxjzGQ8bl7bF91fimzjN1dcl2byhEFWJJB4mva0gkp8bAdpJGFImCdsl86vUgSQqEsqePF7uYG/4/rq36QScRh9RaoMw8+lNoZCLVL8OYfB1LC/zl0J+U/hU7mbtRh5uJGPCqgL2MZp9nDQJL5FsQd1j3/sBHB+2br/WfdLnMj0gyroCLbbatwusI4sWaGM0qpEYnzEEtC48aJPpo5QZg8QliUoUjBlt2QnCD1MIYweVYnftNryHxDnvTIwZ5b3J0YEyv0aZhR0zwxs7MBCBo5VTuZnPlW5vwOHHBO4my9j5/7BAA1ED9GMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjUg5xbvPcbvyq6+Tuqq5gqr5haGGF61z1oVZPVUKqU=;
 b=JBULthbmlos7D5+D6vwSCQfzen62aH7Dvb1RetKqAZ9dmbprg6yOXPlbW+ICIigCyCsf4JBW9EIJgNapghlvD8BKKZsMnJMeW00JtWTn/DYi9a32aiKHC4DxiwtWUL6hTus8Ru4O5jmS3vGGz1hvNX19cfz6v2HbzxcwZwJCKTk=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 09:17:52 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::df) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 09:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:17:51 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 04:17:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up missing parameter in kdoc for 'inst' in
 gmc_ v7, v8, v9, v10, v11.c
Date: Tue, 30 May 2023 14:47:34 +0530
Message-ID: <20230530091734.2336424-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT053:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 314e702f-148b-4ce4-de43-08db60eebe72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HNUTvV+3ZmtfgGnU53HISQpkbVD27cpBWEuELSPLB7x4aB5bMjao2+3LfG8eT12Bf7TT5I5Cg4XlL2r0+zqIX+ccmdOwpdFZ6X6mO8UwDeaYhb+CLAXKgnu29JtzxnfyDUe68cNBgBQdGmTOa2NE1t6R3oiJ7rqk1KEMpKgh768Lv1MbyrlR9Inwbf8XakAYFLlkJ0hvj0ynxC9x4TU62yqcZwMNFQdB73p0cttHTntVtSjGoKE3xSECpgU/ajMxxPMUys4cWmUb57nnX41yl95JrQ1zMJuXsamOeaXTHJtNU9U+eZHks+2RHf5VgwVRcL/N361rrp8w5TwiWl00sMAS1BeCxS045v2pruhoN65Y+yIjmG1HaF3dQ+Mk8P0o4fJAiKzhrZOfrDhmMkzjKU2zqQhsJbSkyGc4OcI7uknTBjAZiB90Rruo65DOvWwmrgUdBplvHAiWM8BRoK0OgVbg7pyBTMzmSRbBZ5qh+8/Rp6VM3XOdhHyi1QnfQw/xE/HENFIPptyrZm53qObN/D3pQdEitpnKHsFzoFfj2iClwYxzeOBOrlr0rF3e6Dl1Ojg3ZgJ3SBpj7DQtuHhi9P6WbIHePn6XLLyYkIia2QTLuojAghlk91C55KPCe12IDI1TIoEDPC5Sp/3SyCDoiIKsNo+gMARND0isXyVfGyUOq10K2jtDY3l97BMPB7kOfWg9p/4FpJ+KMywqqKvZqgedPpuN0CeVbPhmCKl5+6xAmR6oaEvoQ6B2/OgUXR4IqYFmtmYIlK3oI7Yan5Jew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(47076005)(70586007)(66574015)(70206006)(316002)(16526019)(4326008)(6636002)(81166007)(356005)(36860700001)(41300700001)(82740400003)(2906002)(5660300002)(110136005)(54906003)(6666004)(7696005)(478600001)(44832011)(83380400001)(40460700003)(86362001)(26005)(1076003)(40480700001)(336012)(426003)(2616005)(36756003)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:17:51.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314e702f-148b-4ce4-de43-08db60eebe72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

Fix these warnings by adding 'inst' arguments to kdocs.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:428: warning: Function parameter or member 'inst' not described in 'gmc_v7_0_flush_gpu_tlb_pasid'
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:626: warning: Function parameter or member 'inst' not described in 'gmc_v8_0_flush_gpu_tlb_pasid'
drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c:423: warning: Function parameter or member 'inst' not described in 'gmc_v10_0_flush_gpu_tlb_pasid'
drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c:328: warning: Function parameter or member 'inst' not described in 'gmc_v11_0_flush_gpu_tlb_pasid'
drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:950: warning: Function parameter or member 'inst' not described in 'gmc_v9_0_flush_gpu_tlb_pasid'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 01bd45651382..1f9313298030 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -414,6 +414,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  * @pasid: pasid to be flush
  * @flush_type: the flush type
  * @all_hub: Used with PACKET3_INVALIDATE_TLBS_ALL_HUB()
+ * @inst: is used to select which xcc's register to program
  *
  * Flush the TLB for the requested pasid.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4bf807d825c0..8e78bcd92b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -319,6 +319,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  * @pasid: pasid to be flush
  * @flush_type: the flush type
  * @all_hub: flush all hubs
+ * @inst: is used to select which xcc's register to program
  *
  * Flush the TLB for the requested pasid.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 6f53049619cd..4d4a6957ea00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -419,6 +419,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
  * @pasid: pasid to be flush
  * @flush_type: type of flush
  * @all_hub: flush all hubs
+ * @inst: is used to select which xcc's register to program
  *
  * Flush the TLB for the requested pasid.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 48475077ca92..a5d47e4d0a8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -617,6 +617,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
  * @pasid: pasid to be flush
  * @flush_type: type of flush
  * @all_hub: flush all hubs
+ * @inst: is used to select which xcc's register to program
  *
  * Flush the TLB for the requested pasid.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index be7823d82150..5200303e63de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -941,6 +941,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  * @pasid: pasid to be flush
  * @flush_type: the flush type
  * @all_hub: flush all hubs
+ * @inst: is used to select which xcc's register to program
  *
  * Flush the TLB for the requested pasid.
  */
-- 
2.25.1

