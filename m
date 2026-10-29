Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035F606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y9RY1ytd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D801F10E256;
	Thu, 29 Oct 2026 04:09:45 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA6010E256
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 04:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3siVS/2sf61hUl4ST6XlrR8pA4zSU6mJtiMcdAgJgGeyLwIuEQl4/xsBBAAIY02Uw7nBss6mVvZg+eE6E+7WJbqhafX3mcCvruCee/cBdSffAnCAXDIHX36Ucbyl98jqVXORq9jeO2KVU2Z3h6NMiaqNxCwpvgKBOgsPPY2h/GVBBiGlYiyZEjlx9bNHbBwwMvmtdmNAGst1KwqyN74WNP4vZpO5v8/BeqRT0QGwMDBJzeKH/yy+bn/qEbjpwprpGlnnZcsW09YVYoKq40SQebmGsT7PcgithACvGIEvkM3c5xW3DYfjzKRpawWdjDFTaj32rCjOK7Vca5axhIxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm0czl9/JTMPO21Jt18WKC1Mu3S3eG0DctW5am5xpzA=;
 b=DdhlUulTSNnfbg5E5YFERyjFp5NblbfkS18afUkty1JnIqmbvvb/i7zF4LbHbFlCWUqlcvQs1YcskD44O/+OHxpXqruy8JNzbkcIvxwMP2gp+cz5tpCU3PhW0KgZZALkZu4cY5k89H1+m+3ofwYzrSyfepz//X3TKYzZTtXyuaVcL9+yvag0ix7p9sSk3IYLRVIa8gLe4wbVxDKi5wyjtljLXpbbO1qoO2HiHL43yQZfCPUAU0GOQAd49vvzV+yQBUXbo24J1DMk1Gc3zOy6tdfcxDRLJyUxfJY6F5BAOvrTu/YA15FyaHX9hVFOTHu2/0XoxE42M/68rpm2nF3ZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm0czl9/JTMPO21Jt18WKC1Mu3S3eG0DctW5am5xpzA=;
 b=y9RY1ytd5KAeWnUPZ47jJRBG9StH90EvtgMSwbkuMxhcacTZ/+I2M9xEXMU7eSv3o2kBnJ45k0FcWKMFyVCc8DEvHnMEefcBeer83vusK0WADFbhxyAaRR4VdYDDhcZsbfnm4gqSL7F47zOLooX9fi1YjIG+gx7RfhkvT7NlCFM=
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:09:35 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::19) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 04:09:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:09:34 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 23:09:34 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 0/2] drm/amdgpu: rework amdgpu open() path to function in
 sleep state
