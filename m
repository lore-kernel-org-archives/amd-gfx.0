Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BBC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2423C10E2F1;
	Thu,  8 May 2025 05:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ihCunvhs";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFE410E2F1
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY8M1I0/ON7IHfNy40zEymo5bVVBtZ2Lm+c6pSi6Z5KqV9c/AJN3HOI/Nf8HcqoXXYHwcRiYLYns9ok6pJdjabboKcz2zldG1YeA2V5w+1++0uwhD7l2p7A6TW4H9LgYbcpJTaGGzlDCEwKpu1ILtgA7JR16V6Y4aUGh7CY2ciNQ4yY3pgsE2R3WdenRNSMbr3rgXUm+j4fznDnY4GBNK5MvRoAvtn2i1Wg8/Izro/1YX/VY5UwK6+cplZ6Opm3Z9ff3OIvKspPuMQxxLS9E5nDzvHELv4DHkcPHTX4iB6R41bT3aFIdr+TnaEn/Qvs4+YtUcX26Mfi84dSHgW+Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdSBh7NPrhtjtxWY58ZxFC+I7heM0aCk0b9gd5rqC8U=;
 b=XRYcdt2plqCUJ9fszdc8R9qvSNY7RLOP/HPqK53Xfn2erlciWR6nUeCK7YxDCDtnccu6Wkmys2KJmijw9SJAAJJDyXL5UJ90wb+XgEZdu5IZC62nKm28bt/cBJemQNiXj5zFJ0kv42GehXwgsHxHwG28voaUJ3iHQD8P8nt7yEyR/hILZ0oRnKQFehTGelXJazhNA/N3Ae3MDwuKsXEkRAE6cIfoYKxiFBbaV69L+ui06zf+pju1MLxqufj31C7uggyWTmDFE2bARr5mCBH2cpY/yaqzg2PTCttllQNCMjaoKhsvMtgOsjmDK88ZCacRHCuC7P6O8n7kQmEujoqeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdSBh7NPrhtjtxWY58ZxFC+I7heM0aCk0b9gd5rqC8U=;
 b=ihCunvhsdVY7bVMLuVfs4VRa3YDUET/LV+6TG+sn6C/l+R624AAnmGqbNeA8yu+UiaLgn+y9sQBAD2Zwf1By4Qr5QKv1GSN6ZhzWS8f6HxZPbHMEJOt0cZKjF2bbgfGCQm6TsRRkT3DY5pUKgF01u3+gNMrOYtPF0s/ySmZW6EE=
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 05:10:01 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::36) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 05:10:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:10:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:09:59 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:09:57 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v4 0/7] enable switching to new gpu index for hibernate on
 SRIOV.
