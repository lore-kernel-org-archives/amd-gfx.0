Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2559EEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42B7410E05E;
	Fri, 23 Jun 2023 19:27:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88D610E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBaBzogw8aezymlu0g1taUbenSOmUFiJhsmKPb3Q27VNw7hnLTyyFckJ1UqQzGYsWsTphpTCGBG9sS3+tbtZ4sTjc9I2XIN2tCR7a5Frw6iIKQLmkdmoyjcwvOG5PU96s8Xy01SQsUzLezMc0OnKSnSC7kTr5+MGwkX6EWXv8UJx01klnEn3e4Ld6o+YmcXYt01Uhgp/ZFHOH1e5m6nRDKt3zw3/yXttanYKglrOzcUlVekRR2f4Z9Lnm9f5zbqxLkOU7hUDyQWNcdNOkscoWvNfBKLkushEprOX0Hj8lNoDgqig1nxlEHUw0mP/kGykIhwdSXCAcoX6kxgmdvZNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc4CQel+QVLq8BwUtuk6SiiPvm9lNg6u0HgupCMQG58=;
 b=DK1euexZDv8xLOO9QjZOMuvDtlfy80g1PM48IywV0LRGOSnhCQKdnYhc2qrF0hYWMUsahL66nuq1XzOaDQPWaE+pIvIQO+aRnYQwLzhRa5XyoTy41LkLn/Ia8IvPqiyelMBvRVgKwlRsei3XhWhtuwbfvMbHCzhKCFHWMThVKzfzHxdAIqU4273mt05qe0Vm0IcGU3Rsr+i4ejP/bfMI5GORFwEkDWTGn59Iq/nGZyac/3gRA8tJzEi9XJ6l4uVp9aFxb56YZxzV+FFxHElgwLmGsaHt0EIaB133Al8plYJ2+k2k7kHhXrDiyrnMPAifIuZ81uqwIwTLMXDd9DnjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc4CQel+QVLq8BwUtuk6SiiPvm9lNg6u0HgupCMQG58=;
 b=ANXMmvQR5iKpFodOOdQ0VxGv2GWK6kfmG44lZFOXgPMYANMs4+31ED4sEU9CO+4X0aa5nC2BEWYU4SGXCGI+khh0RxmRrXMneGbTCj3Ei5Z8C76l02isMgPwmwmINEYlPk6OZraNH/E+qKu46Z9hCiAYQQg9kgwdJZTZinAdGeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 19:27:02 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 19:27:02 +0000
