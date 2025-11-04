Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837BDCCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD3610E17C;
	Tue,  4 Nov 2025 06:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5NdDxINv";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B199310E17C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xthh8vlrhnwyH1AllMQqpc4KGm9RI4zx5T95usTL5y/zUQr2SsH2YWQuF5LfkjSl8SwxGq+IKuOM//8r2DHyyWrw46AkUnQoRMILAp5M2ZIF1rPV35YeSrq8Acxb6L/ZDaTDK13fmIXEPYRwWgxN+UwfxjEGrshGcaFtSBVERqB08JNDBE+G9MzxVygjTfFubak+zbxDiVm8X2tagzjgKI9TXMsM7yPl4ryGY6UftiUUYUwykCUzz/KVRvHISMdXbrsHXVYqEbA5OCF7Xs/XDYYeItmbn6FhM1O81cwH7sp2hXni2moT3InjqUC+3hcmUGp4iLDcqVllJMjoGmFmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGuZkEcsseCuTYMZy0tVIggoNJBt1Aj7BzmBEMJvO7U=;
 b=Zog4XUs5aVVA69R7s55pNJVnUhT/VqAB/A+vGHmYy4yJM+DI2QQGFAntpEzI252xLupl7wrzMAM7NLD4KqraHtVOafMfAOYj8LQfTXiE/w5wO2Uq1rVwPYsh1YpJrts/+iV3OO+wfVN7AK8psVBHOTB/uFRUujWF/+wv83BOlp1TUMRmeTRMhgwkCxycuWlgL+QrRdXygCxhxQ4xJcM2LA1nbB9hOyjz2nFsSSt7tuPegcrNxFdt2Vfnb+GbDrF/Y11ISqUe8eJaR1pLMgtSvD4oCWsVrGGLWKKeliwbA8UAXZAv2qlJf0v6/nRmYv7Y5PRYyVa+OZqABSc4w5ebjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGuZkEcsseCuTYMZy0tVIggoNJBt1Aj7BzmBEMJvO7U=;
 b=5NdDxINvwiJ8Qj5LxUOcNYFlffoeZHzvHboFtMGVPwqqmrNyqTBZA8bMxMiqIqYZ9PeT73Tcq/dTg7tPKtMkDhT3X4JNX+XZ+tkkTWvVfUTOO5+jAHIZrOmmFnkiOfu3xThyqtWfW9U2YxB2PQhdXaOZyCNfINDWsijz8baizBc=
Received: from BL1PR13CA0371.namprd13.prod.outlook.com (2603:10b6:208:2c0::16)
 by IA0PPFA8EB66EE9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bde) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 06:58:12 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::cd) by BL1PR13CA0371.outlook.office365.com
 (2603:10b6:208:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:12 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:10 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 01/10] drm/amd/pm: add new message definitions for pmfw eeprom
 interface
