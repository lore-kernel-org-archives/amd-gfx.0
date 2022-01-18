Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 10:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC4CE10EA69;
	Tue, 18 Jan 2022 10:40:42 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B982510EA69
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 10:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExnVunAfnjaanjwM41r7+kAAAOldEzogka3usIgdcMdoAfkpAMx6hiH+uuoD1FzK9GRiWFOcYlQLS1AqxQg1H97vVGSMFQLBPgRpLyUSrYL69krEaqLjU85ZmsFlGEhbjM+8P6kJ762WDb/vHT/2sWzvWona5g1egQI/Bdrjo24FO/PtMzCk5dqQ3zEYbKYS0vK8YhbTTic4a4sGWmoP8+AIozoxtHhZlb7babNoBnsYS0Q1MDfOMcWpPDNzwlzNfkQBMlVlAk0Y41DhkiQlVud2w21G4Mpodhx/hBkf/EE8d7DtVPwZhWbcBIK29FgUExGaYv3+mJLAxg8vcoF0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAR2c0KOfdGco8BogSjRRUhd+4cG5Lv9frgdjAzS93A=;
 b=VtBdIAMAKz66CHBJoP5Gn308T3ZHsxtnnGMbeye5Vm3CxAjtG1EK7DqYExa+r/o8qyiSeTZegLZoZ4tgKcghb4EOJfy1xaerY9b8pnfxyADFUBwZrPYrZV2rCsFyk7j2a5yGcHzlqTNr9q23HSGhMygKXaMSuDZ/I1/k8O4XMqqleoymVHc/e7s+n+d/hK/tmJ0P05Gy5zqjrU9TT6KGmYLcwuuqmv7U2gk3QDHvF0i4TIR+Fpg3r0JjvVY2UDewKc/QbgGI/rSrDNJ+wbKJIYt9K5HX6fAJbG7LBK6iLZajZXdUZUkgTCosiNrio0TNPmileXr9Al/XjtLk9RBxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAR2c0KOfdGco8BogSjRRUhd+4cG5Lv9frgdjAzS93A=;
 b=rBUYIvRFnIpXFfO2YtnuPj1522GZQEo5W1RNbXYuPPCW6q/RBXbdBfXPCrzxz9+8uwkm3CgtpiTqWwFsr5iIBDOsU59ckauBezeeoCPZtrI0UjHKn6fSCauGtHst9GDm1E6HldWh2dN109vaAchC+cqV5l8gNjyoSJsLDICcpAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by DM6PR12MB2828.namprd12.prod.outlook.com (2603:10b6:5:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 10:40:39 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::d0f4:808:25d3:3f75]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::d0f4:808:25d3:3f75%9]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 10:40:38 +0000
