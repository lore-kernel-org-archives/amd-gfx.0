Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CCDC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADAF61269
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 16:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7ADAF61269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80026EBA0;
	Thu, 30 Sep 2021 16:06:58 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6576EBA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 16:06:58 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id n64so7922435oih.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=65o01AZFpaCixEms3PMjtQ3+WQ43nxcvuP2TsPb8uzA=;
 b=PL9iTKZ0ZS3g+EypzXRlPmiqA2FsbtrNAKyuk6Z/D7q5JC5KeaELRCrbP2HIV8ggL8
 m7GGXQVHY5S5lu1olLAAlrnv6A/vz33O1kLplmOD1G3O1nv7W9JUMc0cTNi61N8WoGfe
 Aj/KtkpSus3kAjq0rgwGwpyU9CcEoRq4wcy7Et65Vmcdw8r2MupbH3LjgHpL6t2irDak
 xYT+GWUCYRSPlEChA8+Sqb0hAOnXT2U3JboXGoRsq720HyVlAzdWngJOXv2RxNPbbeqS
 4thje/mm5+kynTrOtO/c2bFnoVtxXDM0SrIuaTJU8S1w9X34JZ0wxiufn9VzM7kuoWn2
 5z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=65o01AZFpaCixEms3PMjtQ3+WQ43nxcvuP2TsPb8uzA=;
 b=V34V0MXzWAvziETh248VyyZ2/5NVB0GpSyGihi5bZo8tkS/eJz0XOZm98b10CuATWf
 FxOSNZTgGWoKcmMmL7If9SSiCAuw9+4XCcNpqCJwfKbQtdqkEGlRcbjZDc2gUI4KbmVA
 P4DpR+6UvNM3LIbmJxzTTPKv1JCqDwt850Z2rp/irbAzT6HSYu1BfX+nufq3ExHsZqG/
 Df/YUa59c5lvCAzY66vsRzBvYZMpo1tR/Ot8qLHUlb10TD52vMdsH9cD7AkHUlPPoMwB
 nYiPSVsOW89Xf27H1HR/DK7kIc2Jjs1c+nQ6Kq9YHrQEdsGy0Bf1F5Nu6ad5dYv/fGfV
 AYdQ==
X-Gm-Message-State: AOAM5326+yUSAUtdGc5lLHpu07IvBRETQKWCfhiegBkU5mEdD9NgLXpW
 ozTdnXUdarA7KC5ivtYMNYYiWUE6KGV0RLDL5vWWdNXF
X-Google-Smtp-Source: ABdhPJwuWjDuv5neJyuqyDiYBVVSk0GWFndEFOW5+o1iOacJxf0+Yb2bEuE6LAZ3ziMbz4lLLFutN0tmY1az0FMo2j0=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr37975oie.120.1633018017467;
 Thu, 30 Sep 2021 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
In-Reply-To: <CAAxE2A6a45Vebk4FhH__FG66zDn0m6GbJgK3Bz3o8obePW5P_w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Sep 2021 12:06:46 -0400
Message-ID: <CADnq5_Ps0j20jOkEuU3xJi=v6Qbvp66dFdZOdYrCSn6Q6uknSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix DCC settings for DCN3
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Sep 30, 2021 at 11:50 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> w=
rote:
>
> Hi,
>
> Just discovered this typo. Please review.
>
> Thanks,
> Marek
