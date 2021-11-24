Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336A4C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 21:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CD46EADD;
	Wed, 24 Nov 2021 21:40:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067F96EADD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCZt83zudFtAAxKgL6di0LKKbzFw4xio4lR3x+c4rypkPQqDin3qp3VBjVKFd1ceCgujgDP15TGiGUGUrdtglkrWGMIumwo2lSm5D+2uw0UC3KdbPUIvP8htPtc+jV2TimXBkp2PsjXbAhUriF8gFZ3Wy2c90OIk8+sAcPkm+741ojYuxslLoyg6bfv8umNOTAgsyIQ/zTyGNgp7gYXNWNRoafa6BgnXLlwIs6Jen+8wZrNcmj8e/rgP5bp9AOrN6I//UdYk0PjH+yDuruLQ058wv3iPRnbWROzyKta9i0vvGqdPD4gxGx/5OQ8SAPR9klMRpAAEGP0oJqlIRAfwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Xs0RP8PND6jXCzdPtqewzdDczt0oUNMp+hlDFt03zY=;
 b=fqlU4S0JN6KuR9/eW7zM7JRztFtgcLf8fgfNkegz2wA5tCHwu8GMGchKvY5uQEl2I+WsLGXLD5kF95hZz5jE97RKBjqfDGVeeQE2W/1uV7VY5rjz5YbN8cPcjr+zImosBnTaQNTjqdh2u/urJ32HA9QlC65DIHJ/jpNcCNS2w77z2SbQl8XblBff0m3olRKeyjKy74BJK5UDJJyisBC9FkBHo1QJVlibxcKCznHkuv4K20SXC6oUbq+SnvDtZvhZRE+hM8XjtUqu7fPu4n5l8WGg/GB8dxAJ56QIHv0yuGb+7aE4YNjuoXz6mgXV+Pj7zpdYWaPMPCrFx7Jc2KEScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Xs0RP8PND6jXCzdPtqewzdDczt0oUNMp+hlDFt03zY=;
 b=wLxSTlMtygUg3YxQxtCiox7iguRg6AVz0gZsJ5eE7wHQ0AV/yBZseQUWsxD7MLtgpVtq8zZRVyCvJt1U/pSEvMFh3Kb44qx9/R3V0aw26g713GghcuZqUIGwAhLNRBjJyHr4lKlRTw0+RAQguxR1vFJXqaBZV+kuYHQktsT/AWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 21:40:34 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4713.025; Wed, 24 Nov 2021
 21:40:34 +0000
