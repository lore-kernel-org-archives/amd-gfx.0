Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABE7CD98EC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 01:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6158910ED54;
	Wed, 17 Jun 2026 01:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OKrwI/Hv";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194CC10ED54
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 01:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIdO+ZnzFOws0JpApVeKOjif+q2fNhEoRXDZ4mhbzADHr6jXCYIeQpsQ9UN1Ja+IQzsQSzxBgHKA1GxOVPemjpMwyiqaXHmTkhBvn4O6zSGNRodn/K7/8iYG7QN/GnePEjByI9Oi1H+Ddi205opQUrizoPmIDbVEP7vxwhWzGC4OBtG/VEpxRoG1jYh+ejw1r/Pg/Z++Z5YdMoDi81YfikTYff/ZQERdRuJX5Fx9PTEMSsl67OM1XuvOtnb3Yl1iZmqYn44CGm76FzvbJHgyFM1FKjkzPx0qoihFuRAGsYSoIOJ397fAoURR+4lBZkrJXYpoJaOJcO1W702jn4EZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8KXK0XkksBMfyAgZMVnBZezobIxn7JlKzYdr6GUh8A=;
 b=LzhSpzgWYRoDNJWdTLgY4DqH1WHuqZg4KqwpIFmDxOyplOquVS8Yp3tn2KP45ggYbCz7F1m4ovqCrraX5cJitG2oLbajipiRxQ+F1YzQyxcB3k95NIv3TsbKHOlsABzciB44R6ute0Qi/6aMJmgepITAZ6H6gFF2yVzdAUjAOsyDqi8ETU19922Ri4mnXifmr5cpqBxvvv/BgCa8j9yDncgsjtyLkp7xLu7auJyEmfv9IKIGbP7fGnoo7dR/sdK7eGzh3/p6tDFMo8hVqdlemuWBOouEUG5TqM4Do491AeFcSiY/SRQbmh9l6y/Ol4f4dY9S9QhwKUbGwnfP38jhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8KXK0XkksBMfyAgZMVnBZezobIxn7JlKzYdr6GUh8A=;
 b=OKrwI/HvMmt4aJpfRyXnk2yO1jQasNNUBMsMxit5BTrAX1AebJQEgFybPKGsttgBEy6Py8y9ZLDMeTIskAGECenuKftvk4CRKyjGDBHaJL/TMwgMQVWTLLjuF2yrNOUu4UTx7Z7Zuc1ixeCtnjz9GVtcRuf+RvZLBIJpK8xTYeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 01:20:21 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 01:20:21 +0000
