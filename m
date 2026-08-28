Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D8FC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 14:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEE410F3E2;
	Fri, 28 Aug 2026 14:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6uv/BCU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7523B10F3E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfavAQegCC1w8l04OcTC+TizbGy+oEbgaHvZKTuK2pq0Oedl1QHY4o80JD6HecgX6h4IIVxDWImxHNH8IDZp8IDhulccAVpyZI1OtIl1Tn+I59IPP0VJsUn7vmwiHwutcROxHpWnMX7eUFMVzemaAmX4AfRx63zimU84JAOrcZXuzO6hD2OYT+QhARoNaa559lt2IO6md3CcGYAJ8vbpkEpMQg7cKnx2/hVw8jJdALOObInuE9Q2QSiipkNj/rixZjF5JrzbsDCu/5y58vZmREN6zd1981B31xtbmDVRpItODgffJ63RKGYQX/NOKOZerobD1CLaxwgBphTWL1OT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyntuax+HsAczX1HOzCjWMTBm10grFjSf0OgyUb1g2k=;
 b=qNp3wvVmav63yTZXc6ih/Omc1pSQxPoYBwfpr8l3Osd94mCGRqhcLiC9l1uaVWNAD1OFmKntFxsIy7Vq/my5RCNFG/9cEtJakvdCq0C+wimEeESjqLehRSJQ8G7dD2Np3bp1X/toLVOxRMlLwr6r063lYE7eJc+5ljl5bhUKwp0roYYZEUmkCSmE9ppBEXzT+YBRu64H9LKAdob3g/3LRLGRTMpk/E9htH+VxVJojJOVs9F3Z3heJ+j4F0Zp3EndRYqxMb9Jwn75fenLn/faP7NbDvggdi/8azBHluM3KcJNYed+89ubQGRP0433mdW7Gk9bdGDUIzs+6EkovVsZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyntuax+HsAczX1HOzCjWMTBm10grFjSf0OgyUb1g2k=;
 b=e6uv/BCUxE8vEW9FB+tkibj8RuKb6eJ8loJ6KXi7m/SE72GW5TFgAlBEsXwOm3s+OQQCZiImGa8u8AjlnOZ3hfJIWY07cViEI4ZtNmuKJGfAYPbpmM36PzGD/K7L0Y64mxGjhvmd+Wng3pf15m0Fkd+g/YLxQUctpxMZO6Y8300=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 14:20:25 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:20:25 +0000
