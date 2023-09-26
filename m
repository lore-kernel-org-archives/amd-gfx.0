Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F773E7E622
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 11:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E89810E3AC;
	Tue, 26 Sep 2023 11:16:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25A110E3AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 11:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPJNY6rJ29KCud4wsoC9IQfRJ/1KnGNiKg/g3avi+EhDbbJpwnd8PYS2Qj2vJ42ebVk+zvJyQ1zHrlb7kHN8bVfNfe/pzaq7D4PjscArAq6fwoNwV4nODDUiQOPi+4RPH/WqGXSoT/HWEy+CJDYXNthXGeq12BTa7poP6jMX0ZFwAzZEtQcdLeiTX+hoQFeeFftgJGyWbPea2JrhtgTtIdG2t3U+Otn4GqhJhET0g11OI4HnBzyluFQVXxVxXG6dJLUbwQ6jU1j7JPQbYxzcfz0EfVIEpxtSQrffG0f11aq2lUKJZkFw2iVT2HBm8VUDX0yN1A5vHUSOyJFBWyVDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9oxaedEVRQYLLt9Df/OzMYY8BhE+bZuZRgIdOnVJFc=;
 b=kFqNXxRgN0fIz21AiPaYFodlpZjmTmA3OFyocMYMXtM4XMbOg8BMvnauNR82gv66HrTixUdDei4xrtbULcQU2SMMD3hzJpyH6XzBh4sKfuGYlJoopTJJuLSUYxRcBy72fws/zbI7NBduRyt3upbcUsdRLkFcly8QCPdBLZMie9K+pUIFLGU8Wm0mEZLEQMKUMcvCLAY5Lt3AGOlrG90BYlPqSyppC/oi6tiEQBxHu9FC2GQBiuuY7Y91OZleon59cWGOVhuHFUAZQEYEVFZKXug2LFwemPXCkKxjwjS9VJsoXctM/4qZRYVnYWmtszmdNqzcQk5ntGf+hoedRchi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9oxaedEVRQYLLt9Df/OzMYY8BhE+bZuZRgIdOnVJFc=;
 b=h2mbgPNLhHJBQZYeVA4DNE/mhL5CcqoWPFws/Rk2pyPjGC4PlSM0jSzFfR4ZlSW2hgg2j6ywuv1uXh3nE0hS3JeA8YMk5iA+jp4XEwmrD8s1pfDpb28RdmfxBVtEUmOpGo//vZ03dP9HUYYER9WLfkn/RxQ4uvDLRo60ck/6hGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Tue, 26 Sep
 2023 11:16:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 11:16:37 +0000
Message-ID: <b09015c1-71ec-5d43-abfa-1a4bc70ab38e@amd.com>
Date: Tue, 26 Sep 2023 16:46:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/1] drm/amd/pm: fix the print_clk_levels issue for SMU
 v13.0.6
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230926110249.5071-1-le.ma@amd.com>
 <4483780b-cb29-5d74-b973-daf45976d124@amd.com>
