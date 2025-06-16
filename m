Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5943FC7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFFA10E674;
	Tue, 17 Jun 2025 13:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="SvqyFL5h";
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA6510E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=ImzOJ0Fu7HUWP5Tk98CrEZQ+23QR5aPJDRY8eqZP6s8=; b=SvqyFL5hLq5vK8nQbihAXrkG0G
 hw3+hd/uF1wbC3Yj1e5Zo7ByN+JQTEazFGwTVRGmiAmxCamg2J8mUxLqMC9bn6yfGu3H5UfRPhwtj
 rkVuK3WqM5EEYF/EoVXWs+sS/+i7WjyMX7BjJaaz+m5G3tVceT8LLAMVB+qoCiy/7KdZqRcaEEC3W
 t07vMuQ8Tu3KDNFe+2xXhnERpnb7Z7D8hYXqiwYRJaJ0CS6pFEDHlXd23KAfG+3i4hasHl1K7vHI3
 M9hg5KGCxZP4vMJCeKFZPAue8AGPbyb8b6Vcn9jCqh3+HNJW+8J/ClnXXu1C1KdG8G22Z1wqSrix+
 c3c9Pftw==;
Received: from
 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1uRBEM-00000003cMr-2pmi; Mon, 16 Jun 2025 14:54:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5847430D551; Mon, 16 Jun 2025 16:54:37 +0200 (CEST)
Date: Mon, 16 Jun 2025 16:54:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu vs kexec
Message-ID: <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
X-Mailman-Approved-At: Tue, 17 Jun 2025 13:02:38 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 16, 2025 at 01:51:21PM +0200, Christian König wrote:
> Hi Peter,
> 
> On 6/16/25 11:39, Peter Zijlstra wrote:
> > Hi guys,
> > 
> > My (Intel Sapphire Rapids) workstation has a RX 7800 XT and when I kexec
> > a bunch of times, the amdgpu driver gets upset and barfs on boot.
> 
> yeah, that is an "intentional" HW feature and yes you're certainly not
> the first one to complain about it :(
> 
> The PSP (platform security processor IIRC) is designed in such a way
> that you can initialize it only once after a power cycle / hard reset
> for security reasons (e.g. to not leak crypto keys used for digital
> rights management etc..).
> 
> On dGPUs we work around that manually by power cycling the ASIC when
> that situation is detected during amdgpu load, but that unfortunately
> doesn't work 100% reliable.

Right.. hence the splats.

> On APUs the situation is even worse because the PSP is shared between
> the GPU and the CPU.
> 
> We have forwarded such complains internally for years, but there is
> not much else Alex and I can do about it.

Oh well. Thanks for the info!
