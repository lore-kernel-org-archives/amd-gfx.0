Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047AAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 17:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF3210F0F5;
	Fri, 12 Apr 2024 17:31:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jo0Hm+f6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9252A10F202
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 17:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZtDIdDyy4Nt8FeHm3rHEXvYkCJhKZI71WUQvU8ZLJpwsvWpwV+JI1oXMQGPzr0dYnmmC3gUXn5CPoXpWMai1BsXSlvv/umiKiK9w7LnID4yAzPYp45Yn6ImSFXWxeu7M+zr7SCqZTmfPp2BO2J7QXkguFxbwBQOzmJjlGP2d5O/XdDL3BSsmK7FCHZYt/GqEcVpsw2F79b5+lNzWE9y8hq2pcEoyPdzlGreaRQBOTA64EXZzjx0eu76aFPlOZtMwK01nWSeqEYpszvdfcGmIFdSXHTwEsvVdOqtQ8eGWwMWuyDTVeQkWcirXvfmC9x0p3IstvC0xQpiFIcSuJcxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2itRpGDO/XnKisaWlaJEEN/PfRXYCC0bHF/JSmI5D8=;
 b=mFiD61GZgTHSHRNKC+U/LkZTBbURErQhebT49JxAmG0q428z3AVV5HVXvn52WIm7wVOBgSff4ddugeUu3iklFmSxa8X7MV0bcnVGNlSEZxCz60qKnmKpP+N3LoVRiyQ+indRiwdjOGZc1fDG27dlfrhf/u4wuXGZtR3GXkc7SR1HCV6BTZN+1Sa2p5CgZl8KvEnsP1nO6tiQpxIY+mk5Jdah5Mze048NbkW28QypnIeoF0VwVLZrVVhGUHyFLm9eRRj7JaRLfEsGXnAujYEYQeM1s4BGqwOaA5OD5drkwYQYA1pckYG41utVlJMR0NmyCwXZSzWFKpQyLFoFP3ikfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2itRpGDO/XnKisaWlaJEEN/PfRXYCC0bHF/JSmI5D8=;
 b=Jo0Hm+f6e8zION2LyAFo1UHtU3A6Rv8DpPmssetKtdcEQnGwguL/EFAiuU8t3TUPrgs12Su2wzOc80QQn6GJAXOzAvFSPaE1tROu7g32IjmD54kTq/NKMwqvFXxtheJ7j8/gYzFxcMoqF8usLL0owhfM0XTOCBfPMzjClyRQYQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 17:31:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 17:31:35 +0000
Content-Type: multipart/alternative;
 boundary="------------OxMUwlQn8Ljy4FJUgFRZUh2H"
