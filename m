Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD9BC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 08:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B158210EBCF;
	Mon, 11 Mar 2024 08:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P5wx3i8m";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615E610EBD9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 08:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKQktObODr4ik1elsNxhr9X/IQO8wG/9z5jdQMvsF5PktUM6dhFe8wF/vyIwMV3iKufVHLXqqg/fOkPY9/j/Lj1j6vRQstL0lqaXKgoJFkeuR46sKGxvWysMxd1b6sfumCkErK2WNK1VnWN9MIFStxGsLekNl3qMfXANsCQE0x+IycBS6xFkxDeDtJ8D6gs9HUmT6DOij7Y8Z8SQqk8KXpwIebou0aQorV7QSjCQXGc3hCMnnBnM+ua5fk1kiUirWndeZ8PVzWnd0itsKQJGrdQUlYE2MF85vqG4cIe0+0yizEciKIzIvGZ1S0fgIBitnax1XgxSbWmzEwJbhV37LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OWScM2Rblyu+08XN7NE2qaKRagv3DPZ1s07Rihfkl4=;
 b=ETRz2frmLdEgGl2m0I8a5+HYxua838OV+ZGQBP/gt+WLNZf6ECzYeL3lU3/nXDaNP/5QOIjQ2XG6aJgAKsFD7+LmhoeRZNkZj2d3Te9i9WEItwNiR27r53tUZA6Onf13GUjUnbp3QGC9DPLhDYkgPVuAhhme2x0vtSWY5N8soa46j5V3cHqXrcgH43CO0VfaWYMgJaFVNdu/5h4XB2ph8h27wYB6VRt72EHwS1O74uW5Xlu0Zh+X4cuUzdsf1R9ienkvb2OPrzZRbOcjjqk3Jh+Mr+rRvnIItlhM4sxzAtSqkrteUoJ0AWwLI9dbefZ96jKjdZxk0SwBYWjnjmLKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OWScM2Rblyu+08XN7NE2qaKRagv3DPZ1s07Rihfkl4=;
 b=P5wx3i8mBHxqmCVaCZltLRC9XANAgxkl4SCEwFY1uOzOSulNac3YosxIcr05Az0gitBy9BRKX8yy1yqoJsXg+akajMqeA5PsNNlHLaPnTVxnoz9Ef5IUGXvmje3TfrUkq7V+BgyzJZ6NsMmnDjrgGUMtlJrORy1DYml/PRpef7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.34; Mon, 11 Mar 2024 08:13:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 08:13:01 +0000
