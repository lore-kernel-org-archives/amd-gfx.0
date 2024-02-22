Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB91C48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 15:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4579710E95E;
	Thu, 22 Feb 2024 15:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NwL9O/Pk";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EED10E95E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 15:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgJCfOO7v246O6xFHWCYs/OXWSnRscFhor4KhZolShEUbsuBPaoczHXJNyv717gFZTqdqFJglxmPzpV3srviyk1J3IebsAwXpXpgf4z3WTsIVJffoJSSMPz9KnlzCmqMzoVKWOVSIrGpM9nbyICBDBnPW6pq/9goBZx5ptzfas+EXxgRbc2rxtpDmhj9F6mpxnk3coK5uyhnfeKlP38JQhbi/TYTQAzF0jCLG0Rhl8AsH3mtY82j3mfaqd0kKu9D3AFlmSrxVzOv5qiot3q4L0Yr1OD4XNaK2A5I4A86wt8N23zSOlB1VfWm1IJms20fBId5MpGCnWju+H9cC2IyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf+FOOo5FfsxxfpGlrYvA2JKm8Rpjiv2OqUZE/u7Ioc=;
 b=G72OdkwdWFqD6XfNC7C6AGBVpCzALYWIQI9z7gUxD7A1PBVcTv+WMwkIul54PD+ZxhXZiuPaFSWeV+R+K9R0EnDmxjIX+r0HcFFc2z5lg2OUA4m/Njj1fNb8uvnc4mjuy6sJPfXnSP5bnxIHpbW9Q7O8HUwbtKShkqP4CkeoHLhch+XUfzXToX8SmA+5nGhioiw5r2R28AHZwHDwqyj2U1oxKm64gNSoGx5cxx4Wc1ooYCuAU4U5FxT2lj3aFB9xtY64ZhKTLGcRfyljPt58Go1OpdZ8xArsG9ED3VOu+a9tvOsqOMyLPXYL8ADVjJqOrPamRDjHsC6rlmxnp6fbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf+FOOo5FfsxxfpGlrYvA2JKm8Rpjiv2OqUZE/u7Ioc=;
 b=NwL9O/PkTNh8N0Ewg3sTBZGKoJrMOZBtdCN9yRRw77qY0y9b4iujC1aDAmFFgvpWkNgWHYu81nKTIc3RCOTQZ0kD1+aUYqkN9xWFI/A8L/GBXUQ2BYv73fB+xG7lESkHs3GcNF+o0CG7h18h6f3NwyJAFd2n2e7dG7X76n59StM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:26:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 15:26:16 +0000
