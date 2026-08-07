Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DA9C5AC7C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 06:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CAF10E3DB;
	Fri,  7 Aug 2026 06:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcgNFr7b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B4710E33A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 06:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz46ZST/O4JyHDNMaQSbMTwugwttOUsxtLKBpc+jQjtl86YwdZBDHEWuvbkdHdMFMdcQDPlGXIRXBBAdZ5CGxnXcUL4Vhr9WX1l/cUGwSKzcCqpvfMagGygwdR/NSB2lREdWGJaOq7OotGsQst9BZl8r9sL/NP+bNwv5COqcjMceykNsdGogMH38OEl0WLf5rc36oA3Qffby+blBc1IF1N3SxMmuna4duJTtf9gzoL0eFCGu/XjVNpqvwrwhVJI7hJ9mRHzQ0AaY8RO/etdfqtTJnFu0JRtVFVkMbOY227PftaeTK325oHnamhLHMU0n/qdTla58JxqQ8SHpuUo+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRhfCWfTiMqayC5kTKo7Syvs58v2EwNz4R0buRSb5IU=;
 b=v1O32XZ5BrFErzlXPGdly25xGTOXwC9mwWzeqr+rPu2w+TsxekbrFl7KLx37vcReIKBl2xi6dIKp7g4vtJAng6hPyvQcyuRi7DiMsmEJEaaGwCZ44bahqdHkJDFCkT7AFm7ZHvQFHHJXL74Ir2a48RTmOnI7ChbrXfJe8K+hUuFZ8hfS8EcFXnpuCnwf3r6VOAlQxRLz+Fl/weaByCPZx6HvDFbdJc/AAIfSLl7ROTc7Q2INcZDdoEClM1Je8bAz18t8LkhxW3vpECSJ/34nY3ZuyCNghCmoEbtpt364LM5obX3xy4VLGA1G+dhvauwshS+IfPZv4cMZo3ddxIrLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRhfCWfTiMqayC5kTKo7Syvs58v2EwNz4R0buRSb5IU=;
 b=vcgNFr7byQkyXyV8x2wRMqXbQ63i6cPl+eAgrh7XhxeYtrdps8d7SXV69LavgdnpJ9ZffgOylvqjf5SBGQJpTO8mGCutd5c/IsPYN2u1aAWIj30ejC8CBAg9iJXeIlkm7IjbQXUJC6Cs6jUy3kbeKuiAfpNPCadMepjlPT8EChI=
Received: from SA0PR11CA0187.namprd11.prod.outlook.com (2603:10b6:806:1bc::12)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 06:43:40 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::1a) by SA0PR11CA0187.outlook.office365.com
 (2603:10b6:806:1bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 06:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 06:43:40 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 01:43:38 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update xgmi_get_relative_phy_addr to cover
 single socket case
Date: Fri, 7 Aug 2026 14:43:29 +0800
Message-ID: <20260807064330.3070081-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: af03ba87-7695-4886-17cc-08def44f375e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: /+cU7um68scBWVlKd8Qc4/VDptSRqFWCmQpCuG+PUl0GQxFSm7APxOLxLDi2WIIIwAl3CLwudlbDKYbxOrMDJ5Ftu5R7pQX9dztkBIGTgsq6eRof4nOURvx1CsyKEFN+V3Fq33JkzCfkZIQConOkTGS1zVIbEBcVVhHdPeL7+waiZ8Q9zBiVIelHdtL2EFkuAIAHnz74XRe2iEKBHl423mt/uK0tWwwJhdl41wADqNv6eqfmvl83kN2FrFsXKByZuYlJGLy+g0M4p4bARBmcC8UUs30oj9heshg93mIn2ChCeUXrfZF0ebRlWHjhYKrhAo6n/px0dUoLzWFeETQelMcszUiKoBtiTUIkAuQuGeVIp4lmyw0AFSHKDtIQw4J8nIyFwob3uiL+C0Iryha1pHEGjFhIA2nzbSriw/MTooOUkIOp9qzBVjnuEUZ7zdoBqTaBWGjIwYf3mXXPPPLL43OrmomswrvE9lPC5QleUpdChBg1vrNf3oN6SKFbertjDo39hd9RB+OThip62hXcZFZcRWUv6FJK0fiEI9B8fXppYNwYlpyPomCuzwakhJHybXBaVVBcAG0lJJa4Um9EkVd50mu6+weoh4RgOC9VkphGHLpUDJf4qXK3KH+VCThURf1hsO+AANgELPflefQSTrS4TsJwjU9LDKBdCf0MtGJBm1ZTsonhjWy1yaXu2MO3DMchfpmFZ0yeKLc2eXCXtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vjwn2ox3JeliJ06Y2uYyyRe5cr0CCog3jD2sglYqSeRUFZ35mhOpIIDrihnRGHBblGUYbzVXsA3hem/V7sGaJl8NYUdcIjSo/ZxrUpaROz1GhfSAegKc4SR453flIyrYxjKZTvZTvXEiEM90g9/f7LugIevu9vQue/spNtQ9Us5UPE5K7J0aayVPWz4VukSipOKvUrY4va48NKA0Kt2iaeaAvCnFFj4RHUA/OhsAZ2oeH8Ay2owg60Tr6HGdnEMvfAjQ++7PwrIsteVBzFUjZSY6xIRjUMd5yk+TayM14qqUZx0X8yljJfwsLRzYDPWYGBVARuga29q98/qzw7PaU0imaUsFjn+Q50DAYw6ZD+IbF1/74zJJJAfcz4J3lrf64c1VRaqdlaMRIYKRgBWP7mL8ggoiQp6iFTrDXunn2ICpIocckLMLIpV+W7PW4Xv9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:43:40.1017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af03ba87-7695-4886-17cc-08def44f375e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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

For single socket, the xgmi offset for memory address is 0.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index c180c35e3622..9df32785f365 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1249,7 +1249,11 @@ uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
 					   uint64_t addr)
 {
 	struct amdgpu_xgmi *xgmi = &adev->gmc.xgmi;
-	return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
+
+	if (xgmi->num_physical_nodes > 1)
+		return (addr + xgmi->physical_node_id * xgmi->node_segment_size);
+	else
+		return addr;
 }
 
 static void pcs_clear_status(struct amdgpu_device *adev, uint32_t pcs_status_reg)
-- 
2.34.1

