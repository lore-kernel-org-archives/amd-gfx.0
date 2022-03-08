Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63A010E535;
	Tue,  8 Mar 2022 16:40:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1900310E535
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUJcXu4cGHXBF3ukd3Ym1syNzcdeFY4tkV4v7H6jMAPYk3OaOuWHsIs2VAS9rhtkamMvWwsZvQUaFERZVM02Pkey6pZvodCN6I5akrtszZ3PCSTKWBrCca72I3SLmBHE+XYQJ/1vsmb8JFsz8kUOUF79J/insF2waOGj/+IzbLdm5ztoFbibXEWPx1rFM1N6DepDHcsztJcS46g18kUuX4nZGqx6qIDJFvOpVXQvcSBBdJ55UEDBARR3k31awABLVhTMWkZrssDSordzfN4BnzrGronR97r7OQLK1LuHKgEcEMtbAmcf7jbmreIJaVBf8ehRF5iZoutZQAjEkn/yXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXICDxeaRaE12BTUAy1AxVOPHyn98b7dNpcQiYNrLgs=;
 b=QSL3iNELcBwokC0exE3RWJSET5jK3zeY78Y+htvOVqOqSsONRY90rYNWoifmppiKiokuCxwndeXEl9JLQ7qO2lYrcTYEpeWMhDX4XzfM2vCbVYyI+hWsUHHJmkT4hfpSty7vbWuJK8vVCoKm9LCFUwZY0ImildRTnSHLuYONDyPuBzSjGPVAdINT9/Ri5QzCBPQGaBN6S1Vc2QnbRbOPu584KnG2seTpmxb2obwpvweCqTa5zFeHT/nD2Quu5wwU1DbOQ6MORPNkNgQfNCARSMD8hsgvyYxwx9oyxVyZr2w2+m2m91VCHHp+Z9s726bs6HJnxsQff4B1PyFpAngETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXICDxeaRaE12BTUAy1AxVOPHyn98b7dNpcQiYNrLgs=;
 b=4AFs2VUKmShhFXOJ6slAdp1jFiEFpXP1GojfDwTjGZDh9KHRgSS9PJXKMz17xhDlYPR+YoUCu+h90vwX12et4fkXw3cU7mt3Roh8pL/F2gjPXPrSvCRZ03dDamKmUuu467OxgkA1fb61+MlkvZraZrJa6/d7XalXxLE5/6ZNI3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 16:40:15 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:40:15 +0000
Message-ID: <4e7494e7-ebf4-e830-95a8-cd9a4fceb2b6@amd.com>
Date: Tue, 8 Mar 2022 17:40:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
 <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
 <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
 <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
