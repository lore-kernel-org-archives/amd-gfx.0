Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A76F60E98
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A76F60E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9A889226;
	Tue,  2 Nov 2021 11:18:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58AC989226
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 11:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqEpRBN/dGwEKbkuf27S9QKCcZmjHSw+LEovB4Gb8tmKd9uPyON9x8VwHG1iP1nIyuKO0ZJZ7NycUl3Lc+xC9RKOYoqnScElmC5qR10slBUfTFRstqA8KMOEEoKFPNRaMisNwXzgR2an+I9OPz7z7l/9+ow9t8TMJ5ZglKIGxi0FDhciaB/4PLcUpFBrDqpaec0r+2SotQh7W/crJ8SdMrP7zD6a8UBPhnzp+SnirbcNMcV8qMOa84ZoxABdraCjbAI2dAEjTJdzl5IiZ8mWc/dFPZnkPrak0/QCmFtv6OjJWl/d4WSKng0WY8tkJLrPSyJ9kClbdftxUpFjB51Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJc0NaJb/5jdMbHlx8kyFLkpBMfz4rheyl5njw8KIes=;
 b=WgQn2ZC+KHE2ytVJy7l0kLN23JK8bjVToagBfda5nOn0uKr3bn3iScvlN/CH+pGFloRjFhHjW6IV+z7ORjl0WkH/P9XMBTjJTjrv0BjkUL3RHR7OBnRC83fhbaoAN26zPSBAYQb9TPmHxv9/N3srCHDlhkWn50DQG6DTNd7KGvZrHt4/l+nKsM360Wky0mlEBe8LFdLOf1dLN2LZWN3GS1USeqGvhT46YGmea1n/enprCV1P2m1HqAV7mrggSbS98lpqzzc8RsX/1UvI5iokcunV1mpdSKwuHbuI2gNuDF93ea6ZTdkj3t+DOhHL4TUepO5QY/SxN7wCFqf9qHC0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJc0NaJb/5jdMbHlx8kyFLkpBMfz4rheyl5njw8KIes=;
 b=oP37FHj7xbvWV/HOPpnASPFwCQdA/lIF0PHTvcs8I7xyMR2P+erldatpwdF5/peBDOwj3gfdBGoQDJChnmtAgQTqKKGW8Um3Fv0SS+Z6CAVCFUIFJlC0Y3VoHw2YuYVYFR3397WJIrWbrmWuBMjdxdiVcSoTecvULEyIgsvKUas=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Tue, 2 Nov
 2021 11:18:14 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 11:18:14 +0000
