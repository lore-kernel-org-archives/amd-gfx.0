Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C815CE79D4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 14:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC17410E02B;
	Wed, 20 Sep 2023 14:20:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32D510E02B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 14:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fhr8mGFg1+TCyXn09sFSDRPziE4afy8qMO7q4LBy7oyZ/lwrOOEzw6BtEdXOCme4Q4ZpptHe+QZsn1VruKeX4B4R6oY336eC4ga8PV3E44ksnl+teMKO9YrvwWo+sWcp2MIVF+cqzBLZYXasBD1zTGd8dH4PmB/cufONJla06UdYNhYWlqjfzroz6UJj4EAbyAga58ob+8FuLY6uG6uWrOdLSQpQdLrhlH1wlwdYPfh4upHpBoKLh/JRs8uzkbR7mT/oW1hdTnoLbuRUt/egjUIDabiQISuL+45cU9IazXQGUCLY0FvXjemgTJNWhTxvkta1WTCZBJ6TpSE81f4b2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C//pwKuqWD1HqtEcW+s+S+/udkaiQbDDZq0tdoFZNUw=;
 b=aWuLpdKOTLiyfoRihFOlzEo5R9MPq/eHx3n3TW8WYGgz+ffBGN+V8vCAj1lo+oHGv1M6Hh0ZYPJJMuhEGYUPtrFXj2mJj6M0IoXP4M39EzQh48gtX1Lkj67d8/5yTG8ghueqxhSOwMFZks4sq7aVuA6oUDcGt7Q/j+iRJujUSDi/d05MuIdq3qRZeSzlwA5IyVQrBtmzPSc43TdH/eGTooeU7lQSoA3Ol/xlUPKcLNiFkoqzXUer3xCR9oqI7MuTS8RSaDfx8bq1KsPzyiIFA2MdkZMQm1mJZQ4IkJQOUZhJ7ueoHA1xrTn+XWoXpuxXPCBF02dO2HvOJ4dmNdz0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C//pwKuqWD1HqtEcW+s+S+/udkaiQbDDZq0tdoFZNUw=;
 b=cpp1BS2lORwlCk3dJJP5KLe4HZ6ZZE3tHpFGqdiuuIpAjGXUtovm8xvCPzQpnBSzq+A2wbNUJijSdBf+DnhDm7Vnp/+7xM4lFancrxk+DEtZCQEq6qe9cwYB6NxG5ZAG2WkMIOWEGRyI2Z7eBB5H8nKOqwzJBdlto27mVVcCTSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 14:20:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:20:17 +0000
