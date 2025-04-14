Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FDC369B5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B81AD10E564;
	Mon, 14 Apr 2025 10:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7vFwfmF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619AA10E562
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkzOqxAeV/HJ5VQWTpVDZ8RhOjXeDSi8Nxg2Ni5Efao2obI95pdhF9hITtiKyVj+4daOXd6GiV+4BvUQeU8gc4P6NnGEwyh99qCRlDfsHASioWLts9sfcWt6P35Sz1rVBu+khlZaCPblSOGieMNTj1pXJ8JdjT8G3Xr05kjgjD7eMyvL4F/d6wQXWD420Y0QOj5LlG/sIZjtGOKWLDMMr7cr29nVGY3dw9R2oIyy7XKr8i4tnDCnFCKD3EQS+YApLwZWb9e8rabkBdlIlFsZmsyY0+PfXamNGKXpcTC8V4DW7x/zzoS8a8sDLzxqfNGDHvkGG36vRfiHpjJlutjFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s54HhNrdneSd1RrF3bLTz5Wi0mzTupPLOEBFOwT1H+w=;
 b=o9DLGZL0FjTmeKEygpC93xXanH0ADSS7Mjn0fpV0l0EUeaL7BBF/IfdhAVEIgBittrzfuCEKryp4vYn3KZGGN3XA8LRnaYitsrj6QUQyyHshCtU4gEvz/uqTKjq1mqolm2b0e3vUJ9ZpEcT5k++xwmIxzQBTFGUTKnLUclf1bow0ifKJQFRo0LoSDTbymBAdEcWxlMwX9fC9U42iQt9Lm9EZFnGBtl9arQlgIw3qLGoWBV0OMaTpUaiYBbaN0WRuMvaaMykhLG+FuBvWuLh5BLEeRCwARbjPZLEJDgBJq0/TDtv7LZAhNhaHCxBY2uX0KXVeTlBhMWGuIbwCoNFI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s54HhNrdneSd1RrF3bLTz5Wi0mzTupPLOEBFOwT1H+w=;
 b=z7vFwfmFZpT/Nrdb1+Nt9mYi7C7/lz0nrRJQWOGCCVOwzgHHLLZHBGPdfYHWgJlt2UN4fsr4bnog2hVnJUfCUDLm5ldjqLRWQBpiNLThrpd0tFxJ4wI0ynmhMPeVfj3wKQz/R4FBMXMeND8yOH0yLp2ym6zxuLM7Pnm+jbIv8v0=
