Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBB8C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 13:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FCC10E7D4;
	Wed, 12 Apr 2023 13:01:20 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 901BB10E7D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 13:01:18 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1878504c22aso104589fac.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681304476; x=1683896476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mxKclei0w/b0N4uH87WGf+Ujao4UGkT6N1QIAm5x7P4=;
 b=GtrLL28zBItwWPd5a2VUjqRtSL2G1Q2Wj2zcmjN2f1Gb6RKvAmIZRCyZ+GsKDyp7a+
 04qCUJVqAexSfhnt+PSOk+pUKgM5KlLeA+FxvkHDgzAARxdQ4O8HV3z+x5MD16WkmLWh
 GWh8SvL59t2qvhqfB/+n1qkyVAbaTAmdaoFlS0htsHTmQS8n7qC01+CTRD591EUofAOF
 AmIjLfUeIhYWfDnwZBOE0kih2F7XmneEnTTESQJ3RGbO570bP8uw8Wl3Vnqtos9MwwY0
 z06jOHqzM7FsnkKuA2PE1g29TBjLmzUjI2CwQo1FOJv3AJ1B6wY08iFkyzIUOzsMgBXa
 qUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681304476; x=1683896476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxKclei0w/b0N4uH87WGf+Ujao4UGkT6N1QIAm5x7P4=;
 b=5VLm31bD6dMjLMODS42bmzq+jZFn9s8UDviTDrjSP/StYwDt01eq9+pDERhhXpRTtt
 p0BBU37kDZRMl8m3rTsg4RBALyUwsXHmtZqbxIhmWiN859ZFoJ64qGSLtSzo5jK8Ibgz
 N3d9MMlfd4LKT847WxWQJjhoabHQkrfvQVmajp2CicGynZITx2cDuBkpnsoUj2gYuaEX
 xPUhR/2OrRhVHEcAFqEkdGydnlQfRHi5J4wb4zw0cNxlnVUGp1TCJW9XbrX9L8O4/fbG
 NMn2wcSxIA3i/nUBmjw5C25SzTGhtN4D9a26/4LlZDtz19dm3NT+RjrvQZkOQSx1wKSr
 trXg==
X-Gm-Message-State: AAQBX9dxfrbg8m/qGm+DwQoRlPu9r/rnTsEbY4h5vXweX3bkdDdKxqwe
 RBqeWRPR7I/nvLBBg+Es2PjVofsvv2x5l9OVoSc=
X-Google-Smtp-Source: AKy350aNg0IriaO5qefzPxNmPFYqLk/zXH0Dk4aer6o3cqEjRRe/Hm4+ir2xXiAF42w7WPkPXEu5TMpzD1OkJBzNWu4=
X-Received: by 2002:a05:6870:339e:b0:17e:d308:7790 with SMTP id
 w30-20020a056870339e00b0017ed3087790mr1009058oae.11.1681304475799; Wed, 12
 Apr 2023 06:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
In-Reply-To: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Wed, 12 Apr 2023 15:01:04 +0200
Message-ID: <CAD=4a=VJ2V9=RQRtLmrokNx2id67pmbw+DnBe=_W2A7fAtN4rQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="0000000000000a13fb05f92334a6"
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000000a13fb05f92334a6
Content-Type: text/plain; charset="UTF-8"

Sorry if I read this completely wrong, but the other patch says "radv
currently has
a limit of 192 which seems to work for most gfx submissions, but
is way too high for e.g. compute or sdma.", while you return 192 for
AMDGPU_RING_TYPE_COMPUTE
here still?

Regards
//Ernst

Den ons 12 apr. 2023 kl 14:20 skrev Bas Nieuwenhuizen <
bas@basnieuwenhuizen.nl>:

> And ensure each ring supports that many submissions. This makes
> sure that we don't get surprises after the submission has been
> scheduled where the ring allocation actually gets rejected.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 7af3041ccd0e..8362738974c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>         if (r < 0)
>                 return r;
>
> +       if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
> +               return -EINVAL;
> +
>         ++(num_ibs[r]);
>         p->gang_leader_idx = r;
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index dc474b809604..abd70d2f26f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -49,6 +49,25 @@
>   * them until the pointers are equal again.
>   */
>
> +/**
> + * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
> + *
> + * @type: ring type for which to return the limit.
> + */
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> +{
> +       switch (type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +               /* gfx/compute are often used more extensively and radv
> +                * has historically assumed the limit was 192.
> +                */
> +               return 192;
> +       default:
> +               return 50;
> +       }
> +}
> +
>  /**
>   * amdgpu_ring_alloc - allocate space on the ring buffer
>   *
> @@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>         int sched_hw_submission = amdgpu_sched_hw_submission;
>         u32 *num_sched;
>         u32 hw_ip;
> +       unsigned int max_ibs_dw;
>
>         /* Set the hw submission limit higher for KIQ because
>          * it's used for a number of gfx/compute tasks by both
> @@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>                 return r;
>         }
>
> +       max_ibs_dw = ring->funcs->emit_frame_size +
> +                    amdgpu_ring_max_ibs(ring->funcs->type) *
> ring->funcs->emit_ib_size;
> +       max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) &
> ~ring->funcs->align_mask;
> +       max_dw = max(max_dw, max_ibs_dw);
> +
>         ring->ring_size = roundup_pow_of_two(max_dw * 4 *
> sched_hw_submission);
>
>         ring->buf_mask = (ring->ring_size / 4) - 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 3989e755a5b4..e6e672727529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -317,6 +317,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_patch_cond_exec(r,o)
> (r)->funcs->patch_cond_exec((r),(o))
>  #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>
> +unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>  void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
>  void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
> --
> 2.40.0
>
>

--0000000000000a13fb05f92334a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Sorry if I read this completely wrong, but the other pa=
tch says &quot;radv currently has<br>a limit of 192 which seems to work for=
 most gfx submissions, but<br>is way too high for e.g. compute or sdma.&quo=
t;, while you return 192 for AMDGPU_RING_TYPE_COMPUTE</div><div class=3D"gm=
ail_default" style=3D"font-family:arial,helvetica,sans-serif">here still?</=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif"><br></div><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Regards</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">//Ernst<br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den ons 12 apr. 2023=
 kl 14:20 skrev Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuize=
n.nl">bas@basnieuwenhuizen.nl</a>&gt;:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">And ensure each ring supports that many submissions.=
 This makes<br>
sure that we don&#39;t get surprises after the submission has been<br>
scheduled where the ring allocation actually gets rejected.<br>
<br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/2498" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-/=
issues/2498</a><br>
Signed-off-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen=
.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 +++++++++++++++++++++++=
+<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 1 +<br>
=C2=A03 files changed, 29 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index 7af3041ccd0e..8362738974c8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_ibs[r] &gt;=3D amdgpu_ring_max_ibs(chun=
k_ib-&gt;ip_type))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++(num_ibs[r]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;gang_leader_idx =3D r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c<br>
index dc474b809604..abd70d2f26f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
@@ -49,6 +49,25 @@<br>
=C2=A0 * them until the pointers are equal again.<br>
=C2=A0 */<br>
<br>
+/**<br>
+ * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.<b=
r>
+ *<br>
+ * @type: ring type for which to return the limit.<br>
+ */<br>
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_RING_TYPE_GFX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_RING_TYPE_COMPUTE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* gfx/compute are =
often used more extensively and radv<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * has historically=
 assumed the limit was 192.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 192;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 50;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * amdgpu_ring_alloc - allocate space on the ring buffer<br>
=C2=A0 *<br>
@@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct=
 amdgpu_ring *ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int sched_hw_submission =3D amdgpu_sched_hw_sub=
mission;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 *num_sched;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 hw_ip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int max_ibs_dw;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the hw submission limit higher for KIQ b=
ecause<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* it&#39;s used for a number of gfx/compu=
te tasks by both<br>
@@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struc=
t amdgpu_ring *ring,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0max_ibs_dw =3D ring-&gt;funcs-&gt;emit_frame_si=
ze +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdg=
pu_ring_max_ibs(ring-&gt;funcs-&gt;type) * ring-&gt;funcs-&gt;emit_ib_size;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0max_ibs_dw =3D (max_ibs_dw + ring-&gt;funcs-&gt=
;align_mask) &amp; ~ring-&gt;funcs-&gt;align_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0max_dw =3D max(max_dw, max_ibs_dw);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;ring_size =3D roundup_pow_of_two(max_d=
w * 4 * sched_hw_submission);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring-&gt;buf_mask =3D (ring-&gt;ring_size / 4) =
- 1;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index 3989e755a5b4..e6e672727529 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -317,6 +317,7 @@ struct amdgpu_ring {<br>
=C2=A0#define amdgpu_ring_patch_cond_exec(r,o) (r)-&gt;funcs-&gt;patch_cond=
_exec((r),(o))<br>
=C2=A0#define amdgpu_ring_preempt_ib(r) (r)-&gt;funcs-&gt;preempt_ib(r)<br>
<br>
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);<br>
=C2=A0int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);<br>
=C2=A0void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);<br>
=C2=A0void amdgpu_ring_ib_end(struct amdgpu_ring *ring);<br>
-- <br>
2.40.0<br>
<br>
</blockquote></div>

--0000000000000a13fb05f92334a6--
