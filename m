Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905FC83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441DE2074A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octaforge.org header.i=@octaforge.org header.b="PstCH72c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGkSkECt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441DE2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96996EF27;
	Wed, 29 Apr 2020 15:08:50 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278146E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 15:08:49 +0000 (UTC)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 835AD906;
 Wed, 29 Apr 2020 11:03:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 29 Apr 2020 11:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=octaforge.org;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=R3+XHv/jP+/xA9ZbK9P8+A0LI4
 stWJTiqxkB6g7Pvw8=; b=PstCH72cK5PWSPua5saP32LZe+S1NPLzj3mmo/sBq/
 /oBUiXKL9/tSlwECPXn+clHdHkVCiseTA4LtxErpxdxHNK4KX73tqFSe9IdsbJ63
 LFVh3quNTz84sZ+zBIOJwHzeVBhrS7/HXTlOyQWEQIuZa/522pq4PG7r6cE0UrJI
 GHwdn8brQy7rDRs/OFs/PeEXq0gWDoab2alTIUBkjGgvRT2bwgXW9yaHwH5jOhON
 hXl/GPASkCf7DoIIA/qO4qVFVkER1RT+39BdKXJ65vHEBYkTDUYMAGubaMQiMMzk
 xD9HIPQ2N8FDYyAD/4H6l6OOz1klhYRkIRm1Vtw57COQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R3+XHv/jP+/xA9ZbK
 9P8+A0LI4stWJTiqxkB6g7Pvw8=; b=hGkSkECtVpKeM0ku1st9xXRgsJYGXPZz3
 jA2jeEQ5O7HsB+Zmw+FsjaFLDN2KefsAh2I+Eg/SByVy+SUA5CGPiLk6gyrh3PFo
 RXx+O8O4thsuqk2fbyi+OGzYLzb7BZpZ6R9CS4NFv/gPJeFxh0iVlrNbst6kzQNI
 cm8VXYrgXfLfkVUu1tW/TJsqbWw5hrCeOHhom+62qp5n7AYDXozC+ScB4Lzjrvq8
 Svv7qgw7EKpa+yTJ8IGvkzRhbGQOkoTgI0oYhHHRJwblgmTB3M7jJ0O6ep32qPDw
 /zdYhrRoRM8ZtFBuLKNICIeRpoHSRrZ8oVGEYFhDizm6KouLO6GVA==
X-ME-Sender: <xms:LZepXlMZj_3dKCh-NF1xfwNiGWsZ9JX4oSDcImRdR7863KYvP5YMTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
 dtnecuhfhrohhmpeffrghnihgvlhcumfholhgvshgruceouggrnhhivghlsehotghtrghf
 ohhrghgvrdhorhhgqeenucggtffrrghtthgvrhhnpeeguddtueetffdtheeitdfgheeute
 duvefhheeugeelheehudffudeuveetjeefleenucffohhmrghinhepkhgvrhhnvghlrdho
 rhhgnecukfhppeelgedrudduvddruddvkedrudekleenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegurghnihgvlhesohgtthgrfhhorhhgvgdr
 ohhrgh
X-ME-Proxy: <xmx:LZepXqT-K3Y-fV6GEoTIlgt2I9ET5G5nswWk7narQBXFWEo4ZdOp-Q>
 <xmx:LZepXi8hhuuYfjJZsR1keU0nQXk6CMqG99oX0jfuuGJzVnvhimmSiA>
 <xmx:LZepXupwbZz3rbbPQsf7sUWwh4JP50luyDrIDFA_M9fnrkJa1rP3og>
 <xmx:MJepXj1mrTnl0bHrelNC9u4b6mFE4NzMwlDnmYXI4MXQEYY5y8aqNg>
Received: from localhost.localdomain (ip-94-112-128-189.net.upcbroadband.cz
 [94.112.128.189])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2C85C3280064;
 Wed, 29 Apr 2020 11:03:09 -0400 (EDT)
From: Daniel Kolesa <daniel@octaforge.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] Fix Navi cards crashing with FP exception on 5.6+
Date: Wed, 29 Apr 2020 17:02:35 +0200
Message-Id: <20200429150236.4626-1-daniel@octaforge.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: Daniel Kolesa <daniel@octaforge.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is not a real fix, but rather a workaround that should be applied to the
5.6 tree and newer. The idea here is to work around the compiler emitting FP
instructions outside the DC_FP_START/DC_FP_END blocks, which it currently does,
which causes crashes at least on ppc64le.

A proper solution would be to move all the floating point code into its own
files, then compile those with hard-float and strictly wrap all calls into
those with the DC_FP_START/DC_FP_END blocks, with the rest of the code being
compiled without floating point, but that's too extensive of a change to do,
and would not be possible in a stable tree.

The proper solution is already being discussed, it seems:

https://lore.kernel.org/lkml/CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com/

Daniel Kolesa (1):
  drm/amd/display: work around fp code being emitted outside of
    DC_FP_START/END

 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
