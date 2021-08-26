Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AACC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95620610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95620610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5D26E83B;
	Thu, 26 Aug 2021 12:47:43 +0000 (UTC)
X-Greylist: delayed 924 seconds by postgrey-1.36 at gabe;
 Thu, 26 Aug 2021 12:47:41 UTC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E056E83B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXGsFRVQaOwRnPArs86NyXAEZvBBNiPVFzlnaCEpRZJWW+tFWJlqiaaCAg6rOt03hjKF5SU3OVlEeKP36foYoiPrIzYi0N3z7cxaDXD794vTilJlUejxAEu4lrwew6ejEUPt4rnBfyDILzhBk71hfJ32FQ8swsOCyJ+KAHLUBP70h14/yatQgtm6Qk4Ig3s6acX6EGitQUPUPZywuupMlwCPnFbD+Gevxgeacl1D1305jH5AJKvnJZxDLYAtafXB/bMD0T4qgDzd4zD/ejf9ttWcsDjwOIQH2wPZiRNKTbMG7qbcIjPkH1pDc4AqFDxcaSb9DIrzGxpwnwWmOcMQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDOOuusijUi+aG0Pfvie1/43vUINC6iUotuGt6R4bvQ=;
 b=IJMbKsS3iHhN7s49vmEbu7yDj60BoZtP6+1NsT+wTdpF5fcuEaZaMswTk1jl4CVd2zPbkmBSP19viPB91WF1aG8gJuAFlFxnYy8XL8UIeVDPG9n9B/sk5lzR1moBseDzNobZugOwzjzRyYtiZ2tsJlzisszS8qaua/Fm5fOQylkanOJT8H+w1T87imdKyChsg6M3PzPWDSrqrd/RiaW8wVJEZCS7Ell13JwYGC64PmDGECmaO/tCzq2QYXel4n/OMk1EPAVKsoriAHxZxQ6fTrkyOFxCpmvHry5VFn0fSd8Jt5N+GPe3gabh0LxvrWt078br77rVcCkMLur5OXZAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDOOuusijUi+aG0Pfvie1/43vUINC6iUotuGt6R4bvQ=;
 b=miYaX2j2rTjrRm9J8Xx4R+AA+Dav/l9iMtGOL4ScDprEQSttdZ6GgTBxgUlmRTWR4wN620t2GOXNR7Y81S+SmZbJsz5gci6RDPyDUIIHBQ6jEvuPDit3g+CW05MeyjjPNlHe96dAUDGEvYNLwnrGw/8LN5t8qP6BJANwO8py5nE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:32:15 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%7]) with mapi id 15.20.4457.021; Thu, 26 Aug 2021
 12:32:15 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu:schedule vce/vcn encode based on priority
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-5-satyajit.sahu@amd.com>
 <f6c013a6-1d88-6360-57c7-6494a92f7648@amd.com>
 <bcfdb979-0788-1cb8-8abc-46fe6e88b517@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <ae01c721-1abd-2ea1-b721-b1fbf1f232d7@amd.com>
