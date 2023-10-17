Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD5CDB482
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 13:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFD410E2F6;
	Tue, 17 Oct 2023 13:18:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0C510E297
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697534081; x=1729070081;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=5hJ1MOTyviSW3cZFQ1/6LAEsLb2tBCjZ2qHZ6qLypPU=;
 b=GPeI5XqQVBZOvT8zyzLJO/bJ7Hnlm+DI8VvieFJYQMxA/CjFkDj+elJV
 xF1tAoVOK4gqYlvXGJCRbzNV17u8CuIJp7bPhR+A6O9LkW8IkVWgFbn6y
 9rEdaS9KKDZLX/yHxpYKPilPBaEXxNcBvI1a/8svivdIjCMVNiVcpHweL
 AyRez3cpm7rbUsNSDPtPy9lmPk9rlzbSgQDNSJf9+AHsnRsE358WWRURE
 DoONlBvAczW7TJZJ0krX/xx5IuxKkjdtGi/B1FyPQmFJwGpUM6MPg0gEn
 0IWRt7eNNiPf6L4CZWVda4WLtQDUi5cr7/YNMhzEZZzYo18a2eNaHo20c Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416820964"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="416820964"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3851348"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:13:27 -0700
Date: Tue, 17 Oct 2023 12:14:30 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v12 3/9] cfg80211: expose nl80211_chan_width_to_mhz for
 wide sharing
In-Reply-To: <20231017025358.1773598-4-Jun.Ma2@amd.com>
Message-ID: <92dde569-3919-15e-b714-4eb8fbc73eae@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-4-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Tue, 17 Oct 2023 13:18:29 +0000
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
> The newly added WBRF feature needs this interface for channel
> width calculation.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
> 
> --
> v8->v9:
>   - correct typo(Mhz -> MHz) (Johnson)
> ---
>  include/net/cfg80211.h | 8 ++++++++
>  net/wireless/chan.c    | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index d6fa7c8767ad..026d91083f37 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -923,6 +923,14 @@ const struct cfg80211_chan_def *
>  cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
>  			    const struct cfg80211_chan_def *chandef2);
>  
> +/**
> + * nl80211_chan_width_to_mhz - get the channel width in MHz
> + * @chan_width: the channel width from &enum nl80211_chan_width
> + * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
> + * is valid. -1 otherwise.

Add empty line before Return:

> + */
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
> +
>  /**
>   * cfg80211_chandef_valid - check if a channel definition is valid
>   * @chandef: the channel definition to check
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 0b7e81db383d..227db04eac42 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
>  	return true;
>  }
>  
> -static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>  {
>  	int mhz;
>  
> @@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>  	}
>  	return mhz;
>  }
> +EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
>  
>  static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
>  {
> 

-- 
 i.

