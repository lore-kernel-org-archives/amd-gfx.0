Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E215AC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B304C60FEA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B304C60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FE16E441;
	Tue, 20 Jul 2021 15:44:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AF8E6E43F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF6ArEDGNgVbJH04NvG6yw5B6Z5MShr6Bjlz7XNoxx2nAAgdDvrqyCuZwgjsRO9TZZXTE00iiPhyXSER4jwlWjY8+7Ffubjhphg9ExeeqXvFjuPKZhKzOUsfBWO95945niZJj1o+94WYounoqH9qa2wsAzCNvGU7zKsHd4ae2rye3h8H04iY7AgZg8a00RSJEt/0GXKoFoFA9mU3bMjRu07WWaT4L2u1z4wXZCupAbFS1It6ZZk57uYQAXigXu0gNGMmFv2mYXDUssCrM0R1P+cP8UApD0cTsnJz4H/x9maTlVlejl+AOMwm7AQXNmEAoQqe9feF5cnbqDOroRz2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkZ0eKxtue7L7/oglcbQe5gHsyv6VQuji04E9wlbJJs=;
 b=aNc0qQgSMD5McOOJKQF6NNoU8XndPl+rRVRH6KlTXOxfqo74qw6tBBPGtdjDF7S5ITCah48V835iXbCdVO/LecgJU26o5hqPmdgT0MnIDF2a4XAfXSp4Nm5IS3GHbqfOYNib9+sW6yqETbIRuv5w87XtXutYCayY93yeHJ4Wm8kj56y2volUbGI9HWwsFfVTWlrPkAG9p5sj3ubWB2Eoz4aJcQenQpDfiBAql3+V4c2kZAulC2FGrYahejBMbFsdBJd6DVbVp1SDKkAjc0kjBLw2JaFgZXv43VUuOGugFYEJ1pBoWbFOkKd8lHlka5OTsJW2TZXAMsUJP9Rpn7lhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkZ0eKxtue7L7/oglcbQe5gHsyv6VQuji04E9wlbJJs=;
 b=Tw77fVVmC3fuFBEhClYtlTaybx0F01M6pfgZmS+EpP3DQPOD6YmbEcLUXxee3NOfROO3NQw5B3ypujY7FpqeCV6Z75Uw9qkYfdMqpCVMB4BJfTkHKcDS7731pqU/dTohJOLQbVs+Qq5CQkTfAFfvPUmdyuyGQPsjkALylO8O0Qg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:24 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:24 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/29] drm/amdgpu: add smu_v11_8_pmfw header for cyan_skilfish
