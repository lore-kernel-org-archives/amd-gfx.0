Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A38E8B399
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AED710E07F;
	Wed,  4 Feb 2026 04:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e33kOvJF";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED7A10E07F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIIbTY4ulwOIwiaorsw5vDFemaJqEogv1JF2EP2vlGxDx8F5L2OQnhboN67XCTNLUGi5lJW3LSZVqBEiYdlZKW03NpmYReL9/vBJbmtiaEgV6R9t83ndNtol12f4rkRgMpzOM8147XLkdtc0syDELFToWf7W+/rR1BYx7nxknfZ0J8WGvbhQEsrobq1UiR2ALXILKfkC1zvbNK33ICYPdPIhfMxyIILbC6mnHc5bb06crw64w9FGOch7SpiHB/5Rzw1ImmXoAfFGEhmUxiYirSSVJkSnihbhgYzgm6D628LBnb4/wO7gePuPhxpKFPBoqVl8O0ZAcsSEpuA03yhROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b0icw5Fq0a9qKSSj01Y9Q1JgN58iqUSnMwger4nAgg=;
 b=jDxxAGcyRAsFelzbCXOitstefN7TUr4Nz90+kMtEXbjPxvgtVSMfiCcmFaxJrwgW8tP7S4lMad0iBbUeJoY2EbI4HphEFverFBv7xxgmJ6DX6TfKlz/GN7hZsxbx0gW8oqlqEULIhqcRoSnYbTHxDDmC0VOg5mENBojFgl9jx520P4B0y+wxyD11lye3yCBUhDHHKw0qTLW6iS7jDVeVCm7ozcJY35zdWpcWCfBhFHrMJED5edcmgUwxwdjOB5fQ6V+tchPvWBwMPTROr2EVRLjYsyMGsUcDU2JewEIOCbYDZ6XxKflzF2YZYwFzCQyQSCPRSNf7DLg9/9p5ylyO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b0icw5Fq0a9qKSSj01Y9Q1JgN58iqUSnMwger4nAgg=;
 b=e33kOvJFHxLZy2OkK5a3i8rYim66hjovE9HaqKnRkh2uVDzSBRnwC+LPmcbqHFFYG6BXjz34F3l9WxUqxsnPVW8RnPIeeegF0Y9mrYisiSdyH/sNPjDBLtRtfoXGeBtKoa+2mrsBKZOpXmb0vuuJW5GFPYNVBQWSxCIUhYUlN28=
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:43:57 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::12) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Wed,
 4 Feb 2026 04:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:43:56 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:43:55 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Wed, 4 Feb 2026 04:43:28 +0000
