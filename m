Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E6606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SU8gDOee
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6500710E5E9;
	Wed, 28 Oct 2026 09:32:18 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF8610E5E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg8l4xF8M7i1KjZ1kfBJK8V28WwzglYVlAFL89MRYXIRwqQ4G23jqYGxIeMoLueITcBNyCV9mDyrM4Hh6oV0njmRvU4lLSTVV6sqBnMqmHs87zMxeX1zEfzwQHfgP53eZ9zp7UDBGpSoug5YE8O+erLlYZ9uxnX6OGvFwFD5dsKKTKG5YVvPV4L2Q811caCHMfcfRMzkdiU8flct3A4FibiBmO5MYauxIn+aKEow7HGI+tXWj0p6gPg3pWcfIN+1xus8q8AY+ngnt6wfFPmpwIvZHcO+HukfXyTPL3hOSgK5XQrokN4gJKdkjbTw4uP6B+vrWgx9q8K+i8fYdXztpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4THzVkL1bBPlDBXGwjIMrn8JtrlNrowclZYSA0E7Mkw=;
 b=QKtCYKANcQOrYqzmrh5j0v5aC7a3+GMtBOM/jd+Vd1qFqs3yDhsfosUkBz/iyX/VGgqUzl6DqlHRTu7XShe0gIAsNuoFHgfsv7X/ONR58TCAqm8ac6AOpHJUXKzB3v/RsoZmc736AKiCKpA2sjhaTmEy1c6iqNWY7+ac6V1nstb+5xg1n3ajm4I+MJLeqAcBornpkdgimrNXzHeBzfMHloEI1IBD/QQ8V/nqvidiBKBOi7zXhp23iD3RHr2GQN6q0rhNqo/adQrm5Yh/k87yWeEm8EM7xlX421bX8uL61cXGUpwDVKgKOQgcjJV2svwr8RsFVJ8YWfBcwA8lkbldkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4THzVkL1bBPlDBXGwjIMrn8JtrlNrowclZYSA0E7Mkw=;
 b=SU8gDOeeezXuJdI+Zs/gFsMbFOEC/8vGb6+29Tx8AMqDb8+gEVEL0sKrtoEF3wZys5qUsZ5mzPSJEYX1BnmkrUuHx18SsxfJJsSv7BXKRm4cfAOMW34u86C05A6UOpoikGBcWjOcUEC0qgpDebCXLH6j23riMDpkoOYbnhjIG5Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 09:32:09 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:32:08 +0000
