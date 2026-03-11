Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7D51125823
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 13:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81DD10E1BD;
	Wed, 11 Mar 2026 13:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQN5QoQ6";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A53610E1B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 13:50:43 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124713e4244so892776c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 06:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773237042; cv=none;
 d=google.com; s=arc-20240605;
 b=X8l1rDpw9AEe7G+wFmyyHxwQXoqFpcHJuv4C0/uoZzlwTryrzAhxcnNimDeXp9kWWM
 hCNVI+f4cxNsX9IPAI6BpCy8TPIwiSH5DCJiQ4iKsVq9ghqhtE8ZngBAKfqL4YIz9ciV
 rCvNIxAAEys50DgQZEoNvVwdmF+F1S4sL5yzu3jWs1/SCC5jy1LpYR4FJyGYiOLmeBSr
 /vibbCU7JG7d1ntRTBExJb15VBI49CkHszWc6Bu6Na+pMbqOqsjBOgftcrZbQiwADMLD
 fMmtTR6GH+mvyO7m+AwYARSVK7hpjkTeqpeFYSQ85zqr/p91CCy/TuBcLRlgkn+aWDwk
 kMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
 fh=6wK3CaOM311B/alEvOKhcnOpIRqlPmoVCwfBvPBc3Qo=;
 b=HsI3kSywhmQU+z6U2l+glZewenSDA1jTUALWwWWXjcPQbUppCo2aVfyvnQPRjbzHeZ
 PQYfbdHfniIt2hj4HjH6NWcyh8AuLzC9PP9YuU7uOTQsAHSb/44BPL95B3bcaexsgAcW
 h8UvXRPToID0aqNK2axaFkmMItBCpiAqXUrhAaag5fJrMrJHdax/LrLzebln+a3x6CTW
 BkK7id7H17eYjJRw3Yv0u4lw1YWagUPzrQiSQ5vnDHB6Zfl55FqJdT4b+inULuvdl5Vg
 7MmKK1uci8zsuvNfNBJhaYIMQ60ka5BjspTPUwY6b1JJvI9B3WcPKd1zcdR0HM7coWkB
 2hYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773237042; x=1773841842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
 b=gQN5QoQ6KFxEZ1vDvtjHfntSH/Dq7BHv+ZqsXjiWGHAh7Qq4JvUXstKEnoKywffqT9
 FOEy5HtPVGBgRlaiQ2w1r4nBCxZCzSecKloIyPA5m7PXG5cgsNrBtFptxKk193TwKC1Q
 oFHYJenOBLuCWq5hOoII0KwGDB/uOOuTPzU4Q3DVmex6OeOO9Da51LPnqjbMjMbfr/bf
 9UnFjNU8Jz/xV2dyctv1ijr5fsILAuVQCxvZSgins5QUMsV64Zgk1q0cEP2RJtlKDNVs
 TQb9hXTXLJikgykLcT0towwo5DF2pvYHyyfOeoMIPeiZSluyrE2U4unjeB3pRHKz3Dve
 pKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773237042; x=1773841842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hrWxe7huXLGcH2eRq/nDkQyqOoBgN9FgmWPPk3aJ7iQ=;
 b=Usl+yyFCADq5ajk+6P57RNG/nKpchUkkx+bUyTEBQxVGP0xT5Ba07LlqiUEb6fnkEe
 zIY9XyIf6VyXsW7DlzqqwCZ6Ftk9LgcJbiSmDrjgRjN2reyk8+6A4Fqj4d4o5qG5VSUQ
 qhNr4iRKHF6O5/bGp7CjvJPIuwGlyaberKnq0CwsbDVNB31MZ7gDl0hwNUmqoX9l2nW6
 aWrgqYQDKKWMavQNVSDqIwoNKC09nv39++1MM0cqG49nBu8etGa9wuSLa2kxkjbtm+xs
 pZLOL5BejCQg40zroJXKqghHWuUjNMs9ckilaFnMU/w1PBe3aToHQdWbsn+GWbVDUhTV
 GSxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPVmQ1p5yKe4b2rE3E0kZ9wukW5mwxo7MdWSRCZr6RvPc4Qf4HiknGLpu8W17yquj/XF5+xts7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHPcISG+9IuwB9M5ubVNMpXh7eKD99zGQLjWZ02ZgqjSPqYmwL
 utlBB/3bWSzpa2sGsElSGH+lo5FeLLyboQV/lPm3OL8D9m+6bPkm1k8zu+Gi7C6ZgYDX5TWLJUx
 THnSzSp5Tf3cYI48fH8nboQpvorCpuPo=
X-Gm-Gg: ATEYQzza0M/B8PakJ4/txM8RBWTYeojYcFPJPwcITUQY1uFyu841ufIr7Hb9MJJLafh
 nZjGY6pJrvzesBVC5ydfxbU1hjB+C2LarXHWn9I2MNt0Kkf1TVUjo0a6FaxEplzUfUu6CmiWm+G
 sqafwv0x5+6FtPq8WIYkfPewMTODa6bRMzJP1Ye6/8+NzgYtUC0lCwSJYtFe0nJR+izZlO/kRvv
 KazIlAN8H9ZeCeqB9ZtHbnbDLFQaem3But1ycI2LvrGW5MH/XYq+1DwXcJLXCqvB2UQxoKMkKsT
 CD+0gTOpKDDsCpFeigzxFRhE1ODcD1unfUYs68m1k/HR1coV8+fMj2qevErXZEdRh4sXsg==
X-Received: by 2002:a05:7022:1503:b0:127:3480:7ca9 with SMTP id
 a92af1059eb24-128e778b056mr646722c88.2.1773237042449; Wed, 11 Mar 2026
 06:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260109162514.308143-1-yiconghui@gmail.com>
 <202601091117.122A9268@keescook>
 <be86c64d-db3f-447b-92e8-085333c28d11@gmail.com>
In-Reply-To: <be86c64d-db3f-447b-92e8-085333c28d11@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Mar 2026 09:50:31 -0400
X-Gm-Features: AaiRm52BZqGIbP0vEq-B5UeZs-CBWlpJXFWO9mG7NhBLLIxZnacde8BTAw8Hoyc
Message-ID: <CADnq5_N9PdjcbV=X4eDStPZd0COOGjaFJf+J-e_Lr9dMpEmq+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy() in
 amdgpu_virt_write_vf2pf_data
To: Yicong Hui <yiconghui@gmail.com>
Cc: Kees Cook <kees@kernel.org>, airlied@gmail.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, linux-hardening@vger.kernel.org
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

On Wed, Mar 11, 2026 at 7:59=E2=80=AFAM Yicong Hui <yiconghui@gmail.com> wr=
ote:
>
> On 1/9/26 7:18 PM, Kees Cook wrote:
> > On Fri, Jan 09, 2026 at 04:25:14PM +0000, Yicong Hui wrote:
> >> strcpy() is deprecated as it does not do any bounds checking (as
> >> specified in Documentation/process/deprecated.rst).
> >>
> >> There is a risk of buffer overflow in the case that the value for
> >> THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
> >> replacing the deprecated function will pre-emptively remove this risk
> >> entirely.
> >>
> >> Replace both instances of strcpy() with the safer strscpy() function.
> >
> > This looks correct to me -- dest and src are both fixed-size, so strscp=
y
> > happily checks everything at compile time. :)
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > -Kees
> >
>
> Hello!
>
> Is there any further feedback or progress on this patch?

Applied.  Thanks. If any other patches slipped through the cracks,
please feel free to resend or ping on them.

Alex

>
> Thank you!
> Yicong
