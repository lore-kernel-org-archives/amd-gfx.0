Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6982FCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 09:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0346410E1B9;
	Tue,  2 Sep 2025 09:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loYQnRfh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B39710E1B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 09:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNJISy3M/3as82SZSlrnV5w6u9rn4TKcwFPk0gkg9kF0PSC2dx1qLYAxhapmYtAmnvxxOQSn6ctLwRrgYIlXsz6g4PpXQvlylLM10dahuYkE7BvRmElYBAFuU4WK6IRMQUxrhqK9J4S9h3kVBeSemP5/E9vzf4Jn1GlbP4JdColhTdyzs9Jw6WP4qmX8TRl281kUcLjqLckICuXR2q7UzOsohbPAtGeqP/bfJtbjvVlholGbStQo6COa0tsKtJ80UGS3GHObUYt69rCe4KkmdtdVNA+3YTkZones6x7fBTNvo63KBdHsa3AwAkqwzIteimhtjfWu4ryT9elxmcRCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zjVyUwbyAJgZHwtza5EyCeolLSq7a9TeoYHMhlnJas=;
 b=OGYYqxNAN6tEzQhc0dt1vuJ3YsazGzL3+u7yRoJXgdzgrWP+3F/fhWpQXOshTxt3m+FXmPVbg55TWlBN5FcYF9tsTblRG9q8mm1tbLcJVyny82G8JO3zLGn1XeyFEpU8qdVEcK7A9lGd3K2m4hr17t4KZKac0gdX0dKwQUz8M/KYXdIevm+02FTHdGh1Sezxl/el4Xm8bnL0FKOnM0ZON2dgxQliKZi6KKKs/Yu6Ry1caWyAfX+aMUuSZkb2nNe9e5hNMvc+uw4JzaisUjDZplT8Bn+vdLI60Ye4h/3BleujSC9XGJECWNnjSSdLw/1lzIpILLgREZ+N23U3+Ls+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zjVyUwbyAJgZHwtza5EyCeolLSq7a9TeoYHMhlnJas=;
 b=loYQnRfhMchmV++6JscAsaPgKm3+vg/93LpNEunq49BeFO4pVtEV4OQizMjeJAPFtgKqWrOjpfwJbkf5PfCwbmyoe+AGlo2zPh815ULXTJWo/SLOUeKya72cHZ4tXGn/9hgq0P3fZbBnfUVyUbtRq72vTNzMIV368uJrYjqaJak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 09:00:03 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 09:00:03 +0000
