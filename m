Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30042C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0928613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0928613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497FA6E4CB;
	Fri, 21 May 2021 12:46:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E8C6E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjiZSczm1Kok4MNIUKx4arkieUOT23GDFEkzZKIKTs3Gw0sFKJ69VrW9vvVLt2mgNAiHGmCE1k7neV9uZIgyD8EqYGOcCXvGPHXAueMjg+PzcTLhcmeFyYGTExY+rp8y578MWOOU6WbJ94Sm2YrVmvdjtZihQkbN9c3F5IZUd7VzsPl3imSljsmm+ky5PyKxRYFE/2GDt6pOKlNVsi/SLDQjmGnHYU35YlTo89oVhy5hV6jlkjXTHbqazd06QGtuRQYHnn3Y1UI4tOgUAtKSZHVd3l2Pm6elQKPj+PYv4YxVhLyNmQ4TPhsal0pQkh9abPMFoNruAKrKGFT0NLc9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6tsnzCUYvx2GDj+MKdkes9Ke24pqovayd5XYko0tSI=;
 b=M9wrz8R6SfmqTdrWMzDmWnZ4DiDG6ZuzCib0mWFFdrhOxX1x1Ab52ecXFiraZHUJPZ4ns7p4j0JlRFENabCnMCN71L9H6gkF7URA0O2W3P53LsJyKr9TOqbMPNxYp+vh4IPfA00pUMNcKjk+lqMtWd0L+tBs9inMkkkQQ/1DDCrtETxN4BIZkd+7Gm15r0IFFGLhyoo7BCcBe7k2wurR86k+mqar7YnjgDgZZBDhEaOs2OAnGRnFNnJfwDjIfxkJUxIS/RZo2yqHCouVSddVH2FYQWBRbF7YxauDSEjKBKoz99SYwNLc1Ve68PVdP9gJOZ1oEID/bAZrFEGwBtK6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6tsnzCUYvx2GDj+MKdkes9Ke24pqovayd5XYko0tSI=;
 b=5AIhM0tFmChJYJQ6AVqy0+xXGWWwoQddMdxC78x5gG/Jpix8dZaAHH/0BaJItOt+pAU0+MDphhfwR4XCUqEeAjCSM2kTKIJQdyeBbt2EC+XDRCR6oqzDIOG9hQbbJ98KXhgP8mYsL9EOw8/ynKBN76D/sEzyhhbBBRsPNcXEyVI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:54 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:54 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: add a new identifier for amdgpu_bo
