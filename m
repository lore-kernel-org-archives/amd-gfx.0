Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDCC19776
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 08:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43D110E876;
	Wed, 26 Feb 2025 08:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7meBEn4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FDE10E875
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 08:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh4L2nXDb8bTzM0Myihinwl6srzHdfSlijc072T/NMd7PrnoU/2pAL8JBkHnibidN+ETlV/KKIg+bDLCUUBh+GrMURTUwW+Na/VI/KgenMVrfYidYWZB4FjWzkOXrzESHIFEJJg3K25f4HHLpuMxYtHoGE1PF6Ulaa7M70a6/GqL50GSJLG81oP73UW6JaRzy71m6EwIzJG7uDmUXtcjmSs+zL0y9bBF2XpQY+OePh0UH6odP9LgIHiEM+G2NEyr7rMLPwLNNn6cjlFT78lfRA/Bx6fQv+K51kzBropFPTFzJrjFGjTLRj1eFAIR4HRaIUaim/tKn9ySQr5nkN595w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktGas7WbakPmlYs1DeixWO7oEOuvfkuaAplZ9Dh78pw=;
 b=WNRBocLUZOZ4nZCLrMOqwbCRXMg9sr3LLzpQaNMeGrayNdsoRXix4pgj3m+YguMRsAEWQwH76U++D/V+vE/AUrOKdet9PXB3bu/5CDxrVdISLTTtP8JlRWnuLJH2NUYE43EpTPNytiKcjGVNtF4LwfcP5uXx30V5KKlZ4Zsl1DzRmG8tTCBzQR4tZ0RYCRVFsFsF4JE/wVC6aCeGvDmE1fWpf386IqdC/0lrFrfgQ7S6VuZGAyXNOKcBb2el1VCcVtjNpbobRoYop4u5u7ilNZ+niakUWORC5bpohV1cRhpHadvRUfeGAmEt/sxeFjCti83MhxSyuVHGl0nIjtLyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktGas7WbakPmlYs1DeixWO7oEOuvfkuaAplZ9Dh78pw=;
 b=b7meBEn4XDQUlR1cUhDwJ6NGeWPC/Vw2Gevs91p7i+P7YT9aXjbPv/Swy6MnD+1Sfn11v0hYA/J9dUcw3bReZVyvMd6EHM1qh/HIyIeJwRh/0G5XOzzBi9g1BdbLnGTSbHLSvsOn7+owyyIcRepicuzXsuSKFNRhju9RSSI4USs=
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Wed, 26 Feb
 2025 08:08:30 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::ff) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Wed,
 26 Feb 2025 08:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:08:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:08:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Feb
 2025 02:08:04 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 26 Feb 2025 02:08:02 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable gfxoff on the specific sku
