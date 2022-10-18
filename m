Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8FDC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 06:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E01410EE96;
	Tue, 18 Oct 2022 06:37:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F85E10EE2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 05:20:47 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB00F6143A;
 Tue, 18 Oct 2022 05:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACC6C433C1;
 Tue, 18 Oct 2022 05:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1666070446;
 bh=kwWBH/nif8QxqkwcKqTC4kftjp46RnJBMj8AFMegplE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h2PIPZel+KW3LmhVvdMuYlExIgpTS2yTEJs1kO+vX/zQmUc1IQj/NxpDsTG4282P1
 iS+Vhr6sAKuihAdoQB0x2hDCmwXeCOKdGN+5uuE4+LE5ocgl7QfmdjvTWyupHhVy7A
 +K2ueq/IPIZO5g4UZ8Q6aIuz6RjvE7deY0krGizc=
Date: Tue, 18 Oct 2022 07:21:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Remove ATC L2 access for MMHUB 2.1.x
Message-ID: <Y0433bWlP9OE/Hm1@kroah.com>
References: <20221018044724.86179-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018044724.86179-1-lijo.lazar@amd.com>
X-Mailman-Approved-At: Tue, 18 Oct 2022 06:37:09 +0000
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
Cc: Guchun.Chen@amd.com, stable@vger.kernel.org, helgaas@kernel.org,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 18, 2022 at 10:17:24AM +0530, Lijo Lazar wrote:
> MMHUB 2.1.x versions don't have ATCL2. Remove accesses to ATCL2 registers.
> 
> Since they are non-existing registers, read access will cause a
> 'Completer Abort' and gets reported when AER is enabled with the below patch.
> Tagging with the patch so that this is backported along with it.
> 
> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 28 +++++++------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
