Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241CBC6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 14:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8896C10E96E;
	Wed, 22 Mar 2023 14:34:42 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3397210E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 14:34:40 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 cw13-20020a05683068cd00b0069f8c4eecb5so2647794otb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 07:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679495679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hYtEQ6JITp4/OV8BzeMBfYMTSpYVck3PBqUy6Y9hF8=;
 b=n/5Nfyag1iy1NQEnZFR0szjd5IAEhf6WlDDAX4+fLrmsIoDDuoFhMhynyMxOO2PO2w
 rU1MHVSr6Qav24kUjjTA/J8UZ1l4NDF7+o3wjfKQL3g6NHre/tGrFqG+VOswSVsOeQRa
 fAc2llio/QnvoBMoYQIQa3OhRbV4azat0rf6m0BlcX3UV/ecospKP4GMr7K1HOTXvTYC
 znBsyTedY3PGW5wIHuYDDBHpggO1SrVLE06b1iADJIdeaHjXqgKPySiOjYoDf9qVNygJ
 JQ5XwTKgZnb2PgjgspfZPkwspeQF8nLwWIye+HJwiHTKOeSf4SBvfYzSYwLm7774o2SJ
 sERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679495679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hYtEQ6JITp4/OV8BzeMBfYMTSpYVck3PBqUy6Y9hF8=;
 b=TriZEy3cAtfa7b96Wxwel+JRj6p+ajk40EoHf41ay9XJLOM4omIzk0kLyY3A6QMSer
 N2/JIlOh6LaS2JRPpYQGexVW1kNF4o6Nukkc0DPjYWnKe8h7SJNeZiXuFIH6hdInMZ0k
 4oTEMNYpSVurh+dhxR1G8m5Gxxta3bFxplRrObw82Aj0vZYmWX68HhvHqTBNZR+LC5Da
 Z1yfLNjXeAp0wQoMEUvpvq/dg14cb1Cb3+URISA8u6r5jedxCiNIMrFBUTKlz3WQHRRq
 BjFtMUWVv1g9ALgxWXqCyeN/+jzZ4CZ3SJtzd7HmlOjZWKbXnsmAqaVr5+EXBiiNM6nu
 YLgQ==
X-Gm-Message-State: AO0yUKWC/eSCR5O2cyCvpXhqeRfHlJ6qdZKxZ0IODttx39Mow1JsCWjD
 swzFmV2PGxt9aNlA/fcSq2iEHeg2f7eO2qXSmZU=
X-Google-Smtp-Source: AK7set82g9+RpIWnOkMwFYb4CP/MzHjhnxxkV6P8csLh86Hx1oju3g7yCzLLNJ5iQfzxrDjqb2GGI79pnOkU8iXPJ5U=
X-Received: by 2002:a9d:6c48:0:b0:698:f988:7c37 with SMTP id
 g8-20020a9d6c48000000b00698f9887c37mr1176407otq.3.1679495679496; Wed, 22 Mar
 2023 07:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230320173810.250835-1-alexander.deucher@amd.com>
 <20230320173810.250835-8-alexander.deucher@amd.com>
 <CAAxE2A4oPbDtZfCg=PQhT8Et_KN2Wrs0Dz7jiLv-raeH2u9AEQ@mail.gmail.com>
 <CADnq5_N+KZrpaPL8=N+70r6dtwZywC5WmEO00a_1jEBTCmA5zg@mail.gmail.com>
 <CAAxE2A5m+xACjfbBA+GZF7wWss38B5=Dy_jW9sLzBf8XV_8wbA@mail.gmail.com>
In-Reply-To: <CAAxE2A5m+xACjfbBA+GZF7wWss38B5=Dy_jW9sLzBf8XV_8wbA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Mar 2023 10:34:28 -0400
Message-ID: <CADnq5_MEWgn20_ywHR6N2XgqkZXdqDj5BAwdYBTDBew_uHr4Hw@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: add UAPI to query GFX shadow sizes
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 22, 2023 at 10:12=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmai=
l.com> wrote:
>
> On Tue, Mar 21, 2023 at 3:51=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
>>
>> On Mon, Mar 20, 2023 at 8:30=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gm=
ail.com> wrote:
>> >
>> >
>> > On Mon, Mar 20, 2023 at 1:38=E2=80=AFPM Alex Deucher <alexander.deuche=
r@amd.com> wrote:
>> >>
>> >> Add UAPI to query the GFX shadow buffer requirements
>> >> for preemption on GFX11.  UMDs need to specify the shadow
>> >> areas for preemption.
>> >>
>> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> >> ---
>> >>  include/uapi/drm/amdgpu_drm.h | 10 ++++++++++
>> >>  1 file changed, 10 insertions(+)
>> >>
>> >> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
>> >> index 3d9474af6566..19a806145371 100644
>> >> --- a/include/uapi/drm/amdgpu_drm.h
>> >> +++ b/include/uapi/drm/amdgpu_drm.h
>> >> @@ -886,6 +886,7 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>> >>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>> >>         /* Subquery id: Encode */
>> >>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
>> >> +#define AMDGPU_INFO_CP_GFX_SHADOW_SIZE         0x22
>> >>
>> >>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>> >>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>> >> @@ -1203,6 +1204,15 @@ struct drm_amdgpu_info_video_caps {
>> >>         struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INF=
O_VIDEO_CAPS_CODEC_IDX_COUNT];
>> >>  };
>> >>
>> >> +struct drm_amdgpu_info_cp_gfx_shadow_size {
>> >> +       __u32 shadow_size;
>> >> +       __u32 shadow_alignment;
>> >> +       __u32 csa_size;
>> >> +       __u32 csa_alignment;
>> >> +       __u32 gds_size;
>> >> +       __u32 gds_alignment;
>> >
>> >
>> > Can you document the fields? What is CSA? Also, why is GDS there when =
the hw deprecated it and replaced it with GDS registers?
>>
>> Will add documentation.  For reference:
>> CSA (Context Save Area) - used as a scratch area for FW for saving
>> various things
>> Shadow - stores the pipeline state
>> GDS backup - stores the GDS state used by the pipeline.  I'm not sure
>> if this is registers or the old GDS memory.  Presumably the former.
>
>
> 1. The POR for gfx11 was not to use GDS memory. I don't know why it's the=
re, but it would be unused uapi.

It still needs to be allocated because the FW requires it.

>
> 2. Is it secure to give userspace write access to the CSA and shadow buff=
ers? In the case of CSA, it looks like userspace could break the firmware.

Yes, it should be fine. It's the same way it has always been, it's
just that on older chips the kernel mapped them into all of the GPUVMs
because it was global. If the userspace screws it up, they are only
hurting themselves because the FW uses it to save the UMD's hardware
state.

Alex

>
> Marek
