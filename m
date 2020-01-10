Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1BC33CA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52592082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h9rH2Afo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52592082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871AE6EA2F;
	Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481E16EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzkYxOvCKjq8Z+HjrRNkUOdNRQAxcOcGUhUDAZwp/6+AFeRwrcS28lWGI8cK7TunPbSWtortPl+LZlWW19m/rxbPL1KoDqxCugTE/IyNwTU2jBGgDJ6YzAFBrUTM3zV3EiEmUz21ErAAcsnGl0BN938VPZzqwkjJkiaA+BR6eO+Y63KnS8YiuxZopHZA6MQu64W8RSGcNSdSakcUu6sfGbolDCIvtBrNxHSTvW3mTveVPnRMMaHjDydU0MMEExu1DDj5rMbftSCP1Cm/a2WW7m1Zn2VTIimveyh2F6IPWmJy61hCkl9a3TXBbtudEXqPSeAf+J89tx3Q8gXAfj2PQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FjwwHM84TaCxRx3hpa0h88tzZ7sPCVBkL9xXuQ4fp0=;
 b=IyozDmf5rNBG9dTlE4SzOo3i8K5ODhvCh3z0ocz0MPs0qRvgNYk380BsvddY3mxN3FdkE/hhEE+ldBWaqUOEogdM+dg4CLjQFP8sZJBKHjZTBehKMWNCg8C8kNwqB9PHHS1pXeB5sVqNn+zaIBc9hAhPGjNvoz+b7ikQLG6sSD6pznqT5MEyFA85oljjMnfLikRW+x5WrXCPNa0K1bJjGFh4DC95EmjDyVG8DL082rXpUBnbHjAipULO7iC35fjPNHouKdHF9vfKR8/pdvt+UNlC0qhmpek0ht/PVjongcZ4/oJfje9uSx43H1YorKT48fmRMZKionkoW+veH3HaMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FjwwHM84TaCxRx3hpa0h88tzZ7sPCVBkL9xXuQ4fp0=;
 b=h9rH2AfonbQ2Wf7B46QsgP3VrHi3SsCElZGGE3UCC9zeDcrm/tbLlFv5y2uZ5X8Z3TViZgykQ1b6nqAH68bSX3+gUgcVdE13sFkNnbb9cN7wG08b8X1nXJfCbGjenqsEGSUAMEh+I26AiBdCu/OwXbAvU8zAl/L2lGTdhZtelek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:21 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:21 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/43] drm/amd/include: Add OCSC registers
Date: Fri, 10 Jan 2020 09:46:13 -0500
Message-Id: <20200110144655.55845-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:20 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39796ea0-5d41-4e68-92b1-08d795dbff77
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25243CDD173FA0E9C9C65BD098380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvhxQDXtDwGUGDtMseCAxDAzTO1+0CWx03wa6P2apuzKjGIruBgE36wBr1hrZ3nDqVBgqeO+879K79D4ADCi/TFykwvQ18d6XbZH8qhejXk76oXy0/9arFr7Urh0rQF2/fv4g1igPnVt0b3B/VrOp1WVjiX135ddgDKGkcielkcRxAhQgvSnCuTZlCf6Yi758L71RQRYJtfXgUOTnMbfS8c9sfS0oGP+M4MS6zuaqsz8T44L+6p3poqfe40FBZz08s4w3t2i5C/c8M7A2Lkdy9Q4xtHQhNr+k2CaYlNAXaAAyTF6O1I7sdBvzpVudvvUi8ej787/3u0SnkttX2UIB+BYFmYrDOVcCabp7P0noXvFsrU6fJy+DsIfCD9rXcejECl22ErD416Lok6MprtrkVoK95+5IkrkK/KtsPQW+9XQIg8Hf8QrzhLslaR7XW7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39796ea0-5d41-4e68-92b1-08d795dbff77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:21.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NerF9vVMc8DO8/3mNrWrbvYvfL/vE59S7RSO6SpG42JF9caffzZZgWrcsPwCFL+YBkgm2mX+YFH2kfY0n+Zg/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Leo Li <sunpeng.li@amd.com>, Bhawanpreet.Lakha@amd.com,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add registers for handling Post Gamma Color Blending (OCSC), which is
useful for conversion from RGB->YUV for HDMI.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_offset.h  | 4 ++++
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h | 9 ++++++++-
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offset.h  | 5 ++++-
 .../gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h | 8 ++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_offset.h
