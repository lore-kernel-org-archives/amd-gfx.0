Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9893BCA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 19:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C5510E91F;
	Thu,  8 Oct 2026 19:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GLJWRI/6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF18710E91F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:16:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B518A60267;
 Thu,  8 Oct 2026 19:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5111F000FF;
 Thu,  8 Oct 2026 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791486988;
 bh=V/dD73O0qYWnuhR+33XqIFxZxWXjPtj5XHflOH4Zjvc=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=GLJWRI/6MT72mRCXqxt/3cuE0brl79WCWUEzo0FwChIKhsN96PySr9Ey+mZ9pZLtQ
 9fVNqZbjFcrzHWuyAQgl1Y59jYdrE0/YnYIbil307iewNozuKZ5GTTZaQ19TyBtRBZ
 J/ikBLw2NGDZeZsd6diy0DK8ULj/iTD59ydFnwVtcywwdZ7S2iBdJxplE9rZ/6lohE
 1vJbBv9LCOoxbpieBX3634jnTmHE0X5CmfBzkgNtaPU5wr/RG+yKXpg9IhgtcIFjhK
 jcMyRvknJc8NrDg+avdGkpHjOetHFAtfS+x8ui/ufXPwP0G9i+Sy7DZNAAMw5ZWWLo
 qPV1SXfJiLW0Q==
Date: Thu, 8 Oct 2026 14:16:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: GPU initialization failure with kernel 7.3
Message-ID: <20261008191626.GA918896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com>
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

On Mon, Oct 05, 2026 at 04:14:45PM -0400, Alex Deucher wrote:
> Hi Lukas,
> 
> The following commit causes GPUs to fail to initialize on a number of
> our servers:
> eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> The change reverts cleanly and the GPUs initialize fine with it
> reverted.  I've filed a kernel bug to track this:
> https://bugzilla.kernel.org/show_bug.cgi?id=222095
> Happy to test patches, etc.

#regzbot introduced: eddba19b8b5f
