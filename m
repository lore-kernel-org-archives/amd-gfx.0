Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BACC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB6810E138;
	Mon, 17 Jan 2022 10:35:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5EB10E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjqbkOORb6cPOl58y/9Gmu0pPhS2fozCFGo3NaxtKLO7EN/YLvYtnbabPEMYUKc3xub10wJ4JyftHIon3OZOLHI2Py3KrWkWv/zJNZECL9IQOHjTyKyfdFg864CAzkexBfUpIzp33AggB7VJZwCog413LybkZGe861W4/4BZpdmC1zaAnGIWDecoogMhEpZA9j/gqD1TPpN+e3WJuyC7dScDrd1ecGr9woC61SWR16RXLq0LfXdtU/jaY77075ssW5HRxuD5qUovDBMtj/wfmUI1mAasIad+luz18bZjrGBhbpkjhAt1NJ1/esmLzWwqWEfcLP+3CVN/jwfoOaB4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cqTdlNEF2lozr3Q0ASV1rXxuxCz6GkTqOcHDt7aT7M=;
 b=XVCWe2fTLNJbI1mYXpuXVBVW5ySYpveKYDJQdvTIgdXJ7++/mI82KYnYbtCeakHOhqJv3etE0C+bgab3w8tr0xnV3N/y84LJWJWoFHhgce7TJn93p/uoO2OWc/sO4OX2ljXTc5Dr5H1AtfeTTSz6BosaHfVVJGPOj5hpgbvcg5RQfOshSpOiYYYPcCwjsaFaoRF5LxrrKU7wsxLFEUZtChna+zGb+NlAsEAb+98yA0tw34CvaesN5SdeffNIDm+MRqpqw8xY5OqNx5Rb27k68OUHXFHybRvg4rPFmZpRO7h8NFwPeh7LS4P55wdjPILt0YmI/mwNQZQ9QwymG+BLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cqTdlNEF2lozr3Q0ASV1rXxuxCz6GkTqOcHDt7aT7M=;
 b=aye7fZrNSy4jVmm7d4vinD11a65t2c2/uy1ImCwhy3CsBMo6owYmDjg7aPAuBHr4TqfB+/uKTLY4t2pXf+QyRcrOwc4IN6JzwauxZNo8jsBNSAaPcA42kmvbzLeYkWrd2epzX26laDPI4VssSCzU7UjAGksb00fB1DiVvW1l7qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 10:34:59 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:34:59 +0000
Content-Type: multipart/alternative;
 boundary="------------rWQpY0UsbsBnAWDW300sOorL"
Message-ID: <779d4778-6b85-2769-f169-f5f9e956a671@amd.com>
Date: Mon, 17 Jan 2022 16:04:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
 <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <62372e77-31c8-211f-0d9c-01a0f880badf@amd.com>
