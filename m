Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04626D5CC8D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE3510E6FF;
	Tue, 16 Dec 2025 09:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i0sPFgs1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5685810E6FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9EVN+9e5PkV4lx0FSWmDyh4TYj9zXW+9KQj9dtmxwXX7Uw940GkN7hTQGz0C+sz+R/VDSXEPsdTyhLSg42UpmcmbfwjisaSZzgEtYU0yo6DDnlfKH4DmBto2AzlpHemXj7J2BohQS5GACf83Vift6APBER2OAqTWOqqTKIHAzm/BVnk2U8IEcEq6jhwfBN2ewbwewKx5Hldfqczi9tJXGRpWOIyIFfB/2HLRPYxj7awdpcLqIcsg3Pqbs+qCp5RKtiS20mghEIdoDmYfSRbMYDpq0AdJOPwAnk31iMd37rYOtJ3YuB20YvPbvgFecvI9eBT93Y+VSprFXyXqAhUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVzSoKpNCB6xiaSc8V7LtRAXsnvluQs8exjPiv/eKGw=;
 b=euf72i/fxuWDfttXjlaM8/a25tPSs7yzPtuG/rfBG2ZUn/Ywi1eOOpKBkP/0ZEJjj+XXvQ5HeR9ktjxfXeDzObGpPMRCsZwhhWXROh8Jwc+OidbZQnEIWobh6qKh9Bbkq2DchH1O/yLWHpB2ue1VYiZnqIxlY8qVhNQcSGtDpYEvANJn52Rs+uolpZ8NwWChS3QUdDEds8qxWndWQNCGBeDZvmT2Yd6yVoDksCbqFT5j3AiQDVdzBZ9LueacIBpfXmoiM9J9Nc4kgmjOnRm6d/3ypcE2x1F52WDlAASIaV85Ig/NdbWzkEOUYvaW08lGDna5RQEF818pyNCU8PQbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVzSoKpNCB6xiaSc8V7LtRAXsnvluQs8exjPiv/eKGw=;
 b=i0sPFgs1hXdIs4DR8DexPxiPOVdV9qmPYU1l1tKLODINjn2LZxUlVatJNkBmtHTqmLPbXu7Kv8EunZuCWTn7swfhFR+FR8DGNHjcx89HHyNhhYb/aTNGTgTHDPeH3kYGbtnrc9Xfzy/vknq2frzMsJi9NSGdepqr8WkU8kNJmnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:10:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:10:29 +0000
