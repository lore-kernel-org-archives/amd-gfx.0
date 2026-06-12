Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDA7CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 11:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B7F10E9F6;
	Fri, 12 Jun 2026 11:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DatjDVvy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A58010E9F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR/ylz/rYrOhbMGllyOdiNAVpo9WZ5u8jluqQQDidD9k9eW3ifX5nKRKILiJ6NXrnTXeIbn983Fz+PUu9LPtRxWJI+eon4geJz6OGs3DWK+ZtnbyBWNSp/5yotbCSJPQYnX1xCbVUQWCo1R3ZtfME+j6NJtAsmdzL5NJaaocIpgsxHbTLhCSWufeP9bngJ0HmQJAjKRa5UfYlOvqQ+J0+/BxK2SJL+aA9/EF27eSSjrIipfQmq9tjj37Jg5qXXJOi5Kr9fD6yCuiwDjCOru+qO+zboFPqM6rOqnFdIEAx4OUojZtlpmUzl6nBwgKWuS2vA/XPDkIbOJ2OcNkpw7DWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWr4oNyjgCIrijggN4IP9syHJX1eFXEzL0H8ylA7O98=;
 b=EAnQZvzZptd6+HKaxHy1emFALTGYMpXX2Te88Xmy4/l59Opolc5tWWpewYgHhyhw+15rWDN3KXmg7N3VA49Ubt1lVn5IH23nTJ9gyArl05kcmL47oxA4dSSgdlc3+K/MYxH2wMQEaU3OcT8jV4l5AnFok5gVQwg9FT+xk0qFGCQXsWUARa80kIEI8oxEnrIdLVkwbfAJCGFIuLDoc7x3mLbnBMPN8R35hUoeav22bD/LfxWo8KspPg5fuF3tb5Qo4dx+oR9o+GrSGM4vPZT6oBs3pg4Htydde1psgO22xSgz49MjxSkBWbCVEgBM101Rfda3NpA1AiYLq/Ao+35N6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWr4oNyjgCIrijggN4IP9syHJX1eFXEzL0H8ylA7O98=;
 b=DatjDVvy2SHFQV2fz9lCqEIPIrkDG+rY4baH+E1j9O7HxrPWUR3u/cRQFI4tQjMVkckfC0zq+2j6/H0FsOwQxSXYMOVvKuw+nk+fJuTfzP9yn1kloR3S2ehcfR0uKoKNs3aO+xlq49+xpl/31Bom/NbsYcMoGFPT+aungSvhTJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:49:22 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0092.011; Fri, 12 Jun 2026
 11:49:22 +0000
