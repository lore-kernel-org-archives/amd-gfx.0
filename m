Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20960D6E2A4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 03:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE85510E131;
	Wed, 20 Nov 2024 03:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kAQlkOl3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA2D10E109
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 03:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYMX7lnp/KBC31Q5hXHR4AO9FMmHzYYgoy8jyOa+Ok+YdcebtXgSVSD394B0cyymVSliTKvGMSVxwBNef6Rw7n2pQ3EFFXdkIrEdmZKkrY8sXAoyAJUJ9RDbVeqHuZ471zgRxGVeBtgCrlIMigcvJAayuCJaPZ4RtykrWNJgBxeHHZcuiVuM8LFpicE1YMTUX0PuCHTazxT/aWsWsOgcaX1Su5nyy7Qf4XrT7/0yez3Ofu6/U34a4LZC1Wr5bdK8VIAMtiJGB8G8bjBRdtT35iV+TQgYIyN9/lmnw16iW0jKXgqt26iHmwfXkUvy8S5mkB64AP+MPJIZ5uY9ZM0E1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hnqp3julajVaLn3wxrgX1z+IPP/vgcKnYYq1kkO2E0=;
 b=b5KvDGY3xrLaD+PvXzvL5r3ewFPX9E3Hyt+bgiDCPtfd7vZkOhgCPMb1foBpjzSl8alpC/UlWEzd1IfSx7Hqn5tCFy6YmBlP0coEWJJVxvTUy/jEkZxKc9zoxGsCeFMwMCMGzrmiuCwf0Drf5gnwR6rkoxINwwEqf3a/PxygzItiaIAvVj75hukAxOGDtdynA+zAz6GPwU9MOm17yZbioB3rnVM0VVzFllQGnSs0nWyoDAMrM5tVVD66MZV2e9F5LX1BaMyTnPXjWLRGhBAiN417IVT2sexh4x7R0fOKj9zGy9xTJ/I+6xJqPDo2RT4le7Jzh8YcCyqY1FCAybWEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hnqp3julajVaLn3wxrgX1z+IPP/vgcKnYYq1kkO2E0=;
 b=kAQlkOl3GWLnj2tdh4SFuLtcYx4vVEG/X9LNJAoIegHIsHhVhCm4SUjQq1TqAkOT3eK7rMteonCIoKStkQLXB4bGH1K8H4Ewf+nvym97xYQzTRlG7uv8yiLoWDbcixZ72xRxWJJnIh5Ao+Z6K7bjUfcM+/qgOsfoxwsL9zLoPMc=
