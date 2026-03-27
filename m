Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B885210ED659
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 10:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8BA10EC81;
	Fri, 27 Mar 2026 10:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k17u5sR/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC0810EC81
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 10:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GABDDjL+RZSD2KHU/AW1VoAv0xxuMmL4zBOUi8C7r26XMye+pMn25jiNVae7tE8GGaZ2e5NPT5pW0lIbIZEy9IqM9a9Q49dSCMZXlquoAUtWORcCy/jZSQtVchSp7auairwEj/gS7tpW1cmNx4wBSwOMVFwc1OcuiUzzoXaJ4vQaGuKFmTPVTrrhMchYN+50usbjHOFauwOyW+/0c19HBXhlBrUMsBVpfR46oqTxmiuoPBNnOa6t+I98IT4eqVgOMdjZBP9b/yNPY8MXmhXbz1JyN9ujPccVExsQR+SzDV974Agr9alJwddcevmYW3/1kMGhQ14U54QZfkwxSCpwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DCYU1zyExWhrJ5Ts5lPONsSFuSdv0eVuS4HvXk7vEw=;
 b=qTYQ/RE8hGzm1bC8SlfqEjwWhYrOTuysKw//ptDrBfDeQP5Y4PGsJ30C5Jb+tfdkU/S5mJU0cXs1r7VEbJD+m3/amUITCCN3OR1hbrT8jLx43MN+LSOQKN2wPfQWjCQvzcqoGoyv8ulcBll/S783GWk/ND8MYPtXY/cE171IiEpurazW4w0nKLsFV7UPe5El6sg6Ytu9LGd7ht2R18qnRS6+toXcVAY3lbA2qw/RxcUUSiHu8F6HWnvJzbg5jY/ljqRcIIcCiBpLtek+avCP81FY7JO4jy/zg5S1TJK2ZVdng3BOChidSoINKoSKMwh05D8fBYNAMu7IK2xOdPRhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DCYU1zyExWhrJ5Ts5lPONsSFuSdv0eVuS4HvXk7vEw=;
 b=k17u5sR/sH2q37gqivDUpUeKmGJBNWZfu2e3B5LdR84tXYl3FlcBJ7MieOqNGp3pSfU+36ko3Tw7c47eln0T65yP82+Mf0aodIGrisy3Lye1d3krbY2mI5up2DJCKZptQu1FRq8/1wVHU3aQOSH0xbEYv/QRt4dQHZtai8evLz4=
Received: from DM6PR01CA0018.prod.exchangelabs.com (2603:10b6:5:296::23) by
 DS4PR12MB999077.namprd12.prod.outlook.com (2603:10b6:8:2f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 10:40:05 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::2e) by DM6PR01CA0018.outlook.office365.com
 (2603:10b6:5:296::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 10:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:40:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:40:02 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix wait after reset sequence in S4
Date: Fri, 27 Mar 2026 16:09:44 +0530
Message-ID: <20260327103944.1477094-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DS4PR12MB999077:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f44462-0d8b-4b57-3a6c-08de8bed3537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zzfGnMOkIjsZo2wjTCYLQxH+X8G47IOVTdPYeqKeq1Kf2zUFJnH+QqnS5nCjTBiDi0OTcxZ30Xvl8hv3/ikRhCejwmPD0fLj7vVDrkEAdmgLSIswurDH+ByMkARmYacy6dGg6Ks+5PywD3VMoz6xMlrR4ATxakz8BG/1yRAL7cozGbYJbBd4+NjfwE0vo9ZUJm09zP/MQdRL8WoiV23pbCfIWuez7oFtgSdTLIJCOqw8kJ+YxZVcXBr9FZODCUzJBUEx7jEPsZX7mkueOxsUAAEGttcfNapsAmUAUGa1s8Nq+4SYAYXGpOgccr8XbLlvNfYzsdUtZGN7JU7RQddfdMonAisQhTOE1gjgEswdN5yIRvSDdlgK2hXcHd0cyykI0k6lblLfk0idOp8RgOxj0DWdwdF+W4xkv6LeBGu9h4mlQY1SO1zUYk/YfAGJQjZ4gn6PrZzPA2DBfcbNh6kEFcctPV0DB3xCMG77kN+p/jFYlHGdBX/s0IbLTnessIjza6a/IgDFVHYgus0UN1D+enxvsa968tPAhtp4M9WskmMTvdhAaIjgyD/eMroHFOel57rzoiPCHslnG+lhYKG8egpoLuN3xprfvsWnMrhuxDpmlVk/YXeQm2W5PqIDlAC2lgtDwz4MMpzostkPfcj10bWXnko4HPm82fqZWyAwyyGIHE3fq323RpMbqPrCnON8HF2wcm0pqCPocs4cjRbSe9dPMs0+d5by1MK7ZsYzph8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DxT8mlG+XVR3AcGPGYB2LXCYybpTscxEwv6s8FGjh34PdL+IM5vQvz8Sbi6PvOTH6ch8pvF3DuIAtjLR0obEHD9c29PiPAID0Mer4b9kuK+pgQKfpw5ZtMuISV0Y/Tmx9lVySHLeq6cmW2DJK4woeF+YipB2M51qagaTZom2R6JRUoiblB9fqficyWX2eaJ9F7RDMhqZDuZoHbp598nsC36OonmXtbCeMCKrwLYZ6NLiNTq/wyJZdmChwXSYZ5Fk2zNkfBNvRO/XEgNr1TaJmQnrJ2lqgruSN0NiTVZNPZpBXM0ic9vFt/knWHcuwPke+PWh8Huhi/B/ZTeLDITC9DW47Nws78URVeSAs5rUbgL1+EoGAW+ttyzDGbcy1j+T3cQF0cn9YWRaP+fbegZ1qnoJXt/ltv2+3lVoJ60mgxuOXmGh2L//yygsjM/eILjr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:40:04.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f44462-0d8b-4b57-3a6c-08de8bed3537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999077
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

For a mode-1 reset done at the end of S4 on PSPv11 dGPUs, only check if
TOS is unloaded.

Fixes: 32f73741d6ee ("drm/amdgpu: Wait for bootloader after PSPv11 reset")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4853

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a44baa9ee78d..8ed637f92322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2683,8 +2683,12 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	if (r)
 		return r;
 
-	if (amdgpu_acpi_should_gpu_reset(adev))
-		return amdgpu_asic_reset(adev);
+	if (amdgpu_acpi_should_gpu_reset(adev)) {
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
+		r = amdgpu_asic_reset(adev);
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
+		return r;
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 9aa988982304..fb7aaf5ae05c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -170,7 +170,8 @@ static int psp_v11_0_wait_for_bootloader(struct psp_context *psp)
 	int retry_loop;
 
 	/* For a reset done at the end of S3, only wait for TOS to be unloaded */
-	if (adev->in_s3 && !(adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev))
+	if ((adev->in_s4 || adev->in_s3) && !(adev->flags & AMD_IS_APU) &&
+	    amdgpu_in_reset(adev))
 		return psp_v11_wait_for_tos_unload(psp);
 
 	for (retry_loop = 0; retry_loop < 20; retry_loop++) {
-- 
2.49.0

