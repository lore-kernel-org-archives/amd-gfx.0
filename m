Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5720AC02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 15:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB9410E734;
	Wed, 15 Jan 2025 15:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="Hj7gGOWn";
	dkim-atps=neutral
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB18610E761;
 Wed, 15 Jan 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1736956469; x=1737215669;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Hj7gGOWnrvt3GmaoyT4kGP0eHl0ZN6UI0E4mcJ7G1JCOQg+HJimGjBq5wjY5Y+4kc
 5is3lljJmawxKLO/eOOUjXE7T+jYzaOoccgIpqr9t1V1VBWKnkiANL6P9V636dZ0w2
 Li8SuBulnfUSPQne9448N+qi4F5D6Zroa05jm1//+rP5uwWjgslJENv4Is7no8fjmG
 PW5zR900QY8/xHbIBVkYQ5TcDR7tQmhvHDNNliLTZ/cataGNsVmXqwCG+r5y/4bM6l
 QtNQwI3jiaKK2p2ENRuQ+fDKszp6CfC9eUk4W06AavJmNVZ4IiaNK2/P9gAEEf8Gt5
 15vASCgGEcK5A==
Date: Wed, 15 Jan 2025 15:54:27 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 36/45] drm/colorop: Add mutliplier type
Message-ID: <-anZ-Kodj97pzzzPpBvLinqyhZ8E6TquGswKYKVqfzjjVj8ehc8tOITNjGGXFuxpOiT2CjRLKi6VxfSimqw48tlj1tTEVLBCVm2vukDjKSQ=@emersion.fr>
In-Reply-To: <20241220043410.416867-37-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-37-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: db8b661e4ca5e7716a081d5402d0c7387e8c0d30
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Simon Ser <contact@emersion.fr>
