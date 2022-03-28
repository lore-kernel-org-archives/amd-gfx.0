Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA50C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351E710E537;
	Mon, 28 Mar 2022 13:06:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F4E10E443
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1FMVHfOWsNhKDMcf03MoQKIWMUM/bmzu2E/F5AaGgV/sP59Y3JOaY0TgsUZkySDgaxU+ji17esNlmG6j7/FlL/oTqqLXFFlZfn3x/vfqQux6EgSZU6CDMj1HX/qONqp57uvyMNvBDUNw5hCkgvhl8SOm4SMiXbfZnbPJxnCMGDjfTNCb6BTqcK/B6tpfle9lnQsRE3CaTrgPuyAmy/eJ0Q+I6KtAVQ0/waF41348VvNaTj7ExyRXT5Xb0o/BetAUhBQic2FHc+kF5SuBQHTamuGrzuJD0Xzf0t0fBtYS8oOYlm3HI5vF728FTii9NZpW8hkkouFVDzAbcHWqcjY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiMqe0lebqO+Vt/xwJAIZLDtc9/JKO416qZBNjweMMo=;
 b=mkNVRtflqQks1wyVgYHD1hZhHFSUpN0r54sP3fr3oPSo5kVkhMblK7yX3fbMHfg+Rctbc305IMoyNp28e4qEXoB0BOjfVvAJfrXvBONpCeSu2kFkKTDqSwdDupqEXOK/SsVYAoK0IvgVgGBdWjQt50BF+uXKHeh/HUPH+qUhFjs/G91PAatn/T1i+jifvVNrpBqF1sUppsk73Mr92jso+pVgHHugpNeDd3RUdU0SWaviXAzVWPhZ7qx4SEIIE9iofjQEmTJAmq8FGG/0hkn2vll7mUiVzLmAGMvqgbnx7Jj7KOQzHLarzlzr/O/LlBNsaZpe/dC6B1GAYPHTIxotEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiMqe0lebqO+Vt/xwJAIZLDtc9/JKO416qZBNjweMMo=;
 b=mzbFOiKBxYwj9uoRq7tUeiHBuGlMdhm1kLQ/76Tem5f5Qy4k1O+kr5jD0HeDEXqaSWP9KuCQGGb3+6QXze4I/ryYvCZHtyxC5p8utasl8PF9mjPHmH7wTnOibbKFV1V7GYsILf4txJkZEoEeIkDpcmFyLQwMrrfEViqhwbA2TNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 13:06:45 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:06:45 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Use last_unlocked fence for unlocked
 update
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220326005641.10284-1-Philip.Yang@amd.com>
 <20220326005641.10284-2-Philip.Yang@amd.com>
 <af7b9210-01e6-261e-b7c2-de29275f7a0b@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <72af9376-bae9-37de-758f-8504b402662f@amd.com>
