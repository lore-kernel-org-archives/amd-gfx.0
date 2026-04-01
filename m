Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320FBD3514A
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 07:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9C310EE5C;
	Wed,  1 Apr 2026 07:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q8Mpbzde";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECABD10EE5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 07:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAy9wo0UeIfOAr2/44r6BApYetF777tPg6+8ZpPecqqMfv9d4PxYv5f38nAVhRmgn17TipH+mamAdxCaGZ2Z8d4CEPclYiP2Ow3gJcMZjJP9dCJXOb/wI1v9NgpQBlVXvS3sC5x3R6y95EUADCjVopUPPm0QPkB/BIy5NH4W1U2IB4o8RFz8POHr95KHj2OUp9nVmZIYDXYLM8NzUQq51rFgkOgFRoOxBmHaHaiagj2+MvfMEEYb4QzJXRCONVhhHW3N30NIqFazaiycKPqJmU6GBmeHvv2NYQ0JbSwSLsfUSZKed3N2hgHnLo5lfN4mVNXWrogST+hbVUOtkVLCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZQYC1tnajkWsz6H4T1W6yIY3iMmba87HRlS7MElbsg=;
 b=TpjuqrZ4FnWTpm9Ca0GHIzAEWyUVgx+QgCi917FQpL/hTS2F0Mt6AzeBbXuyf4MYvk+8TOKXO7Xt3E1k1aZ4gzA0vHFEBvZyQ2f7zbSoYi1+SwjbigMkIc8dzuZXQKGNUhxDp+1uzr716h9VPKRWwVafIzondtfYimmQokvsZwDljUWoMiJDEZ13PSLF6TeDi9Xzqj5hGM8XPQ1gW/a/uELH8Ss4if6uBK9Qeob3fy7iOrS6iIsyragxtttQHg6gT/FaI+CRRy6S5BYH/6VPGbABCX0fs8hWbABBZdkYzJVGP8abS2zGUjmuTUX3uhBL1E9nISELFkS7gYiqdya/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZQYC1tnajkWsz6H4T1W6yIY3iMmba87HRlS7MElbsg=;
 b=Q8MpbzdesI/R4CbgSRtx19X9xEYFysLoMQ/jEeM69YxtOzPqyKmesx/ETqbg3ij19h1ZoCL3EJYD5VebV8xZKOtWHj6h9YbepdJGa3bsQsIIdkjXVFHbkKcTdumaEdTOHO9tnId/IpoUyhv/cAowFbo9r3FWAgeptqosxXchKLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:13:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 07:13:27 +0000
