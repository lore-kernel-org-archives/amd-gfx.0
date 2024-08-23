Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCD4C52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 18:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE9710E062;
	Fri, 23 Aug 2024 18:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fn5Umjy7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD25F10E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 18:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIpUc+mOSc7RFQrMXBvb9B4QSblpFlEEzZZJ7ESORbLf+dXNhN+3wlsll/L5vBfcK2YrmWXkIQ0lbmfc6n64XDYvw0b9X1k80BIInjXUgHcG5+Co2Z+qooLnVybeoZydhq7+UI+uKIvZtatCs+9oYPTGtMNB3n/EM6Ipn3h4sCtwiSAUGUfzQooSOn2bPXkh87+iHfFJaLd5+Psog5ph+j41QHt/gbizZgLkOp4suU5C8yX8QdDQ6qoxkT8OCMGA9tbpbDOpYL8pt8+OPFuddlWa/y6wqf5c56QCTIYlUxXOa08RSsWWbpDVX/gc+AxpHjhbBCjTDfLU/hC+fFcB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tb14qzEy7lqg6j9IrxBJtetwz6vjIraZjSZSAlafDg=;
 b=i+d9dVmnkgxxNwKUOJbUHnl+AJA+UbTuIXBCgHDpXx+if3AgPlWQcPEEUEZG40D+XzqeMEyVhZzf1DvWGyr5cV4ClrxE2i5NLcD6ENufwLaC0Mxaf8+yCiqY/UZqrSBBogiYFkBBzDv7nu4TZrJ313Q7WsaM/Wn9e2OTJhDPzCPhiwKlgEfPRkp87gnYU6BGbi6OWdkilPe2gU8Wy1iGQaWYdvNapPybAOZPqB94urrT1IRUjZpwbgctNRnMP5rkpQ2RtH+UmtjPNx6qi0H4AW6mOTFwpmKTdCsTnMVknlyx8qYQ9DdevtcGDbLEpppnuS9dZgXXY6z5JT6pjodSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tb14qzEy7lqg6j9IrxBJtetwz6vjIraZjSZSAlafDg=;
 b=fn5Umjy7nnCguGfoRc2FQ6Vrx5hSvSN64WFretcgsInu1JysQ2iw8Ntc03KnWMRgoffDaJnfajfVEQi0ugVrGD7gFh/lczTTaDLXCtfX+9vRg94rBm5agy5PUWh9GaxOkQwpGlWkj4Q7TmTW0xfUHXYqhRjIeMYzea7oepg4R/0=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 18:44:59 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::b) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 18:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 18:44:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 13:44:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: always force a state reprogram on init
