Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76DBC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3840210E65E;
	Tue, 11 Oct 2022 18:47:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BC810E65E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz3roBRAlbqOigmlUK9rlh018ZO2qTJvmOBqy4mSkK9/F2dBIYqlNhjR83PLrn/DpbTqPf6+959EFU6giQUcE5jVC9yyCHYSAS1bW5V/1BGCVucCDeSyTwZBsgt1XV2beI69zNgIbMIRydHZVvRD4VInWK+JGkY2MzgDdNw/a2YJpYgVbr5C6t2TM0aIOWe8WzfH1p7m2p/dBc+GIDUlELqRQ8+ASwB8qtO+8OSJULHsf0SvlFsII8Sl61AMwSt5Ddx2LmOCPXqXkrvecgeWvShuHL769364MV7cLYnr+f900Zdiw7O6cyAfi+7xRaJ0lNrEt5DJcQIbO8g2JboT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHls6Co/+4Uoso2SKN10o0TnuDrV65se03Owv8PwJrk=;
 b=iXIQeLAERfkqpd2e19IpRaEyQzwvCaJ8PVYvRQhgIiU1UH2TdaafUSXX9fJm1ogBZRFCgahnkXIZnkWzH0wUiT3B70ZHyCmDH6ncm2HakjGfmkeKPo7DIN2sk8N2HSYzAE5h3kz9Fu6Md1FybZXgnsLv7ZaMlEg1YkUIVBLsGZ0Xd3TNfByTiI/MnFZAZqkAlqAB2L89tXv3sW3y6qjXXdhg34vysrKDpR3plSBruBC1HQWXyrLAAUwM67ITYGgkCyoLIQChPfllCSHZUaojKx2VSDdL4EzoxxQu/FkrDrlOgvMjj6r7tMn7rmPH8agIrLnXIprjXVlGI3pZC+91Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHls6Co/+4Uoso2SKN10o0TnuDrV65se03Owv8PwJrk=;
 b=geVhJTPaUVRPx1wn6wm0ObWuZLnhjN2cmd10WEYILGnSwtWryFHTDIyOBjfGt6ijoosCujY9lAof7Pbpius/kLVQSUOJyo/eGraxp79CVp8f4rvLXIJXG1OlUGvfPcDd/Os+9IDV+BZTGCI94/LS4y409xYexQL9IMJ0o0daLA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 18:47:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 18:47:19 +0000