Message-ID: <ad61e40f-4a17-4700-bb8d-085a87f20ee7@amd.com>
Date: Mon, 11 Mar 2024 13:42:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <b9b7b00d-57e9-4d35-a713-f922f5e19402@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7cca1-99ef-40d5-bc63-08dc41a311ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auEKylvEZInv8CNzK6DTlV8jAHvgSPUIBabs0bK42rNuxtt8dGUFDpvhqQ5ZprH4JL02WS2utL+jwHzPiXRq/QOaRWsHM2gZyF2GEBhTcDzgv+7k59B+U85oWzpc0ANbT37yCvbOCYdEew2m9TYeD/dgiSTdo7wzVYjx7J1rcE1Nys0mhoRfaDPzliR938Aov72bw+mYUKEFPSGTSUSB61swvgkXcP8VqdxTOdyKy7mE3vbT/hUgUbCPY6tHYVKYbpAv+PKSn8eoe13pBnVZF95J+sif/HudXwq0jKddWC1VCEXEcjX0Mr2UhWDa32EMJ9ZuhJqXjKgHUZ4TVKhYx1rA56+D9tNu1bgBxFvCrp87hfY7VSruE4NaKUahbp9ynmfilRbPj5Xus/3WU1XbVTFxrl39XB5oqVKLFRnHxHblku/ELQ4zd5M+zN4QjW5U98cvXpGD2cVADAFy344PuoxRnhKk0I+i/0GjCejRTjbLjwalULP3l7wrbklbvJBRkPn6TsVffpT21aI/E6SqG40hyki50wKfiPvHTT682mehNJXE7Fz9MrU/YjLQ2o+Wy1n2BU6csqsey7lXv1SfWaIi3bSmaBe8KkKeVubxpHK1Ehp209IFKJmPmPctF2YSWFubmjDJGEXr/coM5wiHnpYBMlQ4njcROAGWfHWu+VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJiaEpSWHhnYnVqTm9qdUtsZkhnY3FkMUhvZUt0RVVUSFpGaXRtdkxpMjRW?=
 =?utf-8?B?TVcwcGxzeDVabE9MaVQ3bEFjaEgyY0JhbGRKTlJDa2xySjU1STBHUW5HNHQr?=
 =?utf-8?B?dEs1M2kveHhPY09iT2g1U2pYV2l1MUFrc0Zqazh4YWFKV0pJVEJ6ZU4wL010?=
 =?utf-8?B?cFFNMFZESUJKSEJzVmRRdGRINGRzOVZGU3ZXbmFKK1l4aC9xRmZjVXp2Vy9i?=
 =?utf-8?B?K2YzcTQrZ1lHek8ySU8rTWgreHdqVy95U1g5N1M2d00yYkhmOFZBOXA4V2d1?=
 =?utf-8?B?bGJBaThZS0J1RlVNWHN1blNtbGd1RjdxTlp6OFpoRGQxZ0pKN3pZcnhiVTBs?=
 =?utf-8?B?UDRTRkZGVmxwMlVxNExpSE9heTNEMkZUN2lMdG01aXdFOEdwenB1UWYvcmNM?=
 =?utf-8?B?UVVBMEdPTVZuSU1TUzluTnFma0twM0VWb3czM1RWY0NlSExPNktleXFGdTNN?=
 =?utf-8?B?UDNsamNIRm9lQ1VIOXhwRERhdHFBSUxIYzB4RFAwanlGNUlhd0JzcHJKUUFn?=
 =?utf-8?B?aThPZnpWOHJpT3Y5ZkpwMGd5RTdVZmFhb1luUGxWMmhXN01kcVRhcUhKTjBl?=
 =?utf-8?B?L0NYeGdZWERjZVc3Yy9JWFN0bmFwR3NYRWlpbGJjRmFTZEtZazc3WHNqZGRv?=
 =?utf-8?B?VFRwY05wYXRrcFRWaTdoMmJ1VFg3VnlTVTNQTlZDVEJjN05PUUZXMlhmaTYr?=
 =?utf-8?B?NktUcUltd0VodzJwWDZtT0lQMHNNV2VkUTNnUUV2a1Y2OFVhblRQRWRMallD?=
 =?utf-8?B?bGJnNXI1clg3NnpKcFlBUnR0NUluT0VuSUV5Ymd5RStjYVdDYWkwOTRzaElZ?=
 =?utf-8?B?S3dRZ2xxRE5BYUMvQnV5aFpROWdIMnZ2b1oxTlgwT255RjNNdU5GUHFmREE4?=
 =?utf-8?B?R2hzK0VaZ1VkQlFrYUF3K29pdFN5Vnd6L2Z5Y1c4L3MvUDlqTFNlOUtSYXRB?=
 =?utf-8?B?M1c0NFUwNmxFWDVqNm9PSEJSYUV1RGtrR2c4Vno5N2ZVSTcwSnRkVEdTY09Y?=
 =?utf-8?B?dUxiMzlHQWdaN3lRVTlVVEFMcWw1OFNCaTVJRE1ybHVIanpkWjk0bWNsVitN?=
 =?utf-8?B?Sjh6bnNjeDZydnpWbGRML0JVMlVrMGRDVEx5QUQwdUhyY1J0UGlIWHdOUUNk?=
 =?utf-8?B?RTltRFZDVFpnTGFXclhmTlFwaGl2YUYrMjZzTUhlV3JYN3FCSUJPQUdkRmVQ?=
 =?utf-8?B?S1Z6ZWV4d2F1UWNJR0paOGpXWkVRWXNHNVVFWnFZOXJDUXpNMkJzSzArK1NG?=
 =?utf-8?B?NnhlUVNyUkZGcERFTjBsMm1WZEN4M0NhS1kvVkNMMmZWK2RLK1QvL3ZRbWp1?=
 =?utf-8?B?NUlsT043R2dEUzRDaW5kTk85eDJyb01ybTQ5YnZBL01VZnJTQmhmY1dYRVpN?=
 =?utf-8?B?S1J6eFIyR1NRZ1gwbXhWcjFwd1hueThsNWZlMWZ0dlNWbGJZZDlpanJGWTcz?=
 =?utf-8?B?c2ZtVUx1cVhQUlBxSHFObVY5bHNnVU1JN1JRajg5SEFTa1l2ZGNweURmTkY0?=
 =?utf-8?B?eWNqMVdTQ2FiY012ZnFEMTBVM3E1M1QxcTUrK1B0YmJ6WjNrNTlCaXoxK2FO?=
 =?utf-8?B?NmdsM3BocVFrUXRoS2VmQTBSWHdLNXdqWURQSnp5NWRCQ0lwNWgvUHBkS3ly?=
 =?utf-8?B?RUlLZ1VLMzFmbDdjMzR3Mkc4QnBPZUQ2WTV3RnZSWEdFRTJxSndXS1p4VU1C?=
 =?utf-8?B?K3FvcFpiWWtNZzRFZm4xSTkvcU1kam5zZnBiN0VMaEdzL0UvQ1IwQkJvd01v?=
 =?utf-8?B?bWVUcGFTZFYvT3NLTXdKTHhEYzZwOUlXSDkrZjRQYVpaOS9TZFVienZ0WVEx?=
 =?utf-8?B?a2VWYXF4RWF6QWpzekk0NUYyRm9YM2NjYllScWdXdmRFNVArdjVtM3hEa1dp?=
 =?utf-8?B?M2RSUTFKK0hVNkM0N25UaWpDMTkwOWd1aHVLNnVJTGpmSEx3NjNZQlhkUXdu?=
 =?utf-8?B?aW5SU0lCU1ZjWlV4czdjY2l4eTQ5ZHViUFpFZmhzdWFCcWxLZ2ZWZEE0OG1q?=
 =?utf-8?B?b0l6Q2x4c1A2Z2grR3RCY3RkWkpXeHRSTGVsckpJTEF1c3I4cnRJWlhzMFo3?=
 =?utf-8?B?MXhCNlU4eXRsV2pGUXBYalVNRGRsUVBZS0JBZjIrM3BURTczbnlwbERHRGJN?=
 =?utf-8?Q?4NZXgjOI7FAukTWgk7MxT/oDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7cca1-99ef-40d5-bc63-08dc41a311ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:13:01.5613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDYU2VQ4osaPJfjpd4j5zQv/kEWNXX6IavSTJDEGAJgJ7K07s468b++bN+S9ALfj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926
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



