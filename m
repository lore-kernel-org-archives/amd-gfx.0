Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D75C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 10:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298B214AE32;
	Mon,  8 Aug 2022 10:32:45 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5159210FA4F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 10:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyrXqzqhnHJAhY6pRqXBDzjoE0soZMOLCH5+i/PsE9QuMW0+mwhxCmIQ+kos4ia6rgEkh6/rjzym7XTI6XLM+yqSxisRQzi2tsBPlwMx/QE0huglfuyRg7QfEdy6o/D7qIed4YsEui8Bz0IgGWZ4RXUwMRCHd7aD8wn0ibmzNS0vBijsEORYVQqbuiuYUKtqLcABK/e1kXOfwa+E0rAKjMKiLn4JZFoeeX1h3m4yGI+yXPXXcelwwUO23Q44s0GCI/CIUX0jc0euzjPNnzlQ530qEwVyN7Ut10iGYLv9EzyJZINCFdECSUVz/6v3cJM086QVJ/HUbR2f3CajBG8v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv0fr/eAzxjGA8sEdgWXM51tSzl7trfoblI22fC8nxc=;
 b=VYlV7IDyVLhqL1MRWw6blB7j5POCxUKRez095WmaBpMDIpw5PXJeNESyz9xmPC/dH/ZZLGU4OMnceX2+oqfx0GarwWu9mL1lQBw4351RNduBiz/2iA1BrR9wqHJDJ3IjxlZvFUcSE9o7FWvk0E8fTfxW6AmcrPMRLR25jkKJdY6f6RJv27u1fcgECPIcgSpjnmJZ5BKZSYk+i3GpZk69mCgt+31+O9NrQECT8TytzUspFiYJjP7FJvJM3OnAkGPOOejNGgGSDONiCDfa2ZPqn01DqykSDFRz/pDLDGBYblPDbP+gq+rIWCbVl9h9i+dVv7mMFi+M18Z/S0V7oSZBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv0fr/eAzxjGA8sEdgWXM51tSzl7trfoblI22fC8nxc=;
 b=qiR5r+AkmVVcJAMp2T7KNdLwC3oy0g8Bgnt2iUdE3N57dswMqbjoqadZ6uNsEb2lljdWD42RdPDoZLlvJlzNf46KZ2RnWe1XEcOgA6QA+9NzyWa6tAqmLG4Nr258MHys73hX5NlvDFvaajBaVVpQs/b7rdj1nxeWXfo3mgrDeRE=
Received: from BN9PR03CA0386.namprd03.prod.outlook.com (2603:10b6:408:f7::31)
 by SN6PR12MB2606.namprd12.prod.outlook.com (2603:10b6:805:6e::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 8 Aug
 2022 10:32:14 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2c) by BN9PR03CA0386.outlook.office365.com
 (2603:10b6:408:f7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Mon, 8 Aug 2022 10:32:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 10:32:13 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 05:32:00 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
Date: Mon, 8 Aug 2022 18:31:02 +0800
Message-ID: <20220808103103.3143927-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a166455-2fb5-4f8f-528e-08da79294228
X-MS-TrafficTypeDiagnostic: SN6PR12MB2606:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z5CUiY4s0z+ECsQlQx0BylIVXogDNI6oB/iSi/L6TrwTXXcNkh5jk9F7gFfpu/+2fEIymgInMKLmmMwJGBk+DOYRKiP3j0Bzy8zxEp5kb0ngBga6ZnnBsw9CB0463atc7OEPmE0RHhFAudskEN0MUUr+5t+tgeQwOWigPbZQKVDwALGR+SV00kyFquUJF8jR6auA4FZxWw/kvGUxjAHRYieSMOEfR1KQXJz4xFoJlyrv7suhofbxKFhV1E1fQEdH71dBeOn/T/bbUMiIzYIVCQagf/vnVhQfNAPflemJe2WWacjdj0T+/Va/4+5T75qI0VQcR//O4kAT2dcM0ZbzhVcu2tMnyZvO18IggPs8vqjnq4PgwQ/mdLlhzxbfEf645FSTgKpGz8s+382rHuwFY2mAPa8dD0pb9FpVcAoAkRTPF9HX3yDivm5Ebd9AgqSPGfaRxezSsGST8CUFoN+iEN+b7F7nHFZuIwxVwxEej7emAu/3YRzqrVB0XctsQxB927uQUpM78ixTjn7Wf/wOYfacM8tLj7cKO7MG4gKxcBEeh52casYHipqirJO0PtCLntGRTLDcPHsODq+T+15pzwjAFPqEinpKfdDk7E0ApsiRvfvl8Jr2mOB4ihx/6AXBlD38D+0gc2yHeydiCtLSpzqBRjftEUSH/hW7wLK/14xAQ1vzhANfrFq3WVu1kHzwQfrHEjk6TuejLCssVZnggpQILJy5zC9plsYAqxS8uOcuJWt1RBS/e09J5ar2kuMzoU8bSHXSa/cMG1P1BIr8X49x8xxo3jatOGwzSRfVfCum+0Y4yAqIrPBEn3IOgjkTsoUipRPXaLtiY427738mjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(70206006)(4326008)(8676002)(40480700001)(44832011)(2906002)(478600001)(54906003)(6916009)(36756003)(316002)(5660300002)(40460700003)(8936002)(70586007)(7696005)(41300700001)(356005)(26005)(186003)(16526019)(336012)(426003)(47076005)(82310400005)(36860700001)(81166007)(1076003)(83380400001)(86362001)(2616005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 10:32:13.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a166455-2fb5-4f8f-528e-08da79294228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GFX Power Gating control for GC IP v11.0.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e03618803a1c..319f07f61be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -53,6 +53,7 @@
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
+#define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
 #define regCGTT_WD_CLK_CTRL		0x5086
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
@@ -5279,6 +5280,38 @@ static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
 	.update_spm_vmid = gfx_v11_0_update_spm_vmid,
 };
 
+static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
+{
+	u32 data = RREG32_SOC15(GC, 0, regRLC_PG_CNTL);
+
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
+		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+	else
+		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+
+	WREG32_SOC15(GC, 0, regRLC_PG_CNTL, data);
+
+	// Program RLC_PG_DELAY3 for CGPG hysteresis
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(11, 0, 1):
+			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
+
+	gfx_v11_cntl_power_gating(adev, enable);
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
+}
+
 static int gfx_v11_0_set_powergating_state(void *handle,
 					   enum amd_powergating_state state)
 {
@@ -5293,6 +5326,8 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 	case IP_VERSION(11, 0, 2):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
+	case IP_VERSION(11, 0, 1):
+		gfx_v11_cntl_pg(adev, enable);
 	default:
 		break;
 	}
-- 
2.25.1

