Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF29C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 08:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F67910ED23;
	Mon, 24 Jan 2022 08:30:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB80B10ED23
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 08:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFPdp1R0t1nH7r/UvpRxRkhcgPaTNPsBTjX1BEKIMfXNABKArYgB9zUZf/bYtzASlFq1aQ35GPFOhPjxzuI/9orfhAk4gIo4M+Q7KGIbBKpBa9M2+MnekMHpTvw0K5504Uc1jBFG0TCAjwf6O9pXBAGABDWiORZUOIqTeW9gqDenxzmitRszKZ5XTqEKDN/Ukk2LD3BNPz4KUQ31kKjl9y3758wpOWPhUc9klzEJQqEMbcZ8/PQIAh5leGIIyVtJrYqieg1ID3FI8QpvAoXQ0e/QDH3BjjHcGpT0VE6QX3iIEpkv2swBYe5mZEL+Xy/aJVwxUrledklwpUNyLEJcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSIYvkXVA7wVHGSsiT+zM/xeCVKeP0vrZq+OFbLOPzk=;
 b=j2LDPYQpqJ5tTB9LQBLyiQE4nrqJWN7zKZt5xJk57so+P2e/IW5bx317ySeLXTqlLAoLiiuRAiglJVU2OkG5r7xGGBse7w6Oxw3znYETBlm3lcpAB9FX4R9TOj0ggdLDhZ2S8mrUaVd0zWrct4jgYkXfmAMheARUSpBSRC+taEw00dY8+5sGpyFX37ZnMps7/uog/TnJa+70SdO/GP/xv1C+7McVwd8U9te28ZOZJbdYvU4qNtZE7DOnf+vOI5XNRPucjaVjmuGArnAzQtMh6h+XxFHAkw1AIUePDN8WsDtttyAQ/4Em3aDLR1zVfFeLjLVAYq0Z+SXIVIxyfTzyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSIYvkXVA7wVHGSsiT+zM/xeCVKeP0vrZq+OFbLOPzk=;
 b=kOPx8+i9erzvQLlbOM81uHhSb+WGc5pNbaoggCWs7THgKREwr+NmbaEIlHf/SWAICQmOQ5U+QgwG39DCcH5RKBjOrGh1XZzABw++AzpdH4nDA3f75hlnCest9c6C0CPy5xGr9a72hi0i/iG8vk2FXmM+vDv+BPwAPJQa1FlzTrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN8PR12MB4769.namprd12.prod.outlook.com (2603:10b6:408:a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:30:15 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:30:15 +0000
Message-ID: <a6c49bda-cc66-2426-8927-2c461d63ecef@amd.com>
Date: Mon, 24 Jan 2022 14:00:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220124064342.273055-1-Lang.Yu@amd.com>
 <88fe897a-4866-7275-62c4-bdd027789f2a@amd.com>
 <Ye5g71hOdQZmABYO@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <Ye5g71hOdQZmABYO@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::26) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a6d20d-767e-42cf-6943-08d9df13befe
