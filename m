Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8500DCD4F5B
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 08:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F137C10E601;
	Thu, 13 Nov 2025 08:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="cLAOA1xj";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75F510E0CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:23:43 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 94FF733F771
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:23:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1762961021; bh=9+zQf/AuWGRSxTZP5IIE+dPc0uwpxiiRW5VchLQjh8Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cLAOA1xjOjmXj3QFn4tKznXfNg7hpeyWYm7a43pEJZrfhBsnWMWOtT8Sf8RTTUuQi
 1zYLD7NJMFSR5s0nQHF9ztdu6JiESfR1MN+2t35W1RyBVRiP8o2YXrvwi7K1cV+tNk
 3Z0dtirbiJ2CzPbHrNyoaFNJ4HUraGNmDQAa4/Bts0ZYPGythcfDp2SmiNzfbG8OXW
 vXCCOP7gDqmfQG10eYYEIE8aefWbVUddshW7nCBv5oGYqnsaZKcctlsSlJR1V4RNTQ
 409XCB8xn4lBpAMhfLfNcs5GbrG6rgGMfI/+cdtnGj74V+ESGgcwBKvZu0VaKYI8Wr
 ysFd9tkc9fuHg==
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so192394566b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 07:23:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwKIoT7j5ZEIozPkQK1yvss/0QIxQoJBhRnVUIcEnJsFchFNVAA
 P/2kFNW5IEZoSjGYbi9M4OqdNasnyEVATdXDZ9xmbn/CRFXK0IBZi8gLnKhUDNCv4W66xEB8LkA
 /uQpybMb9/ylLAK7MUqo3TYALlswe9d4=
X-Google-Smtp-Source: AGHT+IEqSUhcHB9yzt3lWAOifWAVCmWJzXd9fR72pSxiuzeiA6zz2iFZfZ0vI5EWVrqsgz7fN02K33GdkNguZOl/z14=
X-Received: by 2002:a17:907:d644:b0:b72:b7e1:5c90 with SMTP id
 a640c23a62f3a-b7331a838e7mr335564166b.34.1762961021159; Wed, 12 Nov 2025
 07:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20251112151832.77867-1-xaver.hugl@kde.org>
 <20251112151832.77867-3-xaver.hugl@kde.org>
In-Reply-To: <20251112151832.77867-3-xaver.hugl@kde.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Wed, 12 Nov 2025 16:23:29 +0100
X-Gmail-Original-Message-ID: <CAFZQkGwapJxp7uPdiULV-1RnctYp0oDsS2rJ8iN+O-JQpwuOLg@mail.gmail.com>
X-Gm-Features: AWmQ_bkw2gqpOSedb7znZ28oKqgOzGMfWx1QgisgRQ5Rzi9R74GASAMkAR1MPn4
Message-ID: <CAFZQkGwapJxp7uPdiULV-1RnctYp0oDsS2rJ8iN+O-JQpwuOLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm,
 amdgpu: add the "FreeSync HDR Mode" connector property
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 harry.wentland@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:36:11 +0000
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

Note that I've only tested this on a single monitor so far, a Samsung
C49RG9, which is the only one I have that supports FreeSync 2 HDR. It
would be nice if more people could test it; the compositor side of
this is at https://invent.kde.org/plasma/kwin/-/merge_requests/8423

Also worth mentioning is
https://gitlab.freedesktop.org/emersion/libdisplay-info/-/issues/51,
if anyone wants to help out with figuring out the userspace side of
detecting whether or not a given display is actually FreeSync HDR
capable.

- Xaver
