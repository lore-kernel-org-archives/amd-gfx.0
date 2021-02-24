Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614EAC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B0564E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B0564E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C556EB98;
	Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770054.outbound.protection.outlook.com [40.107.77.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B1E6EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgFYCtsOzf1sRf0RXpgCnD0sOSKu0SA+DDJgfnLdvCTIxKGUVNHO6OzX4f7lKzrQI80XR2mufoyj02kdj3BRSTANsrZ04O0BRZGofq18/eeMhRRUaokCXGUpteTXAX1MbBe0e/syuQtotCOsiE5pmr10iSkWmmVcdO+2qqksrx/lN+weL8nFyZU4VmefRLVdyjog7sU9rFbNb1FNx5bu4pMeaNLHUvR3oHqPU4meMIGnktxsdy4w5wdBJtZCcGzCRwDeEvXS8jvlHu0e+D05pOCLQz2TcnyKSxz4R/h03V9ZpsqTI/zVpzGLGY1/YB+uUU/Oh9jlxdnKUpxXAoNKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0nOGdRHrVRa0FFVnz/B9W6sqztIGV8r+WkC7GwikQY=;
 b=AiazPrOzAaCHldmuAAo8xQdjd/4BGQmSxul86iqGR1t7aWWYFT1k7J743/39g5PGSEyvDNPl2NMkHN48xzg9sa5HVI0y4cmgbgdEvuLYyCTvxN1CpTKNBdlhAiS3s1qv/phiO3Z+Iwcd8BQy39564CsNGtvRa58/RYM/RJYJVLWWFXEzJnL5IaDL7skxmFznPs46cbF+mHfAOauZraXHzgFlb24I2/46ATemJOaJCnkNyaxX60OWIWA8926tHZpSZViKuEc5KdPfAgi2L+nWuFNngv8Tv9dljGLo3ibhUGRNOvFttn2JjuomKGvx5zDVjJanxmDD6nNm2S1yprx6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0nOGdRHrVRa0FFVnz/B9W6sqztIGV8r+WkC7GwikQY=;
 b=2LNWdqHBp8b3S6AqZOmcaLR8sjUSswV9zPcru6Luj+a2FvCKEZRFfTUq0QZp45OXPCFvSomGmwAqA6Cy37DnKlSToflIxmTW+j0BRs8fcidxJUTlKT4a3M+hjmM2iKfZf28JFTVY0IHzcDeZcHQvybPNCPXR9aiXttqonpO/MQo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 138/159] amdgpu: Fix GART page table s-bit
