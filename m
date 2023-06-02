Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF967C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 05:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AB610E045;
	Fri,  2 Jun 2023 05:59:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFAE10E045
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 05:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8kEq9g+X+haUWjBV/pqyaz/AfkCkXx9vz1kQVhQ2LSLk5LebTk2/xRMWhM+arWreH1+cpljvk/aV+ManA/MW0UYgEmHC+YcZGRs6DG4D2KRgS7L1LdmabmDSlTOJRTO93eDotAaiB/65P16ECN6Y4FBm7/7KAgi2sHKnGOGdH7+b6/kfpFmoNeCpiYnqeRsabwBgcXiVxzHnotbUagzPxyR9UKif6wRuO9ZiopajeXnfJxAbC4AcVCHrpMl/6sOzFX6+Z/I78TAIWK89T9j4VezUkOLtyEIr0S1HMGd5yqrqJHfa8LqYggkMAJAqFrPBe52J3+zjVfdv68NdHBM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bToy80+fxYmxxnUH65Zn7QUNiVA5u9pwHahGL4wq2B4=;
 b=WbkAWizlUmLpPJoR3ltESqSfZLMIA6JZgzgFQ5gXQISTJG2QZ88XIRI+TN21DhLeSrz4fk9JU72gEtPbI6c7UrrruTyiGUGrMxyju5517Wj8kFwftLnkwbsSr0gW/17VgzrhBKnKZO3WoUlA5DxitZEfRpiPuZHVb2POVWyU9AMz56ihD52KVvt46bWIPfGQWvCsVtOYwvsjGINvyMp5VJViWcTpA593+p/Wf4K0m8GZIeGdp40h2r9O36+QwC8WapImNKmCHkj9yaKYWarT5mro5aMCHySqYjOMN4hzByfHlGo7dBG2X7Dc26ePPQmR8laPI0+C6a9rCvIZ2xc7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bToy80+fxYmxxnUH65Zn7QUNiVA5u9pwHahGL4wq2B4=;
 b=zZQVo5TixsGyHmkePWfNwDsivuOpoQpAjLFhoPmgLGo4Zk5uvtzaFDHDe4AGCnFMCqYOHIAuWVcjGWVyjyTe6KcsRkm5bdByBn0L0pfVlytfAnTdDQ2PZ3mPr04+Lie286S/nz2qUr28P97v6KvfUOXM08b6QdjDthO3VZYTAXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 05:59:17 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 05:59:16 +0000
