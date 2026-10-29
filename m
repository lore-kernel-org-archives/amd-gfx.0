Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73060A261A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMRLKxaH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D060811229B;
	Thu, 29 Oct 2026 13:00:58 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE4311226B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:00:42 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-34c522572bfso308674eec.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 06:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278842; cv=none;
 d=google.com; s=arc-20260327;
 b=eqk4PKA2jLtx+bCN+xB8Aegi3Ol2n7BRlAtia1X8mvgKW5T8N1185jkUW/511bgUsM
 grsavyvn9qWlDbQFGTP9NPTLK4XU6UBJocfAg9UZC70Ht8oDge4y70tccAFz3QCWsx+F
 oiojb9jrzWNPd7kV1UHotGpODMbZYqtCBkJsL8J8IGrt1jLUmvBV3jqncx7EEbtKs7U4
 bPc5U5KmxhXc+cSsY+M88GY8eplthI7c/2ABKAuPNF8Q/8QeosDuL44VdO4rMP0TYGEJ
 vP5BLdFPhNsX2Z51NZrpnxwcMn/pe7uJ0DPiTc9Eb69r8udZDVO0n6sc6sJdV6x3Wlv8
 D0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 fh=rK8pxROhMV2Lh9fvGon5ws2VafXKwdp0OruRUEzJkbI=;
 b=rq4R+BWvc4trz5ykKuJzipq80+cPHEQSeS5OXpI8YSKSERXLdCEtyEEmMeaCiEJg2l
 45YzNCi4HhSVQonmf6ewdijLgQd5edEcMfeX2drNda4GNNmz17Y0pQOF9MOZMEbmkoOB
 XnHvYswte+dpiIHsXbaaEgCEkbW25Z8lxBs5Hui5GiRgO1GRotKOYowtjH7iVCA1Eohd
 CiwVcZ8oShFUJweNW9Qh/x1E0I7IvRDzCD35Pk041GB57LLiks1DxbvC6E6FHOp6AK55
 4aXz5AG+jYrDFiDeQeJE3unpzQ5CBLgNn6SN2B9yCgdRBPLC9asV7XsEZ23Zr25355nK
 JgmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793278842; x=1793883642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 b=yMRLKxaHq4LdkjtwSPrZYeax04Cn0ZHUF3yyqKxs8ebgDKfRvb2RRJXwyqruYtsrmU
 qd15avt/VCjfO5v+xM+vZZuBRXiuUvY8WDk9zJQ/qvx0NG5qRa28gSOeXvo2F7PKLOy3
 CErOf7wboJ3ri755E5b9HDe2z5mHHOb6MsmWrtwZ+z7kVd0/wcsVmmMcGNJ1W3f3/0Ba
 1h3aBcK7eRK90WbnR1UGIOeMVTwK2D8X9UVa43ApT12UuKWK660V1PtVcB9W5LRtP7DK
 42J3A/TQD/5TvPZpdgHLwbBalkGZqx1V6pJP/+zmZ7Kz965mdtCMjLFusovA8yCb5U6D
 jDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793278842; x=1793883642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
 b=yC3/v9vwIWrov8AAl9DtUSQ8MGzrHXsT8yST/4Npgb40cPWAy+SDK0ufyFn6Imr+Eb
 5CaZ1ZKHKQtAN8NRba68j3r3c0pt9ytiYrs/cgPUKBLYQNtV/I8slJXzsypViH384O++
 7ebgsIxvq0VfmFhpNhbJqIwrIdNLrpNgNvCnoAShLDJh45qQ2XWIoWfBj8uwq7MVoQql
 lIz20Ywli3ajBCcBGr9YwCkm+4Op5kMoD0DpPwhVuzYyFW3+mvxycpFPu1hZ6rTTD/VX
 +wOECtQC+mA7k3CAr5mvJqYSdXZ5UcyW50SWoNmHPTnaTR90p+OXjtGc4GqzWGfjw+JG
 Fwbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcXduoLP4/ayDGNS1TPc3XL02mpAL+aEzugLArPhJd7Ob1YnWBepIo3mGYZjzSSBu/BTRZ1E9O@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ36TbiAqzIj3pXsH2Bl4Y3jsPuJpSJBlKTBEDalHdNDsUGwo0T
 mwy0TDgf7PO0v+5yVo4eu5+D1Rpc37ajT7u8YZ3Pq1hCDNkZl9ZhCqbq6w0xwiP9nEjF6dUDa2n
 intafSd4J5C9U8unVFsdfXUtzinlFE6w=
X-Gm-Gg: AYBFou1+TLvp8H9+XC9QMVQJh4NgqXqYBO5RmAV6iNd1K+prIboQotDDquBuiJVu2Rp
 DJbANdeTCvyizN9ENBq7HaajyGLMREX2fXJzE6dJKlu57WN21T/MOOIlmN0bp5XaxBNoINHvCBG
 zsZuRZGsfewsAozxBdjeAB/R9WY4an0DsoAmcrp9Zyc/gOTTmjRfUXIsxJuyODVqAMS3vmKKGIB
 LgvvR09ZQ9FX6xZ1IcahoHfQyCQz/x1JLoobRcxKtwtn7z/2ij4pNzfFoIk3oyqitWqZLnGi9jr
 73FZ0HK1N0jS44qXhRZoL30Hosz10hCHmgGvmkFoT3/j8MpkV2f7TCNrXq8VOHka082Wv0jfsOH
 84ORcqkIO4uhe5khKfEa2N5B9Sf58GkUzLjqfUdNkyGORSVeo34cpDWX4fXALz2QLOhkeJIx3Sp
 7W9Hjf48TEF2lIAAr/lFH9r3uNpJ/ItCPhcoDnmFI5nWcJcbA7UMcAA6O8/5Vd5StwsDwDuNpVW
 3isc3w5LAILJRau+o2SdooNbDSuxQh2qu8hjA==
X-Received: by 2002:a05:693c:4196:20b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a202cb0e4mr12034617eec.2.1793278841146; Thu, 29 Oct 2026
 06:00:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com>
 <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
In-Reply-To: <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 14:00:28 +0100
X-Gm-Features: AclHuK_VOCF7u599iESvOsHhN0DoC1VeK-LagvEMwpUC6WNOUUTl411X-macJoc
Message-ID: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher <alexander.deucher@amd.com>,
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
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 13:00:54 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:32=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Should gem.h now include <linux/compiler_attributes.h> ?

No, it should be included for you (unless you are doing something
custom with the compiler flags etc.).

I hope that helps!

Cheers,
Miguel