Message-ID: <902ba436-9549-40f7-a202-810b1b1ae818@amd.com>
Date: Tue, 16 Dec 2025 10:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251215165630.1172383-7-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 9487bf83-5be4-48c2-32f4-08de3c82f51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXpSb3JvZlQ1TGlIeDVBV2pZZXR3RWs5MTRTTjhYRzZjdmZLREwxSVllNHly?=
 =?utf-8?B?VmhnWExuTzcyeGNHVGxodGF1RGFNblJUVTQrenBIWFdmOFJPMkJTRG1ScERt?=
 =?utf-8?B?Qy9Ta012Y0FJTWRYR1JBaEM5d0Q1U1NhVWtmZXRsWFNhQ0JvL0ZOYUFkaWNJ?=
 =?utf-8?B?YnBZKzhkcUpZL053Z0hyVUU0V0kwcjlvUUdJVTVPL0xjUzJzbVhPYkFTd3RW?=
 =?utf-8?B?czR5SlJTTmxQK0h2dHJVanhScTlZd3ZoVnVtZTV0N0pjK2RCckRuUFZPSzlj?=
 =?utf-8?B?b2IzOFRUTHZOYXJ1VTM3K0lWOHhhSTMzZ0VPNHZ6NUFzaGtCMjF4T0RyR1hR?=
 =?utf-8?B?dkFVNnYva2x5QXNXTGU1TUY1aVZMVVdqOTUzQVR1Sk9PNEp6VUo3QitQaUE2?=
 =?utf-8?B?WmptOUlpSUtKMDRRSVVxTCtERzZ2T1MzMk1yaGdTQWxUOS8yRlVCTTQvSmxE?=
 =?utf-8?B?anVRUG91ekZ2ZlZMVURwczljU0NmSHJYNHBubG5OQ0NPSDZKdis3YkFnQ1Vm?=
 =?utf-8?B?Q1BMcDVEWC8vUVN5OFkxY20yV3ozc0ZMRmtHek1xby9kT05pWHVINE55K1cv?=
 =?utf-8?B?cC9xcUk4YWVzeFpIeWNyVUFzS282a3R0Rm5oVktpZlUzY2IzZDliWmRDM2FE?=
 =?utf-8?B?NG5oWE9pcTVFQmk2aHF5VWV6WHUvV3o1R0R3dXhKWDdNenhlOUxkMjBzMEZB?=
 =?utf-8?B?RXduVm1JL1ovTVUyTEVpR2c4NTJRenZYTVJFcEk0cmtZQ3o0U0ZHNHhreFZJ?=
 =?utf-8?B?K0VjOXFPeFlMQWtKelptTHpIU1BrcDAwTUZ2dS9sZUhZbitqZlZGVkRsRS9R?=
 =?utf-8?B?QWF1RjB6RnZpSm1oNDh2aGlkLy91T3ZmemdnNlpZQ1lsNnd6VzVpM0piUkVr?=
 =?utf-8?B?VHZUQk45TXBYU3FORG5jMG9lSm1zR0dlNGJoNm1kc25EMnd2T1JLK1ZVbVhY?=
 =?utf-8?B?WXNwMGVmdFFHSmFocDViT0pPVlNONmsrYlFxR0pZU2tpb1FWWVQwSFpHVWlu?=
 =?utf-8?B?aHpzMnEzckNzNnVWb0FJRS9EQVZGRHZ6MzVJVTZyRm5Ld0Zmbyt6V1lqMHRy?=
 =?utf-8?B?RHdReGJFSWNXZ1FzVFd1aEdaNzI5UVR0RkpCTnp2TXo3ZnoyK2N1ZTBad2Vz?=
 =?utf-8?B?dHZCVTZXOEZ3UER5cUJBdzNCZU5lMTM1MGpGQTVwMHNtMUFKaTVMSFdaOWk5?=
 =?utf-8?B?dExPMlAzbEF1aCtPeG9ROUlyeHpleU95ZkMvZU1mYmhsNERTa2RFTDR6UXFw?=
 =?utf-8?B?SEV4U1g4ZzNhdElMMzFUQVlJZGoyTEFFUDBHRDNyVDE3RzdKdS9jZ1hjUEJC?=
 =?utf-8?B?bDRWK3M0VkJoTkMxSzRkSHBiUTB0TEMzN1hMZENmZW16WE9IWXF3TU95aHp3?=
 =?utf-8?B?M0piVGprRkt4eldYeUVtbnhzQ1FmMTRlTTdQb2J5OUs5ZFNFdEUwMW8rd054?=
 =?utf-8?B?aUJKa1lBTzdhSjI4WWxvVlk0c21RY1hoeXRzdHQyNURRMzJ6Mlh3MmszZzJ4?=
 =?utf-8?B?TVdybklkSlQwRDc5VSsrbHl3UXhrWGYrQ0dPNUFFNGFvL2J2Y0ZMOXlwSVI2?=
 =?utf-8?B?eUhsMHdzNFVobjFmdkNUYVNEWWJEdHZJbWl4WWx3MGN0aGVaQ2hnYVRPSmpW?=
 =?utf-8?B?cjhMOFVpVFp5SzVpOGsvdXpQTHoxWHF5c3IrYVlzVDJOUDlSWTVKNUtWcWFJ?=
 =?utf-8?B?WjhraHVDWms4VjBjTWdyanZqVW9IcFBrdmdCejNia25DaXdIcjJ1RTBpWEkv?=
 =?utf-8?B?V2hjUGpaaDEwMVcxL0RHYjU3ZWFHVG1HSndRUFRvbVB5QzBGVnJYTGEwVzJm?=
 =?utf-8?B?YzNrQW5IdFQrWkRSeU82Y204M09GZjJOb2oyQTNGdzBRZDBEZ2JLOWZhWkNY?=
 =?utf-8?B?UDNwNENjekJqU0tmUXZpaEx2bW5sc3JPK2VxSEJUbktSNGgwMEJZN3R5ZUlE?=
 =?utf-8?Q?PHPh1FhEEZdzFEPUxDdjqNVr5BMeq9nk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGFPOG1uN2JDK3N0Z0NXVEZWUE0yMzY4ZU9mZUU1K24wSEJsWG9sbGpBRjJm?=
 =?utf-8?B?RHh0cUlmaWhVVmlFN2xmdGFMQUZPWlo0bFduQ0lHa3BGaFg2RFBUWGZiamVW?=
 =?utf-8?B?elNpM0wzQlVFQmRCMlMvUTloMktxN3ByVFcvcnFBZjlRc0dFQ1Y3MHMwaVVE?=
 =?utf-8?B?MW4rZDZRN2NmU0F1L2hYVm81TTZ2SkJLODkrYjh5cytrd2ZJcWx6K1FTMUdK?=
 =?utf-8?B?UHp4Y2tjWE5jS0ZGU25SNXZNaWtpOVhSQW9kcklIYzhvUFJPUnpuc0x4Szhu?=
 =?utf-8?B?aU4ySDVTY1plUURoSmJHUVpxZHQvQzBnV0xnVk16aXFITmdnWXRiZmJyTWZl?=
 =?utf-8?B?TlIrdVFWdnB1T29OZkZYMWJJREFpaHlTTE9ka05IS3BvdFNFejZRRkgzMlNp?=
 =?utf-8?B?MUR5WEJHWmpmQnZqaHU5UkxiYTNINnBWVVRodlR5b0NwQ0hSNUFpY0pnOXFi?=
 =?utf-8?B?Q2Y3VGUxWGpmVnE3Sm15bit3MTBxakk1MGlvYURzL2c4WHpRMHpIb1JOMVh4?=
 =?utf-8?B?NmloUHlOY09xeGZRMU1HUHptYXJDY3YzcDUrcithdGJnb0ZIV3FwZmxuTFZP?=
 =?utf-8?B?blpnTEpnWk1nNWM4QnhFNzJFNzJNc2FuVisvUDVXZy84ek1mYm54SjNUTStI?=
 =?utf-8?B?VUxINjI0WnJJdnJaajFKbG93Z3FQSnEyMFZnQUNvNXpqQ3BsaXNpaVRWMEg5?=
 =?utf-8?B?RGNXTDlmbGdHK2dXeUhab2hzL3BybmhRMGpKbmY2K1VqNTh4NHYvVlllbnBE?=
 =?utf-8?B?cGhVTFVad3Q0azhtT0M1WlpycTZIU0haWWZpSFBIRjFjVWtTU3IrdVVPdzI3?=
 =?utf-8?B?YXpDVWhSUWFyTnoxREp0Z1pBcE9oTTA5NkRYazVPQUlGaURLRHNlWFEvVmhP?=
 =?utf-8?B?eHdwTEZwTHJMZElSNWg2WTd5eUJYTTdWa2dRK2ZvSDJ4RGY2aEFMTW1lWm5w?=
 =?utf-8?B?VkIvSDY0b25VN1NOLzZpS0VtOFVhT0kzVVNjaFkzZ2YvbFlmR2pabld5TDRW?=
 =?utf-8?B?SGpZeTE0RGZFaFZVMk9NN1ltY3pkMkF3YWtqSUx1M1Iya2paTE1hRGVneUtk?=
 =?utf-8?B?WWNubmhWakx5L2FuU1lKRGErN09nQm5EcndRdXFPeWtZMWEvVytJWDUrMW41?=
 =?utf-8?B?TnRrTnV0VWFzRHBQanFVYWJmVGhta05WVE5maHFrczRhL2kvQld3Y1J1NEZl?=
 =?utf-8?B?WW9ZR0dVMkVUNUhvUGVZVEVveUNFUTltZXlBSytlNzJmWGFrWURENkowQlhy?=
 =?utf-8?B?VWFYZkg3ZXErNXlRN21FMTVDRWdLMEFCQlF4eWtlT1Z1SGFBTUIyOEMzNTlH?=
 =?utf-8?B?bWFkazU3TXBIRHBoZDdsMnV5SEFMTXBNTEthQjJPNXpCYTZFNzFnYVI2M2k2?=
 =?utf-8?B?SWJhdXFoMzQ2Rk0wM0EybEc0K1NkamdaWHNxZVpkejhKOVZqR00zQmVqc3NG?=
 =?utf-8?B?cHFuRVN3S3VZa3Fac0dPK1dra1VtSU1YOWZkeUthci9Gb2orL3JlV1Q4eUE3?=
 =?utf-8?B?ZDNpSmsyU0t4Z1B5Yzkrc2ZudzRKdFVKRVRWb2NDckV5M2JxMm1CR0xJR3RM?=
 =?utf-8?B?WjRTYk0rU2lRQUdGNytTYmpuaThKM3JkeFhGemkzQVZ2QlVsRkZjMjhJeWU2?=
 =?utf-8?B?YjBnY0I0bmNJMFFLK0NyakhBL1hTQit3d1NKOGJGNklhMXV2WU1nQnQreVVq?=
 =?utf-8?B?WXhJakRYMmI2cDRMYXo0MG1YVVRjMEl6ZWVCN3VvT2NKY3JXYVVjazhBb3Ji?=
 =?utf-8?B?Y1hlckRTQkhHSlEwSHNUVUYvaE0rRG0wbHNYa0diK3ZTZjBkWjc2SGtsV2M3?=
 =?utf-8?B?WUVPamJzcWRYcU1mMXVaMy9EN1BXd05nTmY5WVk1eDRScHFlZFhBdjUrelpW?=
 =?utf-8?B?dFlqNEt3VDJSdkVJYXRWUkJFYlp3TWZXU0pSaWlja0ZQWGpxbzFVbm9helVq?=
 =?utf-8?B?N05wRXIyT2UxRGJNTVZLYmRqb081blo3ZWsrRnJWNmJnL2F4UVdpcmxvNWIr?=
 =?utf-8?B?QjRWSG4rdE4vOGtVRzhweWpUY29lTmtWcTVVaEJhY0U3MG9QcXJEUXZHUWkz?=
 =?utf-8?B?RUtYeDFjVFNtWkt6TkpndDUweGN4bHloR0NnNGtoTzVrS0dLY0pacXRuRFFp?=
 =?utf-8?Q?wkuXbQguuIIveCyiuZSjF+ihv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9487bf83-5be4-48c2-32f4-08de3c82f51b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:10:28.9989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+Fv3epIazvnhEw28QDc/t26hxNIEcuUniMQo4a8JxYNGgG6sT3/tjs3hbMDW8/P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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

