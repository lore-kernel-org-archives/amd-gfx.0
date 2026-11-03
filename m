Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FC606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j7Z5xtw/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A4110E0F5;
	Tue,  3 Nov 2026 07:43:34 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E2A10E0F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 07:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMisQAdOozWGIpt+RU5TGDZVp2ceVoRDkf7xKDd7TYlVdHsK1IBCbWM0k2o3kjGw/EDuCuFElIcwWnkmxO+e2hialJ60iLo7QpKFsrGmYOMoSs5r+MxIXNztnT4Q47hTiQQ4aDi1Nd04jBp4NbOqrDYOMj/V3mkPnkSDqbWhJTGTTeUAuN4MJTrCud/mNMYXF5WJZUKg3cL+OovOqHGO8RPwWcNuuIOJ1NQ6EOJGgvT9+808bIb/a8TYWLmbA1kJP3JFbiAdSxrynU2BfL5K7gEBqHPYX+b+JBh0wmjss5/kHZxq1dlxQfndfwCK/XzrU79vHdIEiUx1VEte7WRoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGIDstG1G4hykFisS5sPymymF2MivadNYM1QI6RTQFE=;
 b=J6sRwOp9ZvZx/MNzvX6l9IPCDMLwB67C3VabkGHcr1X5XAVRilanJNzxdxsTxbA3grmnC6OJ9mrqmRPEE18O4JcHwhMzBllat8VDzQRE7iEXESJiUomzjZbakweorrgXx9KwvUjlFk1Mup9/eAhtr6at29SSUMl2KxPKSGH4YJ/u4B475UAEmv8FTnDSmjT5+mcvlAOyxZ/m5jy0gSdH6x+URVHb+OceF80JiquKiLK3VFvvUcmwqxRvfRbSOQfSrucy9nFKe0NhJE+tKu+9PBMOEcc6wRPu064QBaVsPzm/EbBsbj4b3Hv4iSSlrLS+1EHLR1RxSqp6O73USuVBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGIDstG1G4hykFisS5sPymymF2MivadNYM1QI6RTQFE=;
 b=j7Z5xtw/IcaoEUqHdrBONbHJQJK0qD3HCIQF780rguyvSXcUvKbXl8DQ8jKN00bNFw8a+gxLqLI/iTdmnybrP1DZShFYdTAXElPX7GgfJzxJXv1jVP83hWvyLfZsPHYEeQtylb5h5QbjG3XeMrqeaLzJc8Ph/M/I9/+DiWhh1aY=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:43:25 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::7a) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 07:43:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 07:43:25 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 3 Nov 2026 01:43:22 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: add a debug flag to disable the userptr size limit