Date: Thu, 26 Aug 2021 18:02:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bcfdb979-0788-1cb8-8abc-46fe6e88b517@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 12:32:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0012eea-226f-4961-cba8-08d9688d891f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB531179DBC04DD88D71CB1322F2C79@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g40L+oot0L0u5E+MFJHP0lnKLwMYyWJhjRXtVfW7lRr1eFi4dZXWn7oM6DCIKNUb6dEbxhRohymVUBy+y5n8k1GmADgPH4iHnwl7g/MCPWYOy6vNE9XEWsQKkbjZ7ITK56TD6QP8csROEpwoGCy28kfACup6RMf4qQnup+TWyelonoD6gCqn8TsNWuvPC4aSK8gtYKdVO38il//i5BkRt2/jUaMRLFBN3CLO9mHi00z5lOUZlibntW/gX3Fovrk9BVWdUdaoXCxu8b/IQp+zxgvGjTEA3HsER0MflmQUd9A7n4aBlmL41PPWPGqF/3tZdxr49E6MMVRH2DiDFYCA4hCQYMsLEP0oMpLJPqVV4WVzq488t1pomqDELqrWZrcDYLbyFCYJgLNxb6CQ7psKOR4N7rtAdYPhx5HROL13cFGFd7L8kpSi/FFb9nEWgOXbChblyrx2Q3ZO8dvUslppWxm8PaYLaK+VZrN+/4aZ6qHFNfa2pzTXfLHCMESHyOSplIVgimMSYhwia+SFGL1JWOwtlzSOsWRdYADY9gOcNQ294HAn9u6ZybAx/IPL0D3pKLU6igWngH78uVQbfrnb88+PhydDAqWqhJtp7mNffmnkUVnI9uBkfX8Ive+iJL1nnjmxZEsss0hcizdzFWFYlgQCXKsdthyY7fD7gnTc2Jn45Mr640B9Vo2dlLqW/vut+Q8Cnvo/wVwmrVj4Z4nGFSRfFWMO7iVCvHIDOPCertY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(36756003)(8936002)(4326008)(316002)(956004)(508600001)(55236004)(8676002)(26005)(5660300002)(38100700002)(2616005)(110136005)(31686004)(186003)(53546011)(6666004)(1006002)(2906002)(31696002)(86362001)(66476007)(66946007)(6486002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dHNy81b28xeGFsNjNYVm5OWGUvazlobUViZ1BhSkdqdjA3Y3FoOElIZVFO?=
 =?utf-8?B?aVFqU29ibnc3dXo1UjI0UjE0K2JNK2ZUbWRIVWNlS2ZiNVpiWWlLYmgwMXh5?=
 =?utf-8?B?R2VLS1FZL2dSR2lGc0srSjdCMDQ2a3VpQ1NOV1dvdUpkSUJUNHpINUNZWElM?=
 =?utf-8?B?bW5BbXZWSS9OYW9BbmUvWk44UEhKWDJTOGNJK3hXcHhmTW9UcnNsRGhrUWFy?=
 =?utf-8?B?UmNZSXFId0lQdXNrRWxydlBiT0VVNE1ZL1B6L3lwVzBFYlBieDZqSE9LekZ3?=
 =?utf-8?B?ZUEzWHh2MUtGNzUvYysyUlpXbktBcjR3cGtJQTY3a3NrNTZ3bUF1OFBzQU9m?=
 =?utf-8?B?OEZMc3pNTzIxcnhEWTNDaDlWWGQ3b0Z6bUkrcGZVQ0psSEFBWjRKZjZGVXJY?=
 =?utf-8?B?TjdoSSswbHp2MXVRSmFnWXlKdmo0blBVSWgzTkNSOWI3ay8zKzZUelBhWHMw?=
 =?utf-8?B?QVArTXhiSi9rS0FBZHBwd0xnWnFEcXlWdTZQVUFyVnFqRVAyTWMxTUxadHN5?=
 =?utf-8?B?WEpJdzBMb2VvdFhxZ1BVNGhvUjdsZXp4YVBOczk4eTArbjIySjhEYUpDdmdX?=
 =?utf-8?B?OFdaU1M4aE9jeUp5Vjg5U3dCMnhjdFp1cTNLeGc1Q2I5ZE1VeVlwUHV2LzB2?=
 =?utf-8?B?aTluNW9sV3VPaCt0WThoSlZhbDBkNGFjYUZVODFzVmFjUE5HK1Jid2RmNWMv?=
 =?utf-8?B?aGFoY2lFMHFpN0VQZ3g0UnZLMGNtajBEbzMrY1Nzemt4L0hFL2I2Y245dXJx?=
 =?utf-8?B?YlBlSjVjM25tSFNpODk0dWxQR3NHcjU1MCt1SndMaHZxcVhzT2hRc1o0WnJV?=
 =?utf-8?B?UVBCaGpkb0VYbUJCWGwyTXl0WllGNWJPaWpCS3dzQTN6Q2ppbmRURk1TWHc5?=
 =?utf-8?B?OEF0UUwzN1JGYmRjYnB5emlRZ2RIVE4zcmVaQnFjZm5qdmJRVmVPZUFBcnpU?=
 =?utf-8?B?UzlOdUtMUVJuRWpQNW83UktkOHg3ZzdOZGo2cjc2MUE0OFVwRVg5bkFzaUQv?=
 =?utf-8?B?RmY1Z0U1WXhYblNFejRYbjloYjI1RGxmMDB6d2VtdnZubm8xajdKWXJnTENz?=
 =?utf-8?B?aDVBVExEQ0lLdXFoY3RzT2dkckJ5Z0c4WjB5c3FLYzRDVEtNRE1BenBzbW9N?=
 =?utf-8?B?ajFlU0VFZWwvUXhzdHNkNkN3MXJ1Zllrc0IzQnJkU2NWMUZNZ2JYenV0Mjl6?=
 =?utf-8?B?TEo2SThUMjM5ckM1ZDRxS2h2Zkg4NC9aQVpDVFpqQ2l2SFB1NlhXdytpMDV3?=
 =?utf-8?B?eFlVZTBJZlNVcGRIZ21sZUttYzREM2t0MTM1VVg1Q3NyYTIrR2swWjJkUFhi?=
 =?utf-8?B?dVRmYnpKMUJOUU1CWUVXZ3ArRnN0R0FuWFV1RUFBWVdPUGlvYmlTY0YxdUVO?=
 =?utf-8?B?Zi9aQ01wRm9GQ3BZWGg0L1BmMWgvTHlOSDNDdENHcnpjWndRYzlKRCtickJP?=
 =?utf-8?B?dVppMHQ1cjRPN05mUnJPeHlnL2xWWGh5cUpYcmNqNEszRzhWazdnVXgzRUdt?=
 =?utf-8?B?R2pYS3owWUphQjhtMlJtTVR3WE5VY3lBZU1YUlRacUhEdzJzTlRxM2NVenQz?=
 =?utf-8?B?dFQyOCtlQURrbXJnMlEwS054amh4eUxZM3lycTFveFdjTDltYkVubmhBN0NU?=
 =?utf-8?B?SjE0L29rTUVuRVlGcFZsVDIwOUxJYjZjVkVzUncrV1RNdTBNRTJvbWtPRzZH?=
 =?utf-8?B?cjhVdllPc1BnQmdxR3JBcitBUFgzTEdDWFZadDBwc1ptMDl0aE82OWdvMGcz?=
 =?utf-8?Q?GKNg3VGXWYJES6mknKmOHFY5itqgESUjetURNbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0012eea-226f-4961-cba8-08d9688d891f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:32:15.0831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gsK4kFqCZ2l2UCQMSIYc3xhhS9cOyF1I+DNlptijalN9bY6ofUTsujZ4dZCS3sGOp9QhdnRP3cPdRZpzqtXWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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



