Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB0BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 05:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DAC61103
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 05:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DAC61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CB06EB23;
	Fri, 16 Apr 2021 05:35:26 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B7A6EB23;
 Fri, 16 Apr 2021 05:35:26 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id l131so21684378oih.0;
 Thu, 15 Apr 2021 22:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SFCuQjzeWEqVOnSxH9l3seK+DWkURq4UwkFrvexD2eU=;
 b=d0yTUxmTcD6nOU09FHnlzTo0lx2mwWzMVSDLY7FdcLjHeVJeVLjeilmVNNQ4CSC/gh
 IhmShyVpFwEkb9hwfZVsXO0m2pbhuetrECeMDuRev7x0LLI2satvKrdejFVsmSttz8cO
 oxxjcQ8yK62sSn2/mMDFyyFkm/OXJ3r0QDr8VbDowa9jo+XZzn1QF7cf/GB0qU4esOsP
 EYTV3EC9dhbV2KS33vH86rsn3jkQNG0sytqkXlFoTPb8zNX3wCrRAF2oz/YdjIx6Unjd
 9dYYB0VszdZtUdpViQaMQfDmz00euvrj3EZxr2Xl/tTsda+uRd+y6tZv1kQPUbeREXed
 giRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SFCuQjzeWEqVOnSxH9l3seK+DWkURq4UwkFrvexD2eU=;
 b=XuxM03ExlkuokL6dfbpbI6iaJHuX0PWWqwZInPYGDn0mk/WJJ0Kzwd8Og24Ohz2V4Z
 9gNjkYvosDTnzeZ7f66RXJC0inLlo1m9P1HpNqfQOytFHSmeJQ3UwO1HfE5r1NgoHdRg
 I1/eerpH2dTjuHGuCZPY4loCMUKpjytmSgi7Ob7Lg1MSZ25YZnO7t1eooiXtCVtLijgo
 XUefhtuvFXKIl+EHZGXqwE/gheoA7egW25Noqi62gfZSSMgIXAN1LuH5wwfk2u1kKADp
 SPOyq5MAN8w77YeQOJImQ3NuwWeLdYeiEQYj4qrXV5GRDD3fsNgj/MSD22L9nvuGsbLX
 6QKQ==
X-Gm-Message-State: AOAM533Zv+Sub+VoJoB1tP4pSHqzBxO/89b/inFK6Ufjo+MyhIwSgZRp
 e6otngDcju1cVd2wKXYj3Pn0zdKU5guHWtYHeP0=
X-Google-Smtp-Source: ABdhPJypqEgjQFMCGz9v5f2MQTPTCxXxge7bZue6TFEQc+HYzUoahf5lCYEmOL2SVqpvYBWuuf78thQEnheNwoAxOXo=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr4986993oif.5.1618551325311; 
 Thu, 15 Apr 2021 22:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210415212508.7ef57d73@Zen-II-x12.niklas.com>
 <20210415221626.3a33787f@Zen-II-x12.niklas.com>
In-Reply-To: <20210415221626.3a33787f@Zen-II-x12.niklas.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Apr 2021 01:35:14 -0400
Message-ID: <CADnq5_MqWX9wGN7p+8RYqQ7dxV84sQjdgv9nWFrDgbVLh46oDw@mail.gmail.com>
Subject: Re: [Regression] amdgpu driver broken on AMD HD7770 GHz edition.
To: David Niklas <Hgntkwis@vfemail.net>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 16, 2021 at 12:48 AM David Niklas <Hgntkwis@vfemail.net> wrote:
>
> Hey,
>
> I forgot to give you a bug tracker in case you want one.
> Here: https://bugzilla.kernel.org/show_bug.cgi?id=212691

I've followed up on the bug report.  Please take a look there.

Alex

>
> Thanks,
> David
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
