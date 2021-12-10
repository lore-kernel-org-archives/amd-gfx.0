Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD1FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB88410EAD0;
	Fri, 10 Dec 2021 15:45:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E176910EAE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtu1XM5LLhHmI1H/aJdFQArRt9Oj10a4T8kPS6tZUXKSHOnPRsp9329pL79i8KPxqouX985nup9OO1GsXwjGmM/yAhNI+tfdAVijXna4Ip/9IsDLG8XXRWva8fZhc1wZEYR5BOCQk53KE4OdKOf/c7tFfnP6Yh8iQ+/hmeEXOjTDp9x4xFkxjbSfiS2l0PcfHzy7nduLsVXRyJA49tAQlVnKo56epn7kVVYyzlrKEwjLdOqhWF7orfaa1nld8gVCt5eDABvNMd3+BLmcfJkB4cr7/jDPpj4PkCyJdR8KD0kaJVitzmQiQYhM5l727iT8MLQIp/KOSvOHqBMmo7rGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYQQIYJcpC1p0gHGH2sOEXq/46kxZEWxDreCYsqyirw=;
 b=llHtdhCRsfBY5K3tTL6Kt6yBXvTiaRACZVK/ziUv0R3QCmoP/2R+Qw4QRzwMojCvJ+pBMv6sN4ur30EUrqtlPqkMRDW9ABcDxMsSTWd/cwM58IWkVpKrcTEcYDsrIMv2wZKrM0cubLQaKGUw+32xQXxGGyn/Nfs3y/rJ0JwVj8POg42VJzhc0Ak1cazLI6yMZm4+Zl+LAHA6GJDrZ11xIiGvJMYFGG17ozLn4E7sTL9RpKVj2gBXYR5GpdBdTuRsq5KsxteiKXtEt7EjihWF/Z1DIU66SCgO66pZaiahiCcK0fa0p371ZaNuBzZx6lJC1awKntRoOcNFhKGOVRDspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYQQIYJcpC1p0gHGH2sOEXq/46kxZEWxDreCYsqyirw=;
 b=uQo6wUjYpP7eJ4583HiMaJkK0cOSVhleikmP5w9iefDhc0nyj9jyzRJwiFfWeYWdqNFPwHGuourT0UYf/Gle7M4Pb65WF7Y3U6cv6xtx+Yzs+F93DVnoeZi1dCLt81pkSyVEKHEt/wQUBW6xJjKnvyBgaIjf10zht5DSeHH00k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 15:45:53 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b%7]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 15:45:53 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
To: Lang Yu <Lang.Yu@amd.com>, Christian KKKnig <christian.koenig@amd.com>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
 <432a38b5-2c56-2b54-4e05-b0a3862ddb2f@amd.com>
 <983b6cd3-57ac-a797-170c-2c43b86b67fc@amd.com>
 <YbLNtFgoxa66ZV7N@lang-desktop>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <92c154cf-8ab1-a2a6-191c-13dfcbf86a84@amd.com>
Date: Fri, 10 Dec 2021 10:45:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YbLNtFgoxa66ZV7N@lang-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: CH0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:610:b1::23) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:b35b:da98:234c:d854]
 (2607:fea8:3edf:49b0:b35b:da98:234c:d854) by
 CH0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:610:b1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 15:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c8d0bc0-baa3-4865-a7e7-08d9bbf42577
