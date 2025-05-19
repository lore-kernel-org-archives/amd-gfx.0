Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7430C2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 08:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8419110E20B;
	Mon, 19 May 2025 08:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KFytf+yJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB7210E20B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 08:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9YQ5o6wgEVDNrIirCQnxVSwTx22M77Q7XGpTFSXU8pBbuGcAqRCIofep5celCZToXHIkCPD2ypACWxYFVR8Us13RTo0UFyyE8Qvew0Nw2fEiriY40wrcRSpSHbxrEJv3vryUlzdqCrlirpUKAaQVPZ44sc71woDE1ZISVPue+ahAv6BcAwQX5plpVF7IliqdcPzwaAvRIe7516AwmHJk5VtrhfuEI90PEy8AJl18ptfwDQYnfKpoGaN8jrgD7J52EPXHeMKrc4Tatdt2USGOphcP5G0e7XCf3xl0HH+DZi7NlAyBOF0QSHf7QPRaypMwCaj12GNlX2wNtplvcLIsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbHhMCok6IhRhElJPRC80AOWmz0umJcdN6VOr4SEhX8=;
 b=RZw1NWxV/Iw17/g77S0Yf4Yi4B7TLfRXscsS0jpEP6zuw/RYJ5M2dYnho5E6NUR7Vh+YSemENkWDaT1NFLMnCsL/LMeDTHmBDSJtuePNkD3R+p2azK9bRXo2FsDYIdpuh7Pa7tAH3Ruuy3LRIgursVEqJHXfM5IuCKWBy89jOnhvoUq8qY+wvCUnYMvijm6qJGKByoKQg539GkteA6T/i7EBrLZ2oyxBeMmyVROI9unEXauxO72Bod1OSmCH/zIW+CofFFftV36scRtZlR2BfU1fYcWMqElAecdhd/0AURDlmtHXccwMf3QSUzyoWtjFASHpec8BLWBftVQdEWIu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbHhMCok6IhRhElJPRC80AOWmz0umJcdN6VOr4SEhX8=;
 b=KFytf+yJmGlJ74w/Yde9YUKwK3cRqh/okAxwHkvPPQJViJKCS97cb1XOgPp4FdaNhU4kd6MH+FuA7qUFSRAvfYH2rNMKFlqutFUhJ87z+XXVbLMbWqXV5ksWxEQdW+ZFNa/EpQFRv7GsB+qt/4tgfF31pHTd0/MzE3HCs5G4QhY=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 08:21:29 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::5f) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Mon,
 19 May 2025 08:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 08:21:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 03:21:27 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 03:21:25 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH v6 0/4] enable xgmi node migration support for hibernate on
 SRIOV.
