Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DEDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 15:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7741710E88D;
	Thu, 10 Feb 2022 15:28:26 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E1110E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 15:28:25 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id u13so6250825oie.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/A9FcDGeoBpuUMDZbJwP6/1uDmuOLMx4NprmqBtt2YE=;
 b=IdyKb1eG3SX1rBrnOGt0Q69C7+jxq7Fruh8bDa0H6UPiYD7dvnl4HX6QLC7sH+uhCM
 VzMo0lAv0eNc7zFDz4WqqRJb+Ju4R6sc6O7MEnBXMxOzRs9eMG+LeAcmaGQ0wLvt2D8+
 BNtrDic1F9YbyR7d27yHq0JsIxBdupkHHvea4J7UALJ1ProX/iH5Ai97Ji2AnYoYAvgy
 ACK8rK8/ApQbRvw7oyBHv398ouEd21khzWHDJDhCBDVX+jxF33Vbf0k7Es/Y1L4NAOIp
 X0dlpGZGILV1k32lfAIFRiyOKFiIQOtjrgVnqowLmDQfy19uoIdT78GBGVAlWefBHKp/
 oMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/A9FcDGeoBpuUMDZbJwP6/1uDmuOLMx4NprmqBtt2YE=;
 b=d/xItllrMab+vCixrjNEtlts164qMwYLMQ7lHZ12dqUG1RD39XEIh7QpXs4pEBPMvK
 zp5B0OVEly5CYiSSh1pQnckVA4+CgpmOlV2OiM9VybYtTC7NtTnhqrp+Vv3ekbfPVoyT
 N+Qf9afn1v1ARr/7qF+OJXcMMZlThuOCSVPrz0Neyr9LKqWyIrfFACV10Kmy3GuPN0g2
 UPnH0Q9O9T1DyF6Lj+pzhrOvk4n76KGNsSwPVnlqot/iM+Bjcxn+/j17sL9B9M+STgPu
 z3+joJOnaFUfcDZZOykjF14S4ywvYJvnXJLI2wARWiv0DnhqTA3xoVi2iaSh8mUKGtRD
 ClwQ==
X-Gm-Message-State: AOAM532EXZWkyhvXodughOEUg5b7mjSot3hj6+XXx9b1lQYSY/zf3Iua
 GuwAJglLMzYDIboLgyMSgrkMe9T+bf8SXicYyEq/qCJW
X-Google-Smtp-Source: ABdhPJwh4wsojNNx1fef29AbYqRWIKZ2glu0Cv2Awidxs/g4kqvhJqveetkvqnBp0w7nObYczEcsQH5CRFpm+clFI6k=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr1212255oiw.132.1644506905018; 
 Thu, 10 Feb 2022 07:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Feb 2022 10:28:14 -0500
Message-ID: <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 9:04 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> > Sent: Thursday, February 10, 2022 07:35
> > To: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>;
> > Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> > Subject: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
> >
> > [Why]
> > SDMA ring buffer test failed if suspend is aborted during
> > S0i3 resume.
> >
> > [How]
> > If suspend is aborted for some reason during S0i3 resume
> > cycle, it follows SDMA ring test failing and errors in amdgpu
> > resume. For RN/CZN/Picasso, SMU saves and restores SDMA
> > registers during S0ix cycle. So, skipping SDMA suspend and
> > resume from driver solves the issue. This time, the system
> > is able to resume gracefully even the suspend is aborted.
> >
> > v2: add changes on sdma_v4, skipping SDMA hw_init and hw_fini.
>
> This line in the commit message should be "below" the ---
>
> Besides that the code is better.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I presume sdma_v5.2.c needs a similar fix?

Alex


>
> > Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > index 06a7ceda4c87..02115d63b071 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -2058,6 +2058,10 @@ static int sdma_v4_0_suspend(void *handle)
> >  {
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> > +     /* SMU saves SDMA state for us */
> > +     if (adev->in_s0ix)
> > +             return 0;
> > +
> >       return sdma_v4_0_hw_fini(adev);
> >  }
> >
> > @@ -2065,6 +2069,10 @@ static int sdma_v4_0_resume(void *handle)
> >  {
> >       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> > +     /* SMU restores SDMA state for us */
> > +     if (adev->in_s0ix)
> > +             return 0;
> > +
> >       return sdma_v4_0_hw_init(adev);
> >  }
> >
> > --
> > 2.25.1
