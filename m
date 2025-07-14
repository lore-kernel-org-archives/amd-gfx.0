Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F061DC83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 05:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3667810E1EF;
	Mon, 14 Jul 2025 05:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsMLwG5n";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F4B10E1EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 05:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYW0IR26x1vAVras88QBujki6OXdXHaF6VbXiGBBsuxQArHAJAz7bmyHGzg2PE/c3u6MmIYiodoHRt0bkk1xmGyhM5LfkxeGnCzEOuOpsCltfzOFgFLGERmrrTupAGKZZPQTMnvOxBBoUdS0yBqLyVDA/U7+BjpV4okpV0X50gL/etdLsDlpvJM9It26CVehy3yiuqfTmUIy0aEpcZMAwuBUCyqv8kz8aACR34ro+dAGqzYRii6h0PLKoJCm/b8CBmesIyftNLeuvby8qK7LNrj9pmdHfZ0sAtQ5nxaQ7qiyXlS2kwoT/V0nfiENU6Gb9Wuu5z8jwdavPu0kh6dZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdgHjCwo/3lRx6DDD7F3c4LPxtHx96LxuW1eO7BIYgU=;
 b=mO8xZUGTwKoHMBFc1yxBMbC+eheDVLBknSNk2v93FCSBuf1adcjsdac7XpEBVXMnG88AkPy4wUgfcZPL49FzPkidHsYIkhzYJu/3CNSbwj6oKsnmQBQKDwUfeQxbTEVuMPBvw9RRv3I4ClpVUSIULFh3Y9Y8NSMzWcrv15NP+neaX0c2j3xCU4pX7mbcDACoR01qcip5hyqnz90afwMGTipd5IlVVimzA+WgbhQ3S0EaKVfW71ERZ/PNSbeDzviNXtnHctQZcbRClzaRSiJd6hmU9lRKH/cH0csfKnopbAocQfT2u0HvPvmyoEMAETy8keSPx6UMmvL/81UUJeOqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdgHjCwo/3lRx6DDD7F3c4LPxtHx96LxuW1eO7BIYgU=;
 b=xsMLwG5nOnvwuP6ENgtOOTWlXGvsSQD3tdNNFBJbUR7ipycyvPxxKSX+hrkOeBF9NFiTkeQ9LZz5vFpeGAjCYjQqp9dnax2m46IhkvwbEs2ATzBTtPr83Ro9rX+xgcc61yYYK1eOeE2NYAyymonUIUJkG46KwbO5HrzhTgG5eac=
