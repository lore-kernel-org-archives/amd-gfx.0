Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FB606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SgceIAYX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EDB10E61F;
	Wed, 28 Oct 2026 11:16:30 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE51310E61F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 11:16:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so7616755e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793186183; x=1793790983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqaYV4D+nxbNcqZxayfMlqD/q9RUsEpvsi2zVu7Kx9s=;
 b=SgceIAYXC+RwwTfFmF6KXUCka8uKVMpAEZou4S1mmA4aAl6xXlBUgeARbfZLRoVcph
 a23P2+KaV/ShyAm6KUgFviKFmh1AyFOksNcn8lXhYDbE5uhNIc/6EA5rZhMKNshf5VYy
 Z+7LqvSdh525pAeWrhWy9aEopjXCw3FryukzpGZb99xm2pTRYGeNHWUoejFudrrXBH3j
 ssovIIxnVkPC7AGRffM4k9J315v+tYXZZ4pGOTcmeI23taCI71w1xT7FkD+iixccwT8o
 Ymr+2JYVS2F8zCeGjgYxT2cl8T2DbhY4YiwYeOnzbvlR5wDmsfUiBjZBJ062pKQr7MmO
 Op2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186183; x=1793790983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqaYV4D+nxbNcqZxayfMlqD/q9RUsEpvsi2zVu7Kx9s=;
 b=edn5F0b1eQJ5oHLsP4W2GkYXbsm/M47sXA64rlWN0Rw9lM4KSYUOYqfx+9/nmWWhFf
 K0plnxDdJr34UdJ3DwkI0oB8ZhXvSM6AL/T4GoSIfSnkVI02JclO0xTHsgvhXcP+SMgf
 UMfMlkZ7sqGytIQtgW47MoGgt9U1f/2Qk5BDSa/aTcJvuGRehBXndAVXHKNvGDT9TKK/
 4XbDzKzv0aK6UJC07RBNQFlhwDTGwtyy8HEyMgXc8W52cqplbxy5raC1uKxf4XG9UzR/
 BPJATs2Dmo/mffDCYC0v7lQ9fScBFOojLFnfPZFlR00XUINzyFnu5tPg7xBC4bUzy/9N
 IhPg==
X-Gm-Message-State: AFq9FYKfHAg1KRducA3IjrVlUxcoiSjvjo1uo6DUDOn0fw9PY1EOpbGb
 0kLfEhYxzvNlQ0L7NlbpV/c9Sx4y0WnkcYy+0Ecv2Kf1Ou3pwHayHjNv
X-Gm-Gg: AYBFou2zF5MgSGSGClncHKLCJEF81fR2+dcgIGI/pOLNVeLSweGY60eIclonNbhZfjF
 JowC34l13ncErEJibv3YEmVt4Yo3Xoa7kNJarp+3+e8tC4A74TbeGdK+djOTxBIBqj1nTqgy3Se
 i+x3tgIQjiWdBFBlwPPppTKgzl/F6YeqnuGgZ4AaLmmPK2r6xQO0Bg+CxIPyiEpv6KH7DapgYBu
 oBEXKvOT7ObK4Dev+gV/l95sB5/17X9CWVVJPHXc8s9CiLgBITG1o3U4IH7c2PVSVgyCYXOOmma
 h+uJsmaXA8Rt4ux0CuLlQhb8BOXN/6pQ5J/jbrbyYq6QheaP1hb3eBG2xLHMRBSaikBrvx1r15E
 gQVdCRyZlVy9nQF+mlQoHtkh0IYgTBMOrMJ5bo7eMad/d7SPZDqGp8d40u2nFr/5WNOzTl/nsCq
 BpMsThCoGyOI+zEPBu2p5Pn5HnY3npcYDNqGMh+w1N97QYEzjbMd6ukSbFR2l3B38fzYILzN9WV
 NH7yIdenb/SyZVRrB1wVvt+sWUzKA5z+smprqHTxYmOMZXanWMVPxbWlfnrJ6bntuqDb0iuMcPk
 Id1zHktMyMfrGdphsG/C8xVwC+Y6NcJZN5ksMi71eWIPKHRhR587vOeNf5WHkPljJHmBN62FTaE
 cky3Wn1U93m72mcUKOAywRUEzmQ4=
X-Received: by 2002:a05:600c:a314:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4a9672f815amr32754615e9.14.1793186182794; 
 Wed, 28 Oct 2026 04:16:22 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm27793374f8f.4.2026.10.28.04.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:16:22 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Subject: Re: [PATCH] drm/amd/display: add missing CRC engine 1 registers
Date: Wed, 28 Oct 2026 16:16:18 +0500
Message-ID: <20261028111618.27368-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028091501.191108-1-Wayne.Lin@amd.com>
References: <20261028091501.191108-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested on Navi 31 (DCN3.2) the same way as v2: a kernel built from
mainline 65ba8f34ec88 (7.4 merge window), with and without this patch,
opening crtc-0/crc/data for the first time after boot.

  without: two WARNs from dc_helper.c:53 in set_reg_field_values(),
           both reached from optc1_configure_crc() under
           crtc_crc_open()
  with:    no WARN, and CRC capture on engine 0 works as before

I also checked the generations I cannot test.  I expanded the OPTC
register and mask lists of every DCN3.0 and later resource with the
preprocessor against that ASIC's own offset and sh_mask headers,
before and after the patch.  Every register and field the patch adds
is defined for each ASIC and each OTG instance it is used with, no
initializer gains a duplicate entry, and DCN3.5, 3.5.1 and 3.6 end up
with the same entries as before.  The patch also applies cleanly to
v7.3.

You are right about DCN2.x: their lists start with
TG_COMMON_REG_LIST_DCN and TG_COMMON_MASK_SH_LIST_DCN, which already
have the engine 1 entries.  My note in v2 that they were missing was
wrong.

A nit: checkpatch wants a Closes: or Link: right after Reported-by.
The bug was reported in v2 of my patch, so a Link: to it would do:

  Link: https://lore.kernel.org/all/20260829085941.106318-1-mikhail.v.gavrilov@gmail.com/

Reviewed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> # Navi 31 (DCN3.2)

-- 
Thanks,
Mikhail
