Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECABC001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 13:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC1510E0FF;
	Tue,  8 Aug 2023 13:02:19 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1D210E0FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 13:02:18 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a44cccbd96so3911419b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Aug 2023 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691499737; x=1692104537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvpgRFjGqCJkLCqqpcvEP5o38k4G1Zi7slLqYoG9c7E=;
 b=V19J7+lE7hAqs+LH681lGXCK0jZVUVsqXZvRh6/PvQUY9//cd+AKvIzzML2Xbuy+d0
 1HWAvQNSa6kbqrLWA/Phk9pfBC1CsNoX2r/MuJTL+qwt6vJKfl5OuxIT3XkeklGzHFVG
 zYXMa2Ed4ANNYPVrJYhEiNhw/eVyjx7iiikO/aOZmoiV71B9pilIpekwNLFKxiScCNKn
 hzS9xQA7buohUJjqU/FM3aYY10I0DboS2QPtW806fLTncCCeCP2Ai/GTYxEtf9Tbre0a
 RNjHDIqhzRxF7F9tgp6SnmtrMdqgqqtpXfCH+1xSlcDR9ehArbS2Ub/WJIY6ZHnfcp+K
 IcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691499737; x=1692104537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvpgRFjGqCJkLCqqpcvEP5o38k4G1Zi7slLqYoG9c7E=;
 b=ATjnui4rONN4pYx8ktV82jBvB2MPw6Aylli/BiyqswMyyYnCCzcoAePnSpjB3qtmEQ
 k1zphEdk5dAzp8aLj6LcTnpWE7EU7uh/MjP6o4BATWFQeDOaG267DGTWyGEcyp+Ec/iY
 pAp4Ebp8WayqB9yTcbM27PJHJrLYxMLPtnOcvJjlc9AXONo8MsIQL9kUqFUjl1xdQgeb
 SCp5rjVbcJcDWoivZYr9l1N9NUICMF8rdJLxkjuRg5IZMC25HQXpfSTnid9s1r7QC+nY
 vY+zJ9ukpMGePBYIXxtfjat1btZLJksR8+dpxPJqmdAbRLe5kaIsGiJT1TD/CeGO0bS2
 aMzA==
X-Gm-Message-State: AOJu0YyKU7t/i3eue5aj5VXR23j4+qaaicD0OY6nHlp+1wizOBNREjt/
 ZBisFLtk9L2ZJAA5fX4HyJMFnVZIAksxiKMzktw0BYlx
X-Google-Smtp-Source: AGHT+IHrBB1RYmnzsxOIqKTTz6GncgCq3lS+UNOhHTFwyVyU+zc6tC/v3XvPxBqR3WdkSkIFQ8l+zs1zRTEZJwDwUeE=
X-Received: by 2002:a05:6808:13d5:b0:3a1:c108:41b1 with SMTP id
 d21-20020a05680813d500b003a1c10841b1mr17012770oiw.25.1691499737490; Tue, 08
 Aug 2023 06:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807051054.39706-1-Emily.Deng@amd.com>
 <PH0PR12MB541745C29B12508D1190F93F8F0DA@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB541745C29B12508D1190F93F8F0DA@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Aug 2023 09:02:06 -0400
Message-ID: <CADnq5_OtCwYPokcPkso_29qBrYvWnjauCTa1POROqh4azY_x9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
To: "Deng, Emily" <Emily.Deng@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Aug 8, 2023 at 2:43=E2=80=AFAM Deng, Emily <Emily.Deng@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> Ping.....
>
> >-----Original Message-----
> >From: Emily Deng <Emily.Deng@amd.com>
> >Sent: Monday, August 7, 2023 1:11 PM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deng, Emily <Emily.Deng@amd.com>
> >Subject: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
> >
> >Need to move irq resume to the beginning of reset sriov, or if one inter=
rupt
> >occurs before irq resume, then the irq won't work anymore.
> >
> >Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >index 1338489b0b2f..8b304fdfe6db 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >@@ -4617,6 +4617,7 @@ static int amdgpu_device_reset_sriov(struct
> >amdgpu_device *adev,
> >               r =3D amdgpu_virt_reset_gpu(adev);
> >       if (r)
> >               return r;
> >+      amdgpu_irq_gpu_reset_resume_helper(adev);
> >
> >       /* some sw clean up VF needs to do before recover */
> >       amdgpu_virt_post_reset(adev);
> >@@ -4646,7 +4647,6 @@ static int amdgpu_device_reset_sriov(struct
> >amdgpu_device *adev,
> >               amdgpu_put_xgmi_hive(hive);
> >
> >       if (!r) {
> >-              amdgpu_irq_gpu_reset_resume_helper(adev);
> >               r =3D amdgpu_ib_ring_tests(adev);
> >
> >               amdgpu_amdkfd_post_reset(adev);
> >--
> >2.36.1
>
