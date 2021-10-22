Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E83C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA29B611C3
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA29B611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FC16E96D;
	Fri, 22 Oct 2021 09:50:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824E46E96D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAer+EoiHF4Nc6+/iS5B8/G56zcQyKhmC4KKDu/TxD8DvOHA+LluldCuAXDsaRGrDzQv4KUsIiDtItCcaaB6yPe+kLnKSUmPbVHR5uYBqgyudRxFdKRbEs7s1JwqbsJGhk3rqUTQ5LhEZzOjiI5Ltz27v4iOE7lc5v4Jd1mBYXvJ0n74+18nxzFUVL0mwZBtNjdx4KPFO3tcCPi2DGfGSVdJxShw1/FQpv4KkCaS5pvmqUZWYb1EE9p1G74fvX4RHh5aNFNCAx/77uMjAq7v2KAf787/8XISifsioaCufOFP8M5IZnMngOH8RSmlZVvvwHNaFpflkEf3wXEJoJ+VxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDhnFHmo+j1jCnvxUutymWOCd4VxnywLwneDbE6KT9U=;
 b=iDUyYDLxB149fDVgs+iFuKr6yuM6jJv0afkqyIFxiEGESSRXgrI8R3CjfpwaTFdlmzLVNKkdKoBLF4zRxWrEAUksYo1bUHeTYxXYxfT0HZN0TTdEAvcbXKi6tYH3FwSsqFctXaSa4imzrJKcPomFPL8A9+vFZlkE3pm6WIAmjYZ0qMY0QoF5REPkkvprhuq8KZ2wY7WxEsJAA/p0+hltPbuUsdtfrgpV5tC7ZCbBEO2DFuOiHVv9HIt8FVyPrb4QnGF2bcg7I5hqnkzB3zMKeXWT+8bvxFxSKTWAZ928gdYrFqQyB0eYVX5LLqS8vQCNnk/tKLSI2JwOlW7BW6mHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDhnFHmo+j1jCnvxUutymWOCd4VxnywLwneDbE6KT9U=;
 b=Rf7zcqiBKUZRFJpLSSo9R3v7EqVKM+xlUKg6sf1xjxW0Z0j6TNSQrMKa2DE0g7Bv8a+4rXa8JOlh+XRBS4p8nFXlWs4GhZNcRKTPPpF8mJdmfIXbQIN3s4qVNGCRjtxxoR1ic3rXUG4a4go9579KwVY5xi+gdnusLMctjVg2Q80=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4410.namprd12.prod.outlook.com
 (2603:10b6:303:5b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:50:28 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.018; Fri, 22 Oct
 2021 09:50:28 +0000
Subject: Re: [PATCH v3 3/3] drm/amdgpu: recover gart table at resume
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com, lijo.lazar@amd.com
References: <20211022093231.7787-1-nirmoy.das@amd.com>
 <20211022093231.7787-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <db7f5f0c-2848-df9b-feba-0763ba69e003@amd.com>
Date: Fri, 22 Oct 2021 11:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022093231.7787-3-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::39) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:a39f:d981:e7cb:e6dc]
 (2a02:908:1252:fb60:a39f:d981:e7cb:e6dc) by
 AM6PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:20b:6e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 09:50:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b77287-613a-4b3c-d80d-08d995416117
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44101D07C3750BB48A233A6783809@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jD+FSMeIRW9WsIy17HahyOwhJBz2UhlbekRTmO9RPx9rEthP/OUqSuw+Q7Dn5jzCCp2sW04f5lWtKW2f7NJ0jGk1U8bpjPpolQ9kF2vI6Rb0IY6suEerlinv1SlPWOLLKVd6Vu6KyF1A0TCwjS3NSd/bs0BBwuvUAFN77KVJsP+PdcRHIBi33g5YzoYEe9yqXMtloYulb+JTDS/F4qR8B5QrI7vELNSV07p5uacKTaSty+PkdbZo8ZZzHJURWycwbHzkb/85JxkRBm1RBljdIoAn45jA93a1QhcNC8UqXcCXiBkoYMR7Vaqw600TOMzpv8QoR1g6+kU8TFTbHHgEPofk0xgk9cXotCfw8fi5fh9bc+z5MJty6PgHoYoT2aT/f444RutRoXfHDZjnda0zEbQKLnKQoz60F61o/rn9hXY1OptxZwEDIsfISZCo/UK333dOsGTqbd1SuJDBf9kJPHYCgxxMWy3FbBn//6GHzc2ztSotj7yFnwwseIHwweK/vo2jjInkFh7xuEYG8LAiFaqW9OyBnfxQEFhgU6gu7G2VTwWS6Mx7+BRb853HT1hOR3SkMJMw961ffP1VHrKiOcVOp/uaT3yollx5T76P1Nzg1YFz47LJcSvMKAeFssaKpD2WA3JWR32d2hqs0YfY76+UQClwFIP/1B+Knd7tcrZddfYB5/PNqkO8pP9TI2UsRU0BGduCqNc8t78dYisfjiWi/C+2b3FtDKUuetZkcEbmVnsi4HNV+c0EJuN6C9H3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(508600001)(66476007)(5660300002)(66556008)(6666004)(4326008)(31686004)(2906002)(66946007)(2616005)(36756003)(86362001)(8676002)(6486002)(316002)(38100700002)(83380400001)(8936002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFM3V21lbHpsM3ZwRFBmbXFEL0x6eWg5OVdNS1ZIL014SDN3K2FDdjBObWxr?=
 =?utf-8?B?SjlXeTBUQkVvYm4xV3J5eDJsck5Ybkl5M2FlYnVrVEhGc2F2Nmt2U3ZBWUpU?=
 =?utf-8?B?ckVpTXBaMEU5YjMzNzliTXE3SWJiLzNGNkpHMjRBVTdEN0lzOUJEb1VGdFRI?=
 =?utf-8?B?OTUvUS80T1QwYkIwZUJ6UGxoOUJIN0NDeFNGcjIyTHk0SVlnU1BvVC8zOVFY?=
 =?utf-8?B?SHViQlRaVjVWcW0waXcyS2VHRjZ5cEI5bjRpYlZkZUpZS0F6Zm1NdzBIZEtq?=
 =?utf-8?B?dmh4OENuOWVwN3V0VTZaOTFUQW9YcWZwcGdhZnRWZ3JVTERuRWIzbUUxcXgy?=
 =?utf-8?B?dzh2R2hVaThrbUF6UDkwakZmckZmV2g3aE5wZHArNmRIS05YWHJOWTF2NDZ0?=
 =?utf-8?B?NENoYU1QYjJhODVkK0V0cHpycE11dWY3UDcvaGRuZWZ4cHJLUm9PeDMwYmJ3?=
 =?utf-8?B?dVprSWhqS2JuL1BuUnJpY3M4VGN3MWhLN1k1OEsxd2NJU25tNW5jQ1AyejVj?=
 =?utf-8?B?U3JpckRGcjZjMnhDOHZoSDRHbzYvWERlL3JJeFFFTHJuUTJBRUdlQXhXdmtj?=
 =?utf-8?B?Zm5OSHBvVm5QaTR1T0hiK3I3L3Y0RGV1TWxuTHFzTkE2RWRjeEZVQnlWQ2hV?=
 =?utf-8?B?MGdwYkxGWGQvaFJSWjhRTHJkekJwVW5ETDZnZWZEVjlUVjJSV3l2RThDNFU0?=
 =?utf-8?B?eGUxM3U4L0s1TkJ6TnhGUllJTEVJeHF0RkZ0YTlwQlVEL2ZxaTF4M01QNnk3?=
 =?utf-8?B?ZjBJR1N0cnJoek1JYUpnZ3lTWW1EWEd2SEFFZ1pXVkx2d3JxWC9yUkk5Q0VK?=
 =?utf-8?B?akYxUUczSFc3VkdXczNEL3R5Ny9TNngyV2dBellRZ2h2MTJDcE1ib1Z4alpp?=
 =?utf-8?B?VTYxRWcxY2xmcHJlZjM3czhUOGRtT0lBV0JPMVFOdXc5c0twZzVhekhhT2JT?=
 =?utf-8?B?WmhlR1dqNkdSVUpKZVFOampWeWs5eW94bFNHUUsyTVdZd1RBa3QySjNuT0d0?=
 =?utf-8?B?cDdEbit0ZVN0Q3BZZlJxeE0wQzBianpxNm1GYjVRWW1KRTliOXh5bjFpc05i?=
 =?utf-8?B?bXVxN0t1QTdtUysvRWlGRDlOdEw2Z1orVlg2YTNSSG44bDlkcFZkUVRXOEkx?=
 =?utf-8?B?OEZ6a1J0bzBSellUNUlsSExDajNNQXlVcnRsWUdjdU5ncHd1RVVNZjh2cFUr?=
 =?utf-8?B?Q2RwVTI5MlJKUUhwTjdLRlMyUWZ5TDM0eUFoREp2Z1krT0ZqOTdRTXg0Y3gw?=
 =?utf-8?B?bmZZRjRxVjcrOXg1Vlg3cXkwZ1VVRnBPREVIT2RSNHdJZWlCbTlnd3ExVWdP?=
 =?utf-8?B?UjE4WXNkbUNkK3ZzUEVTVng0Y3lUVVIrM1cveHBXUmpIMFJpQzI2VEhPZ0FJ?=
 =?utf-8?B?d3pER2YvNlcrY0FzTzJVVG5oc05nL2lYejRhMlZCR09OUlJVMlQzMDQzY01K?=
 =?utf-8?B?RWF0ZmNFQVNMd1FSMUdvb2lGT2N6R0U1dkZyK21QdHAxd1BJbUtPUC9vbitw?=
 =?utf-8?B?UXQ3ak5nQjA0bXQxbmQwK0lhdnZsL05LbWZPczZaMUNHQmtzbEhwY2U1SVJI?=
 =?utf-8?B?Z2ZBUlZJR2VtOU5yWnB3bXNhV1VQOGRGbjE2N2FnOEJyaXNoSkhhVmU3Umg2?=
 =?utf-8?B?QTlyNlF1eUdCeTR3Tm9kNTFYRW5TRFJUL1F1RXRreHZ6RGp2eElrVm5TM2d3?=
 =?utf-8?B?QWZvdTRjU0grb1F2dHZMRk44WktCcTlndlhKeXBEOStJSGRnelNRK0c2R0Nk?=
 =?utf-8?B?c3NkOFNsOUhMWlAxMkVNSW9nZjFybm0rVXNQQnRKUW9NVVNFZWdIUWRkWDRy?=
 =?utf-8?B?OWFONXFGNUhSdTdlS1N5YWN6VDRjZytYakVkU2x1bjhiYU5jMmpTSWQxVkc2?=
 =?utf-8?B?NUZnczl3Yncvbi9oS0pvWllIa0svUXNOQXpaOXpaOUxkQ3hTUm4zclhwbHZ3?=
 =?utf-8?B?YVR1WUhhNzJjZk1hRjgvZHZoNWN0bWFsKzFuekJOV3BKT1VCQ0Q2eDE4Zkxm?=
 =?utf-8?Q?IJ+8sh0jAcAMcbsnZfR5gmWht5vSDg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b77287-613a-4b3c-d80d-08d995416117
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:50:28.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Am 22.10.21 um 11:32 schrieb Nirmoy Das:
> Get rid off pin/unpin of gart BO at resume/suspend and
> instead pin only once and try to recover gart content
> at resume time. This is much more stable in case there
> is OOM situation at 2nd call to amdgpu_device_evict_resources()
> while evicting GART table.
>
> v3: remove gart recovery from other places
> v2: pin gart at amdgpu_gart_table_vram_alloc()
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 80 ++--------------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  3 +-
>   7 files changed, 12 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b53d86aebac..f0c70e9d37fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3935,16 +3935,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	if (!adev->in_s0ix)
>   		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
>
> -	/* First evict vram memory */
>   	amdgpu_device_evict_resources(adev);
>
>   	amdgpu_fence_driver_hw_fini(adev);
>
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
>
>   	return 0;
>   }
> @@ -4286,8 +4281,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   		goto error;
>
>   	amdgpu_virt_init_data_exchange(adev);
> -	/* we need recover gart prior to run SMC/CP/SDMA resume */
> -	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>
>   	r = amdgpu_device_fw_loading(adev);
>   	if (r)
> @@ -4604,10 +4597,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   					amdgpu_inc_vram_lost(tmp_adev);
>   				}
>
> -				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
> -				if (r)
> -					goto out;
> -
>   				r = amdgpu_device_fw_loading(tmp_adev);
>   				if (r)
>   					return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index d3e4203f6217..679eec122bb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -116,78 +116,16 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>   {
>   	int r;
>
> -	if (adev->gart.bo == NULL) {
> -		struct amdgpu_bo_param bp;
> -
> -		memset(&bp, 0, sizeof(bp));
> -		bp.size = adev->gart.table_size;
> -		bp.byte_align = PAGE_SIZE;
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -		bp.type = ttm_bo_type_kernel;
> -		bp.resv = NULL;
> -		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
> -		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> -		if (r) {
> -			return r;
> -		}
> -	}
> -	return 0;
> -}
> -
> -/**
> - * amdgpu_gart_table_vram_pin - pin gart page table in vram
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Pin the GART page table in vram so it will not be moved
> - * by the memory manager (pcie r4xx, r5xx+).  These asics require the
> - * gart table to be in video memory.
> - * Returns 0 for success, error for failure.
> - */
> -int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev)
> -{
> -	int r;
> +	if (adev->gart.bo != NULL)
> +		return 0;
>
> -	r = amdgpu_bo_reserve(adev->gart.bo, false);
> -	if (unlikely(r != 0))
> -		return r;
> -	r = amdgpu_bo_pin(adev->gart.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
> +				    NULL, (void *)&adev->gart.ptr);
>   	if (r) {
> -		amdgpu_bo_unreserve(adev->gart.bo);
>   		return r;
>   	}

Just "return amdgpu_bo_create_kernel(..);" should do it now as far as I 
can see.

Apart from that looks really good now.

Christian.

> -	r = amdgpu_bo_kmap(adev->gart.bo, &adev->gart.ptr);
> -	if (r)
> -		amdgpu_bo_unpin(adev->gart.bo);
> -	amdgpu_bo_unreserve(adev->gart.bo);
> -	return r;
> -}
> -
> -/**
> - * amdgpu_gart_table_vram_unpin - unpin gart page table in vram
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Unpin the GART page table in vram (pcie r4xx, r5xx+).
> - * These asics require the gart table to be in video memory.
> - */
> -void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
> -{
> -	int r;
> -
> -	if (adev->gart.bo == NULL) {
> -		return;
> -	}
> -	r = amdgpu_bo_reserve(adev->gart.bo, true);
> -	if (likely(r == 0)) {
> -		amdgpu_bo_kunmap(adev->gart.bo);
> -		amdgpu_bo_unpin(adev->gart.bo);
> -		amdgpu_bo_unreserve(adev->gart.bo);
> -		adev->gart.ptr = NULL;
> -	}
> +	return 0;
>   }
>
>   /**
> @@ -201,11 +139,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev)
>    */
>   void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
>   {
> -	if (adev->gart.bo == NULL) {
> -		return;
> -	}
> -	amdgpu_bo_unref(&adev->gart.bo);
> -	adev->gart.ptr = NULL;
> +	 amdgpu_bo_free_kernel(&adev->gart.bo, NULL, (void *)&adev->gart.ptr);
>   }
>
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..2440278a3b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,7 +992,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -1062,7 +1062,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0e81e03e9b49..3a8c9d4ee06a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -476,7 +476,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -608,7 +608,6 @@ static void gmc_v6_0_gart_disable(struct amdgpu_device *adev)
>   	WREG32(mmVM_L2_CNTL3,
>   	       VM_L2_CNTL3__L2_CACHE_BIGK_ASSOCIATIVITY_MASK |
>   	       (0UL << VM_L2_CNTL3__L2_CACHE_BIGK_FRAGMENT_SIZE__SHIFT));
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..ab8adbff9e2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -620,7 +620,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -758,7 +758,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..cd3a4bd8fed9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,7 +837,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -992,7 +992,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..8732da11ad98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,7 +1714,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>
> -	r = amdgpu_gart_table_vram_pin(adev);
> +	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>   	if (r)
>   		return r;
>
> @@ -1793,7 +1793,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
>
>   static int gmc_v9_0_hw_fini(void *handle)
> --
> 2.32.0
>

