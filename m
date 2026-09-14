Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51055C88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F11210E0F4;
	Mon, 14 Sep 2026 12:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XYXe2rWd";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01C410E43E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 11:20:43 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca94bso8946515e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789384842; x=1789989642; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q7ZdNSjtN9ojPIBbMzg3azdsXUNRiHAmCEOATn6Atxc=;
 b=XYXe2rWdbueOErvdkbqzpRc0+MgbKCicCmwOblZUQaYxrO9PlIeJcubmJtHeqM+RkF
 OiCPSFAt5Avp2jOqInGE6LY1BnMdUWo7QJFK8/vReTuCDMqsyEXmBCWB0/Otdyc9/z+E
 IIPEdto9K0aRssFniY3OvL7OCGhMsu0pnnJfmpSnUUFsrmImWtVe45/jsdleZh9y1uj7
 5XpKIpwBPfQF+Bo5SZ9l0ThN94Qv0x53K9dWIiF2L8nL301I0fPBAXvcT/an7QqasCwn
 HFE9Z71ztOX3e8ghIFjTKUxOuFQUjqzfwgjS90gg2FbwTS4NFOf5NPLGvwWdQII+5RSe
 B1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789384842; x=1789989642;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q7ZdNSjtN9ojPIBbMzg3azdsXUNRiHAmCEOATn6Atxc=;
 b=JLKRzqXdbMjujcvmiEwK3wno9ZtZHo9GaleFtAb+4wNVfqVWYbgFPiGP41gbXzuHQT
 Db6V3Q1jm2XsVo+16e2xS2U2jsjyMaRzWkYTQo5pNCZl0pDG8++gOEBAOlBqUtNUzP1b
 cXox0hTsPORnt/YUr4epk8cy6Otr5vY4tn8Z6bjGY1nV9lQJoWRzrLZBk5pug3xoWec9
 SaNgvnR59h9jdn3vyhFiN73ISlQJeyP6JQWuu2PO9ciY/hp5KykJXOMooiw6JSKwO5oT
 9XY67LfeT8Ueu6jlrBDxPeKR/jwVAps5rEEotJpFirUAuJiLDvc+V8Ln9ZZb2477JA8W
 wqyw==
X-Gm-Message-State: AFuF++nc10VVI7SuT6Oz1UlycwDuy68Nr1oSwjK4yqHlTr0z2kc8moDx
 F3wlT/ss9aZOJtn7Vvk1vKNF+igzSGUzMFyFEwdXQ+8kBUBWlH0tf88p
X-Gm-Gg: AYBFou3VzyfBOPQv2rzkpwVNAOdCEomVMATXTpPQkYFW0T/3fAorAIWho5ep2OfzH+s
 aWcdM+S7boMaJLJtYt6lyeYmiX8b9JRBE/F6SmafzFJPrtEZdPzLwyNdSipDgoqkubdZaa/OAVp
 ctRXhG/KoSSj3WMt96U01wXmOnJGMFiqMMj7pPtcY5CVHHeppNSTMhaEO1BpCZQOZhklpGiG+VP
 HgsjuG2xuzzbMawjFBXjUTcnICJpt/uMDZ/FDJbBZUUdpB9o0t0SewT3YOispfnzn88l+xNvUNk
 nnFDSHnOlWbVi9UyoPhn+ON1N0ID3pgzRz1TF/mvYB9aM9xx+ELzw6zuHeRrFsm2IbYefcRZF5H
 3AVjwDIZxs+QB//07f3cyUZ3l4YPjIGFbubzLOrQKWZRFlsQzBCy3qKcWRy48aFxdaYVncBxMd7
 WtMbitN6LNk29J+76WR89YyKZLq1FMYBf86lSiqFA0EnhBrC9fd2IIA1e6iVSA2OOSbRI=
X-Received: by 2002:a05:600c:8012:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49e7a67c769mr23852755e9.31.1789384841405; 
 Mon, 14 Sep 2026 04:20:41 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm210420155e9.2.2026.09.14.04.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 04:20:40 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:20:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: Re: [bug report] drm/amd/display: Add new sources for DCN6
Message-ID: <aqfYhEAF8EB2SNO0@stanley.mountain>
References: <aqfT_w8H_hN1ywfY@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqfT_w8H_hN1ywfY@stanley.mountain>
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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

On Mon, Sep 14, 2026 at 02:01:19PM +0300, Dan Carpenter wrote:
> Hello Aurabindo Pillai,
> 
> Commit 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
> from Jul 22, 2026 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn50/dcn50_hwseq.c:641 dcn50_init_hw()
> 	error: we previously assumed 'dc->clk_mgr' could be null (see line 541)
> 

There also:

    drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn60/dcn60_hwseq.c:650 dcn60_init_hw()
    error: we previously assumed 'dc->clk_mgr->funcs' could be null (see line 556)

regards,
dan carpenter
