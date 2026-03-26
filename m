Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C57110A3D8C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B976710E9EE;
	Thu, 26 Mar 2026 12:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHhq3p5q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC8810E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4PdYuRYyS4n6CW7QEq2drglhSMpXmG8tlEupYPzfk7s/PsHfiHtNI++SOU++n+b+Ywtyl7JtsD8o19BXj74ZvAQWBqHhrZg/5dL6rOyRyt4TidikGi2HQI3fwE/KBswDAgpn6Xz/SG8PwnykwHmZ8UniGfueLyStDUc7Vhf60t8aXqAXCSlAfZ/TGzpCGk1m+Oy6F+GnpgRfM8MPzjctlSRZpPtphBCEf+KA5SIin13V+MqBS7f4Q24qBFY3DnLSYVAqmjJvuOD+zQiyPDYcwMpuYT025W79DGQxjF64TfoWyIfetEoV0CzZ03mSf6DT9DAfqrv0AR0QydTn21C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbO7VRu5MnbqH1BsHXSnb17RjTia2iID6/SgVt7mAWM=;
 b=ULEHw/eCcrLaJnt/IAtn7mETwQiHsV236mhS3l+cSyaSfxvmj25jQax8soAPR6Fzv/zwy4xCN5LB+GGcZv+KhWp+HDxA+pvNBKBn2MsErjKEAHew/0krQ7s25OtYmfdqx27cW+fd8vxKuw3+LupfsEgS9dF8GFC4QYn0s3wtDw3sm6JzobMuBGCET1vP4VLDuCx+qVnYKuqvGrdo2yzKxT9BWco+beDG3tQ/OqVNlpuQDobERlLmT7sZb/ASzDyva9ULnIoqyN/OVbNla39d92oM2WWVZhyXx/zZcQJUvOav6ZmZg4CQB2ma0TFY3qYfbCxumA8eYuBMqS70dt53lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbO7VRu5MnbqH1BsHXSnb17RjTia2iID6/SgVt7mAWM=;
 b=nHhq3p5quBMA6ue4A+MOB+S9KPs6A7UCo25SIgMTdvfQDY0Jz/XazNbecw3tpmxpcPmB0HxcXLCtnA7elzu8SCb9oxLDWIjDHBs0F1GdOcE1JT4cw6IEU02jALKKZ3qCuCwX6NDLo/Gy9OsQkVAhYI0XJyGp+MuH5F9IxZ7TA8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 12:32:30 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:32:30 +0000
