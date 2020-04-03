Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B10C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 18:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3E7206F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ugedal.com header.i=@ugedal.com header.b="GptnmV+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3E7206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ugedal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4593A6EC59;
	Fri,  3 Apr 2020 18:06:16 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B546EC59
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 18:04:09 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id y25so7225613qtv.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugedal.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=lNiDwG0qkWqv3WMcS5B4Z7G0FWS480XihkrG5v1LoUQ=;
 b=GptnmV+EI423cNcpNE6FP4opLNPijmJNmWEw66eLb2Rv8VjBUZwjuod+fLgD/eWMwv
 F4+M/pPrjwWP4hMIr5IjaKbDowmbua+opZXPnZilw0YSxRHsfXGqhzwXdWDMvsuMdXNI
 NIUdB32bD8ZT1TY2h0pcu2X51IyxZtDg2TyUukOsnBDKtbkM3gTcAv7XqLUUJxS9KZNh
 rBGS2uuQFdcnuW6kru0qXCYQhslfCrQrHFOzrNR4RoT+Wjk8M/vYVFaOSaH5pZM9wz4F
 Sg9C2vhq2f+08+ZeSTbkNwguXX82u9Ntj3AQj2W2uB/XhkERD6aJWYWq2niG7+dsx2Vy
 OzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=lNiDwG0qkWqv3WMcS5B4Z7G0FWS480XihkrG5v1LoUQ=;
 b=VYch+vqYZewUON7bT9fD3P+f78+Azbd/acDwFHjmAQj00beh5I16MNpGZDU/UQRZmy
 WNMCyrCIu1XcXxTGIL1wMDvikLURjPvsMYXPwTDIguwmwuGq7Yl6zdnjaZJx26vgHmwz
 Y66v17TgezCcAB4Vxa3TVKo/JFksLl6bUsw2bvNm9rgIdGB0nCwo2F3kOEQ9vl56uAlu
 L8cTLQ4BnxhnQXCr+TEqgp5VkAnJCVffY9WD1LZ4hRgWNHoZ1+M+IEbVNa4CeugwGl5e
 VjnEDl5Mb0JguQ4vyDDcmxk1ZC3Ld62n5U0RIGEni6SXE6YEiVn1eiXOVamHarP34RwT
 rO4A==
X-Gm-Message-State: AGi0PuZjDwUh0hIalfuvTCqTbZiQF9NsAeYnga1SGFeeACazQoMSaf1O
 JO89wf4pDSnTVyHpzBKOrpbU0DM5ybBoHhAXnCFtaBdKL4/B4KBT
X-Google-Smtp-Source: APiQypLCYHmf2nmiF8IJ6kO0kd/GOtSejBrea9x2120xBVSBHOdQpKHmmedRLkYZFgJzh+/C3qFl/lDdam5lAjb1gtY=
X-Received: by 2002:ac8:6919:: with SMTP id e25mr9588303qtr.151.1585937048457; 
 Fri, 03 Apr 2020 11:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200403175528.225990-1-odin@ugedal.com>
In-Reply-To: <20200403175528.225990-1-odin@ugedal.com>
From: Odin Ugedal <odin@ugedal.com>
Date: Fri, 3 Apr 2020 20:03:56 +0200
Message-ID: <CAFpoUr2TONVokmw2PCkM7m=Ft+==uBRfY1jdROD_Kx3Y_ex_BQ@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
To: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
 open list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
 Harish.Kasiviswanathan@amd.com, guro@fb.com, amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Fri, 03 Apr 2020 18:06:15 +0000
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
Content-Type: multipart/mixed; boundary="===============0871290676=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0871290676==
Content-Type: multipart/alternative; boundary="00000000000069000305a266be95"

--00000000000069000305a266be95
Content-Type: text/plain; charset="UTF-8"

Hi (patch author here),

This is my first "real" patch, so looking forward to some feedback! I am
not sure if this behavior is the "best one", or if we should require
CONFIG_CGROUP_DEVICE to be set to yes. In that case we can just abandon
this patch and replace the original "#if defined(CONFIG_CGROUP_DEVICE) ||
defined(CONFIG_CGROUP_BPF)" with a simple "#ifdef CONFIG_CGROUP_DEVICE" and
update the docs and the config.

It is also another alternative to keep the code in this patch and move some
of it into a separate file in order to avoid all the ifdefs, and to make
the split between cgroup v1 and cgroup v2 code cleaner.

As a reference, only Fedora is currently shipping with cgroup v2 as
default (afaik.) and their kernel is compiled (5.3.7-301.fc31.x86_64)
with CONFIG_CGROUP_DEVICE=y and CONFIG_CGROUP_BPF=y, so this will not
affect them.

