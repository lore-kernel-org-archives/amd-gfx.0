Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FE0CF9C6B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 13:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC9310E82F;
	Wed, 25 Sep 2024 13:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLQHulk3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8573710E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 13:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4q0sXlwdjivADkeeLlRNFmF7ZACDetbQ+LzXyKFfZBorH02EXO9ZD79gwaB2ghX+RHldyEkP/hMDQqDpQq4m5EoHUElXZazoS7JMeMlv8E3hBSs74nei4RE6SWaf4SqD1lsrMyARKzNnTqNFDqMGYnLnvtsfBg879aJcsb7xXPxJemBi4x/kroGpoRtgd9+vSdls0U4o92wjq0Sm83FpDaFOPLqChlOS5FCxk0TqhlnHwP2ZnnM2by+5AsWwV1/6pnizr2cw84uaLUParqyr4/uWPNZYFQ0XmWZnBsVdNCHA25hUWM823+kOqH8E0XIy/G2OSrVU0BuiLo4vn58Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJs7CxJVgl8xNUxOkp2bVL8eHjl7m+1x5qQO8NwHg/4=;
 b=KO0f3CiQXu71dAIImX8/0ZDIz6jY+J3j5us0eeGVZL47QEk/MrfT/JOfiJYxsDmw9Aq8wjpd9F0lW//SEeIQ5Yu3zDSWulK7kuOmp0pG2d7u0g6qBMK94yYMX9R0dKDrsYNYJtsR1GINCDSiLGPgshcB1E1OQCWS4j1kF3pbqqpAl8mg+MsOQeTQyJwlZnS7cyZgPYn9wHVaGdHGh98X7Bym2e4yrFKwqeteZVSMohszhVF/ZyA906klddGY5bUkwwokipedHE/t0nIwaZV1RpLffJMsYLCmd0axEGad6KbT9eAKPJ6ufjxAoiLeHmMjh824oEgwnMV0obQjTFiseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJs7CxJVgl8xNUxOkp2bVL8eHjl7m+1x5qQO8NwHg/4=;
 b=hLQHulk3PwqU6u12EDPzgRPc4NURpMCundZHNciw8C9jQBsQ+esVP/tXaaniKJ3Ah+wqHrvjO3xbsgZYz4BN7JyKw0Cn2hP1/b9gM2gXjRZCkNFHhpckTLOb/0XCfggZBJv1n2v1P0VsiZMYkegtVLPTTCZj8nc/8m/fliyZWqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 13:37:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 13:37:53 +0000
