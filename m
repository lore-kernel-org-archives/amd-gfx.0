Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A280107BCD9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD27210ECC6;
	Fri, 13 Mar 2026 16:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="L9ZDUkRP";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED12710E0B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:30:58 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b942a41c5fcso307114466b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 07:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412257; cv=none;
 d=google.com; s=arc-20240605;
 b=V14B1MKEQ9n9TJklfzdF4+kOMoFmpygnTUsvRsAirTakNBkbpqZL02dqd6eGwvvybO
 dgSmCl9TT/It8B3R2+DKf4qUYkohfP4rOaJvy3+boUxWf5murIgYpJAoW1WVbUIYfZAA
 iWODx1uyQLiUMTRyN9W3l8mzexcVjT1PF4+1uIBSedlVAd5NOII0iqa0uPoo0mFTbTMN
 LNZKkvYPRBPSONTgdAdcxxs+7IckMArhPSzwVZEruMYaBkFSOfDwCv1+qrAnBnUcmd+Q
 KFUTm6H9o1BVD36UQLXgNBTE581Py79585s2Kvoa24VtFqZn06MVh9VJXJ0egNlGrbRg
 ZOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 fh=tj7oNe0FIQcyPhn7ErbiBZSRBO2uL9RHfu/yiwRRy2I=;
 b=ilDtN+v2Yxc7W/x3n7EoNoQRKIEdwOnP31CxheJR574Q2aVpv+8GLvUQ89UdDy7nTO
 mI002rW0VjG3wXfndj62uG3d3yIFrpgSljwODAXP2EGYk3sXLYdH8MlhcPM+CTEJ4Adc
 MOQR6fargbvi/5+sK2ofkVRPpm9NGHS7MT27v/vbIme09JqR/hqNW8xKx74AnzIzS7Zd
 jvFARkwLBKzL7P3Lca/0rSxtH27TC6U1MGixptGbdPauzOr+Aik4pkjjEkSictqKAIwF
 CYYLY+Z8IRToEzmwnfPAeJFTwlO7mJiDGR1gxCWofcPw93K9YcihBVvX0Bsf3pgj0oJd
 7ncw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773412257; x=1774017057; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 b=L9ZDUkRPDOqVJMDjsyN83qRs9iD5TquISN6oD/q4YF8hNSbvtYOe0eorLHilqylYOS
 /KJNHrsT12T43TlXOrONJjDSOJ+RF2r3eRPQyCCfBNzNyDCw4gdRqM1FJqou9bnraFJu
 8h3FCATlqtCsLsXrygRIOGSarcLpfLw1ieCBuxBfx4zZcI2GkGeKpKCwjV+ZLMSpq8yX
 S3+H7NFW536oLYcSLXpMBK7CSxX+3ds8QwxsAwDyFnT+f2VCHUNFI3aoEcrR76sB4Mp6
 BpOEYbnRv8e/082Wnhi3tE2P10ck4J1nYx2td+29Y8ZYKO9mMuZqBv/YYNNT0QyLcOSb
 5ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412257; x=1774017057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRxonFHxKOFtwLU4vtjcCaWjDuObgsewD5LZ6SLLhBw=;
 b=iGGDQnMxuKgpYAetzdDVNzT9yYF+VW5KiFnT257TPJ2+mxDTrlYiLAdgcpZDg+w6/Y
 fFWjRyYJFPLqvILZScihxokMRb74dlu6xqq7nXhTJuD5Ujf7w2/EiNYLi6mrob4HwDrA
 6Pgzez3AvI92mOJyUSiMMwl9fbFRBEyk8mucmCD3OhkVo7JbVTflyA3n7TIeja6AGF7D
 m8oVPWqlyw+vJh+9Ww+q/Wgti+7ZRVpFrUw24Gasqhevkci1OtM7eZhZa01AQB5ftcat
 Gr0NtNd4+QP8W+e4iMhsMNMa1ptOu0CCZTzVlS8Hc1RgktrMB6GDe//LKfP/jYvGpdSm
 HTmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQwRcUASYNF3mGecneYOdfH22sR8i088efGlN/G9wm0yQwjC+B5/QzBC4GC4pZnnRf6rQ+RyxC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTV2loc0fMOC+1eigGJFYlAdfB5m5UXYFcUJPZ//tLz2CVOP9g
 9YsjXYgjvxI9PIXPRU5DWA+ieo+TFtcTKVPI5pBL4otj+CO7KNh1Ozs9c0QlvVERqnoFlsToC5B
 vvE0Us46FuCKk1RYxcolsLWxb97GqD1fENF6zmTSXnA==
X-Gm-Gg: ATEYQzzNmHCIWtfT6uJQTstA0UqiYKSV/riNXtp9F8jAcgef0nG0oWjuVU28UkQNL6k
 dtq3bSNAysW4pfe/+h8/KTy9B8ijiJTB524HmNtTvwHc+f66XusAslRRYQh8VeUHjBgrycaAv+K
 s6uQq8CyLax5FFOwPcAyjBg+Ipx5sP4yfKhEXJfQZz5s3RuPllMYlQm7pJ0Hs6zcZ5eDEDTIxiM
 /RMVC+zqsg0fCo3cOLLQjiExhnS04DjooAXrQXlSVlCqfjWULrhnFQECH/1z6J6GkOy4jtPje7E
 lZooCpKG0NRoeYhencuzclMUA+Zfn5uBeeer1Ii8
X-Received: by 2002:a17:907:c11:b0:b87:1c20:7c63 with SMTP id
 a640c23a62f3a-b97650e6e92mr207376766b.20.1773412256991; Fri, 13 Mar 2026
 07:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <CAAofZF5XSUVn+XW75rC76-Amibc3rZnG3QQhWxPtk7K6YMQx4w@mail.gmail.com>
 <50e3d83a-c90b-40a4-85d4-f5b0b474ab97@amd.com>
In-Reply-To: <50e3d83a-c90b-40a4-85d4-f5b0b474ab97@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 13 Mar 2026 15:30:44 +0100
X-Gm-Features: AaiRm50wX-gvpB6CSw1TM_ZxnjyuF9CD-NmCqCiMXD1oDbU4mspiNqOOHLx64Tw
Message-ID: <CAAofZF493ZvbZa0qpTjKU7VZgnGcG6HFuPF1SMDk1+S3kiW77Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Replace old wq name and add WQ_PERCPU and
 WQ_UNBOUND to alloc_workqueue users
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Philip Yang <yangp@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

On Mon, Feb 23, 2026 at 11:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
> [...]
> I don't have time to go over that again in detail, but skimming over it l=
ooks good to me.
>
> Feel free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com=
> to the radeon and amdgpu patches.
>
> Felix or Philip might want to check the amdkfd patches.

Thanks for the ack, Christian!

--=20

Marco Crivellari

L3 Support Engineer
