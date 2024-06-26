Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70B5C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 21:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CB710E27C;
	Wed, 26 Jun 2024 21:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uU8oCeiV";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC3C10E27C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 21:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIb6yl/yr1yPZZjDtbXi5t5fGqGt7brHjTF3MQB3F2KvMZ6LcLpb9x0wxyENB5cbO0+WvAyl/OHwxziU/SYlL6HmUmg/clL0l+MRw6z9gfJhE7OjObPsKvOD9z78BfKrs1Go47O6obW3RWiu4LPVmdQMoie/4lOEXm/XeUVx4JVXnFvXL0ILLENNUhle8oEokV/BTnLO42MAh0gIC1DkEzTDJvjQJmHPzagPYEuhSHKoYG60VjC9Kmz+MQ8ot8LPE+OgD6SD758vyerpeo6wd/UQqO0PFBe/JoQ7AXXv4MeWnogxj7pgr2PwhEKC2+dv79TnVt5HmfOhSEVjTGq+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Wyu3VlFpVuu+22RDip/b252Uv5yyK1FXIwd5KvjG/I=;
 b=kg9BZrhwUVYngZXQGpZcis7yLr4Uehw6vk9WnKqyy6hvXKBWPYp0Qu/GhGDE3olsUm2qmI5FYUGCMePk9QwTSvu8Vs3DLdU9FuES40U2BElXJTpVH27+OItkXPvBFlMc8oFATaHeyMgwvXBC33a6B1+/fHdWDOiFxUPs3NWP3+OMjqxFObn8r/BLGjHZ9x/glD9o8z0SeZuwCAZag0YUHwq1RIIj2KMjNPlVeR/zGgQJKmt4eiJ3/w88HP0h4O73mSM/5EZwKPAnIL5DtaJ/EHZcbIHnyRPgXZJH91EFvFIGc96rlNWq2K3HVyXmDFpmYxPh/zH7Tyx75g97XPueOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wyu3VlFpVuu+22RDip/b252Uv5yyK1FXIwd5KvjG/I=;
 b=uU8oCeiVd+1l9HmdiW59Go/oZ9fv+62Ki+hx9Lofgh+x3TUqW9DVQsiNBT+kZsOcZhr91T7HZx2fjtsnAseBELEl3Wr6nhhFoF4SHheTLsCfogt2ApWrdyjSR2EvlUolvbwprOIVz50HEK9KbQrpKEt5ChYB7ZlBWP71jLTcg5Y=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 21:45:53 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::c3) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 21:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Wed, 26 Jun 2024 21:45:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 16:45:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: use vmalloc for struct dc_state