Message-ID: <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
Date: Wed, 25 Sep 2024 19:07:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] drm/amd/pm: stop extra checks for runtime pm state
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: c85bd4a3-6b8e-4c5c-ff4b-08dcdd6741cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykw3YW1WVFpFZURZdHY1RHAyVi9QZjhqQXVDZlR1WVBxY244ejhXOWROZ3R0?=
 =?utf-8?B?K0hlMjg1YmtKTDlMSi9Ebi9RdjUwWlNKaEhIVnNnK2llQXhoSzMyQ2FMSWJ1?=
 =?utf-8?B?WDVwWGxmS1pzVS9SS2djTzVmakVJTW9QMkxBMHVEdVJLRWVOZFRIemIwc2ha?=
 =?utf-8?B?emJ5SnBXTVlMdklqVmg3d0Y5Nk85VnhHeEVqQm9lU1dGWTE1c2FndWJIb2s4?=
 =?utf-8?B?UnNpdURjNm83UVBNeHUxTDNnZlYyYlJGTEQyV2tzcHhabjA3WG83YnNwMHVO?=
 =?utf-8?B?b05RR0ZsSnVrVWw4dTJzR1BQcjFZcnFpVWJCRU9pdW5ob3ZVNHI5d2ZnNGJX?=
 =?utf-8?B?b3pGSWJMWVlGSVpoa040UEwxN1BmWWNhaE1HUFFxSzYxaHRzY0htZldySUJM?=
 =?utf-8?B?WUtUOC9FNmw2bWlxVCtKSVpWZkZHMU1NeGVHb0dVQk1MK0RaQ2Z3QW94Ynl3?=
 =?utf-8?B?bkNxbnBpc010UzRJeHdlbnNNd0JOQzlNWlV1ejRDZy80eFFWM0FYY3B6MnpK?=
 =?utf-8?B?ek9HVmxtOGYzSWpQNnNpTXZrRWMra004bXovSzV0ZmFQM0ZGWGJ2S1hoRHQy?=
 =?utf-8?B?NlR1SEJPZlJ0ekRIdmd1bCtJWTZZZTlnUGtXczREMkRVUjRoOENCM1Vjb1cr?=
 =?utf-8?B?VDJZVEhLVDhGamVnMGdTVVNFOUdOVGxRTWZ3ZGhsTDQzR0lXNSt4NzZWUTV1?=
 =?utf-8?B?NXhrcDgydnFhTWdGVEpVem9YUmhqaDNNRTdPY2hPaEVkZVcxTXFpb3JmbEVn?=
 =?utf-8?B?L1VUSm1FWWdkNlFxMXNmVE9zYnVhVnJNR2w5K3BCWStlUEpOVTFONmlJZk1H?=
 =?utf-8?B?MXAyQkQ4T2ZlZVNWVFg2N3BoWDB6UTE0dUJxM2tSUitzWkhaa1gvQ09ES0J0?=
 =?utf-8?B?NUNQTjliWG1uSHpNc2pKM0E1T29FR21xMm9RdlVpWWxDU2VrZkZ4NUZPdjN4?=
 =?utf-8?B?RUVmWGU0SjcrczhlSU5qd3Zjck41bHl0NCtjNTZMZkZ3Nyt6M0laemUrWHVm?=
 =?utf-8?B?OEVjb3I0MXZvUzlTYktxMnp1b1luVVdGWmIrRFRHSFZpVWNPQWZ5bGdGazRL?=
 =?utf-8?B?UG1yZHE3SHBVbVBnelZHMDlWdnNBRzRGZDJ1TGxJOTFRZ0p0M3p2eDZySWFp?=
 =?utf-8?B?TkxiTzZNU2drdGExOUVxd0w3Nm5JMzRHdEJJVFNZM0VNdkdrZ2JuVStmK1c0?=
 =?utf-8?B?UHpkUWF5L3BIb0hqOTE1YXl3QjJKNSt1c0dBRHpndm4wRlJmMEhNeUJiVnQy?=
 =?utf-8?B?YitpaitPQzJCZll4d1dnK3U2ckNJYXZ2bW9aZ09vM3hpc2dQbFdrM2xNak5N?=
 =?utf-8?B?Nm1Sc3lyTG9vUmEva3o3UkNRdjkyMTZzamdURkMyMUN1YmdMS1pXWTNpVSt4?=
 =?utf-8?B?Ym51VlFZWFhlWGF3T25ibXBUcHlraVd3U1dwazBzUWMvS2R1UU1Rb0tkdDhq?=
 =?utf-8?B?M21LNTVrclpOYWpwL0ZXV2NKMllCOVZvNUc0RG1NLzVqOHJEODNLaVZTK2RT?=
 =?utf-8?B?QzdqNTdCbEJZOC80QldpbzhwckUzak11Tnp6djBNaXBJT1hiRHlEdm1qRUFm?=
 =?utf-8?B?TFh6b2ZTNXFBSmhvNWNOQVhpR2NYRFhhQ1ZXMlFUQjQzdi9MRlRPZk9ub2FG?=
 =?utf-8?B?U085eVZxajk3ckR3N3dhQUhKdk50dytiSEU3YzNRU1QvT2J1UWZ4NHF3ZHY0?=
 =?utf-8?B?VGN6VmMzTFNTQkhoY0pTbVFiK0ZTVkNLRU1sQzFkS3BtaHY1Nk1JOFowcnIx?=
 =?utf-8?B?dGVyMmIyQVR2Vzd2bDZmRmg4RXFnc0tEcmdINjRIck5xTXljK0h2cGJ0bnc5?=
 =?utf-8?B?RW9ER3lxb0FaYk1OVGloQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vktvd000R3p2MVh1elJGN0xuamZQcVR4UG5WME5GK29rZkRDUUwwYy9PcGtH?=
 =?utf-8?B?MWVhWGRjK3IwQW9iQ3hqT2FnM01jcGp1R1hDa0xLcGNHMll1eXVYVzhKNDhI?=
 =?utf-8?B?U2dUdElGbEEwMnRVbkV2a3htVkpCaHNJSFVUSGYxM1dxeWRqT3J3NTRmMllE?=
 =?utf-8?B?YURDZVhhOEoyVnpNUmVwTzloTlRNWktXWlJ3MGlFOTh0ckNkM0RReXIyVmxS?=
 =?utf-8?B?T3ZrR2ZJRWcrM0ZWbnMwbVlPbk4wcGgxTTJRZWRGVnROODNLeEZPZThOMVIx?=
 =?utf-8?B?bGd6KzVwWVdYME5NeUpiUWZ0ekwwZEZOc3lVcEd4aHBpejhVUHdKRXhpNnlX?=
 =?utf-8?B?MmczTHc4R3FXcHZsNjk4UG81MlZ0VitkZ3NicnpDRUcwZVVUOG9QYmI1L3pm?=
 =?utf-8?B?WnlPbUc5ZWRyczJ4SnFkdXV6Slc4Nk1GRTVRakRHaEdzKzk4eGFBeFkzU0Jv?=
 =?utf-8?B?YnREczhXUGRQdENZemViTkY4cWhZOUQ2NW5jQzlYcm1vOThRS1RySk1WbEM4?=
 =?utf-8?B?Y3l0WWt5VUttNFgvMFJ6YkMvY3JjWG9OajdIS3ZKaXVCeEwyTkZFYWp1Qk5t?=
 =?utf-8?B?MUlaMElpY0V6cytnbVVCYlhlWmJZdVNxdTUwQXBib2hNK05XS0VpdnQ4SzJt?=
 =?utf-8?B?a3VzbzJSMW5mVnZNWG80aDQ1WnQ4WFpFeDZZTlZuNFdsNG9ncWdacHROVXZF?=
 =?utf-8?B?UlZzbnhYQWgwWGFTdEdQc0c2L2xqODdNT1hWVUVWQ29Ldkd6djZLSG1hQVpM?=
 =?utf-8?B?V2N0WHhIWWFnK0NkeElXWThuZS9BWFV2azFENVQrTFlSMXpJU25ERGpTNWRq?=
 =?utf-8?B?WHBQRkt3djZoK0FyOXRkZWozdGlFVDhua3hQUDdoNGIva0tXMC84Z1JGS0JU?=
 =?utf-8?B?ek5reEl2RTVvUVBYeUFjTXRBSFBQMjVrNy9ZQzc1aDJTTFU0VVJKWm9wcmEz?=
 =?utf-8?B?cVcwakdhTXlGbUF2b282azVxQk1MV2xSSml6dTlkRFYrWkNaV3FGUGRRM1o5?=
 =?utf-8?B?NkVTVUlNQ2gxUzdHTDQ1MnlKQy8rM0daeTdxSUZ5RklrdmRYMzRXZkpnaEVI?=
 =?utf-8?B?U3dNNFpBY1VVOXZCRmdIKzlKb0NHK1lWanhJU2hVSldwRStzTXhNUjI2allY?=
 =?utf-8?B?aHc3VzY0Y1h4S1ZLZXQva2UwRC9yQTRHd01LSzkwemx1Q0JMdW9LY1BzZnlJ?=
 =?utf-8?B?bzhlejZFYjNqNi9acjhMcDlheTZLZUg5SlJpcWFCSEhGckQ4TEJJM2pmTTRx?=
 =?utf-8?B?clcrdUhraHFybCtGaXR4NVlvWk03NHVGQ0FYQjdUa2dlVVI5aUdjUGhJcTlN?=
 =?utf-8?B?eUsxWnMzZmJ4djVTMTRWZDg3QnRGYi8yWkpKeFZOMEltLzNlampWWm1hWDJW?=
 =?utf-8?B?UGtINDhNckoyM1cvQ1dDMWNGbXdqbFdHeFBFY0JkNFREWmNheDZhRlgyV0FK?=
 =?utf-8?B?eHZ4QXVzWTA3Qi9OV3lIcnFLVUhFSldmem5vWXU4RUdxZDZUV1dmUWxrZnUx?=
 =?utf-8?B?VHNaWEM4QXgrNkdBQWViVzFNaUhhTm9DcUJyZ2gycS9iSlhPK0h0cFZNenBk?=
 =?utf-8?B?OSt2NjdYeURjaWtJYVRoemZUaHNkNEpsWTQvMW5QTmdhdHdSQjN1OWphT3F3?=
 =?utf-8?B?MnZwMDhvM09aQ2Z2N2pzSzVpTzJuM3VoTHh5R08zVmxOeVZoZWhUSmdHZy9N?=
 =?utf-8?B?U0FXS1c1R013dC9UVUZ3MDlOcitNY3lGNHNSYkVuVGowdVNuZlB2V0Y3aCtO?=
 =?utf-8?B?QU51azh0UTRqajRnRVVhR0NzdWNEQ3lNc1FRdmxSQS9LVEdxbkE0UllvSmtR?=
 =?utf-8?B?QmUrM3V6aDZuNWZYY1dwVTE0UkU1MkVWdkRPRitYSHc5b0hnTVZPc1pKcG50?=
 =?utf-8?B?eGpqUWtHVGxHSmt0cXlYZ3V3QjMxaDdEQTNYdGp4RklXR0hXelF0Yk43dVE5?=
 =?utf-8?B?WDB4MzZEcTh1dzRuV1lVOXozQi9wMkYxeWRHeHNIL1lSY2lZM3FDMnZaT0Jy?=
 =?utf-8?B?ZzFmMG5zSFVxMUM0M2lvTW9DVVNRS29CTTl1NWJmNHpDTGRhakJWdjVJZkZY?=
 =?utf-8?B?NmFzalQ5K2RJTlZXVkFCbXlDanhXZDZLUDZEVG9SZCtKWVVPNnVlSzlXTEZh?=
 =?utf-8?Q?TjAJFSry1ZO1zBgnJXoQ973AG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85bd4a3-6b8e-4c5c-ff4b-08dcdd6741cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 13:37:53.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0rjz+fyXp5/ONoJBGk8CBuYsZ3G7rZvksHUUrnj4Djdk7cpKRgn/4KvwLAXS6L+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
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



