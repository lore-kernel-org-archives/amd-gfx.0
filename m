Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C3BC44500
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 07:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B640F10E6F8;
	Mon, 29 Jun 2026 07:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=yeah.net header.i=@yeah.net header.b="UjTLx4oI";
	dkim-atps=neutral
X-Greylist: delayed 1757 seconds by postgrey-1.36 at gabe;
 Sat, 27 Jun 2026 09:57:25 UTC
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91F110E48F;
 Sat, 27 Jun 2026 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=cditTTZR98qCuukx7N1JBr9bmy5QU/HMtRkQnIKtEBw=;
 b=UjTLx4oIOzozLBA3ssScOuWhIDyB81Iy5o3Y0U4UPTvky5Eh0i4X3Qm2+8kMSY
 U1S8jtBwPfxxPDlhVQF/QiV6dXms7Tr+IDtO2Gi/Ca3KiysZSjQJF5Zpu6T3rMeI
 UngzsSUFbMImW5+SzqQbLgAFyxQ7efQJr7sZsWmJ8o7mE=
Received: from zhang.. (unknown [])
 by gzsmtp3 (Coremail) with UTF8SMTPSA id M88vCgDnfzRnnj9qUg0MAw--.13884S4;
 Sat, 27 Jun 2026 17:57:01 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: markus.elfring@web.de
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 linux-kernel@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, zhangcoder@yeah.net
Subject: Re: [PATCH] drm/amd/display: Remove redundant NULL check before
 kfree() in mod_power_create()
Date: Sat, 27 Jun 2026 17:54:54 +0800
Message-ID: <20260627095616.4479-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dcc01255-8c9a-41db-80b8-e4482ec12789@web.de>
References: <dcc01255-8c9a-41db-80b8-e4482ec12789@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgDnfzRnnj9qUg0MAw--.13884S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDWFy7KFyfuryDtFWUArb_yoW3XFcEkw
 4ktFn7uw40yrW8Awnayr43Wrs0kw47Cas5Gw1FyF9aqry3Jws7Zrs7GFn5Aw1rZF18CF4D
 Cr15Ar10vFyxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-Originating-IP: [116.149.202.60]
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiIA4t7Wo-nm7sqwAA3M
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:55 +0000
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

On Sat, 27 Jun 2026 11:43:25 +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> > @@ -270,12 +270,10 @@ struct mod_power *mod_power_create(struct dc *dc,
> >  fail_bad_brightness_range:
> …
> >  fail_construct:
> >  	for (i = 0; i < MOD_POWER_MAX_CONCURRENT_STREAMS; i++) {
> > -		if (core_power->map[i].psr_context)
> > -			kfree(core_power->map[i].psr_context);
> > +		kfree(core_power->map[i].psr_context);
> >  	}

> May curly brackets be omitted here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.1#n197
> 
> Regards,
> Markus

Yes, you're right. I will send a v2 with this fixed.

Regards,
Ziran Zhang

