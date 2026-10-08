Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD6CCA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809A510E803;
	Thu,  8 Oct 2026 12:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KGW2XPgH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D7110E803
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8Finyi48Uz3JZ8H2Tocbiz1WamAKykoLzs+niDGDnRnFyJN0RQ0LFCZLsCZbz+w21percM3I5fU5TH9R2g1L/4AZjyt5Tpa9LywHVs1x/HLH6Kci9CvaLmrgg/Gd+zB8IAuCq2TatZYPbJ1iXajAAHrrLryXPdLjIWzpIsIiloQ2FxLMOFAgpxaNevWsk4fIfWDg1VgGBw1Y4UcIagyg98sxrXnTnvHagF7CiVc13y3Nk60NRUW7InufpY2xJevl4039KyEEqQSserlkVYYguUr+BEjQgLpDdRRYO2VHlUI3z9CLy1KbNUuaR4JqHCt3xZdiCVqxQCrYdJoSsTcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56YhKiU5yDHHaqV3D47qcF+xRx1F70Fp72eDilu4s7Q=;
 b=EoAiAtauGFP3QXTz66qabpxAmFH9Vjh/gwN9AfoFS/aIjAmjnsoiKFad4I1mPk9wfWvBOtl0q83wIGv7LwWeUflZX+sdgCbeuau6bD7wsoh8SVHw7tPkZ2bFL6s+/YX3UvpTIfk7vk803LMeOrNVDL39ycjXmuJDYkFampfafSlOOjAxoBySHH0PjbgWJDZ5O9qI8dHhaPKRqcffpQ0Lu3UweWcUSQzTzPtdS9w9SXRS1TAMni+G8ZTHTRPpC2tYOEIdSKQFd3oLWLr+gjjdu/qmqUNEI5gryHqMixAISEJfyvlnSje/ax7N+Cxt1/pGkjLPtkeHDF8s8OIre4BzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56YhKiU5yDHHaqV3D47qcF+xRx1F70Fp72eDilu4s7Q=;
 b=KGW2XPgHT4ObrhVkugtgM6Ii98OO4h456SHIX+63Jpb/Ek2rxxuSwVSdz1XXEbSMI4n4TM06RAdm84FF3rbiFhrqFaC7NsMMCgjzMaiErNq9z4ykByWppXGSWcLlZwv8jZozDBUAWn3rPobyu7h4pHYQ+VWbP/Uyhcxyv0E2cO8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.34; Thu, 8 Oct
 2026 12:33:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:33:42 +0000