Message-ID: <27724c57-25e9-407c-89b1-790d8fcdddbe@amd.com>
Date: Wed, 1 Apr 2026 09:13:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ
 SDMA MQD
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
 <4bb97e2d-b654-42fe-b680-03989960c2e0@amd.com>
 <DM4PR12MB5152D39FF0D9571E3D4B88F9E350A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB5152D39FF0D9571E3D4B88F9E350A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: af5324b0-8a1a-4c50-c449-08de8fbe2b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MYOQQE+YM1eGDcAIf9rBWxfBPWmTgZLW9xOViaQ7nSB2dM5EyPX7USw66nCrhb1UELvwtflOXXCha332wwl2n5W94L9Q+WFfUJ9wsZogZ9NIzHSERcRdy9cp4oaDd5JbufAVd4kNJ+fH1Yd5JB55nLNFGVlRoioiiHQKoGPbV8g/NDXnfrOn6EV6IG1PrihJSKz4A949iP5gaXN6NeWyzWanQJtIC14EQHCv1VM98C+7BfNBXCTGBNjkZtqY+12Ow2aJrLwRFZv7Im+4qGq6mJDzd+yxuvbvNBA+HIjqFn9A3YSSZqK5w7gJXXp7Bjhuj8bQfR6MbVk7fMEZGXXW/tLlGtiz8PfiTWIeOSCyUjOwSsBmjy+SxFHIUXod4fXYaS+bnCykkBJOc/XL+LACpzwK4F+hTGZGSW6VI9F4a0eTbwpHNmSWhxCeQX9N7Y5zjI2aA2Hl4ng1PjW4qrEnxktT7mwxSf5/877QBrsevPWrozZmNu8ug96SI3CQ8Ui7QHIporwkW8ObZECy6kL+06oW4V7A3H5YpIEE9zc7hX+pkoIt34yJymN7ldXlByv44PKJmt3uxLObJZt6Rj+tBnel+G+JzzJrgcKzY7rqDsJduIAV7xjmgQrfoSbDsuBFZs8/t8k9uko/nIbixX7MNsiWxyGDkmWSmdZrNHhvpaxOS12YIH2BGGAhebM0xGL4BM/BiETXuRxUpHJ5BKe7KF5dhR1IoB8EFVV2Pw3pqEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVN0QUtWbzVQY0tzTk9hVmV4dE9OK2JSdnVQTGhaa1hTL2pkdlNqZ1JvODJj?=
 =?utf-8?B?MTRQMTV5WWwyYWdPVXlKQmkwL3JuMXRTRmE4eUFoY3dZcVY4UUc0TjhGN0cw?=
 =?utf-8?B?ZFBubFRETlFabEN0V0w3bkVxKzVtV3BhZXZPT1d1amdqODk1cU1vWDlkWjN4?=
 =?utf-8?B?MjdUZWRIVzIxV1JKWTZRY0RKODVMb21ibGJSam5XMU5VVEkxSnJuUjBoaEZ5?=
 =?utf-8?B?S082U1dBSjZoZEwxdjhSUlVBSVhIVnNGYUhCODNvZTZJd09SaEtUdGZwdnFn?=
 =?utf-8?B?bm1qTWVLa2kwTXhLOGZwZnNncS9OMkFVbzlJYnFEQUovdG9JdlhnV2twN1My?=
 =?utf-8?B?Ym5sN1NtUXFxY3EvL1JDKzdQMS9nRC9seTlhcUxOdW9tUTJrUkY4MlJGM24v?=
 =?utf-8?B?bldtekpyMnc4Vnc0Wm9iVVhzWUViL0V3VTBrdCt5RWtBOXBIcnBpaDEyMTJ1?=
 =?utf-8?B?WVY3UWJrR09rWS8ycUlKMkFQMXRsMHE2N0xYY0xjb3hyWTJrQkFFcDY4SkV4?=
 =?utf-8?B?ek1HK1Q4NkptQ0tucTNadklMVkQyZmxodGZZY3dRK2pUZUc0SjZGbklWemRP?=
 =?utf-8?B?VDBCVTlNVWdyR2kyc3pPQk5yTnFoMk43VjliNWIxeEZXRm84aGFXZW9PdHJV?=
 =?utf-8?B?UWlnTjRBZHM5S01WSk5TNERvZkxjUEVBUkJKSGJMUS9lWU05Ulh4Nno0dXpl?=
 =?utf-8?B?dDFicjJQazVzVHpxVEQ4eFFFbDF4Q2hPS0pYcVhDNlVCNTRieWNQQ3hTVExW?=
 =?utf-8?B?Q2pySll4eUdpaVh1VVBLWE1VUFdGdTZpQ3hIc1lISUZlOGpPOUhpSlNNWWg3?=
 =?utf-8?B?c3cwOFVUYzFIcURJRHlRem9JR3BUZEUyelBtc0FqdW9hR29CcDdRQ2dIUXpR?=
 =?utf-8?B?WSsva2l1R1EwKzJzOTRWa0RYNVgrRHBKMjB3NVZiUmxIMFcwK3h6UTd4UjIx?=
 =?utf-8?B?YVpVdy8vT1B4NWVxZjYrdWpoL2VnRHRIclEyNzBKYVZmVE9KSTdhUlMwTUlU?=
 =?utf-8?B?MlNJYmJjUmVBa2FldDZYcDhVOEtjNzJnK2tjMWI1MkhHOVlEZkNZaWFqditH?=
 =?utf-8?B?VlVuRUJsbW5EczdNK1RneklrYzQ0em5HL0Q0WXgyTEl3Y20rVEhpNzNDbEd0?=
 =?utf-8?B?Z2hwU0h5K3VWd0lqWHpmTFFCM290ckorR0tUK0JLTGtXVWhNN1NLOW9rZTZY?=
 =?utf-8?B?Y0w4VmozZkNqaFFMTW5Jc2dpNngrd2oyWENWcnUzQmpwR3VZM1crTGE3VEhn?=
 =?utf-8?B?dEIxaWNBYXdrTlBZV1J2WEhuaVVaam84VmJURU9od0szeEgwWUREUDhrbWNl?=
 =?utf-8?B?aDVGZUIxM2lJai9GcUFvejBYc2krZEJLODlFTWJNdGNWcDZOTGZ0cVY2Zitr?=
 =?utf-8?B?VmhwWUlVb1UyRmZvdzE0NTQzRlNuVWt0N01JTkhORFJES1l3RFZJbDhyNE5P?=
 =?utf-8?B?Q3J1ejl0UmtOUVJCMkV1eUh3YmdXK2JZby8zUkxiZWxGbjlkRDF3UXd0NkJE?=
 =?utf-8?B?ZERnNm1oZ04rbUp5L1ovcmw0NUFNL1dYakdCVHRrbmFlb0VuTC9UTjk3cnZn?=
 =?utf-8?B?dkV1aTJmdnVneWNBSkZ6U3FwSnRQV1kxSk90VmZhSkp5QlRLWndaSDN5QS9L?=
 =?utf-8?B?NkNVTmxXUVg1UEplbkhSQU81VEtDWjFyNFJpR2pTOGJDaDQ4cDZzNTBGR2Zs?=
 =?utf-8?B?SmhiVlEzbFhPK1RuSGx3REFBZC9nQzIrK0h4VHJmdFZqTG5VL3RrdjFYcVJU?=
 =?utf-8?B?RWx2NTRrVXNsOEt6SjJhWmJPK01mNEVmelFRM0k3dk5saEhneEFPUlRFMDcw?=
 =?utf-8?B?dm9JS2V6T0Uva3phNHNISWZ1N1dSTjdBRERxdnVaSUY1NGsxcXY4WDlEb2dO?=
 =?utf-8?B?aGVqaHdKSzVPajV6Q0duS2tBczEvc1MzYzNmN1BBZHJ0R1JJZDJIY0VRODlp?=
 =?utf-8?B?RkNpa3hBZmxtNm04Skd5UGkzNlcweTI1VU9VY09Tc1hsbTBJb0xndm5YNnlW?=
 =?utf-8?B?OHlsa00wcTQ2dzY5eStncUQwN0o3d2F4Rm1TQkRCMVFwSEJSYXpYejJERWtW?=
 =?utf-8?B?bW5sVTk5NENHcVpVbXRBNlNRT2dua0k2VGZVMnNXZEo5MlZ0SG9XTEV3cGky?=
 =?utf-8?B?cnJoaTFrQkw1OGF6amNYN1BjNTZsV0ZxMVErVzdaMVpkRkFjTzlDNlJzZ2Zw?=
 =?utf-8?B?OGQzdTcrUy9mc1BGaDlBVjQwTTZaK0NQWFFWdWc3YXdNa0Y5aXR4T0I5V3Nl?=
 =?utf-8?B?NkFIbTZKNkhRS0QydHpLT21xQlhyTmduWG01VkRCUGt1SVJoMWovSjFVWTJF?=
 =?utf-8?Q?0es3e6eZ2USLfKl1AU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5324b0-8a1a-4c50-c449-08de8fbe2b63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:13:27.0313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fzLqSEjxK+vToUehlxwyV73fXTh+OnXQumE4ChuVlhG7o6PQJs+ScwEVcmDvnkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

