Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB543C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0313239D0
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCSldKte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0313239D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC486E123;
	Mon, 17 Aug 2020 15:25:04 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F79A6E123
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYHx22Hjk9SO0WuigHF5xk5EUMKORl8e5JmIgUyAttg=;
 b=PCSldKtesAttqF3WpvmO7Xv+t3QfDFZMcmYs4JnMJQplvXIUDL+u0Fg7TF7WrTMPJhGnzx
 cqh75xfo9ZTixG1cEh0Gr74XGw3gUkenWBaz0PMaApW/DsFRSkmynLdugL/41g4VgsLQX1
 SfwM6MC36/uVMuGVm1ZBNKUl71XO99c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-6pTwdTIHPTS6JlGHTZhMGg-1; Mon, 17 Aug 2020 11:24:57 -0400
X-MC-Unique: 6pTwdTIHPTS6JlGHTZhMGg-1
Received: by mail-qt1-f198.google.com with SMTP id k1so12262449qtp.20
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=YYHx22Hjk9SO0WuigHF5xk5EUMKORl8e5JmIgUyAttg=;
 b=XfxZvv2yNH+znIOuvAgeMoeCFymfOmhALVeuo0crw8ggOWtJddvwyZw1RxtY0NpxEB
 7I41W07UVhbVRfQotR4slCwxjw8cPl4HXxrMa+ny16xttwy+Iufmk1V1uqs2CR4ewLiy
 eR7B7KgDqBKxQRZtHLovqP9x51lGSuQwRQfesMqHJr8yb7LB5BrlJUsjUBoNQ+GACtPH
 YCgcCKR8NvOSxRLHEBGh74ypNpstk9YQqF9Zkt4XK44gMfnmrrrrTEp+5a6sWvZDZDAY
 5ARvxET3jDj0rfchvGtudCzxs/ZDZcaBHAYls2TH0eQkEPjdjn6c3EIB5P8uixzU4dPi
 67Wg==
X-Gm-Message-State: AOAM5310YN1FROdnoj2/2bwLVpOLp9ZuXypNsqyKb+xcELR4Kqs1GD2z
 b4ZOARJm9pzYFFHj7GuleBjmH+Ve0oN4QIj1YBNalx1CyBWKdDrYqnYGm++31l4PIGEL5g8mRDP
 ZUPc6bx3zxs/BCtf1DE4TGbItlQ==
X-Received: by 2002:ac8:1342:: with SMTP id f2mr14409902qtj.392.1597677896998; 
 Mon, 17 Aug 2020 08:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDJNoTKKNnjyjhaHdfokCMVzskFWoa6w5+Vl7NMOGfJ38y3hnUbk7iTfAKTgzN0pZmky6nMw==
X-Received: by 2002:ac8:1342:: with SMTP id f2mr14409884qtj.392.1597677896802; 
 Mon, 17 Aug 2020 08:24:56 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id b37sm21098426qtk.85.2020.08.17.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 08:24:56 -0700 (PDT)
Message-ID: <ef2fd2125b7a4a37437d161cc15e056332556b4a.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Don't return error code when crtc is null
From: Lyude Paul <lyude@redhat.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, mikita.lipski@amd.com, 
 nicholas.kazlauskas@amd.com, alexander.deucher@amd.com
Date: Mon, 17 Aug 2020 11:24:55 -0400
In-Reply-To: <ab808ea5782ea14c7d521d2869c211b925bbcb5a.camel@redhat.com>
References: <20200814170140.24917-1-Bhawanpreet.Lakha@amd.com>
 <ab808ea5782ea14c7d521d2869c211b925bbcb5a.camel@redhat.com>
Organization: Red Hat
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0.003
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Oh-just noticed this is also missing a CC for stable@vger.kernel.org. I'll add
it before pushing but please make sure to follow the guidelines here when
submitting fixes, since otherwise they might not get backported automatically
to older kernels:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

(you can ignore the "It cannot be bigger than 100 lines, with context." part,
as long as you're not trying to backport new functionality to stable and
you're actually fixing something they're pretty leniant about that rule)

On Mon, 2020-08-17 at 11:21 -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> I will go ahead and push this to drm-misc-fixes, thanks!
> 
> On Fri, 2020-08-14 at 13:01 -0400, Bhawanpreet Lakha wrote:
> > [Why]
> > In certain cases the crtc can be NULL and returning -EINVAL causes
> > atomic check to fail when it shouln't. This leads to valid
> > configurations failing because atomic check fails.
> > 
> > [How]
> > Don't early return if crtc is null
> > 
> > Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 70c4b7afed12..bc90a1485699 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -5037,8 +5037,8 @@ int drm_dp_mst_add_affected_dsc_crtcs(struct
> > drm_atomic_state *state, struct drm
> >  
> >  		crtc = conn_state->crtc;
> >  
> > -		if (WARN_ON(!crtc))
> > -			return -EINVAL;
> > +		if (!crtc)
> > +			continue;
> >  
> >  		if (!drm_dp_mst_dsc_aux_for_port(pos->port))
> >  			continue;
-- 
Cheers,
	Lyude Paul (she/her)
	Software Engineer at Red Hat

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
