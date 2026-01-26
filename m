Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7625D19519
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AD510E47C;
	Mon, 26 Jan 2026 20:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CJzXScrW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366D310E47D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCXW9lY9y4f2eviGWyjK9n2JucgCBBqLMV3yeFIkxSxbrauiAq0vEcVGyRhj+Ar021it0CcFifFcbnDxFBA7Z8RGKs+RP1SBQXmg4hjxmkJ9w49UBRegwK9X5NrMrFa21isfZzpnH2cJbicuEHygF9DYpfCMcxaOHYgI6JOoggvZRDhOExRr5Crn2Q5BwtmBhzW0iqUhInNYean5LdbwljDN5kHZosDAoZwhSx63qZjtjHMHF1LpnRDgGzwVUovtRTHZBpR8yoH5qsK1IveJmFfxXs5ZEBGdSrMV+gKmMQL7Ex4CUTHEmXkC4UCTK8lMwzXzIYpHRFTRLhAAogaJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX9Zv3XUsUy56qLc2QqkJxC2gMTbSW0uNjx5canZ6oo=;
 b=Ih216CL/83x/RMq5FlVob8Lhsrh2U9TW20urjATjJJO2/+eYsyyU8kSrlJLVev31Ok4q8Rn4aNBEt1Vs3IkrVThIJvafURERDOlLhVBTXSwtrrucilqYqnwKFpJhCTP0kWimM47vkGrovXKXmNOGsqyiwY3Hmb5rgHlncAWTXBvmpyWYYGNgGBFBWXc6PwASLN7aUSsEea8je5xOffSD5gpR37LpQfecIitm49Z+U8zGVK7X1JM9eCgYNexoVoJbM3DN8Nqy36t8KFQXG5GERSzWlWN0T045A+cLcr07mIDASLkXCV+WDXSd3PHjav6dBVWtIyz9caZJMYJcEgH5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX9Zv3XUsUy56qLc2QqkJxC2gMTbSW0uNjx5canZ6oo=;
 b=CJzXScrW1Q428ovHyt3luN+o4h5CiU87GJ1Yj1UlzcZwuK0QKdi451TqC+ZBjtVGOwxZFjPbZlDmUqk5GOjGdWCONTKyYolU138Lw0GVHOerhp73QpQ/9GyEn84F/OmJkXQR2AP6zPkfFg8lnuw+McvZYo2xQFV7C6WeYyfY9U4=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 20:07:58 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ab) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Jan
 2026 14:07:57 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 02/12] drm/amdgpu/gmc9: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:37 -0500