Message-ID: <4be19b73-fe80-4803-b97d-2c9995699e01@amd.com>
Date: Fri, 12 Apr 2024 23:01:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add support of gfx10 register dump
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240412140034.65565-1-sunil.khatri@amd.com>
 <20240412140034.65565-2-sunil.khatri@amd.com>
 <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
 <f7e75379-34eb-4733-b489-c76a2fb8f26e@amd.com>
 <CADnq5_Ow3YOBZMAWofCAyeX+TvDnGAAj=izPU5jZLsy=w1ZY0g@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_Ow3YOBZMAWofCAyeX+TvDnGAAj=izPU5jZLsy=w1ZY0g@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: d626e317-c753-408a-659c-08dc5b1666c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmvkljla4FQ1bl2RxN/P4e0q6IrGjRXCnxuVbhbXXsC5pRofagiyfb2uADD4ODpepubncQcaPww//mFPLfk53fdUwpfE/dZdlYjLstAWFwlxHVTrmmQ82aiYBa45dmow73+93UfegmhLAcEm1tFmvf77y+GCHS0q5DHebaf4Qd9HrjKEwgk9bef9Gx25nV5MeV3uAssXb1iq730qDm/n4fEx69mT8ovLADoMNt5zHBr5QY7YfplMNQZwPy2TZchLwmGZbv03PCX6N+Kuz6v4bNoBu4fMjoTiH1LxalLVCdac0Eyw5L0VYnZb2N9RTFSNfoc71dBdZx6bbJRQLFduQdU90KQ+f8n1zRexpyuyxvl4KJ6u34L01JmguWAFXfLCKLMVEwvlrW8/0d3yXQJlJxkCbz9B2z9+G32vqwDJT8S1EAjkkoG5EroZS3JUkJH+V0S7iC+cTrfiGDhzLW2aJ5oDtEYI8Dt/x6pUD3tdwnZAI+G1vxqf39vi32a/ksEYfSZrJ0MxZhCGo1nbRGHAQydhFsbryBb3mPjsONJlfoNKj/peOCubX7/pJeyZOatZaCsW/iewhNLsl0PqgBw60OWbqxyIlF/0W+c7zXOatgz5jO3ehBZF/pcLOnnJt1/trXslvp75slAtW2JnBTRRiYouc6mvZ6xquXxls46GpNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdJUTFCUW55ZlpLUGxFaytpR0xnbDh2b1hBN0NrUGtDQlFSbjJreWRkQndX?=
 =?utf-8?B?Wkt5Rk1HOWNuSHRSSytyaTlxcUIrdE9RaTRIVDZJemtuckJ6K3ZqUTR0ci9i?=
 =?utf-8?B?MlZ1aTk1K05HVGVlSVc1a1lwNm53V1NwYk03MVhwWkhVZkdBaGtxUlNRTzht?=
 =?utf-8?B?bjVMamVGZk9zK2VvMTBRQkNMV3VjaUJvQmRmUHdZWWRlRmZzZEZ2UlNUeTNU?=
 =?utf-8?B?eDRuOGQwUzROdlJTeXQwOTZVL09aNnhXeVlud1pQeTI0RnFKcmpCTkxjS3R1?=
 =?utf-8?B?VWxuRUNSMUMwVWVoR2pwVTgwZXpBTndKWGsxTVl5VFhrbXgzUllJeTAvVWFF?=
 =?utf-8?B?R0lHL1FTZ0xTcTdwOG4yU2EwcWZlNTREelAyV3NyVjlFa1BiUHd6MEI2SnQv?=
 =?utf-8?B?TE9PWDViQ0xqREswbkc5V01NWE5OYXBOMExLOGMwU01hbGdFTHAxMkZ2dlhJ?=
 =?utf-8?B?a05IYjFBbHorbnhsWmlpQUMvWHY3WWxLTVpsZklmU0xSR3FEL3drSkJNL3JO?=
 =?utf-8?B?NGJ6ekZMcE5OZUtlRkppSVVuMExDdFpCOWcrY0VBbUdQNGFQUXJmZ1NYb3Nz?=
 =?utf-8?B?ZVBUR0prVzVLdVhpeGt1aTV4YndxSE96VlAyNFR3bFkwZU51UW14bFFkUWx4?=
 =?utf-8?B?NlBvSnZLYy85RkxaQ254UTNWVTUyTTVBbWpiWUZhNjVVZ2VWTXVNWW1lRXJY?=
 =?utf-8?B?QkxNZGtsNjlLeExtOEJlbzlqTnlBNlJndlhZTWV3dU9VY1hWdGUzeWV3MGxx?=
 =?utf-8?B?NER6NG9TeGRqT3dweSswOHdQbUNERWNkdlJtL3o4QTNOK3loWFByLzRBaEJC?=
 =?utf-8?B?ZWJLdjZIOVN2QjBRNTNwdVNMSTBnckZmb0Z6MS92NFkyeHNLTnYwQ05hdC9m?=
 =?utf-8?B?SHZWdzFXbnI0ckdsdFpaL0QrQ2I2UHlmOWVlYjdLdFBTVzRpYjhBVUEraG16?=
 =?utf-8?B?cmFvK1IwSWlXS3pBN3dObkFONWNLTEhaQWVlYzVkWU95WVVzbk50UjdCQWpD?=
 =?utf-8?B?NmFNcWpGelVIOEJ3RC9LL1BOSlloaG1tK2VrRlVuazc0N3VKVk9JWG9MRXRQ?=
 =?utf-8?B?ZkF3TEE2dnBLcTEyTlh5MUlzVFF2RGV5Y25MM3NsZXI2bitEOVhSdHdEd3BJ?=
 =?utf-8?B?Q0I4RzhTcDFzRTdtSHJ5ZXFaeUt5K2ppRWtsSWVsM2ZrNG5sMm80RG52dXEr?=
 =?utf-8?B?OE5RTlpvTU9RL3JmNkFVTm1MaCticVJ3cEt3aW9ibXZEYlJMMUNNcXVyZDda?=
 =?utf-8?B?Y3FxT1VWMUFOYjJXUlRoTUt0bFpGa0VrR25LMnJGcnduZklJNzJFaXAwMFps?=
 =?utf-8?B?Qlo1eVlvbUlvbVliN2orZGw0TlZaeWtZaEZydm13WUpDQ2hCU3lMdFRFM3BG?=
 =?utf-8?B?NGdBdjMxTjNlenBVVlBmdWViTGpraWpkT0IxczNoRXQvUWo0TzdpVFBpYUht?=
 =?utf-8?B?dGdNYlpQajBuZHdPa2I1bGlMaExpMlVMWFUzQ1NNWmJFYi9KNDlFNFY0TEhT?=
 =?utf-8?B?a3dCWnd6QmFUMmRJTk1rS3BpL0dJWDV2UGY4cXV4Z3dabjZYNWdqUjZldnpM?=
 =?utf-8?B?UHdWU3B3ZkNqSjR2bG1Xd0t5dHIwdzlidFhUY0NjQ2t4bTNodmowZHhnU1k1?=
 =?utf-8?B?aWs5ZXZaUDQrK2dyc2VVdC9nR3YvT04ybnR1OENLREt6UEd1OUM3azVrN0JY?=
 =?utf-8?B?OS9OYmtCVzl4MjRuRGdWMC90ZEQ4VXgyM0tYUjQxWVFESS8rR1BNaDdiZWxv?=
 =?utf-8?B?VDdIdlFZc0ZEV1RsdVhUYWU5cjlKMm9uNS9UblB2UWYvRnQ3NWpqa09PTUVj?=
 =?utf-8?B?WEEyLzRVaWZuc2syMEFRQkdwMFhMWWI1S2VHNmV4a0QwTUJrdGExUDZnbUlV?=
 =?utf-8?B?d2FxcDVETmEyMm9Yc1c3ZWRmNm1IcmV1eDNHNzUyb1V3S3RIaWJDN1Bub3h5?=
 =?utf-8?B?UXBOZGVXK293QkxKYW85YWdUK3hUY2Y3TzVoZE5vSG43c2x6andLSzRiQTht?=
 =?utf-8?B?NGx6NjNyVGk4a0RKQVNUUlBHVkROanlhZmQyL1VmODE0bHgxR0VjSEwza1U5?=
 =?utf-8?B?dUJkalc4U09nQXorWS9KQUxncGNncVppSmRtRzFnV2V0WnlHdmZxdG5zdUZ5?=
 =?utf-8?Q?6YxaVzc0T4hQ741hzDNcpIcMi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d626e317-c753-408a-659c-08dc5b1666c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:31:35.4283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfrvY7dghNE1Atk2KMOru9XWJhpvqeewjxe3vxRkJH9H+yxsyI2JjpF4bKEhCDYW2xngociX5UFOSBjSMHjXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

