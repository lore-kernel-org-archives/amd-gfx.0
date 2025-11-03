Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057EECCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 09:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF9110E1A5;
	Mon,  3 Nov 2025 09:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwRYDLAx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E177C10E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 09:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqwaAxBSIMwRhJZYRAjYdiC0nzIz4MOrkgiudEgQj4aALTlFSWModgsO8PqyWxEfl4l2lvrjyRgAKIj2LqOqMyO6aAhzJfi6r3qsxIQ9nPr4D55mp3tGRLxWgDrknPqaPiaHVvuUp74IMbb0j0Hj1QHvUkI/6rUJLuHOu9p2LDNVf7dHwCQf3pJAKcqO7Mn2o6OxjfdvdAy9ln5ef9u1l9HhbH3G/g0iKRM6w3rMEA6+aO5dy2mlA3eHFKdrCnjSTZZOYQ9xyFO/VKxSeJjByoNDZWRBVgHoW0oETDcHlO5jM78g2ibHJtOEz8boCJGZ+9nSHh9RctOks9uhApgdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whu770s5FMMr1/0goZCcoIl9bJTk90OQCLN8uXDQSd0=;
 b=LBWsPusBdl3jYNjVcoyxIgR6JagYNkg5Z6/FyloFDYDiEDp81JyRFeb7/W742iwwWrLnTn/a25sBgtWm0ERtWkmBihDc8182yN/unFA/A97dLTcq39DpCKJCq8OBJzBtLwu4efqcy5uWTXMvat6IA2t5vnVuhnMi+yL4LS9WoPg3rlwVp3/+j0N+ryUdMK//39yMJ9A34DG0cuZaq3iuWx5cWOOCt0aWsTgBAMHfQ2fR544/AFk3B7gu+6V1XlqebMIBnRBvX+KPy4EVap7wKZhIuj7LSoy6rtJTQFx0RLLpDYvthv/HeU7mns363aYrbtotS2qI5srs8/f+QimOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whu770s5FMMr1/0goZCcoIl9bJTk90OQCLN8uXDQSd0=;
 b=MwRYDLAxSZmvR/SpgRr2Pbpf6bH5yhRK5aMeqqRXy2lBXEs7GvQsgycowAsBtZGcc0uIZWqn6bDtMKu481N5AMucVGV0YRja7ysp4imLVq+dVX+rX7mOGyTTMaLHTDFCyLwvF83KgX9p1+uujsmKlK0FDF/XCt3AqOYoOpN7GcI=
