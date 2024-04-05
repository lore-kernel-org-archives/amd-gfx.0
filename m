Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873A7CD129C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 07:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E03F1121E6;
	Mon,  8 Apr 2024 07:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kPvxaac6";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083EE113AB9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 10:10:15 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-516cbf3fd3dso2135387e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Apr 2024 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712311814; x=1712916614; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pMVxpj5jrCWY4wGNABtVWwiGTGunJDyEHWKpz3twrCI=;
 b=kPvxaac6um2RsgR20vDH7jlByWlpp8L65SUHvFRvGSkB5m+iptwlvVcSr3oLDeJuUY
 8cg3N+K1w2X5N/yqblryNBOcNg5XQp1GF/XplvgmSL7HN6ZnkqjaCkCvqCKFmxHEPadI
 v71047ndROVWNxaiHdGrTnKDPAXIMX8gBSc2+GdX1OuLDFd5pKa/VPlBLh2Rv0YD/nyP
 OPUG+SiEvKCSf1DfuFy5ZBIq6qpx4PsolEd6IgVA4EjTvksQHq+g8ZZaAWFtxe78oePJ
 j0OIn0R4hseKMu33tEBA3r4sETt+oveKbTR0NZyQQMXwlNzGUgafESCYZbxkO36N+ChO
 jZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712311814; x=1712916614;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMVxpj5jrCWY4wGNABtVWwiGTGunJDyEHWKpz3twrCI=;
 b=BYzqCvdcv8+sHo3oXb7qFz1s5nnwxn2nLnbWG4YffTC1rBW6MDFxY1cDYGhtDjpf8g
 Wge/B3RQdL3Hd+GfgcNsmN1+DUkbW+uBTkfjmehH2cVTqsT3hn30HhgxbjyqQXx6cBHo
 dec8eXgiHBV34ff5lvw8EqVzIAcTd6cq3eD6nDOtBgqXprsTu/kFuuK6N8Y31ABgZYY0
 XDsAInLhoOg8p3BNLOMv9SUkG5EJEVO0/4Qi09EHySgYFwBdMZe2LFfzI7ij0Ca+u3/k
 G9FoSeg/oUdxxKmEMU3JGIGiEE2MaYfuYsKJ5gR+CA7cKmHgFzBw5aUKVcn9hgsPOGLs
 J3Tg==
X-Gm-Message-State: AOJu0YxGTbB/r50UKorDID8L7DdEBWcNT4bAn+l4sE9js+JO6YnVsTrd
 lDA7CSejy3mm2+4dxslltjh90+HapiqnGn0x9RBn+3GeISU+XhsAvGDmraMh5XZs9pE3f+yS8w/
 O
X-Google-Smtp-Source: AGHT+IF8onUpvsNtjzwoZWQTlEbe6Ezvt1hwQZRyGt0118r/S2n4JBcqJBoX7auLjlWuvR9oMhCLoQ==
X-Received: by 2002:a19:2d5b:0:b0:515:920e:eedb with SMTP id
 t27-20020a192d5b000000b00515920eeedbmr501937lft.39.1712311813673; 
 Fri, 05 Apr 2024 03:10:13 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 kn6-20020a170906aa4600b00a4e238e46edsm655856ejb.223.2024.04.05.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:10:13 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:10:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bhawanpreet.lakha@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Allow Z8 when stutter threshold is not
 met
Message-ID: <b4d8af9b-1014-4682-a573-15847b81ef49@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 08 Apr 2024 07:46:23 +0000
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

Hello Bhawanpreet Lakha,

This is a semi-automatic email about new static checker warnings.

Commit e9a09a198bfe ("drm/amd/display: Allow Z8 when stutter
threshold is not met") from Mar 13, 2024, leads to the following
Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:1088 decide_zstate_support()
    warn: variable dereferenced before check 'link' (see line 1087)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c
  1086			bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
  1087			bool is_pwrseq0 = link->link_index == 0;
                                          ^^^^^^^^^^^^^^^^
The existing code assumes link isn't NULL

  1088			bool is_psr = (link && (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
                                       ^^^^
  1089							link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) && !link->panel_config.psr.disable_psr);
  1090			bool is_replay = link && link->replay_settings.replay_feature_enabled;
                                         ^^^^
but the patch assumes link can be NULL.  Somebody is wrong.

regards,
dan carpenter
