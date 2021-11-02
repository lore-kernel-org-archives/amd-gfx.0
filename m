Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612CCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B0060D42
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19B0060D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1B36FF03;
	Tue,  2 Nov 2021 08:58:08 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8E86FF03;
 Tue,  2 Nov 2021 08:58:07 +0000 (UTC)
Date: Tue, 02 Nov 2021 08:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1635843484;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=I7BfR8Tm5PFeWXoE8R0R//TQF8/hy3Tt4bIF1B90AgDR1K9YLk1RlV8S8qJmBoUMI
 lp2dg7wtxW+xC6KpndMvEP7ddzQNMk5ZzLdFd/E26s2sKCR5c6H67GImNkJxofQeUk
 1e1odJREXzGHTpVVk9dYj1eJ+0BQ/L71EXZu6jqC3VIPt+4UuaZvmeAnbC1KqY9hbY
 eTJKJGwMcNUtLeFZi6h5eOF6AndMA0/FzV4yGlL8kz0juAbpAk/nIvnzbxbeoPxO9l
 YDU62Msd2bdbNKdlmh9J9vR5DxkfE5H7AfqIs/b+nbP46otSt8NeQdL/ulVpK932V7
 hgW4O+Qd6QbtQ==
To: cgel.zte@gmail.com
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conditional operators
Message-ID: <lvX4AA55dPGJGyFf1ncXCnqomRKljUmW8TXAJV88VrSpYt2gSTrcK3JnCbGl5zsRJ4Gqs7-MAXIuCGr01axsnxkzDO5STy3cMMAo5SL7wOE=@emersion.fr>
In-Reply-To: <20211102070125.4445-1-ye.guojin@zte.com.cn>
References: <20211102070125.4445-1-ye.guojin@zte.com.cn>
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Aric.Cyr@amd.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, meenakshikumar.somasundaram@amd.com,
 lee.jones@linaro.org, jiapeng.chong@linux.alibaba.com,
 Zeal Robot <zealci@zte.com.cn>, Rodrigo.Siqueira@amd.com, syed.hassan@amd.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, aurabindo.pillai@amd.com,
 george.shen@amd.com, harry.wentland@amd.com, Anson.Jacob@amd.com,
 nikola.cornij@amd.com, ye.guojin@zte.com.cn, shenshih@amd.com,
 qingqing.zhuo@amd.com, Xinhui.Pan@amd.com, Roman.Li@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, Wayne.Lin@amd.com,
 alexander.deucher@amd.com, nicholas.kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Simon Ser <contact@emersion.fr>
