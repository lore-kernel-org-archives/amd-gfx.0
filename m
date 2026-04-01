Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CC2D35159
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 07:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7A310EC73;
	Wed,  1 Apr 2026 07:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLVRBM+l";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43E610E39D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 07:54:07 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d7e5e8c907so4194989a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 00:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775030047; cv=none;
 d=google.com; s=arc-20240605;
 b=bbIcEsNpGuZw3BoqUrPSOCMsOojwxgYxqp1SsJEBhqXhXimlVvlMyxTTR+8I136hsR
 fpLRdJRZp6CbJCPgSkgKo5KxjgDNcKv5tTlK5UJ/BYjF61/pSEpSXYQXwHJnORo4YF3p
 60A0wSh10oGp1UekeGHQ6ahChpUEaXDvicBE8sBpo8umeluOROm/8fZa8i+qTG9/Snc4
 kXF8TFupjDwUrZjZdx5k37ESnhMHJrexkbQjWdNs1WqrYEiWjXgSTEdwT+GBpZMHdKhT
 HxKTSt63Utv5b7Aiit8J/iw8/YX3jLwA5jvlkH4ZQCd3IoG3GY+wpnBAN290NKCvqyJn
 ydWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 fh=La0utGhl0Zmc4bdtfbXc5Y7DjfR8zYpquFbFFoK4GP4=;
 b=OSctxuuh0EoXfV6gSkT5rwQJPHW7X10dx3AB9deD0veWnvsvNUoyeN6xf23n69QhWP
 LVaVNi+/MmXrI0JsbKEoc2IESZhNrByACnFWSM0zIEJXRG5SJZtBiHhcrwJzCxN8Wgc1
 sxQTXVXmEIFvAN16Be0508TIJNgmplC9wP8Z1fnbvUEE2udO3vNIBDMreT5ofVxrBZh8
 RyuMYIkg7A/oMJo0MFCKGR4OGKV8gt7NF+RfnQfjw40Q1ivaMfzJooBMs6WJOUlSpGVj
 qRGZpgP1E/cHkW180/O9e7p8HHu2J6KMoo2prPrbFklnjdmHBButJW/3KWtZ4d3OLKC+
 Nk+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775030047; x=1775634847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 b=PLVRBM+lBe78/Gu2kemUgpiDlxzBvrKw15wd//UhJhS/1hIQGVenAv3vhEN2xSuUAR
 nFJftVhHAVU00gD/n+D68GdQvhIxKC+ZNMcuEGGTYKr7gzVpG8CF2v8z1LoCah5Ttsts
 F9/sYgxYVpexk+OBUSIu8jcaPEY9d4wTy3AzKa4Y485JhdhFwCgJ7j4GPTSei1gT0orG
 GEMlgZC1ILN4fdXFXMbrMq1rcRhMfK7866gvLUnFGdVH/CjL9mvn+OFuJktnNh9kvSpr
 Ti/zgXknblEu6X8a4QvHTa5QDk6iNPS+UbXVPLPDeiW+SAHdz6wY1ii0PVKOWzKoDGcU
 rqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775030047; x=1775634847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Onegw/uhjhmbOLrBOIvAd+f/C9ZHUdcCB0fhOs3Zv+c=;
 b=pPgXaiWCKSRK+6zPqivwoN3JVeUeiukOmYaRLHwengg8uxYgYHFLcWuHFFhQKyZbpz
 WH9CCQGT4Gugnuzbv8otv38YwDUv3+x/q+PZnjw8BTj9UddtzZcUyvfRFTdFwZP2QnHB
 TGxxhyOh6/9QP+WTSotJlNBCnuFCycDP82z884KAtyNkPcAjBuON/+XpShXN1pXirkkV
 /A4T29kIuKdeFIs0tRV6ssjVq8AKO9XncdiA18Sa+/GxcN/Z49hgxkgQ4vt8rSKRx8Cd
 UvCZqwBeKd12IkUi29ZxkPz+tT2fpgWHd2IJAMfwKH8125qlbMCA6jdUvBUcrCVYRA4/
 IqAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8kwqHAZpZSm4BJzh6WThOp8nZ63wgOXB96ikCYN+CCkJbf1hcUlmZu4hur4KnCkfOx1VImth/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1boIkaFi/AyXNRI6GINlcwCmKzSSQwQSsu+ZGtw55sLzyRq9o
 4XhqoQ3pUOs5IjXYR/Ww5hETqpjrV9Kctdn8I8EyKqXNO93hRhiOl1jRVv2aXJeK25WuT36qHjW
 4VaDcYFCnTkUuihT2YNs8o3gxm7srqcc=
X-Gm-Gg: ATEYQzwGsTWt58wcB9Frkhtrw0l6dR7K4iP5KVh+/75xNb+p1rlZpJk5Wo0Y1Ej5mqO
 encJNvsoxQSdOFdP80GIz+Wf7h2KyC28rOI9n2wsr3n2E5VEWfOz26ulLKSrBNhL2jIDOSOzRN8
 wpjVCQ8an0GfXcIKfm/TB80pvRXJhDc6Co6s3W0jGEu8MkzwEqCHkrJvkH7gnseaI/uVslyAuS5
 yBt90MRC4iNi4VF0i+/95m6FuqeT9V8jLO+rxmqPampmCL5bFFKURYp/ye3V1qm2yGbL3DZk2rm
 yiAUiIU93QLk/I4dRa04
X-Received: by 2002:a05:6830:67ed:b0:7d7:d66c:a445 with SMTP id
 46e09a7af769-7db99415a63mr1700486a34.31.1775030046975; Wed, 01 Apr 2026
 00:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
 <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
 <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
In-Reply-To: <d37e1e34-8a9b-49dc-ace5-76f23c0375e3@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 1 Apr 2026 12:53:55 +0500
X-Gm-Features: AQROBzBUL17ggoQ_c8L1rGFMdlEb7hWGH8F-hvG65ADndRBXDtdXw3A8WWNL9XY
Message-ID: <CABXGCsMtdqaLEOo3v5h2b3Kmn-1SUTHSU9NW3dJfzKig8=hKfQ@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Wed, Apr 1, 2026 at 12:24=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Alex already applied the v7 so it would probably be best if you provide a=
 delta patch on top of that.
>

Hi Christian,

Done, delta patch sent:
https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmai=
l.com/

--=20
Thanks,
Mikhail
