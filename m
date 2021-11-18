Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1764C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9305E61AEC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 04:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9305E61AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346F86E8D8;
	Thu, 18 Nov 2021 04:04:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E596E8A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 04:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHHTqhjsdEGQof8D5/wTl4L2GJKGPMsp4QSaW3kQ3raxV2vpdx3R2ZZwmPa2W3T5m14K5doLSoFz8A77RpgDXYujk1P1U84cn8QK42I9UstZicKEbJvK7zLSLXFGMkSq8RJqhkY7ObuJtP4MxKbwxOj+FvgbXEcN5lqcHzqhw4ltHdeRwfKPMWMDWDLpslZfnYV1RTOj+wmQC9QfSMQIoviYPxT+uDuchZMHiCEjjCyD7lD/i3Ww4okcjk+7mRwOEgbJQPlfDqVdNg+IhcBoE9pA9qROXwijA29lQBN9qUTKBgr5YFRGRFeyHvHEHt7tjoKZ5qIBN1TekaKrW1A6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQHFnfGGjea1hVyBa7G7JC9qiG3hpDQqoxJ6Ar0VXOA=;
 b=FTvMG4BoprerdlgidFcpoBKDctrC60tlP5BHGpMP2MXFIojgHMZoUvSzQWEHrVk9KOO2jSxiaaMSq0NBSA2+2T0dtpbkmaFihT9fPWnCOpbiZhr/mlNVnSxEeyjoLhbtgvYC28gf7uNVQ4/UGi2rb9n2EVZ0MW4uXEcpuLge6aRgeCnIWm1O7A9XLHYIBSW40wP2qg780Cs2m2llrZxlQOcpcUUoVvyX7CuSs5K829oLnleej2uBsQuNonL2E9szpwn8nA0TeuwPTuJ5skTgM7WhT3pc08lXAMFmEJKmPaW8k5yDk9Y7/qkofV901xjGwVN0IxGJH1IxntEiiK4MiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQHFnfGGjea1hVyBa7G7JC9qiG3hpDQqoxJ6Ar0VXOA=;
 b=4Ty+SBS4LOj869EdDBzP8ZKTUKTvCWzY6BFWuSRydPtmSe2K2VutqgjhuY/ND2rDdbfkT715h2Ns5qaW4SRO4JdA49sGWI0CV5+4FY3FehITUuUzTxy7GBRohT/54CuDZw+N/an6mklvQorRP0csdUZpqJSHMFBvlH//3WiyMAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 04:04:37 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 04:04:37 +0000
Message-ID: <ff20f817-8dcc-16e3-d57b-e2add9eb3a66@amd.com>
Date: Thu, 18 Nov 2021 09:34:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIFJldmlldyAzLzRdIGRybS9hbWRncHU6?=
 =?UTF-8?Q?_add_message_smu_to_get_ecc=5ftable?=
