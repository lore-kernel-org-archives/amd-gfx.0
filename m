Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AA8D63923
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 10:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEBB10E6E0;
	Wed, 20 Nov 2024 10:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WRCITlh4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FF310E6DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 10:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApMePdSs7aZwXli1ZVmi/Zhq6/oMzcjm9OjQY4BdvL4UKYpd2HozGCBqskk9Q1EwaL2tlIKhhPyGdckb5VqdwwAATOJaj0GSpjuyXBm4ScOgbCkpNPIJIeTzXPsN9wgwzDDshnoXH8I5WS6Gx1arci5YmmRR3pjY8Ig+xeopb0+k6ZqwN0wgXyLoE9rxqRkuG9r0+sQdQYIYh7wilYSj8VM0z3u1ecE2NwZ1Q3q07N5/UIR4Ojnl27WeIgO8kiGT7rzQtA7vGX4lYb37dYfmxggXRuQcO/sjUfWFYlllhz5QJrR36DANh3gFzDYqcpm7Jm9G+5c+irNU7RN4VHFgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNiCT6Tpx0Kb2jUXMS4n70eq7piIVc+PxdJpXBr1ydo=;
 b=sS4qOQX0ClxYAr6Fve3FXgQo9kyN3JJLqYuzaeN83HMLWRQiIw+/C2Wt7A3m13NQkOwkEMkEzWcQHvSgcZ2dF5mZ6QfoWx+Ox1qfRSN2LSscBzhDTyDNwAd4vsHOwVFsVlciZszD/R7lnAEtq4ENT5w1SRg8gqqcLWmHPh3CXD2IS/bNhXWvVQ/E6xV7KZUQfb1cJhX0rJtq4DxtghboAPxWNNsF4wyTwlTin5iNGijWZbFmao0xpSAWyab6BsRf9QdECcZSwCoQD0CE//Q66d7wDz0Qh2b2KX7QBrXSTAq+jjIxcixv0fnDD++COcIi5w+slkfqwstQBzHwsakf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNiCT6Tpx0Kb2jUXMS4n70eq7piIVc+PxdJpXBr1ydo=;
 b=WRCITlh4xuK1sprdEeKTRt+j3IM/sTAjw62zYeJA9pz3AMLSgRSntwwybxrPCsDQby8WwTfLJNvGeqs1DuvYd5VDuidMbdirEnYGLvaMS97prMJ0ZTzkDRIaiPP/cxbRckiEWEAy0LYW0uCRJmhtAUaC5IFmpC9Y1SE+oYXeV6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:34:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 10:34:34 +0000
