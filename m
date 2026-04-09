Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD579E98FA6
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 04:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B8F10E0DD;
	Thu,  9 Apr 2026 04:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnNY4SrP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCB910E0DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 04:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7Nc2oFcUhPAI9qBvqWXX+Vmei+AQkjsebBNijL3VthMS7KtURzl22Go7Ez3aaXFHyWCtwxK0LKH8uwHROvhnlc+OPoMhVXSEz+1Fjz9nbfhzUDDKDvhWtushgSSzWsYj25ugvppyOyC8NNsmO/7HQARPQw1KoSHfnNPPsiIGozZAHeXZi3aBskLknltD6EhAcyh3IN8b8dTWr9R8JMTFPvC0sMaHUUETghyHVwyH1QXpwiMIlJSTBLMjbGE1yo/QS/4RcTJjvxmX8ZScSNRcQRFRSntWb4hjdJEgV5sfAEQC1Op6TTVTGvHCgad+1oi6ypJFE33m4LdYL6BWSaRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOP/eFnzTH2NEW/VaNwmdpUU8va4o54DeCOrQ+RtLDo=;
 b=f+zIakXkAA+aTeNRG17Sx31Cu2zuHyDzOC1fzOvu5E+P7fOXKIIz6o5iDN0CgsyTLWKX6Y0ay2hTmY15wkthVG0CEgh7cTGnuVjgbhqjz/G32YQHXtxUiHFz3y15U4UmPOC+HDZoWC+aVbymRn+rCtJ7Iwobw/LUJnGj0Y1/JBVW1ezlxxsmFdZhkzV+j4b+yEhL5IKnbe1EADLQPM6zMLxbj46FpKD4aN4NadIjmD/iMAR8362skzguUYCoF+g8popsRe79WFUGXgObH85M9M4geUUGfABIxPqZWjMKrSHJF/6c5iEnmnugpVXdu29XwmK9Xc/o50wzLFXSnW6BIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOP/eFnzTH2NEW/VaNwmdpUU8va4o54DeCOrQ+RtLDo=;
 b=wnNY4SrPUV076irkgfC94fKnMLaP+ZTuJ72slmcpgUH+GH78wKh2oIvVtNZEmFq5gwgHziW4M4mz76Aruli0F0F0RL//r7tB986if7Ls4GgDE9oiAn0WxRh9m8vXxF7MEmMwNXukEkbyC+3nn2oZem9GumUR333JbyW058RI+8E=
Received: from CH2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:610:5b::27)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 04:12:22 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::f6) by CH2PR07CA0053.outlook.office365.com
 (2603:10b6:610:5b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 04:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 04:12:20 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Apr 2026 23:12:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Add missing firmware declaration for PSP v15.0.0
Date: Wed, 8 Apr 2026 23:11:58 -0500
Message-ID: <20260409041158.1007373-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed3ebab-ab50-4213-81d9-08de95ee320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: z7bjOBC2NaAs5PWg25UzxdvlOwUdBO9WdaKZuaWKYbjZZZVQnQA6+KvsCM7BCFKkAmS3+jTwooyV/ppzimSU7/FjZmtVobgLbD5NjuIWMFtqT80Wpj3ZQ6AoDAvtrrnSRHsj63MLZPu1Lbt7RoGc7Eh5d4F85TjJQvCp9baOOq47I8YwfJNo59SaIY0oqWjSsvKIKlogPXwpftRyekjcVqNMcYYX2LyDw+wpIWM+sVg7pEgPtfJx6vlU7l99GYgLg0EPQXSUVyor91zZkn/n29C7eBvHqr8mLCD4IFnbRN6anrn8TxiWwQ0FSn/3cm9J8PKOfuvssXULa1/gBx2LQdteBiXr0rdi58F6ERVQ1Z9Cfvgezu9jyjt95MXWuWgMQAZTryYWBt7DEZ06TOYRt1isxIrtiudmDKo9CP1/SrniEV+Mhw2uH853KP8+w2xRXIg5qu4Ls1q1TwMqj/U9iTLaL1IGPuUb6WCZ1rYB8s/i6O8fbYdFB9/B+tamH06zJwZDTr7z7WeKuDb6HfzJ9wMaU2oV6/k1GSNJnJR8hg1h8N3eZYzGk8u4iDzSXGoMpfNUHt+ie3rd3klHz3WAXRPSKU3+HYXdIEaTxWeleJvbrY64zXqNL+TKaAWH4tYkjOQHQufjQtoHzPYsHAOzKrum+cyL84OjJOdEB2HL+B2dWj4w7c4q+SdJmuFFqhQymtSIomFIWZjpqUzrVfiAzvoFqbLkgV/gBRZRVXNJnusggHg9TXwq10aYFHxSAv/P81GX0iHc3cWvUjNXNOTTXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +jeklHJCQ3WOB6a06tEbNFWyeyoBqWDeDjI+97sENAgKfNad4Q09kYsdF46pPgyNo/WXuVXFUxNwF3XrdhrBBZ/hFULeVc31hFED6cPS8ptKSC7B6OsoKPN2+Z8Auf147Z3G1/JrfkAFXw2f2ZSE6PumdAxy3rfDjgDvFA8xxySXVpg2DlzcRO2jpiITe2dGZaxg8p6uq6T7OOcZD8dfowrItPAGsSol+Mp/p5u7cxSnta7nA+OL0dRjvatCxM2O7tC5ts5waqhrLA4ixwKo8bhb8ic8EK0p+PC+PSZJKdY8EysJsXlMNZ2mbI1G4B4+FkTpQap8sL1Pwuvv+urvjHMOjOeg76Py3He03HycG7SFbS1irirx2xsEoC+/08T8m7a8pCLk6uBKcAkdpbE7SRLkeVAuD8NT9rtZubYQ5Rnxws3viuc26TELEBynszFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 04:12:20.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3ebab-ab50-4213-81d9-08de95ee320c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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

PSP v15.0.0 needs both TOC and TA firmware. Without the declaration
it won't get included in initramfs and leads to following failure:

```
Direct firmware load for amdgpu/psp_15_0_0_ta.bin failed with error -2
early_init of IP block <psp> failed -19
Fatal error during GPU init
```

Fixes: 9b24f63d825e7 ("drm/amdgpu: Enable support for PSP 15_0_0")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 73a709773e85b..2a8582e87f2b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -32,6 +32,7 @@
 #include "mp/mp_15_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
 
 static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 {
-- 
2.53.0