X-MS-TrafficTypeDiagnostic: DM6PR12MB4864:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48645BFB61BF10732097844DEA719@DM6PR12MB4864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGH4Ox4rPCqUIEzU0zfxRm4kx4cqlHgMo60g/y+h1ev6kHKou/5tAXAV52c3QMQ5/Nc9FqNd6Yh5okcTKH2B32Kn8LFfAvkOQnIwKWbvmNyZrcKAt7bGKrdgF0FdE78/ijc9xqOK34I6o+eTDAU5z8L+fHzIRSYD68FTfeAlOlNtEC6ldmxmzXFJgSeLuaZ2kcSlE3CKtdp+yWwXET2c0YOY5ONSzErgTzNtZ7LC66rzIYOra6mQdv2C7bjzyatzeh7GZoeOa7AGNfZ/mXXL+s+3mQ4r5jFR8k7xDFoLxDgumVLzjYzglitlp5YSIqb1U/GI+ISrBVLQ7s2gjbFEk/sqCibjtbUR5Vm2MwflLK22n0LIYRl0FR6xXhYS8qk1v44/bfp8xNJOoQJ0lem9X6yQ/lpu8WnX+KxiuiBcjZRIgjEBlGJdxi9GjtF9X8j5jogFc4Jxb+utxoyQpuaGqDy5oL9PieZvPnaCDDRTbvC9NByTvpaMzBm8s8Out54ZB19cGcfLAG+VFMRhacXeitpxXqCvYMHyP6UW3nhdOHJaq3HXah/M1kUpNWu0u8J9WGurFYNwq+h8TzzbsI8/qXvRcjbm4F+AOZW7mt+6t0ru+c5PsPiGaRi1QbyBXzE6wBJfPW0lzZppGdUjZYJoVwXLPI6L3PMTAqE35dWtC9k7j9TCT6J9qzV7SepDb/CO6lLIdtBYVXoJ7qWSVounsl4vy8Ub4lzrME9yKvfCFJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(316002)(36756003)(38100700002)(8936002)(186003)(83380400001)(4326008)(6486002)(66574015)(31686004)(2906002)(86362001)(54906003)(66556008)(5660300002)(508600001)(66476007)(53546011)(66946007)(8676002)(2616005)(6636002)(44832011)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkQzazE3VnNEeW1RRCs3K2FuTlBrT25OdE9GdzMzNWxqTzBCenpEcEtKS3o4?=
 =?utf-8?B?OXpSWkg4UG5LaklndjJaSVVyU1JLR1NlMVp3b0IyaFZ5RmJ0UUViRFgwN2hI?=
 =?utf-8?B?cmNxaWN6aWJKWENaQjYvclp3d2FWMFV1RGgvcDhTWkxObjVldVlxdzZDUjZL?=
 =?utf-8?B?WkV4Uy9abnR6MW1PVlRUYjdsZkxWT3R3MVQwSXlWdUN0a2N6VWJnc0EzN3Fp?=
 =?utf-8?B?ZDI0eGJqM0RudE5BVnVYdHB4ZnV2empoT0RZTm5LZUloODVwbWt5RGVPZ0dQ?=
 =?utf-8?B?dm5DZU9HWEpYNExhZzN1azJwWmRnUnUrTGRSMnMwcmh2Q00weVBKMExSanJR?=
 =?utf-8?B?YnNKMTVKRzY4MEdUTUxLVjVZYUpSd1dzcVlvQitrMzJIOVVnMTdZcjEvMVZh?=
 =?utf-8?B?ck1LRE4zRkZ3SE45RHlhZmxqMzB0aWNzaE5hSmxGblpWSmxTMEZiazBVd0dO?=
 =?utf-8?B?d2FjVjBjNHRyd0ZKdHJFbnpvbldTTnlrTGVUcjZ1MDZaNFZRSjRlYjBHUjlk?=
 =?utf-8?B?Ym9PdEk4ZEE2RmdBVVplV1JJVG1ZZzc3Y0xnTUdWUzE5NFU0dHhMQkJHa3JE?=
 =?utf-8?B?UVJkOUVFZmJGUVhKNjhSTHRzU3owOTh0aTNKeTgwbVo2bTJtdHg5T3k3ZXZP?=
 =?utf-8?B?MGF0STkrN1RjRmtJZ3lXc1pDWU44UnhPT3ZWd3dGdlQ2aFZYRENqc2NvcE5i?=
 =?utf-8?B?Y1BkUkw5aEVjWXJueTVVb3FrWGd0dGk0M1cxaU9GQ2FJalhYU3REeTFnd09T?=
 =?utf-8?B?ODFsbVEySUlUUkloZ2RTUmVxczRxckdYalcrSzBnQm15aVBPWVlSdEFLdDho?=
 =?utf-8?B?bE8xWnRSTldwL04zQTB5YVVoN0p3QnJhbnpLSUFGYlRvdmpCMXZ5WnJ1SDUv?=
 =?utf-8?B?UDhuUDlCR1NjRkZnVG5XRzRmNHNoMlcvNXZURUVEbEt2NE5wTGZJeTVnaGVY?=
 =?utf-8?B?R21RVDAreHNMSmZsR21Pa1Q0MG5vUTZyQjRlVWttZU5YN1ZqYkRYS0dwekhO?=
 =?utf-8?B?ODJjQkRoeXdlVWYxT2M3RTdXSWF4d1F3UW1vbU5qZDhjWTg3bk5zZk1WcWxp?=
 =?utf-8?B?MkUvM0tnRFBoWXp0OTROV3IzaU91VHk3V0s4dU9BTWd1TXUzaW9Wc2NGeHdF?=
 =?utf-8?B?eHh3WmV5WjJaY2UxSlNEUjl4TmZvSDlEbUp1YXZMVzRBSStHNkVpU1hqQkNH?=
 =?utf-8?B?R0RRbFdFOWo3UlNaRlFmS2xON25BNk9jTzNNZG5XUE94Sm01a3BTUDZiY285?=
 =?utf-8?B?QjJ1ZXRKVmJuU2VWTEZZYXl5VUk3R1F4S3RKV0Z0a0NVeFBFcW93Vm8veVhr?=
 =?utf-8?B?OFVPcmhCY010ZXhFZHM0eHVPaHNkNDQ1cURBc1VtMnZCTCtKa0JIay9PM21W?=
 =?utf-8?B?RjFGdUIvTlh2OXhLbktnbHozOHFIK1Rlbk9QVDN0ZFV1RW9ZdjBaVlpROTJj?=
 =?utf-8?B?eEFKMjVkUUtLaWNJWEwvY05LT2RZbkdxdzlmTHdsVmwrK1ptQml4Sy9iNGVD?=
 =?utf-8?B?L3Fpa0t5eDVhZngwd2l4K2ZsY2drWERVQW52UjFCRlU3K0EzYk9NaUx5RjdK?=
 =?utf-8?B?VWp6ZWlVZm1DNEdOQWhPOThMbHhuaUJpR3BsT3BBVlZERTEyTUVEY3BlVjNS?=
 =?utf-8?B?ajdnQmJ3TmxpVGJFUzQwM0h5RDEyWHFPSklBWjh1QUI4ejFPbHdsU1RBUHhj?=
 =?utf-8?B?QXo3QVNmZm5lVXRaWmZDRmFkNnJYSWp2VDgvQUREeU9MbEJEVTV5QjI0Yk9q?=
 =?utf-8?B?T2p6cFl2d2JLM1JsbkNTcVBrQ25YNFpuOGpxekt3ak4wbm4xMDdMaHlOVUtG?=
 =?utf-8?B?N2s0dlVoVFZzV055bktKa0xhTDArSmtUZC9mSnJ2WE0rcnFNN2NpQW01THA0?=
 =?utf-8?B?aTdtOE5yTjJsNUpvRS9GYVE2Y0FpV01PaXVTQ2VGQ0xjSGIzU2trSDlyOW4v?=
 =?utf-8?B?blprNU44SnIzWlNJanJ0UFJiWEJsNndCRksvb2x1OHFvVHBDeUJub3JUblZm?=
 =?utf-8?B?RHNRZjNPZ3ljZkUvMnliQkp6d3o5MTROWG9hb2lHNXRxNmlSdDU1MzVSL3Bv?=
 =?utf-8?B?TldPem1heDhzSW9qTDd0eEx4UC9KbFRwUUordDhQQW56Tk1VSzZ0aVZ0bWp5?=
 =?utf-8?B?eUhMZ1c1WUswYm90NXV4L1lKUEZpN2VoUEphRkxkUXdMdWw5YlFBWHorTXlS?=
 =?utf-8?B?dWswZVhTSm1FRWQrR0Q3SDRwY2FNZzdXcU9JVjRtZy9tcVhoVlJUNUpyV0hO?=
 =?utf-8?Q?DyKr+vwo9w8RSYMNv33/EaET069CPeAVAXZXhALzM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d0bc0-baa3-4865-a7e7-08d9bbf42577
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:45:52.8737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1+nZgKF0Jfwd6f3jZ3RmSiUeUBv0e3agR3qPgIL2Ivus+Crhl9FsH26ArhvMXJHXx/VB3Xe3paWQZW3PhYjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-12-09 10:47 p.m., Lang Yu wrote:
> On 12/09/ , Christian KKKnig wrote:
>> Am 09.12.21 um 16:38 schrieb Andrey Grodzovsky:
>>> On 2021-12-09 4:00 a.m., Christian König wrote:
>>>>
>>>> Am 09.12.21 um 09:49 schrieb Lang Yu:
>>>>> It is useful to maintain error context when debugging
>>>>> SW/FW issues. We introduce amdgpu_device_halt() for this
>>>>> purpose. It will bring hardware to a kind of halt state,
>>>>> so that no one can touch it any more.
>>>>>
>>>>> Compare to a simple hang, the system will keep stable
>>>>> at least for SSH access. Then it should be trivial to
>>>>> inspect the hardware state and see what's going on.
>>>>>
>>>>> Suggested-by: Christian Koenig <christian.koenig@amd.com>
>>>>> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
>>>>> ++++++++++++++++++++++
>>>>>    2 files changed, 41 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index c5cfe2926ca1..3f5f8f62aa5c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct
>>>>> amdgpu_device *adev,
>>>>>    void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>>>>>            struct amdgpu_ring *ring);
>>>>>    +void amdgpu_device_halt(struct amdgpu_device *adev);
>>>>> +
>>>>>    /* atpx handler */
>>>>>    #if defined(CONFIG_VGA_SWITCHEROO)
>>>>>    void amdgpu_register_atpx_handler(void);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index a1c14466f23d..62216627cc83 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct
>>>>> amdgpu_device *adev,
>>>>>          amdgpu_asic_invalidate_hdp(adev, ring);
>>>>>    }
>>>>> +
>>>>> +/**
>>>>> + * amdgpu_device_halt() - bring hardware to some kind of halt state
>>>>> + *
>>>>> + * @adev: amdgpu_device pointer
>>>>> + *
>>>>> + * Bring hardware to some kind of halt state so that no one can
>>>>> touch it
>>>>> + * any more. It will help to maintain error context when error
>>>>> occurred.
>>>>> + * Compare to a simple hang, the system will keep stable at
>>>>> least for SSH
>>>>> + * access. Then it should be trivial to inspect the hardware state and
>>>>> + * see what's going on. Implemented as following:
>>>>> + *
>>>>> + * 1. drm_dev_unplug() makes device inaccessible to user
>>>>> space(IOCTLs, etc),
>>>>> + *    clears all CPU mappings to device, disallows remappings through
>>>>> page faults
>>>>> + * 2. amdgpu_irq_disable_all() disables all interrupts
>>>>> + * 3. amdgpu_fence_driver_hw_fini() signals all HW fencesamdgpu_device_unmap_mmio
>>>>>
>>>>> + * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
>>>>> + * 5. pci_disable_device() and pci_wait_for_pending_transaction()
>>>>> + *    flush any in flight DMA operations
>>>>> + * 6. set adev->no_hw_access to true
>>>>> + */
>>>>> +void amdgpu_device_halt(struct amdgpu_device *adev)
>>>>> +{
>>>>> +    struct pci_dev *pdev = adev->pdev;
>>>>> +    struct drm_device *ddev = &adev->ddev;
>>>>> +
>>>>> +    drm_dev_unplug(ddev);
>>>>> +
>>>>> +    amdgpu_irq_disable_all(adev);
>>>>> +
>>>>> +    amdgpu_fence_driver_hw_fini(adev);
>>>>> +
>>>>> +    amdgpu_device_unmap_mmio(adev);
>>>
>>> Note that this one will cause page fault on any subsequent MMIO access
>>> (trough registers or by direct VRAM access)
>>>
>>>
>>>>> +
>>>>> +    pci_disable_device(pdev);
>>>>> +    pci_wait_for_pending_transaction(pdev);
>>>>> +
>>>>> +    adev->no_hw_access = true;
>>>> I think we need to reorder this, e.g. set adev->no_hw_access much
>>>> earlier for example. Andrey what do you think?
>>>
>>> Earlier can be ok but at least after the last HW configuration we
>>> actaully want to do like disabling IRQs.
>> My thinking was to at least do this before we unmap the MMIO to avoid the
>> crash.
>>
>> Additionally to that we maybe don't even want to do this for this case.
> So we just do "adev->no_hw_access = true;" before
> "amdgpu_device_unmap_mmio(adev);".
>
> That can avoid potential registers access page faults.
> But direct VRAM access will still trigger page faults.
>
> For example,
> "cat /sys/class/drm/card0/device/pp_od_clk_voltage"
> will call smu_cmn_update_table and can still trigger
> a page fault.
>
> smu_cmn_update_table()
> {
>   ...
> 	if (drv2smu) {
> 		memcpy(table->cpu_addr, table_data, table_size);
>   ...
> }
>
> Regards,
> Lang


What Christian meant is to just drop amdgpu_device_unmap_mmio, unless 
you are worried
that we might somehow alter the SMU state from the driver side by direct 
VRAM access.

Andrey


>
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>> Apart from that sounds like the right idea to me.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +}
