Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A17C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 16:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E633B10E818;
	Fri, 26 May 2023 16:51:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FBC10E818
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685119887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2VFnVsNyMBiLJW3sl37cQkzARH8Hl1Ri81egbddkwco=;
 b=ZEz/+ZM8VDcX+uoDE0JKmyo+N5BMNXXTk0x8bjriiLqZfB5dk4qNk6BbazjU9W9OBjuDKg
 1lrSstrIHQr0ssv+BXpyf4kiCIEUqQskEAe9TjsSETlJYHxGzzJ+LaxQr4lMalDK2nNnM5
 GwEKCCVWGOK1iOZkKH1gDbx/hDXyvvw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-0useklvTPhWfP7Oy_S2z5Q-1; Fri, 26 May 2023 12:51:26 -0400
X-MC-Unique: 0useklvTPhWfP7Oy_S2z5Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b02539087aso4494601fa.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 09:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685119885; x=1687711885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VFnVsNyMBiLJW3sl37cQkzARH8Hl1Ri81egbddkwco=;
 b=Ese1pKysI6GgMUcM5Iv8uBvD7vNTLDPK4mK4D7xShWsYnWzW/EYZQ0jH6TM1F9H97f
 Med7842pMYokStdACvLdofj9U9Z1BZMl/VkcQOdruTH+7TRKz2kvmBLv4sSJY8TWQt2K
 q2CjWwt6OXUvBouAk5N7Fapg2x80zxkLovh3FgAJwigRExhB/TRWnsFfExI2x6ip8CRs
 UfkT3BFNmGHS343ovEKCE9/aBlT4pjr0y2kaT51su5oDClmDQGVgXEU7a1oqoKW+QdVL
 7Ud7q+hnZ5u6kVNGlZqJmMTT1T2Qk5uh6MhWQbK8vacHPN6w5XD5P2SGSxVNhTbuichT
 9QjQ==
X-Gm-Message-State: AC+VfDyOr0yT8Px8w6J4CAI3yx1HHcSCWDn7kNfu2//dAewEgh2MiUKa
 ieLeiEACYlD89zcjVUS4uCyum7cVHXezPHe5gA+iuDpmbh2UhIXDwAaYiOj9U0WrcgRq9FfYkLl
 QC7vrr9dRm/HW9zBtakCwhqELYi+2I/hZgKEFCNisRg==
X-Received: by 2002:a2e:8854:0:b0:2ad:81ca:a52f with SMTP id
 z20-20020a2e8854000000b002ad81caa52fmr763452ljj.47.1685119884816; 
 Fri, 26 May 2023 09:51:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZUJMoHaFSDdaVF/+xNH5IxF0WTKfLu7LPNiAfpaWdPUmoFLTIiIL4SovvzIkRV+BVCbVgSlO4YBgWLfITnQY=
X-Received: by 2002:a2e:8854:0:b0:2ad:81ca:a52f with SMTP id
 z20-20020a2e8854000000b002ad81caa52fmr763446ljj.47.1685119884481; Fri, 26 May
 2023 09:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230525191809.3524-1-harry.wentland@amd.com>
 <20230525191809.3524-3-harry.wentland@amd.com>
 <CA+hFU4xpYguvZi7n48xB3BS-dONShUvDOwBqpM2aZXRAH_DGwQ@mail.gmail.com>
 <oQIftfWjxOOg5ef6hQXufI_hfSvyxhX_Q54ZZSFfzxQKdXKZIwxzPLup5zcTFWzdlQ_bwIrZ5Z2WAy3VYCiI_qoPkvdP0pNUkZCT48NXCbk=@emersion.fr>
In-Reply-To: <oQIftfWjxOOg5ef6hQXufI_hfSvyxhX_Q54ZZSFfzxQKdXKZIwxzPLup5zcTFWzdlQ_bwIrZ5Z2WAy3VYCiI_qoPkvdP0pNUkZCT48NXCbk=@emersion.fr>
From: Sebastian Wick <sebastian.wick@redhat.com>
Date: Fri, 26 May 2023 18:51:13 +0200
Message-ID: <CA+hFU4yzMo8J7nC7D7HkoZjRzOcdQ_XmxiM4s5sBVUB-TwDr3A@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] drm/connector: Add enum documentation to
 drm_colorspace
To: Simon Ser <contact@emersion.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: amd-gfx@lists.freedesktop.org, Melissa Wen <mwen@igalia.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Joshua Ashton <joshua@froggi.es>, Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 26, 2023 at 6:37=E2=80=AFPM Simon Ser <contact@emersion.fr> wro=
te:
>
> On Friday, May 26th, 2023 at 18:27, Sebastian Wick <sebastian.wick@redhat=
.com> wrote:
>
> > > + * @DRM_MODE_COLORIMETRY_DEFAULT:
> > > + * Driver specific behavior.
> > > + * @DRM_MODE_COLORIMETRY_NO_DATA:
> > > + * Driver specific behavior.
> >
> > TBH this is still confusing me. Is DEFAULT really just driver specific
> > behavior? What's the difference to NO_DATA? Is NO_DATA actually not
> > driver-specific but display-specific? I.e. the default colorimetry of
> > the display?
>
> DEFAULT =3D=3D NO_DATA =3D=3D 0
>

*sight* and backwards compat... Alright, not much we can do then.

