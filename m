Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1DBC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9428910EEFC;
	Wed,  1 Jun 2022 17:39:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9532A10EEE0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMb/5cNA9zk4Ow5p7ImztQEvkiYSVgcH8Dq3W5BKRZjYlWGQh67ScEfHNDKO6Ahts+BsUul18MfVkk7QtFYEJNgMMSb0/lSryYg+4Cgp34KQnGymIAknGcelsye0mxE9RUM8z9Yyxf+Mow5NjwtvOW4orHq8EjkoyfytpBf6vkcwk0tJKERGRFX7YKOcJw07d+X5F94kkP2enRtSQYrGabZloofYc/N3if6qn/5xg9xiYb8c0xkjIpRyq3VxJJG0Wc31wVr8q0cL/mdAoWWT6vFDt2U20BjI+P9LrsPu8IRXXjZhigWYtxrbjG7RTlD4HcJ5O8s4eBWMzDy5LAtGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evb9agiTdq2Wn4HwsQamDDDBw+DXyIQyzyPiJF0HiyU=;
 b=KEwnDgjk5EjzWWsCRNkk/BFbLB+wN1qWywXOW4jsQZIVuyxFIcTM86nUtGjpY4AbJvSrQscIDd05VoB73vas9fuy+5rJN2I2ywpULOEcNjOodKzXeVSLfj/rFMEUVyIganF/qqiuhpu9QcXckOGls+QdTYUIoqF5lTNcGICXa2qQiw1T2pBZZWF7vLzGwC83MEdkcR1ln9UKp4V1TYFzJpn/Xtcinl1L+/pFizja119EvxM4RL2IZZi/H/RU+VQ3rN2KGVtonq/WC2sSbMKVt4wWWPhFJk4ChagMHROlgcIrJiMeIi6NittCTzVkWUpR+WxHHW0hQ+glzGJMSqoVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evb9agiTdq2Wn4HwsQamDDDBw+DXyIQyzyPiJF0HiyU=;
 b=ytquVH0ObVzqDcg6qc24+l+O9nPM9WYWTX0l9CfNYwFwDJTAQyqM6lMj4wPBkWi7O2/f5z4Xx/QI3l+Rgce12wcquMj8dXpcskkytSWxJYecp3uFC8cL0DIPmw1j+BRUHIW4n/nAXARmFF1jvB9FRRR3C3oat9BWc0MPH05cnSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 17:39:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 17:39:31 +0000
