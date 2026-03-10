Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD9FFD2D63
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A68310E6FF;
	Tue, 10 Mar 2026 12:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZVgAtbeA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2267310E6E1;
 Tue, 10 Mar 2026 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773146449; x=1804682449;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=4n7SWzZw3HonRxcsYR4K9EQXN55FZ8Ptv8pjgw3X5aI=;
 b=ZVgAtbeATH2gPepv4Z+2jHCNIZ2n5tKLvg1Hrmecpec6ASlOj2nW/wO4
 F+6XIuoIxVEAqKi/dzbtG4tcy0BW+xKbROPxZFUwIsJHLVunZcHvoLigX
 sCAhcbIpbdh0YNs8mQsf3Lu20uK/9VVcvOhXOx2qAVANeWVrw8xqHEmQg
 yYSW4gxW8JZnQZr+9kenqpVI7j4DZiClXmRxC4/o/z0b3tku+QJfpmrEI
 Gmij16wLVOOILj8TAGg5xoysQc+kjq9w1/nRVrL6efG/+tIc2zkXpEpA4
 JXGVUnRKXKr49PcghveNC4sJY5KRliiuufF95LJYzZjptLo2tWZg/O0+r g==;
X-CSE-ConnectionGUID: +Px5qBpATBOtDNZeAic2RQ==
X-CSE-MsgGUID: ma9DedQySGa8vUxol0xpQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74268672"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74268672"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 05:40:49 -0700
X-CSE-ConnectionGUID: YN7AYaNRS1SW7BYHWz48Hw==
X-CSE-MsgGUID: 8/8ToG5IQtCvFB7Zui+W9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="225039280"
Received: from wtcline-desk20.amr.corp.intel.com (HELO localhost)
 ([10.245.246.50])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 05:40:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Philipp Hahn
 <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Zhenyu Wang
 <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 37/61] drm: Prefer IS_ERR_OR_NULL over manual NULL check
In-Reply-To: <e8a328f9-568c-428c-9111-8742e5dc9a4e@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-37-bd63b656022d@avm.de>
 <e8a328f9-568c-428c-9111-8742e5dc9a4e@amd.com>
Date: Tue, 10 Mar 2026 14:40:37 +0200
Message-ID: <fcb42057cbea719f7f131f57a822822b37eddd48@intel.com>
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

On Tue, 10 Mar 2026, Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Alternatively when the i915 and rockship maintainers say that they are
> fine with the change I'm happy to push this to drm-misc-next.

[dropped most Cc's because, well, there's no need to spam the world]

For the i915 parts,

Acked-by: Jani Nikula <jani.nikula@intel.com>


--=20
Jani Nikula, Intel
