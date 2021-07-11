Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5292C07E9C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EBF61153
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EBF61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DD089B78;
	Mon, 12 Jul 2021 07:18:40 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0070.hostedemail.com
 [216.40.44.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1840C89AAE;
 Sun, 11 Jul 2021 23:46:26 +0000 (UTC)
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2031B2289C;
 Sun, 11 Jul 2021 23:46:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf19.hostedemail.com (Postfix) with ESMTPA id D810E20D75C; 
 Sun, 11 Jul 2021 23:46:23 +0000 (UTC)
Message-ID: <111b2612313dc85eb6cffb5ec93423e92aadef15.camel@perches.com>
Subject: Re: drm/amd/display: Simplify hdcp validate_bksv
From: Joe Perches <joe@perches.com>
To: kernel test robot <lkp@intel.com>, Bhawanpreet Lakha
 <Bhawanpreet.Lakha@amd.com>
Date: Sun, 11 Jul 2021 16:46:22 -0700
In-Reply-To: <202107120638.fhBzNbDi-lkp@intel.com>
References: <d3a180c3dc8db68a25440edf466cfeddcaae5a64.camel@perches.com>
 <202107120638.fhBzNbDi-lkp@intel.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D810E20D75C
X-Stat-Signature: 4w3xb16q81jdos9h7m1m6o7oixokhp8p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19RtmqfZkbsFeCZmvi7tQ9HuVjqDlNgdx4=
X-HE-Tag: 1626047183-174502
X-Mailman-Approved-At: Mon, 12 Jul 2021 07:18:38 +0000
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
Cc: kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
 LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2021-07-12 at 07:02 +0800, kernel test robot wrote:
> Hi Joe,
> =

> I love your patch! Yet something to improve:
> =

> [auto build test ERROR on drm-intel/for-linux-next]
> [also build test ERROR on drm-exynos/exynos-drm-next linus/master next-20=
210709]
> [cannot apply to kees/for-next/pstore tegra-drm/drm/tegra/for-next drm/dr=
m-next v5.13]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> =

> url:    https://github.com/0day-ci/linux/commits/Joe-Perches/drm-amd-disp=
lay-Simplify-hdcp-validate_bksv/20210712-034708
> base:   git://anongit.freedesktop.org/drm-intel for-linux-next
> config: i386-randconfig-a003-20210712 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build):
> =A0=A0=A0=A0=A0=A0=A0=A0# https://github.com/0day-ci/linux/commit/66fae2c=
1becdcb71c95f2c6a6413de4dfe1deb51
> =A0=A0=A0=A0=A0=A0=A0=A0git remote add linux-review https://github.com/0d=
ay-ci/linux
> =A0=A0=A0=A0=A0=A0=A0=A0git fetch --no-tags linux-review Joe-Perches/drm-=
amd-display-Simplify-hdcp-validate_bksv/20210712-034708
> =A0=A0=A0=A0=A0=A0=A0=A0git checkout 66fae2c1becdcb71c95f2c6a6413de4dfe1d=
eb51
> =A0=A0=A0=A0=A0=A0=A0=A0# save the attached .config to linux build tree
> =A0=A0=A0=A0=A0=A0=A0=A0make W=3D1 ARCH=3Di386 =

> =

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> =

> All errors (new ones prefixed by >>, old ones prefixed by <<):
> =

> > > ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko=
] undefined!

curious.

Anyone know why?


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
