Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60EDFCB619
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530EB10ED69;
	Fri,  6 Mar 2026 15:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R+5oqqFz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC37910ED69
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnS0IWODtGaJKZj4n82RFZUKDoBO5merl6+zzIYExsc3Ku2OkzHFFeRHLGFQ56EPEn5kIAbzwql3NPn8ZQe1XEb3epudjFCft2IRZAu1q/7zqSUwhC7D0URvNA+avcwfoD1qYH+vhqinX5zN1PHio5IAZZQUAWoIUo+ryOrzE6f7iRxjDIlX2vIXf7X0Td2WSFKbGDJnHaec9s+ABcv4/YJsANuastXXL+u0MzVNKoLai9z0kaXdtI9TccNjrcrMYBE3MRtZeMfHEOXyIs6o4sJIXFpC/9+Y00ftsScHbqrvfTCFSQV8tGAf7dycK6s8FVZeokKzjFJWp2/0/jbVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCvf5xzT2KbBWwFKQebobTD+rP1hlWc5DxjbP2kUYSY=;
 b=CsBFQ/BXHxk2kxhvx1yfEmiEXpmbbosq1k5JGb0LjAlgTULf3FJLnvi4ys2it+zzttyokmB51zxXeb0/1wdOhnZz5s2/j6xRQtbfQCi12nSP8uYn1eqUikK60N5adBTRmVP6AwjDtT5K+0RB+Yj/ogoWur4a4vIt7+dKhRHWXOGgUtwGkZi3XmoCzF+zV4euI9KL95mw5fyS85BTl7AS42y80dHnO+p1FZwupE8EEEqqC2nQVdKSqLkt4MuGED+FfzDDfHNuk8zC5DAHSoJpripJxBBq8jIQSuyw+7qJKHBN20OHTIWtOwJ3LpoSqdj4/Ih3ikq/sDKtNheXf8RtHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCvf5xzT2KbBWwFKQebobTD+rP1hlWc5DxjbP2kUYSY=;
 b=R+5oqqFzGK7efQTQa82sIt/UK1mFjL7gKSHL5V35aUXS8OYsOs21tcSRlvocbit+wGSoZzaF9c+Lv4EBYrSCFluMqPSM2qaxu0Dgvqc5sszD6/DNiSEm3LLIgcVXksZBB/qUUuy065Tok1A7b9FdMKvYHJRD0/b6L+YL7itlGAY=
