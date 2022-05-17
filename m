Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38109C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D754911205A;
	Tue, 17 May 2022 16:49:06 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A37112099
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:49:05 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-edeb6c3642so24924852fac.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bcgUgHNgXY5Lwd3TlOrbjB/xUcB+pa5/93k0jd8oJ/U=;
 b=nNwxR/EJ6TE04qJCayDaQhkHT/oQ3Tqn0HyBcjXkYqqn8OIOKaqr8Rv/ZUOP9sdl3H
 k32K27P8oUJtusDnORpS98l9rlMVtHRCCTme8Y+y0g1/RuiAcYqGAL9uJAiMWQcvMITX
 yBNlO42DlG95w6yQoH/ZYBWuuKFC2HT0MEO+TWuEMG/9w/g0QF6QQ0xxM20iczr1Bgy8
 mlOGkYggFDvivqAMRi8ygcAEVDjGuip7cXiKBgYiz1AUSronvbgLxE7mKzIcin12AZmh
 vNtfXaf36lwfxIT1htXTgB+6FxhHyiVrj9UCOO6iWH0WeXAdAlgXwsbsQSYOG3QDsQqT
 he4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bcgUgHNgXY5Lwd3TlOrbjB/xUcB+pa5/93k0jd8oJ/U=;
 b=54/m+4Coe7TQqefiablxBloX9DnCjWRDJsdRROj+weGEirMWLj4nYJumlxAxhXkt5y
 cCigpEhHZAEl8jknIdvjsdVPJCncSCN55OXGRWNn/B0jHsTSav28DJjBpEZGRq8zEXwm
 pQbd/CxVmbsG8IAUTxvPgd7reDDLt/qPIBDh/ba2bY9xaRBFKR/KDSuL+Ejo/Ex8QOaO
 ry/5lca0MEAp/YxtuqZ+BVh08UtNQBGxsd3Dej0SLIGgMqj7F4tfLy30zhtGULteqHM1
 LBd9amfMy1qZ6lOv4xO631tlF3ZgjiP0pM/aEheWXg/F+e8LzYUVnX8Th/1VDX0734ho
 1oBQ==
X-Gm-Message-State: AOAM531dVFs0iIRLNuffkzBu7nMyHfCIPsxCnXJjMF5+jZq1389QYBUv
 a3vts5Yt3cyU74BR2XmAnzNZzaB4IrYpX7R4+sHvv+6qBJs=
X-Google-Smtp-Source: ABdhPJwp0/EHjuRFWjpiEIO0SlMBw6fGqNdO9NSlWO78u++hiCP3jZEGPktWtt5oYC2Lb95R6BlvmUnqLR82hR5FD5I=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr13701323oap.253.1652806145097; Tue, 17
 May 2022 09:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 12:48:54 -0400
Message-ID: <CADnq5_PtbSv+4ZH+wMJRki8iMVcirR5n86nYPazKztqLsJ6yhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 12:30 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > PM_SUSPEND_TO_IDLE should be under a compile guard
>
>
>
> It is actually.  All of the amdgpu_acpi_* are.  It=E2=80=99s not obvious =
though looking at the patch, you need to apply it to notice it.
>
>
>
> > It makes sense to rename to something like amdgpu_need_reset_on_suspend=
() as it decides on reset only for a suspend situation.
>
>
>
> Remember it=E2=80=99s in amdgpu_acpi.c.  So it would be amdgpu_acpi_need_=
reset_on_suspend()?  It=E2=80=99s a bit lengthy.


You'll need to add a stub version of the function for the !CONFIG_ACPI
and !CONFIG_SUSPEND case since it's called in amdgpu_drv.c

Alex

>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, May 17, 2022 11:25
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedes=
ktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to=
 s2idle
>
>
>
> [Public]
>
>
>
> A couple of things -
>
>
>
> PM_SUSPEND_TO_IDLE should be under a compile guard
>
>
>
> It makes sense to rename to something like amdgpu_need_reset_on_suspend()=
 as it decides on reset only for a suspend situation.
>
>
>
> Thanks,
> Lijo