Content-Language: en-US
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
References: <20211117101132.6568-1-Stanley.Yang@amd.com>
 <20211117101132.6568-3-Stanley.Yang@amd.com>
 <daa32ce8-5afd-a9db-fbd3-f9bb874622f3@amd.com>
 <BL1PR12MB5334BC1E31CA36947E74621D9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5334BC1E31CA36947E74621D9A9B9@BL1PR12MB5334.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 04:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ef1b9f-be7b-4c46-91bd-08d9aa48893b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12444B9830AD65EAFDBECAF8979B9@DM5PR12MB1244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lu0mqvnJSbecj+nN2kRpjdLVSqf9T8Yb/Xq1tj3DlV0XR3y6HJRatLXccf6q7/yFq0ObCKmK4ezLqSKH8h9otBxRJOh9rJXswGGnY37/MVPLYQDon+W4hfa9VfXjOlvLMxyVTYi+2QhAcOf425DrvXGibogAjkwQSzj4vEf3VFmJUeEaURzGatIMJLu4GZeyNqCR+bmB/4VMYuJUo2UYoUZ2U4mgG7HDmOTYnaJ2snTzd92YjKOu+U81EiI0xrb7HcHTF9b27kcoAhT4w2qKj94pdvpjfn2HxaQoK58rniRySGLT8mN/Oiv0am42VFIOsYfvPBWIHcyXTjVbTaKr/w59bszyVM6LOHSfpDo7D8Ucrh0Mbkd1GOeff2tj4ksvT+8iQuu/l+trq8MumRfVd++ybWUoQIQ7MMZsEh9rQGRB3NQ9Dpg/lDMKmON98FrlgdawjXVzIqQAA9fVpLt/+3FUoL2s/efqgzvdFjJEs0I3q9mvYWHBQUEb2fNxYsds10yOtE7qLwdydBcZ94QSnABQRrzwN/yLZ6W/vu4Y8TCfgiPHyEn4eJ5ApwScn160s7tAYrZdMvbz/IJmTeHtYv0ng3L6K3ljWaAYA+sQBA2z6SZvqZuD3mPqNYIYGqbxCQyfWr2W6/v77SdLcBBB2Y/HYF9NtJ16koMjGtkLip4sVWobEq2k1PZQIQiJ5dJF0uvIm/zmurGRuzjLAhgowTfN+k0XoMqCg5RrmY0AyQbGHC1i8Mel5H94JWXBvar/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(53546011)(6636002)(86362001)(66946007)(316002)(508600001)(83380400001)(6666004)(110136005)(2616005)(8936002)(16576012)(31696002)(186003)(36756003)(66556008)(224303003)(921005)(2906002)(66476007)(6486002)(31686004)(26005)(956004)(5660300002)(15650500001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STJtenVlemwzRDFvSUM4bm9lckF1YkFDUzdBcmJEa0Myb1J2TG9ROTIzNGp4?=
 =?utf-8?B?ZDFxem4wQ3BZQXIyUHA5aURQRGpMQzhhekdoT0pXclY4NW9ub1NEN2xKZ1Az?=
 =?utf-8?B?ZGdNU2wvOXVWKzdSbkl6aC9QeldaVDJTdGZ6SHZHTFFZaVUrRHVDS1ZQU2kz?=
 =?utf-8?B?MHQxTTRudGJ4eUZLS3ZzVmZXRVdacUpGY2xGK3RWTFQxZ0EvYURiTnNDTjZI?=
 =?utf-8?B?MkVtMWh3TzQrejR1THhWSlpTNWZmQ0xIRkpLVHo3RXlFNW5tbW1GdWh4TmJY?=
 =?utf-8?B?Y29IZDQwUUlzVjM2Q1Aza2lQdHlCVCtxTjd0NW5TN3d2aXVock5FdGY5V3hj?=
 =?utf-8?B?Vk1Rakl5OWlRZkM4aVJzL2pocE14OExkcWVOdVNXQnp4eUNFdlVDR2MvWjJs?=
 =?utf-8?B?R2RISTBGL2pNbWw3NmVZMUhBRHN0cUxJTy92TFdST29GY3o1c3ZISkpJbml1?=
 =?utf-8?B?T0FFcXRpbEdjTllSOGtzc011SFRaY2hYMHM2OHZUaFVvanU1RDNpU0U2S21Q?=
 =?utf-8?B?OVptT3hzamRtMW8yOGVhY0l2VmFpV013Y2l5N1RDWXFEOVNVSTlVZG05WXkx?=
 =?utf-8?B?dDZRejVOU0RiTUcrWGlKc0c0N1BCcTM2d1RMdFVuRU95bXlMN3BYTzdqZVd3?=
 =?utf-8?B?QzZFR1ZlR01oSTVnQ2xUMFhQeHRGeVRpSW5iekdYekZqemVYUjBBSTJlUDNk?=
 =?utf-8?B?amo0bFZxTUtLbmk1NFdZby81Ti9ZMHFoY2RqMmJFQ3pjQjVqNUhtbjlUYVBL?=
 =?utf-8?B?aG1GdS8xeW13bzJ6b3hQQ1AzOWRCSVpYWE1oeTRYUThSandJV000UmVmSUVF?=
 =?utf-8?B?Qy9kdWJhK3hmb3NRNlpnb041V0g5a3BzamQ3eUZVZi9LU3UwaVFid0wxQUdD?=
 =?utf-8?B?aDFRMDkzQzl2K1JpNEZIdlNKVHdLZUx2SnFwRE1RT3dxamc2UFJVVjRWandu?=
 =?utf-8?B?UU1hdmFBazdrc0NUeDhvaU9UWWUrS2cwSVZHTHFnWWw4SnFxUWF4b1ZYelc2?=
 =?utf-8?B?NFpFT1JaaGh2Z3ZMUVJ6dVN6ZWVrck9HbmhLMUF3RnNSNkh6QXlJdHluZFRu?=
 =?utf-8?B?VEhZQU5leW1vSkN5bThoaGdFS0JwUjNyL05JeGtqNXB6U05xck41KzJUVHVi?=
 =?utf-8?B?djkxTHJpMTd6M2NOeXluY2h6VkJrZ0xkUktGTGRsQmFpTjRJZzNyVVVEd3Nx?=
 =?utf-8?B?Q3J0MWwxTkF6OGtmMnJlZ01rbTF2ZWEvS1d1d0FOVUxra2p5ajBja09zUVQ1?=
 =?utf-8?B?VlB6bFNJMHpMQUc1d2I1WmNhUnZTcXdtdDJsQjkremR1M295YndOQXh0RG9N?=
 =?utf-8?B?bjhPRWd5cS93ZGMrcU9KZ0poQklySmx4aWE2elB0REpOWG41Vk1zemFqdVZB?=
 =?utf-8?B?eDZyMFE0d0RISzR1d3FMZG5ia3lOaEk0OWxic2s4OHBPalluTXdaaFJ3V2hT?=
 =?utf-8?B?eG1RNlYveHNwY1pCRFFYZFBFd2NiaUFZTktIdEV5SmFtZzNNanVkcWNUcHBX?=
 =?utf-8?B?cnJzb2t1c2ZtcmhvRmxYT0hKSmkzeVpVZi9SYUpBTlNIenNpYUxPQnd6Y3Ni?=
 =?utf-8?B?dU9vMkU1WTQxdUxhQTJXT2VUcUdtVS9BbVBUMlJBdFlPM2RiVDcwZ2dHaC9D?=
 =?utf-8?B?OEV3RGw1UTZ5TFMvV3psQ1NwRTNmRjBxaDRpZXh6TEhYV3NObmM5VXZZaUpJ?=
 =?utf-8?B?c2FpUCtEbnBlUEZReDUxalFiS1d0VjdicS9kK3F2TVU2VlFQMUNoOE9odlk1?=
 =?utf-8?B?T3Via2s0MUE5OUtDN1RDeHp2ZnJiNURGQjdZKzlnN3dEeGM3YzNBeTZlVDZW?=
 =?utf-8?B?VXdPaFcrZnZCOTFyYU1SV1pwWUhtaEV6aG1DOGhrYm1xTlJMc00vY0NVZFR0?=
 =?utf-8?B?OTBiQVoyS3M1UW5xSFB5ekczVmRTS0czK3NGYmZoaVdsL0FUWk9mNlo1SjdN?=
 =?utf-8?B?aythUGoyZlRITTB5TkhUUko2YkUrMEl2UDF4R3MyVDliRHJzYjRxcHVuN2NO?=
 =?utf-8?B?S3BpeEowc1gySEo3dWIvQThCK2xMQm5rSGJPaTVrNE5lUGxheUlyamFPWmgy?=
 =?utf-8?B?L0tpQ09melNmWElSUStIQjdsZkkvQUlqdDkya0ZNMjRrMEFwS2NCamc0d2JC?=
 =?utf-8?Q?edjw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ef1b9f-be7b-4c46-91bd-08d9aa48893b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 04:04:37.0633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBnySu3P42TLJFNA+G7pwzvane3XRcHRDW8ycRUWw2HN2dydiqOtjipah9SNQUmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
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



On 11/18/2021 9:07 AM, Yang, Stanley wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----邮件原件-----
>> 发件人: Lazar, Lijo <Lijo.Lazar@amd.com>
>> 发送时间: Wednesday, November 17, 2021 7:24 PM
>> 收件人: Yang, Stanley <Stanley.Yang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Clements, John <John.Clements@amd.com>; Quan, Evan
>> <Evan.Quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
>> 主题: Re: [PATCH Review 3/4] drm/amdgpu: add message smu to get
>> ecc_table
>>
>>
>>
>> On 11/17/2021 3:41 PM, Stanley.Yang wrote:
>>> support ECC TABLE message, this table include unc ras error count and
>>> error address
>>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  7 ++++
>>>    .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 38
>> +++++++++++++++++++
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 24 ++++++++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
>>>    5 files changed, 74 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index 3557f4e7fc30..ea65de0160c3 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -324,6 +324,7 @@ enum smu_table_id
>>>    	SMU_TABLE_OVERDRIVE,
>>>    	SMU_TABLE_I2C_COMMANDS,
>>>    	SMU_TABLE_PACE,
>>> +	SMU_TABLE_ECCINFO,
>>>    	SMU_TABLE_COUNT,
>>>    };
>>>
>>> @@ -340,6 +341,7 @@ struct smu_table_context
>>>    	void				*max_sustainable_clocks;
>>>    	struct smu_bios_boot_up_values	boot_values;
>>>    	void                            *driver_pptable;
>>> +	void                            *ecc_table;
>>>    	struct smu_table		tables[SMU_TABLE_COUNT];
>>>    	/*
>>>    	 * The driver table is just a staging buffer for @@ -1261,6
>>> +1263,11 @@ struct pptable_funcs {
>>>    	 *
>> 		of SMUBUS table.
>>>    	 */
>>>    	int (*send_hbm_bad_pages_num)(struct smu_context *smu,
>> uint32_t
>>> size);
>>> +
>>> +	/**
>>> +	 * @get_ecc_table:  message SMU to get ECC INFO table.
>>> +	 */
>>> +	ssize_t (*get_ecc_info)(struct smu_context *smu, void *table);
>>>    };
>>>
>>>    typedef enum {
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index f835d86cc2f5..5e4ba0e14a91 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -190,6 +190,7 @@ static const struct cmn2asic_mapping
>> aldebaran_table_map[SMU_TABLE_COUNT] = {
>>>    	TAB_MAP(SMU_METRICS),
>>>    	TAB_MAP(DRIVER_SMU_CONFIG),
>>>    	TAB_MAP(I2C_COMMANDS),
>>> +	TAB_MAP(ECCINFO),
>>>    };
>>>
>>>    static const uint8_t aldebaran_throttler_map[] = { @@ -223,6 +224,9
>>> @@ static int aldebaran_tables_init(struct smu_context *smu)
>>>    	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS,
>> sizeof(SwI2cRequest_t),
>>>    		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>>
>>> +	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO,
>> sizeof(EccInfoTable_t),
>>> +		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>>> +
>>>    	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t),
>> GFP_KERNEL);
>>>    	if (!smu_table->metrics_table)
>>>    		return -ENOMEM;
>>> @@ -235,6 +239,10 @@ static int aldebaran_tables_init(struct smu_context
>> *smu)
>>>    		return -ENOMEM;
>>>    	}
>>>
>>> +	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size,
>> GFP_KERNEL);
>>> +	if (!smu_table->ecc_table)
>>> +		return -ENOMEM;
>>> +
>>>    	return 0;
>>>    }
>>>
>>> @@ -1765,6 +1773,35 @@ static ssize_t aldebaran_get_gpu_metrics(struct
>> smu_context *smu,
>>>    	return sizeof(struct gpu_metrics_v1_3);
>>>    }
>>>
>>> +static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
>>> +					 void *table)
>>> +{
>>> +	struct smu_table_context *smu_table = &smu->smu_table;
>>> +	EccInfoTable_t ecc_table;
>>> +	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
>>> +	int i, ret = 0;
>>> +	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
>>> +
>>> +	ret = smu_cmn_get_ecc_info_table(smu,
>>> +					&ecc_table);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	for (i = 0; i < ALDEBARAN_UMC_CHANNEL_NUM; i++) {
>>> +		ecc_info_per_channel = &(eccinfo->ecc[i]);
>>> +		ecc_info_per_channel->ce_count_lo_chip =
>>> +			ecc_table.EccInfo[i].ce_count_lo_chip;
>>> +		ecc_info_per_channel->ce_count_hi_chip =
>>> +			ecc_table.EccInfo[i].ce_count_hi_chip;
>>> +		ecc_info_per_channel->mca_umc_status =
>>> +			ecc_table.EccInfo[i].mca_umc_status;
>>> +		ecc_info_per_channel->mca_umc_addr =
>>> +			ecc_table.EccInfo[i].mca_umc_addr;
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static int aldebaran_mode1_reset(struct smu_context *smu)
>>>    {
>>>    	u32 smu_version, fatal_err, param;
>>> @@ -1967,6 +2004,7 @@ static const struct pptable_funcs
>> aldebaran_ppt_funcs = {
>>>    	.i2c_init = aldebaran_i2c_control_init,
>>>    	.i2c_fini = aldebaran_i2c_control_fini,
>>>    	.send_hbm_bad_pages_num =
>> aldebaran_smu_send_hbm_bad_page_num,
>>> +	.get_ecc_info = aldebaran_get_ecc_info,
>>>    };
>>>
>>>    void aldebaran_set_ppt_funcs(struct smu_context *smu) diff --git
>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 4d96099a9bb1..55421ea622fb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -428,8 +428,10 @@ int smu_v13_0_fini_smc_tables(struct
>> smu_context *smu)
>>>    	kfree(smu_table->hardcode_pptable);
>>>    	smu_table->hardcode_pptable = NULL;
>>>
>>> +	kfree(smu_table->ecc_table);
>>>    	kfree(smu_table->metrics_table);
>>>    	kfree(smu_table->watermarks_table);
>>> +	smu_table->ecc_table = NULL;
>>>    	smu_table->metrics_table = NULL;
>>>    	smu_table->watermarks_table = NULL;
>>>    	smu_table->metrics_time = 0;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> index 843d2cbfc71d..e229c9b09d80 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>> @@ -983,6 +983,30 @@ int smu_cmn_get_metrics_table(struct
>> smu_context *smu,
>>>    	return ret;
>>>    }
>>>
>>> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
>>> +				     void *ecc_table)
>>> +{
>>> +	struct smu_table_context *smu_table= &smu->smu_table;
>>> +	uint32_t table_size =
>>> +		smu_table->tables[SMU_TABLE_ECCINFO].size;
>>> +	int ret = 0;
>>> +
>>> +	ret = smu_cmn_update_table(smu,
>>> +			       SMU_TABLE_ECCINFO,
>>> +			       0,
>>> +			       smu_table->ecc_table,
>>> +			       false);
>>> +	if (ret) {
>>> +		dev_info(smu->adev->dev, "Failed to export SMU ecc
>> table!\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	if (ecc_table)
>>> +		memcpy(ecc_table, smu_table->ecc_table, table_size);
>>
>> This copy to another buffer is redundant. You may use ecc_table directly in
>> the callback, then this method itself looks unnecessary. Instead of calling
>> smu_cmn_get_ecc_info_table(), call smu_cmn_update_table() and copy
>> directly from ecc_table.
> [Yang, Stanley] This design consider to protect ecc_table in further if multi-thread call smu_cmn_get_ecc_info_table same time, it should add mutex lock just like metrics table handle if it is necessary, but now test case is simple I didn't do that.
This is not like a metrics table use case. RAS error harvesting is not a 
multithread case. The error registers are cleared after reading, so I 
thought it's always expected to be one user at a time. Besides, I don't 
know if there is a case where driver needs to report errors from 
multiple threads.

Thanks,
Lijo
> 
>>
>> Thanks,
>> Lijo
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t
>> crev)
>>>    {
>>>    	struct metrics_table_header *header = (struct metrics_table_header
>>> *)table; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> index beea03810bca..0adc5451373b 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>> @@ -105,6 +105,9 @@ int smu_cmn_get_metrics_table(struct
>> smu_context *smu,
>>>    			      void *metrics_table,
>>>    			      bool bypass_cache);
>>>
>>> +int smu_cmn_get_ecc_info_table(struct smu_context *smu,
>>> +			      void *table);
>>> +
>>>    void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev,
>>> uint8_t crev);
>>>
>>>    int smu_cmn_set_mp1_state(struct smu_context *smu,
>>>
