Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5E1FD2D88
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE24610E6F5;
	Tue, 10 Mar 2026 13:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gbboZny9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BB610E6D7;
 Tue, 10 Mar 2026 13:34:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBB2D60054;
 Tue, 10 Mar 2026 13:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1338AC19423;
 Tue, 10 Mar 2026 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773149641;
 bh=1YnmztTcNk3Ff+PgeiUurE/Sk941AjWRBcXze9NtmZ0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gbboZny9vDD72Pka+n0iXs0baByjKbSZoFC4cppvyGvi6DURLPzP7/PURy6H4x0SE
 hZcTDQvWtiIR96dUWEkTSxfg7YW1/icauTRQtPPhn3DjatNJnXXgx9ePr2EFS/J1xE
 m2MZHJen8/8vAxVjX4Rh0mvAwOneBCTEICPjlkx0jZOCBN/iedVV5+9QBqwIzFk1vO
 tVOWY5YqoR5nPBwka2P8esnXtwU65aqvGrom7R8xo/zbp7HcZsAU1Ct1Z6jDsVgPm9
 q6q+cosYNG9tKwHqU9XoTXUFgoVy3XzQYbAwRSYwrOvATdzUAyZiFt5O4W3gYPYlF6
 gVdqFVkFvSybA==
From: Lee Jones <lee@kernel.org>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
Subject: Re: (subset) [PATCH 51/61] leds: Prefer IS_ERR_OR_NULL over manual
 NULL check
Message-Id: <177314963081.2226692.3105447886678957300.b4-ty@kernel.org>
Date: Tue, 10 Mar 2026 13:33:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38
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

On Tue, 10 Mar 2026 12:49:17 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> 

Applied, thanks!

[51/61] leds: Prefer IS_ERR_OR_NULL over manual NULL check
        commit: e68f95a51d1a8c1594b536c4d495cbea38d47561

--
Lee Jones [李琼斯]

