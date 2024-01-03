Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F50C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7850F10E323;
	Wed,  3 Jan 2024 14:35:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8F710E323
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1bLaxM8G57DUFP+7VgLD75Y68YeIW+YcslCg1PQEM7/+7aEyhFLRt0L0T0SMNwkzyg3ILzXY2ayGi7DLRlC2zkAYh8qcdgA0gqm1kE6+nmobS6QTqH12Lzi7ZnDudq1QdbtOrMy3fIqOm6M6FvPDN3BD9nzGG2bfTaGlHmIEfKV2+UbTgiqO+R/kslNHgLvDE28W9yPBaIHWTbUURcxKrjB4Tr22I9ZneBj3Iso/SSGJieEC12f2PmJQOgsSyDRckxEWAdtjYSvTTT4kuUTrxTsvxcXKixesqWnqVGP2ycPqtpCh6voiqu1DD8TAXDkRvWlFEsY+v1f1ZSjLex18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXwwF9PetS1CqNqb3oPxNhoQ7Cv2idBKvKZ79c+qZbg=;
 b=CQWOfcBmNl3dckSOLISwUrDvAhH3V6qfpSshxd/5ZOf5HSTKkckkEIw12PHrZbHUNKMTHV1MPA9irt6qSKdU/9XKqd5sEiDG4AWdKRpT+LQkEXURb2gw3aoVIg/8G6rYoQRWExQzd6SdjACBeRAC70GpsH/oYvKMHeVmxOzI+ci4lZ8cuka0HU/pF7u6nb/b/SmVM+VoE/PNVS4pq+zhAcgWrwvv8sORfcuBkABKbAPpgyJZL/QUgf5fjxVZWn0WP7NdYi0kF4TtFNZ1KGvEbKm85wnXtPoqIiBixMSn2PgNK4wtIeWbEWfIiD822Gnyf4TaEQM7dECEKRmb5TuOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXwwF9PetS1CqNqb3oPxNhoQ7Cv2idBKvKZ79c+qZbg=;
 b=UkCuHN8YEGL9ezRCh8KWJ1MUSw+zOcP9q8FjjyXCUuaXTT37UX+VAX0Hhm7P6HuWDCrhvPThcslRbjpTyujCRR/P0gwdPNPqYmRrf1caaGjopQvyMdp2q1bbnW9Y0s79TheTQcqKQMOxGa15fYBo5Og4/bhzqoLbvdTM0EM+rVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 14:35:47 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 14:35:47 +0000