Date: Fri, 23 Aug 2024 14:44:43 -0400
Message-ID: <20240823184443.2032149-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 67855d08-b99a-4321-486a-08dcc3a3b0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ygCnKHfWJs6H72P2/mfGKopcc1oNd+2Kwty4EsyTW0ljOgGtr5hFAQ+KRgC?=
 =?us-ascii?Q?GXiqP6hFF6xCcUltze8r0Kgqmg7pfJJ1xEdOEStZlW1AbvrSVrknQlXn9Dn/?=
 =?us-ascii?Q?4Br/+4JVxTPjFUNK6M7rszYwDmIy0opyDKTyPXXra2R11OCLyfmWXcetTVOn?=
 =?us-ascii?Q?ph0CLjNgue36YWnVv5vua5aYHFXOmAcF6Oh9vEFP11SjIqFKCpVQz8UhI0Hh?=
 =?us-ascii?Q?wANE9SzkU4BvYZNzBNKGMjV3uZ+2KFT/p8/+wNhUg1Bee50BGamMZQWLSOp/?=
 =?us-ascii?Q?A/2vYQSC5c9zPt8HF4/LH0PpV0JAEllqG6wpor25W7zuEhn5RHKfAHuurIsj?=
 =?us-ascii?Q?cFGLGwdtW6CUAPRO0y49sO77fyrTu2PPL4N2NcNdVNSha/5aWHL4u7YGG0eD?=
 =?us-ascii?Q?m/8Nyzq5Gwz0iuejt1zmgrZXTM2fK7EBfjF72Ejbqj+eV0B5uDBuvlMJcVfK?=
 =?us-ascii?Q?lwCHUHQwyC2jrFW2fStFRN3iU0BAIgJD4SdFihrRpdrn46bg3DGz5U2LZ+Hy?=
 =?us-ascii?Q?+rjASrMCneb6IhlvG9OalHjImP1d4KBdynnnJbbLEwR4tX7dv06sydjJI+/9?=
 =?us-ascii?Q?pz48+3pf75i0mokUKg5vYyTngn2qkTHYS4uAXwvTOOQgaRMA3R7dqV6IQ4qc?=
 =?us-ascii?Q?THZPMSkCo3wEpY+LpNY4ZDPLUlzoajN/UZSUyYud1QoiC/9dqrD4uq6r67UR?=
 =?us-ascii?Q?fi9IP2q4kfN4BSwsKmhJKg+SdD35rPeindYikQ5BzXGgBL9BReuAf3QDYkd2?=
 =?us-ascii?Q?x14pow8RC3rW9BhZ8dmPBsumkD1orihjyBlhWzS5vvuFmt0p/bs05dyydXDQ?=
 =?us-ascii?Q?w2DxOzhw42F6BjrTKe1qDk4Z0F419RBHQxaibB5uVSbs3wT5j19iNMOQd7Lm?=
 =?us-ascii?Q?yFRhKLKxGmRYTaZBsQRW5KpViB0cvOt83Ku9DhImFvYGb8+NGCRWoKV2N9/s?=
 =?us-ascii?Q?bSv3qD4RM1I+BPF+Uzl7t3wMstLsdz9VjrgAHnfP1VD02PeAHjXdokp96W/4?=
 =?us-ascii?Q?RI2l8nbWj+mEXteBbmGSK2UqKKuTMhSU/Q01do5h8csCMbmsTutq7BhqS1oi?=
 =?us-ascii?Q?LKsIbanCGAa4WQHk7N/2Qv4UXjaW7LfQ6rX1Hzy1eyF/aIxUWW9RjemHumYS?=
 =?us-ascii?Q?l3pFRVy7AEpa5Gcpq2DbUVHwwYULwmsCZVerKk0vFCbRai5BHpHtb4qiRj0b?=
 =?us-ascii?Q?49SqijoQGS4M2eF0GKm9bXrgW/PRRh9XL7y0goLR8Qnt3lbun3UHq4EcJVFw?=
 =?us-ascii?Q?DJBK5+CxPhbaR5nlAaeXj5G4yLbzYf6L8fVVmGoKbl3D3K9TC1R/skrimnlg?=
 =?us-ascii?Q?dYHL+GqmJeVmkWVG2rifG8n0FwI1my9cQv6vxWMcU6kXVaY3YYm+MKQos1Qm?=
 =?us-ascii?Q?ZmZIF2Zu3TwTCpF08fK7GXJjw+cS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 18:44:59.3258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67855d08-b99a-4321-486a-08dcc3a3b0d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603
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

Always reprogram the hardware state on init.  This ensures
the PMFW state is explicitly programmed and we are not relying
on the default PMFW state.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 12d30af431fe..c1cd785b4aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2224,8 +2224,9 @@ static int smu_bump_power_profile_mode(struct smu_context *smu,
 }
 
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
-				   enum amd_dpm_forced_level level,
-				   bool skip_display_settings)
+					  enum amd_dpm_forced_level level,
+					  bool skip_display_settings,
+					  bool force_update)
 {
 	int ret = 0;
 	int index = 0;
@@ -2254,7 +2255,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		}
 	}
 
-	if (smu_dpm_ctx->dpm_level != level) {
+	if (force_update || smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set performance level!");
@@ -2270,7 +2271,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 
-		if (smu->power_profile_mode != workload[0])
+		if (force_update || smu->power_profile_mode != workload[0])
 			smu_bump_power_profile_mode(smu, workload, 0);
 	}
 
@@ -2291,11 +2292,13 @@ static int smu_handle_task(struct smu_context *smu,
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
 			return ret;
-		ret = smu_adjust_power_state_dynamic(smu, level, false);
+		ret = smu_adjust_power_state_dynamic(smu, level, false, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
+		ret = smu_adjust_power_state_dynamic(smu, level, true, true);
+		break;
 	case AMD_PP_TASK_READJUST_POWER_STATE:
-		ret = smu_adjust_power_state_dynamic(smu, level, true);
+		ret = smu_adjust_power_state_dynamic(smu, level, true, false);
 		break;
 	default:
 		break;
-- 
2.46.0

