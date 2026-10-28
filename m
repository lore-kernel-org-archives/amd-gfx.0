Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A976606A323
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gZGSnkpa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B5910E5A3;
	Wed, 28 Oct 2026 09:35:05 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3BC10E5A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyWIgDTh4bY5EB32enwa9C17Sn72lh8MtcWEQ3ZS+JUr3uYlLqWqfrkmtMAguJlGeuVNFIZ4U/Vh1HDSXu6Igu/JdtlfGtz1S4e0vI0Ul+2YAMp61JXyrRLna8XQ3fioAK8XwqAx2MpQoGpGBdUx/GE3CxGMQuLQTKilmDaZzoAF6l8YYI49H15E1EkZZmMHwolihsDzvv8mvZ26EmBJfScF0gt2w9ZL8bZ+oKAnjes5tXtThLUYXwXEDS3hdqqTo4yXIlyNVBVfgSjHjwEAgLDljcBxhyDvUSSQshqeznaIUCQDfpTGAD3fqlx+s53yiO8Arp/hxzZEqjBrsgMT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0Gxi66WNHnU8BwUOIK9Aqvlx5uAbdZP0goZVywdyUU=;
 b=SeBw45D5hrpWd6F4qbZqN42DbsLuXLl1aI/hdg7NQDCf68/rwW5T+mvglkK2oOaQWieyJsuYTM09Z9Di+d5SBMMQDYwbMyzwqDjVfU+KINB3KdOoT8DdsskN33crWDcDKuwAfvH6hyC0uJSdVTl3NDCDF/M16m1/1ND8hCYHU5tpbY0iA5OssKDRtmLTJWtLfHyizjoaZFMNDw5Jh5upwrRiDvOOmxznFiMzeXUYIjIuzsLI+KrMnSNEsFaoRuMb0kEcsBcwwCVg4Adan2GsJwBr/cZpWdBW/k6U/vQMs/+kzUO9rBRwtHh8UdOTg+1yCjdxB8g513ELbnAbZMFdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Gxi66WNHnU8BwUOIK9Aqvlx5uAbdZP0goZVywdyUU=;
 b=gZGSnkpasWvOhIeLAQSp5QDJ2XhE2OM1aPF/oHz8l1oje48J7kQ/1qt3lOFl2HaJ8q2mNseAnzTjd58q05ZksQ6xPZeeBd1TRbZBsEwxnTxRSNh4O6fe1yIP41YxGwFk846TErVuRSSY0loc+Y7n+jmKdJvZXnLZ4pem3wM4x0A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 09:34:32 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:34:32 +0000
