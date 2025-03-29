Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED954C36008
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Mar 2025 15:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F48510E2CF;
	Sat, 29 Mar 2025 15:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="DD8Gq3Uf";
	dkim-atps=neutral
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3EF10E2D2
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Mar 2025 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1743263494; x=1743522694;
 bh=Xbjirl1o4n9wdqM1v8qpezOCIScFfUe1qzeSV1etBs0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=DD8Gq3UfbCpXTF2C4FTFpg3mlN3VmcW2FU0mJROMlF+mQCR66zniB2/TnVFh83T6N
 sfo0qFX/cut4gYcrcbTF93NW6UN94ZmZm0V8BPPVNbtACrfObJeJT119TkMg8uWCPi
 7EvwrVJlruamdrVhFc8sxSE8aGsoRs+jrBasJmfHvNMzEejey218iUbJBuLm9xppLr
 Um5KUwiRC6tZrUCScUCvWAxISPKW4xJs9/PKUFhFQi8ubc8LHq7V2IVk+UIl/2AUpW
 HWiZUSjSYqu6kC0+QCHBvrsOiSslCKyBxgQNsBn66eMfvSypYRGfHuu1h56a5x0oX2
 JgjoQhm05+1iA==
Date: Sat, 29 Mar 2025 15:51:29 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com, leo.liu@amd.com,
 ville.syrjala@linux.intel.com, pekka.paalanen@collabora.com, mwen@igalia.com,
 jadahl@redhat.com, sebastian.wick@redhat.com, shashank.sharma@amd.com,
 agoins@nvidia.com, joshua@froggi.es, mdaenzer@redhat.com, aleixpol@kde.org,
 xaver.hugl@gmail.com, victoria@system76.com, daniel@ffwll.ch,
 uma.shankar@intel.com, quic_naseer@quicinc.com, quic_cbraga@quicinc.com,
 quic_abhinavk@quicinc.com, marcan@marcan.st, Liviu.Dudau@arm.com,
 sashamcintosh@google.com, chaitanya.kumar.borah@intel.com,
 louis.chauvet@bootlin.com, Arthur Grillo <arthurgrillo@riseup.net>
Subject: Re: [PATCH V8 00/43] Color Pipeline API w/ VKMS
Message-ID: <0FHuyQUsCc6DCo8dmjWlZpSh6O33g5K4F4KMM9CaPYsEMeoZHlKt-Flj0WBVeTexhU57D8HCvl4EAK8A-WnbVeV8faDaDaLRA2BS7YhcBRk=@emersion.fr>
In-Reply-To: <20250326234748.2982010-1-alex.hung@amd.com>
References: <20250326234748.2982010-1-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 14d6c30ed63e25d1e11b678d78e510ac3cc383d2
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

Thanks a lot for sending the updated series, Alex! I've looked at all
of the core DRM patches and they all look pretty close to being R-b'ed.
I don't think I'd have time to look at vkms or amdgpu patches. Let me
know if I missed anything!

Simon
