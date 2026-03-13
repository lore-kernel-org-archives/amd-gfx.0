Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EDD105F784
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 09:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C99A10EB68;
	Fri, 13 Mar 2026 09:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z0gC1Yl7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B594610EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 09:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS5V3lJw6A2Ytj5mFBtaVxsBBQY06ffAHcqhxukU47LmVh7wi/DIpKR0eIKqGknqr/f/IX4u8rkuU0rX5gh8dhJWMHOwn+LJ4MKBhbaM9UCgp5W7q2T9sDx5byFJRodXcl++G4OOZ1Jd76JzxkqYqp0bPRsLcnKONsmBekCbD+kjApT64qwRkuQqGJAfRYBjMzRXDwuBte9ZYWsYUcy2HRcWKBVqD5F/KvxpGsDtFH/2el/zKMmSY6RC/f9i2RDFMOJYZPLcb4UARNNj4CivrOKcukOa7AphaY2QivyxPgrl/+Z+T1TP3GAw8ZKVHOAadCYF1jYdjuz/U25Rt0m56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjFnvShn5Pt2VMj6gaUDC/AK/pmlkkIXoKN+qOfUTTY=;
 b=LZ6ckPpdxAFqV3cRgTVOlC+pfsyOZopg5/1gvVrVjwNK4HGbtXMaZ18+nuxOlsMLs/iScxZd6ecJSK2a8eWUldNKSzhIOxJf4SQ7jL5NzGH/xlUDlU+UBfAAyqCPLokxZhrnha3ql6YE2ZnfQNfIZvouUz+lt0JDu00UmU6TWkcbrIfxqVG5UZ/8Nvx9X1bOT0utxG1l0tGBU2pR06AduBlq5obtFoA5GmNajwnQ9+Es7YF4LZzsiAe+y4Ug/Z98/I1Iq0Lq7yYO0TFsqWCZqHADwuJTWqcIjl2QJpaYreZ3AAYnkA/MzlivFhxkGrie7SwaLF4P6qhLf4z9XUlCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjFnvShn5Pt2VMj6gaUDC/AK/pmlkkIXoKN+qOfUTTY=;
 b=Z0gC1Yl7wHaExxTOvKQggePY6lFDves+qroQ6MMjLQJZnPVcU+ahXo40ZDCknxtNhG0OVbLlmYQEmq7rnCMPvQ/ctWAtBUO3jHWKV0feu777paHfrf5wNJl7jWUxNgrDDAvnDBl7xOpDnOjU90De8O70aoV/jbREF5yalvyW/FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 09:35:09 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 09:35:09 +0000
Message-ID: <d571086d-9e4f-4e31-a346-b0c2381288e0@amd.com>
Date: Fri, 13 Mar 2026 15:05:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/amdgpu: fix eviction fence and userq manager
 shutdown
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-5-christian.koenig@amd.com>
 <bd511d12-f07e-4277-b5ec-270578ea5b4c@amd.com>
