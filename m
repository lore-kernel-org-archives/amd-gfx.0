Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F0FC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 16:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A40110E444;
	Mon, 20 Jan 2025 16:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/VA4BEg";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F4410E444
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:36:20 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ef05d0ef18so994340a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737390920; x=1737995720; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kMAl/Pk7TVR8pqnvgqVTKuhluv/mCcn/oNvbzjPydAw=;
 b=X/VA4BEgUjo3JTryh1xNSMnfX7dLlvyOA6dqlKrYpR2Ct8hB3HejLrtGywEVUJzYiT
 n/85Xq0ZQulPWsAjUpclG4xfnsBxRNyeelM4qItg3AD2rhDsksviNDXeJIl0PL7+7Ovl
 LBGr8c0m0ryE9OqxPBHzJSOC6QWsuNllrLAeHdnZRmeJmHNsNGoiJ9KUlKZoOwud0mdK
 t4lAsDgyjwWbeH/huxhKXPCWL0Hv/r9JeqdCbdo7rbOTsltaX2p6zcs3iRQSEU6c60wI
 Icy+6nYkYUf+iDfOfXtiLMqeKzn9kYWU6aL3rKNfcC5qm4k6hlM9OYGfViOsXgQpQXdC
 cREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737390920; x=1737995720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMAl/Pk7TVR8pqnvgqVTKuhluv/mCcn/oNvbzjPydAw=;
 b=qBGbIl/RpnjqaGCshYAsygR0hFkzPLtFIyEKRRyk1ZdyRJHQe3CL7HBk2iAPLps7nq
 YCUDC7/nhjInSoliXduvOfdSOipUVCxG2GJIKUsIIz2Q+E5GZ4D/D2ltDjAo/bW47vMq
 0e59oLaTi+heqbPVA4KVIZDWGG2KjDEoP+7+zCfZTg9mhYhS/sN8C0NyR5QnXRWdt3MJ
 rKii/aJn49FG1NLQOblaTcY+I4hpXyPqqcu0c4Vp+4C0iE4joeCJCYMB7jeh0K7uQUi6
 3K2FskuDcXdMHn8KfoXtuj/bQpHwSthIyAL12ygM0TpNP5IQ80X8AQahj5+hFxBezhkE
 trdQ==
X-Gm-Message-State: AOJu0YyJ+UnhZfbD2Mq1uJdjFYfvo1vVcuaeVdjZUjZhWAL/u7SKpEsW
 CBYcpmqpr0cZBtXbFajqEH6fzKndVOPK2XTBk1eDH8wwTugOUTAnFm8ucBUGPUloHSxFXoC7Bk6
 tct51Xlsvu1W5iQyxbpBdxJ3iRwA=
X-Gm-Gg: ASbGncuhTJ9GNLEitvXaUNhuQu6oHEWEwmx8pycKxGXK/XkL4s7+Ne4MvlfubevsvWH
 Z5LwjvhR793lgA8rO7j/jonv/Z4f4B6m9KRsz5YpsD/Du966Hlm4=
X-Google-Smtp-Source: AGHT+IGQAFCHYjHEq6Dnms4ASz9DqzL+DehfkSYTVNu/q+Q02mz8DAYt+o2EdBRFCgaEaQ14V/5NnjPlo4+/9T1RiEk=
X-Received: by 2002:a17:90a:d64b:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2f782d8663dmr7572857a91.5.1737390919892; Mon, 20 Jan 2025
 08:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
In-Reply-To: <20250116173734.256704ca@ryz.dorfdsl.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jan 2025 11:35:07 -0500
X-Gm-Features: AbW1kvbFFtzJO8AnXhil0hUOVc0wTrAuau88MDbvbT-dBJzDe7Sv9AiB0gtrSqQ
Message-ID: <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000009dd6eb062c25d815"
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

--0000000000009dd6eb062c25d815
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 11:57=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am 16.01.2025 um 11:32:42 Uhr schrieb Alex Deucher:
>
> > I'd like to see the driver messages leading up to that.
>
> I've now attached the entire dmesg without the firewall stuff.

Does the attached test patch help?

Alex


>
> --
> Gru=C3=9F
> Marco

--0000000000009dd6eb062c25d815
Content-Type: text/x-patch; charset="US-ASCII"; name="drop_dev_core_dump.diff"
Content-Disposition: attachment; filename="drop_dev_core_dump.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m659omgu0>
X-Attachment-Id: f_m659omgu0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwppbmRleCAxMDBmMDQ0NzU5NDM1
Li4yZmQ4MGM0YmE4MzNlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfam9iLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5j
CkBAIC0xMDgsOCArMTA4LDYgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0IGFtZGdw
dV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQogCSAqIFNraXAgaXQg
Zm9yIFNSSU9WLCBzaW5jZSBWRiBGTFIgd2lsbCBiZSB0cmlnZ2VyZWQgYnkgaG9zdCBkcml2ZXIK
IAkgKiBiZWZvcmUgam9iIHRpbWVvdXQKIAkgKi8KLQlpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2
KSkKLQkJYW1kZ3B1X2pvYl9jb3JlX2R1bXAoYWRldiwgam9iKTsKIAogCWlmIChhbWRncHVfZ3B1
X3JlY292ZXJ5ICYmCiAJICAgIGFtZGdwdV9yaW5nX3NvZnRfcmVjb3ZlcnkocmluZywgam9iLT52
bWlkLCBzX2pvYi0+c19mZW5jZS0+cGFyZW50KSkgewo=
--0000000000009dd6eb062c25d815--
