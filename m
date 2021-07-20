Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CFBC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD5E60FEA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD5E60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96CB6E43C;
	Tue, 20 Jul 2021 15:44:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177F76E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVthfSupWcFGExkmbIJCLUqusI8w+JSbvrCOX2iHCxIU1/WDLozUv6b/OXCZdSXof/lNj4lpabLSRAXo+64svzBtiy3+Wb316L63rGs8a1oWaUFZ5jIGZSi5Q83mW3V04UaeNM5ZBuzXV4ozQjqJAThPO6IHhOD5mJhnLDjed3U9YFVXkgJZjbfI6wUxr+0vQ/Sl1k8tNDlHkVekN2XAoInBdrsrcOs1kT2OXuDsVyYo6diuZ9nSgcKJaysxvcSJYubYFat5DqjzsY5+KVjsZLCIkwrIWFYWD4EFa8LRlln4y0jRCtPKOswT9SakEi+0GP3bTV8h4sYeB4SueBwEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4rb0V2WqiF9lBjuEHE51knNDqYTPtXtj6KuMBKqNHU=;
 b=LHC3NOnuuUFUcjAbQaFGcMYBMM+8JYmg6AvGlXEkbV4AgQEQICMibeFkcafvv7yPovqiXAdxmELaYfg6bA1vitopc52aowfy+yUV/5KT/QfNLSgYaoapTrGBv+4M8EgmXAGhA1N+Lq5uDuQJ2Vzvw4bLflOZO85VyVHnaSgDmCVeSgecU3iHw7VQXD4r2t2H6cE0HA24almsQBeN7L9XgfQ65zHrssEnGFTnz6luZkIbxVtwoyDzdqXL1MpGWJMM2BIFbxr8q0Jzh6BxMtiBHhj6nOaHTPqezywli+QDhZYa8KejO5os0thD7bKAOiGFg/nhrIgK5825h6MpxD0MTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4rb0V2WqiF9lBjuEHE51knNDqYTPtXtj6KuMBKqNHU=;
 b=RWgSObkIqB1r1zDFQTyumAkkNBM/3B9BkrybEjpO3tAQpjtS4QLQVpcDecNrSAqgZA5FMYvT7PFok9GMYjllzOu9OfYvGVUO00qQEJw7buSPuwBSAsRaFXEZhbjUZSCD4j4gE7X0KeiqqZE+sGjWK3YutENeJWUG9JdxHGKK+Ys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/29] drm/amdgpu: add smu_v11_8_ppsmc header for cyan_skilfish