Message-ID: <7aa62852-3b42-4af0-87d7-3732924ce308@amd.com>
Date: Thu, 26 Mar 2026 18:02:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 3/4] drm/amdgpu/userq: no need to use local variable
 here for return
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-4-sunil.khatri@amd.com>
 <94fd70ca-1700-4e3c-b6d2-34a51b63f265@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <94fd70ca-1700-4e3c-b6d2-34a51b63f265@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b588f7d-edfc-4d4a-fdc1-08de8b33bee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: mCUzjiXaQrX+RgYNwDuMTcfjdanaL4gQDPoReXlAlTKPlzf8UN9qE1Nv2c9hZCkT07RXxN75EPjGImIT14uNIELNT+f9yoFQ6lrN2O//bhfNioAa7hf4qYWS+vfX74hueeopH/YjNm3FWIgKJR83tbQGjrxVTvjamgjY8+EAv00/cYKtSRfcVoqbDeci23LRPw8H27UzqU5yM+3bcpj36kDZm3SjpuZB10Xecg6XGGzfGCVDjTHNEiTwQ836/p86mELCBPWBczpokMPWhsu/hEamT8TRz1NdoPlXzQ39//gATz35rKkNnF0OVZJGkjsimIRleDKseLEYVgnzQJrFqtHMBhONX7vvlhWyKsMS5nor8i9SIqMy+dlSTRxIVBhUMM4eEXJF9bajRJlvlFneUIHz9XhL2eIbyTjFibJU3wWHep3rZFx+IFoeFbxstiR208HVvmhKW7PVT9JqYuNnJqmmrTF8AbnHLL4c+BKAMjbP42xsnpoH0f6qZ0lb4hZWD9NxG6fWcpttpVF93P5qW2WO/neiaksrWpq8UdaIXd5NoJHcFlGnXTbpELyX8DDSAWLX74WErnK6AzG8IshQ4TX38EOzOVgutTXCwg75R70B6JNqSJ7J11IYI9aeir43xPbZ/M0ME/p49wH6NVOsdY7BnL1gOguQ2JgAN5IEHKxkAPVqYRG+d/fVkqfkwUOfI8oFiSc47bSiM8cpYfZpjx6jVSSXVED5i6e1vB8KQk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkQ4QTR6QWdiKzhBVmxWMDZCK3V6TThXL2lOMFJKWUdFTU1haFZMSTluZHZW?=
 =?utf-8?B?TVVRdTBuWm04QzhSMUFXc0w4ZzFWdXRPSVlkWE5nK3VjOTdNUmk5eHJKRFJC?=
 =?utf-8?B?UzdWWlRvV3A4eDdMbGd4UWJ4Z2hRbUtGOElLWUthWjVJeGkyT29CeklORkpJ?=
 =?utf-8?B?cmY3R3NjbktMMFJlMWx0WGQ1cGJ6T3A0TzUrbUY3TWVBNE5YV2lndnZpUUVk?=
 =?utf-8?B?L1g4Z2Q1aDJyK0FXNTFBeDBxNGcwRzJ1Y0VrY2ZkQ0VYWSs5c0NtZkxNdUYr?=
 =?utf-8?B?eU5pMXNkRkVvQzVnam9CNVU4YkxKb0hrbGRpNHliOW5SZG5hTTJHcUpqSDNn?=
 =?utf-8?B?aWNWRzM5WEQvZnZkRFhaSDJVb2hTV3R2azlzMmVMSXJCcUdvRkMrUno4U3Rv?=
 =?utf-8?B?NVE0bDM0YjhBa0N6K0JYNzBKTGlZRDltQWFkYS9LU0c1SFlXd290enY0aXh0?=
 =?utf-8?B?SlhQdnVxSkxYMG45QnpWeHQrR0VXM3J4cWJoa3VqUnhDOVduRGN1MkpqWnFw?=
 =?utf-8?B?MnZSRGtLcFJTMlVJbzNWTGE5Zmh3aGhlcVZlOXV0RDFmUVZaRjVadDY0WTBi?=
 =?utf-8?B?cW16WFF2Q1FxQ0lIV2JuTXd4WTJSQ2oyaDhrNFE4dmRCdTFEM0FJTnJQVDRm?=
 =?utf-8?B?UUxVYUc0eFUwK1NjS2YwMVZLYjJoV3NWbGVmRmthQU1leCtsaWxiMWJHaTVU?=
 =?utf-8?B?MWVQb0RqMk03UGE1bE5RcXhIT1JScEFiS3JWcVIzNUErTTdzWElvUmdVTlVk?=
 =?utf-8?B?TDh2VnY2RWUrcmNPejZTNldBUE5QR2liRGwyR1lsWVppZmFuenN0N05OaGFE?=
 =?utf-8?B?QWUxeTZ5WHRMamFaOFlXakxOdUE2YmI2WTVOVXpPZFdZQSt0Y0lxd3V5Nko3?=
 =?utf-8?B?REFmeTBVZEtCQlQ2WWE3NEdtS2Q3SC9vSGhrNS8rUVJ6VFVkaGZ1eFM3TUw3?=
 =?utf-8?B?dmJNZlNNUC9EVkw5dGJXRC9DYmhTS0hlME1SeXZaaGJGQmlYM0NQNjAyTVA4?=
 =?utf-8?B?OUJFSjczZFBUa0tHR3hnSVRYT2Eva1YxS3p4SWswdFd4TXpYbXNPdWtvaXVx?=
 =?utf-8?B?QlpNZS96RFVySFhiWUV1ZlEvU3ZjSWJOeDNKSFlQeTN3TStRQWprYnVkcWQ5?=
 =?utf-8?B?K1liVDJ3dnhQM3ZpcCtkaXM3eVhZMDVEVVlUem5tVytrRkZ0dDR0ODMxanUx?=
 =?utf-8?B?Y1lXNVBLN0o0a1hCK1gzcTRjbGlzZ1MvZUlhQWZPUCsxTUptU3hmdlU1QTBR?=
 =?utf-8?B?cktRVGcvQmNWakkzZEZ4T1dqdnFEUlZxR1BwTytKYVVONWFwY1BHaTVGMnoz?=
 =?utf-8?B?bnFUa2NjR2hab0NrLy9CYXprMHN2L1FpcGNRLzZ2NEE2SnAzVW9sTlIrTUZ2?=
 =?utf-8?B?L2dVdzRCNWJyTmdLeGJhTWhqY2NTZUxaQ05lQlJCLzhqekxYTFUzS0ExUWht?=
 =?utf-8?B?djVrSXpsQWptNjVSZWRVb3doZ2M3YnUxLzJrbXViMnU1cHN6OUlyS0U4c2VU?=
 =?utf-8?B?dUVQRlhsT1o2bTZpdUdyVzVqOVVGNmtGc2crVk5FL044WUx5RHlhSDROMStp?=
 =?utf-8?B?RWtmeWN6ZTNaUWpkZDhaUHlGNGNWS01ZeFRsLzRiV2ZBcjNvdXJKVmJOcTRL?=
 =?utf-8?B?L2cvNUlMb1BZcVBUU1pZTC9kQ2x3aG55Yys0aG1CZnhKSXFYZzBrMXFaOXV6?=
 =?utf-8?B?UFordWRFcW4xaWV0M2lVZnJwbHAzbWpoakVraWRrWi9HbXh4V2ZydWFWLy8x?=
 =?utf-8?B?a1RRWVFJZ1MxN1JWS0Q1NTUxeFhvZ2JnVWhRZi9DZmRtbXEzT3NvdE1xR2Q2?=
 =?utf-8?B?WFFSWVlNaXhLRyt4RERxUTIrM252TFAxdkMxUElidlFTdnJhTExzTUFCc2cr?=
 =?utf-8?B?cFRSNWM3ZnNUbjlJYXY2dnZaaFpFQmZVN1VsSHY1VlVaYUo4d1Faa0I3Ymgz?=
 =?utf-8?B?Y0NjK1JybDhYbE91QWFVbHB3a2lXVGp2K1d1bkJ4WWIybnBFZ3NvZjBhZ2h1?=
 =?utf-8?B?QjdWaEttZVRhVHd2QUxlWVZrUDJKZlpURzVQcUJnc0hYR1JuL2cvQmFiQWhY?=
 =?utf-8?B?WnMwWHNHdjQ1eEt2RCs4YkpFUk5mS0kycW9oSUdUZU5IMUNZN1pscWtkVXlI?=
 =?utf-8?B?YzBvUFpWcE80R2dHV2tManNrWnpXOHV6TGRoWGh4UWpvMkFBYVVrLzFEaXNF?=
 =?utf-8?B?OVdoYjdhMThwV1hvamVaQTJTQVJCcE9udXVHYmY3dzVjWTJBT3NLUW9xelFD?=
 =?utf-8?B?YjZaeG5OWEJnY3lsUE83NHU0SFB1c203dUp3enQvT2haWXd4akN0YUFRa3hz?=
 =?utf-8?B?d3MzRTV2OHJFZnl2c3ZycXpXSjZuVlE3bi96MU9tb2gvMnFiNytjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b588f7d-edfc-4d4a-fdc1-08de8b33bee8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:32:29.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2HivQdTqxSI5CjSlaqn3My+mAHSuBTZfa9uiRV/e9x0CgaX0uM6kwPJCe0WaVXd/8exwD21V7pO9tLFoyWdMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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


On 26-03-2026 05:41 pm, Christian König wrote:
>
> On 3/26/26 09:56, Sunil Khatri wrote:
>> In function amdgpu_userq_gem_va_unmap_validate use function
>> return value directly in the if condition instead
>> of local variable ret.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 2b07c3941927..48cb2e21ce56 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -1478,7 +1478,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>   	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>   	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>>   	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
>> -	int ret = 0;
>>   
>>   	if (!ip_mask)
>>   		return 0;
>> @@ -1493,9 +1492,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>   	 * the eviction fence is always unsignaled.
>>   	 */
>>   	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> That test is just nonsense, call dma_resv_wait_timeout() directly here.
Make sense.
>
>> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
>> -					    MAX_SCHEDULE_TIMEOUT);
>> -		if (ret <= 0)
>> +		if (dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
>> +					    MAX_SCHEDULE_TIMEOUT) <= 0)
>>   			return -EBUSY;
> That is wrong as well. We need to return ret here and not -EBUSY!

sure

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>>   	}
>>   
