Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB893CAC598
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 21:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BB810E144;
	Mon, 15 Sep 2025 21:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EXSp1v8+";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEAC10E144
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 21:58:25 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-267716b113bso2176525ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757973505; x=1758578305; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QMnhjLymriLqAQF8EsTjEdjZC44ePyf8XJpqwGSNoY=;
 b=EXSp1v8+JikRkFIbiOpvljYPER3TA7qpUZ5j34J/8+aFsUuUVZEzkoLAne5iej6ScY
 azgYWSZBe3aoe44hhcbBYH5EVoajcRHV0qNEI7DZmk1ogrGGhw7VhKbeio9XZd6eOakn
 X8Z6CKvUnAiXwTwxo0f5/H6BqPQ1FFTDgMnbnU/m7IARtQT/0SUVGPOUegDynonRuEkB
 axehoKy6iEH/U9D4AR8ZhRKO7U2h6g3RK5oc5wAnUfgOAzgMj+3nf1Sb8SRsGTUa4fU1
 DMIM8oxjIU82Q75frofNN6qU2PyJig4Jh7P7MUemQmyBB850kUS/GqPgFoGjTClI6lgM
 CA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757973505; x=1758578305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QMnhjLymriLqAQF8EsTjEdjZC44ePyf8XJpqwGSNoY=;
 b=ZtfcprOyNJSoKbImKJJE4NzSSc75Xh4vKxzdmUy9Xy7Qg48eUY3Z3BnisqNU+8mMsM
 yCyczrPA255pqnn0aNjZzcpyCop/p8/Bg3F74mIgZfAGCY16OB99J5RdIqfqPLbmlbJc
 k/8ogRak5tr+4C9vuiydmxUk7wZAzxPeFnbNW0RfxU/b7A5qOh9uAnz7mCNdO28J401e
 jKe1asexwmCWSe79+aTnwwuh44E47QrQhzQcDN7YVNPPqQEQjgLN1mn6ZSXzCNjxUMo+
 6xruIVFXI90UGjPhYP5Tu8Ui5wItZI73+N+M02+3PBFBBQBXiRfRYvhAcoru0lEEtPXc
 8L6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh/Bc8T07f+nZRnxmrRkEfCP+Sgpo+vah3HY51Fyo9pmQT+FeIF1sAibr5NhKtYlKZ7NH3/4h3@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5br4y4pRv2SjUSCzsMNXdioD8ttFB2YAq+o86WzMTt76rQ0o7
 88b/hJSHTKHPGwOAQiOscYOUl+HdS2WjbIVHVgRwqzBqtmZRNEAwWBWS7u2DKqmh5FaV/a054BP
 5tJieLNfCUjMFMuytiIcdKyLJIyDyP/o=
X-Gm-Gg: ASbGncuvwHry5Mu44oH2rJO3EPbiM+5nLXwkuoNpeGPI16w8CKkT9pSDtrTsePRQnl2
 Ge2g4YejWwXoLTh1+E5IrrHz0F9uO2X9TYQaZWJtuBiixlzzbyfa1Nbr18PT11eCb/GzsiLrD5p
 Z9QZdK4SqFqO2W/KAxl3kv2fC/mP2bRNUjOHI8b+X9KHB6UAXLdiq3um8o+0Yv/cpp2PeAjTdFr
 HRs8NI=
X-Google-Smtp-Source: AGHT+IFWbXWEvx9pTC37a7rWkcCxBx0JZzf8DnLs+4gyIQP+0xuvTbzAj3pVu+ZDxNogJ7M9QZtKViCZw81GEJQv8m8=
X-Received: by 2002:a17:902:c407:b0:24b:142a:c540 with SMTP id
 d9443c01a7336-25d24bafdb3mr99863445ad.1.1757973505165; Mon, 15 Sep 2025
 14:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250910174350.2729341-1-siqueira@igalia.com>
In-Reply-To: <20250910174350.2729341-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 17:58:13 -0400
X-Gm-Features: Ac12FXyMx_JFxGtZwSGs7vpFOxJk9QRIBNAGECJ0F_RFPteZd9Cci1H4LGxyEpw
Message-ID: <CADnq5_OFRLFbcGfJq6kFPqP7xfnsyPi4M6A_e18PcZYj2bRYBQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Use devm_i2c_add_adapter() for amdgpu
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Robert Beckett <bob.beckett@collabora.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

Applied the series.  Thanks!

Alex

On Wed, Sep 10, 2025 at 1:44=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> When discussing the load/unload issue in amdgpu and its fix [1],  Robert
> Beckett suggested the use of devm_i2c_add_adapter(). This function is
> part of Devres [2], and it simplifies resource management when the driver=
 is
> detached. Aside from reducing boilerplate, it also reduces maintenance
> effort and minimizes the likelihood of future load/unload issues
> associated with i2c.
>
> With this idea in mind, this series replaces all the i2c_add_adapter()
> and i2c_del_adapter() with devm_i2c_add_adapter() in amdgpu. The first
> patch is focused on DM, the second patch focuses on the generic
> amdgpu_i2c, and all the other patches are part of the SMU (they share a
> similar code).
>
> [1] - https://gitlab.freedesktop.org/agd5f/linux/-/commit/89923fb7ead4fdd=
37b78dd49962d9bb5892403e6
> [2] - https://docs.kernel.org/driver-api/driver-model/devres.html
>
> Thanks
>
> Rodrigo Siqueira (10):
>   drm/amd/display: Use devm_i2c_add_adapter to simplify i2c cleanup
>     logic
>   drm/amdgpu/amdgpu_i2c: Use devm_i2c_add_adapter instead of
>     i2c_add_adapter
>   drm/amdgpu: Use devm_i2c_add_adapter() in SMU V11
>   drm/amd/pm: Use devm_i2c_add_adapter() in the i2c init
>   drm/amd/pm: Use devm_i2c_add_adapter() in the Arcturus smu
>   drm/amd/pm: Use devm_i2c_add_adapter() in the Navi10 smu
>   drm/amd/pm: Use devm_i2c_add_adapter() in the Sienna smu
>   drm/amd/pm: Use devm_i2c_add_adapter() in the V13 smu
>   drm/amd/pm: Use devm_i2c_add_adapter() in the V13_0_6 smu
>   drm/amd/pm: Use devm_i2c_add_adapter() in the V14_0_2 smu
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       | 18 +++-------------
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  5 +----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++-----------------
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 19 ++---------------
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 19 ++---------------
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 19 ++---------------
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 ++-----------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 19 ++---------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 19 ++---------------
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 19 ++---------------
>  10 files changed, 20 insertions(+), 153 deletions(-)
>
> --
> 2.50.1
>
