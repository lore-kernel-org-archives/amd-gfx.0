Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA8C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 14:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2AC6127B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 14:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD2AC6127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F76B89BB3;
	Tue, 24 Aug 2021 14:37:13 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92A8899A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 14:36:50 +0000 (UTC)
Received: from zn.tnic (p200300ec2f11440070ccc1d7a1cb5edc.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f11:4400:70cc:c1d7:a1cb:5edc])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F33D41EC030F;
 Tue, 24 Aug 2021 16:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1629815805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hfoMF6SGFqSHpHldUajmgBFLEl1tYqX+l2KPXDR9t9E=;
 b=Qcu1fYJqbKqJ7kYnHDZVTAVyluKJX5rdTFNozSQZEZpJbShdBVDrSsV0tUagP5ekFGm1/4
 oiAZDxtrza60ZKEx5eH+f45J4eP4mstqFQt50EHDeC8FmmiYIVMu1xTeb724y+1L+24dj/
 62OLBED0ZTdaiz5THH119s4sjXcmhOk=
Date: Tue, 24 Aug 2021 16:37:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing
 pm_suspend_target_state module export
Message-ID: <YSUEIriLpcQQYy2k@zn.tnic>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic>
 <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
 <YST2u5UznQjMKulE@zn.tnic>
 <1bb0baef-7924-98ab-b125-aa3c2ac405d4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bb0baef-7924-98ab-b125-aa3c2ac405d4@amd.com>
X-Mailman-Approved-At: Tue, 24 Aug 2021 14:37:11 +0000
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

On Tue, Aug 24, 2021 at 07:22:46PM +0530, Lazar, Lijo wrote:
> 'pm_suspend_target_state' is only available when CONFIG_PM_SLEEP
> is set/enabled.

pm_suspend_target_state is available only when CONFIG_SUSPEND is
enabled. The extern thing is only a forward declaration.

> OTOH, when both SUSPEND and HIBERNATION are not set,
> PM_SLEEP is not set, so this variable cannot be used.

And it will not be used.

> ../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: In function
> ‘amdgpu_acpi_is_s0ix_active’:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1046:11: error:
> ‘pm_suspend_target_state’ undeclared (first use in this function); did you
> mean ‘__KSYM_pm_suspend_target_state’?
>     return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>            ^~~~~~~~~~~~~~~~~~~~~~~
>            __KSYM_pm_suspend_target_state

That looks like the .config didn't have CONFIG_SUSPEND enabled.

> Also use shorter IS_ENABLED(CONFIG_foo) notation for checking the
> 2 config symbols.

What shorter notation?

> So it does look like that error can be extracted as well in some
> config.

Yah, when CONFIG_SUSPEND=n.

> Well, now it doesn't seem to be a better one. The original one checked
> both.

I don't see a reason for checking both.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
