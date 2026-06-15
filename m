Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6FBCD98CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 15:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A7410E517;
	Mon, 15 Jun 2026 15:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r6xqrbQu";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBF210E42D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 15:44:20 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1364ff8099cso101961c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 08:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781538259; cv=none;
 d=google.com; s=arc-20240605;
 b=CJukdGEoYTcDk7EgNojlqTS+yemItf50lqLAVx9WKYxZ3ek4lRT4gQGChHHumedzxM
 h6mrV9FxNTPgKKy414/FRoB01jYNogtvYuqyiha4fcG6tDCxhQ0rYCT7ZN1C9NQkjF8V
 MplFH5sPl0Z+7QFuCS38xdx84vyxgjRr9U1zzD+ItMfiCKnQnJCPfkIstmNJypHZovEE
 GrAHqgxgSyObZ3BiqebBjsYUQA+hJO5aYOeeiT3KKv6tV9SjIkgnKMeyvNyHmaJsy3hS
 y+Rh+xJBUr+QUFnAH13iA7dkO1vwSvH94ZyhFppgBJ9bgSFELj9Obxc1xVIibEBuUd6S
 1C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zUgKZj5aLyEFq+7q5dOeM6059lCwbRiMMKWyZ7+3FDs=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=J+3V1V3ZSxE96EsqEC/S9HZIkmxjZrsWwtYJGc6JDhwSZiuzpDzn+tq/bMwqmDCXab
 yA8XhRfHzyaP2wt1iUnILkfg+l4f4UmmhcjMX6ioIi7OVdd3sTwByQqJ37MQal7Zft4E
 JqXBpqJ/XbckUHYmi3kqhrZgqEMwSHw1+Ii6cJ0XltaS65Eju1y7Ws9G/aV45z9VcTvb
 KcrwdiDlqNtrFgaUbiGLSEoAfmy34qWgA5Q1YaQ9kQ9nh2lJzoiEqixPpNYeQfSnaWvx
 JI24ypnryCSpSb1ZjX/miQrQW4OC9oaHmTpYtyWySq8xZVOXjxUkyVlqiPOGsT9Rz3/M
 rZyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781538259; x=1782143059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUgKZj5aLyEFq+7q5dOeM6059lCwbRiMMKWyZ7+3FDs=;
 b=r6xqrbQunqas1perv8K8paRlWffeRtJNLZr2oZyhMV43gomkoZNZzsK/CSdj6poAxu
 5AdcWtM2z+PntZzsi5PjRJIYsI+oxAsev7ml/yg18DCLHKHRou4cDOlltGF0inT3WVFQ
 2acKZue4SxZeqbesEm4Ycy44p5CfdRdRqoeC+97IZB/Hv84ajYJLeCbmBNiGzz8ESlXz
 UFPpw4kHQuWVTcElZFMcQqi97Rm8rrAS9Sw671bzw/Wc4qfMni4BlIScq3vChb/zLKq/
 9CqbrvSzULO9IS6zpryucRRKq3iF8gQFKYGGqLYZESZQX4Eqml6CH4ZCMNzlaeP387j3
 tKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781538259; x=1782143059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUgKZj5aLyEFq+7q5dOeM6059lCwbRiMMKWyZ7+3FDs=;
 b=OgB7vf8dF3XMiOm035itbmh2I5raVeOI19Yu7qTLKQUSI/BvYfRbSWErdmwqNr0xBm
 ZMLqUgeMNiZxXlVTPtaONRcHss994CdlSJ/SPExj6rloG0AOFGmSwG+I/It0IBK3/cdE
 mQlwKqsdNPDUhlVic5ANAPE0E+71/uJQUmOPtithOECyf1yctg0wl4xuhiudsy9CwjJv
 TVQ3g/UmTTYVZZ+Bmi2iMVEefT52V9ap0zkD5Frvkhn0bSGQiYgKEmT1cPwn6WEOZwy2
 6dXdqw0FDHab2Cozl4O507Nl0oRymTgyxJBrTvnpXD7Gaypl01sXVLvVEtZwR1g2zRei
 tAMA==
