Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7F3F483D7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F04310E083;
	Mon, 23 Mar 2026 19:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XAA+2hnu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865DA10E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5ig5AqkNWjSfYhE/1m+PQRAWuwEYHq3aiFaQENr/l4UGQp5J5f3uyF2/M3dIFL5swayQi7lnOtEy6kBs0+L1iaBBQkpUslSLT1Hu2nVPCkGLCNr7qJLcES62tXKscokJk0sCEYWhW0JhpLUBA9QZShMJasuPOj0SsGjCPpKdyx2b8murEVEfru+0RNkv6Bilb6Hf6anN62H9zxxRvITgJsvSYviK0ZGXOP7bnwane/bcvza3Tr+XCjr0OGehRsxuQjA/ch+4aAy3TE0fhMBZkSDt3C599TsNQx70UuEhf/h4rDPNWBFDliRoh41ozB3z2adrJt+dz5w06xqBGXybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIK+fjBEzTwIldEQRiJUgTLh6vmc8AJ/WBT6aiR9wUE=;
 b=m3g6ZQtDj0uNl2k4BvAwQRwwDwN0wqqYc5fb01QQ6NxugqcgdUTWJxc9596tkBl2Xqym4WNFvpfytteqC5hPSa70kzJ6Krp45kRb0AqJu2CY6pGujPZfC/hdnKZW41aucZmyCLfyyfeUrQUQmUz1xED1GdV3Gx/8k++R386+6wWLF54SNGCYs9Fm7lWAj/RSBAFBd7CuQLyUwzo39sQUntTWtkoC2B1VRowIHj4N7cbtBcxR0Jj6uFdj+8qJi0BfmUw5Wb8yoByIS4dzM23BTjN7IHB6YWhxpVUB5ua6CyBbMrbz6zft6tNHUmpMRfYLMSzXqrIXlxb6aH8d6cDNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIK+fjBEzTwIldEQRiJUgTLh6vmc8AJ/WBT6aiR9wUE=;
 b=XAA+2hnuTXVMoNZIW3Kn8dDTYEekTbErBgd3vZxULnTBIhymFLwPFI+W7EV2Q7gf3C/vmZHmvV3DK/KM8Tx0xgPJB6kKa+PHiPaLt6LRCbbEXSbr4HoVrw+LhAL4HxBufiS1T/oMcWKSMp2UuLJuYcKZV0LkHeRMso3RKm6ccq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 19:15:27 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 19:15:27 +0000
