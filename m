Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCFC64E8A
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 21:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2425020857
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pywhLHH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2425020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E58F89F03;
	Mon, 30 Nov 2020 21:44:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950DF89E69
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 21:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLdNwd9ceD3M+dMERQS0vdEvuqA1hVpvAbeyTFTsKFa5dH1ctXN6Szpb8MLK4cOG0eJZb2/f7np08y5SOqA7m6OZNcGTrPk9CYbPTzps3yU5ITCmTnrC1xJZD26UMEJHJp4KNGuRdBpY1hmNUoBMaUpx7mcjxRIxThGo/9HhC3Rp1KVq0lDodnnr9lr5jue6k2Dx3n7f3ZDzY/CFn21XvVsEAjrewRFNlBIJqtoJhVRD3DLESA2ARIrulz+hx/+ddaiLNVk291HIXIIqVKlAegylKTQUziqblX3IJGTeY/iNE9MVtViyaM/fs0ztxMkFFX4CWDZ0Av5YlC5ZhJilow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSGpnfWqdcz+hZ9/XOJrvtm/rWdJeOrxq+lfp4/C9v4=;
 b=ZCAJLRVYJv1aBEE2PL4W/X5g89O0Fe3vsYbNiymaUYjYoAdwb+Kw18AP6qrMw4c1wDkvQjVuLmN5uyshn/CzlZJnjvC6gb8PGH4sh0BP4rJ0kSoIeBV+tmlNyiiKUpIqNY6eUtzw7XjSOMjQrBY5xkjH3IGGBdywjAFoh42y/G/znlTQPewPr6hPUU9egyiOfVcphK3x8zeu4Aq7fLaoA2DndbyBB2Zbi+fCrv8WNfownJz0B2fPfK7IevDQ8lYMJK5enGLj3EwrOBFQctmgc/CcKzRnle+Z7wblsHC1jkuyoxtoaZSQ5Ik4Rp1Wbc+vM0drqVAAS1VUV+Eg7tI40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSGpnfWqdcz+hZ9/XOJrvtm/rWdJeOrxq+lfp4/C9v4=;
 b=pywhLHH+vtvqkFE+HTMV8gDfBq/bXvfD/hgweKNAtB23ycojaTbhGa46mm/AE8U59ud3DglmrL4SBfScqwax8jzmd9uHrjtyp20uvyhzHNvVHxl4FWjmWkVe8qS1ZM3ZmIFRkR7g8GGF37SepNSWdUC7mke3HzNMkWMfXHWp/is=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 21:44:32 +0000
Received: from SN1PR12MB2590.namprd12.prod.outlook.com
 ([fe80::9885:d957:b3ab:c57f]) by SN1PR12MB2590.namprd12.prod.outlook.com
 ([fe80::9885:d957:b3ab:c57f%6]) with mapi id 15.20.3589.037; Mon, 30 Nov 2020
 21:44:32 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: keep BOs in system memory if restore failed