Odin Ugedal

fre. 3. apr. 2020 kl. 19:55 skrev Odin Ugedal <odin@ugedal.com>:

> Original cgroup v2 eBPF code for filtering device access made it
> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
> filtering. Change
> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
> reverted this, making it required to set it to y.
>
> Since the device filtering (and all the docs) for cgroup v2 is no longer
> a "device controller" like it was in v1, someone might compile their
> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
> filter will not be invoked, and all processes will be allowed access
> to all devices, no matter what the eBPF filter says.
>
> Signed-off-by: Odin Ugedal <odin@ugedal.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
>  include/linux/device_cgroup.h         | 14 +++++---------
>  security/Makefile                     |  2 +-
>  security/device_cgroup.c              | 19 ++++++++++++++++---
>  4 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 4a3049841086..c24cad3c64ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1050,7 +1050,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);
>  /* Check with device cgroup if @kfd device is accessible */
>  static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
>  {
> -#if defined(CONFIG_CGROUP_DEVICE)
> +#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
>         struct drm_device *ddev = kfd->ddev;
>
>         return devcgroup_check_permission(DEVCG_DEV_CHAR,
> ddev->driver->major,
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
> index fa35b52e0002..9a72214496e5 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -1,6 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/fs.h>
> -#include <linux/bpf-cgroup.h>
>
>  #define DEVCG_ACC_MKNOD 1
>  #define DEVCG_ACC_READ  2
> @@ -11,16 +10,10 @@
>  #define DEVCG_DEV_CHAR  2
>  #define DEVCG_DEV_ALL   4  /* this represents all devices */
>
> -#ifdef CONFIG_CGROUP_DEVICE
> -int devcgroup_check_permission(short type, u32 major, u32 minor,
> -                              short access);
> -#else
> -static inline int devcgroup_check_permission(short type, u32 major, u32
> minor,
> -                                            short access)
> -{ return 0; }
> -#endif
>
>  #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> +int devcgroup_check_permission(short type, u32 major, u32 minor,
> +                              short access);
>  static inline int devcgroup_inode_permission(struct inode *inode, int
> mask)
>  {
>         short type, access = 0;
> @@ -61,6 +54,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t
> dev)
>  }
>
>  #else
> +static inline int devcgroup_check_permission(short type, u32 major, u32
> minor,
> +                              short access)
> +{ return 0; }
>  static inline int devcgroup_inode_permission(struct inode *inode, int
> mask)
>  { return 0; }
>  static inline int devcgroup_inode_mknod(int mode, dev_t dev)
> diff --git a/security/Makefile b/security/Makefile
> index 22e73a3482bd..3baf435de541 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)           += yama/
>  obj-$(CONFIG_SECURITY_LOADPIN)         += loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)    += lockdown/
> -obj-$(CONFIG_CGROUP_DEVICE)            += device_cgroup.o
> +obj-$(CONFIG_CGROUPS)                  += device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)                  += bpf/
>
>  # Object integrity file lists
> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> index 7d0f8f7431ff..43ab0ad45c1b 100644
> --- a/security/device_cgroup.c
> +++ b/security/device_cgroup.c
> @@ -15,6 +15,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
>
> +#ifdef CONFIG_CGROUP_DEVICE
> +
>  static DEFINE_MUTEX(devcgroup_mutex);
>
>  enum devcg_behavior {
> @@ -792,7 +794,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
>  };
>
>  /**
> - * __devcgroup_check_permission - checks if an inode operation is
> permitted
> + * devcgroup_legacy_check_permission - checks if an inode operation is
> permitted
>   * @dev_cgroup: the dev cgroup to be tested against
>   * @type: device type
>   * @major: device major number
> @@ -801,7 +803,7 @@ struct cgroup_subsys devices_cgrp_subsys = {
>   *
>   * returns 0 on success, -EPERM case the operation is not permitted
>   */
> -static int __devcgroup_check_permission(short type, u32 major, u32 minor,
> +static int devcgroup_legacy_check_permission(short type, u32 major, u32
> minor,
>                                         short access)
>  {
>         struct dev_cgroup *dev_cgroup;
> @@ -825,6 +827,10 @@ static int __devcgroup_check_permission(short type,
> u32 major, u32 minor,
>         return 0;
>  }
>
> +#endif /* CONFIG_CGROUP_DEVICE */
> +
> +#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> +
>  int devcgroup_check_permission(short type, u32 major, u32 minor, short
> access)
>  {
>         int rc = BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor,
> access);
> @@ -832,6 +838,13 @@ int devcgroup_check_permission(short type, u32 major,
> u32 minor, short access)
>         if (rc)
>                 return -EPERM;
>
> -       return __devcgroup_check_permission(type, major, minor, access);
> +       #ifdef CONFIG_CGROUP_DEVICE
> +       return devcgroup_legacy_check_permission(type, major, minor,
> access);
> +
> +       #else /* CONFIG_CGROUP_DEVICE */
> +       return 0;
> +
> +       #endif /* CONFIG_CGROUP_DEVICE */
>  }
>  EXPORT_SYMBOL(devcgroup_check_permission);
> +#endif /* defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF) */
> --
> 2.26.0
>
>

--00000000000069000305a266be95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi (patch author here),<div><br></div><div>This is my firs=
t &quot;real&quot; patch, so looking forward to some feedback! I am not sur=
e if this behavior is the &quot;best one&quot;, or if we should require CON=
FIG_CGROUP_DEVICE to be set to yes. In that case we can just abandon this p=
atch and replace the original &quot;#if defined(CONFIG_CGROUP_DEVICE) || de=
fined(CONFIG_CGROUP_BPF)&quot; with a simple &quot;#ifdef=C2=A0CONFIG_CGROU=
P_DEVICE&quot; and update the docs and the config.</div><div><br></div><div=
>It is also another alternative to keep the code in this patch and=C2=A0mov=
e some of it into a separate file in order to avoid all the ifdefs, and to =
make the split between cgroup v1 and cgroup v2 code cleaner.</div><div><br>=
</div><div>As a reference, only Fedora is currently shipping=C2=A0with cgro=
up v2 as default=C2=A0(afaik.) and their kernel is compiled (5.3.7-301.fc31=
.x86_64) with=C2=A0CONFIG_CGROUP_DEVICE=3Dy and CONFIG_CGROUP_BPF=3Dy, so t=
his will not affect them.</div><div><br></div><div>Odin Ugedal</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">fre. 3.=
 apr. 2020 kl. 19:55 skrev Odin Ugedal &lt;<a href=3D"mailto:odin@ugedal.co=
m">odin@ugedal.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Original cgroup v2 eBPF code for filtering device access made i=
t<br>
possible to compile with CONFIG_CGROUP_DEVICE=3Dn and still use the eBPF<br=
>
filtering. Change <br>
commit 4b7d4d453fc4 (&quot;device_cgroup: Export devcgroup_check_permission=
&quot;)<br>
reverted this, making it required to set it to y.<br>
<br>
Since the device filtering (and all the docs) for cgroup v2 is no longer<br=
>
a &quot;device controller&quot; like it was in v1, someone might compile th=
eir<br>
kernel with CONFIG_CGROUP_DEVICE=3Dn. Then (for linux 5.5+) the eBPF<br>
filter will not be invoked, and all processes will be allowed access<br>
to all devices, no matter what the eBPF filter says.<br>
<br>
Signed-off-by: Odin Ugedal &lt;<a href=3D"mailto:odin@ugedal.com" target=3D=
"_blank">odin@ugedal.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_priv.h |=C2=A0 2 +-<br>
=C2=A0include/linux/device_cgroup.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +=
++++---------<br>
=C2=A0security/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0security/device_cgroup.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 19 ++++++++++++++++---<br>
=C2=A04 files changed, 23 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 4a3049841086..c24cad3c64ed 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -1050,7 +1050,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);<br>
=C2=A0/* Check with device cgroup if @kfd device is accessible */<br>
=C2=A0static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)=
<br>
=C2=A0{<br>
-#if defined(CONFIG_CGROUP_DEVICE)<br>
+#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_device *ddev =3D kfd-&gt;ddev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return devcgroup_check_permission(DEVCG_DEV_CHA=
R, ddev-&gt;driver-&gt;major,<br>
diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h<=
br>
index fa35b52e0002..9a72214496e5 100644<br>
--- a/include/linux/device_cgroup.h<br>
+++ b/include/linux/device_cgroup.h<br>
@@ -1,6 +1,5 @@<br>
=C2=A0/* SPDX-License-Identifier: GPL-2.0 */<br>
=C2=A0#include &lt;linux/fs.h&gt;<br>
-#include &lt;linux/bpf-cgroup.h&gt;<br>
<br>
=C2=A0#define DEVCG_ACC_MKNOD 1<br>
=C2=A0#define DEVCG_ACC_READ=C2=A0 2<br>
@@ -11,16 +10,10 @@<br>
=C2=A0#define DEVCG_DEV_CHAR=C2=A0 2<br>
=C2=A0#define DEVCG_DEV_ALL=C2=A0 =C2=A04=C2=A0 /* this represents all devi=
ces */<br>
<br>
-#ifdef CONFIG_CGROUP_DEVICE<br>
-int devcgroup_check_permission(short type, u32 major, u32 minor,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short access);<br>
-#else<br>
-static inline int devcgroup_check_permission(short type, u32 major, u32 mi=
nor,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 short access)<br>
-{ return 0; }<br>
-#endif<br>
<br>
=C2=A0#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)<br>
+int devcgroup_check_permission(short type, u32 major, u32 minor,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short access);<br>
=C2=A0static inline int devcgroup_inode_permission(struct inode *inode, int=
 mask)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 short type, access =3D 0;<br>
@@ -61,6 +54,9 @@ static inline int devcgroup_inode_mknod(int mode, dev_t d=
ev)<br>
=C2=A0}<br>
<br>
=C2=A0#else<br>
+static inline int devcgroup_check_permission(short type, u32 major, u32 mi=
nor,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short access)<br>
+{ return 0; }<br>
=C2=A0static inline int devcgroup_inode_permission(struct inode *inode, int=
 mask)<br>
