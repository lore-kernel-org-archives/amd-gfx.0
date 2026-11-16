Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C63606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jam7qKqq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0912D10E470;
	Mon, 16 Nov 2026 21:22:33 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCCA10E470
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 21:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmMNE1HmMoxv18r97F9I+MMFtR6U1iNmD1b5JXLuz/V43vwbbS77GxYN6qUGpYsNZrp0byyjszvQRY+8LVF85VWGg+Nx8GZrLRkcFi1vMksrF3d/s0GlxEvF9RkwsDmy+XxZBQ99zplTCcsqICDO94IQ7VE2iY421rrptJQCiVbdXSWReP4Uoa+cneQImU+RpmRDb6IaOs9tDJqDPhPHlX4opNGlUVhP8PtiXM0R1b9DMDMZDpIdJ9aX+oIkh9gQW/nwscbxgjZcqYp+pYnHOvPwSVA4tw8oRA6ix2c0UZOOvitR69rpcbemzCtNhZ+ObLHLpbEjaqfkFkPNcZASWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwh6Oc6YaQCMw4NSw29GcFIMeMbyVm+rGAQUA5IfJHI=;
 b=autUeOiaQuZpJuRBwCBhsIUyxrY+kCHtOokKo4FOyMC7w6IGP71ohU98BSpwHcWYU26OzpcGkpURKXwKUP+X8ZWPTMr6h+RPnVQHkDyUhbB7HQ7WC8TKm9EskuDpvCv1bAsiwJIyvtWIfhQyGBYV1iwYIBdtqn6eHUhzFGIiL4A15hDAxss2XAPmYuiXwshBVHCaSZwegf4m4ONaCt4aPylZtBDmq3CW+D3XBSHOv+9eSn/3qBuNF9HYQWaR+fcoXqb5e/TlZtJxhp28xe2TluEp8YWx4cqcnQVMiHVx5ri/XeklJirYvtGjkr0MH6UMV3IUeKn+HR7ILa2v6o/BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwh6Oc6YaQCMw4NSw29GcFIMeMbyVm+rGAQUA5IfJHI=;
 b=Jam7qKqqzJ28zs/SXlM+SheHeJSqM6z+3uGK41KE1YgLFVPIZbVClLIt9xNE8dXoQlfSyinfOz8cqTtl9gOUgUb6gN8fvMDldyQ9DGg8c1LsAHtunTPFMLH39BZdsjE9rbYpcz2QsxRo4/loXNHs2IJikZZ2cTESvvpKu+Yx8Dw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 21:21:18 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 21:21:16 +0000
