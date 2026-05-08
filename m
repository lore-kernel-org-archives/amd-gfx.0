Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A8CD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFA0710E4D5;
	Mon, 11 May 2026 07:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="nIp+GL+A";
	dkim-atps=neutral
Received: from xry111.site (xry111.site [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA3D10E303
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1778230650;
 bh=XTE2ScLz1R6lNx0b4ZmJP0j2jlKQ/OYwUr1wLMduU0k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nIp+GL+A97EeFGk0DucWBu7j/eOJdnkDhdrrw58KvU2hSYRydXE3AroxFLk8VTyRc
 rJW2oZYsunH06AIk6M3UKDlAuACKE7XBzNg0mdkxl72f2g7HQzNqFxYMBhQgEl1Vhu
 myWhrZ/QzQawOhfDkXk7/3hSghm2bxqbCruevkdo=
Received: from [IPv6:2409:8a4c:e1f:d2d0:3663:3ffe:842d:4c31] (unknown
 [IPv6:2409:8a4c:e1f:d2d0:3663:3ffe:842d:4c31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id EAF3865997;
 Fri,  8 May 2026 04:57:24 -0400 (EDT)
Message-ID: <d0765c9131d74bbe89e2ae7df38f63f0b413aa3d.camel@xry111.site>
Subject: Re: [PATCH v2 24/30] drm/amd/display: Move FPU Guards From DML To
 DC - Part 2
From: Xi Ruoyao <xry111@xry111.site>
To: ChuanYu Tseng <ChuanYu.Tseng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung	 <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler	 <daniel.wheeler@amd.com>, Ray
 Wu <Ray.Wu@amd.com>, Ivan Lipski	 <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Rafal Ostrowski	 <rafal.ostrowski@amd.com>, Dillon
 Varone <dillon.varone@amd.com>, Mingcong Bai	 <jeffbai@aosc.io>, xinmu
 <xinmu@xinmu.moe>
Date: Fri, 08 May 2026 16:57:19 +0800
In-Reply-To: <df24e57df62dc4d0a9385a20f6476808b133be71.camel@xry111.site>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
 <20260326030153.406612-25-ChuanYu.Tseng@amd.com>
 <df24e57df62dc4d0a9385a20f6476808b133be71.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 May 2026 07:30:27 +0000
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

On Fri, 2026-05-08 at 16:11 +0800, Xi Ruoyao wrote:
> On Thu, 2026-03-26 at 10:57 +0800, ChuanYu Tseng wrote:
>=20
> > FPU guards (DC_FP_START/DC_FP_END) are required to wrap around code tha=
t
> > can manipulates floats. To do this properly, the FPU guards must be use=
d
> > in a file that is not compiled as a FPU unit. If the guards are used in
> > a file that is a FPU unit, other sections in the file that aren't guard=
ed
> > may be end up being compiled to use FPU operations.
>=20
> /* snip */
>=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/dri=
vers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
>=20
> We have:
>=20
> CFLAGS_$(AMDDALPATH)/dc/dml2_0/dml2_wrapper.o :=3D $(dml2_rcflags)
>=20
> and
>=20
> dml2_rcflags :=3D $(CC_FLAGS_NO_FPU)
>=20
> so this file isn't compiled as a FPU unit.=C2=A0 Why removing the guards
> here?

>=20
> /* snip */
>=20
> > index 408559d6fb2d..f8250c80be02 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
> > @@ -6,7 +6,20 @@
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#include "dml2_internal_types.h"
> > +#include "dml2_wrapper.h"
> > =C2=A0#include "dml2_wrapper_fpu.h"
> > +#include "dml21_wrapper.h"
> > +#include "dml21_wrapper_fpu.h"
> > +
> > +#include "dc_fpu.h"
> > +
> > +struct dml2_context *dml2_allocate_memory(void)
> > +{
> > +	struct dml2_context *dml2;
> > +
> > +	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 =3D vzalloc(sizeof(struct dml2_co=
ntext)));
> > +	return dml2;
> > +}
> > =C2=A0
> > =C2=A0bool dml2_validate(const struct dc *in_dc, struct dc_state *conte=
xt, struct dml2_context *dml2,
> > =C2=A0	enum dc_validate_mode validate_mode)
> > @@ -23,16 +36,12 @@ bool dml2_validate(const struct dc *in_dc, struct d=
c_state *context, struct dml2
> > =C2=A0		return out;
> > =C2=A0	}
> > =C2=A0
> > -	DC_FP_START();
>=20
> Notably the removal of this is causing:
>=20
> [=C2=A0=C2=A0=C2=A0 3.943927] do_fpu invoked from kernel context![#1]:
> [=C2=A0=C2=A0=C2=A0 3.948860] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not=
 tainted 7.0.3-aosc-main-4k #2 PREEMPT(lazy)

Oh, I didn't expect the code path of 7.0.3 is so different from the
mainline (7.1-rc1).  The mainline has guarded this elsewhere and the
breakage on 7.0.3 is caused by some difference reason that I'm still
trying to figure out...

--=20
Xi Ruoyao <xry111@xry111.site>
