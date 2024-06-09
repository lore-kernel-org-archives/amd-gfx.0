Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C449C27C55
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jun 2024 20:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CC310E11E;
	Sun,  9 Jun 2024 20:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IDVGWN4g";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9D610E11E
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Jun 2024 20:47:38 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6ad7d08c045so4451616d6.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Jun 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717966057; x=1718570857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZPwyVXX6F+Syx9TFtvOV4xYL54mKUOOQam9Dpy50nI=;
 b=IDVGWN4gECsPqjdDKEpAMFAoo3Mw/Cu1I6PW45Tf8KXdNt9ViYSh0zenEHw/Bz1noH
 Se1TB9VclYUd8jn1sS5JTi/B8jNy/935mxFGfORyP3tu/DkhPI+J+jLItnwZwZrsmpDn
 8CRMX59705uIlhnAkp0ja3/bffPggapFFOyf3TkOxct8XJpSfQWbuCsJE6RHqq+tfSga
 AIPSyuOJYUhVFNZRb5dfvRhJfP15bmpHxRJjgAJryk4C4FCEVsDwN954eIX4sDfp89fK
 CkQ4uHvSrNwjHYYZdSdGrF3zRvBiH2F412urJN4HG8+UYg4zAR7Lxv9s6CVNV44bigAS
 yb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717966057; x=1718570857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZPwyVXX6F+Syx9TFtvOV4xYL54mKUOOQam9Dpy50nI=;
 b=qcVkcvXqGniPgFgoWxKmkmwKKeKGtSKmgS9W8u3JKWhR4vLyNt9SeV1yXLv49lQXGT
 CqEafpG5pZ47eGkDt/6Km0Ir7DCemhPLKEVbttCFVIstLKYHZs2qYC1NI+SgV95F55u3
 fcEp/x768dmqKk1Dm400N+UNIiWFwpiUMDuK/2oXORmcQh2XgpQEvnS1kdXhYwcuV2Qa
 BkL+p81Ykw4S4VgOGC/A/5WpWj+Uk0suLqYSUr9zGn2oW0oAu0JVfSJvdlWGQZVuZ9un
 VXJ98wMsJFBaN/X1uz6vqSjSDkGN38jW6Qxq/BfIs12ROQwPkdCZfGlIE/bAqxdnXf2J
 0Xeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSSXpDVcioMPcr6uHe2YBddeABHAhNA9XISYFHMg0VMH9nkO3t36CD1E5818uZ49dVWCb7a9poek8ck9Ry+P6wOfXN6i5yAmIN3sFlxA==
X-Gm-Message-State: AOJu0YzzGWF+70o+qcFMJeXUnWoDYC9OjgUEoJxYKqMxCiNNPNf17m1t
 OTz+TMSDkqw917YL6oIbsiwkSWqqk8cMBzUhyvHs12ATVeYiUc4IxWvfZiPzkiHn8EjS4eZ3lS9
 bLlnWCp+UnVhkenyXHoXtCLNu4zk=
X-Google-Smtp-Source: AGHT+IHsz/3g0QZS8VJvYn/UjZPiE0Rj8KOCfXA4O9U/MnypRs+hJxZsoJ7gLOMcn3hQd0DkQzgp+0SdU4ITeomMHqU=
X-Received: by 2002:a05:6214:2263:b0:6a0:a4eb:bcdc with SMTP id
 6a1803df08f44-6b059cfc759mr87471406d6.3.1717966057153; Sun, 09 Jun 2024
 13:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN6j9GMTx+f_pYShOpLKL5b6kmJ3w-FeYHHw9nUWYjyHg@mail.gmail.com>
 <f3c2fafc-dd31-40a4-8585-4a5dfd26e68b@amd.com>
 <CABXGCsPDwDKpYc+jKCqDCGoQQmSkgEFEHG98fA-9KmKHohsTQA@mail.gmail.com>
In-Reply-To: <CABXGCsPDwDKpYc+jKCqDCGoQQmSkgEFEHG98fA-9KmKHohsTQA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 10 Jun 2024 01:47:26 +0500
Message-ID: <CABXGCsNYr=yeN1xWFeEhouy8LNWXBEs-2htM6HD82roDHwxR2g@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - commit a68c7eaa7a8f cause *ERROR*
 Trying to clear memory with ring turned off in amdgpu_fill_buffer.
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 felix.kuehling@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Fri, May 17, 2024 at 8:59=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Thanks, Arun.
> With the patch this error did not appear anymore.
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> on 7900XTX har=
dware.
>

I see that this patch do the same but more correctly:
https://gitlab.freedesktop.org/mesa/mesa/uploads/034bc23b94c373e5e903e7ce00=
0aab28/v2-0001-drm-amdgpu-Fix-the-BO-release-clear-memory-warnin.patch

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
