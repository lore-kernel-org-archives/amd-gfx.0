Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47125CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 13:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156DD10E2F3;
	Tue, 17 Oct 2023 13:18:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A57D10E29C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697533953; x=1729069953;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=3VKz2nC7lyrDD58NgcAxec6nbzS5Bl7KW30kPUiaSaA=;
 b=GIgP22qaprhm5ej5chPCYM+mTG+x+4/+oBcODHXqaGLyPSk9G8nqbqZx
 WjSV7RrH1UvaU1yGOSQFvWzqhav59k0u8XR9OEHmsZekweegXXc/d2Z8g
 a/TXf0W5/aAJNiErf1U1lzYEr4cdUBWWsuxex7Cb7qk7HrJZD6JKEjLLm
 xuRa0qG+fLIOG5QsNl2k2qiFxsEKSZAClbOuzjdHo73pU6KnSe+R5BIOd
 ueKs4LgCwjD9KF+5/913yt7RreAqO+L9lm35XihFJxviAqKnNdSGjaPNd
 DZr8rPtZuXwvT3UX1e/zWqyc0G+FKQlyiW9Jd9nq1BSKRXZNLSQ2rnnfZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384617336"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="384617336"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826363773"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="826363773"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:12:28 -0700
Date: Tue, 17 Oct 2023 12:12:26 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v12 4/9] wifi: mac80211: Add support for WBRF features
In-Reply-To: <20231017025358.1773598-5-Jun.Ma2@amd.com>
Message-ID: <34acd59e-ff40-1e7-7986-b3d3832a13f@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-5-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Tue, 17 Oct 2023 13:18:28 +0000
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
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, Lijo.Lazar@amd.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 edumazet@google.com, mario.limonciello@amd.com,
 Evan Quan <quanliangl@hotmail.com>, alexander.deucher@amd.com, kuba@kernel.org,
 johannes@sipsolutions.net, pabeni@redhat.com, davem@davemloft.net,
 lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 17 Oct 2023, Ma Jun wrote:

> From: Evan Quan <quanliangl@hotmail.com>
> 
> To support the WBRF mechanism, Wifi adapters utilized in the system must
> register the frequencies in use(or unregister those frequencies no longer

Space is missing.

-- 
 i.

