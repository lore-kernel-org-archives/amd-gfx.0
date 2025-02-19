Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F109C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 04:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E4C10E195;
	Wed, 19 Feb 2025 04:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MgvvCQ6y";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E6710E195
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 04:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpAKMcCQUrDfyc0FOd+YORKsLU/brYc/d3BBADNgtJVrJsV0sY2Hb5nmIRj+GrJNs19lpKiOqmcXl8a9fWFUbA0Mh2nwND2TIHmijcD+8m724ICeawO28NVVCg3W1jVv0PTKhvLMY1lE9ICr9h15uSaZyc5JN8Q9nyM4gCgx67QQ7G8Loh86BBPM0tXMI8KDdww6kHe5yQGt884YDTBr/cy7r8GhS/C1mrZugDLrPOCR2PHex3ti11nXVMz0Gl/2PNtHSN/8CxO2LCu0tpelSsAXHXgrJeRWJF9SXA47OhxymAoKLh46MWnr2OCltgFzHypu/X7zKyAnh6fQOwIE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWIM9z34Sp09zNKqebT6RAoyYQpUd3lZ1v2g8uoG7aI=;
 b=CDzlESgWIVgMQmxrN4n75J7hTJ7HOfDL3U0d4uTZ1MzKO/s8d5F8BjK9YjGzYka373xu25Ojbl8Q2cE1kW9+soU09uPXoQjzcI5daLgmIBviJPDQyMSpBzIwA4c7FDD4leVQEi0hMhUg3CovTn5Gg33usgjS1LeSiPLFnmj9Ihyah7qWslT2O8e/2VEDYFblemygk9tNFpFFwOpDKJK/hI2ys0E7CqTQBODgQYa6tRZLAw4X8HhRaY2Ol6yIONfahTn4cwZ+otlDLAbHDE+igaWyh4b41qPH+Ij3z/+YMtf4KX2CoT9p0CnJOUXKRAKSlHZ71CRZYRaYjgq7eB5Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWIM9z34Sp09zNKqebT6RAoyYQpUd3lZ1v2g8uoG7aI=;
 b=MgvvCQ6yzC10w+Bh1ERaQPcRlsBH5OXTcYBeaA0TmKKOVoqf9Oj05jF3WtIduQE8PHb8w4bXY2AtvEkYwpMazlQ/6k9+zibeBGC2ugwWO0G56G7NN8N/+PDooDzwvpwG/mK8H4LWyN5cshPzHt9Ht/Nfu3ebP/rRUhlnlIYdkoM=
