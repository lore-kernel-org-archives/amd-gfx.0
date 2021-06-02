Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B237C47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0926F61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926F61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C217F6ED80;
	Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602196ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7F2fSrqauOMnO0XYfm7EAW+NfUr2qmgNOvwozDWrJxkUxlaDBJSqEV9uLcknUZInsPJLKymNbBNJZAAVMjqGmKdMC0YDQTelzk93YpbgIvifuQh8IR3M9FbZs16hlf2j76uT2iqBbPF5OFVTE/z6kOMojUvA1GBDtbFx+XyYzmsTRCb3idIJEHxCBHRw0UhuzD7eNcf/6HfS3/h/JM/1qlQU/ognRgGnXMmV653VgxdIO3zVyIl0vrA5G9h8kCsGjbKzGQjZBL9faG7b2Zz8ubUbzYnMved7wpNu7VHP96glHkTar/fH31ylDoOOO5QazqqtKuxE8uZrPcxSI9+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ik651xd0UoNsaPlD0F+NUYU7xV6pLbs3O8EApXk1Eg=;
 b=gSZyNSjGDByNu5l7xCrb5yUnS/t3Ja2/8qJwZ7/tmjvq42AeIw3DuNoralSSzh3MGU4HODpJFH3+sa79Fo3qo+2MtUz5W5wtNZ1IsdIXkT07U5t26ySv7s+YBJ6+y9JKMigaY3pGP4JORlFzDD9oCaB0TO/GxoqU6XuVago6FrX6oQlXgRRlh+XFJORzzFYguC5CK+HXQHQr4hFl4gheqUuQkd3moHN9UQexlyQlRROUqfSb14NYDSRmVmhPIOUiMhycqe0XqOw+Q73ChL6CaKRg6+ULJxK19VmCVjn/Gya+EEYO2Xjvm5qON7/UoZAzCKrX3db7OhIEfTIqhuAkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ik651xd0UoNsaPlD0F+NUYU7xV6pLbs3O8EApXk1Eg=;
 b=FdwoJ/HVmO69jTvmqWnwWBXf4GcphRtb40LBl1yxrsA57I16XWVocsX1WvatWyXmLgLr4eKshd/XhCbrY0eC+rkqTOmAYzddwzBltGv7OW37DXXH2Y5FHLHMYZPyC5JUg29/sPRqgvt4UW19vq1KCwPFXljfKlpw2DX8BugArPY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/89] drm/amdgpu/pm: add smu v13.0.1 firmware header for
 yellow carp (V4)
