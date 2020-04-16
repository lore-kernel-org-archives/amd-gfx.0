Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5EC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 20:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E48206A2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wQJEVAQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E48206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078336EB62;
	Thu, 16 Apr 2020 20:34:01 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2556EB62
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 20:33:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnfY+NS0yaIP7YiVW0U88SOoqCTCO95IlylKUKHYy7Z9PlJCoUrD+9aF2bjfD/HE52n87R1C7OT3WdTh1kaNpB0ms39+JS3ylwn2jEqhdSa+kR/ApN5KEAUsX4iTR/wDyU5npy95as567u54V5+1QAWyUTiMDeHzQklT3Uw5vlr/vOtU+qRbcpdSs90c9NZ0BQmn8hUmEKPXe68MSeUX3+1sj6kDsbXfOHUi19r2MD3f/Vp5VRHuvHqqAD1teKlVGjNjUGDl69DMBu8JUsr3P8+ubASziBmh+exiNb3Qbpx+gFIPfKysdVMJ6pE0oEhzS+AtMjF9CpjTnSXzMvSECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvd0qqcnIikRUWfjtq4XDfqSmYPltDo+BDYBYals4Cw=;
 b=jC9rV34QjAek5iZLqGa4gXuI5CPbZxyt4goVdVZw+WMM+CNsduhp5vQCbpN9bsz0PEEDkyM1KWIaY5yP9yJa464UI4rmpBVCfglRODgGoixV87Yzk+zq/tsy+v/qytVUiPQ88Y+cMjcPU34oMULfjGlKkBbpyg78coyO/r0REJ8i0wYf0d5EGIzCixhBEYOcv2r6awO83ZmtUW2iiLDkcvEQHhAxT+u22AoixbOKvmvaGpiuf8i70JqUf3W65Vexa4jjiHWY9tknTVw5Utga8x7o7pmuulIB4sP9T3VJskMECsgKOjSokZoGEKnUyjznYtZvWCDo1PyLiUvezOE8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvd0qqcnIikRUWfjtq4XDfqSmYPltDo+BDYBYals4Cw=;
 b=wQJEVAQhbaq1jQQ92M6VESbR4nUEp1mBHhz/7rvppnxApp16hURXZrDNN6WNVPfMb8U7j+BLpKgfTavv/nsErWJOZUFnHSd4obS8S4iPWEXo4WeQPd5kWKsnTOtjwAWKqiYhOiPNnidZ8oO8umj10TO+urb9xrkb9H0kaT5BAk4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 20:33:57 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::f4d7:424e:e4c8:e875]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::f4d7:424e:e4c8:e875%9]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 20:33:57 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/display: give aux i2c buses more
 meaningful names
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200416194325.21755-1-alexander.deucher@amd.com>
 <20200416194325.21755-2-alexander.deucher@amd.com>
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
Message-ID: <0c270366-1d76-d66f-86af-b668905f2e04@amd.com>
Date: Thu, 16 Apr 2020 16:33:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200416194325.21755-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR08CA0080.namprd08.prod.outlook.com
 (2603:10b6:404:b6::18) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:9240:c66::7] (2607:fea8:9240:c66::7) by
 BN6PR08CA0080.namprd08.prod.outlook.com (2603:10b6:404:b6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 20:33:56 +0000
X-Originating-IP: [2607:fea8:9240:c66::7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5aa573ae-4566-4fa0-b942-08d7e2457c9f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:|MW3PR12MB4507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4507CF025D9844810BEF10EC8CD80@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(5660300002)(6486002)(31696002)(2906002)(66476007)(66556008)(31686004)(4326008)(478600001)(66946007)(8936002)(81156014)(8676002)(53546011)(16526019)(2616005)(6666004)(52116002)(36756003)(186003)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXoE+4v4Ynkxu0CrIcm0KsaS+voaJQG6HVqtcPsNcHm1eb+Xs4moWE7gqxGbB8IMAJFgI2FaYaB3HkIQ+aBkRztZHZToN5uuQ/xuLRPxgCMFhzO2m0FnL7Dm8eNfuBIOu7SMnsLKCDMr/DFkvRrrZslRa+uPiD0z2JH+XVkSee9heoLUmYppTiDpqVb4jxMjIkO4lGCRhhgKatqd35d6uJ/spsDgkESizS8KTeJ0+0crgL1UH8Sw6/BMrFP90f0BLLDpsNUPhzV7/E5TMWdecw6inyLw7ZOQlOE2uwFhzaZLmE1UqLfxn2eywabu3GR+R9iQfU/mREQrFsmGaAxbPFfTQChUCvaWYBN1kk8jRCfp0glcH6dL/UqaV3hYBeBtir2xpfJz5GXeokgJwhpiM14wkSOs4Pkea3QWtSFPJqeTVY5x+cReZzi4tCsQqgk1
X-MS-Exchange-AntiSpam-MessageData: HtfKyDpKEo+kK5UEtp4GnOoD1kQ5P5qm9H6cZVyW/fdW9XgOjOxn6w2IXsw3JGKDVnarUppgJF50E3A/FJqr0XJujMukNOx2zZXKOLj8ljSTJlMqZbA73nvKDSozHfNCgeI1pJaDJDbhM9b0ThLYakxQTfIEu7C6WiuG5Bcc7pY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa573ae-4566-4fa0-b942-08d7e2457c9f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 20:33:57.0993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVCzNs3NHt0ZTPno1s/YBXG5jx+E01GCsD0TRwwpJYWalBSzx1pTevewZxTB7Dc1k01StRt5tSidudP/AMK1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-16 3:43 p.m., Alex Deucher wrote:
> Mirror what we do for i2c display buses.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 3 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 7 +++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fc81788f24b4..4a85076c36ab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4679,6 +4679,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>  		i2c_del_adapter(&aconnector->i2c->base);
>  		kfree(aconnector->i2c);
>  	}
> +	kfree(aconnector->dm_dp_aux.aux.name);
>  
>  	kfree(connector);
>  }
> @@ -6119,7 +6120,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>  
>  	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort
>  		|| connector_type == DRM_MODE_CONNECTOR_eDP)
> -		amdgpu_dm_initialize_dp_connector(dm, aconnector);
> +		amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);
>  
>  out_free:
>  	if (res) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7d28b0482127..69056660672d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -429,9 +429,12 @@ static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
>  };
>  
>  void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
> -				       struct amdgpu_dm_connector *aconnector)
> +				       struct amdgpu_dm_connector *aconnector,
> +				       int link_index)
>  {
> -	aconnector->dm_dp_aux.aux.name = "dmdc";
> +	aconnector->dm_dp_aux.aux.name =
> +		kasprintf(GFP_KERNEL, "AMDGPU DM aux hw bus %d",
> +			  link_index);
>  	aconnector->dm_dp_aux.aux.transfer = dm_dp_aux_transfer;
>  	aconnector->dm_dp_aux.ddc_service = aconnector->dc_link->ddc;
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> index d6813ce67bbd..d2c56579a2cc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> @@ -32,7 +32,8 @@ struct amdgpu_dm_connector;
>  int dm_mst_get_pbn_divider(struct dc_link *link);
>  
>  void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
> -				       struct amdgpu_dm_connector *aconnector);
> +				       struct amdgpu_dm_connector *aconnector,
> +				       int link_index);
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  bool compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