Message-ID: <9012d5b7-2d18-4596-b020-6e2452ac992e@amd.com>
Date: Fri, 12 Jun 2026 17:19:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting
 via VCLK level index
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
 <20260612104408.9596-2-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260612104408.9596-2-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 70385d27-20b7-494b-2630-08dec878a4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SBh1YMumIBsXagVZFs1SCLb7OicaVROphLBlp83i/TJpsMawNwA/YXiX6KUL2KQoM4WbFqtD3nzGPf77N5Z2cWBcfLxKbMtA/p7NxUnhcdHk06HHKmxw8RCde40Zwg9z+yfxlz85P/d9iAO8DSLiOXpGjWbYZIsCAubi8mH4yGdtpvHWgrY88bOIDNrLcC/+BEhHm1cD7h5rkUqgOphV5qzwX9g8TkiihJ4oJbfKxiAdji2mVNnz4PRHrvohOeLg/byCG2xEGp93h4+/t3T/91+XI7O9CDy22Umrfn7h2moDp0EppURKffNE4/g7xQyXjpnavljKGhxpvGrpsCTiUFzu/3aOP3uBVer2fEY/M4cVIUPDB2sU8B+UpQ+w9NqpPLnurDfc5oPHUSrvwuJ5Wg70kQUyIlk4XpxsXLWakYgPfgzewofRiWXLdkLPLqGqkL9MYdpPXiyPq2iXmG+q2DxXqcWseMO6oTuTHBt0Zj/mXxnilrvmueGxDvqi4rVef1usCvWf10MdKy3OzzKuTW0jkka6SP5ycfX+rcjqyU4XFoRV93nw9YAUBEooP51fivSpItmQUOMA0SIrJoXF4JT0cKmNzM0pjEh8IVa4YlyRsCChV07NMGoSaH59iWQT9A7gqsHzqv8jDBi5NprXdEgsI0NeyXCCKNt4pP+QuETYVYj6j10YakpBJabGTPXT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdqaU5Ldm1pelhYTlUzSnFlTEpiR1NkN2FLM3Q5QU05eTYvY0xiTEFJeEg4?=
 =?utf-8?B?c2tWMnVjcEsvdkNEVWROK1gycXkwK1FxUXZQcThuR0graTZVSWFQYlZZbzgz?=
 =?utf-8?B?T0FhbG81TURZU2ZVbFlzZDg0d29KT1VyVW1ubGxETlpndlkwYmZoWE95bUlR?=
 =?utf-8?B?cERGQjZnOC9nVjJlWHdsYVVKVWVkSC93WVNkV0pmd0ZOME5mcHpjY3YzaEJ6?=
 =?utf-8?B?eUVwZ1RaamRtUFRlbi9OTXRGNmtmNzBwUm1ZMy9RK1JkSmNTeFRuZE5wSUY1?=
 =?utf-8?B?bHpSRzVzMXgyQW5IU1pZSzFuTnBDdFZwYzJxalVIRGNtUmVCWHhRcTlNWFdD?=
 =?utf-8?B?dnloV0g0TG9aaUlmaG9pa1BTVGpZOW1BUy9YY3pXdkNHODdjWTdBMFBoSUJw?=
 =?utf-8?B?MTFNRnAzcDVBbFlQaDZCVThCM1NDcHhMYlRBSkpHRkUxZzVUWDYwTytpcjFm?=
 =?utf-8?B?NmFGZG9aY2ptMEZXNlAweEFNWmE5WDdhS0h4YVR4SlIrYjg2Z0NpVVdHTnJB?=
 =?utf-8?B?bTRMY1duWlEraUprK2IxNE9pY2hJVVVQby9QQ0tmTk96VXdycktBOEhnblVw?=
 =?utf-8?B?NXJ0VDNLQVpJdVZ1V21oZ0lwUGE0ZXpNU1dDelR1bW95djQ3SlIyaW0wVWFo?=
 =?utf-8?B?UXl4VzRNZERuSmJiV3FWNmoyTTZScmc3MkN6SXZvenY0WmRvcFFMSGl6N29O?=
 =?utf-8?B?YzBmNitaVmNsYzVQSlRYdU1WQXJwb05DSkpXZXZEL2JoMWJDTGlURHdRb2dX?=
 =?utf-8?B?em41U2o5aDViQndkRmFacUUvWWJHRENMREN0Y0RZNnljNlJ3SHZ2eExTeG1K?=
 =?utf-8?B?V1JQWWExMFJ4dnk3VTdET2E3WHZvUDNHSTFiTmFsS0lhYmJUYzJrZTNoL014?=
 =?utf-8?B?dUoxS1czYjZsdTh2SWErMkxRUlZORStnUnNGbU4rOHQ3TkN4UGZzanhxQ1dE?=
 =?utf-8?B?VkZWVDBHMjJraFU4elZQUXcvdms1TnFKakI4dkk1c0lmYm5TT1B0Vjg1ZHJ5?=
 =?utf-8?B?YnlCQ1VWRWJmbGlMbUZhd3hQMjZHeWw4QURlU1FldEIyK1FJR2ZkaTBLUEla?=
 =?utf-8?B?cjd1ZWsrMXJoOWM5NHp4UWRIdkU2b2t1YysrMzhVM1BrNlJucytXUEQ3WGVN?=
 =?utf-8?B?Mm9lWUNRRmZQa0xEQk9COWVndFlPVWxieitMMm81b2VRR2ZiZ1ZvTEg0dEJ6?=
 =?utf-8?B?Tkw3SFdMQTEzamNmdlpSamYvRjJEZ0RWT3ZBaW9SME0zSjF5bFpXTkl3dVdY?=
 =?utf-8?B?VUUyUzErYWxCdHlNMUwrS283ZTlEcERxVUxWT3IwNGJzMSthVHBoSzdoZTFw?=
 =?utf-8?B?UzB1NmhmZ2dqRnlhNzI2TDEvOE00SmZoMTlpWitOZ1VtZDJDTG5lcUJzTHBw?=
 =?utf-8?B?S283cUdHTjR1dVJGekI0WFJNQzArNEtCdUorcTM0L09mc3RlOVpVK2U1UW9N?=
 =?utf-8?B?Wmsvdm5PMFkvOHF0ait2KzNyVnhYTzZ6cGhvOUVKRjZNK2ZHbDUrcGppSGJs?=
 =?utf-8?B?OHlHNi8rOWlvNkRyZ1dsckcxY0t0b3NxN3AvaXdXdS9pMWVuNGRJSFlqdDZN?=
 =?utf-8?B?SHBQd1U2eVdrV29CRlBUZFcxaTd5R051VXRLQUFlSWpncUVPZ28yTEZJeWpQ?=
 =?utf-8?B?dDdYb2FEV2phejZJWUNMSDdqaTRqR094L3NxcHhQYmJRY2tjd24wNytCd0tO?=
 =?utf-8?B?R1lqMjNBVmQvN3NaLzJXVXd5K1J6TWwwYkpwc0N3Q2s3RE9iTWNQRGdFMGdN?=
 =?utf-8?B?T1czM1ZhYUlHMTNIRXRjS0paRmYvYVdNOUFTTFBldHhwLzZhdUpyWVRDeEJK?=
 =?utf-8?B?bVdnejNBUlp6MkhMcHZOdjA3OElPWWRKOTVReVQ0K2F3RFM5RHAyemtTNzFq?=
 =?utf-8?B?cXJ3YThMTVRoNy8vQW85YzJhdXBGTFllVUc0a3F4OWt6ZmpscFRRL0NxSWVy?=
 =?utf-8?B?ZjVPZCtUYTVmZHlxNnNtTlJkSVpRMHE0cmVlelRLL1dwY3hJZ2hyb1RJSU1l?=
 =?utf-8?B?d3h1YVdEU09La200SkEwejVTcXBPSVlxV0VHVDVlbEhKdm1MSHlQTE1lMDVw?=
 =?utf-8?B?SlhjNU0vbEpTczU2ZDU1MkFXaHcxZXBoTVUwYktzVHdNWmM5U2Z6LzFDTi9O?=
 =?utf-8?B?cXVDYjMvMFNySzZqcy9Cd1c3OWF5Q0tzcC9HTXV0SFQ0UkdyVE1zRkhPWjl3?=
 =?utf-8?B?Qit1eTRBdWpHT0VTUDFrck9tK0ZwTlRsRWFEdVZyQ2pvMkdvQjlFRlNURzlI?=
 =?utf-8?B?TVBRbTMxOXlNRHEzSEVLUmF1WUJlVDZmNVZXVDFlOFUya0dRRTg3VW9pSWEy?=
 =?utf-8?B?U3lNUytzTHZUbXBsY1I4NnRXbnZnVEMxcVNtNmRtTWpQaXJudnM3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70385d27-20b7-494b-2630-08dec878a4cb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:49:22.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X9/zHl/4XWUObqhqpRjxjGOGecC/N6Qlr9xWpPoRURTzke07NYB+zT414XIjQDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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



