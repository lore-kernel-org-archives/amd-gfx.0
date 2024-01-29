Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ABDC47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D8E112980;
	Mon, 29 Jan 2024 14:54:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090C611296B
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 14:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZqT422m00Q+Dl30kVN66rlVS/X6P0foN7I5fu/UCYbR0g4jIEWYwiEPySDzkf7J78iC+d3BflVkcP6ZSw+aUx+htgwl69vvECKSytdtMxA5cSygJZSZEqBqnSffTgA2Yt9Mrncdtncd49aY/fEITI7nxMenjbhCFth3pFgNIvRj9lMFxXi6Vo7uaaIwGjAxUN9nWK/WZPOzj58rV93QSwyQo6slxGtLnCcszRCkCworY9e/sdgz0g0DKB07aKihGqWLk7XGor6p6qYze59cWlYviD5koYK4YtlSaqnBKsSetr3+sHYUgXigohDw+XOQevy8ZiuaNsYbwWmbmQguXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzyQzgz7fEU0C3nJIfMMIxVa5ZnyGLyXpHXAMiaWjKk=;
 b=P7p5XEXrV9XyHtjFEpgdBP3aLRskIIK1j2hOyIW0B7m67sZtMKPL8Ii1L42HHKGkMzn6VkwVXQcEvdIxyXFAfjIa5oZ5awBbCePMNULAynIKBVpNXEDegvtPx5U13/+utVSf5A+KEh+fqLXfDlXThaYO12b27T0CmGSotDZvvl/8oZdHGUe5Ke024or47ZYijREKPIm4lmIZbYmwNH3pSz7PBesa1Zn5+67yn+lKfAHby1jq9iT6ITUhc8JtdbBIfw9UMs6lqTEt7u5rm+ZbuFL72QYC8aZ8PMrEX/94Ouq58c2DeFKtegHyG1sf/nX7H4z9RhYSycvjdGoynlroMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzyQzgz7fEU0C3nJIfMMIxVa5ZnyGLyXpHXAMiaWjKk=;
 b=pPugC7LKQg9hkooR4WwH/fpf1sNKSevPyJxteN1vjrphg2t2RCrAX9CG4Wau4nxD7p/99u1H17HOHWxuw9JPBJSJfENj+k0l05fU3i0k/rmShbLo+CzGbhlML3+nfbEoFGB5a/AwptoVF+mH0Mtc1O0bOcpkGSG8BjXWqzD3Exo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:54:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:54:39 +0000