On 4/1/26 08:59, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, March 31, 2026 7:57 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ
>> SDMA MQD
>>
>>
>>
>> On 3/31/26 11:53, Jesse Zhang wrote:
>>> UMQ SDMA queues can stall when only F32/MCU WPTR polling is enabled in the
>> MQD RB control configuration.
>>> Enable WPTR_POLL_ENABLE in sdma_v6_0 init so hardware can reliably
>>> observe WB write pointer updates while keeping the existing doorbell path
>> enabled.
>>>
>>> This fixes UMQ SDMA submissions timing out on subsequent packets where
>> wptr/rptr no longer advance.
>>>
>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> index b005672f2f96..622518483c6e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>> @@ -863,6 +863,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device
>> *adev, void *mqd,
>>>             order_base_2(prop->queue_size / 4) <<
>> SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
>>>             1 <<
>> SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
>>>             4 <<
>> SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
>>> +           1 <<
>> SDMA0_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE__SHIFT |
>>
>> This enabled WPTR polling for the kernel queue which is clearly not correct.
> This patch will not affect the SDMA kernel queue.
> the kernel ring path configures SDMA queues via register writes; the UMQ path supplies a firmware-facing MQD built by sdma_*_mqd_init().

Ah! So the MQD path just uses the SDMA0_QUEUE0_RB_CNTL_* macros to fill in the MQD values the MES should use. That makes a bit more sense, yes.

But that still doesn't explain why that should fix the SDMA issue we are seeing?

Regards,
Christian.

> 
> Thanks
> Jesse
>>
>> My educated guess is that this only works around the problem because it keeps the
>> SDMA awake.
>>
>> Regards,
>> Christian.
>>
>>>             1 <<
>> SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
>>>
>>>     m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
> 

