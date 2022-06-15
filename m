Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5361EC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 14:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EEF10E7D1;
	Wed, 15 Jun 2022 14:34:59 +0000 (UTC)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7804E10E80A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 14:34:58 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp6-g21.free.fr (Postfix) with ESMTP id 3090A780333;
 Wed, 15 Jun 2022 16:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1655303695;
 bh=KpgCnZWrT58TBcG/6G1ezc4T082sQ+4odvHBC8hj1TE=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=kif/YKjOXwvww4YXbPCIOOv2qf1WBaDiXsKl8AzdCAZ/o8pJclCYfDm6BPx9M+8fC
 m2s2mW3PvlDP/K3HNdMHEfO2sNTAef3OY2VgbYQBhtRW/6W7rIpp9AL1fhgPH4wb12
 5+qSA2626kIHWl1z+AUD35o9HsPDdIKrb2G9MBTF9uk+IDcVh5ftMaWZuD/KCn4GvP
 dGTtJAeNR//U0FR/dUDtRlA+3jsN0Bsw4P1+G7mjrQFKJYvikvb0RQkOfsqPQvyfLs
 3ldY6ClS/g9xYjRdcOHtXrwbOgS/eyUbgp5NQa14DFQUQbNXs5CvtNQ6tHUDfmi7Z+
 hBng1e8UYRscA==
Date: Wed, 15 Jun 2022 16:34:53 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Message-ID: <697640373.608902230.1655303693136.JavaMail.root@zimbra39-e7>
In-Reply-To: <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 tales aparecida <tales.aparecida@gmail.com>, amd-gfx@lists.freedesktop.org,
 maira canal <maira.canal@usp.br>, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Sean Paul <seanpaul@chromium.org>, isabbasso@riseup.net,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nice!

> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
...
> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
...
> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx,
> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1

Those similar-but-not-quite lines tend to confuse me :)

Best regards,
-- 
Yann
