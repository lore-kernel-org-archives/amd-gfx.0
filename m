Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D975C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A77C410E2CE;
	Mon, 12 May 2025 06:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k3Z61nca";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD0510E2CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef9lx7G3gjDgNGrE7CQbZ8b51NsGYRZd2JH+0kVbZjh5OhHOcSKTPwpEcBJ8/Y3UUeCiKN1Hw2eun5PwguektV99QTX7Qw6xNdsRnVED87mbVyRsvb99CGz5B5c7ruEsnaYP4h/S61PQgZX7u2oJBJI3+T8g96NPbhjkSonfp+35Ni0oI11RaxDjdilxkrWbYPYljGNEDW2M79JT/RVocjQy7ZNStOB73Rsul1w0QHgiPggkYd5kHfXUGa+McUPoelcmGgNuT8oBrrz1W986rnFm0HqItNffGO4IjJw5YTrI8rvqZM7YEtl1jkwfX5tHEnf2yCQ24cnLtQy5hq6y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Heqr16s4tVvQGvZqVdJZ66E6OpX0ObDDLDkxYx6nNUI=;
 b=bc20d1CkOyAkOIF6gxhbeNRlR17fln/jcr80roXtFlh+Tm6TMlmkAfdQIzInehigzDOu11szKJ1Wp2BwnNI/qJc2KPSMjNK301qB/i5x1CRpoR8lRbEzCh0vAAeCWKB6zZA/CCy7NlIe+TyJWsF7xziuSrJrmDMRpnJJb4e9O5VkSnBnU/eYfaVeRoMv4p12799otzWIZ+tNsLmpufVn1xQ6uutX2s+TNGXQqtfW1cjmh97RxAZJVaxRdRkCKgCq/Pfslp+91FA+8Ut0LFbERq2Hpaq1DcQu3R6Oiqjm7x+pdGVjSMvWo2T0JfxPfwK9legd+2phgcS7TxH6Y01u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heqr16s4tVvQGvZqVdJZ66E6OpX0ObDDLDkxYx6nNUI=;
 b=k3Z61ncaIeiSTlEk3dHDlJr3oGyBNZoq8f7iRF3oHzxT5lEmBVA/PPYTrnfqLImMj9pLdzzvndaRHmmmvQ1jszjrhBSCAX+yNvZicHbQiE9P7v3iwkJ1o6+JAGcohRiy0zU8JJuEYSjEhdwQNqTIy5heAbmBL/O++1Fe5K72ZYU=
Received: from CH0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:610:75::12)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:42:11 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::f4) by CH0PR04CA0097.outlook.office365.com
 (2603:10b6:610:75::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Mon,
 12 May 2025 06:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:42:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:42:10 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 01:42:08 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v5 0/4] enable xgmi node migration support for hibernate on
 SRIOV.
