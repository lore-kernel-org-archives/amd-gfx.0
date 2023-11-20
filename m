Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54297C2BB3F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 15:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5E510E422;
	Mon, 20 Nov 2023 15:40:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBF710E3A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700481593; x=1732017593;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=hLlgtN7e+i6tZI3bxI8GySjeZu1w9pcdPAelbmCT79A=;
 b=PU0P1fFlepeIrHUMp9oRK8f7ggnceVcBwcsr8EF7pMuNOEG67r1OqpuX
 1Yly59lnLpziaSbUsLl6wGjuUvJ99XiCXix35cRWY0F4oCvSDIfSgPp0c
 v/FCmR6m9u50iVBgAYO/RuO8TesKUfwRohJII2m3OfUacDAwX1NvdFWvu
 obAF+4riVGMBOupexgevm/nebzo+acAS1/ZGgxLom0cLNOXySaVVoLY6W
 eBmSOkyx5eVcsrup/oPd8gQZOI2C7lhNIPnekUKkzkEPVtycZNXFJ9Cia
 s/syjlZDGykvxEBeoa73eHTJ2eGIafliSvNZrcrAip9KMTQuY806ccida A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4723177"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4723177"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 03:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="766253122"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="766253122"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 03:59:46 -0800
Date: Mon, 20 Nov 2023 13:59:44 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [Patch v13 1/9] Documentation/driver-api: Add document about
 WBRF mechanism
In-Reply-To: <20231030071832.2217118-2-Jun.Ma2@amd.com>
Message-ID: <3e18c716-4c1b-ea3-ede3-5a67555f5e72@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
 <20231030071832.2217118-2-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Mon, 20 Nov 2023 15:40:24 +0000
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
Cc: linux-doc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 Lijo.Lazar@amd.com, linux-wireless@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, edumazet@google.com,
 mario.limonciello@amd.com, alexander.deucher@amd.com, kuba@kernel.org,
 johannes@sipsolutions.net, pabeni@redhat.com, davem@davemloft.net,
 lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 30 Oct 2023, Ma Jun wrote:

> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 76 +++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============

A lot better but you missed adding newlines here for this and previous 
section title.

> +The expected flow for the producers:
> +1). During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +    can be enabled for the device.
> +2). On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +    param to get other consumers properly notified.
> +3). Or on stopping using some frequency band, call
> +    `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1). During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +    can be enabled for the device.
> +2). Call `amd_wbrf_register_notifier` to register for notification
> +    of frequency band change(add or remove) from other producers.
> +3). Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +    current active frequency bands considering some producers may broadcast
> +    such information before the consumer is up.
> +4). On receiving a notification for frequency band change, run
> +    `amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +    active frequency bands.
> +5). During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +    unregister the notifier.

The correct kerneldoc format should be without the closing parenthesis:

1. Text here that
   spills to second line.
2. Second entry.

-- 
 i.

