Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 17:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E26810E45D;
	Tue, 15 Feb 2022 17:59:46 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70F410E45D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 17:59:44 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 s6-20020a0568301e0600b0059ea5472c98so14292351otr.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aRfEFeghnIX5Qayheb1XV413Coeied3jt4BwpJdAsEA=;
 b=B55D9mfrY+y1qNt0+4uU5qzR6n8kfveX5kOwY7ijTzHVTEnLunrOllan4uVaBdhCKa
 7y4qJYQYEIzRtM130Lx/KL6YJGC/O1oNNR7HnRLL1/r+k2WuNtk2FTT8h2YUdWBmvvZo
 5phG9j+K6s+/jQzmwpGv6NuwmM3DOKdXsIelHj95KnzIl6O+3+S0QNOVgLhK1qMMwrOx
 f9oBYDHt7djFZ9UERco2uCl4680S0YjsE1tHgFvIclS8nQNo6d6BnPtj+885B4RukQnS
 ia20ZIinHpWmtmCZ8nWzMzdHjUSrOnC6cjasf6fZO+xQtM05CTlsvvRlBq+evQlnApUz
 cgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aRfEFeghnIX5Qayheb1XV413Coeied3jt4BwpJdAsEA=;
 b=MTEy74Sdbr5jTx2B+TgqxQ8hO4Rxw0UNrRkdu7k9ZVgxe+b9LfIZnj7KRwn1GvpFgo
 miR6kGrm/VNPd5zSQNA7Zz8hTOgKbMf8WL0vEmvtBkK8wCwVoYwNTDmhvJkcSB5o1eXO
 Nu7vMxEpxWmVjpRVJwaI1tBPlVobrMxT3E98k1Y05I+CLuEfZwM2IGsbu785krGbM4n8
 k/2/Bo8kciDOVch1nZIATToOOZvUB6JZ0mZI2jG822C6LTNbvEAHqYxTxKtlp5M4HpI8
 HHO30BglwsdDNXU/04aNuJOd1I75T+soThUQG3J3T7t8JY+Ax6o6haezUQsxjJBtHadg
 f+jQ==
X-Gm-Message-State: AOAM533x0iYp/aTbvPJ3QsqLCOcSTF0zvRFhVaA2zjSqpvdy9hhF+Yc/
 q06r7Y3hj/qn/s95G1dqLZ6VxQzhk0zYETHN30+dUHT8
X-Google-Smtp-Source: ABdhPJz43+wY1NRg63hs5ufW+t7zHQCPFFAj6DI20gO/mgERCeK75uIpENlgr90fv/Sr9RkEBUfjoakuOWbIUwxKkmE=
X-Received: by 2002:a05:6830:18fb:: with SMTP id
 d27mr77302otf.200.1644947984005; 
 Tue, 15 Feb 2022 09:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
 <ba9088ae-e7ca-ad44-e107-105ff5ec4e1c@gmail.com>
In-Reply-To: <ba9088ae-e7ca-ad44-e107-105ff5ec4e1c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Feb 2022 12:59:33 -0500
Message-ID: <CADnq5_OUL18dmGYBasOfdJibpx2RYO8Z6CVewT3Gi65gZ-Zs9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

yeah, I think it's better to keep the additional data there.  While
there are some faulty vbioses out there, I think the goal is to have
it correct in the long term, so I think it is fine to just expose what
is in the ip discovery table as is for now.  Maybe add a comment in
the code as Christian suggested.  With that:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Feb 15, 2022 at 11:21 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 15.02.22 um 00:21 schrieb Luben Tuikov:
> > Add the "harvest" field to the IP attributes in
> > the IP discovery sysfs visualization, as this
> > field is present in the binary data.
> >
> > Cc: Alex Deucher <Alexander.Deucher@amd.com>
> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index c8dbdb78988ce0..0496d369504641 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -393,6 +393,7 @@ struct ip_hw_instance {
> >       int hw_id;
> >       u8  num_instance;
> >       u8  major, minor, revision;
> > +     u8  harvest;
> >
> >       int num_base_addresses;
> >       u32 base_addr[];
> > @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance=
 *ip_hw_instance, char *buf)
> >       return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
> >   }
> >
> > +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, cha=
r *buf)
> > +{
> > +     return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
> > +}
> > +
>
> Maybe add a comment regarding Guchun's concern. With that done feel free
> to add a Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Regards,
> Christian.
>
> >   static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_i=
nstance, char *buf)
> >   {
> >       return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses=
);
> > @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D =
{
> >       __ATTR_RO(major),
> >       __ATTR_RO(minor),
> >       __ATTR_RO(revision),
> > +     __ATTR_RO(harvest),
> >       __ATTR_RO(num_base_addresses),
> >       __ATTR_RO(base_addr),
> >   };
> > @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu=
_device *adev,
> >                       ip_hw_instance->major =3D ip->major;
> >                       ip_hw_instance->minor =3D ip->minor;
> >                       ip_hw_instance->revision =3D ip->revision;
> > +                     ip_hw_instance->harvest =3D ip->harvest;
> >                       ip_hw_instance->num_base_addresses =3D ip->num_ba=
se_address;
> >
> >                       for (kk =3D 0; kk < ip_hw_instance->num_base_addr=
esses; kk++)
> >
> > base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
>
