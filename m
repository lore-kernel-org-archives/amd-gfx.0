Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A50CE7AFC
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 09:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC7F10E9DF;
	Fri,  6 Sep 2024 09:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cm5ICubP";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615D710E9DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 09:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt9Ru+9FlDke+sxVadaI3P0GJInvrT/opzff9IqnVHdtkWBz4AacczAK9q788XeD+dEgKeJoW+1vpc5H7je2QTPhGKujwJGyPZ23L18vtCv4bFIZCyW+MUBBfw7AnaWZcrqE4jI09NWtEUHXRJFpQjvvZWAutTiBSuqzKi9WeJRuAmgsB2qfUFalPOH1oKjz4ut8UJP6bqEQjldKKYsx8BVcGjnD0dtrMDbwZtpM24KRcq8Kjw8gDGxCMHC8LciSIvL2DizlJv6b5TIRHoh1N7sKxftsLogOG2tsoPeaHPdUA14qKfrHrTWUie2tC0HHw9vS5jLiRgUFtQjWcVyAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyXapuBfnPLfCQENrlJteLOWqcbbtL0jqcw57aYk4UQ=;
 b=U9jEBa8b8er9z5i9OWvcgSpXwZGot2LkRa3rsbsM02ALbwXgHOlZeKzxsaTrVnWxrWfkV0mw8DgkrzBhiHoMniC8uGSVijJPOLMWi81kqf1FY8etHGFJ0jCXUcDxAwlRqZ4/U6XqQfepYdOnFkzV4ORdkVAgS4R2watFfgfM+Zl7vp1HA6qEYDaJPRI4yqcIjErn95D7SzmaNFCxXVg9EKjWHi9+BFm+WZmIvy4RDRdOVSUAPmupuyaauxwccGSGJhEaEnZ/WM8ETP92R+15PDhv8hBncjXu9MkpI1WyNHQXOTPhwwociZLtDNbh8ZekrcnnXTz66DjPjYRE/U2OoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyXapuBfnPLfCQENrlJteLOWqcbbtL0jqcw57aYk4UQ=;
 b=cm5ICubP6F+3sIPe5EgFOtt2ZD/tFV2rOWlg8zfuIo3xRhC3/nbHZBjf2He7QvHazrsWF6YaR/YBpo1rI2tTnG9Cl9akkNB5hE1Cadf7/U6cQrrRtaARs0aQ4AC1KUiwN65WdHkTvnoheCjNBGrWIstXknvdG33gekVC2nQnWbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 09:47:32 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 09:47:31 +0000
