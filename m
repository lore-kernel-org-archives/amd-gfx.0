Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D09AC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FA06052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2FA06052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB146E0D4;
	Sun, 24 Oct 2021 13:32:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6B689F9F
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq2nz2zmIYT2qSBThaepgajQkJ8MUaz6Yq0lpMszR7BVGk4QwSbJ6qvgOU7SQv/EZvHuASqYfxQgNKJxfRB93ueUmowOSJyQOrlXQIxMfRP8pj8wztWi2bjA6WSsJz2fDksXqzeqsJaeYhnE1s6HcqphsHXRvkGMs5LPYu3pOl71cJpDd4gGrYQy25rM2fXWbJSPqgODX/avZfhHfz4fTJPwqtIRLsDiznEwhTYeplm/PGtipzJHKNUXZZ7StT63Ddh7YtKZ5p4EKMbU6fTguFXVytP96y3wbgxHYWkxQW2CnoKwAhOj+ACsTtWSgukYRQgjZG172/RTP+Ujj4NWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hewItNTGMRh4/McbUsxpDuWZgZ56fRuGjXVyJfQXFvg=;
 b=GXTE1mJw7kCLEG5y+cXYtgJPo4ko8pNFEz2WMzWYm7a3pbFLy9nslVZkBnyFcHG0tvv5p3Mo/458CkICi5oFKqeaCOfQFnyRclh5z0Wng7q9bgMf8EemhlrOElXhRCfZAwBI2PVzvyR7UuvC5I6BYjjJ73E/QuEQwIrgptug2tCfssMUV1oMzTwwI3SN9hWfXHiPfV27BDUlTPyG/d/qNUxATj4PEuyuLSUEK08dQoMQNa0n+TJvNgPxaBY3MHpGwPVjFAnFQucWcPYSSWALcQHj6MisPZnFc6Z0odruoxu+mnc0eTQ2vmmO2PI2PxpjQk8BLIG+XZwEvUKgg1gTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hewItNTGMRh4/McbUsxpDuWZgZ56fRuGjXVyJfQXFvg=;
 b=2Sr67zcetw+M0ywNucpVUSLkdAucWERFLY8yRcclXUc2f2nKEPoTRmgbzmbnQ7pfKcPPcnbrgI3vWXPlKJpljIZm3W7NXInTiiLIzN+wZm6adGho+s95X9BZSREpKp0i/7L8VwhzEZzlVUrNAShbrLaaabW0fVr2judVjzh5IiM=
Received: from MWHPR1401CA0010.namprd14.prod.outlook.com
 (2603:10b6:301:4b::20) by CH0PR12MB5369.namprd12.prod.outlook.com
 (2603:10b6:610:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:12 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::3b) by MWHPR1401CA0010.outlook.office365.com
 (2603:10b6:301:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:12 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 02/33] drm/amd/display: dcn20_resource_construct reduce scope
 of FPU enabled
Date: Sun, 24 Oct 2021 09:31:10 -0400
Message-ID: <20211024133141.239861-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c346fa2f-a773-4c07-ff91-08d996f2afa2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5369BC3F0372F3FE1645F8D198829@CH0PR12MB5369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhlxwRO9Eg6TbbmZZMlXsQ9GHIa72/GwoGn45s+fTuV4V8adAA9yJg1VSBOIavWFqdT3dFS4VVqA3XWCmr0gOSri2xsX+NKV33kOIzDMdMI36d+XWRmm+MAdUmY5vEv0kHPmhMk1SaIbIN/EU0RFbvixTFNbujI3GirjDfXeuG7z7RYgSDWLPQS1amx+VEXPw3Rr9Q2kHWK9WVFfhEgdSkQkfuqVtheZiUC7+5GeNb/6q0U8zFGb1HzP/4FACxeg/nDCnp8PCIGFpDTbBNWdMY/i6Nc9EtkK91n/f2XZbvAVpjocJfQrP/ZkW0mVyHwHyCOmEw5Gr3klKiClLJIvH0KxXgmwh2eNe+eciFPETiD0JelnnVk1s6WcfA7z+Usz1PEeuDEiowXo45Z6WKZFWMsSQo2rYqOpjV2P0hwnprmTDBQgZw3NznCxBJ5GR1DlczpC1dc64Lp4nOPDv94+HP8YUvtyOO0L+w7cHXGWdiuasABiVtZJVtzehflUIBNfEgDmtQ7/Ay8yx3StXt30YOAQH3dQ6UoQ4uKrki8urDP/HGG/tZwI/yLolTEq/U+ZkYBSvwAvy0G4LEPtMzAvSqIqAU7OqsHj5CF3S6m4mX6xP28ERD0cHqFwdxyFZ9N0sgrV4Nbqogj543zjayF3BiafjDrGonsGbrsvSNjZPsXxGkwvyJ5xblcnNkZk8Lnucp/JrKO8/fvf7xw3BoBpLyFqfyJMfKUftFMvEXMXBm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(336012)(6666004)(81166007)(426003)(70206006)(356005)(5660300002)(186003)(70586007)(16526019)(1076003)(2616005)(86362001)(36756003)(4326008)(66574015)(8676002)(47076005)(8936002)(508600001)(6916009)(2906002)(83380400001)(316002)(82310400003)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:12.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c346fa2f-a773-4c07-ff91-08d996f2afa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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

