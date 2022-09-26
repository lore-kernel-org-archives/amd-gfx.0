Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28E8C07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42DD110E6D1;
	Mon, 26 Sep 2022 15:06:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5667110E6D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6pPp9AUpej2YYiMfHFGqQbZ4oSc9hrkU3dTZ6l832YCXsVG8q17bLO9XBpQb8YaYh9tJKeaDFbESeglQX+1L0kN6ermfhTzUcNJ3rCzjSuv/2ky8Ho5+bg1ZqnLhj5OdFboPUpnOs6EUmGBA2QuaLUCq2MJ2/DehOu7o0g2DGccF/Vc0XMP5f6ige21p4gCZX+3VNE0Mr0aUF1lfMtSE2NdlmD0ZZOr0PuHpQDa/ptWVq2FT/+AcwNxlosbWfmpLRm5jNnbtVfqM7Y31l7wzwUvMMQ5ef+qHohLcqprAifAq5PSMg0b0PhXp45jRz4ZkD7WfbRftQh3SApbWDCX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p50vOekaQM79OJRITVG+nUmIW4bJ/a7tgv+qreZgd9g=;
 b=KiSvsEOpEleLx74cKeObp/+BuKonpt5p+BpfJOjRSX4VpTRuh6nxz8RzvzxterBFgmQIdkThEHdK8VUkBj+za/JTSegXt02g6CXAz4gyrN9e1znlmwCa1VIxz5slAFjHg+V+qXXnBlDZE4kF/24Rneb3EZ+2vIw1K6Qf3KPtYch9PWLGUH7TbK4ndGiRngAKGkCxuR/Q1OW9RIrb6QDJh9NqMHcHZZrK6kymhV25TRX6EKy5oVkgxmTeaBdV00SAyKYKaLHr6jemYMbSKusNhOU/tfzVRuZfgRbyPVxnlwZ/0elFicQ5jo4yChqIlx0Vn1TDkGn6jFP451Bthft47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p50vOekaQM79OJRITVG+nUmIW4bJ/a7tgv+qreZgd9g=;
 b=e4pjqaszfCaRLfGCCJICDmElTFrbgL26X4SykF6caIgqmJ79Z4i8YS5j0J8tBQOCiVNQ4IUXYlpym3uOSWtWTyJ78MzPEWWFtflkza2Zzvi2KQC2hPdKFP6poX0yhaBgZf5fpkvexhg9yeLWJpUcMrrdPP0Nm3NpgTB5Ag2yQe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 26 Sep
 2022 15:06:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 15:06:52 +0000
