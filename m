Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB24FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D2B10E4D3;
	Fri, 11 Feb 2022 21:04:38 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6187A10E4D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:04:37 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 s6-20020a0568301e0600b0059ea5472c98so6928093otr.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/oPJuI+ihifWL2PVVsr10D8RBudny/0rRFrLHlcvU/Y=;
 b=i9gGgIMs4xIovgbDeXUXFmhmrjdSU1ecS+K2+AyBQ6SNMI2qJpDW9w2tPUQtwUgDJp
 0KooqcsT55TssnT+jwfo8ctRWUiIWQUCGTtI4PO5jKhsceJvVrxE6iDHYAye7rmNuO8/
 UtW24QoVjtgmqqFjANDEStmVx4UGmypWQSwnzPFEKJMwrsvUzHveKoyX8l7bjG4k50Fp
 Vuwxu859jEniIc5yXKUsxShRw4ieiKjj7Mn6GjILdAMj3LjgvYWbcouLh2hIHNVKlkhi
 oLr9gU8L6bEMFrrUYNtYWwslY3YPslxPkhc9WpszMvb8e9Kl2RRGsuwsCy2OyoSCkoyg
 B+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/oPJuI+ihifWL2PVVsr10D8RBudny/0rRFrLHlcvU/Y=;
 b=HAReNylZV8rKz4uLqsnMaqxWTTWQ+0z2wvyDsbq9mnWcJpGRjnq4g/9U8lyhngtMn8
 6qyk8bGwsKLVad2H+AuiLcaJ/mXce3EzEI71wg+FXI6b7+N7Ug5euHwkHu0s/HHTutjW
 HNMjKHgjGFGzb2KVvKiKturYCP7HBBYnKlH7oJAr1VdmQBYsICiaisgQaez5YNjSGNA4
 b7nrrUV8X5ak0B69ofw9xa+PhY5bE/p+WSMC0JviqLiPUjceUgoKwdgAeKbxNiZsBRNX
 DrEQ/xmkG2xoDlTf3nctR7nG95dAv0icI3M0IyWc/yNCF+XiiPOv3Rc1+LKgJMbhKI4v
 k4Xg==
X-Gm-Message-State: AOAM531Yq6OdIjJFV52fV7cBcTlQNjuVYPOyc6ZxbXDQErqjYMFRKnVD
 Xq6B/jJYknZxIRD6eiK6SmN7Z+xvJ7P3urokL6iTpfJG
X-Google-Smtp-Source: ABdhPJw15BU5kl4IMNGLTxE+8SI9GBVAJjY/9x8zowyCu8Kw0eKJHV3FQCyhfr8+9zrUGYsep6HSno7BuwvFaka8yp0=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr1286642otj.200.1644613476409;
 Fri, 11 Feb 2022 13:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20220211205312.6410-1-luben.tuikov@amd.com>
 <20220211205312.6410-2-luben.tuikov@amd.com>
