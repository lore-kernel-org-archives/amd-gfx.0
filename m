Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4608CC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 19:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E6610FD69;
	Mon, 18 Mar 2024 19:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R0+gpUjE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9ADD10F84C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 19:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqYKqm41vj+/YHnv4WQgNTkIG35evsWAj68uUhsBDrwK5BwCOioMQcJEDkH+qMxJy35qMUfMBHDRxBHZ4VW15l0FrQ+R2nUCYcCgmcYpm+xywEtL8+FfSK02nllXmcj+M2TKZ1IEnvHVmPzh7r3r4TppFDubNzMHkrbwzSaQ97RvVZtIkr1Cm2GXAzg3GCNgo0cWkwgU0cwQbNQqmUV+jcTtJZ8H/sG7VvgoqcD4fV+Eh7YENU0GkhzAXPyEGK26eM+gM4Bvxs7RqvzWbGTZ6l8WQJg7zXez7LLjdrzRe0vhATYJ4LohWMeiLBNm8gBLdsy4WWXdOsKhLHVaIq6Bww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFMA7GA/1zeD7PmqA14azxn3YUyGJbRW/mDgcJhb1zs=;
 b=ZrtIjtKNiy8R4J78IrvjYbA8ABYFxgK8rYc2shBotuYbFAI/9/1Q3n9Ig3A2AvObNulFU3ZACPLzitzCXB/+hZ8zM1F1zKHZgPB1Lj5JCwX4oty09AMQcDZvx7SRUdytXDOea6fk/e5rmuVMS3mqZlW5oIRO9Cg7TTFn81QX/zMiWcUM1pUH4eRn7ASHha9Qd+UU9eGCUyYZGacaBa8dMnZYz9cTAvccDMTKZtRAzK6tkO8jjjpjFhJF7AQfNrYZM8s7gvNLO/ceIvS0YN2r9+VcspZ4fLZSE6HXhTvMO7YXvx0BB6vFKUe2ncer8bFQIXzH9Pz1wnIRopBu+ebBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFMA7GA/1zeD7PmqA14azxn3YUyGJbRW/mDgcJhb1zs=;
 b=R0+gpUjE5jwcCHZYLz3f1bEsvQhHQJY9L3ju3TEaJiNvBOEEdj5u6e0pF2ZfqXxNzTH4W4s/f5rWsIdBbBb2effyVdcFFNOy4w0doCKqJHU3aHPc/G1Qa9oCm+2wHKMkVif0J/45vQo+Fu4WlmL9RJAy7ZXq9z4DgObd5SoV3qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:01:13 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:01:13 +0000