X-ClientProxiedBy: BM1PR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::22) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d345c64-8efb-494b-6c20-08d9d9a502b7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27106C60654CA6E68C3C9A52F8579@BYAPR12MB2710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQlrHXh+g1hqZD/FchNsTylWeX0kjvRxiVaA912SdUdSGPeRiwBuFRxi++/1IoUW2m1UAFfJbzCdBGIJMfNdp+KOWIDBpqu/PNToZUA9U1HtPgulnuKJau2B5d18BKqGEtdf1Jl7UTY3XGQ58SnhPFQwpgfYYyLUL/Sp/QSbRCeR/RDb/cfY8tJNnGZjA4THkStAulkFS9vmp5cACkCxbwVjsUbtac4rFOJl6dp7CNIUNNvoC2ivq9Kp/BAl3VfI82Vw9db8JS42mMJVtl124NWHBM+rPMU5+0E9mlfXfCh953u76ZEAIhuWT5jjVuVNsV9f1fEXHzt0Imh8IzQQ3E6OZVHCu3+o54lXgX6zMdmrVCAUpVDuJ1oF3yPftFEj4saTwQxWde+R87pFfc8ypAxfGj9zd8O6DpL/grVXba/vZxXDUfZurao9qZyuuIwfpiI/owUMD0pq5tGEcNt2gb7eba/6iRrOgIfEXMHbFSAHeVR6eM6lPLu5vFjdlh+TY4XnuIN6q15xW/1iBUBlOG2Ofjbfnoxubbw/Q4wApe07wmFkVEJjacBF4DYBgMGF+uj3oVMdZia3QX11mMXutan9oh8nifFJQTBsGYluPOdjcjOLZmTpRdKKVuUTPn3AatbuRS3YxwiSC8eNLfbGAOorzaz88mimkUwdMXpbBAW2BS4WVrBNOHpKAVoLdQdQ2Spz6qExY/R/zZEjfPiT27JQI66zAiWed/dh7FoU5l8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66574015)(66476007)(5660300002)(38100700002)(186003)(26005)(6512007)(83380400001)(8936002)(31696002)(508600001)(8676002)(316002)(6486002)(31686004)(2906002)(36756003)(66556008)(4326008)(110136005)(54906003)(6506007)(33964004)(2616005)(53546011)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNVd2x2U04xZllhSHB4Z0ZtUjFNdEdDT0RMaGpieStudko3WVFETUc3MTdp?=
 =?utf-8?B?RWk1RGtuVVhoc3FMcWFLY1BicFhhQ3owdGZnSkEyR2w5RTd5Y2tjbFJ2cmor?=
 =?utf-8?B?bXJ5cVlyN0JhWXVPNWFPNnJWU2pta1I5bjlTUnRrVzN5MEkvUG1kWlpYa3da?=
 =?utf-8?B?TVQ0bEQwd2YwVjFQRFJIZklTSkxIZTNkeUplZXppOGRmNHd6TmRnWmhsMUhk?=
 =?utf-8?B?OGhsOEJnRnpjUDNkVXhsTms5RFNhaXM0REswdE5HRWtaWTV5QlZCU0hvSkJm?=
 =?utf-8?B?cHo1aTlzRWF0OEg3MTBBei9KK0QvZnF2QzJkUGRMaHdGcHIzc0FJNVJiZjRr?=
 =?utf-8?B?OVFwZ05GM1EzV053M3NEdWVwUUNsWVA2RzZiaGdmME9QK1pPWHBLNVZ0amU3?=
 =?utf-8?B?RnFJeVhBY0VtMzl4Z2p3VjdBYTZaV0RvZnF5djZUQlBUM2JTSmVReXVLWmc2?=
 =?utf-8?B?bGpGUlBvZGQrSWVvK25Oa3JKMjA0WUlHQVZLRW55VWdEVHJRTmM3d29YOHpk?=
 =?utf-8?B?ODlmRGlxcGVLTEE0RWxTOVE0V2ZuVU4xUitKSS9mS0RtZ0IreVNOMGRzZWlw?=
 =?utf-8?B?VnUrRElyYzlNOVM0MWJRR1N0MFVYUG5CRmhEbXVqMFpjbU1qNjRCTkdheXlu?=
 =?utf-8?B?WXJhMVlod3hJV1JiWGhhckRWdXFFT3RUWkRZN1BVdVdnMTl0YUpQR0FUai9U?=
 =?utf-8?B?bEtaNFJKKzVCVEM0Z0c5V1A0ZlV4WEVXUjdxaGpJcGRTekJYeityTGloTVdH?=
 =?utf-8?B?a2JWajgzb3p4UGVvOURvTjFieXZhZEJqWk5saDBza1ZmWFVYeGMxVlR3ZU11?=
 =?utf-8?B?MURsLzdJNnVPMGRnK0pjdzlZM2RMQ3dYK2c2QmhGbFBROVl5RkNOSFVNMElS?=
 =?utf-8?B?RGEvcWFhM1BDYndnSmVnTjJkeVdiWXJrWHZQa0U5em5oYlh1UGExUUdVUXBl?=
 =?utf-8?B?bmRUSjdwRDdSUWVwd1dJSnRYT0lXNW9uM3Jsd05kTUJpMVh6RTA1dEw4UG1J?=
 =?utf-8?B?RG5CSE0rWnRkc3ZqTmJ5Q25BdzFMbjJ1dnJMREVWZFh0ZVMvRCtMZGVkTXlp?=
 =?utf-8?B?UWVGNWRxNU45NFdMRG5YZ25TNlNNWnQrUEFQb0VkR3Zjdm9taDIwMnk0OERY?=
 =?utf-8?B?OEVFeUdPeWhTY3kvcmc0VkRVTm5oT2k3Sk1GQjM0bWNwSTBGbmlxY1BHWE5t?=
 =?utf-8?B?Y09qWW5kZWFndHl3QkNHMG9BUjVFa1ZlZXRKTHJmMHU4VWFjbWZQZzdrWC9o?=
 =?utf-8?B?ZXVuSGwya1RCWFlBNk5nQU5zczNjRWJDdHo0TWRBUGh2RlZwWnhiTlU1U1Fp?=
 =?utf-8?B?d05FQ3RPbnNkOHZkdkdFTDRUQldUQU8xaDhVeXZyaVBHL24rak4zNm1hVXpX?=
 =?utf-8?B?U3ZFWDFEOThneXdHWDE3eXAxMWExdmM2M2IxaEtUeDZnRVBUU04wa0k2emUw?=
 =?utf-8?B?ZGd1NVF6RGhNOVlldnBEajFsRUFmLzA2SmxDVzRNRkRMZkRtT2lsUGNhM3hw?=
 =?utf-8?B?NEtTSzhwUU9BbXZBcmhjU2tQZVU4RFJXemozL0l4YStHKy9FZVNITk1HTHp6?=
 =?utf-8?B?WWZEZ2Z1WlB2dE1MMGpxS2laNW0vbVlSbzhMNU5sZzdTVThaUlAzS1h6RGhr?=
 =?utf-8?B?UTRCOXZ4NDgzUE1KOFlxY2lrSVY0RXJ3bmUzVTM1MlUvZHpnWnFSZXVUTWZ1?=
 =?utf-8?B?ZDZjUUtKTC9HZTRLS3ZPMkR0SWRzV2h2d0xIdUNzUmwvOHZzTXA0bklXWTlS?=
 =?utf-8?B?ZnNWVDhDdElVYTBaRkMwck5haGlIZWh2ZUNreHExeDRjWHNscFc2VkhobGNK?=
 =?utf-8?B?SDJ3bnNYdnZRSEdVV1RJTDNMMHQ3V1ZMWW5LMnFKOStSNzZMeW9LRWRXVlRz?=
 =?utf-8?B?VnkwTDkvREwrckU3QmpZL0FWRGFXRWdVZUpaZGErQXpQNi9DM1hEQ1BkTUor?=
 =?utf-8?B?SmJnVHVoNUhBVW9yWjBidTZrcWhVZU83RXluK0ZzM0dsc0pYeUluOUVxRTZ5?=
 =?utf-8?B?LzJhazlUSzdFMlpKNDBsU0ZucjhmbllXVzMyaVJPb3dWcDR0VWZ5S3dyN29V?=
 =?utf-8?B?a0pCK0pLNWhQU1IzcmZCVFhrcUd1dGRwM281Z1dNMjJaU0lpNEtzZXEvQVZP?=
 =?utf-8?B?SjhCKzdoN2xBYitUZThOQ0FrMUhLTEh4NzBUdzRrSzloZGZVbC8xMHFoOFow?=
 =?utf-8?Q?IVN/G0/Eu0ZBO2m3lCLaovY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d345c64-8efb-494b-6c20-08d9d9a502b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 10:34:59.2260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izA2nrKUd6VQPkRTzUnGwQTiUlRl3YVyCjrfjZRXincGEXNBcPT4y5U3/86ybGOdmjIp5t3BK8oAL9P6qhqpsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------rWQpY0UsbsBnAWDW300sOorL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/2022 3:49 PM, Christian König wrote:
