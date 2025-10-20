Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7163CCCD1A5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 07:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD2A10E2D2;
	Tue, 21 Oct 2025 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="VUENkVNl";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674DA10E536
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 22:45:46 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7930132f59aso6577632b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1761000346; x=1761605146;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RjA+D2gABjg6fRwb90P8FJ6zI+4eBjJEl6XrYNmNfy8=;
 b=VUENkVNlkFQsimQjkPHUy61tPNF08iBpffUjsfDE7JW90uZ77v8fIYtO/Blfb7R+GF
 5BvwR85KMe2FOev7bSVRmoya+nnCvZMBY7m4LP9XOtiUeLZ2yslDVVfWvy496hAir13W
 PpiQT94I5kDaR8MWgtmlDwZVn1jRZ1+3DPWiOEqpTgLeVa6BS74fvS3Pr0feFLKYGlqL
 So1QWo7ldxbB1iT0YYKapBD4Vifs98ubfd3ZwQYy4wo+dahq0+aW/K53D3vKhoCNKmOn
 cYXjufWjQPvmqebSfAZ2q1hbkTNFoQfATBh6jeIIfU45C7GOxc2zEX5jvmnJMZlgvzwv
 iVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761000346; x=1761605146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjA+D2gABjg6fRwb90P8FJ6zI+4eBjJEl6XrYNmNfy8=;
 b=Y+XceVZ3RlTjwGaN2awJRXWNrUNzTCwz/BWP6UFXe25tFW+GrBIYBAhmjowcEuwsp3
 LTR4RuuVtdgok1Zq5YclJkYYLw9UNBltbuCzgU+BBtCKWdK8RypdYkWWpiJoJU0fZ5F/
 lUhn3H/tbV3QhpG+JaLbk1Xc5I4imtS9tNoJV9P9zYDacZCBcYWgvu5pll2aCA/qplVL
 2jY8gzxm6Q06aCpkM/74yUISjBN2vpib9J+sv9P+re1UJFnLVgKmSnqx7r9Tn61kAfKi
 w3PiirD/aNwR07Iz2E7FnYOE/jQFiNB0h4McSJUVNg84B9+gAxw+VSuFNSqDknzsOWMm
 wjVw==
X-Gm-Message-State: AOJu0Ywl6OOGJfvLyii0bWMCpB3RZJ7n62ywxUTpofHSaQAAnXT2Khf1
 iF/i7LYN1OBX3cDe5v4u8ZxvpqiyJWLuDnGGbq0PKCNGSrzees5eOYRi5OAdSbDjcIcCtBvu1+C
 hwMzIL2U7
X-Gm-Gg: ASbGncuZFNyeJwrI9lqPML1WG1tzGFXONFRVKqn5pZro6194YUlBI/bL+7FlIgKjIk/
 Gqy0FTuusuZ41i9W0an0yHREi/pOixiHdWIhxzL4eW0bWgAMYDwN1ndj+9Fn2EojL1jh6k6pgPw
 3VZxGBvb2zswNwe9Aqz9PSuVS3dt5uyutCNk0MdoEe+AfuqliXPjc2IXDYRF4Jxd+n7YrnMroxI
 q7sDdQUsZLtiHkJg9D/s0oVcplAChDaZ7AKXwut2ujbS2xHOa8GpYnVl5eK95mo6rrxTYBZ3+Iq
 ZTFJu4JPgfjq1Kp+3zpVWj8ycRGyXogxIf9isHrPuR88GPoG/Qiz3mNtN4NwAMjmhsanUSLYlWB
 nTefhVsHDrcVWQE3pE4hPQpu4/VxB6xWUmwBakh2p3fJaqRru74xolUkKfTZLd+NkWYelXJeP1I
 /QqA==
X-Google-Smtp-Source: AGHT+IFMfVbHKDPJ93PraNhiZ4Nmaqe9rmEg5jcKWkWmKkIqhKzyHvYVhl0ZbDOR4Q8R+bGwGNNryw==
X-Received: by 2002:a05:6a00:21c4:b0:772:45ee:9b9e with SMTP id
 d2e1a72fcca58-7a220aa8c36mr15402276b3a.9.1761000345917; 
 Mon, 20 Oct 2025 15:45:45 -0700 (PDT)
Received: from sultan-box ([79.127.217.57]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010e25asm9290207b3a.56.2025.10.20.15.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 15:45:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:45:43 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa7lwfpALpbCmed@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
 <aPa60qtBV5iCiY2I@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPa60qtBV5iCiY2I@sultan-box>
X-Mailman-Approved-At: Tue, 21 Oct 2025 07:12:08 +0000
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

On Mon, Oct 20, 2025 at 03:42:26PM -0700, Sultan Alsawaf wrote:
> On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> > Adjusting the idle handler for DPM0 handling forgot a return statement
> > which causes the system to not be able to enter s0i3.
> > 
> > Add the missing return statement.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> 
> I just noticed that this link doesn't work; it seems like that email of mine
> didn't make it onto the amd-gfx list?

Ouch, looks like none of my emails today are showing up on amd-gfx. :-\

Sultan