On 8/26/2021 5:55 PM, Christian König wrote:
> Am 26.08.21 um 13:44 schrieb Sharma, Shashank:
>> On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
>>> Schedule the encode job in VCE/VCN encode ring
>>> based on the priority set by UMD.
>>>
>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 30 +++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> index c88c5c6c54a2..4e6e4b6ea471 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -120,6 +120,30 @@ static enum gfx_pipe_priority 
>>> amdgpu_ctx_prio_to_compute_prio(int32_t prio)
>>>       }
>>>   }
>>>   +static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_vce_prio(int32_t prio)
>>> +{
>>> +    switch (prio) {
>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> +
>>> +static enum gfx_pipe_priority 
>>> amdgpu_ctx_sched_prio_to_vcn_prio(int32_t prio)
>>> +{
>>> +    switch (prio) {
>>> +    case AMDGPU_CTX_PRIORITY_HIGH:
>>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>>> +    case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>>> +    default:
>>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>>> +    }
>>> +}
>>> +
>>>   static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, 
>>> u32 hw_ip)
>>>   {
>>>       struct amdgpu_device *adev = ctx->adev;
>>> @@ -133,6 +157,12 @@ static unsigned int 
>>> amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
>>>       case AMDGPU_HW_IP_COMPUTE:
>>>           hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
>>>           break;
>>> +    case AMDGPU_HW_IP_VCE:
>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(ctx_prio);
>>> +        break;
>>> +    case AMDGPU_HW_IP_VCN_ENC:
>>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(ctx_prio);
>>> +        break;
>>>       default:
>>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>>           break;
>>>
>>
>> IMO, this patch can be split and merged into patches 3 and 4 
>> respectively, but is not a dealbreaker for me.
> 
> I would rather keep that separated. The other patches add the 
> functionality into the backend while this one here modifies the frontend.
> 
> Christian.
> 

Sure, that too works for me.

- Shashank

>>
>> - Shashank
> 
