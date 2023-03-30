Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C29C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F41310EFED;
	Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE1010EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZONIGsMWz4OLL5sUjUwB5iZqPVBqpPmyWzJlaFZ3JuAaxdIE/vwI4iLrgIFeUU/AU1CyzroYOjlXO+L2BuVJn3u0WkDN96ZFhtLERpanUi9Pn4F12L7U0hiq8r/TVplSgZ85pNocqgK0iFiYIyv74WpgAB7PvUzemR68t8/BK64D2AkRei/gOerlGwCVmQo1Z2Edxk3MR2iZFy1fs0dhdZGNjv7bsBerpzGUFwhWNMxKos+9Skz1DYcvQ3+SJQCbe/gNOQ3NOKzmp+rxvz25/g0xj/uFUZzYEJeMefHgW548jaNfaypZyDNzCCEK39/h3YUOfzPTbwlb5dQAH7jK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjl+MbkG0E0K2KT9wnKhGvCP4mosT7jWj+oe1FGpQDU=;
 b=EMMNJT913pF7+f8zBMizXnPwBK69jzLr61CSrxN/i6DnOv8SAd1eGFy0VisRxLutIy62O6XDa24p2Ru/DbP7v0qTf2YRNFjGGInmVavWfnXVZVv52MCgzrfpunRMf00i8KPsANy/NJBwm7Mwz340SErj7iLYwr62LImLXGM/tJuLIxCdJnhYzDXLfT9kZG67htC6GUH1Pd8ZQfYhw986b3er2ALCGwfgboA+u5hND16C2zRhTfpSJ5iOCMp0ve+r8hxFRPUgtitIDs+0BOD0fl3KDUK0QU1f4MIUgz8/NXKcPMpQhkvCb/PZ5LnUfoZd5J7xPz4lgt7XpfCImbmKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjl+MbkG0E0K2KT9wnKhGvCP4mosT7jWj+oe1FGpQDU=;
 b=d+/S8eFRBChLjRgtzh/d52IXpxhGF/qTEugCB3YA65Eakwn7w1fpsnr5p9b8Y+yvQUGavry+5fzvewwyvDGxJ5slBWA9KQTTe/6FLbRlQDMY2z0KPrPlLfpH9cvFOF8LGdLuk+Nlmz9qEnYS//pq2NwBCth1CD9LEIhwCVeXxCI=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Thu, 30 Mar
 2023 19:42:57 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::11) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/23] drm/amdgpu: Make UTCL2 snoop CPU caches
Date: Thu, 30 Mar 2023 15:42:28 -0400
Message-ID: <20230330194234.1135527-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: fae6c9e2-84dc-44f4-af38-08db3156f610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvILEgpzran/autUMcjTs0U2HmWTCQP9Nvthp6JuHYwhqu9bLQMSbnWO7W5G++WK3WdOqmxiROLAbmqhnVWp54NCcjclJiDXjV+XiEgEOSTQ3Llu3TNdpTV/k5FrGrJETSHVFm+Yk8KouW3JxBwVdDBH6BJYGoq8X/VLQySEYG+RLQe8zuK+4etkMt9hQV9dFYGD2kPRa4hQDdNek2OU/uScMAFozWQsoP4XpW09+Yt8t5ouM33Lttap6SXPOHWRA3plHIfLpdJ+JM4YSoVMvrwzWSCtxRdTVWooJlXXmnxS6Sn+Fliwk5dClWuTbJd8yrdjcDlKUXoC9Sr6r1A3HTtQrv0G8nQLeQBolTGqGPT7CCY9t0VGM/LjK66cKNmGGJQu+7rhJRZFcilQNB+Srk6VMBagKgS4SbWIyWGeLjr3EDMYm61Ox0ik0Cq4ePvSDSl0otgMDVB88tt2L858ZsDHIL2NlF/TQL2SLwpgZ+R0BADAXKHlZEWeWYyJVw7Vb4+VIuDNHOQV6OiU6lsu2mj/oIvgc54sDomdBLd4RG3mcOS7haVw1PJbF6hvLRDIC6e04OraERyZ2H0csvfNP9Grd5IHjp+O/tpbkCxuBicVhLht33cV6cfjhBZNR2LM7wtMB+A7Q8PejefiWxJKE3V0c6zVTshHVP6PmOAu3+dNqKyU1VrNQ9sFF5NPKiH7wci0vdDQkJ+0EyC+7lIp5/GNmSYlmgxkfJHVJk1+NhU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(2906002)(336012)(2616005)(83380400001)(426003)(54906003)(70586007)(4326008)(70206006)(8676002)(478600001)(16526019)(26005)(1076003)(316002)(82310400005)(6666004)(186003)(7696005)(36756003)(86362001)(36860700001)(40460700003)(40480700001)(5660300002)(356005)(81166007)(82740400003)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:56.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae6c9e2-84dc-44f4-af38-08db3156f610
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On AMD APP APUs, to make UTCL2 snoop CPU caches, its not sufficient to
rely on xgmi connected flag so add the logic to use is_app_apu to
program the PDE_REQUEST_PHYSICAL bit correctly for gfxhub and mmhub
both.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 8ba59ffe0e9f..8901e73fd700 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -252,7 +252,8 @@ static void gfxhub_v1_2_xcc_init_cache_regs(struct amdgpu_device *adev,
 		WREG32_SOC15_RLC(GC, GET_INST(GC, i), regVM_L2_CNTL3, tmp);
 
 		tmp = regVM_L2_CNTL4_DEFAULT;
-		if (adev->gmc.xgmi.connected_to_cpu) {
+		/* For AMD APP APUs setup WC memory */
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a530e2a3cc28..a8faf66b6878 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -257,7 +257,8 @@ static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(MMHUB, i, regVM_L2_CNTL3, tmp);
 
 		tmp = regVM_L2_CNTL4_DEFAULT;
-		if (adev->gmc.xgmi.connected_to_cpu) {
+		/* For AMD APP APUs setup WC memory */
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
 					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-- 
2.39.2