Date: Tue, 4 Nov 2025 14:57:36 +0800
Message-ID: <20251104065745.1737050-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: d073e483-2c55-45fc-fa18-08de1b6f8521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEFcjt2esjU7x0KYW64GWpi37UUw6M80EvcgNytW0/921LyuqLN1kwxa+kXt?=
 =?us-ascii?Q?0o6uOTQaolkeJ4RFv6zrT0i0z2XcZr8BkfiysmZFxuO+FGXvjICvlpGMlSkJ?=
 =?us-ascii?Q?4k2m3sklDBPqlya1nVl5duKcd+oIuMd5LqqJU0txq9dXx9m2lq40gh+zf8zZ?=
 =?us-ascii?Q?lNoCV5/8pZ9r0rr6nv6kYoSJHi9zzX5UO6BYeZjoRCP3+cnhl0rO6Ie7ni0a?=
 =?us-ascii?Q?95ytFtupAZkPOfZlO6nbOTx/+VzphXT3Pl38CTYYJvKcaodkjy/YPueP/wGU?=
 =?us-ascii?Q?ojwn39ymq0z4E2rDvSgAJ9d2HyfJxcXqsSbMNpK0YhSJCsfr3ihp/iH2GN3M?=
 =?us-ascii?Q?fj8QNdezQs6cjhLCxujGQToYrsBMpucsK6paJ5IOZdEr5SJMO298YhW+OOQR?=
 =?us-ascii?Q?wnMfFcGGoBY6ftdUVAkt84GAzKTVrlJBB07US2khSzRStK0wjiCStemP2omg?=
 =?us-ascii?Q?pCrMLWzrMzTdDHEBU6u61ZPNaDzvdWHRZsbvecz7GbbzlGNFKWnJWjde10GY?=
 =?us-ascii?Q?pCCSW39tX1OyfKmLd2AXQQTATFgZclJgqbF0J2YBpeXxCSIj3aPxyvvKmyhY?=
 =?us-ascii?Q?Ubjr1DkNjaEpacbGulsy1R6tguKuGM2Ygmq7ZrJyrWRRafTPsVgZ7JCwomeh?=
 =?us-ascii?Q?zPMfvL1VXEXOBoNwZIf/I97uFC0ZG7IKKStfkaFJ5n/aWTRoouZY1fn+AtuE?=
 =?us-ascii?Q?wlD+fRCwSo+PQf1sV9w8RSaC6+t12jXHpiKQJ/R6RCRwMgAmbk3HCbjVVXbR?=
 =?us-ascii?Q?bFFYWzC/64fL9yYJ94/ze6Im2DTK3xj4gYyyNjcGAZpx1HV0b1u8xNhFwdcG?=
 =?us-ascii?Q?ms+ECckJhOMayf9zP9GkOQe3CFEN/WTLxu2CuJMpBLrRxCynAMyW3C6/7BHn?=
 =?us-ascii?Q?s+rirvyQjVCZFVCpMxogY4ckcHv5GehUFGCjHW64WcD49emTpfbEq2RSXxxp?=
 =?us-ascii?Q?cHLWItY1FbEXEwlOR1zD8Q4cI+lhD02MRgicJCnkQYOYFTpDywF+VnyNEw58?=
 =?us-ascii?Q?/rfDT31UzSg/DPKvMGrHOcIAv4R9Z1Ub0kRt2/ekWCHGooQMp4kcCRjdIBXA?=
 =?us-ascii?Q?GwyjiR1/SIUoMZoPNBi2jsbZa9oykQcRXCeQoz8HCLCpppvnVRVhRq5PfZMB?=
 =?us-ascii?Q?1jYvwauRcqPWIdiPZomxDRH4GbpzZROLxedF9FO+x+J0XhLHMkErZACvpVzk?=
 =?us-ascii?Q?f1Qky3nk9+O+qK42qc5TEciKkWF3crCtbdWk8zP2mJJwmGiMhKz32CDPBzfc?=
 =?us-ascii?Q?zB+MeWXAebBZmwFzPWQwF20bMhD0S37mHs8w62XbHfAokKCFgXrm84rV2Oh6?=
 =?us-ascii?Q?VlAANhUoo4E1VeJ3vB/req+2TmuE5vOxDijWsRdYFTvsjeB/F6bP82B/AkIY?=
 =?us-ascii?Q?fbTzMNCv6QBcbDllu+03/tEC4HIz3XnVcp80EZ1ZytDGvoBsQXWBaohKvZet?=
 =?us-ascii?Q?3ZeI7xa12qnGydHe47JTOOJ18xFMTjhmU86bnqJYhZWsKgUX4HmzzyejxcyQ?=
 =?us-ascii?Q?tklBdDl3wfr0XhZmAnLtw1HiMKt/45bMv1K/lBNz38fWkZzsOK+liW1VHgQD?=
 =?us-ascii?Q?PT5E6XFL0ipl4N3K354=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:12.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d073e483-2c55-45fc-fa18-08de1b6f8521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9
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

