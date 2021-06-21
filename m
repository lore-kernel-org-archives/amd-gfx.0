Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E34FC4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BDA60724
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BDA60724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023526E1D2;
	Mon, 21 Jun 2021 16:04:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E017B6E1D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKMu0tRE3837CF9XEVcKx/btaY2pesYPKQduwJeKECXbl6nwiBMu3MowgQSCxT0Y6IPFKvYnMvn+Yfl6fMbJRqMljgFOT7BFJJxZNWl/Kp1LdfrQNTnKJnIt3MehqN2V4arx35MLh667dnD+srlggsDxYO34kW6IYS79XBGARIoKefFIJ8xcXHhodLPhLL3gb1l2BMtUw5mewSQBNJVypPYTPx7Jv/lPeK5dPENld+JtIgt2AJRa3gyJ8j8qQBmqIyr2Rriq+fugHKwsaP/MwRaGxwHqGoHUJzhq/jG+WwvJ4BOfKNsZQnQwwEMlZT1c1Okw2IhjkzJTcd0/TIy/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDqvjdOV2pyyEgzzMILzdG9LZHRy14TA22YA/10PCtE=;
 b=biQq3T9qd5866LI8mWQrGFlzjUlZPleQ2uQqOmTaVETDxDjXHriDivqXHOEeuwcEMBLzIEYq6h0vpOn568L/+KsWwNZXnNcYDpDnf0MA6d6l/6r+MDUT3PtlPRB8fUgMSMM3yTb4RHV5XlzRe+1X9cG06fKDIAYR7oja8qp/CkPavD7ylMgDco7D4YI6F/G89DkXdPpBUeutQsdYPx6fSzvsR6MMcqdSyWPTyj9aMSI1SjPHnQBNRkHK5W349I57u7wFKcUKqgt+SZMmia5uDcSLF6bGYE9GqRyGfZTD3kcptbxhL9W6jaAKTSM0KcoMVkHjsRYb6eLXYtpLJzNOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDqvjdOV2pyyEgzzMILzdG9LZHRy14TA22YA/10PCtE=;
 b=CJkwh9OdTju4G2wrTfLfMlL6YzMbHX0JMZky+OMk0anBHvJ57/pg9N9AWCd7UD//DeguqPtR89LcJPSQS4rVkEVP0yiyzEtTpb09OQSKNbFqXiejE2cFQqCynfZoVxPtwUheFII/ECcYzKhB8djI3UH5Hvm1y5D34o07gSExsf4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 16:04:37 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:37 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/10] drm/amdkfd: device pgmap owner at the svm migrate init
