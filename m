Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DB7C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 19:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B87410EABA;
	Fri, 13 Jan 2023 19:31:48 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3520710EABA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 19:31:42 +0000 (UTC)
Date: Fri, 13 Jan 2023 19:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1673638299; x=1673897499;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=LM/cvxdxu1h67rgJmHGTZ5TA/54rBU4PAWlLcMZwqucruMoTz/3ZDQ5jOrVT2YuYT
 UulQsVo6SO523340mlJZf+1DsqoA+CtbkxBR4usIdLzIuYDa2Quz9bvrRa/2emDIIe
 pMqTr1BDaCH4+BJikpXiYzmYNIqFV6TvUSh/wpoQEW/oByqBUMN3Ej5cdcAMHJBwlq
 /spDqIrNM6Ivmryhoq4pJ79J5BZu4ovROCxtUKH/2zTkPsd9S7OE908KwwJlNwgrEi
 E9dEKMucBcz9FZvd8xhDM3J1QwlrhMRcKDAYoniuSM3++XZd7xSG9LezoVZb2W5S3y
 UBBAxQAENMNTQ==
To: Harry Wentland <harry.wentland@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 04/21] drm/connector: Convert DRM_MODE_COLORIMETRY to
 enum
Message-ID: <kheFUP1l7rBWCZbD5XFZtgF1efA52MViV-fZAxzA2wqbIixOTiBUJI4k-SvznW2nUujcumWv-VK3k5lRxY57tXW5vwJbSXwAvnfhM9fgCh4=@emersion.fr>
In-Reply-To: <20230113162428.33874-5-harry.wentland@amd.com>
References: <20230113162428.33874-1-harry.wentland@amd.com>
 <20230113162428.33874-5-harry.wentland@amd.com>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>, dri-devel@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 amd-gfx@lists.freedesktop.org, Joshua Ashton <joshua@froggi.es>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Simon Ser <contact@emersion.fr>
