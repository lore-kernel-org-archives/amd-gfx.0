Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735D8C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 05:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1864E10E649;
	Fri, 28 Jul 2023 05:31:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2744210E649
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 05:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMOjzcL55olGvhB7/oiXGRsp4YfAubJW3sglZOheYCeQtDpcfKmuOweYEE0ayEOMfxowWXiVrohQElyKp3UabcFtVSqsMTyFbGcdKQZJpQA7gJPFFnzEDgRHoEUn6Dlw3Q4LN3fUJ2nvXN6tDSX0qCTaTnF0hwoTiHPC9YhQh0z+takT6hxtcY5lIHLg2h+IZ7q8vJ8POnOoknqHz9cjpv3iO9a2lsYU4dSAlSRw0GQJE4XsnHUcfM1uNuRK3vV+E1OTuQXG7gSd+rYSW12UfSFh9/0eH+Q4JE22D3pDr9UqqunCb8pcjblUSjYWBxUezhjRrR4MqI7H0PrVN2tzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6U6G72TEMVkGBW87Dz6W/KyuNnfdSonxPwpUsHYJ9s=;
 b=I5M/WOzL0ov7CUVfWQoSv/ssocEdDQKijp9zjGtCJpKQkaQf9qh7qT/dSNhZw6N7w1+GbmAZML1nJKivWm2QkA7H3NB/ycudqyhKyqerkWzv3UhmlYtgCyOLE5UhWO1hbJ8ovFx/Pk1+PJZKXiLfwpIWjkntrP3O916jJTDaIER5q+/bov9hdHIVQYfr9qZivhLolpDFqYew0BFdCkX0pXnMo1KhD5tE8KRBci/FW6ezFHGQS7FlGeRB7fguDSOPFP5qlmYOnuL4EfjGwdO/563lzhgRBE9TfECg64Z1E2ZxR1qp8j+TadJKh4mld4gPg/5aKFM+RUwuji7xuOSE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6U6G72TEMVkGBW87Dz6W/KyuNnfdSonxPwpUsHYJ9s=;
 b=pZZ5U4FXK1al9F+lKnukKN90AR7xXJS+IBYnpzy+ECuF8E+drCNCBlD0M3d6lkGZInunsFLjlwcUJc60iNytGh8ifIvWiueH/qF+1gGR9xEnCi5YX3P1JX2YPPWDWSgwZhxCqxN8chPFhvO6oCVArgCC5Pb3vlVD04HSoHpmFsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:31:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:31:39 +0000
