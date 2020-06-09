Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E2C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7540220734
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ibR/reBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7540220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F206E31E;
	Tue,  9 Jun 2020 17:59:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335316E31E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 17:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3hqECtxpo321r+3R1KobsCdKBLzS4Iym8VKoId1qP/YsLqIwNevMQsqceQfU11QaQhHf1soss+f/MAREjh90vOTvBGzhsiB8KYp6pYthcXJP4GT+oeECOr8KmCNrhg1nTJgFokUQO6h+VWAizFvhinMklHBSUArpfsI+bWIOEKxwtsCvh1ELGNhiW2ER4CEgligshQacQZfJlXNQF1owIj+EN3Cng+nZJ9kCelhENXJkluzL2+A9RBZ7VQGW0yKZQBVgZd8EPIeBfmMEc5I+/ZPgCjD6hHT1PRjbqqithoyI1KF9JZdT1rpAok93zYx5fFU9ry4smHVCNFtP9KQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvr3CzWNaAkmfhQ/SHJI+9kIiYu+3DIf/USMRyZ4www=;
 b=Fq8ms4dtUOYUXETSEdjep4n7f/rt5rgNI3beCXF1rOd7RHKViiSYcPvIBEfeT0da70ZtZ7WaMX1BZNc++x4B+M6Ywc5WY9A5KM0KvtI2+zYEmMSz0wvl2gnqnK10gMN9wciEYslkObos6tpPuQqkCKIYaW69CfToB3h24oOVwT/5AHG9AAcx5M+bF0Av31AmUoN3TbHUUrYeaabc0ZyNSm7lRUlxlPqEVsg0saJ7c9i5AH/rSQIOZODUNYridlManMWMrQ+nDjWd2sHanuRzTlVNeCxmlPa+hsuwycIQZze0BPtLnmq9tKW42ikS2NGVq/hMOIzAQPwsIbpjJ9pBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvr3CzWNaAkmfhQ/SHJI+9kIiYu+3DIf/USMRyZ4www=;
 b=ibR/reBfMZLAtJaxHsbhH0/bd7INzz1vI47BLpvQSk+UM0lCzzD+kNu13IkwvXcPK1d2XHahhdjWa3oqe2WyKi9/AjfB/xu0nnZ0FQj/Og7Ti8wZ4ZfIzT1l5XqP4qrVb5kImPu0QeyvwiRaOogHGUojav3OHtXIaEL25bS/x94=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Tue, 9 Jun
 2020 17:59:09 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c412:144c:b4d8:3ced]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c412:144c:b4d8:3ced%5]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 17:59:09 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add SQ debug registers to GFX10 headers
Date: Tue,  9 Jun 2020 13:59:00 -0400
Message-Id: <20200609175900.74139-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:404:c9::17) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:404:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 17:59:08 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74d1a38f-43fc-4a8d-ad35-08d80c9eceeb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31312C55910E5397D1F146BCF7820@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anNAxCcZNi2Gd+NmG74mVO0JdXLGQCs+0WQzLtJ3KxjOQumeEFowvbQAeExjFT95Iuq/LVk1Iie+GoAG+MQz2jLPAaJ+o9T61E9kSFW09sdS0s085N1AG7TLarxforfXCCamDWCMXcjlm9FkPwQ27Jk0Po97ow/CQhv8rUukGF67mV6MhXDi1Z/5XwxcRfZPfGk+tRWGdveewvc7Geuv1s2wilO+b7Rww51Ux5xRTga65kQrZGPoaoU2EtahJNtkn18QqVB3mftmGzgQZPLhq+y5H79aQeulAXFrXxo0QIIWdskchNwiaqTWfS/00qIMCXws+Wk7jdJUL5Zv84Ke5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(4326008)(2906002)(36756003)(316002)(16526019)(26005)(52116002)(6666004)(7696005)(83380400001)(2616005)(956004)(186003)(6486002)(8936002)(66556008)(1076003)(478600001)(8676002)(6916009)(66946007)(66476007)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KZ1QzvgYRV9TKiJjgiDdoKgWF88RyZJvkVcpyG5p+csUdQ/0EVGY7FupAmQHVEwQbxMLcQlfnHSxYA4e+7SLH5j7/rlzWVfK3eT+cz0Uaz1VetA4eQpExfNU/30Flj6mX6EaU/YPwnuAu9K2VvP14JX/nP0Zrm8JH30GNkXUKxCMU1/fkeblPzAW1CjKpmM42j8MGr7y2LkavDg2b4sAJihZPNSzSwkSDhwcRh8O3Jq/wP4di9eYe9F/yU1XKDMSNlRBvm1yw4z0YNNqrjBCCJ/9vD3Psacmwq7aIbJnSSN1TwnizEPwINqsW28bMRrZr+m/zq3L770N25nYoJ07fBIqE/z5xPSQKTouddEgp9MrNLmhQeh2lzeNZSlJSMiv1d/RHiASG8+MKnVI8lQisAg+Xc9VUvzyxq++yRJHJDPFqGh5ElxWkZuWE4ZJs45Ltle7Dp9ceVJdhHgMj+0XdBYCOQme9x+3NapGFO2HZ0g=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d1a38f-43fc-4a8d-ad35-08d80c9eceeb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 17:59:09.1301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opY0ToXgHZlLStjzX8ks8TBUqI44pRH4ybDiCObJVm523YfYgksyApu1uF4wLPzVGC48dG0qWZmJuiSj9GhhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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

Requested for UMR support.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  1 +
 .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 20 +++++++++++++++++++
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  1 +
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 19 ++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 075867d4b1da..791dc2b3d74a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -11151,6 +11151,7 @@
 
 // addressBlock: sqind
 // base address: 0x0
