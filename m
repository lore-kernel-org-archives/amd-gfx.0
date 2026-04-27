Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C1FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3102510E5E4;
	Mon, 27 Apr 2026 07:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEofhf5L";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D56810E0E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhmyVAt1soNt/caBqcVjckMFiawcrE513+AYhhyicvBfe97GEleiIh1PXwxqzz+6PyPM0vSTIpSLKpQlNDksPeQb+qTLBnHgCqTXo/RyamIMKBHsvDmwaUBsGYr3kveTb2hnlvDEPjDLVETZGhtm4hh8WH3nFH85SAb+//bOw8IvHhWBnza/IH06pnoeK88Nrx6rfN3z45s3zPM0REhILQ2mkuVo6YXMbgzE2LQ6NFZ9Wtmyx8CWPAl9oIIgR3IgGRaoMIIhQr0VUFUguNcHjmnzqMqSVg4n0RO2wLD7/N/OZdgYieh23SA3YJCPr3Z5rwJJNl8UkNp5NF+EKWfn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY0B/u6EBF7TTpPc1qJWV8aLKs4NY/bTxL/Uuo6o+HU=;
 b=lr5tHq6zSdiDBjXhYjvr9y2vWOAizXKjVPSsvlHtjA4y3QKiJ+xRSUmreY1cJvp7D14Tfa+k1+dy15HmUVxrWc7DfSWV2tl9KkaJ0bGh+K5wpQHWDkfn+cygQvZoMnBe/lrOlPzYJKYvj39ghkPpfgzAwo1dG6Y5NaMNDs+NBLZFCIn0Is5QLFll/U3GmHk70fPkPJ2XDL8RYVJLrZkI12Q4yG1uBm8jzN8zQLnQYunXs3PH6Utk+XubegAKqpKdDa3SiNqTKC39fWC/+c84lAdYfqM8ZFw28Ydtvr/vdsFsvTnkwzEDzygnjBWb5+8ECBADBTpmvU+kdd42603LMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY0B/u6EBF7TTpPc1qJWV8aLKs4NY/bTxL/Uuo6o+HU=;
 b=lEofhf5LgbgSOg0i6U1IjELumuPNJ8CdGU/HPAfaz/XbChzOKGPNBM++BxA1oEBdIf3FwGd3mFWHikt9LT1uNNPOjxFsmfRvjFtw1Wq1cZgev9LVBlHNuji+v9LkukYz9NwB4reMOiA8Pig3ohREXLoa3JphvmcD4KHuC7VVFv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 07:56:10 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:56:10 +0000
