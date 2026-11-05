Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C78606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gD0zJxrI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2273A10E078;
	Thu,  5 Nov 2026 22:13:30 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C7610E078
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 22:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrSXf2eYvYjr2hl9eFfyVu+4Kc1HquxEvJ/SpzPABWBYNmTC79qlN3u6pzPcRg9VBcbe4349UOCeYoatO3OD2IZjODW7AdKJkaUVogUhhB0QZX1BZWpi/s9PmaxrhGKs7NL5OTwH0HnveqFjcxwFMVnnaAQvh2FE8ia3g+41FzXpWoRRqstd6vuXJBhFz42sE0J8fDoR70GVJa1pr1p7CH6Koa0gXnypa2OfG86L/Ro/cNz1bjMfeU5RK+qKkZbZqQJAlGO3xFBEDNgOM1D90CnhyitSZ4JMllCNvNVqauTDQRDBOhPtOyClcCk21Slj8l08VB8yO/JxFRQSd21R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCOY14A1fjwJX1oQFU7HE8xhrP5gn9QfKssc+zQNmsM=;
 b=QdpJvV//kz6AvzxBeD7sxlXz9iQ7CcTQxCKuHhw8xRipwvFsGPL/I+Qgp0gWDaDLodicQ6hMoSyA0q3/rWipffp5mUlSnBujdF0OHho3TY9FYgu8jcjzfNPR1dN9K/4rgOUTZJNl86PAWfeY85MqhGLbytUBnxJLHNJEonafoxtqeuWylWNGAa7FrYN6/KqJByX+tU8Dy+5PvblZtWvgxAcbZiqk5Kwkzmz4vsGiKnS9twTngNswDPo6BH/TDS6aLVjcMAk4dizUOU6KoLY/s+7jnCq1/bdejOVcvq/9A8h4W37buTX8aEZkagd6tYuvpqzidPMeGKmqZjN+bYMTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCOY14A1fjwJX1oQFU7HE8xhrP5gn9QfKssc+zQNmsM=;
 b=gD0zJxrIbMfgIsLM/u3bfLpHze6cXeuHXdnFrCrdZHvRC0hYTVD/P80EximbvNMYFgPRifkNERYtr4T5V57fpQ0BlzyuzDJieSVn1hSFFg+xINKvTDR4yIX5WZy17JIJSEK+T6PVFiBaso9uZfWMdYyN7psnPqZfffk756x/T3g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by FT1PR12MB183566.namprd12.prod.outlook.com
 (2603:10b6:170:2b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 22:13:21 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 22:13:21 +0000
Message-ID: <416e7bcb-dc8d-445e-af14-914b08005f4c@amd.com>
Date: Thu, 5 Nov 2026 17:13:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-6-mukul.joshi@amd.com>
 <01e74b6f-3eb4-4ddb-8288-fdabe4efd943@amd.com>
 <c5317b23-66d0-49d2-a011-0c210cb3aa98@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <c5317b23-66d0-49d2-a011-0c210cb3aa98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|FT1PR12MB183566:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d20ee3-179a-4908-2ad7-08df3b8a00e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|4143699003|261021123027099003|5023799004|261102130727099003|261009223027099003|56012099006|261021121427099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +2Ec9L1aVdQ8v/NDniKl9Nxy+Y1kCWaamj123Ot33Y9XzpquOCHgo5ynwrh8yPE/sYfP0bGKts+N/F3bqwCVtqQD8BBch66eWnd9scKwzFsr1h6Nzrdg/oRWopQetUakfjFTsxI33hV13jzQmvTK1pxdLccAi8rtGVZ227OEkLfmD5y2+0iltv9yndG9mDxwmaONxkOlxrnFV1jEpudtiD314x8CroYgFBRO/BA96JW3BuUo7T9Nrliv4NEISqFW8fHFlNsZiQr1W/VJQOPBxkUDmUmFn+C65NsT6wCZ9M3WGbHH8hVVsolR1KF1IgdM8ZOiVvVTwbivq/US7nMIEvd07ODrTkxiwhqkaI1EHBOn6bFeiGNIkeMln+jyv+jNVo8M4mNjAmmb372+WkjZN8F8GsWHI3f71ZKxJ/PZtAU8fVFvmaDny9dRwHScWDEAgS/VXHXSAhoTgMBbTQ0/ZKB1LiHvtcoZS7nUBH+fMhGWQPMm9To2L7s0BWARMKnFG9JcnG7166Gowhzm0UsOGhw9jycUMHiIVeJxkDr8LM6CpDJri98iLvtqFu2e3eqHndNibZgUS48tiwgjUXRta5ItBFDOki0gm3RXVTcmTzBFu1t7eSBflq+mCatQL1BHK8tuHNV7BKri6dfpuNevmjNSzEuvCDauoYIPnKPOt6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(261021123027099003)(5023799004)(261102130727099003)(261009223027099003)(56012099006)(261021121427099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpYRUtHRmRZeEs1NFJFdWxNTTFtVm9QU0VSNzRDa0l1T0xPZmFpNGJlN3NW?=
 =?utf-8?B?a3NRWmJBMUd2a251bDZrYlllTWptQXNUMzkwNC8xK0F6dENVUWt3L1ROZk84?=
 =?utf-8?B?QjdwN00vQytWQ2xJSUFkeWVQZ1JrMVc4bWk4TDVsakp4ZGtKWFBkMGFjVUdq?=
 =?utf-8?B?cWViQjRaNHBmMUZDN0hCNkhWRzJrUXZCYjJmZ2V0OHczYm9KTFVHYm13S1Nq?=
 =?utf-8?B?aWI0VUJaZzZtZzNOVmw1MURwcE5uNzRkekFZaEYvQ0RiM3A2MkR0OU0vVnc2?=
 =?utf-8?B?b3FrQnZsTXEwTEJaWWw4WkJnWitNRUFiVEVjS2ZGczhqZ3VOQ21rS0IrZXVy?=
 =?utf-8?B?L0pwbXJrL1hWYUYxWFBSaFlwZmJTTnJxczN6eE9aZFNETzM4QXNtNWxScFZV?=
 =?utf-8?B?WHhZb2RhNnlsUVVES0x4OWF0anNZRG5NcDJoQytoVFg4WnM4M05lb3ZyWXFa?=
 =?utf-8?B?QzZDQ2FYSjJxZWcyOW5OdWNEWkQ2bzhBV3psQ1A5OFdXenJBazNUM3l2Vmg3?=
 =?utf-8?B?N1REZFhVTGg2ckxGV1Z4dHI2c3VIZFZXQnNjQ2NycWxxK3p5ZE9nS1VLc3Z5?=
 =?utf-8?B?LzJlQmUwRmxIMmFvWmpOZ0xrWTRSMFF5SFcvaTkrTHpmNVBKa01IbDlrUUVP?=
 =?utf-8?B?TVBEVlZoY3pnYVdPR3JhVEFqSWc4bkZ4UG43WHJ3c0tqNUwvYW12dDB4NzRH?=
 =?utf-8?B?dktUVmt1bzA0M0dNRWV5ampXU2FGZnFMMzhNSnoxUFIrMmxRdUZRSFc5ejRt?=
 =?utf-8?B?ZkRKMnVXRHYxNFREQnRieG5jUTcyeWtTU3pYYXNzTE5sSlFuSmNnYXQvQTJj?=
 =?utf-8?B?eHhyYytvU2lvS3BiNEpWbFBFYk93eGd5RkJ4OWs3Nzg0VTQxM0dqVG85WFo4?=
 =?utf-8?B?UDRHVjI5Qk5DYnhxQVBUS0ZWS25id1pRR3hmVUFXbVhUamxtS3FWUHIyelVS?=
 =?utf-8?B?Z251aDB3RnZqbUdSSThHKzBYdW85UittVVNqeDRLaVM4bWpaWUlFSkxJRUJQ?=
 =?utf-8?B?ZUhtdlVSdkZGNmxQSHNOamZGeXRtWUdaQVhMOUg2MWZVd0xCQnhTMktiNitW?=
 =?utf-8?B?S0tDTnVxd1FTL2FFRUZLbHBnalIxNjVtZWh3TmQ3MXFpTDMyZVdKN2tMYXVL?=
 =?utf-8?B?bzF5QUhOWFJKVnc0SmZaMFc5VXdLZVJCeUlhWlNjdWtVZnlkRUhadHdpTlNC?=
 =?utf-8?B?aVFXdGQvb1lOWnhOeWcrVjQvbHN2ZXJwS3dsdHVoSDlpSVdBM1dnZjJETjlL?=
 =?utf-8?B?eEtyQWpWcS91NDlseWNDMzRMbWYxbjJyZHI0MmlTSldlMVBHclNvOEpjUE4r?=
 =?utf-8?B?WVJVSU1Gb1VvMm9tVlhLMkl4ZVR2NmRqN3pFQlRjOFZJblBpZHk3b3BubmF0?=
 =?utf-8?B?anRZcWczNmZBeHd1ek1KTWZJbWJWd0xlNjlTSndtU0hEY0h5RGszd3BqTnR4?=
 =?utf-8?B?NVN4YjNtVE84c3JrUUpKWGoyWVduUE9XSkpiZTFTUG5iYVhDK2hSaUdNY0d2?=
 =?utf-8?B?YXVHYnpCdEtQNlFiSGQ5UmcvQklpZVcrWUVqcitIZThMSkQ1L1IxUmZESlVT?=
 =?utf-8?B?d3hyQlZRczVjeUdkSW9IMzh2NEVLakwxc0hnK2I3Q1Y4bG9hZ01RbUs5L1VK?=
 =?utf-8?B?K1M1WUorbGxXWFNOcno5NXdqMDdIUWIvcE9Yb1dGT2FHYWlxL1RCeUFVV0dS?=
 =?utf-8?B?UWFyR2VtK0F3S1AzTUtFbGhjZXZpVlcvK3B6TmRJY1cxUnppS0tFaXJFOHUv?=
 =?utf-8?B?bmk1NFdrZVFLeFJmVFJ1cUI4dENuaVFYcHI4OHR4NUhLT3prbVFjY3JRdUlX?=
 =?utf-8?B?YlF1cGgyTS9aWkl1UHFUMFZmN09MbU1wSDA5c0gyMTRFZHVWSlgwY0RBMmFF?=
 =?utf-8?B?VS9SZWF5NWUvOUxLdVdqMm5jYVU3bW5wQk5MZ1ppRkVqUUdSWldlaEdGcjVD?=
 =?utf-8?B?RDNqaE9zeUNJZWRpTHhTUko0cVpnRmw1aUhUdGowRzVndGFKREdTclJnMlVG?=
 =?utf-8?B?L1RIcmxmYzRHMHk4VUsvSEMzb3BjeHNKUDdhTG5UZE9POGpjTXE5WkhTL3ZH?=
 =?utf-8?B?TWtaU010dVljNzhZM2NEWmNSeGd6V3VkVDM5MjBzUm5DMDhnUmxnc2NKWjVN?=
 =?utf-8?B?a3djL0RKSmlzaGpxTDVVdURkM2Nrc2F6dXhWR3RLZU50OC9mSDRiTTdsQzN6?=
 =?utf-8?B?YXdKNjhOODhvRVRMUVczRWY2N2k4Qm8wSU5WQ3hyWHd6OUtBUGpYME04aXAr?=
 =?utf-8?B?VERncmwrTWNsVWdlWldsVXJaSU5EMHdjR29mMFFEZk9tbHRWOXFTbHJzRU1Z?=
 =?utf-8?B?RGYvYzhEOFV3Y2RjMDRXd0dGZ1hmNkFrRXg1ZkpJeUlrQXVPQ2p2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d20ee3-179a-4908-2ad7-08df3b8a00e2
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 22:13:21.8036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdzcGTk/Oo9CNezEbY46Uri8ezWN4VrpV0pylkv7EglZG8SMrWxuZ9k21Qd2WEpmZw0uXNv/CxtVi1tqQYRzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB183566
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026-11-04 15:20, Mukul Joshi wrote:
> On 11/3/2026 6:15 PM, Felix Kuehling wrote:
>> On 2026-11-02 10:47, Mukul Joshi wrote:
>>> In UALink loopback mode a single GPU acts as both the exporter and the
>>> importer, and the only path the HW serves is importer -> exporter.
>>> Adjust the per-peer setup accordingly:
>>>
>>> - The importer's doorbell reaches the MP nHT stamped with the GPU ID of
>>>    the exporter, and the FW looks up the metadata entry by that ID. So
>>>    publish the importer's rings and tail pointers in metadata[exporter].
>>>
>>> - Skip the ring pointer resync. Both ends of every ring are on this
>>>    GPU, so there is no remote peer that can reboot and leave the
>>>    pointers stale.
>>>
>>> - Do not take the local dma-buf shortcut on import. It would bypass
>>>    the NPA path that loopback is meant to exercise.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>> v2->v3:
>>> - Move updating src_accel_id in peer_remote_init and fini to patch 1.
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 54 ++++++++++++++++------
>>>   1 file changed, 41 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> index 8558dc1a9e84..74bc8a907f5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> @@ -3976,7 +3976,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>>>   		return -EINVAL;
>>>   	}
>>>   
>>> -	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>>> +	/* In loopback mode the exporter and importer are the same GPU, but the
>>> +	 * import must still go through the full cross-domain NPA path (the
>>> +	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
>>> +	 * take the local shortcut for genuine same-pod local accelerators.
>>> +	 */
>>> +	if (!adev->ualink.loopback.enabled &&
>>> +	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>>>   		return amdgpu_ualink_local_import(adev, remote_acc_id,
>>>   						  &handle, fd_out);
>>>   
>>> @@ -5452,11 +5458,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>   		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>>>   
>>>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>>> +		struct amdgpu_ualink_metadata *md;
>>> +
>>>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>>   
>>>   		if (accel_id == ualink_exp_accel_id(adev))
>>>   			continue;
>> I think you could drop the condition just below if you change this to
>>
>> 		if (accel_id == ualink_imp_accel_id(adev))
>> 			continue;
>>
>> It makes no difference if loopback is disabled. And with loopback
>> enabled it's the more obvious way to only initialize the ring for the
>> exporter ID. Then all the other changes in this function are unnecessary.
>>
> Unfortunately, this won't work.
>
> In the normal (non-loopback) case, when AccId 0 sends a message to AccId
> 1, it writes the message to the ring buffer and wptr NPA addresses that
> AccId 1 set up for source AccId 0, and then rings the doorbell.
>
> The remote interrupt the MPNHT on AccId 1 receives carries AccId 0 as
> the source, and the MPNHT FW uses that to look up metadata[0], which
> holds the ring buffer and wptr addresses for AccId 0.
>
> With loopback it's slightly different. AccId 0 (the importer) still
> writes to the ring buffer and wptr NPA addresses for source AccId 0 and
> rings the doorbell.
>
> However, the interrupt the MPNHT gets reports the source as AccId 1 (the
> exporter).
>
> So the MPNHT FW looks up metadata[1], and for it to find the right
> buffers we have to program the importer's (AccId 0) ring buffer and wptr
> addresses at index 1.
>
> If we skipped the importer and ran the loop for the exporter instead,
> metadata[1] would be filled with AccId 1's own ring buffer and wptr
> addresses, which the importer never writes to.
>
> That's why the patch builds the entry from the importer's addresses but
> stores it at the exporter's index.
>
>
> Regards,
>
> Mukul
>
>> Regards,
>>    Felix
>>
>>
>>>   
>>> +		/* In loopback the single MP nHT services the exporter half:
>>> +		 * the only messages delivered over HW are importer -> exporter
>>> +		 * (source = importer accel_id), while the exporter -> importer
>>> +		 * direction is emulated in SW and never reaches the MP nHT.
>>> +		 *
>>> +		 * The importer's doorbell reaches the MP nHT stamped with the
>>> +		 * GPU ID of the single physical station, the exporter, so the
>>> +		 * FW looks up metadata[exporter]. Publish the importer's rings
>>> +		 * and tail pointers in that entry.
>>> +		 */
>>> +		if (adev->ualink.loopback.enabled)
>>> +			md = &metadata[ualink_exp_accel_id(adev)];
>>> +		else
>>> +			md = &metadata[accel_id];
>>> +
>>>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>>>   
>>>   		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
>>> @@ -5464,27 +5487,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>>>   			wptr_gpu_addr += wptr_size * accel_id;
>>>   		}
>>>   
>>> -		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
>>> -		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>>> +		md->header = AMDGPU_UALINK_METADATA_HEADER;
>>> +		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>>>   
>>>   		/*
>>>   		 * remote shootdown type is 0, remote command type is 1
>>>   		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
>>>   		 */
>>> -		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
>>> -		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
>>> +		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
>>> +		md->tlb_inv_rb = rb_gpu_addr;
>>>   
>>> -		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
>>> -						ualink_wptr_offset(adev, accel_id);
>>> -		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
>>> -						     ualink_tlb_wptr_offset(adev, accel_id);
>>> +		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
>>> +		md->tailptr_tlb_inv = wptr_gpu_addr +
>>> +				      ualink_tlb_wptr_offset(adev, accel_id);

OK, I missed that it's still using the accel_id here to calculate the 
offsets. So what I proposed wouldn't work as needed. The comment above 
explains it too. The patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>>>   
>>> -		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
>>> -			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>>> +		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
>>> +			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
>>>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>> -			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>>> +			md->ri_rb, md->tlb_inv_rb);
>>>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>>> -			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
>>> +			md->tailptr_ri, md->tailptr_tlb_inv);
>>>   	}
>>>   
>>>   	r = adev->ualink.msg_ctl->send_metadata(adev,
>>> @@ -6069,6 +6091,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>>   	u64 int_wptr, tlb_wptr;
>>>   	int r;
>>>   
>>> +	/* UALink loopback: both ends of every ring live on this GPU, so there
>>> +	 * is no remote peer that can reboot and leave the pointers stale.
>>> +	 */
>>> +	if (adev->ualink.loopback.enabled)
>>> +		return 0;
>>> +
>>>   	/* ring->wptr and ring->rptr are owned by the send path. */
>>>   	guard(mutex)(&peer->lock);
>>>   
