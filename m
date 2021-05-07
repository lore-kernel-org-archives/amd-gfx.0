Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CDC43460
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7063F613CE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7063F613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BAF6E02B;
	Fri,  7 May 2021 03:37:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02766E02B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE0q2NbujAfiBb6UQyAVHWMubwXFqmzo8KksdI9hfHDcuKX9gT//mivaIdQxeRz4X2Z211kI1w5TlG6MXKK/e4mV48HvNqwUQp3Q74RxNv22W2vgGrxJB+7Zl2r7eu+JJvsQqEHxQnkDZ8fgz2/FPoBqdlpnbi7PX8PsPfxjf9FPknRB2FKIElz79bveUdq8gFrenG81ahVBwMr/f9zqFAHclBSJsS7GiYHU/81hTlk5yY1gohVrhL91GXiiwM/psN45ZSAQJAxRcgNnTuVCSnwnvhWtwTiUnZr8R6cSDr5E08s6O5racSv2P+bTu4kK0mILTw04pRvaMudi0Cc0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3wG+sCxl8iD2nWU+K/pWTu6D9e1zHwGnVz2AcL8V0Q=;
 b=asOiEcBPnj43zzsKattEVv4DWxeOayoeY9chWgQNoKP2fSO8JT3haXssIGy5vnyYo+ClSOaxsrUgb6dPpvNWmle+OTKIXlDulXwA9Tcpyebh1urHt7bPFIP38r0MmzbIXeVGkhxPNagjS0dznfKGnEp5v6sclf4IPqFs+DRngtTXpGUClKpRfU1mPOc6wFLXllzkN0KqNeJuAqWiqVVC+e+tf9wobxwFZewesj6pe5oyAHc6g/kmohFwQSMQ9Gf3zWQwtd43xLyQkQgtftc8eW/jxqVKfQ+2PYhMQ3wa+1R/zlAxys1m9aOV5u5+JiVMtQCSgS+p88kcC1m2TSdg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3wG+sCxl8iD2nWU+K/pWTu6D9e1zHwGnVz2AcL8V0Q=;
 b=4moJZNWbtZ0cJeoJC5MIQmJkSYM+g3EeZpk3WeA0F1lP39OdbX5ZWjPM+qsjISLWW+HWIhIg0EZ6vmrXHSOi/0XKVqgQzfOqr+xbvMa+tTaHfhbvwOefRchIiw1naSXzwdHy0qHP/BR7GesA8lqceGbljhN6zJiCoL1JH4Vz8ys=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 03:37:16 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 03:37:16 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdkfd: device pgmap owner at the svm migrate init
