Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA132C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD5C20707
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="su92Psz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7786E2DC;
	Thu, 25 Jun 2020 17:14:42 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C4F6E042;
 Thu, 25 Jun 2020 16:56:25 +0000 (UTC)
Received: by mail-lj1-x243.google.com with SMTP id t25so2736870lji.12;
 Thu, 25 Jun 2020 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=0kEW4FUMP8gt2vgN7gdapk4+2lvhVO5y/7YY3LT5gus=;
 b=su92Psz+lpCbzJeuoCiRMc152apsXyZ1LjpRXCdjjAvnrvYQhlPecj6k4ivQ4jWun4
 mYgYD9ZVqbb9M09vLNRWAlXtry6/5dO6ZkQNIzs07dY0tLy3Cn1CAqPzQwMfkKghCH+/
 pBrpXceZzWb0WQetcGk/G3FatciADmzeR3qq71jFt5fsuPwsdPDu/t36TPSUT42S+oNf
 Cmqs7qH+hKseTwi2qGYqmMlU8QkIrtdNTY0R5pVHsTUe2Ezin7xWxkxZPXurJruqy3gW
 L5SQhsba4Kr3JzpCNDSrNErzOePxL8IEuW28Iy5zL3gGyez4jW1PSGofBBOSItRb1Z3U
 6N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=0kEW4FUMP8gt2vgN7gdapk4+2lvhVO5y/7YY3LT5gus=;
 b=CVs/rgXuX6emWLtVylSEQlpB5P/CGxL+HbnvB/ahEY1uzaid3gBxnVmnYZ3EbsLvt4
 NWCWTwx39s4+5FLgDFExTqKrfj+cV7pnHBKFntOCJGpkXdhQUj3QEdBLuddFXCuhbOfx
 7iRTSutZTwCmmP22mQtlT9sDejlIVHe1q2B8AOB9dsdKVrmyd3NFApeYlpBwqZGH6gW9
 5WYupzRSJBTZL+wsDmS1XzdQTN6DXcaaA+HpBkpcIbtmdhQIUKk1XfUrjAA95YV/qg5E
 1AFkTV/PSH82TY4ztlNmpLI5mQM6BncSnElY0hL3gyr/0rJtU9ez693MOYn6tCjSR6cE
 hE9g==
X-Gm-Message-State: AOAM532uMnWJQZeoy9042rUA0CXcOZfmUBd4mOSRI3pgrFTLbdGhyX7i
 vdeHK7zg9mwBlMLG+/1xO5hE96ycErU=
X-Google-Smtp-Source: ABdhPJyL+P6WaNLjzNEOxclDJJRC5dfG5zUMEyFazPEs5YNY1uXRah1xiPoWtO4JE2YP+GH9wOI57w==
X-Received: by 2002:a2e:7f0f:: with SMTP id a15mr5390539ljd.80.1593104184195; 
 Thu, 25 Jun 2020 09:56:24 -0700 (PDT)
Received: from im-mac (pool-109-191-188-200.is74.ru. [109.191.188.200])
 by smtp.gmail.com with ESMTPSA id 193sm7075975lfa.90.2020.06.25.09.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 09:56:23 -0700 (PDT)
Message-ID: <779b5021239b3713c5f5c0b32a06ff8b132056c6.camel@gmail.com>
Subject: Re: [PATCH v1] drm/amd/powerplay: Fix NULL dereference in
 lock_bus() on Vega20 w/o RAS
From: Ivan Mironov <mironov.ivan@gmail.com>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 25 Jun 2020 21:56:21 +0500
In-Reply-To: <20200625165042.13708-1-mironov.ivan@gmail.com>
References: <20200625165042.13708-1-mironov.ivan@gmail.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 25 Jun 2020 17:14:40 +0000
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bjorn Nostvold <bjorn.nostvold@gmail.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue still reproduces on latest 5.8.0-rc2+
(8be3a53e18e0e1a98f288f6c7f5e9da3adbe9c49).

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
