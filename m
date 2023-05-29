Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6EEC77B7E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 06:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D6B10E213;
	Mon, 29 May 2023 06:45:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25BF10E215
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 06:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPQioQd/PQSY6jEEy0VbqcXAcXYFMJ33MBgx3uXK4MkM4VH6j1SHmSgTYwkPGrd6ik6x00oFP7HomLEy9YULxSZ8ddn913AXE83Z+oUfrOZBDMZ/dn09GBIIqBUFXwpd0pbdprxf6kBBwfuk23ct2zoHZ3l5Cy6eXpv2PTygS+GWILmMbz6lUJ8q0V6lywwBgg+avOsLCOI5eQhczkFYQOhG4oE3Rw3P7IWDXn7PqFM3QCDcUmni7CDb2AoEzVjlvUtGZetJmwa19bw8RHcQCKIcK1bn2IWNtS8H/8ABEDLiBPhpfkyhCkwCE/WmblBXc2bgXIggNrrwiCXjcOXJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sCb8JEnHtCDLa3M0dqeA8n28SwgW2CNjriMcJwJwnY=;
 b=GrCwW2jYa4+yfEgW3vdfSr6OxhJmYY4aGo/uR0Pz4WN8yBejxdkHkAN0qwfHL7j7P5a35mGA/Fwmb4qTs2+NLasZESB9sCyD7V90HQMbINUzHmSee2QsU+SOChTiYXMs+hzKz4othb0QOHHEcZAE9h2tLHAGXJ8xGIjs6o9r9nMSvwR55HXJiWmR7E3DBGKadd858zcYWt63ECVisx6kFgXhWEYwlG/9yqrPlS9oReybMmECCDyWlug/UJQ2nvbvzFHlX25rPLRR7bG8pW4xTQ8y0iajiJWGiVWbj6qa2SXWsFzFpXvoAiVllw48yDKqHuA0EIcf37o22WUcsKg/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sCb8JEnHtCDLa3M0dqeA8n28SwgW2CNjriMcJwJwnY=;
 b=mBMUV8z/d4bpWLED5IJQ+R0+lfT8b2jd4imbQSmxUTmqczJvcB3QvmMHSN2ty0gR3NpwCNHXI/wmzakgeSh2M8z2M6A9F8AfQKPRU82Fi2mw5RrFFlBMZs0q08mfrkA2IL2UKjMRmJVkze17RfuYvSg3ny0tJk05PFpIBGhexZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 06:45:07 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::560f:c247:cf85:84d7]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::560f:c247:cf85:84d7%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:45:07 +0000