Message-ID: <20260126200747.13527-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: ba23cc76-9103-43dd-6bcd-08de5d169985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S9A7bxoArabqZE0C41ie2TZFYSSmR/wbHSc723E++EpENWF95DLurQH+h/Ov?=
 =?us-ascii?Q?1EV18LKyS9YPkrhwrgN3WD+WWGeAQaz9YNBLQ90HuoTZQ7huVB9azPE0ZCL6?=
 =?us-ascii?Q?wY6j3JmDKnPTfS7VpcW1OeSfUeC73QIkkFDD0RD5BI+GLIv+QQjmDw9bzlKK?=
 =?us-ascii?Q?J+kY99NFLYyNiNuiu+2aMzr8wqHXSIAzTquFPVr7bHOUCnkot6GyBgTZu/MU?=
 =?us-ascii?Q?VHD6yIjM4vPXHmDhz9/RJCRs6HHbmDgSXzpdH+RxmeVzPZxMROAe9sZkQUNL?=
 =?us-ascii?Q?P6aXaXzwZ6db/Alslro2aQOEuR8Zw0Ya7WSXnz8ZNL7zr/IkjpaVwuH0Z/la?=
 =?us-ascii?Q?Dxoa7e01l3pIfR6dwdbR7MLBEfjgXZcy+q9mJ2cLeuYYoTxJcSLjRc6YsD8b?=
 =?us-ascii?Q?tM3uHbdg9dnMk31oGMEgzG6RIQbL5ynPylCjogUMdbwLaI8hDRmdTfOIgkdX?=
 =?us-ascii?Q?MdhdyZ7pNC91bIZwuOaWuLD0iY56MPCVk3jB8sHfTRXZopDJehtqimNF/YjN?=
 =?us-ascii?Q?oXmCQirqyxjXZvbkBHbX0iVYRgKS3006a6hF6LYs4udDTk9XFSlmr2XWz18y?=
 =?us-ascii?Q?sOfdKGaySk+TM+ubZA5aWo2WnBV7wmicOTd2W+nBxlU6EbaGBZ6OsgiLRedz?=
 =?us-ascii?Q?rGOeY32t8q4nqgY1+F3OjGjzsqiCblkLljmfg6g8zM2f5xuHy9sXiP1ebWFz?=
 =?us-ascii?Q?azFmNSYtoXIE45huttPxo6rYMx65QgysY1+6S6WoSfYN2MSS7eQeuQtBtdWR?=
 =?us-ascii?Q?Rtib1/fX3VT54sH6yBxBZ7L5g9s2v748egilqSreSQQXNjvVAbtZib8zzEVt?=
 =?us-ascii?Q?7zST/qVPiQCLhglhnxU2sCGU2+hcB+/R7Gy3h4QST89t3LvXLKuE5N+KN+Zt?=
 =?us-ascii?Q?p28OJd48wlIo3Gi5MbuRh2MX/SBFklMyOhPC/D7/U9IcLqgV8pYjt9uqg90u?=
 =?us-ascii?Q?syGh59R7TVs1923K4vmqUOk8kjCihybYAmoHeVQZ5d4n966A7q3P6RqvXB4P?=
 =?us-ascii?Q?yMkdm9r7fkyYZ1dSjDxRpY7QpRxEjWFkfim6z0pUpWzjp3vTepj8TKCd2sQK?=
 =?us-ascii?Q?kZRZAyvjysE4qniVu2Wkr0FTRnorDiZ0R40SZ5BHJcfeQsqQot4xVMJTh+rm?=
 =?us-ascii?Q?CIjpv0eu78hxGhjnqVGvwV8W9uqQPqPzOuoimCpBJ6XWACh0vMdtSWZrgZVe?=
 =?us-ascii?Q?7O6fN6nOEqfRn/LKXxUM77hDSFNa+6kXCU+7TUUTFNi7+qRdOy8S0onBKl+C?=
 =?us-ascii?Q?v9yG5boqEdKCvHQ2XiSdW8z10cM1uZZVTeiGM5TqiBQOYM0dKGwS5bXdYxRa?=
 =?us-ascii?Q?k2SXH1wGOITz7yJhGJr7q6V3PKN10wvj82oNT3p4ig+PmV2hkSbRrWjjNNuw?=
 =?us-ascii?Q?3zOaBxlDQnNO58YswKoOgZ0syL2kTy4FJUdGHLHQMZK/R3equi6AsUz6SCE2?=
 =?us-ascii?Q?JtrJRtNqrwjM1laWjGDEMqE9NoVOuUHMCVu98hAsIh8LsyZjm2t2SxUw/uxo?=
 =?us-ascii?Q?NR35rAuP9/X+8FRmJ24J/vbFLKNb4enooKWo8+TbBc3A1roet6oIIP3nlIlB?=
 =?us-ascii?Q?LoIIiccNmhkRMshQB8byG76Lmb9hxlQIRjAqVHHGAiEnGwY7Xr573YF+XkQH?=
 =?us-ascii?Q?th3Ubt9qQ5eFx9Oh+j6d9bHpWwi3UfaUvrM742x3CR054rkoELFg1QBDFG/3?=
 =?us-ascii?Q?jJ6EaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:57.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba23cc76-9103-43dd-6bcd-08de5d169985
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e35ed0cc2ec62..335163be45c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -468,6 +468,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub;
 	u32 tmp, reg, bits, i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	bits = VM_CONTEXT1_CNTL__RANGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		VM_CONTEXT1_CNTL__DUMMY_PAGE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		VM_CONTEXT1_CNTL__PDE0_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
@@ -536,6 +537,7 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
-- 
2.52.0