Message-ID: <8a7cad5b-4833-491e-8d61-08a646edeeab@amd.com>
Date: Tue, 16 Jun 2026 21:20:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Signal GPU_RESET EVENTFD notifications
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-6-srinivasan.shanmugam@amd.com>
 <7efa87f8-1b82-426b-9570-84012b1fb660@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <7efa87f8-1b82-426b-9570-84012b1fb660@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::15) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 019169b4-053d-4e46-974f-08decc0e9998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: U69qax8+A6qts6+3pxKeDA8zXbBntSxl+Qctvda9NKzFxOSpOzTdLovvwV+a2Ix4114X4dWg5y/mmYi9JxE2MixXCbjdSjHyUctxvQZSJ6+I1WxJ7J9KB6fwi5YfzvyaOErg0NdMch/qNsL/ocbEerIy5BWiVynjj5eoq20R/a3GZRjPBvoy+U+YMISbSIp6lmpnrhBjjMKiyUnhf0+y+jy/w+eiV9XPcxjgyWxLzsccUCbwd0jZD7HpvmjgtwyVIY45JsVOzGgF1/J8hCX7aFh4JNS+NfQrU0kil4ryb2tEXS6BlCeC7a6v/ejkrnz4kfAERGEAnaVcX0wGx7Eqgg8LXvwAnTb93k3deSfhd54rgRn1tIfY3zCAfyLBY3619cshc+FTfvzA//Rgp0m6QsqIQGpLrV+9t177Opz8hR1aLS1Qsczhsl8nYeppzaYxJPKOdkiV/vMvWZWVG/CGpF+kAetjpWkB8TXXWfHecHlT17iGGcDOQFmAwc8qgVVsKXdQBZJCA+4gZTM7qJkfVJj7Q//yGCTZ0xyoWy7WrU+CveoMTLgr/+zZA/LNFolF6s0Niorm2xNzTklhzX+RYfBSK9Bp2siOgq+CkZeb/M2qrqXMrBwtly3+HkuFJLiGgFPEtH/mWYf+nL+iZcz+jrYW60KljrjaPl20PFwITuCqSDI7HXRgEUXmyDvmWTpR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhRWVhxbitHU25kZGpLYVVXR21FZmxWTmJMZnJ6b2I5VWVVb2I2K0pva3N5?=
 =?utf-8?B?UDZ0T1VCbFlDeWZ0UkQwNUVlQm1GSDRNSlozMURIN1oxN1B5UE1WTHFXYkZu?=
 =?utf-8?B?T1VmRUNjTDkwbzJHZnk5V3F0aXA2aW5yVEMrczA3b3FXSFkxWnFBalRpaUo1?=
 =?utf-8?B?ZFQ3dG9MTW5MbVVncDB3ZE5jMzFpeE5EVG1oSkhabHpIRkgrUTZidEZucnRU?=
 =?utf-8?B?amhJeU55UjNWajFuL2kwdHdhMDlyMEpWbjRQWWdJdmRwWGFiTlBnZmpKWkI5?=
 =?utf-8?B?YmtSRnU5bXNIelJJeXNINWJTQnNQajk3NnRCa2VOWk9CZjZUWkIya0NJWVhw?=
 =?utf-8?B?YzVXOFFZby9RU21WRXN1WmRTUC9hV09wb1BRZTkxV2xpUHh0aFhDdTJBNE4r?=
 =?utf-8?B?b1JjR1cxUWlYbzVRWHZLN3g4RUU2ZTdTeFZXWDJJcXBrSjhkZE1aTlJPS3Ux?=
 =?utf-8?B?YnRIRHRQUHNGYVo2dUJIdHpacnQ4WTJudnBON3pqeE9MWFVidk5VQnFkdlR3?=
 =?utf-8?B?TVREdU5tY0F5UHZrbFhjR3hBTWNHTG1RUElvQzFkUXpSTEdicVUydDErSSs5?=
 =?utf-8?B?cE9xQTRhQUdSU1EyWjM1UjlSN2w0TDdJd0dYSk1CcXA5dk4xamlZMGRPUU1N?=
 =?utf-8?B?Q1dlKzlaSGRQZlJzNUFMd1NZUnhtdjdKRjJJdmVKdjNkQTRGcnNjWGhSZnh0?=
 =?utf-8?B?czhtUDd2WS85dVZNZVJPbE8vb3JINDNZNWVoT3poRUExZGJFcUhjR0RUYWp4?=
 =?utf-8?B?UE9iZzVEcEdTemtTVmJlTko2M3Y0S1hLN3ljOVgyMFdZclhJVHQ1NEg2MW82?=
 =?utf-8?B?cWdydGNxbTdmOG1UUnBYWGpXNFZ6UXJWQmZYSmZ3N0xCdlNndEp2dnpMUk11?=
 =?utf-8?B?YnUyWUF1UHBpK1Bob2VleTBucWRuOTQ4Tmx5QTJnSUVaand6WStJSEN1cjlW?=
 =?utf-8?B?OXRTdHBmc0M4cm5KNHd6RHM0dzFYbGFTM0xZKy9PWGpTelJqNld5V1Axc0hn?=
 =?utf-8?B?bGlYTWJYdFp0cTR5ZTQ5UjVtVlk0V0svbjcyNnJRd1phU3Z3NUlib3FpMUhv?=
 =?utf-8?B?L2d1YTc3RWJTSkFYb1NtcnprQ2NSbXRMOXdySGdIbGQ5S1IrUm1hL1FWOWFR?=
 =?utf-8?B?NXR4Uzk1aXo0N2hTWVZnWFJVcTVRSmVjVHZmRHJqcENzTTJiR2s3MmIrbG1W?=
 =?utf-8?B?ZnRIOWowbytFaUZPTlk5cnRCVExmWjlUQzFVcFNRRTNUd1l0bkVHZUZ5ZjlL?=
 =?utf-8?B?b2RHMDBPMFVqc1pmZGcxUHgzQ2FtS0JFM2habUVLNzZPQ0psa1JDQXhrVUdW?=
 =?utf-8?B?cW5naHVzVGd3bG5yN2FjL09TZEZ3YVVQSkVGVTNMMjUyU0M5a1RGYzJ2dXo0?=
 =?utf-8?B?dFJya212WEtYbGNZdXR0MHdSdjcwSjRDbGpBYkYyYVdKb3dJQmgwS2NUQnZO?=
 =?utf-8?B?a2NaZHlydVNWa29KeFNzWFd2SWYreXB5Mk5BY3h1eWt3TjZqcnA2c05tbCs2?=
 =?utf-8?B?MWdMcXJPUGxWYmhtOVMrdmpYL1dNVUhreFBNbmx1L0x0eHZJT1ZzYkVBS0sv?=
 =?utf-8?B?czdScVdXZHZ4VDlZMlNMYmtTSURuKzNWYjhCb0p4M0ZuaTh0Und1a0VCQW9a?=
 =?utf-8?B?MVRRNTNZQjBtV0k0N0R5QUJxL2srOEw4b2t0THVCcVAzdzlPRHpUemtlWDFS?=
 =?utf-8?B?b3UrRVlHdzVOVFowcUN6cEFjZHVNb1Q2MVJva0tIcVlhVWJ6OEZFU0Q2YmFh?=
 =?utf-8?B?Qy9UaEl2c3daNEo2a2JFUWppcUZxUG9LK1Zpa3l4U3FSVktaWUMzR045QTJO?=
 =?utf-8?B?czlvZnF0TmNjRXZwRkpZSTNGK2plYUxEVUJUQlVobkFsd1BtRjJTZDE4SXpw?=
 =?utf-8?B?NGpCYXFHL3hTUGF0UGRCT05STW00VDV1WHJBcFd3WUJUeDlaTWdLb0tEWFNU?=
 =?utf-8?B?VW12dmVEbU5IbTR5VDI5dDZrRjBqcktIbHgvZUN3bkZtTXZLMGZYTHFkVEFT?=
 =?utf-8?B?bWdLZDV2TDBjbHRMV2RCTTdydC9BQzdLWHpoandLYkpEVk85bU94RXduc0ZE?=
 =?utf-8?B?aUhmbkdmVGFTeW9nZXNKcnVSaHdQbEZWa2tGa0VZK3BQZVBQOHlRUmZESmg1?=
 =?utf-8?B?NEpaY1NSSXVUNlg0Wk5maDkvZkVmaGNCVVBlbUJlbXI0V2tyVnc1REYyN1Mz?=
 =?utf-8?B?UVN4Q0dxSE1hZ0g0cXdYRGJpczFCTUJaWDBFeEdMVHNXMnpmQmd3QnlsRE9u?=
 =?utf-8?B?VkIyakkxcjhjUGpYdENqbGpINmthM1ExUWREU09nblE0RVAzTTNkWUxBZlBo?=
 =?utf-8?B?NnNHSXpYUGVjd2RwNVRtV0NzRnVZbWJrTEQ4UUJ5L21iVDh5U09yUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019169b4-053d-4e46-974f-08decc0e9998
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 01:20:21.3347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe0W5J3G1s03Y8mvin4Rd2svdiAQVRuZyUifeI/uQTfpenp2vu2HG3qH/TRC4dpHest3L2eEzKZaM1H5DC4ltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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


