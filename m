Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8374C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A0C10E103;
	Wed, 23 Sep 2026 15:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a/AJFiCJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB1389067
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVf65/TkGpcW/EII7krKx9rJzEfOpSdcHHEbuW8igLtmFnNJ+JA9gSn+U2vfjxsM/j2RQL8PsXznBPSGDPyd0HkQgSa7z4yguDJp25RpmmS+AHV57u/V3z3HIINIguJ45psHVEC8PGXlqb3JDprIRDKUynSv2aXV8ewFXexbXInrwbSaReQzch94GB7nghzktFKhq+jYhxlFFvgqtdRrxflztI+u5goIYyA/AFhxU24k6NetDHMmN3FBxeld0VtCixL5PkFc+k2tDKN3MYUmupkuxvMXCWTbHZEhlyu5KrpWaAbwwC6OB8GoGIJRsMNrKJP6bQ4EVLmkrw8q0vqitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWTiAdJtZQGztNjTL+mFGMLaEToATiYxOGNXCbC33Jk=;
 b=xtC89XuChh/jFIDlWXgh4a/AVvkt1w07hmCklwTAqvRGjvFOO359ans5INzQpUZmTi8forKWgFSXnV6acuVI3OiCl5z72UX6JpLmbIIpPhuig6J6XKqUnn/fXuGgPG/Sj/iJjy2aiOvsL9EVCst6JYtZESHwDo3PJB0JyZKHb2VT/5Jd9mA63WODZ2XrR8VK+1bsTjaqNgOERA4An3LmUWPsr0T8oDq3APU6ZhdTDplxTW/z4wpwDSIqrX24OiFA4x28UPLbXBkyE7n4Ze2s8aKObduMSRFTLeHyb+d05NhK0QxzyWemUoXi9gMYXIgMEA36M12SD7kp/UImaMJsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWTiAdJtZQGztNjTL+mFGMLaEToATiYxOGNXCbC33Jk=;
 b=a/AJFiCJMgbmS//Y56K4Bs47KuvbBxWz/RRgy71WrIPeZgjVevhHjg7gLofKRWrQb94Q/5QZRr5NRmSVU1yHLBjdh9/0+gXJX+pUh+4iFCh1+lgnh+0SjtaHQmaUnvq5QasNyMgjWaKd2sz3u/gpXUjx91Xr2rSRL2wMxM13/h4=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:51:16 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::92) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 15:51:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:51:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:51:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: skip vpe dpm enable if dpm_enabled flag is
 false
Date: Wed, 23 Sep 2026 11:50:56 -0400
Message-ID: <20260923155056.2816021-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923155056.2816021-1-alexander.deucher@amd.com>
References: <20260923155056.2816021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e09f01-aa93-4d7a-a4a7-08df198a802a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qP+812tHim84AQUt/PcNa8Y/cVkUjrrRpWy2Kfyz4ggNP3kIW5emqNvTAQ4vkfQLiY+PJyphqoiIei79p9L0ImULnZkU+mkTudoB1nDT7kOU4udT1el+h8Qa5ZB1fwcPYykPf83WCxToXv4ddq2GxXqDc6Fo1hM0lewI9GjOoywR253cKhwih/fEyHCBcrPP8qeeTLa15YwJ7J49AoCtGpuJ7liq2uWmo82Z9akoWbwn2u+G15ozlUNKk9FwCmeIqr8aIaRuB09hgw0aMJi4ZtyFBcleLeZjRYOpzqIDfExJy2S49YoONOaEeOCvmJ/5nZ9IxZD2pvs3f0e+IfatDzTVD3QY+wksV+C09uzzjyJaa5cylMmbKjKC52uBSv2zf55Glf7EkEg5MHfVcLlUCjrG1ORJwVAIdZkUGA7EF0tgAVcgFxYz5hXVIrOhqc931l+DYHIjODWTQ8nCElEtNZrVekxXvBFR6z0utub9i3wLdppkuzHu4Ra0P4IzP/Cs/diDOHS/4VW1ig0Q0oz6q9qc2UzuoJuAGGCCfuC3W+cR2OQ0diTpRiVdHJizg6pb2BjW4d47dYmum5eme0ZpZkEbhF025T1Y2DDwtGAsaRljhplMOpld5nDosGivjCqDS8sVGrnwuQK1QYYpE62XAj/7OpZLl+sY0gzW87fG+AlLL9bg3JX9xV8y0cqk3vKcwtU/Fh1g6MHdnd/p6v26jQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2QPh8C0eSqUWJTmqG+V5pb6OZ1FwMuu8LYFLtDRIo+KcIBw8FFiuOC6iYe3/ZrvrkonYYBwTBtcx4qdbTXsYCdllY6NodfiQu2M3bi2LjL/FkKuB2RTY7dQRGm+zXzSt/uR+FmuYMXE3XGLH7sa7wXVavpmPkrTNE8vrWxYSf2VFLly+tJnx0qd9Wxd06Lg5c2c9mu+A2XVUWIcFKwhCqypBZDSHPMoCfM8SBKf3f0am2/yvnnWQYSj0ZC9iJBUXzeKOG2irSeQMEgeZkKfsL8cPAv+UZxpwYAAsRTOSQxlJpUgXqB7t9tU8VC12gM2ClK0f1TjhAkxxRLKsLPnpp0mJkFmdECcXlpYlifF1oYtXqwMxm/flpsMsXO6rUcZBRbAEpo7SV4E5gnjz/UXVAVlpbvxfa5SLckU3GLE4F/5yG7NHIpCoNr7eYnnDXW8C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:51:15.5920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e09f01-aa93-4d7a-a4a7-08df198a802a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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

From: Lin Cao <lincao12@amd.com>

amdgpu_dpm_enable_vpe() should be skipped if dpm_enabled is false

Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 1f1e1a4343d82..f6adbc1906fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -699,8 +699,10 @@ static int vpe_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 
-	if (!adev->pm.dpm_enabled)
+	if (!adev->pm.dpm_enabled) {
 		dev_err(adev->dev, "Without PM, cannot support powergating\n");
+		return 0;
+	}
 
 	dev_dbg(adev->dev, "%s: %s!\n", __func__, (state == AMD_PG_STATE_GATE) ? "GATE":"UNGATE");
 
-- 
2.55.0

