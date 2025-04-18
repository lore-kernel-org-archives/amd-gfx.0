Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC96C369CF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 01:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FCF10E3EA;
	Fri, 18 Apr 2025 01:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gZIxCXox";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E082810E1F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 01:10:47 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso235440a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 18:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744938647; x=1745543447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7nETPg+IDemm8Piufm3ia7vwssw6aPw/0kpBxq7JZM=;
 b=gZIxCXoxM5YwE7j4h+7Ph5nWLT4HZWJvCtlT7XWAJXnshXAwGA4HdYibmiuqzq9rHl
 cMIl7AIHk2cPsAuiCbMrjvo1e+3NASBNWD+N3/c6Yg454+KrGHBAptU5C8yH9puh3JYI
 hiDEY8NqhG7xwEvkhCpxrv137uaxzJZtXvPOcZIpVEH9GzpJarZ/Nwn9utHf7cWA4Tea
 gJTAvTpLedvdgeRH9xvYBMGe88qLbXTJTjgFa/e4job0MVrIezJMqBsreQGIV+bCYw1y
 WL/vvopIAVC6LUGvqiltn2ixqRhZ45GgBkIzsuwE6Ay4aF4dOvbtSxnvfVwpdBl89rIf
 Tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744938647; x=1745543447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7nETPg+IDemm8Piufm3ia7vwssw6aPw/0kpBxq7JZM=;
 b=Y7GNwUKs/b/mSrDJ/NaWukwcBmRXGJEj9Jhq/3RZyxRXxz76NdODZTy2NW9VDf1VUT
 II1tGShAGvwiyZUIphVGPLtIrzNz1FfwzQD8xDfv5cKKQ+uS6IJs9rbxNgS3OVWgbzuI
 6ZzbV/+gTWd7CsQKa3z6s/qNsePLo/Vmgk4k1ZAxagNOtQTafYpd+lAW3jTAt3HTbvcW
 2oDewrDUp5hSiu9PL82uhg2CehBBNuB+vQSwj8g/H0Cg8XRE20weCIokwAqGqyAjuZZn
 +d8nlpFdoz5xse5buatQFcEg0ChnwEg4QCmKVr6KDDTIBlOISO/yqz19wUZfJFfxuqne
 rDww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjB3a1Had0iyEr1i0dmpP171XmKID40Y9MCqOG0WtOa1LOliLdqEWx5fOk+46z9d2ihXwrMvno@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yym3nJ9KQteXuLcOlx8UQPVD/qcM7+GeFy2IgoAwFTlcGPQ+4pG
 ZYeQhbZASd4ERmDymVpNPfi2qk2by6NJRH5P+k4sUwBEaCYoccMZLtgnYj+apAsh3g6iKS4RwOU
 5Z03uzbuRhjj3r9rSbee8khkj2N0=
X-Gm-Gg: ASbGncvCcwPqYs8MNKB0imerp+CFFj74G9sunOQSUtSZ1nj6daa7mFWRefGAmogtlOw
 7dH+jG6a8dfKk5DsPtnc0MOxYNcPkPUomMT/pbKEghbN9qYq+5H5j3uE3aVrEeQAEhmeSaa1/xg
 1sAUlXJZCdeeknAbmOV9mepMyKOW2/H13L
X-Google-Smtp-Source: AGHT+IGB3LlkcO/Zmqrhmx9Cbi6Z6kj57/61w+a/tBtR80nfrh/0qjkTkqsWScI5CmlOxB7P+pamMtN7oUHnq6ZZxss=
X-Received: by 2002:a17:90b:1c0a:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-3087bb30433mr523993a91.2.1744938646588; Thu, 17 Apr 2025
 18:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Apr 2025 21:10:34 -0400
