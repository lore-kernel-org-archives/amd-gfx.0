Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E6CC3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3434810E5CD;
	Tue, 13 May 2025 19:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P19rzzGF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F8710E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNe+OOYerchJ13vnFOTvZPgdEbZ5fR8AD2AtDYucOyzSNsWVbWdbRs9SRNlCf452F3wgS2eYFDr+O8R0x6sO7Q3BCIFI2eobKa7cDb6/sqgmvfoCyqR8IuDsBwbI7N//rmhR2vYMhyZ69uplFQTUz3DEnWhReeNTmrUhLJVgSuSMn1QvCFa+BX44CJWG3xHpD6JyXnZawjd5U3NdN7G+pugmXol2vLW/M1rlNnbCThXstStrJFrcn5N7zIq4twXKtonqkcoMvwIrmsysiG41BnN2jlVuGJElIjh6icQgUovJP640uopja+yWO3z/wmzX3OP/MvQ5IddwCinBaopSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTWIy4fs3ZXgUoMe5jxMR80veASFyWpWaLLUVgiIk64=;
 b=Qbt5ffbstODcIx2vOqKGY5EmarcBQblDQgkbMGLxFWxwNKSdH7cAtYaKVovrrp/AMx/xLSHW6d8r0mzIoq73xPIWl+RDNpbA8KoyHyticRQKqG2SuLl3vNWh+NGZZhvhGMuOWLeamBYyWxVEuIrzoWkC2O0qzcKUzX7Mg9mRlvTBFh6W7x586xtkcOS4K6dm8S5da7RDXxKWrcUH3/xXVpVV8sWRjx4QQbzyhvvKB8Plt4UreWpzfDeFCKHJMIjuP1L618IMN5IfWw5Pby79X6qNyvcnnAEPtR5aZfmj0dggHEv5sFwJUqFgh/8p9lacRtiOhZ5HWoNrPWZxlBiZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTWIy4fs3ZXgUoMe5jxMR80veASFyWpWaLLUVgiIk64=;
 b=P19rzzGFNTC44CL+88Jqz+9JyF9e38Tu1Wfl18FilZcci09bXrQi4tIC8CnglV2qr96yi/VXRPQKLTtwMRutxHHrxRwAeRYgy7wVeymmkGi4QCjBG2QMSV/R/7V/r8Rn0PyluXzXWLJNeoJRhwMHNI9mgCnFEtlTNOSGdDzoyVk=
