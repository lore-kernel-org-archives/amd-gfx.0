Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2869AEF06E1
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9637910E02B;
	Sun,  8 Feb 2026 16:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Kh8Z1AZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504F910E02B
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIYaWiJ5ye8DSin1QLBEJUetZeQX9LxZFmr1kpRDnDPQmOxxlaSa68qW+xAKkPCGpEy2PU6NfI0nPckhNoEM5hfwZrjk37rUCZJXLPXGNEL8XfuW45HBXD6rK8uCy5Gd2PSyk00Jys2RUtqhkqLfeaRJr5oNRunz3q4BsnIhTxB7XF9zZPF0AYkV6aWx5eiFZCf2FrQMPUynuJCPueaQJpmtc+LlXHfpRZGaTVfycCh03Q1alqEeuds3U7VcgDvDN5vhBYePvnWHjrMa5Iw34RD61zTPQXacxwmUQ48YHoX5iafNM2Tc7TiZ5PaEtczSUA3v9ucj9QYCesY/o6L6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HPRxOX8zUu17JQXGev0sZ32qN2PEX5r2W52g2iTdUU=;
 b=q1VFM9JCOlDpJOorsNkZYfZTpaKAIXy/SydfkTs3FJwOYKyZ06CkLkKUtTvVgkp4de8sJgoOqmZauLaaxcn6+cZMwW05gAx7nrQKPfCz25RRMJEivkUTLrLpt/fHVwZVHH4eBZcZ8qIuJJ96BnABm9fHdsQDF9LgogDyHfQdjx+LrlaesY5/kAFgumqhW1icMqRY8syLsDT+stz0VIa//YccFN+UiBhC5v7EDj2rv5MDmtSnUH3SaRFeYfcTO2jnykYtrnPATRmXpGBY6DVGxAIJ0Z43jfhwBBrHVcjQxXJ3nUt89fyL8+k44mVlCuFB/u4qvAn/gow5nhW92dLS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HPRxOX8zUu17JQXGev0sZ32qN2PEX5r2W52g2iTdUU=;
 b=2Kh8Z1AZOBvmoY9C60MaCC0v9EVRuqw+QMXKuji0ZM95VozU7nwVBf7yqrsbwdjBHidlHsIhjJILT7dWog5Y8Wz1KXZw9BobLMKlF2FubxSXwOHUaTu9BymN8/FBu8RLIqP2jBRZFcCpQ9aVhu+8sHaOxEXpit6bATDGxWrCBXk=
Received: from SJ0PR05CA0170.namprd05.prod.outlook.com (2603:10b6:a03:339::25)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:43:37 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::6e) by SJ0PR05CA0170.outlook.office365.com
 (2603:10b6:a03:339::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Sun,
 8 Feb 2026 16:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:35 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:31 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 00/13] drm/amdgpu: Add Peak Tops Limiter (PTL)
