Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5CE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 17:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7E810E0DA;
	Fri, 10 Jan 2025 17:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZcpDVsh";
	dkim-atps=neutral
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FC010E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 17:18:02 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-85ba2893756so93573241.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736529421; x=1737134221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQq9kRATFNijymim3q+GJ/2Sm8qq9oM9Mt7qEidRwBA=;
 b=WZcpDVshpv4p7ELHwRMbqnPtVUBIYrts6OQpHNoPV7+WV0mlW+ju3Www3q+t0hXm+t
 w9LRDPQiv5JeT3kzw1H4p3L8/Kob+NaaKiq4UUn53pSqOCh3v6OXhliY9v0yKlND+eDm
 aUAdosw4qsn18Zyz7LV3UrymPDy/0VAm0GLInPTmWaO0cRqYllDVD+38CtmADIoRvHJ3
 f9eK2geD58Oc/C3wk+/N+9Ng5jwBldZbK/AgKQzMB+kvZ/KRSQNBYb4imoVZCBzmct6H
 p2jWvDy5MHNNFDAShjaVbynikoayPd8+S7c2N3NUzbLx5o7yZgMgU4p0tWuEa4rbGxl/
 8wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736529421; x=1737134221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQq9kRATFNijymim3q+GJ/2Sm8qq9oM9Mt7qEidRwBA=;
 b=I/h4KxdZmi9qEcUYYXyQEHl4Y5JttHg0CExPenyz45ADVap1GFxa4BAr6iYjNfBi+z
 2EuiRccTOb8GHvWpGrv/aCNQcv5PexguSrtCNqFHXATfmhtHeR+aAsjb3Dx6Hb7Bp1Q/
 O6p70j9Xfu4MRfW6Xhjb+WAHudsRnNYhdCsMSsViE/YhYLmloaOF+yWEbTP+2C+kyw6Q
 IDS1pkuL5vY1+S93U66sdgVaZjq/3Oh8TqRsq292wLTXe4l1FibGM75BTdILPrk8e1p6
 SvKZ2MKNOtiAQcGMggNxnFZ3IgwEBqYF9MNPpgCNma/0jBTXo4v49CFkZduo7gmvu1Mf
 KDHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjZfQwn0CX8Agx2S8qEbWKuJjbk6rc9O03Rb45KBBCr09fV0b83pwyezz01Z1Popyja1zLfsNg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlDoHojLjDZlqY8BN1TiFKs06bVx1fVWVYkTAtRLp95pzF4ogP
 6yIpij0uP+oHndl7vC3qZ9iOixaBxhBEi8tHW6sr35/VaTZ6UN4RfBNGtkgZb50FYjRS9KCBRj7
 d+DB5cibrGLBoEirVuRNQ2u7azc0=
X-Gm-Gg: ASbGncsYPIHv3BtrDQ4Kzv01Z2JkK3YRzRwtYbVbEbBOQzY6Y3UzGNIdIa74WFLRPQu
 Mm1eDULJlZ30MEJrsA0GOroIzSHV7qqMcaFxarg==
X-Google-Smtp-Source: AGHT+IG80xQKKFtP9Vlp03Jv7xNpjTmCwdkjEEs6ytSxKnAoFBxXJ4OOqA6HwKkQ3WkFNvMtJe6FIftrAu4UtJjKDEc=
X-Received: by 2002:ac5:c247:0:b0:518:8277:5f66 with SMTP id
 71dfb90a1353d-51c6c321ed1mr3434457e0c.2.1736529421266; Fri, 10 Jan 2025
 09:17:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
 <9c6f3c11-0782-47f3-ba7e-eb6d8ba66d31@amd.com>
 <C869BCDD-27CD-4A46-8DD3-E364C15F9FF6@linux.alibaba.com>
 <bb3b6949-d5e0-42ec-81a6-2b0c67647147@amd.com>