Message-ID: <e2451b28-908e-4ff5-a8ea-62ff074300e3@amd.com>
Date: Mon, 16 Nov 2026 15:21:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <sashiko-outbox-217693@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <sashiko-outbox-217693@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9900fce1-9208-4ccd-a4f1-08df44278c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261026140227099003|5023799004|11063799006|261026121527099003|4143699003|261009223027099003|261022105027099003|261021121427099003|261022075727099003|56012099006|261028144727099003|10067099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Wof/Xiavjtve5xtks+TZzNTM+JSBnlp8oP7/yMUU/MbXlMTMoyGJzjl79loSznYFauCDIRHhX8/Gz4x6xvDxY8eSzjPxmkxmFcl4oFZQZHuq6d/4TiUWDbHlmWqJgoWk5T1AyhSSOr4Vy+l+KbTnqTEWxKywfWxsTwX6fKV0TwrmDOSDj5Kuaoj0lWGVSiH36vTFuq8qdRxOqWfAcYbKtC6xbklUdR2AOxzhDK4JnE6l9+Mabl2sltlsJfqxGq5mGx+V0ECaj9EnxibrZ8EuZKD2fOcT12TIpjQOcCQMiB6wGEXeo8LfnChAze5AkvKxdJ8umRMzn9uGdTB/cBwxEIQl01QtcrcAuBH6aFCaaMvfAUHx1hvgmeQBPGuEWZLKhQb+O0UZA3A0AYN5oOMCyNKYZs+n1NtiFnqiLqbZKabcy+dZ9bb1lWhrHb+TMaFhEqV896mcxuQCzjkdLMCehePyhtMZl0bmbUy2XAh4rbPhtsYajzeg4JkBd+pMkSgzO2HLgI8aqWpuRObDkvo13eNNNOBNCRhyZ2r0+gaT+E21hW3MOgzZEnTC9eW6FU+8egCE6aFcvH8uun5jeHIWCMUhrKy4uq/yF/lNaLOGnPzV2WKUEkZnoAuYd+qLvXYT4Oogsg0QBw/1vptpZDtPBB2xkYqnh5Lg7rmAkNzD/ko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(5023799004)(11063799006)(261026121527099003)(4143699003)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(56012099006)(261028144727099003)(10067099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTQrSC9sSjd0UGlpbTBpWFJzbkhmU0tlK0N3S1I0bE1SeS9OVjgydjNvSXRy?=
 =?utf-8?B?c3ZnU3R3VGh5R0VRazRXN1FsOTlqNmgyN1FNams2K0hUeHdPdFEySDBXaFhX?=
 =?utf-8?B?K3dNeG9IZE5vb251S0lLZ3VxSG1pSEtydWxVcDBWYU9Bd2pZZms4SG5PRFN2?=
 =?utf-8?B?eENqcnRzZkVId2hJS3FUUXM3ejIwUDZXM1dRd2s2dWdjb1g4dFZaZXBoN0dR?=
 =?utf-8?B?ZzlpZDdwV015ZEZsMFNjWTNpbXNPVjd5bG1wWE1nYmlaenRyVUxTaHYyOVd3?=
 =?utf-8?B?VzhJd1hIeEhlR09QWTV0MldVR2JrbnFGLzI4b1UxRnZQQ1ZQNjVBa0RIRjM0?=
 =?utf-8?B?UTdtdWtNQjBSa3A3ZjRxTi9JRUVtd2lJa0pxY1VMQTB2bjdEZEZGWkh2T2dY?=
 =?utf-8?B?Tlo5QmtkMndNRUQvVmk4eG9IZmlwcEMvNFRQUkQ5cnpLUWxxS2hSR3c5Lzcr?=
 =?utf-8?B?eXgwNENwRXlTZmNTWCtXWmJtQWhmRXpzTjhBL1BYTVBYOGJKODVHUlJvbS9O?=
 =?utf-8?B?czMrZWtIUFZpYkdIOGhpanpENzNsaDcwVERQMmV2dFlJUkJRZmg1QjA0a2kv?=
 =?utf-8?B?YXR6QzZURnNJb0lGZzdTcjJjZWUybk5STzFkWmllczAxRHVqVUt4UFpJdENW?=
 =?utf-8?B?VENwNXZYc2lsUlM0RWdxM08rWm56QktHYU02K2FlWElJN1N0ME9KRHZYUVhh?=
 =?utf-8?B?OHdCL3FqSnE5S3N6YWtvTVY5T2lEcFU3ZlE1eU9iaDIySDdrRk5FMnlHNUtr?=
 =?utf-8?B?QVBRRWNxdmwzQjNBcCtVQTIwTnhORFVzcVZUNWdTSWlFTEwwbnBVU3Y5Rkpa?=
 =?utf-8?B?T09BSTB0dXRueEFpTW1RZ203bzlDRW1oTGRYRWdnck9YWXoyNkNqTHorelFC?=
 =?utf-8?B?UEEwd0crdFBsc0hFTmJQVW9FSnM3MXkyRzBaTkpIbUpuUU16NHRLYU54NC9j?=
 =?utf-8?B?aERGNGp1UlNOck04cHp0NDd2MEl0MnN5QUpHbmVlWDkrbzQwQTJabWM5eUpk?=
 =?utf-8?B?aWxVd0pGQzlVa2tuQlV2RXdtdVF0SmJJSnRTdER1aVBJakQvSTU2SUdpbi8y?=
 =?utf-8?B?WjZ1T3lxalFrUXAzSVFETmFrd3NZS20wUEJ0YnNjWDc0WmF6K1VGT1ZpNzVM?=
 =?utf-8?B?bU1pWS9HUFlzbUU0Q3lDVTlmMFllTmM3SC9reWdwYVV3QUtCUXlrVVhJUWFa?=
 =?utf-8?B?SHBoWmd1WmlvaFRJSklTWHRBa21QZlNFaHI2VEVPMHhyNnNtS1ZoVXVTTHIr?=
 =?utf-8?B?TlZwUVN4cGlJMlBONmYzZ0hFcjFjWEpyMUU3cjdSTklkUEFnL21PRXgvZ0JY?=
 =?utf-8?B?SU9naCtjckY1VG80MzF4LzU3V3R2T3Q4WC9XRE0xMHAzaSs4R3hqQ3VtK0kz?=
 =?utf-8?B?WHVPTGtwOE4zYmV6cEFrNG0rZzhSQnhvRjB1dmhWTVBXOTI4VktaVE1LcTY3?=
 =?utf-8?B?VzIvekw2R01ER05GZ3pCdkM3V0ZraFB6WFBmU3NtK2IvZkFYT2xIU0JPK1NR?=
 =?utf-8?B?d3FBK012Qk9hd25USm4xUHFhYlVWM28zdVhUb0xwVjNXYkFOUjFyM1hjckov?=
 =?utf-8?B?OVRlQUREa1lWdWlLZnZvSDdZM3krU2RySFZ1TXY3OVladDd5UU1FYjFQUXBD?=
 =?utf-8?B?NHd2Z3lWVWR4cVBNbkNaVzJ4RGIzY2cwM1NTMFMyR3AwY2VMOXBZVnBwTlJD?=
 =?utf-8?B?RmJlY2kvRlludXhMaVppRnVTN2c5OVl5S2lzc2gwdDlEdDNodDZxRk5oemFm?=
 =?utf-8?B?elY2Sk1oaWlBRTVVQWhKdHpEbEIwMkhtVmZrMEdSelM5UldyYzVna2o2RVg5?=
 =?utf-8?B?NXJrS1VYWmNmdTMwZmJXUEVvakgyL1phT1BOcFJkTUcyejNhOXliTlBCUnFs?=
 =?utf-8?B?WmpyanozZk9TUmluRi9uNC9ZN2JkbHh6eGdnYjI3WGZ4N1k5Skd6RG1ZdXM1?=
 =?utf-8?B?L21jTnVkbWVCTnZXTDJPT0ZvU0dRVGRIMkY3NWxiMzFQOFZBb3VVd2c1SkdZ?=
 =?utf-8?B?ZGhPQWFZRnQ0T0pXOGNRNTRUb3lIZTg3MTY4clRKYm44TnE4RDQ5K0pEaHFE?=
 =?utf-8?B?Nzc3YjJFZjBrYjVtQ1M0U3Z1dS95Z1Rzd1lDb2svQ0RPdStvd2VaWHNBSEJJ?=
 =?utf-8?B?MjR3TXo4K2JvZ2ZvVjhmelpOMjM4UFpGaUNGL2NRR28wOHhsbnpWc1BTTU13?=
 =?utf-8?B?aTEwU0Uxb21rbkxpMUsxL3ZRcm1KdDhtSGhKaS9yZXh4cUJDYzEwV05HeGJt?=
 =?utf-8?B?RTJXL0RpZGUyMjNKaWVWZDE2U3N5MDJGMVNQNWFEZXhPTkVDVk9zcW5aVG5v?=
 =?utf-8?B?YlluZStQd1hNcGtxMVFoL1lHMmdoSmxaa0tZdFZjK29nZFNVazFIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9900fce1-9208-4ccd-a4f1-08df44278c3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 21:21:15.9609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o8/Jra7rVYwHJMEXtE8ung/ynqG540uc8NYA4ge1Gp7xBKShvPHg21qoZevvyNezyjLqNJZDMkSb9VWI50fnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 15:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] drm/amdgpu: deadlock in amdgpu_device_flush_file_entities() on
