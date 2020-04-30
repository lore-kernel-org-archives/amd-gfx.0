Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DACC28CBC
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F3F2082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 13:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+BkpE+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F3F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4446E8A9;
	Thu, 30 Apr 2020 13:45:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3B76E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 13:45:00 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d15so6992065wrx.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1cFWAE9eYf91TWjrEXcHVGnbxQYRsYcG2hQCPah+/i4=;
 b=Z+BkpE+M3TfS11VCMmeIDrjbB8Z5pkGrW7b6j/sRtYbcZ8x7HcrbNNVM3jCxQmiNaN
 vqyq0ObWAeXpRTIsq4FEgmprvf9ElnYC8l7QnNUXybYKzijoM/zdG2rK7xAqGcSmd9py
 spK43UXF2eiV75S9mxY0RgpALuOXV6/xCB3t63YYHYp7GJHrpAu5eaCoSiHsbpWK9hjV
 xvU7OfaY+aGpV7+FOBQQUczAUssrkInQeYnkSw4A3JoJf3TFAw1g6PvU92rGLv9qRozo
 7XFqtOZ5ihSmoVPDhFfwKk7/UI+Os5ViTdmy1Otmtey6BN6Ex0ov/NL5VqyIALvCSUHp
 KHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1cFWAE9eYf91TWjrEXcHVGnbxQYRsYcG2hQCPah+/i4=;
 b=b1WbAYx8gnaf/tVrjHw7aTe+KU4CKa9bY1bpJuaVVZMceOXTleMuvKE7jAaJFBBpGi
 XMmTMA4xkqyu55DT4ir2HQdl5Z6dsVFrrVTcXaiPNhhCevgUO8wnD+hgGsHRrNgD4RQJ
 RKsf4oZSpkkyU2kKFsBj17q+eHYRcXgV/fbsRWYvIJd9qAS0P/9LNSmtTrxbilY9/Qfj
 OGrKfzejgaeE3kZ9Qy/I8Hzf0Wr6H1PFHYTl0WfkEetT6/8C15QV8LOyCiQN+cVoY3gu
 S4313T7P3bdjc79FVo9KXxKPVet3v9pZIIm09gzNLlYbiXz5g9TSnZ/KBz0TKwkAXVg+
 a9NQ==
X-Gm-Message-State: AGi0PuZgHE7Zo3EPs74cTIwj5Wxk71YIOMqBLs+k8dPGTat0/w/LV4zi
 abUWMfZLvGD0EAxwUqfYT/W3mWSDvkOp1rvtTkGl2A==
X-Google-Smtp-Source: APiQypKnB1EK42bMbZ52bMivdM8lUVwLZtijR7FVLqjU+UFFrOIHV5r3xg8WnqMcQE/AwUVD0+Qw2ndrTW2HgwKLy1k=
X-Received: by 2002:adf:f844:: with SMTP id d4mr3967196wrq.362.1588254299076; 
 Thu, 30 Apr 2020 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200430000047.31083-1-Felix.Kuehling@amd.com>
 <DM6PR12MB3721C196591A6CE969E78CDE85AA0@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721C196591A6CE969E78CDE85AA0@DM6PR12MB3721.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Apr 2020 09:44:48 -0400
Message-ID: <CADnq5_ML-RRHrJ5uaw-tqmkQRu8NrwoyRAYBL76oi+yzzy6xoQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] KFD upstreaming
To: "Russell, Kent" <Kent.Russell@amd.com>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1,2:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
3, 4:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


On Thu, Apr 30, 2020 at 8:31 AM Russell, Kent <Kent.Russell@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> You can add Reviewed-By Kent Russell <kent.russell> for patches 3 and 4 and use them for 1/2 if needed (since they were already reviewed/acked by you or Alex).
>
>  Kent
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> > Kuehling
> > Sent: Wednesday, April 29, 2020 8:01 PM
> > To: amd-gfx@lists.freedesktop.org
> > Subject: [PATCH 0/4] KFD upstreaming
> >
> > A few small patches found during DKMS branch rebasing that were missing
> > from amd-staging-drm-next for no good reason.
> >
> > Felix Kuehling (2):
> >   drm/amdkfd: Fix comment formatting
> >   drm/amdgpu: Add missing parameter description in comments
> >
> > Oak Zeng (1):
> >   drm/amdgpu: Changed CU reservation golden settings
> >
> > Ori Messinger (1):
> >   drm/amdkfd: Report domain with topology
> >
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 4 ++--
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c     | 1 +
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c     | 1 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c  | 4 ++--
> > drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
> > drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 +
> >  include/uapi/linux/kfd_ioctl.h            | 2 +-
> >  7 files changed, 11 insertions(+), 5 deletions(-)
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
> > eedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C04b4185d714a4375
> > 46bc08d7ec99a178%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
> > 637238017505884390&amp;sdata=eFMYK%2FzJBYAzQz7BOAqmMR1QOhRMe
> > nh0KXIEhYsv0bI%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