Message-ID: <9bd31692-9372-40a4-af9c-0c34a01535f9@amd.com>
Date: Wed, 20 Nov 2024 11:34:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add NULL ptr check for non userq fences
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aa9870-e492-47d8-0005-08dd094eecb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L205UVpGaTdHS3Iva05wRXdXNDFDRW95ZkZJVk1YQkRQbkgxbUNyUDRBQjl4?=
 =?utf-8?B?bEZsQzdiMjFHeE5UVnF0aEJWNkxMYlo2TWtkNW1XbW5sL3FXbmFvZzNvcmhk?=
 =?utf-8?B?TEVRYlFBV01KbXlIa0hDSXRxZm5sTFpCSm1TOWxjRmI4U0REckpVTW01OVFr?=
 =?utf-8?B?VmZvWlVKOElLTkVoUVZrMm53aWp3YmlUNW9ONmhobC9lSkpJTlBoRFp4WnpQ?=
 =?utf-8?B?SitaN3lvdytCcENNcFU3UjZmd0ViaXlJcENJVm9oYTFGQmtsZnFKTmk4dUFy?=
 =?utf-8?B?UWNPZ2Zvc1VrQVVhQ0VSQjZGSndPN1hrM1QwZmZmQ3FscXVmSDZ2T3NpS1NP?=
 =?utf-8?B?VUYrSGh4UDdNQ3hkL3BWbzZYMWpVaUt3b0xJblpYTG1kMVhPZnN1S1VPbmFw?=
 =?utf-8?B?R1dqT3Z5b1JEV3YwT3ZOSHdsbGlBNEwwcFB5MmNkdG9xM2hwS0YyU2Q3ZGZm?=
 =?utf-8?B?T21aRkZTK01JOFFFSjZ0bUVIVlNvcGhwZHhNN3Y3RDhDRWR0bzJSSnhaaWk3?=
 =?utf-8?B?UFBNU1ZaV3lDWTVCUU0xVERvTktvK2R1cFhOenkzZTljSG15aEl2VERtSUs4?=
 =?utf-8?B?MkVwUXRLUFdsSnFpa2JnN0IweVFQMWJMOUIwQ2R1cHAxM01DNUM1UmFFUGZv?=
 =?utf-8?B?MmVvellnN2tIdG8wdDZjTDVHR1E0STEweU9oa0hUaTBCMjcwdkgxSU5MdGdz?=
 =?utf-8?B?UFJIQnFuSTJBUklVWGtEcjRDa3pRZnFtekdRUXhrSUx3VjZGTWhpVEJXTHd2?=
 =?utf-8?B?bFkwcUQrRHZ6Z1BEQXF3TjMvU2dCUVRpM0lSTi9USjhkc3AxTHZDZWdxc09C?=
 =?utf-8?B?MnR4Q0VVZlhlOWlwQjRxeTNjOEMvSyt0RStlemYwdFh5NTNYaGdsangvaSs0?=
 =?utf-8?B?Y1pzWCtua0E5WVZ5cjhUYzRmbFZsWGR2NkRXTmVreDNLcitMZ2wzekMwdTJF?=
 =?utf-8?B?REdlMGNpT3JHMzFRWTlTWk1LSVc0dytsUGFCK0tJTmN0YXU2S0ZGdWNkUStp?=
 =?utf-8?B?TEFrNmthVlNSekFSV3VqQmQrdmZ3b2c5NExDdTgzZUl1R1RxSE1LZFpWb2dw?=
 =?utf-8?B?cm1xZngxN1dVemVlSzhkOHh6ZWg2LzhreHUySHFNNUFFWHBqN0UzU28wZmdu?=
 =?utf-8?B?Z1hVbVJKTCtDbklYSnJDWGlmdVVoWldEbW90cVJ0bWptakJIWHBXcVg5TGVZ?=
 =?utf-8?B?RG1nSk5hNGgxSkI1V24xMjFZRnZEalIyRlpKaFEvdzBBV000b0ludWJMSCtG?=
 =?utf-8?B?RWNmbEV3VUlHNEQ5Y2V1VW9zYnNvSXVlcGhudjB2TDJialhXbnJlUWx4d0dS?=
 =?utf-8?B?VkNKVndlRlVFV1NCbkZ3UzRjMTFZcmdGRGxyYkhGZVF4OC9IN25aSUxMWEMv?=
 =?utf-8?B?MlhlSzBaY2xteVF3UFhyc3NjSkF1d3NIWXpBMUdBeW15bnFLOE5vVXRMSEt5?=
 =?utf-8?B?RC9qRGMwblVuSE9tRzl5Qk9ENUdaZytpa2VDOHZqNG41V2FWc0d3S21YOWpn?=
 =?utf-8?B?RThMaG5BejdVUUtkUk1MUU5VZFhscEVyTVB6N2p3WGpTb0RyN0hXMC92Vk5U?=
 =?utf-8?B?ak5qUnUySExUWUNaVHJkUkZ3RXpqendhdWp6MDhEMUxlUWtSV2N6RFV1ZHlx?=
 =?utf-8?B?QmdBck5yaWRxUFNJczR0M3RCdHR0N2txOGZ5czAxTnZuWmdWQWhQNnZuNENF?=
 =?utf-8?B?MVg4OXRWUWp2cTJscE95ZzJncWR1dk5NcE1oaU5xejJTN1pRYTAzM1pUMnlH?=
 =?utf-8?Q?nNrj0VFrPIjfhYXQfWZpjalSYGhaR5KYMTwd2Kt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWY2VWRFZ1ZVTlMyYldXRC9pMXVXWENIa0t2TzVGYjJtWHY1S2d1THgrWkpx?=
 =?utf-8?B?aHhXanVaQjJZSXIrRXYzbmtSMWxEUitwK1JuQ09kMW16dEw3cDJRamlONGlS?=
 =?utf-8?B?eUl4YktWaDNUdmY3RGU2NlJYOE1XM003cW54dWlXZjlOczk2bitob25MSWVV?=
 =?utf-8?B?R1FPQk15UUpZeW5XMXJPN2hKSm5Nczc2bWlQTUpsZWhSMGlBcjNkNVBGc3FZ?=
 =?utf-8?B?cU42ZzYzamV4SzUzbjUzdXJ1N21uNjcwUmxOc3hnNmtmanNGNURyY284RXVF?=
 =?utf-8?B?TkRMaU1XNU0weGNnWDJHSUhJTEVucmdsbmlHandoTzhoOVNLOVF6RzRib2p3?=
 =?utf-8?B?ZnRoeFB2YlB6bFlKT0xKL0NEc3hpZUs1M0RUSHB3a0ZRekJhQzVGL2RZdXRD?=
 =?utf-8?B?T0xJamEyM1hVRWNOTkRsMDBYeXM5UTVhQ3k4VHJOYjVZYjFpbG94WU5aYy9i?=
 =?utf-8?B?RWRIZzRDYTFtbHN0Z0hpY0ZLTWtHZ1IrVEsrTjVtWE9CeWZoVGZrVVZESmFN?=
 =?utf-8?B?WnJ6bGlUWkN5OTQwRm83dkFxQ1hkeWx0bkJubU56RkdwTkltNTFrUHc0YWY2?=
 =?utf-8?B?UkFRbFdtVWZ5WFRUb3JTc2VrdUlxVzJ1QWYwUWZuSEtmVTV2SXJnUVlObHdD?=
 =?utf-8?B?R05xekN0QnJTUWMvNER3SDE0TzhPeGJhRGx2VXhHNUVQZ2ZUKzNxWHViLytU?=
 =?utf-8?B?SExMZFptRWdXclBpUUw3SjlDYnQrL1pweTJ6alVBQnRDSUkvenhza1dlY3dW?=
 =?utf-8?B?TEdMRTZWTFNlYUNibjUvUVpCaXZDUGM5V05xNWtLRnVGNmdPRHRYdUFpNEJj?=
 =?utf-8?B?T2psS1E4NmlDRXlyWEhGVDhOL0FmUXE1MTJ2akVJS3VIakNqaTJlWndETzJU?=
 =?utf-8?B?cUxjU2QzK3JyWDE5SDhyZ2FleXV2UU5ZcS9jNStiNWxQcDcvamNOU1FPTk1T?=
 =?utf-8?B?b3ZsMXRXaG1zUjM5OHpuNS9QRUZDSmhpejEzS3BDSEpsR1l2a2dKdXZMV1dj?=
 =?utf-8?B?Vi9MTGpLVmlFMXNKVkJUajBhZUY0VFZEb00zYnA2am5lY0UyWTNaZlZoZDFv?=
 =?utf-8?B?V0ZOak5WWmhhTVBkeHJRYnVnOHNTTWJJL2ovN1pONExZc2l6Sm14ZktpSXEv?=
 =?utf-8?B?OXpTcWViWFNHd3dMTktPa2ZnQkV5VGVxSmIzeFI1M3hOcjMrOEsvdE5GdVAw?=
 =?utf-8?B?TllKZ2pBTnAxZTQzUzhBdktJSVRuOTlGd1dXcnl6QUJuMXIxZWw0NzJzb0Jq?=
 =?utf-8?B?Vk9NWmtrc1VQY3pVTlNQc2VMaUdjMThoeTdTMEN3NVRQaUFTbHBFZUtxNTdm?=
 =?utf-8?B?enAxM0VmUlljNGZMMjduZ2YyQ2s1bDNkaHNENkNQQ2xYRmFWaXo3TThEeHpz?=
 =?utf-8?B?eVRJRkNOeGpkV2xscFBVeUhZZytkRXJFUENOYzJicTBJTUQvalduVE5teEYv?=
 =?utf-8?B?QTJTK2J2WEFZQ0d0WkFPdk1JTlRxUWlkTlRLS0VaSnluVmJpaWJ3UTZsU3dO?=
 =?utf-8?B?ekc5N1NJdGxhMFV1YTVKbE5HV3NtMVd3UnhmMmVtcFZ0TWhBWlNBcDl4VXVt?=
 =?utf-8?B?QmZFRVFKcytmSGVDYjMxeWFBYzY5NWQxVC82TlIvcXBsOFUvaXFxM3dOenA1?=
 =?utf-8?B?alBPU0I4WEY4anZMdlFXUkJwVDRNcDVLeFJMRnJZOTFtaFJsYWowODJGaWhn?=
 =?utf-8?B?aFlSRWppRkZUZ1JRZzdLSC81NW9mSFFlajFJTE00TXVUMEJSRnVSb0ozeGZZ?=
 =?utf-8?B?c1BTZ1UxNkpNUTFrRXd1K0hwNFlrV3FmczNEcFQyRytOWFBTMFFLYWN2bVlJ?=
 =?utf-8?B?K3Y4OW9EWVoxcWk2c09rdndrNTBqTVJ6U3RHdENQUzNyZEZqYU5SM3hQanl4?=
 =?utf-8?B?TmRMOGd3TWtCcTlmZnpDd2I1VFJGc0NCS0o5M0UxekpKUWoxWHUzcUZXVUtm?=
 =?utf-8?B?R0l6aFUybnNBb0NRU1JTaElrZHlqOVhnVWdRdmRhbHBmVzFjdXA0OGxUcEZ4?=
 =?utf-8?B?Z3JLaDdBVXgvWFFkdG82L1ljN2NNdnV2RlRMQVgxdk1QQTduaXlJQlRZUWlj?=
 =?utf-8?B?bGpSSlpWNFZqd3Bhd2Z4Mm5wK05RRDNoSHZ4T3BpVXRwSGVHTHIzWi92RzJU?=
 =?utf-8?Q?EYUCLjaQkp8jJ5Qt6uPH67q5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aa9870-e492-47d8-0005-08dd094eecb8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:34:34.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wk88mHttzwxWX8ihVxrz1tiu9bcQ3PU3XyoM04LjFwl/YCJClJWyVrQfpjsl+a8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

Am 20.11.24 um 10:26 schrieb Arunpravin Paneer Selvam:
> We are observing a NULL value in the non userq fences,
> thus added a NULL pointer check just to avoid the
> NULL pointer dereference crash.
>
> v2: Moved the NULL check above the non userq check.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6157a540c929..76f7babd7a54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			struct amdgpu_userq_fence *userq_fence;
>   			u32 index;
>   
> +			if (!fences[i])
> +				continue;

That should never ever happen in the first place.

All fences in the array either come from some reservation object or 
drm_syncobj. If any of those are NULL then there is a bug somewhere else.

Regards,
Christian.

> +
>   			userq_fence = to_amdgpu_userq_fence(fences[i]);
>   			if (!userq_fence) {
>   				/*

