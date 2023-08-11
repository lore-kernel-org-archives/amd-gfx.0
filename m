Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CC9C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 07:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D04910E668;
	Fri, 11 Aug 2023 07:13:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA2610E668
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 07:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Drh9bY8apdv8vo2L+EGbCXHgWqdVz7SXeosRF4xYyB9TIM50oNm4rS4FVOjfOoXFKEviJeMohiWq0N2JkGSNit6ID2alavv4DE+IVMEXtJWCm8vYBFLZUoA7yBOB7/OyA1y3mjXx5zZ2LBpE7d4NCNMC6IsyVkSr+ecy6QD8QCJnAlrunioV0OqUrpNvd88cajmj2OAem7w1qPSLn0UW+6QvQzt+3AgbtipeUs6J4iPnOnHxmIEMROBn/qPz1kNHynd4AJxrvsuGVkSxDqyHA+KjmbZfdYHdFjYXZ0RiHjZ0FjYdFD/5E+6q6vJyIqbvZYW/T4uuovv/e+apOfR1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf8uXQDpW6nuiHI0AAHpu9UgFECaTAxcRbt8yPvlFu8=;
 b=elxbHISO/sL9PGChKvOR8HZeUEjlmTAiTRdoauHud1BLdCbToaGpLmHsgGh2paBrhcuJBOqm8dkUYfJETkxM2Jo9jwBuMAxgJXyS6EyF25IwQwAEIGl4lMOEjzoZCkfDB3MMx9Gk2xXmgl6akAR6aQzEe51VhsCHUcM5P6E5pbAk/qtvIEayu1NAEix9j5kOmWpHaqElFYTu50jQljEnC/JIJwEdJdaWNEU88zObNC1rJM4Dif1iXB/RJJYuK2QOuTwhIbGYPl4SYE/IUOFK00QqgjR4MJ30jbmDYgI0xAgpkMxYpdL/WuEDX6EleOwIN/9WjXLkmstk+r2eWOVI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf8uXQDpW6nuiHI0AAHpu9UgFECaTAxcRbt8yPvlFu8=;
 b=1L9o/YCz7yiaeCR2Qy9e3NEcQKa20FYh/L+lNkQNmX/pYWF9lHO6zjXCyJDJiWI5qF4658skg6AtM00oM021yofBYkUItqvulBxuuY1RAQMm3Zg7Wi63atey+coEmy9VpeTNSaqGDkL5B1lK3wbssWJ+1n11BMA1M1kiiUBlIfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 07:12:55 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::a1d2:8170:526c:490d%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 07:12:55 +0000
