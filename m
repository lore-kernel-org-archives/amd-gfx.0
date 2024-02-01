Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF7C4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 21:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC1110E060;
	Thu,  1 Feb 2024 21:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fU5xkyIO";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D632410E060
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 21:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0tfqPK4gV30sZr3Z4F5LoCKk/826bT7pFCfYFb6rX/2OdzctOmyLEIUN9qU/Fj5h8KngzZQxvRwLwSwqC+fhpJWsHYt4ptn6pASK/aKhD3GeSRxHq6U8tGkmvaVbMHFhzO064BlGi81bMLiCTvmzEpy1fq+i8pCG2GF1LDnXyDHLnH4pyyoAB1AZBP2/I/Cyi6La0YOZYtA0AbfoRO9fSbCx6kzABiBnm0xbIq2Tl9H2/voKkex5P5gWshPyncK9AEe/Ze5Jf1Weyc++NU7huIU4ssVEVr+Ts9R1T+zJ83rp0O/heoU/JaMrTqw75p1cCwRKxW1APLv6he9oXtl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHN9UK/xAmh12PWmdkxTTfD1xBDJTm/xM6L4b7fIenY=;
 b=BYHhqUneIoeLkORYTMUMMMjXcFxolrpSEVs7v/b4jxnLOODf/J+nVm/eWGia8nLoOq4eMQkt0YeO22wAXBf0Vd1hcX4O3B4yqr4Ars2KzQ3phKPcWQszOzWp98i6xcItyMd1krt1CPrj8WfhGNLF0r882vPaGk0+7EFmVPX4qw7SpOyFNy6dtOjI74IthFSj2insthRfN66YfYqq47AcZRQjnUhF4ghpx4KJxLUDMvmkutkWgNBGdSXWdmlnic26i7KGBCpiCYmhJyvvK01zCIgiJTUeg2/cyTNyfK6wkmfZ20KBxs7hnQVwO3HKmK708bYRVQ5eO/YsMRHsUM9oSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHN9UK/xAmh12PWmdkxTTfD1xBDJTm/xM6L4b7fIenY=;
 b=fU5xkyIOfCr0m2taeiiwGBDpw6ZoaJ13S4U6vfelbQwPcYZkUk81yGjulWVKAHtFcPl2JPL584xWkCrPGRG+896NCvGxTz5+gU+4GSwagNlRy9s2Haz4hUNunxiE8goL2ocDk4MkQsi+/WijkHivfk/JtKyrprI5mZD8nYrztAE=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 21:33:58 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::6b) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28 via Frontend
 Transport; Thu, 1 Feb 2024 21:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 21:33:58 +0000
Received: from lmoriche-tr.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 15:33:57 -0600
From: Laurent Morichetti <laurent.morichetti@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall.six@amd.com>, Laurent Morichetti
 <laurent.morichetti@amd.com>, Lancelot Six <lancelot.six@amd.com>, "Jay
 Cornwall" <jay.cornwall@amd.com>
