Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7FAC43219
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 05:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459D410E440;
	Fri, 21 Oct 2022 05:11:11 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BA410E440
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 05:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPZxa2m6P0mOVzqF6NHjGK2wHoa+4zK3dtFvIaCUYlH6Ilj7cTpBkWm2VctzpjrgOQIx6WITM8FolsHM3qV4D0XZ+rk9pIzGFraqsh+3RWrCOyrX3MCtEZ/B+1qK6eiBdvymP4uFgsdXFlmf4WdlyaZ56klinHLS2rHqJhav3eTIed3sV+XebD8QH0/DazvCm816j8JWsFlOgyNZoPflM7UFx7ooSsj4TMFc9rzPAZ1oNK+0daSwqsFSVFgudTCsk0hdZebSSJPrT46oJLeCIW21BSmgXtQ4u15Hle5MmfdsNSEbQjjKS5xENkZU4aaHBSsqEQlFjCZmj0eVl9Regg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSnbon57vfyVVoQlO5w1beHKujnCrHu/76ZM8T+GIZ0=;
 b=NtKmf/OdltrDGSLgfSJwnKaM5FiAcT3dZQB0lv+qPPhFLHNOtVbJZn3Jqtp8gHW4CMw2a4vmGXJO7LdBvku8kdx4kFH7SGdVbPM+r/SF5PiOgqmJojchnNLB5gS74F0pKcHt4+iu3blG+QEs/nDgZ47a06dyqtaR+6gRoiuF2M4zEzRHEuUtNeSArmZL3kL5fwNv7bwuZvYm93MfI7hykSna6PTA0mqEBtBt7SXBeaYbTxjnGBDOyJrCL83tTHFaHQvJZEyxn6AcyhXvTh7T7WUJnvjPX+ASb8A2XjACgpoXntaHAOtks3f3WAt3bqcX8HVBVWWso/tEkCF3NLC/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSnbon57vfyVVoQlO5w1beHKujnCrHu/76ZM8T+GIZ0=;
 b=XFRD7EnKaZuNxCMN2mSkKOj8712uwKo1+2CE8n0+FONIrCMQgDLsEgPJURikEf+eP29LuTaxFx23ABYQyQqxGn1Omda5kPgWBTqBsQEjuYzgwXIM69Qdm+Bg2QosIem4aC9gMQrglHOqitQRR6lR/rH6BRqmYruHE7NYXMTbJek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 05:11:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7e91:f457:9ec5:33be%6]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 05:10:59 +0000
