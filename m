Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B234DE6916C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 15:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA6A10EBCE;
	Fri, 22 Nov 2024 15:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GiyZOH1x";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C8810EBCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 15:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWnLesY+Q5IrkBUGs4XwRBVLZ+bmBHgGdg39tB9ZGmpvYxOfPeYQ3JFokBpGyiFSf08ca09IMSzkymmgHhCYZW6a+TF73cLXVYR0fcZoeba/X2E19/gJ/IEDwKRhhGR5m9Gx8Mtm0Tf3TLtJAZAfklZuyWFOIODmkwPjKd2es/f1DRqItBegOAWd4nzAEA9z5KSeJZQ4BNJmXfjkR3SfVaX2kyp9x/o/cAZ1YUfq10TZX7NzgEl4PkqupGtvGqALEmbSs5cNWphGBYFQxvsbHz2s5Ym+jl+Vsm9v6fWjUvHsYOrJgsW0lfiU4psVqTBRi7AQ6N+QzUuyAziVmqHrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQFXB5ub0pX6MqMIZRfVCyx0JvjV/FtgTHEVQLGaP68=;
 b=P9VqnV+JpYoN0fBzZ1cTtSmq90yaLneQy9YpZtQlkeBqViRc22ccYkz2ULsUwgadoCr+lvm8XRY4z4nWW0f1zSSoddFfD7f/U7Pnb+LiERYjzQmswA8proJvorFJlPRsMTxGM8flrE7J3LIV9N44VDEOrKyuUsJlYbRx9XkJTAreMJZZ5lWid5/xYIOfbayoMBYZ2A0XQO16nMQUS9qlA3LYhPIZyvSV1L5wxYG1/rbaKYTNEU5lONWzdmMS10reGIVVI5h9mVB/ePLfI7rrNkL8mtwSNvkBatD4moY/2BKgr+2XkLfDIseFA/dUgBD8Uw5HM9XjboHXAddbZY8bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQFXB5ub0pX6MqMIZRfVCyx0JvjV/FtgTHEVQLGaP68=;
 b=GiyZOH1xfUOCHH7oyZDViUMZzIZOT2TbjtolHZjSF9Jz+uiFZ2NlhYm52NAYa4d5bDQ4ouOJ1BMx9BuyORWmoxGJEabjxl4EKHGEgUxq0rMMoWjhEyf6ao09mAE+hRf2May3psZRPNIoOGFw3fh4p6WsBL8uw0OIviSvizKunrc=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 15:50:23 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::73) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 15:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 15:50:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 09:50:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH v2 1/2] drm/amd: Invert APU check for
 amdgpu_device_evict_resources()
Date: Fri, 22 Nov 2024 09:50:03 -0600
Message-ID: <20241122155004.3565-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ab2e9-e985-46f7-3c35-08dd0b0d601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kjzeeLbx2sUUVmvFn475s9CDG0K7FYtJICWpNt8tr4gztOm3XVglK2bYlNKf?=
 =?us-ascii?Q?LV2a1aV6nPEmHtoDnztrkTHigYCb3Kk+zHe33vk02zukApNXpTeVfV9ircro?=
 =?us-ascii?Q?J68NgNT6lf9Kf0janHBs2u1Qi9FmsAEW9TEeiy9Sk4NAToZhYbCzOa/ClW/+?=
 =?us-ascii?Q?AUvegVY0WMJiYvWt1zXKypn5UekeDWpvphCkX8OWaBZ0126HNAYaYCTzWJnv?=
 =?us-ascii?Q?/VXvlm5XIPa2hCkBEUG+k81u74+xs01vqUg9ZeO5scWK1sZWaCtbBYAxnns9?=
 =?us-ascii?Q?D0sx1Z8q37g7FNeXxotXPNHGOgIe0yIr7nKNk6+PoE14Mpwtnog7u18HdlUi?=
 =?us-ascii?Q?DLlSMQDbEOODfhf6c/V5/GfqiHG9qYfOr0Q3h85Bv2Ufgu1Gf2V+MK+1Enve?=
 =?us-ascii?Q?l4XDK+3kQQrHWnInIT07TRlNMuUtf6uVlJm4fKcvU+9nYB4gWJYlHEfkPVKx?=
 =?us-ascii?Q?3mE7IoykztFrbKuK/UniopoaqthroQEvuKti4702X0WA9I2PEcA997Jl1pvt?=
 =?us-ascii?Q?oPlAS6VDtyf7Hxo29gVYB6XchC8FTM38xnCKh3o2dmJDld/jvs5pNPRAAF8Q?=
 =?us-ascii?Q?oatGBdOc5bJ+HY/Er2kBQQ70IDzcYqOpXcEtM8D5VKKoMyXQThJaq4Xz82kH?=
 =?us-ascii?Q?tMbLUJTz/oqKCc4r1na3+d64HSSJsoawBnieC3TPO75a6NZb9AzOPCbneCYF?=
 =?us-ascii?Q?eOMHl0w5mrW/O7RhulQQtDTq8Fl8QGHcrE7iebq6p6NMU7UL0zwzxhS66YiC?=
 =?us-ascii?Q?Wuxh/FV8ZZTDnh9P78QTqY6R0Cd/UrRqx+ueAdpW1p8TOI/lPSSXqtaCVN/6?=
 =?us-ascii?Q?lZNbZvrevlbE5hSCil/js8Nwhi6GO7d9JKi/5GbnjdcZcKKVZZ0MxO9J+owo?=
 =?us-ascii?Q?hIQYHvlku4timl3FHfvmkHnCh7vKeA8hdHjPvdbs7E6cH4UnNhtQJ/2RAdqo?=
 =?us-ascii?Q?32x0aHh8SRQYhkKOh/9iZEW8WBIH1Y2Ik6PTNk0TBfj9Vspwr7EpLqmWRXkA?=
 =?us-ascii?Q?vHUR8oKnD+tMLboXN0+FnL3utS40IeA4HuAF8oFplM+dPubhmqA2zvOfqYZU?=
 =?us-ascii?Q?nne4AIwdlMapAC88dNJ80HvpeR99hB33aioRhFtiSjq3qz1XG8TzGey0AOGd?=
 =?us-ascii?Q?oeeZlKk2zi25xTdzuIEP0OEVfABoW3eGAr6NAjJMkRBqZMOh/N5kvoQWpmz/?=
 =?us-ascii?Q?35dZYGBBc7dI5XaKPEBcFdlWJVukn7ZGVNWLVbWQNNa3QV0Ol51pRTaf0UDG?=
 =?us-ascii?Q?oFVzTE9Oj396sqf6yVEhN933jYJ85u8yREnpGWzXp8igPswtjLt9whJRPQMQ?=
 =?us-ascii?Q?1mvaet+xbvGIdWDKNzaSopF53yOvf7d5q2INJpt50kcsHDjQrvkYyU06Bj0x?=
 =?us-ascii?Q?Rp1G1NJAzdQDIt3JoZ42Psb/vtVufvPsSCuhgL3cX52CVbrwMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 15:50:22.9925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ab2e9-e985-46f7-3c35-08dd0b0d601d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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

Resource eviction isn't needed for s3 or s2idle on APUs, but should
be run for S4. As amdgpu_device_evict_resources() will be called
by prepare notifier adjust logic so that APUs only cover S4.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v2:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 11d344166ba7..d511ba949dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4744,8 +4744,8 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
 	int ret;
 
-	/* No need to evict vram on APUs for suspend to ram or s2idle */
-	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
+	/* No need to evict vram on APUs unless going to S4 */
+	if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
-- 
2.34.1

