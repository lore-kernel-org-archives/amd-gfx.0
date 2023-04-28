Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F66C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 16:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 236A610E0CE;
	Fri, 28 Apr 2023 16:11:45 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241F310E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 16:11:43 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-2f833bda191so6263431f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1682698301; x=1685290301;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RS656tvRpdWSP+KRo8s/RT9TN9u+3dfrwJSy0U4kWG0=;
 b=SX6+5UPo6PMGE0VrjJHn+1cNNEOB7vjBKnxmoCzVYJgQvg/wHd6ZyKALVfxGOL99ih
 cM788q0a2ZUTJxwAZiryToedH0h4pwvPtD2vAeNWKPdMxSco2T0W/3yAmkChGe/umXbx
 1+bZWbhcuBDd3/IxfEDZbdfvhbsrIuMtJh+WZ4w+V4eSi9tK2FY/2BxWewJiplodlD6b
 7v/n+Dm0hDeroEKSLqVDK8UuH/hS4JQxJ0X26b+lsWgX62NbkHQpsnJePLMkZmTcOkqM
 79MNcRj00Tk04O7RKbu/TwvJaOh+qFnfDqiaRJYr48SfqN0uFL1xhkDw2wsvgvERlQnO
 UhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682698301; x=1685290301;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RS656tvRpdWSP+KRo8s/RT9TN9u+3dfrwJSy0U4kWG0=;
 b=RFYlQWc2J3xTGRpq/WY/yCZP/Y2gWakpNA0Uy2xSPq7Gf28zAOzx9Nfx8isFXgb6J2
 1BQUGn6FCEwSBazkk0ibYU/kntWeYw9VF2eWPXCoZpQfShwoA+IfXgHrm0PJW66ibzPZ
 PW0nbysPut9vJcKBJcBG9inq29/Yr4Y1O1f25jS0C16bo1nlHBMAOpXxbvq7GdFZ8hNE
 72yxB5YTdrRZC+7qOh3G4T/tGvCarU8cATM9wdJg8Rq4g7GgPvz0Z3LLLLjw0JC9lOo0
 NWPHRI9Ue2L8s3DkJFjuacmboiot/fwJWDGvV/IYY59Ec4l8z2JOdVwAeWSrgqBnvKhy
 WOWw==
X-Gm-Message-State: AC+VfDxvszW9EY7GqFTvzBAH6w3OD4HR/4UYgHj4YZh/g6ibdU2mJzko
 kK7Hb5zr7dN9UcGJw8CIUoocBb5wwSARaxmyV4oS5Q==
X-Google-Smtp-Source: ACHHUZ5MyTE5eFaG7QzXOMZCR3qWjXXUEgqaaAIhsbHrxAq4QvVhXr268yZ6MgAfPXpqtmtRLu2wCQ==
X-Received: by 2002:adf:e707:0:b0:2fe:ca6e:edb with SMTP id
 c7-20020adfe707000000b002feca6e0edbmr4605956wrm.39.1682698301147; 
 Fri, 28 Apr 2023 09:11:41 -0700 (PDT)
Received: from [127.0.0.1]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adffc52000000b002efacde3fc7sm21369816wrs.35.2023.04.28.09.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Apr 2023 09:11:40 -0700 (PDT)
Date: Fri, 28 Apr 2023 17:11:37 +0100
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Marek_Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Subject: =?US-ASCII?Q?Re=3A_drm/amd/display=3A_disable_display_DCC_w?=
 =?US-ASCII?Q?ith_retiling_due_to_worse_power_consumption?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
Message-ID: <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----F3TZ4M8HTLNGTTVUR179LCBBXRV89X
Content-Transfer-Encoding: 7bit
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

------F3TZ4M8HTLNGTTVUR179LCBBXRV89X
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I really don't think the kernel isn't the right place to do this=2E
Is there any reason to not just disable it from the Mesa side?

We can already disable displayable DCC there, so I don't see why you are e=
ven touching the kernel=2E
It makes it infinitely harder for anyone to evaluate perf and power tradeo=
ffs if you disable it at this level=2E

The whole power vs perf trade is also not a big deal on dGPUs compared to =
APUs=2E Probably needs a better heuristic either way to avoid regressing pe=
rf=2E

- Joshie =F0=9F=90=B8=E2=9C=A8

On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail=2Ecom=
> wrote:
>Hi,
>
>It's attached for review=2E
>
>Thanks,
>Marek

------F3TZ4M8HTLNGTTVUR179LCBBXRV89X
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>I really don't think the kernel isn't the right pl=
ace to do this=2E<br>Is there any reason to not just disable it from the Me=
sa side?<br><br>We can already disable displayable DCC there, so I don't se=
e why you are even touching the kernel=2E<br>It makes it infinitely harder =
for anyone to evaluate perf and power tradeoffs if you disable it at this l=
evel=2E<br><br>The whole power vs perf trade is also not a big deal on dGPU=
s compared to APUs=2E Probably needs a better heuristic either way to avoid=
 regressing perf=2E<br><br>- Joshie =F0=9F=90=B8=E2=9C=A8<br><br><div class=
=3D"gmail_quote">On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" &lt=
;maraeo@gmail=2Ecom&gt; wrote:<blockquote class=3D"gmail_quote" style=3D"ma=
rgin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204); paddi=
ng-left: 1ex;">
<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>It's attached for revie=
w=2E<br></div><div><br></div><div>Thanks,<br></div><div>Marek<br></div></di=
v>
</blockquote></div></body></html>
------F3TZ4M8HTLNGTTVUR179LCBBXRV89X--