On 3/8/2024 10:17 PM, Felix Kuehling wrote:
> On 2024-03-08 11:22, Mukul Joshi wrote:
>> In certain situations, some apps can import a BO multiple times
>> (through IPC for example). To restore such processes successfully,
>> we need to tell drm to ignore duplicate BOs.
>> While at it, also add additional logging to prevent silent failures
>> when process restore fails.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index bf8e6653341f..65d808d8b5da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2869,14 +2869,16 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>         mutex_lock(&process_info->lock);
>>   -    drm_exec_init(&exec, 0);
>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>>       drm_exec_until_all_locked(&exec) {
>>           list_for_each_entry(peer_vm, &process_info->vm_list_head,
>>                       vm_list_node) {
>>               ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>>               drm_exec_retry_on_contention(&exec);
>> -            if (unlikely(ret))
>> +            if (unlikely(ret)) {
>> +                pr_err("Locking VM PD failed, ret: %d\n", ret);
> 
> pr_err makes sense here as it indicates a persistent problem that would
> cause soft hangs, like in this case.
> 
> 
>>                   goto ttm_reserve_fail;
>> +            }
>>           }
>>             /* Reserve all BOs and page tables/directory. Add all BOs
>> from
>> @@ -2889,8 +2891,10 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>               gobj = &mem->bo->tbo.base;
>>               ret = drm_exec_prepare_obj(&exec, gobj, 1);
>>               drm_exec_retry_on_contention(&exec);
>> -            if (unlikely(ret))
>> +            if (unlikely(ret)) {
>> +                pr_err("drm_exec_prepare_obj failed, ret: %d\n", ret);
> 
> Same here, pr_err is fine.
> 

These kind of prints - "<func name> failed <error code>" - are way too
generic and if more like this are added, it will be difficult to find
out even where these are coming from.

It's always better to have a context so that this translates to some
useful information in dmesg - minimum context is the device or bo
details or anything of that sort.

Thanks,
Lijo

> 
>>                   goto ttm_reserve_fail;
>> +            }
>>           }
>>       }
>>   @@ -2950,8 +2954,10 @@ int
>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>> __rcu *
>>        * validations above would invalidate DMABuf imports again.
>>        */
>>       ret = process_validate_vms(process_info, &exec.ticket);
>> -    if (ret)
>> +    if (ret) {
>> +        pr_err("Validating VMs failed, ret: %d\n", ret);
> 
> I'd make this a pr_debug to avoid spamming the log. validation can fail
> intermittently and rescheduling the worker is there to handle it.
> 
> With that fixed, the patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> 
>>           goto validate_map_fail;
>> +    }
>>         /* Update mappings not managed by KFD */
>>       list_for_each_entry(peer_vm, &process_info->vm_list_head,