Received: from SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 09:05:56 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::4a) by SN7PR04CA0077.outlook.office365.com
 (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 09:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 09:05:55 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 01:05:52 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Date: Mon, 3 Nov 2025 17:04:57 +0800
Message-ID: <20251103090457.3036885-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
References: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 64436d87-ddbe-4880-0d0f-08de1ab83250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vpb0UcnDYIi6wEZ9m7irA14TZRRkMqM4ICJfyrqi7noy2+VJgX8tG7Rp0ozE?=
 =?us-ascii?Q?zjztrqxwyVHak524weggpfRYLNYdmJnjxm8sP/bIPQ9JzY55xb1E5v1xqUrw?=
 =?us-ascii?Q?NKcGOBGyqlTiTa4Or8XTYFbUElgStA5H2duAaxUFso3vXJLzk+wPeTw9YUvp?=
 =?us-ascii?Q?AV9xDcZwHRlxcqk1XvVD5h62mwdSjXNWZK/aUEyuEshO1YZBk0V3zOW9iqB4?=
 =?us-ascii?Q?WqMB8gZzAmVQ1FmDp4i1ajUJ9DJWPnsXoPSokhPPpRZWsYybB6q/MIgv2MAy?=
 =?us-ascii?Q?QpUgSQ9OGAALRrCXsoAIsvBYIr6jfPh1ZdFBwHK4j+JjmB0eUPZFkacRG1kD?=
 =?us-ascii?Q?1499M3ue5mriE/tIYAD0bO3aEpuH82KQ/fosU1Qsr0j297su75rBo1ggOmKZ?=
 =?us-ascii?Q?W4g4MytQ+biY0QiYwFBge6Ji1w53wpXZOxKR/y8lt3x7SsZlBd1/4LZZjBP7?=
 =?us-ascii?Q?w4Fpm1ub631bUEXIoO5qvKp6aaWacZyw9ve3+csO59OosOJ0/1cLVKFTSSBd?=
 =?us-ascii?Q?7AlxWYGXN8Pktadm9LavUt+pguUIMSYDUR9gOSCM9EfN+85HZJMrEjqamevy?=
 =?us-ascii?Q?jwJsH3xiqkAVVu52L8UmJ+pd41PdQNNM0hHDgv2i/4vf4GoPRfn5t3Wralwk?=
 =?us-ascii?Q?7mpNPYZk9iEpB3eilAFOZpfYiXasS3AyvivFO7tm1fsryyN1I1XiAelULb9u?=
 =?us-ascii?Q?BSvLTQIqUmDOHStF3PST3+NeSU5ILMNmbr/2wU1k4uRx6lUJyhs9QQS+Y1lq?=
 =?us-ascii?Q?6sKtvF9I+NQ9zR4JWxivJxqEULSwszci0F2aFA49EQaaXiJ9/s/hM0bRCSRl?=
 =?us-ascii?Q?d8WMRyivzj8B0kTZXNsjunMyNGgTKtkOc78wwjB3pmAxTLw93lovtykvVwaw?=
 =?us-ascii?Q?gbOgO9NoiLmE71h7ZNEqAoMG5kyXDAyq3sGMIbgxA1KNYAPcdud0Wu4iGoVn?=
 =?us-ascii?Q?pwaqbk2QnzCjIQF9H4Z44M7nqOCqG8RqBFdq7hr0pPojosbnNRzappLmw8i+?=
 =?us-ascii?Q?mbkkcivuOPEMmIRyme4nkU1EYZHkcMsTw9WLh7oiS74ZW5Wvlke04Y39u7JZ?=
 =?us-ascii?Q?7pBk5bVfaOndbd/A/lD8Q0ny/zjGSE5myu7sgdwidTVBqg+F3M/RvZ+N/6S/?=
 =?us-ascii?Q?qbEFpg/4nEbbBVfD6Jv5CIVpgrRoi8ouiSk946ekRjYoXpzSEtwzRVunq0Io?=
 =?us-ascii?Q?HGa3tTurODmKHDs4NsvRLzhkBHJ9StMw0/ug1V0ANjClGTykEVj06X3LDND8?=
 =?us-ascii?Q?Lh6JM/Y0V1uGfuCBvdIlJwGCChGajNn7ULQuUw2ceLl3g/LZpWjC10CpPUoc?=
 =?us-ascii?Q?qNoh7dv6Zj8dCrftKj+QmiezKwJsIvrU9yTYONO67k8oczlP3WbdqFnpKoAU?=
 =?us-ascii?Q?bbzcd5NbDZ6lQvY0dcEFgvNhAQ+7YZRomXephbjXCm8SY2w0Dzd7b9KqzM7b?=
 =?us-ascii?Q?ey37z4obRv+62HwZhoGbJ7xsaVkqJtPxJpcBD2JSVQGCyK/lto/GGNbNdSqA?=
 =?us-ascii?Q?6pJd+dzUM+7r/XzkDApQx4kx2t/eBGg7TeVnHexZ1Cf+cAdqDgrwJ30Vlt1K?=
 =?us-ascii?Q?gYZr4RtWXP3zLIZAPww=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:05:55.2940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64436d87-ddbe-4880-0d0f-08de1ab83250
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

Add ras support for umc v12_5_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index b06aab25d4cc..40b458a922d5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -259,7 +259,8 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	init_config.nbio_ip_version = amdgpu_ip_version(adev, NBIO_HWIP, 0);
 	init_config.psp_ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
 
-	if (init_config.umc_ip_version == IP_VERSION(12, 0, 0))
+	if (init_config.umc_ip_version == IP_VERSION(12, 0, 0) ||
+	    init_config.umc_ip_version == IP_VERSION(12, 5, 0))
 		init_config.aca_ip_version = IP_VERSION(1, 0, 0);
 
 	init_config.sys_fn = &amdgpu_ras_sys_fn;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4067359bb299..4dae64c424a2 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -71,6 +71,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 {
 	switch (ip_version) {
 	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 5, 0):
 		return &ras_umc_func_v12_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
-- 
2.34.1

