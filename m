Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A52CC10DCE
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 14:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912B310E267;
	Mon,  4 Dec 2023 14:04:18 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F28D10E0B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 12:43:07 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b479ec4a3so43813085e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Dec 2023 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701693786; x=1702298586; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=082RvqRTJvQ4TXijXEsnRml++3Vo7qwhcaPlOkAUAao=;
 b=gSySWPmFXHBkncmY0XJ1dRWrbtk1gWr0+aGbhNPf6euXoNU9jIniNoVs8+B4bFzL+n
 dzQJeUKwqJ2My69hUvzz9PzB0TY0PxvFyCO6LTAmUwCknH68ZrjQNXEbbGwIeltbg+Lb
 sWr0blHbm6mawMSd+p19FHajRE+ATt6WJHHM7SPJlraRJaiFhPxixaMQn85X+P9z6SJ/
 O8Ko76bCqZLeK4pfENqKnH6vyGYZJF0DDiujtAwI93f/mSg+51LS6IT1g0aAJWDC39WA
 YuEFlgnt8XUKPJOS5FFXlLmgK3xYwOn4OePYmW0ZMIbv1myFktXv/TTmG7hB0UPHYCvZ
 f+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701693786; x=1702298586;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=082RvqRTJvQ4TXijXEsnRml++3Vo7qwhcaPlOkAUAao=;
 b=UIsCrlg5ECKcbVyWMk9WJAYyT+LknHzFe1H0WIL/2IfR7F15fkLGnecTKpoHVt+UU/
 tBd8baWGWPBYhv+5Vq1nAPpkRsSCdHRKBVdsRsqPxLsFaYutBoKmqnWxH+WHM87sPUSi
 cXRZV5gXwLNKSuL02Aam69BG62CJ50XUO7WjL47avNG9JCcF0nPOLGARUqd1t012bsH3
 Fnhb7WtsoXQn2ZICF+EZJo8FrrmnmV8bYv/0QAWPFgDX2Xl1mR75eOscE++nY3j/nyfY
 2qa4323n9yAOSsjny6fXCB3Ya6cyrAU5R2YKdf0bbwXk/U7x4roexPKOcmcvNPE3KCyK
 cMDQ==
X-Gm-Message-State: AOJu0YwqnSBsXoft9zuSY01JQDb6PfeH5EcdeLlkleeMUB892FG0J9Qh
 RL16lAqYn/3+q5Pn/fFxES6kyQ==
X-Google-Smtp-Source: AGHT+IFeukzjjpwu0aLYsEt9DFTY/DazUbHwFJ1RU5k+kFGRhy5f7C5EnB8yeAdg3wsSQ7qtrXnT6Q==
X-Received: by 2002:adf:e5cd:0:b0:333:17d2:4556 with SMTP id
 a13-20020adfe5cd000000b0033317d24556mr3336921wrn.23.1701693786073; 
 Mon, 04 Dec 2023 04:43:06 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 k5-20020a5d6285000000b003333fbb68c7sm5251470wru.112.2023.12.04.04.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:43:05 -0800 (PST)
Date: Mon, 4 Dec 2023 15:43:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stanley.Yang@amd.com
Subject: [bug report] drm/amdgpu: Workaround to skip kiq ring test during ras
 gpu recovery
Message-ID: <3f8219aa-e4af-4db4-b667-632eca40f40e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 04 Dec 2023 14:04:11 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Stanley.Yang,

The patch b1338a8e71ac: "drm/amdgpu: Workaround to skip kiq ring test
during ras gpu recovery" from Oct 17, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:604 amdgpu_get_xgmi_hive()
	warn: sleeping in atomic context

drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
    591 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
    592 {
    593         struct amdgpu_hive_info *hive = NULL;
    594         int ret;
    595 
    596         if (!adev->gmc.xgmi.hive_id)
    597                 return NULL;
    598 
    599         if (adev->hive) {
    600                 kobject_get(&adev->hive->kobj);
    601                 return adev->hive;
    602         }
    603 
--> 604         mutex_lock(&xgmi_mutex);
                ^^^^^^^^^^^^^^^^^^^^^^^
Shhh....  The mutexes are sleeping.

    605 
    606         list_for_each_entry(hive, &xgmi_hive_list, node)  {

The caller is amdgpu_gfx_disable_kcq():

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
   516          spin_lock(&kiq->ring_lock);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Holding a spin lock.

   517          if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
   518                                          adev->gfx.num_compute_rings)) {
   519                  spin_unlock(&kiq->ring_lock);
   520                  return -ENOMEM;
   521          }
   522  
   523          for (i = 0; i < adev->gfx.num_compute_rings; i++) {
   524                  j = i + xcc_id * adev->gfx.num_compute_rings;
   525                  kiq->pmf->kiq_unmap_queues(kiq_ring,
   526                                             &adev->gfx.compute_ring[j],
   527                                             RESET_QUEUES, 0, 0);
   528          }
   529  
   530          /**
   531           * This is workaround: only skip kiq_ring test
   532           * during ras recovery in suspend stage for gfx9.4.3
   533           */
   534          hive = amdgpu_get_xgmi_hive(adev);
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^
Can't call a sleeping function when holding a spin_lock.

   535          if (hive) {
   536                  hive_ras_recovery = atomic_read(&hive->ras_recovery);
   537                  amdgpu_put_xgmi_hive(hive);
   538          }
   539  
   540          ras = amdgpu_ras_get_context(adev);
   541          if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3)) &&
   542                  ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery)) {
   543                  spin_unlock(&kiq->ring_lock);
   544                  return 0;
   545          }
   546  
   547          if (kiq_ring->sched.ready && !adev->job_hang)
   548                  r = amdgpu_ring_test_helper(kiq_ring);
   549          spin_unlock(&kiq->ring_lock);

regards,
dan carpenter
