Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45589E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 15:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F0910E1AC;
	Mon,  6 Jan 2025 15:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0fiLjR79";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A930410E6AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 15:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDR2wodB8BnjZF9t9uXcDdVPQVV7W8kEAFzCh64/0QnI0Okmz0ab2N3H7VbeDlWn6C9IxcvwfeXgDChKuLKikU/Ez74HIckdilJ7TuF1UTkUaNXy90QTMOnJO2av/JRKO+di0eOXP/Oaj73NIC+Dtzj7q7RWuHEu0hbgpDLHirolmzJgC9w9yYN+ZHAbxNEGrsTc7DmHdFE7u3taRSAsMIHbj5x593rSv9O9/47IevXxakN/1Z0DgTu1M6j8vVTAn2ZwfljcpfCJBEvq4CsiPVHPLDAtF69BhCe96DWODFWGDug0ltM3hvXocwNvvzZP8uv/dy2oCMVWUEnQv4pPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPIFLKimxXwRDjJALWWVAcdurXC57W+sRzpvDJfS+2I=;
 b=vHG7yTOzSlCuaDLffEeRI2wAqFVwbFMTtUk/o0SOiCSoT9aOTqrdfVyK6klPRpujADWjINqNg3W2X+ycY+kZ/KrmI9rPRB/RAAH1dCOhbOTlDfDowTsfEqUeFmMOPD0Ul0Bitgzy8hyBy8qKHboBZrecHAj9IotpPHsy+RxNQ9hOCzSLu18z+NmF9XT4G91m8j0dJVp+m9EhiEkr8kaKBJm+Jmw5y6BeKFI/MUk9xhdZdFtDK/OfHDhRv79m19rmOjRTq0r1Jn3HiY9MF65qdCoj/OhntQ1EBalMLJJ9u08Gjc8oCXHtyLV4omlM0JA5i7pL/F8vdpX73TPSABngHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPIFLKimxXwRDjJALWWVAcdurXC57W+sRzpvDJfS+2I=;
 b=0fiLjR79TmL3r4S4yEr8e8aWVqddnmIPaJej1ezIMGPF/ud/3/0dmEa7kasfHCF4F8/+LUYDDevXqmTdP7kkUIzHJT+iVjvDqpVamRaMrK0BKb5YYbvgh/fc/JW57U2e2Koc0iMoUyGUcdBQ3TW4HVf8qnVrT5Y4d8f5Acmvd5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 15:27:01 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.013; Mon, 6 Jan 2025
 15:27:01 +0000
Content-Type: multipart/alternative;
 boundary="------------Jbm6dgApqAm5RpIqeyLSN49D"
