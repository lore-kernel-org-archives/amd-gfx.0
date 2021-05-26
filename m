Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950A6C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545B761355
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545B761355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B19A6E0ED;
	Wed, 26 May 2021 10:11:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A4F6E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/rPpCWwvwj9vY3ua93tEaLvEU0U2GNYuD+E2ekExSv1AOZsnoaLE2sie74EmH9LbpIwssN3ttx2Kn84568RyHKgYti35F9dubkYpGwzu1FaLqadgQckIlAQdYhvj0QZQ9JRoy5qQfW6KuSITyeld9ZNDATpDid2PP55W3J5BPwUDOF1tHJYdYRlGy564lBMqQkWxWTjvZRaMe+ti93Tkf28T4sm6g+9W4lBkjctzoW18drBodpmKoz3ijvblNqgCuUM8Q1BmKYIag4pvhlsV0k54i3So5Iz0XlQ5u0XX7NG8lLMfrH3wuwIL377ImOMzkmDzLkzDQgpXNTa8EUPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6i7rt91AVXPsTgkKVlpuA6IpBnXyCpMh8JxkBOZG/o=;
 b=jh90S20155BeJR+SOZTLT/52BLTRPQI8HMwz54VjShFIOylWebQgrNt4IX8XzgRPUxhiPMSL0nmkBhWp2NYRvpDp1KX+eAFmosaqb/zY8FIx6QFxuOXinV3E2jSxqg9S9veEV6fpOlYSSYX7Kl7jkCI36VJy3o4dJMjoGMD+ULPWYUiM398UE82DWEh7KuuO8TjgGvzTh1GkqYxH7M7mX/BOGW3Y3Wn37cGwSYqGlmIqHBHAo+Nj6ktIVNm5mgtt+GfuHmCIt697FVEvRbkX3IyiZ3Nlbqk4EOGBrVKuUuh6qZVhADbw7vjg7yhRmTwF2UqJD4XOhEZ2UXp0U5L8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6i7rt91AVXPsTgkKVlpuA6IpBnXyCpMh8JxkBOZG/o=;
 b=a36DpJs8iV2lhJFXbLqHM23jUMX+5YLc7rIrJfjIAjC/w9gv+qUyW2s+8QauBeapSpxO2xI5GZHmN+8m8aNohfxT12CMPRbYp+7PMKKXHrt32SJOeCM3U7qZQVbmdOFvvrlK4Laz+cwfA9XrA2g7O1yDuGf+5A2IceZjV3oHY3o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:56 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:56 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 7/7] drm/amdgpu: do not allocate entries separately
