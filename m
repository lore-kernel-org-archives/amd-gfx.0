Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1DFEE4993
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 13:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BEC10E23E;
	Mon, 21 Aug 2023 13:00:30 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E48E10E073
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=d9AC3Y3wKvLhTCxarPAnq2BCxnL4Toqn/q0Gu3hZcq0=; 
 t=1692611085; x=1693820685; b=PHHWbJh82RK0a3pzp1LHYbjE+eXDAZlD3fvUkfOe8gN/POe
 iV0OIgcmNvti0+PXN9pYSiknYguWDSyr5/973N7BL7ArkTModSl7U9ZUVYjCZ6DoNUpplsHGQFshM
 EtzY4a1kAW8C538Gz2Axyueg2+ie9KtFATN1s9QHl8rPovn0E93G1k9yj6sOjQaptqvrfOafPFNcL
 rfl9F1WiYR6SASG4fDlvzXYb73jOeOKeO+m8H4TizA5kL70BtZ+X/FgMtI1enhBg4zk2g4FQf6HV3
 zNS93HoN0ZY2AdK2Iq9waRYzvoGblIA5mhmQ5cSNDq3k2PMOszdCIGFAxUXTCJlg==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <johannes@sipsolutions.net>)
 id 1qY1SZ-002xnF-2J; Mon, 21 Aug 2023 11:44:31 +0200
Message-ID: <e167e97797a90d3d6ea09840ac909325537d6034.camel@sipsolutions.net>
Subject: Re: [V9 4/9] wifi: mac80211: Add support for WBRF features
From: Johannes Berg <johannes@sipsolutions.net>
To: Evan Quan <evan.quan@amd.com>, gregkh@linuxfoundation.org, 
 rafael@kernel.org, lenb@kernel.org, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com,
 alexander.deucher@amd.com, andrew@lunn.ch,  rdunlap@infradead.org,
 quic_jjohnson@quicinc.com, horms@kernel.org
Date: Mon, 21 Aug 2023 11:44:29 +0200
In-Reply-To: <20230818032619.3341234-5-evan.quan@amd.com>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-5-evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Approved-At: Mon, 21 Aug 2023 13:00:28 +0000
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
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 2023-08-18 at 11:26 +0800, Evan Quan wrote:
> To support the WBRF mechanism, Wifi adapters utilized in the system must
> register the frequencies in use(or unregister those frequencies no longer
> used) via the dedicated calls. So that, other drivers responding to the
> frequencies can take proper actions to mitigate possible interference.
>=20
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

From WiFi POV, this looks _almost_ fine to me.

> +static void wbrf_get_ranges_from_chandef(struct cfg80211_chan_def *chand=
ef,
> +					 struct wbrf_ranges_in *ranges_in)
> +{
> +	u64 start_freq1, end_freq1;
> +	u64 start_freq2, end_freq2;
> +	int bandwidth;
> +
> +	bandwidth =3D nl80211_chan_width_to_mhz(chandef->width);
> +
> +	get_chan_freq_boundary(chandef->center_freq1,
> +			       bandwidth,
> +			       &start_freq1,
> +			       &end_freq1);
> +
> +	ranges_in->band_list[0].start =3D start_freq1;
> +	ranges_in->band_list[0].end =3D end_freq1;
> +
> +	if (chandef->width =3D=3D NL80211_CHAN_WIDTH_80P80) {
> +		get_chan_freq_boundary(chandef->center_freq2,
> +				       bandwidth,
> +				       &start_freq2,
> +				       &end_freq2);
> +
> +		ranges_in->band_list[1].start =3D start_freq2;
> +		ranges_in->band_list[1].end =3D end_freq2;
> +	}
> +}

This has to setup ranges_in->num_of_ranges, no?
(Also no real good reason for num_of_ranges to be a u64, btw, since it
can only go up to 11)

With that fixed, you can add

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

