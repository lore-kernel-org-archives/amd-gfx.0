Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CDFC636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C748601FC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C748601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108686E442;
	Tue, 20 Jul 2021 15:44:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F96E6E442
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmcSDkUxjOP791fM4DPDVePwOe2z7kW/C/0fvx+XtnLOrtA6dhdxoJbRI/xisNzSzTAMpV8K6Zic8RDXCszybCuemfRKf7vffpZegfTDfn5l9kB0rvTv/4zjQMte3l5yWeDG0qFLHRHbH11RXi/bMtWOTbBDSGFWQLt7C400iSv/jvO9FKwfm88QscSYkZJxRwy7mK0Myojkkjv8WgQh7ZF5W5PSbKbzyBVqubRTT7trV1ARlF4Ew7u+poJgmTh4i6yb+R+2h2BlfbXYwBHjYHWrnLiWVcaZTAjKw3rMUvons21KU4EQmlYsWgVbPuGX7mBPYkMgzpRLkp4Wld6qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmzX8E1HcAvtzovmV4w+KIiXwO5KV6oDAePKk66UFGs=;
 b=SRJn9lubOMNVCNilE6tEhR48sH974Obre9YnoXGlOiqGWD4SYPw+pP4cSFeAKCwFUHEtqMJaI8s6yPQbU6eS3Wb/sZqaJQzZNDovs53pzTpVGZL8I3+S/Hbfv/JCr6hphASbu6Lm5rjiNPnIX47liz1JFqoYVUuvVRj6iotJXZczGnBngXhyzeNYjTTRz7hzW3ENk6CtWOly0I4kSI7lKvLShuV6e3g1zSRATRYd2JVPXo4o1/Ed4QpSDfLTF5DQruBauNlvxg27B9bvJ1y99QZ9ybglwia2d1LOs1c3KzzvkYlK4Ko7y3TtDeW6CUtFGY9pTUOEccYV78HdwOYjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmzX8E1HcAvtzovmV4w+KIiXwO5KV6oDAePKk66UFGs=;
 b=q83PIxXAcuDuwBQ3fpC8MVyI16PdjskiqhZNDnuRIC2JTwIuF1ytRQmOWOLm86upYH1KaR3lf5NR0HrzL/7QnGDxpqsr2M5aNYfS58FVE2MGehWkTzKYZUOTqB8SEoZJwbbisTqs02AM9YWdycbD4QfXX4S2hIg6fGhKmYZkdSE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/29] drm/amdgpu: add smu interface header for cyan_skilfish
