Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBC606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwLlIdaq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D3610FC56;
	Wed, 28 Oct 2026 13:00:09 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED00A10FAED
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:48:54 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so1368027a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 02:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180933; cv=none;
 d=google.com; s=arc-20260327;
 b=ZCUKCmJ8r1voH3x/tu6EY8PWH4bShjASigyi1L0GcwNQqcd1QBTCPnROdywCXnMITR
 MFIkCoQHiRDrDfsSiq9R7TXGLTaIJGQ2Ov42G5hjwzYJ8YX9mbYw1ftgZnmM0TUyPv9X
 ThtXBPhwr0I41gwLVIS/6WuJG+iAGayf/KvJjDWzAFKbNLrqogg2uLcNdr0NlbRA49Io
 XYgaZB9PpLilRy2OtQS5BCpm3jutd6a7OTpSMg/fr/S3hbJ9ze2zBrgxGxf8TLSQQZ6Z
 ILDIKyGDBft6Uny1ljXn+cHua25ZPZNSvzlDRJ1w2H8HHULnjxVKgQaT5WPFGwfYpwYf
 wQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 fh=y7T8PcrYnxzRqw1UqPAIcOn4AnfVdHXoqkxtyGmEdEQ=;
 b=gFn0IhlOCYet7ck5/+tHIu61CucD1vQTdE7/7bvTdTdDXTzv66BsgwAb3duT0Wk+Jd
 tJj/UPmY5NSnbxmW/r5/9BiPzGBJffjKmpNQxRIujZkmg91BZaXQNXcCFUHeeG6fmfJC
 q08sCDkOQOOlyHvWYOE+ijuqojzg51EG6/xwKo6pUlyLEEqrspsnbtiBK+GLrytpcKUK
 V8EOyoq7YI5Y7Fb6MhFAtPi86h+xFO4NlzKtPG+Psg0pwExGAbrgg64vxElcMACwvMcR
 LHJrJFYm4Mv2QG99YL1yIKtiSmOcaTgq4zUqkZW3Ysn1aNb+v0BXLHhL12wOqW1Fpmnw
 9Vaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180933; x=1793785733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 b=TwLlIdaqR2De+/frgxJauvxcud7Nw7bMfWzjPWwN7zpYItK6byIN3C6v0N7kkY/3Ox
 iQSKLaSbUhxy5UvLmw2lwMJBCSE+708ktUpJAg1+ctefJtujtLKnvUGYNdGhxoZxO62B
 irFNhk9yVBjq8rdqUOSiDIkOH6L+ZCX9phI0H4Xoa0ifr1jUwZ+QaCYqTGZ9V4v/8BNy
 MEo3BKm21keztiOilWg6UlQELwMIk21KD5xqPWqIAxe1sROoXE4I937Yze2aysVrAxqJ
 MtifkNbQFSIX/cH03pYvqhZrrl/5VN5C+quumaDa+lPeyP+Xk+dO3Sizf26reCc1QIsp
 O8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180933; x=1793785733;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
 b=qOa4AygKBlhy88BUSmoRTVUwf2WwfWjvrr4IzNdEz5QK/XUixLWX9bHdTHS4JqSxfF
 n8qQTt0k1e33jf0N9aAn2jlQOrT/E7H50CgEehQtAE1EpTSZTxh3kwFzo9mXHlYbu7TW
 Lekbp32Z/a2dnHswRR3LuBPS0TPPVXCprolM4svdC1d9Yo1E/GN+wzJzf/DPcgUkqQCU
 NmORz1LFATRO/71QkDoCSR2R+CsPJT0A3njqKfadgKPIZ55ujaV3vFC3n/rwmi3P5tVv
 HfIDXoYgXt9AA+xQYgye+Bkt3MV8AySVm8hbq5tNVJK5jeLDIdF7YW+awsEsW9/WtRyJ
 EXZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2rMoYdBcaKrFAQApDynRTmPy3C2yBrtfRozbl2r9pAxSI2l0jvHpUzyU5z4xkthjYVJqtsi9T@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJswKKCIiod5TAHOsnTXNL0GsoOzyF74ksNX3/KOjS17n47w348
 664gjCEvp8kGCSjwjEFzs7n6MfF2GDtaWCXrbBnMjbrK70aEACQmR+ZwYc8OlN0/4A1UQElQw3N
 B4MzLNLsPysynD2JAlJbN0gF4nDo6IpU=
X-Gm-Gg: AYBFou3BFtyRCKvPAvoIEQLanYisyqo2gMphohjznHgMVFwlYl4KVm5ayjAKX12A6Bs
 6zGJqv1Ra6GeZnMdjgwJz5T9m/9+V5n5EPZhpBJhjWzKs2YeyjHSfUA5gGnuILAVym985TvwtbT
 M8it2wSBJYR9GmROF9wsUofcJiaZVSTnATp9LZwZ4bPuzWBUDjMEc68NC+gXJ9TDMwdPzq8BpxR
 UZiZpakoUQ5UHFztUe47c7pOEAX8S/uytxvXbtqiutRDiQDhuBmpN3H9r6OL1/jEGpSBAzh3iYK
 iOzKcWMUxfgASNAjVSvKcUQ8sD0GOctgoka7S6DXZIKdPQipnzR02/tSDpQGFTm+dlwM+y1+xou
 Ynmo8+DF+rA2hbb/ybFHqeZVArLFwX6ZHToz73A7zwopdHdvUZgle27Cczlj62/16AoKwfMEPn6
 aeuGDN4PbE51MdQJqEQQKinyNuoHDDoR9CuLwxpusyo+h4K3f8vbMwxt+9VfB1SkGuPYDRmRHi0
 mMCWUveCDbqDlLoLUF9ApOCcw==
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr156034066b.17.1793180933042; Wed, 28 Oct 2026
 02:48:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
In-Reply-To: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:48:16 +0200
X-Gm-Features: AclHuK9bqVSr5ebQZT2ja4gGk1wmv0GUJ0T7y7aJfJNVsg1OI_1bv2lVUKDS3Hk
Message-ID: <CAHp75VfJ-L5ELAttN+Fz_Co2E1KHumwLZAEMXFMhRubzgVLqug@mail.gmail.com>
Subject: Re: [PATCH 02/10] string: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
