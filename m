Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EB0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 15:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C8210F16D;
	Thu, 19 May 2022 15:37:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B194C10F16D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 15:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H06XANSOjl9yZt5m5QwY+UUFLLtDi+Tr6kJOyNnxRmIIiOVZm42ceFjWftn+sAqz835O1g59JmwzOxhWV+YdSEpAkKMJMllf2Go7J4aiXLfFqIe2A9vePkwqQcoBwsUjE/SZ6jw1DWtNXJKldFMY84U2XHHWole6wW7hbU9X9ZYGhDBZa6so67PtwG9fbjxHwf3nKnTNqSU0/PdNk14etNSHT8vEe97/FN8lAyBJ9k4Khss9+teKsKI6cdAuF1Jp3rfA7RzXF36VWY1C9U4dJDZel5A2kjj2RK/9wBfNoLH7xlasFtkhF0Q6g8nW/3ZhsWMLcZiJo08fFOljZkr59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx9U9Ck76HRGMOBs8UqL4N6VbOaqb1J9u7RT99Z6ECw=;
 b=go/xdtzyE21X/ZiZrlgjYQjt1hZkU0/DSlY6Cf9KvvVXO06fAghAI/eoeT+ZoMdpRSfp69eZdJwjEcLtVOTy4dlXJN8CeTCoSO0c4wbOhjl0KYBZ2hJSvP+NvSXohZiuXH41bHaRbllzQTeRMW24K1MtrbdGT0zw2MCR1W4baodXrKEyOFVSRjwRZdO0/4+k+0w0OH8yPfbkhfjbzBQA1YYZE+Jd9dat1Q6a4Noxhf5Ea24JXP6H0xlOXUVl8ZuryVr15Yj7maBdxbj+S5w+UGOCk5wv3CyRFiASUb98LAm2d48IuS2775FZQ1+VwLYZkonbO0sAgXHPmQlB9Ua6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx9U9Ck76HRGMOBs8UqL4N6VbOaqb1J9u7RT99Z6ECw=;
 b=GCMido9a+uPlTyEl7ffgkMhUwpiJm+uiNsxkWDKInAyfYUeDOkEB3KJowZmI2V0hlctQUmlwuqCFHhln3cNYE2slFVQ54Zs6BYxKy4QH/jfyQIoRNnga+jaT9dznTziC2+9cyBu+zip8Kab1Yj17uJIX3+9oGWWc5uL7b7S7m+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 15:37:28 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.017; Thu, 19 May 2022
 15:37:28 +0000
Message-ID: <ca5eb170-a888-02f5-4eb5-ece504690317@amd.com>
Date: Thu, 19 May 2022 11:37:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 19/19] drm/amd/display: PSR-SU rate control support in
 DC