Message-ID: <1a00bbb8-3102-2000-1194-af937071eda7@amd.com>
Date: Fri, 28 Jul 2023 11:01:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 5/8] amdgpu/pm: Replace print_clock_levels with
 emit_clock_levels for aldebaran
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <20230427062718.1172269-6-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230427062718.1172269-6-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: ab619d5e-a712-4d06-03d6-08db8f2beb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWn1hz9OW1oC3P0cJ/a/SkorVUxGGSSAGj8/95DOru5vS88jgLbOQyspeXsCSMgC3GfUcPM4T1eAFLrFJdu5WZZO0Td0jUTuemzJY5E5uDRslK7Tk+yO3FewyB7f5A3gyoezet+kYKx+s5bFKf+feQu/wsslnBYKbqEztIDA+N1m2L4lGOjR/uBI14HRTgkSlHl56B51QM1/me4bpXmdzahXVI7zAsO99qSmG88DDx37QahLLMuHVr1DaYWUFUfggBT/VGp8v1cm1mJY9bYSRQ/367ZBCeFaR1L74+KaPTVmRp8MnCTnYwsV5xFM8x/vYcrPZUwrqqNjlmJMxqh3X4qDO+Utx7TpC+t2pJWvLwHk0fFPPhymJ/8aolfXFTiuOnyjWbbLMY44s9tCHAgkHTXxgoiOc29R3NhmdYl4nWCha6oj3tJ4eztIXIY7jv8AM7vk52C8T6IZZG72EzmjOwWncLQKcEUSLQiMDxwR5VInraSKTzbsZxyWViZuEmZKGR/yTdz3ilsRTxhNghIjKnJLW9FLZkTqlSuu3amHNM0krdnLrHmIe0Cthyd/eAFo9KujqOiNjfdPS4TYC6ik+k7qhwNgbiJu0rNPIcTF/jMlHWxu8dOg3ybF6zdCFYPDVk7gb0kOLex7OKmquPCQ0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(31686004)(83380400001)(31696002)(478600001)(316002)(8676002)(8936002)(36756003)(41300700001)(2616005)(2906002)(86362001)(66556008)(38100700002)(66476007)(66946007)(5660300002)(4326008)(26005)(53546011)(6506007)(186003)(6512007)(6666004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdjV3FMT2NaZXVhbWtteW5EZEc2bUlUV0pGTTlVQXRJeGxKWGZyQTRPRXlW?=
 =?utf-8?B?QkxrWEkva3VlKzJrU3d3MWNHRm5ZU0xaa09aRnJmN2NsNXFCRlpQaDZINlZj?=
 =?utf-8?B?ZDUyVmJZdjJJVlN2aEdTMTUzbDNOdjUvbzcwTjF1MndnamljeGZhZENVTEt1?=
 =?utf-8?B?V21XeGxJK0c5cVJPTlNBR1pxQWZySXp2d3NVQmFoMG1qYWZzSkpEOXhTT2Z3?=
 =?utf-8?B?dVRrNmNiUEJ2N1FkNjV1VVRKVlo4eUhldmY3M0FySENqWktmU1NaZ3gxYTJD?=
 =?utf-8?B?U0pheGN2b2pZaDhHOGVLWHdROWlDUytRSmFjSGJVQS83MVhQUE9hKytrbndZ?=
 =?utf-8?B?UkJBSWtHTTFJZkVNOVFucWxRUzdwQ2gwSE42bDRrdGFhREN3OE9xYUFkWkhP?=
 =?utf-8?B?TDd5S29UclBBNW5yWGFmTXFKOUg2a29mMHdaNzM5VVBVYUFZb3FwVzl3S1J4?=
 =?utf-8?B?UjJqUEFMK3lneThPZFdTTnpTWERPT0x3amFmQWVXVVErOE9pdks5elVsbCt5?=
 =?utf-8?B?Y01JOHowVmQvWnBwWDFFbWU1NC8xbElhQ3oxRWxha1dqbUl5SnpLQVBnMFQ2?=
 =?utf-8?B?ZTNtdzduSm5DeGlCOGd0SU8rNzZtUUZ1VHVranY4NjJoU0FPV1ByTk1xaUtQ?=
 =?utf-8?B?S2pCbCtybUd1U0lhNkQycVRIRmNJaFdkaXRVRGtBQXEvSEc0RmhNOURnV0k3?=
 =?utf-8?B?Z0NZSzk1aXlsTDM2cXF5V0w4c3hheTArS25QbCt2RGR6VDdRVURwcGdFcnFO?=
 =?utf-8?B?YWp4dTZaTHQwT0ZoMW9hQzZqNTF4cU1idndWR1lhWGxMOGd0cFhtcjhNYTVr?=
 =?utf-8?B?Nlo4c1dFbjE3TXFLZDcwaVpZL1ozNVkxYWdTYWt3QjJGT1pVWjFpNXhMWUds?=
 =?utf-8?B?OHlHOGRUY2MzbGZPb3gwNDVMYTZCM3I5eHBsL1ZtWVdGbVpxdmpJcU1KT0tn?=
 =?utf-8?B?VzgvVC9yMnljNXA1UTAxM2wwYlM2bW1KRThYQ0phcUV0cGpOcmw0ZCt6dVlP?=
 =?utf-8?B?MThYeEVGZEJpOVVGUzVXRmtjSlJMUWptSy9Eb3RRMkdnRE1JOThVSWJxTWsz?=
 =?utf-8?B?aWQyTG04SVZpdXpTUjJ5eHlaWW1JY0Ura3BGUk1PcGhGMStMRy9LNHIyVFpU?=
 =?utf-8?B?Vlp6cDJLbWprR1pvamJUamM0V3NiUjZnM3VZVGJ3MXMrd0lRd3hSWHF4d3V3?=
 =?utf-8?B?czVtNGtVZHdnQXFEbG1Ha3A0UHl1U3NTWmNDMzluUkVqSmlVb0lQb21uZmJ1?=
 =?utf-8?B?RjRaRzV0dXBPZzJZQTdsTkRIb3ZyaFRLNkVrT3oyMkNDZHc3UTNtNjk0TVli?=
 =?utf-8?B?TjY0bU9hZVM0eGZ3THJEbmJiVzNtK2hxREpNRU40aDR2MC8vREdSR1lXTXFQ?=
 =?utf-8?B?eUNQU0w3dmpnMUlpdVUvd0xNeGFQdlpMWlo3WlZQdWJweTBsWFpGUVlhRkxI?=
 =?utf-8?B?dEpGRjBNYjVtT3duc1NzOHJKZjZVOGh2bFFOZjNZdEk5bjh6Z21kVkNpTVM2?=
 =?utf-8?B?STNzbkkraUl3N2tZMHNhTWpyTEI3VHYwZ3VUeVdkdm90SGpublpubFdOaUo5?=
 =?utf-8?B?UlNKT21IcndLQ3NXK0NieUJWbHpBSC90ZTlvYndPUlBRcWVFdnVQTUJzaVZT?=
 =?utf-8?B?cnlkdEdBQnF6Ris0WndFN0UwSjVDMHpmOHRaQjdUL2RYYTF5L3FZbUlMdlYx?=
 =?utf-8?B?QW9WTUhESHJmUEZheEgxaGprSVVvMUQ2eFhMald5TlBLYVp5MFRydWRiSHYv?=
 =?utf-8?B?aW1RU3JxM0RVbWd4ZFI0TSsvdXcyZWNkTEJyU296QnB0NWdGQmpoVllPbXhI?=
 =?utf-8?B?a1JPbFpNZkRaY2lqQW1zdEFQc25QdWlobGxvbmVFSUlMNlg3cEdiaFFvQ1JG?=
 =?utf-8?B?cHg2SkJYS05GUW1LZWtXdit2bjNnNXRBcmt2SWVScUFwTCsrR0d3NGsySjhB?=
 =?utf-8?B?REY1THhXWG5UNkVlOTFYa1c5WFFqMFZ2UTkyNXBLZEVoWDM5V1FHajVRT1pi?=
 =?utf-8?B?Wm9ROXo2c1BkYkkyRDVBUFp1TzhhN0lRQXdZVVNuY0N3N1NJVFA2TlBnTWdw?=
 =?utf-8?B?Z3BROW1FK1JSOHJRUm41TERGVkJrRmJEa3RKcTFkOHc5Qk5OZ1pkWE5xeFJQ?=
 =?utf-8?Q?Twh8b6ZA4EeNbFwDsmes5eWXB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab619d5e-a712-4d06-03d6-08db8f2beb02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:31:39.5980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwiac9uLCNM+45oRsJ/P97xzTgwggyTwGblTudAStg0whcsWvr2+amK8JlmP/mTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: ray.huang@amd.com, evan.quan@amd.com, lang.yu@amd.com, david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/27/2023 11:57 AM, Darren Powell wrote:
> Replace print_clock_levels with emit_clock_levels for aldebaran
>    * replace .print_clk_levels with .emit_clk_levels in aldebaran_ppt_funcs
>    * added extra parameter int *offset
>    * removed var size, uses arg *offset instead
>    * removed call to smu_cmn_get_sysfs_buf
>    * errors are returned to caller
>    * returns 0 on success
> additional incidental changes
>    * changed type of vars i, now to remove comparing mismatch types
>    * renamed var s/now/cur_value/
>    * switch statement default now returns -EINVAL
>    * RAS Recovery returns -EBUSY
> 
> Based on
>    commit aa93bbdd1492 ("amdgpu/pm: Implement emit_clk_levels for navi10")
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 63 +++++++++----------
>   1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index d30ec3005ea1..f93a50217239 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -736,25 +736,23 @@ static int aldebaran_get_current_clk_freq_by_table(struct smu_context *smu,
>   					      value);
>   }
>   
> -static int aldebaran_print_clk_levels(struct smu_context *smu,
> -				      enum smu_clk_type type, char *buf)
> +static int aldebaran_emit_clk_levels(struct smu_context *smu,
> +				     enum smu_clk_type type, char *buf, int *offset)

