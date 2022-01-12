Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE7AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924B610FA29;
	Wed, 12 Jan 2022 13:01:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C55B10FA29
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 13:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUAeNlxBpQ7ddcDRfJq25ToBqRK226IDIaHrXpiEJb4iY7b6zFnVIzo/LgINFehY8xF+XSrKyBubXG1po+7wJ+sn2TJhXdxHq1qbMlQTSW2gWJfquqbxiXOv4kUufMwVbpQHbju0VZ+dib5HAWUbwCSqIWBazDneeCCnRPE6QkXMsVYvidvKSLAflMdmcV5WvMIfHKOW+thsZgxVKptcccvj4kpIC+U0tD+GhKFj1E5rrNw711hLHsTp8FkiUaSzvyHVRsIrRuw/rY+9DF+ifPFeqDqjGXDgV/VspcKggRMreVU2eeTcw/BEWtFDEK+PSsNz4p9V1QvPCvgpkNPBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFNnB5mq4EZKXDl8ct8dF164ngiyA3VmHhVqy1yYlHc=;
 b=Vd+Y8kouU9w8+hUe9HlnSThw/Mo+wx1FxMvCGeOWL/cc+WsVvrqSiGiGc7Rdamhcn/UXNDvDcFN2wOaxAlneh2QbViEe3IYtPrLivdBtlhQsCA9GHiy6/vd6rpSQ2xsiBR24+OkGfWxO8ZrCkkvX+wT9wD8ElQZF5GXxkc+KTEocUpTNpX2sIvzl3qSdoJ7P/a4O/yfpt+fW3X/mb+X4Nooix1sNg/of5OS4fZchtvnQm2WN4AJ9bGHI13KXMdNKrgUHnlB9s+FFnH/4dmO8fK8PEzQWO3VYBw6NXr0SwSKyogui9YpeK3HjEHX542EdHSNewHHeyZVQkPG6eigXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFNnB5mq4EZKXDl8ct8dF164ngiyA3VmHhVqy1yYlHc=;
 b=B8XgM4zIoUAWhGylkK4BVD01/MOMcNu9tZu5WAffgOs6u6Dupsi5zOdO91TLldvTMRYwSAg9YaTBNaV1tbH8HSA6Fp3B5QCeeWbmuQF1sXgGRg7a1VY5Fxa8lTqeL0R2t53v58D6w4zKjqBhlXtShA5861l0cqxcS9no4GQ2xpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 13:00:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:00:52 +0000