Received: from BN0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:141::32)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 04:30:53 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::ea) by BN0PR07CA0011.outlook.office365.com
 (2603:10b6:408:141::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 04:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 04:30:52 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 22:30:10 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Check aca enabled inside cper init/fini func
Date: Wed, 19 Feb 2025 12:28:59 +0800
Message-ID: <20250219042859.716845-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6dccbf-7da2-495c-169c-08dd509e31bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YY/xrjh0ZMMcj7G+VzBC5G35WeMJT6emTobppsSP3ngGkL2ub+aNBh3zfXqc?=
 =?us-ascii?Q?CJ6d9gJJO/qOtd4W7pKu3tEGiyMRroKs54TYqCOcsE/DmGv0lkrtiwyxptF7?=
 =?us-ascii?Q?3HmUc3HXLVxB65ETtl6JQj0fGgGynM/QmHzSSxf0kpfJOqj24UJYbUvzGywC?=
 =?us-ascii?Q?cUfdeblBMWgcoVU9761HJDy5LyouGeQKbVNhQYGnf68TzqNHG8CIOQb76Ifh?=
 =?us-ascii?Q?l/sgCuTaM2BSRXFylgOaM8uHv0eAX8Y3VRavl3LNBEJvtNnmeYgEoeCrgTjL?=
 =?us-ascii?Q?s109b++ChPbmTLovVeeA+7yfOgd8OWJHJUbcKjEYsVFjPWY2bVNUrergg24s?=
 =?us-ascii?Q?TkXgEXbugFFpcnKDow6Vn2F8iPppr8q1diQi9Rh/yHcVqZCNBjiErkOZFY20?=
 =?us-ascii?Q?xz6jCiYxL6aMZXXD/5ArAXrDlbNtKhjyoPTs5GYw9Iu0vpfRce2pVkXYf7VJ?=
 =?us-ascii?Q?CbDRnR1sggjeolAKfj48jUvnNmOaA3YpuruJiKEXlyRxTZrlmReWhXBbfAQh?=
 =?us-ascii?Q?48cB5KaUSp25ElmvW33s2eZehv9P9p9N0ujwSCx2cZ0H42LItdD4QC10s5T0?=
 =?us-ascii?Q?5yvCXEaO+kRtzhNwXa6BPxRa2+KvDw5FDzZQQQDAGCxXZbi9F2RXzXYc+a5U?=
 =?us-ascii?Q?odPW28fqPInIULmEPQe3CC2+T8asRVISHL+cP0SYS201dDlKtytWK8a+vPmy?=
 =?us-ascii?Q?UcL8sNik5pxjC6I9G/AWd60A4mkAETqSmYAXU6KJeRMyO8dsGGfGRi0BbBBd?=
 =?us-ascii?Q?6Uv5zCfyOosCanKTolJqJCVjxXy0KrbQ4VoVmjoQ2rGrBmQMZa7m7G1NauIF?=
 =?us-ascii?Q?K8b+OR2joBOfkUHZqsmKuFJcXdryRFfL+5JAbBULFXvjahAicPYe2+lMkCrj?=
 =?us-ascii?Q?WifF23LKbIJnut25ISP7deYRdGioZKNBfIQzGROHXCTI8TvMFJOURM1wryWU?=
 =?us-ascii?Q?oi3nCBCMRKJgovWUUxhFFZ3wwZr0ZYL3zwgYWYzmurhrNAKD3l7MfEbaR0a2?=
 =?us-ascii?Q?KVB0XfCtHCtdGC69L7CJdKvwAa30rrp8HvFRJYXCeO7+s6ko5T8HtPDzB8/5?=
 =?us-ascii?Q?8Fr3lpijel3YB+JIZa3ZK6Y6JasBapw3wYxbt0DViyMVtX1Uk6huZ736QJVS?=
 =?us-ascii?Q?NWgZXkLUCxGKCU7RPs/lXQKe2JEw2CG+G/ntlUoQD9r5L5Bx3N30F+pkJCFZ?=
 =?us-ascii?Q?rPAoT8wFPWNmqN9LAdCM1VgCZHAX/YZVmffaDr2UHUF7j091RVGVjtVXVkQF?=
 =?us-ascii?Q?It7w4rmwjmG13pfgGctox17Xr6P4R6+InKlo77IDgCPVP2pyB6gNH+X6Rx6p?=
 =?us-ascii?Q?hWtHh9caGvLBMDf+DhheyIFTjJ55/628OJzlPIuiX3MGMb7aJOiMB4GaR1el?=
 =?us-ascii?Q?D6cW6lJQM4FiJXXtDpWxLL9n8RQnLRwlGGTt6e/wThHTvErpkzmstgRVCvWU?=
 =?us-ascii?Q?NKMz4umu478/x0FSg/r64EVa97h0b0bSbDg33NDwN4WK6jJpxQa+Lu6iQ7zw?=
 =?us-ascii?Q?2UJd5WWVjvJSD98=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 04:30:52.5409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6dccbf-7da2-495c-169c-08dd509e31bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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

Move code about checking aca enabled to the cper init/fini function
to make code clean.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 8805381e19b9..20c474a32852 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -538,6 +538,9 @@ static int amdgpu_cper_ring_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_init(struct amdgpu_device *adev)
 {
+	if (!amdgpu_aca_is_enabled(adev))
+		return 0;
+
 	mutex_init(&adev->cper.cper_lock);
 
 	adev->cper.enabled = true;
@@ -548,6 +551,9 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
+	if (!amdgpu_aca_is_enabled(adev))
+		return 0;
+
 	adev->cper.enabled = false;
 
 	amdgpu_ring_fini(&(adev->cper.ring_buf));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79dc38c88304..b85e3624a943 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3091,8 +3091,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	amdgpu_fru_get_product_info(adev);
 
-	if (amdgpu_aca_is_enabled(adev))
-		r = amdgpu_cper_init(adev);
+	r = amdgpu_cper_init(adev);
 
 init_failed:
 
@@ -3454,8 +3453,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (amdgpu_aca_is_enabled(adev))
-		amdgpu_cper_fini(adev);
+	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
-- 
2.34.1

