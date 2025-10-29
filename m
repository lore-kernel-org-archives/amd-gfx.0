Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1070CCF9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365AC10E811;
	Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YaoR19O9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A8010E219
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axv4dA/Cot9Rg1RR0++Pty5uKKzPzNwS1zz8+J/cJk8rmfdxC4FJVLQh/je1LkuyYtapE5nqhDuaqneEZTQSYJkbKL+zB9ACSx2TxbKwCBTEUe2dbo2YkFj2S8W3aM0L6MoJxOCbQxqrj4BSVCw2UifQbpHW3YweKn/ceNMb0ai20/rUmUjG+4iDzqWDX7SdjtZ341UeRnFCB7MkVcXhWRNbDBKOTyBvrHS7RWDTGa5GC8gzAGoLpq867P1XjC22IJZT1lY8fyUW/OIGPukDimswBUGbE/BWPqUq0jtEw7zXkxc9VfGyVxvg9rw3MOwwRftkkkbwyQA8IABZip5F2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGHiAHbrXWt6TT0A5AG6/4Djj4OnLidwpNjI8qpHXD8=;
 b=I0MBmOzGuQSK0dnUwThGFZaBPvWQqU6koeZ1P2gaahzQ9MZu8vEO4yQDEGIKIAERpE1ZE2DojEPNJ5WM2qZU/6YzIKCscVl0voOwcE8W2yYizDIEfyLxyen+vCuBE+TQu0u8Vb0A+3AU9Y3qA6AvWvZ3XUmoMV58c2h+PZLxLDYOmzemmFPkOMaUiCX8Lh7V5mgsB0FBpaoTk3cjH3bOFSPAws51f1ll3y7f3kubn/oct3fNQebG5+SgmKwV+Y2Iee5FClePyYaA5kdghYXo+GkaVBkVP4vEXSQeE5FN8QUTxwN7ESTIWUhN6OPzaoP6526qgOzj0m1uReEDvrDT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGHiAHbrXWt6TT0A5AG6/4Djj4OnLidwpNjI8qpHXD8=;
 b=YaoR19O9Rc3DwjT/rGvliwiSJVvyuTUYXX8OMmsTDIThfS74FpKPgZvhrQQnlcHEz6WCBvCr7OvL7qILQ/JQn0gVP3gaOt7nhdmM0m8DOGKPOFFBRBE9aDkvx/gznMBb37GUefOsAC3huMhdpaZmgYyEIyA2jgCKnl6VcD59xmk=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:52:00 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::62) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:59 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:57 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Generalize HQD and VMID mask calculation for MES