Content-Language: en-US
To: David Zhang <dingchen.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Sunpeng.Li@amd.com
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
 <20220510204508.506089-20-dingchen.zhang@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220510204508.506089-20-dingchen.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54fdd80d-5de7-42a2-eee0-08da39ad7aa1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2921:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2921DACAB911CCFB587DD0998CD09@DM6PR12MB2921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEZ92PluHqiffTMpjITL6blRuVYbSj6OYoMW/NmGJuq+W/Fyl+WdMkECSmlFiKRs5L5OSC94MmCylOVitR09601cg1mk1u91jMq8m4Bcs4q6qAS8Km32em3H3EkxRiDJTxOXAHfBfJIlpzZsalBDNBHZvLkm+HGUx8C9230vUxeHszpt214g8bNlGK1p27hxz2ZwlKAiY2602nCakv4PTKrhQysyQLXIsmrpw5R49tzV6gKqS8L7pUH1/u1cx6xRC4RTJLuKCzfgcoDd08wziYR1lkGkEPiPhVwQj99WK63Qq2p1/B/BZAWui1NsGB/S6AWHxGvS9aBkZQPMTI5lKtw8j9R/M73Kiv0nOhlXuCQL2efTK0Ki3b9Dl6ZncsrcAfI4vHry3I/jR2gzsrQNqCk5pEWm/P6TQpYoom1BxnemQWp67IlA+qmPujpZ7yrmQXGmXKbAV9K8IuTqyoCNJqkkq06SmfbR0ELmFGl6+jT/bQBtspAP/18AVu1vPWcPtUa7xTQJAb28vFQ9RV2LotpRMZCBV6wJQMTNATjyI1wzxCs70ydspkiLC40bhpiW3pYMcI1RzX/k5DTCIlsmA9Us10alUosLaZoxBoXvcO88HFfkdZaQV+0Vj4qeQVIzAcZdxqcY6i9jC/ivI0QgDjJOC6F644UuPWKCZNtuQFTKWL32d1KRxaNJXrvppYUcU4dAKN6Zm+N5QhF8fotsCesXZ8Jk6ifF/27w1U3h2bZHyBDOF9H0PkRQzGkUYMaD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6486002)(66476007)(66556008)(66946007)(2616005)(508600001)(4326008)(8676002)(316002)(38100700002)(6636002)(36756003)(6506007)(8936002)(6666004)(83380400001)(5660300002)(186003)(53546011)(2906002)(26005)(31696002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JQS0hjSUxYb0NtaUdZOUhzSkN5MnNxNGJiQ1ZPOEUrVXJ5a1dlSUZ0dEtG?=
 =?utf-8?B?bHArSU9IR2IwMUlUY2FicE1GZm9hMldhYkFFWkVBeEJsWno2NWF4d2F4Vkc2?=
 =?utf-8?B?WkZBV0ZOYmZRaEhJMTFPRExhajEvTUcxcnREeEtLdm05MElBUmpOUzRBUVNt?=
 =?utf-8?B?OFdIN3lUMmlNd2hNVVdwYyt5dzRJZS8zNlJHYy9Jc1oyeFZMam80d05WSVgw?=
 =?utf-8?B?bWdvN1MybUs3RStXSGJSSTNJWnIvTVB6OGs4blEwVzlLYlBncDRNYlpOcjc4?=
 =?utf-8?B?K3RZVWRhWkticDhlQ3JVOHZIUURTNjRCWEhrNHE5bzhxNGVUTlRQNkFIa2FX?=
 =?utf-8?B?U2hZWmNIVVo5YVZNZk93eTRLbk55YlZ6K3RTa3JWdWV6UHhSZUZsN0JXSWtn?=
 =?utf-8?B?SityZEFPT2pDdTBhdjZxZEYwWnp6WW56eGVpMXJpWVBKYTM4bUM1UG1oKzhv?=
 =?utf-8?B?TW01SVdJZTdSTkZHanlCUDJSNksyTnkxTDBUWWJXWmxvdlcrVDF4MXlaVG11?=
 =?utf-8?B?T0xXZkQ0eEh5azZ6MW9tR3ZjUHkrRDNZaWRBN2hHbTNoMTJwMnpsNll3L3ly?=
 =?utf-8?B?R1creEpGYWsxUnZ0bHZ3c2ZhaFh4SVR5b1gvZHBtL04zYTRucjdFb2xrL0d6?=
 =?utf-8?B?V0NyM0lTVWhTY2VkcmNneVZWOGhQeUFRREpXUXJPdmxaRmNza0VzL1lBZTNZ?=
 =?utf-8?B?RnhYZjRHT1pGZWhYK25PcUxDc2RuWXM1NWEyM01lVFRad1FvTWFzSTVPZ1ZY?=
 =?utf-8?B?REN2T0Rjclg4UzdITENKTm1JdUlRU05qN2UyQjBnTXd4RHVPUGNVdXNDMGJY?=
 =?utf-8?B?Ni9DYkZZTHRQbU1Ha25YZE41MlV4TUxQVGUralc3WnZ2SkZHMUxmTUpIRll4?=
 =?utf-8?B?UlMydzJNdHNMUUV4a2xMM1NmRXBqWHd0eUw4YXpKajdweWx2elg3cEV0OW1h?=
 =?utf-8?B?RFQ3MzRpZzl5Y0sxMHVxRjU0OXd3anRtdU1Qd081ZkZQcys1dEc2N0pJZGFY?=
 =?utf-8?B?dmk0RzMxbFE3bnh0T1JWZytyRzkxK3JVUHU1SFlCd0lhc0VrUVhPdkZwZkRy?=
 =?utf-8?B?OUVoVFl2S3Zkd2tIVC9NRk5qeTZDRzdaU1J4VHZBWG1KYVNpaCtJOGNRUGxk?=
 =?utf-8?B?SlhLWVBJRC9oZkFHWDV5RW5zTm1UMTBJdHdZOGNBNFVOdnpPZjcrVjkyL1g4?=
 =?utf-8?B?TitiUzc5WHBFck9RalZNNkppM2xBOXRyN1VBN2NRUC9oSksza0JuQXlKREs0?=
 =?utf-8?B?Mm9nV3lqTEsyNXgzTVVZWU1LMGxvbkowUi8yRytGZlJxZFNtd25wZVpuWE9r?=
 =?utf-8?B?MHY4TFM5Tm5veFlNYitLazlSYkRoZzhEZURJcS8rUUYxWjBsS1d3OW8vRlY3?=
 =?utf-8?B?aEZxTVh4d1JaQU5wMHd1MGM4THBnb290ZUx0Tys4cmwwbWNxalJaNmUxV05F?=
 =?utf-8?B?d01TQlZDcUhIRlpGeWh3eXVZK2FRbys0WHNBc005OVBaSFk4VktZcWdRMFY1?=
 =?utf-8?B?c3lOTXRUdnpJaEhEWVozNkgyR1pkVzJWWWNjVmwvZEJDN0lsVHlzOVBUVW0w?=
 =?utf-8?B?NmppTE9KcTA0c2pscHNvTktIT1dLNUZHcnhicEwxQ1NKV0ZwUWJWSW5DTjhv?=
 =?utf-8?B?VEJkQWZXTm5zK3pJbmRYYzFtVVh1Nkd4UE0xaHp4RmVPQW5LS0pBODB0azcw?=
 =?utf-8?B?SFFXbUw1azVGUG9XbFk5ME8vVTAvdmtCRTNxVmptZ2d3YnAyVlR1U2Z5UGU0?=
 =?utf-8?B?Y2g0SlpFZHF3czJUL2xrSkt0ZzZWRDZRbFptRFdZRWk4UTg1aHNTMFZXcnFJ?=
 =?utf-8?B?cWQ2YWNoaS9JdU51VVVXNXgwSmtiL096VFJMUktFZFNCdjh0TzJrSG9uRXg4?=
 =?utf-8?B?dlJPdzkwTTVSMjRVMGZZdUZQTnd0a2QxTzVwOHQvMHdTT0RVaFpZRC9YVjhi?=
 =?utf-8?B?YTRVZEpjRy9qVDhNZWJVSWVvcTR5eW95QXBVd3JQbERWRUdvVUwzY1pyc1lC?=
 =?utf-8?B?ZmR3eWdRVTE5UGZCdGR2dG9kL1FpU3RCMGlaR2p2QkZSZGtPS21jQ3UvODM5?=
 =?utf-8?B?eHlvMFVuQko5cHgxZER3Wjd5NHV6RHhaT2ZDQzB3NFQvUDZwNm5lSFBHTVRQ?=
 =?utf-8?B?YzdEcGw2WmsyWEVoTHpDRW5wRmREV0hySWpQYjNqU0lNWUp3TFg2M1R1cHYv?=
 =?utf-8?B?SElDMFpMdVUxSFB6RWFIVVdRak85cUVtZ05xaDljNG8zME82YmJieThERW1Z?=
 =?utf-8?B?cUFhNGhGZGoydmNuS2tnbllBY0p6WjNoUjErR3hhbEdoK3QzOTR0RDlQVHA1?=
 =?utf-8?B?TTJBbm0wdVdIZmFRUzl2Y3hJS1BkSWRhdGNaZ1FCWDdkOHc4ZUdLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fdd80d-5de7-42a2-eee0-08da39ad7aa1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 15:37:27.9029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeNXU7XP1iNfd3Q/rT9R31Q3Tajti/QGcwB7gSP49cDd03yGzlHcQLVu/JoHkQnlyULXj+4Hgw/HZJSDuhozmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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
Cc: stylon.wang@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/10/22 16:45, David Zhang wrote:
> [why & how]
> We need to add the necessary DC codes to support PSR-SU rate
> control (RC).

We'll probably want to expand a bit on what rate control
is and also note that this is just adding core functionality
for RC but not enabling it.

Harry

> 
> Signed-off-by: David Zhang <dingchen.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++++++++++
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 ++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 23 +++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 ++
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 +++++++
>  6 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 259745074ebb..08dedc16a9c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1765,6 +1765,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
>  	 */
>  	program_hpd_filter(link);
>  
> +	link->psr_settings.psr_vtotal_control_support = false;
>  	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
>  
>  	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
> @@ -3377,6 +3378,19 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency)
>  		*residency = 0;
>  }
>  
> +bool dc_link_set_sink_vtotal_in_psr_active(const struct dc_link *link, uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su)
> +{
> +	struct dc *dc = link->ctx->dc;
> +	struct dmub_psr *psr = dc->res_pool->psr;
> +
> +	if (psr == NULL || !link->psr_settings.psr_feature_enabled || !link->psr_settings.psr_vtotal_control_support)
> +		return false;
> +
> +	psr->funcs->psr_set_sink_vtotal_in_psr_active(psr, psr_vtotal_idle, psr_vtotal_su);
> +
> +	return true;
> +}
> +
>  const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
>  {
>  	return &link->link_status;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index 5e7f70840e1a..4e15e68375da 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -100,6 +100,7 @@ struct psr_settings {
>  	bool psr_feature_enabled;		// PSR is supported by sink
>  	bool psr_allow_active;			// PSR is currently active
>  	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
> +	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
>  
>  	/* These parameters are calculated in Driver,
>  	 * based on display timing and Sink capabilities.
> @@ -326,6 +327,8 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
>  void dc_link_blank_all_dp_displays(struct dc *dc);
>  
>  void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
> +bool dc_link_set_sink_vtotal_in_psr_active(const struct dc_link *link,
> +		uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
>  
>  /* Request DC to detect if there is a Panel connected.
>   * boot - If this call is during initial boot.
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
> index 26b62f50ac4e..fa735d5f730f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
> @@ -684,6 +684,7 @@ struct psr_config {
>  	/* psr2 selective update y granularity capability */
>  	uint8_t su_y_granularity;
>  	unsigned int line_time_in_us;
> +	uint8_t rate_control_caps;
>  };
>  
>  union dmcu_psr_level {
> @@ -794,6 +795,7 @@ struct psr_context {
>  	/* psr2 selective update y granularity capability */
>  	uint8_t su_y_granularity;
>  	unsigned int line_time_in_us;
> +	uint8_t rate_control_caps;
>  };
>  
>  struct colorspace_transform {
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 9ca0cbb0af9b..0df06740ec39 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -250,6 +250,27 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
>  	dc_dmub_srv_wait_idle(dc->dmub_srv);
>  }
>  
> +/**
> + * Set PSR vtotal requirement for FreeSync PSR.
> + */
> +static void dmub_psr_set_sink_vtotal_in_psr_active(struct dmub_psr *dmub,
> +		uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su)
> +{
> +	union dmub_rb_cmd cmd;
> +	struct dc_context *dc = dmub->ctx;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.psr_set_vtotal.header.type = DMUB_CMD__PSR;
> +	cmd.psr_set_vtotal.header.sub_type = DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE;
> +	cmd.psr_set_vtotal.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_vtotal_data);
> +	cmd.psr_set_vtotal.psr_set_vtotal_data.psr_vtotal_idle = psr_vtotal_idle;
> +	cmd.psr_set_vtotal.psr_set_vtotal_data.psr_vtotal_su = psr_vtotal_su;
> +
> +	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
> +	dc_dmub_srv_cmd_execute(dc->dmub_srv);
> +	dc_dmub_srv_wait_idle(dc->dmub_srv);
> +}
> +
>  /*
>   * Set PSR power optimization flags.
>   */
> @@ -358,6 +379,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>  
>  	copy_settings_data->line_capture_indication = 0;
>  	copy_settings_data->line_time_in_us = psr_context->line_time_in_us;
> +	copy_settings_data->rate_control_caps = psr_context->rate_control_caps;
>  	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
>  	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
>  	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
> @@ -435,6 +457,7 @@ static const struct dmub_psr_funcs psr_funcs = {
>  	.psr_set_level			= dmub_psr_set_level,
>  	.psr_force_static		= dmub_psr_force_static,
>  	.psr_get_residency		= dmub_psr_get_residency,
> +	.psr_set_sink_vtotal_in_psr_active	= dmub_psr_set_sink_vtotal_in_psr_active,
>  	.psr_set_power_opt		= dmub_psr_set_power_opt,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
> index 01acc01cc191..74005b9d352a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
> @@ -46,6 +46,8 @@ struct dmub_psr_funcs {
>  	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
>  	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
>  	uint8_t panel_inst);
> +	void (*psr_set_sink_vtotal_in_psr_active)(struct dmub_psr *dmub,
> +	uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
>  	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst);
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> index 66132f3cac42..c89643eaa0f4 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
> @@ -101,6 +101,14 @@ union dpcd_alpm_configuration {
>  	unsigned char raw;
>  };
>  
> +union dpcd_sink_active_vtotal_control_mode {
> +	struct {
> +		unsigned char ENABLE                    : 1;
> +		unsigned char RESERVED                  : 7;
> +	} bits;
> +	unsigned char raw;
> +};
> +
>  union psr_error_status {
>  	struct {
>  		unsigned char LINK_CRC_ERROR        :1;