Message-ID: <032550fc-5680-4f6c-974c-fe96cc8083e1@amd.com>
Date: Fri, 28 Aug 2026 19:50:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-4-timur.kristof@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260828120729.25908-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0342.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CHBPR12MB790180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3dfb07-ca4a-4dc5-f2a7-08df050f8020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: at3lnVxwQW96skfvy4VLUB87wn56o3Cx66DJPycNYdCghqQXHlg/b4CsbxSfa78ZMIJjOEdvuIfImd136KZUV9Oar8u3athW6bnTrAqzGpCsLqx+B9CILzze6QOSCr0ToakbA+MYMPPIB6x2PtaoAYNKBTDpOu15vqg4osANouRNXha2I1/3/R3LIZl0Lcs7xxC8LUGUg9bfEXkmd/jGs0Nnav/YyMjrrpuOZGPzVmectYSM/Bq3/3MG+xDVENT6+Ft9NSJ/UFxOtcAPwn3sf98jCCjUhR6rQ/qWgpb8qsJ9ouq97SkJ4EfsxtIOMQ51xMyM7A4O6DreYKDS3av2fdT+j9U4f+Mn2rTE+o5EQgGvNkMbYRxfCGyeirBBRvzpWk93lusNWxzZnFMBp7V9sEfCxMMuR3wllv6pFskLxaA2wBWO85ch1AyDubgNQlYqNtq6REHSz3rTl2CkZDVeM/2MJVV2fKiqt7X0D1lmZgLpLXoqM/w5ORBvKlPbqUW7nem0tPNV9c/GJ9jDPTLQ+wYS3seY0YYf99F6XMpIAGf5qRGmdwMg2yiXGpvWcvwoAx4nUUnIjUM5+jiQ2dSqp8J83WCqFaaLnNLBx3zMdzqvBM85Bh8Il3vtsmn6PTKwwHZd/V3eNOOVeAHUkTPfo0nVAqARc4/mec1zQVBlDsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUMraDZ4RC9RbW44Y0hoYjJWeHNVN3prdVg1Y1BqM2x6VmRHNWJUanJVOVoz?=
 =?utf-8?B?UWFKTmo2MnRnbU9xM1BwSlpNTVowT2ZLMEtHM3hldzlmRUlKcDVITmp0Yjdl?=
 =?utf-8?B?TWFGcTlRaUI1Z01GdXJESSt1Q0dEZXhDVC9tWWpQRHlNOXZLTWR2SU5NSzVV?=
 =?utf-8?B?bmFzZ2VQeFFGSmNzd1JNcUNjMTZId1pjQlFHS29vdWlFa1dhY2JyM3VUQm9Z?=
 =?utf-8?B?ZGdydm8wNTlUdnFZZVJmSGxIeWtBNXNEb0VYVnZCeFhaMEZXY2I3L25teEtv?=
 =?utf-8?B?NmJKTVBSUlI1elp0cnJHYzdRak1yWEtPNUdJN1pYWE5DMFhFSWNZSmdJMVVn?=
 =?utf-8?B?WDRMRzNnb1REa3l0a3hLVnBqaFJadzhxejI4cGNLTXVvZGEvbklHZitOTFNG?=
 =?utf-8?B?U25nNThqYml4K2MyMHgzaDVuRFpRL1pRREtTd01zK2dsQ051ZDJuNnhOTGRI?=
 =?utf-8?B?OGxSS2xCS0hLWTZ0SmNtR0ROOG5NYVF4a2YzYkNRQ2dlZXJGbWJKM0FRdTdl?=
 =?utf-8?B?R0R2RS93MFVOZVY4V2puYitDM1VQbmpicGFzUGVMUDNYWnI1YTlyUWJGSDQr?=
 =?utf-8?B?bEEyTXNBR2JYOE4rYUxsam5lTDNCWGg0TGZEL2FXdDd2dHpxY3RxdlBBV2dB?=
 =?utf-8?B?SXA1eXNRRnA4eE1MRml1RzJRanZwaFhCL1Y1WFNyajBCMjMxa3dLZ0g0dzhE?=
 =?utf-8?B?TFh0NzA2a08xb2JDaThZdXB0UE1mTVIybmMweCtobnNWaXJnY09BVHBkTU9B?=
 =?utf-8?B?Wm9yZ2tVUU9YRGZjRFJSRlFCcnFWYk45cWs5OG1BMFM5bDRTYnlMaGtoV1Zu?=
 =?utf-8?B?dkRVMWpDY05EdDl0T2MvaEZwQXRjTDY5Yi9sbG8wSTQ0eEorcW0zYS9lWHl4?=
 =?utf-8?B?c2FpZ25JOHFxZFFRRTkvaHlWbGE0Qkd3SUhRWlF5VzJzWlN1bnVaY3dWQU1B?=
 =?utf-8?B?U1Bab1A1SGtKUFIvSWRRdm1pT0t1RGozY3h6Q0ViNTlYOFZHWTBscU52cmRa?=
 =?utf-8?B?ZWNLWldGdG1CZFJMQkJNeDZiZjFINTdVb3dqb08yQXRSaEFiQnk2RVlubVMv?=
 =?utf-8?B?TVJUaDl6a1FVQ3UzZzlQdllFZXprckFJeU82OG81alFTWmtkdG9GSEswNjZx?=
 =?utf-8?B?SVo5VE1YbjJFQTJheklqRk0rQlRqN1ROUnZpQmJIcFcyYnhGNHV5QWJDNXAv?=
 =?utf-8?B?ajJZaXhJSlFsNVptRFhhWnhMeXI0V3NscS9mN2dRZjA5cGUzRXlpUk1jNVFS?=
 =?utf-8?B?MzlpSnlSV1JPTkh4NHgxSGpwSTR3SStuNC9zTHg2cjk4Z0RMM1pNeHo5UHph?=
 =?utf-8?B?U2NaZUFkR2RKUUkyMmVpWVlmRFlJV2lNdG5HMXgxUUVsZGJSKzkvZnF2VlNz?=
 =?utf-8?B?aW0wcCtVa2lpcmVuME1MR216MVVoZjlrUHBiYUw2TkF3OFU4U1pyUkE3Szdu?=
 =?utf-8?B?TER1dmRBOFVBdWZLcFg4WDlYTytvS2NkUnN2RkVIUmpZejFjV3Z2c2FpcEor?=
 =?utf-8?B?RXRBcXhxeEJ3bGR3UWpaSVZCTTRHc2NUQk1qQ1VpYWZXUmZZM0NQa0VIYlYw?=
 =?utf-8?B?ZEdraUpGUnpCK1NrVHhzYjNhdFFEeVdUeDR3TjZPL3BSU2plNXlKOWxMS0xu?=
 =?utf-8?B?Wk5nWXF4bGlzQWRIRWZxTkttaUhxWUU0VDMzZlQ2ZHluWjR4c3lSb283dUVt?=
 =?utf-8?B?SDBrL3lzUGhYQWdvakpYU1ROSHFId2g5dnNNMk14NkczYzV1TWx2cURGYXRC?=
 =?utf-8?B?dzhZYXhlMnF2OXJEbUNwdy9EdFZEVUphYlBXKzVYdWFkaURjT3hoWXpkd1Zl?=
 =?utf-8?B?QjlDZXpvMUZpd1ZUaExzdXdmRWJyY0RCNGF2THpKZEVMSFRFbE9PT0dEV3lM?=
 =?utf-8?B?TkgvelhDWFVCclNLYk9Kay9VbDZBcm94RGRQc2E0RmJGRmxTczlyelhxclli?=
 =?utf-8?B?L3NOZzdEY0tBYkU4OUJBSnFCMEtGNXVNN0hYVHpsZktIdFNWNEx3eEhBQ2lI?=
 =?utf-8?B?N1MwQXAvcUdnQ201T0RPOGxXR2VESzVLTDVZTXNRYi95RTdiZGhqZ1Z1bmMv?=
 =?utf-8?B?ak5QYy9jeWYva3hsdzJsem5WUStLbjBSWC9YcnlLMk5sSkdEeCthMFgyQ0Vx?=
 =?utf-8?B?Ylk0V1IrNnAxZjE4ZEVURHc1UEREVmYvQlZyOUQ4Mzd4SG9FZTFJd0s1SnlT?=
 =?utf-8?B?YVF0RGtScjFjOGswa3EzcmxrdWJSaDk0Um5OdlpEdEJQV1htbkllS2dYUDBO?=
 =?utf-8?B?UURuNjFNTE1rVDRCbFlxNWtRT0FYYVZVNFRrL0tTWlJiWE9WQ1dDMnVESS85?=
 =?utf-8?Q?m7Y48LN/6d8mUEpgFK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3dfb07-ca4a-4dc5-f2a7-08df050f8020
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:20:24.6846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl9pykUTF7S/M6u908xtEfbxs+89VrvFp7V6GxGm8vQE0w2uSeZXskLhRCeL62Ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
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



