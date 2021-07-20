Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54AC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC17A61029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC17A61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E95A6E438;
	Tue, 20 Jul 2021 15:44:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66C86E436
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1IF/q8AqLULdRuW275wCwcU52NzTsbDC/1ZnQFXcR/raHI08Pu6UWpr6R3FLaXhEymI26hhjHE3GXzoAB1genQqPyRuM84JtsOkUs6q2aur3H2uAzmZdpB5qmKO5JKmfu8Cys9PR2IfRTmkuuhslfa9xxPfNrzi3Lcj5KyUecBrzUdYGcghQ+F/P+UNldaGgbr3joQa7npyFtaxBgjEtpBSpAA88kyKR59n2rzVbLBKOIeunOVqjpdlbKNmGlu94XM4Iwq+p2/Lt95UYyz8SdcUn3Kx+gWdGb75qJVM6dXZWsDJ4kxcX7VNR9eBsjtRPUGZ+uqp0Ewxn/VpgP1Bfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK5SNqMbRGl0oWQgboxvXBPU4/7UEECztuqqLIYj8YQ=;
 b=Q246UAEFgZzvkZWNW0cKJiudGGzZrRIqng364Wo8yZMldXnj4X0lM7cvveOfan2tp81ChmPAwqZvRvS3zkhVxcesWnJToy+TzHczvL9Vj0XK9leYCNtpE+x7lTsHxteflT7Rb915iEg/BO71QVL4K8Nn0wkrJ+jjZFCSiWR4SWzUzRwldn0VDM+3nhuAp4IS6xmsZV1p+xkdGXiKgm0VTEj/CI5Nd7RDE00ypV6uIV9tamUh4uYPy2l2ghIsiRh2OtlDGojjxHAciACBjNG5cABdZ/ABXxNZAESOvChUtaYvg9LErPCpG0ZrZCic/fFlzNLuwrWM02DcAawzbWMWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK5SNqMbRGl0oWQgboxvXBPU4/7UEECztuqqLIYj8YQ=;
 b=5p2KwTwY+fcZepXtrcEOdEU3Jv3YfnkxT8kZCxh/p+9uUeEByRV9FHFI+4LcWyGze+bgQbLgpNCBTwPFoJrp2ShgwWl/rIABrT+TE4GXKslSyYmoBIHUCVRiYKOhJNVC/SyQ58hz77yBbxmmZ/6sQQebpud169d64OHeCwdaoC8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 15:44:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/29] drm/amdgpu: add gc v10 golden settings for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:33 -0400