Content-Language: en-US
In-Reply-To: <bd511d12-f07e-4277-b5ec-270578ea5b4c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea082f6-6ead-437b-70d9-08de80e3d123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: eWbKf3tOYE/u/PWglt0NX0rR4ZMHl2G0Bn4rYfdTYlArzlBybVLV+Q9a1ystkzQecUiFFqTifkxb/yC9BcTlDpi8HNSU9TmZcdqMIwfECrvob0N0UUcw1ebNTX65Ue/kTsba1xNNER22qlDo0Rgrt5onWm3ikwmylDurmLFPp/FqLMTDv2bFSvUftAgVJbdvR0jHkIAH2R9g3yrE6zwQ6fUbpygJL2L9tC0azRL4c+zY/jJ+gm9xiO1L2WVu3t19bUuuqvOYLhloDqGnbraS/uXCnvFZBhA2kzLtC2sisH/cqgTLI1avV0jJaUEZA/paxHKop6/u95ygnKhgehEDwxrCeOGZl2qhT+eMzCvsvBlt3Ry+BFcr6kB4RVZ8PMoodgwdkBRLl6Dda5sJ4PRhnbWtX0ARky1aeV8jCn6ZJf2YzWSaLvtfXDaQUOsGg6H2KhWol1ykK2TqDwGiCHmzPrY4z8Zx0nzKpIxRTUi5EhuBE0hMqRBCGXqJp/gTonzHJ4JbfmxERu8jaCjrJL/lyj4qfKcqH2moy25QC2fX6UIWebaAYljkGU1JLFxRR23ryHesSxjBRDf4qE2et7PGlgWGOTZTM2y+95iprFyftPSGtMVgM9P67P7k0JyyEk/+g1/P1nVwRMOGZEBZeAcIVnoBfvs75cEVlyMOaB3fDmbrl1z8AfEQrPVJx5jNAMXLLkYDHR+oxK/007hZ62RAF8ys2Zsq9P5p+AC4XYNAgoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2dQanlvWGRHQ1FudHpmYndVZkhNZ3RnQ2d3ZE5MdDVhNlNlSzRNZmVkWWIv?=
 =?utf-8?B?Q08ySVRac2VDRjkxcU1ITlVic2E3YXZTR3JUZVRySzNxeXA2SWlMeHB1TnQx?=
 =?utf-8?B?Tm9MYWh4NHpBQ0xyNXZteG01UkJvSXdBTXJ3ODlrbkdVVFFCZXFzdGRyaENR?=
 =?utf-8?B?ZTNienNSQUNKQmI4RXZKYTJOYU14Vy9yTUJpODZUU2hjUGNyN2pQZjZXMEIz?=
 =?utf-8?B?VG1jMTRXN3pkcElIdnFOWUtkdEM2cTRyT2RGV0x3blduYzg4K1FnMDRaL3RT?=
 =?utf-8?B?dmhFdWVUL1lldVRydXZoMmZFT0xlRjZDK1c1UWo4dm5nY3lZUWRNQTd5ODdt?=
 =?utf-8?B?c0l3d1IrSFdpalZRQi9hYlZ3S2FPWDZZTFBNT1QzQzBCeUQyWXdDVjBabEhF?=
 =?utf-8?B?QXB1SkdFejRaSk1sdVRGck84SkdENXVFQjdLY3cvZnZTRlR4ZE5KV1ZvampJ?=
 =?utf-8?B?Mm1VT1RicU15UU9ndjhTS1JsY1E4K2psZVpPWEdzOHhTMC9meVNzT3NIbEhG?=
 =?utf-8?B?R3diTXd6L2ZGdmdpMDIvWFd5QmxLRU9ERGY2d25EUEVYM2FHKytzN0lZbTd6?=
 =?utf-8?B?d25iZDlFUnU5VHdGNkdCbUg0UzIvWVM2TlFIRzA4dGlZaWJkWG9xazI1Ump2?=
 =?utf-8?B?VGw4VW9oWGhXdWhad0lNNjZjL0dORDBtM1pOSmRma29PKzlncjNxYWl4S1ZP?=
 =?utf-8?B?RmFXcXZrKytGZ1M3RDRIeTBiVUhSUEhpOFdPL1F2WGpFSFRKRFJLZVhjTmpI?=
 =?utf-8?B?MDFFTVV3cGwrM1ZsclhRSHljNVpoVmZERkJVeW5tNUc4NnFHTVcxck5XSTBR?=
 =?utf-8?B?UUlxdkd4QlU1Vll1VEFkRXJjVFp2VVFDTDRoMTFOYitoenROMGloaGJSVHJY?=
 =?utf-8?B?SlpjWDhNWG9aUWJpZ201Zm5WbVdwVExMaTE0aDB1K3BZR0NZUmJ2eTV3WnNZ?=
 =?utf-8?B?UGtjU1l5dXpBTXNTTjZjaHBtblJzYk9rRUovWUp5NCtmYVoxR3JwV0M0UnlF?=
 =?utf-8?B?blY5VWsxYWtkTFczVVBzV0FKRUQ2eVU2SkN5bmxUUWttN0JUOTlXOVRxQ21L?=
 =?utf-8?B?dzBraEdIaE50WjJTQkF0d0lUcFBIWTdyUWllN2ZjZDhBa1BUc2FuK21VdTBl?=
 =?utf-8?B?Ry9WYVhRVUNNZmw2a3gvTk5KZnk2SFJTSkJXbzRrNWhiczFVQlZDaVJWZk96?=
 =?utf-8?B?UEJqcjVFLzhBcFAzR2NhdUtwdXVsYXJOa3pnMnpxMU82ZUYrZ1pZdDRteU9j?=
 =?utf-8?B?OERNaHBEMkgzQUVlSGJzc0tKMnJRSFU5VVJ2RUpqZ1ZMVGNQUGFYWnMrak5V?=
 =?utf-8?B?aUlCa1F6ejhzU1pYR0ZsTWFoQVdMdkhGVld2dC9rTEZtRHpYcFlGdHlxeVQ1?=
 =?utf-8?B?bll1b0hoZ3VPalp0UWl3dFA3TGZqNWpyc3ZRRzZ2MVRhL1NwblVVejN3WmJs?=
 =?utf-8?B?c0hWQTlHUHlDK3NSZVhKZzA1bWJ6TDAxQkNKOXp3cTR0eDJHeTJBeUV3SUN4?=
 =?utf-8?B?SVhaWFovZjh0eitOc0hVWllveEI1QXdWbEk1VlJwQkozcHFCUXJ5N1ZYbWdC?=
 =?utf-8?B?VHBFYUV1ZUlXTHJOM0dDSGcxbXN6U2c3ZFY3Qi9yNDNhV0RNRWVFRWRreTd3?=
 =?utf-8?B?aDFEWEZtbTEwbU1rZlhMK1VJeURYTVRLM0R1Y3NtdDdhR0pJTVBuNVprV3dM?=
 =?utf-8?B?R3Qxcnh2YUdHTittQ3laWHVJbTFiVHVxME5LdEIyYU1GdlhDcFJwK0ljZlJu?=
 =?utf-8?B?K2xGTHdwZ2ZHNDQ5bll0OW5GMTN2WkV4dXBnaW80NXczTG5tdmpKalVKZFd2?=
 =?utf-8?B?VFhXVUFXQTIzMEpyU2o3QWVNVEJyMFRld0dSWEZrL1JEYUdVMnMvTG1rVTRF?=
 =?utf-8?B?Y09WY2VVcExGM1p3cGFXdm9GSGs5RjBlSXU1VDlKcnRMYmdZTUREMlByOEUr?=
 =?utf-8?B?cUlRNk51a0ErTFgrRzVwVmFuVllIU0lYNjVXMVRjZmE2WXdkK0laS2puUThm?=
 =?utf-8?B?OUFYVkQ1akZ6MElXWklSZUpqZVNXSnJXc2dsV1M3QVpwV01SS1BrZVJIWHdG?=
 =?utf-8?B?YTZMNzEycmJpMVB2NzAwTTg3MzJSWFVBOGpCQ29NYi9DbGUvdzh5d3ZGODRL?=
 =?utf-8?B?N3hRUWo4ZUN3RjMrKy9wOXplSFhrVU1ZeGRmWTVGcnpYVWc2NVFtVGR1eGsw?=
 =?utf-8?B?bDRLbllib2Z6eGNaSytCeS9TZ1hFdlpIdGhaTEsxQkF1V005MHdFWHhualNX?=
 =?utf-8?B?Rk9HTlBDV3FkUkU4d2xJVkU3elJIZE5qYU5IWGx1U1lUcm1IZGJGS0ZHS2FH?=
 =?utf-8?B?VHdxZGFlcDRheStGdW1nNjdCU0k3am1tOFB5cW5GZXZsdnBBZXFSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea082f6-6ead-437b-70d9-08de80e3d123
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:35:09.2804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdmgMJ7XmJeanEdVU50RQRql0GQDSGQZH8Lq3AmYfvKAglMfY441E6ZqOX4voJcBMzgOquovKkwukz5rcxl8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