> Am 17.01.22 um 11:09 schrieb Somalapuram, Amaranath:
>> [AMD Official Use Only]
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, January 17, 2022 3:33 PM
>> To: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank 
>> <Shashank.Sharma@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD 
>> GPU reset
>>
>> Am 17.01.22 um 11:01 schrieb Somalapuram, Amaranath:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Monday, January 17, 2022 12:57 PM
>>> To: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank
>>> <Shashank.Sharma@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU
>>> reset
>>>
>>> Am 17.01.22 um 07:33 schrieb Somalapuram Amaranath:
>>>> AMDGPURESET uevent added to notify userspace, collect dump_stack and
>>>> trace
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/nv.c | 45 
>>>> +++++++++++++++++++++++++++++++++
>>>>     1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 2ec1ffb36b1f..b73147ae41fb
>>>> 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>>         }
>>>>     }
>>>>     +/**
>>>> + * drm_sysfs_reset_event - generate a DRM uevent
>>>> + * @dev: DRM device
>>>> + *
>>>> + * Send a uevent for the DRM device specified by @dev. Currently we
>>>> +only
>>>> + * set AMDGPURESET=1 in the uevent environment, but this could be
>>>> +expanded to
>>>> + * deal with other types of events.
>>>> + *
>>>> + * Any new uapi should be using the
>>>> +drm_sysfs_connector_status_event()
>>>> + * for uevents on connector status change.
>>>> + */
>>>> +void drm_sysfs_reset_event(struct drm_device *dev)
>>> This should probably go directly into the DRM subsystem.
>>>
>>>> +{
>>>> +    char *event_string = "AMDGPURESET=1";
>>>> +    char *envp[2] = { event_string, NULL };
>>>> +
>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>> As I said this approach is a clear NAK. We can't allocate any memory 
>>> when we do a reset.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Can I do something like this:
>>>
>>> void drm_sysfs_reset_event(struct drm_device *dev)
>>>    {
>>> -       char *event_string = "AMDGPURESET=1";
>>> -       char *envp[2] = { event_string, NULL };
>>> +       char **envp;
>>> +
>>> +       envp = kcalloc(2,sizeof(char *), GFP_ATOMIC);
>>> +       envp[0] = kcalloc(30, sizeof(char), GFP_ATOMIC);
>>> +       envp[1] = kcalloc(30, sizeof(char), GFP_ATOMIC);
>> No, not really. kobject_uevent_env() will still allocate memory 
>> without GFP_ATOMIC.
>>
>> I think the whole approach of using udev won't work for this.
>>
>> Regards,
>> Christian.
>>
>> I have tested it with sample applications:
>> Gpu reset:
>> sudo cat /sys/kernel/debug/dri/0/amdgpu_gpu_recover
>>
>> And I never missed the AMDGPURESET=1 event in user space,
>
> That's not the problem. Allocating memory when we need to do a reset 
> can cause a *HARD* kernel deadlock.
>
> This is absolutely not something we can do and Daniel even tried to 
> add a few lockdep annotations for this.
>
> So automated testing scripts will complain that this won't work.
>
> Regards,
> Christian.
Any suggestion how we can notify user space during this situation.

Regards,

S.Amarnath

>
>> even with continues resets with sudo cat 
>> /sys/kernel/debug/dri/0/amdgpu_gpu_recover .
>
>
>>
>> Regards,
>> S.Amarnath
>>> +
>>> +       strcpy(envp[0], "AMDGPURESET=1");
>>> +       strcpy(envp[1], "");
>>> +
>>>
>>> kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE,
>>> envp);
>>> +
>>> +       kfree(envp[0]);
>>> +       kfree(envp[1]);
>>> +       kfree(envp);
>>>    }
>>>
>>> Regards,
>>> S.Amarnath
>>>
>>>> +}
>>>> +
>>>> +void amdgpu_reset_dumps(struct amdgpu_device *adev) {
>>>> +    struct drm_device *ddev = adev_to_drm(adev);
>>>> +    int r = 0, i;
>>>> +
>>>> +    /* original raven doesn't have full asic reset */
>>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>>> +        return;
>>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +        if (!adev->ip_blocks[i].status.valid)
>>>> +            continue;
>>>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>>> +            continue;
>>>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>>> +
>>>> +        if (r)
>>>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>>>> + adev->ip_blocks[i].version->funcs->name, r);
>>>> +    }
>>>> +
>>>> +    drm_sysfs_reset_event(ddev);
>>>> +    dump_stack();
>>>> +}
>>>> +
>>>>     static int nv_asic_reset(struct amdgpu_device *adev)
>>>>     {
>>>>         int ret = 0;
>>>>     +    amdgpu_reset_dumps(adev);
>>>>         switch (nv_asic_reset_method(adev)) {
>>>>         case AMD_RESET_METHOD_PCI:
>>>>             dev_info(adev->dev, "PCI reset\n");
>
--------------rWQpY0UsbsBnAWDW300sOorL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/17/2022 3:49 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:62372e77-31c8-211f-0d9c-01a0f880badf@amd.com">Am
      17.01.22 um 11:09 schrieb Somalapuram, Amaranath:
      <br>
      <blockquote type="cite">[AMD Official Use Only]
        <br>
        <br>
        <br>
        <br>
        -----Original Message-----
        <br>
        From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
        <br>
        Sent: Monday, January 17, 2022 3:33 PM
        <br>
        To: Somalapuram, Amaranath
        <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <br>
        Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
        Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>
        <br>
        Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on
        AMD GPU reset
        <br>
        <br>
        Am 17.01.22 um 11:01 schrieb Somalapuram, Amaranath:
        <br>
        <blockquote type="cite">[AMD Official Use Only]
          <br>
          <br>
          <br>
          <br>
          -----Original Message-----
          <br>
          From: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
          <br>
          Sent: Monday, January 17, 2022 12:57 PM
          <br>
          To: Somalapuram, Amaranath
          <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>;
          <br>
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <br>
          Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
          Sharma, Shashank
          <br>
          <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>
          <br>
          Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on
          AMD GPU
          <br>
          reset
          <br>
          <br>
          Am 17.01.22 um 07:33 schrieb Somalapuram Amaranath:
          <br>
          <blockquote type="cite">AMDGPURESET uevent added to notify
            userspace, collect dump_stack and
            <br>
            trace
            <br>
            <br>
            Signed-off-by: Somalapuram Amaranath
            <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c | 45
            +++++++++++++++++++++++++++++++++
            <br>
            &nbsp;&nbsp;&nbsp; 1 file changed, 45 insertions(+)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
            <br>
            b/drivers/gpu/drm/amd/amdgpu/nv.c index
            2ec1ffb36b1f..b73147ae41fb
            <br>
            100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/nv.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
            <br>
            @@ -529,10 +529,55 @@ nv_asic_reset_method(struct
            amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp; +/**
            <br>
            + * drm_sysfs_reset_event - generate a DRM uevent
            <br>
            + * @dev: DRM device
            <br>
            + *
            <br>
            + * Send a uevent for the DRM device specified by @dev.&nbsp;
            Currently we
            <br>
            +only
            <br>
            + * set AMDGPURESET=1 in the uevent environment, but this
            could be
            <br>
            +expanded to
            <br>
            + * deal with other types of events.
            <br>
            + *
            <br>
            + * Any new uapi should be using the
            <br>
            +drm_sysfs_connector_status_event()
            <br>
            + * for uevents on connector status change.
            <br>
            + */
            <br>
            +void drm_sysfs_reset_event(struct drm_device *dev)
            <br>
          </blockquote>
          This should probably go directly into the DRM subsystem.
          <br>
          <br>
          <blockquote type="cite">+{
            <br>
            +&nbsp;&nbsp;&nbsp; char *event_string = &quot;AMDGPURESET=1&quot;;
            <br>
            +&nbsp;&nbsp;&nbsp; char *envp[2] = { event_string, NULL };
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;
            kobject_uevent_env(&amp;dev-&gt;primary-&gt;kdev-&gt;kobj,
            KOBJ_CHANGE, envp);
            <br>
          </blockquote>
          As I said this approach is a clear NAK. We can't allocate any
          memory when we do a reset.
          <br>
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          Can I do something like this:
          <br>
          <br>
          void drm_sysfs_reset_event(struct drm_device *dev)
          <br>
          &nbsp;&nbsp; {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *event_string = &quot;AMDGPURESET=1&quot;;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *envp[2] = { event_string, NULL };
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char **envp;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; envp = kcalloc(2,sizeof(char *), GFP_ATOMIC);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; envp[0] = kcalloc(30, sizeof(char), GFP_ATOMIC);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; envp[1] = kcalloc(30, sizeof(char), GFP_ATOMIC);
          <br>
        </blockquote>
        No, not really. kobject_uevent_env() will still allocate memory
        without GFP_ATOMIC.
        <br>
        <br>
        I think the whole approach of using udev won't work for this.
        <br>
        <br>
        Regards,
        <br>
        Christian.
        <br>
        <br>
        I have tested it with sample applications:
        <br>
        Gpu reset:
        <br>
        sudo cat /sys/kernel/debug/dri/0/amdgpu_gpu_recover
        <br>
        <br>
        And I never missed the AMDGPURESET=1 event in user space,
        <br>
      </blockquote>
      <br>
      That's not the problem. Allocating memory when we need to do a
      reset can cause a *HARD* kernel deadlock.
      <br>
      <br>
      This is absolutely not something we can do and Daniel even tried
      to add a few lockdep annotations for this.
      <br>
      <br>
      So automated testing scripts will complain that this won't work.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
    </blockquote>
    Any suggestion how we can notify user space during this situation.
    <p class="MsoNormal">Regards,</p>
    <p class="MsoNormal">S.Amarnath</p>
    <blockquote type="cite" cite="mid:62372e77-31c8-211f-0d9c-01a0f880badf@amd.com">
      <br>
      <blockquote type="cite">even with continues resets with sudo cat
        /sys/kernel/debug/dri/0/amdgpu_gpu_recover .
        <br>
      </blockquote>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        S.Amarnath
        <br>
        <blockquote type="cite">+
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(envp[0], &quot;AMDGPURESET=1&quot;);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(envp[1], &quot;&quot;);
          <br>
          +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          kobject_uevent_env(&amp;dev-&gt;primary-&gt;kdev-&gt;kobj,
          KOBJ_CHANGE,
          <br>
          envp);
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(envp[0]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(envp[1]);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(envp);
          <br>
          &nbsp;&nbsp; }
          <br>
          <br>
          Regards,
          <br>
          S.Amarnath
          <br>
          <br>
          <blockquote type="cite">+}
            <br>
            +
            <br>
            +void amdgpu_reset_dumps(struct amdgpu_device *adev) {
            <br>
            +&nbsp;&nbsp;&nbsp; struct drm_device *ddev = adev_to_drm(adev);
            <br>
            +&nbsp;&nbsp;&nbsp; int r = 0, i;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; /* original raven doesn't have full asic reset */
            <br>
            +&nbsp;&nbsp;&nbsp; if ((adev-&gt;apu_flags &amp; AMD_APU_IS_RAVEN)
            &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&gt;apu_flags &amp; AMD_APU_IS_RAVEN2))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.valid)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
            (!adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;reset_reg_dumps)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
            adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;reset_reg_dumps(adev);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;reset_reg_dumps of IP block
            &lt;%s&gt; failed %d\n&quot;,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; drm_sysfs_reset_event(ddev);
            <br>
            +&nbsp;&nbsp;&nbsp; dump_stack();
            <br>
            +}
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp; static int nv_asic_reset(struct amdgpu_device *adev)
            <br>
            &nbsp;&nbsp;&nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret = 0;
            <br>
            &nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; amdgpu_reset_dumps(adev);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (nv_asic_reset_method(adev)) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_RESET_METHOD_PCI:
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;PCI reset\n&quot;);
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------rWQpY0UsbsBnAWDW300sOorL--