Received: from MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::13)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Tue, 13 May 2025 19:22:04 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::6a) by MN0P220CA0015.outlook.office365.com
 (2603:10b6:208:52e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Tue,
 13 May 2025 19:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 19:22:03 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 14:22:00 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: read back register after written for VCN
 v5.0.0
Date: Tue, 13 May 2025 15:21:48 -0400
Message-ID: <20250513192148.646359-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513192148.646359-1-David.Wu3@amd.com>
References: <20250513192148.646359-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: b005cc2a-731f-4e1d-9f45-08dd9253713b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P9wqUSkN0pGU0q2dbbW8FNtk8OLT90ynSF6dhUa1BHWshtaj02uuBMacqLZY?=
 =?us-ascii?Q?cXQDfDhafGuDAeDEwzIIl09Ms9YIhBORc/l4qsye+kXX6AhZm2avpXlmutQ8?=
 =?us-ascii?Q?/EhnKfBPD7tKgNQL8siy7nrhsVHJwEgqxRlyqRkDBDwzw8e74S3BK8Dn9mSc?=
 =?us-ascii?Q?guFDt1fPsSccTKvqzBF411dWmbKZO3zLIW/CxNjHIOqPhLeNpkKOLLNvb59x?=
 =?us-ascii?Q?P/I413iAV+6eRvbwI01Ed0pX6dNRU4Pjh6M8Y7l+j1Di/HH/NAIs9h/rMcCm?=
 =?us-ascii?Q?Y82VGkx1u4XjqxmPwidGNtE1geJQQAWMVCKtaGx9vSt1FgJlXYfv04ZHujnj?=
 =?us-ascii?Q?UA/SYlhw3W4f9ngEDfEcuK56ByOkb7jV7l3FGArJCnBm6M0o/K+JKj13dlKR?=
 =?us-ascii?Q?mYmJCkHFxNLgv6cM5fIupAJE9a408hL0N64XaWnk1hgg0hfNSe54AxqwxU2Q?=
 =?us-ascii?Q?2cynVOStSCH0rHR1duD13w+IxZiqjwSiCmXmN/cJ7Ub/+IV/AAP+1whY+3OK?=
 =?us-ascii?Q?33/Evxc+8e6ze6rNcAILqsZKuLaOvW0CAbsOZhqDKXXKmYLGPMYABCKoV21u?=
 =?us-ascii?Q?yF66abkRAMoqt1Tk5rCR6F1F6ii/QIxRUjMTjdwrwB50zHIVSuFTzyYT0TRy?=
 =?us-ascii?Q?WpID6Bxu0rKQVGJNorZinGl1gzvB869QAeTH3rgTrpdlM9IzIvyDMTLlNU5G?=
 =?us-ascii?Q?4gDcnmuFkTJkITenJOU5SrSYfhN8DbPKl9ot9vuG8L02ZTgG6d11KlE03NEE?=
 =?us-ascii?Q?MOCIVO86ZeCB2BlS3ykfzBXBm1Cg8B9C667ZXHH/lAvFg5AesXAZDggj/YiD?=
 =?us-ascii?Q?GZeU8MwGevvs0mS0vceNWRLF3EfD44G4RWpUgp57IwUHtpc3iKnc4k74VdEL?=
 =?us-ascii?Q?qFEvPwrxL8X5Nh0fmz3iKxbOEvFknk4PJuXADf0mBwQvlxvjSsEgNvEZnRAv?=
 =?us-ascii?Q?WDzWAafOBIToqw5//mhk64jG6skPXyO4nwzcKRPLaJHPdsZ+TV7knkZr98+g?=
 =?us-ascii?Q?KFsZBNby6n/4YeIgxm+qgLhF/H/TZWz6WezOBwKM6cYaGFTXPuvxyLUecyqt?=
 =?us-ascii?Q?KKczd9wc79fO8H3UWhp6N5pBgICZgrFAMCk5IkxK8DtLNNffy35cb1G92/m9?=
 =?us-ascii?Q?om7KAXUsa/ORzDrmktaXmuQQaTxJcZ54NB0LkcmAqiI9SyC/ZjAPHseMcpJs?=
 =?us-ascii?Q?dZRwmKi2nbZlNPttSdbLgsCBciEF6Da6/JCc6dbP8Unaz87iOAOTImnwlHTC?=
 =?us-ascii?Q?JUK+yGpH+DonOiAKImxieNbVBTbUbQ8VIw1Zq7kZBNymLPb+JWaYScWLEcF2?=
 =?us-ascii?Q?Bu+r23HZoOBd5JA/iFosS3OtsROm9zo3dQBQRmnDBs3TUuluJi020roy7e9V?=
 =?us-ascii?Q?tnA7gJMtFtUN1lOeE9YSfBsaPhUPgeuHZoROXqdbwsX3fIQErkxhj+pJo9cg?=
 =?us-ascii?Q?DJcbgdXUw2s4HDO0W5zTj0BC6GqBW2zKlywtJeicPwES99QKTEGMmsXlSir6?=
 =?us-ascii?Q?HZ3hx15qL+IPwToFaSszvl506JJueUfWHCtR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:22:03.5717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b005cc2a-731f-4e1d-9f45-08dd9253713b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

V3: patch for VCN v5.0.0 only

Similar to the previous changes made for VCN v4.0.5, the addition of
register read-back support in VCN v5.0.0 is intended to prevent potential
race conditions, even though such issues have not been observed yet.
This change ensures consistency across different VCN variants and helps
avoid similar issues on newer or closely related GPUs. The overhead
introduced by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a73..77c27a317e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
-- 
2.34.1