Message-ID: <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
Date: Thu, 8 Oct 2026 14:33:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly.Prosyak@amd.com
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: e4db152d-4c6b-432e-bbbb-08df253862d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|10067099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gm+XeAgR3/E03wxC5dhf3kkMN89Tgj4amqu9beEw8ZCaEyvkKl9GgTXQkEbAMu2KcJo6bnmi7sRNWpd3tLN6J4oMfab9prRsVw0C5kXNPPIJv1inDo5/GdK2MY8LhzeLtjGXALTtJI0vjg8cyPY0Ji+giJFQyZ4d29hl5E1fO1yvLA4XcsowWoJ+hSIMlPa9WQX80VRqP28gn6BZSKs834l4MhuO6cEUoYFnd9teirL+gXFD/JSkS706rnMf5ex889AoYOegTj8gtymw61s3fSczj8bCULhb2SOmhjSSJ/Gwlv5d5Of4xsNStlx+Q2xJ4c6MwYfEkWXWbebg4LfxfIG2jPG3UIppsPkAkdRRkmWy7d7tNrVY87fB3VoyNCogEx4TPb7RMMa2MhzX+HsLdn+3f+xC1RlTCHLQcr5vV6UjIvdtCx0NcR88sUS4RXVNdyp0m+g3gD6nbLLZeRULyBnpxkY/axSVYdTBZgYKZDQxjHUmn2KwynehLhITW9Czr3T10CyrFQIUHKbFgRszpGeZVuTvEyghyPxfCIj43mGC8Ra5cABxGasQPtI/3Ozzn0rgHPMmiURTkV933TuN/Py2IdNlXTr5X51wRJvWGlx326G6xRElYuKGZRbliQ33FBn7GmbLgyZQ1lxAetciFKNYEaiJOQJnSDkDZUK/V3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtqakU2S0VnODA5SEpyY3NMNVMrWHlKS1NrK1Y1cDd0RDRoWklmOTdTMnlw?=
 =?utf-8?B?RmxXMW1zUVo0cVdYSTBaWE95d2tzeVh4N0FEdi9GVldzZENHZjRKKzJCcUc0?=
 =?utf-8?B?YXRVVGRVanAwVHNOOW1JendqT2FyajZMQWdWcFord0dZekw2ZXBXZnU3NVBk?=
 =?utf-8?B?bXkzYU45YkF4M2ZEd3QzalltK1BrdUpKdzNPQ1dPL2NaQUEvT2ZnaE5uV1Nm?=
 =?utf-8?B?L3pHcWRnOVllWksvcFZqODVlTk5EZlZVc3cvSzkyWDJTenRrMTZ5QXRQNkQz?=
 =?utf-8?B?b2lBOWQyRi9FWm9BSEJYalNVRTM5TGNZUWFhTmhEU1N3cDh6a3ZDa21kWTU5?=
 =?utf-8?B?Y0szaGpyaHRuZFZ3SVVwSkx6VzM1LzF0cVNTVGxjeTBZcG53b294TXorc0Fj?=
 =?utf-8?B?ZEJic0JJcENXWlpIdUpPY1hRY1RFcDE2ZlAzbUlKSDlUZUU4Qi9rcHczZ2lv?=
 =?utf-8?B?L2JvKzQvNTRQVHUxb1NVRDFNSHlKdlFub0NXNXRSRjFjZXJDSy8rWHA0ZVV0?=
 =?utf-8?B?NUpiekJCL1lHbXZhSGhHdXNDcFZlOEpSYjRsS2xzRk1SNWtyL2IyS3p5V3V0?=
 =?utf-8?B?V0lhYWwyZUJjU0QzcWdGcFFHaDZsaHptcEJoSFVUSmU0MGpuRS82dU1XZmNh?=
 =?utf-8?B?L3J1VFgwVklIYi9BWGtOWDI2NE93QmtwVXFyd3NCUHJ5RXBNOG9VS1krN1dm?=
 =?utf-8?B?SUdOOTNjNzN4cWNMTjA3eFBiZXZsaGNUcmFoUC9Zc1VrY2ZxbDBVNnd3WG0r?=
 =?utf-8?B?VkxDY3o1YWJmYnI5UG1DaVVpUi9FN0hVdUdHbnc5dGJLV1pYMUFqOXJjRzJO?=
 =?utf-8?B?V1RsRE9DNDZsWEhhMmtiS3FveUJXRWk0L1Rjc2FSd2Z2MnB2ZTV0N2lsZXVI?=
 =?utf-8?B?VU4xbnQ4YUZpckorMG5XZGdMUnlpZDBrby9YYm1vazR1U1BlRkhxc2IyNHlw?=
 =?utf-8?B?U29sL3p5eXg1bW1YQWZ4cStVZEVQbmlqY1c5WFVKdlNNdWlNOXBJZGh1VFVy?=
 =?utf-8?B?ckNBSiszNnlvOUdMeXZyeUozYVk1aDA2bFVSM3c4c2tZTmt0VXczYnpZSEZu?=
 =?utf-8?B?UVNGdDE1NnNab3I5K2loOXRDcElaU2QrZFBFKzFiRGE3czJmUEs5WVp3dExq?=
 =?utf-8?B?U1hOSlN6ZkxSbVY3SkpjNFFWN0VsT09IM28yUG91QkwrZ2dEWmN1ZjNOS2hY?=
 =?utf-8?B?azA4SVQ4eGt4YjNNM1ZST3hEcjBLOHpDZkRuamdQdVZLcW9pOFRZYWk3WFlj?=
 =?utf-8?B?T1hjTTNDQVF0MmIwanhXSWZVT0JuNFF6TnlqWWxkY2NxQUZHSW5lc3dXai9F?=
 =?utf-8?B?bk5BM21STk5JSFhnSFJwak54b2Z2WVVvWGV5ZWR0bzIrNGVmbjNCamY0dThW?=
 =?utf-8?B?aFRERWtyOXpGZzduc2ZmTkFNSWVmV2NsQ1BXWXc0ekp0OEZIcDRCTTQybHcx?=
 =?utf-8?B?dnRmSFZlN3cydTNnWjJ5dWZOU2JkN3l0ZnBhcEJYN01TRkNUMzBTU250TFVH?=
 =?utf-8?B?a1VlZ2ZPeEoyeXNqWFBlRjA1Z2FTeUxlRlFsQ2ppWnlPTDVic1RabXkxcE9k?=
 =?utf-8?B?d3Z2SnFKMXkzcFhzdDlXQTQyQlZucitzQmNDa3JGQWpOU3kwdVhzcnV5KzhP?=
 =?utf-8?B?L2o3b29Vam9JZGE0OHRESVVoYVdBQzNENDFNdHU0TGFrMUtYeUVkYnpkeTlQ?=
 =?utf-8?B?VkpwWExzeUZZbFBiUjR1c0tGb0E5NEhQdnAxMHJ3TTVvSHM3UFJHaHNzL1Y4?=
 =?utf-8?B?ZzVFeXY4bkxWS2ZSS0F6b29qNjBkN0lPNGpiK0FvQzQwVklCbVd6d1RGcjJM?=
 =?utf-8?B?K1huY3ZBcTBWODlFb3pZUnZIaU1IZHRqT05tbE5tbnI1TVI0K1FZbGRieEkz?=
 =?utf-8?B?M1YxMEtnMEhlbkp1SzZEc1lSaTFHak15bEpGYk4zOThBV1N4M0M2Y0JrWjJt?=
 =?utf-8?B?SnNMTFhCVlVJMmw5dW9RLzZNKzJCdDRWcDhnVncrSGRpTVNyck5MUjJzZkkr?=
 =?utf-8?B?OHl5SDlWV3pOTmFXS3dPZTdWd1JOL2toS2pCbWEyZWRVMzVLNnJxdDhPT24y?=
 =?utf-8?B?akJSS3ZwekxxWG1oem83OENVVHgrZXg0TGtjRitIMCtVZWhwQnZhakkyMXQv?=
 =?utf-8?B?OEQrYlU5L3lZSFhjZW9jaGZoRzkyU0czamtldHFWenNzS1lMNGpxMktpbjlq?=
 =?utf-8?B?NjdSMlZnOXMzN0VVZUFER0NxOHFNYWVaSXN4cCtJVU8zWWJVcTZnSWJ1Y1ZQ?=
 =?utf-8?B?cTJUeG55RXdET1p6K21qUnVtQ3RDc2xqdE85T3ppcWJCQmxOQTlFclpGY3J5?=
 =?utf-8?Q?MpdvY2xUYxOcm8CGQh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4db152d-4c6b-432e-bbbb-08df253862d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:33:41.9690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0SQz5WOeqUZpI3gockfe/JmPpyjCNSwiRK0Kbxn7iPFFv3oIXKWvRnA0c/POgUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

