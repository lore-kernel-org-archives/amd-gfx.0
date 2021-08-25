Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CCCC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9516860F92
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 13:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9516860F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D106E216;
	Wed, 25 Aug 2021 13:35:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA67D6E216
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 13:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0HQ3UsDujJEHLEuqtXp0DqzirF5xbo1sjpX95urZXD7FO/ftKTesIWQfX/A2Q1Wlt8aekVx5/ZXh8PvzuGu0s5WMcDO+qAg1357u+qkF+M3CmS+fgTxtEWJji1Oir9HQHpBCiefEOWx5paK7cP9wH4r0CHkts1SU+78pRN8/SHd8pJp5nhV6mbXhVvSaclq0lNGh1MUIUZHGPWzUvjVpQff/SgjR5k/Yydsc9t6qRDvkqBmUC1aWhwZ4QxxVE+4qWVs/XUmhPWRlcScoTK38ysRLe5pQqmSdz2MtjDgxT3QkPYvBc8gWzEXuNIjz58HqkkZEne3MYV7j05Hrrx0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWL21oO5pJ/lo1ohOCS4EwBn015zz0yC80d7GRwplc4=;
 b=FxMgCgVRd/dLTymc/4lnu3VZmOI6HIvcxL/3jsk6hExdVTRz1ZptPlfC2cixM4viVcqKYMB/TChOix8XEsZXP6y3VixpyIwwaWAaUzeu+rWYzLzKBE98iz0eCFbs/kRi/Sx2V1h2VIURMUXXy8e22XceiQSAWs0gd6qURIjisuSFtYYzvhym2T3Jwy6ks3HjhPsLHMf3dkC2wRyO/vvuy/fvbz5oqFEDNy8pyPSICfb+5tcaPzg4RlJNY9u7oO31Kg01dLckOatkwnrG5Wk+rzDjySx/m3BPaJfsfqGExhDKfhnxlO/3GovhJ3V6CaZQWkcmCADDqQP2Ikr5Gk9lIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWL21oO5pJ/lo1ohOCS4EwBn015zz0yC80d7GRwplc4=;
 b=Uveiwqn0FrxgCqg9af1TnXSMaZrtoIyylO9kunu9Fzm/FbNSKvBKp8qiANE40qSYHWgU2gzoK5kCFFJRS7WU6aL5Sr6oYixGtilvG+V88ucoaqzlgrMKCf1Gsy3y3+3CRpB3T8CbWDQ+vip+NhSFxbIfxt4KxxBoBMftzZ6dx2Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 13:35:46 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4457.019; Wed, 25 Aug 2021
 13:35:46 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework context priority handling
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: satyajit.sahu@amd.com
References: <20210825112203.3806-1-nirmoy.das@amd.com>
 <bd435c95-4d7d-5b0e-b1c7-81ed4d883ff9@amd.com>
 <9f4562fe-2c83-a0fa-5564-618db6a33c7c@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <ca660b9e-e2c4-4c41-19c7-b68d05ffbe02@amd.com>
Date: Wed, 25 Aug 2021 15:35:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9f4562fe-2c83-a0fa-5564-618db6a33c7c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f24:3900:b5a0:c2c0:8e2e:b92d]
 (2003:c5:8f24:3900:b5a0:c2c0:8e2e:b92d) by
 FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.8 via Frontend Transport; Wed, 25 Aug 2021 13:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a3a620-bcb1-4e52-d2a2-08d967cd3e28
