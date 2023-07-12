Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6192AEB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 07:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8B10E4A2;
	Wed, 12 Jul 2023 07:38:29 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E116B10E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 07:38:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R18jq2jYFz9spR;
 Wed, 12 Jul 2023 09:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1689147503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gnX3MY5n7IqrPQmLZHVpzDm3rD17nTcEur8VsWSZ+c=;
 b=E5MgKvilhHiIM+6gWVW8DkfqX3466IKiCrlvzxYV3vqgAM6r1ToZC2273e/MKFygmL1m9N
 CfhNrRwSSrmII4vWZbtRZi6bpJUVGlFX+IdA/0pZXJ0djWGofkrkaCBQhV6PgGO/jWFJ1s
 FtVfs06/T2gopCp5jRdrK+AmxSuQCu1RW6V3wzxnTlB2ubTM+wAiys2gOuub2nefXydEvT
 41wIYr/FndQF+Vd2wAnyphud+V7H6dLUdHuZQEcrsJ8xVTS4gJdqIzgF5bwVy5EJsCsf0Q
 oVpUz6/bFODu6bgX38Qu86D7UptNUjjX6REG0tMkpNT/15zsj3qSMFAj5u/EtA==
Message-ID: <81821e44-9c4a-855d-83e7-42d2999b7078@mailbox.org>
Date: Wed, 12 Jul 2023 09:38:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Use root connector's colorspace property
 for MST
Content-Language: en-CA
To: Harry Wentland <harry.wentland@amd.com>
References: <20230711195021.171964-1-harry.wentland@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230711195021.171964-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jkfg4ijqjpijhjdjfuhh4fp1pqw3res8
X-MBO-RS-ID: fe0c1431a15cad9f26d
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/11/23 21:50, Harry Wentland wrote:
> After driver init we shouldn't create new properties. Doing so
> will lead to a warning storm from __drm_mode_object_add.
> 
> We don't really need to create the property for MST connectors.
> Re-using the mst_root connector's property is fine.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5722b14a6bec..ba493d325dcb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7359,8 +7359,13 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  			drm_connector_attach_colorspace_property(&aconnector->base);
>  	} else if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>  		   connector_type == DRM_MODE_CONNECTOR_eDP) {
> -		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
> -			drm_connector_attach_colorspace_property(&aconnector->base);
> +		if (!aconnector->mst_root)
> +			if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
> +				drm_connector_attach_colorspace_property(&aconnector->base);
> +		else /* use root connector's property */
> +			if (aconnector->mst_root->base.colorspace_property)
> +				drm_connector_attach_colorspace_property(&aconnector->mst_root->base);
> +

../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function ‘amdgpu_dm_connector_init_helper’:
../drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7361:20: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wdangling-else]
 7361 |                 if (!aconnector->mst_root)
      |                    ^

I think coding style asks for curly braces around both cases as well.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

