Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C39C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 08:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DCE61175
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 08:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DCE61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CA86E075;
	Mon,  3 May 2021 08:44:51 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F2C6E075;
 Mon,  3 May 2021 08:44:49 +0000 (UTC)
IronPort-SDR: El/yz9nnWEW1LjzRnRFbBpuEOGcmoXAsyY+F9jpyjv95mm5h8kvC0vD6hGztnTXD/6ExWF6bWP
 4ik4vqmjvIsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9972"; a="197305479"
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; d="scan'208";a="197305479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2021 01:44:48 -0700
IronPort-SDR: xd2qe6U1Q/xAyIkxyzZeoM9XM2kr4OgipLQMoXq+fusHEHNLgIOPw6axHuvG73mxfbnACMrp39
 GPmZH6l4viyw==
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; d="scan'208";a="432633606"
Received: from tbashir-mobl.ger.corp.intel.com (HELO localhost)
 ([10.252.51.126])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2021 01:44:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Cornij\, Nikola" <Nikola.Cornij@amd.com>,
 "lyude\@redhat.com" <lyude@redhat.com>,
 "amd-gfx\@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/1] drm/i915: Use the correct max source link rate for
 MST
In-Reply-To: <DM5PR12MB4679215F5490F2D38E2A6C51EE5E9@DM5PR12MB4679.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210430214531.24565-1-nikola.cornij@amd.com>
 <20210430214531.24565-2-nikola.cornij@amd.com>
 <20bfb456d1f05856ffdc4cd330e1155b99367a01.camel@redhat.com>
 <DM5PR12MB4679215F5490F2D38E2A6C51EE5E9@DM5PR12MB4679.namprd12.prod.outlook.com>
Date: Mon, 03 May 2021 11:44:41 +0300
Message-ID: <87h7jk1a12.fsf@intel.com>
MIME-Version: 1.0
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
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "koba.ko@canonical.com" <koba.ko@canonical.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>, "Lipski,
 Mikita" <Mikita.Lipski@amd.com>,
 "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 30 Apr 2021, "Cornij, Nikola" <Nikola.Cornij@amd.com> wrote:
> I'll fix the dpcd part to use kHz on Monday

I'd appreciate that, thanks. I think it is the better interface.

> My apologies as well, not only for coming up with the wrong patch in
> first place, but also for missing to CC all the maintainers.

The drivers we have are monsters, and it can be tricky to get the
details right. All the more important to get the Cc's right; then at
least you can blame us afterwards. ;)

Thanks for reacting quickly, though.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
