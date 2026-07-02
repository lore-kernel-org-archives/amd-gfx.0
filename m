Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C95C44500
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 07:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15E910F671;
	Fri,  3 Jul 2026 07:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CKucUvA6";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6091010F52C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 18:50:07 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so17879635e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783018205; x=1783623005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tXG6OHs7oPiK0kfLO0F3MKN7dPnCD1zMj8jc2BcBAJs=;
 b=CKucUvA6Imjqf+hcvHRK8rZyqznXZ5eyq0chs6XuDYtKWY6YMosEILYRp8T24R5MTo
 YY3s6n+jKLfyURLFRF38GTfCRaRTkICijPC3haiN6E/dL+j4PDoH90Nc9KbIr1v7f/Zu
 RwAP2y+CaxQCrovW/hVGiCnObULQgA+QJQAFRW6LYAeTyufVQPJsfonQYjhGty25PYpK
 g4iLgGUSODmv9yRuhora8uKz7c/L1bpc9GQm+Fq0WLB+9ucjVRELAbJqKsb6pAbrBDw+
 08QxWxwK/Yc9gF+EiViX0EUbR87698bGQjnpMDQQLuwvBKp8L1NJwWd1X21n9KZiDos6
 oW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783018205; x=1783623005;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tXG6OHs7oPiK0kfLO0F3MKN7dPnCD1zMj8jc2BcBAJs=;
 b=HYg/XeEII4RUeyv7YFmLEZZ96oAbxrC+89t7cUhwTnE11IlmynGiLIv595yqe7vlAF
 x0Fddc0URHO2kqrEy7lJptp3igQFpeGWgs91o70ghXNnof8RmAgrojmsuqV3w9vnwJUC
 VsYXJ7MpMpzXxXYh5M2r8qi50s5OWFxU1zIvvy9FSDDLG3/gaKw629urFYs8JmZUpNiQ
 x6eU0/yBdWNpzVSNb9ooKEPnkTV/R4uaBOd87p5BzSTEG2UR+ajncqkwZUUtQmAUIt/7
 XIl19jDPC5RHkxnnHrpIoEUOeicSXrL0XFLGbIT0NoBmMtv4virNkLKo8XYOfGPQGqT2
 85/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TGs1vj+xxZZmeZRMNaH4nNGNHzCISzGlsg1/NoeJUHZXRpuO9RMZVSSaByHAkccCT7HCywRZa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsjxCsgoPMK/4LIyyIxtOkp+OQKvUp9g5cnfIeZsdoTT2o7RMg
 9oK8jSQA0ejeBL8S5uCnrkhl09QCROfkoo7CQyciaPtrAuG2Az7S0EGW
X-Gm-Gg: AfdE7clFdBriDjNAbPl5Uuvyk05yCYHTG0uITJUtB6H3HRU/KKUpm32p8X9X7FJZTdd
 KVuNGIQRlhj0Pm+rrbgsRjXl4MKyzVdYbfYN926wDG7Djxm00u05YzPONUfKc/9ASG/GnGMgquc
 ThwkMgR3CBwYipMASH+B5kyRUvZzFb7kHcc+7fnRhbYOaH/Uff1sv44c0H9d/xJ2NdQkQsVlm/3
 YFUoNsdV9ETHjRf3mq8lzB63c32eRWRo776X6VbQe9w3v1CvKpAtnMQG19rRE1ty2zqBf6RWPia
 br863rafYwrrXZZy368tO0OHm1hQJZDHETfSjvK768pO9BWNPOwnTVu2RgsgSQGiEpX8ePqymyG
 HfIIffOTkkAQUg09P69AHNb7C+HJHJoTlMlcrUcn3VhNjukYrsX7iyaipSzDNo41Jiy5FvghlTn
 tV6RYAW5gL48pvC08nbPeRFHbPMq3rrjFLrEtNJ0FJRbynX8oVzwEWHkSc5NyVJI9Z2YnMVBeYi
 izKnAfeJN2bRHjFS/c=
X-Received: by 2002:a05:600d:844f:20b0:492:5bb6:6d4b with SMTP id
 5b1f17b1804b1-493c3df77eamr74808995e9.34.1783018205423; 
 Thu, 02 Jul 2026 11:50:05 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba3csm10877210f8f.3.2026.07.02.11.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:50:04 -0700 (PDT)
Message-ID: <dc6ec395-ff15-46b0-ad0d-0f173b4d405e@gmail.com>
Date: Thu, 2 Jul 2026 19:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: core: implement rx580 state optimization engine
 and c-to-rust char dev
To: Breno Rodrigues Alves <breno3011alves@gmail.com>,
 alexander.deucher@amd.com, gregkh@linuxfoundation.org, ojeda@kernel.org
Cc: christian.koenig@amd.com, arnd@arndb.de, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260630210445.23103-1-breno3011alves@gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630210445.23103-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:06:48 +0000
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

Hi Breno,

On 6/30/26 22:04, Breno Rodrigues Alves wrote:
> This patch introduces an automated indexed state mechanism to optimize
> VRAM latency and command loops for the Radeon RX 580 architecture.
> Additionally, it provides a converted C-to-Rust sample char driver.
> 
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
> ---
In each revision of your patch, could you include the changelog and
links to previous iterations, here below the ---?

- Julian Braha
