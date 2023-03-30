Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E273FC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 14:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C6A10E2D5;
	Thu, 30 Mar 2023 14:15:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2EE10E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUcILo+dmMuLZBtVEXXiotz8r8zC+L2pHrRHnGDBqafOJqtRIOygtLIKfQYgCctmxXlZEKaOag35tBjhPpzzR4fYw7hPzvl42GUQ0tLcJBtiPwau64SelVMii8MYLlI0SV0TbYFoP2UlhPxeHyKZLXfqcLtAjrKMmhgaTJTOIuXBjAJrJM0SnQSHRjbtlA7I3ixh9aKBOT6/es6G/YU1hqmCTYQdZh3YQGPx8oraFUljlA0DHZf7SaUetZlRghvN0pYFUMM5gWnxc+csMZzn++WjrIzOh9eVAL/6ifNJOTZl/YRHNI2nhfjPN8aiITLKxW6hQwgWqdJEsN3P0Ew4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYcVj/MbJLp0HiRTa5COWx3Rsk1V8Pr9cbg1+py3reU=;
 b=Sh07P5dto7lD56lTFpPi/RRyjJE2cFUATyjxd+ahuVVNI/kaM9fNklNldhk+6CSe2FN0DdrDDrxe+fobtvCh6vzT0F820CDwlq9v52wgOX5ev1c9vt7Ukh6Tcn8AvaRDidnrwCL3JBlFAScldtNHPTCa0cigYZR6Jjq1NjjqeGvvUreUWnsUEafGGL+/jLObZFPk/3UxFbCmKSmetdEltq954IiM1asMfyZof1LnfBZUGRQVLy9Z0aqOYR+5jbV8CtLB0qMq0TEpxi57q56gBxW5IApWtLE4PTNpjS3BxatkBCmOoiRJVj7Uc8sG0X5WskbJ/QK7T7cxOqafEjSU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYcVj/MbJLp0HiRTa5COWx3Rsk1V8Pr9cbg1+py3reU=;
 b=P6koTtyRoHJhLV4faXfsdrqrdpk+CEHOGfCGpV08wBGAtu07iNil45a/60PFNfD3oE26fCZZawMxoxL+CeeQVHNhVFl/wsnN3oEvF+SjQFoBaLm/dl7VFSmeZGykjP3qd8PaKaAZ/AqZXGFlqbwyK2BN0jxwj2Hcwb4Q0vYWFOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 14:15:41 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 14:15:40 +0000
