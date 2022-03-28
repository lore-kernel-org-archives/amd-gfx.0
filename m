Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F42C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 15:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53B10E71C;
	Mon, 28 Mar 2022 15:30:09 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D86510E71C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 15:30:08 +0000 (UTC)
Date: Mon, 28 Mar 2022 15:30:00 +0000
Authentication-Results: mail-4321.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="pS8+Lr8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1648481401;
 bh=Dwze+Z1fKLVc7Ssligk7at5uxi2SQfiAgxh3xgmR/FY=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=pS8+Lr8QtR0wTl3LB3qDMy8cM/xoSa3lMa4UIeq66fiUd+Qgy9KDum/sVHKJ8wwHF
 AaelfItgq2wNS7gx7gsdMfPSMaJc+vLSNhS9Rwkz6oN5DKCmsD4DUVcdHNm+ti8z1g
 DVq3c53IZUbxHl85mxnaGSEt1+1SXxRtCckQTJcbINrocf84lW67W9Y3ybu9uYuPZk
 yxz36CkIg4QtkKsxl8owKpgBoXJydFUeOtCr6ryxFRCpBpUiLmvPhFBIaJqLrDL5DZ
 dARGsI0rEqvXB+p2+uXbNMsEXOtKdKm/EtDItFiObM0vIgnHlw9ExOahCHnU4QPloA
 uT26xs3PANyRA==
To: Melissa Wen <mwen@igalia.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC PATCH] drm/amd/display: dont ignore alpha property
Message-ID: <Bq9Aj2IM-iCzmSHMJzvYjL_qmyPoAjbrRh8JNExHmqJW5kxFbtOSjC4WFoeB2R_lUKQszrEuHsFKNHAtXvhdUwp_8ejTnKqKRmVPiiS8Cqs=@emersion.fr>
In-Reply-To: <20220325204450.kq7kjb7ez63p5srm@mail.igalia.com>
References: <20220325204450.kq7kjb7ez63p5srm@mail.igalia.com>
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks a lot for you patch! I've noticed as well that amdgpu ignores
the plane alpha property [1]. I'll try to find time to test it.

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1734
