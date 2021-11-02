Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B65C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144CB6023E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 144CB6023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E67E6FFE4;
	Tue,  2 Nov 2021 13:43:21 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50586FFE3
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 13:43:19 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id y11so1738160oih.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WyUxnFqhjJt3erQAh+xN+A062EJvXFiDtDR0CI7fZg4=;
 b=cnF1HkCHd3kSgBDJfON7F2kqzUEPht0tc7b1tzFSgu0rMoLv4c+UJ6Z+ucQz/Dw3qA
 6TxYAybD1byMsTqIzwVCEV4p6RwTy7Rf+5icWH7mE5S6BN10fo2wB4TQpOjkmNHia687
 iZjRwMNIaSNHL4Jv+MT7AUuxryX8NbHh2mCeS5RrK1+OdD6AR22us28oYpsGRu/rhP+Q
 Gp3BNus6USLXwE34tDj0YJCYdWXYqaf2wgRYkKKvgcxVZVpDij4Ze2crg1wrjZysv4KN
 gkNkmV1XR3Fogk2gHqpxRd3eVMzlkBqXVvnQlUsvxgvwI/tEhLXUY4FhKWit00S3l/Jq
 wTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WyUxnFqhjJt3erQAh+xN+A062EJvXFiDtDR0CI7fZg4=;
 b=FqvwezxbYWX5EFW/xVN47j70vyyGWkn18uQMWqcJRk70X68e8y8tvQo79T1mjA2xPB
 5rueZYL6cnC1PDZcesaVkaXy0yHdKhf05V+FKGMCF2HYPjY9amyJlDqc0A3ItP7KHagi
 5S4+D2DjC+Kbo27RlSXV284fM1cQF7RByZt3VhWSQA9sGj0/0qeLfCWiGMy5bHgaDpbE
 pFrqnp4PIitkSeyBMyMnwezmvymuSKGvYbZYGFkGuC/rmKHAh3geqkyurDboUdct1Rq0
 KSqkv+2v64jP7dlWMVWFpIhBB73N/jJgGRUJCLmVoJebgimm9f+Gs5eYWm1kMTQXdXQd
 ZsJA==
X-Gm-Message-State: AOAM530AeIGn4prr/EGl85H6mOwJVBwp9a2jLwQLn6Y0v41PfNcmZwK+
 e97/r2E6YgEg5qdVbtdfJWvrOn6Pqu93h3l5qzA=
X-Google-Smtp-Source: ABdhPJx5ACtmTn2OE2Cyc6AH8rZRR8HzWa0hI/bi9Eb257kD0Ba187G9WtW08/SFGHS0po1zCHsYVTTjh6XL2VFgXHI=
X-Received: by 2002:aca:e08a:: with SMTP id x132mr5053934oig.120.1635860599042; 
 Tue, 02 Nov 2021 06:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <446fda20-a635-3b00-4886-661fff4ab0f2@gmail.com>
In-Reply-To: <446fda20-a635-3b00-4886-661fff4ab0f2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Nov 2021 09:43:08 -0400
Message-ID: <CADnq5_Nr_c7J-WrZfsOEAHQwerM7vgU=dC0JrO+B7wTh40Z_Wg@mail.gmail.com>
Subject: Re: amdgpu support for Ryzen 5XXXG, with integrated graphics: is it?
To: PGNet Dev <pgnet.dev@gmail.com>
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

On Tue, Nov 2, 2021 at 9:24 AM PGNet Dev <pgnet.dev@gmail.com> wrote:
>
> i'm running an AMD Ryzen 5600G -- with integrated graphics -- on linux (Fedora34) kernel 5.14.14.
>
> its color output is wrong.
>
> i've reported it to AMD support; their response is that it's ONLY supported on "RHEL & Ubuntu"; they suggest I switch to Ubuntu :-/
>
> i've reported it here, on list; so far no response -- either from *@amd.com, or in general.
>
> before wasting more of anyone else's bandwidth on this --
> -- *ARE* the Ryzen 5XXX-G intended to be supported, and known to be functional for general linux/amdgpu usage?
>

Yes, your device is supported.  If the issue is related to the whether
or not you can override the ycbcr vs rgb setting for your monitor,
you've found the relevant threads about that.  To upstream a solution,
we need to get consensus across drivers on how to handle that and that
has been a challenge.  I believe there are some experimental patches
on one of the tickets you posted if you want to try them out.

Alex
