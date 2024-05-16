Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD0C25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 12:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE67A10ECDB;
	Thu, 16 May 2024 12:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xBCxFAFD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3A10ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 12:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrxD6bmbIhGZ9T6hvV1zeSDlrj7JbAUNTR2X7vyDxk+JxM/xnuwJKg5wKynNLin6jyBZVLHvEB3AoDFdxzCSSdqgpifVBin9wmE/1hIAC73X9Q9kUOslUuljL74G3ORMpUIUPf/m9q74YMcNhJjt0SvNA84uNCiregbecHLLvuGOYtGKq2m+dm0Mbl4Y0xUud7hZgAVVzuhJGtxRc1FSKg7gT6cdSwfxQFMr5ajLf9mId5tr7DdeQRJA8+YpBvT63JfBHRorjEgvLXZ+MANQ4Mb8bLiiausTldmAh3A4m4ed5i9atV71FqI1FwLMoUi/dwDaDco6FJ2bPA6PN1PQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjLa9nAPqwh94LVnD/yqvR1Z80sO9P9jImW1ckhtJAk=;
 b=Q95/wTzI+j3Bl+0Y4+8fWiic9QhhWa4DLZWLAk2MKHhjtGvZfjswmDo99LDW/8WQ32ysoLe+jPY+VeeRQTQvaA5LGbHIAiu3VO/Ca0g3yZfdEqd2u2S4LH3i+WIJE+OQRjsG+dsel7uY2GydTGTKa0GjQtVdZNh9nfaNHRUjgqsOHBiocmxAf8Gp0GT94slJfCXLlWh+qyaP3s6OFet5O1hLbXvYuUcZkg2IeTryHZO6aDkNRhzZEsiFwf6QXVgaqffHQcXVY+zEFTQy9bxwSoQBWccvWuKcfu7umthcUspwNeeeQR2Holv5+Kx6UDsBn2aea9W7rK6hIM4E9ajiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjLa9nAPqwh94LVnD/yqvR1Z80sO9P9jImW1ckhtJAk=;
 b=xBCxFAFDtvoy48ec9HdkdNb0BiUI70MQErbBZ3IJPvpy02GODVRa4rev9Y0WnJK7G79DKotmTJ9hDx3ewQFsLve/TRJhcCwIv8U/drhTpi4aiHibLeVEJqe2jjKH6dxo1ihsX4icnf4xy0Tqnnt6wCbzhYi8Hbvmgv9DFXFhvQ0=
Received: from CH0PR03CA0396.namprd03.prod.outlook.com (2603:10b6:610:11b::16)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 12:43:39 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::3e) by CH0PR03CA0396.outlook.office365.com
 (2603:10b6:610:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Thu, 16 May 2024 12:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 12:43:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 07:43:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v5 00/10] Add PM policy interfaces
Date: Thu, 16 May 2024 18:13:08 +0530
Message-ID: <20240516124318.508785-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f203c0-5acc-4a96-c398-08dc75a5cf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mfy/RaZaRLFu48X8DzqiKU5lXV+do3rEoWpPgRudPq5jXycTncuLp8xUrcYD?=
 =?us-ascii?Q?LKa+7EhlaA861mPY2S2qMbNiIbXbLaYuAjlpR+tS3Bn2bDus4Ja1syKgOlTQ?=
 =?us-ascii?Q?YIXBIOOc31kfzvV6yvsyq0qU4wBTTceG8UA9DUl3cfDYyPq5iPC4OJNBvlPN?=
 =?us-ascii?Q?iuKS6kC94u9/4wgaReSDakETkIy6t6yHdPyCM6mkxMGS7j84PxsBBrbzn7f/?=
 =?us-ascii?Q?6U00JBeFdMLo6mJGNWaNcONrfwvG6UzWNS1X34nUxwKP+zWBoAZL1u3rmbwH?=
 =?us-ascii?Q?2I7igMCwFMd0h++enGZA2coGH9xlgtV3I6JUBDv2YDewWNfayYIWoEKhpJlG?=
 =?us-ascii?Q?yaLbrLdox5H2PifOQZ6HXHfFGK68wYK/GtqsbWzntCJMkXW60LNbEPiQ9SPP?=
 =?us-ascii?Q?tOqPxB40Jh9fAq1Hwp1UMiyTNiBR63AetpJi31FRdRFBX07ubR262ieslDeY?=
 =?us-ascii?Q?fste7E7qD63bZm8GQ0dd/ozbwGsY+zOXD9pB5jgBt3iVC4qpb+mh69QJskys?=
 =?us-ascii?Q?5kRqqem9VkeUYVyrj+/77Ui84NooKJ1VZ1z4B4YiR0Vl77j3lriIh38kbJIQ?=
 =?us-ascii?Q?iUaaSCWBB3P1YFpsVXtIqVQWg3IYZrS3ScTPTDlbombxxOqAPt1/BLe+oSlI?=
 =?us-ascii?Q?qZYDeHcdV8uH1Fgg+pIG5aqIeoaWiwXhGkcX3Q4BIkG83PjDbDcVpMsJsCDB?=
 =?us-ascii?Q?q4cT2gEzlVYmDvVid0HG1TKZ8Pc9zlbRtT/S1iGDKXS4Fuwt+bKh0bHRVdFm?=
 =?us-ascii?Q?BwlpWb6N/Tqh+UWztVJSRORors0E/n+IscmoqKwU4GI4xjmVmDFSYEMCWFDQ?=
 =?us-ascii?Q?zu4FIqW5kHXAQU6kj6km07JhFVJkLJtRHjSiBQgqSkD37cC4fcEf1Fs2aci7?=
 =?us-ascii?Q?8/FOSy9wYuuAbhUQHV8qWa9dW/jMHxtSzEe0WfMrDY58kSsgnvYV2yFvzzi3?=
 =?us-ascii?Q?Og7uQBX7jyEahO+L9I2Fx2yv822yk2wop0sxoLXs0n1kHTcubAf/7rAj2GVM?=
 =?us-ascii?Q?tQ/p+KKIO8tCav/IucBx0CwrWGaiPLu4LPOpFufmjsxjRADu9gLm2NMgk+Yv?=
 =?us-ascii?Q?WwIkyyLKC4KOCHbKfVSQCnPRJN14VP2at90GCf37+gu4T+SBGCWNyVb8Bsq8?=
 =?us-ascii?Q?8RBN1S39gPV3ERfDtzeUV/jVmKA+iVYZhXzB7qIvTPHMuXGzj0LqDL+7m74G?=
 =?us-ascii?Q?AFf8WaYVRotOBDC33eBPdWBhJbqt1lPUEyEiAXHvKev2jReXlhJuwDZNdp4l?=
 =?us-ascii?Q?lXZ5IuucdUN5AAZLpqLlczBonqeR/yBgxWdHaW/X05Wot4ynmk03jS0MQ/+5?=
 =?us-ascii?Q?/y+YU5KLk5J33XE66YHZtjSogVnuDFiGiNuWjZ/Qy1nNyNkrLaOVRcO3TKDT?=
 =?us-ascii?Q?Z63S41Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 12:43:38.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f203c0-5acc-4a96-c398-08dc75a5cf00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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

This series adds APIs to get the supported PM policies and also set them. A PM
policy type is a predefined policy type supported by an SOC and each policy may
define two or more levels to choose from. A user can select the appropriate
level through amdgpu_dpm_set_pm_policy() or through sysfs node pm_policy. Based
on the specific PM functional area, multiple PM policies may be defined for an
SOC For ex: a policy may be defined to set the right setting for XGMI per link
power down feature and another may be defined to select the SOC Pstate
preferences.
 
Presently, XGMI PLPD and SOC Pstate policy types are supported. It also removes
the legacy sysfs interface to set XGMI PLPD as it is not used any client like
SMI tool.

v2:
 Add NULL checks to avoid access on SOCs which don't support any policy.

v3:
 Rebase and add documentation patch

v4:
 Use consistent policy type naming for read/write (Alex Deucher)

v5:
 Use a pm_policy sysfs directory node and place the policy types in individual
syfs files (Alex Deucher).
 Fix a logical issue in smu_get_pm_policy().

Lijo Lazar (10):
  drm/amd/pm: Add support for DPM policies
  drm/amd/pm: Update PMFW messages for SMUv13.0.6
  drm/amd/pm: Add support to select pstate policy
  drm/amd/pm: Add xgmi plpd policy to pm_policy
  drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
  drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
  drm/amd/pm: Add xgmi plpd to arcturus pm_policy
  drm/amd/pm: Remove legacy interface for xgmi plpd
  drm/amd/pm: Remove unused interface to set plpd
  Documentation/amdgpu: Add PM policy documentation

 Documentation/gpu/amdgpu/thermal.rst          |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  33 +---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 178 +++++++++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  10 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 114 +++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  41 +++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 ++++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  60 +++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 ++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
 17 files changed, 579 insertions(+), 169 deletions(-)

-- 
2.25.1