In-Reply-To: <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::29) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1af082a7-0460-413d-4e4c-08da01225265
X-MS-TrafficTypeDiagnostic: MN2PR12MB4062:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB406226C7CB7812B2C1CFC151F2099@MN2PR12MB4062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxNoQUXVTqz9yX1FyhqR58ejhaikGCGiEJEqykMLN4IKGva1MhtIdkF9GD7IXI9QHHqnc8QnFuwHFBwEtQSdQ5SP0E9OU55lKb92qUG69CtXhoTsvYBnQZXSBGTLXyC4Jo/qnQkhyaGhnfD6PwSFv/QHxTR4HEgPMn0QoYuhm1h2FQRr7g86nx7L4hYxPt4WAkF+RNGc0fSkAxwJAQzFrKS0BrTUFv/UNM/7ELo3U0tor6H7rwBMCMTVpmOveGHYtWRGhpf2BMF6aEMN9c0LYKbVSo1aSHQj6H616XFVCq/+7W19oOpjIUAipPAk6dcyas2nwJf3QtyDC9GFT3dJBZSHRaVTsfCCSJBPBuymcORHaKYCFplF1Lui0g3Tk7S0vAaONIMvIo2r1tioa/ZI3xuSCrTqjntL+8EWAptg27i3F/++lenkhOdc1niqO7Fsz0QBUHetaAk75ZNF4i1m3vKq1t484XGCcyo3BzsLh6Ts3wzHrQ4u00T5iKA0iWWy196DtsiC1FioJjendiMBHcjzPZLyRSH7Q190n01rGJLhikDPeRVZWTfa6yjzj66/34SSCUpwqRIBl6iBZPEZoJuJ3+DgamYu5IblOBXdIpsxHVtFqKc6Jp0FQ9EcMHPqzich1YFt4GIgkqIs01lABwqHYk1DQS1WqNYF8PWY0+dP/vrEh2H5o2udLiRNLMovFr93wuo5CVj47bkpyv8EVK46vr3vLCrYKN2NEPklQQ1V5K4Q41Fj4KoImHlWG+U6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6486002)(186003)(2616005)(316002)(31686004)(6512007)(53546011)(6506007)(36756003)(110136005)(508600001)(5660300002)(6666004)(86362001)(66476007)(26005)(8676002)(66556008)(31696002)(4326008)(66946007)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckk4RE1CWWRSK28yN25EcTNLaG51ZzMzc3pQbUZ3U2JFbHVlQ0gxaXQvb2Mx?=
 =?utf-8?B?SmJBY1dYMTd2ZVo3TlFCNnltc3FkcERzTTZERnBKalQzL1BpaUV0QTEyTVBj?=
 =?utf-8?B?Y2RZK2p1VVFCWnp1cGt2cC9nWE9jWHVMYkplWHVlTHpwUTdLbm5sWjZXd0xK?=
 =?utf-8?B?dzZYeTE1WlpGTlB6L2g2eWZ1ZWsybVllSWlOaFpkL2cxdk1sRjBwT0xVckIx?=
 =?utf-8?B?T1ZHcnVYWlNmbSs1dzlqMFdtaVMzKzRQdllNUUE4SGxjMEcxZXFxMkpuRnZQ?=
 =?utf-8?B?cnQwZndlZlZpWkdNUkQ1dHlaTTRua3pKSzFFMFpMejhBTWJSZkI0RTlvcmFy?=
 =?utf-8?B?WCtnTElnSkhXZ3ZyWkFzQzFvY1A5MGNUMm83dWh6THRKZ00vbUxyQVordlZF?=
 =?utf-8?B?am5rUVhFdnliK0xQVHFBZnpsZzJpbERrSTY5QmM1RHFlazIya0huOC9Dak9Y?=
 =?utf-8?B?K241azVJbjdqTDN4YnBPckZDMGUxeU1KMUM0a29yOGJncFBXVW5OdVQ0b0pl?=
 =?utf-8?B?Wk1HWm5oNmU5d0xHbWUxa2pjVmtzaU9aOHp6NHhmUXJmT3lIMWJ1Ty9SSkFk?=
 =?utf-8?B?Sk1xV0VJUlFuVDdMTlRRTFlTWnAxWjBzSWhpSk5VZDJmY3R2WTNVT2hjYnhi?=
 =?utf-8?B?YlJ5NENSdndLbm1uc3Y4MWxaMUxjZ21aeTFnNU5QcmFtZDdnaWJnZ0hSQU5x?=
 =?utf-8?B?ZmpKdkJnMDNWK1pXeWtnREZCNm90U0ZkSGVQdENscnk5TXJGbFhDRDluZ1pn?=
 =?utf-8?B?Y3BZZktFeW4vazh0UElHQiszd09ra3FBTHdwU1hGTTRSdEdSUFFRZFZkUDdJ?=
 =?utf-8?B?OHY4RVUrS1pZT0ZTSVowS1pLVmxzQkc4eGRTZXRnR0M3aUQ3UEd6TGtJK2hm?=
 =?utf-8?B?WkhYS1NrOU82YjRjek12OWZCdXNzYmdoYkUwa1A2cHQwVFNrZzVsWUtLT3hr?=
 =?utf-8?B?c1VkNmE5TDA1Q2pKTEQ4RXlQdkh4YVJZWk40MTdyYzh5d1hZekZoN3dqVDNL?=
 =?utf-8?B?RDRlWGw2L1dURjFxMUViMTVjUXkzaUJKSENoa1hVZjl1MmdJVHRMY25oRkZU?=
 =?utf-8?B?NWNaRTgrckhzSVpsNXhZVkxFZXZzbjFhSk16L3NXL2d1VHp6RW5FNG42UEQz?=
 =?utf-8?B?UGRSZmgrTUVEV0FuR2JyNFJNcEh6TFhKT1ZEbzliMTNMdXJXa2IzSXNGeUQr?=
 =?utf-8?B?dEg0dUlmUXZaUGVBSGw2c3NDOVltUDJUU2xGTkpCWU4rNVQvaFhPek1vZkFJ?=
 =?utf-8?B?dlMvU1gwZG5SNWN5aWpoVmhWMWRrcmlidVBPWVVpVlFZVmpRVE83cGRHTnA0?=
 =?utf-8?B?UjFnL3NJYzVqV3ZvUVZVTUZuZTltMldvUWZJay83SE43Y1ZYcGpaaW1mREMz?=
 =?utf-8?B?ZWg5bXdMOGgxUlhEMHQ0VDJvK05Hako1dCtUTi9Ic0dRbndDZ0NwQkJoS1hR?=
 =?utf-8?B?UjZkYnRDWDhuRHZxUW1qTjBBZDlYa3lvVjNueXlKU0lidGV4c3NHQi9JY2tq?=
 =?utf-8?B?dXk3SlE1MXRHcVV5SmlKNGMyVjV0L08yajdFSitCYXI4R1pNbklxV3phTlJZ?=
 =?utf-8?B?ZE1vSVQySCtMUzJQajEvMDBaelVYUkI4Y3VyK3BETWNQeUNBMENqZHVjVXFJ?=
 =?utf-8?B?RkF3czl3a25CQ2JHRURQazFjUzBBYVBxRjdXYlhNMTVaUHBwYjU1dFJMb1lV?=
 =?utf-8?B?UHlkaGRUTUJid1pBTUZ2UzNGR293dFU4YXNIc2h1bVdvWXdScmlSRXUrQ0lQ?=
 =?utf-8?B?cUF2TThKREV0M094cEduMkVrcUhXc0lXSS9LQnJlcklTTGZMd0hROGFkblZu?=
 =?utf-8?B?aFU0WmdJMHhxWWtOVGFXc2UvUDN3ZUx5VTVrRiswWTk3Um5VbFNINndLN3JR?=
 =?utf-8?B?aXdEbkNHeXpMMkx4aVNPSUlydU90QlN1RElYV2F2a3hsakd4UzdJTEtnUG9B?=
 =?utf-8?B?VC9abm14MEQrZHZNSW84WU5Hb25EbEdBbFpnUjlYWlFZTysvS0dzeVBHaWRC?=
 =?utf-8?B?QTBpNVU5VEJjY1NCVHhUUW9DeDkrdS84UlFUZnFHNCtXSnRBb25qOXdmRkVt?=
 =?utf-8?B?UUpjUXd4YVo2SzRqZ0VJSGJmTWRDS2RUcE9peVNlMW1jNmh0UFNVY21hSWov?=
 =?utf-8?B?a3lPUnFWb012QWowMmduMHFaMEVBRDBvVEpIZzRkTDQ1VkNmY1hROVJQQldh?=
 =?utf-8?Q?zk9RrAvylNvPMCOSPVPxtDo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af082a7-0460-413d-4e4c-08da01225265
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:40:15.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P4SVH9EUtGV2CFSK29PyoZq2Pf1T57wPErCxecMidwsv+F/b+lgtgFcsBtv4jKV/hRrAYoa16RwLaXSoHdOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/8/2022 12:56 PM, Sharma, Shashank wrote:
> 
> 
> On 3/8/2022 11:32 AM, Christian König wrote:
>> Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>>>
>>>
>>> On 3/8/2022 8:06 AM, Christian König wrote:
>>>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>
>>>>> This patch adds a new sysfs event, which will indicate
>>>>> the userland about a GPU reset, and can also provide
>>>>> some information like:
>>>>> - which PID was involved in the GPU reset
>>>>> - what was the GPU status (using flags)
>>>>>
>>>>> This patch also introduces the first flag of the flags
>>>>> bitmap, which can be appended as and when required.
>>>>
>>>> Make sure to CC the dri-devel mailing list when reviewing this.
>>> Got it,
>>>
>>> I was also curious if we want to move the reset_ctx structure itself 
>>> to DRM layer, like
>>> drm_reset_event_ctx {
>>>     u32 pid;
>>>     u32 flags;
>>>     char process_name[64];
>>> };
>>
>> I was entertaining that thought as well.
>>
>> But if we do this I would go even a step further and also move the 
>> reset work item into the DRM layer as well.
>>
>> You might also look like into migrating the exiting i915 code which 
>> uses udev to signal GPU resets to this function as well.
>>
>> Regards,
>> Christian.
> 
> That seems like a good idea, let me quickly dive into i915 and check 
> this out.
> 
> Shashank

