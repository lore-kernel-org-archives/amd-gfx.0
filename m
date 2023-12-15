Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075FAC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972EC10EA2D;
	Fri, 15 Dec 2023 16:24:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7E610EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kapKSbXOzpH8yP/s8uAaDUbipuJU+tM0gDPfaTG8+MZxEkp9L+2W6UFPj4QshxXhDAEShGJrvDdJGOtfz7XrRIc1Z2T5bn8xDvIObZz6L88HENYoN2wxmcrihFJATxti3mJy8PI8EL8Uc9EC1Xyy1M/kE0ZcI7Ltc0dwWsvzwxRVUODpD1XxriC7F6aWYAy8gOVoqcCxyqxbK3YKv8MtW28Tr+pkX2mmn1f2UwEABMVYE/ULvMhbIHPwoiencK1uDrPWq8pgwVCh0ZrH7FIWBiiGx3IYp6IWA0/Gw1vT0VZsMbPwQ5d8DVNFIYg/Cko31syBih9LmnxE9TQs7q4UAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40xpWeuLhWgzOvqNX/9/yR1Wv2qCFAGto3k7yiaJsKM=;
 b=WdQ3woQi87DgZOU2xuTmtsb/JYBr/lh+uDYZy8QeDJSPB6B44JM3kpplAhSZ+Gxt4e3CzkITvbZHngqvlO9RYEtbLHCmgxgyijWadExg+Htzr0H/0aiT/SPJm8DOpNrfz26sO+DxB32mwD3XGge48++sJsYD9JNVxQMSEg6XeFX2czUdbq5LoZunYhvoGaXuI/tHjSn/a5mEhOOBWHrqwRf+hIol0+erYZY+xnumCWbFcdqpYJEM7PHBoHrZwwYykg3eZe45jAPYxCSlII5S60VMWB5OO0oClF63hOrLIhsRQqY3l5dunNzz6NSvv0HKdHBNdKwbKx+XaeiTB45bPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40xpWeuLhWgzOvqNX/9/yR1Wv2qCFAGto3k7yiaJsKM=;
 b=GnmMbLAZoVI5HGu3JNcTdga9G0r42JrbsHO90Uc3bKw3jTy5psWi+5rY+nfTAtqE3M5KGNW1/ZHY0q2GeQKBfqr0UDbBV8Tgq3QCbKVNzO6qLCEkha8GbAW78C9WncCiCPP/JxKQox7VbR/b3jRqoqS0VO5KRE5nMpYBiPJ9y6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:24:54 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 16:24:54 +0000
