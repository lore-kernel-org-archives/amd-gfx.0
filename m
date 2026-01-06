Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5007C47BE2
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8C610E4CC;
	Tue,  6 Jan 2026 10:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lPSmQay7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBA810E4CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vvelo1Jallo2qkdDRqRzIfZH5EpGHpLJxXq3KQZBxu7EkcXoA6+XL7tPMV1cQ9dfzZZOn6ZNV/OlhP2pY2Qqt/ki084n8nzCsRqWTox4C/eJVbtyXB/MwkBs8PY80ffTClXdAX8n4+cmpyAAGPhjsNpJH4PAG6EkLAqMJaGBwhf5k9BqLCKXVIIsYdbqq8DRW0gZdAiQf6MV0BfFXZFtjz2HiW1GFVTKx13zWUlNUhHDEOTONwO7BwaknwoEl/hv06JiPv4sfRLhnfh3SKRSXhvb8FoaDLFl6PuJ8EDv1rG/S1TNfOkc7y9mniu5dq1mAp7vHE4Mr4i4rt9FWt+8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P7/Yy1jo8tlsKY8eWbUzDxT87X4zujzs7HkvtP01xM=;
 b=nMrNElyTt8ReitcMax9nSzLd3l4AtJQPzlwB0dtNzY49vzGLA3kNWvhP/rCvitXckmCxKJfNd8/W7OspvtwGeUVM9Ep4rvuVXuzx+nMOQx6y7kpc0jRM9RBdjNJolgcU6InaCNu8lpCtv5L6C2xg55M8WeULSeVpApm0evOgzqrNFi1RmRJ9GGGL1EEAvQS/DVj7IIo+0mHxoJ08MK54+PaoQYoKjyZptjlGL1p8+dHhYh7CQv/yoXE1k3IhXVZzdjm2UHb+wIQgQdoVzoXp9aRoAV0s2SLj169IkC0gBttN3TaG7uKW4cZlGhflAnxIqScihkw6zIGggqRZNBExbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P7/Yy1jo8tlsKY8eWbUzDxT87X4zujzs7HkvtP01xM=;
 b=lPSmQay7yfsXgDHMeT3IjzOPaPcN2asc71xVC53XB2lJ7HKFvyH34xFLYbMtBD0i31eII23qKw8QFizXmVF6bjFKYfIX8yb6PegUWCMdtR5ohSO10HG9gEVKD3EnZqDz5Uq6K12qyB77H7o5KWVXHjeR4uCUuObmWck0hLJAiJ0=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:05 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::35) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 10:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:05 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:03 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 14/21] drm/amd/pm: Drop legacy message related fields
