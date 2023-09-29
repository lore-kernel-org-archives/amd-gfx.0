Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782EAE71D56
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 15:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9DD10E11F;
	Fri, 29 Sep 2023 15:25:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D4D10E11F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 15:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3XMu4zjhj/TgBADVhb0L+R60zxEbnMC6K6W1Jmv2zQwbgGqsJt5RxmnRL0IEPbXc4rwlIXIKzH4swGyCsJO8SNu+HXv2gWoD6rP1xn9uMWt7rxArIbnh8pSuMzyytrKELACwwKn7i8NEV5/HcFKi2Vx74INHj5Izv1eeI+c6zynfnG+CBsc8LX6dwPzLSbeI1AHLJapJHfxi5IjPOP7lBlh5rpolNA2rUs1fUkDb5IGm98Rpm+efSJvYrgxBaw9dpXt/nwufKnIgF7HhA8QKYTtUZLwCdzn1/vkj6za8z9I/MpofE/ceYgJobavFopeaAqCY6aNk6z7BlER8Fqkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVKWy6AoPE4vAkhRuWDqUgoZYOXQcIzrPgJ72Ff/RZw=;
 b=jXWajbCw29rlh3izFE4pIlHrgKXb1rnUDEPtIWBAO3RZJR4hZIX+YyEm3AsLjiwfp6jUQm/AoFeTt8950VNxbs0Q/C+jP06sbIpNwwh8/r1xTgnTbY4a94LsG6HNtKmSYh2Mo8CKhgAn5M5DJCUT0lS12LsVEsmEOQHT+Eu/7BpBui0evscKu4Xpq1sBT2RLfGjhDL5502xY367XiLlPepr+Mnwkfv8vxU9Y9z/1TVRowChBlQzwPmuR1Kh0nnW9l2Pe8PNK2D508dpwvtirhK3gxrpJ4X+2ap54fra9IJ6VLZRpwatZf+hzAPqZ8NfYWMOVYUYEYt5l/Phefd60rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVKWy6AoPE4vAkhRuWDqUgoZYOXQcIzrPgJ72Ff/RZw=;
 b=oicy1H+8EF9RrOAvVeNIQz3pyWg334HOxlaAqnY6YNn2E94CPovR6/QsHEC5jPmSqs76Dvxk8y/mO0rypEONQX9tp8W7c7jQAQ0MV07OcNvzXn8Y39nitm/sqpFPn4rtU4ho0MKGUjHgHyb0O8Ibg+j+m2Mff+pdfySUIPKyx2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 29 Sep
 2023 15:25:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 15:25:52 +0000