On 12/15/25 17:56, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency
> 
> Add GART mm_node to kfd mem obj to free the GART entries after
> MQD mem obj is freed.
> 
> Use resource cursor to handle VRAM resource which maybe on multiple
> blocks and use cursor_gart to handle GART entries.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  5 files changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,67 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>  	}
>  }
>  
> +/*
> + * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
> + * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
> + */
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	struct amdgpu_res_cursor cursor_gart;
> +	struct amdgpu_res_cursor cursor;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->base.size >> PAGE_SHIFT;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
> +	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 start_page;
> +		u64 npages, n;
> +		u64 pa;
> +
> +		start_page = cursor_gart.start;
> +		pa = cursor.start + adev->vm_manager.vram_base_offset;
> +		n = 1;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +					   flags, NULL);
> +
> +		npages = pages_per_xcc - 1;
> +		while (npages) {
> +			amdgpu_res_next(&cursor_gart, n);
> +			amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +
> +			start_page = cursor_gart.start;
> +			pa = cursor.start + adev->vm_manager.vram_base_offset;
> +			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
> +
> +			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
> +						   ctrl_flags, NULL);
> +
> +			npages -= n;
> +		}
> +
> +		amdgpu_res_next(&cursor_gart, n);
> +		amdgpu_res_next(&cursor, n * PAGE_SIZE);
> +	}
> +}
> +
>  static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>  				 struct ttm_buffer_object *tbo,
>  				 uint64_t flags)
> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>  	return 0;
>  }
>  
> +/*
> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
> + *
> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
> + */
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,

