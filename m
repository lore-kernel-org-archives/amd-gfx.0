Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE91F107BCD6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 18:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A2010EC45;
	Fri, 13 Mar 2026 18:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="icgCCGBA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD9E10ECFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 18:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mutLoodUxJs99HxN69739txT7MYFBOs1GDSm9AAc5YO38RRmaCrqIER6g97F+dLAY0e6BcPt4yP3S659eXBVnYW99H1GM97ELhTfiWq5z/CTMS3npDsb1VtgPUMEHb79nicfZNHyilRI5G7UVZxFD7iIR4eLXSmfWvCHLIoMyxVNTk8W1+zTZxO93uncwmlV2kE4KubmrHZJFLLIO1lIRizxVkVseRxVz1HkUXtBokOj80xr+aYEDr4//hS0lY8UIEuc52ECJvrdFTxggjUR4PKCL1L+dcFwOvZeilHxRA96sGfuyD18vVi+RW9jftO4LL0UnclUfdKpEp1rz+jmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtfNYZ4/a10gxgY1xakXvDG82EEPKTwRWvaK1BR6J2g=;
 b=gjMhA+FA9fP58y8POjpU0ryZ+tT+OWemgbU6zA8L/COPhMJ8aoEmB8/ieeqzR/ZRuekIAT7Ldb9J6wyM56+RWYCU7J0quEQ7F+XdrdhSYds/tvKxtWeNpwBVVavjXVlw2USaAFVVd9FVcD4Ag/qF4HmHJ+PITJ5cBDyfJZaA4yskYWMwnGQ8I965qHAF7J0TmKuUxh71sDjCCIoEBI2e+Tl3kJCNO0S2elpSzcTJdXFuHSgrnaadmMDLoiPsrRrGzZnxwvkyGDysXybhytrXRNYtX7cnPdj9IGMXaDz8RuUY9r8lM00JfW/18TgRz7FziLa2Bp3VOUZxbB2K2HYc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtfNYZ4/a10gxgY1xakXvDG82EEPKTwRWvaK1BR6J2g=;
 b=icgCCGBAeWoR5PlTzVP6TiEtFfj5G7fz9vDYTwsGDigtqnXJ6hwMGERCWIqyxTkGHh7wa+IpHRcVWVtq+lrFCAZJiDsL0j9g4FYiZfSxmG7q6FaxrRA6MLbETozL7GdpnJLQeK/0lhiG3jjneMRW31GAXL/ksDAaghwOEVZXqWw=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Fri, 13 Mar
 2026 18:22:51 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::b8) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 18:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 18:22:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 13:22:50 -0500
Received: from thonkpad (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Fri, 13 Mar 2026 13:22:50 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Alex.Hung@amd.com>, <Roman.Li@amd.com>,
 <Alexander.Deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: Add LpDDR5x and new fields for info
 v2_3
Date: Fri, 13 Mar 2026 14:22:41 -0400
Message-ID: <20260313182241.171036-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fca4375-5781-41c6-7375-08de812d893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 26sNVcAYdHheqKYSrM6AoOL2v2y2a58diVtZ/EjsDt6eZl8RC8qTBTA3CUgZU4TPtOyZ7anzj7dvKTVqM1E5GbEZ5Iz3y3PzGAl1JydgmWwkd0B17utFzfF9cG6mqQ9rI9Hm6gyB78Z0T7tyajxQckJgOv6PFWkV2ACMkmJGXOHEQrSx77hFSb0MCZ/eU2U2LrflN53JA5OjMLniPVqgRJh9WmmGcBq3XFrq6c2OWhq0BpicTEFFmBI4VQLFK0WH9UOL/FoSFZBIb1Dv2qFY1N02G/Gl/nNAPkDbhmQvDLVF420Cbilslzh6FXO2eD2jO1pXQAnKjWAzdwQL8orgd3JoadxEjevnTn/t10C8e8QtTz7yadQiMyYOnJHCO46WBNHSd/odLVT9i1zG3VQdk+lFEGjnzmtddxLPlY4YywhB5tGGzuzZ0qlLx/dFJH13TdI7mgElFBRJXM8j3LCjoejGiqt1LDYV1d5PEJcwOfpz1rpo5zi2fRsqMK/B/UtpRN09+FSDGepO/Y5x2PDXgPVin1fbzGmmPPYTigukW6v5KnhPBtcWld/k7FKQE92Ilq8Ozm1A8syRrVBZ9TRqPtu6/zZa+zK1/m59kCXQxqlBhv5YuVApZ1kJy7rWk2xKXoit74jANWkeFLeS9m09++3mPZWe+aOC9QoVR1lvAqPJPeBnddhnpPVHq/E5FErQ4bvFkd8H0k9STy5TLAj4uVcJKIj25tf0kFvy6AnDvezWTqux/KT3ydiy+5H1k6vKHDUz3g9II7qzfxTf525JXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZUax48zfbnUgGljzo/6geRpiwldnmdFFlqW8b6+r1L1c+y6KBNtB4J2o+UoWu7B9473pXOdoAPAVgmHg8/vfnbPtwvsKGgmrt+GE0PQ+PUw5siAW9veZLg8U19O7Si0AMIi8SgT57yHrJLS0XOiOOcOx19DpA1DIWZZL9bkPIohF6XmWUeSfkaWQ/ybom+5En+rEFUb967++XRxuDUV3Rcuk0wZaKQwWSwRKkRBf+W+9sxDADI3qvuW6932rfUU2WIpnw/HkjJRQX5RBfxkcXzaKT0i5FpEqJDoQ4Rwz1xMV1/7/eiWhtxPgHmSyTqJeeqVV2lDo2xJliW4k0oqobmRyDEvPraJPqJonPtrrpmCDvKwbwneoi6K7DDRXS3LWgIsZnXE7ZOD3YBemLr9Zl+LCoRr3dsapacKbhkwOeyWdV0NdHkvJFYDCwfSphP9C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:22:50.8834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fca4375-5781-41c6-7375-08de812d893e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Newer DCN bandwidth calculations require new definitions.

[How]

Add new fields cpu_id and vram_bit_width for
atom_integrated_system_info_v2_3, and add a memtype for LpDDR5x.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 18f9642a42eed..62f7ed0b20667 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1695,7 +1695,9 @@ struct atom_integrated_system_info_v2_3 {
   uint8_t gpu_package_id;
   struct  edp_info_table  edp1_info;
   struct  edp_info_table  edp2_info;
-  uint32_t  reserved2[8];
+  uint32_t cpuid;
+  uint32_t vram_bit_width;
+  uint32_t reserved2[6];
   struct  atom_external_display_connection_info extdispconninfo;
   uint8_t UMACarveoutVersion;
   uint8_t UMACarveoutIndexMax;
@@ -1770,6 +1772,7 @@ enum atom_dmi_t17_mem_type_def{
   Hbm2MemType,                                          ///< Assign 33 to HBM2
   Ddr5MemType,                                          ///< Assign 34 to DDR5
   LpDdr5MemType,                                        ///< Assign 35 to LPDDR5
+  LpDdr5xMemType,                                       ///< Assign 36 to LPDDR5x
 };
 
 
-- 
2.53.0

