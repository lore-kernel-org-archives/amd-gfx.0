Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C584C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 16:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAA610E4A8;
	Mon,  3 Mar 2025 16:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hd9AH2qE";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A23710E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 16:33:35 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2feb700271aso832863a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741019615; x=1741624415; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FFzuSTh4oVwx1/519AdEmEmceXX+V+WTU0+T5yCA/U=;
 b=hd9AH2qE0jsmM/AzityFAEPfpyenr/xY+iFr1ko+XmaJgemfl6uMeT9bQLx5ahNOra
 TyAkgQZzjsaR00eRi/to2NwlzDC0OEeMiaUDKm800RmsuHzwWInBACQsgRiZXNj6tu7Z
 7yQusdsbE+dY9ZTKlifXLYCpuS05wLNPrOM61fiGRHX46tV8fP773CuHP3NSu5+UKpix
 HnOKFJGjnx0ab2GrnTPAZCuGN01FzwgzSQ01p8tpB0pA9+ZU5iTeuCG6jMgIc2xXRP/O
 zn0WTc8Nhv/s1lMMQPy7pYOa60y3HcuepDGU38j5NP8NxfsK3F8WaIKfJs8UZNAWDPWQ
 HhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741019615; x=1741624415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FFzuSTh4oVwx1/519AdEmEmceXX+V+WTU0+T5yCA/U=;
 b=CAQyUVaFzbY7nHFSRoGqDrSVPl0nPzZ3MxvPnCOfbH2UU484L2Q2pKNKsiUzi3TKys
 GIk0FSBdKeKzRx+dKH/c/0IblTjiHSKHcZT0qbiZALdgh8UDKzNYPsUYmXoHb/kfcy6A
 ENDc01aSVk7nURG54vJnxe3gdYdeQ7kn7vqskCj0jmd1KTvW1lHuXhav5I1YyQvKFLNf
 vapWhM/nzl1IcRdEfVjpUXH3zlQsvc7mQhThLjAZjiWDLUyHaNVlFq/mqIu740KKCEWX
 /FArwI4G5xgR657SjVn+FFO5anOlTlfxs7gR8yf4ZlFv/Qed9qcCF4Kuf86GizRhJg4L
 hD/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1W/WAiMse7Tt/bVJ4vKBZstqFBVgH/Wbg+AsRR4BR12pPChcjF/zvHRpvYLVTgdzxLD2PlW/f@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz0ko0PgQypSNpiB8qTKU+F8MubC6Q/XhDyGVy0n0sVhudKs5e
 b4xZwX5tKGtGEd0qO0zC2wfW+FpxE/RnMDAZ40k/47R0sjhuFPSJYFcbLEXaHaa673E9unDp+Vg
 IFWzh7VC1xMAVLgL6ykj5aqjLvxX5/A==
X-Gm-Gg: ASbGnctEEGa/klUJw6xVeigCTOAXHg7GIZcGj8AxMe0Ard+NykA4GSAEkdhuntXD2kc
 AWnMUTSxLNRmLHeY6LyBBIinkTlp56NG51WUVmHq4lwJwe/OhvfG2XaJYb9nuMCi/rByZ3sC7yB
 7ltrWZtp0tnwj8c2jdPYVZC3qm6g==
X-Google-Smtp-Source: AGHT+IGtijCgaPny04z/SPnhtgOn2K0gyIyL6vGI6UMqcoGGd43a1OBRuDY2XyVzI39e8f6gEt7poD+YUAXbkIiy8pM=
X-Received: by 2002:a17:90b:38d0:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2febabe996amr7888471a91.7.1741019614887; Mon, 03 Mar 2025
 08:33:34 -0800 (PST)
MIME-Version: 1.0
References: <20190617214627.2768-1-u9vata@gmail.com>
 <CAAxE2A5h44-iFE=zW3MfWJoCe83ZtiV5m0dCZBg_-5ZkxE4s1w@mail.gmail.com>
