Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9CEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D286A10EA39;
	Thu, 10 Mar 2022 15:41:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778AE10EA32
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 15:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3lrwCyDeu3dH5E8+HuShpxCvCF/7U5UsmQxnFv6nbMeFpEeKLYz/Q6nyaUMr5y3/wbozJblRL2/GO1gXlSZ2SgfSgRqs6yCzHhsyILnY3qsJeUepcmMxRHaKJTI9KcMjP+7AEdJyDxDC20x8oGY91OxFCql11TTCeb2b0PVG3BZBn2Twab72D5eYnf5FAk438G6zkf8uQw5aX6bbiuUgrkK7dZ5tDpk+gF1m4BAunQgkYBAXobtfOkQKUPsZ2A2F8WOUtuKynMm21K1oPusSvC1nfZ01TcwQutf14Tjuv4IK7G3lO+47QUbbpjSKfbrpP1IjO/235HbumGSejvMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3heSCnyqYIifCArWH/8TKP7ExF4folR59tB8ys57bc=;
 b=CLOGhyQSa+Sf6YYYekOmyb1RfFqBf1QmJG3xupQqAA2PxbQ44zacC3TrXuGNy3mgXXUnV1nHU3sbUIOP4j2sWisWvimuMy+2CbuV2UUi++iDJh5M2oIszGkL2ihlnEKRD3gUV/3+NoF/y8L7puFsxw4rX3ogfVaWEjMtRb76CuwwN0zgMDvm2Q1JBzhg/nV7E9g3qnJNXeQIhK3HANNzeKfuxn3oYndmI6XBaDU5kFa/RETJv7oxZ83H0gFcZFzFHQm4lTdJrnIiXofs0HfqwxfxqqSj1DIAAjcWy4eVbMYW7BUNXx4y8hHzx5xZh1pzSSr7mLqHHwxqesuPE72hpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3heSCnyqYIifCArWH/8TKP7ExF4folR59tB8ys57bc=;
 b=zrB54KO8PXHrMOTlDRbGJ5Ju8QSWxqfg/JV/rOaI1HI4wT+jRm043X6201SurbYe/nhaELpL4DMN4RX+vk5B3yH+VNe6uO0S33EPoC5fphO1Fdiskoc7OcDmXkkz0hezzLtXoO1she2XOQTTHMrCyQGOr25J04ZeSNx53YfB2eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 15:41:27 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 15:41:27 +0000
