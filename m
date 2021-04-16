Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E8C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 17:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048E1613B7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048E1613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05DF6EC7C;
	Fri, 16 Apr 2021 17:31:27 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3F46EC7C;
 Fri, 16 Apr 2021 17:31:26 +0000 (UTC)
IronPort-SDR: jSNCwVvmSCwE2BSiP1erxkSaUh4wy5lM62qXstxhZKSxfdw4Bfvvna6AEnLPTxFx4F6gJ+gD3D
 2z4dkj6iT0Jw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182201558"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="182201558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 10:31:22 -0700
IronPort-SDR: 9oFyRbbhcRWs1zOigyzdsE2tWBeTxWDBYPvj/RON052kr4MspyQSJu5NUSDSKBQwT8o5CNfi0R
 G8N4px1Ty8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="390102238"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by fmsmga007.fm.intel.com with SMTP; 16 Apr 2021 10:31:19 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Fri, 16 Apr 2021 20:31:18 +0300
Date: Fri, 16 Apr 2021 20:31:18 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: Re: 16 bpc fixed point (RGBA16) framebuffer support for core and AMD.
Message-ID: <YHnJ5nszQdN7eYMb@intel.com>
References: <20210319210317.32369-1-mario.kleiner.de@gmail.com>
 <YFi9Nu/rAjfEdnBg@intel.com>
 <CAEsyxygUbyjCS0V6AGdh0HPu20wWQaRuTy9pXJmS1XNS+LLcMw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEsyxygUbyjCS0V6AGdh0HPu20wWQaRuTy9pXJmS1XNS+LLcMw@mail.gmail.com>
X-Patchwork-Hint: comment
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 16, 2021 at 06:27:23PM +0200, Mario Kleiner wrote:
> On Mon, Mar 22, 2021 at 4:52 PM Ville Syrj=E4l=E4
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 10:03:12PM +0100, Mario Kleiner wrote:
> > > Hi,
> > >
> > > this patch series adds the fourcc's for 16 bit fixed point unorm
> > > framebuffers to the core, and then an implementation for AMD gpu's
> > > with DisplayCore.
> > >
> > > This is intended to allow for pageflipping to, and direct scanout of,
> > > Vulkan swapchain images in the format VK_FORMAT_R16G16B16A16_UNORM.
> > > I have patched AMD's GPUOpen amdvlk OSS driver to enable this format
> > > for swapchains, mapping to DRM_FORMAT_XBGR16161616:
> > > Link: https://github.com/kleinerm/pal/commit/a25d4802074b13a8d5f7edc9=
6ae45469ecbac3c4
> >
> > We should also add support for these formats into igt.a Should
> > be semi-easy by just adding the suitable float<->uint16
> > conversion stuff.
> >
> =

> Hi Ville,
> =

> Could you point me to a specific test case / file that I should look
> at for adding this?

lib/igt_fb.c is the main thing. It has a bunch of conversion magic
to support rendering into all kinds of weird framebuffer formats
via cairo. =


In this should be mostly a matter of adding convert_uint16_to_float()
and convert_float_to_uint16(), plugging those into fb_convert(),
and declaring the new formats in format_desc[]. There might be
a few little extra details I'm forgetting though.

Once igt_fb has the required stuff kms_plane/pixel-format*
should automagically pick it up if the kernel reports the
format as supported.

Oh, and you need some >1.17 version of cairo for the float
support.

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
