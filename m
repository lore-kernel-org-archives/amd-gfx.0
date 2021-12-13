Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A5CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2D710E851;
	Mon, 13 Dec 2021 15:44:31 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208CE10E851
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:44:30 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4JCQmY5pFGzDt2F;
 Mon, 13 Dec 2021 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1639410269; bh=BYLpkgjoo0rmBMLzOP44xX0nY2bSxIzcSl3c+jJTRYc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JxAI/Zxc2u37W04rYfC22vzwTDHxxJzvLMZJ/aJpLakBBMO3z0Bm6BcZrsqSJC+XG
 gzc35oye/gCbhz5axmdI8GqO/w5uT2/1e/qERaGMsiXNt34Z2pidSbxdOAoWu7UwUR
 PJePIag7HjcxKrPxc9sbojO2zGupYAk71U3glHGE=
X-Riseup-User-ID: D7E9B49A5D0467C472815538328D1E9C8232CCB89EF23A16B9FCECE023503D1C
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4JCQmY32kzz5vcG;
 Mon, 13 Dec 2021 07:44:29 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 13 Dec 2021 07:44:29 -0800
From: isabbasso@riseup.net
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: Re: [PATCH v2 00/10] drm/amd: fix various compilation warnings
In-Reply-To: <20211209154722.4018279-1-isabbasso@riseup.net>
References: <20211209154722.4018279-1-isabbasso@riseup.net>
Message-ID: <9c621fce775c1a617f156726670c38f3@riseup.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: ~lkcamp/patches@lists.sr.ht, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

Thank you for the reviews and quick responses :) I'm really glad all of
the
patches got applied and am looking forward to making more contributions!

Cheers,
--
Isabella Basso
