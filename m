Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7520BCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 10:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F004110E642;
	Wed, 14 Oct 2026 10:57:07 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384A310E642
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 10:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPi7kqbTjRbtJChrkUQbN4Ipu9b7Nk56gzwO5w0EGHnUIumM4YS6evFd8+ZpjPs31na46qw/uAy7cRkovGYerpR//R4Z+ThnWp6eZbE8aQ1fUntafz+BIRxU1ffNwYz8huj6IkFQA8mfS/aElOv4GUw/d0vT8IxkNLCqyBxua2AV9GphN+KISRjBd9qJTWSsdCaEKskk0WHw2MmYmupJ1J0S4oq1AUvBslFI6lp69C91a+lvFj1AJ4MWyHJ6H+S0U8Or8ziMPdOHWz17+EdTKGZlf11QOMlPFzkYZF9SwicISeTNc70CQMyY0imhN4xSdIuCsY1YjXl5f8QAMZL5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn1J7vW9N98HisSAk7dYeXUWk4wZSfJQxwcl9izqR+A=;
 b=QArDxFzfGtzPSd87y4tBy0CET3giXU0rDu41IjIhHEn1PJ1H2SEcii3Z2vZTfUdX8QI2Y/89pGssinYSJJkwXF3TvHQlcrMPFV8Swuqy5FvRkf0jnWWSdrZTJDAaSmn9e8bmRQFZiC2WuzvcycCKhcLPEQtxlC5YySA2zksbyetDuutTw2SC/bf+RGALH/al2gwYi1MUVao9dqYkRZ6PpPQKiTGuWeaMKINXPJIMOB66wYWwXE0YU/llDacd5xnhyq7/PDaym0G/Ofox4ySsM7k7M1AkCYTvnSAO7PPqNSiWgp80o0Po2cwg2KaQ4hWsBiw3szD8sC3nnTr95lkd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn1J7vW9N98HisSAk7dYeXUWk4wZSfJQxwcl9izqR+A=;
 b=IC+a4n7SvU9WJFTkOxlTjy05Bu0OtggkB1YoYd77o0G2/h2Q9ohjdW3z6grPv47U5PRCNAxuF/sP4++VGpEkVCaeQAiUYTfaaNjFFr2zjUXR9gDVuPOtNlte7KLGo0e7Vi5Ev9vyCHhBJ2gMgfusIhde7Ba0ttV4RDk1gyMCXSI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 14 Oct
 2026 10:56:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 10:56:58 +0000