In-Reply-To: <4483780b-cb29-5d74-b973-daf45976d124@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 80406e72-8fd1-47dc-0e75-08dbbe820c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sk8PdlYa/4fc3ckkaZaxb9SrQLnCzJMp6zqNI6iCesXbI3xp/e/ZoKf1nMneoY+yrULF1u1Amqpvn4sDEjGD/CfzfBKPMKgisjd6PGJ7/Jg0dRqagU7mbonpWEieWfY2ewnjHBKJuDC/LbuebCyyKC9WPHh5GQo94YqLlGpcOixv2IQJWZxZBSv5jg2EnZkO6X5wHlZ1AqSCqm8L5+8yOHcgNQKZDvchl3TyMl7iU/9Q98wEng0T4KHmfFrDkCUfzja3SEuknmQcM788/SRy7B4DHaX/uB2mfYmWL7z87Rj7S3ChaJmukdnJHv8HUHZwjwrcEvI9ZrbP4C7aWI3eZ9bocXDcOEvpeccklOCBH8qb9dDCvGd69uhP6WgN6WhO2n0HbzkgGOBi54wO/VJ3HDQq4B02k98i6RdL0hV2usZxp074F6UFaHZQ0t5d+SnA9S+dPr4WVR1fyWQj0MJYs00sJ8fLaW7lUn/IwEi22RXgWXnONnd5XApe1IqR8e95QC6lJVmR0auZInbM/1LCCntw4zlJkG4b5mBnbqa0C0OySJtMyORc7I66s5dBOAs/Rwugx22t4+bgyHwWt/yfrvN9/rnPRPpcsgM0cdbavvdHKCUCQuT8ysblSlpXbYjKa+djH1lcF7j3BBgJARIsyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(86362001)(31696002)(2906002)(31686004)(4326008)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(478600001)(6666004)(83380400001)(26005)(6486002)(6506007)(316002)(36756003)(66476007)(66556008)(66946007)(53546011)(2616005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09acG5EYVpzM1dRTUZFUXVzZUdROTBwSTRENUhBYTk5K2xNL3l1N3JuQzNW?=
 =?utf-8?B?bG9CYWVGQjUxRGZ0ZGxqTE9lbkpIN2w4U1lsT09xR09Nek1jYVhibDVlR2hG?=
 =?utf-8?B?Y0JFV3hhVjFGRXlRYVlyZE9mSUJqTzNQY29KWEovZklubmVyaVdXNkg4T1Zi?=
 =?utf-8?B?Z1RlRGFjamk1QU9ZcjZnb3dSRi9MZTRuTVJlSkw2R05ucVdtLzNnWXVKSTBx?=
 =?utf-8?B?bzRmZHRwQi8yQnRGY0V5SkJrWktMU3FnbWtDM2NkcmlwR1hlb0Zjd0ZnR2xC?=
 =?utf-8?B?Nk9uSEtBRU03emlJVTNHUkMzcEpqYmxnNjlqbCs2aHNPMGVaZEJkVzJya1h0?=
 =?utf-8?B?U2x0dU1aU2NXWVFOdWdEcXc0UXplemFzS3RiT1JWZTNvK0JhZkVjU1NTREZm?=
 =?utf-8?B?RjRwdUJOZE9KUjNLWFlxbjNDZEtlNXBoZGxOQ2ErcmhoTEtmM0JZdkFxRGlt?=
 =?utf-8?B?RE54VmQ4MkFQc0FUR2lBSjhwVXRMdHE1MjBHU09qcjhSWVhjRFB0Q0tmS2NI?=
 =?utf-8?B?S0hhWExud0UvNzVKdmhFdkdrMXhseUFHMTBDNXgrOU9IRENhcE5wSmJhVmdS?=
 =?utf-8?B?eU9YbHZvSjRlNU03QlpyZnNXa3NTdVlSc2NpdmFIUXlyTHhWMU1QazdxK1FR?=
 =?utf-8?B?YzhOZk91YVNRb3JoZlAzMGpBZVp6VUJSamxnaWJDaklxZTB3UXNSWkJjbW9K?=
 =?utf-8?B?QmE2UndHNGhzOGdnU24wZXdIdWlEaGo3S2FkMGZRN3psaEJWd2dLNm9id3Fw?=
 =?utf-8?B?b0JtUnhwSFZpYlo3N3RIWlhPQzJjTTFyQXdXSUI2VmwxQkxIUVNxSUtxSTNL?=
 =?utf-8?B?aW1XcFVRemVadkN6cm1xWjFUUU9wZlZBcXJSN0xZeU5zVjFNaHBnVmJrMDAw?=
 =?utf-8?B?ZWRUTjJqS09CcmlOODZvdjZONEM3bVp0N21BL1ZFYkl6KzNtcERYeVpsZVJu?=
 =?utf-8?B?cG05STAvS0tCWDR5aHdkdFJGMEVHUk9xMlloQWphbEFVSldoNG51bGhJYW9O?=
 =?utf-8?B?QzVrTTBKUHRiYit1T3JoVjF4d2dmT2VRL1NtY09xK2thcUhFbzNnWlRwVkov?=
 =?utf-8?B?SWVJK0JlZDcvYUlsTzY5MzRQdjVxeFlGMlBmQmViMmdoYldUYkpqbzhkRUpK?=
 =?utf-8?B?MFZ0MDJqaXVTNmxjWktpNEU0R0dCSDNxdnJmWlI2bVd0MkJzNGx4ei9URU55?=
 =?utf-8?B?d1V1eCt3YnFneVBYQUNTZ3p2WWJQM0VHbHpFWkFHeWhQOW9JQ2UrTzZlSGpR?=
 =?utf-8?B?QXFZbmh0UXo1dFJsZUdjZTZxZVdNQXRyaUV3UzJIYWVPVUs2ZUQyRFBNbXJJ?=
 =?utf-8?B?T1RuS1VFSmVvZ0F5dzZjcWR1N0JSSlZTODBnS0FXcjVacE1Md0syS2hUWGFP?=
 =?utf-8?B?Tm9yaXl2S0NaZ3FXWlhnT2s2YW56Q3RhTWkwWEwrYnV0NkIwa05pNUp6YkRn?=
 =?utf-8?B?OG5OSHhIOExDbFJZNWFWWGtDYzNvUG9SSGFnZEYxbnVSeG1mZUlOMXRRNkFx?=
 =?utf-8?B?NDhmV2U0ZHhaM2RuL0h4MmF1dXRQVzFLTFJKZ1dHK2lKWndncnVnUHplck96?=
 =?utf-8?B?WFQ0ZjRNWnZXNjZISU42RjZLZWluN0ZHUGhaaGpDSU9wMXp2cEVQQWNhaU80?=
 =?utf-8?B?aWl4ZEpwRnRlV0NaZE40ZnlKZDM2Q1JneVFZdHhnemZsTlNOaHVEUG1YOGRT?=
 =?utf-8?B?VTJjSHVGaHp5Z0Zhd0RBa2RKbUI2ZVFiZnJiQSsxdGhoQW9YVjdoaFdhYXpB?=
 =?utf-8?B?MkxzUm8xZnhZNzA2OFBucEFBbHhBYWMxQiswWXpvcWZiK0tlOWk3VVJUODEz?=
 =?utf-8?B?aDdyN3VuZzhZeUpETkxtbmJjcm41VFNPeHZtZWJsRzVFcG8wYzQ2Y1gyeWF5?=
 =?utf-8?B?V1BaTmlwYkFRaTZFc1hIMjVkTUlvWGJ0MndrZ1pYZGZxaW5TV0pqaWt6TWpI?=
 =?utf-8?B?cW9tclVjcS96N2E5eDA3UUpIY0FTTTJFS3pxS0hzaWdya3dXSy94M2ZrYmR1?=
 =?utf-8?B?K1FETzY3TGN2K1hwQi9BdDlELzlUbmlzR3NxTHB0aXk3SE9aVEVKQ2JZS1pB?=
 =?utf-8?B?VlFuUG1MZ2s3NUc4dmw2NC9vTmZoeXlCQlI2VGtxd2t5cUpRMXdEcXlZS2p2?=
 =?utf-8?Q?m+oQ80+WVYnOEYsHgbjueuZno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80406e72-8fd1-47dc-0e75-08dbbe820c5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 11:16:36.9076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KIFLid1nkVVGLqyUKA6tfvX+pnLgHWhBIL9aiCU4Ye6Ne0SrxnPoFUfNSmIm31R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/26/2023 4:41 PM, Lazar, Lijo wrote:
> 
> 
> On 9/26/2023 4:32 PM, Le Ma wrote:
>> Pass the correct size to smu_v13_0_6_print_clks, otherwise
>> the same place in buf will be re-written.
>>
> 
> Where is this getting affected? As far as I see, there are no multiple 
> emits to the same buffer in this code path.
> 

Never mind, found one for OD_MCLK.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> Change-Id: Ia0e12430d01146a11490204c1bab4b4f06cd17ea
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> ---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 11a6cd96c601..19c117eb5ebe 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -821,12 +821,12 @@ static int 
>> smu_v13_0_6_get_current_clk_freq_by_table(struct smu_context *smu,
>>       return smu_v13_0_6_get_smu_metrics_data(smu, member_type, value);
>>   }
>> -static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf,
>> +static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, 
>> int size,
>>                     struct smu_13_0_dpm_table *single_dpm_table,
>>                     uint32_t curr_clk, const char *clk_name)
>>   {
>>       struct pp_clock_levels_with_latency clocks;
>> -    int i, ret, size = 0, level = -1;
>> +    int i, ret, level = -1;
>>       uint32_t clk1, clk2;
>>       ret = smu_v13_0_6_get_clk_table(smu, &clocks, single_dpm_table);
>> @@ -947,8 +947,8 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
>> -                          "mclk");
>> +        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                          now, "mclk");
>>       case SMU_SOCCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, 
>> SMU_SOCCLK,
>> @@ -961,8 +961,8 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
>> -                          "socclk");
>> +        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                          now, "socclk");
>>       case SMU_FCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
>> @@ -975,8 +975,8 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
>> -                          "fclk");
>> +        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                          now, "fclk");
>>       case SMU_VCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
>> @@ -989,8 +989,8 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
>> -                          "vclk");
>> +        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                          now, "vclk");
>>       case SMU_DCLK:
>>           ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
>> @@ -1003,8 +1003,8 @@ static int smu_v13_0_6_print_clk_levels(struct 
>> smu_context *smu,
>>           single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
>> -        return smu_v13_0_6_print_clks(smu, buf, single_dpm_table, now,
>> -                          "dclk");
>> +        return smu_v13_0_6_print_clks(smu, buf, size, single_dpm_table,
>> +                          now, "dclk");
>>       default:
>>           break;
