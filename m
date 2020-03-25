Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F574C2D0E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238C1206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y+NbNhiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C1206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54C189C61;
	Wed, 25 Mar 2020 19:17:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4680989C61
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 19:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gARjsctD1wrTkKyQTSCsRVyjyXBHn5anhPKHhvPnRI4RweaY/6mfn7RSV9kmr5Q9WyMaQB2FwfKU4d6uvLTpMc7RHDJeXFcMWej05MBlZwkN7yFCQOOQys4/tdqy1KTFA6BW1G1Xe4zw6any1cjy+/40ewgRef6Rvzc0Hr9CGF8DS4tUQzsoA9aMHDFmHtY/ThW8vuAOeieWcK1DzIvnIG36p1mksYdtBgziK7vO75iQoNMbEMiITHzGZCoq6p4DoF94hnJxBj/WH7o6AvjFF0VOC1ceyf5wXrrh906tZRStT4v5heEoJjRhX/DZ4lOMn6ch3SMbtn22yRHltfDX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fULq2TFSOEOabwUfyiJ0GG4XfXijiWmQMFdUYm5sj4U=;
 b=IWAdSlSb6Rc1xQ3ehospi93J8RMZEw0im3Kd2Hc6ZH64CXk396Gf250ciFCT5SAtpBrTdXa7kOJ6IoqAUhYPPOv/CaAlt/q5qZOJ9WMh4e+duij+SXJhR4LVHmDKBahiP7sa0zfDtpdlO+dov2cT+fxYeGowFrodFeB4GjpbSfg3XpK6Z4n5PNCd9vRFLIDjpTKvbb7UjqQ/P4mgv4Oc5YFPcG+RUu+TqKP1Qp6haaBUaCHWjijSiamJveDfKZR2VCcl2X8eQjyPqloe8TLm4mVNK278FFUqDei7l6JQ5SvZCU7au0WGusrwa8JXZbUc08LKGHDkjo2YYxMRaH8xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fULq2TFSOEOabwUfyiJ0GG4XfXijiWmQMFdUYm5sj4U=;
 b=y+NbNhiSiHcrXzjIfJirT4o3LQYzScTAUoxFBjYZg5Hs6oJOP+xQezj8OxRBDP169hwhvwoxqkYiQAk7P498VbUnihzHPDIoDmxSGdb2xAXeKDyGMK4F32SluQNag2jkqr9/v7/H37iyYPorJYXBfcSyV4jKaGcJ2HyiWLEXFww=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) by
 DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Wed, 25 Mar 2020 19:17:51 +0000
Received: from DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d]) by DM5PR12MB1674.namprd12.prod.outlook.com
 ([fe80::c0af:ab9b:b8de:7c4d%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 19:17:51 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix SMUIO/PWR Confusion
Date: Wed, 25 Mar 2020 15:17:43 -0400
Message-Id: <20200325191743.717237-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN4PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:403:1::24) To DM5PR12MB1674.namprd12.prod.outlook.com
 (2603:10b6:4:11::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN4PR11CA0014.namprd11.prod.outlook.com (2603:10b6:403:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 19:17:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d25aa46f-db5b-4642-75b2-08d7d0f1362d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:|DM5PR12MB1307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1307F7FBB8F0DE0F4BE84A7BF7CE0@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(6916009)(66476007)(66556008)(316002)(26005)(66946007)(16526019)(86362001)(7696005)(36756003)(478600001)(186003)(52116002)(8936002)(6486002)(4326008)(81166006)(8676002)(5660300002)(956004)(2616005)(6666004)(81156014)(1076003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1307;
 H:DM5PR12MB1674.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm7/uW45rqvmMf1CMz0S/Vd59B7f+grt83cHZDTK72NMZ9tX/IPQQGiG9T+IiPdHrwyeG2n7L/b+quL9uf5QgIKEMFGDzq4cvYUsGVIWSbZ+e7C44hP5vpvGQ/slLuGqn3lzl1p6S0Ipz+a3AXUUSFogPMqXvvHJvSnL+oqxl9E6HnLmytkiZPZPgsfWk53kxJKwOvJi0YNEW/ZsZt7s89Jla9TkBwkb9PGKVbBegc2UwGmdhALXzBXO1vye2NlLkp65IrvFauUUspMfLicrTp2lSX6u8v15KzSJZtgbUixfR5vRQ0FNQRypy1AuK2uupJJwuE01PVAnvz9SjM7a5BC5d4JnFpmE1O0/pxNm2fIEX/OeMfrh5CKmGq1Ik/7w3j2TMBw80H241Jpa7ah874aLPArCciM4OZg/HFr4954VNkJ4L65wg6B1tql7w2QW
X-MS-Exchange-AntiSpam-MessageData: 5i1jsTfwyHZwdYydIFvvI/4W4IscXvCyCLUuuk6VI8wfn2WUraRGVDvktNzwPF0lJ9yoaCLDf5AZVKm/TZ8ep4Hw4W99UDjcSLMtrKxMeghJFEDUkxiL2tw+xpAebAXXyApFKY6JSeyIhokWcsJcRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25aa46f-db5b-4642-75b2-08d7d0f1362d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 19:17:51.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM9ihtX7Gg8aJGe/I0twGn1NeKdPwCFi0DNeTbEMXhTtSfWMtcx6CvZ4ia+NpA4V2Jy9J6A4LAwAnpgRV91SJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The PWR block was merged into the SMUIO block by revision 12 so we add
that to the smuio_12_0_0 headers and then create a new smio_10_0_0 that
raven1 can use in conjunction with the pwr_10_0 headers.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../asic_reg/smuio/smuio_10_0_0_offset.h      | 27 ++++++++++++++++++
 .../asic_reg/smuio/smuio_10_0_0_sh_mask.h     | 28 +++++++++++++++++++
 .../asic_reg/smuio/smuio_12_0_0_offset.h      |  3 ++
 .../asic_reg/smuio/smuio_12_0_0_sh_mask.h     |  5 ++++
 4 files changed, 63 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_offset.h
new file mode 100644
index 000000000000..cad22fe8134b
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_offset.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _smuio_10_0_0_OFFSET_HEADER
+#define _smuio_10_0_0_OFFSET_HEADER
+
+#define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
+#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_sh_mask.h
new file mode 100644
index 000000000000..f4cddb9a16b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_0_sh_mask.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _smuio_10_0_0_SH_MASK_HEADER
+#define _smuio_10_0_0_SH_MASK_HEADER
+
+//SMUIO_GFX_MISC_CNTL
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
index 327b4d09f66d..9bf73284ad73 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_offset.h
@@ -24,4 +24,7 @@
 #define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
 #define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
 
+#define mmPWR_MISC_CNTL_STATUS                                                                         0x0183
+#define mmPWR_MISC_CNTL_STATUS_BASE_IDX                                                                1
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
index d815452cfd15..26556fa3d054 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_12_0_0_sh_mask.h
@@ -24,5 +24,10 @@
 //SMUIO_GFX_MISC_CNTL
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
 #define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+//PWR_MISC_CNTL_STATUS
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN__SHIFT                                                      0x0
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS__SHIFT                                                        0x1
+#define PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK                                                        0x00000001L
+#define PWR_MISC_CNTL_STATUS__PWR_GFXOFF_STATUS_MASK                                                          0x00000006L
 
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
