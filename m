Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD489C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 19:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638EA10E17E;
	Wed, 26 Jan 2022 19:14:22 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226DE10E17E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 19:14:21 +0000 (UTC)
Received: by mail-vk1-xa31.google.com with SMTP id y192so397338vkc.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=br0q0nb2tGSU3luJpxAux+e+Crd0mPTlsm5pOlMUMAA=;
 b=DH3g6BAWQz+ApKGF6QDxhJLsCba7NxUsFe01ZVjJbBHBTDgEvTXLwc9V1mIAg+0Ss+
 TucXAo0OE4YcKgFRHT41jYWhdAzqfmWDR75krvklv1Kl8eYkrUn/eXXIFqEMH7/DPqI4
 XaqXfq4bI8n4mo1nOj5UwzteqABFdcWYHoAQNKkcPTVdLvdYBYaOc/4g5SE5Z/XAm9ES
 JOy2zsL1wCqmsWjOMLGYYSL5MNqP8vsdSARp2J3hNZCUtYGbGzLCjOG2XuLBCh1oueQK
 vRi9awtD535vO92Z1zPxLOFaUsxfRJ5JCTzL/kPCIFrjeKTp0/+6kl6DCuybKSkwWuVL
 uUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=br0q0nb2tGSU3luJpxAux+e+Crd0mPTlsm5pOlMUMAA=;
 b=Q5hz9ORWg/ohhfwalggfk+JYHWI1+F7PjuUjmcapCMdwewWg9XS7rySlAH7+I8AbOi
 sm7/8m27g+ar+Z4I79vWRxI1HqQqlnobHzj6EGMGDVuyqW675ROJu4w3TJcPeV4RVznx
 XSE3am4T03L6fwrxdb6qWl2/Kt3pw0i/cJRApZ1KUJ11oOSUZGGhif20CasSKkXppbXZ
 jUtOiMe9uLomIqcq0FjtHZ84yxAyM0AJ43azN82HhTWdfjQe2g5gfVPo5hNgjUj7E39X
 9UNFO/kujFNLCyTK3E6vZRHDDdCMHBMCjAebGi5aiwWyJAby50d+OS4LuZu4qQI/CPUY
 xVgw==
X-Gm-Message-State: AOAM530qXOlEn5LLXIVE8zUcQm2b2VyDNWIl9rurVqYz82n3UDnc2hrv
 Hb0iYiSOAFiPnjf5+BCfYS3LOiGcuzDKXold7jgcUkSl
X-Google-Smtp-Source: ABdhPJyqgmeahAxL/vfkdFeKJf+RPA2ZlsjXnXD8o5rjkeDrWNy1DreoDCxizeRqxS7bzOuc0CTcRJ6ZaRZ6Qb78aA0=
X-Received: by 2002:a05:6122:179e:: with SMTP id
 o30mr219858vkf.18.1643224460066; 
 Wed, 26 Jan 2022 11:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20220125181835.2735521-1-tom.stdenis@amd.com>
 <4a4917ef-a770-17f0-f72c-e4321792eaef@amd.com>
In-Reply-To: <4a4917ef-a770-17f0-f72c-e4321792eaef@amd.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Wed, 26 Jan 2022 14:14:09 -0500
Message-ID: <CAAzXoRJW9fVcjhGiEy4UzfgzzH_4OJxvHK1NHOqd+-HKqi36pw@mail.gmail.com>
Subject: Re: drm/amd/amdgpu: Add ip_discovery_text sysfs entry (v2)
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003a841b05d6810253"
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
Cc: Tom St Denis <tom.stdenis@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000003a841b05d6810253
Content-Type: text/plain; charset="UTF-8"

Thanks, if we don't end up dropping this patchset I'll incorporate your
suggestions into a v3.

Tom

On Wed, Jan 26, 2022 at 12:36 AM Limonciello, Mario <
mario.limonciello@amd.com> wrote:

> A few suggestion ideas inline.
>
> On 1/25/2022 12:18, Tom St Denis wrote:
> > Newer hardware has a discovery table in hardware that the kernel will
> > rely on instead of header files for things like IP offsets.  This
> > sysfs entry adds a simple to parse table of IP instances and segment
> > offsets.
> >
> > Produces output that looks like:
> >
> > $ cat ip_discovery_text
> > ATHUB{0} v2.0.0: 00000c00 02408c00
> > CLKA{0} v11.0.0: 00016c00 02401800
> > CLKA{1} v11.0.0: 00016e00 02401c00
> > CLKA{2} v11.0.0: 00017000 02402000
> > CLKA{3} v11.0.0: 00017200 02402400
> > CLKA{4} v11.0.0: 0001b000 0242d800
> > CLKB{0} v11.0.0: 00017e00 0240bc00
> > DBGU_NBIO{0} v3.0.0: 000001c0 02409000
> > DBGU0{0} v3.0.0: 00000180 02409800
> > DBGU1{0} v3.0.0: 000001a0 02409c00
> > DF{0} v3.0.0: 00007000 0240b800
> > DFX{0} v4.1.0: 00000580 02409400
> > DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
> > DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
> > FUSE{0} v11.0.0: 00017400 02401400
> > GC{0} v10.1.10: 00001260 0000a000 02402c00
> >
> > (v2): Use a macro for buffer size and fix alignment in amdgpu.h
> >
> > Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 ++++++++++++++++++-
> >   2 files changed, 79 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 3bc76759c143..43caeb4bdc07 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1019,6 +1019,7 @@ struct amdgpu_device {
> >       struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
> >       uint32_t                        harvest_ip_mask;
> >       int                             num_ip_blocks;
> > +     char            *ip_discovery_text;
> >       struct mutex    mn_lock;
> >       DECLARE_HASHTABLE(mn_hash, 7);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > index 07623634fdc2..d036977dab8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -267,6 +267,19 @@ static void
> amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
> >       }
> >   }
> >
> > +static ssize_t ip_discovery_text_show(struct device *dev,
> > +             struct device_attribute *attr, char *buf)
> > +{
> > +     struct drm_device *ddev = dev_get_drvdata(dev);
> > +     struct amdgpu_device *adev = drm_to_adev(ddev);
> > +
> > +     return sysfs_emit(buf, "%s", adev->ip_discovery_text);
> > +}
> > +
> > +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
> > +                             ip_discovery_text_show, NULL);
> > +
> > +
> >   static int amdgpu_discovery_init(struct amdgpu_device *adev)
> >   {
> >       struct table_info *info;
> > @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct
> amdgpu_device *adev)
> >               goto out;
> >       }
> >
> > +     // init sysfs for ip_discovery
> > +     r = sysfs_create_file(&adev->dev->kobj,
> &dev_attr_ip_discovery_text.attr);
> > +     if (r)
> > +             dev_err(adev->dev, "Could not create amdgpu device
> attr\n");
> > +
> >       return 0;
> >
> >   out:
> > @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct
> amdgpu_device *adev)
> >   void amdgpu_discovery_fini(struct amdgpu_device *adev)
> >   {
> >       kfree(adev->mman.discovery_bin);
> > +     kfree(adev->ip_discovery_text);
> > +     sysfs_remove_file(&adev->dev->kobj,
> &dev_attr_ip_discovery_text.attr);
> > +
> >       adev->mman.discovery_bin = NULL;
> > +     adev->ip_discovery_text = NULL;
> >   }
> >
> >   static int amdgpu_discovery_validate_ip(const struct ip *ip)
> > @@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const
> struct ip *ip)
> >       return 0;
> >   }
> >
> > +#define IP_DISCOVERY_BLOCK_SIZE 4096
> > +
> > +static int add_string(char **dst, unsigned *size, char *src)
> > +{
> > +     if (strlen(src) + strlen(*dst) >= *size) {
> > +             void *tmp = krealloc(*dst, *size +
> IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> > +             if (!tmp) {
> > +                     return -1;
>
> If you take my other suggestion on cleanup, maybe you can also return
> -ENOMEM here.
>
> > +             }
> > +             *dst = tmp;
> > +             *size = *size + IP_DISCOVERY_BLOCK_SIZE;
> > +     }
> > +     strcat(*dst, src);
> > +     return 0;
> > +}
> > +
> >   int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
> >   {
> >       struct binary_header *bhdr;
> > @@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >       int hw_ip;
> >       int i, j, k;
> >       int r;
> > +     unsigned txt_size = IP_DISCOVERY_BLOCK_SIZE;
> > +     char *linebuf;
> >
> >       r = amdgpu_discovery_init(adev);
> >       if (r) {
> > @@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >
> >       DRM_DEBUG("number of dies: %d\n", num_dies);
> >
> > +     adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> > +     linebuf = kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> > +     if (!adev->ip_discovery_text || !linebuf) {
> > +             DRM_ERROR("Out of memory\n");
> > +             kfree(linebuf);
> > +             kfree(adev->ip_discovery_text);
>
> You've got a variety of new codepaths that do this freeing of the
> memory.  Have you considered to add a "goto cleanup" instead at the end
> of the function?
>
> Then each of these turns into
>         ret = -ENOMEM;
>         goto cleanup;
>
> cleanup:
>         DRM_ERROR("Out of memory");
>         kfree(..)
>         kfree(..)
>         return ret;
>
> > +             return -ENOMEM;
> > +     }
> > +
> >       for (i = 0; i < num_dies; i++) {
> >               die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
> >               dhdr = (struct die_header *)(adev->mman.discovery_bin +
> die_offset);
> > @@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >               if (le16_to_cpu(dhdr->die_id) != i) {
> >                       DRM_ERROR("invalid die id %d, expected %d\n",
> >                                       le16_to_cpu(dhdr->die_id), i);
> > +                     kfree(linebuf);
> > +                     kfree(adev->ip_discovery_text);
> >                       return -EINVAL;
> >               }
> >
> > @@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >                           le16_to_cpu(ip->hw_id) == SDMA3_HWID)
> >                               adev->sdma.num_instances++;
> >
> > +                     snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1,
> "%s{%d} v%d.%d.%d: ",
> > +                               hw_id_names[le16_to_cpu(ip->hw_id)],
> > +                               ip->number_instance,
> > +                               ip->major, ip->minor,
> > +                               ip->revision);
> > +                     if (add_string(&adev->ip_discovery_text,
> &txt_size, linebuf)) {
>
> If you take my other suggestion, you could instead do something like
> ret = add_string(..)
> if (ret)
>         goto cleanup;
>
> Here and the other places you use add_string.
>
> > +                             DRM_ERROR("Out of memory\n");
> > +                             kfree(linebuf);
> > +                             kfree(adev->ip_discovery_text);
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +
> >                       for (k = 0; k < num_base_address; k++) {
> >                               /*
> >                                * convert the endianness of base
> addresses in place,
> > @@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >                                */
> >                               ip->base_address[k] =
> le32_to_cpu(ip->base_address[k]);
> >                               DRM_DEBUG("\t0x%08x\n",
> ip->base_address[k]);
> > +                             snprintf(linebuf,
> IP_DISCOVERY_BLOCK_SIZE-1, "%08lx ", (unsigned long)ip->base_address[k]);
> > +                             if (add_string(&adev->ip_discovery_text,
> &txt_size, linebuf)) {
> > +                                     DRM_ERROR("Out of memory\n");
> > +                                     kfree(linebuf);
> > +                                     kfree(adev->ip_discovery_text);
> > +                                     return -ENOMEM;
> > +                             }
> > +                     }
> > +                     if (add_string(&adev->ip_discovery_text,
> &txt_size, "\n")) {
> > +                             DRM_ERROR("Out of memory\n");
> > +                             kfree(linebuf);
> > +                             kfree(adev->ip_discovery_text);
> > +                             return -ENOMEM;
> >                       }
> >
> >                       for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> > @@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct
> amdgpu_device *adev)
> >                       ip_offset += sizeof(*ip) + 4 *
> (ip->num_base_address - 1);
> >               }
> >       }
> > -
> > +     kfree(linebuf);
> >       return 0;
> >   }
> >
>
>

