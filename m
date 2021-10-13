Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4543DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 23:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02593610E5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 23:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02593610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8096E885;
	Wed, 13 Oct 2021 23:18:28 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3556E883
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 23:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6noghBHPI5pwDrRKAIbZhMHWb73PE8h/v/iLDES3ecT8CuxZOTO9xvuSoMM/TnvmcJ16PP2pgkjUMKg/Jl1ehn5YdNONSsCkzhyO94sjP2Bu9iEFnKjeoNS1d+2yE4AnSlB0bIpdphnid8PZFsuHYExdFHxurlMWR6Y/dasnxvLH4zp8nVnZhBQe4gSIBdNpD3ore6b5rtX5MhwMdMq8po75mOTIDLpbtV4thX3P0i7mHdQIPhrM9QejE1VFhBzxZ2q3bDYQ0bze+IPBlkUWT5tI7yA2DjACFMzWe3AmVam8gGRPhbOWNTrIDQF9XIorqi03OwbejdYhFl7HfAQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rj0O5Sn+CcSLTiST2dlp+lWaJWfEfEIfNsrv9pkMqY=;
 b=LpstQ4ZbDhpiRlflOHjXQhosjFWooh8TMg3pBUKcTCUZYq/zrpS98Q5/vz+JiuYN375MOHJzW05xISxAa/kDDVUaiwoNQVqaey61SpzLxXbSDtkwm/IkE2j4BBYqCXJbvY63ASv8QOhv0o9Up8kmY+Probg/Eg2zUSEsR167wJgCbFGOtft4tJsBKyHobRIHYBBg0wrcDsVWl3qbXsMtsd72a+qSLM0ekaoAGSPxkq/T591S6nA6lQ9WReHwfnKERYF9wRNXDPqJj3/6mDdQE/jT8utnCCJpLcJIBXWUcE5BJLVIrdMdaIAXa1ge80GRkXsOpgy67xe+8RWDmZrgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rj0O5Sn+CcSLTiST2dlp+lWaJWfEfEIfNsrv9pkMqY=;
 b=NzwdMirefThRxtD17pHwbk7qA2C5ZSJUM15KKF73lrEpWxDRqM0NEyhpzaJ/vFWbIcw8tNhk5NVbvqNPr3nLKLiUokBRvSFIj14Sym9g0PwkExwKlDQoRK24Z6+yWvuvrdb9Gq7nR1bHfvE6eye+XEiyU+mXfksbDLURIa+pTng=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 23:18:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5425:6607:8b21:1bab%7]) with mapi id 15.20.4587.029; Wed, 13 Oct 2021
 23:18:22 +0000
Subject: Re: [PATCH v3] drm/amdkfd: unregistered svm range not overlap with
 TTM range
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211013220526.7505-1-Philip.Yang@amd.com>
 <7a0a21b5-9619-f3cf-16c8-2308f9b6d46e@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <fe64d237-1736-9d0c-edca-b8aa5f168cac@amd.com>
