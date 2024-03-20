Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62995C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 20:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEBF10E11D;
	Wed, 20 Mar 2024 20:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0omv+fn7";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2460C10E1F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 20:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E81RrHCKXDFg1/XJQN5jrobWuJ5QAHQnf/PwUgey9J0kwVr92j4sj8QXENqzXnBhFXh4FjUGic1/cjc97E0Hfh8JnGd4fAwpAjpOA59gODWDNMKcV8nY5MrtfLGYG7b/L2Han3jL3LQLHgegkAUwJTn7tAQShwMs0vLiO8IOtdvDttIYZ1Gegn3GVj5n/070xeUEMo4U0gJo7hfV+uC6FNMwH+ptm6ZG0Tkvfb895hNb0ILxuvH7yMs9sUBOOvchmaHo928RhumEP+y9ATXH4ebMxCKR34XsOzxCQifwljWoLFy5MnIDpdqEYziZsXjrNv+1TOADl9eLR0fIad7plA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Biv0rTCKFxYMnNzxrheJ9+RNrNdxgT7xj+2d7v3dk8w=;
 b=FCS9ZbALe47LElsapr6TKEURzWOEAP1rFBK0rqY3GsTHXHTXZP0ZtmNuvuFRxlZpqgZRczGvlON8tQ0j1L0nKsEeu44rLGWiW15/NgFf9doZLrqC2ccOuYAUxGIRcpKsT6YP/pvl61WZ21fFAmsgVR43KJvsLM6QNZGbk4qy5rRyFNzvSSaErXDWBzpzW/ie8XIYPaQMbGxTDB/dxanlcbxVFV/iH8NVN7tCTZmV9nIyvhPxaUIdfH3rY8iEx8i7W5M0RSdQ/UuSJeIGu8fzfiIyJ9KSv+3g45nJJYakvLL79L4ATtPIF5s8wDmsLnTjBI6Be8N5htK62/CVpxyNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biv0rTCKFxYMnNzxrheJ9+RNrNdxgT7xj+2d7v3dk8w=;
 b=0omv+fn7B+8lwarkhX0nIQbjyQ5viwyddkZgQY+2lLK14lkoVwx1f3n1c13eeimXIQ3KLV7YvnLZHzdLNb9At86ol+Bgxv52ra6E3ci3QxhHD5KyC71z6XZMA6SYSLG2auGjoL04j1G9q1wvT7xIs5u9pzOAJGOewHw5cUbtrNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 20:10:22 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455%4]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 20:10:22 +0000