Message-ID: <58b622db-3a30-f6c5-cdda-0136d85b531a@amd.com>
Date: Wed, 1 Jun 2022 13:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
 <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
 <412a23fc-eb92-8f3c-e339-0bc3918c0f18@amd.com>
 <4d563bf0-ade6-fc3e-9de1-cc2522c4a57f@amd.com>
 <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <743af352-bdce-a69c-7ecc-2fc99441c82b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0dfdee8-ca90-45f1-3eb6-08da43f5af1d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3823:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB382301D95CCA97B6B2A2E04C92DF9@MN2PR12MB3823.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0p5nvIysGBBIZDEfTncOesgPGgfNQJiqEkfTipqLGrYxwf1evVGm7mjMoTX8w/R2YUT9a4yEPPzcZHc5ux3NIN4x5Jz+dk+tMv8+gSn4Szs4AODQeT10ZZLQCMz8zI2EgZTpN5j6zHF1f68Rz39uajSCSnw2z99Q4Ey/pea53EakA/Jk1TgCDNxKMaDB8MoCPoN/AjJa16SpdEpJnTNZtdN1LzGwAWyStz6i0Y8P9Rg+yBtRtNYK+UCcJIUM0aW3zuYGZcF+R1nR0KAETxHPWWF7qGwnjva6UWcO8uLiiSova1ThQbTa3ZxlBfYnSREmvl+SP106OvJmq+h44EyklAH6LD3SsCZILOVYycdutpI4HYDIKkg3O/EOsWA3NwY4ofMJV8AVAoS8fr9uvzfCLsouSC+1bR5TmCq8h7XFNctW7bPHBu6lM0FEHUcrZYPHd8Rk5CbKYYGkG9Nv7YLYXWo7eh1P2eKABNwZI7EYvQQ4y7A/D8EgGzTwuyZNJw/ijchLAqMDIfmZBcrJbaSqddv8Z03LWysLUvfheOGHnAVTYJ1xbYp1cggtcZvWVyxf5tg3Mt2Y+DAP+HpoYS8USgC3v5OJjYjv5Rcj+rHm9hQoudbP2E6O2FGpA4e3//zS4gmV0rNR3Ch3GqdI1sORMJD8kkE9wYSZ200FN9xFmFU5iUYAvW3ibWf3ezfRarS1XwX7xwGdnOcdKh+39uTocz2HpBLuD6Bg9BYsEfnawTWQNU6a08lKi8o6ehZBNYP9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(44832011)(36756003)(66946007)(5660300002)(38100700002)(66556008)(66476007)(110136005)(7116003)(4326008)(8676002)(66574015)(2616005)(186003)(31696002)(2906002)(6506007)(26005)(31686004)(6512007)(86362001)(15650500001)(3480700007)(83380400001)(316002)(6486002)(6636002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFl4K3pKNEZWWi9NZWdJcURCSU9IQ2JMV3FXN041U3pvWmcvVkxrY2hKVC9I?=
 =?utf-8?B?MWVvaGRxMm5UVUxCSDMveVByckZheHE0MGp3MkVCKzBzT0VmN0JleEhoMDV5?=
 =?utf-8?B?RlQ3S0JHZzk4ZkVLUWNjVDh5UTkvSUpvN0FYWVlpMUFEaE55d3RCV1h1WGxO?=
 =?utf-8?B?dGRSV2wvMXc1UzNmaXhHQWhnaDd3ZGJVei9KeldHaTFSdVJhVmVSMDJQTzRC?=
 =?utf-8?B?S0VaV0F3MDNOLzNHb3QxcmkydS9aWlJQOTNTOE94a3ZkV1pGbzhCQ3BTZE1l?=
 =?utf-8?B?SXh2Zmw5Zy9TZGpjSVRMcG9BTUFiQTRhZ1JFeThibmh6THlsT1pMcURUN2dk?=
 =?utf-8?B?TjVnVVVmQ1hBV0NNWHZzVjhyNGl2NWlPbC9YWnF4c3RWOTJLczlYVHBZOHJ1?=
 =?utf-8?B?eE5TU25FNXNiY3d0ZGlKSGNnendaZWhvaW9HQnVFdFN1dGpWelRldzNaa0ph?=
 =?utf-8?B?Yk5NYUk4QmNzQmx2SjdqemlKait4Nmt2TGwxUmdDQzZmUGhBL1kyM1JCV2Qv?=
 =?utf-8?B?NHJ1WUY2bmQvdURMVjZwL3pBaVpiVUh2TzFiOXZjZFpUUERHZXdkZXN6OXZj?=
 =?utf-8?B?Q3FOaUwybmJDUDkza25sN1htNkJHTUdHSjU1Nm04bEd3aHZUcnp0UEphL29N?=
 =?utf-8?B?ZGdLVmhoUkx3R0Z6RjgzNXJiNUNWKzl0VjVmeW5za2pxREpaSjF5THpublI3?=
 =?utf-8?B?bndkVlVPeVlLYlFleXJqYTJvUTc5UldUYkNkazZaZExPQVNKbnZzcFVSNkNw?=
 =?utf-8?B?b3JKOFU1RmZmVExTdnhrYkpjK2d6a09BbUEwTC93MWtvS0d0VlFmNjBycDN0?=
 =?utf-8?B?USsxdGliSEN6RXAyWVBCS3Q3dmVveU9vNHJNcWlySUVzbURpNzArR0llakhQ?=
 =?utf-8?B?NlV1Skc3OURoUFJIa3BNK1dldHJrb1ZSQU44SDMxTEZERWhoRGFRZ3IwOGE5?=
 =?utf-8?B?aHRHRHFRZDBwc3NtTzhHZnNaeHMvdVcvQk5lbFA0WGNGV2R1Nk9UZnNLZmNV?=
 =?utf-8?B?UkhMUCtxZzBWWGRTOTVSRk9qdTFwZEVVYzc1N3FsMXBvclJYU0NWR3JFVGZ4?=
 =?utf-8?B?S0VJYzVKdjJDMnoraDNndlRiVnY3QmJESEtkR3FtWVNsYmxyYllkTmtEVnRM?=
 =?utf-8?B?WjArTVdUTFZGMGZMOUVmZ1hZKy9Ga2llbmNueHdnNURmbldnc1ZaWG90TFc2?=
 =?utf-8?B?Qzk3dHJOTmhWVmV5eVlFZ2tUZU02THZQQ0Nwdi9PbkNmMTZWOHF6NFUya1d3?=
 =?utf-8?B?b1BiZCtGbDdWanBwVE9VZHk3RldYYlVNL0RzMEtLR2Rsbmd4endNNFIyRHcv?=
 =?utf-8?B?Z241TE1DYzFJZFhyZGdETzhpdkhJd1ZBaytCRlYyRnRPbGhsQzhsaEVMTUR5?=
 =?utf-8?B?TzdqVmxCNEc5R1JkUCtaNnFtcmtYWUJMN2hXK095OGFNOUI1NkxNNHk3Z0dh?=
 =?utf-8?B?NCtYbWJrVHluSzVvczVyUFRKSGdiZTVSaUVSRkcwaTBwZkdWN0xoY3lQR0Fi?=
 =?utf-8?B?VUU0cCtLNEJscG9IUnByZHN1MzFxQUJkUjh1a1NHQ0MzWU1aN0F2bUVmRGds?=
 =?utf-8?B?YTA2K29UYmN6MTRxcGNnczR6bDJVM3V1a1Z1RkF4WklpbGZmZGRSRUJnV1VX?=
 =?utf-8?B?MlZLWEFRVnFGd29aOEx0VEsvd0hTSjBwZjR4bGlUMzkvN29iMUtzYk55WU9M?=
 =?utf-8?B?VUxuckF3NXRGTUtOWEd1b1NPNVorUk5BakFiVnhzS2xJdG8zOFB1MUJJS05z?=
 =?utf-8?B?bndheENQRndrVmgybzRLWlV2UWg3UGUvdS9EclIxcFFnMjJ4SmtGTDd0OS9L?=
 =?utf-8?B?R0JmR0hCd0hnUHN1NFVncFJJeEJJYnR5Ymd0ZnA1c0NocDk1Ymh1MTM5c1RM?=
 =?utf-8?B?M0MwMVNSNEJqTnBRMjZHcnBhVExaSVJvK2wySmtXWXZXdTVkN0xnZDJiVk5v?=
 =?utf-8?B?OFk0K1Bnb1FpQUx0UWczdkJ0NXJzczlUTklwNUZESTJDYTRwWHFhY1pBc2dU?=
 =?utf-8?B?Tk5hSjlqY3dBYk5FaHFnUUxLVTNFdHdpaTN2VXRWKzRlMHlkT3h0U0ZQeDhT?=
 =?utf-8?B?RW1pZ1gxY0dtSFVCeERtU3R4V2dsNmwzbVdsQkl4S1lwZFZMOG4zNmVtaXBQ?=
 =?utf-8?B?U1ExTkt1aHNONjNKZU5hdGZYMXlYZ0U2dnNEd2dienMyOUpOSFR4RWZZeTdZ?=
 =?utf-8?B?MHZZSmMzcmk1NFVyMG1rK2JBVmRSbHhnMmJndVV0eFVuMThNTHV5MmkwN2lt?=
 =?utf-8?B?OXRnYU1scEZrMHdzZ1RXYjljSnowYkdMR1FESHh5ZXpFUk5qSHBRK2pEdnAz?=
 =?utf-8?B?SFBSZHB3UXZnRWVFaUFoWmVwSGlwRmJrOU5qdDYxZUNWaWxiQTVPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dfdee8-ca90-45f1-3eb6-08da43f5af1d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:39:31.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra9a/9QNEWIB/1e4veuZ7sjDoBj+rEWI+ch8oM4bTcKO9BrmJgHsde1jAzNdta/M1UwGszIzJK12W50TdL2IBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3823
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-06-01 um 13:22 schrieb Christian König:
> Am 01.06.22 um 19:07 schrieb Felix Kuehling:
>> Am 2022-06-01 um 12:29 schrieb Christian König:
>>> Am 01.06.22 um 17:05 schrieb Felix Kuehling:
>>>>
>>>> Am 2022-06-01 um 08:40 schrieb Christian König:
>>>>> Hey guys,
>>>>>
>>>>> so today Bas came up with a new requirement regarding the explicit 
>>>>> synchronization to VM updates and a bunch of prototype patches.
>>>>>
>>>>> I've been thinking about that stuff for quite some time before, 
>>>>> but to be honest it's one of the most trickiest parts of the driver.
>>>>>
>>>>> So my current thinking is that we could potentially handle those 
>>>>> requirements like this:
>>>>>
>>>>> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. 
>>>>> This way we either get the new behavior for the whole CS+VM or the 
>>>>> old one, but never both mixed.
>>>>>
>>>>> 2. When memory is unmapped we keep around the last unmap operation 
>>>>> inside the bo_va.
>>>>>
>>>>> 3. When memory is freed we add all the CS fences which could 
>>>>> access that memory + the last unmap operation as BOOKKEEP fences 
>>>>> to the BO and as mandatory sync fence to the VM.
>>>>>
>>>>> Memory freed either because of an eviction or because of userspace 
>>>>> closing the handle will be seen as a combination of unmap+free.
>>>>>
>>>>>
>>>>> The result is the following semantic for userspace to avoid 
>>>>> implicit synchronization as much as possible:
>>>>>
>>>>> 1. When you allocate and map memory it is mandatory to either wait 
>>>>> for the mapping operation to complete or to add it as dependency 
>>>>> for your CS.
>>>>>     If this isn't followed the application will run into CS faults 
>>>>> (that's what we pretty much already implemented).
>>>>
>>>> This makes sense.
>>>>
>>>>
>>>>>
>>>>> 2. When memory is freed you must unmap that memory first and then 
>>>>> wait for this unmap operation to complete before freeing the memory.
>>>>>     If this isn't followed the kernel will add a forcefully wait 
>>>>> to the next CS to block until the unmap is completed.
>>>>
>>>> This would work for now, but it won't work for user mode submission 
>>>> in the future. I find it weird that user mode needs to wait for the 
>>>> unmap. For user mode, unmap and free should always be asynchronous. 
>>>> I can't think of any good reasons to make user mode wait for the 
>>>> driver to clean up its stuff.
>>>>
>>>> Could the waiting be done in kernel mode instead? TTM already does 
>>>> delayed freeing if there are fences outstanding on a BO being 
>>>> freed. This should make it easy to delay freeing until the unmap is 
>>>> done without blocking the user mode thread.
>>>
>>> This is not about blocking, but synchronization dependencies.
>>
>> Then I must have misunderstood this sentence: "When memory is freed 
>> you must unmap that memory first and then wait for this unmap 
>> operation to complete before freeing the memory." If the pronoun 
>> "you" is the user mode driver, it means user mode must wait for 
>> kernel mode to finish unmapping memory before freeing it. Was that 
>> not what you meant?
>
> Ah, yes. The UMD must wait for the kernel to finish unmapping all the 
> maps from the BO before it drops the handle of the BO and with that 
> frees it.
>
>>>
>>> In other words the free is not waiting for the unmap to complete, 
>>> but causes command submissions through the kernel to depend on the 
>>> unmap.
>>
>> I guess I don't understand that dependency. The next command 
>> submission obviously cannot use the memory that was unmapped. But why 
>> does it need to synchronize with the unmap operation?
>
> Because of the necessary TLB flush, only after that one is executed we 
> can be sure that nobody has access to the memory any more and actually 
> free it.

So freeing the memory has to wait for the TLB flush. Why does the next 
command submission need to wait?


>
>>>
>>> User mode submissions are completely unrelated to that.
>>
>> I mention user mode command submission because there is no way to 
>> enforce the synchronization you describe here on a user mode queue. 
>> So this approach is not very future proof.
>
> With user mode queues you need to wait for the work on the queue to 
> finish anyway or otherwise you run into VM faults if you just unmap or 
> free the memory.

If the next command submission doesn't use the unmapped/freed memory, 
why does it need to wait for the TLB flush?

If it is using the unmapped/freed memory, that's a user mode bug. But 
waiting for the TLB flush won't fix that. It will only turn a likely VM 
fault into a certain VM fault.

The guarantee you need to give is, that the memory is not freed and 
reused by anyone else until the TLB flush is done. This dependency 
requires synchronization of the "free" operation with the TLB flush. It 
does not require synchronization with any future command submissions in 
the context that freed the memory.

Regards,
   Felix


>
> The signal that TLB flush is completed comes from the MES in this case.
>
> Regards,
> Christian.
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> 3. All VM operations requested by userspace will still be executed 
>>>>> in order, e.g. we can't run unmap + map in parallel or something 
>>>>> like this.
>>>>>
>>>>> Is that something you guys can live with? As far as I can see it 
>>>>> should give you the maximum freedom possible, but is still doable.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>
>
