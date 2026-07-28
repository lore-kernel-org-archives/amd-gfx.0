Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9B4C53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 13:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E5310EC2D;
	Wed, 29 Jul 2026 13:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VIc3ShEx";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C3910E613
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 23:58:02 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so225050f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785283081; x=1785887881; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bOUbbFg/a14VH9bvxbiGt1NTV24v6cj7Q7Pwvkj6HI8=;
 b=VIc3ShExTrEwY7BrTfP9bEyimdwaP0LBRnEEE3oPnJNuzjxCQMso6Q0GS/2Oq2qSDU
 7Ej1/FUOJzxcYIgNoidQRsb51QxbihMUDK5FwYg880Llvep45Vwc/vTHUG/KqW4xmQRI
 jvG9+ksvJUoWBxsvl+aNZT5LMz/Rmm6IxzcNmgwrb/BrjX46QQcNJp0hY3so4TyRpwdM
 ppsDH/3JndMlmxVsiRME0f7T/9yrLsrVan58pazsdK04qkdXu1pLrltqLtzCtPL1Ty/S
 lP6gthuh9fw+Nqh+tqyiVdj1efw9LRhm0WfmyuXuiIeb3xvPp1vvWjZTta4/GPxgElYd
 dHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785283081; x=1785887881;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOUbbFg/a14VH9bvxbiGt1NTV24v6cj7Q7Pwvkj6HI8=;
 b=CrEoMmRzuSLHNcZSm6ZC2zD6irgFMR9cRe6sxIFPmF+AP5vPJ17qTw3e5LgmUl7e3b
 XfOohHAil2cMjDi09PEzv4UGRZSefuF8cye663Z4RvM0g1q8im69+CBm7TzmJwnedNrx
 NjGVH/gLCSbHRniRSRHK/AYrgOfT4EIXWN6B18brPL53frIlFQC7O/aFXU5FPd5Crr8O
 XqchJG8sKwKQ7kBQ/x5BBXWRejUvmZFacO4OchXu8zmj6OKzv+SPWrIzeqbyWG7RpPSN
 zn44gu4HuCw8/5x2uga9rK04n0aLOviFadqAayqfUVQAI9+f8EF7cHAsJqPTLNVADrAb
 nqgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpl1rZe+4KhHvIHv7gPkTOBpzsd6l3GLY9LfIU6onMVpVu2Paul6n73EjLZ8YTi+yc3WGNGbCDT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyM+1bkJQL9dDTHslCjG1tI95TbXjzHIab3yKEsc2ZJ5sjkMGml
 X9V7WLa2cMV+6Q7JbOkmLDBEy1exGhuo0Xud0cjRcc1OARJDzUMPrBlG
X-Gm-Gg: AR+sD11qkl5zqxFZF+XMGuyc/1HXVvKC75wf7CAkNGKxpK3yPlS0IY6W4Lbyng3lpz4
 05uTo2uRvoCqJ2nm7Qgn/kqh+ipw7O94RBanxGdY5GsfmiGF2XJJ/embZ7OWjp1Y0c345E/LXGu
 7WyL5t4z+OYwHpNe87WldF0ggXiBOlcWQT0nlrPkFswMFuCBBy54sulFQLpd/yP/uXbUpEgKMVp
 vFiyJtVvZKY2t66mKhDUZAMHLxhORnphhS8sIaCPTBBBo830dSy7YIDs7Joj7zSqxzQoX1Ze+cz
 HUo5BQi7Myc85uOvclKVeTAUCPZxDPzCESdt7QxMXj3OfflDNB1Ifd+loXQVCO/V5nT1OWKPO9l
 CL63515gxkfJXbk933qGAHBg+y6LMTxd7hkd7YQNnbK9YjcIWfiecdJtLnj96kKnxR3JWptcDxS
 /7YMHZqcf7dpqVN6prqHP81j9La2flXGu6tCXPA8cm3/1y99voBT8VstDW+OxsFCvd
X-Received: by 2002:a05:6000:4285:b0:46d:9871:1a44 with SMTP id
 ffacd0b85a97d-47fb1f13c2cmr4979291f8f.32.1785283080521; 
 Tue, 28 Jul 2026 16:58:00 -0700 (PDT)
Received: from localhost ([193.30.163.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f039sm3079471f8f.18.2026.07.28.16.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 16:58:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 01:57:59 +0200
Message-Id: <DKAM18ABX9IX.2G6Q8UZZHXZJ1@gmail.com>
To: "Fangzhi Zuo" <jerry.zuo@amd.com>, <timo.proemer04@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
From: =?utf-8?q?Timo_Pr=C3=B6mer?= <timo.proemer04@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
 <20260713194945.2AFE11F00A3A@smtp.kernel.org>
 <20260727213305.810014-1-jerry.zuo@amd.com>
In-Reply-To: <20260727213305.810014-1-jerry.zuo@amd.com>
X-Mailman-Approved-At: Wed, 29 Jul 2026 13:16:19 +0000
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

Hi Jerry,

Thank you for the response.

I see that the patch you referenced was already released with rc4.
I tested my use case with that release and the EDID is read correctly now,
so I believe my patch can be dropped.

This is my very first interaction with the kernel process,
so I am sure the released patch handles things
much better than my attempt anyway!

Thank you for your time,
Timo
