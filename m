Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331C3E94605
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 20:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17E810E373;
	Mon,  9 Feb 2026 20:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gy+uJKE3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA43110E373
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 20:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEMEkmZV1dmKpJOEhNeBnlvDaXHS3oY8b8fhSw7VIe6SqTPyDIBX7kLIxS/pPMiyIfDIW0fzO//u7fgJK/zVmgUmp6yBkiUauj5TO6iKb2hO+kCKDMH4ylNQPnxh773AJnp+NIJs8aOt6Mok9xv58rLG5mybtSNjhN0iSfPEvO67xIDl2Ekg3sP+N83lVtq72DrEaCH4fEdbBG2VcfBxYM0PArtSJkD7dmyg6LaKfBIJNNiXY4dUPumaNJuTbTDLeOkqJ0uqm2J4GNTdV21qJcU1XS1dcGpwj69fYUMhKAQZMKLEqmPXibvvR+5rFaw35zfDuvgNq9Hobyw6ql5lHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn5rXWLY4K5KwKHfYod4tLTKaPHS8xC41+eS/XoK6d8=;
 b=GLTHXMPiyExgcgaPspLyXnbF43pzb6odpMIx9zLytai11azu8gAtl6pP11T9HJcyh9o/XX9/ETiQHlQXCQprIeP98bdz5pTBpB3tSEX6axmgwWenzC1wrofntanMNMD5i9i6GYagKlCqngBg3cxTg9HCnp90tlbW/yHiXfUkFauZQB0nxnJaYdg8qox7Y3omaLnUMU8TjrPovYkGuDRYZ6kPEft4HZtp9nSFO3iR7vE/4tZiQhAUTj8r35LfhPGVTjqVYpm24aSekJESGbmCu6YUpWwzr5Dru1aFf469tMPrwD44sRS1l9sS+Xk9/VS33cD5zqoUA+bUoNfvmPVTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn5rXWLY4K5KwKHfYod4tLTKaPHS8xC41+eS/XoK6d8=;
 b=gy+uJKE3gQwLoHDIh58CtCkL2ZgJ1ZK7DcNZgP4ZcX3nySAOQ//3bSRn/j3Edv9dDHqswmo5piembbN3psAvbvi3sA+ypzZnDM2I9kNl/VNMJkIQiEDoE17YR1bYzahYc7zqrbVM2LRqKDfTSEV34jnbTqWJc1AQQioGs4gVXQQ=
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 20:51:35 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::45) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Mon, 9
 Feb 2026 20:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 20:51:34 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Feb 2026 14:51:31 -0600
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, <Kent.Russell@amd.com>,
 <Felix.Kuehling@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Remove dead kernel queue cleanup code
