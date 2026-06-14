Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31B4CD8CA8
	for <amd-gfx@archiver.kernel.org>; Sun, 14 Jun 2026 21:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4303F10E11C;
	Sun, 14 Jun 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a36aKSrq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF42110E11C
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2026 21:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLBs59PhM4WQmOJra9L+3HJUrdXIlWmdbfhNdRx9xDL++AnV1pv2XC+IRNWSfz5HFJ986O7yAIux+0mohztfgOkUxMk6f/NvkmneXbDwnOVg+xBQKxBW9snhrS4tiJjA5HjEBEvk+hnCqhf5QK+s4rDdcT2/hq6+lJdlm/JySIaGBuwisIy5QIvROrRiIjzwTCz07WsKUSeMxP3wsGqpI5EromzhatW+0AyRGBOmWSdVweNI6g8Jq1xcwgOGRprl3EFV3SpYeDs/S+4BJNzUxPedj1YoE5MnZSDouAN+wk478Wx+tppXzusiu4bvuYpKOGVYRcy+ofzqw3CEBo3NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpRpRxntrtgLzqHfJ78lQHHiw3ILQjeQgpdJpdMzzpQ=;
 b=gHn9+KDOGoz8b7Jvq6aA1iEv8C+CbvhrTSu034ovwTtTkkI1gncQXp+t8zWPU2V+8IrADJ3aStBAfRiWX++Of0zw7BfUxTWWiB0ZnN+XFc5qgKYQPN85KGmgMyjBEsKbG+T2KPvDteXcn5T6XAe0hXu0KYwsnvEAa6K6yMGBtyAGdkx6mwb+vaY1i+QF43TExzxuBZzizk5IWw/v5weylpjCy5EwEa2sE0Nvuwo9f2qTUVNn3EsOKAHh9EHc8S++8F28UGEFYap/o7JOuPMqnY1jYk2AYxPLBEyw8EdC6lSXdrI9+m8zhO1XgWcqUgxVRPWHUHp/UHnD+OukMi+BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpRpRxntrtgLzqHfJ78lQHHiw3ILQjeQgpdJpdMzzpQ=;
 b=a36aKSrqo4NMZCRNCVi5M0VP4Y+ds3gI/m9SzwyhkWcBR68cp1m1CZzUfH00AUxYbGgG8+JRvADTH3tYgoLjqpLtbtuFLkwDEx9P1fnXip62c/GrCS56NBXlBuhwrbMWOG5WvQYGB7oLwiVcylcUSEqB998eXdRuYxZkJkH4uPI=
Received: from SA9PR13CA0101.namprd13.prod.outlook.com (2603:10b6:806:24::16)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sun, 14 Jun
 2026 21:15:37 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::4d) by SA9PR13CA0101.outlook.office365.com
 (2603:10b6:806:24::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 21:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 21:15:36 +0000
Received: from rocm-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 14 Jun
 2026 16:15:35 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jesse.zhang@amd.com>,
 <shaoyun.liu@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add gfx12.0.1 adev to queue reset support
Date: Sun, 14 Jun 2026 17:15:17 -0400
Message-ID: <20260614211518.2125426-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9a0c52-30f6-42bc-2302-08deca5a1442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: a1IHUTMiVTnpcR7MZfeUzzEbc2s0nitj+mrKKQzjuk8aWwzFMyDjhq4zATQMUGv+m3rfqYdkyX35+jVn26T8b3zfHTBg1emMg5x8m8/MQLxHn9I9ZFfUs8XwEE61Ww1QNBp0g7embLvD6GJhQmb+Xf8/US+7QIAjc6tq1nBhcGNSTTt+MyL93R6X1MS9RqmXsxonnreCOvmOLfZwlYBOaSeQ8Ru2fpjeOM909oAJWgd8e8M56yq9znh6U1vFlo76ksFkHtfix2ZJg2/x1rQbxIEKoKR2dBTWjWSOIkgbJbPOmkc81+EiDrdA3D/UCaODQYu3IrBFzK+9g8uCyw6vAiWAgP0VH7ifJD+PUX95yEeTXMrGJ2bmnyLAmvGgsCA6SdRY0nYf7al5VTYFXB2XgTY2lPEL8EJBScwbO94vrh1e0Ot7zh+/Ds29hcTkLX2STeemEwHBG6j69NtAV6Q52gmsadtrJdrPJpkqTV6RcLWDylNKc5zHvA9SGhtztYGDwFQXXoG5GOQSkabNplHSlLmRa1O2Pb+zmKlfBmumKxIVjaISjr9A8qjoQcwJ/7UCCEWf76APjgNqrDvsb1oQwhnq2oYgSXoSqcg+ZN1Ndb1+b3dNgfqdHhdQnMP1vIg2kpYcBFF/16NR7ZmeLpOY2zD2nV+RmhUapys67sQIaZuNHEZ9D9goVTfxbDJMEvArwONPyUl9OHytl2x+05j7hns203uQx+dhA7dcSwMkSWk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AWh29htBxwIqWxkxwupvvBmGG4EKdS4W7TNFj+PhqN+SYyUvv90faWFtkp3Bc05fuLM2/vukDIpMXwgKA8yt1s01mSG5vdXOvcDJCjNMFnnRDo1RSA0jkTRDkNsns/oS3tJcnAFUo3QmsRlmHFDZFBanBSBlGsAzL+TNM4S3r58l4SG6Ri7tJ0UX5qp6CR3Z9qDrggEy493rYBiO6pK9vwTlthBJIez9d9EteXkcKpgSFZWdEPeW94qETnGcNulBJErebbTmv0vbTFuHjTCcX//8/RL2sGmRnWFDhKmMGoYZRN3rSO/SoSUAGG2Ex15vTtNhW4+TnzlUTwDu6sPaMkS/dhgOjCbyOkyGV44dlDv6rZbW7WkKr0JgPywssGirHuIywFe8GGf5Nm+homX/O8XlxlvmW+S/aHY50D5IcxAGlvX0oqPDM5ub8gbQF5V6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 21:15:36.8312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9a0c52-30f6-42bc-2302-08deca5a1442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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

This patch adds the inclusion of gfx12.0.1 by cheching GC's major number
and minor number equal to 12.0.* with the same mes_sched version.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 020d9c512306..6c0dde3786e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -864,12 +864,13 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 
 bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
 {
-	return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
-			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73) ||
-		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
-			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8c) ||
-		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 0, 0) &&
-			(adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x8d);
+	u32 ip_maj = IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0));
+	u32 ip_min = IP_VERSION_MIN(amdgpu_ip_version(adev, GC_HWIP, 0));
+	u32 mes_sched = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
+
+	return (ip_maj == 11 && mes_sched >= 0x8c) ||
+		((ip_maj == 12 && ip_min == 0) && mes_sched >= 0x8d) ||
+		((ip_maj == 12 && ip_min == 1) && mes_sched >= 0x73);
 }
 
 /* Fix me -- node_id is used to identify the correct MES instances in the future */
-- 
2.34.1

