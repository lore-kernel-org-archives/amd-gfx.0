Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D595DC5320E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 02:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4763710EBFE;
	Fri, 23 Aug 2024 02:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bq5SCZA2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4407610EBFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 02:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8pkQSaJmuLraNydaxPoK6BrZsrJ5IpGYlwgmwCik8sIfMYByzXOkHP5NR/JGm3wmTQJKfu/OnHbatjceAGTxkfL0vYNi3LhVem0xB2vQgxMAnOc8Ns9ogLxl4FtiHYqTTNkgaXZ/3wEqQS/4WD1ZNxEqys6Z+8ysaINBKeRkPmnkRD81XeWr21tqc2h4oWqmkfr45bOXoGNDmn1Wq5K6SPD8S8LscJSP7iFzFWp9urf0oLU6lLNT4dw9nKguif4egqQTYPsRhPB6V5NTBGYJabK/mXKZw2JnrlVDh9PF4DxpNVuK8YoH067fSx3CES8MEgIYgrEHEti3/0FqGrlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05O8xHmQz1G6Q1bM6Rr7QUFC8sX6Uc3d+VIOU9HKObM=;
 b=qAaNDwKWNjOhWAUJz1ZIjVoVzZDSgyq9eRzlstCDp4ZUscNkHp2JylxZxxGU7XQEteUhaAvBbdWzhTW1yn46nE0VlAnbPXlT0hrZb4Pzkya58dCNzhaXENkKMX2g0RD1Zl+xzqrAuXk2Uvw0vRST9caHJISjt/wpC70fOH/cPex1p7sx34L1NIaDDxKI8eBzMf+dBum+NCldarCVa0v6jOAgTh3ChQKntXKA+fFgEIngaX8DvHevEjfD4BDu+2udM+Qyd0cwAubak5W3hCKRpgrq/FjpezlsbhkBzc+lsHKxPVqx3lA+mu0I61cl4jK/o4vJekRbgqDrf0+D1kkhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05O8xHmQz1G6Q1bM6Rr7QUFC8sX6Uc3d+VIOU9HKObM=;
 b=Bq5SCZA28dXQRoaowu5NZXrJoDkimtwwkYKyZH2x1KkV+4WbLkriCRBx0zoo3OWzs9sjIdtXTfY/uc6YMEkktDmqALM+Emfdk4G6zv3xcB/1H+H+444ctMCq1286g8BzEfB4AMDzKOvEJ8a0OLG8ykh3d10bYjwl2mV9uktPbF0=