Message-ID: <d9143fd6-2e82-4e42-a297-962d3b806cf9@amd.com>
Date: Mon, 29 Jan 2024 09:54:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 09934c97-dd98-4fb8-18d0-08dc20da37d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgMDfXFraMVc2uMvxcZ7tfKe73+EkO84CZizT9Hd7cbESZCO7oJJRfjp+6iqpWQ2HAcqv511AX2meiJasOsKGFOmO4thAQIALNVIvFhTOZzID61QVTYSATA4FJoL/YU4RvX43TYNHM00myE/ojotU9cKrAoiS6R2Vx5QipZCp6s0l09uzPlUrKb2odOzV6baF2W2CNVzp0qI132s4Ts9nbze/hsQu0gt3TeFCXk7ZPSvusd/x3ruY3TFVlS4xS6r/Q48VHPosubdq3EESjLFsf6rXzgo4zZ8+U/fzWQhHeH/Vun+AGTF02F7AO5YbQJhX+cCnBMkqm0m83pJUYxhMN5sFovD47FjxJQyAA1QRL93e8M/VTiqLwYO2NWCTJvQ8Ya7ajalEQCFsR7/q0doCTXTEjri/6w+0/cvqOMVKaQZ1BeysHqG+jJeSrKQVzLZxhZl4zYr0x1jET+x5cocXWNMJ3zM7SjmuoKEhOdj0wpNeifyRZCLqYCMmRmVEDt0+X3XeUoaPQhZbNTYeBqVSkvv8tb8ElKYrGettkO2xSV1lvz1YDyWgLKnIlpLUOUn0aCYHCWY+tPFCTGfcBWcmV3KXDUknVd5U6a9SGJ0i2D4kKi1HJbDXzHD4wQaRK1OqsbjfxcEEBWG1LRdOR6oTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(2906002)(6512007)(6506007)(5660300002)(53546011)(4326008)(26005)(8936002)(66556008)(8676002)(316002)(44832011)(2616005)(110136005)(66946007)(66476007)(54906003)(38100700002)(83380400001)(6486002)(41300700001)(478600001)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHN1SGhZalZaaFE3ajRyZzEzT2ZkcFl6eWQzTy8wcXZNUEl6RkN0NGUvTHpO?=
 =?utf-8?B?WG9FSXlHNjdCUHM0R1hJVnZkalVnZVd6ODVlUk1zT1RPek9NMUhDbjBMSzl6?=
 =?utf-8?B?QXN6SFpWa09DK3plUUtVdDgvSkdxV3gzVVJsYUl0NkJaNGxzbE0vaDR6dC8v?=
 =?utf-8?B?SmJxUDFvVnJUQ3V3M1FjNXZQVldNSlhqdGlnemZrVXZZUTloQ1JOaW1rNmpt?=
 =?utf-8?B?bFVMZXNPOTEyU2VSOUpsR1VCN2ZTbjJLUmZrVW5tT1M5b1hrbGxHUXVKUzBi?=
 =?utf-8?B?UjQ1VXExSkZmQzZDcElOc3gvMlBQKzNEVjRQWmlXK2dUd254akpFZ013ZU96?=
 =?utf-8?B?WEJvSTBqMCtNTE1ETWswU2x3V2tROVFXZFMyNVFhQ0NZMmJsSHo0TnlaQ08x?=
 =?utf-8?B?RmxQYmliMm9EdWpQdG1mL21OTXJNeFlmWFRQZ21YKzhvQUFzZzlZS1JqbG5U?=
 =?utf-8?B?c3QvRmRBN1Y5a1YyTllZVktVVWJpNDJwaXoxRm9kRkJRTGNzYjlLTUFLTGhG?=
 =?utf-8?B?VHRkYXVDcEZKQ2I1dkx0dDc5M0pPd1c0dGowQnNEY2hJUWNxSjY0VkJscm9L?=
 =?utf-8?B?QjQrbjM0VEhxTHNLclIyMi8vY2VQK3phUlVVenNvQVhiYzVGbGNwemhqeHZj?=
 =?utf-8?B?d25xcHMxR2tDK1FxdlVQNnFSTEkyMzVUMUNxRUVSdnF0Z1V4T3p2NUJBTmR2?=
 =?utf-8?B?ZFJsTEVncDZVTDZOSURuYWRkS1dsVkVUK2ZCY0Q0endYeVlISDNEZ3JYcW1J?=
 =?utf-8?B?ZEFwK1NycGtXem5uc3BBcDl1bFlvOVRYVDI3c1RnSFRRa2FVZjc0OWRiZjM1?=
 =?utf-8?B?K1NxNWJjWDkyV2VKaVNwYnduNktXVDhnd2F4SWdNWkQ0b0N5b2ppNEVoTkt1?=
 =?utf-8?B?UTQ3Vi9JYnhlaWRRWTliblFqRXN3TnI5dlJWS1BVTmUvUDdwWlJCdDRvVWw5?=
 =?utf-8?B?UUZPWngwR2tNdXZ5UmVSeXhveUNkRW1BUkFQMFBKMUI2b2l2S3ZjYktBRHZ0?=
 =?utf-8?B?RE05bnk1bHhNWTNhK2JUUlVJZzlHNnQzcWtaY3BqaUk5clR4Yk1qMUhQVzV4?=
 =?utf-8?B?SGl4a0duSzhXdEdxdk5DWGhtSE1SbEwzMS92WUJ5N2duUHBXWk4rT2V6cyty?=
 =?utf-8?B?ZG5RWC9IM0VRM2gxNlhySjZDZmJHbDJSVHZpekJyMDlxak5MQmdSYWlUbEJE?=
 =?utf-8?B?Mjlzc25CaFFvQy9qUFBzMmdrUzIvaUJHaHQ4OVNWVG1UYVhJaHFlMzRNdnAw?=
 =?utf-8?B?RkFQV0dkcFgyTzdPaXdKcFNrdy81cEdEbVhkenloR3Z1Y3VNYUxockdFcFJv?=
 =?utf-8?B?dm94RjVZZm9VdTZHZi9WYmVJNjJsV0E5WDY4UEd1VXlNcEJ6VGQrb0pNUlFU?=
 =?utf-8?B?bDBEYUhLVkQvSk9iQis1anBKcG43MzAzdFpzVjFPcVpPcW1UbDlBcjhEdjc5?=
 =?utf-8?B?VTZCS2h1WVZUL2pyTzNPdFI5bHVBbGZEaWlRSW9PRSt1cHBVRENyckxXVkpS?=
 =?utf-8?B?UmJzQUJqeFJHdGR2dk5pN3l4VFd1QXBQRVY2Sm9HV1ZqUFVVNERPdVROMUlE?=
 =?utf-8?B?VmVoaFNTSjVOOGN1SHRjR285bGVMUnJYcTB3ZUgrRDAwOCtCV3RWRVJldUln?=
 =?utf-8?B?WnQ4ZFRBbFRTQ0ZwY1hncEFERUdNVXhSbENGZ3BRL3dvNG1UeU85QW9hUVQ4?=
 =?utf-8?B?VzlJeFNua0R2dGVXbWdzbnNpWXlYSEFBRzFpKzJPb21QYlRNYllidkFVeU13?=
 =?utf-8?B?SzlZeHFYUEl2TUNNV0xxU3U2cjdRR3ZQYzNFSnptYW9vaStKOHdETHpLY1Qv?=
 =?utf-8?B?cjh6Q21pRzllUVBDZytCZFhpTm1iZll1SnpwcVZVd1EvSmtFTXhmVXAzT2hu?=
 =?utf-8?B?a2ZEZTE0YUFOK2lEdi9yZ3NURUpvSzcxLzJLR2FaWDVST1NpR2tGbVY2ODhC?=
 =?utf-8?B?b2xMVjN2M1ZCU0pGOXRseHRWZFNUNHlyckkrSE92dEhETThSWDdkVDlOcWxK?=
 =?utf-8?B?SiszTzhOaGgvNFBwd2dLaDljLzRTR3ZSNWJzTlpXc3A2NUUzdllXRVR3a1dM?=
 =?utf-8?B?eUJlYnFVdFdLUkFDdHNqZWw2UU5RQTE2NjFtODVTYkRQZGluN2lIUEg2NVU5?=
 =?utf-8?Q?I0+Qtx2ccgqVkDxLCPnXq9qph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09934c97-dd98-4fb8-18d0-08dc20da37d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:54:39.2802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8scQIRkLKfPCjY2bkik4n0AnotjBWBY4GBRDVbspjEompH6/a9wv3iCMkRjREv7tEePPVhLMS8tVw/3Ql8gXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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
 Christian" <Christian.Koenig@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2024-01-29 3:45, Yu, Lang wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
