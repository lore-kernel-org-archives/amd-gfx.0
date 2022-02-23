Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9CEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 14:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B215C10EBF8;
	Wed, 23 Feb 2022 14:23:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C3010EBFA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 14:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB7ZfljpPku6x9PG8bzfmuOQ4s7o/qLQZX3G0ugvWZ5UWcKiAPI8UkhaoYRIxbKmQs3qn7zrHn+ijTduCMKEABmX+FwuSxTTJuM2sLGPsO8GZg6ommojxTf+St4/FOUBRhr1v+3Bdc4u2bGdaL1NloocpbUPOujKg5WkrQxy97EoMpbEsFWiQyQjUCZgUQgKFlNRglm603uRy4FIFAc2G4PzaAIo6UbCpQLK2K1upkx9GAasrSPuP0DaaE5RVU3pQQ44uedIZlbz9RzNVuDomtFoQOOwameCufHlAq2e26+DoPVUuWuX08yrDWU6ZOOVrRGwOIfN6FLm2ZCwntAhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZDkka58d3T1Thm7svcjfbCJCJmC2GZ1/7fT9EwchsY=;
 b=KW5M8IP+UT0NlDrx2yqhN2yB/jIR66lb6BlO5LgkiVfykwcmsH0h3rmeNfjOAqPzEIK7Lms4RS+lfFyuP/dje2avT+NjnsVvhdg0fyZtNuJIG+e0Cl/GjdcSaKm/Upy0LJ1z7MZ0Le+xX1oMvc/joetcgcyTQAnbYjQInKyZv5CMLvYZpOXoYEk3p18zurfVIoZdaM+uDMIoWVOad8Zet3iGCpyfH7tO7cZdiBSA4ODtOLLg67eqTowlVpVSumSlBaM7NCOHaq5lSf5oEge1L0dXqIqkjTzPbmQvSLWVjPVGlRnFniSaaJ+kTr3TwcaxWw755u+DsWg54AoFr3Mukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZDkka58d3T1Thm7svcjfbCJCJmC2GZ1/7fT9EwchsY=;
 b=ms4z50P82orp/xhBoTmWFZSPz1D4DH77LjPY7V6WBo6+HoPmr1R08rCSMvkis0CBRxPbWJhg+2/Albb3r+3Bcc/JmPC0i+6bsQK8CRAoAKN+UFCNr4CMnD3tjKB8HDNZ6H7+ugRFzcE8vrCOX425Q7l3dE/eO5fpnkf/PiV7bZM=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by MWHPR12MB1584.namprd12.prod.outlook.com (2603:10b6:301:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 14:23:25 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::97) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Wed, 23 Feb 2022 14:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 14:23:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 08:23:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/benchmark: fix error handling
Date: Wed, 23 Feb 2022 09:23:07 -0500
Message-ID: <20220223142307.1659697-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c484b8c-df3c-4887-47f3-08d9f6d80d6d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1584:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15843B5E6BDDA34B445A3CA8F73C9@MWHPR12MB1584.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/DMyR1KAzFxX4q0mw1pQRWof62LOqwB9lCfhJMeTdlSDyz3S0fMczM2iuQRnoKGn83/CKDfO+FWRnW2hJPFL6tR5KQZBF/4ErEeutoksgco5CEviu8h0BVTgx3ogtZDlxcm74g0CdKG7ypA1F42F2rtfyk4DdgBEW/YsRHteFCxeqnNiUkeBLWPcfFNtd+ED42+zoiTnDcYXwDTR7W+9czzr0t9rgJAPSfJ9JRcLOEzF4dN0h81l7iv/MUO00On+KQA6XxmRsZvHtwDKj3djwaK5QWPR0frIA8heN9vFbbzT2I6DHgcXwIdTGVbrX8FQHofODAww56IFgOHqwqjvOoV6b1x6mKr9uFDYcfcpzZ8DTWspzcAtWgZYODaytCGnmoBDB2fVLP3CPD9eO/h4tfiaGM1zHl6Ek220gsNGNpCArFkCJfEE5Np6cRzSQkCOgHXELOV9bD5kDcV4eoMf+Ws0V/ZssvTBAgM39r3Dx+sWjhvnsjHE5EjLZ7r6Be1zQVG0ocI2AFbmCS+CkSwkISZ4gE+VZ9pDy9Tn6VBd4krzPHalxST+kfBKcAItbAashSNsI+5yZMVXITOhdTYbmLUHMy7xK+Jdna/PNV5mJd8ATp567gI7+0lsZAqUW0SJYhsclKEZ/gUjQwc4Lpg42EGlqoDLLXdb7Fdrs9mHrHLfAj901XXVI7abTrxHXS1EuFFzLGNLrPUQ0kT+hClQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(2616005)(4326008)(6666004)(508600001)(5660300002)(4744005)(8676002)(8936002)(47076005)(1076003)(40460700003)(54906003)(6916009)(86362001)(36860700001)(2906002)(7696005)(82310400004)(356005)(336012)(83380400001)(426003)(70206006)(16526019)(70586007)(26005)(186003)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 14:23:24.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c484b8c-df3c-4887-47f3-08d9f6d80d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1584
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Forgot to assign the return value here.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 3136a9ad2d54..edc6377ec5ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -163,8 +163,8 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
 			 test_number);
 		/* simple test, VRAM to VRAM */
-		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
-				      AMDGPU_GEM_DOMAIN_VRAM);
+		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
+					  AMDGPU_GEM_DOMAIN_VRAM);
 		if (r)
 			goto done;
 		break;
-- 
2.35.1

