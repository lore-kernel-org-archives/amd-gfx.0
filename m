Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED9C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2CD23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2CD23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7409C6E8EA;
	Fri,  8 Jan 2021 21:50:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561516E8E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiGqhDgCviqLwgYFwvYOFXaF6vmEC81rOi4f0tlD7S3Vkm99YxlB4DkwgPifZloFgMkjHIS3Vpu3bHWYfKX4mEhkw7modhOJNGTm514+Snbhq1zPbQSQZAy/TdI5Sjh/YgFAKcAd5rXMW9TaoHwe8ZwSm7fBDVCgbmUjkFAIpeOSWe3srBnSacqAuct+3e5N8WfGOXU8UKLfIC45Fo+d2ZVWTn7kgNh1uix/Df4mpbm7idMvOkcUHf4+oLtL/G5XmGkJy76xFCAqsHLLUZ2d3i/oq+BhbO5cuNOo5Spr+c2sVG0M80PywuP92KBSsv8xQ2MTa5hjLuDPhxxsxkvO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULYRnOB1wITt9LrOgSqXIjzTDLbyjX34FoI7IQcAJaA=;
 b=aSRFvHEQgxmJMdSd/bVf6Xh/LXbpHTsQU1Eg3fTFSHQREBA1LUyXGeLfoJIEmDk+olmPtxxy6oVslNB0czReam/F7OkVKy/KwpBfUTfUB9pc6lKIA2Tfibdi1UwxYuUQU39LqkbIC2D+f9d425u4Mv3XETjxCg1+Mc25cnwE/a7AY+KyPP1y1Xz7Rc/uoqLVyc2Y7viNmsCrrE0s6O1z21UqWxak7hiIkxvE1Q5CLczxGW4X7EKqCHSGafOaNTHLsBUOEl/qwyh/05uj16xGTvM0WRfpcK9+TEsi0w71pqOZWrP9XPt/W3SwnhZihNqq0IAZqqmgIFeNdk6vXKlRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULYRnOB1wITt9LrOgSqXIjzTDLbyjX34FoI7IQcAJaA=;
 b=5I7dpYIosaozSG7OS2s3c6iULFUCwQRyKuHLWY7ea489yT9///ABSP/as6WzxPyghbVA6tyYqL84NYH0PHOoQxJ9mhu4J6+HvQ1x1zEp8MOKtanmFwj2IJN84aOshJcg/iB6q1Q7Wmzk4rS8oqwhHExF+sgpcYgQyt0hEFMjthA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:38 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/21] drm/amd/display: Remove HUBP_DISABLE from default
Date: Fri,  8 Jan 2021 16:49:52 -0500
Message-Id: <20210108215007.851249-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7804bce4-5571-4da7-e1dc-08d8b41f6fb4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882D824848F2CAEBF23345D98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Dluif3CfYoX6xsQJlBw9WRi4taYXpcz292zFd/NUK/DMg1sVt3BhfKLkWMyLut3QtuIJ+mA92ouVRBnCIGcAEmBwl3LAvarfDygOWqwNGaWGzoyBnHvzEHzHUM5yXHX4LLl/73shz7vw1Z43oC4fwun6oZUMl7E+xBD2OAia4SHi3KBCLriRPtWbfll1yex2zh0A8NdeRvvZdRIlLkj2w9sPHtQ0v1jnKfbYcBh8Qfl/8M1VdCEUXwER6lSTVI7z58LdctZKpjXmgsV+IhyYWJTLXf/PpAEy1RjVUNtA8k7iPPEqO06VUDT6erT1oDWGSZpf8wSwEYSvuqY4NKzOXk2iBj/CnMk2sA99aDjxKr1i2Kt7QYaLUdIJHSeVkKPb43fxCe2348Bp7QRIzQ/fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hlU9cDH2Scmab00f2l/bic9qD0omZvkANdIIL0NWKaN+Wn9fYMAqdin1Csqu?=
 =?us-ascii?Q?d1T/BLsOaor8A8mPTPz33FOy1GykJ/16fPCJlGSIrcdLGCKB8VlKhCY+eo/Y?=
 =?us-ascii?Q?/XdpUepwrQWIp1w3BRvzC4IRJ04MLKRgYf1LCQe8SJYkOSSVNcJc1P/ttVwZ?=
 =?us-ascii?Q?+89Tpu4HVPAIfB2Njs5wI2PeMjrH5Un72ioWq5iJdroThVxSqE0rm401z+qN?=
 =?us-ascii?Q?AA2UbPP7O3s1JCA/ERvb7Is2M6i95NscdX6epbVk/ANYH/3eF0aFBjtN+SnZ?=
 =?us-ascii?Q?uCOM3qb3m0noBpgsblRzEMpeY9zMaLt2d0ODzv3g/ADD+g+VWlzoNTk7c8Kd?=
 =?us-ascii?Q?uP6tRaqyufgcoCIbTFooaDg8i6BwlI+nXnyyB96oCI+swCrIXVos0cRZJN2R?=
 =?us-ascii?Q?0cU3ZDD9t/A7Q7OqibRyNCliURcZVRLkWuOxJo7uPUHXM9UdFvplJK3gzS7A?=
 =?us-ascii?Q?Vy8N3ZZRrpoOsLyLY1MEQPWkpbKAi3MbIfXKlFAAy/qwXL2EAtMIMgJ7UH2Y?=
 =?us-ascii?Q?j0cl+sNwaaUQMsx8ZyBPqz8HolFo8P39eaBL3hDkvN0JP5VP8V/VKVOxSQO0?=
 =?us-ascii?Q?tQIj0PCigTgEfvSKPF1n4cjYFx3HlTWlQUy8oPdCXlHwAloW11ssTSBfhe+1?=
 =?us-ascii?Q?yzlGirsuf8ALXONk/u6IrL4x/xr1it5/eZPmulZ1DiDys6ADBrCr1ejS4hHO?=
 =?us-ascii?Q?V7NDhRoCEbebil8N9t41aWjDNQv9rLOZtItdVH1vuu2n9yQRHrcZx/QNkd3I?=
 =?us-ascii?Q?6yfkRnSz48b0dBqWxWIg3L4IXmyNc9UUVRZL/pGnBYg1FQHkpVruI0l1Z9ce?=
 =?us-ascii?Q?eN1vJZq9WwVl0PttAgzZ/onEpciqgndBDJspVmKgwcrAPXOklsjxlTr8iUgb?=
 =?us-ascii?Q?mLQ2ln0cWCgmCLt993eNv2h0DEFZqfE8opIAOlLh4yL4tB1tHa9ixj8VWRBj?=
 =?us-ascii?Q?B1h7YDliFHNI514exRZnYluES2zrud+m4DteG99X6tRoav7R6z4RFWrXFcsJ?=
 =?us-ascii?Q?F9yprPXR9aI6FYBgddhlo3dnUjlXIiq0srOBcPC16cB/LkcaXL9xRKvvy3QE?=
 =?us-ascii?Q?NLKM6T0w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:38.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7804bce4-5571-4da7-e1dc-08d8b41f6fb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhyMDjdtitQOX9xpz6PqfY4AvXTbHdxLzwmjzztW2oWkfVDruKIg/e6PGbXauxOQuPYzNJjr2On4TQahvj7+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
