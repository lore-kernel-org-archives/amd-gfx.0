Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76489C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484C861C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484C861C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CEA6ED7E;
	Wed,  2 Jun 2021 16:49:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8656ED72
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnCP9lSJsqTbhqBFYSyExVlpVIZ51bX+dpABFvvWqIgjeAkrG6B6R10IDDUcp91aBvfdfO2OM/UI1vMJjY+N7m9wiCbUNplXLkY8r6dlDf9TP4k1KfkkoRBDa1lDaH/G09giLCJF6PVjMMb/a7NzXNOjPmJbpGXmmE4uBYd5vVwYXY6SafcQCK4jEH80SARNxddPcVyRgpLg6JvQ6uQKdc2WE2h5CsqY/wk6zCahByfhg8RpwR03bJdnvf/79ko8gPD336PkEKHaEbABN57DCQzibNrgwHalhuTdFN/6OcVqWlDndpfi21LR1WxyqyBZoPS4bOn45LoaXmHzQuv4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhKahIuHctVwyVk2Kt4tjfuoJDQp/89bov8RcqFIR9E=;
 b=HxUjOcu6FMkJrepn2aEdVywT9mekZOW2j4EqVTEpN+mo3pVeZNFCQrDIdFyFmnnNS+EqNJJwUIwn/UdFHXGxk73nrSldUT0nGBPsmZWkhIU6hDIqK2WpUDffJwhL+q4V1wzEgehonTPUG2na7OeIecRtFpsiGKhYbe7Pyx2hdCuMFjKmNcSdxIPzXTgnoey8CEgrM3z+pEaioRrAXmoAT67+31lqczQL5ZRSeNcTc21N/O4L4yroaEsIoaLIP9gd8CFWFktoLxAinTfQLKnmz3Eku58OeH1Axp2Vv+qnNqEn6i8tPHBSygkYRYeQXiNElFAJcp+BPHo8+c8tMJtVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhKahIuHctVwyVk2Kt4tjfuoJDQp/89bov8RcqFIR9E=;
 b=DWo3uwGrPa5cOY+MMw6EXtXqsgjR2yXbmpGWXzUcjkwVDSnl3vCiSanKeArFkvCtQXvUBgL+VKcu3idoIzdx0+1SLsR9SqmThIdl/vdPROcHGv1wrzhBdPPiH+na0BwNHH5VSknO3JVME8WIoKoI5RNLWmjDmJRrIhqCVPlPqsw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:38 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/89] drm/admgpu/pm: add smu v13 driver interface header for
 yellow carp (v3)
