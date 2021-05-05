Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DABC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2318761164
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2318761164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306BF6EC70;
	Wed,  5 May 2021 21:50:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164796EC5A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 21:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHeGgCY03TszruXVVToeJLKuSGmd5R/yuVSJwA2+ypunt2axDsl2UI1567zceyUZDn/yrnkUFsn9DrltqzveMoZCAUyYFPMfC27iDkjb3sLYJm3c6zHZhQqBB/AJOtNwUVT+6m/ZjjDJ2Wz+qIL8nVTABgROgFqUXxWTm/yDU2ZI/kwCJdmdYb7mwB0xHCmj67SnMTDB96Rx0Krei/j4oGrFyi4WSvW8BsEeVgcYvmhjrIa3yHmtTbd9CsI4LnI8gz8KzOc0leukHGMOovlLPGaLbS54EHmh2Pe+ebHRXksqUEza3Bl7xBwNL0IuduAyH5WJ8+aljm2tFfwWKIPKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kJzo0j3bFS+dOl5htxNZ55mizBIzt4QqSc34jDJKwM=;
 b=Lho7ROzF8Z0nsjrE0rH+aA8xu0uKFFaeAFM1+RKrGfwL+oe9lwTka8gubML1G3EsjRAzcEkJJqHyvj/geAK3g2xkgkiAlFmIZGhs0Q4h1xvbZfmqmSkkHZ/iVks0B9TvKZa+y8LYF7dT2CYmzB/i9/tAA5hwCZuVDGAmSzodtDxo9d4QSJlgeVToP7mARjZDyInW3fylr72azkhne9c+bocL0Ss91wYnCX6PEKqUL5HfQm2wkTZy7hR+07Sd6iG+366PifObtfs3vcugk2hNPmSUa79zbprb3OjLdGS1hGZmCFZEwptqvmjc00+oqtKzB+lcWMZnX7BZAjzYzNrreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kJzo0j3bFS+dOl5htxNZ55mizBIzt4QqSc34jDJKwM=;
 b=g5EgP69aDCp8tRaEME0dpK2Fte4N7n4ek2S0VNWma5HZhZ16yJoqAiXOW/u91lnmQUyJWNnOzy3zkGWaQGOoy9eaFSOyggF4evaMmQ7wCK4nFRncWBQXooZ6ehXAOne9Q1Jn0L+0CF7UrWVoZHMW6RpZOPlwcTUl1sGQfU5YGwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 21:50:28 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 21:50:28 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: device pgmap owner at the svm migrate init
