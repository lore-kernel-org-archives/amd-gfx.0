Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1559C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 16:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F2D6E145;
	Wed,  1 Dec 2021 16:01:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028546E145
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 16:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5JZ9HA5fOzovKEQ0G8rgXMAsEI1nW9i1auwsE/B+d6213eociPzrAZydhagwfpXzQf4i7NO3rFlMSSXHXMD19zXsCGiRBfMy+RSfPUqYWAx6BTblX1PPsrkT/M+npVbuOagT6NXV7q/K1UKWeFWKEi5fFVu/Q+c9fcTKEWI+vnzpv+Vog2nwFVzclm0I5sjkmS3ywIFXQmw+bSO97eBIs6HP2zNsdRVvvB2bTagpsP0Lj60Y8s+G8PYYRWQqzIiP2hQ4MH9mn+PcFpKM4bF4wWxoHqKs7OZqy0E2TFeKKd0F1nZZXaTNsvrUKsDBc2jf7RHCaGR89k3aZJH97Qb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4UZi+Pi2baZRPw5M/WHuU0tGE9kcuzsB431gEaAH/c=;
 b=HiD6OV9W8mQKEvlWUx7czCNyHfIABOjcxbosS6HIllrZ1ahiCCmLcGrMin5sHUNWIEiQXGdTK7StP+A5qMMA9lds4CzyNuYi59fmb1ab1PqxypdXr+C7oOD6GvFnp4Ar06D9ZKy6jmMkrlx+9lhDuHGCGBHH7e7M2yMsm4i6SBzy405XUIMDUDZzovGx9dWnY1oLsPOJPuhY6AudP0pLMaYwuo7gb0zQAOwWQ4L4qkzKfEijaIpYqhYDRql9sdImEdoW25Gr+vkJJy74FH8/1dhYDvmwUQPRqbicMY1KNKn+9i0M0Cdu6S25Sf1hHGypQHO2+TUJGOVbUQt26fIF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4UZi+Pi2baZRPw5M/WHuU0tGE9kcuzsB431gEaAH/c=;
 b=aZWgpZTdHFID4yhQ82ZIKP533in6wYHzRU1U2I1hYFzCgxAO4jLsVl+fN+1b6pyugWRbQXek17ATvvog/rGsnBAKu6Ki0dc0QiZiTFYxqe6uMWqRmGFkI6Y2Sutb1xgsy9WwBB1iQ+Ny5j+U24a76ghWVk54FPa0goWT06ugc58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 16:01:30 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 16:01:30 +0000
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
 <DM6PR12MB4250CB4C8DE2869BB8BD55D1FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0bf2d85f-d879-9402-a953-a637ece495d2@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e5572279-9c3c-f83b-e0ae-dce97592465d@amd.com>
