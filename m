Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C5C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 04:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFA010EA0E;
	Wed, 15 Feb 2023 04:29:31 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6339E10EA0E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 04:29:30 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 bv2-20020a0568300d8200b0068dc615ee44so5321489otb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 20:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F63U0ccHgp039e/zBAB3Aozzw1Qp7fWEiTZ+8KrSCTc=;
 b=ETxViDZQKyevvesWQ2B6uHiXXXg6fjqZQyYPdClcAf06cEPgTQXsXI2b/OCPk7ll8u
 IQxzRVm2QreCUsJDbvHaejSIC4XzKaB7dBIvTMjNdhvRo3itE3bsamy2wzlakbTGwXUb
 su6ckolgunkRqJgNngSzMesr5QfPyzR7DGD+izht9epC7sfj7uBRgQgyYy/B4VO0b14y
 CByL2tHvRcZ4mIBwCkHI/af0IV15dm8l16382MfW5E6hdypRtSsVEAMb/QUGRPgdaWc7
 3z0Q5Gt7Rb7aIW90J8tRF5/orijfUld1BWeuQ82EiRlrSGUdmK35i0rAHR6bOETUK3Oo
 bj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F63U0ccHgp039e/zBAB3Aozzw1Qp7fWEiTZ+8KrSCTc=;
 b=NZQXNkvxj4WwlMSi8mGl1/xfkYr+Jjqm8sbOeeWuOmOfZaJj/Y0DKUbpW2l7RS1kk/
 jkLujnt08WJClllnEisVXeJqdL+yo9p3A/ZFpKRXlTAs9gi9kyX3DaCd4yTSLzrJU2lP
 8PCuzclpWS4FL2lucAWaNjt8nlwMpEkNDmjFdrolTYNI+JUfrPFHoU2uRw/Sog2hZGxB
 1Rq8a0hy+YaoY4klXH8gvTV6cb9xqVOMcybcH75BhfpuVMO7tA4Ryx/e5+a/WMeglLxJ
 rgMjZXkCyxMaEY1zYXba5zgNLw/W1C+C9sJo9qxtLE33CWnzKOg40OqHeZpczWHGnZBX
 8REA==
X-Gm-Message-State: AO0yUKV8aSy00GunVPmy/xBQbiwyDhNoh5lQ5ZKxUOp4Ez1xB2/JS/Q2
 pp0mfSATmQ2sGksrU/m/oEGJtB7NOQqaORfNQAUYju1y
X-Google-Smtp-Source: AK7set8IiM/uhjwOsQCyCVZ45hb6RfdWMtReXxQ1RVoQtSerRVRHyN/4IVdl7Szvsx5nIf5VAYyGk5CUHA9+5SwM42o=
X-Received: by 2002:a05:6830:556:b0:68b:ac60:ebbf with SMTP id
 l22-20020a056830055600b0068bac60ebbfmr44513otb.6.1676435369680; Tue, 14 Feb
 2023 20:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20230214064944.54993-1-jsg@jsg.id.au>
In-Reply-To: <20230214064944.54993-1-jsg@jsg.id.au>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Feb 2023 23:29:18 -0500
Message-ID: <CADnq5_PBdc5MoiMBM+yiOO8N9Pic02EiHbx8qG6WxRwuN4tUTw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid unaligned access warnings
To: Jonathan Gray <jsg@jsg.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: sunpeng.li@amd.com, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Feb 14, 2023 at 1:56 AM Jonathan Gray <jsg@jsg.id.au> wrote:
>
> When building on OpenBSD/arm64 with clang 15, unaligned access
> warnings are seen when a union is embedded inside a packed struct.
>
> drm/amd/display/dmub/inc/dmub_cmd.h:941:18: error: field
>   cursor_copy_src within 'struct dmub_rb_cmd_mall' is less aligned than
>   'union dmub_addr' and is usually due to 'struct dmub_rb_cmd_mall'
>   being packed, which can lead to unaligned accesses
>   [-Werror,-Wunaligned-access]
>         union dmub_addr cursor_copy_src; /**< Cursor copy address */
>                         ^
> drm/amd/display/dmub/inc/dmub_cmd.h:942:18: error: field cursor_copy_dst
>   within 'struct dmub_rb_cmd_mall' is less aligned than
>   'union dmub_addr' and is usually due to 'struct dmub_rb_cmd_mall'
>   being packed, which can lead to unaligned accesses
>   [-Werror,-Wunaligned-access]
>         union dmub_addr cursor_copy_dst; /**< Cursor copy destination */
>                         ^
>
> Add pragma pack around dmub_addr to avoid this.
>
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 33907feefebb..dc92d06572a3 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -162,6 +162,7 @@ extern "C" {
>  #define dmub_udelay(microseconds) udelay(microseconds)
>  #endif
>
> +#pragma pack(push, 1)
>  /**
>   * union dmub_addr - DMUB physical/virtual 64-bit address.
>   */
> @@ -172,6 +173,7 @@ union dmub_addr {
>         } u; /*<< Low/high bit access */
>         uint64_t quad_part; /*<< 64 bit address */
>  };
> +#pragma pack(pop)
>
>  /**
>   * Dirty rect definition.
> --
> 2.39.1
>
