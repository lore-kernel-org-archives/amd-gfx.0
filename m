Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5E0C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859B210E624;
	Tue,  3 Jun 2025 13:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CpiLr4Yy";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3F810E711
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:04:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B65F25C57AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45539C4AF09
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748955887;
 bh=DoAXo4OnDoZDuAMbwm5BIR0ENeifjBrBXXHSJzqMr00=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CpiLr4YylX3AxM3o89JCo1GxXmRkLiF4MIJZ36P1QJdEE6P9wwpUEEdk90h1xOOz4
 OyKP2I7pYha6q1nX8GBDsrZ5+tmILfYUePakFLi+YVJzCL6VwPnFOmfG+YUr79Z7G5
 fsB47LyIVIuP5+S4tsLbvdcOySExmu+R3r7O2vi3zImiuEah5F0hu0wIkjKcgoYAh/
 etfpsd4z3GHD2LS3u1UatP/m8U0Fjj0FZrBZ/2CG+4yzc8ha2n6a4FmVX5e+xcpUCn
 jhVvODiXfOSdD4UmMGnM9tpVfnxO4ergaPZBQIUb2otdzeABcLtot2mLnVtqHAYJNU
 Q7erll6/4CpFw==
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-6066c02cd92so2631927eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 06:04:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXy0MesX74wVx9/bYzFIB6fuv3I2D9xEsDvcygrXFPXu6VMeUgliKoAbDuSv4/ec4EPQ1395aFt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO1YoEdANK2S1I+fryCWVrKojiM1Ot3OkoUvQUEankGGmqYa6D
 Q//MfKw0a+jvR/PGYKPW6nbkYeKAWL6Hqsp09SCWSkJsFMaxflhhWygMf3Yd0HgQSzs+wvNl2vB
 ei+iyCzDnYJrajmujtwa4XIAsIg+dDCM=
X-Google-Smtp-Source: AGHT+IH70pTjoyraAJHi2TFHPJtOz3pkE8jHNSJbFcVKb6HyzZg4kpHwMOUUaBz8jHmx5I+H0d1MTCu/TuC6HKfEFb8=
X-Received: by 2002:a05:6820:270f:b0:60b:d692:7c53 with SMTP id
 006d021491bc7-60c4d747a4cmr9965476eaf.8.1748955886491; Tue, 03 Jun 2025
 06:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <aD2U3VIhf8vDkl09@debian.local>
 <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
 <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
 <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
 <CAJZ5v0hpJSVdiCN29=kbV8KfgU1y1d3hFfshtBoMpVFXf+LvBQ@mail.gmail.com>
 <aD7nOMP3xA9BR781@debian.local>
 <CAJZ5v0gAcohRWuSZbFWvyfAU9Vjc7nRyj+AFRYQ7hcGEXdPxyQ@mail.gmail.com>
 <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
In-Reply-To: <CAP-bSRbVjcXBvxDT6ZQuoRB+JF6A4LhdMVnNqnaQC0bg-xg2BQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 15:04:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
X-Gm-Features: AX0GCFtu4dUDCitADOsGBJLQC6GA0pUrhBB1aNLhVDidgU_jWioLD5HwF13ubQo
Message-ID: <CAJZ5v0gTRtPzrROdkxRjTeXv4BsRyUkyGpCWmh-gHNx3X2L9RA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <superm1@kernel.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, 
 Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="00000000000057bb180636aa868e"
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

--00000000000057bb180636aa868e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:27=E2=80=AFPM Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> On Tue, 3 Jun 2025 at 13:24, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > This patch does fix the list corruption, but the "Unbalanced
> > > pm_runtime_enable" still occurs:
> >
> > Have you applied it together with the previous patch?
>
> Yes

So it looks like some devices have power.is_suspended set from the
previous cycle which causes device_resume() to attempt to resume them
even though they have not been suspended in the current cycle yet.

Please try the attached patch in addition to the previous 2 patches.

Thanks!

--00000000000057bb180636aa868e
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-is_suspended-cleanup.patch"
Content-Disposition: attachment; 
	filename="pm-sleep-is_suspended-cleanup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbgj46x00>
X-Attachment-Id: f_mbgj46x00

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCi0tLSBhL2RyaXZlcnMvYmFzZS9wb3dl
ci9tYWluLmMKKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL21haW4uYwpAQCAtOTkyLDYgKzk5Miw4
IEBACiAJaWYgKCFkZXYtPnBvd2VyLmlzX3N1c3BlbmRlZCkKIAkJZ290byBDb21wbGV0ZTsKIAor
CWRldi0+cG93ZXIuaXNfc3VzcGVuZGVkID0gZmFsc2U7CisKIAlpZiAoZGV2LT5wb3dlci5kaXJl
Y3RfY29tcGxldGUpIHsKIAkJLyoKIAkJICogQWxsb3cgbmV3IGNoaWxkcmVuIHRvIGJlIGFkZGVk
IHVuZGVyIHRoZSBkZXZpY2UgYWZ0ZXIgdGhpcwpAQCAtMTA1NCw3ICsxMDU2LDYgQEAKIAogIEVu
ZDoKIAllcnJvciA9IGRwbV9ydW5fY2FsbGJhY2soY2FsbGJhY2ssIGRldiwgc3RhdGUsIGluZm8p
OwotCWRldi0+cG93ZXIuaXNfc3VzcGVuZGVkID0gZmFsc2U7CiAKIAlkZXZpY2VfdW5sb2NrKGRl
dik7CiAJZHBtX3dhdGNoZG9nX2NsZWFyKCZ3ZCk7Cg==
--00000000000057bb180636aa868e--