Date: Mon, 21 Jun 2021 11:04:14 -0500
Message-Id: <20210621160423.3517-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a084c8ee-3d15-43af-fd41-08d934ce44c7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4365AC274A5DB4C64CD8A4ADFD0A9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBDKN7KAJ/OBkCabeLpED4C80UHQAYPNUalao2JbX1jZsU7cRCNNQHvdtmMQvD3UpkhvRwRu7NDFAAl6yvdyfb650LCO+zybuGQzZkIgvc5TES62wq1ADJchmYg4kTKjtpKk6FY10feKIdNUxAqygXiC1noQM5mEJLJ5qt0CI9AS44R8ShnHE0QrpkYYNfr9PbNjGMN2IXo4hmg2Y0FcVgayXTD2v7K/p9x5iqgSX9TDAlWGfI9j77WaPIRORWRTbP5uWf+q13I3r9suRxaIwaE2MhS+iD8Sgphx9q4qC2xAgSqkl1z6kQIy7j4YNZ8EhOhUg7QcMTToz1kli4VonCHyMB3NjSFyjldeDeLuI0ec4in6y48JisnpzFKb98+dWfpResYX74muJ8jcLG4BbFocANbMB9rwEwuDwcihN/3qcC42gxhIoITPgob4Zuj3q4ik7p/+B2LvFyWe2BBi8Qfzi5XETiVDpPb4HYcbt2SBR3yNgpkiml5e/NQEiLYVhOupQ9KNW0daAgaoqpDwkeof7CB0bZeTXaA4yT9CY1QZ+r/77dYGAdPaZS3MFuckiKnXBCc+rF3peKnrRdm2CVyXki/lI8cBBHdTAGlR8+RT5imBTG2CstaV6xjCjSuaTp7h/VQG76ZiN8g6OTbW0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(8936002)(7696005)(52116002)(16526019)(8676002)(26005)(186003)(83380400001)(2906002)(316002)(6916009)(956004)(44832011)(66556008)(6666004)(6486002)(1076003)(86362001)(66946007)(478600001)(38100700002)(5660300002)(36756003)(38350700002)(2616005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hekyMV+sAHMoqi/u7fVsuS2avrHB/TbhqY06Q01j0zcaQKvCQoFMY3OmL9D?=
 =?us-ascii?Q?3qEFq8V4W2BQEiwJwvtGOzD5lGz8LkPo10diPIrXx38dPZFo7om+2dgI91tw?=
 =?us-ascii?Q?3k0KohAD7Gh12RNN5rqyvKuf19hy9vyx5JrtKn5GBLTAwX8IceaPBi2p799L?=
 =?us-ascii?Q?fVRbk9QzOZrd/d0GM6o1PzhQOn6jBWgn29ogXZaRJdMkgos8gDwxck5ym3gm?=
 =?us-ascii?Q?kWBXCNyPyTwcTU1ui/v/6jhrDfgR/b6jEP8JeGKkQ60McDZg8zWQRnO1pLU3?=
 =?us-ascii?Q?G52SK2sHEoV0gDX9id+SvZaWHB53S1ihZkypyKGEeH8Os5zhzRRyT/MdkE0X?=
 =?us-ascii?Q?glvcgVHUsMcWivtvM0JOjmAqIN6V6q0XNnDPWaLVfyqaMXqAxihu+nKoiDSS?=
 =?us-ascii?Q?OWHtbGX0XWyJdk3LR1Us04FuXov4/ySNkbSu4xakC0sm7RTr7eBkCATddJQX?=
 =?us-ascii?Q?H7t6J8mAaoSb8hMu+09q86Nl8y32a0CBcvNOYGHd04t3ytWq9gSSAbVAPNc8?=
 =?us-ascii?Q?QQc2JlEchK3lxm9qDdrvAsDhJYP3WZv6qwKzoK4/FhQNNoGn4lhLSvYIJ+tM?=
 =?us-ascii?Q?ltEwg7EHARAo72TJsORyjFbkXfTHhALJLN7hJzV5tzlSxj3W5iMDUDpk4OEr?=
 =?us-ascii?Q?sqkrsumu8FstIUaJzJb56WGXgENZ4yB5wChi6Ns3/Yn1U+pOhkiPcjen1X1m?=
 =?us-ascii?Q?hdFyDpy7al026gMpcHWiSMLRVX2bZ6FZvg8KEEOl6rU9keJTF2t5lgSAzAKN?=
 =?us-ascii?Q?7ACoqPENW9kAkaGxnhNWiC20k7/Y2QH2XR2r9QWhfGR+Gpf/WayeIGgdIbcJ?=
 =?us-ascii?Q?RpaupyMubEqr7kKaqjPT1yvb284kzSABgMw8uiWLXFoqStxyoLFgxG7PK4R1?=
 =?us-ascii?Q?SkZwOiA91iAuOH0qp5XyHvtX9jIZ8q9k2PIM8Eegj5KhZ/PU+U/94iZb1p1C?=
 =?us-ascii?Q?B3EtMLYWy7bTOZM6Mmndx+cn/E9hXfOS0Kb0gz1XJYMCecZXqfORNbT5TGhw?=
 =?us-ascii?Q?tNJKAaV8BXwhuvZrbeAF35MC/Okkb6ZuHDv+lQAOx1DdANZxtkNJ84q/P3eH?=
 =?us-ascii?Q?EAHQLbeffx3EKdTL8WANQk9XkrLfc1KeqsdCZTgOlXDnvVTIL5mm2pci/nhB?=
 =?us-ascii?Q?bhpuurC6pibVGSFLxywakMhOH7ThpU/LnXLxrpupOI6wxehiiHqkGzkDg9u7?=
 =?us-ascii?Q?bEP3W+QD5GgRJzrD1h0YaJXlvUjRyP74LUxcGyqbUZm0ROLvm1g00amoUiX7?=
 =?us-ascii?Q?EJOERReeaBYwlUZg0uMw3Dn+VmCcOC7ETOMmQEkdY6qkC3HZ8lJovfIUwH3V?=
 =?us-ascii?Q?ydmLAK68mM8YfLlzzoZnHEle?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a084c8ee-3d15-43af-fd41-08d934ce44c7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:37.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIOEdZcEAbU7XGq7U2L9wPJH0SgN//ARJkt+REOfCin++dhsbo5E7+ByCqSpAy4P1P5ayekr5v/RRWCBLVksrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

pgmap owner member at the svm migrate init could be referenced
to either adev or hive, depending on device topology.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..11f7f590c6ec 100644
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
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
