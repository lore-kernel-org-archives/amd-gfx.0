Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B92CAC5A5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 23:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3C210E034;
	Tue, 23 Sep 2025 23:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JpZiPkgX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA7D10E034
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L1MlqsGeioQfj5JyedxOPJ08ajbTfyvRadJLzjXTDIE=; b=JpZiPkgXy/X3s1AKNKxnYEIQYo
 o0TvhRXRWGIpKkj1ActDktISfXTZb2PEFa9L4rafLCUdcYEfBxdEyg56PoRPduBtxX/M57iunKMEU
 x+07QCn17Go0MWkrkd8kBaS/qSj3stt+jGCyCp2shja6PIn4Ax1PPdrFzBaw7u+NX5YJgq2cvkSsa
 iDAR3nYSaNC3nEVVtRl60Db2iFr8KZKpQFCf2ku0IsBdT7RNXTk8y/jaoxY+7d0ZQxzLtbyG0iU6M
 p7ukbjQlkTN0MVC7TDWIBtPkaIpmYe/OSxJqwz3oX5pgzzYMAzY0gBarHVoVWnkTzd78rCiXLGPjk
 ybdGK7vA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1v1Cer-00GUry-3y; Wed, 24 Sep 2025 01:42:53 +0200
Date: Tue, 23 Sep 2025 17:42:48 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
Message-ID: <vtbslchbxzsl27unpci2h4e2brloakvjmqggnfakwxnccl5zkq@2lbhfaj3dlyp>
References: <20250923211216.306525-1-siqueira@igalia.com>
 <CADnq5_Nk3V=7d4m7nCExc8yLhu1Zz7T08wXpM0qJhJSVAVnuaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Nk3V=7d4m7nCExc8yLhu1Zz7T08wXpM0qJhJSVAVnuaQ@mail.gmail.com>
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

On 09/23, Alex Deucher wrote:
> On Tue, Sep 23, 2025 at 5:12 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> > set of errors happens and the system gets unstable:
> >
> > [..]
> >  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
> >  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx_0.0.0 (-110).
> >  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> > [..]
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> > [..]
> >
> > When the driver initializes the GPU, the PSP validates all the firmware
> > loaded, and after that, it is not possible to load any other firmware
> > unless the device is reset. What is happening in the load/unload
> > situation is that PSP halts the GC engine because it suspects that
> > something is amiss. To address this issue, this commit ensures that the
> > GPU is reset (mode 2 reset) in the load/unload sequence.
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nv.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> > index 50e77d9b30af..1964aa37c499 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -543,6 +543,13 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
> >  {
> >         u32 sol_reg;
> >
> > +       /* GFX in the SteamDeck hangs when amdgpu module is reloaded, since the
> > +        * firmware is already loaded. To avoid this issue, ensure that the
> > +        * device is reset to put the PSP in a good state.
> > +        */
> > +       if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
> > +               return true;
> 
> This will force a reset every time the driver loads.  That will add a
> lot of latency to the driver load sequence.  I think it would be
> better to reset on unload or add a check to see if CP firmware is
> already loaded here so we only reset if the driver has been previously
> loaded.

Hi Alex,

Thanks for the feedback.

First, I tried to call amdgpu_asic_reset() in amdgpu_pci_remove(), and
then in amdgpu_device_fini_hw(). Something like this:

r = amdgpu_asic_reset(adev); // mode 2

However, the situation worsened, causing a hang followed by the
SteamDeck fan to spin really fast, and then the system shut down. In
this sense, do you have any suggestions on which stage I should invoke
the GPU reset in the unload phase? It feels like amdgpu_device_fini_hw()
and amdgpu_pci_remove() are already too late to invoke the GPU reset. Or
maybe the reset operation that I used was not the correct one?

Thanks

> 
> Alex
> 
> > +
> >         if (adev->flags & AMD_IS_APU)
> >                 return false;
> >
> > --
> > 2.51.0
> >

-- 
Rodrigo Siqueira