Message-ID: <2b0607e9-8f83-a0e0-3e4b-f6b796e5e308@amd.com>
Date: Tue, 18 Jan 2022 16:10:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/3] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
 <1b35f6db-d101-519f-aac9-f30380fbcb34@amd.com>
 <f10b8279-fce1-ca17-b6dd-0108e4d1793c@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <f10b8279-fce1-ca17-b6dd-0108e4d1793c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::33) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdde099e-79b2-4174-fb80-08d9da6ef75c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2828:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28282ADCEA39B8FDF94C7D2BF2589@DM6PR12MB2828.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdonpM7XuBOFes94OyUgaF58gCbHJB82M3eQO778NFB2xOlGByviYwr4RntHwlA7P8mHfhb1PJaBpQf6dAMegVrniXRxs/1kYcXTP0fLeUkgEdwlGGOspyp/CxQiOdQaY8GVRejkRVTZD+cICHSY21VeKBuwyb1R05JvQmSChTLGrIW2+FfWu3+X5+qEYP9um4u+sBAp7fbewM754i9X57Tb7cxaUAcd5F4hJsdByLK8Zp13iKaYqz5RHVTWjeJ5rZn7kLh+9e9XxzFti3DR8l1VTrBw7eBpK1PYTwpK6WMVIvvNbFLybXDQLfpQjg5WAP/9M9L3M+UgpOaZVYvL1gHLtnT1vkUWaMs3N1MHsM+PUy4NM/KCb29xEB9nvU9PaGXodFeC0bY2w39iBBjZJeZ00duTIe4c+eTpbP1gyqlvr8XD7g/Te2hq0U/Yx04UCOHmflOEDngiVT5C/jAeg2KcSzeuOSuNnrCq+GXsPjBG/+taHj9aXpFZqG4ZapH6Ew+X1zLLOVzXspQM/rSBxTl7iN+O7/hhsKJMME298icdogPcI/DRYdJyo8SROMdTLu/9OomNYDWiKnF5e7LtdWdOaNcvZYe6xsyqzVFdklbm6LkTDL/8VXB8qpkavlCP7cx8+s9ZACHQE0k/rzBOatzenEPTJ+R5/L8GTch9q8wkRojX+aINzSyGzeJ9BLUgnu+99AixmGftdiJstuMQYdwZcxPlxRpDWeDcBYKxx1BOf4RTTem3vklchJDH0yJm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(83380400001)(110136005)(6506007)(508600001)(53546011)(6666004)(2906002)(66574015)(2616005)(36756003)(31696002)(6512007)(26005)(4326008)(186003)(66946007)(31686004)(6486002)(5660300002)(316002)(8676002)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFMwWjlONE1ZdDVzR0tRNmpqeDRpb3p3OHprN1BKMlRzd1psWnM0Vit6OGty?=
 =?utf-8?B?ZFI1R2krUmlPaWZadmI4UkNsN3JpSHZvNUxyZHlvdlVyalRuWUFhbU0yTFVt?=
 =?utf-8?B?cjJOVjEwKzl5c3lZQlU5Rm5BR0NwZ3lsVE5RSXNUN2dDZ1ludGNVY1BUdjdJ?=
 =?utf-8?B?L3pxTmx3QUxhaHpWY1VpSHVUOU5kVTh0OGo4Qjc0cWVSK0s2b1pFMU1jekQy?=
 =?utf-8?B?emxSYitJZWNScVFGZG9QOENqdTd6WlRDaTNoWjh3NnBJOUFQVDdzeVRzZDhH?=
 =?utf-8?B?UlB1cExESE9Cc2E4RjlBb2tISVA3SGp6SjVEVTJIZ0ZiZHRUQWxOQkhsa2Zn?=
 =?utf-8?B?bkxOVFFFbW02anJVc204aUh5RWQ4ODNXZGFQOXhCNmhhYjVwMUV1cFc1bHdh?=
 =?utf-8?B?QWloRzdEdWI4cWZVeEQ2bVA3VFQ1bFlHb1pIN1hYZllBaVFUS2hwQUxyd3Qr?=
 =?utf-8?B?TGlPbzFnNTJWSkpnS2lNRXpJWGVyc3lSUjRCZTB6bVUzakhxSXFtZjhBaEhW?=
 =?utf-8?B?NkE2UkphRlpreE5ZMVBsQ1JqL0prczNma2xrbTRzMWxvNnRtckJydG5IaEEz?=
 =?utf-8?B?bVZkSUZjeVhlYVVCYjlpdWtnM3EzRzVZVm1xQ29wdW9rMjNDUGppelArYzhi?=
 =?utf-8?B?WW9OYnU5RGtpS3NKRG14aW1QeFF1ZjMwbHVyWFpoQkpZaXJjcVlabU94M0tJ?=
 =?utf-8?B?S3FqcURTZ1Q5TGE4NmpPZXZpSWc5eXBZNkd4QmNEdW1KL1FyaktzT3AzTjQ2?=
 =?utf-8?B?M0tCMUdEa2p0cjhDZEFxcDhURzRnako5Zm1PbjRYdldnbVRjamNQREZPaUxM?=
 =?utf-8?B?QjhnYW5WTXIxdHhHT1R4MzFDaFhVbUVDSGhoWWhTWFVINVplRVJBVWZERUJX?=
 =?utf-8?B?MXZrdi9pUmw2WEFyMm9mbVhWcDR6OHBYMTNOZmpsVUpyTkZEN0RoM2FGZFZm?=
 =?utf-8?B?QzYwQ0xXVmNVOUVzaWk2WXJNTlF6OWZ6YmNzLzVUOERqaHdLTFBPQTZDMElG?=
 =?utf-8?B?eDlDTC9yM01MeU5RMXVoQ2c0UStwVVRzVS9sdXpaRUlTbC8wS05aQzE2S001?=
 =?utf-8?B?YkN3dXZhSFdLb2R4NWh2VTYyYzJYdzVkcGVuVVlvaENJOGF6L1lwSXBRWEtK?=
 =?utf-8?B?NkJ2czNTK002R05qZ0REN0hCSStoQXlYWjBZK2xGeUdLYkQrQjN5dlZtd0tX?=
 =?utf-8?B?cUQ2bmJuSGoxOWxBTnl1OGd2MDFHcFlLUEdMT1ZtdUFWcVBISjNHcUpES3FS?=
 =?utf-8?B?cVVVUlhQK1FCdG4xT3NhelhuT2FFOW0wMlpySDViR29YZnFLemlsaWhldHRE?=
 =?utf-8?B?c29PcVNFSWwwcU5mMWZJQ0xscWZyaW1XZ21NVnFrMEJVK09wcmhvQ0JPMEtq?=
 =?utf-8?B?bUd0Q3M2VW8zdmRLcVNKcUFWNC93aHhHdElKNzN3OVEvWllKMExwWTh6cFRW?=
 =?utf-8?B?ZGJwNVo4YUUyUk5nYUlFQzNaZG5Ga2ZPQnUrb29kNmF0N0tJS1U2NHBYYndw?=
 =?utf-8?B?bUVZYmZxdjIwRm9HdmdSelR6MzRwZmhkY010THhzcEVJRkFTcUJQRDMwNGow?=
 =?utf-8?B?QjJyN3N3Nk1RaTR5aTljRGdQMzZ1MzI1NjRLTnQwOXl1T2Z1dHhQenZwTkNP?=
 =?utf-8?B?OUxwQ0hubFA3VnNDK0xiV0diR1VOQ2dOYzlKdzI4OVVWMmtmMmc2NUNtMDNF?=
 =?utf-8?B?WEZvdGNrd25TT2VnSWtDY0J1T1JWK0FFWnBGeEVkcmtFS1pQYTJ6MUtWcSt5?=
 =?utf-8?B?UzUvNUJTQ0dZa2hsNmZCUlZmZEpzTWJQak13UWR5MTJQbXU4T2MzS0d5Q0N2?=
 =?utf-8?B?bmNCTkVRZ1JaSFJDUk1xU1g4NXF1THhoUW9FemQ0eE9zN0tvaVoxOWdjZW5H?=
 =?utf-8?B?dFNJandFcFo3TVNMQVFxdUkrRVRaQVMwRUxYL1hxZjdSblRzTU5YQjVKZ2tt?=
 =?utf-8?B?R0VaY0F4YzlJa005WWd1OTB3ejJNQ1Bidml3cVkydC8vMjRENnZseFg2K1ky?=
 =?utf-8?B?NFNHTDVjUm0yQVkxejAwdkxITlRYRXptcW92TVE3U3hXbkQrSHk0T3FERExm?=
 =?utf-8?B?WDlXeGRTM2duTmI5R05ZWnZSaXFNUDg4RU1SM05RVnVVbSt3SDZONVNaSEZM?=
 =?utf-8?B?dGhhV2d1YWxTVjcxM0ZUamFySzM1N0dpeEd6cm0yTkI0RVhPQ0JJRDZiSzJ2?=
 =?utf-8?Q?64bdKj8pYYGOjf7C/CoIOKE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdde099e-79b2-4174-fb80-08d9da6ef75c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 10:40:38.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHPMy6G7PPDcuAwbzcPYrx8Zg2cH7d3gLqZhfx2OvB6vM7e2Unwk7siZK9FvI7Mg9WpBcM91GdUd9hG/DF4S+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2828
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

