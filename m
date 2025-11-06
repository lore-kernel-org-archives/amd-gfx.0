Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02601CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDB210E963;
	Thu,  6 Nov 2025 16:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJFkHWBD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C6C10E964
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjgls4W5I/o/FEDn3bG5+mJi7DbFKqr74gwcCpO6XpytOG2zke59tBuEEbh9vrUgAnZRHCdyjY/8WHcufL1EvspUBa7BGyFjEOXfQueW0h/oHTq6KrXHmeGMj0KWSgVys1cM0Q5LL+xYxjB4im4dxtbz/GScQ+qRuWc9h4V+G3Auq0K9VfdULtCNdmAVK5sdEnuzVMId2DW2M6cxq3UapQvGA/mK9WMkM7Uzp2Ki6PzZY4YG4YHhd79tuFUkRh0u6KMLtBbl1QtEwO7KYbtVzsEB+zDtr6keMJGFefhLs5jwsW66RgO1v7LqDAubSo/VRPrrYNmyZbl7Y8NclpM5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S78aNDxG6pelTk07xUCKY135bVDGJk27KQBR/RU53bk=;
 b=VcqYqMBxHJVPe/5EfICtostYxJdyn2F1Nhf/zYLnj9+r2bNAPH/ArdUwCd/sY5hn0lrE8dq4sTLQki+eJuhEuoA2ulA/c9G/+BN8D+glcOF6917OTwSao2bMwSYaFKMwSXUWj4iJxqKl683IiaZOOgYrLkZOu+s8l8Sm7cbmxQyDbZo4yhl2dv+WZM2BlbvqlIOEfhTObuQUxmX6mBNABDJJTjMFu6/Ck+u0oIQTNv/YKFLtR3cI41b9Vp68N5PvErlPQ3y023ShZdLtdX0vnr/G3YK4G/74fPhy9bNF0m/GuDigMI9SloICcjQOzBw1C5AQbWIu51mX2andCdRJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S78aNDxG6pelTk07xUCKY135bVDGJk27KQBR/RU53bk=;
 b=bJFkHWBDL/HGxF/BV2GI0jn3EJt906ayX1Nz/BSrc89iWBjkzq3Z13NUDkV5PWuB1dXFjCrxBdxQ+RKN1/9AZ0o0k3nl9sqI+jKyfVmkA5kx3pyPjg+FoY7NGqEgSvR5gGU4EK7Y3/o1WBTRLnX0k1ab1BVcj/Z8qGlOJLb7CXQ=
Received: from SJ0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:a03:3a0::22)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 16:55:32 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::e0) by SJ0PR03CA0257.outlook.office365.com
 (2603:10b6:a03:3a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 16:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:55:32 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 08:55:28 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v4 4/4] drm/amd/pm: Enable ppt1 caps for smu_v13_0_12