--------------OxMUwlQn8Ljy4FJUgFRZUh2H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/12/2024 10:42 PM, Alex Deucher wrote:
> On Fri, Apr 12, 2024 at 1:05 PM Khatri, Sunil<sukhatri@amd.com>  wrote:
>>
>> On 4/12/2024 8:50 PM, Alex Deucher wrote:
>>> On Fri, Apr 12, 2024 at 10:00 AM Sunil Khatri<sunil.khatri@amd.com>  wrote:
>>>> Adding initial set of registers for ipdump during
>>>> devcoredump starting with gfx10 gc registers.
>>>>
>>>> ip dump is triggered when gpu reset happens via
>>>> devcoredump and the memory is allocated by each
>>>> ip and is freed once the dump is complete by
>>>> devcoredump.
>>>>
>>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 +++
>>>>    .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
>>> I would split this into two patches, one to add the core
>>> infrastructure in devcoredump and one to add gfx10 support.  The core
>>> support could be squashed into patch 1 as well.
>> Sure
>>>
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 127 +++++++++++++++++-
>>>>    .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>>>    4 files changed, 176 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 65c17c59c152..e173ad86a241 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -139,6 +139,18 @@ enum amdgpu_ss {
>>>>           AMDGPU_SS_DRV_UNLOAD
>>>>    };
>>>>
>>>> +struct hwip_reg_entry {
>>>> +       u32     hwip;
>>>> +       u32     inst;
>>>> +       u32     seg;
>>>> +       u32     reg_offset;
>>>> +};
>>>> +
>>>> +struct reg_pair {
>>>> +       u32     offset;
>>>> +       u32     value;
>>>> +};
>>>> +
>>>>    struct amdgpu_watchdog_timer {
>>>>           bool timeout_fatal_disable;
>>>>           uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
>>>> @@ -1152,6 +1164,10 @@ struct amdgpu_device {
>>>>           bool                            debug_largebar;
>>>>           bool                            debug_disable_soft_recovery;
>>>>           bool                            debug_use_vram_fw_buf;
>>>> +
>>>> +       /* IP register dump */
>>>> +       struct reg_pair                 *ip_dump;
>>>> +       uint32_t                        num_regs;
>>>>    };
>>>>
>>>>    static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> index 1129e5e5fb42..2079f67c9fac 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>>>> @@ -261,6 +261,18 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>>>           drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
>>>>           drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
>>>>
>>>> +       /* Add IP dump for each ip */
>>>> +       if (coredump->adev->ip_dump != NULL) {
>>>> +               struct reg_pair *pair;
>>>> +
>>>> +               pair = (struct reg_pair *)coredump->adev->ip_dump;
>>>> +               drm_printf(&p, "IP register dump\n");
>>>> +               drm_printf(&p, "Offset \t Value\n");
>>>> +               for (int i = 0; i < coredump->adev->num_regs; i++)
>>>> +                       drm_printf(&p, "0x%04x \t 0x%08x\n", pair[i].offset, pair[i].value);
>>>> +               drm_printf(&p, "\n");
>>>> +       }
>>>> +
>>>>           /* Add ring buffer information */
>>>>           drm_printf(&p, "Ring buffer information\n");
>>>>           for (int i = 0; i < coredump->adev->num_rings; i++) {
>>>> @@ -299,6 +311,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>>>
>>>>    static void amdgpu_devcoredump_free(void *data)
>>>>    {
>>>> +       struct amdgpu_coredump_info *temp = data;
>>>> +
>>>> +       kfree(temp->adev->ip_dump);
>>>> +       temp->adev->ip_dump = NULL;
>>>> +       temp->adev->num_regs = 0;
>>>>           kfree(data);
>>>>    }
>>>>
>>>> @@ -337,6 +354,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>>>>
>>>>           coredump->adev = adev;
>>>>
>>>> +       /* Trigger ip dump here to capture the value of registers */
>>>> +       for (int i = 0; i < adev->num_ip_blocks; i++)
>>>> +               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>> +                       adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev);
>>>> +
>>> This seems too complicated. I think it would be easier to
>> This is how all other per IP functions are called. What do you suggest ?
>>>>           ktime_get_ts64(&coredump->reset_time);
>>>>
>>>>           dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index a0bc4196ff8b..66e2915a8b4d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>>>
>>>> +static const struct hwip_reg_entry gc_reg_list_10_1[] = {
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
>>>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
>>>> +};
>>>> +
>>>>    static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
>>>> @@ -9154,6 +9247,38 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>>>           amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>>>    }
>>>>
>>>> +static void gfx_v10_ip_dump(void *handle)
>>>> +{
>>>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>>> +       struct reg_pair *ptr, *gfx10_pair;
>>>> +       uint32_t new_count;
>>>> +
>>>> +       /*
>>>> +        * Allocate memory based on the no of registers for each block.
>>>> +        * Since adev->ip_dump is common pointer and we add more
>>>> +        * memory to it as we move through different IP's of the ASIC.
>>>> +        *
>>>> +        * This memory needs to be freed after gpu reset once the ip
>>>> +        * dump is done in the devcoredump.
>>>> +        */
>>>> +       new_count = adev->num_regs + reg_count;
>>>> +       ptr = krealloc_array(adev->ip_dump, new_count, sizeof(struct reg_pair), GFP_KERNEL);
>>>> +       if (ptr) {
>>>> +               adev->ip_dump = ptr;
>>>> +               gfx10_pair = &ptr[adev->num_regs];
>>>> +               adev->num_regs = new_count;
>>>> +       } else {
>>>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       for (uint32_t i = 0; i < reg_count; i++) {
>>> Some compilers don't like variables defined within code.
>> Sure
>>
>>
>>>> +               gfx10_pair[i].offset = gc_reg_list_10_1[i].reg_offset;
>>>> +               gfx10_pair[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>>>> +       }
>>>> +}
>>> This seems too complicated.  Just pass drm_printer to the ip_dump
>>> callbacks and let each IP dump their state directly.  E.g.,
>>>
>>>          for (i = 0; i < adev->num_ip_blocks; i++) {
>>>                  if (adev->ip_blocks[i].version->funcs->dump_ip_state) {
>>>                          drm_printf(&p, "$s IP state\n",
>>> adev->ip_blocks[i].version->funcs->name);
>>>
>>> adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev, &p);
>>>                 }
>>>          }
>> I did try this but there is a problem in that approach. drm_printer is
>> created on the buffer which is provided by "amdgpu_devcoredump_read" and
>> "amdgpu_devcoredump_read" is only called when the user opens the file
>>
>> cat /sys/class/devcoredump/devcd1/data and by that time gpu is reset and
>> registers dont hold the value of interest. I tried this approach first
>> and got all FFFF or reset values of the registers.
>> We need to capture the values in "amdgpu_coredump" which is immediately
>> called after GPU reset and values are what we need for debugging.
>>
>> Crux is we need to capture data after gpu reset but read depends on when
>> user open the file which is too late and hence we need to capture all
>> the data in advance immediately after reset before recovery.
> Ah, ok.  I would suggest pre-allocating the memory to store the dump
> state in each IP block in sw_init().  I guess we'd probably need two
> IP callbacks, dump_state() and print_state().  Then call the
> ip->dump_state() in the GPU recovery sequence before we try soft
> resets, then in devcore dump you can call the ip->print_state()
> callback to print the state to the devcore dump output.

The problem is there is no standard size to proallocate memory 
statically. Each IP hold different set of registers and every time i add 
a new register set i have to update the memory size and allocate 
dynamically but this can be handled. Another problem i see with this 
approach is where to store the memory ptr of each IP. One way is to 
Directly have ptrs for each IP in amdgpu_device global struct or other 
way is to add ptr in IP specific struct withing amdgpu_device which are 
to be traversed in a hardcode way as they arent in an array or list.

For eg: we have to access each of these in a hardcode way in code as 
these structures arent in a list/array form to traverse for each ip.

/* nbio */
structamdgpu_nbionbio;
         /* hdp */
structamdgpu_hdphdp;
         /* smuio */
structamdgpu_smuiosmuio;
         /* mmhub */
structamdgpu_mmhubmmhub;
         /* gfxhub */
structamdgpu_gfxhubgfxhub;
         /* gfx */
structamdgpu_gfxgfx;
         /* sdma */
structamdgpu_sdmasdma;
         /* lsdma */
structamdgpu_lsdmalsdma;
         /* uvd */
structamdgpu_uvduvd;
         /* vce */
structamdgpu_vcevce;

In current code the approach is to add memory based on need for each IP 
in the same ptr and keep adding registers to it and we can search with 
offset value in the devcoredump to debug.

Regards
Sunil

>
> Alex
>
>> Regards
>>
>> Sunil Khatri
>>
>>> Alex
>>>
>>>> +
>>>>    static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>>           .name = "gfx_v10_0",
>>>>           .early_init = gfx_v10_0_early_init,
>>>> @@ -9170,7 +9295,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>>>           .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>>>           .set_powergating_state = gfx_v10_0_set_powergating_state,
>>>>           .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>>> -       .dump_ip_state = NULL,
>>>> +       .dump_ip_state = gfx_v10_ip_dump,
>>>>    };
>>>>
>>>>    static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>> index 4908044f7409..4c8e7fdb6976 100644
>>>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>>>> @@ -4830,6 +4830,8 @@
>>>>    #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>>>    #define mmGB_EDC_MODE                                                                                  0x1e1e
>>>>    #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>>>> +#define mmCP_DEBUG                                                                                     0x1e1f
>>>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>>>    #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>>>    #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>>>    #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>>>> @@ -7778,6 +7780,8 @@
>>>>    #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>>>    #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>>>    #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>>>    #define mmCP_MES_GP0_LO                                                                                0x2843
>>>>    #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>>>    #define mmCP_MES_GP0_HI                                                                                0x2844
>>>> @@ -9332,10 +9336,16 @@
>>>>    #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>>>    #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>>>    #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>>>    #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>>>    #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>>>    #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>>>    #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>>>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>>>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>>>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>>>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>>>    #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>>>> @@ -9720,6 +9730,8 @@
>>>>    #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>>>    #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>>>    #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>>>    #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>>>> --
>>>> 2.34.1
>>>>
--------------OxMUwlQn8Ljy4FJUgFRZUh2H
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/12/2024 10:42 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_Ow3YOBZMAWofCAyeX+TvDnGAAj=izPU5jZLsy=w1ZY0g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Fri, Apr 12, 2024 at 1:05 PM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 4/12/2024 8:50 PM, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Fri, Apr 12, 2024 at 10:00 AM Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Adding initial set of registers for ipdump during
devcoredump starting with gfx10 gc registers.

