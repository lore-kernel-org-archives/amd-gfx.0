Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F7C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5766192F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5766192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47936E8D4;
	Tue, 29 Jun 2021 18:02:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50F26E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvYeZLqhbjku4gP5k7GEb4hoyksolff6+62s+nqnVGC5DUkwyWRF1p5orS/YnPF107dY48X+aYccK7hxLXNZ2CYxhpb7yS90Wkmdit8YwbTl1zO+8TRjX97FJCI7FjnK0O4wkHaDG0K/vcyfGaERSbA+semBtQzMsSdJV7TJyZVk54SkApngdha6KwKoXWcVtU1Itk9v91J+RNlqoYouxfeVgHt9M91WyQdGsDH8+kqwV9qrQKodA9GxDRufBhFiDeAwXhvhTqysR66t9ni1P3WOQb5Z0PYzmm5eG1u1JgW5T38C50Fjk29AtsstP4p9XnzG5ynibuFpBOrBrWOpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kvtnwuzBaUiLFSyXJnozDrtOftDwlecIO2v4Q1/noA=;
 b=dc40sEww384F03IWX4RvLQkxjCHZ55nIY3rPMh5kqkYrIgRZ8nBWZ4+tZtzf/WP4mwBgHGVIXjZN0EuJdFsO9WF1aYJEd+KsBmDYohT1FgAhxLh3G0TYvem58FRnAgFp3CS5hcheoFoGKfEEYtE+dCb/y3XBlwuVqXPvHz5g7dP7k+s4QZfNnRWsySDdF3a16trvW7XQ+0pmb/D9zM6ZmfML890xjAAQ9XDFt4ESFOzAUF85Ya63JLQgZRXY2/TLCQva61QHpHX3uo4xYV3zIzeMUfPSAJbewgOzGnurH3graiQeMU5dgahMOHfP6MWrU1Xed3CXOwZO4U2mQfTE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kvtnwuzBaUiLFSyXJnozDrtOftDwlecIO2v4Q1/noA=;
 b=4x2jho9J8ut0hWXmcLew3p6KG4Z3HFMW28Aoak/jSGrH+ztu889V9Wijy2qlo9YjEHfRn3g9bstHtPmaqkQypr+lvuelw+2dSbKg5HoYr9OkJvxvjC/wo77xXYYQyBp/kmThUES2Simk3RSDw/qW2pUDHlhzmy8NYi/UX/Y8Nw8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:52 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:52 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/amdkfd: device pgmap owner at the svm migrate init
