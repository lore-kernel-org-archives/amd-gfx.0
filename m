Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C96BC0755A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Nov 2023 20:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B23E510E0ED;
	Mon, 27 Nov 2023 20:25:57 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC8E10E0ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 20:25:55 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1f060e059a3so2826229fac.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Nov 2023 12:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701116754; x=1701721554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wz0/avnrMni34wGT0X/o2LZH2wAyjXhoW3wqBPUgb/A=;
 b=TvPNKyb6FUhyhgie4BBpqvThB0wlQcyrumcK0ssZ8HvpFo4rAicrz5cnEhF4Yw5pCJ
 CS8X2Kt1+2D3O0IsVw2EER/8i1NR91adK724Zzi/x5fIY9L2ZAaat18vkaesm/8FdLDA
 JFLG3GrM0Gf1+4heSbrksr0k3hWJxtRg+51IQtPhofdG4icsnDMQ6iIv0DN3bUeOfUXS
 mo2oY9ykpHGx+gSme87zPZUULLgssuxlK6CnN+J3YYus7z73e5nQAmncxC6lR3uG/D42
 gStrg4ZWflbpsAs0s21QRDCV8FK7Q3BkyXBxqImz7c8+btilo6vH8d4BzqgTZYZRkPId
 VtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701116754; x=1701721554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wz0/avnrMni34wGT0X/o2LZH2wAyjXhoW3wqBPUgb/A=;
 b=HLVgk33htJ0kmYUIOHji+9tDAkJp5+xbbE9vvYhbOCKdoJuhnT5Nd406Hu7rrDA/bN
 pdivKPLeg/+iPd7CNNnK67KbGb8TF0BaGDebSwe/OvbZOjQRowbEkf3hQ8bMcSVcnOk9
 KvTZ9iFSaNb1ASYNfdT/ZUwbVqguHxlPFJklTvEFAbKpiIaa6xHZAcj8pIx/TXMZ+ocm
 AcaSZIgXPKHjqXtzDXLUlHMKbj3FHd6yQ1chMQXIDxbrxwKNImSBiZpA5xnIZb1me8tL
 dm7spCAN3nK+stowEVksJr5FUrFYE0e1sg3Tnx5tnEqxmm/o6z0jwkdNPdC5VK5xYZXZ
 ywIA==
X-Gm-Message-State: AOJu0Yy8axRDAipZK7Z/AESnqBwlD/+A19yc2XJ+dalOckwc7M7RBSdv
 HNhaMAZ9n10kHuwbVrkYgt3861TjS9SCrgK/+rE=
X-Google-Smtp-Source: AGHT+IENE7w5LKLRrHxsnyaBTytFvkZ3mC0d/ySyos0PRuJbygAIvyF/WpyvZFpT3UevvjNCoib6KPy5tGAzKd60Mfk=
X-Received: by 2002:a05:6871:296:b0:1fa:3b7d:1573 with SMTP id
 i22-20020a056871029600b001fa3b7d1573mr7689871oae.7.1701116754284; Mon, 27 Nov
 2023 12:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20231127184001.3306-1-mario.limonciello@amd.com>
In-Reply-To: <20231127184001.3306-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 15:25:42 -0500
Message-ID: <CADnq5_NSOLLi-rnJOzJmQveF4gGMjpOnPc80Zk0OYsGBdFOhmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Enable PCIe PME from D3
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 27, 2023 at 2:17=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When dGPU is put into BOCO it may be in D3cold but still able send
> PME on display hotplug event. For this to work it must be enabled
> as wake source from D3.
>
> When runpm is enabled use pci_wake_from_d3() to mark wakeup as
> enabled by default.
>
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 5d009175318e..08763f6de482 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2263,6 +2263,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                 pm_runtime_mark_last_busy(ddev->dev);
>                 pm_runtime_put_autosuspend(ddev->dev);
>
> +               pci_wake_from_d3(pdev, TRUE);
> +
>                 /*
>                  * For runpm implemented via BACO, PMFW will handle the
>                  * timing for BACO in and out:
> --
> 2.34.1
>