ip dump is triggered when gpu reset happens via
devcoredump and the memory is allocated by each
ip and is freed once the dump is complete by
devcoredump.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 +++
  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I would split this into two patches, one to add the core
infrastructure in devcoredump and one to add gfx10 support.  The core
support could be squashed into patch 1 as well.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Sure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 127 +++++++++++++++++-
  .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
  4 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65c17c59c152..e173ad86a241 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -139,6 +139,18 @@ enum amdgpu_ss {
         AMDGPU_SS_DRV_UNLOAD
  };

+struct hwip_reg_entry {
+       u32     hwip;
+       u32     inst;
+       u32     seg;
+       u32     reg_offset;
+};
+
+struct reg_pair {
+       u32     offset;
+       u32     value;
+};
+
  struct amdgpu_watchdog_timer {
         bool timeout_fatal_disable;
         uint32_t period; /* maxCycles = (1 &lt;&lt; period), the number of cycles before a timeout */
@@ -1152,6 +1164,10 @@ struct amdgpu_device {
         bool                            debug_largebar;
         bool                            debug_disable_soft_recovery;
         bool                            debug_use_vram_fw_buf;
+
+       /* IP register dump */
+       struct reg_pair                 *ip_dump;
+       uint32_t                        num_regs;
  };

  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 1129e5e5fb42..2079f67c9fac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -261,6 +261,18 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
         drm_printf(&amp;p, &quot;Faulty page starting at address: 0x%016llx\n&quot;, fault_info-&gt;addr);
         drm_printf(&amp;p, &quot;Protection fault status register: 0x%x\n\n&quot;, fault_info-&gt;status);

+       /* Add IP dump for each ip */
+       if (coredump-&gt;adev-&gt;ip_dump != NULL) {
+               struct reg_pair *pair;
+
+               pair = (struct reg_pair *)coredump-&gt;adev-&gt;ip_dump;
+               drm_printf(&amp;p, &quot;IP register dump\n&quot;);
+               drm_printf(&amp;p, &quot;Offset \t Value\n&quot;);
+               for (int i = 0; i &lt; coredump-&gt;adev-&gt;num_regs; i++)
+                       drm_printf(&amp;p, &quot;0x%04x \t 0x%08x\n&quot;, pair[i].offset, pair[i].value);
+               drm_printf(&amp;p, &quot;\n&quot;);
+       }
+
         /* Add ring buffer information */
         drm_printf(&amp;p, &quot;Ring buffer information\n&quot;);
         for (int i = 0; i &lt; coredump-&gt;adev-&gt;num_rings; i++) {
@@ -299,6 +311,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,

  static void amdgpu_devcoredump_free(void *data)
  {
+       struct amdgpu_coredump_info *temp = data;
+
+       kfree(temp-&gt;adev-&gt;ip_dump);
+       temp-&gt;adev-&gt;ip_dump = NULL;
+       temp-&gt;adev-&gt;num_regs = 0;
         kfree(data);
  }

@@ -337,6 +354,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,

         coredump-&gt;adev = adev;

+       /* Trigger ip dump here to capture the value of registers */
+       for (int i = 0; i &lt; adev-&gt;num_ip_blocks; i++)
+               if (adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
+                       adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state((void *)adev);
+
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">This seems too complicated. I think it would be easier to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This is how all other per IP functions are called. What do you suggest ?
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">         ktime_get_ts64(&amp;coredump-&gt;reset_time);

         dev_coredumpm(dev-&gt;dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a0bc4196ff8b..66e2915a8b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -276,6 +276,99 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec.bin&quot;);
  MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_mec2.bin&quot;);
  MODULE_FIRMWARE(&quot;amdgpu/gc_10_3_7_rlc.bin&quot;);

+static const struct hwip_reg_entry gc_reg_list_10_1[] = {
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
+       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
+       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
+       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
+       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
+};
+
  static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
@@ -9154,6 +9247,38 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
  }

+static void gfx_v10_ip_dump(void *handle)
+{
+       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
+       struct reg_pair *ptr, *gfx10_pair;
+       uint32_t new_count;
+
+       /*
+        * Allocate memory based on the no of registers for each block.
+        * Since adev-&gt;ip_dump is common pointer and we add more
+        * memory to it as we move through different IP's of the ASIC.
+        *
+        * This memory needs to be freed after gpu reset once the ip
+        * dump is done in the devcoredump.
+        */
+       new_count = adev-&gt;num_regs + reg_count;
+       ptr = krealloc_array(adev-&gt;ip_dump, new_count, sizeof(struct reg_pair), GFP_KERNEL);
+       if (ptr) {
+               adev-&gt;ip_dump = ptr;
+               gfx10_pair = &amp;ptr[adev-&gt;num_regs];
+               adev-&gt;num_regs = new_count;
+       } else {
+               DRM_ERROR(&quot;Failed to allocate memory for IP Dump\n&quot;);
+               return;
+       }
+
+       for (uint32_t i = 0; i &lt; reg_count; i++) {
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Some compilers don't like variables defined within code.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Sure


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+               gfx10_pair[i].offset = gc_reg_list_10_1[i].reg_offset;
+               gfx10_pair[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
+       }
+}
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">This seems too complicated.  Just pass drm_printer to the ip_dump
callbacks and let each IP dump their state directly.  E.g.,

        for (i = 0; i &lt; adev-&gt;num_ip_blocks; i++) {
                if (adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state) {
                        drm_printf(&amp;p, &quot;$s IP state\n&quot;,
adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name);

adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state((void *)adev, &amp;p);
               }
        }
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I did try this but there is a problem in that approach. drm_printer is
created on the buffer which is provided by &quot;amdgpu_devcoredump_read&quot; and
&quot;amdgpu_devcoredump_read&quot; is only called when the user opens the file

cat /sys/class/devcoredump/devcd1/data and by that time gpu is reset and
registers dont hold the value of interest. I tried this approach first
and got all FFFF or reset values of the registers.
We need to capture the values in &quot;amdgpu_coredump&quot; which is immediately
called after GPU reset and values are what we need for debugging.

Crux is we need to capture data after gpu reset but read depends on when
user open the file which is too late and hence we need to capture all
the data in advance immediately after reset before recovery.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ah, ok.  I would suggest pre-allocating the memory to store the dump
state in each IP block in sw_init().  I guess we'd probably need two
IP callbacks, dump_state() and print_state().  Then call the
ip-&gt;dump_state() in the GPU recovery sequence before we try soft
resets, then in devcore dump you can call the ip-&gt;print_state()
callback to print the state to the devcore dump output.</pre>
    </blockquote>
    <p>The problem is there is no standard size to proallocate memory
      statically. Each IP hold different set of registers and every time
      i add a new register set i have to update the memory size and
      allocate dynamically but this can be handled. Another problem i
      see with this approach is where to store the memory ptr of each
      IP. One way is to Directly have ptrs for each IP in amdgpu_device
      global struct or other way is to add ptr in IP specific struct
      withing amdgpu_device which are to be traversed in a hardcode way
      as they arent in an array or list.</p>
    <p>For eg: we have to access each of these in a hardcode way in code
      as these structures arent in a list/array form to traverse for
      each ip.<br>
    </p>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #6a9955;">/* nbio */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_nbio</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">nbio</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* hdp */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_hdp</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">hdp</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* smuio */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_smuio</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">smuio</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* mmhub */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_mmhub</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">mmhub</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* gfxhub */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_gfxhub</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">gfxhub</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* gfx */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_gfx</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">gfx</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* sdma */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_sdma</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #9cdcfe;">sdma</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* lsdma */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_lsdma</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">lsdma</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* uvd */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_uvd</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">uvd</span><span style="color: #cccccc;">;</span></div>
<div><span style="color: #6a9955;">&nbsp; &nbsp; &nbsp; &nbsp; /* vce */</span></div><div><span style="color: #cccccc;">&nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #569cd6;">struct</span><span style="color: #cccccc;"> </span><span style="color: #4ec9b0;">amdgpu_vce</span><span style="color: #cccccc;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span><span style="color: #9cdcfe;">vce</span><span style="color: #cccccc;">;</span></div></div>
    <p>In current code the approach is to add memory based on need for
      each IP in the same ptr and keep adding registers to it and we can
      search with offset value in the devcoredump to debug.<br>
    </p>
    <p>Regards<br>
      Sunil<br>
    </p>
    <blockquote type="cite" cite="mid:CADnq5_Ow3YOBZMAWofCAyeX+TvDnGAAj=izPU5jZLsy=w1ZY0g@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards

Sunil Khatri

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Alex

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+
  static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
         .name = &quot;gfx_v10_0&quot;,
         .early_init = gfx_v10_0_early_init,
@@ -9170,7 +9295,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
         .set_clockgating_state = gfx_v10_0_set_clockgating_state,
         .set_powergating_state = gfx_v10_0_set_powergating_state,
         .get_clockgating_state = gfx_v10_0_get_clockgating_state,
-       .dump_ip_state = NULL,
+       .dump_ip_state = gfx_v10_ip_dump,
  };

  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
index 4908044f7409..4c8e7fdb6976 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
@@ -4830,6 +4830,8 @@
  #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
  #define mmGB_EDC_MODE                                                                                  0x1e1e
  #define mmGB_EDC_MODE_BASE_IDX                                                                         0
+#define mmCP_DEBUG                                                                                     0x1e1f
+#define mmCP_DEBUG_BASE_IDX                                                                            0
  #define mmCP_FETCHER_SOURCE                                                                            0x1e22
  #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
  #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
@@ -7778,6 +7780,8 @@
  #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
  #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
  #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
+#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
  #define mmCP_MES_GP0_LO                                                                                0x2843
  #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
  #define mmCP_MES_GP0_HI                                                                                0x2844
@@ -9332,10 +9336,16 @@
  #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
  #define mmRLC_LB_CNTR_1                                                                                0x4c1c
  #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
+#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
+#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
  #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
  #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
  #define mmRLC_PG_DELAY_2                                                                               0x4c1f
  #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
+#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
+#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
+#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
+#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
  #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
  #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
  #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
@@ -9720,6 +9730,8 @@
  #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
  #define mmRLC_LB_CNTR_2                                                                                0x4de7
  #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
+#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
+#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
  #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
  #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
  #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
--
2.34.1

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------OxMUwlQn8Ljy4FJUgFRZUh2H--
