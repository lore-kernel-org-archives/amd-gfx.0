Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263D60A2600
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EeBwMfDh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE5A10F20B;
	Tue, 10 Nov 2026 11:44:09 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1DD10E116
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-535f598d126so39581cf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
 d=google.com; s=arc-20260327;
 b=B6wmq76REmJxUKxyWIB3dN4hE4uccHhxzz5By8TKJ0kh3HyWWDyuubfUWnQbUAdkpH
 NhPOrMgnyDmjkAtbuYEIuj468Cu7dTmcGaqphSRsuxb8mJ3a8H0xUAHzz8BXm594J+yT
 RVdog9I+q8wt46vXBkb+NmGken/UhYiYWvsF78Vx5PwZuikel09ioRlZxSAZ0EbMtbdH
 wV8c/alpdOWvKvz+ffoj/G2APLxvYdXQjUpfGZwXwSBrCwFNOx4+utSI3QVL4rjvk5xw
 AYPL39TC3buQzECq0UM1NRGfwi9l9GCTYU0zoKsUY6DAQ+VgWNai0K4ChNWImvGSh+MZ
 H/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 fh=1ZAhpGtsUE/20poXUbgmDJ9HmFBsKM317Akvg14p7F8=;
 b=ncX95ei/UFxM5k5k9LNWHLkX4p+GbP6EZIIUeHX1D6TlXwWha+KBl0qhslT77LXBtw
 fhrbiGIcgQiTaTKeJWnW/V/V/BEwL/c7DysLICkhS6/LVs3iz1nRINXWsbfIWVpRCcp1
 CRTCT2NbSZrvGXAtey3SfRvo6eEIsUV+qZ0kSCH6SjaIKy6roNqRvkpVL0Uz2PlPvgfz
 3OI134fzVXBxaByTgJxReQAodED1zEaXP7gc9rWyH+ToMSdVrcZxqlqwJbcWkEBzpZot
 oH09qNBoyQ/nCsLbpWKGt0lFGbUCkpxmTqKjyE/6VT9nfCsSNBtL4m0BnKcpUpxx4ZVN
 k9Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794263408; x=1794868208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 b=EeBwMfDh4Cmh6OOfmPKYL5tG9yOeAoN7gd5IF8LUkWrJHrIj5iW/kTKa8Quc+0t0e7
 v0x73wPQ7RtCBIrsiV8DPFS64Oa105vPLa8/BRpY5LGTg1V0ihVDCSsn5+Py+cdoq7CD
 mTpSKeeqfa6cIQbIcGl4chBPlaDeEEWtZWlsALFUnl2QVNOSQybSRz+m1qPt3pv6BIIX
 5oFa13ayFtQgLs9xmH/hOlsQnoRziO8vbQF5tXz91ezbJ+BLNlsy1aOiux0zs9al03aT
 X+63FU3gZC+LO7y2XbRrq8Pwskb8n6MA4SEM4uwxw6Ei3a+7TeEoK54Ly2n9dNW52YpC
 6Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263408; x=1794868208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
 b=pireC/RjWfqEMwrxi2+lCypFV6Wmlf7TFGotS9s+FlgJxIBHnDO3cFK+bsKts+RJjt
 REDeyCQvPyYDXFyUR387qkAoFI61Jp/oTOdU6xlL70VgrPJVDDwnEgC+V0cEU77EVbHn
 UB/auuW8D+yIhGkYwMNW4BaHYVoK/sQn2aZ3izLIjupCwZV6Cc9BvkaUWgY5JmochNrs
 u8ajEQbA00KJAUOEOTHZoILhNa2IbvEMZTKiQ5z8DZY5JBHNmGP3Tu3SFqeBuATujSbF
 CnszBUFyjNpIhZuQS+cwoWRApcJcCt0EXDfjx/0+N7bw1+7Sw6yeIx02wEJI1c7lv4Yn
 qFHA==
X-Forwarded-Encrypted: i=1;
 AL+hErFX9zpSjpYqSUqzDE5icqzvpR5odmFLIxXw05AErOzO1TRNO3noxyszyZuHPBJFHlI1VRfAtpa9@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Bmi+M6J6MNmjPegj5EwYGfz75MIbHolqgAw1WnwTlKuoleFTP
 WBC+ZM37zRO8tSuYHwDg8jWtislwjkrcOugp/yNRW5LiQJ351TjCUUavFE7KEUVB24V4RaYwS8E
 6lMAKV4CTMi1UOPX//dZYD+YRnRk9Se/sjoKrnJfJ
X-Gm-Gg: AYBFou2YxOUXHsyZzJI1dten5oa53nBkcqBqWlXROwyJg+9X9ARql3ez4yFMmLpzHi1
 H5F9WlGThsqgGL+fUAeSQeVf5MdiWJrt9avDuC4Q/urw1VunDoboUIZ/V3nVHs+KCU6aCtLPVfL
 5/XEFEYFivOJz6JNAaLZOORtHIJZZ1IdhfTlHvim/Wk+CmFlZAbECkwHqMJER03BcjSn7eofCtB
 /PQ5KFnTpSccOLs4mRSDZHACf9cXYZCHj05SLDEo6d6L+cjDKyY5cjhwiqQZWY5cvPp+rc9Qjvi
 wvDPthRmS1sShE1yUiD078vrOiiNydi0tyBNbnZ14Emo1AsUa9N7KdFafjyYETamsONKSxmxUTt
 4LowGTZkb18IgQAKNajONxsY40qEouqlfhnmsnSVt5FVDOGtY56L7/mgfaPq4raQJ1D0=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
 Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
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
X-Mailman-Approved-At: Tue, 10 Nov 2026 11:44:03 +0000
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen
