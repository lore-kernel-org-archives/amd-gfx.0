Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D2EC982F1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8921110E497;
	Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HDTGyZah";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0158710F2DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 10:49:56 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48436686a40so78233f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789728594; x=1790333394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VDT0gosUKlKyUP/LqVdpjlvegUJ6Vvc/r6oZAzPMHB4=;
 b=HDTGyZahx49k0H1xkzd/lubOlEnlkwJZ9n7Ejk0FMjhbr9wi3PEYm9y73pkdgGOYwj
 zCkJkBgau+cnAdpuktFkh2GsPxkIJ9784HegiqFKhXlnwTTDt7x8Xoh42QvTX+1WIM+c
 2K3yTjDRhY5QBe6GcdbceR+BBQsrTAhwgGCwWW/oZH0diBf69zSmQZHlYEQ/aGX7ZJo/
 M7jk/4DWg1UWBQE7KA2s79sRuFWx76/bqx7B2sWriWnsEiLDcXxZVYNgFROVE8O/Nm91
 EIa5XJytg7jH2zxszr1vuFPlsFxtcmMgcVTQnYj1XiiiqeZircS/NiV26iFxu2LdC45D
 e4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728594; x=1790333394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VDT0gosUKlKyUP/LqVdpjlvegUJ6Vvc/r6oZAzPMHB4=;
 b=a2jG19wJFNAOj6lO4Gonf6zGg/l6jqS7f5nnbXgYlqAHcrL/jO2hplevpRJFH4IbGF
 YLXCWThQRKWCiZuESd7WIRGOTTCT/n1TgAFIaIh4HEOqt0PorRj8Va7Dn2XoPesFVQQ6
 A1RenksBfq0MY/4lRdTfyq8x7DlbaxFDOL2ZvZktpvem7GCazVmVTCOGiVMoOeqE8CGa
 kttcANoiSfHL7qQbvC2aDSQD8wCqQ4lcmRoFKhGyaEd1e3+r5eE7qzsm1VZVGC8ZnIcx
 FzqplNvXT3GuLvJEuFRjIjBs5iK+TirSX7Ceuizqu7rrnEd107FINaE+PGWo+NscmGhS
 fBNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ9fx7h+RkRHYOQlG1Zwa56qqukaIA9fckHsciD3jqJnGJHco+rGaT7aXlLY09LUoL8cO0TM0s@lists.freedesktop.org
X-Gm-Message-State: AFuF++mE/t72Psweo2oblNn7cxoXKfiSSX91k6Tdy7YKrNU17A2tJicg
 zbDhuDafqvvUeNwrLOOavfXguGH3vMcYUP5R3AtkZtxLMuTJ/17+LKyg
X-Gm-Gg: AYBFou139ClqAXr8Y4XsVh16B9t/r2R2HAriIOJ/NmASCdSFDFV815wJfKsMdQziJKl
 6KqG0GXSTKvHtfGFW7n3z+G4fIlA3yspwlvGdCdCPL++XNiX/tWlQeeVqnq98rpNbuHRnkbbnkS
 a9R3KMfOiaG2oYHT8fvOfybq7dsVtLix/YaNx2lx2kQHP9ewQGIGv5JZWC0CoahMEG3GKcNKodh
 ToKtUwLmoN3jdNs3ZX005BSxRA+PG/fZRQy0x9McLF1dhk5WWCgPrBoVARDLbgcGPhP5ZX0yaLB
 yIISVMP+ACvMeXKsZ3m5F8KKlsCi/SqgZgmm9ZNrdlUDHhb93TagKVsmxBua/hfnaCmgyz7hOfN
 hq0a3GGQWu3ch3vZHeG6nDCpX+1Rccu87UczxsvV2I6UA16Aan3e1CEtgPh69AkV/n4nVep3qXT
 Yv7DSbPtGoy558rLXyDdJUpiMJVuuHYsP7zpKmu7410b0Lr5O9551sYOIdvo8YChjhK9BRJ3fDA
 BFpMp5HJuJg2+mkWxJhepnMzZjO9OVq6XO9G3zuSIJrpRlCnO51fbgxcGW0MO83CJ5RgfHo9JYR
 KIA=
X-Received: by 2002:a05:600c:a00a:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49fc7b83237mr20725205e9.0.1789728594305; 
 Fri, 18 Sep 2026 03:49:54 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B829B006E521A2A508563A3.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:9b00:6e52:1a2a:5085:63a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3ae1fsm2975686f8f.8.2026.09.18.03.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:49:53 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Lu Yao <yaolu@kylinos.cn>
Cc: Igor Paunovic <royalnet026@gmail.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND] drm/amd/display: fix audio playing speed up on POLARIS12
Date: Fri, 18 Sep 2026 12:49:25 +0200
Message-ID: <20260918104925.33904-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251205074344.143063-1-yaolu@kylinos.cn>
References: <20251205074344.143063-1-yaolu@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
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

Hi Lu Yao,

I hit the same bug on a Polaris10 (RX 580) with a TV at 3840x2160@60
in YCbCr 4:2:0, and your patch was the only fix I could find, thank
you for posting it.

I have sent a patch that fixes the DTO0 module for HDMI 4:2:0 on
DCE 11.2, 11.22 and 12.x, which should cover POLARIS12 too, and
leaves ACR (N/CTS) as it is:

https://lore.kernel.org/r/20260918100443.23694-1-royalnet026@gmail.com

I could only test Polaris10. If you still have the RX550, a test of
that patch on a tree without yours would help a lot.

An LLM helped me draft this mail.

Thanks,
Igor