Message-ID: <40e6b31e-c77b-4d89-a051-215eb4ddff46@amd.com>
Date: Mon, 6 Jan 2025 09:26:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250103000644.1398643-1-Emily.Deng@amd.com>
X-ClientProxiedBy: SA0PR11CA0106.namprd11.prod.outlook.com
 (2603:10b6:806:d1::21) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a319067-74ae-4695-1a18-08dd2e669116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFFFVFBIcDZHM1ZSVFpVbFFvNGsyWTdFQW9mTzZBN01pN0F3OTlMSU1BVzdL?=
 =?utf-8?B?QWtNZnpwajR4YURBSmxVekRZYlVyM0Ewb1FYdGFtb0FLbGMxVVRqQXcxbFRI?=
 =?utf-8?B?V2xiV1NMaW5ldCtmcmFrRnE2OHhLSmZ6V01LaHJobUJOa3dDV0UrclIwWjRH?=
 =?utf-8?B?TXo4ZENpa0dxa1ZWRG5QN3l3WHBybk5XK2pTTlFIUVM1RHNaZTM1RmJoY0tV?=
 =?utf-8?B?anN1V2lsVHpDM203QUxsVEYrOTFjQUJuWVd6MEJZZVVyTU4zMzYzYzdzS0dN?=
 =?utf-8?B?dlZuZmNWTjdHcFdRWUxXYjZjUkR1ZFlLMW00blhBNnRqd1VwQ1VBNDcwS1Mz?=
 =?utf-8?B?NkpiNktQcmhlME5Jelh6cGR2WUlxZGVLYkNwbzJ0d2RlTndpMlhKanRpeGxJ?=
 =?utf-8?B?V2QvYkN4N1hJZ2RjdzA2eWZvUUlhdG1EdGNJVlZPa1NCVUhRR2FpbVF0d2cx?=
 =?utf-8?B?QmRIMGRjNDVGK3o3WEZYdnYwYW5wR2s1d0NvMVZVNDIySExoeFByRFpneUht?=
 =?utf-8?B?d3ZWT3NOVzcxVU9vS2xzZEJ5NDQrUjQwc3hCSDBEQStQbmxoU0FYbkY4UGNV?=
 =?utf-8?B?MCtyUzk5K1hhcGxHQ1FkdEF5aTkvak4yWUpSTDZ3VklPdHg3UStoemcyUU9o?=
 =?utf-8?B?ZGZDTUppZ3IyblNMUHBVVVZ4NVlPYXVXQTQyN0gzSXhHSk5iNk9WbFNhc2JV?=
 =?utf-8?B?bERwVzBaS0pmOGx5U1o4cUY0R0cwOFBqdkxyZ050djY4OFd0SWZtcmFNR3BC?=
 =?utf-8?B?aHB5bU95bHFzbXZtUVFZbnpKRnBBSnlUVUdtL0hVQmlvK0VVbWViSkFUb1l0?=
 =?utf-8?B?MytIMVF0NWNEeEtnVitkZ2lCMHl3T04ySk1IMU05ZHMxMUR1bW9ZbUd5NTVK?=
 =?utf-8?B?QXBQZnRWRm1XNVhPZkxKMHppekMwYWVQR1JnZFJacVcwR25nT2dJZmJtR3A3?=
 =?utf-8?B?aE56ek9xcTQ5UzFSaWxmenBscnRGMTk3dHFaMnhQdkhlckhSdUl0S3V3QW9M?=
 =?utf-8?B?MW1tSncrajlvTi9XZmo0ZnIxZ3hHb3dUZkJNamZ2eHNNaWxaTHpQVlRDdXBa?=
 =?utf-8?B?bHNDbVhFdS9TckFuN0VVQk04dDZQRHN4aE52WStpeDlKUXhYT1A0eUpVZEhj?=
 =?utf-8?B?dTkrbGxxTVZXaHpab1F1T3lOTitoTlFtVGRHcmNEY1JBRThxUzlsQnA3djR2?=
 =?utf-8?B?MmtKNytaVENmclFJOElTRlpHbWlNMC9pQmg0OUdUTWpSL2JtaTJPOXNkeWlU?=
 =?utf-8?B?MGJGQ0pvMmZzMmlDTG1QSzRGdDJoQ0VkMWtFa0EwcS9FNUpWamxWZmMzb2tV?=
 =?utf-8?B?MGNSMmVKaEwxYXVSK29hNHJCNmVtR25sOU5mV3dlU0VtbE9NRmJhUE5ZaDVk?=
 =?utf-8?B?MWZwLzhuZ2dKNHgwWExFRWVoUEE2NlNhd0tueU9DVTZnZjZmTDVJelRaU09N?=
 =?utf-8?B?WUNLUmZyRnlnUXNFVkNaanNrdlk2WmlOQ3FMRUJpakRQZkdSYkgxMnZtRDFn?=
 =?utf-8?B?VkZjMHpoYWNzb090ZlliWTNHSU0yUWVEY0Exd3phWmt3N3FVS3R6aVQvakRs?=
 =?utf-8?B?eEpwNFBEenIyenVPRFdHazV1L011V3Y0a3QxeTRjRFBwS253Zm5wci9WZDZx?=
 =?utf-8?B?VFkyb0FncVE5c25mZWtXYURoNVJaNW1VMjdBSFhxNCs3eGgzT3N1VnBmWnBx?=
 =?utf-8?B?QTF6N0dOUnZLNGZzSzRZWitKbnhXTzh6dDZ5cENXanNmRG1aWDVCWmRsaHlv?=
 =?utf-8?B?RXk1RWdNdldQWDRWN0hhd0Z5ekdTcVJPdlNzajQ1Ky9xSmZlMzNsRDl4bDVm?=
 =?utf-8?B?Yy9lUEltM2VhZm5iOUo0dTBPSTJsYUZsNTIrVjRDakdKU3YyYnRobXhnM0RW?=
 =?utf-8?Q?KPNEwHR9mr/U+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mks4dFZGV1lYNDFHbmV4Z3U4RXVFaTBsTHN1N0VoVWprYnJVRDAzckFTbEZ3?=
 =?utf-8?B?a0hmV0s4V1MzOUd1QkR0N3dQMnNJdWF2SDlMbXIvWFlwTHZJVFcwbXVZdHpv?=
 =?utf-8?B?bVdDVzVMUzRCNFk4T0MyOXhrNU40L0JxVjUzSy85blNvMFlSUG5QaWlsc3hO?=
 =?utf-8?B?MVZRbHJaaU4rMVFHc3dxNWZqNlZ0QUtGYktKK1c4alVvb3g5QUhwQ0VhckZz?=
 =?utf-8?B?NUlSaHZFSHBNR0pVbGQrakY5M2cvRllyYklpVEhZdWUvYmszSlp5MUtQMEx4?=
 =?utf-8?B?NHByOGgwdjY2UjloSHk5NzlQOTVMNDFIaEQzaDgwNXVFWFNtcElqcEZkOVg3?=
 =?utf-8?B?SDhSNEtKbU1WVUtwV1VabERCN254WU9nbDhEM3lCMmQvUHNUREdLKzVVNDBJ?=
 =?utf-8?B?b1ZTT3RKUXZubUE0dDV2eXJ5TDJkN2R5NnRiUU92VzRHcDdDUldJZGpmMmtP?=
 =?utf-8?B?NWFRTG56WWZmMFFuZHlSdWtMcVA1cWpFZ0U1Y2ZOY2ZGalo3ekZJUGdWT3N4?=
 =?utf-8?B?czFjMktwTjRacHc1Q0dhdEpFZUVvcXV0bzBaNitnOFZ0eVRQS1YzS0U3TktX?=
 =?utf-8?B?Q1ZYUkVoNk1NRzhwczhNUUE1bktPWFpJTWdKTHZjc0w3d3VsN2dSRW9GNXYz?=
 =?utf-8?B?L2NjMytsdzZ0ZC9OclBQSzNJRDcyTVkvaW1NbmUya1laLzJGNmRWc0RHUm1s?=
 =?utf-8?B?QkFkN3ZnRURWM3QrSFJyUytMc1pJOHBaWDVEWWp3THdjdlZiL0QzdjhSbjlJ?=
 =?utf-8?B?cEtkajM3bGs0Sk9ZOVd4d1FSYjBkMW5NL1VZMURObU1VUy91Q2c5YVRxdDE2?=
 =?utf-8?B?ekYwLzloRDBHT0ZQbUdYTTlyNGRONnc3TG13ODQrUkF4WEcwRVRuL2tqbnZK?=
 =?utf-8?B?TVl6MzRhbnJwY21lYXk2SGl5aWpnSDJYMzRuSXd5eU0yT05mUEtYZ3JmRTBy?=
 =?utf-8?B?WTJTWWkzSytvWEtsV0V3QkU1WFNqMkFkT1EyZTkvRFRuWjZ1NUF2VFNVdjBy?=
 =?utf-8?B?TnkwcjRGZ3Q2b1VNekpFMlZlcEt5RkFxeHRKV1ZYRUF4QTNaN3ZwOWpCSFk3?=
 =?utf-8?B?eTkrUnR1U2R0T2FXbVNDOVgrOC9BVmxCWStUNldUUjdJMmJabHVhemE2TzFa?=
 =?utf-8?B?cWV1UEt3bi9uT3VETnc1VkJQcGs1TzhtdFlWb2h3RjluT09KUW9BdjMvd21L?=
 =?utf-8?B?cG0yNGI2NUk5aEc5alJqMTcrbVA0VGdGSFlvbFo4SVB3RXRQUXg5THFMWUZu?=
 =?utf-8?B?S0tRc1hSV1lidEgzSVlBZ21qWmFuN2ZFQXNodWpDOWp5MG45V3NzTjJmTkxm?=
 =?utf-8?B?N1loQnJBUStscjVEeFR2RzBqMldZVm9sQm8ralFQOHVrdzZIT0V0VkZvNFI1?=
 =?utf-8?B?eEE0V2MyRWRIZjhBT0ljT05yVVEweG9xVmtiQjBlRkNQOHpvay83SGtSMi8v?=
 =?utf-8?B?UU9QR1hRUFVjVCt1bWIwalhlQlpjYzRneFhXdm1jT2xod3Z1ajRNZ0t3V3JY?=
 =?utf-8?B?Qzcrc1RjWVhNQTUvMFI4cWRWRFhiQ09RSG9Ld3ZkMFptc3gxL1lFMnVsWmpZ?=
 =?utf-8?B?OFFCNkhrV3JtR0I3Y0tPQW1DLzFFUjJDNVFwbUc5ejFSZGI3M0V6TVRqNG9B?=
 =?utf-8?B?OUY2VHBCaDVkZlJKSmdsTFcxSDhHejlqZlpRNTZSd3JrMjVya2lYVkthdU1l?=
 =?utf-8?B?KzVHQ2NKM2p0aTJHRStDc21XV09PeEhoaFVtRU8zbTlWalI1ZW1OUDl1UUxj?=
 =?utf-8?B?STVJRCt5QmplcXA2ejhsRFNjcGErQnhWS29WN0pnaHhIdE9IRzNEZzRpR1cv?=
 =?utf-8?B?clkzcnVBdDNONHdqVE9HV2VobEVrQnJ4SUhneEduYUtFOEVXVitCTGlzczdK?=
 =?utf-8?B?TTc0VWdiWlAzOURsZDBxZm54NEVVYktqMVpkU2RkYkJXZXhTT3FpTzdUQ09L?=
 =?utf-8?B?cXQvU0R4RHllWmRXY09FNzRjWk9jbWEwOEVWakFKcVVjQ0JHMlU0NXlNRTFu?=
 =?utf-8?B?ZVFqSGlMZ0FIQ2ZhTzVseXVoaGFmdDE4TUZXMXc0Sk9CVldncnpsUVYya1lu?=
 =?utf-8?B?NEErNmViWHM0UktoZHFCSGdid3VzT2hzUzVCZDZTZnUvUC9RV0dsMGFOQnp1?=
 =?utf-8?Q?Svqw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a319067-74ae-4695-1a18-08dd2e669116
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 15:27:01.4175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsBu0T6gk6JFHYCL9SMsRUBDe/Moej6BK1LEHlx1YFWS9aKJC926qQcQBW8Ij6VO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