Date: Mon, 9 Feb 2026 00:41:59 +0800
Message-ID: <cover.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcb2673-9e8c-47ec-d0fc-08de673133ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5YLxP0brcTjrYXanB4RWQA1/Xl3Y9xiSbtumZu5vKgcqhIR12BzeenS54vps?=
 =?us-ascii?Q?LuDQa3a3BvTaGO9hwwgTTtpANsTMtfZO/L/4lu47v+woHcZcqb6kZGtVh42W?=
 =?us-ascii?Q?tHVGdyMETf+nk3JPhqL6XZ2HaCHzTu2ZbYSdmbpPsTBTikNe4vOS9TW3LqKU?=
 =?us-ascii?Q?cdzdRzzo3gw8iP3TRjJ5BXSuywZa5AeRxKrkAF/rq1vPKlBWl8c7Lh7QLSSu?=
 =?us-ascii?Q?9OqAfHtH6goNqhJgCoF5JLLu9xZD2TPFw89GIspE1NiCqn00hWmOGHigwpoy?=
 =?us-ascii?Q?OAdJsoPJ/Ib3zWIlVuN0daByeAu65eAjDpGSLD5K2STh3ios7I5wGedIUbEd?=
 =?us-ascii?Q?zIXYMljo7qkJJickcsfs2FMb/mPWAWPTrHG8m90vINre/8sKjG0+pI/oyaZt?=
 =?us-ascii?Q?c2zkNI9Xkeg3zOPgJtlsMQ+36V8QpnT8uXK09GyyjYh9NHkqs2u2IAQqXFVx?=
 =?us-ascii?Q?LAn913h7cQ9yxHhx7HFdbRJY6vkVpizlWEddtru9iSLsadwAqbEcwZp2qmOm?=
 =?us-ascii?Q?gffWeyTOkKWws5kQNyPztHTr9ImfPJqg17Bkv/m5IbtLo4xPuMli8J5/BQ+c?=
 =?us-ascii?Q?5eTCdisn8I51NP70GHMaZldeG7TRyiEyNX4o2dKh7uu6pvJZQN+Ol9Uolf2+?=
 =?us-ascii?Q?51xTI16F1xCeQS+j+b56Z9two0S2UATePRoBxeuRuUC1CufMBrs6uKwxPxYr?=
 =?us-ascii?Q?7FMk+fW0HdIjgY46X0XrotHP8ir9qCVC+OxUcu7+g9riC59cQy+HIBiiB8Mj?=
 =?us-ascii?Q?29nIr+MHm2VBsV+eYVgy+H9uOCK8m3BEEJaJ2NF7ZlHk9ai9nhZtxDXVU0Us?=
 =?us-ascii?Q?KLIKFJzzzVjd1T3jaOeHSPFqgwdhcXEc6xyiDq2Yf111b9Bn4JP3CDwXthyu?=
 =?us-ascii?Q?BJDeXcXKG77yzKsBACr9KQeCoBxnasF1DnQhlzNUid5Yn+n405bSiEMSX7xH?=
 =?us-ascii?Q?EMCXc35OC4N7Vhe2FigyfZSJOJuNo0kQIU6JdkxCYnxw8oVjXShiN6T0PwDq?=
 =?us-ascii?Q?m+6trzj1+w92BTfg+sC6Kse26eOiniHWu3yVYLaALoOhXuCHqW7HdVZ6VtNT?=
 =?us-ascii?Q?DBDt05DoihGLfZd5VnVj9vgLB32OxSjhGcmSnKQM82dn7//BCeOfg+HOmCSQ?=
 =?us-ascii?Q?ZA8hY0kHP/hda7jLfFPh3P6uWYUQC2lXrj1LUcIg5x3oyeYmEN4s2mcFG9Yg?=
 =?us-ascii?Q?+GaBJ0HqZcMmiDflqDAFTZ6dEXWL7jCtetZEmBM5HJZtIBsZGarhxlClfXr0?=
 =?us-ascii?Q?sp0Hq34xWkNuMjzhL4Hn5ljyhJ76Uz2GUCOH2DpYTNF47cYhGlb4CB3PehDs?=
 =?us-ascii?Q?zBn2axP5Ef8ETlq764Lloafrz2y1rd0n9NhRkr3IlNuaAnJg/Og15AODUXMV?=
 =?us-ascii?Q?pVGPn3ZI0LoT+e+BWajRWyEUOra3Kk1wxWNeq7VNvGFYfIl3h/Yg0axbwbC7?=
 =?us-ascii?Q?J22cYENWiBVOlk8J7sG7Gf83D6qIEUAdDukZrA9iHVMrDpkCUWIVUIH2agp9?=
 =?us-ascii?Q?N3axrZEAtcXDZhrrUkorGhp3cxXgMcA/2pSwEt+Yapt44mpbICfUKu+6IjeQ?=
 =?us-ascii?Q?vCMRXNbDR9ey+zbw7tCADypA6ZMghKyp+/go+iSkauYV/8pxfVzykFJeayHs?=
 =?us-ascii?Q?e9feGiISW8arSEcvx76MYrKl1uSs2c+vI+t5D59Xxxp0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Jp+jZwF9Ha5HO47Y8lDAuntbRuzo0FoLW08aiPNnVH3IXnkqiNb600DRcq0wvPXCWQbdpm4yde2rND1Fa/39Etys+pPB+xdOfa0TS/PFWtaHMEBMQ28MRdX5kLba7BdzKHRxMwOFb3J9vQaq1QwlUY53tIp9nfMlMda5bQOyIiJlmLsCm5Zqb099ky+c+qFv2lGvlC6AjxKI8jARi5zC17YekDvuatCnIJeDTqBMBzcnaWMxjN1mh0PY+IpHdraLqwL6GEZLitF6jGS5mKqWW0KHkY39Klg20It7iYSTLUzIQKgTyHYCm5x9KYv3/ZEVa86rYqIeSpVLm0dlKoLUyusw5/fjbUXYHh18SeUIemoYsUJ5yhhpmYBR3KQ4OugJxZUP2gYZbSe2ImQYBz8gO0FtvQBUJ3HP1+jnctsGdjv4S7GgpwKepaiI1yEd1h3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:35.4082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb2673-9e8c-47ec-d0fc-08de673133ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

This series adds support for Peak Tops Limiter (PTL) on AMD GFX 9.4.4
GPUs. PTL is a hardware feature that limits peak
computational throughput to stay within power and thermal constraints.

v1->v2:
 - Rework patch set based on review feedback (Alex)
    - Consolidate PTL structure and interface definitions
    - Drop patches that have been merged into earlier patches
  - Add explicit PSP response status check in psp_ptl_invoke()
  - Add GFX idle wait before PTL state transition to prevent CP hang
  - Unify refcount logic for PTL disable/enable
  - Rework profiler IOCTL interface based on review feedback (James)

Benjamin Welton (1):
  Add kfd_ioctl_profiler to contain profiler kernel driver changes

Perry Yuan (12):
  drm/amdgpu: add new performance monitor PSP interfaces
  drm/amdgpu: add psp interfaces for peak tops limiter driver
  drm/amdgpu: add PTL enable/query gfx control support for GC 9.4.4
  drm/amdkfd: add kgd control interface for ptl
  Documentation/amdgpu: Add documentation for Peak Tops Limiter (PTL)
    sysfs interface
  drm/amdgpu: add sysfs for Peak Tops Limiter (PTL)
  drm/amdkfd: Add PTL control IOCTL Option and unify refcount logic
  drm/amdkfd: suspend scheduler during PTL re-enabling
  drm/amdgpu: Track PTL disable requests by source
  drm/amdgpu: add amdgpu.ptl module parameter for PTL control
  drm/amdgpu: add new data types F8 and Vector for PTL
  drm/amdgpu: Wait for GFX idle before PTL state transition

 Documentation/gpu/amdgpu/index.rst            |   1 +
 Documentation/gpu/amdgpu/ptl.rst              |  94 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 349 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  27 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  62 ++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  17 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 219 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  25 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  16 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  14 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |   8 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  15 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  11 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  16 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  15 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h      |  61 +++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   6 +
 include/uapi/linux/kfd_ioctl.h                |  36 ++
 25 files changed, 1020 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/ptl.rst
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_ptl.h

-- 
2.34.1