Date: Wed, 13 Oct 2021 19:18:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7a0a21b5-9619-f3cf-16c8-2308f9b6d46e@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 YT3PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Wed, 13 Oct 2021 23:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79e697d-0162-4e45-9755-08d98e9fc033
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5183E5EA66997BEBED3752FCE6B79@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jbeORY5JHDjycsiTKTdq5N062pKiLPUXSDS6QEZH7faOegBuGgb51q9dLn2CD4zPMmnBBev3KpAe7zrqFOSy7cceJn464kRFwS/yTzZRyd+LZBJ2GDv4voNBX/oBgCp/Z/3TVT8uAiVmhjsxLX6ewoC+q3OZHocTSJgn9ILu5zNVNUIv64cUmGABI7qJWOkNIldDJDL01xPuNDwPlpqPCq8zQkf83rxM5m3+bilLPLrB/39bTBzN7TFh1fuTPLH0wohfQN9atKIgYkfNkBPwByo4GnbTl1s3Nuxve6qgBpe5r8+fxQo+Af9SPKcB8MB+3oIc1JNOBiLu9l0/GBRWy6JUYZYoccGRsBIBfpRBPbhwc1OUowStWr3z8nETkPNi46lQDfF4pVKHuMuf8x/b1+qJqjxuAF4eN6GROWZH2pSCOYHZX0Wsg8IojYqpPiEL+94x/YRRCRHJQyJU7CuX8QZq2aZ06bVuiUNpc8NLE9/hEacOaX9P5IsQr2ywQc+RjtCO/gL6EpBW763VGuy+RZrV2/ULvAZ1w2CHeuQguaFHxVuPp1A9QRRHVO6oW51ojQKFHm8g9RyD28HoQpbd7Dh8ff9QvxF50ozcNTELhHcoyUPKhLHlFclXGZJ5Oh5ZWKBfI47Enfw+zabcD8LpMxFfYJjDWvaK/YEH7NdgtR2KHArhemTXHHOdYIW8IaRXd2UAL8JTCqTxDFGg+BrbBanQYZU8n0V6DVNFjtXjYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66946007)(66476007)(8936002)(316002)(16576012)(53546011)(186003)(110136005)(508600001)(956004)(26005)(4001150100001)(36756003)(38100700002)(8676002)(31686004)(31696002)(2616005)(6486002)(2906002)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlabWtLYXZndHhwOHdjQjI1REtxaXZqZGd2ZzBUTy9nU1ZGakM0a0Nxd3gz?=
 =?utf-8?B?b0U5Mk8yOG5yVlFnM0xiWWRianBTQkg0N0Q1V2pqeFN6NEJ6dk9lSklJY0lm?=
 =?utf-8?B?b3BBcUJWS0JyWHpiR0dYOVYzZGMwSFcyQUFJWjBoS2hIWGtsd3ZGZGIxU0V4?=
 =?utf-8?B?WXVXRkUzaW1rUytNcG8xbkdQWW9ncXp0N2txczV2OUwycC96bzljYS91WEtE?=
 =?utf-8?B?ajRiUUZaOTVEZGRnZ1RVTGsxMTlrV3RWdy81dWk0VnhqYnlNNkhqM0U0dUlT?=
 =?utf-8?B?RDBiajU0Q2ZGSW5CTlM2VG82N3Z1ZXcwd1dEQUlHUlV2b2psbCt2ZVBSRGkw?=
 =?utf-8?B?R0l1aGV2TEhnVVpqNTRVU3V4RzBxT0lmUG8wbVliMGx3TFZJckVQSDU3YjlJ?=
 =?utf-8?B?NXZoMU1HZFFMQ3hnTC9ocFNhRm0wTVNMWXIxYmZFUG80d09EZE16UG1VVllY?=
 =?utf-8?B?b3R5ZHlISHh4c3NmZXY1ckFrV0lOWCtFNkNjMVZLdnlEMkNub040SmpHQ2Mr?=
 =?utf-8?B?UVJ2M3F5b2dXdE00L2crZnNCUDhmK1M4ZWFNSm9MbnUzcUZLbWVQaHRxRm5S?=
 =?utf-8?B?ZkpRbEV1U2VISEY5TUw5bU9HaEZnQzZzNnNDcG45RWJENVB5aGVkQldHOUo4?=
 =?utf-8?B?Y0hzTDdyYkVNbk1lSWJpYzE5MUdGQ3V4R25NZTIvY2J0N1Rvb3NHQ3lEanRF?=
 =?utf-8?B?NDlXRHZGNU5pU3VBQkt0QnZkdDFvU2lucVVyMHYwM3dzVHhMR3I5SmhObjNu?=
 =?utf-8?B?RTRNb3pSWkN5ZlZ1OUR6UzRuTHp1bGJSL2VBOWhKL0RUeTJhVE9KdUg1U2pE?=
 =?utf-8?B?UGtpTHc5aGxEZ0ExbS9UQ0xPY2EyQjdZL1lOdjQ4VkE2b25QSG5tTDdRQmR0?=
 =?utf-8?B?aHlLbHFab0UxR1pLVDNrd2hFaHplSjhHeUpSVGdtalIwbmJ2czdzRTNCTDln?=
 =?utf-8?B?bi9IR0NGOTVLR3FTcEpzSWFyZ21GYmJuOEtYV0FqRktVT2VVZ2xPcTdIN2VS?=
 =?utf-8?B?b3hHS3RrSHZGeWRPdjMyN1Q3S3o1T0k4VEpWOEdmSTIweGY4MHBhb285ZTFX?=
 =?utf-8?B?ZGd0c0s0OUJGN044L0o0amtOdEw1VjVqNmhDU3MzQjl4aHVraGg4akNzb05K?=
 =?utf-8?B?VGZDOEUrUG01aFdlaFp6NHJKckJQd1k4YkZzOVd0TjNhKzdWTTFod1ViSDRL?=
 =?utf-8?B?WWwyVlFhQ3luQldKVjFrQ21tcncybk9iQWszMnJoQ1VISWEyUkR0RjdFM24v?=
 =?utf-8?B?ZnRqakhoZXFQUm9HNTRhVVcwNFZrUEZ3V2F3WFUyQnFYZVRkTnluem5XdVJC?=
 =?utf-8?B?YUQwcnVUQThjeXUxZ3FzWHcwbGVoY0UrZTE0OWFOcm42MzJvTENpZStFWTFs?=
 =?utf-8?B?Vk1QQUtGMlFmUm0rWTVXdU5VcWIrODllUVpEK3FKb2dFTlNQcStBaWdsRjBn?=
 =?utf-8?B?Nk40Q2d5K0tISHBhMDc3OTJoVnRHVDNlUzNWM2tONlh3SmZ6WDI2ZXplSW9Y?=
 =?utf-8?B?RVViWE5ZZ3pxckxYbGV3ZHgrazR5VkY5WGFjc3RLdENZZHpyWDdJUlJjK212?=
 =?utf-8?B?a2U4enQ2T0RYcE01NWhZdkRlWXN6RllqY0pKY2FCWGZYSFdPanlVSzRUbytO?=
 =?utf-8?B?NXJ0MUh1UW1XM3dqYndTWE5md0hTeGhNSFNYaDRhM3BRK0RJbGdMb3oycE1h?=
 =?utf-8?B?T3pUU1l4K2l1Z0VIR1JHa3FycXRKb2FmVG9sSithQys3T1NDWExURldFNDhp?=
 =?utf-8?Q?kfTQKdAqj39myaTqWol+jY31/Ck+ak8l/6PZZuz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79e697d-0162-4e45-9755-08d98e9fc033
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 23:18:22.6928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1bCGv0BjZaFElPMgLRxVt+cBj0sSQPZLneKif1IO3e1Ote68MjF5Fhszw02Dwyu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-10-13 6:33 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7a0a21b5-9619-f3cf-16c8-2308f9b6d46e@amd.com">
      <pre class="moz-quote-pre" wrap="">
