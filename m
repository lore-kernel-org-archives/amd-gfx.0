Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F73C83F14
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 20:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC71210E851;
	Wed,  9 Jul 2025 20:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="IXQu+MF5";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E4710E851
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1752093014; x=1752352214;
 bh=f3wo+BEjgOI8A8/i/tByZ7AuRr/xEvtzQxvcIiw6tTM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=IXQu+MF5Xo4Xtg8BiWBJuf/85IwtYTFi39x9rvgPWeZYUuT/OlQ97cvimHhnKVMZL
 QxEQ4VuMuMCLcuMgVurkQmvMusGyytBueGW9PmB5iZ8z4QcB9s/OiBSgsC1tdNVzZw
 ovTHB58wbSSiMCMAuCybRqEIi44mdIX8ZH+V5m5Pfu4Ydp9IWM1Rd6HCGObbqvSbSs
 QW+3Jz7TJGC0CT+G7B76VMTvZ6XuZB7P7WunobvOUSSJEl6qO78BwcDQt1Z/JRE4jB
 y4kwFhKAZ1fAFPV3fiQqvqN4mNoJ8/E+hFDCO0Vi6GOyIba1V8pyzlP6C62vKz+2Ku
 7MYKY2E2+9RAA==
Date: Wed, 09 Jul 2025 20:30:11 +0000
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
 louis.chauvet@bootlin.com, arthurgrillo@riseup.net,
 Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH V10 40/46] drm/colorop: Define LUT_1D interpolation
Message-ID: <xn27XZjdRP83I8eaTGnDdLyvppJUppZ_GVsnDJQ1wK3UINAwh4FEutAlh02CtvZoPbB4D7zhof9rGj1DsxHpccpGK7ID-S-DjGi5VRhAD8I=@emersion.fr>
In-Reply-To: <20250617041746.2884343-41-alex.hung@amd.com>
References: <20250617041746.2884343-1-alex.hung@amd.com>
 <20250617041746.2884343-41-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: bb790c2e663b1cc6e273456efea57e7c5d9e32f0
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

On Tuesday, June 17th, 2025 at 06:27, Alex Hung <alex.hung@amd.com> wrote:

> - 1D LUT is no longer immutable (Xaver Hugl)

I think we should keep it immutable for now, and we can make it mutable
in the future when we want to extend the uAPI to make it switchable by
user-space.
