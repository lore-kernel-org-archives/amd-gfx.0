Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8D6C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 08:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C7010E53D;
	Tue, 22 Apr 2025 08:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kVQ0bQ4l";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D80510E044
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 02:49:20 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso39990775e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745290159; x=1745894959; darn=lists.freedesktop.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5w5RFyx5Fde3sjleuIUHKTkCI9P3qZB2/QHcS9ihhf8=;
 b=kVQ0bQ4lHQ5hE3Bqg2iMcytP2vqcs10ycGE9PEWuuGkUnxve9GFH8AvErzbhFrmfUl
 PjsDWP9SwX5x/dPiRKk49XlyUDjSh3jnchy6ZKtlhhTLy+CTDFBcovpfYGBQwkLeasxr
 Tw/nA42wauvXsiSBZE7ALf1AXZ2E3FXSSA0kdWP7WEJv5m4Bkj5G3+8b5iWOpluQ607Q
 CnE2zBRD9i8OkyFaUuPLYt32jtgXnnb5Syvuo0nys6YFO5ETFJG/IhRdhDSAU96Ub8sl
 NlncGkLXhnrPW+igdNhtatC/fLCGgwA5lg0GNxnLTe8knDo/duIWgHbLu+iEEwD8uVmR
 mzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745290159; x=1745894959;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5w5RFyx5Fde3sjleuIUHKTkCI9P3qZB2/QHcS9ihhf8=;
 b=fjCpobU38XnumsajyD2oVvSAPCqESGFQvCorbX5f/CHdb13KOLzHKskfIrNAJgue/h
 4stRlzuE1kZ11kEf/MRNZwdIlCZvNN8OPOXnyU+mSeoUy27kSAk3WlS//zduHeLPT2zz
 TTqSFP0Vrjota+fAEndc+LRGtmmFgnCfn27noJM7rm9I9mmZ0wouX6Svr95mPONNJOLy
 678faRm7tYfxkITOSFWHi+S2q7ZcfPsHdPzpJFxRzx27zrnHNezMArVBGjNVifjINQYO
 /B4YKDr/M0iMDkLkrsrzC4bpGc9EyMYj5EnxAgMIfwmdxjZCU3O9hXk6NoNnznpGBWrv
 aNTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3yUIaOVwW2GJ7MgVH2RySUc7Qg8IUDdEhMnjLKsp3eiCDzvzfKV5d2Ki9ANPkgf77FzyX5xFP@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp8+vCyVOGE33ZfA28y3UTq9hbmO9/GB3QECJOJ5UGJ8a2/HHz
 H5inN6sXyRwuM1JJarfv5Hg73cacflWvs4qUb6a0bRl2gyxPvK7AKIR8uw37/j8=
X-Gm-Gg: ASbGncvYRGGlef82hIYlsHFNx5aDxy0XjGjjja9tNktDKLqPfXWU85FHFxnLYyiqtXL
 zfeWzuuEaz1EBuSyAJjy1kHcDfeTqhwcWUzrE7VnJnsb6JGy1HSXGsCv5bTdmIYDwGy7PyLk0k8
 rxPYxddwPHfpRNLBxlKuKdx3+eP9jWjzasDSABoT+6CVswS3BvEHoC0763pouZYkXuTlZi5l9x9
 ii7brvatZi2BlbEFjP5qHwAtGDKc+J4O5aOvGhptOIdsAAspvzOO1Oh32VVRQLJZERTOPkUrGC/
 eePeQBdSQwF88loHRcPf+10jWoIJUb0ZDnJbeu5irIcvOCScqyo=
X-Google-Smtp-Source: AGHT+IFHOUnGuFF7OKg26doAxP8+/Wmt3TKEqsEMokxQaF5Gq9QsD+XTtQwXLVRgj0GoP+lTjP1sNg==
X-Received: by 2002:a05:600c:4e8f:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-4406ab66eb4mr131770005e9.2.1745290158755; 
 Mon, 21 Apr 2025 19:49:18 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9e50sm156862795e9.6.2025.04.21.19.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 19:49:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 03:49:17 +0100
Message-Id: <D9CTQ5P0YSCF.2802I0W1M4AWM@linaro.org>
Subject: Re: [REGRESSION] amdgpu: async system error exception from
 hdp_v5_0_flush_hdp()
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <frank.min@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Cc: <stable@vger.kernel.org>, <david.belanger@amd.com>,
 <peter.chen@cixtech.com>, <cix-kernel-upstream@cixtech.com>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <1567c4e7-fd5c-42d4-8278-e1bba2ce46cc@amd.com>
In-Reply-To: <1567c4e7-fd5c-42d4-8278-e1bba2ce46cc@amd.com>
X-Mailman-Approved-At: Tue, 22 Apr 2025 08:15:48 +0000
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

On Wed Apr 16, 2025 at 12:44 PM BST, Christian K=C3=B6nig wrote:
> Am 15.04.25 um 20:28 schrieb Alexey Klimov:
>> #regzbot introduced: v6.12..v6.13
>>
>> I use RX6600 on arm64 Orion o6 board and it seems that amdgpu is broken =
on recent kernels, fails on boot:
>
> Well in general we already had tons of problems with low end ARM64 boards=
. So first question of all is that board SBSA certified?

Yeah, I can imagine.
I can't find any info about SBSA cartification for that board hence I'd say=
 that
state is unknown, hence most likely "no". At least that's what I think.
It is a good question for cix or cixtech.com-based emails.

They have some updated potentially unstable UEFI firmwares to test though.

> If not then the chances of that board actually working correctly are very=
 low unfortunately.
>
>> [drm] amdgpu: 7886M of GTT memory ready.
>> [drm] GART: num cpu pages 131072, num gpu pages 131072
>> SError Interrupt on CPU11, code 0x00000000be000011 -- SError
>
> Any idea what that error code means?

Well, current thinking process that it means:
-- bits 31:26 system error interrupt;
-- bit 25 indicates that it was 32-bit instruction;
-- 0x11 in lsb is probably implementation-defined which can
be anything like bus errors, parity, access violations, etc

That's probably not very helping here.

Best regards,
Alexey