Am 2021-10-13 um 6:05 p.m. schrieb Philip Yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">When creating unregistered new svm range to recover retry fault, avoid
new svm range to overlap with ranges or userptr ranges managed by TTM,
otherwise svm migration will trigger TTM or userptr eviction, to evict
user queues unexpectedly.

Change helper amdgpu_ttm_tt_affect_userptr to return userptr which is
inside the range. Add helper svm_range_check_vm_userptr to scan all
userptr of the vm, and return overlap userptr bo start, last.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 93 +++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bd5dda8066fa..d784f8d3a834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1220,7 +1220,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
  *
  */
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
-				  unsigned long end)
+				  unsigned long end, unsigned long *userptr)
 {
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
 	unsigned long size;
@@ -1235,6 +1235,8 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 	if (gtt-&gt;userptr &gt; end || gtt-&gt;userptr + size &lt;= start)
 		return false;
 
+	if (userptr)
+		*userptr = gtt-&gt;userptr;
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index ba5c864b8de1..91a087f9dc7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -182,7 +182,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 bool amdgpu_ttm_tt_has_userptr(struct ttm_tt *ttm);
 struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
-				  unsigned long end);
+				  unsigned long end, unsigned long *userptr);
 bool amdgpu_ttm_tt_userptr_invalidated(struct ttm_tt *ttm,
 				       int *last_invalidated);
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 49c92713c2ad..95d018fe2287 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -50,7 +50,9 @@ static bool
 svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 				    const struct mmu_notifier_range *range,
 				    unsigned long cur_seq);
-
+static int
+svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
+		   uint64_t *bo_s, uint64_t *bo_l);
 static const struct mmu_interval_notifier_ops svm_range_mn_ops = {
 	.invalidate = svm_range_cpu_invalidate_pagetables,
 };
@@ -2308,6 +2310,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 
 	return -1;
 }
+
 static int
 svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 				unsigned long *start, unsigned long *last)
@@ -2355,8 +2358,59 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 		  vma-&gt;vm_end &gt;&gt; PAGE_SHIFT, *last);
 
 	return 0;
+}
+
+static int
+svm_range_check_vm_userptr(struct kfd_process *p, uint64_t start, uint64_t last,
+			   uint64_t *bo_s, uint64_t *bo_l)
+{
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
+	struct amdgpu_bo *bo = NULL;
+	unsigned long userptr;
+	uint32_t i;
+	int r;
 
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		struct amdgpu_vm *vm;
+
+		if (!p-&gt;pdds[i]-&gt;drm_priv)
+			continue;
+
+		vm = drm_priv_to_vm(p-&gt;pdds[i]-&gt;drm_priv);
+		r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
+		if (r)
+			return r;
+
+		/* Check userptr by searching entire vm-&gt;va interval tree */
+		node = interval_tree_iter_first(&amp;vm-&gt;va, 0, ~0ULL);
+		while (node) {
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			bo = mapping-&gt;bo_va-&gt;base.bo;
+
+			if (!amdgpu_ttm_tt_affect_userptr(bo-&gt;tbo.ttm,
+							 start &lt;&lt; PAGE_SHIFT,
+							 last &lt;&lt; PAGE_SHIFT,
+							 &amp;userptr)) {
+				node = interval_tree_iter_next(node, 0, ~0ULL);
+				continue;
+			}
+
+			pr_debug(&quot;[0x%llx 0x%llx] already userptr mapped\n&quot;,
+				 start, last);
+			if (bo_s &amp;&amp; bo_l) {
+				*bo_s = userptr &gt;&gt; PAGE_SHIFT;
+				*bo_l = *bo_s + bo-&gt;tbo.ttm-&gt;num_pages - 1;
+			}
+			amdgpu_bo_unreserve(vm-&gt;root.bo);
+			return -EADDRINUSE;
+		}
+		amdgpu_bo_unreserve(vm-&gt;root.bo);
+	}
+	return 0;
 }