Message-ID: <79e3d074-33a7-4a84-a575-99a9afe191c6@amd.com>
Date: Fri, 29 Sep 2023 10:25:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix logic error in
 sienna_cichlid_update_pcie_parameters()
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230927020743.387802-1-mario.limonciello@amd.com>
 <2bf271de-c020-4d95-96bf-7d488d5d14c9@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2bf271de-c020-4d95-96bf-7d488d5d14c9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:806:23::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba13652-09f8-401a-f4d5-08dbc1005da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTbJYGatK95Dh8e3qs7ziMlh1Bsz1S3aSaXu62Y35T1wkr+j+smnG34rKfPIxFuVMwhjKo0ztNZQ3mCMVrHOACsu1HjFZXiSbsGmt6Ew8Z8TM9SB2FY/Saa7NH9/p/3tPNwPGsr20ymwpMi3VxJnxWot3XU+X5AV/2aCWf2xZtWE9lDhwmvFpWWvC/YCNCbuJBUhnValXWrn17OJczn2R24YO4vciNJNgWzt8ZrVya2oO3v6hLCo4NEkr+72K3YzgYq0+Bm1L/4GKw5vhpg/S/EAQ7RtigIig9XYSQG1IQSLVMkOlenVeicGE3a/U372oPrdMC6wpuCmUqXRphWJHwB/W9y8pvZnLqyHtJj1lattgFGmYWQnCO90qAbYXpySVGyGx8SiG38C1afzYZr5WZ8G24QgkNHzP+6dvrMawL90aSTuUyd65Ihae5dEo0bGaDr3MGnMEAjOFREj5aSDdtE/vKmq4vFuxOucDCa2r5T+DgD3If7jnoytOD1ypVOU4erOl/+jGbfqulWVg8qF9h1ra5dycdCg2U1eQ0JmXssySaFfzZzACs0SoVdxJgPOcdrIH5uJb1ZBIwI11FPx8fKoWDcyS2di4x+tkv7LcLMf0v4bkMDVvJHhanSsGLkH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(4326008)(31686004)(31696002)(38100700002)(8676002)(86362001)(44832011)(5660300002)(8936002)(66556008)(66476007)(41300700001)(316002)(2906002)(66946007)(36756003)(478600001)(966005)(83380400001)(6512007)(26005)(2616005)(53546011)(6506007)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldraDhRamMrbkhyVGVNZ3dybWp4SDZTd05MUHMzdFdiM2x0Sit2TFpPbktB?=
 =?utf-8?B?Q013UFRuY2RjbDZrWjVoMGk1SnBUWnFKVk8yWTQxVi9MOG54YjhRNFhBSklC?=
 =?utf-8?B?OFRlVGE0OTc1VXlqc1R2cUJwdkZ3OVNyczRNUkRaeUdRSERCYVlReXJwU0tx?=
 =?utf-8?B?YnV0QW1ObWY5UHlyS2dJVVA4SnJCUUpBSEgrV1J2dGw3UHgxUlV2VUREV1RX?=
 =?utf-8?B?RDFhR0o1TE5nR2RjaEplUmdDU25NckY2VnN1RUw5cUxxVUJ0eklDakZyeWNV?=
 =?utf-8?B?OW81dVJHK0xFRit1cGxOeUxEaUJMb1hmRTI5Qzd1MytnTVNDVEZDbmRBMzB5?=
 =?utf-8?B?amVUR3pMUjNJVVRsM3pXdjRocndVem5LN2t3RzVYNEpJYmZZOVBLZW5LbWdr?=
 =?utf-8?B?ZFBlVWY2ZGxsNlFueHg2SlU2YllieFpoR2Y2Q3BJWGx4Tzd0Uk1weUkxekF3?=
 =?utf-8?B?U25yRE5FRkhUTFk0bVFBeUJkVVFsSG1rV1EyZjdxZVhKWTlQQkZmMnJ5NEpV?=
 =?utf-8?B?elBGczVPaDRWdUNOYTFULytNV3YzMTlrRzdxK2FHclJ2clFLd1VoSW1NM3lO?=
 =?utf-8?B?ZEs2QnFEYzk0VFRpYktMblFlTnRNRWloMlFRSVp3R1ZGWTU1NlNxenFaRmE0?=
 =?utf-8?B?TEk1ei9UQnpXaUlrU0owK1dmQURLdVFwTXNqc0Z4amdmTnlmbHZTUnJ6NDFW?=
 =?utf-8?B?Mm1qR2V5MnRYK29qdjBja1UrWGhTaEJXaHAwOEZaZjZmbFM0MTA4c01oVnVu?=
 =?utf-8?B?YmhaTTl6QUl3VGxWVnVaR0p1b205dEtKWUJ4bCtjeTQzcjVmYkdLT1J0blVE?=
 =?utf-8?B?VXhlY0RrdncrMEdhUE41aWlONzRLb1NSRndRTXJ1SmZUSmJ5SWI4U0RtZlc0?=
 =?utf-8?B?ekZJYTZGUzNuOEhMVlFrUUtZUWtpWFAvN0hjZTY3YnlhRmIrN2VvZ0FjSHNY?=
 =?utf-8?B?VThJM2lXTXRDSmVEZlpSMStEZWlhQUtEOFJJak9QMzBhaEg5T2NOc3FGMHRi?=
 =?utf-8?B?d2NVc3NERDF6blNiSFozMW9oN1JiZXhSRGNQMW9uZkhPenJVVjM0d0lyMjd3?=
 =?utf-8?B?MjRUZVRJVnYva09SSG9FcUZuS1BJK00yWVhsREJYNm02NU5JQVJxYU15czZa?=
 =?utf-8?B?bkhaTWl4WE4rUm1XUWVPdFpYZXE2WjZsRVg4OUZxbU9hSlJMZlh4bXZueG5y?=
 =?utf-8?B?UzR6UmRyZVdZdVVMS2J4UWtlajVpSW90aTBSanExMGVMM3F1ZUZUZHp6a0xO?=
 =?utf-8?B?SDJsNjNNNVREdzRYRkRYMEtyOXZXSjN1TGw1MjFIWXpmNkw4Zyt5cFAxcTFk?=
 =?utf-8?B?L0duUHBYL3JHUTUxTTNFcXpRa25KeDREakpjYXpvcmEvL3F2c2Z2bEF2NkYw?=
 =?utf-8?B?TzhGaDNXdFk3NkY0dnMrRVYvUG92NFo5a2c3Q0xwRFJzckdOSlBWY01PWnpG?=
 =?utf-8?B?Q1hJa2J3RE1KQWoweDRoT0xuTTh0L3BPdzV3RHRkWlpOOXJHWWM2QmVOT01U?=
 =?utf-8?B?ZytXZzRhMXludzJpNkxUQ0pmMnQzTnR1bmpFdzR3SWc1aWJHNW1jSlk1a0R3?=
 =?utf-8?B?QjR4L0g3OXZqelo0N2NYUUlLUEFVdTVkS3h0Q2tSSUh5dnhONmdSeDVxUHgz?=
 =?utf-8?B?Q0dpa2dSQlF0NXdEWXJyWXMxSGFqdHJuTmUzVzkvWFptREp5aTlxVlNEQ2hs?=
 =?utf-8?B?U0YvTUdGcWpnYzlzY2gvNEh2SXJBVHJJa05UdHR2OGJDaGtlWHl2MEpjSDdW?=
 =?utf-8?B?eWM5UkNEb0ZLazN3WkNQWkVqYzJwRml6cERVU0dRS3dwVTA3NVdyNk5sdGcy?=
 =?utf-8?B?NVkzNXN5T3h1ZkV4RHMwK0xpU3d4TXJmeldibHhDUVBwTCs4Z2NpRFF3cENJ?=
 =?utf-8?B?TW9OMldzNFg3V3gxQXNoM1U1Yk9qM3gyNml6Vm8rZXpyRjgwUzhwZjB5T01w?=
 =?utf-8?B?S1l2WWVOQkJ5Zk9uZ1RoQXVFd0t0ODRFcXh0eXRnVTJVek1hREc4My80VkFP?=
 =?utf-8?B?YmExT0o1aXMvTVl4a3JLMWZUcFJwL0Fyc09RREtZWm51TWJ3VUVsSDFPVmIz?=
 =?utf-8?B?V3NIUk1CQXZWd0lqZWhXQ09hTHRFU3VQYWNVZ0ZVVEs3aitxMVZkVU9GRVAw?=
 =?utf-8?Q?+ujughp71z2vIxrVWh5qyzrui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba13652-09f8-401a-f4d5-08dbc1005da8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:25:52.0136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHUHlmOIVv9i1n1gQlUfBHo4Q5sK4GqBFbULJzmiRDKDbSEOKRVUSylQCli20hWykulOUQ8RQ4Sny3EsGbtA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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