Message-ID: <4bd6acaa-5114-4a4e-9b8b-1e4166e55fac@amd.com>
Date: Wed, 20 Mar 2024 14:10:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Fix sending VSC (+ colorimetry)
 packets for DP/eDP displays without PSR"
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240312152425.171452-1-harry.wentland@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240312152425.171452-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:408:e6::9) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 127b8f5e-bc56-488e-902c-08dc4919c5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed1ZVA5vvkXx9kTuMFrl14pYuiDDzV1JDHpnL3jyeMUGVReF26STQEXgLTZ+cPFIUUzAfaXPWXmimTGUDDlyWxkl8jQG7Q0b7UH9o3/BmJiSb8LQkOA/0YlfTMpOvyJlJ4DpoqH2AxvuriBoTZdY4mkuZfpkDFDy4UW/6h6GSiu3hcvneioKYUcPu/z/kItjlVHnxXjEgg+tX3HebmKiPfx+QzQFMxpRaK6VO4xwgko+azfqunW/bK9p7zk7DSsbQtcxKwQSWseSXbKlToWlY2OWLRZ32JPv5S2PyqrEIL6qt0UENCp8qLLHBbfbO4KOLQG46jkk7nUnXWxtShxemWXUoXoqAqth6mXWG0cjKk7pzm1sfVdBk1GKkvR0a3KBbysR+OAv3EVEccbgvJ7j93kNzhtZpWJx68BD40JY+zu3s6Tn7GFl0K1AZm6TJ1mY6+L0InKOmQX7wSjiHEh2MHJg2VaB64GeYA1tSJpZ2Y3JjqwT/3H85T1PGEpbcokj/t9tCBDo0jeDE9jN6VPdpgO+TaYV/csg7M3CP6a7a4hy7672vstFM8OZW9uoM/aj16X/LSQKRYPfAk8vi4eNGbHm1znln3g0gIyMMbmUD/nlSBcW1oCso4IYQh7M8P9X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emU4T0pZN3pwdE42bGJCcGtqUThhVVdGd1gyWi80dVp3aThnOW1YVWNYaEpy?=
 =?utf-8?B?SHNzelBobGdRVFdOZUhOdURYV0ZGeXdjWEVUTXYwemwxNkJSaGlqb3ZzL3Fx?=
 =?utf-8?B?eVFrbjVZRmFYd3dUckFhVmswaHhKaXR3TFFyRzZwOEEyMmk4Y3RmODRXeXFO?=
 =?utf-8?B?NEpvOXR4bDRJNTk2Q3VhMEdiOWxwSVZUUnNTQmtPeHhiRnFXSHcxRGQyeUN4?=
 =?utf-8?B?ald0WWZTcG1XZEloUHFQZ1hodFZVV2lzNTJUM0JGMi8vWFYwNVNIazZCMGF4?=
 =?utf-8?B?bzNRaXZUb0c2Y0JCZUIzU0ZCWFYvaTVDOEgwd2NiajJwSFpqY2hmbWhYSTZR?=
 =?utf-8?B?Wmd0Q3QreTVvMlJIK1JYNERrOTBvV2pqbzBHZXh6NWExMkgzSHpGak5aWGJY?=
 =?utf-8?B?VUdVekhNSXpvcFAybnJQdWpzb1dIU3ZrcFNQTVliQVdDNXAwOGlnSmk5OW1T?=
 =?utf-8?B?VmVBTit0REVWTHp2SWdzeFhDOUVMcWFldStBSk1YcHJWbjliYURhdnJkV09l?=
 =?utf-8?B?MTlZei9tbFQrYWsxaHkwUnQyRUlhNStoUXpGM3NZRjNSTHB5dmlDV2JUd092?=
 =?utf-8?B?ejRISG9IeSt4OHErcFo3dkltNFJ1cm1qRWdoeFFSekV5WmtrSVhXcTN5dk91?=
 =?utf-8?B?ZVllS2VUQ1QweFMvTXJmUmxacXNRUkczSytWelBETFl2TUp5bGdqdkR2TDZZ?=
 =?utf-8?B?dDFLaXZHN1FnaXJWc0pMTUdFQTZVVG04SjBONEpWWmRiUjdxQWswYTJNWllY?=
 =?utf-8?B?OTdBeGNxd3VMOXdweHd2Q2RmNGRsOWhCeTlLVEN5REhMcG13elJTbkdTTWhD?=
 =?utf-8?B?emFYWmp4N1hKcEllajRNWVpXUFYwM2gwL2xtSVZrM3dadFF3VmdMNWVKSk4z?=
 =?utf-8?B?OXdRelAxWmdCTS9xQmNicFRHY1pqTE84RzFXbEsycFd4MWQwVkZKejhQS3Ro?=
 =?utf-8?B?VVFvTDJFR0JNWnJ6Z2J4Q1ZVa3hRbFhBMXExVEhqVnk1Tk5YQkJha0pFaGZ3?=
 =?utf-8?B?b0I1dXVTZ01lZ3lseGNERU1SRmJna1ZieTZJaXJjSUpzSjYxdHh1YU84SURC?=
 =?utf-8?B?YkUwSk1DMUZ5b3dGb21LQTRUZDFxUmpQa1o3Yy9hcHpIVlhzdTcrR2NZZURx?=
 =?utf-8?B?dERON3VyblFNV1lZVDBITWdGK3ZwdnZVZmdkZzZlWWVIT3JiNmxONy9KWDBp?=
 =?utf-8?B?a2ExWERwY0lWclB5bFhrc25TZ3dlN1FJaHc2eGM0MUwvUHI4djlxZlNDK09M?=
 =?utf-8?B?cmVZdlNaZEhXTzdLVFdURlc0U1p5VEo0cmFvb3Y4Wkx1bVl5YUFQRnVwZ3FY?=
 =?utf-8?B?UEUxdHdtQUZBQUlxK0s3bVZKME1jWEtsREFPVlZrRG45WU1pQy9qVlVTOGg4?=
 =?utf-8?B?RnlLNU8vYkFkaGZmNjV6ZDBqTmVadmdUUjk1ZXMzazFEVk9EdE4xZEpmNkd0?=
 =?utf-8?B?b04wdlFKYkJheHhZYmFDdVM5SmZTd0dkN0R0K3RPVThpdGVTMlNCWTZMdWVv?=
 =?utf-8?B?aTVSYlE5N01tNWt0RWxxOUVRR2g1WXVuYUV3aU5oeVlTcUVWcFNXKzFQR0lT?=
 =?utf-8?B?SDc4Ulo1a3FLYnFDaVdtVG82aStuZERUTVlPLzVrUnJwU2VOdnFSS3llUjRM?=
 =?utf-8?B?MERmQ2ZkYzhvTHRzek5aaytSU3RSNWVJYjNSbTRRR2ZiSTE5dHdNZHNYMUUx?=
 =?utf-8?B?bk5abjl0bCs0L3E1YlJPOTdaQmRudmZUVmVUS1lqaTdlNkpid3NuK2FnTG5X?=
 =?utf-8?B?L24yTzE5N3hqSXFhbUErdVlsUzlPaHcrWjh5cnJFcDRZaXBPRTFsOFZTRzhD?=
 =?utf-8?B?Nnh1aGJ2d2tVaW5tYUJtSEVnMmVQSE5Gak5XOGQ3ZStIYjdKY1IyYnlDVW92?=
 =?utf-8?B?NXdNa1dEdjdjREE3VzFTeUQrdHZ2NHlZQkthemJLZ2pmVEw1RldtQjkreWdF?=
 =?utf-8?B?Y1U4bnp0T0Q3ZUcyaVNJWTlvWTVMSmUrMnVtTW1FQSsrM25OclVRQUkwWFBy?=
 =?utf-8?B?WURnQ0lMYXloTTRPMUVXMkJkL2QrSGJMZjNVOVR4WitIbXhtcUtFaWFhVUYy?=
 =?utf-8?B?Nng1QVN6R0ROdHpNeExuQVIrSVZUWVkrMXZpeXNET3g3VUFyb1dQRGZhVHJO?=
 =?utf-8?Q?W1aDbdy9LiI7Qh49Uq6mBv//N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127b8f5e-bc56-488e-902c-08dc4919c5aa
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 20:10:22.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNDAyxf+yH+ZOMhmIhMnKw/4tVqHbo7BA1hP4CE5zzXQLkYOiV2Acbh6lSJ8purQq6fKw+ngwl/Gk7hpaatzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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



