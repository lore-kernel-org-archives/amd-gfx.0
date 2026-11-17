Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848A606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WvkQQlxM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58B2C10E608;
	Tue, 17 Nov 2026 15:15:16 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC6910E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:15:09 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-4a7b47eb7b8so96621fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:15:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928509; cv=none;
 d=google.com; s=arc-20260327;
 b=qM/j3rVCfhHdBrkt5SSgE5rv4NSqKp5GuJIux+zFnDOXi9HErT4l6RYoFRwqv2o5a7
 ELz3SanzYp+/4OA/bSHylFdBkbPse4rOKjB2K93MjupbPHHtss5xKrWmfDv9aWPSS/5I
 hRQFVn1FeQji09RdElDfaY4nZsdccsXA4MpjF0vo+0jGYF/Za/6GJxgCZVMVfkhCS+Mm
 QHFoz5ggNhKcdYuZT3kYEyc+GxkZZyE4UYGEsFlQqi4nyGis6ZzSKaiCwj1ekyM7c7H2
 kSu92xX8FpYpakvppYFnLLgssnuqVXraYUviCtZIRjoWhN88iXHd3xFhY7BGPQqaxSRV
 FN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1meKvj6zEbJsuExr5J2gBpHLIaRuEJzf4h7Juxmt43M=;
 fh=3slDxRRHn8EcTayrY/OtbbgFniLBPub6OjMMoIb/+5Q=;
 b=q+er0dJ0CXAKYBsX+4etgGMSaFw5j2bvsjlqtj2hEE0LJEqhbCMRq5sm93QI2YCwWx
 mZ7qvt1HZuIhh6TKZJ4rLxEAhbHjiGU1JpbI8yzB1KiYNRxRIv22PLF7AO6SpBKbmU1n
 cVuVUxIKWr7sZfyjrATpb1gvlM2AiEukpGD3VjzaRQgGaBF2PZiUZaRFP0LktH/+zP9a
 XNkUgjdQsBKpMmNRIz5Rszf9ArFUTARBarelpo5G1GF/Qr5ZjDfINPHLqVVJ0R/UKfXa
 52BMB98hzQmrXbTw24V4hVtxjPYRKkN1BMo7PMf9nJYDLbsJhwQ7Ku6gpmlBL1xUp89k
 Ipbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928509; x=1795533309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1meKvj6zEbJsuExr5J2gBpHLIaRuEJzf4h7Juxmt43M=;
 b=WvkQQlxMWftskfnnqztD2V9XURGPjwcH20ncW6/sMntnxuR74CvSeI0j4blZqyOYUv
 VoTsKnnUn/ZTaBLp97spQfCwN8IesI6/OhIw/mumd3ISVzUNhZDlqXRhpm3CKQwtGGSQ
 bN/yBwhOJh8wFD8Nv4jOPt2N7SgUKFfcH6h0j7RqcoXnCYIjcG6SdwwZVWWIk2pa9cLC
 +N8MPc/fVrPG+etPtjQVCYJAmkEQZjn0+ARPNtG/cafWxcFVn0ATCiH4S80+fRWIBnUL
 wejwYmYCqF19mKYGYi+Y4hq5pQSUQjUIrsO+CVeXSf3FJsw6gclt3ww+ddRa/T7Q4BuH
 1ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928509; x=1795533309;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1meKvj6zEbJsuExr5J2gBpHLIaRuEJzf4h7Juxmt43M=;
 b=eLatOl13om5VVoqeo2oczBzYNW2EnzZ3XBcM3fiHxPV+gJpR4QpiWecjCUAsnndSzn
 Q3RpGub7mhvIC8olPnHzWIPvVZZ+HVevjL36F8JPvyLoc2DC6JT99+ynerj6+ZwNPxgx
 JzWa/dPBUaPv18+XCZr+N5vEPjwS39UXzgDVe8dLc5rML/nTnUh50E/9jsQ34nJxjNHe
 RmLGeupM3mY6RwRxTIyGD/ynCHQwmM+W+Pxkc4o86/R8dW7Jt0wNtGah34jZyy/MgTzv
 mPvseYs19uOsh7iQBV2f3gv+JH2h+q7GJTX5VJaBLLl1tnfZ0/xvaxZNmyu085tCvv/4
 uUxw==
X-Gm-Message-State: APuU4Z8HMmYNORYiBk/8vKOG5VoZzYilZ0dBdakuqBTBQC0d0vSxpX1f
 Vr9A3q9+JW5re/nH8QWIL3Q+ITiSAUfGPdEW9PKY1YiW9Zs1dOinjOFLO34PEZDs+Pfx4U11TGR
 vMyxUuQw0XPq6AS8lwkefT9goCxhOHD4b/CjQ
