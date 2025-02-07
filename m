Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA8C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 21:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F50E10E0CF;
	Fri,  7 Feb 2025 21:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Or0LgU20";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A93610E0CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 21:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWz14iU61ukmqbao+x+5ZLkrSq2u0OWdVVxnfv0EHTnYY2RJym4RMl+aZZuJTyVHeI7rGG3LZqoTQaO837pf46X1Lzu6l7vKIYt5d3F/81UBy2NOw70SEc10RJLMdHaqe288ozSwfAYeZYwiZZNrNzEavmBTYtYgXGsagCaYLjBrmwqizgGrd6agxkcXvbU61nsJyVHg9aJBEhOICuisqFk54OfnhOmLclFlCCyWE/+PNM7J3kXYj9D1dIdhv8b8p//j2dAVyk7sOXqtE6m4nFFF2HMUutrpLuYijObbmmmKf2GSuuGqBSg8o8hTahSDfLoVRZjjoVime/8OEH4RQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bA7CYniD1CQHeb7wYMGMkPvs+WW8HuBPMTqnTVs+Tg=;
 b=h/inM7Tz3wSCwW9HcShb8swEiz5iWtJHMmdLZ/657AiklrdXZtU4ied+c6Pz8QHd3UUOmTorCol18njPVsJ3z/D7nHDH/JIbLUhw+s/0OxAPEpHfSytGS4atfYEQJE0ZB0FAKBo22HXIvDyXa7HDe+BSMSBGVtsQwnZYPPGwRWvpdptN+Ic0uY9kp8bRjjdyY/NWWHpefKWZMQxD3NyDiUZMMBX+7RBa672Wx2v61fnSLIIpB+UEkjJ4HAFsFuTjeT/cPhTu+1S/a2rlGLidlvoUSi9DTu3N6A9Q1SIwHa8cAOz0ZFYqXMzkafynzUruxv+xze477HGDWGd3nizWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bA7CYniD1CQHeb7wYMGMkPvs+WW8HuBPMTqnTVs+Tg=;
 b=Or0LgU20KXnqp8lFzxHJ3Bqqqi0ePJiBxDuFPKoIvNVkT+Milm5PwDz+Jaos/NrQyTG27trXsYpBrefftm/R2p+esLhh3n4wYKuEp8rQdggTBWuKwR85w++xmNjt0iL+eV6P5ruqxptmfjDe5wEvRgoqMx7YAvoJKveoLMxWMWg=