In-Reply-To: <bb3b6949-d5e0-42ec-81a6-2b0c67647147@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2025 12:16:49 -0500
X-Gm-Features: AbW1kvbE48OeoG4MJvZgLeOdaWg7pSK8lUboj0SoDAoJtJtGFQz-CblyyuHC8SA
Message-ID: <CADnq5_MJWRLAYymMPcmddpSTeYW7zHiHmC5Y0ofP+yABepkROg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] drm/amdgpu: add a flag to track ras debugfs
 creation status
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Gerry Liu <gerry@linux.alibaba.com>, "Koenig,
 Christian" <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com, 
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com, 
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Jan 10, 2025 at 12:10=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 1/9/2025 21:19, Gerry Liu wrote:
> >
> >
> >> 2025=E5=B9=B41=E6=9C=889=E6=97=A5 01:19=EF=BC=8CMario Limonciello <mar=
io.limonciello@amd.com
> >> <mailto:mario.limonciello@amd.com>> =E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 1/8/2025 07:59, Jiang Liu wrote:
> >>> Add a flag to track ras debugfs creation status, to avoid possible
> >>> incorrect reference count management for ras block object  in functio=
n
> >>> amdgpu_ras_aca_is_supported().
> >>
> >> Rather than taking a marker position, why not just check for
> >> obj->fs_data.debugfs_name to be non NULL in amdgpu_ras_fs_fini()?
> > I plan to use marker as a common status track mechanism, so used marker
> > here:)
> >
> >>
> >>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com
> >>> <mailto:gerry@linux.alibaba.com>>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
> >>>  2 files changed, 8 insertions(+), 3 deletions(-)
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/
> >>> amd/amdgpu/amdgpu.h
> >>> index 32941f29507c..2ef7d3102be3 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -378,7 +378,7 @@ enum amdgpu_marker {
> >>> AMDGPU_MARKER_IRQ6=3D 6,
> >>> AMDGPU_MARKER_IRQ7=3D 7,
> >>> AMDGPU_MARKER_IRQ_MAX=3D 47,
> >>> -AMDGPU_MARKER_DEBUGFS=3D 63,
> >>> +AMDGPU_MARKER_RAS_DEBUGFS=3D 63,
> >>
> >> Any particular reason you jumped to 63 in this patch and then counted
> >> down in the next one?  IE why not throw it at 48 (and then 49 for next
> >> one)?
> > I=E2=80=99m not sure how much markers are needed for IRQ, so I split th=
e space
> > into two parts: one for irq and one for others.
>
> I think it's up to Alex and Christian here but as it's all internal to
> amdgpu we can always reassign the enum in the future.
>
> So I think we should just take 48 and 49.  If another IRQ is needed we
> can slot it in at 48 and bump these by 1.

Why explicitly assign numbers to these?  if we just use them as an
enum we can add enums in the future wherever we want in the sequence.

Alex

>
> Alex, Christian, thoughts?
>
> >
> >>
> >>>  };
> >>>    #define AMDGPU_MARKER_INDEX_IRQ(idx)(AMDGPU_MARKER_INDEX_IRQ0 + (i=
dx))
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/
> >>> drm/amd/amdgpu/amdgpu_ras.c
> >>> index 6d52e22691f7..efd72b07a185 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >>> @@ -1996,7 +1996,8 @@ static void amdgpu_ras_debugfs_create(struct
> >>> amdgpu_device *adev,
> >>>  {
> >>> struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head->head);
> >>>  -if (!obj || !dir)
> >>> +if (!obj || !dir ||
> >>> +   amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUG=
FS))
> >>> return;
> >>> get_obj(obj);
> >>> @@ -2007,6 +2008,8 @@ static void amdgpu_ras_debugfs_create(struct
> >>> amdgpu_device *adev,
> >>> debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir=
,
> >>>    obj, &amdgpu_ras_debugfs_ops);
> >>> +
> >>> +amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
> >>>  }
> >>>    static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev=
)
> >>> @@ -2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct
> >>> amdgpu_device *adev)
> >>> if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> >>> list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
> >>> ip_obj =3D amdgpu_ras_find_obj(adev, &con_obj->head);
> >>> -if (ip_obj)
> >>> +if (ip_obj &&
> >>> +   amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
> >>> +    AMDGPU_MARKER_RAS_DEBUGFS))
> >>> put_obj(ip_obj);
> >>> }
> >>> }
> >
>
