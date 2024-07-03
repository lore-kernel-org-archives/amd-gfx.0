Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7666C30653
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 06:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6933910E733;
	Wed,  3 Jul 2024 06:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="msqADFNG";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E9710E733
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1719986667; x=1720245867;
 bh=1Tw2pPg5VcTqdZV+dstC4dUr6AJmx6XOfqPDGcrnLKQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=msqADFNGzz+QGisVihmrsWXDDg+9XIP/sd7IIj2xHjU4DxetwlnXvTzA4eFo35XL3
 ogYq2hwD2QmhAzYm3JCeVEUHh5UoyZM9ZbBi4MdvE/hCZz9qUoLvWpuVkHwdnCWFp2
 fuPYP4Rc2I1iG5ZeDglhBAiSHXeA0E3ABlaRWDHVjdFLQDtqI+aGHxIy4lliPYC/V9
 w9S94uRry3rOpsANQFvp6UbRCodmxMmnypguiAg6Y6tYW3QlInYLDAjfojsWz5SDv/
 k5U+zhKF5gbUepeFp87VXFn9xe5YZXYpUwJfkmAPczaiqljksXvw1++iAYVadqcu+z
 ihdClS3v3nKVg==
Date: Wed, 03 Jul 2024 06:04:21 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>,
 daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>,
 =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com,
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 2/2] drm/atomic: Allow userspace to use damage clips
 with async flips
Message-ID: <Y7XXNRZbyuqt9XZPtxVFRJgywsSTpsDwdWZjhxWnYH3lPSwa0-hVV1kgXzb0q8BAMRvH8eEMdPHOvgAn2KI5HcaWazmQvRyfI7NvQBAU4Z0=@emersion.fr>
In-Reply-To: <20240702212215.109696-2-andrealmeid@igalia.com>
References: <20240702212215.109696-1-andrealmeid@igalia.com>
 <20240702212215.109696-2-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 0dd41e430d756e207182de869cba7ff4f635e530
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good to me as well, thank you!

Reviewed-by: Simon Ser <contact@emersion.fr>
