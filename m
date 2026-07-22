Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9BAC4451C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2026 06:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92F7910EC73;
	Wed, 22 Jul 2026 06:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFoJ5CLy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E0E10EC73
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2026 06:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltiMOWmVvfpB4HxKVLQsK6z2WIxP947+D/FuSxDbGjwN3P5McEVpbV11WQFyq88031efPRBGtt3y4bKVfZzPr3zBD4L7i3vYFUXbkhUbBTGTk/nKpxN2fVoVRS4AteEmkyHeXg8CfQvHXZdgu335YqyFSsrm1DmxE+oVjh9klKQhfKuv0D7UoilB7AWr1ie3hE+BuPbXXWLF3Hptr3bH888KrHCIaxvWO7AbAstqjoyuZ/yBVPDqu9Us1l5aTmVstK2XLXuguUI23ACGdGrI3mYjDyngNjk6f0bCS6CwnMu31faslHDH89r5ewIYLoWZs3dMAsYDYYx/KIoIYgDS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHrrw22RLdjE0sakRQ7BgTQec6x6DB3Nrt83fWKHgdg=;
 b=Oi+jGydTBjsvjCVoVFqd2/iPfig8KDh9JEgKGA/IzrRLD2c5r6zlL0dQWXmnlujy0YNhbGbpJn5DYpSK/qwA81KgZ75TsyzsReoIkj0BK74MIjabDcFnx1QvLjv9I99YQBxTzGLWWn1oTaYZ7bWsX1EGYJKViRRcLywscmgeHZK1TLxtUACJICZxMJUrXmStUSuqMhLO2KxtKKnf8QWgFLrgT3pZrIwoeof8/odrObVKfiWS8N1Sm47pLnjDLFXhwbbkeyD3ypt7KBltAiDGil9Ka0ZPRgv3MJ2b0OIeP0zfyeccf5T0Gh87NFPvfFxveVYf9pAPFxjZfAbKk304Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHrrw22RLdjE0sakRQ7BgTQec6x6DB3Nrt83fWKHgdg=;
 b=BFoJ5CLyO1uvirZESr9eqVUm833mSl7gDxRD4MssNrcIjI1hR13WdincKThMzaGPUy5ixur9Is/vh/DOjYv6jfe7wkAGOfM9sCjG8a7IczWwA+hDzH85nNIQo0p4eQKve+gBHeqi2UIoivzEfWb9l8o2RY9j0W+/+Y5Z1qW4bHc=
Received: from BN9PR03CA0400.namprd03.prod.outlook.com (2603:10b6:408:111::15)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 06:56:09 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::3d) by BN9PR03CA0400.outlook.office365.com
 (2603:10b6:408:111::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 06:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 06:56:09 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 01:56:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Fix warning about helper function use
Date: Wed, 22 Jul 2026 12:25:49 +0530
Message-ID: <20260722065549.425085-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 01498b08-42b5-40ab-23bd-08dee7be4f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|13003099007|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: FmNKumb1jrZGWAYCCwxbbQYiuS50SXOV49ypDSVLmRY19dWdkn8NlsHIE4X1PHJCWN/gIiURqeAkIvdwdBWIe4476bELTLbzvW5kH0djBxUSWyPd8eS9qhn+epWba/q0sPatEGFlKYVRzNgCFPwoLSQWh1hP02ewSQR8/eftxFQ9b89aILGXIioa3lHJPG7f+YCPVOzP+lCIejfp7XoxIJ2XWj9F0zoUhCVve8P+E4tP9x9vkXGzQX6vBtxvYtBF0ZioDcZ15zJ8XA42aJZNPOalrkiQshHo3a5C/NQE4Vqd/ct2lkcdas8MkmdB2JG9RtnBzWrDz60HUHTlBMWcRohyg94pp2S7uCFbad9THmxcR6/xaXuesQeGfzzXx2JyCyZYKnu2D/l52AGfqPOtcQQnxm/gLw02886gbmHbIIjKv9XtV+V/gUK7nvzc9Zmiotl4asIcLzUxHCtsGbB2bSoHq55ArLYCBwOkD6bHTa969p5/k4Co4fLbIzJrvUVfVJL1+kOfNdPiTl5UYTFvSOCiZVcuOPY/o7VCbgXpn23jB+ToLXGNxjIf9chxymY6t25qo2xnsDu5ocXnX7+2NmobIp6mhSF1Zw5UASbuDTNN1IuUu5K89jLHkChzrmYcDgJ3E3uPCyzUxGHGxah1BqRW4IcAN40OA8uZsrtavNz8vDwgePe4kYe0zFLF31s+6N4aOzEwXklmYgyZwSH2Pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qZDEEHX1wejWLZSoy2qkCJNNbyxJqPDjHaJN1Rl32ho6czf8aIKGXKgBWTycHlGCWddiaoLLsYYj5+lrtWVonurFd/gsgZW1AnG73WmiFF2WK5GtfmOMFTK4MDFg8XUpRVW46El1I+0mBNSCJOqwXi5gz7lPcOvsaLLlLupNlbOSNO1qsgmhkk5yEYZyoV2d02bGZrm7hvUx/7tlyZeeMgZ1/RNdszkw93m/FMeOUwxt+sf1f6q7QGc1pzsTS9k9EItzfBRFLN4Sg7RXiPV6x9O0O07fdiKy9qkVRLhmtMsoM60lGj4RWZUEFxU+H5K+QyVproDLKsdsNtTSVmDRGn8pZpSiliKUSecRjqMjLOeA5DbAjPyJ/GX3WBSk5UavGDSS+aPvis7LS6exxXael8rHyVxqNXbmTPjegiLJynErKEJySSpnjWZtaj+vvzls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:56:09.5222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01498b08-42b5-40ab-23bd-08dee7be4f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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

Use str_enabled_disabled to fix below warning
drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c:920:3-56: opportunity for str_enabled_disabled(smu_feature_bits_is_set ( & feature_mask , feature_index ))

Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607210737.OeGpY3kI-lkp@intel.com/

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 2bd3ea17e789..764f943df5a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -965,9 +965,8 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 			buf, size, "%02d. %-20s (%2d) : %s\n", count++,
 			smu_get_feature_name(smu, sort_feature[feature_index]),
 			feature_index,
-			smu_feature_bits_is_set(&feature_mask, feature_index) ?
-				"enabled" :
-				"disabled");
+			str_enabled_disabled(smu_feature_bits_is_set(
+				&feature_mask, feature_index)));
 	}
 
 	return size;
-- 
2.49.0