HW team plans to rename HUBP_DISABLE to HUBP_SOFT_RESET in future HW
revisions. Those future revisions should not inherit the HUBP_DISABLE
name.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h | 22 ++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index a9a6ed7f4f99..80794fed6e20 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -450,7 +450,6 @@
 
 #define DCN_HUBP_REG_FIELD_BASE_LIST(type) \
 	type HUBP_BLANK_EN;\
-	type HUBP_DISABLE;\
 	type HUBP_TTU_DISABLE;\
 	type HUBP_NO_OUTSTANDING_REQ;\
 	type HUBP_VTG_SEL;\
@@ -644,6 +643,7 @@
 
 #define DCN_HUBP_REG_FIELD_LIST(type) \
 	DCN_HUBP_REG_FIELD_BASE_LIST(type);\
+	type HUBP_DISABLE;\
 	type ALPHA_PLANE_EN
 
 struct dcn_mi_registers {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
index f501c02c244b..98ec1f9171b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
@@ -161,7 +161,7 @@
 	DCN21_HUBP_REG_COMMON_VARIABLE_LIST;\
 	uint32_t DCN_DMDATA_VM_CNTL
 
-#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type) \
+#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
 	DCN_HUBP_REG_FIELD_BASE_LIST(type); \
 	type DMDATA_ADDRESS_HIGH;\
 	type DMDATA_MODE;\
@@ -186,8 +186,12 @@
 	type SURFACE_TRIPLE_BUFFER_ENABLE;\
 	type VMID
 
-#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type) \
-	DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type);\
+#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type) \
+	DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type); \
+	type HUBP_DISABLE
+
+#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
+	DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
 	type REFCYC_PER_VM_GROUP_FLIP;\
 	type REFCYC_PER_VM_REQ_FLIP;\
 	type REFCYC_PER_VM_GROUP_VBLANK;\
@@ -196,8 +200,12 @@
 	type REFCYC_PER_META_CHUNK_FLIP_C; \
 	type VM_GROUP_SIZE
 
-#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST(type) \
-	DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type);\
+#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type) \
+	DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
+	type HUBP_DISABLE
+
+#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
+	DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
 	type PRIMARY_SURFACE_DCC_IND_BLK;\
 	type SECONDARY_SURFACE_DCC_IND_BLK;\
 	type PRIMARY_SURFACE_DCC_IND_BLK_C;\
@@ -216,6 +224,10 @@
 	type ROW_TTU_MODE; \
 	type NUM_PKRS
 
+#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST(type) \
+	DCN30_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
+	type HUBP_DISABLE
+
 struct dcn_hubp2_registers {
 	DCN30_HUBP_REG_COMMON_VARIABLE_LIST;
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
