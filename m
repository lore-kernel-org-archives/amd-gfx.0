Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8338E7FDF3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 22:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B10610E2E4;
	Mon,  2 Feb 2026 22:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L92SWLH8";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BCA10E2E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 22:11:13 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1233e05c77bso253134c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 14:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770070273; cv=none;
 d=google.com; s=arc-20240605;
 b=XRcOHZEzvLmecPdsmas7wdNNEUIWtZILW5LdmqOmoGz7aAoR3h4Mcs7VJwsQ9RbIiJ
 Rj3tBr2PZMgd0ahymapL3uxPdeGy6XHOpbI3c39j+Ivzfa6+1we05gUtwEX3h0Gv02H3
 JEWjqZE85lR7txVfdzjA2pb3Kol80e5S/q0ZvtbDaXwFFR8GxiLaFCgD60wLloAAOVoN
 M9zdXUh4v0tQIlXSOrVgBWZ7HC4JJubZ3Q+ZxwXD1oOR1kRu2Px1FmYpXpUsbTQabRjs
 N5VOCMAYjPKyqvh6JIEWX6fOkYssIS3lNSIq8IQWPZQ4YZgn4cLramGsYxgPPQUprx3O
 KNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bJzItTAf4Rzc2pFrfdZD+A0aas/BNfJt38FMaAtf+4U=;
 fh=ipwj50nJMuLWMJJFr715GRRrwpSygMfZYbsEOO3XQtM=;
 b=Db9V97D6kDz8KA1LZpbgrHbGdrQcYoBzMOStRCR9TogB2n75gKJbv36h2xp6e4xUgg
 t+Uj6Lt8v+GAPqGYNEF7M8Nv0WAB4wlk9tU/lDt/TI5im5Oq3cE35BeTjBpEzqntlxl0
 d456CYxYMzWD4uHNpnZ5mQGNb5Fit1ijRZskZEvkACpb9ytd3VqlbK1Au2PVlhKQIiTO
 L1vybxapQMDkcd2Qa9F0THDTyw3jkI+DBdh5d94Fgee1HnbL2RMWn4xUezh7AfEKoPvc
 eB9FoPcSYu8ntORmf0s5q5StOTkuEoLx3AwEMhIHI0QDd/tplwUI7650wMQldVg2XNa0
 NiBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770070273; x=1770675073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJzItTAf4Rzc2pFrfdZD+A0aas/BNfJt38FMaAtf+4U=;
 b=L92SWLH80TWcCjUtnrm8vk+j7iLCvled2dif4tIV5lwcoWpvaY4lHraswR95x3qZ7t
 xzl0rwjRPZv2FiEvvP3lu0bTftWexoe7XT1zfQUp1YMLf5+JlDW+hrzeBW72fsHhE3gq
 qwKphXz+SFrg5ZL/X9AxyLBZRwdBzoER5ltJaVCx1Pzg6y4v4InreyD+xSf/22VGv02L
 fSYcc5hQp1gFTT/YpGkXN4hDDdBSzsVY97kHFY721n6z9U9lPaDGzcmMTW6G84VVKJz1
 O48vt5cxKc8SIuJiyzRmiWd30UBc0OZF12qkcA4cyr9fEC6DwN/i57Iwia2b5KR3cTAy
 yW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070273; x=1770675073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bJzItTAf4Rzc2pFrfdZD+A0aas/BNfJt38FMaAtf+4U=;
 b=Ig8RKqxkhalJ+9dCbvPXukrZkmERzGKWf5drq7ZKwcCVXxP2wSlwAGi5VgGfpmFdTG
 65XeAUiiVAlMT1niyLm00ozXAxaQbotAMR08851Pq0AFEe4OKj/1LXtfWt/w4NtgoGfr
 9sUN9T2pcmMIkpSlcBvbTok4GB0aJUf7VArvJVYz4kbOmFiagdWdDayHwnrlILtROWuG
 vZEz+ifMPA3xQJU/1s6eXbgqP7qX1D4ODUSJhlE+ldTk3iEkdCmEyL2Cy7j5X8QK55xn
 el99HbcVtIIYkGWWwvvsyjD4zHGoF8g8TZqjGITcGFqVN8arl9/sPXYPoa+/cw3oNcic
 tcOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXUsMs62CxreSo6HLkjLohkmpuTe17vMWW98ms1ReNXzWaAVoiULI/L3TdT46zk3xG1K+1mUjW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi08cZldu/KJa56QLb9ElRZT5HjxWGLR0JT3+x/5I1+lJKd8Pa
 EGr6lTLrsawdDGRs0WNRO80mR5HFiEDZA0HrstIH7DWhHK53YIOHXqq7jrmrqplSIm4gQpuwMXc
 UqMfY8ArpQ0WtvModFVgB32DylFM1zlo=
X-Gm-Gg: AZuq6aIFhskTgkx0YWm+jOrbUn43MKAal7OSupr7OnjOXUuct+XeoujvHtrDoy6fFSB
 gXWMI+61GaD960bNOzRECDNYNXFTZWMeQ66D/1aVbCyyNr/71WRUXCpVkLOCJH4Spt/47KNYfn8
 1b9LgGLjU04rdPSE95ijBgv8eetTmqBm+knc0NXrL4zIqrwYDKnBidZdCcgkSmuabAbCfoeLVIi
 OD5qY2t6Ge2TthHpsROVCf09XT72ALvZet5gs7KaA/BI9KEYs9iZdEkuwnSTMVmyyD3inpd
X-Received: by 2002:a05:7022:911:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-125c0ff4b25mr3248156c88.6.1770070272797; Mon, 02 Feb 2026
 14:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-3-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 17:11:01 -0500
X-Gm-Features: AZwV_QgGENiV4HEbqyS75Dx6gANiLEcwGtZuS-2yb-DHmdwXzEeCWpD0V63gCaA
Message-ID: <CADnq5_PdW0SP_87WZmjirsk=bF1QGgwvh4=r8m=eEzQ_tESLBA@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/amdgpu: fix amdgpu_userq_evict
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com, 
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Feb 2, 2026 at 8:02=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Canceling the delayed synchonized can deadlock!

Please clarify why it can deadlock.  E.g.,
Canceling the delayed work synchonized can deadlock because we already
hold the userq_mutex from the caller.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 8feeaeea1c36..af3922e9caea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1337,13 +1337,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr=
,
>         /* Signal current eviction fence */
>         amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>
> -       if (evf_mgr->fd_closing) {
> -               cancel_delayed_work_sync(&uq_mgr->resume_work);
> -               return;
> -       }
> -
> -       /* Schedule a resume work */
> -       schedule_delayed_work(&uq_mgr->resume_work, 0);
> +       if (!evf_mgr->fd_closing)
> +               schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }
>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
> --
> 2.43.0
>
