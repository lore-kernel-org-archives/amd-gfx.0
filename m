Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60396C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3BA10E1E7;
	Fri, 26 May 2023 18:11:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D5C10E1E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 18:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUpoCg6Y/4EGGJOx0zDo53oaZk6lQvRxt6u/9ibhZCCtO1pfCfUM1WnUG4BW6vptO6z3XGg7uQjcsBvGjrKM30rI8rzt/kg8J6o4l4K7j1m1YNwboukmj0kdbpTA3dPoC7v3rNss4wBRPJBIu7YQv7pCkIo2XOUIC6oNG+OFFnjr3bQLMpciodsH6ibgygPBq3qETYoiW6Foha5buj+9x9GtloGdgRzZQd1fCBkhhXzLwHlhPgc8q7r2/t3r1wu0huJKHr8MNwfN2veb20804n+yH+T6k2mVZvkFsb/UxMS6xYNNXPgYLOnDxSxsz7y4tPYIH9gEWnK8O2Xm70wr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugpiZWLTEeWfp09Y40aWVSYQHb/A3zV0CGxvLd5tlvA=;
 b=CNonP3rk47Tb7DWrR/DOoSPfXe8XhpRA0t43JV1Y5PgD2MgAxeiKvJSx0+ioeytmy/NwB/Qbxqk18EtO0jZF/Uz/Lh/O5EgpLKHS9ucqxo59n3nHiMZYT3Deny5LhmunG0bPPfdOC1iTszdjvQ6PuRbGas3dmdmzTThAOYnN/k/h2nvGybMrEV0UkK50/TJu6Mi+DmRMugRfxdS9RhW9hrceTT8Dm0FcoBfQOdLZ8c9KO0luXcFsiXFpoqwo2KhTNVi/+k5oLulVQbgv4soDE+STzlmHyv5nmztfKOafAkp16QK56UHwehS/XuEAN9Tz/GbE00cIRMP5WrVSd8NRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugpiZWLTEeWfp09Y40aWVSYQHb/A3zV0CGxvLd5tlvA=;
 b=rC4ZZytB1oSRQglYPbT/Pr/qy8PAohgM1DBv13jqkiDHN1o+qnrFmn8YICOL2oYsZ9fyozpxsvTF6h/p6ex6qiteRKMMAg/pbA4tcKLm3ZaJl/T1gKFeiKliye2CeLoePhc3WXJN/LxQRxds0DoPh1lCzUQE8cQQa8o8OmXTjIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Fri, 26 May
 2023 18:11:43 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::560f:c247:cf85:84d7]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::560f:c247:cf85:84d7%4]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 18:11:43 +0000
