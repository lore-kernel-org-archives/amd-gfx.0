Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB57C04A95
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 11:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5710E1FF;
	Tue, 25 Oct 2022 11:37:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6601710E1FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 11:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XX/r5E9ZTutI/RjBRYb8D65ldinY2Sn7xBInDcz2ZsTtiMDaf7sRfmzm+/H6+Eisvtv2BrEKm84bFsGe5C4izfsfAlrkB0u8XSjvmLfcKPRRvjMBMzYIkjmBb3Rl7Cn7b8G27yHXtxvpbSM95+kDkJYcTSXT664qDXitkvGDIa30DQNJscXJfItrPgqW8eOIuup+qjtEt6WMqBP5pywyiaC+0+eaMs1jm1KRh438157J9yBL4qlbFrVJ9nry8xB495LUOKzUY9Hnl0Q9mzPIiwK3DJTlGcdIR4SNs1Y29K61Mpz+orokmibIi/+T6M17GUhbnWGzgihImOZa63uZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJfbYnqplZwBQLcwEVZebPQTt+zxdo0f+iCxMjyzBQY=;
 b=NknXaK953PaqqNypfwGu/yOFV37XZb+0GrXKolmi9Ja+j8cZB5Wc+JdGfjAMGw81I5lXIdun9pSER2gQ63qZoESH8nL1ns93XTG8Cd4GWCRXOgubzB2OrT74UXIyz2+z5M9ypjbmMeCc+ggkhlTtuHyG4NbCnLAhH/RU/sQRYQiovl7bR7ZEg/TrHQz8KB45ft6sm2M3otRkBoIB3w1uFfT/O5Fp83i2e6xDNwujo/6LlRZBGf7Sv6af6BFaoqhbOMdJZJd+Rqe1z0vDf6XH5x7rt45jwLWXSINVKmWBugMnrR9Tqi4fKBP4PXOgomcRE1CuENEP3CSayUwnpJNOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJfbYnqplZwBQLcwEVZebPQTt+zxdo0f+iCxMjyzBQY=;
 b=N48wxBZ6g9JYSyrZqQH/m6H6SutOqLj548fkI21NDa8lSWN+fWybnSAWOB2m6lnYtCL+XapmJ7Psatj59tCYx4L6n0skJhtjIkgM7y5r8xYp+Lxe5uNmiWY7KnfC6ThH0YDukYgodCGAuxnpCIKk1hTlDSPVdrczaO0wgM/8dLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 11:37:33 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%5]) with mapi id 15.20.5746.027; Tue, 25 Oct 2022
 11:37:33 +0000
Message-ID: <e632053d-392e-133d-4530-f032c8ec2ef5@amd.com>
Date: Tue, 25 Oct 2022 19:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: "Ma, Jun" <majun@amd.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: Init the base cu processor id
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221024112639.3440664-1-Jun.Ma2@amd.com>
 <0090fb7a-209d-11ce-e16b-35dab826b4f7@amd.com>
