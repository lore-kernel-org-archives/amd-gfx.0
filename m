Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01344C44501
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910DB10F8B8;
	Fri, 10 Jul 2026 13:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSwPey2Z";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3FE10F8B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYmor67FY+JO6hECHSx3U5fcMMUR+cR4Z8Z4i7eVOKhqfxSnbDbfXD+P/NKUm+aH/sZshuZjoJ5Jd4gB8MjA3jA4SCswuNbti/3oms0lMqCP7ihftBCSJTDg7yQOEnvewqJXMj3uaVbYL+KVw5j8vMutfJk9d+UfjBCrLWffqtHRjsmDsTNoLYJSR4X1kmQdKfQDbVfpddbC1PQ/gZI8PmX6oMDiGT2QAvPedWib+beqJzaVhYlybUivaTyoseDlKyYsqg3Zqm5LbL1XFZbV8TKOl4Errg2xz2y7DyINQz05BgUNUiDOFMO8Uxs1SjDwuYMn6na1qNvh1ADSA8ws6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVpT5SRkbDV7NIbtmRKDd2mHSq23n1djHUO5yLe8Dfc=;
 b=IMRqRJzmFlfik1MIa3FrgVvy1A/p5l+BH+DfHQYSRCwaKrv0+lJEkmclXnma0qGC24eAXzRiizQZvRJ+Fe356LDSs7QubCC8mKaLLC6E8GuqkVGiZyrgIC59VtkMiijElEewzo1g6lJAWnrTWrgnMWVOVG3aqNdU8eUmuQyrRDkmjYBtI2P04HodbalBICUqFpLiL+jdLTE03gQCM1rz8d7bp5fEICDwVpBDNphP1H/2j/k7SFjjWRD4x3TL5a8g0AQU7OhTjFqLUB90TF9e8M9Y6GlIBrcohyNl48uTa8eLKh0VUP/dHRMG/NIkVdqEwCSJ35O3pCEvg45n2U+agA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVpT5SRkbDV7NIbtmRKDd2mHSq23n1djHUO5yLe8Dfc=;
 b=RSwPey2ZIcny+GqXZETHDt+tACaAZgVmR/q7MHpu8W502IZxQzIesoWn2WklArI59SMPLGW9PXy8UBLzv2jDW6MULabJdHXnbP1O+ddYbbxHE+o0jZYcU55Wt+e3MuyL7kqHuF1fMB+Yx9er11bIGytXUKBmS4BgckHMc6PxvnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 13:13:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 13:13:54 +0000
Message-ID: <c1b31669-86a2-4e44-a66e-508ef82e8762@amd.com>
Date: Fri, 10 Jul 2026 15:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix bo->pin leaking in
 amdgpu_bo_create_reserved