--------------Jbm6dgApqAm5RpIqeyLSN49D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/2/2025 6:06 PM, Emily Deng wrote:
> For partial migrate from ram to vram, the migrate->cpages is not
> equal to migrate->npages, should use migrate->npages to check all needed
> migrate pages which could be copied or not.
>
> And only need to set those pages could be migrated to migrate->dst[i], or
> the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>
> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 4b275937d05e..5c96c2d425e3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
>   {
> -	uint64_t npages = migrate->cpages;
> +	uint64_t npages = migrate->npages;
I agree this part.
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		struct page *spage;
>   
>   		dst[i] = cursor.start + (j << PAGE_SHIFT);
> -		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -		svm_migrate_get_vram_page(prange, migrate->dst[i]);
> -		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>   
>   		spage = migrate_pfn_to_page(migrate->src[i]);
>   		if (spage && !is_zone_device_page(spage)) {
> @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   		} else {
>   			j++;
>   		}
> +		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> +		svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +		migrate->dst[i] = migrate_pfn(migrate->dst[i]);

I think what current code misses here is that migrate->dst[i] should 
match migrate->src[i]: migrate->dst[i](vram page) got set for page that 
will be migrated from system ram, otherwise migrate->dst[i] should be 
zero. Your change makes migrates->dst[i] not set though its page has 
been migrated by svm_migrate_copy_memory_gart for the case that cpages 
!= npages, because you set migrate->dst[i] at end of loop and use 
'continue' after migration.

The page migration happens at svm_migrate_copy_memory_gart, not 
migrate_vma_pages that migrates struct page meta-data from source struct 
page to destination struct page and has mmu notification.

Regards

Xiaogang

>   	}
>   
>   	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
--------------Jbm6dgApqAm5RpIqeyLSN49D
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/2/2025 6:06 PM, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre wrap="" class="moz-quote-pre">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..5c96c2d425e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;</pre>
    </blockquote>
    I agree this part.<br>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		struct page *spage;
 
 		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		} else {
 			j++;
 		}
+		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);</pre>
    </blockquote>
    <p>I think what current code misses here is that <span style="white-space: pre-wrap">migrate-&gt;dst[i] should match migrate-&gt;src[i]: </span><span style="white-space: pre-wrap">migrate-&gt;dst[i](vram page) got set for page that will be migrated from system ram, otherwise </span><span style="white-space: pre-wrap">migrate-&gt;dst[i] should be zero. Your change makes </span><span style="white-space: pre-wrap">migrates-&gt;dst[i] not set though its page has been migrated by svm_migrate_copy_memory_gart for the case that cpages != npages, because you set </span><span style="white-space: pre-wrap">migrate-&gt;dst[i] at end of loop and use 'continue' after migration.</span></p>
    <p><span style="white-space: pre-wrap">The page migration happens at svm_migrate_copy_memory_gart, not </span><span style="white-space: pre-wrap">migrate_vma_pages that migrates struct page meta-data from source struct page to destination struct page and has mmu notification.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang</span></p>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre wrap="" class="moz-quote-pre">
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
</pre>
    </blockquote>
  </body>
</html>

--------------Jbm6dgApqAm5RpIqeyLSN49D--
