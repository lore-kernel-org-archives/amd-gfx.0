Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C1C369B1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 18:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4500410EC5E;
	Fri, 11 Apr 2025 18:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kPsdhBm4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6646D10EC5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 18:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5AHpI4ppSx61KTDlxoFC8KQRJ8uuFWEHUqkdB8fsNrnj62OI4ksNT+7BNfk5uBeDddCcO6kcerc6tksaY5TZTCuHPoDyuzqOOsa2KE+UIkp4mkxW9YoZiRw6rrGQh9/o0QQEN5xs4RR7eZlzQOdHERdasPXjplK6NPfiPNC0rmA0XE+pBh622rHMnxHHH+jxaT+0yKCVHs1Gg/9Kh6jwkxQiTe76mwZ3OyMHSRCVsCOdPZO+/J180QXHwxLaHfnuX9ksz0TVv9QSDez0zzJumx5qSLz5sO+vCU5fDMzTbbK48+uomg1OKdIMXkMFD6Dxw+FncfGqlvJQsUP52sKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MUs/RxMyLwnXjF/FupITOWk9PqBmMdhEHIk7pr1CTw=;
 b=hRcZww6qP5LqtVijkzQCZ6j5TH1wPLIZtD/xZiLmsbluPHPedPECLE/qBn3szZnlN5cx0SDZS25UR3r7n2cRLlSs3yDTvyMZUR8ea8VZtWuJ3lI7ygU0AGAAZcKoI0ZCyxz9mQpK3J/CvnV567qUFHwtoYbGxwXhdAtqxScMA8nk2PGz97ckgA85CZIkDKrlkVi3XIEHLTJ4e7M+sgkpGwbOrKyqiLe5EP/LBa+Ve+uUCfdE3xNROA4Ch+PZK7/pcSuJUD1lKJJNk6o2HeJ6M3tUR+AIS/RJCq+TbpWtm4hCrTp2UUqi7S/2xAiP4Y56sdUMDgE4r+qhkRFg1J4Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MUs/RxMyLwnXjF/FupITOWk9PqBmMdhEHIk7pr1CTw=;
 b=kPsdhBm4EQbZxxzStSLsQhkk3jl2Y9t3px8WGpi2eL3QUKsCiLWGsMYbn2QBcinREZLGmzn31XcknDgFs2zXQne2Va6e7sHMQ27UIF21TkFAbY1BPcgHiHORVdKEyq8k+2udl0cy6QA7M5qIyQa0Fqv2QGcYicfFalDXP7S6dso=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Fri, 11 Apr
 2025 18:48:42 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::96) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.27 via Frontend Transport; Fri,
 11 Apr 2025 18:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Fri, 11 Apr 2025 18:48:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:48:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/userq: handle system suspend and resume