To: Alex Deucher <alexdeucher@gmail.com>, Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, Ray.Huang@amd.com
References: <20260710091617.156343-1-lingshan.zhu@amd.com>
 <CADnq5_N5PR9CcJWD703jf0DapxGnDneAFyX5V0iNgR+27qWAUQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N5PR9CcJWD703jf0DapxGnDneAFyX5V0iNgR+27qWAUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0565.namprd03.prod.outlook.com
 (2603:10b6:408:138::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bc27fb-da3f-4e71-9d60-08dede8517cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XpFpUs1CwRu5WFUop4NqHisbVZJC/UKKDIYxU97G8kLqq9XJ+Wx83m0AEo4erFgW5mMg8ysx065syNKQAcCuBwJhaKAQhye41np1IAQzug/jG5Jz5NWN7YJ8U6w+qXfOzDfnyg/fRNhBbkTnfyie9SDAKztFQFqmEKs9/W54fJPehhlpaSsy7r6OJ6mI/ZYHvhPwApy4pB1ufhDpRKkxeBbLUX/W2I4v38WDh86iAmm/cxlX3//SEVl/9+RmlWzc/1zfYah7I5Itl9xHjCaw7NzGK0zPhYQbSYBm5swydl/2doNS9QcNTjIktF5wPlb/kPUYD4iJKJvTyULS4vX1fjucGhpSidIWwk+s7JR6ZwpZKSENUAUwMHrZm0RY7JDPcKOX3e6I/U1cmmAKWojlwDkGd9TP0813Dgr88YaY1CexpIN2oXWEp4IicXwJz/cILjO9Cay4QM3x3JdN1OiRLoy6W6LYHHQ72P+wmoIWjwi/tzr91j48EcmhjyEoEOykfF26D63PK3a0epMaYA5zev/brpPsy7AtM0lFvGDgKAnI4eP52/t8rAOLJsDhginClWVZsYl325NEVXFPgGBAEDoFvLOIWcOxrwZq/TPglV9qnjjm48hwR1AVl4pw65/TfhwSKto2CHrZjkpD1m5V2vLBC5xzEmtUdVIwhBfCNUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Y4M1p3bkJiNzlrM3RUY2xHYWhPZDV2Y2l6UDFiSGpkYjhqQ2g5d3I1b2dW?=
 =?utf-8?B?NGswcklCK0xrbzBwcTZ3L2lUaDBpMmt1TEJqNmR3ejdxSTZTTDQzRWd2U1lG?=
 =?utf-8?B?QmlURVFxZkVkOHhRclZrUjkvNXBTUTFwNFQ2NDArUG9MTTdhNWJnRmN3TFlZ?=
 =?utf-8?B?N0M3L2gyV2ZZYnpPUmcyYWdPd2dWdnhzQ0xXVzNvT082V2Y4RzVXQ1ZuaGZt?=
 =?utf-8?B?aXM2WGZIcVFMZDFncjdNWkZyZndIN0lWSU5FTFhseXRpM013VXNNT0pBNWxF?=
 =?utf-8?B?VmZwODVRckh1UDBmb1J2akszdVJpaThXeDAzRmFyVE4zbENOdXpYRzBxbjd5?=
 =?utf-8?B?bUVoQjRuYkdDaHZOMWs1V1gzVHBVWm14OW5adXlqeXQweDdCRjExMDZaWVJS?=
 =?utf-8?B?SDBJQ2JYbm5aWGFiby9EWUJ4VkczRHNnS0JMeUFLeVZvV0ZJNkhvMFVVQTYx?=
 =?utf-8?B?SnRVM2JENWlndGZDZEt6NEl4YXVGamx3MW5wWU1pUXVuRHJHRHpnVW1RWU5K?=
 =?utf-8?B?ZmhpQjV3ZlUzV3pob1hNbDEwS0pwYktwQjlid2NQS3dGTzBOa2g2VlRmZ09i?=
 =?utf-8?B?WGhjcitoTnFDakZueGI0S2ZQRTY5YUVxRGpwNUZiZFZUaktlMHVYODNtWm91?=
 =?utf-8?B?ZFZMTTM1MThMejJCeEZNODlaelBJRktzQ1JITzRCcGJjMFI1bDdHWEdWU1lY?=
 =?utf-8?B?bzBaZjFXN1N1dWhRM1kyR2dCM3lFclBkZzlZQ0JZYytFbW8zNnFaM2wyRS9u?=
 =?utf-8?B?TktrOGRnb1lsanp2VGw2T0RTZXdQWUJiRGZwTEYvRzJmWUVtYnhadnZVa0VF?=
 =?utf-8?B?OXo2dWpMd0d3bm5zN2Y3N3k4RHJvVWVUVzZpUFVCdm80VkNoT3ZwbnFlUjhk?=
 =?utf-8?B?OW9wYXk0QTVOcjk1L3ZVM0VzdHRRK2dyS2xCMWJtWElkNE5vV09MNWxTci9j?=
 =?utf-8?B?czhjS0gvRmlCUnlTZTV5SzhjSmRUQUdpbGxGMjNIQmV0bHNLK1RhSmVoK2Nw?=
 =?utf-8?B?REFlUkNVWUl4R2NiSzJtcEwvYXZGd1lKTTJZQTMybVdnZkEzQnhEQi9nL2ht?=
 =?utf-8?B?TWtwMDVWa082Vi9JMGJocGc5WmY5eEpjWnRKNkUyeDI5SG5ya0FmYXoxcTZJ?=
 =?utf-8?B?c1VPREdzU2hKeHZKaFZqY3h3c0tVUW9TRkVhYUN4UG9lem5VNkVpcDNLZGx2?=
 =?utf-8?B?NStoMHF4dWJRU3paMnpPNXI4bGZHYU5FVTRUM1d0ZjBKdVlqOXNOOEZCNUFv?=
 =?utf-8?B?MUd0T2FnTURWOTZLU2NtelJLd0NiWEwxSUVxeFE3bG1ZY3E2eGExY1hhbnBI?=
 =?utf-8?B?TlJ3blV1a2gzMEszc3M3NXhnNUdxMlRPMk12TVJiWDBTdytVcWo2bHRLRElj?=
 =?utf-8?B?YkdxaDZuTG56T2Jzb3FGSHVEK0hxVnhGQ2xuRGRxN3M3cHdsMFdGeFU5WUtK?=
 =?utf-8?B?UUxVdEx1MXZCTURPdnZCMDhsdnQrbU9Nc0k3dnZFNHFmT1pkZ0pLMDVWc3Fo?=
 =?utf-8?B?RWcwekJZMUQvQVQ1cmt1RjUrWDBPTmJTZ29aR2RWbTh6YzIwS0Z4dmc4cWZs?=
 =?utf-8?B?blRRT0ZYQU9md1FBOWlVdnRaSU8xK0txVlFiQnBVTzV1WXc3Zm5PRHVyRGNp?=
 =?utf-8?B?eVRRQ0FNNXF4NXFobVdGWDNwSU5WbWVGekhLM1hqNDBuaEpTZlVhVjB4R1Ny?=
 =?utf-8?B?c2RzdjNDeVNtNDZDSGM4b0pPNXlSSmQ4WURmRFl1SzREbDN2YXFNVHBCdkJY?=
 =?utf-8?B?NlFaZ0dtS1ZDajZSNHVEeTlJcklqMy9saEVIcTM5NHVWRjFxeHFlalNUOEZp?=
 =?utf-8?B?MTh5Y0d4MFZhM2JLWFFtUTdGN1FxdmE3RHJHdjNWMlFRZTJLRTJORVZCeFVI?=
 =?utf-8?B?QTBxU0VpZG1NRzU0WjV3OFY0UmlsT3p1QUVCbVpWa2FoSmFwNmhpV01zVlV0?=
 =?utf-8?B?Q2VxQ3FGS1NLZnhUbG1aazFhZ2xnYWxRNERNSXlEanZFdkhreDFnd0JLV2wr?=
 =?utf-8?B?ZnFyWEJIa1RzeGxaL1NXU045dCsxSDhaLzl3cFZtVlIzMGhwWGhaZXZOcTJB?=
 =?utf-8?B?TVM2V0JsRk55Q1ZWRXh2SWRic3N4eXhXVmtFQ0J4cDMxWm1TdnFJYW96VEhQ?=
 =?utf-8?B?ZDZDclBKRHBzUEM1QmN4MEd5S3JUNHhsUjh5cVRKaG8xOXJ0SmxXNjQxdXJh?=
 =?utf-8?B?elJLQ256M3gxRGlmcVNHcFB0dGhlYUxEZWhCYzVKd3pleGNmcGlIYklTeloz?=
 =?utf-8?B?UHIzTllNK1ZSWk5OZElNR3hWWDFnR3FiMXVxSnhWODJkVHlBWGlOZ0VSenNZ?=
 =?utf-8?Q?ET5ojCkAmBQK5bCRuj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bc27fb-da3f-4e71-9d60-08dede8517cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:13:54.7936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czwg4sGW9eieXt00htZeISYkiGz2P1W6MAUzhBbXZQCuKJRUFJzPhtN6YFnr/ZTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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



On 7/10/26 15:11, Alex Deucher wrote:
> On Fri, Jul 10, 2026 at 5:54 AM Zhu Lingshan <lingshan.zhu@amd.com> wrote:
>>
>> amdgpu_bo_create_reserved() only allocates a new BO when
>> *bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
>> NULL, it simply skips creation when *bo_ptr is non-NULL.
>> But it unconditionally reserves, pins, gart allocates
>> and maps the BO afterwards.
>>
>> When the same non-NULL BO pointer is passed in again,
>> for example firmware buffers that live in adev and are
>> re-loaded on every resume / cp_resume / start
>> under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
>> pin_count unconditionally, however the matching teardown only unpins
>> once, so pin_count never drops to zero, so TTM is not able
>> to move, swap or evict a BO, causing BO leaks.
>>
>> This commit fixes this issue by only pinning the bo
>> once at creation, and repeated calls no longer
>> take additional pin references.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4dd7c712b8c3..7ac3b8fd963a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -276,10 +276,12 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>>                 goto error_free;
>>         }
>>
>> -       r = amdgpu_bo_pin(*bo_ptr, domain);
>> -       if (r) {
>> -               dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
>> -               goto error_unreserve;
>> +       if (free) {
>> +               r = amdgpu_bo_pin(*bo_ptr, domain);
>> +               if (r) {
>> +                       dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
>> +                       goto error_unreserve;
>> +               }
>>         }
>>
>>         r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
>> @@ -302,7 +304,8 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>>         return 0;
>>
>>  error_unpin:
>> -       amdgpu_bo_unpin(*bo_ptr);
>> +       if (free)
>> +               amdgpu_bo_unpin(*bo_ptr);
>>  error_unreserve:
>>         amdgpu_bo_unreserve(*bo_ptr);
>>
>> --
>> 2.55.0
>>

