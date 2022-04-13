Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D5CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 13:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9F310E755;
	Wed, 13 Apr 2022 13:07:52 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CB210E725
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 13:07:21 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id r64so1038875wmr.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kafA4Cp/nvsG1AFf16x4P3arNB/XPl6avUTek6th6LM=;
 b=JhqMhVM5H/AR7I/KTvaWwpyBIGvDRUUSTX73lauZ64L74/VO1bBrYLO4kOCXiDsp9b
 0eYtRMoZ7x+ck797cRJmAfBS061I5aDnEewWtvDE6jhHf8tUivNI/chCSIiU2fvRcrR/
 tRVSChnBJZ5SsIri4tfjbW9sM5U/BrgcSRF0tzmvBtL75oV4ALTkPWPmLfIHfc1bLnew
 /Ge8zb3nnBu8FVVJjy63m44WkE5gpeahe5Xy1imr0aH8pYOpFTrFXd7Mf9Tz+fXBqDnN
 1hjMXg6TlCD/sv/8Vsfi03n2aPOgXeeS0Beh55YH84A3mRAFlePkZiEjp95iKeWOgWSg
 Ah8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kafA4Cp/nvsG1AFf16x4P3arNB/XPl6avUTek6th6LM=;
 b=tTo8lVv/jv00myjHAk4ikj18H38pwmRuOH3DWzh+Gqt3sVmxdKD+y9Ss5iWcfLlrJa
 F37BD15kYd/WZGEpUGMLfYCG33CVVIcmaZGk4LX9X8FCuUsPGNF2xP/a21wzd0hsc5BE
 4dwT8lV8f47j3BVrnU70Ld41MrUSLg/Egd1xVs+fTNkoc4Uus2U2tmnwAD6PXRgvbdOp
 N7KGJ8KUD0GjGCg3p6DHxSdLskOPruKTzfA+uUFk9iDCwfGIpkZUP2SzHagOs74PAfh7
 ND0sU219IFXkUYVyPyJTTc8mZQWotVn1JLeOoFwrF24zlHNvGBLdJ5IzAjngRgxF/Ffp
 OOZA==
X-Gm-Message-State: AOAM531Dn1Ckf2IwPdVyG3tGBoluahzaisYd2Oq+1Vo10SdpFARLC9Pl
 kXMqgZWHJf+RSxCq76vugQg=
X-Google-Smtp-Source: ABdhPJz38kWLFzpnLGk8019rjJMv35e3WlH7WmyVRBX8+qR51s+Kqeuhii9sqjD11yXqjzhXO47SZg==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id
 f2-20020a1c6a02000000b0038b366147f1mr8455676wmc.5.1649855240054; 
 Wed, 13 Apr 2022 06:07:20 -0700 (PDT)
Received: from nz.home (host81-147-8-147.range81-147.btcentralplus.com.
 [81.147.8.147]) by smtp.gmail.com with ESMTPSA id
 o17-20020a05600c4fd100b0038cd5074c83sm2749187wmq.34.2022.04.13.06.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 06:07:18 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
 id 8D7CC2CBD6EC9; Wed, 13 Apr 2022 14:07:17 +0100 (BST)
Date: Wed, 13 Apr 2022 14:07:17 +0100
From: Sergei Trofimovich <slyich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2"
 ... amdgpu.ko] undefined'
Message-ID: <YlbLBUJxMDUBFo+z@nz>
References: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSYv3d9a5cZR9KE@nz>
X-Mailman-Approved-At: Wed, 13 Apr 2022 13:07:51 +0000
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
Cc: Jakub Jelinek <jakub@redhat.com>,
 Segher Boessenkool <segher@kernel.crashing.org>, linux-kbuild@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, amd-gfx@lists.freedesktop.org,
 Andy Lutomirski <luto@kernel.org>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 10:08:15PM +0100, Sergei Trofimovich wrote:
> Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:
> 
>     ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
>     ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> It is occasionally seen by others on previous gcc versions as well:
> 
>     https://lkml.org/lkml/2021/7/11/261
>     https://lkml.org/lkml/2018/10/24/403
> 
> '__popcountdi2' are inserted by gcc for code like the following
> from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':
> 
>     static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>     {
>         uint64_t n = 0;
>         uint8_t count = 0;
>         u8 bksv[sizeof(n)] = { };
> 
>         memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
>         n = *(uint64_t *)bksv;
> 
>         /* Here gcc inserts 'count = __builtin_popcount(n);' */
>         while (n) {
>                 count++;
>                 n &= (n - 1);
>         }
> 
>         return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
>                                MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
>     }
> 
> Note that gcc can insert it regardless of -mno-* options.
> 
> How should linux.git handle it? A few options come to mind:
> 
> - Perhaps use libgcc.a directly.
> - Just implement '__popcountdi2'. Example definition from libgcc:
>   https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=libgcc/libgcc2.c;hb=HEAD#l846
> - Or workaround it with -fno-builtin-popcount in Makefiles.
> 
> CCing people who can help routing it and/or deciding on the fix:
> amd-gfx@lists.freedesktop.org, Joe Perches, linux-kbuild@vger.kernel.org,
> Jakub Jelinek, Segher Boessenkool, Thomas Gleixner,Peter Zijlstra, Andy
> Lutomirski.

There is now a discussion in gcc bugzilla:

    https://gcc.gnu.org/PR105253

-- 

  Sergei