Date: Wed,  2 Jun 2021 12:47:55 -0400
Message-Id: <20210602164908.2848791-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4b046c-f845-4722-c796-08d925e6695a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077376EB1D005DD73E6E5DEF73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCVjqrnA7Tl+8hdyI+6iV8pW5iEvkjS0P847qlYrqYhxowLmJftSSIDhyFcLqf7LLifQ27o4F8t/7DjevvSbS1a5HnMDjhlFPk9EwYaSAUxr80OSvJflbxNx9uuqSYDJUHYwl/VtY+8TGMxGvVxRFX+YT+J5LJWWFmXIEDPFp5ETTwQVtJA57tYpf14+PuK+v2LYAQQP3L8tsRg1arQpVs1i4RskbvUrJWtrWxGT9Ady2MOfa71dFyZdBfJR+txo9eSJiD8yfFa+1TPlK39Wwj+4UV5OBd1fo5gshrRBxwC0L+2EQy3WVUJX1np0R1beRibMYdj0nZeNf/7A2uM6yHLvx0TeJkAWOpTJ+gKlwCPOQBWy0lPjwk5jFXYYjAy/FYy2HLug13LDB/+9eu9TBlt1XIdJdUPKJLOYGKM0YqrpyhcQ5+FnPnZ+0OAU5riG92vQQDSmjY3VTTJF5WtqZQxx1MYTPW7zwdRBOuO7m9e2sCkfALnH0nUipa4SVnShxOP7z+hXHCmsYinbZy+58Vz2vSGO3LXoE7OjlhviIadWyG+LVS75gKV7Ikyew+CjzXM51kiwixhBRT3qzg1MoHISnLHwzh7c1EUoYzCFcyPoWW8FVMbLEgSa4xwDEH/GMd2HMg17VwmbFOFd8I9LWZqzXzYAmQFYTOhb0T4sTTWXmUWmTOQkxQUhQcRBKM/p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(19627235002)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zrX+YfMao7xfGDknk030q3auwPLPWIi5pWkDNhh2AMA59X/y2veub6G6j9Md?=
 =?us-ascii?Q?YKy1x+ajtX9MNh9oCJtHiwejnBbmcB2ifU3/wiXcC7kwcaUKtHa8BxsEwRLc?=
 =?us-ascii?Q?Xdc0AxcR8c7tfhD2lKmpkwVRNew1+tU5WZgUGx+epfv0xY2zgJ3twK7AKCov?=
 =?us-ascii?Q?aDE59bVsLaaDS/lc11zGWvrbfX4x+B+qO+fnXMAKYPfxHbIHqozvsRdwvRHD?=
 =?us-ascii?Q?SjEUHik8uRl4uUZq3wPrvyoIOCujHdf+z6Ey8qSGfrjUOEf4jNPCIpM9/PGZ?=
 =?us-ascii?Q?py0l8hAGRi6hltvO8ptETvoO9wapulGcHwhH4qj89P1YJqzWzj4Udb2RyCQF?=
 =?us-ascii?Q?zcEIfGI7mC5oc5mdGK9/5KQdsGIXDuwm7F6ChCvQ55ueerqMaqt5OMfWcLyC?=
 =?us-ascii?Q?ZadL09vIx/MO3ffUgibMSdq15G9yEkgEayrOWpLK1p94bTmLifXhpKgC0XNS?=
 =?us-ascii?Q?JAWasbhwXme1jovbmz8FwWZHluLd+0pgocG+fmQKlyXCz9JOLA8OSQP+kn7Y?=
 =?us-ascii?Q?jUsZ5sTcuKeNI732yKoDNyPOk8kVBB1YjoLxUnooOhfBei0F1p2en7uSRmc6?=
 =?us-ascii?Q?HS1oXKFXi1usbPs8u0Z9mpMfBVqib/aARqtY0rWMYRs7lS9pLQMOzWQHdwhZ?=
 =?us-ascii?Q?xTJgBYdD4kQUvUfihL0m0cNkMx/puAwo9h8i95E0MSTR38qEH+b/dnp0XSYa?=
 =?us-ascii?Q?DtHj2ehYrW5FsoS5c0L9LkaMy8VNPh0Vqv9iHQf3QQ5IURsQxAzgk7s5mij8?=
 =?us-ascii?Q?XAIjDcIWX5rMWHgP6J/wODCsOzdzIctcltipAdS/2AjBO+eTGfGuW2qZZlzQ?=
 =?us-ascii?Q?4PpM59B+UH8wqnczkCj20t6SAa8V04fiCAU/swhumDgsVrxgR0JtAq6bQeWI?=
 =?us-ascii?Q?FrXPpgMHlYyYf4+t3e/3WJ/xf6fCwq3XdHJAp7ROUxs6Tq7SjsXhJeedzrWh?=
 =?us-ascii?Q?1L74Nu1a+iev6gjfSamFPKZEa4niDRgK21rAi2soELviSlwWDXU+VuRudbRn?=
 =?us-ascii?Q?GxTKzTY59Fo/XZFVJMwDjr1geeYUYrVmhzuHWiiHTTmA5ylwDNw1oXwn+LB7?=
 =?us-ascii?Q?EUpsQEhFZw144gMC/IkIRvGrwinY3u+kUrf2M5v1/BQXNX7IaZsibmQAnlHM?=
 =?us-ascii?Q?ntfc1pPWv5NQUbcvcUY6kjECMcZkfJVpkQtRVKRqY/qmnrOImdJeJ0fg3ekR?=
 =?us-ascii?Q?UvKKMKfZPYCIyeF0xMCE9Cepgn01M8f7BOCapfhAFmPlPiPH++NVmDG+s0Id?=
 =?us-ascii?Q?89GLu5yBvbUhC/TfQ8CkJGof1xNuT2WNkupP1romi8ee1VkYXU7jXoFLJBjg?=
 =?us-ascii?Q?bbkWPmUUd6tWJlVnsw3vaToJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4b046c-f845-4722-c796-08d925e6695a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:39.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUP1oxNzWSt6LY49NKrEvNSUcfL4OYZ3lotHZGg9nmOEhZVu0923T/aBwewslegOi6GUEM+m8gPwPfikGkLc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch is to add smu v13.0.1 firmware header for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
