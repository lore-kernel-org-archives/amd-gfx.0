Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE423C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 03:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726A610E26C;
	Mon, 20 Jan 2025 03:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x38Pc+OP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F7210E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 03:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAFBAFJLWippXEiTJPj4qQ/RRmbBgAsZo7xyhOHt7QSNT+4Z/A8c7tV4u1Bu+nvLSx+uNfM5ewCRcWVOERl6h3sP75uiL9b0AE/OlD6Kgnhn/J3fUVTRH4hzU3RvmxsWWfTNnUCAh0lV6Yzv+tuIs1zZ/Gl2FTTKRsK9J6ctgIMR0Oqdnzyx9zFV0X3Vqz9Hxx4tSkWGr951J38/JoWiSRzvJWdS0LrhyJwXI2C8zsk7dzBzarNHwxBEvkKdeQOlNW825TEFUlWVZ7uZUoFBXlDrrXECgTK4GfJaCqp4FoOeR6VDKCRGwPaJvY3llz68ajghfbz9gBRmjFR3auOtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL8iCv1dEdE6EVRa6kOIJ1XFyO5BH1WgOqvf2xyfUhU=;
 b=k8XuV9+3KRslfGrmq07NWDXvBjTimANYqR4nT2HLVOyH4F0fUa3HN7RqKkX846c9kiHJvCcpenyDW3xpuJgeLxmoFi7QFi90aYFFXZa2k/Rc1h9366h/UMFw8EFADTTFdZC7hdGF9Hh9iWH9c4ORKqe+889zG+DyQAol7QdVdPMVByXjMDT6qv1h6iU0ddtEnkaxI+MEoIx0W1X4xem7TA5CabIcYrztQD+l3pHrf57EM7aU4fqehY9i/dXoljETkCNqmyWGQhckcjURjHCsliLVLqlMr4IjloilzZs3jd01DLD+NDjrvrYvDjqp6YmmzDH0TPGpvVlQ27kb+bDipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL8iCv1dEdE6EVRa6kOIJ1XFyO5BH1WgOqvf2xyfUhU=;
 b=x38Pc+OPK8B0/W+xr6dJ9KVUpO83I2VaGDvcsng8jC2rl33F4FQy8GIF5izsXhcINuQeBYM9wCxTs1KifZSFb54QfFD/Wx1d1L8UKnwT0gpK6mFqRuHF9A4rJKwaCWd9H4QcH0/nNSTfEnLf3KL+lYVMRrD9rahY+ccFqOwK784=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 03:50:52 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::83) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 03:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 03:50:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 21:50:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 Jan
 2025 21:49:43 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 19 Jan 2025 21:49:41 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>
CC: <Horace.Chen@amd.com>, <haijun.chang@amd.com>, Yifan Zha
 <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg mapping
 table