Date: Tue, 20 Jul 2021 11:43:44 -0400
Message-Id: <20210720154349.1599827-25-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870fe51d-eecb-4754-546a-08d94b954096
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55372AF466A35EB7F8B242CEF7E29@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5BuS1HSxHKcTg1gau4OVCLH2imXc3vTi1uHg8qvJc1pTD1zQR0Qnu2gYvO5XmRdMxwqxeRmfP9BZcis3kKhS7qJlYNZW0xKMKBrNzGo8uN9CxgDN4Bt3r+Mc/jeQ20u3BzPXQDK42LcjwRcm5CkqynxUk0wuUekldFPX5uBFLugjk0VrYz7MionUCztmydhsGlq+et+ICnlw8kqIRkUzXlwo52TDv1POImRO8i16glhqaLKJlzAMWEqZL3EZqphPf9HmP7epFS/MW+UGgQDYN8jeijfg7UVOxEc/RiT1lp5vuTPDzMQ4YtQv4xAuxEWSlf8bnEoyTfHwAymCi3fkGcMT5qx5XDhA5rHU++7LLxdGfCNk24pWcafRDGo0Qe6Pm0sWz9tsJ4A/5JIb8FTw7mJ3itja4xCmBkNAgJdnoKOHAinN6v6mb5oa9kG2ck+kCn26OoOwgXndLwFjGCJp90TEZaYXPbqivxKCCFc6PwMn2ESSy5L7hr66vZBjdDLt7+1NzbLCmR6U4obtrEPawOH89+6YuTn10cAzapkBqJpz/FeSgOio3UZqy8uAzK0lwioRg7dvNy/bWOqP+7dSp78Q4Xm6sCT3LC2kTE2yXVEI5WvS1pnCOex/KilSb5K95MzrZPpVkYLj1YJxuNIpjbBIv2TaHDs+0sg98WMeQ7T0LJpU0yj+xF52UPkt2RTg2L3fyfe2kc1o26GWCd+Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(66476007)(26005)(86362001)(6486002)(66556008)(6666004)(2906002)(1076003)(508600001)(66946007)(7696005)(52116002)(186003)(54906003)(4326008)(83380400001)(36756003)(316002)(8676002)(5660300002)(8936002)(2616005)(956004)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImBSrGvYRpKNP5ervsaRMexOp1BxCHHL7tc2gClIOPehjeFPp/t/5hdsApOP?=
 =?us-ascii?Q?Y9CAMxF+8/r8HU8izjyXIheOraf+r5/0G8e7QFSv7c2KvTU2ZWf6mAmdMHup?=
 =?us-ascii?Q?3kP8uyZPW6E9nlXY+oyM1BM4P1OMnBE6NaznJPX0ApqgTUWhcs2qzd1yLf7g?=
 =?us-ascii?Q?85D//P0ROlQzXH5sMAj01kLpEgoBG9Rj4OMf8Carfdf8C9G5Imm3dT/Wum6Z?=
 =?us-ascii?Q?Oy+z82O8JC70VTpSDsX9l6Qf1KQQ8bBr7FqACWd4d9KveR2k6RNA2eAC0Qtw?=
 =?us-ascii?Q?ahxrfvfi/GQFLzKrG2uK2sTseydqwhlnTdTK3Ce2Nu+xVCYk733AlytxNKhs?=
 =?us-ascii?Q?W+qHxD9RyAnAp3wuP6jwrJruA2Vyo0o9dakSNA4jmVgpFCuXvTFJBo9i/TUw?=
 =?us-ascii?Q?VxQY1GL2pMZ/GyNB8pqTOfu0T7jEQZqlAjgbnK3O7jZkkdSA0SRWxpLrmd3Z?=
 =?us-ascii?Q?QwIdKsGZZ9b1pVJdwNHAYEjCyxijLKUzI/VHppcopHjlGc9ryF6q4kK0ogZw?=
 =?us-ascii?Q?7aHMhyfAQ1dMIkNzUSSOCvfpQVqEC23d/zVkTQ8Yi3cpf1SD1jmg7Z5KTDuH?=
 =?us-ascii?Q?ZsVqulBWOws0gg4/0jJ3SkoiZIQ2LOT6UuxRRCAaoxMFyf8y3C6o3Tf9YjUb?=
 =?us-ascii?Q?YXR9RMAOs0sUpCmcYdSLOuiqLjOfciXU6h2x+Nf72l5fhnTKZsp/DJOMOfHq?=
 =?us-ascii?Q?xXWmgyE6aLA5Seb29H+CcU7jcTRIt8ytOoEA63/vlI8JpoTuWqKrhpB6Lupx?=
 =?us-ascii?Q?v3QePFDxfRbbCA8BAmmmN1iBtN8ZSMKUsn2A3LKJaPtz/redTDyMWZ44Mc/9?=
 =?us-ascii?Q?7K4DK5uIDQ1QZ3wPmTpx3bGLlBke+wq2SKkqdDweBcMb33VDft9OXIA01XWZ?=
 =?us-ascii?Q?o4VNBCKUFaDeoqxZcmH38kLi/sNfWauGNk3oEuwDp6vp6m3/4rZfuzT0ydOb?=
 =?us-ascii?Q?QmoYLWPmcybvN2Plg3eXv1NUoYH4nUH1nyApvaqzNS0JV5r9EBt7HNtrfrPj?=
 =?us-ascii?Q?0+mht4s/aGXfhJ6OUBjcdgW9Mmpy1eCL9OqiRsxpwXUNdLNhEzpKVJvjXATm?=
 =?us-ascii?Q?ul0yR8WJ5p7aQljF8FRmgYpDwMUAi0g9bpDJszOjT/PLy4UsJBqDo86LOaYP?=
 =?us-ascii?Q?mpSH/Ut/7An7o0xhIvv2bXYkLayblTp8cGvZtfV2mhaHCnuXYkGN4MzdeVvQ?=
 =?us-ascii?Q?ZJAV4eqBUTf4f0e9TqOce7A5L5PV0MwchTtmrUWGgT/LWv9TIzCsRsMMbI/G?=
 =?us-ascii?Q?+ykq5bqlF7kKxtP+l1/jg5+exHHopoixkPP+lpIIfDnOotwc9NOm37DfrzRL?=
 =?us-ascii?Q?JKRSN7ynRDPU6CwL4q2wHt+3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870fe51d-eecb-4754-546a-08d94b954096
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:25.8277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw20corYZ9WtBZpYUcPBqi8sOeuFKOv0HSXOvRDMvB9RP90ZFT+1slJQ5X++uYkDdiwsrbFLrOwBwcKfMO4XCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
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

