Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36636CCD184
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 04:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8239410EAF2;
	Fri, 17 Oct 2025 04:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnFLuGE4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8642A10EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 04:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMyhUOX6tKAUsjsv194bqFx9PuSw1yldruR5u2wh6TFEXslso9WuC8O9Ehm/S/jPA2+nbGafdVz5jFj3n/n2vAbvCEt3/6r/Cua0nXnhSaFSiUgMQ5mWfY1d9+dQaUAew4ObzujhG3p/eRO7+VNHfXey59Kjsi1vHobnbNqn5KVliaXvPje8IP1DGKyFip2BtZJ9T+1epBdwk5mO5op67Z7PeYxmSHm44niXPg7N9EdLTyjLcw5wV29nsRFONf+7/54uMapL+/hC9UPVYeNh5mCATe8ltxnbLg7+N9isW+slVLw+dvV1U3imKD09ToPunl4IhqxMZY2Q045+luC5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHK+erJr8GZtqYl0JY9ZAq94/k7wjvcjOa8lszdBu0s=;
 b=caooq4cEf9wsSOaNhAICju9GG5uBcBwHe6Qdqjuatp1oi6FRGFLa8WtUPVqHPyVk1pq15hs44sAyiUm4uWHk7mrJJ5JVb/f1dQGhryIs/75tG5EEcNvuHAksjgVkXejKkX7Qd3hkcI7paiG0w3fxf8jSknBqBatHgSHrpSPckNqLZsM+14+zRRc85OXhkge/oGpcofz2YKzsHNdXbY+lmjGh0LDII7j0T3NwEBeI5sLkL35WpYK6/cpG9ZUn1H15qC1zpPwuV4wFKPyIpEaQJLdS8Gb8oXYxethyd4ryb1Va6uN0QQPdVnX4qTt6OdUeF8D2sNodXAjm0pUiykR2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHK+erJr8GZtqYl0JY9ZAq94/k7wjvcjOa8lszdBu0s=;
 b=LnFLuGE4vkaeJj5jlDun3K2CixK6fUObISA8wI6Lbvm9qWs1QF03W3f02s0waASSc/qMK9RFKbMyNcDG7w8/GvpLWbgtW4Mv0jzfwv/o6r0/Eixl6jrttLyhvu01HitOayhksUttdKMfMX1pEAaoO5kdjtE7Q58um6+KQsWETro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 17 Oct
 2025 04:20:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 04:20:25 +0000
