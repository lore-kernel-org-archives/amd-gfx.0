Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D180CC04AA7
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 15:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B8010E047;
	Wed, 20 Sep 2023 15:38:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2004410E047
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 15:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZVYCaIOH85p5YmovW9Pl9EzV0czk94vPjCKLIqA+mX0CWgmnKceM9kebbAd5UGIeMm72oHLm4tfzcND7uCN7KQmAl6tm1WgMd9yCQZts2yS/sKc7tC/NS5OZ+NvmTqLO0luePI+wgAkUEyLVX+zEv7+LfMdR0wHW5Qz9nmicImtbfqRFDf5pXi4tGEv2bRd04OYwZOXdGFwOb17MgY7ifQqWdoAxGEV+dx+XguYydiHtitbY9hiGvo0yL6JMkJK1pcz3GnXGDHXrFbbJDjw8MiVZnQq+2Xp+SyDMHRENV5APEJepkBoMmWSxI/Ric2IUqEiqIVOc6rNGJBOVj04yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYcmLwjNO1Gcdx4v/oBFyXG2bgxRQO6wCN2DiWOn6i4=;
 b=ELJssOOAESwMnYYiKta+12ZZDiHg0l2l0GsxL6icziJR/fcF0q3b19sWAsBO51YeRWb4RsQQHj16/RSUMegqByDFDNR01gLEektMMP/ugQpiGDFkEnetg/H4FoFsGkzngFwvSKfHVSG+5nZTwt+tOtbCkQJ9wx7MJj7bwIruicuVdKuDv47YgNL7XCy1+O7Q6BEg91UdiLwtE7P5JuAA6BYd1GtQ9aHFmpCm5fpa/jOEzgbZHDqf4tW+3GV6j6mOQ+MOTc72tfforjH8YXqdR4SUAbOabllvJuIL4GpScDyPga8y30dcJ4ZBwBYwcXOSqf/05YfXa1aQNsXNnKt3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYcmLwjNO1Gcdx4v/oBFyXG2bgxRQO6wCN2DiWOn6i4=;
 b=3+F10wZpjVlLlwc1clggDfxbXcViIQCpeIgvLhFFX7pJJbfZu90Id0RZXpAe0+L1ZAmd9wQLgNyKQDo6w4TOGApdceZw9CGxdE2i7/eWjZutGqGgzZxuv4/VYGDnU51a+IfRUEnxnfs2FD7kCHhW8rwi4Ebg2oxw9Rhwe/gJNtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 15:38:31 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:38:31 +0000
