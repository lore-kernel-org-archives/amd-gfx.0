Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7C1106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E23710E169;
	Thu, 26 Mar 2026 07:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DGXR3+/3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4194F10E169
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocXSvn56kRGOfSPOoelY+6B2ofc92ZzR7Fv6Xe4AVnQKcpyo/bS5yb/Towp/Paq2C69ynVb9F3y73c8ebfXuNBIPcXbCwmVrdN3OcRoBcBRQAG4khahZDzID52dbXIwn8xAoSiFeueHnXLuc74vvYEWIVHgiEo71tD8rga8YYP8JDEK8BPDxDJ6S8rzD4ne0DU55hiLDKcHXP+w3q0VJ2fKF3cyxnmMVc6izmM9UyteDr3U8y7YGPfq2aX1Kvfg4BxCB7w6AoSEFnvLIEcEyiuKpmr+uIN/p39sVIZ5687+S3NHyGAVaELQAl31gQ8NNZGtksguWUbqGrqnt2b+2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+m9/Jm8Pac6AuzvRDtSt4anGDQI3sOGAmEgH81fi7o=;
 b=DBOooW7e9YzZjTt4r/8GPF80bpVb2bigyLS7xWVT3Fzu9gHiOyrblbPuCHpJUckWuE+XbX6MblYtH9HNGOvkS7ZkUC6IqRWn96whr+u+CsJe1SpirSKXyXU+mpGuX80njFgJA4CrOC6XfdwoREdLFJa5MJe0iAkxKPQUYP4z8SrBZCPAwbmCE7Fp4J/znWuCKKDocxrjD33QC1UnCQVV9nr+ftsomjCSAg17C1ON3creThiIJvEH/H12x8Vg7aLaiUD400BzPWPw2zQYsB0uCeq1qBHBwWpzqHPXgY2jW1s2QiI5k/l60PF107tBf0ohCLWNJ7MW+guWk9jzQUpnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+m9/Jm8Pac6AuzvRDtSt4anGDQI3sOGAmEgH81fi7o=;
 b=DGXR3+/3y5sYl+Ndb1WogoIaHjyEkObRrQiM1kO/v9ld4+SjzATzilI1KkRSU3wEDzoUcUO/S+DujfBn3QG4lu86d/nU9ur9f0AVjKjCMICsCdnI26r8rXCnXmjLYKs/skMpMGNN60JkuXKTbUjN+mvQASOTDTh3l7fY8mvNKmE=
Received: from BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:54:43 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::9e) by BL0PR02CA0074.outlook.office365.com
 (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 07:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:54:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:39 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 00/14] Refactor reserved region allocation
Date: Thu, 26 Mar 2026 13:15:21 +0530
Message-ID: <20260326075412.1378411-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 29de7080-2258-4573-c203-08de8b0cf04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IEfIhpLdwBaRn1EmNxKLNDt9H8AhSJyGgHEjOn8zTS6k8IpHE+SKBtXIUxMj1WvnAldSxLDxmAq/bNUe2q5tB0iVhqeVWc8RriGa/pRlCddHRf1u4OCzYPAFmSVZW0dHCyawowaIM2QLY2jof9hHVlz/CB98vT7uBDuKAojN77P2gs0cYkbcLc5AQUbhr8HwTIPK3Hp/3nRBtrO/cxHNriYISSK4M4boKLfWJztVl1IaY0+Ku/6hJy0M/s2m9KOUE8rYatdO3cmMKg7PDrPTdL5Mjj4UExUFaqSk/6Oxton1kkvCOyKwbnPo0OIfo7UuiEcXkLPYPTym7Wup5BSR81EqoQFdr7h8OFjka4jmH2HxovAQCf5kVm85dkQr+rMTzHr2MLQdxjRc1oSlSBlHtgxCOGFsO09+NGU76d+qQydyD5BeG8+5h4GvJ9M/YFsCgh1Cdl8E+A6RUDl4ZGhGsmIodpTsddguOG0pwcd+TmkGfibn1fN+uIBPMWEJy8AF3ThCr1wdQtl50xDIaIQK93qBWszKXgMxdDmiFkoriDRMIGH3TDm+hMh0flGLJ6P0aCxl7NjWjQ+3eFLQTGYQELDx0h24D/xySMAi8svUT4+vVzVp4Cgi7Prg7pMafHhRNUkHJHvXMxZujWMX4dWQEFZOUB3Sz22Og8LraY0OaV+H09gjhTTBZk+rGj/w9sknE6yfm5l/4+06BU6oz6t/mi8VteK/rSK4Z5NscNzzXCsmJFMoJORdWRe/QJogdeUIJo6mFDIJn4DUPnVmR49thA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8pce01lOoVv5aBEjXy30Mq5Jz9F14lHhf4c4zK6mKDdRdUNnuXF5l9T0tTX6zayiRIgGCV5U45JiOrkAbzn/ofad+l9cu65F0aiGT+6v+7yAAfb1qoiifOI9yzacKtvw2adKGnztAjEVove9zqMadVJfg5dW5BdbphC2SOrBpmXy2drgsu6Vg9+hMNKy3nBq5fIx38etHDUzMOYUgPsRpfaC6l2KyOHFURRAKznain+0lqBvLMXhez9KsawbFXDC2GZ79gziAhmS7Ib4+/6e170vG4nwf9pQKvHvIA5Fxkp0E0nClUYx0rhuAVGll7yxQykacc0RaYPT3Wqg9VjLJ6OolLu4EpJ5Uy75oPR4/khP8g+8CJ2CB45ZvX6ImdGNrZqEMrJ5S44yIcBpjz3FiT7ZJzLy7e8cvVFo/V6dP3PbqNx/tyXI08FkoQ1W82ZW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:54:42.0158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29de7080-2258-4573-c203-08de8b0cf04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
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

Currently, multiple variables are maintained in memory manager for various reserved regions in VRAM.
Such regions should not be allocated to other purposes. Instead of different variables, the series
assigns unique ids to reserved regions and maintains an array of them inside memory manager.

Part-1: The first 9 patches of the series assigns unique ids and maintains them as an array of
reserved regions inside memory manager.

Part-2: The last 5 patches of the series prefills reserve region data upfront in a consolidated
function and then reserves them together in a simple loop. It doesn't fill info for all regions; the
data for some regions could be still be filled in a scattered manner like from atom firmware tables
or host driver tables. Also, there could be some regions like extended firmware regions which gets
filled later during runtime and allocated later. They don't get allocated in the init stage as their
size will be 0.

v1:
	Part-1 
v2:
	Part-1 + Part-2
	Rename functions/variable (Alex)

Lijo Lazar (14):
  drm/amdgpu: Add reserved region ids
  drm/amdgpu: Add stolen vga reserve-region
  drm/amdgpu: Add extended stolen vga reserve-region
  drm/amdgpu: Add stolen_reserved reserve-region
  drm/amdgpu: Add fw_reserved reserve-region
  drm/amdgpu: Add firmware extended reserve-region
  drm/amdgpu: Add fw vram usage reserve-region
  drm/amdgpu: Add host driver reserved-region
  drm/amdgpu: Add memory training reserve-region
  drm/amdgpu: Group filling reserve region details
  drm/amdgpu: Add function to fill fw reserve region
  drm/amdgpu: Add function to fill training region
  drm/amdgpu: Move validation of reserve region info
  drm/amdgpu: Consolidate reserve region allocations

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 362 ++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  53 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  50 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   2 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c |  16 +-
 19 files changed, 256 insertions(+), 308 deletions(-)

-- 
2.49.0

