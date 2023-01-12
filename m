Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0ABC61DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 22:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F2310E94E;
	Thu, 12 Jan 2023 22:49:33 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063BE10E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:45:42 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 w4-20020a17090ac98400b002186f5d7a4cso25203525pjt.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
 b=YGaM1pN0C8twUIzQgGfKjkYks+VnXiObKg1aQaTkoY3olojecUD3RTItE7YfBzxsXQ
 ap49M0nIV5gwf/pkXPjh3bX8XHcHw2MqaSz2nwdIGfXeyGzq/xzLxr3Cigh1uBhm0PdQ
 xXPPrdT6WSBM60Mci5MPFJD/YztPmxYo5yMbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
 b=ydmsFjScFMl961MEEIvHqOrP466HDFv5Nx4BMnHGx3w9OHPh59dazCllyyOC9ZGhO0
 GhqnK8TOJ9YJ0ep1WUptMr3KFSYUmNGOvYnBD2/dyQ41nBCUaLYPpi8MHJsdosL4amzF
 m0k3DEzDz40DsljNQZ9potRaeBGyqu6MAhUT8k6YFeR1nFYLpGUxq7TtJYoXKACmSmXp
 /Gpe5mSXdo8EkuHa25yy8JYAwWh80ndy1ftVQoW2dTBuAoQCO7WT/OE8PNcshza+6d3a
 rZHUaCrBKQ+OHq+h/AIY4OUa/GL2csZbeq2484K1WjzqKeo0ptgmOSUFWOGLGGmThSAO
 yLVA==
X-Gm-Message-State: AFqh2kpVyVMpoO69SeZnDJ3gNzWhXn4aeAKJ99PSoTpXIiJDMAXY9poF
 W7LvqEoj+YnnWVYqluvKwCprEw==
X-Google-Smtp-Source: AMrXdXvGve+4kNjBvlBdmOxwGLXehsNBREHOMLlomMlydd2DdmmiiiqSkLXYqlPUtwZFaLbLOdvQUw==
X-Received: by 2002:a17:90b:2356:b0:226:e1a0:6596 with SMTP id
 ms22-20020a17090b235600b00226e1a06596mr8726077pjb.12.1673563541660; 
 Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a474700b00219463262desm10980238pjg.39.2023.01.12.14.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Date: Thu, 12 Jan 2023 14:45:40 -0800
From: Kees Cook <keescook@chromium.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: Coverity: dm_dmub_sw_init(): Incorrect expression
Message-ID: <202301121445.393EAD9B21@keescook>
References: <202301121425.FB249B61B4@keescook>
 <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 12 Jan 2023 22:49:31 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, David Airlie <airlied@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Roman" <Roman.Li@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 10:39:20PM +0000, Limonciello, Mario wrote:
> This particular one was fixed already in https://patchwork.freedesktop.org/patch/518050/ which got applied today.

Ah-ha; thanks!

-- 
Kees Cook
