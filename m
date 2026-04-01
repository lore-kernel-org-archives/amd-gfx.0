Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E78A10FCAC9
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 19:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38F210E55B;
	Wed,  1 Apr 2026 19:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3Db5EiB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BA810E55B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 19:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxQiYcGdA1XNCD/Iftz3UBj3O+/+bAGOFbnyp7GCQYJbDCq9PQm3ZV4XIl2BmEFfAcArby9xYyPduPjJPRTV7VWxeQPnL/EWMm6YCH61wuKZfXIM2TMQCQS2IEZxWYpBnNx/qmiwRLTwFC3lopi3VBJIQchntczoC4YHdKIBFDVEM1/cd6/52Gvxv/ZHNGzmE58lzzSnpXRtxbU/fmLebMF5ZXPOxELXqzBp721z5nkjg928d1ZPNgVdoZYF8Stx7HqAhq6MJUs9GJni1+Fm1zG7Rnjr1yPjpEx54PFTCHmgsudigB2c4QtwlP9MlIxgrsQE2nKdbiX6TH0kXeJkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwdb7mW0ReEzZY8luZmZOLzRG0Tbnv0dy6x6y57pft4=;
 b=YphrEoqFX5CLGKuR67iRfGnBA6mQVs+H59li2n6/2tOEn3pDl1IP6OTMokSnYPqRmg0IDyOf0lPuZcDYqwPcixaM7YV3nCc0dsDnJk6ThGi9hHjB7+/WRPknogBPyBv0ZSG9Sg/yPK7hk9JTvyQFRu3tQQ/aJB/wfEAk0kFGm+KkKyACRcG/Y7EKIvz395b5PAnWtXboOwGoZ+xCPnmQEbXzUfE3vTineedrE+YtPZhIb5DHBN5wOtD1TrCkxliRA5+KAzCP/yF/M3CMIg/0jZXfe6s2rJ/lBS/4dh7f77Qz3B6mq32Wvlala4yQfaT4M/mrFHlvoIrQ31ZdF+ANHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwdb7mW0ReEzZY8luZmZOLzRG0Tbnv0dy6x6y57pft4=;
 b=q3Db5EiBRH4Uy7CI6zlIv0PCb7S008TxLJXwIAKK9lXK0xRph3wjgw2/v8AknPsgT2YXnOeP/3dgt9+wXW7YahitQmu0MNIVZ6mXXMoeh7X2FuDnz/HBFLA/NWI3+IachmxYNMTbaJIpT4rXkeOSqHVaOztNZl83eq+RgD75wr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 19:20:39 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 19:20:39 +0000
