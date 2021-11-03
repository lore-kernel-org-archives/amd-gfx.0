Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A850C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3829960F39
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 02:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3829960F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ntlworld.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4E873AA8;
	Wed,  3 Nov 2021 02:50:46 +0000 (UTC)
Received: from smtpq1.tb.ukmail.iss.as9143.net
 (smtpq1.tb.ukmail.iss.as9143.net [212.54.57.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A5D73AA6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 02:50:45 +0000 (UTC)
Received: from [212.54.57.107] (helo=csmtp3.tb.ukmail.iss.as9143.net)
 by smtpq1.tb.ukmail.iss.as9143.net with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <zarniwhoop@ntlworld.com>) id 1mi6MN-0005LR-My
 for amd-gfx@lists.freedesktop.org; Wed, 03 Nov 2021 03:50:43 +0100
Received: from llamedos.mydomain ([81.97.236.130]) by cmsmtp with ESMTPA
 id i6MNmyPNj9Za5i6MNmNQdU; Wed, 03 Nov 2021 03:50:43 +0100
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=NtrCzuRJ c=1 sm=1 tr=0 ts=6181f903 cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=NLZqzBF-AAAA:8 a=OWmU1wAo9Q2lxlFl-7QA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22 a=wW_WBVUImv98JQXhvVPZ:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
 s=meg.feb2017; t=1635907843;
 bh=PqgC+6FBsZn40ZR/UMH2Th0n0BC1JFcPeVhcSDXr7HE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FQ4Ktc9B1uLQ1KhX9w/zKlve7PzDxmWbFJAfIyD7oyLBIEJBljfVsBvoUmoh9RWME
 XWlmRlFp/d+6bzxMwSPf10u/iZAGdg5GdblU94AEqjuuLkTVvk969Kn2/WQZmR2L/z
 CjTokCONyZTF/2wBaX5ubjoekzbkXIqeV0pH7NXHUf9E/1jHSACAfwK6aA1A7VB/4H
 eqaPyLOYsbouz+lVRJtzuu8aJrfFV01nES/qsdxZWF9dUUkiRro0haGtBzLEC8AQdM
 Zw0DgtPUC5bNMR4JavFIzLSCPsDAK6BoxfM4EZiUpHXLlimQ7BRZ0jIeAruxtdw1Ca
 fLPCkB3kZUo/Q==
Received: by llamedos.mydomain (Postfix, from userid 1000)
 id 99F3160C5A; Wed,  3 Nov 2021 02:50:42 +0000 (GMT)
Date: Wed, 3 Nov 2021 02:50:42 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
Message-ID: <YYH5An5dFpPAmSDv@llamedos.localdomain>
References: <20211103013350.6015-1-James.Zhu@amd.com>
 <CADnq5_OurPZjmq2SbRZzw4MWRO2uFT7H=+F75czmwgG0MgGAiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OurPZjmq2SbRZzw4MWRO2uFT7H=+F75czmwgG0MgGAiQ@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfIgjptwq50QfC63zrUulSn/p3EsjOipRCyH8xTuqRuRNHYt/4rvYPcuhXqpt5C/dQcUjYnhY/VUNWr5RVE+FZB0bSnaTesMl36Beo+MOgm+Jz82CONhh
 g4KzAE32vPzD0MXOqrni3pu9L7vi13Gh6Kv0qzs9+UgKubl6OWjgKm9FlFKp6BC7hmDLVFO++KIjL/9lkiGpCYLWIrvXd8C2OPbkPvU/yihIxpFCKKumxF7C
 osVsURG/ulWf0k/wVj/CY/I/jeB6/XpkIffLfHvSFa3czkC02zTDOtqZT9K8lengkuYaUP6oMWKZ40eleIODmXTKo1YIiyIr2DfQ/LgzYOlzloqfQMX6r//L
 ybibXVhc+LmROpWTJDZYw42/DySlkQ==
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, James Zhu <jzhums@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 02, 2021 at 10:01:46PM -0400, Alex Deucher wrote:
> On Tue, Nov 2, 2021 at 9:34 PM James Zhu <James.Zhu@amd.com>
> wrote:
> >
> > Remove duplicated kfd_resume_iommu which already runs in
> > mdgpu_amdkfd_device_init.
> >
> > Signed-off-by: James Zhu <James.Zhu@amd.com>
> 
> Once you get confirmation, please add: Bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=214859 Bug:
> https://gitlab.freedesktop.org/drm/amd/-/issues/1770
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 
I see those were both for 5.14.15, on my 5.14 kernels I have not
moved beyond 5.14.12 so I've dodged the bullet on those.  And on my
2500u which I think is a Raven, 5.15.0-rc7 was ok.

On the picasso, this applies to 5.15.0 with an offset of 34 lines
(no fuzz) and solves the problem.  Thanks.

If it is any use,

Tested-By: Ken Moffat <zarniwhoop@ntlworld.com>

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e56bc925afcf..f77823ce7ae8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
> >         if (!adev->gmc.xgmi.pending_reset)
> >                 amdgpu_amdkfd_device_init(adev);
> >
> > -       r = amdgpu_amdkfd_resume_iommu(adev);
> > -       if (r)
> > -               goto init_failed;
> > -
> >         amdgpu_fru_get_product_info(adev);
> >
> >  init_failed:
> > --
> > 2.25.1
> >

-- 
Vetinari smiled. "Can you keep a secret, Mister Lipwig?"
"Oh, yes, sir. I've kept lots."
"Capital. And the point is, so can I. You do not need to know.”
