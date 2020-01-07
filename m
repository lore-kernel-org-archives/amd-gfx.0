Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AAC282DD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 18:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC8F20656
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aEQJrkXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55366E0FB;
	Tue,  7 Jan 2020 18:49:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECA06E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 18:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyVHHqVkClOQvV0p8RLLcYOfp43RykuqLbO1rXPxrvYvwdB8cepcVIGUvBDo1jO5rrd9Ewy68OWVdDohXy/Q2OLLP8OIiqrTkBKmkXyLFtiyveNLsbmwzDquWL3J4leF1ZvdGS0YDLjIV2Q+JtjLBVK8xWr1vLsroivEOuOZBdzVY9sVCrZ9llhd4KRxnyg9RfpKX3LllMKOi2XwD3m3Bs1ppE2+KYGqOhYhurB+lLRqo9rRQSt6ELcd3RpDmtCxL92Tz+IkLV00tnxKtrDNAHTm3hqy+qf1tRjEuyswhgzUIiuwFL11JTK5vol8Fw1tZ2ZkXqvJcaMjm5RTNcf5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URyNr7IB8XCnP0SNBVleI7M5Z4X1JVAYqj+2dranM9s=;
 b=JfJVKdRgVNOfcpEIF4MyDtjb7boHbM0bIf8AHNagNJjJbF8URTNRSNnEItwLiGRq17Dv+n7wIehDdOxEfe1e/zu7Mm7ptwR8R0cumor1w0254flhXeqRywG520U8dSGS9xAKyd4MKPf1NkjXbBDoDZyKNFU7E+JTf7OqIZPvGX09UeHRE0CkcpkPqkyqrdzJo2xyRyP1thMyXsp0YbLgPFwSbPZ938MFPVcms2vvyxRTcdX1DICKB7KCo0W6yvlxaC4W2kv9p78RWNEk6SDyYyhXldVYYeJ2bk+5SfUEDQXQdAj3s94DLLM5Kzwr2zYX7pbrh/nQ4h38omvKnph35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URyNr7IB8XCnP0SNBVleI7M5Z4X1JVAYqj+2dranM9s=;
 b=aEQJrkXDGDt8FljlKH4+NQDAXbvpiKVZNwSzFEgsrEr5Zde4SXTMkCfg7l58JNliRUSpA9EUqySyrzL4xJ+w69dB05fVf5UeKKMxLUmZhEHbAxV10sd+2xIExrBOVtAKqfpi2pbIy6qRQv95WScSVyioaCU3OlP+gx8lD1rtJug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0056.namprd12.prod.outlook.com (10.172.78.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Tue, 7 Jan 2020 18:49:27 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::4c09:215c:e5d2:3c8f%9]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 18:49:27 +0000
