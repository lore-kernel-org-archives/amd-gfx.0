Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49205CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 02:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095F910E07A;
	Thu, 19 Oct 2023 02:30:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9DC10E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 02:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIRtrMH7p2J8y0VqtGxysyzXV9s4dFBYY731Si9d6nIu0YmBmm2V/ItxwIB74TWZ4GnePrjOZESkWxr7/Lv8I8SxGz17+05U1DKnqKrlocs1a+qSC4QSg3BeOLKgeqrioi7KvMdQQdzYjrQNQd2p+YG9FfILXp7zW/0l/+z8lLlVAkgXNdBSj9h733bZQXKEGrpb2W9Tocy75JlwttSeTzlk++U74J/jQgCxd75N8zlA7moG/6ekFuh4it730ykh9ZbcWBphV5UC55wmcJuotzNK6EEgI8sHJhL78ZpHLa6o4OZDq424sYfEXRHGuT336JFft2y2Uw1Pphy14vN59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL1lKFj3rd07SNjSiDWIKh2IkBD/AkRlDVTLwfri4Bg=;
 b=ifAo+yMbjXrttxvZYlWC6bvosu5tqJ6Yseil2TxlPj6DHjzrDF6KG79YPdYpSicO8IzYesiC3sPssCm+G3fTMFOSzDshaKVe25QLAI7nJOo8AAuqPiLW8u1r2ggbeJQiYJKr5+Tt/KtMiycbFLCzKeHCKLrsIe13t6G0VtXHVfOeONUtuI4CdJrUImNacgNGOfNZaZsqxuSEx9ymTfrP0n/rJCpiZ8sO03rX3ghVtOf7ZwyuuLBnXufUwNDHtZAE3OF7V3mPZkAJzoH6tULtEQeA1hqr/ev5bTSgPSULJIZi2gIm9eBVZAIniCoyFpLYl6xpw5n0hGcYEWeFGPqoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL1lKFj3rd07SNjSiDWIKh2IkBD/AkRlDVTLwfri4Bg=;
 b=JPdlZQMq68ezQt/AOj5pUC9ZU4ge2pNUE46o8xve2wLreLhK3qf5pLYD+ctnj1wjmI5+r6gKvuFRfVQymaTZUDejVQZ3oe31+ahAe7D0G8fAytHibJVSfolqkmN9Hrt1kSy/xJJRy7WBw908aoN20fP7StU/lbB6rMaJrhr+2rk=
Received: from SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::29)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:29:57 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::9a) by SA1P222CA0184.outlook.office365.com
 (2603:10b6:806:3c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 02:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 02:29:57 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 21:29:50 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/pm: Fix the return value in default case
Date: Thu, 19 Oct 2023 10:29:25 +0800
Message-ID: <20231019022925.212867-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7ecf63-34ec-4974-e00c-08dbd04b493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZgtOlMoJippIP+LPempeJXBoVFkfSeEyWel1C9ZufFpgwSLANHzM9PccCDLiAHKMbQJBixIp9gB3MqodHlZwcJzPDtee1HVI4XmlSJl8VzfGWPfZ7N9U3Mq6ETx/hDdfEXM4fIN70ICLr6AzisgNgHXYrJ8lDVzVWbG1JgOHCfVJ1LoB1nREA3Xf0G3IeyLqMKHcsliUKoR/gDjJSJ9b8Zp5kjRk2tTl4uuioPARvERoF+A3qyF4UjBnO7Ghp+LJj5U1QJLBnD8ye2+ZIQLhtWPomcDkledV/EUdyqmqJlqj9PVY6HPXt7Ac86ZTdCSeSbK7ozG5z8BHLNG+DEUMMgnPMCkgIxPtKzU64Z6ARaWeWi1VZjOQH/Uu4A5CactowM/blFPaw6U+ueD0KrN8P+ztv3sLLyukQWjX6mT39wgJ91xXAAxlJ2Y7/7tFvbYdgxAEN32wYT0MLd/lPCFlGgDSMYGeitrOCcbsV6R+NygKw/uO7iRgJsK71KHvKL/n6Ds7bKGHS53rv91LjC3IM9+agTHNkbAbPtyCNhwwHGKj6+pEOJc6HGyF+M32brfB4oepjcdCcnXn71LzChW6rE+PW6CTtbTxyt8Bi7NFxnkbWQMSlZMWxTzsaZEYjzAcXb/T2xlFLj07QBx6Lr180vx8GO7CbwhG4fmRIwhJRpVVdNY5pCP/p1GTXyKLxctTMPVsTfr5GLaFp/OnaZBQxVi2gI8i1OfJHX0LnSHRjRclc0Ox8UpwgRsdsrjydNZDjVZVCfBss+7icxh4Mvs9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(40480700001)(40460700003)(36756003)(2616005)(81166007)(316002)(54906003)(6636002)(86362001)(110136005)(2906002)(1076003)(4744005)(70586007)(70206006)(5660300002)(41300700001)(8676002)(8936002)(478600001)(4326008)(7696005)(6666004)(336012)(426003)(356005)(26005)(82740400003)(16526019)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:29:57.2373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7ecf63-34ec-4974-e00c-08dbd04b493b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the return value in default case and drop
redundant 'break'.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7087f9840ab7..3b4053e2607b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2434,7 +2434,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	default:
 		return -EOPNOTSUPP;
-		break;
 	}
 
 	switch (pp_limit_level) {
@@ -2452,7 +2451,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	default:
 		return -EOPNOTSUPP;
-		break;
 	}
 
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
@@ -2486,7 +2484,7 @@ int smu_get_power_limit(void *handle,
 			*limit = smu->min_power_limit;
 			break;
 		default:
-			break;
+			return -EINVAL;
 		}
 	}
 
-- 
2.34.1