Received: from SN6PR04CA0084.namprd04.prod.outlook.com (2603:10b6:805:f2::25)
 by SA1PR12MB7151.namprd12.prod.outlook.com (2603:10b6:806:2b1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 14 Apr
 2025 10:47:35 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::4a) by SN6PR04CA0084.outlook.office365.com
 (2603:10b6:805:f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Mon,
 14 Apr 2025 10:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:47:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:47:34 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:47:32 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>
Subject: [PATCH 0/6] enable switching to new gpu index for hibernate on SRIOV.
Date: Mon, 14 Apr 2025 18:46:49 +0800
Message-ID: <20250414104655.336497-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SA1PR12MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcaac17-1540-4404-3353-08dd7b41c436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oNs//l3ncPnu3pzeTPRiQsjRZCuQBKU/87rFmYxDp+n7T1NDhIYTECdySsqR?=
 =?us-ascii?Q?EzlSf5KDRtHCkqu3wvIllVeKECke61ZNcIEyY/4sL7cm6t8PUBLcOq9/GE7Z?=
 =?us-ascii?Q?vnhlhlzTrFato6w3kDWNWpYYIcHioprWzYw1amiWRUXx18C6QYwBIAB3qqek?=
 =?us-ascii?Q?1LXiZvrE9hKHiHHwOvOIdeT6ymdmnAy0oTV9rI1mGv0HdF0GvYwxuV5FPhuJ?=
 =?us-ascii?Q?OEEKjNS0OBNatNPotLwfTWGZgDMM527WNkC4PPmcqV+81OWWmUB6lEnAPgcg?=
 =?us-ascii?Q?miagJDXlS6HgUnwpFY1NaNgSq7GhpLihzYa6Tlt0JzLFouRwiq56B/VSWh1z?=
 =?us-ascii?Q?YRZxhaf+mqWeTZxymch9+NcZG64iPK0ScijGTnXPdIEx02EcGSurKZzluwFC?=
 =?us-ascii?Q?k8+oUqB9EZt5ZJWPui3og7CLHlxBDaLdFEaOZl2KJgekSM6nC6h+BB1oQmm4?=
 =?us-ascii?Q?fB/ILj1RNSgZ/XaBOayjD0royge+ysC7img5O++INX0yop78R5uSDupJMGh9?=
 =?us-ascii?Q?Tf69QB156iuUObr+fkvRpFd54HlSNEBx0li0T9cDkLLyw08cDx3MPF0hrPAP?=
 =?us-ascii?Q?HVMEAHDHgdgw7N44Zffm/bdXVpo/nGx3ahwzH+EVZixLC0FxyZHV7Tkl4hMK?=
 =?us-ascii?Q?0UIjADbcwGC08LSO1OI4QRzAplMQFJMt6iRJ/5W0HhokBPBYp9O2OQtD/MNm?=
 =?us-ascii?Q?7kFudistqtXB3Xu0N+6YLODCibNAikcZGz7nJzKiVhYgFT/7IHaAgfc40BpR?=
 =?us-ascii?Q?vu0Qc2cgmQwmo9cFOdXnOsHYeMZR+2f4+tS79ZRndiM0407qrV84E/IFoMrp?=
 =?us-ascii?Q?YixoWsYYi+r0HcQynxaRiBo4ybrqvzWld5Z3MwkPNWg5n/bcMthKYybt4y4X?=
 =?us-ascii?Q?X6m9DmJwZs/HFFc1AoFbG7jDqHUjv3uNCoD8QdH+XCEEEq+bEMZIHhiBen5f?=
 =?us-ascii?Q?cPTlpsppjrQof6VIsef2XEd29eAaRYw7ijCmvWX/v6st+lb3CG8CkSSkHgXA?=
 =?us-ascii?Q?n2x8pn+gYdyM3/0ZIJaun9egmM/O3SlFoS7uSOdWAXtScbDtm54tpr0Gyx4m?=
 =?us-ascii?Q?l0zy5mFRgJyWsIUhElKMYhmwQggnUtbEui9Ms2Hoj3vpdIRNQFkeJfZ8PzRt?=
 =?us-ascii?Q?hcuW5ar376wNlIQWqNtklohNjWBgoC2sQEWcW2R7mGBkcIlbX/A6R/Ye1TBp?=
 =?us-ascii?Q?ga5FncbCn+akVk21kytk4rWizq8oJIQjQywucyvTpaB71da39SC6s/gXcj6M?=
 =?us-ascii?Q?y7x5ARj5DYixofIwV1VBPq1CuW420M0MO8bUoc3TVw5JW3Q3hnrw/n8GdcVc?=
 =?us-ascii?Q?bYaLi+/07ujFeszpIIKDC+28M4vZAJuuREFoY0ZdDIni88oFI5O0poEXCkXm?=
 =?us-ascii?Q?zE3lN7yLy14EWuJZLZqq9WN43qes+7lYFxfYNATFq8Ucx932xFQ+faTNg5km?=
 =?us-ascii?Q?uwCUJVbCvyaTXvO6O4cRGboW5cvjZkaUegSf0ygZHK/izavbGmp2fu8GJJRj?=
 =?us-ascii?Q?9fH2dL80l2Xeow+jL4QnwoWK0MwHpu4KT5c+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:47:35.0674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcaac17-1540-4404-3353-08dd7b41c436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7151
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
change in this case, the VRAM aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all
over the KMD codebase, updating each of them is error-prone and not acceptable. 

The solution is to use pdb0 page table to cover both vram and gart memory and
use pdb0 virtual gpu address instead. When gpu indexes change, the virtual gpu 
address won't change.

For psp and smu, pdb0's gpu address does not work, so the original gpu address
is used instead. They need to be updated when resume with changed vGPUs.

The last 2 patches fix the issues we hit when testing this feature.

Samuel Zhang (6):
  drm/amdgpu: update XGMI physical node id and GMC configs on resume
  drm/amdgpu: update cached GPU addresses for PSP and ucode
  drm/amdgpu: update cached GPU addresses for SMU
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix sdma ring test fail when resume from hibernation
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 45 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  7 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 24 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 39 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     | 18 ++++++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 30 +++++++++++++++
 14 files changed, 199 insertions(+), 36 deletions(-)

-- 
2.43.5

