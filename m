Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCADC36008
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Mar 2025 15:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F137E10E26F;
	Sat, 29 Mar 2025 15:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="WTpWSv3g";
	dkim-atps=neutral
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E3010E26F
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Mar 2025 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1743262375; x=1743521575;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=WTpWSv3gM0E+tsUjqIuiw68CTqoXw63Onj3HDxPLU2zMp0h17s+zoTLUz/BgGy3ug
 N1epblFNnENnXlnxJ9j6X6FvH54y4VQ6ePQZFLAj7NrMfNO/uiGFf/4E/83GcEdl0D
 R4ak+hkq0g21r4jJQqoW6zvaCoKyw4Em+zWUitCkI1mKMvcvTzdWCNJAV3xMgdtXxp
 TmXF+56HBajdEebzz1IS47yTXCSkhoz+WRTZCmlKzXrNkrfcK7nOD8hBk1RFy9HW+u
 aTebiLQk5KHdma7zWEcfBHJzHD7qXJ+H7JfML/O8cmhhK4FQ6wXKPFm+6fjYS43+jv
 hWJp4OH6ra/lA==
Date: Sat, 29 Mar 2025 15:32:49 +0000
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
 louis.chauvet@bootlin.com
Subject: Re: [PATCH V8 20/43] drm/colorop: pass plane_color_pipeline client
 cap to atomic check
Message-ID: <cEsKllgIVrWAYjUm_QfcsMTsJTSZC7F7wt64jNDoRRFfZ_4H5k1gk6j_DLb_gRyG_do0YO9JF2aMhW0hgZfi1btnhoau1-uBQcmUPEVYWCQ=@emersion.fr>
In-Reply-To: <20250326234748.2982010-21-alex.hung@amd.com>
References: <20250326234748.2982010-1-alex.hung@amd.com>
 <20250326234748.2982010-21-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1c10c000760c051aaef61acb510a36b3b7023e3b
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

Reviewed-by: Simon Ser <contact@emersion.fr>
