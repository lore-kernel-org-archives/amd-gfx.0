Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D0CD69113
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A00910EC9E;
	Thu, 28 Nov 2024 14:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jVm65+0z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F4A10EC93
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7GdyBDM6H8molfYXOAf71ETCvPMQzVR0af9uVt+lnGdYV6X1cd9S7RPsmOeVGdqX221Zd1VAWxJVT7/K4WTprjI1dvG3Wz2io+Vf/rZWIk0epmb31dlR1hRevs7/m0mjWdlEOK7RFPdmBGTiCYlr/RnpPUZjxy5T2lzr1tisNVVT2lnM+z65EHPimL4O/p1zA88TL2E0+YceI5inVytQnZ83wc1sN5KCFykOpjOJfsxCRGfZwPty8UTziSzaN5rgyxIR37t5hn3ho8udmHSswztSMedNKJzCmGzlHM0bepotpV2tqXnktnEjCunQ9dS8vW7ZsVq+ptO7IZQ/2UOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LovYLDJsdt6xZkjTkEaOc/5Hf2DMHW4ZC2hdcZALmuM=;
 b=O9B78afs2jE7TfMZS1ppZKQ/fqOpd/z+pPjoER2HKzVGTPv9RC2K7vUHxNMAwnz15v2vahHb73V7nB9SrD+u+g/acxOO4mGp4+SpZf/NShL6nANJezDxDTEiDemRB/ge56IRdkNoU7y20f+NMIZQN5s1W3Ly8wEyo1k0hjuWmS86OMUYkKz8o67wBvr9SFjaJ32fhy2tV2gmqUDt1vXbcUfJhDHKGcd6kIga//a2ROA5cKaHzI3WUJ2eU18fK98Zpvrc/OOMsP99jGITui5aTUjvuGz+eZcT+Oqg+aZ2FR48T5TNFErTN1Gplpn25X8SlWwJ/33eem6eBbPKfSwo7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LovYLDJsdt6xZkjTkEaOc/5Hf2DMHW4ZC2hdcZALmuM=;
 b=jVm65+0zfY+d40M6hahEeW9GRkoyU58yZ2Cyas4I3FD3zg5RDBz6gdo0z3FK/xgtqmAdwrFjeNoDJ77J2Z1Bp4mcdApm0MPlV4KgLJXZwlZalmtEZCSTeVBsV5Hi62hGMtG56HAkUFJKzEomIWo334l+GHcsdrtM6CoLK2hTOUA=
Received: from SN7PR04CA0161.namprd04.prod.outlook.com (2603:10b6:806:125::16)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 14:30:15 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::75) by SN7PR04CA0161.outlook.office365.com
 (2603:10b6:806:125::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:30:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:14 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:08 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 0/9] DC Patches Nov 26, 2024