Message-ID: <ee9c75ae-587d-9958-df45-de76635cd7c4@amd.com>
Date: Fri, 23 Jun 2023 15:27:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] drm/amd/display: Set minimum requirement for using
 PSR-SU on Rembrandt
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230622182507.25531-1-mario.limonciello@amd.com>
 <20230622182507.25531-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230622182507.25531-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:408:fc::17) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ae9e5e-afde-405a-735e-08db741fd266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4XE/Y3DhuAdjYWfqMOjmsIBDhw/xXIqLGvRGwQ88392c2NgONwdvBAUxPAHApVoDmQ2taRkPAcyzZ9HOidn7jKcT6YLt2HB3U77VtTrfASo6thtWXHkWkhyqz2kI+r8tJDUbO2t4eoYREHOEh7Ic7iSLS2FTP8E/KNQQLUzrulPoS829FFbxnNTSSm+TQRGs9i8LcOYyoBy1CSphUm8LgNMbXLdvXNhAcBW/zC131cnpCr7zmxXXEurbmlU1/OkodHnDeULE7QKkZRyR9Vy2K6ncly+Z18rUCCmvd52C1U00C5grvBzuov34n1J70AVJn/tbav0emOspCuuZv0ImSJmjtBRl0sCfG5UoiZtvIwb/ozSiLM85s7eLFoq6XFDbi31WUY0RxSeF+6KW1VPupIxPH53foT7vrSEroYfK+Ijsb1cIEop7VvQBgI+JxzKhY6TvMfChfD0Fgea66HfafQV6iAQj47kq32XF2B8cLYPUFLwK/E0MJdJo24cx3EA+ZtPFatT3vWphd1l+CsTbAnwNdoEY8oGlKxm1N3GxVRabDl8iT+RpO30eo3USt/67yz4/osIREV64v0RQL2cCQNS0B9V0m+M4HF1PAcRGfTC2SN77liV16bpTgp/hOHNlhkn93ouXrncZU+K2xchPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(478600001)(54906003)(4326008)(966005)(186003)(26005)(6486002)(6512007)(2906002)(8936002)(66556008)(66476007)(66946007)(41300700001)(8676002)(316002)(5660300002)(6506007)(53546011)(86362001)(31696002)(36756003)(83380400001)(2616005)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWd3cTNrYXRSMkk1ejBKTm5ib2I2Y25SeEtkTHFBV0M4VWFIcmdBanJTU003?=
 =?utf-8?B?SVBzd3g5R011V3dLeGxCSm11cS92NVJzNzY3SysycHg4ZVdXRTBxYnpLNWVJ?=
 =?utf-8?B?MGI2YTNFTFZ2cVcvOE8vMkJlNmFkaER2RnJjSUVZdXRSN08waXZycSs3dm5a?=
 =?utf-8?B?Sm42cjY3c2EvN2NjdEc4b3JoU3BFU0tJUjRCV3ZIYnIvOUUwazhTTjBiMk91?=
 =?utf-8?B?QnBFZWxSKzBRTlZrOHJYL1dnMHZmWjJUNTZvMEhOOG9FQ0k4YjlWeStxUFpn?=
 =?utf-8?B?bzJaYURxVDZwNE9aVVVpWnRIcjR3ZnpCWmFJVm5sN3NqQ0J0ZmozQ1p5eHR0?=
 =?utf-8?B?ZkhvZVRkalZpaDllajVxRm1UbWIva0x3cWE4TjN2aHczN28xZy90cHBvRXZo?=
 =?utf-8?B?eE1qY29oZTUxU0NWOFFjNTU5Rlc5ajhuTTFncE5iQTJSb2YvVU8wazlDbzYx?=
 =?utf-8?B?bjZCUFdrTXJLSTZ0dkJYaHdQTnZaTW5sRWw5V2lGY1hIOTlCZVY1NE5Cd09Y?=
 =?utf-8?B?QVd4T2hwZ0lhWU5WSlJGUzZDU3pOUUJqYUMvMGZCWW5OR0VIdDkrekxuL00x?=
 =?utf-8?B?eW83MDQwMEF5b2VhMmdmMnNQTnoydHlQQ21aUzBaMUtpNlVDWjdabjRuOE56?=
 =?utf-8?B?NXFaSHZMQ21qeVFCenhHSGw1UmtwVTUreFpTbFRxMzUwWXU3UStKZXdDdnNM?=
 =?utf-8?B?VW1ET1dpZ0ZGb1dGc2ZZbStMdzFaV0RPRitybTJwOXR3V2dYQWtKWEIzZjd0?=
 =?utf-8?B?cnlYakd5SVd4a09iTWxsMEtVU2VOa3I3UG1CSlI1eGRtdi80eHlYZDhoOVdW?=
 =?utf-8?B?Nm8vbFYwUXpQV1U1YlNIWUpSL2x5RzlPeTB5aFF0ZURpbm9xM2psVFQ4Zkp3?=
 =?utf-8?B?RGgrZWwwbFZkN2lScFFVTjg0cmZ0dUJ6S1I0a1VwcWY4VTkxQUJIYkRqVWtv?=
 =?utf-8?B?MlFvbVdsditkMTN4eFdrNzdoRHJISVlEaDQwc1VzZEhZQTIxV0l3NkJDZEw1?=
 =?utf-8?B?cG9kQ2t0UHMvZXdPNWdtRm4vR3g5TEthUjljSDh4dGVwK2lKS1JNcU11Z0JY?=
 =?utf-8?B?Y3VkS2Noc2FmaW4wZkpVZlA4SU9sZ3QrVVRQMG1BSGZNdVNpUnBSNktvMFdD?=
 =?utf-8?B?RnJVblBBWFZiTUdHRmxXTmhoSk1iVE1NQzFaOHA1dUhJWjJBaEtmM3l4dUow?=
 =?utf-8?B?RnZZdS9Sa3lwdDZSVHl3UmE5M2I1bXRFNmFCRkdoRFdpVnFCdWh1VDRlT3FM?=
 =?utf-8?B?TGVtRFRSOEdDYmdPOHJuRm9rcnNQYm0xNFlQaEVGaHZHVE5IdmdPNDZDbzdw?=
 =?utf-8?B?WXp2ak5XME9sSmpXaDZZTmdPaXdjS05URWJBY3ZodkpFc3FvZ1QweG9ZK3V0?=
 =?utf-8?B?OXN3OXlYMmZVZXFBNjhGQmRsVis0Rk9vSThMUmJMTndXbk9aUU1xWmY1Q0Zt?=
 =?utf-8?B?NlRwNUlsbXZNL3dEZFlPd3pNVjRSY1Uxb3prZHB4R2NjOGNFYUJnYmpmRmZv?=
 =?utf-8?B?UlBRWk1oR0F0cnNWcG13NXR4Tjd5N2M4NVJ4cCsySkltR3Rmcy9MaGFuL2R6?=
 =?utf-8?B?VjE0MVZ2MFJvd2xtMTlGNDNhYUZNeCtoMUU2ek85U2xIelp2amx2KzZxSDNt?=
 =?utf-8?B?UWxIdkp5OXJ2SUJLNTZUQW5neWJLMlZGVld6SExjM0ZBb3piOElKMXJaT1Jn?=
 =?utf-8?B?ZmhWM09TU2hZSEdheGZrcEh5QzB2dENDZ2xqaGNwcnRVakRVejBYdXN1QzNJ?=
 =?utf-8?B?c3FIR0hjWWNJem5YVXhkQVlrRHNOYUdYSlpvc0hmTS9COUxBTWlTYzNTZzhk?=
 =?utf-8?B?RHc3QmhIZUlacXRpaUxxSzNxY01qWS9jUjZmMkxzMEZFNG1JT2EwVVhPb0xP?=
 =?utf-8?B?U3RQZVFQQnIyUy9TL0hxUEhJS3JzT0hOQW1wb1NVR0ZvR2JYTGJVcmlVczBx?=
 =?utf-8?B?bzNGT3RFQlNxUkZZb3BSc2JtaENrMnc3ZGU0NmlmRk1JYWpKZ1J4Y0NKZXJt?=
 =?utf-8?B?ZUlNaVAwbEJsNmVaVHZYSG9sUll1QzcyU1FEeHdUeUhrM0hpMGs1RE1BWU9h?=
 =?utf-8?B?QXZ1bitFM01oVG1QdHV4Rm9DOHN1YUxHWUpPRmJVcy9nYkFQaHJHK0d6aDNT?=
 =?utf-8?Q?ibQs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ae9e5e-afde-405a-735e-08db741fd266
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:27:02.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SygwdD2fkMDnRixEBek9qxblPDjLtuo3+P3tx+SwLTatcQ+1plN4xEESDcBhQ/x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534
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
Cc: Sean Wang <sean.ns.wang@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>