>> Kuehling
>> Sent: Friday, January 26, 2024 6:28 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Paneer Selvam, Arunpravin
>> <Arunpravin.PaneerSelvam@amd.com>
>> Subject: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole (v2)
>>
>> The TBA and TMA, along with an unused IB allocation, reside at low addresses in
>> the VM address space. A stray VM fault which hits these pages must be serviced
>> by making their page table entries invalid.
>> The scheduler depends upon these pages being resident and fails, preventing a
>> debugger from inspecting the failure state.
>>
>> By relocating these pages above 47 bits in the VM address space they can only be
>> reached when bits [63:48] are set to 1. This makes it much less likely for a
>> misbehaving program to generate accesses to them.
>> The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL access with a
>> small offset.
>>
>> v2:
>> - Move it to the reserved space to avoid concflicts with Mesa
>> - Add macros to make reserved space management easier
>>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
>> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
>> drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
>> 4 files changed, 30 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> index 823d31f4a2a3..53d0a458d78e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>> @@ -28,9 +28,9 @@
>>
>> uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)  {
>> -      uint64_t addr = adev->vm_manager.max_pfn <<
>> AMDGPU_GPU_PAGE_SHIFT;
>> +      uint64_t addr = AMDGPU_VA_RESERVED_CSA_START(
>> +              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>>
>> -      addr -= AMDGPU_VA_RESERVED_CSA_SIZE;
>>        addr = amdgpu_gmc_sign_extend(addr);
>>
>>        return addr;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> index 3d0d56087d41..9e769ef50f2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> @@ -45,11 +45,8 @@
>>   */
>> static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)  {
>> -      u64 addr = adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>> -
>> -      addr -= AMDGPU_VA_RESERVED_TOP;
>> -
>> -      return addr;
>> +      return AMDGPU_VA_RESERVED_SEQ64_START(
>> +              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>> }
>>
>> /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 666698a57192..f23b6153d310 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -135,11 +135,19 @@ struct amdgpu_mem_stats;  #define
>> AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) <
>> AMDGPU_MMHUB1_START)  #define AMDGPU_IS_MMHUB1(x) ((x) >=
>> AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>>
>> -/* Reserve 2MB at top/bottom of address space for kernel use */
>> +/* Reserve space at top/bottom of address space for kernel use */
>> #define AMDGPU_VA_RESERVED_CSA_SIZE           (2ULL << 20)
>> +#define AMDGPU_VA_RESERVED_CSA_START(top)     ((top) \
>> +                                               -
>> AMDGPU_VA_RESERVED_CSA_SIZE)
>> #define AMDGPU_VA_RESERVED_SEQ64_SIZE         (2ULL << 20)
>> +#define AMDGPU_VA_RESERVED_SEQ64_START(top)
>>        (AMDGPU_VA_RESERVED_CSA_START(top) \
>> +                                               -
>> AMDGPU_VA_RESERVED_SEQ64_SIZE)
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE          (2ULL << 12)
>> +#define AMDGPU_VA_RESERVED_TRAP_START(top)
>>        (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>> +                                               -
>> AMDGPU_VA_RESERVED_TRAP_SIZE)
>> #define AMDGPU_VA_RESERVED_BOTTOM             (2ULL << 20)
>> -#define AMDGPU_VA_RESERVED_TOP
>>        (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>> +#define AMDGPU_VA_RESERVED_TOP
>>        (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>> +
>> AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>>
>> AMDGPU_VA_RESERVED_CSA_SIZE)
>>
>> /* See vm_update_mode */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> index 6604a3f99c5e..f899cce25b2a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>> @@ -36,6 +36,7 @@
>> #include <linux/mm.h>
>> #include <linux/mman.h>
>> #include <linux/processor.h>
>> +#include "amdgpu_vm.h"
>>
>> /*
>>   * The primary memory I/O features being added for revisions of gfxip @@ -
>> 326,10 +327,16 @@ static void kfd_init_apertures_vi(struct kfd_process_device
>> *pdd, uint8_t id)
>>         * with small reserved space for kernel.
>>         * Set them to CANONICAL addresses.
>>         */
>> -      pdd->gpuvm_base = SVM_USER_BASE;
>> +      pdd->gpuvm_base = max(SVM_USER_BASE,
>> AMDGPU_VA_RESERVED_BOTTOM);
>>        pdd->gpuvm_limit =
>>                pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>
>> +      /* dGPUs: the reserved space for kernel
>> +       * before SVM
>> +       */
>> +      pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> +      pdd->qpd.ib_base = SVM_IB_BASE;
>> +
>>        pdd->scratch_base = MAKE_SCRATCH_APP_BASE_VI();
>>        pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> }
>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct
>> kfd_process_device *pdd, uint8_t id)
>>        pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>        pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>
>> -        /* Raven needs SVM to support graphic handle, etc. Leave the small
>> -         * reserved space before SVM on Raven as well, even though we don't
>> -         * have to.
>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
>> -         * are used in Thunk to reserve SVM.
>> -         */
>> -        pdd->gpuvm_base = SVM_USER_BASE;
>> +      pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
> Hi Felix,
>
> pdd->gpuvm_base changes from 16KB to 2MB after this patch.
>
> The default mmap_min_addr(/proc/sys/vm/mmap_min_addr) is 64KB.
>
> That means user could get a CPU VA < 2MB while the corresponding GPU VA has been reserved. Will this break SVM?