Date: Thu,  6 May 2021 22:36:33 -0500
Message-Id: <20210507033637.29622-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend
 Transport; Fri, 7 May 2021 03:37:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68f216fc-db66-41a3-a456-08d91109690a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB236586AA0DEEE864A55E8A0DFD579@SN1PR12MB2365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP6wZzM6nbH/L5V1HiX6w5fLTCabiWsMSqnX9FxsHhcnFsJG61whqmtGFrQ4x9bxOwbV0i6Jz1HDqsvWdGqZXYhwRaiiE2pbiSfuRnyWLkPfnjg82BnQV6qZK1DR8d2VKXq8QbRtAwSZA3Nl6Kg6nmgA12zxIPRO/L5EGBKjFTmU/vk5c7FAqJ0nif8nJFbPJruJ+U4Ug0eGC+JOY1VCqel8QtVYkM6/R50nMRdv8D1z//xRY4oemfJBz4znPQbNnYK07fZiqdptMr9gCWWBSaPYEjzgnTZWsdAvn811THwbgwzQJwo11/rjYd6IFdOwlnO6BvDGIfYNbwBb0ZoI+U+wOd3UYr9nhFksRypsGvgCNVQ/P9S+7J/ovi9mddSJ/cyeGGTeKL4pjoI6EXSFshSqrNWKYeBijBwaiuA+f9FOzWQFhyb/kb+stsF1hLJ1OTghY5Sf+XUqtEx7V1+SsLtM4ligHyZ7+5lJUypulWMo3QMiyl5sS7uCmioFsCKX9rouF7oMBy+6qtDyWaQRd4fyKoLjMqNePyWgeKgdqCDqgOTmbn5R6RdFl0EjveKXOGF13U/yQB/HKCjATyN24gqt0kZC9HSM9GiDgprB+uhR0ixJUA7hEcE5P0vrzWygObikmAUPD+Js0sZT6cfAzA9ODb2CDzHQW6k7xDyNFYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(26005)(8936002)(66556008)(4326008)(52116002)(2616005)(66946007)(16526019)(186003)(7696005)(38350700002)(478600001)(66476007)(38100700002)(6486002)(44832011)(956004)(36756003)(86362001)(316002)(6666004)(6916009)(2906002)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1mEhChq6LleEcfw6qj+Ket8+cKo4d1N5ZF2B9338NdrKT6zwBYpaiOf5hkJN?=
 =?us-ascii?Q?t17PSSAjH/aO02ctSOpUyVxJy8/BJPpY0rJwovpQvAjs/wk6fm8cnQ8bsCvm?=
 =?us-ascii?Q?DjJ4j1h0lvrLcsoH3jQ7u77624UD3PUQGqfaarzRmRn2H0oDXQD900NNICLP?=
 =?us-ascii?Q?AnBrOFN5biWCtCbwtq+w1ST9fDivY3O4MxRbZTdCsDzKnVahl1Jsf1Tiet/r?=
 =?us-ascii?Q?Zi1qyb7KTLgxoFNvi+a9oj9gVCus0cFofSumTk9dQ+IH4WgRLTUzJUvLV1ZA?=
 =?us-ascii?Q?ynyyHvm4wL8WV2CHdsgVJPFZg3u9a3P2tsS1KN6WGm2xUfcJcY65phHAuL/T?=
 =?us-ascii?Q?KE/TkUfF8Hq1+PcLKC//nxsECYy7C6CcZb4SiMgdd2yZVLr9PAEo/t/FX5+0?=
 =?us-ascii?Q?SnXfe9ioOXQGRRWHnRCeRH8VMtvoQ81WErsB2X9bEGUeBrGrUSdVZdhGWsCx?=
 =?us-ascii?Q?KFgRfXbchmTtrTyaH5lUxQYvGyRjFwvcbqGU+pdTCNF1VFEfWL5etFOF+aX9?=
 =?us-ascii?Q?Y94ukC8/Fx20FSBIAn3RRRfXwPoVSadtDOZ+1fc21wq0NG5AQt9HsvrIgu3y?=
 =?us-ascii?Q?KigoKVnht6/I5DzirMJVg/TrH8AaP04AryQfcKgsWpayfbp3PWfL8kA3xf+t?=
 =?us-ascii?Q?vaaOyDdxW5KmU4nVz7b99ChuhW/tFjZu0fOsksriBiChOB3g0mZAHpBvWqQU?=
 =?us-ascii?Q?wQjOtj184pUWx60QEXlG694BEVX3ZzWC2wmlsSnIflF2H7G64c6qUjrVj7ou?=
 =?us-ascii?Q?+8tyRAHTnF6PI5afWa0iEYCsZX22dluXCWEkpblRRH+OSYhaB4VJwS0DVRGl?=
 =?us-ascii?Q?O9iTPipRlrre0HW6D7mos3eCFnErRTuQ++RTBL3z0MqEDd2lppNSBYclkzvo?=
 =?us-ascii?Q?et2CTPuLAUfYgy6yV93Q4XbiiDJnF3HH/aZDCtxtH2/HyknacWIKoLMkjwt0?=
 =?us-ascii?Q?QFWyS/PI9NizwodSSpHnycR1c6pHiRye6Bro8cmqiZ7VrGwciV9wUq710Ky0?=
 =?us-ascii?Q?VeokftgHPB7vrQAkdGwlS1B+WPSFGZwZ27qb7TXITgBqmLqywecqT2hUMcp7?=
 =?us-ascii?Q?YLYFNE1eDmFPWxHl/WajEUvZHvodwT41AsDTW+RjdAvwB5QTghdh+9GbDEei?=
 =?us-ascii?Q?iM8DmJXOEASgRB73o3YmCA/hSmD7A3WrPQ0hLcNpCoAstrm4MRRnhkqbOJQx?=
 =?us-ascii?Q?ZfeUolx5cxkbKlEbGcGESCufBkFCIHMMGqpEOx8jL1ZZrVJ+vt61fVUu9UNb?=
 =?us-ascii?Q?Xm8NN+H3GwiUaOE+oeYJKwUDuTxk7mY3AvCnjYAHQyYlLIPXryC8A1Bomocq?=
 =?us-ascii?Q?ujEr9BXLl5iNVgjTr8/Nwua8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f216fc-db66-41a3-a456-08d91109690a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:37:16.6091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oabNJEJcOHEdbpvuQeeCZiYTOV12kL7xNyObLq0+wmnuPFBvGVmpc1gfP5rduIVFMO7AKfP/P8wtCbKr1Rc/yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
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

pgmap owner member at the svm migrate init could be referenced
to either adev or hive, depending on device topology.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bc2fc528ad58..02340f36bd3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -426,7 +426,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -641,7 +641,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -907,7 +907,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->range.start = res->start;
 	pgmap->range.end = res->end;
 	pgmap->ops = &svm_migrate_pgmap_ops;
-	pgmap->owner = adev;
+	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 573f984b81fe..4297250f259d 100644
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