Date: Mon, 28 Mar 2022 09:06:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <af7b9210-01e6-261e-b7c2-de29275f7a0b@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f12c9b2-51c0-4669-86c3-08da10bbcf09
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB31726837A8C28CBD58AB0244E61D9@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rwxRFwh+MM5gR1OS9GhL4hrM6EF3MAnKWRPJK7XHQ08y98HA3g7B4Ua1FvBBjEVu4Y24Mj83we4+gs96kth+GJOyCQy4BvTbJ2rIzz7oO8o6QoSlaYrgJ2QqME58OWYocA3+n7fTkJAISdtkZuPE16LK3IFsHIwBv4C8CCueSZpOGAFQGqzI/lpyGhtzopG7EMXMPv04us907juRVVd/686YECCMuDoBSQpkcWZ0daeyAz8K5Ttylcmy0qwLSbWX9Xwc9QChczAMh/52Pq282N48F+Tw7oOq48+9G1xXYe5/klaoyWrfDsIW+keuQlQc1dMhvAkRzNHrJfK63Khm0QMMEW/hyNkbDPogIAglXmBeTcz1QgAzInTWcphpm7lseqwG7Ke1a+AgsOvZW6AvFM3s8dCn1HD1qybZ7Xx5D3ZtLJtepVOoseaMYTOMT7AjOTcaTl9111VnuZUZVnJ+qZ0Bh5/8taRQDfiFcO68dB9sNRob0OecQC6nNLo/UDnMLzCJAQJnrKzvaDvR32Qfdl/lf9qbVxyxg3LU+WK+DUr/POTakrzq8larRQcbLvY3guRhcUdSj1ij0XOMf4b4FIAmxH8uecsHMMxP7ws/Me64NEGJ/v8Cw8EJIF4NkIVlsBKXYlWjmerbDvAj/DxCeIETadwPBmWEYYmFMp8YxSsdBuhsVW0qI8VKz62a/Cmf/4zfQLqLsKv2LhYM+PSTlNmxR5q/nJq/+PSRVxAZUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(6666004)(2616005)(186003)(31686004)(83380400001)(15650500001)(66574015)(6506007)(26005)(6512007)(2906002)(53546011)(66556008)(66476007)(38100700002)(508600001)(8676002)(6486002)(66946007)(110136005)(31696002)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ttS3BoSjkxZk82cWZGZ0doQ3U2eWI0Smh6SjUzMmpDWHBEWW54UkJBbWp3?=
 =?utf-8?B?enhTdEtNcDVUQUJZbElvMDJTVVpzWnp5dHBUYWIrTWlNWExFNHVhdGphSFNU?=
 =?utf-8?B?Q29mNXpmeHlLV2FpeThxaXBFSSs1R0k2Wm8xUG5oRTVuK01Qa2kwdVVjNzlX?=
 =?utf-8?B?Tk5FWlZJR1V6RUI1bkJYelN5WS8wL3VvMDF4dEltVDc2bmtiY0tQc1hENUJz?=
 =?utf-8?B?cFhpZmhvRnRwQjcxZzVYRXJqU3Ivd1FNaFZmY1QxQk81NDBJdTJMVnhFMHJl?=
 =?utf-8?B?Yk1pakJiVE1ENkNSTDdOYWJaL2NjY2FyL2NQOXRRN1pTVW9WdEREb09JMXFp?=
 =?utf-8?B?a2ZQNFVNdnhWZkUvVlpkeHIwOS9RektXenNQejFXNzI1azA4U25hNUxiaTZR?=
 =?utf-8?B?RzByVGVMUER0a3U1OVFlT2xSTGkvVFltQmxoeUMyS3JZYUpKUFQzNzVTbUFB?=
 =?utf-8?B?cUh1djdvTGRjdGpXK1pHR0t3dXVIOUtuZ0RueGdLTW9zQWFVTFJwRXZ2OXE2?=
 =?utf-8?B?YTN4aHJRMHRIeENzR0JwREljelZ1M2Y1eS9tNnpVdDcvQXBUanp1RFl5ZnFt?=
 =?utf-8?B?OWZxaWU2UEhIcnFHeUl6bzQ0SDg4WWpEMWUxRUNZdWNnZ09uY0crWDUyNE9X?=
 =?utf-8?B?aDgyeU9LVWFCMHhBUG9vTUU0NlhFZHV2ZnZsK1lnNDF6QlNFeWJMZDMwSFRQ?=
 =?utf-8?B?RnV2em1ncnJ4L2o4elNLcVFGZGFTaTZ0ejR0QW1GSTJnMUkwMWRZRENkWVZG?=
 =?utf-8?B?bk5oU1k2bUNVanp2K2FUMEltblB2TFJsN0VwWFQ5T1ZiZ0VNRHFzR2J6T1FF?=
 =?utf-8?B?cm5ocjlUY0RzRFg0UFRwZ256SG04Q3pSeXlpTFhtSERFdVJtZ01Wci9wTmVi?=
 =?utf-8?B?R1pnM2l4MGhwdDd1cVFtTjNVMEtkeXNLbS9xbm5NNjdGdktVMndQWmJNV2pH?=
 =?utf-8?B?YUtyQ0FlWGlzc0dSaExMTVdFdU5lTm5IMVl4T1ZFMFZwZ2l5dHhoaDRkYkc3?=
 =?utf-8?B?NldpUjhPNlF6bnJMcmxwWFc0N2VoSUhEZDJld2libEc0UWJRaFdLcUhRRVBK?=
 =?utf-8?B?YVY2d0U1UjExRU5SRFNUMThWUGVvM1E1S1I4WEhKdWdldFBhWWZ2L1YzSUtM?=
 =?utf-8?B?cjFGRE9aYUhrYVExM1dLVmtKMTJ0dHpkbjI2dmxRMm9rMlk4WEdaU3orSzZu?=
 =?utf-8?B?OHhCSERxTGFaeGlEdXQ1dytPWE9wYXU2Ynh4QjFKalUzQ2MyZW5lQVYvMHdH?=
 =?utf-8?B?RFZrV1N5bVFQTEJEckRqNDdzSURVRURzVlorRnc4SjNPVVhjZnN1Sk1TU1NJ?=
 =?utf-8?B?WGpSK3VEYTgzMnZDOU8vVTB0eUpkTXFXVzV1b0lBekVqNGlZcHFKWDNURVFK?=
 =?utf-8?B?ZU9GeWVjUUZKWWFIQTY3VHNMYWFHbzd3U0VaVDd0VDRCNm9VRzU4TTFsZ1c2?=
 =?utf-8?B?L1YyTkxVelBra2RGdzM4UmNNQ2tyNGpoWUtoODJ3dU1qTlFVbEZuZFZuQlA2?=
 =?utf-8?B?cXdibk5jWWpFVDdJa3R3WTd2TXJ1Z3k3L2treVNhdzRkNjZCeU1FRTFoMjY1?=
 =?utf-8?B?NlAzRGk0SXFZdXV4RTR6V2JlUm9KK2pYajQzaU1wdCtpV0NITVFwa1ZMZDhX?=
 =?utf-8?B?QndLRUhWaS9ZdXJuQzJmbjh1L080bkxPQXBVbk53TGhQTVdqV1lEdmQzNHVa?=
 =?utf-8?B?YVF5NTNDVkxnU29ReTF0T3JsK1IrdUN3Y0xtZHhwVlRSRDFGQ0wrczZaNlFD?=
 =?utf-8?B?L0VsdlVaaWdETjkvR3dsMDBWSjc3bytaOGJCUktVaW5kRW1Jdm9NNXB5RWFH?=
 =?utf-8?B?TENTa3lzUnBvYmFndXlWdElmY1IvYWllR1FVSTRZRnBpWDZJcnJhZTJzczlR?=
 =?utf-8?B?ek1BT2Z2d2NaRzl3ZG9XUkNxYW1jVTVZaEVXNUtham5CR3h4VS9CUGd0TlRw?=
 =?utf-8?B?bDVVdnhtOEMzUkN5VkVwR0owSXIxWXB6TW5kNDMxUVVGOU00UmdjWEJLM2I4?=
 =?utf-8?B?VW10d3dPWHI5d3RSdklENmFpWVE3TTVWSWF2VTBYeHpJazBjOVpsV2lTUnVH?=
 =?utf-8?B?eHpmbHErVmNrRUVJNS9tT1BuYm94NzVVWHgyeW1XWkVjUzFKR1Roa1NJbWFR?=
 =?utf-8?B?N1NLRnVSeUVQK1lYVVBvS1MzNEFaQm94UGlib2E3dHlIU2xZYWtRYjE1a1k2?=
 =?utf-8?B?bWpKNE9zWml4K0JBS1MwRmRNYkJnc013NzVOWUh2eW9iTnhlY1JRZFBNQmt4?=
 =?utf-8?B?dkRQRGcxdjJzb0Z6ZFEzdzQrZ2RXLzBJdy8vOUdUYVRQeU53YkRBZHZucCtK?=
 =?utf-8?B?Z1c3RHhqK3dOdmxoeVNmeThoWGUwdXZBNEVvOTJTNEY3eE9YOWpldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f12c9b2-51c0-4669-86c3-08da10bbcf09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:06:44.9938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu27lcpdH/3GquMRlyjAI8qBFHkqc0H/tn79gUWlhhODapiOf7CqexUxZDrGrx2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
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
    <div class="moz-cite-prefix">On 2022-03-28 5:21 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:af7b9210-01e6-261e-b7c2-de29275f7a0b@amd.com">Am
      26.03.22 um 01:56 schrieb Philip Yang:
      <br>
      <blockquote type="cite">MMU callback update page table set
        unlocked flag, add callback tlb_cb to
        <br>
        vm-&gt;last_unlocked fence, and pass it back to upper layer to
        wait for
        <br>
        page table update done.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
        <br>
        &nbsp; 1 file changed, 4 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index 48f326609976..aac1b625194f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -927,7 +927,10 @@ int amdgpu_vm_bo_update_mapping(struct
        amdgpu_device *adev,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = vm-&gt;update_funcs-&gt;commit(&amp;params, fence);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!unlocked &amp;&amp; (!(flags &amp; AMDGPU_PTE_VALID)
        || params.table_freed)) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (!(flags &amp; AMDGPU_PTE_VALID) || params.table_freed)
        {
        <br>
      </blockquote>
      <br>
      Dropping the check for the unlocked flag here seems to be ok.
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlocked &amp;&amp; fence)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence = dma_fence_get(vm-&gt;last_unlocked);
        <br>
        +
        <br>
      </blockquote>
      <br>
      But that doesn't seems to make sense, fence should already contain
      the necessary fence object if any.
      <br>
    </blockquote>
    <p>You are right, seems there is another bug, will send out v2 patch
      to fix the bug and remove this.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:af7b9210-01e6-261e-b7c2-de29275f7a0b@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fence || !*fence ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
