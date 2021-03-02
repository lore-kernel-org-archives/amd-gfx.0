Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B976EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459F364EF4
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 11:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459F364EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A49B6E147;
	Tue,  2 Mar 2021 11:34:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E2B6E10F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 11:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOUuKXWxGxZdZhlGj03NB9YKysPBoLmqOemQOOOnrgGz+AjLb6VkajHfrE+VU7NZTOJNeiQknd9eNbbGOLPaV+PhZucMHl4/oUCmZ/Ds1cF+NCyAltOS6YTjQG28nBXUq25pztpOPwuYXrcCLTpcgzAPCAA+s7VaVAydrZ4/x76j9AtNXkluwXfcp6DN8T1rI411jf1NvQkY2Qf5t3I6IzBucauEsn4vxEizK+T+wecor7wEHfn+F/uv+Fqt283y/bmtjTsSurgNTP6HZbgVPozSjFKayZ+A0Lgo5MRwFXSq4KJIlfxftZZ5ih5vBJk7KyxD1m3PZ37fvaGJYnT/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR287VyeTYTgDNUMpxqowU2KfRRpDhFuQ81f6u6+AoM=;
 b=RpQJIXKXh2EpNR5gvCRe7yxrSeaUg8VvId2TpiDZo4FMsA37PAEFMdTmr4VI9+xynyAOwPQRWGTthlqhdFNGtr9/32kToivKcWVpEPI9Uszj3brFOjRpEZyopjZXUBhHbyyg4tVOi7VUR5Xc+G/5EExwusgRartiMc8xx63DZl5q3tYqxKetqaGVNNnJ6ltIbW91WDvvrRlbkakj901It1XpW7YZw2aWTMx7nhYiY66ESInv1T0d5DTvDQ2Qpcw+GtDzotrRLjHcPQdT5J/3hZ7sEObLW+BsotkoxdsE8z07b3BikWz64bqCC9XlNcASsZ1CVveOlw+b8pTzsYpbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR287VyeTYTgDNUMpxqowU2KfRRpDhFuQ81f6u6+AoM=;
 b=gYcZa42jSuKKfXb+WIicxHsLfolm9jfheaRvyd+OXt5MfBy5WsZcNnIIf3SJrjx9fL9znzZuLyg4z8AJ5WduaEafyD/+Qm78/LDSw+tzFPkpPmXSo6RyJHhfEVetHdL37KZ3nAwOONS0Av0xgC1toeMrzEEn4nJ2pBCsbtnoKwE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1381.namprd12.prod.outlook.com (2603:10b6:903:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 11:34:01 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 11:34:01 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com
Subject: [PATCH 1/3] drm/amdgpu: drm/amdkfd: split amdgpu_mn_register
Date: Tue,  2 Mar 2021 12:33:39 +0100
Message-Id: <20210302113341.74813-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [93.229.44.238]
X-ClientProxiedBy: AM0PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:208:55::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.44.238) by
 AM0PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:208:55::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 2 Mar 2021 11:33:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 216f7c37-0083-4d19-ef49-08d8dd6f134d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1381B04982AA36E87D8650138B999@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFIBoC1pPGTlx635McuPWHOWrt2o6LjI4w2JEGNfyDbEgNXrKDJnueHjbvAWGuApYfI7Wd6dflWZK5vzurSv7pymizsKt1Rrh8eRJW6vutk0K+IpK/ohwbg757tO7AS2+NYTz/mll/zpgOccT4mdQ4dhwA1PY8g/xldq9L4kUhSneg1YSWLrmbueXba0NX6587ksAqEWwbQ1CalS6mrKY94Ag46bNJKvYerZlSPjrmfT+qC8d8+30M7cHDNpFbjjXLuyoNgpd0mTMXwR7MImQ0HbG5HgNpwjA0mudu+xj4D0GGEltTiilx5A5/t6YI5G5lIim13+s9X7WBTQK5tGBhU1Rufw6IXvQniiRcviVnsDrEPKKw/FmdRvyeZmnz+Y0ChS81h3ALa/OIVwMxsJY8qnQKpSFQerQd+enon07qfleaBTOwXNv3JAhz2PGumXHwnJ5GmpdGeyu/tLLTps7nQzgupj7vgZhiPSeERyMvC5dt4+tOzNy6SCc3oerE6/scaylYA4HfUVlfBBjshLWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(478600001)(8676002)(8936002)(1076003)(44832011)(5660300002)(36756003)(66556008)(316002)(6512007)(86362001)(66476007)(66946007)(83380400001)(4326008)(6506007)(52116002)(186003)(16526019)(26005)(2906002)(6666004)(6636002)(956004)(6486002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qqB4ohfw2ySLj6FMo6+qEj+1EQUZ+pxiNtI9Xlztw/4JXKBrS6L57MfXJOUQ?=
 =?us-ascii?Q?jwOCH9gFjH0pP1+m4riH1/GSWdQOtMlyyOUDOLeZpYfcWrST1FNHNmg65cpT?=
 =?us-ascii?Q?VTEUjmbTdyooL2R6GPOUOUGt5OsJio5RfIHKHqd42e8z9lH6Iym043by4ke0?=
 =?us-ascii?Q?nPHYXFtndqcPo8XPmDcbKvtECQR3C+5Gd9yCFKdk7bKMyoXAFr71v3ZK6foa?=
 =?us-ascii?Q?wJe1DPcwcN6S8yh/5m+QXU0l0Rr2lO6Z8VIsgh7GH1uD84BcRAHGZIi1G0Pz?=
 =?us-ascii?Q?ylYs7iY9YzYn32y3ZLcrQPgfdh/ZMuQ+bIY/urAm4JgIl1aBy5sIdQn7CAFC?=
 =?us-ascii?Q?RDfwMufJiA2FTO4PHbCOVXqnf8RfxdrPFqkl5HdSImjzH0PiwoDOiEIehwK/?=
 =?us-ascii?Q?C/X/IoKNEWTq8o1H6UIahn38xaC/zmNU5sumK3j/iqdO8wIhVeNwG5UNPIPa?=
 =?us-ascii?Q?Fuai8SCRt+y7xpogbL+Fr/yjMOLEbqVxR+FfBJvZkNxACWv11ijOngVml6Fb?=
 =?us-ascii?Q?I3AuKOa5dr2xxP06pVWHqe+Okmv9671XeWUu4OR//Jhktvtt67MWeRoQCC4E?=
 =?us-ascii?Q?xe6+vh4y/VVCsn7/23/4EXmOeGENMHaRtF9wV032vio4l/yijm7KBPXRujHq?=
 =?us-ascii?Q?LtARNoRPJMoyYIbpZB5JOcotf0cP+60Q5uYg18dam0PepfBoiOuDoZ5xf0lc?=
 =?us-ascii?Q?nnhdMN6qPkTMXsVU/sBo2orVI4wbUsNk9T3QKCvfISpLdw1LwK5EQW0CCX1E?=
 =?us-ascii?Q?KYKXeDQG1tOuokra37P+aCzWVt7yzjfO2fMueEvCZ+KoO4PJ7ImFD0ONHtnL?=
 =?us-ascii?Q?hDvYQauVpjrdoIP8auT/PnONSr7oC+X8slWjuzPPRcxXbErnaoyKzgetIQWN?=
 =?us-ascii?Q?FA1G/2UrvmR+V3y4cOm+khEy1z3uxP+V5eEnTDFe/kq3c+yPSmAa9XirpeCu?=
 =?us-ascii?Q?jBW2ylxBXtckOxqyMjeRI/YnA0dYKiuSvmF/yXQqhmfEYqdKRJrQ4Yr9FK5t?=
 =?us-ascii?Q?AVLLLo3DbthrgEfzWAbOmKyMnv4wtxbp8r1lMkxxPmOtn3jIaIk2WU8I7v9R?=
 =?us-ascii?Q?YL2CQTI/TsReN33uQJ+vTwnTJBVbdxuS1WSqMBSDYT1nNpNocJlz7D52/QVo?=
 =?us-ascii?Q?/2SVcVwKqPQmoHWrrK4XOiNTa7NlNROdJyGUZGCxES4JPZ8Q4DD/PsU0BYor?=
 =?us-ascii?Q?aSGaeRVQnRSH20imQFTC1O/MbpICUMup7glqa96OdlLW0BPy688/5L2BB4vU?=
 =?us-ascii?Q?6z08WB9LjPt10/lF1tS8RTAYdVylYuZKWBt4CSk08lrT/AnurATkZgygGrsk?=
 =?us-ascii?Q?RCA1jeBP34HkypXtVsqkhm2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f7c37-0083-4d19-ef49-08d8dd6f134d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 11:34:01.0007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no+nkW4Po3EdMHIw+kAZvdI0LL6JCu8sV0MZkbXkNu2+kSsUZI6F5C5wZWDsKqNuthwLAc3HQw6NTKa149jyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Split amdgpu_mn_register() into two functions to avoid unnecessary
bo->kfd_bo check.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        | 21 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |  8 +++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 99ad4e1d0896..89d0e4f7c6a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -571,7 +571,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr)
 		goto out;
 	}
 