--0000000000003a841b05d6810253
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, if we don&#39;t end up dropping this patchset I&#3=
9;ll incorporate your suggestions into a v3.<div><br></div><div>Tom</div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Jan 26, 2022 at 12:36 AM Limonciello, Mario &lt;<a href=3D"mailto:mar=
io.limonciello@amd.com">mario.limonciello@amd.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">A few suggestion ideas inl=
ine.<br>
<br>
On 1/25/2022 12:18, Tom St Denis wrote:<br>
&gt; Newer hardware has a discovery table in hardware that the kernel will<=
br>
&gt; rely on instead of header files for things like IP offsets.=C2=A0 This=
<br>
&gt; sysfs entry adds a simple to parse table of IP instances and segment<b=
r>
&gt; offsets.<br>
&gt; <br>
&gt; Produces output that looks like:<br>
&gt; <br>
&gt; $ cat ip_discovery_text<br>
&gt; ATHUB{0} v2.0.0: 00000c00 02408c00<br>
&gt; CLKA{0} v11.0.0: 00016c00 02401800<br>
&gt; CLKA{1} v11.0.0: 00016e00 02401c00<br>
&gt; CLKA{2} v11.0.0: 00017000 02402000<br>
&gt; CLKA{3} v11.0.0: 00017200 02402400<br>
&gt; CLKA{4} v11.0.0: 0001b000 0242d800<br>
&gt; CLKB{0} v11.0.0: 00017e00 0240bc00<br>
&gt; DBGU_NBIO{0} v3.0.0: 000001c0 02409000<br>
&gt; DBGU0{0} v3.0.0: 00000180 02409800<br>
&gt; DBGU1{0} v3.0.0: 000001a0 02409c00<br>
&gt; DF{0} v3.0.0: 00007000 0240b800<br>
&gt; DFX{0} v4.1.0: 00000580 02409400<br>
&gt; DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400<br>
&gt; DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00<br>
&gt; FUSE{0} v11.0.0: 00017400 02401400<br>
&gt; GC{0} v10.1.10: 00001260 0000a000 02402c00<br>
&gt; <br>
&gt; (v2): Use a macro for buffer size and fix alignment in amdgpu.h<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis@amd.com"=
 target=3D"_blank">tom.stdenis@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 +++++++=
