Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828C0C79FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 08:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED92F10E4E9;
	Tue,  8 Sep 2026 08:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ofd3AreN";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AF710E356
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 08:42:33 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso41801795e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788856951; x=1789461751; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=okyy8wBIYqLr3XCR+DJBWuL6CMZiWXhgfPD/oqOvsyk=;
 b=Ofd3AreNvbXKRITqOkAIl11ZKqtSeC1lMBlpcRc3UQD+SQvmrjOAfKDct6GFjxFhxr
 qvfSyJqu/MFa86FdJ4zwt4ypPWBAt0+HGkyEXGbC/ogWKWy9NfWkx27iok92/cJt2Nqo
 Gg/GiDnKsDjJeO2NAGP2MUGbUWVJRRvYA/nNkZS1qpQgB7B2Zg3pguYOPNmbTQ/E+Yjs
 N91WKnOSEhx2E4hOe7SGHzPz7ecCL7q1GyMfaQzagkfV3M2fjtOT4FEuMqr7o+H75u5q
 V9yc8R+EoFY0gLWpfBreF/STAjq8ARZQyBGJKi4ZDSn/a8yJzP0nLz3sIkxMNN01qOuV
 GRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788856951; x=1789461751;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=okyy8wBIYqLr3XCR+DJBWuL6CMZiWXhgfPD/oqOvsyk=;
 b=f83xWILSGwjeWKXpyAfIO4vOuhYoxluX9p4oZCingrO0Bao7SY4COK+og26BMsg5Se
 dLaGvbfcDTJnnlMdaBOgy5b7wzxCT2tZ4OUUojyuVVropElUSHfNQH0vQIWVqd2qOcWh
 CtvOrMGSO1cz77NzZxaRmZZ3SQs9+MBwClvaa3ZLJQwQugAsRNgDkb+UOoHd6TXIxAUD
 tteXXjNbb7+h5lcN3fFSvwvrHoNXLyEFLMPg8gV+ZEmIAMLt9OvgCRasvsiR6gXnr4gi
 AAlaO1GXYjV+NFyhi0thKFH5bhO1iY/yApckmO/Rp8YCvyNRU0ksW0Z6FuomlFNrOIAk
 EDBg==
X-Gm-Message-State: AFuF++kQAqSwd67NhtWe/d14F7weOl1uIbl2KG0r8xyjCxe2MjzVbdFC
 RZeTGy5qb74rlwYLzjEvyALhkTubXAO6N5C7BI+h1BILp6l+VK55t2ooWwtv1X+w
X-Gm-Gg: AYBFou2vY4WwlJjIHOGpCb1ZIA8rSvYyA9BjH3DJFFE3SoV3nIElZ4K2pyVUatVhp/W
 uCFWnHgfjpLUdJ4wXydjtINoC3p3EAMSY4Kq4rZZqA/deBJNiPQ9nT24AXXGLp4kALafy/sbGz6
 zlP98SilTqoWp7Q/o/3aQKjDDQp1qc4tsotAikfn8HmUe7Hk8dCdp8gGWOAcbt0DEwZENF6NNZ0
 qYvuACqELeIA2/scJNIRPqllhgSEIS26qHvdv5q+NCt5oTY4nqLJpM9ecJYgk00F+YsCKqLBk4q
 wAvyGl6mRcEWRUtmzNjPlhCHmmmRnkj2hw52Cu5kIkbPWq6b9uyiSmpdjeTZ9AKTRDELCgLoc2l
 vbgm0mDbYsi7D3A4NdLQ00QCwjQ8uqoOHSHiaP2Cke/jTPnSfqG91dK5dOPbGVKpAZcopiMXLnI
 8dX/pTWZkEZr6v+bbV6Ab2GszrLVeVr3RUhF1H4fQeMftkJUvn48zNNHgvGg38Sjaxm3lZU80AO
 f/+ubpoT3Y7kYUtUw9EYUBjwdWsEssq
X-Received: by 2002:a05:600c:3544:b0:49c:f5c0:aa79 with SMTP id
 5b1f17b1804b1-49cf8244bd0mr278760355e9.9.1788856951458; 
 Tue, 08 Sep 2026 01:42:31 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm538207635e9.13.2026.09.08.01.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:42:27 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [RFC 1/2] drm/amdgpu: Store SDMA instance and index in the ring
Date: Tue, 08 Sep 2026 10:42:19 +0200
Message-ID: <15g9zLryTPO4j32E_pIEBQ@gmail.com>
In-Reply-To: <20260622143649.54632-2-tvrtko.ursulin@igalia.com>
References: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
 <20260622143649.54632-2-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAnius 22., h=C3=A9tf=C5=91 16:36:48 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Instead of searching for the matching SDMA instance inside many of the
> SDMA ring vfuncs, lets just cache the instance and index in the new SDMA
> specific section of struct amdgpu_ring. This converts a function call plus
> array walks to a direct lookup.

AFAIK, the rings already have the IP block instance ID in the "me" field. S=
o=20
this could be simplified by using that. For example like this:
https://pastebin.com/raw/jp4Uk2sE

>=20
> While at it, we also consolidate the initialization side with a new
> amdgpu_sdma_ring_init() helper.

Can you move that part to a separate commit?

Best regards,
Timur



