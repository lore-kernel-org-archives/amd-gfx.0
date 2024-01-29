Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7752C48285
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 16:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F96010F3BB;
	Mon, 29 Jan 2024 16:50:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED9F112A0F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 16:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj6cwFJqQ5U62OnXdNX9oou0nWq3b9b8t5l54NXu3tgDXe/P78FLE3CK78rnHDoMlMwjLhbi+T+ZCVK7zV4BPqQhBuJ1bz/YGoZ8cZZvLcxZmUGk6vnFLmzTU8L1wL/e5HSHFwIA3moq/e8tegZBTsi2Pr/FZ4Nv89KbP+CaBqvJVssULUe4AK9JalbUpGNR2x6Ch7VfVgXpV+PHRdThcK57+K0ja70ZMchk9/gip8GtJOzu5U0X8XyKCFTgda3IHQ8IKe0V8U4iz8DoGdvrq+ZQM38e+6mtfdEl5e4PgcTUDWpKSXqkuFNVdxkazWas94HrpbM5IBj4/uG29qvFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCyzbqnpATXtpteBjslRhXu1p7OZ4Rbi63+FMgHEprQ=;
 b=JYc8Cm3IrqvPo/issmw3jnI/kcIKKdiqj6zMcWRmmKQtGXR55S3CGU3CBahV6R4QmqfUzcCW18yZThFKmA8GFvZMg6jvi390w3B65GEjWdmkeECBbVHAd9hoa0RRRIvbd6Lk/KccG72F/jC6cpWsY78eK3hD/QZnWQF+JVH04U4FRlyeX2obgui6QrMJRsj9/nQHfdNNmZ/aFuMZNuV7Uqk33b5Zqp55X3+sg3Qv/gbMwZqX08YVfYeD+3aX0FGS0yz8st2vHTCkKW4OcPKG2gsVMWw+tp17bfZtKdp49yr14pMmqlaw7OBLniUt/NphsDtJKH3iX2a5dNTL8EUsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCyzbqnpATXtpteBjslRhXu1p7OZ4Rbi63+FMgHEprQ=;
 b=TR5NntrepAcj6TfK2raBF2sTKrKUEiNGp9gvthaRhUbXW8+Id3MqMUQNq7IRjdcgzrHxqq+Ih8zLguTQp4JLTO0gybzfUn2JYZQRDDl7mZARQNV9Lq7G3HC2cGbMcTEPbEzrvUJhU506dw354qZeyKb0c1skWx9PnkLNdGU8PBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:50:20 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::795e:efcc:ad1b:aafe]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::795e:efcc:ad1b:aafe%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:50:20 +0000
