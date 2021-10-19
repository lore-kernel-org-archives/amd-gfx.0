Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7448860EFE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7448860EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E186EB4A;
	Tue, 19 Oct 2021 08:10:50 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656AB6EB4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:10:49 +0000 (UTC)
Date: Tue, 19 Oct 2021 08:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634631047;
 bh=euxSr3f/82bJe/RfW7FtMPd6D54TcOKU2YJFr9jU0oM=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=F8s2UKLYoJyF+McrDAFd8+cwH4u7aVbBySzij73oVgnHuVn2TnNTEb00s0J1nFmsN
 dvCnKKBl9YL23K0xjfnzY/5E9WcbPWthoRpJzJ+qQqytrMLjSNj9A+kzyuaNa8T50+
 Kvj4ScEtrTlWXf/vePvWRpz2EFYjYE5COdtK9aoDjYaaCWMJCPNxai4EcIcUkh7F3c
 hZ0VvhxGh9uv9k8saCw0ArIO+huZcpudDrevWqC9jqKCwsfWQRVDtIZ9lVFgcSLJLm
 aG/kR+O4HbcG9EH4FpQVbDy5lvTVoqUSORQuknvPvVXq4oWYoH1BPGeOPHBpDwTkQY
 FSn6VZsOrEpDg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
Message-ID: <IbTspowQBQlcRaVOdJ40EaV2xtWsqFXO1SbYF4AXqpDPehiAwIWyuMOBmuItYsLAHxbI2wAk5vxE2ydg_WeXoehmP51XBoiHnOPlqdl1tOg=@emersion.fr>
In-Reply-To: <9e6e9cbc-676d-4b2e-4a45-16f6f82d96e4@molgen.mpg.de>
References: <20211014153433.169454-1-contact@emersion.fr>
 <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
 <83v0yDp6ECf071d9soan6ioi2tnd6POWo1kem9kUb08Vdlf1cMkYQlKp-mD5M1e7Vnr9Y-XBdP4R8CcvuAUOZWTod-KI3DdoNhAN-hnOfss=@emersion.fr>
 <9e6e9cbc-676d-4b2e-4a45-16f6f82d96e4@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, October 19th, 2021 at 01:21, Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> Am 19.10.21 um 01:06 schrieb Simon Ser:
> > On Tuesday, October 19th, 2021 at 01:03, Paul Menzel wrote:
> >
> >> Excuse my ignorance. Reading the commit message, there was a Linux
> >> kernel change, that broke Chrome OS userspace, right? If so, and we do
> >> not know if there is other userspace using the API incorrectly,
> >> shouldn=E2=80=99t the patch breaking Chrome OS userspace be reverted t=
o adhere
> >> to Linux=E2=80=99 no-regression rule?
> >
> > No. There was a ChromeOS bug which has been thought to be an amdgpu bug=
. But
> > fixing that "bug" breaks other user-space.
>
> Thank you for the explanation. I guess the bug was only surfacing
> because Chrome OS device, like Chromebooks, are only using AMD hardware
> since a short while (maybe last year).
>
> Reading your message *amdgpu: atomic API and cursor/overlay planes* [1]
> again, it says:
>
> > Up until now we were using cursor and overlay planes in gamescope [3],
> > but some changes in the amdgpu driver [1] makes us unable to use planes
>
> So this statement was incorrect? Which changes are that? Or did Chrome
> OS ever work correctly with an older Linux kernel or not?

The sequence of events is as follows:

- gamescope can use cursor and overlay planes.
- ChromeOS-specific commit lands, fixing some ChromeOS issues related to vi=
deo
  playback. This breaks gamescope overlays.
- Discussion to restrict the ChromeOS-specific logic to ChromeOS, or to rev=
ert
  it, either of these fix gamescope.

Given this, I don't see how the quoted statement is incorrect? Maybe I'm
missing something?

Hope that helps,

Simon
