Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA8DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 15:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C378560FD8
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 15:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C378560FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DF86E098;
	Fri,  8 Oct 2021 15:50:59 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4796E098
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 15:35:56 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d5600b5f996c39c66b7a4.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:5600:b5f9:96c3:9c66:b7a4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B6AC1EC04B9;
 Fri,  8 Oct 2021 17:35:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1633707354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=FyemXY0AOdlICp0KI0nDs+rgSiJMVPqaGO8BhnjPb6o=;
 b=lcxW2fredBQl+/XQ+czUhGjIofkM75FwTMqqiuee+37/OGvOZVPL7Ce1zOgCObeBOJAiuQ
 00d7Q3B9SSZ2oztutdJIdACD/g9AWECYzvHNgf9gwmZSzmLiAWEeiplAgkghPYWqmizG9b
 KVp5GROArNCvaFvnofDpMp6r2cFFTok=
Date: Fri, 8 Oct 2021 17:35:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Quan, Evan" <Evan.Quan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 xinhui pan <xinhui.pan@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Message-ID: <YWBlVzZK35ecQHNZ@zn.tnic>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
X-Mailman-Approved-At: Fri, 08 Oct 2021 15:50:58 +0000
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

On Fri, Oct 08, 2021 at 11:12:35AM -0400, Alex Deucher wrote:
> Can you try swapping the order of
> amdgpu_device_ip_set_powergating_state() and
> amdgpu_device_ip_set_clockgating_state() in the patch?

Nope, the diff below didn't change things.

Should I comment them out one by one and see whether the clockgating or
the powergating causes it?

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bc571833632e..99e3d697cc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -561,10 +561,10 @@ static int uvd_v6_0_hw_fini(void *handle)
 	} else {
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
 	}
 
 	if (RREG32(mmUVD_STATUS) != 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 9de66893ccd6..a36612357d0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -507,10 +507,10 @@ static int vce_v3_0_hw_fini(void *handle)
 		amdgpu_dpm_enable_vce(adev, false);
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
 	}
 
 	r = vce_v3_0_wait_for_idle(handle);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
