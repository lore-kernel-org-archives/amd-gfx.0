Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B787C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C6910E26E;
	Tue, 14 Feb 2023 19:17:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87DA10E25B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2HEovYmwEbIb7scmnDWZsWhWHaDGYRPd+qBrQI74Eay5rHOCmwWTwQSuKxKHto44nMTAdtisZwvC6z+id5DAP/7DBpY/6kQtAUlDQnLmGdpCnzFknxFR5QuwKBCp2CxpsxCKuS59jYl7r2Nr5cc3QK2xzgTVYluDkvz31NO490TjhpT4HAEay3Kct8+1ENUZMM/UMCtC4gi/hozhEHOmrSFBiG3caUE6Sb92vd7NxoOmJl4fd8c0GZi2g2dqYe1QyPCFGOQKayWNeLPqvFTBOzAtnoENdr6eX1vk9R2Sc1O23M5V/2EAqwQjIzcVuZp2BnJQ91COuZkZXLX+MBhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUWT5Y9bKyd+28v+UAPPMf0ZSao/Xv8RtfrSxVZRRmk=;
 b=CHPDmHPxOCuAaId+zN1rZ1Sv7moTPg57XxMLJX7hGhIzgYqsRrrS+92IX9GsUOXbd0JcDHoIwItc8/Q9vgKlcppMaQAnJ6G+BaP8QYGexCmZS4Lgn6Iv41fyMGhzC15HPmy63QhhxwbWqhhbpPkqeYLA2EBwF7qH2cPgwalp7dZO7hYDxwhpEd5eE7LpqDUoFS61LKGRZy4bsnqfG964uR5OOnue6meJLuuZMWa+aHGNEcUbzBz3xEKYBT308CIFcuh7t7OwB+qS205SLvxCdbklCLGkBJzUa/EZOghbsMDMLUot5/OJuCm7btvY3YCbFyHfd3yNX7OdnE4O5ag51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUWT5Y9bKyd+28v+UAPPMf0ZSao/Xv8RtfrSxVZRRmk=;
 b=P+61/l5fzhuVKwKZcNthN2iotVTaRWKrNsINur6CBVxXytCD6rM7NbR+eB+Qlss2HyND43zDC5GUbYgyuq6mmaljEe2+0GdKlo6TnRjsPk2y3+wv4XMcYRSCTGoN3p8xtrHYww/JvurftyyM68L/8veVNiacnwJlyh/KTOHJJ84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 19:17:05 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:17:05 +0000