X-MS-TrafficTypeDiagnostic: BN8PR12MB4769:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB476923195246B462742914FA975E9@BN8PR12MB4769.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0t65PFeUfwkWYAYXE+Kbd+rF1PpK9SqY9J9v8ms/JFTDhrjK9SYyFq2Rkhfs12iAu1pSPdaXr9TH42bH3AttEigAMNeQDJaUSkN8+Uvm56v4d7FTeBIOVjDCWDLWtM261Lqq4imgNU+4O6KOgxqs+eT5uvyAx1/eTMIe4DQR5SyZOItwEsnhvcoac3jTGIu9TJDWb2+UvMREbAa3MMUQqVwLjdDNwLgJW/zkUdcJUeVf6ObMtBQ9eX51eoc1qHe7tIFjFkol/Kri/toARWsCp+s8Q92fecqqQ2k2/pTQDitoY6Y1GUpuDYyMtq3N018u4n/nEHLw2jI/iz+RQZNO0yPywPBtStsaf801a1XhPzirDqQoR/zbkJ8gdJrbl4w2u3f8/c/ULfb3E44IuZt6ILbPoW9uItTSPGRbPmZ0t3gm2d+R9Y42CTerc2c7+YZsFs0UC/XPhu6ZpS5qXyT4NqNwLv25RGpiQyDKaUmD5rikqe7Wi1OPvVftJK7U2DGs0iGpX/JtSdi6sy/pxhDuRLKjYTcZ6lglocjZmJF8HT0L59Ltygxnfq9LAewFK809PAmylYoWwTL+n0p36zAkDE5CZN9hc3BCwH81Vi2Hl3GhlVbUheU0Ce8IVXb4HuoMOJIsekPa3UdBQeTDldRTSKKY6zVjyhcJRTvJ01te/X78YheY8J7XnyPIjuS8GjBrXjPtxtfpXA0FNFGEaFP3CHy3JFCwV0PNuUS0Wanr/c/hiA3k+D07PdGBZKDZZLzc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6506007)(66946007)(86362001)(26005)(31696002)(53546011)(8936002)(186003)(6512007)(6486002)(316002)(4326008)(508600001)(2616005)(6862004)(38100700002)(83380400001)(66556008)(31686004)(6636002)(6666004)(66476007)(8676002)(2906002)(54906003)(37006003)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBZOUtCMVRCNnlqWXovU3REUHQrK3d6Y1ZlSysvSUJrUkdCaDlaeGVGdkww?=
 =?utf-8?B?R0p4NU9nSE1aR0JjY0xzWHVFQnh4NVN1c1FodFltTEVpOG9paWlFcHl4TmRr?=
 =?utf-8?B?aU9zeWJOSjN2ell0cjA3YWtNM3lJVHpIVEthVFBHYlpOWjkzSmtaNEhFQnJS?=
 =?utf-8?B?L3R6QTlFQllRTXcrNVRlNE15ODVXVTRNZjErNlBjbXJCU0hoeW9VQ0NNTlNu?=
 =?utf-8?B?dGd0eXdGSmpqbFJEckx1TkxEdjA4RDlRaWxjbGtHNVJRTG9NZzUwS3JaQVFn?=
 =?utf-8?B?Y0QxTjJXMzlCaEJvTnkzbVhrYnhzUm9UVVFYLzlFVzd6S0hBQnhvVm81ZFEw?=
 =?utf-8?B?RThaRUtZTkhUd2ZXeHM2N2E0bFNtdTFsYnF4U0N2MDRDQnlEalVTM0xBLzRi?=
 =?utf-8?B?SW1CeTJVa1daVWRXS2hHNi9weUtybmJHUGU1aFdPOWk2czBSbXlwMHZDOEpx?=
 =?utf-8?B?NmJrYlljWndGZDhXRGN0aW9UWHhzRzQyMklWWXpwRzRVODZ0VTE0VERJOXdJ?=
 =?utf-8?B?RzdpMzVqdzRoczRwY0ZTT3huT2xJWGMyRm8xRUgxVEhCN1drcmhUSlZ5MHFJ?=
 =?utf-8?B?UEpOb2M5T1poUkgveUxVYmJXSmNEKzJjcmtSVlU2eDJPc0QvZlJaemhzQ3Fq?=
 =?utf-8?B?eEQ3WSsyM3ovdFlycjZZY3pVamdXUkE1N0s0OUZSTml1cDlSWVJDVk1pcE5B?=
 =?utf-8?B?Skh2TzRoVnNhdHpGZzRhZXNYd3pGZFBFNjNnTEVOdWE2VEwvTjhrSThXT1dT?=
 =?utf-8?B?SCt0b0lHQjZYMy8zS0lobjdlSEp1Y2l6WTJmV3pLMzFRS3dpdnBFS3lSZk5i?=
 =?utf-8?B?NExtOTllN0FhTC95MG90c1M0OFNsQ2J1OFlsSG55MHVnTzVnR3FMNjd5Tm9U?=
 =?utf-8?B?UDc4NnF3NkpnZ1FpelBFdUtSZjRaN1dtMi8wQjlFMXYrZFNIM00xQ3oyNjVp?=
 =?utf-8?B?NTM3K09Ua085Vk1McFR5aTl5ZWpzSU5lN3h3dXk3N2NIRmJ1L2tYZEVBSDZU?=
 =?utf-8?B?eWh4T0VQZ2dOaG5xZlNTUUh3QnAyYlo1SjZaMHhicThCbVMwTzh4dEQ4M0Fp?=
 =?utf-8?B?M2J2SCtJMkw4bXJlSUlMVzZINXJPbGVCRHlUb2RzMXdOSXVrNG4zTDkvS2tk?=
 =?utf-8?B?SVZJTVY4aUk4WkFWSThGNk1seGphaTdEdS9HVStRS3I3dlgyQlZzaVZFSFRn?=
 =?utf-8?B?cW5SOXRCQzN0VzduWXlBekp0aW8yL3I2YklVb0hMbkp0emNHZDFIc0tjeHFy?=
 =?utf-8?B?a3hjb3ZDOUMvRTR4RTFwd2ZiRDVrSmhzVUJMeTBiSklNNUJpMElMbGZaWEt1?=
 =?utf-8?B?ZHhxL0FnMkY4NWJJeHRQL05ZQ3JDSGkzTDNHcG5oemplZS9iS1lUcy9nQk5I?=
 =?utf-8?B?ZEs2SDJPK21TSXhGVmtnQ1pPL0JGUzg0bCs1N2xzSUVnY1FFSWpOd2V4UFpy?=
 =?utf-8?B?ajU1czkya0dCUUYyd291MjRQVzByMjl0R1JOelFoYzdIVFE4R0Z0ek1PMXBE?=
 =?utf-8?B?S2JOUEhzSVB1WitIbjI0Z2VGaUtTTk5pdFJtazBMTVdERlhrVC80eG8rNjYv?=
 =?utf-8?B?dlhtOXdaR0pnMFlxdW9BME12N2daLy9DenRjbCtNSkFteWhxNjUzU2RIbnUv?=
 =?utf-8?B?WUl4bEpDVnZVekFaU1Avc2ZDYWttVW5vY0xPUWNkRFV0UVNic2VTSUpGODc4?=
 =?utf-8?B?ZFhQZmtGNFMxdlBNemJPQUlTa0N3QkwyTEZuUEo3YTVabTZHaUZSQWtxQVBn?=
 =?utf-8?B?L1VRSVQvOTYwdHV4UGMyNHZMR3VISEpUeGJybkJZVVhtNzVDSkh2ZXhGUXF1?=
 =?utf-8?B?SmhKUHZETUdoaHNtK25BY2VOTHpiakNzVkd0ejVPenAySy9hYWxUZ1d0RWNu?=
 =?utf-8?B?NUlCeFlYNUo2RVpiTmpXdEpHQ1lQNEZlSUZ6OXhwZzcyWnNUQ2lpRDlrNTVT?=
 =?utf-8?B?MW90UFZtK3FLdFdmWWJHYnZ6L3p2VVp0TnBiRHJ4VDc2ZHUvdG1ZNUltYTli?=
 =?utf-8?B?R05iQTd0UnU3Q0lONzZma25CSEVSc2tsZTRWR3ZyL0NZMFNIUDhBUFk3RzJP?=
 =?utf-8?B?SktnREFqMjBRRmRRbk5oV3BnTVY2cDJIbUhUZTZ6Wjg4dzRoSnI2NzZlRkZV?=
 =?utf-8?Q?PT6A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a6d20d-767e-42cf-6943-08d9df13befe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:30:15.4789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B04NTURy6IxCim7LTgF3WKqlHNzzjMrxir8mVGw475CZSQ4THr4j/K3lRzJLe9OZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4769
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 1:48 PM, Lang Yu wrote:
> On 01/24/ , Lazar, Lijo wrote:
>>
>>
>> On 1/24/2022 12:13 PM, Lang Yu wrote:
>>> Some clients(e.g., kfd) query sclk/mclk through this function.
>>>
>>> Before this patch:
>>>    # /opt/rocm/opencl/bin/clinfo
>>>
>>>    Max clock frequency:                           0Mhz
>>>
>>> After this patch:
>>>    # /opt/rocm/opencl/bin/clinfo
>>>
>>>    Max clock frequency:                           1500Mhz
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> index 2238ee19c222..665905a568eb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
>>> @@ -552,6 +552,14 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>>>    	return ret;
>>>    }
>>> +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
>>> +						enum smu_clk_type clk_type,
>>> +						uint32_t *min,
>>> +						uint32_t *max)
>>> +{
>>> +	return cyan_skillfish_get_current_clk_freq(smu, clk_type, min ? min : max);
>>> +}
>>> +
>>
>> I see the below logic already there and this patch doesn't match with that.
>>
>>          case SMU_GFXCLK:
>>                  ret = cyan_skillfish_get_current_clk_freq(smu, clk_type,
>> &cur_value);
>>                  if (ret)
>>                          return ret;
>>                  if (cur_value  == CYAN_SKILLFISH_SCLK_MAX)
>>                          i = 2;
>>                  else if (cur_value == CYAN_SKILLFISH_SCLK_MIN)
>>                          i = 0;
>>                  else
>>                          i = 1;
>>                  size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
>> CYAN_SKILLFISH_SCLK_MIN,
>>                                  i == 0 ? "*" : "");
>>                  size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
>>                                  i == 1 ? cur_value :
>> cyan_skillfish_sclk_default,
>>                                  i == 1 ? "*" : "");
>>                  size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
>> CYAN_SKILLFISH_SCLK_MAX,
>>                                  i == 2 ? "*" : "");
>>                  break;
> 
> Thanks for your comments. To maintain the logic, for sclk,
> just set min/max to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX.
> For others, set min=max=current. What do you think? Thanks!
> 

Should be fine. Also, from API perspective - make sure to check both 
min/max args for non-null and assign values to both when they are not 
null (doesn't matter whether min=max).

Thanks,
Lijo

> Regards,
> Lang
> 
>>
>> Thanks,
>> Lijo
>>
>>>    static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>>>    	.check_fw_status = smu_v11_0_check_fw_status,
>>> @@ -565,6 +573,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>>>    	.is_dpm_running = cyan_skillfish_is_dpm_running,
>>>    	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>>>    	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
>>> +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
>>>    	.register_irq_handler = smu_v11_0_register_irq_handler,
>>>    	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>>>    	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
>>>