Date: Mon, 19 May 2025 16:20:34 +0800
Message-ID: <20250519082038.21459-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: f84d6866-9f1a-415d-e1bc-08dd96ae2760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HWav+wYUwfM5SgLs5GeBew7Vm2mjOPcnTqiC/nmVgzBu+Irr2v+RUHhd4B6i?=
 =?us-ascii?Q?VHkuHyS0M26AsXADmy12mCouFVNcgbuMsjSnYLVIMoqwHIMVcsEwL3DUIViJ?=
 =?us-ascii?Q?O9Py3C17Lj+GuXtMT2nmULnBMwPyavyztT8Ht1/o8KZZHzeobWq3H4hkCyBf?=
 =?us-ascii?Q?ymh/ncbdssXZ3fcv301X6nfTfL3jYatTXiabVOwO+lJuFogZlmIZdf8YDc7r?=
 =?us-ascii?Q?KD13VEqjTn/joJZEtClrcOyFrS6bM4Wi8sEbvSrbzmiZ+4+4UP2k33QEPdQi?=
 =?us-ascii?Q?fUIEaUhD98jeLWaLDQhhSn0ntJTd/f5aZD6qZX0AqhcZMqnV9mkp14GYlC57?=
 =?us-ascii?Q?nngKgVOZR2WNdn4cfzQnGVUIcXOObjRmD/gZ286nXq2Fn4X/dnBjoytJQoys?=
 =?us-ascii?Q?X+7Zp8gayga30RNnjd9sp14w3apfZuUSNSvMT60/pw6HPvDtGDatRn1g8veU?=
 =?us-ascii?Q?X/8xPdMZIlzHQdKKTKyLJfbEFcyij/JEbGhHBnLqjqS6/K3VLIn7oHi2qI5k?=
 =?us-ascii?Q?RTIpU14k+/kjcVsV4E8Zu0aD4xC09+Nwst66VYok3c3IwlM2qknAIZUUoIE4?=
 =?us-ascii?Q?IzyF4UCUoCXPY2MyYFBuEX1Q2h38ECG2/QaBwnbWfI/M3T94G7OW5aTtMDzH?=
 =?us-ascii?Q?v2TlPPad/ifE3QHulJHrQ9Jf9G4NcR1mlfW2KTiYnPkwPmxWDB4K+kWdrGLP?=
 =?us-ascii?Q?Ui7t3qr40XV2oHt/FLyXFzwM9JgZOJmD/jI+qBymgrPVzBuBY6erRn5ypH87?=
 =?us-ascii?Q?EIgaGEuEt+fVPftpeHmNHKUtQ1bdGVinHSYjx3Xuisin3a/xczu0o8rTRAjq?=
 =?us-ascii?Q?fHFJUr+YGKiRco9E46HFfNNKddXl97fUEL/X07OjUixn5Aa/FI9Wbwrxqz/p?=
 =?us-ascii?Q?ETpydZr3vn6cHSa4oGcxa25TOQTSx32rEIgDhIVXZzUEJORZuXKIj8M5J10m?=
 =?us-ascii?Q?g+/yDLafphIFa57cX1rSLZSls5Lgn2qk38TsUndJ9DsWbLzDfiwot9dKGcJh?=
 =?us-ascii?Q?lZsYdYbvgjdyobqdvSZYsEXAM6696tnc5I+cEUjiJqf0N13PiXxzywrSPgtE?=
 =?us-ascii?Q?pVaw7UlWS/LtAESK0BhS7DhIcfHnxEhLOkryy7FbLutRzFn97ZDQKDz+UISN?=
 =?us-ascii?Q?wAUz9S0M7EW2Za1a4uV+AbXoRO8IVdfq1N96GIIrQgcJGZ4NCR1kD0hP6yzh?=
 =?us-ascii?Q?FEo0B8kRhAHgCW7y3Lz5Uk439QDBBdbUurgiBfi7HpI5RjAVSrTpavFsr+1N?=
 =?us-ascii?Q?0zAGGjGE3Qkr4SwVQ6q/gLhvenG2cx79+AqaD9wpcUfeTgS/t6UxwgQQLY6W?=
 =?us-ascii?Q?Gc06v5a4wR7Q0VpOH7XIOm9QY/z8WmCreB24MFJ7WXH8e+BowJUxO2HbN24M?=
 =?us-ascii?Q?taxtJWhftjou5+7eLblHBTpQFXmeYmB/A21gC7eGPw9iGGjLsmCxVgvX1D6j?=
 =?us-ascii?Q?MpEGTpwEEz8PKOG7mqcdDSgQFeMu5YtegbiAEdeUaN3hkIl0MMbMV0QTCg6b?=
 =?us-ascii?Q?7RGZ0IDzCix6e6qDdCsybGU+TnTIHqDIb3+X?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:21:28.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84d6866-9f1a-415d-e1bc-08dd96ae2760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

On SRIOV and VM environment, customer may need to switch to new vGPU indexes after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` will change in this case, the FB aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all over the KMD codebase, updating each of them is error-prone and not acceptable.

The solution is to use pdb0 page table to cover both vram and gart memory and use pdb0 virtual gpu address instead. When gpu indexes change, the virtual gpu address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB aperture gpu address is used instead. They need to be updated when resume with changed vGPUs.

v2:
- remove physical_node_id_changed
- set vram_start to 0 to switch cached gpu addr to gart aperture
- cleanup pdb0 patch
v3:
- remove gmc_v9_0_init_sw_mem_ranges() call
- remove vram_offset memeber
- add 4 refactoring patch to remove cached gpu addr
- cleanup pdb0 patch
v4:
- remove gmc_v9_0_mc_init() call and `refresh` update.
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.
v5:
- add amdgpu_virt_xgmi_migrate_enabled() check
- move vram_base_offset update to pdb0 patch
- remove 4 refactoring patches to remove cached gpu addr
- add patch to fix IH not working issue when resume with new VF
v6:
- rename amdgpu_device_update_xgmi_info() to amdgpu_virt_resume()
- merge xgmi node and vram_base_offset update, IH fix into amdgpu_virt_resume()
- remove 2 unnecessary gpu addr update changes

Samuel Zhang (4):
  drm/amdgpu: update xgmi info and vram_base_offset on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 35 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 32 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 +++++++++++
 14 files changed, 146 insertions(+), 15 deletions(-)

-- 
2.43.5

