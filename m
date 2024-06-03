Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C5C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 195D410E25B;
	Mon,  3 Jun 2024 07:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tt50w6uE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7D010E25B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 07:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZmXCdkPvMLnhRNfWspGdpBOMsvKcliYWAEc/RlYalS80Fovtwetx0UiOYJ71B01czfTKZ8lbxmtBncMaDIvCnyJClGIgzEApSpjej1lx1A5lCe9QyXirklmIxootov3dVCSOjFQR5OzXBtN77obPHHyfQ5pT8MF9BPzcrXdXo1B6GhPCoAZWMKiBcsEIe5Nmi/ugDDG9uWCUtpdTwrgyNxsWwWiKDc4HI/Cydbc8S1SPtol6ExfHoV+xoDi/7gW5LYTeNxPkrYvVbX7tE1YlADvKor4dvb791qLMDPXs4NGI1P6KG29313H6yJ4ItVsm50IHglBtFyVoPImssdKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU3EQLYZi0N5e4GDH7fQMJIbwonDUHsh6hLUakk86VA=;
 b=L45FbWZGZzauy8fdR+/3gSkgLv0CSmoVHFfWIAUsXzkmTOiaK3OcLveMDjdS5hlYSKO3vMFpTjtwyfVU0g57LOmi++RCxRraQfMddqmJfN/g/nH4TZx5tGoqSvdLtRJ2oKzDwCa0+fdsBm0RjBJQtD6KakYJZmbhDEMgFsqJpp1W/OzgWnCQwikEx5VoG+lEyD/Mkc42wx7hsZzZ/wWO6y+/v5IS+9gAqRvO8SEMqE8u4E+9l8WtN81MVxF/b0zbpyrHAM1hwxrU+cf4Ny7rLomNwO8PmMJm/sbPTKB4F2KzltEiRGCeYyQuUJW4WqshcsSfQy0TWJ1o/r/sC+b9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU3EQLYZi0N5e4GDH7fQMJIbwonDUHsh6hLUakk86VA=;
 b=Tt50w6uEKGlmCtZtagwMbOmforTOHWVs42skWNCRMQZ9KiKz3SzS8OekFuwBtt4V1ZK74QjdWG2/tfW2ojnjF1o2q1hBoayEiE3V6Yq+/w0siTH3EpRHPZeknyutgN9TKUOl5lW0ockrvKgl7zFHX33PPM9o4fRlU0UAW0iZZmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.35; Mon, 3 Jun
 2024 07:18:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 07:18:44 +0000
