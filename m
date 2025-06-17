Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A942BC7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA0010E480;
	Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xM2R7eGN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED77F10E3BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q77ZhFvsZ3BJiF2CNtQTJenyhQgzPJXWZ/Q1DMfzr45f++2WFDRhYpTU/16zuogVMdUIgTpLmPo8qQvj8L35zMe4lgxKuA5CUImsLO5ypalMEOFqo8KxANI5eEieHccRklBRwUKoODpTLOiv61mTQ8d/3ANMRriOUnPANp8wqOba3gBirEKlpRm88rLLFdVe522GlQ6+UCfSulL375yx8R3m9fbnpsj2NFXmNuQaivm0pbRmwhNOwqEMwOKe0QwB+q+tAx3zhHP10z1t5ulMiaSRHJVpOomQSvplrjpBYHPCgVGa2pK2lQrRD8yQWLs5F9yKo6tTCWbe+/127uQSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrnoTvjtOxTdtsCdefxNtj6//s+mFwUjwiGOLY1qDEQ=;
 b=CNKOViNbaE+dFm0p3hGWxB9cZ5edPGujbtN9L4VuCLQblac8BjJSDFLykJzVJyOqMnJQKClhjuxjmDkZf3YSnZs0ERe9IuD79qPWdaBtAhp0pwXb7RpC9ezvpzRE8rb8frnfvQFH9D34DbkeNEcQdwyqcBc2Oal+geHsjA+6rbStAif/2jYy7LKw+WMxjbt8KlLeBoS3WE8LZsvbpkEFthfLittXTwnh4ggR3fWnZhThnPApnWHOU1PaVSFscejA5Ld8yJhFkxzkCOeV1XTIVKmQPKO9zadGyLwAOYEMmxaW24RqlzZQlhruevTIk70i7WQoVkSQLv4y37/v1x11Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrnoTvjtOxTdtsCdefxNtj6//s+mFwUjwiGOLY1qDEQ=;
 b=xM2R7eGNof38UF8xhfyEpAhr/pLj8b4iqt4y3JXaMO0dTO5cMkzMcCNGAHS+G6yU3vlUQInXiZy7qVKO5xGzbzVuhW7goNqyt8UjyFWCMthsI5xh8SbShI6QIfsa6JtFjc15D8hdTnB1F6OEpwFfQqF8fXzwPXb/Na8h1RHKryE=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:35 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::a1) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/36] drm/amdgpu: enable legacy enforce isolation by default