Date: Fri, 21 May 2021 14:45:28 +0200
Message-Id: <20210521124533.4380-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b6fbed-3640-433b-d623-08d91c565f78
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB513320E760C275FC876E1E988B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtALZPVM0HWLZWHzeoILpL4Xku64ZjX+ZHrqwmfLwOoO0XtcvFkEEZzGuK1zWxMZHGdeEe84XDArHcL1AGLvv169DEpMowz73STp8hv7ppan20FWUaleLwNfvpH9ercqzp7AZwQknmANB7+eseFH7DOzhbvytqAvoLn9jNwzS4BngSNbMviQl1MqoXyFaOhZNuIT7yuImHxDFvWtBGjOZQLCYagJ8FOn5KfEsdwT/ZFypXYt0xy0ozbuj0PNrTq8MVl27hY1zDCfMmB+rsLGgtM+yrIAO3F7FLfmEm8PQr0vGwqibKIRR+xJdW2V9n/jzerhwgMH77Fi84l3Go/2cNprO4bAXH6Cm6sop12jtZWI975RgpraJS2X8Br0OJUNDepR7FzNKSL5tj1tuYtYH4US1USLR178qTbpGu6cmcOzq32q2fjdSacC300NH3k4yB+JevkYlnjPqXS0Xb76rSQ3sgxylqbLI4uHLH38UIhp/y+lYmJ63qc0E0OLiZ1DoM6NL8gUEAgXtd8SveziKLL3ESKnsO5BdA0TTcLLF26pv88kob/RSgfCKFuYBTdVnvwVDJvXG932ocIUen3AKYxfeOITzQihANI0Gwia6uMigpkwCpuCqmUztId8I4z0o+WOVsd5ugpmN5TPGZwW8L4af3bVXkhdjbqZF10JcJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Xg/bLykjPaOKO10x9uuOjTOMtAFcRNlLr6M9RnIkhEC1fVm3v/A9O3rE027V?=
 =?us-ascii?Q?8mnZrEsXyjOIl0NMlwEt0zYoewTBRs0ZMz+rBWCUaYlykWgAH8Ujt8jyWkx3?=
 =?us-ascii?Q?Syf/qWir/0DlSxg1ut56Cy1X5U1/me7BrmZJoujAoGWRLs/q0TltTluAMh/D?=
 =?us-ascii?Q?Z0CVYZWFqhlSkIRWYv4uB/U7VWsPIpmK+wEP244QxueHNFva39EnZ3GmwC92?=
 =?us-ascii?Q?K7je9+AI9X7iXs/3PJInJVndFJM3cpEECo7KfkP6xtbJCErZ9OlMOzQYkyFo?=
 =?us-ascii?Q?uvwnOwZzXhOarLMRcfJnWmgpC5hG+e+F2hXufUfoI2blMPp9UBlMwWxdzaIW?=
 =?us-ascii?Q?CTthRgRmCWH1qyuBuNhTyGS/N8jHoJu7PPV1CkEpEjfvexqR0YVgtwyq2Flo?=
 =?us-ascii?Q?krOSzLRYEhPPStWPbNMWwB/yjxE4UpI9nG3p+cndpR2lK06lKN+DAVWLFAQ8?=
 =?us-ascii?Q?RGiZKQrmdwTP/nUHaFzpSXcI6ktKS/BFVJPpyXRUcUfXs3R4mNftXiI7aifP?=
 =?us-ascii?Q?nPSfecly4QkhpNm6pubjFh+PiqcMGCnH9EdISZ1HMXuHkk2GTaDaV8HLAvSR?=
 =?us-ascii?Q?+tRZqRmogkhMhDstU6Mb2N8ISDviaSFdhJY/5ao87rXFO1pAmv42zqkMTESd?=
 =?us-ascii?Q?mxAbssjnJ0m3vn3Kxi0832TOjKUJbcwJApZA2pMWY7NVLYCbOilY8P0WUdd7?=
 =?us-ascii?Q?PuRtXRYw6yQMTe38coNTeNBt7oFt5SQLxRxNfy79Zjv17HvqFheIf9Ya86ZT?=
 =?us-ascii?Q?+ifEuMwqICCKYT6zd2Xe3mdttnAjuz50CCwUODGoMy2dng01dRJgXPZk9OTp?=
 =?us-ascii?Q?qEIeOgPIEtMPRWRKL1nVBVxFfVwfwvOqVyVZHWl3IPFzSxRqNjHh7viCrYve?=
 =?us-ascii?Q?Wrwv6oYl3IDtgpH8+50N+u/XwHcbYDuI5Gf88PJJ7biDEL9x7yMRKlzcrojN?=
 =?us-ascii?Q?hJBWtiHsSW6NUnTIcPmw2y95GBCBj5yCqU3egMRd84WCEPtFYpL1asgHRMu2?=
 =?us-ascii?Q?eAU0pTVe1e2Xg/xVj6r0pTsBmMBXqd7wjVAY6ZYjbL+WV42yM85LSSumzWqI?=
 =?us-ascii?Q?g1x6s8ukbbeo8cHOXfM95p33nLzRqcdhQQbtlP58/Swh2nnvmhIxrnPsAhNQ?=
 =?us-ascii?Q?iq3N5uqtJjIDUpo0/joszMbU3+YL2QaBUK/sIrLEjSMNsZKiWFyobAMVuOUb?=
 =?us-ascii?Q?M5p8AnNrrRTA7i3Xu9WWLk1BX7Sz5VQmAEGDC/1E+LyYeozUV00pA8KdsC/M?=
 =?us-ascii?Q?7Th4w891aRpt+I+3wJ38ZvwwuwU3flxXzGHwsEbYIeoUQR0K0PTf4YCrS7yd?=
 =?us-ascii?Q?ZWyE6IWhqF5wTt5t5SMUGCaI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6fbed-3640-433b-d623-08d91c565f78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:54.5330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuZclXqvOp5H/xPozqVCqop+GuHddoi/BS6vNY3ZT70oIxeDZ03CwbFwLmi7EBA1HNUAwrMmPeMM1c1XXs4iuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add has_shadow to identify if a BO is shadowed.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 61b1edcb490a..eb3ce33cbfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -619,6 +619,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	}
 	if (!bp->resv)
 		amdgpu_bo_unreserve(bo);
+	bo->has_shadow = false;
 	*bo_ptr = bo;
 
 	trace_amdgpu_bo_create(bo);
@@ -657,6 +658,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	r = amdgpu_bo_create(adev, &bp, &bo->shadow);
 	if (!r) {
 		bo->shadow->parent = amdgpu_bo_ref(bo);
+		bo->has_shadow = true;
 		mutex_lock(&adev->shadow_list_lock);
 		list_add_tail(&bo->shadow->shadow_list, &adev->shadow_list);
 		mutex_unlock(&adev->shadow_list_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a7fbf5f7051e..3a0e6ca88563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -104,9 +104,8 @@ struct amdgpu_bo {
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
 	struct amdgpu_bo		*parent;
-	struct amdgpu_bo		*shadow;
-
-
+	struct amdgpu_bo                *shadow;
+	bool				has_shadow;
 
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
