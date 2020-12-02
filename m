Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B7C6369E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2901021D91
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901021D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFA16EAC1;
	Wed,  2 Dec 2020 21:09:16 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FD16EAC1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 21:09:15 +0000 (UTC)
Date: Wed, 02 Dec 2020 21:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1606943353;
 bh=38h5gjlaSwfQQKnHE+2v5+OrOAGIRWGYcdZxYSziU6c=;
 h=Date:To:From:Reply-To:Subject:From;
 b=NU+Nht58p1sxnWcbr4q888dU9RdmgXPG3YCY+CO0xpsNh9XFOTPXGId/DxDuoE2VM
 xw7+eAG+ybkrZGWsYD6o4JN7tGp2jlSFodgHrjtM+etD9ftiT1OrSh3LER+WW7uJLP
 c01UCatwhaupAog1qFvPk5iiLKIp/SUtNXYh1aH4mpXR9A/fs6EvsvpkmHxIEryml+
 F5OLW3N0Tzt09NXm9L5brStZHo0EmN7BqAY3OmVTETU4x4eJVvV59SjM+ZKOrR9NQ8
 Gp5N5/LwXBHiY+Pk1s81Ry5EDJGo+GBL9b5MEg2J72LyjuKxXyg6TYXdq2Kw6NQPNz
 Sem4QAHGpWXcA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 0/2] drm/amd/display: add cursor pitch check
Message-ID: <I0taFFYbMGqEVV2Q8votdxgboAc8fwuT5InlTl4BHuA@cp4-web-014.plabs.ch>
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
Reply-To: Simon Ser <contact@emersion.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were checking the FB width/height, but were not checking its pitch.

This has been tested by running Sway.

Simon Ser (2):
  drm/amd/display: use FB pitch to fill dc_cursor_attributes
  drm/amd/display: add cursor pitch check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.29.2


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