Date: Tue, 20 Jul 2021 11:43:42 -0400
Message-Id: <20210720154349.1599827-23-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2974481f-b4a2-40aa-b81a-08d94b953f78
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126EF3ECA57F2000F6A9909F7E29@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXXe2XqLlISGxH7t1l/KL7kHGcoZP6kI7MhxEsLFmMh0oErE4bxSGgwgOD6b+dgO+xZPtneZVPa6MfExTZlns6m+ZSFD9QCShAgaKTom2AcUD7RKVs0KrEChwUUCv9Ea7E+gRsB7mfnFaEEvbnSUwf69BMphivuRnyaZ8lzU1kpmYb4Z9j9Oo5d1Tpb3SgzUDKiOoZabLvNsHzih1dAGGuUKlJG6qFDvSlZDsLy+mLz55hSxOARsOTIr0t/0HQkSCE5rqI+PcKkP9vlm1Z8ahD39uwXzgPtNRyNEIiHkzKUIo9aYTTDS6vSVnQUjzqMdl+00/6oHuu9rPVquy71jxwWR7FInJOQpZprq2bGhdbnnsRqvU67LNjgN8R5eGz+TC1verN9tB4FZR0BmbNs0hEUrE4jMhAgpzL9uPIfDuW8q5gL5S6RUGakPCBW6Atx2Xz4pedJuISFxfp5MTTD5ZX9X1md/hA1Ca3QSmfbtQvbnnr4aVS3F1nHfDbjZQ8OXyWzPWoS00g7BtrNgLBSFtYkptcZgp47EXC1qDCPpdNaqR+tLXALNW/jthAgII6YhS2Z2hgNykCswYjrv7Aa7Z3eIQdyyjw0h9q9SdEy0I/tyNT0G2cWsD3rWeksapIclTCJBDMqjCMLeHn29AZbMx/ba3B7cymkdanEvRqXMtbvhfkJfXwBVeck8cDcrQ/BpXpzJFxQh1DycXrw8ZWl13w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(66574015)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1hX4z4+4KvcjyN2RQxhIBD+XdddZaCvoMAjgSjn3MtDYj2Cmc26hOZ9THJm?=
 =?us-ascii?Q?FedX2fGJIIaHvsGCANoGPIAzLo0pL5yhOkN+z+12RLqCjBFgZTsQBDFJQ8/8?=
 =?us-ascii?Q?YyrjCoISKzARNzq6DP6Lf8tWZ4WGoU4Su336Ip9YG9C9Utxb1Moau4kkUOuP?=
 =?us-ascii?Q?arzDr5ZGx+edQIK7a71NTkz2naCMhA6KjGxhq+CFmmeOPcByaDCljR0YrbuP?=
 =?us-ascii?Q?3RBbZ6LmcVh5xTOb1UeI4vQps8ffgqG6xdmPSL0SyD5ThFGeODxwGwqrIKM8?=
 =?us-ascii?Q?fTdSCL7g65wWTDo3gehWC6ZiIBidFy7W2oczKy5A/1vvpgVxEzJdO+kLr4MC?=
 =?us-ascii?Q?rTm/Byoi/xXY4PUnk3l325/oJYXmATNSXzR4QG0PqJd7j3G8oxYLY+a6sg7H?=
 =?us-ascii?Q?0C932UYrZCCi4IhkM4bJDJ4Mr79g8nF/eqbChrw2Flb84b4j6XfacbBoWwiG?=
 =?us-ascii?Q?IPB2uoxlUY2nVQ/FvYlK+Vd3fObiSZNnUm68WUIcuI2RPE7BX5b1AkFvMGhr?=
 =?us-ascii?Q?86RtYsak8TqMB11CZ74X2fxqLbGBNE3iS0oDHQBp9qJ6fHzTZGBcTCTzeZA2?=
 =?us-ascii?Q?LoOtWjg2aw3fZ/CploEUCTgRK+pZJTXSPCQJqSB6C2kdeGRLsXX8gm04KRVd?=
 =?us-ascii?Q?EmeDAMilwHwbPUyREA0smmpJEssUpkAwLFKxBcgWeittYzoweey/wQJPpkLY?=
 =?us-ascii?Q?4IJD0N324iiGsjzVueeEThbPlpj/ztlQE/SCPEQm/K0DsWPJcLABetZIfa76?=
 =?us-ascii?Q?cv3eD8WtKKHw8j6tt33jAF9jJaAAv2gjtmbNSwfNa4vxjdgUdkPTo7ULhjWZ?=
 =?us-ascii?Q?ZrJmFHsF9grNgm2LBi9ZQBEMxBmaxDymB/T6gn1VEBCkuziQxQM1d5xQQ6Sn?=
 =?us-ascii?Q?5vwN87ut+xMzOqpRC4iiIMxtLTe/tC8l2ATmuL0JdllPmATBdUg9HCcyI5wU?=
 =?us-ascii?Q?9rxnM3barzQPbXBH5ALqZF2Qy+hUThA5XHMfZCyBVOXtJ2R7JBv1J5WgMDCF?=
 =?us-ascii?Q?FhBULBqFQRCwoPHKxZBVjfFt+v/3OK17EtM4+kFMiI1zRkl5iZ5jvOQVpCxV?=
 =?us-ascii?Q?RhMLUIcHbiwrq3dGujoinoNsyMirSXMiYO/L+2gjJYYrwLslqv4NC3OXhWOV?=
 =?us-ascii?Q?I/kjlOt595wasihnZRgqQtocbgm4JRbpzJen5PxUCVaQPXPq8rWWb+ZyBkaI?=
 =?us-ascii?Q?eH2m2Q47W3QyzCODOIY1FlWXR5uYVMqv6EPok/aU7g1MEwshJDN/+S+AeliF?=
 =?us-ascii?Q?kWlFE12u/exGRyEs5xdlZxkZ6mtrVw6Lami/riLX2z6tEgk1SuvHYKcrlj3z?=
 =?us-ascii?Q?m1rGVB4oG1kJqTU5DzzSHv8r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2974481f-b4a2-40aa-b81a-08d94b953f78
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:23.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9PX/nfHXu+pH4pcgIjToUCMxnKug2Lgnv7+G3J/kku44F685+ghnDk6eZfWc25HU2d77sCfkY/E6ZpFfvJ/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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

