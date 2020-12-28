Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A8BC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFBC207CC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFBC207CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0626189A5D;
	Mon, 28 Dec 2020 09:18:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72FE689A5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 09:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECn+7Tn+XCvWhPN48bulIgip6MUvTf/t/r8WE+5BsrRhLZPPsZpHIHx2tWo9gI8+4iFnvJ3MQhDBGemh0DqnID5Av1d9EhVFK7s/q1oQNzgg6ZzZyX3O3wq/GBoqvhNQcMGjil/48vcj+ZXCSHsubNIXMWADr4/EVKb3HDZKxw4+o3LkpHf3kl0+Hld+lujURzXD2dJV29+UMCqmnAaqUhUrPUHu0jw72+Shl6rGk6gQaW3P1N4JyM2VMvcrr8McNM9/chRr8pQID8a8Z+QBhD9duC5i3Dvj5iAaEeADGI3+TpFeDiAdEhNszkqEo/QB+vFkc5Pa8M0JT+LXgqzt2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fQNK0h84PS/bT2LhzdlSP/rvtbMEeJr1xpA04pmzZI=;
 b=hjW6Uz8tvzEhVBxhbLE4duRfMdWpP/vtnwNi8dy8Jv0F8jAJoKk/tntTz6loBrDYNCSmsPMjOyYNfp+YO1jMb5T73h3jdYLyM3h0sJfhb34IyCQZacqXB2Pat1MvHtIJ99Udk+ZA68Mic5k/ZZjnov/q2OrqneYN32MT6O1+yLcw6ODovIhom2PFv/+S07q2sJdPyaaq/6razJmjUkewayMzedm2T3CNRlTAzsOXbeNg6C9Z+ZPk3ZoGv4I6o8M3m7c1qebYzcLdbxGERDD4cz7LfXnKwsKltaMV90YDPKVQUmwbpRRG4ORIuTTCi5HXWv0MeI9lBmoFNAV2rMDSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fQNK0h84PS/bT2LhzdlSP/rvtbMEeJr1xpA04pmzZI=;
 b=eGRp5cWB+25HXnm+WFz5FtCuqCCu44Fp3QEjIor5OkNV0W9EynjqPGGP4B4YRiDu6JCgtipJDL1tSmWutzCw2WuacRnaldNzwLIA/Jact3bAp6B8f3z0K6/CWvrVMtrcTbGBPGgyKwde5qUas3ts+Ko6RIZcnv0NLsWiPsD3uzM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 09:18:53 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 09:18:53 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add hdp version 5 functions