Message-ID: <f10b8279-fce1-ca17-b6dd-0108e4d1793c@amd.com>
Date: Wed, 12 Jan 2022 14:00:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
 <1b35f6db-d101-519f-aac9-f30380fbcb34@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1b35f6db-d101-519f-aac9-f30380fbcb34@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c60c7ec-9df9-4dbd-adc1-08d9d5cb900e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174FA748D9D36EE0AF196DAF2529@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUDktVn1rvoEnJ4KeECUOk9LABmD8ZgfjgbURGKESumPxQZPwSZmZOsDsLv3ThrPcm5c8IsjLuVg6hR7BwWpT/7GCb7Lqy2i4iETuIeZJoKXdrKoRxPTG9LoQAibRflQVAUmQd9RiWBYvORKvlj5ZAXCRzsvFhFInxzDO6y1/5WBZpJoHYJBv6EkcEbNixKNByFjPMzC610xFZZHk8r8AR7zIa55pWENSdgIybhT2DcJIOJkgeF28vlqm8RJ47R8za5+HTi9cquijDowXqB+PJYj9FZuckz9U1UAuxxhPS5Orzk42vQjDG9hN8T3RwvTwUJug0PVO15NgXWTo5txCPfEaWLpAvX+OBNBA0Z5WfHw6A9JmY5kjElfsJO/Nhb0xwxsBU8eXFUUe3YgcbI65z1SA0EAI1vvnl3hhcKr0P07kIUsWpQrclWWjG1UOR9ZvgUSpHthPZpzfAD6KOgfnNuL3B3u5bQ7Q0icKMxOgNWB7LTmEWz9MX1Y5KVJDipMP3e7CCrCqvoo+0wF67sabaTm7SCwaw5LK1hjqrfXx/W5ll7UtFlbN4McQQpLKdEIkOkewzL9IURnaFalFr+xl+1HWD74a5TV9337ity/qsxVB7/qCO9b8Ep+O8IVL/NwX3+8cmr/aP9PKGWCZDP6DJ0aRfNq6uZF7LTIZPrZ0HWF5jub+0qq6jcx+pse1CLg2Zu/0wnBodeOspqmvYSHdeiqchgYoZoIz1fMxEbhV3IxMECQ8D6yUrxsIdrEJpPP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2616005)(6486002)(508600001)(31696002)(316002)(36756003)(110136005)(6512007)(31686004)(83380400001)(38100700002)(6666004)(66556008)(66476007)(8936002)(66946007)(2906002)(5660300002)(86362001)(186003)(8676002)(53546011)(26005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHNhdUViYVpLcHRQdVFDb05RUzhZaHhqeVBFcnA5anFaL0RQem9LVEVxNDZ1?=
 =?utf-8?B?clRBdU5OdGZUS1lFK05DNnJCbkx0Wm1QT1J6U1Q0bXFtR29GcEZQMVA0bUVm?=
 =?utf-8?B?Qi8rL01LSlMzZkpxN0Mrbm1xNkxXNWJLVFFzKzgvUnk0anMySnh6dmE5dkdQ?=
 =?utf-8?B?V2FjWDJmT2dMTDMrd0ozMjJ2K1NrSFVmelpiZ1hzQ1luZ1lzZWdCZDYyY3J3?=
 =?utf-8?B?WWVNSVBCR1hDTFgzZUNkNnp5V2xyYkMyV29Yck5iUE51K1FIZHFiTVV3N3Zr?=
 =?utf-8?B?SVhoUVIxRmhRVEUxMkRVRmxOMnMwTkU1U0hvVVRTZGdWc3JyMVhTUmNFN2Js?=
 =?utf-8?B?RlpLeVZpYVM4aGY2V2NMd1Z3MWthQ2tBYis4RjBFOERKZG41QWFhOFljRks2?=
 =?utf-8?B?RzI0bm9FZDltb1Y5MHo2N01hZkZpREdLc3puc0lVaTVYbWszNFlMb2d0eE1J?=
 =?utf-8?B?dzEyRGxKb0dSTnEyamZoZ09la1R0ZUp0MG9tQWc4a0kwRU1lbTRTejlrK0lv?=
 =?utf-8?B?cWZvQWsxNUROU1hxVHhvZFkzaVFQYUxROFB1REd5OHdKSHJZSm0zVzdnSER0?=
 =?utf-8?B?OUZqcll5VWR4UUNjRWMwbmJYZUlobm5pcXd0Q3FiMGl4VkFRMS9qU3d0NnNu?=
 =?utf-8?B?U0YwQkdraTlBQURjL0trOXErc01pUnM1U2FscGJ5bmMvbllJL3BFT2tjN0Rp?=
 =?utf-8?B?WGpjSUJVSDh5QnRhV1JXU1pkaWZpaTZsR0ZSeGlEeHE3ekVvTHpkbmRqQmdH?=
 =?utf-8?B?U1RCRDlncE9BTnlmNGYvdGhsTVdyeHJMQVRUODNIcGpSd1dvcEVxMjhHSmd1?=
 =?utf-8?B?ZmZCZ245cnU0cFJhZEhaSldBRWc0VlV2bjJoZW1IMGdDaVJRd2NjbkNGNjhK?=
 =?utf-8?B?U3o3bXZvdEU3NHZ4aUVOS091NEEzMHVZb1FKUUJ6U0V6TjlrNmlQNmZWcW9T?=
 =?utf-8?B?eTBrTjg1YlU4elJRbHkrUDNvUG9FRU5kcUI3bU4yT2JaWHBwcWloWDBzdnlO?=
 =?utf-8?B?MWtKUEROc3l4dFMvbU5wSTRMSzJpRC9oNG1SU0k3d3JiTWtVTzhkSHR4WTdU?=
 =?utf-8?B?WEp5ZmptemFONWNmenV2MjQxNXlZdk90S3d4Q3Q5NUxBeGtNaXowNnhuL2pk?=
 =?utf-8?B?YStYTjA0cWowUlNNb3lqa3FqT2xvaCtHbW5Lejh5bk1zbTRGU0VtWmUyV0s1?=
 =?utf-8?B?RWE4c2doaW5mdFE1Q3c5by9JcE54aitsTVpueGl6WHRqbk1FQzdqaWFYbmo0?=
 =?utf-8?B?NU5aUW9HNHl5bElvYzkreVovRGplRHZWWEpHdTdULzkvcjY4eElNcWZKNEtC?=
 =?utf-8?B?REE0KzVPWTJXc3puS2JmS09wUjlKTU1yNUx0Q0pVbkkweXNxTnJ1NGVDV1JH?=
 =?utf-8?B?N2NLcUgwZlprYStlc0YzeE5pWXR2ckRuL1pIZHdwWHIxUEhaWjZSeHJFeHJx?=
 =?utf-8?B?R3REVEI0Rm92Z2E5Qm1vVDMzYmJxWjQxQnVLZkJtZmMwZ3FZbklvRkQ4cTFm?=
 =?utf-8?B?bkx6TWppN2E5c3h0UkxMNzQxWkxUR0ljQXpGRHRENFhpUG1IeERWVXU0Q0RJ?=
 =?utf-8?B?eHNOL3UwajBodFF4cjExMzFaYnhzU0JiWnZoVGd0TGVkZUJQcXZUY0xBaHF1?=
 =?utf-8?B?TGEzTVNZK3BsVjFpa3pLYjdZVkhtQklXMnJnNm1IbmYvOFVpTFZod1VrYW9F?=
 =?utf-8?B?WTFyWW5qcWc2QTBrVzhYckNFYTFVOHZjc1NNM2Y1NXJxbUkxUTRSUUk0NE1V?=
 =?utf-8?B?aTNMOUxFQklweTZ1VlVROXJBOC9ZMUdqaHdkZ2FGTXVKQm85b0JFK29zZXZ3?=
 =?utf-8?B?eVFyTGNPYnpyV0s1REx5UElJWFlYRnltQSt4Zy9TSzhpeUNKcVFXTTM2bzgr?=
 =?utf-8?B?cTRXU1Z0bnhydzlFTlNkMXptaGJnRHprTklLaXRDMUZHQkJ1Y2JFbzh0TFNK?=
 =?utf-8?B?c3Yvamd4cGI5ZTBzZUNyOFFCV0lhQXEzMEVZWjh6aUJYdUdSYzA2RzVXREI1?=
 =?utf-8?B?T3BMTzMva3FDeDVUMUNmQm9kYk1acUpnSnNmdEI2cVZFUFV4SG1wb0VFZUsv?=
 =?utf-8?B?YmxsYjhienRCT2tHUUljSUs3WFFxaVprL0J4M2x1b2pkSEpHajFiNDZUQjBL?=
 =?utf-8?B?ZHpVb0VEUFpMb1dKenpwaERBaW9vZ1l2WlNHc3RTQndESHNQVkM1Z0EzUysz?=
 =?utf-8?Q?cSMf8OUX9tdAflFBb7tDzOU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c60c7ec-9df9-4dbd-adc1-08d9d5cb900e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:00:52.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHZpSQ1NOchNywQ/rqGS35WGL2/cwHM5J5BVBLY4E5UUqOZ3w6dF5OkOFE/tNOkbFkYaW4wad7CBuGQEdTqoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 12:26 PM, Christian König wrote:
> Am 11.01.22 um 08:12 schrieb Somalapuram Amaranath:
>> AMDGPURESET uevent added to notify userspace,
>> collect dump_stack and amdgpu_reset_reg_dumps
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nv.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 2ec1ffb36b1f..41a2c37e825f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -529,10 +529,41 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>       }
>>   }
>> +/**
>> + * drm_sysfs_reset_event - generate a DRM uevent
>> + * @dev: DRM device
>> + *
>> + * Send a uevent for the DRM device specified by @dev.  Currently we 
>> only
>> + * set AMDGPURESET=1 in the uevent environment, but this could be 
>> expanded to
>> + * deal with other types of events.
>> + *
>> + * Any new uapi should be using the drm_sysfs_connector_status_event()
>> + * for uevents on connector status change.
>> + */
>> +void drm_sysfs_reset_event(struct drm_device *dev)
>> +{
>> +    char *event_string = "AMDGPURESET=1";
>> +    char *envp[2] = { event_string, NULL };
>> +
>> +    kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> 
> That won't work like this.
> 
> kobject_uevent_env() needs to allocate memory to send the event to 
> userspace and that is not allowed while we do an reset. The Intel guys 
> felt into the same trap already.
> 
> What we could maybe do is to teach kobject_uevent_env() gfp flags and 
> make all allocations from the atomic pool.
> 
> Regards,
> Christian.

Hi Amar,

I see another problem here,

We are sending the event at the GPU reset, but we are collecting the 
register values only when the corresponding userspace agent calls a 
read() on the respective sysfs entry.

There is a very fair possibility that the register values are reset by 
the HW by then, and we are reading re-programmed values. At least there 
will be a race().

I think we should change this design in such a way:
1. Get into gpu_reset()
2. collect the register values and save this context into a separate 
file/node. Probably sending a trace_event here would be easiest way.
3. Send the drm event to the userspace client
4. The client reads from the trace file, and gets the data.

- Shashank

> 
>> +}
>> +
>> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
>> +{
>> +    struct drm_device *ddev = adev_to_drm(adev);
>> +    /* original raven doesn't have full asic reset */
>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>> +        return;
>> +    drm_sysfs_reset_event(ddev);
>> +    dump_stack();
>> +}
>> +
>>   static int nv_asic_reset(struct amdgpu_device *adev)
>>   {
>>       int ret = 0;
>> +    amdgpu_reset_dumps(adev);
>>       switch (nv_asic_reset_method(adev)) {
>>       case AMD_RESET_METHOD_PCI:
>>           dev_info(adev->dev, "PCI reset\n");
> 
