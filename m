Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF395C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 16:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550EB10E92D;
	Fri, 26 Jan 2024 16:02:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A4F10E92D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 16:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALiY2RcPOh7mfk9TsqAyk+eZqKLbpH9m8X3k3BI5oibaiPU+oEhipSjNyCda7R4uteBUVfBb7awejy/Y3VFX1buepF7ZzjFOg4jnAXUN99YD5X348fk1XFzrpXP9alzRper18WIyFO8LErPiaVEbVOkuUMAcK96Xehj2L31NyFZ93CtcKQ5dFfCOFrdDACnIOCagHbDWoWyMhbe/FvPh8/67I2q1eEFS7x1XltDQAwwpS7l18MqeKLvSnj6+OgbfCbbIGuA75KYITjVX7fBdR5hi1BZ7E4YhVe7yKY6wEBjVc7+hwuYIS5X7mz/t5CCSUoIGJJrvElFOroxRS9r1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmwOAob8HRDJ3ISKtkvcSQc7ME4LZx071Pgv6h+DG7A=;
 b=Ij3CIEpO9B83iRnEdshe7tqr2BILj8sCgLQ99Hgc/tstTatjUOFWQhiNanzoHejmGzBpEqIkwSGYn4RTs/VtQ6nKgfcv+On3GZQeUmjubNsfsKnqMs65d8DpEZYzrhPzZRzN9MfwXOWdzFhvR++cS6AQq0mWZ7lZEkhiAAeDgCqCNyE8Je+AnAnS1EVJ8f+Krc1T/d+uR9hS7qrTkDiA/URI+dv+ZuWJ0p4dPyCAAGwN/s9FE0Pwyr9Ev+lks2ewFiNdyn5spZm5Um3Mdvfxowor+v6BsxizcYoOe6zpipDMrB393UkYH0N9Qwp+U4fwaD7AdTrJ+vZ79ARAaY0t2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmwOAob8HRDJ3ISKtkvcSQc7ME4LZx071Pgv6h+DG7A=;
 b=QuB3Q+sGK+qctG3lXfGW4WfdRVqxXjKfC3d4SnTEjvvzRxPoND0M6dVqYoZEY5M+opETA5aYO1kIXvH0KWUlH3mBX9FZ1gWBJIv/Y1tQU27IE2J23Xw1d8o1dgqMIfeL3OAPygvDL9PtQxTmycxWXjWh0sJoqYAdjoYCx6hjuoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 16:02:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7228.028; Fri, 26 Jan 2024
 16:02:05 +0000