Cc: coelacanth_dream@protonmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/29/2023 10:23, Hamza Mahfooz wrote:
> On 9/26/23 22:07, Mario Limonciello wrote:
>> While aligning SMU11 with SMU13 implementation an assumption was made 
>> that
>> `dpm_context->dpm_tables.pcie_table` was populated in dpm table 
>> initialization
>> like in SMU13 but it isn't.
>>
>> So restore some of the original logic and instead just check for
>> amdgpu_device_pcie_dynamic_switching_supported() to decide whether to 
>> hardcode
>> values; erring on the side of performance.
>>
>> Cc: stable@vger.kernel.org # 6.1+
>> Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
>> Fixes: e701156ccc6c ("drm/amd: Align SMU11 
>> SMU_MSG_OverridePcieParameters implementation with SMU13")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 41 +++++++++++--------
>>   1 file changed, 23 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index f0800c0c5168..9119b0df2419 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -2081,36 +2081,41 @@ static int 
>> sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>>       return ret;
>>   }
>> +#define MAX(a, b)    ((a) > (b) ? (a) : (b))
> 
> Is there a reason why you can't use the max() defined in linux/minmax.h
> instead?

That came with the logic restore from the previous commit.

Likewise we have a:

#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))

used throughout the driver.
I'll send a follow up to clean both of these up around the driver.

