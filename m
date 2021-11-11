Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB458C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677B36134F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 21:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 677B36134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D8F6E0EF;
	Thu, 11 Nov 2021 21:55:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B236E0EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 21:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0Yh85N9yYK2Bqc5dRE6nqo1Bz2ZWysgPg+omI5CP0bwhj6+AMyOUBl8iMp2QhGyeGI63oEwVKU31VGelcdEa7CVAMSz0r9FOgO7lu6gJxPt+7Yd6C5+p3iws4Erg5SEZsf7p9cZcGH7vj8MhyPk6xkAO04wDLdOL7q0+EMzgnZvOvTc+8pbDee2JTruJwl4N29jhFtdrNH0vWGjkGSdLC9yPBTDEAqpE4at2h675xSf2tSmfyDtaaQzvLrIx3JOpERi04dDfHm25NZTGr8NIjtB2E19avkp12ozir11cw1vQ0a4MY/1BDA/s9LjeM4tg/2LeitEzdzZ75XsXjrnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrK83Y6lvkTZJEuValkbPqo+XRcFepTc09uzVCEfk8Y=;
 b=B0UVIOhF1uSRywJRnI+d1ssbf8g/FhcA60NY2F9mkUKxdHNIAkwHcDgtj7++/U76WTalyBdUIzxf7yl09r8Bpw+9pVOblwu96ikAjLds6Vr2W5GNrik2u5L0mjgiFWmxTyfSLoJL6VJKhti4BRrQ0LaNVIlUvGnaQG0Ji63Uj7Ba1HWjj34SPGSSwsnIQRL2nerX1oHki6rSX+C7Vd8mMQazRAKH/o5Xt+dtplkOxbpqZAJkzRd/Gyg+w/9xh1Bb6voQHGL1adOAB62D0ki/mVLc+nCXc2I6Qja8SqaunR6hg8aq+z9ARA91ufD0xKrYuXLqEnVeeh+Pjn9GEXNyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrK83Y6lvkTZJEuValkbPqo+XRcFepTc09uzVCEfk8Y=;
 b=Y4Ekr0lWTw4Q1/ilvJps0KPv2EJg48poxYdHXKeBXB4Vv24GrAbYRbQt5uA0TFYGbdGsdpmej4feXuSWgBV5M3NJtIT9RrHRYJ6MC0XQAbr1/1c2oaewaBaYzvNMRQEUOHWe896smeRinC37sG0RZne9LLx8KUWLRm6yt0NGqd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 11 Nov
 2021 21:55:26 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 11 Nov 2021
 21:55:26 +0000
Subject: Re: [PATCH 2/5] drm/amdkfd: check child range to drain retry fault
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-2-Philip.Yang@amd.com>
 <d4bc4acf-ff14-5370-16bd-8cec6253c09c@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <bf24561b-eef3-36b1-6f8f-08f27b4872b9@amd.com>
