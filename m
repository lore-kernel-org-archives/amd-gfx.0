Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33C5C5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 14:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C12210E182;
	Wed, 11 Jan 2023 14:47:42 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7AF10E182
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 14:47:40 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-15bb8ec196aso3987586fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jan 2023 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FK2+uw+zjyn2bkQTH1uT+g159Q5BkxTC7GAI+9P08hQ=;
 b=MRhVyRv6YOQiNMCJAKTsaAsfBO2nUpy7Ri8n/8oTBVNs4WlAeZB1f3T4L8fVUj8dhL
 h6rlMKFdBk39jV2M/i7QtisRcsYLp02xjR4v3YweXdZJdCLGHuj3k/2/0H3QWvKHL6nj
 047iWYdI8WMlUipYKnxRndHEQVmuI249joPgWi6y4lVPArsNm6uF1EQZt01oLUtNHk58
 5yZt0d3LKujCF91+kIwMbgz386Kp0Vyc8AuT2i9+l5jNWPgE0HyOFk+thmZ4BmhCYkR4
 7lB7wU88h9bZ1GgdusndoRUxUcqVYhUSBsDe1xO5TL4jtzInihXJxshWsq8paVOyLtcx
 zBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FK2+uw+zjyn2bkQTH1uT+g159Q5BkxTC7GAI+9P08hQ=;
 b=Vj20f1svs4rq/XtvD90wEnZxLp6sAyFgcbSMM+iZJEq2nm+3FQKoRexlXUzuDErRHW
 zUVgUbx80VvFpT/mo6NDjMryN/elzMBteyDXQYYqHwIA3A73v4qlMlBHk7e4YZnwvOc6
 FpKmJj5IQPeWks0GU/2J4/jL0Em+Q8TvWeFtv4UT7TArIrfn9fbzeGjcz4UguVoKqI+1
 vxVxYFIx87M+H7auYafRQXMi8kcCCPIeWNy1hAlr1eAbPlMU12vttT+p1Diky7KdIUr9
 GCq2EL+hu+DxVp7IvfT3xmD3XklDrKpURXqi1zX9JZQFqrJFb7LJo+pd65pDluWQgM1V
 opbg==
X-Gm-Message-State: AFqh2kooSQ4PUriFlCpNEy7O22iSTV9qX6XC222aOKAfM9npf+7ouu0W
 Dq2zn98xqrYXr7fj3G1qJ0sNT13uu1T6DpeQ0U4=
X-Google-Smtp-Source: AMrXdXvGcXPLQtjoC9ZfdkAwWvvgn+HwjFyZPAYAvVUYLPctkDuaHdBwX+MiLT/BCsqn52yrNLQvKlgCrQ4szOobepc=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr2541367oab.96.1673448459989; Wed, 11
 Jan 2023 06:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
 <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <bc81b6b8-4bf8-4565-80f4-cb46539318ff@gmail.com>
 <DM6PR12MB26194938F0D4873D5DB83A1DE4FC9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26194938F0D4873D5DB83A1DE4FC9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Jan 2023 09:47:28 -0500
Message-ID: <CADnq5_N8RQAZtEy03qohNQF_7c_kLLQOQ0FGvXtRAqvBbV-Aeg@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: Matt Coffin <mcoffin13@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 11, 2023 at 8:23 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Matt,
>
> The problem with the approach(removal of interface functions from the ppt_funcs) is:
> 1. If to drop support for some sysfs interface, you need to know the internal implementation details to mask out the corresponding function.
>     That's not straightforward and might be not an easy job for new comer.
> 2. Sometimes the missing of some interfaces is unintentional. It needs to be added instead of being treated as unsupported.
> 3. The removal of the interface cannot update the sysfs file permission together. That means the sysfs file might be still shown as writable while
>     actually the setting is not supported at all.
> The patch series try to address these in a simple and straightforward way.
>
> Regarding the manual fan speed setting issue targeted by this patch, the SCPM feature of the new SMU13 asics prevents us from toggling the fan control feature from auto to manual.
> Without that, the manual fan speed setting to some specific RPM/PWM is not possible.
> About the capability in the OD table you mentioned, it might be a different issue.
> Since as I know, the capability the OD table provided is to change the minimum/maximum fan speed limit.
> That should be not affected by the SCPM and relevant.

Right.  Manual fan control is no longer possible.  As Evan said, you
can adjust the automatic fan curve using the OD interface, but that is
it.

Alex


>
> BR
> Evan
> > -----Original Message-----
> > From: Matt Coffin <mcoffin13@gmail.com>
> > Sent: Tuesday, January 10, 2023 9:57 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> > Subject: Re: [PATCH 8/8] drm/amd/pm: drop the support for manual fan
> > speed setting on SMU13.0.7
> >
> > On 1/9/23 23:48, Quan, Evan wrote:
> > > [AMD Official Use Only - General]
> > >
> > > We need these to address the fan speed setting failure reported for the
> > new SMU13 asics.
> > My opinion shouldn't matter much given sparseness of activity, but, despite
> > his... short tonality, I agree with Lijo's assessment there.
> >
> > As someone less familiar with the code base, the use of "multiple sources of
> > truth" contributes to making it harder to understand and ramp up with.
> >
> > As for the sysfs fan control issue itself, this won't really "fix" the issue, but
> > rather just remove write permissions from the hwmon files (if my
> > testing+understanding is right), so it wouldn't seem to be a hyper-critical
> > deliverable to me as a random outsider looking in (despite being effected by
> > the issue personally). Even with that interface removed, there isn't another
> > way to control the "auto" fans, as the FW reports it doesn't support that
> > capability in the OD table, and ignores anything set therein for that purpose.
> > Hopefully that's temporary until FW gets fixed?
> >
> > I also think the behavior of the other proposed solution (removal of interface
> > functions from the ppt_funcs), is objectively a better experience w/r/t
> > outcome. If the functions are NULL, then the hwmon device files go away
> > *completely*, instead of just being masked from write permission, which
> > would make the message clearer to the end user that it's not an error, but an
> > actual lack of functionality.
> >
> > Cheers, sorry I couldn't help, but wanted to at least have something come of
> > the last few days I spent implmenting OD on SMU13 for nothing!
> >
> > ~Matt
