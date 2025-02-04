Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B28C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 16:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D3910E354;
	Tue,  4 Feb 2025 16:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MYLlrmvx";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F03210E354
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 16:16:29 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9c31175baso186249a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738685789; x=1739290589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRreOSsx7EsB1qCDYRv+endB33ADmjHkzdchyo/O9GM=;
 b=MYLlrmvxuKc64IiE7HH760jA7L0ar935V9uzxcWlg+G72lx9khiNA43OWj6rwiZrtk
 9aF75LvSQHmM7QrJKcLOjZ7rBty2C01zCYZCCHMwoydK76n57oCnA7p2MfNh6qO+Auk9
 /iPDWz1vNHtByHIY6XcxInezI6m3lmsS7zHTDE0N5wnVKigLEl+uJ2E/4Lzsl+HuwCFA
 hnXqBITWJCOEW2VSrB5YU6AHpIpVOo9naQCf5nmF7s8muyOwFA7aH7a8AjrDEddGzbzd
 lA1eTL9V0bHC8hKFPigHZOBoMjUKePEEO6YHnCHqaPdvTEXc6N4VYrsH3mPHGQHOwABv
 FX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685789; x=1739290589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRreOSsx7EsB1qCDYRv+endB33ADmjHkzdchyo/O9GM=;
 b=kJY++TPf4JeC9H5Dux8NOWkG3XQCWwUDacKioy8ZZYS3g+P9RBPtPeiu1vg8I8t1wk
 9sTfbWPQ0fc5PChpt68MHm/DGYiUk83gMHD46uL2A2UqPGVcKw2uASewRsMhak/xbIYG
 363hQH54sr6rTXbnp/vPfaQjUclvmvwGA4KejpOZQGE3bOuQGSzvq8oIKU6SCjmCXhNw
 TDxQgE17oV2RZmOnixXWmIhvP+bwFlO5ebGM/+TEYkIwF3SffF7iFHOwC/sFlf1YK9eX
 TK2MvAtQE7galCfrLnWZ/oaoOr/HW/WMRgKGF8XAQIXAHkT39zGLPDv2FEChcnr+q9yV
 wCvA==
X-Gm-Message-State: AOJu0YwhRHflzvKD2rdzQJw3SdYJNxxo9gZaFouyaX0LggCaq/kR3N8P
 Vm49d/F4uv59U6gkR4jmozJPlQwxDVIbNv0L2FnqXwQpIkl2VTlLif1S6oJhgS2LPR97QK69p1J
 M4SXm8PVOEaaziP1PEYrwg3JDckYJ5iVr
X-Gm-Gg: ASbGncsS0o4aoPz8YmwFUXM0tlX2E8IuzR5Pt9TFc98gvFewuPSeglLYpQ01rq8OIN5
 Osd3hAesbSEOa4H3NU42Yb1aVyC19qQzJjdq2ukqfxs7hGsNaEVDjLhu76kt9kIMo1jlcBbxM
X-Google-Smtp-Source: AGHT+IFBO7doIqA7FVj6AYtWe0cM6ahwuiKgEJUo0iVtZPWphFXO78Vy6AazZozNyQkNyL0FtrdJE8qNVP0N52ek5cE=
X-Received: by 2002:a17:90b:2e06:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2f9b8c21be2mr2552692a91.1.1738685787408; Tue, 04 Feb 2025
 08:16:27 -0800 (PST)
MIME-Version: 1.0
References: <6e7ac88f-7db1-44bf-aaad-191555ebd016@riseup.net>
In-Reply-To: <6e7ac88f-7db1-44bf-aaad-191555ebd016@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 11:16:15 -0500
X-Gm-Features: AWEUYZlLojHRQoNHg-Advyw2lVlzTmgcTpEzr8FMquh7ZKlm5ciimx2sfxmuuvQ
Message-ID: <CADnq5_O1Ut0mf-TtThRTccv74_W0N8=KzFfqanQhpEcb_Eodiw@mail.gmail.com>
Subject: Re: Graphical lockups on 7900XTX while using 6.13.1 or 6.13
To: Sean Behan <codebam@riseup.net>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 4, 2025 at 4:17=E2=80=AFAM Sean Behan <codebam@riseup.net> wrot=
e:
>
> Hi,
>
> I get a graphical lockup while playing, opening, or closing games on
> both 6.13 and 6.13.1. The issue is not present if I switch to 6.12.12.
>
> A dmesg of the crash is attached.

The GPU is hanging.  Can you file a bug report:
https://gitlab.freedesktop.org/drm/amd/-/issues
And if possible can you bisect between 6.12 and 6.13 to identify what
change caused the problem?

Alex
