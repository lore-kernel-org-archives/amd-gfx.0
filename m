Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D09C47074
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 18:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5D010E0A3;
	Sun,  7 Jan 2024 18:51:36 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CCE10E0A3
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sUz+0QVkHBY4pG2AAr/KLwUCaKSA8dFj+XVgW7d2Jjg=; b=SWtQPFzjOTHUla4KJNuXiM1PH4
 Wx/WkAiksCm8m/e4tKtWT+P4EotRRCGbuf2e+QKOBxIFtvaMBLDm/TZP+SIBEo0+DPgXUBGv8PD1Q
 2g+/K69+GaHHZHWmJHuDSzkrqr2UjZoLNVH9Cwz59QLAZ/EXLDrvBetqEAca915GuoIGhQSUTnj6Y
 E5C/qd2YSFdvntbx6cqXhz8xtbZkXDlTyAE4qWYHPjDkHpUogrlcCevsVYXIw4Kuhn/sRT7sV7VTA
 /T+M3q2A5a2iocc/9hnrM4nYYR69hRrTnR0IUDqd7ea0FCUEPfa+Glb4gC0bAcLSHcq0U1IYTlQAG
 js0F7pNg==;
Received: from [102.213.205.115] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rMYF9-003y8U-7L; Sun, 07 Jan 2024 19:51:31 +0100
Date: Sun, 7 Jan 2024 17:51:05 -0100
From: Melissa Wen <mwen@igalia.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
Subject: Re: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation
 failure on DCN 2.1"
Message-ID: <ryht25fuarcj5yl4g6fp4cafx4btwvfjchep6nujlaq6omgvu5@p6tnynn2umjz>
References: <20240106004050.1506869-1-ivlipski@amd.com>
 <PH7PR12MB793974E3D84089FD35D19E25E7652@PH7PR12MB7939.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB793974E3D84089FD35D19E25E7652@PH7PR12MB7939.namprd12.prod.outlook.com>
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Choi,
 Nicholas" <Nicholas.Choi@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/06, LIPSKI, IVAN wrote:
> [AMD Official Use Only - General]
> 
> @Siqueira, Rodrigo<mailto:Rodrigo.Siqueira@amd.com>
> ________________________________
> From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
> Sent: January 5, 2024 7:40 PM
> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: rodrigo.siquiera@amd.com <rodrigo.siquiera@amd.com>; Choi, Nicholas <Nicholas.Choi@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Melissa Wen <mwen@igalia.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
> Subject: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation failure on DCN 2.1"
> 
> From: Ivan Lipski <ivlipski@amd.com>
> 
> This commit causes dmesg-warn on several IGT tests on DCN 3.1.6:
> *ERROR* link_enc_cfg_validate: Invalid link encoder assignments - 0x1c
> 
> Affected IGT tests include:
> amdgpu/[amd_assr|amd_plane|amd_hotplug]
> kms_atomic
> kms_color
> kms_flip
> kms_properties
> kms_universal_plane
> 
> and some other tests
> 
> This reverts commit b7ebd39e2922f642c7ee63ade4a4a5a1ef675d84.

I'm not opposed to reverting this in the short term, but I don't see the
connection between doing a full validation and link encoder assignment
errors. It seems more like the change unveiled an underlying issue
rather than causing the error. I don't see those errors on DCN 2.1 and
3.0.1.

Unfortunately, I don't have a DCN 3.1.6 for debugging :( It'd deserve
further investigation.

Melissa

> 
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> 
> Signed-off-by: Ivan Lipski <ivlipski@amd.com>
> 
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d77fc79f3542..111c6f51f0ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10752,7 +10752,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>                          DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
>                          goto fail;
>                  }
> -               status = dc_validate_global_state(dc, dm_state->context, false);
> +               status = dc_validate_global_state(dc, dm_state->context, true);
>                  if (status != DC_OK) {
>                          DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
>                                         dc_status_to_str(status), status);
> --
> 2.34.1
> 