Date: Thu, 11 Nov 2021 16:55:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d4bc4acf-ff14-5370-16bd-8cec6253c09c@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 21:55:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b97f529-eb48-4f7b-ce1d-08d9a55df7fd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5374BA693E37C0E836052E4FE6949@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apy0YZniYZOChDZcYZWxIPnr6yarc5JDV2QvEAYjSstcY7I7xQTeLLSARKF0yBH6qlAmdTeKrGP4nBZI6XXTsBK0ZvjnsysNXGfNEhWroAjNPvbkiNI9SIzdimyz+5njpglC0s4bEs/R0a/j6DanJp8KAvEgoJ00tbTgKv74/RCfGeCo/qpndXNBGSeAJc1XljCiwFU7MlACvRE4jAZFQ9hxPN+9+9chm2/XS0dNwxfeqrzmDZ5UMFrU/EoZnHxAmOLaviwacJBR+CJALbCxV2P6KKxlLQ//xcLtb+vov8RuHe3V1igC3YR0Il2tnYU22Ww5/OZfGNrSKpnNRqh89Qx3gAJ0Uu0A6QVW2loM+wnbTzNFUNteLIW4Tufwq55V8WO1JGQBk+HH0nC51eAbDLlnx+KCe/UuV4GtGQ5PKvEcwJu8VQXtXQRK3+/UJAl3hJ+yfQcPdfvQrApFO4fV8U2ul2mBUeypUFiyM2hARF6dG0VxYsJJOosgxOeii75RG7ev2sMuR0kFocxVmEeI4OlbRBADGY07T7NI4McdIUAC6wPuZQTwcY64bnQ/6kGhk4nBuqusKxbYZ8crX+xwUiSIKWMqCOydCdqXWWmAk0A2SRrqIWunzeANCBfK/rt/JHiMJCjJgi5LLjXvpWiGDsOXZsAGOe6Sg5kxzJroZA8z8+HwvszICNhKDk05iWb7s121gugvhFHg+y2nl5HvltBEBh1YYlhuUp2dShU0dCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2616005)(66476007)(110136005)(186003)(66946007)(508600001)(53546011)(36756003)(66556008)(2906002)(31696002)(6486002)(5660300002)(83380400001)(8676002)(26005)(8936002)(316002)(16576012)(31686004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhNSWF6bjVXUXd5VzczQTd3L2VOc3V0TlJvNmFxSnNSQzArSEFPRnc3SlpX?=
 =?utf-8?B?QWcrNWp2UUY0V2o4TktOWldEZWx3T3Z5WEtSWnM2cHBNNzBIRFhhTnQ3NzlM?=
 =?utf-8?B?R2pwc2xCQW90dUNSZTl1R0JTVGR4aUZ5UHJvdWVna2NWMkxSZnpkbGR2emJU?=
 =?utf-8?B?MW5TUFNOQnV2bFJMZVZzQUhlR2tFdEREeG12eEJqUFZqVE9JS1VsODBMQWZa?=
 =?utf-8?B?b1VWU3lvNGs0WDhlZ0tNeUJBcHRvR0szM09NSmU0R2xsQXJkMVpIYnJZeTNW?=
 =?utf-8?B?VngwRURvTUR4TEJtRVBBTTFuVGVucHlFRG1wMWxmcW9FTTA5SjRPWmRjbFRR?=
 =?utf-8?B?OHR6eXRZWjhDdTJvZUVSSWdNSWQxN2FKTENRSnBkYnl1MHBtNTFuRGRiNW0z?=
 =?utf-8?B?WVoxay96VzF4ZnRxYjhnbkV2VEMvMlUyWGw1WWlNSGJwbWxtb3EybTBjSFZn?=
 =?utf-8?B?L3ZZa29nc1JlWG9HbGlCaGhReitVR0FacmUyc3JCQ0Foc3pmT0RyaVBsaE1y?=
 =?utf-8?B?ZXYxRXEwa05qQTl0N3A2VG9SUkRrdkxUL3pRQXVxSkg5STRrbWhmK1U4ci9t?=
 =?utf-8?B?d0duS3IyYzRiNnY1QmlKbDc5ZzJ0c0dUNElPUlVCbjF2Qm9iSHREY20rQnlv?=
 =?utf-8?B?RDRFNHBlbUpCVm9UeXVJL3J6T1FlSVJwTjFEampQYytyblBsWitvK1R2aExN?=
 =?utf-8?B?VnBZd05TajUrazFBazJEak93cFF1dGMybjR0RndvSDJyWW1IV0NNY0xxT0Q1?=
 =?utf-8?B?dU9VRmNQU25zL0RiZ2JRVENEVytadmJHNnNQRjIrYVB3Mit4Wkp1Y014dSts?=
 =?utf-8?B?UWI4K3M2Vmp3ZUdVZ1haRmVxTmtzcDJhTExCcUxZM0lIK3haUEI4bW9zNzBE?=
 =?utf-8?B?SEFCd1hwSkZNUm1DSUdGRkNVc3JYRFpKRG40bFpjYU1Ta2RDOExvZGtzMHo4?=
 =?utf-8?B?MUlQVFdwTnYvY1QvbUlBL21xOWQvVnN6UVhIeXdPSkY1SE0zb2k4cVpPTlFs?=
 =?utf-8?B?Sy9jNEdzMUVPNEFjUXN6OERpUzNDb1d3ZUk3c3QzVCt2ZUh3N3NjbllKU0Zu?=
 =?utf-8?B?VElXVzBaUHJhMmFGQTZaRTY3L0FmMmx2eGZmN1hIaGdEYjY1QU9ZWTRuZnNI?=
 =?utf-8?B?SkQvVFlzMUY2Y1lWdjZHMlRFQytYY2JtMmgxbWhSbThJbjFEaEZiMldMRklr?=
 =?utf-8?B?VXRrSXBmS25NZTVEMU5uY3lWd2M3WUZ0SlNabWhOdE85VjZWRSt5QXdTenZk?=
 =?utf-8?B?bkdsd0JHSklORUFVR2hwQXRpL29mLzRCMlMxRmlBNHV5MDFBTWtSS2EzUDla?=
 =?utf-8?B?R0Q2dzJ1aHNERUtaTlhHc09RMGlDd1E4bTIvUXBYcWlkejdHSU1LdXNQVEVw?=
 =?utf-8?B?V3ZpM2pQYXZNaUY3MHI0R0NybDF4Mko2aUZsRWZPQVlja0pVVnZUcGxzL2RW?=
 =?utf-8?B?UzRnV3EzaVhsUzlEOCt0Q1ZCbEgyYWxIMjJPU0lDUjJpeUNpVGVRbElWSlF2?=
 =?utf-8?B?TUE4Rithb0tPSXpaNktQMG9QbHIzSDcwZjB0M25BM0FmTms4aTROejdwWVVl?=
 =?utf-8?B?TEtjTjRLQjRZYVJla0NLYzREV3UxQjR3UUlBTWtwYVR4RUhST0ZRS2tKVmJQ?=
 =?utf-8?B?VnhMTjArNCtycWFoNkJLTkttaEtiU1ZvQTF4UXhKS1dNMVlESzJaNXB5UzA4?=
 =?utf-8?B?dWQ5RmxnSWtiZ25ncmVqaTZMVEkzMis1d3FaWmk4bHE2TmNDMGVaUjF3c2M0?=
 =?utf-8?B?TkM4UEwrd1FacWdWbUdka3ZEQTZiSXY1ZEVWU2dkeXRyay9nTjhDN3p1S2d6?=
 =?utf-8?B?VHhnZWVOUFBJYzVIeUtJNThPRXNHRXhSVjAyZndlYTdSMGd5Y3pJaHBvVjla?=
 =?utf-8?B?Y091Mmp5THl0Y3J3cTZmcExoSER1K2ZKQmpEUWdZSnVyMW9vaVZWQmNYcU5h?=
 =?utf-8?B?cm5CTGxGZm5zVUczeTZOeDgxcjVxS1h0VzF3WVpGQmZKS1BjNFBEdDg4M0l3?=
 =?utf-8?B?Q0lGcmdZalFoeS84WHlTMTRNaDdjbUROc2ZjK1JoczdzRCtQeXpoWmpUY1Vn?=
 =?utf-8?B?aFdrajhhWWZtQ1J4TkwxN0VXRi9tM29aZlFXL0hvd0FLZkwxVWI5U1lRU1ly?=
 =?utf-8?Q?+keA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b97f529-eb48-4f7b-ce1d-08d9a55df7fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 21:55:26.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xllWH0GYhgPpQhaTAoBZjyKTOnSJCAmCC00JkcQAnqSQHoih4Mc3I/983LikuXjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
    <div class="moz-cite-prefix">On 2021-11-09 10:26 p.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d4bc4acf-ff14-5370-16bd-8cec6253c09c@amd.com">
      <br>
      On 2021-11-09 6:04 p.m., Philip Yang wrote:
      <br>
      <blockquote type="cite">If unmapping partial range, the parent
        prange list op is update
        <br>
        notifier, child range list op is unmap range, need check child
        range to
        <br>
        set drain retry fault flag.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
      </blockquote>
      <br>
      I think this could be simplified by simply setting
      svms-&gt;drain_pagefaults in svm_range_unmap_from_cpu. The mmap
      lock ensures that this is serialized with the deferred list worker
      reading and clearing svms-&gt;drain_pagefaults. You can also use
      READ_ONCE and WRITE_ONCE to be safe.
      <br>
    </blockquote>
    <p>Good idea, change will be in v2 patch.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:d4bc4acf-ff14-5370-16bd-8cec6253c09c@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++++++++++-
        <br>
        &nbsp; 1 file changed, 12 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 77239b06b236..64f642935600 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2049,8 +2049,19 @@ svm_range_add_list_work(struct
        svm_range_list *svms, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the range is freed to avoid straggler interrupts
        on
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * unmapped memory causing &quot;phantom faults&quot;.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; if (op == SVM_OP_UNMAP_RANGE)
        <br>
        +&nbsp;&nbsp;&nbsp; if (op == SVM_OP_UNMAP_RANGE) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;set range drain_pagefaults true\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;drain_pagefaults = true;
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *pchild;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(pchild, &amp;prange-&gt;child_list,
        child_list)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pchild-&gt;work_item.op == SVM_OP_UNMAP_RANGE)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;set child drain_pagefaults true\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;drain_pagefaults = true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if prange is on the deferred list */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;prange-&gt;deferred_list)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;update exist prange 0x%p work op %d\n&quot;,
        prange, op);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
