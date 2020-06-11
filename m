Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFFC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 11:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6722206C3
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZIzKZqtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6722206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC676E14C;
	Thu, 11 Jun 2020 11:58:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688FE6E14C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 11:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqf86JeWPjaRKdfwjdPpktgwy+pSMg1FxzKfCLHXqHB7Dof50HR7lAzWLK2MkW4/TwQgrFxorhuYG5dcXrWQzGO7jKQn904QeaEltNdKY5262qp/xKDYQlLjW/oP3aOP28aZ6+7Y39IXcJ0h8Ufo3p/KhQFGjd72XoSsqvGJ9b5CzZxTDaxLviCebA/J9DL0Hb5C5JDkIx/QYSLx3dR22XhFkRNfSLrR8Cz5smySTlmU8PcYTciZ0FnPGGmtlLStX7Ukmyw8pwrML7noHXyeKULMNb73hla1XMmxxZA/jVY9dXmHsvmF91rYfi21/yw7xhaAHGTsStxtHEt3pR7BbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdBQTNdh3QkB7zpcvO2IKAVdIvS3blCLumhYatHA/OQ=;
 b=cOvG4zNTZi20GPHY1Oy18X4ynM9/XKfCD7MfNZrIjd0rHYJAhRveinUnTCxjB2Misqi6Ahmh6Jt044G93Ea3KVpu0X9yGj3C979bpyy3I03oody3lMoX4zmpmvgdcKGKjgib94oSdX5XUVlUJLhz1znMn0hlAIJnDoeimSYJVaqMFu/ihY4ZuUqfwjzaSX8GwMwCCUsM9K/lb2MqZuGUeCTaXX9XWIx7WXNgw51Xa2M2JlvBNKX+0OOzqsAjF7+jzxwyw8xRsSstsSd+SY2V8N6Elh5ZVDXZWIlmB0i2gXXF4EOBcMqxcaBe8jvhbknycnsPRf+TbQggQGnjiOTQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdBQTNdh3QkB7zpcvO2IKAVdIvS3blCLumhYatHA/OQ=;
 b=ZIzKZqtRJ2S5GokECxH4cw8R4/YrfAtB9XsgRrzJncaD85E1G2VU3A2OnKzDjOgDsx7XyRblrXZjsDryAp2BK+hK0VxNrVoQM/clnU/NVO2J1Kwrx8j3VlwhYpMgJ+ulvHcQyCAmTCnA2Y10OJtbFeJ6Xz1FutW0OZsHolwciz0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM5PR12MB1211.namprd12.prod.outlook.com (2603:10b6:3:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 11:58:41 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c412:144c:b4d8:3ced]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c412:144c:b4d8:3ced%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 11:58:41 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add SQ_DEBUG_STS_GLOBAL* registers/bits