Message-ID: <1ebbea91-2ef5-43d0-896f-2d132b9219b0@amd.com>
Date: Wed, 28 Oct 2026 15:02:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
 restarting schedulers
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-2-Prike.Liang@amd.com>
 <f07784fd-26e6-44fb-8558-da0638ceb11a@amd.com>
 <PH7PR12MB60006DA49574AC938D7E2D1EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB60006DA49574AC938D7E2D1EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0238.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a8a7f6-c450-421d-2cea-08df34d6564b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|261022075727099003|261021123027099003|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Uewpc7ahLJviQtZ6oeAir9goxyIhFGewV3soRZxFzVc25auJsB2s227LdpNVEL1SgI2TgruVfua5kFXMAWmXDuYStOHZLRAchEBaNsVOMjACK5pAPXFA/Fg3TiEt5f23122ySBlkfntpYn0JaU2izGtSGwb0p6SHDcyexypHL0i181pHkX9j/Vgb45s0x4CNay6L6oGP64QQhuc3JYplIo5QsmV4Mwv06LWRRHwuMEuxrZ5C5yqBLW5d8y+MRqr+ZUPruzdhclEgvuYvDKKW1G7MtZ8i7YaxuQzgopDAZLIXvgcm/SoQwO5h5c83bVgGDNvEZpfob07IYjKijyl/00bt3T0UjawJzM/vJS9G3ybBRsYwbAWUsepuWPLjwpQTXyJid+C41hvuI1t2Qku3T93PHpyvh5NsRkSnA9lt6/JGC7DlHYmtHLaa8A5Qq+ntBGKl/GOBDbpBxaGewkykWfZeUOZWMsqG41Fb+XTkZViWf6oCX3eiTsJudQ0GTneiNm52v0fU3z1ox4q/VWQawppwh78WLVcy1287zLOCEO12qrScFC4Ydfap8ZRNvAoulLGVD0hZYe7K9whMrCjDEGcYjEJS7SpZ9vjWhq9AuhPlL/4IVNlPiup5QFz2ezVXLRIRVe4y8ap2EjQP98TMMFF3jZ4d1p8Oj+AsEXu5JlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(261022075727099003)(261021123027099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjdnMmZwOTNpTXB2dWdjeFhhR0hyOVFlZFo4V0R0TC9IM3hNTDBrTzNmMTJh?=
 =?utf-8?B?eWVvQVdaU0RYOVFqeU5zYkxTSUN6TnM3dUIwL0p6S0pXeGRZSXpSVlI4SVc1?=
 =?utf-8?B?bXU2TjNJN0lJZFJxc1hjV1RCTktSOXZPUUFqdUFSWWc3ZmY2TEhNYXVoblFp?=
 =?utf-8?B?Sk1HdkVtQVdOQStQMUZxRk1rYzg2UE1NbzBkRHRWNVhQVUY5QkwrQXJpOWV5?=
 =?utf-8?B?UUVoTlRjd1hsTHFuWTdQNnpDWnIrZXpPOUYwM1ZGRDVYUTNHQ0o2c2UydGRm?=
 =?utf-8?B?OHlaWUlVMXNuSFdzMStTZlN5dnJLaFdwRmFJQ0JGcjN4REE0eUhPcGdhVk8r?=
 =?utf-8?B?SDRoZUpqVnpNVjIxM2E5WVNodmF6SzgxQ3Y1YXhVSGFUdUhQWXladUo0czFj?=
 =?utf-8?B?R21qcXlXTmhCQ2dUM1RONksxU09pSnJhSm9YS1FNQXhadVhxOFExRkxQczd4?=
 =?utf-8?B?MHk2SDdNMWd1aXJnODZRYkJ3Qjl6bTc2VHVPQ3ltZTZTYkd6QUpuM0FONE9k?=
 =?utf-8?B?Y0Zuc2JBdzJNemphb0dhWUVWYjVIeDUzZzFYbEVZaERqYzR2TGR4TXhKL0Z2?=
 =?utf-8?B?eFJpNWdkeDViK0hmYUcvSFh2Ujlmd0hmTHN2b1BsNmExYmRvaXlEbmRSQnk0?=
 =?utf-8?B?SDRWeDh5YmxYR21jbzM0VTFBWGU4SmhDTk1PeWc5elU4OS8rQlg3UXozR1hl?=
 =?utf-8?B?WS9ya0YxenE5SHduUTI5bU5wQ1M4ZGRxOWU0TGhTS2VmVWRvSGlxS0xDbHMx?=
 =?utf-8?B?OGV5cFlYQUN3Q2cvUUVWN1RzMmtPTTRCWUltZk9KSURJU1NBejF2bEhzb1l1?=
 =?utf-8?B?TjQ4cUpNbDhYbW5tQW5MdUdNVHo1U0xGZjVIOUdPUVc5YnNTQndqdVQwK3Jz?=
 =?utf-8?B?bXFoRjRxQlhwQmhpUXg1OXhlTHplNERaMUpGeWlvU0cxZWtNTUJQZ3cybGdK?=
 =?utf-8?B?dU8rM3daUWQ3TlNySlYrbzcrR1NuZjBFN3JZcGYvcWRzTnZWcERBWEtKRWh0?=
 =?utf-8?B?d1NnUUI2ZmhTK1NCTklVVDFjQmQzRUp0Y1Nvem9mWng0ZS9TemhSSytPRnFx?=
 =?utf-8?B?Q3YwWGY1Ym40WmNWZVhvNktRdEVwczBQZDZ6V29CM1RIVjU1b3djWDQ4RU0x?=
 =?utf-8?B?TjcvVU1xZkxiSlZLWHgwNDZzTDJkUVBRVS8rM0hVWTlBTklMVHl6dWtBdTAw?=
 =?utf-8?B?MkEwMkM0Z0NSQVFHbWlpSFYzY3hDN1gvWVRObXhNQ2Zyb1RKT25NZTFsc1h6?=
 =?utf-8?B?b2RoSTRrc0dZcWl1UEcycUxJN1ZyMklPcnl5QVlmOGdvY3BCL2FDb3NOb3Bj?=
 =?utf-8?B?OEN2WHpwRG9iOGRpQmVWNWlxSjRLU0IrSU1TcWhOQXRwRG96RFVjcWtyeWc0?=
 =?utf-8?B?bmMrMkFmVlhvM0pZVVJXcE9pK3lNZlhwVzExaFlnVUREbWxRU2JiMm1Lcnln?=
 =?utf-8?B?OGUxcGRPZFBiRkdKMnlNcll0ZytEdE9KWm40NGdtZ0VRaGc3alZLNGliSnpE?=
 =?utf-8?B?OURCaU83RCtDcHFkZGt5ancyQXFDend3TUdxYlROdkFrM2RiaGhkVTBGaktm?=
 =?utf-8?B?QkgvaGlESDV2Qm5nbEVYdmJkOWhrWEhKUmFac2RnME5abzFaQUhMUlZEWko5?=
 =?utf-8?B?UXFScjVHSlVtRGR3cVZuakVYcWJuMzBOanpRZHczeTZmUUZZcU9CY0NEWnZr?=
 =?utf-8?B?N1ZUOWJINVpTVkJiMk9wQWF0WDBzMEc3TnZhOUc4b3RmZWZlVytZTHYwenJJ?=
 =?utf-8?B?bWo0VVMzZzdCNHZLQ3AvajdQSW8xVkV3MFBhTWhpdXcxb2RoMnNEWmFhY1Y2?=
 =?utf-8?B?VyttTWVRTSswVzQrTlc5Ym5nY1ZXazVsRGxEbzRPVFlQY3ZuTVlIdFNtWDR4?=
 =?utf-8?B?QjR3Ulc3S1JtMTJoaXVocFpRdFdmbkFxby9ydjd0TWxjQUcyeXZoT29POVc2?=
 =?utf-8?B?aXVjRVBDcS8zbVhYQll3YlVSN3g0aDhSVjZkbWhhY2x5UXZMV1VOZTkweWdk?=
 =?utf-8?B?bzJqNE1rbkM0U3VjQkdSK0VzNFFGWDNjcEhhZERaUHdrOUFqY2ltVndRVkpP?=
 =?utf-8?B?WDVjc042NFBITVZ6M3hGUG1mYndmOW9UUng5eVA2TDlGRE1FOWJPR3kvR1Fn?=
 =?utf-8?B?UFY5RVdVZjA0NitVSFBWYzBzL0VBbUs4ekRPSW1PTDIvWDI3bDdnYWRTb0hD?=
 =?utf-8?B?WUZ0eVdDR2JOWHRFdFl4b2pnMzRvemEyWjl2b2ZjWVBiMFVTT0IwcmVSY3p4?=
 =?utf-8?B?bHppMFQ1R3VPS294THlVZzJxTmdaclFKOTVYQk5ReXg4djd4NGtZb2tWYkhC?=
 =?utf-8?Q?DTBGYb+8j5aIpCH17D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a8a7f6-c450-421d-2cea-08df34d6564b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:32:08.8581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71S+G/L/S0tRb3mQefFOO++YfgrjCK49yMcWDLtUU2NpPMw7+cUX7E4ndr5Ur8RA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 26-Oct-26 8:43 AM, Liang, Prike wrote:
> AMD General
> 
> Regards,
>        Prike
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, October 23, 2026 5:14 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amdgpu: finish GPU recovery callbacks before
>> restarting schedulers
>>
>>
>>
>> On 23-Oct-26 2:04 PM, Prike Liang wrote:
>>> Run GPU post-reset callbacks, including KFD and display-audio resume,
>>> before restarting DRM scheduler workqueues. IP hardware initialization
>>> already happens inside ASIC recovery; this change orders the remaining
>>> callbacks before new scheduler submissions. Preserve the
>>> emergency-stop and guity job completition path's callbacks without
>>> starting schedulers,
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++------
>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 406c5f2fbee1..20f02dd14c41 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5816,8 +5816,10 @@ int amdgpu_device_gpu_recover(struct
>>> amdgpu_device *adev,
>>>
>>>      amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>>>                                    hive, need_emergency_restart);
>>> -   if (need_emergency_restart)
>>> -           goto skip_sched_resume;
>>> +   if (need_emergency_restart) {
>>> +           amdgpu_device_gpu_resume(adev, &device_list,
>> need_emergency_restart);
>>> +           goto reset_unlock;
>>> +   }
>>
>> Does this reordering indirectly affect any ttm memory management funcs
>> (sdma) that may be required during KFD resume sequence?
> 
> amdgpu_device_gpu_resume() doesn't submit or wait for any TTM or other DRM
> scheduler job. This change keeps the DRM schedulers stopped until all the
> hardware has fully resumed, since jobs running earlier could access
> hardware blocks that aren't ready yet and fault.
> 
> Thanks,
> Prike
> 

Thanks Prike. As ttm mman jobs could get canceled for vram lost reset 
cases, it looks fine.

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


>> Thanks,
>> Lijo
>>
>>>      /*
>>>       * Must check guilty signal here since after this point all old
>>>       * HW fences are force signaled.
>>> @@ -5827,18 +5829,17 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>>      if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
>>>              job_signaled = true;
>>>              dev_info(adev->dev, "Guilty job already signaled, skipping HW
>> reset");
>>> -           goto skip_hw_reset;
>>> +           goto post_resume;
>>>      }
>>>
>>>      r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
>>>      if (r)
>>>              goto reset_unlock;
>>> -skip_hw_reset:
>>> +post_resume:
>>> +   amdgpu_device_gpu_resume(adev, &device_list,
>>> +need_emergency_restart);
>>>      r = amdgpu_device_sched_resume(&device_list, reset_context,
>> job_signaled);
>>>      if (r)
>>>              goto reset_unlock;
>>> -skip_sched_resume:
>>> -   amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
>>>    reset_unlock:
>>>      amdgpu_device_recovery_put_reset_lock(adev, &device_list);
>>>      amdgpu_ras_post_reset(adev, &device_list);
> 

