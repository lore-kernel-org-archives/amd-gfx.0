Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680DECC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 17:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72D010E5D4;
	Thu, 15 Oct 2026 17:41:29 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9685310E5D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 17:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XalIbQtT0qK1aqxsaHZzM/MjUWWD0K7cWFA8FP9QdqZOI1aPN98cU6DcvXMA16dmHoud6yZZm+sHdZ7N4/QE7bLVkZfz6IsI+h/qCmclleuFFJuWEZ0iiiSFGo7X39qHdWiwH2bUurMsoCF5UDXlsx/gB5h/2VRRcbuJG8KZiD9hTbUaI9kDRJovG8XrPBylrmQJ2I3X7xUN4X26HoudT4IwpOTFm+4OFSVcJi0cjr0RtZbBFGjd9JH0/Q8z15hLnepxfiexGJlNTi0ZHUe5ddEwRaEtOuu8SnP74YC6SRs42CqAcJr6MnumGaoy9HOwRw0n9d/FtQ8JrY83g4g44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV6PXrt/qClMrHspBrwRca7OKG5oxK9hxcDM4gGTcZk=;
 b=jMT4yLftCyIeqYKp+txkAZ34KBODinQujrn4USzFDqJ5QsefrnXJ3QKmK9C0HeSiMzPveKeEJuWOnTr265Nei8Dim8JfYVN2vmgQ/dKTKC9sNZbTrdYqdo3ZuDzGYIzUes3zGrX1Apc+6BR8tsgXHjDl2UHofITQHyPoCiSb49pcKQSRyequVaXgXR8fH1UNZs4B6NVomZ6xpEQpOkJbIsJXp9ZpcxXTwD4xHRe8EXK8xTJQdJrKuvl2cC2H1DOhzqNuF9leFE5bO0ZYwnrnXCQj+4i4RMfb3DnxOJvbco/sBk5/tqntD4OIJyPRwoCDAdyb6jRK9MaeDcK80QZShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV6PXrt/qClMrHspBrwRca7OKG5oxK9hxcDM4gGTcZk=;
 b=x+OEbobt5on5njboMYuif6kFCBZNNtYVwNhlWsnNdNP7mik7km4jA7pfSQHuhKaL0NvM7JTh8Vt/mYZfSUrgf6QmGQsXh2645wSy3bAHIsJ7YS9J2lJDIMVnlj13QVk0tvEFz80RKegCWx7mckuZRIs8lBrq14WnclD3NRNh1DA=
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 15 Oct
 2026 17:41:17 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::57) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 17:41:16 +0000
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
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 17:41:16 +0000
Received: from belanger-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 12:41:00 -0500
From: David Belanger <david.belanger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Michael Chen
 <michael.chen@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: pass watchpoint addresses to MES for GFX11
Date: Thu, 15 Oct 2026 13:40:39 -0400
Message-ID: <20261015174040.65493-2-david.belanger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 9570eccc-7f5d-4044-eff2-08df2ae38368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 8XFJTqgRPuyn5tqql3LuJtCsWTk4pK7mszTaPsV6r+y/Pu59p5Dz5nd5/9FOcNKd7TLJszd8qOibCO0YaUM6/lKJCvJCQ39269ky3wkOPFn844/bvfJ/8lGUpxjgubpv+D8BwdPH/nhaTziTAAvbnE5mb8CfiwWuIoCuXItbb5ZaqpIgemg2O7aRpEW2dWzfnpxMn/KoueZ8Lz6EQd1vyj/WtTS+VJMcUN+phh1Qrt9puJIB7qM9y9nzbrWUG9gEXx6DDTfvZLR5K411Y64PKwhyp/8wtUdUs7LHPK7bIi0ogcbAKXefs71Lo1F0Q/SZohAXbWrlf+C8jTn5nAgDreXtCecK70etjMOIDls1KFX8JAwPxjEMANyq8pgjwES7wmsllgrTixsH452+kU9ObSi8K3INBrTZZ5gdsypNka4kxAjuRq2gwKeLM7Lb5ueefrWPg8cqCy/5jB2JSFLG/8TjaLkvNLHCadnQUxxNEz5ed2a3QkodHLK3SQR10E6tFtp9hh7okogwhmxwSZ1Tg9/G3530G3luXuuvp3oG7kX2Tqe4htpuyrkbnv785nO+2BZKAuaOx19Ib+Ccn9joj4HMBPTDFrWSUzWpDeinkl2b8UcFJS+iegdQ/eHCRiHyHf8Z2kpQgKyUKf1K+Yt8A8QbSl8HctAIKhcjn/d/GUxFxAR9/rQJvKR9oKoZ4kBbP8tXYiFHkACedjaquYmB0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6psdnE6DWQ0WORimP5JyXKvfeTT7Mt3xQDs42OPKI3o4oWOVjroDeDhcLqXrANWa5NOccZTuQ6LVaCE9BNc1hKuKXlsS9HOi1dNkCfFiCfEErb5i++sUr+EPCdfyLqP/9kXeZXscFOJSs7FeRGCZi1lv9k6gc98iiCIR9Yo+JKBmWA25F2eQMAFp141ohdjLI9npowEa612srJMMC1v1/3MxwL7DHKfSp1HamXZYjMKQcqa4ikSNFWJR1+5nb0x0QKh311bSF5QV4WdLReolycSfTNIj6156FmLA09HPmln0YDWtHDnEDPEIolpujhZLQBRV68rRRuPP6kLewTAFshqbYB8lB2HCW69RARq4mUA+P6xNKyeVtD07H6Ogd7oc8g1+VVBLg2E3U4HR3xGPM7pMdf2gZao8Gx5d0WZMK/Ma6TqZjJtyn4Mv1MbfpkTO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:41:16.0155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9570eccc-7f5d-4044-eff2-08df2ae38368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

Assisted-by: claude-code:claude-sonnet-4
Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  6 ++++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |  3 +++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 04fab30ab5dd4..96a308b946469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -747,13 +747,9 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
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
@@ -770,14 +766,6 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
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
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 043ac05eb0fa1..3939eed05150c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1028,6 +1028,12 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
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
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index e251ccc41f9ca..de217882f5e8a 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -676,6 +676,9 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t spi_gdbg_per_vmid_cntl;
 	uint32_t tcp_watch_cntl[4]; /* TCP_WATCHx_CNTL */
 	uint32_t trap_en;
+	uint32_t tcp_watch_addr_lo[4]; /* TCP_WATCHx_ADDR_L */
+	uint32_t tcp_watch_addr_hi[4]; /* TCP_WATCHx_ADDR_H */
+	uint32_t process_context_array_index;
 };
 
 enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
-- 
2.55.0