Date: Tue, 29 Jun 2021 13:01:56 -0500
Message-Id: <20210629180206.8002-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994a05b0-5ac7-4ee1-f2a9-08d93b281d16
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542612508C602C924566A55FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYnf1+5XZXT2NA7VOqLD+CHfTetH/Z12+O8J90DnJgGjA3bI/eiMUwyg+nkIbdQEP25IBy3Pen0N+NSWrm/W46Tbqr4aOdYVH3GNlyJTiHKHHPbDbAtA7Mwnj0P9/0bjTo88Ozh0TCNLiHD/ItTuk2wZai0vmoQoBU0vRKk54ZUmvB7qAc1t2Nj9rjF5jgDYQB67tFBl+6IYZuo+kogdqvWK6MQlMEL5GuLzypyecb54DM8GnmhfW9We2t6wvftnZqGijQN+nCjAZbyM8PIDG6Awofk77l1vZkBYrCTqn2hAdD0kBEKiiIkeLI9e/CYzPVJgUg06B+qTJOWPZrwD7GWIhzGxqJ21BTTJTTN0dO4WsVx75+lh7kMqWMwkj/54OUvPE3Wr/g6JxD1XtK1dZviUoPtZ7xpXRypkRtrDUsplPHDY2Lhe6koA7gDLlZ0XKT326ORX+NUlPunHgGeBSsh7TrIfOF6PIQ/3NnsToFBu0EOsonZB//qf+9R/TF1d1EwjFqIrE/wKBB98LaIvCCPswYlNPavaMBrR39Z3cw6rEbokjCf6jCBIs1YpQcXMJLedjmIrzCEoRmaW7Gkdt4ps0NoNhdD3TSQaClzfNaTLClmkKx3/Ersjew0QINMWW7YBBiX4//Uu+G952PsV0nkBOb+22RNArSzjYE+xYgaHVewcn9WdHshQ916fhygD+kWXseA5aE63cWfgKgNvjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(83380400001)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2rxdsJI1DN8xy5vd3f5HnqEZHNzrKz+vEzhj1/r8L+mSFV5gTs4vCbdlqQ3?=
 =?us-ascii?Q?pzBmBIwIcqaJpmR6d/BUQNr7U2ImSROqBJqOiWpFoudrDaSFN4CXJftQOgZb?=
 =?us-ascii?Q?ZnNX+EMtSWJ4G6DFx6YGrKCjIlmoyjc8Yz6AomRtFZdDppC1QvrfndAsSA3S?=
 =?us-ascii?Q?d5b6cnsEA76TXxvOe4+TGuZSmHE4pzZhcU2oZz3JJZ/HGB3nN0O+9RtyDI+O?=
 =?us-ascii?Q?qkl6UvQPo/Kc51s/fOFm+vvCQ0eaGly06Wwo4T3BNfm1Dtfa5qQt4vGO0bfJ?=
 =?us-ascii?Q?Z8ryuPlN06y2lwUyM7G98xac9afSPw6CKeUCKVKUQxtlX+bSdV0eZSab5NxA?=
 =?us-ascii?Q?UsSv2mvioQiLu2Y+0PJI8EnEKYJrQLFok2QALBSIaHUAUsXPH3VG/YjMowSN?=
 =?us-ascii?Q?Dm1GmkCJjkKsLfJd/1V+l9Pi5cjdxjXB53ovouJM7wHxDHeMPrp5+v9+SnMc?=
 =?us-ascii?Q?qZlxjrT2RmO7DC271SN4EiOlknPWA1vp5EHkNbQwKUKjNx1ExOpdQYduSEvm?=
 =?us-ascii?Q?axF5mxIW2igcrPtAr7oyfEWKDN2iI2tUi1QG/ju4unARV88CAA+lHJMV+Lyu?=
 =?us-ascii?Q?Apj1EL1EflqC/B9uZuHY6AKVVA6gunzWsbCrxuiu1YKOPjJ3I7yOf12Xe6I/?=
 =?us-ascii?Q?bAu463RGqJE5acbNPY3e8M/QGYdK7pHtwUCggjxFNPb1iUV8AkHXMqSKjNju?=
 =?us-ascii?Q?T1vrwB1+NpUDxxH2qMOK8PqRaynTUZ6mAme2ch0kA8LFQ748ElJ9wv0S2zA9?=
 =?us-ascii?Q?yn1VzVd0frBbteeCu1hCtj5LQ4mjdAVvyblC3Q4b/oh+h7reBSdJm3h5EFlc?=
 =?us-ascii?Q?ukTW+U+RJyevj1iNDW2xaxQtgf5GSZ20fEa/paDOvildn8UGryl0kyr+qgjo?=
 =?us-ascii?Q?sEGyEUS1kfA0IlZzW0V9GltDoQsyyQKG7B1KhmNryiFDsSaCCm/BYpGMSgty?=
 =?us-ascii?Q?c2LT/w+ZwkwX1T/ZC667FAjGHfbd2e9JH2HBa4fnTxD1zQZDIIOpt4Wz+wxf?=
 =?us-ascii?Q?p+62ejPhDo2QXX4gPcVX0eSmSnK4iIh9qJTluM86dZKj2Uj7CrJFZaqOBXpM?=
 =?us-ascii?Q?tTO8DValRx6I9DC4XMaucDU6eM+WmJ+Idh7cbVR5HLLOdtWPxapGs70kWLuH?=
 =?us-ascii?Q?JUY//tP5DE5W1gikH8w5Y0h8b6UDbNqidNlXMiNs87Wy8WDVz1Vir2XDhp3B?=
 =?us-ascii?Q?gz1e+0cOXUgw2p1EjVS9hhFQ7obxtRAqIu/exs5YR1Q0kIEhYJJl+mTZGush?=
 =?us-ascii?Q?CY/71NcE5ZobmjEOdUH3TzRjuC/zb3F/iCQyXAgXDVjz0y6w/wUuU7XSLtz2?=
 =?us-ascii?Q?Mdfx/zhgpi/16+LtNtL/fiXZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994a05b0-5ac7-4ee1-f2a9-08d93b281d16
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:52.3833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SS6UdI+igydeVYI8SUITejxLczqgZPuI+l/d1uOw9N7R4R+QA3vTIdrWmLnyl3X27072f4bZPoeG8CSMYH3Kw==
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pgmap owner member at the svm migrate init could be referenced
to either adev or hive, depending on device topology.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 45b5349283af..8ce71c8142aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -427,7 +427,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -649,7 +649,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -921,7 +921,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->range.start = res->start;
 	pgmap->range.end = res->end;
 	pgmap->ops = &svm_migrate_pgmap_ops;
-	pgmap->owner = adev;
+	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index a9af03994d1a..1f88bdfdbcc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,9 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
+#define SVM_ADEV_PGMAP_OWNER(adev)\
+			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
+
 struct svm_range_bo {
 	struct amdgpu_bo		*bo;
 	struct kref			kref;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
