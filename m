Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84CC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 21:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A26A10E083;
	Fri, 28 Aug 2026 21:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVICMMul";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2E010E083
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 21:49:13 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2569aa5116so118534666b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787953752; x=1788558552; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kV8YKidsu5kL7xlD6s9n8kqjs1FZfLe/y03ISSN2PH8=;
 b=QVICMMulmAsnZl4ElOGyuQIzmpp3pbUJgAN+qkcVSKoNSzOqrBK+xJTPaNHepYMAhM
 ew5zTQWe7XvNkiKeY9DTWaX0kJG8CFg8xuCVOsom51df5DVkPPPkliNBbc5uHVFfsm7R
 CK46e1VKPH6x2Tl0bC2yCpyLIkI0XIjU3L/svO8E825krboJDENvp7GkCoop/+I8yXwq
 5uhqHTJl+XnqBgfD09MEBkEVCdIfO7vlqgpGjHahXSKSr1BHVtAtaiuV+WKvrKk+X0YR
 rL8coL3pjQiVgKbrvDimxjWmZpxLGLKHmqY8Fi6qu/gJEX3YTLMlbRUzOgrijx/J8LKK
 zEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787953752; x=1788558552;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kV8YKidsu5kL7xlD6s9n8kqjs1FZfLe/y03ISSN2PH8=;
 b=LfeQTFdbPEvuBTZAGdVA1KeWtw0EiNHmS6C7krc4f8tmhO4XoiIJuKaKjaC70Gatph
 KR2Alwu3Y2q+lPz0Uy6RpBnW4QbboistY/hExvKFd2xywORWbAnYLrWgK7OW5BcZjj6+
 iokAWsi6/hvaGt1LMyUY6dFplRFrPsyITIyPfyWYhNs01g0kb+FzPJl0BK/rJzhnv8UR
 EAFt1Kcb/gjKHjzefiYvLYHwWAOpyZkD0XaRDwsbfUiDG2anPmYmaeDw+m9g3LJb4QO7
 krzfLrYY4FDFVTq17P6hWH/pldoeVGL8Q1c4DqcoSoXmHeTbQYPANkiEoz2Qgf7CiOaB
 e0Mg==
X-Gm-Message-State: AFuF++kQJ8An1mPnJ71FhU80tqPa5vqwEbnH+0L2S8A6wZ9Aq1cBZPqJ
 ZTTTxK6eM5xCbEasd1APrvQyVA/J12Np5uD8wqOZXftBjIcFYN9ezBuF
X-Gm-Gg: AR+sD10nec80ixd+yEgR3msKxtgg0m3eHKF90vZNGbgdLOmKibdBVSPydj2GTNYCY8l
 CqcsdWWyKZ8qbtaCN0nAHDbvpuTuPk/33prHwsirYY8DMFfVT5caecXkyaPcIuVIjz/V1wllZjz
 eUaoPWNd3p4s34TdPk6PLWJ/yqjlQNQkejMZaFsRgcH+g1ADt9RB22kHgF+T2/CClpfiVTkRpD8
 DPqQ5FGyR9zN91zwvRMq+dcNpt5mq099hxjG2rX3Ykt4rGeKqg8Pyh8EjfFnvghuZovadi7cmCg
 t5x0oqtsGERa2bUrSpXot0kqHtjAridvT8sfjcX+IoIvWPw1GyAOnUA0f1Ee7dVFOv1faYLwc8F
 BtA2eSB/TJduV+21T/bPCaGkcvedRNJkBc45ZiLWpbi2PZGWbP2ADFApy+DlF3yT+Nw1Dg/BAwJ
 3F3btz2MMsiGa+jaIlpU1rqVTvmod3yjZeR4R6Zm36yUDuXS7usjDJTk2YvpmQedu59Ee7mz/Iz
 HZmZhpDGaCTmsilmIK6WGv+nRaKTzD74XB54/pvTyy/RVidrFwXWPDI92PbAoGqew==
X-Received: by 2002:a17:906:4784:b0:c1c:49d9:4c34 with SMTP id
 a640c23a62f3a-c25360ae6f6mr1245511266b.11.1787953752033; 
 Fri, 28 Aug 2026 14:49:12 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24E8D1009A9F6421981DD8FC.dsl.pool.telekom.hu.
 [2001:4c4e:24e8:d100:9a9f:6421:981d:d8fc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee09ed8sm133855866b.9.2026.08.28.14.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:49:11 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
Date: Fri, 28 Aug 2026 23:49:10 +0200
Message-ID: <R_iMZNxlTFO2uL1L2693_w@gmail.com>
In-Reply-To: <CADnq5_M9yN5zMm63PAhLpk_QzfKgmqknhRv6MvH0HKWJYXNQDA@mail.gmail.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
 <CADnq5_M9yN5zMm63PAhLpk_QzfKgmqknhRv6MvH0HKWJYXNQDA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. augusztus 28., p=C3=A9ntek 17:52:22 k=C3=B6z=C3=A9p-eur=C3=B3pai n=
y=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> > >=20
> > > Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2
> > > is better. This may not work in the same way for all legacy queues.
> > >=20
> > > Thanks,
> > > Lijo
> >=20
> > Hi,
> >=20
> > As far as I see, this function can be reused for all generations that
> > don't
> > use MES. If you don't think so, please explain why not.
>=20
> I think the context is missing that you want to extend this to older
> generations as well and it's still applicable there.
>=20
> Alex

Yes, I would like to implement queue reset for all SDMA versions and I woul=
d=20
like to extend this function to do that.

My main motivation for this is that we want to enable SDMA for older GPU=20
generations in RADV. The SDMA will see more use, and therefore the kernel=20
needs to handle when the SDMA hangs.

I already have a prototype implementation of the queue reset for SDMA v2 (C=
IK)=20
which makes is much easier to develop the SDMA code in RADV because it can=
=20
recover from hangs without needing me to reboot my computer as I am develop=
ing=20
and testing the code in RADV.

Thanks & best regards,
Timur