Date: Fri, 7 Nov 2025 00:55:08 +0800
Message-ID: <20251106165508.3785924-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106165508.3785924-1-asad.kamal@amd.com>
References: <20251106165508.3785924-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: febd8519-b83d-4fb6-18fb-08de1d554c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nj0Rqypv83XT4rCEjPqW5WtkzDDK7y35U4nLRNZ5xQZXr2zgqJcSgZ93ne+y?=
 =?us-ascii?Q?cwuhhcIpfCZal/Qq8CDhi2l8uPm1s1jl2Ov4W3h1lSSULn/eeGkCV42hJav6?=
 =?us-ascii?Q?OFkfS3NpPgcUGwcmoibHu/c5sQXz3isdcYbxWFyZ6PkNojFzSMpKfRjhhYap?=
 =?us-ascii?Q?FSNJqLnY0TL+8W6RayZ11os7tMEWW1eZvp2jD3NT3xOL4k54qSSJAzerIPSP?=
 =?us-ascii?Q?5eSGIMh0zotSM0cU+b3uCQUQdrfNfzI41Y6cgosqQ60g8TaFprvyT7Oaxhnp?=
 =?us-ascii?Q?aUNDhut4sLRKY8zi1VzBW9HRxsRmrcajoA9TJPZjpuDFT2k2sGBIsDS3mQQm?=
 =?us-ascii?Q?2/JN2C+ZPzZ8a9NP8bNRxYkdkyXg+Y2v/u9lBygw8vDnAb4KiBvfzwixs7cK?=
 =?us-ascii?Q?qnsnw/M8jmuSe582H2l/LdVWIlLFWOpOJoDvTb3m/XkLcfJmVOnvotArkvlJ?=
 =?us-ascii?Q?iOxJ66coae225ewW5GhzyCp63kmOaFXIkN+3qfJiGu//HJD20FFMqmnnLat+?=
 =?us-ascii?Q?km5ebid9lZgmeM2PNFZ/zuHycz9AHRd5HK0t5FOxwouuLbin+1fkDSkbdX/V?=
 =?us-ascii?Q?EHNllBBh5eASLd27yj5cKDq2dDEHf0Ik+spRPEzpbzBJVJPKtUeew1lfGjaE?=
 =?us-ascii?Q?A6QQomXlLF+yN94mJmN3UC9sFO85WtFyJjwuPodePgr5eJIAXO/5sk6VDpCJ?=
 =?us-ascii?Q?wtRiJyzQhGBIgVsdKuCz2ht7AspRJjjVxFeNHaZ1eqM2ZS/hKHcLqFLRDY9Q?=
 =?us-ascii?Q?EMdeRvwcMBjA9SF4mpTCzTuc+3GzRwY9UPq9J/vr+TUjvbAljZzHabhBF7dQ?=
 =?us-ascii?Q?w2dU7oiTiR4HdwWsHusg0hbSyUObea9D+OD4OdbtMUpyKP94aErmKXnS6Fs8?=
 =?us-ascii?Q?6+iiejN8XfO+QL1MaZ1X4stmTKDcJulhrzdR/m18dugUThJ7NrEFMWAhNAO+?=
 =?us-ascii?Q?7ordjlqS/SGO4SaPZX+P4+8L+BsNqcDst4FIdZADxoY7fFGF6/fU4p8oSal9?=
 =?us-ascii?Q?V02BuXmsH3XPRVmVHYTuReMQA5abpk1c2V8yRojO08z/IA05EtqNjb4SRIlE?=
 =?us-ascii?Q?jai44Mh1LECYD0Zqe5Wwhl9PPHwijk9Z23Ff0bvvHUfGiSd/VKLuRUwbaikD?=
 =?us-ascii?Q?/2FedgLmoJZcKkGJuG8/mlnWNWvXVeCil3lIeqbw2yDOWMWywgd2veRVKuqw?=
 =?us-ascii?Q?wZkJxXGOqHfiFpibWWawqAqgcPF/90Cmmf/S5p6VjOpVyPcoMmPVVo5a6eHF?=
 =?us-ascii?Q?x6/KZyyi5u5nByipSJxJDMwKOyLB3lsijvGiWq3gq3zG9ANwRWc/uNOLU+kW?=
 =?us-ascii?Q?e6MH2zuXnV02/NTW2IQ7K7CXvEjDvpvTFNo17NT+qv3g5I7SsNOTzdFnvIxk?=
 =?us-ascii?Q?icKAwuW306ROryiuieyfRnYAY5ffmx9Moqfi57YdZhq/zeY5ZqpU2NhvKnGA?=
 =?us-ascii?Q?gQ7STcfRkskmB75677AEpihkQ/O3gZh9O8oCHt8jaqhgCdYwckd6rTvJ/DRa?=
 =?us-ascii?Q?SNqxmjpPxROF+ZLmQNkYvNt+gvfccY+RkK09KytKMM+siUFWxjQrmWu7tSrg?=
 =?us-ascii?Q?7lBBkvDJatMUdIAwOLE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:55:32.5143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febd8519-b83d-4fb6-18fb-08de1d554c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

Enable ppt1 caps to fetch and configure ppt1 for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f9e04df7e472..44e1cd821eec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,6 +356,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver > 0x04560900)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 
+	if (fw_ver >= 0x04560D00)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
+
 	if (fw_ver >= 0x04560700) {
 		if (fw_ver >= 0x04560900) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-- 
2.46.0