Date: Wed, 26 Jun 2024 17:45:30 -0400
Message-ID: <20240626214530.2008713-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: af72712d-a5ae-4702-e065-08dc962959ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|1800799023|36860700012|82310400025|376013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atuX145uYg/Rgwkhlui9t66L24shLAauMWxe00iP6BGTp16Pv+qO7SrUolTT?=
 =?us-ascii?Q?Or/BTNeTmlifSPXLVWgA/xFLgg84SiHMkU9/RQ0VQg/j8Kl9o/JDWOHxaPOW?=
 =?us-ascii?Q?HeII3gUiv/JO1k4N47MmuYoHFdCKZyZt3OeuSvik/mNAhf2MkEdEAs5r5wQG?=
 =?us-ascii?Q?wrGIxhLdv/1buxDYXL2ezzErLIK0lMRPCvRTPKqxGLNkKCsrs55GwDrMgYVa?=
 =?us-ascii?Q?CbgZs1sjWGailiGxR2sW2gttUZJSgHy12IifKNCbBQ2VP+68AftPqr9VEEVK?=
 =?us-ascii?Q?s12neIuvWufMcyVlZTWV5vpXDyjB/slA64BFbQPxiTJi8lqCe5VJW2MTz6qM?=
 =?us-ascii?Q?UXXXfTX8CajRhWn/ce8l6meoZiYm4cdqeo/0HIB9hUMsH+zIbcWmaD9Uw8yP?=
 =?us-ascii?Q?lpNqY2U74hNtHwYuijRAFn2nPxBGrNijOHCtMcqfzkZTmzb2kLMJ7NSOuOe7?=
 =?us-ascii?Q?div4dwLH9sBycUIqwgj7A98VRVFS5t9zMieNQ4KwDNaMg4IyHbYNk0qW4uOc?=
 =?us-ascii?Q?hQ+n+k2cUSzGwfF9QxICVBBPgsqdT9ge3HQ6213OGUGKo8/B7IauRPWGYPFK?=
 =?us-ascii?Q?55p1CC/cDbuxrzW7B0a7OnMMxEO3xw7+psfdKacEK92yHFRwxzpG4boa064h?=
 =?us-ascii?Q?WKP27GB2WaPZmfYbg5Sj4s2XbPRFKBoEmOVzA1rbVQm/3+4QWnc7F6YMWeW/?=
 =?us-ascii?Q?gm9/1iLIrSyiPOjBZxdTRBebTdK4QJatMZkN+d8D+eTpBtHgrf4qkEg2OYwe?=
 =?us-ascii?Q?CZy3DFvDBkFPeuMvgnWcjz5a+DaO1hXGQ2Wx43SvrUMsGSiBDwogJg0OLPR7?=
 =?us-ascii?Q?mIFeTWeO7Pt8HKRXKlIe4gAvN1dVJJVFTTobB2yRvGJVFXFaxARqBp9hn4h9?=
 =?us-ascii?Q?uAOn+XBXWirX1urjvP0hsh+T+oOwujC39JGRwW9619e66Lsw2btnQjv7CcfY?=
 =?us-ascii?Q?zBKqV8AEebcUI3lAnLGj+RQ0VQtmlliaoAt3uWAuHwDQn4ZvgN4kb+I93aWe?=
 =?us-ascii?Q?AbVtnrZI4em8A648uLKE4N5+dVB3RE2qrWY7wAe9b8ZMHXTOyFfMylVLWRCL?=
 =?us-ascii?Q?QA8V//R0t/NhJCyB9jWKAkj1ERGm7q/FB/9vXO+shP7Ki+8mPQCEptVPaErR?=
 =?us-ascii?Q?Rrt/AGnKRk9JKech9vY8UnwGXgST1Mkg3f7Uj2AziukJXdNGpekbPJeEiIzK?=
 =?us-ascii?Q?DAH9jOzaWoLedgXNNcRGY0rPwZ9LiOHQzHKYpTUCGOPi/LBaRbt/BEm7Njsc?=
 =?us-ascii?Q?k4MNg3jlp96WGkcQav6kruf4+jMrbOZ4Up6SYBhPIxf7z0KfqhnaNSTi389H?=
 =?us-ascii?Q?r2/phAcbb+DbjfNhn/WPi+qyMftjzt3LkmZzB4KH53zubTIEcxIo4t1XEGNE?=
 =?us-ascii?Q?rOx+rac=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(1800799023)(36860700012)(82310400025)(376013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 21:45:52.5508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af72712d-a5ae-4702-e065-08dc962959ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
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

This is a big structure so use vmalloc as malloc can
fail when there is memory pressure.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3454
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5d4f831b1e55..080c1d5f7412 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1491,9 +1491,10 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 	 * from dm_state->context.
 	 */
 
-	local_dc_state = kmemdup(dm_state->context, sizeof(struct dc_state), GFP_KERNEL);
+	local_dc_state = vmalloc(sizeof(struct dc_state));
 	if (!local_dc_state)
 		return -ENOMEM;
+	memcpy(local_dc_state, dm_state->context, sizeof(struct dc_state));
 
 	for (i = 0; i < local_dc_state->stream_count; i++) {
 		struct dc_stream_state *stream = dm_state->context->streams[i];
@@ -1563,7 +1564,7 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 			dc_stream_release(local_dc_state->streams[i]);
 	}
 
-	kfree(local_dc_state);
+	vfree(local_dc_state);
 
 	return ret;
 }
-- 
2.45.2

