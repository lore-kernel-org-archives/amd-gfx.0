Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB30C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 06:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A0210EA1A;
	Wed, 15 Feb 2023 06:18:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2FA10EA1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 06:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBU24wotfhnWpJ89ZhYjyKS/YS47MvZJrxxXZECvFh+V599WQsTSVkN+NFxMqFCIf0DDaU79aEVh3Tlnx0/Xx5vCBWvF3TqBaq2+VaBKHGJRveUL6wEdIQbCCV95yKfu3KybyN+MdGeGGdX0k2cXcjC2VDHgDIZGgH9taM8+mXydgipZNll1x0ETsbhOncDgBWDPDOs80T5Om8gyWH/NHCH20m58TmxHNAwlUehx9uRjNPFqkFLM1l5A1ijMlExj9Pfdp4hU5m1f54FXr84RvRR1ZVY6sheg76dMh5IewtWLJa+Q+wPQOipoPnN+SdxnEFbpquK+Q5pUGbEIzO8zJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGL7hbTM4/ibT92W53CFSEkEf+vbnkMS+q+QYDbuD9o=;
 b=YlZ4td3O3yyZ9HnNST0RDYJ4XhMMRrvrYhQqZCUKTWtjCxuSCgsAarFfdVeu2X7WZmlXkAet128WH0ufEfOOvUxylwnld4ENX1ZVcZuykr5LevRtVJGcqGIkRXpK6cBn3BYLdLLgGRGm8M6ZxIV5cejxkG4rPTMz4BhzN/z8E42GJfhtXIWMx9mCp2CrgtNLds4+XyZGvEnHuWhbuB121cb3BFDM8FoPEMGzT9I+XK84VFjb1zm38wGAn45Es2Ay68HNhkdH5tRuhCiia9ShbwGhGhL3tY75KHRReJtqI+hpDQccO2sLSsPh3Lh7VHtS65sA2TSAGG/i4HwgbDFJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGL7hbTM4/ibT92W53CFSEkEf+vbnkMS+q+QYDbuD9o=;
 b=16L7cx51Gy2Ya+NgANO2jS4YPJacp3S1ilO+jIxIa1QQ/N4SyEuEtfAk25gUJHHsMhL0H1BoH8jfqP+ZWlLG5A72Eezegr1xVnadTpy3eSiiHHuW+MNhs6+cJQu92i8iPYtQEg8dUjjNAXWQEkGahMf60FV0FgOJBAdQ5aZV/gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 06:18:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 06:18:26 +0000
