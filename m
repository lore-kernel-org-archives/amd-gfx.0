Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1DECCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95B810E92F;
	Thu, 23 Oct 2025 16:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s5Rxndot";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40AB10E92F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:20:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B13C640E7;
 Thu, 23 Oct 2025 16:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A027CC4CEE7;
 Thu, 23 Oct 2025 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761236415;
 bh=rRPDDXxNpsWlZ6/Xjt6nPcJS/JvZvNDmte8DVh1GIvg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=s5Rxndotd91+OAFCcZhGqu1lY5rUnkFxNKucSqq4WuNhK3rpyPqeuzE5OwF13gcyc
 LoswyTZmm+7DMUlv995vPADCezgnnplo2jWh+EdTNzXuxQUVJTVG6pIwJo7TUKsTBr
 VEyvjGerJHGwi6Tkl0ayW7won58v7CJQa4nLuqYZkEHKjY1X6FrOU8fbvqwvn4oxuO
 qU0xu3PgqfPguW33xkb53+28EBeD2uxtDQZFGfVOQfH2gjCken0/JFQiUAEtie++p/
 QQ4ituhjaz26LIrLGCtIrVG0BdLZkDVeebw3zHt9BIaNOkeAnMWA3vlhpRyehIcoGd
 jSeIYBpCmtyBg==
Date: Thu, 23 Oct 2025 11:20:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-pci@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 regressions@lists.linux.dev
Subject: Re: 2499f53 (PCI: Rework optional resource handling) regression with
 AMDGPU on Arm AVA platform
Message-ID: <20251023162014.GA1298313@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874irqop6b.fsf@draig.linaro.org>
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

On Wed, Oct 22, 2025 at 05:51:24PM +0100, Alex Bennée wrote:
> I've been tracking a regression on my Arm64 (Altra) AVA platform between
> 6.14 and 6.15. It looks like the rework commit broke the ability of the
> amdgpu driver to resize it's bar, resulting in an SError and failure to
> boot:
> ...

#regzbot ^introduced: 2499f5348431 ("PCI: Rework optional resource handling")
#regzbot title: arm64 SError panic with amdgpu BAR resize
