Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AC8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DBE8922F;
	Tue, 10 May 2022 15:08:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B2E89182
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abF6IzcwO5LK1HqlRtriZSSiQc0Rgtj0bLixkcW9mu1Bt9Hs4xXkAG3cMIjm7JWz6cpYtx/4904XxCCvV/DpWt03t3sc0NJ0Gx/XZMko443qFn868Qj8XNsSpoXS3TGCGmRFi9obBN4eF0ppFoon4Zl+Y1mHsedUbt4Gw7DMZ4YyhBzI7Fs3+7byp0KODq8SokIf3OilRYyKpLoyCbyo2FFM5hnSMv9O4U81KtU2Ezr5ss6XW2r9pJqEisYgrkDfSpXhPMIbptzgvtvSx4Ywb6aQH4/5Z/HeW8gYK6ayDJdA2rpY7k8wmdDb0m9xlaG22999bB1LJfUxEBW6UYu0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8XGGRkBU7YkjFhd0A7+a5xbC1JKVvGzn5qNhZoDk/I=;
 b=XK0pzhE3FFnHOrwzrtJNdGjeoeB+VuVqFS933cqbWBzYvUHSv+C7N+h9Tu61hgSXJdZih32wsjzPykcBrROQ6FQRA/+BVO1cs2flccV/fq1qvpoBnqvpDOwqwX0X1c7T5CYzj0LiWA47Bbk/EHqqzYAKuc5UK+VH/EsGDmPd/MuCH3KAuBSWiJZhCkmDhSMkQU6Rj8UZx0xxM2veHZQS8KKgk9bXBz/o9m21a3FXcJ7xp/S+i2L9OjwJoQBcbxVW+mxoNb+xvHnLlQd/ikUTNgPfTRDflFXdGC+BA65PP8M/LwAfqTL3gSy+sL0nXaaDbiQ+k2O+/gZKUftHYLjQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8XGGRkBU7YkjFhd0A7+a5xbC1JKVvGzn5qNhZoDk/I=;
 b=Wk6K6IxufBNuUD0yD+eUQnGXaDWDT+vAsn7Xh3C5mvmWbECOaqODl9eAqiVkgFkjoAuJvOYfAV1uR/6tS7tCaCYdohtx3gn09VM84vN8fo/0nZxDHN9jcH86mzYMZ+SL1KsDePHjjsJ2TXCvCmSzIGHGKxqK///rT9Y6ny/H8gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 15:08:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:08:45 +0000
