Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA41CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 08:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EA510E5D2;
	Tue, 26 May 2026 08:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ybR2Op9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3694610E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 08:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx4VzsWh0PhiTHYBWeiWv0hQyeqLXwEbr71XYx8/QLlgt+q4hu9vVWEbojgy4OoeAzwTBXjpo0B8OXN8CtKQaqE9LGxtJcmWzIJlQ/9mzHUjQYF1YqzKxHbAmZtFRw7A/MJfs41Ki80ePW/4Xh27unRP6it8KHRXghxUdK2HKsAtjZnkW3f3Dm/HblsbXpmzdnnUpfvMo9md6NS1DGKcv4Hwwuorappc6CrSmbrgUXaG16nvl7DOViRHnTa2Y4iE/UIhyYywAD010tYpJ93NlNbXEtCA45LyaoZbWtXZn1eWB9poPZs/MlRhOKCT5jqG0WSgHkkkNaTSFhgwhtxeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjo9QNRSyRFmgh+oD3DOU+13YlR6tz/7/FSmi680EfY=;
 b=mBEa5US+HgdgbPFAGRlendjSrvZ/qA55x6I1VnSyW2GXHmtUMhz9yM7KhLB60oRGLdujdhPiQmCTyZop1Skqkr0o9p1cm2Oayw1fuoay4et1/8uYOcMIJRL9UWVUyShx2F9QNM++mNsDZJkXeGrP4ql9wbhFJc8CUY+Zk5iW1qFh0oQtIPpf9Lk08dkbKhNUhupK9VkKTh5cFQYy7VaUzFqvQRf5Mdu7mnfNJMckqlbzlKO2xsX78n+G8iYBc71pOVkdwptIqGc2S5CXZd1R8U+ivBw53AXRQxhy9v5BxpjXIFbNC7XBCD80zXZJE8WgxDBYejO4Tq3DVbLEnjGDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjo9QNRSyRFmgh+oD3DOU+13YlR6tz/7/FSmi680EfY=;
 b=0ybR2Op9TNZZt9Y4CiOUICVDVZljAqcvYqVE3r+LOk58h7m9d5IfFc0kdKHqGj2bzj8pUUPkB2y1YhLhjv5mTj2EGz/jwQoq/GXJ+2jb/GJpzNgwiwsmdfAKA+PtrltTfTQUm9talcXRlFszqLr7y5kdC0Iord4V0z4yb4Opr1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 08:14:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:14:37 +0000
