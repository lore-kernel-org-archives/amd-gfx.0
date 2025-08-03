Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D8C87FCA
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Aug 2025 10:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AB410E4E5;
	Sun,  3 Aug 2025 10:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="qEY7Dve0";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C592E10E075
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1754216663; x=1754475863;
 bh=/p3/ye2kr/NSHR+Bb844xeICp5/llZX5W/aZ7SyK2II=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=qEY7Dve0zimP25d3pmIhhunWNUN97ul26F41KmPdg0iVfV/iAa1ziEPfMJYqZgUBS
 /aCQiEftBzDzAkh1nrxhYIfkTsmty3VwqrOpRE+VOrBO21K/o8PGlHiAsDHEwzBsAO
 SdNriEQc7QnesdaSChnKRgjFeHAWTMC8KAiAVuz31Xo93IEhHNsh3nOHZd+sR0z1Yh
 ZKO88AqNuHg1oPSgqHgx3qNrhZqq6YmgQgK/gh+8osW6fTd5fwQ8ESQfGrb5VBYpHz
 coQVj6u7tbdpeN2bZrq8qUAxgT949TxYxJk9/fftFP8SjgxwtA0l3ruRLk5IeVooaZ
 pmAosFtOPzzrA==
Date: Sun, 03 Aug 2025 10:24:17 +0000
To: =?utf-8?Q?N=C3=ADcolas_=22F=2E_R=2E_A=2E_Prado=22?=
 <nfraprado@collabora.com>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 harry.wentland@amd.com, leo.liu@amd.com, ville.syrjala@linux.intel.com,
 pekka.paalanen@collabora.com, mwen@igalia.com, jadahl@redhat.com,
 sebastian.wick@redhat.com, shashank.sharma@amd.com, agoins@nvidia.com,
 joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org, xaver.hugl@gmail.com,
 victoria@system76.com, daniel@ffwll.ch, uma.shankar@intel.com,
 quic_naseer@quicinc.com, quic_cbraga@quicinc.com, quic_abhinavk@quicinc.com,
 marcan@marcan.st, Liviu.Dudau@arm.com, sashamcintosh@google.com,
 chaitanya.kumar.borah@intel.com, louis.chauvet@bootlin.com,
 arthurgrillo@riseup.net, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH V10 13/46] drm/colorop: Add destroy functions for color
 pipeline
Message-ID: <L1Z5NdAqsKKxLye8RDhCz1zWm5IgwmdJwGHfy4ctcR6fhJctxyckoaci-ir_zuDKTFsWDKfnXdbxc-oyYGCGIwXWugxZG16zIh99p3GhteA=@emersion.fr>
In-Reply-To: <07cd16202b742b37a0d4f70ff8d3a7a3ce3b1648.camel@collabora.com>
References: <20250617041746.2884343-1-alex.hung@amd.com>
 <20250617041746.2884343-14-alex.hung@amd.com>
 <07cd16202b742b37a0d4f70ff8d3a7a3ce3b1648.camel@collabora.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 85d58c1602d30ea3aed636ce46367658fc6c3765
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

On Friday, August 1st, 2025 at 00:12, N=C3=ADcolas "F. R. A. Prado" <nfrapr=
ado@collabora.com> wrote:

> This function implies it only cleans up the colorops in the color
> pipeline of a specific plane, but it actually cleans up all colorops in
> the drm_mode_config of a device.

Good catch! Would make more sense to take a drm_device in.
