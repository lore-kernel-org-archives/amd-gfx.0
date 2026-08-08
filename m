Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEB5C5AD4E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B93210E672;
	Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qYV+jUfw";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420A010E06A
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:31 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso5363865ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223431; x=1786828231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=qYV+jUfwEFcObqsHPuPUrAXZjKh0vc+v0ZsfU/IyZA9GQUcEQ+peR5zMcxUO2eOO8L
 1IukYTpmmMnY0/iavmSdnm5DyD6YIbeUlLnyLf6NO0fDsY9TrUp3X0+FhdQkGw1dCMyp
 DfUG/vszzPnjKSia6LrpdvdBJ6oclRiIhjWs3KazsAgC+ctSN1HY+ttBGqTTCIfxEwve
 DwnJJYIMrMxOwOxZ4cpmFTVk1rx8NY7cfSguHNHuqdqNjkjqp/O/Z//D9q2+4tahvyRO
 ZTKYzulaSxole9khaFu38ElnFEHmtKBczSYREspePszB8bmV2HKn4xqLCo0+iwHiyeqv
 zABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223431; x=1786828231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=lqw5DgBOfiaxc26piTlmVDV6FroMzVfirXIoJ3h28fBL7TlX/MEiF+i8OtmtVlBuWy
 L1JNqJrXpGHXbpI/qrsqJelJbdP3BshC4lb7NLHl45Q3nmg/mvIaxB764Tk0sN1yq/gS
 cqJd3U3QfK6g5fjRvjD6Bi75lCW4s/1j5jia5tOZA3mIbyeRPcSn1sOtBiBdD+gkXNLQ
 zubg0ODDxq4mXRzWaIFaSRbQzlctdJn1tbMxoUTHc7MOBOOQbn/Z75AVJ3roKH5EzWBz
 WC1YEwtPGetJg+1xvTUfjdCY3iIGZUVBa3Tlrkm/Sey0o9PcHFJU0pHDqny5zUoJX1yU
 9XoQ==
X-Gm-Message-State: AOJu0YzrKFLbLexDL8TF/9TB7hJwi7JFUIuVMbxpK3p48G1DlDUGIaYe
 +rsBTuw8xJfgxcXiv16WDa2yphjBtLRtvDFyUPWUqTi7B39Z+vwBQRnQ
X-Gm-Gg: AR+sD13+m/L2Sqe2OYjGU7KojMsWDIZ4D5i3anT+WbOvJgheCnIxVg1MXIfIE981QpY
 SdPauWpn3ra+UMK6wQD2qlAcibhNJIoWwTvahQDPdjYGjT1zbfLTGOteY8AMKyGcHj3nZ0os9XR
 XqdqMYycYspe2X2g6/wKVIWtDajaHs7u5iqfKPMve3+FVG+x1xYtsUeHvKPuhwp4zsWPineSU88
 mRtN0N64KpWL1aGwT1lyP5RQ44Ujz6SpoSmUOe+x4KKdWNxQLIbDuQ+uQBsTffhr5itEeTTcxMr
 SOPTCRrr74sqBla5iWjiwaT8CaEva2xXkdjfsbngFEH50ZPX18pVVBtCpVBRA5VZ+nrfajSxPOl
 r4svY2aUim3B27FXOcmVNdElrUNz8W80HrlHSXEjCXb+d3+JZWF+nxUvd5YBN+2Lqjs1l8MQfFQ
 I37LD5pLR5Gl491pvFFqqmTRbHeFLzjR3xOrK9eJuAsj1xbqLQ2MeKyFOXOCHB7JyfMSHvd5U/K
 CEyClfrfLE=
X-Received: by 2002:a17:902:ebc2:b0:2cc:d69a:354a with SMTP id
 d9443c01a7336-2d2a8eb76e2mr131021095ad.22.1786223430721; 
 Sat, 08 Aug 2026 14:10:30 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:30 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sat,  8 Aug 2026 21:08:49 +0000
Message-ID: <20260808210852.2938-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

In aca_bank_hwip_is_matched(), the 'type' parameter is used directly
as an array index into aca_hwid_mcatypes[]. The function previously
checked whether 'type' was equal to ACA_HWIP_TYPE_UNKNOW, but did not
validate whether 'type' was less than ACA_HWIP_TYPE_COUNT or negative.

If an invalid or out-of-bounds enum value is passed, an out-of-bounds
memory read occurs on the aca_hwid_mcatypes array.

Fix this by validating that 'type' is strictly greater than
ACA_HWIP_TYPE_UNKNOW and less than ACA_HWIP_TYPE_COUNT before
performing the array lookup.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d0d473082431..c76664af9902 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -138,7 +138,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	int hwid, mcatype;
 	u64 ipid;
 
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+	if (!bank || type <= ACA_HWIP_TYPE_UNKNOW || type >= ACA_HWIP_TYPE_COUNT)
 		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
-- 
2.54.0