Message-ID: <c4b15d6f-cdcd-4f85-ad0b-cb7365f5567e@amd.com>
Date: Wed, 14 Oct 2026 12:56:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
 failure
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak, Vitaly"
 <Vitaly.Prosyak@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <639f5147-1694-49af-8ac4-dea9ccdd7f89@amd.com>
 <PH7PR12MB60001D76F73B9883506282A8FB9D2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB60001D76F73B9883506282A8FB9D2@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: e744d91e-313e-4636-1a6a-08df29e1ddd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|18002099003|10067099003|22082099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Kc18ZfFGN1vQVOVwiXYcKGzH6KJZePhCiLG8m3l8n/O5iHeNSMp/C/G87CWr03ePFcLLwOpp3XUEF9ovx65XjGRQ8EhZHPVD5kaHmMjRCbyh3B9kj979ZYp9VBE2CcFIGZJ5h4yr705n/LkACq8t/3D6K/Ts7oQhbs3GaaW6fyP1eF1Njco/Z3HL41d8CSRQljjwNQAs5VRyQhzHyEvqdx/5NZUhBftjBsIrY+C9tm1uSZmP+21jv/uP6R4JnNRmbkOPmdUv5/Xg7tIOXkdhBC9Ngvvv4JUSD9COg+fqnTbxZSnBfJOOuAdmmXj5LOvQTWjkFXR9MppW8jOhKFm+FMvEeAgGB0Hc2LgBWGflRyS6750TYv97raYkuBnuTjiaUUcuhkVqff7SKaQwV/EBjSuROPqIxhYhvFDoeOWw43BV+gYdVYkVau3lEGnHlWNoq2FNVDDtVXDsUaczHPi4j3pqYakwsO7pGK906UMGhceA/Zj7puVkKehCBaDgwWCCKEs9OgW4nFvH0GYlwlJrHel5f8UT7er+Xq15yOSZkCo/jhyIwDxjvGCbrBq8hb08YwfG8v+4niKAHLfg5oakZrmoV7hCOnNRpb9VyKSEdvFBQjTOG5lN7lETctcIQ0YMQnVdQwrUM+rifw8s2smrRXmS51nNJ/EGXw6ABzMOWjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpoVXA5SlljT3hiek5WQk5GUkpwNlB0a0dkbE93dWp0RzdZc2VXdm4zWGpG?=
 =?utf-8?B?YTdXYVdQZXBqRjFYSHF1MmprYVpPU0NaR1FsM2x1MEtVRnBHZDlqSVEzam9i?=
 =?utf-8?B?dDdmN2x6MjkzRlBGaEpHTWZWcGp3dk9aeDZMaFJLdGY0MFJDTjdnYW9Qam5a?=
 =?utf-8?B?V0YxTmdicG5LaHdVUDNzQUp2dXdkQm9OSFlBOWZ1MUhpLy95aGVHTzN0aGxH?=
 =?utf-8?B?SkJCc2doVUtOWFNNN0p6T1p0SVB1OWVDVXNzdHlqR1did2FjeW9qZElIakhz?=
 =?utf-8?B?eVBwaWJzUlh2cnJqWDlDSnBIK1lTQlNCelZtb1hweVJGNGF0VFJkK0VYVk12?=
 =?utf-8?B?WW81czdVRUVpMHBBeDlCRHg5dVQ3SDZNVy9obTNlcUN3ZXJrUTJaV3lDSUlH?=
 =?utf-8?B?TkF2MzFSbXZVYzh4U0d6WFlNT21FeVozbUtpd3FkYUlyRmpyMnlaMG1zbHFW?=
 =?utf-8?B?cmNDQldqWU9NUXNjSFRmZ2pRY2NDeUJtWTB5bkpYTVgvc2hmenVneHlhMm96?=
 =?utf-8?B?ak03NnhZK3hveVRtR2UyNUc5Y25DMnU0eGtmTFRMUTRqVUthMUJ5ZEVSbTUv?=
 =?utf-8?B?YXoyMW1Zb3hqZ0hFWk53QkZHeldHUS9KRnYvZ1JWaGUvL05zczdqcy9Kb3dm?=
 =?utf-8?B?MDhKaUxObUc4dndEVDlHMVBQR0gvQWhraGVpczZYSHlOVmFGd056WUF4bnBK?=
 =?utf-8?B?MTVEcENFK3hWVFJGa1VDUXRwT3FER3I0bmVXejA0NmpxTktQZ3ZxdGFHeURz?=
 =?utf-8?B?d1dFT1cwZDhpbXF1a1FaaWlqU2NYakpvR1VzRXZBVWt5VFRHejBVakZramZW?=
 =?utf-8?B?RkdkWUZCbEk3N0NmYktIbDE0OU5kNDFKd3NUZi82MXhUK0Q5c21hdzFxN0Y4?=
 =?utf-8?B?ckdLVzUzODY4S2JPWjFMc3drZVh3cXlLeHhTQUFoaDA3d2d5K2Q0SENBbUNt?=
 =?utf-8?B?Q0lFYXJlUUt1OHUrdFhEckhBbEJPTGoySm1BYVhObldtVkoxMEJRMjZzdnR2?=
 =?utf-8?B?UXhVNGNsWGMwK2QvNVJWY0JtNTdTZjdseDZMcFlPdnZSVWxKMVdya0cvaGJy?=
 =?utf-8?B?bjlkVEpseVArNysxNElxUzFjOHA2Q1hrT1hIZmdyRDZFQkNzajFqUWFQZFJX?=
 =?utf-8?B?TDZVOXhGMkxSYTdQUDdhM3ZOYlFBSVYxZXpyamNzZGRVZ0NoQjRsZkFsWjdC?=
 =?utf-8?B?YUhtSUVJVlJBZ3N2aytYUU1NOEJCOGRVYUlaVnhKY3dwVWxPVjFoSFRwclBH?=
 =?utf-8?B?ZTFWN1RjSE9uMEVQakpwR0hqZXZ3Zit4NHFNS3IxRG1VTExmaW9yUjlKakNS?=
 =?utf-8?B?L1FibWRRYTZteFVaSUUxQld5akJ4dkJOM0pMS2JybkpyclJ3TjM3NEZITmNx?=
 =?utf-8?B?ZkI0b0JhSDlha1NpWDNzMzNZalpMT2FQYjNDVGlqVHpEczQxemZwV0x0ZVBC?=
 =?utf-8?B?YkZ4a05PMzB6NkV3ZHgxdktGYm5XQmptYlJpN2ltRHpZOE0raWxTUmhqeVZY?=
 =?utf-8?B?NXg4Z3NuZUVNV0Q3T2htbWMvVitMOVRmS0xOaUJoRUhsRVVENkp3RkRpWC9x?=
 =?utf-8?B?VVN3bXQ1WW9hcEMxcmxQV0tGWXZBMHkrNlZvYmxWY2JVOG0yM3d5Ry82dWVP?=
 =?utf-8?B?KzR0V29xTHNpTUxTUjZzWUx6UExNbXRpbEUvRUIzOFh1amRaQmc5SmV2ZUFm?=
 =?utf-8?B?cTNnSWZVcEZyVEpKZy8vWHkveFpaNWpHc2ZDZVNIbFJoazJMV2JWQ2pEcnA3?=
 =?utf-8?B?K3AySS9STURhNHJwbWdBemdJMDVSZjdVWDh1c0NTTHJ4ZzNWQzYrek5MNG1M?=
 =?utf-8?B?UVNnY3Flc3dZbHcrUXliOWYycGtSU2cyMStULzRBcTM3Y2I0NjAvQ1A3T1FP?=
 =?utf-8?B?aGZyTWdMeEpja0UzcFpnSFg1WnVjenRTamNBS1lRWEQyUjlYVjdFa1N0TWdC?=
 =?utf-8?B?bTY2Q3RrZFZVeDJLQTloa0J5MFFhV041aUtpY3h5alZZZ1JCWmJ1UFF5cmUw?=
 =?utf-8?B?VUQ3aGEvVTB5aEFzL2dXVWplSmpVZEpxRFlWUU5BcFpBZlkvTGhRVkY0VC94?=
 =?utf-8?B?SmljNmplZFJ5WU5yV0Qxd01tVCttNWQxUHYwWGduWDV6eUpzRXFyRk5DTHhQ?=
 =?utf-8?B?Vk5JcE52UmtHTmw1STJaaHBVN3ZIMzVhTjNxODRIU3k0cDVsV291Qnd1Snp0?=
 =?utf-8?B?Ui9yOGNVVmtwZTVqVGNTNW5jSmp2bFlWeVVHK3VZMGUxS2dmTWRhcjYzd28r?=
 =?utf-8?B?azk5dVZmNS95eS9xNGcrbVAzeVVEeHVrR2hncngybjlYeXpPdTByZDlxZlg1?=
 =?utf-8?Q?L2AsfvpmDCikMTtK2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e744d91e-313e-4636-1a6a-08df29e1ddd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:56:57.9573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvqMvfBbsCc3qotpESlYmY+kar+AflIiSE8e9NHwgc60xmCBvxwncxYrk/deaFco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

