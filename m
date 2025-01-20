Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5D1C02185
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 07:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865FB10E341;
	Mon, 20 Jan 2025 07:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="g+VkeCrK";
	dkim-atps=neutral
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FC910E347
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1737359319; x=1737618519;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=g+VkeCrKrJMJBx6MsYH0Gpjg3w/wY2gqeo6Z+cHH2THw2P4haYLecMn2TYXR+aMZB
 vRrzgDpfyyjhEDQ2YlCzYDYxVICTM5w9TXfk+uu7qHoc7+wcrO46XPeABMPSuGEFx9
 PHMeIDlnXOqZ6K56XFQlzoYzYl4iKx5CJ+0b/G4KzIYJPWryGBoSdA+giJZe7a9XQG
 KKu/ntbqFaV/EeO29m9sCVOqYQYjLhXeGBaxaZsWTL6L+rzFuOFjEpR5B5DeLTAH+J
 E0QL5QtTgd8mwfAVheLQFBEeIqDpkedRyPdQJjN6yJSZSTLf/ZbmeWGSg0rAw01l2f
 8Up3OcpkrLxBw==
Date: Mon, 20 Jan 2025 07:48:35 +0000
To: Alex Hung <alex.hung@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, harry.wentland@amd.com
Subject: Re: [V7 39/45] drm/colorop: Define LUT_1D interpolation
Message-ID: <CME-EpnEJHl2zzYsno91e3ZHtHT9cBCCfXb-WPbUzKzdLWg8agu79ZqkjjF9Ncawl3_YoIrUYHioH_bQd8u2kknOyjLzQjh3ftX-a0Re12k=@emersion.fr>
In-Reply-To: <20241220043410.416867-40-alex.hung@amd.com>
References: <20241220043410.416867-1-alex.hung@amd.com>
 <20241220043410.416867-40-alex.hung@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: af607c56be6d75a242474f153cbe6d4da248a893
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
