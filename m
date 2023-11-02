Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BED2C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 13:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1610E87D;
	Thu,  2 Nov 2023 13:05:31 +0000 (UTC)
X-Greylist: delayed 1796 seconds by postgrey-1.36 at gabe;
 Thu, 02 Nov 2023 12:34:55 UTC
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F8A10E07C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=HntS3je0QXLdwZ1+s0cY5G8BrYYXr4+VZLC8JT4/rII=; 
 t=1698928494; x=1700138094; b=TVZUW4fjIVt98eAGKhj5E91eN4tXapy+eHw2lBTF6y0+a+W
 CHtg8RW7dnm+Ke1yp5ynlRoBBCjZrHKKyvZ8N4FfhoS5jVDzn3AWVvNKogYv5/3ykgW2tFpgDBeKY
 I7dbHP9NaZZZXUIB+o1B1kQtObIFLLMpELCQZGG61TmDvGLe5jhhVyBR7Cgxp3FEOndo3nriRyXGG
 kvF6Ykr7Lxs6ZMY9Le8yjw4SMGereWnwvgvZ0sYnPTR+HY3WaoYl47QOohbK1u7nwkTaaOlxf0GpZ
 MoBu5TgWOQyQTRATJWHmEyChOWerTLLPlA8uvPPod9Jqlrgrl+04LkUI74f3gyzA==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97-RC1) (envelope-from <johannes@sipsolutions.net>)
 id 1qyWRS-0000000BHyX-0ieC; Thu, 02 Nov 2023 13:04:54 +0100
Message-ID: <b080757463a1f55a38484e3ea39fd3697e98409e.camel@sipsolutions.net>
Subject: Re: [Patch v13 4/9] wifi: mac80211: Add support for WBRF features
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Ma Jun
 <Jun.Ma2@amd.com>
Date: Thu, 02 Nov 2023 13:04:52 +0100
In-Reply-To: <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
 <20231030071832.2217118-5-Jun.Ma2@amd.com>
 <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Approved-At: Thu, 02 Nov 2023 13:05:30 +0000
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
Cc: Evan Quan <quanliangl@hotmail.com>, linux-doc@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, Lijo.Lazar@amd.com,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 edumazet@google.com, mario.limonciello@amd.com, alexander.deucher@amd.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2023-11-02 at 13:55 +0200, Ilpo J=C3=A4rvinen wrote:


[please trim your quotes]

> > +static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth, u64=
 *start, u64 *end)
> > +{
> > +	bandwidth =3D MHZ_TO_KHZ(bandwidth);
> > +	center_freq =3D MHZ_TO_KHZ(center_freq);
>=20
> Please use include/linux/units.h ones for these too.

Now we're feature creeping though - this has existed for *years* in the
wireless stack with many instances? We can convert them over, I guess,
but not sure that makes much sense here - we'd want to add such macros
to units.h, but ... moving them can be independent of this patch?

johannes
