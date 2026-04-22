Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171DDF9B614
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 10:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996BD10E9CE;
	Wed, 22 Apr 2026 10:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x3CllA51";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2027A10E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 10:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVDubmNGAavUaQ4Gaf0C+iioOOEu3/mYy17k6CGRlb4B4SA3tl80EFqnft3SnFbyD4rl/O5ZHZk8tyifQQWoFRreoe7Y7TXSIjngR2+q0lIqOU9pL3DoVZJ9iPcXlMJJtCtVT43iDveE7Fve830oVgyJLlt4Gy6PMwavki0Y4Bi4eV/x8dtsx1+jC6jU2zxPdasxJ4ul7RoNH6Dof3XByrw1Dp9ZgWNw66hio+CHI7LWIgFdWqnhnosK8GwdplVi2D9ez1sdbZnVfRnuPoZCLC84UTwdKWv80HBaH1pQTgem5Q9cJ15ugT6N05CKuqohMdT0LXYbQ3daYhB3HT7paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA6d9CNRhx86O0ut/9gguqCtyUjbBXOTY2E7LsXrKvs=;
 b=y5sPBDvChwuo9DZtpoO2ULYbxTOVD7lxQMnygXram/SG5nCj4NEantG8Ux2wNyCTXnJOef+6AAmgBCVWFdPQBHtc0ryx8RYFG71ybEypHpixTJa+5jfVTeu3hR5km0UdMPrU7LCslTo8DJORnFlEJbthzWMMyHblsB+Zv247lFtM/uyP4x1upRZPW34XRwOxr4Vh+X0DzuJaGjVYJfLUX3h6pLy9chxKohz2Zs465cfZwYVrTpnCT8xyQF+1Wq3r3rAPnkzDwDpxcwdOaD0k0T79prvA2qkhSr99oSjB59+81AeMMC+fL1x7Q8qtpkm1AgahQf6uQKwdlTthc3LgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA6d9CNRhx86O0ut/9gguqCtyUjbBXOTY2E7LsXrKvs=;
 b=x3CllA516O8OPALayQwsfK83OFfBQouoDBpQ+lyUtHh0SGFO/Tt3KkTTSEmAlu+PJmirAC1MdBL71gU5JHigNBZIGnQrNep795jrrBI4sq3xN+eSbgSkA+AwdtXk1zXPMdwEE9mGOuDKhEnhEZuTcoQNf/lfKZhQJTeP+zti2Oo=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Wed, 22 Apr
 2026 10:48:28 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::8b) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.17 via Frontend Transport; Wed,
 22 Apr 2026 10:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 10:48:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 05:48:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix missing fine-grained dpm table flag on
 aldebaran
Date: Wed, 22 Apr 2026 18:48:09 +0800
Message-ID: <20260422104809.1163843-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b4e696-728b-440a-21be-08dea05caf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: s0eeUMuwpZQwxYs/I9KeuQBDZgDl5vDW176qjW4JGZEgZtjjMi+dP/8Jyz016s4xORA9FFz0UW2sNNVIuDATexOia3X/v6+p2JyketfHqvMxc2rA6RBsak9mJgw3N3TQTbEVmwLFT4M6v9rR/n7EAht2jRMUhV2tBdRAZuKqAP1Jtek5hsUMJqmRh3zyXdrb/XrOA3v3KzXuFuDLFMEzs9Y++kBECVt5tohWwWu9Zd353GlcO10toESbGvh5K3c5AEgMMKD+mbvUhfzKiprFURvFNNi9yIqFenbKyfkzbhEMSM6GZB/g2uQ1rX5kOl8PK47i6ZLxekGeMbm/yj087hks/UNyUZlkaNuyHpsFCwJEA0QF/i8GPsGYDY9LRs+r6OTcXBPFAjF25awqtCr9NVtUgF7iW/QNT5WYtKOzzJnwBypTo9gw56OQGslfU9plWicfL2QUS5R5cx9WT0h45fPQFPoI0eOGtn+l50cnTskBRiljb5IHJnKdDmnqUEWY9sXawscrQyWiGX4yCba06k/NEdfX/FkJPvRZqke5TPBE8pftT9VhoDNl4dRqf+voSftSfuy1RdxwCKDUQGU5NHtzljc/81aaWC6copBh4dvz4R5fLWmVwBVEzoh0Qrtgy0GwsPUYwbGHToAMyaI7QSTd+iLeIK7u1zyPJbMSX/hy05ol6HazyAiAcQclb8IewYjoImMfDJhFZYDpX6rnVJ6DaUmm+y5jM4zNZnrCUwor+LHZ2KPLOriACeDf7jN/469oPYCYE4Saq3tDQNRX8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 63YT33JvFM8WX5yPFTqxr7bfItss+mVEvlGoXZR3vCTQ364mJw8IB32OoEBCgBpnqEv1+kbmOg5nUht+shDARf9weRtPM3XtJw+/NJ211QnlMyVztYTV1eiTE53G9JcGFhHSY/NhpAAqiZigpKHCqyTjl2qLT6MBWuPbemvUhXiHvS0G/zqXwGadH7zX66442cm6yp6nYdu71SkNRB9KbcPkZV0WB7r1NArQnr+Pz1KsmgR/YqE8NKPMJGpRWkPAsdCaFV5Xizs/h2Fh7k365rrWL1k64M5vWWXjGPRm/18c7l84448vwefD4HEh458chiUR3K8KMqxmU3uv8Pb1VQ7NjzXb4Dv4CS4I5rPPZuurZu55pBsQ+gYf+bIHQ04T9p7N8uumF+PyySBT3P6KsC016k1+XChQWJpARUs2VnFX59F2SJRXwF3WQ3uPSmpW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:48:27.5500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b4e696-728b-440a-21be-08dea05caf8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

Add the missing SMU_DPM_TABLE_FINE_GRAINED flag to aldebaran DPM table.
This fixes the pp_dpm_sclk node issue caused by missing flag configuration.

Fixes: 7ea1c722fe1d ("drm/amd/pm: Use common helper for aldebaran dpm table")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c340f19f7de6..754cad44269b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -426,6 +426,7 @@ static int aldebaran_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->dpm_levels[0].enabled = true;
 		dpm_table->dpm_levels[1].value = pptable->GfxclkFmax;
 		dpm_table->dpm_levels[1].enabled = true;
+		dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
-- 
2.47.3