+#define ixSQ_DEBUG_STS_LOCAL                                                                           0x0008
 #define ixSQ_WAVE_MODE                                                                                 0x0101
 #define ixSQ_WAVE_STATUS                                                                               0x0102
 #define ixSQ_WAVE_TRAPSTS                                                                              0x0103
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
index 8b0b9a2a8fed..355e61bed291 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
@@ -42546,6 +42546,26 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_LOCAL
+#define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
+#define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
+#define SQ_DEBUG_STS_LOCAL__WAVE_LEVEL_MASK                                                                   0x000003f0L
+#define SQ_DEBUG_STS_LOCAL__WAVE_LEVEL__SHIFT                                                                 0x00000004
+#define SQ_DEBUG_STS_LOCAL__SQ_BUSY_MASK                                                                      0x00001000L
+#define SQ_DEBUG_STS_LOCAL__SQ_BUSY__SHIFT                                                                    0x0000000C
+#define SQ_DEBUG_STS_LOCAL__IS_BUSY_MASK                                                                      0x00002000L
+#define SQ_DEBUG_STS_LOCAL__IS_BUSY__SHIFT                                                                    0x0000000D
+#define SQ_DEBUG_STS_LOCAL__IB_BUSY_MASK                                                                      0x00004000L
+#define SQ_DEBUG_STS_LOCAL__IB_BUSY__SHIFT                                                                    0x0000000E
+#define SQ_DEBUG_STS_LOCAL__ARB_BUSY_MASK                                                                     0x00008000L
+#define SQ_DEBUG_STS_LOCAL__ARB_BUSY__SHIFT                                                                   0x0000000F
+#define SQ_DEBUG_STS_LOCAL__EXP_BUSY_MASK                                                                     0x00010000L
+#define SQ_DEBUG_STS_LOCAL__EXP_BUSY__SHIFT                                                                   0x00000010
+#define SQ_DEBUG_STS_LOCAL__BRMSG_BUSY_MASK                                                                   0x00020000L
+#define SQ_DEBUG_STS_LOCAL__BRMSG_BUSY__SHIFT                                                                 0x00000011
+#define SQ_DEBUG_STS_LOCAL__VM_BUSY_MASK                                                                      0x00040000L
+#define SQ_DEBUG_STS_LOCAL__VM_BUSY__SHIFT                                                                    0x00000018
+
 //SQ_WAVE_MODE
 #define SQ_WAVE_MODE__FP_ROUND__SHIFT                                                                         0x0
 #define SQ_WAVE_MODE__FP_DENORM__SHIFT                                                                        0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 71c787d66132..a9a66371b75e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -13277,6 +13277,7 @@
 
 // addressBlock: sqind
 // base address: 0x0
+#define ixSQ_DEBUG_STS_LOCAL                                                                           0x0008
 #define ixSQ_WAVE_ACTIVE                                                                               0x000a
 #define ixSQ_WAVE_VALID_AND_IDLE                                                                       0x000b
 #define ixSQ_WAVE_MODE                                                                                 0x0101
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index 00bae8e09f84..499a8c3c2693 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -46269,6 +46269,25 @@
 
 
 // addressBlock: sqind
+//SQ_DEBUG_STS_LOCAL
+#define SQ_DEBUG_STS_LOCAL__BUSY_MASK                                                                         0x00000001L
+#define SQ_DEBUG_STS_LOCAL__BUSY__SHIFT                                                                       0x00000000
+#define SQ_DEBUG_STS_LOCAL__WAVE_LEVEL_MASK                                                                   0x000003f0L
+#define SQ_DEBUG_STS_LOCAL__WAVE_LEVEL__SHIFT                                                                 0x00000004
+#define SQ_DEBUG_STS_LOCAL__SQ_BUSY_MASK                                                                      0x00001000L
+#define SQ_DEBUG_STS_LOCAL__SQ_BUSY__SHIFT                                                                    0x0000000C
+#define SQ_DEBUG_STS_LOCAL__IS_BUSY_MASK                                                                      0x00002000L
+#define SQ_DEBUG_STS_LOCAL__IS_BUSY__SHIFT                                                                    0x0000000D
+#define SQ_DEBUG_STS_LOCAL__IB_BUSY_MASK                                                                      0x00004000L
+#define SQ_DEBUG_STS_LOCAL__IB_BUSY__SHIFT                                                                    0x0000000E
+#define SQ_DEBUG_STS_LOCAL__ARB_BUSY_MASK                                                                     0x00008000L
+#define SQ_DEBUG_STS_LOCAL__ARB_BUSY__SHIFT                                                                   0x0000000F
+#define SQ_DEBUG_STS_LOCAL__EXP_BUSY_MASK                                                                     0x00010000L
+#define SQ_DEBUG_STS_LOCAL__EXP_BUSY__SHIFT                                                                   0x00000010
+#define SQ_DEBUG_STS_LOCAL__BRMSG_BUSY_MASK                                                                   0x00020000L
+#define SQ_DEBUG_STS_LOCAL__BRMSG_BUSY__SHIFT                                                                 0x00000011
+#define SQ_DEBUG_STS_LOCAL__VM_BUSY_MASK                                                                      0x00040000L
+#define SQ_DEBUG_STS_LOCAL__VM_BUSY__SHIFT                                                                    0x00000018
 //SQ_WAVE_ACTIVE
 #define SQ_WAVE_ACTIVE__WAVE_SLOT__SHIFT                                                                      0x0
 #define SQ_WAVE_ACTIVE__WAVE_SLOT_MASK                                                                        0x000FFFFFL
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