Message-ID: <77094d78-2278-400d-bb20-7aaea3545222@amd.com>
Date: Wed, 1 Apr 2026 15:20:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] drm/amdgpu: Create hqd info structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Jonathan Kim <jonathan.kim@amd.com>
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
 <CADnq5_Pm1ArB7odhzTo7Ssc+BX7z0wn+AyjotWcbjmxevE8UDA@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_Pm1ArB7odhzTo7Ssc+BX7z0wn+AyjotWcbjmxevE8UDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::8) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fe0b7c-893e-4256-3b2c-08de9023c232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +e+D1O5v6JMpMGM3a3x/uDA4cmIW2uEImeTJ16HktCjiMGXDQdt7uyzY99lxyVf/StnB0UfgJ9E0h1VTHE6/KmA3e8p/yQHl7bMuQGjpQPPwoPw69wFCWlgvvGYN6/1N+iKRO+ycuHzeFV0cYfsftAyV63qqFQa+e08o5iKkOQCPee3e025lUSffKarAL/3RwCFghKL053f6Q1HPbMu6FfgROyGAuHxAxfOPFZXyrDSBgEhcqe0XtbUqRLIv2lAi6xMinA3AFZZcz9qFM1iWpHbG/BHFuHoR2vVImFHxuucFB2GJnKL2g5I9NJV2/5a7GrQ0n/Mzy8U3XjB5emmolQnsQs6UnraVGnAbyoXbSl4d/fvZMOB6+uLYWU8oD3flWbjrUcoRlV7hgThsq2KGIkqdK6efjF9CUahq6LBWV5XOxc6rrtuuxS6jAlSCOTkOqz7wgghTOIxqhCi6xJVJbE+6GPC7liuBxG5JJPf0OVAEI2tjPEVMfUWJALEJJ/tffZxibevF3ljIjjdlvKeP/OMY6QObXhU+P6r4V1x+Mv+4wuYNyB1Ewq7WmPSY0evobTMR0pqMNyoTDIeVzZppODUm7ABgdoK2JLAZnKDw83FxmFEx076utW4iCIacus1m5w2Fjt6QW36QSUvGSavIiuLKWtsY8danfPJRUxDPJQ/NqdSG/YhQMQeY1L7J0AVwRFhBNCLvYgh2q6FbKXS+YfZ9KpjvSiiNzwSww4NdZn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVM4QnBHWXlSbWhuc2VlalJDWnYvU1Y2Z0owV3FMUDZjRVMya0dDL3J5SWZY?=
 =?utf-8?B?eEI4RVJncTB6dlpUUWZtQk4vRkErTXhEWlhPNTZSK1VoY09BMXU2eWxudVpE?=
 =?utf-8?B?ZUtFV0d5L09VcVhTVGMxYWY5S1JYaUdMS3FFUnordnk2TTZaYzdnSFM0N2Yv?=
 =?utf-8?B?QTVpS3NaYit0RkhncDlXQmRLZlhVUWkvWWNvWXNzV2R0MGw5RmZWRkFqS3Vl?=
 =?utf-8?B?OVVGVDNPZk1uZm5sTHZxTlduVnkyRmY1diszMVpKQW5Fcmtuais4dElnYUtW?=
 =?utf-8?B?NzZQMWNVYmdrcEhDL3UwUnVlZHJkYWxmYjEvRUMwY1RXZ3NKT0M5V2gxYVBj?=
 =?utf-8?B?Y0kvRnpDQ1VPKzlvMjFBcUF2cSt3SEFhMUU4d25DWUQ0L0xvd2N3cGdtcG1w?=
 =?utf-8?B?TDYzT0MvWUpmZUJ2L3JaVytIM3ZtcHVobkhIZUFDMXduRGMrVUF3NVdiYTdp?=
 =?utf-8?B?TDZ0MHdadStydHh1TUNES2dqcld6UFE1Y0g5QWY3bjg5N1hWaWlSZm5YTWtl?=
 =?utf-8?B?ODI4ZCtsYWgrbzFMSEIrOElqZWlRYmhyS0ZmVHcxeC9VWlRkRkd4dWZrbHhk?=
 =?utf-8?B?a3pRRjVLTHBlVlQrME5kYUcrMW1PQmdMc0lXZXZLMjJtZDFXL0pDemxiaTZw?=
 =?utf-8?B?TFcva3hwYUZUSDQ1OTNIK1VDdUk3OGQyYS83YU11b3U2UzI0ZWlXSk5sSUZC?=
 =?utf-8?B?Um85eE1DWTRWUXc5amJzZTBZQnNiQVc2VmtVbzVzMnY4VTRSMHRvajd1YkJk?=
 =?utf-8?B?c1RhVW9tNmFRNSthSCtpVVdtdXJSbDVqaGJWN1doS2dBVnlkbnhKS3NMRW5o?=
 =?utf-8?B?MnFLcDFnam9zK0V4T2VGK1pLeTJTVitic0lkYnFqNVQraktLT25GNVB3a3lQ?=
 =?utf-8?B?UUhMZFdIQ0NYQkVzbkFhaEZuS1JxeklHa2hpVHRBZUpHRGE5cmUyWDdTcE9K?=
 =?utf-8?B?em05RXZDUDF2TW0yZ2F4TXFVaytuNU9GWGp5a2Q2K21kTkhKL0V0bDI4eUdE?=
 =?utf-8?B?TUFMQXB5aENUTWlyQ1NDdVREVVNUSk5oa2hZMTViQ083UnBpT3Znc3NkVm51?=
 =?utf-8?B?aWZCZEkwWWF2RzdrVXB2VFJacHFJNGpwZ1UxclNnSWd2MldJOU9sMUdsSDJT?=
 =?utf-8?B?bmpxT2I5Rm4zUGpCRUxqUkU0ck4zelV4alNzbHFNaW5zdmsxc3lkTUI0MUNu?=
 =?utf-8?B?WkJrSjlTVGtrdGYzaXRFemNkV2lDV2FQaTNnc0MvM3FSS2FjSmZEdG1IV0hp?=
 =?utf-8?B?NzVyYnJSMTJpNlhIcnRNTkpLWnlQUkQzN2d0TXdxdmJyRm5pQm5iRXVNNXZT?=
 =?utf-8?B?b3lnNFplNVI1NE9semthbkRMeGt6ak9xZWtwcExJMGJYN1hrZnM5blVVMCtV?=
 =?utf-8?B?VFNoVjAxdWNIU1hiY1VyWEtjUWVaMnQ3T2tIV0ZjZnBmZi80eHRJc3ZGL0da?=
 =?utf-8?B?akxpbmVHTEYrRmVJWm9UTExMMjJNSEJTaTZLSWdDSzNrLzMvS2cvd0FudzdX?=
 =?utf-8?B?SEhESlBtZWg0K0lJN1kvNkNSZGVVUDFHUm13UXN3S0tGQzBXcCtzWFdVSXlj?=
 =?utf-8?B?MHU5WmFGUUMrb21LZ01tZ3lLU2RqZzVWOS82VG9FSVZhMTgzbXk1M3VKQ29K?=
 =?utf-8?B?Y2tDMVFvUGQwTHo1RlBVc3J3NmFsNS9DOWV2Y2hEUnJnRFI4OWJmUVBZR0Vn?=
 =?utf-8?B?YVk5ZjlXM2xKbGpBMDZWUHBWaFJsQUt4aTJJSm9YWlhMT1dtY2Z4bkpJc21z?=
 =?utf-8?B?eTJaV1VDQ0xKT1VoRnNaOENXZDBQb29CTCtLZU1CcDdVaDE3czFtRmRnUzZn?=
 =?utf-8?B?eUFkTXk4MklFeEVXZEhmb2F5aStTbzdDVWhFanZFaVpTdWo5QjNlZkFmZzBW?=
 =?utf-8?B?MVQwUk13TkhsU0FoTDNnUHhxZ1diZVI4aGxxT3JrWmFvWlRYMnk4L1puUEN3?=
 =?utf-8?B?WDlWWE5HRGhGT3VtSmlDbm91c2V0d1plRjZCQ1UyZW0zOGNvR2dmSnQ2SmZX?=
 =?utf-8?B?MGJnWWhzR0NxZ0FHcHBHR2lhVzhBZzA1TGs2eDhlV0Q5MFIzaHB1ZTl3SFBP?=
 =?utf-8?B?dDlNU2d0LzF4YmJkZWJTOE1MeGpTdUdBWTlTVFRwaUhvMVlwQjJYMXNQOU1D?=
 =?utf-8?B?Wm11NXI3SzJtbnE5enNmSGIwcWFneFJpV0xvZ3dSOGRvZ2ZOK3RDQzJmaFFU?=
 =?utf-8?B?WENJYmZIQ3QrL3U1c28rTnZJMmhROCtmMERHMnVxZmZhRXVmRHBNdG8zdFUx?=
 =?utf-8?B?TlV2SzVUK1NNMHVYZUlJNDNoVVpoSy9od3lDUW8rVkVQcXNSSEJQZHlLZGQ3?=
 =?utf-8?Q?dtcN0k0QKvnsZ5Bs7P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fe0b7c-893e-4256-3b2c-08de9023c232
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:20:39.1562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8LAnxeRNuiXkQbw05sWMACYO4NHYnPKWVzghqxYnC8l7LStjr/T6fDXHAkeIfMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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