Message-ID: <4d949de2-c4a1-d8f4-3139-c0f24d9e028d@amd.com>
Date: Tue, 14 Feb 2023 20:16:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/8] drm/amdgpu: rename doorbell variables
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-5-shashank.sharma@amd.com>
 <d68c855f-03de-5f24-3da3-553209648603@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d68c855f-03de-5f24-3da3-553209648603@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 7858b228-d8e5-4a74-205d-08db0ec00eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0/B2eZyDvFvi3fiNZ4MBjj/te36eQHdrex9CRtC2R9ANdyInZhvhQ30agwTgjJiPju6HRfVLJMnRVZKwJ1ZvxQbO8e+Ps/RlQO/ITwXcxMrY2cLXDtrZppWH61+phU4ik1T3AG1y9WrxFcWM/gvRFDNICfQ68bVE4vg8CDUc5cTiFdDs72khxWYVMUNflXutqqDj9PEAkfhTug6tDcjU5cCCCKOAsIXUMXIb1sb48GH2YRXfxbDQK0nzbxAxtJ5pLOZEn8yVio78sRXAv5LfCoLMG5/t95uH2MJhbMLg5fUj0vuFATldo6KjGvz5s6fUNc3T+sAgeXx2I5s42wsyqrRWo/wWHONssu0wcsFw8Yo1FQ6lqxX4qvrAtGBihKALjd4/opemFB4isi/N/pvLWHPyU19csJaeMilsVpMd3ZM84giKCbur6TIjHT+ndnyB5VgF/RK3aQhmRKIuDpIO6c5WgBoQViMBDq1spycg7RJktUN9N0NHS9dR94mv/5RM8edsaJtygt1XMIfMei8B0Fv8vwqJl1QpcRcf4iYWZYugZDPHJD5nFo74+T+AT7Rm4m1e+K0nf+c27ffL4GHhZa6Ghi+jrp/bRR7EXYL9C3oA2zM/CJBk5RzMA5lkG5RmNfcvLreVV7M95CQd9p0UFRR57X0Ybj3OHLApphHEt2+R7wToowT4c+b8higYTwfKBjuez0aTM+kyaDS+fjegxcRADyFdEMnNJ4YUVqJDus=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(44832011)(30864003)(36756003)(2906002)(6486002)(5660300002)(31696002)(26005)(6506007)(186003)(66574015)(83380400001)(2616005)(53546011)(4326008)(38100700002)(8676002)(66946007)(8936002)(86362001)(66556008)(66476007)(316002)(478600001)(41300700001)(6666004)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhkYldxQlFuQ1psZHB1cGdNSkM4OElQbndzdmpjaUtib0NkUlMyZWs5dXg5?=
 =?utf-8?B?Sy9kVURDRFpsYnNCcGJ4M1BYYXZ0UkJ2Y3lQeTBBMlMvNmpIdW9xWGRza01V?=
 =?utf-8?B?TUxjc3Zxbmx5ZEVhVHBwbTlDeUkzMjhvanRWdHRISUlpY0hoSFJMN0Vhclg2?=
 =?utf-8?B?RUh6WmZKcjF2ZjZkZDBDeVlkWDltQ2tDcTVpRlIzbEhFa1VZbFJwY01UMTV5?=
 =?utf-8?B?eWZUSHZ4aXVrcHRXWU9QaVhaT01VRHNYVEhJMHNTSk9KWnc4b3VLRjBjRTJO?=
 =?utf-8?B?N2lKdldreUN2eEdkUkhjWTRCN1R5amo5RWxObkdsa0Q4RXRsdFlPKzMya1FT?=
 =?utf-8?B?RVJOQTlSNnhnYWo3Nk9lTWFMSkt3UEdBNTd0QmpEYzE3aDJpMG51Z01PVUU2?=
 =?utf-8?B?dEhJMUU3ZDY2cDRFVFZKTHJqNjhTUmtPeEJkWEo1OTBMMGlWOWpqU3U3TEJ1?=
 =?utf-8?B?SHZRRmFIcHZyUHRjbEt1N1o1YW9XY3ZUWlhsLzFYZUE4WUZnSGNTQWllV0VG?=
 =?utf-8?B?WCt0K3J2KzA2aGhZUUkrSDVHWkdDUnZyMUk4d0g1ZlhTN0N5dVN1UURWQ0Q1?=
 =?utf-8?B?K0NEMHZwcmE4d1o2b0FZLzRPMjdKSWg0OWRybGw3M0xSVE5yNVpUNXdDamRw?=
 =?utf-8?B?aEVDdVV1VDhzcnpGaEJCeW0rWmtTK1hVM0tZTEM4VlpzQjNDNXdKN01uckFm?=
 =?utf-8?B?eFNaOGhHUk5IY241Wjl5NEw5NHY4OTB0UHM2WVZ0MDl4RTFVaWVQdTZQdU5r?=
 =?utf-8?B?ZHVhVnduYnNIYXZFRTVQNGorRTVERE5qc1RDdFRCQlBmai9qV0JnNmxzZGR2?=
 =?utf-8?B?MFZldDRWN09UWFNiMGdyL1N1UTFTWFArcWRYTmpNNEtqR3FOeFlSK1ZBOGQw?=
 =?utf-8?B?b3Bwa1RlWFQrN0xtYlFZSGRZd0dRYXVmVkZwNzBlWHFWYXd4UzgyRzY2N2Rn?=
 =?utf-8?B?aFNTNEw5SklkSmJUWDhhbjBtS1lPL0NsbjVnaUE4NDNZWThBdEtmM2c5MEtF?=
 =?utf-8?B?S1hVaWRKY2pRZStuS3BxNzQvRHZkZkdWcFNXZjBQS21ZamVJL1E2ZTdXN2J0?=
 =?utf-8?B?Nzk5ejJtcWlwMDZJUUtCU1JBN2Z6R3ViT0VZT3B2UXo2V3g0LzFsOTFZeXJT?=
 =?utf-8?B?dGJGWHZoRXZCV1dXTXZmOFBrcTE0UGdqNnNsT0VDVFQySEVySkc1L0ZsN29s?=
 =?utf-8?B?bEV5dGxxUWFKUDhLN09PcWU4R0tMRFBNREVJQUlzSExpSW9nMFlBakw0cnRy?=
 =?utf-8?B?cnhzMzA4WDg1a016R1I4ZzJEcjdLVDFqV1Y5WmNXcmJxMldMbXR4NnZlbzJM?=
 =?utf-8?B?T2pQaWVKWWJvTmJ5VWZzVWMyNkxzQkZJOWNZTk91NG5xYXlBTDZjSTNxcHFp?=
 =?utf-8?B?amhkd2YzZ1V1eUFOdk1lMlFjVDZvMDFQK0ZLV2hkK3IzamdPelBvY09HY2Zz?=
 =?utf-8?B?THVYL3RWMHJNWEZ6OUpzU1dCZm9HZk94TmxwRG9rbStxT1NGdElvRzk1Titk?=
 =?utf-8?B?MDR5WGpNTTNGUFFTclBacXlVWXRHdXQ5aVVtUGtqNVVHT1hWVXpSWDNRRS9y?=
 =?utf-8?B?Y3FIZXBwWVhGRkpseVpieEY5QVB4UDF5ejZFamFiWjJBYlZRY3p0ZGxjSmFx?=
 =?utf-8?B?Y0dCdWszb1ZFTmRVZHZ3UkJVMnVMU1gxK0xVWmxIQUFERGVtbGhNczFUbU9o?=
 =?utf-8?B?TVRDbVRZMDFVUGV0ZksrSG5zcHBxa1hJRUdydFBOWStLVkpRQ3A0S1pQdElj?=
 =?utf-8?B?UVdESXRvWW1pNGxxL3F3dHlxQng2Y09vNXU1dFZWUk0wRzlVc3cyYk1Hampm?=
 =?utf-8?B?Q1dEUnViQTZPM24rOElYaDd3dFB1VUFZVWYrdWdWcHRxa3BVZXdFZG91YXhz?=
 =?utf-8?B?amQ1Y1hnSEVNK2ZQUTNRc25ORUFlNU9mTkRhcjVKRDRHM1k5TDBWYy9VZ0xr?=
 =?utf-8?B?SmFmcUNBcFRtenJGOU9YVm8vNVphbUlaUEUyc2d4UFJzdW9YUTNsaGNheEtS?=
 =?utf-8?B?WE5sUVNtazF6Y2ZIQUo0NnNCZVhaNGFHQnZtK0d1ajBLMDNmeGI4RnFrdTJl?=
 =?utf-8?B?UFYwMWJ4SS8xc1BaUVp4cWNwdWZrWkg0Uyt2ZFpldjcrYmRacGtKZ2MyU1Vl?=
 =?utf-8?Q?lt5SEfvT+euoZwXuliDIkI0oC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7858b228-d8e5-4a74-205d-08db0ec00eec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:17:05.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEhGwqCLq73IQaX2LK930QBic6NzT8JceXbok/+nDZgQ672dnA9GB7jZmjMhAPk+Gm5n9iHsYeK0GkRFAxymcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:27, Christian König wrote:
>
>
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch:
>> - renames the adev->doorbell.base to adev->doorbell.doorbell_aper_base
>> - renames the adev->doorbell.size to adev->doorbell.doorbell_aper_size
>> - moves the adev->doorbell.ptr to adev->mman.doorbell_aper_base_kaddr
>>
>> rest of the changes are just to accommodate these variable name changes.
>>
>> V2: Mered 2 patches into this one doorbell clean-up patch.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  8 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 34 ++++++++++----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  5 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 +--
>>   drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 +--
>>   12 files changed, 38 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 58689b2a2d1c..0493c64e9d0a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -106,13 +106,13 @@ static void amdgpu_doorbell_get_kfd_info(struct 
>> amdgpu_device *adev,
>>            * not initialized as AMDGPU manages the whole
>>            * doorbell space.
>>            */
>> -        *aperture_base = adev->doorbell.base;
>> +        *aperture_base = adev->doorbell.doorbell_aper_base;
>>           *aperture_size = 0;
>>           *start_offset = 0;
>> -    } else if (adev->doorbell.size > adev->doorbell.num_doorbells *
>> +    } else if (adev->doorbell.doorbell_aper_size > 
>> adev->doorbell.num_doorbells *
>>                           sizeof(u32)) {
>> -        *aperture_base = adev->doorbell.base;
>> -        *aperture_size = adev->doorbell.size;
>> +        *aperture_base = adev->doorbell.doorbell_aper_base;
>> +        *aperture_size = adev->doorbell.doorbell_aper_size;
>
> Well that now looks a bit duplicated and you completely remove 
> doorbell_aper_base_kaddr later on, right?
>
> Christian.
>
Yeah, I still kept it as this cleanup is a bit peculiar and not easy to 
follow on review, but your right, lets keep it cleaner.

I will take remove doorbell_aper_base_kaddr.

- Shashank

>>           *start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>>       } else {
>>           *aperture_base = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 45588b7919fe..43c1b67c2778 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -597,7 +597,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>> *adev, u32 index)
>>           return 0;
>>         if (index < adev->doorbell.num_doorbells) {
>> -        return readl(adev->doorbell.ptr + index);
>> +        return readl(adev->mman.doorbell_aper_base_kaddr + index);
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -620,7 +620,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>> *adev, u32 index, u32 v)
>>           return;
>>         if (index < adev->doorbell.num_doorbells) {
>> -        writel(v, adev->doorbell.ptr + index);
>> +        writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> @@ -641,7 +641,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>> *adev, u32 index)
>>           return 0;
>>         if (index < adev->doorbell.num_doorbells) {
>> -        return atomic64_read((atomic64_t *)(adev->doorbell.ptr + 
>> index));
>> +        return atomic64_read((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index));
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -664,7 +664,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v)
>>           return;
>>         if (index < adev->doorbell.num_doorbells) {
>> -        atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> +        atomic64_set((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> @@ -1035,10 +1035,10 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>         /* No doorbell on SI hardware generation */
>>       if (adev->asic_type < CHIP_BONAIRE) {
>> -        adev->doorbell.base = 0;
>> -        adev->doorbell.size = 0;
>> +        adev->doorbell.doorbell_aper_base = 0;
>> +        adev->doorbell.doorbell_aper_size = 0;
>>           adev->doorbell.num_doorbells = 0;
>> -        adev->doorbell.ptr = NULL;
>> +        adev->mman.doorbell_aper_base_kaddr = NULL;
>>           return 0;
>>       }
>>   @@ -1048,15 +1048,15 @@ static int 
>> amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>>       amdgpu_asic_init_doorbell_index(adev);
>>         /* doorbell bar mapping */
>> -    adev->doorbell.base = pci_resource_start(adev->pdev, 2);
>> -    adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>> +    adev->doorbell.doorbell_aper_base = 
>> pci_resource_start(adev->pdev, 2);
>> +    adev->doorbell.doorbell_aper_size = pci_resource_len(adev->pdev, 
>> 2);
>>         if (adev->enable_mes) {
>>           adev->doorbell.num_doorbells =
>> -            adev->doorbell.size / sizeof(u32);
>> +            adev->doorbell.doorbell_aper_size / sizeof(u32);
>>       } else {
>>           adev->doorbell.num_doorbells =
>> -            min_t(u32, adev->doorbell.size / sizeof(u32),
>> +            min_t(u32, adev->doorbell.doorbell_aper_size / sizeof(u32),
>>                     adev->doorbell_index.max_assignment+1);
>>           if (adev->doorbell.num_doorbells == 0)
>>               return -EINVAL;
>> @@ -1071,10 +1071,10 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>               adev->doorbell.num_doorbells += 0x400;
>>       }
>>   -    adev->doorbell.ptr = ioremap(adev->doorbell.base,
>> -                     adev->doorbell.num_doorbells *
>> -                     sizeof(u32));
>> -    if (adev->doorbell.ptr == NULL)
>> +    adev->mman.doorbell_aper_base_kaddr = 
>> ioremap(adev->doorbell.doorbell_aper_base,
>> +                              adev->doorbell.num_doorbells *
>> +                              sizeof(u32));
>> +    if (adev->mman.doorbell_aper_base_kaddr == NULL)
>>           return -ENOMEM;
>>         return 0;
>> @@ -1089,8 +1089,8 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>    */
>>   static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
>>   {
>> -    iounmap(adev->doorbell.ptr);
>> -    adev->doorbell.ptr = NULL;
>> +    iounmap(adev->mman.doorbell_aper_base_kaddr);
>> +    adev->mman.doorbell_aper_base_kaddr = NULL;
>>   }
>>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 7199b6b0be81..526b6b4a86dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -26,9 +26,8 @@
>>    */
>>   struct amdgpu_doorbell {
>>       /* doorbell mmio */
>> -    resource_size_t        base;
>> -    resource_size_t        size;
>> -    u32 __iomem        *ptr;
>> +    resource_size_t        doorbell_aper_base;
>> +    resource_size_t        doorbell_aper_size;
>>       u32            num_doorbells;    /* Number of doorbells 
>> actually reserved for amdgpu. */
>>   };
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 0c546245793b..b79fb369f0f6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -126,7 +126,7 @@ static int amdgpu_mes_doorbell_init(struct 
>> amdgpu_device *adev)
>>           roundup(doorbell_start_offset,
>>               amdgpu_mes_doorbell_process_slice(adev));
>>   -    doorbell_aperture_size = adev->doorbell.size;
>> +    doorbell_aperture_size = adev->doorbell.doorbell_aper_size;
>>       doorbell_aperture_size =
>>               rounddown(doorbell_aperture_size,
>>                     amdgpu_mes_doorbell_process_slice(adev));
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 929bc8abac28..967b265dbfa1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -51,6 +51,7 @@ struct amdgpu_mman {
>>       struct ttm_device        bdev;
>>       bool                initialized;
>>       void __iomem            *vram_aper_base_kaddr;
>> +    u32 __iomem            *doorbell_aper_base_kaddr;
>>         /* buffer handling */
>>       const struct amdgpu_buffer_funcs    *buffer_funcs;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index f202b45c413c..7722da8e7cb4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3526,7 +3526,7 @@ static int gfx_v9_0_kiq_init_register(struct 
>> amdgpu_ring *ring)
>>            */
>>           if (check_if_enlarge_doorbell_range(adev))
>>               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>> -                    (adev->doorbell.size - 4));
>> +                    (adev->doorbell.doorbell_aper_size - 4));
>>           else
>>               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>>                       (adev->doorbell_index.userqueue_end * 2) << 2);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> index aa761ff3a5fa..c5fd58d5fef9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
>> @@ -173,9 +173,9 @@ static void 
>> nbio_v2_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>                       DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>>             WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -                 lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -                 upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
>> index 15eb3658d70e..9d716ec71f28 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
>> @@ -169,9 +169,9 @@ static void 
>> nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>                       DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>>             WREG32_SOC15(NBIO, 0, 
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -                 lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0, 
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -                 upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, 
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> index 37615a77287b..19e175cc7340 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
>> @@ -121,9 +121,9 @@ static void 
>> nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>                 REG_SET_FIELD(tmp, 
>> BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, 
>> DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>>             WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -                 lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -                 upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, 
>> mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> index 31776b12e4c4..bb2f1857b1e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
>> @@ -175,10 +175,10 @@ static void 
>> nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>             WREG32_SOC15(NBIO, 0,
>>               regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -            lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0,
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -            upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, 
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> index 19455a725939..ee1982bb06aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
>> @@ -223,9 +223,9 @@ static void 
>> nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>                 REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, 
>> DOORBELL_SELFRING_GPA_APER_SIZE, 0);
>>             WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -                 lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -                 upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c 
>> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
>> index def89379b51a..180d50bcb40f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
>> @@ -132,10 +132,10 @@ static void 
>> nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
>>             WREG32_SOC15(NBIO, 0,
>>               regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
>> -            lower_32_bits(adev->doorbell.base));
>> + lower_32_bits(adev->doorbell.doorbell_aper_base));
>>           WREG32_SOC15(NBIO, 0,
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
>> -            upper_32_bits(adev->doorbell.base));
>> + upper_32_bits(adev->doorbell.doorbell_aper_base));
>>       }
>>         WREG32_SOC15(NBIO, 0, 
>> regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
>