Received: from CH2PR14CA0051.namprd14.prod.outlook.com (2603:10b6:610:56::31)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 21:27:41 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::13) by CH2PR14CA0051.outlook.office365.com
 (2603:10b6:610:56::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 21:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 21:27:41 +0000
Received: from rliang-PowerEdge-R740.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 15:27:40 -0600
From: Ying Li <yingli12@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Mario <Mario.Limonciello@amd.com>, Alex
 <alexander.deucher@amd.com>, <ray.huang@amd.com>
CC: Richard <Richardqi.Liang@amd.com>, YING LI <yingli12@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: add support for IP version 11.5.2
Date: Fri, 7 Feb 2025 16:27:34 -0500
Message-ID: <20250207212734.1986678-2-yingli12@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207212734.1986678-1-yingli12@amd.com>
References: <20250207212734.1986678-1-yingli12@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce04207-189f-4992-1376-08dd47be4113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zc9c/JpAJt6EMsnh87Gs5u3U6w3283hXzTieVxht42/p+5YTyMLi/m738AFa?=
 =?us-ascii?Q?/KGpagpOKNwSkHx14PM62mAlwWHzbeuLvv34mvH3dUpgVWPK6GZhLjX7XCUX?=
 =?us-ascii?Q?eBIkLRIt9PF2bVQsaYHj0o7hpO6ShMKyRwx3Vm2QkmfJLzyn8CAAYExRNUKU?=
 =?us-ascii?Q?i6/QBcgdOMWRDTRIv/KnFnrVYT6IJpSnzp2sbsj50u7SM+d7rtuSQnMnzbz8?=
 =?us-ascii?Q?z47Smw36s0ooCsY8Tin0UCCMZWn2o++Ut7FZX6MkgeVftVUNi/JXoReVHgxX?=
 =?us-ascii?Q?a3AXZp6UeTiZWFxFbcjeIYTxc9I19pMq6l0m8efLCA/EB/KtN4QRW4uBi7E3?=
 =?us-ascii?Q?6qNVEH8NijjTEDN/Tgb2ZTh7GPfYZJI0b8tBZu/q3ufisJlV6T95DFySKwx2?=
 =?us-ascii?Q?xRNIAsd0r0nCD8waG7P3QY/eJ6HMciW+Ff342WGX1DnMG+qgfmYgMyYXIXky?=
 =?us-ascii?Q?7BU05xtPHhRyZyzCkHAscVOakfXmI1udbuXzoFCE4tp7pYt5rQn81ffXDq35?=
 =?us-ascii?Q?i2OvXV6cqYdUGziLkqSdbtOO/A4ag6QTRXj4ZLGXQbyGBuvyScz96rrQir2U?=
 =?us-ascii?Q?hCybYgWIPRy5bYozkD+Tq+aqxLLfPGdDjalOMYYGuuBwWsz2WwmJCcfwqj5p?=
 =?us-ascii?Q?uE1xIGz3S81FC8fiuKvCaVkXv2EN9JJ/FI7KKi4p1nxP7Ejvi/7Z1z9yfA/g?=
 =?us-ascii?Q?pn71x9GkFxnWnuoTO2OuMYMGyaWHNiQn1u6io0XCRAG5RWvKVFyXCVSCTGBh?=
 =?us-ascii?Q?C98pg4aeVVf8Aq42VUBER0S/wsay9FvmvJHMYRk535L0+kabg4YzOYTL1bOQ?=
 =?us-ascii?Q?HBlmWcPRRud3CAT9MQMq8RH1v+N61BQ4lfPeYMTPVBiF4stzNbmtZVFHsPOS?=
 =?us-ascii?Q?eSrqXLHjTb7kAr3FabcO/51cbNpXUO3TqSuHGuDwilkVCih0GsqF4eQ/gF8Y?=
 =?us-ascii?Q?M3/J6vCDTP0SXwSwkBpk3j9GL5bei8zl5GcKyxRl6CBoIAnbuC/1m/KOuy7L?=
 =?us-ascii?Q?yGIo2shmmp9ABs1CmqrnI2HGOZ7MHS4zxt/Jm3bxTo42ecNQWf3qQZCmx/NB?=
 =?us-ascii?Q?4j3d2VqrYZxXxHxA3zF/mlQH0e7Vs/O2Vt8AmKmVFCfDkVePtvUVcG5xZbGU?=
 =?us-ascii?Q?lae7du/ZmuSH6jSyvZFAnZDA/+54c1gn6DUE3pgOgq3XRCwvA2ku4wNWOAPV?=
 =?us-ascii?Q?/tMVR4pUuG/LyoJxskgdLSWcKnJdMmPo7u2rqIhrMtjXWC9moTB2O7PRQ1A8?=
 =?us-ascii?Q?PTF3Z29qiK+nqGSN8ZK1HUlPb2+nphrhDTxZ48TEapAoqXWbETAwwzTW/y+o?=
 =?us-ascii?Q?usY/DL2lSObsjPnCVarz7CowMq26ij5OHcUcZV27vGATPGY+TKG7WmPRIuUT?=
 =?us-ascii?Q?aBbv4zJD+/42zGNYgopGfH3qTH4tRBUpNgNed+XvVJU75txwg9Fbz1v2wvw1?=
 =?us-ascii?Q?MuLMv+UJ4CTOzLw+I/UkulNtNIo7qSqWqQwFtk0uc2oEdcjdr/vhIlQcd9k4?=
 =?us-ascii?Q?pux8XD+bJHadqqQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:27:41.6668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce04207-189f-4992-1376-08dd47be4113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

This initializes drm/amd/amdgpu version 11.5.2

Signed-off-by: YING LI <yingli12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 1 +
 5 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eca431e52038..8db1b221f30c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2020,6 +2020,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 8):
@@ -2084,6 +2085,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2930,6 +2932,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 10):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 9):
 	case IP_VERSION(13, 0, 10):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b531adfb4f57..a221165f239a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,6 +193,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 11):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 0, 12):
 	case IP_VERSION(11, 0, 13):
 		psp_v11_0_set_psp_funcs(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index cf700824b960..3d9e9fdc10b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1216,6 +1216,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 		case IP_VERSION(11, 0, 13):
 			return "beige_goby";
 		case IP_VERSION(11, 5, 0):
+		case IP_VERSION(11, 5, 2):
 			return "vangogh";
 		case IP_VERSION(12, 0, 1):
 			return "green_sardine";
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47db483c3516..8d84dff58b7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 2395f1856962..bb5dfc410a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -129,6 +129,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		err = psp_init_ta_microcode(psp, ucode_prefix);
 		break;
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 2):
 		err = psp_init_asd_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
-- 
2.34.1