On 3/12/24 9:24 AM, Harry Wentland wrote:
> This causes flicker on a bunch of eDP panels. The info_packet code
> also caused regressions on other OSes that we haven't' seen on Linux
> yet, but that is likely due to the fact that we haven't had a chance
> to test those environments on Linux.
> 
> We'll need to revisit this.
> 
> This reverts commit bfd4e0b7eb4467f9db5bb37268565afec6cf513e.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3207
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3151
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++-----
>   .../amd/display/modules/info_packet/info_packet.c   | 13 +++++--------
>   2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cffb2655177c..6a61eb4148ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6302,9 +6302,8 @@ create_stream_for_sink(struct drm_connector *connector,
>   
>   	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>   		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
> -	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
> -			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> -			 stream->signal == SIGNAL_TYPE_EDP) {
> +
> +	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
>   		//
>   		// should decide stream support vsc sdp colorimetry capability
>   		// before building vsc info packet
> @@ -6320,9 +6319,8 @@ create_stream_for_sink(struct drm_connector *connector,
>   		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
>   			tf = TRANSFER_FUNC_GAMMA_22;
>   		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
> +		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   
> -		if (stream->link->psr_settings.psr_feature_enabled)
> -			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   	}
>   finish:
>   	dc_sink_release(sink);
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 738ee763f24a..84f9b412a4f1 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -147,15 +147,12 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>   	}
>   
>   	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
> -	if (stream->link->psr_settings.psr_feature_enabled) {
> -		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> -			vsc_packet_revision = vsc_packet_rev4;
> -		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> -			vsc_packet_revision = vsc_packet_rev2;
> -	}
> -
> -	if (stream->link->replay_settings.config.replay_supported)
> +	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
>   		vsc_packet_revision = vsc_packet_rev4;
> +	else if (stream->link->replay_settings.config.replay_supported)
> +		vsc_packet_revision = vsc_packet_rev4;
> +	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> +		vsc_packet_revision = vsc_packet_rev2;
>   
>   	/* Update to revision 5 for extended colorimetry support */
>   	if (stream->use_vsc_sdp_for_colorimetry)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