Message-ID: <8db7cc61-53df-b246-3e92-0edc77f47829@amd.com>
Date: Wed, 24 Nov 2021 16:40:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1] drm/amd/display: Add DP-HDMI PCON SST Support
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com
References: <20211124172837.41507-1-Jerry.Zuo@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211124172837.41507-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0443.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::28) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend
 Transport; Wed, 24 Nov 2021 21:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ad506e-9cf5-4f69-93fb-08d9af930bd9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52297E6FEBC6F58A4C945306EC619@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqbbDUtzaDc2uP43Ep3Rfu1x3DRfmunZQeuJmihMIsN0CyC2JCDANXh1P27OORiN1ksMmdljHRvbcvKO2K+PQttDKq8xV8ITM5w9xSPqvCjHqwFHY7vFtSEBmmdGidjbW/UWN4H4P9MNruoQUetrAFXClpt3o59x+uJa+aZ3OHFLY2tI6JQWCfd7jIfvlFoaxEBKXbkyWhy551iHhAI3u3f49LmrBMNbui093I0DEzMUqDrzOs/jbeE+x7kFLs53/VJ4G8NCeNkniJxIjOtl6ydQZ3lnsMBKGeVYyWA60hZNwYJOhsizgwnJ/d0jzif5bsR15m3HeE90nX8PI2Dl81myUkFnFt/hhMvHdMH2XMCcnmrejg1vmymc2OBLP6JXDTP8od4a9sAH/Rp3VpApHPzenPa76mu3dDfDOU2V4oqZlttwb2Dibr4/4NKtUZ7TXlOjcnIuWK9J9SY9QSl8WPkY88pCVc0SR2xouLpUECwxg0+KnlzX+73NVEGTEfu0JvVRSDedWT6y/waLFzlcN2xxB15n6Q9CJ259h/TSl1ztxKD32yhp3qn2x4JEn8cRfV7n2BHTXv4Z8GlXJOP9mcs2U97jCGf2JQMSGumUQc5J9QmLGLW5gRjtWhBJEg6lIMXBtdTsJidce9epOERoFfqnQaDkI7vAFtYyRbdwcnbKhPrm5QkG4DM5bUzAEZoRNZFiLzlGfqU6JZ4LbIxtNaIfgULZ0rrNJrwyMYvF+B8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(36756003)(6636002)(26005)(5660300002)(31696002)(186003)(4326008)(508600001)(4001150100001)(956004)(86362001)(2906002)(16576012)(316002)(8936002)(66556008)(8676002)(66476007)(66946007)(83380400001)(31686004)(2616005)(53546011)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REgxOU9kYUdhRGM4T0NYT0FvalAvKzU2OFVvaG5PR2t3UWphOHN1K2hFc1Bn?=
 =?utf-8?B?K0wxR0U5a2w2SWxzdVdsUjdSM0swUUF5ZWRqeWgyVUx3MkpMV2I2L04zaGVQ?=
 =?utf-8?B?bUU1ZU00N3dvdlRaK3ZlTi9KaFhGYlhoRDlnbHcwdEJ1ZWFTRkVOdEw5TGVN?=
 =?utf-8?B?Z3g2Y3prVlRFYkt1TURhWHZQYVRLZ1BsMVBtL0l5N3psN2hEOXREQSt0R2E5?=
 =?utf-8?B?UmpSZ0FLODNUR0dBaXhQWE5Ea01yVVQ1ZkdOY1NhNnFnYWZ3eVoxbUxKTmlo?=
 =?utf-8?B?THpYTFBwb1FGSEFUb1NDdUFCS0RCWERuZGt6ektKRFoxRWpmTVNxWEwySE5K?=
 =?utf-8?B?T09XWTZnblVZZTQ4ZWFKRGdxNER2bTAxRkJVWHczYkVGZUJzd3hheUZVaWZL?=
 =?utf-8?B?a1BBZTFxTkVZdWRTNStLWGF4UkZyNjYxcjBDUmpoZ1NGZUY4VzBkdkE5c3Rj?=
 =?utf-8?B?Y2FIa28vYmMwUUJCQnAwcUJUYnBQZXVGWWdIN2h3MTVXY2NPQlFOeXlpaTUx?=
 =?utf-8?B?dUk0Nkcva0RJVm04WW9oTUZGNDVDUzZpUFBLSkFMbWdQR3B2M0NjYndWMUtL?=
 =?utf-8?B?Q2o4RlIrbEdlc2JPSXg0WHB1d1QrNVRmRlNOUlNJKzZ6VGNzdEU1Wkl4TTNX?=
 =?utf-8?B?R2x2eHRjR0FjZDRPem43eENJdmExcWNwSlRsL05uUFBIejZpak14SEFlZ1FN?=
 =?utf-8?B?c3R6NEppTFQ2NjFZaVRSb2szNEhCWkU4ZXc4WFY3eERlUTA0a1JydUIzYzhv?=
 =?utf-8?B?Y01YWGdWRnRjY0p0eDBPQzJNeGxyVnV5OTArTDhUeERPSXRzUm5nSVpicTBk?=
 =?utf-8?B?U3V5U0p4VW9ST205M2dVTnNCZnptQU9aVjcwN2Z3N043WFJ5NlFUR3lLMkZQ?=
 =?utf-8?B?bDA1Nk1qd0hoTDRSMnl6MjZwWnFCZldvMXdlVld2alZhQ1RXYys4azJuRjlx?=
 =?utf-8?B?YWl3Sml0dnU4eWFueCt4ZXEwR1JRV3RxVEt2b2FmQzZWZk83M3JoTklEQnpx?=
 =?utf-8?B?ZkVaejUwT2xPT0ZlL0ZIblowczJQSGVib213VzBzNHlUZU55V0VUamM2M090?=
 =?utf-8?B?aDduMmRGb1QrVTl5YlM3WnFMTzZiMzJJQ3NHTTNGTjRyaEVsakRXdXlkZVgr?=
 =?utf-8?B?bUNqK0RKcGtSUmNLeHkzb0svZEtvcEZHdHNYWFZMc0RFQ2k5ZDRBVDNmd2N6?=
 =?utf-8?B?RGN5cTdidE1BTWVmVWQxZWp6ak5mSkltT0RVMWdKc3hsMnB1Q3FKTVNCTUt4?=
 =?utf-8?B?ZUVjTDJBYlB4VENuUlJhWkQ4R3MrMzBNTEhxNUREUHpUZGI3Q1hHUjRsRFND?=
 =?utf-8?B?ZlVhOUxpMnE5aTI5VkhNVitzT0FHdkxweUgyT3pRRi95WklpWlNHSDNmcDBQ?=
 =?utf-8?B?cXdhTi9MK1N5RisydllsWVdkd2lZaGUwU09SdjFlMU84RzVKVHV4UHpVNzZZ?=
 =?utf-8?B?Sk5ZQnZKNmRLRnRTeTVQSzdVTHR0NVVOekhRZEVYeWlJSmpJZi9Xbk9OTFJm?=
 =?utf-8?B?QXdJR2ttcDlBajQvTW9wS3l0dVNZeEVvSnNrdXkvNHYya3NReStaRG9ERWVV?=
 =?utf-8?B?UHI0WG9rWENIekNDbjJxVUllMnZNb2haK3BLYmtJc3UyL2QyajI3eUtYM3Qx?=
 =?utf-8?B?RndPei84YXh6QUVuMzNBSmJQMjBwQlZTUHdKeUl6UURTc00xOFQzdEkxeWJn?=
 =?utf-8?B?dkxxS0s4TGNmTzh1NG80U01ENUcyZzFiZ055STJXV0phQ28wUkZLMUZSRHVC?=
 =?utf-8?B?MXdheDlWd25wSFlqUmkzakNXY1pJWUR3dGZFdWVMaGdRTkQzMWNYbFh1Ri9l?=
 =?utf-8?B?UVhsc2NlUUZlTno1dUJwenhvYStyUTlXTThuem04dmJxT21GK2JneDNJajh2?=
 =?utf-8?B?U3V3ZVRPNmRIZmVkdXh6ZjJreG8xdDRENGVCQU16QXNrNHdNRHJ4OERVWnpa?=
 =?utf-8?B?TDJKUzdWdm03cTNZS2c4amlqalUyV256blh1a2QzSXZpaG43bzh1YTBvUjgv?=
 =?utf-8?B?QXlOMDJ4OE90aFNHVnFEQWZ2a3NUZ0hKNmxMeFo1T0RwdmZkaW81Unl3QTl5?=
 =?utf-8?B?WkZ2bktUaEp4WHI1WHlrOStzeUlNZGRReXQ4cjg3T2RlT0szU1ZzaW05c3Z4?=
 =?utf-8?B?WmthMVRxOHBXTzVLQ1FHZ01JMWpvRW9DK0h5ZUV0T1B5K3gxUnY5bUVhdExW?=
 =?utf-8?Q?3FPOKDVazeVFFqmiWI+weZE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad506e-9cf5-4f69-93fb-08d9af930bd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 21:40:34.6753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa4V55e80LIO4DJeYAE4hsoyR/hgyG+pqIxeDLlj7ff1+brtrt3VsE5fW6wdSghlE/10MuvRIYE6RVrHAf/Yug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: wayne.lin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-24 12:28 p.m., Fangzhi Zuo wrote:
> 1. Parse DSC caps from PCON DPCD
> 2. Determine policy if decoding DSC at PCON
> 3. Enable/disable DSC at PCON
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++++++----
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++++-
>   2 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9a1ac657faa2..9dbf6bf3f1c3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6047,10 +6047,12 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
>   
>   	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
>   		sink->sink_signal == SIGNAL_TYPE_EDP)) {
> -		dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
> -				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
> -				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
> -				      dsc_caps);
> +		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE ||
> +			sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
> +			dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
> +				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
> +				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
> +				dsc_caps);
>   	}
>   }
>   
> @@ -6120,6 +6122,8 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>   	uint32_t link_bandwidth_kbps;
>   	uint32_t max_dsc_target_bpp_limit_override = 0;
>   	struct dc *dc = sink->ctx->dc;
> +	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
> +	uint32_t dsc_max_supported_bw_in_kbps;
>   
>   	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
>   							dc_link_get_link_cap(aconnector->dc_link));
> @@ -6138,16 +6142,37 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>   		apply_dsc_policy_for_edp(aconnector, sink, stream, dsc_caps, max_dsc_target_bpp_limit_override);
>   
>   	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT) {
> -
> -		if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
> +		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
> +			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
>   						dsc_caps,
>   						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
>   						max_dsc_target_bpp_limit_override,
>   						link_bandwidth_kbps,
>   						&stream->timing,
>   						&stream->timing.dsc_cfg)) {
> -			stream->timing.flags.DSC = 1;
> -			DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
> +				stream->timing.flags.DSC = 1;
> +				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n",
> +								 __func__, drm_connector->name);
> +			}
> +		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
> +			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing);
> +			max_supported_bw_in_kbps = link_bandwidth_kbps;
> +			dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
> +
> +			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
> +					max_supported_bw_in_kbps > 0 &&
> +					dsc_max_supported_bw_in_kbps > 0)
> +				if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
> +						dsc_caps,
> +						aconnector->dc_link->ctx->dc->debug.dsc_min_slice_height_override,
> +						max_dsc_target_bpp_limit_override,
> +						dsc_max_supported_bw_in_kbps,
> +						&stream->timing,
> +						&stream->timing.dsc_cfg)) {
> +					stream->timing.flags.DSC = 1;
> +					DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from DP-HDMI PCON\n",
> +									 __func__, drm_connector->name);
> +				}
>   		}
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index e8e70840a622..2c73594da85f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -585,8 +585,17 @@ bool dm_helpers_dp_write_dsc_enable(
>   	}
>   
>   	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
> -		ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
> -		DC_LOG_DC("Send DSC %s to sst display\n", enable_dsc ? "enable" : "disable");
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE) {
> +#endif
> +			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
> +			DC_LOG_DC("Send DSC %s to SST RX\n", enable_dsc ? "enable" : "disable");
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
> +			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
> +			DC_LOG_DC("Send DSC %s to DP-HDMI PCON\n", enable_dsc ? "enable" : "disable");
> +		}
> +#endif
>   	}
>   
>   	return (ret > 0);
> 

