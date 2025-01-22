Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383D5C02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 03:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6C210E106;
	Wed, 22 Jan 2025 03:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tX5a/YgX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C692E10E106
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 03:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxc+3B/tYp6Jiuq2lVwPLCQxDUhWb2T0iMr2BhT6o5Nah9Vnd0vPjsHmfFgonCPuE32AZj9q0lMfm1sT8cEcjv7dMwMevaRJ546OqX2SgWhFesndqMuLWZwA0MJ81ADkLRpbBOfvwSqiLwaYxdCB4GIknXK7lx0ojHLcrSlKz5R4zNzXLsK/hO+iPv95BZoFxTKxNcnXTah+rX/sgLbfCGDEuLeUx0GEFjDrOyeQk4ePsGARhKWNz1o4KJcI2Ct+cDt12suQAcdWuL+SSPasea9nFkcEwA1LNU00xMKmrOHocqBPhMRbpGC3GZZ4o6ncuf8kskzdXjVgK0jpWTsiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhWQj0snMdi6b2MlqBW/YFQfHCgkWeAi2/uGcDw2XBc=;
 b=k+krCA6wtF3imS06IWu+k1rgg/6DxenZsMsCDEsEHcvy0ofU8my02dKYlXyzJWQGhfWD7y96NoeyuY7kTInMQZ3EWDhJ+9oKm3IwsU95qK3DpytT11jlOnC+pcAXvvYwSXDfRgnxURUu8m5qWQq/yPZy+HcUlbMc4hX/czaG7Z8V/D4qVtdvCKG3F6Gy26g56uy6l/wGPOzHRYFIlwHH/iyPlwdj9fRaggSNzEABCTblUD0oaLtIuK6VXOF2l2JY8+1CdQI1c+ldsF3wkgFL8ebRrjJXaXQEep4arYY+IuGmcXJEVvyhkFCBvwxlc1YOH7CzJjXeW96BnGfgIOmCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhWQj0snMdi6b2MlqBW/YFQfHCgkWeAi2/uGcDw2XBc=;
 b=tX5a/YgXirjIKZ1/0wRbKZFCEQoRuS2QN8IKl1VnT+PfTksAN02fm2b4+W+/UoC+r7wkmKkR5/Z/i4cDRrJtKS3ac8DrqlifIEOJ982EZA3ifWOK87xyIjEjM7kHjQHAM5J1PoY+Be8CjTpVTX6Uuxlayq9tNMmJbfplI8784Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 03:24:24 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 03:24:24 +0000
