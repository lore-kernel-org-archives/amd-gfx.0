Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F2BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 17:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE56D20738
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb6aIsQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE56D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC756EA15;
	Fri, 22 May 2020 17:46:53 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B87A6EA15;
 Fri, 22 May 2020 17:46:52 +0000 (UTC)
Received: from embeddedor (unknown [189.207.59.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A95E92072C;
 Fri, 22 May 2020 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590169612;
 bh=D18/tscbxNYJt7Qi51OajMBP8/Y1ftjXaTbS8M/yx6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nb6aIsQcHONH6fn8FyPFvbOOwO3QjVHZd40VefUzq2Aa6TUjr/ikpuBaIan+XiE/L
 mVYg8LPnlNqb6RaLcUR4WMGfypNbRiJ1qbMenZVRKfUrBPOve31RnG2Wr53k7AUMae
 l+prLfZh08RC2CGMiwEo2m1OO8NeU57g1c2xzUoU=
Date: Fri, 22 May 2020 12:51:42 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
Message-ID: <20200522175142.GF29907@embeddedor>
References: <20200519225545.GA2066@embeddedor>
 <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 20, 2020 at 09:42:27AM +0200, Christian K=F6nig wrote:
> > =

> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> =

> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> May I suggest that we add a section how to correctly do this to
> Documentation/process/coding-style.rst or similar document?
> =


That's already on my list. :)

> I've seen a bunch of different approaches and some even doesn't work with
> some gcc versions and result in a broken binary.
> =


Do you have an example of that one that doesn't work with some GCC
versions? It'd be interesting to take a look...

Thanks
--
Gustavo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
