Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AAAC433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949B64E33
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949B64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1236E088;
	Sat, 13 Mar 2021 02:44:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB286E087
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 02:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPXn0nkV0EbtPMIfC64j6RYekfdCvw1qdH9YCmwjk7lQhKY3ukzw9CNe9XPA8/2uaQx4ZsPIUQoU6r9WggxeldTvqbOGOru2zmKNgt4YYNTer4tzOJQ6sLHQdLFm4P/Xy4TejohK5VPMITIV/qJQSR2D3uJVUGBtcq+cYKXBCVHa5ubkayW9vuz9ImZA9wK9lpnDgy6eM9aDo7tQ2TVQ9G3C5zLxT6fJwq4csJ2EmHS2f7AtrgPyFNwitRjiOEuoVlhySmD4bYFswO1gjXp9Kh0EPLrZ/FOCQJqYsSgvqPZRhuuF4ufed3k7OZMLPrDZ8jCt0/W3AeeMMcPCgRadFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1iVPDGUHjo1AILTLKGc2R/bRWli9Hvx+GIGXncg9Js=;
 b=i8Cf53U4jOGGT2KyFucW5qpTLvfCGgX2vkhLlV/aSTdphSzY1tBVEtkt1agqsttOhm3Wo+9Mpq4d1YAt996tafFZoKGFJbCTfncI5bs1GVJqOecGe8x1DUed6x0bferJ447FrJewNypiJ0cOQ5nA7d2K5/INjCoUQzRkO1iadtuqSySkucSur2Gp+mKN1ddKKUABkHdANNWNzMpBxaLBFHzsR/xnIujESgxCMqiCp9QumaYVsJ45md9iwvgKOH7Vnky9hKFaurWd0agCFCRIbiXTY+nQMG+AzXSGpkohulFdH9d/yNE2ji2X8mZ6y/XClkUGtjMm/4Hewu/x5urwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1iVPDGUHjo1AILTLKGc2R/bRWli9Hvx+GIGXncg9Js=;
 b=xQ1F1REU9CHuGB36hBnLCOF8Xk4/WqqZlGHzByKJhnUgsXeHKDV9WGXfZytyBuj5SUmS4a4/5a/o8yoriAyohQhfRdDoL316nm226MRqHb7DTe3kSvaB3eNfo2v7vDzM/RQ9vSl8H0MfTNPtQ9qg8FP6R/YUNmToxXzuo0xmk3I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 02:44:10 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 02:44:10 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Fix recursive lock warnings
