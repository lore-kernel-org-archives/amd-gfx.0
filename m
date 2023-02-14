Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17BCC05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 10:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A1610E85C;
	Tue, 14 Feb 2023 10:24:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0F110E85C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676370239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yC5rgzrpSV/CC6ccMz9kvwcqmt3ccy8YJeIQS3ORBOg=;
 b=X8JProS6g50UWnXUiNeg/I7hTYpzn2oO3RKdOW7upIMQ2wTE28Xaa0R4RR+QjzF1H4MH75
 lS78nZAuxA01q2Um+JRfnntLu9ZITvpoZNbOBUu+6T1NmxGM9BMg4nnpNlz2oyUP8K/z9D
 6yJv0Gditz5JAs45mbOcPyo8nzJQpMo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-CqOIy8EXOEGfhg-CKo5fqA-1; Tue, 14 Feb 2023 05:23:58 -0500
X-MC-Unique: CqOIy8EXOEGfhg-CKo5fqA-1
Received: by mail-wm1-f72.google.com with SMTP id
 bd21-20020a05600c1f1500b003dc5cb10dcfso7558495wmb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 02:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yC5rgzrpSV/CC6ccMz9kvwcqmt3ccy8YJeIQS3ORBOg=;
 b=wrTCnR/UV/G4azDnkXl1rkloUkxAhthncOejjbcujw3Y9I/PQw3INLpEbk+beNHSTy
 wzh85zbIv/exbsq633vjVzi9AYtF57HY+sCvjPWjaYAb62plSkDY2x/qTcbbSUnB4Cmq
 A0eSDMaHf7oWobQ6WmhElc6vWNwSsyALpgAUJa/GbVKTNSGQTkEziXsI8M483ofqFnq7
 wBYunjn7aaNoDtFXJPnSvpGYdrPM5gRxZ2UEfQFknxahCJCLXP6TjFrGkUJMsaPWxSqr
 PIIsT8IwQvdmew+YEzvpYwnSICsMc68Ub/XZhXZnNH+iXA3ekcObWjGDDUrwVWzN6N6S
 uENg==
X-Gm-Message-State: AO0yUKXezdyC7IMGqrWDk2ab6b/KT1o/3g4TfJ7+nQrdYwOoFDGix9rD
 HChFIguXdofVjS1b7i6CjiKoZmv9XF5qUU+DH1NMVm3XNVBQaZQnGjG69WMad0Z/xbrBorrWXUT
 WBoZcBqFWGsHM2vhetoukFo5+ay56YQU=
X-Received: by 2002:a05:600c:44c8:b0:3df:e659:f9d9 with SMTP id
 f8-20020a05600c44c800b003dfe659f9d9mr1406294wmo.34.1676370236944; 
 Tue, 14 Feb 2023 02:23:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8SWmU0JcygTGNnHi4hle8KypTLIbJ2Xu6VlXTzuyDGKAn4t+/PHQFWFC0KxllkbkxVEIu70A==
X-Received: by 2002:a05:600c:44c8:b0:3df:e659:f9d9 with SMTP id
 f8-20020a05600c44c800b003dfe659f9d9mr1406287wmo.34.1676370236816; 
 Tue, 14 Feb 2023 02:23:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e?
 ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a5d5409000000b002c558228b6dsm5287846wrv.12.2023.02.14.02.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Feb 2023 02:23:56 -0800 (PST)
Message-ID: <b7438a7d-0166-54e8-5e9b-01bb7d35f3e7@redhat.com>
Date: Tue, 14 Feb 2023 11:23:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amd/amdgpu: fix warining during suspend
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230213105224.55662-1-Jack.Xiao@amd.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20230213105224.55662-1-Jack.Xiao@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13/02/2023 11:52, Jack Xiao wrote:
> Freeing memory was warned during suspend.
> Move the self test out of suspend.

Thanks a lot, this fixes the following warning during suspend/resume on 
v6.2-rc8

WARNING: CPU: 2 PID: 3980 at 
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:425 
amdgpu_bo_free_kernel+0xf5/0x110 [amdgpu]

Tested-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

