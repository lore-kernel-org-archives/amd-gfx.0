Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFE606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Maw9n+Tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1EB10FC52;
	Wed, 28 Oct 2026 13:00:08 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC4510FAEE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:49:42 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso812356a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 02:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180981; cv=none;
 d=google.com; s=arc-20260327;
 b=UD8iPL76xKIWFTgbbkpg67P3WpgvFiJ+FrWyQjxwVNc0Ruc9xOCfSuCX8EL9WUV+M0
 BDULpFA+8AterBNblWCF3h0318+hTjSUoT3lWUG7GP16MlRjDqnbyb/89sC7k7ggK8pP
 ZKn+eq9gAImwVLBCDQHt+GnP/LI6DpXJK63C3E3mBMAIoQgD6K1uQDuQCsJmc/opXen5
 82qrEanUMrqJaG9tIcR9hfvmLBebcB52RfbNAHppLWO3OSgtOY5k1OqUPuA5r/1x4SMf
 l9zV9NvFgMWcOJ7viKi4vpGo+wQK9mRwCdvbaLzkO97SdmEInedSCMTTAlj6M5ZGqHqR
 +JcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 fh=BiUxISHmUmoRYlEHC2hCUKNQCyVsS68Id7ICbTNQ9Y4=;
 b=Lcnk6SdWyNP/1TFbL3kCo4xMPF327YXvpeOdkhA42I1KKvQXnlWoYfAvH5rpN4/tKY
 Tj5PaZkrt3jSPMpvDARpVSTAlvL6DHDXlQ+BN0jwkxE0I4TEgeXf+HQTGuB7VN4Q51DM
 h+Gatk19jyzM1UV0XOmmfeY1OXmEPMwjEJfHTYCAujJ11bq7bWROBuQeWYok0srSx5oA
 buvaGnQnBUZF22C1FRosXNAsWW4nnsdjb89PG1jS1XwJmOsaEk4mSB1lJWqJCfabsWdi
 1aDzUPRwjOQwDcsn/ZIu2cRwXRtk+78EGOiYdSOi9ko8rLsOJFKSkcJ7sVdihUAvVrkY
 MCHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793180981; x=1793785781; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=Maw9n+TcH4EeZ+50zm4sza3sDbL9oGQlrvaSKk/UYKKaYdF+sdqqOo5Ba+SSTfh5+H
 yNsGSwQbLT9ze28aZp+DHmxrgvpcl5/6jG2/Kon28EiHgK+KK5YJV1FjRWgxlNdw4THc
 jXn2kh5Wqt2i4LmUXSsV/qV9F2GWFE8ivCeZZrkVK+8VOfPOSc+ZsYbDAVb5hPSgXzWk
 tTlGejzVX/A8SGO57xOR3nX7nUB1R+2Kt1568PjhjJ2VBa8uaunZs7M+7VwiMZuQz2mN
 akLfn29QZjysCK3NHRdE/mDKq4dlH53hquuZKQO2Dq8h29NWodRciIfT70BylAdMqX3P
 buIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793180981; x=1793785781;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
 b=e2DQwRqU0xi+TXInFCBzo6rFZ5TkhQFRsaEBS1NlBDEwFawLCxRXe3rQQCaXJCDpBl
 vFisJnULZsDaQv9a9gmcOFV0DOWaFwWSmAO/7SQ8YM+DJthAdAdZjI7GdbL6mlAQ2B97
 vEbsbQkfyboLkXZFP8GqOgOWWpE2XTur2KwvEh7g0JNrZkzdqr6+rrN1qJnB4KCram8V
 ddRR8TJBq1EU1qL0EDLqT7d2OHpw3xAeXL6B6/rWkqpeLBtSej0dIElM/U0uQJauD57/
 KSUj65uKlYVkyFbdjroxrbCs8c9J9v7oQSxsXrBO//CQc/znZWXnLJtbyKeh6AMbdSKx
 aFDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgRf8dqt0ZyrhJHaR6oJYEw5o83OA2UJP5ygqtO+Onot05d2SJKAv+RzG4BG3o9P4ZYrSi3RAX@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKu2nE70IA7ZD7Pp16dfj2ggAjA4RE3uiNo6pPNyPAqhmpsSgh3
 sUxVH/ENBTOYsvAHUHUYG+VazedEESKbss7vEL5KJTF3w1zUSwnGnLU03/4qE8Qxc/GXn6WTp86
 ZJiagodjyfqBLNamYD4vyg5xTIJY3+vk=
X-Gm-Gg: AYBFou16ldLOWgRQhClLHB9nGjUBr59ChslZGOXuMrSVYCcP1x8oEx27CBYhsah/W2o
 NHsAWrO9YozUYyAX3QGKMSlviLch4qNq0mgr4IHjn7RN8g8d8Y4KiPFYin7c2A5LqGt61GqddAx
 +Z7JMunsItDgTTR4JB/sgNu7CzONlkqnACxyHjO7mss/WxIbzPdndWNT03QrvGFYsyghdc6+hhX
 WwYqsL17oNgZv1QGB24sWt0Cv0FWCkQQpl9L+0Zo2+1VNSmERxPdgQ2mAhb3mR6vpTmpdgz8aL8
 GXjAlzc9L/WXuVh6v2LC971eS8M2BIZBBJoJ+QdeG13i2R+gzlX1bz9+x1CgrQaanf0Hl47jlgF
 Y3srduypQt/G1HsIrMCegolaBW5NBVSGdBMr1vFy7EWRGHXfBQEt51zzulWmi2SZXjshZohZ3yq
 Z4s4tu1HUG2P3ucngaS4rgQRxeNUhrkgqVPKUCKeXHJ/yT8R86g/pWckJ+rKjPbTiATkr6qi09w
 rEt6TSz4EBa6cKrgHu7H5FGdpA=
X-Received: by 2002:a17:907:d48d:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c49bdf7de97mr167322666b.29.1793180980909; Wed, 28 Oct 2026
 02:49:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:04 +0200
X-Gm-Features: AclHuK-kwXGKz5n7QFXQ4iO49tQbUX582-rj9xJLuSYR3NDY9XFvg2hsu7UGHjc
Message-ID: <CAHp75Ve71BfcWr++PfQPiOc=OURNn1-cdJey=M1xBVCb0HhHQw@mail.gmail.com>
Subject: Re: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
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
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