Date: Thu, 29 Oct 2026 00:09:20 -0400
Message-ID: <20261029040922.3911530-1-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: d54ea135-31da-4149-833f-08df35727126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|18002099003|261028144727099003|56012099006|261021123027099003|261026121527099003|261022113327099003|261022075727099003|10067099003|261026140227099003|261022105027099003|261009223027099003|261009221227099003|261021121427099003|11063799006;
X-Microsoft-Antispam-Message-Info: Kq9QT77xxaj9uG/5kupM7sfmI20aPeQl2RSD1MC9Q1JCU6vWYiJgAIROnZxzMPnHfksMmxuJ0zyNvv9u4DiLfDoNuAjkMEy628vsCtneLvTWbDjIcDBE3lYjeYL2KJQUWtYhD7VILXw9+sI6IiSC13mbWsSp/5Da3CW/hnb2mn9du+mn/GreLOA69IRwT6eXBXC5XVDH9S0IS/5cewXNQfSu9oSKKr6eFlRJIeCJkBlgUe9GqF2WEwRg2kU186fuYU+7oig6CEmMf0D7Nk3ccSecTkV+Lg3c77SNVkbUGW5m1AbYEMDMmkBqiOh1qjNCntX5Y/WktsDbaIAEShjv/+EO1VGfYY3BtgygcGMhpFqnLTc/FrKg+wsAOXltiONscRnXcC5Unqmv4m0xRf2h3N3acV0vWSbyQa+pkkNIDNbUjixIkM4w3OMNu3EfgxG8bFZIVsYNRb53J3ubx62wLSnQi/F7kQMzjjV8IHTDcw+poGb8E1KKyr01Y8egS9LMO+2HN7b7yZX31gGqLtHmrxP5f265J9mPUKPEFnc7DZ+Z3vMwcTwVY54zWxpQSJXb2TsTvb+bBIHUR5fPJY8tRlzK3BcJoCeXskSJKUGEE3MlLYKTHO3rydWJaygEEpTvqy8XadjI5NhVhKtzF3BJ9EreV8YFI2wVK3OLnIv2FePN6/SLA4uq0h11ldpSEvhKs04qI2/ActpvlSjOS45Kjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(261028144727099003)(56012099006)(261021123027099003)(261026121527099003)(261022113327099003)(261022075727099003)(10067099003)(261026140227099003)(261022105027099003)(261009223027099003)(261009221227099003)(261021121427099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j8JyKUAxVBRLfk6jSVwY+xabI6s1eI3hqUfXrD784LY28m70BVyp6Fvz0+i+Jy0mdQy80ExcTCi/T8mWLUMGWOznNY4oaU8+PI+twoiFco16ooSlTZawQKkLqiDewm4b354hfd/V9k495ArqR3PffP9DKjCHEbzeJehAL3t0WJQzlPxZUiLCgXi12fbOcmNMd/YSPn37zoTPpwq1ccH9H1Q+obWNAL1m+2v7LSRUZ2F9fMZlW1SR26AT4zZfAcsxR1zT9kj9gVrSo6UIU4YHbzwjyJ78FogMe7m+dKpwfAma40DlsJTYGbs9y5B5esM11J0D2pf0A7IAnUyGGomePJuMveBijwZtZBvrJTnC0dxc9i0ouvKGFdNqYMCVSrBJVtZaowVyu4wd2QHDh/xxqlNnXq9pQJxTcqDM87JacKkfHcFAJe7E75pvPsITmvYu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:09:34.9690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ea135-31da-4149-833f-08df35727126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series reworks the amdgpu open/close, vm, cs, and validation
functionality to allow for access of the GPU's CPU sided bookkeeping
data without waking up the GPU from idle.

The overhaul will allow a few tools to function without waking up the
GPU, which can improve power efficiency within relevant domains, and can
hopefully be expanded on later to adapt for useful utilities.

v2:

- Force a vm->generation mismatch by adding 1 to the result of
amdgpu_vm_generation.

- Separate validation logic from patch "drm/amdgpu: defer GPU resume from
open/close to first use" into a new patch.

- Change validation logic to not depend on flags to operate. Instead
relying on a vm->generation mismatch.

- Clear vm pts in the kernel.evicted loop instead.

- Remove the root_cleared flag.

- Let the vm domain be initialized to VRAM in amdgpu_vm_pt_create if the
vm->root.bo is not null.

- Clear the root page table on vm_init if pm_ref was true.

v3:

- Merged: commit fbbcdad4c7c8 ("drm/amdgpu: clear vm pts upon a
  vm->generation mismatch")

- Remove pm_runtime_get_sync() and pm_runtime_put_autosuspend() from
  open/postclose kms.

- Remove the powered_init flag and parameter to vm_init.

- Remove amdgpu_vm_generation() result + 1 patch to instead depend on
  setting vm->generation to ~0ULL to force the mismatch.

- Initialize the root PD's domain to 0 (system memory) instead of GTT.

- Add validation handling in accordance with amdgpu_ualink.c vm
  initialization.

Concerns:

In the first patch, amdgpu_vm_init() reserved a fence slot for
amdgpu_vm_pt_clear() prior to this patch set:

	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
	if (r)
		goto error_free_root;
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);

Due to my limited knowledge on how fences function and when they are
required, I wasn't sure whether I had to replicate this in ualink and
possibly other locations that require amdgpu_vm_validate(). Such as in
amdgpu_amdkfd_gpuvm.c. Since amdgpu_vm_pt_clear is now deferred to
validate.

As a result I left it untouched within those domains and used
amdgpu_ualink_reserve_npa_vm_and_bos() instead of amdgpu_bo_reserve()
for ualink, since the former is native to ualink and reserves both the
bo and fence slots.

This can be easily changed into amdgpu_bo_reserve() in v4 of the patch
if required.

In the second patch, amdgpu_driver_postclose_kms calls functions
amdgpu_uvd_free_handles and amdgpu_vce_free_handles. Both of which
require hardware access. I attempted to test this with a Radeon VII
card, which to my knowledge does utilize these multimedia
specifications. However, I was unable to get the gpu to enter BACO/BOCO
mode and wasn't fully able to test the path.

I'm not sure if it was an exception to my card or BACO/BOCO isn't
supported on those older GFX IPs.

Shahyan Soltani (2):
  drm/amdgpu: defer amdgpu_vm_pt_clear() to validation
  drm/amdgpu: remove pm_runtime from open/close kms paths

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 18 +++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  6 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  | 13 +++++++--
 5 files changed, 47 insertions(+), 22 deletions(-)

-- 
2.56.0

