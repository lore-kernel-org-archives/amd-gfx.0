Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888B0C54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 10:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F77112DA8;
	Tue, 12 Mar 2024 10:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nb1UQ1Gr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F38112DA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 10:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k31GjJh3aDmH4VILgy/K6ykVzF7E2TsrC7HULjmdet5tEYC+yX6jt5PzL0qYFL3ZtTUtVlU9ODlsfU+EJn7Hyi+GgRkgRI6dLOyAUQN+EAt5Kd9X8rf/rwI+SaomO5vWkL8/aDPTKPkyR4bCp5QwU65nf1aSo+hqa9jP90UqCASYS7VGA2jbbM2I7yBRlTIaYDkqhHcP2lBNLmwswYvR00sxSlL+3lclWOqTnDZNRijdOpkWFqOyS5HjD8kPH+ejrBuECJjs2WAmWkvjNX0PD3Gr7dbJaXDbzKa7dvL3Rk2GWcEzyrIczleaqZcHk4P5qJhfgnq3JUNbNK9m+wextw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYSXTxmw6B+Qw5ssRwwELTz0R9flOJWGNQqef6YB0VM=;
 b=TfiMvrxgVbi86sI56NC01HB37PQta3eve+afa92VcLoTKSqikHwfC5L3/+XKEbKf6imfXyJ8iORoyU7bgf383setFetO8Barf9dDLFOnZgIc0jWH/zmR6kyAZbOvuUpt2dYB7bFpmbaZ8Q3Jz6aW/AC15xYsc7H7F2U3AxU84CJ0MhWh1oXGHYnE61GvHQgyDUtvmveTGPhtJUoydeurtBTnIpjtCx2znWtALQqO/3EbOJyEwLp0ocZdsDtICEEawoSG88ez+jQ/nl318hSCxvfPZ7Im1MShNO/GGWe3Dhc1kbe47VQD9EYkkqWELJSC9VZYHeNWyw1H0OOXbkFSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYSXTxmw6B+Qw5ssRwwELTz0R9flOJWGNQqef6YB0VM=;
 b=Nb1UQ1GrKigIFWT4vhff7TeLf7tYMXjlCPWAFOWon0mI2VC5qPg3Bxx6JaFUychbeJcsns+yntg6+wOcpuE+MyeIBBiEZTy3T1row2RRAZ7JhUbfQjZT8+ggy2qWwIh/ZCZtkg/9uwRPurvoER57UN/EtXLo4liyo3H24qAR3KM=
Received: from CH0P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::21)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 10:59:50 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::47) by CH0P223CA0002.outlook.office365.com
 (2603:10b6:610:116::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 10:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.0 via Frontend Transport; Tue, 12 Mar 2024 10:59:49 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 05:59:47 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Fix the ppfeature value
Date: Tue, 12 Mar 2024 18:59:34 +0800
Message-ID: <20240312105934.2291792-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 701cf78f-7c48-4c47-44d8-08dc42838986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lRoMOjGW6iN22ZVlvR2w216y+2/XoSpNuFmBY9NLylsEoLEsQmggtyanHYg8HzsRD3WBNwOub/B2nSxBqOlOdk6Ul/9ioWzpRxuWPnSu57HRo8WKOPJtesJcTeHHctgCDJ+bopnvoZo4Q63C63cX9pO0evZXBWkGYgBNkE/fidqczyVJVJtxRclCqTgdAK3VBbhJ6iDfVKFZTZM7OIvZINZPTR/fSp8BCPqymgQwf5fMl213fcPa8vjjhincyjvM8XZjzZ2iH4ayqmostXp9elXFbB07YG6sTdVrUTZJOOOJeabWl/yLyNl58kfyh4DkOJWQoUts2lVkqh2QqnlcgT6+nshzRMppKlS9FU1E//AciBir8HNjs1wlvbImPwuygjwlcdsnjV2i3M9xYdHB7cEcOxgroGjtiThw/dFXODphRwjnXvB8odi5sk+M/9N33G7eEGO/3GwnaO6Ahu0uhJDiUImcpWPlLKwrbbePTmRFfXdvdvR/MzPjq0jPpt8u37wjqhs4LDZSmrITy5Obsec+DQ313QpOsfY2+6ruzrPx3Qo4XZghJPenDBQEn8a0z0sLa3uhrTwHS+VzT0u+yq93ei5RncWXiYVYLv+Dd+i12U5D57pTydqY+vkNjRO1nY1qPwh9YijebQM7O2QtItfv4dsYRlLzQFAaOvWCO3/ARxTnWkcSO774jemZto7yHN23q0z1XyfcKV4QHA863u+9072HzAOW973ux44lfTejT6GQWIjGkHtpzbxpdN/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:59:49.4569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701cf78f-7c48-4c47-44d8-08dc42838986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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

Sometimes user may want to enable the od feature
by setting ppfeaturemask when loading amdgpu driver.
However,not all Asics support this feature.
So we need to restore the ppfeature value and print
a warning info.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 15 ++++++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f84bfed50681..d777056b2f9d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1548,12 +1548,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
+bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
+	bool od_support;
+
 	if (is_support_sw_smu(adev)) {
 		struct smu_context *smu = adev->powerplay.pp_handle;
 
-		return (smu->od_enabled || smu->is_apu);
+		od_support = (smu->od_enabled || smu->is_apu);
 	} else {
 		struct pp_hwmgr *hwmgr;
 
@@ -1566,8 +1568,15 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 
 		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
 
-		return hwmgr->od_enabled;
+		od_support = hwmgr->od_enabled;
+	}
+
+	if (!od_support && (adev->pm.pp_feature & PP_OVERDRIVE_MASK)) {
+		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
+		DRM_WARN("overdrive feature is not supported\n");
 	}
+
+	return od_support;
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..0635f9d3a61a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -551,7 +551,7 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
 int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 				       void **addr,
 				       size_t *size);
-int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
+bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 			    const char *buf,
 			    size_t size);
-- 
2.34.1

