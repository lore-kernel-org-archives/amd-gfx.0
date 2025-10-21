Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BC0CCD1A5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 09:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C423C10E2DD;
	Tue, 21 Oct 2025 09:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="icnG/UfF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50F710E2DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 09:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbQgoPFlUGVSJ231XYN0XsMtBD/Z0XBC9uFOhqdztCm0cNxMdPEFaI0u9eDKvc0M9pV/gvHxhRtZA5I44U9NUvtHFErYEpMAlLtlLiLC23EEjbNDkGmoFyywoCaWurhWxszopY+T67W7fCayeXjXvtbqqDtgWxOIl7twll2x6HGqZv5jKsh+k+dqEJSYTurO5j8Ya/aRfgYBFLZ/dEgDhqZDmO6zXmBfhtc7qDU6lyTaOnHSpPoOp45+VDUPnrqrC2jCQleAEJJjl9mp09pqiFopJl2G11B9bStDiHFWMMLn4h4Br/t8OcrRnJctMBjHfsx4Y4Wq1m6hy/4OqovyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuNIgKqcK/+vb2MUObpGDUHbIcyQdYJ5TXVhmDPGcTE=;
 b=nGTtcqk2fAIP8mnNLL62S7mSU6p/P+G9QKt3SnnKoE5b9AJyieH8dZTIY9a41mwVclQc3Z4W50PGAlCcNkPXJsMZt69IGntX3oLIEuyTMm1gI8S5+sQSleUWHPHCXkSM+YSXwi37rWlJ6einmvYVLgA7PNwa3w+DjZfQbJCorLjDxK5NTsBVY3Ev1pxVyeVHdSElNuVO/KsKSCeq0jIzbdtsvPjTBC+VsQHOx+OjoAt8gwYOwb4/4a6QI6gj894yOsIeNOg/vHZAyISKi5b3lF9PUwMQEN05wH1QjQpIxoxkINbsJhEyuJfXBUPmDY9p+HkIoYxSD5vFQIy6ZcF4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuNIgKqcK/+vb2MUObpGDUHbIcyQdYJ5TXVhmDPGcTE=;
 b=icnG/UfF/W9v6GwlIiboi6IvSJ59mCRkeMpyttp5gj+Gi7zpEN7Hml3fwGhuxT3pbp8kRvRoPDz1UXer/M0mCqHjn9K+/ylM2zUvpHAFF7MN7SArBwZrneM603wtsLJz/xzsbrlRLmtAvYbc4elGYQtGzLGKwKsI0yAxLuUn4Ss=
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 09:48:37 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3b4:cafe::2d) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 09:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 09:48:36 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 02:48:34 -0700
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Horace.Chen@amd.com>, <Harish.Kasiviswanathan@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Tue, 21 Oct 2025 17:45:57 +0800
Message-ID: <20251021094558.4133201-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|BN3PR12MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: a7708ade-1a12-4f9c-8e2b-08de10870168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+pM+3PDXXIGUQqKI9sScuFmum2nhYDLzbidgi5zbFAOAPYgYBF3qiFT1TNA1?=
 =?us-ascii?Q?43/2dF6bjBBKfIc2JxDVeLs4PgZu5Ppo2xlIYqDY11MozBwFKM4jXdw6KalF?=
 =?us-ascii?Q?mHKc6Hvu12iCiF97t1Q6VreipI67C+Myhgi5n0g4l2UOJJ7KU3+juVGcviHw?=
 =?us-ascii?Q?j749ympFMAYFziYav4kFvO5tv1PkaXZHnMZbhFOeH4Tbek6vPk6NkZlnGzZW?=
 =?us-ascii?Q?9c+HAelEr1/dG9QJWVqi4kESAA7Dxd4NiVwjDiFCvgU6q7TlmWEkyZ3iJKMS?=
 =?us-ascii?Q?Zvs1YwRqsSbTNG3T9EvU+MBIhvt4ZQtVCEcplDuf+VYIr8fmIIaGfb4kA+1j?=
 =?us-ascii?Q?FHpG2qTP8R+WYhylcALs9sE7PT8GD8pT4e8Qr0jnpUdAtRE50WOcl31KRxVa?=
 =?us-ascii?Q?pD4kMZqgySHD5TKGqnM4kmhtBxuvRpg4Hby/qLZesv80q1oYYVfPjl5mQXcx?=
 =?us-ascii?Q?kVNfJtPDyzIYE6VyVtvHG08a/f0bNqz2GNIyi5CgCWabdqPj7yzJDU3DSiWT?=
 =?us-ascii?Q?qzAwFHabfTicju9R0TEvpbiq7OKgN037CeepdQ5RyZHvRCvoJW8w9/Te8+uc?=
 =?us-ascii?Q?EurB5JZAfSx3Ah25Sc/5ioChUzDci8gvE6bgvJjXVLwjt9NlwGVotnFe2vzY?=
 =?us-ascii?Q?ZZx9GOiZZFVEsGr0l9k1jxYaVZOkpgFAn5OQTOq+9NH2Lr8tjjBqJlzr+o88?=
 =?us-ascii?Q?QIfXd5xKU/Duy2km/dzEEcn0PgeV3IF24jCZdl4ToIpDHDGjR/ISj8DD2D3V?=
 =?us-ascii?Q?3HGk8/T714mefZWgDUaj0YZKq6Kh3g3CorDUPwv3YHESipduwk0mdapJvf8F?=
 =?us-ascii?Q?kNnlC73ofYtup3qzbjhrvL1ojyVupXhPKSQeZZIJ2rhmxWA8HqESpSgnI6W7?=
 =?us-ascii?Q?UomtBHCGq0eg9grnxRhm2qtORt8/drIgnk2mExcVDI2Hm0VnY+BEzVQz1y0v?=
 =?us-ascii?Q?11ApBqAdL5pNq+HeyB8OrmfU0PfO/Rk6Rhk9nGbL0t9jr3dcwyUO4gVDYos1?=
 =?us-ascii?Q?XjRw5CZf8fpo7ian3UCD2Z9dpvPU1r81aGV9mO2aGwj1/yNssQLyZyc4KQkb?=
 =?us-ascii?Q?/kqak/V15H+fK9oTK4Gvz8HOhJcUcNc1jVPGxg3vtzIIlvT38p+fIGZQMIFI?=
 =?us-ascii?Q?06v3eb2om7+bKutZ09wjs52lS+aB5CK5m6/SQQsVvV3AsRWXpYI5lSDfp0WG?=
 =?us-ascii?Q?Qr3ht0NdiGSwsaF/umu6ySZyAMzdqqk/PP994fC77IvDUHK81lEdSUePaMIW?=
 =?us-ascii?Q?bvSIoy6u31c+H+I/F0I8J/c9q3rSEDMzX5jytIbHKKL/zNtWgWPMA4XRssy+?=
 =?us-ascii?Q?WowMNYHLGatKpd1Qa2YEVcLRzVaDBwEizeAuTrPgeQFDMQ0YHYM9e5qKbp+5?=
 =?us-ascii?Q?l01F9vn0xwzdRiMNj1uHrRsXVB7ViY3qTeQMTg0Ri3HigGbmK7GZuXxljg/u?=
 =?us-ascii?Q?Ny6tZc0c1altscDYXPFBvsU6sylAvwo9W309ViY5FSszQFMYS94wafoMmqvI?=
 =?us-ascii?Q?O37x/WkIHfMd/ee5it0QC3WxovCBixG+9BU7Co9OvV78K62q7Ei1jlWECv5K?=
 =?us-ascii?Q?yAodKC/2nwQ3hQvyWAY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 09:48:36.2921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7708ade-1a12-4f9c-8e2b-08de10870168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569
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

[Why]
the function "pci_p2pdma_add_resource" in "kfd_ais_init",
and function "devm_memremap_pages" in "kgd2kfd_init_zone_device",
sometimes will cost time about 4s,but the gpu full access time is 3s,
will cause gim reset vf.

[How]
move the two function after release full gpu access(amdgpu_virt_release_full_gpu).

Signed-off-by: chong li <chongli2@amd.com>
Change-Id: I2db38d905d9dd7fedc4c6a38e325320268c2d84d
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 882fff5a7598..93f66a03ee01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3331,12 +3331,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
-	/* Don't init kfd if whole hive need to be reset during init */
-	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		kgd2kfd_init_zone_device(adev);
-		amdgpu_amdkfd_device_init(adev);
-	}
-
 	amdgpu_fru_get_product_info(adev);
 
 	if (!amdgpu_sriov_vf(adev) || amdgpu_sriov_ras_cper_en(adev))
@@ -4926,6 +4920,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		kgd2kfd_init_zone_device(adev);
+		amdgpu_amdkfd_device_init(adev);
+	}
+
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
 	/*
-- 
2.48.1

