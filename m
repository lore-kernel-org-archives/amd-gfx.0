Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8FBCC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 17:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF68C10E182;
	Thu, 15 Oct 2026 17:41:32 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0F910E182
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 17:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz4DN89pTXwPN0i6nMsDS7Adm1q1kft+AQyYtgqgXKGAG+Y0U5YCrGcT2tAOJ1Sfe4BrcvWeZsFc8nOMkyxnlfj/7w+PIsNiuopdTR/sEU+pfhuL9eVH3twM5SzSvWrcch1grPDztlQMpFIUZhP9314Y2zu6koAQm0IrjFvtXaqhdrKRbzk942g+cmgx6j0LqkkWsSHNzBNAYfOI8tU0isq3xW/b1/Jg3RRfntabeNRm2yjqNpsCUYfKht+lk10fgjT2SpKH5y9Re1P3ESc79hejHEEv6nKMoBYWSgun6xWiGi+x+jsiTlIAHSlKGh5Srww8q4otxepus3O8dklQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOzeIv0/aygvSfR+c+X3GNL9XVSL4zFeFzsJvWwBmt4=;
 b=gVp8flH9SGDUP0qcaMNjnQtBaGljlCvAIEbT3KyvIfnjhlQLJseq5rdxivS3TIr8PSc7MMkvcVfX9Ln7zIijozyEvLZ2adcED82itGkExdBlXdZldFAuDczL/YY5rh53ZuwOSuEdp7ut6E46OI4M9Qk1/9rVQbooGtzP1dTbSotHGcta4e9CzksoljH2QNutxWl8cAFLG467Bms0VGsEfbzJAfljAXS6e+JTUpzxRifdko9Xs+wpK/4JposPB68+g3cxxx+36XmIC2ElXxtVRVlMD+qeKtljqvJnSdabAtGVqIyvT/OOuP1m0KzNx2x5P7cLaVTiRlbhVtzkOvGnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOzeIv0/aygvSfR+c+X3GNL9XVSL4zFeFzsJvWwBmt4=;
 b=Xu2a5brECdQay4Qr0WMsL92GTd+oRjcwFJLpaLgmkP6LztyjcTPbx9uzAZ8Y4FspcsRHCqh23ui+v1DWiarBvJYhVSeGrTwfMZWsVxqAJfMTzHiQxwPUwbWim23oyk/HQe2HaR5oOrjeNLH2necRgL3EUxGbkxCU/JAu7dLNmi0=
