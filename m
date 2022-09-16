Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B31AECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 19:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D444710E0EA;
	Fri, 16 Sep 2022 19:22:55 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E408210ED9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 19:22:51 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1225219ee46so53515437fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=n0uRRJ6xDsLC5Ky3e0jGyyzJUpbO4vOl+/pSbvhA++Y=;
 b=JSBLrT3/csfiUPZ6g+ZlLC8hRRMmzt/hOYHrmzsXSNSeNPGhNbdC0Yma6zKQMavyGU
 Ms0g5F2aY/OF2BOiY8Mdp2Utpd1v9eeiuVW+ZCzfo9wWo+kwC/B3U8TT9VtSmWGcoBOP
 3melqYEV/sax5WluZPl4McWocTxJFcnKBpzSZzveSag3vLfAMAT5eb0tTawqzEaFFTC2
 iNAINiZN+gaRfcs4Q2isZ+bTD2XgSAKSBt7rWihy+6Sqq7bPli4bMjNQFtRcrdjpn8G7
 UCxkNivKvPglNvx/+zQXv65r9HY8BhC1Xxrdb/mcrhhUhtaEKraeSShvdeWKur8eCFEN
 Osfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=n0uRRJ6xDsLC5Ky3e0jGyyzJUpbO4vOl+/pSbvhA++Y=;
 b=Tgl++KbFR+/DTgbxn/0oRLrfWDBb29CSXmI3m3SFlHc2tdFAnqF7SgD1pJ58H8Nlia
 MsQV9FNqgWZb71+T4Dcpl94+oOwKFtOW/JwbflrjqDNIViM5Xj0P4KNRtnYBJdWQaT3I
 sENoSN/DDQkW2TmqzmlM7/tNnassp+WDrBmMWnEHY2rpXbSl3+OMgdz1pJek5vQ1QhYl
 L4WnbEZlcw4A4hbPmBrk/qFaCryTYyBZqX3vGZQVJ07VlkdTnW+Uinvhs1RTW/AXL8pO
 XV6LE2YAIYGKItDnfIK4BpUckLAU8kCj2FLWSoZRPsx5o4sYyre1s/3Si71Q9lhrF1ks
 QKbA==
X-Gm-Message-State: ACgBeo0nPqSqd791nAcZGa9l9MwkmvPz+5vfDenpCWiD+YQBsuOVIJ+e
 CdO8Bvf3/GTZ+P64DYHMwywl4ca+4ZUr+OWUhQ8=
X-Google-Smtp-Source: AA6agR7roJib3yFCbVzgy8z8IiLuU6r598DdF293i8GxkjszkCOppQiNjcw7I2DtwRONPOQoCe7/YZ5n+hVZ9pZFy7U=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr9984532oae.46.1663356171239; Fri, 16 Sep
 2022 12:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090845.3336-1-christian.koenig@amd.com>
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Sep 2022 15:22:40 -0400
Message-ID: <CADnq5_Mz2gYDH+Gie=F1PXVxnevCBtkvmbDvP181-GLzEibOCA@mail.gmail.com>
Subject: Re: Final gang submit patches
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com,
 amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 16, 2022 at 5:08 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hey guys,
>
> so thanks to Ruijing I was finally able to hammer out all the known VCN
> regressions from this patch set.
>
> Alex can you review those? AFAIK you are pretty much the only other
> person deep enough in the CS IOCTL for that.

These look good to me.  Just a couple of comments on some of the
patches.  We probably also want to patch to bump the driver version so
userspace knows when this is available.  With those addressed, the
series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Going to takle the userptr issue Bas stumbled over next.
>
> Thanks,
> Christian.
>
>