Date: Tue, 6 Jan 2026 15:42:34 +0530
Message-ID: <20260106101317.3856153-15-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dd1510-d41e-43d8-5862-08de4d0c5299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5r95FaGT9MS3hINxbeiMfQvYz99N+7n9sFm8WPnUyWNggLmFeg6HFJmOeDIs?=
 =?us-ascii?Q?ocIJ476qBUfn76xyNxYLt5lwS0GRlFTQjYzixHwFTbprqqJAZhYtqEXb1Al/?=
 =?us-ascii?Q?nf9HEulh285fWc6/6Np4ea77JQ2B75vaWqS8oxTdylhOE9j7s7fuh2wiTsnB?=
 =?us-ascii?Q?cOKQmyu/SaoOnsrqxNSExUoTnqhrqd1NjOyZMu0hX55eXjFcpPunalLQbGrr?=
 =?us-ascii?Q?PLTN5BPl5AHIF8/gSJzY7YaNwl13vAn2hOcuYvWOIpy2wJpWBROIUTezoUT5?=
 =?us-ascii?Q?eCPrSzdGDXTSc6k+dRWedK2TdnojqziLpnP+ay5aPbS+Izwt4kgqONxVo5sJ?=
 =?us-ascii?Q?BS36jq4TvUFXz6RPDIYosxlmKfgsX3NIq2mDBw1LNimmERh8ovg0iK8LsEtY?=
 =?us-ascii?Q?w8hJa3J1Yt2wsBgBsickVzZv2gLx+9kvBqeRbXSnY25TwCqnsUW7qaX0afcc?=
 =?us-ascii?Q?5O2umKJhsf8/41dSVqpr/w2a+3hpLTM2DnRsswM+sYJFWKLlHTlT3G5ooAX0?=
 =?us-ascii?Q?sED2B2Ym1w5Hh2qXdBKFpbFAXMxgRjnOobpI/9wNfMgunBfEMmK4DssisJXp?=
 =?us-ascii?Q?B1TGZSv1ULNz0fGiVN3EONmbyelY8KUgSa6+tE83AtQI1i37X8xEvzYF7i8F?=
 =?us-ascii?Q?wTZty3ru/GIaMZw0qtotCxQzkOb6C7Bi4bbI5ph/5COQhBQw+N0aR1/2pyqz?=
 =?us-ascii?Q?IdG5H9uPQyl7rttr03I0Zr8vJW2tIQTS2N27PYJ1tjTvJ/YMUTOheEgGeIDn?=
 =?us-ascii?Q?KS44scB1cGn6c0PZANOVPfc9hKTBLZSACXcEdi9tekKJXOG764y5cIqKEekZ?=
 =?us-ascii?Q?g10NwRKZWzqp47H8v46MJdgNQ8rJ/Fipr/7EDIKA0oRj8HTNMWGRwKaimm+h?=
 =?us-ascii?Q?CVqIFoyo+8gnvLuArPm2YoaA1ONj6zyK8n6Rwz0beXmtx2Ali0lcr0qeoADT?=
 =?us-ascii?Q?U010xn7/mnIH3ieZDDFYSY/iS6TTPNQyJk8DHcYYRzwxa7djXp6Wug77eMJS?=
 =?us-ascii?Q?aCJk8PyuCRDwmN8pB/cjdTzCMDuuUGNnvTWUsY0b2CW1rBy9ipd+aae1b64P?=
 =?us-ascii?Q?sDy5LPmxs+VobkiQgFOqC2np6Q6PiVk+kmNZKqpo0S3avhgymNOgPZ+jnM5U?=
 =?us-ascii?Q?pgqI9cK7F/IWuJa+e9EfZjfKblp9E7kvwgSTpKZnl6YSg8U8w/dkwunZIWfV?=
 =?us-ascii?Q?RqnShFsSSNcBGUXjzrOtDnOg8Si8HqcmEWnVwHvFqu4VMVwCyssD3L2kL/EE?=
 =?us-ascii?Q?FYIr3gG6OQ6PV2IwnStPeaLjdumzoZ56XFB6jm1gdjY8Xt/TOpPaGp1TwwSH?=
 =?us-ascii?Q?VgZPuliCBIm06mMTIzr8YcO4RjMGZZ63Wr2gXv1Zo+wea9haG0DlmNBJDePQ?=
 =?us-ascii?Q?+ta0p4AeYcJxWEhAj4lqrNRNmqddvk3QsZTNd000dIm1MyxSFWSVrCgwNO72?=
 =?us-ascii?Q?zveirv1pTWirELtwhVR52ark6WsLqg4V0xgnCGljaZlcmLQxJp1kEnybQ3Hg?=
 =?us-ascii?Q?oSM6QBtHwV2nXnyQiCYC8uE+1O9GdwG+Bc3aLHlMWmANX+OgY2+SL0bmLGzu?=
 =?us-ascii?Q?5OUwm+vXkJenVSt2zK8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:05.3311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dd1510-d41e-43d8-5862-08de4d0c5299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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

Remove legacy message related fields from smu context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 2 --
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 39f90317b5d7..7817dccfc7b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -822,8 +822,6 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->user_dpm_profile.fan_mode = -1;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_UNKNOWN;
 
-	mutex_init(&smu->message_lock);
-
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e98a1e765f1c..a403e3a45e59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -655,13 +655,11 @@ struct smu_context {
 	struct amdgpu_irq_src		irq_source;
 
 	const struct pptable_funcs	*ppt_funcs;
-	const struct cmn2asic_msg_mapping	*message_map;
 	const struct cmn2asic_mapping	*clock_map;
 	const struct cmn2asic_mapping	*feature_map;
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			message_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
@@ -745,10 +743,6 @@ struct smu_context {
 
 	struct firmware pptable_firmware;
 
-	u32 param_reg;
-	u32 msg_reg;
-	u32 resp_reg;
-
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
-- 
2.49.0

