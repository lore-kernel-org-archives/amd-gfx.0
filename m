Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FFCCD1A2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 22:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7CA10EAAE;
	Thu, 16 Oct 2025 22:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bVexwIjC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3DE10EAAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iUgzEqgXwNZOQfXkIWNM7+Vhy6krnQ6OepMQAtMW0Go=; b=bVexwIjCMhz6FVz0hOi9IsWl20
 DFw9kuLBehqKwygHbv9AsD5OztFcYmeCr2sxvSYndZ5Pt9LOxbLMY1R1Vlnu7ZAXYLoUZ4gCNQzXQ
 FL19xTjEsWTbgt16GzFTnB1WxJY4SCc16u4fAUwsMTt89rFE7Fr5W8k0NdyomeOxVDKe37KJZ9VUr
 f5Q9a3r2Pjy5qXwsv/wpeZLxBz7yetHsJmpgosFP7bEJDgxsQr26etTOEJpP60Qx5TQiII7jT1aGe
 l6BBLCQ7I6mH79hxOwDV+4JEl6aUGWOL0jeJzF2C8+GhkhfkyBQHegrO8Stnaj6e/l1LKG0H4+RNM
 +OYWFOcA==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1v9WfC-00AehX-1R; Fri, 17 Oct 2025 00:41:38 +0200
Date: Thu, 16 Oct 2025 16:41:34 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
Message-ID: <jpoll7ay7sgnyqlpt5sq7y7dphgqcmy6vjorau7db5ura5nnnu@nmnlursykidl>
References: <20251016210018.901389-1-siqueira@igalia.com>
 <CADnq5_M7xTVfmVf4SaU7sQH4e4qp4M5Ds_g7fvjgr1Sr0v+PKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_M7xTVfmVf4SaU7sQH4e4qp4M5Ds_g7fvjgr1Sr0v+PKw@mail.gmail.com>
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

On 10/16, Alex Deucher wrote:
> On Thu, Oct 16, 2025 at 5:00 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
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
> > GPU is reset (mode 2 reset) in the unload sequence.
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 0d5585bc3b04..78009b93855b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3613,7 +3613,7 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
> >
> >  static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
> >  {
> > -       int i, r;
> > +       int i, r, current_reset_method;
> >
> >         for (i = 0; i < adev->num_ip_blocks; i++) {
> >                 if (!adev->ip_blocks[i].version->funcs->early_fini)
> > @@ -3649,6 +3649,17 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
> >                                 "failed to release exclusive mode on fini\n");
> >         }
> >
> > +       /* Reset the device before entirely removing it to avoid load issues
> > +        * caused by firmware validation.
> > +        */
> > +       current_reset_method = amdgpu_reset_method;
> > +       amdgpu_reset_method = AMD_RESET_METHOD_MODE2;
> 
> This would only be needed if the user has overridden the reset method
> via a kernel module parameter.  If they've done that they get to keep
> the pieces.  MODE2 reset is only used on certain chips so this won't
> work generally. Better to just drop this.  amdgpu_asic_reset() will
> automatically default to the right reset method for the chip.
> Alternative is to set AMD_RESET_METHOD_NONE which is the automatic
> setting.

I'll send a V3 whithout the method mode 2 setup.

Thanks a lot

> 
> Alex
> 
> > +       r = amdgpu_asic_reset(adev);
> > +       if (r)
> > +               dev_err(adev->dev, "asic reset on %s failed\n", __func__);
> > +
> > +       amdgpu_reset_method = current_reset_method;
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.51.0
> >

-- 
Rodrigo Siqueira