Date: Wed, 1 Dec 2021 11:01:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <0bf2d85f-d879-9402-a953-a637ece495d2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:6ac9:f949:139b:ed22]
 (2607:fea8:3edf:49b0:6ac9:f949:139b:ed22) by
 BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 16:01:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d12d870-a0e1-413d-019c-08d9b4e3d692
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1945E778CCE26F1F29736D01EA689@DM5PR12MB1945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vU2WGPeXkAPCcEuLdQ9A3wE1ZMgCmE37sDLQxvOhZiNlmb4uOVB4UhEb5LWkBXhjv/dANOZrIjXdAP2BPysZFMBXf0oXOq8IykvcyqUpoOlF/LfRN0uBG5X+DJJchkhuuwlqW3cVwGMzr32DY0RdIW8weu/2oixM560wbAQdj1VPTLrpI3J9LB/2xQrjGmPuj+CcnCR5yLV/uMM0tqPqwNf2TxHOcrcWV+AxR/gYtnhXxpE9TuESODEx+9lP9ofgYKMpYA0MnUqjvYzrTER5OaO1zU3uMfdRSruzXrsZe/akjpcizicX1bwJ8t9v1sqgUNcwdAs47gnmF+TAJGem2NxudU1AXT/IA+LQrmzUg29uFF4KI+GtjkiMxJNX66o3NNo5m7F24AS44EBiTbYG+HqO+WaZMOIQ+yMyMwgRZw0W2l9kxJ0IQ/I+7MjGGzlUAf/MyCwRBEPjEeVyie31loqYy6FXZYj2jqZgJQO7HvxXCaBjgk56Gqapk4b4Nazozdi+UwCbLzC6ZB1TeO/ESHZv5vPuygvbsTPhvutcqj5kMs9PJfCnDSNiSEu3vhFw1O25r5bO4N26N3Zl0Xih5c7eZ6d1F7x8J6SavLyYQmD7ynADPSetDGYp+9jZebPpNHplxQ3A43IO6Rs1HznrMLEmK/G5K/ZZljfBVzmww3a+O3ykE37L22A25mVza2oYN9E1Di0EeDWjPZbomURPqV2IoU0kjuf60UnUKLxO7CA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66574015)(66476007)(4326008)(31686004)(38100700002)(31696002)(6486002)(316002)(66946007)(54906003)(66556008)(8936002)(36756003)(44832011)(110136005)(508600001)(2616005)(8676002)(186003)(53546011)(86362001)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hSZVNHYkd2Rk53NUQwL0RTbmYwNkJTZGhNY0dScStHOXZ4TlQ1ZU5lUHFY?=
 =?utf-8?B?c290ZzgraE9XQWV3aDJLZXZQSzROcW9xYy9QaWV1MnA3aGluSzZCZ2NqbldU?=
 =?utf-8?B?VThRV3Fjc3BLZllDTWp0STZ5d0tKK1dYTE9RNm55ZU0wdk1VdDU1eS81QVJL?=
 =?utf-8?B?VTVpcVBsMVFkSHZxR1VaTmNkeldxYUo1czdTOWFNcmlkcFNldFlxYWZlVTFz?=
 =?utf-8?B?dXlobXh0SkgrYSswRlBxL1FndlNDdzZkSGJDblpzNTNvSWd2ZjJua1RabzFS?=
 =?utf-8?B?cmVDc1JBTjZXVDJENmtzeXVpWDBQeitWQjlrWi9qdXR4bUZQV1BLWHRkWHQ2?=
 =?utf-8?B?UlAwcjJpNjBPbnhUNWxaZDEwNk9HOWZUTEV0QUV5TVdHVEFJMzZXMTNSVlBV?=
 =?utf-8?B?Sy9iTHhaTVREcGhUcVFLNHFHTXlZTzd3NnBlZHJ0WDI3R0sxQlg1ZThrYktl?=
 =?utf-8?B?Q0I1UEwwWUN5bTFHd29Rc2tTaEJoWmxDUVNjNnBlZWJSc2ZWTGJmaXNpM0pI?=
 =?utf-8?B?T241K24zT2NZYWdXc0QzYTJ1cWhKU3p5bHcyWUxNanJyMmhJWjYyM1E3MHBV?=
 =?utf-8?B?SE0yaThIL21vZzZwUXJEM1p1N2JETXduemJSZXhtZjNKUEpxWC9kMHg2S0pr?=
 =?utf-8?B?N2hGYm96dlNwL0xIL0tORVc2Nmt5amg2SzFNY1ZMaXM2WlJXZGhPUUFJd3M5?=
 =?utf-8?B?R0JWSXRPelQrQzhxUGdsTGx0MkRsSG1WZkYrcXEwdGM4WUpHa01QcXZWOE55?=
 =?utf-8?B?N3VCTTFCMUkrV21Wem1CVkJmaG9YSXF1SjNVWHJBRDNGVUNHamk3aGg4ZWtx?=
 =?utf-8?B?bFdDemUrVGpYeFp3aVNkV1ZzV1dIckk5czVCem53OVR6MVFNTnRrelYrelVX?=
 =?utf-8?B?d0IrMkRlRkRtZGNaZ1VPakhta1kyS1kxT0c0VFV1R2l2ck92WTdFTzhjaWtV?=
 =?utf-8?B?SXZ4bGJCUGYvL1ppWXNGZXEvQVlOOFpQSFk4ZnJQeSt2SHRlUkU4YjgrQS8y?=
 =?utf-8?B?K2VxTHFPN29IUGdGU09Nb1JNaFg5ejdndjBnZ0hLVzgvcjU5anVSczk3aWJH?=
 =?utf-8?B?YWF0WTNubDJGWlZQUVhXK25rYTE5OHBpWC8vbjIvTFZreGU4SU10eFlLQzQv?=
 =?utf-8?B?N0hwT20vUUpZNXBnMzZrdG51VkdzRUdpbWdZNGFnamMrSkVzQTNXRDFkYjdq?=
 =?utf-8?B?c2xYV1kraTRGSERyOWdOdWJnNGY3eWllak9YSXdXdE4zVG9WVDlZWVNTdWta?=
 =?utf-8?B?THVBWkVJSVRJRGhuWWdUajRCREVtOTBuamhqVDFrU3NKczI3VTRvd01pRUdk?=
 =?utf-8?B?MmhCcEpMUk8zNDJuSE10Ly81VHhQYkhEbnpYOHllaVhGY3JXblh0dlJkR3lR?=
 =?utf-8?B?eVFJN1NOSUYyNlpSYTBiV0N4YmtzbnR6TWI1NVdmSE5xRHdINVl6ZVBMTWF6?=
 =?utf-8?B?L1BTNEtjV3VXYThKTTE5bi81QjFWTXlWaEdiQ1A4MEUyb2JMdEhTVjFtTGww?=
 =?utf-8?B?OEkzdHVQc3NJTTM5WkVhemwyU0o4YTRzem5xS29aTmZWcVcvOXk5QXdqNmVB?=
 =?utf-8?B?bG80VUZVZy9WaUZLWW5HMjU1MzgrS1FIRlBOKzZuVTI5ZzVJakNoNG5QamRm?=
 =?utf-8?B?b2JId2pEU0xvdU5rWGsrZ2tMM2xSbUo5OENVUFYxRmhRclJVaUNoMVZSTTN0?=
 =?utf-8?B?dHFWbGZTdjk4Wm9hZFJsTWw4YVpGaDkzSklxY3JQL3prQUhvd3JjMlNWd1ZB?=
 =?utf-8?B?bTErYkFicnlkNitxTmp2TVF2R3ZHcm9SVE9jd2NHRGQ3ME5Ma1B0NTBYazhy?=
 =?utf-8?B?SHNnWEdHb2NoajhJNVdseFFTZWtiQ0F5NjJaVEJBZFFLZjNvZkhSejB1SFB6?=
 =?utf-8?B?Y3o1U1cwRWQxTlpWdWg0WVJUUjFJcWFNUTQ1WVlXbU9QOHdHSzYwMGQrbG9M?=
 =?utf-8?B?cTBCbUJhdFh2ZmU3MnRNQmRUcXZ1dmhpVzA3UmZ5ZmdvTkZKVlZoNEU1ZlNV?=
 =?utf-8?B?RGFBL1dsL0Z3M2hERUN1eTkrWjJIZDAzTXJtc3dUcE1jQlZsS0lmWTVvWEZk?=
 =?utf-8?B?Rmk0YUI2QjAyUFVza0hROFJBWDFXUmp1U3F4SHdpZFh2MENQc2VsdCt5TXFh?=
 =?utf-8?B?RUVDdjF3WFI2ckt3WisxTHhFTkpVWmhWelV4L0ZsQzNwWDZkWktCM1BBZU5B?=
 =?utf-8?B?ek0vdHNnL0NMditqelI4cFVoQ2psNHlCM2tsem5TWGdYNGV6MTJOZE9WLzBk?=
 =?utf-8?Q?cyMBGPpEiea02oJhHMXQtl5QETk5QOxdt0Quj/1D8s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d12d870-a0e1-413d-019c-08d9b4e3d692
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 16:01:30.2093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kwBBTC5zievWRQjSWpwQeCY2u19UbZhCvchFzY4YclpU904tez01EOlQcTJiz508C4f7TUxV0z9Cn2mnasgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-12-01 8:11 a.m., Christian König wrote:
> Adding Andrey as well.
>
> Am 01.12.21 um 12:37 schrieb Yu, Lang:
>> [SNIP]
>>>>>>>> + BUG_ON(unlikely(smu->smu_debug_mode) && res);
>>>>>>> BUG_ON() really crashes the kernel and is only allowed if we
>>>>>>> prevent further data corruption with that.
>>>>>>>
>>>>>>> Most of the time WARN_ON() is more appropriate, but I can't fully
>>>>>>> judge here since I don't know the SMU code well enough.
>>>>>> This is what SMU FW guys want. They want "user-visible (potentially
>>>>>> fatal)
>>>>> errors", then a hang.
>>>>>> They want to keep system state since the error occurred.
>>>>> Well that is rather problematic.
>>>>>
>>>>> First of all we need to really justify that, crashing the kernel is
>>>>> not something easily done.
>>>>>
>>>>> Then this isn't really effective here. What happens is that you crash
>>>>> the kernel thread of the currently executing process, but it is
>>>>> perfectly possible that another thread still tries to send messages
>>>>> to the SMU. You need to have the BUG_ON() before dropping the lock to
>>>>> make sure that this really gets the driver stuck in the current 
>>>>> state.
>>>> Thanks. I got it. I just thought it is a kenel panic.
>>>> Could we use a panic() here?
>>> Potentially, but that might reboot the system automatically which is 
>>> probably not
>>> what you want either.
>>>
>>> How does the SMU firmware team gather the necessary information when a
>>> problem occurs?
>> As far as I know, they usually use a HDT to collect information.
>> And they request a hang when error occurred in ticket.
>> "Suggested error responses include pop-up windows (by x86 driver, if 
>> this is possible) or simply hanging after logging the error."
>
> In that case I suggest to set the "don't_touch_the_hardware_any_more" 
> procedure we also use in case of PCIe hotplug.
>
> Andrey has the details but essentially it stops the driver from 
> touching the hardware any more, signals all fences and unblocks 
> everything.
>
> It should then be trivial to inspect the hardware state and see what's 
> going on, but the system will keep stable at least for SSH access.
>
> Might be a good idea to have that mode for other fault cases like page 
> faults and hardware crashes.
>
> Regards,
> Christian.


There is no one specific function that does all of that, what I think 
can be done is to bring the device to kind of halt state where no one 
touches it - as following -

1) Follow amdpgu_pci_remove -

     drm_dev_unplug to make device inaccessible to user space (IOCTLs 
e.t.c.) and clears MMIO mappings to device and disallows remappings 
through page faults

     No need to call all of amdgpu_driver_unload_kms but, within it call 
amdgpu_irq_disable_all and amdgpu_fence_driver_hw_fini toi disable 
interrupts and force signall all HW fences.

     pci_disable_device and pci_wait_for_pending_transaction to flush 
any in flight DMA operations from device

2) set adev->no_hw_access so that most of places we access HW (all 
subsequent registers reads/writes and SMU/PSP message sending is 
skipped, but some race will be with those already in progress so maybe 
adding some wait)

Andrey


>
>>
>> Regards,
>> Lang
>>
>
