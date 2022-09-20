Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC36C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCC910E6AE;
	Tue, 20 Sep 2022 12:55:24 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF6D10E64C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:32:08 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id bq9so4052097wrb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date;
 bh=1MF4EqMmKiknkCxbkWjC3WSdMgGUyAMwUXpH/v5PLhs=;
 b=hqQ+kEhXrINc6InWXqyon5OwHwauo0C0OEZqG9NYnnK3ZJEsnGX1dAgFB3BKCrj+G2
 dPc7q5c1k8lHWMoQBkHE/1IaSTUy3ygewYM52gTFSgKVYi2WbLib61VKuUPe+W0DDkYR
 JKD8dDfQC2/sTJdVL6sudb0h/OJjZIYbZ88OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date;
 bh=1MF4EqMmKiknkCxbkWjC3WSdMgGUyAMwUXpH/v5PLhs=;
 b=zyBEG8SXWaTD6uDFtez3am8/qTZYfs89vE7OXNeInj+gh6gZiz1zRSKc9PiI3mkCPM
 iKmnJv3wPWTAbg+fHkZqlAvo/k4WKPFxAzvxzPR5YtZz18HBHbgYWVeaNQjQ2u/UOwy/
 WDjROLAIZSa03owfk+j3xcac98zFEAhfimSy/FNWR63R+4TZ6ppRN4NvWgfT6aBzMf+X
 FLBRGrSE0a4xxylQTVaPqWLrAP+ynKXxZfVDxi/RmBWqv9mVPsA/eguKnklHrsiyngFk
 2rrC1lJmeKxMcn/R28ZyMTMLP433+YNvP4nptX9yDoAJt2NmkoJbLlHEHVw3QgzExlMg
 XanQ==
X-Gm-Message-State: ACrzQf3pPCQPFetiNgf86qz226A8Zu+zIiTCKUNd8lQQUjY1aAcD3Uzj
 xmJtIXqkIQUrXTd93CpfwJydHZ93eIxaXw==
X-Google-Smtp-Source: AMsMyM6r6Ml0b1UTbXqs9UY3GRGCQbw72xzvUd6ll61viiKh6J0PpVhoGzWJOg+mkXMFmIU7FSUtJw==
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id
 h12-20020a5d504c000000b00228db0ea4c9mr14181924wrt.272.1663677127257; 
 Tue, 20 Sep 2022 05:32:07 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i
 (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b003b340f00f10sm17629084wmq.31.2022.09.20.05.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Sep 2022 05:32:06 -0700 (PDT)
Date: Tue, 20 Sep 2022 14:32:03 +0200
From: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: initialize r variable into amdgpu_cs_submit
 function
Message-ID: <20220920123203.GA346517@tom-ThinkPad-T14s-Gen-2i>
References: <20220920122216.346321-1-tommaso.merciai@amarulasolutions.com>
 <3430255f-3675-eef2-92bd-4eb8be582c83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3430255f-3675-eef2-92bd-4eb8be582c83@amd.com>
X-Mailman-Approved-At: Tue, 20 Sep 2022 12:55:19 +0000
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, llvm@lists.linux.dev,
 Philip Yang <Philip.Yang@amd.com>, David Airlie <airlied@linux.ie>,
 linuxfancy@googlegroups.com, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Nathan Chancellor <nathan@kernel.org>,
 Luben Tuikov <luben.tuikov@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Tom Rix <trix@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-amarula@amarulasolutions.com,
 sudipm.mukherjee@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On Tue, Sep 20, 2022 at 02:23:58PM +0200, Christian König wrote:
> Am 20.09.22 um 14:22 schrieb Tommaso Merciai:
> > The builds of arm64 allmodconfig with clang failed to build
> > next-20220920 with the following result:
> > 
> > 1190:3: error: variable 'r' is uninitialized when used here [-Werror,-Wuninitialized]
> > note: initialize the variable 'r' to silence this warning
> > 
> > This fix compilation error
> 
> I've already send a patch to fix this to the mailing list 7 Minutes ago :)
> 
> Please review or ack that one.

Sorry, my bad. Don't see your patch :)

Cheers,
Tommaso

> 
> Thanks,
> Christian.
> 
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 58088c663125..efa3dc9b69fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1168,7 +1168,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
> >   	struct amdgpu_bo_list_entry *e;
> >   	struct amdgpu_job *job;
> >   	uint64_t seq;
> > -	int r;
> > +	int r = 0;
> >   	job = p->job;
> >   	p->job = NULL;
> 

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