+
 static struct
 svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 						struct kfd_process *p,
@@ -2366,10 +2420,24 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 	struct svm_range *prange = NULL;
 	unsigned long start, last;
 	uint32_t gpuid, gpuidx;
+	uint64_t bo_s = 0;
+	uint64_t bo_l = 0;
 
 	if (svm_range_get_range_boundaries(p, addr, &amp;start, &amp;last))
 		return NULL;
 
+	if (svm_range_check_vm(p, start, last, &amp;bo_s, &amp;bo_l) != -EADDRINUSE)
+		svm_range_check_vm_userptr(p, start, last, &amp;bo_s, &amp;bo_l);
+
+	if (addr &gt;= bo_s &amp;&amp; addr &lt;= bo_l)
+		return NULL;
+
+	/* Create one page svm range if 2MB range overlaps with TTM range */
+	if (addr &lt; bo_s || addr &gt; bo_l) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If no overlapping BO is found, bo_l is 0 and addr &gt; bo_l is true. So you
basically always go into this if-block. You should only use bo_s/l if
the return value from svm_range_check_vm or svm_range_check_vm_userptr
is -EADDRINUSE.</pre>
    </blockquote>
    <p>Thanks for catching this.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:7a0a21b5-9619-f3cf-16c8-2308f9b6d46e@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		start = addr;
+		last = addr;
+	}
+
 	prange = svm_range_new(&amp;p-&gt;svms, start, last);
 	if (!prange) {
 		pr_debug(&quot;Failed to create prange in address [0x%llx]\n&quot;, addr);
@@ -2672,6 +2740,8 @@ int svm_range_list_init(struct kfd_process *p)
  * @p: current kfd_process
  * @start: range start address, in pages
  * @last: range last address, in pages
+ * @bo_s: mapping start address in pages if address range already mapped
+ * @bo_l: mapping last address in pages if address range already mapped
  *
  * The purpose is to avoid virtual address ranges already allocated by
  * kfd_ioctl_alloc_memory_of_gpu ioctl.
@@ -2686,8 +2756,11 @@ int svm_range_list_init(struct kfd_process *p)
  * a signal. Release all buffer reservations and return to user-space.
  */
 static int
-svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
+svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last,
+		   uint64_t *bo_s, uint64_t *bo_l)
 {
+	struct amdgpu_bo_va_mapping *mapping;
+	struct interval_tree_node *node;
 	uint32_t i;
 	int r;
 
@@ -2701,8 +2774,17 @@ svm_range_check_vm(struct kfd_process *p, uint64_t start, uint64_t last)
 		r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
 		if (r)
 			return r;
-		if (interval_tree_iter_first(&amp;vm-&gt;va, start, last)) {
-			pr_debug(&quot;Range [0x%llx 0x%llx] already mapped\n&quot;, start, last);
+
+		node = interval_tree_iter_first(&amp;vm-&gt;va, start, last);
+		if (node) {
+			pr_debug(&quot;range [0x%llx 0x%llx] already TTM mapped\n&quot;,
+				 start, last);
+			mapping = container_of((struct rb_node *)node,
+					       struct amdgpu_bo_va_mapping, rb);
+			if (bo_s &amp;&amp; bo_l) {
+				*bo_s = mapping-&gt;start;
+				*bo_l = mapping-&gt;last;
+			}
 			amdgpu_bo_unreserve(vm-&gt;root.bo);
 			return -EADDRINUSE;
 		}
@@ -2743,7 +2825,8 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 		start = min(end, vma-&gt;vm_end);
 	} while (start &lt; end);
 
-	return svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT);
+	return svm_range_check_vm(p, start_unchg, (end - 1) &gt;&gt; PAGE_SHIFT, NULL,
+				  NULL);
 }
 
 /**
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