Message-ID: <95893e7b-c648-bcc7-707a-3cff22598985@amd.com>
Date: Thu, 10 Mar 2022 10:41:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] drm/amdgpu: add sdma v5_2 soft reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
 <20220310061155.39292-4-Victor.Zhao@amd.com>
 <deb521dc-9c77-1fb2-18b4-c62a640b052c@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <deb521dc-9c77-1fb2-18b4-c62a640b052c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:610:4c::12) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f844a209-5f49-4353-cf4f-08da02ac70c9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3054:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30542AF68A0E2E78F48C6DD0EA0B9@MN2PR12MB3054.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJAqTikd24VVwNVMtJn1BFC1l/HVLZa30SxHuZiByBbyreOlRhJyxDRukdv9SuX6oqSYnsujtrmcMTidg2BfKasnt1NmiVwSW0zsscfpWDnwnmtp3QlSf/z0R+N+CjrucXqYQy+YK0xcTo2hoxtiYLCoMdPuozQnZn1U+vBeWDM0qyL0v/OxD1wj0m/VPLGQFlOD8cxcZt9ZY+ODAGJFY5PvBN7+O/maDPkvCXTezDz4N+ZT0XWxpyOyx2/L5n+KKzgOGWN0piHKXry0P8bj04cL3+8qnEAr56VrztpQoJUcnOlUW2NkEacEZ2ssfD+FiKThWCBdH5Le1Y3k0+doYA70eM1+E6jseYj3i5EcJPQyJZCAJ3j/rn73B+mQX5cRvHjZYHLiS9z/gSJue1y/Now0Yef4YKImuvtDv6KnNm2TbCFXjv+naexrh/ReRIKE5VG8YdZ8DjwSpCm++O4AWrkl6Bq5V2w27tCK88lFV5aWe1v+9cIXAXpu2s5hSgAQQ22Lq6U0Lt50FEF4Qi/aHT7sSMMdfFk3qotWbybxTH4oLMhSG6XQD0Lzk8obFBey3w3UnrFVyLz57Vn2cQA9+NLYA6PRKFC1pJ4hB9HTAHXYWyS/FcXVDDGdN4GVCAZpFkgU4VW4nw9VdvYsWT0B4EZvc9Q2KMos/hKsvkWAGjkMZeOeeb2KlgP+Iih06VEo1cEb+uX+SSKgVZ7RWPV8L2u7rKdlrivTNgAYwhdCEwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6506007)(6512007)(316002)(31686004)(38100700002)(83380400001)(186003)(36756003)(66556008)(66476007)(8676002)(110136005)(6486002)(4326008)(66946007)(31696002)(86362001)(2906002)(2616005)(44832011)(5660300002)(8936002)(508600001)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpYWDl6aWtJTDBDajh2RWNRZ21WQmZvZVA4Z2lrdGJKallSMjVTUk1jWk13?=
 =?utf-8?B?RHdyTEpSR2RZdEZFQkpJOTVhSzl6OVRDOTBYeVJERk9ET04wUVM1d01kOHRB?=
 =?utf-8?B?c3FWTlZhVUVEUDFCaGVzVWx5ZS95WUtjWXg5T214a0dEVm9pVTlUN2Y4TTk3?=
 =?utf-8?B?NTFxZ290TTUyQWZ2RHVERFBabjMxS0pLcndJcHN3QUhLZG1jRkhhTUtsKzlZ?=
 =?utf-8?B?U1p0Q3AzNExXSTQ5bk92NllQSTRRY2NtWlhTQzBiNlk3RE5MbndqSFZ1L2ZK?=
 =?utf-8?B?VytsaWxjdEFVbFZiakdnQnZGcmxZNWowbHZtak1KMzhOSnhxcDBPc3UxRjZH?=
 =?utf-8?B?VXUzWVpMa0VKSDRPWTRjRU55aXhXS0dWRlhXenllOEJUNkhTakRKVnBxSENH?=
 =?utf-8?B?SlJPOWxIZVZWNEUzVE9oblFjdk9GV3BMd2MxQmEvaHZSRldaanNJOFQzdW4r?=
 =?utf-8?B?dFBiN2FxZmNhOFJuMk1OazJoUTVHVmc1TW0velg3M3lhNzgzTzQ4eElZUEtk?=
 =?utf-8?B?em1xLzlpMGswckJZNTZnd2ZVZVVlb3B1R1dlVWNHMkE3bGtWVE1NdHB3U3FI?=
 =?utf-8?B?VFpEMDUxQTRyU29mVDZJQVJFeFY1ZDY3Z0Z6RDd1aHZCN1o0cjU4T3QrUlVT?=
 =?utf-8?B?Vkd1cUJ1eFZZSGlFQmNXZG1HcnYyL2tySXhVV080eEZiaVFsWXg1TURVZ3Zk?=
 =?utf-8?B?aUYzVE1Ha0VHREVUelNXTDU3cUl4MmtUamE1d0RFUFRXOWhLOFZDVVNLZjQ0?=
 =?utf-8?B?UHFGbzY3VVVySzFwRlBaKy8zSy93elpqTzFXY1dZbXB5dkJhTitwWWc4Q1E4?=
 =?utf-8?B?RVRIZWpnbkJxbWZjRjY0T1hzVkhCOGtsTTdiYXNGYzFGQlh4dnRYb1U0MkVh?=
 =?utf-8?B?UXorSm14bm1LbEhSaTUyVnBxc3ZuNlBoMkFmU2lidjhJb2tETUhrSmxVK3hT?=
 =?utf-8?B?UXdWUVAwQWo4SE12U0xrbnZ3eEVmMkx1ajloZGVxZHVnTHZSeHl1RUdkWVZ4?=
 =?utf-8?B?SmFPOEladlk2S2V1b0Eybi9ySGJwamhZYUN5dFozSmRCbytrOFRIZGg1c0xz?=
 =?utf-8?B?V0VwVzFSSHNLTlpqNGFnSmpxazcvdTFESk1SbkFxT3lvRmpaaHdJbU9sUS9H?=
 =?utf-8?B?ak9sMmQzNlRYTUJmalQ3VGJLQnRqYThGTVh0T1pRUzJhT1pHTnNVNTdobFJ3?=
 =?utf-8?B?QVYrcmdFcHdwVWt0aVk4VmVtNnQzSEZpaTUvWWlUeWpray9uQ1YyVjF3MGM2?=
 =?utf-8?B?REdKY2lEOC8rc3RFZlRqMzFpREdRbzE2YlNFUkRhejQ2NnVielRIMTNPSXpS?=
 =?utf-8?B?YUc1b3kxZTlEOWJXc1pFZFZPUjI4aHdHWnBkdXU3YXp3R2ZVQklBMEMxSFNs?=
 =?utf-8?B?RktVUnFhaUVDT1doR0QyQ2xxR1lLTDlOUVhkeXc5M3BJVThoVHE1ZE9vRjVV?=
 =?utf-8?B?Z1VMMXI0VHhkbTZnZVQ0d0l3RjJDaDNSVXY5eWdtMHU2cjhCdkhNTlFWeGpO?=
 =?utf-8?B?VUgxTjZIOWVNcDBDaTlYOXlLQlNpZ3JicTFGVnQreEtyVy9uaUN6d3FJV0Rl?=
 =?utf-8?B?ZXZKUm0xdGFDVXQxSTE3NGhLNnl1Z3gvbkpOOGpGSndzSkFmTjFmL2lncjRj?=
 =?utf-8?B?eDlqbExHMDFYNm5CRUtXZ2NGdjlVL2xQNzdOaHJZVGNMNnorTzRkaTZzY01O?=
 =?utf-8?B?dTdYWk9qNHFmQklFRzNIbTYvUVJFUFJYanRWQXgrMTJEdnhqOXkvaFBTTXc1?=
 =?utf-8?B?UjAzZHJzNXNJTEs4aHh6TlBtc1I4d0NIdjFHazIvL2ZDNlVyaWpuZStPeWlM?=
 =?utf-8?B?bTh0V29MQTVWYTBmeXF3V3VVSk1rME9UUDZaTi8xL05lL2FLQ0FlM0hyOUFV?=
 =?utf-8?B?QWhHbjVlV3RBYmNySFlXV1ZVZG1FVEdHYjJESFNaQ1hVdWZiZXY1UGVtd2JB?=
 =?utf-8?B?dEFBUmxzSEtqMGVRN3A1QTZ0bFFEV3ZqdWkyUmVQVnVIalZnVEozY3A1RXl1?=
 =?utf-8?B?dGR2YXBSeHZFUG5WT2dIdzY3ajZDNFEwSTU5ZWZrV2pQaXZXeVNCUE0xQkhB?=
 =?utf-8?B?YWZOTUdQNGQ5WG5sWlFhS2pOYk1jUTVjb2kvVFg1OVFHaTZhNnlNYTdmRVpG?=
 =?utf-8?B?NVNQSTBlN1VGc2E3bU8yTUx5TVFwQ1l6bVp2WHNKdGR2TktDM2RmZW9PYVVF?=
 =?utf-8?B?S3NJeHpTeUFWNTNVU3NHTUE2VndvakJzNUE1RFBkUXBmVHpZcmVsRUtIU1BW?=
 =?utf-8?Q?cczkH9Fq/UGmD6P58IMqy6ll8hEOMhUdEkwr7zi77s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f844a209-5f49-4353-cf4f-08da02ac70c9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:41:27.8125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlEj+fs0kgrqcc1NWCi7eHJAWcIyEkzIkIYyVvksoT8CvR7CDwNvBNGpq/+oMCzC7GZrlhFaGZfAX0lJm60lhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3054
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-10 05:06, Christian König wrote:
> Am 10.03.22 um 07:11 schrieb Victor Zhao:
>> enable sdma v5_2 soft reset
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 79 +++++++++++++++++++++++++-
>>   1 file changed, 78 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index 4d4d1aa51b8a..f9f978d8fe8a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -806,6 +806,80 @@ static int sdma_v5_2_load_microcode(struct 
>> amdgpu_device *adev)
>>       return 0;
>>   }
>>   +static bool sdma_v5_2_check_soft_reset(void *handle, struct 
>> amdgpu_job *job)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>> +    if (job) {
>> +        if (!strncmp(job->base.sched->name, "sdma", 4))
>
> That's a really big NAK, please no string comparison in the kernel if 
> it isn't absolutely necessary.
>
> Regards,
> Christian.


And even if you would rely on this then at least you have to define a 
MACRO for  scheduler name and use it everywhere because
tomorrow someone will change from 'sdma' to something else in scheduler 
initialization and this code will break instantly.

Andrey


>
>> +            return true;
>> +        else
>> +            return false;
>> +    } else {
>> +        u32 tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
>> +
>> +        if (tmp == 0xffffffff)
>> +            return false;
>> +
>> +        if (tmp & GRBM_STATUS2__SDMA_BUSY_MASK)
>> +            return true;
>> +        else
>> +            return false;
>> +    }
>> +}
>> +
>> +static int sdma_v5_2_pre_soft_reset(void *handle)
>> +{
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +    int i, j;
>> +    uint32_t tmp, f32_cntl;
>> +
>> +    for (i = 0; i < adev->sdma.num_instances; i++)
>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 
>> 0x10);
>> +
>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>> +        for (j = 0; j < 10; j++) {
>> +            tmp = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>> mmSDMA0_FREEZE));
>> +            DRM_DEBUG("SDMA%d_FREEZE=0x%x", i, tmp);
>> +            if (tmp & SDMA0_FREEZE__FROZEN_MASK) {
>> +                WREG32(sdma_v5_2_get_reg_offset(adev, i, 
>> mmSDMA0_FREEZE), 0);
>> +                break;
>> +            } else {
>> +                udelay(10);
>> +            }
>> +        }
>> +        if (j == 10) {
>> +            DRM_ERROR("SDMA%d_FREEZE frozen not set", i);
>> +            return -1;
>> +        }
>> +    }
>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>> +        f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>> mmSDMA0_F32_CNTL));
>> +        f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), 
>> f32_cntl);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int sdma_v5_2_post_soft_reset(void *handle)
>> +{
>> +    int i;
>> +    uint32_t f32_cntl;
>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +
>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>> +        f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>> mmSDMA0_F32_CNTL));
>> +        f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), 
>> f32_cntl);
>> +    }
>> +
>> +    sdma_v5_2_gfx_resume(adev);
>> +    udelay(10);
>> +
>> +    return 0;
>> +}
>> +
>>   static int sdma_v5_2_soft_reset(void *handle)
>>   {
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -831,7 +905,7 @@ static int sdma_v5_2_soft_reset(void *handle)
>>           WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
>>           tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>>   -        udelay(50);
>> +        mdelay(2);
>>       }
>>         return 0;
>> @@ -1655,6 +1729,9 @@ const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
>>       .resume = sdma_v5_2_resume,
>>       .is_idle = sdma_v5_2_is_idle,
>>       .wait_for_idle = sdma_v5_2_wait_for_idle,
>> +    .pre_soft_reset = sdma_v5_2_pre_soft_reset,
>> +    .post_soft_reset = sdma_v5_2_post_soft_reset,
>> +    .check_soft_reset = sdma_v5_2_check_soft_reset,
>>       .soft_reset = sdma_v5_2_soft_reset,
>>       .set_clockgating_state = sdma_v5_2_set_clockgating_state,
>>       .set_powergating_state = sdma_v5_2_set_powergating_state,
>
