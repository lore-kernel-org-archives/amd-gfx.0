Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD86C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 23:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871A018B551;
	Wed, 20 Jul 2022 23:24:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7049318B54C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 23:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G07FEZ2JH7iLxBjjgcdm5glskfMnKDRXjw1FuaNWL3QYVNRApdVEFt1j+dUM1qa+KIPS6joIWK2zZd7XUDsdB0J0aw4Ya1GsPOj/nH3yknsAtwFbh5eBdrc7VcWevQEZlFEQ+EpWhx2+kjlv1LUs5qEZQ4rudGUKqT912OeOTiVMuq83USVZJv6Qhrc6fM5rw9op4KpKY1Wq0dOh+Se/DDWUmvZstBhSODzmKbk1qFtNsvz4+/et9el7G5RcS8THHHillww5hx/GJOPlKt7DolFSLXFT5XuXAPINJPpCTAoT9TwYInHTgxxKH62CknKN1leRqcbYP/U8EXgLVRceYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PUildOZCdWXEN5k4Vkvz3XIz2+xFT1DMseAjWZdt4w=;
 b=Re4wUfaAAo0IZSLxhHElV94ba24gsYsJefYdsNgzBBKB/wWVkD7rUxCzEM9e7874iE7NFTofARfZWSJtxqBL62AhIhfJdpb69QLmvb5DgDsi3w76Kq+1fJ7oC2Y0sDW5VCf1BVUd15EIwtoYYbB4COfX2yMnYiQdT+Ub9s5xu6bloaZR4rchjm4HqShqCIZXIekGB0d4Bm9Ph0tmFAlWwx5ZP4VeBEd8Nwiibz9n3Ps6xWgF8BB+Od+jene8iguOkCzFgXMLNOxUdhrAucPnIfvE4BA3CxjNl47p2VWE8xcsRzTt2iz1VhdSqJY9B3S8tnzPt0NKNqC0y20ypnFCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PUildOZCdWXEN5k4Vkvz3XIz2+xFT1DMseAjWZdt4w=;
 b=AdQadkU8xAyvi5X7mtDRtVeM9gtALdm/8CGqk2Y+1TS92NzyevtL4ykkKgsHPMRcuqFKDguwVHF6Lwe7DQXUcN7XvnlvnVLkGL0P0w0JsLfGnXsHfX8t4U/aLFmuNGKhKZRN6WksMdbIvJz7DXeg/IQ2jfOkEcgcJ7ErvajWi+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 23:24:25 +0000
