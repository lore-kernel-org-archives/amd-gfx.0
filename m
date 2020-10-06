Return-Path: <SRS0=TD2D=DN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E25C41604
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 07:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DCC20760
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2020 07:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DCC20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00E156E314;
	Tue,  6 Oct 2020 07:35:22 +0000 (UTC)
X-Greylist: delayed 340 seconds by postgrey-1.36 at gabe;
 Tue, 06 Oct 2020 05:00:48 UTC
Received: from smtprelay.hostedemail.com (smtprelay0016.hostedemail.com
 [216.40.44.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5AE6E2EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2020 05:00:48 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 90D35800E2D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2020 04:55:08 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id E8DE618025614;
 Tue,  6 Oct 2020 04:55:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell79_1c14f78271c4
X-Filterd-Recvd-Size: 2318
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Tue,  6 Oct 2020 04:55:04 +0000 (UTC)
Message-ID: <92c4f9bd1d43b80a424a52131fcbc6a1a416de64.camel@perches.com>
Subject: Re: [RFC PATCH] DRM: amd: powerplay: don't undef pr_warn() {causes
 ARC build errors}
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>,  dri-devel <dri-devel@lists.freedesktop.org>
Date: Mon, 05 Oct 2020 21:55:03 -0700
In-Reply-To: <9c86375d-34a9-6584-0069-452b193076d6@infradead.org>
References: <9c86375d-34a9-6584-0069-452b193076d6@infradead.org>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 06 Oct 2020 07:35:21 +0000
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
Cc: Evan Quan <evan.quan@amd.com>, kernel test robot <lkp@intel.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2020-10-05 at 21:50 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> arch/arc/ implements BUG_ON() with BUG(). ARC has its own BUG()
> function and that function uses pr_warn() as part of its implementation.
> 
> Several (8) files in amd/powerplay/ #undef various pr_xyz() functions so
> that they won't be used by these drivers, since dev_() functions are
> preferred here and the #undefs make the pr_() functions unavailable.
[]
> --- lnx-59-rc7.orig/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ lnx-59-rc7/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -52,7 +52,7 @@
>   * They are more MGPU friendly.
>   */
>  #undef pr_err
> -#undef pr_warn
> +//#undef pr_warn
>  #undef pr_info
>  #undef pr_debug
>  
> --- lnx-59-rc7.orig/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ lnx-59-rc7/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -54,7 +54,7 @@
>   * They are more MGPU friendly.
>   */
>  #undef pr_err
> -#undef pr_warn
> +//#undef pr_warn
>  #undef pr_info
>  #undef pr_debug 

These are bad ideas as all of these pr_<level> entries
may become functions in a near-term future.


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
