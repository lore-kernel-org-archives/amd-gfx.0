Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D98E77185
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F1810EDCA;
	Thu, 12 Dec 2024 14:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A4YaT6y8";
	dkim-atps=neutral
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F7A10E21B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 11:15:26 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so315415e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734002125; x=1734606925; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
 b=A4YaT6y8MElPomdMlks/fIKVWpGlJi4Xz1tQMIXL/rIqy++ieCVuVo6jG80mJjyCuz
 QVe4aNRa6S4WRjzBn9ZYvqlRbsKfRU21XXmSfaZm6Vp24u6mwTl+pRY9GLbDNRAcvBo8
 CfvRie6W3FzF4DAw8CZ04qpv0FbpUcip+MjZho07+gMISotvOESshmP6o+4qyHBI9aTZ
 laNmfScIOvKInufJ2QvWl46vtFuB80xvvD5CFCrYrs8NwxAhD9+Tc2ZeqKvfjL+YChJz
 rW8ZdvJchi5QcZSDJJ7NSppXpJxyHzehJX8KQyvEBEMmgmoV7f5+nC8mVi5n4XCpUbIU
 TleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734002125; x=1734606925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
 b=pJJ4AfFB4yQZ8lK9u7Np1opr55Gj1pThWa8W7eNWk0QcfSNE90yoPAOmV5V6kjGzCK
 L2/ElNwrar7RU8W3VO+5irMt3hh6MOAsxh+sEYVKKsHFm6ArPGc9EeafG9QtCi5kznOL
 H04YUO0053gCIM2lSSGxZCUIbY3XPXUt/VBdWKxGXdroPfWgMcpUvrPMVmvm0YRQexfn
 A9pS1FfkMWboKICmPzyvD5QePL7dRRIa8Mlfd1DzPNPX7m1JxMvkHIX5ru6oYn8rInXa
 HB6Ez11F+EDckiuS73CdnGhfDbWNf+xVLqSp84kmHkr4jjhWBijUDqweU9h5t2+afGh0
 BhWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyKn2OD1+y3pnVo2dxvXSmKsDUgd2bZa/U0bI/2RbGOlSe5f3YPKlKIj/bZJBnrDhJdojKxJE4@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwviXtjIyC9K6XepyQx+ugq82kY0joyD0fjZTQ1XAOqNCulpq0o
 YKckdVPGkhKOjDQLRo06pVlkETvXRkiUtM4JVHpxotmmBPJUmA6kA7l07+pa/DU=
X-Gm-Gg: ASbGncvHtlIwC30yKTEGc8WZmwqDdsJ4EwapVL1m0Ro6xNCgiCg3GCq48/CT5oVhQJ/
 8Pc/iVypyXZ8HCInrPhRjp13zSaYfvF7zZlyJtBftfgvpRexPRnJFaoLYOGJPtL81D8AI4xaUCE
 MOnKA0Jl04Li7kCLp/Y4SvYzPllbWBjwNdZrArzNLYX78hutAlC2EeNof6T7zGY3KsSK8lQB5FV
 Pd72zqy2d46S6U6Aols5fv4gE0LdNImGcrslERSz/vEY00FJMaGwXmwNuJzgg==
X-Google-Smtp-Source: AGHT+IFp55pQ2gUsjE25dxRL/twFqRaMvKuj65DF74GVH4rT9f29RNfPP5f0avwzyCra7X1h4hezTA==
X-Received: by 2002:a05:6000:471d:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-38787685b4amr2282393f8f.5.1734002124981; 
 Thu, 12 Dec 2024 03:15:24 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256e05f1sm13238445e9.40.2024.12.12.03.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 03:15:24 -0800 (PST)
Date: Thu, 12 Dec 2024 14:15:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Message-ID: <e53e8832-e05d-4d76-839b-ed5ff3b9e999@stanley.mountain>
References: <20241212110808.956179-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212110808.956179-1-srinivasan.shanmugam@amd.com>
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:04:19 +0000
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

Thanks!

regards,
dan carpenter

