Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF3C44503
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEFF10E5EC;
	Wed,  8 Jul 2026 13:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="HqaPy0z3";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2930D10EFFC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 06:23:27 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5aebfa21c62so354334e87.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 23:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783491805; cv=none;
 d=google.com; s=arc-20260327;
 b=JH2ZRNTgETNGYKLCR2uUKsvYBC+uG00jzu7QsxPKxP5mTd1/bmsZD9sc58so1AKeMK
 30qzvh9xHNBk+FO5tCuXQnUklvSjPQ2gP6uqpFe6eP0eMQZL5v20OIJSsFffs6kQnbiI
 PVi/MTmZsaJeH0nUBewnhav1kw866qjG2jlfcYKFa1y0gYNJGl/0weNXcf0/uEZPS4m2
 3neOtADYELS3wxEwkZZvINbE3I5fNb3+Cmih3fKKD13G9N5Kcnc5xWyAvOZKzqZIYoet
 m2Bc9I+8RhlKv6RIiNTN1fXI0fLkPBzVgwQr9FoXr+n9P/MlFv4NSXpYi9ccxVq7PqdH
 ys2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 fh=VntcOgbegSGBtS0sD75bbYKcJGhrjSd0CPwM4oZp1YQ=;
 b=D99dF9DouML9rJB/DULBd68hGpKGRIP56c8WWGOg0zfHf0GnHlMZBB7WWG2T/UH7vP
 6gWw/Gko9PrzORhdRrut/J/ZjHmokd0x2RLpqVtzTcH3yuSj9n7DwVus0cFncPYByeVL
 zTDQ73dFEZFUw7Xr7RDykfDG2XFg8HpOwlhvs4VGYfqGPwMrMe3DSYKeViH2yulIiryy
 qVFD9jVWMiXPw7eu/6aaTFmHIS5vLpGnviYSDmC8yXRctR5I23OIqARuQZm6vPksEmwk
 6Hw1v5yeXSZN7H9YY9vJrQxdgFnweZjw9d0/IyeK9F3p2+vPNUNTXxkFidFdDUkZyqjV
 eOzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783491805; x=1784096605; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 b=HqaPy0z3L41MHnGdaeMOCyAioRN31Y4eIKGJlLAG22r1ZqcUCjIVHumFd8jp7ddT+/
 kGIn/IHUTj+99bipqc6I9CiPDUcRdlI8NWcrBqMoESbALqQU2n0Pa5OL3XN0JRNUAimD
 Q+qyFjqKcZ1aA8f/oWluNzFZ6CQ+JnwPMYn5o9BEFgi5lOkQwlZr7zeTCOrkWZ6rXZ+w
 c2Rv+Uv7EW6n4TLffM7HsCke5FBAJaEtP0KJRaWIjJMUcSDm91gCQxHN5CX+ITJ+Nh1q
 kwSJLX5y3tcyQbajB/rtz09IcN+Kc9jrotKdYAjm+azjf3G8Z/o3O8ZB2t2FL0krZ6D6
 Zxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491805; x=1784096605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mrsdnvD8wyDjJzaLu44gItX8Fn98lAu0yzczJuLApQ=;
 b=AoEZUdVj6JmIHrAfnxORKre+Lj4WDDWqBIpvEqhPgsmSf5t124ks3fxoxHQ0/VLRQw
 QXoB3lIHzJfxuIORcJRkieDocimcrwdfRYfGJpdfcpPUULxvB07I++yhLK1Rv7Uu4D4g
 9B9zogXAPET7gu7o1qOl0TyxR8TG2hbhNlpfNRNQAcdXvY9Ai1FEe9ZsNA4wbiquWaln
 6g7XzS2B9D+OYOEugIBtmrQ0N7ZXkglfuN95odhKSitGzHh6Fq+B72tvMiTnstyEYkX9
 Y/tgVdtgP1vBfgPx1+fNuOrvZCPtQnt1JBT4nr0N8wMXATM77wX8OtGva47xBLie603v
 8nYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxmSxwT2SPLjPeILmMiIBgfDA8UkJpkc8ejroPD8XU6pqT1cDA0EFLLmKqulUhtyKYApWtu9we@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaZ6GMt0tbicWK7IyCBWbjD13sb8dAKrOBV/O6m+u1dxNHbB+a
 Wxwkm1TXXLcEPnZ4kloRId76XaqXP+WgGiATeG6XTOQAGX24lZU0yJsEik/+m3CvmOjQYYWWNj1
 6lPEF+TTP8aF49vxtZy+tKt0Qqvk1+koI8Saf1icOgg==
X-Gm-Gg: AfdE7cnlPo4l54GxwTGOfZg73265oJM3Q7a8LnVZ1nQcLM7W+evOCV+cc5gfb+qjd0C
 5HIPCaeJab1g7oLHezgmzWpWLh+vQytNrlMsmVjzSAQ7k3FjMBZIWTV98th9lI5FhercIym1Awx
 pG4LeJ08/4vvWukdyHo5jCROLpnL10LMdlBxT+SZl51mbaAOTj6B29/UNgphX78ARDPcg/wVMIP
 jVeCeZN+otSwClMNVLAoDHjfW6rbGPq+Fkk5/+9Io/RyU6Fy4hgM7w/uszmvLVxLic+ICl8tUkz
 eCiF01Co2impixEAAgMjhFNslx4S2C+KDNsTlBRZ
X-Received: by 2002:a05:6512:838b:b0:5b0:d0d:1f41 with SMTP id
 2adb3069b0e04-5b01145dc07mr247846e87.32.1783491805462; Tue, 07 Jul 2026
 23:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260707093812.109176-1-marco.crivellari@suse.com>
 <12766042.8bMQJbFj6T@timur-max>
 <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
In-Reply-To: <CADnq5_MHa8L9gWutwRKBQQ5QuM=5qd8eJgC8ZYKyBQQ1J9NUZQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 8 Jul 2026 08:23:14 +0200
X-Gm-Features: AVVi8CeJhDw9N0PwmBetZLqNcsqmdLEyWTsa6Ck_ToyKT89sOJoqix71D3z0JWk
Message-ID: <CAAofZF6186ZO2j-pphxxW=Gg1asF03-ZhcW3Z0-kUB=q3_xm3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Ce Sun <cesun102@amd.com>, 
 Tao Zhou <tao.zhou1@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:12:03 +0000
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

On Tue, Jul 7, 2026 at 8:13=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Applied.  Thanks!

Many thanks!

--=20

Marco Crivellari

SUSE Labs