In-Reply-To: <CAAxE2A5h44-iFE=zW3MfWJoCe83ZtiV5m0dCZBg_-5ZkxE4s1w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 11:33:23 -0500
X-Gm-Features: AQ5f1JqWCFTOmwtEKuxJ737z5gxOXl9uLbnmz1-pBevzelYM8HMjCgLuheg4oDw
Message-ID: <CADnq5_MGNw1Dn4OzfEMfKVA77a-nZ1SJ64y2vpzoW94c21XL2w@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix rs400_gpu_init for ATI mobility radeon
 Xpress 200M
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Richard Thier <u9vata@gmail.com>, amd-gfx@lists.freedesktop.org
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

Applied with a small tweak to fix a warning.

Thanks,

Alex

On Mon, Mar 3, 2025 at 7:55=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.=
com> wrote:
>
> Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> On Tue, Jun 18, 2019 at 3:19=E2=80=AFAM Richard Thier <u9vata@gmail.com> =
wrote:
>>
>> num_gb_pipes was set to a wrong value using r420_pipe_config
>>
>> This have lead to HyperZ glitches on fast Z clearing.
>>
>> See: https://bugs.freedesktop.org/show_bug.cgi?id=3D110897
>>
>> Signed-off-by: Richard Thier <u9vata@gmail.com>
>> ---
>>  drivers/gpu/drm/radeon/r300.c  |  3 ++-
>>  drivers/gpu/drm/radeon/rs400.c | 21 +++++++++++++++++++--
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300=
.c
>> index 652126f..6724c15 100644
>> --- a/drivers/gpu/drm/radeon/r300.c
>> +++ b/drivers/gpu/drm/radeon/r300.c
>> @@ -355,7 +355,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev=
)
>>         return -1;
>>  }
>>
>> -static void r300_gpu_init(struct radeon_device *rdev)
>> +/* rs400_gpu_init also calls this! */
>> +void r300_gpu_init(struct radeon_device *rdev)
>>  {
>>         uint32_t gb_tile_config, tmp;
>>
>> diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs4=
00.c
>> index 4121209..4117572 100644
>> --- a/drivers/gpu/drm/radeon/rs400.c
>> +++ b/drivers/gpu/drm/radeon/rs400.c
>> @@ -32,6 +32,9 @@
>>  #include "radeon_asic.h"
>>  #include "rs400d.h"
>>
>> +/* Needed for rs400_gpu_init that forwards to the r300 one */
>> +void r300_gpu_init(struct radeon_device *rdev);
>> +
>>  /* This files gather functions specifics to : rs400,rs480 */
>>  static int rs400_debugfs_pcie_gart_info_init(struct radeon_device *rdev=
);
>>
>> @@ -252,8 +255,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rd=
ev)
>>
>>  static void rs400_gpu_init(struct radeon_device *rdev)
>>  {
>> -       /* FIXME: is this correct ? */
>> -       r420_pipes_init(rdev);
>> +       /* Earlier code was calling r420_pipes_init and then
>> +        * rs400_mc_wait_for_idle(rdev). The problem is that
>> +        * at least on my Mobility Radeon Xpress 200M RC410 card
>> +        * that ends up in this code path ends up num_gb_pipes =3D=3D 3
>> +        * while the card seems to have only one pipe. With the
>> +        * r420 pipe initialization method.
>> +        *
>> +        * Problems shown up as HyperZ glitches, see:
>> +        * https://bugs.freedesktop.org/show_bug.cgi?id=3D110897
>> +        *
>> +        * Delegating initialization to r300 code seems to work
>> +        * and results in proper pipe numbers. The rs400 cards
>> +        * are said to be not r400, but r300 kind of cards.
>> +        */
>> +       r300_gpu_init(rdev);
>> +
>>         if (rs400_mc_wait_for_idle(rdev)) {
>>                 pr_warn("rs400: Failed to wait MC idle while programming=
 pipes. Bad things might happen. %08x\n",
>>                         RREG32(RADEON_MC_STATUS));
>> --
>> 2.21.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