Message-ID: <5db46baa-c894-4205-9e4b-6ed29d7ccf31@amd.com>
Date: Wed, 22 Jan 2025 08:54:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] amdgpu/soc15: enable asic reset for dGPU in case of
 suspend abort
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, Prike.Liang@amd.com,
 asad.kamal@amd.com, sonjiang@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736739303.git.gerry@linux.alibaba.com>
 <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
 <ef9902c4-0d7e-4a1a-b785-b3ca8e8d0a03@amd.com>
 <9e689d0e-d8ca-49c9-8e62-dd113fe774e0@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9e689d0e-d8ca-49c9-8e62-dd113fe774e0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd7e844-7073-4318-6d0e-08dd3a944492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlpzQ3JvZUg4WDlUUVZ3d1NLVXg2Z0hvSGpoVXZYVGFZMmxtUXZLcHduUzFv?=
 =?utf-8?B?OVZvUzhFV2NDQU5CV2kxNVZjNHYwZWdmaGNvY3k1WVoyZEcvUEZZdmFpSm1z?=
 =?utf-8?B?U1duZHJNQ1VZUzU2c0RJSjZ4dktNMjBqVnJnSzhBeXR4cHZnZWNVVXJnaUYr?=
 =?utf-8?B?dWVVelRLTElQbU1tVE5qeVJuN0h3cmRXR3dZSU9WVmZBQWY3SWczK1BDa0tV?=
 =?utf-8?B?dEVNeVRIREY5THlwL2V5ZUw1OHRlRk1taWFzZG5lT2JpVnNEVU5KMW1aL3N0?=
 =?utf-8?B?dWtjekpkUWsreUFyaG56ZHYyanVOV3dBQ200Y2xWazg0WkVnYXpTanFoSDhy?=
 =?utf-8?B?SnFzUVVkZXFoc3JML1h1RmlNdjVCdW8zTEM5Q1BZZXl0cDNJK005SG5WUTRZ?=
 =?utf-8?B?ek9oTm56SmpUR0FONVdnbTlxaklFZGJJaWJCb1VOUm5JV05VODdQUFVnZ2NS?=
 =?utf-8?B?dTdiaWgrc2hTY3ZoR3laS3Jqd0V1WmxhbGJwWktZQUtlNjBoWUpYTXNndnU0?=
 =?utf-8?B?MnplT2dWZ3V6VGRSdnlmdE5sTFA0YVphVldod2xHMW5rMDcyck1KQlk2Zmwv?=
 =?utf-8?B?ZnEwTzl2aUFNbkdzRGhoT2RucHAyTm01YVdpWlJuOENSaHR4U3drQkhZUmw3?=
 =?utf-8?B?YzMzVWkzOVA3L2pyRWszanVCSXhIc3V0bmVYZGZJYUZzK3FLbVgvUWhpRU5z?=
 =?utf-8?B?YTUvbHpEKzhzVGhOT3hvOUplM1gwaGxyVytzalY5MER0bVJtZWx2L3Q4cW1T?=
 =?utf-8?B?a3M0cElsM2xmNmowNkFzWUptYnh2bEQwdjd6QmQ3RE9zVWg5Mzg5L2VTSHF3?=
 =?utf-8?B?SXFGQXp6bm5weUovSnZpVDh4R09IWC9ZME15aCtSeGd0Z0hRY1lZNmtmN0VS?=
 =?utf-8?B?NXpYdkllbDl0Q1ZuM2g0R3daWWo3QW1hYjFTOEtoSG1ONkRHVUdUMmNFR1hX?=
 =?utf-8?B?c0pXQ04zbXFsa2hWclFraGJJWEtqOVp1YUZJMmtrazc0YUJxRjA3cFpnMXN3?=
 =?utf-8?B?WEIvbmhzM3IrdFl6T2x0UEY4WmNKZU1NeWZZNjhIem1xTUlTa0NmeWNHb2Np?=
 =?utf-8?B?dWdPYnp1QzR4NEorR0Vabk1ySnp1Q0hLeUpyU0JPcjV5WTQ2QkNwckRzb2lU?=
 =?utf-8?B?NGx4dGtqK0dIOHJPMHYxWVhSWWpmUWxkUzJjeFpCS2svY0JJaXdnaWpwSXJE?=
 =?utf-8?B?QzRDRkd0cUpJMG5WUzdMakRXY2NRanJRRVI1SHZKK3daWTQ4VTJzVmtsRnVY?=
 =?utf-8?B?UTlwMEVpRStMWjZYWTQ0LzhPTGlxTzhSRVF3K2J0NzU0ck42bDlSM1RaMlpC?=
 =?utf-8?B?Yzd1UHZSREMzc2pKNmtQb3B2aUphUjFjVzlxOTQxeVdncEVmTkkzZXNaR21Y?=
 =?utf-8?B?QlFtaUM2T3N5YmJndTZsbzdacE9SMWJxN1BQc1RPbDJnbGRYLzNlcjhsYkFZ?=
 =?utf-8?B?eVo0YUcxWmhObWNaaTZTd2lrKzVQcEtmQVFIc2loaUw1cXJ4SWVYci9Tb0lQ?=
 =?utf-8?B?QytSRzlVclAxNVpVUi9qeEw0cHFxanE1SXBTWjdIeEVtMVYvNlh2RGxRU1VS?=
 =?utf-8?B?ZHR3OWNpWVdhZ0tGNVlkQjV6eTRMVWFta1F1Rk42RFo2dm5QdTBKWms2M2NZ?=
 =?utf-8?B?cGdZUVAvOVBRYWxRQTl6elpYQldEd2pQbXFmOU94b3JYd3pUa3VTSjZ5UkNt?=
 =?utf-8?B?ejg5S1Z4ZXhqSFJpTi9XejdpMVhBclMrRHpjSXkvd2ZXb2ZVOGVkdGdJUmV3?=
 =?utf-8?B?VEs4cDkrV0JvdHdvaWc5ZllmdDJJRzdNaTZSS2lBMWFKNTVjbE54TUlGZWVJ?=
 =?utf-8?B?bGQ4UE5GQW1ORWxMeEZmdTBobGZpRlpCYkVwS1kzRlZOM21BQlFkcDFnVi9C?=
 =?utf-8?B?ZzV0NUM5OHA4ZGFKYkhZVlFpbndHSlVycndkc0U5eEZwcjRyREhYWVFSYytK?=
 =?utf-8?Q?BqQoKvBl0Xo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxrT1gzRi9RaXR1QVB5eDEwRnZkVGJUYlpUL1NwTzEvVldacDhka1lMUXZ2?=
 =?utf-8?B?SEtJVzR0dnlELzlhRmpxSk9qY3lSMFBCK3pxZTN6SGJOOHlvanBmR0NOS0NO?=
 =?utf-8?B?Nk91MHRmY3N0YWlZUWk0emxEM2s4dFExeGZXcVhweHQ2ODNIcVR2b1RWUkFi?=
 =?utf-8?B?Ulg0STNXaiswRFJSSHZkNjBTb3JlRnBHME0yYUdCSFBWMU0yVmsyaFlPNGpP?=
 =?utf-8?B?aXErbnYzTmJqY2xnN2xxNWViUlRBa1Y1T0ZiS0Z0UjlIRWxFU0ZRay96UGZr?=
 =?utf-8?B?UUlUYXJjT0hzb05xQnA4a3Z4cFJWcllVTG9RQkd5SmYxNzBpK3ExcUZTRTND?=
 =?utf-8?B?dWNuZXJYUWUyRUNtVVNsQlFSQ0VodWRaVHV3ZHhqUU5lVG9KbUZncnErcWFj?=
 =?utf-8?B?UkRKV0kvRGZKNEdLUFg5N0NtbEZtRXR4U2RZdmtSVzFsMnRQVXFQMFZaTExK?=
 =?utf-8?B?aURkYUtBMDZFRzhkMmhjWWhZSGVkN1ZQL1hYMVVEUU5tcEhZQ1ZMaWNpMWgz?=
 =?utf-8?B?K0Evam1JWHh5aDJjWDNQUjFKaENnaXRiNjFSbkNjMXloNE5rMnJHbE9TZlpQ?=
 =?utf-8?B?QzY5MEJqM0RwWFFnTjgxL2FEbzdQVkpzSjM1Y09JbnVuaFE1NEdlZFZoVURs?=
 =?utf-8?B?L2UwMzVpVysycHV1a2FYWTdBalh3ellHOVV4N2wzTU14SWFoY2tJWFB6Z2dR?=
 =?utf-8?B?NjBoZkVRWUQ5TEFwMGRUa2IyTkt5Vy8zMnZvSUNwZERuSDlWTzNXSVgvaXdU?=
 =?utf-8?B?MXdzTjFpYnNKbFBEQnZ4YUp2UTNZQTFRYm13NUpPb0FTUEtxWmpLZ05OMExn?=
 =?utf-8?B?NjB1WURNQXp5OGI5NlZ2SUxPSHQ3RDlUTFBMaWVUT0JoUm0vbnhXYi9LWFJm?=
 =?utf-8?B?MkJZOXl1NkFBb0NrZmpMckZOL0NzQlNFOXZNQlRnYWhuZFVsQzhNYnRQZlhn?=
 =?utf-8?B?anlxU24vVmxKS3k0YngwNjJXN2g0RkFLN3lEWmFhWEFFZnEzVmhhaDB3RTNU?=
 =?utf-8?B?WmZUUFRmaXRCKzdwYnZNY3N1Sk1pV0s2V3IyWXgzRDZLRHZ3endJUEsvcFJR?=
 =?utf-8?B?aERwb2ZLWlZ6Yi80RjZNTGNoazNiUVZmTmJKeHhsSWgzNnZWYVhZekl2d09X?=
 =?utf-8?B?ckVNbVoxUDAwZE9mMXNhaTFRTlpaVEkwclpwSm9Cd2xQblRLRElhSytObVJH?=
 =?utf-8?B?WXdoVWZmVS9DOXV5MG01bHFwVCtVNTN6UkthMCs1MU5hZUt3T3E0VXgvaWVK?=
 =?utf-8?B?bVZLcEp4aU9HUElJMjlzUTY4bFd5UXNBS1c4QXRhdFVBZUh5RWtiMmMvUENv?=
 =?utf-8?B?SWxPTXAxY0hSa3VsVGsvV2JOclI3UnUrek9BV0JCSmtrQ0tkY29WOEk4MWZt?=
 =?utf-8?B?UzlKemp4Y1JiZkxxQ2ZudXhyV1I0UHVOTXVPeVhjZGJTaUcybXBHVVFpbC9U?=
 =?utf-8?B?RitlQjhzQThDZ0xUOVRtOW5sZ1l3UkNOVi9OMW94Y2xuNjhTdGlrRlZsRjhY?=
 =?utf-8?B?U0loeUtHcXRsY24vWVpEaElTUTYrVXpVRnFTdFh3SFIxenZhVmRhaU1rbHps?=
 =?utf-8?B?U2liWmN5VytUY2d1VmNoNDFaV2FtaEU3MGFjZG1ZVVZSQitmaE1teDNJSWQr?=
 =?utf-8?B?TTE2OGxtRERoaC8vM0tXTjI0WmljWnVEOTROTWloamczdHhrMnhRMkdsbUhG?=
 =?utf-8?B?bzhwV3cycDM2bEVsM2piSjlkQWJvbWZ1Rk80dUJTWTRndWVVRHNpM0dFb1FE?=
 =?utf-8?B?NENrMGFVMnJIZ1psUjNORytVL08vNGp5NXlXR1kwWkR3azNFN1VJdDd6RXhL?=
 =?utf-8?B?K2V1bUFXL2xkYSs3UEtQcE9Sc0w1cTBEZ20rOHVXZWdYclF6eXo1L0xDYUNo?=
 =?utf-8?B?Vk02WGlOTit1RjVnTHpPZUtnakVRWlZhWTBZTzJnZk5HL1JuWjJzTEp3Y2x1?=
 =?utf-8?B?eFg1NEdBNW04Wlp5TGxCdStGUU5YMkJvNVJtOVZ2cHVNTHNtYkFleit6V1Qr?=
 =?utf-8?B?YksvU2FhZWxlRHdLd0xINXdXY1I4SngxakJFT2FvYWtrYU5zOFhPWXhJUWla?=
 =?utf-8?B?NFcvRVNOOFFINU1xTXNCV21hM1VnakgraVJKR2NZMWV6Wm15UlZJMWwrSkg5?=
 =?utf-8?Q?liQkMPNbjuC3hvaLGY1wEccPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd7e844-7073-4318-6d0e-08dd3a944492
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 03:24:24.0322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N+4uhVtfyerOCfSawSiuTF5/zvhVfsqWqgfkS2CL31CJw1W5jYZ0XjbV2WjdSs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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



