Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1177C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 04:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFD010EA3F;
	Fri, 17 Jan 2025 04:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZjY86Mo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3063D10EA3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 04:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x30nJTr0fcu6SrA5QZVim6oWpj8vpYrr/NHS7z2lq9VqC4i8xTDOt4hMN4lewqs42C+dg5sPgMqBTA7WdS0lm8jwJgreIWdXenGI2gET/dN3Lv1s+JrO7VY/lyzrRCkMumXUJx5Y613sF00bt4zW65GsfY60DMxeZAw1P0uQPfRJVY3MBOS4ptXtyxVpM5Eum2VHysg1Rp/cSwOWY6kKa0mwzX78EqVyYmvnlL5gzrOhkCiEvVTHT+Tkbza+XHu9ZW8S5gOwfhBeX7YBV9zP2VQONfoA951GtNtmkItc3bCrPY4I+pWIzQ6v/1jlWumg35+eNZ081KlgCGGJLmAurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQTTaK9245JlVVVfC9Xb1C4voJIEnT1lG7Gu1bAYLx4=;
 b=ebklVdWMEeMVTRDd8qNfQ+ueC2UfxAlyC2DcoPULkvujIgdcIV77zuyS9hECBzKMCXPTZZ+A6fFzACX4CHMoBNTMDWiRCQ0/y9UIqLsU5JULLIpWhE86rT5bKV/SotTKsF1p9dkGIaqIsCD9sVC532jb1oZWRll7lroHtGpbYQBlfTxoyL9gXbArlEaMTulGR4z765V/AHkM3LBJOCsCnTmLl3cCLvYlCRLz0yMMKaR/POGQJgplvYw8uZYC5mv/VEYmvOMvAd/3Q0qnWGRj8Z/WU6B8BPZFuJj2aGDk2d3qBX5gbyf7T1/Cg7TFMaIKvnxjpGOw+XF87LluzV6dLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQTTaK9245JlVVVfC9Xb1C4voJIEnT1lG7Gu1bAYLx4=;
 b=YZjY86Moel49umK2oQp0X0TLeQeTdEDlGyhbHH3XMrEWkBnyVVr3G/F45g2PmYOJ3owwgUp15nFy2hc82HNFWLU1HcY4fMkLLvH7wXmkn6ch6Yd2VNQMTwo1UuUGlIaGcOFNUAv5sx2MuZle8JsiAczClblmOoF82RU4iUVPsF4=