Message-ID: <3ccd38e7-2877-2b75-940b-0c41102084dd@amd.com>
Date: Tue, 10 May 2022 17:08:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <CADnq5_OkTfJO0KWRpfeoTZpXxU5Doi4Uw0xaHGVLxRVgdCKT2g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OkTfJO0KWRpfeoTZpXxU5Doi4Uw0xaHGVLxRVgdCKT2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 598e2e9a-e0e3-4e84-dd23-08da3296fa25
X-MS-TrafficTypeDiagnostic: DM5PR12MB2406:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2406D4DE47DDD8445E9FD30E83C99@DM5PR12MB2406.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsvReFG6TfihGcF+XPyrWGw/e/eO2t2t/fliFOSBAcletO/U1DdTW1GKa5GMMUDqnZZt6WGKuhT6zx95h0t5dQyM2H06rVe7qI/SCVQwy8F9d6CbwW2pc93+85uy5YaBugcqvBk/AwnwkmD6I7V33XIkSrmtv0Sig6mQlHprnCDp0UpjJCdNKY0A7GF/DnLSIL8OHNFdURVWyWHP7XOUXGlVGYo5quMoQP3E8fWWCG/eW1nxDa2HlgqzRtQymZHJcEe2YXnW1Aylw5OBKu2B1xAlFVnWwkkLZU+nkvrzNu9FVr8Omwtf0Zsa7Y27bDX7g8BOT0xkTjoUMNy6v4GRpugY2pl7WJ9OqLhJejIBCQ/XkiPgHPyX0qi+TPRHtGSYsRnGNlFoDrJIi/ztIDEqEQ9bxR1sSqbGdqgvCtU2MzzMLA1z/0opvDblSRfpS56GV5cYKy82TVJRFhZ0IuI+dy4f2CbJgBUeSkLCpjHQfeUMeYODmoSdDymn9LK3rKJ43v3NSA9BJ+4fYwpkB5Vi8d2/quZSjjvdy5BKodMqglqv3ruw24F3ONeL/UkPe6vRmkM3mu6cQqRfoEyODhU8MvSaqKA9VS9NF1yH3SsLhaLnrep2cXrkNcir6m/KOWw6Md/k0r9NWfrXL2RXG4OSfRRtWV9ld3/lqomlHkvTn2ztSdQVcVbxEHzX1Ztdx1aTWe+EDV4ucuAAEOUa2T8mBY5eaDgDusYiUdBZ+CFmb1gNm+amlf/TejGBsv7XdybU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(2616005)(53546011)(8936002)(36756003)(86362001)(38100700002)(110136005)(54906003)(66476007)(316002)(6506007)(66556008)(66946007)(8676002)(4326008)(31696002)(2906002)(508600001)(31686004)(83380400001)(6486002)(5660300002)(6512007)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRNOHdqZEpnZG5VUDdFajVIZDRXeWlHaUpxVEpPdCtkZTZWMHZCYm52QlVv?=
 =?utf-8?B?SVZ6dEw0cUNSMm5XUVROVS8yUmMram14enJHU3hIVXI3cms1ckFWeWxQSHY1?=
 =?utf-8?B?ZE45OUVONllaQjFCUlJPNVZMNEZ3bmNnMzNRVThncjNGeG05TE1Xd3N1QmZt?=
 =?utf-8?B?WjFOcG8xN1V1STlMQmI0NzF1em5kOXhjYnlsZ1RxZ1h5Umx2dk11RGpXMGxx?=
 =?utf-8?B?dUFJdUxoWUtjVENpbGM3MFRMZ2ozL2xIS0RKSGZGdXNabGFNR0ZVZ0xiNkhQ?=
 =?utf-8?B?UmtiOXc4a2xwMXVrN2JWblVWVTh2QUhwS2xwTnNTZllQb0VJQ28rRzdzWWRv?=
 =?utf-8?B?S0EvOGVGTmdZaENqeThjR0UwaVg3U0JJTEhSMjFuWTZMRm52K3FWVHNDd1Nv?=
 =?utf-8?B?YWdXdVIxQVpPbkxtWGtoUmhXWTFvQmhSaHQwNVk4b2JMbi85QmU0My9qQUVL?=
 =?utf-8?B?eWt5M2ZsMmZwekFzVUVFZ2cxeFhDbDRqZk04WWVxTXZlVGtIRWtOaVJ2TE43?=
 =?utf-8?B?V1FJa1NXUjRBRERNL01XMFoza2c0b29Day9OU04zRVhIMGJYVHhjOENJM00z?=
 =?utf-8?B?UjVpbHJ3bWFnbUUwR2d4eW4xK3NJamNyaUU1cnpqRkhkbUVrdXkrSkhIZy9m?=
 =?utf-8?B?aFpLZFd6RmFHcUJ2K2Q2OVJ5SHdZTXFnVjV5S1ZITVcycFhvSWE2VUV0OU1D?=
 =?utf-8?B?cmlCcWpZeWFpT2d0QnorTFIycUNLcmY2UWtvRUQxYmFMVmd5VEdsMXZXZ1da?=
 =?utf-8?B?S2tFM3JCWTdNZXRIa09TRS80YW90S2M5dE5ab0ZHajVBU2ZUOFV2UWgwekJP?=
 =?utf-8?B?RHo0TkJoaUJMNE9BQVkzNlFLTUhPUHI1ZkU4UURtU3dVM0RTeS9PS3phTHlp?=
 =?utf-8?B?dVJBVmdsa1lWK29ERlIwWFVQVGJJL0JuSDdsZjJpV3MwdEN2WnVzSXFjR0hT?=
 =?utf-8?B?dG9XcHJBYTk5aktvQXFMMkl6U2YzLzNjTjZla0o4bHBaQkZPWk9pUkN0aGM0?=
 =?utf-8?B?UHV0dlhSSFV3bnRsa0FqamNzZVdSMG4reVRMdzJOaXRHNzdSazkyRENSYVIz?=
 =?utf-8?B?cFRoQ01TQ0tETlgzNEdHTXdpL01xMDU5OW9oNm9ON3cvc2hRMTB0b282T0t3?=
 =?utf-8?B?dStZdGVZK1RxL0lUSTRKeHdFK3o2UXUxQVh5djVQZjh3djdHZDZFbjNvMEkz?=
 =?utf-8?B?WStReWVRdDFCMG9OcTN6alA3K3pDaEw2OEJhdFZZRjVSUHdyYnpIU3hobkZp?=
 =?utf-8?B?OGthN085MVMxQlpWTGFLMlVGQTdYK2lZdnQzb1ZidzBDUnI4alpBdDU1b0FC?=
 =?utf-8?B?ajVvQWpJWGUzU2RxK1JaejgxM1B3RHRwZTU0QTRKQXFpUTJ1U1krT1pXRWI0?=
 =?utf-8?B?bGgxOFZBUmRuMTFvTW0rZ094Qm1takVmNG5YazBMWEZwUEl5dmZ0NVAvbWQv?=
 =?utf-8?B?azNJdjROTFRxbHBNTW9nbkxyYW1CVnZlbzk0bGVOQk0vOWN2VjdWNUE0MjI2?=
 =?utf-8?B?bnBXU240ZzBjOHJWbnhMbksxVGxWM0w4ejdrOXhiU3pSQ1NBYjNoK3dkbU82?=
 =?utf-8?B?dlNRcU1ZOWVqQlBmdjdBajBnRk5USmFvTE4vSHkvQURFNGg2WU5oRWRibzdL?=
 =?utf-8?B?UkhTQlRvcXB3bjRKVkJDSWVwK0RpRjRkeEZmZmxEMTA3S3luU0ZmZlNrMlp1?=
 =?utf-8?B?M2l3dW9ULzhPRjhFbml3M1JrT29jODFGV1FTVEpYQ2ZHdGc4SzJXbXMybm9z?=
 =?utf-8?B?dk9zOG8rQ1A1UjA1VHFDNkNMV3gyaDRyM2E0cExHbVB1NXg4bEFDNzlvWWdI?=
 =?utf-8?B?R1BWVUtQcUd2eFQwVHJ1ZFpTcUk1THdoWUp6MnplRFpsMzM3UzVGYnl6Z29E?=
 =?utf-8?B?S3RnbXpuTVFqbTlDdHJFaHdmSXhSUzNxVGFadXV1M2YwSHZ3VHFIeUduTTdj?=
 =?utf-8?B?eEhOc3ZGeS94WEFJZHpRWGVBRGpoWlJTSTY2QU5NZkhlM1p6Q1VhWDF2REZT?=
 =?utf-8?B?ZUExdlk2Q1pOclpRWFJXVStpUVhXakFoZjlydDF5dTBOMVVPbGJ4Sk5xWHhT?=
 =?utf-8?B?anFyTk9KR0tzMmFrbTZ0NUtQZWVpVkJ6QWxBT29kUm05ckIrVWNEZWcyK0x6?=
 =?utf-8?B?eWVYNmZQS3N4eU9acWtqMExkMklHK3dCSkU5RjY5QTArZlpOOFQ3TVNIekxT?=
 =?utf-8?B?U1FHNjNweUNtTFpKbVBVQmZ2TUVDRkVndTJ5eUs0Mkl3OXBha0VSd0FRWEFW?=
 =?utf-8?B?b0lJSVdBYjNSY2VIVjQ2ZkViZnR2TGQ5THBrMHRxZzVYZXBETnY4WER2RXc0?=
 =?utf-8?B?UFo0YUxCOWNKS3FrME5QK2VKczZFVDNFaUx0Q1hLeHdPZTRzbm5tQk1ZTk05?=
 =?utf-8?Q?c7M7EZRNKeWKibK3Xjh3jlr5xNI2oJwcDkMFCM1SEqXim?=
