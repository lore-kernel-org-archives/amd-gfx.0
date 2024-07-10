Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCD4C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 09:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A12810E21C;
	Wed, 10 Jul 2024 09:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N+M/q4Fs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1EE10E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 09:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK0Utqu1+wm4FD8KaupmgA0Kx8ZnGOoktz9MtXcfxwKpQdRL6paKfe/XyVNdDD30Etbb5QSCpsPbzjpRKrZWZw15geZlg0mI/f7DqLImeA5TcjR8hiUYYFITbUyWFsduhvxu0Ggr16mtNzqsZzeBIZyekh0bfChFZ3ZDzymHEhlA2S9FTdNAGn9Wu3Jxn5F35Zn5hjMWBauQnroJ8k2LopPZfJbZ58p/hapUM9I/J3a9g82cLMR2m9TvjGvEVMh1/v/OlVsA5RNZvLVPWpl4NPjQ3OcT7MzwLshEnAJ9nrXWZstko+tCMxI8OyZ/9vAHeecIoi29G2lZRqsPq90hTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9akEhXeez1o4AR4iuxjChiDxz4/ml5FtbYG2VoetCFQ=;
 b=KOClQZdCQvy5kzTj7LnfPrEBap4ps5nEqbiwH28zMp4tAKdKDyjyERjs+R9nZkwk4REFu1V0bZdooY9xAgBv+ELwSXWJN9OsIF4gm76mRDcZZc80jgsR54u7/ijp5U2UwaYYq2+ZHOj5ktxKk+6oPZuy8oTsin9Z/lZgOMaAcDKOwQfMpYtgoYMoUNVFiNsoaHuhYV9AcXYsdTef4YNwa06h3q5iXazbDqjE0AUXZjLThs/ccTvfFozILpvLj3NtFyHf7ce2qmWksWNA3ZehFc2FXP6fOYTjfVBioF4hWFxBgtjpF9sT4fNYH7jPhuzVUmKWme7kt8UMiABSNVU7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9akEhXeez1o4AR4iuxjChiDxz4/ml5FtbYG2VoetCFQ=;
 b=N+M/q4FsrSF9sjLTmAqkYQSnFbUFzpFTY63NmkjQxgrccyMJ0G2/t1+7ZQJyE61n9ibTV3xS7CBIQCuBNiTIsZtTOhaWXLVzYI2WhSVApA3kuQwvTIFd7hGNJWOtYRSCzYLQgQhiVBwV0yWlyc1i3Lfza8yaJ0FC7d+sFjv7rlA=