<Nit> It's not necessary to match the name with the API call used. For 
me, 'print' is more obvious than 'emit'.

Thanks,
Lijo

>   {
> -	int i, now, size = 0;
>   	int ret = 0;
>   	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
>   	struct pp_clock_levels_with_latency clocks;
>   	struct smu_13_0_dpm_table *single_dpm_table;
>   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>   	struct smu_13_0_dpm_context *dpm_context = NULL;
> +	uint32_t i;
>   	int display_levels;
>   	uint32_t freq_values[3] = {0};
> -	uint32_t min_clk, max_clk;
> -
> -	smu_cmn_get_sysfs_buf(&buf, &size);
> +	uint32_t min_clk, max_clk, cur_value = 0;
>   
>   	if (amdgpu_ras_intr_triggered()) {
> -		size += sysfs_emit_at(buf, size, "unavailable\n");
> -		return size;
> +		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
> +		return -EBUSY;
>   	}
>   
>   	dpm_context = smu_dpm->dpm_context;
> @@ -762,10 +760,10 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   	switch (type) {
>   
>   	case SMU_OD_SCLK:
> -		size += sysfs_emit_at(buf, size, "%s:\n", "GFXCLK");
> +		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
>   		fallthrough;
>   	case SMU_SCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_GFXCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
>   			return ret;
> @@ -787,29 +785,29 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		freq_values[1] = max_clk;
>   
>   		/* fine-grained dpm has only 2 levels */
> -		if (now > min_clk && now < max_clk) {
> +		if (cur_value > min_clk && cur_value < max_clk) {
>   			display_levels++;
>   			freq_values[2] = max_clk;
> -			freq_values[1] = now;
> +			freq_values[1] = cur_value;
>   		}
>   
>   		for (i = 0; i < display_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n", i,
>   				freq_values[i],
>   				(display_levels == 1) ?
>   					"*" :
>   					(aldebaran_freqs_in_same_level(
> -						 freq_values[i], now) ?
> +						 freq_values[i], cur_value) ?
>   						 "*" :
>   						 ""));
>   
>   		break;
>   
>   	case SMU_OD_MCLK:
> -		size += sysfs_emit_at(buf, size, "%s:\n", "MCLK");
> +		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
>   		fallthrough;
>   	case SMU_MCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_UCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
>   			return ret;
> @@ -823,16 +821,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
>   					i, clocks.data[i].clocks_in_khz / 1000,
>   					(clocks.num_levels == 1) ? "*" :
>   					(aldebaran_freqs_in_same_level(
>   								       clocks.data[i].clocks_in_khz / 1000,
> -								       now) ? "*" : ""));
> +								       cur_value) ? "*" : ""));
>   		break;
>   
>   	case SMU_SOCCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_SOCCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
>   			return ret;
> @@ -846,16 +844,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
>   					i, clocks.data[i].clocks_in_khz / 1000,
>   					(clocks.num_levels == 1) ? "*" :
>   					(aldebaran_freqs_in_same_level(
>   								       clocks.data[i].clocks_in_khz / 1000,
> -								       now) ? "*" : ""));
> +								       cur_value) ? "*" : ""));
>   		break;
>   
>   	case SMU_FCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_FCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
>   			return ret;
> @@ -869,16 +867,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		}
>   
>   		for (i = 0; i < single_dpm_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
>   					i, single_dpm_table->dpm_levels[i].value,
>   					(clocks.num_levels == 1) ? "*" :
>   					(aldebaran_freqs_in_same_level(
>   								       clocks.data[i].clocks_in_khz / 1000,
> -								       now) ? "*" : ""));
> +								       cur_value) ? "*" : ""));
>   		break;
>   
>   	case SMU_VCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
>   			return ret;
> @@ -892,16 +890,16 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		}
>   
>   		for (i = 0; i < single_dpm_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
>   					i, single_dpm_table->dpm_levels[i].value,
>   					(clocks.num_levels == 1) ? "*" :
>   					(aldebaran_freqs_in_same_level(
>   								       clocks.data[i].clocks_in_khz / 1000,
> -								       now) ? "*" : ""));
> +								       cur_value) ? "*" : ""));
>   		break;
>   
>   	case SMU_DCLK:
> -		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
> +		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &cur_value);
>   		if (ret) {
>   			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
>   			return ret;
> @@ -915,19 +913,20 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   		}
>   
>   		for (i = 0; i < single_dpm_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
>   					i, single_dpm_table->dpm_levels[i].value,
>   					(clocks.num_levels == 1) ? "*" :
>   					(aldebaran_freqs_in_same_level(
>   								       clocks.data[i].clocks_in_khz / 1000,
> -								       now) ? "*" : ""));
> +								       cur_value) ? "*" : ""));
>   		break;
>   
>   	default:
> +		return -EINVAL;
>   		break;
>   	}
>   
> -	return size;
> +	return 0;
>   }
>   
>   static int aldebaran_upload_dpm_level(struct smu_context *smu,
> @@ -2079,7 +2078,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
>   	.set_default_dpm_table = aldebaran_set_default_dpm_table,
>   	.populate_umd_state_clk = aldebaran_populate_umd_state_clk,
>   	.get_thermal_temperature_range = aldebaran_get_thermal_temperature_range,
> -	.print_clk_levels = aldebaran_print_clk_levels,
> +	.emit_clk_levels = aldebaran_emit_clk_levels,
>   	.force_clk_levels = aldebaran_force_clk_levels,
>   	.read_sensor = aldebaran_read_sensor,
>   	.set_performance_level = aldebaran_set_performance_level,