Message-ID: <bf317e46-160c-8281-0c94-bcc12b843842@amd.com>
Date: Fri, 15 Dec 2023 11:24:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231214002413.8485-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231214002413.8485-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 36552970-7662-4d70-cc8e-08dbfd8a5ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6d9sv16t1dp8LAOWemewjDsahNPKrqMpvB/22Bh2Yp3JY7IBfMFLfR+FUgKLYZzZAtZTbWu14msCOHAfmJCQne5/n5dwnSAfRYE8N39j63uHbxN04B9IofI60V8Cl7LeR8RjZkc3j+FzEG8481aNui/WH9/EYFrHWFVxaAsenQNYFFvX/O+AxKwWl8Ie7xBQAAUhsnbKSgvZ46rg0XC6lzOn251+Ptw5EmU1vpeOyAGOW67Du/Flu6jFulcl47JxSZlVkmELsNknp6YiL334co3uOx1VJIlsnZdcji9n3grkWcLHDiYAL53jPIsUfGdvLJgGlc40ntPTN1CwamEVVPu8tfezrWoOr9G48F94cfUvm0/b4aIix7Y7/j1scztz3gPhgwMhYYtV4NuH91WKhnmqQRnBcvQSGpYCClHRfZXR/3ct3/marELuIc+zLcQT3dfJZtwLu4p0rEcp396k4/ej/ujtgwm/ACBFYTGK7UtRpR6k+HbBykAyVtbJMvaZz9dvbSahUWhBiciwTSOThyaIiGk5zLJXD4IgbRzHtPWuPGrLQksUE13r1J43NV+VW+r9DGajoSv2kiJXm6RF+CGOvoTI97yzuVhjdQYNuDIgjXgRjhFdCvE/m9qanBmsbPy429CSSrnzwoyjcLwHtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36756003)(31696002)(31686004)(6666004)(6506007)(6512007)(66556008)(53546011)(41300700001)(6486002)(26005)(38100700002)(2616005)(83380400001)(30864003)(4001150100001)(5660300002)(478600001)(8676002)(66476007)(66946007)(4326008)(2906002)(316002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRxRGZONGpjVGRDQno2Q1NZRy9VNTdmOEt5SGsycmFDK253cWVhU25vcGg1?=
 =?utf-8?B?ZHo4R3FVUWtWU0NCa0Rsc3lYMmk4eGNmcVdPQ290MEJBMlcxdDlmMklFcys1?=
 =?utf-8?B?VmR2VkhwaDQ4RFRmWUVQVHhiUloyejdyZlhNdHNGWXN3MTVXb05MbCtweW5z?=
 =?utf-8?B?c0Q5Zk9CS3lnRzltb1dGSEhrdmt5TnF6UXRpMllwYnJtN1hBV2wweGorNjlZ?=
 =?utf-8?B?QzIwSnNEOHF0YkFrS0tacUxYS0J0YjVPajkvR3VJbEtWUjg0SFI5Wlo0VkI3?=
 =?utf-8?B?c0VpV1NWRExyYWhUUzhKbHZzVVFXT1R5czhrUnE3b29LMXhhZ05iTHNoQlFj?=
 =?utf-8?B?anZQQkd3cTZFOHlaa25oTFV3YTJyZW5TNmw2bzZQRVlJckRNbXY0aUtxbXpo?=
 =?utf-8?B?eGFraGVZL3ZhOVlYSFBGSE9ZYkNOd002VkJxU1l2Wnp5VU0zaHFnRVpoMkY0?=
 =?utf-8?B?Vmo3aXJKSDlMUkc0U3VIc3YwSnBGSXIxZ2lFdHVVUnlEalNnd3BTYjBVamZB?=
 =?utf-8?B?bytaeTRjTE9ZdFR2cWJJWm9KWGY2bXpDakdXa1RpUGZrUUduTDY4QXpRR3d4?=
 =?utf-8?B?UkRtY1RLUWxTanlkaUY2ZWFQOUlVaVJZVGFvNmZueUJuM1NWQmhTQm8wMUky?=
 =?utf-8?B?K3FOTEY3dll4V1Q2am5OYUg1Qm92OTRXMlZteGRXYVFzeGJKblZjK1FkVGNH?=
 =?utf-8?B?bll2MUhvemtQOTM5cmhNZmdna0R5QmxuWi9GMEJCWUt4alc3SEk1RnlLcloy?=
 =?utf-8?B?YnlZS0J3WXNqNSsvZmsvOHA5SFZDckVVMXpHZlUrekNFSU9MZDdkdVpkdEpk?=
 =?utf-8?B?UmlTUS9rUS8rS1FBNzdXSzdmcFRzUXRveEIweGR2R2xtamdXaWtBSlRJcmlh?=
 =?utf-8?B?bzVjKzJkYnhTL0YrWHZwZUtKTXJjVnZka1RMcjV3Wi9tNytDbngvYTNIQzMz?=
 =?utf-8?B?NW1XVUJyeXdCaTdnalpQMEVSWkg3cjJnZzZvck94TktmTUpGMG5uVzR5Skwr?=
 =?utf-8?B?Qlk5NUE4alFzWEU1aDNEeXVNSDlvYjNMWGl5RHhET0ZYOFJ6N3pVVjFEa0Qx?=
 =?utf-8?B?YVdHUUtCOHVnQkR1VTVscDViRlBZVkRQeFZNckk5VUt3cUJRa0hGazFQbUI1?=
 =?utf-8?B?VTEvMkFENndPckFjemhQVHN1TkV0ZndnTEc2SlZmRlJQVXBrK1pDRGNQRGpY?=
 =?utf-8?B?MjV0NTZmTGRlaHpUU0xiVWVaZk1BdW5vQnNHdGlrc3pOVDhVeWdXaXZqUjdp?=
 =?utf-8?B?cmRLeExZZG0wZ0ZDc2lZRnZnMHlLQ0RpdU9vcTE1RDZQajJjaEdWZXhKYmNL?=
 =?utf-8?B?eFVMTlVjYWsxOGt3WTRCVFdBR25PcnM5UUVOdW1idTVPbW9YRUZGMXZRaDhT?=
 =?utf-8?B?R3Q5SGhwNVhhbGFiQmpTeWtubEtBTFFNNWdLNURZSW9BYklYdm9zVmM4SDBZ?=
 =?utf-8?B?QTJuVmxoYlZsTXVRVUpid1NJNlRqU21TM2xTUVA4RjZFaHVpbU5zZEZrd0pV?=
 =?utf-8?B?Q044VldaYXk3UlZNbzZ2eXNqK3o0QWJsZHh6REVzSGdZZlZNUW1DKzFwcGM3?=
 =?utf-8?B?QkREMEJ0S0hmU1VQUzJHeDBGcDNtcnU3Q3EzNm9sSVRrZmF6eVRkeVJRYndK?=
 =?utf-8?B?aG1Na3RON2hoc20rYWhyU0pkSEN4TXg3Zi9nY3kwam01VldCV2VwUlI0TXFG?=
 =?utf-8?B?ZVc1SlNNWHRWNmo0S1E3UUdvVmdUeUhTT2VmMllpMUp6UnQyNjRaa0U4ODBi?=
 =?utf-8?B?YnE0Z1NxR2VDcy9lQ1FnU0ZqWGF2Y1l1SmY0eE1DZUs0aG5Scy9XU3Y0NDVH?=
 =?utf-8?B?RFFYdy9UalpQVlJmWGtQYXl0STRlTWlIVWRTME1DQW5tMFovRFZ0amJVN2w3?=
 =?utf-8?B?MUQwRTREZWxyOElESnp1SUE5ZFRwWlEwa0dDcFpwaG5KZDJwWFYybzJoaDdj?=
 =?utf-8?B?TGdzc3NRbjExbVVpUWUvT2NrNjkzYXJtNEJybUZMK0lQNFN1ajB2UGxwWFlu?=
 =?utf-8?B?S2xtTVdZd3ZsZTg0MFU0U29uM2UyTXhtT0JoZ1R0ZGZqSHVlUGhWbWZIdEVZ?=
 =?utf-8?B?dUkzREVIdDIwU1RTaSttVUtSM1E4SkhQamFqamtoWVZZZ0h5R3NXVmFleDBx?=
 =?utf-8?Q?87aI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36552970-7662-4d70-cc8e-08dbfd8a5ee1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:24:54.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofJ7F4owmRIVsHTNDdd3jrw4lbnnlhfUEUmTOuLeEP8PstPwA0/6VkDeVWzNtWOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-13 19:24, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

v2:
-not need calculate vram page number for new registered svm range, only
do it for split vram pages.

v3:
-use dma address to calculate vram page number of split svm range;
use migrate_vma from hmm to calculate page number that migrate to vram.

v4:
-combine calculating of vram page number of split svm range and page dma
address copy in same loop if original svm range includes vram pages.
</pre>
    </blockquote>
    Please move the version changes after the patch description.<br>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a></pre>
    </blockquote>
    <p>Thanks for the effort to improve the partial migration
      performance, with some nitpicks below fixed, this patch is</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 35 ++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 79 +++++++++++-------------
 2 files changed, 48 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b854cbf06dce..3fb8e59acfbf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,19 +260,6 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
-{
-	unsigned long cpages = 0;
-	unsigned long i;
-
-	for (i = 0; i &lt; migrate-&gt;npages; i++) {
-		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_VALID &amp;&amp;
-		    migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
-			cpages++;
-	}
-	return cpages;
-}</pre>
    </blockquote>
    This was called incorrectly before migrate_vma_finalize, agree to
    remove it.<br>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
-
 static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 {
 	unsigned long upages = 0;
@@ -402,6 +389,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
 	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
@@ -450,12 +438,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	r = svm_migrate_copy_to_vram(node, prange, &amp;migrate, &amp;mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&amp;migrate);
 
-	pr_debug(&quot;successful/cpages/npages 0x%lx/0x%lx/0x%lx\n&quot;,
-		svm_migrate_successful_pages(&amp;migrate), cpages, migrate.npages);
-
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&amp;migrate);
 
+	mpages = cpages - svm_migrate_unsuccessful_pages(&amp;migrate);
+	pr_debug(&quot;successful/cpages/npages 0x%lx/0x%lx/0x%lx\n&quot;,
+			 mpages, cpages, migrate.npages);
+
 	kfd_smi_event_migration_end(node, p-&gt;lead_thread-&gt;pid,
 				    start &gt;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,
 				    0, node-&gt;id, trigger);
@@ -465,12 +454,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r &amp;&amp; cpages) {
+	if (!r &amp;&amp; mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
-			WRITE_ONCE(pdd-&gt;page_in, pdd-&gt;page_in + cpages);
+			WRITE_ONCE(pdd-&gt;page_in, pdd-&gt;page_in + mpages);
 
-		return cpages;
+		return mpages;
 	}
 	return r;
 }
