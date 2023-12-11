Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CA5C10F05
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 13:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2C210E425;
	Mon, 11 Dec 2023 13:57:14 +0000 (UTC)
X-Greylist: delayed 1840 seconds by postgrey-1.36 at gabe;
 Mon, 11 Dec 2023 12:12:27 UTC
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1030F10E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 12:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=tWsLt7SLpCw5MQDNBJrqaEYgF2X1wOT/u6YZ+/q7Ies=; 
 t=1702296746; x=1703506346; b=DrxAAbzPHONlSP1oTTTe/OUMvx7TUZKQxnWevqO5lHk4xbg
 Uh5LpeR5nYBJlXGSsb2XtzZjRxTOSDyFls29/Ri5aHfl8cfi++PcnVw5dqNzBsWe+ZsIfPN49KpMs
 uvYJsYk6RWakvb/1vSllTU5adLob0f5dopxM92R30ETnoN65hwFJNE4sqpA4WklMbgYg29sxJ1PFv
 PN8n8f+Fzg0bJWEmdZPjPHS/G2pr+W5tfEhfmcSCghD1qTY+px0aq5oFJsna7fD0prrczLGV6Mao0
 bcbgCsZ9Xh10HUSnl/aZBazIQvgS8VXRJecNrqUew+W4VKWHCQvqd+IDobJUZpBA==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97) (envelope-from <johannes@sipsolutions.net>)
 id 1rCefQ-00000006k4P-0UCC; Mon, 11 Dec 2023 12:41:44 +0100
Message-ID: <5e14be1fc61d9d7027cd50f4148eea52e40fb9d3.camel@sipsolutions.net>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
From: Johannes Berg <johannes@sipsolutions.net>
To: Hans de Goede <hdegoede@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>
Date: Mon, 11 Dec 2023 12:41:42 +0100
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Approved-At: Mon, 11 Dec 2023 13:57:12 +0000
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
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

> Here is a pull-request for the platform-drivers-x86 parts of:
>=20
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.=
Ma2@amd.com/
>=20
> From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbr=
f-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu=
 driver changes on top.
>=20
> This only adds kernel internal API, so if in the future the API needs wor=
k that can be done.

I've been fine with the wifi bits since around v3 of the patchset ;-)

So the idea is that I'll pull this into wireless-next and then apply the
two wireless patches on top, right?

AFAICT, since the other patches don't depend on wireless for
compilation, this is the only thing I need to do, i.e. no need to have
another separate branch to send it further on, right?

johannes