Date: Wed, 26 Feb 2025 16:07:57 +0800
Message-ID: <20250226080757.518795-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: a758a646-43a1-4a9a-ff43-08dd563cb475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VrwXSIyOb9lvvv+3mlq3mGxgCxMoaSQzCEGca7J0MJAOtaKQIrdlcO6QSELp?=
 =?us-ascii?Q?ENWThF8m5K8RzS1ErT+J3a1ASZkjO1hOuW5N0VmsZEB7/kfPDawqm1dnWOOh?=
 =?us-ascii?Q?zG4xmP5alZP2QVupdXJP4c1KVlHYJ0WwM9eZMJKJvd8nlAeBkfH10QUcV6RJ?=
 =?us-ascii?Q?DqoS/T2WKJxdrAiUApfnZ35oTgl+L3v6Kn5+AHQQsQwtmLZtaymBcMhBRlzj?=
 =?us-ascii?Q?pEt1p4lwQZediVjAO6L/5FZErH1aXSZipLyIB8IUagIibElDOidJ3YQfHbKz?=
 =?us-ascii?Q?rVu3uFE1HgU0oHAy0l7GkQkDMUGsyuq3C+Rm6NghUkAyDAPIrr/9Ro46G8Qb?=
 =?us-ascii?Q?qk6wyGqLieXYqonylJsPL+F0fxWgaS1S33e6AILMLF2Cb0qyqKZdgmcbeaqE?=
 =?us-ascii?Q?NxuN5Po3lpfaPkqhmdD6js3vDMuOn7649/4ihQnqrt9h/IbUXI77Tg9vcvGj?=
 =?us-ascii?Q?Q9ry/BG3D+XkNL9C5glpNsWV0/J6YfgObGsD9eR353h7tWzIeItt/L3yy/Wo?=
 =?us-ascii?Q?c4u+C1ilFstX7ePex6c8sLZTfqcf9FCq9WgOMNeuJCXwVukTHRzQDIh4Q4Vy?=
 =?us-ascii?Q?0KScNuPsvtkoyF9Fb14YpOahrFWLVKjkOARTzkKvWgQJJ626h8UMMSE2RJYw?=
 =?us-ascii?Q?cvIbV2lxaxMSh46xWensHEnQRtkjzglebg6N7ppCdczxdeEHWXA3H+5fHGrI?=
 =?us-ascii?Q?fTthDhaGs2Z1ru0drje7QYExkY3QPvkgCTFTcuewfIjJQ+iAVIqv49XAuJSz?=
 =?us-ascii?Q?dk5A8WJWezKS0mKoQx2T11Dvpd/BIH8QcfBVpKjSZccs/vdjApuygZvXlfSW?=
 =?us-ascii?Q?USBa3tS7XCnUnW3DP0mLmtEUmvll8V3sIfVClcyRp9RpMmW5W0EKpfqLi1LN?=
 =?us-ascii?Q?weWgrP7PcCOxxYZuG+fh6IiM/uPL7pXoMFONeXOvosACNTMPy6yRN3AAVOq/?=
 =?us-ascii?Q?z5yeLGjlXnKfVBFRbCgyzkeM4Alpiyy2pGo1QhIuiYeHyX0PBM+VCLZvhsH2?=
 =?us-ascii?Q?w0jd9uAZ7uRTnBJ2jWvplUWUY/E1wmHJtRRclgsnluCSV+yPMxUR3oZcHcVm?=
 =?us-ascii?Q?msaEP8721hAD5HxHgIIX+y0LzpD56/iXW22QNmgMNGHK7f+1fzQPklym6S0z?=
 =?us-ascii?Q?+MjCARHoBy2jz7mUMGJC4HX96klYywXY+uK5RXvShk2wIpSeVWS2c5uFOOG8?=
 =?us-ascii?Q?X06rZBpwbbVveS/vyn6y7gPSziYOIMJsg4lUgyqBHay6ozV2NxcX8/DsHHmG?=
 =?us-ascii?Q?3eXPj33KCZcgDMTwwFtSZbioEtI9T5oe54KBqiI+eW2A/QQJH2vIkHTk4piv?=
 =?us-ascii?Q?Mg0C+qzLeaOG1C+QoLzsa1x2miUOqcXWYeCAcRPTIoe1Q24GqsRYbKsjXlbY?=
 =?us-ascii?Q?/Em5B6XO0APdmncA6fFheZFCqDy/GUJumoWfZnOxts7DieUK9w+LcuM1XLvB?=
 =?us-ascii?Q?8qrSRs/8ZPhRczjYtPVygBpC/9HJeW0vzxP2UDCD8qOpIVw+OroVXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:08:08.1668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a758a646-43a1-4a9a-ff43-08dd563cb475
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

disable gfxoff on the specific sku based on the requirement

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 985355bf78b2..898487ad6cd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3234,4 +3234,9 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = smu_v13_0_0_workload_map;
 	smu->smc_driver_if_version = SMU13_0_0_DRIVER_IF_VERSION;
 	smu_v13_0_0_set_smu_mailbox_registers(smu);
+
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) ==
+		IP_VERSION(13, 0, 10) &&
+		!amdgpu_device_has_display_hardware(smu->adev))
+		smu->adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
 }
-- 
2.34.1

