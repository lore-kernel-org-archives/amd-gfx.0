Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2DFEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB9910E41E;
	Wed,  9 Aug 2023 12:07:00 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB5110E41E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:06:58 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a7a180c3faso2036678b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691582818; x=1692187618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbPL3f/SKGrfWLo1kR/zfzIUMY28L8Hb67rotPOMQu4=;
 b=BSlz9i1RwHpC+oohRnKMw+KZQUXXCTxsGknvsffe8eOsFjWEGyrihkfx+hkVmIpmRc
 3wo2w9CxVUt6cQXMA02vyX1M3ajLj2ERi/Yrd8ydRT26eGtL+EeFcNx0sJPhpgOwI6Og
 OmLYvExRoibqDbStZJWIw5qX8kDltLQViHINzUr33vtlQTY7odkE/7ghsfpYGTjFq8St
 fKXvSLHRwHYYOQa6cdOxyZs5FXW9qZ0BxSC5AVbfdPeEsn82SNFbIvDFU4hongXc7vaW
 MwrxAiLLTaVD6yJRdx9xa+r1gdD9I3A0ig7lDmIsu5+Nl1UEN8Gr3BDn0sqvdoM8PYFw
 S0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691582818; x=1692187618;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbPL3f/SKGrfWLo1kR/zfzIUMY28L8Hb67rotPOMQu4=;
 b=EAqn6prVPqHK8CuWHV3LF1Ih8iD4FoADA/leUMazLWpnwyPsyqHMAYZ5gbbsX2zRiJ
 CbUDEZeaK/arBe2aA9uHqwj6nFjfZoGosdM9Mc3Ra8ihHwMLWHrbjPk9XU6KOhQX8AIC
 3B4h5BG6qNWu372F8wy70uuT1/SAiuTZ8ie0CRQlcTE7Bnr3kkPrN9QgtNi6LqQpGTtL
 IIaZUsV8GE8tOxWTpGbr3/37DiOSkbaKlmjLwuUXjw/cyvksyj7k5gRHOkWc/ZCDDq6L
 dELMjLHPnVw2+QSWHBWoVHdTBhv5nz+riblN/XHxSFwEuW+mKG3CWyiJwMCG3P0JEcOq
 spfA==
X-Gm-Message-State: AOJu0YzG4NpRCJ27Tt98BtprGyDvZ0ecOU8S19A032laGFW0X9P7ZPtO
 XylVyBNPn0wfssUmoDXfOBt1LoJdvkab4HYG4LpBDJuX
X-Google-Smtp-Source: AGHT+IHl2AjV0vGVyGNzmsaw5zEsQMqooCC2+EkBkSOhv3i3VEsiTi+XqD4ELvwnqXsVSGJxIDGUHPskNIbZlOtFjy8=
X-Received: by 2002:a05:6808:649:b0:3a7:8510:ecaa with SMTP id
 z9-20020a056808064900b003a78510ecaamr2467695oih.27.1691582818121; Wed, 09 Aug
 2023 05:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230808064025.1008680-1-coelacanth_dream@protonmail.com>
 <DM6PR12MB26194F879FCE037C745B6D97E40DA@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_NdZzofSAoaEg+fZbbn1weELA8acJ++RuekVWH13+YLeA@mail.gmail.com>
 <20230809062525.2346797-1-coelacanth_dream@protonmail.com>
In-Reply-To: <20230809062525.2346797-1-coelacanth_dream@protonmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 08:06:46 -0400
Message-ID: <CADnq5_OEAmaiOHRnOSey1k5qmgkh6VuPkWq6GUGDFjRnJM8zvQ@mail.gmail.com>
Subject: Re: [PATCH] fix throttle_status for other than MP0 11.0.7
To: Umio Yasuno <coelacanth_dream@protonmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 9, 2023 at 3:15=E2=80=AFAM Umio Yasuno
<coelacanth_dream@protonmail.com> wrote:
>
> Sorry, I had mistaken MP1 for MP0.
> Also, should I add an `drm/amdgpu:` or `drm/amdgpu/swsmu` or `drm/amdgpu/=
pm` to
> the prefix of the patch title?

I fixed it up when I applied it.

Thanks,

Alex


>