> 
>> +
>>   static int sienna_cichlid_update_pcie_parameters(struct smu_context 
>> *smu,
>>                        uint32_t pcie_gen_cap,
>>                        uint32_t pcie_width_cap)
>>   {
>>       struct smu_11_0_dpm_context *dpm_context = 
>> smu->smu_dpm.dpm_context;
>>       struct smu_11_0_pcie_table *pcie_table = 
>> &dpm_context->dpm_tables.pcie_table;
>> -    u32 smu_pcie_arg;
>> +    uint8_t *table_member1, *table_member2;
>> +    uint32_t min_gen_speed, max_gen_speed;
>> +    uint32_t min_lane_width, max_lane_width;
>> +    uint32_t smu_pcie_arg;
>>       int ret, i;
>> -    /* PCIE gen speed and lane width override */
>> -    if (!amdgpu_device_pcie_dynamic_switching_supported()) {
>> -        if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
>> -            pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
>> +    GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
>> +    GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>> -        if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
>> -            pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
>> +    min_gen_speed = MAX(0, table_member1[0]);
>> +    max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
>> +    min_gen_speed = min_gen_speed > max_gen_speed ?
>> +            max_gen_speed : min_gen_speed;
>> +    min_lane_width = MAX(1, table_member2[0]);
>> +    max_lane_width = MIN(pcie_width_cap, table_member2[1]);
>> +    min_lane_width = min_lane_width > max_lane_width ?
>> +             max_lane_width : min_lane_width;
>> -        /* Force all levels to use the same settings */
>> -        for (i = 0; i < NUM_LINK_LEVELS; i++) {
>> -            pcie_table->pcie_gen[i] = pcie_gen_cap;
>> -            pcie_table->pcie_lane[i] = pcie_width_cap;
>> -        }
>> +    if (!amdgpu_device_pcie_dynamic_switching_supported()) {
>> +        pcie_table->pcie_gen[0] = max_gen_speed;
>> +        pcie_table->pcie_lane[0] = max_lane_width;
>>       } else {
>> -        for (i = 0; i < NUM_LINK_LEVELS; i++) {
>> -            if (pcie_table->pcie_gen[i] > pcie_gen_cap)
>> -                pcie_table->pcie_gen[i] = pcie_gen_cap;
>> -            if (pcie_table->pcie_lane[i] > pcie_width_cap)
>> -                pcie_table->pcie_lane[i] = pcie_width_cap;
>> -        }
>> +        pcie_table->pcie_gen[0] = min_gen_speed;
>> +        pcie_table->pcie_lane[0] = min_lane_width;
>>       }
>> +    pcie_table->pcie_gen[1] = max_gen_speed;
>> +    pcie_table->pcie_lane[1] = max_lane_width;
>>       for (i = 0; i < NUM_LINK_LEVELS; i++) {
>>           smu_pcie_arg = (i << 16 |

