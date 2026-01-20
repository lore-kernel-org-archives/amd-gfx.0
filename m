Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F1CD2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A3210E4C9;
	Tue, 20 Jan 2026 06:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pdla7yTO";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164BB10E4C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQQuD9g+0UJ1Ud7kMLKLbo7ujH3Wz/O4QWi61UXqaObdk/8m+DVJRdgdiIlTGAvXURPvl1il779Ix0KFjEMup3cyWVkk3bIA0eRw+9X0NJcEgeQ3X7MbSXUwwI6sl4Tus4xSbUsFesGfYaqmXsCRzhtFhLfk8KxUkn5ty1o+soZIT/YEra7UrhczKmNjYdK9mRNrXBX+JOTJePCUIhKpz4ht4XR3DWUkzS+NmOiykdayiL9CVQucMjSqvBWp3/Wn91YWCE0I/o/7PFPyLRZcpHWHUCLtX+kfiLjmOY+/qW7hWJ9Hke6sOlLWtTDIOVnRfL/ReT3e0PzrQ2yxKu88YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjkOoqOXh1p6bJZTnAw8V6psec/WElOKxxSSFk4+XM8=;
 b=NU89hGX88UlfwbSciHDAokTMlh3yNcW6zMCXFyExy3/AlqyiycLWCKVBXPQkxn2iuC8N4t4dnlH7H4zb0MW4/v7iHAZLenNxFwzMHjTo0xEHTGjtN0pdzDNHL9tYmkj2EqUUN3EROpAk6hogYQRX+tUl8aG1UuWf1TGt6z+HYtv/nWKnLJBqO9bSeQ39fkIDkmEMvSR2hob+RcGxMv/wRSUN4nft84sCo7WzlOliLFlnJFO8XZR4Vozkf6o8sWmaOh8sYDwZ7Gt8Cs/xphsvP1gZ1pIWHSjaCNANE+VXuUVbN7HEWXlDCYzIpL3POz9Zcv4J6q5e8bqy/Ug7vie3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjkOoqOXh1p6bJZTnAw8V6psec/WElOKxxSSFk4+XM8=;
 b=pdla7yTOCsB0+/0BRvBI8AqvDmT+BNzgBBTDHYoSn++UvqJ7TWPInz+7xWoQ//lRkrbj06X6rwfpcB9B+0V7EmCz8NhixiAMKQuk3Q7eYVqfQBNTOuTVeWO9o5K2GwKL6XeF/rdQQ9XmVJLgvmCHzNur/95Y0UHIwMhAYOBwY7A=
Received: from SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:59:53 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::71) by SJ0PR03CA0055.outlook.office365.com
 (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 06:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:59:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:59:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 00/15] Consolidate register access methods