Message-ID: <1afd8a7e-defd-4187-bfb2-da066cc6c805@amd.com>
Date: Fri, 6 Sep 2024 15:17:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Select reset method for poison handling
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Tao Zhou <tao.zhou1@amd.com>
References: <20240906081251.31139-1-Hawking.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240906081251.31139-1-Hawking.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: fc662d86-36b1-4102-0de5-08dcce58ed70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWxSUDdCR2RwRFNYTXZCSHREUDBLaDR6RlkydmZ0aDhJQlVtYTJsTmZCWkFz?=
 =?utf-8?B?S2NUSGpBaWpTb2Y5WEdNY1hBbUNQT21iNDgrTHl3Y2t1b3VFM2dlaWIrNmls?=
 =?utf-8?B?WVlXdlpzWnFsVGZST3B3bEovL2pCSWJBaHptVkk5bDJVWUhwZ3JsYXpoVFds?=
 =?utf-8?B?TmFqQWxZWVVMM3FsdnkvM1h4UkgxYXR1WTFCR3poWUFhWDZuS1RMK1hhSDBB?=
 =?utf-8?B?elQ3b3oxcU0xa3AyMW4vd0ZyalE0NUdGeFFJeXRoSlJqTnFJODNIcU8reURa?=
 =?utf-8?B?eUxPWEJ1TWc5YjZndTRJQkZPdkMzODNrOWF5QWVVTnhwL1pPOGdlUjQreEFv?=
 =?utf-8?B?YzhEMU93M2R1TlBwaTBLaUExeDZ4VmJDcWhTaUlHY254UG84REtYWi8xSHc4?=
 =?utf-8?B?OGEyVmRkSWJZOWpxZW9SS2lnNXdKUEZBdis5L1UycTRNSHVwSEN2NDhhK0VR?=
 =?utf-8?B?cjczME1sRjB3REhRRWRveUpld0ZIT2tlWDVsWGRvcE5rSyt3ampzOTYzR3Ni?=
 =?utf-8?B?bVY1eE9SODZreU0wY1BTci9iM2RDRndzc0x1d3JIUzlmeGJPa09pcXMyYjUx?=
 =?utf-8?B?Ty9qUWJTUVVYMEtEZHNjUVBwUmxNSkdhMUV2YnJJYXlxWi9jRnp3SC84Wmlo?=
 =?utf-8?B?OGE1ZUNkVGtkQ21sVkhzdlk2K0lEdFdxdzQ1S1YrTDdFOHFtdTFlTlV5VXpV?=
 =?utf-8?B?Vkp2V09wa0hrMzN1dUtWcnVKVDNVZWI5RHNiV21paFRlU0luRU5Wc1JLbUxZ?=
 =?utf-8?B?Zm5OV1BGN3FDeExua3B6MnlJc0xVWDNjait1TmQzUmZTWHBHVVVwZzJUWlJa?=
 =?utf-8?B?bDI1RzhBSnN4VlBnSnpVMjRqWlRsSmZQVUU1UXF5U21hakNybUJYUXNHMG4w?=
 =?utf-8?B?YW9MQkExWXlFOER1YlpMN09TYTZGdmxiNHJuZkd3RG1SbWFPTDU0ZWxWbkZO?=
 =?utf-8?B?dnA3b3FFdFI1TkxMUHVXZzMybmhrVjBwemxsL1p4NEthNkdNVEdwcXpXdGxv?=
 =?utf-8?B?Znp3cU9NWjRoa3pTNllYVTA5OXczM2NiR0VkWDBjWlRHaGdPTVg4M1QyTHRy?=
 =?utf-8?B?TWgrNU8xNnVVekVJQ1FPWFJHNkZqaklCVWYwMEF4c2NTSnBXaDR5QzBSUFBB?=
 =?utf-8?B?S0VHS2Q1RUswTDJsbDc4Q2VTUjVkNFBLQVVUZ2hQSU9kYXJ1RjFwSmRFQ1A0?=
 =?utf-8?B?RFpzTFhpbjk3NHRYb3NRdmhncjdFREUxczlQMTdBZExNVXRXN1YvRWpCYkg3?=
 =?utf-8?B?QnBwQWxoZXVCVkJScTBqNThFMUpTb0ROb3p1d0ZEM1lBN2xiRUFNRkp6MjN5?=
 =?utf-8?B?NElJSEVpS1UwNC96c3k1WURzbXhacEJpNk5lZkQveXNMYm5sUnlwYm9Od2J6?=
 =?utf-8?B?YUt4alNCNjhGQXdlMVZyTVRYd3FDb1NSeU5zbDY4TytlT2ZsTHFnVkplVTFM?=
 =?utf-8?B?VkdRaGRETGtkanBsOEdCZ094amErS2VVU3FDM2Y0M2dPMmM3a1l3UitSWW1L?=
 =?utf-8?B?aHVqdWJ4ZjROUVNzbGRTQUM0ckVlUGlKaGc4NUp2anQyQ2o0cVJKN3p5QjNz?=
 =?utf-8?B?a1cva3RObi9qMXp1N2tvUnFLNUZhS3dwME5CTnBTUXR3VG9rVzZPYVVqUGQw?=
 =?utf-8?B?aHlvZEcxZE1kemV0OExQOU1KaXFuM1ZCYjFjMzhJSmVReStrT3NUeHhYa2dL?=
 =?utf-8?B?Q3JDNnpSVEFCYkgwd3Z2SzBJK2tNWTVTckJ3dnIyTnd2RGtDS2U3eFM0c09O?=
 =?utf-8?B?endMVnRUb0dOKzV4N2ZJalo2U1M1VXlrTjgwcGtPaHVPS3QvWXBtdm9SNDU5?=
 =?utf-8?B?cXBoZkQ2ajU2UmlHOTVjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0RXZGJFd3Evc2JkU0p1QlRpSWJPbHAxM2w5Z2VWeW8yNzZJVWxtdUJHN0VO?=
 =?utf-8?B?WHFBQmxSQjc4TFZPT0pYUGRQT2l0T1NRem9VY2dOWlVka3ZGOG1hOWpMc05K?=
 =?utf-8?B?Z2pJMTEwc1hzZzlmOENTNjVmMVBVVTBmNUJvc1FBVnZrQUVoSHN4ZW9MYnBD?=
 =?utf-8?B?Z1Y5NWwveDlWZ2t3T0pJNG1OWEQvTFJyODJxaWUzNTJCbFRYRVdGZHUraDBW?=
 =?utf-8?B?Mk04Mjl3MGF2TzdQdUFxSEpqUDR3aXFPbjV2VmxBYVUrRW92aWZGRC9TK0s3?=
 =?utf-8?B?S1RoUmdqcDJ6SkM3QXdqMHhmZ2txcCtHMmF4c2Q0cUlUS0szQ1VYVWdzejhG?=
 =?utf-8?B?Q2VJVXo5VVVsZFBxb3dkYmJsbnFVL1pSVmc0T1Z3K21BdG9QNGprRVc0dUVx?=
 =?utf-8?B?eG03VGRYUTAxOStzRUZGbDlBZ0lRSkNkQkZCZm1telR3d3RhVGlNUW55ZktQ?=
 =?utf-8?B?cEUxc0ZuYWoyMCtJWjIyZm82VFBlNzhEVS9nMjRaekF4UEhKOWsycFM3c2cy?=
 =?utf-8?B?YWNaRnBieTdOeE5FVG10STlTWjIvZm9pWmdJSHd2NTlydmQvaXJaNkpydytn?=
 =?utf-8?B?cVRYYXpqeVh3c1BTMHg3TnhPZHJqZHZkMlJXUlpUeHhBMm1rS0JEKzNDc3VO?=
 =?utf-8?B?RWt4cEw3NG93TmluQmo5ZVFhckJHQTMyc2REeWhCeEdJeld3L3NFb3Zaby91?=
 =?utf-8?B?ajNJaTRpSkRRSHB3ekwrRWxLZkI0VGQrTGJpOWptcU9KRVZsb0hoNEFDc0pI?=
 =?utf-8?B?bUFvMUpkeWtWKzAwMlNGSXRIOXpmb3VJR1VDUFh1MDhiTnRGaXd0NFRXMDFn?=
 =?utf-8?B?ZmNmUkhSQ2Z5VHlYRUdDQTFOVjdOTDNoZ0FScXlkelh3ZjlJZEZTLzJzYVU1?=
 =?utf-8?B?ekhjWXpiZDJOK2dZLy92WlRhaGJHREt5VDIzMUpCdExEQWJ1MTJZSGVCSnpr?=
 =?utf-8?B?SzFiYVFlNnRMZDlBVEdRUXZCdVZMMTd0Myt2VGRJNGNSQXhHeVpGMExVR1g3?=
 =?utf-8?B?bkgwZ3Q3Q2dHellWMklaWnQ5V1pmT1FpelVSUHJiK09BNGhXNzB6cFVFazc5?=
 =?utf-8?B?ZXdxUDVva1ZUSHZYdHpmWkIrc1kvdzFDa1B2RFBEUTRXNDNQa0k0WHRYdHJa?=
 =?utf-8?B?VSs5eUV1U0JRNTQ4TStaTjZObW1BRkVTaVd6VDZ0VWpTanBDbWJJL2ZwQk9h?=
 =?utf-8?B?QzEzY0J5cnk1SklNREpXMEh1ZG95ZTB6MlJMWHY1ZVQ5bVFDSTZncFB6dW9R?=
 =?utf-8?B?Q1YzckhKQms2KzV2VDNjSkVzMnloRkpJTVoyUDhFajRmbXB2NUYvM0tGRDI4?=
 =?utf-8?B?R0RwRSsxL053Smh6ME5jaWROaUE2S1M1QWFkdkRJOThoTlViVzlFNlBvUGx1?=
 =?utf-8?B?OW5sdG9DUjN6anJyNzJ4VlFjS0VhY204MGRpcnZtNHlKcGY3Q3FOb01aVWp0?=
 =?utf-8?B?dktLelZpUm95cCs0RzJKVkxEeFloYkpyUGsrVVREbS9nSWFmODAwRnZWdG1Q?=
 =?utf-8?B?a1FWWG5SUG0vUDJqTStMbjVyUGMxN3hlS1VSTUlYcnlBUzJFcmI5Rnh0RFd1?=
 =?utf-8?B?aHZpOFJwempZcDR3WnNFdDFHQXN5eC9iV1hPYVdjMktWZkkvakRacExiWkEv?=
 =?utf-8?B?enBCbjUwOEdsTlA2ZExwb1BHWTZFRFR6RGJyZkxrcXhaZXpzWmE3TzFMbnFu?=
 =?utf-8?B?SDNCMGhSdURoNWIrNCsvRHBXMU5NYlY5K0xNU0FBSll6enJ3Ry9kbkh4T0Rj?=
 =?utf-8?B?VWZKejV3YkFOd2NOVmwrQTFEeE4vRXcvZjlsNW9TZWFhK2oxN0xwNlpMZE9r?=
 =?utf-8?B?MEFvNmI2Rmk4WHl5MmZzS2JnSTRDdXFOcG9Sd0ZVUDZvTUxocExxMHo2ME51?=
 =?utf-8?B?WnkweDVrcTNLN0dtaExHR21yMXRndCsva1hiNi9qZG9vWVk5QlMzR1lrZ3dD?=
 =?utf-8?B?NG1CYVRNWE4vZEJzOU9lMjVhNVZudjZHalB3Q1BubUNtUktDb1lPQ0djQ0RW?=
 =?utf-8?B?dFhEWkQxRlpMOGtZWTk3NmsyR0tFRTMyTUUzWTltMWgrMVlHUDh5M2hOUWdV?=
 =?utf-8?B?UnM5UnM1WEs5WDZ2OHJIOFpxQ3FOZW5NWmRyZjJ5bEhCdm5iRnNvM1JZalVT?=
 =?utf-8?Q?5LIn5eo5N3VxwOyN99jbYOzSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc662d86-36b1-4102-0de5-08dcce58ed70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:47:31.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QICJ7mMFna5el3j2SngtoDL2jgBGbwPffpYbvIncuu4js3lNZOsL65VpuX4h6COv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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