Message-ID: <47155fc1-b7d9-49c4-8fe1-a2181edeaa79@amd.com>
Date: Tue, 2 Sep 2025 14:29:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: remove check for BO reservation add
 assert instead
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <20250828150200.4035-2-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250828150200.4035-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 95712b25-cc22-439f-6823-08dde9ff1adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1Z2ZmRFdWV1aGZUN1ZHdmJCOVBZK2dZK0tCWEg1d0tKZndiR2tSUTdQSnhN?=
 =?utf-8?B?eHpidFk1cDBwZ3BZSm9Qd0ZNZU1oS0ovNU1hdE4vMWhHd3BlcFpWRlhVWVpu?=
 =?utf-8?B?c1pJWkJzNjk3L3YrRzVSMmlvTGlWaGV0bVc0bHJmZ2pmeU56QkNTSXZ3WW9j?=
 =?utf-8?B?VUtESEp4by9WN2xKd0ZmK3VZYjJtd2NPU2JtQTNKaXd6cm5CZ25YNVM3RjVp?=
 =?utf-8?B?V2FRRSs2amM1d2ZOY3pJMitpeThTanp1NnFNamVqWENJWmZuOXc4WTd6QkJ3?=
 =?utf-8?B?eDBZMFRiZW55N0grejdmMmU5OHF0SU43NWxyUlZIZDlGMEo1bHFEOW8rZHlP?=
 =?utf-8?B?Z2MvVDFUd0YxRHBabEVsYUs2LzNycU1QZURIRVRLVlYva0IwR0FiRGQrazR6?=
 =?utf-8?B?U2U5UTJucU14a2hiaDVnVUxiZzJGY1Z1L3FqVUNLTGE2akw0UlpqMlp4bVJ3?=
 =?utf-8?B?YTFKYlJseE41RXNleDdCTks5OEZjYUFTWmExdDBPOE5QNlBtSCtOWDZxUjlC?=
 =?utf-8?B?LzhaSXJIUUtkYk9RU2k5d3RyVHFrQzI3a01rbTFnRHROUkp2VjY0MFpVVUlQ?=
 =?utf-8?B?WFk3MDMvQU5RQjNhQm10UWpEaWRid2JkS0o3WG81bVVycWZHV3A5dGxONnQv?=
 =?utf-8?B?ajF4UjMvdSs4bGhCZjFIc1FQdDM3TjJOTUlMWnZzRXExeUFQVUQ1WmNQQkpp?=
 =?utf-8?B?d1VsMFFuQVRlOHhaZGZqSm9OZXlpT0t0WHhzQXFpdEJpNnREdnN6dnhkRzY2?=
 =?utf-8?B?SXQvdG5Tazk2VlZ2RnNXSlpPTk9naVc4cHRhSW5ZTzhIa3l6UFQyTHlKUjRN?=
 =?utf-8?B?MVdtMzdBc2pVUlFzeTl0TnBSL1NyNmtlR2RzTy82OXdBK1NoUkxmQ0Q0T2Vz?=
 =?utf-8?B?a1hXRXNnbjBwdVVUQ2sxZndiOW5STU84R1l1R24zQlllQWxlcW1haGZDRTFJ?=
 =?utf-8?B?Vkx1NjhVMUIybUZZOEcxT2kycXA5eU04dXhoS3dzZGF4T05iWEFUaGFwakR3?=
 =?utf-8?B?b0RBN0VZc0hHbm10ald5b2pHQTFFMEtFWGh1M1N3VG8veWZYVE9Bbkk5Vzlj?=
 =?utf-8?B?d3E1TjNQajl6WGxEbWRJMEYyeE1PblR3K2M2OTlVdHA3cTM4TzNXb3NLTUVG?=
 =?utf-8?B?R01xUXk5anJGcEVDZkJ2cmJuWXVveVRaKzM0RkFzckdBN3BxWGNsOE1QcmtD?=
 =?utf-8?B?Qi84ZW9rZGxuVm5nWWhuYm1KMHIyQmlWYmo3Y3NMTEZsWi92ZmZZYVkyLzB2?=
 =?utf-8?B?RVR6a0lIRXdxLzFHb0hDZTIzOUE4d3NlNDFMQmU4MkIrWHVBajdONk02TUtl?=
 =?utf-8?B?L25OWlFUZWJrY3ZLMWU5bmM1NDFpYmRvUGx0MTl0SHJtQkozZWgxNUJtSTEz?=
 =?utf-8?B?Y0dUUEh2eUNsdHpaeFhyWVpGZ0ZPVjlUK25RZlBWRmdDb0ZIUXNnRHlpeE1j?=
 =?utf-8?B?cTJXOS9SbksydTE3WTJadnBOQWxRbDlQWDg1Q01xbnZjMUsrajl1dDh3QmRk?=
 =?utf-8?B?dENnc21yeUJxcUY5THErRDJOT1c5LzlmK2F0Y004eGlXWWZkK0J0V2EwSk9T?=
 =?utf-8?B?L2lrSFdqWnIxR1U3WkgxQWhUMmovbTJTRmtqSm01NXpER2NmSVNGUCtnMTZO?=
 =?utf-8?B?bTdkUWNJR281cyt0MXlLMVZGcktjRzdZTjMxNWRhREc3eHoraXBSdzBKUVpQ?=
 =?utf-8?B?QjNvK2FBQWJJU1dnSUt5ZWtrdWtYM25aMGFjbnlDSVY4cXIrT3UvU2d1NlBw?=
 =?utf-8?B?L0kyTHllNDlVejBQdFEzR3FTRzFTaEZUSEZ1SWVWUFdRZzkwVHJZdXBEYWVU?=
 =?utf-8?B?b0NvcytvbEFwaVpIdWYxR3llSkJhUHlQUEdGdkJtL1RHMkVCWkRVZnhxM0FG?=
 =?utf-8?B?V1dlcTdEVzY0WEp1cWU4aHZIaGkrK1NHS0dnK1NMT01RaUQ1RElrSUp4OXVu?=
 =?utf-8?Q?TOdrVKD1ZSk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXYyQlFkeEprdW9qZFplZmtIT2JSQzhibkppZE53VjlZR1d6QVIxTVZkUlVp?=
 =?utf-8?B?cVdvRmJya29FTHh5ekpXdmVPY1I1Y3VSeXJ0MTVWWUNjaTY5eUFUemRQa2l4?=
 =?utf-8?B?OG9vdDdzOThucXM2YlJjeHZ5VGtTWlFtZHR2dXZFT1dlWXVQMG5iYktzVFkx?=
 =?utf-8?B?azh4Q0Z4VGtvdVMwMURENm41QjhxUHM3VXovNFZGZGptSzd6TXRGNUkxUDlG?=
 =?utf-8?B?dG1QUDVLeWRlelpKZkFUMzVnUnpldi8rY2swQXNWNWNMdWs2QWV4R3ZwY1lL?=
 =?utf-8?B?WHpTU0hzWDdtRFRWcFgvKzJtMTlvMytVLzhiaDBiS1F2NU8zTzg4MU9EK3Fu?=
 =?utf-8?B?VDNzcVNYd3dIUVAySDZBaTAwZlRzdk9xSTNtMExlNGx5QndYOGdNNi9uNFpY?=
 =?utf-8?B?Vlh6cEdTYzdCckh6V2k3MGg5YVdOczA3MWFabCtTbDh4NnRMR3hJMEU2Nkpa?=
 =?utf-8?B?T2sxaWIrZjJPdnBienFrNHNRZ0s5T0lZcm5RdEdERFh1Q3RidmJEN281b2NH?=
 =?utf-8?B?cHA2LzJvK3lxY0djcmpkanh5TTY3WUxaZkp0ajZKdFdhWHRTR0I5ck1kNUo2?=
 =?utf-8?B?aXpmVXZJODcyNFhzV1BPa3lqOTBsV3lRcDhmNXNWeGptN1BGL1JCUkFIQ0Ru?=
 =?utf-8?B?Wm1lN3BNT1BFSERid0lZZHQwVVMzT3hub1NOQUp6Ull5akpYV3NOWWlBS1o1?=
 =?utf-8?B?QkhsOGdGMlVpdmNTMURHZ2F1OHlQa3dJbkNWQ0VLbDlDd3JPL1pReTBIODJn?=
 =?utf-8?B?UVFFNkZJV21IUERlbFI0ZFNyMDdlNGdoelFnbDBKNUVGYmFYWmZtSGtDb3hQ?=
 =?utf-8?B?c3VmYmkzalFscElsQXNyZGh4TUF5NnZUZDc1VlBSRGJEZm16QzN2d0E5Sm9I?=
 =?utf-8?B?WS9maThPcmZhMjZ4OGliZDF0MTIzbW1FYVFQL1FHWGpJR0U1bjI1bENMOUJ3?=
 =?utf-8?B?NDE3c2YzcFRveXpNOThjWjVvYUJBYWdsaWRaMzIrVjVhRXNNc2RIM3N6MTh0?=
 =?utf-8?B?Z1JZV2tGcFUyWDFWWThlTXB4VnlXZXVqWC84MXpBQ2MvQnJ1bEI5ZnBNNGdG?=
 =?utf-8?B?azJIcXM0ZFhCY3BkNVpsblBLa3I3dUw5ejJlRGZxNG9yQjljU0J6K1orNVB2?=
 =?utf-8?B?ek43N1VlZCtCRHZEb0lLWjUrOUxmUkFDZjhsUld5MDVXbldCek5XbXFtTHlm?=
 =?utf-8?B?bGlDYlU3N1FjeWt6Q3phUkYrdkI0UmJVYmhZdHZtRDdqYXFvTEt5WXNiZkp1?=
 =?utf-8?B?S1FlVEVZM1hpV0dMRy9mQmRxNENiS1A4QVkwaEJmTmErK0hidlpjWk1xRUdL?=
 =?utf-8?B?M0ZueEh3S2U4RGRkZVhDdHdrMmpoazc2UEJIN1dKN0tzSHpTWU1CRVp3OXpq?=
 =?utf-8?B?N2NGajJKNEE5VEk3NXh3QTFRanBwd2dqdDRodVRmU1ZRUmpKVHBVRGc5dUQv?=
 =?utf-8?B?dExIQWZmUTdwd3RoUVBSQ0tQUmhURURxVVFKb3ZnY0oxRkVTb041YVFtWjFa?=
 =?utf-8?B?bk0vVGVvZDVlUU0wMU8zL2pnbmhHOHFHbnk4QmNmeUFOckMyZ0NnNVN4c09R?=
 =?utf-8?B?cXFjQ3BPZ1dGVlNtYnJqOGJHaXg3eXhkUzZkbG5seVhMUzR4RGRtVlRrMUhu?=
 =?utf-8?B?d2xCdFZWakJ4aU9QWDVrQ0t2aURybnRRSFRTWEtidGFMeXJXNXJKZ09QaUFx?=
 =?utf-8?B?Y29jODZSdnMxU0JLRlBNVTVNNll3UFZ4OGNOTXdhVGpjcDE3MTFaNWpocnNV?=
 =?utf-8?B?VDNnQ3J1aFNYUmw5eG1vcjdyQmQwcGc1bzl1eEd0QWlIN3hFY0JwRG5wSzYy?=
 =?utf-8?B?VEsrYVNTKy9jcE5pd2VOWHdJeUdzZGVHWG5sYUhPSDRXYkhQMWg4TnMzNTYr?=
 =?utf-8?B?bU02Y0FMSEdFU0dTWHpWOHljaWFmYnZSUG5jM0R1MnQxTVU0TTdKM1grT0FJ?=
 =?utf-8?B?TmRVRVNNN1lFc3gyNVV6R2EwNUhyU0FxQnN6UTU0elE4SUZHSTkvNXN2ZHZQ?=
 =?utf-8?B?Um5Ramx2OFRxNEF6Wm9EaWFkanptMmRkaGxxZEkyM0lBQWd4eFZxMFR5dC9N?=
 =?utf-8?B?amFKNEFkNS94R2xPa1UydUhnWnJiNmRqYzJIZHVCcmdmUEZoQW9qakxqcjJG?=
 =?utf-8?Q?7fjBEGQ85kf4ESzv66NKhJ9Y6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95712b25-cc22-439f-6823-08dde9ff1adf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:00:03.6757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG5uDm+Kx2MBIeiWuu1J2eOgKrbUraSGJTmR6mDjt0qbsBSRJ+5TKqo1Yf1DQ50SWcfzbnB1wdqLTVxV5+vghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
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

LGTM but some else should check.
Acked-by: Sunil Khatri <sunil.khatri@amd.com>

On 8/28/2025 8:31 PM, Christian König wrote:
> We should leave such checks to lockdep and not implement something
> manually.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 16451c9bbe1f..a0339187eccd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -651,18 +651,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		spin_unlock(&vm->status_lock);
>   
>   		bo = bo_base->bo;
> -
> -		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket) {
> -			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
> -
> -			pr_warn_ratelimited("Evicted user BO is not reserved\n");
> -			if (ti) {
> -				pr_warn_ratelimited("pid %d\n", ti->pid);
> -				amdgpu_vm_put_task_info(ti);
> -			}
> -
> -			return -EINVAL;
> -		}
> +		dma_resv_assert_held(bo->tbo.base.resv);
>   
>   		r = validate(param, bo);
>   		if (r)