Subject: [PATCH v2] amdkfd: pass debug exceptions to second-level trap handler
Date: Thu, 1 Feb 2024 13:33:34 -0800
Message-ID: <20240201213334.1275083-1-laurent.morichetti@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c0621e89-8f69-7b18-92fb-37c91c678760@amd.com>
References: <c0621e89-8f69-7b18-92fb-37c91c678760@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 365dfdc8-5090-4b72-c56e-08dc236d7fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbxZ04V79pdWbA9kd/PDgPdiRC4kfROL4pcBB7wc3VlDclAHbcxtsRTznHYVxZO3Bbr+pdfiWsfh5Qa9Me22Q/El4ZjMKVEda6Snbp1UDJ4fHWRIGUa0LfD6nDa+QKsduuuKipmy2Rme+byt0TJzKAqfJLZgyEE3vPi0LP+CZfJOYPIFIqFUcPvIsaNJq/Gw0Zy9gzAO8WS8Jzp7cYMZ7LkxrAsauM9vyr8Vq1O9zowLkz0VjxduiGv30pUFCYGVu0mMvjgYSmwHxp9ocg7bxvKOD0PzXv01W6b9T/BXlXnM2SBtRVyU8RvcQwFDs69RbzH35e2mJ1M+PeWDEaxN0VYQt48RPequvyEV2is1Lz/CknGdHpPrM1z+i4iv720qNPBGJr1RivHIhWv7s2pf7reKKmEiNzQYNJK4PbXoE1sLo+k6dprf7wzkyOeV3o6IG38+lrZMqll6MOneSzO/5u/BniHgG1JOrlPUTK/TZW+hyLVOwlfQ9VaBRm9D3pviGE+6s6ylWxSZwiHkjBPCbtKmQyJDULT0wTxdF0EjSgDrf/HBFPireUmPWzOS/xyGg3J9JBJQD1wkRAVO3ODwBms43C2ld3IGouXZci3L0KHzKI0lReG5Fh+a5M3OzG5/QKkC/a3kmKCETH3VP1hIjiXEvjflRAzKBOstrN5qwZzeCglNzko5zvKgjLOLal/ZA2O3TjVPPOjKAHfOvIiwGPzse1dVMO8MUs293NJ3jBNc4swALVUAOkntR3q/OFLzBQU8CgxIYoay6fuKd/7ilA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(54906003)(316002)(8676002)(8936002)(70586007)(70206006)(4326008)(478600001)(6916009)(86362001)(5660300002)(2906002)(41300700001)(36756003)(44832011)(47076005)(83380400001)(336012)(40460700003)(40480700001)(26005)(16526019)(356005)(1076003)(2616005)(36860700001)(82740400003)(81166007)(426003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 21:33:58.0915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365dfdc8-5090-4b72-c56e-08dc236d7fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

Call the 2nd level trap handler if the cwsr handler is entered with any
one of wave_start, wave_end, or trap_after_inst exceptions.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h  |  2 +-
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm  | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index d1caaf0e6a7c..2e9b64edb8d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -2518,7 +2518,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x8b6eff7b, 0x00000400,
 	0xbfa20045, 0xbf830010,
 	0xb8fbf803, 0xbfa0fffa,
-	0x8b6eff7b, 0x00000900,
+	0x8b6eff7b, 0x00160900,
 	0xbfa20015, 0x8b6eff7b,
 	0x000071ff, 0xbfa10008,
 	0x8b6fff7b, 0x00007080,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 71b3dc0c7363..7568ff3af978 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -81,6 +81,11 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT		= 11
 var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE		= 21
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK		= 0x800
 var SQ_WAVE_TRAPSTS_EXCP_HI_MASK		= 0x7000
+#if ASIC_FAMILY >= CHIP_PLUM_BONITO
+var SQ_WAVE_TRAPSTS_WAVE_START_MASK		= 0x20000
+var SQ_WAVE_TRAPSTS_WAVE_END_MASK		= 0x40000
+var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK	= 0x100000
+#endif
 
 var SQ_WAVE_MODE_EXCP_EN_SHIFT			= 12
 var SQ_WAVE_MODE_EXCP_EN_ADDR_WATCH_SHIFT	= 19
@@ -92,6 +97,16 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x003F8000
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
 
+#if ASIC_FAMILY < CHIP_PLUM_BONITO
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+#else
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		|\
+						  SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK	|\
+						  SQ_WAVE_TRAPSTS_WAVE_START_MASK	|\
+						  SQ_WAVE_TRAPSTS_WAVE_END_MASK		|\
+						  SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK
+#endif
+
 // bits [31:24] unused by SPI debug data
 var TTMP11_SAVE_REPLAY_W64H_SHIFT		= 31
 var TTMP11_SAVE_REPLAY_W64H_MASK		= 0x80000000
@@ -224,7 +239,7 @@ L_NOT_HALTED:
 	// Check non-maskable exceptions. memory_violation, illegal_instruction
 	// and xnack_error exceptions always cause the wave to enter the trap
 	// handler.
-	s_and_b32	ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+	s_and_b32	ttmp2, s_save_trapsts, S_TRAPSTS_NON_MASKABLE_EXCP_MASK
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 
 	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.

base-commit: c4b562a17829454713e45219fa754be1bfda9004
-- 
2.25.1