Date: Wed,  2 Jun 2021 12:47:54 -0400
Message-Id: <20210602164908.2848791-15-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d31ec051-0e8c-4ce9-cd08-08d925e668e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4077118CC435E6C21EA97FE1F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMHQKHkhsE+S6/ZzoyY8NBkHYifgHWp50ZNRJ0xxk9Z78wsugYLsDLRLdCg5mRPvab8wTcBPBb5Y2btyuufEsCM4G+z/+Zq3yyd6VCEqJ2Dnketkchw8bgjIUgJ0OFEcGXvdBREMaXq0yvu1wtSAgXX2No23xeLVdQHz6CWnjtJc7s7L8LFN4J9LneeXoIQyl/BDKXgUpET59Zrd7dRu1C11daGyqeig+GssD6GgrP2EAdujsCrRcXLP1Dzjh6pc+I5oUztlkgNv/ppHSEzM+kGHN1FKxs2a3rVmYbNJdUldOYOTuVaBTh2Bf8A9qyI6L0luCtC13Jp7g+XxO2ztbgKgKvkI4IAmxQGp5cxA2uXYqBvnOeYvlfuiojYpVOeiQQzV9kC2Dx7k0AyM/IxU71XjgQrB/kLEc2R5Pi7lb6ZUHoaADkjIVd6x3YovZPtyc2p1/wj4QeCVpO974xKjLzv7BLXNNs/Gwnp1BKjhFoSGb5IE4OPJl+WPpKW61vZ1p7NzAsmUGH9CPcy5UZbAUbV9CpzpSNY/Pe09Pa5Bh7g6zDu4EjAbYv0q1GkYp65FaYAxhcTgA88uPpjee2I5bozGwEQANWb5G9djL8UY3xdNgdti5fSnlyl1N1JHMtF3YFFfQdqW0wuhnBYigYRb8ZmE/uHRi2XKItKQfejwNE7A4MgF+3QP8kMnLdtQtw1M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JT2EHBxQ94wmNnk/AGyI+uncs+BM9I18S8Lc0hdBOg7bvEcZflFKKUKW8B7Z?=
 =?us-ascii?Q?eDvkaFy2qG+y0540BlJDPWJW79wdLv92TZ1m6fMEUAFS4HDCjVKp6GjeyNyK?=
 =?us-ascii?Q?65Fzx+C6/+bfNU+bnOdkwWrHqc+oi9KEDR+59rINAlo4G8Gz+muzIqKf9Vu5?=
 =?us-ascii?Q?3nALKZcQ8ytjZ5rpOpEUMgHg8wK82xQqrgVDUY//njbQGhmTYAA45MHbdHT0?=
 =?us-ascii?Q?GAj1AVC1HGqNB3D4NPLKMs+F8rg9y1rmGvMpLlcnWOse+Jo1/WjkhuXpjyRM?=
 =?us-ascii?Q?KrSrbHVFAbbsPsGk6tXGf00EEfO/1FE6AyObT/6ZDyrpIA6chkD07Ihmva5I?=
 =?us-ascii?Q?w1B7/DnbXaalJq1iGddez09yr3rygSsaboEi0O4WD8QbHGasResFVeU3JB9+?=
 =?us-ascii?Q?oztpuCosrIMzP6C11iulhDcMXedmiMOc86ZJHdh9WAHASETQRMU4AbbAzwYk?=
 =?us-ascii?Q?bSDwpZzrrMbBgYxZt4XyOEPLDHi8WBfl/CImqVBIWDNXs5KILEV2Wx3SRO5T?=
 =?us-ascii?Q?Uutlh1WzE6OohF875W1u05EPYl3BSNAaXL8EvRL0DqzrnWS537NLTM2Fy2GN?=
 =?us-ascii?Q?qsI3SqADM7TFSmOdz9gLzKjBABGxrY6Oojkc6mCeUQj3WjfaeN18+1O67vEl?=
 =?us-ascii?Q?qjKJUIGUsNS+CS9sENZX5Jb9ADOdPQtp9WGWaV4ZsX6h9bgiTP4s6OSGsby8?=
 =?us-ascii?Q?PeRz/b4mWDrWxJe5saNUYuT4YzAjfTHgKcJhHB0FrdUJJxy5evoQBnbDiE8/?=
 =?us-ascii?Q?iq1l41gWmLt4KzSkiZRBO8OicRNPZ/P00TQAw4LEa0tcE3pPIUhoC4kpWuHQ?=
 =?us-ascii?Q?nFV/ziDyfec89hpQQMT5bP2Iyyj/pgQJuNXcPU3MMg+SmdYpKmS0OHdX+UPd?=
 =?us-ascii?Q?D4/cFjq7L9K5oQnwYONTaoSf7NfpvTx6RTFHBY5WRyR/joeNETKwWkygcJ0W?=
 =?us-ascii?Q?XNReSZCRK+SFHmCDbz/lL8P0AtGbqaox7BfQkdEbbh0V1wAhiTYiEBCs1sia?=
 =?us-ascii?Q?UOL5o2L+/7rugwHYHpuil90/s0oYvCK4NjlZODq0xaIHy9TCNjzoAlcReS9H?=
 =?us-ascii?Q?k44C/XQy3HUBCyv9WKp4ZKL8ldr8vYL0LK9FJHz5+BHDyZfE6SQ164i5cSlH?=
 =?us-ascii?Q?XHofPWdX2/2A4EBSkWXuN0JdrqNmVp/Co8zTVpjomELaZNi2MYYmGyvYX76P?=
 =?us-ascii?Q?TrfS1kdbSGFwYMuNd9dqY73yDu1rNthfoheCPtSP8ftSAwQeLuxMt8apDefo?=
 =?us-ascii?Q?Eug0xIp/aUSK2p50yQ3FcYmN3WONge4mcAtGex1aJpDllgrtJ2Uu/6GEcu3J?=
 =?us-ascii?Q?WVGY903LVtO7lJXcjq5O5BYP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31ec051-0e8c-4ce9-cd08-08d925e668e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:38.4850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+gD/+/6k2fsKssbb+6Fvgi6GHGWvYB+B191OXAjaHWqIiNkdwncUn+ZqaGwVGC7uC8dzNrmzPjvnognDlz3cw==
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

