Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D2C3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 16:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B5510E755;
	Thu,  5 Jan 2023 16:01:35 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B638410E755
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 16:01:33 +0000 (UTC)
Date: Thu, 05 Jan 2023 16:01:18 +0000
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="cRhfUE8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1672934484; x=1673193684;
 bh=FYT19YRig7+3DWEq9DPUZ81iWivNICHTmXVAjOXMm0c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=cRhfUE8yBga/DoADsMOydDRuSKcZe3RpWHgQELWqZwLtgvPCPwYQrTCs957N6X4/F
 9W1+M6AzBfHvVJUz46ZHjZ5xzhPUxTMEi+w9zmWEB0UXIe63VJUxprYCCcwC37383k
 g/rjLVfip1jE9xzXcX1rZ1wMHKsszvGGd681LlDCAqNs919vt0WTRr0MdoTi6dPBTU
 U3PWeWGS9VkxWX+z3wMtszClOjDvrC0Z3Dx+XoW9jGilMJnExqQRVQ1BXss5fUL5+F
 8Q3Bl+bLlosu2hDN0rpBiQ8Q6kBlt07OHNLiMcF7jKXtHIoY48iH3nKww+JINVrkD2
 vFzFVIrNafaxw==
To: =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 0/6] Add support for atomic async page-flips
Message-ID: <mUbWRvaKE0P3xaf7qy0aVeNHaoGpCmS1qPXYt9Uta7837U8zNh41jd-auKVO_bqrkmscOsF0_diu4sxqd0CML6rL6VEFttgeZBS2MJqa_S4=@emersion.fr>
In-Reply-To: <2gTBGn0MFrQeE-GBD4weUAgOHEYiLDD5_hqTLNxOYKYIOfD1HL_84sEVhjftn7nR3kr0of-bONvg55mHNDCuOiwAhCcKexGrD9RvIN-OHw8=@emersion.fr>
References: <20220929184307.258331-1-contact@emersion.fr>
 <Yzb0uNjB5FpjCIjq@intel.com> <Yzb6203nHF8fVH/W@intel.com>
 <YzcGw9myJotLRTVl@intel.com>
 <PJIfCPDOH8tzwE1mwv58g4ICBZbEgW44vwzW-JdUde6PjLDUeF_JNT0kUZ_Z8hZWqii_DTdDFfAYpRbO_T1Tu28wpjiwYlQpRdsrHJXLF58=@emersion.fr>
 <2gTBGn0MFrQeE-GBD4weUAgOHEYiLDD5_hqTLNxOYKYIOfD1HL_84sEVhjftn7nR3kr0of-bONvg55mHNDCuOiwAhCcKexGrD9RvIN-OHw8=@emersion.fr>
Feedback-ID: 1358184:user:proton
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
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 mwen@igalia.com, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 hwentlan@amd.com, nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hm, thinking about this again, there's still something which is a bit
off with the new approach. Let's say the caller sets MODE_ID to another
blob ID, but with the same blob payload. DRM core is smart enough to
figure out that the mode didn't change and skip the modeset. However,
the check implemented here isn't smart enough.

tl;dr there are still discrepancies between the regular code-path and
the async page-flip one. Does that matter?