Received: from CH5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::10)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 03:19:08 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::68) by CH5P221CA0013.outlook.office365.com
 (2603:10b6:610:1f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 03:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 03:19:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 21:15:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: Remove arcturus min power limit
Date: Wed, 20 Nov 2024 08:45:37 +0530
Message-ID: <20241120031537.3398907-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a1fa9e-559e-4d8f-bdfa-08dd09121855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0bIL8Mw8/K/XzvM/A7n5z8RddatVJDVarG4DQHOuwK76A6T8zj/+OdKWHMtm?=
 =?us-ascii?Q?XzPckbbEsq5679n5wq9IifODgbXEN2HTCf5n57N9XYwkQIG4aOpLKzgDK2yS?=
 =?us-ascii?Q?Ms5GsVPTPYzp9vLqeR7vvT4eK1Eegwe8kElzYhklhN9vP/Jx0TkcFBnu83M1?=
 =?us-ascii?Q?AvHaCvrjVUWr1B5wCoLPck/FxZ7nj5De0utLD13CZg/oTcr42ZwXv5u4n6I7?=
 =?us-ascii?Q?FA1wamfCVi8gYX09nWIKHgmM87xI6LQTmmGnkDadTtiG5XZhzawnxWJQsEtg?=
 =?us-ascii?Q?4BE8IxSDVkPgYetmbGXOoczAEZ4zXy5OHacDG1+1VXZlkBxQUJAvjuPzSVZz?=
 =?us-ascii?Q?XksoG8rf8slEQsH5kBsp/Wc2CMLqxuPhzZ9BkyxUIp441V69sQbkkRXIBHFu?=
 =?us-ascii?Q?Afs7XL8gZgQXZWtLwbFE8DmeyQ35KXZamcg5L4zG2ACn91P0dw5emqdD7lol?=
 =?us-ascii?Q?Cph0eheWMwYEdPQFTxt446SoAz8RKzA2pMsk8EV+ForMuhAR9VfUj+xmHJK2?=
 =?us-ascii?Q?jXkS168aUW/9SNx4UxxwmXdzAwvJdDk3MpoOQaByHDTXyTSQerCG89v3Rrf/?=
 =?us-ascii?Q?ROJx7ahIZz6YqV6oRISpGk8GSG5sGBoqcIcUayRZaVOOWLu5eF1kV1igGc77?=
 =?us-ascii?Q?LHNp7qKjqvgAVBjvl9W6W3D9+l/BfPnsqI4XSJhlzpV/3t0QLv+9AgtWoEAV?=
 =?us-ascii?Q?x3wWTlH9TAZQIwNYMsk0ncCag8m91n7qXQdHBNK9hLvgMX2O902ODhsVKcUI?=
 =?us-ascii?Q?aUZWmNgNWEnV5HH744ySOgri6N0hRHGOuSsgQffGj2kLvE1ps/zB3aoTjYFo?=
 =?us-ascii?Q?am4RQJXbOw/ql23vYqu6w4bEdQQ6THpdI7+AnWWjbxVdCK8dGy+4aWojRX1m?=
 =?us-ascii?Q?RpcbQ4hABdCL6q8J/tiR4uZHxjRuBwTbaPzJO9DlF/Rx+Vk02IzRhnz/0leR?=
 =?us-ascii?Q?XNJ9mLM4pV7zyys9GTtlnIpI4QmrsAhmmmoIACPYiypE+SEHuee1Bhbi0K4R?=
 =?us-ascii?Q?WvnwN8WBMwIK7ImRJddWJDK3EB91T8oX8F1A23LWUkx5obJVmyVNUDQ9UssV?=
 =?us-ascii?Q?2qENpuozo8YpN6pt/wFXcPXe/nkHGZnihXxfcZgfa8elKnfre17G2F7cTZ5u?=
 =?us-ascii?Q?r+81HhIjDOHPt+6uD2oNF5k/vOp5NzZAYu0EWT32tbq0xzYfrb2nny/Bo3ua?=
 =?us-ascii?Q?XthOyyYSSV59x+cRLz3vecukgzEsyXxU41LghCW1CtlXOcuSif541hIjlEty?=
 =?us-ascii?Q?aO/di27Z2dj4+nyNBqp9657evyPuoxi/DtFgb/akqlSRA5iFuzo9tL1vatE3?=
 =?us-ascii?Q?qeiFCFjO1T7pHy2ZzAhMLQWbjZyzonECtt5Ou4nMcK1pC8OtapacgZpgr94C?=
 =?us-ascii?Q?PEaDhKK/qFnC/ST+B6HrjJ1r+YBpEQUnEGHSCV5pC+bloZXK1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 03:19:07.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a1fa9e-559e-4d8f-bdfa-08dd09121855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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

As per power team, there is no need to impose a lower bound on arcturus
power limit. Any unreasonable limit set will result in frequent
throttling.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4b36c230e43a..12125303bb79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1344,8 +1344,12 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 		*default_power_limit = power_limit;
 	if (max_power_limit)
 		*max_power_limit = power_limit;
+	/**
+	 * No lower bound is imposed on the limit. Any unreasonable limit set
+	 * will result in frequent throttling.
+	 */
 	if (min_power_limit)
-		*min_power_limit = power_limit;
+		*min_power_limit = 0;
 
 	return 0;
 }
-- 
2.25.1

