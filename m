Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3635C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 20:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BC510E29D;
	Mon,  5 Aug 2024 20:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kdnykaxg";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C18E10E29D
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 20:00:34 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2cfd1b25aaaso4837569a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Aug 2024 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722888034; x=1723492834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Rvpd0wIwPo5RAZRk6uyfaH6jGfmkAL4tT+G73f1Rf4=;
 b=KdnykaxgdLhm4WRW5VezNouCAdtF9eLcMeM+rJXx/KffXxCAJl+d47n6vHy0sMiBoi
 tooYQ6zflTbWO8JCCLq6gnuL92mwf8xdxiVUhfNdBUPdTZC5/efz5a3DWWV+lBObN12Y
 2jzmb9DMBNBht+0D767aS8v2imWDPXMCnQXot2uBveSObo9srT3/AtAOjrnQePhuXOlg
 4E+lwCl4lM3LiBW6kOOko396T0ZJORd27DNzPqXgGUa9gB3iXJImSpWufVgXr1LKHkoh
 MBNHQk7n+BClwn/Tis80Bp/WTi9BrAOFHiJSwDngewSo4kqXET6kb5TbJsBLk/wWDh5R
 nuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722888034; x=1723492834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Rvpd0wIwPo5RAZRk6uyfaH6jGfmkAL4tT+G73f1Rf4=;
 b=ueG9tMplYQAGT0SdZFgveKA92IVO+weobpL4Br+khg5TdqZhcnbjCBNWz+xy79LSD0
 4c9qEZjcfso6a/RC20zVvNW+r7Fpjf/3fwmuVeQMBT0UA2NxeFlQT6jRTeb7Y09WmnOV
 McUfUIGcGULYvXBWYwB+U/YYJfwQsHlrb9SZDyZ4/fcV/vhNXMxiue4HQd0qBFgyc555
 dnN8CdjgyZAuReEI7ss86tvFccHOtCjF2773nr5RxyLBDXJWg+7RnqG2U3ywGNLA9azT
 90jJAk5jKg05id2AksLPE6Lm+Oh2ZvkL+SFyn5RvX2FbvWwYy7oy86oafQSojXNjIlN5
 R76g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8SOHWlw4xeCi9rX/jpS6wBNNEFwAIokukE292oP0oOQZ5a52bC4JaTv0mKMwExAk++mNzIKrsTcIFEO8+MFzRUoPu2We9DA5ikbPPg==
X-Gm-Message-State: AOJu0YwbjZZjN/qTrBw/B4bcFJT9hsL7kQQFNKE7y3NYZVy/raptWwHV
 7z4TZJI3OysqUuzs+Rn7Ly6NvBJUD6r1u4+WMFqdZGYvDyw9ZLT0+nYMPcmjaGOvSmNvR9Tb6Ig
 l1vFO2tc64gByXShHiIoRmuu1BZnxng==
X-Google-Smtp-Source: AGHT+IHf3fMitR6XBl7gTapNDcdbF3VU9w7FxxehYxDwg5geobLkoDIEoKZZ/7rlIkQl9TF67dOK00stnbkjIoq7/qk=
X-Received: by 2002:a17:90a:3885:b0:2cb:511f:35f with SMTP id
 98e67ed59e1d1-2cff9414351mr10796671a91.15.1722888033782; Mon, 05 Aug 2024
 13:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <MW4PR12MB7482EF2FD5ECF7101A593E5180BC2@MW4PR12MB7482.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB7482EF2FD5ECF7101A593E5180BC2@MW4PR12MB7482.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 16:00:21 -0400
Message-ID: <CADnq5_NYqaAcu8gtbNJL5OKx-YhD0WfFZ4dKSvxnJrC51soEGA@mail.gmail.com>
Subject: Re: [PATCH] check for mcbp
To: "Dandapat, Soham" <Soham.Dandapat@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, 
 "Ramayanam, Pavan" <Pavan.Ramayanam@amd.com>, 
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Sat, Aug 3, 2024 at 10:13=E2=80=AFAM Dandapat, Soham <Soham.Dandapat@amd=
.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> This is the fix for below
>
> we don=E2=80=99t need to call amdgpu_ring_mux_start_ib/ amdgpu_ring_mux_e=
nd_ib if adev->gfx.mcbp is enable .
>
> we could return earlier in amdgpu_sw_ring_ib_begin/ amdgpu_sw_ring_ib_end=
 in case !adev->gfx.mcbp.
>
>
>
> Thanks,
>
> Soham
