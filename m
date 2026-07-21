Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368FCC44529
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 07:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD21310E2E1;
	Tue, 21 Jul 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FGs+IIoP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B33310E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 07:47:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdD+9ogK1PmkPBXKY7P4cfWSKhlcvtGTARmxvLQkgfJGZ/gnw536CGKyAKzcexkavkWuPZ+zX0dONRMFuGxA6w9GW3X73vsWi6zSfTCaC6bsJ2cpV/kRNWUljNpV8sjiWHzgpU1RTf6rgyACqD4cpgEFm9Mu0KFmOxH/woMTz7wvpr6miPnFRNz3E+1DHJB2vUA4l/1WP0yeASBa13i3DfGGe4ag2Wj+7lyK2ZSUclgHJjopmMkL36bX0b6nJth8BzOyjJFhuqVfweZN+5uKI8hNuBgNnDjWmGu6zLmSSlRuq7dt2dzkYGOdfdbd7hM2FTZ281xGTPV8IL1DPabvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBngsk51EfJgPIFWaVEqWEuKnFKTGpjEDsmkLNtvxGU=;
 b=t71C8SdcdgjbHqlDpXWJuVpEyFVanCZBQ60zwgFvdX6BpgJ0mxsezUIcsRpAI01SYZIJw04vj/BHP0fFRUaheoNCX1ZH7BWvr3wN6G1Q94TwF1RkrwdC9cbCgyO1paFS3nXNMpGGNA1LCxUDKxveEV2wouRQeZ6uHp+oRq5Tk4X7hwupIR0PbvtXs6BlkbGnVF9n0Z/pfRL02q9mo94ZAq4CL9Bs7ykMVNEqfhIowZqrhOT+JZQUCQvNNwxu2oL41692Qery2GTiLIV1U7KtHeKCTD61d9lHQ2OFv7+dn1HfbYxt2g/7zdinZs8NSQf2eq98jyDgslL9pxjGqLFeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBngsk51EfJgPIFWaVEqWEuKnFKTGpjEDsmkLNtvxGU=;
 b=FGs+IIoPNJvm8KVaI2XPo6IvsP/uP/F3kkaMJZHTokZh1+5zFcCr24xU9/Ksvzbq7QvKafh3p6jElnyDGTKs+zY3+GpcoRb0CSeGp3UyHLR8pL1dl4mTmKTdg5cIlALNufG3oYU6H2Br8/H1aZO1R8QM0bwCgprRk7XzIWymesw=
Received: from BL1PR13CA0305.namprd13.prod.outlook.com (2603:10b6:208:2c1::10)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 07:47:54 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a2) by BL1PR13CA0305.outlook.office365.com
 (2603:10b6:208:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 07:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 07:47:53 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 21 Jul
 2026 02:47:52 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/1] drm/amdgpu/ras: use vram_base_offset for UMC inject
 address
Date: Tue, 21 Jul 2026 15:47:37 +0800
Message-ID: <20260721074737.635912-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 47983c93-84c6-4615-d1a5-08dee6fc5f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 94xMtoLzHT0nsnH+KTkXCh695bLsftvOinxDc8U2FHKI3J/tSNjBU1C9VLppIPVOPE5HENvne/n5AoaHq8cepJv6WAnFbD0fMR7r7tVZ4OK1lVj3GMBcWZ9mjPsTYokH2aALWSFMUBr7HOLbvNBVTLuWCpPsa7+NoE0/ukyd3lc4RKtg+vkNHEH9anm0jgJYhBjRWfpscr7WfBjAqpOPr4+6FUfBNyu80MP3Gdk9fGIzcjZcf8GG3cyKpLfoGbGn/joVGod371AGn0SARKBtm+XFSJnqIhufva3fKTLjN556uvs86U66o/u1bTRRMOFyJDN4pKnD4KsPzZK2OgeZLjWtHBaxNzt6IZ7XnYNRXaVhgoXxeUXSxVqVD7QgP47p1ynu5Rxauyt+KsfWlr1IsXVgEc5ysVzQkKXIY3odlwrsk1DDCmsIROlkL0JJ++4vNk8GGtihpo7CZIhBGxwgPdDc1aKZZFiK2Kw+AIhDJn83wMfSsDZZ2CbAN9uZdIodEBSwpDmsj23ik4pYMNx9WTwi68CBntbHox6lqvP4ZuiwUPbHrIXaJx6JdzQ9kM3oj2+vfoUMWXFmXf5zV+eTUK+hFMklcaTp26fNEXlldAg9aCxuUmM37pBBH/w6FmIRPLjKxHtYbi9HVsSUPD6gymFyfLZ0X+iueNcLh3iOi2mHRYXoiEszY7+IRaFePp8pQUu7zoT2RrHhD72ZJTCfEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pRXoxBqIDhA7nINvzKbPoLxuGg0s93h+70GYlfmIMXEE6OrIoYthrHSlnfMf5hi/X28nDp3lV2jx1CjE8suK4qgbDShgF6KibJxTnwsxxu56kbAEaulE6Yfc5/nGPjYL6So30JsB0SwSVanzXK+M49pY2shk4dzQsMFALuYNpeTlbLDOZIpJhft/nNneb89eCLpI+gdIpmDWHi3qo9ce47Y4ONzE1rfDMRvTcATapspUil12FEkJQ9YYPGOVdHQ6S0kJUFUULEF747lagym55ijxp9D0q98ArFU4LB3uJNp2vuXJyuzEFL+RWJelyuKN3DHfHnvtiHQe2wa/9Md/3m4lep20nwcZ22ikIxQC4t1E70htr3mg1o5gdnmQ/oboGPNDYh1DZvEsNNUyyrZBoh713loIgTqspDSIyQtIfe0GLFs9+bZFS+L+VvVBtKE6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 07:47:53.9820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47983c93-84c6-4615-d1a5-08dee6fc5f6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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

Cover both XGMI hive offset and A+A platform MC FB offset in one calculation.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c    | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index c28ecdb78e4f..b5fb667df5e9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -76,15 +76,6 @@ static int amdgpu_ras_trigger_error_end(struct ras_core_context *ras_core,
 	return 0;
 }
 
-static uint64_t local_addr_to_xgmi_global_addr(struct ras_core_context *ras_core,
-					   uint64_t addr)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
-	struct amdgpu_xgmi *xgmi = &adev->gmc.xgmi;
-
-	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
-}
-
 /*
  * UMC error injection is dispatched by the RAS TA using the injection method
  * carried in struct ras_cmd_inject_error_req. Only the "coherent" methods
@@ -157,9 +148,11 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
 				return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 			}
 
-			/* Calculate XGMI relative offset */
-			if (adev->gmc.xgmi.num_physical_nodes > 1)
-				req->address = local_addr_to_xgmi_global_addr(ras_core, req->address);
+			/*
+			 * Calculate XGMI relative offset if in XGMI hive,
+			 * adapt to A+A platform with mc fb offset calculated.
+			 */
+			req->address += adev->vm_manager.vram_base_offset;
 		}
 	}
 
-- 
2.43.0

