Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF94C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98FF603E5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 11:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C98FF603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400806E0F3;
	Tue,  2 Nov 2021 11:33:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F34D46E0F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 11:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR+WVMFIRIrsypYoCen0USo2XBNuIJs+Hp6DTXjWtF/JOo2Fok9jiyJCyFLOrQf2kEajzATvAhgx4IqiJYAjLRwPIzxEYdeEJjMYny6XV/PNCbEW8B9xODUt4/bP9Jtnnd5hkPzuFUZURUVzoOtLGVd7Gca9q6kfdTB1U0wBwIlhIGmbtULBkq8+9hQFNxQFD9BN0Q4sVBhdtlnOuBkRxX86bEPBIXrSS4CwuDt1on9XD0jCyXOndgzrMW5Ahsc2+Brke8qqJykTShBxCIC+LbNaWyzCc/0iOlLWtvnL7VLh9Mx0GkKx8kShCq273kxPUljMAXPcYr8d7TLrruf69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgTPmMPskWrGcZmUf0prdBlpdeYguFmJrmmuVnul0T8=;
 b=gZdIqUHOquRkM/adUgALoAdu3MOpOD3RpEdm51VtE5iODNAvm1vwsoJoPcBbSQsQRHT+D5aRKbDeDNPQg0w3cKyDFn67VHqdvtu+7eql60rdb/X2zs45FcgdmGVD+YTRfoBj1tSWk1PeVR9qvpWTWUgSu1qhPmVHE69E8w9o/hN9kFQHqfL96TQvqVWkKVl74ASI9OeQB1CUomf2EcfZ9NvyiQlBMBF1N72Qng+1NGeXkrjQbFxPELOL9ViSxDv54YwqK2akOXR62FvE6qaIgkaHdGQ4JKpUXShTSy3YbNxetYLA52GE4ppYJqwrp+Q+Ywi2eDhV7uY9tTmQZACwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgTPmMPskWrGcZmUf0prdBlpdeYguFmJrmmuVnul0T8=;
 b=lG92f8cuqag4J+iON402Mkt3J7/LR3n5yoivgSBfnYSbX0GOfRrwAStERAVvqa7Izh7wnXz5F0o1bKMQxBLEybB5RaUT0HYmYYS0YrTfZc4K7GW6vkyYGe+lRuIKUAvbERVQshUPHuI16RCMsxlTeNVtA0SNDAuhSil34uuZpJM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1901.namprd12.prod.outlook.com
 (2603:10b6:300:113::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 11:33:27 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 11:33:27 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: return early on error while setting bar0
 memtype
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211029150917.4462-1-nirmoy.das@amd.com>
 <69967ca1-6482-7cd2-1c32-d4de5c8136eb@amd.com>
 <c807f013-1931-bf17-6942-28e7413bc627@amd.com>
 <7b1efea0-d937-c7e7-4d9d-7583cc9fa368@gmail.com>
 <f2b87f2d-fcd3-ba4b-3e3a-53ec20a4997c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <25de3975-133c-f22c-d75a-eb943f8a9193@amd.com>
Date: Tue, 2 Nov 2021 12:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f2b87f2d-fcd3-ba4b-3e3a-53ec20a4997c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::47) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:2746:f022:81db:a2f4]
 (2a02:908:1252:fb60:2746:f022:81db:a2f4) by
 AM6P191CA0034.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 2 Nov 2021 11:33:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b111e98-2856-4201-7c56-08d99df4963d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1901:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19017820B60DF11AA5278304838B9@MWHPR12MB1901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXim7klRauZN6/qdc3E1l36youlSfjm9YD6oiyKL0bUXsLxET+I37QBLR5U/XX0oJ8aJ2f8sppteKLxv1JFA+uV+aEU6FSk9dwLW5Xfj4L9xpdPNW/Awpft7ex0GrYDQIuCFkLJh9GnVg+LquJct2/cqe2dG8x+2WkAEiGKAzK+nwhIwtRFKQ1uee2w9/sXSJD+eAKpPfgMzThdHzzG/5ucjt0cBt9U+xViKOCEH1DLBjJUbEAzaJStUDI6nDeQWQmUcOOVuvC4o7nYehrSRfUz5HbuY8CSrayXpLIUAprDFZXOe1VKWMxHuI3DjPDe63l4xM4JKzzAvBLHYKViolRV+8OJYK62h2L47PWKRhqwxmsCk7+UYxbF7xrRUiS7ana9q0bxtColF/j4z7pf0EC9gIu2dqArpw8fd0EtXYATl0Mep4DN4Lqyh6f5auiVjMHq0dm3U8F3T9m6qUmP7D/KfYymHJJ08x8QlUd1yYUPb+BTcHmX2hUI87Ah67P8Xe7OCKzCSnYb9NVTWTmhpa+eVrylHc1owuMdJIFg0X2JGQwhDkh43CnKitn3U+mmty/DuqDjqYR1DBRzxbjgZjsCeRDUkjRNrS/vXPrcMbEqGCyJBDZIYQu0m6A0ccNMYzRSPIt4ubVKme5P5k0k7cyAdQP2MEuF8aUCAOePeKpcEkUIq3WW7Usr/sQ075VG4ziATA24BHw9G118sGIxK/Cd4oIzYv8Tt0yH6isLa3KlZ4XVMbZ8Y4MA6NGZkngus
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(36756003)(110136005)(38100700002)(53546011)(6486002)(8936002)(31686004)(8676002)(316002)(66476007)(66556008)(66946007)(31696002)(508600001)(186003)(86362001)(66574015)(6666004)(2616005)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnYwR1ZrdVpLZE1yYkFjazE3b2dHemZGNlFnS3g3Snc5am8vbVJUc2wxdTJo?=
 =?utf-8?B?cFBpbVV4WWsrOURWN1ZMbHA1WkpmV0NrV1NBSVBrOWVGZHNuYnN4ZFphcU1t?=
 =?utf-8?B?ZXlpeW1iWTVJY2F3SC9rQ0NvckZodldtTjNQaW9NWFNJbVp4eDc3ZWJpZjBh?=
 =?utf-8?B?dTIzZXJrTnQvaldzU3JERTlhT04vbFBZajBSbWxjZzdTY0lQdlVueVdad2RZ?=
 =?utf-8?B?QVFmS3NyWlFaNUNSbFJXRTIrYnlyL3BIdVhJQThnVXFFRkNiQlJ4V1psYlBB?=
 =?utf-8?B?VWxyYTlFbWg1UVgwWm8rNHhOcmxaRis1TWttRDRGTURZM08rU0RLSzJQZ0Rq?=
 =?utf-8?B?dnV3dmJiSFI3bk44bnJOSnhnaGpQKzVJdjg1TEZLdzNqV0FqZnlBY1VuZGlP?=
 =?utf-8?B?R1RYbWZhZ3llYnF0Q0tWMDlUN2Z5RXlRU2d4SktkeW82K0Z6Y1BFc0kwMEZX?=
 =?utf-8?B?YXlqNlJ6YmtGeENBOS90WHdISy9kUzgrSmhmR2NacnJPR0RsOHkvT3RqUTll?=
 =?utf-8?B?Y1ZkVWd2UnlibXFLNm5XQlhsNTVGeXpBNDFBOENYaUdRTm5jb1lEdTFWMXVa?=
 =?utf-8?B?MU1nMFo3RGtTR0dnQ25OaHk3czRVUi9neHJPb21RQVVkNmZUMEYxTWZTTFlG?=
 =?utf-8?B?amJQL0ZuT1orVitOYkVpU0pHYkRuODc1VEFZcGdWK1ZPU0crS00wZG9GT0xr?=
 =?utf-8?B?MzdBV2N2TVJSTkQycm50OWxNcVIzUkEzaGkyL2RpV21CZDhoc2JndnFsZ3BC?=
 =?utf-8?B?V1EycXJ6WjNPaHVaN0UyZ2xMU3RmNUtRcnY2TWM0bG0rTHpyT2w0NWttS0Vm?=
 =?utf-8?B?WVAxOFVsb0h0N2RkbThOc2VUV3EvVU8yODlTa2o0YlcwWmExWjhpQnBQSE9G?=
 =?utf-8?B?UkxRUkZmWXhDdVVoUUxjWU9MOC9jUGdTSWpHOWxiTWU0cFFqNit2b3JxM20y?=
 =?utf-8?B?elV0ejRGNGxiN1hkdE9HR0Q0Syt5d3o3WmlhM3NrdHhWTUFFeE9Pb0pBVENz?=
 =?utf-8?B?cTRjanJRY25kWVJDeWUyN1NNNGtCeWhkdmtzVVUwYUpOR09sNWh4TWR5ODFY?=
 =?utf-8?B?TEpUTWkzRkIzOUlNeS9GNGJicjl0NmVkcTNORklqcTQ1Z0pqZWJMRFNXbUhn?=
 =?utf-8?B?bldaWmZtV1IrUlcwK0VNcVE1V3RYdnBDeXVFdmFjb2c3M011bWFGVkNZTG5C?=
 =?utf-8?B?YjdBWDhpd21qbk5TaG9kaXB5ZjZ6dGlKR0UxQ05uQ0sxZWdMRDNvQWlBR0ZW?=
 =?utf-8?B?M3IvY1VhOWNYNGRyY0dDVUhteHBmNjFRMG55ZjkvTWNvNFJKaWt5Q1JOZndW?=
 =?utf-8?B?UXVadm9jU2ZVSU1HT3I1cEVHWHFDZTdZVU5vdWJlMFFXMDhPY0N6c3NUZU9u?=
 =?utf-8?B?MldQKzhrWmZheldMc0NKWm9CYmkrZy8xVXYvUTZUN0NXSklPeVpGM2diR0lr?=
 =?utf-8?B?VmxLS1QzU3Q5QXdVcnpIV0NjODdDaUVHMFQwZWhQeDE3cTZkOStJODZIOVNo?=
 =?utf-8?B?MGpVTXJNdGdCMmFzMDNtVGdjZ2xhZXNQN2xiRTEvRGRvMmZPN2t5MUswaDVs?=
 =?utf-8?B?TFNYK2EzWXRKeUVwZ3grbzhoUkNzVlduMjJpUjl2ZFh6d0VQc0Y3YmEwSUo1?=
 =?utf-8?B?OVE2anl0ellHbXovTGxvOFRSeENOa1BwYlBkZTZPRWdJR3NlVnBlMnN6RWg1?=
 =?utf-8?B?UmltQ3ZEUHVUSUNqM1lwT3dWZVhLMlJ5aFF4aHlZN2JFQnByZHQzUVJxUVNG?=
 =?utf-8?B?SUd4enBRK3NUeHE1c241UXZaanoybzJreGRDbW9VT29zSk0yVGxmc3JuRXIz?=
 =?utf-8?B?Z1ltT0Y4N1QzV1JXNkFLMTRvVUd6MUgxdFZPVCs0Zy9wRE50YWE2SDNLK3Ir?=
 =?utf-8?B?K0d1a3h1NExtS1hpU0lodkM5VC8zY0I0N3pqaW01SmtvRmFCblpBSE1xUTlT?=
 =?utf-8?B?MEdNUWxaeUFVckYycXlHMm9IYkZUZWd1NGo4NUdkMUdaZkw2WVBwMGlTeVNq?=
 =?utf-8?B?cVNnSUJrWVJGaEJ3cllJRnIvWEtaNHg4L2paMElqcld6RVllcElFaEI2dFBh?=
 =?utf-8?B?Mjd2WnROWVlyemVCWUVhbEpMZlNMeWJpVlAzMkxlc21LYWJTd2FCejFldXls?=
 =?utf-8?B?SkRzS3dIZGZ3VEp4RHBLV3BuYk5VM1A5SXdkRE1jZGZTQm5OZWV5Q2NDZjdX?=
 =?utf-8?Q?SPI6piu1NzxtkDcvfTI3Ke4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b111e98-2856-4201-7c56-08d99df4963d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 11:33:26.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlr2CeeOcblJl9uXkeJeRibU33tjiviqy/MxWMvmp6PIw2SU8rNIZFl9Pa6PTlCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1901
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