Message-ID: <e577614c-077a-6b1a-5842-aea1d3660938@amd.com>
Date: Fri, 11 Aug 2023 12:42:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Add memory vendor information
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230811041157.652427-1-lijo.lazar@amd.com>
 <DM5PR12MB2469D6AB6C6D65195AD71C23F110A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB2469D6AB6C6D65195AD71C23F110A@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf09a8c-51e4-4e3a-42b8-08db9a3a6257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjt1iWfcIPH/HmnA5t/MawZRVApbC1sPThz4sP7cM8TTO5+zUOnP4rwprAO6Rv6ZjKsFDjobpdMjGUVHiTwsH/h/7dlA2k00kiRQzu7IdSpxJOsStC/SVNi6GB+bS1TSvyHb75eA8pjpFHZMKdxLnL5dH+gCG6ATN721UqkRbsMnJzAqgtwh382ds8dlJK3ttLyFTEOYL5cFB+zszaQnTG2E4JMfdGmhM75AvggCCH9j0bAYL5EdmY3Ha1/0ZRUPhd88v61WEZG0CSNgOh4amsYmrhRhkWx5xZKPJtsSNNa8QfcCYeo/1pCnx03Mym0meo58+8konCKFD7Ny6EUYHsO5UqxXkMUNTNvwrGtN/np1J9IMb6H6N4D4dZizOnjlojBSVggZiVX/YVSXWhgSbPEhgilU/AeqjtFf7odbu+KM+mSQEHo8e1mIvg9v7fKajSa7YEiqv4CCIS6emiNBhqz9G3xjEGZ0KGSHpdtWIQuohl6Lrc5hOwigJS2WfoWcE+vrVxJgYwVAGtsOStttsjM9FfeOpXI8E6wsdtr3LEcLY8gxgHiZSed96ej6+ggBnUc1SJ/lQQJx+ILZAljD6HtsfI/lxTuMI+hF8aZ4oxPSAb8f0F0g55Tq8eUWAqdAz4CtMMkpCKjwkFxGlMZ3AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(1800799006)(186006)(316002)(83380400001)(6512007)(8676002)(2616005)(8936002)(41300700001)(5660300002)(4326008)(6506007)(26005)(66556008)(66946007)(110136005)(66476007)(53546011)(478600001)(31686004)(6666004)(2906002)(31696002)(38100700002)(36756003)(86362001)(6486002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3YvdWZ3Z3VQVUZuYnBsMXlKQW9GR2FCRVNUQ09zV2hldGhpS0x6UUxzUmxE?=
 =?utf-8?B?a21nakpPL0VlQXBaOXpzYkNpRzBPTDlCalJPdlVkQllBbEdna2RpOTdFamNU?=
 =?utf-8?B?ZW11RW5PNDNiTy93Qng0K1R4TXdPVEo3ZWluQ2MycGRxNURLR0g4NGxNd2Ir?=
 =?utf-8?B?WVAvU3pWVzd3ZTV3SUFpL3Nlb0U4RGVGQS9uc1psRGNGemExMTdsYlh6QjUy?=
 =?utf-8?B?QzlDYjdTT1cyZ2djNjdSV3A3cm1KN0tUNjd2RXNtNFl0ZUgrb1d2dkg5UlF5?=
 =?utf-8?B?Zy9EZ0hRZkJQWitwYlVIbFlya3lSTDQ5R2ZYU2JTY1FUTm90bitnTzJpelF6?=
 =?utf-8?B?UnRKS3BHM3lNV2tGeUtXbU5mRW1XUlYxMk1oZllsRWhySkZOTkUwWnhmVGxU?=
 =?utf-8?B?bGZ0dzZCUU9rNXlrczI3QjRNcUVCazBMNS9YcVBPWkNJT0l4WUtCL1p5Tjd2?=
 =?utf-8?B?N0NNSHZ5SXc3VEt2bVk0TFQwYjlSVmtjenpwQmlOSitzT0NiVXRBYThlSHVX?=
 =?utf-8?B?c21BbVAwaCs3Nnh4aXo1cGVBTVZCNXpkU2hqMGhaZEwzOEhidEx2QmNOemZk?=
 =?utf-8?B?TG5BZ0Uwa0gyb0ZOSWxCdVVMN0dYd05DdFA1REY5bEE1YURTS1pQamdiYnlT?=
 =?utf-8?B?YThUSjNodXE3VlJvRE5RY3Ewb1lDYzJmaUtGMmRDTkNSeWhPZFQzQTRHOGhI?=
 =?utf-8?B?aVZkbTVYeGNDZW9WOTFPUStZeFRGKzFhM0pDV2JnVU5KYjZnL3lmdm5iSUZE?=
 =?utf-8?B?SjRCMUc5YnFhRVZZYkRHbnFydnUzeW03RmxTY3BCQmdMK3JhMWpEeXQya1dR?=
 =?utf-8?B?cUVFVnhscldaSWVTaWtRVGE0L2Ywd0JpUTlQZDNTVDh3Mzkzcmdaakk4RmtZ?=
 =?utf-8?B?WUhEc3UwWEQ5QVRPc1A5V1RUQzR6WDQzMFhWQU4va25VNEpWRFVOblBmQ3hK?=
 =?utf-8?B?UGRSNjlXWnpkcnZMQ3pUY0FXYkVTSWdObll3cWlwOU1TdmpJV0NEcjNsTDVR?=
 =?utf-8?B?bEFnOVpqbjdBOGtNNko0ZU5KNkFxWDdoa3pPZnVJTFRRQk41Zm9TYXp1a2xU?=
 =?utf-8?B?VDNGdjJCREMyOUhPN2I4SHJpOW5vWVpiSThwQkxSdlRkVU0zQ0xIYzdGMUpU?=
 =?utf-8?B?bjArdDZ3cCtrcEJWd3VuTjVWWUF2S05NOE0wdmxaTFVVZ0hiTUl4TnBvUFli?=
 =?utf-8?B?aEJvdWtOZkY1Ym5rSEcwTGZjTW1PR0ZMK3JXVUFOK08reDcxK1JoYkwwSkgx?=
 =?utf-8?B?T1A3K1ZnQ1dLdHhPTVVmdlVRQjhCRDQ2NHR3UlJjSGlWMng5aHVkeVdCZFNZ?=
 =?utf-8?B?NmI4U2pIY0lxbGlUZGk2R2ovQkZwNjJmYkVCa21KVXdTZ1FQVFdzOFZZb243?=
 =?utf-8?B?V2NYTW5KOUFIdG80MHVDc2FEblhUd3pUN20xamxYZm9QcHhWQlJ4UTRYTlM5?=
 =?utf-8?B?LzhLYVcyck5oWlVZWE04d1VSb2hXZlRwWmRFenRWSllmWk11WlBLM2kvZlNJ?=
 =?utf-8?B?dEpnR0gxc2JrT0VmRWwybUsreURrQXZnb2t6c01LZzNhekI2L0k5QjFEM3lv?=
 =?utf-8?B?MkFYUEx1SU9aTE51dHVVQXQxLzNQWlRBRFc3TlpxTzlId0RGQ0JHTzBCeVpk?=
 =?utf-8?B?ejY5MFBUd0pTZjR3NlhPakZDbE1VdVkvQ0dML2FqcjBzUm5Na2hLSUU5TWJy?=
 =?utf-8?B?QmIzQS8rOWRiMnBOZVQ0YzFuUjlxK3kxMHZGVnprcWlldE10SVgwN0x2TjZK?=
 =?utf-8?B?eXcrdTN3KzNMbTQvWnNZbndUdzM4TnVtUFh1RTk0MEg5WDBYT0NVTklkVFZR?=
 =?utf-8?B?ZFR4S253SGUzRU85QnQ2bUtxQk5RRFdGd3loSTdxbGNBUjM5QTN5YW9pb2Np?=
 =?utf-8?B?QXI3VlZLRmpVQkRaSUM4bnkwZGxMWWFHdEhqenRlUzZoVFkwekw0Wjh0T1FN?=
 =?utf-8?B?TDF2ZVh3c2N6c2c2RG1iMEgweGd0RFdCMkU0SFpqZytoeUs0TURjVHdkTzZK?=
 =?utf-8?B?VWJIVUV0UG5kQ25lWVNZVWNJb0FHQnJDV1phajc2dmZvTVdnSTNBNmRLVm9z?=
 =?utf-8?B?S1ExeENmTmJReHpXNkJuQnNUUGtRTzFzdTR3RCtKdVZhT3pXd0FpWnpBR0xx?=
 =?utf-8?Q?yFcOVKVXE+OvuKny/sSUdDdju?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf09a8c-51e4-4e3a-42b8-08db9a3a6257
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 07:12:55.5347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fLnimkORuGrAR2HfIjuNXQdCpRcur1zlYQajNOiH6psRrALYserqrAVv0TD8Wx4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/11/2023 12:36 PM, Chen, Guchun wrote:
> [Public]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
>> Lazar
>> Sent: Friday, August 11, 2023 12:12 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>
>> Subject: [PATCH] drm/amdgpu: Add memory vendor information
>>
>> For ASICs with GC v9.4.3, determine the vendor information from scratch
>> register.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++-------
>> -
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 880460cd3239..f9a5a2c0573e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1998,6 +1998,19 @@ static int gmc_v9_0_init_mem_ranges(struct
>> amdgpu_device *adev)
>>        return 0;
>>   }
>>
>> +static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev) {
>> +     static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
> 
> Any reason to use a static variable here?
> 

It's only done to initialize once and keep it shared even if multiple 
devices use the code path - that will remain true for any reg address I 
guess.

Thanks,
Lijo

> Regards,
> Guchun
> 
>> +     u32 vram_info;
>> +
>> +     if (!amdgpu_sriov_vf(adev)) {
>> +             vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>> +             adev->gmc.vram_vendor = vram_info & 0xF;
>> +     }
>> +     adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>> +     adev->gmc.vram_width = 128 * 64;
>> +}
>> +
>>   static int gmc_v9_0_sw_init(void *handle)  {
>>        int r, vram_width = 0, vram_type = 0, vram_vendor = 0,
>> dma_addr_bits; @@ -2010,15 +2023,12 @@ static int
>> gmc_v9_0_sw_init(void *handle)
>>
>>        spin_lock_init(&adev->gmc.invalidate_lock);
>>
>> -     if (!(adev->bios) || adev->gmc.is_app_apu) {
>> +     if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
>> +             gmc_v9_4_3_init_vram_info(adev);
>> +     } else if (!adev->bios) {
>>                if (adev->flags & AMD_IS_APU) {
>> -                     if (adev->gmc.is_app_apu) {
>> -                             adev->gmc.vram_type =
>> AMDGPU_VRAM_TYPE_HBM;
>> -                             adev->gmc.vram_width = 128 * 64;
>> -                     } else {
>> -                             adev->gmc.vram_type =
>> AMDGPU_VRAM_TYPE_DDR4;
>> -                             adev->gmc.vram_width = 64 * 64;
>> -                     }
>> +                     adev->gmc.vram_type =
>> AMDGPU_VRAM_TYPE_DDR4;
>> +                     adev->gmc.vram_width = 64 * 64;
>>                } else {
>>                        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>                        adev->gmc.vram_width = 128 * 64;
>> --
>> 2.25.1
> 