It could break SVM if a process tries to map or access something below 
2MB. I'm not sure what AMDGPU_VA_RESERVED_BOTTOM is used for in the GPU 
page tables. But if it's causing problems for real applications with 
SVM, we should look into lowering that reservation.

Regards,
   Felix


>
> Regards,
> Lang
>
>>        pdd->gpuvm_limit =
>>                pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>>
>>        pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
>>        pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>> +
>> +      /*
>> +       * Place TBA/TMA on opposite side of VM hole to prevent
>> +       * stray faults from triggering SVM on these pages.
>> +       */
>> +      pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(
>> +              pdd->dev->adev->vm_manager.max_pfn <<
>> AMDGPU_GPU_PAGE_SHIFT);
>> }
>>
>> int kfd_init_apertures(struct kfd_process *process) @@ -407,12 +415,6 @@ int
>> kfd_init_apertures(struct kfd_process *process)
>>                                        return -EINVAL;
>>                                }
>>                        }
>> -
>> -                        /* dGPUs: the reserved space for kernel
>> -                         * before SVM
>> -                         */
>> -                        pdd->qpd.cwsr_base = SVM_CWSR_BASE;
>> -                        pdd->qpd.ib_base = SVM_IB_BASE;
>>                }
>>
>>                dev_dbg(kfd_device, "node id %u\n", id);
>> --
>> 2.34.1
