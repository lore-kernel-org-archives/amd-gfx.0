Return-Path: <SRS0=NjTA=G7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D15C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 13:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7E36146D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jan 2021 13:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7E36146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC92F6E95F;
	Thu, 28 Jan 2021 13:42:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23436E95F
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jan 2021 13:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGa91LN61vqoSkzltAGsqo1cv5gGjVGYeiMcszQoFR3hHDXFRcIuPBvnWSNNC99XNydL0MrokSHaPkLF5m5p6Lcn2ZR4ftgwZLc81AKAg7rla5FB+N8hzUvmwWBZ+1xbmES8ZrCBIU56+nhLAuW6v5jvvq1qGygDcRkK/U7rUDa5LU4v/ViQuXu4vvHcTGzb5CZ9tS31/BJwjAg7BOosqfJB7xnkzUcsLMvSIr5Iw/cwnIuSwN7ZjbFboP4PvryHJl5exMG8VzvoBC8ArqQHI1pm+10c8VJzdGrAlePNHW1bkvOCn+76BXxhWIoNLdKdx5f6Qe5ukXILwpia2pVW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=KgmBSspOQvX6uGBpuuW+b1nRn+f9umqrTlU1OcsPR6f6yQyw97yOrk4cPQI7eUkeB7NdrgMJrcBHutxaWYOSEJjelGEFk0lfuBbjXfFIhrGiGqUy+XH2fAP+E5TTwjvcPqA91cSSFBSdVvwJu1VdnrUW9DI06en8JJ9q7/B/6NAwMorSeCodE4nD2EanApFXhS60aRTNEhxouWOdPaWdDdyPfWULZ+jm348kRb9wN1uSqUdrZIaOb+tHt8Gj4D61iJ74ZWDFb0EHZvVnA1zA2+WfgEJJqQKajeJwjYqivMtnbg3wBP+sQdfwNjFCg9uS/LbvT29bjGcNJD1adhxuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ro1JqyJ+dZz00hh7XW/1EAbfRfXIQXE7FvoIkV6rQ=;
 b=LRMzb9l3teuC6vhHjN+bpe1GurXyRjpNmD0I8p7h99szMgs78GDBJiRBg4yCRkZ9n7BRQtYsv/j4WcC0JAYN4TuaVPBzP5q8GZfonFS+nZbX5TC8ucbWfwRJF1I7VZgH5LtMq1wC1L/Ep0xfL9hWlwmGtmOQG/iUHu4X+Y18fis=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 28 Jan
 2021 13:42:16 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:42:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