On 10/14/26 11:02, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, October 13, 2026 5:26 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
>> failure
>>
>> On 10/13/26 10:24, Prike Liang wrote:
>>> On userq eviction failure, the suspend worker waits for reset_work
>>> while holding userq_mutex and inside a DMA-fence signaling section.
>>> This makes eviction-fence completion depend on GPU recovery finishing,
>>> although recovery can itself require memory allocation and eviction.
>>
>> Absolutely clear NAK to that!
>>
>> GPU recovery is to unlock memory allocation and eviction, so it can *NEVER*
>> allocate memory nor depend on eviction to complete.
>>
>> This patch here is just utterly nonsense. What we need to avoid is to touch the userq
>> mutex and/or any eviction fence from the GPU recovery.
> 
> You're right, the current lock ordering userq mutex-> reset semaphore in the userq eviction signaling path does not need to change,
> as it matches the order declared in amdgpu_lockdep_init(). On further check, the VCN/UVD IB test may perform a memory
> allocation with GFP_KERNEL that triggers reclaim during GPU recovery. We may need a follow-up patch to address the resulting potential deadlock.

Yeah that is a really good catch. That needs to use GFP_ATOMIC so that we can use the emergency reserves.

That should probably be ok since the memory is immediately freed up again.

Regards,
Christian.

