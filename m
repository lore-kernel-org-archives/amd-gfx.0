Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F86C11F68
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FD761DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FD761DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3786E8E7;
	Tue, 29 Jun 2021 18:03:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E496E8DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m20AooqaR4wRz/ZLyqJLg9JOEcBCPNiWmnjfYIRgnCnGaOAqsg5EZdf5ddXodq0eMSa7XcdF52LKAXegbqGQZ30rHS7HVwE47CPeHJuTJthRQBn1il/lgWxwH0hV7HgPmNYQZQKUjzQ3CdeT/4H0t/dZ4HIckcvDMX81VjJhYbcvmSrhVZEa7y8jl77YchvJ3DxxVLn/UNIAAHdq076gMTBVVho3kbvLc7SE2bnKPnMvKyViyrL90ykEpW8L5Lma/fYXYiicg3sjrkobCyh/nGQkj72shGBVKZJ8WyKVNJM8t24YudhtXPp7ne3WXb+G5RiAbdlXFBZzjyd2wYvj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW0sBSg9YpGQ895iexSoPWGdAzCiqriof7yZjvGDzsY=;
 b=AtJGn4Eufg3YZ65cxitDv5/5ZtmuPGQWxVV7+FqCTb4mj6IkGtdbWeTKXkUH/eNkZg2XwJ0UikVfOxrBZ4wq3diLYgZkLxYvEtCgeUn+zUjOMWURsYjS1QuvM98iy/nyTNdkkH59q2khMxKItfTS+0BLhjCx6wiX04QXcByD443+Ti9Hg03n7Thcmrms7MvoTxGLhtcUlKxDYmMtjXHTBZdEG0cQm046nw/UyJ6B1t7Ryq48VUrvKfiDATa/djz0qH7IclNNsLMe6I4RkT/LDfrY2igSMu8nA1wVWM38dSNypidXlMIytu4y+UMUUTFpMJFHFOBFl02quuMXl5mZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW0sBSg9YpGQ895iexSoPWGdAzCiqriof7yZjvGDzsY=;
 b=QFVJJA6huI3Ff6Di96XV9SWP28E/8yfhEPpGrMhbrQpm7C5usSvPhT+14alyNBltvTDWvMA56H3r/Z1dFz58Nbl5pK5TMPUeuhAvTTaI81H7iopjGnEFhn8DQxvTI4XHgFs06N3XmvZZtXYpGiwvfqPKpxr8GomyaNjVtmNXAp4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:57 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:57 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/amdkfd: Maintain svm_bo reference in
 page->zone_device_data
