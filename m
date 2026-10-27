Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5B606A324
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JmYTKMAf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B917A10F5C1;
	Tue, 27 Oct 2026 14:21:00 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47DA310F5AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 14:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3hW3B3tANcznXL678jOaM+3roPZX1v2jgFhxE+hwZE0oh4i2tpo6xhTD+hDLO8d4D7cWrVkEcVhGvU5drXOpaiKlBhsIGgbjpQWe+3lyMAZYQXrGU/1cSbPW6IrLGqQ5i2JmzBEEmK8Mx6CS2l89x+o/0ySCG7EFtIng4H6S7ZSvU9qvgPh0CQkWCNntFFJUX4XCe2NvvXoOJdOoy4QxhD8xkbCjRM4eTfwnvRLgvWnhzUJXdUgcwCdnEVstUExsfrK9p9x7kgOLxhYP0g9MXWWLGApt73bdlAk0QoxAyoUSBm2LzIx6UAs2cgSYa1uZcLhrWFXNu8lBHG7I07cCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlDlL087ufavkOwC5FdzEUBc48cAUGIyAmLeoCFOcMs=;
 b=pcG7tIj2SyI4GQl5OTlrGANTBFORQDz95mPDG7ZKqlG3K49zCgpAp8EkHQP6mzcKeTTNgiVZTdZ+inNw3oRc7b/p1EZ6xc/RufrRGnLdk5osUjVXPxWdRAJza+mecSWmohBj3A31n1/bXnp4or8kE0WadoBWRAwslRR6Y7QblveXJq0t02Z/vHlydMGQooyJqpqCY93NdQsxt0v/g0JUex0VUmYjszpIQ2nR0wSy3brXfCqv5F6B0glWl21MT72KvXOoq6ghMlyzHl/ikOV+9cHasWjA0Kk0vTyHk+qFDZfZOQ8lHjq/3aew/RKSWTv43+2KasdelAatvTXQ/xHTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlDlL087ufavkOwC5FdzEUBc48cAUGIyAmLeoCFOcMs=;
 b=JmYTKMAfx9evnnfbQnyapd/8hrVUVdfbgxWfjPwUmTSmkJhhno7vFZVqsNI3TXX566Wez7yK23aVzVF0yJpr8JQM4MXMp/S37QiBwGGwZtnKmQFr3FZankFY+pCWuHd2xDNil0vHngqyb2GOlaXf6JqomssBCci8CfVk+6z0El8=
Received: from MW4PR03CA0249.namprd03.prod.outlook.com (2603:10b6:303:b4::14)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 14:20:46 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::7f) by MW4PR03CA0249.outlook.office365.com
 (2603:10b6:303:b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 14:20:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:20:45 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 09:20:44 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <arunpravin.paneerselvam@amd.com>, <christian.koenig@amd.com>,
 <kent.russell@amd.com>, William Palacek <William.Palacek@amd.com>
Subject: [PATCH 0/2] gpu/buddy: make range-biased allocation independent of
 live blocks
Date: Tue, 27 Oct 2026 10:19:23 -0400
Message-ID: <cover.1793108566.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: b8967317-50ac-4091-2123-08df34357df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|10067099003|261021121427099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: C4/RxpjvYb/t4+OGZFjseE2Pk9/Ljw38kIZDvnutyR0KQK4+R25F+iDiQMN1E0PZGTBejoFwGfak4kSMNQzUYhzYFZuWeJnCvrRTqb/01FueFj4SXl/JIK3T0BAPhH0wr3YsOwsLigH8TcLLFTt/AUE6RLPCu1ooGNmc/TgIA3vGpL6hSy5mvWTo9dgkFHCHPKfAIFYugXp8FTZ9lxnky4AqVOtJWRD5L6QJQMqtK61CexAQRNKXizubYSkYgk3IQ7bymtFDTTmnuDv9dm/RdQ+uUH20AefsdeoeQKDzf+NfiRc8X1pS9hm/13lfPX1zSfwRMgi9CZiywqro/+AZe4VjF1msXgOtMBCpx7e/eQbgmB6S1ZnUf3B/Wdvov9MB9PdNJcJvB6xUHzUhmy8XYyGDNPuj5NVfSJx7kYUsh01BddryROexypGBASA2nRUoLmy9Tp1JBxqHBd+0DM0LbnN0w0IVmF//kwuFKjBXZuQIIXOHiyilENQiyTbOLR1+YCUDJlFN/jGzspjve2IRodm9LnZhrfDFa5yz8VWG4nl1ZkD+OstNXwY4NfjvDf36xsHRsxXmLOz25+fgdhzk4olqCEIFTdiE/eTrAqoSaNr5DvgmW7O2A2WQEivdcEsbm4kFzhM0kLTCuIA/i21ZiYPsCyaplc1Pqz2j55dSSPTKK05gJzSAfle0q/JM0cWRsV36FH5UjbitpOG0X2NAhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(10067099003)(261021121427099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MijzC167tuJWoFipPY408Rs7/00FAdajuQDZhysOYH3IZvv6KWb/xKUEUAaD0jBkYnyKM77SdpJDyimecwsSWQTndqTg9vune64t/JAl7tYEi9cQLS3aD3aqrcYg9jPwKJ7l6RBQgbi7eOs9hQ2dP1bOmBYnSCK12l+sDpF+Xk7o7wwgK5qQZigFR2z/9zW6sYBOAL5RnzVOdfL7FJDlj33uuoExzoujDOg/+ZpH36BDyPlOVcVLlYxrVSdccja8IbqMP0LXs+yj8Z42dbqv2f1/3chJbRPoGEG0zDakWPPFkGKUfyD5VsD+cM3Vv8h6g80Hs0dLdgIPMNL16QgDX3Hu4iXy7eLMs9uE/VBWjBnvSj5Tp7zPsvTfOjdGshH6kkRo7WmL67NLNjB45fLb6/1e0fKbzv/jzSrXiZFt64Umgoq4OHfJy1cAHAtu2SuG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:20:45.9427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8967317-50ac-4091-2123-08df34357df0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A range-restricted allocation walks every split block in the range, so
its cost grows linearly with the number of live allocations there.
amdgpu restricts every VRAM allocation to its memory partition under
NPS2/NPS4, so on MI300X in CPX/NPS4 KFD allocation latency grows with
every live BO, under a VRAM manager lock shared by the compute
partitions.

Patch 1 looks up the lowest free block inside the range in the
offset-sorted free trees and restricts the existing walk to that
block's ancestors. Patch 2 adds a KUnit test for the NPS4 pattern
(range-biased, cleared, 64 KiB): about 1 s before, 2 ms after.

This is based on amd-staging-drm-next. drm-misc-next no longer has
separate clear and dirty free trees, so the lookup there needs a
different form and will be handled separately.

William Palacek (2):
  gpu/buddy: find range-biased blocks in the free trees
  gpu/tests/buddy: add range-biased allocation performance test

 drivers/gpu/buddy.c                | 36 ++++++++++++++++++++++++++++++
 drivers/gpu/tests/gpu_buddy_test.c | 25 +++++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.43.0

