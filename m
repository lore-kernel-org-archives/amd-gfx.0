Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EEDC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 12:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B11710E389;
	Mon,  3 Jun 2024 12:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hLd0q2fk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313A510E0D7;
 Fri, 31 May 2024 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717169566; x=1748705566;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3etIn3wD4YKQlTjuROd7Oo6lOSJcR3qD7Jk9Yz8CHEA=;
 b=hLd0q2fkTNe+YEA154yZgLu6KG7W/NLUI2ffyimCl4mE9O2fp3wTMe4O
 qEYTTlVVYBG8pe0lAKTXWKTzQV8pC3ZqPDm5okeue0GOtUndZ0DG0Ui8J
 mPuy1sKTfInsBozzSMy2EI0YkOEvQCT/c7uN/V4gmMHv+4x1+Ym2eO8Tz
 1nYWM8WvxcpAqkNQqY/YuULxoSAsedoJu2dziNnTRrlaXB4C9n/QmMLF6
 Enc9EI6yDCJ29XhiuGvhPGBtA/qOQpYbPdasUQt2Qtsf7+5pmsWxLspKd
 Spo2t8lgcrNXJN4LCz+lcaNhJztOv86RRb+hh9TFblJuoQPzXMSURHo1T g==;
X-CSE-ConnectionGUID: JgwvOy0pRPiSWzZ90FrsXA==
X-CSE-MsgGUID: xny4bOUGSYe5hnQAEJT76w==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24381267"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="24381267"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 08:32:45 -0700
X-CSE-ConnectionGUID: rKba3UEcT8ulk9qB8K/H8g==
X-CSE-MsgGUID: UksFEEPsQ/Or02YNbMKKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="41272597"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 08:32:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sD4FE-0000000CVTM-0kXL; Fri, 31 May 2024 18:32:40 +0300
Date: Fri, 31 May 2024 18:32:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
Message-ID: <Zlntl4m8ztZDNGwJ@smile.fi.intel.com>
References: <20240531053704.2009827-1-olvaffe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531053704.2009827-1-olvaffe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Approved-At: Mon, 03 Jun 2024 12:52:59 +0000
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

On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
> We can skip children resources when the parent resource does not cover
> the range.

> This should help vmf_insert_* users on x86, such as several DRM drivers.

vmf_insert_*()

> On my AMD Ryzen 5 7520C, when streaming data from cpu memory into amdgpu
> bo, the throughput goes from 5.1GB/s to 6.6GB/s.  perf report says

Also in the $Subj (and pay attention to the prefix)

"resource: ... find_next_iomem_res()"


-- 
With Best Regards,
Andy Shevchenko


