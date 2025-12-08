Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D7FD3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 23:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9889510E0FC;
	Mon,  8 Dec 2025 23:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QunoMr8U";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADF010E0FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 23:35:17 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-45085a4ab72so2658315b6e.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765236916; x=1765841716; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LWvNH0uiWnBHLo+W4IdN8RCcKFUTX9a5JQWgMUb+P68=;
 b=QunoMr8UOrP/hwXg+Rf2Xx6vDouK+iwmrU+biV4SObJVpYsVJecMtkeLjezyv+b+uv
 aZgUJXerR9sSZc4RaRuuQmO73cQxJvBLYGFpTu/KDuIsCPXyfuF7QekyolYuVVC+AXcd
 hftBFXAsY7SEh2qS7T2R0+Ccn2HNG7eoQNOuNIri2xbZfPtSIb0mzH+wdihZ4TWh/ruM
 Lr2Y6ZPpYyh/ToyWLH0JBEX8m++VfRngaP0RMyJfFoL4Xq1yVVYZmu18p+Ah3H0XhDVf
 t5UiYO6CJu60lJ7OIKO1BmKHZAFjoJk/LA+ZyjWSPGZixtNB4JCPjFIT0hvh6akAY+2/
 br8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765236916; x=1765841716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWvNH0uiWnBHLo+W4IdN8RCcKFUTX9a5JQWgMUb+P68=;
 b=bR64y+C0nTYEqtewQdK0xzslFpTdkZGiKm+XRUNJ11wvXNAbh54SigLrfUL+RqIn5N
 VwcfzDY+z/frhahviUGIRs1vrvezgFedwz6vTU1axadjn8q568/96ZmrjpepR9FMz/qd
 AEmG/4W9puNuI0iu3uOZnIbMulfKX2wQ9FhlxEQEc6dO24EHktHFWfQtdhTr70BERZEo
 6nsmz+0q/ykB1zKnFo5JbHgU4V5asZ0zul96SCTKs0MwvpGnjbJWg3fpaIBnQFC0lLmP
 DjFwZtGI5ZkQMBdlVhz1Rh7P8blA0Jq8temuMUX7yXmci3y4/dtNmB0P+Afm0Z51wTmL
 WqXg==
X-Gm-Message-State: AOJu0Yw7vJ07OVTaNaWEmOf/nP3c8s09tHL0yE+QFD3Nqne0ncLA/ki4
 m25vDIvMz6n/gDI/mST5DYhLaWPeuR216HyM6OAaPGL02ChWLL6DIKmgvv1kP2qiy1BG5wW+X/T
 tv2+5pNHFRj7M91YoMgfVfqnHzkg3cGU=
X-Gm-Gg: ASbGncucwfj7oUb8/+Zv/zuC4zCQMBJ+iVUC8M6WZXQBKDi1gmeHX/XAU9yWdP2HXOx
 8BgWzzhM4kfqMHN2Pt8yFnH2pkpzafMJkwUhUQbH2Rxj7BG4me0oK3NBzv6gV8tDessMq5w0att
 l7Ug3atYgIwkicH/u2jtAOI5/jGtV8wTySimmGncBD6ZgjgpoT2WpClz9hsI/9ObFdsIm1SIvHu
 3vy2/c68RcZZkqfSYMvLXixJl9I6hlhX+e/x6u5knH7IXrnNUPTjXy8MydYQbxz+BupGolXrQ==
X-Google-Smtp-Source: AGHT+IH06aj63pU78GqN2zr+B7cM0h0wJsiRNCZmfFQGkA6HO4jARrUPfGrppPai4nJt8nJGUBEG/g2sBqZtl8RpgNE=
X-Received: by 2002:a05:6808:1902:b0:44d:a3e3:40a9 with SMTP id
 5614622812f47-4539deda1cdmr3289617b6e.8.1765236916175; Mon, 08 Dec 2025
 15:35:16 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsOcjjD1f5vCxbv-CCCMZPearMnY6GE-WPc_N=_k1TtfXQ@mail.gmail.com>
 <CABXGCsOfOuWqzV=3wZXSUJRmJpWQf6f3qQ=93=DqtN2ZjhyhGg@mail.gmail.com>
 <CH0PR12MB5284525FDCC5F2261D7FA6BF8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284880C09ACD7DFB6670ECC8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CABXGCsMH-4mC9n-ZySb=QtCLkM0eSX1sKaDTzXT8cG9mFS0rRQ@mail.gmail.com>
 <303ed7b8-fbd3-400d-86ef-ac93c0c5c291@amd.com>
In-Reply-To: <303ed7b8-fbd3-400d-86ef-ac93c0c5c291@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 9 Dec 2025 04:34:51 +0500
X-Gm-Features: AQt7F2pvYmvmYV9lwe8gzTLGG13tTIzpI-oop8B3Q0pkL36lQuvZO3-h1Tf9454
Message-ID: <CABXGCsNZcGXPe_nmRE3fUUMGfnGB_Bc1+R+=JMrymd0LN8Z9xg@mail.gmail.com>
Subject: Re: [REGRESSION] Black screen on HDMI power-cycle after commit
 3471b9a31ce3 (7900XTX + LG C3)
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
 "Vojvodic, Relja (Reggie)" <Relja.Vojvodic@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="00000000000055638c0645793f75"
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

--00000000000055638c0645793f75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 1:57=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> It is available on amd-staging-drm-next. I'm also attaching here. Let me
> know if this helps.

Hi Aurabindo,

I applied the patch you provided ("drm/amd/display: Improve HDMI info
retrieval"), but unfortunately, it does not resolve the issue.

The behavior remains exactly the same: the HDMI signal is still lost
after power-cycling the TV.

I have attached a new dmesg log (captured with drm.debug=3D0x116) with
your patch applied. Hopefully, it shows why the fix didn't work.

--=20
Best Regards,
Mike Gavrilov.

--00000000000055638c0645793f75
Content-Type: application/zip; name="dmesg-6.18.0-a110f942672c-with-fix.zip"
Content-Disposition: attachment; 
	filename="dmesg-6.18.0-a110f942672c-with-fix.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_mixs9qeo0>
X-Attachment-Id: f_mixs9qeo0

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
--00000000000055638c0645793f75--
