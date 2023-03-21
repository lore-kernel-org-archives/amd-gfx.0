Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DCEC6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 00:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5D810E35F;
	Tue, 21 Mar 2023 00:31:44 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB39D10E35F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 00:31:42 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id b20so20650842edd.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679358701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nYGxSswtUGawkIPbz7SE9pPxzVtMWIKw2yaxv2vnR7k=;
 b=S74R78KlaRk6FsL0YYOhEoaqY5TKpX07QAyJUgIKryfdvlODGJqgTVlIz0xTsY9MM0
 v9KsHvlr2ec22M6lBUlDPZ36EJh/56bi3jwUqzp0rbfElbAopHmCxcbrDy/nKon/+Uje
 yfhddneMB567B7n1i/iaUSHMMLbbwoF9GIIgcUTFdfMtrTC8xPf849jxd0EEDnrKMeZo
 ZfDRDyGq82PTBbWV+V/abSr6XU+Y3IpG15ibJBzAcrXunuInFrq/tdQU9+enlVyo+s4B
 59wpSOW25NPSlXxjNQ+2ACARYh0q0pC5RWdOJdetY5dvCL4TLTo0xaWyFSbB/n08qHD6
 YvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679358701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYGxSswtUGawkIPbz7SE9pPxzVtMWIKw2yaxv2vnR7k=;
 b=32yNrj4E71OzvYLiBp5XsDrwVZcEVIe6oVnrwTaIkpgsTxcjzTg7ZFVgsqgJEfD2yA
 WyJ7udkUbyH6ltObbrXVi0RsX6KP1qdWuh9RD96quvxldYuYoTaLpp8H7by3KEVxoPlr
 RTF7pgRtxH0RhBH7fJPNrfatuGr7A2rPCezFurHlZYDrBnz1VK4UfwwqaB+PJ/Hf/PV6
 jW/D11RlXcUNLHm2MmX0IBVvoC4Nd1nSEs+9tzFIfonR6QeocMHAc9t4f9fXAWhxMVSk
 CR4zKeKnSVSjDMCGevZTrm+oORx4DXeOsHStB80VdYzNeX6rNtcQqHxobM7cyWutEphy
 UcIg==
X-Gm-Message-State: AO0yUKUQy15HVsutZ9YmkWGJZyCEo/cqv76IEMB8nk5aci8fIFySJBuP
 Or8ODHQwi0c1fYDjWwNS/lGoqeHb2NCZlUERP9X9shQi
X-Google-Smtp-Source: AK7set9qkemyi665jR5HfXih8hvNYI0Ys525YPivj33prC3ENCz9Z2YraHkuw8bsZXLqxOVSaazyyiPUfj7CiTTx1BI=
X-Received: by 2002:a50:a6c5:0:b0:501:c965:33bd with SMTP id
 f5-20020a50a6c5000000b00501c96533bdmr684344edc.6.1679358701186; Mon, 20 Mar
 2023 17:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
In-Reply-To: <20230320173810.250835-8-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 20 Mar 2023 20:31:05 -0400
Message-ID: <CAAxE2A7enKdyE_cBsCwCFZJjSWQZgOGZYCfUT5ShZN2DGa+Qbw@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000d5b41e05f75e2a09"
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000d5b41e05f75e2a09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> Add UAPI to query the GFX shadow buffer requirements
> for preemption on GFX11.  UMDs need to specify the shadow
> areas for preemption.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 3d9474af6566..19a806145371 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>         /* Subquery id: Encode */
>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
>

Can you put this into the device structure instead? Let's minimize the
number of kernel queries as much as possible.

Thanks,
Marek

--000000000000d5b41e05f75e2a09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher &lt;<a href=3D"=
mailto:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Add UAPI to query the GFX shadow buffer requirements<br>
for preemption on GFX11.=C2=A0 UMDs need to specify the shadow<br>
areas for preemption.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 3d9474af6566..19a806145371 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define AMDGPU_INFO_VIDEO_CAPS_DECODE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Subquery id: Encode */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define AMDGPU_INFO_VIDEO_CAPS_ENCODE=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
22<br></blockquote><div><br></div><div>Can you put this into the device str=
ucture instead? Let&#39;s minimize the number of kernel queries as much as =
possible.<br></div><div><br></div><div>Thanks,</div><div>Marek</div><br></d=
iv></div>

--000000000000d5b41e05f75e2a09--