Add new message definitions for pmfw eeprom interface

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h    | 16 ++++++----------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h     |  9 ++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c    |  7 +++++++
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index 4b066c42e0ec..fe1b3ac50a75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -105,19 +105,15 @@
 #define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
 #define PPSMC_MSG_ResetSDMA                         0x4D
 #define PPSMC_MSG_GetRasTableVersion                0x4E
-#define PPSMC_MSG_GetRmaStatus                      0x4F
-#define PPSMC_MSG_GetErrorCount                     0x50
-#define PPSMC_MSG_GetBadPageCount                   0x51
-#define PPSMC_MSG_GetBadPageInfo                    0x52
-#define PPSMC_MSG_GetBadPagePaAddrLoHi              0x53
-#define PPSMC_MSG_SetTimestampLoHi                  0x54
-#define PPSMC_MSG_GetTimestampLoHi                  0x55
-#define PPSMC_MSG_GetRasPolicy                      0x56
-#define PPSMC_MSG_DumpErrorRecord                   0x57
+#define PPSMC_MSG_GetBadPageCount                   0x50
+#define PPSMC_MSG_GetBadPageMcaAddress              0x51
+#define PPSMC_MSG_SetTimestamp                      0x53
+#define PPSMC_MSG_SetTimestampHi                    0x54
+#define PPSMC_MSG_GetTimestamp                      0x55
+#define PPSMC_MSG_GetBadPageIpIdLoHi                0x57
 #define PPSMC_MSG_EraseRasTable                     0x58
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
 #define PPSMC_MSG_ResetVfArbitersByIndex            0x5A
-#define PPSMC_MSG_GetBadPageSeverity                0x5B
 #define PPSMC_MSG_GetSystemMetricsTable             0x5C
 #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
 #define PPSMC_MSG_ResetVCN                          0x5E
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 2256c77da636..9315ce49b396 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -279,7 +279,14 @@
 	__SMU_DUMMY_MAP(ResetSDMA), \
 	__SMU_DUMMY_MAP(ResetVCN), \
 	__SMU_DUMMY_MAP(GetStaticMetricsTable), \
-	__SMU_DUMMY_MAP(GetSystemMetricsTable),
+	__SMU_DUMMY_MAP(GetSystemMetricsTable), \
+	__SMU_DUMMY_MAP(GetRASTableVersion), \
+	__SMU_DUMMY_MAP(GetBadPageCount), \
+	__SMU_DUMMY_MAP(GetBadPageMcaAddr), \
+	__SMU_DUMMY_MAP(SetTimestamp), \
+	__SMU_DUMMY_MAP(GetTimestamp), \
+	__SMU_DUMMY_MAP(GetBadPageIpid), \
+	__SMU_DUMMY_MAP(EraseRasTable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index c6cf0d0c4b82..f2e3cae43fda 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -139,6 +139,13 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN,                        0),
 	MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticMetricsTable,           1),
 	MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemMetricsTable,           1),
+	MSG_MAP(GetRASTableVersion,                  PPSMC_MSG_GetRasTableVersion,              0),
+	MSG_MAP(GetBadPageCount,                     PPSMC_MSG_GetBadPageCount,                 0),
+	MSG_MAP(GetBadPageMcaAddr,                   PPSMC_MSG_GetBadPageMcaAddress,            0),
+	MSG_MAP(SetTimestamp,                        PPSMC_MSG_SetTimestamp,                    0),
+	MSG_MAP(GetTimestamp,                        PPSMC_MSG_GetTimestamp,                    0),
+	MSG_MAP(GetBadPageIpid,                      PPSMC_MSG_GetBadPageIpIdLoHi,              0),
+	MSG_MAP(EraseRasTable,                       PPSMC_MSG_EraseRasTable,                   0),
 };
 
 int smu_v13_0_12_tables_init(struct smu_context *smu)
-- 
2.34.1