Message-ID: <6797379d-2f65-49b7-8826-0763efc4a158@amd.com>
Date: Mon, 23 Mar 2026 15:15:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: Fixup boost mes detect hang array size
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-3-Amber.Lin@amd.com>
 <CADnq5_OxDUYro8TqWQFuJ1qE9MRwoC1j6=ac_D1moP2Mfss+4Q@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_OxDUYro8TqWQFuJ1qE9MRwoC1j6=ac_D1moP2Mfss+4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::19) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: d765750e-046b-44c5-b5b4-08de89108a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 7w2Pne558+c3h0mY8oVV5kHjtlrrHWzGSG/zBjzeMOHj8gjuuM0LutzLjN2EA9WKZfx3LnMQ3QcotT+jvHz3i6F56KwRSekA6WIJboTBHCG6ZIYSWLFID4rfgRaC/Y3Z7douWzUar1HeDgaanJAGLmlLoRNW4+lN9NE1xdbBdPJ2Y+dQbFs4DXfwBHxoFSdOIujY20eTbigQ2jorJ4j9PUsql+NuI5JaEn2JUwIAhwXLOyz7mpABVbjcq46w9q889HN9gPqcucIiJwvahjmhwBVUgiWEl+fHUaw+f9tauoE2mk+uLG9QzrIE7YzxaSVlGaCRQN5yAZvpPVIBicKBXBj4R0yBsQdqqh9I5mQnyzb8LOS6lXRel405aEmsZ1TfIVADALYz7A2/vtkA8dLPhcnmajV4OHVXuaSaAOFB9CbMWjGyTrdnmjTdCV+D0bX/N3UZ1Wix90PjKnQdHc+29wuISvGDgNgASoDVaFvc6rgSXrBm+T4unm5yVOCg2/9fK8Z/beo6LDmdUyKSmaHrZs+FHOXW01AzVyUVLubySXLtkJ9nC2IsXyx6k6eruQ7jgxTe3qJjQxwoGoVmOnFPNVynArZrdnlUtGUBeWNRaaMiAMRfpAXRLe+JtO/3odJr8Rp17r1PWypNjuL2Nc5rr1llIV0B+xadF7j6V10VO6puNa9aNdIJeMyLLOFfmKKrGC2LMFpZFWkAuL8PvK4ZaieqXw/CXaNC/Ynl/TH+QkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckc4Tm5xdEVjRm84YVhIWTRtYWIrZGlhV2pxVWhJVnZlZEZsQ21vQnk3L3kx?=
 =?utf-8?B?SFNjcGNyNDU3SDFzQVF2NnN0N3JDaVdURlFmcHZMSXhIZEQrbUs5S3QzMzZh?=
 =?utf-8?B?TUdBRHBpc3NpcStzUk1YRE1pQUJWblhYRUorN0FudkNyUjRQS1RkOGhrbE4x?=
 =?utf-8?B?bEVMcHRoTENUeVpBYzhLSVZxeWlVeHNFeEVNdnNMaWlyUXE3emVOdThZajA1?=
 =?utf-8?B?TGdKRWZIMG9EeUZZV1dJa1hLVzVkZG4yZ1NVZ0NVdUVNdEJpZjlxNWt1RUF2?=
 =?utf-8?B?Mlk0SFhEaC9oUURqRzVBbE43dGFiN2hTTXU5YjFjMk5jdjJBYzVVN1Z3WVRy?=
 =?utf-8?B?dWN3UDVOWDAvM0VnWWRjb1dzUDZHbDVUMExrUlIvbWlON0hCcHRoMUVRUWxy?=
 =?utf-8?B?M0U3a0U3UUxYUFliMU9kSEpzSldQQ0NDbW83bVUxZnQrSUdUUkM2ZVgzM3Zh?=
 =?utf-8?B?V1FmUy9uSGw2dXVJdkJ4ZVhwNXg1MmNyVUxXTTJldzV6ZGJkczJLdG96bGY4?=
 =?utf-8?B?MGU3TmFiYVRPUldCNHJyYzBFWEFWKytmL1pSWkRnY2sxNjVwOElmZGgxamVa?=
 =?utf-8?B?bkVkVGpDaXN0TjlISEIvUjlEc2xHTmhGVllUbjZjOGZ5SVJ4NTVlSUwwSTVh?=
 =?utf-8?B?cHI2UzJhNHpkRzQyM2MvSVZHMUdVcnlDUUdnS3VQNE9iZ29va3dKTGNYM1Jt?=
 =?utf-8?B?Qll0UWF2aklvQlVTU0hnV0VtWFZueTdGVE5abCt1NzJnb01aWGpIQ2d5Y0Fi?=
 =?utf-8?B?MHZKYzRtRnFJa3dFVnAzTmkzbjl6WW5TMk96SWlOcHUvNllLc1NjcXd0dEVQ?=
 =?utf-8?B?c2RpNzlYdHJORlliMVYrTm40akkxbXFmZ24vdUdvUjJoNFJCRlBJVlJIWkFm?=
 =?utf-8?B?bTByblRtQ1gzME9zOFFIYnVHWUVzZnpHZkRYc3BQY3lRamovayttV29WbHdw?=
 =?utf-8?B?Z2VMY1lhOGx6U0d1NmFoRDZpUU8xSzZoazVMMGxzTXA2OXZhMkhtc1RnOVJz?=
 =?utf-8?B?UnE4dGUvSXRqdHJkUnRnM0cyb0VmTzJpeEpudE9zc2UzR0hYR1JBSDJjdy8w?=
 =?utf-8?B?dWtVajBHL0VQQTVsVXpNU2lRU0Y1WlVnOUx0WTF3cVVXRWt4K0lUMmc0dE9T?=
 =?utf-8?B?UTdVZTluUkI5cHVzTFB2a25tRlp4ckJGZ1l6c0R5c3ZuWGlUbE5TV3Z1MXhq?=
 =?utf-8?B?UUVkanJ3Zkg4c2pydmpvcjc0c2MrYWF2bWdZMDFJay9Ob2FPUWoyS1JNb3JO?=
 =?utf-8?B?SDRHSkt5Vk1mNEh1ZkN2eGsydWxyb2pGSTE5K1FKV1puSEN3c0dwcGxUQ1Mw?=
 =?utf-8?B?ZCtoalc4L2k1Q2dBZ0ZwT2ZHZmhBeXN4Q1ZpTkRsMVVLY2RLTE9GMW8wSnBu?=
 =?utf-8?B?VVZtTE9sYm9XQjN6OUFnczVteFdQNG10eHZNYWhiWjdVaXkxM0ZqaWlybWp1?=
 =?utf-8?B?MUtOV3ZHUW5CVkZJd2VZenFVKzhFcnk2K3RKQndMM1VKVTZZUnpsZUtGRVhV?=
 =?utf-8?B?cDM3YWQrM0FqR2dRUTN5S05WQnkyOGgzRlFneUEwTGtCWThCSUQ2dTFvYVNt?=
 =?utf-8?B?UDR5NERQZGJBbCt2R0QwcERxSHhFN2RFZGMydW0ySlBpSVVjV1VtZTBpdzFy?=
 =?utf-8?B?aWRibHNVOVBHcmwzaklLbnpXcFA5REd4ajU2WGtobGxweDE5aEFaZWtvb3hD?=
 =?utf-8?B?QXZIL3lVSGwwUHBQMUpJU0kyWTdxRTRCVFhVaGJ1bHkrdUhFUkRmcEVnRjBG?=
 =?utf-8?B?cGR0NTk1c3VrL1RnRWM0VkVpdXY3eWF2ZmE5YVRFbTZ3djRxSEc1cG1XMEZu?=
 =?utf-8?B?WStrRkVzZ3U3ZXJqbkJNV3hCZGh5djV0L0VIQlMwQnkzVXdaQ043RC9JU0J1?=
 =?utf-8?B?QmgzUlg0ZnVpSEpWSzRNSEErVEwwQlQ1Q1BkNWQvZFVEYW81bHR0bGVxdEdO?=
 =?utf-8?B?MnBlSno5M3E5MHc4VnlxeWpKTUFKay9odytoUjlVTGVhNlhqSmJWaWMzYjND?=
 =?utf-8?B?dzZvR1gyZHJPOTFHZ3FZN1I2NjM3QndjR0dTajI0QnFRRFMxa2ZRMXRPUzM1?=
 =?utf-8?B?alMySWVrVWprY2lzUGp0N014MC9zYUx4VFQ1N2N5T3N5VHUrZEVteTJzaGJT?=
 =?utf-8?B?QXF4WngreXhRNkdBbEtSeGdFVFp1TE5mZjF5OUZrcjJqRGRZN2ljVzJQeE5F?=
 =?utf-8?B?aTVPUHJOMklHZk9aNFdlaWx3cndINkVnNmlZeHU3Z2p6TWVlUWpKTVgrUU1N?=
 =?utf-8?B?YUM1QU0zTk5nT0d0Y1VoR2JtRlJNNGxmbU13eVlCbFZ4NHRtQ3JXc2NUMlBP?=
 =?utf-8?Q?zXJX8aYk+SAhmJMftn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d765750e-046b-44c5-b5b4-08de89108a86
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:15:27.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDb1mlt1u6bSgs+ihGU7da4TFL/bxpmX6qZGtLKwGU6FwX+x14SMzF0L94xluqY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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