Message-ID: <f769b20f-e373-4fd7-bb4e-7a286461a76b@amd.com>
Date: Fri, 17 Oct 2025 09:50:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] drm/amdgpu: Introduce SRIOV critical regions v2
 during VF init
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jeffrey.Chan@amd.com
References: <20251016180219.15879-1-yunru.pan@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251016180219.15879-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f993bc-423b-4330-a293-08de0d347e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWRQSjF1NGlGbysyWXhRcitubDBnaFdOcjVFMW1tRDJSNmdNQTVtcXhSOXVB?=
 =?utf-8?B?eVE4dDd0b2d2TGl6OFNBcld2dS9kQ1h2N25mMDRMYW01NEo3a1A1UmNxVnVU?=
 =?utf-8?B?VHhlS1lFM0R4dUNZakI0SkptYXV0cGc2STJ5Q0wxbFBTTDY3SVN3NzlNV2Fy?=
 =?utf-8?B?VTFtWS93R2lLOE9kenY1SXNITmZkTVV5WTdvNVhTSFFVWDZJTHFYbnN5UkN2?=
 =?utf-8?B?T3prOUpsZ0RMV1hMODVlVEVrSWFhYklZVEdjc2lRZ0pHdWhmeVhqV1FRUjIx?=
 =?utf-8?B?V0swVDMrK0ZPQmRZVG9mMk1rT3pSSTBTeGFwR3cwcWNFL204MDNKUXRLYVhM?=
 =?utf-8?B?THBUamtWSzBqOVY2Mi9YQlgzdmR4WGgvQnRGczZ5dkwvSWRNM1RGc09WalZ0?=
 =?utf-8?B?c2RrTm8veHM0OWJXQk5ORVJGTDh0dk16MnR6M0VLV3BtNUxlRUEyV3hyNDV0?=
 =?utf-8?B?bXZoYlkxYXZmUzJtV25VT080bWllRTZlT3BaVU93eWJLZVU2RndpRnovUDVx?=
 =?utf-8?B?eG9QUmpkRkx6VFlGSVZjSnFMTXRNazhXbGxZN2tPL2kvU2xwQndsL21IeTBj?=
 =?utf-8?B?QnNPWlNZM2doSktOb2tNWmI2YS9oWUlyOWVmVC9BdjBtbzRnblhYZmVKYTVO?=
 =?utf-8?B?ajBuMFc4Vm1lc2xSMlVwb3hrdHRVVXdRWjNQN2k5Ry9VZExKVEhPZFJROHZS?=
 =?utf-8?B?OUVuSW1iZDc3bWxlNm9Gczh0dnpzaXFBVkJLY0kxUmNIQVQzR3ROcFBQZHI4?=
 =?utf-8?B?RytJL3NRdTZpVDREUmR5dmFVUUdiQjFQaTZpM0JWTUtNNUs5a2I0MkV4Skpt?=
 =?utf-8?B?bERObW5DUnk4enFLNXJEOFhZTzN6cGlWbHZ5eE9saUtFMzFDZlI5Rkl3eENP?=
 =?utf-8?B?cDhOUXpFNm51dytOM3I0U0ZRM1Z3ckNOeE1qMjYvZk55OWlRaStxT0RXcWFv?=
 =?utf-8?B?bTNlWVhmVHdJTEhWczBlVmhFL3J6NWQ5ZTZiR3lOd25MaXJWY2grWHJ6SnNX?=
 =?utf-8?B?MitRRG5QYis5N3JmNkRrL2NHNmRyOGd0b2ZQQUw2QWYzbC9OUHljMWRBazFX?=
 =?utf-8?B?UHEvT2pNVitrc0NJWGRVbWNSYlY1U3ZzdStYa0ZqV0IxakJHVldweEVYUDNr?=
 =?utf-8?B?bDJnOTBtUjAzQW9XalVicjJ3cmNCSjNRVGhUeW9ibVpFNTAyVnVzUU44ZUFy?=
 =?utf-8?B?cjRiUWNiZVJtek1abFZtclhSRG1XSVkremluQ3RXQzM1c1BaMnBKN2JOVTVo?=
 =?utf-8?B?ZnR6VjBiNC9lbGxFLzFyRXdHNHAwWEJpaTNva29mYW12VUdXTkQvVm1hMWw4?=
 =?utf-8?B?SFo2c0crdzhrUXpDb3pNT0ZZZ0M4dEsrTDZQVVlDWEZtWGROcTJsT3dqRUdR?=
 =?utf-8?B?S1Q4OWdMMUM2a3o2VFpGY2JWZVlRbi9tbi8weEtVTitVdmVLRHNvTTdGdWJa?=
 =?utf-8?B?VjFkcmQwV3ZQd1BMQkVvOXRLNHZSS09nTTBRUDh3Mk5FRUJ0cmFaTkd4amU4?=
 =?utf-8?B?SnQ3V2dvODIxNGdIajdHZ3R2UHdFRmFVNWNWN2dreVVLYjlhWUZsSmNHWUZC?=
 =?utf-8?B?RHRqcHJIVkxrVThvSUwrTFh5TS9rK05nSGc0bnk0U1Q3VEtlY1ZrTVlxcFUx?=
 =?utf-8?B?cE5GR0JhNDZkdGwwelFHWlR5Vk1DSG1rSTl3SUpnUEpqR0ovWDJDcTZ0UU1n?=
 =?utf-8?B?b1owRWh0YURUNVJhYnBKNWZ3MmM0MUxwNmVrTDU2UVQzWGtMY2lNeW9EbDV6?=
 =?utf-8?B?RFEyUDNvR00zdjdsZDc2ekFtNTI4d080aXBDYmx5UEs5ZzNXQ1VEMWcvUGZh?=
 =?utf-8?B?MlhoMmJDeWx0ZzJweVNXVHhsTlJCRFR6M2cwRWFrU25icXFrdkZBKzREWHQx?=
 =?utf-8?B?Z3BRZzRrdDdNZXV0bEJhUUpueE5nd2ZKQkJRdC9xd3VWeFBXR0N2cHZZanBG?=
 =?utf-8?Q?WuJTYSLuUK3jYy1l1a9gIeBmXGvBjRHQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXcydFlyeWFFMGtzQm1rVkJuUnMyZkorQ0NpUEp6MVdhUXRZdWxVUzlPaFpP?=
 =?utf-8?B?OG1KWlc3ZFlzVWxBK094N3diQkk0RXNjc2dsSVBkdU9zOFBzVHpMZGtTbW5v?=
 =?utf-8?B?STUwaXI3UE5uaDhpb0w3UitwUm5TWEJTK1E3dDJBM3E0TWdYTzhERC9OeHNT?=
 =?utf-8?B?dWpJMHphUjk2MmJLUml6VmpNcTgxUzZYZDZ3NWtyZ09RQWtsWDNtVjEyVnRB?=
 =?utf-8?B?eDE2V3ZaRi9uK3ZabGp4dXQxT05tdndIZzMzR2xSRXRDUkFOdDMxMGxCWkFT?=
 =?utf-8?B?QmsyeCtJMjA5THk1S1pJY3g3eUp4WUY5NEpJK0FIZ2tDUzdpd0FualhHbkR3?=
 =?utf-8?B?RnBlWTZDd2VTSThRSnhNOUlJMFNiY0w1bnZhQWo3Ri9IRG1LZkJzbEE5Ky9E?=
 =?utf-8?B?b2poRHpKV2pqNVpaNHVKN1NrbktXeVJya09CdWFJMlZjQjRJeTd4VHZIM1Jj?=
 =?utf-8?B?WGdTMTJ4WjdFUDMxWkZkMFJlcG5JY2JkRVZ5L3REbEdoTnd6MGUySEZ4c0dJ?=
 =?utf-8?B?WDhLdzVnbGZ0ODB0NzExb3IxTEY3dFNsU2lkYTZCaEJOZnNGeEh2akJQMGM1?=
 =?utf-8?B?OWZvRkdKRU1PZU1POHZSbnRZam9weWZ2Ly95Wm82ZjhKNTFnUUFrRXFNQUhk?=
 =?utf-8?B?Y0g0dXowRHhWcUgvZSsydllsYlBQYmxlWm9ONUhCcFl4Um9ZeWhuQVJlTVNk?=
 =?utf-8?B?bExoNS91eFlGT1pET1ZwRExHK2QvNFV6WE5rcDdOQXNDTW41a3Q2cjc2U21L?=
 =?utf-8?B?VVpVVVNkOEM3NlFLQWhsc1U3azUvOEFNTzRCUm9nb3AyeHZZaVg5QmMwa0M2?=
 =?utf-8?B?akZ6OFYxYVBJNCtNV2RzT3EwZlU0L0ZEeCtKMGwydlV5Mm5xaGhVbWpIRHVS?=
 =?utf-8?B?NmpGZENnVUU2aVBaeVltcFFTQ0NkbVNBYmxaTkVFWTltcXZCd3ArTzBSeGJi?=
 =?utf-8?B?alIyUE02dHI1aWNrbWFRakZZQy9nc1VVamFwL0xvSCt4OUdBSytRQVNSL2hU?=
 =?utf-8?B?c3JzMHdkYmN5RnVvcXlVNHFUZVpIN3AyZmdseHJuQThZRnJzQVg0TW5keENP?=
 =?utf-8?B?a1NzUGkrMmpHSFJpOWRLdW15S25TUXdQU0piQmxFY3lIbHFyd0RzcjJCSW1Y?=
 =?utf-8?B?ZGZPS1ZjTmliWjh4NnVvQU9WdTB1Y2owT2h3V003Y1FVelFEbkdhLzVHNHpP?=
 =?utf-8?B?Yk5nbXROSExoY240czhITTN1Y2diMHNkMG5hSkRZR0thN0srakx3anl2elFU?=
 =?utf-8?B?WUFnd1BIT0hGREtNcGcySUNhWVNndXdCT0dmdXA1U09EV0o0NlBsWGxHSjdJ?=
 =?utf-8?B?VjBHck9Cd0dsM1VNUG9GUVFlc3NQMEd4b1lWN0x5Z0wybHV3U2xDOUhMZXdD?=
 =?utf-8?B?LzlNcmlIVEk3N0tYQTdTVHJ4UERwRlJPTGJoOTkvWW1OT09GeGE0T014RWNN?=
 =?utf-8?B?cTh0WVhFQ2kremNxVUxsTWRwWFBxUHVoUnNQKzN6MFhSRTRjYnp4VmxTcWZh?=
 =?utf-8?B?K2VmL0xrVUoxTGExTXJ6SHFncnFYNDQ5WTRqeDlrNEJFeFhKWDk0YkpZSjZo?=
 =?utf-8?B?aWYvNVJOYXhpVXlNNFNVMG8rWmpZajc1L25IaTBhVXo0eVNVckg5TnNwamds?=
 =?utf-8?B?OEJORDVxVXRNNTNqK1g5TWI5clYvLzlNbmRibEJhMVErN09XVlNuY0N0SE1B?=
 =?utf-8?B?SEJGb0ZlNG5WOWpEVW5jRnRPSXNOcWFzN2ltRU5OQ1AwdFZ0emRxdUdpQWhG?=
 =?utf-8?B?QU1TVi9GNHdQUVF6dkl4RmVuVUticUhMY3I5M250TzJlWmM5MUMrN3lwVWdx?=
 =?utf-8?B?SWwrQTlsZzV0ZzRiZytIOWtSbDBiZE16LzFFOHpVYTZVbVpkZGZkY0pzMjhL?=
 =?utf-8?B?RGo0Rm1IWjVueldJYjY0SFRwVElEeEdkeG9NVkJERTNRbk1nRk5GM2xJTm5y?=
 =?utf-8?B?STFxbWh1cGg1NUszbHY1bHZYS0dnOTg4RElUYURLVzE2Z2dTa0pWQ25zUitC?=
 =?utf-8?B?b2tXTlJrZG9KQ041RTBVWW53VnJnLzJ1TzBsK055c0NlK3RxbGFIbTk3cFM2?=
 =?utf-8?B?RU84dUlFVWluRVVVNzlPWFY3dVZ0WjdpZjVCM2Y4SFV5TlUrOVFhOWVTRjdO?=
 =?utf-8?Q?RHqr7kwmOcNOy0BkuQWFLf5WF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f993bc-423b-4330-a293-08de0d347e76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:20:24.9377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urpybweeWfVWYci3BkvbXSXoq4TLt7Mt5WgZTgztLkPdOjDpbpyIm9GfjtCb/bLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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