+++++++++++-<br>
&gt;=C2=A0 =C2=A02 files changed, 79 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 3bc76759c143..43caeb4bdc07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1019,6 +1019,7 @@ struct amdgpu_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_ip_block=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ip_blocks[AMDGPU_MAX_IP_NUM];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 harvest_ip_mask;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_ip_block=
s;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ip=
_discovery_text;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex=C2=A0 =C2=A0 mn_lock;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DECLARE_HASHTABLE(mn_hash, 7);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 07623634fdc2..d036977dab8a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk=
(struct amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static ssize_t ip_discovery_text_show(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribu=
te *attr, char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_device *ddev =3D dev_get_drvdata(dev);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D drm_to_adev(ddev);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return sysfs_emit(buf, &quot;%s&quot;, adev-&gt;i=
p_discovery_text);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip_discovery_text_show, NULL);<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static int amdgpu_discovery_init(struct amdgpu_device *ade=
v)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct table_info *info;<br>
&gt; @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_de=
vice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0// init sysfs for ip_discovery<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D sysfs_create_file(&amp;adev-&gt;dev-&gt;kob=
j, &amp;dev_attr_ip_discovery_text.attr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(adev-&gt;dev,=
 &quot;Could not create amdgpu device attr\n&quot;);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0out:<br>
&gt; @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_de=
vice *adev)<br>
&gt;=C2=A0 =C2=A0void amdgpu_discovery_fini(struct amdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;mman.discovery_bin);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;ip_discovery_text);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sysfs_remove_file(&amp;adev-&gt;dev-&gt;kobj, &am=
p;dev_attr_ip_discovery_text.attr);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;mman.discovery_bin =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;ip_discovery_text =3D NULL;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int amdgpu_discovery_validate_ip(const struct ip *i=
p)<br>
&gt; @@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const str=
uct ip *ip)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define IP_DISCOVERY_BLOCK_SIZE 4096<br>
&gt; +<br>
&gt; +static int add_string(char **dst, unsigned *size, char *src)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (strlen(src) + strlen(*dst) &gt;=3D *size) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *tmp =3D kreallo=
c(*dst, *size + IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tmp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return -1;<br>
<br>
If you take my other suggestion on cleanup, maybe you can also return <br>
-ENOMEM here.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*dst =3D tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*size =3D *size + IP_=
DISCOVERY_BLOCK_SIZE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0strcat(*dst, src);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int amdgpu_discovery_reg_base_init(struct amdgpu_device *a=
dev)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct binary_header *bhdr;<br>
&gt; @@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int hw_ip;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, j, k;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned txt_size =3D IP_DISCOVERY_BLOCK_SIZE;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0char *linebuf;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_discovery_init(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; @@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG(&quot;number of dies: %d\n&quot;, =
num_dies);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0adev-&gt;ip_discovery_text =3D kzalloc(txt_size, =
GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0linebuf =3D kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_=
KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!adev-&gt;ip_discovery_text || !linebuf) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Out o=
f memory\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(linebuf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;ip_dis=
covery_text);<br>
<br>
You&#39;ve got a variety of new codepaths that do this freeing of the <br>
memory.=C2=A0 Have you considered to add a &quot;goto cleanup&quot; instead=
 at the end<br>
of the function?<br>
<br>
Then each of these turns into<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
<br>
cleanup:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;Out of memory&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(..)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(..)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_dies; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_offset =3D l=
e16_to_cpu(ihdr-&gt;die_info[i].die_offset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dhdr =3D (struct=
 die_header *)(adev-&gt;mman.discovery_bin + die_offset);<br>
&gt; @@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (le16_to_cpu(=
dhdr-&gt;die_id) !=3D i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0DRM_ERROR(&quot;invalid die id %d, expected %d\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0le16_t=
o_cpu(dhdr-&gt;die_id), i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(linebuf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0kfree(adev-&gt;ip_discovery_text);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0le16_to_cpu(ip-&gt;hw_id) =3D=3D SDMA3_HWID)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;sdma.num_instances++;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, &quot;%s{%d} v%d.%d.%d:=
 &quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_id_names[le16_to_cpu(ip-&gt;hw=
_id)],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip-&gt;number_instance,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip-&gt;major, ip-&gt;minor,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip-&gt;revision);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (add_string(&amp;adev-&gt;ip_discovery_text, &amp;txt_size, lineb=
uf)) {<br>
<br>
If you take my other suggestion, you could instead do something like<br>
ret =3D add_string(..)<br>
if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
<br>
Here and the other places you use add_string.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Out of memory\n&quot;);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(linebuf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;ip_discovery_text);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (k =3D 0; k &lt; num_base_address; k++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * convert the endianness of base =
addresses in place,<br>
&gt; @@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_=
device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ip-&gt;base_address[k] =3D le32_to=
_cpu(ip-&gt;base_address[k]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG(&quot;\t0x%08x\n&quot;, =
ip-&gt;base_address[k]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZ=
E-1, &quot;%08lx &quot;, (unsigned long)ip-&gt;base_address[k]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (add_string(&amp;adev-&gt;ip_discover=
y_text, &amp;txt_size, linebuf)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&q=
uot;Out of memory\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(linebu=
f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&=
gt;ip_discovery_text);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOM=
EM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (add_string(&amp;adev-&gt;ip_discovery_text, &amp;txt_size, &quot=
;\n&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Out of memory\n&quot;);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(linebuf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;ip_discovery_text);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (hw_ip =3D 0; hw_ip &lt; MAX_HWIP; hw_ip++) {<br>
&gt; @@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_d=
evice *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ip_offset +=3D sizeof(*ip) + 4 * (ip-&gt;num_base_address - 1)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0kfree(linebuf);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--0000000000003a841b05d6810253--
