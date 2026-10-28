Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB1606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OnDulit/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9E5112091;
	Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1163810E646
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-533202fe429so405271cf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
 d=google.com; s=arc-20260327;
 b=HGlVxpC0QGey+A8Li3n/gjJqWmRFG11gqHooqaS/7BcOfQBY3yoOA6mVNaxsk87J9l
 RJ78iBl92h6b4SwkpCb+Sh5SL/XoMgJXGRubUIDByXvkjLPC22a8PqjuEGPrnWsxqxMq
 wyYXcW15Y+CPUjBPGimeC37Ct1rrQHblkZLqHsfVGxZxbgYZO8yf7Pk52PA+XOdcpVi0
 FFddRUF4I1EOhRaZ9ItoYv/4xgIh+VwsxFJH3zQSKLsFXJLnOCeyWvezJiaiL7quwjaQ
 IqwyZuDrv2uiRydg0WqBrM+SoaVwM9jyhX9nWHExHGzENE0su44oKS3vWt0RUGUA5vUl
 t3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 fh=vHReoYhUUXX1bhj4JUai/G5HZJV7gZCDJu4+tqxHY8M=;
 b=QJ6Lds9yRhXsze2hmLcuZv9AlQ9S6EjOlu3HRdpV19iyVAoSRfVxNXS7P1FA3jPMW7
 snX8Za5WYpKCZmVhLdnhgPkvUEC3s+KFRExwjWSpUHbk+t3LXJummTtVFpXedr+o4Fy7
 UpsYGDOu2nmjcQCNH++cRQpKsmNA89a5MDR7DxilKXWn51r43Byl9IC/X8YuDNwN6sls
 jPgfJVIj5CwhscgQmboqoxG0mUOGrrfoihwdwrjAdRu1GF7E214AJhPpQRgrvUv26wOv
 gA0EY95HRNw9wg4S3ZYC9Kgv1MOUbKTh2K7bwrn2/BkMwpI0XBK/SOHzBhqjtbss5crw
 yuZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793201764; x=1793806564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 b=OnDulit/DVlvX17kiS1odIYOm300xQiXaf2zwuqK/L9qEEwsUp+1ppNGhfC10fNFHt
 Tuy4lthdY9XlvPjBHhV3TcWbYnMiFLHNLjn6kZlqhdKAwlKXnB5xvIw+hQMUplW0TRwW
 afrd3H854saNIuamHzAohaVZqM1Y30AdMy1UJ1EEzcz0fQdCyRzkwbsBKSY/9Ey00CaL
 FTkdttnSec8/7Wnp7YVzZkYFX8bp8QF2ZyLxDCd3UwzcrhxpBywgiBuvLuHRK8AxU/4R
 LxdL0ocuuwXG7PWEW2BsmiWX5rA/XOaebINPMEPuiwZA+2hrqhcHgefiP0aru5IN7k6T
 WEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201764; x=1793806564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
 b=OAO06qUfolQDonCnjTN9WZ4VpqewWq+WFG825/Gt/miekkMOqLA7+JeCnnuUqQmSod
 Jm28PvwmSp1ulU+4Bq/qTFm6TWLqE7b52xA/LHjCo2/PbPGG7lqphEGZrSPn/BvTWXYn
 kVzcRAlvumhx2q92zxvm9PAOfBanFjV2hjhapEcQ9sRa6phcMBwW+xk50TNBHFCLdD8+
 h2hVuZu0LZlA6gmMewAi+8Zu4Q560Bbt4qr6Q1piLlNFEbKor67LHkHiU0BXBc0U57n8
 qopWsELEbWoGO4UmJVZHraAULBlBjUFPR+C8+aCeAll8F2PaQhr223dZ0+6uu61EHASK
 DttQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmd1MDjmb7RHoT9mZpGGt5a9mdggIlOpQxaZDsMALdbInV7FMZXk4uO91+hkBxVbGS0fCvWUxY@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/PZeUS7CtqHwNYVouKsNqRyiLawrb50MRtin1RGdYIT9j0RFL
 FssyLnf+9iQpG1HYsfZHTC9hxrlL4N4wv9+zjPB7CWnimqz0AxKwVBl/+5mskGq+IwDBTf92+WQ
 sO9QxODFsqv82RAH9q2gWL1OtZ+oqvQgR+tg5TfHr
X-Gm-Gg: AYBFou3fK1PIcIHVXGChCnDE/3Nm2NOO3LQTH4GyyW717L2TiB6ChoDzKHcTgrkEIL9
 3gt7UuisyBttIuxeEsYfw6CIXwg60NRwo/5DhWdBR6HuIMnme5Rw45OzV99e9va6zoaluPI5L43
 mbrZI4xXGpu72laplZme6o1375TuFSpwyBDrCAeEoA0//zk/3u+lZGndx/9nvdzh7cZjiLsGS2r
 ssqzYesWeYsAnw+8XcSqSmWGkdlwq/h/PcBw4hH5zxB+zpu8zeBCR38rRPLsAXapVDZGKy8wJmT
 bmFzyO8JRU7PRz/kpsWHy7etb2/DrNOU05j5lMI7Zyx3Yy/1TZE2rAUwVxOOnoJUvx6Srg9V26v
 yeuD/PmSY5FkQYqpiNPKai+aL9+fFsnQTC8+p+pvCcF0GwWvR8VOLChnvQrs=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 08:05:22 +0000
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

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