Message-ID: <016ec155-12da-5a2d-9395-6941e332833d@amd.com>
Date: Fri, 21 Oct 2022 01:10:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property
 asic
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221020091515.2758445-1-Prike.Liang@amd.com>
 <e92f2184-73bc-eb3c-d903-5a46c5c34ac0@amd.com>
 <DS7PR12MB600544275C2AB15530224DC5FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DS7PR12MB600544275C2AB15530224DC5FB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: a32b2561-c6a5-476c-03fa-08dab322a411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJEb3+K23C2wQGk7hUbJiveFFIi6vC1ctUhF2vAbwEzbKWoWn476gXcVj+yqrUjc0sDfcK7agDla6i6ncdyjFxA97FVS+WwzMy7h/rFBHznXARBYBu+i2eyoe/UEXhTzLzCH15OycePzMUtfyvKYzcmy6DtcNA8BPK7ogj1zrHrEQKausVDd2yMxWKoJ60WQlDi0Piw0HjkJHREle2VnXlRNLoA1APv86c57YRuWUIsqdVfSUkqG5I3XhuyOfhcJ6B5CoWEgWuGwvuxCCPygPDCb97dTTNPVjhaXDOO2loNkdhT6HUGLmCowCMr4bGsisvJVFiJtWNC2XQVfHkANu3S1ydLfv1fEJems7jIOfcSIwYZ3m4qPYhAOPSwBlFapIw47axbnWpa3QNgDd7WWrD1GuSzpxHGIL26qPg6U7n5VaGaE7/77t6W8LQVhfHSYWGay9VEbqoZvSUC6933aa2FDZ/cI36hoZruthHySv+BUx/DIFUQlJr+SDsrcNT3nosLNQ6ILt7dEYsnjOVQROS/BrtFWhO6g6fbUK2IsiAOECCDA2gd5LQpPlVjTdhRy7uFEpb8gp+GpsgGOF41kw6fuuvgAk4Ij6rdUu/HGO1O/rO84MI91ZC7W458lOQjXZl/N+nabn73zziUSDuhvuJVEAg3HiimOcmohpelTKM7KeIuvL2HDlBoQeAAMLn28MKADjSyEICa6iTmKO5S2mFZ1TUZV1F96QCLYCy/xye4NtISQpFCzrhkCBXORKyaDg24ZiUM5FGtOCZpXiABgY5CtFuthTumMVxpyYxwIxQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(4326008)(36756003)(110136005)(54906003)(316002)(6506007)(6666004)(66556008)(53546011)(8936002)(41300700001)(44832011)(5660300002)(38100700002)(66946007)(2616005)(8676002)(2906002)(4001150100001)(186003)(66476007)(31696002)(86362001)(83380400001)(478600001)(31686004)(26005)(6512007)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJQeTJaTzN3Qkh6aTY4OWh6eUkzaTlWUktUSC9oNTNBaDlBcWZFRmVuVkpj?=
 =?utf-8?B?eTZqeWZ1YmtMeGxqemJ2bTlCdVhLRm1vVEx6T0ZSOTlCcjlrM3VmaDlHd05E?=
 =?utf-8?B?bk9sbVJsa05HK3l6ZFhjS01aOFVXcGJPa21Ia2xuT2ZyN2ZaWkgzVEFvT2Zk?=
 =?utf-8?B?NTNVckJTN21xM2loSGxGd1ZGb214a21HdjFMalZWaVRoOFdzb2ZHQ2ZPUzBj?=
 =?utf-8?B?T1VCQW5Wb0c0SFQ3NFdpb3pma1BFdWpjdkxNeTNONjBLKzRLcmczaFhCRlk0?=
 =?utf-8?B?b0ZyVTF6Tjc1bEh5TDRZVnkxVnNxdFZvekJYc1dyY21qSTBHUnU3R1RZNnJL?=
 =?utf-8?B?UnNuVklzWGxRczFxRXpOa0pLZ1BwaXVRb0JwNVArZGpzb3AyQ20vZ3BGTENa?=
 =?utf-8?B?dHZ5V3BNZGlxYzZlNG5kVGNVOHlHQTRGQnhnS3lDWndPN3M4R1pFR2lxUUt4?=
 =?utf-8?B?UDJNNE1ZVXRYaUtJaFhBQTB2QnpSZDQyMG9YL0pyek0veHN3SFRBYU8zQ0xr?=
 =?utf-8?B?MENUeS9vcVl5bW9oRHdYNUZrUzBqTXBLZTFBOVhaNmd5dHlUNVlta095Vjlu?=
 =?utf-8?B?KzZWVUk5RmNQZ1hxcFUyeGRlQ2hNNGg0WVRhY2VKcVdkTXE5ZDRMUzNiditp?=
 =?utf-8?B?MGVKQTVIempCMWF2Vk1qaEJrUkcvLytWeXRjdnl5dDZ1eDRhWng3UnBDZUl0?=
 =?utf-8?B?YnE0T1hsMFF2aUttdmlwMnFFMkNmUFdGR0hlVFBqeSttOHh2aGhIbWpDdVNt?=
 =?utf-8?B?UVN0ZGh2MDc3SzFzMHkwTjFsczEzTjZ4YnZHdjcza25mOTl3ejNmeW16Z2l5?=
 =?utf-8?B?OVczNVNNMEtTT1dsMG45QjFEM2NxVHI5WGZWMmJkaGpnTWozcitmaGNYSkZ3?=
 =?utf-8?B?WDF2cjVyZ0ViMTVlZjZXSDdUR3FFVHppbzFiVkhTVlhRSmZZaGN6NFN3ZTdR?=
 =?utf-8?B?Q2VEZEtsZUNTazFyTVNIV2V0ZnkxQjA4dmNLYWZXK2swYkxwcVdTYmxHS3Ru?=
 =?utf-8?B?QythQ0VvRWI3L0s4NUZUMTF3aXdLRk9IUkhXTFA3dnpYWHg3Y256Z0dOVzZG?=
 =?utf-8?B?ZGsvMk1rSWFxYjFSS1VsMmpKYWZKT2UrUEJIT24vcVFHSFdkREtZd1hMREpK?=
 =?utf-8?B?ZG8vM2tibWhmUDdYY0VDLy9nSEhtWXJvOHU5S2dqdXpIVExKNUlFRmNmL0dp?=
 =?utf-8?B?Tm9WQ1ppUnVIVVh4V3VPS1cvUHVGc25rcm0yZ2VNY0l6RGo0K1VsOTkzR2F2?=
 =?utf-8?B?cjVPQUhLNXhJZTQrWVIxSTUrbUJpOWlKVjY1SGpYYVVaa1grTFJQUFJvK3p0?=
 =?utf-8?B?Vzg2WkVuNHlIOUxyelZRUTR5R3pQSDlHRTRibFJRaVdYcW9GYzJkMldVYVdI?=
 =?utf-8?B?aTBvZUZJZGQ2bUY1aUc2N2ZPMWRDM2VZS2wwdXBuc2NRbjVqbFlaWTlhZGlv?=
 =?utf-8?B?TlFTRTJHUjBtQWc1bkwwUk5kbVVCSjhuZHBjTGREdERFeGxMbEFwUWZCYkRL?=
 =?utf-8?B?SWQ3RUVkdGUzNDdPY08wL1ZnRnZRdWtDbXhUVGIvODBub2RNTm0rQlVyenlU?=
 =?utf-8?B?OEJreWR1THdiQzhuTUlGeis5RWJsSXFYYXdSc25DVE0wVXpqS0ZqeUNSZTlS?=
 =?utf-8?B?R2FoT3dUTCtxZTdkUUR1cm50a1V3OXE1SmhydVpiazV6WGFWQWIzbTYyajBN?=
 =?utf-8?B?Rk1udWtxeTJBNjY2dU9jNW1iWnNMUjhDYkY0Vnl0MUFQd0hWUXg1RWZib005?=
 =?utf-8?B?MTFMZXYydGsrR3lvbGo2eHBrVWQzWDZGQVJyK1lYUFBYc0o3MDlsY25EZFJo?=
 =?utf-8?B?YURVeW5Yc29pZ3dzMGl3YzR3QW02d3VVbHhtTFVXVHFibDBWaWJHRWcvNG5r?=
 =?utf-8?B?b05EK21uQmdXQ0tRQXFtQk5jTEZ6Z3dpaW5WVkJ2OG5xS0tPb0RpS0p6aktz?=
 =?utf-8?B?NE1EdTNJYlkzU0tHeTljMlVtQ2cyekJwNFdJdFV1Q3Jvblo5REtYMDJtOTd5?=
 =?utf-8?B?MUtHMUZWUTdpcTlDaDVIOTlucjZFWWs0THFzQVJ2Y1BCZjBLYUFkb2RDWUF2?=
 =?utf-8?B?Q0tBTksrTktEUDJ0cWtKR3g5QVlRM3Faa21LcWxkQ0lSYkNGeWV3d2MzZTRo?=
 =?utf-8?Q?wKkGxd+ruAEabRiji/7Onu3HN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32b2561-c6a5-476c-03fa-08dab322a411
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 05:10:59.0591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqFqDY/sk0IQr7cb5xDjRJTqS2R7oIgzCCPB6//eelUo4IV5/wqlPgxWYTvM0tgwoVOo0zH90S1U/ZnQc//zIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-10-20 um 21:50 schrieb Liang, Prike:
> [Public]
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, October 21, 2022 12:03 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdkfd: introduce dummy cache info for property asic
>
>
> Am 2022-10-20 um 05:15 schrieb Prike Liang:
>> This dummy cache info will enable kfd base function support.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 55 +++++++++++++++++++++++++--
>>    1 file changed, 52 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index cd5f8b219bf9..960046e43b7a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
>>        },
>>    };
>>
>> +static struct kfd_gpu_cache_info dummy_cache_info[] = {
>> +     {
>> +             /* TCP L1 Cache per CU */
>> +             .cache_size = 16,
>> +             .cache_level = 1,
>> +             .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +                             CRAT_CACHE_FLAGS_DATA_CACHE |
>> +                             CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +             .num_cu_shared = 1,
>> +     },
>> +     {
>> +             /* Scalar L1 Instruction Cache per SQC */
>> +             .cache_size = 32,
>> +             .cache_level = 1,
>> +             .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +                             CRAT_CACHE_FLAGS_INST_CACHE |
>> +                             CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +             .num_cu_shared = 2,
>> +     },
>> +     {
>> +             /* Scalar L1 Data Cache per SQC */
>> +             .cache_size = 16,
>> +             .cache_level = 1,
>> +             .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +                             CRAT_CACHE_FLAGS_DATA_CACHE |
>> +                             CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +             .num_cu_shared = 2,
>> +     },
>> +     {
>> +             /* GL1 Data Cache per SA */
>> +             .cache_size = 128,
>> +             .cache_level = 1,
>> +             .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +                             CRAT_CACHE_FLAGS_DATA_CACHE |
>> +                             CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +             .num_cu_shared = 6,
>> +     },
>> +     {
>> +             /* L2 Data Cache per GPU (Total Tex Cache) */
>> +             .cache_size = 2048,
>> +             .cache_level = 2,
>> +             .flags = (CRAT_CACHE_FLAGS_ENABLED |
>> +                             CRAT_CACHE_FLAGS_DATA_CACHE |
>> +                             CRAT_CACHE_FLAGS_SIMD_CACHE),
>> +             .num_cu_shared = 6,
>> +     },
>> +};
>> +
>>    static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,
>>                struct crat_subtype_computeunit *cu)
>>    {
>> @@ -1514,8 +1562,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>>                        num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
>>                        break;
>>                case IP_VERSION(10, 3, 3):
>> -             case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
>> -             case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
>>                        pcache_info = yellow_carp_cache_info;
>>                        num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
>>                        break;
>> @@ -1528,7 +1574,10 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>>                                kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
>>                        break;
>>                default:
>> -                     return -EINVAL;
>> +                     pcache_info = dummy_cache_info;
>> +                     num_of_cache_types = ARRAY_SIZE(dummy_cache_info);
>> +                     pr_warn("dummy cache info is used temporarily and real cache info need update later.\n");
>> +                     break;
> Could we make this return an error if the amdgpu.exp_hw_support module parameter is not set?
>
> Regards,
>     Felix
>
> [Prike] It's fine to protect this dummy info by checking the parameter amdgpu_exp_hw_support, but it may not friendly to end user by adding the parameter and some guys will still report KFD not enabled for this parameter setting problem. The original idea is the end user will not aware the dummy cache info and only alert the warning message to developer.

I thought the intention was to simplify bring-up but make sure that 
valid cache info is available by the time a chip goes into production. 
Therefore, normal end users should never need to set the 
amdgpu_exp_hw_support option. I think you're saying that we would go to 
production with dummy info. That seems like a bad idea to me.

Regards,
   Felix


>
>>                }
>>        }
>>
