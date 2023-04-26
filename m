Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5BCC77B78
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 18:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681E510E260;
	Wed, 26 Apr 2023 18:02:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BD310E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 18:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAt0COqNgQd9jDjvIAPUxhpU52ifaC7TgvKUTu51Mk2WJQR//nd0naV5y5tvgtwa6o8Ykn0LLUBbGAKmgqSS26CE9kTWWEOvjlY7YVrC9efgwxFXMs1AKirN0zQ/j/g19f26zX7+jDYybiB8PaO61JQuN+lSc0BSlDeDoF8U20yJmhKhNsQsBGq0Gx0GqfJb4FLItmsV6bp9/xADIDqMRCn+ivnOnTJBDFWHlcmKFXi3xvgr2fzgBUyY+w6TaIyaRS4BKVEtJvs2ahESAJfMPiL7MArTm8gLv/meJfcJwQyYErICSLFFih4LYFI+RAHjd453OkW7l2LipTGs8uwfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZKDz0e2jIHlsNbEOCE+Tt46IOxRA3I38C8SkHW29a4=;
 b=LZzumJArEmYX3SnvncGp3me53Gsm0gifv74b+IdofCxU9nsZ9UWCJ/gga9kXkvBYXQ8M7I6wBsz7Yp/Ge+wOEsZLSlED2Gnebde+qKDpJV98Acy9KJK9N4gMCOLUfQCrlAndoJvolNXiuRCw6ssnfYKWL5O6APbYsZ6kQOsiR4h/9arUQcByZZcWJ2ouIA2MLUktE3aUG9LOVLMIjiU789x892IjB1HMo6N1DKI1nVkGiqxHcbXW0HOFgZkFc2Sp1yjIglFCOWwSOpxEOMuTfOjXdEbYnISTWAGKUN/rJIvfcY/EkqNKTaUt3lUvYGN7rvenqz+nIg1lTq20jihvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZKDz0e2jIHlsNbEOCE+Tt46IOxRA3I38C8SkHW29a4=;
 b=aS5/2V8dh4X+TPpzrAlEmN7KChligT97QKFTmV27bs9aZFbsWTsBIoEMnfo42ytQO9QGc4bcrHfm4zzKebXkOKdzyXF2SZgDp51TWNTpoQHZEEp9tEwJAGtVNUffws9YH59bTMZSq4uqRQed1lrN8s3BXSYK0rxMfYZLH7zxRiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 18:02:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 18:02:38 +0000