Message-ID: <8356bcb1-15de-1668-c12d-ce0efc28b935@amd.com>
Date: Thu, 22 Feb 2024 10:26:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: break COW for user ptr during fork()
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20240222020124.1302449-1-Lang.Yu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240222020124.1302449-1-Lang.Yu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: 431a30e3-fc7a-4ddb-7f60-08dc33ba9cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9S9RvItbe0nr3uwzVHMbB8/RKd5EI0PFKFjlw/IaUAAKb6qSofuBu4RFsuneuTzFFOXOrVaBRFFRrTRzj+1Dne9G0m5XmXl4NtlzAXdq5bDlLNQjdBaZGRYCOQ3jSfhWQgcJvNOZo1s3AImfEWS4bYRW2v/YtWHG2CqKyelLkRqi91z9UrydnsWOySevH6mKTB74guL34W0RRd2hzK7N1AfuFxgo8yrUDfyIj9ZSDRLJeU+mQpG2HORXdjInO5B2XKIzYDooOgoyi2PtQ/OaSR1shYkquLH3LqtTcEpN3l0gdk6s9+yuSfK6Ecgk3xkCzq8rQxknTSR2cwHk/O160A78Z9RIruqMV9/oGip/Z5udpf5mOl/AdffTV0vEuGEjyGoTOHbYRZnR64g4J+pbpUzaRonHs2C52GmzuMWfxTq2zHW4UXH6GvgftKCOWqkDNtX/wZJk+t350vaTilIOpW4odxuQb/K0S4bWFDON87H+wiNqvKyPwSl3EAAPMj1TCaEUERr+rL1aFuusIoo9XcGjYdnanFwTyf0de2s5l8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5MSHBmcUdnSjVPNmtRbW1aVWptSElDcmRmVjFNYlVqd210bVhxcy85UjlJ?=
 =?utf-8?B?Q2NFcGgybmVFS2ZXWXc0cndVMFlNdmQ1Vms3YjJXZ0dCQVp6RkdQbnB6aEdH?=
 =?utf-8?B?RGlDOCsxN1FYU1IyQUwrSi9vUXkxVHZUZWQyemV2cy9UN2srRmpZNzhiaFhi?=
 =?utf-8?B?MU51M0Z6YzZqNjgrWWYrSXZ1M1JXUWxpdG5FOE5Qa1NPZnRUQWRiN3M3VXR1?=
 =?utf-8?B?ZVdiZHNUTlFhbndGVUVJcENYR2VIdVpxNWRqR24xN3JRSVRzM2RsTGE1V0hO?=
 =?utf-8?B?bTBhNnMvNk41ME1xbW02aEs1K21zYyt3UzNHaTJhR0J1bjlXU0g1bEJ2cDZx?=
 =?utf-8?B?QzA4cUh5ci9GZnNzbUdJSEtqZitSa3Jvc0JWV1kvRjJNMjNNY1cvQlMrS2Vy?=
 =?utf-8?B?NmYvQUpWS0RHZk5pdE1aUU00WmJaS0NXRm53M1ZSdGs1cEpjdU42ZUwrdG1Z?=
 =?utf-8?B?eXV4VXRyc3k2b2lPVGFLRS9ud0xiUk1hTzN6a0tuUGQxOGxjb0dTYW9HaFEw?=
 =?utf-8?B?YldtQkhOdUdQQUI0QkdBQVFBbGxkNkN0Wm96Z3JoZXp6NjVXOVdDWDVQeGpS?=
 =?utf-8?B?VmhVRkw4YVRubWlGUDhSVWhQMFNGUkJGcDFZUFIwR0lGWnBBN2toVnh2TjZj?=
 =?utf-8?B?dHVya1FBYXo5ajlxRktYN3VqOEtwKy9lUTJpNzg1b3g0NitmazJ0Y0FFQ3dm?=
 =?utf-8?B?K0hhZzRKRVZzUTJycVNydjJYR1ZOdzZOcWp0bUZxR0ZkcXFLeXNlQlljclRa?=
 =?utf-8?B?aHZvVTJoM2VQM0lrRHR1YjY0bU42ZENxMi90Q3UvVXY0QkNueUZSNGVlR212?=
 =?utf-8?B?MFZ0RFprT1JBTm5NaUl4SWVEUFRTa1lyWk4vR0JvZDJVTWlUMzE3ZmpYbVJm?=
 =?utf-8?B?RXVDTFB5OTJjSy9UUSs0aHl5L0MzTExOQWtWaGV6ZDR1eWk2Y1ozd0RBaS8y?=
 =?utf-8?B?YU1kUGRFcGoyTHNtZmd1RzgzRzVPRUJFMGZDa2g3aVNibWtzbzN5UUR0dUlL?=
 =?utf-8?B?MTkwY0ZrRm1YbnRtMzZWMXJJQnMzcXVOMWNBZmNCbjJHejZiazdxcisvM2Fy?=
 =?utf-8?B?S0c5QUpiajdiTkxVd2RwUDZRQjNIdGxXREt4SFJXWElmanE5N1ZlSExYVkhT?=
 =?utf-8?B?a0dWcStPOVJab2x3K0YxT0lXaVJIMVMvbHg2a1Z1RWFWY1Y1S25JUlNrVm05?=
 =?utf-8?B?a0IvUE9XR3pKeDlCNkl3YlFjWUVydTZPTlBpNjlCaC9tT1BPdjRDRkxmUTJN?=
 =?utf-8?B?YldrN3pLd2h4QXFBTGhmdmgyME5zclQ5WklERE05bkxBU0U1K3BIS1prZDRz?=
 =?utf-8?B?TVh0RnBtUWFzcGVBd2dwQk9TOEg0b08vMitIdUJUay83eUExWURFUWxBR1Bj?=
 =?utf-8?B?VHRnMWxFTUtvUkJmZmF1dlFlWU82dGdJUlVIRzdVb0pnaEI3dmxkdEt4MFB2?=
 =?utf-8?B?a1hvRU5ZQ0JwMUJnc1lvYlRPMThIaURXK3JtYVUrSC9jRE5tR3BnR3NIS0lo?=
 =?utf-8?B?eHdEM2llYnkzR1BkenJTVHhmUXBRdzdCRG95Z0FnRTZ6TmkyeCtIaHNoNm1Z?=
 =?utf-8?B?cThJaWNhQ1pDOCsrSnRrM3JoWDhPUXRHWFl0WGdNWHg1L0dBK2VhaW1LVWFa?=
 =?utf-8?B?bjdHZjN5cVFRT3YyY1JTaHlMTXBjeXNySXJZaTkrd3RNQThDL3FmTlVDZ2pZ?=
 =?utf-8?B?R3ZBWEE2UysyMzhBM2ZWSUxmbmJvMEhTR0NzQVl4aVpsUTBVMmhvVWQzN2M4?=
 =?utf-8?B?Wkc1ZklxSzFJcFFISVZoR2RUbzZudlhtUGIwRHpKQXBxM1graWhiZXNuVUVX?=
 =?utf-8?B?WjJqQW12R3RaWnpUUTlab2pMd0JDV09qUy9QUGxSRmovbjVyVnIzSlErTXFp?=
 =?utf-8?B?RlR6b0NvRG5qV1c2MDFWOGtHbWRXMXF4K0dLb3BRakVLZnFmNDlDOGJDY0Mw?=
 =?utf-8?B?WGhUckdEREhZSThkdmF0Y3cwUXR5K0I2ZSsvY05PKzF5c21BSWVEOHRSM05m?=
 =?utf-8?B?SXN4TlJtNlhZelJiMVlHd2VBenp1S0xTZi84dlVTdmVvOEM0TG5DdUZ3RExw?=
 =?utf-8?B?d2V3bUhGKzBmeksyTzRrWjBLWUhGZ0hUVmhxTUV0RHJIcWNYdVNzZlg5MDlj?=
 =?utf-8?Q?PDjI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a30e3-fc7a-4ddb-7f60-08dc33ba9cc9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:26:16.8930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGQsR6HbPyMRX7H3jvVMlaIfD92iPEbL2aMW/t2fnH5luYZ7pRCmI68bZdvAeAgj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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
    <div class="moz-cite-prefix">On 2024-02-21 21:01, Lang Yu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240222020124.1302449-1-Lang.Yu@amd.com">
      <pre class="moz-quote-pre" wrap="">This is useful to prevent copy-on-write semantics
