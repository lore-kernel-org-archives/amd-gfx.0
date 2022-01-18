Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7041CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 21:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D1F10E12A;
	Tue, 18 Jan 2022 21:02:35 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2B610E12A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 21:02:34 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id u21so1091152edd.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 13:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JIig2TUYFZx/rNpd0WBgBD+R/juntr8CxXIj5A2GCqA=;
 b=nqFhjhyMjed5/XO2wW7osCeqTaHDZXYdihVQFaJDSf3arWpBK6moqvPvcPLRZ08d3o
 Sn34QnwaT1TM+oTfLgyttl9Un2FnyQ9SBHIySA/LSnsgUYdjT5+fobb2qE0ekNi2NMcr
 3ofUbSUDAY1bbpeH9efCa+4nu8DEZg36EDQwhg7mIVWAVCtY3bPye2iYQUwNMqZ16ocK
 0QkAUgpgHGSApk51JGMFdxNomSHRKuE399IDVmHvfYIzX1B4jXu5W3tveSH17G6GNFCW
 xdnqNR+PKVASa0pSw9XariDudzJ/8PiBEfosr1jOyZQWxmjjXblU25JssoAQ9YGDo4X2
 1ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JIig2TUYFZx/rNpd0WBgBD+R/juntr8CxXIj5A2GCqA=;
 b=tYccFogA6Y3MHDUJ9qLDlo3iLkioFBCP6orxNMMO2cTyJJCpacxCU5HMbkGGsw/FO8
 ZfnRKV6+qbE93mpLZDCUS3rFoxyKcY09AoTpmTrog60dxy+7Sa/RPKUrAKyjz8dB8RNa
 AQX+MY9+H52Z0fR6dUsOOBfuOM0nxicgKyeTiRuIa+klyLu+JQbyaokAhjmVQakX7YBZ
 ZlBvGMZ6k9zeua8v1b8xvS2JKpI53OKfIOBN8gqIyOiaTwnNWdIrelTb1InYEOnT6Ubj
 cNXizVRAPRh6xWzcXXqmEWtaoOqCwpSbYw628toWmqRw1+JJmMimVR3WK7n38Kja1KBq
 PmVg==
X-Gm-Message-State: AOAM530siSgYvajUAV66l3ilef6SkuesLIhSbbHlNEXyWQX3L1J51Sn1
 ZAK2vxQ8cQqwaKdOmTQNTTQ9kPK1JPKy3JeT3Q6WW8gf
X-Google-Smtp-Source: ABdhPJzTUg3FT+NsvsMnMRLhYo2VZ2ParTYojwBE3ZBo0/OoEdTvqOYRd6K15u2aykLGj/DCWbY4IGnmRA4R8i3aZxA=
X-Received: by 2002:a17:906:6a1d:: with SMTP id
 qw29mr8891610ejc.750.1642539753386; 
 Tue, 18 Jan 2022 13:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
 <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
 <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
 <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
In-Reply-To: <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Jan 2022 07:02:22 +1000
Message-ID: <CAPM=9tzVkJsi5=+rMWDCx75y=s0jAibSk6KzS3opJW0yPvpgCA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 19 Jan 2022 at 06:14, Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> I understand Alex's concern. I think usually we only check the version
> when a feature is only available in a specific version, and other
> version or newer version doesn't have.
>
> In case of FW fix, we assume the driver and FWs have to be synchronous.
> If we have driver backward compatibility for FWs, there must be a lot of
> redundant codes for FW version check. So this patch and SDMA fix will be
> pushed into ROCm 5.1 release branch at the same time.
>

Please remove that assumption from everwhere.

If you have released a fw into linux-firmware then you need to support
it going forward, even if it means printing something in dmesg
recommending people upgrade for features.

Dave.
