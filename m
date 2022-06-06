Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C5CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F274510E736;
	Mon,  6 Jun 2022 14:06:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F93210E736
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k54Bcj8PAn1rVxgAqz/8KEx4Ena5c6MQK85+T7hV84kUtF1MNg3XyHLl8DYstfWumUk9s2q2tYrSGbZ2vgyM+KmAjC+Zjon/r0MEWFLGr3ZnBUPCi650KrIjaSdTkU0BjUhsygkj6H3+CP32MHrISdZqdnZHpTmlBOyoNpKXnSbZFydssVO1s+aiP1YCFW3zRw7DDE3lmDL82+XElz4LR3mvKa3mFFNbWJKdgmYaC8pDsalFf1t0qwfgM6yVVwHYBGN9NM4O00ymAVMmHlAguKVIshyA0rJdzGOfoCHkeOzqbcd79VATgo4c8d7m/xz9Vg+sx3iY7NOxLHAojCH5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjWtr1XdeSxSmp1nerwxJYQie8ZBaRLY48RssILliVE=;
 b=J/kuS7E9ELrXZ1TKdPWbvhPwXZaI0XSGN4BsN+GwrrVp2eV+uDLDlhzmSbWeBlzG03eQKQL1CUZNK35+ng/Q60RxwLHhGDXohzrqyDjh2geMmkRRoCMkTajRkZDnyCjJ1X1iudiu5aX0TiwGiFreZVXQDXyWAhzBCmvaw8Cwm/aTXXxhwTuNlwIRjUog57X43h3MZ22BwFWG6yS0CH910+C71/DB8V2AslQcNYQzIpEUq43Hrq/tAWsDu7jzkNI5ROELrpZ4A0ffLL9hOs6jdNbgTaKDWpvMiVcvqmQMq1Scq2mRJFlW7S0+vJi2aa6vmkTw8Wb3iFYOQO5D/htEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjWtr1XdeSxSmp1nerwxJYQie8ZBaRLY48RssILliVE=;
 b=bZ9GMFVYlBqluRWc4jDR9mkJIaAuOrLQ8ubfIVVvvMNmkNfdYPWB40re8GRJn8eJzHIRM++QbqN3pDFzKHSebEpbOkRJ1/ZXQ5oHSSvThdw/QgOziAJAbLiPp5D086JhuIbJ42dvbMn1kwNM+8yuvtd4AjKkEcDmgZd/WOsPLCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB1290.namprd12.prod.outlook.com (2603:10b6:3:74::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 14:05:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:05:53 +0000
Message-ID: <42d357c6-7676-b0db-8529-a36b924b06db@amd.com>
Date: Mon, 6 Jun 2022 10:05:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/6] drm/amd/display: Reduce frame size in the bouding box
 for DCN20
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-3-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-3-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8db016e5-1d02-4d04-fa2e-08da47c5ab06
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12908F3B038D084D94931CB68CA29@DM5PR12MB1290.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuMz1o2eCqHZJTZGsIQBvh6OQzMWyfKsfFBkjpOcbeBd+QnAcsApFZay9SjIYvg4FvqC5DpyuZp1oN1ahkrYHMYSyYJMnlbVo0og+K2YBNPh3XQYkn/AkuGAAB+z6TGDehses0EUV/R4WoTUCzdyOn26oBZwNT4sD6vtKiwi4T5OWXDUDEWGF2ymjugkIV/03eUpZ5/cZCp4wtET6MnU31zhKWj3qlEElSL9E81vkE6Yd8uiIjoAir6Jhhu6tPnwkCN9VPDqAaj0ot1wVh6qs/QVn7zmzjNUBaPzNdl9W4ZoW5yf0DGe7CTA+rWlBzSEv7FbWXisEI/AH1WC3S2dNjifmfRxQq7Cp2K59FZGv9RtPZXxprIYoHO3kw3ZADkkdsTSvh5ctp8WCqmGekO5OoXUqMB0VjfE62rZcMtwBrTn183VUhTlh2BQxXCBKRvQzkcB4peIDb2ETh7W60uZc7TW8u8Tdo4ePjYV4c005ysum3genHUFF4fiQPTEYZa+A48AlACA+gDo81dqtjuDVqociLTHsF4zjcqfvwrcmRMX1SDuGY/1w0zDbOtYbDKpG8vZOm2ap27HIZFYbysDaMETU/jP7JZXt12MPd9AkTYS8+X+nRypqrR6NqNwAD1Ypr09FbJJgDshCqil5hXsVakioYTlsGTvb3q8ZrsjJUF9wseqTS8h4nA9fb0cbfw8oSeGWTQ2VtAFgwOOr9213TnZpjD2gtK5D24opgn7nBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(66946007)(31686004)(6486002)(8936002)(66556008)(508600001)(186003)(5660300002)(4326008)(2616005)(8676002)(66476007)(54906003)(53546011)(26005)(38100700002)(2906002)(6666004)(316002)(36756003)(83380400001)(86362001)(6512007)(44832011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpuZEpFRW9mSGlaTmIyby9tZDZsMEgwYnhJbVMrc3ZuVnRyUUh0dnEzalFh?=
 =?utf-8?B?THNDeHh4dkFFQThHTzBTN3RQUzhtV1hlR1Uzb3hEc09DYTIxV1dkME1USEdh?=
 =?utf-8?B?L25yL0JLb3NRdCtIQ3FKa0RNSm1SNFowVmUvLy9LT0M4RVBXdnRJRnVMK2F1?=
 =?utf-8?B?T3VlVk1qUGlUY3dMQjFaYVR2c01sY1M0MTh0Mm9kd2JORFpXeVkzcHZBZmJM?=
 =?utf-8?B?dFZ5V2Z5aWJaenF4YmhTVVN5bWRpS1lSQlNoQ0lNVHQ1S0FqdVhUT3c2dE4z?=
 =?utf-8?B?ajBEdmlNRHFPdkFLamE5Qm1rMjJ2K09nMlExd3RtTWkzdUtKODdZTmZpMksv?=
 =?utf-8?B?MTVrMkEralB2OE1ya0NveEZxQ2UwTkVidTlIRU5hODVpUzlyZVZ4YWs5M3pJ?=
 =?utf-8?B?ZDcrcmdRdCtDVWtVRWpjUW1oY2cxd1ZWQ0tJUDJsQVhtWGF1dGZPN3BOaDlm?=
 =?utf-8?B?Q2xkRmN1NHMxWUxmbllCUnlHemdvckxYNnhhTnVhNFE2TENlK2Qzd29nN0pY?=
 =?utf-8?B?aHZJR0J0WW9aaEV4aWtGeWIrbUtKbmpBM3RLcWh3NkVUU0VacUNMMUVteGRr?=
 =?utf-8?B?dmlnRFZVSVJQSkcydjFTWlluUTR4OFlZYmRNNDl0Zi9tM2V6OWpJc0NMU1B3?=
 =?utf-8?B?SDNnVFJpLzNWWWhkNnpBQjlJa3ZUV0FHUzQ5c0JvT3QzN29hM052Ti9USVJC?=
 =?utf-8?B?aFlldHR2cGpxMDRWOThvMW5ONjFmWUJFT1BvcGpvb2xGQUNwS3p2YUdRTU1K?=
 =?utf-8?B?c3ZtT1ZMOUhCOE9ZakxGdVlWSUZQUHNyeUpVaFJqbFJSelZ5OGo3ODdOTy9j?=
 =?utf-8?B?OG13SmVscG9JWm9mS3E2QjM2VGE1WHUrd0ROM21ZL2NzNmZGQWhFUGQzeDF6?=
 =?utf-8?B?amRKRGN6eit3aVhjRjVmNy9DQVlCOW56eG1yTXpuQmxMcUxGMzltL2FVc0N4?=
 =?utf-8?B?WmZjUHAyU29Wb250NWgvbHlPZTk4aG9OVVcrODh1STg3UVFPTXlpTndtNC8r?=
 =?utf-8?B?emNPeTh6WGtlK0JxUUFGNTl0RG5zbCtzaWFFL2lLclRzY0Q4LzlqUGlpczR2?=
 =?utf-8?B?M0NvZUVDeXBDdzhzR3cvdnZPeFBwN0VzQlRETEVtVytRMXIycHFZN2FSTEJ3?=
 =?utf-8?B?dUJFd1VOYXptMm9CVDIyREdEYmY5Tk03dnQ2eUwvRXBlVEpkaVBSZEx1MWtU?=
 =?utf-8?B?VVFwSmtNSHVtZHZvYU1mRjAvWkJLUkZvM2hFOHdqaEZ3elRPNEVwdnBjM256?=
 =?utf-8?B?YWRhTGw2V3hzWHNOUHRvVnMrakVERDRHR2Z3VURrcFFsdFhqSnRRdzVwcXBZ?=
 =?utf-8?B?QllpZ3dvdkRsMG83Y3AxVWNSWGROcFJ1MEI4N1k3VDJHZkw3dm9XMXVCWDRM?=
 =?utf-8?B?NjVkYjl2YUttS1liOUM4NHNHb0FSL1RLMEpYekl6akRBZjduc3hsRzdSZjc2?=
 =?utf-8?B?SmptclArNXdsVTR5YnJuQjFueGQ1Tlkza1NTSkovMUJPUWh2eUt3YXJxNjhO?=
 =?utf-8?B?WlIwM29lclkvWVdVRWFXZVRZS1FwUGZKSWJwOUVWamcyN0RCSlpsZ2hwb1lN?=
 =?utf-8?B?SjFJUHhvTXBUSXl4dC94SSs2dEUrT25lbE0rSWxLMnZoOGI1TTR1eUJiWTNk?=
 =?utf-8?B?NVNQMjMwaVJIb1QweFpMQU0vSVdHVm40MDllVk4xZUZQU1kvcnNWWFphTnJD?=
 =?utf-8?B?ejZUUXhCbzlpSjBzMjNZMk55ekVndUtYdktVemlMWG9zRkMrbDl2UzhISlU4?=
 =?utf-8?B?Q0dLS24yYVp5czdnbjJnZk1RUE92bkE1bDJDVXR2MWVsdk1BdHNZUnNFcVg3?=
 =?utf-8?B?RFNuZVNKbGdtM3lVMlgzOTVqV2svczBKSjBxMUJkazZLbGFNVUtQWlczbUFB?=
 =?utf-8?B?b3hwaW9FVW9nRVdYMWYzRTFHNE9COFBJT2cxckY5VFFuRjNoUFJiV3hLU3Qr?=
 =?utf-8?B?Rk5YY2VVR1dSUWRNS05hRm4yNGczUHcxcWt0NjQycG9YYzIrd0JCOGY4VE1L?=
 =?utf-8?B?dHc5aVN1MXUrNTUyb3NEcGc3MThvanlsVXVndUFZeDAvYXBwZUJ0cHpqSk10?=
 =?utf-8?B?c3NpSnBzZWlFWERjUk1XL2UyQzFtZjJ4aGk1bmd3bTNmeHhOcXVYa0hEZjQr?=
 =?utf-8?B?dFpNRUdPdS9kbHBZSndPdTJSbHM4QmM5RGorTHJXWkNGS05oZ2hZM1d4RUZo?=
 =?utf-8?B?MHhFYzgwNzlCdVJVQVlRWm1aWVZSVk5wd1BFZnpZemlUVzJJNFk3dGVITDBF?=
 =?utf-8?B?eXVSdytzN1dWWFNPWnpJOXp0K2xabzc1VHNMazlGdUwybEtub1NJa0RycDFx?=
 =?utf-8?B?ZzlUTUhZQ2ZyZi9qeWJ6Z0xPanUxZ0lrTUZNSXNqT0lZVjRYZGVEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db016e5-1d02-4d04-fa2e-08da47c5ab06
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:05:53.2336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2UTocGwZi4jWQR0Xo6MKWGe4WhVuqn3QQ6PoPXySIhkf53/u8mtuay5YMxqsnli/HM0hIDEC+43yiwl6jbxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> GCC throw warnings for the function dcn20_update_bounding_box due to its
> frame size that looks like this:
> 
>  error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> This commit fixes this issue by eliminating an intermediary variable
> that creates a large array.
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 38 +++++++++----------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index eeec40f6fd0a..d9cc178f6980 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -1456,21 +1456,20 @@ void dcn20_calculate_wm(
>  void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
>  		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
>  {
> -	struct _vcs_dpi_voltage_scaling_st calculated_states[DC__VOLTAGE_STATES];
> -	int i;
>  	int num_calculated_states = 0;
>  	int min_dcfclk = 0;
> +	int i;
>  
>  	dc_assert_fp_enabled();
>  
>  	if (num_states == 0)
>  		return;
>  
> -	memset(calculated_states, 0, sizeof(calculated_states));
> +	memset(bb->clock_limits, 0, sizeof(bb->clock_limits));
>  
> -	if (dc->bb_overrides.min_dcfclk_mhz > 0)
> +	if (dc->bb_overrides.min_dcfclk_mhz > 0) {
>  		min_dcfclk = dc->bb_overrides.min_dcfclk_mhz;
> -	else {
> +	} else {
>  		if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev))
>  			min_dcfclk = 310;
>  		else
> @@ -1481,36 +1480,35 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
>  
>  	for (i = 0; i < num_states; i++) {
>  		int min_fclk_required_by_uclk;
> -		calculated_states[i].state = i;
> -		calculated_states[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
> +		bb->clock_limits[i].state = i;
> +		bb->clock_limits[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
>  
>  		// FCLK:UCLK ratio is 1.08
>  		min_fclk_required_by_uclk = div_u64(((unsigned long long)uclk_states[i]) * 1080,
>  			1000000);
>  
> -		calculated_states[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
> +		bb->clock_limits[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
>  				min_dcfclk : min_fclk_required_by_uclk;
>  
> -		calculated_states[i].socclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
> -				max_clocks->socClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
> +		bb->clock_limits[i].socclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->socClockInKhz / 1000) ?
> +				max_clocks->socClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
>  
> -		calculated_states[i].dcfclk_mhz = (calculated_states[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
> -				max_clocks->dcfClockInKhz / 1000 : calculated_states[i].fabricclk_mhz;
> +		bb->clock_limits[i].dcfclk_mhz = (bb->clock_limits[i].fabricclk_mhz > max_clocks->dcfClockInKhz / 1000) ?
> +				max_clocks->dcfClockInKhz / 1000 : bb->clock_limits[i].fabricclk_mhz;
>  
> -		calculated_states[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
> -		calculated_states[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
> -		calculated_states[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
> +		bb->clock_limits[i].dispclk_mhz = max_clocks->displayClockInKhz / 1000;
> +		bb->clock_limits[i].dppclk_mhz = max_clocks->displayClockInKhz / 1000;
> +		bb->clock_limits[i].dscclk_mhz = max_clocks->displayClockInKhz / (1000 * 3);
>  
> -		calculated_states[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
> +		bb->clock_limits[i].phyclk_mhz = max_clocks->phyClockInKhz / 1000;
>  
>  		num_calculated_states++;
>  	}
>  
> -	calculated_states[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
> -	calculated_states[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
> -	calculated_states[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
> +	bb->clock_limits[num_calculated_states - 1].socclk_mhz = max_clocks->socClockInKhz / 1000;
> +	bb->clock_limits[num_calculated_states - 1].fabricclk_mhz = max_clocks->socClockInKhz / 1000;
> +	bb->clock_limits[num_calculated_states - 1].dcfclk_mhz = max_clocks->dcfClockInKhz / 1000;
>  
> -	memcpy(bb->clock_limits, calculated_states, sizeof(bb->clock_limits));
>  	bb->num_states = num_calculated_states;
>  
>  	// Duplicate the last state, DML always an extra state identical to max state to work