Message-ID: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1feac1-baf0-47b2-a472-08de63a801d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hdp/GEuXbtb6Qxv3qJ0wmreEorACd1TXZqyIn7S/7qCCrpGC8+DTfQuEfBPm?=
 =?us-ascii?Q?Y2kGWF/WvprWbfB4kAFXlBKv8DYsEYT6D0fPxq0rRnpufVAhXhJh65ZMTDaO?=
 =?us-ascii?Q?ujf4zI1HUv8JTMx/4OE0iALty0q4bhYOFcwrfetix4ViW/8x+Du9oCuQB7Qb?=
 =?us-ascii?Q?N0Dwy6nmFoBl0TcFfmm20srmfPsKBGlxBagOCdpvdxTbdrB1idDcJfXgOEyL?=
 =?us-ascii?Q?yVjMMCVo9j7fUjNgY/G8qGeHCPTd0Lol6XPl2ySNkwPOJNcw0aQxvREIE0kj?=
 =?us-ascii?Q?bT5MKPlTi+yIqKnRP1xJ2V8nHXufnxfsdghDIB6PfMZi0EIy1f8x+xcnqFwv?=
 =?us-ascii?Q?hPfBSosE/3/ZUUU9mKq/kn9hs4L+0cKjShZT1NtzsGasVM7c5b8T4h+CK8pb?=
 =?us-ascii?Q?YE7Se42OIHJVXUs9hxcrFKqGCswHV6QlL8hqoidiIReUHUyhZctkFPXR+9sf?=
 =?us-ascii?Q?6CR/qEzBKtziJyIKQ/qIYdfhm6qsFPz203lk9/egbEBOZBEfQZL0TSb5poWj?=
 =?us-ascii?Q?Vb6XT/Y20zzB+vSoQG2Xeye5Yp0cy+TcHwW5uOqzYm6hofdW/D615cr6x1nx?=
 =?us-ascii?Q?vtB5p9110a2PGgB4dgkLph2P9UH+hWwM92SjTcLkji3l0hEw8N9OxX3Zwv/o?=
 =?us-ascii?Q?6fsuFAzpO4kJbaex1BVvzElLCqv3nGgefQZMzYj4B1PwoRMnyX7dvV3Uu68v?=
 =?us-ascii?Q?3bpkjbPnqkWS/rr1HYR4vEjlctiGRIMSOxL2pBzMYoI6+qqtoNIUkK6y2uqs?=
 =?us-ascii?Q?ykDER6tO8ERB8FIgkSioqCXpqXlZmksJROjLUFpOJ34aTEWCJ08aOgcT+gns?=
 =?us-ascii?Q?wlQzetTjl1bbFUcidc6YmuA2IdMEFUEezDTRX6QyTBypCt58twsHrq/cRWN7?=
 =?us-ascii?Q?MXijQvMl1Y5nflOJjhDrNfIMCHxAyqfTGF0/XmGd6ywXzM2AA3REsrpypHef?=
 =?us-ascii?Q?RnhNVJjsGmKBGEVIhRtTc+mCzTPvEF1PAdho9IowJvgFgBPFfm4a32dQ1PkK?=
 =?us-ascii?Q?FCu3gCWiKt3UYOlkBNeKagcUEzzp4YJSMaeeZHtDGq/GGch9cLckA38O/UwL?=
 =?us-ascii?Q?g0XAYlhXKfeJv5KnfomycgwYuvxksRbdyAWXC1Yo3urUi13WCyZrqSNsPjeI?=
 =?us-ascii?Q?JA7XGHfwuDsNPDQua3V8FiO5wDJUfBb/beOogbBdzQuNn/q1Z++v6iwa8KUa?=
 =?us-ascii?Q?tpCzqjriGwLQI/L3slfSIeWcGOc/kjiqgAK5BZmXH1b8GJKnH41NLI/HhVRa?=
 =?us-ascii?Q?Arv2mnWg6D9ZNqIFrOt6xfjvJe9TVIRnMbP1Zioh83HkjEfuH9FDTcPDh7EG?=
 =?us-ascii?Q?WP3SjjEx6RkAhfjdOjGk0fx4lYmwlfz2x/qhFnP8lRpHYTXmJPsVPdj4D0XP?=
 =?us-ascii?Q?ftL3tcow2WSfEzwVAHPkx6qVGTBdnJuULLtFqquqd5abx2Vdk5AgZh/Vdrqk?=
 =?us-ascii?Q?zPd/dyiyeLWt+aaIRZ7nPQbD5UgMQJaNNrFLegqQHifUqicAEOTJGRNbH/Fx?=
 =?us-ascii?Q?WNX9YkkooB7u5P9QIy5JFRs5iye2VHdoTwhiZbyUEndSHTLlYZ9v0B3Sod1p?=
 =?us-ascii?Q?t3XJrNuqRitRxW2QosJhHAAh1v2hXOEb1Vfc+K4AbyriAJXlE7B/ThP0+Nh8?=
 =?us-ascii?Q?HT3OxitquIXzZics47nA0GtF+4RbHemBB5h+2uJcwFR6T+EkhcWW/GkOYUO+?=
 =?us-ascii?Q?vxYWyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: myJ+xgIOkQVl9SgmfLaVnOM8XCus/O9iUHslWAM0djidPYnmHT1owATpxBR7v5lUEj1SzQeMS0+JHtOmXz/t5sxuUI+1xWcvI2GSepdzyhHuA+AysrDTBabDfUvpGwBOZ4QE3Qk7QXHUqDQ9OzMCcJOTLiGFO+ERg0kRXsiUkAdIMaaDW5q/HdUzAqeOT16eKuOHuB7QrQMx8JoRxtiPGJbO31xG1b3Ud7+KSOxisHm7iIYm0qhXP0synekd75R2rPAdk+2CTQnCML5Qr8NLeZ36pkD4VTN2iySZ5PTAHo/2O82gx45ynZ37mfocm1Yq1AyiKd9sdgd+WdJ9zyA18UKEeTmxAQfLsB/nDvAuPTqHb4x/Mv/YEiiu3gV1x5TpNoua+vRWptTo84kL9g2mtz09zXs06+qTugNVOEGGWzQJ3qlPsQAUlTqpx3JJmXSy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:43:56.9466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1feac1-baf0-47b2-a472-08de63a801d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

