Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655ACC47254
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 11:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DECF208DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 11:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DECF208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5016E6EB04;
	Fri,  8 May 2020 11:09:08 +0000 (UTC)
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D0C6EB03;
 Fri,  8 May 2020 11:09:07 +0000 (UTC)
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id D6F2A80500;
 Fri,  8 May 2020 13:09:04 +0200 (CEST)
Date: Fri, 8 May 2020 13:09:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 06/36] drm/amdgpu: use the unlocked drm_gem_object_put
Message-ID: <20200508110903.GC15931@ravnborg.org>
References: <20200507150822.114464-1-emil.l.velikov@gmail.com>
 <20200507150822.114464-7-emil.l.velikov@gmail.com>
 <20200507180310.GC13247@ravnborg.org>
 <d79cd110-27d3-3df9-00b2-b1cad5924454@amd.com>
 <CACvgo50TW1zxB4a20L_JD_3kOvy+BWLVaB6R_r5fTvKnkU5XTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACvgo50TW1zxB4a20L_JD_3kOvy+BWLVaB6R_r5fTvKnkU5XTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=8nJEP1OIZ-IA:10 a=zd2uoN0lAAAA:8 a=QX4gbG5DAAAA:8 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=6O4YvwrpDX13PYuNmRMA:9 a=wPNLvfGTeEIA:10
 a=AbAUZ8qAyYyZVLSsDulk:22 a=Vxmtnl_E_bksehYqCbjh:22
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 08, 2020 at 10:55:42AM +0100, Emil Velikov wrote:
> On Fri, 8 May 2020 at 09:16, Christian K=F6nig <christian.koenig@amd.com>=
 wrote:
> >
> > Am 07.05.20 um 20:03 schrieb Sam Ravnborg:
> > > Hi Emil.
> > >
> > > On Thu, May 07, 2020 at 04:07:52PM +0100, Emil Velikov wrote:
> > >> From: Emil Velikov <emil.velikov@collabora.com>
> > >>
> > >> The driver does not hold struct_mutex, thus using the locked version=
 of
> > >> the helper is incorrect.
> > >>
> > >> Cc: Alex Deucher <alexander.deucher@amd.com>
> > >> Cc: Christian K=F6nig <christian.koenig@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org
> > >> Fixes: a39414716ca0 ("drm/amdgpu: add independent DMA-buf import v9"=
):
> > >> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > >> index 43d8ed7dbd00..652c57a3b847 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > >> @@ -587,7 +587,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(s=
truct drm_device *dev,
> > >>      attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev,
> > >>                                      &amdgpu_dma_buf_attach_ops, obj=
);
> > >>      if (IS_ERR(attach)) {
> > >> -            drm_gem_object_put(obj);
> > >> +            drm_gem_object_put_unlocked(obj);
> > >>              return ERR_CAST(attach);
> > >>      }
> > > Likewise previous patch.
> > > Drop this as the patch is correct after the rename a few pathces late=
r.
> >
> > Well this is a bug fix in the error path and should probably be back
> > ported, so having a separate patch is certainly a good idea.
> >
> Precisely the goal here. The fixes tag should allow Greg and team to
> pick/port it where applicable.
I got it now... Thanks for spelling it out for my dense mind.

	Sam
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