Message-ID: <16411ae3-9cf2-b10a-1de4-131bd76e6830@amd.com>
Date: Tue, 11 Oct 2022 14:47:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/3] drm/amd/display: Add functions for new DC commit
 sequence
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
 <20221011181140.94595-2-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221011181140.94595-2-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BN9PR12MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: e938e8aa-e7a2-462a-3d72-08daabb90671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJcXVDr2vBxBHMzgYlwGnU2zgVMKPU7egrd+KH110BKXVRvHZ8jY5t+cqnDwpcbUuIko8UW494sXRChAw1ikXs/TsZFmybeLmT40GTh3mUi1KX78xcQ6ymDejwo4uf8+dtcyiG75zMNSkn46r1TzWeGnWVKOzuR5fHXMFaet9yvMQIiqj10j0EBMq9Lt4lz9hzI+XlQzwT4trcy9WD5KrqzLBqQy/RCqi5Lewei4IYGzTu6nhEXX1QzyURzAEFKJ5yuw64UTU9H5ewv7CoflW0qaJ4Hd70WN/GJt7iaakc5Ds2ZPy9JceIVL3HaGQfF8Aqcg4HVfhzeoKX8dkJ4nT9bBK8UG+qCUGboN21I+l0SzMaNLFves48XQVtqkW6jdhKK3vFl9W+bUhhffnOaVtsxQM56jpaD+D6iUtAJbpxM0WYoNQSoouB0zdMDhUsw3AV9eFx2ronrLhFX/xqk46r8tF3rHjkD36K2PyV5TkYZGVzPg7b19RKoJPw1eCEj8pSzRhi5dAh1UnAiqZIkQqCWNURn9JvE1RSeNJULrKU56rjcaNhZA4Koi6ZKSkNFJCZspw2Vd3MjdA8yXSQR3hAwbrkF7ZQ4NE8244K3Be4b313OMe+VoAtKdW9yCegQhpP3ac/VTFy5AdHGS451S9TGQIkZcE3brR+Q9cTWcwRj2c3SjFowaOXLmsht85/+Yl3o+vQhJvMTApYN2hr1rEeF7zai6HnjKgP31Pgp/R4eH+PDXf1+JkN8r2InT65fKWckbaxSfVp2Vf/ALFQ3h+P2V3CRkjYhMh7kXpKOAz6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199015)(4001150100001)(41300700001)(5660300002)(8936002)(31696002)(36756003)(86362001)(38100700002)(2616005)(6512007)(4326008)(30864003)(66476007)(53546011)(8676002)(26005)(6506007)(316002)(6486002)(478600001)(66946007)(54906003)(66556008)(186003)(2906002)(6666004)(44832011)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25JQ24wVFJXbk9aUlk3QS9iNVdzbE12eTBDdVVGMTZUdCs3VXFjM1U0RW1k?=
 =?utf-8?B?RldESDVEL2E0dzVYZU1iWCt3cDZHanF4dHdEdkE2VEhydWF6VEhySDhnbTI1?=
 =?utf-8?B?d2JhTHhJQUg1MkoyTnpyZzJnNm9mTDFqSE5rMXRtRVl6c1E5YUdGNkw2ZTRt?=
 =?utf-8?B?dEtKMjhTZDRQYzQ0cW0xMFUzbzQwQ3QrcFVYZWRUTFIrWHRLbDkvcmU3MXVC?=
 =?utf-8?B?UzJreWt1Yk13ajRTRWtHNWEwTm81M25XaHp0Q0h6S0JvdmhPL2hTT1JaODgr?=
 =?utf-8?B?c21mYU9KM1NyeWVWcGFnR3BnU1V3bWVnMkVaZjJyWWV2RFZVZGMvd3pkMDRu?=
 =?utf-8?B?OWxVZnlrZGtVV2Z0N244WHVYUVM1cFdvL1FXTytjNWM0ZWQvTDI3aHpSM1lB?=
 =?utf-8?B?SWI3SGdBYm1uNm5vZ2xNak04SUJVeXpESTl4TElFaVJMb1BBSkpIRzBLVWpQ?=
 =?utf-8?B?cTJuR2pHRWUyZTBjeW1YTzE2c09ncTdnWklmaEh0ZDNMNzd5WnZjbUNzdDJ2?=
 =?utf-8?B?ZWpVazd0Q044ZStjaGJ4bzhTKzBjN2dJYVJyWDNncW9MOVBkNHdkdk1EZ3Z5?=
 =?utf-8?B?ZlErTmNNV2l3MWRQd2VJM2pmVWh1bmxQcGVpTHJmQ1hobVg3eHZJc0hLSWpE?=
 =?utf-8?B?dFV6d01ZR0VIUHpueUI2cHgzZDNDemhIalZlSGJDcXFqZ2cwNi9OWUxFT2oz?=
 =?utf-8?B?SVB3RWM3UjA3Q1BJUnN3aHNIcjY2M0lZTys2aXZBZ2Zuc0FXK1BGeU5Wc0pk?=
 =?utf-8?B?SDY0bjVteXBKTnZzSDNIRDlTa1k2TnBqZjdKMzNXS2l6KzIwOHF4b0hwbC9Y?=
 =?utf-8?B?QVY3Q0NqZXJ6SjYweTBxSmY3ZHdadk5jMCt4TFNiamFtbHk0Zmc5OGpnaXVO?=
 =?utf-8?B?YnVDNG1ibDUzZWI0c0dZQlhETXJpSnA2V0Q3dnJSOENmS2FSZjZweWZ0TVpy?=
 =?utf-8?B?Um1DZC9UbFpuM1BmcVNlL25ZZElITlpQRXI2Zm1NN21QRGFNbCs3bEV5OVlM?=
 =?utf-8?B?UlFtNjZmZjRKS2QwNzQwSU1mSVJ4Z212b0t0TS9FaXFmTkVlNUllNjB1QjFm?=
 =?utf-8?B?NC9CcEs5dTBXaEVkNjVjRXN2YUhhVS95OEIyWDRyempaNnhJSzdOY2JLSUI5?=
 =?utf-8?B?NTEyb2ZHSjlab2EwM0V3NFlYS2plb1Q4eVZkUzhBcENlNGF0amtTbnA3K3lD?=
 =?utf-8?B?VjN3Z1dmL2lqZ0JtQVVQY0NsYXJBOGtxTmUxWXY4N0gvUkR0SUJObmJOOEFV?=
 =?utf-8?B?eXVJRzQ0Mmljd0lxanIrNEwzT2pGSjg2Q1pHaythaXJlbk9tRlROTDhrY2s5?=
 =?utf-8?B?NUp6VTZaRkhGRFBGZHlRR2lidVlCRFBFKzE4STg1Y2pZM0ZoQUF3b3g0dUk0?=
 =?utf-8?B?UXpMdGZJbnZsUWNiaW91SnZlV0luU28zOHBndVllNjl5MVk4YnpTR3RJTEFU?=
 =?utf-8?B?R2dmTkZNNWhWSSt4UDdCUFlVM2JKQmpURlBySTdmcExIcmJQUkdMSlJHZ2dm?=
 =?utf-8?B?UE1SNUhtVVNvL2syaUYzenY4RVdrRm5Ka3lMUHFwYTVQS2wvQlZjUXByWDBa?=
 =?utf-8?B?VzlqWHBYN0E3bEpYZlZZUTBkZ08zQlpNenhxaUZ1Q2hIVkRPb0xZang1dTVE?=
 =?utf-8?B?ZXF1QzhmTmFjR055S3R2ZTlwQ2ppZDNYek4rVjlRR092bFZ1WUxSQWJ3ZGhr?=
 =?utf-8?B?K3FtdXRUbUZlZTVtTHF0RW54dWVyeXZwc0V4ejMrMCtWSERnRExjK1BmOEdG?=
 =?utf-8?B?NlZ1aU90RWdHY3RWUFBDc3NaYkd0VVgxQ1ZjcjNwOVFEcS9pK2xSdktLWVJC?=
 =?utf-8?B?WUt3b1h1SVUvdWlRelJUbGxhR285ckRTMjhvMkpqazFxZ2p5a3ByMGtGenNV?=
 =?utf-8?B?RHhEcFpIRG5FYzhPeW1ueWJBUVIzeVRCUCtkbWNVRUJ3anhjNUR5Yis4c1I0?=
 =?utf-8?B?aEg4UmlCWlhTSVZKMG5TRjZENGxqdW5qMjNDQlhKaE56M0gyZXBtMityMWhX?=
 =?utf-8?B?MjlFTCt4RlRqWVRnVm9EZGsyZHdKdWI2SmF6Z1Zzek1uaTRkTE9IRnQyaDZI?=
 =?utf-8?B?UFlYQnJlYm1RY0hENUhBT3NlU1NPWDdSaVRsY2pCT0M0emdSbnNnMy8xbWFW?=
 =?utf-8?Q?AhINReOI6yqnq8BbIUq2tVG21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e938e8aa-e7a2-462a-3d72-08daabb90671
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:47:19.6866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMbClV5tw7eWMhSTiBSt+flSoZ+x33VcGkfXbm7VGe/jvVjVsa9aGhFQxbcQkWgW3LbzO2K38GR1PpLLzC9Sng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-10-11 14:11, Rodrigo Siqueira wrote:
> Since DCN32, our DC commit become more complex and requires more
> adjustments to work well with some features. This is a preparation work
> for replacing dc_commit_state and dc_commit_updates_for_stream with
> dc_update_planes_and_stream and dc_update_planes_and_stream

