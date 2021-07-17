Return-Path: <SRS0=JwSO=MJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441CC12002
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 02:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CDC613DF
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Jul 2021 02:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CDC613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4106C6E9F9;
	Sat, 17 Jul 2021 02:46:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578C86E9F9
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Jul 2021 02:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6S6P3Dy1tPBXio3KG1u8M9jbV/Xzm4AIvH0QlrGBObZKxphCmAR5esqmBJergfdCn8/5mLrB5tBKSHhgIyCqVb5yG3JABasL9gOaHZR+uR4mbxgTX3KtsHqHlC0PoFl+lYxOSyqjr+bTiT6SmjN9Ev5X1fgQX2OIEKLZnPx/6+HVdkKMyr1tgCFnoTm59KU54KBgwDldDOLRT0g2JQ2d//Ef1x5a17w2dQBCGI/q7z0zuq71VGjlrlfW7bOHZoynlu25rC0L8pBel4Ta6PPhbjI8DARMr07KKgovWCuTzzhv+FXKvzUnOxkTpqDqVkLeVb2RcPE0bJpd6NIt2/crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcdBHHugMCixWnHD2riYekhRT7/0Jeqo9dCrUayknco=;
 b=NP4LuOfsZIpG/0ZGt2jGcC+9Ck1ILSiyD8cpLXdrmH7kYNTOz4OMcQO2c3mqW+Rp2BVEcVKSok9DpZhOMgB3OM5teVK62GSMfKTzuaeCSPmTdTawIl6lr1SeumHjqrWi7g4acI8qCvYdOtcUMw6ddtJcNXuVwngkf6TS4aVsWqTuyxu6cBwfIUWOLXfLYsGtoZO8UH1RapRJ+Fq+BWQH1IlEAp/LdFb/N36VtIw4TYuN0SS1VzHW4LhlL+gsOwuThHO24Uy9Wnl6l1S7yy0buHZfiaNmtWznRRd0QUIdK3FTnxmXSsCdQA28SwmcCE7XghWpmshDI50sbsrGHK9Hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcdBHHugMCixWnHD2riYekhRT7/0Jeqo9dCrUayknco=;
 b=L/FuNzHdg2G/rRRbEKqaptpGlmJZN+JNpS35q7AlcxUYNBF+IzQ4Q3OG9VqeQTrWpBoI9eqX2jQdYLV5j4YSkklG+jfDHNLGBo5IlxjgkPUekAljELA92yiR853ikbuu/DrFgDBTkgU4qGAlYcMJFT65AgoQQtjnWfyaepxcQsI=
Received: from BN8PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:60::28)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Sat, 17 Jul
 2021 02:46:35 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::fc) by BN8PR12CA0015.outlook.office365.com
 (2603:10b6:408:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Sat, 17 Jul 2021 02:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 02:46:34 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 21:46:34 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Allow querying SVM attributes that are clear
Date: Fri, 16 Jul 2021 22:46:21 -0400
Message-ID: <20210717024621.703793-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cabe27f-7c51-4d9d-0ee2-08d948cd177b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2457EF3BB1A15D4229CB579B92109@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYKLioPw7kiFEITBPK32SISTbVukTKlgnP1zl2xPrGzvm7Xh1/EoZeTrR4bK1BUIqgLjMPHqzs+h/5wRvUQdluQ/5lJ2j4AVPG10fd16QH0BiR3+pYMs8b+/TWpLNpnQy5ioaljqG1DOym74o1LMsa4DfuJIP/RfhXtv0OO7F1BUKAzTGkxd/WlIo/YauBjcZxFiQVWtgEi0QR1Q8tQm46wG6mWw7pHqpWD+wirj3fSNtW7aGpcw65xktJu092pLy96Uu73RAMjLaZy1Q9wfiNcKGt3yEed4e/1a8GX0QQf9qgRWD5tpKLu8GywwSms3rcLpIdf/YThyXOqajTIf64ODaWE2FUyFt1M4NvNZz7Gz3angGVRpPJntBsUoLe6+3fiwVyJjeHlk22rh/jjT8MHG5un82A9KXX+SuK44qmoEs8iAOUDjZecGOzVEAzERxJgeDfjgKwKbeIEUkpf/J2lkDO1KS7bPW+kVisLCkE13B3M2zRJL9RlZy+VcSl0srxw5u97bpnGMxBZRMFVS4qbsatZVuiqrF4dLJv6NyIvQF/y19EmdmLz656+lBdzia6A0i7X6cNAiSEwk14koVfmxlJ8nI4yNLV1YBOQj5yQQvksTd6jq4nQsz15HpqjpFshCEgxaGcnc1vgT00sxpqPTz5BdRYKmAtLjyQxUmyBGlLDWw1idOgAKVLcPnFCYjFMRhoO1kgheMYpdTPxEWXLb7HPy6F2BcI3/b8WtHJA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(8676002)(83380400001)(70206006)(8936002)(356005)(6666004)(81166007)(316002)(6916009)(36860700001)(47076005)(70586007)(82310400003)(186003)(336012)(5660300002)(426003)(7696005)(86362001)(2616005)(36756003)(26005)(1076003)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 02:46:34.8542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cabe27f-7c51-4d9d-0ee2-08d948cd177b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently the SVM get_attr call allows querying, which flags are set
in the entire address range. Add the opposite query, which flags are
clear in the entire address range. Both queries can be combined in a
single get_attr call, which allows answering questions such as, "is
this address range coherent, non-coherent, or a mix of both"?

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 19 +++++++++++++------
 include/uapi/linux/kfd_ioctl.h       | 16 +++++++++-------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e7e99c5070b9..c66221a9c02d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3019,7 +3019,8 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct svm_range *prange;
 	uint32_t prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	uint32_t location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	uint32_t flags = 0xffffffff;
+	uint32_t flags_and = 0xffffffff;
+	uint32_t flags_or = 0;
 	int gpuidx;
 	uint32_t i;
 
@@ -3046,12 +3047,12 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 			get_accessible = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 			get_flags = true;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
 			get_granularity = true;
 			break;
-		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			fallthrough;
@@ -3069,7 +3070,8 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	if (!node) {
 		pr_debug("range attrs not found return default values\n");
 		svm_range_set_default_attributes(&location, &prefetch_loc,
-						 &granularity, &flags);
+						 &granularity, &flags_and);
+		flags_or = flags_and;
 		if (p->xnack_enabled)
 			bitmap_copy(bitmap_access, svms->bitmap_supported,
 				    MAX_GPU_INSTANCE);
@@ -3115,8 +3117,10 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 			bitmap_and(bitmap_aip, bitmap_aip,
 				   prange->bitmap_aip, MAX_GPU_INSTANCE);
 		}
