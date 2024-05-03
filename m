Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B265C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 15:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20EB1126F1;
	Fri,  3 May 2024 15:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1fvUZy/";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8291126F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:34:05 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2b33d011e5dso1992729a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714750445; x=1715355245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0aL+sjjhgHPcRyT8k7Nf/Eenahpc9nDfQrN8qKXt/E=;
 b=e1fvUZy/0eTgZsbVO4kQD+dEkzqUeApupC6cuInR61V+Q4K5oHHbFok10xwYdqddH9
 QwuhbBc9tfwp1B7IL5FwhJlQU225E6q6hr5RMMjEDbj7Vp3lMtCmku+oE1NykpZw31a9
 s7wkagXum/7nUU2mlnB2ej0WXdcvWXyDx/BHOWqeaYOKbd81yZBCWtpbw35CHcvmhaxc
 i1adU2ENtfnTj/LmnRxInNhRNWJ2Q/hZD25/tf4vdrPEH1sHIZfpuVepdzVGSaty+RBV
 LmJCjEBcJlGZ9k6hdr4+y20xkHbnsKzVomGKGczhOTbSSa7HZ6aWglf8b8NYivf6LxXO
 DHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750445; x=1715355245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0aL+sjjhgHPcRyT8k7Nf/Eenahpc9nDfQrN8qKXt/E=;
 b=hn1BWWdN4gcvYZAiS9eKxEcS7ET/UYV+AvZP+U4vOh8clFO43RsUEh6R2CZ9AuUmq5
 XHsgsQAnQNCfSJi5qflcHAPU8j5sepadSEWNEQXSxCQNesao7lhySvqKns5XTqSLRvc4
 MS/97nEsBrWpA9Yyk9zSgOTd6az59P1qKvg4qundfrmOQ5Ox4sQuvgnFldxaE9wVuBlD
 mcEYvDl1V//6GmseByofIS1TMzRjG9frJjemeetfZNKtKMhRwfZn6eK2PfUThSKf8dzQ
 jrXO/ourW1uDm06n03OizKnVtdxZjPWxyYWs4mMIArWIoi0dWQ84wVD2PEn5uuL5IZR8
 mvaQ==
X-Gm-Message-State: AOJu0YyxE0FPhR+yJlKZ4PCu20IPK814z5F1UPQznwmI0kls8WWKryuC
 oBsK+38KKM31bMMhaO8Desr5ar0fLgf53uSCnEYCB6dynPfulrIfU+9mN1+1QHb4lVVKhrKP9iv
 2RdCNIIM2q5SEt+owyqVPivc/CQc=
X-Google-Smtp-Source: AGHT+IEDDVsWbQ4xyG/XW9nbR+r3rSp+HTUCqW2fK8s2uAvVFz8ItJs6X3T3uS2d1LUaMEJZ3YPpVCC/DR9O/Aemm2c=
X-Received: by 2002:a17:90b:3547:b0:2b4:1396:6d3d with SMTP id
 lt7-20020a17090b354700b002b413966d3dmr4504151pjb.11.1714750444769; Fri, 03
 May 2024 08:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <1VLcj5GzcoG1-O6-r7zBAGyAXVUTTIHMyJRR8Svf-ckgPom-otJt8N3sT5oPHvLOiYjvdXx6zfZ3zatRHJFGsitQKAA8mHNV57KoFBMjNJk=@protonmail.com>
In-Reply-To: <1VLcj5GzcoG1-O6-r7zBAGyAXVUTTIHMyJRR8Svf-ckgPom-otJt8N3sT5oPHvLOiYjvdXx6zfZ3zatRHJFGsitQKAA8mHNV57KoFBMjNJk=@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 11:33:53 -0400
Message-ID: <CADnq5_P-LpDqaqUs+_1=mNZwDCCWWu4x2q9aMy65gn257B1vyg@mail.gmail.com>
Subject: Re: Allow setting a power cap that's lower than recommended
To: fililip <fililip6483@protonmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Fri, May 3, 2024 at 9:27=E2=80=AFAM fililip <fililip6483@protonmail.com>=
 wrote:
>
> This patch allows setting a low power cap if ignore_min_pcap is set to 1.
>
> Signed-off-by: fililip <fililip6483@protonmail.com>

Please generate a proper signed off git patch and use git-send-email
to send it out.  Also, I don't want to add more module parameters.

Alex
