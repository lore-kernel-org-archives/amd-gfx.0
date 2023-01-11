Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A0AC5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 13:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54AD10E154;
	Wed, 11 Jan 2023 13:49:05 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3546610E154
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 13:49:05 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 cc13-20020a05683061cd00b00684b8cf2f4dso603488otb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egXhKLvUWnUE0Rb4v1WAOmgqSXCapW86SxppYiuDsvk=;
 b=BCcTQEmq3snJ31Ox84xohXBUbLhviGA/c+xY7ULlFl1Lmssg+NG1TrZwuLA/sZkxpU
 3DVU3EaYfPKbvIG4W9bBVgzBGQ+QGGhdAFIbV6UF7rIWcnXfvmYTiiJC2CpPXM/PUQFU
 hUMajxUrdDMKowqi0OOQFUUvIDzFTVs9IvH+YrDL+KXVCuRB2sHoYwPwSRLwZQy59mYb
 4YwuH6ZRxVOufeQf/q75DLUJz15SepEQ/pwY7e6tMz4dvY5BQzOuA156wqCq4Xibm/ey
 VLLKf9GhV4jU5GK0ZFverzFdIG3iNKWhf4jyoO2r1fBUH9RIGzecZX4JjM2zgX3Y1kFK
 ybFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egXhKLvUWnUE0Rb4v1WAOmgqSXCapW86SxppYiuDsvk=;
 b=SYYlGSap1zupZl73zJAruX4lqGMbx/6wXzHB0cUL6fcDsctB/Zs71lE33+KTXYj4V/
 2ixsUJaGfmIPhg8Cj52W2ztnJ/n+4uLeshCgk/W+WOFhWKxR0n/HjOOLewlh4esO+T9r
 Ea3PGMuvYha+Gh46O53UOpBQWES4O/KCwFdmSFuEMotDVjJmpw6MlAG9aJZrj4UBSl/a
 yB84WXqia8fgcA39TEuz+VsdF0TFSmv+rkfdgrPbM0BYWuXv+qaApMN+3tEzjXz9G79k
 4HbLZ7Yus+KlvVODXJvRanavjrYZ518FuCoHBKNINop8xyZWR1hN0B+NrlvUI4EAXgOK
 FkuA==
X-Gm-Message-State: AFqh2koc/qE4lNyA+1sn3P8OwaJuc1wd1nx61r7XwVcjUDXZ4AAHS1oU
 EqD1baoezGd8auaJN6JUk6wOg4NvpUQVk7VeMzk=
X-Google-Smtp-Source: AMrXdXsMzt7x1u/HMvBZ7LMIYiyI4R6l5dpxLbtF+rR43mEtpLKcly3NL0z3X+qg3ryqgcYR1xyGDsXk6vemFaa3wXQ=
X-Received: by 2002:a9d:489:0:b0:684:bedc:4f54 with SMTP id
 9-20020a9d0489000000b00684bedc4f54mr21631otm.233.1673444944426; Wed, 11 Jan
 2023 05:49:04 -0800 (PST)
MIME-Version: 1.0
References: <CANiD2e9bdhxdJr_N9wb7O0Su+LRhzE1n=TepvbBiOoqmKRRgeg@mail.gmail.com>
 <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Jan 2023 08:48:52 -0500
Message-ID: <CADnq5_M8ECkmggxLJRmO6S1fP2SCT_rudz2gbxV-KcNL-V2MCA@mail.gmail.com>
Subject: Re: Wrong revert commit in stable channel
To: "Chen, Guchun" <Guchun.Chen@amd.com>
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
Cc: Yury Zhuravlev <stalkerg@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, the revert was reverted.

Alex

On Wed, Jan 11, 2023 at 3:35 AM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>
> Hi Yury,
>
>
>
> My understanding is though that=E2=80=99s a revert of your original patch=
, we did a revert again on top of the reverted patch later on. Can you plea=
se sync to below commit to check again? Or do I understand wrong?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35ce=
3369b1418ebae0e657cda6a
>
>
>
> Regards,
>
> Guchun
>
>
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yury Z=
huravlev
> Sent: Wednesday, January 11, 2023 4:26 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Wrong revert commit in stable channel
>
>
>
> Hello,
>
>
>
> Something went wrong, and we commited what we diced not commit.
>
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv6.2-rc3&id=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba
>
>
>
> and
>
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv6.2-rc3&id=3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7
>
>
>
> It's wrong reverts because, initially was an issue with a test case, not =
a patch itself.
>
> My GPU is not working correctly again after such "stable" patch.
