Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2147CC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 18:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9F010E137;
	Tue,  4 Mar 2025 18:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZikLnrvm";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4274210E137
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 18:25:51 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-223600d7968so15704545ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741112751; x=1741717551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFP0uywEgqiUxfDszWeMvrDW9bMNf6c4tu2d6CQviWw=;
 b=ZikLnrvm7KKF9G+nEq7cBt64NVf8Y+eRMlpm6u3llVLlxElIWChU/cq265ueuOF8Qm
 abDqFba/91V1bW8BjqfwTDYwesmvuSthYpGFVHfsjieJqmtx0wVEOvoWWXM0XYxOH9At
 tdBRuWnFk58tjoFBnWBiAlJCoB470sgxPNHFktJtffKENBWgkhttLwl+eemVnQeHNip4
 6FLajz0wq/5CI6GwmBAB/1fWmZXvnP/FiLBUPBUIQtgb3K8Dfw93knFFq0W8jFtVYOGE
 AS/mknxfZPqh5zSGj7zkLhPU85iGzGEkSJUuVQ8n9cRKEGmA0w9JzVc5fFDdsatJz3ub
 VxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741112751; x=1741717551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFP0uywEgqiUxfDszWeMvrDW9bMNf6c4tu2d6CQviWw=;
 b=T4/5Tf9Zu34vYBGtL9XdiwRd19NJuX/8IhtP6rE9Z7ZhRKoDuwZZ8Mz+LW54mBsWBe
 /CD7h5dceD//KWI+ppxN7nbKGAmNp2zfq5r49Hx0DxWMQaQ1096IFFtzuUN4lotFIuLY
 kPRb97qklbkjwxXUTurKtrqjvOwLcHrw7YDji8S9m82C2YtK6u77yrdlkWYkfWdWJ2Qm
 aL5SHFvBxy4p4mQeCJzvs3xcBYA1b4x0gO8KjRIQEJW4YXPd+DJ5lkiSJs12fZiw1R4z
 09lNohStqHGSjFl74XwECd/WXPMSmiTiV1OC5TCtI21OayD1HkLCxA8vSaSqIaLaSwZA
 EzDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQkq2G4s0wBGwYjkxqqokb1lwfkT8UUThqQ+HfBwmHtoXOwflY3SUWqwx8O5xdQuVXGvVrIY1N@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx07SF42oVjxtscokLcsirhwv6szY+j3XspAsKHPGNTAcpMl+Bi
 UuH6dlKSJ5TD+SGZx05cI3T0+MgiMLNAyatl5N3ST0S8SEvZPSjXd7x59R8ElDaiJ+Yk1mbmowQ
 JSD0/HmToxIVZZLr/DUVvQa+3Tbzt1w==
X-Gm-Gg: ASbGncvAXVBib0aoYIsSxYjLqAtm8ZVj8BAYGhHf5jJNFhExYS4vsK6OX+eNXCyB/g5
 cMkzUoAdflGKQ8LeY2EaUNVJBH1rUkd+UAaXcq7y/RTGjE8CKVo9GHen2zPlr9aYb9bXNHi0p/k
 7H+5Ugl6lDNHBwIlLDs069wVtLRg==
X-Google-Smtp-Source: AGHT+IEWYiXmVeqy37vvHRrBEZ63rR9MG3JvalMTTaoG2UxRxClyuSZhC0Gk23mALa76xrDTKrxHHKJ7uomHXo7Q7P0=
X-Received: by 2002:a17:902:cec8:b0:21d:cdb7:876c with SMTP id
 d9443c01a7336-223f1c687edmr1192295ad.3.1741112750635; Tue, 04 Mar 2025
 10:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20250304175128.368511-1-sunil.khatri@amd.com>
 <52638c55-ba64-4cf0-9bf3-8b7935e42f3e@amd.com>
 <BL1PR12MB57530EA7AEF0BE777E39B93793C82@BL1PR12MB5753.namprd12.prod.outlook.com>
 <88360484-cc77-4837-bf9b-fea050f1b929@amd.com>
In-Reply-To: <88360484-cc77-4837-bf9b-fea050f1b929@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 13:25:39 -0500
X-Gm-Features: AQ5f1JpxhwNwaKfxxErx6xLfGCnjbYrAy7CrSLL1Z2VcY2oLzWSWQ2OX3DrHE9Q
Message-ID: <CADnq5_NpuNL_sN_RRkhkRG=cPyuSWdvJtkFONWeG0u8tZbop-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Validate return value of pm_runtime_get_sync
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 4, 2025 at 1:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 3/4/2025 12:03, Khatri, Sunil wrote:
> > For new code can you please use drm_err() instead of DRM_ERROR()?
> > I see drm_err is not used anywhere in amdgpu driver but display is usin=
g it. I think it would be better if I take it in a different patch to chang=
e instead. Does that sounds ok ?
> >
>
> DRM_ERROR() doesn't give any information on a multi-GPU system which GPU
> had the problem.  drm_err() does.  So it's the preferred macro for errors=
.
>
> Up to Alex and Christian if they take this as is or spin it, but I think
> it's a very simple change.

Please use the dev_err() or drm_err() variants. We mostly use the dev
variants outside of the display code.

Alex

>
> > Regards
> > Sunil Khatri
> >
> >> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >>                goto free_mqd;
> >> +     }
> >>
> >>        r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr=
, userq_props);
> >>        if (r) {
> >
>