Message-ID: <80629e43-3953-a1b3-ea47-7459dde387eb@amd.com>
Date: Mon, 26 Sep 2022 17:06:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/amdgpu: Fix VRAM BO swap issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220926052529.2586-1-Arunpravin.PaneerSelvam@amd.com>
 <799e07a5-435a-6608-bd54-6b48d6af85fa@gmail.com>
 <eaefa0bf-f7c4-675c-72a0-377e681ce281@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <eaefa0bf-f7c4-675c-72a0-377e681ce281@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0005.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a6d7d4-6e21-4cfa-25eb-08da9fd0be1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhWuCFHaUNwhC4rWceLpKOsS2yOv02z9ovbIR1D5UkC8kwmkiGVkFKEXVQ9sxwz+0DlivxU8p3zhFWPYs+/zcLq3SZ5/ofxA2DpG4USIGja/7/8LRCiNIZeUtHi64mGWtgrAEeRrL6Q1ZoJjHd2SgyOeEkE5FIoY/VbwAriumfVVn5LnNHZoAuUg8P0d0hCoWssx9JneRn3TwPmdRKJZXgzrL4nJIPiVmYhLrQtYmR0CMMj1JdilnKtPVXyako22AxiD0fUts2R1g6B4OreeWb35KCIgpEMDNP1IEAhz4tU6Czyx63GlcEi3Rj/8h6J5s9C0dDKuEY0msLyVi+LaDxhqhp1AyIIaCF9t6N6x1/FgFtE7Q3+K2ynVKbPuVw4KGd1GnTr6rEuNlRqx5ApYkJMvhwY+CX10X8h75jW2yKXINnMuI1sfnEkSJ7eTFaPjwBNAHwKrPIauWJsfP1iCpKE0rQnpjLpYxAKCIsoYWh19kL2S0GM6/WzBg1ioFA3V8vmi67cxfzM4RyJirNds7seGq4IuIug8t5WE0Ig5RaXO96sJfGMAU85XNULAzjoMllpZhziufygjCkxfaYFU+ofHNu6axKS/wuKQ1fEsDaUppYlr4Y36LtkZVDN1wQAXytE/dFaLFtRYCficr9cRrKz3yMNZAICRDs49mbQq6sd9qgjZL2UBhgJ2AtP0Zub+tQDLSUMcdNzU+EhQ7v/oDDjWzLrpirUPmbTczIMLRA2pHQlGXdKdDsPEoG4Gefy49tZsPc16JjnBdKkwG4TIKquuGdAwqeLjdLuBznCLq1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(6506007)(6486002)(53546011)(41300700001)(478600001)(6666004)(83380400001)(2616005)(66574015)(186003)(6512007)(2906002)(5660300002)(110136005)(66556008)(8936002)(66476007)(66946007)(4326008)(8676002)(316002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhkUGtadExWQWc3c3ROWUtLdjBuUFliUTVqbTVMWGhveFBpbktoS1hlWnVM?=
 =?utf-8?B?T0VMNXRhNFZlbk5HZ0JoOUxQdmw2aDVDajFTTlppdE5lUHRNNE1wSHRvR2Iz?=
 =?utf-8?B?QnJkVld6SEphRWI5cklTdDJzVjBpejFoSEJ2TklhdmpOQ3lYQ1hkVHVUdFU2?=
 =?utf-8?B?aVVyQjVVWnRKOXhRMXZiV2ExdldVMk4xM0RTanpvOUdRWjVNWW1sbkcyYjhp?=
 =?utf-8?B?dWplV1k0eWRDTE81RzFBT1dkRXlTUHVERHl2VmxFUlN2SEFFK2EvQ1d4cXpW?=
 =?utf-8?B?SXArWGMxT2ZHZWZHTTYzUjhkSXI1bEU1bWZYSm1FL2pESzlkS2J5YkFqMmx2?=
 =?utf-8?B?TncyV2RneVFxdXRrKy81TFV1OHcwV05pc2lWQ3pHK0ROWjhhUnhBL0tOQy9n?=
 =?utf-8?B?OElLK2RTMHVIK2JxVldxcVJ2VXJ0ZXIzRFVqMjJ4bytCWkZoT1JvZzM1aUJO?=
 =?utf-8?B?TllsTjNZK2J5Qkl4ZXBXZFZPQjhZekJzMng3RU03YkJUMlFWTmlGRGVtUFZa?=
 =?utf-8?B?N3BMRW8zMU5lZy9IaEU4QTFkRzczNk5YT3JIbTFPd3kxSjdSZVR3akNubE9B?=
 =?utf-8?B?bURDZjd3MDlndkRmNEFrazhkOE1IaFYvdUlvVk50cENqeGZucjRmdkV2Mm9Y?=
 =?utf-8?B?L21hRklUcktZRTFqSStOcVR0bnR4TVQ3UFdycTVRNkNLQVNqYlp3dVozNGJN?=
 =?utf-8?B?NWhpSTQrcTM5dXpVb0VZOGpjVllGditGdlR6b3dINFdwcThrbGRWbEI3MTgy?=
 =?utf-8?B?Y1BXOHVCTytEUDJNOEtWZVR4NHc3NU13OExEcWhXTDRRenpNalJ5R3MvcHBr?=
 =?utf-8?B?d1czSVRzendYdUhIOFRWa1pjRS9QMDRoblZPUGVQSEIwcUtvcmV6L0ovT2hV?=
 =?utf-8?B?YXlMUkRsdjZXWWxpc2xDSFYwdyt5MlgydGFKTW5ZQ0Rib01nSmI2OHo4LzZs?=
 =?utf-8?B?WFZxdUpyMGJDZjg1ajc5K3ljK2lDejkrcmtHUUdkdTNDbnBhbFp6NHFXdk5l?=
 =?utf-8?B?UDI2Y0xCbGl3cDQ0R3o5d3ByaVd3MnBpMUtHOW1NdDZFTGZocXFpdThBSXJt?=
 =?utf-8?B?ZloxMjJZTzZFVzdBdHRrSy9tNkdDbDlPNFp4Sk9uSXVMRFN6OE1Ta2UwRy8z?=
 =?utf-8?B?RVZoMUJXOFpDUGV0MzFCRTBtNzI4cG1YRk5qbFBEWHgvZFZxYXFYSnlzRkk1?=
 =?utf-8?B?dGo0bDZ2QXVEblRNUHpMaEhJcWN0UFRWRWZMWnlSTHhMUzBzcXV1VDhRaG5U?=
 =?utf-8?B?SHpFbGFnREVzSUVBUVZCMVovVm1WYmRYQ0ZQaGlWd1pHcGFkMEJlYTAzYTE3?=
 =?utf-8?B?MG5ib3hWL0psN1J4OFpUdncvbFJqRGNIaitTVFJMbDVRd0p6TzNUby9VY001?=
 =?utf-8?B?YzhYNnorTXpFcG1ydFN6V3dYRE5pUHlNdzUzZXlFY01TUnN0VG1GZFdYU2Jq?=
 =?utf-8?B?WXo1Vy9vdWNLR1NaK3cybk0zNUo1RVgzeWJ0dzVyU2FPK2g1V01XUGdUWTVG?=
 =?utf-8?B?aTNuVVlHT1V5cm53b3EzdDBTMkFEU1o1eVRKeWNpMWE3Z2M1MndZbU1HTVNS?=
 =?utf-8?B?NEJPa05Bd2t0QTduemdkYTlwY2FlY0hiTDNKUU8rV2ZkK1l5NEJTbHVQZ2R0?=
 =?utf-8?B?anZIa1JhTWw4ODZRd3RRckJTTDJXNnBjNjRYbFBDK20weFlUMDJGUDBJNzdX?=
 =?utf-8?B?dVZGNGl6MVplQWxSd0VpOUhQZlZPOG42amo2REtodWxPWE1KTHZjSjF1RjF5?=
 =?utf-8?B?WCt0VGN6T0NZcHVqSHY2ZWJMOWMrZTVDYzdjVDFPbE5oeDRqNndPQXRaR000?=
 =?utf-8?B?bnRQOCtyN2ZlUUUrcUc2dGpQYlg2K3FjdHA0R094cXJRYkFIY1J2VHZxZndO?=
 =?utf-8?B?aXhMTlh5MGV2a3RybnhuUkZwWHRlSWtVaUNuVTVXaHkvOU8zMlEySUlZZFhB?=
 =?utf-8?B?M0tVYWp4NlRrTXpLdEkvcU9KY01NWVFlQ1ZXUm5qTVVqZmRUTU1ydDhLNjhM?=
 =?utf-8?B?Rk5Md1pwRCtPSUVyUXVMNXNkOTc5UVpaN0hMbUk5NUoxaEUvWXlVNzVueTN1?=
 =?utf-8?B?MUlTS1FMUmRvL2JVaTVzcWVUTFJVVExYOXRpQVpyU05pdDE0dVNkY0ZwS0RX?=
 =?utf-8?B?ODhTYi9ObFg5aHhiRktNeEg4WWZpUDhRQ1VEUTIxbUJHNUVnZ25JOFpueGV4?=
 =?utf-8?Q?9j0vVBvVbsGS3lGLS6mwHbGGrZs22Bk9sge99gMUlIJb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a6d7d4-6e21-4cfa-25eb-08da9fd0be1b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:06:52.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s2pB0fI/eDoXt2ioOHzAgZtsNL9UU8ahS0WKI1G0jHlmnEurMUUJqmRWNB6ZXEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 17:04 schrieb Arunpravin Paneer Selvam:
>
>
> On 9/26/2022 12:01 PM, Christian König wrote:
>> Am 26.09.22 um 07:25 schrieb Arunpravin Paneer Selvam:
>>> DRM buddy manager allocates the contiguous memory requests in
>>> a single block or multiple blocks. So for the ttm move operation
>>> (incase of low vram memory) we should consider all the blocks to
>>> compute the total memory size which compared with the struct
>>> ttm_resource num_pages in order to verify that the blocks are
>>> contiguous for the eviction process.
>>>
>>> v2: Added a Fixes tag
>>> v3: Rewrite the code to save a bit of calculations and
>>>      variables (Christian)
>>>
>>> Fixes: c9cad937c0c5 ("drm/amdgpu: add drm buddy support to amdgpu")
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Shall I push this patch into amd-staging-drm-next?

If it applies cleanly then I think so, yes.

Another possibility would be through drm-misc-fixes, but since it is a 
pure amdgpu fix we should try to avoid that.

Christian.

>
> Thanks,
> Arun.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 17 ++++++++++++-----
>>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index b1c455329023..dc262d2c2925 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -424,8 +424,9 @@ static int amdgpu_move_blit(struct 
>>> ttm_buffer_object *bo,
>>>   static bool amdgpu_mem_visible(struct amdgpu_device *adev,
>>>                      struct ttm_resource *mem)
>>>   {
>>> -    uint64_t mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>>> +    u64 mem_size = (u64)mem->num_pages << PAGE_SHIFT;
>>>       struct amdgpu_res_cursor cursor;
>>> +    u64 end;
>>>         if (mem->mem_type == TTM_PL_SYSTEM ||
>>>           mem->mem_type == TTM_PL_TT)
>>> @@ -434,12 +435,18 @@ static bool amdgpu_mem_visible(struct 
>>> amdgpu_device *adev,
>>>           return false;
>>>         amdgpu_res_first(mem, 0, mem_size, &cursor);
>>> +    end = cursor.start + cursor.size;
>>> +    while (cursor.remaining) {
>>> +        amdgpu_res_next(&cursor, cursor.size);
>>>   -    /* ttm_resource_ioremap only supports contiguous memory */
>>> -    if (cursor.size != mem_size)
>>> -        return false;
>>> +        /* ttm_resource_ioremap only supports contiguous memory */
>>> +        if (end != cursor.start)
>>> +            return false;
>>> +
>>> +        end = cursor.start + cursor.size;
>>> +    }
>>>   -    return cursor.start + cursor.size <= 
>>> adev->gmc.visible_vram_size;
>>> +    return end <= adev->gmc.visible_vram_size;
>>>   }
>>>     /*
>>
>