Message-ID: <8f7fdf40-92e8-6fdb-4e9b-5ce5d51b5989@amd.com>
Date: Fri, 26 Jan 2024 11:02:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Limit the maximum fragment to granularity size
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240126143830.30586-1-Philip.Yang@amd.com>
 <9c59557b-f6e3-45a9-bd4d-bddea9339e92@amd.com>
 <170486a5-ec4b-08cd-a993-3efc569de0c9@amd.com>
 <5ad7382e-5b3f-49b1-9aba-59a316feb7ab@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <5ad7382e-5b3f-49b1-9aba-59a316feb7ab@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: bad60d5a-f2b1-4e04-2a72-08dc1e882459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rx6TRpXKMaWTRAcfxIIlOJAJI4A8n8ysvf/hHT+iIhf2EKaROTZVkhOYyteffUnRdODxVu26IQNlSqutZsBISEcaGo85KmCmjTGogvFCWe6cj5Dg6wO5bTduNRjn/FWxwb4OMXFd+1+VDWbTHB6WdX9uXJkUiMS3/OE6U6/zTYyxeUHilijAWb8FbPANgEh9XJVoSU9Yiy5GBVCu8LDN3d4gj+C690t3NvzZvDYtNTrweMx+F4POm7ZHvO5lHO9FYXWzo2noXf3Yq5hkuGy5PbypYYm33o03EdqnRSTPwUOPQwV3+f1rDwKPQy0Rmp/Oq/mAuzHgW747YYNWT7OnlkVZtJIKhj+oESR16JvFMstYPocvascnN5jBPYEjVGcHLADpiA02HkAOQ2bRcKQIQ7s6tXOy/gMkVP5NcIigxDst8vkSdLXmPN6urB11mN+M+MQfrx5xuNkO5yTYSAq34fFO34h34dymZDID/LBirvcv323x8/vv3ovJO700hLRbpX5UJNcwnRpFvxLTYRoYG58V47yIJMAztghAxIav3yF06t7pgfTV1KQV8brSdn5Y1M+EV4sqQ6WN1EZ1092/HdsCSKtXV5SnSVxJIP3sWuPfBNgYCrSVoImJYxhqjIty83hwF+rhuRIrwtAqbpC/AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(6512007)(6506007)(53546011)(83380400001)(66574015)(66556008)(26005)(41300700001)(316002)(4326008)(5660300002)(8936002)(36756003)(2906002)(66946007)(110136005)(8676002)(66476007)(31696002)(478600001)(6486002)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2UyZ3FoSlpvd09hSERDSGdlQmFGblFINEVkWEg3cG1DejU4dWdoc0VlUzdI?=
 =?utf-8?B?YW0rVTV6ZmM4NldUYXJjQ2RWUmczK1RyWFJwdEJpamwrWnN3UGxRMXdUY1lS?=
 =?utf-8?B?bmwranZucHVSSndpZ3VSV21BL2FkRHd6Znd1YU5QUTBGVE9ReWp1NXZnZVBp?=
 =?utf-8?B?YnpiNWFxQ1h1dEVaMnlLMVhlMmZkN1hsaGs5NUlJSnpsMC9IL00rZko5Zzlr?=
 =?utf-8?B?aUdQbXlNbkpyZzFKajUveUR6WURQdlhhdUpQai9QZUR2UEdzSnN1dERLMW5K?=
 =?utf-8?B?NnA4aDBXQVQ5TjBVV2NvSGoyb3diOEU0UFFHa1FRUVFMaW9sL3hMVThDRU1r?=
 =?utf-8?B?SWpveGplbGltYnNKa0VLdkRzeXZvV1hLWkpRVlEyVU0xOHl4NkwrdmsvN1ZM?=
 =?utf-8?B?UWZWSlFJVmVHWnR0SlQ0RmkyWGYyNENtOGRMa2xQckt0V1ZGYUpvUEFweHYv?=
 =?utf-8?B?TU4vMWxHeHFMeWhFZ1VLQWgxOUFnSmpCR0x3QmhTVmc1TTk3cU5IRFpPcm5T?=
 =?utf-8?B?bDhTRWFQd0IrZVpoMDV0VGFaaXVNL0VMTFd3QXFuMEJidHVlTi9sQ21YYld5?=
 =?utf-8?B?T2JUMkhiQmtiUFgvQy9RRXBWQnpZZXp0ZnhkR0RCU09pd0VQUm50b0FQL2Zm?=
 =?utf-8?B?b2ppRkJmcXZyWVRuQ0VUQ2E5MDN6L3Z3Y2RNVTNFMm1jNFJzM21pTWFyQ0xN?=
 =?utf-8?B?ZXhwYXkyYUovYitRczNTZlBuWUJKdEFNcGtqTTJuOXNVb2RjUVA0N2lTcG5n?=
 =?utf-8?B?M0ZrQnBTTXNCdkpMdzBwbnhtbE1BOG42UU9uaFB1NzdrTW94ZmZ6S1ZLcWhI?=
 =?utf-8?B?ZzVVYTloQk90QjdsRDNPTVdQSW5NQnpscm5qOElpdFpENmlyQXVYQXJaM05U?=
 =?utf-8?B?Qi9pOWxFRUE5M2xIT1U2MlNwU21lazdMNHdYNWx0TGZ2VkZiNzJZQ3BNZkw4?=
 =?utf-8?B?dkYrNXlybU4vVlg2cVhtUjI3NVhsd3BMQ2lGd1Mxck9pT2FaZzhWbkUzMXZv?=
 =?utf-8?B?M1R0S1NyWHp1MHBoSlROQWdoQm9QVDFNYUxzNys0MzFmbVlJbFVOKzI2QllU?=
 =?utf-8?B?blhBcUljcXkyRXUwaW5QUmoxcmNZU0p6ZjlTRXdSY0IxdWJ4Z3dOaVdEZnUw?=
 =?utf-8?B?ZUtmWWlyQjlrbTJDZ0lhTlFyTlFzaGE0NnNHNlZySFVNU2t6ZEp6QUpVUXY2?=
 =?utf-8?B?Z0dKUDFqOUljamlPRWNIenNNNTdiL0oyNjU0c2NSZlIwUEtiVjFKWHo2cHZX?=
 =?utf-8?B?WW0ybzdXeGEzRUVrT2VKQWgyMllBb1h2TXY5UzcydTFMZEtUajZhb0VRS3FH?=
 =?utf-8?B?ZFBleC8zUFdCWkZkNFQweGZlNkwxN1ZnY2ZpZEhXN0J6QXJFN2p1cjBnOEpH?=
 =?utf-8?B?S0dyMUwvOFFBRnRuR2JBQ2JmWWV4UjQ4Um1WWkdwU3Q2UFExUzk0c1BnQTVq?=
 =?utf-8?B?ZnllbUl5eFdZaXcvOEU1eXQ4K1lqSnNxc3ltMlJldWJlMGVyU05xbFplcXpI?=
 =?utf-8?B?SzdNNW8wb0ZxaDJ1SDlzaDBiZnROTXRLSm1QbnJKRGcxVnpsWFk1MS9CL1ZG?=
 =?utf-8?B?b2RFeitkTFZYcjQ2UHdHYXdHUDQ2eXZjV1ZUYUlkZW93ckExbG1yV0R6UXBP?=
 =?utf-8?B?U3FwSHEzZDJYOFFmMXJGTGZsN3FFUXhSUzZLK3d5bjlSa0E3WCsxNzFudlBB?=
 =?utf-8?B?ZjAzOCtrZkhUVzNUbkIxa1VzYW1HQ2s1b0lqck11NVIxTHkrVmUwb2tIeDA3?=
 =?utf-8?B?SjhHQXFUZTdkbWZSYnBvZFdXKzQvQ0d2TnVrMzlxckZCUVFKMElmUENwQlZM?=
 =?utf-8?B?WTl6Y3VxZksxSU5pY0VsdXZMOVBoK24rK3pIRXpXMjhXdEd6K2o5eFZyYmNm?=
 =?utf-8?B?YVY3Smx0em1VTklZYkcvRm95bUxaU0YwdXdMMmt1TXJXNWdIbmJQZEJKRnBo?=
 =?utf-8?B?cFlkdXM4MkxiaDhyNXA1enhvaHN2eFM0Ri9KWXc2bmppRXpzeXZBMjBBOS8w?=
 =?utf-8?B?cTJVOS9XVkdURHB2SVNkL2xCY29lSTRXOVh4TzlPZzRVM21ySWlwRThaSEV4?=
 =?utf-8?B?eklabHRQQWRHb1JJUXVRb1E5ZEJzQkFwUzM3VHJWRXVNNVlXak5QblMwdnBn?=
 =?utf-8?Q?kaHT9yBw3yanKaiUh6SgpvQeK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad60d5a-f2b1-4e04-2a72-08dc1e882459
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:02:05.5543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta/7d1zmqdJ/RZ3wY1ci/9T0BQXXEDSkOdxw/Q+Vcn7mdlS0bmOjWNKnsD8B00T2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-26 10:35, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5ad7382e-5b3f-49b1-9aba-59a316feb7ab@amd.com">Am
      26.01.24 um 16:17 schrieb Philip Yang:
      <br>
      <blockquote type="cite">On 2024-01-26 09:59, Christian König
        wrote:
        <br>
        <blockquote type="cite">Am 26.01.24 um 15:38 schrieb Philip
          Yang:
          <br>
          <blockquote type="cite">svm range support partial migration
            and mapping update, for size 4MB
            <br>
            virtual address 4MB alignment and physical address
            continuous range, if
            <br>
            mapping to GPU with fs=10, after updating mapping of the
            first 2MB,
            <br>
            if the second 2MB mapping fs=10 in cache TLB, this causes
            the first 2MB
            <br>
            access to the stale mapping.
            <br>
          </blockquote>
          <br>
          Well that sounds fishy. When that happens with (for example)
          4MiB and 2MiB, why doesn't it happen with 8KiB and 4KiB as
          well?
          <br>
        </blockquote>
        <br>
        unmap svm range is aligned to granularity size, if the range
        size is 8KB (all within one 2MB granularity range), it will be
        mapped/unmapped as 8KB, even if only 4KB is migrated. This is
        handled in another patch series &quot;amd/amdkfd: Unmap range from
        GPU based on granularity&quot;.
        <br>
        <br>
      </blockquote>
      <br>
      Ok that makes a bit more sense.
      <br>
      <br>
      But when you have a linear 4MiB mapping and unmap the first 2MiB
      of it you need to flush the TLB anyway.
      <br>
      <br>
      So why would that cause a stale access?
      <br>
    </blockquote>
    <p>yes, unmap does flush the TLB, the issue happens if GPU access
      the second 2MB to load fs=10 entry to TLB, and then access the
      first 2MB.</p>
    <p>Originally I thought this could be fixed by using granularity
      aligned address, size to map/unmap to GPU, after debugging,
      realize we still need limit the max fragment size. We could change
      this in svm map function, but it is more efficient to pass the max
      fragment size to GPU page table update level.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5ad7382e-5b3f-49b1-9aba-59a316feb7ab@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Limit the maximum fragment size to granularity size, 2MB by
            default,
            <br>
            with the mapping and unmapping based on gramularity size, to
            solve this
            <br>
            issue.
            <br>
            <br>
            The change is only for SVM map/unmap range, no change for
            gfx and legacy
            <br>
            API path.
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; | 12
            +++++++-----
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 ++--
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22
            ++++++++++++----------
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++----
            <br>
            &nbsp; 4 files changed, 26 insertions(+), 21 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index ed4a8c5d26d7..a2bef94cb959 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -897,6 +897,7 @@ static void amdgpu_vm_tlb_seq_cb(struct
            dma_fence *fence,
            <br>
            &nbsp;&nbsp; * @res: ttm_resource to map
            <br>
            &nbsp;&nbsp; * @pages_addr: DMA addresses to use for mapping
            <br>
            &nbsp;&nbsp; * @fence: optional resulting fence
            <br>
            + * @frag_size: max map fragment size
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Fill in the page table entries between @start and
            @last.
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -908,7 +909,7 @@ int amdgpu_vm_update_range(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int
            frag_size)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params params;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_struct *tlb_cb;
            <br>
            @@ -1016,7 +1017,7 @@ int amdgpu_vm_update_range(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = start + num_entries;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_ptes_update(&amp;params, start, tmp,
            addr, flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_ptes_update(&amp;params, start, tmp,
            addr, flags, frag_size);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;
            <br>
            &nbsp; @@ -1197,7 +1198,7 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !uncached, resv, mapping-&gt;start,
            mapping-&gt;last,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_flags, mapping-&gt;offset,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base, mem, pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            @@ -1392,7 +1393,7 @@ int amdgpu_vm_clear_freed(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            true, false,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            mapping-&gt;last,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value, 0, 0, NULL, NULL,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);
            <br>
            @@ -2733,7 +2734,8 @@ bool amdgpu_vm_handle_fault(struct
            amdgpu_device *adev, u32 pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, true, false,
            false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, addr, addr, flags, value, 0, NULL,
            NULL, NULL);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, addr, addr, flags, value, 0, NULL,
            NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, 0);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index 666698a57192..b34466b5086f 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -465,7 +465,7 @@ int amdgpu_vm_update_range(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int
            frag_size);
            <br>
            &nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear);
            <br>
            @@ -531,7 +531,7 @@ int amdgpu_vm_pde_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry);
            <br>
            &nbsp; int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags, unsigned int
            frag_size);
            <br>
            &nbsp; void amdgpu_vm_pt_free_work(struct work_struct *work);
            <br>
            &nbsp; &nbsp; #if defined(CONFIG_DEBUG_FS)
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            index a160265ddc07..4647f700f1c6 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            @@ -860,12 +860,14 @@ static void
            amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp; * @flags: hw mapping flags
            <br>
            &nbsp;&nbsp; * @frag: resulting fragment size
            <br>
            &nbsp;&nbsp; * @frag_end: end of this fragment
            <br>
            + * @frag_size: max map fragment size
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Returns the first possible fragment for the start and
            end address.
            <br>
            &nbsp;&nbsp; */
            <br>
            &nbsp; static void amdgpu_vm_pte_fragment(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end, uint64_t
            flags,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *frag, uint64_t *frag_end)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *frag, uint64_t *frag_end,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int frag_size)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The MC L1 TLB supports variable sized pages, based
            on a fragment
            <br>
            @@ -893,7 +895,7 @@ static void
            amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (params-&gt;adev-&gt;asic_type &lt; CHIP_VEGA10)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag =
            params-&gt;adev-&gt;vm_manager.fragment_size;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag = 31;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_frag = frag_size ? frag_size : 31;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* system pages are non continuously */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (params-&gt;pages_addr) {
            <br>
            @@ -904,12 +906,10 @@ static void
            amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This intentionally wraps around if no bit is set
            */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = min_t(unsigned int, ffs(start) - 1, fls64(end
            - start) - 1);
            <br>
            -&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag) {
            <br>
            +&nbsp;&nbsp;&nbsp; if (*frag &gt;= max_frag)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag = max_frag;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = end &amp; ~((1ULL &lt;&lt; max_frag) -
            1);
            <br>
            -&nbsp;&nbsp;&nbsp; } else {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *frag_end = start + (1 &lt;&lt; *frag);
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; *frag_end = start + (1 &lt;&lt; *frag);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -920,6 +920,7 @@ static void
            amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp; * @end: end of GPU address range
            <br>
            &nbsp;&nbsp; * @dst: destination address to map to, the next dst
            inside the function
            <br>
            &nbsp;&nbsp; * @flags: mapping flags
            <br>
            + * @frag_size: max map fragment size
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Update the page tables in the range @start - @end.
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -928,7 +929,7 @@ static void
            amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp; */
            <br>
            &nbsp; int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params
            *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags, unsigned int
            frag_size)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = params-&gt;adev;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor;
            <br>
            @@ -938,7 +939,7 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the initial fragment */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start, end, flags,
            &amp;frag,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;frag_end);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;frag_end, frag_size);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* walk over the address space and update the PTs */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_start(adev, params-&gt;vm, start,
            &amp;cursor);
            <br>
            @@ -1040,7 +1041,8 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag_start &gt;= frag_end) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next fragment */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params, frag_start,
            end,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag,
            &amp;frag_end);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, &amp;frag,
            &amp;frag_end,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frag_size);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index ed35a490fd9e..d71b2c8bf51a 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -1488,7 +1488,7 @@ svm_range_get_pte_flags(struct
            kfd_node *node,
            <br>
            &nbsp; static int
            <br>
            &nbsp; svm_range_unmap_from_gpu(struct amdgpu_device *adev,
            struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, unsigned int
            frag_size)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t init_pte_value = 0;
            <br>
            &nbsp; @@ -1496,7 +1496,7 @@ svm_range_unmap_from_gpu(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev, vm, false, true,
            true, false, NULL, start,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last, init_pte_value, 0, 0, NULL,
            NULL,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence, frag_size);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -1579,7 +1579,7 @@ svm_range_unmap_from_gpus(struct
            svm_range *prange, unsigned long start,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            svm_range_unmap_from_gpu(pdd-&gt;dev-&gt;adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_priv_to_vm(pdd-&gt;drm_priv),
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, &amp;fence);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, &amp;fence,
            prange-&gt;granularity);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
            <br>
            &nbsp; @@ -1647,7 +1647,8 @@ svm_range_map_to_gpu(struct
            kfd_process_device *pdd, struct svm_range *prange,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (last_start - prange-&gt;start)
            &lt;&lt; PAGE_SHIFT,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev ?
            bo_adev-&gt;vm_manager.vram_base_offset : 0,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            &amp;vm-&gt;last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            &amp;vm-&gt;last_update,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;granularity);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = last_start - prange-&gt;start; j &lt;=
            i; j++)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[j] |= last_domain;
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