Message-ID: <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
Date: Wed, 3 Jan 2024 09:35:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
References: <20240101182836.817565-1-joshua@froggi.es>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240101182836.817565-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0292.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::11) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 89335d53-2fc6-409a-3fd5-08dc0c694675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spW0NA47JXSHsgbKMysJcKjm22JK/P++W+J+InxZYN1ht8ng/d4Wffff5vUerDHXgctufVe7202c94xMT/Y9GQh+VKwEoMVD9vk/cUX+K6aUvh4WCztITvFqgQXEJBgPFvF8FAKWnqMdU0evNoMJV9ZfsAk5CemjqqcvedN4xYhwgQVzOIYez6prEpS5NgwOmo/Q+VlTYkVWzl2ZWIdSC00QMc20t0UagP8q4Q0xNkWqJt2WC8Mhl96mMcSuAAP1YgA7wq2k88BaRIPrsfkVh3xaY30+UdLDk6NvO3kO2E9xbHBcaerN+BKfzWfyp7SqQhjKgB2kF9eMqIS+uUgFHDEgUAyfsVqEkFl/EmKEzViMnKFHqTPQMaDrl/RfQjcuQoLMOg/gKM85oqrTYwBCyF8ix94mz7sulPWRf7qzb9gwB7781yA+l1QYSCc+CKtZZImysdlg+WPEdvplJIjBCYEzJMn0KlqPW9J6gh2vRSF4Rl9FfX1PsAc+2R0rWngnGBu3RChRLpTdyQFXVFi55BXFSmnpDmZ7tN0FEraZiJwYZoZdrsRLoDxOp6N/J/7nP9BiO/Prnpnhq+PauLVQ1GKjvMCS6pVAMFYhv1aUm7Bpr5vpXGLnbOG+5PTbpG4BND6XBdJLQvjpdI3xgEndTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(38100700002)(2616005)(54906003)(8936002)(8676002)(316002)(5660300002)(44832011)(2906002)(4326008)(41300700001)(6666004)(83380400001)(6486002)(66946007)(6512007)(478600001)(66556008)(86362001)(6506007)(53546011)(66476007)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVoMEtCTnZ2STRtT0RTM0ZONzZxMDhwZEIvZFVuTmk1NVZkNlJ0dWhwRWpP?=
 =?utf-8?B?NlRQdnlJKzhuOWEycEZ2T01GdDdrckthVWovbzl3enRhREpZSVRZUjNVc1R3?=
 =?utf-8?B?dVhtQU1iTnhHTEpNdWxXYW05ZVcrRlkyYi82NVY0UStwdFQxQ05FMy9KVnU5?=
 =?utf-8?B?TlEySUtxUHFGRVQ0Z0RFcVUxWFltVUZQdDVwV3l1STQ5Q1F4NTBZa01zSzlJ?=
 =?utf-8?B?azRNSGNYSFNrUnRlczU0RVVnZjY4OGhiSy9JSXpGenBaSkMrMzNPdlNuQ2F1?=
 =?utf-8?B?dDZuWUNvUlp0ejIrWlRUT0RnZ1ZBSkY5dzFQTWtmL3VqTnFWOU9GVCt2U3dT?=
 =?utf-8?B?TmowdjFicTFiNlhodnpXYXVldXFVN1pYMWk1Vmplc1liaExrNk4wV3J1U0or?=
 =?utf-8?B?RURSd0dSTS9ua1V4cEcvSXI1eHZCZGdGTC9STUI1Sy9vb1JxdWEwbVVWSFJk?=
 =?utf-8?B?OGlUV0N3QWRxS0E5T1o4bTAyQzI1WnhscEpZVTl5R2JxMm5HZHY2R3RPeDFD?=
 =?utf-8?B?OHVNdDZjN1VwT0piVXZsZVRrOEJMQVBIanlPaDBXc2FXYzdQNjNxalllUHFS?=
 =?utf-8?B?anNNQStGZHk5ZzEydEtVVEJuSU1vNDlyZGlvaXFPUldCcHZ2MlV6TWJ6RWJi?=
 =?utf-8?B?U1JBMFgrSnpmYVg3dXlidmRweGtBQW1HcGF2RmJvRSt4dlNXRUo5eEN0RVhn?=
 =?utf-8?B?a0lHdjREbnZidUgrL2ZJYWtkN0JqOTZHb1dPalJkclBuOGRuYy9nNndZT0lF?=
 =?utf-8?B?bDdtT3E1YnVJby9Ud3JreE0wRHdLUE1uQVpjbWk3Q3NnV3JMMmI0UUxONnZL?=
 =?utf-8?B?dGpYNnVmSjNOWFpVVTl6VWdYdE4yUWFyS2t1bGNxRmd2MkVCeXRza3NvalR6?=
 =?utf-8?B?TnB2V1ZqVVBVQlZRS1dwMHR5UTVlOEMvQlllODJJQW1MdmkxL0d4RndwbGdS?=
 =?utf-8?B?dkc5c0RRTnJXMU1HS0lZSjgyNUd6enpyZ1crMVVQdzBtem91Yjd1alZta0hp?=
 =?utf-8?B?SHk4RGtPVmpIaW42dW9iTVJad0hmYzdzNS92dWhBZDQwUk5paW5PUnhhR3E1?=
 =?utf-8?B?eVBKN1B5OEllMGFtRElOWi9NTW9JOVpselNheXZiaDl2emxZcEQrak9uU2Fw?=
 =?utf-8?B?bEJOd0lDNlRTbjdYSVZZR3lqQ2tIU2I0UXFrSi9HdkVsT3NQbk5zV092Qk1s?=
 =?utf-8?B?Z3dzMFVxaTBXb1pxT2FpLys3azExLzE2MkJKZFo4RUo2VG8vYkRQejhnMXU3?=
 =?utf-8?B?SDZRKzFnZ003bUY4cVpBakpGNi8rV21qVzdIZytpZ0FpTHp4L0sxNTlIb3pR?=
 =?utf-8?B?RnVqNEtGQ2tDYnZIUnN6a1hBSHNneG9wWU1vVG53czErd2ExZlRWTGNuSUx6?=
 =?utf-8?B?MDJ6MGtzSTh3SndsN01DdlJBS29uenRwbDBhY1NSL01uUDJGaTB5dHh5Mzdp?=
 =?utf-8?B?N0RJVHAwVE0vQ1ZkeTlLc3REdW5GYkNDTFVtdjNYT0xILzdxbXlHanBJUHZ2?=
 =?utf-8?B?MCszTFdHK3JNMzNnRFJ5bmlGYXZ1R0pwK3VRc002ZHJFRjFhclRpd0U0Z2g5?=
 =?utf-8?B?MmMyMUhrZVVNVzJqQ0JYcnlySkQxajl4VGZRdndZUXdMeVdpUjUwSVRnNDE4?=
 =?utf-8?B?bnFJL3lLTWZpdm9uRWFhcld5VEl6d3NkWFBoMjIzcDBtdWtMNWZsWTErcEVt?=
 =?utf-8?B?SnJXenN3NEMwQkhPd1JaeTdVTm1zb0kwZEgrSm1PNVZpQzFJQTV5VVFmazVu?=
 =?utf-8?B?aXVsS0xkcDZMSjI0clZvR1hMS0wzR2hHK3JMbFdnVGtzYmRONHU3eEdicDZ2?=
 =?utf-8?B?cVRrOWlWNGNQclVqdHdtd2NkOWI4SHlQdVk2QmhvRllJZVJwbzVCZGwzWG9v?=
 =?utf-8?B?UUMxeUF3blpVNXBoSnN4MTNRUjVIOHNUZEtwa2JEQXpTOGFuU1RSZkU5MWty?=
 =?utf-8?B?NlVyL0QwRS8wVXdZYXdJb2hubVJsa1BhZDN6aENSV28xUmZOVEM2aDF5ajVQ?=
 =?utf-8?B?RkRhanBBUzZ0NW9UdCs3RklYOUtLMWV6N3JRQmlTV1AvZUlEOUtXbXlCQW4w?=
 =?utf-8?B?L1Y3R0hFSm4rV1g0VlpFbDJOOUtnWVhDRElZWUVCem5GcExxYWoyTVVIbVR3?=
 =?utf-8?Q?tknKyiEier+38YzIgrfofM/BY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89335d53-2fc6-409a-3fd5-08dc0c694675
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:35:47.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3EgyJQYPDjOsQSgg4OenxWI5zm46GpVGVNNd28FGUxawDTceeGV8X4q8o58CFpCb0hgjbNOCYB02Of0BGlqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/1/24 13:28, Joshua Ashton wrote:
> The check for sending the vsc infopacket to the display was gated behind
> PSR (Panel Self Refresh) being enabled.
> 
> The vsc infopacket also contains the colorimetry (specifically the
> container color gamut) information for the stream on modern DP.
> 
> PSR is typically only supported on mobile phone eDP displays, thus this
> was not getting sent for typical desktop monitors or TV screens.
> 
> This functionality is needed for proper HDR10 functionality on DP as it
> wants BT2020 RGB/YCbCr for the container color space.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Cc: Melissa Wen <mwen@igalia.com>

