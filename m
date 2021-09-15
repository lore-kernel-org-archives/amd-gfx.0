Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 12:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E4E610E9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 12:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44E4E610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649026E920;
	Wed, 15 Sep 2021 12:35:50 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA316E8EE;
 Wed, 15 Sep 2021 09:39:31 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id e16so2176505pfc.6;
 Wed, 15 Sep 2021 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=9DwEurpv8pV9WAKblxk8PQ6MlsJLKqkLsk2uIwjdOs8=;
 b=CHYtUWpojKuDZDp8++kUB6sBOmGkVp2FVI419Trr5GXtgFzVzUVDD+wZ339WENrz8n
 LzaoQW5ksPbkLJC57SCoeeombrDIjB05zvwUeYFBhf86tHsq+kpPxZjubz3XaRw++fAl
 OYw/wlU/FwEWtvGkrcHgyFb4U98CqPZNAPRZkbgScMMtXZQlg/cgcXREcnWskkH98n8i
 bdOBFAwLupdlx4R+W5KqPTAH4bOdCKCQoJhvScfHvKs1JkO7sfHpJfdSZii+yLoHz2j9
 ++COGMH++Ee04AmkKCF+dov94QQVsYm4Cw4ofpRlliJ/IKPSeJcj15g680EclieKGCgq
 U8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=9DwEurpv8pV9WAKblxk8PQ6MlsJLKqkLsk2uIwjdOs8=;
 b=fNNTLLdsuqL5S+nxYqv5fsU1u3R7ZDld+bpkTjurKgPIcFpdRIDPNIapvYsIcaqanz
 m8ExqZLt5s1Qrovag0eQ66+hBlvSQsNbJDutZVRBnXDCEHm/61DX0JQtnBB9+Dug9Bk0
 u2TO6DVW9RhMNQe9Vf50Dt9dT4Zfpiy+YEZCTY3UoQoOqLe4m3r9nZo6y7x+NFHBOVjS
 u6zPHrZeX3EvqmHAi1Sv/5NAOq3NK1EaXK50+mvUqpwjoptpsnIHbS5XYPSfkdA7t75w
 EVvXpLw9lRPj3VgJqWYnhcil+c82XTer4rlx7pEloJWxnpgE5iQ6ekd22rvCq0NaoTCh
 hp9Q==
X-Gm-Message-State: AOAM533jGnTt0+wYCOsyBo7xr73EBHEd6w87o2Um40xB6n45ftQOSqsN
 bMmTR1z/ttkIwXALd9a3Z4g=
X-Google-Smtp-Source: ABdhPJz79Ykf/6lng9i3x2nmL9Wuw9ciMpAMALdLeYK2rnjmpUMc21B1gNwkYS30l6z927RkIZSdhw==
X-Received: by 2002:a62:e902:0:b0:414:aaf2:2b4 with SMTP id
 j2-20020a62e902000000b00414aaf202b4mr9587556pfh.10.1631698771533; 
 Wed, 15 Sep 2021 02:39:31 -0700 (PDT)
Received: from [166.111.139.129] ([166.111.139.129])
 by smtp.gmail.com with ESMTPSA id w5sm14342387pgp.79.2021.09.15.02.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 02:39:31 -0700 (PDT)
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] gpu: drm: amd: amdgpu: possible ABBA deadlock in
 amdgpu_set_power_dpm_force_performance_level() and
 amdgpu_debugfs_process_reg_op()
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
 Felix.Kuehling@amd.com, ray.huang@amd.com, lee.jones@linaro.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2dc31435-ba62-b6a4-76dc-cfe9747f4cfb@gmail.com>
Date: Wed, 15 Sep 2021 17:39:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailman-Approved-At: Wed, 15 Sep 2021 12:35:49 +0000
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

Hello,

My static analysis tool reports a possible ABBA deadlock in the amdgpu 
driver in Linux 5.10:

amdgpu_debugfs_process_reg_op()
   mutex_lock(&adev->grbm_idx_mutex); --> Line 250 (Lock A)
   mutex_lock(&adev->pm.mutex); --> Line 259 (Lock B)

amdgpu_set_power_dpm_force_performance_level()
   mutex_lock(&adev->pm.mutex); --> Line 381 (Lock B)
     pp_dpm_force_performance_level() --> function pointer via 
"amdgpu_dpm_force_performance_level()"
       pp_dpm_en_umd_pstate()
         amdgpu_device_ip_set_clockgating_state()
           gfx_v7_0_set_clockgating_state() --> function pointer via 
"funcs->set_clockgating_state()"
             gfx_v7_0_enable_mgcg()
               mutex_lock(&adev->grbm_idx_mutex); --> Line 3646 (Lock A)
               mutex_lock(&adev->grbm_idx_mutex); --> Line 3697 (Lock A)

When amdgpu_debugfs_process_reg_op() and 
amdgpu_set_power_dpm_force_performance_level() are concurrently 
executed, the deadlock can occur.

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