On 10/8/26 14:17, Lazar, Lijo wrote:
> 
> 
> On 29-Sep-26 9:16 AM, Prike Liang wrote:
>> Protect media idle workers with a reset-domain read trylock. On contention,
>> requeue the idle timeout and return without hardware access. Keep the
>> ordinary end-use scheduling event, including from reset-time ring tests,
>> so otherwise idle engines eventually power down and VCN drops its profile.
>>
>> A blocking read acquisition would deadlock with reset-time synchronous
>> cancellation of these workers, so the workers must only try the lock.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> index 9887a4f99aed..7b10260ad0d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>> @@ -114,6 +114,12 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>>       unsigned int fences = 0;
>>       unsigned int i, j;
>>   +    /* Reset may cancel this worker synchronously while holding the writer. */
>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>> +        schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> 
> Is there any need to schedule this work here? Being not able to get the lock indicates that a reset is in progress already.

Yeah agree. We should just block for the GPU reset to finish.

So a simple down_read(&adev->reset_domain->sem) should do it.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> +        return;
>> +    }
>> +
>>       for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>           if (adev->jpeg.harvest_config & (1U << i))
>>               continue;
>> @@ -129,6 +135,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>>           mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>>       } else
>>           schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
>> +    up_read(&adev->reset_domain->sem);
>>   }
>>     void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 17db7264269e..f851a6ecea1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -470,6 +470,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>       if (adev->vcn.harvest_config & (1 << i))
>>           return;
>>   +    /* Reset may cancel this worker synchronously while holding the writer. */
>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>> +        schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>> +        return;
>> +    }
>> +
>>       for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>           fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>   @@ -499,6 +505,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>       } else {
>>           schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>>       }
>> +    up_read(&adev->reset_domain->sem);
>>   }
>>     void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> 