Message-ID: <01c7f7f3-8d86-4495-8892-cc578d1a3235@amd.com>
Date: Mon, 3 Jun 2024 09:18:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip coredump during resets for debug
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, sukhatri@amd.com
References: <20240531123403.978597-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240531123403.978597-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: b1cade1d-2146-4bff-3495-08dc839d6749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnVLVUhkMllrREx6bldpbUtTbEd1cm5kWnR1QVhkdVY4bTRMclUvSGYycS9r?=
 =?utf-8?B?YS9rbkFHdC9tRXVENGUrSzhrbmRUUWo2cUczMG8yd0ZCcmVNRHVOVTFnL3gz?=
 =?utf-8?B?d3NHdkxjSHhNdVpFdjgzVzBkK2dsUHpDWnp3VlQwY2tIM2JUSm05VklVdU40?=
 =?utf-8?B?RkFCeHF1QzlJR2Z1Ti9sTHJQWXh2YndyL3RzZmxKb2lmNWVDTzdFYjJGVHJh?=
 =?utf-8?B?cmN3MW4wZHV0enV4dTRRWGo3MUxXTjB0cGo1QTc4T0lZUmFyWklXcGt5VWp3?=
 =?utf-8?B?dDY4bEw4bHNhVERhNDhHZiszTGROditFSWJ3MGprKzU2R0dFZXNJRmg0NFJE?=
 =?utf-8?B?b0JLcWhWbmg2QUVSajZMS21qNnloSitZUEZzaUlvMFVQajMxcFA0eDI0ZzRz?=
 =?utf-8?B?N0kzZnBCeWkxUWZvYVMxTDVYb2NsWEhLWUMxNUhnSTBYQVBtY3JQK1k3cllF?=
 =?utf-8?B?SGw4R2tZL2pDdGEremQweVdneHowVXVCTTZOTncvemFJQnBDRnVEb202VkMy?=
 =?utf-8?B?RCtmL0lmTTNGQW9Za0ZVeklLelUyMHJ0UHJNbFM0dEt1NzBWWEJldnhJdzVp?=
 =?utf-8?B?c1NneGFKRGFIc3I0QytreTRUeWdReHNXRmpTLzdpeUV0LzFRT3Y4Z1JOYXhB?=
 =?utf-8?B?OHNHTGgvTENzWFg4OW5sejB1TzBSRk9jaVdKdVFZSklyVWZaREtGdXU4YmZr?=
 =?utf-8?B?bXFzaVRJY1hMeGlZTWRRZDArRnBnZlNsWjNwaWRLczZWZHJWTHV6QTF0dlc4?=
 =?utf-8?B?NmcrMDFjQ0NOYnVUdWJxYlcwWjVpOGdiQkpqRjU5NVBWM0R0SjdyWmRhaGpR?=
 =?utf-8?B?cWJ0VjVhek9YL2ZjV0c5N2ppSkE3bDZOVjVWTE52V3E5WUNTZDFJSWFDbWxi?=
 =?utf-8?B?QnpjQjVha0thQkpFOXFxRjIvRHZUR1pKbm5PQ1ZEQmZlam53ZGkvdi9wTnNU?=
 =?utf-8?B?aXoxeXFucnAzZ0hKc1FRS044dzhxWkUraENsZ0hDNXFkQkNiTnRBRml0OEpI?=
 =?utf-8?B?VHZ1dE9xTlVCVFpDZnI4T01Db1FsMWZFb0lCdmVDMGhWYmJmL2ZVWklLZitx?=
 =?utf-8?B?MEVXQTdnTWRMWFZaSG5iVkszcWZNY25Fak15MnExY2NnZ3BEc0xNUTJIZFJm?=
 =?utf-8?B?NEJDV3NadzlaOVUrUjFxZXRseGZmSWdjK1NVMEFRNEY0dUVLSS9ZQkNCNGtP?=
 =?utf-8?B?RytpQnlPUGZ4NW5jd3l1eC9yRURXOWF0QzhrM1ZiWUllWHlCc0FadE9tazM4?=
 =?utf-8?B?OTVyRWhNbHo3ditrKy9vZDRtUUlNYldxYnlvZVNzZHdycWVNRmNuODdpZ2ZT?=
 =?utf-8?B?eHJhWlQxQVQ5UDBvZjcwYmJjZUJ5MWMvbU8yWUxIekxXdDdLazRNcE9NbmUv?=
 =?utf-8?B?Yi9hSnJUV3Q1NVBrTjMyMnd4cUZXSnF0WkJqZ1p1c0ZCSzV4Szg4S2pIenFl?=
 =?utf-8?B?c29jTXhHVUNwNUd4T1hENTFzQ3dHSkdnY25CYldKdHVuODJ0ZW1WWXFPb3Fx?=
 =?utf-8?B?SGdZcDVtTTc5VmQxSkVMcEJ6bjJ6Y1dsT2VMSUhZZnFDRlA4eStKNEFyQ0Nz?=
 =?utf-8?B?YncrbDZORXRrTnM0ZklGemtCTThrUGNCMVNGc0pkZmVzUUVxMTF5WXUvdlJz?=
 =?utf-8?B?c3lmd2NzYUJMek13QzhlcTVyZGNaUENaUUR4SlFWMFlMLy81dFp2TWc2Ty9H?=
 =?utf-8?B?d1BuY3gvdXpBaldwQ21ZQ0tDU1JhVFVUZHFHZThhcktOakl1QXozYUlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUlqQUR5bFh6d3Y3N1h4ZnA0Tmo1SUNIcFlVMXpvU2FqN3dueGw0WHF1QVRx?=
 =?utf-8?B?Tmpxemw1M09oUGNQb2JvcmlSd29BWFgzZkxsRVZYbXJXSGpzMlNlTzQwU1hm?=
 =?utf-8?B?OGpJQVFhb25QbDBjR1JJMkt1akQ4UGdoOU9JS0h6RVFWZTE5aE9oN1FTWm1q?=
 =?utf-8?B?STBIaUV4MDNTd3pVT3BFTmFVQ09VSHZnOFBXN2JKWFNPUDhtRXVYMVEvUjcw?=
 =?utf-8?B?bS9GeFUxRXR0RDEwMGlpWUkxekU1WGNqRHExWkJwcGdBL2JFZW5oZlZpWHg0?=
 =?utf-8?B?QzNnN1BxTG4zdUd6RWJTZlg0OGMwUG05Qk9tT1VKdnBVWXpxd3A2Ly9wZFhi?=
 =?utf-8?B?K2x0ZHlSVDRlR1kvNHUzRGFCRUxkZm11eWoyc3VqUGxIU3RwVUxtVDZ1QlhG?=
 =?utf-8?B?UzAyTkRNMzU0eldTMUVSSHR2TThaM0l3bXprK1ZmMTByV1RZcGJtbXlXSk1Q?=
 =?utf-8?B?ZEl3V2k5OFhyZTVLUDRLamFpS0hqUHlGWVhpMnBpV3VENDU1K3JQQTliVE56?=
 =?utf-8?B?T0hkNGVvRXJ3NHBKVElCMXNnZDR6azdBMW5GWHJadDhqUWdQbUMyQjYvNzVB?=
 =?utf-8?B?eEpOSSt3LzV3QmxuMkxoZmNWemNNWTJETXB1b2hGOHZnMnIwRnNXY0F6OW1D?=
 =?utf-8?B?K1JySmFjRDcrQlZaQkFMWTJCWkZWc0xTTExBcUZlalNlcTA2WnpyZk1CWXVm?=
 =?utf-8?B?YUtFcDVZcHk5V0NmbU1vMVMyc1pLOXBFOUxiYnlpcmFRcTVCTFA5dmM1ckdN?=
 =?utf-8?B?NXF1NzA5Rjd5QUtES2pYcm5ub2hrNitqRlJkUjQwRGdSWTVDeTY1bFYyaWNw?=
 =?utf-8?B?bnQzWFF5UDlWbkI0SDE0bk5EMWZXYkxrSnliMFdveEtmdVFGREV2dVNXUHZn?=
 =?utf-8?B?eUhmYnVYMGw2VjhjU3dZZkFxcUFuQk9uWFpkTTVDN1JVWnp6cS9BdUFhQVBa?=
 =?utf-8?B?WGRYWFhUS0V6N2lNdE02MlZ2R2Y3T1I1eHFlVVpRbGpHZnZzV3FrRkxTbXBV?=
 =?utf-8?B?V0swUkwwYU1XMGorK3NpbnYzTjdSeUtTeU40UjVKaFIxQjNWYWVxZHZHR08x?=
 =?utf-8?B?RnQ1c0RzU1A0QnJHQ1AvL21LbEtKcWZWUlk3Sk5DN0lxMHhaS3FNb2N0Rk9M?=
 =?utf-8?B?S3JNcDFqYXc4cWlZdUVPWGc4UVowQU9xNy9KWFhhNDUxbDVJVVgvWE5iNXNO?=
 =?utf-8?B?bCs1Mkw3aGsrS0Z1cWwwcVgrOFc0aG9ENmNiQmt3OFhqSFdRekpMWmhwR0pz?=
 =?utf-8?B?YzNJNTBaUEtXNnJkcDhHbnh1YTRzNVhoWVNHUmhacmFyOFFZYU1BVDA4T3hD?=
 =?utf-8?B?UTdoVVVZZHhyWEhaVGVxR05NVXdkQ0RPR2ZaU0J4M0ZvbDZZcUxsRkVEWWdk?=
 =?utf-8?B?anNQRDFPb0ZkVEU2LzFEN0I5dzEvSmtiTXBtNVppRUI4ZGVUbGVWekRORU1R?=
 =?utf-8?B?YWJxUU5SSjMxNkhsOWkzUTZNN3ZtZ3N2aHplOHhlQkNZUG8wbWZRZ3JDMC9t?=
 =?utf-8?B?TjRaVHR1SG9xVDFhLzJURnBPbE1qbmhaWmZJSTA0RngxNEQ5MUZIUmJKSmlv?=
 =?utf-8?B?RlN2c1RlMzEvVGtNYnVnMXp0MlZ2TUJBeFJINTdLUFFkZ2VXMUJPZTZwQ2Ft?=
 =?utf-8?B?OEkrTjRoQmw5TFpLSlVSUjZvU01KZjROdTFyVXI0TUVwdENCcXVBNTF2aDZN?=
 =?utf-8?B?UWJra3hVWmgva0IzbW9TWk1oQzBXTVJmUExDUytLQ1ZwRDFpWDNwOTlsZmhZ?=
 =?utf-8?B?VnpsdytWLzFHMTlwTTc2TS9xQWsrUElSOVR3Qk1NWjl1bUdHNStIbGNHN2Uw?=
 =?utf-8?B?UDF0NW5FaUpWTVgrSU9PbWdSSVRFakRiRHV0d0taVXQ1SDdpcUoxeUJCdzRD?=
 =?utf-8?B?NHRrS0Zrd1lBY0tlSFpmSlZqdDN1SFNKR3Z2Uk9lamM4U3o1L2hjaThKK2lx?=
 =?utf-8?B?T3pJbDU5SndkOW5yYVFIRHVCSS9lM0FCNUtFaFBaTVl3YVdRV0l5alNGRkRa?=
 =?utf-8?B?N3RENUZXVXdpNExneVVoeFBqemNDZWMzOG40WW1xbzlOWEhPWU90QnNlRWpZ?=
 =?utf-8?B?ajg5cWxGZWlJY2ZGZFhIUHcrekk4SE9wSWdZQ091OGNGNWtMWTZ2K1JNSUpE?=
 =?utf-8?Q?DfS8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cade1d-2146-4bff-3495-08dc839d6749
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:18:44.8358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbthRqrA4vRu2zZ/y+OIwykAFYAM+JS1WwGR7/hEuGZuKRYDMJP5IOiKW7QkNv09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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

Am 31.05.24 um 14:34 schrieb Lijo Lazar:
> Skip scheduling coredump when gpu reset is intentionally triggered
> through debugfs.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 10832b470448..1a9fda1d20fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -981,6 +981,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   	reset_context.method = AMD_RESET_METHOD_NONE;
>   	reset_context.reset_req_dev = adev;
>   	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>   
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>   }

