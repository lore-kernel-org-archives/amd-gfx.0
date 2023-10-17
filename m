Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F36CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 13:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F1E10E2F5;
	Tue, 17 Oct 2023 13:18:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2186C10E2A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697534424; x=1729070424;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=v/7G7MGX1gcW6Dj8Rktw//OjNQ+o0JO+cRKd4i36UZg=;
 b=QVCwJ4ak1VC297JXol4Hd0q9Z6W+Zu9632i1l0QgGieY4mdaQzXk0s0t
 Qd6GHuitMK/+To7finlLqHbQ1MqFBqgLfwFS3iX0dWQrpoLE+u9aw0Vdd
 3i/3QUm+y9ZEmHEqdX08JZyIUPeu14uj2Rb6QO6ADgcWYhXk/Ut0eBu+A
 Hdtkccp3axFBui7Oglw+pCe3Y4lgaR5MVQjhHsWsTpBKWxU5+AQUQPp76
 Cf4HaVfjB9W54NLbNNi0yMKMxVHds/FhVCXPag2oaPuhPdlbxkw2jzV1J
 kzCDcT8TDjjCaO6K6U5GfkzrCKTG/ejrnhZ95NiW7FKXGframLrT2FIdM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365999440"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="365999440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759733290"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; d="scan'208";a="759733290"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 02:20:19 -0700
Date: Tue, 17 Oct 2023 12:20:17 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ma Jun <Jun.Ma2@amd.com>
Subject: Re: [PATCH v12 1/9] Documentation/driver-api: Add document about
 WBRF mechanism
In-Reply-To: <20231017025358.1773598-2-Jun.Ma2@amd.com>
Message-ID: <f3c89e85-a683-eedf-9c3-ed54173bc12@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-2-Jun.Ma2@amd.com>
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
 edumazet@google.com, mario.limonciello@amd.com, alexander.deucher@amd.com,
 kuba@kernel.org, johannes@sipsolutions.net, pabeni@redhat.com,
 davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 17 Oct 2023, Ma Jun wrote:

> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
> new file mode 100644
> index 000000000000..8561840263b3
> --- /dev/null
> +++ b/Documentation/driver-api/wbrf.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================================
> +WBRF - Wifi Band RFI Mitigations
> +=================================
> +Due to electrical and mechanical constraints in certain platform designs

Add empty line before starting the content of a section.

> +there may be likely interference of relatively high-powered harmonics of
> +the GPU memory clocks with local radio module frequency bands used by
> +certain Wifi bands.
> +
> +To mitigate possible RFI interference producers can advertise the
> +frequencies in use and consumers can use this information to avoid using
> +these frequencies for sensitive features.
> +
> +When a platform is known to have this issue with any contained devices,
> +the platform designer will advertise the availability of this feature via
> +ACPI devices with a device specific method (_DSM).
> +* Producers with this _DSM will be able to advertise the frequencies in use.
> +* Consumers with this _DSM will be able to register for notifications of
> +frequencies in use.
> +
> +Some general terms
> +==================
> +Producer: such component who can produce high-powered radio frequency
> +Consumer: such component who can adjust its in-use frequency in
> +           response to the radio frequencies of other components to
> +           mitigate the possible RFI.
> +
> +To make the mechanism function, those producers should notify active use
> +of their particular frequencies so that other consumers can make relative
> +internal adjustments as necessary to avoid this resonance.
> +
> +ACPI interface
> +==============
> +Although initially used by for wifi + dGPU use cases, the ACPI interface
> +can be scaled to any type of device that a platform designer discovers
> +can cause interference.
> +
> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
> +
> +3 functions are available in this _DSM:
> +
> +* 0: discover # of functions available
> +* 1: record RF bands in use
> +* 2: retrieve RF bands in use
> +
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============
> +The expected flow for the producers:
> +1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +can be enabled for the device.
> +2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +param to get other consumers properly notified.
> +3) Or on stopping using some frequency band, call
> +`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +can be enabled for the device.
> +2) Call `amd_wbrf_register_notifier` to register for notification
> +of frequency band change(add or remove) from other producers.
> +3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +current active frequency bands considering some producers may broadcast
> +such information before the consumer is up.
> +4) On receiving a notification for frequency band change, run
> +`amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +active frequency bands.
> +5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +unregister the notifier.

Align these so that only the numbers start from first column. I think the 
proper markup for numbered lists is 1. not 1).


-- 
 i.