X-MS-Exchange-AntiSpam-MessageData-1: ltKE35fO+5i2fQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598e2e9a-e0e3-4e84-dd23-08da3296fa25
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:08:45.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lw1m/eeudVxQmY91j1ovNb1XSFI51Xw7SXs5RmIozIB0wCya55eYJK45clDtGMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <arunpravin.paneerselvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.05.22 um 16:42 schrieb Alex Deucher:
> On Tue, May 10, 2022 at 7:36 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> We still need to calculate a virtual start address for the resource to
>> aid checking of it is visible or not.
> Does this fix a known issue or is it just something you noticed?

Just something I've noticed. Judging from the bug reports we get large 
BAR systems are so common by now that only a few people are left where 
that actually matters.

Christian.

>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 49e4092f447f..51d9d3a4456c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>>                          list_splice_tail(trim_list, &vres->blocks);
>>          }
>>
>> -       list_for_each_entry(block, &vres->blocks, link)
>> -               vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +       vres->base.start = 0;
>> +       list_for_each_entry(block, &vres->blocks, link) {
>> +               unsigned long start;
>>
>> -       block = amdgpu_vram_mgr_first_block(&vres->blocks);
>> -       if (!block) {
>> -               r = -EINVAL;
>> -               goto error_fini;
>> -       }
>> +               start = amdgpu_vram_mgr_block_start(block) +
>> +                       amdgpu_vram_mgr_block_size(block);
>> +               start >>= PAGE_SHIFT;
>>
>> -       vres->base.start = amdgpu_vram_mgr_block_start(block) >> PAGE_SHIFT;
>> +               if (start > vres->base.num_pages)
>> +                       start -= vres->base.num_pages;
>> +               else
>> +                       start = 0;
>> +               vres->base.start = max(vres->base.start, start);
>> +
>> +               vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +       }
>>
>>          if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>>                  vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;
>> --
>> 2.25.1
>>

