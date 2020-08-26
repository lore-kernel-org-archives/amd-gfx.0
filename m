Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF9EC433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 08:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF7F206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 08:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbhLuHC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF7F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C276EA05;
	Wed, 26 Aug 2020 08:29:45 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561D56E0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 08:29:44 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id mt12so548342pjb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aeW7wBZWZfuCRDPaIAoh9dQimxGhWguqZpvDABTyzRE=;
 b=nbhLuHC4bDxBygmBiD6xkbOiKPb7aapHXldEgSyQsNjdCj4eBrWfCc6w1hfKi3blly
 crV/6oyNO1EgupBi/OMdisCDF9TzztgRAEetn6KQdEOid+usiAmp6XvaNe+LBKgAYBuW
 y9+uo5xB0shaApOHXJOwdbdnwZWCY5oRRo2kmqFLZ5Fy+SE0m6ifg3VMIRTI5XSkHETu
 2O2yXiYusnYHHImSP6WHLa8vKT9Pq2CwF27sj4eNKAzHCODIhmcWecW6ia+1AthvBCe6
 9+3zymXonkzNYYKnlMXjfGECJW2AOak3DgQnQw8/UJHiJVF0iccN2qAoSA1B7Pv5rkUQ
 Jr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aeW7wBZWZfuCRDPaIAoh9dQimxGhWguqZpvDABTyzRE=;
 b=nzXRWCvfUDbJYNmwmkLIoGfMzQcAWJwuQiGIxv2KN7oN+1AObIRhAJdC7ljyTMN5vz
 U44y3yTntSkdzsPd/k8v9WhhpJEvmu7kQ4b3VxwDGW1SaSt9nF44vDIlqtRF51ieloJQ
 TEQrDMZ5vW6NnZSo9JWDyVXfrdgiRrUC3BOfcqsjKM2e+oxP9pzg15Zebgnz0YLSo1rw
 almUAHZ+6kcNEwQZ+ackSoZc3xIpSJsPpvs85F+V0dl+1xmzDri+4Wq1TXV2HpuZlNz/
 1ktX+gmDnZXiXIT8l9yzz/w6XL073Xfj8urwJJW5foxTqlekmhEDTlzCeQr+/XdoRBV9
 5c4w==
X-Gm-Message-State: AOAM533YJQBlfubBg2uJiQo7+AWwR4Wju3vbWXcMFkM9l+5IOEOj5Up5
 2OzpPgbzXI60QADCLwsPa0JpC8sFOBsm2uXtgcOgUpl9
X-Google-Smtp-Source: ABdhPJzXXW/t46whfwO2zHe6J8TS9/XNnvTVNnTYZTb9ZiIo2Yj4KKhSRlfiSLV48pMnBXA5krHUVbnJCyuzotFgmcs=
X-Received: by 2002:a17:90a:a081:: with SMTP id
 r1mr5041040pjp.115.1598430583958; 
 Wed, 26 Aug 2020 01:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200825191223.7795-1-mukul.joshi@amd.com>
In-Reply-To: <20200825191223.7795-1-mukul.joshi@amd.com>
From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius@gmail.com>
Date: Wed, 26 Aug 2020 10:29:32 +0200
Message-ID: <CA+nq7Ds2Xr63Bk_SGiaaFbeT+JzwTwyP=143s=_q4T+zTao2qA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add GPU reset SMI event
To: Mukul Joshi <mukul.joshi@amd.com>
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0474567229=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0474567229==
Content-Type: multipart/alternative; boundary="00000000000027ae9a05adc39fc4"

--00000000000027ae9a05adc39fc4
Content-Type: text/plain; charset="UTF-8"

Hi, see inline comment below.

Den tis 25 aug. 2020 21:12Mukul Joshi <mukul.joshi@amd.com> skrev:

> Add support for reporting GPU reset events through SMI. KFD
> would report both pre and post GPU reset events.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  4 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h       |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 30 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
>  include/uapi/linux/kfd_ioctl.h              |  2 ++
>  5 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e1cd6599529f..aad1ecfa1239 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>         if (!kfd->init_complete)
>                 return 0;
>
> +       kfd_smi_event_update_gpu_reset(kfd, false);
> +
>         kfd->dqm->ops.pre_reset(kfd->dqm);
>
>         kgd2kfd_suspend(kfd, false);
> @@ -833,6 +835,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>         if (!kfd->init_complete)
>                 return 0;
>
> +       kfd_smi_event_update_gpu_reset(kfd, true);
> +
>         ret = kfd_resume(kfd);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 18bc711f97ae..b1a2979e086f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -312,6 +312,8 @@ struct kfd_dev {
>         /* Clients watching SMI events */
>         struct list_head smi_clients;
>         spinlock_t smi_lock;
> +
> +       uint64_t reset_seq_num;
>  };
>
>  enum kfd_mempool {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 4d4b6e3ab697..448abfdde230 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -174,6 +174,36 @@ static void add_event_to_kfifo(struct kfd_dev *dev,
> unsigned int smi_event,
>         rcu_read_unlock();
>  }
>
> +void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
> +{
> +       /*
> +        * GpuReset msg = Reset seq number (incremented for
> +        * every reset message sent before GPU reset).
> +        * 1 byte event + 1 byte space + 16 bytes seq num +
> +        * 1 byte \n + 1 byte \0 = 20
> +        */
> +       char fifo_in[20];
> +       int len;
> +       unsigned int event;
> +
> +       if (list_empty(&dev->smi_clients)) {
> +               return;
> +       }
> +
> +       memset(fifo_in, 0x0, sizeof(fifo_in));
> +
> +       if (post_reset) {
> +               event = KFD_SMI_EVENT_GPU_POST_RESET;
> +       } else {
> +               event = KFD_SMI_EVENT_GPU_PRE_RESET;
> +               ++(dev->reset_seq_num);
> +       }
> +
> +       len = snprintf(fifo_in, 4, "%x %llx\n", event, dev->reset_seq_num);
>

I think the 4 will cause truncation of the message here.

Regards
Nils

+
> +       add_event_to_kfifo(dev, event, fifo_in, len);
> +}
> +
>  void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>                                              uint32_t throttle_bitmask)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index 15537b2cccb5..b9b0438202e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t
> *fd);
>  void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
>  void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>                                              uint32_t throttle_bitmask);
> +void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
>
>  #endif
> diff --git a/include/uapi/linux/kfd_ioctl.h
> b/include/uapi/linux/kfd_ioctl.h
> index cb1f963a84e0..8b7368bfbd84 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -453,6 +453,8 @@ enum kfd_smi_event {
>          KFD_SMI_EVENT_NONE = 0, /* not used */
>          KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
>          KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
> +       KFD_SMI_EVENT_GPU_PRE_RESET = 3,
> +       KFD_SMI_EVENT_GPU_POST_RESET = 4,
>  };
>
>  #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000027ae9a05adc39fc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi, see inline comment below.<br><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den tis 25 aug. 2020 21:1=
2Mukul Joshi &lt;<a href=3D"mailto:mukul.joshi@amd.com">mukul.joshi@amd.com=
</a>&gt; skrev:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Add support for rep=
orting GPU reset events through SMI. KFD<br>
would report both pre and post GPU reset events.<br>
<br>
Signed-off-by: Mukul Joshi &lt;<a href=3D"mailto:mukul.joshi@amd.com" targe=
t=3D"_blank" rel=3D"noreferrer">mukul.joshi@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_device.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 =
+++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_priv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 ++<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 30 ++++++++++++++++++++=
+<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |=C2=A0 1 +<br>
=C2=A0include/uapi/linux/kfd_ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A05 files changed, 39 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e1cd6599529f..aad1ecfa1239 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -812,6 +812,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!kfd-&gt;init_complete)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfd_smi_event_update_gpu_reset(kfd, false);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kfd-&gt;dqm-&gt;ops.pre_reset(kfd-&gt;dqm);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kgd2kfd_suspend(kfd, false);<br>
@@ -833,6 +835,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!kfd-&gt;init_complete)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfd_smi_event_update_gpu_reset(kfd, true);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D kfd_resume(kfd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 18bc711f97ae..b1a2979e086f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -312,6 +312,8 @@ struct kfd_dev {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clients watching SMI events */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head smi_clients;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spinlock_t smi_lock;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t reset_seq_num;<br>
=C2=A0};<br>
<br>
=C2=A0enum kfd_mempool {<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c<br>
index 4d4b6e3ab697..448abfdde230 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
@@ -174,6 +174,36 @@ static void add_event_to_kfifo(struct kfd_dev *dev, un=
signed int smi_event,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rcu_read_unlock();<br>
=C2=A0}<br>
<br>
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * GpuReset msg =3D Reset seq number (increment=
ed for<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * every reset message sent before GPU reset).<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 1 byte event + 1 byte space + 16 bytes seq n=
um +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * 1 byte \n + 1 byte \0 =3D 20<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char fifo_in[20];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int event;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (list_empty(&amp;dev-&gt;smi_clients)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(fifo_in, 0x0, sizeof(fifo_in));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (post_reset) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event =3D KFD_SMI_E=
VENT_GPU_POST_RESET;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event =3D KFD_SMI_E=
VENT_GPU_PRE_RESET;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++(dev-&gt;reset_se=
q_num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D snprintf(fifo_in, 4, &quot;%x %llx\n&qu=
ot;, event, dev-&gt;reset_seq_num);<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I think the 4 will cause truncation of t=
he message here.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards=
</div><div dir=3D"auto">Nils</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_event_to_kfifo(dev, event, fifo_in, len);<b=
r>
+}<br>
+<br>
=C2=A0void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t throttle_bitmask)<br>
=C2=A0{<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.h<br>
index 15537b2cccb5..b9b0438202e2 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
@@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)=
;<br>
=C2=A0void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid=
);<br>
=C2=A0void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t throttle_bitmask);<br>
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);=
<br>
<br>
=C2=A0#endif<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index cb1f963a84e0..8b7368bfbd84 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -453,6 +453,8 @@ enum kfd_smi_event {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KFD_SMI_EVENT_NONE =3D 0, /* not used */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KFD_SMI_EVENT_VMFAULT =3D 1, /* event sta=
rt counting at 1 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KFD_SMI_EVENT_THERMAL_THROTTLE =3D 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KFD_SMI_EVENT_GPU_PRE_RESET =3D 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0KFD_SMI_EVENT_GPU_POST_RESET =3D 4,<br>
=C2=A0};<br>
<br>
=C2=A0#define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL &lt;&lt; ((i) - 1))<br=
>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div></div></div>

--00000000000027ae9a05adc39fc4--

--===============0474567229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0474567229==--
