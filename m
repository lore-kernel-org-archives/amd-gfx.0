Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D392C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 08:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CE410FFEB;
	Fri, 15 Mar 2024 08:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="dYYTe1XJ";
	dkim-atps=neutral
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C4C10EDE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 17:09:58 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-68f571be9ddso8148496d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710436197; x=1711040997;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wq3tDY8BbJifWyupgIyZpzh/9hWKNCkxl+BfruynXAQ=;
 b=dYYTe1XJU2M6Oz5ItN9uVdmRBCN8g8yCZFLPcCqbUuGVtA9frFsyByCCDSAoKGbypm
 ZVFqw2l32Vqebi0QaRzga3HaYVIBGZB6my60BL1Tb9IsAwqDjUSRVz4Qk1dZoEcdYxk3
 5tV0xm4ldx2CAW8TyMq6sUbagB51Zc6maBXYVDJG42Ci84/PkfnklzWVkugJ2dogsKMh
 4hJhpGOJtXpGwjAEGlRwmdMf4vzPo73n90x8BN9KpuBsQqWxAazFeDxYYWqGPkDLL69y
 cG0Cc6/gojglVk9ONICIXnlai4ZsDBE//wcZBPW35xQyX9krmVA9mqY6s3vqpGUqmlRF
 DTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710436197; x=1711040997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wq3tDY8BbJifWyupgIyZpzh/9hWKNCkxl+BfruynXAQ=;
 b=S2Qveg8Gd9ACu7UktDgmrX/ISgIFD5uvqXgnfd/o17RFU5EyX1LuPGu5VxsvqbQ2RJ
 83L7Po6se+OyFcbZcG6eGX2NVIeQ3jkR9ws1TARZJc+zIZ0i7nxAe565Pc+E+hkuQ3iJ
 weDTFz9GWw2jLp1qq0TyOblkzacEOjMwOSkJ3MjX/n1Y/lJ9LZBg4xrUiTcpNHQt2giD
 g8cG3PeKO1u0YFd423eHGB8COo8p3r2IbZz3gOUCvBvel0prA8GkCEuD4tGaMTyOn/Ka
 5qjqpLH18UbsW+a7ugH3gCYu/O9UKCL3zRBxzDS90M/q7oz0d2+oIF0h2Sz29l4/h80z
 mJsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFUbCKUJq3Q65FoUvVQ535CiGmGAN/tr7lCw/0GqEsEpVqBba5g9x8uTyIU9+zKBRZYezs+9owSuZ0UeSMIV9JUmcL3leQTIqAGfEXbg==
X-Gm-Message-State: AOJu0YyRW1fsBkgLtHy7hEB1nkTFTBZFWK4lbcwYfUOxwNmPHo0wUYyx
 cSpMYtpyOnMpcCC0Aq2ldrT7Vic4y+RQhwmjXmvFLkuUbMHvVW7cgDY0SHFBc8c=
X-Google-Smtp-Source: AGHT+IG9aYKr3SLrUEGgyDZji2FG4IGp3KCRhhwIdIrak8oLuo4wulKWroEURFFbiWSVw95P6gj41A==
X-Received: by 2002:a0c:d989:0:b0:691:6dd8:4606 with SMTP id
 y9-20020a0cd989000000b006916dd84606mr65545qvj.30.1710436197410; 
 Thu, 14 Mar 2024 10:09:57 -0700 (PDT)
Received: from localhost
 (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com.
 [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a056214040a00b00690d951b7d9sm700131qvx.6.2024.03.14.10.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:09:56 -0700 (PDT)
Date: Thu, 14 Mar 2024 13:09:48 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix deadlock while reading mqd from debugfs
Message-ID: <20240314170948.GA581298@cmpxchg.org>
References: <20240307221609.7651-1-hannes@cmpxchg.org>
 <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c411dce6-faaf-46c3-8bb6-8c4db871e598@gmail.com>
X-Mailman-Approved-At: Fri, 15 Mar 2024 08:24:26 +0000
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

Hello,

On Fri, Mar 08, 2024 at 12:32:33PM +0100, Christian König wrote:
> Am 07.03.24 um 23:07 schrieb Johannes Weiner:
> > Lastly I went with an open loop instead of a memcpy() as I wasn't
> > sure if that memory is safe to address a byte at at time.

Shashank pointed out to me in private that byte access would indeed be
safe. However, after actually trying it it won't work because memcpy()
doesn't play nice with mqd being volatile:

/home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c: In function 'amdgpu_debugfs_mqd_read':
/home/hannes/src/linux/linux/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:550:22: warning: passing argument 1 of '__builtin_dynamic_object_size' discards 'volatil' qualifier from pointer target type [-Wdiscarded-qualifiers]
  550 |         memcpy(kbuf, mqd, ring->mqd_size);

So I would propose leaving the patch as-is. Shashank, does that sound
good to you?

(Please keep me CC'd on replies, as I'm not subscribed to the graphics
lists.)

Thanks!
