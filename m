Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A3C25B77
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 03:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C25E10E74D;
	Tue, 21 May 2024 03:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OTCS1IUa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0948210E74D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 03:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcDvxIsC86LBjfhi+3K058bHjrMjMYfo6c0t3VZ06BOvyv9hzSayYow4Q/RDz5F0UrXvFYRmdCmnqvIFrS3Ls7kmgrTfmuJY3MY0vxzxzii8vuEl2AZXhjEZ3vGSZaVLfkSWq6AB/wCcy3XhNDwSv9JM6CBanItRcQwAQeU9doK11oUf3A9GgbmV4WpA2zLVxjyNltRD1DkeZLy8O0JfU6F88nPu6N8timTGeQLmwTWuJ8DeUNT5YtRyooFzbxiW9ij7wwMwAC6cmBj+IJmS7OnKccE0vWVxU5LIKv/pu3FRo5K8I3inuSsEBtzKpWWdAw1OJEB2LNJe6SZumE4Jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KmZ/wdG2ORMyz5bCFSy9h0VZSP5JcddEJt6aggC+L0=;
 b=aIFjowRy2hVV6cEkAgDHwMmJOzTvtoDbdchNePQnjptvTQ0DFRyUiDyieiYY8WlTFhwi9m+rKG+xD85Guz6pDcNZMH6QxylZnk4wBMNbBU7NwF92TsYGzUFMv1XTItDmRYqC/tmXQ5ELiGqqsuVp+V0J7Id4KVIL4qmX2sS7mGenVmsFcWFG4xQ2E5LzsDPKG8rSsF2mAcl4H3u0Z11fHXYB3puPr+2Zi9V1JQoJji1Euyu1g2xM3gyTVuKic4BDfMShGT1RkJE4B+LCtfqBXE6N73N5y5q3+9MOZznMiWaQQm1pHQPOrw1mugSE8C5UHcGNfSyjE6DqUJ+RoNEQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KmZ/wdG2ORMyz5bCFSy9h0VZSP5JcddEJt6aggC+L0=;
 b=OTCS1IUaz8hhC9nnUDQca9AshgY6kQ12dGqH7G8QyFb2SkWlbgfM7d1tGMllaPQ6JYQBgMRoz9QzVnUGzfN2qzSGn+YRiL7xnpMNE7u/xPPeWEzLorIH76edytu/eGIjOA+S24okUvjA/35QQOKespwjgclvQLs/UImIUBPLlC8=