Validated the patch for any regressions.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 11-03-2026 05:56 pm, Khatri, Sunil wrote:
>
> On 11-03-2026 12:43 am, Christian König wrote:
>> That is a really complicated dance and wasn't implemented fully correct.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 5 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 1 +
>>   5 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 67b8c33d5ee3..d99e80aa3204 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2953,6 +2953,8 @@ static int amdgpu_drm_release(struct inode 
>> *inode, struct file *filp)
>>         if (fpriv && drm_dev_enter(dev, &idx)) {
>>           amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>> since we are doing flush of the suspend work in 
>> amdgpu_evf_mgr_flush_suspend, we could get away with the shutdown 
>> totally.
>> add the flag of shutdown im flush_suspend or something like that in 
>> one function itself.
>> + amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
>
> Should this be the first thing we do even before evf_mgr_shutdown?
>
> Regards
> Sunil Khatri
>
>> + amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>>           amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>           amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
>>           drm_dev_exit(idx);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> index 8fe9f91f9551..ef4da6f2e2a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>> @@ -146,13 +146,19 @@ void amdgpu_evf_mgr_init(struct 
>> amdgpu_eviction_fence_mgr *evf_mgr)
>>   void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>>   {
>>       evf_mgr->shutdown = true;
>> +    /* Make sure that the shutdown is visible to the suspend work */
>>       flush_work(&evf_mgr->suspend_work);
>>   }
>>   -void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr)
>>   {
>> dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>>                  false);
>> +    /* Make sure that we are done with the last suspend work */
>>       flush_work(&evf_mgr->suspend_work);
>> +}
>> +
>> +void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
>> +{
>>       dma_fence_put(evf_mgr->ev_fence);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> index 527de3a23583..132a13a5dc1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>> @@ -66,6 +66,7 @@ void amdgpu_evf_mgr_detach_fence(struct 
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>                    struct amdgpu_bo *bo);
>>   void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>   void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>> +void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr 
>> *evf_mgr);
>>   void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 67ba46851c2b..23e4c5f99f67 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1344,6 +1344,11 @@ int amdgpu_userq_mgr_init(struct 
>> amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>>       return 0;
>>   }
>>   +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr 
>> *userq_mgr)
>> +{
>> +    cancel_delayed_work_sync(&userq_mgr->resume_work);
>> +}
>> +
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   {
>>       struct amdgpu_usermode_queue *queue;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 82306d489064..f0abc16d02cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -123,6 +123,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp
>>   int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct drm_file *file_priv,
>>                 struct amdgpu_device *adev);
>>   +void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr 
>> *userq_mgr);
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>>     int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
