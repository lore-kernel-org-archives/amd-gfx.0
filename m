Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B25CCD18A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA9410E3DD;
	Mon, 13 Oct 2025 07:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7n1eJUx";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EAF10E194
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 19:13:30 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-781997d195aso2510953b3a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Oct 2025 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760296410; x=1760901210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cJyjShr1i4+1ahYehZ/S4z65QdfAA6uxL/qAaZtcMo0=;
 b=S7n1eJUxrmRIwuw8wal+pu1UCv3PWKDsSKQMOSHOtuKTUY4CNCMJ+BTBjxGyzba3HR
 fmadkwuFDA9Xk1yVQfIJhAY1CW51Ffjd5YTklwBCU43iseK27c6ER6yo08Z69t9+CcZx
 5/ivbg+lUjlRRqcnVhsbNpadVsDMEV1bDoTqISvEWEQEF1m9S41IcOuDzJxxtWf9S2l+
 /wyGf+ZQSd6uxp0B8xpsh7XZUY9bSvmHLZbRPLknPz2mHdSGM6u9Pen2dJAv4Zmbx3Iw
 Dh+ZgWmBVIT6D+nvJCB1TJWpq+3LJpgQ+orsGq7RCAkfjGaI5uQlmrJIbS+v8WkM746/
 QRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760296410; x=1760901210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJyjShr1i4+1ahYehZ/S4z65QdfAA6uxL/qAaZtcMo0=;
 b=bu+SYehJd4U2YGRFNJcGt00JoTMEnpg+dNzYWl+yPLRdl0oI6YVZnWLkjtrL108hkC
 ghCvtey7XJbv5fE/crOyNBu7kLyfFg8wGtDPoFB08pGu8dRnxqHKtbmmTOs7UkY67s8I
 qqRWU/VdS1Q+MxhI1cskVj2AoyZa+95/aglgAA1Ah82Nr5Lvv6VATNFWmZrzUuFMgs62
 yS7T+O4E3bVVTj9TlhdxDUS80TC6gQYUxXFCMXWACIyG1UF4JznzfG8fDqfmqz47gNh4
 QAhXc1URQTBDgqdMyNjc6/fvE6ViJH6pqbkNnF1bRdeNLmFj3DRv10RKeZ+DvGstu2qT
 Vq2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUjen1HB7Qlw5x3vwBpOS1ckGiiv9N3jOUcBqzkPNEoJ0yszYnmJEUxPCMy3jtqBHl9V0d1rfr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr2kw3LN3o/rN2GKLg/p51+uTqHn0YT+MGTmI1t0WGqqZGIRW1
 GrZ6YMI9lKwluQvh3o9K2LWwUJNmV507gRUNFbymROdn9xluxngVVyHz
X-Gm-Gg: ASbGnct/e2B1mLqn1bEknnRPt7kbiDzO2X4GLU4y8IAkbfFgIDz0bnW8rg8N9vVGCf1
 Sb1Xv+QbxYAsQp5zVeNcqFRXtQn4Ppgi2o8RiDG1QEUo1amKDGKqN1d0kQK/DsDGTtwEnVXLP2Z
 K25yRoEtQWFz8QfNB6d2WPZlQ3B7AMnn2gXpXU6v/mBrPGVJOXP/r7l5kvJKilfOvIlPeg8qaEX
 pfp+fOijEYEZFWC/YrP7cW0U3LDDcGFvFLBFq9p8HlrzIkN9h/ApL20YxMopMeSG1u4P86YRGhp
 BtWPMtX02V2n1zCoN5h8PbTXwcXnoBt9WueTDIiqzvHmz7soO/+t/FJsCK8kjXHR6uk2RDgVr1S
 BUysmfmo5pyq8cD+nyKxChvYc6Vg9zpHw9r52ry1ULK48S0vdvUbwon07lSo6KOI1lM3Z+MU8PV
 noZwt0b3QiUvrxH9TC/gfvjwqW+FADteuKxyXz80Az/g==
X-Google-Smtp-Source: AGHT+IEAYVnUkYlyXFyELMBmp9hn0QU0m0/phIOjfHeyi4BZTIDLCyxOo9zX5iCKuem03RJMyzRu1A==
X-Received: by 2002:a05:6a20:2443:b0:2bd:d83a:d1a5 with SMTP id
 adf61e73a8af0-32da845e45fmr25164575637.42.1760296409944; 
 Sun, 12 Oct 2025 12:13:29 -0700 (PDT)
Received: from linux-dev.. (174-21-182-191.tukw.qwest.net. [174.21.182.191])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b639cc8sm9115199b3a.20.2025.10.12.12.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:13:29 -0700 (PDT)
From: Aditya Gollamudi <adigollamudi@gmail.com>
To: austin.zheng@amd.com
Cc: jun.lei@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 Adi Gollamudi <adigollamudi@gmail.com>
Subject: [PATCH] drm/amd/display: fix typo in display_mode_core_structs.h
Date: Sun, 12 Oct 2025 12:13:19 -0700
Message-Id: <20251012191319.40046-1-adigollamudi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 07:35:45 +0000
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

From: Adi Gollamudi <adigollamudi@gmail.com>

Fix a typo in a comment, change "enviroment" to "environment" in
drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h

Signed-off-by: Aditya Gollamudi <adigollamudi@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index dbeb08466092..d57717b023eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -1894,7 +1894,7 @@ struct display_mode_lib_scratch_st {
 	struct CalculatePrefetchSchedule_params_st CalculatePrefetchSchedule_params;
 };

-/// @brief Represent the overall soc/ip enviroment. It contains data structure represent the soc/ip characteristic and also structures that hold calculation output
+/// @brief Represent the overall soc/ip environment. It contains data structure represent the soc/ip characteristic and also structures that hold calculation output
 struct display_mode_lib_st {
 	dml_uint_t project;

--
2.34.1

