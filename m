Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98797C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A8820866
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 21:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJWtPkF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A8820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3271E6ECB8;
	Fri, 20 Dec 2019 21:45:18 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BD56ECB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576878316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8zSG1RPASkHkV56GZulUOiAvmwOUPVucW5rPiy8WYI0=;
 b=FJWtPkF2vlvr8IuYkTOegQVFmMhBNLl4mtFKugEUXSz4X/Gcl7R/nhGWykqozIowXZpnV8
 bx5tIZqV2Tw4A1zOXkg/uyZuNtmnM+zQkKywKIfLBaPsCRc5OjQ9WdYhS8vgvXB+2mgRmf
 PrL8A9wWtZeAoIjHwVDY4MLp90gjajM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-pwLW2ksPN2KNH7u77zgYrA-1; Fri, 20 Dec 2019 16:44:10 -0500
Received: by mail-qt1-f200.google.com with SMTP id b7so3860086qtg.23
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 13:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=8zSG1RPASkHkV56GZulUOiAvmwOUPVucW5rPiy8WYI0=;
 b=g8/zvx+mSFxeeSn3TJesH/itjj9s1y91uotK6Qs9qqr0NUoasyzlEKyMLwa5YVJ9XL
 q/p0iOj91jXDMuqQPV3h3l9+FlBjzoT5dhq1xPjFu3fTAjlKFiL6b2P/2+tqCOROmybM
 Wa1KLk4ZEzUCm4rS87iN8NOrofUSeVbKjT/Q2heksqWVOdx3GfsGM8SJty8261DeE/BF
 lOInHqpzso0i7Ixwsj3yEkzslExNeVwExz6rNX0z5a7fEJeXOg5wbC37WEzLRa2x2WaH
 B4XLnONan8XzKwD5Rsma+QdmXAuGCGVuuTz5ouMEeWRzL1XIAfi9zqfjvnHTBEQE0gNv
 H4MA==
X-Gm-Message-State: APjAAAUEhbxrc3NSGxsqknTzvJ8kk1LcOv3Kxz9RhoE/7/OxZceo3tPF
 t7plm9voApvch5o2RnH7IJYzhkbJj16EHp2Nkrckmi4u4Lb4ijzSqiNDFCoSllgzG6eqfEcpUue
 8eFCZ9jclDdw23mxdZwYg3ESaaw==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr13347196qtq.229.1576878249304; 
 Fri, 20 Dec 2019 13:44:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvTHN7McuqaMs0DzRwA0Cr2fJYDyz2KZJJKzarXufNvHYFhYEp4zKajefQ3+t73J0fXsyMFg==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr13347183qtq.229.1576878249079; 
 Fri, 20 Dec 2019 13:44:09 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id 40sm3421307qtc.95.2019.12.20.13.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 13:44:08 -0800 (PST)
Message-ID: <79fe00bc7373bb8b448b4c0b7a1140d87a2afdf5.camel@redhat.com>
Subject: Re: [PATCH v9 14/18] drm/amd/display: Add PBN per slot calculation
 for DSC
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org
Date: Fri, 20 Dec 2019 16:44:07 -0500
In-Reply-To: <20191213200854.31545-15-mikita.lipski@amd.com>
References: <20191213200854.31545-1-mikita.lipski@amd.com>
 <20191213200854.31545-15-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: pwLW2ksPN2KNH7u77zgYrA-1
X-Mimecast-Spam-Score: 0
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
Cc: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Lyude Paul <lyude@redhat.com>

On Fri, 2019-12-13 at 15:08 -0500, mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> 
> [why]
> Need to calculate VCPI slots differently for DSC
> to take in account current link rate, link count
> and FEC.
> [how]
> Add helper to get pbn_div from dc_link
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 8 ++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h   | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7557edee7db0..c376c8ccd391 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -491,3 +491,11 @@ void amdgpu_dm_initialize_dp_connector(struct
> amdgpu_display_manager *dm,
>  		aconnector->connector_id);
>  }
>  
> +int dm_mst_get_pbn_divider(struct dc_link *link)
> +{
> +	if (!link)
> +		return 0;
> +
> +	return dc_link_bandwidth_kbps(link,
> +			dc_link_get_link_cap(link)) / (8 * 1000 * 54);
> +}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> index 2da851b40042..a553ea046185 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> @@ -29,6 +29,8 @@
>  struct amdgpu_display_manager;
>  struct amdgpu_dm_connector;
>  
> +int dm_mst_get_pbn_divider(struct dc_link *link);
> +
>  void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>  				       struct amdgpu_dm_connector
> *aconnector);
>  
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
