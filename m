Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA20C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 16:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA79A10EA4E;
	Thu, 18 Jul 2024 16:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AK4mHl0F";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E47C10EA4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 16:54:28 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-70af8128081so51671b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721321668; x=1721926468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3P3UxVM4BmSRURNPE3XGDGlnHMgpQCbrwbhi5FtFvGI=;
 b=AK4mHl0F7tXsJeGhTwp2hF5atoJCs6TEf8q4o0rTnf2ZKMTfKqVYqgqMuHtfixycfF
 IeyxXEapcyNqAt8q5lbsgG3/R+kINC5xeTgtdrKaYun/5EhOW/PGyzJRKM1L8IrLnvFP
 m3r2gaVBF/Xojo45lW/9cgTwqvlzb5OdAOZAB1IGrt9SAI5VNePoevHwcbwpb/bdOJa2
 tA+yFwbdND/j7D8PRe+NI2TPy/0qsUfZZs1PpGxgcMQUiCsUU4AEN8PBsoH5ybZOEMEs
 38v1fh8VJvNY9G4KTONnCKHGNH6h09XTth7aXisogU4ksWq+Nm6EUHLnPlO4ZN8XmX33
 Lc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721321668; x=1721926468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3P3UxVM4BmSRURNPE3XGDGlnHMgpQCbrwbhi5FtFvGI=;
 b=QbVBlsMsMqlxCJt3I4kxkF85AXzzEJcbJ23Gx+8jufDLBAs87CEQ7p2L1svYFdJ5E0
 4EqFec1K1xf1EEsGGvbh8f8sgbK9DbjMc3X7gZCdyadcWzSxkFyQPnSH3aSVnAUi7BSa
 lomA2BJJ2iI7YrCy7a4dEbYzvM3P/PG8qI8ztzVUHF/IE1DBks/5+eUso9pybres65+9
 60MYFPGTE5SufgSJF22yd+FvDUFWfQC5UKK18K9zaulbz2gUbFX6YW7rLxVIPjL/L/Du
 fxLad8EdXz2VM04HWf1bzFdMtu0AiNrcHff/ygPfBbBpdInB+1q2iFQEuLq+ynfWYuXF
 iiig==
X-Gm-Message-State: AOJu0YyIjN/UEC5azEzEOp9D3p4WVVjVgEJ2XXnTGUGyJtYHJUUjNjCv
 oFzR/AQ/B4edHgP9YaV3ruq3WRJk1DDw71SdZDoJzS5L0Y5nWAps7oVQmfq0Q0LDj60evCtWnJV
 OCd4cYooZ062YXp3l7fbtiMWVFoLbBhBp
X-Google-Smtp-Source: AGHT+IFHA+QOvUT9UCEumFZjpoywCDyvIzu89uk2UWDIjO+Msi/d/QCeTLWE8kE8eKbFrU4ljrHVnpMFRJ7tbe1GxMU=
X-Received: by 2002:a05:6a21:99a7:b0:1c1:31d0:c7aa with SMTP id
 adf61e73a8af0-1c3fdcf3d4amr6727796637.22.1721321667936; Thu, 18 Jul 2024
 09:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jul 2024 12:54:16 -0400
Message-ID: <CADnq5_NHzGzPe73Ks8au=_up87PTJU11mHpCxVcQBNcWkW-b8w@mail.gmail.com>
Subject: Re: [PATCH 00/34] GC per queue reset
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jul 18, 2024 at 10:15=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> This adds preliminary support for GC per queue reset.  In this
> case, only the jobs currently in the queue are lost.  If this
> fails, we fall back to a full adapter reset.

Also available here via git:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next-q=
ueue-reset

Alex

>
> Alex Deucher (19):
>   drm/amdgpu/mes: add API for legacy queue reset
>   drm/amdgpu/mes11: add API for legacy queue reset
>   drm/amdgpu/mes12: add API for legacy queue reset
>   drm/amdgpu/mes: add API for user queue reset
>   drm/amdgpu/mes11: add API for user queue reset
>   drm/amdgpu/mes12: add API for user queue reset
>   drm/amdgpu: add new ring reset callback
>   drm/amdgpu: add per ring reset support (v2)
>   drm/amdgpu/gfx11: add ring reset callbacks
>   drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>   drm/amdgpu/gfx10: add ring reset callbacks
>   drm/amdgpu/gfx10: rework reset sequence
>   drm/amdgpu/gfx9: add ring reset callback
>   drm/amdgpu/gfx9.4.3: add ring reset callback
>   drm/amdgpu/gfx12: add ring reset callbacks
>   drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>   drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>   drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>   drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>
> Jiadong Zhu (13):
>   drm/amdgpu/gfx11: wait for reset done before remap
>   drm/amdgpu/gfx10: remap queue after reset successfully
>   drm/amdgpu/gfx10: wait for reset done before remap
>   drm/amdgpu/gfx9: remap queue after reset successfully
>   drm/amdgpu/gfx9: wait for reset done before remap
>   drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>   drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>   drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
>   drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>   drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>   drm/amdgpu/mes: modify mes api for mmio queue reset
>   drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>   drm/amdgpu/mes11: implement mmio queue reset for gfx11
>
> Prike Liang (2):
>   drm/amdgpu: increase the reset counter for the queue reset
>   drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125 +++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
>  14 files changed, 930 insertions(+), 32 deletions(-)
>
> --
> 2.45.2
>
