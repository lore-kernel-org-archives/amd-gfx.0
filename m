Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9ACC432BE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F092760E97
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 20:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F092760E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E18489A9B;
	Mon, 23 Aug 2021 20:30:15 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF7789A9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 20:27:53 +0000 (UTC)
Received: from zn.tnic (p200300ec2f07d9005f98ffa3f2e7b729.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f07:d900:5f98:ffa3:f2e7:b729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2ED421EC01FC;
 Mon, 23 Aug 2021 22:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629750468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=NlwMdfb8DUPYPogP/i1uarjs2jWow9N6Di29V/9QCZo=;
 b=l5maMkyP2FIiTGcBehL2/EUNKYFWpWAc6DY5XFJuc7HGYb6XDNv+99EcJX+brt/5JAsn3f
 i4P+MmdgR74W8b/BevrgFT8UWlu4Iivgpn2YR+MmBaM1Kc7Qp6uXomD612eZ55ITjwOy1u
 2czFO5CF4B3DYSXZb8Sx8zoKTWkJuq8=
Date: Mon, 23 Aug 2021 22:28:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 lkml <linux-kernel@vger.kernel.org>
Subject: Re: ERROR: modpost: "pm_suspend_target_state"
 [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
Message-ID: <YSQE6fN9uO0CIWeh@zn.tnic>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 23 Aug 2021 20:30:14 +0000
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

On Mon, Aug 23, 2021 at 03:49:39PM -0400, Alex Deucher wrote:
> Maybe fixed with this patch?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5706cb3c910cc8283f344bc37a889a8d523a2c6d

Nope, this one is already in:

$ git tag --contains 5706cb3c910cc8283f344bc37a889a8d523a2c6d
v5.14-rc5
v5.14-rc6
v5.14-rc7

also, from only a quick poke so IMHO, the error says:

ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

which means you need the

EXPORT_SYMBOL_GPL(pm_suspend_target_state);

which is in kernel/power/suspend.c which gets enabled with

obj-$(CONFIG_SUSPEND)           += suspend.o

and if you look at PM_SLEEP:

config PM_SLEEP
        def_bool y
        depends on SUSPEND || HIBERNATE_CALLBACKS

(notice the ||)

and my randconfig has:

$ grep -E "(HIBERNATE_CALLBACKS|SUSPEND)" .config
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y

which means, you need:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4137e848f6a2..a9ce3b20d371 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1040,7 +1040,7 @@ void amdgpu_acpi_detect(void)
  */
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 {
-#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_PM_SLEEP)
+#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
        if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
                if (adev->flags & AMD_IS_APU)
                        return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;


but whether that gives you what you want for amdgpu, you probably need
to ponder on a bit.

I sincerely hope that helps a little.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