Date: Tue, 3 Nov 2026 15:43:12 +0800
Message-ID: <20261103074312.2467826-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d08ec33-b2af-41e5-98ef-08df397e247d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|56012099006|11063799006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: f/+VeMaDIHBa79WAH7l8XgnoZzt4Z/94bbEDVl2mS0PsOOVFE9jPw1uUV57YOXz7ZNWuj2CXzcDRpgXyrqNVdfdHp6EvHBrJiH+Jc6tnmu3XK+i0F3aoc2nxJYH63i9aOdiUCOpBKKO56sJIEMJswYNR21lcvDRcsxVgJKeVtz4HdBi0w+Mbo+2ERzVBrXbY4pQF47wM+qhE+37m7pMXQKP+mowrrne87bRVM6hW5rHd551vqmZYD9B04nnHKDj/1DIT/1/XfX5hSn1DpmsWgzWZQzoBuVn7KvXGTjHnQZr9WbY2Vp1y98hSlzxaQdijgpaqJGvActzHjw4aqaqS7pSw1DjRmLHGLvtWVdqkWEzgfn+E/gn2gH43U6xZbLbIA1Wt/Cx+wsgkGB/B6t+OI7rRR0Vl+PET6vN9lrYGWNq+OUKbwnn+JC1xdCUi+GIhap28++aNs0gnKUlvkTRYoriIyEB9TJAGmr16JSJOXPsoMG3KyXB6dx5nFKiPtGxbfi3yTIRCcHd0cgcwki/F1pvJyTd8e9eE5flh64btU02/esAa7hZ7xsQc4FUCjYxe2HAiWPVP10Vy6a9OrSJgwW24UNH3YLcAseLW1KXWI0mgyLf+e1OvfRt9M5sIY+drZpKClyV6wdnJaal1txFW3TvBBLGn8DGbu97DFBZaf+xKdObWGIrl/NG2WbnQZFMYMPr3gFn01Vl29z2vxBkeEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4xom0l7mOZPZ1+ew7ZS/baeFScuLIB0fqnLBvOkIUlUxGFDLhydiD4WAcNMj+k07cERyV+NDKLNThk2p25qFdHT+FOfUtOQa2jctsw8EOxW63mC7r6lJ8UnDLk8wmJqQAlNF6TsXu8LUNlnOCI14dZqTAKyeMJq3hZn84+5dRWX4JdmIjA8/sBJ3eNlNA3OyGNt0md16sQOVa1oJ0hcyFfehjxVQvs8Jy7OrEgNG5CsaQi+9yIzXwNUqloKHVPPihxJqCi6jJUGUhp1w/Z/85F+PbcLXlWVsSXitwxKRFbtxuEa6DfKPT41ozV3fuh6xMP6SDjm6uTVJh+XSdkH3/Qlsxt9VugfFzEOW31F2smCCktl0uYrb1OYZVaek3Q4kHmf1Ye4EZKrb15t+muxBhk0vLWsrTJQEiiK5sIuL7/rZaZf4UziQXCoYR+iAIhi3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:43:25.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d08ec33-b2af-41e5-98ef-08df397e247d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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

The GEM_USERPTR ioctl now rejects userptrs above 1GiB. Existing
applications that register larger ranges fail with -EINVAL, and the
limit might need to be adjusted based on customer feedback.

Add AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT (amdgpu.debug_mask=0x4000)
as a workaround to lift the limit, and print a one time warning naming
the flag when a userptr is rejected for its size so affected users can
find it. A zero sized userptr is still rejected.

to disable the limit:
sudo modprobe amdgpu debug_mask=0x4000

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b..0355af0433ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -959,6 +959,7 @@ struct amdgpu_device {
 	bool                            debug_enable_ce_cs;
 	bool                            debug_hibernation_thaw_resume_gpu;
 	bool                            debug_disable_ip_block_soft_reset;
+	bool                            debug_disable_userptr_size_limit;
 
 	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5e0029530b79..ee5e61718151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -150,6 +150,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),
 	AMDGPU_DEBUG_DISABLE_IP_BLOCK_SOFT_RESET = BIT(12),
 	AMDGPU_DEBUG_SDMA_RB_CMD = BIT(13),
+	AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT = BIT(14),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -1092,6 +1093,7 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
  * - 0x20: Enable experimental resets
  * - 0x40: Disable ring resets
  * - 0x80: Use VRAM for SMU pool
+ * - 0x4000: Disable the 1GiB size limit of GEM_USERPTR
  */
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
 module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
@@ -2345,6 +2347,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: enable SDMA RB command switch\n");
 		adev->sdma.sdma_debug = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_USERPTR_SIZE_LIMIT) {
+		pr_info("debug: userptr size limit disabled\n");
+		adev->debug_disable_userptr_size_limit = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 348693023563..77e0e063147a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -567,8 +567,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		return -EFAULT;
 
 	/* Userptrs are for temporary uploads, not a general memory allocator */
-	if (args->size == 0 || args->size > SZ_1G)
+	if (args->size == 0)
 		return -EINVAL;
+	if (args->size > SZ_1G && !adev->debug_disable_userptr_size_limit) {
+		dev_warn_once(adev->dev,
+			      "userptr size %llu exceeds 1GiB, set amdgpu.debug_mask=0x4000 to lift the limit\n",
+			      args->size);
+		return -EINVAL;
+	}
 
 	/* reject unknown flag values */
 	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
-- 
2.34.1

