Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE94C63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6A520719
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Lvt0xf0A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="qZT/78tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6A520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530B989CAF;
	Mon, 23 Nov 2020 08:26:10 +0000 (UTC)
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [96.44.175.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA1D8996F;
 Sat, 21 Nov 2020 17:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2C7E2128048D;
 Sat, 21 Nov 2020 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1605979140;
 bh=oKjwoQQYqAGHYIcGa87tH3kfRh6eNDZ11DRWs/5n6Nc=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=Lvt0xf0A2UjzBqGR2epCNoE7DN6YV9pUrVXD+f22BVAeiOW2KxZsGCImkMcXBrgh/
 zD0zBdigF+USoIPaRfSUxU4T/o3yBTwQz1ZuRUKYioWvma2ORezv7XJ+/UVZk14HDg
 znn3A0Y1A4QkkRvYDhfOKnhgBoH92sfIP7bAjSz4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id dA_Y3gfv-HlR; Sat, 21 Nov 2020 09:19:00 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown
 [IPv6:2601:600:8280:66d1::527])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 584A71280481;
 Sat, 21 Nov 2020 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=hansenpartnership.com; s=20151216; t=1605979139;
 bh=oKjwoQQYqAGHYIcGa87tH3kfRh6eNDZ11DRWs/5n6Nc=;
 h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
 b=qZT/78tSZnguNV1yoYzSSmvqmDGgzNIuIpg2PbOws0zqwE5yu2CoK/DoUP3fxAE7/
 cwr3zThASX8R91ADl4Ew6X2dNx0rQAVJjUjWHCFXFVZg8s5iaP8BFiZuwsxl12vuws
 rCw1QQ3k1zT/j95+Y6p1vgihiOvqC5dVUCKPWDl0=
Message-ID: <5843ef910b0e86c00d9c0143dec20f93823b016b.camel@HansenPartnership.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: trix@redhat.com, joe@perches.com, clang-built-linux@googlegroups.com
Date: Sat, 21 Nov 2020 09:18:57 -0800
In-Reply-To: <20201121165058.1644182-1-trix@redhat.com>
References: <20201121165058.1644182-1-trix@redhat.com>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 08:25:57 +0000
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
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-scsi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 cluster-devel@redhat.com, linux-acpi@vger.kernel.org,
 tboot-devel@lists.sourceforge.net, coreteam@netfilter.org,
 xen-devel@lists.xenproject.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-media@vger.kernel.org, alsa-devel@alsa-project.org,
 intel-gfx@lists.freedesktop.org, ecryptfs@vger.kernel.org,
 linux-omap@vger.kernel.org, devel@acpica.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, patches@opensource.cirrus.com,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
> A difficult part of automating commits is composing the subsystem
> preamble in the commit log.  For the ongoing effort of a fixer
> producing
> one or two fixes a release the use of 'treewide:' does not seem
> appropriate.
> 
> It would be better if the normal prefix was used.  Unfortunately
> normal is
> not consistent across the tree.
> 
> 
> 	D: Commit subsystem prefix
> 
> ex/ for FPGA DFL DRIVERS
> 
> 	D: fpga: dfl:
> 

I've got to bet this is going to cause more issues than it solves. 
SCSI uses scsi: <driver>: for drivers but not every driver has a
MAINTAINERS entry.  We use either scsi: or scsi: core: for mid layer
things, but we're not consistent.  Block uses blk-<something>: for all
of it's stuff but almost no <somtehing>s have a MAINTAINERS entry.  So
the next thing you're going to cause is an explosion of suggested
MAINTAINERs entries.

Has anyone actually complained about treewide:?

James


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
