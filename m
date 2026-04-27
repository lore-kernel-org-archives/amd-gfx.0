Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64E9FF8869
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D6D10E7F6;
	Mon, 27 Apr 2026 16:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D07XC/Qn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD7D10E7F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR5I3jqmdeWuswsd1LP1c/xBI7NwIgfRUShJdMrwajirYQgMmITcVHkhF1nIR/G1d5HZJ13sAwBTd99ibifd5UvXBVPb1uHQw6O9lYs3sC+QEtPw0OVTMs2zu1iI2iodZq5h2s9W/goOkU72iJbCPESR5qVPHtKsn9yHHBV24CNZQceCGMML61w4jVJw7YglDbQbKt2DNKdUUAOmNfrop6AditI61XR3qBXMn2I73NAYMaVze+VIBjfz20KT3JJzxXgtjYsp+rFpaqocIZnkX9/VCMbIUj7JnHz7EeYZMk/ij2lhQGQRuq24cbA+ZWVEL7DrfFxFQTB9frHPlcER8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7Oj/2yliWXqSSMHjjttcly2YyciuFehHxcpicTxc0M=;
 b=SgDM3RzMEYYMcJtvBAvv3ui5HqnxAfrycZcQ/f9H/DCN20PdVZecjG4SE0tPF3fvG8oaW4/N4m6nck365LMOO8N9h56dBoigHVCaOrF2WbogW+SSNNlNf/yQv2IJqBsCobzFMNLalT5M4rs8c3h4fqeyh1LG0waM/WcnJV0L9/Xz/NJQ2QBjWEIW8uesCxzyKOM3Z9kZewtocQrCxLCcpV3ThfLeq5M/SszLx+W9KAn9tbBmtN28JQ3JCpxfa9Kv6qjP7qssG/Z952Pl1PKNfvlLnkLvdshYkukxGgTPz7XXVQepSD1uWdeDUiUn22PNsq1fVLLhaDBh27l9ZscBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Oj/2yliWXqSSMHjjttcly2YyciuFehHxcpicTxc0M=;
 b=D07XC/Qn3Z25jaM39c6MZC1K+kmzWJ2S1/ShTS1Jcvzmv+iTiscWOQQgGk+oVjJRWP4vxxqERTIAtK4/GU0UN7+wXJsQGeih9KVD2s8BcLlV68T3NKzh6WTnbdudshlZ7iStM3cjhzFeIlKEWD3ypwshl4LPPa5wNKyAUohVJx4=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 15:59:54 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::f5) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:51 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:51 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 09/19] drm/amdgpu/vcn: set no_user_fence for VCN v5.0.2 enc
 ring
Date: Mon, 27 Apr 2026 11:58:47 -0400
Message-ID: <20260427155857.1370151-9-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0706d6bd-0c48-4aa3-b0ce-08dea4760441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g/F8o7/kxmsLA0yS+/IPAx3368RVrESUgod3aFuGRwXaUS7/JFP/8yyPmLtMV4+RYlztWSx54tlc+lWQqG5JwZAh0ChC9rudVMfagiVyF3C792KHIQsYtmgzpcugFz6f7NZDuvPeeJQuVgPU9+LCXTzrX8o4ircZ+2BIAVGeGslI/d28ilPsc6kDfvuRj736Ev8wraaH0heMENr7M0921GjoAf5kVxMHCsUb52LpCvZWUeglloXhM8tRz8vozvTGwntFnnmzoFnZE308vyR/1l3q7qTr0SUHcsHkbfT3vHAfk+DLMpWSXD69ViGr+kDiEnh+/LZoIT30GIRumAdEUOevsOY0RIkM0P4r+Z/pMle/hL2R96C3M8BMc2kM27HSKgW7PemskPVvVjgZEFymuOxHJ4+YhuqToF8L1pMiFQde1wWQrVMo9NFYTVFrxg2ypMEmvJawkYJeOP+PQNMnAn4f2HrLT71ktV0EnpWyRWgbV+GencZbsxzfNG0jtDfkdVK3AW00SR9zyTPkusF5gZLWDuNFIzZ7LQsSS14A3R4P5dwlmGhjBbaJxoJl/pSLp4B7KDsATtKO6URR84i5sTV1TOlYeAclau/2HROZj5j+SAA0OM+s6O/u362fdrkmjBbU2Bu0sUZ4Ad51WmP+ROPS8x7Z5AhQcjOgkbiE8u4xYNfVlMy7GV3mmtSyWHLCMgiWLsPnTX7ssjUSg9bzwtXik1N+YqVBC1pjkZKV+hxGm6+3dIF/nLRntkBdysl0vGyiyHdLSqeKrmMLWYe/2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lGnzzXUMt1X+Guj23YGhpgOekWrDX5Zu79Q+4NwYwsStSTDIjfSDhOQtF3zuaBSF/3zh5ls2sCevszIjCztRTZqTkWHkY3t35k+6l28mZvqSy6zi9bl2v8yGwXzsHcnPaRO8203yMrmB7egRfcRhOueU+QFoFr7v/JovY1NRlZA7FJkItdFYOR2QIkIG9Zrdlrs7qSR32i6zFqniMTOxNX7LSjwKI0T5W+BLj8MQl75u1MCoZN9CrzpUCjfJnZ/jpFl+mP5QhdMu2psaYNgyaUDVWaCa3xFvxNm6650in2JiAJM3fSz4hvTkR+HmwxPdT1daeRMVdN15hd41p0L+WX0ZMxDfzCtDGrimKIc3XLnC3Ae9rAtUNRiL0tVfGo6sD7XZBGbrZasOATIUI/sBzmWMrIq+KsrFAVQ7PphnCDBm8128h5IUZQHlVk1WxAjn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:51.7270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0706d6bd-0c48-4aa3-b0ce-08dea4760441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 8956ae2c343f ("drm/amdgpu: Add VCN v5_0_2")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index c3d3cc023058..bbc172db91a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -994,6 +994,7 @@ static const struct amdgpu_ring_funcs vcn_v5_0_2_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v5_0_2_unified_ring_get_rptr,
 	.get_wptr = vcn_v5_0_2_unified_ring_get_wptr,
 	.set_wptr = vcn_v5_0_2_unified_ring_set_wptr,
-- 
2.43.0