from changing the physical location of a page if
the parent writes to it after a fork().

Signed-off-by: Lang Yu <a class="moz-txt-link-rfc2396E" href="mailto:Lang.Yu@amd.com">&lt;Lang.Yu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a..2ee0af3c41b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -693,6 +693,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 	}
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
+	vm_flags_set(vma, VM_DONTCOPY);</pre>
    </blockquote>
    <p>This will break user mode because the forked child process cannot
      access this vma/userptr.</p>
    <p>This can be set by application if needed, using
      madvise(...MADV_DONTFORK) to avoid COW after fork.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240222020124.1302449-1-Lang.Yu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	r = amdgpu_hmm_range_get_pages(&amp;bo-&gt;notifier, start, ttm-&gt;num_pages,
 				       readonly, NULL, pages, range);
 out_unlock:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 6aa032731ddc..607a8f68f26f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1674,6 +1674,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			next = min(vma-&gt;vm_end, end);
 			npages = (next - addr) &gt;&gt; PAGE_SHIFT;
 			WRITE_ONCE(p-&gt;svms.faulting_task, current);
+			vm_flags_set(vma, VM_DONTCOPY);
 			r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,
 						       readonly, owner, NULL,
 						       &amp;hmm_range);
</pre>
    </blockquote>
  </body>
</html>
