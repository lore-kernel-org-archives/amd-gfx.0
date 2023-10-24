Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC42C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 09:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2ED410E0AC;
	Tue, 24 Oct 2023 09:38:53 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EFC10E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 07:52:12 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c4fe37f166so59962781fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698133931; x=1698738731; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ilKMnCDZxes3neJ/m0gqhGJPibPIN/Gb1E4NmL9n6tE=;
 b=H1BIta3tXlCR4dLvt7HV1M2Rtfl1MBIq0dBY+4ACcNkaz2aB7EkEAWLvtmM4OFapPs
 M0HMHC83xgGGrorZkxV4az7Ix/6Bbf2W8hXzg5YypsuLfOwQz9apZIchmbPyCAzn+djp
 vMhPbE3yrhgQT8/P3iTVgkhvRLG9qhaXx8Y9nmE+bTbi+EPm0dM5n7Tl74Na1rXBbrsM
 FBR6UJZwD5vnmSR/k7Yl2ESiktJprkVLk0F48Yzf2QlBa6Zma6eebA0PyhIsjZRkE/11
 /Y75bYMyWHl/Cy0ipKNH5x0etgyrtM8ZyhtY4uRCvCTxlGHx8+nwP5zq4gFaECmFdzW/
 dJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698133931; x=1698738731;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ilKMnCDZxes3neJ/m0gqhGJPibPIN/Gb1E4NmL9n6tE=;
 b=L1+4Pg8y0WAULBJlK7kQ1q3GWi2UCZlHnV+h/oNJ/jFrlxeNHFrm5XdcqPPAHExw0F
 qOl7/+SFiTld5sLPe0vOiCqArno9m9+uwR569guCBUQFQ5TgvrToVMccaAD2oAj2QMPv
 FERGO7h+I2YMuMwUEMB/Iq4JSAwyBJCO2mehzlybodiPFRqwy0U4WHsstU9POA2SjIFs
 ySireyvSMKY0xyUIeMb1+QysnTj4fBDEfdIvJoyvwoDLOedYvhX4ZdN8w2vcjQ0U9FJ/
 1vM8ZAfQYflaKQqDRSAQH2fBusyDaHfZVlOJcr6ne2gcBY9Vj+hEIX8vt+NsR4iagbE7
 i8yw==
X-Gm-Message-State: AOJu0YwldQCCPRT/YN5Kvu4H3hEfwUWjnp32yMnAfm2fsyXiCAySQ/G+
 AeSf2H1gLmA829Kvi/URoZncZQ==
X-Google-Smtp-Source: AGHT+IHyrZ9RoYlI8A3qiSP0nlZSIc+pBNzGzYtiovRmGj9s81PSUkS6KsGId3DCcuSW+hVOF5nsWQ==
X-Received: by 2002:a2e:a7cc:0:b0:2c5:fb9:49b6 with SMTP id
 x12-20020a2ea7cc000000b002c50fb949b6mr11022386ljp.10.1698133930734; 
 Tue, 24 Oct 2023 00:52:10 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c0a0200b004060f0a0fd5sm11320822wmp.13.2023.10.24.00.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:52:10 -0700 (PDT)
Date: Tue, 24 Oct 2023 10:52:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stanley.Yang@amd.com
Subject: [bug report] drm/amdgpu: Workaround to skip kiq ring test during ras
 gpu recovery
Message-ID: <bb137e53-8c19-4495-9404-7b250c510356@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 24 Oct 2023 09:38:51 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Stanley.Yang,

The patch b1338a8e71ac: "drm/amdgpu: Workaround to skip kiq ring test
during ras gpu recovery" from Oct 17, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:513 amdgpu_get_xgmi_hive()
	warn: sleeping in atomic context

drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
    500 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
    501 {
    502         struct amdgpu_hive_info *hive = NULL;
    503         int ret;
    504 
    505         if (!adev->gmc.xgmi.hive_id)
    506                 return NULL;
    507 
    508         if (adev->hive) {
    509                 kobject_get(&adev->hive->kobj);
    510                 return adev->hive;
    511         }
    512 
--> 513         mutex_lock(&xgmi_mutex);

The patch adds a new caller amdgpu_gfx_disable_kcq() which is holding
spin_lock(&kiq->ring_lock).  And we can't take a mutex if we're already
holding a spin_lock.  Turn on CONFIG_DEBUG_ATOMIC_SLEEP to see the
warning.


regards,
dan carpenter