Received: from SJ0PR03CA0123.namprd03.prod.outlook.com (2603:10b6:a03:33c::8)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 03:25:23 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ba) by SJ0PR03CA0123.outlook.office365.com
 (2603:10b6:a03:33c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 03:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 03:25:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 22:25:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 20 May 2024 22:24:51 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: fix unsigned value asic_type compared against
 0
Date: Tue, 21 May 2024 11:24:45 +0800
Message-ID: <20240521032445.288578-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb4d0db-5e1f-4dd4-7bed-08dc7945a686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c458/UUZdE1gjdSe8dI+oiZmzFA0RIUP3ROlgxdKAo/oYoP4uKmZ3Hbhc1yk?=
 =?us-ascii?Q?SYAB27BhByE2GqQ7J5jLje7Wr1W/0/HuiAvJD1Qkrs4IZGry16/Ve4wSvsKd?=
 =?us-ascii?Q?3k5mMLxPvmunmXdi5IXxx5uczVMNt5Fyk9RGm6naE5WCxXxCTNMowAHusUzK?=
 =?us-ascii?Q?wtotAeOW8X3e44EbEVTtMJfKTTgy+v+bbCD5INaTEdllX5qVt8izgfOhD4oa?=
 =?us-ascii?Q?plW1GKPCKPdpMeGZBAZ59Z8/cbz8hckR3VwJMJdOCesnD2I1F2S5AxpasQ+J?=
 =?us-ascii?Q?ro/obHZWB4BdEImQtcvhkp1eHnvP1QG/L+iaKzEraYd5KAa53QIknvCiGrdZ?=
 =?us-ascii?Q?4JYu8Qj78KVjcGm8UC/Mkpd0L95R8QANDA1UtDdlJ5/JcCcJgD1QBzkDCdIq?=
 =?us-ascii?Q?i7lGXLMriNalM6p7CgEtDVvffNZb1Gs5nr4WLYnj6rnZvXJ86f17SNt3HBY8?=
 =?us-ascii?Q?qGtmNsGc9NR0OCVzMcpU41CmbLAIS4YA/8RDtWHkezIU/epPt0kj/Asebb3j?=
 =?us-ascii?Q?GKDuEABDb2FC/ottF1yoPxEIUuRzYhF2+4Q8p4C9UdNHd8SQWpsB8khH9t40?=
 =?us-ascii?Q?ag4YdBS8PhAx3DsysogKdW1yuJZ1V0sYXxVZR9HvjCAgFD+9ySqZZj7btfJb?=
 =?us-ascii?Q?QHUihIJNkMPiKG29S82l4ZqdAwxS25OOZSmhmVA8EknP5oSy6mv1/7DEPRZ+?=
 =?us-ascii?Q?41Es9PiimDQA+wkcezmN2SdOThgE+Nq7eQMM4gi0cZnC3iECC3+RPeKrmTLx?=
 =?us-ascii?Q?6EnbtazN5ogUdzxSXpcTbi1/8mrJS5oELOQhtBp1u2Z4M8mDOnzZzMfssxFa?=
 =?us-ascii?Q?NYd2IhwlM77YIZEx4/XUF8gO0s6E6FRMC9apHVUflsL8LAjaEgWJGcxWvGh2?=
 =?us-ascii?Q?e5KozoFtpCDlP0EV8DSp+qiMBSxz4qao7TJrqk+s+CbqI7wcFdfAXALCukjw?=
 =?us-ascii?Q?OoK1pnLbdiaC+aXX02qoH7fMIcGAMKeaHUDiPRRCBHPVKbQdISSCMyYWZ09U?=
 =?us-ascii?Q?yTlGB8UrUwrM2RuFQHoqLmgbhHcTeFU/jrRrKcyvsRlGmyTydH2xDKAwdJu7?=
 =?us-ascii?Q?z4ygvd7CgZUBWWFp0Bd4zvhjhOkLbaPftjQ1HfJDxNN7i+5zrdjzXxwXOaH4?=
 =?us-ascii?Q?/V1b60kFOPHhcg57u+bbQ53MqMDCVGQ+Hwy1rnOcRiKce3Tz1/79ySVm3f17?=
 =?us-ascii?Q?E91QS2vAn0YQ26k75sM3eplqz5e9cZmpIMXYenWarMRki2fQeaUBHsU4gXfh?=
 =?us-ascii?Q?G44ZS+sa13yge5Soc+KMUY0/XRCJk51uDO6r3BGCgv3rAI2s5g2LhVAtBWfm?=
 =?us-ascii?Q?AsaDhf6jOOGD6aTgQsNJraT45cpUyoR14FsVqRqfR5W3F8iuQTmKWdbqloyt?=
 =?us-ascii?Q?VPQDZ88X7JvpRziyc3X7ehUHLwOS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:25:23.1897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb4d0db-5e1f-4dd4-7bed-08dc7945a686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957
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

Enum asic_type always greater than or equal CHIP_TAHITI. 

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index f245fc0bc6d3..feca6e17113d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7928,12 +7928,8 @@ static void si_dpm_print_power_state(void *handle,
 	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
 	for (i = 0; i < ps->performance_level_count; i++) {
 		pl = &ps->performance_levels[i];
-		if (adev->asic_type >= CHIP_TAHITI)
 			DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 				 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
-		else
-			DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u\n",
-				 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci);
 	}
 	amdgpu_dpm_print_ps_status(adev, rps);
 }
-- 
2.25.1