Am 02.11.21 um 12:18 schrieb Lazar, Lijo:
>
>
> On 11/2/2021 4:39 PM, Christian König wrote:
>> Am 02.11.21 um 11:11 schrieb Das, Nirmoy:
>>>
>>> On 11/2/2021 9:00 AM, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 10/29/2021 8:39 PM, Nirmoy Das wrote:
>>>>> We set WC memtype for aper_base but don't check return value
>>>>> of arch_io_reserve_memtype_wc(). Be more defensive and return
>>>>> early on error.
>>>>>
>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++++-
>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 073ba2af0b9c..6b25982a9077 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -1032,9 +1032,14 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>>>>>       /* On A+A platform, VRAM can be mapped as WB */
>>>>>       if (!adev->gmc.xgmi.connected_to_cpu) {
>>>>>           /* reserve PAT memory space to WC for VRAM */
>>>>> - arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>>> +        int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
>>>>>                   adev->gmc.aper_size);
>>>>
>>>> BTW, isn't it more appropriate to use visible vram size? There are 
>>>> cases where pci resize rounds aperture to the next higher size > 
>>>> size of actual VRAM.
>>>
>>>
>>> Good point, I will update this one and send again.
>>
>> Not a good idea at all.
>>
>> The aperture size is rounded up to the next power of two and that's 
>> exactly what we should stick to if we don't want to get an error code 
>> in return.
>>
> PCI rebar sizes have its restrictions. It jumps from 4G to 8G to 16G 
> and so on. Why we need to map 16G for a card with 12G VRAM? BTW, how 
> it increases the failure chance - this mapping happens in page sizes, 
> right?
>

Exactly that's the point. This mapping usually happens in power of two 
in the same way as the PCI BAR sizes. So we should use 16GiB even for a 
12GiB card here.

Only some architectures work with page size mappings (e.g. x86 with PAT 
enabled). Then we can indeed use the real VRAM size, but that is 
absolutely not guaranteed as far as I know.

Regards,
Christian.

> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>
>>>
>>> Regards,
>>>
>>> Nirmoy
>>>
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>>   +        if (r) {
>>>>> +            DRM_ERROR("Unable to set WC memtype for the aperture 
>>>>> base\n");
>>>>> +            return r;
>>>>> +        }
>>>>> +
>>>>>           /* Add an MTRR for the VRAM */
>>>>>           adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>>>>>                   adev->gmc.aper_size);
>>>>>
>>