index cff8f91555d3..e9b2bd84cfed 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_offset.h
@@ -8134,6 +8134,10 @@
 #define mmMPC_OUT5_CSC_C33_C34_B                                                                       0x1604
 #define mmMPC_OUT5_CSC_C33_C34_B_BASE_IDX                                                              2
 
+#define mmMPC_OCSC_TEST_DEBUG_INDEX                                                                    0x163b
+#define mmMPC_OCSC_TEST_DEBUG_INDEX_BASE_IDX                                                           2
+#define mmMPC_OCSC_TEST_DEBUG_DATA_BASE_IDX                                                            2
+#define mmMPC_OCSC_TEST_DEBUG_DATA                                                                     0x163c
 
 // addressBlock: dce_dc_mpc_mpc_dcperfmon_dc_perfmon_dispdec
 // base address: 0x5964
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
index 10c83fecd147..dc8ce7aaa0cf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_0_0_sh_mask.h
@@ -28263,7 +28263,14 @@
 #define MPC_OUT5_CSC_C33_C34_B__MPC_OCSC_C34_B__SHIFT                                                         0x10
 #define MPC_OUT5_CSC_C33_C34_B__MPC_OCSC_C33_B_MASK                                                           0x0000FFFFL
 #define MPC_OUT5_CSC_C33_C34_B__MPC_OCSC_C34_B_MASK                                                           0xFFFF0000L
-
+//MPC_OCSC_TEST_DEBUG_INDEX
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_INDEX__SHIFT                                           0x0
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_WRITE_EN__SHIFT                                        0x8
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_INDEX_MASK                                             0x000000FFL
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_WRITE_EN_MASK                                          0x00000100L
+//MPC_OCSC_TEST_DEBUG_DATA
+#define MPC_OCSC_TEST_DEBUG_DATA__MPC_OCSC_TEST_DEBUG_DATA__SHIFT                                             0x0
+#define MPC_OCSC_TEST_DEBUG_DATA__MPC_OCSC_TEST_DEBUG_DATA_MASK                                               0xFFFFFFFFL
 
 // addressBlock: dce_dc_mpc_mpc_dcperfmon_dc_perfmon_dispdec
 //DC_PERFMON17_PERFCOUNTER_CNTL
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offset.h
index eddf83ec1c39..7cd0ee61c030 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_offset.h
@@ -7103,7 +7103,10 @@
 #define mmMPC_OUT3_CSC_C31_C32_B_BASE_IDX                                                              2
 #define mmMPC_OUT3_CSC_C33_C34_B                                                                       0x15ea
 #define mmMPC_OUT3_CSC_C33_C34_B_BASE_IDX                                                              2
-
+#define mmMPC_OCSC_TEST_DEBUG_INDEX                                                                    0x163b
+#define mmMPC_OCSC_TEST_DEBUG_INDEX_BASE_IDX                                                           2
+#define mmMPC_OCSC_TEST_DEBUG_DATA_BASE_IDX                                                            2
+#define mmMPC_OCSC_TEST_DEBUG_DATA                                                                     0x163c
 
 // addressBlock: dce_dc_mpc_mpc_dcperfmon_dc_perfmon_dispdec
 // base address: 0x5964
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
index faa0e76e32b4..2f780aefc722 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_2_1_0_sh_mask.h
@@ -56634,5 +56634,13 @@
 #define AZF0INPUTENDPOINT7_AZALIA_F0_CODEC_INPUT_PIN_CONTROL_INFOFRAME__INFOFRAME_BYTE_5_MASK                 0x00FF0000L
 #define AZF0INPUTENDPOINT7_AZALIA_F0_CODEC_INPUT_PIN_CONTROL_INFOFRAME__INFOFRAME_VALID_MASK                  0x80000000L
 
+//MPC_OCSC_TEST_DEBUG_INDEX
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_INDEX__SHIFT                                           0x0
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_WRITE_EN__SHIFT                                        0x8
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_INDEX_MASK                                             0x000000FFL
+#define MPC_OCSC_TEST_DEBUG_INDEX__MPC_OCSC_TEST_DEBUG_WRITE_EN_MASK                                          0x00000100L
+//MPC_OCSC_TEST_DEBUG_DATA
+#define MPC_OCSC_TEST_DEBUG_DATA__MPC_OCSC_TEST_DEBUG_DATA__SHIFT                                             0x0
+#define MPC_OCSC_TEST_DEBUG_DATA__MPC_OCSC_TEST_DEBUG_DATA_MASK                                               0xFFFFFFFFL
 
 #endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
