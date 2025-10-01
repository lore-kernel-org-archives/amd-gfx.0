Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB40CCA471
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 18:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD71C10E73D;
	Wed,  1 Oct 2025 18:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCqrqPUr";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E1610E321
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 18:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXz2gb9WcHhnbbUO8oOPkVzZULLKElDn6bQcGjE3ha09GBWD+LWziSTOJqztTOKwOBhqV0VMe5EaRndCEHwNp1wPq+1yge9HNde447tZI2DdgU9AvBHRfd1i9TzXKw8nnemkU+S0Z6jHtOXu/vCxkG4M7aQROB5n4/0eCqLMtiNlWfB9qKh56/w1DOzDc/wxqK73L/pygqjgwqyJOnva936vOeZrIuWM8bzaNO4K//Z+L4gnyq2hocT/uZOYCXYGC0uuWF3zVQwY/T1MVsC+YWms6BLFN2g41NyqMSBOh6z1wYsJbB3/dkPmV9Kfzva4lh90X654JMEg2GpzI+awqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTeeyBE6TmKK260kKbBMBVdIkCbWuN20RoANUkAMyKA=;
 b=f5qI/3Vb7pF64lQodOD5dE84ObJZF54kCfVKc+Pg7iJJ3jVmF/556K2OJ8YLIngusY1h0ozCP/cCBqw2KOkhu94LkDRchwSBvGuxQKAH7Kyrnf65Y0P3/tUf05/4q4Zh5uFeaMl0bpjRqSEVO/dTWnQjulr5uA2HxiYwVE4EJhHhs/78h2BT4zJWJW5wBgKEaW4zFBCpljJwBCJ7IeJsMwxz5FtT4VKfI1DrGPdwi78QmeYiiR4g2sh4rZOzqCNqodxwfJORQowbgPmNvdjckp0PFofGCYNcd9qztEQU+vmL16RVQ6qbOsebTO39pLYdfT5HVwZWH6tuA59zbW8urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTeeyBE6TmKK260kKbBMBVdIkCbWuN20RoANUkAMyKA=;
 b=OCqrqPUrs+v6QWElzRreCGBBw1fcQPOdA1ccDkz31A3CJhH02pmvCj/IpovfQ9M/bmKc/FW+y1RTQIKetjnj67GgNU0DiNVzPgnMXittOioVXYrpiQIWL2mnYPFroc5sClFkE7uORZ9PBBvTx18l5xID97vmhO4Zzi+SWKlVXe8=
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 18:03:53 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b4) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Wed,
 1 Oct 2025 18:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 18:03:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Oct 2025 11:03:52 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <Lijo.Lazar@amd.com>