From: Anson Jacob <Anson.Jacob@amd.com>

Limit when FPU is enabled to only functions that does FPU operations for
dcn20_resource_construct, which gets called during driver
initialization.

Enabling FPU operation disables preemption.  Sleeping functions(mutex
(un)lock, memory allocation using GFP_KERNEL, etc.) should not be called
when preemption is disabled.

Fixes the following case caught by enabling
CONFIG_DEBUG_ATOMIC_SLEEP in kernel config
[    1.338434] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
[    1.347395] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 197, name: systemd-udevd
[    1.356356] CPU: 7 PID: 197 Comm: systemd-udevd Not tainted 5.13.0+ #3
[    1.356358] Hardware name: System manufacturer System Product Name/PRIME X570-PRO, BIOS 3405 02/01/2021
[    1.356360] Call Trace:
[    1.356361]  dump_stack+0x6b/0x86
[    1.356366]  ___might_sleep.cold+0x87/0x98
[    1.356370]  __might_sleep+0x4b/0x80
[    1.356372]  mutex_lock+0x21/0x50
[    1.356376]  smu_get_uclk_dpm_states+0x3f/0x80 [amdgpu]
[    1.356538]  pp_nv_get_uclk_dpm_states+0x35/0x50 [amdgpu]
[    1.356711]  init_soc_bounding_box+0xf9/0x210 [amdgpu]
[    1.356892]  ? create_object+0x20d/0x340
[    1.356897]  ? dcn20_resource_construct+0x46f/0xd30 [amdgpu]
[    1.357077]  dcn20_resource_construct+0x4b1/0xd30 [amdgpu]
...

Tested on: 5700XT (NAVI10 0x1002:0x731F 0x1DA2:0xE410 0xC1)

Cc: Christian König <christian.koenig@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Anson Jacob <Anson.Jacob@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 756f5d411d9a..001737487800 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3698,16 +3698,22 @@ static bool init_soc_bounding_box(struct dc *dc,
 			clock_limits_available = (status == PP_SMU_RESULT_OK);
 		}
 
-		if (clock_limits_available && uclk_states_available && num_states)
+		if (clock_limits_available && uclk_states_available && num_states) {
+			DC_FP_START();
 			dcn20_update_bounding_box(dc, loaded_bb, &max_clocks, uclk_states, num_states);
-		else if (clock_limits_available)
+			DC_FP_END();
+		} else if (clock_limits_available) {
+			DC_FP_START();
 			dcn20_cap_soc_clocks(loaded_bb, max_clocks);
+			DC_FP_END();
+		}
 	}
 
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
+	DC_FP_START();
 	dcn20_patch_bounding_box(dc, loaded_bb);
-
+	DC_FP_END();
 	return true;
 }
 
@@ -3727,8 +3733,6 @@ static bool dcn20_resource_construct(
 	enum dml_project dml_project_version =
 			get_dml_project_version(ctx->asic_id.hw_internal_rev);
 
-	DC_FP_START();
-
 	ctx->dc_bios->regs = &bios_regs;
 	pool->base.funcs = &dcn20_res_pool_funcs;
 
@@ -4077,12 +4081,10 @@ static bool dcn20_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
-	DC_FP_END();
 	return true;
 
 create_fail:
 
-	DC_FP_END();
 	dcn20_resource_destruct(pool);
 
 	return false;
-- 
2.25.1