On 28-Aug-26 5:37 PM, Timur Kristóf wrote:
> The code was exactly the same between SDMA v5.0 and v5.2
> furthermore the exact same implementation can be shared
> between all SDMA versions that don't use MES.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 37 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  4 +++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 25 +---------------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 25 +---------------
>   4 files changed, 43 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 66f278f77f71..9eebd8380834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -635,3 +635,40 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>   
>   	return ret;
>   }
> +
> +/**
> + * amdgpu_sdma_reset_queue_legacy() - Reset legacy SDMA queue after timeout (without MES)
> + *
> + * @ring: Pointer to the ring of the SDMA queue
> + * @vmid: VMID of the timed out job
> + * @timedout_fence: Fence of the timed out job
> + *
> + * Common implementation for resetting SDMA queues without MES (legacy).
> + * This relies on the proper amdgpu_sdma_funcs to be set up
> + * for the given ring.
> + *
> + * Applicable to SDMA versions that don't rely on the MES yet,
> + * that is all versions up to SDMA v5.x and older.
> + */
> +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> +				   unsigned int vmid,
> +				   struct amdgpu_fence *timedout_fence)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int r;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
> +	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> +
> +	amdgpu_amdkfd_suspend(adev, true);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
> +	amdgpu_amdkfd_resume(adev, true);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> +}

Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2 
is better. This may not work in the same way for all legacy queues.

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 4f4e56022c97..7c4e145ca0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -160,6 +160,10 @@ struct amdgpu_buffer_funcs {
>   int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
>   			     bool caller_handles_kernel_queues);
>   
> +int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
> +				   unsigned int vmid,
> +				   struct amdgpu_fence *timedout_fence);
> +
>   #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>   #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 0da54c335822..76f8765fb175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1518,29 +1518,6 @@ static int sdma_v5_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> -				 unsigned int vmid,
> -				 struct amdgpu_fence *timedout_fence)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	int r;
> -
> -	if (ring->me >= adev->sdma.num_instances) {
> -		dev_err(adev->dev, "sdma instance not found\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> -
> -	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
> -	amdgpu_amdkfd_resume(adev, true);
> -	if (r)
> -		return r;
> -
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> -}
> -
>   static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
>   {
>   	u32 f32_cntl, freeze, cntl, stat1_reg;
> @@ -1936,7 +1913,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>   	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
>   	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
>   	.preempt_ib = sdma_v5_0_ring_preempt_ib,
> -	.reset = sdma_v5_0_reset_queue,
> +	.reset = amdgpu_sdma_reset_queue_legacy,
>   };
>   
>   static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 5543e381dcca..e7f4b74f27b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1436,29 +1436,6 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return -ETIMEDOUT;
>   }
>   
> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> -				 unsigned int vmid,
> -				 struct amdgpu_fence *timedout_fence)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	int r;
> -
> -	if (ring->me >= adev->sdma.num_instances) {
> -		dev_err(adev->dev, "sdma instance not found\n");
> -		return -EINVAL;
> -	}
> -
> -	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> -
> -	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
> -	amdgpu_amdkfd_resume(adev, true);
> -	if (r)
> -		return r;
> -
> -	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> -}
> -
>   static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
>   {
>   	u32 f32_cntl, freeze, cntl, stat1_reg;
> @@ -1951,7 +1928,7 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>   	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
>   	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
>   	.preempt_ib = sdma_v5_2_ring_preempt_ib,
> -	.reset = sdma_v5_2_reset_queue,
> +	.reset = amdgpu_sdma_reset_queue_legacy,
>   };
>   
>   static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)