Received: from BN1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:408:e2::15)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 05:22:43 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::37) by BN1PR13CA0010.outlook.office365.com
 (2603:10b6:408:e2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.13 via Frontend Transport; Mon,
 14 Jul 2025 05:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Mon, 14 Jul 2025 05:22:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 00:22:41 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Increase reset counter only on success
Date: Mon, 14 Jul 2025 10:52:18 +0530
Message-ID: <20250714052218.1523140-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: ab12e102-b625-4d1a-ddb8-08ddc296757b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NWjQM2kCkibTuCPn5LsoXod69wlnzx357ly0lGiSFMghFU6AMfUmzUlU7wnb?=
 =?us-ascii?Q?EAkyO2tLV0JQTNMDvMhxjGrScM9xcT4dHYNN+9xDFIZyZ74OtWSE1LZ2HBiM?=
 =?us-ascii?Q?M2ZPXxcLtCVNxS6xFiw7ontGG2x/H+KIDz/r+VQfEqeUSBgxKSOkGBatltDG?=
 =?us-ascii?Q?YVrDG+EhCHFQnz1WEjoCwGbTfOJmHvPVdxAohUhgD+IE20emgMOFYRpfmT6D?=
 =?us-ascii?Q?EMsqJ7rYrr7u8VC2AJNKn+XwP4LZyIAd1BNcWzISWa2vxlHpLUjX4Mw96qs8?=
 =?us-ascii?Q?mLicewA5vLh2Hvu8X5wS+cc2k4xh8GAd0BFETn42Q6+lgKyNAtlxTTkbQg2v?=
 =?us-ascii?Q?vUyflqZWqUYNREjTwXWNwatxTmwS81FYCZuxVUONuCAIkmrBujOsx6JcguP6?=
 =?us-ascii?Q?kJ3jY/C71g+JH8WYdSshZdOrNciHUCe3yEocp+vpTDZqUlee9KW3c3dCKVwv?=
 =?us-ascii?Q?+3aVjFtPVUlUw1TFdKBA3agYlZjY+2nwzmWjSBIsbkH/r8bwyeDTw87lQ+nT?=
 =?us-ascii?Q?PZMhe0tgBKzEV+NYgW4QPLlaNq4Ela416hnnn7z/EExLrJVu8dfKBwxJ4Jor?=
 =?us-ascii?Q?YBUooUOD/gm2gXKJU0ytecMIXrPa1ObyGpUQmruWejUFl0N3NLP+5L5hLUxE?=
 =?us-ascii?Q?VabGJvPSFVaKN3EMw4p21iNkLzIQRkP/RsEAczgZHVP2q54bhC/ZAlBP7PnK?=
 =?us-ascii?Q?mgs5YZV2j8z+ZYQK4Fi61KNcHQbSdfLAGOFmsjZPDfmCxSysz28ePQ0dAdnP?=
 =?us-ascii?Q?qrzkB8J70c35wshGHNI1pWomL68DdJc7Xx8F9wtRtt3NfnU2n7rlwRrjQEwc?=
 =?us-ascii?Q?+VWPiFFhb0zN9hPDA1VuH9E+8oTKA3NyX54nSM8DWLg0xoRJuuUsTqEB4GcM?=
 =?us-ascii?Q?4LrZPVZ1PowaNOmeUH3Vu+EgJtCIe6JkQ2NbRzMbPDzcP0w9Hi7uPeWvOU30?=
 =?us-ascii?Q?BROgp1mJ7Ie8C1c2K24ZRgUTqh037qrLbDH/0cTDP4R5Vfl+smo3Yze/h/dS?=
 =?us-ascii?Q?oR02FtvAqh7Bau2eY0E3iORnyejJQXs/yDtnzOsDorYOxLE3RJsdSNNxWM2s?=
 =?us-ascii?Q?JYAjcfeabUhlQegix9lFt9LobvBICfcjv+tKjQbg2Gnf5f7E4nPrqJCYofCH?=
 =?us-ascii?Q?a/d7j2bijbJFTCoXZNu3ncPrMuyCNkgzz0EXFN8cCKJF4DneYOMwC2nUCyIt?=
 =?us-ascii?Q?7Lb0ViePVAnfalapPCVB39aACym1q0cKx4uotlGmkRsK9AHblMCt6vt/l8gU?=
 =?us-ascii?Q?JX/diefSWgBL0UXsJtUkkAohpBmR4JvVEQoqICteztzxNn365okK7arvtrO/?=
 =?us-ascii?Q?GcsZuOZkMyXuHTDqUnp/JBrQICSgK/sSu+Uy0Ds+4muUWu2n0l2a+Ggtzm/G?=
 =?us-ascii?Q?BwMR+g2pMsgQ1uhJL+xMJKGI5kJoO/ul16PT/pst+byM4XpCM0MzZ4AHoQ6Y?=
 =?us-ascii?Q?kkzQQK4uvfzGbQITioBnoZ6iHCt99Kf1NAmMkXZ6WdCuxb7WKuk7pBM2uK72?=
 =?us-ascii?Q?I5p9D0XwBNiEbmHYV/KQMwwvUQrs+INRjp8O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:22:42.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab12e102-b625-4d1a-ddb8-08ddc296757b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
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

Increment the reset counter only if soft recovery succeeded. This is
consistent with a ring hard reset behaviour where counter gets
incremented only if hard reset succeeded.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf..6ac0ce361a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -427,6 +427,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 {
 	unsigned long flags;
 	ktime_t deadline;
+	bool ret;
 
 	if (unlikely(ring->adev->debug_disable_soft_recovery))
 		return false;
@@ -441,12 +442,16 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 		dma_fence_set_error(fence, -ENODATA);
 	spin_unlock_irqrestore(fence->lock, flags);
 
-	atomic_inc(&ring->adev->gpu_reset_counter);
 	while (!dma_fence_is_signaled(fence) &&
 	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
 		ring->funcs->soft_recovery(ring, vmid);
 
-	return dma_fence_is_signaled(fence);
+	ret = dma_fence_is_signaled(fence);
+	/* increment the counter only if soft reset worked */
+	if (ret)
+		atomic_inc(&ring->adev->gpu_reset_counter);
+
+	return ret;
 }
 
 /*
-- 
2.49.0

