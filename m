Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0099C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 07:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E329D10E56E;
	Thu, 17 Nov 2022 07:56:25 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C621E10E56E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 07:56:21 +0000 (UTC)
Date: Thu, 17 Nov 2022 07:56:09 +0000
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="MbZLgtY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1668671775; x=1668930975;
 bh=WYuRefUyKGr6lMweRSCbo3l2TIHxHgZBvU3a5FItoNs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=MbZLgtY/j47Dw22xljN6e7r0bo46ItdP5YGdDrUUoDwx6Vnv8jDKfuXZnGrstuC3x
 MrHMiAlWFV7z1yHgl5Yjf+JQ+4oIv4TF3dGbHvnDY7uYS11pj/zEwCyfodhhPl8obV
 fClzkIiWGaUBDf4yB7/vFfMAsc7579C+XbsN3PecMDD9b04G7juRtBxeZGDHYYsHdR
 pj1GHcMKxAze5bslODwcSfFQCAJDdPSNFgzIePH8rGNj5gQ5RzKI50KsuPHSBnmvuE
 zX0rDm03ODf+NYZKwUAy7Wm3f9I/VZLVfeXcwptLOZ8AcDdrgZJb+TAWW08bHtO1wU
 zwCHQS9vdlR8Q==
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: rewrite the check for mods
Message-ID: <rCi2ckxzcwtJsZr86hXMQnk3b1ARq6wXXoNiQe-6cQzinJ7CSzUABqf7k5GfIhKoLQ3wXGOQJPR0TjW2Ddn5sM5ht61w_NEHHeSPdGaIwc0=@emersion.fr>
In-Reply-To: <20221117073258.21214-1-jiasheng@iscas.ac.cn>
References: <20221117073258.21214-1-jiasheng@iscas.ac.cn>
Feedback-ID: 1358184:user:proton
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
Cc: sunpeng.li@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, dri-devel@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, Jerry.Zuo@amd.com, aurabindo.pillai@amd.com,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This breaks the "size" out-parameter.
