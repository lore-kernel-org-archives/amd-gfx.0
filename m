Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E3E7C4D0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 15:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76EC310E175;
	Wed,  4 Oct 2023 15:34:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBBF10E175
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 15:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grtovca85wi8x0O+/KaWcrkKX4eYtKlvemRo7kjbenSlFzcwkUjlkwRht6Rby8dj4u1OLOGRDBrbM07rvJOZZtC5Atjs/Iww3tsdcJ0cW7Aadd6BvaDLnWiW2LSkcxu4urKv9buZtSgHeML/zRCanQ3FDCl1WKb0iYKWKCFFIRHNSETtdVK2ftE0GCULqdUOa5k9nvBjc1P3jPKNFLNt+ePpVTP6PtDeNDq7CAw9SrR3hqjWjqR6Y/PDJ0kICA+SDFNPIsPwqD2WFjik7NexTS0ZivLOK+GARI+dV+mMz9O52ifvChDpy5Kq79KGbsfhj1rxM1sxCfarv/MbFoVrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEQBkwih0k1ARMJV6Xt9Gz+QFt8sHlzZeb7f8pV5AQg=;
 b=X2eEZYcagmfeXr1gvOBQYQq/rIoGX7u1fSEd94rIbF6mMh7Uq0djtOoVDB/wxEwyD0huxTL3PfBsNXJjRhMS76W5vPnr/RQrBpaL4sItiFmooZE1stnHhF0Z5Jx4Iif7J3dZ8F5xCuz8ZXRBy542T2kYndAcrv/RbSdNpwB362dnIsWY7+F06G4hZ6kZaajH4wLNb09Tt3c/Aiff6seZPv6rDZCJS6hu2HWrhwtgs5jIxcbcKXK6yuDMdqyVsnf0m/3bboWOXkQOfaYQW1R7oShlVJ+bpRqT8kYo5ni7AuHVWYeWL1dx63l7m+yZQbZxTD+h7oCaFc/1lVm/Db6g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEQBkwih0k1ARMJV6Xt9Gz+QFt8sHlzZeb7f8pV5AQg=;
 b=sugKy87RQE9GM7JylX9neudaPkYR54PO9gU6wkAAN/pMa4sOGswBwTxmxzKWpb10RUYMVVbK0BZKWnU6z5osnMgB++3lh1RrooCwcUJoAtAi86/PZc55v+6BN41Q4gPkxoIs74wIF9A3Kw5/dRBgEazSDJtLPk1Lqs05IjcQO/U=
Received: from DS0PR17CA0018.namprd17.prod.outlook.com (2603:10b6:8:191::18)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 15:34:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::2a) by DS0PR17CA0018.outlook.office365.com
 (2603:10b6:8:191::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 15:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 15:34:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 10:34:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
Date: Wed, 4 Oct 2023 11:34:10 -0400
Message-ID: <20231004153410.895387-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e000503-cb9d-4b03-c100-08dbc4ef640c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oF5YMgKw94TN9yIy9W/4lOhyLWPxkOS3LJftIsAg0yjUKUJxQdgljVm+qTee1fWVzKzF+sRnoyb+/IZz084uJWAZiRdRGc6ICc38QwU6ngRQKTh40Zbhj42Bx05vlZ0uAHHsJ0IRxwc0MHXa0johKFWCJlOjx4At7AerJ4ka8sTtSG6MS1Cqf8iEFH3c50BrgG3rJ0NVMnVc3wvRIDiWql4AF+SeAd7dnZvrGjM2RDhQWCfsEz8COiVihyv+rpnTuKS8Dp0C0lOkhN650bBBztXOh/S7VO8YPeOfnfvnUxrj4mC6xh1488HJwWAeBd2VcQSpRIfMeXNrpTv/hRXF941YCJNEzKZGoYz5mbc3AaxET0bhuvq+z5Mum5YasfGg8AY4YvniDwzprTMxUtsZPDKSBQU6O2wg2Bc0l1WFqS/0773W2ktN2SyJYxUhqa6fh1dLa81wqzqDJ5TE3/rlRg4Hykz/HjpqGIneNkeRMLxuXD3H20cBStE8Qbm62Cj9Rh7HFUYpLX+fvino4XUWxWkNA9X777YqFSWzhdg6uGIvDHazwQ0RyzUTy64k8eE43g54GADgk7N99kLWdlIwFXrWttwopa1QBdxsYWbV/pgUlTj5WKmLREg1V6nOa+qTon/R0GwjQ3XVy1kyNzC4Agf+I3ERJgYCuzV7QoxkxSfZzd8d9bEQ4FNeUmBHbvztRrP4+G9zJng9izuUMNuLBd313dmRIrWoGybC8jSq6mTlo7i2O+EsdmPZKd+AVqmI+CHK5zViNehK0NPJqAPjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(7696005)(6666004)(478600001)(2616005)(47076005)(86362001)(81166007)(36860700001)(82740400003)(356005)(41300700001)(70206006)(336012)(2906002)(83380400001)(426003)(1076003)(26005)(16526019)(54906003)(5660300002)(70586007)(316002)(6916009)(8936002)(36756003)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:34:25.6904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e000503-cb9d-4b03-c100-08dbc4ef640c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kun Liu <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kun Liu <Kun.Liu2@amd.com>

When ROCm is active enable additional SMU 13.0.0 optimizations.
This reuses the unused powersave profile on PMFW.

v2: move to the swsmu code since we need both bits active in
    the workload mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 684b4e01fac2..83035fb1839a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2447,6 +2447,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
+	u32 workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2536,9 +2537,23 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
+	workload_mask = 1 << workload_type;
+
+	/* Add optimizations for SMU13.0.0.  Reuse the power saving profile */
+	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE &&
+	    (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0)) &&
+	    ((smu->adev->pm.fw_version == 0x004e6601) ||
+	     (smu->adev->pm.fw_version >= 0x004e7300))) {
+		workload_type = smu_cmn_to_asic_specific_index(smu,
+							       CMN2ASIC_MAPPING_WORKLOAD,
+							       PP_SMC_POWER_PROFILE_POWERSAVING);
+		if (workload_type >= 0)
+			workload_mask |= 1 << workload_type;
+	}
+
 	return smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       1 << workload_type,
+					       workload_mask,
 					       NULL);
 }
 
-- 
2.41.0

