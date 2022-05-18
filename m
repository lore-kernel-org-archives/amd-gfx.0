Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA08BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 14:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5488F10EEF3;
	Wed, 18 May 2022 14:02:40 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5196A10EEF3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 14:02:39 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-edf3b6b0f2so2744692fac.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/zapYjieHeAnPf28lfmDeX5BOOtBJSv7iaCvgnuPXSQ=;
 b=hOI+cUt9z4ij7GXleBdtMOGQ09NODmiGfGQbw3zW6rUihEZq7hEm4FgtWSzhrxO4QL
 aS7Qf47GVqEBwjdNDi4/9F+OPhnxxzlLkHKHgVEnlua2GOCQD9mt6+64mOYxMEhiCZve
 rEqGpPlGSd3+Z1zKiRVg2wP4qn2ZM8XUjzJgPb7RytSOm95jibKk9vCaldwrspcmysoK
 b//nCknoXS4AcB8rPr5stkwUUDlNOIuku6fftnv7DfJwgxPw09rOEfJebB1onrS1Y+4J
 JHZyhfc0CgVcq2CIvAktNeM2kwGwB/ZaG08xl3X2TmaHTqd2vpDQHLxkJBHOYKgh1qav
 0Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/zapYjieHeAnPf28lfmDeX5BOOtBJSv7iaCvgnuPXSQ=;
 b=cnrTpyZznDBubV9Y6JwOX3j3HT+BhReQ2kQutpimc2pX13ZYJFqucQ7OD/1SLlyPeY
 XynQDs1S1kuW6pDZnu5N/cxlbyI53pOwNWYfnmSQM8pMa3B0qRPM9IZG5+qFh6UTMrMk
 6nl0/nUAYaxHpQCnxAHNFsEj/ID25LhoxEm7fVU7it9SyEb+1kpElM+7yKnvgXjrPa/y
 4y80OED6GDS9aGBO4Bnn5IPcACZQA5WhnVdgl+xf636m6+8XmAGFQWHl/Cyuvi5P1QjJ
 bYhztqYBi93y1kjl7O581io5TUJm/eVdvi3LQxXjkSoxmMja4zdb2xDC7nuRe2B6zqkV
 5OGA==
X-Gm-Message-State: AOAM531beHtyAjdsPW6R83f0mykcua5snCJ6V8sTkeLniyIqcRnj2OI5
 gqWF9Q7aRdShgglspCcY0zZVg97okQ37XQXGPZk=
X-Google-Smtp-Source: ABdhPJzpfgAv2zCUsq16jjQObibUsHGF9PIka9hmauWXzubCHf6ZyvZ/HCbvBjYw6XIIosw32DLXAj7NIMFZrlFbKw8=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr79997oaa.200.1652882558511; Wed, 18 May
 2022 07:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220517221524.94146-1-JinhuiEric.Huang@amd.com>
In-Reply-To: <20220517221524.94146-1-JinhuiEric.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 May 2022 10:02:27 -0400
Message-ID: <CADnq5_Ne5gPA8UumS9nw-yqqLbaFqY-3Q_o166O3Laj2E9SoEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdkfd: port cwsr trap handler from dkms branch
To: Eric Huang <JinhuiEric.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 6:15 PM Eric Huang <JinhuiEric.Huang@amd.com> wrote:
>
> Most of changes are for debugger feature, and it is
> to simplify trap handler support for new asics in the
> future.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
