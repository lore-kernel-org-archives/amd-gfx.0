Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888A606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hBiXNiRy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D70112469;
	Thu, 22 Oct 2026 09:45:00 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD5111123B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 07:36:51 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36878d8f8f5so94328eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792654611; x=1793259411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5DpYvnCuMI3yPgcDnrdR2yXHOcHCjxXFPFiwuk+v6Tw=;
 b=hBiXNiRyaw+ys74dl4XEaR3F4Z628uGa7qfq4DtZIfXNsxuib+RD9yMWqnX5uoW/OL
 /fsgBUBm5DhSe/X411YnO1JdGdX+a/tdi0UNbOrgpOgxSx4BrPY5KDvjTp06jBsTgbVa
 fBbsiZPUlZoG2TrZrgoZFuFnRmjr5O7Rn557YB8OfTTjpCnV6RA4CfYoxjDo6R7KneXz
 uU7zoA2LNrjq0/XWPol5vbKpKNU4x+mK+Kmu0jI4py0FWnBReEIc5azm2utFO2jorAX5
 +jnqg2QVlGMmT0pdCUgNTHVQUvDpDeLACd7Ww1LK7HxSRdliBQatPHOvvHErW7u1DguV
 uRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792654611; x=1793259411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5DpYvnCuMI3yPgcDnrdR2yXHOcHCjxXFPFiwuk+v6Tw=;
 b=adh4fSt6Pg0Kqc2gPBor9ZXCq3FIQLD/Un5Z1j7vTN/geBfXefOq+ySqHTdabdszrH
 Xgm5mCjQ43Zwd3EviwH1SIc32q/8WaKGERB2DUtcWNoR0CyEaafUqysvoF22AQ5xS4cm
 TYBB0e367YLNgYI1obknFf7ckdxVdx06rY2hVOBsMJwOqc69SR2KCFzYlDyWAuAXNZIj
 VFAcvflMm/g2gOeKKIR95hPU0wimmNpXWZmdvcAsuJgOqwdtQr0CVtqn7Pt3ssBtd9b1
 tGeOXuWXgc75qFC4Oo8H7FyAfnyAzmnip0ho88dcUiFDlb3tadHthgeJ63FY1CUbjuPr
 h+Hg==
X-Gm-Message-State: AFq9FYJ2Almz1lt2jwi7F9M0O/nGtwID7e3p0XfSGRWyrNd0VKh4lPUW
 bHzGogWQq5bTFqRzBi8R/fS76Ho4ASBxwFjDVmhHGpb04m5hIIvUHPPC
X-Gm-Gg: AYBFou21EXbIW0jM5y8vKD4novNggKYAvwUPcqEG1iI5qBn7+SdGsYJGWq8TZLq9G7+
 Z7OXKzo8YfVolwleUk32MB2KeDWQC30GxLK89bZDV1R+wAC+RrQq8DshOvGpHswBFdR41jBDmTJ
 7fUi7Oq59PjLOAyjipjkPrYoJNIWKEKtMqZMGeXfK9QkpHHhLehqIC2TxdjRsCJk6MFAeUn8Mez
 QYGXkigsHx1z3qNiNlt2E6riIH1gcU9HNqNIat/IstbqRycx+oNBBFyUP9hTMggDojojQa8oMB8
 u5JJAeM32qzb0sgBZ+CHlR1w9G2ucPTTJ9toyioSCgg07Hc9OrAD/585ZyIAR4D+vi5ueotzj8f
 d9oAANKsmq0esAjYbsyI5hSMFNIJMe3/8BGmP2ESdPUhoFjDqoxKCv8E+T1rDm3MzU5RcHgHQgC
 0pLZ6FQw/upNKxCfifqEEudMsEMtRfJKyZ8XroVykFPp/LgnjOt/6hr3qxoGEgRWPX4djuWPAks
 GtT/putD4Bw4Vy1mYIWJt3z7eL7mkfVTkQ9f5UmtjBKnRu0B+p1IrJU
X-Received: by 2002:a05:693c:811a:b0:368:8792:720 with SMTP id
 5a478bee46e88-36887a14b77mr4373527eec.1.1792654611029; 
 Thu, 22 Oct 2026 00:36:51 -0700 (PDT)
Received: from archbook.lan ([14.1.89.164]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-368ca323effsm4486672eec.7.2026.10.22.00.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:36:50 -0700 (PDT)
From: Brad Drury <drury.brad@gmail.com>
To: qchcio@gmail.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM
 at 0
Date: Thu, 22 Oct 2026 15:36:38 +0800
Message-ID: <20261022073638.724414-1-drury.brad@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015095713.20560-2-qchcio@gmail.com>
References: <20261015095713.20560-1-qchcio@gmail.com>
 <20261015095713.20560-2-qchcio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maciej,

I tested this patch on a second MacBookPro11,5 (Radeon R9 M370X, Verde,
1002:6821, subsystem 106b:0149). Here the dGPU is a headless PRIME
offload GPU and the panel is on i915. The kernel is linux 7.3-rc7, with
amdgpu rebuilt from that tree with this patch on top and nothing else
changed in amdgpu (amdgpu.si_support=1 radeon.si_support=0,
mem_sleep=deep).

Without the patch, VRAM is at 0 after boot and every S3 resume fails
with "ring gfx test failed (-110)".

With it, amdgpu logs "PCI CONFIG reset" and "GPU posting now..." at
load, and VRAM ends up at 0x000000F400000000. I then ran four S3 cycles:
two on battery and two on AC, from 9 minutes to 13 h 19 min asleep.
After each resume the GART table was still at 0x000000F400000000 and
the kernel log showed no ring timeouts, -110 errors or GPU recovery.
After the last (overnight) resume, DRI_PRIME=1 glxgears (radeonsi) and
vkcube (RADV) ran, and VA-API H.264 encode (VCE) and decode (UVD) both
worked through ffmpeg.

One thing I noticed: on 2 of the 4 resumes, about a second after
resume, vce_v1_0_stop() logged:

  amdgpu 0000:01:00.0: VCE busy: VCE_STATUS=0x2, SRBM_STATUS2=0x80

VCE encode worked straight afterwards, so it doesn't seem to break
anything. I didn't see it in about 11 resumes with a local workaround
that kept VRAM at 0, so it may come with the new layout, but I haven't
looked further. Mentioning it in case it's known.

This supersedes the gmc6 patch I sent on 20 Oct for the same failure:
https://lore.kernel.org/amd-gfx/20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com/

Tested-by: Brad Drury <drury.brad@gmail.com> # MacBookPro11,5, Radeon R9 M370X

Thanks,
Brad
