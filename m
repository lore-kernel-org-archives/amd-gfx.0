Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60675C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B4810EF2D;
	Wed, 15 Jul 2026 08:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4yDGI8Y";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E336710EF2D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:10:01 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so45614425e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784103000; x=1784707800; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=waFXj9Mo2E0omsohEobNIGOJAzbb9TXo8QmtYQhOjlI=;
 b=P4yDGI8Y3Q0zMMIlES3BWg1T3dQuDm86dKhVeNBbPWSTEw2eIt3whA2LChc9i6qSF8
 23WR3U1kYL+MmXms6EvgcdJtl0PeZ21EcvZBG4cZMOPM9k7OxEwu0rNUpdxKvRSZWuGw
 7KleCNdyjHqgd16N0rdtsLGDdCilskAd7ciwS8IXQRn5Q36zjSW7jaYPQMm1Q4rozOQ7
 QDUmbifdweVXd6pCbrosHzl8gOzmbGgLEWm1z7eFpnWpApBkt7Z2NHHAHYAV7XCMLFHo
 QFGuDiECmLlz9bcMNvroYEnzUGE17Fq766HIGR+isxLUYL6e2CVd0GIbY/1ktH0ZHKIC
 0gBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784103000; x=1784707800;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=waFXj9Mo2E0omsohEobNIGOJAzbb9TXo8QmtYQhOjlI=;
 b=O/e9G9ytK19ALeAaqFwbHvLZDG+ZaJaQ2pfi/r1gisJa855fVxfkSacdzv2wlrBFif
 lZ/lEhjkso12fHyZ4DrrDlqcU17mbKNYF0jV3tKiE9Xd5siwb4euPkBjmcEovV7t3xUS
 Z4lYMuvO6L8RJKDLp4M3sOSRoaMG5P8KHV47qHD50Oly+WAjErmBeQ5rcoUfBUq7uCph
 NoW2gF9pxW925ALUMAFvvCbUNoxLo6XpMyw9ornfC5Qt1cCH51bJ/Rt7qQ76hi1YHCYB
 jRWBVYNZFJKMngrlUdzO8PWsWkP2SKrDasXsJnnZia/K2cMCKKsbK5sf31wTHL/rcN7i
 2QiA==
X-Gm-Message-State: AOJu0YxSO3D4CfD6E0pmJtELY6+t6QJ8ET/ILEuGEOfFFUsyVK8Hq5ZT
 GNVg47eIw+reY8TudXJ4gN6MqhgPqHL/6Jy7dealHg5NO/2FCJBepRBFlXM1pQ==
X-Gm-Gg: AfdE7clMArKwDcvqTRUQTQa+xubDgvXRtpHFJFgCdlBncR1ETSKjldlHo9GCMErhn3B
 tR4hJRS6c3t52X+nYc7ok2w3EwVVNf3ECmcVvzOh4m1CcYOTjRH/tl9izTjbumstKyvaL43kXV4
 jS97Lco7VzaiUJgLwY3jZUUS3ZTeX4tWQJg1rn0ZPTDXYEfxgzw+GV+vgwYGWrN6PYX2JDtJEpT
 JeffPLGUhtORR4OdtzpZENv2T78rnhe+CrdL3FJAHRnQoyKbP10ACWm8hBf4yOpypr16FdP15IZ
 o62wwH06CZvQK0x7RJI/y/AMl9bQhBwRlhoFKzNazsdhza4Y9B0kEC2nuMtLqADA+HTRMVkgGfr
 w+1jnyAf6BIFRmK/Cap8grfJEVl3lICmMLgX+UcJdFxjl78a8Q49dG4ue1Y1kZmHLfQcqO/785E
 8XW14GAS48KpsL8fdU0SfxYCSmxbJKTQTOymALZtEi2WIlyWS4VTyyKDiG5jAytaQq3t+SVrdyG
 IK2fdzRhzUo7dejNuc=
X-Received: by 2002:a05:600c:42c8:b0:490:d354:bcf4 with SMTP id
 5b1f17b1804b1-4953c28b5edmr11460545e9.27.1784103000093; 
 Wed, 15 Jul 2026 01:10:00 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e029sm15077382f8f.3.2026.07.15.01.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:09:59 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 1/3] drm/amd/pm/si: Don't schedule thermal work when queue
 isn't initialized
Date: Wed, 15 Jul 2026 10:09:58 +0200
Message-ID: <2159182.YKUYFuaPT4@timur-max>
In-Reply-To: <85a1a097-7f6b-4d26-b0ac-8a78d7dd0a79@ursulin.net>
References: <20260712173928.259701-1-timur.kristof@gmail.com>
 <tM3iYIRPQHWYpTCh4LOKcw@gmail.com>
 <85a1a097-7f6b-4d26-b0ac-8a78d7dd0a79@ursulin.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 13., h=C3=A9tf=C5=91 16:39:08 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 13/07/2026 12:16, Timur Krist=C3=B3f wrote:
> > On Monday, July 13, 2026 12:25:38=E2=80=AFPM Central European Summer Ti=
me Tvrtko
> >=20
> > Ursulin wrote:
> >> On 12/07/2026 18:39, Timur Krist=C3=B3f wrote:
> >>> When DPM is turned off with the amdgpu.dpm=3D0 module parameter,
> >>> the thermal work queue isn't initialized so we shouldn't
> >>> schedule any work on it.
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> >>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c index
> >>> 832953941266..6a54566d1a68 100644
> >>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> >>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> >>> @@ -7692,7 +7692,7 @@ static int si_dpm_process_interrupt(struct
> >>> amdgpu_device *adev,>
> >>>=20
> >>>    		break;
> >>>    =09
> >>>    	}
> >>>=20
> >>> -	if (queue_thermal)
> >>> +	if (queue_thermal && amdgpu_dpm)
> >>>=20
> >>>    		schedule_work(&adev->pm.dpm.thermal.work);
> >>>    =09
> >>>    	return 0;
> >>=20
> >> I don't know this code but what is suspicious to me is that there appe=
ar
> >> to be other unguarded entry points to the un-initialized work. Like all
> >> the flush_work() calls and one cancel_work_sync() as well.
> >>=20
> >> Presumably as long as si_dpm_sw_init() is returning success when
> >> amdgpu_dpm =3D=3D 0 those two can get called?
> >>=20
> >> Finding the right Fixes: target might be a good thing too.
> >>=20
> >> Regards,
> >>=20
> >> Tvrtko
> >=20
> > Hi Tvrtko,
> >=20
> > That's a nice find. Indeed si_dpm_sw_init doesn't initialize the
> > thermal.work when amdgpu_dpm is zero. And in fact the same issue seems =
to
> > be present also in kv_dpm. I can address both of these in a follow-up
> > series if you like.
> You mean merge this fix for si_dpm_process_interrupt but leave
> si_dpm_sw_fini and si_dpm_suspend for later? I am not sure if that makes
> sense TBH but I guess I don't have the full context. For example whether
> you have hit this bug or just spotted by code inspection? If you hit it,
> can't fini and suspend also be hit and if so why does it make sense not
> to immediately fix all three?

Hi,

Let's just drop this patch then. The actual important ones are the next two.

Thanks,
Timur