On 12-Jun-26 4:14 PM, Priya Hosur wrote:
> SmuMetrics_t has no DclkFrequency field but DCLK and VCLK have
> separate DPM clock tables with different frequencies at each level.
> 
> For METRICS_AVERAGE_DCLK, find the DPM level whose VCLK frequency
> matches the reported VclkFrequency and return the DCLK frequency at
> that same level index, since both clocks share the same level count
> (VcnClkLevelsEnabled / Vcn0ClkLevelsEnabled).
> 
> The original code returned 0 for METRICS_AVERAGE_DCLK, which broke
> the active-level marker in pp_dpm_dclk entirely.
> 
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 27 +++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a..c4c45c8dff69 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -284,7 +284,34 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>   		*value = metrics->VclkFrequency;
>   		break;
>   	case METRICS_AVERAGE_DCLK:
> +		/*
> +		 * SmuMetrics_t has no DclkFrequency field.  DCLK and VCLK
> +		 * share the same DPM level count, so find the DPM level
> +		 * whose VCLK matches the reported VclkFrequency and return
> +		 * the DCLK frequency at that level.
> +		 */
>   		*value = 0;
> +		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
> +			DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
> +			uint8_t i, levels = clk_table->Vcn0ClkLevelsEnabled;
> +
> +			for (i = 0; i < levels; i++) {
> +				if (clk_table->VClocks0[i] == metrics->VclkFrequency) {
> +					*value = clk_table->DClocks0[i];
> +					break;
> +				}
> +			}

I think it's better create a function - get_closest_level - as in patch 
4 and use it at both places.

Thanks,
Lijo
> +		} else {
> +			DpmClocks_t *clk_table = smu->smu_table.clocks_table;
> +			uint8_t i, levels = clk_table->VcnClkLevelsEnabled;
> +
> +			for (i = 0; i < levels; i++) {
> +				if (clk_table->VClocks[i] == metrics->VclkFrequency) {
> +					*value = clk_table->DClocks[i];
> +					break;
> +				}
> +			}
> +		}
>   		break;
>   	case METRICS_AVERAGE_UCLK:
>   		*value = metrics->MemclkFrequency;