I think you mean
"dc_commit_streams and dc_update_planes_and_stream"

Harry

> respectively.
> 
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  92 ++++++++
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 204 +++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
>  4 files changed, 308 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 660316a536f7..ad3aafb73cba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -59,6 +59,7 @@
>  
>  #include "dc_link_dp.h"
>  #include "dc_dmub_srv.h"
> +#include "dc_stream.h"
>  
>  #include "dsc.h"
>  
> @@ -1505,6 +1506,25 @@ static bool context_changed(
>  	return false;
>  }
>  
> +static bool streams_changed(struct dc *dc,
> +			    struct dc_stream_state *streams[],
> +			    uint8_t stream_count)
> +{
> +	uint8_t i;
> +
> +	if (stream_count != dc->current_state->stream_count)
> +		return true;
> +
> +	for (i = 0; i < dc->current_state->stream_count; i++) {
> +		if (dc->current_state->streams[i] != streams[i])
> +			return true;
> +		if (!streams[i]->link->link_state_valid)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  bool dc_validate_boot_timing(const struct dc *dc,
>  				const struct dc_sink *sink,
>  				struct dc_crtc_timing *crtc_timing)
> @@ -1923,6 +1943,78 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
>  	return (result == DC_OK);
>  }
>  
> +enum dc_status dc_commit_streams(struct dc *dc,
> +				 struct dc_stream_state *streams[],
> +				 uint8_t stream_count)
> +{
> +	int i, j;
> +	struct dc_state *context;
> +	enum dc_status res = DC_OK;
> +	struct dc_validation_set set[MAX_STREAMS] = {0};
> +
> +	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
> +		return res;
> +
> +	if (!streams_changed(dc, streams, stream_count))
> +		return res;
> +
> +	DC_LOG_DC("%s: %d streams\n", __func__, stream_count);
> +
> +	for (i = 0; i < stream_count; i++) {
> +		struct dc_stream_state *stream = streams[i];
> +		struct dc_stream_status *status = dc_stream_get_status(stream);
> +
> +		dc_stream_log(dc, stream);
> +
> +		set[i].stream = stream;
> +
> +		if (status) {
> +			set[i].plane_count = status->plane_count;
> +			for (j = 0; j < status->plane_count; j++)
> +				set[i].plane_states[j] = status->plane_states[j];
> +		}
> +	}
> +
> +	context = dc_create_state(dc);
> +	if (!context)
> +		goto context_alloc_fail;
> +
> +	dc_resource_state_copy_construct_current(dc, context);
> +
> +	res = dc_validate_with_context(dc, set, stream_count, context, false);
> +	if (res != DC_OK) {
> +		BREAK_TO_DEBUGGER();
> +		goto fail;
> +	}
> +
> +	res = dc_commit_state_no_check(dc, context);
> +
> +	for (i = 0; i < stream_count; i++) {
> +		for (j = 0; j < context->stream_count; j++) {
> +			if (streams[i]->stream_id == context->streams[j]->stream_id)
> +				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
> +
> +			if (dc_is_embedded_signal(streams[i]->signal)) {
> +				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
> +
> +				if (dc->hwss.is_abm_supported)
> +					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
> +				else
> +					status->is_abm_supported = true;
> +			}
> +		}
> +	}
> +
> +fail:
> +	dc_release_state(context);
> +
> +context_alloc_fail:
> +
> +	DC_LOG_DC("%s Finished.\n", __func__);
> +
> +	return res;
> +}
> +
>  bool dc_acquire_release_mpc_3dlut(
>  		struct dc *dc, bool acquire,
>  		struct dc_stream_state *stream,
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index fd8db482e56f..0c58a19e9115 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2593,6 +2593,208 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
>  	return dc->res_pool->res_cap->num_dsc > 0;
>  }
>  
> +static bool planes_changed_for_existing_stream(struct dc_state *context,
> +					       struct dc_stream_state *stream,
> +					       const struct dc_validation_set set[],
> +					       int set_count)
> +{
> +	int i, j;
> +	struct dc_stream_status *stream_status = NULL;
> +
> +	for (i = 0; i < context->stream_count; i++)
> +		if (context->streams[i] == stream) {
> +			stream_status = &context->stream_status[i];
> +			break;
> +		}
> +
> +	if (!stream_status)
> +		ASSERT(0);
> +
> +	for (i = 0; i < set_count; i++)
> +		if (set[i].stream == stream)
> +			break;
> +
> +	if (i == set_count)
> +		ASSERT(0);
> +
> +	if (set[i].plane_count != stream_status->plane_count)
> +		return true;
> +
> +	for (j = 0; j < set[i].plane_count; j++)
> +		if (set[i].plane_states[j] != stream_status->plane_states[j])
> +			return true;
> +
> +	return false;
> +}
> +
> +enum dc_status dc_validate_with_context(struct dc *dc,
> +					const struct dc_validation_set set[],
> +					int set_count,
> +					struct dc_state *context,
> +					bool fast_validate)
> +{
> +	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
> +	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
> +	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
> +	int old_stream_count = context->stream_count;
> +	enum dc_status res = DC_ERROR_UNEXPECTED;
> +	int unchanged_streams_count = 0;
> +	int del_streams_count = 0;
> +	int add_streams_count = 0;
> +	bool found = false;
> +	int i, j, k;
> +
> +	DC_LOGGER_INIT(dc->ctx->logger);
> +
> +	/* First remove from context all deleted streams */
> +	for (i = 0; i < old_stream_count; i++) {
> +		struct dc_stream_state *stream = context->streams[i];
> +
> +		for (j = 0; j < set_count; j++) {
> +			if (stream == set[j].stream) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			del_streams[del_streams_count++] = stream;
> +
> +		found = false;
> +	}
> +
> +	/* Now add new streams */
> +	for (i = 0; i < set_count; i++) {
> +		struct dc_stream_state *stream = set[i].stream;
> +
> +		for (j = 0; j < old_stream_count; j++) {
> +			if (stream == context->streams[j]) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			add_streams[add_streams_count++] = stream;
> +
> +		found = false;
> +	}
> +
> +	/*
> +	 * Build array of unchanged  streams, it is needed to handle
> +	 * planes only changes (added/removed/updated)
> +	 */
> +	for (i = 0; i < set_count; i++) {
> +		for (j = 0; j < del_streams_count; j++) {
> +			if (set[i].stream == del_streams[j]) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			for (j = 0; j < add_streams_count; j++) {
> +				if (set[i].stream == add_streams[j]) {
> +					found = true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (!found)
> +			unchanged_streams[unchanged_streams_count++] = set[i].stream;
> +
> +		found = false;
> +	}
> +
> +	/* Remove all planes for unchanged streams if planes changed */
> +	for (i = 0; i < unchanged_streams_count; i++) {
> +		if (planes_changed_for_existing_stream(context,
> +						       unchanged_streams[i],
> +						       set,
> +						       set_count)) {
> +			if (!dc_rem_all_planes_for_stream(dc,
> +							  unchanged_streams[i],
> +							  context)) {
> +				res = DC_FAIL_DETACH_SURFACES;
> +				goto fail;
> +			}
> +		}
> +	}
> +
> +	/* Remove all planes for removed streams and then remove the streams */
> +	for (i = 0; i < del_streams_count; i++) {
> +		/* Need to cpy the dwb data from the old stream in order to efc to work */
> +		if (del_streams[i]->num_wb_info > 0) {
> +			for (j = 0; j < add_streams_count; j++) {
> +				if (del_streams[i]->sink == add_streams[j]->sink) {
> +					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
> +					for (k = 0; k < del_streams[i]->num_wb_info; k++)
> +						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
> +				}
> +			}
> +		}
> +
> +		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
> +			res = DC_FAIL_DETACH_SURFACES;
> +			goto fail;
> +		}
> +
> +		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
> +		if (res != DC_OK)
> +			goto fail;
> +	}
> +
> +	/* Swap seamless boot stream to pipe 0 (if needed) to ensure pipe_ctx matches.
> +	 * This may change in the future if seamless_boot_stream can be multiple.
> +	 */
> +	for (i = 0; i < add_streams_count; i++) {
> +		mark_seamless_boot_stream(dc, add_streams[i]);
> +		if (add_streams[i]->apply_seamless_boot_optimization && i != 0) {
> +			struct dc_stream_state *temp = add_streams[0];
> +
> +			add_streams[0] = add_streams[i];
> +			add_streams[i] = temp;
> +			break;
> +		}
> +	}
> +
> +	/* Add new streams and then add all planes for the new stream */
> +	for (i = 0; i < add_streams_count; i++) {
> +		calculate_phy_pix_clks(add_streams[i]);
> +		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
> +		if (res != DC_OK)
> +			goto fail;
> +
> +		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
> +			res = DC_FAIL_ATTACH_SURFACES;
> +			goto fail;
> +		}
> +	}
> +
> +	/* Add all planes for unchanged streams if planes changed */
> +	for (i = 0; i < unchanged_streams_count; i++) {
> +		if (planes_changed_for_existing_stream(context,
> +						       unchanged_streams[i],
> +						       set,
> +						       set_count)) {
> +			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
> +				res = DC_FAIL_ATTACH_SURFACES;
> +				goto fail;
> +			}
> +		}
> +	}
> +
> +	res = dc_validate_global_state(dc, context, fast_validate);
> +
> +fail:
> +	if (res != DC_OK) {
> +		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
> +			       __func__,
> +			       res);
> +	}
> +	return res;
> +}
>  
>  /**
>   * dc_validate_global_state() - Determine if HW can support a given state
> @@ -3734,4 +3936,4 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
>  	}
>  
>  	return true;
> -}
> \ No newline at end of file
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index bfc5474c0f4c..2753d9eabd16 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1286,6 +1286,12 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
>  
>  void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
>  
> +enum dc_status dc_validate_with_context(struct dc *dc,
> +					const struct dc_validation_set set[],
> +					int set_count,
> +					struct dc_state *context,
> +					bool fast_validate);
> +
>  bool dc_set_generic_gpio_for_stereo(bool enable,
>  		struct gpio_service *gpio_service);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index 9e6025c98db9..d5b3c80635ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -378,10 +378,9 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
>  				  uint32_t *h_position,
>  				  uint32_t *v_position);
>  
> -enum dc_status dc_add_stream_to_ctx(
> -			struct dc *dc,
> -		struct dc_state *new_ctx,
> -		struct dc_stream_state *stream);
> +enum dc_status dc_add_stream_to_ctx(struct dc *dc,
> +				    struct dc_state *new_ctx,
> +				    struct dc_stream_state *stream);
>  
>  enum dc_status dc_remove_stream_from_ctx(
>  		struct dc *dc,
> @@ -445,6 +444,10 @@ enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
>   *   Phy, Encoder, Timing Generator are programmed and enabled.
>   *   New streams are enabled with blank stream; no memory read.
>   */
> +enum dc_status dc_commit_streams(struct dc *dc,
> +				 struct dc_stream_state *streams[],
> +				 uint8_t stream_count);
> +
>  /*
>   * Enable stereo when commit_streams is not required,
>   * for example, frame alternate.