Received: from BN9PR03CA0693.namprd03.prod.outlook.com (2603:10b6:408:ef::8)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 23 Aug
 2024 02:12:59 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::b6) by BN9PR03CA0693.outlook.office365.com
 (2603:10b6:408:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 23 Aug 2024 02:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 02:12:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 21:12:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: fix ordering for setting workload_mask
Date: Thu, 22 Aug 2024 22:12:20 -0400
Message-ID: <20240823021220.9928-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823021220.9928-1-alexander.deucher@amd.com>
References: <20240823021220.9928-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 647c7568-b0a4-4d12-427e-08dcc3191c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bV34F5s9PCU4HjPcrcbMMJW9lQrgneiZxMr5pSuwiO9GpXczDmJ3bIqemU9T?=
 =?us-ascii?Q?qMgH20y4cv3676F6FRhhVE68bQjd85TdJZQwAwRMxX6Cnee8Yqeap+WSOX1n?=
 =?us-ascii?Q?gXTo1Xbp1G0S1e9H8z+Lo0YYvl8r5TSNlBuHFdU0v5KXHeFYbwTcSqf+FBHw?=
 =?us-ascii?Q?3kS8Wz1yJWCbeSLCbFc6ugVSyRWH7Kbon5+TMx+vthkL+5MzxtMIzRIvmbw7?=
 =?us-ascii?Q?h0hD+FIGoRve+r4Tfn8F9QtXBGGySld4qK1Q3j9JQoCU0Mgg5+3n1Huq+yYy?=
 =?us-ascii?Q?s3zYvOvHSLJ9FJ9NvBC+SW9kwt5PUY5LSFpa+eEKKznC/l4SVLIpY6JXmlg5?=
 =?us-ascii?Q?svjhwA4g6fH3nlJSi33Q+XDhEf96l3W7AWLME3G2Ik11yihCMAi6KI+xgLNL?=
 =?us-ascii?Q?VH4S3NgaoTRwhI85/fdz+s1D3sWJpRGjxMZ4o9GpDA0QOL195J7/N/1ssVlv?=
 =?us-ascii?Q?1yKy2l6VUkg7pJHaGA8IAYj7nmMMOEa1wC5ckayl0mZmN8sX6rVVxHkFtumv?=
 =?us-ascii?Q?/B/q1MiIkqWNbqexH9p8khy+B8Oo64MYg9s0nfqurbljn1iIBZLi0cqyhLiV?=
 =?us-ascii?Q?bL8m4rjDrPro3F/p+fLByzZmbkUxnc1ZQtBrMg8Tf0QLG2WamDLDjaGSX0/6?=
 =?us-ascii?Q?VKhvIBniF1pG5W0v+Oo0yhQVcXEHahK2NlmLU/h7CbQGNs512hl/NN/DPqnU?=
 =?us-ascii?Q?tJkUcf4z8j08aIRsBa6GI2FIpIVCNwsbYX/sJt2B7jQRODVCO3h9ULwRiXkc?=
 =?us-ascii?Q?2E7qtAsM9ApjwRbBVdt5Mov/5VqI1dp8XuRuCuB0KVlZjzmFhI16B5Bb+n5f?=
 =?us-ascii?Q?dX8W4TqZ6aLBuXc13oT0YuBehIkGcJgQv77IprWJDw40PrhC8b7SRyoq52ni?=
 =?us-ascii?Q?SfcigINHNcw4wVJ47vIjc6IDjnu8uqDmSv+SrT4zimrVbOyLap34dImC9PFC?=
 =?us-ascii?Q?EFSh2ZKgCfgfkveQUdmq2+ncKO2S0MI7tBXQ1+R8b4g3BAOMTUjCHyUWA1Bw?=
 =?us-ascii?Q?5sekJU1SzqynVRmVNbQl8FmY+ldD6UNAm53vsrEwZ/xbWdZM1DjKceVkAZN1?=
 =?us-ascii?Q?86l1f3kVEsV/+h4TmtySBGfdKSlXbQiWFL5QU+jVUOzm2TWRDpuLluavikye?=
 =?us-ascii?Q?OUrQCbwCtGFN4vLxfvJcRiDfspYthOtMgF5WX9Jr3xvJHsi8wDKf9TGquWUV?=
 =?us-ascii?Q?Cxi2TUEz7knruCgu8ZCSYsIYisnFuQaqvBmTchSlZouDIQHUXEcrimseF2BX?=
 =?us-ascii?Q?YPQPADBiYzW7KwA2qMDiZXt5lnYj5zMAHJR50jIPzQfuQJ98FEgFuj9z4cgf?=
 =?us-ascii?Q?w2UBbge7LZ98FmjgbY39H9BRFhAq+561AKp1M85zn0RhzZPgNaFGGpk8ww9I?=
 =?us-ascii?Q?nfHJU2no8vNIWm/XMhpm0jKrEU80/1U1Sn7gRCe3N+rEtXlUKJmdKNNdZh1E?=
 =?us-ascii?Q?5WGfZQPHD72ubGYm/nDONF6LR1Tj8RHf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:12:59.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c7568-b0a4-4d12-427e-08dcc3191c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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

No change in functionality for the current code, but we
need to set the index properly before changing it if we
ever use a non-0 index.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 74e35f8ddefc..c1cd785b4aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1257,7 +1257,6 @@ static int smu_sw_init(void *handle)
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
@@ -1265,6 +1264,7 @@ static int smu_sw_init(void *handle)
 	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
 	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-- 
2.46.0

