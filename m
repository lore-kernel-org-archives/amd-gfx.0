Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B8ACCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC49110E67B;
	Tue, 28 Oct 2025 22:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L//nNm4p";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8FB10E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:40 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-63c45c11be7so10609978a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689199; x=1762293999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZRKLQvDJvTFtMZiHMA4K/xzfPwXLFKq2fC8dn2Nvx5c=;
 b=L//nNm4pRbmCvIZtdBifCEdJPu8z+ncCs/hzq8gfW/o2ghrsuASFwOnffoJCWqvslH
 SUFIuGYH29Y9HFFZr8iPBJ/chXqi1UU8Ldkr0tvv/E+Urn8JhN6OHnTLmyv5YbHZ2END
 GRvPPXFKHoNwrbYSahdQ4CVQ+qjwRtN8NGw0OxSGp3dg0TBsH63g+F4Nzy+oY9UjJhtM
 KJ1ENDOhN8G2KE/49fdZ0PrPydRU7QXgIf2iDodW1x197J5Zweq9qHqd7smoWTLmxB1J
 X2714roCRGSSK576DwR75uvQ6k2cfc6+MeHo7xNP0Lwn8S4dVuxJPIjmxZIF4FX6oEH3
 UkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689199; x=1762293999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZRKLQvDJvTFtMZiHMA4K/xzfPwXLFKq2fC8dn2Nvx5c=;
 b=cpYSFLJwXgifO3vLiM6Mf3w1nTV+yH4ep2GLjX/dEIh4Wo7X4Azc1oxK0ffk176ah7
 eq0dTixiY3Gz6JjWp9WJUle30oGilj2pkEiSOZErNY1L8FHVj8SOvcLf+L+gz0mezf6H
 kFOZzt4irjSZKmuAxmuKsDFHhePpextWPASFiVO2/J/KDrDNMjGazUMLClDa9c/7hvmq
 RAqvIYXjTit2neEWAQXpbb181DcVGJXPu8KijNjPXcdA2Q4o4PU8FCxtJXf0ee+3Bwim
 WRKRSuufMBKU3eKMBApPmq2XrJk094UjQPplpFq6NkgHpAjvO1tuDY6WcAc4zOj34gFl
 PfXw==
X-Gm-Message-State: AOJu0YwU4KHR+N4mJzyn0vEhm1p2ytwihQFnAmUg8WJgku6Mk8OHxnB2
 ssPwsbdEc7b+Io0/Gh6z+zdZF34f2LHECUNiiW4iiTEm2WGobA6WABrq5ET65g==
X-Gm-Gg: ASbGncsrV2lNwGvg+8HeodhN0zR9EqI1p0AsJ+jsPh4g1VdvuNx9t2gi2qRNBSk2j8T
 IXM21sDr4nnaVQY2pIyhKJgqJuxhJ1QDdaQxELvioyl04HI0DtdzO7Pt3lk0cT6jojLQ5sjituE
 bBTPZJjSA4YEKwawssj5Znr7Gv8CNQ/nYrz/2v9SfKzFMZ7nndoI0AvUzTVEW6XLFJiEAUMRGvW
 AqhTouwjfNiV/p4SnA2j8jiboszMqW1R+gasc/mfXlVQdIWxFw64RUO4VH5IDab/96OjabD/Q3l
 Fx2/lgKtWuxoNkgs6/PzQcEBMoapAC/pjgYuwc0E/ASRSZACu+0Pn+erGrqsTZWWtuENJo9fgQi
 rEPlHAcCWQapO34qkBM6CzhV/MxgpoWOd6Mgc8qYiQeQzT25b4Kzn6RHsRtEptViPjkbjp8HE8T
 gdMv0HhnzsHxioIYkEwokh/ndz4aWwAvIQHQ2LaKmjqHSSNs6HpiU2FYcO5Ub4QgMOzoliIvDPF
 PPbV7IU
X-Google-Smtp-Source: AGHT+IGza3qI2nVmf0WCVieCs/fKZkC6Um5fFl9EhUmMFrn/SO9QZxnhmYv4uch5c6Bc0iyZiXgLBA==
X-Received: by 2002:a05:6402:4415:b0:634:ab36:3c74 with SMTP id
 4fb4d7f45d1cf-640441a956bmr486533a12.9.1761689199371; 
 Tue, 28 Oct 2025 15:06:39 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 02/14] drm/amdgpu/gmc6: Place gart at low address range
Date: Tue, 28 Oct 2025 23:06:16 +0100
Message-ID: <20251028220628.8371-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Instead of using a best-fit algorithm to determine which part
of the VMID 0 address space to use for GART, always use the low
address range.

A subsequent commit will use this to map the VCPU BO in GART
for the VCE1 IP block.

Split this into	a separate patch to make it easier to bisect,
in case	there are any errors in	the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index f6ad7911f1e6..499dfd78092d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -213,7 +213,7 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
-	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
+	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
-- 
2.51.0

