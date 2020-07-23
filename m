Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF1C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E55B20771
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8ikQg/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E55B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA2B6E09F;
	Thu, 23 Jul 2020 14:32:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8455B6E09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 14:32:45 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id x5so4607832wmi.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lXr5gdG8k2Onsnw6XHRVGUYVyW8pviburCW5a5QzeSM=;
 b=r8ikQg/S8lGcemXedf0XOvCkzVGaoPde7oSAhWei1En9UJWpYF8c98L8uuNO0muWN7
 o4uGjTSG3tkWiHajHnToa4lfecOle3GC37HA73A8Joz/WuC8eoWCMs5/yCeNeIh+KLOE
 QxbsLjrv5nM1Lkw2akbaCH1EZt+2D+iamHSpJinJxN8Ku70mJ/meOyNUT0tpFlFiWdlr
 pwu5RHpITvnedpqpuGbT57gRQJcLeMhfpPHfdOCVODyFD7vFaEybyAKVwDQdsYNMECHO
 am2nO4Lxayujq/3eDXqUI/PWGuo4fsCXZ1IWXMDVI1OlaO2M2Se04RZ/bcQwvm1lJhD4
 z+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lXr5gdG8k2Onsnw6XHRVGUYVyW8pviburCW5a5QzeSM=;
 b=Gb0qO1XOfco/FRSq73WL2g85CiWzt5A/KU67ov1WTTpf5I/livfnOkIcAK9jfTaC2V
 8oJ4/KwDzjugw5sjiz5oQuXwROTfDfRXIHSSjTzk9J792IVN3gdph3yZGcDUeoL/BkQi
 7hiSYSjj29DgPVqpkDX30tTtpPKUaDXTJvQHK3tR0gbM1DfOxtkmvN57X08YP4fJDiDQ
 S5IIpE99jAtm34tK5n9nNY7ItAI4g8a9viXQVSo6x69y1FB+RqPJBHbAbAfx7/m1FiKg
 4bOxp6XwdQLoFmSO+DyDphLg4tmXN10Nfc2q2cxNFko6WAJK18wOLnNCfDvRekAXVAPG
 XVGA==
X-Gm-Message-State: AOAM530WdiEEQHEXHBwbSKcEXu173ScppabHZot6d3ecaY8q8/iRiQ8t
 NQQjlUyGHHwgnIUsLwSHvOCdmoEBavFtmU9B9Q1fog==
X-Google-Smtp-Source: ABdhPJz7ti4HUyQX/8zO4vS0ZJfbrxDlKQ05QRThE7MZXbJUwOzYnEu0qmgBDjaPhj1bNmGEaATKY78wVMkVNm/DCEc=
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr1147699wmj.56.1595514764084; 
 Thu, 23 Jul 2020 07:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200710145047.52383-1-nirmoy.das@amd.com>
 <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
 <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
In-Reply-To: <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jul 2020 10:32:32 -0400
Message-ID: <CADnq5_PyiMajtTDdGnO5aV4HdwDTqt55cDEeLudq2NMJSfdGHg@mail.gmail.com>
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

Passthrough.

Thanks,

Alex

On Thu, Jul 23, 2020 at 10:19 AM Nirmoy <nirmodas@amd.com> wrote:
>
> Hi Alex,
>
> On 7/23/20 3:59 PM, Alex Deucher wrote:
> > Can you check and make sure this doesn't break polaris or some other generation?
>
>
> Do you mean breaking device passthrough or normal operation ? I have a
> rx 570,
>
> I can test on that.
>
>
> Regards,
>
> Nirmoy
>
>
> >
> > Alex
> >
> > On Wed, Jul 15, 2020 at 1:12 AM Quan, Evan <Evan.Quan@amd.com> wrote:
> >> [AMD Official Use Only - Internal Distribution Only]
> >>
> >> Acked-by: Evan Quan <evan.quan@amd.com>
> >>
> >> -----Original Message-----
> >> From: Nirmoy Das <nirmoy.aiemd@gmail.com>
> >> Sent: Friday, July 10, 2020 10:51 PM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
> >> Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
> >>
> >> For passthrough device,  we do baco reset after 1st vm boot so
> >> if we disable SMU on 1st VM shutdown baco reset will fail for
> >> 2nd vm boot.
> >>
> >> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> index d1adbc45d37b..07be61ce969a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> >>    * unfortunately we can't detect certain
> >>    * hypervisors so just do this all the time.
> >>    */
> >> -adev->mp1_state = PP_MP1_STATE_UNLOAD;
> >> +if (!amdgpu_passthrough(adev))
> >> +adev->mp1_state = PP_MP1_STATE_UNLOAD;
> >>   amdgpu_device_ip_suspend(adev);
> >>   adev->mp1_state = PP_MP1_STATE_NONE;
> >>   }
> >> --
> >> 2.27.0
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CNirmoy.Das%40amd.com%7Cf4018ca31bdf481e0bba08d82f1096b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637311095591342103&amp;sdata=PvRVEMzHPeQnQC%2Bf7DI1Y3vnEZLnp9Af%2F07KAIQjKsM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