Date: Tue, 20 Jul 2021 11:43:43 -0400
Message-Id: <20210720154349.1599827-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ef160b8-dcff-4337-f7f0-08d94b95400e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB553858EA1BAD9C2E41B5CAE5F7E29@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpDEE86Et7cq7qUUSLlZDMznawqrZa/qBcsGCOy6iWr05h0PQYd8rRG28S3JwOvnTeHU3kLOS5VnDFxkel5XT928P7qz3nnuINaZI7FA0FQ4FlZot4ckdgSLpdAg3FtJGkiBdde9538ZfHirC0vaodMS/tBLvtUaJ2UrQJIeSQeh/9yneUEKUPY5oGg3wWaeguBgQCkrAaS1NP0rlTgAz+T+CLi5TNUjD25vOBiRhSCUdN+UJMQyDJQcvWX9jVkQp86EfpmDOVS4iUP/849FdVENuuXI6jK9EaOrjAtPgiLbfN/dAGN67iCGyGHcfWIXA+8hW7rtlMarya677aY1tSW7MkTyZR0qJYkjdpvArylmk94PC0ItrXax7JFJM1TegUJqdmwJ1dWkwFoktnClk/67nGM+qzJ6E41BJL/V0te+o6dfxMee15n3kPqMT7sfs1WPaA+tHs6IaCLBQfLm/wAJvZyVHPeJ/0YrYVJaPmX8r3ze4xJ5FdCuvXmxwgRvJReso4bNsUM4GKWlEBPrs6/PaOTTMtpTkD/nQctl/OWURU5/AO1xOhkJ6+swbhPDwKkjdmoejs18YlHF5uAyWipEpgyHu5KjbBOeWW2mewflSMqu3ymICnyPOBKCyAZm8WJmFfATXHcrZSLeSnKwRrsqfzfll4LOmoXmyPfOi5J9+GhwJuMG4zQNU0GEBHqz5prA1npi6XTralliTDDtpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(19627235002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ykk6u/RCQdH6qLYliLNh0EcNtI4aBNiGfbFAZW/zf+5gYxiW/ncHzyxqtPB3?=
 =?us-ascii?Q?FZZde/0gtYS1sFr4mGI3UzpVuAEch/1bucTnQXUdSRKPWzHf2y/pKMgtwdB9?=
 =?us-ascii?Q?N9UmFTLd37CZD6W8l4O/K+urit4U+bpSdBsWuw5LG7jpjdHH4t4+6Lyxbqwh?=
 =?us-ascii?Q?E4N25sjuuio6f4fVz/K7BC1Ekd0gY6OHCFeWRguHPdFm+ERAtwAP2Jgda37b?=
 =?us-ascii?Q?Q42zftCsKSkgklyfCfM+0wBo76G+WKVnmi7xU2uevHYjLmNgXqCHFLGZQDTb?=
 =?us-ascii?Q?WhITlJCh+IvQTNlYedLK7rdXwqzj9CDiHIA/f2ZzdjWIPXxQqhelDlP6SX08?=
 =?us-ascii?Q?XStyaHE9zIKQdWj2Wxv4rHFpjVXtbUsVKYjBvn0yIcbOv0x1M4X/j/F09cXx?=
 =?us-ascii?Q?2tjtVs514s0HWgSzOcsdKNYyv6ySh4FU4QEb7KI+g5ZMwB67mhsAhl3rEYYE?=
 =?us-ascii?Q?n1PjChtn1hugTQ5xNKHUi9pmEXnaG89izYLr6LH8k4d3K8J8aNstZ6etfmNG?=
 =?us-ascii?Q?2IIaVn+dz5VpCWfxBebVCI3Wl7U/garUJUTFmNKeboRgDzM/VbxCTJQSy2NA?=
 =?us-ascii?Q?NDjQQATZ/ES7a2D8E9fVqVKoSAwl/w1ALxjhMTnbrs4Lazm26kfhPkzG0EGo?=
 =?us-ascii?Q?0kAWzgsP+S8SKrbvrZk+vnKgQgGkqN/c2Ji7DEMRpDL5ZD2UAzd1SwpG3azA?=
 =?us-ascii?Q?IxwJbpBB8WKud4E6Z9N37Ue5Sui8qmgjvpmWjXoUA9cCJ3aI5u9RuhxeZ24v?=
 =?us-ascii?Q?sjPbJuTIcZZcuMbQSc6lfx8UFcDbo3tkqUO0GYmdZRdtnZxsFjRwcCaEAZBW?=
 =?us-ascii?Q?eDSoc6qJIWiK2BSnhXYvW351NwOm88ugjKPSkGFZUqAMC+QIdOimY74kaI5w?=
 =?us-ascii?Q?tHqhlXxEsORm63fbxGs4NhRrL0IOLnTLH1+sItM8wRW4CoheaWm9pIhEzHLN?=
 =?us-ascii?Q?z9RLYzGejlEj+vM6kYooVhAGM2LR+X+tuJDunaN54rLTTLFHlrmd2btZ0AYT?=
 =?us-ascii?Q?thujtQqR7ufDnwem3urIXqW2Sx9ToMCulFuMpfvLu/ImxJUFBG0w2UABgSCx?=
 =?us-ascii?Q?TMsak1N0+TC+g4qax2n2biJgCh79kSwg9jNdgB9uAXTE8i7qwUKOGmQNykCc?=
 =?us-ascii?Q?1bh0iRDGUvrcbQJP2sUU1pmDEknJdN0IPYulWtWTY0W49Uy3nbMNJLuCTczE?=
 =?us-ascii?Q?Pu/z91KonLXNTXkLHi89uNlKfd/AJVmkzvaMDy80rinncS9oEQYpHnXNOImh?=
 =?us-ascii?Q?8ub2FwfR76lDCyeBpNZAc8LlBJZvxm8gv4Tq/L6mLzkVnGr5eFczAeSqG2MW?=
 =?us-ascii?Q?gwsq4G2D0FkC2R7dsrzp+3Mm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef160b8-dcff-4337-f7f0-08d94b95400e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:24.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue2eteoYb4aaSQTvjQWZXwrCXaSXAiLzPddHwr17y7DMX+XL1HmiBp6GetI35vSh4A6E+dnxFhMzdBmCtRd1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add smu_v11_8_ppsmc.h for cyan_skilfish.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h | 70 ++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
new file mode 100644
index 000000000000..6e6088760b18
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_ppsmc.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef SMU_11_8_0_PPSMC_H
+#define SMU_11_8_0_PPSMC_H
+
+// SMU Response Codes:
+#define PPSMC_Result_OK                    0x1
+#define PPSMC_Result_Failed                0xFF
+#define PPSMC_Result_UnknownCmd            0xFE
+#define PPSMC_Result_CmdRejectedPrereq     0xFD
+#define PPSMC_Result_CmdRejectedBusy       0xFC
+
+// Message Definitions:
+#define PPSMC_MSG_TestMessage                           0x1
+#define PPSMC_MSG_GetSmuVersion                         0x2
+#define PPSMC_MSG_GetDriverIfVersion                    0x3
+#define PPSMC_MSG_SetDriverTableDramAddrHigh            0x4
+#define PPSMC_MSG_SetDriverTableDramAddrLow             0x5
+#define PPSMC_MSG_TransferTableSmu2Dram                 0x6
+#define PPSMC_MSG_TransferTableDram2Smu                 0x7
+#define PPSMC_MSG_Rsvd1                                 0xA
+#define PPSMC_MSG_RequestCorePstate                     0xB
+#define PPSMC_MSG_QueryCorePstate                       0xC
+#define PPSMC_MSG_Rsvd2                                 0xD
+#define PPSMC_MSG_RequestGfxclk                         0xE
+#define PPSMC_MSG_QueryGfxclk                           0xF
+#define PPSMC_MSG_QueryVddcrSocClock                    0x11
+#define PPSMC_MSG_QueryDfPstate                         0x13
+#define PPSMC_MSG_Rsvd3                                 0x14
+#define PPSMC_MSG_ConfigureS3PwrOffRegisterAddressHigh  0x16
+#define PPSMC_MSG_ConfigureS3PwrOffRegisterAddressLow   0x17
+#define PPSMC_MSG_RequestActiveWgp                      0x18
+#define PPSMC_MSG_SetMinDeepSleepGfxclkFreq             0x19
+#define PPSMC_MSG_SetMaxDeepSleepDfllGfxDiv             0x1A
+#define PPSMC_MSG_StartTelemetryReporting               0x1B
+#define PPSMC_MSG_StopTelemetryReporting                0x1C
+#define PPSMC_MSG_ClearTelemetryMax                     0x1D
+#define PPSMC_MSG_QueryActiveWgp                        0x1E
+#define PPSMC_MSG_SetCoreEnableMask                     0x2C
+#define PPSMC_MSG_InitiateGcRsmuSoftReset               0x2E
+#define PPSMC_MSG_GfxCacWeightOperation                 0x2F
+#define PPSMC_MSG_L3CacWeightOperation                  0x30
+#define PPSMC_MSG_PackCoreCacWeight                     0x31
+#define PPSMC_MSG_SetDriverTableVMID                    0x34
+#define PPSMC_MSG_SetSoftMinCclk                        0x35
+#define PPSMC_MSG_SetSoftMaxCclk                        0x36
+#define PPSMC_Message_Count                             0x37
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
