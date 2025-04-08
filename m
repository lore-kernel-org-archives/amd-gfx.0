Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F2DC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3142A10E5A2;
	Tue,  8 Apr 2025 02:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcB2Ukp9";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384D710E599
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:32 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7be49f6b331so525866985a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078290; x=1744683090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WAMooTpEAwYzJIXYvNGQLnoibuKC02Gc2Oq+iSrxM9A=;
 b=GcB2Ukp9tmy1bNuxw6MVigBK2SNHIuSNXKp3j67z1FXWDkgANcy2D7Cy0UQJ4HkK71
 YpnUs8XIRBRH9cozU3yB3xKTWici4OPpU/HAfdCw7J1z/EsIeu3eHjW2HOUsuJ5Lt+ss
 O+WsORh15MTi6I4QNQrFR3mmZaSYW9ClaDnV9SD+0RyoGynv+aHamPjhrk+6nN9kB+Kt
 FrbT4+2Fnq8edRbcSqw4rneC/Z4a05aGVtC3dbrd51wbH7XeXSWM4ufMU9BsEL+P3eB2
 TiEHJ3a5bhrmcVBRyHe4hOU+fJEsTD6UqIMElBNLWHcvFBTGHXjEpkOpmzcnwOzSj/Xm
 T11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078291; x=1744683091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAMooTpEAwYzJIXYvNGQLnoibuKC02Gc2Oq+iSrxM9A=;
 b=uW5yWTxmO1iGhDjJZO/DH/4UKtzFViVEScwNGeRV02nvUry+8sqGf7/6h+2B5JZzVx
 ANWS5Gtzw0kYbGUtgd12dXtp+CI0wbkjoCQIhDQ2GRtTEqmei+lOO6Q2eNZmyau5hj/6
 2dzpdTe94tOLAj+J0H+2wfzvRBuMnQ23vFuFW5t1tgL5zB1DIAoxy/u0Zba36BUi5mHF
 jFmw5koIoiIXxa6q/tqTrASvzK6ZebtoswcvJ0HopisXfgRFbpLdPEHF479cLheBSYui
 R1Sm61zowbJtSgyMkaZd46JG7Eh6Gxt4BptzwyUwpoJ0kGJ7nD+FTq6OSaxzdMiBWkzW
 GBaw==
X-Gm-Message-State: AOJu0Yww/FSGNdU+xDZgc7iqCwjByx6Rkp9FC8inhlg6QZAeH2ay8ZYO
 9p1dRfUU24nyRG7HNDfAAJVGYbKTZJ3sUsJ+7LNEa0ocm/aZENZalJ20Qw==
X-Gm-Gg: ASbGncswVYFFWtxeQ9Cxa4rjbLciu5R+rXz/CNBRNq8Opyys13P/bD3x0RxQ5lckSjL
 5KockIRDagNYp0Qf6bN1N8HkWEW/LNygJRwoAFayhHv+WN4PU/vYMaCZ3tiO19zKtoUW527dulb
 Ow18B2mZYuXE9CIp91iBzF30Oz8I46VK/G6vtk37GxytRtughU0OFmBhztjyGH0NTmHn4LghUMn
 rTjUfVNoqJ8cxT7nsnpW51UPIDxLZrm9omb5d8L9tg27JBvwSPwwLjG/wnZuiegy42FWXbrtRSY
 2lPbcV4NZ/HAWD82Ll9eu7zKpvFuCDRuKhxxOSC0iFr8BYilmpTr7v6yeqbAamhZGlqz
X-Google-Smtp-Source: AGHT+IG4XpnnXlhb3HUj7HBgNZ5+M0zhakhnTwkrrqhEweT7oNH7xV7AbHQtBfZ6MQelnYoU1BpZBw==
X-Received: by 2002:a05:620a:f04:b0:7c0:a70e:b934 with SMTP id
 af79cd13be357-7c77dd6b3c9mr1795247385a.7.1744078290642; 
 Mon, 07 Apr 2025 19:11:30 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.29
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:30 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: fix typo in atombios.h
Date: Mon,  7 Apr 2025 22:10:57 -0400
Message-ID: <20250408021100.5439-4-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

"aligned" not "aligend"

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/include/atombios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index b78360a71bc9..52bac19fb404 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4308,7 +4308,7 @@ typedef struct _ATOM_DPCD_INFO
 // note2: From RV770, the memory is more than 32bit addressable, so we will change
 //        ucTableFormatRevision=1,ucTableContentRevision=4, the strcuture remains
 //        exactly same as 1.1 and 1.2 (1.3 is never in use), but ulStartAddrUsedByFirmware
-//        (in offset to start of memory address) is KB aligned instead of byte aligend.
+//        (in offset to start of memory address) is KB aligned instead of byte aligned.
 // Note3:
 /* If we change usReserved to "usFBUsedbyDrvInKB", then to VBIOS this usFBUsedbyDrvInKB is a predefined, unchanged
 constant across VGA or non VGA adapter,
-- 
2.49.0

