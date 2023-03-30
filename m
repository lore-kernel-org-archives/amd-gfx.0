Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE66C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 12:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E0B10E2C1;
	Thu, 30 Mar 2023 12:27:15 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1090310E2C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 12:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc5JPLtmG5A+9+yo2grm0JyAG5YOq4jNcxC3hL1lga63mRMncP9WlMpc8hL5eQPB6glelFZDfpGsutUIIQWzBrLHmbPl/7/r2f0jqK7bTYlrtnU8wpus2pw3huHbgBXNd29zJfybbee8yxWNqjyMIXaf6p74VuYUGCZVfTa9pYaT0uI8dD3ikNAhXHRyDXKDZ8hasJ5+4brkM1N7tgJiNZggoYk/JN3/qe88ATdKdA7n09Qy3qyVYvHrB3rD8V67ILunQvumN8eFnhYeNeQ0FmsEs2G5DovkP27Srn2ql0xSuvmOPaGk5YsnOPxQAHTEkB6Z/NNH6dZswb/eq1oXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYO1HuBbvabqcmNb5KhDf3QUup4HPGp8KTBaRceZaJQ=;
 b=eM7gSjCvbSTIHn+x8xGVVvQOMheTuWFnppjBGQBBwx90BVz8oVbLC4uGcjqxwNVFlaOvZoNAKY7PDP3nIQEGwpc06ZmGYaDZLmPSKC3rPE0LvwddifiAuBFcgN/eSPkPJwdSRdwThzV1GqRTZFLxPN9psK0dS9QjaDRryBeWwa5UVBowWLHCSS5JhmHUkKoi3y5LWOgsoBH24aT31EAv3DDeqQJnUYscIzqRIKN7srz6h8h2MtrAUwnetleM0PpqtHSSmr2ZYkqwpcFfQ4ULWSAS6yNme2Drk8wlDArEkUN75Wig2Un5GlL3OKyLbjiY3LMElNE1xiaffYlcpHUo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYO1HuBbvabqcmNb5KhDf3QUup4HPGp8KTBaRceZaJQ=;
 b=uXcOUtsuprzN+OgEjnYE1YDCQ9WckPXnAYD2izPoCub0WvTN3IDbtHUUjVfzOK1vW3G17hK/piwp599I9d3IxinXrnZcmEQY2dxM0347yDbN+MUSBSTNxBtMQ7SdHihp+hzQauI7BIovktgpfVvaPAgyD3fMGuPsyZ1XkWooJbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Thu, 30 Mar 2023 12:27:12 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 12:27:12 +0000
Message-ID: <ed7db628-3749-d109-73b3-aac9f04baf62@amd.com>
Date: Thu, 30 Mar 2023 08:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <aff27f2a-a878-be69-fb06-74f2063997f9@amd.com>
 <SN1PR12MB2445C6C12FC1824D4A14124DF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
