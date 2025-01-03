Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D0CE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 23:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D8010E97E;
	Fri,  3 Jan 2025 23:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vg1xJxJv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B1310E97E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 23:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJx9/cHDsA6FpAgYMqgkCDtNd3RWACdiTZv8bQuYeP8nWQT5Rb73uinlQiUESFwjShciAxedDYDAFHPrktfJJCJA7lmYKlPxSXCB473IpgGpVWF8vX5ciVQd5EvPQwmswkeDtfzNz1mu+W86Fd7l8NQVpg6QX35XQXm4Pi0Iy5HPMmEYx4QE42ZeFSNdKBHiieAywhRUNYoFt/f0VjAnW6BuhzXIhqPKPNnpwIKvClgo5uHcd/OMyrODwXY0l3DjRpJzkLO9Hn3SNTaGFlQMVu1E66kX84gVfBsIJ3xmqT1eXLXxyCBk48cDFvwDK6LNm6xNOBb6oHTFP9e/k3ZaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPsR7HUQU/zHI6AFuMY/z3NHvtFJ+V+GrcNCZQV8oY0=;
 b=Wgg5UH/VCBxqOS/bX0EIHViRLuZP1sivw1naiypoEb2OTlr2zfCa+5VWfqlIXNyKv/GRO0Yp3MlGy/aHUQZhF6XHI2zfpMhhjN14pWbdPrZeT2ixhs6T6JQ/RvAKbZ+D+94PGek9AUo1U1BV0071xIShYZ6X8jx5eunocKBz8Wa2p0IVSXiu+l3CZkIxF1xjR20aSrcLHWCvQ+l9hm6qbfLpWi5ykuGfQOxHF9/1kzwmByZLtMb+vu3wa2VUMShgpV5W/IMPwiivTTwlnJuXQTYeVNquV3zBYFrcT9Z9dHvEDTa46bkUmRD3VG5YDcQWcfBdFGrHh3ocw0Z06GPFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPsR7HUQU/zHI6AFuMY/z3NHvtFJ+V+GrcNCZQV8oY0=;
 b=Vg1xJxJvZVYorTz/MSPAvXKEeHraOzoFp9kYZRy4qgojvKCP2Eh9d871uKRgBsfMj0u0wuEEm9RkYdwZS1UmhN9fm9j8pIQ9AFvgWu2lL7AWWmXLbZh3MMh3BV/qJ+Q98jpeMXenGF9Fqdz/3QtPvtE2ytzjBYc3hPm/vhCUdUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 22:48:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 22:48:42 +0000