X-Gm-Message-State: AOJu0Ywu5Ku+xqd6zSpQqtEmHk49/Y6Qs5OahNcSnJalli6C2t0kp0si
 10Etvs+JP9aiVFNdpbMTCMDqO2fVpKJJ1HUiwAlRGCuMuHmwvPGZS7Sl8ooreUyTM8iacJrs2EH
 /MIeiGE2hwEqOVw3Ao+nalQQdtRVNFrBKWQ==
X-Gm-Gg: Acq92OGb2jIXn4okxPVvVkCM6SWZ9/WPvD4zsLZULRIWtXSAOvFD5LufNoddOFp1Tqv
 XkwXDrsovIY7BmE0ww49TACzv5Bmg6hO/JjNTz2Y5DWWdQcT6MfX6lz9utJ9p7Jlu1rLAXyKR4w
 vZMguQLBZXl3rifJNL5wTI7pBo5AvoFVCGBa7cxT+1zpBfybfRrjlBS9wVGDThFXoLqIfvdlz6j
 Hjd7YWNL0jALY0WN+yvJAzgDFg+nvavmfZxUoRLKhyRPvj+YLgeV88oKie5LtoBSJzkaRj1iRLn
 3Rr7kdOgWVzQFFhyBdwnNpN8FxamfV8tsi7hJN1OLV9upDKfrENMYCFSFxzrOzLpl5Qw+g==
X-Received: by 2002:a05:7022:fd07:b0:137:f2f4:ff76 with SMTP id
 a92af1059eb24-1384bb850a6mr3103470c88.3.1781538259209; Mon, 15 Jun 2026
 08:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260612164443.1002712-1-mario.limonciello@amd.com>