Message-ID: <6367650e-25a0-6658-042d-f5ea8f1a1ef6@amd.com>
Date: Fri, 26 May 2023 23:41:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
 <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
 <DM4PR12MB5261EDA410B001ACCF0CDC289D439@DM4PR12MB5261.namprd12.prod.outlook.com>
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <DM4PR12MB5261EDA410B001ACCF0CDC289D439@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 36496912-1bae-4920-07dc-08db5e14a8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhuL/PLv7elfaephRa5ZcM5O4+2QF1qtxnXREw9SOKWh1Ln3vbl7LkZv5v/ik24jU9lRMgKtDafxPOI+MHPd907KyXdhPsd1wQq+rEAdl2cWRW0C2ZOmhpyTynfY8bbfkRD8yyCGcRjx+YsZZAKWXmnJQGs5XIv3Euf+zw+eBISJdLucX/K41r4vvnd1R56oZGVVUydA7SHqpPOEuRuU5tdjZIKQ+8sQnYIy+jJyszO+SC4FLDNehEbEWJPW03iEqNJ9uZ8WoGvPMemInV/gsjAdg2a0tmQpZq1qnBY8PvTIYnTd9oXoJPldWc1t4FzNwRYpJCSvTIpRQc/h7lKPPTDzNDvf+UDFHLKKCF1M2IaQejUzwnUgfs2e1aUTXrkV/xXxcIfb3/Hf3tFVLVCocadVQqPNfggFDkd48Kc7qy/n8fuIivtQEQoelggj+YEJeYjK0vRHCSNyAotDCHMmKqmqKt/Zp3L64SPEo74pLkcPlBTHDc8AgTw09B0V1Qp38cNOws/ERzXCr/1wwJ8esukFD2Fq42TW2i/+UL/f9WjHl4OA6SEywOGFK1Hh+t7ZBrzWbm/xBYIhxIEr7a3gPh43uOTyhZVEKS842s8XFPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(316002)(6666004)(6506007)(26005)(53546011)(6512007)(36756003)(66476007)(66946007)(66556008)(4326008)(966005)(38100700002)(5660300002)(8936002)(6486002)(41300700001)(8676002)(83380400001)(86362001)(31696002)(478600001)(54906003)(110136005)(31686004)(186003)(2906002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtRaG1PT0JEVGJvWjRNVjQvZ2tOZ05nWlRpc1FFSkY5bndlOGxNZEowM3FH?=
 =?utf-8?B?MEhLc29DNFp0dkRZMTNQcytkSFBQSWV4THd0Y25ocXVOaC96cmo5VnJBQURp?=
 =?utf-8?B?dkI0ZHErVmFGMWlVQTcyZjNkL1l4aWhRVElkMnlLVDJHYVpxRWZFZE1ySHA5?=
 =?utf-8?B?Y3NObGlnL0JoTzZVUXh2ZVNvWjdvdWk4Y2x3Y0t5Y0JVdEkwMm5ncXRDNTZ3?=
 =?utf-8?B?Rzh6U21FZEYva0RRN2NpcHZyYUdtVktzS1AyMVkwVmFZWERiMTlPaCtESGN5?=
 =?utf-8?B?cjdUQ205YysrRndrUDJ2eEpyQ29kUkpwZHNXLzE0WWR3elVqVnJTNDZjYWYv?=
 =?utf-8?B?aklubWNOZXZ4ZmJWVmRmSXovTTVuS2VyR0RMZVBVVFRlekJTVTZqYmdEQmhh?=
 =?utf-8?B?SjBQL2VwUTRYbWNadEp1Mjlvank3bFFtMFpCeTIwUis2U0d5T1BYS1JIcExK?=
 =?utf-8?B?TFNCQ3Q2NDhESG93LzBSTGNLSEw5aWhMWW5CeW84MEJIeGJUQ3pGb0NIaDJp?=
 =?utf-8?B?bFBId2QrL280UzB6RHl0alNlMWxjMnZjOHFUUVcxU2I4UFJ5a0liTjlMSVZl?=
 =?utf-8?B?NnF0U1BjSnZFRjZ2MEJic0lqQ3lZN2ZCWUVOQ29ESkxKeHNlcjYyNjFMVFJJ?=
 =?utf-8?B?NU5hRS9JNUtydjNGQVpZaUpCL1gzaHNCd3U0aDlZOW9JaXJKZmxyWnZwZTJw?=
 =?utf-8?B?dktaNmpDelVnWWRmYXVqcXJFVThGajhMdEY0ZlROcjJBUndXcFRQYTRRWEh1?=
 =?utf-8?B?K3A3elV2N2YxRVY2ZVlmVkd2Q0VteGpYNGpucUdMTWlQMElvWXd2TFlVZWpI?=
 =?utf-8?B?QkRvTUFWUFFCeDFVeVB0ZmdOOXdlNmVUTXpYejh4c3YvZ3lTNHQwaUdCQ1dG?=
 =?utf-8?B?Yk9meGtrODBCWnN4R2VMcFZ2ZzROanJXRnVSWGVvSjZEVzdNOENRdDhkMGdI?=
 =?utf-8?B?b1VIK2NXZTI3ZzdFYVZqNmljZFdmdWxVMXVsU241dUFUNmFrOXFSZm1CNys3?=
 =?utf-8?B?eTJjakpQaS9pcXdHVUU0STdPaFM1NVpRSHBJZHFCYkIraDV1UUkvVU1pTHdp?=
 =?utf-8?B?NEtHSEFBTDI4dkwzL29nZ1JwcGt1RTFlTElVZHo4UEhRMGZ1K3c0WUpXdUR3?=
 =?utf-8?B?TFR2cEFHT2pFYnVSTCtIRDhwMlhZbVN5OTJvMmYwNjVOUUdLVDhxTXlocWxz?=
 =?utf-8?B?ejBnUHQ3ajVtTDN0UDgvcWJTbFI5S3F0ODZId0R0UmIyZkREM1pLK2F4UFE5?=
 =?utf-8?B?WTFvOWhXYVVlMFdoRTBUN0dLeUExYitCWDR0RHAvTHpSL0dCK0tNWjlaRUdi?=
 =?utf-8?B?K3NRd1NvS1ZlUmpvTG5OUzl4bHZubSszOW5TT2grWkdON1pXVE1oSHlxOTdD?=
 =?utf-8?B?dWZwR1ZRd1VMdWxDQnZPS09WUUpaQkZ4TE1GRTZQbVlENmVybmdHaWQrYmND?=
 =?utf-8?B?YURneTlBVDU5c095dTBNZWNLS2pCaWg2NnpmS3ZtNko2MjZ2RTNjQ3V2UTJN?=
 =?utf-8?B?cStwNnFGWkE0Nnd5MUVrUFRPRjBPVXdDeXJPakhGd2E4VTRHWG9UY1Bha2tv?=
 =?utf-8?B?eHhwMGFJVGhnYWhlNHEzUFREeEI1S3pEakRER1ZscWhBZVFqMVM4bEVxOHcr?=
 =?utf-8?B?ZkNWRHhtZW9kMVJkYUovQ2ltdjQzcWJjbmtSNE1MVjF5WExLODZCZGowc0dK?=
 =?utf-8?B?Zm92SG9UTU1WYW5QL01YRlZ1eUxXVnZZcGlyRlcwSk0vN2VGWDVHTktWU2ZU?=
 =?utf-8?B?NVgzOFpwVFdpMjhieDVER0FTSmlRZlArQVk2VGtCeHJhNVNKODZoWXJQLzg0?=
 =?utf-8?B?L0VnbEtPOFdSMitmcEI3NHVSZ2JhZTRhVkdibkVEcWFKSm5aWmNORmlHNWp1?=
 =?utf-8?B?RjFqbVhtUmFVUHluVzVKdXpzY256a0U0SjZWU0FQQ0REU1o5ZEpwSzBjTzFI?=
 =?utf-8?B?VmVSSmtQZnV1cWpqblpxZWQ2Q2lQTStFck0rN1ZobjV1REFBM0JDWEVuV1JP?=
 =?utf-8?B?N3dKbWhQdHoyRHZNNTZ6T3JhRjNmSDNxa1AvbHZKVHdBSisvQjZCdU1hZ29Z?=
 =?utf-8?B?N2thbkEvd2tOLy9sOVFlT29lck54M3p0YWhCZTlZckM4SkYvYVdvWWRBTFZX?=
 =?utf-8?Q?saaKSsR5bqNGaScOro9gigX78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36496912-1bae-4920-07dc-08db5e14a8c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 18:11:43.0564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnqsDrEaNAXzdHmOQ3pHo97amuKBpjVD84TJWEzz9xkwwBoRJ/kMJu2z31owKxX3maKdvTNZKaKDRRK6vmhldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/22/2023 8:52 AM, Xiao, Shane wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Sunday, May 21, 2023 2:39 AM
>> To: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Xiao, Shane <shane.xiao@amd.com>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when
>> allocating VRAM in large bar system"
>>
>> Am 2023-05-20 um 05:25 schrieb Arunpravin Paneer Selvam:
>>> This reverts commit c105518679b6e87232874ffc989ec403bee59664.
>>>
>>> This patch disables the TOPDOWN flag for APU and few dGPU cards which
>>> has the VRAM size equal to the BAR size.
>> With resizable BARs it's not that rare.
>>
>>
>>> When we enable the TOPDOWN flag, we get the free blocks at the highest
>>> available memory region and we don't split the lower order blocks.
>>> This change is required to keep off the fragmentation related issues
>>> particularly in ASIC which has VRAM space <= 500MiB
> As far as I can understand that, both ways may cause fragmentation issues.
>
> As I can understand that remove TOPDOWN flags may get two pros:
> 1) It can reduce the research time to O(1);
> 2) Reduce the risk of splitting higher order into lower orders when allocating blocks.
>
> But as for the second point, Removing TOPDOWN flags still carries the risk of causing
> fragmentation issue on some scenarios.
> For example, the apps need allocate (1M + 4K) VRAM size, which is not a power of two.
>
> Case 1: If not using TOPDOWN flag, we will allocate 1M order size and 4K order size from different order.
> --And then if this 4K buddy and 1M buddy are freed, it may prevent the system from merging 4K(or 1M) to 8K(2M) order.
> --If the app has many such allocation requirements, it may cause fragmentation issue under memory stress.
>
> Case 2: If using TOPDOWN flag, we will find the highest order which is suitable for 4K and 1M needs.
> --Assuming the highest order size is 8M, then we will split this 8M to lower order to meet the needs of 1M and 4K sizes, respectively.
> --In such case the 8M size will split into different lower orders.
> --If any other thread or process need allocate 4K or 1M VRAM, and there is also a chance to prevent the system from merging 4K(or 1M) to 8K(or 2M) order.
>
> If there are so many needs to allocate not power of two pages from apps,   one of the choose is to use suballocator from UMD such as what ROCr does.
> That means suballocator can allocate power of two pages(for example 2M bytes) from driver, and the app can allocate memory from suballocator.
> In such way, it may reduce the risk of causing fragmentation issues.  But I am not sure that such an option is feasible.
>
> Maybe case 2 occurs less frequently than case one, then we should use TOPDOWN flags whether the system is lar-bar or not.
Yes, It is better to set TOPDOWN flag mainly to avoid splitting down the 
lower order blocks which resolves the fragmentation issues
and it doesn't try to allocate from visible memory (provided that we 
have the enough requested memory space in the top down region)
which improves the graphics performances as well.

Regards,
Arun.
>
> Best Regards,
> Shane
>
>> If TOPDOWN has these general benefits, then would it make sense to allocate
>> visible memory TOPDOWN as well, on large-BAR GPUs? Without knowing too
>> much about the internals of the allocator, my intuition tells me that using only
>> one allocation strategy has a better chance of minimizing fragmentation than
>> mixing two allocation strategies for no good reason.
>>
>> Regards,
>>     Felix
>>
>>
>>> Hence, we are reverting this patch.
>>>
>>> Gitlab issue link -
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2270
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 2bd1a54ee866..ca5fc07faf6c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct
>>> amdgpu_bo *abo, u32 domain)
>>>
>>>              if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>>                      places[c].lpfn = visible_pfn;
>>> -           else if (adev->gmc.real_vram_size != adev-
>>> gmc.visible_vram_size)
>>> +           else
>>>                      places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>>
>>>              if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

