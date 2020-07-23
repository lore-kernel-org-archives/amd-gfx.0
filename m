Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B852020709
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgnXX4U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B852020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7146E6E0E1;
	Thu, 23 Jul 2020 14:55:27 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E424B6E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 14:55:25 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b6so5452555wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uez/zxm9mCZzFG8NnpnH8JoxtlP8q3ai2rF2yaF8dfU=;
 b=vgnXX4U1HdSdBRSQmwbwrFrgf3v+yejttV0Ii/O7Y/hJIkDSlZ9U68QXeyc1k6z9FS
 315alQ6wuKRt5xndizb4XPljdBi5XLRCjv0puDWgdOtuEhdPPMLmke06wSO3YHT4PA/a
 t/PX8c4/K0pBaJyAFkONvZd8ceGyR4w7440Cv2tlRx0lvG4qsTdjpjUZlwAX079c8deN
 h3SNOSniL9agOQNSHjyZIu7ZDgiK/sYDQBLU0vQ/1ojmvYz6ItWpxHw2mDdT5lRpNvSF
 RUa2tM8zRNv4qOLee88sDw7Z93+os/pY0aYynM9pYGXzFvLgPfIbPfFScytdUjlONTSL
 9rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uez/zxm9mCZzFG8NnpnH8JoxtlP8q3ai2rF2yaF8dfU=;
 b=hKQixXsjFyGTsNnO15Lze303uGvwZv0zB8tv3g9AiuTjxJkn5d1tWafsfpZjQ+fGgU
 a8a75oCw+9I6c0H5nCMFT96sigIbQUVPD8IYF2ojHSFpsfjI8FN87dEutd3mPT3/clir
 AGU1cGDG51VaIWmrGFebJZp/BhA23DjSol9/VrcxU8QZJEAZHL07EGmrTyAN3izXsCrv
 zWDAzpDbxLe+u7k5IfyYqFBdwr7Z4G0zlWYuxMTlHTTZRGuDDeksB1tZ9eg1LFc45pBk
 JcsZtqTIDlRrQSjpM2fngK3oKWABIYeXwQggdZNmhgF0h7Syf0EFL6e/OVrjpbpwCqHq
 gYYg==
X-Gm-Message-State: AOAM530KvO1EEPYzgtpqkwmZZB95oA8y0BFZbYYcwvIW4hhyusP3ZKDF
 koXE9CSabsmdVwACn2ratbkTO8uxuECYebhg+lr3wg==
X-Google-Smtp-Source: ABdhPJwb1ogeycNPVPPBW3FxRs4MNTmv6f5KsrY1s5kwnfkeqnkmDgBfE9PGeW6AVSqCof9+fwkuxYrDcd6lMRKjqYo=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr4321108wrw.362.1595516124522; 
 Thu, 23 Jul 2020 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200710145047.52383-1-nirmoy.das@amd.com>
 <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
 <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
 <43411c44-dce7-e215-5b7e-994d4ff4d1d1@amd.com>
In-Reply-To: <43411c44-dce7-e215-5b7e-994d4ff4d1d1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jul 2020 10:55:13 -0400
Message-ID: <CADnq5_Pgamq_dA6zQVG2JYSa7dACrDgYtNkLsn3nZfGAgTTbng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
To: Nirmoy <nirmodas@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Great.  Thanks for checking.

Alex

On Thu, Jul 23, 2020 at 10:43 AM Nirmoy <nirmodas@amd.com> wrote:
>
> Tested Device passthrough with polaris(rx 570), the patch had no effect.
>
> With or without the patch I could only do passthrough 3 times before the
> host throws
>
> IOMMU error.
>
>
> [ 210.762150] vfio-pci 0000:01:00.1: can't change power state from D0 to
> D3hot (config space inaccessible)
>
> [ 210.762732] vfio-pci 0000:01:00.0: can't change power state from D0 to
> D3hot (config space inaccessible)
>
> [ 210.899735] AMD-Vi: Completion-Wait loop timed out
>
> [ 211.022824] AMD-Vi: Completion-Wait loop timed out
>
> [ 211.145434] AMD-Vi: Completion-Wait loop timed out
>
> [ 211.268250] AMD-Vi: Completion-Wait loop timed out
>
> [ 211.778593] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=01:00.0 address=0x107d5fb50]
>
> [ 212.780494] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=01:00.0 address=0x107d5fb90]
>
> [ 212.781060] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> device=01:00.0 address=0x107d5fbb0]
>
>
> Regards,
>
> Nirmoy
>
> On 7/23/20 4:22 PM, Nirmoy wrote:
> > Hi Alex,
> >
> > On 7/23/20 3:59 PM, Alex Deucher wrote:
> >> Can you check and make sure this doesn't break polaris or some other
> >> generation?
> >
> >
> > Do you mean breaking device passthrough or normal operation ? I have a
> > rx 570,
> >
> > I can test on that.
> >
> >
> > Regards,
> >
> > Nirmoy
> >
> >
> >>
> >> Alex
> >>
> >> On Wed, Jul 15, 2020 at 1:12 AM Quan, Evan <Evan.Quan@amd.com> wrote:
> >>> [AMD Official Use Only - Internal Distribution Only]
> >>>
> >>> Acked-by: Evan Quan <evan.quan@amd.com>
> >>>
> >>> -----Original Message-----
> >>> From: Nirmoy Das <nirmoy.aiemd@gmail.com>
> >>> Sent: Friday, July 10, 2020 10:51 PM
> >>> To: amd-gfx@lists.freedesktop.org
> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> >>> <Evan.Quan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
> >>> Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
> >>>
> >>> For passthrough device,  we do baco reset after 1st vm boot so
> >>> if we disable SMU on 1st VM shutdown baco reset will fail for
> >>> 2nd vm boot.
> >>>
> >>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> index d1adbc45d37b..07be61ce969a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> >>>    * unfortunately we can't detect certain
> >>>    * hypervisors so just do this all the time.
> >>>    */
> >>> -adev->mp1_state = PP_MP1_STATE_UNLOAD;
> >>> +if (!amdgpu_passthrough(adev))
> >>> +adev->mp1_state = PP_MP1_STATE_UNLOAD;
> >>>   amdgpu_device_ip_suspend(adev);
> >>>   adev->mp1_state = PP_MP1_STATE_NONE;
> >>>   }
> >>> --
> >>> 2.27.0
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CNirmoy.Das%40amd.com%7Cf4018ca31bdf481e0bba08d82f1096b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637311095591342103&amp;sdata=PvRVEMzHPeQnQC%2Bf7DI1Y3vnEZLnp9Af%2F07KAIQjKsM%3D&amp;reserved=0
> >>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
