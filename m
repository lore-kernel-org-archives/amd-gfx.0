Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55528C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29212206A2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 12:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ75jlgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29212206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF01890F9;
	Tue, 14 Apr 2020 12:47:14 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A80E890F9;
 Tue, 14 Apr 2020 12:47:14 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z6so13821506wml.2;
 Tue, 14 Apr 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PRyhuD/q/qOwlm0kCGXzYUfBwRXX/YNDPiZm8kxyWfw=;
 b=eZ75jlgV8S/ZzIaX7d0n1GVxx+e+nNLM0JeqIjKIZL5R2fXELL1gLdVc1A3L+2/Ymk
 WhbIpajbhckGLvguf9NIaCUzUBncvsNIXltfNiXd3Ef92Bq+2BvGDzIw4apEYExuCyvr
 tuPpAk1sZehGNF9Au+LL0+d3FJHVDBAKvMcXizZnjJRTCKpxbByjs2PFw48Mwvf9RfE+
 dN4m865SUI20bTA/onU+ZeDVQjWvQ/d7AX9ZQbukAkSuKxVdf3+CNP61K82+/vm/zMM8
 5BQzHCVquADazudWyZozQ5Hg8yTweCsWYsmgLtrL4umj5RV73+3ND4P6uTEYnAHLu8ON
 jdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PRyhuD/q/qOwlm0kCGXzYUfBwRXX/YNDPiZm8kxyWfw=;
 b=Q1Zqfisqs0Tyll3h4c0Z5K2J+DfJkQVupMQ3yVqKY187wY6SEnsGCx+pNeRp/Zo9yY
 MqjgGjGewk9+Y6H0AYFNY2kLjt8ze3hNm6USkgM6lSa+crteXsiBOUum4l04iRwB3MuX
 hbJ1zGAvu4jQDZrCkHdMu2AfkegYdwaPgI3BChOEqTuOlDqnBJDXqfj+K31KK0Y1bLhR
 3LBlk3ueaniDQY/zh60Ck+kzsnLThR2aYIRCa1xWq8zgyAyJcu+d0AxgdYD5HRT/Z20G
 Drej5tp/bi1ips5uOmTEF/7gZd6exZA3/ufRZ3jrkPrwVWM/0go7GomqoFVKsdkC/AX8
 qICg==
X-Gm-Message-State: AGi0PuaQL3ee2XYMyaI0BeMqcBLZKJGcd1h3pGvTFbbFhRtgj6YnxZ5C
 4oqOLCaq5mPj7OjTwOrvTSkfn1ca30OF7CqGBWg=
X-Google-Smtp-Source: APiQypLuNpCYZZTsMPtx87wYh1wg4P8bZcbB42r/ns9R/dVzYhHCFhPBA8qsVSDfNoiLwGFYJ61nieSa+Sgja1Sn1Y0=
X-Received: by 2002:a1c:bd08:: with SMTP id n8mr23047307wmf.23.1586868432709; 
 Tue, 14 Apr 2020 05:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
 <20200414122015.GR3456981@phenom.ffwll.local>
In-Reply-To: <20200414122015.GR3456981@phenom.ffwll.local>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 14 Apr 2020 08:47:01 -0400
Message-ID: <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To: Daniel Vetter <daniel@ffwll.ch>
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
Cc: Kenny Ho <Kenny.Ho@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 jsparks@cray.com, dri-devel <dri-devel@lists.freedesktop.org>,
 lkaplan@cray.com, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Greathouse,
 Joseph" <joseph.greathouse@amd.com>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Daniel,

On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> My understanding from talking with a few other folks is that
> the cpumask-style CU-weight thing is not something any other gpu can
> reasonably support (and we have about 6+ of those in-tree)

How does Intel plan to support the SubDevice API as described in your
own spec here:
https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support

Regards,
Kenny
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