Date: Fri, 11 Apr 2025 14:48:21 -0400
Message-ID: <20250411184825.2890189-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411184825.2890189-1-alexander.deucher@amd.com>
References: <20250411184825.2890189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b66867-a9d4-4fe3-2edb-08dd79297ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aUI0rrqT3o7mr5Z8K5NWMPp8oMrwLkWv54+mlHrxGrHwOeq/N4vUU9+j3/A8?=
 =?us-ascii?Q?5tcPS7VIeU0K3kGNEjp9UwWMPggA1nD7j2mLaif0FyDoyVxBwnyHGdTxX2kV?=
 =?us-ascii?Q?hi1WI/lqxojGErI9hqvxN9A8TXYHOKAhF5UtprDnXl5ozlUF7fXdmVn5lfIC?=
 =?us-ascii?Q?ODlIlXnTRctsd2+dtF/N3WltJRxmd6wyc/JRLC5vS/y/h5RkQKY2kJePbqlP?=
 =?us-ascii?Q?h24NbDbfVSyL7EEH1xAxLg26dCwIqOPUXIDo0jSnv3G/VAbrajEbkR8ED4Eg?=
 =?us-ascii?Q?crkA0HVLScdXwrct+Iv6/w6y4nweWT7npKF++02reFvC2N4nXqBJtrqg/MLN?=
 =?us-ascii?Q?fpT8NxLqbJzTCHyOn4nHjXEOotfH0Cbz6L0QE6IQyPiaiQng33X78TK0bLqp?=
 =?us-ascii?Q?zSQFy8dBvbFH7rMwOp0NgyRHYBfUjy+GRHPQqHWbgv4rf8lhfLwwZ7R+hO/F?=
 =?us-ascii?Q?OHDlI+eaoYFstspbhd1xEwjt1FqVyP2QrD4uhzfEqtkBisdKEcOCZVTFQSjH?=
 =?us-ascii?Q?K7LBCpAzZvPXijOGrG5SAJdM+2vOqfmK30zBlTXQrMVPUi/hplYEn1MeIcPI?=
 =?us-ascii?Q?uVZAzlbfS+mzFr89IK1WvXiJlHVlMNOs32HWE2SOs0HwE0VyeNWSv+XpsZra?=
 =?us-ascii?Q?10hzR9wdsELXfbfhsFnxg8U17U8UIE7cBJDhheJM3KIsXdBslyYRArT4u0sb?=
 =?us-ascii?Q?xFuJZuDOfFRf23j10EqaDkBE8A8wGB0eGv4CxPsqz4fBwSGjcmN1CmO5XqGL?=
 =?us-ascii?Q?Cagnx2RZGi6g6AWWt036t1VnW6mljVN6v+p1kp71oA8TAgPw5G6UjyQsL/DM?=
 =?us-ascii?Q?R0BfvBGYYteOv9zaNPtUOjJyKA0txrRb+5Z/HUJq6xvwpomkj8t5DK3AM+cw?=
 =?us-ascii?Q?QQMY5UR3r8flC2lbasGUiNnoD6OCUNjylZcQ8ecvijG0YVJxA74MULWGs1jG?=
 =?us-ascii?Q?5uDgjQ6Tw95+ZNMp8UAOjzqU5Npd65xe6noLVuBY8Uv+jiE5Si3UqC81u3Wf?=
 =?us-ascii?Q?O7CSExOghEgCBQHYOamTxpNmWFKiEJE5fvgUEF5fi/lkJ3CaHA9wBQw61xV8?=
 =?us-ascii?Q?0yDQ+yxbCmN9Z6SAlIZnRFpEvQtNpkn5SBnIKgvhI6ZN5Sp+jNIPiYmaoz+K?=
 =?us-ascii?Q?eFLOYMgfHqGSo4uuy6GRstaq4MfnUBjk2Q0CiGFGxNmLygtA8F1XNMRMQabd?=
 =?us-ascii?Q?OxwRks0qOqMJs2SoAmBkTiVaDI/xu8M5OQVVDumTrUvHEI/DXgLmSjjqK11r?=
 =?us-ascii?Q?w1dgZulRhqNdGeC0rzPlYba9qXskR8n2xg+se3GKFp2Szr8P875WYE+WDnJH?=
 =?us-ascii?Q?TICDY5nppy1BK4wA63gtJ5lRXOmP/8IEvvRO+DqlPzJsyJODkzgqnHlctYRX?=
 =?us-ascii?Q?twFYLQWdpHn0GfpuuFCDxzldYMKcrdnm5vHuUGToZEcKdlceAF1xOZt+ohT9?=
 =?us-ascii?Q?B5C1k9Z2HsgJQR8Z3MpFsMYPC1cGPBfrWYOdRDN03axuepq1eAIWxgCYb89b?=
 =?us-ascii?Q?hjos0GZjNh5sPdZ2YpvZ4o9Qu2iCa90Y6Ch3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:48:41.8185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b66867-a9d4-4fe3-2edb-08dd79297ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
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

Unmap user queues on suspend and map them on resume.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f212ce3f5d34a..e7398e70d6795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3507,6 +3507,9 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+	amdgpu_userq_suspend(adev);
+#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5075,8 +5078,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix)
+	if (!adev->in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		amdgpu_userq_suspend(adev);
+#endif
+	}
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -5143,6 +5150,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
+#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+		r = amdgpu_userq_resume(adev);
+		if (r)
+			goto exit;
+#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
-- 
2.49.0

