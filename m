Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9A8C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 03:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75745246A9
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vObEROOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75745246A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED5F6E1BD;
	Sun, 19 Jan 2020 03:03:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC866E1BD
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 03:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8XOlhrVzvuJJ8x4d1iMG9qZQEVadJZPxpDlD2DmJyPMoz/pQ9J0ZOzj6LhmMcBubxauyc40VGbZLdE5v8kjy0zvw2m3eBUJ2Mkn71Dy0wV2OqlfXdNNaGdBupv9t+uLiNyVWQpHzYgXfSP0oWZ19WPOwSqsZn2ZxBhPTrfvBMhcxIW9a9gRlmcEHbIzrkCOw9l5eSX5HpAtaf4PPNl1u60haGGKwGyHeaIlJGVQD6tQKuKHyS1eVTYloRjRaZAdcqwXNuqG8mAidTRB8DhG+V32S8YXf24glDHiYTSsOYrBEqD9RvpKRXm6Q5D3fNdpSZtWUb3mObIcF0M6pBMovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7YkvghIATIg6G9ALTnL0EB2xHjBP7kg1dCMtVszANs=;
 b=fuZs/ACv8RALxm9P3x0+djCwKsXyE9UfDRmS4riTKQ1xczA3AmVicHYq2ScLu7oClDi7/LiNSnq2x35Wbs8Lo4IpkKRC/6RsNqGBTIhV7hfv+P1iTKgaALzWYfOqcb/OEV+HUE9OfDhnMcijcFV2ueQ1/iySYAyB72qlTSFM+vrL892VyxllqaHimEj7RclHZCA9F+VECACxIMJq76sM9XlpHMUOq99g70zxX+RqYJtzcqKFFgwwVOdERQBzp5kJ3B9uNCsJ0E9GUQRvAUq598nU0k/wPpwzZCRiBT4ITWyZpCm2q3jTvLMafArNIMw1l6RwyyuNVgKCUpKxFcIiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7YkvghIATIg6G9ALTnL0EB2xHjBP7kg1dCMtVszANs=;
 b=vObEROOMfhPS53PyG7Ur2KhWcOzYnjDaguCY0pB7SgUQVrM3y4nMA+qYwHRtuEgaE3pdakA+tHEErTyrfBbagsCMphxNG9mSffn9DRmBNvSQV2Dko6m57rL36JILwjZDIuaH6wYjYL8GhWxsoUO+xqFdID+GrKjP0Ap8UGR33sg=