Date: Wed,  5 May 2021 16:49:59 -0500
Message-Id: <20210505215001.3418-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 21:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e63932-3e01-4454-1654-08d9100fcb9f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430C55E2A088BF5844F64BEFD599@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2A+Pzzf4A/w4gmddPBzbo8SXnbMzKJLpD/3VqlRdIyfTeXee8Z/hYDrzv9Z60h2QguHWnJvP0FBFGppNZHtFlX6F7lKMKh5IBppCwviDH4PJGDuLdy1NgwUg4pD4SihI55hWFytbXJ+Oe0dp+cwAr9BXab41FGPA6iTZdN1xnDi6N6Uzcx1QtC16jLUIl41vKBxPTduJd6zaE7FmqhDJ0ojBDEOdQYQrCVGg9eACs20jykugnuf/CLIZDF0DUvoZcSIIZxDNM5xywT8pSYvBqEo5ta+z4L+NG0qM+msuIATgYS0FmkK6ueQDM+IMMelPYqbMqhzh+lige2vTT+kpSdG4bKUmsvkD/uV3xLT1Giq8qhpFlPuFIPigHclNB9WsNAnUwa4L/ucEk0688/JvNI7Y70PFAE6uspogg3QZHTYi/KdJm05kH8Xibq9MOOmY8xC/C66FS7HbY2rAvC/DRuDRchYIE1iG1SqYUAVV4byuvgj4QsRNJMpZxr5vuAFa5k945MK2V4o43oP5fmQE1IOh9TJY8U+Rh6kieBVwG5QV3/aphmnaVQs5QYcz84TVbkEZwmvsp4DM3truZPeXaILIaMUmDz4fuMwVBsW9PyRIazCGY7t62BQLIsBxh0icpPphYJEou3y4w/hhlGML+S+mmroz/IhOOaRbaIX553o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(6916009)(36756003)(2906002)(44832011)(66946007)(6666004)(66556008)(66476007)(6486002)(1076003)(52116002)(7696005)(2616005)(956004)(86362001)(26005)(316002)(5660300002)(4326008)(186003)(38100700002)(8676002)(83380400001)(8936002)(38350700002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jn1AS9HnlNPOG9b0CNIJKwOkh0rp0oOgeD0R+3a9QjK3A5UssGq7FHV9FSDW?=
 =?us-ascii?Q?IJJi2JHtDjXbovqxXCzTkL8maFgZFazjpKPFJFCGwGLUuX6jeoJrQS+s4H9J?=
 =?us-ascii?Q?F3acNhYqyFC+vEo8AFpyRBNsgin2AuF7ZzQAh6+0NyQE+TiDC9J7xGHD/JyY?=
 =?us-ascii?Q?HWE9KwBbnr8nGVOCL87EGXkCrFIp1gPAJqOkFSx6yN8d8rNEjt+UNwXD2XU/?=
 =?us-ascii?Q?/lSrcL8FfiaoXX4qYMGDzlujZeLFwfxbc8U90hHJrqxxTQP37HromK1w0Zx4?=
 =?us-ascii?Q?TISOXM1OH7Gpy3VJBCNa8want2Z2rAYdTqnIr2Pw8kuKTPWS+0kXx6ElJs8Y?=
 =?us-ascii?Q?EfsoeD67ilXL2BsOF9xeKfL590AmYZFh7DYKN5HX7fFv2sZeLYtBxi372pc8?=
 =?us-ascii?Q?OoWaDo113CfzJN249J3wX8BCPYhkb7EPldp9ar+Om7P55wz0aduXztdkpEIp?=
 =?us-ascii?Q?itw2QsokoV398RoXy3hWLEIuCdSFq8T1wJ0PGHtlqEKdAiY2JKzLYt+VcoRI?=
 =?us-ascii?Q?4KiByg54dvl9OzjjZrFPHpGg6/rjIMtiSsAW3RVW0HCv9u+GH6fIMebyBAtW?=
 =?us-ascii?Q?rFtx43M+fWKRtov44ryf2AWH2TOmnOfS94XMLCB2yJrAeSw6UJoJCchWWDMv?=
 =?us-ascii?Q?lBPxW3Zj7akSEdVWK96elZ577i9By502Qxbz4hHuF0vOVEcsK4lyWl7OhcW5?=
 =?us-ascii?Q?6pklgBMwXI27TH4mo6v+QtDYWJsh2xOr4ejxoqvbbvlw4l+ky8WtDH6UvhpB?=
 =?us-ascii?Q?hB/7+49H1TOOuXMDhr3zAsdGkzaP0ZdYMVOxeXa3CYF3QK1MTl3REmLXWCvW?=
 =?us-ascii?Q?2lWDWMieAv1tVm2/ko0hzNXAGX3NsnJWQyPQzA/13owVSnoNRYsN4lTYPHNj?=
 =?us-ascii?Q?eosnH9DUnOhziuNiGNqHvlgpAJfWDNbpb4Of5Nl4bkPdA7OOU8qLO49UH6fO?=
 =?us-ascii?Q?pd5AsqKmmBQssLBx3HYeqHhBiMSqlEslTqis4fuhDU6fgluIYHg3IW2NJZFF?=
 =?us-ascii?Q?MzVix+lOdd/sY38lx/q+tn5A5n8ut/62J9ll0YBzLbyN7Lzc3BMdot0pmfEe?=
 =?us-ascii?Q?gitiOt2sM5+uLcKPld7O+Tov1wbp257kl2DFSbxU0yGFV03aaMs8rSifdpK0?=
 =?us-ascii?Q?T0ExWE4W+Mfe17MqYFqHNYg4IaS/4Jac9RCJv+wihYDOHPlNSsZpZeOf7Dyh?=
 =?us-ascii?Q?m2FIzZTa+4STfoKqV5KzPlDQ2KjoWFvr73/bLkg330BVb5aSlsaAFNNc4x5g?=
 =?us-ascii?Q?EF7ZqgZm4rXiW/xPvtHoxtvNKtkushmRgRFSeIYi4VDG3IKVvKeTQ7pLF/tA?=
 =?us-ascii?Q?dHXFK4KAYhfKOXxgCiSRDEik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e63932-3e01-4454-1654-08d9100fcb9f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 21:50:27.8242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2qavNvhbPzsh2DR46xIaY4lze6qDvahv072yQQUrfEVnOOSUBZg2uWxP8o3sfiPOmli0/EP8CgBM9+8EAut5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b810863f6ba..21d92de235be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -426,7 +426,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = (adev->hive)?(void *)adev->hive:(void *)adev;
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -641,7 +641,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = (adev->hive)?(void *)adev->hive:(void *)adev;
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -907,7 +907,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->range.start = res->start;
 	pgmap->range.end = res->end;
 	pgmap->ops = &svm_migrate_pgmap_ops;
-	pgmap->owner = adev;
+	pgmap->owner = (adev->hive)?adev->hive:adev;
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