Add smu11_driver_if_cyan_skillfish.h for cyan_skilfish.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/inc/smu11_driver_if_cyan_skillfish.h   | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
new file mode 100644
index 000000000000..8a08ecc34c69
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_cyan_skillfish.h
@@ -0,0 +1,95 @@
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
+#ifndef __SMU11_DRIVER_IF_CYAN_SKILLFISH_H__
+#define __SMU11_DRIVER_IF_CYAN_SKILLFISH_H__
+
+// *** IMPORTANT ***
+// Always increment the interface version if
+// any structure is changed in this file
+#define MP1_DRIVER_IF_VERSION 0x8
+
+#define TABLE_BIOS_IF            0 // Called by BIOS
+#define TABLE_WATERMARKS         1 // Called by Driver; defined here, but not used, for backward compatible
+#define TABLE_PMSTATUSLOG        3 // Called by Tools for Agm logging
+#define TABLE_DPMCLOCKS          4 // Called by Driver; defined here, but not used, for backward compatible
+#define TABLE_MOMENTARY_PM       5 // Called by Tools; defined here, but not used, for backward compatible
+#define TABLE_COUNT              6
+
+#define NUM_DSPCLK_LEVELS		8
+#define NUM_SOCCLK_DPM_LEVELS	8
+#define NUM_DCEFCLK_DPM_LEVELS	4
+#define NUM_FCLK_DPM_LEVELS		4
+#define NUM_MEMCLK_DPM_LEVELS	4
+
+#define NUMBER_OF_PSTATES		8
+#define NUMBER_OF_CORES			8
+
+typedef enum {
+	S3_TYPE_ENTRY,
+	S5_TYPE_ENTRY,
+} Sleep_Type_e;
+
+typedef enum {
+	GFX_OFF = 0,
+	GFX_ON  = 1,
+} GFX_Mode_e;
+
+typedef enum {
+	CPU_P0 = 0,
+	CPU_P1,
+	CPU_P2,
+	CPU_P3,
+	CPU_P4,
+	CPU_P5,
+	CPU_P6,
+	CPU_P7
+} CPU_PState_e;
+
+typedef enum {
+	CPU_CORE0 = 0,
+	CPU_CORE1,
+	CPU_CORE2,
+	CPU_CORE3,
+	CPU_CORE4,
+	CPU_CORE5,
+	CPU_CORE6,
+	CPU_CORE7
+} CORE_ID_e;
+
+typedef enum {
+	DF_DPM0 = 0,
+	DF_DPM1,
+	DF_DPM2,
+	DF_DPM3,
+	DF_PState_Count
+} DF_PState_e;
+
+typedef enum {
+	GFX_DPM0 = 0,
+	GFX_DPM1,
+	GFX_DPM2,
+	GFX_DPM3,
+	GFX_PState_Count
+} GFX_PState_e;
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