Message-ID: <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
Date: Mon, 27 Apr 2026 13:26:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e21b8e-97a8-434d-9058-08dea4327156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 7w+EzIyomlU1K3WdfSaHe04FNN13bb7k1BjvAcBG4FxQLQCrU5e6X/T/g+PlOFE5q0/uW1Wx+emQK2qDyNPJKPkXRIOqSLv1cbclmRitBwW6wrwn9NwPHeMdaxBjxTZiuI4YcyCk/p7H/yQMAzBnyIAHKVLjX+x28tnXVoaFhga+uUyo/iXldNyRd5sOYX/V3kRILGasEFdU3EjccdyIR2nBWCrNxch3EOKRzpnonM184cfpzkmGH+2YS5Zn3AxsSTUQMc9RAxsN6RbCfzEYSTcs7IUW7qegOarxckAFhyqulwIuwsiCilIXlBya8op4jtVGeb9RcQG9vnd0MNAHrEg3D8nVSRGWax4UELDt9bGr31Dq/9z6xu0NIayhj2CpwyEZCAHnizGsU7gN0wxY1N3E/Dti/TXpikJazeLnZoIFLXT0yoJWbJ8TaW96A2Vc9kD4BKezDD1PbBrlTFhFdMrTgY63OJRjhFrE7LBvWj6lGQOpX4wMfFpYxcsRW7Y9YEI74QLeS52Ik62nTHEnCVli9dVt4TNmoG/YdgoeHGRozQPFFZXEEzBFlUDVzK0k0cGWQz/qyfc/F1q0c5KRaUQKjPpG2qaEVYerIIMQANs8O1GPUcaSgm/uJUp4COrjeMRYNVhFPIRxt72K0UWBUaot4yqCDpNRsBW7QdzI+R2+OYAp44y+APopdkCkA0X/L9KIZI/sy3xnDmzEFCDMPw0/ECmnWOeAAzg26tRNjp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlduNmd4bENzSFdzUzFDZDJaZG05Y0pYRGNER1paaVNDTjk3WVJCWGcxcjdR?=
 =?utf-8?B?Vk8vOEVtSDBBWDNtb2RqaVJKZTRRWHNKajN3MFh2UDNYYURhOTgxVFNveFhZ?=
 =?utf-8?B?WFZhdyt5eUNneWpaWEI1SVdxWFlETlJZd0M1ZnBUay9RNmtCK3JLUmVYZ3pD?=
 =?utf-8?B?K29JakZ0c1hrSHhPTDdZME0zTGNaQnovNmpMclhmQ2tmN1Q1TzlhWXdoVE5p?=
 =?utf-8?B?Mkd6UVNTamRQbGpVYmE0eEZoNWtnR3BWV2tueHZBaHNpUEw2TlNLK0pjZm9Q?=
 =?utf-8?B?QzhYZy9NOEFuL2VqemhNR1N6RjFSS0VxZFFES3FVNFpoLzdpS25EVGhFQjJT?=
 =?utf-8?B?Q210eGQ3V3AvL3FKQ3JKdjNRREdKTDVvYTljQ3M4MHpjZTNxbExlNUJEWHJO?=
 =?utf-8?B?RDdoSFB6enByL1dSTU1GdHBmcW5CNXNPQkZ1a3ZuTmVZbVRPR0dnNm8vd1Vw?=
 =?utf-8?B?Q04rY3IvSXNtQmdHekRJa0VvZHpITEJETmc4c010NUZzTzBYeHdQekhXQkFP?=
 =?utf-8?B?ZVBzbVl2ZXFoeDBIVVZ0VTgxaE0raTI5dFFoSjhnM29USjBCT3dCT2ZOZ2Ry?=
 =?utf-8?B?YkxLUit1RFJVVUV3V2R0VkpiVzg4cEMrL2h1TW5oaHppOXpNVDQ1ZVkwbkNG?=
 =?utf-8?B?SW5HRGpTR2dTcUE3UU5yUzJhYzgvdjVHWVhmaWk5TjRhbHFRQjNZOVNNVUJ4?=
 =?utf-8?B?U2ozTkE3MFlGNDNsTWVHeWwzNTFNQnBTMG1kSmFkSHAwRWtybkRsSnNOOXJY?=
 =?utf-8?B?WnhiTnNFSVAxK2gvQkdNdUtBQ29oUUhyZVhqa2lYZjRIKzJTakhhWi9hRDJI?=
 =?utf-8?B?YVhtelU5MmV0b3J3a2JFZUhJMVU4Ym9SVVFyVGxOay9UZ0c5eWYzMkEvNnFo?=
 =?utf-8?B?U2l5S2lMWVIxREc5MVhNSkRLaW8rcDdWY0JlVC90Tkh4YkxUbjlQZ2ZiMGZI?=
 =?utf-8?B?b2lzYnoxNG1TQXRnM21NWlFNOUlCMExyQmdiVnNDaEUwWnA2VnVNUVNXSG5L?=
 =?utf-8?B?MHFvbnlYSmZ2VUpCWEhpWUhLVVdhTDMxeDBkK2FjdEZGRU1KRklGSWJzMHVv?=
 =?utf-8?B?U0swRFZ4M1pkLzBXWEQ0ZUlQRDNvVFJpTEtBK2w2dUdGSjRqajg2ZHk0T1dz?=
 =?utf-8?B?TS9IbmxSdEwrZ1MrK1h4VUtlL2dsOWtzQlBUTDdwdXpyNE9KSWpUSDBhcjh5?=
 =?utf-8?B?ZmxKVjkwNHkwaC9GYUtMbWgwcHBXMVIrSEcxQmNDZHkrK1d3NEsyOGtLTm1O?=
 =?utf-8?B?VHlzMU5DOGFtdUlSNWduOW0xOWticTc0QldTdVlVcTBicitvWm0rN3ZvT0R5?=
 =?utf-8?B?SXZyMkYxanAyeGxhWUxSNFNJQnd4WC9hMnJ6OVZXbDc4V0FTTE1zbHNmNjhZ?=
 =?utf-8?B?NUtBcURPWnBScUJ5SWx6STMya2ZVbmY0cC9YemZiM1FJeUxJcmdVcXJTb0tF?=
 =?utf-8?B?RW9sRldhRmhrU1JEZDdrY04zQWpZN3VtTURvZUFGbEYvUnRRdWRheXBpcWQ5?=
 =?utf-8?B?bVdLc0Y2NnpLK3dqVGhKUnZhV0NPalVGR2ZVOFgzRW9xUHM0RlBaYWV4ejlM?=
 =?utf-8?B?N0QzR3dzRHNmK01yR2YxeU5DakE1RWV4U3k2d2E1ZmFScHhXOUMyMG9KQUw2?=
 =?utf-8?B?R3NFc3Rkbk5NbGVMQnlwdUVMbkxsWEVvT1lmZGVNaVIzRTBPOE1tb2dHU2dG?=
 =?utf-8?B?NmJORjI0SG5yN3JVbU5kQmkyMXZrdGpUSVRadWwrbWsrUnFXN1BFc3BiQ2Fi?=
 =?utf-8?B?eGhLNkxWSFFPVHZmZU5XbDFRT0hYTmVSY012SWtqeW5tbXNvZWlLdEZrVWdX?=
 =?utf-8?B?N1RzOStxaXBIYmtSQ3hVYnBFc2Iza20xaXN1bXJSbnV0SUFTN0dOdmRJd1pr?=
 =?utf-8?B?RHZTR1I1Uk5NQmpwZ2hld0pCSklqMjdtMk1jVHlzS0RDVktueWNLc2QrOHA3?=
 =?utf-8?B?dlFKd00wZjdPZVJIVG40V1JRcW04UGphWm5ORFhBZVowWDBVaWJhOTZMV2Vt?=
 =?utf-8?B?RkJQVDQ1d1FBUkU4T3FMRUNwYzRHUlQrTENJS0ZuSkVHcG5nNVk5SXlyWncw?=
 =?utf-8?B?Z3FwczkvbWp3QzcrUFN6MEx1Vms1R2dqMUtEbXQ0K1d6TFB5VE11dWhUVDBi?=
 =?utf-8?B?QmdadHBoNGJrQzAzaWNVakNGQmxKMWoyQURNRXNrWE5HdGh0aDE0SmpaNGQr?=
 =?utf-8?B?VENNQ1AxL1Ywc0RaNUR2MXFzMGZsL1N4RnFzVk83Y2laWGJKVlZITFh6aE1j?=
 =?utf-8?B?NGZtT3RWdXUzdjQ2YmtwcmFVaDg4V3BiKzRkdkQ2N1lrR0hYR091OW9tbVZS?=
 =?utf-8?B?eU1Rd3R1bFhJcm5ab0ZSVXZZQmxlU0FKQW9qNGxtSDU3Mm1acVZndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e21b8e-97a8-434d-9058-08dea4327156
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:56:09.9547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdlmisy73yIs2O1apq48bVD3hOfbvGCnaE4xDJCwqfLKlaJFBXyIskBhWv9guV3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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



On 27-Apr-26 1:16 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
> 
> You need to move this line of code under smu_feature_is_enabled() to prevent subsequent smu_cmn_print_dpm_clk_levels() errors.

I think it's better to fix the smu_cmn_print_dpm_clk_levels() logic for 
that - to keep a separate path for dpm_table->count == 1.

Thanks,
Lijo

> 
> With that fixed, the patch is
> 
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Monday, April 27, 2026 15:31
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
> 
> Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report clock frequencies correctly.
> 
> Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13 SOCs")
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 40f0d8a685bf..8d04f6e73fd7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
>          /* gfxclk dpm table setup */
>          dpm_table = &dpm_context->dpm_tables.gfx_table;
>          dpm_table->clk_type = SMU_GFXCLK;
> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
>          if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
>                  /* In the case of gfxclk, only fine-grained dpm is honored.
>                   * Get min/max values from FW.
> --
> 2.49.0
> 