Message-ID: <b505cf13-aa3f-efaa-9510-fdc71ec94fd3@amd.com>
Date: Wed, 20 Sep 2023 10:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Handle errors from svm validate and map
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230919142124.15092-1-Philip.Yang@amd.com>
 <cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0256.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ce308e-8bb1-4708-2aa6-08dbb9e4b6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nACNhbaywNJxSBobs9XS5PAZAsjTZPb0WjWrnAxx2NOa1GDeUAMDnNE7rgpwjxCrd8uj+y8tevv/ZHcE0yfgVOsjALcHN/7LqsqKzFKcw4pRslTVrVTSm/uwI5A3FCpz24LS/6oPUUf3XgwVdHqiZnSsJBD/Fcy9LDcE3NG462UJ/ZkuKPzQH/UCVwkPziaJoQU0ghH/XStj59GKL12NmaxNOkT9C6s59uZqVnxU6ZkhYa6TYCRPI9xhvR2i/UMYV+yLRL2GYVbtOUoOdzfy+R6DihIohjDiLDvK35HV/F+3rnUCCDtRf9Ud3Md0eRWX0WU5Nzyt8xYgdBuxYpY7m9wsPTNqIv3JDy2Y90B9BjW/oZxCq9GTyDxT7O34ErOukBxXHgyVZg3RbMPZxSr/w3Yn3YxMo/FwhSa8o4i3iH3lye+5/u5IGi6HxEhF6s5MnIyO8zU5XOmYctW+mLrbsg8vCBzOuL9ClG+YGpPb8SS7cxvhAyq2wl8fJLA/y4WJm91fNuuOHkKgRSQtI5PhPBIfqWskadSMZdUfB2Gh7VoiSUMnCTORSklCHg82X2cf4qnuYENlp0+/HG5fmmRJ7UMJSKj3ysalO1Y/obTZtJvGoIHQwxz4DA2OWHPee4tCnh8VQCCq1cL8Ck9BOBOoVPhSr618SHdS43vNl58BKnr6M3TTvgZzmLrXLc9zC49e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199024)(1800799009)(186009)(5660300002)(2616005)(41300700001)(15650500001)(26005)(2906002)(31696002)(38100700002)(36756003)(4326008)(8936002)(8676002)(83380400001)(478600001)(53546011)(6506007)(6666004)(6486002)(6512007)(316002)(31686004)(110136005)(66946007)(66556008)(66476007)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnRUakRWUFJYaHFGWlZSRG0zcGYwUjMwekdHc0c4MklBeWxwUmRZMlppdjFr?=
 =?utf-8?B?Y0x0dXlPL1h3LzBvNmRMSWd5T3NsZmY1bWlTUE9SSFgwUkR5cTRXdVkwQXFr?=
 =?utf-8?B?aEFYcWhRUUo1YXhNU2JvNlMydUw2aXpFbVJrME04T3lZeWRWZlF6K1pVc0pk?=
 =?utf-8?B?K2xpWnJIVlNPbmpHZlBUK0czc25MbHFaMmhOaVRKRklIbENwM0lmQlA0ay9Y?=
 =?utf-8?B?NXl6YVVpeTZNaFRDRWNIRlNlaVpIQXZtbUUzakVHcVErcTdkTndPc2dWMi9k?=
 =?utf-8?B?SkNmZ1UrNlA2N0Y2VFUzekxZd092SDJxNkJUQkxhdVROcHpXeGg5Q3loQ2Qx?=
 =?utf-8?B?TXBQVC8yRUFCTGdpbnl3V1h1U3NmSk1HM3VFMDJyRXpIVXZWK3ErMkVrRUcy?=
 =?utf-8?B?NXBhTXd6aGV1NUUzTXRlK0ZBYktGdzVDb295cmRCNFBaTGlPUHY2b0pwRldu?=
 =?utf-8?B?K3JFQzE1b2tkZ2VJRnpEZ1JiZUhORVpZdktnc3p6d0xTSWpJOW8wUHBsQjlj?=
 =?utf-8?B?cTdDeWdFR2FRQ2ltK0t6MUFiREVXSlR2QkJoUDRvWEFmbzdmemlmM3k5WHJy?=
 =?utf-8?B?MlVQVDl0N3MzcHl6Ly9KbHJWbUlubzAweTdkNnVsQVo1OUdTWjl5SHRVUnVh?=
 =?utf-8?B?bStLcDB3aC9nZytpOXA2dWxqMTVZQm5qclV6amxyM3VDWTVMZWIxNExvVDdk?=
 =?utf-8?B?MzI5RkVYZ2ZkNGhhK0RHZ0Y1Nnhnbll4YzJmdGMrMlVTN2Z5RXJnNGhMbUFt?=
 =?utf-8?B?NGQ1TnE4NmJkOGg3UTNFbmpRZG5zcUN3Vjg5c21taFQ1ZHlTNWU3SStvdVcy?=
 =?utf-8?B?ay94R3NpVnN6MHhPY25mR0xiSmlrWHRZdHlvOUlCcFpDNGZ6aVVHL1NhSUZ5?=
 =?utf-8?B?QWRLajV3SCtQN0JXbmU5WmIrejZQL3dQWng4RVJLQ09zN0EyMm1TT3E5b1Qv?=
 =?utf-8?B?Mm1uekt1OTVEKzAxMXR1SncwT0Fod0FHT0NuYW9Sd2xoRkRoTDhZRDhkS0lp?=
 =?utf-8?B?MTQ1b3NiRmJKSWM4SUJCTFBRRHNqYmZZS2VqQ21YSlgxVkZMem05WG1Gd3N0?=
 =?utf-8?B?WUwrdkluK3BEYmVPWmUrWU5DRVcrNkZ6NHdGeVRIZVl4TnRNTm9tNTk3SXVK?=
 =?utf-8?B?aGxGZkdSajdBa1ZCRVZYbHRaaWRFTDZ4RWowdGZSeFVXa1BUcWhoZUJhbnRr?=
 =?utf-8?B?NHBjdm10c0d5NUNjQTBqaHI1MHExSHdQYTdVVkxVL0ovNnkxV2trQUM1YUox?=
 =?utf-8?B?QTVmN3JpKzlXUDVLazZMSGtlNW12L0FhazhTVTN4eWM1Q2pGNk9Ka0h5Z3lm?=
 =?utf-8?B?U2Y5V1hMc0pESDh4T1ZoZDdVY0FNMDY2SzgwaHJFdm5iUGw2eXAydTlKQzVR?=
 =?utf-8?B?QWc5b2h5VUMrci94M0EzdEpXZUFMMiszWkFWcklXdDllWm1rbWkva3A0NGVz?=
 =?utf-8?B?K2NVdUo2bDRwc1QwWk1jdndWOXIwYS8vNThKZ0ZVK1gwQ2lrc05ITHdZbkRV?=
 =?utf-8?B?TlVLQnAxeEhEQWRVUXZGY3Znb0ZmRHJEU2ZXU0R3MllQUUV2aXhGS1RLSUpv?=
 =?utf-8?B?WXVTUjVKeW1hTHJQYWR5bk15NGY3K3JUOFJqcExQZmZPNCt6eFBKL3paYkhq?=
 =?utf-8?B?SmlSTE9yL1hCM1N0QTlabU02M3FhbnF6NEp2MTlVZ0tHMUdWY1R1aCtyTmFH?=
 =?utf-8?B?a2tKNnlMRlR5UVRmMUgzYzBheW1KNjlEMTJ2ZnRkMi9BNHN6M0Q0cnB6Tmdh?=
 =?utf-8?B?VC9uaHM1TUdhV21Gb0V3TVcydnMyZG11ODd1eXpGRzFDZzhRSHNhUS9BYm91?=
 =?utf-8?B?NjcybFltZVEyZVlRM3kyenN1ZnFmWnFRY3RTT25SZTNpOFVqaU1yVGt1VDla?=
 =?utf-8?B?b01mbW44cmFrQnAyTW44TnpIT3FtbUZuZUlVSi9BQmt4YXhham1YaFNFSXdk?=
 =?utf-8?B?dFQ0eVIyYmZwVS9xTnlaQk1GNUlTRnRJYm1jOFBLOXFpUEwvRGhkWWV3Vzdk?=
 =?utf-8?B?RWM4bm5zaUxlb2t0L25wRklYQ2ZqQlJPdmpERmRGRmZ3b3dYMjdrb3ladTdw?=
 =?utf-8?B?RXUwaDFvUllBN0p1SjBKYlozVWN2NlBBUi9rKzI1RmFHTlJnOSs1UVZVdmNJ?=
 =?utf-8?Q?e1vs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ce308e-8bb1-4708-2aa6-08dbb9e4b6c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:20:17.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIbdp3KhDZuPuTDItSC27tbl2wnYx07GGiABo0mY2o//6jC8XAkt5u2ewHMnTYX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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