This patch is to add smu v13 driver interface header for yellow carp.

v2: squash in updates (Alex)
v3: squash in v69.29.0 update (Alex)

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/inc/smu13_driver_if_yellow_carp.h  | 222 ++++++++++++++++++
 1 file changed, 222 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
new file mode 100644
index 000000000000..25540cb28208
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu13_driver_if_yellow_carp.h
@@ -0,0 +1,222 @@
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
+#ifndef __SMU13_DRIVER_IF_YELLOW_CARP_H__
+#define __SMU13_DRIVER_IF_YELLOW_CARP_H__
+
+// *** IMPORTANT ***
+// SMU TEAM: Always increment the interface version if
+// any structure is changed in this file
+#define SMU13_DRIVER_IF_VERSION 4
+
+typedef struct {
+  int32_t value;
+  uint32_t numFractionalBits;
+} FloatInIntFormat_t;
+
+typedef enum {
+  DSPCLK_DCFCLK = 0,
+  DSPCLK_DISPCLK,
+  DSPCLK_PIXCLK,
+  DSPCLK_PHYCLK,
+  DSPCLK_COUNT,
+} DSPCLK_e;
+
+typedef struct {
+  uint16_t Freq; // in MHz
+  uint16_t Vid;  // min voltage in SVI3 VID
+} DisplayClockTable_t;
+
+typedef struct {
+  uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MinMclk;
+  uint16_t MaxMclk;
+
+  uint8_t  WmSetting;
+  uint8_t  WmType;  // Used for normal pstate change or memory retraining
+  uint8_t  Padding[2];
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+#define WM_PSTATE_CHG 0
+#define WM_RETRAINING 1
+
+typedef enum {
+  WM_SOCCLK = 0,
+  WM_DCFCLK,
+  WM_COUNT,
+} WM_CLOCK_e;
+
+typedef struct {
+  // Watermarks
+  WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
+
+  uint32_t MmHubPadding[7]; // SMU internal use
+} Watermarks_t;
+
+typedef enum {
+  CUSTOM_DPM_SETTING_GFXCLK,
+  CUSTOM_DPM_SETTING_CCLK,
+  CUSTOM_DPM_SETTING_FCLK_CCX,
+  CUSTOM_DPM_SETTING_FCLK_GFX,
+  CUSTOM_DPM_SETTING_FCLK_STALLS,
+  CUSTOM_DPM_SETTING_LCLK,
+  CUSTOM_DPM_SETTING_COUNT,
+} CUSTOM_DPM_SETTING_e;
+
+typedef struct {
+  uint8_t             ActiveHystLimit;
+  uint8_t             IdleHystLimit;
+  uint8_t             FPS;
+  uint8_t             MinActiveFreqType;
+  FloatInIntFormat_t  MinActiveFreq;
+  FloatInIntFormat_t  PD_Data_limit;
+  FloatInIntFormat_t  PD_Data_time_constant;
+  FloatInIntFormat_t  PD_Data_error_coeff;
+  FloatInIntFormat_t  PD_Data_error_rate_coeff;
+} DpmActivityMonitorCoeffExt_t;
+
+typedef struct {
+  DpmActivityMonitorCoeffExt_t DpmActivityMonitorCoeff[CUSTOM_DPM_SETTING_COUNT];
+} CustomDpmSettings_t;
+
+#define NUM_DCFCLK_DPM_LEVELS   8
+#define NUM_DISPCLK_DPM_LEVELS  8
+#define NUM_DPPCLK_DPM_LEVELS   8
+#define NUM_SOCCLK_DPM_LEVELS   8
+#define NUM_VCN_DPM_LEVELS      8
+#define NUM_SOC_VOLTAGE_LEVELS  8
+#define NUM_DF_PSTATE_LEVELS    4
+
+typedef struct {
+  uint32_t FClk;
+  uint32_t MemClk;
+  uint32_t Voltage;
+  uint8_t  WckRatio;
+  uint8_t  Spare[3];
+} DfPstateTable_t;
+
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+typedef struct {
+  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+  uint32_t VClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t DClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+  DfPstateTable_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
+
+  uint8_t  NumDcfClkLevelsEnabled;
+  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+  uint8_t  NumSocClkLevelsEnabled;
+  uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
+  uint8_t  NumDfPstatesEnabled;
+  uint8_t  spare[3];
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks_t;
+
+
+// Throttler Status Bitmask
+#define THROTTLER_STATUS_BIT_SPL            0
+#define THROTTLER_STATUS_BIT_FPPT           1
+#define THROTTLER_STATUS_BIT_SPPT           2
+#define THROTTLER_STATUS_BIT_SPPT_APU       3
+#define THROTTLER_STATUS_BIT_THM_CORE       4
+#define THROTTLER_STATUS_BIT_THM_GFX        5
+#define THROTTLER_STATUS_BIT_THM_SOC        6
+#define THROTTLER_STATUS_BIT_TDC_VDD        7
+#define THROTTLER_STATUS_BIT_TDC_SOC        8
+#define THROTTLER_STATUS_BIT_PROCHOT_CPU    9
+#define THROTTLER_STATUS_BIT_PROCHOT_GFX   10
+#define THROTTLER_STATUS_BIT_EDC_CPU       11
+#define THROTTLER_STATUS_BIT_EDC_GFX       12
+
+typedef struct {
+  uint16_t GfxclkFrequency;             //[MHz]
+  uint16_t SocclkFrequency;             //[MHz]
+  uint16_t VclkFrequency;               //[MHz]
+  uint16_t DclkFrequency;               //[MHz]
+  uint16_t MemclkFrequency;             //[MHz]
+  uint16_t spare;
+
+  uint16_t GfxActivity;                 //[centi]
+  uint16_t UvdActivity;                 //[centi]
+
+  uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
+
+  //3rd party tools in Windows need this info in the case of APUs
+  uint16_t CoreFrequency[8];            //[MHz]
+  uint16_t CorePower[8];                //[mW]
+  uint16_t CoreTemperature[8];          //[centi-Celsius]
+  uint16_t L3Frequency;                 //[MHz]
+  uint16_t L3Temperature;               //[centi-Celsius]
+
+  uint16_t GfxTemperature;              //[centi-Celsius]
+  uint16_t SocTemperature;              //[centi-Celsius]
+  uint16_t ThrottlerStatus;
+
+  uint16_t CurrentSocketPower;          //[mW]
+  uint16_t StapmOpnLimit;               //[W]
+  uint16_t StapmCurrentLimit;           //[W]
+  uint32_t ApuPower;                    //[mW]
+  uint32_t dGpuPower;                   //[mW]
+
+  uint16_t VddTdcValue;                 //[mA]
+  uint16_t SocTdcValue;                 //[mA]
+  uint16_t VddEdcValue;                 //[mA]
+  uint16_t SocEdcValue;                 //[mA]
+
+  uint16_t InfrastructureCpuMaxFreq;    //[MHz]
+  uint16_t InfrastructureGfxMaxFreq;    //[MHz]
+
+  uint16_t SkinTemp;
+  uint16_t DeviceState;
+} SmuMetrics_t;
+
+
+// Workload bits
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
+#define WORKLOAD_PPLIB_VIDEO_BIT          2
+#define WORKLOAD_PPLIB_VR_BIT             3
+#define WORKLOAD_PPLIB_COMPUTE_BIT        4
+#define WORKLOAD_PPLIB_CUSTOM_BIT         5
+#define WORKLOAD_PPLIB_COUNT              6
+
+#define TABLE_BIOS_IF               0 // Called by BIOS
+#define TABLE_WATERMARKS            1 // Called by DAL through VBIOS
+#define TABLE_CUSTOM_DPM            2 // Called by Driver
+#define TABLE_SPARE1                3
+#define TABLE_DPMCLOCKS             4 // Called by Driver and VBIOS
+#define TABLE_MOMENTARY_PM          5 // Called by Tools
+#define TABLE_MODERN_STDBY          6 // Called by Tools for Modern Standby Log
+#define TABLE_SMU_METRICS           7 // Called by Driver
+#define TABLE_INFRASTRUCTURE_LIMITS 8
+#define TABLE_COUNT                 9
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
