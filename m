Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4465BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB1E10F129;
	Fri, 18 Feb 2022 15:25:58 +0000 (UTC)
X-Greylist: delayed 2460 seconds by postgrey-1.36 at gabe;
 Fri, 18 Feb 2022 13:07:53 UTC
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD05010EE83
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=MVaFoxpSrw0lXOFRf60il59+xXDuimORkK161w41iNc=; 
 t=1645189673; x=1646399273; b=KUYRYSXHnUMCCoRsbEm+I7s1mHvWL+cJrX2Z46vce5RPJ7X
 7a8ll+QmXcnogHt1fcbhL98mpr60zNUwiSbq4WNjM44cSx3+zSL6LJ1VaeRt1me/l9FlLxfuvSCZ+
 pRCu0YpflLdMNQ+nk/pomgw6jXTN80QNzQiOC2RNilcqyM2EPw0//3jls7GnjVaGgVGkG0nrgT6z7
 60U+FXdY0SbTLMD1TsvoO3IZ7+G4OVpDZG0QQCjM4S47nGxDkDXmgc3Sxb3V9ireRq7k+vNZa5+ZR
 hfBzGZNVP86VlSkyYRiDD+UFF4rQKYF+9x49ogXiBjhcLfv42/PYoNoWiXpd6gAQ==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) (envelope-from <johannes@sipsolutions.net>)
 id 1nL2LH-002du1-NQ; Fri, 18 Feb 2022 13:26:31 +0100
Message-ID: <ac4c5f8c890e5bdd7ad7ecc04a51e72fa3ac1703.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>,  Randy Dunlap
 <rdunlap@infradead.org>
Date: Fri, 18 Feb 2022 13:26:30 +0100
In-Reply-To: <20220218075727.2737623-5-davidgow@google.com>
References: <20220218075727.2737623-1-davidgow@google.com>
 <20220218075727.2737623-5-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Mailman-Approved-At: Fri, 18 Feb 2022 15:25:33 +0000
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
Cc: linux-rdma@vger.kernel.org, felix.kuehling@amd.com, x86@kernel.org,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 2022-02-18 at 15:57 +0800, David Gow wrote:
> 
> Note that, while this does build again, it still segfaults on startup,
> so more work remains to be done.

That's probably just a lot more stuff getting included somehow?

> They are:
> - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache
> - CONFIG_BNXT: Failing under UML with -Werror
> ERROR:root:../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function ‘bnxt_ptp_enable’:
> ../drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:400:43: error: array subscript 255 is above array bounds of ‘struct pps_pin[4]’ [-Werror=array-bounds]
>   400 |                         ptp->pps_info.pins[pin_id].event = BNXT_PPS_EVENT_EXTERNAL;
>       |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~
> - CONFIG_PATA_CS5535: Needs MSR access (__tracepoint_{read,write}_msr)
> - CONFIG_VDPA: Enables CONFIG_DMA_OPS, which is unimplemented. ('dma_ops' is not defined)
> 
> These are all issues which should be investigated properly and the
> corresponding options either fixed or disabled under UML. Having this
> list of broken options should act as a good to-do list here, and will
> allow these issues to be worked on independently, and other tests to
> work in the meantime.
> 

I'm not really sure it makes sense to even do anything other than
disabling these.

It looks like all of them are just exposed by now being able to build
PCI drivers on UML. Surely the people writing the driver didn't expect
their drivers to run over simulated PCI (which is what the UML PCI
support is all about).

Now from a PCI driver point of view you can't really tell the difference
(and anyway the driver won't be probed), but the issues (at least the
build time ones) come from having

    UML && PCI && X86_64

or

    UML && PCI && X86_32

because drivers typically depend on X86_64 or X86_32, rather than on
"X86 && X86_64" or "X86 && X86_32". In a sense thus, the issue is those
drivers don't know that "!X86 && (X86_32 || X86_64)" can happen (with
UML).


Now you could say that's the driver bug, or you could say that they
should just add "depends on !UML" (though that's basically equivalent to
adding "depends on X86" and the latter may be preferable in some cases).

Or actually in the three patches you have (1-3) it's in the code, but
same thing, you can either add && !UML (like you did) or add && X86.


Arguably, however, building PCI drivers by default is somewhat
questionable in the first place?

So maybe you should just add

    # CONFIG_UML_PCI_OVER_VIRTIO is not set

to the broken_on_uml.config since it exposes all these issues, and
really is not very useful since you're not going to actually run with
any simulated PCI devices anyway, so drivers will not be probed.

johannes