-		if (get_flags)
-			flags &= prange->flags;
+		if (get_flags) {
+			flags_and &= prange->flags;
+			flags_or |= prange->flags;
+		}
 
 		if (get_granularity && prange->granularity < granularity)
 			granularity = prange->granularity;
@@ -3150,7 +3154,10 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 				attrs[i].type = KFD_IOCTL_SVM_ATTR_NO_ACCESS;
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
-			attrs[i].value = flags;
+			attrs[i].value = flags_and;
+			break;
+		case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
+			attrs[i].value = ~flags_or;
 			break;
 		case KFD_IOCTL_SVM_ATTR_GRANULARITY:
 			attrs[i].value = (uint32_t)granularity;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 3cb5b5dd9f77..af96af174dc4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -31,9 +31,10 @@
  * - 1.3 - Add SMI events support
  * - 1.4 - Indicate new SRAM EDC bit in device properties
  * - 1.5 - Add SVM API
+ * - 1.6 - Query clear flags in SVM get_attr API
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 5
+#define KFD_IOCTL_MINOR_VERSION 6
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -575,18 +576,19 @@ struct kfd_ioctl_svm_attribute {
  * @KFD_IOCTL_SVM_ATTR_PREFERRED_LOC or
  * @KFD_IOCTL_SVM_ATTR_PREFETCH_LOC resepctively. For
  * @KFD_IOCTL_SVM_ATTR_SET_FLAGS, flags of all pages will be
- * aggregated by bitwise AND. The minimum  migration granularity
- * throughout the range will be returned for
- * @KFD_IOCTL_SVM_ATTR_GRANULARITY.
+ * aggregated by bitwise AND. That means, a flag will be set in the
+ * output, if that flag is set for all pages in the range. For
+ * @KFD_IOCTL_SVM_ATTR_CLR_FLAGS, flags of all pages will be
+ * aggregated by bitwise NOR. That means, a flag will be set in the
+ * output, if that flag is clear for all pages in the range.
+ * The minimum migration granularity throughout the range will be
+ * returned for @KFD_IOCTL_SVM_ATTR_GRANULARITY.
  *
  * Querying of accessibility attributes works by initializing the
  * attribute type to @KFD_IOCTL_SVM_ATTR_ACCESS and the value to the
  * GPUID being queried. Multiple attributes can be given to allow
  * querying multiple GPUIDs. The ioctl function overwrites the
  * attribute type to indicate the access for the specified GPU.
- *
- * @KFD_IOCTL_SVM_ATTR_CLR_FLAGS is invalid for
- * @KFD_IOCTL_SVM_OP_GET_ATTR.
  */
 struct kfd_ioctl_svm_args {
 	__u64 start_addr;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
