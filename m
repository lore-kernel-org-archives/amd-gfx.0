Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63416C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 18:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1EB10FC47;
	Wed, 31 Jan 2024 18:51:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2EB10FC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 18:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6/wIFZEVgaaxm6SuvQFEKCfIn6dqIwffrk0AKQhfnPN3YSWto/MF5Jh8Vv76R9k0Zpgo+TvBARGFUpw8+yZ3O0dDO/Q65iRrWnK9eDiEQx/sW1PGcDhHVs6NKqUa+vxHEG+hSueG7YT13ykF0mfoiSBvF2eD5ITahcVnlFkiLWoDZdVXoRXdL+OH13owX0VN7oYDVLiFmO5XxELJ50tlrR4skhDvbWN8M2KbuXqjVAQBG3pZ+6mbztNJmkyar6781LIhDlo8MLBBP9S1AkgX12QGw/byY59nG9ftoW5orjsddEOxt9E9JUsrR9nguAZxCHqgA7OU5TZgZ5uaFI4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OXClulTMy2f9WrXPBjQEtgUZhpjAxhvofoJLvg4RXw=;
 b=RHeuLDxf0PpzaKUGGgq/5P3DbXjouQZJSqhsBNjaGSbMgz/jptaXsctAmgfdpWVJtjK/+WBjYqMPg5+h7AexAE4HnOXruKqQhEtGathAPHX0JqgcQQg3dlsE3OxdN4ZGgGcj2Bu8Q/RWqAD0RvbQ/HB+4qvGSPyUTHnXcWNXZqzk2rD7DWuIwAtjbgZzOsUtw9BRIEDML3FDOjVZ6YeZR8Zt1/uGtWOx6wJsEngzz3QmDCiHuc3RAwUP8SCfAKg7VbL/srAvZqZ9m9709ugLBJJYfzKIKsRDzXaRWsiNBYSpl3Y2KitjokvXhbG28Zv3QvBbns2Q06sFn9eUuIUoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OXClulTMy2f9WrXPBjQEtgUZhpjAxhvofoJLvg4RXw=;
 b=I+lRJWIqLmhWGvpJxDMMm0gbYr2vPzCr/8y1Fc1D7j/6L1ZDzRThAKtoo6cpzFo/158+MA+GU5LrlCjoCx2+CSZNIND6y3A9NvocqlYnmw0mcW8nj78ozNdWdbmzBS1Tg70nK7pDlwo+cQkOY+ubEk9+uTaCTGEtwmbKejMRUSo=
