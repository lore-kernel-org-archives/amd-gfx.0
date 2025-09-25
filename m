Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F1ACAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 12:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A076610E90A;
	Thu, 25 Sep 2025 12:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VCWY4ojZ";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB14A10E27D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:55:16 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cXXG962C9z9snk;
 Thu, 25 Sep 2025 13:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1758801313; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E86Y100zuJF39GwcyoOCsLajnC1ylIfMg/CBPblZbL4=;
 b=VCWY4ojZHOG93CqE6krjfuOn2yyzMqeWtyFUHtE/z85FrisgypbIASe7EbZ7/R9c10DtyR
 oL5/FKNwtSEIQSuhraHlCW9WYlznzS9950ejQ3smQTzIupPBKB5CJz0FtQZjv4SVTvl+b7
 j5VLVJ43FtC99SGoFKPgEcJaA59Ldp+MgTMJbVWhqwqXSQyPm63w0KGNyP7GzOiOpgdMet
 FMP++HhUklauXlZ4fMi16TjGr4J8hiNAsTm9Y/oZh4RNE11JlJmvN6cbrqSMnx1W4V/LLA
 oK7UqfqkSucRH7j+jdQNx0JzlbSQoXccO6lsJMMJAB4uWGmNZp4vpeQOYUYc9w==
Message-ID: <4e3e1e20fe4842f4a7cc61d6c47e270156c2e87c.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: Fix for GPU reset being blocked by KIQ I/O.
From: Philipp Stanner <phasta@mailbox.org>
To: Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Christian.Koenig@amd.com, Emily.Deng@amd.com, 
 Victor.Zhao@amd.com, Felix.Kuehling@amd.com, phasta@kernel.org,
 Qing.Ma@amd.com,  HaiJun.Chang@amd.com
Date: Thu, 25 Sep 2025 13:55:10 +0200
In-Reply-To: <20250925094334.2012248-1-Heng.Zhou@amd.com>
References: <20250925094334.2012248-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: gake93o5568gww1ajeibakam4sqwcyoc
X-MBO-RS-ID: 67e313dd2343da49f6c
X-Mailman-Approved-At: Thu, 25 Sep 2025 12:51:53 +0000
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
Reply-To: phasta@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2025-09-25 at 17:43 +0800, Heng Zhou wrote:
> There is some probability that reset workqueue is blocked by KIQ I/O for =
10+ seconds after gpu hangs.
> So we need to add a in_reset check during each KIQ register poll.
>=20
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
> ---

You should create such patches with git format-patch -v2 to create a
version 2 field in the header. And, ideally, provide a small change log
below the three dashes like so:

---
Changes in v2:
  - foo
  - bar
---

JFYI for the future; I guess this patch is fine for now.

Regards,
Philipp

> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 89fc1015d3a6..7f02e36ccc1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1102,6 +1102,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev=
, uint32_t reg, uint32_t xcc_
> =C2=A0
> =C2=A0	might_sleep();
> =C2=A0	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +		if (amdgpu_in_reset(adev))
> +			goto failed_kiq_read;
> +
> =C2=A0		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> =C2=A0		r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> =C2=A0	}
> @@ -1171,6 +1174,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, ui=
nt32_t reg, uint32_t v, uint3
> =C2=A0
> =C2=A0	might_sleep();
> =C2=A0	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +		if (amdgpu_in_reset(adev))
> +			goto failed_kiq_write;
> =C2=A0
> =C2=A0		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> =C2=A0		r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);

