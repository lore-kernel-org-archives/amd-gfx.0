Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022E1C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 01:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7868610E386;
	Thu, 13 Oct 2022 01:32:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C2710E37B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 01:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdd5IQc8iKXa4sgP2ELpADtswaYidu8d9xSpAgM22xdfu9l39ci8Z+hS4cpFx9VrAQW/mWt19zfaVhNW+3HmniS5q+TOTPvVmNykOCZG4SbEoo/TWQnfvz5yK2MOPvdfVGxtxxAnfntbsMrA7Gq0XaFJYIAz6ee+iHYG7viXHbWshztfp+LKPm3MPuALiKX7e/EdPwcu+YXYXUks7rhJQ8FsKRYwBlK9mmJETWBR2Uz8pzTNv7lUqSRbvbupHSBEqSPqkVZhAsVnENzV6KxeusDIDefnca+LYkCy2Db6pr4y4V25rSRBNzwUaPGckOXkx9IQ5zpQnO0vQ8FYhdAMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGO+5P/dTMLSASU8ggjS9O/UboiQs0V2qSl0iV90g+4=;
 b=ljUuEJwarCW6l35tDvC/JY37Kfg23135CGIiBiA6RnDeU85lqcXnjAAcbgHjlMq2lepHsm+pIY3fut/rlIM9Hk8z0h8UQ8s43xM/kVDN9FOJUceabPxHSIB6vtfEegF0G02IZtlFiluxQEl+1QQ8HK+kUz0RNNN0FHYUt9Zj1UdsYpqA+adj0EnpIc7Wjiy7bRgoX98Vs9081fCpVRhUZHqf7Ij0d6nlHHsvlpYO+ofonqz+e6Yw8HrQKxXLSZqDxWrKeyek/RKQQz02VPtMLwJuY0Q1HBC34dMFkRBTU0RHU0MJzQDOCnzo2TIjIFCZOAXhqZkbRia+EuPfCY4OzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGO+5P/dTMLSASU8ggjS9O/UboiQs0V2qSl0iV90g+4=;
 b=nFEiTTn3g5PV3j/ggAudnnU3q/knIRgAYyitGJ9oAvIxuOEYMH+jAbXxqCN72GdyWPbDVc8qTvUZ55tALAwtZDVkOCcb9TSjFHPXiH1D+TpsTYUq7pSIT/MLVbnThGjOpmbh1RQBO3RtXKRCj0f4dt4PdUSNXQJTzEXHlDhYwyA=
Received: from CY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:930::32) by
 IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 01:32:05 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::3) by CY5PR13CA0022.outlook.office365.com
 (2603:10b6:930::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20 via Frontend
 Transport; Thu, 13 Oct 2022 01:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 13 Oct 2022 01:32:04 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 20:32:02 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu reset
 scenario
Date: Thu, 13 Oct 2022 09:31:41 +0800
Message-ID: <20221013013141.75369-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013013141.75369-1-evan.quan@amd.com>
References: <20221013013141.75369-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fe511f-6af9-4f74-e1e4-08daacbabc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYadpZeH6aW2FVTJa3Pb61B/ynNeIk5Q2c2pwemY5Ca0IdntrimtQA3d9lBoy4WVCxOUdzw90i8ID5USK34N41RARzolx+oz2p85uRA+c0tk4PBV0OJh9wTjDVOVHSvSwS3Ffnm9Gagg7I4QiaHsjuIF7H3/Ra+BvA4ARnaUyqfAMVvOytVrJkgXCsqznaGrOCKmgs/aJ0QQFmSBAgfee1ZOozmWFeIyMaASBPRdI9ycx/MACegWu78j8OOS1zdpBmbwMYGZYhJyNI1Yyo+eSGYrx5nfIxUKSbcduqaGFhreo95Qy9x3q7m2yhupQT3rSAs/6wTp6BzE0O6j+PuJPnxMAO2Q1eAEw3Mvnn2tdnoOt5hN5S0kFhq3SzWVkjMh1ua9lEPZvXosYa+pp5WHcxG0TifagHt7uyEiQW6xyH6gIn/r6F2tRUv2elkXwEzMl6O78wQQ9EXvD4/LhHDFwB18sRlMen+3Yn7rfWDblGNkWmEIdPj8T+g+w9B+ZDsftRu/jU37N+ZbCgQaiDwbWVTBJUEI8rnGrNtQapU4+nCX/sI4F3Lw4TnttB/BOcuDHMgxwuP5yArrzrxZ1hU3Olw7CI5VcCWXapH1P012tXjc0OUg7ZCnBA8Bjksw+S/BiUrLBmhdK2wnEeT69w8+t9pbmQV9QUpptZbfXiuS3DXYMILFWGsnsLVBWn2/YOLiJf/ieGxTgizwTtqvDLNlJZPog0f4lAp9WGjAiCJAwh6dJBbCe0kju83GYSiQ3F6b4+pmWHvMrSUxs215V8b7gsaw2MDjeVQNBJlKKnXRoKrEE4SVvl1wVAve1B1O+9hk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(82310400005)(2616005)(356005)(82740400003)(2906002)(81166007)(5660300002)(6666004)(8936002)(26005)(1076003)(44832011)(7696005)(40480700001)(478600001)(186003)(316002)(4326008)(16526019)(47076005)(336012)(426003)(86362001)(6916009)(8676002)(70206006)(70586007)(36860700001)(40460700003)(36756003)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 01:32:04.5772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe511f-6af9-4f74-e1e4-08daacbabc23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suggested by PMFW team and same as what did for gfxoff feature.
This can address some Mode1Reset failures observed on SMU13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: Ieb4e204c49abd405b1dce559c2ff75bb3887b6f9
--
v1->v2:
  - revise the code comments(Alex)
  - limit this to SMU13.0.0 and 13.0.7
v2->v3:
  - make this happen before display suspending
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ab8f970b2849..874bf623f394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2928,6 +2928,14 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
+	/*
+	 * Per PMFW team's suggestion, driver needs to handle gfxoff
+	 * and df cstate features disablement for gpu reset(e.g. Mode1Reset)
+	 * scenario. Add the missing df cstate disablement here.
+	 */
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+		dev_warn(adev->dev, "Failed to disallow df cstate");
+
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
 			continue;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 445005571f76..7d34f40460eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2245,6 +2245,13 @@ static int arcturus_set_df_cstate(struct smu_context *smu,
 	uint32_t smu_version;
 	int ret;
 
+	/*
+	 * Arcturus does not need the cstate disablement
+	 * prerequisite for gpu reset.
+	 */
+	if (amdgpu_in_reset(adev) || adev->in_suspend)
+		return 0;
+
 	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get smu version!\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 619aee51b123..93a0f7f6a34e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1640,6 +1640,13 @@ static bool aldebaran_is_baco_supported(struct smu_context *smu)
 static int aldebaran_set_df_cstate(struct smu_context *smu,
 				   enum pp_df_cstate state)
 {
+	/*
+	 * Aldebaran does not need the cstate disablement
+	 * prerequisite for gpu reset.
+	 */
+	if (amdgpu_in_reset(adev) || adev->in_suspend)
+		return 0;
+
 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state, NULL);
 }
 
-- 
2.34.1

