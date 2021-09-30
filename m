Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0CEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8775661528
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 06:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8775661528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A326E2F2;
	Thu, 30 Sep 2021 06:27:41 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C679F6E2F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 06:27:39 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id z2so3691223wmc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=BVkP3sClllm6/H0fnvu6jGa8MYp6ZmEhHC5O8pDdVOI=;
 b=dl5L/eo75AegiK4YRg+/0TSooval8ucvCe2//VtTTCj5keBhg3Wxx7+bbaEKLGYHYt
 CUX5yQAzMouvD4Di22o2B4YW2qFT0Her6W6be5AhAnPL1biHMOEe3pPmCtkEXVMQqbPS
 Rlf2ZX+UeQuJ14KpDeyOUKQ6mjg3ghjBdAQNr8LqvY+8WYW3oKwntI2CTVoh8CLDRDMp
 NcYxLKU04d95gnWTcYqfbeUjnrWUNaB2Xi6uLqvsF7RBXJuuOmw8aXIReFYANJ4cgs72
 aWkwJIMm9TmDpVe67Pl0uUMtf2JiMrJoJIfpJ+BtiWYxEef2xsV6OR5+D6gHvt/sKljm
 Kvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BVkP3sClllm6/H0fnvu6jGa8MYp6ZmEhHC5O8pDdVOI=;
 b=25Fy7iXz4gpIwTlfPW8OsXbnBGuSredp1puYdHmz15xCKmKF0NV9tzF1J97wpFgKVf
 iUj2t68uVv1nO/lC3INi/6rsMBBgl6SkbDpizJI4hih+0cMHG6VzZIhLkVaOqB6NjAzR
 mNrW3dxMsn3xj75p5H/Gf97+bzBMkt/X0sfNtoUnfeMRMpDSdBDO5dGx6f4uWosErxjk
 qCAT+KpNc4+If/7YD7a1ftXT6XBBezFeY9kU+1G3ahGEmNy0s+Z9x+EWqO6XdwflSDQq
 UviuhwFnhZtsbLCfgvleZGe6N6qGk9g4dRXen5RLiu/+A2908Rcg5HlA0B6TovvE4sfv
 LavA==
X-Gm-Message-State: AOAM5332Aq8fyoW68gM77VMNyBGoVvicMTohcbxu95kb/cl1AEbphEzb
 M8IHSQOiEh+POtfsTLpiOBvj2tsKGp0=
X-Google-Smtp-Source: ABdhPJw1Htp420fB3qJNascQSxXF24jZGFFIX/HadNiRizAXM1Yx+zmAGYX9pVdlXVyLdqW82Ynhrg==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr14144596wma.69.1632983258362; 
 Wed, 29 Sep 2021 23:27:38 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id l6sm1892121wrm.64.2021.09.29.23.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 23:27:38 -0700 (PDT)
Subject: Re: [PATCH] Documentation/gpu: remove spurious "+" in amdgpu.rst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210929174509.1640343-1-alexander.deucher@amd.com>
 <20210929174509.1640343-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4a9c8745-f7f7-e924-2af3-e29587dd1463@gmail.com>
Date: Thu, 30 Sep 2021 08:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929174509.1640343-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 29.09.21 um 19:45 schrieb Alex Deucher:
> Not sure why that was there.  Remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   Documentation/gpu/amdgpu.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 364680cdad2e..8ba72e898099 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -300,8 +300,8 @@ pcie_replay_count
>   .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>      :doc: pcie_replay_count
>   
> -+GPU SmartShift Information
> -============================
> +GPU SmartShift Information
> +==========================
>   
>   GPU SmartShift information via sysfs
>   