>    suspend
> - [Medium] drm/amdgpu: race in amdgpu_device_flush_file_entities()
>    before run_job()
> --
> 
> commit 2d3632cb05b8d04352d9590da3fabb5b096f1b19
> Author: Mario Limonciello <mario.limonciello@amd.com>
> 
> drm/amdgpu: drain queued scheduler jobs before suspend
> 
> This commit adds amdgpu_device_flush_file_entities() to flush the context
> and VM scheduler entities of all open DRM files during
> amdgpu_device_suspend() before evicting resources.
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 19a566187dfb5..d18348116d3f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>   	}
>>   }
>>   
>> +/**
>> + * amdgpu_device_flush_file_entities - drain scheduler entities of open files
>> + * @adev: amdgpu device object
>> + *
>> + * Wait for the scheduler entities owned by all open files (the context
>> + * entities used for command submission and the VM entities used for page
>> + * table updates) to run out of queued jobs, so that nothing can slip into
>> + * the rings after the hardware fences were waited on at suspend time.
>> + */
>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device *adev)
>> +{
>> +	struct drm_device *ddev = adev_to_drm(adev);
>> +	struct drm_file *file;
>> +
>> +	guard(mutex)(&ddev->filelist_mutex);
>> +	list_for_each_entry(file, &ddev->filelist, lhead) {
>> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
>> +
>> +		amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>> +					    MAX_SCHEDULE_TIMEOUT);
>> +		amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>> +	}
>> +}
> 
> [Severity: Medium]
> Can drm_sched_entity_flush() return while the scheduler worker is still in
> the middle of popping a job and before sched->ops->run_job() has emitted its
> hardware fence?
> 
> CPU0 (submit_wq)                  CPU1 (suspend)
> drm_sched_run_job_work()
>    drm_sched_entity_pop_job()
>      spsc_queue_pop(&entity->job_queue)
>      drm_sched_rq_pop_entity(entity)
>                                    amdgpu_device_suspend()
>                                      amdgpu_device_flush_file_entities()
>                                        ...
>                                          drm_sched_entity_flush()
>                                            drm_sched_entity_is_idle() == true
>                                      amdgpu_device_evict_resources()
>                                      amdgpu_fence_driver_hw_fini()
>                                        amdgpu_fence_wait_empty()
>    sched->ops->run_job(sched_job)
>      amdgpu_job_run()
>        amdgpu_ib_schedule()
>          amdgpu_fence_emit()
>          amdgpu_ring_commit()  <-- ring written after fence wait
>    complete_all(&entity->entity_idle)
> 
> drm_sched_entity_is_idle() reports the entity idle as soon as
> spsc_queue_pop() empties entity->job_queue, before drm_sched_run_job_work()
> calls sched->ops->run_job() and complete_all(&entity->entity_idle).  On APUs
> such as Picasso where amdgpu_device_evict_resources() returns immediately
> during S3 suspend, amdgpu_fence_driver_hw_fini() can finish waiting on the
> ring before the popped job emits its fence and commits the ring write
> pointer, leaving the ring hang on resume window open.
> 
>> +
>>   /**
>>    * amdgpu_device_suspend - initiate device suspend
>>    *
>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>   	if (r)
>>   		goto unwind_ip_phase1;
>>   
>> +	amdgpu_device_flush_file_entities(adev);
> 
> [Severity: High]
> Can calling amdgpu_device_flush_file_entities() here deadlock runtime or
> system suspend when an entity has a job waiting on an unsignaled dependency?
> 
> drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_flush() {
> 	...
> 	if (current->flags & PF_EXITING) {
> 		if (timeout)
> 			ret = wait_event_timeout(
> 					sched->job_scheduled,
> 					drm_sched_entity_is_idle(entity),
> 					timeout);
> 	} else {
> 		wait_event_killable(sched->job_scheduled,
> 				    drm_sched_entity_is_idle(entity));
> 	}
> 	...
> }
> 
> Because the suspend task or runtime PM worker does not have PF_EXITING set,
> drm_sched_entity_flush() ignores the timeout and sleeps indefinitely in
> wait_event_killable() while holding ddev->filelist_mutex.
> 
> In amdgpu_cs_ioctl(), a runtime PM reference is only held during the ioctl
> itself, and per-job runtime PM references are only taken in
> amdgpu_fence_emit() when a job reaches run_job().  If a client submits a job
> with an unsignaled syncobj dependency, runtime autosuspend can enter
> amdgpu_pmops_runtime_suspend() -> amdgpu_device_suspend() and block in
> amdgpu_device_flush_file_entities() while the device status is
> RPM_SUSPENDING.  When another thread or process then calls amdgpu_cs_ioctl()
> to submit the work that would signal that syncobj, its runtime PM resume
> waits for RPM_SUSPENDING to complete, deadlocking both tasks.
> 
> Killing the process owning the blocked entity does not break the wait
> either: amdgpu_flush() times out after 2 seconds and calls
> drm_sched_entity_kill(), which drains the entity without waking
> sched->job_scheduled, and the exiting task then blocks on
> ddev->filelist_mutex in drm_close_helper().  During system suspend,
> amdgpu_userq_suspend() also runs right before
> amdgpu_device_flush_file_entities() and unmaps usermode queues while
> userspace is already frozen, so any entity job waiting on a usermode queue
> or userspace fence can never make progress.
> 

I'd say that these findings both look real and this being able to 
potentially deadlock the system means it's not the right solution.

How about instead we stop schedulers with drm_sched_wqueue_stop() on 
each of the rings?  Restart then in any unwind and resume paths.  That's 
kinda like how SDMA already works from what I can tell.
