Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C73C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 18:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5C82076E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 18:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNFkkhe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5C82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29AC46E513;
	Tue, 24 Mar 2020 18:49:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28306E512;
 Tue, 24 Mar 2020 18:49:40 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c81so4426002wmd.4;
 Tue, 24 Mar 2020 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Bn2txemVnNW3tHUFGp2WOb1jH3UpeSV6hCDyIGrExc=;
 b=RNFkkhe84ZEGayHB8baD92NZqRNYMXvMXE6mRhmjiQa6+aEXFVM7MbYvmyJIdKpcyL
 P0Kt/3R2vW84P4s/9DAgLdNeg35C5fOZkjEhyT13/ZCUR+gG626E0DClz8eIGUTN4nKh
 kPtmyz2MZ8OtHGbxKYWz0+VZ3mQ3xF5qLTcUcbUjDvhp3hca4DAJ/qNdW2MiOi5eR3i0
 RLCdb2fIDqmg5ainr8H58LNrwP4j2Jnrr8FDHiGROvKA7RIu/LOsoSvLChS7sTz6LFpj
 ywjdBuh7EW9/2VFW49Duuk5GS0Htz5fgT9QzmpTW7cYC62W0m/UhGfP0tDnBfRz2EzUV
 K6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Bn2txemVnNW3tHUFGp2WOb1jH3UpeSV6hCDyIGrExc=;
 b=qSQOkQ4bVIHR9pxJeX60tGZcBmrWB2g/Jj/CDGmtunhmmPfYaTiGdtESwmrnqjD7pK
 xcrqy59kLklvJi9ByZP4A7nKc/TsyO3C0hw892o3a3maN0BIsTQNP/SQA6ghtDjIhTsR
 8lFv2Qv9zD1zLu7dhMbKzppOBfOxH12BrEHGOe24uZJmr6QtDZkPgmk9uLD6H8EAANLk
 lHNyFZKBJP8kq2cDY4OSqBUxLnfM6P9zyWG/9X1aQivRLxRywPNtv+qSZec/tiU1M1ag
 1CVOFAdgcjpUAdE7jlJ2AsCV/VHImzkc/bJQDHPCaX7/S08CGGr2cfvYsW7cg01HHKzB
 o8xA==
X-Gm-Message-State: ANhLgQ2kMGRquWugJByp3okZpou/hdfyyy6RK+kTew9crjnmXHHIGyJb
 O/LBj5femAHvbz4o7kRZYTHZ3mMPzyMd1x6y1fU=
X-Google-Smtp-Source: ADFU+vty6Yk31S5LF9YuvRPGLvF8AD8PNX2XXzN0Pdgf/WbZp30NoFPvgvWxHl9AOuzF24qwOvjqBS8ND5KRrr4tzUk=
X-Received: by 2002:a7b:c386:: with SMTP id s6mr7501165wmj.104.1585075779201; 
 Tue, 24 Mar 2020 11:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
In-Reply-To: <20200324184633.GH162390@mtj.duckdns.org>
From: Kenny Ho <y2kenny@gmail.com>
Date: Tue, 24 Mar 2020 14:49:27 -0400
Message-ID: <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To: Tejun Heo <tj@kernel.org>
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
 jsparks@cray.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Greathouse,
 Joseph" <joseph.greathouse@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 cgroups@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Tejun,

Can you elaborate more on what are the missing pieces?

Regards,
Kenny

On Tue, Mar 24, 2020 at 2:46 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Mar 17, 2020 at 12:03:20PM -0400, Kenny Ho wrote:
> > What's your thoughts on this latest series?
>
> My overall impression is that the feedbacks aren't being incorporated throughly
> / sufficiently.
>
> Thanks.
>
> --
> tejun
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