Message-ID: <054ed71a-446e-7ba7-e1cc-bfb08497afe4@amd.com>
Date: Mon, 29 Jan 2024 22:20:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
To: Felix Kuehling <felix.kuehling@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
 <d9143fd6-2e82-4e42-a297-962d3b806cf9@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <d9143fd6-2e82-4e42-a297-962d3b806cf9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ac9f07-d64b-4181-4d3b-08dc20ea60be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzdGCOLmqez8JRQiIgaWBl0tB1VXS6DADM6XaMFRnd/coKM+w87B65bO/Ftfk1bqKueaDoIdCZaQQa2gfStenrNytOIKvXfR61yokHTkDYn5OVHXAR3Xdg2WexNCtwt1DPDyOJwpwf2KVOkXJn3hVTHJ23I8Wu9llo0bBWRAQAE+ea+i/rPBIiXd8PrJlU6K+yb8oiSZpVB3hi1ZXUq/TOiZbxs1hFszOGTmN5gll2u2Z7832f93F63s7j1ombeDJy9GtDKpnKf0G0SR5YN4YP/ZRnAGRZrSom7vQTG1rT59MQSijQZ/Cvpr8VdXdT6tGQ3z6e/RgqTsejP3z47XS2LyG0D+Yt7Z8MvO4O6XWe5jEB5xMs6BLm5dO3I3Yy9pGTS5TcQv+rnEtZa7qcN+IDoUrTaScHk7ZjM9UsCDdT2oyGQiyDkZAWSWmn+zKTXyn3NwsDslc3XWnlqDX4UDiwNLmW3NdhH7Ta7Bm3/4CrUIJ0Xe23fd8y08yGbdiizUjL2nBWRY5ZQxKZqZx6L0fzDluQZrL2KvmWHWatTaTCrWCcu0APdSB0yZEfWeNYTEZ2WDbdFceVzQPQvSmmdldWyPGU0GXsxHAcGOIcxjSIuMlXnrNowrzRtBRLqZ2ph0q8SAgi1WkCveLsj3TpYXIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(110136005)(316002)(2616005)(83380400001)(6512007)(6506007)(66476007)(66556008)(66946007)(54906003)(31696002)(8676002)(38100700002)(4326008)(31686004)(6666004)(6486002)(26005)(53546011)(8936002)(478600001)(2906002)(5660300002)(41300700001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdqcmpweitJL2VMbFQ5UjYrb2plV0pDRHMwT0IvanN6cnFxaWlVenpWUWhq?=
 =?utf-8?B?aEJucHlMN1dvWE9kYXMwcGR6MUplK21qS2JxcXRwdUdWWU5yTmJ4L2YwamNT?=
 =?utf-8?B?QW5Sa21RWFUwbXJDbUZvbXlLamZwVkpoVktETEp6S09JWXRzaTcyQW5ZVkU1?=
 =?utf-8?B?emcxSjR6b2kvVUwxcXprclB6aGNsT0YzcWVKWDVEZDRndHhza3RWTzFGZTRw?=
 =?utf-8?B?WXkzV2ZLbDlkWnFkTUM1SUZJN0s0ZkJ2R0syL1V3Zi9sWTZsTVRpK1IwR3NZ?=
 =?utf-8?B?NzZkTU9GTzQ0WnpRdkRVZFY0dVNWdU5uMFYxV0RrNUhmVWFkeFloV2hXQVdX?=
 =?utf-8?B?WGNPNi9oT25Mb2xucmlML09WVDZvaGpKVyt2WkJ2MDhSL0Rtb0NFT0ZpdDBK?=
 =?utf-8?B?dCtZcXpUSi8zOUJtYlpWWldUVU1CZWlGdWcybjBRWktBNmxIdzJtT1E2aGdl?=
 =?utf-8?B?OGNIbFhPWXltVVp0eHMzRURZc29GYmowck9GNzIxMVUrdlRpUW5qa0RtOHRh?=
 =?utf-8?B?TFMxcXY0UHkrYjgxVlR2OGR5MW45UVNzeEtpRDNsM3JpcnUzcHp4cTNvWE9D?=
 =?utf-8?B?Z0NLR2pqdG9OR2k2UmhEazV1YnUyTUsvcWJpNEJoMSt3QkdDcFNnaTJublVI?=
 =?utf-8?B?NHhUZzhNdGV5QlRUV0xxbmEvV290d2Y4VU5oUzU4Y0xmckNqS1FJZlE3Y29U?=
 =?utf-8?B?TVUrVGxQU2tFb0hZeFZJcm5LT05zNEVkQ25tS1hJMnliZUNmSWxpM210T2U1?=
 =?utf-8?B?dWhiSk9OOUFrY1EzYjd5WE1YRzFCQzB1NldwR2ZKM0hra0d4M2xsY2tiWkNm?=
 =?utf-8?B?ZTl2QW0wNE5qcmVDcXVaT1h0c1paYUNmaTdxTTFwYzlraTVBMVZML0RMcnJ0?=
 =?utf-8?B?dEl2THZrVktKdkJLZmt2UVowUXVJb2tnVEUzUGgra3JOVjhiR2NZOEFzdHNt?=
 =?utf-8?B?NFRFWmRrOXVhM1ZaQWRNOXVNcmVpSHQrUnh5R3BlaStycVRla0txbktXekw3?=
 =?utf-8?B?VzlXbGZpTTg0YmkwZ1lmRENkRGJkV29ENVJsN0tFQzJnd1N2dEVwVzFhWmRU?=
 =?utf-8?B?bTFuSE5IM1F4TTJiSjNtWVRyUW85WXhBRlZ2ZzZ4SUNRb1pNQjRrZ0NhZTF6?=
 =?utf-8?B?TmdZaXNQVTBnMEJRSXNUald6MlZuUEFEaW8ycXZ3YzJiMkdzYWF3elJpZE93?=
 =?utf-8?B?ZDcySmlGUG1hejFmMFFhNnA4MU12UkVZSm1IWWorQmYrdXJxS2JYQy9qY1pJ?=
 =?utf-8?B?VHRyNnVSekkwM1JLVEN3eEtvOXhiWUxkL2dqWGp6S3B2MFZKY0xhck1TQm1M?=
 =?utf-8?B?ZEIvWm4xRHhIK3dUemFMTFRibUVNelBzcTlxRlFZSmJvek5DZnNGZXEzWVFK?=
 =?utf-8?B?M2JOSEQyTGtpbzZOV3dqM3BCekFhTmV4VEpBZHpmUGd5K0JBLzVST2VGcm4y?=
 =?utf-8?B?czk5WWNiUk1ROHZDdzZ1K0ZPYVowMkRMVzdmWlNUU05rcXpZZWQ5MlU5T0Yw?=
 =?utf-8?B?LzYveFg2UVl6ZVNQVnFaTVQwVmsrTGNPT0FuSFIzQ29zMU9mQVVCeTRabkIz?=
 =?utf-8?B?bk5RZ3BlSHJsd0d0VTgxNFJDY0VyNTE2RkU4dkUwM2srYWgrWURXeW1iTzJF?=
 =?utf-8?B?emhmRXk1VEdWeEtrdmVlV21iejh3VGErZGJtWk03Mm5CUTMzcnBidlJ1eVF1?=
 =?utf-8?B?REJMU2NvOUk3LzlIamdtdDloUDVXcW5hdFlOWVlCNlhzM2p1c2pvMUR0UWdq?=
 =?utf-8?B?cVhPYkZJWjlZbmlhNFFaNWpMUHBCU2lOMlhmdUVtTTlRTVRyWkxLTEpVc1ZF?=
 =?utf-8?B?YlArM2d4T1RReXhjOUZ5MXEzMzZ1dFNGekJ3elB0MTZqRFA4enRsTS9BSG8z?=
 =?utf-8?B?RURtVU05K29SSDIxRnNGMGR1djN4V0hjZ0xmRUFTVUlMN0dBa1BBS3pDWVlw?=
 =?utf-8?B?SkIzTDhtN3pUNm4xM1FJQkxiMGFqemx5K1B2djZSWkpqeHp6VW14aXRVVFpy?=
 =?utf-8?B?clM3K0E5aUMwVnBnTFYraVBlcEZtSUloZko0L29MUGNHaVROSjdjTXBWR3lt?=
 =?utf-8?B?ekZaeGcwV0gzRU9IU1pUT0xtcmNoT25UUUxwWjlvSlhQTXhsT2VPNWhwa2U1?=
 =?utf-8?Q?LdttRAjvtT1QlUjRf+reuqM1Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ac9f07-d64b-4181-4d3b-08dc20ea60be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:50:20.1588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbnCuOCLVfDgcdUfO3ZIT3QZewXwS3dEaFjmlM4rdCXyBuO+07UgQ9CjcCCZ3GmAeZaQF2JYl63ndN+VCZLGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On 1/29/2024 8:24 PM, Felix Kuehling wrote:
> On 2024-01-29 3:45, Yu, Lang wrote:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
>>> Felix
>>> Kuehling
>>> Sent: Friday, January 26, 2024 6:28 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Paneer Selvam, Arunpravin
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Subject: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM 
>>> hole (v2)
>>>
>>> The TBA and TMA, along with an unused IB allocation, reside at low 
>>> addresses in
>>> the VM address space. A stray VM fault which hits these pages must 
>>> be serviced
>>> by making their page table entries invalid.
>>> The scheduler depends upon these pages being resident and fails, 
>>> preventing a
>>> debugger from inspecting the failure state.
>>>
>>> By relocating these pages above 47 bits in the VM address space they 
>>> can only be
>>> reached when bits [63:48] are set to 1. This makes it much less 
>>> likely for a
>>> misbehaving program to generate accesses to them.
>>> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL 
>>> access with a
>>> small offset.
>>>
>>> v2:
>>> - Move it to the reserved space to avoid concflicts with Mesa
>>> - Add macros to make reserved space management easier
>>>
>>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
>>> drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
>>> 4 files changed, 30 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> index 823d31f4a2a3..53d0a458d78e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>>> @@ -28,9 +28,9 @@
>>>
>>> uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)  {
>>> -      uint64_t addr = adev->vm_manager.max_pfn <<
>>> AMDGPU_GPU_PAGE_SHIFT;
>>> +      uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
>>> +              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>>
>>> -      addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>>>        addr = amdgpu_gmc_sign_extend(addr);
>>>
>>>        return addr;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> index 3d0d56087d41..9e769ef50f2e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>> @@ -45,11 +45,8 @@
>>>   */
>>> static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device 
>>> *adev)  {
>>> -      u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>>> -
>>> -      addr -= AMDGPU_VA_RESERVED_TOP;
>>> -
>>> -      return addr;
>>> +      return AMDGPU_VA_RESERVED_SEQ64_START(
>>> +              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>> }
>>>
>>> /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 666698a57192..f23b6153d310 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -135,11 +135,19 @@ struct amdgpu_mem_stats;  #define
>>> AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) <
>>> AMDGPU_MMHUB1_START)  #define AMDGPU_IS_MMHUB1(x) ((x) >=
>>> AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>>>
>>> -/* Reserve 2MB at top/bottom of address space for kernel use */
>>> +/* Reserve space at top/bottom of address space for kernel use */
>>> #define AMDGPU_VA_RESERVED_CSA_SIZE           (2ULL << 20)
>>> +#define AMDGPU_VA_RESERVED_CSA_START(top)     ((top) \
>>> +                                               -
>>> AMDGPU_VA_RESERVED_CSA_SIZE)
>>> #define AMDGPU_VA_RESERVED_SEQ64_SIZE         (2ULL << 20)
>>> +#define AMDGPU_VA_RESERVED_SEQ64_START(top)
>>>        (AMDGPU_VA_RESERVED_CSA_START(top) \
>>> +                                               -
>>> AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE          (2ULL << 12)
>>> +#define AMDGPU_VA_RESERVED_TRAP_START(top)
>>>        (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>>> +                                               -
>>> AMDGPU_VA_RESERVED_TRAP_SIZE)
>>> #define AMDGPU_VA_RESERVED_BOTTOM             (2ULL << 20)
>>> -#define AMDGPU_VA_RESERVED_TOP
>>>        (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>> +#define AMDGPU_VA_RESERVED_TOP
>>>        (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>>> +
>>> AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>>
>>> AMDGPU_VA_RESERVED_CSA_SIZE)
>>>
>>> /* See vm_update_mode */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> index 6604a3f99c5e..f899cce25b2a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>>> @@ -36,6 +36,7 @@
>>> #include <linux/mm.h>
>>> #include <linux/mman.h>
>>> #include <linux/processor.h>
>>> +#include "amdgpu_vm.h"
>>>
>>> /*
>>>   * The primary memory I/O features being added for revisions of 
>>> gfxip @@ -
>>> 326,10 +327,16 @@ static void kfd_init_apertures_vi(struct 
>>> kfd_process_device
>>> *pdd, uint8_t id)
>>>         * with small reserved space for kernel.
>>>         * Set them to CANONICAL addresses.
>>>         */
>>> -      pdd->gpuvm_base = SVM_USER_BASE;
>>> +      pdd->gpuvm_base = max(SVM_USER_BASE,
>>> AMDGPU_VA_RESERVED_BOTTOM);
>>>        pdd->gpuvm_limit =
>>> pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>
>>> +      /* dGPUs: the reserved space for kernel
>>> +       * before SVM
>>> +       */
>>> +      pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> +      pdd->qpd.ib_base = SVM_IB_BASE;
>>> +
>>>        pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>>        pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>> }
>>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct
>>> kfd_process_device *pdd, uint8_t id)
>>>        pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>        pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>
>>> -        /* Raven needs SVM to support graphic handle, etc. Leave 
>>> the small
>>> -         * reserved space before SVM on Raven as well, even though 
>>> we don't
>>> -         * have to.
>>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so 
>>> that they
>>> -         * are used in Thunk to reserve SVM.
>>> -         */
>>> -        pdd->gpuvm_base = SVM_USER_BASE;
>>> +      pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>> Hi Felix,
>>
>> pdd->gpuvm_base changes from 16KB to 2MB after this patch.
>>
>> The default mmap_min_addr(/proc/sys/vm/mmap_min_addr) is 64KB.
>>
>> That means user could get a CPU VA < 2MB while the corresponding GPU 
>> VA has been reserved. Will this break SVM?
>
> It could break SVM if a process tries to map or access something below 
> 2MB. I'm not sure what AMDGPU_VA_RESERVED_BOTTOM is used for in the 
> GPU page tables. But if it's causing problems for real applications 
> with SVM, we should look into lowering that reservation.
>
We have decided to keep AMDGPU_VA_RESERVED_BOTTOM free for catching NULL 
pointer dereferences.

Regards,
Arun.
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Lang
>>
>>>        pdd->gpuvm_limit =
>>> pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>>
>>>        pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>>        pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>>> +
>>> +      /*
>>> +       * Place TBA/TMA on opposite side of VM hole to prevent
>>> +       * stray faults from triggering SVM on these pages.
>>> +       */
>>> +      pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
>>> +              pdd->dev->adev->vm_manager.max_pfn <<
>>> AMDGPU_GPU_PAGE_SHIFT);
>>> }
>>>
>>> int kfd_init_apertures(struct kfd_process *process) @@ -407,12 
>>> +415,6 @@ int
>>> kfd_init_apertures(struct kfd_process *process)
>>>                                        return -EINVAL;
>>>                                }
>>>                        }
>>> -
>>> -                        /* dGPUs: the reserved space for kernel
>>> -                         * before SVM
>>> -                         */
>>> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>>> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>>>                }
>>>
>>>                dev_dbg(kfd_device, "node id %u\n", id);
>>> -- 
>>> 2.34.1

