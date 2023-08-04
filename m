Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC192C001DF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 14:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509CF10E0BC;
	Fri,  4 Aug 2023 14:37:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A71F10E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 14:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9RCdhKZyoqVeFZeee5o8y2Y+bUSb9vxnCA7yEHNu3n1c+xK8rA5/BF2u1XJzgEeq/HMrsZDH4ld6kRxPwhA3Od5deUDyHqd2X6ZeeNaH/zVm2mcE9PsJLLQQXsJ9zhPJLk82QUcAgbK0rXbsZnG5g63haTstKgd7DHZz9OReYVtZwNcfLNDO2PSYbyq+HFGgXBiRT9FrfU55w1E8zpjiVGIebyTpUzf+Mu8gW9bYVW7PNFBB0fUyWCjUHcE9kLvhy4XC9lXqtjGcDH0BvpRO1BXIX2tFqsbzlqQCEaRk4Fl/LKOs1V2nnUbouJ80oyMmbUW+w52okQLklMZC78bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etr9QG5XyF2JQBMmLgKL7Ueifup7CGRd8PqL2Mu0gAQ=;
 b=HB+eYszOD93bpJeJaVdlkiILrwo2mQvEnczlD8m2ip8PVhcml4tXVjz7/Ofwm5n5HDugGZQvVr109oRcgdg1xChTOCjQo62COKtwij0VSpPhBSLzKKGag4Z/AXFSFjxEqhfLAXDQKg/5jWc0mSBsGnFwvPB5pd8g5Jo7dso58p4yfEDRIwyXSWgXj5MDptU+qYc6SRb7nBszShph0+EuwabAmsFc3jRXeeB7RIj9to+rAHxVJXXepmfzw95sreQtHpzIwyYZVGxtxoMge4OSI7LPwN+KrGwklCaGC9TxJKREFNsYPwJrNUCiqmkjAC7EZoc2SQUQqtgBR+/5/bgvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etr9QG5XyF2JQBMmLgKL7Ueifup7CGRd8PqL2Mu0gAQ=;
 b=MKrc4Q89P6vF79eFIp26AiK8ij3iMrtquDCYchMO9qzuN08dnZCz+lCCh/qscyfo0W6Sy//jOMJXErDbJ37QyvUtZHf6IawJmJiXnRtuUMHvHCEoJUsqzLrZUHAVbXEu2WcXO6RU5HWXTUCjRx73VpXZ5WiD2jnkf7cJkZooc/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:37:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ba40:7dba:9b00:ff16%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 14:37:23 +0000