new file mode 100644
index 000000000000..5627de734246
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
@@ -0,0 +1,139 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __SMU_V13_0_1_PMFW_H__
+#define __SMU_V13_0_1_PMFW_H__
+
+#include "smu13_driver_if_yellow_carp.h"
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Firmware features 
+// Feature Control Defines
+#define FEATURE_CCLK_DPM_BIT                 0
+#define FEATURE_FAN_CONTROLLER_BIT           1
+#define FEATURE_DATA_CALCULATION_BIT         2
+#define FEATURE_PPT_BIT                      3
+#define FEATURE_TDC_BIT                      4
+#define FEATURE_THERMAL_BIT                  5
+#define FEATURE_FIT_BIT                      6
+#define FEATURE_EDC_BIT                      7
+#define FEATURE_PLL_POWER_DOWN_BIT           8
+#define FEATURE_ULV_BIT                      9
+#define FEATURE_VDDOFF_BIT                  10
+#define FEATURE_VCN_DPM_BIT                 11
+#define FEATURE_CSTATE_BOOST_BIT            12
+#define FEATURE_FCLK_DPM_BIT                13
+#define FEATURE_SOCCLK_DPM_BIT              14
+#define FEATURE_MP0CLK_DPM_BIT              15
+#define FEATURE_LCLK_DPM_BIT                16
+#define FEATURE_SHUBCLK_DPM_BIT             17
+#define FEATURE_DCFCLK_DPM_BIT              18
+#define FEATURE_GFX_DPM_BIT                 19
+#define FEATURE_DS_GFXCLK_BIT               20
+#define FEATURE_DS_SOCCLK_BIT               21
+#define FEATURE_DS_LCLK_BIT                 22
+#define FEATURE_DS_DCFCLK_BIT               23
+#define FEATURE_DS_SHUBCLK_BIT              24
+#define FEATURE_GFX_TEMP_VMIN_BIT           25
+#define FEATURE_ZSTATES_BIT                 26
+#define FEATURE_WHISPER_MODE_BIT            27
+#define FEATURE_DS_FCLK_BIT                 28
+#define FEATURE_DS_SMNCLK_BIT               29
+#define FEATURE_DS_MP1CLK_BIT               30
+#define FEATURE_DS_MP0CLK_BIT               31
+#define FEATURE_CLK_LOW_POWER_BIT           32
+#define FEATURE_FUSE_PG_BIT                 33
+#define FEATURE_GFX_DEM_BIT                 34
+#define FEATURE_PSI_BIT                     35
+#define FEATURE_PROCHOT_BIT                 36
+#define FEATURE_CPUOFF_BIT                  37
+#define FEATURE_STAPM_BIT                   38
+#define FEATURE_S0I3_BIT                    39
+#define FEATURE_DF_LIGHT_CSTATE             40   // shift the order or DFCstate annd DF light Cstate
+#define FEATURE_PERF_LIMIT_BIT              41
+#define FEATURE_CORE_DLDO_BIT               42
+#define FEATURE_RSMU_LOW_POWER_BIT          43
+#define FEATURE_SMN_LOW_POWER_BIT           44
+#define FEATURE_THM_LOW_POWER_BIT           45
+#define FEATURE_SMUIO_LOW_POWER_BIT         46
+#define FEATURE_MP1_LOW_POWER_BIT           47
+#define FEATURE_DS_VCN_BIT                  48
+#define FEATURE_CPPC_BIT                    49
+#define FEATURE_CPPC_PREFERRED_CORES        50
+#define FEATURE_SMART_SHIFT_BIT             51
+#define FEATURE_DF_CSTATES_BIT              52
+#define FEATURE_MSMU_LOW_POWER_BIT          53
+#define FEATURE_SOC_VOLTAGE_MON_BIT         54
+#define FEATURE_ATHUB_PG_BIT                55
+#define FEATURE_VDDOFF_ECO_BIT              56
+#define FEATURE_ZSTATES_ECO_BIT             57
+#define FEATURE_CC6_BIT                     58
+#define FEATURE_DS_UMCCLK_BIT               59
+#define FEATURE_DS_HSPCLK_BIT               60 
+#define NUM_FEATURES                        61
+
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t DpmHandlerID         : 8;
+  uint32_t ActivityMonitorID    : 8;
+  uint32_t DpmTimerID           : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
+  // MP1_EXT_SCRATCH1
+  uint32_t GfxoffStatus         : 8;
+  uint32_t GfxStatus            : 2;
+  uint32_t CpuOff               : 2;
+  uint32_t VddOff               : 1;
+  uint32_t InUlv                : 1;
+  uint32_t InWhisperMode        : 1;
+  uint32_t spare0               : 1;
+  uint32_t ZstateStatus         : 4;
+  uint32_t spare1               :12;
+  // MP1_EXT_SCRATCH2
+  uint32_t P2JobHandler         :24;
+  uint32_t RsmuPmiP2FinishedCnt : 8;
+  // MP1_EXT_SCRATCH3
+  uint32_t PostCode             :32;
+  // MP1_EXT_SCRATCH4
+  uint32_t MsgPortBusy          :15;
+  uint32_t RsmuPmiP1Pending     : 1;
+  uint32_t DfCstateExitPending  : 1;
+  uint32_t Pc6EntryPending      : 1;
+  uint32_t Pc6ExitPending       : 1;
+  uint32_t WarmResetPending     : 1;
+  uint32_t Mp0ClkPending        : 1;
+  uint32_t spare2               : 3;
+  uint32_t RsmuPmiP2PendingCnt  : 8;
+  // MP1_EXT_SCRATCH5
+  uint32_t IdleMask             :32;
+  // MP1_EXT_SCRATCH6 = RTOS threads' status
+  // MP1_EXT_SCRATCH7 = RTOS Current Job
+} FwStatus_t;
+
+
+#pragma pack(pop)
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
