Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF893C5B560
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23FC10E695;
	Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jzdcmigs";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6067510E074
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 19:41:42 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so258712f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786218100; x=1786822900; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qOzxaBs8tjvXFEEsG3x6NMorv/PyTmxCSr/TzBnZvhs=;
 b=JzdcmigsxZcoHr1u4G08OHwJDDaXoQW5ciJjSxC8xanwQBEQ46hZi5iYj8oVFrHtdA
 9hRo9vJclByv3PyzD6MRve4cVg7YcnWQDYR+j1lXNkD7cILMpT81NrSk/AdRCBqDuCzX
 G0JHGrgWR+XlnVlxk8z7sEP2YmSzyjtGe3Sfw7ERQ8B+cn2Aqhy6gmpNm4fePCWCnr0C
 nRpoS4WXXDAbBwol4Di4dA4iVgwHTgiwjCFit0E6jnlHw0emWe/eoxu4LJCUn3AUxdYv
 bW2Am9DqGJB9h/hzP1006ARaRSeCbRgCmAQ7xA1qkTK/D56TwgYYiDHn+xyYxCa6JUZb
 aOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786218100; x=1786822900;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qOzxaBs8tjvXFEEsG3x6NMorv/PyTmxCSr/TzBnZvhs=;
 b=Qf73lB9wcFPpwIUUcVlkdYBy2LUo9Ewh5uQJn5ag3vZxaRh4gu9iLL7Z7HoIu/W0h0
 LF39Ol/gC9NvGlsjkGb2zUOe3RzOl+FFnK2hGNjdzSBPPBCHclzuoH+TVP3MKtRIOqHX
 5HjOaAIvqgub95HGIpMeUntkt89jlpssUCNc0S3Xin2MdSIKA8ZddT802rG0062TuUiQ
 ilcqM4rpm7zDPiCjfZitqL+6Lk61/WU3tqMw4W6e31WmAn24JbO/VFKxgCuI+oDjrqnf
 VKWuY1Ol8BhmZHMX1Ny6Bs2RT5u9YPe8LkS/g/H/RXJTKfWj5GUDOZDaszEh31W6Qem7
 L+rQ==
X-Gm-Message-State: AOJu0YwR/QhvvshtOBJJbMuTn+BJ0/bECaYFhDXn5jrI2rKY1uUuwiOq
 wXOOSfEETXrLcgWrdyQQtH2amD62VdePgFS3djD5Igsm/fnp4SquSgLbns1Pls/jV8s=
X-Gm-Gg: AR+sD11+On8lsvzxQzBHVD8kfacpkVw+u14gOeEMWNJ9aU1Q10DlNuvIl2ax/p0ePpc
 297t/h2qpDCcVHCSBvLjF3j74fTd/x/Iu5LcgliglIUG6gTRPsVhvXrmNC5Yi0Ql3L1NNpuotkb
 ultDwpEm7DoY1WmHQ045nrLAsMfYr18T5M1GMgn8pSbTuiruV5jpB8Pa36zyyC9lMltcYi96KGZ
 nKb4oVmYqNIeXesEe0kZjjg7ra11dIPvVcGf990/NF96xG+r9L/EPvzs4/rr0eotuV2Kx6fD/ID
 0Hv1i9fAsk3DGiR1k0m5/+tQvYAvhYm4jJENAkJ88S8IqM9ilMvErhrYQocmQiP9gNyYnBD9cjw
 O7Du5YoLEleYK3ezHa8NpJmUkIzaPKdxyPByYj/ZCyITQS/r0j99ro5rcJ8axuk0LChMTq3MUsz
 p24da9EpnjeTw01G17Ukq3fanI9V7EuOEg+i/0N33tjCtnmrrrim5mL/1B
X-Received: by 2002:a05:6000:2798:b0:47f:6981:a043 with SMTP id
 ffacd0b85a97d-47ffd982040mr19194735f8f.26.1786218100445; 
 Sat, 08 Aug 2026 12:41:40 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fd392sm16588636f8f.31.2026.08.08.12.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:41:39 -0700 (PDT)
Date: Sat, 8 Aug 2026 22:41:35 +0300
From: Dan Carpenter <error27@gmail.com>
To: Asad Kamal <asad.kamal@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/pm: Update dpm table structs for smu_v15_0
Message-ID: <aneGb_1yFYh7rFt9@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello Asad Kamal,

Commit f7bee962d92a ("drm/amd/pm: Update dpm table structs for
smu_v15_0") from Dec 23, 2025 (linux-next), leads to the following
Smatch static checker warning:

    drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0.c:1270
    smu_v15_0_set_single_dpm_table() error: uninitialized symbol 'is_fine_grained'.

    drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0.c:1283
    smu_v15_0_set_single_dpm_table() error: uninitialized symbol 'clk'.

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0.c
    1245 int smu_v15_0_set_single_dpm_table(struct smu_context *smu,
    1246                                    enum smu_clk_type clk_type,
    1247                                    struct smu_dpm_table *single_dpm_table)
    1248 {
    1249         int ret = 0;
    1250         uint32_t clk;
    1251         bool is_fine_grained;
    1252         int i;
    1253 
    1254         ret = smu_v15_0_get_dpm_level_count(smu,
    1255                                             clk_type,
    1256                                             &single_dpm_table->count);
    1257         if (ret) {
    1258                 dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
    1259                 return ret;
    1260         }
    1261 
    1262         ret = smu_v15_0_get_fine_grained_status(smu,
    1263                                                 clk_type,
    1264                                                 &is_fine_grained);

is_fine_grained is not set if smu_cmn_clk_dpm_is_enabled().  And we can't
know if it's true since smu_v15_0_set_single_dpm_table() is unused and
we can't tell how it's called.

    1265         if (ret) {
    1266                 dev_err(smu->adev->dev, "[%s] failed to get fine grained status!\n", __func__);
    1267                 return ret;
    1268         }
    1269 
--> 1270         if (is_fine_grained)
    1271                 single_dpm_table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
    1272 
    1273         for (i = 0; i < single_dpm_table->count; i++) {
    1274                 ret = smu_v15_0_get_dpm_freq_by_index(smu,
    1275                                                       clk_type,
    1276                                                       i,
    1277                                                       &clk);
    1278                 if (ret) {
    1279                         dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
    1280                         return ret;
    1281                 }
    1282 
    1283                 single_dpm_table->dpm_levels[i].value = clk;
    1284                 single_dpm_table->dpm_levels[i].enabled = true;
    1285         }
    1286 
    1287         return 0;
    1288 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