Message-ID: <f2b87f2d-fcd3-ba4b-3e3a-53ec20a4997c@amd.com>
Date: Tue, 2 Nov 2021 16:48:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
 <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
 <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
 <7b1efea0-d937-c7e7-4d9d-7583cc9fa368@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7b1efea0-d937-c7e7-4d9d-7583cc9fa368@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::21) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 2 Nov 2021 11:18:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad272c3d-ec76-4c77-27c4-08d99df27606
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301783986AFFE76FD5E09D8F978B9@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGZyWvZ++sGAJVrAN/dPE4BuwgeJHInQErmKOf14sq7nr6e2LxCXhjdSHuXdRsoWDa6QHFlItT63TlH0CPngeGk499WH8IzOUzihD97KcQ/LKxtnWKMn3WKIqK+56/tJeDNaK4v4oP4tRW0Kn4L5PsWR0eykxlD1LuJ4AjgLj8IjXWAWU2XbDcL6TG6I9TgojNTBO3SB2KKZKFee+N15BDS9/q/ZBkgykv8HelCvDjWBbWUxPO3PUNjGWaVlL8vXrYC3M8wZFf3ztXAGQwzSgQ+3oRrcE1KRXLUJ9rt1hf7qO2icRogDWVB10ZkhhPaGJ2KHe1yTP9teQrkn5kxDlJJb/dB+4lTkvb3FlI5WRU55WYst+qep4bC+Yv30HZNThj0wYR3KuEFsvapzS04kFh7gkTpPgI09XaXMKWXjjVspmJyjQtqD0/znDDCdd1CDYvymUnADl0LmmTynxxHHG/ffS5GIUBy8wPICWKEl+Mwosn4YcIEh6RjNkHskC/tq87eKc3tIDVdg/AxTpWmkb9Ajk2OeuDYsf1bWjeoQYM1DxzZCv+Srupzsa5wvyefbocv3K1Hwpb+2CgrnoURvpmwn0n8E1MJm+AhGw2tc8h/J4/S7oYm1YZI8YuQt6V6OmjysmvPWAgEo6Uxr3DqfzbmMWH45+LcP2wJBL69EVaENPquRMR2+bKtDjW8/0rYnJ9An2FjthD7ZRW4Jnh+ouCHfjIesHcrwfxgjvrqpXb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66574015)(36756003)(31696002)(6666004)(53546011)(26005)(186003)(86362001)(31686004)(38100700002)(316002)(83380400001)(8936002)(66946007)(956004)(2616005)(8676002)(4326008)(66556008)(5660300002)(6486002)(2906002)(16576012)(110136005)(66476007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmdhemdQa3pvbXFFSi9MQVRMVkE4YkZ0Yldxd2s3Sk5xVVpWSGRyNjlPT3B1?=
 =?utf-8?B?bGpZT3ZyWHVJMFhjYm5qaGNPdGV3clFIR2hBTXFKRS91WmFxM1A4cDRFWjZt?=
 =?utf-8?B?OXlLeU1xQjV2ejVPRTUrZTRYSWF3TEt1VXplQ0IrYldKdXlBK2s1TnBQeC9t?=
 =?utf-8?B?QlZjcndlWmdMNDVFMFNCeWRTSCtLM3ZkS05yOGduZWZhK3VRRE81NHA2UFcv?=
 =?utf-8?B?TytDa2dJZVlvSEtTOFN2VWcycy92b1JNdklCZTVLclNqTDd4Z3FuZzRvVFZQ?=
 =?utf-8?B?LzNmR1hhbXViL0g4Qzd6MmZIQy9lMG5ON3RuZHBhVHhFL3BPT3VJeDRobkQ3?=
 =?utf-8?B?SVd6MnhJTW9mQnRqMm1kZXN6Nncycnl5eHgxMFU2cWFZamJvZFBQcVJrTjRx?=
 =?utf-8?B?OW5xQVRPdk41VXhsakZSZEg5cUVjZnhNKzhsU3k5b2IvVEdxNTF6RFp0dlBw?=
 =?utf-8?B?VWs5Zm92OGx4VFlqZnNkd0trYjMyc20zTnhpODRDSmZGdlE3T1V2TkNmRlpi?=
 =?utf-8?B?TUVHbkc3emRVdkNFMitVWHJxbHhiL2pwUG5UU1p6VXNSWE9rWDlLKzdzWk9V?=
 =?utf-8?B?V1MwN0g4VVVlbERHRWJYOHVYemgyZzNUaXJONDB1aXkzN0VTbFpoSXpiUTBU?=
 =?utf-8?B?Sjc1REdwdXhvNEVLQUR4dUpTVDltU1R2d2JjQi9xYy9PajVBcklYM1VjcjdP?=
 =?utf-8?B?c1dPd0dJL0d6cXAvMXpneGFnMzB0VFVEbmRUaUJMd3ZSTThhY1NoZ3JXazZq?=
 =?utf-8?B?ZWc2UUtjQWtxZnlOd1RxU2tYTzRER3hoZjkvWHIxRVBveEl4QU5TcWhLczVI?=
 =?utf-8?B?ZE5FR2VJQ0V5a3dydG0zUFBZRWV3NWZvWXlXWWpsSWpUTWg3cDZWR0ZxSmhq?=
 =?utf-8?B?VHpZTnQ1RndnRTU3MlBSaGFFUy90RHVhUis1WkkwaGNYb2UybkhPdU80eXBm?=
 =?utf-8?B?OUx4YnFhOG4zNVFCV3VJWHB0S2hIZStJVDZ3UFB5R2duakRVTzRsWHB2QVJ2?=
 =?utf-8?B?VUlJV25Fck9iMGdFdzRZQWVLWHJuUzZ1aGhtVmdiS1BtOWcvRWlmQzVWQlhy?=
 =?utf-8?B?L2tKMEdmSndyaGxsdXdqSUhVcXVzNjRkWU9oQXRyNXh2cnkvRjN0aUh2Zllz?=
 =?utf-8?B?NTlsN0xmM0hHemRFK055bGRGaFNKU1RKY0lKeUJNUFBNc3FKZ1EvdXJ5QWF5?=
 =?utf-8?B?MmhDUUxvdTNvMG1ZVU80dGZZUE9ua2N2ZU9adzQ4RDkrQUxxQlEyTzFKUFJW?=
 =?utf-8?B?SEZPTGVTVkkrQjJqanpKUnR4aGx5d1VCeFgweGI1a1N0TmhpckdFZGc1eUww?=
 =?utf-8?B?QVYwdjhhSkthd3c3dTc4OWd0MGl6aTNDYzQ4N3BROEpuemdCUWlGeVZaaEov?=
 =?utf-8?B?MVg5b0dmSUVCSndwYUE5STBUdmc3Ky9CT1N1ZUR0WGxyZjh6TUlhYStyR2h1?=
 =?utf-8?B?NXhXKzNCSC9wK25tMUVXTU5rS0xkNE05TUdLSjZxKytIRnJwZEZMaXBWTENB?=
 =?utf-8?B?ZUNMdUdyekthakhLeUNwMExHOW1sVnorck9ONzJlUkQ2MFU3d1hGSUR6NzNr?=
 =?utf-8?B?YWc5TWtLSklrakdWWWVab0JONTJMY2JqbFRFL1BUcWlBa0c0elBTN1FDbG9S?=
 =?utf-8?B?dWxDMzhReCtsbmFHbWlSakpjWnhpeVhNeDNtTEFKSCtEbDJteFRha1VrY2w0?=
 =?utf-8?B?cTZ0Qm9NdmoxekpxL2RzbkQxYzdyYW9wN2cwUjNWMk11T1IzR0M0Vk05KzAz?=
 =?utf-8?B?VGFIUjdxdGpHelpRcW5jNFE0UzdJZTlDaXQ3UWRjZjdNVXl5TXFPWm1MTVR4?=
 =?utf-8?B?OFMyV2pXQW5qQVJIaXRMOGQrVm1KYXRzcENUUG9vZWRrY1I5R3JHY2V4TGRH?=
 =?utf-8?B?RmZJU0tSakhjK3FQSHJ0YVJmNGx1VU5HaU5TaTBsOTdzWmZGTXVDOWpYdkhx?=
 =?utf-8?B?YXhTNlJnR2kxc0lrVG5OdWMxUXpYb05CYW15QW1LdVA1cUZEWWJBVEFFODR4?=
 =?utf-8?B?L25xM3JGeEdkempCZ0pjaDZUUHpmQitPa1NSMlF4M0tuV25xSERrSEw5V1Y1?=
 =?utf-8?B?OVpTVTFUWFQ5ZmVPY2pDTy9KbDBYV1BVMzFjamZ0U2FZanZURnlYTnNVSHRv?=
 =?utf-8?Q?Fc3k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad272c3d-ec76-4c77-27c4-08d99df27606
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 11:18:14.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtS9ydxp27ZPzx2xLOPtiq+pgej15llye/2V30J27AY4NZKcxrKbSu3YgXUKse/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/2/2021 4:39 PM, Christian König wrote:
> Am 02.11.21 um 11:11 schrieb Das, Nirmoy:
>>
>> On 11/2/2021 9:00 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 10/29/2021 8:39 PM, Nirmoy Das wrote:
>>>> We set WC memtype for aper_base but don't check return value
>>>> of arch_io_reserve_memtype_wc(). Be more defensive and return
>>>> early on error.
>>>>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 073ba2af0b9c..6b25982a9077 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>>>>       /* On A+A platform, VRAM can be mapped as WB */
>>>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>>>>           /* reserve PAT memory space to WC for VRAM */
>>>> -        arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>> +        int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>>                   adev->gmc.aper_size);
>>>
>>> BTW, isn't it more appropriate to use visible vram size? There are 
>>> cases where pci resize rounds aperture to the next higher size > size 
>>> of actual VRAM.
>>
>>
>> Good point, I will update this one and send again.
> 
> Not a good idea at all.
> 
> The aperture size is rounded up to the next power of two and that's 
> exactly what we should stick to if we don't want to get an error code in 
> return.
> 
PCI rebar sizes have its restrictions. It jumps from 4G to 8G to 16G and 
so on. Why we need to map 16G for a card with 12G VRAM? BTW, how it 
increases the failure chance - this mapping happens in page sizes, right?

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>>
>> Regards,
>>
>> Nirmoy
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>>   +        if (r) {
>>>> +            DRM_ERROR("Unable to set WC memtype for the aperture 
>>>> base\n");
>>>> +            return r;
>>>> +        }
>>>> +
>>>>           /* Add an MTRR for the VRAM */
>>>>           adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>>>>                   adev->gmc.aper_size);
>>>>
> 