Message-ID: <0e7ce526-4eea-4a08-8929-618bbd6f5de1@amd.com>
Date: Wed, 28 Oct 2026 15:04:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the
 GPU reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-7-Prike.Liang@amd.com>
 <6ed37c0c-eadc-406c-aeba-f86a522cf827@amd.com>
 <PH7PR12MB6000DD56C8651C335ED83A4EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB6000DD56C8651C335ED83A4EFB612@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 904ab612-e7fe-442a-53d6-08df34d6ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|261022075727099003|261021123027099003|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: v6/gjXxSZN7gbTCMnr7pr+VMQmiEY5TcukzzuPKmY0PJYCeN33Vn/1HHSgDeLR3JtwdGz5JGPfP+JVR21PCZaIaeklIKON+34uvkUW+G9L8zHrCTW8OBVk3GlK02rcvjIe7QPuZoMlLZcTnp0WLiBwPFXFXrrOPojyg2aCOo+6M0SVBuZNCgZFEddPY6kITS5Q64AMmuhBFS8mMfy7ctL/8JwCyCUNmcgVp2PVPi0uUs/PcwvGktJQvKBKrqYbL0PFkQ4uw22K6QLZf7LMnNJQNjfk5sIjbKkG0pytYyQCXFNQ8ZIj1WMAQpirhfVvZ38mOyd6efXRvVq065UkfdDYzSEMYO2jmU6md8nDbq/CVO06nlety/nBKM11F7ceu3+LAXyZkv6eRn91hW0uMTfFiaC/ZAk4/w/NclLT1eGAblKGaTNvY2j97es9iDIhEa20v1YQo+wdKMKd6WUQQWmv00LrlHxWke7/u9LBjEip5LTHwRfXosgWyDHTds9vdNGfVzzVsRyDcGUq6yNjPr671YUKxofLsUAoiVV6Z2jCw/yLz7INYHLh0k4NAfqH1pvFg27w8Ep+yZg8XRxC/hGwJwA/Ujys6LG+J4i51KbcjO1h6wVyqp+kak46pntOBnSN85BGWN1aNO+OW7pnzs4XkJWAs/R/98t52ODPh44bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(261022075727099003)(261021123027099003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0MzTTNzZmkrRDA0c05iNnA2QzNNNUFaVGl2NDlBcVN3YWR5TE9ac1MvL1VH?=
 =?utf-8?B?dVU2STlvTjRSYkR2eVc1TVVmbE5KTERPYmNvNWR0a09oS25MMXFZcXFndzFQ?=
 =?utf-8?B?YlhrNlp0enV6T3BDcVBIWlQwaFQwNDlKaGlFdko0RkRwVGdkL09GcnI1d1J0?=
 =?utf-8?B?S3ptaW80MjNDR2Q1WEplWDR4V2JsaWVBUE9JcTlDQ0Z3NG5LQ0Q2YzdEdWtV?=
 =?utf-8?B?L3hhd0ZEVXk0ZGZleFZaQjBLaUd5R0lDQ3J3L0E3aGFLV3pqRHFRTXdLa0dW?=
 =?utf-8?B?WU96MVVCQWtWTlNCeFNrdmlJdXNEV0NZRUZvajNMUG8vbUxyV3JjN1pWaktF?=
 =?utf-8?B?MFVweWFaK1pDTEpwUWR6ajJkSGREZzYybkdyVFBMUEk1RGtpeWVUTVNNSzRT?=
 =?utf-8?B?VGxibW1LOWg1SFlCKzRpRHkrOC9XeGk0NENTRGtyWUNrZ0N3OHZ3U1JVYkEz?=
 =?utf-8?B?VW81OGsveGdaakcrenhMUXBtWW5VZ0lWQWtqdGw3aUp2QzNvNnhCWXZ6NC9w?=
 =?utf-8?B?ak5Cb3pmaTVIOWtSS2ttKy9Qdk40aTIya0hTeTdtZWdVMkhBdDFnWDRzQ01r?=
 =?utf-8?B?TFpyYlB4UWRrb0FWS3cvcnA2cDFYRVZrNytsTjMram9ZelFTcXlTb2lSV1Yw?=
 =?utf-8?B?VnltbzBsbUcrSWdSdW5PcGxoOC9VU1ZWTnljSWZVc1hPeHRYcmpwSnBwNEUv?=
 =?utf-8?B?a2hscVN6UnYwN2F2Yk5nRnZaRnBBa1c4dDJTV3FjOGw0eXE4aVg4UVZQTW5h?=
 =?utf-8?B?empUVUkrdXR4YzVQOENHREdvM3pJemdHQTlPS2dqem5lZjlmazJROE9rTjVy?=
 =?utf-8?B?TDNPK2dUdnlBYXYzV1NLTGFFakxVWTRCNXExNHJheHZMWnl0aE9YWTZKVlhE?=
 =?utf-8?B?TFdkdGFsQ3NvUmZMcXBJK1I1Q2p0OVZKeUQzZFhsdmJtQWhiMDVnTEZVVnJ5?=
 =?utf-8?B?RzRCQXlMQytwT1hPazR4TEo1UzhaWHMxaERqenVIOEI1eUlNZWFCb2hKNDFm?=
 =?utf-8?B?TEtoUlRDNEc0TkovNm9qcUxiMWNHRjhSenpaRlJoQmNxU2lCNmNrR3JNSEtU?=
 =?utf-8?B?WE9FWiszS0l0QmlIVjdnZUU4VTNLaHlvdTYrcVlKR0IyUVVHZ2hxcnhIRGkz?=
 =?utf-8?B?UnVXbXdxR0JoZnFTdzZDcWxtRkxYRFdVS1RoU3hONDJkbHJ4NHB3U2ZmeDlY?=
 =?utf-8?B?YnFiM2YvbjlUelFtVkdlS1R5SEpEZXkyYVlDc2dmMHFUTkp2ODQvRDBYRDd4?=
 =?utf-8?B?US83Mmp3cEZNczdJR1gxWFFxNXZTSmtqeUVZcmdId2IvNEhpY2xkbmo3eVhQ?=
 =?utf-8?B?TTltYVFyWWM5dS95ZVY3TmRHcmJUZ0dScnhvcXVzSFIrYXpzS3ArSEdPUTlQ?=
 =?utf-8?B?Wkx5Yys3NEcxdmtzMmMxYmNVbGFzVy9ReXJCc2NQOWc5Z0xKRVU0dnJxNjdz?=
 =?utf-8?B?N1daZlV6S0Jld01BZ2Z6MWl3dCtKS1RsNHNCVkpadE9NU3E0ODRjejhaUUNW?=
 =?utf-8?B?TkMxeDhOZ2dMdXFkTHQzVnNwTTVaZ2Z5cHVmQmVUbjNza0ZmWmhVMXRyazlT?=
 =?utf-8?B?RWhnN1NxWHNZeDRaWE53LzllNy9BNzFXeHkvRHZvQlJZVGY2K0VnMC95M0Yy?=
 =?utf-8?B?VEY3d21lLzRsNzk0WDJ5dEEzcUlzR0RQT29OVnFycUhsWE9pMlRxRitCNzhV?=
 =?utf-8?B?Y1lGRWt6aE02YnVSNXJFTFNQTFhMS0x3azlJMlptSnV5dXZudkxNanBDbVBh?=
 =?utf-8?B?OXI4WTlSdVRxZk41bGNYZGU5cVBrUTJOT0V4eE9QYXF4RHZMMHdMZXZkdDAz?=
 =?utf-8?B?L0xXZklNczRMa3h3WmYybEhIOEVKMUhVN3dldE1Ta3lZMVFKUE1oK3h5cHd3?=
 =?utf-8?B?OG85eTZHYVpEYnRwdzZZNFpmNFNUWEJuQWhxejNuanZEQWFYQStSUkV5aUtY?=
 =?utf-8?B?VHBEZUpKOGJUME5mcks3QTFURmtST0FnQi8yaE9vUGhZNUluZGpwckN0ODBi?=
 =?utf-8?B?Z3hDdTRKN0V0T2daYnhCNG10OXVkTk94cW1ROGZvV1Y5QjVFRWNnbHFrY0k4?=
 =?utf-8?B?a3JNWk9XN1FwUE16bU1Vck04ejdPbXFYdEFTWlVkUTdtSDlwSmJpcVduSXRs?=
 =?utf-8?B?NXdIM1B4SUd2WjBDVU9MRkxCSWJVZlB1OUh5TEYvNFpsZnN5RDVUUnBEbCtV?=
 =?utf-8?B?bHlMaHp6cU9wRlRhckNTLzhCOG1xRTVJZnk0RElJQ0c3OG9FQjI1SnZKTEt4?=
 =?utf-8?B?WnVhNHduNlNHL2oxRFp4QjZ1eFlOZ1pBTG5XdmxmcXVlcFNUN0Q1S2Y0T3By?=
 =?utf-8?Q?hqcRKLAMhfn8Fl266l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ab612-e7fe-442a-53d6-08df34d6ab89
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:34:31.9495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dk9RKGZhWkaHhdqnBHEOFE5tGKtDMnXc2g6Dnoa6Z+A7X8byWuLRAwbcLqcEzREf
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



On 26-Oct-26 9:08 AM, Liang, Prike wrote:
> AMD General
> 
> Regards,
>        Prike
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, October 23, 2026 5:30 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH 7/8] drm/amdgpu: stop the schedulers before preparing the
>> GPU reset
>>
>>
>>
>> On 23-Oct-26 2:04 PM, Prike Liang wrote:
>>> amdgpu_device_halt_activities() only stops the ring schedulers after
>>> amdgpu_amdkfd_pre_reset() and amdgpu_userq_pre_reset(). With a hung
>>> MES every REMOVE_QUEUE in amdgpu_userq_pre_reset() waits for its
>>> timeout, so the schedulers keep pushing jobs to the hardware for
>>> seconds after the reset has started:
>>>
>>>     GPU reset begin!. Source:  6
>>>     MES failed to respond to msg=REMOVE_QUEUE fence_wait_ret=528494
>> status=0x0
>>>     WARNING: amdgpu_device.c:928 at
>> amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>>>     Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
>>>     Call Trace:
>>>      amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
>>>      sdma_v6_0_ring_set_wptr+0xa6/0x180 [amdgpu]
>>>      amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
>>>      amdgpu_ib_schedule+0x64a/0x8f0 [amdgpu]
>>>      amdgpu_job_run+0xa2/0x220 [amdgpu]
>>>      drm_sched_run_job_work+0x10c/0x300 [gpu_sched]
>>>
>>> Stop the schedulers of all devices in the reset list first. None of
>>> the preparation steps needs them, and jobs submitted meanwhile simply
>>> wait until amdgpu_device_sched_resume().
>>>
>>> Fixes: 290f46cf5726 ("drm/amdgpu: Implement user queue reset
>>> functionality")
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>
>> Same question as before - should we keep memory management related rings
>> running till user queues are stopped?
> 
> As to the gfx userq + kernel sdma then if keeping the drm scheduler and related ring keep running until stopping userq, then there will have a register accessing fault caused by the inflight submission during gpu recovery period.
> 


Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>> Thanks,
>> Lijo
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 ++++++++++++----------
>>>    1 file changed, 15 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 20f02dd14c41..08395cca18db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5534,7 +5534,21 @@ static void amdgpu_device_halt_activities(struct
>> amdgpu_device *adev,
>>>      struct amdgpu_device *tmp_adev = NULL;
>>>      int i;
>>>
>>> -   /* block all schedulers and reset given job's ring */
>>> +   /* Stop job submission first, the preparation below can take seconds */
>>> +   list_for_each_entry(tmp_adev, device_list, reset_list) {
>>> +           for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> +                   struct amdgpu_ring *ring = tmp_adev->rings[i];
>>> +
>>> +                   if (!amdgpu_ring_sched_ready(ring))
>>> +                           continue;
>>> +
>>> +                   drm_sched_wqueue_stop(&ring->sched);
>>> +
>>> +                   if (need_emergency_restart)
>>> +                           amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
>>> +           }
>>> +   }
>>> +
>>>      list_for_each_entry(tmp_adev, device_list, reset_list) {
>>>              amdgpu_device_set_mp1_state(tmp_adev);
>>>
>>> @@ -5570,18 +5584,6 @@ static void amdgpu_device_halt_activities(struct
>> amdgpu_device *adev,
>>>                      amdgpu_ras_suspend(tmp_adev);
>>>
>>>              amdgpu_userq_pre_reset(tmp_adev);
>>> -
>>> -           for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>> -                   struct amdgpu_ring *ring = tmp_adev->rings[i];
>>> -
>>> -                   if (!amdgpu_ring_sched_ready(ring))
>>> -                           continue;
>>> -
>>> -                   drm_sched_wqueue_stop(&ring->sched);
>>> -
>>> -                   if (need_emergency_restart)
>>> -                           amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
>>> -           }
>>>              atomic_inc(&tmp_adev->gpu_reset_counter);
>>>      }
>>>    }
> 