Date: Thu, 8 May 2025 13:09:19 +0800
Message-ID: <20250508050926.228674-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b69207-2823-4ff2-e890-08dd8dee954e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?px6x1GsQL0QByLvETovTPC6zF0BAq2aC3QxNh3LvDjUCaBsAGXMVsaZ1ZAWj?=
 =?us-ascii?Q?qK08gu6ekiwOrGJOyl+DBhs7H3F42cADbvyx2OY9ZgHT4Wmd91zZoM0b/0t0?=
 =?us-ascii?Q?CRqBRkwpOnKu7X90XP6YTtrSAQkPVvNhTMYxUx22+XZSjNhgpUCEYsuvn3TK?=
 =?us-ascii?Q?Vy8d8LBoIl5E1HPrTqIz/h6QDhn5pw5BkouX/aDj8EFLEwNbo5BMyKtypGlc?=
 =?us-ascii?Q?o1BjLwrYv7QZ23oI/E3ixds7cxTReH97/bXRErQBfKK0s8pRpeyiaMI9FBCk?=
 =?us-ascii?Q?k3XQ1hmabCOURPnrPpqFRa4aYa+coQqmIrB7oIJLvst3BPs8p39gT0socSzi?=
 =?us-ascii?Q?4eplFC+Qvo7/ybWPM4+GXhqnyCUDCUGdvsYT/bsxZK/Mkq9PtogzDqpUpxhr?=
 =?us-ascii?Q?uDBXz5iBUpTCOKya6D5Y7yUICHLezAdUPD713AWRRGt2JlwmniriWEqMB61c?=
 =?us-ascii?Q?O8+J7sj1F6zgX+UuzqLb1jyI+KWJ5jAhzc1lEYedcG9DPEtWeiA13gi/Fhny?=
 =?us-ascii?Q?JQ0afF4I/X9OqpteAWy4SWQOePx3ota1dAJPCW+OmuTMhseAy4aen0OnVq2H?=
 =?us-ascii?Q?wonkswxAy5NmQuQnZxXDUq+0BIrEOJ1B73AW4+6zyOYTUP5zLezcGkAlLCBn?=
 =?us-ascii?Q?uLJmqfoM+zTVx1sypoT/xHXQO3nPcOrkIKMKkLXtwBMOC+bJWnnLrrW9c7BB?=
 =?us-ascii?Q?lg6/dalKcFy+enPGkFrCd/dDSi6/PUWpXwD8s0GjBjUfejH9pehEl9YNRevg?=
 =?us-ascii?Q?z4LxizxVBovx7b/veQCF8mjIc9uSQO5qI+2tvp4PUGCyITJIx8VV1Bo9ENjd?=
 =?us-ascii?Q?LjlpDiFD2DCtD3Qw/eQeDcKzLo40Rx5rRwU88few92wXgPqO9QicRHv/Agwt?=
 =?us-ascii?Q?b+ka/h4plq7w8yD4f3IlFgLpak4SVQdWAHfFmEtZqsZthv08ZB+6ThdDLygD?=
 =?us-ascii?Q?2c/pb3iOzWXSykeAhpA2unoMlDgaAuN4mHDPlxkOq13OWm4HUEXd05kzgnRl?=
 =?us-ascii?Q?PmHicvwHqCE1HD0gRBMgh4vCuLXbKB2bZxHi+iZ5iSKq4+9g/ufcFfadtq07?=
 =?us-ascii?Q?LcRSqgYggFInRDxOnfRkcT8BAYaZGWT5BDcidzwYUSzNS5SVW58tRQeN3eKh?=
 =?us-ascii?Q?RqKlFvBv+BuWLDeTc5CI298jB9L8QyH0EaUNi1ZNV59ljmPTe9wQ+idoxjyK?=
 =?us-ascii?Q?JU2SlNSoaoDJLGgaaKQRyuRttYHTKcz46rP/dMsaL8dgiDSaERIDQh+GrL2+?=
 =?us-ascii?Q?CiXMtvxv3e+VlRB/suScTFIiTT4CoEIOSL6HckYL3DnliLcqUUYJvyso4yMp?=
 =?us-ascii?Q?04wkk+CK6vZnryBx5VyD06u0LvVxUFzt8qdNvFF9waARumfzyFoay0UezhJG?=
 =?us-ascii?Q?5yPM4GlC+BPxPBH4auF9Pjp/61Siu41wyzcDzz8mMMIGm82MNyCVAajE/UqB?=
 =?us-ascii?Q?emmiuNwlGknqDRzm2BziYjZ1uG873QJIIPLjdafySzKxDmbQpso0YNtx76gR?=
 =?us-ascii?Q?rncnZJDRioPBivZ2bPC+2lpayHmv+VDMTiLL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:10:00.1722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b69207-2823-4ff2-e890-08dd8dee954e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

On SRIOV and VM environment, customer may need to switch to new vGPU indexes
after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` will 
change in this case, the FB aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all
over the KMD codebase, updating each of them is error-prone and not acceptable. 

The solution is to use pdb0 page table to cover both vram and gart memory and
use pdb0 virtual gpu address instead. When gpu indexes change, the virtual gpu 
address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB aperture
gpu address is used instead. They need to be updated when resume with changed vGPUs.

v4: 
- remove gmc_v9_0_mc_init() call and `refresh` update. 
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.

Samuel Zhang (7):
  drm/amdgpu: update XGMI info on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: remove cached gpu addr: amdgpu_firmware.fw_buf_mc
  drm/amdgpu: remove cached gpu addr: ta_mem_context.shared_mc_addr
  drm/amdgpu: remove cached gpu addr: psp_context.tmr_mc_addr
  drm/amdgpu: remove cached gpu addr: psp_context.cmd_buf_mc_addr

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 32 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 49 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  | 12 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 19 +++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 ++++++++
 14 files changed, 153 insertions(+), 38 deletions(-)

-- 
2.43.5

