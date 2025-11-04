Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFE8CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED22C10E52A;
	Tue,  4 Nov 2025 06:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3QJvU45";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB5110E526
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCGeBBMcNZ2TaALUzwt/2M2tBYSVckV6pcsL2WzSOCAP5m+JpMclx0QffgHxpavOqxo2g4kldKMFPcOqqUhgjOcb950M8v+MwLcByiIyKRb/QdTfH5/gZ6pOfBMcYEmLqsJtleeagjffKtHFPCNAvmAwGFbZ9wrUbvyQm/u0u+fBdWEGxdQRipBy7lgRjvcRO/VfzabiPAWUPyJm+jt+g+9p6NhBZBmbkkDGezAkve9DsRmoTcxFUJQqhwpBrw4m/CxkbVQGMPTIjY1dHUL2IsDaw4fNgeeO5CPJHJ26LXdwMsFJRoJduvipT/36575HJzN8oftZvo+8UBYoXk0gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUyfk6lBbKpacfgFP9gjD/05QzQTCOphGj20yZ294/M=;
 b=OIQlgfcmkRyMFuYpGDNXAq/gstmlrKSouC6cpqNpPOL/VxpKPPx3+Fe6FGuPhLgVeKI5OVH/DqK1Nt8LwuW6Bq65dwx6E+5XGgSFu39r6sb5yY3BXkNwstDiSQarC0ixtbK5ZmGxbg2DAD1y4TqD09GjjKNCnRDee2MhBNJkinm/S7BIZWmZ7YEKPuhpZkWT+jNNvp91yUl1MGABC3LoNW8ZsjRKTgg3s9iuJI1Lzjjm8q0up12JGREMm6F5RIAxjL9DQ60hBcTFWk8U7v5QFF2mBvT8vuizeAKBIbZPjGDQAKTon9UQAL7fri1876rijUAvQRgfYWSa0lGQTJ2exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUyfk6lBbKpacfgFP9gjD/05QzQTCOphGj20yZ294/M=;
 b=C3QJvU45h22OBLxhkoAoLoTjWhjZpnWsoSjGwL4xiHN2rXWnpY1qB66VOg6CmIgLi9ikMzdUfwqs5FHY6MjsXNiwy5oz8NMQ0EiNWsakcBP9JRjQu5WNE6zx67T7LCVus0HT/R/yqmiHgrdyKVA+sSNeCBVtf4hACV2LllVz9yg=
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:58:28 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::2f) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:28 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:27 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 09/10] drm/amd/pm: check pmfw eeprom feature bit
Date: Tue, 4 Nov 2025 14:57:44 +0800
Message-ID: <20251104065745.1737050-9-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cea5890-bae6-4ec9-cecb-08de1b6f8f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n8SQi3tVzPY7qkHicVO7PZ3hkUNFlZ9Er4VB7C8up6+68GQBgrW3LZ3zMbCZ?=
 =?us-ascii?Q?PkKduBo2Ozp0Dc+KI4aXLRVjJxfeXqlPixR4vDcPcHBZQ6l+xIJs7GGKoWMm?=
 =?us-ascii?Q?lo8gBA2kk7UdLUJVD3qLsuUAUQLAAeptdoGZMHA+17If/BkCC9eZf9p8qpUw?=
 =?us-ascii?Q?I22iG6mG8I//iPJyGg5TU0/tN3jBKgZ8PrJ317k16qjQYJqX4bqBSpXyO0od?=
 =?us-ascii?Q?ZkfcBKJytd0WNB39WsMBh1bH07u+H7koO56fj9O5UCrkuZrwUSJ+Y714VuUI?=
 =?us-ascii?Q?s5yb5+dBs/8Or6uWElDZhsBYIWg/BJO01TXGQ72c+XWZn4Lu13f89bH0l+Ik?=
 =?us-ascii?Q?X5swxAot/s0/XIMef9w1eQtSFRwwWOahuBF9iTuvzwWYtHfbmpZtRkWViJ4D?=
 =?us-ascii?Q?M0aeJCBgE7ua90QX8ZiAZ+9kI8GvUpACV/jiSi0lFdHmkz92Mo9hjSTD0hqg?=
 =?us-ascii?Q?1uWxSaA1RyaFILQzlVzE8ekCh+d2Z4KbaHquqIqpWT9hz+uGqJKn75YiKqZt?=
 =?us-ascii?Q?ngbtpUVRGFJLA85DgmlpLs2EQ+ttkWqwrh4nFCPsPm5w6Y0jDlC6y7dX2PzY?=
 =?us-ascii?Q?YeVcbIHi30NChC99L19+FtdLeko8tiP+ax4hROPw3EN+EZU5iTHV5OrfXeHs?=
 =?us-ascii?Q?s9bmOVwIXHLaq4r51F2h4NTwAtRV8GLcFn0KOqIXrvhCFhjGwR1QG53svGHJ?=
 =?us-ascii?Q?3Ff8EPOkFGt4kDeeiRmUiPeCyTYaUGp+XrkbACWWPb78SLg5rel7vT4cHSMJ?=
 =?us-ascii?Q?uImdLaYy+lMpjgW0cqBx/7lf5s9q0fXknoBW+juKp3FuakVyQUszrD6s9ZM/?=
 =?us-ascii?Q?6EOIZZ8NHEXfsc7pnW30P5gDNDca36p6zVY8JVSDK3WA96N9IghXGL/hrOps?=
 =?us-ascii?Q?lULt+Txa+5ZHBpvLR5rPsqvc0RM3NRjblyK7XSND+msgbkUYzX4dq+Z3c65O?=
 =?us-ascii?Q?VLYp2JawUAE/n7eHuniTnicCh1h/L66irHtwUP0Zlx3qXxngF0T7P2tyPfFv?=
 =?us-ascii?Q?nDvD+mrzJ9fCw30WGTg0XSd3wfrVTMEKtluv8Fnul2f+LdHtBLinx1C3Hl9d?=
 =?us-ascii?Q?jLH7cYgnItmIGqtQFEMxKvwONGF8eeWpKhMeGbEigIEfrRysqSgEOokJpcbF?=
 =?us-ascii?Q?cRQme9Ct4QhMYCScVqDoKq8gpsOxL9CJ4PMWSUhchS1cYJqFk6zgopZbvshN?=
 =?us-ascii?Q?/3+/eyh8tASwuvGTeMuIVc4aQA6Fh1VoPP9uSj/3MhX3uWDrp7Gy6NOiRz+s?=
 =?us-ascii?Q?g+Jh3yC5bwFdX07ya87sZhaUK6N46Zc8+ucSQJd8a1jLL2HcApxNCKbiVjnu?=
 =?us-ascii?Q?Qhd6AWjrreThECAQ0P3aLvEWGXNdUhcJWDrVP52qWA5z0waL/pBl9DDAtnQd?=
 =?us-ascii?Q?YqqWz+4sk2satk5lLffickoRaWix/7X8kSkefHaW3POqfsEf8T15bbeBmKYp?=
 =?us-ascii?Q?ZpIae7YWFy4LjEgTgbVze0hk4QLKoh3fmG+BCA43Ot85hz6hh+nyg6Lv/QPL?=
 =?us-ascii?Q?SAGni0H1afqKJaanp+rKXzIbpuMYZCT+Rj5C74RdF5CwtuhyeoogqKP49lv8?=
 =?us-ascii?Q?FEM/74QZTNkqytxWCPk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:28.7990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cea5890-bae6-4ec9-cecb-08de1b6f8f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