On 3/31/26 12:20, Alex Deucher wrote:
> On Fri, Mar 27, 2026 at 4:33 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> Create hung_queue_hqd_info structure and fill in hung queses information
>> passed by MES, including queue type, pipe id, and queue id.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>>   2 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f1f8bbfc31e0..436a46ba1dfa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>   {
>>          struct mes_detect_and_reset_queue_input input;
>>          u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
>> -       int r, i;
>> +       int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>>
>>          if (!hung_db_num || !hung_db_array)
>>                  return -EINVAL;
>> @@ -471,6 +471,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> +       if (r && (queue_type != AMDGPU_RING_TYPE_COMPUTE)) {
>> +               dev_err(adev->dev, "MES resetting queue type %d is not supported\n",
>> +                               queue_type);
>> +               return r;
>> +       }
> I think the message here is a bit confusing.  The MES can reset other
> queue types, this is just the fall back case for when MES queue reset
> has failed.  Also, does MES populate the doorbell array for all queue
> types regardless of whether the reset was successful or not?  If so,
> shouldn't we bail for non-compute queues after the doorbells are
> populated?
>
> Alex
>
You're right. I'm too obsessed by user compute queues and didn't pay 
attention to this is in amdgpu_mes for all queue types. I just sent v4 
to correct it. Thank you for the review

Amber
>> +
>>          *hung_db_num = 0;
>>          /* MES passes hung queues' doorbell to driver */
>>          for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
>> @@ -486,13 +492,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> -       /*
>> -        * TODO: return HQD info for MES scheduled user compute queue reset cases
>> -        * stored in hung_db_array hqd info offset to full array size
>> -        */
>> -
>> -       if (r)
>> -               dev_err(adev->dev, "failed to reset\n");
>> +       for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
>> +               hung_db_array[i] = db_array[i];
>>
>>          return r;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index f80e3aca9c78..2e6ae9f84db0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>>          uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
>>   };
>>
>> +struct amdgpu_mes_hung_queue_hqd_info {
>> +       union {
>> +               struct {
>> +                       uint32_t queue_type: 3; // queue type
>> +                       uint32_t pipe_index: 4; // pipe index
>> +                       uint32_t queue_index: 8; // queue index
>> +                       uint32_t reserved: 17;
>> +               };
>> +
>> +               uint32_t bit0_31;
>> +       };
>> +};
>> +
>>   struct amdgpu_mes_gang {
>>          int                             gang_id;
>>          int                             priority;
>> --
>> 2.43.0
>>

