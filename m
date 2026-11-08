Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD5606A31C
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EfBxpVIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AB710E178;
	Sun,  8 Nov 2026 17:38:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FEB10E178
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 17:38:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DEBC61124;
 Sun,  8 Nov 2026 17:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDB31F0089F;
 Sun,  8 Nov 2026 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794159509;
 bh=wWvFBng8dsYu30P88LFuSskBm0sLigIa38Aeo9k91og=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EfBxpVImSPRTGcwDZaAaE1p9J4B84iojZ7WITFE8ZVBv4gMmxFNBC50MD3cDyL/k0
 RsASnJwFqrhkgZBFhdlEmsDNbu0uoZF3142e0NLJRao7QPBVNC95pDRV1gGorzkln6
 ZlGOr4edXmmd17WJV0lRW3Zn8E8OS1SJhS9oyR9NRzWxkVGXzxgI3gtIUEA7ORUnuS
 OH/ghcQfrRbTkbBzrpUnBV5i58RnlclbNEMuSy5m3Je8foR6p6dTrtdUpoeaZ67TTo
 vDurIdHK9BWqGtBQ8FmRcd8uwy1lL/LrlVY67S27SqCfjTpaQd46AUaWZBWGU/neHi
 btRJEVIQEs3SQ==
Message-ID: <6adeab8a-316e-4107-be7e-5072484b0fc5@kernel.org>
Date: Sun, 8 Nov 2026 11:38:25 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add support for more PSP footer sizes
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>,
 Michael Strauss <michael.strauss@amd.com>
References: <20261106210738.668372-1-Roman.Li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261106210738.668372-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 15:07, Roman.Li@amd.com wrote:
> From: Ovidiu Bunea <ovidiu.bunea@amd.com>
> 
> [why & how]
> PSP footer size may be as big as 1932 bytes.
> 
> Add a check for this size so that the DMUB FW meta can
> be properly located.
> 
> Cc: Michael Strauss <michael.strauss@amd.com>
> Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
> Signed-off-by: Roman Li <roman.li@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  2 +
>   .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 41 ++++++++++++-------
>   2 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 17579ff2e1bf..84f825c924bc 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -76,6 +76,8 @@
>   
>   #define PSP_HEADER_BYTES_256 0x100 // 256 bytes
>   #define PSP_FOOTER_BYTES_256 0x100 // 256 bytes
> +#define PSP_FOOTER_BYTES_512 0x200 // 512 bytes
> +#define PSP_FOOTER_BYTES_1932 0x78C // 1932 bytes
>   
>   /* Forward declarations */
>   struct dmub_srv;
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 41b14b137643..72fc28feefb2 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -173,30 +173,43 @@ dmub_srv_get_fw_meta_info_from_raw_fw(struct dmub_srv_fw_meta_info_params *param
>   	uint32_t inst_const_size_temp = params->inst_const_size;
>   
>   	/* First try custom psp footer size, if present */
> -	if (params->custom_psp_footer_size) {
> -		params->inst_const_size -= params->custom_psp_footer_size;
> +	if (params->custom_psp_footer_size && inst_const_size_temp > params->custom_psp_footer_size) {
> +		params->inst_const_size = inst_const_size_temp - params->custom_psp_footer_size;
>   		fw_info = dmub_get_fw_meta_info(params);
>   		if (fw_info) {
>   			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
>   			return DMUB_STATUS_OK;
>   		}
> -		params->inst_const_size = inst_const_size_temp;
>   	}
>   
>   	/* Try 256-byte psp footer size */
> -	params->inst_const_size -= PSP_FOOTER_BYTES_256;
> -	fw_info = dmub_get_fw_meta_info(params);
> -	if (fw_info) {
> -		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
> -		return DMUB_STATUS_OK;
> +	if (inst_const_size_temp > PSP_FOOTER_BYTES_256) {
> +		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_256;
> +		fw_info = dmub_get_fw_meta_info(params);
> +		if (fw_info) {
> +			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
> +			return DMUB_STATUS_OK;
> +		}
>   	}
>   
> -	/* Try 512-byte psp footer size - final attempt */
> -	params->inst_const_size -= PSP_FOOTER_BYTES_256; // 256 bytes already subtracted, subtract 256 again
> -	fw_info = dmub_get_fw_meta_info(params);
> -	if (fw_info) {
> -		memcpy(fw_info_out, fw_info, sizeof(*fw_info));
> -		return DMUB_STATUS_OK;
> +	/* Try 512-byte psp footer size */
> +	if (inst_const_size_temp > PSP_FOOTER_BYTES_512) {
> +		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_512;
> +		fw_info = dmub_get_fw_meta_info(params);
> +		if (fw_info) {
> +			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
> +			return DMUB_STATUS_OK;
> +		}
> +	}
> +
> +	/* Try 1932-byte psp footer size */
> +	if (inst_const_size_temp > PSP_FOOTER_BYTES_1932) {
> +		params->inst_const_size = inst_const_size_temp - PSP_FOOTER_BYTES_1932;
> +		fw_info = dmub_get_fw_meta_info(params);
> +		if (fw_info) {
> +			memcpy(fw_info_out, fw_info, sizeof(*fw_info));
> +			return DMUB_STATUS_OK;
> +		}
>   	}
>   
>   	/* Restore original inst_const_size and subtract default PSP footer size - default behaviour */

