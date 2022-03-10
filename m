Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838EEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 15:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E153410EA80;
	Thu, 10 Mar 2022 15:54:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D55D10EA80
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 15:54:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnvV02pETCnQM8OQPZfiIjIoDmuc7x4XzhbK4zPXf7vOERKe0gM88eBPzUjpHhC1TygbftdXpBoGdrF6mwWXFWERy6KO8UxtiVT1KJWeXiMMS4dcS3B/HVuPpK+485Q931ic/G9UrAhYhzSCnUGAmgw8lwBBCMktiuM462fQCwwcjhxa3qTvUIV1JFjlLAPYk5LF6olPKpy0BN9W1v9FtGFZgjHwgbif3I5pR09+WIf1/cJW+Eki2+VXItBkKuXu7kD50BCSCJcV9QCUeQa4CEaZ3aXdvP4v5fOXBNzZMgplHPut1FvEwFxnGAGqxAmkUQYZywsr2g80GYPIGjYjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk8C0rsF2ktV1IfcETWYi4uLkumO/WIuDZcrl7ahIHU=;
 b=HKoxV7N6TSaPzrGpv7aWBF1jaW1vsrJAHwlYOCXDJgLcU+GetDPnJyDf58/mcjD8Hpdo/qxA7z5xxBPfPapRFqf6XUX0fOt85JOEykdxaxhrkOygjL2lMJJjvA0TdL+baFD46snfdPmkMVtZftIbZZ0dB4AY0pq0df+fXy787sfarXyF4xSXu1AziqFCXni3Be+aQO96aBuTQ0QwjRAXVNo8xEtTsIb9RUuMyVZEd+3es5S7M/Z/JWSF8yMbZAQPwG6SOwZPtatyRGIOZ0e3fMjCI0tjyw3Bn9U3zpywuqemEREz+yePNsq2vPLU5uj4e6HtC3ud/5iJDSVivei3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk8C0rsF2ktV1IfcETWYi4uLkumO/WIuDZcrl7ahIHU=;
 b=ih2oBnXhHMb4Dm/Ty2WBsrrecGPcxyLlwSqwmeF8MNh3bzK5lDKg3LwKcOXn7lqrBqEhIhM6r8ZBO534uOy4ZgoLgV2z5OvsO7voYn8vKq0NmjIqn5NEopN9vkHZU0AnQ9Glf5KQocLusa2h7dIIKgt3xddvF+RzNau0ccBHWrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1475.namprd12.prod.outlook.com (2603:10b6:405:4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 15:54:08 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 15:54:08 +0000
Message-ID: <c604be04-f27f-64ba-659a-a8aabcb310be@amd.com>
Date: Thu, 10 Mar 2022 21:23:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/4] drm/amdgpu: add sdma v5_2 soft reset
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
 <20220310061155.39292-4-Victor.Zhao@amd.com>
 <deb521dc-9c77-1fb2-18b4-c62a640b052c@gmail.com>
 <95893e7b-c648-bcc7-707a-3cff22598985@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <95893e7b-c648-bcc7-707a-3cff22598985@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fba826b-faca-4bfb-e930-08da02ae35be
