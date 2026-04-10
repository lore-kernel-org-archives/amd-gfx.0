Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A99BEBFD16
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D2910E35F;
	Mon, 13 Apr 2026 08:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYiOli/F";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFE010E8AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 07:06:56 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so19295535e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775804815; x=1776409615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cOBE4Zk7Ie2nnzrPJPwRrqSdaHEJi977p/pY63odXY=;
 b=OYiOli/FgGthh5Odq8lGoEeqbgKosjURCYlhkPQ2NNw3us2dZQxegRQOjnNv0R4B+L
 jBlj974Dhl4DbqIKEWl385lCIoJS54g6ev+C8BCSsaDsfgCl6lTUnJiyDqz7tcvfhzmu
 OFEa839aSZBAklik2VBWrlb+u4mTX6WdAZBeEN9hen23Vii54gvN06AEBue5X7AZE1tc
 IyHLbG9g3haokQqc7cnkxBccWetQ+bBb3jToVSQXtZVHU/+fmPSFqCGSMgbuUAyFhmHL
 RL1v/J4PZdmQuSaAsWU2xhYKqWkdjpeyW5ks5QyHjYUoyg8F4wMXFQBBMhAx1c4Kvh4M
 Okuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775804815; x=1776409615;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cOBE4Zk7Ie2nnzrPJPwRrqSdaHEJi977p/pY63odXY=;
 b=kBa6jtwF/2WhImxfjc8cw94oxPuxW29bSHXfhNUULbcuZBLUiEz+ABWAw9ceO/d2x3
 anO//05UJT8Ywj2TA7pVkn698+OmdMqQVMboBO9FsFMeWGm5VPNXyoonTe1TYBSrDk6U
 PvRHe/sAmjkzNRadjjHF1nrR44WWAhC1vsCb/TeB+vgUmcd78FDniXvjUBElEC2o9lY+
 qO78IBqmWX+Wje3Pnw6nxDRbyWZgyfNZkJXrgmyTRDinccpX666mNA0Ww2JWD17NEW/Q
 qkeeANdoxM8dNmEhHSGZsqx6qkS7FdQp+mILoHdhZFQL4B5PovU4IfQHmH77cq/aboOg
 owmg==
X-Gm-Message-State: AOJu0Yz0N/fl4+hrAekEOFvJFo+cKaTPddLmgTzEGkU4qIYGeIsyaPmc
 puFeenoREt/wVQDlOLKoGcuButoqgTpgd6jDZ8/48y1k0HUY+3o1CiehZpWvjg==
X-Gm-Gg: AeBDievfVDx5k/CRzBHYPTuyvxwYQSaFkPBsy815IpWG4tkb2dnmWyzhDwvYcUsOSXe
 zc9nKXUphZOs78zUSVlVT6WA4WUIyQ4tv8faS4rMLgepVnu0oTBjNMb5p4g07kU+uOLIvuG/uum
 pR0OC2qypLlsHfjzqbqYTw/rd4Azp8SIYM1tgl4KvEK73p+pO9BOcXcE0B2cb8OcUKEejP6p5VK
 n1Co6dmmegqJK9DJhaJd9XsT4AAc3onLlFSAg8qwMFpTwSB3lPJL0MtwZK1TF9yP1lkXHJTkps9
 lUBDIuHUs1zPgRQGOgvNuWHYN6clIoZtnTW8ZS7b8ydFE/Djz6b8yc4YC0kDgtZwiryTCl8QV0x
 TYhC257I5ZKO1wAcDA8vk+J4iQ9wqG79HxvZ1xaYWTCbQyvpUObhYfMUeYrhz61WpLub9h7BlqY
 Oi5R6EbRVnZw0K3g9MuOs=
X-Received: by 2002:a05:600c:a30b:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-488d67eb7e1mr17557915e9.6.1775804814786; 
 Fri, 10 Apr 2026 00:06:54 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d85ae9sm19805735e9.3.2026.04.10.00.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 00:06:54 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:06:51 +0300
From: Dan Carpenter <error27@gmail.com>
To: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/pm/smu7: Remove non-functional SMU7 voltage
 dependency on DAL
Message-ID: <adihi9-97_oI3uBc@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:02:59 +0000
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

Hello Timur Kristóf,

Commit 9f49e3d4cb86 ("drm/amd/pm/smu7: Remove non-functional SMU7
voltage dependency on DAL") from Mar 29, 2026 (linux-next), leads to
the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:3065 smu7_hwmgr_backend_init()
	warn: duplicate zero check 'result' (previous on line 3054)

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c
    3024 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
    3025 {
    3026         struct amdgpu_device *adev = hwmgr->adev;
    3027         struct smu7_hwmgr *data;
    3028         int result = 0;
    3029 
    3030         data = kzalloc_obj(struct smu7_hwmgr);
    3031         if (data == NULL)
    3032                 return -ENOMEM;
    3033 
    3034         hwmgr->backend = data;
    3035         smu7_set_sclk_cap(hwmgr);
    3036         smu7_patch_voltage_workaround(hwmgr);
    3037         smu7_init_dpm_defaults(hwmgr);
    3038 
    3039         /* Get leakage voltage based on leakage ID. */
    3040         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
    3041                         PHM_PlatformCaps_EVV)) {
    3042                 result = smu7_get_evv_voltages(hwmgr);
    3043                 if (result) {
    3044                         pr_info("Get EVV Voltage Failed.  Abort Driver loading!\n");
    3045                         kfree(hwmgr->backend);
    3046                         hwmgr->backend = NULL;
    3047                         return -EINVAL;
    3048                 }
    3049         } else {
    3050                 smu7_get_elb_voltages(hwmgr);
    3051         }
    3052 
    3053         result = smu7_init_voltage_dependency_on_display_clock_table(hwmgr);
    3054         if (result)
    3055                 goto fail;
    3056 
    3057         if (hwmgr->pp_table_version == PP_TABLE_V1) {
    3058                 smu7_complete_dependency_tables(hwmgr);
    3059                 smu7_set_private_data_based_on_pptable_v1(hwmgr);
    3060         } else if (hwmgr->pp_table_version == PP_TABLE_V0) {
    3061                 smu7_patch_dependency_tables_with_leakage(hwmgr);
    3062                 smu7_set_private_data_based_on_pptable_v0(hwmgr);
    3063         }
    3064 
--> 3065         if (result)
    3066                 goto fail;

The commit deleted the function call but left the error checking.

    3067 
    3068         data->is_tlu_enabled = false;
    3069 
    3070         hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
    3071                                                         SMU7_MAX_HARDWARE_POWERLEVELS;
    3072         hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
    3073         hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
    3074 
    3075         data->pcie_gen_cap = adev->pm.pcie_gen_mask;
    3076         if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
    3077                 data->pcie_spc_cap = 20;
    3078         else
    3079                 data->pcie_spc_cap = 16;
    3080         data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
    3081 
    3082         hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
    3083         /* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
    3084         hwmgr->platform_descriptor.clockStep.engineClock = 500;
    3085         hwmgr->platform_descriptor.clockStep.memoryClock = 500;
    3086         smu7_thermal_parameter_init(hwmgr);
    3087 
    3088         result = smu7_update_edc_leakage_table(hwmgr);
    3089         if (result)
    3090                 goto fail;
    3091 
    3092         return 0;
    3093 fail:
    3094         smu7_hwmgr_backend_fini(hwmgr);
    3095         return result;
    3096 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