Date: Mon, 30 Nov 2020 16:44:17 -0500
Message-Id: <20201130214417.30847-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:610:4d::38) To SN1PR12MB2590.namprd12.prod.outlook.com
 (2603:10b6:802:2e::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 21:44:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c0738a7-4740-443a-f6db-08d895791f77
X-MS-TrafficTypeDiagnostic: SA0PR12MB4464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44645D1EB1EAE1FC2A0E61EBE6F50@SA0PR12MB4464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JwtEb4ugINdlMcbbPurMksYuJFXSSRBpB9HyiSIfNUoWMhIjnr18Mt+UFn6QgBsd22/mEX9sRyoleJTx8PCxS935zmS2J7ZHagcamRM8fK5tJ6VpzTYsNJ8blWXaMSV5qdgqPyRfmWCRZd+N8+y3zSp5ijSy6/JX7qy0+mUjH1BNISoQizF9A9pg5usACj6U4LvrHbi8upCfYiNWVSW7sgVbudmuwluDS9G3vQdSl+VZoNQLtJ50A2M9/Oc/RnScX0sKyRLVPiAkRmDpGXxPipE2HCB0COmgcIyqW48tW1Uxj+UJXz/X3tAojUFs/h3OWKv1VXBonHN4iyfW8oy1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2590.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(6486002)(5660300002)(8676002)(4326008)(6916009)(478600001)(52116002)(956004)(66476007)(7696005)(2616005)(2906002)(86362001)(66946007)(26005)(36756003)(16526019)(8936002)(6666004)(186003)(316002)(83380400001)(66556008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hS8hjPqyA6HD5NsLJmCVGJ/STllJbPDjmX5wyYI0kudlyx7rcWktbAdSdlGw?=
 =?us-ascii?Q?VKyu/1GrZbBBPeHRWIU3bXJYCVQ0Km8XTDbzJ15nWnzIEDpNYrkAiMQQJgFe?=
 =?us-ascii?Q?utg/2ZsCs6r/IqHtY1r9WLS3Kc40j8h05FqPE2e/MV525YCTIP93aSCqrzrt?=
 =?us-ascii?Q?xRguioKcMykayLYsbtp77oYfEPhVIpX3ydZzk8SNDXkQ73VeZRKuJO2kUWdi?=
 =?us-ascii?Q?PE2Ky4S/YRLt0RajxewklUNYEwnZESuULCWzmed2c+f4jGiKK/SgwgS52Uf1?=
 =?us-ascii?Q?M8n+p4tZzStjtNvLUBkawqEK+6MITspzZ8RCdiKTXdA/1WQsqtNq+7Ragb8x?=
 =?us-ascii?Q?aOoxGs+WsHdXqusjLVrN6qNrdO6peD0M3P5cHBeqWStjg6f6i5qQ5S1FD4nM?=
 =?us-ascii?Q?WuYOGoJggqpF4jDN1gjFsoQt8hlfl0pDDOa2ihhDDMqvC2YH4vrFcCr6fHpA?=
 =?us-ascii?Q?93IwA+h1rjQ69xyypjcedXAXXzeIUNkE7vo/bVeak0RW/KbkBwJrmJqkoI4r?=
 =?us-ascii?Q?BICv0aZxEMRWgioFtSEG7wcL7wh5A+fkxJX3wlFg8EGZY/Z8jUBP0EvhiJb2?=
 =?us-ascii?Q?YFUAMMIUy/kRxl/8HxxHiZdl0RifB/huj5McS5x/lrvR8O6OsF6Ft4oGYSsb?=
 =?us-ascii?Q?TRE0uYnlAEnXCtF+loZkdnwl+VqlGncMRpJkIz0LuIj2zPf1NUBdT9iuxS9i?=
 =?us-ascii?Q?+HTzaxQ15eh9V3cQs4QUOy37L1p31ZpD4bJdFUcLgLIVCsMroZvN7rF4R7BX?=
 =?us-ascii?Q?URhoJyYhXNaeiZ2rGFKz9VqtG68nep8KJAWstZvH0FQPf/ErIwYd46OFWCb6?=
 =?us-ascii?Q?8lO+cJm0VXDsR/193f9ezVXhTjcl2nrX4gFRGcPKaP/yzRX4jwSDiUJaBXNQ?=
 =?us-ascii?Q?aTd9XMWrF1FwX1rAO1cH37OPGC4dRra+/9wesKkdveBO8Wy40roaKo1JJxN5?=
 =?us-ascii?Q?V3zGSFSK8Tfu5Nj0Q4Wguij+pQYN3sxvYcBgKCXfomgmSbXselPwDVSv1w1x?=
 =?us-ascii?Q?UJc8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0738a7-4740-443a-f6db-08d895791f77
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2590.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 21:44:32.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96nArpGwLu6hcowStzyb1XgUm532UL8u7QTvQW7bnhjj2xoqTsIofiqvSufxgfIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If vram is used up, display allocate vram evict the KFD BOs to system
memory. KFD schedule restore work to restore BOs back to vram to resume
queues. If restore BOs failed, KFD will reschedule the restore work to
try again. If display BOs are pinned in vram, KFD restore work will keep
retry, and may never success.

Set BO max restore count, if restore BO reach the max restore count,
keep the BO in system memory, and GPU mapping will update to system
memory.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 703cd5a7b8f7..4670515b3af4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -38,6 +38,7 @@
  * changes to accumulate
  */
 #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
+#define AMDGPU_MAX_BO_RESTORE_COUNT	8	/* max 800ms retry restore */
 
 /* Impose limit on how much memory KFD can use */
 static struct {
@@ -2042,6 +2043,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	int ret = 0, i;
 	struct list_head duplicate_save;
 	struct amdgpu_sync sync_obj;
+	unsigned long failed_size = 0;
+	unsigned long total_size = 0;
 
 	INIT_LIST_HEAD(&duplicate_save);
 	INIT_LIST_HEAD(&ctx.list);
@@ -2098,10 +2101,20 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		uint32_t domain = mem->domain;
 		struct kfd_bo_va_list *bo_va_entry;
 
+		total_size += amdgpu_bo_size(bo);
+		if (atomic_read(&mem->invalid) > AMDGPU_MAX_BO_RESTORE_COUNT) {
+			pr_debug("Memory eviction: reach max restore count\n");
+			domain = AMDGPU_GEM_DOMAIN_GTT;
+			failed_size += amdgpu_bo_size(bo);
+		}
+
 		ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
 		if (ret) {
+			atomic_inc(&mem->invalid);
 			pr_debug("Memory eviction: Validate BOs failed. Try again\n");
 			goto validate_map_fail;
+		} else {
+			atomic_set(&mem->invalid, 0);
 		}
 		ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
 		if (ret) {
@@ -2121,6 +2134,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		}
 	}
 
+	if (failed_size)
+		pr_debug("0x%lx/0x%lx restore fail\n", failed_size, total_size);
+
 	/* Update page directories */
 	ret = process_update_pds(process_info, &sync_obj);
 	if (ret) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