On 6/22/23 14:25, Mario Limonciello wrote:
> A number of parade TCONs are causing system hangs when utilized with
> older DMUB firmware and PSR-SU. Some changes have been introduced into
> DMUB firmware to add resilience against these failures.
> 
> Don't allow running PSR-SU unless on the newer firmware.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  2 ++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 10 ++++++----
>   7 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index d647f68fd563..4f61d4f257cd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -24,6 +24,7 @@
>    */
>   
>   #include "amdgpu_dm_psr.h"
> +#include "dc_dmub_srv.h"
>   #include "dc.h"
>   #include "dm_helpers.h"
>   #include "amdgpu_dm.h"
> @@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
>   	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
>   		return false;
>   
> -	return true;
> +	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index c52c40b16387..c753c6f30dd7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -1011,3 +1011,10 @@ void dc_send_update_cursor_info_to_dmu(
>   		dm_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
>   	}
>   }
> +
> +bool dc_dmub_check_min_version(struct dmub_srv *srv)
> +{
> +	if (!srv->hw_funcs.is_psrsu_supported)
> +		return true;
> +	return srv->hw_funcs.is_psrsu_supported(srv);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> index a5196a9292b3..099f94b6107c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> @@ -86,4 +86,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
>   void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
>   
>   void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
> +bool dc_dmub_check_min_version(struct dmub_srv *srv);
>   #endif /* _DMUB_DC_SRV_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 2a66a305679a..4585e0419da6 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -367,6 +367,8 @@ struct dmub_srv_hw_funcs {
>   
>   	bool (*is_supported)(struct dmub_srv *dmub);
>   
> +	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
> +
>   	bool (*is_hw_init)(struct dmub_srv *dmub);
>   
>   	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> index ebf7aeec4029..c8445d474107 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> @@ -302,6 +302,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
>   	return supported;
>   }
>   
> +bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
> +{
> +	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 58);
> +}
> +
>   void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
>   			  union dmub_gpint_data_register reg)
>   {
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> index 7d5c10ee539b..89c5a948b67d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> @@ -221,6 +221,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
>   
>   bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
>   
> +bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
> +
>   void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
>   			  union dmub_gpint_data_register reg);
>   
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 9e9a6a44a7ac..fd5b043dd32d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -226,14 +226,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>   	case DMUB_ASIC_DCN314:
>   	case DMUB_ASIC_DCN315:
>   	case DMUB_ASIC_DCN316:
> -		if (asic == DMUB_ASIC_DCN314)
> +		if (asic == DMUB_ASIC_DCN314) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
> -		else if (asic == DMUB_ASIC_DCN315)
> +			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
> +		} else if (asic == DMUB_ASIC_DCN315) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
> -		else if (asic == DMUB_ASIC_DCN316)
> +		} else if (asic == DMUB_ASIC_DCN316) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
> -		else
> +		} else {
>   			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
> +		}

Should these hunks be rolled into 3/4? dmub_dcn314_is_psrsu_supported is
defined there.

Thanks,
Leo
>   		funcs->reset = dmub_dcn31_reset;
>   		funcs->reset_release = dmub_dcn31_reset_release;
>   		funcs->backdoor_load = dmub_dcn31_backdoor_load;
