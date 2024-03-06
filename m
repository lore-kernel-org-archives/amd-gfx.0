Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBDC54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 10:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429610FFAE;
	Wed,  6 Mar 2024 10:07:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWcpInMd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969FA10FFAE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 10:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBoRSDv7bgjFqMFX5SSXMoKnTkeZpBIpRnFKFuY6ULhmeUtKi6MkTpcpAf20sE6hs8hzymU2zGfQBMfriE+U0a/wsbefYkponvYPr2bhd/cWe/dakWn0rmwAR532SLthQSpCbTucIa2AbAP33ty39lMLC0Rn5Pv64K596oa9HaYeXjgFEpbcmLIdJoWAdkMPNnX2ljcu8DWFYBWy0rNGQXS1YBrZT2foafnfHf1g10EQRvsfsgJCvijEH3ySb6a/Z9KX5TIymGYlysRdzet1sMssX5AkgQuzIe6+ra8c/AtXYEXV7H0TpMhY56P+559H/YO3HgUzxgSOwkL1/FhOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38bl/i+IE/8dHR4AEaC7uX5q8bNUn1dVVYd/XFgjdX4=;
 b=bmgvC27f/OOeCvdWHVMIrueTYx72t2C4sRxs/2Zq9PE6R/qpxOjJtYfR0pSrWwF/ZzlKOTsXBFG3WXAoIK4J6ZIOm8sxDRpaCs2voEtacaunRTEK9o0gMaiLla0GnPU+L7vgkAYmO3KouCSX3qRW0h/zYEBnq4qpIeucO7IrjVeCipjjnYTDwtpPN+sqVw1wds0Q67DKHND435o93sc1pIjSO6n+qEVQ/7Mto60Z/CGaYFoeQQCwfYzkBcz85soxjOx3rHBYebkjFHQrEymS8hsD+HYohVXSavOwdbvAqoI57QInwvomm6YNT/V49v9FMgRBV2ucasWnVE9Hh5ygEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38bl/i+IE/8dHR4AEaC7uX5q8bNUn1dVVYd/XFgjdX4=;
 b=RWcpInMdSgItgOdXw56KxYRThTPVdSR5djLopuRdV3Q4fidBuvSq6qTXNUoJh3IE1gSij1BmGQo2U3IX/tGEl/4AR1Y2vacZaqoQFHxsOQr+BLAcGwDX1eH7eNSNbs6W3qk81TuBnUIyY7jNSN5QHYe/lX4EzbjW2MdXUUAmLck=
Received: from DM6PR07CA0074.namprd07.prod.outlook.com (2603:10b6:5:337::7) by
 IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:07:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::e9) by DM6PR07CA0074.outlook.office365.com
 (2603:10b6:5:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 10:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 10:07:50 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 04:07:48 -0600
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jingwen.chen@amd.com>, <horace.chen@amd.com>, ZhenGuo Yin
 <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: Skip access PF-only registers on gfx10/gfxhub2_1
 under SRIOV
Date: Wed, 6 Mar 2024 18:07:32 +0800
Message-ID: <20240306100732.1126961-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: dc258de6-38a6-481c-acf3-08dc3dc547ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plVjzvq6In6BHm5NYS0JSGSGfyQdgVEJxqzi86Fc47hDoSJshocD+dIpUYHiXj2T0qHc1y2C3wFWhx6lWZD8t2tM0dSvFblcXAEPCBH/45l24U2rtSz+J5HLkjeCkxLYx+3k0jAcdi8/Sl40ND3UIRW5T8edex5Qvn5JhEcOkfe44hcV12Qh7GCR5N2jjwBvnrOLM0Ime315UAAikZdKKgpUUPqxNzZHBf2+DW/S4QcLPbEUHyGAQS5INxYd7PXXfBzKLEXoIfbHJJli0vsIxyULaR6LeQn8dX27zQyx77Au3KM6f45k/GVYqPW24wSqmJZVhRCP2Jvqjr0cKyYWiMtuMSIZ41HIY9lw8iN+gTAC4VbjTX8B/GR9iR7gYE1g1Hga21nJhQUMfIhLnqHLcQ33Fa/TrHF972NfwxOgcNz1P8WjLJ9SqhkM270/TQjdJcZTLyvNd+/GrdxFofuolvJcnjaX+w1I9N4Y+9ryZaaGsnoG8vLXgWOixChM8Pwt1jlxVtIjjnopA3rJ+t+5OP6kgJiAOz+NUHJuNc4/tibtzsI9Rrsc0h5qijts6pC8X0XbJGmZBB63NFEUs1JVVIUbVFcWNFJ+uBRi6CJAv8J0Lr0IkDEdhkNVbOGk/aNoQcTM0dca6JruNSYKEiBJ2+ebJvCZD0xtPD5Ezs3aiqHhRGAdrhJBkWng6Z7q6AxkxZ8GUiuSONjVw6kU6+DpZXNZqkF7LhZLS6Mfw9SE/ns0S6HVnqf2gngs3b+egD+a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:07:50.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc258de6-38a6-481c-acf3-08dc3dc547ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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

[Why]
RLCG interface returns "out-of-range" error under SRIOV VF when accessing
PF-only registers.

[How]
Skip access PF-only registers on gfx10/gfxhub2_1 under SRIOV.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 904b9ff5ead2..f90905ef32c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3657,6 +3657,9 @@ static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *adev)
 
 static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 {
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
 		soc15_program_register_sequence(adev,
@@ -4982,7 +4985,8 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int i;
 
-	WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
 
 	gfx_v10_0_setup_rb(adev);
 	gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
@@ -7163,7 +7167,7 @@ static int gfx_v10_0_hw_init(void *handle)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 0))
 		gfx_v10_3_program_pbb_mode(adev);
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0) && !amdgpu_sriov_vf(adev))
 		gfx_v10_3_set_power_brake_sequence(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index cd0e8a321e46..17509f32f61a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -155,6 +155,9 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Program the AGP BAR */
 	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-- 
2.35.1