That need a better name, something noting that it is mqd specific.

Potentially just merge the code into amdgpu_ttm_gart_bind_gfx9_mqd_vram() and keep that name.

> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
> +	    AMDGPU_GEM_DOMAIN_VRAM)
> +		return 0;

Please drop that check.

> +
> +	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo), 0);
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;

And a helper for this would be better. Maybe we should move all the gtt_mgr functions into a separate header like we did for the vram_mgr as well.

But that can come later on.

Regards,
Christian.


> +	return 0;
> +}
> +
>  /*
>   * amdgpu_ttm_recover_gart - Rebind GTT pages
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 25640bed7dc9..9f07856433fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> -
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 struct drm_mm_node *node,
>  				 u64 num_pages,
> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..edb72f4ef82d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>  	      struct kfd_mem_obj *mqd_mem_obj)
>  {
>  	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
> +					    &mqd_mem_obj->mm_node);
>  		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>  		kfree(mqd_mem_obj);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>  			kfree(mqd_mem_obj);
>  			return NULL;
>  		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>  	} else {
>  		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>  				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 06cd675c9e74..55738b30c2ec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>  	uint64_t gpu_addr;
>  	uint32_t *cpu_ptr;
>  	void *mem;
> +	struct drm_mm_node mm_node;
>  };
>  
>  struct kfd_vmid_info {

