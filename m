Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B9D3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 15:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A27510E464;
	Mon,  8 Dec 2025 15:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2n8AaeDQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5380210E464
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 15:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6LduyyZvcHYv1PEVs5WkODOYwG3T8L8KUuFEg+tD1DL9On0Ycd9iSgKuqNdc9k51bVFx/b8YBl3/PZBGGNpFkwdrhEq3QkBCU7cAuWPtNz9/Dp05lvMldRu9umuzfb07SuETgNeBicEa+F8/2OflvFJfxBgGHp19nlvxQzTvVxf1b0EOzwKOSJ2e7RauGqYXq3UNboYdqQvRSbzvvCwRm0ijrvOL4BNOBtnpNdkt1vaX+8cfHWNUrNygEjsQLejy57ldE8ndHT7hecf7XQUtK+va+/+OONqwm6MTVQwOKXyD/GRTiMQwYGO+JTZhmhfyn4IgEBkQhm70lmg4tVJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX5/ZohS04kJc5dpg0St6ALvVlCB3x1rDzDWdSjmp+M=;
 b=TP6Hd4rOSIGadsKtjhKJhmwH4bhyv6W+a0Cgsjrtsg3QhhhwyDBvcHaPfpj8xDCjVG5JKZX1uFLXgkibQYHa91K8FAkgK9cqCfB+cAlAlcRvPJpc779xujWXehTkj4O183tS/wsOnYE/kf5BYjV31YBvYbJKFf0ybgShlp4DEgonFT6FWkT/pDmqnzNjxgEx3Ksscne/qF6IEgfg0fpeTh1ejqb7N+plCx/pQC6Pf4UcOFFqDnL4glojtkokO3wNKnADp3fRW1b7XQar9FbkRVthtttF4S+dVRG+f/rtSdw8jrMDQIwgkhpmg/jrtNpNUlD9IPriwOROfuFfeaLLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX5/ZohS04kJc5dpg0St6ALvVlCB3x1rDzDWdSjmp+M=;
 b=2n8AaeDQGb9os4FlB0TJbcfnORdedMw8wzGBfHFtxc7gAxuho6Bj2MvHjkfhoWZDGliCrwJn6h6rqISgaVTAVXCrtEQ3XeSyo+EPTYxCaGCBIoBCX6qYH5w+7n7EbIDoPkYwKZzvVxmz/P4xJWBJKTWl5R6nh209npMVmZU002E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:31:23 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:31:23 +0000
