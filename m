Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C419CC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C86D61159
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C86D61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B106EB7B;
	Wed,  2 Jun 2021 08:30:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A906EB7B
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 08:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ3e5B15S6tED8X5oKjg3o+yCJNoQ7ywcPYHIKxw/lL7IEKSxAnJj8O2a1FFg7JbA+A7kx1K6fghgRAE95b1SVFQ4LcOtV4Ed+UNvLENuBA6W12VI2lm2rNporuGuoYxU0UcTO6cIGW+arGdsZ3w/tbTdZ210Sb0rpLio0XGaSrGd+VdswTkzOKbN/J73rM2ogQ9RzNbNXFoPkWLYRXuQVD4DtVObTKo+OAdNGCX4hiuAgJwK0n8gzeHjiRrVCrMBObwcI9B1xrLXsa+Nk92YITtIy/D9+CEPdbrHsdfe3b2xqFLLdrqMlq8Lxh3wl9c7fn1JhpRO0zFPbvNyBTsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7MAyOWGBhiT6pSSBOZLTnttk8kI0rL/NPuKaWPEqp8=;
 b=TOvpcy8P2+mvhvGo45X7bMg2YBdy1IsYChH3ysRAhtbpk53BQkPz42hCTiennjWNRBMJjG2SwuPDBT3hxzwW4CNnpsabUjE8LaKArxPoCGpTTc934C7XMiWNphT/sZnvQnNnRyGsvfcMicVps/ljodxkv+tyAtIJY3y9WFmbrbIyATlsIrS2Oz1HA9YZAGuLxndgrI8n3QPFlk63pXM21Oo3d2XjVP7nQhLMYV8QRu7gU/cHlL+VEMTNo+jD+uQ5jwCF+roCksiBMPOlSeeVH/9U0dPj19lhVAd8+sd3XuHn6sEz4YEHuydfSVoTTCh5j8lRpNEwf2SKV4FwywSSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7MAyOWGBhiT6pSSBOZLTnttk8kI0rL/NPuKaWPEqp8=;
 b=lkDQcM/BzaZhNSup2o0dUoCf+kdGV6/VDp539ZWmWh5S77rTbYt4Xbs+y1oJZ4wx5RwnkUmxYm/5AIwbeDneXD3HOuMCb8nhJISiWu4pKi7W8/fqW3RT80+Q2OOyadb+HJorh8/m0uUE6wsZJPoETExdngIffn3107Xu6LkISB4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1872.namprd12.prod.outlook.com (2603:10b6:300:10d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:30:37 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::14db:e180:2a16:1b2a%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 08:30:36 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: Ray.Huang@amd.com, amd-gfx@freedesktop.org, Nirmoy.Das@amd.com,
 Christian.Koenig@amd.com
Subject: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
Date: Wed,  2 Jun 2021 16:30:17 +0800
Message-Id: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (165.204.134.244) by
 HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 08:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50744912-06ba-4463-d12d-08d925a0b22e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1872B92275C90BE4FA3A81E6FD3D9@MWHPR12MB1872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JK+Ak6Xl1taQQak0Gie2ivSqHA3eJcdzQ9Oyp0b0vQWhZcX9WiV1VymeDMV9Z49kygkocpFS0KFEykSaeH2OZrimBru5JWq6YE8vQnGQ/7tu7WAIlXmWsuXhguRl6XmIHq0aul0qCHRumy+05XV8QUCACehBNIDCz+SNbZO5hgJNWCxlhqT9qvEeplZEZgpsixeKO0/C4OUdnt9v4dem6qvxN5VQp5PA290dbqUhCAHdZHVy+4CRkdoYvyYHwKS2w35iEoBMDgtyXGwzwJOj1ZiyIMEmETMz1HnZJn0lrx9vIjdnE+dQWhCD3241N3MC8t2NOMH1zWNkGHNBTB0Kh1ACvZsNqvkiEru+hiyOXquwC3UOxxy1VhwGlZ2hB0OOIKVrUHecwPvTprwCyL4JFZ89mk30lvxdyUW+r1Y5ls5cm6SQrSI8yv60jiCbBaeVP/mF0Fkd/8vCW67/9W6vgxmetLTeAjAQUJ1DYC3jz44qCCPalCy+4F+ZjuHusirXYxclKARlADBMhEFnJICnx1Diu3vdts1QMAc+9/3up1ZB994p0qG9DAoBpz9qsdK2t94d7uwgZifjXxiDY3W1/gWox9TRgmKcpyuKfFmWg1zifB8U5ZHk7q2PlMqU8qAKjYac5ApsyafoUXVEygdSc5yId33suuUA7lGBTMNvDpnlHwU4+FI56038+vlk+dH8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(2906002)(478600001)(7696005)(6666004)(38350700002)(38100700002)(66556008)(4326008)(86362001)(6636002)(83380400001)(66476007)(5660300002)(16526019)(66946007)(2616005)(52116002)(26005)(8936002)(6486002)(316002)(1076003)(36756003)(8676002)(186003)(956004)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ETXd4HY7174DPbakoXwe2MWNOLrYk2lmwoBzUwUJRcUkju6i4eIhSRNeKL1F?=
 =?us-ascii?Q?gMVghQOkhTBTqeGoLNxejYmkIF8vJLRhx16Y9vU9BQFQoVVNgrCBfbzLCCii?=
 =?us-ascii?Q?xiHsDQ0Hi0aJ7y1DAzo/VkJ30n9z+77EeK6xbvM+sx/T7rG9Mlr+cIt5Bfr3?=
 =?us-ascii?Q?lUgzknnJZNhDsGIpXeau5jEczsJXbO5KCGTCZJD3NDf1aAd4CUQWm+E50CwC?=
 =?us-ascii?Q?JMqSMVgbPOzuho7COdp9hss36JbxbnuUGs++cHC3RsA6Nodnq6PZme0RbIaQ?=
 =?us-ascii?Q?UfOLHtoiLhsOuimbE4l01ai+AQzPuNx8+c/rSAN/EFqPh34PRPE4LHsxWGvo?=
 =?us-ascii?Q?XkdRyfvphZ7pVFOCDUJ8dlSXAvuqToQPZsUnEVHlspe3t7y7L35a95JzVcgd?=
 =?us-ascii?Q?NIh6vEcJmdXwtZ+QQF/OVVFqndVXXeekv13M5f7GVyK+OAdtV/859irUJjoy?=
 =?us-ascii?Q?gXC1DG45sFuHmAzuk7SLZbrrAIOdGV3Smb9n/gja7itlyaSfrIqJCyBkQXi0?=
 =?us-ascii?Q?s7g8Q+p3bpUfxWSKaMYgHNL1+x5+lrTWZQfhPLlHoNDjYix2Pl8yFBtG0T9M?=
 =?us-ascii?Q?w/UNkhDhivYrc15RlojKwBD2847T1A8y+cCQUp3dWPx4RRsBnDLi79cT1nsv?=
 =?us-ascii?Q?RPnfCJ9UeD6pPM61BskUHiU+Sfy374+Z91K0KI8r8wal5zpo9qTaU3fK02rP?=
 =?us-ascii?Q?2TZdpavFL2YQZW7fjq0ULylM7KY2GjP48cjrNxJrmiW5jc5MiTC3NdmOUs2n?=
 =?us-ascii?Q?RnSB4EMcRDtZx3v1BUmJz/qx0pwzC8pUi2HUWFPBlEPbQKDqby/luYyIKeB2?=
 =?us-ascii?Q?5DKJ15Nsh26jkXACsnRgNHL7CuRE20qivDfNHOYlRz3sJygXpQ1kErfnyjMS?=
 =?us-ascii?Q?zhqtxG0yCIafWYz0qOgB25g8vNbGGFTNqysQNZgQra/hEhQGTGUJIG/AgLXF?=
 =?us-ascii?Q?h5nhpWk0/eNBvo1w6wDBR9OmAHPe5a508GBUvis3jCYFkcuPh4XXAWPzcuzb?=
 =?us-ascii?Q?lBZqhGLXkUewwPEHGNnnN1KRSQlx1hjGXj2eA6sb3G6Cl25Rrhj04uM/w1nu?=
 =?us-ascii?Q?L5bzYrUODCe+vObqnjZFNrbScADxir4uCsEvEcwugmYu5FGIQSCLWnODse9m?=
 =?us-ascii?Q?nzjABO1NPbwm5UoWyYhXzTI01akGeQYI290StKwIUGt4o8B+Eg1p/FrcgfYV?=
 =?us-ascii?Q?C+vtlZMoBQHr1i1eV1vpII/E7TNMbwpqnsmdOH9cA3SHpDY15mYM6JJdDOAI?=
 =?us-ascii?Q?E6HgOeVgWJ2ZEMedP0tNPlfuBmQRI4M3VTDyiHrkCY4tyaFKsSG6Oot2z96Q?=
 =?us-ascii?Q?VywzRDgQmXp4OYBB5SpUQtW4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50744912-06ba-4463-d12d-08d925a0b22e
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:30:36.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APL/aH5qFRjHC8old++0yHmr7yFcAec7fYyohwHxUuQkTgBMqdBjbjkebDdW5/zwVAXdVj8qMWLC5Gu9YfdxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1872
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It will cause error when alloc memory larger than 128KB in
amdgpu_bo_create->kzalloc.

Call Trace:
   alloc_pages_current+0x6a/0xe0
   kmalloc_order+0x32/0xb0
   kmalloc_order_trace+0x1e/0x80
   __kmalloc+0x249/0x2d0
   amdgpu_bo_create+0x102/0x500 [amdgpu]
   ? xas_create+0x264/0x3e0
   amdgpu_bo_create_vm+0x32/0x60 [amdgpu]
   amdgpu_vm_pt_create+0xf5/0x260 [amdgpu]
   amdgpu_vm_init+0x1fd/0x4d0 [amdgpu]

Change-Id: I29e479db45ead37c39449e856599fd4f6a0e34ce
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1923f035713a..714d613d020b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -894,6 +894,10 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 		num_entries = 0;
 
 	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
+	if (bp.bo_ptr_size > 32*AMDGPU_GPU_PAGE_SIZE) {
+		DRM_INFO("Can't alloc memory larger than 128KB by using kzalloc in amdgpu_bo_create\n");
+		bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
+	}
 
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
@@ -965,15 +969,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	struct amdgpu_bo_vm *pt;
 	int r;
 
-	if (entry->base.bo) {
-		if (cursor->level < AMDGPU_VM_PTB)
-			entry->entries =
-				to_amdgpu_bo_vm(entry->base.bo)->entries;
-		else
-			entry->entries = NULL;
-		return 0;
+	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
+		unsigned num_entries;
+		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
+		entry->entries = kvmalloc_array(num_entries,
+						sizeof(*entry->entries),
+						GFP_KERNEL | __GFP_ZERO);
+		if (!entry->entries)
+			return -ENOMEM;
 	}
 
+	if (entry->base.bo)
+		return 0;
+
 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
 		return r;
@@ -984,10 +992,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
 	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
-	if (cursor->level < AMDGPU_VM_PTB)
-		entry->entries = pt->entries;
-	else
-		entry->entries = NULL;
 
 	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
 	if (r)
@@ -1017,6 +1021,7 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 		amdgpu_bo_unref(&shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
+	kvfree(entry->entries);
 	entry->entries = NULL;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