In-Reply-To: <20220211205312.6410-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Feb 2022 16:04:25 -0500
Message-ID: <CADnq5_N9JE65hWoUv3vagukh96mebsAGePie6jpAN+7aaGVMqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu: Show IP discovery in sysfs
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 11, 2022 at 3:53 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Add IP discovery data in sysfs. The format is:
> /sys/class/drm/cardX/device/ip_discovery/die/D/B/I/<attrs>
> where,
> X is the card ID, an integer,
> D is the die ID, an integer,
> B is the IP HW ID, an integer, aka block type,
> I is the IP HW ID instance, an integer.
> <attrs> are the attributes of the block instance. At the moment these
> include HW ID, instance number, major, minor, revision, number of base
> addresses, and the base addresses themselves.
>
> A symbolic link of the acronym HW ID is also created, under D/, if you
> prefer to browse by something humanly accessible.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Tom StDenis <tom.stdenis@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 493 ++++++++++++++++++
>  2 files changed, 497 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e4eb812ade2fa4..3a126dce8a2fe9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -772,6 +772,8 @@ struct amd_powerplay {
>         const struct amd_pm_funcs *pp_funcs;
>  };
>
> +struct ip_discovery_top;
> +
>  /* polaris10 kickers */
>  #define ASICID_IS_P20(did, rid)                (((did == 0x67DF) && \
>                                          ((rid == 0xE3) || \
> @@ -1097,6 +1099,8 @@ struct amdgpu_device {
>         bool                            ram_is_direct_mapped;
>
>         struct list_head                ras_list;
> +
> +       struct ip_discovery_top         *ip_top;
>  };
>
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6a08bece24d736..c8dbdb78988ce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -360,8 +360,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>         return r;
>  }
>
> +static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
> +
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
> +       amdgpu_discovery_sysfs_fini(adev);
>         kfree(adev->mman.discovery_bin);
>         adev->mman.discovery_bin = NULL;
>  }
> @@ -382,6 +385,494 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>         return 0;
>  }
>
> +/* ================================================== */
> +
> +struct ip_hw_instance {
> +       struct kobject kobj; /* ip_discovery/die/#die/#hw_id/#instance/<attrs...> */
> +
> +       int hw_id;
> +       u8  num_instance;
> +       u8  major, minor, revision;
> +
> +       int num_base_addresses;
> +       u32 base_addr[];
> +};
> +
> +struct ip_hw_id {
> +       struct kset hw_id_kset;  /* ip_discovery/die/#die/#hw_id/, contains ip_hw_instance */
> +       int hw_id;
> +};
> +
> +struct ip_die_entry {
> +       struct kset ip_kset;     /* ip_discovery/die/#die/, contains ip_hw_id  */
> +       u16 num_ips;
> +};
> +
> +/* -------------------------------------------------- */
> +
> +struct ip_hw_instance_attr {
> +       struct attribute attr;
> +       ssize_t (*show)(struct ip_hw_instance *ip_hw_instance, char *buf);
> +};
> +
> +static ssize_t hw_id_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->hw_id);
> +}
> +
> +static ssize_t num_instance_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->num_instance);
> +}
> +
> +static ssize_t major_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->major);
> +}
> +
> +static ssize_t minor_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->minor);
> +}
> +
> +static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
> +}
> +
> +static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
> +}
> +
> +static ssize_t base_addr_show(struct ip_hw_instance *ip_hw_instance, char *buf)
> +{
> +       ssize_t res, at;
> +       int ii;
> +
> +       for (res = at = ii = 0; ii < ip_hw_instance->num_base_addresses; ii++) {
> +               /* Here we satisfy the condition that, at + size <= PAGE_SIZE.
> +                */
> +               if (at + 12 > PAGE_SIZE)
> +                       break;
> +               res = sysfs_emit_at(buf, at, "0x%08X\n",
> +                                   ip_hw_instance->base_addr[ii]);
> +               if (res <= 0)
> +                       break;
> +               at += res;
> +       }
> +
> +       return res < 0 ? res : at;
> +}
> +
> +static struct ip_hw_instance_attr ip_hw_attr[] = {
> +       __ATTR_RO(hw_id),
> +       __ATTR_RO(num_instance),
> +       __ATTR_RO(major),
> +       __ATTR_RO(minor),
> +       __ATTR_RO(revision),
> +       __ATTR_RO(num_base_addresses),
> +       __ATTR_RO(base_addr),
> +};
> +
> +static struct attribute *ip_hw_instance_attrs[] = {
> +       &ip_hw_attr[0].attr,
> +       &ip_hw_attr[1].attr,
> +       &ip_hw_attr[2].attr,
> +       &ip_hw_attr[3].attr,
> +       &ip_hw_attr[4].attr,
> +       &ip_hw_attr[5].attr,
> +       &ip_hw_attr[6].attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(ip_hw_instance);
> +
> +#define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj)
> +#define to_ip_hw_instance_attr(x) container_of(x, struct ip_hw_instance_attr, attr)
> +
> +static ssize_t ip_hw_instance_attr_show(struct kobject *kobj,
> +                                       struct attribute *attr,
> +                                       char *buf)
> +{
> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
> +       struct ip_hw_instance_attr *ip_hw_attr = to_ip_hw_instance_attr(attr);
> +
> +       if (!ip_hw_attr->show)
> +               return -EIO;
> +
> +       return ip_hw_attr->show(ip_hw_instance, buf);
> +}
> +
> +static const struct sysfs_ops ip_hw_instance_sysfs_ops = {
> +       .show = ip_hw_instance_attr_show,
> +};
> +
> +static void ip_hw_instance_release(struct kobject *kobj)
> +{
> +       struct ip_hw_instance *ip_hw_instance = to_ip_hw_instance(kobj);
> +
> +       kfree(ip_hw_instance);
> +}
> +
> +static struct kobj_type ip_hw_instance_ktype = {
> +       .release = ip_hw_instance_release,
> +       .sysfs_ops = &ip_hw_instance_sysfs_ops,
> +       .default_groups = ip_hw_instance_groups,
> +};
> +
> +/* -------------------------------------------------- */
> +
> +#define to_ip_hw_id(x)  container_of(to_kset(x), struct ip_hw_id, hw_id_kset)
> +
> +static void ip_hw_id_release(struct kobject *kobj)
> +{
> +       struct ip_hw_id *ip_hw_id = to_ip_hw_id(kobj);
> +
> +       if (!list_empty(&ip_hw_id->hw_id_kset.list))
> +               DRM_ERROR("ip_hw_id->hw_id_kset is not empty");
> +       kfree(ip_hw_id);
> +}
> +
> +static struct kobj_type ip_hw_id_ktype = {
> +       .release = ip_hw_id_release,
> +       .sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +/* -------------------------------------------------- */
> +
> +static void die_kobj_release(struct kobject *kobj);
> +static void ip_disc_release(struct kobject *kobj);
> +
> +struct ip_die_entry_attribute {
> +       struct attribute attr;
> +       ssize_t (*show)(struct ip_die_entry *ip_die_entry, char *buf);
> +};
> +
> +#define to_ip_die_entry_attr(x)  container_of(x, struct ip_die_entry_attribute, attr)
> +
> +static ssize_t num_ips_show(struct ip_die_entry *ip_die_entry, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", ip_die_entry->num_ips);
> +}
> +
> +/* If there are more ip_die_entry attrs, other than the number of IPs,
> + * we can make this intro an array of attrs, and then initialize
> + * ip_die_entry_attrs in a loop.
> + */
> +static struct ip_die_entry_attribute num_ips_attr =
> +       __ATTR_RO(num_ips);
> +
> +static struct attribute *ip_die_entry_attrs[] = {
> +       &num_ips_attr.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(ip_die_entry); /* ip_die_entry_groups */
> +
> +#define to_ip_die_entry(x) container_of(to_kset(x), struct ip_die_entry, ip_kset)
> +
> +static ssize_t ip_die_entry_attr_show(struct kobject *kobj,
> +                                     struct attribute *attr,
> +                                     char *buf)
> +{
> +       struct ip_die_entry_attribute *ip_die_entry_attr = to_ip_die_entry_attr(attr);
> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
> +
> +       if (!ip_die_entry_attr->show)
> +               return -EIO;
> +
> +       return ip_die_entry_attr->show(ip_die_entry, buf);
> +}
> +
> +static void ip_die_entry_release(struct kobject *kobj)
> +{
> +       struct ip_die_entry *ip_die_entry = to_ip_die_entry(kobj);
> +
> +       if (!list_empty(&ip_die_entry->ip_kset.list))
> +               DRM_ERROR("ip_die_entry->ip_kset is not empty");
> +       kfree(ip_die_entry);
> +}
> +
> +static const struct sysfs_ops ip_die_entry_sysfs_ops = {
> +       .show = ip_die_entry_attr_show,
> +};
> +
> +static struct kobj_type ip_die_entry_ktype = {
> +       .release = ip_die_entry_release,
> +       .sysfs_ops = &ip_die_entry_sysfs_ops,
> +       .default_groups = ip_die_entry_groups,
> +};
> +
> +static struct kobj_type die_kobj_ktype = {
> +       .release = die_kobj_release,
> +       .sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +static struct kobj_type ip_discovery_ktype = {
> +       .release = ip_disc_release,
> +       .sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct ip_discovery_top {
> +       struct kobject kobj;    /* ip_discovery/ */
> +       struct kset die_kset;   /* ip_discovery/die/, contains ip_die_entry */
> +       struct amdgpu_device *adev;
> +};
> +
> +static void die_kobj_release(struct kobject *kobj)
> +{
> +       struct ip_discovery_top *ip_top = container_of(to_kset(kobj),
> +                                                      struct ip_discovery_top,
> +                                                      die_kset);
> +       if (!list_empty(&ip_top->die_kset.list))
> +               DRM_ERROR("ip_top->die_kset is not empty");
> +}
> +
> +static void ip_disc_release(struct kobject *kobj)
> +{
> +       struct ip_discovery_top *ip_top = container_of(kobj, struct ip_discovery_top,
> +                                                      kobj);
> +       struct amdgpu_device *adev = ip_top->adev;
> +
> +       adev->ip_top = NULL;
> +       kfree(ip_top);
> +}
> +
> +static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
> +                                     struct ip_die_entry *ip_die_entry,
> +                                     const size_t _ip_offset, const int num_ips)
> +{
> +       int ii, jj, kk, res;
> +
> +       DRM_DEBUG("num_ips:%d", num_ips);
> +
> +       /* Find all IPs of a given HW ID, and add their instance to
> +        * #die/#hw_id/#instance/<attributes>
> +        */
> +       for (ii = 0; ii < HW_ID_MAX; ii++) {
> +               struct ip_hw_id *ip_hw_id = NULL;
> +               size_t ip_offset = _ip_offset;
> +
> +               for (jj = 0; jj < num_ips; jj++) {
> +                       struct ip *ip;
> +                       struct ip_hw_instance *ip_hw_instance;
> +
> +                       ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
> +                       if (amdgpu_discovery_validate_ip(ip) ||
> +                           le16_to_cpu(ip->hw_id) != ii)
> +                               goto next_ip;
> +
> +                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
> +
> +                       /* We have a hw_id match; register the hw
> +                        * block if not yet registered.
> +                        */
> +                       if (!ip_hw_id) {
> +                               ip_hw_id = kzalloc(sizeof(*ip_hw_id), GFP_KERNEL);
> +                               if (!ip_hw_id)
> +                                       return -ENOMEM;
> +                               ip_hw_id->hw_id = ii;
> +
> +                               kobject_set_name(&ip_hw_id->hw_id_kset.kobj, "%d", ii);
> +                               ip_hw_id->hw_id_kset.kobj.kset = &ip_die_entry->ip_kset;
> +                               ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
> +                               res = kset_register(&ip_hw_id->hw_id_kset);
> +                               if (res) {
> +                                       DRM_ERROR("Couldn't register ip_hw_id kset");
> +                                       kfree(ip_hw_id);
> +                                       return res;
> +                               }
> +                               if (hw_id_names[ii]) {
> +                                       res = sysfs_create_link(&ip_die_entry->ip_kset.kobj,
> +                                                               &ip_hw_id->hw_id_kset.kobj,
> +                                                               hw_id_names[ii]);
> +                                       if (res) {
> +                                               DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
> +                                                         hw_id_names[ii],
> +                                                         kobject_name(&ip_die_entry->ip_kset.kobj));
> +                                       }
> +                               }
> +                       }
> +
> +                       /* Now register its instance.
> +                        */
> +                       ip_hw_instance = kzalloc(struct_size(ip_hw_instance,
> +                                                            base_addr,
> +                                                            ip->num_base_address),
> +                                                GFP_KERNEL);
> +                       if (!ip_hw_instance) {
> +                               DRM_ERROR("no memory for ip_hw_instance");
> +                               return -ENOMEM;
> +                       }
> +                       ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
> +                       ip_hw_instance->num_instance = ip->number_instance;
> +                       ip_hw_instance->major = ip->major;
> +                       ip_hw_instance->minor = ip->minor;
> +                       ip_hw_instance->revision = ip->revision;
> +                       ip_hw_instance->num_base_addresses = ip->num_base_address;
> +
> +                       for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
> +                               ip_hw_instance->base_addr[kk] = ip->base_address[kk];
> +
> +                       kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
> +                       ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
> +                       res = kobject_add(&ip_hw_instance->kobj, NULL,
> +                                         "%d", ip_hw_instance->num_instance);
> +next_ip:
> +                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
> +{
> +       struct binary_header *bhdr;
> +       struct ip_discovery_header *ihdr;
> +       struct die_header *dhdr;
> +       struct kset *die_kset = &adev->ip_top->die_kset;
> +       u16 num_dies, die_offset, num_ips;
> +       size_t ip_offset;
> +       int ii, res;
> +
> +       bhdr = (struct binary_header *)adev->mman.discovery_bin;
> +       ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
> +                                             le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
> +       num_dies = le16_to_cpu(ihdr->num_dies);
> +
> +       DRM_DEBUG("number of dies: %d\n", num_dies);
> +
> +       for (ii = 0; ii < num_dies; ii++) {
> +               struct ip_die_entry *ip_die_entry;
> +
> +               die_offset = le16_to_cpu(ihdr->die_info[ii].die_offset);
> +               dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> +               num_ips = le16_to_cpu(dhdr->num_ips);
> +               ip_offset = die_offset + sizeof(*dhdr);
> +
> +               /* Add the die to the kset.
> +                *
> +                * dhdr->die_id == ii, which was checked in
> +                * amdgpu_discovery_reg_base_init().
> +                */
> +
> +               ip_die_entry = kzalloc(sizeof(*ip_die_entry), GFP_KERNEL);
> +               if (!ip_die_entry)
> +                       return -ENOMEM;
> +
> +               ip_die_entry->num_ips = num_ips;
> +
> +               kobject_set_name(&ip_die_entry->ip_kset.kobj, "%d", le16_to_cpu(dhdr->die_id));
> +               ip_die_entry->ip_kset.kobj.kset = die_kset;
> +               ip_die_entry->ip_kset.kobj.ktype = &ip_die_entry_ktype;
> +               res = kset_register(&ip_die_entry->ip_kset);
> +               if (res) {
> +                       DRM_ERROR("Couldn't register ip_die_entry kset");
> +                       kfree(ip_die_entry);
> +                       return res;
> +               }
> +
> +               amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips);
> +       }
> +
> +       return 0;
> +}
> +
> +static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
> +{
> +       struct kset *die_kset;
> +       int res;
> +
> +       adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
> +       if (!adev->ip_top)
> +               return -ENOMEM;
> +
> +       adev->ip_top->adev = adev;
> +
> +       res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
> +                                  &adev->dev->kobj, "ip_discovery");
> +       if (res) {
> +               DRM_ERROR("Couldn't init and add ip_discovery/");
> +               goto Err;
> +       }
> +
> +       die_kset = &adev->ip_top->die_kset;
> +       kobject_set_name(&die_kset->kobj, "%s", "die");
> +       die_kset->kobj.parent = &adev->ip_top->kobj;
> +       die_kset->kobj.ktype = &die_kobj_ktype;
> +       res = kset_register(&adev->ip_top->die_kset);
> +       if (res) {
> +               DRM_ERROR("Couldn't register die_kset");
> +               goto Err;
> +       }
> +
> +       res = amdgpu_discovery_sysfs_recurse(adev);
> +
> +       return res;
> +Err:
> +       kobject_put(&adev->ip_top->kobj);
> +       return res;
> +}
> +
> +/* -------------------------------------------------- */
> +
> +#define list_to_kobj(el) container_of(el, struct kobject, entry)
> +
> +static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
> +{
> +       struct list_head *el, *tmp;
> +       struct kset *hw_id_kset;
> +
> +       hw_id_kset = &ip_hw_id->hw_id_kset;
> +       spin_lock(&hw_id_kset->list_lock);
> +       list_for_each_prev_safe(el, tmp, &hw_id_kset->list) {
> +               list_del_init(el);
> +               spin_unlock(&hw_id_kset->list_lock);
> +               /* kobject is embedded in ip_hw_instance */
> +               kobject_put(list_to_kobj(el));
> +               spin_lock(&hw_id_kset->list_lock);
> +       }
> +       spin_unlock(&hw_id_kset->list_lock);
> +       kobject_put(&ip_hw_id->hw_id_kset.kobj);
> +}
> +
> +static void amdgpu_discovery_sysfs_die_free(struct ip_die_entry *ip_die_entry)
> +{
> +       struct list_head *el, *tmp;
> +       struct kset *ip_kset;
> +
> +       ip_kset = &ip_die_entry->ip_kset;
> +       spin_lock(&ip_kset->list_lock);
> +       list_for_each_prev_safe(el, tmp, &ip_kset->list) {
> +               list_del_init(el);
> +               spin_unlock(&ip_kset->list_lock);
> +               amdgpu_discovery_sysfs_ip_hw_free(to_ip_hw_id(list_to_kobj(el)));
> +               spin_lock(&ip_kset->list_lock);
> +       }
> +       spin_unlock(&ip_kset->list_lock);
> +       kobject_put(&ip_die_entry->ip_kset.kobj);
> +}
> +
> +static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
> +{
> +       struct list_head *el, *tmp;
> +       struct kset *die_kset;
> +
> +       die_kset = &adev->ip_top->die_kset;
> +       spin_lock(&die_kset->list_lock);
> +       list_for_each_prev_safe(el, tmp, &die_kset->list) {
> +               list_del_init(el);
> +               spin_unlock(&die_kset->list_lock);
> +               amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kobj(el)));
> +               spin_lock(&die_kset->list_lock);
> +       }
> +       spin_unlock(&die_kset->list_lock);
> +       kobject_put(&adev->ip_top->die_kset.kobj);
> +       kobject_put(&adev->ip_top->kobj);
> +}
> +
> +/* ================================================== */
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> @@ -492,6 +983,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                 }
>         }
>
> +       amdgpu_discovery_sysfs_init(adev);
> +
>         return 0;
>  }
>
> --
> 2.35.0.3.gb23dac905b
>