Date: Thu, 28 Nov 2024 09:26:22 -0500
Message-ID: <20241128142958.28370-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1469c561-c8dd-4083-2c13-08dd0fb92d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S63TNSED7CxIdhIJSl3SZ5uyuP26G4MjVnxJJbvR311tepNQkT+Zhb0E89qe?=
 =?us-ascii?Q?tiCRZZ9IHVIzl5TcrkeJwxPPJrcE50ZPKTnORqCrUY9vcAuGSU/4qwRQPMhN?=
 =?us-ascii?Q?jyXpst7rQl6Cf7yCUGD64nXEQJNjYtH6nwOVjlOWwlVKr1FGuqEK+WWOx8VO?=
 =?us-ascii?Q?BIFoU3yJCbBUJL+KTfbTXybqjXeiMsNiUp+4QbhwLU64MSqKXq81b5QY7Q+F?=
 =?us-ascii?Q?2vP9UnnB9DS6302+1Vg1zylO/A/E7bx8rL9SFRzbHdVpvb8zJLDyoB47ASVr?=
 =?us-ascii?Q?nUwZt1Mr1beIWLdyWPV79aw4aURSJhJXA2eCvm7VCnf4NvKds8PCZLz4AjWW?=
 =?us-ascii?Q?AlvxzpJf/CGLCDfJuu98TQX/Z4VQHhZu5cFG9uaRSX2o9aTMIJAHjQF00Lmj?=
 =?us-ascii?Q?HSQuYfRA5xEpoYjs6sLgarxCaGUn65tPN/C7HHgWhbJzr2mx1S4ABF3uF08/?=
 =?us-ascii?Q?Q4W/V83vsBX9lIBEPIdu3Rd7ayuTKdUTaLAVI8NWSCmGLF+JGR8ip517wKUC?=
 =?us-ascii?Q?XZeg89XntIjjEdg3bEzUqLRriPL9tR2JBmF7xQ8MCnOF+xLHtgJdSgL/gAS9?=
 =?us-ascii?Q?dOfx9c50XSvYp0/l6cINBAoQ0vdSSCsc+5NV61YRLvSMFwaJQcEJD9r1UxQg?=
 =?us-ascii?Q?tJkFoWa53/22HowEj5rMY5UuIFUt3xtz/TuZujo+ybJ+SCpvVLNkdfRfOS37?=
 =?us-ascii?Q?UvGH3i1o79DF0l5Sd+FWaw5EajSESAnH2icuL1YsZwQ24mX1iIWEzg3hHrIE?=
 =?us-ascii?Q?1lVOgHoWNKmgHcQlIGIzn1faebZQQRa2xz9KyhncDu3B91HXQIKZ6mNzj8/a?=
 =?us-ascii?Q?Aim7vAZ+cWo/h4se7Mf23RWAL83nMybcnvqC73SE3No+mmVXWivVfe4xELFw?=
 =?us-ascii?Q?TJTbDcugU7ONEX43i3vq7U0UpjDkUCl9SXVwRvFC6g/URyVS//KkPNSv8UsR?=
 =?us-ascii?Q?7Dy7OwjXv2lDytE3Do31SYPFn8+p7LbvDJzNrayBW7MwqSeLzPF3snW+BAqk?=
 =?us-ascii?Q?qGdTednABCFb8ak2d8CZ5TsBtqnCAd5jhm2KsnEuB0qG34z0J+0IG7Tw+KN4?=
 =?us-ascii?Q?62UpP+Il0HCMUTSsEaSr8u4PK+GkC0RvKupYRAM7qdaf71HfRnIpxJ59tX6Y?=
 =?us-ascii?Q?z+A1g+Yo2Nwoh6Hrrss9q/YrM2uoLrHWjbQ6xeEwxxaWYPzpMa5rJ4udcO3G?=
 =?us-ascii?Q?XXzOGo6nTsXYksviZpx+VTvd5wX7iRaVusrw9BW73BkfhHjTHvTc7FszkcfV?=
 =?us-ascii?Q?GkEdSkapBDRQVdQqynCA/QEeZLDYrS090Dx23tybcbu2LzAm9drKYnqIcNYQ?=
 =?us-ascii?Q?kg/9HMs83R0bR7bUDF0Glbk5LJpLNDN0xuacxb+z6zJMobCJZdWYucZWu5gj?=
 =?us-ascii?Q?xctWqo9GQRrNpD9//cZSGzW3Hw34pt875ttJIVXz0/2Iai8jGGWYfW8F6Fkd?=
 =?us-ascii?Q?tdVijjhnlU+DWITNri97cMFDeIWvkZxN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:15.5622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1469c561-c8dd-4083-2c13-08dd0fb92d18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
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

This DC patchset brings improvements in multiple areas. In summary, we have:
* Fix dcn351 clk table
* Bug fix on IP2, reply, DP tunneling

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Deucher (1):
  drm/amdgpu: rework resume handling for display

Aric Cyr (1):
  drm/amd/display: 3.2.312

Ausef Yousof (1):
  drm/amd/display: Populate chroma prefetch parameters, DET buffer fix

Charlene Liu (1):
  drm/amd/display: correct dcn351 dpm clk table based on pmfw_drv_if

Cruise (1):
  drm/amd/display: Adjust DPCD read for DP tunneling

Dennis Chan (1):
  drm/amd/display: Revised for Replay Pseudo vblank control

Nicholas Kazlauskas (1):
  drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic

Peterson (1):
  drm/amd/display: Check that hw cursor is not required when falling
    back to subvp sw cursor

Samson Tam (1):
  drm/amd/display: fix v tap calculation for non-adaptive scaling in SPL

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 42 ++++++++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 93 ++++++++++++++++++-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  | 41 +++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  5 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 35 +++++--
 .../dc/link/protocols/link_dp_capability.c    | 21 ++---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  8 +-
 .../amd/display/modules/power/power_helpers.c |  4 +-
 .../amd/display/modules/power/power_helpers.h |  2 +-
 14 files changed, 215 insertions(+), 50 deletions(-)

-- 
2.43.0