Hi Shashank,


On 1/12/2022 6:30 PM, Sharma, Shashank wrote:
>
>
> On 1/11/2022 12:26 PM, Christian König wrote:
>> Am 11.01.22 um 08:12 schrieb Somalapuram Amaranath:
>>> AMDGPURESET uevent added to notify userspace,
>>> collect dump_stack and amdgpu_reset_reg_dumps
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/nv.c | 31 +++++++++++++++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> index 2ec1ffb36b1f..41a2c37e825f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -529,10 +529,41 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>       }
>>>   }
>>> +/**
>>> + * drm_sysfs_reset_event - generate a DRM uevent
>>> + * @dev: DRM device
>>> + *
>>> + * Send a uevent for the DRM device specified by @dev. Currently we 
>>> only
>>> + * set AMDGPURESET=1 in the uevent environment, but this could be 
>>> expanded to
>>> + * deal with other types of events.
>>> + *
>>> + * Any new uapi should be using the drm_sysfs_connector_status_event()
>>> + * for uevents on connector status change.
>>> + */
>>> +void drm_sysfs_reset_event(struct drm_device *dev)
>>> +{
>>> +    char *event_string = "AMDGPURESET=1";
>>> +    char *envp[2] = { event_string, NULL };
>>> +
>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>
>> That won't work like this.
>>
>> kobject_uevent_env() needs to allocate memory to send the event to 
>> userspace and that is not allowed while we do an reset. The Intel 
>> guys felt into the same trap already.
>>
>> What we could maybe do is to teach kobject_uevent_env() gfp flags and 
>> make all allocations from the atomic pool.
>>
>> Regards,
>> Christian.
>
> Hi Amar,
>
> I see another problem here,
>
> We are sending the event at the GPU reset, but we are collecting the 
> register values only when the corresponding userspace agent calls a 
> read() on the respective sysfs entry.

Is the presumption here that gpu reset is always triggered within kernel 
& user space has to be made aware of it?

 From what I know OS'/apps use GL extensions like robustness and other 
ways to detect hangs/gpu resets and flush out guilty contexts or take 
approp next steps.

BTW, is there any userspace infra already in place that have a 
task/thread listening  for reset events implemented, similar to hpd?

I believe there are several ways to make user space aware of reset via 
gpu_reset_counter etc, also if the objective is the have call trace upon 
reset or dump registers you can do it in the amdgpu_device_gpu_recover() 
but guard it with a proper CONFIG

that can be enabled in kernel's debug builds only, like tag along with 
KASAN etc.,

This way there will be lesser dependency on userspace.


Regards,

Shirish S

>
> There is a very fair possibility that the register values are reset by 
> the HW by then, and we are reading re-programmed values. At least 
> there will be a race().
>
> I think we should change this design in such a way:
> 1. Get into gpu_reset()
> 2. collect the register values and save this context into a separate 
> file/node. Probably sending a trace_event here would be easiest way.
> 3. Send the drm event to the userspace client
> 4. The client reads from the trace file, and gets the data.
>
> - Shashank
>
>>
>>> +}
>>> +
>>> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
>>> +{
>>> +    struct drm_device *ddev = adev_to_drm(adev);
>>> +    /* original raven doesn't have full asic reset */
>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>> +        return;
>>> +    drm_sysfs_reset_event(ddev);
>>> +    dump_stack();
>>> +}
>>> +
>>>   static int nv_asic_reset(struct amdgpu_device *adev)
>>>   {
>>>       int ret = 0;
>>> +    amdgpu_reset_dumps(adev);
>>>       switch (nv_asic_reset_method(adev)) {
>>>       case AMD_RESET_METHOD_PCI:
>>>           dev_info(adev->dev, "PCI reset\n");
>>