On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
> pm_runtime_get_if_in_use already checks if the GPU is active,
> so there's no need for manually checking runtimepm status:
> 
>    if (adev->in_suspend && !adev->in_runpm)
>       return -EPERM;
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ------------------------------
>  1 file changed, 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f1f339b75380..13be5e017a01 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -142,8 +142,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  

I believe this check is for accesses before the device is fully resumed
from a suspend sequence. That is not tied to runtime PM.

Thanks,
Lijo

>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -265,8 +263,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -361,8 +357,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -396,8 +390,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -523,8 +515,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -837,8 +827,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -927,8 +915,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -993,8 +979,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -1242,8 +1226,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -1299,8 +1281,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -1376,8 +1356,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -1464,8 +1442,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	r = pm_runtime_get_if_active(adev->dev, true);
>  	if (r <= 0)
> @@ -1574,8 +1550,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	if (adev->flags & AMD_IS_APU)
>  		return -ENODATA;
> @@ -1784,8 +1758,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -1822,8 +1794,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(ddev->dev, true);
>  	if (ret <= 0)
> @@ -2697,8 +2667,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(adev->dev, true);
>  	if (ret <= 0)
> @@ -2825,8 +2793,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	err = pm_runtime_get_if_active(adev->dev, true);
>  	if (err <= 0)
> @@ -2852,8 +2818,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	err = pm_runtime_get_if_active(adev->dev, true);
>  	if (err <= 0)
> @@ -2913,8 +2877,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	err = pm_runtime_get_if_active(adev->dev, true);
>  	if (err <= 0)
> @@ -2983,8 +2945,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(adev->dev, true);
>  	if (ret <= 0)
> @@ -3149,8 +3109,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	r = pm_runtime_get_if_active(adev->dev, true);
>  	if (r <= 0)
> @@ -3682,8 +3640,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	ret = pm_runtime_get_if_active(adev->dev, true);
>  	if (ret <= 0)
> @@ -4649,8 +4605,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  
>  	if (amdgpu_in_reset(adev))
>  		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> -		return -EPERM;
>  
>  	r = pm_runtime_resume_and_get(dev->dev);
>  	if (r < 0)
