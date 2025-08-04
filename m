Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C2C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DA410E44A;
	Mon,  4 Aug 2025 11:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SPEvjaB8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFF410E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7MM+xo8rtWaOay1f74eXT9jsJ+2hQeb7+EdRAQcQM/TST5EXLIMTqmoCnRY8hWvuzrcFS6g+8iPzRck7FHTdxekUaAiUW+TN+Fxb5yU7rXi1Cl9lcaCF9JwINShXkzH+9ZtkR4sxzYLlPr6HjwwcxsieVDYeCFSmoyVc4GdNJ1VdpIJl3qMztc11wRk43o54Z4lM/obSXzKXRo5/0yN5WnIQrNv2gxXR5BoxhUu6Nt5Sfds58G/2pufKpzIdZwZSQ8Ea/TLgzy89W9jzifN6wfSaCBmP1TWKPQkPx2DBnHatWCTMJKNV2uBpAIBdpYjmqOko9EHtorD3PrZxluH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7QNt8uNxhLFj3qojBC6LEzoZXc55+L6elHbgT7lXZ0=;
 b=oug72FlKLL16g10+11l1t3nieUJaXeIL0sm8a43tZnsfV/3Em2gKkCMmWpbmw7QWsbYLN/tQO97g7SSUHQk8zZ4PApe6lhNznnlc1uJGH4pYv6SdEitGKdY8Rw3CbJdx2qYSpkH6BTec/4TAARsEshLmd4KeE/9Z8OgYBwp1dHuVvbahmKkE3jEGu97oIVVD6HLDy1ez26JDktqNqYlZ7+QSeLQnVhv7c4ebOoaoR8dvhL02J6BsFKDkUcHxlR5rAni1wm08SKrhMGRrPtGTwXw790Op4o15XEmobSECWpRhKDm/FKhKw6TjkxIj3ZYL0F5xkONQP3gR9iaYAvS/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7QNt8uNxhLFj3qojBC6LEzoZXc55+L6elHbgT7lXZ0=;
 b=SPEvjaB8AaTusICY9hRVnSjSWsO5vSZ7T6k3wQGm9W/ku1niHiUZeKFYySqcyl5PQPflGjjw+a5M/8c/g/unGtPPjqzAt9Q3hElBk8WLrGs8t5xDzXseZR4cxwra4K4VZiW7gs2YqTdCSdVsQIMciATZBlaWNGxSutL2O8CmD3Y=
