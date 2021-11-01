Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 13:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A9E60551
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 13:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69A9E60551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E925C6E3F2;
	Mon,  1 Nov 2021 13:27:48 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C966E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 13:27:47 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 p11-20020a9d4e0b000000b0055a5741bff7so4401526otf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Nov 2021 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=On9wVOSHp04OBSnTuVGnBnbOiciAS4Dv737PCMXzpPY=;
 b=EGSO9MtWqgpZJ4QEOSbpLP1pr1yf59zqUxP62/MuAIeWAVzKChiM3kRIn4laSFtmzl
 9N8lIzn9LxDwQRBS45hsYHgo5e9hL29zXYvQR9NS70YxLA1O9p/D2S5zoYe9p1trtUHT
 +ZJlkUFk+EZ54DHWq/wtrDORqNBo+qFP0vpzaJNK/cnzL26WhRI5mF9+i7uJTJ8hLdK+
 nZ6QXBmZWH9WWSSJcLc6tdDXYL9Hhy7TgjlLpr4KEHRAHjMx/bC4ZcNBfjOyv4fwt+Dg
 JL/gCjc1k+NABLMOWAQTuKbPT64iFAGNlN4Ef62SQrEmlvdQJwzuamEGFj/L4fe5erct
 1UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=On9wVOSHp04OBSnTuVGnBnbOiciAS4Dv737PCMXzpPY=;
 b=r0gZUf17eRpybYm2wO9kjlmbfnLtFTpsyb0F+Q1YSDCax0CGZagAJ1+g4sZ47ltRZ0
 nFrHT4Ln0S/WgYoBS7juC5IF65JNvemuQPIhVE9ULcLZWhzaIZDNkPJ3gkXia/HkM9OR
 j9b9Z2dp1l2c/1qTn539D1n70Q2k75vLuRZvfwf2GT1e97p+VeuxVtKPDMGujBat4LUR
 YgvE6pH44gNCwmbNr2CL2zePJBXy6O5XVKHSgjuCLabFvJwLRqrW96Hw7qh1BtM0Qmob
 PXgiEMv+rgvxRNiPd4I7oAkYve4ykk2S3QZtxcder8yOa7WAgyQrAqMR6zoNiqiAzrbK
 ofSQ==
X-Gm-Message-State: AOAM530xluH3mLEWHc9NGM9ndrcL9hHOPZ7eMAwZ+FarlvhLGcq7/hKJ
 muYe7AAQUkKmngaCER76Z/J/PkH+y/ndiWC2vj4=
X-Google-Smtp-Source: ABdhPJzLxU450QFlZWhAGZpk4cu1ceNwjZGUuYHqignv9Fx+LiSBcOOw+h8Ikj2tpJ0IMsdVN227ZT+k533X2yUaaRk=
X-Received: by 2002:a05:6830:2aa5:: with SMTP id
 s37mr9707181otu.299.1635773266493; 
 Mon, 01 Nov 2021 06:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211717.28519-1-mario.limonciello@amd.com>
 <DM6PR12MB39307B878DCE0423ADFBBFF397889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <CADnq5_PDhA61gJYTPg3Dn=zy0hrt2ZJJN4TYm5WJRQfACrjDbg@mail.gmail.com>
 <DM6PR12MB3930BB63A500C4E548B697FD97889@DM6PR12MB3930.namprd12.prod.outlook.com>
 <SA0PR12MB4510B9D577B9B4FE3608AD30E28A9@SA0PR12MB4510.namprd12.prod.outlook.com>
 <DM6PR12MB3930080025C79479A766EAFF978A9@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3930080025C79479A766EAFF978A9@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Nov 2021 09:27:35 -0400
Message-ID: <CADnq5_OeFJ5xYgK=evk8x8gDmnRSYdFi6Vik78hg3xU-5r01zA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for YC
 and later APUs
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Right.

Alex

On Sun, Oct 31, 2021 at 11:41 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> There are two subsystems - powerplay and swsmu. The subsystem implementat=
ion details are hidden from amdgpu_pm funcs. I thought Alex is talking abou=
t that.
>
> Thanks,
> Lijo
> ________________________________
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, November 1, 2021 8:16:27 AM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com=
>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for =
YC and later APUs
>
>
> [Public]
>
>
>
> smu_get_power_profile_mode actually calls smu->ppt_funcs->get_power_profi=
le_mode
>
>
>
> So shouldn=E2=80=99t it be sufficient to do this?
>
>
>
>         } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>
>                 if (!adev->smu.ppt_funcs->get_power_profile_mode)
>
>                         *states =3D ATTR_STATE_UNSUPPORTED;
>
>         }
>
>
>
>
>
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Saturday, October 30, 2021 10:06
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedes=
ktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/pm: Don't show pp_power_profile_mode for =
YC and later APUs
>
>
>
> [Public]
>
>
>
> For swsmu, we could add a helper macro like smu_is_supported(x) that chec=
ks if ppt func is not NULL.
>
>
>
> Thanks,
> Lijo