get and check the pmfw eeprom feature bit to
decide if pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h   | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c      | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c       | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h       | 1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index bf6aa9620911..fa43d2e229a0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -87,7 +87,7 @@ typedef enum {
 /*37*/  FEATURE_DVO                         = 37,
 /*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
 /*39*/  FEATURE_GLOBAL_DPM                  = 39,
-/*40*/  FEATURE_NODE_POWER_MANAGER          = 40,
+/*40*/  FEATURE_HROM_EN                     = 40,
 
 /*41*/  NUM_FEATURES                        = 41
 } FEATURE_LIST_e;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 9315ce49b396..3a3930ef7ed9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -465,7 +465,8 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(GFX_EDC_XVMIN),				\
        __SMU_DUMMY_MAP(GFX_DIDT_XVMIN),				\
        __SMU_DUMMY_MAP(FAN_ABNORMAL),				\
-       __SMU_DUMMY_MAP(PIT),
+       __SMU_DUMMY_MAP(PIT),				\
+       __SMU_DUMMY_MAP(HROM_EN),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(feature)	SMU_FEATURE_##feature##_BIT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 24aaef1494a4..0ce8cff27bf9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -82,6 +82,7 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_HROM_EN_BIT,			FEATURE_HROM_EN),
 };
 
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
@@ -1044,10 +1045,16 @@ static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs = {
 
 static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev, uint64_t *flags)
 {
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
 	if (!flags)
 		return;
 
 	*flags = 0ULL;
+
+	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(RAS_EEPROM)))
+		*flags |= RAS_SMU_FEATURE_BIT__RAS_EEPROM;
+
 }
 
 const struct ras_smu_drv smu_v13_0_12_ras_smu_drv = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 095f54b7e9e6..31bdaabbd59c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3913,6 +3913,9 @@ static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const struct ras
 	if (amdgpu_sriov_vf(smu->adev))
 		return -EOPNOTSUPP;
 
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(RAS_EEPROM));
+
 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
 		*ras_smu_drv = &smu_v13_0_12_ras_smu_drv;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ecec7af8a64f..367102cdbf09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -72,6 +72,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(PLDM_VERSION),
 	SMU_CAP(TEMP_METRICS),
 	SMU_CAP(NPM_METRICS),
+	SMU_CAP(RAS_EEPROM),
 	SMU_CAP(ALL),
 };
 
-- 
2.34.1