X-MS-TrafficTypeDiagnostic: DM4PR12MB5183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51832095CB12E6674082C28F8BC69@DM4PR12MB5183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UysZFhOvCRtJHbCXtazT1yGagjjokEwYqBXnFcFgAsljymMREWOlQGmL/xuiXibec7/p1tC5xUhIoAVMXJqWDJXuYjTsd1w5c1agj9zejCavZPdMwJAYHnbp/z8xFzecpqDPo6opZHBWwJxxGS0gYD2pOce4fy37wtEGj2BCbZ1Oep8nCKY9QKN7jm3NJPDEDo/HlLCUhKpOeMwbE1FMukcJmxRNGt8i6rdNFHYLdcP0tqQqDSq3rPuGmUJSpqxPxAr3zfy6deiInlyvUF1t9MTpou67RE2BGqySA5rgGCvUCKTWF5l856ddNctXsSgDeXAne+nG4//yItkGexfSHPb9g5FdL3pFn3Ho3nU0PxkOdb056aUcDKx+TKCDE+nbln28kOcfmeEzkZ2OtEvEjt8HCybLfLvmbzqRHQQy7vv/5h2GMZUeAvOxTlDOGqfaQJYZoCzYCbH3JnvCuI2dB3EJL6YvuFzFuPXsAnCNpHzIfVuMSgNAOgGCNzr1U803jOHdHQlmo9wrtXtmoGxLNagsoWSI4vFCiEE+2QiVF1o6xwiIEGFsmWyhSvHacM6lAZr/DU2wIkAml2cb2HqMMYOZrTqlPoDrfkQ64Lrbe6KJsncSIcohMR50gWFf5CZKuUrS5ZDPYbl5hQh+DvYUhNNsWvP8kVt5cn16c+TaXk42ABtJqDQzf7gssYPwJyXSk+/3+4BOrLOaVloshKn2donvWVb5MNnVSOA/8ObIxVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(30864003)(6486002)(66476007)(66556008)(2616005)(186003)(86362001)(316002)(110136005)(52116002)(8936002)(31686004)(38100700002)(478600001)(5660300002)(4326008)(36756003)(53546011)(8676002)(6666004)(83380400001)(66574015)(66946007)(2906002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BJTjg0L2QrdzdSMjRUL25SdG9WbDRFS0RMRlg0REJybkZPRkNoeDZJRTlK?=
 =?utf-8?B?d1YxK0oyVGQ5SFJ1S0VhQmEzcS8yMDR4MGNmTG5KRVlObzRBQzBEL2hiWkZL?=
 =?utf-8?B?WUxFSjJETG9ZOGpjWXJwMU9lbVhLeC9BUWs3dWlyc0Zqc253M3FXK1hLbkhL?=
 =?utf-8?B?T3pEMDhlVHI2MnF3TjlkeXNnQjd6MXRreXdheWh1ODRMTVNnZXBYUmlZQm41?=
 =?utf-8?B?WDNqcXk4Z2kxUDVWUEtLbEt6bkNqMmx3WUhVY1Z0Q1BLcmI3L2ZsTk9hYUZy?=
 =?utf-8?B?cStSQkxrVVp6dktHYWRWUHArRmNwNTdUWkxVUkpsWDhYMktaaUp4RzJDSHI2?=
 =?utf-8?B?SExxb25nN3BPb2ZRL0t2SXFyRjFRVllsWWNHMUljeVFuY2xxQjR0N2xlR25R?=
 =?utf-8?B?VDJESWdiSlFMTEI2eTZwdVYrNjk2cUhhNXU1VXdGajd4MzF1V3Q5aVdaUjRG?=
 =?utf-8?B?RjBIaUtvUjlUTWo0aUxLYnhmalBkYk5hbWNzanAwQXhDa2pnZi8zRHBtUHVn?=
 =?utf-8?B?d2pHUU9Ud1g0bFFpaUl3dkd4dzMzZ2pWdmlWWUFtYk5tMmJzVUNjdTZpYzAr?=
 =?utf-8?B?WU0zcTVZWXRHNjJWcUhVdmZiME5oaE10WXlhZXg2UGUxV0M0OTM5WlBTc2ZV?=
 =?utf-8?B?YjZ6UTZYWU5uY0xtYkdCT1JkTFRnZ0xNTnQ5MngrSVJlM0Vzb3hWV29IUEk0?=
 =?utf-8?B?Y240OThESjAvMzkxNlgxRDU4dHlEazJ3QjZWTS9PUkhDWEx6Z2hlNFlXaGI1?=
 =?utf-8?B?TDdwYUs1WlBhckRCQVgrUTFaWitIeERhSzMzMnh6ekdaUEVQd3Qwd0dFanMr?=
 =?utf-8?B?MWgwQU9hWlZyYUEyZ25qOTFqUXhCZmgrQW1MbDNJS0RJUlpmV29zYnhZZGdP?=
 =?utf-8?B?VW05bEhuSlNVelVtQmw1NUlIWjV5Z3Ixb3lJNlp3SiszYTNYaW1qT3cwNDlN?=
 =?utf-8?B?MDJyQnprOEowWkFhS04vOXViWll2NHBScnhyWHMxTWF5cE1kT3MvUnBoYkoy?=
 =?utf-8?B?cXZtaDAxQTBaWEt3NE1EbFU1Y2psUVk2QklOWldSWHFBbUlnVnU1eG5sdHBM?=
 =?utf-8?B?cjBnOFVUdjMzdW1QelFsT3NFSVNTbk5GeUx4YkYyc3FoWHRzMmVqTDgwV2xX?=
 =?utf-8?B?T05oVHlCS2pmNDRjaUZqQjFUdjhTdFVYNkxWUEU0UkxzY1daeURINGV2bjA1?=
 =?utf-8?B?ek9LRU0xYTN1Y29mSiswUGk3eDN3ekV2WktYcU96a1MrQzJhY0tIck9vYWhX?=
 =?utf-8?B?TGhpNGhYMzd6ZFVham96dW9lSkhjSTNqY04rTUJnTjAyTkR2dkl2RmJIZTNJ?=
 =?utf-8?B?U0ZFcVVBZDRzL2gySTFhMUhLMzB3T1E3S0lYSXE5U1N2Q2ovZlRsRWNhdkto?=
 =?utf-8?B?YzVyT0tzUmJqS1YybGJFa1lvSkpNZlZWQm9HSFJsVjRMVGx3Y2JPZTdtOHQ0?=
 =?utf-8?B?M2dKR2VKOUJzYUhUR0xvZVI3Y1ZKWmhOY3BXajJFdFFDNE9MQVArOVdOZ1gx?=
 =?utf-8?B?Y1BaLzhTY2JoWUJ4ZHBqS2E2STlONjlaa1NHMTlNVFNSWUVOcXREeXM3dGFB?=
 =?utf-8?B?MkJJbEg3Uk10NU5KcFBCdENkL3FvTCsrSk1iWGVnNkxJVGIyQzVDNktkRlAy?=
 =?utf-8?B?QXFPbUZiamJjMWFWcVVhVkt5RXhyZTBQY2ltemJZYzVCdThGcjUzczRUZjJ4?=
 =?utf-8?B?Ulg5MC9IalVlTnhyL0VSbVNOaHpacHF3RmVGK05mUUdrMFVpbTVCd2tGeDdR?=
 =?utf-8?B?OWZUOW1hM1NkRjNmUy9WZ1dhanJLbktZdnZiNWVhT0R6QnpUY09kNTBFd0d1?=
 =?utf-8?B?Z21pZENmd2FsVXRYNEJlVStUZEIybjMzTy9uZ0RFKzM3TnA1M1pYUjdsR29t?=
 =?utf-8?Q?nrHJb9UL4gjaL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a3a620-bcb1-4e52-d2a2-08d967cd3e28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 13:35:46.0954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcK1QZuXFF/hS1GdIPB4wiiMsTw35kkuWAocJ4bnTDpljUezwt0HtIUWKKOo0n5pTit4Ywl7Mhc3ocwtENrf+g==
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


