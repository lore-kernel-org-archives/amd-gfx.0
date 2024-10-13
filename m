Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D12CF2579
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Oct 2024 15:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CEF10E19A;
	Sun, 13 Oct 2024 15:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="L3Gg4nrA";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B4C10E19A
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Oct 2024 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1728832560; x=1729091760;
 bh=2KltCLB/XS11X81ab89FKAcqfJJknRgPMwVaT180UAg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=L3Gg4nrAf6vhRztGDwsddDXGTkQaGTHLxjx0b1S9+asct5JKu3CsiFpNPBaRcTa16
 IyEPagvqsHG0S0GFmO2L8ea9V1Khj2IxLnzvNV3BzUOuaj+F7yd3+OYh7DZRPu5eiS
 VBBEk05zTYTaEEaQv5eElPxaVBvbM2kRQ4RKtuIHyTUEFU2FZpnNNJUJhxuDFa2rCG
 vQb0gKsXr59nBSjEc79kusZ9pUnsMu/1OUge5TG+q9uJQWONbj00Kanjx+ZUFC0ddm
 88MmbpOv3NdqxIXzny2MNKLtdyfiRFvFHIXKMJ9FpQAXuBo5DPPwVmQ544Glpl52iD
 O9Xjsz+mjrYag==
Date: Sun, 13 Oct 2024 15:15:55 +0000
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 16/44] drm/colorop: Introduce
 DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
Message-ID: <ulTyM1xcShNvAX0ItqtR6YssJWwPiXc6IkB8CIGNwMsQ66HKeg3ZsOmYSArjSga9y5hw_kB41crq3lSXqL1p6R6ucffkZyRHhvk6gN17BsQ=@emersion.fr>
In-Reply-To: <20241003200129.1732122-17-harry.wentland@amd.com>
References: <20241003200129.1732122-1-harry.wentland@amd.com>
 <20241003200129.1732122-17-harry.wentland@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: a80037eb0e35b159f1c79e4f8b573fbafc1ae431
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shouldn't this patch come before the others, otherwise we're exposing
unconditionally color OP uAPI to user-space in-between the first patch
and this one?

Usually we try to not have a broken kernel in intermediate commits. It's
important for bisecting.