Message-ID: <9f17b8b3-634a-366f-3eba-77af23bdd435@amd.com>
Date: Fri, 2 Jun 2023 11:29:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230602040025.655957-1-lijo.lazar@amd.com>
 <DM5PR12MB24696BDFC886C94CACF87FDCF14EA@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB24696BDFC886C94CACF87FDCF14EA@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3873d7ee-e864-457f-9a8e-08db632e7f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DO/q4i3F1Bm7nRGi6V6hX5A9zvXocAoIlgcYe6EeqJ+vThByI/nXx7WiChSYqtFaBNmCS+QUNbwjWI6W8y2Heaq/A9H0s/Vd8RrfOrlxpRpY0Kvql8yNBVRV6J5OZHSh1PpqxQJWc7Z1UPm6LAg21ibeYhuAZQsWEot4qsYl4yG1ndVCKudFvtVBqZ0WWKP+Bc89wNVmC0bxUfTBkuZmFtRoYjZHRZ6UvcXLPJsTEkXfvnNflkIc6z/W8mcrLW7nhGVM0yebLp0BnmaPrAmJ0r8qUt5D53Ae44GJAlgEq5SCFyyCRiLi7PoSvPUt2PwM0klq3egqqz3jT41y9sfr0g+7hyZiCHqpJ7lWPuhZB4jliWj8fMNdRpfxVMr8GY6CgsPSdaGn0o7wgXKgFoY2RkDUjnscMhPthH10lMZuDGn0LFcEhw6M/4xNsom3Qs3JMoNwKmDNQsLzjHOIMpPxfEFeqZrGmD4xpMkzKXP8ECwJ6iI5aVwqYOs1tLjAXcP/eSJHiWQzOx5b1xKb0ugga3hLpiyb/VQvztN3LSsLHfPQnql9sbcVfW+Xv1tZriQwyGIHdgaiEnKqj9NBUcPCxPDnI71SFZwXhHWb1cc0NQjiDhMYwOBMhs/TRsmHoa2ooCVsaUrQrYjEkyqZ7T30w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(66556008)(66946007)(66476007)(316002)(4326008)(41300700001)(110136005)(5660300002)(31686004)(2906002)(8936002)(8676002)(54906003)(6486002)(6666004)(478600001)(53546011)(36756003)(186003)(83380400001)(6506007)(26005)(6512007)(2616005)(86362001)(31696002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZyT2xVR0FHMEpCaWxSTXFGcHlQZGNlN0lCaTVJSUozL0RJNWM4ZE81M3Ba?=
 =?utf-8?B?cThFL0tFQTBEaDhqTGZ6cTRUYkMwZlBubW1xNWpraXVXZHRHd1BOM2k5d1JY?=
 =?utf-8?B?TWNxOUJxVmdJUDQwZlkvOXQzQWhIcEZRZURiZ0RBTjBTMGJqK3gzSHVIOFpr?=
 =?utf-8?B?UGhKaXZwZ3h0SVp3YWM4d1YrRU9MSHFicVZIVUxaRFRpb0dlRWhmbG9IVldl?=
 =?utf-8?B?eUZYT2tDQm1SbnhBSGVGUll4ZlVzMkRRN2VKVHdUYUlNY0VuY1pEODc5ZXhn?=
 =?utf-8?B?R2pIRlpZVFlqMCtiZ3VUZmsvcm1WWmYvYkorQjZNd015K1lDN0pVcjg4anhu?=
 =?utf-8?B?V2w4UjB1NDBsYWlzRVBxQ3gyZ1F5NldvTlNiS1NsUXIwUlYzZGdITHJwdEJL?=
 =?utf-8?B?eTNvcjhldlA3WnZwdlQ5L0tBNzBObnp1WDNiTFd5VlQvbXRQM25rWmJoNmo5?=
 =?utf-8?B?NTZQdGYrd2liRkxLb21vTG9pVW5LSG8wRHpFUzI0VVlaUFIrdzgwMGdhSVNy?=
 =?utf-8?B?MjhIbHRqODdqU0ZLMjVMWUUwT2pTL0ZGK2lxVUVSTUU2K1dSV3hlb2FFNlRj?=
 =?utf-8?B?bWdreW15cXBvbW1mbllyVG9CTzVvaExqQndzMG5zRHhzdmdvdDFoTUo1eG1L?=
 =?utf-8?B?bk5pMENQemlMUUJDV0pTVEpOQ2E2VEFHL0UwaUJNWDYzdlZUNUVNUlhLV0dF?=
 =?utf-8?B?aUlUOHdFbW5vcVVwcS9GMDBldGtodWxtZVF6TllQbDBBYnRGM0taUmoxNmkv?=
 =?utf-8?B?UUptczd1bmJ1MTJjK1BhdWoySjlMdTdOZnd5UG5UVmhhUXZtd2kraUx2Nmc5?=
 =?utf-8?B?dDU5dUlyc3N4UzhIVHd5dEtEZDZYdFJBdmxzd0wvNzZoOHVpSmx3ejRZazRS?=
 =?utf-8?B?K0RZZzJyQW4zZXkyRjVVVStXUGlLOXdaeFdHa1poOGtkVXBQdG9lL2xKR1pj?=
 =?utf-8?B?M2pHc2hQUUxEVm5CWU93NGpneTVZUWdobEtodm5IZm9TNlhraEpIaFdhTFBR?=
 =?utf-8?B?VldCSlhObWJXZGdHczlvL2k4OCtmMWhoRkxGSU5CSmRHOGcrbk14Zmp1aWZB?=
 =?utf-8?B?czVuaDAwL2RlNDN4ODQ1dUZmSFZvVXlhSmpSNnVjM2JMVTg2U1plVU1EV2o0?=
 =?utf-8?B?eWhGMGdHL2ZVbUJhQmJjUzlKZ0t5cjRBb2NZR1p5OUJ0bWlyVmxWQmVvc09P?=
 =?utf-8?B?dGYydGxZdGkzMmw2b2NiS1RRSVdhdjJZRjZmeXA0am5hQjVPT1RYTHlPbmN5?=
 =?utf-8?B?aTl0S1duUkRCOVVvQ3doSGIxZDhIRXU3K21EZ1liN0U4RXJaUXBHSkQ1U1Ez?=
 =?utf-8?B?em9lZzNPMnpYU3E4d2ZTM0hacWE5QmpDakl3YVVqc29hM0l0U2NZMnFMNStn?=
 =?utf-8?B?L2Noc2dSUGd6a1JSVDBUMnRETllLZWs3aHV0cm1ublpncUdaQUxxekYxRkJH?=
 =?utf-8?B?SXh1QVQzTGdkY3ROL2dCbHZ0NEtLcWNDaHAvT2tDYWVKb3JyNFlOSmoreEtY?=
 =?utf-8?B?cmRmdXJlVjZoUWg1SG1mMEFkSDZqWCtyeEI4RVVKWjJPdnozRzFUYVNjbnVy?=
 =?utf-8?B?eFlYMlYzWEVTVVBweHBodlllc0J6TngyRExCdDhkZkhNWTBmdmVCUlNwZzI1?=
 =?utf-8?B?M29ZL3ZaR3pmcEdwdDI1aG03cFBtR0JiZm1NM3N0SDRNZ0FIbkIrRFRSYmJw?=
 =?utf-8?B?d21ObERwRDNnOHZ6UVM2Q2xXWThVa1lZNjI2RGJvcGozK1NuRVQrLzd2U3dD?=
 =?utf-8?B?cnY4RnJFUmhmSlQrM3EzclRuVlRnZEpiVXBRL2dod2tIenlNRXlkeEd4aFI0?=
 =?utf-8?B?MldaMGZNRkU2RHVWMnZLQXp4MXVJeXdsTU81RzF5SCt0aThReUE3eE9mUE8w?=
 =?utf-8?B?dXIvRGJMQkJNbnVVV1RvclBhL1lOMW1Id3RLbzBmQ2xNVlZNSDNzMGtQYmhy?=
 =?utf-8?B?VDY3M2NYRjRlcHZZYW1jenJ4bWpKNzM2TGVadkY5Sk1FNXB4eDd0a0xaLzdS?=
 =?utf-8?B?YldyRlVFUy92dWZkc2x1VlhPWkF2ZWtIbW5KSWNJeWwwUjBmOEJCT0tXY2RT?=
 =?utf-8?B?SXhiL3RDSGhhQlNRSWlZNjJIMDhLcnJweHdtNUc5dCt2RWpmWlorRWF3alVS?=
 =?utf-8?Q?owwGy2TDhB6e+DFm6N5FUEGIE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3873d7ee-e864-457f-9a8e-08db632e7f9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 05:59:16.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aRFjp/I9LBz7I+DDx5g8WPjqwvRsjKIAYj+7xEucgmjqwxFqrpqcC9XXujjhlZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
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



On 6/2/2023 11:26 AM, Chen, Guchun wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
>> Lazar
>> Sent: Friday, June 2, 2023 12:00 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>
>> Subject: [PATCH] drm/amd/pm: Fill metrics data for SMUv13.0.6
>>
>> Populate metrics data table for SMU v13.0.6. Add PCIe link speed/width
>> information also.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 108 +++++++++++---
>> ----
>>   1 file changed, 67 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 75255e0baf91..4ff5a66d446a 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -80,7 +80,10 @@
>>   /* possible frequency drift (1Mhz) */
>>   #define EPSILON 1
>>
>> -#define smnPCIE_ESM_CTRL 0x111003D0
>> +#define smnPCIE_ESM_CTRL 0x193D0
>> +#define smnPCIE_LC_LINK_WIDTH_CNTL 0x1ab40288 #define
>> +PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
>> #define
>> +PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
> 
> I see in smu_v13_0.c and smu_v11_0.c, the same macro definitions are present. So is it better to put it into a common place which is scalable for later asics as well?
> 

These are reg offsets and reg field definitions. If there is no change 
to those offsets/fields we reuse the common smu_v13 or v11 versions for 
SMU13 or SMU11 family.

In this case, there is a change.

Thanks,
Lijo

> Regards,
> Guchun
> 
>>   static const struct cmn2asic_msg_mapping
>> smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
>>        MSG_MAP(TestMessage,
>> PPSMC_MSG_TestMessage,                        0),
>> @@ -197,6 +200,7 @@ struct PPTable_t {
>>   };
>>
>>   #define SMUQ10_TO_UINT(x) ((x) >> 10)
>> +#define SMUQ16_TO_UINT(x) ((x) >> 16)
>>
>>   struct smu_v13_0_6_dpm_map {
>>        enum smu_clk_type clk_type;
>> @@ -1935,6 +1939,16 @@ static void
>> smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
>>
>> smu_v13_0_6_throttler_map));
>>   }
>>
>> +static int
>> +smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
>> +{
>> +     struct amdgpu_device *adev = smu->adev;
>> +
>> +     return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
>> +             PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK) >>
>> +            PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
>> +}
>> +
>>   static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context
>> *smu)  {
>>        struct amdgpu_device *adev = smu->adev; @@ -1953,8 +1967,12
>> @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu,
>> void **table
>>        struct smu_table_context *smu_table = &smu->smu_table;
>>        struct gpu_metrics_v1_3 *gpu_metrics =
>>                (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>> +     struct amdgpu_device *adev = smu->adev;
>> +     int ret = 0, inst0, xcc0;
>>        MetricsTable_t *metrics;
>> -     int i, ret = 0;
>> +
>> +     inst0 = adev->sdma.instance[0].aid_id;
>> +     xcc0 = GET_INST(GC, 0);
>>
>>        metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
>>        ret = smu_v13_0_6_get_metrics_table(smu, metrics, true); @@ -
>> 1963,51 +1981,59 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct
>> smu_context *smu, void **table
>>
>>        smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>
>> -     /* TODO: Decide on how to fill in zero value fields */
>> -     gpu_metrics->temperature_edge = 0;
>> -     gpu_metrics->temperature_hotspot = 0;
>> -     gpu_metrics->temperature_mem = 0;
>> -     gpu_metrics->temperature_vrgfx = 0;
>> -     gpu_metrics->temperature_vrsoc = 0;
>> -     gpu_metrics->temperature_vrmem = 0;
>> -
>> -     gpu_metrics->average_gfx_activity = 0;
>> -     gpu_metrics->average_umc_activity = 0;
>> -     gpu_metrics->average_mm_activity = 0;
>> -
>> -     gpu_metrics->average_socket_power = 0;
>> -     gpu_metrics->energy_accumulator = 0;
>> -
>> -     gpu_metrics->average_gfxclk_frequency = 0;
>> -     gpu_metrics->average_socclk_frequency = 0;
>> -     gpu_metrics->average_uclk_frequency = 0;
>> -     gpu_metrics->average_vclk0_frequency = 0;
>> -     gpu_metrics->average_dclk0_frequency = 0;
>> -
>> -     gpu_metrics->current_gfxclk = 0;
>> -     gpu_metrics->current_socclk = 0;
>> -     gpu_metrics->current_uclk = 0;
>> -     gpu_metrics->current_vclk0 = 0;
>> -     gpu_metrics->current_dclk0 = 0;
>> -
>> +     gpu_metrics->temperature_hotspot =
>> +             SMUQ10_TO_UINT(metrics->MaxSocketTemperature);
>> +     /* Individual HBM stack temperature is not reported */
>> +     gpu_metrics->temperature_mem =
>> +             SMUQ10_TO_UINT(metrics->MaxHbmTemperature);
>> +     /* Reports max temperature of all voltage rails */
>> +     gpu_metrics->temperature_vrsoc =
>> +             SMUQ10_TO_UINT(metrics->MaxVrTemperature);
>> +
>> +     gpu_metrics->average_gfx_activity =
>> +             SMUQ10_TO_UINT(metrics->SocketGfxBusy);
>> +     gpu_metrics->average_umc_activity =
>> +             SMUQ10_TO_UINT(metrics->DramBandwidthUtilization);
>> +
>> +     gpu_metrics->average_socket_power =
>> +             SMUQ10_TO_UINT(metrics->SocketPower);
>> +     gpu_metrics->energy_accumulator =
>> +             SMUQ16_TO_UINT(metrics->SocketEnergyAcc);
>> +
>> +     gpu_metrics->current_gfxclk =
>> +             SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
>> +     gpu_metrics->current_socclk =
>> +             SMUQ10_TO_UINT(metrics->SocclkFrequency[inst0]);
>> +     gpu_metrics->current_uclk = SMUQ10_TO_UINT(metrics-
>>> UclkFrequency);
>> +     gpu_metrics->current_vclk0 =
>> +             SMUQ10_TO_UINT(metrics->VclkFrequency[inst0]);
>> +     gpu_metrics->current_dclk0 =
>> +             SMUQ10_TO_UINT(metrics->DclkFrequency[inst0]);
>> +
>> +     gpu_metrics->average_gfxclk_frequency = gpu_metrics-
>>> current_gfxclk;
>> +     gpu_metrics->average_socclk_frequency = gpu_metrics-
>>> current_socclk;
>> +     gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
>> +     gpu_metrics->average_vclk0_frequency = gpu_metrics-
>>> current_vclk0;
>> +     gpu_metrics->average_dclk0_frequency = gpu_metrics-
>>> current_dclk0;
>> +
>> +     /* Throttle status is not reported through metrics now */
>>        gpu_metrics->throttle_status = 0;
>> -     gpu_metrics->indep_throttle_status =
>> smu_cmn_get_indep_throttler_status(
>> -             gpu_metrics->throttle_status, smu_v13_0_6_throttler_map);
>> -
>> -     gpu_metrics->current_fan_speed = 0;
>>
>> -     gpu_metrics->pcie_link_width = 0;
>> -     gpu_metrics->pcie_link_speed =
>> smu_v13_0_6_get_current_pcie_link_speed(smu);
>> +     if (!(adev->flags & AMD_IS_APU)) {
>> +             gpu_metrics->pcie_link_width =
>> +
>>        smu_v13_0_6_get_current_pcie_link_width_level(smu);
>> +             gpu_metrics->pcie_link_speed =
>> +                     smu_v13_0_6_get_current_pcie_link_speed(smu);
>> +     }
>>
>>        gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>>
>> -     gpu_metrics->gfx_activity_acc = 0;
>> -     gpu_metrics->mem_activity_acc = 0;
>> -
>> -     for (i = 0; i < NUM_HBM_INSTANCES; i++)
>> -             gpu_metrics->temperature_hbm[i] = 0;
>> +     gpu_metrics->gfx_activity_acc =
>> +             SMUQ10_TO_UINT(metrics->SocketGfxBusyAcc);
>> +     gpu_metrics->mem_activity_acc =
>> +             SMUQ10_TO_UINT(metrics->DramBandwidthUtilizationAcc);
>>
>> -     gpu_metrics->firmware_timestamp = 0;
>> +     gpu_metrics->firmware_timestamp = metrics->Timestamp;
>>
>>        *table = (void *)gpu_metrics;
>>        kfree(metrics);
>> --
>> 2.25.1
> 