X-MS-TrafficTypeDiagnostic: BN6PR12MB1475:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14752871B58BD47FFD2A1968970B9@BN6PR12MB1475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ0ZobmNFqlNiCmKUbdxtz2GlcaYtAHjGBTveALkh/VMWazaSyu9158gVxAMgc40EE1atgtbMIy7Ibz3vBgqpkdb5H2/UkMSiTd6bhe8gmqV/5MxZFtr0JyKhfDfHFb8o/LY8Ymi+ccW/88ym5BFslKj3HYt19CMOeGqRwM1jmLRg3obLi3riYx6CbjnBSy2SEx5A3AKdl7Vrwf/m1YZbDFWivYVGkv+Tlw112puC5RjHphMDnwhLasPw5Q+XRzgo4SwGrOBcyaRgzxXRi6mtH57U80abv327sQHDgXIwivuMv55viqAXBdND40o6lCruJARkMenesLrqp2EHoICPgEv3voaJgPo6lftv1NnONvEuBAZ38gauCKHujQEriMN/KzU+2Zk2bk53RjZGv+bqKSJQEjUsOpKiQ6BixvD67UmRhYKEtEH1xTrNTrpNDSWtX8QcnGuQVPN64R7zy9Gxz/HxEcr9dC46JzqjL8P98Zauy6ZZysFv3YHRntIr8sqBzg/BYGtp7n7f9H2YRdf3pDTHhkovFk16rZssY3Pd++ejoAi2d1qokmUGsBFhRbJCTfsfktQj3g2VCFgKVzOw+uibER2bYGwewEvy8m5DX7DBqPNyu9d9PB5yeefsKPEAIGqV4rYaTbbCVuWDXViFsGuoXVnRvumUa1gsso1YooXLfzGY8hZkCocn/q66o00jecp+Ow5PLQo/DO8V2Mj6qra3jL/PBSLNP97xpstJ/+kJePy/nH60iA9kMm+MlTL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(6512007)(86362001)(508600001)(6666004)(8936002)(8676002)(4326008)(66476007)(66946007)(186003)(26005)(66556008)(31686004)(66574015)(2616005)(83380400001)(6506007)(53546011)(38100700002)(316002)(110136005)(36756003)(31696002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVN3K05PRU5TY0dDM0xsbWYzWk1RYlpRSHA3bDdQb2oxKy9zak1udDhlZE5L?=
 =?utf-8?B?R2lYdU1lR0JxbGo3UzJNN0h1dHRkdGt3K1NYRkpPSGk1b3RUOXZDWjc2RVVW?=
 =?utf-8?B?NlJCdkNkbERSMkwwV01wYjlXTmM1YTFxSmxaaFZNWGVBSW8xeEd2NUZMVDJl?=
 =?utf-8?B?eTBOWDAzc3ZKdi9iODMzVjFqNWpDdGNPL09wbGFlWkVwU21hU2VmaUVlZXZM?=
 =?utf-8?B?Sy8velhOMVBmOWRGWDcxb0MyOW5RM2wzeFowc1pCTGlxL3pHbUsxMmt3a1Yz?=
 =?utf-8?B?d2xsNEs2dTJwYzZGRjFmM1g4RlNLREpJSlhBUTVOeGJtRkQzSWdWcERObzJJ?=
 =?utf-8?B?aFJBT0ZXWHgwVFA1RGRiV29MWWFYZDdSZ0kxZVZndy9qRmdiSG1XdHArK1dW?=
 =?utf-8?B?aDY1ZWpWV1Y4eURZUzJoMzdsdnlKNWV0R1A0ZnZYT0FSVlJYYU9OQ1JQcnZr?=
 =?utf-8?B?NFVMODNvUmtYL1NOcUMrSE1ldTlEZUplQUZUS2c4SUp1SE9DSm9vaUJBK2Vp?=
 =?utf-8?B?cGZxeGkzcExLYmpWQVlwNDQ4eFVZc0hySFo3clVMOTFaRE9meTM4bFgwSGJp?=
 =?utf-8?B?cVhYaEZDOStVb254QzRraUJxbTE3NFA4Q1R6cFRoT2RKMjRoK1BPWnZWRVJj?=
 =?utf-8?B?NUNWMXVDTExDNjc5SElzRjQyd295UlMxZG51YVBYK3FaNGo4U3NQM0JmRFFp?=
 =?utf-8?B?bXdtc1VtNzZkdjUyNURrTlRMOG9ycE96ZHF3K0o5RHRFclJHSXRYYmhzeU9Z?=
 =?utf-8?B?N1RRWDlXOFhPUXErWGlsSGdURnNtc2JLRnJyeUQ1MGprV3VsblN6R2JIU0N0?=
 =?utf-8?B?YWc3cEVLUEJMeHFQVEd2Y29oeEpxdFZUL1pUcUJYSWpQQlpOSFpYNmswT0pp?=
 =?utf-8?B?SGp3a0RRWWxmRkhwVFJKK0hJV29QWHR1Yzl0RFVucjRvV0FodFF2KzM4QTAz?=
 =?utf-8?B?ZXFRR3BSVXZtRDkxRmIxYmd1cTIzY3dRZm45MzZHdVhmQjl0WjE5R3EzSFZh?=
 =?utf-8?B?ZlpaOWV5KzQ2dlhsbHllUGYyd0xFaHN0UjVPeElFVkh4VWxiOHhzNW83V3Fa?=
 =?utf-8?B?WStxWTFUU3ZVOFlaS3JSNlIzcU9MTVdOaS9UQkhMa3YrSmE5RFNkUmF4dWRt?=
 =?utf-8?B?UHArZ1JoK0F0ZWV2ZmZNRTZaMjdVbFhveDBIdU1pMlp4T0h5OUpyQVdzeTZ2?=
 =?utf-8?B?aEprTFZoYng1OHFVcEY0eUVyZ09zNHN3dWlWWFp1Y244OFpEbHdYUXc2dHhy?=
 =?utf-8?B?eG9HaVhiNnF6dWw5Y0hXTk1ZL1c4MjZuemwyekdWRDJLWHZQRVpxeXlsWTM1?=
 =?utf-8?B?SU9IWkhXc1VKNmtHNytXUnkxT1lHb3JOeUU2Uytlc2pVUUgyRndIUk9yNnhU?=
 =?utf-8?B?VGU4dE5FV081aFVNb1RGL1RXSlBBZFpNWENmZnphRjUxOFpqUFUyVUtGZzIy?=
 =?utf-8?B?VnRSdXVDTCswZ3F4SUlNNWdWcWljU2htV2sxUDBRYjVWdWJmYkdZM0l4bS9w?=
 =?utf-8?B?U2tRV3JXK3REb3UvZEtOVExIelM1VFJJZ1pOeGpmL0dtK0J2WEFFV3lZQXVx?=
 =?utf-8?B?UnlEcnN2WlNlWFArakd0YWJXOCtSVXdwOXJ6Nlk3OUFXRXpWbllaN3B3RVRL?=
 =?utf-8?B?ejR0aEMycThmbURFenEwRWRCeFFybUdWUjhMNUZ6S3djeG9ld25YaWMxQWh0?=
 =?utf-8?B?RGcwVStiWUVYZ2tCc01TbzhzM1Myd0YvV3pOR3JDbHpUUkJDb1hqY28wRmVh?=
 =?utf-8?B?NllUZmNCS0k4TTZjTFBlK0tKT2pmcmZ5azVzek10QzAzaFNtdCt1VFBRLzV0?=
 =?utf-8?B?UnJUTFlscndybjhMNEtSWlJZbzJKNjIrZmYxZlJNTXFibkdDNmNlMXNBR2Zv?=
 =?utf-8?B?TG1YV05pVkYwSnB0WCtjU242eWxhMGFtdHM2eHFhdEFRbFdDangvRUVvMmVP?=
 =?utf-8?B?YVJiZllMTWVJODJMamFYZGZUZ0I2OGtZZWZzMTJwYnMwWTFvckFkTFI4Yk05?=
 =?utf-8?B?Z1hYU1RrOHBXOXh0WXlzWmROTmpCMDhXSHBlVUkyQThvK1EwSElsZjR3L2th?=
 =?utf-8?B?dVFIUWdTQVd3dWhXRmowb1kybWduRlB5SFVCc0dEMVZxSHZRRmQxRDVMZDFW?=
 =?utf-8?Q?95To=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fba826b-faca-4bfb-e930-08da02ae35be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:54:07.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+3rFsZR0qiM73q9LoKfx4i308tqu1AGkMYIOlq1/GaklWTrbEOxbgKZ7ll7R+wB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1475
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



On 3/10/2022 9:11 PM, Andrey Grodzovsky wrote:
> 
> On 2022-03-10 05:06, Christian König wrote:
>> Am 10.03.22 um 07:11 schrieb Victor Zhao:
>>> enable sdma v5_2 soft reset
>>>
>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 79 +++++++++++++++++++++++++-
>>>   1 file changed, 78 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> index 4d4d1aa51b8a..f9f978d8fe8a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>> @@ -806,6 +806,80 @@ static int sdma_v5_2_load_microcode(struct 
>>> amdgpu_device *adev)
>>>       return 0;
>>>   }
>>>   +static bool sdma_v5_2_check_soft_reset(void *handle, struct 
>>> amdgpu_job *job)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>> +    if (job) {
>>> +        if (!strncmp(job->base.sched->name, "sdma", 4))
>>
>> That's a really big NAK, please no string comparison in the kernel if 
>> it isn't absolutely necessary.
>>
>> Regards,
>> Christian.
> 
> 
> And even if you would rely on this then at least you have to define a 
> MACRO for  scheduler name and use it everywhere because
> tomorrow someone will change from 'sdma' to something else in scheduler 
> initialization and this code will break instantly.
> 
> Andrey

Maybe, check if any of the sdma rings is associated to the job scheduler?

Thanks,
Lijo

> 
> 
>>
>>> +            return true;
>>> +        else
>>> +            return false;
>>> +    } else {
>>> +        u32 tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
>>> +
>>> +        if (tmp == 0xffffffff)
>>> +            return false;
>>> +
>>> +        if (tmp & GRBM_STATUS2__SDMA_BUSY_MASK)
>>> +            return true;
>>> +        else
>>> +            return false;
>>> +    }
>>> +}
>>> +
>>> +static int sdma_v5_2_pre_soft_reset(void *handle)
>>> +{
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +    int i, j;
>>> +    uint32_t tmp, f32_cntl;
>>> +
>>> +    for (i = 0; i < adev->sdma.num_instances; i++)
>>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), 
>>> 0x10);
>>> +
>>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>>> +        for (j = 0; j < 10; j++) {
>>> +            tmp = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>>> mmSDMA0_FREEZE));
>>> +            DRM_DEBUG("SDMA%d_FREEZE=0x%x", i, tmp);
>>> +            if (tmp & SDMA0_FREEZE__FROZEN_MASK) {
>>> +                WREG32(sdma_v5_2_get_reg_offset(adev, i, 
>>> mmSDMA0_FREEZE), 0);
>>> +                break;
>>> +            } else {
>>> +                udelay(10);
>>> +            }
>>> +        }
>>> +        if (j == 10) {
>>> +            DRM_ERROR("SDMA%d_FREEZE frozen not set", i);
>>> +            return -1;
>>> +        }
>>> +    }
>>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>>> +        f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>>> mmSDMA0_F32_CNTL));
>>> +        f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
>>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), 
>>> f32_cntl);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int sdma_v5_2_post_soft_reset(void *handle)
>>> +{
>>> +    int i;
>>> +    uint32_t f32_cntl;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>> +    for (i = 0; i < adev->sdma.num_instances; i++) {
>>> +        f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, 
>>> mmSDMA0_F32_CNTL));
>>> +        f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
>>> +        WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), 
>>> f32_cntl);
>>> +    }
>>> +
>>> +    sdma_v5_2_gfx_resume(adev);
>>> +    udelay(10);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int sdma_v5_2_soft_reset(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> @@ -831,7 +905,7 @@ static int sdma_v5_2_soft_reset(void *handle)
>>>           WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
>>>           tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>>>   -        udelay(50);
>>> +        mdelay(2);
>>>       }
>>>         return 0;
>>> @@ -1655,6 +1729,9 @@ const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
>>>       .resume = sdma_v5_2_resume,
>>>       .is_idle = sdma_v5_2_is_idle,
>>>       .wait_for_idle = sdma_v5_2_wait_for_idle,
>>> +    .pre_soft_reset = sdma_v5_2_pre_soft_reset,
>>> +    .post_soft_reset = sdma_v5_2_post_soft_reset,
>>> +    .check_soft_reset = sdma_v5_2_check_soft_reset,
>>>       .soft_reset = sdma_v5_2_soft_reset,
>>>       .set_clockgating_state = sdma_v5_2_set_clockgating_state,
>>>       .set_powergating_state = sdma_v5_2_set_powergating_state,
>>
