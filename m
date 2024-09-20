Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E403C78828
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 11:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA45C10E805;
	Fri, 20 Sep 2024 11:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YfISXRA1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA95B10E805
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 11:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFG+4YpVH154246HAw9mlJ/GQwcU73sc8vbjCem7UF+Nc1tMkM1WFPhEAGypI9Y1dmqBPmLYnZUFQaJuj4z8yxbH46RqIokM808UPwiAJX5kH5CEmSRs6i7jk5cWKiYF8RWcICJEV0jnppR+pK5T1GoY/W7B7pCcjB8O4NUR6CMWnl5ypoFHkL9p9nmgqvs2D6HDsfJTcCAOPT2x0jFyg67oRwF1n34421h4wIldCi2WsCeyPVhUXkW2c2yxzSvHPU6kW9PS4Wk0YX5I2ygZCZ3O7kS4XW/UQVCiofEGJgqBRqLM1WTnhIXCkDoNbdl4I8Rg6L3KhRXWH0Qc1aHAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWXnmRyuJr8OGItM0DxYX/yCZDQ9QiT/aDdMOdymEK0=;
 b=OrgMn1krMPxc5FaZmLe1r6IdrY5gGezrL1R03k9GyVtduN4MlLKNSCLOxvP8Kb1R+M3vbMBtjQ5Ltus8IVPDJ5+M9lmEoZksg2tkSF5bUQBHnjON15y/sQMRbo6O3f4xpA4xhUZoB6ei33/mjb7zEenV2Azv5vZ0mIK0u28HZH71/7A7zpFj9FqgYRFAwdxlXCXUSybdTUjU3TOv5zBgFeTrvFSUD1GqxGbLNxUngM+PvD7uwvy3/40mWkCTj9qsrYVJCgzqFM30eu3PDDh0hwG4b1017GWatA/Ce6TYHX9NolgVLq4abxHQyN4t9HGgi2sOtZnEloBD3wF3tI7Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWXnmRyuJr8OGItM0DxYX/yCZDQ9QiT/aDdMOdymEK0=;
 b=YfISXRA1SkrIbgUCBM4G80V7947CNQEaoA0T7iMX4xZQuuGDFjEwEQota5mxDvzi6Ny5iouu1oNk9z68gdvhlRSBTDzBgpGKyxia8ieZK1Fqt+RpGM0wElKZgg41exLgMfjEb7bVmF/Utg/HiGjca4Mgtx/c0Vk3WdV0TouJIlU=
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 11:13:10 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::35) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Fri, 20 Sep 2024 11:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 11:13:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 06:13:08 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 20 Sep 2024 06:13:06 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update workload mask after the setting
Date: Fri, 20 Sep 2024 19:13:04 +0800
Message-ID: <20240920111304.436478-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 31814846-3c0a-4cd7-7d54-08dcd9653568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HOISfTq9w0eznwBzWrtCXXzoDsrScUJtcg9eqMFKecabhPtYtPb4ijZgXMSk?=
 =?us-ascii?Q?IfkQbKXjwyfTyjEa3lH92MMbHlU/oOIajM1rI4KfU93Sjc7X4nwvdEsFnJeI?=
 =?us-ascii?Q?EAMaj3rNas6A3EIllGGsK2T0aIpD7g8CsPRhRWxo+O1zB5DrAH39zx16lyN4?=
 =?us-ascii?Q?wnDbUg2gM9rI0RLnYkCs8CgSANiEVJdv7y/vFK3AL/cVPK2Z+CSCzSpHI6j2?=
 =?us-ascii?Q?Ve6TOIhSzbmCX/7tWiHDUMrM5g/1GrMECVSCV0J41nkZtcBfc0AXChOKiMW5?=
 =?us-ascii?Q?zcm3Lq+jgz5MKAeQk5rQhZK97jIxD46hM3hr9SEW8diNyBgD3UVGoADDXj6p?=
 =?us-ascii?Q?u4fbH3OB9VSmIv+s3CD6IiNjS5hrNSGwHx47JPCICDyoKGyOXxX5Ihi5l15V?=
 =?us-ascii?Q?Dp1KNeNMgXXPdyCPuYvhDE5RFAh9vOL1v5ls+JM0JhpPhH3ki3fBLSrzONQh?=
 =?us-ascii?Q?DRtd5MHeHkhvnRJGCFNWgDaxRsb/IeGB4k2OvS9D/amBLg5dyRHtDsFgbFiP?=
 =?us-ascii?Q?cWs+p2mcUwSEgEeQXP0vLH7rjfxuy7UlIY9R8psEgpsbx3A/XgN5X2lwgELE?=
 =?us-ascii?Q?lEZS6hXDoFw3z4Nq3Bk1TZaeAwaf/0H9Z9QuS+zkgUQtVvnAgFLtQv9flWfX?=
 =?us-ascii?Q?zbbWJwwjlJm7bAGeJcun/byQ0FE9Jz2emTd4VnnbtxKshS5l0IuIZ5QfHp9i?=
 =?us-ascii?Q?6WUvB5MVGA7GLArQLWl4QUbfISf/Mh59PLjllJbAxkbpfv0RZxo0dM3RIW0u?=
 =?us-ascii?Q?A2nGl5tPemBIgshZsx0qt/kxl+RMlCxT1+SKuPbxULVhpfRm16f//k+KQWqR?=
 =?us-ascii?Q?tAw2aGYmRKfLB5Gqxf6tqXgA5nmb9/rpCF/HpRr1sMYtCPC3IhELzxHzvlxK?=
 =?us-ascii?Q?PrzBxc+Z5cx1dlKZMFFT4j0iYSQn/DqUSTX8taHW+lpIkTugbefwgLajsFpf?=
 =?us-ascii?Q?k2LbKUvGl8gyzp0Jt5tSNyLLXQJZzx4WR8M4fLpg6xQb+wbDECQHkUQmDHWM?=
 =?us-ascii?Q?w5/itjAVk6yLjMPQABudRecefLXtoTnagRVvRDL/Q7YlzZ35ORI1fXHGkJRP?=
 =?us-ascii?Q?7gTRiI34qbX1doQCgxVD07ZnoKcyMshvb7tj5xmYU+xvu9dakYaqMpczzkcL?=
 =?us-ascii?Q?/qlDVy6+XDFqu8z0pTqlBMa2ObW97faGcN9lW+6D44Y7GFPvd1GmUJbKRRsz?=
 =?us-ascii?Q?PqLZXIDsHPPWUK1IjNvdOnKU+hqo0n8mEOU5L6W/y1yVENJNljz9W5xhFGTL?=
 =?us-ascii?Q?WLLGTI8CxR0mUVLK+2pEBNvTWri8I3ulNPckrztucnQdFT8Eu6Doto9AT0x5?=
 =?us-ascii?Q?jT2WhRLUpe2woZgd3xzZwYjlg4hjabpfH+6PPwHGLgGht0mgrhKJG29aGIQr?=
 =?us-ascii?Q?gf6pnXifMXVW0nBW8ekZt1Iy7DKX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 11:13:08.9169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31814846-3c0a-4cd7-7d54-08dcd9653568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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

update workload mask after the setting, to fix:
https://gitlab.freedesktop.org/drm/amd/-/issues/3625

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 +++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a887ab945dfa..1d024b122b0c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2569,10 +2569,14 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 		}
 	}
 
-	return smu_cmn_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
 					       workload_mask,
 					       NULL);
+	if (!ret)
+		smu->workload_mask = workload_mask;
+
+	return ret;
 }
 
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7bc95c404377..b891a5e0a396 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2501,8 +2501,11 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 		return -EINVAL;
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
 				    1 << workload_type, NULL);
+
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
+	else
+		smu->workload_mask = (1 << workload_type);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 43820d7d2c54..5899d01fa73d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1861,10 +1861,14 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	return smu_cmn_send_smc_msg_with_param(smu,
+	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
 					       1 << workload_type,
 					       NULL);
+	if (!ret)
+		smu->workload_mask = 1 << workload_type;
+
+	return ret;
 }
 
 static int smu_v14_0_2_baco_enter(struct smu_context *smu)
-- 
2.34.1