On 9/6/2024 1:42 PM, Hawking Zhang wrote:
> Driver mode-2 is only supported by relative new
> smc firmware.
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 40 +++++++++++++++----
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index fecdbbab9894..d46a13156ee9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -167,11 +167,23 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SE3SH:
>  	case SOC15_IH_CLIENTID_UTCL2:
>  		block = AMDGPU_RAS_BLOCK__GFX;
> -		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> -			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
> -			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -		else
> +		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) {
> +			/* driver mode-2 for gfx poison is only supported by
> +			 * pmfw 0x00557300 and onwards */
> +			if (dev->adev->pm.fw_version < 0x00557300)
> +				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +			else
> +				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		} else if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) {
> +			/* driver mode-2 for gfx poison is only supported by
> +			 * pmfw 0x05550C00 and onwards */
> +			if (dev->adev->pm.fw_version < 0x05550C00)
> +				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +			else
> +				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		} else {
>  			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		}

I think it's better to handle this inside amdgpu_ras_do_recovery rather
than here.

Something like -
	int amdgpu_ras_reset_method_quirk(adev) which returns the right reset
method when (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) is
set. Or add a few more flags like RAS_SDMA_POISON/RAS_GFX_POISON and
decide the method in amdgpu_ras handling.

Thanks,
Lijo


>  		break;
>  	case SOC15_IH_CLIENTID_VMC:
>  	case SOC15_IH_CLIENTID_VMC1:
> @@ -184,11 +196,23 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>  	case SOC15_IH_CLIENTID_SDMA3:
>  	case SOC15_IH_CLIENTID_SDMA4:
>  		block = AMDGPU_RAS_BLOCK__SDMA;
> -		if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> -			amdgpu_ip_version(dev->adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
> -			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -		else
> +		if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2)) {
> +			/* driver mode-2 for gfx poison is only supported by
> +			 * pmfw 0x00557300 and onwards */
> +			if (dev->adev->pm.fw_version < 0x00557300)
> +				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +			else
> +				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		} else if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5)) {
> +			/* driver mode-2 for gfx poison is only supported by
> +			 * pmfw 0x05550C00 and onwards */
> +			if (dev->adev->pm.fw_version < 0x05550C00)
> +				reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +			else
> +				reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		} else {
>  			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +		}
>  		break;
>  	default:
>  		dev_warn(dev->adev->dev,