Message-ID: <149322ae-b0af-4990-8823-468b34e16bc6@amd.com>
Date: Mon, 8 Dec 2025 10:31:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Fix gfx9 update PTE mtype flag
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-2-Philip.Yang@amd.com>
 <f67ed498-717d-46fe-82e3-82c7dbd6dda2@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <f67ed498-717d-46fe-82e3-82c7dbd6dda2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b42a7c2-d111-4b81-7e6b-08de366ed7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0svL0gwdmp6NHNKOVkzZkJ6UFZsTStrNDIrZERVRHNpUjdJRjRyaFBkdHRr?=
 =?utf-8?B?c0Z3M1FLUTllNHFyRWtlanBoOUlENmxYRlRUZm9tRVZCbDRhLzk1SFpjQ2hu?=
 =?utf-8?B?SDkxaVFWMkl3b1phc2dDb3BvS1paTzFhbmd5bXp3cEtuK3A0Q0w4TkFPU0Fw?=
 =?utf-8?B?UDNsdC9XRTFnRXZxU3d6b3Z5Wk1Fc080WUorSEtkWXE0SlJVVmJrQXlxTVZ4?=
 =?utf-8?B?NUNVUVNWVCtkYmx5OFFEYjhad2lOMVBlUUFNRFQ0STAvOGdNbzhxS3dnb2ZE?=
 =?utf-8?B?UURjNncxQ3VsMlovS21iVWhRaUx4NFpYMFdsVzBqQTVYWW16cFlOdGZ6OFpz?=
 =?utf-8?B?NUNSMmgwbWZ5ZUcreStlSzM2TTIxYmVSQmQxcFhUdjMyUDc4YTV1Ny9Cd1Zu?=
 =?utf-8?B?WjVRZEZaQURTSXBuVEVxUGhvWEM2bWFjU3YxWmpZbjhFUkkzMjE3Qzdpdisx?=
 =?utf-8?B?WkJ2NHJLZ3I2YWRXbnZtSVdKREE3STlubnNHQTZ0UGpOUFprYnhoVllIUVV1?=
 =?utf-8?B?WDJQM3FWUDRGckE2eTBacUdpTTlwVlExYS84SHVMSi9Zdkw4ZjZMcE1UaDBM?=
 =?utf-8?B?OUExaUlPUG5hQ2RTRXhKalM3ZE5pOEd0OTRtb0VGL1pLTndwR0Q2cDhjMHY0?=
 =?utf-8?B?djEvNHVhUVZnT0FKaEw1ZlFGS2ZnbGdXRkVsaUpyMWxwWUR0Sm5ia3Y0NHJm?=
 =?utf-8?B?TDcrWE9iOXQ1elcxemdQM0dsSm83U0hzODNFS1p2cHBMRzJKTFdRUHpPRWtQ?=
 =?utf-8?B?em53S3BBYXllblBndE9HVHZzV0YvZURXUkZqNVg0RnY5bWFVWWN6L3VJWkdh?=
 =?utf-8?B?bjJDS1R1Ym1ZQjROU09POWdmQzM0d2VHdEdETlRIV3JzQ1VaVDlMbGJ1YTRU?=
 =?utf-8?B?dkFvNElITTlsYk5LYytUVjhhRlNySGl5VzRWcWRxWDBEM1NDQktFaGRhMlFy?=
 =?utf-8?B?TmZTdnFnOGd0b1V3VWtPcU5uVkNXMjBnOWQzcXdHbkQwcVV2MWRTNFp5MEJC?=
 =?utf-8?B?dy9FNEUrWnRUc2x2K285NU0yN1FQWDNWUlE2WjZVc2FRS1AzL1VMcWZrd1dK?=
 =?utf-8?B?dVhWV0ZiM1NDUlgraTE2aVpSMWFiUVF1UEJta3JiK1cxQXV4MFJ0eHpQMXNJ?=
 =?utf-8?B?OCsweUpTTlpRbUIzbkxGV3BtUC84ckUyeitONUErTXd5MjhHRlRkSm10dVZD?=
 =?utf-8?B?MDBaTjQxQkZmamlyUHFkeFF0cG9jSTNyRExldHUydE43RWp2V3Y5cFN3eWND?=
 =?utf-8?B?MFF3ODlaVDlhcit6UFBUdC9MWmxadDZXQllYTWJEUFJOU25la3lpNVMrZi9G?=
 =?utf-8?B?V2lxWjhMRmNmYnV2eTUwbFY2ek1ZY1dBUmJDOCtycy8vYS9UeEVkemJsSDlF?=
 =?utf-8?B?K1NPQTZTRnJ4QjBmR1g1SHZrVUhQRkVpMnVURnZmcldZUW1WVDd1S0R5eWd0?=
 =?utf-8?B?aTV1b3podDVVQWVQZmxOVGpsZUJWc3pneGdiTklyU1YyUC9MN1I2U3h5aXpI?=
 =?utf-8?B?NXl4cU9xUC9aMEJPWnMySjQvSFFxYlJIMEErSHdCeU9XS2dNNnY3R0NaS21q?=
 =?utf-8?B?cFdveC80TUdCWjJrYzlESjRkRGU5RFdkeHNXY24xR0pKcWJPb1pzT3NiY2hU?=
 =?utf-8?B?YnJNS0Ird1ZsS0FGQ0c3NnMwT2lTeC9obmV2ZHdJam5ld2lXSFA1bXZCZEFV?=
 =?utf-8?B?NUhjSXJEaWpWeFVVaGNOVUh6L3BQMXpGRUNIVVNjamQ1b0ExOWt0Q1gyckZk?=
 =?utf-8?B?dXBNS1BXZW9lSm5FcnVDc2l1MjQrYW4zaFpuK0lhdHhvSGpsZzVVNzkvZGph?=
 =?utf-8?B?M0N3eG9iWUFyQWRrL3F6NGw1clgzZ0N6VEhoaVNYUHlUOUJodGlJdGgzallV?=
 =?utf-8?B?VCtWaGxpMzVTMDg4NXVxMGxCQjMyalVORW9LeU1PR2xBNzZjYURMRzBpZlAz?=
 =?utf-8?Q?sCuSPdSEQKzDTPsdefh3J9gndtfcMxL+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhVb0VIc2kycjBhN3UrUnlORFJ5U2FiZWVrSjFCL3QwWEgyQk5ydmZ4aVNL?=
 =?utf-8?B?emNUeGo4aEl4U05LRHRpakhiSVBlc1g5RFo5ZVdNVEdjckY1eEtUcElaeFFm?=
 =?utf-8?B?MlVjdmhLdDVNQzFqUVlyS0dJRytyeTd5bWFLN1hUT25oV3F1dHMrRm5EajlW?=
 =?utf-8?B?eXRyRmZvUEtMSzE1SmhiaTJPTUYzQWlXaXNJZUtHcTV3MWRBT1dGNDUyL2RE?=
 =?utf-8?B?a1VXNXhLUFRMU085NnRuSUlEcjZYYy82SFRlSW9QNXVqRHZRdE1VNzRWQTRY?=
 =?utf-8?B?NnNGbGhmYlJjb1NlOEN1K25rYUNrUUlOQVltc1N4R2s1UlYvekxCS0VMTi9U?=
 =?utf-8?B?T3RiZHdJWnh1SDYxcWxRTC9LN05BNm04emQ1UTkxcXJ5M3dPa21HK2NScmVi?=
 =?utf-8?B?UmliTVJ5OVZRT3hWUE14UlZKTUNRdkM0czRSLzA2L21FYmFDMktySDRYTXB6?=
 =?utf-8?B?azBablRjNm5mS1k1THFIVDgwVXZqK244bDVpbFl4dXdEVS9wTUpBeW1vSmFo?=
 =?utf-8?B?QWFxRVZJV3gxU0oyMnRodVd0WDR4WDlrTy82MENmNWZVdENoY2VHR2oySVVa?=
 =?utf-8?B?Y2s0S3o0SVRGbDZIcnlIRTVjbHlNQ29nSmZiZnFZY3dDZ2JQZWlpaFdJVHBF?=
 =?utf-8?B?V3RyYW8vT1RLeTFvOUJ1eHlsRUNOY3gwQlo3NkpaYVRjSXpHZ1hIbUZpRHMv?=
 =?utf-8?B?am91ejk1MjQ3Ymh5UTNoVUdyM3B6QWJOdGhiMy9XWmlaUjBaM05lK3pYQmVv?=
 =?utf-8?B?RTFwT0lSZDZHVnZKZlpIWmJHdlJkL2VEcE1TaTJqNWd0M2pGTGR4ZDVQVmV5?=
 =?utf-8?B?dnR3RFl4L3pjWFdMdmZSYTRnWnA5bE5VcmdPc25YWDVpWWZsSDdNT2NjeUNM?=
 =?utf-8?B?ZjhXRGZuRUFIN3FzdFQyVlRSV0U5MWY0UXoxcEh2UXp0M21LQ1hUT0JlQUZZ?=
 =?utf-8?B?RHdRdi9oQlFXQ0d0UXM3RVE4YlM2czRhOSs4SXp4ckFGazhjamUzVUEvcTZm?=
 =?utf-8?B?NXpBaE9rbHllaXY4aFZqRzVITE5TanlxZllNbjBrOU55RXgwMFBtVkN4YlNi?=
 =?utf-8?B?NjNyS2NaQ1FjMk9uUDZ6eGJyZ3loeE9zNFdZamV1bmVNRGFPUjJReWhhR1J1?=
 =?utf-8?B?R1NURUlHOUxjMnNGcDV3ejM5Y0o0Ly91RkJ0SEpFRkh1VjQ4N2I5Vm9ucWRl?=
 =?utf-8?B?TThyL3ZEWGpCaWg3c0JrR1hWUDRvUTM2VUZ0cGFlOGN6UVZQKzgxWU9COW5H?=
 =?utf-8?B?MEVFNHNOV3lGK0tZY3FPVGMwYVczTmk0djdXRHNnVVdJL01tWXJNeGtoQnp4?=
 =?utf-8?B?eEZieFFpeEZ6UTFkeGRlTmJmUUlFNDJkaW40Z1FvM0ZqRkRnT0tOTnlpQThy?=
 =?utf-8?B?WXFHY0Q3amdNd1IwNXUvUktibGp6K3p3QzlmeDJ2TDdMS0hYYXFmK3VFdEpX?=
 =?utf-8?B?c3ViMmpLMlVkdmdnOEhFWHNHR3ZGcmE5MHNlU1hMN0ZXbml2b2dhaGZZeTg2?=
 =?utf-8?B?UWNEWmw4SUZnTysxQ3Iwd1lsSE40ckhUOEwzNitZazlZL0ZqVVNwb05yUlF4?=
 =?utf-8?B?Ym5JVUNVdXBMSkNmWmF1dEJvNEl4TGxjS3JxVjRkenc3OEdwVTYzSGN0Nk5z?=
 =?utf-8?B?Y1NUNHRISkhpNGcxSGNCY1lEbklzTHRSTE80cUI4MmhGY1RnRTZIRW11SytG?=
 =?utf-8?B?TkpoYW1zMkNJSVJuTnQ3V1VERWF2RHVmeU1zMHZnMlp0enh0eFNUcUxxcEQr?=
 =?utf-8?B?RE9aS20vb2U0bmwwVWJJYUFUR1doaWZrRmw1Tm1zQzBvK2VBU0lyK0wxSk5C?=
 =?utf-8?B?VmdUa0YxQzh1ZVJyV2xRUTB5UURaVUxJeDc5c2JhdkdCVUIwLzFLSmcxWElw?=
 =?utf-8?B?MUxuZEpHcVNSNGcvbU56ZGV1eUQvM3RWa1lxYjNhNndXSDNKYUtSNFVoVGJW?=
 =?utf-8?B?SWdCM3JMK0x3eEZpcmpycE8vY2hOUSs1bnRjaFNZMDMyV2xKc0sxMlZLS09x?=
 =?utf-8?B?WUtGNlZwV3ZSM2ZEaUllYlZsbGxtUWJKOWJHcVByb1FhQU45NXg0SFJYZ0tY?=
 =?utf-8?B?Y1JjMU5CdTlRMTM4WVlOZit4UXlCVmVUcjFGRTV5RjNRQWNnbmc5Z2NjTURq?=
 =?utf-8?Q?mtwc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b42a7c2-d111-4b81-7e6b-08de366ed7bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:31:23.3305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAQGyFrohhLtSm8NmZPb09P2Ne80J5GzhFXM6Ogls9Kh5R3fCrJsmCNCkWNlvLDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405
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