Message-ID: <b7a6f60c-4b3f-e8fe-36f5-d4f329a2a666@amd.com>
Date: Fri, 4 Aug 2023 20:07:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: avoid driver getting empty metrics table for
 the first time
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230804143258.1992824-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230804143258.1992824-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 98db3a20-3c32-4d05-f0a9-08db94f8506f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeAKEPaOB2GnQKUSpEOw5Q3aRqobMDrTbg1f90WOqjspXoK134q4RNLbBQcX+KqqK971es0HnGTA2o+tgf2VqgBZNfN1ta5+/w0+r60Ev4ss4YgC4sywrnG2FRSJKjkCUQidej1nz0+YxZbeQPO4hN/I+eox4eo72Z+/7WVjXfGZcCEdu+SwwCQlXhucAOP4sAMLKzwQm2DNTMy3gPgQy8Q5BEb3D9QH+nglMnLCVSabgjAsQrCnh1z6fzkwQwhYnF5pPUI1gNo1ZuWw8wG1KiW+NwkSVZogfcgfjSPtZi+fTniO6YjoaTJYeRxQorXnksobC1z0LFrqUor0rMYSzypNrLgNLnZB2uKpV+g0vzZAHV0t8F5oIu0ksSKdrpg8wyZX+BnvZXHqlKl6hMn8J6mrvildDnruhCB119VbM7q9m6pDaVZZjvMnWeLmVkMLu+8jqpwCzfhyUhPJdz+qJsrsbfzlmdm5vCBy4dV9/Tf8AYFomWjR1Nbz/D9hjZkE4t1C4BQNrOHPdWuzl8ELr6qAEyX2u/KzAgr26Iw30uEa7rvsGtDqpYnH7xZh3wlBH50WwPtpnGqDhAw9D7W59gHrYl9YbmJhX29WnVf348D9ctijhot75BkzlS4udD5wyRTxSiq8joTcj4ni4N759A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(1800799003)(186006)(2906002)(26005)(38100700002)(53546011)(2616005)(6506007)(83380400001)(5660300002)(8676002)(8936002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(36756003)(6486002)(6512007)(6666004)(86362001)(31696002)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEFkd0I4TmFUQ1kvNFRKdTRKalZGcVpseXV3ZUxWOG5NNHlYL3BpL2pMa0Nn?=
 =?utf-8?B?Q3hNamV0aXhrRkhLTkpqd2JHT0k1aTNrZWNaWTZldHVMYTR5YVRRZEtkWDNm?=
 =?utf-8?B?Tk1GQVhQaTVkRDhoVG1VYm5VM0VCT0lvSlR6L3NZWGRuUTQ2VzhVQjg0TU5G?=
 =?utf-8?B?QVNHYVV2MmlLQURRV2FDcEFyVGNsNDdERDNFWVVOZnNuUnlxZ0U2ZFkyWXFy?=
 =?utf-8?B?cjFTSUdOZVZuMllRNmNuQVNaVjRsZGttWGRJeDhhQnFsdGx2Vk1PdEY0R1Na?=
 =?utf-8?B?RXFWZlhJREgzU1l0bXN4ai94cDRyeVZPSkx6eXdpa0tURlNaYjJlR2VxYUR5?=
 =?utf-8?B?SVNISW5DUjRzeDR3dCt4U3dteG1aWjdZclNTYkpFWVhYVGJLNWNmeGR6YmpG?=
 =?utf-8?B?ZkdKT09vMWZja1g5SzB0dm0xamxPSVdNMXhwZldmU2N1QjhkNmFHZi9PQkJp?=
 =?utf-8?B?ci9BVUhlWEJGcExKanVGWkQzcFdLK2JWYjVhSXc2MU9mdHN5UWdqdXo3VjQ0?=
 =?utf-8?B?ZXZkR2pIekt4a0F0ZFFtRzlIdWpxWlZBeVZ5Rm82ditNM0hwSmZJWnRTTUFN?=
 =?utf-8?B?bUhObFJ0R0QzS1V5LzFPVGRGRlczQllZamlkcWJjNDVvLzJqV05ycUZEeXda?=
 =?utf-8?B?eUZab0kxdVBYa1U1WmZYS0tSR0tWRDRqam1zMFJCdTIvR1EyZk9paGl5eUN3?=
 =?utf-8?B?MEpjUkk2UHV5Y0szYTZEZkNJdnRaT0I3Y1lnbXFBeEk4YmJ6Zk1CNVZMM0dP?=
 =?utf-8?B?MnFpVWEvNXBSdnN1L3M5aW5NU2pFb0MyaVgwN3dOSGZBc2U1aklJcFI1a0tt?=
 =?utf-8?B?Z3d1QXk1MjRiRzh0QTNGODIwNUVHdDdLVkRKODM1WDJ0OVRtbFB4R293aFNr?=
 =?utf-8?B?bWhrTzZQM1VJbkN3YmJBZVhWNk95VWV3aXJhR0lJckp4cFVYNXVUK1FlSWp1?=
 =?utf-8?B?cml4bG0wYW9HZXlJcTh3WXRGc2tlc2RIVWx6VHpuK093THdEOEZKKzRtbUdp?=
 =?utf-8?B?QnZHZlBIY3VKd05oWmpSN0JkVTJqVTRLVlJDVjlZR3gyZTNKNVJyTVJsSG9r?=
 =?utf-8?B?WUxoZHQvNXBBL05HU2E3RnkyTWdZSldwUnYwZCt4bVRzVjNlQnovUFFra1Ar?=
 =?utf-8?B?L0hHN2dOQ3FMRU1lV3RudkJLNEhhWTgxbWxZQldLU3F1WGxEbDFPUWVFVXVj?=
 =?utf-8?B?QUVOT1FVOEhma3ZyY0dvcGUydi9GT3p1Q2p1SzNGUm9zOTl0NkU0L3JoeDha?=
 =?utf-8?B?NGxPN05BY1YvTmxpSEo5N2VGTG1JbDFuQ09naVBLWEVoM0VSNXVhbWtPMVQy?=
 =?utf-8?B?MXFmbHdteFJ6bFhMTk4vWlNZMFlYOURqQURPYXJmMmtxRGN3SEdHZjBuZzc0?=
 =?utf-8?B?OUFLRnVCU2kyV0JKLzFQanF1WFVJOEw4NEp0Q1pGb1ZGeDlWaWphUUQvZ2hh?=
 =?utf-8?B?b2hFTW9HU3BQYmRxckVJanFVc2E1YmdzbFVqSFptelc2NDZCWldkY2c5YjF2?=
 =?utf-8?B?K2c1VWMxQ0h5SDhacklidjBxN2wwSy9teHM1Z2UybmUwSURnaFptRU5wKzdX?=
 =?utf-8?B?TFRzdjZqcmJINUN4cmlqRWh5dTZKNit6bnVSazIyZ0xyQUFJZkZKaWhwS1cy?=
 =?utf-8?B?Y3NHb0hUaVdGNU5YcFFjRGtXMzFxMmp2WWtnbDFXV25pSkpJZ2IzKzQraTlK?=
 =?utf-8?B?U3pOcW5yOUN6UDZhSDV6N2xLcHBzL3NsUGwzb1hPSVR5QnhsUUxsOGRTcVdS?=
 =?utf-8?B?b3lPRTZoMjRwdlVpWFpLMU90ZTFqdDJOamd2UW04aVVCNmp4SWZGdEt5dU9I?=
 =?utf-8?B?N2FMaDlRbEZvVkg4dlNoclpTRFZaeGhYNkZocmpoenlSSmN4bXFubDJoeXV4?=
 =?utf-8?B?RDlySytpcVluWHRFaVJHbDRUanlWMzZ2cVZySzJzamt5bVlRRFJrNHRBR3cy?=
 =?utf-8?B?ZHY4dUN0VFNoTC9rcERnbUZ6Yk5mQ3gzcmVueDZsdHowcStBdUZadGVVUy9U?=
 =?utf-8?B?ZjFSL0phZnRUUWlyN094aW9qcEhEeUptVzZ0NVpSbS9NQnRYc095dXpoVEJi?=
 =?utf-8?B?dVFURzAwMUlIdXdwT0lUR0tSZWFDa3RIdnRzVUVTRStXTVNML25jMjlhOVcz?=
 =?utf-8?Q?w7XlbQcvfeZC0SjGfOFGfnfr0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db3a20-3c32-4d05-f0a9-08db94f8506f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:37:22.9634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZGKwyQjYWMs1QANXr0IKV6EdfB8zYKVPo/9esQbthUvZ1nDfNJhF9WCLywYYXT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/4/2023 8:02 PM, Yang Wang wrote:
> From: Yang Wang <KevinYang.Wang@amd.com>
> 
> add metrics.AccumulationCouter check to avoid driver getting an empty
> metrics data since metrics table not updated completely in pmfw side.
> 
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> Tested-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 6253ad13833c..5adc6b92bc49 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -325,14 +325,24 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>   	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
>   	struct PPTable_t *pptable =
>   		(struct PPTable_t *)smu_table->driver_pptable;
> -	int ret;
> -	int i;
> +	int ret, i, retry = 100;
>   
>   	/* Store one-time values in driver PPTable */
>   	if (!pptable->Init) {
> -		ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
> -		if (ret)
> -			return ret;
> +		while (retry--) {
> +			ret = smu_v13_0_6_get_metrics_table(smu, NULL, true);
> +			if (ret)
> +				return ret;
> +
> +			/* Ensure that metrics have been updated */
> +			if (metrics->AccumulationCounter)
> +				break;
> +
> +			msleep(1);
> +		}
> +
> +		if (!retry)
> +			return -ETIME;
>   
>   		pptable->MaxSocketPowerLimit =
>   			SMUQ10_TO_UINT(metrics->MaxSocketPowerLimit);