Date: Wed, 26 May 2021 12:10:27 +0200
Message-Id: <20210526101027.14936-7-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd059216-312d-4157-3a5a-08d9202e8d3b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5232101017E15CD072D5AD438B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNgkOP0YqoYyoqsxIk04RFDLwwfLEpoDQFc9IEmknLDX0TttzfONw7uZRZaWo6rOm7qE0HAgrPuwvk/aNmo+co6b1h1ouHVg1c4QqxWjJufO/3k8A9AJ41/3WQkBw9JNlDIXmzYYRG1dZWBV2UNTQEHk/vzRE4dlSRcERY5b5tZbmRIBLJzSucCUI/LdTcuMHeT9Nt3NkE8pYhmXB/Cba5krnY0CDyW5CkEGXLIGp0VPx6BLYU0BmgrYEEKDsdeJ1iRqvXoeXAfD3+ouKbyYiAV2hflB+wPSwhv/u4BBnMbU+i/jtMDseBrhsS3Q6vS4O74cSDYS97HPfF9gwH4pUo1IIdla/Mp66tePzpOo77/+7uMnHSPa3lhsHCLhb4LqTyV+TUJ1fQbEw7m/Wo2y1ZJsFXOoEjKohiHkrsY1W5ZQG9sEuYdJ6dyVti7i6FWIcAx8VVB5HxcWZs43qHGIVt5z4clTdeH8M6WOdzS0VkKwbmC4cw0pCmsDxqUV3hPbqgjw+IlpWE40uNXn+9VFbeYV5y3J5cH/fz0ZNfnUgpn7StJOw5hQiBG6C20dCTuoqNJW2jl9tIoiqwX0R7RaYcfsXmJfdFraCEXvt372JurTW4NoESBonhvgcu9atRogh5Cf/gMz1Oyqg4YL5zB+W2YlfKNDhbZpML/FL2xWM4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h44aFqd4DVjD1yQvKKNhczukfRV5WFb0ETsOu89bcf1gVT6YibjbHT9Hz39M?=
 =?us-ascii?Q?5M8S6vucpxX3dTT76bOqrPLedOho4elCb/jwKHD/LyZiW6zAs+jhmiVTdJZu?=
 =?us-ascii?Q?uMJ8xCXK3aLWYS1aLTA7uFMFT7GhCps8du0oFzjQZlsqc/pqahWqADFohftd?=
 =?us-ascii?Q?mAEwudZNIQ/C62oahVcZVZyHUPqVDpe+FgvTbwKS8HngsUdmfKnswV55ozl+?=
 =?us-ascii?Q?q2eXuAjRdjsVHmo6Kblbb7cw5lEYMM4jLnInxytH01Bn3pFkidllZI1HrJ7j?=
 =?us-ascii?Q?o/Mvzsiv0c1R3ckjb2x5hSCUZf1XuTgbG7c93dinLk4oAql2ED/aPWJatXYO?=
 =?us-ascii?Q?tM5S/6uApa2XCHzIExBy+3aogApA3U91mIyMKqSIDbhhO5D2ArKRQir7XA3B?=
 =?us-ascii?Q?z/ucOJBa27dM/ekG34igugJ0Z7HaQf8ArWF7GK0mVqra13U3F1AZxagsgjbg?=
 =?us-ascii?Q?8XpVKoF3e/PvG4/OhSwZ6T3sqoPRfF2MHKKiHvR7WDYzI2uOZqsgEfcoDFEG?=
 =?us-ascii?Q?cAlSDMbN839oGQebIchAgwN38dCTPbh9lrFHBN9VnU+EwKGT5ZbGbaO4ndiX?=
 =?us-ascii?Q?mPRixezKPvPxvdD3aQD4tQ6aTd5qm9M7fOgz84CxZvEjxlSDLGx40dKhe/n7?=
 =?us-ascii?Q?FlcFtH70yEJuzalhiOZyT4xqAnQupqGBUmg3Te54OKQCWC95A1u3m3Dgo8VL?=
 =?us-ascii?Q?MqXddGhdZFt3u5b96exIIIrMO7H/v3XULxZF4rrphPrBrYc3BcMHFrriRetk?=
 =?us-ascii?Q?dKSOL4VcOTZBKTzD6iJ9IA0INwszPJ/aeyLNb+/IzFZTcMEIUhUhiXPgS4Zz?=
 =?us-ascii?Q?Jg7BkzikexdlO8JphEnnBZtHy9Q8k4Zr3OvBeuzXlZ8xDmDCxgcQyGmuYrPa?=
 =?us-ascii?Q?5LX+vBfXFOLlCFku3N0A1U4DbXyrKQuUbjxfNTrC6Rv+rmc5OdrlxOr/Cim1?=
 =?us-ascii?Q?faZ3gjeImv7XbUhsWRcfVdV5y7nZO5812ZCOOBGVRHhSU8XWvXL0r8bCcLTX?=
 =?us-ascii?Q?NPb6y5KS0sb49N2bgoPqx7YV6LY6SnNx8aYZlccua48SMppGUjWEf9oG3aps?=
 =?us-ascii?Q?h+Ogdt3DHj+eX08U9XAUbqn9i5RCpB8HTPW9rpVhnsi55gex4gBHzUj2MGIA?=
 =?us-ascii?Q?zJX5x67KN7uyRSaW9PJHbXAw4kwz+blb7D/NLDscVHv11yB/5svx/rWAdYcK?=
 =?us-ascii?Q?Bkpo/N0qBzEyaRsMdo9plwIuK9a7v7LCrjLLN4exn5YpMcznrMsOeuvg2AKQ?=
 =?us-ascii?Q?f1Xhvc9QDGcCWHPEkBZCcr4lqrWnK8cVND/ZVoMlbyp3i9WsOgfVJYMyZ5iN?=
 =?us-ascii?Q?j5GlPeOabIMGTF9yy26qQw4c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd059216-312d-4157-3a5a-08d9202e8d3b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:56.0834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fkvAz79Wik/m/LNIGpLQsDxubacPt5CDy5UZjzCNhgzbolKoA30ZfMrIFIYYLWTYKh+O9ITD3ZityT6lb1f8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate PD/PT entries while allocating VM BOs and use that
instead of allocating those entries separately.

v2: create a new var for num entries.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++++++++++-----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ce17ffce9ade..dc56b09e493a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -876,6 +876,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	struct amdgpu_bo *shadow_bo;
 	struct dma_resv *resv;
 	int r;
+	unsigned int num_entries;

 	memset(&bp, 0, sizeof(bp));

@@ -885,7 +886,14 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
+
+	if (level < AMDGPU_VM_PTB)
+		num_entries = amdgpu_vm_num_entries(adev, level);
+	else
+		num_entries = 0;
+
+	bp.bo_ptr_size = struct_size((*vmbo), entries, num_entries);
+
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

@@ -958,19 +966,14 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	struct amdgpu_bo_vm *pt;
 	int r;

-	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
-		unsigned num_entries;
-
-		num_entries = amdgpu_vm_num_entries(adev, cursor->level);
-		entry->entries = kvmalloc_array(num_entries,
-						sizeof(*entry->entries),
-						GFP_KERNEL | __GFP_ZERO);
-		if (!entry->entries)
-			return -ENOMEM;
-	}
-
-	if (entry->base.bo)
+	if (entry->base.bo) {
+		if (cursor->level < AMDGPU_VM_PTB)
+			entry->entries =
+				to_amdgpu_bo_vm(entry->base.bo)->entries;
+		else
+			entry->entries = NULL;
 		return 0;
+	}

 	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
@@ -982,6 +985,10 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
 	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);
+	if (cursor->level < AMDGPU_VM_PTB)
+		entry->entries = pt->entries;
+	else
+		entry->entries = NULL;

 	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
 	if (r)
@@ -1009,7 +1016,6 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
-	kvfree(entry->entries);
 	entry->entries = NULL;
 }

--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