On 2026-06-16 05:09, Christian König wrote:
>
> On 6/12/26 07:52, Srinivasan Shanmugam wrote:
>> Signal GPU_RESET EVENTFD subscriptions from the GPU recovery path.
>>
>> The GPU recovery flow already determines when a device reset has
>> completed successfully. Use that point to wake up matching EVENTFD
>> subscribers.
>>
>> GPU_RESET is a device-scoped event, so no queue object is used.  All
>> processes that subscribed to GPU_RESET on the device are notified.
>>
>> EVENTFD remains notification-only.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e46cdd6ecd42..8f28716912c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5694,6 +5694,32 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
>>  	return r;
>>  }
>>  
>> +/*
>> + * Signal GPU_RESET EVENTFD subscriptions for all open DRM files.
>> + *
>> + * GPU reset is a device-wide event rather than being associated with a
>> + * specific user queue. Notify every process that subscribed to the
>> + * GPU_RESET event on this device.
>> + */
>> +static void amdgpu_device_eventfd_signal_gpu_reset(struct amdgpu_device *adev)
>> +{
>> +	struct drm_device *ddev = adev_to_drm(adev);
>> +	struct drm_file *file;
>> +
>> +	mutex_lock(&ddev->filelist_mutex);
> Please double check what other locks can be held under the ddev->filelist_mutex.
>
> @Vitaly do we have ddev->filelist_mutex in our lockdep handling already? I don't think so, if no could we add it?
Hi Christian,

No, ddev->filelist_mutex was not in our lockdep annotations. The previous
hierarchy covered 9 lock levels (userq_sch_mutex through mmio_idx_lock) but
filelist_mutex was not among them.

I checked the existing filelist_mutex usage in amdgpu:
- amdgpu_gem_force_release(): takes filelist_mutex -> file->table_lock
- debugfs gem_info: takes filelist_mutex, reads BO info
- debugfs vm_info: takes filelist_mutex -> amdgpu_bo_reserve() (dma_resv)

None of these hold reset_domain->sem, so the ordering in Srini's patch
(reset_domain->sem -> filelist_mutex) does not conflict with existing code.

I have added filelist_mutex to the lockdep annotations as level 7 (inner to
reset_lock, outer to srbm_mutex). The updated hierarchy is now 10 levels:

 1. userq_sch_mutex     - Global userq scheduler
 2. userq_mutex         - Per-context userq
 3. notifier_lock       - MMU notifier
 4. vram_lock           - VRAM allocator
 5. reset_domain->sem   - GPU reset synchronization
 6. reset_lock          - Reset control
 7. filelist_mutex      - DRM file list iteration (NEW)
 8. srbm_mutex          - SRBM register access
 9. grbm_idx_mutex      - GRBM index access
10. mmio_idx_lock       - MMIO index (spinlock, innermost)

The patch compiles cleanly and is on branch lockdep_task (commit 627073ba8951).

Thanks,
Vitaly
> Thanks in advance,
> Christian.
>
>> +
>> +	list_for_each_entry(file, &ddev->filelist, lhead) {
>> +		struct amdgpu_fpriv *fpriv = file->driver_priv;
>> +
>> +		if (fpriv)
>> +			amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
>> +					      DRM_AMDGPU_EVENT_TYPE_GPU_RESET,
>> +					      NULL);
>> +	}
>> +
>> +	mutex_unlock(&ddev->filelist_mutex);
>> +}
>> +
>>  static int amdgpu_device_sched_resume(struct list_head *device_list,
>>  			      struct amdgpu_reset_context *reset_context,
>>  			      bool   job_signaled)
>> @@ -5738,6 +5764,9 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
>>  		} else {
>>  			dev_info(tmp_adev->dev, "GPU reset(%d) succeeded!\n",
>>  				 atomic_read(&tmp_adev->gpu_reset_counter));
>> +
>> +			amdgpu_device_eventfd_signal_gpu_reset(tmp_adev);
>> +
>>  			if (amdgpu_acpi_smart_shift_update(tmp_adev,
>>  							   AMDGPU_SS_DEV_D0))
>>  				dev_warn(tmp_adev->dev,
>> @@ -5775,7 +5804,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
>>  	}
>>  }
>>  
>> -
>>  /**
>>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>   *
