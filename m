Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EEE61027
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04EEE61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A9B6EAA0;
	Mon, 18 Oct 2021 23:06:40 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 517666EAA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:06:39 +0000 (UTC)
Date: Mon, 18 Oct 2021 23:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634598392;
 bh=DNRhC/mQ+chQwgJU0QMgToYF2ekJf2yH1fSqR8CmaP4=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=XMHEo3OpTAH3QSF8xf0FbcS8v+RK/sagXc5jQ25HY5twEN1pzw5oecS9LrSSkG7b/
 uP9xMwiSsFSNDoq2oiL09a2v81EgdZ3+Zg1saR+fIwVv7TCEzYVVXlerM/O05XRuBX
 ExH0UE2YYP1KpfkNT1WqmCCyrtLRogwI9amiYATrbjGE91xdCK/RbjNNiX+aIKO8B0
 QykUMxlS62F72ksxgnm8dGv7PZRV8hwzi8V39UHKhJcqaNcQpfZWFneZutxn2nLFbx
 3sRI6rKL/+EkaMgQz8glnDU9U41Un8+qd/+nF3qZ/0UpjtMkG8nf+9UcPalavGBwG0
 S34qpwmIQ3tkQ==
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
Message-ID: <83v0yDp6ECf071d9soan6ioi2tnd6POWo1kem9kUb08Vdlf1cMkYQlKp-mD5M1e7Vnr9Y-XBdP4R8CcvuAUOZWTod-KI3DdoNhAN-hnOfss=@emersion.fr>
In-Reply-To: <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
References: <20211014153433.169454-1-contact@emersion.fr>
 <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
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

On Tuesday, October 19th, 2021 at 01:03, Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> Excuse my ignorance. Reading the commit message, there was a Linux
> kernel change, that broke Chrome OS userspace, right? If so, and we do
> not know if there is other userspace using the API incorrectly,
> shouldn=E2=80=99t the patch breaking Chrome OS userspace be reverted to a=
dhere
> to Linux=E2=80=99 no-regression rule?

No. There was a ChromeOS bug which has been thought to be an amdgpu bug. Bu=
t
fixing that "bug" breaks other user-space.
