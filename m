Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18ADE77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7EB110ED09;
	Thu, 19 Dec 2024 14:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b="vpc/hr+s";
	dkim-atps=neutral
Received: from mail.schwarzvogel.de (mail.schwarzvogel.de
 [IPv6:2a01:4f8:252:1806::25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C2F10E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=schwarzvogel.de; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KUgJw23mmpXsJW0qTohSnrBVIlykv3qiY9FPedI17yU=; b=vpc/hr+sG1gZm5q0RWkeSf7psk
 MUuYJI8MGSV2al5wEjmoY4pv7vUQ7CCachllXFNYOdpnHcDL3ftdlB8VaIECSumeUoDAacxkWN1Q6
 EpsTym0NT+FD2WG9+lIZfpavCGVNcE+55yNSbTojoPja1ckPfJSuqiAa96no1yqoBrgjkGA8D9sxd
 tiFcuv1UiLppM3MlY94Sc42E4P2BG6YFosWI5m+eqckWkzek4cO4FXFyTS4I77MXnIjuldfyIYezW
 KhF6Me+vwIfZP1PGoI1ZMPE5guReYyb+4gsddoBJH+hTYId1DuOR2Osva5DzIiUOWb0NzPBQUil7B
 6PUr2mGQ==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.98)
 (envelope-from <klausman@schwarzvogel.de>)
 id 1tOD4q-000000007GD-3r31; Thu, 19 Dec 2024 10:44:16 +0100
Date: Thu, 19 Dec 2024 10:44:16 +0100
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [Bug report] Regression with kernel v6.13-rc2
Message-ID: <3b2b05c3-eb14-433b-bc69-6501cbba5df5@skade.local>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
 <SA1PR12MB859906B3658D04A797CF388BED052@SA1PR12MB8599.namprd12.prod.outlook.com>
 <DM4PR12MB5152AFC2089AC7C7F67C800CE3062@DM4PR12MB5152.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5152AFC2089AC7C7F67C800CE3062@DM4PR12MB5152.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 19 Dec 2024 14:17:44 +0000
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

Hi! 
On Thu, 19 Dec 2024, Zhang, Jesse(Jie) wrote:
> [Public]
> Hi Tobias,
> With this patch, PyTorch works on my side, please help verify this on your side.
> https://lists.freedesktop.org/archives/amd-gfx/2024-December/118058.html

I can confirm that this patch, ontop of -rc3, makes the page fault (and
subsequent crashes) go away. Thank you!

Best,
Tobias