Date: Mon, 9 Feb 2026 15:51:12 -0500
Message-ID: <20260209205112.674894-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: 688822a6-fc6d-4c6d-c1a2-08de681d02ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+hxy6s4wcxrxw9p+4NnlnM2q+FFr7m9FT1/TdnQl6xjeulnP+VRTmXdlEmVs?=
 =?us-ascii?Q?kVrMs2OkabzZHOJPMtoOj/MuRAwLuYzxpE8JrSbyJYcR2yHjL+eiru1TUECh?=
 =?us-ascii?Q?RUQzVaVQIrHizPOCTkYjZxcmkkBNx7Fq+loCLzI2kjR5PauoLrMuBXevsSyF?=
 =?us-ascii?Q?ckla4mttdvZbzoDSRTmVA+OUw5l99N8VvvWZmAoySZod8EqPoFkFOerJCmVa?=
 =?us-ascii?Q?dgov5ZoQUBLWZvi6mRlay40/SDuDT/bRoU23zrfO4cSgeLEFVOWcjL7mDx1V?=
 =?us-ascii?Q?XGKY0yzTGYRzZVSLGdzuqjxO0JNXgvQrQFqMK0jmkYRUBe9sPauvC6Lv+7TM?=
 =?us-ascii?Q?RQZIL0uYnOzo8MOBCb441JIqeJk1ZOFUa6msYxOS1fsrcqmlT3J/Tf1p35dO?=
 =?us-ascii?Q?w1Cx9TAnZQtCkkoERsu9YPkdWKZMeJcg6LpzCFsZw0yJXPOO0fkCR/dM2M00?=
 =?us-ascii?Q?grCgDAD6O9TEfrSf2eUXOfU5Q+lfTY2AAhbsfu8byRGUls/EhKWTROa4KjR3?=
 =?us-ascii?Q?VugKnRRiK9TVxRnA7tMJDAv1LGXgdxB4hJS9Vg8JsIYjLSS2Sr7JjMICZ6Mm?=
 =?us-ascii?Q?87HTlFcWjHBoN3QshA5wbOSQ6B11E833GGnil+lIBLCH7+lrUz8RBcg8+MGp?=
 =?us-ascii?Q?GDegdbKnJD4LcrMxISCkiByci2m/G+erw04XS0mZRgnx50xqDD7H90OvP9dH?=
 =?us-ascii?Q?5wgtQNrZUHTpUvmvTcyNPPHEdlJfLlSrkKSY7pTyghTnr9serzXTtOHa8J13?=
 =?us-ascii?Q?o49tepyXMxbg3/IMml6EUrmGt4v8FHaT2vR5vmcscJ59zDfpB9M0qZe9tf8A?=
 =?us-ascii?Q?hNLjgs+yemhWoWn/e4asSjwLp4Gh4ShWFK4T6xpcrOJbSpR4awntlAg768Gz?=
 =?us-ascii?Q?xLr8KyuGRK6iDKEEtQ3j56Umizk5ChA6ztavdwWmBFj1sxNhUT0Dt/VjVuDb?=
 =?us-ascii?Q?UZ6wNS85e+q3l5BEXmSFkTQmy6fa/GgJsr18bv4Dj/3ByQHiYCzUoJK7WU0w?=
 =?us-ascii?Q?PaEwHMpu5mxD6aMdP6+qyPxt+w1Pck9UoxrWa5c4+6UJzdNT5jgbS5nZj71M?=
 =?us-ascii?Q?BdEv1+7GJ7yw1kFWBhXqu0u9EDFUipCyi/UeMkXlbVCNcKz8PxlPssftfCZC?=
 =?us-ascii?Q?2n6MtjafDzRpS9ASbJjKfst+ci8canvasdf8gS84IUSDQxBVH0Rg8SXVZqQ4?=
 =?us-ascii?Q?IPkg2cvIYbeVsWqVf+VAvKq4Z+6bkq71SUagYdSb/v8ih0rryQxu5KLOEaH+?=
 =?us-ascii?Q?uV2YpLcojLPEAvrWIZ+ivfQOsbU0edWOaiqCzyvBjqU85XLtLvaiekRu9fRG?=
 =?us-ascii?Q?jTMoyYTXKlX/lm0lxYXvuPWG8eaCjEJXMPOX9+HPiD/31/alfpRxL9o61cK/?=
 =?us-ascii?Q?DfU82JwEpdbc+MB6cBjRfl/UR93MAYXf2zxki6xiL33mvgEOKLhESce9p6y7?=
 =?us-ascii?Q?4sjcjLEbFx51h5eR66p+uhIE4TRgkSUUl97lG/gi1HtVi/R1vlaBUubsywiQ?=
 =?us-ascii?Q?tjTjcG1+DdyHlm9a91X0E9UETZ7gyMdq3tLt+V6usVB97E7eGp9t6F5njCK2?=
 =?us-ascii?Q?pXhKlfLTC0YNlczeJv9gM5kZzf6rjORWAFsMX+dk2jMGeVpMt0/B7fBJBDj8?=
 =?us-ascii?Q?uJq6+yFN/EZhlwVUVVBQiCewDUEx1mS9h3QUd3U1G/UVTDQP3OxsHIjzHviH?=
 =?us-ascii?Q?zfmuFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qU8vlvDXMte7mlFmARB2S8Y0vtYFD9Lw2K5XrHucZGAr3m+CCPlHBtVGyYRwQY29Twtg8LpSjAv7FG2i7SMVj2JxuWPuDhc6S5ym/KEaIHQR9pHguDSK3ZPmPt10K04ilDd1DC4FX11aoGzRPW5ejj3CqlXfUqPIRFb/vh3tzm70VLwd4UjwW7f3/ZqEOJjdATwYBPHcv49SQgEHW/mslIk0mgQk2EZaKS7fEw/syJLq0PY0jDja0NSbbVFNaDosesjDPuhcgK3vCYDXtx+K1mPS+ntOM/HiblVQdW688XGZTUv6ikwKenkAtNyEfGXGPvCvN5hXh72+yQ2DJR7Y/xtidHtq9COY56qbuovbr50yaJwkLdcZquorms03+DJNWyL1mL1izQyZuJKAwszhkN1SsQRHlswioDrClEUmRXSlBnTg4n+wPIClznLPnrsX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:51:34.5504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 688822a6-fc6d-4c6d-c1a2-08de681d02ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove leftover kernel queue (kq) cleanup code from pqm_create_queue()
that has been dead since DIQ creation was removed from this function.
local variable kq was initialized to NULL but never actually used in the
function.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 449be58e884c..6d47ef5069b4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -319,7 +319,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	struct kfd_process_device *pdd;
 	struct queue *q;
 	struct process_queue_node *pqn;
-	struct kernel_queue *kq;
 	enum kfd_queue_type type = properties->type;
 	unsigned int max_queues = 127; /* HWS limit */
 
@@ -333,7 +332,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		max_queues = 255;
 
 	q = NULL;
-	kq = NULL;
 
 	pdd = kfd_get_process_device_data(dev, pqm->process);
 	if (!pdd) {
@@ -477,8 +475,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 
 err_create_queue:
 	uninit_queue(q);
-	if (kq)
-		kernel_queue_uninit(kq);
 	kfree(pqn);
 err_allocate_pqn:
 	/* check if queues list is empty unregister process from device */
-- 
2.43.0

