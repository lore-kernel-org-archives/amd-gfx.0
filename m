Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507B8EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jul 2023 07:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B6D10E160;
	Mon,  3 Jul 2023 07:47:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D2D10E19C;
 Sat,  1 Jul 2023 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=sJ3VBkhz2c2rPWZ1lo+kvWg61crR7igZ2KfZF/vTU3M=; b=hWUmCAf+ZSjXyHVc7Tv8TU081e
 BJPW5N614euvKV42ljLmBc1WmvJIP9OpqQ8r53Rj+5M58wGSN7/Grj647zMFVXj3Mukb3FGQZXhIc
 6g3bbLmT8F1ykTP1Z5//BS6Ql+QqhtOihJ1DeHvpMOFfXCvo1zqT972VyRmj43qFcYDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qFP0C-000LTo-Pp; Sat, 01 Jul 2023 03:02:16 +0200
Date: Sat, 1 Jul 2023 03:02:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Evan Quan <evan.quan@amd.com>
Subject: Re: [PATCH V5 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <3868dbae-79e5-470d-a144-0884659206d9@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-5-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-5-evan.quan@amd.com>
X-Mailman-Approved-At: Mon, 03 Jul 2023 07:47:15 +0000
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
Cc: jingyuwang_vip@163.com, bellosilicio@gmail.com, rafael@kernel.org,
 trix@redhat.com, Lijo.Lazar@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mdaenzer@redhat.com, Mario.Limonciello@amd.com,
 airlied@gmail.com, amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, lenb@kernel.org, andrealmeid@igalia.com,
 daniel@ffwll.ch, arnd@arndb.de, maarten.lankhorst@linux.intel.com,
 hdegoede@redhat.com, jsg@jsg.id.au, jim.cromie@gmail.com,
 netdev@vger.kernel.org, Xinhui.Pan@amd.com, linux-wireless@vger.kernel.org,
 edumazet@google.com, Christian.Koenig@amd.com, tzimmermann@suse.de,
 Alexander.Deucher@amd.com, johannes@sipsolutions.net, davem@davemloft.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> +static void get_chan_freq_boundary(u32 center_freq,
> +				   u32 bandwidth,
> +				   u64 *start,
> +				   u64 *end)
> +{
> +	bandwidth = MHZ_TO_KHZ(bandwidth);
> +	center_freq = MHZ_TO_KHZ(center_freq);
> +
> +	*start = center_freq - bandwidth / 2;
> +	*end = center_freq + bandwidth / 2;
> +
> +	/* Frequency in HZ is expected */
> +	*start = KHZ_TO_HZ(*start);
> +	*end = KHZ_TO_HZ(*end);
> +}

This seems pretty generic, so maybe it should be moved into the shared
code? It can then become a NOP when the functionality if disabled.

      Andrew

