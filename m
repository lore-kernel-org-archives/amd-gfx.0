Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC6AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B2D61266
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39B2D61266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B388D6EAB3;
	Thu, 18 Nov 2021 16:46:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E92BA6EAAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ+3bnKtZV6UBnCXbhmwgPniu7Izf6gaD66bPzbpheTKVpS3XnB60QKMHl6Mdse9iTt+sItwv6mgjiyhw8ijBNKEp563lKbnzFRc6Okvntq87RUA1h/PT3EzfNKisRWgfsv2yDjus0Uwo/a3pmLZkqGGHIIr4f8bU/30F/W18XV4jTahhQAqAXHrSjwt45MGC7k0m4fedcVyy5xKX/1/pL+g54/HkVaXCSwS4pMbzFLS96Be3X0GUbP3l9c5ELLHsLaWH9LXyCupfkve0v/4E2ZLhBFZy3/qZcDalNbx7CFDCuCLODS6ac/c/02hFxj1bVUm0TNwme4VPb3vpMQ4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6M8yP0gXgX58jrMUCItJI9L95PUwmO+69WqpTyvq9g=;
 b=lpZd84rxsJDvjD7z4L3grVJobsLpTnbjpVx4YOJv6D5dSHUeCUvQ6iuUo7XqiDHZpWiI12KcwSpLWRRDDqNER45uedvhXhukwrjYUEHXPb9DwV2BvQwepaDYBXYUHcFqDLMRJUDpXj2zO4dfVa1K0BDuTvfyFMgGFD+QdhXaKfdbBuBinDmtpdUJCKh9nU/lJAGddwqwkT2r7g1VP1pRXFbDnqib/01P1teCyTkJUNnjoBFrDRli7MnzqdD7PMrZPhob+bab0w9H6w1/odYm8ixweQe/MIrk3v6s+lS6nIvrrNsOwwhikGlydW+rppXkeCpbDmKc08WBcxqor7xSug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6M8yP0gXgX58jrMUCItJI9L95PUwmO+69WqpTyvq9g=;
 b=XgCOfXTFRg9FO7m2Cr+Rosao9h4qaZXZQvgnXZi+hDy26/wlx8HFLNRNsojUWxe3BWpI2hUhgFDsSL9uJO0iBxdGlABmlN55AhevXXEZ+n20cr3QGhcqaG1gYRBiimegaR9sN+udJSBjWslDiahlGTEvQR70GIAe4K0M/dBKdb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB5517.namprd12.prod.outlook.com (2603:10b6:5:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 16:45:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 16:45:59 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: simplify drain retry fault
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-3-Philip.Yang@amd.com>
 <71b8c251-97f3-3064-7861-d2bdb24b6ae9@amd.com>
 <eac293ce-bbf5-fe59-a12c-b0113e64f66e@amd.com>
 <423b2831-ba9c-3239-574b-ae3ac8ebb112@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <2425ef80-5129-262d-de53-97d7908cbd94@amd.com>
Date: Thu, 18 Nov 2021 11:45:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <423b2831-ba9c-3239-574b-ae3ac8ebb112@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL1PR13CA0199.namprd13.prod.outlook.com (2603:10b6:208:2be::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend
 Transport; Thu, 18 Nov 2021 16:45:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8b84531-613e-4808-f8e5-08d9aab2e60f
X-MS-TrafficTypeDiagnostic: DM6PR12MB5517:
X-Microsoft-Antispam-PRVS: <DM6PR12MB551732CFDB2C957E9F7B123FE69B9@DM6PR12MB5517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 074eFJteIjLEEPyBbkecjOxroGH/xhwuj1GV+oIEHsSq6oPuI0oPuO+nw1zgSYTxx3j9YLggerpc1Cl2pkUJGDjv1BvXund1LZO8zl+odOJwufq+wr+BLtEQeFYtZ4p8KSbwOVNXgFPAYc5aC6QPFelUy2bBM/7dwuOjqQY0RAvlr8mT0D8+gTBvQ1qWx/UPURUieUWdfg/GvTiYgW69UsMbFgHPUg/OHOJCXjuX/dGsYAqXlpQqMDhL4jWBiPkJHRkwL+K77SP7nj9fmby8hIQblM8A4m/Z0odEqEuKwRx6Cwtm9b12gd+t9YLjSfdgXHyoXqbLUQ2fG3unjqhUYefvTq9xPx19rPJqn/bRYQqnU9zkdAIs5/JLCAadLhu+i5VE0Bz1Fqsmz3ZdVcUTtn6oixrnvf4SqgSB59atcYghINXTYMI27DN/qkXNmQ0t+JicHlPDzEzxIQqULZA0wak3arYUSa/UCZfHP18w9dH5pQHyoWyInu9vsQYhv8zrjfKeEszTGXcMyOfJ+2nb9XV8uuj/zxER2kkCjQMbttmm3LaleBN46avNOnzfxF7OVhzYfLa6yyPrvjC3LM1a7+3AVoITkiO5xIM+Q1ej10f400CzpRg6cCMeHF4xnMHIkWLn3PwRU95V1906Lpxts9GX2KFxcbXoMkv7T30YarLlpJg2kH31tzlqHl0YgBY8Gei33YFu++8r7S+TvT0l3MO8akWtPOs7uJ3LtQtZbuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31686004)(53546011)(66946007)(66476007)(8676002)(8936002)(31696002)(6486002)(26005)(36756003)(2906002)(66556008)(4001150100001)(186003)(83380400001)(2616005)(956004)(5660300002)(16576012)(110136005)(316002)(38100700002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZsZEdTbGR3VkowODZoMTBoVFpTSG42WGhoUTJXSWVhcXg0ZENvZWJma2dX?=
 =?utf-8?B?Qnkzd1ZRR3RkZ0Y2T2FpbDF5YVVJN2tYcWlSMW44MVAvaDZ1MWozOXJEeElJ?=
 =?utf-8?B?Q3Qrc0pqQWZHakdjcDVCejNKNXprazF1Mk4weTd0WUdaTkMvM25WY1E0VlVD?=
 =?utf-8?B?aFhaYm03dW5HaGp0SzlGWU50amhIejgyM1kxK1ZjN0p4anYxMUJKR2o2K3RJ?=
 =?utf-8?B?YW10VzVOUHk2MFRsVGNCOVg3bE9NLytpWXpTL05ISUVPSnM0TUNmSEpTYnYz?=
 =?utf-8?B?NUMvY0QwcXZQVm0rL1IvdUlNUU1xeUdxWHRwL2pjN3VUTEhONVExSGVZRHlk?=
 =?utf-8?B?YTNiNW5ySWMwQkpjT09tOHNkVjZ4MnUveEE0TUlNWmlQNHI5NytmZ3Z6bTZM?=
 =?utf-8?B?bTR2WnBmdWFndTQyK2lkeVd2RzA5aTZ0MS9pSDdWN054cWNVNDRWRmxja3Bz?=
 =?utf-8?B?cklxdTVXNFhhVHFScklDTVI1OVNSVmE0VVhHaXpKTWdyOFl5R2kybGdRTERz?=
 =?utf-8?B?OVJEMzRTR2RaSjBMV2F0eFFRckV3bTVOQi82NzV1ejJHSVlZWElldTFMV1Zv?=
 =?utf-8?B?M3pINU9Fd0hLS29HWHJiVW1FdTRvcnhXaFBtTzhRNU1EL0FyQjJBNDhRK05G?=
 =?utf-8?B?ZU5aSzdTV2RDVnZtc200V3crbHZMT0Q4VHFob0NmMlRaYWRNcm9MZ01mU3lo?=
 =?utf-8?B?S3lNejlDNE9HWGNUeTNzZ3I4NFBZVmdzNXNaNmdZSlluaGxrRnR0d1dBTURE?=
 =?utf-8?B?T0NEaURZT1E3ckdyYjQ3UTVFYUpPenBnYzRYRUVrN0FuNVc2V2IwK0poOGVr?=
 =?utf-8?B?OXIzTDJXWFR1cnpIdzNPaWR1TkZINk1ISWJtcS9iQTZMcldrQU5vekRNa0tG?=
 =?utf-8?B?L3pScWM1V1h6R01KNXVtR0taa0JqMGN4UWtyaUtydEwweVJKVkI5KzBQeWtO?=
 =?utf-8?B?dHkwbnRxOTJJNlY1WGVIMGMxclo1eW5IbHBrbWpwY1REaGoyd3pLRE5aeFJQ?=
 =?utf-8?B?TnNxK2RBdjdmNDc5MnIySzZySW1pM2E5aDFva3Z5blhJeWpFdTY1YmxySjUw?=
 =?utf-8?B?RnVvSWoxRXBwbVJnaDZiSmxJVkgrVTlmR1JrSDBuaTd4dVZ0c296TEprem0w?=
 =?utf-8?B?bWdHZElzRmUyUElTQ0RlU0tuVUlQZFRydDQ5TncvdnE2d3B6bkZneCtaUTFq?=
 =?utf-8?B?cDREZnZsdVJLYnBRVWhMSGVWdFFFQW5RZk5YaVE5Ni9TRnRseHFCRTAxd0lz?=
 =?utf-8?B?UXRCZmltbThXYnZOWE9MR2JxZXUxdTNhT2R5Z05IeERldjdQcXRxSmlqS2xr?=
 =?utf-8?B?cGdsNkF4VUEvUHMzakZQMEN1TzJFN3FObmxxWlo3UndlZ3BMRHlrd2pJNU9K?=
 =?utf-8?B?V3kyaWZZVXRudEw5b3B2ck9FNFdiVGRtd0tYRDlzWStqOUVVTTJHQ0NLbTdH?=
 =?utf-8?B?cUZYZVIzTUhHL3lXZDBEOXYvSjYzOUVsRzNXSk4ySEQ4NUg0TnVYVzZlSXcz?=
 =?utf-8?B?Q1BPcGoxK0pYWjBoTU1QcE5YL1ZaTVZZRUxXcHd5Y1dnbmFEcXFuVDhKWXlT?=
 =?utf-8?B?cm5Rd2xMUDFCYWZXOGI5N3JIODJ3S1VwbDBhNktRTG5pR1pFVkhEdUlqdTdG?=
 =?utf-8?B?dnRxTkRZTTc4amtsam04R3E0blJZTmFxREJZdU9oSHo4aURNTmFCaEZVenp3?=
 =?utf-8?B?bkdYWWVOcGlDdytRQVNrMkxtR1RiSDlyOE5NZG9JU1BLQysyR2ZacWpFTHBV?=
 =?utf-8?B?bkloS3FrZERFTDBaN1phU3BQb09TbmQ2VDRKaW0wdzZ5SkFhWmlJbW5kVzJy?=
 =?utf-8?B?R0U3dGx1SHVEMFFDcWtHUlhNVGIvRGNUQWpTZkNsVDFKQ0lsQTAxbU1XTis2?=
 =?utf-8?B?di9lakI2SHhaaW10S3B3ZUM0Qm1hOHVPV1YvVm9TNTg3emJ1WWpxOHRWLzRQ?=
 =?utf-8?B?S29YSUVuZlI5YjBucjZCaHc0VFB3cHVFbFNTMXRGZ3I1Q2hYRnFGRlNlUHhO?=
 =?utf-8?B?ME1YbzRWMHFPcFVvOWg0RU9QVm5RK0VzM3U4TGl3MHhpeEJCRktkckRLVUZT?=
 =?utf-8?B?SC9KQzlzdFJWSFIrQnFINXVXSW10em5zUW1QUHlNVGRWcnp2U29XMk9jdHlG?=
 =?utf-8?Q?oGCk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b84531-613e-4808-f8e5-08d9aab2e60f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:45:59.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxa4UvmO8FZNRd42KzDZyVIcmXkZB7rmFQxS1fb2kDapcJU5o6Al6Eb7ePFtLdMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
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
    <div class="moz-cite-prefix">On 2021-11-18 11:39 a.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:423b2831-ba9c-3239-574b-ae3ac8ebb112@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-11-18 um 11:19 a.m. schrieb philip yang:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2021-11-17 7:14 p.m., Felix Kuehling wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
On 2021-11-16 10:43 p.m., Philip Yang wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">unmap range always set svms-&gt;drain_pagefaults flag to simplify both
parent range and child range unmap. Deferred list work takes mmap write
lock to read and clear svms-&gt;drain_pagefaults, to serialize with unmap
callback.

Add atomic flag svms-&gt;draining_faults, if svms-&gt;draining_faults is set,
page fault handle ignore the retry fault, to speed up interrupt
handling.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Having both svms-&gt;drain_pagefaults and svms-&gt;draining_faults is
confusing. Do we really need both? 
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Using one flag, I can not find a way to handle the case, unmap new
range. if the flag is set, restore_pages uses the flag to drop fault,
then drain_retry_fault reset the flag after draining is done, we will
not able to drain retry fault for the new range.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">I think the correct solution would be to use atomic_inc to set the flag
and atomic_cmp_xchg in svm_range_drain_retry_fault to clear it. If the
flag was changed while svm_range_drain_retry_fault executed, it means
another drain was requested by someone else and the flag should remain
set for another round of draining.
</pre>
    </blockquote>
    <p>Tanks for the idea to use atomic_cmp_xchg, it will solve the
      issue.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:423b2831-ba9c-3239-574b-ae3ac8ebb112@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Regards,

Philip

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
&nbsp; Felix

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h |&nbsp; 1 +
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp; | 24 ++++++++++++++++++------
&nbsp; 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1d3f012bcd2a..4e4640b731e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -767,6 +767,7 @@ struct svm_range_list {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deferred_list_lock;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evicted_ranges;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drain_pagefaults;
+&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; draining_faults;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restore_work;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *faulting_task;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3eb0a9491755..d332462bf9d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1962,6 +1962,7 @@ void svm_range_drain_retry_fault(struct
svm_range_list *svms)
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
&nbsp; +&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 1);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = p-&gt;pdds[i];
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)
@@ -1975,6 +1976,7 @@ void svm_range_drain_retry_fault(struct
svm_range_list *svms)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;adev-&gt;irq.ih1_work);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i,
svms);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
+&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 0);
&nbsp; }
&nbsp; &nbsp; static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2002,6 +2004,7 @@ static void
svm_range_deferred_list_work(struct work_struct *work)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mmap write lock to serialize with munmap notifiers.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(READ_ONCE(svms-&gt;drain_pagefaults))) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 1);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(svms-&gt;drain_pagefaults, false);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_drain_retry_fault(svms);
@@ -2049,12 +2052,6 @@ svm_range_add_list_work(struct svm_range_list
*svms, struct svm_range *prange,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, enum svm_work_list_ops op)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svms-&gt;deferred_list_lock);
-&nbsp;&nbsp;&nbsp; /* Make sure pending page faults are drained in the deferred
worker
-&nbsp;&nbsp;&nbsp;&nbsp; * before the range is freed to avoid straggler interrupts on
-&nbsp;&nbsp;&nbsp;&nbsp; * unmapped memory causing &quot;phantom faults&quot;.
-&nbsp;&nbsp;&nbsp;&nbsp; */
-&nbsp;&nbsp;&nbsp; if (op == SVM_OP_UNMAP_RANGE)
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;drain_pagefaults = true;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if prange is on the deferred list */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;prange-&gt;deferred_list)) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;update exist prange 0x%p work op %d\n&quot;, prange,
op);
@@ -2133,6 +2130,13 @@ svm_range_unmap_from_cpu(struct mm_struct
*mm, struct svm_range *prange,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx
0x%lx]\n&quot;, svms,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, prange-&gt;start, prange-&gt;last, start, last);
&nbsp; +&nbsp;&nbsp;&nbsp; /* Make sure pending page faults are drained in the deferred
worker
+&nbsp;&nbsp;&nbsp;&nbsp; * before the range is freed to avoid straggler interrupts on
+&nbsp;&nbsp;&nbsp;&nbsp; * unmapped memory causing &quot;phantom faults&quot;.
+&nbsp;&nbsp;&nbsp;&nbsp; */
+&nbsp;&nbsp;&nbsp; pr_debug(&quot;set range drain_pagefaults true\n&quot;);
+&nbsp;&nbsp;&nbsp; WRITE_ONCE(svms-&gt;drain_pagefaults, true);
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
@@ -2595,6 +2599,13 @@ svm_range_restore_pages(struct amdgpu_device
*adev, unsigned int pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
&nbsp; +&nbsp;&nbsp;&nbsp; if (!!atomic_read(&amp;svms-&gt;draining_faults) ||
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; READ_ONCE(svms-&gt;drain_pagefaults)) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_mm;
+&nbsp;&nbsp;&nbsp; }
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt; vma-&gt;vm_start) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA not found for address 0x%llx\n&quot;, addr);
@@ -2732,6 +2743,7 @@ int svm_range_list_init(struct kfd_process *p)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;svms-&gt;lock);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;svms-&gt;list);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;evicted_ranges, 0);
+&nbsp;&nbsp;&nbsp; atomic_set(&amp;svms-&gt;draining_faults, 0);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;svms-&gt;restore_work, svm_range_restore_work);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;svms-&gt;deferred_list_work,
svm_range_deferred_list_work);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
