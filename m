Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A26ECAA24
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 18:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D56E10E892;
	Thu, 25 Aug 2022 18:01:43 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA3610E892
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 18:01:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8A67AB82A39;
 Thu, 25 Aug 2022 18:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0544CC433C1;
 Thu, 25 Aug 2022 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661450497;
 bh=/WZmsRVsON/vsGFfP03HHcMBKxdg89DXWzff7UBOQ/0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=BuSbYwNwEXch9Og+n8UYevb/qLLUOyWljdvh+xAXTVlBhPe/4fq1KOYeuxjcrXI/h
 xQsLhzYAb0o8Vl7krCWvwxG2BXwEb/n+1fzwXWm7r3wP1v7h7Z93j7Xmn3+irrfOFr
 OnT6Jjc2HMJyww+9cQ+zJqI7WFTg1u9YPaXaTW8ICQDtIdq0K9eebcjw/72NjHj+0b
 eBwzG5SVxanViTxcxiXfw5wx/g2sYoqtMXHNp29qacR6n00LVqGYUFAhDpSoXxWHd1
 cPbwV25t2WUphj58jckGYdlx7U3i9or6jq5dKgWJM+RfzY6mSmFOYcGquIF26gsGsj
 M++QmssP4AoWw==
Date: Thu, 25 Aug 2022 13:01:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Move HDP remapping earlier during init
Message-ID: <20220825180134.GA2857782@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825085820.1228641-1-lijo.lazar@amd.com>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, tseewald@gmail.com, Alexander.Deucher@amd.com,
 sr@denx.de, Christian.Koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[+cc Greg, no action needed yet, just FYI that stable will want these]

On Thu, Aug 25, 2022 at 02:28:19PM +0530, Lijo Lazar wrote:
> HDP flush is used early in the init sequence as part of memory controller
> block initialization. Hence remapping of HDP registers needed for flush
> needs to happen earlier.
> 
> This also fixes the AER error reported as Unsupported Request during
> driver load.

I would say something like:

  This prevents writes to unimplemented space, which would cause
  Unsupported Request errors.  Prior to 8795e182b02d ("PCI/portdrv:
  Don't disable AER reporting in get_port_device_capability()"), these
  errors occurred but were ignored.

The write is the error; AER is just the reporting mechanism.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373

We need a cc: stable because 8795e182b02d ("PCI/portdrv: Don't disable
AER reporting in get_port_device_capability()") has already been
backported to at lealst these stable kernels:

  5.10.137 5.15.61 5.18.18 5.19.2

and these fixes need to go there as well.  So add something like this:

  Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
  cc: stable@vger.kernel.org

It's not that there was something wrong with 8795e182b02d and these
patches fix it; it's just that 8795e182b02d *exposed* an amdgpu
problem that was there all along.  But we need some way to connect
with it.

> Reported-by: Tom Seewald <tseewald@gmail.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
