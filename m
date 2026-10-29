Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87224606A31F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BA311208F;
	Thu, 29 Oct 2026 08:05:34 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D111B10E7A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 05:23:24 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-91c60e30054so17109366d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 22:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793251403; cv=none;
 d=google.com; s=arc-20260327;
 b=V+5f9GHfhDPwp74PeXZKLSQG+DqS9DV6z/6WmeJU3D+dNNMicPdVJ8JaSooYydU9cp
 3wkAQbzAy8882/s2DQma12ylFtPPGiVc1CEwVPOB640lW9wb50RohHZ5HNUvR6qMiFwE
 x3pKxfaHXzWZXO/1FAfmQoKmmhpaaoDO4unqioOWYVz6i7fyd6ZCtXivI5iSgDsdTyso
 TVvolKl36SiPvWB7ZJOJDcRxslYUkp5Rc0WQn4Ps988/gVUeRE2yYkTdgS049KPXjI5G
 IoxCOeMSO6pi11fWGg1F93gMdJ84DxsBPUch8nnyF9IWRj6BJUV7GrdLVKVDHqobykvY
 DfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 fh=a2X/KSEqv6ynFKziTwY42B506VTrm9A31j9N6Km6HKs=;
 b=KwbN7iB/Wtwjnm+dxdfmbSLWkFLcxVivojLhC83otO2CHV0mvbj4mdT1MpuvWZq/Rl
 q3+Y07G/e+FoxLJLjUzEFerUs/BqTL6ux+AM+fju6cW2sqaE05A2UXYh3HS+Q50mOVcN
 b0LR/a2tPqb2kuP2zw0M9B4XpvwJSP4CMcnY82WucQBFtpOOxxgrv9v1fhtT27Th6b7s
 EpQybifv4TrCcIzdqmhMQXN4qFSgA5j5Lf3j/TzACwTlmokagqnnKKUNmAMk6+flLoIj
 u5HUg1UP+i7XsLmfNC2Lb9/JKSysW7/b3tZJNXkfp0pVFcE57ZN3mOH+P+LfFLxN+6yh
 oMdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=comlore-com.20260707.gappssmtp.com; s=20260707; t=1793251403; x=1793856203;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 b=VmeFi2/B8AMEBZ6ox06nh85Gq3mWe9woZlNP0WKWibHvTyGLNM+3yort5EGi4KsyeX
 pA70WCDPOntPNS9xaUpVoWWF68JFp4eRKbmh2VsADvbL35VCsveutK1mbtLpDJgjUDY/
 C/Kejy2StpoLQpFRAGpfeG4jUrRVky3iG1SNfLg3GI2X6DtQxlgolpVgt+MgSGpSc5Uk
 0BymlXkmhzT61kIIm+5YnLQ+htzTPhWcVmVeWg0ICQur13XfwaJoOa4VKwonyHZk8b5B
 tTsCa2I5s+o82NBvJe6OCuZbgrYtAdK/iX5AE3O382lNois+T7MKVNAIvrDNHatP772s
 AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793251403; x=1793856203;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3Lg+FgJV09tVnv78E8W4PKyxu20xSS1d1mIdbRMTE4Q=;
 b=CgGJigS6/EWHBcIDS4EqJr6Y7mkJ37WwTDMS1BBylNincJnRCvlu6F9I4RUs5/KyhA
 3FV80oS8KmN6VjIuN7FZDZBObfK+xkMMlXAaH3blnD11M0bS3wrVI7wNvIwzHYIVBIla
 4mOAkOISaxGsbWfREW3Q4DNEcF16o7oC6eJIPljfUV+PDCn3pRa49x/BlbMDs538WJXg
 ywJBv4gd/z228zsmzLdNn57QkZpU83ge1dSrsvP7roPgxR6fUgWTFvBiIQXc7qLiHilp
 m76clcXLnRRkEjGuOE2oe5DEiR2o5+Lv1z63TzAsMs89isQ3i/iC3TYQW3C3nDkAuXr2
 F+1g==
X-Gm-Message-State: AFq9FYLFkpkjXs2aFs3AUj9TR0hiawGvjM1E+3I1K09E8bXLjkdMcIkY
 a+QChtc/2EpIX9zKrq+SqD2T9h+2Md6/Z/fmt0haVpsNzE1KtlKy5SzDETyr0TFFwzPLPdNCpPW
 lbYa+0S8epo8NNn7KjUk3wvDIqfG02xUBJ5Jtr8bkZppJgotGqfs=
