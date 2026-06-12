Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B96CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 11:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720A10E9EC;
	Fri, 12 Jun 2026 11:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VqNiKrM6";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3124210E9E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:19:50 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so6305485e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781263189; x=1781867989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUBYQs8y+YpTvWT+IOlg3duvADyeg0T0qwE87/OIr7Y=;
 b=VqNiKrM6miowuuyF1wk0WlkEV0zZrHDWmUo3un4KWDUj/a54moOCkSabFHFZyyn56t
 trgw8sy15x1y26Glw2HTTlFu0S0vcBkqBl7o1OSVBqILiGjIcuIMzz2I89B9btNHqLM9
 g6aCeXEchzT5ZgUfxdTo6s1cNigrm26IUEg0BF8Zje4Q6M4LvUb/H1p7Yjdo8FJSjhBO
 wfe22fHyBwbqLkioKXjolMAamHKrEyFd4qVcvrePxjUPDjxSDFPwg8D6vtd7BndaU+0u
 Htt5TkMWZDRIQ1Qo2oO7by8UdvgvkVNfdTFbecBLJPBXV/zNRf24CBJJfBV9IQ9S4T2Q
 DlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781263189; x=1781867989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DUBYQs8y+YpTvWT+IOlg3duvADyeg0T0qwE87/OIr7Y=;
 b=L+rEMd2wDOnJHH74ujsoULxk158vMzsn3Ca+zJgtDDYr0TwprwGDRhY94KFs/NPF5b
 +mlFnhUUDXRs13nTpy9vygisljYWr9QY+dWhq/x9ZfA2o2rJTpV2qanl4TdpUiXiBn1e
 KPb3IjSwrL9g0JQ3/O1IMjLHXbtWjcOSwc/UooUZbLqAp2DoBXZF6s1RW1gKtW/rCS3a
 VU4LNydeH5N6paIyAeW7A/qVRj2i60ZliPs3GLj4z9wCyJWsi7c1zeOyXw6w6hZdx3Zs
 wH2dpyKn7Qvxh0gPrgsX29UM3weRbSrPGNfhK7y37BY354TBINlSdF+SPQ6Zg4eacOJH
 4/tA==
X-Gm-Message-State: AOJu0Yw3F5SIc4dpn0Ro3ZKEQCCS8NIM3LS0u8BAMqghD3HRZtm/uIao
 3kW503L/3Nq8UzA7jzlaFEReqmFv4jz/PVhl3JM+JkhgLIBimVZV1pOR
X-Gm-Gg: Acq92OFtTIXJOfM3jZUGoTlEHo5eLl3q1KwIGbJyN+DgISrZ7P59Ou1PX8uK/5nc+iO
 QJwEmg036TOk7uDeJ0IWGbAKmh7BjBXWh+bgwm0MaLvAMVel7ZcIBJdrepi0PC1o6jIhnn/txOC
 MHD7Ba7ht/4JgRLnyabRzYOBGLJrwdZHYKtzWjNLg3GXUNX6fWZIZcx6rodC7DlLwA8XzqTn7+c
 a+8vw8t8gn8PQgG2cWX3YO5QoosRnPT5Q62kx8Pohr5q+jT0d/YEfcw/oxXe+qS1T3mDYa1J2uN
 XAbz9DeMEIyT/l7cUY/byWn5xXFBDSSfBqZTVVQRWy4gum1Shin7ZuD7alY9fDp53bho+qt1dNJ
 /+igJsWqfsRmhMj0YjfIlbt/v8s1GtUui8yV7XchmmEf+x5xETZqirb6DRcU6BKyV0lLrQTOOnE
 WTJUMAxauov4WqT8YS/uAGevCnzpFj3bY6bo/t/0knM+xF0jzpeDOMMxYZ504p+d7AXS9YoA==
X-Received: by 2002:a05:600c:3b26:b0:491:89c2:bf3e with SMTP id
 5b1f17b1804b1-49189c2bf42mr18239335e9.30.1781263188520; 
 Fri, 12 Jun 2026 04:19:48 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm4935506f8f.9.2026.06.12.04.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:19:47 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Huang, Ray" <Ray.Huang@amd.com>, 
 "Huang, Trigger" <Trigger.Huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Date: Fri, 12 Jun 2026 13:19:45 +0200
Message-ID: <5074099.OV4Wx5bFTl@timur-hyperion>
In-Reply-To: <BL1PR12MB584907E9C1F69772EA27AE91E7182@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20260611055715.1142135-1-Jiqian.Chen@amd.com>
 <2014755.b9uPGUboIS@timur-max>
 <BL1PR12MB584907E9C1F69772EA27AE91E7182@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

Hi,

> > Yes, I think the checks may not be needed or need to be adjusted.
> 
> I am not sure if removing the checks can cause new issues in other APUs or
> dGPUs that don't have this issue. Per our tests, GPUs that use Mode1 don't
> have this issue.
> Is disabling HQD harmless even for GPUs that are not experiencing this
> issue?

It's OK if your patch only addresses the issue on the APU.
We can always revisit it later if/when someone needs this for other GPUs.

I suspect that if anyone were interested in using IP block soft reset on a 
Vega dGPU, then probably they'd find the exact same issue.

Best regards,
Timur


