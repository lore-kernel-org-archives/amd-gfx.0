Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20062C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 09:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F0F21D79
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 09:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F0F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF6789DA9;
	Mon,  4 Jan 2021 09:34:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08CA89DA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 09:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4V3JDb77BZ+W+N+DN4bpiq+6nkvaE3UW9onKwwybNQYsy1hZf7mg8yDVdkj86691DqoN1914sd3HSvQFDlPWZ+7zxHWd8xe7vxvEgKQ0ad9iKqGUVowrKQVWjvElW9oqMqaj8XdE77c567Cq/2FQqCLupTqskJpcgsI96x422d+saKjBHU0pLpuomr1mefxbqZtYZ1eSGqFxxXHEPr67wYluyndLpjDyRoBSeDRjZXXW0QjL/0l//WkIkBw9j4bhOrSGc0SRHp2RG6Mgu5/Rv8umrY/ZXjGq/SIHcnDmsrPHiQoJnN2j/MD9+2s3+ttZJ83m1QXYh05z/7rqFRtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3gMtIdFdzJNI1ENpFWItjIDrm2Y8m9RikQKzr5f5Eg=;
 b=SiN9fhUtcVuE3OXVuit8IH/MK/LhmYa9B8JuUb1gLtChsCKnz8FyljNvYXtbUyc8cHCDBOCYkip4xAAKzMUIjKcIUMHvThN1XeWnrbWIR/Gmmu31ov5Q3GYzieuFXksO9cjjbn8rZUCYdwtIXY7VxqzfM5VyqJ83aER2pV/U6ExXawV/TsaPwa6oUs358cJd6XrmJPw/5t0EnU2Xt6ns8Uz2FhiZ1+GXpfDXDjTaHr6V6SVHu37Y1tfPcxpwICCoVEHFOl+Hg13jcNH1Dk5kS0jmha+1+I9A5SSao0YIT1zYGYZn+vSIPdQcOthK96bIOd5ndUAja1fKDtB0PWbqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3gMtIdFdzJNI1ENpFWItjIDrm2Y8m9RikQKzr5f5Eg=;
 b=e9egsD0V9MKDsVLL3ytCr+gwvaNywalmEYA106fNRfVyuf9p4frab6F/XanUSGt+9+uqWXrpZ5qJn0WSjlNDnAIU1dcf7zEso59+YEQPJioci2LngDAiqKT7WjaqDnva3l15NDLXNS7yq0o4J5E8OVpkXyNnMMm5GNiRSkQUyNY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30)
 by BN7PR12MB2657.namprd12.prod.outlook.com (2603:10b6:408:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 09:34:01 +0000
Received: from BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::a440:d0d:9875:252]) by BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::a440:d0d:9875:252%6]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:34:00 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove redundant include of navi10_enum
Date: Mon,  4 Jan 2021 17:33:28 +0800
Message-Id: <20210104093328.113944-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To BN8PR12MB4770.namprd12.prod.outlook.com
 (2603:10b6:408:a1::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HKAPR04CA0002.apcprd04.prod.outlook.com (2603:1096:203:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 09:33:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d1b06da-b95a-40a3-5d79-08d8b093de48
X-MS-TrafficTypeDiagnostic: BN7PR12MB2657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB265783026446F5BE21E91B61EFD20@BN7PR12MB2657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XrCB0lt6ToPY3QFzg8PwVjteKlxvugdv2oVqyjzTBUkj334SU/D7fKKtjYKqjXSk+Tj1NoTnU3UaMChrxaPfg0KMFLJC1vvSzOSXU9wPTi0bmH8dVIQoPjYafa+rb1la7ZB1EucVTWBwf0QBAJGjWfQ2MOwGKEKo5AELmdeY0JgwooR4NUMg13iV7nVgI0auOhq5PW4KneFj4ZhrwhyVUaKsgu7wigAEMherKwJd7iqGJafI/fGDivI4VK0SeBFd2qnoTDv98+m7RDQAVxBGMntJPh6m8z6UFnE+Hv8jFheBnJ2xqi+llkFk+vjbMlumaB9Q43mrBQ1d2AHdrnZPuSePtVO694j/fPdxjtZqEOKR1qHMXlBY3eV8hobAtsl/8odb5EdUcNPU0sN6szutg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB4770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(2616005)(956004)(8676002)(1076003)(26005)(4326008)(86362001)(2906002)(6666004)(7696005)(52116002)(6916009)(83380400001)(16526019)(186003)(6486002)(66556008)(66476007)(54906003)(5660300002)(66946007)(8936002)(478600001)(44832011)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7zdM96/c9aDziUgZYpJqiMvsQIzY1IBcktRu3HfKBmarVDRFVSPpqxzyqf0Y?=
 =?us-ascii?Q?7EnedW+dfJL19S7TGFUhu+4qvKzi3mWckH3uU9YzkvepA5c3Ae3z1XOUqV7u?=
 =?us-ascii?Q?K7qAsILLGzvRjUuyl0pcaH+2K3ASgv+Pfcbele7c/4xNhaBp6Oxdcj0+5atn?=
 =?us-ascii?Q?z+GnV5W/FRnQjT6XrasqgqxAaIDhhu4Kxlxgb/MC2rJQf1zIuyGYU5XME2Wm?=
 =?us-ascii?Q?+Y1DWNRmfQP1Ood9u8B2/pBOZV/zD/Cr13A798fPeJERUwGCqy30TkfJpBz/?=
 =?us-ascii?Q?h6A9cqa6Tx2b6LEMuvDzxHHV2tze6aHITj71RyOEyUvYibWGMpKZjgKWUIdm?=
 =?us-ascii?Q?ImGC7WhxzaX0U3bKtEn3sFP3Y3NJ8goGLPtYFROfPPhoaU01MFW0blufDqqF?=
 =?us-ascii?Q?PCV7+C2Au1+hFE48+xpd9r3xoaG4mKo5eLIeFstPOQajsSatK4g9JUfbe4kM?=
 =?us-ascii?Q?OtX2pKunaWvaY6l9NuHoi72BL0iXtEWRMlk7VKj0L1Gr/CNRmMsQQadROgNL?=
 =?us-ascii?Q?WmXsU5Kbu7muPx+fuHitRxhuLk3bObuqIHYdXfU5eS3L/20CD+iezN6PEQ8P?=
 =?us-ascii?Q?wEkLfAggW6r6Mlp8VWYrXkAXO8EeNWBPM4Y4NILiIbCvGYwsF4aFwJnEh1T2?=
 =?us-ascii?Q?2vrY5ZvcHLNGXWzGMXfEIsmPVXne9wbFvYNrxJJHE6NnUT6lWOHPnm7bdb5M?=
 =?us-ascii?Q?xzm6y6BLwflIgsF6usUtjKIRFAhmMNYfGQFp+NLFEwNwQHBSQjxLWJY8Pq+K?=
 =?us-ascii?Q?o5eRM1PFzxhULhurfFp300q07d4cr3l2MYxHyGpk/kV0rLHBo3QF0TZubLKT?=
 =?us-ascii?Q?tiMw/ZivbkzQrd18qFNcQEMXs7ROLROaTluBsJTV64CN+ZQjusb67vBOwA9y?=
 =?us-ascii?Q?U/Jp5wQQEr7l1Pkz5cJeUC+r7JYwUiyE3yAXgMn5ucISWMwtRskrApuOslqm?=
 =?us-ascii?Q?8IVWMP5quTTmhg6cizxGPpYZFnLVgBAn72B6x7KGtIYCKKTdnStPVu/wVu/W?=
 =?us-ascii?Q?zZLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 09:34:00.8041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1b06da-b95a-40a3-5d79-08d8b093de48
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfZ/3ppjbYgpW79QiFc1q30PAuJ8Sp6wox7v6Yx4gPYF3Tv8XgLKIR77HNGUQJA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2657
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

Remove unnecessary include of navi10_enum header file.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Id9697d0cf68339b3005b634ab5cf2f7bc39e47ef
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 1 -
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c              | 1 -
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c              | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 1529815838f7..fa7e8ff72dfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -23,7 +23,6 @@
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "navi10_enum.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 50016bf9c427..fad3b91f74f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -24,7 +24,6 @@
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_10_3_0_offset.h"
 #include "gc/gc_10_3_0_sh_mask.h"
-#include "navi10_enum.h"
 #include "oss/osssys_5_0_0_offset.h"
 #include "oss/osssys_5_0_0_sh_mask.h"
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
index 921a69abda55..5b90efd6f6d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -27,7 +27,6 @@
 #include "athub/athub_2_0_0_offset.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_default.h"
-#include "navi10_enum.h"
 
 #include "soc15_common.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index 66c183ddd43e..7b1b18350bf9 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -26,7 +26,6 @@
 
 #include "athub/athub_2_1_0_offset.h"
 #include "athub/athub_2_1_0_sh_mask.h"
-#include "navi10_enum.h"
 
 #include "soc15_common.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
