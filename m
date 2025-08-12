Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AFFCA0EDC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97ABC10E190;
	Tue, 12 Aug 2025 22:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mWcfC2tL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B106110E190
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cZH0ORetFoD29KRw7veeD0m/YRDafsz4/l2sKB+7d1I=; b=mWcfC2tLm+H333rYz5hAXSrZlf
 KYRyMaCt2pqW0f8pjxV6dA/RUwLRu9jZ/BqdJcMQUit5gJhYOYLDJ1VZwN/3yAzL1L2C23myczW96
 3f4qvT17hDjr0EK+51skj0zP4QSE+DHc+ckVFqeG+3zbVUqjKIXnSQ4jXLLdpbPJDhuR9zh4jw8EE
 3SotbdKssuZAa++5ca0iv99YKlFfQArZNgg4iS8jiq70RQ7Emy1En5ekDQOkRfUFvfWzbVQtsobNI
 MR/FZc08zB1WsdmVwZBF9PGxD/PRxhPCV5F54s9Bv840lwSiT7vdCn+NHNhxqViJBwo66XnVA6wLm
 utXIccBQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxxS-00DR5y-0J; Wed, 13 Aug 2025 00:59:06 +0200
Date: Tue, 12 Aug 2025 16:59:02 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH 6/7] drm/amd/display: Don't print errors for nonexistent
 connectors
Message-ID: <d3wy7iarinvx6kmkrl432rfxyib4nrislxlcwbn3yxn2nu65cz@iefjwlptxujz>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-7-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-7-timur.kristof@gmail.com>
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

On 07/31, Timur Kristóf wrote:
> When getting the number of connectors, the VBIOS reports
> the number of valid indices, but it doesn't say which indices
> are valid, and not every valid index has an actual connector.
> If we don't find a connector on an index, that is not an error.
> 
> Considering these are not actual errors, don't litter the logs.
> 
> Fixes: 60df5628144b ("drm/amd/display: handle invalid connector indices")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +----
>  drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index 67f08495b7e6..154fd2c18e88 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -174,11 +174,8 @@ static struct graphics_object_id bios_parser_get_connector_id(
>  		return object_id;
>  	}
>  
> -	if (tbl->ucNumberOfObjects <= i) {
> -		dm_error("Can't find connector id %d in connector table of size %d.\n",
> -			 i, tbl->ucNumberOfObjects);
> +	if (tbl->ucNumberOfObjects <= i)
>  		return object_id;
> -	}
>  
>  	id = le16_to_cpu(tbl->asObjects[i].usObjectID);
>  	object_id = object_id_from_bios_object_id(id);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index cf3893a2f8ce..33d6a5116aad 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -217,11 +217,24 @@ static bool create_links(
>  		connectors_num,
>  		num_virtual_links);
>  
> -	// condition loop on link_count to allow skipping invalid indices
> +	/* When getting the number of connectors, the VBIOS reports the number of valid indices,
> +	 * but it doesn't say which indices are valid, and not every index has an actual connector.
> +	 * So, if we don't find a connector on an index, that is not an error.
> +	 *
> +	 * - There is no guarantee that the first N indices will be valid
> +	 * - VBIOS may report a higher amount of valid indices than there are actual connectors
> +	 * - Some VBIOS have valid configurations for more connectors than there actually are
> +	 *   on the card. This may be because the manufacturer used the same VBIOS for different
> +	 *   variants of the same card.
> +	 */
>  	for (i = 0; dc->link_count < connectors_num && i < MAX_LINKS; i++) {
> +		struct graphics_object_id connector_id = bios->funcs->get_connector_id(bios, i);
>  		struct link_init_data link_init_params = {0};
>  		struct dc_link *link;
>  
> +		if (connector_id.id == CONNECTOR_ID_UNKNOWN)
> +			continue;
> +
>  		DC_LOG_DC("BIOS object table - printing link object info for connector number: %d, link_index: %d", i, dc->link_count);
>  
>  		link_init_params.ctx = dc->ctx;
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