I had a quick look at I915, and it looks like both I915 and AMDGPU 
drivers have very different methods of passing the data to the work 
function, via different internal structures. Which means it would be 
much additional work in both the drivers to move the work function 
itself in the DRM layer.

To me, now it seems like it would be better if we can just provide this 
interface to send the uevent and its structure, and the drivers can 
collect their information and pass it to WQ in their own way.

How do you feel about it ?

- Shashank

>>
>>>
>>> and then:
>>> void drm_sysfs_reset_event(struct drm_device *dev, 
>>> drm_reset_event_ctx *ctx);
>>>
>>>>
>>>>>
>>>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>   include/drm/drm_sysfs.h     |  3 +++
>>>>>   2 files changed, 27 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>>>>> index 430e00b16eec..52a015161431 100644
>>>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device 
>>>>> *dev)
>>>>>   }
>>>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>> +/**
>>>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>>> reset
>>>>> + * @dev: DRM device
>>>>> + * @pid: The process ID involve with the reset
>>>>> + * @flags: Any other information about the GPU status
>>>>> + *
>>>>> + * Send a uevent for the DRM device specified by @dev. This indicates
>>>>> + * user that a GPU reset has occurred, so that the interested client
>>>>> + * can take any recovery or profiling measure, when required.
>>>>> + */
>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t flags)
>>>>
>>>> The PID is usually only 32bit, but even better would be to use pid_t.
>>>>
>>>>> +{
>>>>> +    unsigned char pid_str[21], flags_str[15];
>>>>> +    unsigned char reset_str[] = "RESET=1";
>>>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>> +
>>>>> +    DRM_DEBUG("generating reset event\n");
>>>>> +
>>>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>> +}
>>>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>> +
>>>>>   /**
>>>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>>>>> any connector
>>>>>    * change
>>>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>> index 6273cac44e47..63f00fe8054c 100644
>>>>> --- a/include/drm/drm_sysfs.h
>>>>> +++ b/include/drm/drm_sysfs.h
>>>>> @@ -2,6 +2,8 @@
>>>>>   #ifndef _DRM_SYSFS_H_
>>>>>   #define _DRM_SYSFS_H_
>>>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>
>>>> Probably better to define that the other way around, e.g. 
>>>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>>>
>>>> Apart from that looks good to me.
>>>>
>>> Got it, noted.
>>> - Shashank
>>>
>>>> Christian.
>>>>
>>>>> +
>>>>>   struct drm_device;
>>>>>   struct device;
>>>>>   struct drm_connector;
>>>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>>   void drm_class_device_unregister(struct device *dev);
>>>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>> uint32_t reset_flags);
>>>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>> *connector);
>>>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>> *connector,
>>>>>                         struct drm_property *property);
>>>>
>>