Received: from IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::7)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 15:40:28 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::38) by IA4P220CA0006.outlook.office365.com
 (2603:10b6:208:558::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Fri,
 6 Mar 2026 15:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:26 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable rlc fw info print
Date: Fri, 6 Mar 2026 10:40:10 -0500
Message-ID: <20260306154012.22525-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfb4e22-1651-467c-eb2e-08de7b96b0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: HzCnImh6PllgprExgFtcjS2Pd+aF2MH6smygHOOj1OO5wFiZem+7n8UONJ192CZov4J2rwZRP03JgUv79J0Tw8I1yuGllOISOCYWj3WOug7G4VLfQoyE5HhbyxqyhYUdzXji6/x2fzkrzSlx1R0N9qCY47IVzf0btIjnriGbItIxlmLEelHnCNmPJHZp9etQ4QHfcgnU/rNYQAxJoHdKXkerrUgf2uA5Guz/N+fb0aD4TzrjjscwkA4FpiLKq9LTzwyvKgPjXWc4QLjyGey/Z3S+CYeMBg1yqg48XpptDxM57r7PYDpsaelBTFFUBOnG9qLKQ5a1pBJ+qz/qCWEvJJr5ycRumI7QjmdEoWTIoZF6YCDzRhcvC/x0VtozqNNZpODmoAo4ME4ua6m8T9s1HFD8YOqw/zy2Tft0hc2X2PbUYHBATEdUZMdHbufSEZRuPK/Uuv3jcd84MHOu8qIAxXR7V9fJwdmZ1+uKkMzg07ihBzW5Mm2ogTx2zck/foz5z3fqgMKY/SoY4Cf/76uhp4lunA61MiPVN2UDrh4LKoU4pa+TG3juESArDDSytAXk15a1bjzkcR3Xs/yemM4CoIH/tvLF7mzqqbvMzdf3qF/2b5Zgym+hzTAMnljjUjUmEbj70ZD/onHaxtydXcYJgnDbDlkO0lxAeA+ddpANJiNCUTlaERrwNgDBahAP/mTMRQClXpZNOEALmeQlRnzHgre4VNxJEcCPg8Qy36Sso0ed9L2syVVjGpX2BwkYOtnoq4wDpc6CElTRESxDgGC4Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /jQ53T5cOnVP9g50b/zlbqvSbT8D/8d9wHCHt95Hlt0WLyTcBb5d3ehVmV4Iqw7IRBx/jj9FQy85viYwcD3Ex48Ww3GK2D/gQkdE4XOJa6scAIW+Dk2uAHD5I/LCtonVGn7xVZscVvfg8VM+Y+UaqL3uXF7F5OHlrpc2Hj7UP9JsSz+kayOcreM5pT33r1phognsBTL91UrALmdFSZlsgLyMhye69JTGQyLQZklcyWciyJ1zUYFjXdrmBguCtxNVhXZwsStvZn5VFfFcpdrVB1JsjQ8ZFYKCCoePA05405PTN4k30w/l+Cyxg8FHdxnkNApzMVFW5R5ZtxU/+PiqUiVtR9NMhIPwrmtkcLHqvGWQ2bk6uAKQsbYl2DRLkjd98wF2mRcpRdRJ1b4jNjzsud7Kr8TTMKSVF53fn1tsa+enMGp0Vq8MSY4co/nymKTE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:27.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfb4e22-1651-467c-eb2e-08de7b96b0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

From: Likun Gao <Likun.Gao@amd.com>

Disable to print RLC v2_5 related firmware information by default.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 1ab61e7b35db6..82333aeb44530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -291,22 +291,22 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr)
 			break;
 		case 5:
 			/* rlc_hdr v2_5 */
-			DRM_INFO("rlc_iram_ucode_size_bytes: %u\n",
+			DRM_DEBUG("rlc_iram_ucode_size_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_size_bytes));
-			DRM_INFO("rlc_iram_ucode_offset_bytes: %u\n",
+			DRM_DEBUG("rlc_iram_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_iram_ucode_offset_bytes));
-			DRM_INFO("rlc_dram_ucode_size_bytes: %u\n",
+			DRM_DEBUG("rlc_dram_ucode_size_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_size_bytes));
-			DRM_INFO("rlc_dram_ucode_offset_bytes: %u\n",
+			DRM_DEBUG("rlc_dram_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->v2_2.rlc_dram_ucode_offset_bytes));
 			/* rlc_hdr v2_5 */
-			DRM_INFO("rlc_1_iram_ucode_size_bytes: %u\n",
+			DRM_DEBUG("rlc_1_iram_ucode_size_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_size_bytes));
-			DRM_INFO("rlc_1_iram_ucode_offset_bytes: %u\n",
+			DRM_DEBUG("rlc_1_iram_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_iram_ucode_offset_bytes));
-			DRM_INFO("rlc_1_dram_ucode_size_bytes: %u\n",
+			DRM_DEBUG("rlc_1_dram_ucode_size_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_size_bytes));
-			DRM_INFO("rlc_1_dram_ucode_offset_bytes: %u\n",
+			DRM_DEBUG("rlc_1_dram_ucode_offset_bytes: %u\n",
 				  le32_to_cpu(rlc_hdr_v2_5->rlc_1_dram_ucode_offset_bytes));
 			break;
 		default:
-- 
2.53.0