Date: Thu, 11 Jun 2020 07:58:33 -0400
Message-Id: <20200611115833.2546277-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR08CA0074.namprd08.prod.outlook.com
 (2603:10b6:404:b6::12) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR08CA0074.namprd08.prod.outlook.com (2603:10b6:404:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Thu, 11 Jun 2020 11:58:40 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d21ab75f-ec54-4ba8-7845-08d80dfec8ae
X-MS-TrafficTypeDiagnostic: DM5PR12MB1211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB121147226347B15C06A955D1F7800@DM5PR12MB1211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kohoMj5Zj1PJQduwi8H2prthug/eDh/YjtsuHLmhY1P+/vIHxTXYGf5S0oEL/92LqXpjzZU9DZX/8Y/lXuozMNC+r6HPkF5u9TfukjDDKJxcqS7gtfq6kDHyT5lnH2TKxEFvUYXJnkxobnoTrb3EMcGbH+pokn7+WVQspztu19DBC3gTHT4AMoBH3rZO5xlX+BKTn6IlW4Nz9tAADBzlDvkA3v+DXajiqAHI8JDe1BDM5BMSM/2oZR03AyjGwrrQYv1yJMhCWOBafRvEiHL2elxWDE215gMHBFNIRGILBciAwZEB71yERsDKOMH+7g9RsS+mHR+5zKPOx6y00hWKfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(6486002)(1076003)(86362001)(52116002)(7696005)(8936002)(83380400001)(16526019)(316002)(4326008)(30864003)(66946007)(2616005)(66556008)(6916009)(6666004)(478600001)(186003)(26005)(5660300002)(36756003)(2906002)(66476007)(8676002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cK53vN2AZNDGZrEkhf8xcl5fyt1r/Dx+/2XDC9lPxpmlENEgvK5hUY2H4FYJgqrn5oyVpu9FfyqyqcHMyikK3zjEXaPA/q5aOViUGYxeM1QW5t0aK4uWKW0sULTErMLzZYbkuQxjuGqcFSdpCk4swtneEg3/EEqn7/UigEf41c7ENy2SczqR7MDQg7OSPdq0sZRqnlEmeYkic7HyOb9afF0jKEKIXD/kvst6dW8kyUpcjvFQgAFfKc440mz7JZUub4SdT7FdpDyAEvakfHnn0DoPoMfuvAXv3kR9iGIt08msdXN+rpE/JxrSfkSVBT70LZQbcpcPBCae+UBt/Lx+t2GmBKIl6yKH8i9zAQm+jBr/fbSvrzKzlj3vGQqN9zwfCPPzSIBCG1oklM6giwzDgdn6oRHqpQ0/LROZerrBqoIc/ozqXn/lXxVEG98B4OouJHCzCZlJ4/xpRcz0ASojZRJsWeroEIgqQrrQLMuh2Y4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21ab75f-ec54-4ba8-7845-08d80dfec8ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 11:58:41.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DodxwaxouJ29R18Js3PnTd3ETmUFYUPOiE5YgVwjDnOibLfLZ7OS56a32918PwAwSYpI5tXlnL+uJ2iu+WcVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
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

Even though they are technically MMIO registers I put the bits with the sqind block
for organizational purposes.

Requested for UMR debugging.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  3 ++-
 .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 16 ++++++++++++++
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  3 ++-
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 16 ++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_0_offset.h   |  4 +++-
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h  | 22 +++++++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_1_offset.h   |  4 +++-
 .../amd/include/asic_reg/gc/gc_9_1_sh_mask.h  | 21 ++++++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |  4 +++-
 .../include/asic_reg/gc/gc_9_2_1_sh_mask.h    | 21 ++++++++++++++++++
 10 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 791dc2b3d74a..aab3d22c3b0f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -21,7 +21,8 @@
 #ifndef _gc_10_1_0_OFFSET_HEADER
 #define _gc_10_1_0_OFFSET_HEADER
 
-
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
 
 // addressBlock: gc_sdma0_sdma0dec
 // base address: 0x4980
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
index 355e61bed291..4127896ffcdf 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
@@ -42546,6 +42546,22 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_GLOBAL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE_MASK 0xff0000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE__SHIFT 0x00000010
+#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
+#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0_MASK 0x0000fff0L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1_MASK 0x0fff0000L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1__SHIFT 0x00000010
+
 //SQ_DEBUG_STS_LOCAL
 #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
 #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index a9a66371b75e..16c7f6f2467e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -22,7 +22,8 @@
 #ifndef _gc_10_3_0_OFFSET_HEADER
 #define _gc_10_3_0_OFFSET_HEADER
 
-
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
 
 // addressBlock: gc_sdma0_sdma0dec
 // base address: 0x4980
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index 499a8c3c2693..aac57f714cf1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -46269,6 +46269,22 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_GLOBAL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE_MASK 0xff0000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_COMPUTE__SHIFT 0x00000010
+#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
+#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0_MASK 0x0000fff0L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA0__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1_MASK 0x0fff0000L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SA1__SHIFT 0x00000010
+
 //SQ_DEBUG_STS_LOCAL
 #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
 #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
index fc39795acfda..e3e1a9c1153b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_offset.h
@@ -21,7 +21,9 @@
 #ifndef _gc_9_0_OFFSET_HEADER
 #define _gc_9_0_OFFSET_HEADER
 
-
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index d7964c2bd950..efc16ddf274a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -28350,6 +28350,28 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_GLOBAL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
+#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
+
 //SQ_DEBUG_STS_LOCAL
 #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
 #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
index 2223d4b77dcb..6b1ad9082a2c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_offset.h
@@ -21,7 +21,9 @@
 #ifndef _gc_9_1_OFFSET_HEADER
 #define _gc_9_1_OFFSET_HEADER
 
-
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
index 4acf640b1893..b84bd0fa3015 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_1_sh_mask.h
@@ -29571,6 +29571,27 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_GLOBAL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
+#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
 //SQ_DEBUG_STS_LOCAL
 #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
 #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
index 1c5ef8e8a341..f377354e850e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_offset.h
@@ -21,7 +21,9 @@
 #ifndef _gc_9_2_1_OFFSET_HEADER
 #define _gc_9_2_1_OFFSET_HEADER
 
-
+#define mmSQ_DEBUG_STS_GLOBAL                                                                          0x2309
+#define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x2310
+#define mmSQ_DEBUG_STS_GLOBAL3                                                                         0x2311
 
 // addressBlock: gc_grbmdec
 // base address: 0x8000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
index 088f59cc2197..6199fce51e20 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_2_1_sh_mask.h
@@ -29893,6 +29893,27 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_GLOBAL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1_MASK 0x0000ff00L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX1__SHIFT 0x00000008
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST_MASK 0xff000000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_HOST__SHIFT 0x00000018
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED_MASK 0x00ff0000L
+#define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_IMMED__SHIFT 0x00000010
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD_MASK 0x0000000fL
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_CMD__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG_MASK 0x000000f0L
+#define SQ_DEBUG_STS_GLOBAL3__FIFO_LEVEL_HOST_REG__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__BUSY_MASK 0x00000001L
+#define SQ_DEBUG_STS_GLOBAL__BUSY__SHIFT 0x00000000
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY_MASK 0x00000002L
+#define SQ_DEBUG_STS_GLOBAL__INTERRUPT_MSG_BUSY__SHIFT 0x00000001
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0_MASK 0x0000fff0L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH0__SHIFT 0x00000004
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1_MASK 0x0fff0000L
+#define SQ_DEBUG_STS_GLOBAL__WAVE_LEVEL_SH1__SHIFT 0x00000010
 //SQ_DEBUG_STS_LOCAL
 #define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
 #define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