Subject: Re: [PATCH] drm/amd/display: Check return value of drm helper
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
References: <20200107164112.6481-1-mikita.lipski@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <47b040f8-834c-3fc5-5b6a-7345e2b1bc27@amd.com>
Date: Tue, 7 Jan 2020 13:49:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200107164112.6481-1-mikita.lipski@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Tue, 7 Jan 2020 18:49:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7cd3955-ba26-43f0-9324-08d793a25224
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:|CY4PR1201MB0056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00569D14DC2C46FFB6A91A808C3F0@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 027578BB13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(81156014)(31696002)(8936002)(316002)(8676002)(956004)(26005)(478600001)(16576012)(52116002)(53546011)(186003)(2616005)(81166006)(31686004)(16526019)(5660300002)(4326008)(36756003)(2906002)(66476007)(66556008)(66946007)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB0056;
 H:CY4PR1201MB0230.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dYYMsfrwb8zQJ/bNXIKYgjA3k0PVgyZAWwWGVbLBcZgHZtxJG09uKF4FxWdEO7Ex7svYzNjvh1N//vxAfhuXCHH667hZZaS9duoyHBFzWjhmVGRO4+LZFm9A8IuTOUxLIceQgQkm7J0BgUXhVfkmYIgGsPMYkWzJqtWRJyriTsIXgGot3h9jF9sngz7eo4Uwon+5UCKPJF2FiDINDs2nFx1YNDH4wLBoSXbxTKR/ct3Avi0DdtPysls3izGc5wAwoX/Q5L3n8orcZsHuH8jMcBrX7M5/l479Cpm7ln6gPaNssi3H67Lyt18SncpZ5jKC/ql/wwT2KGSM8hCpauWKKJLxkrqslz5Mpyi30eJpwOfRqMGQ4ZgtkNMjQGUKaFa0OCa1zm1qXqlctndv2Zy4J7KRTYdrueVbQkQnLGovey6ozMuV7XPtU2ifI4F3wlx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cd3955-ba26-43f0-9324-08d793a25224
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 18:49:27.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV4HHSxR7/wneHosQU6+0fxB/YGJfk/ZavFg28ulzbP8iNpVTDM9pZBmwIcFSosaqZ/EUhrKF3L2lAdzgDp1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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
Cc: Alexander.Deucher@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-07 11:41 a.m., mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> 
> If driver fails to update update VCPI allocation during
> compute_mst_dsc_configs_for_state - fail the function
> by early return.
> 
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 99 ++++++++++---------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 35c8b1469f4c..7911c5dac424 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -621,37 +621,41 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
>  
>  		if (initial_slack[next_index] > fair_pbn_alloc) {
>  			vars[next_index].pbn += fair_pbn_alloc;
> -			drm_dp_atomic_find_vcpi_slots(state,
> -						      params[next_index].port->mgr,
> -						      params[next_index].port,
> -						      vars[next_index].pbn,
> -						      dm_mst_get_pbn_divider(dc_link));
> +			if (drm_dp_atomic_find_vcpi_slots(state,
> +							  params[next_index].port->mgr,
> +							  params[next_index].port,
> +							  vars[next_index].pbn,\
> +							  dm_mst_get_pbn_divider(dc_link)) < 0)
> +				return;
>  			if (!drm_dp_mst_atomic_check(state)) {
>  				vars[next_index].bpp_x16 = bpp_x16_from_pbn(params[next_index], vars[next_index].pbn);
>  			} else {
>  				vars[next_index].pbn -= fair_pbn_alloc;
> -				drm_dp_atomic_find_vcpi_slots(state,
> -						      params[next_index].port->mgr,
> -						      params[next_index].port,
> -						      vars[next_index].pbn,
> -						      dm_mst_get_pbn_divider(dc_link));
> +				if (drm_dp_atomic_find_vcpi_slots(state,
> +								  params[next_index].port->mgr,
> +								  params[next_index].port,
> +								  vars[next_index].pbn,
> +								  dm_mst_get_pbn_divider(dc_link)) < 0)
> +					return;
>  			}
>  		} else {
>  			vars[next_index].pbn += initial_slack[next_index];
> -			drm_dp_atomic_find_vcpi_slots(state,
> -						      params[next_index].port->mgr,
> -						      params[next_index].port,
> -						      vars[next_index].pbn,
> -						      dm_mst_get_pbn_divider(dc_link));
> +			if (drm_dp_atomic_find_vcpi_slots(state,
> +							  params[next_index].port->mgr,
> +							  params[next_index].port,
> +							  vars[next_index].pbn,
> +							  dm_mst_get_pbn_divider(dc_link)) < 0)
> +				return;
>  			if (!drm_dp_mst_atomic_check(state)) {
>  				vars[next_index].bpp_x16 = params[next_index].bw_range.max_target_bpp_x16;
>  			} else {
>  				vars[next_index].pbn -= initial_slack[next_index];
> -				drm_dp_atomic_find_vcpi_slots(state,
> -						      params[next_index].port->mgr,
> -						      params[next_index].port,
> -						      vars[next_index].pbn,
> -						      dm_mst_get_pbn_divider(dc_link));
> +				if (drm_dp_atomic_find_vcpi_slots(state,
> +								  params[next_index].port->mgr,
> +								  params[next_index].port,
> +								  vars[next_index].pbn,
> +								  dm_mst_get_pbn_divider(dc_link)) < 0)
> +					return;
>  			}
>  		}
>  
> @@ -700,22 +704,24 @@ static void try_disable_dsc(struct drm_atomic_state *state,
>  			break;
>  
>  		vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps);
> -		drm_dp_atomic_find_vcpi_slots(state,
> -					      params[next_index].port->mgr,
> -					      params[next_index].port,
> -					      vars[next_index].pbn,
> -					      0);
> +		if (drm_dp_atomic_find_vcpi_slots(state,
> +						  params[next_index].port->mgr,
> +						  params[next_index].port,
> +						  vars[next_index].pbn,
> +						  0) < 0)
> +			return;
>  
>  		if (!drm_dp_mst_atomic_check(state)) {
>  			vars[next_index].dsc_enabled = false;
>  			vars[next_index].bpp_x16 = 0;
>  		} else {
>  			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.max_kbps);
> -			drm_dp_atomic_find_vcpi_slots(state,
> -					      params[next_index].port->mgr,
> -					      params[next_index].port,
> -					      vars[next_index].pbn,
> -					      dm_mst_get_pbn_divider(dc_link));
> +			if (drm_dp_atomic_find_vcpi_slots(state,
> +							  params[next_index].port->mgr,
> +							  params[next_index].port,
> +							  vars[next_index].pbn,
> +							  dm_mst_get_pbn_divider(dc_link)) < 0)
> +				return;
>  		}
>  
>  		tried[next_index] = true;
> @@ -769,11 +775,12 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
>  		vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
>  		vars[i].dsc_enabled = false;
>  		vars[i].bpp_x16 = 0;
> -		drm_dp_atomic_find_vcpi_slots(state,
> -					      params[i].port->mgr,
> -					      params[i].port,
> -					      vars[i].pbn,
> -					      0);
> +		if (drm_dp_atomic_find_vcpi_slots(state,
> +						 params[i].port->mgr,
> +						 params[i].port,
> +						 vars[i].pbn,
> +						 0) < 0)
> +			return false;
>  	}
>  	if (!drm_dp_mst_atomic_check(state)) {
>  		set_dsc_configs_from_fairness_vars(params, vars, count);
> @@ -786,20 +793,22 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
>  			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.min_kbps);
>  			vars[i].dsc_enabled = true;
>  			vars[i].bpp_x16 = params[i].bw_range.min_target_bpp_x16;
> -			drm_dp_atomic_find_vcpi_slots(state,
> -					      params[i].port->mgr,
> -					      params[i].port,
> -					      vars[i].pbn,
> -					      dm_mst_get_pbn_divider(dc_link));
> +			if (drm_dp_atomic_find_vcpi_slots(state,
> +							  params[i].port->mgr,
> +							  params[i].port,
> +							  vars[i].pbn,
> +							  dm_mst_get_pbn_divider(dc_link)) < 0)
> +				return false;
>  		} else {
>  			vars[i].pbn = kbps_to_peak_pbn(params[i].bw_range.stream_kbps);
>  			vars[i].dsc_enabled = false;
>  			vars[i].bpp_x16 = 0;
> -			drm_dp_atomic_find_vcpi_slots(state,
> -					      params[i].port->mgr,
> -					      params[i].port,
> -					      vars[i].pbn,
> -					      0);
> +			if (drm_dp_atomic_find_vcpi_slots(state,
> +							  params[i].port->mgr,
> +							  params[i].port,
> +							  vars[i].pbn,
> +							  0) < 0)
> +				return false;
>  		}
>  	}
>  	if (drm_dp_mst_atomic_check(state))
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