In-Reply-To: <20260612164443.1002712-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:44:06 -0400
X-Gm-Features: AVVi8CfujQ7l97DaMlzYktcCHnf8JzyJeXr-_ouvUyW8KzFhr6Qjj1IduGcu3Ks
Message-ID: <CADnq5_Okvy21gCx-WvtDdgrQiDsh8MefExBnZ19SM0YMgkA6MA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Export ip_discovery sysfs on probe failure
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Jun 12, 2026 at 1:39=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When driver probe fails (missing firmware, unsupported hardware, etc.),
> the entire device is torn down including the ip_discovery sysfs folder,
> preventing users from identifying what hardware is present.
>
> Export ip_discovery sysfs even when probe fails by creating it early
> in the probe flow and tying its lifetime to the PCI device rather than
> the driver. The sysfs folder persists across probe failures and module
> reloads, but is cleaned up on driver unbind.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  * rebase on amd-staging-drm-next
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 285 +++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>  3 files changed, 257 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 2cfcfa29204a5..49e8ed65d7a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include <linux/firmware.h>
> +#include <linux/kernfs.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_discovery.h"
> @@ -148,6 +149,26 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin")=
;
>  #define mmDRIVER_SCRATCH_1     0x95
>  #define mmDRIVER_SCRATCH_2     0x96
>
> +struct ip_discovery_top {
> +       struct kobject kobj;
> +       struct kset die_kset;
> +       struct pci_dev *pdev;
> +       struct amdgpu_device *adev;
> +       uint8_t *discovery_bin;
> +       uint32_t bin_size;
> +       bool standalone_mode;
> +};
> +
> +/* List to track early-initialized ip_discovery_top entries */
> +struct early_ip_discovery {
> +       struct list_head list;
> +       struct pci_dev *pdev;
> +       struct ip_discovery_top *ip_top;
> +};
> +
> +static LIST_HEAD(early_ip_discovery_list);
> +static DEFINE_MUTEX(early_ip_discovery_mutex);
> +
>  static const char *hw_id_names[HW_ID_MAX] =3D {
>         [MP1_HWID]              =3D "MP1",
>         [MP2_HWID]              =3D "MP2",
> @@ -542,25 +563,37 @@ static const char *amdgpu_discovery_get_fw_name(str=
uct amdgpu_device *adev)
>         }
>  }
>
> -static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
> -                                          struct table_info **info,
> -                                          uint16_t table_id)
> +static struct table_info *
> +amdgpu_discovery_get_table_info_from_bin(uint8_t *discovery_bin,
> +                                        uint16_t table_id)
>  {
> -       struct binary_header *bhdr =3D
> -               (struct binary_header *)adev->discovery.bin;
> +       struct binary_header *bhdr =3D (struct binary_header *)discovery_=
bin;
>         struct binary_header_v2 *bhdrv2;
>
>         switch (bhdr->version_major) {
>         case 2:
> -               bhdrv2 =3D (struct binary_header_v2 *)adev->discovery.bin=
;
> -               *info =3D &bhdrv2->table_list[table_id];
> -               break;
> +               bhdrv2 =3D (struct binary_header_v2 *)discovery_bin;
> +               return &bhdrv2->table_list[table_id];
>         case 1:
>         case 0:
> -               *info =3D &bhdr->table_list[table_id];
> -               break;
> +               return &bhdr->table_list[table_id];
>         default:
> -               dev_err(adev->dev, "Invalid ip discovery table version %d=
\n",bhdr->version_major);
> +               return NULL;
> +       }
> +}
> +
> +static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
> +                                          struct table_info **info,
> +                                          uint16_t table_id)
> +{
> +       struct binary_header *bhdr =3D
> +               (struct binary_header *)adev->discovery.bin;
> +
> +       *info =3D amdgpu_discovery_get_table_info_from_bin(adev->discover=
y.bin,
> +                                                        table_id);
> +       if (!*info) {
> +               dev_err(adev->dev, "Invalid ip discovery table version %d=
\n",
> +                       bhdr->version_major);
>                 return -EINVAL;
>         }
>
> @@ -728,7 +761,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu=
_device *adev);
>
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
> -       amdgpu_discovery_sysfs_fini(adev);
> +       if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone=
_mode)
> +               amdgpu_discovery_sysfs_fini(adev);
> +
>         kfree(adev->discovery.bin);
>         adev->discovery.bin =3D NULL;
>  }
> @@ -737,15 +772,17 @@ static int amdgpu_discovery_validate_ip(struct amdg=
pu_device *adev,
>                                         uint8_t instance, uint16_t hw_id)
>  {
>         if (instance >=3D HWIP_MAX_INSTANCE) {
> -               dev_err(adev->dev,
> -                       "Unexpected instance_number (%d) from ip discover=
y blob\n",
> -                       instance);
> +               if (adev)
> +                       dev_err(adev->dev,
> +                               "Unexpected instance_number (%d) from ip =
discovery blob\n",
> +                               instance);
>                 return -EINVAL;
>         }
>         if (hw_id >=3D HW_ID_MAX) {
> -               dev_err(adev->dev,
> -                       "Unexpected hw_id (%d) from ip discovery blob\n",
> -                       hw_id);
> +               if (adev)
> +                       dev_err(adev->dev,
> +                               "Unexpected hw_id (%d) from ip discovery =
blob\n",
> +                               hw_id);
>                 return -EINVAL;
>         }
>
> @@ -1111,12 +1148,6 @@ static const struct kobj_type ip_discovery_ktype =
=3D {
>         .sysfs_ops =3D &kobj_sysfs_ops,
>  };
>
> -struct ip_discovery_top {
> -       struct kobject kobj;    /* ip_discovery/ */
> -       struct kset die_kset;   /* ip_discovery/die/, contains ip_die_ent=
ry */
> -       struct amdgpu_device *adev;
> -};
> -
>  static void die_kobj_release(struct kobject *kobj)
>  {
>         struct ip_discovery_top *ip_top =3D container_of(to_kset(kobj),
> @@ -1132,8 +1163,14 @@ static void ip_disc_release(struct kobject *kobj)
>                                                        kobj);
>         struct amdgpu_device *adev =3D ip_top->adev;
>
> +       /* In standalone mode, discovery_bin is managed by devm and will =
be
> +        * freed automatically when the PCI device is removed. Do not man=
ually
> +        * free it here to avoid double-free.
> +        */
> +
>         kfree(ip_top);
> -       adev->discovery.ip_top =3D NULL;
> +       if (adev)
> +               adev->discovery.ip_top =3D NULL;
>  }
>
>  static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *a=
dev,
> @@ -1141,6 +1178,10 @@ static uint8_t amdgpu_discovery_get_harvest_info(s=
truct amdgpu_device *adev,
>  {
>         uint8_t harvest =3D 0;
>
> +       /* In early init mode (adev =3D=3D NULL), harvest info is not ava=
ilable */
> +       if (!adev)
> +               return 0;
> +
>         /* Until a uniform way is figured, get mask based on hwid */
>         switch (hw_id) {
>         case VCN_HWID:
> @@ -1169,11 +1210,14 @@ static uint8_t amdgpu_discovery_get_harvest_info(=
struct amdgpu_device *adev,
>  }
>
>  static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
> +                                     struct ip_discovery_top *ip_top,
>                                       struct ip_die_entry *ip_die_entry,
>                                       const size_t _ip_offset, const int =
num_ips,
>                                       bool reg_base_64)
>  {
> -       uint8_t *discovery_bin =3D adev->discovery.bin;
> +       uint8_t *discovery_bin =3D ip_top->standalone_mode ?
> +                                ip_top->discovery_bin :
> +                                adev->discovery.bin;
>         int ii, jj, kk, res;
>         uint16_t hw_id;
>         uint8_t inst;
> @@ -1271,10 +1315,12 @@ static int amdgpu_discovery_sysfs_ips(struct amdg=
pu_device *adev,
>         return 0;
>  }
>
> -static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
> +                                         struct ip_discovery_top *ip_top=
)
>  {
> -       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;
> -       uint8_t *discovery_bin =3D adev->discovery.bin;
> +       uint8_t *discovery_bin =3D ip_top->standalone_mode ?
> +                                ip_top->discovery_bin :
> +                                adev->discovery.bin;
>         struct table_info *info;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> @@ -1283,9 +1329,10 @@ static int amdgpu_discovery_sysfs_recurse(struct a=
mdgpu_device *adev)
>         size_t ip_offset;
>         int ii, res;
>
> -       res =3D amdgpu_discovery_get_table_info(adev, &info, IP_DISCOVERY=
);
> -       if (res)
> -               return res;
> +       info =3D amdgpu_discovery_get_table_info_from_bin(discovery_bin,
> +                                                       IP_DISCOVERY);
> +       if (!info)
> +               return -EINVAL;
>         ihdr =3D (struct ip_discovery_header
>                         *)(discovery_bin +
>                            le16_to_cpu(info->offset));
> @@ -1323,7 +1370,8 @@ static int amdgpu_discovery_sysfs_recurse(struct am=
dgpu_device *adev)
>                         return res;
>                 }
>
> -               amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset,=
 num_ips, !!ihdr->base_addr_64_bit);
> +               amdgpu_discovery_sysfs_ips(adev, ip_top, ip_die_entry, ip=
_offset,
> +                                          num_ips, !!ihdr->base_addr_64_=
bit);
>         }
>
>         return 0;
> @@ -1339,12 +1387,30 @@ static int amdgpu_discovery_sysfs_init(struct amd=
gpu_device *adev)
>         if (!discovery_bin)
>                 return -EINVAL;
>
> +       /* If early init already created sysfs in standalone mode, skip n=
ormal init */
> +       if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_=
mode)
> +               return 0;
> +
>         ip_top =3D kzalloc(sizeof(*ip_top), GFP_KERNEL);
>         if (!ip_top)
>                 return -ENOMEM;
>
>         ip_top->adev =3D adev;
> -       adev->discovery.ip_top =3D ip_top;
> +
> +       /* Check if ip_discovery already exists before creating.
> +        * This shouldn't normally happen but handle it gracefully.
> +        */
> +       if (adev->dev->kobj.sd) {
> +               struct kernfs_node *existing;
> +
> +               existing =3D kernfs_find_and_get(adev->dev->kobj.sd, "ip_=
discovery");
> +               if (existing) {
> +                       kernfs_put(existing);
> +                       kfree(ip_top);
> +                       return 0;
> +               }
> +       }
> +
>         res =3D kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
>                                    &adev->dev->kobj, "ip_discovery");
>         if (res) {
> @@ -1352,6 +1418,8 @@ static int amdgpu_discovery_sysfs_init(struct amdgp=
u_device *adev)
>                 goto Err;
>         }
>
> +       adev->discovery.ip_top =3D ip_top;
> +
>         die_kset =3D &ip_top->die_kset;
>         kobject_set_name(&die_kset->kobj, "%s", "die");
>         die_kset->kobj.parent =3D &ip_top->kobj;
> @@ -1366,7 +1434,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgp=
u_device *adev)
>                 ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
>         ip_hw_instance_attrs[ii] =3D NULL;
>
> -       res =3D amdgpu_discovery_sysfs_recurse(adev);
> +       res =3D amdgpu_discovery_sysfs_recurse(adev, ip_top);
>
>         return res;
>  Err:
> @@ -1480,6 +1548,150 @@ void amdgpu_discovery_dump(struct amdgpu_device *=
adev, struct drm_printer *p)
>         spin_unlock(&die_kset->list_lock);
>  }
>
> +int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev, struct=
 pci_dev *pdev)