Content-Language: en-US
In-Reply-To: <0090fb7a-209d-11ce-e16b-35dab826b4f7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::11) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c355e1b-b3b8-4efd-1847-08dab67d4ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2O/eESQdvVsxI2Q2VaFfduTWq2BBulc9h+wkSyd5uQuYz7//MXRa0xVcKyO8dPubo5Nl7bdchbJdiklSNsXSyBTHqAkHBY3obQDKzQjphrdm1CnlycylFU0cX34SA+uOkVsnXWR8PBNfxGklrKOnXIKI0Un0yhJuDLohRXJwx2a4gW6EkcztKp+rGBkA8kHR8K4DMXFFKnOwZc8rt+NU62TuGt7cP/EkcHePF/tKS29AS3RW++oVWGAOlkWclfuRfv9mcmcN4VN1F1eHYERKenjLnmaVucQQmMoCnLPD0LCL6yEVhhoedgfPkqkwxaogRS6b/RlKtZCQKFOzpVcIGIRcfHhatGSVAcovx0SpyZzM+l3jMzhbmjCTs611ed1aIH2Sz7PxaY3p3GhHqq8qz/CEhBb05h1RsMvr5QFRZsFPxh+HEBBep8OEpmeW+2dJcIE63JpwFaeCMgTC8uBD3IqI9jHjQFibQlPDxBXGFJctsIp7bcIxoEi42VIEYOrPCWHKTOH3qIutk0BrUpsF5z3dUCRfB06rIj0JlCqqQOUUUqsM4h+l0DI58UxtI4BbpmVkH3MKRxrYQxSAJe654tTn+O5WJ1YI4HbJjicibo/lhjpBGSp/EfhsjDR9QnBO2ayOqBMSjy48NfmqW3CO6+AnA2gSOS4u27XxdQq33aasBFQ0Bi2NKRTWuzOH8BSyuC/wBNoNyvqIk70M8dEiGoRTemnkz/BJiChlPJMZiAmdxPBnad8Rg3ANqaRdF2mZ3TReM6rUwbpBrnuklrgF1MwkEgKUrqrPqHTnxhNykBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(6506007)(6636002)(66476007)(110136005)(8936002)(316002)(66556008)(66946007)(6512007)(5660300002)(4326008)(8676002)(6666004)(41300700001)(26005)(53546011)(38100700002)(186003)(2906002)(2616005)(36756003)(4001150100001)(478600001)(6486002)(83380400001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NzVXYyVUVrajQwUFhWZlRYa2RjLzJ6ZHBsQjdvS0tpOUl4TThONEhRamdk?=
 =?utf-8?B?elN4Ty8wL2RrRHBrSEJhc0JYK1p5MTFvWGl5Z2orb2wrSnVoN3hHcHRjN2ll?=
 =?utf-8?B?VkgwQ3Q4TE5xNDB1dUdNbEdEaE5ZaWdITHlEOVEvcEJudVRWc1NnSWsyOEJG?=
 =?utf-8?B?T3NScDl0RkZSWjhIanJQQlBkcFBTOUd5cDVYNmR0UEVldXIwcW02Wk80YnEz?=
 =?utf-8?B?UVQzUytkVVVTUXBGcDlYYmRiVCsweDM1WGpHV0YvRndabkluSnRSKzcrUHVk?=
 =?utf-8?B?ZWYreWVZQTJRVmFsdnFXejJqOXUrc1NTU2Y3V052VFBwaFltN25aa2w2M1hI?=
 =?utf-8?B?d2c0THQ2a05TT3YwU3JCZUhjT0phVVdrS1NoQ05uVHNRM2doT216bDVZVHBi?=
 =?utf-8?B?bEtsa3pIU1hmZE5wUkFEMjdUV3MvZWRMM1FhNVRDY1JrY0JRUlk4bU9XdXhM?=
 =?utf-8?B?c0RTdmVjVW5kZGxVWVVFN0FFZFZaMU1nZHpBZGtNanQvQStDMHAzejUvSm9y?=
 =?utf-8?B?dWpDZVV1ZitYSFBpcEFxVjgzRjR1SzBYcnp2Nmc0cW1ENG5FcG1HOFBMVGNo?=
 =?utf-8?B?S28xaEtlSUU1ZXBCSGNmeWYyMTdUSUxPb1Nua0JUclRLelpiV1pNbWlHOXdH?=
 =?utf-8?B?QzlPSG9iZXZoYWVhS0FuYktPT00xLzFCRFozWlAxdi9kaWtNL3JoZk9SaDJo?=
 =?utf-8?B?QnEwVVpPblNWN1dxNlA0TXYwZ1FUem5nTEpCaWhXZDlVTDYwREF5YlFWdENh?=
 =?utf-8?B?N0VrVkpPQjFkbjBnVldNbGVwNldYYnpPc2pnSk9RZVZaZThWTEg1NnJVd0xo?=
 =?utf-8?B?V0ZvbTZXc3ZSSkh4TXFBT3FYNks2NDJUclE0b0cyeUh2UnBwQThDNWFFaENp?=
 =?utf-8?B?K3ZiZUlQZ0pJYlpSWlB6MDg2RUErY09ST3BwdmhmM1A0Q0hPY1BWNWpYNUc5?=
 =?utf-8?B?NGpMbDZTZWdOQThkcXJ5SytyRzgvNDlOOE1Oclo1Y2hTOCtFMWVuRHNsOUtK?=
 =?utf-8?B?MFEwY3QwMGxFdklvM0NxVmw3NnVxdm5kaVZ2YlEvRWpramZ0WjV0aXdFVWhU?=
 =?utf-8?B?L1RwdFdvZGRWbFlEQk9EYUpCa0RVcGR2alkvMm9sQTI1SHYvLyswV0tDV1Vz?=
 =?utf-8?B?M0hpb1RaeVZ5WkpwNlF5OUcyZWYxekFpQzMxczlGTHR2NC8xVjkxMFh0bHBG?=
 =?utf-8?B?N0NLVldnMjVpSnpVaHJMNVBOSWVHUDBsRC9mK3FWWEpaaTZBbEFhQkZTOFJK?=
 =?utf-8?B?ZkpTUW1lMXZwdHpGRnl4NWVwaVY1MUMvR3NvRThtaUswRnRmMUtjYWpuNlZJ?=
 =?utf-8?B?K0xZcEZ6Nm1TMVNIV2YybWdhNXVmYjlrN2w0UjRGc0w2bUE0eGhOeXNLeS9p?=
 =?utf-8?B?TVUvNjlyYm5VZW5oR3ljbHNYS2pOUGpnbFA0b3pJRlU1RXVkMHp6bDloZkY2?=
 =?utf-8?B?T1RtRDVXenR4UWRDV3NqeEFWWWNod0RiQzRwQ3ZoUnpjelNyNTFnSnd0WVdu?=
 =?utf-8?B?dkpxVGhJd2c3TkMwUGVxR3BYOE44UW5lc2pvcUF6djNkZ1VwdUdnOW9vUXQv?=
 =?utf-8?B?QThoN0Q2NUs4ekY4ZDI0YlhyUEtIRDR5eVB2ZUlEVHE0UUZoaTcrQUs4Mmd4?=
 =?utf-8?B?ZnBCYzNXOEFNRTlGZGU3VGNteC95UmpnTCthNVR3S1ZoeEUrVHN5bjc0YkpZ?=
 =?utf-8?B?cldrdVZ4MEVrOUduQmpNL3Q3clgyU1M4dVM2K0ZEd2ZDQ1NKQUdXV3JvWFJq?=
 =?utf-8?B?QkFKMDdCejBCUlk1T1FzcTAxeEVpam1NWjNzSHRKckExd3VWS3JqdjlZc3cv?=
 =?utf-8?B?YXhETVIwT25PeWM4M21BOFlQd1BxY0hxNVlneE82TUZhOHBVcVlBQnpqTmlO?=
 =?utf-8?B?WUZvNFVrajJ4MGVaVFg0VW5CZ05jYlJzcXMrM3VUQXJrWVFZSW9QaXgwZnlM?=
 =?utf-8?B?NllzSDlEUkZTdjlDRnQyNStpMnFmNWFDNFgxakF5SzF1cVlGT3c4SjdSK1VT?=
 =?utf-8?B?SktER2JmeGgyWFRSV1U0TG5RcXFGMU1sVU1HNEYvb1o4VlFjSDdCSnVjOWtq?=
 =?utf-8?B?OU9HR3QycER3MGNLSUYweUM4SkJRaCtjTTVCRHV6VDhjelN0WWs0aFQxQnJS?=
 =?utf-8?Q?0wDRe0d2J6jH6BKv70Dmk5clZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c355e1b-b3b8-4efd-1847-08dab67d4ea0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 11:37:33.4659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obtqrtfZA7WT+Z9qGuOUew27wSAjBTIK8w/9mVEwSV48WOZpCotg3iZVuSWBtAgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

