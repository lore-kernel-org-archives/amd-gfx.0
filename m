Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B88B6103C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 15:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B88B6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63C589F63;
	Tue,  3 Aug 2021 15:04:59 +0000 (UTC)
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com
 [91.221.196.215])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375486E88B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 15:04:58 +0000 (UTC)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
 by mx1.smtp.larsendata.com (Halon) with ESMTPS
 id 2eea81a6-f46c-11eb-9082-0050568c148b;
 Tue, 03 Aug 2021 15:05:04 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net
 [80.162.45.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: sam@ravnborg.org)
 by mail01.mxhotel.dk (Postfix) with ESMTPSA id 95AF7194B8B;
 Tue,  3 Aug 2021 17:05:21 +0200 (CEST)
Date: Tue, 3 Aug 2021 17:04:54 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@linux.ie, alexander.deucher@amd.com,
 christian.koenig@amd.com, liviu.dudau@arm.com,
 brian.starkey@arm.com, bbrezillon@kernel.org,
 nicolas.ferre@microchip.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com,
 patrik.r.jakobsson@gmail.com, anitha.chrisanthus@intel.com,
 robdclark@gmail.com, edmund.j.dea@intel.com, sean@poorly.run,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 jyri.sarha@iki.fi, tomba@kernel.org, Dan.Sneddon@microchip.com,
 tomi.valkeinen@ideasonboard.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 00/14] drm: Make DRM's IRQ helpers legacy
Message-ID: <YQlbFjbrnyeWv7QP@ravnborg.org>
References: <20210803090704.32152-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803090704.32152-1-tzimmermann@suse.de>
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

Hi Thomas,

On Tue, Aug 03, 2021 at 11:06:50AM +0200, Thomas Zimmermann wrote:
> DRM's IRQ helpers are only helpful for old, non-KMS drivers. Move
> the code behind CONFIG_DRM_LEGACY. Convert KMS drivers to Linux
> IRQ interfaces.
> 
> DRM provides IRQ helpers for setting up, receiving and removing IRQ
> handlers. It's an abstraction over plain Linux functions. The code
> is mid-layerish with several callbacks to hook into the rsp drivers.
> Old UMS driver have their interrupts enabled via ioctl, so these
> abstractions makes some sense. Modern KMS manage all their interrupts
> internally. Using the DRM helpers adds indirection without benefits.
> 
> Most KMS drivers already use Linux IRQ functions instead of DRM's
> abstraction layer. Patches 1 to 12 convert the remaining ones.
> The patches also resolve a bug for devices without assigned interrupt
> number. DRM helpers don't test for IRQ_NOTCONNECTED, so drivers do
> not detect if the device has no interrupt assigned.
> 
> Patch 13 removes an unused function.
> 
> Patch 14 moves the DRM IRQ helpers behind CONFIG_DRM_LEGACY. Only
> the old non-KMS drivers still use the functionality.
> 
> v2:
> 	* drop IRQ_NOTCONNECTED test from atmel-hlcdc (Sam)
> 	* use devm_request_irq() in atmel-hlcdc (Sam)
> 	* unify variable names in arm/hlcdc (Sam)
> 
> Thomas Zimmermann (14):

The following patches are all:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

>   drm/fsl-dcu: Convert to Linux IRQ interfaces
>   drm/gma500: Convert to Linux IRQ interfaces
>   drm/kmb: Convert to Linux IRQ interfaces
>   drm/msm: Convert to Linux IRQ interfaces
>   drm/mxsfb: Convert to Linux IRQ interfaces
>   drm/tidss: Convert to Linux IRQ interfaces
>   drm/vc4: Convert to Linux IRQ interfaces
>   drm: Remove unused devm_drm_irq_install()

The remaining patches I either skipped or already had a feedback from
me or I asked a question.

	Sam