Date: Mon, 28 Dec 2020 17:18:31 +0800
Message-Id: <20201228091834.3240927-2-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228091834.3240927-1-likun.gao@amd.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 09:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c5b1800-165d-4d22-12a2-08d8ab119851
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45084D977101F9C08D92BEAFEFD90@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRaiXWujDzpCCli3Q4tlXxJoD8v/kNfB+zgmsLqMPZnGKjaCfAZd4e6/b1xP5CW6VTsvJfw1khRWIC0VsIyiY6DIHaF6O0NFHJE3UQc+QMdJ4ltLx9tmwZchM3Df2jo+VfutvqflWg/3vYvLH/lk6HwSCJSHKuxA4WvWY1yk0asqWHFz7AixiVkcqpZPFUBk3VTWEXy7YLP5gLGhAxV9I5/34cQjTTsLsin+nsI6g3DRO0vs78IQ7n0STxHSVmd8+gEaCBUuMprT8YSjJeSY9WyGRovUWnj33wf71qhNB6BwAw4B9Q3tVfeUuRuOctFUmFcFHgFSFvRkw61+wQ9CIq77q/zKvxF7Yz9rLswV5JF/1Mv+0VI6RworaZqZ6kGH4Cs2ugcpy7FOUJqmVKBuFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(16526019)(66946007)(316002)(2616005)(956004)(478600001)(86362001)(83380400001)(44832011)(4326008)(6666004)(8936002)(8676002)(30864003)(52116002)(36756003)(1076003)(7696005)(6486002)(5660300002)(26005)(54906003)(2906002)(186003)(66556008)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3H0l0ycojkgHSI1Z9azq0Z7gJZFWbdStoJ9MKYYiPAQcr4+oEBdat+kxVKky?=
 =?us-ascii?Q?RId3kJHbzgG9UCzUaqCIc8PsAW78IDRqz/DuwjOdal7XLhW1GZJbiOuuU0/p?=
 =?us-ascii?Q?UfIO8EA/jb3EC1vzx6TDKAhtlGwagk23LRtfGIxJzdmYFYj5272QqIaNpSG6?=
 =?us-ascii?Q?MUMwk7N68oIleqE/K98BM9TZ0XwehkY5qCHhJB6tS6phih62KmfH6XEGxFjI?=
 =?us-ascii?Q?5pL6Pq9F6Z2u++lxi+GmSde0ZK5qbdb8L70t+wfG7i35XuNZ5NipcY0mPSKm?=
 =?us-ascii?Q?suqatW5yedBHAu40cBjq4ikEgiyzCq3TQ3RGg6Dbjj5adnCd10ICo1a7HY+N?=
 =?us-ascii?Q?Ntl0O03mbFgilqQEX5zEN4Ll2tAHhoMOc/wd1geZNrfot1DGitBNa/boStLF?=
 =?us-ascii?Q?bq+3wn4q+JYiWzpT5V+W7IAdO9lIrxNz1+gisY/7gn1GZRevEbv2vkF2D0oM?=
 =?us-ascii?Q?EHDRPP8zzZuCNPMN43z0d8HkeRYEQl9M8Nm9o2H8Kqyy5RuMe72bhEq4XSVe?=
 =?us-ascii?Q?IbYmrscoevuafYPFSq3GDeVb02r3IT55xi7z5++cfVhOIv/ikKQl/wYgbfk0?=
 =?us-ascii?Q?wifdp4R0qE93W2cGP2JTWOrpKnBEo0H6+opRJ/OOYWtOy+Kr43B1ci3Zj69G?=
 =?us-ascii?Q?fPOqe2XeHaSMrlioKUtt8wSPqiBvob3EyDtfAfKnn2RpqniAo/LZtOEKF+Bw?=
 =?us-ascii?Q?DfHLCcJmUUrGwJRRAFMObkyDUG5iLQvYymKX16imDSNVceicgAYprEM44W7j?=
 =?us-ascii?Q?dmiUvWguEiH1I21JlhavorIN1VN6OefLQ02gOPIVcfFHrNc7oKDBunag5mpV?=
 =?us-ascii?Q?sqaNdUmecO7chCYxU8MV7X5e8MPeC+nrqY6Rjv3fu0WeUTHpkr7vL4VEtWQp?=
 =?us-ascii?Q?ugKvYtsoncCiTcKAbdEFBbLo19L6NWFJ5yj0+IEVD7lfoMRnwsLhi4/g/Fs9?=
 =?us-ascii?Q?sbnp3d1oVNEwLeSvC5wslEE3SknOLgrKA0TVQi3mXNcBTDZw2gV8/+x7ica8?=
 =?us-ascii?Q?JDY/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 09:18:52.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b1800-165d-4d22-12a2-08d8ab119851
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxLVt4jcS8UV2mZTmBPxeJXElhEZBAGTPOxuxzkxa61Y6Y0e8rD7JxSeHRm3FsJD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Unfiy hdp related function into hdp structure for hdp version 5.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I5d18a5eb4e4ba20b41b40f0454272ba94224b3b9
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c | 212 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h |  31 ++++
 2 files changed, 243 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
new file mode 100644
index 000000000000..7a15e669b68d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -0,0 +1,212 @@
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v5_0.h"
+
+#include "hdp/hdp_5_0_0_offset.h"
+#include "hdp/hdp_5_0_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
+static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	} else {
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	}
+}
+
+static void hdp_v5_0_update_mem_power_gating(struct amdgpu_device *adev,
+					  bool enable)
+{
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* HDP 5.0 doesn't support dynamic power mode switch,
+	 * disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* only one clock gating mode (LS/DS/SD) can be enabled */
+	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_LS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_LS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_DS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_SD_EN, enable);
+		/* RC should not use shut down mode, fallback to ds */
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	}
+
+	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+	 * be set for SRAM LS/DS/SD */
+	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+			      AMD_CG_SUPPORT_HDP_SD)) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_CTRL_EN, 1);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_CTRL_EN, 1);
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* restore IPH & RC clock override after clock/power mode changing */
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
+}
+
+static void hdp_v5_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t hdp_clk_cntl;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+
+	if (enable) {
+		hdp_clk_cntl &=
+			~(uint32_t)
+			(HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
+	} else {
+		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v5_0_update_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	hdp_v5_0_update_mem_power_gating(adev, enable);
+	hdp_v5_0_update_medium_grain_clock_gating(adev, enable);
+}
+
+static void hdp_v5_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_MGCG */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
+	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
+	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
+}
+
+const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
+	.flush_hdp = hdp_v5_0_flush_hdp,
+	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
+	.update_clock_gating = hdp_v5_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
+	.init_registers = hdp_v5_0_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
new file mode 100644
index 000000000000..2d5ec2b419f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
@@ -0,0 +1,31 @@
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
+#ifndef __HDP_V5_0_H__
+#define __HDP_V5_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v5_0_funcs;
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