Message-ID: <19238e6c-86db-6a00-ea83-e69b7384eeba@amd.com>
Date: Wed, 26 Apr 2023 20:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
 <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
 <8b8d22bd-0eff-2f81-9267-07c4c4d058d1@amd.com>
 <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <04b2fcfc-90d8-5398-9ccf-58dfd178d73b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1fcf8a-c25a-4521-ca70-08db46806bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuxMgFyUS8jYGxGKVfCMadW+ta9V78hZ33qS66TEskEaYplaMG5Rs3wvpZ0fBhAAmEJM7VPkP6dgtGLB4M7ql5UYX0SwBHJD9803pZSem8FG7JiXsxHgxfG78ESAi76NFKqAyIClsKuydikINC0prBndf+3VYGWjo4Rw3YvPfbnqeJy1pc8HQJUrWLKYgZVall6Nj6A961MhskgwzXkYHy/FfQlWgBOq1y7K9UvuhgTP3mqlhYyVz68/Uy72hz59oxTbXhKgPSO9wNyPuZnjBJkYm8N/mmuFZahhn2K+HpYQe1Uc79AYF/p5kD3YnNm6WAL9Yrv7RISf7l/giEye8ShuJokPeIlzlu9o3DBHU0TB2tGmToaWjrqpP3eQiDJdnTdQkngoy8PQW1WaAV1Ell6axl7dEn+aC8JaIuZrFx+fx69qYqsAcRJDmDIUyyN8BIKafsC3YzL9tdJQHyNDyR82r0paQByC5D9CdxzEZHntkjJRIOVNbeUIPGexgNoVSWEtgxqvLikIEfxaIcIYC022kpliJ0/I9e/LOb23us1c3KuEF4vNKaSxZNsx7eLCw9NoBhJ72ZHWAZhVZcALkiwzGG8GXF+bQC3JC3TwYhMIKE1bOzdkrQWieK7WZQuGSJeZMmNC/79K+7w0dZ+Efg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(31686004)(5660300002)(36756003)(8676002)(316002)(8936002)(66556008)(66946007)(38100700002)(41300700001)(86362001)(31696002)(2906002)(66476007)(83380400001)(66574015)(53546011)(6512007)(6506007)(186003)(6486002)(110136005)(2616005)(478600001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFIyQkRQbG9raHIxeUJWQ0F3MllyTVdhNU8yU1JqSXA3VXBwQW1yUVRFN21y?=
 =?utf-8?B?MDJlY093eXhQbWphTE5GWUI3R08ra3o4cHRCM1BqVUpmY0NJVEdlcEk5aFlu?=
 =?utf-8?B?dFZvK2V2NVRvS1cvRURib2tRK0I0WWRZTW9XZ1JienNqTERMWTdrYXdsRUVi?=
 =?utf-8?B?KzBKYTVrc1U5b2FXdUY0Y2xPZDhuTUhHUlBENFFiTHdoL1cvWS9FQW5OR2RQ?=
 =?utf-8?B?VTc5YTJKVjJDajlzM1BSWmp4UWxTZUVRRHVoREpIUUd4SmUrNml0NHhJLzNU?=
 =?utf-8?B?cFhzcmR6Nkxnc0dnUnZRa2ZNbVBDcFlNWjdWeFBNN1ExRnA5ajVBOWZtV3lG?=
 =?utf-8?B?Tm93VDdHVGN0NUxOTVJMajZhTEZyMk4xMEl6Z2U3bkEyM0xWK0tqSU5PZ1N3?=
 =?utf-8?B?U1ZFOUlseVZqNEZ5TFVQZHBibDhsb2pMZGZZNnpQNnJOK05nQ21jdStTWTZv?=
 =?utf-8?B?SkpnMTRVT1pVdWNuVjc1d1JHMGlTRHltLzhYd09URXZNQTAxSzUwVXFTVVNj?=
 =?utf-8?B?OGp0MWZsbFhDR1BORlJJSzhwWmxwNUp6NXdmRkdJckJzeFhIS2lvNEhlelpY?=
 =?utf-8?B?eWtMTXNJZU1HbDM0UEFQZHJXNXlaczE0aFBReDhEbnlDWFphSzhJM21aZU9B?=
 =?utf-8?B?UjB0YTNBdWZ3Q04rbFBkcXAvdUpjbUFvNHREbHppTVQxWmVQT21LVzBTNzd6?=
 =?utf-8?B?QW0wRk1pRWk2R09qZ1llajlUWFEwbWREMU1YRldEZjNLTGE5NlpHVEZJaGhh?=
 =?utf-8?B?czJoVGtYUTlJTjk5d0VUSU9Nc2k5NDdqdlhkR0h2ekt5UnI1TnNOd1VPTk9h?=
 =?utf-8?B?OWM3SHgzVnRBcEpTYXVqOGhRTHJBSzlVREE1NjZodWZvQ21NQVY4U0xOWjkz?=
 =?utf-8?B?cDllYjQxL00rcnVONE1KZ1VxMk1od2d6VGprZXZmUEJiVDduTXFLNTRGeGJ5?=
 =?utf-8?B?bFpnT0VoUDBvbVppNFk0QmUwWUthMHJRbjhza3BDbzhTYVUzc1hOU2FUOEcw?=
 =?utf-8?B?NEx2c3J2akVRY3BsbHMvZUdiWFl4MXhXM2oxQXhZYk5DTFNoUERuOVRZZmdw?=
 =?utf-8?B?NUlrTEN3NHhYWjFVTzM5d3BOaVFtbTk0cWRycmZNZ2Q2U1VPcUkwTFJabFQ0?=
 =?utf-8?B?Vm5IOFlxYlErK243UVNpSWZRVUFxMk1MRWMyMFZwY3lWU1Z5YlVELzk1bmdy?=
 =?utf-8?B?WjgwbU4wTUZEL29GTjRKQVZPc0cvWFNVSk1HTFNHTDRmVEphSmtGeWNSSDJr?=
 =?utf-8?B?bUdMdmJXTkxGUVUwMXlBeXRudFdiRm1EZ09YaTZHNHQ5bWU4UnJsNnQvQmky?=
 =?utf-8?B?eUJDUjNuem9yaVBxcFRWRTdBKzMrR1JEKy94Nmt6blhXM2hSRHpsNlFrMUIx?=
 =?utf-8?B?NmpjY2NRaUNXK3RKaXlVUTRYTkVocU1lSnNKZjBRTmROV005bnM4WTZDdVg0?=
 =?utf-8?B?akxGa3M4V1Z3Qml3NzZXbjczY1ZmSDZXdVBvUFV5ZWZuODdPb0hFZDBvSHVi?=
 =?utf-8?B?VWhkdjlrWGFPeElPZ3JiS3RRdldXdy9jUUJJUGNMZXhWV2N3TXZvNElGekpY?=
 =?utf-8?B?NkhrekVrVXlSZlZJd3pRVHhSK2FsaWZpNmQzcTVQM29UM0h6bVFDcjMxQ09n?=
 =?utf-8?B?S21yRElscmd2YXd0ODJ0c3Y2K3h1aXNMK0l3MDkydlZDQmE2RitRV0ZVR2FC?=
 =?utf-8?B?TWM4M0ZLMjB1VFJtVG1WK2pjZnF6UlJhVzh1dGI3QnBJMERpMncxZXR6c1Nq?=
 =?utf-8?B?WHVQWGxkQnF0SjhuUGlVZCt0ZklSN3RKMnVqYnp0VUw2MDFyZ3hadWlFbjQ1?=
 =?utf-8?B?U2hFNzdqNElEVEZzOUpxeTVjWHRPSHh1Z3RmTjJZdTZwL0s0U01OaVM0R0VI?=
 =?utf-8?B?WHJSSTN5V0lSOXJSeU5HVFJPSzJSM2hocVhTRndPeFhFbUpDNXNuTVJUbEho?=
 =?utf-8?B?NUZ5Y2NTWElQUFlid2djcG9Pc1ZpSlBGdnRJSzFFbGtpVWlEazlOUlg4L1pW?=
 =?utf-8?B?dVpGQzNHbFNoVkk3SjV0NkhHSDlJd3lVNkNwNjgzM0ltUE9XUUJxZjNCb1J6?=
 =?utf-8?B?aG44bmVXd0VPK2JRWEU0dVFmQklMUnNDMnhxYjlBU1F5Wm1WQmMvMGJPdGY4?=
 =?utf-8?B?UWhYZURsYTZRUEdzUHRKTENpdVRhWUw4c3ZZNlJyZ2NscndoY1UvZDR0S01B?=
 =?utf-8?Q?yPrlEKEzEFnhDiXZ/1f4fAvm0dQD8gorh6gB5S1w0bbh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1fcf8a-c25a-4521-ca70-08db46806bcd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 18:02:38.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbI4WzvtZ3bHNUKZ+PWbNBPZ556xdvm7+pKjicysJa9pO5wuGk25ssStsqzDkpeL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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

Am 26.04.23 um 18:58 schrieb Felix Kuehling:
>
> On 2023-04-26 9:03, Christian König wrote:
>> Am 25.04.23 um 16:11 schrieb Eric Huang:
>>> Hi Christian,
>>>
>>> What do you think about Felix's explanation?
>>
>> That's unfortunately not something we can do here.
>>
>>>
>>> Regards,
>>> Eric
>>>
>>> On 2023-04-13 09:28, Felix Kuehling wrote:
>>>> Am 2023-04-13 um 07:35 schrieb Christian König:
>>>>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>>>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>>>>
>>>>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>>>>
>>>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>
>>>>>> I'd like to get an Acked-by from Christian as well before 
>>>>>> submitting this.
>>>>>
>>>>> I have to admit that I only partially followed the internal 
>>>>> discussion, but in general you need a *really* good explanation 
>>>>> for this.
>>>>>
>>>>> E.g. add code comment and explain in the commit message 
>>>>> extensively why this is needed and why there are no alternatives.
>>>>
>>>> OK. I'll give it a shot:
>>>>
>>>>    This code path is used among other things when invalidating DMABuf
>>>>    imports. These imports share a reservation object with the exported
>>>>    BO. Waiting on all the fences in this reservation will trigger KFD
>>>>    eviction fences unnecessarily, for example when a DMABuf import for
>>>>    a DMA mapping on a secondary GPU is being unmapped explicitly. Only
>>>>    moving the original exported BO requires stopping KFD user mode
>>>>    queues. If the invalidation is triggered through a move notifier
>>>>    from the exported BO, then moving the original BO already triggered
>>>>    the eviction fence and we don't need to wait for it again on the 
>>>> import.
>>>>
>>>>    We can identify DMABuf imports in KFD for secondary GPU DMA 
>>>> mappings
>>>>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>>>>    operation that ignores KFD eviction fences.
>>>>
>>>> How does this sound?
>>
>> To be honest like quite a bad idea. Why in the world are imported BOs 
>> moved from GTT to SYSTEM in the first place?
>
> As I understand it, the way to update SG tables in  SG BOs (e.g. 
> userptr and dmabuf imports) is to move them back and forth between 
> system and GTT domains. If we left the import in the GTT domain all 
> the time, we would have no way to update it, e.g. after an eviction. 
> Currently the move to the system domain is done in the unmap code path.
>
> Before memory is freed, we also need to unmap it from GPUVM, including 
> the DMABuf imports on remote GPUs. For the above reason that currently 
> includes moving the import to the system domain. If we removed that 
> from the unmap code path, we'd need to do the move to system somewhere 
> else, maybe in the mapping/validation path.
>
>
>>
>> The only reason for this I can think of is that the DMA mappings 
>> become invalid for some reasons and in this case waiting for the KFD 
>> fence is actually the absolutely right thing to do.
>
> In this case the reason the only reason for unmapping the memory is 
> that we're about to free the memory and its DMABuf imports on other 
> GPUs. This is coming from the application with a promise "I'm no 
> longer accessing the memory". We don't need to wait for fences here. 
> We only need to invalidate the PTEs to make sure that any further 
> buggy access by the application will fault.

Well in this case just free the BO and it's bo_va structure. The core 
handling should take care of clearing all the freed up regions.

As for updating the SG of a BO you indeed need to move it from GTT to 
SYSTEM and back, but in this case we should either indeed wait for the 
KFD fence since page tables in between the operation still have the old 
entries or we should destroy the BO and create a new one. The later 
would overwrite the PTEs with invalid entries first and then fill in new 
valid ones.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>>>>> ttm_buffer_object *bo, bool evict,
>>>>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>>>>> +                        ctx->interruptible);
>>>>>>> +        else
>>>>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>>>>           if (r)
>>>>>>>               return r;
>>>>>
>>>
>>