Message-Id: <20210720154349.1599827-14-alexander.deucher@amd.com>
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
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da26dc4d-3ec3-48c2-ad40-08d94b953a87
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126CF938AEA78E785F0F7D2F7E29@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHBlzqr87r8u1MsvY1VWReN177U7sC4BGECl3etVFKf8bFxorzOb5l+KyBHlF5jdCL9RiIDVNSjwvjDqBEAqxBmZ6WpK+/qFJawWhE54cevdqY96fN0K+y9Z6lJN+htN2Xz9pBbqfrweIf2tyEnjCq3VvdnQ71gO9iweweiyizQa5yOhWsjGybycb0ikH+EnAWf5J37RoHD2GS1SQHJ49D+NnKLv/gFqP0ElRKWIow2R1TMK6FWZwXz3imIG/glWzDudf7hhfv6FWMHtPMdtYVE0UAbltP7TcPRuqPmwfks7GgGw8d4/Pj2CNG85bvoNpSo+XHAjwb2Fl1PgHvGzEQUlqpuVv7nd4r4PkAR8WenKLLXpITDJsv7nhz5VUNt3eYGU3v73LaqX9L2h02wFOFIXgC/mafwfldiWfhPFGABLcAa29u24OswppuWNSQJtEqylmQvi46nLDYeDdE8RS3nnEy/U4CY8QQweyQsT8OTsx7bGg5PJhz34yd4f3SnElRteIVAu8XbmT1Q8e79MBXrwQQ9sUJ2QDdd9RZBX7JFjLEXWNGXlg5X7VHIxDmjVEXxxn85CKfd7SZrlLF5IyiUEQZ+Ujt58fO+jOBTf5oZt1nQzqMqIG9yPxEZocG70VPM2VZTSniqDKEFcGC2G8zzfVD70J8qQ1gANYJaIs3MBD/QbLxEzfitEX+ifRT7CmPp/kA4SPYdc9w71Gu5FaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(4326008)(956004)(6916009)(478600001)(36756003)(5660300002)(52116002)(7696005)(6486002)(1076003)(6666004)(2616005)(2906002)(8936002)(38350700002)(38100700002)(66946007)(316002)(66476007)(66556008)(26005)(54906003)(83380400001)(8676002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXyyFZMAXmeylOP0q1TRfdDFuEcRchmNp7Jdn5Dto4zZjw246A47ZumYoScI?=
 =?us-ascii?Q?resipS9z3Wmb+ZeYEBQwGBAMDgPJYWESgI2leLnsruQgzj7Ld/kU5KIUFGtE?=
 =?us-ascii?Q?fqP/K/XCJ4VFETFzgOqxv4zGFS1eR5AnXrk1eQ9ggffT8Kolf04G/Zvxrvsc?=
 =?us-ascii?Q?q1cEWGYzS7OoZHkVeVfkenszpwzj156eSW1znxOMHLG83MGRM50bcSZK9SGN?=
 =?us-ascii?Q?NBAOKhFq5a+Uk8JbjJD+xd0iRXglXDTkzAsGa0z3W2WMyFphqgAfa7UxYUFu?=
 =?us-ascii?Q?cQkSI6DLWI6cQn9yaEs0n0CVdKFYCd6tUEJbSDbOCj/KqUQwqsEMVa5BZ655?=
 =?us-ascii?Q?PJpsB99zophCYse3/SBZ85YhXYrmdjmAxoeHpGichMAnA1EwjA7lIHyxxfMI?=
 =?us-ascii?Q?x/Fp1uHIf3gSr+mZ7ZYOgbfrOI+NPcn6/tZXNx7sCZfsIWRYQr3QXLHE8EMf?=
 =?us-ascii?Q?ZYWVi8IGS68NRMqdy6sDySi8Huu11acF1v6tkJa2AutNtv9lJZsr1kz0TKp2?=
 =?us-ascii?Q?HS1HE/tdYDjohOI8ATxf02wjtRYMBicDrZiYWJiKGO9aJ9ZGLxExSlb7IMlg?=
 =?us-ascii?Q?9lFwOczbTcBwh64AsPIioaTHETtQ/GXqQqFd7n3afKCaGcoWsUwYWnc/D8t6?=
 =?us-ascii?Q?+EpvlCuJ3OwDQtbeijNGcE6ggJkG4pjGp+oG42HR61pmXpjei8s/hxiYsdRv?=
 =?us-ascii?Q?sFWtj+oTdnjhibeE2FrQLjbYy4UUcVpmHAscPuhtJRWkpZSZ4usQx4oS/ybf?=
 =?us-ascii?Q?ngdwZGJBxDhbr8t4rgGORnPzTtnnCPJHOc7gqH9Z5c7m7BEnKcyYKwOI+yMm?=
 =?us-ascii?Q?SjJzZEt+/rjeFa6xwP57mPzFNjz0jUjiOjYvQTg3P/TsgqZ4yijQrCGyjbfK?=
 =?us-ascii?Q?c1qG4OTnHqB0Ig70Ba6SA6+M3P22X5RJTt+pCnIu9WUIkImxpHuReh1yNDYP?=
 =?us-ascii?Q?adtNtqx/dl1001uiJ1hEysXdqGZOgio+JGRbcPWqIe3ZqX5gs8u8JYVGTr6c?=
 =?us-ascii?Q?bcFS/N2JLhqjX+Se2ZQjJffHuWGgKyfXRaqkfei4GKotTLuFsRgG2kbRPUtO?=
 =?us-ascii?Q?W+0bEoo4zKVYdxhwxq42go+PUxIGgT5zGcOPkVzHC/1TQMt5e3GOSW6HaZgz?=
 =?us-ascii?Q?tJpBHL3GJXOq3Em9tqiN9T8CvU91w2I3WwKAKlj65kXlmhWHHAEiUYRNE8uy?=
 =?us-ascii?Q?7hCp497gtnIRC5RVBnDDcnIYjU9JzzlUsOYj3oEeIUQKMuCyeYhTkJLOuZu6?=
 =?us-ascii?Q?cGcKIa8smTPxA7E/PswwKxV9/ua7OwX7yES8U6nTOZ5kNPQF8tgG36dqanT5?=
 =?us-ascii?Q?MHZMVjGTEMHLrYtey9Sho8Oh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da26dc4d-3ec3-48c2-ad40-08d94b953a87
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:15.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ohRUcipcxoRyG/+A3tvwJdNzGChjMR+2QMDl8uWgIkLyDmtvFKuRz3GJrfNuNwummY3sMfjKIe3n4X7lO2Hug==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

v2: squash in updates from Ray

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2808c8bd174a..b91f9ad911ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3522,6 +3522,45 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffbfffff, 0x00a00000)
 };
 
+static const struct soc15_reg_golden golden_settings_gc_10_0_cyan_skillfish[] = {
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGRBM_GFX_INDEX, 0xffffffff, 0xe0000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPG_PSP_DEBUG, 0x0000003f, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPC_PSP_DEBUG, 0x0000003f, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_FAST_CLKS, 0x3fffffff, 0x0000493e),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CLK_CTRL, 0xff7f0fff, 0x3c000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_3, 0xa0000000, 0xa0000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0x00008000, 0x003c8014),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_DRAM_BURST_CTRL, 0x00000010, 0x00000017),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_PIPE_STEER, 0xffffffff, 0xd8d8d8d8),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCH_VC5_ENABLE, 0x00000003, 0x00000003),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCP_SD_CNTL, 0x800007ff, 0x000005ff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG, 0xffffffff, 0x20000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_LAST_OF_BURST_CONFIG, 0xffffffff, 0x03860210),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1800ff, 0x00000044),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x00009d00, 0x00008500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCMC_VM_CACHEABLE_DRAM_ADDRESS_END, 0xffffffff, 0x000fffff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_DRAM_BURST_CTRL, 0x00000010, 0x00000017),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0xfcfcfcfc, 0xd8d8d8d8),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77707770, 0x21302130),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77707770, 0x21302130),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CGTT_SCLK_CTRL, 0x10000000, 0x10000100),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL2, 0xfc02002f, 0x9402002f),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0x00002188, 0x00000188),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x08000009, 0x08000009),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_0, 0xcc3fcc03, 0x842a4c02),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000000f, 0x00000000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffff3109, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000100, 0x00000130),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x00030008, 0x01030000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x00800000, 0x00800000)
+};
+
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
@@ -3754,6 +3793,14 @@ static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 						golden_settings_gc_10_3_5,
 						(const u32)ARRAY_SIZE(golden_settings_gc_10_3_5));
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_0,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_0));
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_10_0_cyan_skillfish,
+						(const u32)ARRAY_SIZE(golden_settings_gc_10_0_cyan_skillfish));
+		break;
 	default:
 		break;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
