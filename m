Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2CEC3ABA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 02:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED6A10E185;
	Tue,  8 Apr 2025 02:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6CK1Wjk";
	dkim-atps=neutral
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608BD10E185
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 02:11:32 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c59e7039eeso724987985a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744078291; x=1744683091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6X+KtcYbOjRviMJLbpLVRkG1JY03BT4I0jIfUtdsMfU=;
 b=C6CK1WjkBMc2cKrdoF5GZoaMYOR/WV0xOYLJhrPRITRFzkkrvIqnZVySFYBCozlhqU
 4b3s+hdgMuFRhGmY26DzCxDa0X6mooV3+r6TS/3xee67wRbKWBV3KtUYC1qZ3mUoWRLQ
 Ah4dWVR397gpfYETR9D5k6Dzoib5VQ8wUsPGZ7H+2+0Bxv9vYRTqmQbAgZL/eVG5/HuF
 1EdQnPM+oVW4ez82jCVJ41dCZFoOFJG4loqEwMwLEQAMXJaOd4eYZoUKpbp5VjyvipRM
 UrtUpXQ3lIseg/1o3RI5RePNa+l0R/Cjncj5T9B8YTJDZ5H9jGbxdyBl+Uw0CVsgnAa7
 drAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744078291; x=1744683091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6X+KtcYbOjRviMJLbpLVRkG1JY03BT4I0jIfUtdsMfU=;
 b=d/DAwVGrhMdkMSp59FN1Nh9l0OaNX++bSPXnvPxyjBnhNU0yhKa55vzZdvAL+mbJ89
 XqPBpfgbFZT4UhAJKkPl6lCjbTq4pg+WRR/fuL1F8FRY6uUWArqxFWjZPvTFT0A19RwR
 XzY5oonl8je5NN1vLsD/XFyOjjkULPbbOu8pyj46kZPW9PmWzJTZXAC6kf4Ql1AlDHtS
 SYYcO4B7xTdBVEVVMxP/yttY6mfUWNgIDyNLujqptGRzW3HAshOWO1QvIpdmIUTlH+aF
 muhHTvaT/XvjsbjSwfPz2vvVdVr1+4f8unl7f3DF+YQOEHO4GujqB+7y3blYPSVXIK8m
 yptQ==
X-Gm-Message-State: AOJu0YwVuVuINkidltc37rb8yBbC9/Tc8dJN5cR/Af0Z6bEvvULo5qU0
 HWEibLZUvqh5Q3NenCUzMdV9DC+27D6AD/yOiRDm2yGlMpYJma/byD6TEQ==
X-Gm-Gg: ASbGncv/LioVQbl+GeLN5YwuKN5ZU6yvAe5EBcJwG2kB8+BR/ON+1VAxJ1eLY+8JiWo
 7tljL/l/Qc+MUmWW8ccvFsYXgGi1cLKE5ajOuSVsH6SKUDUmyGOgYXd0IzG6F5qrx2B7mzLzXws
 swyG/RdFkB3UXMoDAkXc4h1Rkb3K7ztvUw7dfEj5hciZL8a2a5wBsTxC3JF09DjWUsaWNXh/8X8
 XxZCBZ4T5hehUPVBqpzdVU6n/psn44WjroysJ+5GRBsjHDk6XWNMlyd3KFf5Y0te17XZY83eaRq
 uRayiFUNZqTp8mwIqTE1+8alexfHfy064lf58mQTbK6YPzHtwDIrbM6nrWBFOx6Csjw4
X-Google-Smtp-Source: AGHT+IF+G76yKC/HyLeK4zjv+SSXXn+nhfAINDUab0hFqIwDNFbUYxKC9AnNdPUyCu4FxqxI0Uwr1g==
X-Received: by 2002:a05:620a:4003:b0:7c5:49e8:993b with SMTP id
 af79cd13be357-7c774e25ab7mr2556737485a.56.1744078291597; 
 Mon, 07 Apr 2025 19:11:31 -0700 (PDT)
Received: from localhost.localdomain ([38.121.253.36])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c76ea5992csm687693985a.84.2025.04.07.19.11.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 19:11:31 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/radeon: fix typo in atombios.h
Date: Mon,  7 Apr 2025 22:10:58 -0400
Message-ID: <20250408021100.5439-5-alexandre.f.demers@gmail.com>
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
 drivers/gpu/drm/radeon/atombios.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index 2db40789235c..c4abd1f78410 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -421,8 +421,8 @@ typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V2
   USHORT  usFbDiv;		    //return Feedback value to be written to register
   UCHAR   ucPostDiv;      //return post div to be written to register
 }COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V2;
-#define COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_PS_ALLOCATION   COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS
 
+#define COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_PS_ALLOCATION   COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS
 
 #define SET_CLOCK_FREQ_MASK                     0x00FFFFFF  //Clock change tables only take bit [23:0] as the requested clock value
 #define USE_NON_BUS_CLOCK_MASK                  0x01000000  //Applicable to both memory and engine clock change, when set, it uses another clock as the temporary clock (engine uses memory and vice versa)
@@ -3825,8 +3825,7 @@ typedef struct _ATOM_DPCD_INFO
 // note2: From RV770, the memory is more than 32bit addressable, so we will change 
 //        ucTableFormatRevision=1,ucTableContentRevision=4, the structure remains
 //        exactly same as 1.1 and 1.2 (1.3 is never in use), but ulStartAddrUsedByFirmware 
-//        (in offset to start of memory address) is KB aligned instead of byte aligend.
-/***********************************************************************************/	
+//        (in offset to start of memory address) is KB aligned instead of byte aligned.
 // Note3:
 /* If we change usReserved to "usFBUsedbyDrvInKB", then to VBIOS this usFBUsedbyDrvInKB is a predefined, unchanged constant across VGA or non VGA adapter,
 for CAIL, The size of FB access area is known, only thing missing is the Offset of FB Access area, so we can  have:
-- 
2.49.0