In-Reply-To: <SN1PR12MB2445C6C12FC1824D4A14124DF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::21) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 766a7bce-69eb-4d20-030a-08db311a16c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xsca7BrKJ6o8rMkJgYlXunwPpK+zKmt+sGdebezj3xNtpLQbnj3afelz/nnC0USjXJVXj1MJBriqdVA7b+42UdEs51Y8c9tMSsH1mORQKzb8blnBznDCHt7pIA/1hjaKKVJSEmqRLi6DqVUlmPda7BZ0wu67fehmnw1nYr9/UhNEg9CQA/Q5MOZ2h3CnG6DO750a04FB6eRuMqt3OVFtf/Et6BU/grXJ/Rto9i1GOl9CgDaBuKCjaO9xBZn89ljs1qmi/9MphqCf13m/+5L8HiMkr0TF7qEJ+dkX6rIKYePlnLxglKPm+54dxoHFzVGEc1Vl6AsW6zVhN/4KMWSCCRmUyVQj/80V8/wvFDG9gS5dRu8QYt9bLyiqEucs0VvKeLp8EJdZF4+VqytRMbIpA8+mGHgze3Lk3xng2E9c1eS/QM/qCK7HoWZHGBK/hZgC+KhNNfESHdsUrJhhb93fExCdHQoQYWpRNnKW7h+4vBUlzVVp4qr8ANhcXcCU86cXSEAO7kCTSOLzQSF9k9bo9/TB6HuBumOD+1jU2bwsrCWVhHg8V50LUjgc/63JcNDmflc1lhLYnfnTKU1eWTllc6Fl5xAtIWr/xLzujhIXDrln6jSmp18ct/eYC1+AiZtzBsKr7InvfCg8HhSqfPgPtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(186003)(55236004)(110136005)(31686004)(53546011)(38100700002)(41300700001)(316002)(5660300002)(2906002)(8936002)(6506007)(6512007)(44832011)(8676002)(26005)(83380400001)(66946007)(66476007)(4326008)(6666004)(2616005)(66556008)(31696002)(86362001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFR0SVlmVFBjYWdEcTFIZWFaMldIN3VnT1BsbVd0T1F4ZTNwRDREZE5EZE13?=
 =?utf-8?B?Rkxwc1V4ditPN0tHMzA0TXpYTVBVU0Q4NTgrTkNXOS9mUEhSckhkWEFYdW5p?=
 =?utf-8?B?MmhCenJHSjNRbFlrenB1RWJ4Qmh5Sm1kcFNFN1huZHRJNDlIQWU3MCtuR2RT?=
 =?utf-8?B?bnRKM0ZndFd6TDVRR1d5R1BnVFE0N20vbTNoZ1hmcjd6WXNMQjBIVGtyWkM3?=
 =?utf-8?B?cHRmbDZqSUFmUHlFTklPdjBVU0MzWXNpR1I1ZTRDTDhQcUw0a0VjTUl3dnhX?=
 =?utf-8?B?V3YybGh0bjZhTVYrZDZibWc3cFFFalBBWUdDeGZ4c0xqVHlBb1dLU2MzRzdN?=
 =?utf-8?B?K2lRK25sYmQ4Y0Z1cUlEcEo5RHZmQVBFSDZkMWR4eGpISEgwczBCR2t3RGdq?=
 =?utf-8?B?Zks3MkhSalNwOFZOcG5YL2NreVRJM3Q4cEdvN0d4ZXUvUG1JeDNzM3pVNGZG?=
 =?utf-8?B?N3B5WVJMVEQ4Y2ZKVFlzMXF1TXc0RTJQdlBZVXUzWC9oOFZ5Z1ZGdFdIWkU0?=
 =?utf-8?B?d3hjd2Z4V2hscTdWTC9jdFJYTDdlQkl6OUp1RVJDeDJVS29kRlpKSkVLcTVI?=
 =?utf-8?B?TFNQTDFtTzhSZ0t5aE5wWWhCUGw2NmZHdVJib2plUTRZdnFhWHJUMzRhR21N?=
 =?utf-8?B?Z3E5R2RVdVhvRHdFUFBEL3JyaVMxd3Nkcnc4SWlGMm9EdEMrRkIyVmd6MDNs?=
 =?utf-8?B?czdKRlJ0bmJlcE5xdURtd0tzVkhUaGF1SEIxU2V1OU83dXhaN0FvcDd0ZEJ0?=
 =?utf-8?B?TjI4NHMzSFpSSzA2Y2tVdHd5UHMwMTMrZmVweG1neHJaSHJkMjJQSUlGSGtI?=
 =?utf-8?B?RHJkOTlZcEZERktBQ1ptc1hIT3VKd3RYcE1RWW9GQWoxRmpyMGYwUzdnU3pm?=
 =?utf-8?B?Q2tqM0F6aGtRY0JmaTJ3TDZlMXA1Tys4Skl1OTUvTk5KTURVZVkyOC9MeEZL?=
 =?utf-8?B?UXJJeW9qdkkyR2plTlpEOWE0bDk3d1dVVWszWSt6bm4yajhqSkdjQzY3Wmps?=
 =?utf-8?B?UWVhR0RBSThIMFNHcUx0V0dzSXB2NGx0L211OUZKVHI5U29acWZWZ2FyNE9O?=
 =?utf-8?B?ZkZrUkZNbTk2TG0vZGJmTnVOMTErOVllQURxSjgzaUxBZkppV2FUZDBPUXBJ?=
 =?utf-8?B?ZzlqdCtzUEFoTHllbkEyQXdZS2t1ajRlZG9hNkpIVHdmQjluWTB0V3F4VnBy?=
 =?utf-8?B?SnFXNllXVFJmZnVKV0tpNXZtMVJZMjh6VGRPMXdXMHowOVV5NEc2V0NWZTlX?=
 =?utf-8?B?cDBGNWw4MFo1N0NaMDB5YUtadStnbnJaNklvVVBMVWZvRy84RTN1VnFTaWp0?=
 =?utf-8?B?ZWdnb2h6VUMzWktDS01sMDM0eTZkRUVKMDFiNU83YUhpR0NOTTFQcE9BYkFj?=
 =?utf-8?B?RjZ0ZngzV044UjUyb3ZKK1VVUmRiK3BjcDZzZE4zUXY3YzBrcWc3ejBNSmVG?=
 =?utf-8?B?N3lIdlgxd3pocjlSeGFlZnRoSWlkU3JvS0FScHBGQ0lXNHg2TnZQbmZoVFRT?=
 =?utf-8?B?Uk1tdkhlM2o0cEZtS1JBa2FCUWdrVzc2Uk5YQnNKd1I5SmNrcE8rOHhpMktV?=
 =?utf-8?B?cGY5TVJQV3pjVW0yTUZnWW9DMDFQYWxpRSt4QnkvMVc0b3R0NU52cXd4Q0NU?=
 =?utf-8?B?RWZtblJjUFh3VkRweFJtWVdDRVBIVDg2VVVFWWkvUHJSQ0FMcWV0aFQrb2J2?=
 =?utf-8?B?clRTNy9jaVhvNTRUcDE2Ti90T3VrNjhEWWduOXZpaWVhUUtleStxNHVlMzNK?=
 =?utf-8?B?UUtlTDU1cDRvamJDcHRQRUpSY3ZRaG9aaitmMVMxVWc3dE1xNzgrR0F6Q2pk?=
 =?utf-8?B?dlRtcHF0Q3p2MC9LNFFDQ1MrVEd4aVY5NlZJeUJERURRNlBNTFMxQzU5eEov?=
 =?utf-8?B?enBQVVIwTTRxSGdwZlY1ZkwvQ2ZYYjN6eUJTbUcrZzQ3bVdrUUhXOUZQalND?=
 =?utf-8?B?cWNNaEhud2hiRVBVeVRtREF2WUhqdkpPVTZjZUJBbHQ3TW5jSitiNmNWRTVU?=
 =?utf-8?B?a2xDcm0xMFRDOG9QVHpMMEYwck1kMURia2Z4ZHBLRlVJdVMvV3lZdE5pMFcr?=
 =?utf-8?B?cVIwRjlYWFp5azB2M2VVZ0hUWFoxNGFmKzJvU1g1TXpjUU1VUnBZeEZ2b00z?=
 =?utf-8?Q?hJZT9b4p47TwLGLm/aspL0Xza?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766a7bce-69eb-4d20-030a-08db311a16c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 12:27:12.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMjzHOm6MmW0Vziw+GrWVDLF3iBRG7eySYNaoJ2jTSfNHNHAgJTOXEvJkCZcPC/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alan,

I'll comment in the other thread, as it seems Christian commented directly to your
patch the day after my comment, rather than following up with my email sent the previous
day and we now have two divergent threads where you post two identical comments, and it shouldn't
be like that--we should have one thread only.

Regards,
Luben

On 2023-03-30 04:59, Liu, HaoPing (Alan) wrote:
> [AMD Official Use Only - General]
> 
> 
> Hi, Luben
> 
>  
> 
> Thanks for the review. Please see inline.
> 
>  
> 
> Best Regards,
> 
> Alan
> 
>  
> 
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Tuesday, March 28, 2023 3:00 AM
> To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
> 
>  
> 
> Hi,
> 
>  
> 
> That's a good fix. Some questions and comments below:
> 
>  
> 
> On 2023-03-27 11:20, Alan Liu wrote:
> 
>> [Why]
> 
>> After gpu-reset, sometimes the driver would fail to enable vblank irq,
> 
>> causing flip_done timed out and the desktop freezed.
> 
>>
> 
>> During gpu-reset, we will disable and enable vblank irq in
> 
>> dm_suspend() and dm_resume(). Later on in
> 
>> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and decide to enable or disable the irqs again.
> 
>>
> 
>> However, we have 2 sets of API for controling vblank irq, one is
> 
>> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> 
>> its own refcount and flag to store the state of vblank irq, and they
> 
>> are not synchronized.
> 
>  
> 
> Is it possible to reconcile controlling VBlank IRQ to a single refcount?
> 
>  
> 
> In struct drm_vblank_crtc, we have “enabled” and “refcount” to store vblank irq state, and in struct amdgpu_irq_src we have “enabled_types” as the refcount for each irq in dm layer.
> 
> To reconcile vblank irq to a single refcount, my idea is to remove enabled and refcount from struct drm_vblank_crtc, and add a callback function like vblank_irq_enabled() to drm_crtc_funcs.
> 
> Drm layer can use this function to check the state or refcount of vblank irq from dm layer. But it may be dangerous because it is a change to drm layer. Do you have any comments?
> 
>  
> 
>>
> 
>> In drm we use the first API to control vblank irq but in
> 
>> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
> 
>>
> 
>> The failure happens when vblank irq was enabled by dm_vblank_get()
> 
>> before gpu-reset, we have vblank->enabled true. However, during
> 
>> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
> 
>> checked from
> 
>> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq
> 
>> again. After gpu-reset, if there is a cursor plane commit, the driver
> 
>> will try to enable vblank irq by calling drm_vblank_enable(), but the
> 
>> vblank->enabled is still true, so it fails to turn on vblank irq and
> 
>> causes flip_done can't be completed in vblank irq handler and desktop
> 
>> become freezed.
> 
>>
> 
>> [How]
> 
>> Combining the 2 vblank control APIs by letting drm's API finally calls
> 
>> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> 
>> synchronized. Also add a check to prevent refcount from being less
> 
>> then
> 
>> 0 in amdgpu_irq_put().
> 
>>
> 
>> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com <mailto:HaoPing.Liu@amd.com>>
> 
>> ---
> 
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++
> 
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14
> 
>> ++++++++++----
> 
>>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
>>
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> 
>> index a6aef488a822..1b66003657e2 100644
> 
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> 
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> 
>> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
> 
>>            if (!src->enabled_types || !src->funcs->set)
> 
>>                           return -EINVAL;
> 
>> 
> 
>> +         if (!amdgpu_irq_enabled(adev, src, type))
> 
>> +                       return 0;
> 
>> +
> 
>>            if (atomic_dec_and_test(&src->enabled_types[type]))
> 
>>                           return amdgpu_irq_update(adev, src, type);
> 
>> 
> 
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> 
>> index dc4f37240beb..e04f846b0b19 100644
> 
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> 
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> 
>> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct
> 
>> work_struct *work)
> 
>> 
> 
>>  static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable) 
> 
>> {
> 
>> -          enum dc_irq_source irq_source;
> 
>> +         int irq_type;
> 
>>            struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> 
>>            struct amdgpu_device *adev = drm_to_adev(crtc->dev);
> 
>>            struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
> 
>> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
> 
>>            if (rc)
> 
>>                           return rc;
> 
>> 
> 
>> -          irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> 
>> +         irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
> 
>> +acrtc->crtc_id);
> 
>> +
> 
>> +         if (enable)
> 
>> +                       rc = amdgpu_irq_get(adev, &adev->crtc_irq, irq_type);
> 
>> +
> 
>> +         else
> 
>  
> 
> There's an unnecessary empty line before the "else". It's a good idea to run patches through scripts/checkpatch.pl.
> 
>  
> 
> Thanks, will use the tool next time.
> 
>  
> 
>> +                       rc = amdgpu_irq_put(adev, &adev->crtc_irq, irq_type);
> 
>> 
> 
>> -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> 
>> -                        return -EBUSY;
> 
>> +         if (rc)
> 
>> +                       return rc;
> 
>> 
> 
>>  skip:
> 
>>            if (amdgpu_in_reset(adev))
> 
>  
> 
> --
> 
> Regards,
> 
> Luben
> 
>  
> 

