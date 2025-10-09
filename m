Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E97CCD18E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2677A10EA18;
	Thu,  9 Oct 2025 12:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="QipIsMDa";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9432410E02C
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 10:00:46 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1760004044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuzURPilJo8vSvl9gt8w8y9Vtfs9Spi+7eSfOYFI33w=;
 b=QipIsMDaJcGV9bsCDokhOdNGdUc6jZSsf2INwXRIW9bdGNEwlnCaast9vDdVCi1F91RaQt
 AZvs5rfQ00FkOoKQphXEOe0ejvI2/xp+SydIHWCO9WF31PLBjppDBLA6DjmpF8E84ZLLku
 +avMO6ua58zXywGY1xTVRnO6T5ChkNg=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Date: Thu, 9 Oct 2025 12:00:29 +0200
Message-Id: <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>
References: <2025100931-retorted-mystified-bd52@gregkh>
Cc: harry.wentland@amd.com, Christian.Koenig@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, simona@ffwll.ch, Alexander.Deucher@amd.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
In-Reply-To: <2025100931-retorted-mystified-bd52@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 09 Oct 2025 12:35:29 +0000
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


>=20
> On Oct 9, 2025, at 11:51=E2=80=AFAM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
>=20
> =EF=BB=BFOn Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:=

>> This fix regressed the original issue that commit d83c747a1225
>> ("drm/amd/display: Fix brightness level not retained over reboot") solved=
,
>> so revert it until a different approach to solve the regression that
>> it caused with AMD_PRIVATE_COLOR is found.
>>=20
>> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgp=
u_dm_init or dm_resume")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>> 2 files changed, 4 insertions(+), 15 deletions(-)
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html=

> for how to do this properly.

Apologies, I was a bit confused by:

If a regression made it into a proper mainline release during the past twelv=
e months, ensure to tag the fix with =E2=80=9CCc: stable@vger.kernel.org=E2=80=
=9D

in the regressions page, but I see now the way I did it via email cc was inc=
orrect.

Should I resend with that fixed?

>=20
> </formletter>
