Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FEFCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 16:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5025A10E159;
	Thu,  9 Oct 2025 16:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ckeZnndr";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ABAD10E159
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 16:55:23 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-74572fb94b3so747970a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760028922; x=1760633722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkuMFF+ARdLGeqHd3hp/V7bl9dj0E28Y1GVyNgYJxMw=;
 b=ckeZnndr73UUtjsNoRSuzDu+QWFHbwcim9NSgvdQlJIegFCNypvnjwyqPH1hWTZnWd
 Hdp+Fb/X5mwpCzNaAuZT7LP8+XiZ1jNfF8bwqY/A853yD0B8Z07vJhbugujC2/CnOVqn
 rkwpmMRX/h87O2SzxlEVZm7KAMpDdOPS5ZzJBfrbXlyM2e/vh+PMAMDelU0+Qi8CAhV/
 2TMXagVhubVlQ6q8S7Ee22BBqGaTtM0DfxO19dYzwEyhPAJUqfqV2u6IJfGVdyNJW6Kb
 BEP/w6oFfD0qk1VOc9wo3gaGR6zAGAlNTUkqw9TSD4yVga/wd6zwiLv09/ZXrE3mD0ds
 nMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028922; x=1760633722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkuMFF+ARdLGeqHd3hp/V7bl9dj0E28Y1GVyNgYJxMw=;
 b=PH/t71q2sCS2Ffb8ZML6dXhHMKRVX3VLJEoAcPYCdlPlPlXFd5xsdEY6mgfagk1s9S
 P0ND3VLZn0EnZMMx1UEBsw/2+rAuOqV4FS/GaRNLQBU/StjsLzAw2rdsb3g+9G2kh9E3
 ravEmmVMpJpQS4pm5GMhshSEVpc7p6eOrVpgT6I5hOCF32janx7JvXMb++TJ5GCI8BQ/
 2HSkPKptzl7/yaCqq/03vIAcLh5i2m8g1wAJxd9uSTH/z63eZW4Ty0aZLLVAnt9J7bHm
 Hf+dtoZgzwBKXl9jeREMW4pnXOL+MUniQOSIk8tRcU/7WOqNSLZSOwiyWng3ZRJ7tVfo
 txqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTmCzpi2NXPFQSz4qenppoqkk2ivYpshjj8FfL2E38BAVo9JEmMosjFKOsrl7iUv2HeTVYVl2R@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6MskXkx5UheujUiHlOigaNXtwGrfD9+2G1/xr1bS2nkb8fmsz
 0uUwg2heN+c+85YWWjxmb+W8mCKbCU+SvT1lmkvkKie2OfsrPggTNvw7FMJWqBXy+YJHg3iI1ZL
 zeNkdknODJZ5A01eO6UUWu7LKWjfMf3k=
X-Gm-Gg: ASbGncvZ4Al3z3ERoGm5Oo9mZoFu/mche5fDBKUyshO1+lV1HLAApoirBBk8SsOEYq4
 +W61gVUYQ2ZHugLMt5ilRYbK6d4/ZJsrTygeq6XtMdfsr2EbcMiiofn6W8xc5KLy74EOsC50GwX
 Amk5J4Lij5t+3XFKPBUQmLfsa6csrriY3F0VcmNl7OWswXy/AOIoA349jz/Ka8Hts8+LBM7ipjp
 DKNCtDCWBT9W8gy4TQmAyiW18bVkBg=
X-Google-Smtp-Source: AGHT+IFMkZ+nCsqEt4qzo0y1lcmJ4WPina77QEmn6wBk+ND1hK1VeaxxVfFe967UJ12KUKWhWhzppgbxAf4MfdeefPU=
X-Received: by 2002:a05:6830:82eb:b0:7bd:235c:5437 with SMTP id
 46e09a7af769-7c0df785071mr4288989a34.17.1760028922160; Thu, 09 Oct 2025
 09:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsO8_GXZQ9tJYZJDbO7oGvsHyVS-32L1PZ7YNL0SrA1RFg@mail.gmail.com>
 <CABXGCsO2Yx1FvyryYU_R=kvS292eCDaLr9j0LHKPtNDkkz28PQ@mail.gmail.com>
 <CH0PR12MB5284060F40235BB4538B51DD8BE0A@CH0PR12MB5284.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5284060F40235BB4538B51DD8BE0A@CH0PR12MB5284.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 9 Oct 2025 21:55:11 +0500
X-Gm-Features: AS18NWA7KS5rr3mBhnA2kzBEHmJmLYjxE7iPPHkG_0LysO5VC4a8kX0WUaMBIGA
Message-ID: <CABXGCsMMg59UXnv0EkmjsiZNUsZUBzBaUR8EnSv4FqOTmpOf7Q@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_6=2E18=2Fregression=2Fbisected_=E2=80=93_BUG=3A_sleeping_funct?=
 =?UTF-8?Q?ion_called_from_invalid_context_at_=2E=2Finclude=2Flinux=2Fsched=2Fmm=2E?=
 =?UTF-8?Q?h=3A321_after_6d31602a9f57?=
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Wu,
 Ray" <Ray.Wu@amd.com>, 
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Li, Roman" <Roman.Li@amd.com>, 
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
 Linux regressions mailing list <regressions@lists.linux.dev>
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

On Tue, Oct 7, 2025 at 10:55=E2=80=AFPM Pillai, Aurabindo
<Aurabindo.Pillai@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Mikhail,
>
> schedule_dc_vmin_vmax() has an allocation which is incorrectly using GFP_=
KERNEL, which is likely the reason for the "sleeping function called from i=
nvalid context". We have a fix queued for this week's update (switching it =
to GFP_NOWAIT).
>

Hi,

Just a quick update regarding the second WARN I mentioned earlier,
triggered at drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:138 amdgpu_vm_set_pasid=
().

After some additional bisecting, I found that this warning first appears
in the merge commit:
342f141ba9f4c9e39de342d047a5245e8f4cda19
Merge: 0faeb8cf99c0 a490c8d77d50
Author: Dave Airlie <airlied@redhat.com>
Date:   Mon Sep 22 08:44:52 2025 +1000
    Merge tag 'amd-drm-next-6.18-2025-09-19' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next

Both merge parents (0faeb8cf from drm-next and a490c8d7 from amd-drm-next)
are clean on my setup =E2=80=94 no WARNs or other regressions.

It turns out that this WARN is triggered by an interaction between the
two sides of the merge.
The AMD branch introduced the new amdgpu_vm_assert_locked(vm) check inside
amdgpu_vm_set_pasid(), while the drm-next side still contained a code path
(for example, through amdgpu_driver_open_kms()) that calls
amdgpu_vm_set_pasid() without holding the expected reservation lock.

As a result, the merge commit combined these two changes and started hittin=
g
the dma_resv_assert_held() check in that function.
Both parents on their own are fine, so this is a merge-only side effect =E2=
=80=94
the stricter locking assertion from AMD=E2=80=99s branch met an older call =
path
from drm-next that doesn=E2=80=99t yet satisfy it.

I verified that removing just the amdgpu_vm_assert_locked(vm) call
from amdgpu_vm_set_pasid() eliminates the WARN completely,
while keeping all other recent VM locking changes intact.

--=20
Best Regards,
Mike Gavrilov.