Date: Mon, 12 May 2025 14:41:37 +0800
Message-ID: <20250512064141.387079-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b91fd-808c-4ab5-de07-08dd91201fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?13UxaZWngn1q1qp1jeQyOx8gr8L5oU1npfclHWrewKVRitRRhUDG2NGJeulC?=
 =?us-ascii?Q?+t3FPuCVWAEBl9l70avfRqh3Q7IN+Vsm/w1h5VfO5izhzcq4UNBw0jc5bGPP?=
 =?us-ascii?Q?UkodX7sdavjukfZXMnbOKNYktnXhkak+XJDCwGNwqSxgS5cvYqlWCSoeEJ3y?=
 =?us-ascii?Q?8enfqw10LI5QDo/DQ73ts2RVqHR018AHn7dS1Z6vUyXydxDL+kYQL5LXmFEh?=
 =?us-ascii?Q?w1ZEerM3B/IiHbg6YpLjmHDUMkkdwvOT17avWcTukwj5qticy0UVfGXk1seb?=
 =?us-ascii?Q?//8wyoxgrf/h8Tb/o6y5cTuWCTnpjm4klrLJlQ5F/zYPQ1rZzqcyvahENkAp?=
 =?us-ascii?Q?J+wIouEVLQsGRYuxpgX12tGstjEbSrxABUBCzw//wLTggvSDBpumtoc2JLDp?=
 =?us-ascii?Q?aTGe600qMhj+g9jI0z8TnwDMcMDh9z0cFMC5v7zOcmU5VXBtNVxKOSjV+Ogf?=
 =?us-ascii?Q?s7xfTL1QYZLbyf6DaPwMOZ/FjwXN0RA+Bypn7ZPW367TpEQWdMhGKecRViED?=
 =?us-ascii?Q?qFF3xPh6O0T65pCqZU7feZSDfRLUVftT1vjKYsKGmsMX+KUmtawZ+IdpjCvW?=
 =?us-ascii?Q?0FEEsw72Im3oUIBUnSGAYmf+uwQV5Tlx0n4+plRlJx3VMCAQRZHhw71E2lGI?=
 =?us-ascii?Q?vbIWvIEzlt3jIxBChchg2V0cfxUWZn6FC4sZAWX/hu+6LQ+xSD6Rl3a8hgxx?=
 =?us-ascii?Q?qJ+T8GXCKP0GTEe9Uyh1QZOaJTxIBqfuE5YWTcnR2kAMwNNbYyGFeS0+wCko?=
 =?us-ascii?Q?eOFLXj1VaR3U69NEWL+ktiR9mZzBZU9vqkKN6c0va24zwaLu4Hm44mp5j7X0?=
 =?us-ascii?Q?jl4pbcgToZt/78vHjFPiHTuxBTljb8LVCQylSehKMlhBEOnhs01Lv1u7iPTA?=
 =?us-ascii?Q?CI067mwQJIc76Gt23L2kfmSbpNapXs9NCDCXppgysgbGbHLgAy9wohdhQhdp?=
 =?us-ascii?Q?iCm3iNKD5PuhGr3E/fXC+TjK3bGBK5UfOXhJV7vEvIk9EZkj0609SCWYzTOO?=
 =?us-ascii?Q?I0HLBco/aZyXCiEkNBTNg1Fc8JDxQNl+XpbxXOl+4j9RLdTUUmlWf5IlI8eq?=
 =?us-ascii?Q?6+iTlhX9ZhC64lYYOHHSVm1PZSZA1qTEsKXaEXsrnIa3dnq5mdmnW42AGw9j?=
 =?us-ascii?Q?hrAORcnzMgQGWUDISAPm3Ce/7xiNlkQgnjd2witriR1TKFxttAX/QBqjhRrg?=
 =?us-ascii?Q?I1aCcNBx9QdYEUnIh9hhEwMxj+xS5cd3+e6YFAUG05IwM+k6+6Ni8/566T0Q?=
 =?us-ascii?Q?L2TPs1oeurqS/msifk0GDA0EDUyzQQPYaSDJ5NXBdMazVdwkpaPfq0/Oo1mn?=
 =?us-ascii?Q?2gYG5+GkccnxzrJNRHK3mhABbnHBVd/kJV/FSebgjeYKlAFxqcrZmjIGQJBj?=
 =?us-ascii?Q?szyhQ9UCGEC9rhXse2pXIwJ5bk/9ZYZMLpezuufoTc6GQ1NKZMpchz0D4X9H?=
 =?us-ascii?Q?0qRUut0JlsFbRpaduX1c1vIHl9XXIWKc8K6zjxlFKqGFnocxJJ4tJKImMtU3?=
 =?us-ascii?Q?PS2ZgcHfEhMpd5poF5JLuiB2o5wz9juFwNiY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:42:11.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b91fd-808c-4ab5-de07-08dd91201fa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

Samuel Zhang (4):
  drm/amdgpu: update xgmi info on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  4 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++++
 15 files changed, 152 insertions(+), 15 deletions(-)

-- 
2.43.5