On 10/16/2025 11:32 PM, Ellen Pan wrote:
>      1. Introduced amdgpu_virt_init_critical_region during VF init.
>       - VFs use init_data_header_offset and init_data_header_size_kb
>              transmitted via PF2VF mailbox to fetch the offset of
>              critical regions' offsets/sizes in VRAM and save to
>              adev->virt.crit_region_offsets and adev->virt.crit_region_sizes_kb.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 174 ++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  11 ++
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  31 ++++
>   4 files changed, 220 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a99185ed0642..3ffb9bb1ec0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2782,6 +2782,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   		if (r)
>   			return r;
> +
> +		r = amdgpu_virt_init_critical_region(adev);
> +		if (r)
> +			return r;
>   	}
>   
>   	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 56573fb27f63..1779b1ac30d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -44,6 +44,18 @@
>   		vf2pf_info->ucode_info[ucode].version = ver; \
>   	} while (0)
>   
> +#define mmRCC_CONFIG_MEMSIZE    0xde3
> +
> +const char *amdgpu_virt_dynamic_crit_table_name[] = {
> +	"IP DISCOVERY",
> +	"VBIOS IMG",
> +	"RAS TELEMETRY",
> +	"DATA EXCHANGE",
> +	"BAD PAGE INFO",
> +	"INIT HEADER",
> +	"LAST",
> +};
> +
>   bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
>   {
>   	/* By now all MMIO pages except mailbox are blocked */
> @@ -843,6 +855,168 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
>   	adev->virt.ras.cper_rptr = 0;
>   }
>   
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
> +{
> +	uint32_t sum = 0;
> +
> +	if (buf_start >= buf_end)
> +		return 0;
> +
> +	for (; buf_start < buf_end; buf_start++)
> +		sum += buf_start[0];
> +
> +	return 0xffffffff - sum;
> +}
> +
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
> +	uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
> +	uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
> +	uint64_t vram_size;
> +	int r = 0;
> +	uint8_t checksum = 0;
> +
> +	/* Skip below init if critical region version != v2 */
> +	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
> +		return 0;
> +
> +	if (init_hdr_offset < 0) {
> +		dev_err(adev->dev, "Invalid init header offset\n");
> +		return -EINVAL;
> +	}
> +
> +	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
> +	if (!vram_size || vram_size == U32_MAX)
> +		return -EINVAL;
> +	vram_size <<= 20;
> +
> +	if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate for init_data_hdr */
> +	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
> +	if (!init_data_hdr)
> +		return -ENOMEM;
> +
> +	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
> +					sizeof(struct amd_sriov_msg_init_data_header), false);
> +
> +	/* Table validation */
> +	if (strncmp(init_data_hdr->signature,
> +				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
> +				AMDGPU_SRIOV_CRIT_DATA_SIG_LEN) != 0) {
> +		dev_err(adev->dev, "Invalid init data signature: %.4s\n",
> +			init_data_hdr->signature);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	checksum = amdgpu_virt_crit_region_calc_checksum(
> +			(uint8_t *)&init_data_hdr->initdata_offset,
> +			(uint8_t *)init_data_hdr +
> +			sizeof(struct amd_sriov_msg_init_data_header));
> +	if (checksum != init_data_hdr->checksum) {
> +		dev_err(adev->dev, "Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
> +				checksum, init_data_hdr->checksum);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
> +	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
> +
> +	adev->virt.crit_regn.offset = init_data_hdr->initdata_offset;
> +	adev->virt.crit_regn.size_kb = init_data_hdr->initdata_size_in_kb;
> +
> +	/* Validation and initialization for each table entry */
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
> +		if (!init_data_hdr->ip_discovery_size_in_kb ||
> +				init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
> +			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
> +				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
> +				init_data_hdr->ip_discovery_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset =
> +			init_data_hdr->ip_discovery_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb =
> +			init_data_hdr->ip_discovery_size_in_kb;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID)) {
> +		if (!init_data_hdr->vbios_img_size_in_kb) {
> +			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
> +				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID],
> +				init_data_hdr->vbios_img_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
> +			init_data_hdr->vbios_img_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
> +			init_data_hdr->vbios_img_size_in_kb;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID)) {
> +		if (!init_data_hdr->ras_tele_info_size_in_kb) {
> +			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
> +				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID],
> +				init_data_hdr->ras_tele_info_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
> +			init_data_hdr->ras_tele_info_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
> +			init_data_hdr->ras_tele_info_size_in_kb;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID)) {
> +		if (!init_data_hdr->dataexchange_size_in_kb) {
> +			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
> +				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID],
> +				init_data_hdr->dataexchange_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
> +			init_data_hdr->dataexchange_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
> +			init_data_hdr->dataexchange_size_in_kb;
> +	}
> +
> +	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID)) {
> +		if (!init_data_hdr->bad_page_size_in_kb) {
> +			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
> +				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID],
> +				init_data_hdr->bad_page_size_in_kb);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
> +			init_data_hdr->bad_page_info_offset;
> +		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
> +			init_data_hdr->bad_page_size_in_kb;
> +	}
> +
> +	adev->virt.is_dynamic_crit_regn_enabled = true;
> +
> +out:
> +	kfree(init_data_hdr);
> +	init_data_hdr = NULL;
> +
> +	return r;
> +}
> +
>   void amdgpu_virt_init(struct amdgpu_device *adev)
>   {
>   	bool is_sriov = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 36247a160aa6..8d03a8620de9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -54,6 +54,12 @@
>   
>   #define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 2
>   
> +/* Signature used to validate the SR-IOV dynamic critical region init data header ("INDA") */
> +#define AMDGPU_SRIOV_CRIT_DATA_SIGNATURE "INDA"
> +#define AMDGPU_SRIOV_CRIT_DATA_SIG_LEN   4
> +
> +#define IS_SRIOV_CRIT_REGN_ENTRY_VALID(hdr, id) ((hdr)->valid_tables & (1 << (id)))
> +
>   enum amdgpu_sriov_vf_mode {
>   	SRIOV_VF_MODE_BARE_METAL = 0,
>   	SRIOV_VF_MODE_ONE_VF,
> @@ -296,6 +302,9 @@ struct amdgpu_virt {
>   
>   	/* dynamic(v2) critical regions */
>   	struct amdgpu_virt_region init_data_header;
> +	struct amdgpu_virt_region crit_regn;
> +	struct amdgpu_virt_region crit_regn_tbl[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	bool is_dynamic_crit_regn_enabled;
>   
>   	/* vf2pf message */
>   	struct delayed_work vf2pf_work;
> @@ -432,6 +441,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
>   void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_virt_init(struct amdgpu_device *adev);
>   
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +
>   bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>   int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>   void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 9228fd2c6dfd..1cee083fb6bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -71,6 +71,37 @@ enum amd_sriov_crit_region_version {
>   	GPU_CRIT_REGION_V2 = 2,
>   };
>   
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
> +	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +	AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +	char     signature[4];  /* "INDA"  */
> +	uint32_t version;
> +	uint32_t checksum;
> +	uint32_t initdata_offset; /* 0 */
> +	uint32_t initdata_size_in_kb; /* 5MB */
> +	uint32_t valid_tables;
> +	uint32_t vbios_img_offset;
> +	uint32_t vbios_img_size_in_kb;
> +	uint32_t dataexchange_offset;
> +	uint32_t dataexchange_size_in_kb;
> +	uint32_t ras_tele_info_offset;
> +	uint32_t ras_tele_info_size_in_kb;
> +	uint32_t ip_discovery_offset;
> +	uint32_t ip_discovery_size_in_kb;
> +	uint32_t bad_page_info_offset;
> +	uint32_t bad_page_size_in_kb;
> +	uint32_t reserved[8];
> +};
> +
>   /*
>    * PF2VF history log:
>    * v1 defined in amdgim