Date: Wed, 24 Feb 2021 17:18:38 -0500
Message-Id: <20210224221859.3068810-131-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e75d579-5e03-42f6-67eb-08d8d912748e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807CC0BD98C8EB48CC85809F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt+JZPeezWxs/QAbZxrUFHIDjrFLXjA7eOcHglRqpJzqJ1SpTmAtpLFphwCz7UCJUZjzsAjUxTRIQWMlDtp+PPnUq9ba1U5XmOSzFfQ80UAhqiHQdGIUnJERfDZiSdR3cWhj6UDAftunVPj7sA051AXkDA8SbTU9ieVaAlsjBcYsYSK2tte8J0WYBiKwS8z/OSTe9x/SNbrU89PrhVF7joYuQX8Fu/ObKo3DyK7YcXh0YudfgrUwenYT515/AS1IYuV6iPcG+Y/LKX2CaAqZtJ576ezad+rTtkEymyYBfm6h5vQIJb2HMUUXvklfj58HAW645zyfAp8dmHF24IP5XW81rk038W+KGZ8SFv3/Dbm8c2VeAQMIDx3PgqsqbwFBAJP131Td0zmJoPyI+vAM48OxhEXcwS/S20tTq7UhB0J8yT4tmWC9LClGhuBaxtr3kdaPOgEAnaEO2MGnvyOLHdgsw7TluKtxeI/mI0ZfU3QmIXaHq0qEFttFr6aKv9itH0HUhq1Sbpo4koobsPYuyCI+nMma4fS/QqpCFTyKL3S3r/XuOebvGTcrbHIocDycf0NIGp1TJgGbu2s0hBXyQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yTZ6Gx/tH7Hm92tubXQkLJ+x3B1gVICRcoC4VvQGhCXKtlkTF0qQ+4jXoDMT?=
 =?us-ascii?Q?QfWu7fpYVmDILJzK8TnY8n39ePvpWIWZl5iHS/oFYPe+UOKJ2kw2m6ZrQPW1?=
 =?us-ascii?Q?iJ/RRKJXMQ3qqoEEglJ10ZOvrwhOvpjis8IDdhhiJelwgCGXItVT+4sVKrT4?=
 =?us-ascii?Q?kEB8mct8leam+JrmE2Q81gCQRfHMF9pCwkwNxnybs18lGt7hJehSCEh6FYC5?=
 =?us-ascii?Q?5xbNyW90ekhPmAFmkcyXjsuFmmosrDwiRc/J98QA/kdFxQAKIV3jf4b9jhDe?=
 =?us-ascii?Q?LoKltWW0L9zx0502cxJ1UbLi7eHQo23GfrpxfRlbbT5pNDnl1uuMIsABboxc?=
 =?us-ascii?Q?1fzPaxyrhexwjQULXOK+aez29KH+CGkE5P00wUBmNP149l0Jv9ksBtp93ZuX?=
 =?us-ascii?Q?iuZjy4pG+9INOPiVYNKzit06pViRVHTDOkNb4tOwhyYbJ+kwZJdxhD4OJXza?=
 =?us-ascii?Q?i6zwonghFl0I5IuMqwqTrHV/2W3o2ei3ys3m/kksQcpdwIthgvXWm4Irpd2v?=
 =?us-ascii?Q?+KUaSk/z8DlPKb+BdEvyLq32BQxGAO6i9UjA95yMGTOn1V/3EOFFfxWPX0eu?=
 =?us-ascii?Q?o2N/8m0jiaHJ8+wUfrtZydQuxkzc2Nd4p3B0oSM7xFEGlyOzZiwf8fpWYB0e?=
 =?us-ascii?Q?umewNpDu0Rst+rmnWc6X3amkts71Xb5Q+DSyAvdQpbEeh7cRExvs3SaJEXgZ?=
 =?us-ascii?Q?rmSQI5+tgV2gVfVGuzz1cQ4PTDUwYokiSGx9tddtMB75jrAfX9gshs2jstja?=
 =?us-ascii?Q?T/v8p9nerBcV8gOkiv4BoeYT8Z7kfnQtRVNZAp8xEkaVGlKLmlVJ9YTxuV7v?=
 =?us-ascii?Q?xdaqzEv8Yay2k6HybqoBqLyjCfJm9CWB6K+kanjK/hxwP+r93mjzIGiFgBu6?=
 =?us-ascii?Q?cg+PO3J6C3EtX4qDxDZIsafP8IEvq8pOz7VX8JJ7NSdjzjC1WOC7QqtSEOUc?=
 =?us-ascii?Q?vUeegypAYyxKxN/5wpUuMkl96wshRkaDMRekkQEVdgaNKDgUAmRvwCnvESlJ?=
 =?us-ascii?Q?WY9BT1gxP2mZlELNNeEm2dY0cv63DRUPttaaNCbsgvPEf49+1ukaiwMN5BI+?=
 =?us-ascii?Q?QPywy5VXYXNckKvh52WkiclG58NL0T68KPnou+h+ZRHNaXioPyzl7GlrN66m?=
 =?us-ascii?Q?oeK2mSMppy4O6c4UYstpqwD8jdNnhPn8qgo0+1uvcx9iDsSNJnlQjDtIn5f8?=
 =?us-ascii?Q?hARrSXVJT4VFg7QGl0FeNHrk18pFP/03nbcCNVIo+7mHytBMZaChgNJMJtVo?=
 =?us-ascii?Q?fSs5NjBNWM7lAxGGwN9RFk1wuXq+kIJzik4T7Sg/J4SavuR405DPE01QKNPR?=
 =?us-ascii?Q?AcVvxruIoBFHXNYaoMON+Pw5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e75d579-5e03-42f6-67eb-08d8d912748e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:56.3094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QknBaxERuz4IAqbJJ3l5VHmbnluHcluRl1rtSmbXncdLVW6IhkVKzpeayHifvlRlGkAnmwyHSThz65ycZtecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

For the new 2-level GART table, the last PDE0 points
to PTB. Since PTB is in vram and right now we are
runing under s=0 mode (vram is treated as FB carveout),
so the s bit of this PDE0 should be set to 0.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2be31ad8e31c..6d9c660da27a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -650,7 +650,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	 * PTB who has more than 512 entries each
 	 * pointing to a 4K system page
 	 */
-	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
+	flags = AMDGPU_PTE_VALID;
 	flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
 	/* Requires gart_ptb_gpu_pa to be 4K aligned */
 	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
