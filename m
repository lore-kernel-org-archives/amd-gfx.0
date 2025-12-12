Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091A7D4922D
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 13:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A06810E35E;
	Fri, 12 Dec 2025 13:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="eh5Gx1sr";
	dkim-atps=neutral
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2AB10E72A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=nDbmUHc2dj5euBkEod+E3WGAYdQOIp/oaUdJcJPX9SI=; t=1765545570;
 x=1765977570; b=eh5Gx1sr/1eTqJysYPLx1qG5mUNw2lvH2eA5sidyBWr491ZHbCkxl8Ij35zpv
 knBlLG7xpI/Ge4BEy5xYA5FuWdgoBWAo/btxQOBvSSWFaKxPD/FizXgdqZ23qmCz0juLKhACc8g2N
 NdeHo0F9nX9SxdCPgxem/lQPDdmCVBYk/ejnP6D55GGdZ3tx9FvL5i6AGYM4uraCf5lsL89O3o86u
 ALX6356gUZIbxysWMQyLRAbFp2+yQj4FUwyiOVdH9yp656UvybKaQBO5yIC+BolVaHn7oV+AiHpbs
 7pCuamY7ZVRJsqdEA4j67SlqfhB9Xa5lLlf59azagB76HeLRLQ==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 id 1vU33O-00HLxA-2q; Fri, 12 Dec 2025 14:19:27 +0100
Message-ID: <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
Date: Fri, 12 Dec 2025 14:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, bugs@lists.linux.dev, Jerry.Zuo@amd.com,
 aurabindo.pillai@amd.com, ivan.lipski@amd.com, daniel.wheeler@amd.com,
 alexander.deucher@amd.com, gregkh@linuxfoundation.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
 <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1765545570;
 69919f45; 
X-HE-SMSGID: 1vU33O-00HLxA-2q
X-Mailman-Approved-At: Fri, 12 Dec 2025 13:57:48 +0000
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

On 12/9/25 16:50, Péter Bohner wrote:
> note: reverting ded77c1209169bd40996caf5c5dfe1a228a587ab fixes the issue
> on the latest 6.12.y (6.12.61) tag.

That is 1788ef30725da5 ("drm/amd/display: Fix pbn to kbps Conversion")
[v6.18-rc7, v6.17.10, v6.12.60 (ded77c1209169b)] – and Mario (now among
the recipients) submitted a patch to revert in in mainline:

[PATCH] Revert "drm/amd/display: Fix pbn to kbps Conversion"
https://lore.kernel.org/all/20251209171810.2514240-1-mario.limonciello@amd.com/

But it has "Cc: stable@vger.kernel.org # 6.17+", so that revert won't
make it to 6.12.y; I wonder if that is just an accident or if there is
some good reason for that.

Ciao, Thorsten
