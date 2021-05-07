Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB6B61078
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB6B61078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B0786EE67;
	Fri,  7 May 2021 15:56:54 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A2F6EE40;
 Fri,  7 May 2021 14:57:08 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id n15so5962426edw.8;
 Fri, 07 May 2021 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dz08TtZQHN8WysDf1KSSv+J846ggMOVj0kzY1pDn55Y=;
 b=mevx2O5womNc6xFIEoqxVhmtxLhxKExcqHGouY3g4xlRa9Uz+e16jEau8C2tB07iEv
 Z50S/FXyPhQM76QElomJRreMwiozfL5ad6pkIjk+ll6pGw2xXrS2JAmjXY0/53BDkBoU
 Db9S3af17hp9zHcT5GroAXRG5YmFKfICZN/AcwUahxHvLQWLgSfa7MNj0MbhDWpmrGQs
 jU+H6WBUA/mvnTkB07AMea3TmW/8j5n9jkoEfiVroxHk1kfwAiyWu1RRuCtH34D+fnkO
 riVFuD+I0fg00s1KAAkVymZiHA5brIMVB7v9IuJ2nqhcLDEFIFkLz6y5JThHunskwrUx
 FYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dz08TtZQHN8WysDf1KSSv+J846ggMOVj0kzY1pDn55Y=;
 b=fl2oR8HFzdrpbHov9NyJrdt452JTvpte1nr9WHXfhggxvNXKfeFx0XwR9t4VyaPq0j
 6Cl7YXYwmSQXypfn+wlICilJpuGRXpCTMRaWtd6FcJZi1eP86LQf4U3Q4SxZqG/oLSQc
 H21+0vMCkM6sWsJAB8D52s/2LUQpB1pES/cLY5zOmuxZ2/N2XJFNxHdsTEnkEh1EOUz1
 5/wSGsvgJwLixo2MwILBoSeOGMZn8D3P+oBZHgujIRW1/Hkw+k1oPgkZrIKwRwjL3KA5
 phmeTnJ9Dvca67XdOzpDFNkBWCFyOKHImyzTCwGsz3b4J6kPjpcl34yAyIJE1b/kSTvv
 amkQ==
X-Gm-Message-State: AOAM530QEDthfu+P7CQ9Qij+TsgNnx4Nrz9ke8SZ5BnBe3Zlq8vvB9eW
 rrdCF4dgcxfYe1wzcrqfxii1fxEQBLOPZg==
X-Google-Smtp-Source: ABdhPJyjUSVgdPFic/P8Et5E9RwW1l1qkvgy2QTFo4YpaB/kfDIXpAjAt064eXJjGY0LpZQutU0pmQ==
X-Received: by 2002:a05:6402:416:: with SMTP id
 q22mr11927096edv.204.1620399427010; 
 Fri, 07 May 2021 07:57:07 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net.
 [86.58.17.133])
 by smtp.gmail.com with ESMTPSA id h4sm3325354edv.97.2021.05.07.07.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 07:57:06 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <maxime@cerno.tech>,
 Maxime Ripard <maxime@cerno.tech>
Subject: Re: [v3,
 4/5] drm/connector: Add a helper to attach the colorspace property
Date: Fri, 07 May 2021 16:57:04 +0200
Message-ID: <2190160.Z2YBaczauS@jernej-laptop>
In-Reply-To: <20210430094451.2145002-4-maxime@cerno.tech>
References: <20210430094451.2145002-4-maxime@cerno.tech>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 07 May 2021 15:56:52 +0000
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Dom Cobley <dom@raspberrypi.com>,
 Tim Gover <tim.gover@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Leo Li <sunpeng.li@amd.com>,
 Robert Foss <robert.foss@linaro.org>, intel-gfx@lists.freedesktop.org,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi!

Dne petek, 30. april 2021 ob 11:44:50 CEST je Maxime Ripard napisal(a):
> The intel driver uses the same logic to attach the Colorspace property
> in multiple places and we'll need it in vc4 too. Let's move that common
> code in a helper.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
> 
> Changes from v2:
>   - Rebased on current drm-misc-next
> 
> Changes from v1:
>   - New patch
> ---

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