Message-ID: <bebed1f0-bcb9-4e00-bc33-85f0c9a1c178@amd.com>
Date: Fri, 3 Jan 2025 17:48:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove unnecessary NULL check
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250102150124.1323685-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250102150124.1323685-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0044.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: d9259ada-6b52-4e3c-1dd0-08dd2c48c578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0RSNWxJY1BxVVFaTkZzaXlZNFIwOWxqWGtMVjlxSXdWT2R6WXNzd2ZnajlN?=
 =?utf-8?B?czhldGRheVlpWmZ2OHk5Y0dlSU9zdmhGUitXejQ4MkE1Smw2TnFIS3Uyd0Ew?=
 =?utf-8?B?RFBTWlQwVHJpMmFPdnJzcWpJNEpDWS9laVJWMnJ0R250SHlQT1lBYjRiVXhF?=
 =?utf-8?B?K2JMWi9WUEJLYlVCcW1aZXJoeEh3QUZpVlB2d2hFakFoMzlQTldqZXJvSVJ0?=
 =?utf-8?B?aGlNcXh0aURxTEZOTDNkV3pDWEVVY1Y1VEZ2bDFEcWFncDlGS2pyU2N0NlZP?=
 =?utf-8?B?MWQzcnV4RWllZFg2UVFyWG5HMmRYeVBtWGJrTDZEWXhUU3kyclFaZEhoSXAw?=
 =?utf-8?B?S2FTYkFxdGVKTEpCbFRWK3dVK3IvRU5WOXczdXZJMkQxd2RYQklpc1JlQTJS?=
 =?utf-8?B?TkUxSWhoaCtIUXdNVEE5bm5mOStzQjlzU1NwbXllRGU4dXh6bmlQOFJpQWpI?=
 =?utf-8?B?ckwzOWhlV0RaaG9yQ1U3UTBTOFdGeWFsb3dPVytEaGR1cmtnSmdORHJZMzg2?=
 =?utf-8?B?S2I4cEgzaFVXUlZ2VTg4UlBkZEp6NHZNc1h3cjU5dU5Rdmg2ZEFPUzd2Q2Zv?=
 =?utf-8?B?YmpwcXZ1TFBueVpocjNYbER3WmJ2SldQZXc2VW1NSFd5dXBqRU9vV0JUOEVx?=
 =?utf-8?B?ZlFPWmIreWorV0ZpZlUvcWVYNFd4UkdqWDlWZVhGblJGb05xVlY4YWx2TzV2?=
 =?utf-8?B?eGF3MWYvTnp6NVBMOXk5djVVRjZmb2xBcFEzYW1wMW1sMmN6cmVoRWxMa0RH?=
 =?utf-8?B?ZVRNQjlhUjQrZzVHVmpYRUQwclllWU9lNFBMUXQ0Tno3MFRYVTkxTW9qWEti?=
 =?utf-8?B?b2xaQnhSN3JQQUI2blhCNzRGazJZOGVDQnFJVzM1MGtjSGRieHowakZmUE5V?=
 =?utf-8?B?elFKQlE4L3NQL1pYUXlaaGYzcFZpN0FuZFVFMlVRV3dMSFRyYTNQTk5kSDA4?=
 =?utf-8?B?ZDR2dWgwWnl3bkptN0g3aXZ2OGN4MGFrUE9TcDZHWXY3aHZXeW1xeGlWazdx?=
 =?utf-8?B?eXBpUzcxaWxFNWllRVpwZ2dlM05jTXJIQXduSEM2bGJudlpDeklxekFZZHhX?=
 =?utf-8?B?NGdEZE1nSkFIcHN3TXF2Rmh6Vy80MzVLLzh6WDRrWnFvWTFwS0t5MUpzT2tD?=
 =?utf-8?B?WnJpNUxXV1B2L0ZOMit5UFZFMGhGaEJEZy9tZkxUZjlTS2RlMmR6Q01hbk51?=
 =?utf-8?B?dVdCQlVJK0lWVEp5Y2s5ZUxtZ2RaYXUvRlhXZGVSMzNKQWl0TWVzMTZiMkFS?=
 =?utf-8?B?NE5EZnNqM3NtdUZRSVBXUUQ1L0JxYVJsbnczNzdhcXZua2RNNTRPL2Y1cjR4?=
 =?utf-8?B?b0J2NTVrbGRQSC91SDNSZWNQWnV1Q2FhcnZiWHZWSXlYYlJxOVNSalk1eFI4?=
 =?utf-8?B?NURtSkR4eWI1TE5TTWN5b3pQUTNmaUh5dC9aN3hvWTBCcEhKU2NIcXR5WEds?=
 =?utf-8?B?QWJZWmJudkhxd0J2SU5kZFB2bVpOK1E1VjR2L2JHeVR5Wlg4a1Z1Ykg2eE9R?=
 =?utf-8?B?V1VjaGRldC9UcWVrdXJOMENZZ0VyZHlRRUFvU0hkditvRlhiWUZvNUd5ZkZt?=
 =?utf-8?B?dkNVZHVTaEFKMkNyVVBhWklkZ3dzY0YxQWlkRkdtYUpSamNyeDR4R0p2R29z?=
 =?utf-8?B?NVF0NU84TmpMMEwwbjZ5NmdhODF2ZVB4dUVqVE5vUHB0VkxnVGpPLzZuMm5p?=
 =?utf-8?B?QVBNN3FzNmx4d2w3V2lwMnExK2lrVk5UY1Zmbkd2RzdPNUNpVkg1VEZJdTdv?=
 =?utf-8?B?QmFMK3Z3cTZ5ekNDNmlobzlQdlFsY1BwQlZkeXU0b0JOczRPdmdLdU0wL3lt?=
 =?utf-8?B?QTNhNXc0ZGZCbkRpd2o0dTYzbGlac0dncGI2VmJFYy92OGlKckwydWdYTTQz?=
 =?utf-8?Q?vF/zLKxPgSONR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE9ONDYwVXdmelEvUUZjeFd5RDl2bmtudmxrU3BYTmdmZlJKc1J0bmJuTlU2?=
 =?utf-8?B?WHlhV1hkT3ZFZ1JCYU9xNnpGM2k2S01Yd1BNZnBqQ0hCNmpCWXhzdlF4d3hi?=
 =?utf-8?B?KzdsTGZybHc0bmdZOC9KMnpPbk1WWllabDE3Q3JKdE1QWkh5UXllbG52cWI4?=
 =?utf-8?B?Z0JuNzg3Yk4xUXlERDhiSm15cFFzdkM4T2J2azN0T2g5Mit2VkVDLzdyaFFP?=
 =?utf-8?B?NDZiL3dLRU5aNjlldHJiMml4QVZJVWZSejA4QkdHTVBIalJwM3F1MXYvdFUx?=
 =?utf-8?B?V1F0SHBZNFlBQVFVcFkvNFNtMGVBUFFzWnlNd1FUS3liTWJZYVhwTVVoWXE4?=
 =?utf-8?B?N2l1d2hFQzk0VG5iUllFby93VUcvS1dia211S1kxcDgvQzkzV09aQko4MWln?=
 =?utf-8?B?NHNOa3V1VGJ2Wjk5NGRMSzVvdHlmVitUZ3U0WkZWUzVrMWZXMVc2Q2U4L2tE?=
 =?utf-8?B?dEdJalN5b01NVTd5RXBXdmV4VjNmaVNiYTRlZDdmWGYvNmFTWTZRWStINUlY?=
 =?utf-8?B?YVBXbjhtK2RtNU9PKzdKc2pvS1BjSmNIU1BUOVJVcW1XaWVtL0htQXhyRW02?=
 =?utf-8?B?bjBzSEZSMjVZbklyclFjR2ViUEpoVDRnWFVrM2d1dkJOcTVXY2FPK0YxNVRq?=
 =?utf-8?B?V1NSVWhqRG5NbUN3czNOZ1lPTXhGNnpNSHliTldCQW4zWWxUK1ZSWEI5TFFx?=
 =?utf-8?B?bHFMMyswQ09KUFFiRGtJSGFMQjd2VUJlWFB3YnVzTnVvYm42R25ySVEzaFZz?=
 =?utf-8?B?S3JNNGQ4TDhwV2l0Q1FZUlZ0Y2Exd29lSjgzS1B0Z0FYK29EN3htb2NHaTZK?=
 =?utf-8?B?WG91dWNXbU9aU2ZCZitMTkV4NG5yNlc3R2tRdUJCZGIyNW94eWdMTkRTZmZJ?=
 =?utf-8?B?WklDZVVjZHh2eTBwVU5kc3A1aGhRdy9nNGdibjFJTkpSKys1L2w2ZUs2WnVD?=
 =?utf-8?B?YjA3TzJXWjh3UkFmdmJCZGtOZ1JQd3JLbVRjbXN1OExwWDl3N0JQMHVJMW9m?=
 =?utf-8?B?eXFuSU9hVU94MnJmZ0hUelFCUis2VHNCQmlmc2JNcnlGZkVBbmR6enBqUkJ0?=
 =?utf-8?B?ZjQ5V1hYOVNHRmJydGJqVlBZM0lWMFRuYUVBQ2h4Zk56Nks2SFhFaGZNcEFL?=
 =?utf-8?B?TnBaWVJwcmR0MzViYTl4QzI4VXJsZXZJUy9Qd2dBTzZKMGJrOEJyNWVPbTA5?=
 =?utf-8?B?Q3BZNW9wQnV2V0FuVHAxNktueEVjZ2swTTM2MG4rMm5YM1JHRzI0VXpuNkxE?=
 =?utf-8?B?cytjZ3hLRDV1bWw1RjJlSHFOcWpKejNhcFVYcnIxRWpETFFaU0JjNWdyaGs5?=
 =?utf-8?B?cTNMaGFLRCsrRGhyd3hQcmo3eHRRTkZmUnNLaE5LSGUzczhnalVEcTdNdFdI?=
 =?utf-8?B?c2hGRGR1SkpNSldOZTJ5SGFieHQ2TzBwS1cvY0dlUU91U0RuYTRhcHZxNERH?=
 =?utf-8?B?Z3EyeFM3NVBtTXo0NElzYXgzdFhLdGRxQkhtRDMwdU9saEFPTzR5ZlNNL244?=
 =?utf-8?B?Yk51RkxienFPUWZEajFSVGxRUlZ1Qk11RGxsbUZBUXJYdEVaSXBGTE5Wd3FI?=
 =?utf-8?B?ZDEzai8wMy94VEJFN0ZPUXN3bGdoVm9ZWmZhd3FqTGcrNDZLOStFZzhuQUxM?=
 =?utf-8?B?VXNsZVJ0Uzc5MXBzMDBkY0hjUVdCeW54NUlPbUFlbWZMVHlMN1BYdThPLzBj?=
 =?utf-8?B?d3IwbmxaUnpQdUxHRTF1UXV4cDI3NkZselZBMzNBanBNRDJCaVV6R1BuZFI1?=
 =?utf-8?B?aVNxcDVTSUpUWVQvYUtySnloRzMyb2hyYm5ibVI4Wkpla2JTMnlCZFZPencw?=
 =?utf-8?B?RlVWaVhOZXZNVGFjOVlSalZRUWtKMDM1K3ZlaVdvUjIzVDhOOHdZSUFVeC85?=
 =?utf-8?B?K3dpd3ZJNlRQQ25rdkJwOXJyVkYzVTBRVXl0bnVsNUFwcm1UcHRHa2NUc0dO?=
 =?utf-8?B?bmFINXljeXVIODBiN0V2NVZvWVM4REticzVkRklrTFdCNStmNEZ5Z3Z2Z1Ru?=
 =?utf-8?B?MW90aTRIZ2RXUGx1SFE2Q1NiRmRDemU5ZGlKanYxTlVPeHQ0RnFLNk9zWk02?=
 =?utf-8?B?UHBDd01lVmhXRVdTblRXVis0d0o2ODdhUVowRzRGTDBUelF6VUdyUzc0aUJx?=
 =?utf-8?Q?u0glro8hNckmqjKpsyRhujis7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9259ada-6b52-4e3c-1dd0-08dd2c48c578
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 22:48:42.0195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZQPGDmN9+C+AboSToO2XlkmnkzZe8cMacBjT344L0mjbIEvZH1dHGtehDV38hM4Yd9DwoXr4iOBx+wpuoDv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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


On 2025-01-02 10:01, Kent Russell wrote:
> container_of cannot return NULL, so it is unnecessary to check for
> NULL after gem_to_amdgpu_bo, which just is a container_of call
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 7edccb675921..a1691ed717da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -196,10 +196,8 @@ static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
>   {
>   	struct amdgpu_bo *aobj = gem_to_amdgpu_bo(gobj);
>   
> -	if (aobj) {
> -		amdgpu_hmm_unregister(aobj);
> -		ttm_bo_put(&aobj->tbo);
> -	}
> +	amdgpu_hmm_unregister(aobj);
> +	ttm_bo_put(&aobj->tbo);
>   }
>   
>   int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