Message-ID: <5ffd53d8-cf61-d07e-7b13-054ae153f552@amd.com>
Date: Wed, 15 Feb 2023 07:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 8/8] drm/amdgpu: start using kernel doorbell bo
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-9-shashank.sharma@amd.com>
 <d890c9c9-5cc7-365a-df23-f2c16a85bac9@amd.com>
 <ae796f69-28bb-4e45-700b-39a13b69bcf7@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ae796f69-28bb-4e45-700b-39a13b69bcf7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b0e285-f803-4d77-c5f0-08db0f1c7283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKDZTNjf4YVSQN1a4T0MeetVZuSjEX3B3e+k9TkyULm0DYmAuK+i0ph3FHpvJdETvP9Q4qN4kRQX3fqCj0CIA0gQj3fqSo4W/B3uLpmKLvaB2/sShmRq8P939hlTf+vNT/9UrWCvNymcgAFJYqbbje91dVXWWtIVF7G8JUKhcPqCb3MWZ54YAKzDJZOKxdX0hILD9K06DFL2BPPMSbqOR+cgrEzTIH1p2NX1KdCefhBF+plUq5qSOKdvWyVscWihOBdhGhZyKCMY9Gkcd4PRgUFarb2uiDYuvPjCzVz2/1dNqx15Py6aMFV9wgfpFFwnuQDgLKsZOOLR+xmlxaT0xEOg3wMQH9M6KbULCVRfH/4BuOryzPiMBAOocHZJycATLhz6+9lroFiUdJURrCIlpY2BwFP91zIS+xulsUjPSelrBMdwQlbJBMXaw2VbGUgqgK8T1EvfrL8XPxLnWf8L5ky6XYTN09BDMO4FbJdBR6qDxn0cwE1XFkA2duL3KnmyB2rufMmIihIvKflLwXcLzTN4y60qnYxL0K8LL3+OCGbk75A7wkcm187mGw0KACTP4zIEGpUqUsH5WzuBdp86e7X9r2jOdlRIEAI7hni1JOqKAw36XcRhU+oCZElkMGSOHdpemYjtnFh2DLsxPu1v4tDgmH4DLQGSfrYa/HSmhjU/A3kpg1BGV0jFG3Jl1oWr+wDZvC09Sj4uWtLq5GYT5zrKGsjGOqRYBmA3RSkSCBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(5660300002)(41300700001)(31686004)(4326008)(66476007)(66946007)(66556008)(8676002)(2906002)(8936002)(83380400001)(316002)(186003)(53546011)(6486002)(478600001)(36756003)(2616005)(6666004)(6506007)(6512007)(66574015)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YloyRHZpSC80RG9JZDZ2RVc3WGtIVnBmVjNYOFdvUVJSOWhxdXpHYWZPajJQ?=
 =?utf-8?B?L3o4Nk9vM21sU3VrMUNKRWpHQlpmMlRBQ0J3UThEeXFodC9ZcFBtYWpDcFdO?=
 =?utf-8?B?YW8xelR0YWRnbk42Y3d0bGZrWjVnWWVnUmNnS2ZJRVpGQXJmU3I3WmZTZFhq?=
 =?utf-8?B?S2I5dFhoK3pZZXpBTlFCYnZkL2JLa2YxTGVtUEdoQVd5blRudVhXRjRNQ0FT?=
 =?utf-8?B?VmQyZWR6ZUFsR1ZGcU0wL3EwTnRYWERmdGVoR0RoTXpDU1hCWlpRQWtuWFRw?=
 =?utf-8?B?cGhEemFQQUpYbzdoMjcwamp6RXBSK3I4YlY1VTVlZ2hmeTFCU2crb3JCcFZy?=
 =?utf-8?B?MzZLaU5TaEdBR25kQmZkNE4wYzJMK1hVSHVtZkxTbmxYb29Xa21kdkNkcFpz?=
 =?utf-8?B?NktCQ2ZwZ2dqdnpCYm9RRDgyMElnVG5zTzJ4MFpUejU2clBBVjMwaVAvNE01?=
 =?utf-8?B?Rkkzd2ZhYk9lbXhXdUFNQW5xRmRuekQ2OThtRXVpTDNycGpHcmlUSUs5STg3?=
 =?utf-8?B?djZCRG9MRE5SeHRkRVlNb0FsWmJNT3dPYTAxK2ZOTjlIZnU5SXRpaTV2SlND?=
 =?utf-8?B?QU5iNDU3RnBjNkNJVXJ5VFpMM0xubFFUS0RkT0UyUVBnTFFvTkhmdmsrcGd2?=
 =?utf-8?B?VGttYWxFMjhaQ1RsRFVOc1pwK3pxdnR3UlU5cm1hQTFBMkV2dmxSVXZCbjBP?=
 =?utf-8?B?Q2JscFdMcGMyRGlLc0hIQTQzN1NpYWQ2VHJnU3B2dVpNZ0JkcXJOb3dkWVIy?=
 =?utf-8?B?cy9jaTNHbytRa2Uya3BHTXBGbGhkOHdlQTA4NVV2VmJmK2xuWUNxL1ZMdWFB?=
 =?utf-8?B?QVNDL3grdDhXQXdhZjhZT0FTQ3RlZnpLbDcxVjZxb0huSTlzaFBvTFN5UEQ3?=
 =?utf-8?B?Nm1iN3BKUXNzVzJLN1Ixdkt4Mkgrbmp3Qms4a2dVemVHcXNpckV2Yk82cFlZ?=
 =?utf-8?B?L3ZYemZlM1RLYjErZ0NRT1pnMDZVVkJFSUYxcWVHN1Iwa05tMlJhdjFiZFpu?=
 =?utf-8?B?aUhZODlSSTE5ODZjK0JsNUM2bkdycHlES0c2a0grUFpEeE1iMnd5eXFUT2k3?=
 =?utf-8?B?K25Za0RUQ01naTQ1ajdlSk1FTkFYRS9xRUt5UkZsTVE3WmhlczdqanJkbUhQ?=
 =?utf-8?B?MGkzbkVSNFFYWENCbmkvWDVhem56S2RtL2w3d1loelZCbWx1ZmU3UGp6NFpM?=
 =?utf-8?B?RXJOZnFEU3QraVNWMG1EVytUUjRjSTM2TzREZzFZaTUwc2VVOThnWWhuNkgx?=
 =?utf-8?B?MUFEd3I5SXJKK05Hb0xuNEdvclRGbXpMeTlUQVN2elBjd1NuTFRiblppeVhY?=
 =?utf-8?B?MlhmN1NNektOT0ZhcklRY1hlY0Z6WDBzQzFHOUMydXErQlVaeDRtYVVJbHJr?=
 =?utf-8?B?OUJzaTJITjhSSFNkVUFoVXdhR01aRWpHQnJBYUtqc0hhZXZsbTdNU2loN3F5?=
 =?utf-8?B?UUVZblRaOTRPMkdyTmd2SXBRTVlMV3dwUEI3RmtSRUQ4Rm95UklJRVYrRzBh?=
 =?utf-8?B?QVIvQnJWZnpyNUpCUStIQ0h0ajlqakhjanJmQS9TNE9SSnhuRURhQWxCcVA3?=
 =?utf-8?B?OE1lakN3M1FldENES3IrQi9Va3Z5elllUnRyS3B5L255WHhEQlF0c3NScFcz?=
 =?utf-8?B?Vk1KaTQ2WEhtWnpLUXZlNXVhL1dkZHd3MSszNXNVeDgvSGYzM0VHbWtWb1FW?=
 =?utf-8?B?S0RCOXVFRU93V3hDUWtGdi85OEVMeVVMVlpjbVRMaHRPRC9OSHBZYU9hSjhN?=
 =?utf-8?B?Rk03WDJoVllCRHB0eXlDYWlxeWZGWm9QN2RvSllwMVVzc2dVTGthZU9pQVQ1?=
 =?utf-8?B?cW5pMGpNNjRoUWdnaFJqRDFwUXRUbzJ3SHV5Y2hHamU2YStOeEhXM29FQ1Nj?=
 =?utf-8?B?YVZPRjlGNTRYZjYrTGZ1TkhseGxySno3ZXE0WjZROWd0RTIzYUFPcDVIM3dk?=
 =?utf-8?B?N1F2RURMRkRkT2hGR2w4d2xvb0hvUjJMY256V2RsZWNoWlFFcTF6ckdNTEJl?=
 =?utf-8?B?ME1OL01QcEpsb1RQeWNwNTJkYnJvdEZaYmFwL3NIQXliSzJSQnVTeE1DY25D?=
 =?utf-8?B?UUdvbmhjUENQRzhFb3pydmQvZWpKdDJ2ZjNDZDNJRmJybklSc1ArTmpaVWhE?=
 =?utf-8?B?NHE4M243SjBMMm44aGhyZC9RRXRPYTUxV3l3STNwM0hDZDFlczFSY3Rvc1JH?=
 =?utf-8?Q?sQviYupdpCcxM1aUCjH0+U9jWnTGZB1aBUnV+/MeBCOs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b0e285-f803-4d77-c5f0-08db0f1c7283
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 06:18:26.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baFXHjqXbhS7aLbZumwsomr3Wl48lCDlYxFSSqrUdsPgX13FZ3hevZaPl8JIxAZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 20:28 schrieb Shashank Sharma:
>
> On 14/02/2023 19:40, Christian König wrote:
>> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch does the following:
>>>
>>> - Adds new variables like mman.doorbell_bo_size/gpu_addr/cpu_addr.
>>>    The cpu_addr ptr will be used now for doorbell read/write from
>>>    doorbell BAR.
>>> - Adjusts the existing code to use kernel doorbell BO's size and its
>>>    cpu_address.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>
>> Maybe squash this one together with the previous patch.
>
> I just split it from the last patch in this series, thought it was too 
> scattered and might not be
>
> easy to review :D