Received: from MN0PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:52f::26)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 11:58:35 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::a8) by MN0PR03CA0006.outlook.office365.com
 (2603:10b6:208:52f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 11:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:58:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:58:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <jinhuieric.huang@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Add unique ids for SMUv13.0.12 SOCs
Date: Mon, 4 Aug 2025 17:28:07 +0530
Message-ID: <20250804115808.1758735-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804115808.1758735-1-lijo.lazar@amd.com>
References: <20250804115808.1758735-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a6b1ff-44e5-40ec-3198-08ddd34e3da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z4fQjj9WM8fOtmzBJ0MUfXfNKij1e/DKMkne+BndqI+BWFPP0hocXdy12Wzp?=
 =?us-ascii?Q?jhGF1unhGq6K59Hc+GQMTQ3uXmsX6rJ2dO1dXUtTLpRzJ3nZVDn9wXo876I+?=
 =?us-ascii?Q?aWeKxRQERCFYSxdv+1egPq2vxHvOZdzfGyIi2Ac2OF05SyW3TJltKRGyAVGF?=
 =?us-ascii?Q?jPzo1G35q/horUVfgGdWeqXPL8P4Pm8fMKVf7WRywoIQGDvmY7X4YB+I+kZH?=
 =?us-ascii?Q?pWZOj9cpcrhwwDjzscLu1KyLCo/uaeZA+Mh6Tx67QfmpU4lu50nzBD1Q8N9E?=
 =?us-ascii?Q?KO+RfY9uC2H09j7NmCgknDLaGRDTZZrnhnYnS/uIqilAQFTjV3NyTb61fCFu?=
 =?us-ascii?Q?J5/hPZJQ1CrdamgABHW1NAS7P1Bkgevhq+VXI6AUy4ZvcGHRsGeF1/Bf6pMf?=
 =?us-ascii?Q?/yu5JAcv26L7VwGZa5AWeMiaQr/Hzg/eQ7puQapKxfC4U3cFZahy09n2a5ie?=
 =?us-ascii?Q?SJGWdJYfgI4rrFuFaotFOnX2JHYrhY6DIcwAkN/3cL+J8wFk7RBYo3AifNS6?=
 =?us-ascii?Q?R0O6cyWAuWszwzdEAT5A8NL8vSFrvK4pK22JA9hiDN8rUEQK6dG2H+m6So8s?=
 =?us-ascii?Q?TLNWvSqQxl4PeRom6ODten+5o/oB1f41FUrmmUfW5Y+LU5xs1jqg3ilU3qVm?=
 =?us-ascii?Q?+WT6M7DcjA/AT75aHudUYNXu+m6oL/GAI+ojF0sI1MYPkGfqySQcAd9j01r1?=
 =?us-ascii?Q?xp6iwuszw1PriiAR7K6+kkCEYz+6ANJvEN/08aHTvCWgmbCciOcxy26yY0v5?=
 =?us-ascii?Q?S+vEC+ZBt0WJmHEb8ipn6lGKagLNGt9/9gamSosw7Iqsl1AR99duP8CBv2NB?=
 =?us-ascii?Q?f+9fY8SF84mU48LHQUEbAH2mWjOW3OrFssdL/DGuhtZ5BXbJO0IAdJQ4YjKb?=
 =?us-ascii?Q?c/sSdpzBMwbp9FftFnMUCQvWYUt5FL+k1Lot74Wp5pkPf+m1Y1JNsTZmc0aS?=
 =?us-ascii?Q?U6Bxv87J3Wtn7RCjrc9nKLUBf5zyC+f/4ID4jTqu7OxtTjc6NpuI7DpGS2Ki?=
 =?us-ascii?Q?Iq7UGAygbCSoFCmfviMEPwsmvwz5VAxoCyD2D+qDebGXtSq9RJp2lc/pd1oC?=
 =?us-ascii?Q?FrBzT0oHxkJWIXbLGlNA1ETfspZ7nJzMQ3b+jaZUO0Djcm1dED14i5klxH2K?=
 =?us-ascii?Q?SxbvU3HKRCjt/zJjqBijEbGRBaXIUqMGJo9X/ZSIXvj+v5Gdy4N9cKZkhHhy?=
 =?us-ascii?Q?uOqf4EY9MFwHIdW2OeVL4kVxfpl5mg0oF0U0+kT0Ml4OmgyA2SCWDn/oBLgC?=
 =?us-ascii?Q?T2lusG+UBoNbidIdeGeCyhFWOBysWMH4KYxvGegIxqXLOZQXipQ+ecpNtp1R?=
 =?us-ascii?Q?DzeA86FN5O3XD1gyoNGhYZoDz4GyHaLdnLChoz75tgo5axHHyTVw9z+/g5eV?=
 =?us-ascii?Q?oKA7e0nYz4W7EqXUsCbEPFZlbqezpnN4YJDtD6CJEomHBI5XG5jaJzCvirht?=
 =?us-ascii?Q?dvP5OMByrfqrql9sqN2yu8T+jMdSxcRy1iDpw9JiTwjBlV4rbQ8kcf10mIl/?=
 =?us-ascii?Q?QQP54dGBsGrkGDH/7eEGRtn/EI3vRTER2isx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:58:35.1263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a6b1ff-44e5-40ec-3198-08ddd34e3da6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826
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

Fetch and store the unique ids for AIDs/XCDs in SMUv13.0.12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 02a455a31c25..a1c5781ccb2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -83,7 +83,6 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
 };
 
-// clang-format off
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -220,7 +219,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	uint32_t table_version;
-	int ret, i;
+	int ret, i, n;
 
 	if (!pptable->Init) {
 		ret = smu_v13_0_6_get_static_metrics_table(smu);
@@ -259,6 +258,22 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 		/* use AID0 serial number by default */
 		pptable->PublicSerialNumber_AID =
 			static_metrics->PublicSerialNumber_AID[0];
+
+		amdgpu_device_set_uid(smu->adev->uid_info, AMDGPU_UID_TYPE_SOC,
+				      0, pptable->PublicSerialNumber_AID);
+		n = ARRAY_SIZE(static_metrics->PublicSerialNumber_AID);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(
+				smu->adev->uid_info, AMDGPU_UID_TYPE_AID, i,
+				static_metrics->PublicSerialNumber_AID[i]);
+		}
+		n = ARRAY_SIZE(static_metrics->PublicSerialNumber_XCD);
+		for (i = 0; i < n; i++) {
+			amdgpu_device_set_uid(
+				smu->adev->uid_info, AMDGPU_UID_TYPE_XCD, i,
+				static_metrics->PublicSerialNumber_XCD[i]);
+		}
+
 		ret = smu_v13_0_12_fru_get_product_info(smu, static_metrics);
 		if (ret)
 			return ret;
-- 
2.49.0

