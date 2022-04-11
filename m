Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21630C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 21:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBC210E0AD;
	Mon, 11 Apr 2022 21:54:14 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F3610F742
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 21:08:18 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id u3so24864125wrg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=cuLSn1q/GBIKSgoYE18mr+8Xjjh5E8wzIDAnZC3Kor4=;
 b=hYlw6pRtzMxtWsAkiIgcWRN+12HL1xIob5XMpA/zejat696Pcxo2DTP/KTwXMKS5vc
 AYM9+XGhuKlU7EDDi1uqFnQu2pOwhlsxi8Oeo5eht/OrbJqKU5dIe58xJaUA8X8yQbu8
 PR7Qokl1dStZXC5NNgVAu3P6fnvTw99NVCzlCUbUvvQVVs337EylT+eOp82FHHa+zVMv
 yFl2NMF+vdPZdVdTIok+zCLZjhXPyHEwKiUjmbxz/FNoWnxVDRczfXn2Z3VqZLANRnY9
 xM/N3XpVqA7Qv2xRTZEmiK4Wi/3eKNG2M/huJi7rS2Qd/FCzAifUKrzhrQ47KIHXn2vf
 2dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=cuLSn1q/GBIKSgoYE18mr+8Xjjh5E8wzIDAnZC3Kor4=;
 b=R94Ah994L9Qns5mrA8Rgjjj0kBafRJ22X4uJSj+oIgkZZ1x9y/fY1xM2bN9qYxL+5E
 79VUEVX8+/HT2pcz36KGl/XIslz2Xw0SFACoGqmx4OdBYTjjVSyxh+4KhSE1ABe3J9/h
 zlfZnMca1Rah+byK62wELdW64BBNPz9FJ7fQ2g9a1VErmYv7HysFrxN6w9OKlgyqba+7
 wnPGo1npLI0UqLPYymkkN/IILWOqKSJZKyCfo2+DbS9m0OHtRT+vwa8RV0YP3TyVvfNm
 BEWZeW7OWPulZXpVyqrXK8LkV/0YjmWVX66ItMQL6uGHuT4EMfj+7XJVf5OXhAb4ke3/
 4v5w==
X-Gm-Message-State: AOAM531DlmwNKrsKA8pWnbGI3+JqUhq6Confz/PWBt5Vlv3Gv/J8oQ6e
 YuxHC2bMMdn3fnB71hNiUvE=
X-Google-Smtp-Source: ABdhPJz/VITA/P7SQx1zn0TZYnR++acV4H+Y3dJMoss7AHPZDuvdhr4i36KcTLujykxZPwaT/jxkPg==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id
 u13-20020adfeb4d000000b001edc1f7a951mr26150009wrn.454.1649711296330; 
 Mon, 11 Apr 2022 14:08:16 -0700 (PDT)
Received: from nz.home (host81-147-8-147.range81-147.btcentralplus.com.
 [81.147.8.147]) by smtp.gmail.com with ESMTPSA id
 3-20020a5d47a3000000b0020412ba45f6sm32624942wrb.8.2022.04.11.14.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 14:08:15 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
 id 300222C6C320B; Mon, 11 Apr 2022 22:08:15 +0100 (BST)
Date: Mon, 11 Apr 2022 22:08:15 +0100
From: Sergei Trofimovich <slyich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2" ...
 amdgpu.ko] undefined'
Message-ID: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 11 Apr 2022 21:54:12 +0000
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

Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:

    ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
    ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

It is occasionally seen by others on previous gcc versions as well:

    https://lkml.org/lkml/2021/7/11/261
    https://lkml.org/lkml/2018/10/24/403

'__popcountdi2' are inserted by gcc for code like the following
from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':

    static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
    {
        uint64_t n = 0;
        uint8_t count = 0;
        u8 bksv[sizeof(n)] = { };

        memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
        n = *(uint64_t *)bksv;

        /* Here gcc inserts 'count = __builtin_popcount(n);' */
        while (n) {
                count++;
                n &= (n - 1);
        }

        return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
                               MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
    }

Note that gcc can insert it regardless of -mno-* options.

How should linux.git handle it? A few options come to mind:

- Perhaps use libgcc.a directly.
- Just implement '__popcountdi2'. Example definition from libgcc:
  https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=libgcc/libgcc2.c;hb=HEAD#l846
- Or workaround it with -fno-builtin-popcount in Makefiles.

CCing people who can help routing it and/or deciding on the fix:
amd-gfx@lists.freedesktop.org, Joe Perches, linux-kbuild@vger.kernel.org,
Jakub Jelinek, Segher Boessenkool, Thomas Gleixner,Peter Zijlstra, Andy
Lutomirski.

WDYT?

Thanks!

-- 

  Sergei