Received: from BYAPR21CA0018.namprd21.prod.outlook.com (2603:10b6:a03:114::28)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 04:21:50 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::e) by BYAPR21CA0018.outlook.office365.com
 (2603:10b6:a03:114::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.5 via Frontend Transport; Fri,
 17 Jan 2025 04:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 04:21:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 22:21:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 22:21:21 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 16 Jan 2025 22:21:09 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>, Lazar Lijo
 <Lijo.Lazar@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset firmware version
 checks
Date: Fri, 17 Jan 2025 12:21:08 +0800
Message-ID: <20250117042108.3840620-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 429d42c5-2016-4ff3-5e48-08dd36ae767e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4saAUKsNCLQ4CbZ83f9+PAYGtxeZayIqGZ0dkUj149V6Dnzx2LzDAMAsPbs3?=
 =?us-ascii?Q?zTJXBQl2QD4nespCuFvby0ljuXeSmgumwChdWYIodHBrWwCb5LGh0IoQ1I6i?=
 =?us-ascii?Q?RrKdXqT5LT57olOpdIKyX2igqvzcxsYqU7MRTXadYqAhhAwLLugGmoss2iXq?=
 =?us-ascii?Q?kb2r8heJEGBg4fRRSBNaTS+qiMIkwYUmo38l+b1Q/O3oQqAJlAYT5KmDCsvR?=
 =?us-ascii?Q?Y2+wrvezDD8knUc8Q2pa9SV/F07Mx1ZZ4tafGDfx/GFp+7nCB/D9JrzDD0Eg?=
 =?us-ascii?Q?MQOJF9S5ueN2kg3QEnWRXpX3DC+B5XEWvgVBd9tJ86SoR7tIz4wavu775HeP?=
 =?us-ascii?Q?T1oI3nsV/FUITBRWkllXa6StMAslSICbOipr8SgsYxi3JMnUKuz3aFWhJqvW?=
 =?us-ascii?Q?ehlazwl65HzYR/NaUrMUeyjqh30sDQek0ScKzM72SXWjKO7IYZ440EPMKIyC?=
 =?us-ascii?Q?qRoXCI6NBRTehGr6o1K568pu+48jCHoBf5egviJ9rW0QKH+LjL5+Y00AkEM4?=
 =?us-ascii?Q?klRbMesjKbIe62wWio7/N7GvbGT4uKJlyTfj3BzOjWpL3jIJfcL8vf4BRtno?=
 =?us-ascii?Q?9vpOAWBfxj3Bbem+0Z6ArCIdkmSLbas58kb33xOEVgdXiN1Xdpy7i8yIP9j4?=
 =?us-ascii?Q?C5cc3Kvu29CGkTrnZX9qm5cgzSqqyy9xgc45+ymnZ7hXrV6wLvXDINRZ9f0j?=
 =?us-ascii?Q?kIwoRqbiV4+EEI3WwGpy0L/5tYpWaS3pBHvxM6a5AszALw7Y3jjbP1SHAl2Y?=
 =?us-ascii?Q?7EygJ6uCXwyr6rnet74rw9x2HOyuUVw/PF37HeOGuUEmT561NekxzsQq8anV?=
 =?us-ascii?Q?eqIE7BAz8TqOpl9eHNcUwb4eb23kfD/kddqAB3JXjPz4bH4NpxI3ZE5fZ+Xz?=
 =?us-ascii?Q?x5GjqXf3iPeuAZabxrEt3R6nbWTsNCA3Hpfm1LbUnRZmmGpFxQTwgT/ix2vF?=
 =?us-ascii?Q?FkVFmOdFxsq7chBQ64cUIdpbxP9rM3RTLFo7n5jYiUr1Ds458viKPiPkYWD/?=
 =?us-ascii?Q?1xrAYbSH4gj2XZc7auJXRID2L1GgJNJYngvoIm8vDnk/UZbbRou4PJYO1PGx?=
 =?us-ascii?Q?sBImA6PsWit4GRQ8tayU+grwXK3YgG8rt5U10wAIdgCHwvkJlm1aQ86He4en?=
 =?us-ascii?Q?eghF7RVo0eVJ17HtgvbE5HrSROSOHiImZsE1kNG75eYlUSzTo6++2K9DkcQf?=
 =?us-ascii?Q?E1JUiQEZ/pcNt8s5DX+gr7M5LtShke/khzpwmd/Pt5YGHpOt26LGNVmv4zGa?=
 =?us-ascii?Q?5SMPsFs6TzLLqqcQC13MMou6vSZ3OKs4nIjUGicXoHBSq1YnIXM7vPybNlrl?=
 =?us-ascii?Q?xCh/QR3sdnRFz6C3PECey35oue7eR4uUrl6j11KaugB+dlyVepSpqlQBgIs2?=
 =?us-ascii?Q?IA7gw3+tPf47f1V0itKEOvhwy6gk3CTVuBhy5YPD1TR8OxKg1HIOrFsSZi7c?=
 =?us-ascii?Q?3SQ7ymQ/lr3EHa2IwnMMUU2vQNN3QtXgf7mvrx3nGZpfMHWyTyX8tx+fBlgf?=
 =?us-ascii?Q?aem3AxKQvM0qB40=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 04:21:49.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 429d42c5-2016-4ff3-5e48-08dd36ae767e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the firmware version checks in `smu_v13_0_6_reset_sdma`
to support multiple SMU programs with different firmware version thresholds.

V2: return -EOPNOTSUPP for unspported pmfw
V3: except IP_VERSION(13, 0, 12) which is not supported.

Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 35e2f0662fb5..31d9aafe0e83 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2746,12 +2746,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
-
-	/* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 and above */
-	if ((adev->flags & AMD_IS_APU) ||
-	    amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6) ||
-	    smu->smc_fw_version < 0x00557900)
-		return 0;
+	uint32_t smu_program;
+
+	smu_program = (smu->smc_fw_version >> 24) & 0xff;
+	/* the message is only valid on SMU 13.0.6/13.0.14 with these pmfw and above */
+	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+		((smu_program == 0) && (smu->smc_fw_version < 0x00557900)) ||
+		((smu_program == 4) && (smu->smc_fw_version < 0x4557000)) ||
+		((smu_program == 5) && (smu->smc_fw_version < 0x5551200)) ||
+		((smu_program == 7) && (smu->smc_fw_version < 0x7550700))) {
+		dev_err(smu->adev->dev,
+		"ResetSDMA not supported: SMU program %u requires PMFW >= 0x%x\n"
+		"Current PMFW version: 0x%x\n", smu_program,
+		smu_program == 0 ? 0x00557900 : smu_program == 4 ? 0x4557000 :
+		smu_program == 5 ? 0x5551200 : smu_program == 7 ? 0x7550700 : 0,
+		smu->smc_fw_version);
+		return -EOPNOTSUPP;
+	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_ResetSDMA, inst_mask, NULL);
-- 
2.25.1