On 2025-12-08 03:34, Christian König wrote:
> On 12/5/25 22:49, Philip Yang wrote:
>> With this bug MTYPE_UC 0x3 can not update to MTYPE_RW 0x1.
>>
>> Set AMDGPU_PTE_EXECUTABLE flag if mapping flag set, but should not
>> clear it if mapping flag is not set, to only update mtype.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 97a04e3171f2..d2e8b96c0372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1194,8 +1194,6 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>>   {
>>   	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
>>   		*flags |= AMDGPU_PTE_EXECUTABLE;
>> -	else
>> -		*flags &= ~AMDGPU_PTE_EXECUTABLE;
> That change looks questionable, we said that we always wanted to override the passed in flags.
>
> Why is that necessary?
Double check this again, you are right, we actually need this, because 
adev->gart.gart_pte_flags always set
AMDGPU_PTE_EXECUTABLE (it is used for both GART and VM bo mapping), 
amdgpu_gmc_get_vm_pte
set/clear the executable bit depending on the mapping->flags.

MQD and control stack actually don't want AMDGPU_PTE_EXECUTABLE, so it 
is correct to clear this bit when updating
MTYPE. Will drop this change in next version.
>>   
>>   	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
>>   	case AMDGPU_VM_MTYPE_DEFAULT:
>> @@ -1204,16 +1202,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>>   		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
>>   		break;
>>   	case AMDGPU_VM_MTYPE_WC:
>> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
>> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
>>   		break;
>>   	case AMDGPU_VM_MTYPE_RW:
>> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
>> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
>>   		break;
>>   	case AMDGPU_VM_MTYPE_CC:
>> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
>> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
>>   		break;
>>   	case AMDGPU_VM_MTYPE_UC:
>> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
>> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
>>   		break;
>>   	}
> That is a really good catch and should probably get a CC stable as well.
I will cc stable.

Regards,
Philip

>
> Regards,
> Christian.
>