Received: from DM6PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:333::35)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 18:50:42 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::47) by DM6PR03CA0102.outlook.office365.com
 (2603:10b6:5:333::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 18:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 18:50:40 +0000
Received: from lmoriche-tr.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 12:50:39 -0600
From: Laurent Morichetti <laurent.morichetti@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdkfd: fix the cwsr trap handler for gfx11
Date: Wed, 31 Jan 2024 10:50:12 -0800
Message-ID: <20240131185012.1265172-1-laurent.morichetti@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a8001c-370b-48c7-b350-08dc228d8593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lkKwLpJeGtWHPTwZ5/lGJ9W6X5gKvcJx4g9tKK7t3bk2Uwv4fqf4rGz8DqmD8Jno+2xy8swb/Cfm05COKqlnmZUuV8+f0mGzkWd/rqhzm/J4VC5cl7ejhZnJjR9q5JOEyFNY1YnfYrlL7drSpjOxz+EdSnSNcoDDMolPhilwyFLxwNlCWypGmYvOaZrNKnfStqy4VxKCukfqic63N2YX5qSCV3OWoxD5DRR4AzZWvPLIA5mciSIeGZYeSXhV5Gb4UEItgml36q/EIU5PkhQ5Jt9QFrhbDpNcnAG+Zh2ugH4CK8Dn8LHSRswMCyqz+HFfgw1cmM9PEsNzmcgB13YkiPV5lXvyZ1+n1YCF/GSOtjBV9wAFzCBNkm0h6agXs12ZqTJiotqobYmXqblyrdD65snaAutYVO6gjX9RqwOMxNHWNfrlT9dRsqVNbyT/VeUFG8EaYt0yhqCAuYLz1Y1pwQZogOoYLULo2HeSmiwo/SjENgnZyfqsSYJzogK1ku20bvJ4T0nir45nxkwJSsF6uK4ubun+K4j1sLmmMQEjTqKpnFo1sW0HmKijehZ2cQ1po/0vEiGWUsjXXbjJwuIDpTW0KwtnlaFIDBix2kjmy+fOhga4W9od/aBD3KlJ33yJUv4lYiOWt5uVjtUe32keVxdvoWwGG2Sk13EmbS3EXdIcLGMCRyOuSLt/9ipUyP4lFnRX0zdJqCJRyUGEBoWg5HYpehORbtkNfUznYsfya06yxYQaCMdh7X+5J8SykoC68akMu8o1mjBa1ez05awYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(70586007)(70206006)(54906003)(47076005)(44832011)(6916009)(478600001)(8676002)(6666004)(316002)(7696005)(8936002)(4326008)(1076003)(336012)(2616005)(426003)(2906002)(83380400001)(5660300002)(82740400003)(26005)(36860700001)(16526019)(86362001)(81166007)(356005)(40460700003)(36756003)(40480700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:50:40.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a8001c-370b-48c7-b350-08dc228d8593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
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
Cc: jay.cornwall@amd.com, Lancelot Six <lancelot.six@amd.com>,
 Laurent Morichetti <laurent.morichetti@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call the 2nd level trap handler if the cwsr handler is entered with any
one of wave_state, wave_end, or trap_after_inst exceptions.

Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>
Tested-by: Lancelot Six <lancelot.six@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h  |  2 +-
 .../drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm  | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index d1caaf0e6a7c..2e9b64edb8d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -2518,7 +2518,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x8b6eff7b, 0x00000400,
 	0xbfa20045, 0xbf830010,
 	0xb8fbf803, 0xbfa0fffa,
-	0x8b6eff7b, 0x00000900,
+	0x8b6eff7b, 0x00160900,
 	0xbfa20015, 0x8b6eff7b,
 	0x000071ff, 0xbfa10008,
 	0x8b6fff7b, 0x00007080,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 71b3dc0c7363..7568ff3af978 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -81,6 +81,11 @@ var SQ_WAVE_TRAPSTS_POST_SAVECTX_SHIFT		= 11
 var SQ_WAVE_TRAPSTS_POST_SAVECTX_SIZE		= 21
 var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK		= 0x800
 var SQ_WAVE_TRAPSTS_EXCP_HI_MASK		= 0x7000
+#if ASIC_FAMILY >= CHIP_PLUM_BONITO
+var SQ_WAVE_TRAPSTS_WAVE_START_MASK		= 0x20000
+var SQ_WAVE_TRAPSTS_WAVE_END_MASK		= 0x40000
+var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK	= 0x100000
+#endif
 
 var SQ_WAVE_MODE_EXCP_EN_SHIFT			= 12
 var SQ_WAVE_MODE_EXCP_EN_ADDR_WATCH_SHIFT	= 19
@@ -92,6 +97,16 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK	= 0x003F8000
 
 var SQ_WAVE_MODE_DEBUG_EN_MASK			= 0x800
 
+#if ASIC_FAMILY < CHIP_PLUM_BONITO
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+#else
+var S_TRAPSTS_NON_MASKABLE_EXCP_MASK		= SQ_WAVE_TRAPSTS_MEM_VIOL_MASK		|\
+						  SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK	|\
+						  SQ_WAVE_TRAPSTS_WAVE_START_MASK	|\
+						  SQ_WAVE_TRAPSTS_WAVE_END_MASK		|\
+						  SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK
+#endif
+
 // bits [31:24] unused by SPI debug data
 var TTMP11_SAVE_REPLAY_W64H_SHIFT		= 31
 var TTMP11_SAVE_REPLAY_W64H_MASK		= 0x80000000
@@ -224,7 +239,7 @@ L_NOT_HALTED:
 	// Check non-maskable exceptions. memory_violation, illegal_instruction
 	// and xnack_error exceptions always cause the wave to enter the trap
 	// handler.
-	s_and_b32	ttmp2, s_save_trapsts, SQ_WAVE_TRAPSTS_MEM_VIOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
+	s_and_b32	ttmp2, s_save_trapsts, S_TRAPSTS_NON_MASKABLE_EXCP_MASK
 	s_cbranch_scc1	L_FETCH_2ND_TRAP
 
 	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.

base-commit: 5c75a8a293f3e8f31e5ac10d3a6b87451028e5e6
-- 
2.25.1

