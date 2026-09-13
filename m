Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0277BC88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 07:29:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 793A010EBA9;
	Mon, 14 Sep 2026 07:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iCny66GA";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8138010E788
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Sep 2026 00:50:56 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1009983a91.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789260656; x=1789865456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZqrmQnZ68N7oDm3XCrSRrggNkZKtA35ciFNphe4Q48=;
 b=iCny66GAvW2vqeDbJsPpCL9Zf9vhee5sLIEJ3vrk2Bq2ADjv6+A58ObRA1DaY8Zs1j
 5CYob3rXGsOiJ6zwuEk5QEIwOQEhQ9jcsd1SIiDikb7h9PtnQIu5YAsjOAF478s4nRQI
 ayGyWMeKdF+YH6RXjAqZ8ArAgOJVSSkENiMBgkyLrIEYc232T5wrXbwMheOa1S/AhI+i
 cczJYG6IlqzoYibwnXMm4UVT4hHnIRS5QIKhuIUuI7jE51qVkGjD2rYJH5qVQ/AfbQXa
 caT7W00aljVd9z3w6nGxfd4VNSoEkCTinwLKVqiNzzvaE5dIGT7o0JS2SecyMTRKB8Cb
 1RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789260656; x=1789865456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZqrmQnZ68N7oDm3XCrSRrggNkZKtA35ciFNphe4Q48=;
 b=Cqngbq2bYk7hyuZTngSsjKk2wgRQuS/GrL0KB6O75KAih9ZRphQsAQ8IlCoRDJMlR1
 B7kG7FflcMmhurymlF5m8bCWKpGMOAAt7WHHc9e+GwOFRqqYJ3uXeI7mufryRzf1ssUx
 96Y78c1btn01MZXG495qj6L4hwAnf4T/2xVVQavypfvgc0bC5Mqo31AkPneVTkgGJStO
 laZf7eKIElUuIbj/B4NU9sjaEESXA/UUVu7VfkZybpoIJjCmG1ZMMXAlVc4I0MHidzLk
 c5SbmFhEcfn56q4JSuuJKjDnwnG2CXlVI5pIchCEyCP/d+XtJ5R7dV9iw+fAGu5WFM0a
 oD6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0CcAA8k1SwDttn+JXYx6soeVjmFSOzdQ5ygDpwpmd5H3xvF0x1cdbZYC/YB5XichcA9duvGT5@lists.freedesktop.org
X-Gm-Message-State: AFuF++m7sbisBKJwL4++27kef5Fb+7fHI7fKeHbWGhcedwjx/IMXq9X2
 bcV1OdCO/uCAwr+mC6k8bE9WsFPTRz4cYHBXfKd4fYuEcSTiqPdFme0=
X-Gm-Gg: AYBFou1ArxvDaQIFBT+8Yd6FDGv5WPBptiYd/0b1i1WA3D4JAO20Sm5VOmaIZOUAwBS
 0fnXoIkEF8ob6a/Mt2Wmc42nVQ4k4j5rPI6pK5WNYH4hBpGDbMEN8Bxr1EiGjeaA637sjtV7GeH
 6xby3ck6DJqmfxouDPrI8CrS/R07smjss6U1Gu9pKrnkOIR6uWyUFimZM1J9c/6X8g18J/INn83
 zkamfYNJpNZALYAn3yz232oQGzatKJrBQ1Y0Xv9MrBKXQzP3y8G76A9+aJ9hTx6OBuoK8yBLNUW
 3kDk0DeZVygcFUq9LzHK4oVuPjvny8AvU/wSwXjwSbLO8P2MnhfKg8ANwYCdpkfZgqkstdyJzzh
 6VQ7cir7iftH8nO1eQ4wbLXZjIWXyAmpUAgjndJDn/fHYg2o7Ift051ED3tQyNV1vQlxuBwzBJ1
 KDaDztPayzWnaueMq/R3KN88V+WRA16MyljN0WUOU933xu4Ykvd9AYf1JaQONKKnFA5EVVePf7T
 xpIC/PYs6trtueiMvXOSVUbSTwa8vTPMMdX
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39d9c3a1fc2mr20056368a91.24.1789260655987; 
 Sat, 12 Sep 2026 17:50:55 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.205.210.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm15820897c88.10.2026.09.12.17.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 17:50:55 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org,
 atharvatiwarilinuxdev@gmail.com, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, linux-kernel@vger.kernel.org, simona@ffwll.ch
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
Date: Sat, 12 Sep 2026 20:50:48 -0400
Message-ID: <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
References: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 07:29:45 +0000
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

> Applied.  Thanks!

Hey, so im the author of the original patch:

https://github.com/t2linux/wiki/issues/743#issuecomment-5347204171

The author of the patch mentions this:
> Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi post-init implementation for 0218. Retain the revision restriction for
> 0218 and the revision-independent 0219 match from Atharva's proposal.

So as the main developer of the patch, i would like you to remove this patch,
as it dosent give me credit, and also this is not the solution to this problem
as i have mentioned here:

https://github.com/t2linux/wiki/issues/743#issuecomment-5608044095

thanks
