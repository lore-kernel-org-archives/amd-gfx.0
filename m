Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAC5C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 00:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A220C10E092;
	Tue, 21 Mar 2023 00:30:04 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9275610E092
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 00:30:02 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id cn12so7950502edb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679358601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OFa0bU0rjppvt9eRKWUyfqcgMGloxvhm9DmS5F1WZvc=;
 b=Bhnc/yOFXOqerV6rVosdok/KZBsplWrrbYzYNHRreQ+bxgzXh6bajJDGY/B3XuUpxz
 vGIOmLILglICOR/XwRAbTmgAqm1F+4dUrp8hgrUpWoF7MjTf/XsWthXd5DQ0bf0C6Olx
 Ab0rnGXOpfuelI0SIMAJA5WZSENNJ85Ai9MZF9x6Fv07PTF7YIPQK7G8f4I35lIXAjRP
 k1EfarlPXWqk8eW+veNDOis5gKM4LydRG9BnsY+hYDk7W89jUvwGc2QiIVWbV719KoXd
 FJTHrRq2rghSWFY58F2N5np3At1zxS2tLh2rFeqMpwB9quOUXbPOwZnTKC47kx166XcO
 oOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679358601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OFa0bU0rjppvt9eRKWUyfqcgMGloxvhm9DmS5F1WZvc=;
 b=uu+X4DiDyjkIEpvcaFLyNjESAexbf5uV0maZtVBR42yOU1euIqrBlcCPBOaZ9G39hV
 Y55D9JOQVzuXMicCaJgI0wc0GTvxfy4hSdvopSWYU4srN9T2NjhZTck4DWZHKsdIJPiT
 v0K0s4zgpTM1OyYfZ6JOA8oUfxUIPGOyWvWR7E8flLqUsvi3Xu11trOCfRETHOqE54O8
 NjOrymm38qN4HHrWJDaJ1ShNBprCBUirreAYIdQ+FFKrQdM9tsOAEUyvaevwYS9hjcym
 LN9PwacPRGaYRKae+OCiMO2WDHkiooArzE7gWbaxU5SYkkbB93FZFiRdB1q5gmnjBnjb
 DEfA==
X-Gm-Message-State: AO0yUKW68Ncuyz0Wl1HuoJd9ymivSTBRMt71TmoJE+zsjF79PugjyNPz
 t3O0jWAoLG0q0S9Y5ZJwVHbMFXlGS5DnHk19ewFyydra
X-Google-Smtp-Source: AK7set8cqiseTw6BrZfXHcDjcTIhG6AEn22t7vTT8BOW+Uc9JtptBVp+kdwOBQd1gPm3vMLLXVa/zO9SVRHqd9FbgCU=
X-Received: by 2002:a50:9554:0:b0:4fc:532e:215d with SMTP id
 v20-20020a509554000000b004fc532e215dmr688210eda.6.1679358600962; Mon, 20 Mar
 2023 17:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
In-Reply-To: <20230320173810.250835-8-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 20 Mar 2023 20:29:25 -0400
Message-ID: <CAAxE2A4oPbDtZfCg=PQhT8Et_KN2Wrs0Dz7jiLv-raeH2u9AEQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000dc671205f75e244d"
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

--000000000000dc671205f75e244d
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
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {
>         struct drm_amdgpu_info_video_codec_info
> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>  };
>
> +struct drm_amdgpu_info_cp_gfx_shadow_size {
> +       __u32 shadow_size;
> +       __u32 shadow_alignment;
> +       __u32 csa_size;
> +       __u32 csa_alignment;
> +       __u32 gds_size;
> +       __u32 gds_alignment;
>

Can you document the fields? What is CSA? Also, why is GDS there when the
hw deprecated it and replaced it with GDS registers?

Thanks,
Marek

--000000000000dc671205f75e244d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher &lt;<a href=
=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add UAPI to =
query the GFX shadow buffer requirements<br>
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
22<br>
<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_MASK=C2=A0 0xff<br>
@@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct drm_amdgpu_info_video_codec_info codec_i=
nfo[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];<br>
=C2=A0};<br>
<br>
+struct drm_amdgpu_info_cp_gfx_shadow_size {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 shadow_alignment;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 csa_alignment;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gds_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 gds_alignment;<br></blockquote><div><br><=
/div><div>Can you document the fields? What is CSA? Also, why is GDS there =
when the hw deprecated it and replaced it with GDS registers?</div><div><br=
></div><div>Thanks,</div><div>Marek</div></div></div>

--000000000000dc671205f75e244d--
