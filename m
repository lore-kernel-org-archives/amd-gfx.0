Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7A606A332
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RdK6p72r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E95C112471;
	Thu, 19 Nov 2026 14:11:25 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DDA10EA9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-55be673e029so117321cf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
 d=google.com; s=arc-20260327;
 b=GTMZWFm5BW6pMN8hwezNBFR10iYTH9U1uAFKWewuPnRedG1dIx1i1qchqJA5DvG773
 J2LRzyggGb2obuNq6QRRjHjeCYNikUlFyW7mGvb9rxfolbCAA6sah6wQ1j8mxo4qS6xQ
 ClDwthAZI3e5jtSBUz2xnrMKNegQkPYJWQmqTQKzgsxHLuIxzoEJJVixQ8ExONpZTcU+
 1EaSInRKen4y03ExKfcNdzcYbPi1OyFbNMvBNv4nAXh1ihn+M8AMdSd5u4wZTrViohx4
 rU+Fa7ztMHxArssK9jfFn4gcEm0/ZaHGH8GHTSnJ9q5+LPEqA8Q7IBJg59G+HFB25DUa
 TCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 fh=EZCvVrv7mIQRMKLtMgqheXr17j8D8RmKDmd7FauMaC4=;
 b=YUakOTieC65154y0oz/Clop1xvwU5etGI02xuPUeVcXg5foAz7VXwQGZLy75/UpzGs
 B+Vw5FXi1mGc5NqHTgpJt3bayLA7h3vG1EzPGEh+Vmirp/zfJr44ai5c5PvlT8MW3YMx
 Tmnae7FTA/tjFNoBq7xA/aNWMPYgOwCPYK9XGPrRQFXNCdfbZqD/XtG4GAWYUZmWwOWy
 tb51fjKS6WbFZaPaa7FoS9aIYhYnBxQ+W9qXlwdXv9Rob05P+7p2CmCXyqWLFv6sJzcz
 mYwwE9kmD95CmIvsmTm1FCnmduutUed9Z7851JXi8n4GoJHsm90Hv+xLUU5otdS/AJnG
 Ss4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795067158; x=1795671958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 b=RdK6p72rDxBl3a+RRoe+4d9nB67OkqHnrvJa6hds/RHNthdElJ+591YF5PyXfHVArP
 pQ2igpBBnNSglFmgMMQfNX9Io1gdBOKuPo7I9/GjgnP3oDPsrqSDlwrk9aW7/fMKvFi0
 nxfgNZ7/yInih4EdWS/SOGTo/WaMvwngcRPRjImZxgN582otGkqidnjNJYV9qieNCYDh
 vLOEHIa1nYngtIW3IkvtqhPrbvYWvejBCyM7WYhSSAUQzyU/uesRSwjhZ3YgkHAPcMqt
 saJF1nViN+J2wYQocTALx15qXGIrfW++jHSYsZRJhg6YsNIfZUfnaiKemrxgbRV8HUgv
 1Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795067158; x=1795671958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
 b=VaTSxP6FnpuyYL2OtMkUFT2sd9QzBEDWRs5SxTOn2Dx7PO1B2d3E6xUFiKnlXd3qO8
 HV8XBe8fqCVjCUj5T9DjCihnhk5xFwlK9hvZUgrsEr6HQlSql67uPVJ3iuTVpOpADGWC
 RTO38j1qkUFbZ0PgSFJHoBHRdzo+GWAyxeWKdwsRuC98xp1BAEyzV+ck/N/t/3/Zb3Kk
 El3TudvF3R0rHnm26rb2DyPfPYKC1i59bmF3Ky/L2sBN8dpFFW0spBJErADMfTe0Q4Dq
 rSCXaFszGg3I01BMkRd+Y1wjhXhxVoMGm/CUyWG6OG3VpBZa1plz1ILl69z5qrIb0x9u
 vR2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFcR6tf1xJtl0a0DJkUAuHMjYY9kE3TC1PeXTYVYSgVA9UzAF6E5Fa9lOqtX7h22ZCOFB7kqqHp@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9I/K6shZNhY/InLpbX+XKRTx8NUZum+SrefItUucXmpTaWmtOP
 NJysgahPQ4pZBUC+QJhmdxI+Nd6x3MPd5TVLhAIaco43JrNyNqP3KQWw/Z/49bH/mOOAooOKkhr
 pCwZIce6g+Bu3T/OMLesHP/acs8llrPg/Ska91boY
X-Gm-Gg: AYBFou1yF/CWeLfLP62RDiCYt7Vya9876J5RTW39EN2SLxH0g1JqX5CE+m6MWmdYuOe
 2NIGafsfcAw6KGGicoXFX+ILRFoF+pNPbyxgChdzUInx8f7nKQYPCPLFAowwoKp9CFWU4G+AHVH
 rKQC5viXm0OSXIGV5RRsuQef6F64V0Ifbea8PTpWXC/mAj6aaI1B51Kf9TidS8mUF/riqUy5Fo6
 bmJJo6tEYhtDRJnhvWvMXIbhMSgPzVQLtyC9PLy17Ym1rKNbSAJKqgPPI08zKn9cn36oQjwskHM
 zG+7RRUxAlL4v345JBrV1zk0uNtzCxZFE28ire76wqzwolRbnRd7gdTJG5Km9TrduFSFaxAOWly
 2NMqI2wvzSRaccenD8jZT7TY3ahEAEejhBv5n
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct
 kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 driver-core@lists.linux.dev, 
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 19 Nov 2026 14:10:22 +0000
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