> +{
> +       struct ip_discovery_top *ip_top;
> +       struct early_ip_discovery *early_entry, *tmp;
> +       struct kset *die_kset;
> +       uint8_t *discovery_bin;
> +       int res, ii;
> +
> +       if (!adev || !adev->discovery.bin)
> +               return -EINVAL;
> +
> +       if (adev->discovery.ip_top)
> +               return 0;
> +
> +       mutex_lock(&early_ip_discovery_mutex);
> +       list_for_each_entry_safe(early_entry, tmp, &early_ip_discovery_li=
st, list) {
> +               if (early_entry->pdev =3D=3D pdev) {
> +                       adev->discovery.ip_top =3D early_entry->ip_top;
> +                       early_entry->ip_top->adev =3D adev;
> +                       mutex_unlock(&early_ip_discovery_mutex);
> +                       return 0;
> +               }
> +       }
> +       mutex_unlock(&early_ip_discovery_mutex);
> +
> +       discovery_bin =3D adev->discovery.bin;
> +
> +       early_entry =3D kzalloc(sizeof(*early_entry), GFP_KERNEL);
> +       if (!early_entry)
> +               return -ENOMEM;
> +
> +       ip_top =3D kzalloc(sizeof(*ip_top), GFP_KERNEL);
> +       if (!ip_top) {
> +               kfree(early_entry);
> +               return -ENOMEM;
> +       }
> +
> +       ip_top->discovery_bin =3D devm_kmemdup(&pdev->dev, discovery_bin,
> +                                            DISCOVERY_TMR_SIZE, GFP_KERN=
EL);
> +       if (!ip_top->discovery_bin) {
> +               kfree(ip_top);
> +               kfree(early_entry);
> +               return -ENOMEM;
> +       }
> +
> +       ip_top->bin_size =3D DISCOVERY_TMR_SIZE;
> +       ip_top->pdev =3D pdev;
> +       ip_top->adev =3D adev;
> +       ip_top->standalone_mode =3D true;
> +
> +       /* Check if ip_discovery already exists (from previous probe atte=
mpt).
> +        * This can happen if the module was unloaded and reloaded but th=
e
> +        * sysfs persisted (tied to PCI device lifetime).
> +        */
> +       if (pdev->dev.kobj.sd) {
> +               struct kernfs_node *existing;
> +
> +               existing =3D kernfs_find_and_get(pdev->dev.kobj.sd, "ip_d=
iscovery");
> +               if (existing) {
> +                       kernfs_put(existing);
> +                       kfree(ip_top);
> +                       kfree(early_entry);
> +                       return 0;
> +               }
> +       }
> +
> +       res =3D kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
> +                                  &pdev->dev.kobj, "ip_discovery");
> +       if (res)
> +               goto err_put_kobj;
> +
> +       adev->discovery.ip_top =3D ip_top;
> +
> +       die_kset =3D &ip_top->die_kset;
> +       kobject_set_name(&die_kset->kobj, "%s", "die");
> +       die_kset->kobj.parent =3D &ip_top->kobj;
> +       die_kset->kobj.ktype =3D &die_kobj_ktype;
> +       res =3D kset_register(&ip_top->die_kset);
> +       if (res)
> +               goto err_put_die_kset;
> +
> +       for (ii =3D 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> +               ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
> +       ip_hw_instance_attrs[ii] =3D NULL;
> +
> +       res =3D amdgpu_discovery_sysfs_recurse(NULL, ip_top);
> +       if (res)
> +               goto err_put_die_kset;
> +
> +       early_entry->pdev =3D pdev;
> +       early_entry->ip_top =3D ip_top;
> +       mutex_lock(&early_ip_discovery_mutex);
> +       list_add(&early_entry->list, &early_ip_discovery_list);
> +       mutex_unlock(&early_ip_discovery_mutex);
> +
> +       return 0;
> +
> +err_put_die_kset:
> +       kobject_put(&ip_top->die_kset.kobj);
> +err_put_kobj:
> +       kobject_put(&ip_top->kobj);
> +       kfree(early_entry);
> +       adev->discovery.ip_top =3D NULL;
> +       return res;
> +}
> +
> +void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev)
> +{
> +       struct early_ip_discovery *entry, *tmp_entry;
> +       struct ip_discovery_top *ip_top =3D NULL;
> +       struct list_head *el, *tmp;
> +       struct kset *die_kset;
> +
> +       /* Find the entry in our tracking list */
> +       mutex_lock(&early_ip_discovery_mutex);
> +       list_for_each_entry_safe(entry, tmp_entry, &early_ip_discovery_li=
st, list) {
> +               if (entry->pdev =3D=3D pdev) {
> +                       ip_top =3D entry->ip_top;
> +                       list_del(&entry->list);
> +                       kfree(entry);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&early_ip_discovery_mutex);
> +
> +       if (!ip_top)
> +               return;
> +
> +       /* Clean up sysfs hierarchy */
> +       die_kset =3D &ip_top->die_kset;
> +
> +       spin_lock(&die_kset->list_lock);
> +       list_for_each_prev_safe(el, tmp, &die_kset->list) {
> +               list_del_init(el);
> +               spin_unlock(&die_kset->list_lock);
> +               amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_k=
obj(el)));
> +               spin_lock(&die_kset->list_lock);
> +       }
> +       spin_unlock(&die_kset->list_lock);
> +
> +       kobject_put(&ip_top->die_kset.kobj);
> +       kobject_put(&ip_top->kobj);
> +       /* ip_top itself will be freed by kobject_put via ip_disc_release=
 */
> +}
>
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
>
> @@ -1505,6 +1717,9 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>         r =3D amdgpu_discovery_init(adev);
>         if (r)
>                 return r;
> +
> +       amdgpu_discovery_sysfs_early_init(adev, adev->pdev);
> +
>         discovery_bin =3D adev->discovery.bin;
>         wafl_ver =3D 0;
>         adev->gfx.xcc_mask =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index e0010f6a3eda5..edc78184e0f39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -53,4 +53,9 @@ int amdgpu_discovery_get_gc_major_minor_version(struct =
amdgpu_device *adev,
>
>  void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printe=
r *p);
>
> +/* Early sysfs functions for persistent ip_discovery export */
> +int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev,
> +                                      struct pci_dev *pdev);
> +void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
> +
>  #endif /* __AMDGPU_DISCOVERY__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 503bb64c1e55f..63ca6bcde57ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2552,6 +2552,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>
>         amdgpu_driver_unload_kms(dev);
>
> +       amdgpu_discovery_sysfs_early_fini(pdev);
> +
>         /*
>          * Flush any in flight DMA operations from device.
>          * Clear the Bus Master Enable bit and then wait on the PCIe Devi=
ce
> --
> 2.43.0
>