Thanks for review. I will fix these problems in v2.

Regards,
Ma Jun
On 10/25/2022 5:03 AM, Felix Kuehling wrote:
> On 2022-10-24 07:26, Ma Jun wrote:
>> Init and save the base cu processor id for later use
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 24 +--------------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 28 +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  3 +++
>>   3 files changed, 32 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index d25ac9cbe5b2..4857ec5b9f46 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -30,26 +30,6 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_amdkfd.h"
>>   
>> -/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
>> - * GPU processor ID are expressed with Bit[31]=1.
>> - * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
>> - * used in the CRAT.
>> - */
>> -static uint32_t gpu_processor_id_low = 0x80001000;
>> -
>> -/* Return the next available gpu_processor_id and increment it for next GPU
>> - *	@total_cu_count - Total CUs present in the GPU including ones
>> - *			  masked off
>> - */
>> -static inline unsigned int get_and_inc_gpu_processor_id(
>> -				unsigned int total_cu_count)
>> -{
>> -	int current_id = gpu_processor_id_low;
>> -
>> -	gpu_processor_id_low += total_cu_count;
>> -	return current_id;
>> -}
>> -
>>   /* Static table to describe GPU Cache information */
>>   struct kfd_gpu_cache_info {
>>   	uint32_t	cache_size;
>> @@ -2223,7 +2203,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	struct crat_subtype_computeunit *cu;
>>   	struct kfd_cu_info cu_info;
>>   	int avail_size = *size;
>> -	uint32_t total_num_of_cu;
>>   	int num_of_cache_entries = 0;
>>   	int cache_mem_filled = 0;
>>   	uint32_t nid = 0;
>> @@ -2275,8 +2254,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>   	cu->wave_front_size = cu_info.wave_front_size;
>>   	cu->array_count = cu_info.num_shader_arrays_per_engine *
>>   		cu_info.num_shader_engines;
>> -	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
>> -	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
>> +	cu->processor_id_low = kdev->processor_id_low;
> 
> I don't understand why you can't leave the call to get_and_inc here. You 
> could set kdev->processor_id_low here. Or set it when parsing the CRAT 
> table later. Setting it in kdev before creating the topology seems 
> backwards.
> 
> 
>>   	cu->num_cu_per_array = cu_info.num_cu_per_sh;
>>   	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
>>   	cu->num_banks = cu_info.num_shader_engines;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index ae1f0be3f3a1..099df4598a42 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -38,6 +38,32 @@
>>   
>>   #define MQD_SIZE_ALIGNED 768
>>   
>> +/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
>> + * GPU processor ID are expressed with Bit[31]=1.
>> + * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
>> + * used in the CRAT.
>> + */
>> +static uint32_t gpu_processor_id_low = 0x80001000;
>> +
>> +/* Return the next available gpu_processor_id and increment it for next GPU
>> + *	@total_cu_count - Total CUs present in the GPU including ones
>> + *			  masked off
>> + */
>> +static inline unsigned int get_and_inc_gpu_processor_id(struct kfd_dev *kfd)
>> +{
>> +	struct amdgpu_device *adev = kfd->adev;
>> +	unsigned int array_count = 0;
>> +	unsigned int total_cu_count = 0;
>> +
>> +	kfd->processor_id_low = gpu_processor_id_low;
>> +
>> +	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>> +	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
>> +
>> +	gpu_processor_id_low += total_cu_count;
> 
> Can this function fun on two threads concurrently? If yes, you may need 
> a lock here.
> > 
>> +	return 0;
> 
> If this function cannot fail, you should make it return void.
> 
> 
>> +}
>> +
>>   /*
>>    * kfd_locked is used to lock the kfd driver during suspend or reset
>>    * once locked, kfd driver will stop any further GPU execution.
>> @@ -656,6 +682,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>   
>>   	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
>>   
>> +	get_and_inc_gpu_processor_id(kfd);
> 
> You're ignoring the return value. Since the function cannot fail, make 
> it void. The name "get_..." implies that it should return something, 
> though, so maybe change the name. E.g. assign_gpu_processor_id.
> 
> Regards,
>    Felix
> 
> 
>> +
>>   	if (kfd_topology_add_device(kfd)) {
>>   		dev_err(kfd_device, "Error adding device to topology\n");
>>   		goto kfd_topology_add_device_error;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 182eb67edbc5..4c06b233472f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -370,6 +370,9 @@ struct kfd_dev {
>>   
>>   	/* Track per device allocated watch points. */
>>   	uint32_t alloc_watch_ids;
>> +
>> +	/* cu processor id base */
>> +	unsigned int	processor_id_low;
>>   };
>>   
>>   struct kfd_ipc_obj;