Add smu_v11_8_pmfw.h for cyan_skilfish.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h | 152 ++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
new file mode 100644
index 000000000000..bd4fcb6b9610
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_8_pmfw.h
@@ -0,0 +1,152 @@
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
+#ifndef __SMU_V11_8_0_PMFW_H__
+#define __SMU_V11_8_0_PMFW_H__
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Feature Control Defines
+#define FEATURE_CCLK_CONTROLLER_BIT       0
+#define FEATURE_GFXCLK_EFFT_FREQ_BIT      1
+#define FEATURE_DATA_CALCULATION_BIT      2
+#define FEATURE_THERMAL_BIT               3
+#define FEATURE_PLL_POWER_DOWN_BIT        4
+#define FEATURE_FCLK_DPM_BIT              5
+#define FEATURE_GFX_DPM_BIT               6
+#define FEATURE_DS_GFXCLK_BIT             7
+#define FEATURE_DS_SOCCLK_BIT             8
+#define FEATURE_DS_LCLK_BIT               9
+#define FEATURE_CORE_CSTATES_BIT          10
+#define FEATURE_G6_SSC_BIT                11 //G6 memory UCLK and UCLK_DIV SS
+#define FEATURE_RM_BIT                    12
+#define FEATURE_SOC_DPM_BIT               13
+#define FEATURE_DS_SMNCLK_BIT             14
+#define FEATURE_DS_MP1CLK_BIT             15
+#define FEATURE_DS_MP0CLK_BIT             16
+#define FEATURE_MGCG_BIT                  17
+#define FEATURE_DS_FUSE_SRAM_BIT          18
+#define FEATURE_GFX_CKS_BIT               19
+#define FEATURE_FP_THROTTLING_BIT         20
+#define FEATURE_PROCHOT_BIT               21
+#define FEATURE_CPUOFF_BIT                22
+#define FEATURE_UMC_THROTTLE_BIT          23
+#define FEATURE_DF_THROTTLE_BIT           24
+#define FEATURE_DS_MP3CLK_BIT             25
+#define FEATURE_DS_SHUBCLK_BIT            26
+#define FEATURE_TDC_BIT                   27 //Legacy APM_BIT
+#define FEATURE_UMC_CAL_SHARING_BIT       28
+#define FEATURE_DFLL_BTC_CALIBRATION_BIT  29
+#define FEATURE_EDC_BIT                   30
+#define FEATURE_DLDO_BIT                  31
+#define FEATURE_MEAS_DRAM_BLACKOUT_BIT    32
+#define FEATURE_CC1_BIT                   33
+#define FEATURE_PPT_BIT                   34
+#define FEATURE_STAPM_BIT                 35
+#define FEATURE_CSTATE_BOOST_BIT          36
+#define FEATURE_SPARE_37_BIT              37
+#define FEATURE_SPARE_38_BIT              38
+#define FEATURE_SPARE_39_BIT              39
+#define FEATURE_SPARE_40_BIT              40
+#define FEATURE_SPARE_41_BIT              41
+#define FEATURE_SPARE_42_BIT              42
+#define FEATURE_SPARE_43_BIT              43
+#define FEATURE_SPARE_44_BIT              44
+#define FEATURE_SPARE_45_BIT              45
+#define FEATURE_SPARE_46_BIT              46
+#define FEATURE_SPARE_47_BIT              47
+#define FEATURE_SPARE_48_BIT              48
+#define FEATURE_SPARE_49_BIT              49
+#define FEATURE_SPARE_50_BIT              50
+#define FEATURE_SPARE_51_BIT              51
+#define FEATURE_SPARE_52_BIT              52
+#define FEATURE_SPARE_53_BIT              53
+#define FEATURE_SPARE_54_BIT              54
+#define FEATURE_SPARE_55_BIT              55
+#define FEATURE_SPARE_56_BIT              56
+#define FEATURE_SPARE_57_BIT              57
+#define FEATURE_SPARE_58_BIT              58
+#define FEATURE_SPARE_59_BIT              59
+#define FEATURE_SPARE_60_BIT              60
+#define FEATURE_SPARE_61_BIT              61
+#define FEATURE_SPARE_62_BIT              62
+#define FEATURE_SPARE_63_BIT              63
+
+#define NUM_FEATURES                      64
+
+#define FEATURE_CCLK_CONTROLLER_MASK  (1 << FEATURE_CCLK_CONTROLLER_BIT)
+#define FEATURE_DATA_CALCULATION_MASK (1 << FEATURE_DATA_CALCULATION_BIT)
+#define FEATURE_THERMAL_MASK          (1 << FEATURE_THERMAL_BIT)
+#define FEATURE_PLL_POWER_DOWN_MASK   (1 << FEATURE_PLL_POWER_DOWN_BIT)
+#define FEATURE_FCLK_DPM_MASK         (1 << FEATURE_FCLK_DPM_BIT)
+#define FEATURE_GFX_DPM_MASK          (1 << FEATURE_GFX_DPM_BIT)
+#define FEATURE_DS_GFXCLK_MASK        (1 << FEATURE_DS_GFXCLK_BIT)
+#define FEATURE_DS_SOCCLK_MASK        (1 << FEATURE_DS_SOCCLK_BIT)
+#define FEATURE_DS_LCLK_MASK          (1 << FEATURE_DS_LCLK_BIT)
+#define FEATURE_RM_MASK               (1 << FEATURE_RM_BIT)
+#define FEATURE_DS_SMNCLK_MASK        (1 << FEATURE_DS_SMNCLK_BIT)
+#define FEATURE_DS_MP1CLK_MASK        (1 << FEATURE_DS_MP1CLK_BIT)
+#define FEATURE_DS_MP0CLK_MASK        (1 << FEATURE_DS_MP0CLK_BIT)
+#define FEATURE_MGCG_MASK             (1 << FEATURE_MGCG_BIT)
+#define FEATURE_DS_FUSE_SRAM_MASK     (1 << FEATURE_DS_FUSE_SRAM_BIT)
+#define FEATURE_PROCHOT_MASK          (1 << FEATURE_PROCHOT_BIT)
+#define FEATURE_CPUOFF_MASK           (1 << FEATURE_CPUOFF_BIT)
+#define FEATURE_GFX_CKS_MASK          (1 << FEATURE_GFX_CKS_BIT)
+#define FEATURE_UMC_THROTTLE_MASK     (1 << FEATURE_UMC_THROTTLE_BIT)
+#define FEATURE_DF_THROTTLE_MASK      (1 << FEATURE_DF_THROTTLE_BIT)
+#define FEATURE_SOC_DPM_MASK          (1 << FEATURE_SOC_DPM_BIT)
+
+typedef struct {
+	// MP1_EXT_SCRATCH0
+	uint32_t SPARE1            : 4;
+	uint32_t SPARE2            : 4;
+	uint32_t SPARE3            : 4;
+	uint32_t CurrLevel_LCLK    : 4;
+	uint32_t CurrLevel_MP0CLK  : 4;
+	uint32_t CurrLevel_FCLK    : 4;
+	uint32_t CurrLevel_SOCCLK  : 4;
+	uint32_t CurrLevel_DCEFCLK : 4;
+	// MP1_EXT_SCRATCH1
+	uint32_t SPARE4            : 4;
+	uint32_t SPARE5            : 4;
+	uint32_t SPARE6            : 4;
+	uint32_t TargLevel_LCLK    : 4;
+	uint32_t TargLevel_MP0CLK  : 4;
+	uint32_t TargLevel_FCLK    : 4;
+	uint32_t TargLevel_SOCCLK  : 4;
+	uint32_t TargLevel_DCEFCLK : 4;
+	// MP1_EXT_SCRATCH2
+	uint32_t CurrLevel_SHUBCLK  : 4;
+	uint32_t TargLevel_SHUBCLK  : 4;
+	uint32_t Reserved          : 24;
+	// MP1_EXT_SCRATCH3-4
+	uint32_t Reserved2[2];
+	// MP1_EXT_SCRATCH5
+	uint32_t FeatureStatus[NUM_FEATURES / 32];
+} FwStatus_t;
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