On 8/25/2021 2:29 PM, Christian König wrote:
> Am 25.08.21 um 14:20 schrieb Lazar, Lijo:
>> On 8/25/2021 4:52 PM, Nirmoy Das wrote:
>>> To get a hardware queue priority for a context, we are currently
>>> mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
>>> to hardware queue priority, which is not the right way to do that
>>> as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
>>> independent from a hardware queue priority.
>>>
>>> Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
>>> map a context to proper hardware queue priority.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 
>>> ++++++++++++++++------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
>>>   3 files changed, 105 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index e7a010b7ca1f..c88c5c6c54a2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -43,14 +43,61 @@ const unsigned int 
>>> amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
>>>       [AMDGPU_HW_IP_VCN_JPEG]    =    1,
>>>   };
>>>   +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
>>> +{
>>> +    switch (ctx_prio) {
>>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>> +    case AMDGPU_CTX_PRIORITY_LOW:
>>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> +        return true;
>>> +    default:
>>> +        return false;
>>> +    }
>>> +}
>>> +
>>> +static enum drm_sched_priority
>>> +amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
>>> +{
>>> +    switch (ctx_prio) {
>>> +    case AMDGPU_CTX_PRIORITY_UNSET:
>>> +        return DRM_SCHED_PRIORITY_UNSET;
>>> +
>>> +    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>> +        return DRM_SCHED_PRIORITY_MIN;
>>> +
>>> +    case AMDGPU_CTX_PRIORITY_LOW:
>>> +        return DRM_SCHED_PRIORITY_MIN;
>>> +
>>> +    case AMDGPU_CTX_PRIORITY_NORMAL:
>>> +        return DRM_SCHED_PRIORITY_NORMAL;
>>> +
>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>> +        return DRM_SCHED_PRIORITY_HIGH;
>>> +
>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> +        return DRM_SCHED_PRIORITY_HIGH;
>>> +
>>> +    /* This should not happen as we sanitized userspace provided 
>>> priority
>>> +     * already, WARN if this happens.
>>> +     */
>>> +    default:
>>> +        WARN(1, "Invalid context priority %d\n", ctx_prio);
>>> +        return DRM_SCHED_PRIORITY_NORMAL;
>>> +    }
>>> +
>>> +}
>>> +
>>>   static int amdgpu_ctx_priority_permit(struct drm_file *filp,
>>> -                      enum drm_sched_priority priority)
>>> +                      int32_t priority)
>>>   {
>>> -    if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
>>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>>>           return -EINVAL;
>>>         /* NORMAL and below are accessible by everyone */
>>> -    if (priority <= DRM_SCHED_PRIORITY_NORMAL)
>>> +    if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
>>>           return 0;
>>>         if (capable(CAP_SYS_NICE))
>>> @@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct 
>>> drm_file *filp,
>>>       return -EACCES;
>>>   }
>>>   -static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
>>> +static enum gfx_pipe_priority 
>>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>>   {
>>>       switch (prio) {
>>> -    case DRM_SCHED_PRIORITY_HIGH:
>>> -    case DRM_SCHED_PRIORITY_KERNEL:
>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>>           return AMDGPU_GFX_PIPE_PRIO_HIGH;
>>>       default:
>>>           return AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>>       }
>>>   }
>>>   -static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>>> amdgpu_device *adev,
>>> -                         enum drm_sched_priority prio,
>>> -                         u32 hw_ip)
>>> +static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>>> u32 hw_ip)
>>>   {
>>> +    struct amdgpu_device *adev = ctx->adev;
>>> +    int32_t ctx_prio;
>>>       unsigned int hw_prio;
>>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>>> -            AMDGPU_RING_PRIO_DEFAULT;
>>> +    ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>>> +            ctx->init_priority : ctx->override_priority;
>>> +
>>> +    switch (hw_ip) {
>>> +    case AMDGPU_HW_IP_COMPUTE:
>>> +        hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>>> +        break;
>>> +    default:
>>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>> +        break;
>>> +    }
>>> +
>>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>> @@ -89,15 +145,17 @@ static unsigned int 
>>> amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>>>       return hw_prio;
>>>   }
>>>   +
>>>   static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>> -                   const u32 ring)
>>> +                  const u32 ring)
>>>   {
>>>       struct amdgpu_device *adev = ctx->adev;
>>>       struct amdgpu_ctx_entity *entity;
>>>       struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>>>       unsigned num_scheds = 0;
>>> +    int32_t ctx_prio;
>>>       unsigned int hw_prio;
>>> -    enum drm_sched_priority priority;
>>> +    enum drm_sched_priority drm_prio;
>>>       int r;
>>>         entity = kzalloc(struct_size(entity, fences, 
>>> amdgpu_sched_jobs),
>>> @@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>       if (!entity)
>>>           return  -ENOMEM;
>>>   +    ctx_prio = (ctx->override_priority == 
>>> AMDGPU_CTX_PRIORITY_UNSET) ?
>>> +            ctx->init_priority : ctx->override_priority;
>>>       entity->sequence = 1;
>>> -    priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
>>> -                ctx->init_priority : ctx->override_priority;
>>> -    hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
>>> +    hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>> +    drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
>>>         hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>>       scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>> @@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>           num_scheds = 1;
>>>       }
>>>   -    r = drm_sched_entity_init(&entity->entity, priority, scheds, 
>>> num_scheds,
>>> +    r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, 
>>> num_scheds,
>>>                     &ctx->guilty);
>>>       if (r)
>>>           goto error_free_entity;
>>> @@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>   }
>>>     static int amdgpu_ctx_init(struct amdgpu_device *adev,
>>> -               enum drm_sched_priority priority,
>>> +               int32_t priority,
>>>                  struct drm_file *filp,
>>>                  struct amdgpu_ctx *ctx)
>>>   {
>>> @@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device 
>>> *adev,
>>>       ctx->reset_counter_query = ctx->reset_counter;
>>>       ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
>>>       ctx->init_priority = priority;
>>> -    ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
>>> +    ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
>>>         return 0;
>>>   }
>>> @@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx 
>>> *ctx, u32 hw_ip, u32 instance,
>>>   static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>>>                   struct amdgpu_fpriv *fpriv,
>>>                   struct drm_file *filp,
>>> -                enum drm_sched_priority priority,
>>> +                int32_t priority,
>>>                   uint32_t *id)
>>>   {
>>>       struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
>>> @@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, 
>>> void *data,
>>>   {
>>>       int r;
>>>       uint32_t id;
>>> -    enum drm_sched_priority priority;
>>> +    int32_t priority;
>>>         union drm_amdgpu_ctx *args = data;
>>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>         id = args->in.ctx_id;
>>> -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>>> +    priority = args->in.priority;
>>>         /* For backwards compatibility reasons, we need to accept
>>>        * ioctls with garbage in the priority field */
>>> -    if (r == -EINVAL)
>>> -        priority = DRM_SCHED_PRIORITY_NORMAL;
>>> +    if (!amdgpu_ctx_priority_is_valid(priority))
>>> +        priority = AMDGPU_CTX_PRIORITY_NORMAL;
>>>         switch (args->in.op) {
>>>       case AMDGPU_CTX_OP_ALLOC_CTX:
>>> @@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct 
>>> amdgpu_ctx *ctx,
>>>   }
>>>     static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>> -                        struct amdgpu_ctx_entity *aentity,
>>> -                        int hw_ip,
>>> -                        enum drm_sched_priority priority)
>>> +                       struct amdgpu_ctx_entity *aentity,
>>> +                       int hw_ip,
>>> +                       int32_t priority)
>>>   {
>>>       struct amdgpu_device *adev = ctx->adev;
>>>       unsigned int hw_prio;
>>> @@ -525,12 +584,12 @@ static void 
>>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>>       unsigned num_scheds;
>>>         /* set sw priority */
>>> -    drm_sched_entity_set_priority(&aentity->entity, priority);
>>> +    drm_sched_entity_set_priority(&aentity->entity,
>>> + amdgpu_ctx_to_drm_sched_prio(priority));
>>>         /* set hw priority */
>>>       if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
>>> -        hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
>>> -                              AMDGPU_HW_IP_COMPUTE);
>>> +        hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
>>>           hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
>>
>> Not related to this patch, but this kind of logic may break some day. 
>> There is a HWIP specific priority and there is another RING_PRIO 
>> which is unmapped to HWIP priority Ex: when a new priority is added 
>> for VCN which is higher than any of the existing priorities.
>
> Yes, that's something I've noticed as well.
>
> Either we should leave the exact mapping to the engine or have a 
> global definition of possible hw priorities (the later is preferable I 
> think).