Message-ID: <e8bde6cc-2866-4cf1-a998-4ec6f98f1ac3@amd.com>
Date: Tue, 26 May 2026 10:14:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the userq seq BO free bit lookup
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260526025830.50987-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526025830.50987-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:408:ee::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 06696918-bda4-4aa2-271a-08debafed416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CrztswsLLTg4yR66bsClN+GjkLLxJgX7ZAdZeDU0Ce2poRj434p6qz0dvKcy7DrKGYwIc17PoujXG1WCykzPFlneCtvuDU8iVFkTzKb2iBpPHhuwkqPbQ60NWP0dOEetE6v3BGhQ3I70Co1Fx4sNKIZ63ytiDwtnHTG1A7MGINexCB8Fv7VD7WZUsgCAfUP7Gm7mkqzdIwqxNdyYvdD3GvuHdQcEFfjK5WAHI77/T3VIcuz3rbSbuq0y+6wqZLvupVcwXzaW321ezK6+eBIjczXKZpcS8XMKi1RgFklNP/+OoTbUhbMJ/ueqqvSGwtrqaPgtqR7NOExtow4u2pR9ZkpMqLqCPZPKeyRIyllaEeFutxA2ecoNhahtjVyrSNfv+Ml7VhGoHAf4LTSLfJrzEz4VrkngYuBEJpJxu5gicdgVashJtpiVWHb6s0+8yUMI1PL3bcRy/aSUsczskOfRX/5cieQFLbrAeOvBVYwfy8Vgvm/8foKf8qSaQVAW6kYCt8H/B4xrZhwu+kUao+k+dPXs4tlvEeIAKCySRw3DyLoVK+Md1kTb9UWRKg1vXv2sk7RCsbz/tRrONT8ksts5UIr5+widr+qf9PD92xDmOsFpW3kDQ54wrxLOZDmMJHwHHBWbahj8tYuCsZ+wgCuD3JD56SXcYZ8WNDGpVnBU7JG1mVFWmVFvRvYo1dPW24FB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFXTmR0ckpnMURQY0dnT2hvR0g1aTFUejdMMjNURWxRdzkvMmhJdXY3U1l0?=
 =?utf-8?B?T24xaXBCejV1RVRiekhqYjArdDl2TndDUjZJQ213NkZ5aENJN1dQSXltNHhn?=
 =?utf-8?B?Y0hvVXdJa2xIVWgxdzdMd2ZUMEZ5bXJWUXZod0pKSEJld1pTTnpLTUIvK2Rz?=
 =?utf-8?B?UlhBczROZ3ZvTVloU0xYV0kyNnM5aXkyQmlVS3piM3AwN1lJMFh2SnhPNFR6?=
 =?utf-8?B?TXlUUnJ3NW54K255ZXdUdVBCQlNXTEU1eXVsS2xmYXo3ZmJkSmlNeHVvRkhj?=
 =?utf-8?B?TlpuYlFxM2IrcDVPSzFaVUhDWVpIbGg0SGkvaUdRZUpSNjc5V01RVFVSQStL?=
 =?utf-8?B?NXBiSi9jY3pQUTQycGNObXEwb1NkVitZOURuTkpoelNoUzBQSjduandBMjhE?=
 =?utf-8?B?ZUVOZkxlSWdKYmNpVk1nYm5QYnJTM2tGaFRpMk9aYzlxUjBaajdXa2xjWXZJ?=
 =?utf-8?B?ckp4VVJPZGV5bWw3d2FoLzZ2NS9RbHRpR1NHbkZBOGxXL0FiMjRwSDV5MGRn?=
 =?utf-8?B?Zjd5WjRVNmF1dTV3OEVnMGs4RFpZOFdHQlgycXl0eGNNcXhKbmg0OUpvOWNZ?=
 =?utf-8?B?TGVCVUdVVHBoM2hBZmZ1VlhXc2I4UktVOHpNM2RpdzlSSXJZSURvamY1V2Vw?=
 =?utf-8?B?cTBxL0x4WUNOdnNGREpUZm9VQXZNRzN0c1VrRkVNblZUNWIwT09sSkVqRzFK?=
 =?utf-8?B?RXJqUkwxeTl2cmNYaTFkbFpCYXNPcUtJZnVYeGl6Q0VSSjJIWlBZZE5sUmVS?=
 =?utf-8?B?TW4waVlpK3lVQUYyejFVL3hHWFVSamJZTVVtbWdQT05ZUWlQQ0M2anN3a1Vm?=
 =?utf-8?B?Vk5Nckc1YldFMlIxRlIyVk56VzNvaVpSdUk2ZWFBdExYdXVGRkJvQ2hMNDZp?=
 =?utf-8?B?bzVUWk9jQ0c2YW9FWGpoTDJlU3NRN21pOW5iUi9IdlRxOXZIL3U5SWdzdGE3?=
 =?utf-8?B?bUh6akcyUmp0T0o2OXRoRVhKdWJLQWtialdSbzhhWkdXUUxPMlF2dmtTa1Y4?=
 =?utf-8?B?MWpJMUhMUzdwMUgwNjBXL2lEZk43d1Q2QUU0ZVdJMEt5MWN5MkJQSStxc2tG?=
 =?utf-8?B?K3NLTDgwNlREZmY2b09idFhTRXBiWGJPUWYzK1VDN0tmNGFEZVZoSCs3cUIr?=
 =?utf-8?B?THJJOWtoU3FzR1NoTGN0VU4vNXRKdTlKWEdqbi93Rm9maUN3aGwyL0pXZHVz?=
 =?utf-8?B?Nkd5T0djZHFvanBlaG1GVS95RVpuNEp4dlZobVdFdDNiN1Nka0d4cm5aeStk?=
 =?utf-8?B?UTExVCs3U3gyRUVpM2lGbW9WR28wR05ybjZaREdCamx5d3pkT1g1NnVrU2tm?=
 =?utf-8?B?OERvRkhObkI3eWxqMHBSUTdCWFFueUVjQ2VmMGVXYmluWjZUaUZ0aDkyQU55?=
 =?utf-8?B?RS9DM3o5Zjd5dWVOL0pMTHoyRWlsamp5dzkwWVdhZDlZWjZQUFB3RlBkdml3?=
 =?utf-8?B?SzV6cXNFV2tjWFpvNjdkRStPTkxDUnZMczEzOGVWRlQzZHRpQVQ1anBsanZ6?=
 =?utf-8?B?cHpBWW5FSGZrK0x2WkxaWkdlL1NHb0tBeW02SWlFRjJXdzl4N2UzOWNwZHJa?=
 =?utf-8?B?WjlyRGk1Mml2Q08xWW1NVVZHS2NkTXlBWGU0akFQTGFUbU1rTGF6bGEvQmQz?=
 =?utf-8?B?T0VibHZETndNVUMzRHkrbXpWdXBwNUhIR0FFczhsaUI1U3IxaTFtSCs4ZUVR?=
 =?utf-8?B?SldxTzJhZ0RnTUZWbTdESEcxWUZ0SStCZzBZSXJ4NGJhYkVOeTl1R3VnUTF3?=
 =?utf-8?B?a3hWWUZYbHl6TVhHdXFmMGpZWExzZmwyQnNkd3Ywc1BtS2J4T2ZPRmhZaHpB?=
 =?utf-8?B?cyszSUUyRTNpWWFxV2JyV2t5YUJNN3FZSXFFYm5nMjNvOTBJbGw4bEowR1NS?=
 =?utf-8?B?M25MS082Q0pzemx5SDhOaU0vOU5Gb3VtaFBLOHhSUk5LZlFnWDY3bTBSdVBs?=
 =?utf-8?B?S1JYLzVLQjdSZ2p4NXVsbjFZbUlpK0treDRLZmVQY1NKMUROSEhkd1E4VEFI?=
 =?utf-8?B?UjFMNzNVQkVsTHBJZXNVU3A3TVNuMVM1R21neXYvR1dWYXpVMWpCOWZORmZ3?=
 =?utf-8?B?aEtBem5JSU1FQ3hkaE9PWWoweXlwMjk5R1ppRWs4Z3QyRlpSY05ZV1dVV21m?=
 =?utf-8?B?MjhuOHhaeXBRZ3BoNkhUNEpYUTRic2xGZ29KaWExNmswVVcrVHdEYWl6RmJ2?=
 =?utf-8?B?Q1FOczlKOVk0TVJhSklabGFORDZVWlg4cjVqTWswNHErKzFXdGJnbUhYRS9i?=
 =?utf-8?B?RGlQK2xEOGUzbGJwWW40V08wME1OY0Vuc2tQTno5dk45OTRzUmYxZWZFSVlG?=
 =?utf-8?Q?Ovx7byN0DRymt+ZJQL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06696918-bda4-4aa2-271a-08debafed416
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:14:37.8250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lik5EymN3D5YmYzUL1G6XmNPEJZ0nCf4Bfe2N/EmBqvbnlShRDSkNGXV0HzigRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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



On 5/26/26 04:58, Prike Liang wrote:
> Use find_next_zero_bit() to locate the next free seq slot bit
> instead of the current walk, for more efficient bitmap scanning.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index f4be19223588..63771d6d466e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -175,14 +175,15 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
>  {
>  	unsigned long bit_pos;
>  
> -	for (;;) {
> -		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> +	do {
> +		bit_pos = find_next_zero_bit(adev->seq64.used,
> +				     adev->seq64.num_sem, bit_pos);

bit_pos is uninitialized for the first look here.

>  		if (bit_pos >= adev->seq64.num_sem)
>  			return -ENOSPC;
> -
>  		if (!test_and_set_bit(bit_pos, adev->seq64.used))
>  			break;
> -	}
> +		bit_pos++;
> +	} while (1);
>  
>  	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>  