Subject: [PATCH 0/3] Adjustment to power limit setting
Date: Wed, 1 Oct 2025 13:03:32 -0500
Message-ID: <20251001180335.625453-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b163d6-6e41-4bde-f135-08de0114e17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Osq4ApECe7yLfO7ZWxo4GwtaTx7FFXIfmJzPCNFLQCdAJB4Hx8mbgu3ivHQL?=
 =?us-ascii?Q?2ddnlViTzH6GgvISorkDkTXS38+VLdWGaXkljtLn40Q0nAi4P1bQO9+NcqpG?=
 =?us-ascii?Q?9RBmf+SIlPmXmEYMgo4Yqy4nnETQoo7IK5s+SBU27QLvpsaOqJsYQev+sJqp?=
 =?us-ascii?Q?zitTPtiz49FjDR2EwwUMMsyAyIjY8wmQf2FkMcF0f98/+WN4cFhrlg0l5sqZ?=
 =?us-ascii?Q?eUoq/GLdzCyYZInIkLZgQq2vbmhajwys358vbrWRgJpMiYRXY9OCriqTr4oC?=
 =?us-ascii?Q?X8yDwqYeVk85IwDY/WwNW04DSLjbUcQxbmtoVmC7ZbdmnH/u0LXkUAS/R+pt?=
 =?us-ascii?Q?7xscnaWt6MgjTiXJE2vrpT/WJpYpp/hfT8cfqveUoMh+r1YIZqSsCjAtZwyM?=
 =?us-ascii?Q?O5cfiwXMzLP3lTkA9jKhS2mlh8XiU8QsPNe2QnRR58uyo3pLQBTScN7XamEP?=
 =?us-ascii?Q?M6RBI4yFQuPqxbbXZ0/y2wNfQGsZxWi1qGgBQiXXeHh3MjpYloZSgnj8ejhG?=
 =?us-ascii?Q?+RSScOc46os3KuH/BrSOJl5+Rsh8IoyuLVoA/Pu2wYP1K9p6ZZNjpL275VE4?=
 =?us-ascii?Q?Z0BuoHFzyb/VDCA5b2hdugiFrtnCLFKHbJLTaETfWRMeLEOaWFR3ekFFj82p?=
 =?us-ascii?Q?sPLG84z7v8HRY7ME27C/4GmY7ZhPUVkN8DrAha1ob7WVH4GKu1Qjcy2nFy5A?=
 =?us-ascii?Q?DgImCc1FDuIsfmbbbyI0ZC3vkRS25qZNPbnqQQED3z3afZBWv1EZ4g8lLIt4?=
 =?us-ascii?Q?oFcUrf3RPNtIMQHdMAsTsX2zsPCnM4T1NG+kLYLF1qcfknHvYUcJ/XeCWU4E?=
 =?us-ascii?Q?YC2J7F6afWikaWGuJdkb9chafZ9iCmnlP856H3csRnvQ147BjekK5o98XOq0?=
 =?us-ascii?Q?d78NjuK0U2DL/4cSiNqdjW2ztG/2DzY8SGPpAsOrvqmR4cgA9nR9i38qrbky?=
 =?us-ascii?Q?mIzkPHfCKLNamoLSf+omYou4mhgS6m1LZWtNSojMocbbRf2LSEOzWmHPfNI7?=
 =?us-ascii?Q?02XDRRx7nXVwC6H7vExAuaWaQsObLm838FPzEZPgZrx87d7FhMqqo4s8nxm1?=
 =?us-ascii?Q?fr7Y26R5zA8p+/9iszmdRO6fVkwepU78eCjgfQTttDMCFBnR77zXf58QdUsJ?=
 =?us-ascii?Q?aNuBJLpeCOTSOYC9+2JNzNYBubrEnKWAgCj4qEBJjskKfUFoDA8jIRlBah/j?=
 =?us-ascii?Q?Znsi9mY0luSoblDURhYjM4npBkBH91M19so8CoRBye1jBPh/Lv2Rn12qlwTj?=
 =?us-ascii?Q?dMMbSCWLl8/AdOCdunH06jdSzTUj91Wy74RTHu3oVHXbheJnO6Kbt/R6Udop?=
 =?us-ascii?Q?Yd9iUnWSl7UwmrC0ZR+fW+PMTcKb/ytB+fTFThhEnJZ6NoWfu8mfeKOqpjQd?=
 =?us-ascii?Q?tE48WDadz3dCwx/ErJ8AK/eRkaWU+KE9O4LlqxuJSGzmxAD5VYSvaRZy9EfU?=
 =?us-ascii?Q?FSrAF+mUJT5MUfCB9viZJyUvDTNwIFmCkbG4dEiFp3lO8333u0uhdt0nafcD?=
 =?us-ascii?Q?eZXpE41i1PX+8+JYlEuwTCjaAU9Yd/iEcu4xW3J7bVvgD+ORfJEv4LB00Gnr?=
 =?us-ascii?Q?mE69u0r0F2AZN8EEZP4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 18:03:52.6321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b163d6-6e41-4bde-f135-08de0114e17c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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

Lijo pointed out to me that
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")

both should be unnecessary because smu_restore_dpm_user_profile() already
restores them.  However in looking at the code there is a case that isn't
properly restored - the FAST PPT limits supported by Van Gogh. The nuance
isn't immediately obvious because the limit variable is overloaded with
limit type.

This series attempts to address that issue by passing limit type around
and saving/restoring both types.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>

Mario Limonciello (3):
  drm/amd: Remove some unncessary header includes
  drm/amd: Stop overloading power limit with limit type
  drm/amd: Drop calls to restore power limit and clock from smu_resume()

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 46 +++++++++----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 7 files changed, 31 insertions(+), 33 deletions(-)

-- 
2.51.0

