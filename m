Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D120561A09
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D120561A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6906E828;
	Fri, 22 Oct 2021 03:46:46 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3BD6E5A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 03:46:44 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 e59-20020a9d01c1000000b00552c91a99f7so2920421ote.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 20:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xvpetUbe0WIdSZSPFCdfDvX/v0a2Fyb4LcTFcu97Y4A=;
 b=p7V0OSnjbt8v94XMU6XhbISF2V+YgoF2+aGr8B1rQirr1IQrZPJtVoQSAoFDu6zlv9
 U0tXuV4FIFkdn/koOmDeoEdxW9u79sqED6TZLIx5jGfOXmYJ8BKOP3uNEfCBmUnab3VK
 wUuqiE/HpEYgvQa2OaPF7/Vu362FPz5n5oBBXhMNC84QBf79W0UE3/dC1AukHASMYwys
 MdccU+Vzgbjy6ajoQJR0EFKR3AyaJQa9P8OYTVENRlOTZWXyx38+2kzfJK9QDAa4ALhL
 yODww96WvRZJ/5zqo5lkzxUaYGaJYfAn7Zp31MIFmcY+3bP44nDtiIgGnoSFWM2CGE40
 smtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xvpetUbe0WIdSZSPFCdfDvX/v0a2Fyb4LcTFcu97Y4A=;
 b=WTDNKEk1YlHN3aLs39COjO3al669mdgucDZHJSt+scueZVV42qsWyq03/MVMwE/yAM
 ahFXplPa4HHMV4DU8HamYPGhQQ9gil2Rzd1yL+rYiwytfvMeEi8XyeiCnw2Bq1bmiKY7
 pzDzE7dpc4KEiNIUA1I99SZaqxIgKMmli0jbJU+W9dRuEXspOwYNHY43qQgHEToRfX/J
 cJ+UXXnxIUQWRzsnJjYi8XhFQ9NjBCLps92St6rKoSFLCwam5+pw/DR+qL5cLnooSiQ0
 YaxV2a3LHUY+Hb4g1cxEEU1QYKw/C5wIT24otNz0OTJtbni0jsYLIupW2xpRJnHd5ogF
 z3qQ==
X-Gm-Message-State: AOAM5314JK8Ah1Rvof4+rJCCEdAYqVAVAyFfExaRfXuL0oQw3nUckT4d
 6u1cKnQ0Dg3KFNAay70EVwVmavVjaCK/TNC3y00=
X-Google-Smtp-Source: ABdhPJy4QOpcvMJYNXl4ghE3ubXKd/VOMd8ONOkv4IARwfo//TCMMFIqaPboBASY4ngTEO+3jk+KlOSLvkKuhhYrgKg=
X-Received: by 2002:a05:6830:23ac:: with SMTP id
 m12mr8331355ots.357.1634874403960; 
 Thu, 21 Oct 2021 20:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <65fe9427-f649-596d-21dc-95c3f621b4eb@gabscap.de>
In-Reply-To: <65fe9427-f649-596d-21dc-95c3f621b4eb@gabscap.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Oct 2021 23:46:32 -0400
Message-ID: <CADnq5_O+ms8SheY4VtV_iHSRqwE=_2VyuOhHidDq=JDL1A+4uQ@mail.gmail.com>
Subject: Re: PROBLEM: Laptop kills USB-C hubs
To: Gabriel <git@gabscap.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 21, 2021 at 6:55 PM Gabriel <git@gabscap.de> wrote:
>
> [1.] One line summary of the problem:
>
> Laptop kills USB-C hubs.
>
>
> [2.] Full description of the problem/report:
>
> I own a ThinkPad T14s (AMD) and used a USB-C Hub [a] without any
> problems for half a year. Then, I bought a new ThinkPad E15 Gen3 (AMD)
> and used it with my USB-C hub, which worked fine at the beginning. After
> a few days, the USB-C hub stopped working. I thought nothing of it and
> ordered a new one [b].
> The new one worked fine for 1-2 days, until the HDMI ports stopped
> working while being connected to the new laptop. USB/Ethernet ports
> continued to work.
> I ordered the USB-C hub [b] again. Same story, except it died
> completely. All ports stopped working.
>
> I noticed a kernel warning [6.], which is the same for all three USB-C
> hub deaths. This only happened after the system woke up from susped mode.
>
> I dont't know if this is a hardware or kernel issue. Unfortunately I
> can't debug this any further, because I don't have any excess USB-C hubs
> to brick.

There was a recent regression in the driver related to USB-C DP
alt-mode not working after resume from suspend in some cases.  You can
find more details and the fix on this bug:
https://gitlab.freedesktop.org/drm/amd/-/issues/1735
I haven't heard of any damage to hardware however.

Alex