> 
> Regards,
> Prike
> 
> Regards,
>> Christian.
>>
>>>
>>> Fixes: c8ed2de0f2ee ("drm/amdgpu: rework userq reset work handling")
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 12 +++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 10 +++-------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  2 +-
>>>  3 files changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index 082d045edf45..c2d1bc7decba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -65,6 +65,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct
>> *work)
>>>     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>>     struct dma_fence *ev_fence;
>>>     bool cookie;
>>> +   int r;
>>>
>>>     mutex_lock(&uq_mgr->userq_mutex);
>>>
>>> @@ -79,21 +80,26 @@ amdgpu_eviction_fence_suspend_worker(struct
>> work_struct *work)
>>>     cookie = dma_fence_begin_signalling();
>>>
>>>     ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
>>> -   amdgpu_userq_evict(uq_mgr);
>>> +   r = amdgpu_userq_evict(uq_mgr);
>>>
>>>     /*
>>>      * Signaling the eviction fence must be done while holding the
>>>      * userq_mutex. Otherwise we won't resume the queues before issuing the
>>>      * next fence.
>>>      */
>>> -   dma_fence_signal(ev_fence);
>>> +   if (!r)
>>> +           dma_fence_signal(ev_fence);
>>>     dma_fence_end_signalling(cookie);
>>>     dma_fence_put(ev_fence);
>>>
>>> -   if (!evf_mgr->shutdown)
>>> +   if (!r && !evf_mgr->shutdown)
>>>             schedule_delayed_work(&uq_mgr->resume_work, 0);
>>>
>>>     mutex_unlock(&uq_mgr->userq_mutex);
>>> +
>>> +   if (r)
>>> +           amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
>>> +                                        &uq_mgr->reset_work);
>>>  }
>>>
>>>  int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr
>>> *evf_mgr, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 3fe91fdafe55..5fef0cc7703c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1308,13 +1308,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr
>> *uq_mgr)
>>>                     ret = r;
>>>     }
>>>
>>> -   if (ret) {
>>> +   if (ret)
>>>             drm_file_err(uq_mgr->file,
>>>                          "Couldn't unmap all the queues, eviction failed ret=%d\n",
>> ret);
>>> -           amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
>>> -                                        &uq_mgr->reset_work);
>>> -           flush_work(&uq_mgr->reset_work);
>>> -   }
>>>     return ret;
>>>  }
>>>
>>> @@ -1334,10 +1330,10 @@ amdgpu_userq_wait_for_signal(struct
>> amdgpu_userq_mgr *uq_mgr)
>>>     }
>>>  }
>>>
>>> -void
>>> +int
>>>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)  {
>>> -   amdgpu_userq_evict_all(uq_mgr);
>>> +   return amdgpu_userq_evict_all(uq_mgr);
>>>  }
>>>
>>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct
>>> drm_file *file_priv, diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 488dc21d7c81..4dcf6151de6a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct
>>> amdgpu_userq_mgr *userq_mgr);  void amdgpu_userq_mgr_fini(struct
>>> amdgpu_userq_mgr *userq_mgr);
>>>
>>>  void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
>>> -void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>>> +int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>>>
>>>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>>>                               struct amdgpu_eviction_fence_mgr *evf_mgr);
> 