X-Gm-Features: ATxdqUGDEZvfp9V-P_wUUUSYUpfed3Uo-jgWRPQhyLWXle_ivZG6tFPYSajY0Mc
Message-ID: <CADnq5_MF5_ZNc-ipUhVefa-vGZewa+Hg2WOm3zpv49GmqeqNHQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
 =?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Peter Chen <peter.chen@cixtech.com>, 
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thu, Apr 17, 2025 at 8:30=E2=80=AFPM Fugang Duan <fugang.duan@cixtech.co=
m> wrote:
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=8F=
=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8817=E6=97=A5 21:08
> >On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtech=
.com> wrote:
> >>
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5
> >22:49
> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>=
 On Wed, Apr 16, 2025 at
> >> >9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@linaro.org> wrote:
> >> >>
> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.=
org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44
> >=E6=9C=8816
> >> >=E6=97=A5 2:28
> >> >> >>#regzbot introduced: v6.12..v6.13
> >> >>
> >> >> [..]
> >> >>
> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing
> >> >> >>HDP
> >> >> >>
> >> >> >>Reverting that commit ^^ did help and resolved that problem.
> >> >> >>Before sending revert as-is I was interested to know if there
> >> >> >>supposed to be a proper fix for this or maybe someone is
> >> >> >>interested to debug this or
> >> >have any suggestions.
> >> >> >>
> >> >> > Can you revert the change and try again
> >> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df
> >> >> > 05b
> >> >> > 682b546b255e74a420f
> >> >>
> >> >> Please read my email in the first place.
> >> >> Let me quote just in case:
> >> >>
> >> >> >The only change related to hdp_v5_0_flush_hdp() was
> >> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing
> >> >> >HDP
> >> >>
> >> >> >Reverting that commit ^^ did help and resolved that problem.
> >> >
> >> >We can't really revert the change as that will lead to coherency
> >> >problems.  What is the page size on your system?  Does the attached p=
atch
> >fix it?
> >> >
> >> >Alex
> >> >
> >> 4K page size.  We can try the fix if we got the environment.
> >
> >OK.  that patch won't change anything then.  Can you try this patch inst=
ead?
> >
> >Alex
> >
> Alex, it is very sorry that our team don't have the GPU card in hands.
> It is better to ask amd gfx team help to try the fixes.

Sorry, we don't have the problematic arm board.  This code works as
expected on x86.

Alex

>
> >>
> >> Fugang
> >>
> >>
> >>
> >> This email (including its attachments) is intended only for the person=
 or entity
> >to which it is addressed and may contain information that is privileged,
> >confidential or otherwise protected from disclosure. Unauthorized use,
> >dissemination, distribution or copying of this email or the information =
herein
> >or taking any action in reliance on the contents of this email or the in=
formation
> >herein, by anyone other than the intended recipient, or an employee or a=
gent
> >responsible for delivering the message to the intended recipient, is str=
ictly
> >prohibited. If you are not the intended recipient, please do not read, c=
opy,
> >use or disclose any part of this e-mail to others. Please notify the sen=
der
> >immediately and permanently delete this e-mail and any attachments if yo=
u
> >received it in error. Internet communications cannot be guaranteed to be=
 timely,
> >secure, error-free or virus-free. The sender does not accept liability f=
or any
> >errors or omissions.
>
>
> This email (including its attachments) is intended only for the person or=
 entity to which it is addressed and may contain information that is privil=
eged, confidential or otherwise protected from disclosure. Unauthorized use=
, dissemination, distribution or copying of this email or the information h=
erein or taking any action in reliance on the contents of this email or the=
 information herein, by anyone other than the intended recipient, or an emp=
loyee or agent responsible for delivering the message to the intended recip=
ient, is strictly prohibited. If you are not the intended recipient, please=
 do not read, copy, use or disclose any part of this e-mail to others. Plea=
se notify the sender immediately and permanently delete this e-mail and any=
 attachments if you received it in error. Internet communications cannot be=
 guaranteed to be timely, secure, error-free or virus-free. The sender does=
 not accept liability for any errors or omissions.
