Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0293C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2240A10F158;
	Wed, 23 Sep 2026 19:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w19P0BoC";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1C810F155
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfpDWXK/fXhfE6l5KsJj2mzIcrCdjJu5Fdv0AvOMHWNro1ly2KLgicGwLPoBqHgMmrRBwZbkMbFPyz/06G1NCeSiiYZadsPo/fkCgGnNxO3DsJMX57dAq5WYPkHq2KcXT3g1JfGxolslD35X2ocQBK/bGQ8Bb8VKhbKnBQtHW1AyDX+0BVLKKriGsV1htHE/Qn7zgEW3khosDxWClZlDC0WJRdrfw2f5kTBJGRfaraN77+mlZKXrdImc3BFYF3KuhwL5kBm5yDYhtc+MHjSmcpLsszBPEcQyz3Oh6jXAJGC7R2i6Ozg0ASOwnkXUuwjMJ/JsU6uAt0QVTu1yIgwqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmarGF+I97e7X95wnHSPVTaAoRw0ghZanJYA7lWw7lg=;
 b=nhnMurcm91H1JXieDPA2M44sVPYwrzpmKbyW3xuA0BWx81nnmiGIa7zlpNgh7ETc+64su/pG+q4lu/eS6VhJjKSubTouFqhds2eYFamFBrvtINfoZe7MOXCVt+L9Xuj4sYM4YEUqNhamRW9D6lN5FmnCq/JFSC4X91uhaW+1P8ypjLSbHLOsx2c1zXUzah2UlYRpr8pX69yM7c+X7o0FpZoR6vSiGh6W5cpcJDJ3QwkMjdSYYC8cpo5ya8TROer2iJ/F82tR8aU3W/L75/RM8yjxI7lmII4F5kh2yWC7BY0giaDeneTKrbgbBRX3rCGkSiDof3ID5CN5+DejLb+WiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmarGF+I97e7X95wnHSPVTaAoRw0ghZanJYA7lWw7lg=;
 b=w19P0BoCE5oBwvnxF9SH9+sgQwzojBXtQysLKERsF9wsvRmj0kgJ+SLMODOFkvOie7FdlTzoSUCSSP9wjxVana3Uw3jbBmxxVE+2tsEw9FIGfFNltNyiDGOdqfnzpstjeCtU8SjiUAVVqHv+i0LfYRD0YJFO+CEKaNLsN8FR6S4=
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Wed, 23 Sep
 2026 19:34:25 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::4b) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 19:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:34:25 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:34:21 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v3 06/10] drm/amdgpu: prevent suspend in fault handler
Date: Wed, 23 Sep 2026 15:33:42 -0400
Message-ID: <20260923193346.2292597-7-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193346.2292597-1-shahyan.soltani@amd.com>
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 77524707-dbbe-4d93-2dfd-08df19a9ad1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2QGREuIBgIlyv/TX6isO3Tno2IlzU0v2XTPB61YzNbifRx54HapUJwEPH6THthPAO7Hwdr+HO1PyePYN9WFElopx1Kwo22OM+3VQ4M35w4P+iVIn66yp+sbZE6kOLWP2H6iHN9l4P0p1o//PpzI2MJysc+kaC/9v4feTYSS9Eh4PwGANa8XpOL4hbQfubtjRa9YlHXKZFzSTVbj7+0f5tvBICgWIXbVU+LnGPiLpc8/xo9SY9ETuJXvuk2AOEeOqaBjdCE/oZYtQ7mPhBcdY7PA2kAIqXcyI8ol/T1KHyxzPF0QE53uXWf0dkLFTWnVTfDFUrpvxvsTYQS34NTI0Ob9tv/uba/MWzoouEpuTq6aYQV0iJaA+YnQTdAlCTr6VdUq9W1khFmUY+ot91Jo2+EvA4QZhQlhTqNHnxNSkqh84/IUMYJ+puiEb3/c+JGgOv6Qx/MbyzjQzSX8Ln1vUm5AyP8syg6Jp+XR82wuAp1skVkELhEgrg9PUaPsZN5+1wVvQftWExFcpBm7i/XkaqaJFuk7PBIezLxVE8k97FctmsPTAmyzpxIzzcV/jyvLijc/D+kcghiyrRcD7eo0e50nUIy7t43u6Msax7xXlPb++Gjtbf3AnMEvGj9m3gT3Gb7QtpWmLZraT+NOEgAmTWl4uIg7zWfprRvoyJukOSVIvXej+AG73lZVcwGXgMln1J8gyN6s9KD//nm+CM+Wn7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tP/iOrtGeKugCQJvb1Zi05T3I2JQ+OR0tWLtsxZoqbukcwi/I0msJ4UCs9zL1YOfX+9z/HNosznKzfnnUgEDvDj9YY5YK/2Ie1OXNTcqE8OEUqhcz1WokGySRU8CeL+SAqQF7rkdJAce3kE8oz79vwkNJQRxp+XFxQHSaiyCNEYQUWKkLcPdePdzmlQpzKlS1HiAgULgLnhPeBW8FgMU+yXcJiBAkGR1abmyo23fNb//7Bc8W1p2bN/njIs7B288xS3PL6neQgcJ308fPUUQL5CF6m9/8HX6B5Fq2Wrw40tJEPkp4zU96JBZtYv3+nlXAYGU2nLlcPDzPCErQKxY7B49ONvKdybCPeUdAbeXfy7+68O4scfktquk1OIB+d4gPFoh9XL02ePLGQ6tseGtd05uv5i0A/8WyFatDehgUgTqL9aRv+Hzoc98+qmsG57z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:34:25.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77524707-dbbe-4d93-2dfd-08df19a9ad1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Temporarily increment the PM reference count during page handling to
ensure the GPU does not enter a sleep state.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
v2 (Shahyan): Added commit description
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e1760e112ec0..1f5b9c77dec5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -129,6 +129,8 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		return ret;
 
 	if (drm_dev_enter(ddev, &idx)) {
+		pm_runtime_get_noresume(ddev->dev);
+
 		ret = amdgpu_bo_fault_reserve_notify(bo);
 		if (ret) {
 			drm_dev_exit(idx);
@@ -138,6 +140,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
 					       TTM_BO_VM_NUM_PREFAULT);
 
+		pm_runtime_put_noidle(ddev->dev);
 		drm_dev_exit(idx);
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
-- 
2.55.0