Message-ID: <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
Date: Thu, 30 Mar 2023 10:15:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
In-Reply-To: <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fec546-076e-4451-d210-08db31293d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmxtBR/stVCpANJsIPcaa3bjW50DWg7eCZH3aXi4QqPIN48RaOjvW9PlWmVNmnF60lVlOxWdr33NhA+grAbBwaXA4I/b6yz1a+CoKK3hRAy7F2pL4Fi45A2eNkkXyPXvzZRx20ztrMSJhd9gCVDHKIvvckfasA8jS0smUa0fIqp5bH9Rywh1K5VM6Y0th1r3/2FoDbarjOIaD3QA/Eu8xnWHMgHHY9yexk02mVQ/Fwbyj+zpohhIn5Cntb27WDwICw6WH+AlfIC3bGF/KNg6QYvoDqPrZZPyEdSHe61PwM6ntBh42eZPhl9w0p9B7U3FYcnMU2Gkrspz3BEn6XFPUnuysSDpNzJzckmymMzYsCCmVG6lfLLiztPcRGJziFsAtyB+3NPhdWdP60S1qRMkthM0kZPE0UVsBZ7qNDzjQ79WCWtMapu48ujVlSiPcKoC5U9ktk7O5B+bKnE6xBsg5JEOrc67LGaZvbEg0ZLA5OIVUo0OY4HMWXyQsMNhUYFgY3PQS2GVI4cLJvl7VZkFhqN+D9+JFQSkWDKoJYDuF2fNXCpa7u5wdu/8ULu+MIp1Hxu/teNcGmv7L8sHtxqsynRO/X5m71pqcFsNt1cbajDrl+d2sOhcLYFTncWLlUAGKqowU6sm5bh3Z/bUoAkQJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(44832011)(2906002)(8936002)(38100700002)(41300700001)(5660300002)(86362001)(36756003)(31696002)(54906003)(6486002)(316002)(53546011)(478600001)(26005)(66946007)(66556008)(66476007)(6666004)(8676002)(4326008)(2616005)(31686004)(6512007)(6506007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTVqY2dsMjFNNTJDN1ZpbzBSa29CV1ZvcURRY3A5cFR5M3ZybnhGYVlwaW1R?=
 =?utf-8?B?L2VKbTR0R1lmYitRdk54c0RqNzFoRXdhM2RwUjVobGNQbUNNOHlRRVdacWRy?=
 =?utf-8?B?anpHTFI1UDFGZjN1T3o5ZndmY2RxZmZWWU1NbnRzNTg0ckJ4TW55bmRWY3N4?=
 =?utf-8?B?SkVNcjJBK21zc0tHUm1kQ3p2Zml2ckFhejFiemxVZUNEeUFYd2tBUU5tSTV1?=
 =?utf-8?B?bmM0MC8zVklWamxGN3NoRUYyM24vTXJPUnVHelFhV0xMdndyejZOQU9JT0Jz?=
 =?utf-8?B?WCtYU1Y2SER4MzR2aGw3WXF4SUlnR2ppQkZKbU1jc3ozRlVBendYQ3Fpd3pa?=
 =?utf-8?B?SnFxbWYxMWRRZmJLMjQ4NWU1RUw2THFGS3lHUENMTFRkQUgxWXdkVXBpTFpy?=
 =?utf-8?B?a3lhendaVkUxSVJXbmFGaFJNbnoybm5WYUZEWnV2WGVGSUhQSC9EMVpwTUdM?=
 =?utf-8?B?RzB3aGVvRDNyV2w3ZUZTcGdoR09Fek1BbGtrZGRpdWN3bVk5MDhjS3F5djVn?=
 =?utf-8?B?TDJXc2NkcktGczJ5ZzRHVTZ3bVhVVUNvNGlVRWhsZ01kSGd0WmQ2T1JIUU0r?=
 =?utf-8?B?ZVVxcXBvNGo1S202eW83alJVSWx6ajErZ3RUTldqYmFPVnhGaTFNWGVRMnBT?=
 =?utf-8?B?N1drZFFtZXd3WUNtM0JROVAvbzBzRmpWNEZQSFJacm4rdHpjZGMyakN4K2lR?=
 =?utf-8?B?R0RoQTNKOGQ5MUMwSXZ1Tko3eW12N1VOV2xHTGxkR2t5aEtCNzhWYi83N2lh?=
 =?utf-8?B?TUIvaHpVeXhWWGRQeCtvN3QrTnEwaGw4N0YzUVBodW1EbmEvamFZbmM3V2hL?=
 =?utf-8?B?WjgzVk03SXFCbjNETlQ2dkhTaHFQN3U3Zmg5WlRxWG1mdDRDWXBRdEZ5ZW1s?=
 =?utf-8?B?L3ZKUktxZTE0UkRKQTBuTzF1Q0FaYURZNFlhcU9aaFBrWkhOczRwenl5T2Nr?=
 =?utf-8?B?MTBJQ2F3VzJJeHlxUTNwR3RoMFE1SDhqM2R3bXZyVk5UZkhZcTRUbERNS3No?=
 =?utf-8?B?aTF1UGFWYnhVSWh3UFZhVzA1ZG5LYkpjYitwUWdwNjJuWmdZYmlHbldwSjFD?=
 =?utf-8?B?RUUvZWUrMy9zcXlRTm4wbGNvUlg5L2tWSXNwMGFkeklOMVl0bk4xNmlpeVcy?=
 =?utf-8?B?UU5LUy94SERRYXhkRDk0anVoZ2Y4U09ONE9UTXhlR25UMVJMZVVmbTF1V0x1?=
 =?utf-8?B?eUNTTmVhVVl3UjV0c01wbVF6YjIrank3Y1RaUS9qRGlDY3RlS2Rrbm5QdVhh?=
 =?utf-8?B?YWJmUmdsS3pPTEtFMVgzWk42Ny9wREIzMWpPcnRzR0duMTVtVi8zek9YZGlv?=
 =?utf-8?B?SzRNeUJwMDRhVEJMNHFhZWJDTHJVQzREcHh4K2kyYXV2ajJkRVh0VUthU1Yz?=
 =?utf-8?B?N25ZTDRlQzBwVWl2bFR5VXQ2aXR2RUdHYmgyL0NOMUUxU3NGMnBJR3RudGV6?=
 =?utf-8?B?NSszcUJTeFg3aHhGYldoOFJaZnpaWlBGOFZJejNwTkZUa0l3SkFHcWlTV0gz?=
 =?utf-8?B?TTA2aXdhRVhkL0lMbFA4VVk5WW9yaFVxTnEzRHRlL242QzVoN1VIWWl4M3Z0?=
 =?utf-8?B?NHdDdGtDTmlHWVU2YlNoR2QrM00zRk9ONWJtdjlYQ3pRVVU3T0ZkNllKbTdG?=
 =?utf-8?B?VUl0ZU90ZjVaZGVtdEhZNWxGcXd3SjJlcit3anlDSFkxcktldU1ZQThKZCtG?=
 =?utf-8?B?cE9qZUtIN2MrZ0RwV0RIa3I0ZU1mUUZZc21wSmUrcnN2V2VtNWdNYUJKS3Jo?=
 =?utf-8?B?c29CYUp6RjVNcENqWXhyc3hOdlN5VWJnVmtWWGY4VWtOQyt5dWE5UmhPNXNP?=
 =?utf-8?B?c0Y4QWllUHpQTlJvNkNYU2FESFFUdXNQRmp2M3JXdnZmVnFJKytiQjBPNlk5?=
 =?utf-8?B?b2J6Z3ExUmtCV1pOczQ1czMySVo5VC9vQ3pqNWZIYkQxSzB3SS85VkJxVG1T?=
 =?utf-8?B?dXhZRXVEZEFIbFRrczVkcW1oV3NLREh3NnR6bWJVMXJkeW9JaG5rVndKb1pm?=
 =?utf-8?B?ZGFNM2ZqZGhsNzhuU1g5Y3VNQmsrZTAvTXRENE4xK1VGcWpnUFVsQmRPajh5?=
 =?utf-8?B?N2tNM25SQVFnaE1YRUY5R1FMODc0NFJhNjAxSE1iNjZ2TklKMGNkVXR3NWZu?=
 =?utf-8?Q?5gBTNgxmMHycssDWwkGVhPsFv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fec546-076e-4451-d210-08db31293d9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:15:40.2443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY8TYMQQ0FT3VobN/T0xx+Y1MCZ791N1Zvd6kx7eflf7HAcDf6t3sLQJi/2sara/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-30 10:04, Shashank Sharma wrote:
> 
> On 30/03/2023 15:42, Luben Tuikov wrote:
>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>
>>> This patch adds helper functions to create and free doorbell
>>> pages for kernel objects.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>>   .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>>   2 files changed, 90 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> index f9c3b77bf65d..6581b78fe438 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>> @@ -27,6 +27,24 @@
>>>   /*
>>>    * GPU doorbell structures, functions & helpers
>>>    */
>>> +
>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>> +struct amdgpu_doorbell_obj {
>> In the comment you say "Structure to hold ...";
>> it is a C structure, but then in the name of a function we see "obj".
>> (Object is something which is defined like in memory, i.e. it exists, not
>> something which is only declared.)
>> This is just a declaration of a structure, not an object per se.
>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
> 
> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and 
> many more existing structure.

The amdpgu_bo is very different than a structure describing a doorbell.
The doorbell description isn't really "an object". I understand
the enthusiasm, but it is really not "an object". It's just a doorbell
description. :-)

Regards,
Luben

> 
> - Shashank
> 
>> Then in the definition, you can call it an object/objects, if you'd like,
>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
>> "db = doorb_object[i]";
>>
>> Regards,
>> Luben
>>
>>> +	struct amdgpu_bo *bo;
>>> +	uint64_t gpu_addr;
>>> +	uint32_t *cpu_addr;
>>> +	uint32_t size;
>>> +
>>> +	/* First index in this object */
>>> +	uint32_t start;
>>> +
>>> +	/* Last index in this object */
>>> +	uint32_t end;
>>> +
>>> +	/* bitmap for dynamic doorbell allocation from this object */
>>> +	unsigned long *doorbell_bitmap;
>>> +};
>>> +
>>>   struct amdgpu_doorbell {
>>>   	/* doorbell mmio */
>>>   	resource_size_t		base;
>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>>    */
>>>   void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>>   
>>> +/**
>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * @db_age: previously allocated doobell page details
>>> + *
>>> + */
>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>> +				struct amdgpu_doorbell_obj *db_obj);
>>> +
>>> +/**
>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * @db_age: doobell page structure to fill details with
>>> + *
>>> + * returns 0 on success, else error number
>>> + */
>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>> +				struct amdgpu_doorbell_obj *db_obj);
>>> +
>>>   #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>   #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>   #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> index 1aea92363fd3..8be15b82b545 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>   	}
>>>   }
>>>   
>>> +/**
>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * @db_age: previously allocated doobell page details
>>> + *
>>> + */
>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>> +					struct amdgpu_doorbell_obj *db_obj)
>>> +{
>>> +	amdgpu_bo_free_kernel(&db_obj->bo,
>>> +			      &db_obj->gpu_addr,
>>> +			      (void **)&db_obj->cpu_addr);
>>> +
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>> + *
>>> + * @adev: amdgpu_device pointer
>>> + *
>>> + * @db_age: doobell page structure to fill details with
>>> + *
>>> + * returns 0 on success, else error number
>>> + */
>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>> +				struct amdgpu_doorbell_obj *db_obj)
>>> +{
>>> +	int r;
>>> +
>>> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>>> +
>>> +	r = amdgpu_bo_create_kernel(adev,
>>> +				    db_obj->size,
>>> +				    PAGE_SIZE,
>>> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
>>> +				    &db_obj->bo,
>>> +				    &db_obj->gpu_addr,
>>> +				    (void **)&db_obj->cpu_addr);
>>> +
>>> +	if (r) {
>>> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>> +		return r;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /*
>>>    * GPU doorbell aperture helpers function.
>>>    */

