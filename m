Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E6C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 14:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE1510E487;
	Thu,  4 Jan 2024 14:05:52 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2E710E479
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 13:58:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 7C8BDB81730;
 Thu,  4 Jan 2024 13:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C70CC433C7;
 Thu,  4 Jan 2024 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1704376725;
 bh=kUAhvV5Rtj8FmvIgEpCZ+OIBaqt3tBUq1CbPUeHc7LY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nw2yu0ISm0HwuyuchMlVcDXZbbROdxImitr94F0THRNKy10y2t/TgjWzFz7lh4rKg
 wu0M6Zj9xbh4dTzzj2NwEWU22QLndFBKEMmxjnRB2GbDBs0bmYvsYmzKWLWSOMaSY5
 X8zDiJI+VPc3/xHniZepE7pggBPYsYvv9zEo4hfw=
Date: Thu, 4 Jan 2024 14:58:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
Message-ID: <2024010434-arbitrary-muzzle-9058@gregkh>
References: <20240101182836.817565-1-joshua@froggi.es>
 <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
 <aa5dee62-cec8-464c-aeac-38fdac0a4a80@froggi.es>
 <fbed675b-7f82-4f33-a9fe-1947425a649a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbed675b-7f82-4f33-a9fe-1947425a649a@amd.com>
X-Mailman-Approved-At: Thu, 04 Jan 2024 14:05:51 +0000
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
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>, stable@vger.kernel.org, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 04, 2024 at 08:54:19AM -0500, Hamza Mahfooz wrote:
> On 1/3/24 14:17, Joshua Ashton wrote:
> > Thanks! Is it possible for us to get this backported too?
> 
> Sure thing.
> 
> Cc: stable@vger.kernel.org

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