Date: Mon, 16 Jun 2025 23:07:43 -0400
Message-ID: <20250617030815.5785-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5c99b5-a210-41ba-336d-08ddad4c3f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkxGZ0ZzVTArMVJCUHhSbkpnWXFNV3RHclJOTE9rck13WlEzN3NGWGtDTWJq?=
 =?utf-8?B?SWh0bkgxVk9KQXBZVzVOcU5HK1pacy92VEJWVjVxeW45NmVjb3ZFTnpaSlFY?=
 =?utf-8?B?bFVwSnk1V0Yzb0REUzNHNU9tVG5kcWlVNW1pSWIvV3UrckJONDBvUG82MVhs?=
 =?utf-8?B?TmZ0TFovcmlXVmJwSEpoNWx2ZjFlS0JBdGUrWnF0RlA1dHpsWThQZ2ZiZGFn?=
 =?utf-8?B?alYvVmp1VjloM0d6SzdUaldlMG9ZODhobTZaKzNKYWVuNXpDdjk3dzl5Yk1w?=
 =?utf-8?B?djJzdlhNMGdXNEJFV2dwb2xmcTdJOTJjUHRxR0E2aTBFZC9ZSXFuYUVZUkMz?=
 =?utf-8?B?Yll1ZlJidlQyeEt0NTVZdElmbDR0WFlMakgyamVFNmd0ZnhBd1BXTzhiUWxC?=
 =?utf-8?B?akZId1I3dkxXWkJiVjVSNXA2S1QrdTdGWkt1VDFBM2lPb3BIY290b3E5OWRw?=
 =?utf-8?B?WXBrSVA0K2lNUk56M3dsMlJ5aTdHdkR6Uk9xczNKTG5BN29RK1RrdWlGSE10?=
 =?utf-8?B?S2ZJZ05RdGV1YXVUSWowZ2l5U0J5RUEzd2tZQUtjeDNQb2hnc3JEVGdJd0I1?=
 =?utf-8?B?U21qbnZvL3BkUXBuN2diM0hrK2luQUhnRUtGTk5Ick1DM1UwYUtrT2IxVndH?=
 =?utf-8?B?NGJoZVE2d2pDRHZZTGZkYi9JWmdBeGxlbzdZVWVISjdvVm1FVDlkeThzazNj?=
 =?utf-8?B?U2pFY2VGM0JMMkRzSG1ST2IrYjFIaldaSEVNU28ybE15SkJidDAwWUI1TURu?=
 =?utf-8?B?cjk0dFFFbThES21TL2Z1aUVmSGVqT2hXWk1Cd0sxUURUU1BNelZ5QUVVNGpt?=
 =?utf-8?B?Tjg5VjFudEU0LzNsVmRZaFlWUFJKYWxiaGR0UHJFV21CYmRqK2tJcXlaYXlF?=
 =?utf-8?B?WmlhdGM1Q1pMVUMvTkpFQUR2WVlybnZaSWxJVmxRL1QwRVFKMDR5anpYWHQ4?=
 =?utf-8?B?aHVXM2pNQk9mMkpaMURLR1ErbWwzQU9sWkcvYU1OVVVHUlFqLzZwOUtqZ0c2?=
 =?utf-8?B?eEF0dXlEWUpHRVJ2VnlqeTVHRXdFNnczcE80dzJPYUxNaERYMFY2cjZJNmEr?=
 =?utf-8?B?Q2QvZm14VG9QMm9GSVNLSHZpSGdXdVMwT0E4UC92RDh3b0gwN3VldGkwYnpa?=
 =?utf-8?B?VCtYVzJHdGlZc280VG1KUHBIY3hWbWwzQlJKY1NXNmxsVVNxenViUDdtcm1k?=
 =?utf-8?B?alBxU0c2cXhpVHBRcEMvcjFLUTc5N1NUWUtkK0pJQllyeG53dU83SEFZSWVU?=
 =?utf-8?B?RUFoTzMwcUJuZDVBSFZZL1o1TnFlUk9vWHA4WG9TYmNwYXZWREErNVRLMEhk?=
 =?utf-8?B?Ty9KQ3A2Qm1QUmJZVGpRQlhFM3E2a2VxdFl4MjhzVmFFTGU4YUdjYnFpMS9x?=
 =?utf-8?B?eHE5blR4a0Z6YTZQaEwvQ2hFVnJmSG5zTmtBQ0U4ZkVnM2ViUllQcFp2NHZN?=
 =?utf-8?B?NUlJOTBpVms2QWZEZXZtSERlTndsZmdSN042QWZVanBqaW5VSjBTL0o2RnIw?=
 =?utf-8?B?UGprZ0VCRG1JQTBpekVUODg2N2Y0VFM1Q2FLV1gvYmxjcTgwQTNXWUhBUEUx?=
 =?utf-8?B?cllDNHFDVVVscmxteDZOUTd1ZGh1MXhUblp6aTBnR1I3M2N3YXowUVduNzNw?=
 =?utf-8?B?amxvSGZVdWkvS3hINVRLWk9BTkVuUUkwMmZ2aldEdnN3NDJXS0JaZGE1eHJW?=
 =?utf-8?B?ZHllRStmM3RRUkRORjZNZUNmNDk2REJjMEtKS0Q3SXZXaXZwTDkyRlg5TXVO?=
 =?utf-8?B?TERNWitMclBNS1JoVWlZQld3T0QrM2cyZ0dLNytPUDBYWXIrZ2FkSUpSeVk2?=
 =?utf-8?B?eithdU1tOHpmOTRiclMrN3EwTjdzcnBFVnBhUW9QVlJCQlIyK09qTnlmLzMy?=
 =?utf-8?B?dzcxZW0rNURiYTdzMDZaa3pCUHRKNG5WbHV4ZzRla0lwQUc4NU5GbnNCRmx2?=
 =?utf-8?B?OXIxVkxoTjBIQnZUMHF2aFJHOUVSOVdNTHRxTDJHMFZFSUV1b0VTT0ZZeTRt?=
 =?utf-8?B?Y1BQZlJ0d2kwNWJkWUd0TGozNE1SdlBaQmErUDM0OFVucUxCakVSWjdTTVRF?=
 =?utf-8?Q?NQlaiM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:34.1370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5c99b5-a210-41ba-336d-08ddad4c3f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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

Enable legacy enforce isolation (just serialize kernel
GC submissions) for gfx9+.  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 13070211dc69c..508546ef55787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2148,9 +2148,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	for (i = 0; i < MAX_XCP; i++) {
 		switch (amdgpu_enforce_isolation) {
-		case -1:
 		case 0:
-		default:
 			/* disable */
 			adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
 			break;
@@ -2164,6 +2162,17 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 			adev->enforce_isolation[i] =
 				AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
 			break;
+		case -1:
+		default:
+			/* disable by default on GFX8 and older */
+			if (adev->asic_type <= CHIP_VEGAM)
+				/* disable */
+				adev->enforce_isolation[i] = AMDGPU_ENFORCE_ISOLATION_DISABLE;
+			else
+				/* enable legacy mode */
+				adev->enforce_isolation[i] =
+					AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+			break;
 		case 3:
 			/* enable only process isolation without submitting cleaner shader */
 			adev->enforce_isolation[i] =
-- 
2.49.0