Message-ID: <9e753e8c-e015-d7db-838b-ae4133487e06@amd.com>
Date: Mon, 29 May 2023 12:14:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating
 VRAM in large bar system"
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
 <f03a448f-1ba3-5d4a-a2a5-baba97b3ec1f@amd.com>
 <DM4PR12MB5261EDA410B001ACCF0CDC289D439@DM4PR12MB5261.namprd12.prod.outlook.com>
 <6367650e-25a0-6658-042d-f5ea8f1a1ef6@amd.com>
 <DM4PR12MB52619D3795D127F9D0FDAD309D4A9@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <DM4PR12MB52619D3795D127F9D0FDAD309D4A9@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::31) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7dbdcb-2992-4676-3091-08db60103d0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C643nCfr/tKtUE5BOc1ED1l6CcOVCMs/2UdalvpAu1kIYmKt/GU061ruHnXH9h02XemvbreNdxcuUHg+/1ZB0ZxiFCGfF7vylINoomVPludffthtrHr9+WM1dqYg0L23Vuz2nHJsUh7bCQRtsVySdX/hqx2Ka6dauvCYIbcff2WDZqd0GuL20tjEx+7wd361L7dNLT4YIBgsUkb9TtjshzutOqGEmBMB672UrurR0nrizVGquYIjK+cEXWqhLbMp1r0rsNUis9R5Qgc1e9CzjyX0XeuxiqJQkw+R4nPbc2z76gfO91JoHiHifJNRUUylbK7BEPXy3lplmNQAd3+AngHJj4bMsEQk7DX306bYWJB83Opcu+XSxm8bry+LHa6caf0kwdoCyOSttJy+gOkls/494byTkepDx7YPltRJ2iLJvG3b5NDROqehulq+62mOp1ZUtvNbU+2nBT1KJxb51ljFCeHkcrcw5Akw1SOqkWChpJX0kUd5j473AhAvpBvAmnlQd0drxtvoQtvlpYQFtSGR7VkOLGAFAtEuSXktSdD6UW9macXa1fnRb6oIwsbL9ibp9K22igvhO+4KuWjynVIx/l8SUOuWBYGpwnd5h2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(83380400001)(5660300002)(6666004)(316002)(66946007)(66476007)(66556008)(4326008)(31696002)(36756003)(966005)(6486002)(8676002)(8936002)(41300700001)(38100700002)(86362001)(110136005)(54906003)(53546011)(2906002)(2616005)(6506007)(6512007)(186003)(31686004)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRGZzZFVkFybVpkZDBxZDJ5aGNlSDAvaSt6UzVKWGUwb0dkbHlycFNHczZG?=
 =?utf-8?B?d2xDcVlwZGpOemRtR2VjOGNSOFJUV1A5MFpDTklES25SeXEzMWVCTVJNeGFa?=
 =?utf-8?B?RHFsMFBNSGpma21nbmNVTVdrN05yMUlCNkEvWVZKakhyNkI5TFJGdVJobDVa?=
 =?utf-8?B?NHIxQURRcy9pRi85dHdhczFkamNEQkNZS1BkU0tEVDY2dmJsUkE3MEt0S3ht?=
 =?utf-8?B?WmlrM0ppbDdyQ1ltU01XUmhBWG52S29EWDZTUDFJcnQ4TGpEQlk2amxXM2Jr?=
 =?utf-8?B?NjVJT293Nk9XSjVhU1MvNTE2ZUZLb28zMENtUFpJNWVRTTU3U0E1NFYzY1NS?=
 =?utf-8?B?d1BNRGI3L2pBVkEwWEVCSEVYQzZVdlY0VFk2YkN1L3VLQlNReVA2c29TYllU?=
 =?utf-8?B?SXlSUVF1NEg2R2RqRi9kaTMxa2xacEdhSU1ZNlRXQjMwOUg5Q0pidEF6WGor?=
 =?utf-8?B?NGcvYytSczYwZ2M2RnJFeUVVNWMxVVRWUnROQ3dhNVBKc1I4cXJ1U044MUxk?=
 =?utf-8?B?ZWJFWXp2aWU2enRVKzhzakY2MlhacXJSMlVaNnVHK2J1Nnd1ZHFhUm1iMjV3?=
 =?utf-8?B?WEVYZjRuWFh0eG56cHdySThZNzgzNnN0eVZUMjk0Q2RUc1lQTzVHSlNmeFJW?=
 =?utf-8?B?N2k1aEt1YW5RdDR4am4vdm1tSFNvdE8xWFoxM210USswNFdvUzd1L1Aram5y?=
 =?utf-8?B?d2syYjlkZnJSVCtLV1Y4Njd4WmE4TC9NN01SNU50MHlIWGZSeVluTDRnVVor?=
 =?utf-8?B?bm1KNE1GRTVOaVQrZjdZaDFpYjdHcGxMazBTdXkyOGFFVHFhNDFqQlIwaGZ5?=
 =?utf-8?B?ZnRIRTFlWUYxNFE4Y2hTUWFXTVYzbzJPVWwwMjBvQWJrVnl1TzJOaWtsNjNR?=
 =?utf-8?B?bTMvYmhzdHY4OFBUS280ZG44QmpWcEZOTjJFcEdQbS8yR0pQSEVBWUVsUmh6?=
 =?utf-8?B?SklnU2tYOEsvbGIvOTlhTnQwdWdicnFSOWJEOEExRzNnUEVVNitqK2dLZGxu?=
 =?utf-8?B?TjdISjk1eCt1cE9wcFU2Vlc0ZXRQc3U3VkJTc3A2MnF0QkZlRlJZa1NWZXNL?=
 =?utf-8?B?cEZkbHhwamptWEZaU1hOaytzL1VmWEtOZHNLbUhMNG9yeGJPSFo3eW9mekE5?=
 =?utf-8?B?K3VnQkVhcHpZVEFaMFVoZFRWM0VpdTN3K3FkVHlkL2xlQlNIeVlMWDRIRC9N?=
 =?utf-8?B?Ny9xeFNzcG5SUlVuQ0s4b0lud1Zjb1g0NDJkai9sRzBxa0ZKbWJQc3Zld3Qw?=
 =?utf-8?B?Q0tVc0VGYjNkT1dKN0R6Vm5mM2NsNXBiQXJ5RDRIVEdOOFI3YUVwTG1wWEtm?=
 =?utf-8?B?bC9sNHZLNXNCYzlMZWROcmhyTjJ4cWphWCtsbk1SMnR2ZTF2QjlyOWpVdFBE?=
 =?utf-8?B?bjZzNzdBWkxmQzNUenE0bmFXa0RNNmlRc3dtTktMZUo1U2xxMExpaWVIQ1dC?=
 =?utf-8?B?ai9HdGlSa3AwRXBTVkZYZzhTL04xejMyYVdBZ0xsQ0kwQXlmUU5mblFxTHdq?=
 =?utf-8?B?SXNnRXhuQU05UzR1MmREUzF5TGdlRnFuZkQzbTRpRXZsUDJtVW9SaDVNV0Rl?=
 =?utf-8?B?a2NTeVZRUjVHbGY0MUFZSTk1bFo5b2ZWVGl0L1gxcjl3N0o4blFBMXlERk9s?=
 =?utf-8?B?T2NWLzZ6bmVyM1RUOTBkV2ZTS0d3aWpuRjVUUkVPbVcrODJqV3prSzY4d200?=
 =?utf-8?B?SVdwM0RXMGhmTzVnODZZS2d2eVFrbENDV3FrcldJT0hQTEZPZnFJeURYYnBG?=
 =?utf-8?B?TGFZbG9hMFl2VnN3NS80djREazNnNzkzaGVWaTVETHozZFBucTU3ZlAxdG1G?=
 =?utf-8?B?bnlsK2xjMlRmWWxKTDdGZmMvU2xyN0lld2lVYWVIRHVVRUNkYWRYWW5sR2sw?=
 =?utf-8?B?QmtYcGE5RFdPNHdwR3ZHTDZHU1VaVnB0WHpWc2greWxiQjBZUUIwY3RqbHRm?=
 =?utf-8?B?RjFoMU5pQmhRbjlubG12TGhOMVJ4YlFYU2dTZ2ZKblRwMmVVb0FiR1I5WUo0?=
 =?utf-8?B?U1NtYUJpdExTZTlwam1qOWtyUkFNVG1SMk5rQ2NEVS92ZmI4ZHc4R2Z1cktM?=
 =?utf-8?B?Y0pjOFNBWUgvb3E1cXpmQjFIcVZoeGw1eEJIcURkQUpycnlmbGlVbVB0cWZ1?=
 =?utf-8?Q?ECfsIjYpvW2YLsWFR7WjSnGID?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7dbdcb-2992-4676-3091-08db60103d0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:45:06.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OWXwawlzO5b6fPSsu89LD4U0/v6f1IkCpd6R0LrsutNsz5FRtBAtNYcRB0HlA8TncjSWIHwqW2E60weScDAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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