=C2=A0{ return 0; }<br>
=C2=A0static inline int devcgroup_inode_mknod(int mode, dev_t dev)<br>
diff --git a/security/Makefile b/security/Makefile<br>
index 22e73a3482bd..3baf435de541 100644<br>
--- a/security/Makefile<br>
+++ b/security/Makefile<br>
@@ -30,7 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0+=3D yama/<br>
=C2=A0obj-$(CONFIG_SECURITY_LOADPIN)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D =
loadpin/<br>
=C2=A0obj-$(CONFIG_SECURITY_SAFESETID)=C2=A0 =C2=A0 =C2=A0 =C2=A0+=3D safes=
etid/<br>
=C2=A0obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)=C2=A0 =C2=A0 +=3D lockdown/<br>
-obj-$(CONFIG_CGROUP_DEVICE)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D =
device_cgroup.o<br>
+obj-$(CONFIG_CGROUPS)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +=3D device_cgroup.o<br>
=C2=A0obj-$(CONFIG_BPF_LSM)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +=3D bpf/<br>
<br>
=C2=A0# Object integrity file lists<br>
diff --git a/security/device_cgroup.c b/security/device_cgroup.c<br>
index 7d0f8f7431ff..43ab0ad45c1b 100644<br>
--- a/security/device_cgroup.c<br>
+++ b/security/device_cgroup.c<br>
@@ -15,6 +15,8 @@<br>
=C2=A0#include &lt;linux/rcupdate.h&gt;<br>
=C2=A0#include &lt;linux/mutex.h&gt;<br>
<br>
+#ifdef CONFIG_CGROUP_DEVICE<br>
+<br>
=C2=A0static DEFINE_MUTEX(devcgroup_mutex);<br>
<br>
=C2=A0enum devcg_behavior {<br>
@@ -792,7 +794,7 @@ struct cgroup_subsys devices_cgrp_subsys =3D {<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
- * __devcgroup_check_permission - checks if an inode operation is permitte=
d<br>
+ * devcgroup_legacy_check_permission - checks if an inode operation is per=
mitted<br>
=C2=A0 * @dev_cgroup: the dev cgroup to be tested against<br>
=C2=A0 * @type: device type<br>
=C2=A0 * @major: device major number<br>
@@ -801,7 +803,7 @@ struct cgroup_subsys devices_cgrp_subsys =3D {<br>
=C2=A0 *<br>
=C2=A0 * returns 0 on success, -EPERM case the operation is not permitted<b=
r>
=C2=A0 */<br>
-static int __devcgroup_check_permission(short type, u32 major, u32 minor,<=
br>
+static int devcgroup_legacy_check_permission(short type, u32 major, u32 mi=
nor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short ac=
cess)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dev_cgroup *dev_cgroup;<br>
@@ -825,6 +827,10 @@ static int __devcgroup_check_permission(short type, u3=
2 major, u32 minor,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+#endif /* CONFIG_CGROUP_DEVICE */<br>
+<br>
+#if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)<br>
+<br>
=C2=A0int devcgroup_check_permission(short type, u32 major, u32 minor, shor=
t access)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc =3D BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(ty=
pe, major, minor, access);<br>
@@ -832,6 +838,13 @@ int devcgroup_check_permission(short type, u32 major, =
u32 minor, short access)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EPERM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return __devcgroup_check_permission(type, major=
, minor, access);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0#ifdef CONFIG_CGROUP_DEVICE<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return devcgroup_legacy_check_permission(type, =
major, minor, access);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0#else /* CONFIG_CGROUP_DEVICE */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0#endif /* CONFIG_CGROUP_DEVICE */<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(devcgroup_check_permission);<br>
+#endif /* defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF) */<b=
r>
-- <br>
2.26.0<br>
<br>
</blockquote></div>

--00000000000069000305a266be95--

--===============0871290676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0871290676==--