X-Gm-Gg: AYBFou24Ed/TxuJ2Sdy12fAlphHf/DHFoY1l3v+NPozoLcJ8dnmF/3huK/KHsZNiwx/
 vA+xXdiqUjciCzzmgYIaWnG2yx5plH1oxlM0bIGBhIaGmTv/IAwAB0CBdZ5A0qlIUphpv3fTMXQ
 sxM3q9y/z1/qr6cSdnaiBRmV/jz97No4+I1iE5JIEfbdKuNeLcjiH6BoJVbGnOldaIF4xSOuJKI
 F6/IOKBBRya818ZYT1wdi9EMXOCvDYyBCrFdBUsj2uzBXQ9B2zm7Ply4bw6ABZVJINkuDdnuPnh
 a6WrQqXPR93WQqXh6u3ufAHZVZPoZCJv8gUKHMPQSIz/sbIo2QiuvfS3iX5gdKzkxgBOiHEvFDG
 o7j82BEEVEt1M5fEQtUCZdJ30wis3KcGEf9jqrhm/CbkqtlX2cdLOsuV6
X-Received: by 2002:a05:6214:238d:b0:914:47db:4640 with SMTP id
 6a1803df08f44-91c7cf96bb5mr75175836d6.19.1793251403564; Wed, 28 Oct 2026
 22:23:23 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 29 Oct 2026 00:23:22 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 28 Oct 2026 22:23:06 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Wed, 28 Oct 2026 22:20:28 -0700
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST; 
 Wed, 28 Oct 2026 22:14:21 -0700
From: Ted Bullock <tbullock@comlore.com>
Date: Thu, 29 Oct 2026 00:23:22 -0500
X-Gm-Features: AclHuK_tNNj08QVgFsStypVC3FMQXg1t9_UmaQA8dmxpz6COnH-A2PgFV31jkL4
Message-ID: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
Subject: [RFC PATCH] drm/radeon: UVD GTT corruption and RV6xx coverage
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Oct 2026 08:05:22 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I investigated video corruption on my older iMac7,1 (RV610/M74,
device ID 1002:94c8).

When the decoder was reading compressed video from system memory while
the GPU was drawing, it would corrupt video frames. Moving the input
to VRAM allowed frames to decode correctly. Disabling graphics draws
also stopped the corruption.

Here is a proposal to keep UVD buffers in VRAM for this family of
devices, as the driver already does for some other chips. The patch
covers RV610, RV620, RV630, RV635 and RV670. These chips share the
RV6xx decoder path and legacy R600 firmware, so I think they are
likely to have the same hardware requirements. Someone with the
other hardware would need to verify that.

I tested this on Debian.

I used Codex to help with the investigation, testing and patch.

Signed-off-by: Ted Bullock <tbullock@comlore.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c
b/drivers/gpu/drm/radeon/radeon_cs.c
index 2db819a..9bfd3ea 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -125,11 +125,16 @@ static int radeon_cs_parser_relocs(struct
radeon_cs_parser *p)

 		/* The first reloc of an UVD job is the msg and that must be in
 		 * VRAM, the second reloc is the DPB and for WMV that must be in
-		 * VRAM as well. Also put everything into VRAM on AGP cards and older
-		 * IGP chips to avoid image corruptions
+		 * VRAM as well. Also put everything into VRAM on RV6xx, AGP cards
+		 * and older IGP chips to avoid image corruptions
 		 */
 		if (p->ring == R600_RING_TYPE_UVD_INDEX &&
 		    (i <= 0 || pci_find_capability(p->rdev->pdev, PCI_CAP_ID_AGP) ||
+		     p->rdev->family == CHIP_RV610 ||
+		     p->rdev->family == CHIP_RV620 ||
+		     p->rdev->family == CHIP_RV630 ||
+		     p->rdev->family == CHIP_RV635 ||
+		     p->rdev->family == CHIP_RV670 ||
 		     p->rdev->family == CHIP_RS780 ||
 		     p->rdev->family == CHIP_RS880)) {
