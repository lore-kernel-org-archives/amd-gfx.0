Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FE010E1A1;
	Tue, 25 Jan 2022 16:40:06 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD4010E1A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:40:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id bb37so32098300oib.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MUEjQ8q2rLDcfec63OqfasVusI1JjtiB/r0ZULmRGfs=;
 b=XF5OFMK0HoAGUt5hI6+jR73qa3W59vtLFC5VuP4QDgtde41j45+kp3wMro138slEJ5
 a1Qsc0XFXZwct1jAtQY4LUhbgZwNi90Jvs/s8zpCJUhfJuvJRpL6Wb/zPbIvYYf36a8w
 lmsqq75gnbuII4ORyy+r9qM/Hqts8bYYHa54Z2Bwp9zgFcaUVKK+wPC+4wn1RR5M6vwa
 J9FsBoprdaBlskYjSbhou0SmfJrYYETJXqkIM8tPn4VklosvbbC5qC/ZLbm95Q8+Zv5f
 x3kV9UM+ciq+iX/8Nlh72myjHWWTPky6BjMSv0r3c9ezNRVA1f9cwK3iDqvLa+jpkPrj
 /oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MUEjQ8q2rLDcfec63OqfasVusI1JjtiB/r0ZULmRGfs=;
 b=kx/lteqd4sSVBJyILouDH4XPNbl5sCZaNwOspYdSZJGOk23Rs0hvQT3co02C/FaRw5
 U9WTECcF7cgxKej9T+IntI0XTmQQ8HhAAMLtOR3Qi/nPHloHyI6XRlLxF85n7jXwFM44
 8RO7EVyLyMdMMuV4pF7qjSILWuUb1V0N3IW8n0YP7LCL14DcR69FBCwNVg8q064a/xP6
 OMlgQDAjt+CuzTNRuKoHvXdgfuswwGfycUI/KLWGcaZW+52w54hxuMkfjh+SV6KMMGEw
 8Z8gN4jpbfXT9EboCos+h3cj3xkbgdLER2XKY3Hb7gDzC1F+w8dMGEnQaGrnSqWqpKfS
 MGmA==
X-Gm-Message-State: AOAM533HV7mN2pEQPXl36Tt4G97sDpIJginMxf36iPc2kr9jsN3CsfDv
 DR6FOEIjQhxpyWds8GjUGcifQYtezo4Z8Sw3xepI524gYy8=
X-Google-Smtp-Source: ABdhPJytA6naab/f+oefa4iRUmPAZ+HOCBNksQFg3PPqzpYWSFmOp1rNA38AMiMeVmHJ9llUUmBGGh0K65gzEdymJfI=
X-Received: by 2002:a05:6808:2097:: with SMTP id
 s23mr1165157oiw.132.1643128803200; 
 Tue, 25 Jan 2022 08:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20220124180736.2646458-1-tom.stdenis@amd.com>
In-Reply-To: <20220124180736.2646458-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 11:39:52 -0500
Message-ID: <CADnq5_P66evR0jLhVOg7DmmKbD=xJ-gym0id9ud=s6PTT04G9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry
To: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 24, 2022 at 1:07 PM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Newer hardware has a discovery table in hardware that the kernel will
> rely on instead of header files for things like IP offsets.  This
> sysfs entry adds a simple to parse table of IP instances and segment
> offsets.
>
> Produces output that looks like:
>
> $ cat ip_discovery_text
> ATHUB{0} v2.0.0: 00000c00 02408c00
> CLKA{0} v11.0.0: 00016c00 02401800
> CLKA{1} v11.0.0: 00016e00 02401c00
> CLKA{2} v11.0.0: 00017000 02402000
> CLKA{3} v11.0.0: 00017200 02402400
> CLKA{4} v11.0.0: 0001b000 0242d800
> CLKB{0} v11.0.0: 00017e00 0240bc00
> DBGU_NBIO{0} v3.0.0: 000001c0 02409000
> DBGU0{0} v3.0.0: 00000180 02409800
> DBGU1{0} v3.0.0: 000001a0 02409c00
> DF{0} v3.0.0: 00007000 0240b800
> DFX{0} v4.1.0: 00000580 02409400
> DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
> DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
> FUSE{0} v11.0.0: 00017400 02401400
> GC{0} v10.1.10: 00001260 0000a000 02402c00

I'm not opposed to this, but the general rule is one value per file
with sysfs.  Maybe something like:

$ ls ip_discovery
ATHUB CLKA CLKB DBGU_NBIO DBGU0 DBGU1
$ ls ip_discovery/CLKA
0 1 2 3 4
$ ls ip_discovery/CLKA/0
version offset0 offset1

Alex

>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 77 ++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc76759c143..6920f73bbe73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>         struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>         uint32_t                        harvest_ip_mask;
>         int                             num_ip_blocks;
> +       char                    *ip_discovery_text;
>         struct mutex    mn_lock;
>         DECLARE_HASHTABLE(mn_hash, 7);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 285811509d94..c64cab0ad18e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
>         }
>  }
>
> +static ssize_t ip_discovery_text_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +       return sysfs_emit(buf, "%s", adev->ip_discovery_text);
> +}
> +
> +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
> +                               ip_discovery_text_show, NULL);
> +
> +
>  static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  {
>         struct table_info *info;
> @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>                 goto out;
>         }
>
> +       // init sysfs for ip_discovery
> +       r = sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +       if (r)
> +               dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +
>         return 0;
>
>  out:
> @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>         kfree(adev->mman.discovery_bin);
> +       kfree(adev->ip_discovery_text);
> +       sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +
>         adev->mman.discovery_bin = NULL;
> +       adev->ip_discovery_text = NULL;
>  }
>
>  static int amdgpu_discovery_validate_ip(const struct ip *ip)
> @@ -382,6 +404,20 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>         return 0;
>  }
>
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +       if (strlen(src) + strlen(*dst) >= *size) {
> +               void *tmp = krealloc(*dst, *size + 4096, GFP_KERNEL);
> +               if (!tmp) {
> +                       return -1;
> +               }
> +               *dst = tmp;
> +               *size = *size + 4096;
> +       }
> +       strcat(*dst, src);
> +       return 0;
> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> @@ -396,6 +432,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>         int hw_ip;
>         int i, j, k;
>         int r;
> +       unsigned txt_size = 4096;
> +       char *linebuf;
>
>         r = amdgpu_discovery_init(adev);
>         if (r) {
> @@ -410,6 +448,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>
>         DRM_DEBUG("number of dies: %d\n", num_dies);
>
> +       adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> +       linebuf = kzalloc(4096, GFP_KERNEL);
> +       if (!adev->ip_discovery_text || !linebuf) {
> +               DRM_ERROR("Out of memory\n");
> +               kfree(linebuf);
> +               kfree(adev->ip_discovery_text);
> +               return -ENOMEM;
> +       }
> +
>         for (i = 0; i < num_dies; i++) {
>                 die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>                 dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> @@ -419,6 +466,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                 if (le16_to_cpu(dhdr->die_id) != i) {
>                         DRM_ERROR("invalid die id %d, expected %d\n",
>                                         le16_to_cpu(dhdr->die_id), i);
> +                       kfree(linebuf);
> +                       kfree(adev->ip_discovery_text);
>                         return -EINVAL;
>                 }
>
> @@ -458,6 +507,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                             le16_to_cpu(ip->hw_id) == SDMA3_HWID)
>                                 adev->sdma.num_instances++;
>
> +                       snprintf(linebuf, 4096, "%s{%d} v%d.%d.%d: ",
> +                                 hw_id_names[le16_to_cpu(ip->hw_id)],
> +                                 ip->number_instance,
> +                                 ip->major, ip->minor,
> +                                 ip->revision);
> +                       if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +                               DRM_ERROR("Out of memory\n");
> +                               kfree(linebuf);
> +                               kfree(adev->ip_discovery_text);
> +                               return -ENOMEM;
> +                       }
> +
> +
>                         for (k = 0; k < num_base_address; k++) {
>                                 /*
>                                  * convert the endianness of base addresses in place,
> @@ -465,6 +527,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                                  */
>                                 ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
>                                 DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
> +                               snprintf(linebuf, 4096, "%08lx ", (unsigned long)ip->base_address[k]);
> +                               if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +                                       DRM_ERROR("Out of memory\n");
> +                                       kfree(linebuf);
> +                                       kfree(adev->ip_discovery_text);
> +                                       return -ENOMEM;
> +                               }
> +                       }
> +                       if (add_string(&adev->ip_discovery_text, &txt_size, "\n")) {
> +                               DRM_ERROR("Out of memory\n");
> +                               kfree(linebuf);
> +                               kfree(adev->ip_discovery_text);
> +                               return -ENOMEM;
>                         }
>
>                         for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +566,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                         ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>                 }
>         }
> -
> +       kfree(linebuf);
>         return 0;
>  }
>
> --
> 2.32.0
>
