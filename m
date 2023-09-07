Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D116EE14D7
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 06:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228B410E772;
	Thu,  7 Sep 2023 06:52:09 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A274C10E772;
 Thu,  7 Sep 2023 06:52:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1D0B0B81A56;
 Thu,  7 Sep 2023 06:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75840C433D9;
 Thu,  7 Sep 2023 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694069521;
 bh=DbVPF3fDuw+/fHxkvTKzad9h+IArdS9JFe7ZDMm1wRs=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
 b=I3CaSgdX+UXuLoTXrYqF74CfiYpT3dwsti35q8kBkQRaXW9ykJtq8eDKFYRguPgsD
 O+FuJc6uRm+FEgpRbwt/cdx4mgd2vMerRWmhSJP4+7EqiRJ5YWsa5bc8RCA5nFdPrq
 /4jcmzcSy5xLdfTXLykPw3nAW3n5sXJ/wM8dnLcPqr+ujrSHc5JVuvvLq0RB22wzOz
 tjK2W8UdB4yXSspV1zN3YSf/h3bUucnw88Vte8V9LXEohvRd+jFss8dmCvp7SQ9Dxp
 nYt3WkuAIvmWNu4kMf/d4YdtKQOtHaxCSlD9OOzlTnx0uH7obJiQO2KfOEmvn7pCmN
 86ncDuPDk6ojA==
Message-ID: <040b316aae533abac3d3fa9c1eaff3d1.mripard@kernel.org>
Date: Thu, 07 Sep 2023 06:51:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Jim Cromie" <jim.cromie@gmail.com>
Subject: Re: [PATCH v3 4/5] drm/vc4: add trailing newlines to drm_dbg msgs
In-Reply-To: <20230906190224.583577-5-jim.cromie@gmail.com>
References: <20230906190224.583577-5-jim.cromie@gmail.com>
Content-Transfer-Encoding: 7bit
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
Cc: Maxime Ripard <mripard@kernel.org>, Emma Anholt <emma@anholt.net>,
 jani.nikula@intel.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robdclark@gmail.com, seanpaul@chromium.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, David
 Airlie <airlied@gmail.com>, intel-gvt-dev@lists.freedesktop.org,
 ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 6 Sep 2023 13:02:22 -0600, Jim Cromie wrote:
> By at least strong convention, a print-buffer's trailing newline says
> "message complete, send it".  The exception (no TNL, followed by a call
> to pr_cont) proves the general rule.
> 
> Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