Date: Tue, 29 Jun 2021 13:02:05 -0500
Message-Id: <20210629180206.8002-10-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dffe9b1-62f6-473c-302d-08d93b282031
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25426F4B373B91C8B7046185FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19iqUKJ7Pn7M4wnpCfdc9rL8bZBqiaIayyQVSUcKa83h/EbYdV6jMzV9kjVieCHngiq86XV4sQg8J6k9EMZUFzBUGLyCSiQFW8v637Umk18cTjWTnF5xbYSWaZQpnyaIrklu9HrMq/QexMorehTmwtJR1y4UjvpJp+1QB5mKsEcYHlmCzaN06F6TAQXHtZgLbfki+OyGQrH0LuIiylpDp9rWnJQyEnAFhmI8xIyi5vwfgEBej5nXdQDSjmdhhKo2+G0tE3icvnIRwMYxBQo4c/y8s7XScUg4vXRG7Z2WHpGXE7blAX8c8bPfb+0P4TQk8fAec4nUyFRkxerG2aOlFZXa0yhsRZoCJjBAjl/1di+/BptT8c3TVHoxSQXOAW69OKHX0e0WTcUh6sFluvCr5Gzeo27Eyw0BzIWPKfAh1fPLAhWyNCE7VE6TLPoTFgdQ1s1IWfZ3WChpzPyIgZboBL2EtCl1KbADRxw2d28gxoNHUjyvAcWGOLfQvNX3ossDKjY4eGECBAXQJuh3msOXPrfUw9mmPTZrnWr/a33UNhCr98SggNlg0SpS/6xAyyjJtJ0XKs+rChf2+GLAJ17fOxABSq05yZbdOERPqBJ6Kjqzhj7F3NlaD1uHsr2dMCmLrumuYsUhi51M5AVkAadDu531V6sM3Z4ZE/Pq4tgcuZDhZfDoXGZF3yjZ4an/lXXYVKGXP1W+matlkNhO0Ksk4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YNO3BKBo9VaDjIcPrk1rOdEwrw90OzPov6iftItLCDkf2ABIQfXPgrWYvLWJ?=
 =?us-ascii?Q?XVRLagonPL4Nc74pMod5M+v7rhwR+ILJoYco5UYS3SIsn1a1UyzgAP1BREFp?=
 =?us-ascii?Q?l0lzVJjFqjhFMupWinwNgdye9EoK8/YMbfvlYlNm/o26yUNp+pU6IMSUamk0?=
 =?us-ascii?Q?nz6qhZ9a3uExP+ezv7+7+3Gth5x4w3nWXmtpkmut1Id1H+jpSd4oVqbd8JKq?=
 =?us-ascii?Q?FsL0un/6BK4GKaZV6cCD0cT9vYlhUZdEvkLhBwBhDk+n6A/HoMhT10uTj8Jm?=
 =?us-ascii?Q?hBWrDkYHTnbPtnSJlRadjpL95Ao6jzmHvrBM1ouQ8wg0sK8/TZiMfaid0VCc?=
 =?us-ascii?Q?8TKPP0p6rlwgmQMeYwPOJaphYK8RaRvdMA2moTOfbO2mRHx0cV8820t3sYMt?=
 =?us-ascii?Q?VoE8fSw2AmVBHJhKDUvmRIZI0c/Gf6XZMRWtjdeyNmS3BbjCCiNU3MI1igTr?=
 =?us-ascii?Q?RLAC17rVZairKkBxDmSlJr2j/LKb71gLwczO/vOSV+r1aaFFMtao+xEhnceE?=
 =?us-ascii?Q?khsJ1xQONN5CPekNaQdOxxQF0tyoegKXe/hmyLJMYZElhQsiwUJGqyXvi/Hb?=
 =?us-ascii?Q?/6WhvVOsWrBrZDspOmQwKP/BSUfvJc7CGEBjHsiizYIET8jJArmkSGRwyjuP?=
 =?us-ascii?Q?88Ok2Y5N6ys9OF872sl4FgyT+uOijblzQPMPlbOs9A/m//NB+w6aeoLYoJJb?=
 =?us-ascii?Q?BL4TN1xWCuw+ya8rQtwvTNk0bodn3GPHX53kR82PAFZFeqXc7AtHuVhMOPsk?=
 =?us-ascii?Q?18vLt7T+reVtht7a3S6MXiHOCj98e8jYLE2TB019Ka/rUkft/Ijrhgl0UNm7?=
 =?us-ascii?Q?CELRl8zDYBToq8LSBwU80EoELHBHkXg4ImuwHv8d4HM+yDlvrdLnodPyWvrW?=
 =?us-ascii?Q?Y+WcYg2UVIDPXQR72Dzi/UsuRKZsqYiSbQoNTh3Iu2xsA85pDMi5p4XnNNcD?=
 =?us-ascii?Q?LiBj+OflhAA3HtiodZCYV8S9WmKOKIJi3vZy2zx/Qt7Gay9w/YTj0oq8TNas?=
 =?us-ascii?Q?fA+dHbCOAVlrd6oeztoQWMXm9lbmotr4YQBWjYbWcXmLtGp6Mop6aO7xMgsL?=
 =?us-ascii?Q?HjToT1OwSZgYtMct4YSEKWYPQdtpR5YUsMbqoh3TGeppLo9pKlOVOm8HcT4T?=
 =?us-ascii?Q?agkcUmXPwuBw6T14ipPW32jAqPuTM3ZN5pexodFNpPIhzwfT24vPdOZSyoGu?=
 =?us-ascii?Q?/x+dCfsGMg1S4fapzMTzeepHksHkwcbfiSspQMyU6huMaWRLqVTlym8FGrcZ?=
 =?us-ascii?Q?VeVjzrrl2AN3Mbn+5wNiNNBiLiCWlPu40yZlyG64EB/TMy8go3lUFaW4t/3d?=
 =?us-ascii?Q?UfZJdQui5Dsf1P6cNYlpRlct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dffe9b1-62f6-473c-302d-08d93b282031
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:57.6830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHTP6EL3TRZ02Py0vVDI0Sm+CaVulmHYR4TXxU84dKsbVwP7JPR3tr8485TnkgR5CC8gYSLZhGIGXeUEcR48PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Each zone-device page holds a reference to the SVM BO that manages its
backing storage. This is necessary to correctly hold on to the BO in
case zone_device pages are shared with a child-process.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 10 +---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  9 +++++++++
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index e9490236c7fa..21b86c35a4f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -245,7 +245,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	struct page *page;
 
 	page = pfn_to_page(pfn);
-	page->zone_device_data = prange;
+	svm_range_bo_ref(prange->svm_bo);
+	page->zone_device_data = prange->svm_bo;
 	get_page(page);
 	lock_page(page);
 }
@@ -550,7 +551,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 
 static void svm_migrate_page_free(struct page *page)
 {
-	/* Keep this function to avoid warning */
+	struct svm_range_bo *svm_bo = page->zone_device_data;
+
+	if (svm_bo) {
+		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
+		svm_range_bo_unref(svm_bo);
+	}
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6572dea2f115..294c9480a184 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -312,14 +312,6 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 	return true;
 }
 
-static struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
-{
-	if (svm_bo)
-		kref_get(&svm_bo->kref);
-
-	return svm_bo;
-}
-
 static void svm_range_bo_release(struct kref *kref)
 {
 	struct svm_range_bo *svm_bo;
@@ -358,7 +350,7 @@ static void svm_range_bo_release(struct kref *kref)
 	kfree(svm_bo);
 }
 
-static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
+void svm_range_bo_unref(struct svm_range_bo *svm_bo)
 {
 	if (!svm_bo)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 41115a220c2b..3fc1fd8b4fbc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -150,6 +150,14 @@ static inline void svm_range_unlock(struct svm_range *prange)
 	mutex_unlock(&prange->lock);
 }
 
+static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
+{
+	if (svm_bo)
+		kref_get(&svm_bo->kref);
+
+	return svm_bo;
+}
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
@@ -186,6 +194,7 @@ svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
  */
 #define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0)
 
+void svm_range_bo_unref(struct svm_range_bo *svm_bo);
 #else
 
 struct kfd_process;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
