Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F34C2D0EC
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 00:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1BC20678
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 00:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJqOLfyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1BC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCE56E05A;
	Wed,  8 Apr 2020 00:29:43 +0000 (UTC)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AA756E05A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586305780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUaMFl6VOupQh7UxmlQdV+KauWU8dk0fEOX3vcNpHB4=;
 b=dJqOLfycA0xgk07wEm0g/K7sx4v2XWBZl8G2vLiwk7+qpqbq3nJ0filXZfnWFLDZw1YaO0
 BuuVGus5APABt6847W72xIDPY2SWXW8doqLJWyRmSwmxymyrj+OYJIjVz623aWvUsi5e2F
 m8W/24W2BXNZ1w3s8SGZMPr114jI0bg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-HoyvQxo0Obim6C8KnLIwGg-1; Tue, 07 Apr 2020 20:29:39 -0400
X-MC-Unique: HoyvQxo0Obim6C8KnLIwGg-1
Received: by mail-qt1-f198.google.com with SMTP id v49so4820266qtc.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Apr 2020 17:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=tUaMFl6VOupQh7UxmlQdV+KauWU8dk0fEOX3vcNpHB4=;
 b=Ak/epFHbAdjI9oVKGQqlrQu3QEhcPaD+EbtJ5+l5zi0cRjMX8IoKBqhF0MydErY+Ss
 2OmFHlBZFJYlm63f9/wourdUrCxNmM40EH1qh6bQwo1grsZfGXDfWiUdhzp1HB+pyGYz
 rPGGYRvdYc25ABj8faUdaKj1br628Kqg5l9JQrmnYKZu6pB/NG691gBYh5pyRICHVhze
 6wM3bdtw2UbBMmd6PtlNl71g8ZSbwiYRNTIESgPFOjfbbvfgnNNLYdGk/21ntPkGsQJM
 6jiVu70qGeAVy+rJpQVpQSemeEArdZXur7S386woEQN6b6zLOMcdCH69oJAQNiq5wMfP
 3q1g==
X-Gm-Message-State: AGi0PuZOQDALnqMHVNwRFsRL0inkCahxuzbRKbRJh8HFexSX49DaZm/N
 nH9+GslWhyitSzXimv4eboDk1oNfiCSOLUCWf39OSaDDetIZgGN8sn+s5jaKoO29+Tf5VOJp9ze
 Z6NL90OEWrp0os7mT21+8E2Y0Rg==
X-Received: by 2002:a05:620a:91d:: with SMTP id
 v29mr4932434qkv.424.1586305778412; 
 Tue, 07 Apr 2020 17:29:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypIlVgpRT2Lw3SajwdlxtCzLF2X4end/IWmlCSzOGeKBN33ZJvHZrJrYh4WLb/ryv5HN3uPTuw==
X-Received: by 2002:a05:620a:91d:: with SMTP id
 v29mr4932419qkv.424.1586305778146; 
 Tue, 07 Apr 2020 17:29:38 -0700 (PDT)
Received: from Ruby.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net.
 [173.76.190.23])
 by smtp.gmail.com with ESMTPSA id g21sm12696744qtq.26.2020.04.07.17.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 17:29:37 -0700 (PDT)
Message-ID: <2f8f0ff07b39681ca07a054e74b59d14c955a7b7.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Zero assigned PBN when releasing VCPI slots
From: Lyude Paul <lyude@redhat.com>
To: mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Tue, 07 Apr 2020 20:29:36 -0400
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

Hey - didn't get a chance to take a look at this today but I will review asap!

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
