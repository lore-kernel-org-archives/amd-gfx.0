Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15423C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFCD10EB26;
	Fri, 12 Apr 2024 16:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bs+fEFhc";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447B010EB26
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:52:57 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so900577a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712940777; x=1713545577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezx/Tj+O26aP+vVMwEOpTB2UPy3w2kX8ihT1mvLlvAg=;
 b=Bs+fEFhcrE7GC1cUrHhpjP51i6JOaJRzsahDWhKa/oRJoXFONHJZ+OYTe+jY0g9wbj
 nYRSL6J/o2upt/7sIYN44+k86e0WPvpZQN0W4oDoyqdVihp3sQIU41SUkMsO8S67v0hs
 mKomvDzVNImqqgPO9koV/ukySUVj/U6k/P/kZJgZhrP0EeKBSPQDRWDyZCStmZ48HRLL
 dz4WJCVCkDQ0QrsLr6t7+lxEFLPFAHicFomF/SF6j07IroLZ5mBZ6VJeZSMLxJARTj3o
 wntxvGFzRLQnz4Z5+3sVMQvzepGPLkPQZH52SN5d//vqiw1u6Lfxc1Mz6SBdluHxO2tJ
 o4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712940777; x=1713545577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezx/Tj+O26aP+vVMwEOpTB2UPy3w2kX8ihT1mvLlvAg=;
 b=A+4GImdXksiVLK/nWDvuKd+PWdtkAquBPXZ/tWpZLLikszmA4pgGSzujNSJ6EI6IkS
 UazSA5azRQR0zMrxnbPY6ojzKaWvrA/COWCKGGXEcR7UHtt2qqlVwEwTBRBOxxyMBXa6
 DhT/ykn/qiyJaTn0OxO5nPwb3zxXOGFtRngzk3f5SMT8Ix0SUXdd6y49+HvE3jgWyqpv
 B/samV+/+VPaCrwhq4cAItPJH4m3BriTCNKAaVluBaYb1HtPoDKBrzP+WodjpW8fQe0n
 dqrldi5xQAqvXhDUcV8gRQ/w/PuJTVd9/iaTl5trNZNFtdGSJ9xSIZTdOoWzQKkgz2rB
 6HWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVEA74il2sMzBH4xCzPkwdwfTIe0BuJYbqmp6xfPl9SJxyQdo7Y5JCrK01Q0bWBoaEF4UX4itI6Rtfwsnsy4AlYlvVyAxIKf+zKmO8Qg==
X-Gm-Message-State: AOJu0YzkBA2i8NGUQnHTIHlO2s2FvTUdS8Qa+pxPqGrGq7PN8BZlfcwO
 LVwiYpJyQPgkEPQCWmxp+yFwCit+yfOPKWi8BW8O+F/z+4DLzy5bzQP6CYkdvrdqWsQYrbway8b
 kB1iS0eIcSQcMW9Qk3Z9yvPfKyuY=
X-Google-Smtp-Source: AGHT+IEKRCrfu+7YDYpF16HowdPu/Gel1CUltO/UzJ5KX5tAPWIgpgh67SQTIMYoeK4asolnF2Uw2l2RkYQnIs40/Bg=
X-Received: by 2002:a17:90a:17c7:b0:2a5:decc:47e5 with SMTP id
 q65-20020a17090a17c700b002a5decc47e5mr3269568pja.38.1712940776621; Fri, 12
 Apr 2024 09:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240412140034.65565-1-sunil.khatri@amd.com>
 <20240412140034.65565-2-sunil.khatri@amd.com>
 <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
 <69a8b47b-227d-4c35-96cd-13d4576b7aa2@amd.com>
In-Reply-To: <69a8b47b-227d-4c35-96cd-13d4576b7aa2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 12:52:44 -0400
Message-ID: <CADnq5_NqSYTXcC3g10wcLf=Ce1yC6j3LOGukO0EbXkjQVydO5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add support of gfx10 register dump
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Apr 12, 2024 at 12:49=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> w=
rote:
>
>
> On 4/12/2024 8:50 PM, Alex Deucher wrote:
>
> I would split this into two patches, one to add the core
> infrastructure in devcoredump and one to add gfx10 support.  The core
> support could be squashed into patch 1 as well.
>
>
> Sure would push the v3 with the changes.

note my other comments further down as well.

Alex

>
> Regards
>
> Sunil
