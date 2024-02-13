Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE4C4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 22:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2E610E5D0;
	Tue, 13 Feb 2024 22:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="gVw3JHhE";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD96C10E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 22:52:18 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3649409a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 14:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1707864738; x=1708469538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n1biSooTx/UrebYR5OP4qSXkcgnNa/5VFREgCxOwPao=;
 b=gVw3JHhE5eKzjmfUWlV6um7Ld+MIg7eajO6BWo+bTfO+Cs1aAq4QAxNs1954KJyoTo
 lO72lIborEFoZ1eMuim9rwxrbWi0pmRCluKkerzZVt8Fmi6bW9STXVtouWatAk2FqJuw
 +2P91P5Ysyv89jngGyHYLy3kCkXfZNf0MuMSsK5Y2nMe/4reihPlvE4GM+X9fuDPs3Tw
 /w4gck5u4H+deEEpb2ehvgjirx0PF7ZN4jBcEV95PxnUAzTDr3occ/ziqkaVlALYP1Hm
 siQmZ3N/zup6/5hbskEkuq/8axRgvv1CMF4NBQnfbm0+yXOlUdvEX4dyGBOQSc9Chk3O
 0MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707864738; x=1708469538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1biSooTx/UrebYR5OP4qSXkcgnNa/5VFREgCxOwPao=;
 b=sXzYpPVjX0xlubSoK7XrPoZ0VCAUqESgkjqoaEltfyew2q0RA+OckKS19WBl6F8Ora
 1jbqPPkZjE1K7OXpATaaS81O3OJG8RT4EPIvp4kTGK0KL14yETSQ/zbJEBoh2L8dLbnq
 fH7ah+joVbQKbjDBJ2Z959IRSCiZvRx30ShArMRztYiiSMq80kSPcdpcRH40RLhfKush
 FWTEJ7q3GQjbzxbir2Dqae8fmuyPWgIchNRV4s6S8Q2BmAjJpuf/wXgmCqUMvX5gREaT
 LvGKSZbrzoRjShsZ4vTNu7x4MQFtSSLegqr+FHt6zM3Vlgi5BGfduMbsXQ3u0BymYhuW
 BdrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLg2In1f3yZ2g6c89kb82eOYdXN5EDWjvOi3XIBJ7dvuiBNfXuP40E8q+YSg2u48nXgVyOHUxKZTbTmUAty4qnRPjvd4lWguEqdbL55g==
X-Gm-Message-State: AOJu0YzAof/q+uTx8FssOP443oj56w895xF3+6sPS15nLyg+bKPXwTuD
 dRVoDOENVRt8dJ6TzMM+6za8YW1/R6YUq7jyVnIqLUUpjzCDZYhg7VCGs1VY2g==
X-Google-Smtp-Source: AGHT+IG83kjcMgyb2TepVhraekXIrGAoO7/5x2dYYti0Y2M/nalGgdcVnPISARyASbiN2EjZJxr0xQ==
X-Received: by 2002:a05:6a20:6f07:b0:19b:673d:824d with SMTP id
 gt7-20020a056a206f0700b0019b673d824dmr1066486pzb.46.1707864738360; 
 Tue, 13 Feb 2024 14:52:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXCiFWioP2hocfsaygH9ibRlbits+JDjuU/QXuJb2JVlOpqNH/v23Dygl9ANykWvEBeaX+I99sxAIVTQierYXlXJ+ZNpjQ9clLsKzo3whCzixc/NMeLrB5twSJzY2NE/+snoB/KB7FZ0RP4dV2a+j59NZsYPGN86+pimfvFR0KZqXAKt3jcLuEUx4+1woE1pwc6qI1RtcVqQ2BNl5IlKvWoD7oEAXvp5hrlClJSsSK3gf8+eiRXg8m96nUjr7VfnR48sax7zY2aipw6+W/VrP0PivaN0TuUMo3uzgn99VX4kbf3VooNNIGWt4Cudrvttf/4P1c22Y/TcNrychwT0JQmO13cAjvgDfMMDSV4AMU=
Received: from fedora.. ([2804:7f4:8280:6434:9a20:a151:2d8b:d5a0])
 by smtp.gmail.com with ESMTPSA id
 r25-20020a639b19000000b005dc89142b99sm1528379pgd.84.2024.02.13.14.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:52:17 -0800 (PST)
From: Joao Paulo Pereira da Silva <jppaulo11@usp.br>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 daniel@ffwll.ch, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
 sunpeng.li@amd.com, Xinhui.Pan@amd.com
Cc: Joao Paulo Pereira da Silva <jppaulo11@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/amd/display: clean codestyle errors
Date: Tue, 13 Feb 2024 19:43:08 -0300
Message-ID: <20240213224339.379599-1-jppaulo11@usp.br>
X-Mailer: git-send-email 2.43.0
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

jppaulo (2):
  drm/amd/display: clean inconsistent indenting
  drm/amd/display: clean else not following close brace

 drivers/gpu/drm/amd/display/dc/core/dc.c              | 6 +++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0