Received: from BN9PR03CA0222.namprd03.prod.outlook.com (2603:10b6:408:f8::17)
 by LVUPR12MB999137.namprd12.prod.outlook.com (2603:10b6:408:39e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:41:18 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::7c) by BN9PR03CA0222.outlook.office365.com
 (2603:10b6:408:f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 17:41:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 17:41:18 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 12:41:07 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Michael Chen
 <michael.chen@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: pass watchpoint addresses to MES for GFX12
Date: Thu, 15 Oct 2026 13:40:40 -0400
Message-ID: <20261015174040.65493-3-david.belanger@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015174040.65493-1-david.belanger@amd.com>
References: <20261015174040.65493-1-david.belanger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|LVUPR12MB999137:EE_
X-MS-Office365-Filtering-Correlation-Id: 301fe8c9-39f8-4397-6aa3-08df2ae38510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MNliAW20wd9aIMPi9Nxv7+46X6V8hLSnECl5fR0u1823pc5LyMtRAkeVN0T5161NKngXnnR+7Pxz1wWY2D1umTVGe686qu0xE7ybGYLknVQXzE+5afxzrkETz6jotsCNLJg3JVFltW2kpVysCCKJWmd1o899lBtWU73xUUOUwRWY9bgr3dcp9CsG3qvpTw9NNrEdUcVpZ6Zv20T3twI18jLEDf6zQ/KvlirRMuQfg9jrXvhCi0NdaUN0ktWUrWVRkhEa9XH6O3LG2WAckFCU+8um+iWaZYJtQKRUJKJGBYo2NrzBwHrR7COtoMNrTXBCll9O6qLHuVIZW8kzAsmgaJh3YQjxokfrCVwzYl12h5p+VPa/wHK4zWiHaCs3lOIfCXD2DEqqiF1hGNVAGdkPz60nizxB/UiFHqaPHdIHWcmlUse/FzQ4DnsL4hwF135LlXYsAL5Ns/jJECmPjRI4X9v9vbWIWFeB2sozlIZNZs1S1rtLr7x++coQvAjPB5fTxRjmSKWJUzBeKzRfv8UlfnTRROUY0/XW3Moe2OOLRJyhmV2+SS50se7U3e6HwMW567uuv8j8rRcLjjmJgYBOKurK93JeQiE+JFUafBZsJZbjW8keQuj4/T13z8e+TGYOxKFIgCMpzj5n2K7iBS5/zeGxtv0ZQlZMGJ6N/uT+9hd4r0EX7I15BDSf5Iwy3TgluFlO1HdVxHGl+JUyPpxaeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3d2cyrSf7/+ZwHiRngu3lwQ8IGVrirMY5pkh3YSSyLyk4V7iJIkxCEeE51IaR0AnRzcV7OsBkrgRdrcuefsQQyFfFnNU18jYlXlu0xsQmSaw11mr1GOMXKIahmrPf6ldkQLPHEWNOlN6MINniel+ud3r6fzqwrwIv1qtBGJm5PUc6vhOMmirTz2C5V6fmqz2B2Hhxzwt6jBoXnOMtyjYwS5XgzrxZ6GkUq04GdcdueLIMunEO+s5liRvsNBL6U0+d4+9fNUPZ0dJ9RmnUgUaCUYOZljPae+72rP+PaEaCgChMYT1LzQd1D0oP/qgGgk/1r7uSFoj8lazNBXIGH0v/XPMnjERmvoQOBJMKUNeKVWmhy5TlbewkvFPfclWiY2gvxlqDipbJtmWVTgVuHJ9eMZi3BaPoZew7EHcECPXEXWWErN8GZvqhDGu+SklaT5d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:41:18.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301fe8c9-39f8-4397-6aa3-08df2ae38510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999137
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

Update SET_SHADER_DEBUGGER packet with tcp_watch_addr_lo/hi fields.
Remove direct TCP_WATCH register writes from set_address_watch().

v2: Add missing code for mes_v12_1.c

Assisted-by: claude-code:claude-sonnet-4
Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c   | 12 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c               |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c               |  6 ++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h        |  3 +++
 5 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index 62b9db64368e3..004d0253f60db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -322,13 +322,9 @@ static uint32_t kgd_gfx_v12_set_address_watch(struct amdgpu_device *adev,
 					uint32_t debug_vmid,
 					uint32_t inst)
 {
-	uint32_t watch_address_high;
-	uint32_t watch_address_low;
 	uint32_t watch_address_cntl;
 
 	watch_address_cntl = 0;
-	watch_address_low = lower_32_bits(watch_address);
-	watch_address_high = upper_32_bits(watch_address) & 0xffff;
 
 	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
 			TCP_WATCH0_CNTL,
@@ -345,14 +341,6 @@ static uint32_t kgd_gfx_v12_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
-			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
-
-	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
-			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
-
 	return watch_address_cntl;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index bda9578c40359..ca82eac6035ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -325,13 +325,9 @@ static uint32_t kgd_gfx_v12_1_set_address_watch(struct amdgpu_device *adev,
 					uint32_t debug_vmid,
 					uint32_t inst)
 {
-	uint32_t watch_address_high;
-	uint32_t watch_address_low;
 	uint32_t watch_address_cntl;
 
 	watch_address_cntl = 0;
-	watch_address_low = lower_32_bits(watch_address);
-	watch_address_high = upper_32_bits(watch_address) & 0x1ffffff;
 
 	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
 			TCP_WATCH0_CNTL,
@@ -348,14 +344,6 @@ static uint32_t kgd_gfx_v12_1_set_address_watch(struct amdgpu_device *adev,
 			VALID,
 			1);
 
-	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_H) +
-			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high, inst);
-
-	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_L) +
-			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low, inst);
-
 	return watch_address_cntl;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 0f8b9e59d394e..fdb21739c1d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -981,6 +981,12 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
 				input->set_shader_debugger.tcp_watch_cntl,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		for (int i = 0; i < 4; i++) {
+			misc_pkt.set_shader_debugger.tcp_watch_addr_lo[i] =
+				lower_32_bits(input->set_shader_debugger.watch_addresses[i]);
+			misc_pkt.set_shader_debugger.tcp_watch_addr_hi[i] =
+				upper_32_bits(input->set_shader_debugger.watch_addresses[i]) & 0xffff;
+		}
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index ef81c5a23b9da..3c154529aff30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -622,6 +622,12 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
 				input->set_shader_debugger.tcp_watch_cntl,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		for (int i = 0; i < 4; i++) {
+			misc_pkt.set_shader_debugger.tcp_watch_addr_lo[i] =
+				lower_32_bits(input->set_shader_debugger.watch_addresses[i]);
+			misc_pkt.set_shader_debugger.tcp_watch_addr_hi[i] =
+				upper_32_bits(input->set_shader_debugger.watch_addresses[i]) & 0xffff;
+		}
 		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
 	case MES_MISC_OP_CHANGE_CONFIG:
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 3e214cb4f6e13..090c9142674e3 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -805,6 +805,9 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t spi_gdbg_per_vmid_cntl;
 	uint32_t tcp_watch_cntl[4]; // TCP_WATCHx_CNTL
 	uint32_t trap_en;
+	uint32_t tcp_watch_addr_lo[4]; // TCP_WATCHx_ADDR_L
+	uint32_t tcp_watch_addr_hi[4]; // TCP_WATCHx_ADDR_H
+	uint32_t process_context_array_index;
 };
 
 struct SET_GANG_SUBMIT {
-- 
2.55.0