-	ret = amdgpu_mn_register(bo, user_addr);
+	ret = amdgpu_mn_register_hsa(bo, user_addr);
 	if (ret) {
 		pr_err("%s: Failed to register MMU notifier: %d\n",
 		       __func__, ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 828b5167ff12..1da67cf812b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -132,15 +132,28 @@ static const struct mmu_interval_notifier_ops amdgpu_mn_hsa_ops = {
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
-	if (bo->kfd_bo)
-		return mmu_interval_notifier_insert(&bo->notifier, current->mm,
-						    addr, amdgpu_bo_size(bo),
-						    &amdgpu_mn_hsa_ops);
 	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
 					    amdgpu_bo_size(bo),
 					    &amdgpu_mn_gfx_ops);
 }
 
+/**
+ * amdgpu_mn_register_hsa - register a BO for notifier updates
+ *
+ * @bo: amdgpu buffer object
+ * @addr: userptr addr we should monitor
+ *
+ * Registers a mmu_notifier for the given kfd BO at the specified address.
+ * Returns 0 on success, -ERRNO if anything goes wrong.
+ */
+
+int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr)
+{
+	return mmu_interval_notifier_insert(&bo->notifier, current->mm, addr,
+					    amdgpu_bo_size(bo),
+					    &amdgpu_mn_hsa_ops);
+}
+
 /**
  * amdgpu_mn_unregister - unregister a BO for notifier updates
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index a292238f75eb..565ee5a0a3ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -32,6 +32,7 @@
 
 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
+int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr);
 void amdgpu_mn_unregister(struct amdgpu_bo *bo);
 #else
 static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
@@ -40,6 +41,13 @@ static inline int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
 	return -ENODEV;
 }
+
+static inline int amdgpu_mn_register_hsa(struct amdgpu_bo *bo, unsigned long addr)
+{
+	DRM_WARN_ONCE("HMM_MIRROR kernel config option is not enabled, "
+		      "add CONFIG_ZONE_DEVICE=y in config file to fix this\n");
+	return -ENODEV;
+}
 static inline void amdgpu_mn_unregister(struct amdgpu_bo *bo) {}
 #endif
 
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
