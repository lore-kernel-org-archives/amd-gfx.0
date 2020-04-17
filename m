Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE7FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DFD221E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzP6DKhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DFD221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059B56EC4D;
	Fri, 17 Apr 2020 22:20:55 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ECFE6EC4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 22:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587162052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzRc/v3Xx0E1ZKVi1/Mf8j0Wa0CDdC/8BTT/hHrxfaw=;
 b=JzP6DKhDtgosNLsUKlvisNak9AAVAf/cgGcpDZNF4qBw+QecgI9xdpNqVitMuhKD5goM4g
 0jyW5L34rfx8OtijPfKbMBGklmQbVeQtiLSXKjJ+PtxwKU44L7UU1FAO//18nmTfm7CGHi
 VriHaep6+Bgib7J7W0SNSI2CuRDLSrk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-ORXW2FA7Nx6ha14Qz0hgYw-1; Fri, 17 Apr 2020 18:20:49 -0400
X-MC-Unique: ORXW2FA7Nx6ha14Qz0hgYw-1
Received: by mail-qv1-f69.google.com with SMTP id v4so3660954qvt.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 15:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=ZzRc/v3Xx0E1ZKVi1/Mf8j0Wa0CDdC/8BTT/hHrxfaw=;
 b=hIxW3jYJO/kdZG+4xGRh589gUlCIAb/gk+UF60Cog5z4dsmRgQ6IFw/qnI3+mU/63p
 bMB3U2IB+iPZD+5s+Yyjh6sV1O2VyLy821xStCTwMq3qHSkONqZi5Gm3ByFv1OLODHOR
 Cd57VBJYJ7CFod1bDgY9/xyZzul0Z+r2zNlhQTJ6lsOmNS5fP/VgldSdSKQFa+62D5tZ
 BqivEWJYFdlQUSllrfE7YSvOlO22Whho7V3JJmSZ+JM+KVvEVx3f0NrqvdeTqc11Wejy
 f0mWsJuAi7K0B+lJCyV1US0gfxTN8dNyp3zMmGMlYb3jumQAtqZjyAOKDKHUHLJx5wNQ
 Nr8Q==
X-Gm-Message-State: AGi0Pua0x3wvrfxlcfpncOL+gcQgOKY+6c4mnsB8hsTetcViKAXeH7bg
 WcyIkJea9Kb/CHMrCvWNC8d0J7ORdXre6WutXjLt+d7ewr4GoFKhznp/mxmInF6nh2u0u9pIDSV
 UEYx2ru46sBDPyaExRzjvBO/Ubg==
X-Received: by 2002:a37:b181:: with SMTP id a123mr5681830qkf.10.1587162048812; 
 Fri, 17 Apr 2020 15:20:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGE7m+KFsYr0B6VUVs0qc6m23Gdy+O7+lN47GrvI/DVrguYiDNGukMP1hgUKZVeeSIRbjN2g==
X-Received: by 2002:a37:b181:: with SMTP id a123mr5681814qkf.10.1587162048590; 
 Fri, 17 Apr 2020 15:20:48 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net.
 [173.76.190.23])
 by smtp.gmail.com with ESMTPSA id m83sm12620232qke.117.2020.04.17.15.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 15:20:47 -0700 (PDT)
Message-ID: <ec314b1e4255c32c9bc0880f72f3bcf36e384526.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Zero assigned PBN when releasing VCPI slots
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Fri, 17 Apr 2020 18:20:46 -0400
In-Reply-To: <20200407160717.27976-1-mikita.lipski@amd.com>
References: <20200407160717.27976-1-mikita.lipski@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Alexander.Deucher@amd.com, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

In the future btw, you should use the DRM maintainer tools to add a Fixed-by
tag, since this:

Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST
atomic check")

Also so it gets cc'd to stable, I'll fixup the patch and push it. Thanks!

On Tue, 2020-04-07 at 12:07 -0400, mikita.lipski@amd.com wrote:
> From: Mikita Lipski <mikita.lipski@amd.com>
> 
> Zero Port's PBN together with VCPI slots when releasing
> allocated VCPI slots. That way when disabling the connector
> it will not cause issues in drm_dp_mst_atomic_check verifying
> branch bw limit.
> 
> Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 38bf111e5f9b..ed109dd15df6 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4276,6 +4276,7 @@ int drm_dp_atomic_release_vcpi_slots(struct
> drm_atomic_state *state,
>  	if (pos->vcpi) {
>  		drm_dp_mst_put_port_malloc(port);
>  		pos->vcpi = 0;
> +		pos->pbn = 0;
>  	}
>  
>  	return 0;
-- 
Cheers,
	Lyude Paul (she/her)
	Associate Software Engineer at Red Hat

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
