Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17FBC0018A
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 13:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6129110E884;
	Thu,  2 Nov 2023 13:05:35 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176D210E87A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=lhnHvgPTUerCavcKvy4VoFNn9k17Ymmjx4Tbd3bshik=; 
 t=1698930286; x=1700139886; b=VufvgQTN2x+ccuWQJSzLjrK9rDx0J5+TMJajhEpNClRZj33
 VK8Xs8YfOizK/DFJWLv8bfZyXc/g9MMY2AHTOtYDNC5/z7iPCHHNWgE2dnrDIL+TcbyXUhEFpaJq1
 Wy/3LIc8lT51zbb+SDc68nJvL5tK1AMRYiHB1c7fcyO72IoD6FpxVvVVqJq0nfLrPQ/mwDKTlpo7R
 0i4Zd/kS9Q+U+GWeiNxIJnGeHMgUSR1Jfzb3TFM0zE7OcdvqQQ5cpSi8E6AzIKKrOn8G56/vt3tKY
 kj+mX9bwVe+f4QgpydGRyRniVQWYD8fsI9hB1g2gU1Ohf0W6IH82hu2RDwbM7y+w==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97-RC1) (envelope-from <johannes@sipsolutions.net>)
 id 1qyXNL-0000000BJWz-3w9i; Thu, 02 Nov 2023 14:04:44 +0100
Message-ID: <d0d35561b80b873d9f78c9ca4ad304b6e0f16cb2.camel@sipsolutions.net>
Subject: Re: [Patch v13 4/9] wifi: mac80211: Add support for WBRF features
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 02 Nov 2023 14:04:42 +0100
In-Reply-To: <e42c5484-d66-e41a-8b2e-a1fa4495ce2@linux.intel.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
 <20231030071832.2217118-5-Jun.Ma2@amd.com>
 <5b8ea81c-dd4c-7f2a-c862-b9a0aab16044@linux.intel.com>
 <b080757463a1f55a38484e3ea39fd3697e98409e.camel@sipsolutions.net>
 <e42c5484-d66-e41a-8b2e-a1fa4495ce2@linux.intel.com>
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
 Ma Jun <Jun.Ma2@amd.com>, edumazet@google.com, mario.limonciello@amd.com,
 alexander.deucher@amd.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2023-11-02 at 14:24 +0200, Ilpo J=C3=A4rvinen wrote:
> On Thu, 2 Nov 2023, Johannes Berg wrote:
> > On Thu, 2023-11-02 at 13:55 +0200, Ilpo J=C3=A4rvinen wrote:
> >=20
> > > > +static void get_chan_freq_boundary(u32 center_freq, u32 bandwidth,=
 u64 *start, u64 *end)
> > > > +{
> > > > +	bandwidth =3D MHZ_TO_KHZ(bandwidth);
> > > > +	center_freq =3D MHZ_TO_KHZ(center_freq);
> > >=20
> > > Please use include/linux/units.h ones for these too.
> >=20
> > Now we're feature creeping though - this has existed for *years* in the
> > wireless stack with many instances? We can convert them over, I guess,
> > but not sure that makes much sense here - we'd want to add such macros
> > to units.h, but ... moving them can be independent of this patch?
>=20
> What new macros you're talking about?=C2=A0

Sorry, I got confused - for some reason I was pretty sure something here
was already being added to units.h in this patchset.

> Nothing new needs to be added=20
> as there's already KHZ_PER_MHZ so these would just be:
>=20
> 	bandwidth *=3D KHZ_PER_MHZ;
> 	center_freq *=3D KHZ_PER_MHZ;

Sure, and in this case that's probably pretty much equivalent. But
having a MHZ_TO_KHZ() macro isn't inherently *bad*, and I'm not sure
you're objection to it on anything other than "it's not defined in
units.h".

> Everything can of course be postponed by the argument that some=20
> subsystem specific mechanism has been there before the generic one
> but the end of that road won't be pretty... What I was trying to do
> here was to point out the new stuff introduced by this series into the=
=20
> direction of the generic thing.

I just think that the better course of action would be to eventually
move MHZ_TO_KHZ() to units.h ...

johannes