Date: Fri, 12 Mar 2021 21:43:50 -0500
Message-Id: <20210313024351.10908-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210313024351.10908-1-Felix.Kuehling@amd.com>
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Sat, 13 Mar 2021 02:44:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12cae929-f0f9-49cf-8d85-08d8e5c9e095
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42233B61382A0C93367FF561926E9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fJGFyTt3NZthWLF1p99xRY5k9mWUjBpE5RkjKSqwrYvdtjzRVbwHPbosy/P1nBXC5fJFM+YQv4bIvuE0nuEyDAvNg3k5GaH6cImO4Px7L+GVZvifwsAGHuIPU7UjnPwnIYIYPDyHGpyc4Kri0Zo+VcxzInJZcxpwCENWEI0z4j5EPR6yaptaTFY1FqAE8G9W6je+5VvQTgdr+zv9M7wecUNjGec0qbBrbWDqhfQDPqjnp6UoedhHwM/QXMN34D++ahp4oVcZ+T8jpfvrYmmwHoisxXHPJL33f4AysFLOPGhLTiqr+Y6CFWntO8Bwah9DWcaMxrmcD2YwhzqWa99EavIqh2rFiPhsJbvgjfj2qSWb0mLgf0cHlK+zowHO6QfbPJn8Ggs63AWp2mcB3e7ndaPuZjb4D5Yx5tsN8ayAkW11SKlHPrmvl7fNqjTE3ETNWBY3mufj/Zf1kfmSAuoLKgMOTKTAdXVt7tzaZT/E2yJAgRPmcNTm1pbUH7QrxiNOjJr1A6NLVS2HFVDyUG73qv3Dnaf/TVcp7jQ3/1V2vltlC49XPhnUftxDu60CMr0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(6916009)(66556008)(66476007)(478600001)(66946007)(6486002)(8676002)(36756003)(26005)(8936002)(316002)(2616005)(52116002)(16526019)(6666004)(186003)(5660300002)(86362001)(1076003)(956004)(7696005)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NMNx2ReXk/iCDQc9GHij/vHp/9Xvh4TkRibYd/LVa96RTY7eJfUmvp0AwI3U?=
 =?us-ascii?Q?/+PrC7kFjXxvXYj5jRbET12Luc9k7a5FjqLQ6nCDUSr47RpfahCC516av18j?=
 =?us-ascii?Q?EU7TpiHmZXt9pSqbex1YGFku1kK3nSrlAxAKroIBjM1qeTyXTlf0+/f4sSmu?=
 =?us-ascii?Q?WgX2vn+rdITbT3dUfjluPNun8xtMX/d36Q212c+FC2u3ZZC67MyXcCPyo76f?=
 =?us-ascii?Q?T4ao1YQXefn2KDIo1iTX8tz2FLcv5MxRSmDIQvT4JWGKEDU39pM40LgJR0wG?=
 =?us-ascii?Q?ONrm3Ozdq/Qgf6vjdKu+G7OtSVl3REjeOn/hR84qldeaGCS97ssRBBPZrYRq?=
 =?us-ascii?Q?8oWMqSICSeSFx/mrpGeV/xfOTB4lA6+4AXXo9sNQ2ix9zVBdQygJbFyhZNth?=
 =?us-ascii?Q?+NbdVg33bBL4+cZ/22InbG9mU4BTezynA6fKERU4v3WvMbNqt1drKCsPIYSQ?=
 =?us-ascii?Q?wIKBieP87cYnTzfkSwB1bDGw5P8S9McxkXqAh/O1P2sdSxYNzbCP25GlDLjA?=
 =?us-ascii?Q?zXFExvaTiBU1yF9xUh6hycvHI1dOwDasoUpjbY+OHKYeM7pJDaKDCJuRFiZZ?=
 =?us-ascii?Q?q7InqG8KJFbQmz8xAGKVSK994+E6dTF3dV3M++TTb21iw3knzA6JINFBnO/P?=
 =?us-ascii?Q?mozKSpIJukBEPsA+x7q/WfnYwgdXgVkM9GE49uJzYVLVCyV4ojchfxxN2uJr?=
 =?us-ascii?Q?/qTTb4W6VjySmCE3/VXd7qVm/V1veoLQ8bYprggoAUoOUwjB7zy/9PaRfDwW?=
 =?us-ascii?Q?z13HikMs1dBjTaU1sPRZ2djxueFJoq9Ux9P0as5ygh5F0Gwsr6J+DGByujmn?=
 =?us-ascii?Q?zssy7sJwYB4hoN2OzMGQewHeTzP0LCMwBCHsZT5t692DzgQ/w5gGvNhbH2g4?=
 =?us-ascii?Q?85P+684w5gL9VOhwluL2Q1tY6wMjNTPDX1GcYxQd/15iUyCHX6bcjtlauID5?=
 =?us-ascii?Q?fZKuem1y2uvoSrDy2TuCVg1Phesd6YeOEpvKP9QADZfHwBFbicYQ4hStToZZ?=
 =?us-ascii?Q?VmGLH53MPh/w3dzciVCPKyVIakAkl/doMGfr370tqJa3SqlrpFLuyw5v459N?=
 =?us-ascii?Q?PNRdBkPu12o08mmXq4KTu5y+T7wi0cum9z+akxrKfnXIrZD7H/buB0v35fae?=
 =?us-ascii?Q?ps40/6D0M/ttgPL3UOECi1GPsEJlDzTZxzcENZHS5XIFw9JSFXhxiNOvlNfM?=
 =?us-ascii?Q?lxHHlnDa7gYJ/QZtyjsddUA+UyY989pX0KrI530dqlrlhZ3CF0hZNlRxZeUZ?=
 =?us-ascii?Q?q+5wPyBcdHHE6iZvYHOSKE7CNIsoFssK0k/QO3z1K0ScdKlu9dnhQcnPkAgn?=
 =?us-ascii?Q?4yqPMgtJ4r/sKskAtvWzGRmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cae929-f0f9-49cf-8d85-08d8e5c9e095
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:44:10.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XgXk841oMtGcv1pM9xeaEwI0NReTgqCFmHpaOnX0T//7z0D2Qkb7ATDjjsZd+96vIKGDCr8OuAFfO7DcvAHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

memalloc_nofs_save/restore are no longer sufficient to prevent recursive
lock warnings when holding locks that can be taken in MMU notifiers. Use
memalloc_noreclaim_save/restore instead.

Fixes: f920e413ff9c ("mm: track mmu notifiers in fs_reclaim_acquire/release")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 318eeea577b5..bc3951b71079 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -93,13 +93,13 @@ struct amdgpu_prt_cb {
 static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
 {
 	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_nofs_save();
+	vm->saved_flags = memalloc_noreclaim_save();
 }
 
 static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
 {
 	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_nofs_save();
+		vm->saved_flags = memalloc_noreclaim_save();
 		return 1;
 	}
 	return 0;
@@ -107,7 +107,7 @@ static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
 
 static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 {
-	memalloc_nofs_restore(vm->saved_flags);
+	memalloc_noreclaim_restore(vm->saved_flags);
 	mutex_unlock(&vm->eviction_lock);
 }
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
