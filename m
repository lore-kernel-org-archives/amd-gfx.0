Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D5BCCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 19:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F03910E27A;
	Tue,  7 Oct 2025 19:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JZjUQau6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F8E10E27A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1759865504;
 bh=BZ9iNxj6BLCx8JpKG24s02KzTpxxl33HZp0d1RIVHZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JZjUQau6g+U7BJJA4PbwGP5E+HgV4g1ejjTsrLVZfl1MfgFMFbEcvniRS29LefP2u
 pzqUSw8+oRAm6veAKw6YBnksRvHluN5SkmzoLKUQk0a/oMMl+hGXwRpdeGnD8fUHH6
 nh0WkSgxYvXaJige5iadFkWO29Elhc2JmIGTjVZtaCnEhGilx4jHfZGS3555yvL0LS
 A+cJKQw51DyFzHjkWJ2OXwRxoVC93kdFgOrWTKTLeV0kKisfAhxCQuomOEF/qmmzrO
 EhF4T3Qs2EQYsmpU6ArGquZ/m7HVvYCt1ohxcbvORb3mc0mTJ80ru9z+W5hIZJ5Yh/
 gT8IUG8RI12EA==
Received: from hermes-devbox.lan (unknown [84.18.237.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbeckett)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D86CE17E0A28;
 Tue,  7 Oct 2025 21:31:43 +0200 (CEST)
From: Bob Beckett <bob.beckett@collabora.com>
To: mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Lijo Lazar <Lijo.Lazar@amd.com>, Robert Beckett <bob.beckett@collabora.com>
Subject: Re: Re: [PATCH v2 0/5] Adjustment to power limit setting
Date: Tue,  7 Oct 2025 20:31:10 +0100
Message-ID: <20251007193110.763709-1-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251007164116.371340-1-bob.beckett@collabora.com>
References: <20251007164116.371340-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

--- quoted message ---
> From: Robert Beckett <bob.beckett@collabora.com>
> > Lijo pointed out to me that
> > commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
> > commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
> > both should be unnecessary because smu_restore_dpm_user_profile() already
> > restores them.  However in looking at the code there is a case that isn't
> > properly restored - the FAST PPT limits supported by Van Gogh. The nuance
> > isn't immediately obvious because the limit variable is overloaded with
> > limit type.
> > This series attempts to address that issue by passing limit type around
> > and saving/restoring both types.
> > Cc: Lijo Lazar <Lijo.Lazar@amd.com>
> > Mario Limonciello (5):
> >   drm/amd: Remove some unncessary header includes
> >   drm/amd: Stop overloading power limit with limit type
> >   drm/amd: Save and restore all limit types
> >   drm/amd: Drop calls to restore power limit and clock from smu_resume()
> >   drm/amd: Adjust whitespace for vangogh_ppt
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
> >  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 13 +++---
> >  8 files changed, 29 insertions(+), 42 deletions(-)
> > -- 
> > 2.51.0
> entire series
> Tested-by: Robert Beckett <bob.beckett@collabora.com>

apologies, I need to retract this Tested-by.
I inadvertently tested v1. v2 looks like it still has the restore issue.
I'll debug and get back to you.