Date: Wed, 29 Oct 2025 13:51:32 -0400
Message-ID: <20251029175137.2861556-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: f88efd50-8048-4911-a40b-08de1713dc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RpEgPuf5TEfW3QrbFHEOlbYRzPJBQ8SkDVGyYSvE1kixIBfNxXjL2vxNBQKF?=
 =?us-ascii?Q?BH/UdmZtb6inGYtTYKbhtuA3iB4RPWMqHQm5vrciKPyhpvAg04dcFi7OXpOV?=
 =?us-ascii?Q?gXc5KnRuu+45+St9sAumHTwsPz38pLg5QdPaOWr9PsElX2PEendJVobA8jBb?=
 =?us-ascii?Q?1E75Bs7bOSJsPWunMuWwMmqKttYXW8OmkAGIfLR1iim0xShBLg6FCNKN9n/I?=
 =?us-ascii?Q?bxmYf5aPFxN0PPn7TzJZIsjv3iuFsDkHedIy8qIq+s5e+lIzV9kxaBmd4qrg?=
 =?us-ascii?Q?4fowcuQspRZRC1Pxw2rbl+/2NPTBvHhWamdJ0/6HhUiGh2xj6h4Nxa50lnfr?=
 =?us-ascii?Q?tfDG5ktrDuphwsXJYbynC6GEWun4bOMhOlnilws035/m4YVN7U3lCFCCgvVw?=
 =?us-ascii?Q?nhdvqUbnJuNPOHo0wq1IyGPUnBv/h9ohvWC0FXAhGnoxxmsvzlYqtaf/jGCa?=
 =?us-ascii?Q?1ApOFUB9S0TtpNeT7IZGj4nlnE3dE0pkJXxfmK94Z/Ryh+tYtFtbGSt5d780?=
 =?us-ascii?Q?bDNDTOrEJ0VsIIIRsnGO5AT8J20y/zVZ3jXOTFbsn8If8AUi3g4AtmSSedsL?=
 =?us-ascii?Q?AsVbhzzpRwyKIhah4Cozt77FfjyPLzVxEa6Urqzex4o/ICZvTZxTvxYXKimY?=
 =?us-ascii?Q?4NCYHT+rEMjrIP1lmuhBthh8ILphNPEzV5EHssRc2Nu8iFXtq+/vnZ1B/Rrn?=
 =?us-ascii?Q?yacMrOFebROKRlgmrfM5KQlAP6Rvm/vVz4iDcnJXyd4ZHY7ITcoWnwnUGkbL?=
 =?us-ascii?Q?inc/JIPynlIpFmbAjWr4U2SbVt6U7wTGBslhWEWDNdU3YoDMpep2YY0YEImD?=
 =?us-ascii?Q?8IE9I6zRcXy8hca/G4oI0g1RCjKrjFxegySpHTNbiPPllPfDm1kQwXY/AYPk?=
 =?us-ascii?Q?GFYcKYmb5XcwL0jtze4tr6laZQNqdP+3XLsAj2PHscfNtrusvJ2w+Vz0WEj4?=
 =?us-ascii?Q?cOw87PzIz1MIfq4dAePiBdlIO4Mso/RsB3jQFwxwrPzNhFTEcSxDLyxXA9Xs?=
 =?us-ascii?Q?g0p9QvbaTpIxc4pVi2mQwIYGih4MesOti66hrG5uuFVDUEgx6Ameg2Bq0Yin?=
 =?us-ascii?Q?sfWOEzvlCmGH7BUd0U+t0phbEAmh6KsLa8QA8EFeKsew87VxpJ3xSHNVmp04?=
 =?us-ascii?Q?RgbA6yO6ew2wybnITWOy23HLvPD1h5+YVBTwrwymweuqmNXHjzvGoU7+gsss?=
 =?us-ascii?Q?kaobnguKizajFhednE9GUOCSHl3dSdYV+CmAwF/O1k2/dqrjDrT6/V9jXGDo?=
 =?us-ascii?Q?Qb/4eaW+37vD/cp/x5Soq904IVfx6ZBKph8NDWWdeaREe/2cAZIcPCP1HZtN?=
 =?us-ascii?Q?1lZBw14beT87rPXIG5qm9SSlZfFgzNwcUX4MQNPjniQHrPq7UGbRrDnjUPa5?=
 =?us-ascii?Q?qqA0km+A+F3CEBRhUe67MK8p5QbSsNWITsI1lXE6BSfgoUx5oE4sxrt0Qitv?=
 =?us-ascii?Q?siBRrwxddcOyKIM3pwI4W3KS6S+5BHJGPwjO7632OrHIF1FjK4HGwrEAle88?=
 =?us-ascii?Q?hhxCs7CuLPzN/NZS8P+m0BuKmV57zyKdHGm8ZQkrjK/wtINgs2nCDVkmnMe5?=
 =?us-ascii?Q?wJv5HMtJjpcFo6PhFsg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:59.8239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88efd50-8048-4911-a40b-08de1713dc28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

From: Mukul Joshi <mukul.joshi@amd.com>

Generalize the calculation for determining the HQD mask and VMID mask
passed to MES during initialization.

v2: rebase (Alex)

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 96dc65559f488..895b841b9626d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -31,6 +31,7 @@
 
 #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
 #define AMDGPU_ONE_DOORBELL_SIZE 8
+#define AMDGPU_MES_RESERVED_QUEUES	2
 
 int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
 {
@@ -92,6 +93,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes;
 	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	u32 total_vmid_mask, reserved_vmid_mask;
+	u32 queue_mask, reserved_queue_mask;
 
 	adev->mes.adev = adev;
 
@@ -106,8 +109,14 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		spin_lock_init(&adev->mes.ring_lock[i]);
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
+	total_vmid_mask = (u32)((1UL << 16) - 1);
+	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
+
 	adev->mes.vmid_mask_mmhub = 0xFF00;
-	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xFFFE : 0xFF00;
+	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
+
+	queue_mask = (u32)(1UL << adev->gfx.mec.num_queue_per_pipe) - 1;
+	reserved_queue_mask = (u32)(1UL << AMDGPU_MES_RESERVED_QUEUES) - 1;
 
 	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
 	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
@@ -143,7 +152,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
 		if (i >= num_pipes)
 			break;
-		adev->mes.compute_hqd_mask[i] = adev->gfx.disable_kq ? 0xF : 0xC;
+		adev->mes.compute_hqd_mask[i] =
+			adev->gfx.disable_kq ? 0xF : (queue_mask & ~reserved_queue_mask);
 	}
 
 	num_pipes = adev->sdma.num_instances;
-- 
2.51.0