On 3/23/26 15:04, Alex Deucher wrote:
> On Fri, Mar 20, 2026 at 4:09 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> When allocate the hung queues memory, we need to take the number of
>> queues into account for the worst hang case.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 33 +++++++++++++++++++------
>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 0d4c77c1b4b5..b68bf4a9cb40 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -103,7 +103,7 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
>>
>>   int amdgpu_mes_init(struct amdgpu_device *adev)
>>   {
>> -       int i, r, num_pipes;
>> +       int i, r, num_pipes, num_queues = 0;
>>          u32 total_vmid_mask, reserved_vmid_mask;
>>          int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>>          u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
>> @@ -159,7 +159,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>                  adev->mes.compute_hqd_mask[i] = compute_hqd_mask;
>>          }
>>
>> -       num_pipes = adev->sdma.num_instances;
>> +       num_pipes = adev->sdma.num_inst_per_xcc;
>>          if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
>>                  dev_warn(adev->dev, "more SDMA pipes than supported by MES! (%d vs %d)\n",
>>                           num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
>> @@ -216,8 +216,27 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>          if (r)
>>                  goto error_doorbell;
>>
>> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
> Is this 12.0 and higher or 12.1 and higher?
>
> Alex
Thank you for the catch. Yes it should be 12.1 for now until the MES 12 
support is available too. I'll fix it in v2

Amber
>
>> +               /* When queue/pipe reset is done in MES instead of in the
>> +                * driver, MES passes hung queues information to the driver in
>> +                * hung_queue_hqd_info. Calculate required space to store this
>> +                * information.
>> +                */
>> +               for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>> +                       num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
>> +
>> +               for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
>> +                       num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
>> +
>> +               for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
>> +                       num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
>> +
>> +               adev->mes.hung_queue_hqd_info_offset = num_queues;
>> +               adev->mes.hung_queue_db_array_size = num_queues * 2;
>> +       }
>> +
>>          if (adev->mes.hung_queue_db_array_size) {
>> -               for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
>> +               for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
>>                          r = amdgpu_bo_create_kernel(adev,
>>                                                      adev->mes.hung_queue_db_array_size * sizeof(u32),
>>                                                      PAGE_SIZE,
>> @@ -264,10 +283,10 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>>                                &adev->mes.event_log_cpu_addr);
>>
>>          for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++) {
>> -               amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
>> -                                     &adev->mes.hung_queue_db_array_gpu_addr[i],
>> -                                     &adev->mes.hung_queue_db_array_cpu_addr[i]);
>> -
>> +               if (adev->mes.hung_queue_db_array_gpu_obj[i])
>> +                        amdgpu_bo_free_kernel(&adev->mes.hung_queue_db_array_gpu_obj[i],
>> +                                        &adev->mes.hung_queue_db_array_gpu_addr[i],
>> +                                        &adev->mes.hung_queue_db_array_cpu_addr[i]);
>>                  if (adev->mes.sch_ctx_ptr[i])
>>                          amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs[i]);
>>                  if (adev->mes.query_status_fence_ptr[i])
>> --
>> 2.43.0
>>