Received: from MN0PR12MB5930.namprd12.prod.outlook.com
 ([fe80::2566:38b6:8f5a:6c1d]) by MN0PR12MB5930.namprd12.prod.outlook.com
 ([fe80::2566:38b6:8f5a:6c1d%9]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 23:24:25 +0000
Message-ID: <be9c3086-4dfa-b492-15e8-1b2c6778b618@amd.com>
Date: Wed, 20 Jul 2022 19:24:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: Refactor code to handle non coherent and
 uncached
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220718225227.17382-1-rajneesh.bhardwaj@amd.com>
 <e421b561-217b-b4ed-9d8e-a56390734c26@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <e421b561-217b-b4ed-9d8e-a56390734c26@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:610:4d::21) To MN0PR12MB5930.namprd12.prod.outlook.com
 (2603:10b6:208:37d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6f77d69-2b86-459e-a00c-08da6aa6fbc3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46YSAqr3tuWZ7WytKx2JToNsZEwun3UUu9m4SJ72KFQN10OYVeRY/x3IVTdTRfGWr2gde3UVkCD6q0INfe7Hs6dS/Vnx1JBqNRk3mYrlps50lyk7uVlx/2bAla/JTyqTBKUZq4fk8j8Z9AbGhP1kF1vJ7IlABs6oaqviYc1nDJ8VzJiknzHtvN2nQ9lqWL2a/x/Pw4KVH/nq8+gaJSKfYGMq84obHWKMnqMH643PPDwqyracoGq9CSnznBUTjT7/SJmRYK6abTeFoUMy8cZQNk864IZ+3TM7rUr9FR2RGG1TV6Wncsi76jLdihO/9mzVlhf16LvOk5zcoDDLmhBjqHyi9oYyMLnyhw8EhnbwY39qM2O4i7QOBi5lCfwrLpWeWAEhTOclIFLcnWoznf9Mb9p19dUy7rVzG4s3ZLGrWgd8oo4u/ktVi1QknYPFaOo7JG4T/iuvPeQpmTaYKWBJa0GZm+GvH4eIytmpTNGFmuU1r00Uj0tZKD/yimMYtukDp6jCsgocWa7+z98HWzcNFhJ2/aidoXyayXUEzpa0tcUhy/+LiP3rqRK2GZHp6j20fi86DNCNr7ye3ALYQGvZayXH8M5dg5xK5F5G2r+enQlh5EWBo3u1IrgTukXdxpPt/HpPBtgWyUomr3qCSLg2VUDtsO+OdDQLBVzXuu/DfkyCh13+hwvwUxTaSQbGBYqF8JTYNipJ2Hc6f+kck8IpItX2nDcsIQMsSyYF9ekkX/aLi89udBoINqqUD1nRf5PROUiKoknZd3p3OW4/hn+4TsuHhIllX+efjKvKlbAry6l33ZAY7dvYvRvdbMb5+UW5z3A9zhdZAF0zs5DeUmBS/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(26005)(41300700001)(186003)(66476007)(31686004)(36756003)(6512007)(2906002)(6486002)(478600001)(2616005)(54906003)(8676002)(8936002)(66556008)(38100700002)(86362001)(316002)(66946007)(83380400001)(5660300002)(6506007)(4326008)(53546011)(31696002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JuTlBxdDYyL0paT1NEc25xeFEzcFdORTQxSXpNbk9TdHpsbHNJL2ZUa2Mv?=
 =?utf-8?B?OHNHTXc1eGZLTDlnQStHckxYUjV2MTRmVnhwdFJPL3RvMU1PaVh5UndPb3J6?=
 =?utf-8?B?M3BINXRWU1NlYnJ1ZW0xazVjL1cxNlc4SncyZytjTkdKeUFkcDgxblpUUkJs?=
 =?utf-8?B?N2FjNG9CNytjcWZqRXd5NWNqcGorRzhDSDI2QUNqRzBndGx5cGY2Y3Y3NGE1?=
 =?utf-8?B?Sys1Y1h0d2tCWVd1UC9zdFo1YmE5SzNaWXZmTkRKNENxUVJQTDBxRkg1ZTJ2?=
 =?utf-8?B?L1ZEanhNcGhrVDhqcUZ6eEh5UjBacUhWZGxYNG1rMGdlR3F3bUMvWldOeWZM?=
 =?utf-8?B?dWExZ2tDMVdadnN3ZHFtMkRWMU9VSVp6eEJnTlRmZzU2aCtNTDZZbE9LRGFr?=
 =?utf-8?B?OUlsRENqVWRiYmI3dndVUWxTSWNmMlcrQ2o5TGtLbUFiWXpPYm5Ld09YbVBG?=
 =?utf-8?B?TGI4V1UvL29kSGtCdEhoWmZnWnk2NFl3elJTUzkzOVlnMmhRMkFzVitFK3dO?=
 =?utf-8?B?d0h2S2pmRDh4OUhKMmpXRExRc2xHWHFZcm5hbDExdTd1S3lDTkZ0Y0J5MlZG?=
 =?utf-8?B?MXJXckxybDRabXprRERrQWZDbFd0RDlsMFI1YmVnTjR5T0xHRUh3MjNFV1gv?=
 =?utf-8?B?MUZjZUxUdUtDemNYcVR1VHg1Vk1ndkd4bWFzQkVzM2FFWmJwY2haTXBzSGpa?=
 =?utf-8?B?bkxuUkYwSGg1NkF5c1FURmQ5UGZobGJSNGxDOGR2MVNWS3lQQVN4SHpmRE1L?=
 =?utf-8?B?Y0R0QUlBa0dSeE96NklFZGdRMk81SHNEZ0d4c1FzTWwwS2x1UGtsWXN5Y0tN?=
 =?utf-8?B?M2huRFowa1VSMHllVlpjOE9BL3dIV1pnaU94em9NTlhoTERHQU1DUnBPMGFs?=
 =?utf-8?B?elRRaWNoUy9YaE56K0JOanhOWmtNWkUxWVA3TWYydWxETTFWWFdiNVNZRWhG?=
 =?utf-8?B?WmsvWC9PS0ZqZE00MmRoOTk0WGUvN3drcXk2bnZsU1R0ajRGakc0SVFWNUhI?=
 =?utf-8?B?ZHJkc2FsZnVxWXNYbStWS3RnY05yNmIrdlBLQ0NKSWFhQWtadzlhdlBQelJX?=
 =?utf-8?B?UXV4WlpIVUpIOTZvQnAyTk9YTUg4SVprM2hHYlNIczN1ZDRlaFhhYXZZUitC?=
 =?utf-8?B?WkN0NGFlN01RQ0tMMXB5dm45VG0wbHNwU0psaEFXVGg1UndHN2hSdm1hSmhJ?=
 =?utf-8?B?aU5heTQ2cDBFb1I1N0V5QWFXV25hNmdTN1JrL3BLdVNWUTYvV0dJT05yeDhu?=
 =?utf-8?B?UTEwaFE1NUtXS21GZGRnT1NQWERMWC9GNjVKOGdIUlU4ZU5qMCs2eWsrMHMv?=
 =?utf-8?B?Y2x2OEpkZXRUaW1KczJjZ3hFSEpvVzdscURoamQ2Z3o0RnJudWorRkZSVnZW?=
 =?utf-8?B?eldlOGhHbUQwSmxlOXh2OUhIVXdWdDQ5R3lmYi9WUWw1bUx6MHphdkMrdXdz?=
 =?utf-8?B?WnY3M0FTWXVGNWtidE5aMC9SZk1wVEF6MFhVRWFrNElRcWVhS3NkbjJLWTUv?=
 =?utf-8?B?UnlBOWF0UENrM2UrS29NVlZ0TnN1cEpXcFFyK3UvbW1FM2ZWblhqaEdYWVl2?=
 =?utf-8?B?UG9CNUdHSGlzanNja0dWVGdTOHNlSUN0VmE4RFVVU0g5cy8wZ0hockN4WmlY?=
 =?utf-8?B?SXR1ZGJnR2htdnFNSTlYVlhLaUJrSFRnSlNEQlRNaGhJKzVLZUFacGhCd0tW?=
 =?utf-8?B?a0RRcEtGUWZteDIwSjV3azRZb0p5eTMrTE1WWmxCUHRGR2QvRHh0UnJDSkgy?=
 =?utf-8?B?eWZiclRvM3RRRVdrcFpUbGZBam5YRHV4dFF1cWg5NUFKNTV5VGg4OEhlUzVn?=
 =?utf-8?B?OFBkcUh0TmRIZy94U1IyK2IyS0dBSFlLZjl0ODBiRkY2ejdqOWtiRUFmU3o2?=
 =?utf-8?B?dGNGdFhORTB0VFAwSEJIMkNyYjJVZXZjTFluM1pmWFoybFcwY2hjNjk2NGw2?=
 =?utf-8?B?dlpsWjBHNmp0QVM5Sk9nQUxHVWJpR1ZtTjVzVldSbVFvYy91ZGdPUXdpOXR1?=
 =?utf-8?B?Nm43NWlhK3c3V0Z6TllTRGVzVUVqZ3pxWWNwYXBwaktEWXVOSHp0Q1lGNk1G?=
 =?utf-8?B?L0NPbVNzNTY0TGdUR0I5Qk5UZVA0NHlFV2FRSlE1Q0R3YW55VzB2L3cxS0Ro?=
 =?utf-8?Q?kGSZ60UCg57KA85ZBLaqOV9aD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f77d69-2b86-459e-a00c-08da6aa6fbc3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 23:24:25.0657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fmom4grEpmJv5VT8sy0YpXRoMgojgTXVq16b1HHESYoleVkIzPzr1HR4kNZgbu8rA9mKfJqFkL+ulRxXNCfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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
Cc: Amber.Lin@amd.com, Alex Deucher <Alexander.Deucher@amd.com>,
 Joseph Greathouse <joseph.greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 7/20/2022 7:18 PM, Felix Kuehling wrote:
>
> On 2022-07-18 18:52, Rajneesh Bhardwaj wrote:
>> This simplifies existing coherence handling for Arcturus and Aldabaran
>> to account for !coherent && uncached scenarios.
>>
>> Cc: Joseph Greathouse <joseph.greathouse@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 53 +++++++++----------
>>   1 file changed, 26 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index d1657de5f875..0fdfd79f69ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -471,45 +471,44 @@ static uint64_t get_pte_flags(struct 
>> amdgpu_device *adev, struct kgd_mem *mem)
>>         switch (adev->asic_type) {
>>       case CHIP_ARCTURUS:
>> -        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> -            if (bo_adev == adev)
>> -                mapping_flags |= coherent ?
>> -                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> -            else
>> -                mapping_flags |= coherent ?
>> -                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> -        } else {
>> -            mapping_flags |= coherent ?
>> -                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> -        }
>> -        break;
>>       case CHIP_ALDEBARAN:
>> -        if (coherent && uncached) {
>> -            if (adev->gmc.xgmi.connected_to_cpu ||
>> -                !(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
>> -                snoop = true;
>> -            mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> -        } else if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> +        if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>               if (bo_adev == adev) {
>> -                mapping_flags |= coherent ?
>> -                    AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>> -                if (adev->gmc.xgmi.connected_to_cpu)
>> +                if (uncached)
>> +                    mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +                else if (coherent)
>> +                    mapping_flags |= AMDGPU_VM_MTYPE_CC;
>> +                else
>> +                    mapping_flags |= AMDGPU_VM_MTYPE_RW;
>> +                if (adev->asic_type == CHIP_ALDEBARAN &&
>> +                    adev->gmc.xgmi.connected_to_cpu)
>>                       snoop = true;
>>               } else {
>> -                mapping_flags |= coherent ?
>> -                    AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +                if (uncached || coherent)
>> +                    mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +                else
>> +                    mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>                   if (amdgpu_xgmi_same_hive(adev, bo_adev))
>>                       snoop = true;
>>               }
>>           } else {
>> +            if (uncached || coherent)
>> +                mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +            else
>> +                mapping_flags |= AMDGPU_VM_MTYPE_NC;
>>               snoop = true;
>> -            mapping_flags |= coherent ?
>> -                AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>>           }
>>           break;
>>       default:
>> -        mapping_flags |= coherent ?
>> -            AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>> +        if (uncached || coherent)
>> +            mapping_flags |= AMDGPU_VM_MTYPE_UC;
>> +        else
>> +            mapping_flags |= AMDGPU_VM_MTYPE_NC;
>> +
>> +        if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM))
>> +            snoop = true;
>> +
>> +
>
> With the two extra blank lines removed, this patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Please check whether a similar cleanup can be made in 
> svm_range_get_pte_flags, or maybe even, whether common code can be 
> factored out of those two functions.


Thanks Felix for the review. Do you want me to send V2 with two lines 
removed or just apply to amd-staging-drm-next after deleting those two 
lines?


I will check svm_range_get_pte_flags and see if I can cleanup the code 
there and get back to you.


>
> Regards,
>   Felix
>
>
>>       }
>>         pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
