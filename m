Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF036EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7A910E4AD;
	Wed, 21 Jun 2023 15:38:43 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1692410E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 07:38:07 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f901f87195so23626575e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687246686; x=1689838686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f9ygZ7yIAEY2d9d/qVhI0amgeoXNE1mQXne5+wfl6TU=;
 b=o8C35uSrEvqAjtB8BTU84BGAVzv5V27RljnynJG/urSw8gln1nYPSK77wTX/DfGNnh
 ouStvQQoAm1BiMsdV+Pcw+zXRKqAij3IDmt8Q2HNlmCce+Vd2wN3J5Mi6IGHqE+xPtWg
 nOOYbZOkx0WbHbuQbSOwjaw2ahP6qphnFUnPhhoeXvR+6dadq1QF43DKO04T6+2dB6cQ
 k0mmoin7wISe+MjOaA9iwZzcYvE71fIewTAp7lygYvIGJrzta3el1COcgZBVi4pftR6T
 ESnilamv1CcDBMgF5FSmjL3cgZG3cWCLhWHtvKy9G86NjjJ0JURiXbkby373yfvzYOgm
 7Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687246686; x=1689838686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9ygZ7yIAEY2d9d/qVhI0amgeoXNE1mQXne5+wfl6TU=;
 b=KZ3l8cx2ZVtvkSwBTL5Q9r3sXzyOFcHJ3kq40KK8tPn31/c0Jl4WgHg4SKDVT+OQTL
 REfxkH4S2yYJmzOF4D4cdnh8OYxk6ZhqKAH+o3umoMtWoGNYYQKW+Jjo07VC0IafLt3v
 ZlNzHw80HBlTrOEaymWbLFFlUzjaTQo6FUpytB6PIgW0ETEDD1/ZZ2EGTVTPvOAjOyFd
 cLaYnwjR9qDc5xyClc9KnsUEoCkWADC9glaa06D7IhP4XI5UTdBvT4JvmHZcdBlv7Sjz
 T+DGb7f0mU0K1jZuyYHgDvfKwoiyb43In0NACA4hzG87fFg7S215rMdpUojJqfvQu6NH
 TZpA==
X-Gm-Message-State: AC+VfDzlc3p2ZlQm39q9NeWRZ7prQ5h3Q8ZnF4ztJzhm0EzVubYCrjVx
 XaXiRJhyeUYjHXH2qn2wfg6aoA==
X-Google-Smtp-Source: ACHHUZ5FuDhulJo8756eozh0KRopUTsJakAb65F/au8o6bfOt5vQhNQQ7DZNSJsOaDGBmSoV0WMa7w==
X-Received: by 2002:adf:ef10:0:b0:311:ff2:87e4 with SMTP id
 e16-20020adfef10000000b003110ff287e4mr10664853wro.33.1687246686193; 
 Tue, 20 Jun 2023 00:38:06 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 s6-20020adfea86000000b0030ae3a6be5bsm1315337wrm.78.2023.06.20.00.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 00:38:04 -0700 (PDT)
Date: Tue, 20 Jun 2023 10:37:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Message-ID: <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
References: <20230620045919.492128-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620045919.492128-1-suhui@nfschina.com>
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: Jane.Jian@amd.com, Bokun.Zhang@amd.com, David.Francis@amd.com,
 Xinhui.Pan@amd.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 20, 2023 at 12:59:19PM +0800, Su Hui wrote:
> Smatch error:
>     gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:316:49: error:
>     static assertion failed: "amd_sriov_msg_pf2vf_info must be 1 KB"
>     static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
> 

I doubt that moving the struct members around is safe.  This looks like
it's in a very specific order.  So I don't think this patch is correct.

The reason for this false positive this code uses a #pragma to pack the
struct.

#pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed

Sparse does not support this and Smatch uses Sparse as a parser.  The
main reason why Sparse doesn't support this pragma is because Linus
thinks it's gross.  You probably didn't even see the #pragma did you?
And anything you can't see is unreadable by definition.

"Mark the associated types properly packed individually, rather than
use the disgusting "pragma pack()" that should never be used."

https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/

regards,
dan carpenter
