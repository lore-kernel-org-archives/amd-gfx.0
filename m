Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62E8C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 22:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E3E10E535;
	Tue, 23 May 2023 22:21:29 +0000 (UTC)
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9381210E535
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 22:21:28 +0000 (UTC)
Date: Tue, 23 May 2023 22:21:02 +0000
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="Q1e7QkDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1684880464; x=1685139664;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Q1e7QkDV5Zacu07sYQ6VrJy6cddZnmEZQWUwJlA0IkQ2Dp+cc63CuXDJKddL4dmzg
 FRTg0R/s5sPxJYRKUgVSG7MEcskIAhZEj3e/jMGLeNN2fPmAepkvu8EQY4Y2l4vvUj
 ywSQ0w3psCVuNM1w1mlS95faA50I6N8DTnS3JesReu3qKKHRRPB1bxKj65iTAi2aoG
 KTXSUckbouWzTtewuw4YlKHYLb5DX+4CUN33vafnrFiP6LptMufPOIvPgq4vdPQ7gp
 kcrxOaz8lyC+kn41DXaJ2XRK68+YUr1AdDfjS6oQ8e5KrJT+oLh6r+KSWOWjDtVeQx
 hyCkUxZ+59GwQ==
To: Melissa Wen <mwen@igalia.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 01/36] drm/drm_mode_object: increase max objects to
 accommodate new color props
Message-ID: <V7P7Qs7O1XEpNUGXDkkpL6rV2Y2jJ60PhjEL7-qetMKUv6YF2C1leKhKS5zAj1qG8tkBcTqoHFhN_gW1SWaI9FwsQn1uzuvyZcreV6MwGPY=@emersion.fr>
In-Reply-To: <20230523221520.3115570-2-mwen@igalia.com>
References: <20230523221520.3115570-1-mwen@igalia.com>
 <20230523221520.3115570-2-mwen@igalia.com>
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
Cc: mripard@kernel.org, kernel-dev@igalia.com,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, daniel@ffwll.ch,
 Shashank Sharma <Shashank.Sharma@amd.com>, sunpeng.li@amd.com,
 maarten.lankhorst@linux.intel.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 tzimmermann@suse.de, Alex Deucher <alexander.deucher@amd.com>,
 airlied@gmail.com, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Joshua Ashton <joshua@froggi.es>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Simon Ser <contact@emersion.fr>
