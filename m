Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3164C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 19:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4398710E408;
	Mon, 21 Mar 2022 19:04:31 +0000 (UTC)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975DF10E381;
 Mon, 21 Mar 2022 18:50:14 +0000 (UTC)
Received: from ylum.localnet (unknown
 [IPv6:2a01:e0a:3d9:ddd0:37f3:7f74:639b:b0a3])
 (Authenticated sender: domi.dumont@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 95819780377;
 Mon, 21 Mar 2022 19:49:56 +0100 (CET)
From: Dominique Dumont <dod@debian.org>
To: Eric Valette <eric.valette@free.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
Date: Mon, 21 Mar 2022 19:49:56 +0100
Message-ID: <3873010.MHq7AAxBmi@ylum>
In-Reply-To: <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan>
 <CADnq5_MWqz7-XhOS4zfuzi3=_nKa72iYaO0BcKNcVDwEvZ+YHw@mail.gmail.com>
 <61c2b2ce-d749-3723-ad27-f40e1c49d967@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Mailman-Approved-At: Mon, 21 Mar 2022 19:04:29 +0000
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
Reply-To: dod@debian.org
Cc: Sasha Levin <sashal@kernel.org>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, 1005005@bugs.debian.org,
 Evan Quan <evan.quan@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

On Monday, 21 March 2022 09:57:59 CET Thorsten Leemhuis wrote:
> Dominique/Salvatore/Eric, what's the status of this regression?
> According to the debian bug tracker the problem is solved with 5.16 and
> 5.17, but was 5.15 ever fixed?

I don't think so.

On kernel side, the commit fixing this issue is
e55a3aea418269266d84f426b3bd70794d3389c8 . 

According to the logs of [1] , this commit landed in v5.17-rc3

HTH

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