Message-ID: <28100466-4bef-7bac-ca19-9b5541b3f590@amd.com>
Date: Wed, 20 Sep 2023 11:38:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Handle errors from svm validate and map
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230913151617.18894-1-Philip.Yang@amd.com>
 <20230919142124.15092-1-Philip.Yang@amd.com>
 <cb12d72b-8427-89c1-209f-eb08901eb40f@amd.com>
 <b505cf13-aa3f-efaa-9510-fdc71ec94fd3@amd.com>
 <b6fb1ca2-906c-08c5-9dd7-34e7f21af870@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b6fb1ca2-906c-08c5-9dd7-34e7f21af870@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0316.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aa3036-dac6-4692-a02f-08dbb9efa495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJp41TG5uMlsXT15m2T5Gv5G2tNXOj7wCrwBRCO7oo8TsRY9s6o86hY2dcUtEECwd5NBGN3kKnaTmN1xt7z9siUskU7fjM3U1ani4Fa4rydwebAqb+JONCKiWzMV4RiZdNh7PJjkZfdodiE/AJ7OXJEoTUTX7FhG7pOlclqv0AXqX2WaQkNNGv4z7+TUvaZczDclrqi620LVfUNrunomQyEjadKVO68ccB/q0pHX1LTmF8NGPVpFHKAki4becGdXo6LiXdW5c6ugOz2guoa3h8xKyqTQfPrMKJ9kQ+oFUt0yI1vn5YQe9LDVfaVqrXNN300cKXbswh/95djESqUKyJJgz2YQguWRm8LVHPBV3BPnxvyUcmqSKS79Hb8oQURVE777YZgm1od0vyIjpv4yRmQWI69hdeGSs9HxjMS2DV7/fBna0onMq9o61EhzLciWZgrE2W7P2wAuqc6FtHHUne1zqqPDrj0u98V/uSJVvLc4VArMFgWOIzQXUL07xHrfts/K7GJ6RDtts4ud1bje+GVhuIdW4fOoSM1wbSnUJjPjMSpJYKf0l32vIICtBb9s+E45PE7bEt0GDSVEhS+IQxSKasqsIVj3coiT274XYwU9+LnokJCjTm3Cwg46If/0GvtA2VQZ/3c7Xmc8R3MUub6jGPcSeHUOZ8LzgyZjAfb8045tGE/k2sHzrbV9S2yp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(186009)(1800799009)(451199024)(6512007)(53546011)(6506007)(2616005)(38100700002)(6486002)(66946007)(110136005)(6666004)(31696002)(478600001)(26005)(66556008)(66476007)(5660300002)(4326008)(8676002)(316002)(41300700001)(8936002)(2906002)(36756003)(15650500001)(31686004)(83380400001)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29SZFRBaVdqV2pTL1Fib1I5UEs3M0dqcmNXbXNSUkhkSmZtaE9Ia2djVlV5?=
 =?utf-8?B?QXFyMmFUTHZhZEJaK2FzdVpTRk15VSt2S0dzbDdVcmFmVVdzRXd4cVN2TzdU?=
 =?utf-8?B?U3ZRSjlJQ0F4dGFmZkUvM1RJMkdJUmY5MFU2ZGp5NlozZllpYWhFc09lUUlO?=
 =?utf-8?B?TXRZQzZFSjdTZDhNaWJ3SXBXY1U2ZEdpR2hnRktvK3A4ZmVZTXRMbGYwdkVM?=
 =?utf-8?B?M09YYzBUa1FpSzN6TGtuOVcyNkZGcnltT01xTlRIc2kzWGRNbkZaNUJqRHZm?=
 =?utf-8?B?a1dwT24wMWVjbWI2ZUgwdmZ2N3JnKzgyWkk1eEtBYmpuWUdNcnVPY01CK3Zv?=
 =?utf-8?B?SFo3RVo3bmdQTEU3bEdMZWx6Y1ZGKzhuS2pVOGlTL0xzVEpnYjM1U3dxNTJX?=
 =?utf-8?B?WTczQUlRcTBYT3pTYXFMWEVCM1FHQUJ3OFVlL3hmdmNralVvTEdlU1RlUzJF?=
 =?utf-8?B?SHVPS2xrRDY1aDBBV2tjTWx1aVB5SEF5M1djMStHenJmWDg2eHBoZGlHMW5n?=
 =?utf-8?B?NERoWmpWbm1WTy9aWnErbEtyWUFUTzc1cHdWZDNZdWFXVlRiODdHVXpxU3c0?=
 =?utf-8?B?MTNCRmNoVEs2VmZJZ1BuSHJpUXJ5OUk4S1NPdU5nU0MyUktvV2NDU0d6WVYy?=
 =?utf-8?B?V3JkQmd6WFRpR3I4aU14c3c5ZXp4WG5VdWt2RG5UemVTeHFibTlNWU0rVGp2?=
 =?utf-8?B?eDFIOFRmOVh1MkVvY2lseGVlOVA0amhmNUh0eWo4QVBNU3ZzRkxxbzZraWNj?=
 =?utf-8?B?dDcwcERiYUFSeWF3VUZGRHlhQStQQ0Zyb2NoOHY2ajYyL0IybmJuNzNUTVJp?=
 =?utf-8?B?dU8wNzluUjBJM3Z1MmVxY3hhZExSQ1VEY0RnQ2pld05VYTRjUWJrVjAvVU1E?=
 =?utf-8?B?WDNrY04wWUE0UUgrTWdPbDkvQ0xwcE50OGd5elVweVFWUFZnd0dnR3YxcTBp?=
 =?utf-8?B?Z0ZpbHpQM1paYmNlZndnYzMzVGlUTmVqTzFJc09uV3ltb3Z1OGFuRWJHTThm?=
 =?utf-8?B?bVlEbjJMTExCQndsUVpQc2NSMUVTbmpFM1BLa1pZNm9TQVlSNFFuVkRqSk9n?=
 =?utf-8?B?UlVrRUpnekt6NzdvS0twQktVVy8rOERMU2g3Zjhiay9qZk9mc1VZZ3F4MU9K?=
 =?utf-8?B?STVnRVZ1WGFWNlFsOHUxeWlITzJ5dzdHTE9jSEw4bi9rQVRmYTFUNlZ4cG5o?=
 =?utf-8?B?NUp1dFhOUTZGc05PbngvN3BUMFhRVCs0UjNqeThyY0FmY1JXemZxTU9tZk1y?=
 =?utf-8?B?VHF4L0s2elZGQVZmQms2M2kyS3pjYTQwNVc3SGI1WGt4UVNsQytWYWlwYXU3?=
 =?utf-8?B?S3RpRE9hczU2bjFPNnFoWlAvc0Z1b2lXZWFrYk1jNTA4Vkh0eWFiaUJUMStN?=
 =?utf-8?B?QnB4TTJtV0lXWmJyOGFRRXphb3pwNjRTVzQ1ZWZMVkx5dGxjS3luSU5ORHVn?=
 =?utf-8?B?ZDlFS0lVMU5FWlZSemVWeC9KME0yMTNxS0M0cnFaU1BLVXcrQ2VDcEFQVWR3?=
 =?utf-8?B?WG9QUFJQMWg0Ums1MUNnRmkwWEU1TnR2eTdoa0lIY0g3M2lmQ21lcDl5ZVlF?=
 =?utf-8?B?Z2swVm5ndUZyUmVjSERseWRYOHlTOEYvbnJmNmhhVTF4SlBwaE1RWEYyOXpX?=
 =?utf-8?B?VU5nU3lkRStGWUlJc1Frd2NpQnVDV3NQV0hZU1NPNkowYVU1VFRSQllYYnc2?=
 =?utf-8?B?RUE1ZjNUYXZ6ZnNTclR3WkFpZG1zSkFjeWF0dm52ZUFHYnA4YlF2Rmt4TEVk?=
 =?utf-8?B?RzRKcnF3UDVFTFQ0RGFOWDRwSm8wUGhEbUhMRmw4cTAwUTUxZjFOUEh0NCsw?=
 =?utf-8?B?alBxMFNINFN4eWJVayt1UmdUcU5zWENnY0t5a3U3dlNuUUtOSnBFYzJtZ3JF?=
 =?utf-8?B?Tk5VOUlQYW9EdTdyQit2VnE4KzlXNVBHdzlDaVQyQ3dUS2NMcjNLT0ptYmNp?=
 =?utf-8?B?c0lGeFlEWE5KRWFQRmFlak1ZMzN6MWZEOHVhWTRPT0dKMmFOTzA4cVlKKzdQ?=
 =?utf-8?B?cDdKZERYaUIzMWw3WmRVckZ4T0xpbDNCZXAvV2VqM0FHdWZpUWhLVkJQUTlm?=
 =?utf-8?B?WEZNRnpOaU42ZHFhTU9CdFRBOEdpQ0Q0OWtIbWEyNzh2SitjaXpXbWQyRFpD?=
 =?utf-8?Q?F3QR6OlGZgzzIDN8msG+/Ty9W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aa3036-dac6-4692-a02f-08dbb9efa495
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:38:31.4175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+GSDQCSfoHbbuPKkmnJyDyDAPEZmA49Gso69NSBy0Y5Llux6GpWPm77CZoWlO7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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
    <div class="moz-cite-prefix">On 2023-09-20 10:35, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b6fb1ca2-906c-08c5-9dd7-34e7f21af870@amd.com">
      <br>
      On 2023-09-20 10:20, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2023-09-19 17:15, Felix Kuehling wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 2023-09-19 10:21, Philip Yang wrote:
          <br>
          <blockquote type="cite">If new range is splited to multiple
            pranges with max_svm_range_pages
            <br>
            alignment and added to update_list, svm validate and map
            should keep
            <br>
            going after error to make sure prange-&gt;mapped_to_gpu flag
            is up to date
            <br>
            for the whole range.
            <br>
            <br>
            svm validate and map update set prange-&gt;mapped_to_gpu
            after mapping to
            <br>
            GPUs successfully, otherwise clear prange-&gt;mapped_to_gpu
            flag (for
            <br>
            update mapping case) instead of setting error flag, we can
            remove
            <br>
            the redundant error flag to simpliy code.
            <br>
            <br>
            Refactor to remove goto and update prange-&gt;mapped_to_gpu
            flag inside
            <br>
            svm_range_lock, to guarant we always evict queues or unmap
            from GPUs if
            <br>
            there are invalid ranges.
            <br>
            <br>
            After svm validate and map return error -EAGIN, the caller
            retry will
            <br>
            update the mapping for the whole range again.
            <br>
            <br>
            Fixes: c22b04407097 (&quot;drm/amdkfd: flag added to handle
            errors from svm validate and map&quot;)
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
            @@ -818,7 +818,7 @@ svm_range_is_same_attrs(struct
            kfd_process *p, struct svm_range *prange,
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
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm range
            pages\n&quot;, r);
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
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to get svm range pages\n&quot;,
            r);
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
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_dma_map(prange, ctx-&gt;bitmap,
            offset, npages,
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
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to dma map range\n&quot;,
            r);
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
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset,
            npages, readonly,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait, flush_tlb);
            <br>
            &nbsp; -unlock_out:
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = !r;
            <br>
          </blockquote>
          <br>
          I'm still concerned that this can update
          prange-&gt;mapped_to_gpu to &quot;true&quot; before the entire range has
          been successfully mapped. This could cause race conditions if
          someone looks at this variable while a validate_and_map is in
          progress. This would avoid such race conditions:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; next == end)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
          <br>
          <br>
        </blockquote>
        thanks, will also add else path for error handling, to exit the
        loop with correct flag.
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (r)
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = false;
        <br>
        <br>
      </blockquote>
      I thought about that. I think the flag should be false going into
      the function. There should be no need to validate and map the
      range if it's already mapped and valid. So if anything, we should
      set the flag to false in the beginning.
      <br>
    </blockquote>
    <p>I was overthinking, you are right, if set_attr update multiple
      pranges failed, set_attr retry will not process
      prange-&gt;mapped_to_gpu, evict and restore worker will handle it
      correctly with xnack off, and restore page will update mapping
      with xnack on.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:b6fb1ca2-906c-08c5-9dd7-34e7f21af870@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">Regards,
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp =
            ktime_get_boottime();
            <br>
            &nbsp; @@ -2104,7 +2097,8 @@ svm_range_add(struct kfd_process *p,
            uint64_t start, uint64_t size,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = interval_tree_iter_next(node, start, last);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next_start = min(node-&gt;last, last) + 1;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr,
            attrs)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (svm_range_is_same_attrs(p, prange, nattr,
            attrs) &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* nothing to do */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (node-&gt;start &lt; start ||
            node-&gt;last &gt; last) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* node intersects the update range and its
            attributes
            <br>
            @@ -3517,7 +3511,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid, &amp;p-&gt;svms, start, start + size
            - 1, size);
            <br>
            @@ -3605,7 +3599,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
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
            @@ -3618,7 +3612,7 @@ svm_range_set_attr(struct kfd_process
            *p, struct mm_struct *mm,
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
            &nbsp; &nbsp; static inline void svm_range_lock(struct svm_range
            *prange)
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