Cc: alex.sierra@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-19 17:15, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com">
      <br>
      On 2023-09-19 10:21, Philip Yang wrote:
      <br>
      <blockquote type="cite">If new range is splited to multiple
        pranges with max_svm_range_pages
        <br>
        alignment and added to update_list, svm validate and map should
        keep
        <br>
        going after error to make sure prange-&gt;mapped_to_gpu flag is
        up to date
        <br>
        for the whole range.
        <br>
        <br>
        svm validate and map update set prange-&gt;mapped_to_gpu after
        mapping to
        <br>
        GPUs successfully, otherwise clear prange-&gt;mapped_to_gpu flag
        (for
        <br>
        update mapping case) instead of setting error flag, we can
        remove
        <br>
        the redundant error flag to simpliy code.
        <br>
        <br>
        Refactor to remove goto and update prange-&gt;mapped_to_gpu flag
        inside
        <br>
        svm_range_lock, to guarant we always evict queues or unmap from
        GPUs if
        <br>
        there are invalid ranges.
        <br>
        <br>
        After svm validate and map return error -EAGIN, the caller retry
        will
        <br>
        update the mapping for the whole range again.
        <br>
        <br>
        Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle errors
        from svm validate and map&quot;)
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 78
        +++++++++++++---------------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h |&nbsp; 1 -
        <br>
        &nbsp; 2 files changed, 36 insertions(+), 43 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 50c29fd844fb..4812f4ac5579 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct kfd_process
        *p, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return !prange-&gt;is_error_flag;
        <br>
        +&nbsp;&nbsp;&nbsp; return true;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -1671,7 +1671,7 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
        <br>
        -&nbsp;&nbsp;&nbsp; for (addr = start; addr &lt; end &amp;&amp; !r; ) {
        <br>
        +&nbsp;&nbsp;&nbsp; for (addr = start; !r &amp;&amp; addr &lt; end; ) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hmm_range *hmm_range;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long next;
        <br>
        @@ -1680,62 +1680,55 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool readonly;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma = vma_lookup(mm, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vma) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vma) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = min(vma-&gt;vm_end, end);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages = (next - addr) &gt;&gt; PAGE_SHIFT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, current);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
        amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr,
        npages,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly, owner, NULL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hmm_range);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm range pages\n&quot;,
        r);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_out;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly = !(vma-&gt;vm_flags &amp; VM_WRITE);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = min(vma-&gt;vm_end, end);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages = (next - addr) &gt;&gt; PAGE_SHIFT;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, current);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
        amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr,
        npages,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; readonly, owner, NULL,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hmm_range);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, NULL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm range pages\n&quot;, r);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -EBUSY)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset = (addr - start) &gt;&gt; PAGE_SHIFT;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset,
        npages,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;hmm_pfns);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to dma map range\n&quot;, r);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_out;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset = (addr - start) &gt;&gt; PAGE_SHIFT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_dma_map(prange, ctx-&gt;bitmap,
        offset, npages,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmm_range-&gt;hmm_pfns);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to dma map range\n&quot;, r);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_lock(prange);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_hmm_range_get_pages_done(hmm_range)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp;
        amdgpu_hmm_range_get_pages_done(hmm_range)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;hmm update the range, need validate
        again\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;prange-&gt;child_list)) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp;
        !list_empty(&amp;prange-&gt;child_list)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range split by unmap in parallel,
        validate again\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unlock_out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset, npages,
        readonly,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait, flush_tlb);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset, npages,
        readonly,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait, flush_tlb);
        <br>
        &nbsp; -unlock_out:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = !r;
        <br>
      </blockquote>
      <br>
      I'm still concerned that this can update prange-&gt;mapped_to_gpu
      to &quot;true&quot; before the entire range has been successfully mapped.
      This could cause race conditions if someone looks at this variable
      while a validate_and_map is in progress. This would avoid such
      race conditions:
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; next == end)
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
      <br>
      <br>
    </blockquote>
    <p>thanks, will also add else path for error handling, to exit the
      loop with correct flag.<br>
    </p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (r)</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = false;</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unlock(prange);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (addr == end)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
        <br>
        -
        <br>
        -unreserve_out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_unreserve_bos(ctx);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; prange-&gt;is_error_flag = !!r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = ktime_get_boottime();
        <br>
        &nbsp; @@ -2104,7 +2097,8 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = interval_tree_iter_next(node, start, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr, attrs))
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr, attrs)
        &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start || node-&gt;last
        &gt; last) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range and its
        attributes
        <br>
        @@ -3517,7 +3511,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *next;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool update_mapping = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool flush_tlb;
        <br>
        -&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; int r, ret = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages
        0x%llx\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid, &amp;p-&gt;svms, start, start + size -
        1, size);
        <br>
        @@ -3605,7 +3599,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp; out_unlock_range:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dynamic_svm_range_dump(svms);
        <br>
        @@ -3618,7 +3612,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;pasid 0x%x svms 0x%p [0x%llx 0x%llx] done,
        r=%d\n&quot;, p-&gt;pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;p-&gt;svms, start, start + size - 1, r);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return r;
        <br>
        +&nbsp;&nbsp;&nbsp; return ret ? ret : r;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index c216c8dd13c6..25f711905738 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -133,7 +133,6 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu;
        <br>
        -&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_error_flag;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; static inline void svm_range_lock(struct svm_range *prange)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