Yeah, ok good point as well :D

Christian.

>
>
>>
>> But see below.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 33 
>>> +++++++++-----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
>>>   3 files changed, 16 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 0493c64e9d0a..87f486f522ae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -109,11 +109,10 @@ static void 
>>> amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>>>           *aperture_base = adev->doorbell.doorbell_aper_base;
>>>           *aperture_size = 0;
>>>           *start_offset = 0;
>>> -    } else if (adev->doorbell.doorbell_aper_size > 
>>> adev->doorbell.num_doorbells *
>>> -                        sizeof(u32)) {
>>> +    } else if (adev->doorbell.doorbell_aper_size > 
>>> adev->mman.doorbell_kernel_bo_size) {
>>>           *aperture_base = adev->doorbell.doorbell_aper_base;
>>>           *aperture_size = adev->doorbell.doorbell_aper_size;
>>> -        *start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>>> +        *start_offset = adev->mman.doorbell_kernel_bo_size;
>>>       } else {
>>>           *aperture_base = 0;
>>>           *aperture_size = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 43c1b67c2778..fde199434579 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -596,8 +596,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>>> *adev, u32 index)
>>>       if (amdgpu_device_skip_hw_access(adev))
>>>           return 0;
>>>   -    if (index < adev->doorbell.num_doorbells) {
>>> -        return readl(adev->mman.doorbell_aper_base_kaddr + index);
>>> +    if (index < adev->mman.num_kernel_doorbells) {
>>> +        return readl(adev->mman.doorbell_cpu_addr + index);
>>>       } else {
>>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>           return 0;
>>> @@ -619,8 +619,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>>> *adev, u32 index, u32 v)
>>>       if (amdgpu_device_skip_hw_access(adev))
>>>           return;
>>>   -    if (index < adev->doorbell.num_doorbells) {
>>> -        writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>>> +    if (index < adev->mman.num_kernel_doorbells) {
>>> +        writel(v, adev->mman.doorbell_cpu_addr + index);
>>>       } else {
>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>       }
>>> @@ -640,8 +640,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>>> *adev, u32 index)
>>>       if (amdgpu_device_skip_hw_access(adev))
>>>           return 0;
>>>   -    if (index < adev->doorbell.num_doorbells) {
>>> -        return atomic64_read((atomic64_t 
>>> *)(adev->mman.doorbell_aper_base_kaddr + index));
>>> +    if (index < adev->mman.num_kernel_doorbells) {
>>> +        return atomic64_read((atomic64_t 
>>> *)(adev->mman.doorbell_cpu_addr + index));
>>>       } else {
>>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>           return 0;
>>> @@ -663,8 +663,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>>> *adev, u32 index, u64 v)
>>>       if (amdgpu_device_skip_hw_access(adev))
>>>           return;
>>>   -    if (index < adev->doorbell.num_doorbells) {
>>> -        atomic64_set((atomic64_t 
>>> *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>>> +    if (index < adev->mman.num_kernel_doorbells) {
>>> +        atomic64_set((atomic64_t *)(adev->mman.doorbell_cpu_addr + 
>>> index), v);
>>>       } else {
>>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>>> index);
>>>       }
>>> @@ -1037,7 +1037,7 @@ static int amdgpu_device_doorbell_init(struct 
>>> amdgpu_device *adev)
>>>       if (adev->asic_type < CHIP_BONAIRE) {
>>>           adev->doorbell.doorbell_aper_base = 0;
>>>           adev->doorbell.doorbell_aper_size = 0;
>>> -        adev->doorbell.num_doorbells = 0;
>>> +        adev->mman.num_kernel_doorbells = 0;
>>>           adev->mman.doorbell_aper_base_kaddr = NULL;
>>>           return 0;
>>>       }
>>> @@ -1052,13 +1052,13 @@ static int 
>>> amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>>       adev->doorbell.doorbell_aper_size = 
>>> pci_resource_len(adev->pdev, 2);
>>>         if (adev->enable_mes) {
>>> -        adev->doorbell.num_doorbells =
>>> +        adev->mman.num_kernel_doorbells =
>>>               adev->doorbell.doorbell_aper_size / sizeof(u32);
>>>       } else {
>>> -        adev->doorbell.num_doorbells =
>>> +        adev->mman.num_kernel_doorbells =
>>>               min_t(u32, adev->doorbell.doorbell_aper_size / 
>>> sizeof(u32),
>>>                     adev->doorbell_index.max_assignment+1);
>>> -        if (adev->doorbell.num_doorbells == 0)
>>> +        if (adev->mman.num_kernel_doorbells == 0)
>>>               return -EINVAL;
>>>             /* For Vega, reserve and map two pages on doorbell BAR 
>>> since SDMA
>>> @@ -1068,15 +1068,10 @@ static int 
>>> amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>>            * the max num_doorbells should + 1 page (0x400 in dword)
>>>            */
>>>           if (adev->asic_type >= CHIP_VEGA10)
>>> -            adev->doorbell.num_doorbells += 0x400;
>>> +            adev->mman.num_kernel_doorbells += 0x400;
>>>       }
>>>   -    adev->mman.doorbell_aper_base_kaddr = 
>>> ioremap(adev->doorbell.doorbell_aper_base,
>>> -                              adev->doorbell.num_doorbells *
>>> -                              sizeof(u32));
>>> -    if (adev->mman.doorbell_aper_base_kaddr == NULL)
>>> -        return -ENOMEM;
>>> -
>>> +    adev->mman.doorbell_kernel_bo_size = 
>>> adev->mman.num_kernel_doorbells * sizeof(u32);
>>
>> I would just keep the kernel_bo_size around and make the 
>> num_kernel_doorbells a local variable.
>>
> Noted,
>
> - Shashank
>
>> Christian.
>>
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> index 526b6b4a86dd..7bdff4f926ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> @@ -28,7 +28,6 @@ struct amdgpu_doorbell {
>>>       /* doorbell mmio */
>>>       resource_size_t        doorbell_aper_base;
>>>       resource_size_t        doorbell_aper_size;
>>> -    u32            num_doorbells;    /* Number of doorbells 
>>> actually reserved for amdgpu. */
>>>   };
>>>     /* Reserved doorbells for amdgpu (including multimedia).
>>