Received: from DM5PR12CA0070.namprd12.prod.outlook.com (2603:10b6:3:103::32)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Sun, 19 Jan
 2020 03:03:06 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0070.outlook.office365.com
 (2603:10b6:3:103::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Sun, 19 Jan 2020 03:03:06 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 03:03:06 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 18 Jan
 2020 21:03:05 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 18 Jan 2020 21:03:03 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update mmhub 9.4.1 header files for Acrturus
Date: Sun, 19 Jan 2020 11:02:51 +0800
Message-ID: <20200119030252.23853-2-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030252.23853-1-Dennis.Li@amd.com>
References: <20200119030252.23853-1-Dennis.Li@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(428003)(199004)(189003)(8676002)(26005)(1076003)(478600001)(36756003)(186003)(7696005)(316002)(70586007)(426003)(81166006)(336012)(81156014)(70206006)(2616005)(8936002)(30864003)(6636002)(4326008)(86362001)(2906002)(5660300002)(110136005)(6666004)(356004)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4168; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64050cb5-cd23-4a99-d34e-08d79c8c1b25
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:
X-Microsoft-Antispam-PRVS: <CH2PR12MB416838CB858242D4D4DED77EED330@CH2PR12MB4168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d3x2Vc2t+lPK/wTw0tYyzoE6tFFNB+2I5yDbPAfZwtKMXjxmMtdxNFDDDkReYKUpXC8JYp77RIZbjT28WL6PO3fuqUKd2etDXAwNEBzIA4WgnJB1mMCauwsmpGjvPUuPrku6SZO+ast6KmQugRoEj78jdoJaYGrQeyyhg4cpPUK7kv5WTPGUZ6FPkIc0BSFsTuVaDluNeN8KUwtSFd1tnYWJ0WcPHPfXANtqPd5qVEYFU+GrT8Iq6vym8QeFIUzuShq4QaRoYTE1CR+j3XDpXw4ksrYbY6ICWjatxh5+VCdXzKheR3i1Zup6to7MLen7uaEY8jYSyJ0cGi7X7RSwGULs5yfwDvTnVE5chYshTkVmE85jr6UscoMLZ3KKq0yCtDTfICCX01dLIXR65QUmUTbymEPo9NwX1yGW8kLDzgkkUz24IoWcKYnRZbf0LJeutWgZorY+V6TvMz1949VhQYwQ2Ip/PuzUDTemvQmbcE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 03:03:06.0212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64050cb5-cd23-4a99-d34e-08d79c8c1b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add mask & shift definition of MAM_D(0~3)MEM for all mmhub
ranges.

Change-Id: I65c8a3040611198273a4b6da77c1a1ad2ffe7fd3
Signed-off-by: Dennis Li <Dennis.Li@amd.com>
---
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 40dfbf16bd34..111a71b434e2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -11185,6 +11185,14 @@
 #define MMEA0_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA0_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA0_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA0_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA0_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA0_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA0_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA0_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA0_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA0_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA0_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA0_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA0_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA0_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -11193,6 +11201,14 @@
 #define MMEA0_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA0_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA0_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA0_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA0_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA0_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA0_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA0_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA0_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA0_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA0_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA0_DSM_CNTL
 #define MMEA0_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA0_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -14197,6 +14213,14 @@
 #define MMEA1_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA1_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA1_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA1_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA1_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA1_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA1_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA1_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA1_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA1_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA1_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA1_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA1_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA1_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -14205,6 +14229,14 @@
 #define MMEA1_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA1_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA1_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA1_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA1_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA1_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA1_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA1_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA1_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA1_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA1_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA1_DSM_CNTL
 #define MMEA1_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA1_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -17209,6 +17241,14 @@
 #define MMEA2_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA2_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA2_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA2_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA2_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA2_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA2_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA2_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA2_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA2_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA2_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA2_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA2_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA2_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -17217,6 +17257,14 @@
 #define MMEA2_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA2_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA2_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA2_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA2_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA2_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA2_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA2_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA2_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA2_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA2_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA2_DSM_CNTL
 #define MMEA2_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA2_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -20221,6 +20269,14 @@
 #define MMEA3_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA3_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA3_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA3_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA3_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA3_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA3_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA3_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA3_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA3_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA3_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA3_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA3_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA3_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -20229,6 +20285,14 @@
 #define MMEA3_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA3_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA3_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA3_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA3_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA3_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA3_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA3_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA3_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA3_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA3_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA3_DSM_CNTL
 #define MMEA3_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA3_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -23233,6 +23297,14 @@
 #define MMEA4_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA4_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA4_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA4_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA4_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA4_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA4_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA4_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA4_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA4_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA4_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA4_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA4_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA4_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -23241,6 +23313,14 @@
 #define MMEA4_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA4_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA4_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA4_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA4_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA4_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA4_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA4_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA4_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA4_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA4_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA4_DSM_CNTL
 #define MMEA4_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA4_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -34952,6 +35032,14 @@
 #define MMEA5_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA5_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA5_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA5_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA5_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA5_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA5_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA5_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA5_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA5_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA5_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA5_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA5_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA5_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -34960,6 +35048,14 @@
 #define MMEA5_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA5_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA5_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA5_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA5_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA5_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA5_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA5_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA5_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA5_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA5_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA5_DSM_CNTL
 #define MMEA5_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA5_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -37964,6 +38060,14 @@
 #define MMEA6_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA6_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA6_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA6_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA6_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA6_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA6_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA6_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA6_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA6_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA6_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA6_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA6_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA6_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -37972,6 +38076,14 @@
 #define MMEA6_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA6_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA6_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA6_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA6_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA6_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA6_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA6_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA6_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA6_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA6_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA6_DSM_CNTL
 #define MMEA6_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA6_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
@@ -40976,6 +41088,14 @@
 #define MMEA7_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT__SHIFT                                                        0xa
 #define MMEA7_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT__SHIFT                                                        0xc
 #define MMEA7_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT__SHIFT                                                        0xe
+#define MMEA7_EDC_CNT2__MAM_D0MEM_SED_COUNT__SHIFT                                                            0x10
+#define MMEA7_EDC_CNT2__MAM_D1MEM_SED_COUNT__SHIFT                                                            0x12
+#define MMEA7_EDC_CNT2__MAM_D2MEM_SED_COUNT__SHIFT                                                            0x14
+#define MMEA7_EDC_CNT2__MAM_D3MEM_SED_COUNT__SHIFT                                                            0x16
+#define MMEA7_EDC_CNT2__MAM_D0MEM_DED_COUNT__SHIFT                                                            0x18
+#define MMEA7_EDC_CNT2__MAM_D1MEM_DED_COUNT__SHIFT                                                            0x1a
+#define MMEA7_EDC_CNT2__MAM_D2MEM_DED_COUNT__SHIFT                                                            0x1c
+#define MMEA7_EDC_CNT2__MAM_D3MEM_DED_COUNT__SHIFT                                                            0x1e
 #define MMEA7_EDC_CNT2__GMIRD_CMDMEM_SEC_COUNT_MASK                                                           0x00000003L
 #define MMEA7_EDC_CNT2__GMIRD_CMDMEM_DED_COUNT_MASK                                                           0x0000000CL
 #define MMEA7_EDC_CNT2__GMIWR_CMDMEM_SEC_COUNT_MASK                                                           0x00000030L
@@ -40984,6 +41104,14 @@
 #define MMEA7_EDC_CNT2__GMIWR_DATAMEM_DED_COUNT_MASK                                                          0x00000C00L
 #define MMEA7_EDC_CNT2__GMIRD_PAGEMEM_SED_COUNT_MASK                                                          0x00003000L
 #define MMEA7_EDC_CNT2__GMIWR_PAGEMEM_SED_COUNT_MASK                                                          0x0000C000L
+#define MMEA7_EDC_CNT2__MAM_D0MEM_SED_COUNT_MASK                                                              0x00030000L
+#define MMEA7_EDC_CNT2__MAM_D1MEM_SED_COUNT_MASK                                                              0x000C0000L
+#define MMEA7_EDC_CNT2__MAM_D2MEM_SED_COUNT_MASK                                                              0x00300000L
+#define MMEA7_EDC_CNT2__MAM_D3MEM_SED_COUNT_MASK                                                              0x00C00000L
+#define MMEA7_EDC_CNT2__MAM_D0MEM_DED_COUNT_MASK                                                              0x03000000L
+#define MMEA7_EDC_CNT2__MAM_D1MEM_DED_COUNT_MASK                                                              0x0C000000L
+#define MMEA7_EDC_CNT2__MAM_D2MEM_DED_COUNT_MASK                                                              0x30000000L
+#define MMEA7_EDC_CNT2__MAM_D3MEM_DED_COUNT_MASK                                                              0xC0000000L
 //MMEA7_DSM_CNTL
 #define MMEA7_DSM_CNTL__DRAMRD_CMDMEM_DSM_IRRITATOR_DATA__SHIFT                                               0x0
 #define MMEA7_DSM_CNTL__DRAMRD_CMDMEM_ENABLE_SINGLE_WRITE__SHIFT                                              0x2
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