Date: Mon, 20 Jan 2025 11:49:19 +0800
Message-ID: <20250120034918.1835607-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: e9754b84-a6eb-44a8-51fc-08dd3905a2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/5gYz6dCSbs5HHZeXPruorF0FtBSH8/DTHERPxcq+d7+kVSlPm/t5TAVWrS?=
 =?us-ascii?Q?1Mx6rLBaTW0YqnFeuuaWNL/Y9vYalzmY+xTO396E8RTEr3MnKYDInMfg/8L5?=
 =?us-ascii?Q?4ZoJGQ8E+BIAuqaw+DPVrEnX8rllVYhIJFMms07JhFGiU8fjrTUfZpQrLUtH?=
 =?us-ascii?Q?1R7HOcSXykZVsLKCjj8aYLNjNXO6NwWlOZSsu+RqmgjgmspbKyZe15EqJ5QE?=
 =?us-ascii?Q?1SSU5NhJmxtZvHIhpUIl28FyUKXeTlrmRKbL5sixZN7AK/rVJI2DZefIcyw7?=
 =?us-ascii?Q?CIiVwi2hMYMYfacgDVaw0VLvMUnHOV5BUhyNSbsR3uxeEIxnEvpuqUznHP+k?=
 =?us-ascii?Q?7ApYdpd2EqoOqojIIbOplCunVn4yQ/DF6nvGIM0c70YGFuleB/eLZbeYPJmH?=
 =?us-ascii?Q?URFhghsfYCz75Jr4Gee9LUUhwWMvCA+y7STZtUMqP850RWbvcO+AvNxb2mIj?=
 =?us-ascii?Q?4GPPTOiZ14QtU3vnrmZiouqmpl04BrbspzkfHziCtiXXg5ByAsDXN32ZEcQC?=
 =?us-ascii?Q?Q+vx738UzL9JzrIo+IUMxD66s7Uof2whAUmHCsDRQKJuqGqd7wX33MeSwgDh?=
 =?us-ascii?Q?u8W3093cirYCc3TPx5nuZxmPeepjl+zRDxsmJN6WoUCSmmiq1k/31WRrpu26?=
 =?us-ascii?Q?Gaoj9q9fx9Ok9SDtmtyaYSKNyJEgq99LGrdkJGbvDevD9LC7sMETi3zSDxbc?=
 =?us-ascii?Q?zkQUqUc8tB0PUsDBcDDelyyvAw/U+W2z/6n16vhrrrt2zteoDn7QBiZ8MneQ?=
 =?us-ascii?Q?Azr1oz04FEogcgUlIoEap18k8cDVUN0iAOot6L/yq1Uw3bS4tbLme8HhJnnY?=
 =?us-ascii?Q?KChiKiItGkqVnBtY+xFa++ywRFnvYLBbKGalAa1Fm+SLwWkWFhU3vowaPYjx?=
 =?us-ascii?Q?kYl3PDCTW5mQhJRzjy9NLRU37WJ3hN0QHy2dq0kJHpn8Q1YRUjfJ4MTcJ9NU?=
 =?us-ascii?Q?zwc4VykkfW66TzosFX/O2aqONlg7tfr4Tn7B0gBaD5jPu3gfHrYNhZQug4s7?=
 =?us-ascii?Q?+DvlSqH9UUhBs1gcBOThnQF3StS1lZtlmLsD1GKJy46VtgaiQN8k3So6H9QM?=
 =?us-ascii?Q?fOQE2J4xaQaoLgV7CGRnannRZSDcVUzlTgBBvSkjwfJO3aj+AP48omywkcdd?=
 =?us-ascii?Q?wWivHcNR2rFuLbEUveTlZn4vhugvtnOm8SZvsaC8kZoUDzAtHXGJueaH/Kvq?=
 =?us-ascii?Q?XZAd5tIpX1UOjvRfow/qgdXncPlFtVl3Oh/3WF7u2K557VpruMXF0iuGGtiL?=
 =?us-ascii?Q?By5HTwp2laNciRwbnyTKfEHYzy2e80wepwELhdxze+TXyhoZg58pD8X1n6G3?=
 =?us-ascii?Q?gahXn/ldIzYfV+n5UnigdJht/1T+vSMDmdmIViw9b0EQ5wKCUFwSIkzPqoEs?=
 =?us-ascii?Q?m+CSYp1MiCA+gq3YhEM5uIclxWqAJiGavzyOJG5L+z1nTHwKBWO+eKkv4Zu8?=
 =?us-ascii?Q?ZoPP8X9q2hew2uyeKVi4X2JMwGt1fxbGL1QquckB76lyQzTcFWMg7Fp5yGxn?=
 =?us-ascii?Q?5vptGkhbAKykSYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 03:50:52.4555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9754b84-a6eb-44a8-51fc-08dd3905a2d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

[Why]
Under SRIOV VF, driver send a VF unsupportted smu message causing
a failure.

[How]
Update smu_v13_0_0 message mapping table based on PMFW.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 0551a3311217..985355bf78b2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -126,7 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,      1),
 	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
-	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
+	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             0),
 	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
 	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
 	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
@@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
 	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
 	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
-	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
+	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            0),
 	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
 	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
@@ -149,7 +149,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
 	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
 	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
-	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
+	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         0),
 	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
 	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,      0),
 	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,       0),
-- 
2.25.1