On 1/22/2025 8:28 AM, Mario Limonciello wrote:
> On 1/20/2025 23:45, Lazar, Lijo wrote:
>>
>>
>> On 1/13/2025 9:10 AM, Jiang Liu wrote:
>>> When GPU suspend is aborted, do the same for dGPU as APU to reset
>>> soc15 asic. Otherwise it may cause following errors:
>>> [  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper
>>> [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
>>>
>>> [  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper
>>> [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
>>> [  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ
>>> enable failed
>>> [  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
>>> resume of IP block <gfx_v9_4_3> failed -110
>>> [  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume
>>> failed (-110).
>>> [  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns
>>> -110
>>> [  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error
>>> -110
>>>
>>> This fix has been tested on Mi308X.
>>>
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
>>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/
>>> amd/amdgpu/soc15.c
>>> index a59b4c36cad7..0e1daefd1a8e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -605,12 +605,10 @@ soc15_asic_reset_method(struct amdgpu_device
>>> *adev)
>>>   static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>>>   {
>>>       /* Will reset for the following suspend abort cases.
>>> -     * 1) Only reset on APU side, dGPU hasn't checked yet.
>>> -     * 2) S3 suspend aborted in the normal S3 suspend or
>>> -     *    performing pm core test.
>>> +     * 1) S3 suspend aborted in the normal S3 suspend
>>> +     * 2) S3 suspend aborted in performing pm core test.
>>>        */
>>> -    if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>>> -            !pm_resume_via_firmware())
>>> +    if (adev->in_s3 && !pm_resume_via_firmware())
>>>           return true;
>>
>> I don't think this can be applied to all environments. For ex: this may
>> not be applicable for dGPUs combined with ARM CPUs.
> 
> I looked through amdgpu_acpi cases and I'm not sure I agree with this.
> On ARM side amdgpu_acpi_is_s3_active() should never return true because
> ARM doesn't support PM_SUSPEND_MEM.
> 
> This means that amdgpu_choose_low_power_state() shouldn't set is_s3 either.
> 
> So I don't think this block will run on ARM side.

ARM is not the fundamental issue. It's for any platform which supports
suspend/resume outside of ACPI. The original patch is accepted only for
APUs for that reason.

Thanks,
Lijo

> 
> That being said, we might have other more fundamental issues to worry
> about with suspend/resume than handling aborted suspend/resume when run
> on non-x86 so the whole set of amdgpu suspend/resume code might need to
> be revisited.