On 5/29/2023 8:05 AM, Xiao, Shane wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Sent: Saturday, May 27, 2023 2:12 AM
>> To: Xiao, Shane <shane.xiao@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when
>> allocating VRAM in large bar system"
>>
>>
>>
>> On 5/22/2023 8:52 AM, Xiao, Shane wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Sunday, May 21, 2023 2:39 AM
>>>> To: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>;
>> amd-
>>>> gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>; Xiao, Shane <shane.xiao@amd.com>
>>>> Subject: Re: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when
>>>> allocating VRAM in large bar system"
>>>>
>>>> Am 2023-05-20 um 05:25 schrieb Arunpravin Paneer Selvam:
>>>>> This reverts commit c105518679b6e87232874ffc989ec403bee59664.
>>>>>
>>>>> This patch disables the TOPDOWN flag for APU and few dGPU cards
>>>>> which has the VRAM size equal to the BAR size.
>>>> With resizable BARs it's not that rare.
>>>>
>>>>
>>>>> When we enable the TOPDOWN flag, we get the free blocks at the
>>>>> highest available memory region and we don't split the lower order blocks.
>>>>> This change is required to keep off the fragmentation related issues
>>>>> particularly in ASIC which has VRAM space <= 500MiB
>>> As far as I can understand that, both ways may cause fragmentation issues.
>>>
>>> As I can understand that remove TOPDOWN flags may get two pros:
>>> 1) It can reduce the research time to O(1);
>>> 2) Reduce the risk of splitting higher order into lower orders when allocating
>> blocks.
>>> But as for the second point, Removing TOPDOWN flags still carries the
>>> risk of causing fragmentation issue on some scenarios.
>>> For example, the apps need allocate (1M + 4K) VRAM size, which is not a
>> power of two.
>>> Case 1: If not using TOPDOWN flag, we will allocate 1M order size and 4K
>> order size from different order.
>>> --And then if this 4K buddy and 1M buddy are freed, it may prevent the system
>> from merging 4K(or 1M) to 8K(2M) order.
>>> --If the app has many such allocation requirements, it may cause
>> fragmentation issue under memory stress.
>>> Case 2: If using TOPDOWN flag, we will find the highest order which is
>> suitable for 4K and 1M needs.
>>> --Assuming the highest order size is 8M, then we will split this 8M to lower
>> order to meet the needs of 1M and 4K sizes, respectively.
>>> --In such case the 8M size will split into different lower orders.
>>> --If any other thread or process need allocate 4K or 1M VRAM, and there is
>> also a chance to prevent the system from merging 4K(or 1M) to 8K(or 2M)
>> order.
>>> If there are so many needs to allocate not power of two pages from apps,
>> one of the choose is to use suballocator from UMD such as what ROCr does.
>>> That means suballocator can allocate power of two pages(for example 2M
>> bytes) from driver, and the app can allocate memory from suballocator.
>>> In such way, it may reduce the risk of causing fragmentation issues.  But I am
>> not sure that such an option is feasible.
>>> Maybe case 2 occurs less frequently than case one, then we should use
>> TOPDOWN flags whether the system is lar-bar or not.
>> Yes, It is better to set TOPDOWN flag mainly to avoid splitting down the lower
>> order blocks which resolves the fragmentation issues and it doesn't try to
>> allocate from visible memory (provided that we have the enough requested
>> memory space in the top down region) which improves the graphics
>> performances as well.
> Hi Arun,
> Think it more, the gfx needs get continuous VRAM for display something.
> In such case, the TOPDOWN flag can meet this need better than not use TOPDOWN flag because the drm buddy TOPDOWN flag
> is prone to meet the condition in amdgpu_is_vram_mgr_blocks_contiguous, which means that the blocks are contiguous.
>
> As you mentioned that issue https://gitlab.freedesktop.org/drm/amd/-/issues/2270 , one of the reasons may be that TOPDOWN
> flag in drm buddy can make it easier to get contiguous VRAM with the size of not power of two.
> This means that we do not need allocate contiguous VRAM again and then do copy for display something.
> In such way, we can get good performance and reduce the risk of allocation failures.
> If so, it's necessary to use TOPDOWN flag for gfx.
The reason behind setting TOPDOWN flag is that we don't hold the small 
blocks randomly preventing the merge back into larger sized blocks.
Enabling TOPDOWN flag allocates the smaller sized blocks from the higher 
orders which are split already for the previous requests, thus we
don't disturb the lower order or middle order blocks. Hence we don't hit 
fragmentation issues.
>
>
> Hi Felix & Christian,
> However, for compute, there is suballocator on ROCr to allocate power of two sizes from drm buddy.
> If we use the TOPDOWN flag,  there is a potential problem that split higher order into lower order.
Exactly, this is what we want to solve the fragmentation problems.
> It may increase the risk of allocating higher order blocks under memory pressure if we split too much higher order into lower order.
This is not a risk, as I explained previously we dont disturb the lower 
or middle order blocks, hence we could see improvement in performance.
>
> If so, my question is that do we need to consider using different allocator strategies on gfx and compute in large bar system?
>
> Best Regards,
> Shane
>
>> Regards,
>> Arun.
>>> Best Regards,
>>> Shane
>>>
>>>> If TOPDOWN has these general benefits, then would it make sense to
>>>> allocate visible memory TOPDOWN as well, on large-BAR GPUs? Without
>>>> knowing too much about the internals of the allocator, my intuition
>>>> tells me that using only one allocation strategy has a better chance
>>>> of minimizing fragmentation than mixing two allocation strategies for no
>> good reason.
>>>> Regards,
>>>>      Felix
>>>>
>>>>
>>>>> Hence, we are reverting this patch.
>>>>>
>>>>> Gitlab issue link -
>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2270
>>>>>
>>>>> Signed-off-by: Arunpravin Paneer Selvam
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 2bd1a54ee866..ca5fc07faf6c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct
>>>>> amdgpu_bo *abo, u32 domain)
>>>>>
>>>>>               if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>>>>>                       places[c].lpfn = visible_pfn;
>>>>> -           else if (adev->gmc.real_vram_size != adev-
>>>>> gmc.visible_vram_size)
>>>>> +           else
>>>>>                       places[c].flags |= TTM_PL_FLAG_TOPDOWN;
>>>>>
>>>>>               if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