Received: from BN9PR03CA0900.namprd03.prod.outlook.com (2603:10b6:408:13c::35)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Wed, 10 Jul
 2024 09:43:22 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::63) by BN9PR03CA0900.outlook.office365.com
 (2603:10b6:408:13c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 09:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 09:43:22 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 04:43:19 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tim.huang@amd.com>, <Alexander.Deucher@amd.com>, <yifan1.zhang@amd.com>, 
 Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amd/swsmu: enable Pstates profile levels for SMU v14.0.4
Date: Wed, 10 Jul 2024 17:42:59 +0800
Message-ID: <20240710094258.1033943-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6779afa2-5729-4f6d-efac-08dca0c4bd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H22TWyUpKusnCVrCcK3iXGBiNskIWyrk8Kad+wvaGYOfJWuOK8Lefh8smh3h?=
 =?us-ascii?Q?nvfKGM+n1i75tx9SxQr7NdoAnYw1fNwtyHLP19AbfK9kK+RTZBRLzEP8iHKc?=
 =?us-ascii?Q?mjGjAvQz5Yb0f3SF+DbH0qxZ9q/YHuIPRMzqKnyiCzEWYFdbVY+CzFIDHRi3?=
 =?us-ascii?Q?eKRes7nvqZ8QYzVXGGnAUb+bWwIP9YcfMLT9hS0ZLS8Lipm6kN+6ahE1sYfo?=
 =?us-ascii?Q?WyVHkd0+aeOWV/ZtBs5CFYk0jV6uulQmExv3V6HzEnjRPwjiySyOOFUfjte6?=
 =?us-ascii?Q?d5l7+0H7MelOJhDbw4NUxzJjl4iwlP8XzD3O9Dg3VR366rWZ7+I5OVZSWVMU?=
 =?us-ascii?Q?BHk5knFloemkcfVIvQzum7BtbkHFomun15IaMp/wVSy/EjLxoEmjltr8Rq08?=
 =?us-ascii?Q?dtlnoyPRP2Moa2FatxQVu3TC8gw6wvmvu1/VX+OI+VGX1sWLP2a43QqAcLdl?=
 =?us-ascii?Q?IOPC7L/B4BPHYXcB6uWsuZ++DlXY0cJTRGl+cwPV+wQEE1+1ITLY6IKn0ifD?=
 =?us-ascii?Q?5xpDNe0z56d4X5A/YZzRFOWxWPbmWlMi7hEAVrNu/oXnsMQbCcAAUpSKfDgf?=
 =?us-ascii?Q?Zb8TerY7dywHIJdPWpVdmvSO0fcclScyXphxeeCX96reg8lRY+YvnkPHM85X?=
 =?us-ascii?Q?JBNfEFfBgLiZNEZjnsTccV3Ny/MDPqsCeQg2q/3mA0VyYixjkZRKAptLJARm?=
 =?us-ascii?Q?yWc55zrvzaxQ6DTG9i8LfGO0e6Yy6RzkiRMWCq2WJyUsfn9OfqIB1JQl4d4U?=
 =?us-ascii?Q?TYF+7/2ftwo9wd7imxW+dBd+DElb3e7bdjBTseVTXdXzQra7QDd+OvL2rpVl?=
 =?us-ascii?Q?M7UiPTCyjmJeK2UZ3ZJ50ORsJATw6+SvrB1G2j/yacEpUtAvrZDhpJU7whtf?=
 =?us-ascii?Q?qgOzeo0eW6IzwKEx5spmwAVlygojRsqSbuTvzU5YgjiuW7R9qdYjnuxPE+73?=
 =?us-ascii?Q?wUs9zqvdq/PgBouK74julx0G7kLLnQEyT1Xsw1zQKlIxZ8xpgm648WkvkBvt?=
 =?us-ascii?Q?HCNyuvMfYWAXXQog+9eRubLxhLXeWud9I+og6P32X4dUr71Fsp4OyZsUNg3w?=
 =?us-ascii?Q?MQYsh0+mq6RjyddxxpNFlvxmOMcSwhBojV2o+7dJ5MvqgrGjTAmcH8NDRiQW?=
 =?us-ascii?Q?vETh4sKTQBkjc/OSKD058OOV5vLe6r5GoTlbpSeu5nj/Rwbk/rE4E+L/Sd+0?=
 =?us-ascii?Q?G0qL4bfib5z+pFlPXeUVrYTQ1JGFzSG5S5VR58zxK+4XgFGOJwwWsajhrq9v?=
 =?us-ascii?Q?wAtz+1HrKH1UI6xUMC1nY+rCOdun8g3xQAkknLSrld82yLJR8JlYZbe8M7uM?=
 =?us-ascii?Q?RwWb6VEMqn+ePAL3ZJT3qDvZC5KCU3MPWFWeMj88HJs+l04PswcFeoWy4GcF?=
 =?us-ascii?Q?v2Q8zJyo9FyD4F0R6Rt9AqC69EuASmsLNrV7O07SHJ1QFoK9M15J/QGpUfcU?=
 =?us-ascii?Q?IXUDijKBtRorCztp7ZEBuLeRj1aRTnlX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:43:22.4772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6779afa2-5729-4f6d-efac-08dca0c4bd24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098
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

Enables following UMD stable Pstates profile levels
of power_dpm_force_performance_level for SMU v14.0.4.

    - profile_peak
    - profile_min_mclk
    - profile_min_sclk
    - profile_standard

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 5d47d58944f6..8798ebfcea83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -69,6 +69,9 @@
 #define SMU_14_0_0_UMD_PSTATE_SOCCLK			678
 #define SMU_14_0_0_UMD_PSTATE_FCLK			1800
 
+#define SMU_14_0_4_UMD_PSTATE_GFXCLK			938
+#define SMU_14_0_4_UMD_PSTATE_SOCCLK			938
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -1296,19 +1299,28 @@ static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		clk_limit = SMU_14_0_0_UMD_PSTATE_GFXCLK;
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 4))
+			clk_limit = SMU_14_0_4_UMD_PSTATE_GFXCLK;
+		else
+			clk_limit = SMU_14_0_0_UMD_PSTATE_GFXCLK;
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &clk_limit);
 		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK)
 			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &clk_limit, NULL);
 		break;
 	case SMU_SOCCLK:
-		clk_limit = SMU_14_0_0_UMD_PSTATE_SOCCLK;
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 4))
+			clk_limit = SMU_14_0_4_UMD_PSTATE_SOCCLK;
+		else
+			clk_limit = SMU_14_0_0_UMD_PSTATE_SOCCLK;
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &clk_limit);
 		break;
 	case SMU_FCLK:
-		clk_limit = SMU_14_0_0_UMD_PSTATE_FCLK;
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 4))
+			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
+		else
+			clk_limit = SMU_14_0_0_UMD_PSTATE_FCLK;
 		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
 			smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &clk_limit);
 		else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK)
-- 
2.25.1