Applied, thanks!

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
>   .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2845c884398e..6dff56408bf4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector *connector,
>   
>   	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>   		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
> -
> -	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
> +	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
> +			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> +			 stream->signal == SIGNAL_TYPE_EDP) {
>   		//
>   		// should decide stream support vsc sdp colorimetry capability
>   		// before building vsc info packet
> @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector *connector,
>   		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
>   			tf = TRANSFER_FUNC_GAMMA_22;
>   		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
> -		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   
> +		if (stream->link->psr_settings.psr_feature_enabled)
> +			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>   	}
>   finish:
>   	dc_sink_release(sink);
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 84f9b412a4f1..738ee763f24a 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
>   	}
>   
>   	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
> -	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> -		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->replay_settings.config.replay_supported)
> +	if (stream->link->psr_settings.psr_feature_enabled) {
> +		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
> +			vsc_packet_revision = vsc_packet_rev4;
> +		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> +			vsc_packet_revision = vsc_packet_rev2;
> +	}
> +
> +	if (stream->link->replay_settings.config.replay_supported)
>   		vsc_packet_revision = vsc_packet_rev4;
> -	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
> -		vsc_packet_revision = vsc_packet_rev2;
>   
>   	/* Update to revision 5 for extended colorimetry support */
>   	if (stream->use_vsc_sdp_for_colorimetry)
-- 
Hamza