Message-ID: <3a8944bb-4390-d6fe-941b-d22f8e05f36c@amd.com>
Date: Mon, 18 Mar 2024 20:01:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240318161140.2101-1-shashank.sharma@amd.com>
 <BL3PR12MB642593F5E2264E6ECF645021EE2D2@BL3PR12MB6425.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BL3PR12MB642593F5E2264E6ECF645021EE2D2@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ac2440-2a56-4779-cf21-08dc477dc834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGz/YsIPO8jc+7++ZekBrIWyr5RCY6kA/zB49GLIsb/qJcrHM9xCQD1gQDbIutw1MA5B8jygMoF77vxjXcOQxnirgsDzTgJNhcyOGzZtzQQWvl4cRgQnm+4G2Z+SyKJ8ugKx9GYwjJrh28JfvoLwyW94fTWW2g5yPQvT8TYWu19Y/9Mzu4dTmrMmdCbUj+xaHHRpY2+aGnLLj8nPMM5O9+zV66CVO+gwMPbDa8SPlBykjASvcGVv3PTxYDZ+X+9t2eiueSBYGHVV2idf2J9RbLDXTf1a41YRHLToziAtL0od48m3MaJDswCQbkbPGCuTgQHAK3bgUhQp9kJssFXensN6rZlANinO0OYyfpCwBmuVrQ3mc1PwaKkE9OWHNG92TN0t5FGJMvMj/tI6jPz/h0P55GVU08DvgyMGBUhhbIbQrbeZNT2pTeS1EOe0q9E1/rMx8HyXSX2khN7/kII9JYsWCDobmakvMRtWpDSgxIDBrKcRoGgQdh4/H2RmnWkDQhUGLYK8iGhtD7HvfhMlk11MYKWeQaVQ+MWEkwl6Qc1DU7EsXebvwfZCDRSUyNBDLd141em+BAgBu6V0o8UbgRUYxPfQPESjGaWVhCZ8R7mgKwsexDg5uL21hA7Mao3dhZUbmn2ellV1KpC5IAzKD1s7WjKReL7dWdHpuzcB6xA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZYZWxmVFpodXF4a1h6ckxFbmNvK2VZOWQ2L0JTWGpKdlEzSUU0TzRYQzNo?=
 =?utf-8?B?L25EZUE3OW5rOWJGZlo3Mkd5OVNBakxpL0VyUmFtRTEzZVBKczFpNkQwL0pS?=
 =?utf-8?B?enhyMFM2ODBkVEZTYWJNMDdUaDB3dUNUZ3VLajN2aXV1Zkkwa2VTU3JueVBn?=
 =?utf-8?B?b2YzaStBZFNqNk04OTM0TTVUN2w5L09BNnM1SWtxRVc5dzdNRjFoeExzcGhq?=
 =?utf-8?B?Y1VkNEs0VEIwRU53cVdZeFg4bGZyMFl4OUdmYkxadmhJYnliK1R1Y1paTlY3?=
 =?utf-8?B?ci9POGxzMEI5ZTUxWldWVk9kNUNuSStWd1ltQUwvTmsyUTBNa1NQWjExYjNh?=
 =?utf-8?B?Q0YwdS9oNTM4VDljTnB1ZmF0RUgweVdqeEdicVg2UjhUKzByNlJYTGNoejdX?=
 =?utf-8?B?VnlLdjAyR2d6VEFpaS90ZmhTRUJHZURVS3cvSnJUTFJEVnNVeUhtc0NBeUh6?=
 =?utf-8?B?bE5lRC9aS3Z0VDVYVlZZN0pIM3RkNDFGVmdmQXJSbzVEU1lPYXZDeHF6K05v?=
 =?utf-8?B?RkYxNnIzbnp3U0Y1am9HTVRBdzZkYzFtTmNmWC9qNTZ3eEdTcUxpanc4ZUNl?=
 =?utf-8?B?b29SSHAwYmtTOGIxcDE1U3Avek44MXNwVzhPdzA5eC9zT3p0S09LSUtFSEpI?=
 =?utf-8?B?OXEyS0s1MHhlcjg0RDlxcXhWZzBtYklza2lac05PbWloSlZKYjY1TVlraHE4?=
 =?utf-8?B?RTRtS3J0aitDQkI4MldHeTE3dFZWQi80ZDdmdzZmYkUrTllBcVFCL1JsTFFT?=
 =?utf-8?B?M0F1dnE3bGFiczdUTGhTMXh6T2R0Q1JZVGJYaEJDZ25qc2lLSmw0NnhXdDM0?=
 =?utf-8?B?eXlFQm05YzVicnhQU3YvUzlYQ2VTeTlzSHlpMGdTU3pibVlML3RXUWhaQkha?=
 =?utf-8?B?VXBZNTFhdTVFNzNHdmZGOW1BVXUxWkMvTU5LZ1RTOGtQRXA4TEJKWjFzNWdD?=
 =?utf-8?B?UFZOYTdmTkNsTTZQaFpMVlNaQWpGQm5iaWFyKzBQaC8rckVTbTFnWHlWekVT?=
 =?utf-8?B?UXBUZWtpaHBibkI5ZklNOWsySjdpc2RYMWk5TlovVGlYR2w3cmp4QmFXSG1x?=
 =?utf-8?B?V3JwZ1NpUnJTbVJxNG83bWtvN2Fwem1Tb1N0MjVHamwzSm0xY1M1YzJWeUs3?=
 =?utf-8?B?TkdGQlRteTRBWWVHMFc5bURGNjVVZzhtRWZkLzFiQUJZM2JZdUcrTGVmSU5X?=
 =?utf-8?B?U1dseTIvWTdjYkpUeEIzd2Z6RWZMSE5JRmdTK3BRR2pGVDdTV2Y3dlNuK2gy?=
 =?utf-8?B?cjhkMlU3MFhiYVJjb2JlMnJUUXhSdmd4dytIZ1ZTSWlkU1JaRDVlMTgzQVRO?=
 =?utf-8?B?STBvVXJtRkxMWnZvUk5ZKzRFS3huNU1FRFpSbjZPTCsvM0NsVWxrZFNGc0N1?=
 =?utf-8?B?K3pUMUUrQXBHeXpURmY1aW15ejBTTzd4dS9kMFFoUkJqLy8wamo2TjIzS0sy?=
 =?utf-8?B?aVJrTUZYY0U3SHdFeXMzY3llZjZwb3Zpc3FqMDBBQlBYSm5jSThCT1VvTjNk?=
 =?utf-8?B?ZzAvblBJby95b2lMOGNHSHY4MDA5NUFwdDMrKzNrTVZKZWlEZ0QwN3ZBZ296?=
 =?utf-8?B?Szk1OTJISXFKdlA1UDJmY1c4OWFhUVlUYm4wUFBXUU9DemUyU09EYVRTajg5?=
 =?utf-8?B?aWlOYW1IQUtxUFRIeGk3VHhDd1NVZGFMNmM4Qkx4bkNYUzJRYjNvaVpxcHhG?=
 =?utf-8?B?M21wZEU1eHBRMWo4YmZzNHFub0lYNzZLZ3o4MkhzMUI4a2tiZ2x2Yk43UEVr?=
 =?utf-8?B?bTlzc2xlYklSTFkzRElYa1FUYmFNbDRpMTFtTUwwSjIrYWMzYjFaVkdLcS9M?=
 =?utf-8?B?YkxKblQzb3dOOWw4UGtEeDh0L1lxZ2xIZjdXRjBTTTdrL1c5VWhKbmhvdmw0?=
 =?utf-8?B?LzdDU2tObTZ1Tnd4M3lQZkl1YkhlR1Z1SzYrM1F2NGJFODR3WXlTV3FvV0xD?=
 =?utf-8?B?MkVsKzBLSnNRZmtrUDNETWhQRllSL1BtWm1iY3FpdVhTT0lRNFJjUHlBU2hZ?=
 =?utf-8?B?MkhTVUNscEFpdkpqMzlkYjZubGx1Z2l2aEM0eFpjOVdZZG5rYis1eXdTRy9u?=
 =?utf-8?B?T3N3Q0Z1MEdUQzB3OEl3dWdQUWpVT2p0eGRTdkRuK0ExdEwxSFFpdGlBaSta?=
 =?utf-8?Q?H91adDyLyezmu61lDeBBUr1xg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ac2440-2a56-4779-cf21-08dc477dc834
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:01:13.6393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYI7Pp3XTPAJVzo2r7QcmHmwHMZtN0d6xRTzaFJATNx6BkByp9eqjrPZyt7QxIdLgIjNcqwpu+3V7ID8KbWreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
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