Date: Tue, 20 Jan 2026 12:27:34 +0530
Message-ID: <20260120065931.1300054-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfa4834-a3bb-4bf9-c338-08de57f182e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?77fi2itxMiMSLh/wAyk/Lxc2H0YXLLOnfwV9dKlpmJsfcBBRKIRJ6CP6tUaj?=
 =?us-ascii?Q?ApMbol92nC+p+j1D9oG/zAcQzR/r824wo8L2S+q9LsLHfaWvo9lHaArfCfFq?=
 =?us-ascii?Q?TGldL3ga0q74jqT+DI5EBgvydmm4BDN02nerz21kx5XyQtbEr09gtJJ+DV9z?=
 =?us-ascii?Q?mg+wlPpQ66qaLom6U8bH2vz/bBI65TO7blUiydbfTQaDK3+2+bzqAvhWc/tU?=
 =?us-ascii?Q?GwoV60v6HGHANLVFUusIyGCHII0leVwe1095HYRn6MyP4YqQxcWjflL+v63S?=
 =?us-ascii?Q?0aQ/xerMuL0ZDLeEIxFEJkerJlJUNLvQOTXPyLanWSL5wAyRs+wqdMg5aXLF?=
 =?us-ascii?Q?HDgn8jOgbVBvkPDb0hWgMIbs/I9SLR7xQiDXNQsw+E8NWv3Zh19N1sRrYU6R?=
 =?us-ascii?Q?RUWxyuN+9JZ8MuepU2ThMZR4hxhHEkhYYSR3y5hDaKFFrPpwB/lCmkuksWKK?=
 =?us-ascii?Q?oY/XAwAcigog7owiFJkoBTFIJVPQJPwlcsw1kp5g0RNY/v2zUJ4YQceegWFh?=
 =?us-ascii?Q?GJXYoxi/n2Ea/xgjuiRSM0Iz1+IIv72EMggLtQqbMzLTWu9AT4kTLQV/9U1n?=
 =?us-ascii?Q?yNvx0yPRfoMYwuwsoVv+Q52+xac+WrTCrQSAdgZ3pYK5FEnVS7jMc5T/sVTa?=
 =?us-ascii?Q?Hh9yK28O+AeY5GPdWgj3pT/bDs6Oi7oVCLHQ4mBH2VWE5sRQpDtscVIlNnYF?=
 =?us-ascii?Q?KHn/tZ0HR2u5LyFteDDcNDs5iITq8pdA1kwtE6rgisEOhPZFD3D/iYhPris1?=
 =?us-ascii?Q?NZN/9iC4Up+bFYVmr5hBnwtqM5nVmm9bqko6iz1WYt5vXInwpr5RILeyvrkU?=
 =?us-ascii?Q?9we1nHrEeg2ulZV0AEh4sFSpB/BF81QsmqJudSersRupNwLoKX7aChxeCRSF?=
 =?us-ascii?Q?Wh7KPlLX8FgxyS8BXtaIZhkHWeJmgMInB1+CCUVkCSyB7+tfB1US69DwlUp6?=
 =?us-ascii?Q?dK61ERbMxk2Q4bm1m/8Vd9GuEEERlTrN3ypzDZqGfxF5b9gIxuHJSdWjaJtA?=
 =?us-ascii?Q?QQ06x92iFoAaaNUn/fyUCKt8AxRAQrH3G6VWap3L3zBHtnslRJ5eZH1qEmpe?=
 =?us-ascii?Q?xESkBoQGzhKrMfHUJPjdrS0FjXyEmbp4E9cGqZ1zlOU8ZoVg4xp6d9KUYPV/?=
 =?us-ascii?Q?ay1LtCNmkEcwn1bsMJWTtGStX2pIoqJjlAHgm1ld6r/U/PJKV5JL5xcHJjed?=
 =?us-ascii?Q?kfbGtF21vsB0VimYGjVIEQBOApztGfqkbm9xc35F4lnb03jzd+jVMYIWuokT?=
 =?us-ascii?Q?KAvOI7IR4VTOkv+0uMjDXy4DzCpR3ZrK8yAhiIz7faLcZzirVyU4YI+Zwrit?=
 =?us-ascii?Q?S/x/v9RiHwmDZ9nQXdVdrlppBiwlTrAgRPu6cmZNWC7sQVFi5g/iLn7nq6c2?=
 =?us-ascii?Q?pLSaHyf3cqZ/0YGlBiI3poNSobxubDC+fnttn56QBmp0eNnGXpwZ8XBeAFvX?=
 =?us-ascii?Q?SMTLdqjH0SSAt9tZMlv79RbMuiS80a5IGEfHCAzFhgxahxTrQLP4NqL1wO9P?=
 =?us-ascii?Q?yvBq1IzGkHoUvSGGAT4P883c81YRhpiQP5k3xQdB/y6VMJvSqHjrWFKq4x2f?=
 =?us-ascii?Q?UNKk+wec1VqPLgj/hQrAmQHiXw7WqE7Cf9+f7vgG8BClx+7kWmX/c310EFMY?=
 =?us-ascii?Q?pk9y6ju2Y+BBuCFVYf17o5/LnRmrzP3S/Uc5Tf35WFBt+Sz/azJpWzIGheVt?=
 =?us-ascii?Q?8fSZzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:59:52.6831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfa4834-a3bb-4bf9-c338-08de57f182e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
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

This series moves register access methods to a separate file. It adds a register access block
which consolidates the different register access methods. Any new register access interface may then
be added under this block.

Finally, it adds a callback to get SMN base of an IP in a die instance. If the callback is not
assigned as in a use case for early query of boot status, it uses deviceid to identify the
appropriate access method.

Lijo Lazar (15):
  drm/amdgpu: Move register access functions
  drm/amdgpu: Add smc method to register block
  drm/amdgpu: Add uvd indirect to register block
  drm/amdgpu: Add didt method to register block
  drm/amdgpu: Add gc cac method to register block
  drm/amdgpu: Add se cac method to register block
  drm/amdgpu: Add audio method to register block
  drm/amdgpu: Add pciep method to register block
  drm/amdgpu: Add pcie indirect to register block
  drm/amdgpu: Add pcie ext access to register block
  drm/amdgpu: Add pcie64 indirect to register block
  drm/amdgpu: Add pcie64 extended to register block
  drm/amdgpu: Move pcie lock to register block
  drm/amdgpu: Add smn callbacks to register block
  drm/amdgpu: Use get_smn_base in aqua_vanjaram

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 140 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 786 +-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 959 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    | 163 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  12 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |  21 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  52 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |  20 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  32 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  66 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  68 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  31 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  32 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  18 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  26 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |  76 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |  16 +-
 26 files changed, 1395 insertions(+), 1183 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h

-- 
2.49.0

