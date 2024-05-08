Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943BC25B74
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203E910E58E;
	Thu,  9 May 2024 09:11:48 +0000 (UTC)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA3910FB17
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 11:25:21 +0000 (UTC)
Received: from beast.localdomain ([208.68.93.230]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Ln8sF-1sYG0H0Pwj-00hKTA; 
 Wed, 08 May 2024 13:25:16 +0200
Date: Wed, 8 May 2024 07:25:15 -0400
From: Jeremy Day <jsday@noreason.ca>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [patch] problems with "fix visible VRAM handling during faults"
Message-Id: <20240508072515.2aca2fdb97c048eeec06ab64@noreason.ca>
In-Reply-To: <d0aafbac-63af-464a-85a8-68ecc56404c7@amd.com>
References: <20240507123907.3a39163546b4643c5d834522@noreason.ca>
 <47c31c39-9ca0-46b6-93cd-e5c4c002fe23@mailbox.org>
 <d0aafbac-63af-464a-85a8-68ecc56404c7@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zyVZlBeYZ0ErZXBst+Nfj/b/Ta6kQzk+LB6TAYC6QYeEq8Bk7zY
 6IrOwYVMICLoHyE8UX2pcvg8z8Tw4x5+ZxlP+N4OR/yKoOQJvI77fwRXySw+QZ9utXwmnAA
 XEul8oHiMzsECOp1pWjXdKUnf7pmxKwUId4e+wVJFs1/6R1OkIcJEula748coRqGpBeVOut
 rh5d03V9VXkieQI+69r/w==
UI-OutboundReport: notjunk:1;M01:P0:cH7gmyVgJ0w=;FiXY9SvZNYWD5M0Z7WGNWYKPJMS
 8fgZKY6JgQnI8ICp7Vz9cTLsO9HZl++pK4v1E8+tAGmlxZwYfdgdEBXN3su+qHqrm3AgGixI2
 kWVxoq/HnHgEep0bKhTWFPa2FIezgZyo3XyU2a/fmuph30m3prk0WRJGMV3P5TVERIcfUuMbB
 c3SuD262Dm4908opcPz1z8A6vSmNa+ZnybYLMr0zPZ86hFtoNYvmc0lof0Qv8T2SeVRhd/vcP
 U6O93rSOJR6ZezPXZv1tW+CyHoExAecf1r5jQFbB21FudpeVF2fwIZvewXkygoyYt7LFHUi/w
 UV0M5bOLHkw0l3x5VeJwjJckzQ/xKRfGMD723BqW9j75YcNgsHMrKCK9zeWDiWA/5nNHRTxO4
 teNYbdvgq/FJar73fq72b9ef8Ma7OyEcCM8BV319Wt/nWqyuTHE8CjBdCmBdDRXdkjnzyyCdD
 rCVNBeWCmZFR4UgAmLesxLp1zeU24G1ImleULhyqoH/nrmxFYBNxQIpsSeeqT9BC/itInxIDf
 qi3vmhh1s8ymseEXczBJT7JANaNBGfvKVcweDn5Qj23xRrsa0Xslzzgr2BIvgcyh/sIkMSE1q
 39Sy6gLs3VPW6lIql5C66dqdpKNzkzIaoLpaWZ6QSstE7MEIQGdIEwZ7dbGbLaWKl/e4IE80w
 EbfxNToFcl5szYMF9WG1YU1c0VJth7nFh3hQiY+rBoFBZoFNFKD2DbQaBAiVoIu5a9emZVqJB
 lPseLVFg9QJdZQN5l1CrRx+o3zIVjRqoU1tsjS03BQmTrmQk/F0jfU=
X-Mailman-Approved-At: Thu, 09 May 2024 09:11:44 +0000
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

Christian K=F6nig <christian.koenig@amd.com> wrote:
> Am 08.05.24 um 12:17 schrieb Michel D=E4nzer:
> > Does this instead of your patch help by any chance?
> >
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 109fe557a02b..29c197c00018 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -427,7 +427,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *a=
dev,
> >
> >          amdgpu_res_first(res, 0, res->size, &cursor);
> >          while (cursor.remaining) {
> > -               if ((cursor.start + cursor.size) >=3D adev->gmc.visible=
_vram_size)
> > +               if ((cursor.start + cursor.size) > adev->gmc.visible_vr=
am_size)
>=20
> Oh, good catch. Yes that might be it.

Yes, that does it.  Thanks!