@@ -498,7 +487,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	struct vm_area_struct *vma;
 	uint64_t ttm_res_offset;
 	struct kfd_node *node;
-	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	long r = 0;
 
 	if (start_mgr &lt; prange-&gt;start || last_mgr &gt; prange-&gt;last) {
@@ -540,15 +529,15 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			pr_debug(&quot;failed %ld to migrate\n&quot;, r);
 			break;
 		} else {
-			cpages += r;
+			mpages += r;
 		}
 		ttm_res_offset += next - addr;
 		addr = next;
 	}
 
-	if (cpages) {
+	if (mpages) {
 		prange-&gt;actual_loc = best_loc;
-		prange-&gt;vram_pages = prange-&gt;vram_pages + cpages;
+		prange-&gt;vram_pages = prange-&gt;vram_pages + mpages;</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">prange-&gt;vram_pages += mpages;</pre>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	} else if (!prange-&gt;actual_loc) {
 		/* if no page migrated and all pages from prange are at
 		 * sys ram drop svm_bo got from svm_range_vram_node_new
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..61e363e388f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
+		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange-&gt;dma_addr[gpuidx];
 	struct device *dev = adev-&gt;dev;
 	struct page *page;
-	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
-	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i &lt; npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
-			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.pgmap.range.start;
@@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
 				     addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
 	}
-	*vram_pages = vram_pages_dev;
+
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns, uint64_t *vram_pages)
+		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd-&gt;dev-&gt;adev, prange, offset, npages,
-					  hmm_pfns, gpuidx, vram_pages);
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -885,14 +882,28 @@ static void svm_range_debug_dump(struct svm_range_list *svms)
 
 static void *
 svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
-		     uint64_t offset)
+		     uint64_t offset, uint64_t *vram_pages)
 {
+	unsigned char *src = (unsigned char *)psrc + offset;
 	unsigned char *dst;
+	dma_addr_t *temp;</pre>
    </blockquote>
    <p>uint64_t i;</p>
    <p>For loop variable declaration inside is not used in the kernel
      code, and use type uint64_t, not int for pages.</p>
    <p>move local variable temp declaration to inside for loop.<br>
    </p>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	dst = kvmalloc_array(num_elements, size, GFP_KERNEL);
 	if (!dst)
 		return NULL;
-	memcpy(dst, (unsigned char *)psrc + offset, num_elements * size);
+
+	if (!vram_pages) {
+		memcpy(dst, src, num_elements * size);
+		return (void *)dst;
+	}
+
+	*vram_pages = 0;
+	for (int i = 0; i &lt; num_elements; i++) {
+		temp = (dma_addr_t *)(dst + i*size);
+		*temp = *(dma_addr_t *)(src + i*size);</pre>
    </blockquote>
    the size is used to support 32-bit and 64-bit pointer size, we can
    use type cast here instead.<br>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		if (*temp&amp;SVM_RANGE_VRAM_DOMAIN)
+			(*vram_pages)++;
+	}</pre>
    </blockquote>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; num_elements; i++) {<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *temp;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp = (dma_addr_t *)dst + i;<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *temp = *((dma_addr_t *)src + i);<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*temp &amp; SVM_RANGE_VRAM_DOMAIN)<br>
    <br>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	return (void *)dst;
 }
@@ -906,7 +917,7 @@ svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
 		if (!src-&gt;dma_addr[i])
 			continue;
 		dst-&gt;dma_addr[i] = svm_range_copy_array(src-&gt;dma_addr[i],
-					sizeof(*src-&gt;dma_addr[i]), src-&gt;npages, 0);
+					sizeof(*src-&gt;dma_addr[i]), src-&gt;npages, 0, NULL);
 		if (!dst-&gt;dma_addr[i])
 			return -ENOMEM;
 	}
@@ -917,7 +928,7 @@ svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
-		      uint64_t new_start, uint64_t new_n)
+		      uint64_t new_start, uint64_t new_n, uint64_t *new_vram_pages)
 {
 	unsigned char *new, *old, *pold;
 	uint64_t d;
@@ -929,11 +940,12 @@ svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		return 0;
 
 	d = (new_start - old_start) * size;
-	new = svm_range_copy_array(pold, size, new_n, d);
+	/* get dma addr array for new range and calculte its vram page number */
+	new = svm_range_copy_array(pold, size, new_n, d, new_vram_pages);
 	if (!new)
 		return -ENOMEM;
 	d = (new_start == old_start) ? new_n * size : 0;
-	old = svm_range_copy_array(pold, size, old_n, d);
+	old = svm_range_copy_array(pold, size, old_n, d, NULL);
 	if (!old) {
 		kvfree(new);
 		return -ENOMEM;
@@ -955,11 +967,15 @@ svm_range_split_pages(struct svm_range *new, struct svm_range *old,
 	for (i = 0; i &lt; MAX_GPU_INSTANCE; i++) {
 		r = svm_range_split_array(&amp;new-&gt;dma_addr[i], &amp;old-&gt;dma_addr[i],
 					  sizeof(*old-&gt;dma_addr[i]), old-&gt;start,
-					  npages, new-&gt;start, new-&gt;npages);
+					  npages, new-&gt;start, new-&gt;npages,
+					  ((old-&gt;actual_loc &amp;&amp; old-&gt;ttm_res)) ?
+					  &amp;new-&gt;vram_pages : NULL);</pre>
    </blockquote>
    <p>if old-&gt;actual_loc is not 0, then old-&gt;ttm_res is not null
      too,</p>
    <p>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;actual_loc ?
      &amp;new-&gt;vram_pages : NULL);<br>
    </p>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		if (r)
 			return r;
 	}
 </pre>
    </blockquote>
    <p>if (old-&gt;actual_loc) <br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; old-&gt;vram_pages -= new-&gt;vram_pages;</p>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">+	old-&gt;vram_pages -= new-&gt;vram_pages;
+
 	return 0;
 }
 
@@ -982,11 +998,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
 	new-&gt;ttm_res = old-&gt;ttm_res;
 
-	/* set new's vram_pages as old range's now, the acurate vram_pages
-	 * will be updated during mapping
-	 */
-	new-&gt;vram_pages = min(old-&gt;vram_pages, new-&gt;npages);
-
 	spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
 	list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
 	spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
@@ -1109,7 +1120,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *tail;
+	struct svm_range *tail = NULL;
 	int r = svm_range_split(prange, prange-&gt;start, new_last, &amp;tail);
 
 	if (!r) {
@@ -1124,7 +1135,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *head;
+	struct svm_range *head = NULL;
 	int r = svm_range_split(prange, new_start, prange-&gt;last, &amp;head);
 
 	if (!r) {
@@ -1573,7 +1584,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1652,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
-	vram_pages = 0;
-	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
-	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	start = map_start &lt;&lt; PAGE_SHIFT;
+	end = (map_last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
-		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1677,13 +1685,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r) {
-			offset = (addr - start) &gt;&gt; PAGE_SHIFT;
+			offset = (addr - (prange-&gt;start &lt;&lt; PAGE_SHIFT)) &gt;&gt; PAGE_SHIFT;</pre>
    </blockquote>
    <p>offset = (addr &gt;&gt; PAGE_SHIFT) - prange-&gt;start;</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20231214002413.8485-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
-					      hmm_range-&gt;hmm_pfns, &amp;vram_pages_vma);
+					      hmm_range-&gt;hmm_pfns);
 			if (r)
 				pr_debug(&quot;failed %d to dma map range\n&quot;, r);
-			else
-				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1716,19 +1722,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end) {
-		prange-&gt;vram_pages = vram_pages;
-
-		/* if prange does not include any vram page and it
-		 * has not released svm_bo drop its svm_bo reference
-		 * and set its actaul_loc to sys ram
-		 */
-		if (!vram_pages &amp;&amp; prange-&gt;ttm_res) {
-			prange-&gt;actual_loc = 0;
-			svm_range_vram_node_free(prange);
-		}
-	}
-
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange-&gt;validate_timestamp = ktime_get_boottime();
</pre>
    </blockquote>
  </body>
</html>