On 18/03/2024 18:30, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Shashank Sharma
>> Sent: Monday, March 18, 2024 12:12 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Bhardwaj, Rajneesh
>> <Rajneesh.Bhardwaj@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: [PATCH v9 1/2] drm/amdgpu: implement TLB flush fence
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> From: Christian Koenig <christian.koenig@amd.com>
>>
>> The problem is that when (for example) 4k pages are replaced with a single 2M
>> page we need to wait for change to be flushed out by invalidating the TLB
>> before the PT can be freed.
>>
>> Solve this by moving the TLB flush into a DMA-fence object which can be used
>> to delay the freeing of the PT BOs until it is signaled.
>>
>> V2: (Shashank)
>>      - rebase
>>      - set dma_fence_error only in case of error
>>      - add tlb_flush fence only when PT/PD BO is locked (Felix)
>>      - use vm->pasid when f is NULL (Mukul)
>>
>> V4: - add a wait for (f->dependency) in tlb_fence_work (Christian)
>>      - move the misplaced fence_create call to the end (Philip)
>>
>> V5: - free the f->dependency properly
>>
>> V6: (Shashank)
>>      - light code movement, moved all the clean-up in previous patch
>>      - introduce params.needs_flush and its usage in this patch
>>      - rebase without TLB HW sequence patch
>>
>> V7:
>>     - Keep the vm->last_update_fence and tlb_cb code until
>>       we can fix the HW sequencing (Christian)
>>     - Move all the tlb_fence related code in a separate function so that
>>       its easier to read and review
>>
>> V9: Addressed review comments from Christian
>>      - start PT update only when we have callback memory allocated
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  64 +++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   4 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 112
>> ++++++++++++++++++
>>   7 files changed, 175 insertions(+), 22 deletions(-)  create mode 100644
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 4536c8ad0e11..f24f11ac3e92 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -70,7 +70,8 @@ amdgpu-y += amdgpu_device.o
>> amdgpu_doorbell_mgr.o amdgpu_kms.o \
>>          amdgpu_cs.o amdgpu_bios.o amdgpu_benchmark.o \
>>          atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>          atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>> -       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o
>> amdgpu_pll.o \
>> +       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o
>> amdgpu_vm_tlb_fence.o \
>> +       amdgpu_ib.o amdgpu_pll.o \
>>          amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>          amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
>> amdgpu_virt.o \
>>          amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \ diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 81fb3465e197..104bf600c85f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -885,6 +885,44 @@ static void amdgpu_vm_tlb_seq_cb(struct
>> dma_fence *fence,
>>          kfree(tlb_cb);
>>   }
>>
>> +/**
>> + * amdgpu_vm_tlb_flush - prepare TLB flush
>> + *
>> + * @params: parameters for update
>> + * @fence: input fence to sync TLB flush with
>> + * @tlb_cb: the callback structure
>> + *
>> + * Increments the tlb sequence to make sure that future CS execute a VM
>> flush.
>> + */
>> +static void
>> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>> +                   struct dma_fence **fence,
>> +                   struct amdgpu_vm_tlb_seq_struct *tlb_cb) {
>> +       struct amdgpu_vm *vm = params->vm;
>> +
>> +       if (!fence || !*fence)
>> +               return;
>> +
>> +       tlb_cb->vm = vm;
>> +       if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
>> +                                   amdgpu_vm_tlb_seq_cb)) {
>> +               dma_fence_put(vm->last_tlb_flush);
>> +               vm->last_tlb_flush = dma_fence_get(*fence);
>> +       } else {
>> +               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> +       }
>> +
>> +       /* Prepare a TLB flush fence to be attached to PTs */
>> +       if (!params->unlocked && vm->is_compute_context) {
>> +               amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
>> +
>> +               /* Makes sure no PD/PT is freed before the flush */
>> +               dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> +                                  DMA_RESV_USAGE_BOOKKEEP);
>> +       }
>> +}
>> +
>>   /**
>>    * amdgpu_vm_update_range - update a range in the vm page table
>>    *
>> @@ -916,8 +954,8 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>                             struct ttm_resource *res, dma_addr_t *pages_addr,
>>                             struct dma_fence **fence)  {
>> -       struct amdgpu_vm_update_params params;
>>          struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>> +       struct amdgpu_vm_update_params params;
>>          struct amdgpu_res_cursor cursor;
>>          enum amdgpu_sync_mode sync_mode;
>>          int r, idx;
>> @@ -926,10 +964,8 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>                  return -ENODEV;
>>
>>          tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
>> -       if (!tlb_cb) {
>> -               r = -ENOMEM;
>> -               goto error_unlock;
>> -       }
>> +       if (!tlb_cb)
>> +               return -ENOMEM;
>>
> Do you not need to call drm_dev_exit() if this tlb_cb allocation fails?

Yep, I missed that while restoring the goto in V8, will fix that.

- Shashank

>
> Regards,
> Mukul
>
>>          /* Vega20+XGMI where PTEs get inadvertently cached in L2 texture cache,
>>           * heavy-weight flush TLB unconditionally.
>> @@ -948,6 +984,7 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>          params.immediate = immediate;
>>          params.pages_addr = pages_addr;
>>          params.unlocked = unlocked;
>> +       params.needs_flush = flush_tlb;
>>          params.allow_override = allow_override;
>>
>>          /* Implicitly sync to command submissions in the same VM before @@ -
>> 1031,24 +1068,16 @@ int amdgpu_vm_update_range(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>          }
>>
>>          r = vm->update_funcs->commit(&params, fence);
>> +       if (r)
>> +               goto error_free;
>>
>> -       if (flush_tlb || params.table_freed) {
>> -               tlb_cb->vm = vm;
>> -               if (fence && *fence &&
>> -                   !dma_fence_add_callback(*fence, &tlb_cb->cb,
>> -                                          amdgpu_vm_tlb_seq_cb)) {
>> -                       dma_fence_put(vm->last_tlb_flush);
>> -                       vm->last_tlb_flush = dma_fence_get(*fence);
>> -               } else {
>> -                       amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
>> -               }
>> +       if (params.needs_flush) {
>> +               amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
>>                  tlb_cb = NULL;
>>          }
>>
>>   error_free:
>>          kfree(tlb_cb);
>> -
>> -error_unlock:
>>          amdgpu_vm_eviction_unlock(vm);
>>          drm_dev_exit(idx);
>>          return r;
>> @@ -2391,6 +2420,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm,
>>
>>          mutex_init(&vm->eviction_lock);
>>          vm->evicting = false;
>> +       vm->tlb_fence_context = dma_fence_context_alloc(1);
>>
>>          r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
>>                                  false, &root, xcp_id); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8efa8422f4f7..b0a4fe683352 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -257,9 +257,9 @@ struct amdgpu_vm_update_params {
>>          unsigned int num_dw_left;
>>
>>          /**
>> -        * @table_freed: return true if page table is freed when updating
>> +        * @needs_flush: true whenever we need to invalidate the TLB
>>           */
>> -       bool table_freed;
>> +       bool needs_flush;
>>
>>          /**
>>           * @allow_override: true for memory that is not uncached: allows MTYPE
>> @@ -342,6 +342,7 @@ struct amdgpu_vm {
>>          atomic64_t              tlb_seq;
>>          struct dma_fence        *last_tlb_flush;
>>          atomic64_t              kfd_last_flushed_seq;
>> +       uint64_t                tlb_fence_context;
>>
>>          /* How many times we had to re-generate the page tables */
>>          uint64_t                generation;
>> @@ -611,5 +612,8 @@ void amdgpu_vm_update_fault_cache(struct
>> amdgpu_device *adev,
>>                                    uint64_t addr,
>>                                    uint32_t status,
>>                                    unsigned int vmhub);
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>> +                                struct amdgpu_vm *vm,
>> +                                struct dma_fence **fence);
>>
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index 6e31621452de..3895bd7d176a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -108,7 +108,9 @@ static int amdgpu_vm_cpu_update(struct
>> amdgpu_vm_update_params *p,  static int amdgpu_vm_cpu_commit(struct
>> amdgpu_vm_update_params *p,
>>                                  struct dma_fence **fence)  {
>> -       /* Flush HDP */
>> +       if (p->needs_flush)
>> +               atomic64_inc(&p->vm->tlb_seq);
>> +
>>          mb();
>>          amdgpu_device_flush_hdp(p->adev, NULL);
>>          return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 124389a6bf48..601df0ce8290 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -972,7 +972,7 @@ int amdgpu_vm_ptes_update(struct
>> amdgpu_vm_update_params *params,
>>                          while (cursor.pfn < frag_start) {
>>                                  /* Make sure previous mapping is freed */
>>                                  if (cursor.entry->bo) {
>> -                                       params->table_freed = true;
>> +                                       params->needs_flush = true;
>>                                          amdgpu_vm_pt_free_dfs(adev, params->vm,
>>                                                                &cursor,
>>                                                                params->unlocked); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> index 349416e176a1..66e8a016126b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>> @@ -126,6 +126,10 @@ static int amdgpu_vm_sdma_commit(struct
>> amdgpu_vm_update_params *p,
>>
>>          WARN_ON(ib->length_dw == 0);
>>          amdgpu_ring_pad_ib(ring, ib);
>> +
>> +       if (p->needs_flush)
>> +               atomic64_inc(&p->vm->tlb_seq);
>> +
>>          WARN_ON(ib->length_dw > p->num_dw_left);
>>          f = amdgpu_job_submit(p->job);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> new file mode 100644
>> index 000000000000..51cddfa3f1e8
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>> EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>> THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +#include <linux/dma-fence.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_gmc.h"
>> +
>> +struct amdgpu_tlb_fence {
>> +       struct dma_fence        base;
>> +       struct amdgpu_device    *adev;
>> +       struct dma_fence        *dependency;
>> +       struct work_struct      work;
>> +       spinlock_t              lock;
>> +       uint16_t                pasid;
>> +
>> +};
>> +
>> +static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence
>> +*fence) {
>> +       return "amdgpu tlb fence";
>> +}
>> +
>> +static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence
>> +*f) {
>> +       return "amdgpu tlb timeline";
>> +}
>> +
>> +static void amdgpu_tlb_fence_work(struct work_struct *work) {
>> +       struct amdgpu_tlb_fence *f = container_of(work, typeof(*f), work);
>> +       int r;
>> +
>> +       if (f->dependency) {
>> +               dma_fence_wait(f->dependency, false);
>> +               dma_fence_put(f->dependency);
>> +               f->dependency = NULL;
>> +       }
>> +
>> +       r = amdgpu_gmc_flush_gpu_tlb_pasid(f->adev, f->pasid, 2, true, 0);
>> +       if (r) {
>> +               dev_err(f->adev->dev, "TLB flush failed for PASID %d.\n",
>> +                       f->pasid);
>> +               dma_fence_set_error(&f->base, r);
>> +       }
>> +
>> +       dma_fence_signal(&f->base);
>> +       dma_fence_put(&f->base);
>> +}
>> +
>> +static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
>> +       .use_64bit_seqno = true,
>> +       .get_driver_name = amdgpu_tlb_fence_get_driver_name,
>> +       .get_timeline_name = amdgpu_tlb_fence_get_timeline_name
>> +};
>> +
>> +void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct
>> amdgpu_vm *vm,
>> +                               struct dma_fence **fence) {
>> +       struct amdgpu_tlb_fence *f;
>> +
>> +       f = kmalloc(sizeof(*f), GFP_KERNEL);
>> +       if (!f) {
>> +               /*
>> +                * We can't fail since the PDEs and PTEs are already updated, so
>> +                * just block for the dependency and execute the TLB flush
>> +                */
>> +               if (*fence)
>> +                       dma_fence_wait(*fence, false);
>> +
>> +               amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
>> +               *fence = dma_fence_get_stub();
>> +               return;
>> +       }
>> +
>> +       f->adev = adev;
>> +       f->dependency = *fence;
>> +       f->pasid = vm->pasid;
>> +       INIT_WORK(&f->work, amdgpu_tlb_fence_work);
>> +       spin_lock_init(&f->lock);
>> +
>> +       dma_fence_init(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
>> +                      vm->tlb_fence_context,
>> + atomic64_read(&vm->tlb_seq));
>> +
>> +       /* TODO: We probably need a separate wq here */
>> +       dma_fence_get(&f->base);
>> +       schedule_work(&f->work);
>> +
>> +       *fence = &f->base;
>> +}
>> --
>> 2.43.2