X-Gm-Gg: AYBFou16EQxUJ+Q+aduMo1KpgKHDIM4Mkw06eQzE+eYLzxa9MsuI3HHL4qKAGRT63Qs
 Z8Y0pmqMiVmKakJ6OIUuurUq+weVwXVojL3XkkI1vUiFyOJfjtQERrckVEONbICx3XgqQwKz6GZ
 8ojqdFSIFQ//tPfgV/PmUuBPq4SCwfRKO0a9KY3PO9kLZ/BmfSFL62w54x7Jw7I9J9mMBPoVGZf
 tbNHw5+LQO5u+6r5i2SUWXWfJBb03s0psiUoveDPxKpXt7qWhSt/8Hn65dj+mYQs2U9TYX1Muf6
 TTFeeIY72PfE1fZufP6mNNc/X6bM3SuUIIt5WDRqiDWiu4tmD7MiCvxMdjv81n0apw1xHRgKNB3
 tkMcBlUZ7DjA9cPraafA+wQK33i+XgUCzA76I+Ux9hif8KNb1DpdnaxndhLx0sadL1YylTcaEZq
 h/LAewewJBV1rLoxSW2ouEBBCvu+kQSHOk4hmdnu7hoc8xxSPSpnkmSfVM2OU=
X-Received: by 2002:a05:6871:eb88:10b0:4a9:2f21:28f4 with SMTP id
 586e51a60fabf-4afdf29678emr12554012fac.2.1794928508474; Tue, 17 Nov 2026
 07:15:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109184113.3656539-1-alexander.deucher@amd.com>
 <20261109184113.3656539-3-alexander.deucher@amd.com>
In-Reply-To: <20261109184113.3656539-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:14:56 -0500
X-Gm-Features: AclHuK810gwmEp-8UrDLCxg6kvCugiXhUc6YWSQtkBWdAJF8GRLYQqZ-hmU3R0A
Message-ID: <CADnq5_N1vSi8tvh76_m1jYE9REFG9sZtNHK=mKFSi2J7qF_E1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add a helper to handle IP version specific
 client id
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lang Yu <lang.yu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 1:51=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Lang Yu <lang.yu@amd.com>
>
> kfd_int_process_v11.c is common for gfx11/12/13,
> while GC VM fault client id is IP version specific.
> gfx13 uses a different GC VM fault client id -
> SOC_V2_0_IH_CLIENTID_GC_UTCL2.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v11.c
> index 24d13a74a181a..224b0e1e38ff5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -255,6 +255,16 @@ static void event_interrupt_poison_consumption_v11(s=
truct kfd_node *dev,
>         amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, re=
set);
>  }
>
> +static inline u32 gc_vm_fault_client_id(struct kfd_node *dev)
> +{
> +       switch (KFD_GC_VERSION(dev)) {
> +       case IP_VERSION(13, 0, 1):
> +               return SOC_V2_0_IH_CLIENTID_GC_UTCL2;
> +       default:
> +               return SOC21_IH_CLIENTID_GFX;
> +       }
> +}
> +
>  static bool event_interrupt_isr_v11(struct kfd_node *dev,
>                                         const uint32_t *ih_ring_entry,
>                                         uint32_t *patched_ihre,
> @@ -299,7 +309,7 @@ static bool event_interrupt_isr_v11(struct kfd_node *=
dev,
>                 source_id =3D=3D SOC21_INTSRC_SDMA_TRAP ||
>                 KFD_IRQ_IS_FENCE(client_id, source_id) ||
>                 (((client_id =3D=3D SOC21_IH_CLIENTID_VMC) ||
> -                ((client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
> +                ((client_id =3D=3D gc_vm_fault_client_id(dev)) &&
>                   (source_id =3D=3D UTCL2_1_0__SRCID__FAULT))) &&
>                   !amdgpu_no_queue_eviction_on_vm_fault);
>  }
> @@ -323,7 +333,7 @@ static void event_interrupt_wq_v11(struct kfd_node *d=
ev,
>
>         /* VMC, UTCL2 */
>         if (client_id =3D=3D SOC21_IH_CLIENTID_VMC ||
> -            ((client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
> +            ((client_id =3D=3D gc_vm_fault_client_id(dev)) &&
>              (source_id =3D=3D UTCL2_1_0__SRCID__FAULT))) {
>
>                 info.vmid =3D vmid;
> --
> 2.56.0
>
