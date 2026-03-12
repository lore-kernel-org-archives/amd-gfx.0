Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB0106FD9F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BDE710EB41;
	Fri, 13 Mar 2026 08:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="homXtovm";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D151710EA83
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 19:15:46 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so81945c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 12:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342946; cv=none;
 d=google.com; s=arc-20240605;
 b=VxA5AvOYuKP18eW+jpSxOUTH43zwsXfP+bmsDP8T7aSZDspotF8yY8Y96Wzd8OoVuk
 LWea3QZ+1s0rS0sgdw1t9jYT8a5ZdDSOH306/4SIsRqQ+Sc3JcIHzPnT/P2vnRM1YsQd
 WYwnXCmQCdmymHtxmUIfoZ+pOZI5YwWOMB4Ue2HLsDaV3bESjb6yxaEj28z2uTw9kmWj
 3aojC4ZEG+ybNqRt4Yu658jzef+g6nTEsthwsiVsV9EDomZHMsORDn6U9CNQIZ5qMK7D
 EBdkbBlYOqE4tBbyKxUi3C2q2mIueQPPFAUU9OhOTdRFzb4SlSRD66bbbc1okSWMI18/
 g2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 fh=/O/n7rzcKQc9i+LME983roHkGod15JNfnDb1VgkR55U=;
 b=aJFfI3BipK5+aU+PjzkykA46pxNCNlxHf+emV4m86MylRZIpRe8+NLXUFEo6vJ3eEc
 T9FMhh2ec3w/jL0RwTRUwW35S6O1vKvXoM8mHG7ned+Kp3qJYNORDQTsq84Z+YyAzx28
 Y10LpFCVt/PrB5aOUgVce1JfuREcwlY+XW6LdjxQjSelyWEORKxmWFT9gi4xnWfzEUAz
 as6UlAupg1etRHgb24GQR18QctUO/eSeAF8Dx/Ua2pWGkDELUAtxE3KXQ8rxNemEmcAT
 K2lHjPoL5ilvxNYtImF/Bz+4ByiSIF/Q17jpnOIITbNl6rv0ZNGqIK9vIhcaoX0/1DSB
 Y/nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773342946; x=1773947746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 b=homXtovmL7d23e1KalTVecPCknznywPIJhKJxhlfi9r/A8gMAxe1ycrez11l4fcHPC
 UGvAcbrIPdP8O+4oEK+JchQu580zby3Tlf2fh6+ztzz+HhH8wE21U6foC5E2j5gyYoFM
 iVKydSWkzJza/5PFWOm3qlqzqrH0RYniiCSWHJ1PfXLSa0w+zNGzVtbdj14pTcR66X9s
 PMwush3kC20A/nl6ZSDn+yMNBkGgnQh7jo+XNOknpROw63oeMZPgx2RpLGBP9QLTA78P
 EDwErEtf6ttnw7STJmy01IEfICVkOTw7TU9vyyi7EmAcaP7446w5CnqMgfCZ9NDSjUeO
 zzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773342946; x=1773947746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 b=BHcGcLI6ZW+zRQvZAgVmOPZL2Z/k9WysNBPdNUh7n68G+s46WKURwp2mhaN4lUbFHr
 2tuUq6nRm2XAJ4atqScS0CEeF2OTVbSMJCFn4R4A1fOuY0RxFv3IuKs17/11mtJi2a0U
 EDehAZ5Sy8gnNgEe9W/VZtsLpCF/cViLhe8A69AuStPHg24v7fR63pCkJONogXva70Pp
 1Ts9mJkr20K2Csxw0H33oAVZ5Nzk8oR2cY1d8BUEO8O1qVCK2fHQAMZfS92t9dOQZUvC
 JQQUpd1fo2B8U97dTMouXKKC0E6hH9iNq0wsxKUuHzqimhwTPG8WToSKRUtZYeK08uQz
 CJ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt/3TrT3ks0qc2L3LGmwmmUQqvTABjKffSNWUBj/j8PY8iYKGyjMylqXLoW7lpu1uPCVjGSrCu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyChA5f1Vu9ASNIHgWTdviQLfsMbZv51Y3xxfAMTX+Ler3WTOSL
 PCIB56tc+3jWyjZBgjHcVwFVsTgV7Z/UHktBXz4u2DZTXP9Nzn5ZZMe7DWhESHPoerfYtg6mHoA
 zxKix5HiWXT7R6A4r3nv9dsJjBZ5QZ7M=
X-Gm-Gg: ATEYQzyCqPomSGO5fpniXTsJ+LiB4BFDAJuDLHtaIU9ruAVhHBmhXW38peDEvxfKi3p
 fSf0sI4/wzrQYQOUz2HsS8vbcCnAD0fN+W8JcIHPISb4LLCKjK2RhzXySTvb5DfzM/p53Ht9uTq
 H5xh1T2U+R+I0WTMIIKouQrTxLxlOfYT65ytwiGtcDpMs9tpFUXDjkQ+X45MHpmeuh921RPJ+Rr
 DIRVJjRJNlfHfdmdbQQQmbaTKUyeCPJxIOlIMOTJhIofAOmVUjyAEBdWlqlH5zljZq9n41q8PeS
 j4pGK5MUfj0m1iEegrnWk1RfkpfQgOdcN/6csVDE5qLikxb8x61gde3DC7tJU1DjRtrz9vA6gdj
 w0uT3vbPkU14Q/1h4KQKAHHY=
X-Received: by 2002:a05:7301:1924:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2bea555c8d0mr231898eec.3.1773342945899; Thu, 12 Mar 2026
 12:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
 <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
In-Reply-To: <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:15:33 +0100
X-Gm-Features: AaiRm53560zXAmoL0EVQHDBxYh33LaVByeeBz-QChPDevjdBJ65drv5v7FGkL1c
Message-ID: <CANiq72n6ccEz71V3nkJxtY_BNbTw3F_eekt+Dyhvfb1FNP-srw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Dave Airlie <airlied@redhat.com>, 
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, Nikola Djukic <ndjukic@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:55:39 +0000
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

On Thu, Mar 12, 2026 at 6:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Was this given off-list? I can't find a corresponding reply from Miguel.

Thanks for double-checking that -- it is fine.

I am sending some nits and Clippy issues independently though.

Cheers,
Miguel
