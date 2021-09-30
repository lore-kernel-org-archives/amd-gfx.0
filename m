Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331D4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 10:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EA961881
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 10:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2EA961881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753786EB5D;
	Thu, 30 Sep 2021 10:17:34 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A496EB5D;
 Thu, 30 Sep 2021 10:17:33 +0000 (UTC)
Date: Thu, 30 Sep 2021 10:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1632997050;
 bh=omu6kUN/ZbjN/MA32O0UnYTGse061XaoIw5SVvXsMJg=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=kFLPl7HPxuXTisHVHRjo3tmjECLclF4sbz9BepfxOoj+K+F3V6xyK+RCwvy4v8zLY
 CUadODmeZxu+MWJsdu6xVmzimRpEfHQQbP+4IAtabwp9Y106PoqMvngC0QmY4kVW4I
 DKE9KzxLLNtMZcjOka56mhNvJQSkEwM7ddIhrNxJCWyZtEhcMixRZ30ufpj0PkAdtT
 LgTLVOKJ/wv5O1TW1ip1u4D0qQZgizRv6MBbKf/Q07JShMJzgufNX8HkCRCTFvyilB
 v8Gq+JBb0AY9bPx4nxZgo5G0baPoy88aluPiK6d7YuDxqRmZHcg9y8SDR+WHCkPts2
 GzjrPYCFQs0rg==
To: Guo Zhengkui <guozhengkui@vivo.com>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Guchun Chen <guchun.chen@amd.com>,
 Peng Ju Zhou <PengJu.Zhou@amd.com>, Bokun Zhang <Bokun.Zhang@amd.com>,
 Likun GAO <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] drm/amdgpu: fix some repeated includings
Message-ID: <AGiYadRf5XyGUqLxwu3ykKzfwM2BgZo4yCAaEXdQiYfH2dbyKmipDNrclnI2lZH3HzNh71VBy5QKz3O4fFvQETjTI9hoKzKHjZNBz9ERKI8=@emersion.fr>
In-Reply-To: <20210930094239.7435-1-guozhengkui@vivo.com>
References: <20210930094239.7435-1-guozhengkui@vivo.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

One include is v2, the other is v3, or am I missing something?