Date: Thu, 28 Jan 2021 14:41:52 +0100
Message-Id: <20210128134152.38101-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128134152.38101-1-nirmoy.das@amd.com>
References: <20210128134152.38101-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.126.145]
X-ClientProxiedBy: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.126.145) by
 AM0PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:208:3e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 13:42:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb947e52-41d7-419e-8cca-08d8c392863a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4139:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4139C3BD31503A906FF7FFCC8BBA9@DM6PR12MB4139.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:48;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuTbct/F35J0VSVlibFXDHSsbJn5Mif3lv0Ct1zGhY/DdMFp88lwZ66aeHIk8uCwC8gDU65ed5LnxPsHl5JaXo6QllqpmT/gIkrck6ETDElU2UszYpeZl+WyfckcXvzL6P9ahbEq2CnFqruDbrEfs892JLua+FrnLuZTNAmZ9qiRDv7m0tSJAhs9wlle0N19lMxgAsmQcSKAsrhqxp2DaiwUGz6oED3H+I2fmgIQ21gtNYq7JDHhSUl0Rt+Gg0JJc4CsVfgZC8ld1I8vEegREfifEw+rECRLEFKQ7yT7TMog/hWfzeVziHHA1jpZMZQrytZLtJMPNIl6NPhKL0Z4uQ/S/nJyninCj+mLxGxJqfKx5bK9OXHwhPwoZFhicVCbZ2U3QPGWuceGk9NB3K78BCW5CbT6V6piNPY8kIi5vTlehr4K1mW3m1Fbm9edcq0y8a1PSn8lvo956wvPuQEr+FZuzvV/DZCwjMDU9Zs03Udd0zG68GMATl0ePuhF+C2p/Q395PgFq2XvYgMrO+/z9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(86362001)(26005)(16526019)(186003)(8676002)(6486002)(5660300002)(1076003)(44832011)(478600001)(83380400001)(6506007)(2906002)(36756003)(316002)(8936002)(4326008)(66556008)(66476007)(66946007)(6666004)(956004)(2616005)(6916009)(52116002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pww0y7CeZ9D78PvLnEIlR8CkCCibDRT6igrIMD7CYyJIKXjjzT+M0r9R4idk?=
 =?us-ascii?Q?ho4ySopetcFdKsPo0SXNLosqzcuKazplC2TUjHiNaBNFjIyHMA3WYUtul859?=
 =?us-ascii?Q?+YtLuXlT5A6H3CeW6F9Lm7B63b4Uuw3hOiL7ROsGM4f/0cRvKToWhWkbkK2a?=
 =?us-ascii?Q?s+A3MhCacGolWyrUjugAoL0E0dmDaKM38gA6c6GpgJM5oJer+ydkChhKiJGL?=
 =?us-ascii?Q?bgdCTvVnZPQaPoO1kw4CW5RUOCHPveGdy7mY2SWFLmcHWSloZ658xdsqPaqc?=
 =?us-ascii?Q?0E/iLnM2NmuiZ0dDopxtsNL35vSeLJXZzkum6HXXi7g5zYHrUFWi5wy+a/Aw?=
 =?us-ascii?Q?SGBKkjPe78zNnhgWNYE/qNHOuHd2g6hrDOHFBN+byAVA9IX2sgpP4jNhxBH9?=
 =?us-ascii?Q?bL948wOYdbBic+kNU/wyZQXboVWMmRSv+OlCptxWPBl8V9a0IPa28Gg1HBaE?=
 =?us-ascii?Q?WEu/CRNYeYRFxbYfiT2yJfyRzePNysqQ8SAM6xjsOnYLkT31/VY1uld7/445?=
 =?us-ascii?Q?j8hXzmkzP3D559Aaf5GTNyy6IvgKIT1CaRyo0axw4RK03NXinT4xyCfxEFYw?=
 =?us-ascii?Q?4r6ujKo0qDy3VIvRnjq4DXh/95CAN4kAZBT6jeei13jibNKKkrGd+wtyLDSC?=
 =?us-ascii?Q?l480IcQqqBQ+3qY8IceWnVtRyrKrWunpxjl3mK4fH2N+3mAelDWtSEQVJiwP?=
 =?us-ascii?Q?4zXxp0PQ4wFqcJ8C1z/7W0iKmXwiHyVQWrYg6S3RSVSkyPAtJJTLiJQ+I775?=
 =?us-ascii?Q?eNdHqa2+zIc/jGo18pp5wL9KWB9+BQSpVpmr6d+Ru/f4z+Jt/6bEZsaUe3Nf?=
 =?us-ascii?Q?lMhR1DS0gzHvdqEkqe3ehxTwUgr3/xXU937pUXxewWFkH4uEsLXGjxDavIaN?=
 =?us-ascii?Q?7lDhjsPg9Lyegyl0075sXB5dvgI1hWzDxOzUL1ciXwEEFJSTPKmQJZ6Khh8b?=
 =?us-ascii?Q?jbcdWx3wg7Sie7jmOVv+WlSN5nVu8Q8xOPYJsHA7J16uAaoi7OWLkDxCmF96?=
 =?us-ascii?Q?tYi/fjsw0G9/zZPfe90kPjrupQh2bB/TuLagsjGd4+KJAaAHfYGZOYanXYDV?=
 =?us-ascii?Q?IE8dE0Ow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb947e52-41d7-419e-8cca-08d8c392863a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 13:42:16.0239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByE9BcHbpBZ3ancoVwNqBGzs2N10TXg769nI8qIk2Xy02U/65AFAPsmHmyWfmrYo6SgvQ/9mfJeo2S/dq51COw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx wave limiting for gfx jobs before pushing high priority
compute jobs so that high priority compute jobs gets more resources
to finish early.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 024d0a563a65..ee48989dfb4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -195,6 +195,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
 		ring->funcs->emit_mem_sync(ring);

+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);

@@ -295,6 +299,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
+
+	if (ring->funcs->emit_wave_limit && job &&
+	    job->base.s_priority >= DRM_SCHED_PRIORITY_HIGH)
+		ring->funcs->emit_wave_limit(ring, false);
+
 	amdgpu_ring_commit(ring);
 	return 0;
 }
--
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