Will  this be sufficient :

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43fe2ed8116..937320293029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,9 +43,9 @@
  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES

  enum gfx_pipe_priority {
-       AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
-       AMDGPU_GFX_PIPE_PRIO_HIGH,
-       AMDGPU_GFX_PIPE_PRIO_MAX
+       AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
+       AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
+       AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
  };

  /* Argument for PPSMC_MSG_GpuChangeState */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e713d31619fe..c54539faf209 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,14 @@
  #define AMDGPU_MAX_UVD_ENC_RINGS       2

  #define AMDGPU_RING_PRIO_DEFAULT       1
-#define AMDGPU_RING_PRIO_MAX           AMDGPU_GFX_PIPE_PRIO_MAX
+
+enum amdgpu_ring_priority_level {
+       AMDGPU_RING_PRIO_0,
+       AMDGPU_RING_PRIO_1,
+       AMDGPU_RING_PRIO_2,
+       AMDGPU_RING_PRIO_3,
+       AMDGPU_RING_PRIO_MAX

+};


Regards,

Nirmoy

>
> Christian.
>
>>
>> Thanks,
>> Lijo
>>
>>>           scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>>>           num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>> @@ -540,14 +599,14 @@ static void 
>>> amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
>>>   }
>>>     void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>>> -                  enum drm_sched_priority priority)
>>> +                  int32_t priority)
>>>   {
>>> -    enum drm_sched_priority ctx_prio;
>>> +    int32_t ctx_prio;
>>>       unsigned i, j;
>>>         ctx->override_priority = priority;
>>>   -    ctx_prio = (ctx->override_priority == 
>>> DRM_SCHED_PRIORITY_UNSET) ?
>>> +    ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
>>>               ctx->init_priority : ctx->override_priority;
>>>       for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>>>           for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> index 14db16bc3322..a44b8b8ed39c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -47,8 +47,8 @@ struct amdgpu_ctx {
>>>       spinlock_t            ring_lock;
>>>       struct amdgpu_ctx_entity 
>>> *entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
>>>       bool                preamble_presented;
>>> -    enum drm_sched_priority        init_priority;
>>> -    enum drm_sched_priority        override_priority;
>>> +    int32_t                init_priority;
>>> +    int32_t                override_priority;
>>>       struct mutex            lock;
>>>       atomic_t            guilty;
>>>       unsigned long            ras_counter_ce;
>>> @@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>>>   struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
>>>                          struct drm_sched_entity *entity,
>>>                          uint64_t seq);
>>> -void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>>> -                  enum drm_sched_priority priority);
>>> +bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
>>> +void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t 
>>> ctx_prio);
>>>     int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>>>                struct drm_file *filp);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> index b7d861ed5284..e9b45089a28a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>>> @@ -32,37 +32,9 @@
>>>   #include "amdgpu_sched.h"
>>>   #include "amdgpu_vm.h"
>>>   -int amdgpu_to_sched_priority(int amdgpu_priority,
>>> -                 enum drm_sched_priority *prio)
>>> -{
>>> -    switch (amdgpu_priority) {
>>> -    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>> -        break;
>>> -    case AMDGPU_CTX_PRIORITY_HIGH:
>>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>>> -        break;
>>> -    case AMDGPU_CTX_PRIORITY_NORMAL:
>>> -        *prio = DRM_SCHED_PRIORITY_NORMAL;
>>> -        break;
>>> -    case AMDGPU_CTX_PRIORITY_LOW:
>>> -    case AMDGPU_CTX_PRIORITY_VERY_LOW:
>>> -        *prio = DRM_SCHED_PRIORITY_MIN;
>>> -        break;
>>> -    case AMDGPU_CTX_PRIORITY_UNSET:
>>> -        *prio = DRM_SCHED_PRIORITY_UNSET;
>>> -        break;
>>> -    default:
>>> -        WARN(1, "Invalid context priority %d\n", amdgpu_priority);
>>> -        return -EINVAL;
>>> -    }
>>> -
>>> -    return 0;
>>> -}
>>> -
>>>   static int amdgpu_sched_process_priority_override(struct 
>>> amdgpu_device *adev,
>>>                             int fd,
>>> -                          enum drm_sched_priority priority)
>>> +                          int32_t priority)
>>>   {
>>>       struct fd f = fdget(fd);
>>>       struct amdgpu_fpriv *fpriv;
>>> @@ -89,7 +61,7 @@ static int 
>>> amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
>>>   static int amdgpu_sched_context_priority_override(struct 
>>> amdgpu_device *adev,
>>>                             int fd,
>>>                             unsigned ctx_id,
>>> -                          enum drm_sched_priority priority)
>>> +                          int32_t priority)
>>>   {
>>>       struct fd f = fdget(fd);
>>>       struct amdgpu_fpriv *fpriv;
>>> @@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, 
>>> void *data,
>>>   {
>>>       union drm_amdgpu_sched *args = data;
>>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>> -    enum drm_sched_priority priority;
>>>       int r;
>>>         /* First check the op, then the op's argument.
>>> @@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device *dev, 
>>> void *data,
>>>           return -EINVAL;
>>>       }
>>>   -    r = amdgpu_to_sched_priority(args->in.priority, &priority);
>>> -    if (r)
>>> -        return r;
>>> +    if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
>>> +        WARN(1, "Invalid context priority %d\n", args->in.priority);
>>> +        return -EINVAL;
>>> +    }
>>>         switch (args->in.op) {
>>>       case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
>>>           r = amdgpu_sched_process_priority_override(adev,
>>>                                  args->in.fd,
>>> -                               priority);
>>> +                               args->in.priority);
>>>           break;
>>>       case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
>>>           r = amdgpu_sched_context_priority_override(adev,
>>>                                  args->in.fd,
>>>                                  args->in.ctx_id,
>>> -                               priority);
>>> +                               args->in.priority);
>>>           break;
>>>       default:
>>>           /* Impossible.
>>>
>
