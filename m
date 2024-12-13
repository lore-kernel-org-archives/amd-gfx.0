Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44277E77180
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 08:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4193610EF48;
	Fri, 13 Dec 2024 08:24:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJZTFsYU";
	dkim-atps=neutral
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC1010EF11
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 07:41:20 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so2525861a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734075679; x=1734680479; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ECAswhSjbBa0l5WXOE2XiUyA0/uxnQ2bbT4EuE3Nw5M=;
 b=rJZTFsYUqCCzhjHe91QFmrtQevoU0XsWy9yv6Kdw9FQjz0kvWa3dOxEqMi8THa+5kA
 IXYMPxF9pjcv6gngEdZEvz284XQUBnMC8x4R/1wj/SNmeahpD/BW2KKPUcBtmPZpx+65
 prXO/OSteAXbrdMDum/3PkSOYDIg9QRuCP1R8eMeRcF9rrWjZ0Cdp5XR3JoOLVd3CfA9
 azrUB2hrl7PS2FLlAJDucn2c++ejiSpfMWxLY3jxKjcpL+HsN7B7Co2XObKHs5+b9cgp
 7ISYuaZeY6j2E0YfSGWcPskAlDRhhonRuKktAOfy3BCeMc9z17exC0R4Jwscf7oQ8sqL
 +W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734075679; x=1734680479;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ECAswhSjbBa0l5WXOE2XiUyA0/uxnQ2bbT4EuE3Nw5M=;
 b=KIQtUzI1KL2NXIo77Ai09/NmFPpcvCJzhA+4JOAMe8ezCTSA8cDvFnqoXGJO/qSEu6
 d1H28vKSH6glg3B7EjG/uUNpYt9MxijcpSbuXB9fhqW6j/GgnpjeNIgTqebW9GDA5skS
 WCraUkW/jeNOL7HYyJDNR6J0jBDcWSN17VIm8Ft7CpY+JO2UY8otEHWovay7JAUIFFUt
 OT6YpG9ai87spp2mJbwlHNk/dkFbxuVW/nHEDmmuSku1aWJvo36eG/Nc5MnHQjXJV8ys
 fWEn4XSEi0l+RqtVzLIvGSvbsMqhygn1mc73VoYxMFtducw/DUDnanvsYVHe3SyvtQ+/
 JtTg==
X-Gm-Message-State: AOJu0Yxy3puxIgve32I25f9kNBjSBK18J/c/gs4znHd78JA3iih5tB1y
 oWzCZlNE8aL5z3j3Mb92TbuVX3Vqop/5PytPkobYJew2TkDUarYyFtCuAnBMzW4=
X-Gm-Gg: ASbGnctlXDZnoyZ/8zTz7ADges6tjlluvchCAFq9h2gH3/vsuOp9UyM2ah8rAsPLopw
 T7BtVLdayZcpqs3jxI5Q2ZYwFYtAlU17GG+G5HjBpdH70mxSoGuFNI0sO0c7R6u7TMK9Zp4uFpS
 bUz6jRjaz3E3+H8cTAKTGBG7j5wfQxr04eC6cqBsOvQ3R0u5t76GQ77ZKy2/9HwIM1svUIlIkVk
 CZtopWGuf9QOMvlHOffTNRRAamAR4sMi/YhbUEJK4NvNbOLRSRch3og9YY0Ng==
X-Google-Smtp-Source: AGHT+IHL6HVnn3gzbK7xOsJgeBTtrEHedemU+ZK48cGZknGZbGVAOSfA9w6GbYiTVe1HKURCAKHqRA==
X-Received: by 2002:a05:6402:4582:b0:5cf:e71c:ff88 with SMTP id
 4fb4d7f45d1cf-5d63c2e9de7mr1256322a12.4.1734075678714; 
 Thu, 12 Dec 2024 23:41:18 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d42a754cb0sm4025883a12.88.2024.12.12.23.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 23:41:18 -0800 (PST)
Date: Fri, 13 Dec 2024 10:41:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tao Zhou <tao.zhou1@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: parse legacy RAS bad page mixed with new
 data in various NPS modes
Message-ID: <f647df3b-42da-4e61-8eee-239408ed4556@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 13 Dec 2024 08:24:48 +0000
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

Hello Tao Zhou,

Commit a8d133e625ce ("drm/amdgpu: parse legacy RAS bad page mixed
with new data in various NPS modes") from Oct 31, 2024 (linux-next),
leads to the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2849 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_umc_pages_in_a_row()' failed.
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2884 amdgpu_ras_add_bad_pages() warn: missing error code here? 'amdgpu_ras_mca2pa()' failed.

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
    2800 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
    2801                 struct eeprom_table_record *bps, int pages, bool from_rom)
    2802 {
    2803         struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
    2804         struct ras_err_handler_data *data;
    2805         struct ras_err_data err_data;
    2806         struct eeprom_table_record *err_rec;
    2807         struct amdgpu_ras_eeprom_control *control =
    2808                         &adev->psp.ras_context.ras->eeprom_control;
    2809         enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
    2810         int ret = 0;
    2811         uint32_t i, j, loop_cnt = 1;
    2812         bool find_pages_per_pa = false;
    2813 
    2814         if (!con || !con->eh_data || !bps || pages <= 0)
    2815                 return 0;
    2816 
    2817         if (from_rom) {
    2818                 err_data.err_addr =
    2819                         kcalloc(adev->umc.retire_unit,
    2820                                 sizeof(struct eeprom_table_record), GFP_KERNEL);
    2821                 if (!err_data.err_addr) {
    2822                         dev_warn(adev->dev, "Failed to alloc UMC error address record in mca2pa conversion!\n");
    2823                         ret = -ENOMEM;
    2824                         goto out;
    2825                 }
    2826 
    2827                 err_rec = err_data.err_addr;
    2828                 loop_cnt = adev->umc.retire_unit;
    2829                 if (adev->gmc.gmc_funcs->query_mem_partition_mode)
    2830                         nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
    2831         }
    2832 
    2833         mutex_lock(&con->recovery_lock);
    2834         data = con->eh_data;
    2835         if (!data)
    2836                 goto free;

I guess this is intentionally success?

    2837 
    2838         for (i = 0; i < pages; i++) {
    2839                 if (from_rom &&
    2840                     control->rec_type == AMDGPU_RAS_EEPROM_REC_MCA) {
    2841                         if (!find_pages_per_pa) {
    2842                                 if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
    2843                                         if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
    2844                                                 /* may use old RAS TA, use PA to find pages in
    2845                                                  * one row
    2846                                                  */
    2847                                                 if (amdgpu_umc_pages_in_a_row(adev, &err_data,
    2848                                                                 bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
    2849                                                         goto free;

This should be an error code.

    2850                                                 else
    2851                                                         find_pages_per_pa = true;
    2852                                         } else {
    2853                                                 /* unsupported cases */
    2854                                                 goto free;

Error code.

    2855                                         }
    2856                                 }
    2857                         } else {
    2858                                 if (amdgpu_umc_pages_in_a_row(adev, &err_data,
    2859                                                 bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
    2860                                         goto free;

Error code.

    2861                         }
    2862                 } else {
    2863                         if (from_rom && !find_pages_per_pa) {
    2864                                 if (bps[i].retired_page & UMC_CHANNEL_IDX_V2) {
    2865                                         /* bad page in any NPS mode in eeprom */
    2866                                         if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data))
    2867                                                 goto free;

Error code.

    2868                                 } else {
    2869                                         /* legacy bad page in eeprom, generated only in
    2870                                          * NPS1 mode
    2871                                          */
    2872                                         if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
    2873                                                 /* old RAS TA or ASICs which don't support to
    2874                                                  * convert addrss via mca address
    2875                                                  */
    2876                                                 if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
    2877                                                         find_pages_per_pa = true;
    2878                                                         err_rec = &bps[i];
    2879                                                         loop_cnt = 1;
    2880                                                 } else {
    2881                                                         /* non-nps1 mode, old RAS TA
    2882                                                          * can't support it
    2883                                                          */
--> 2884                                                         goto free;

Error code.

    2885                                                 }
    2886                                         }
    2887                                 }
    2888 
    2889                                 if (!find_pages_per_pa)
    2890                                         i += (adev->umc.retire_unit - 1);
    2891                         } else {
    2892                                 err_rec = &bps[i];
    2893                         }
    2894                 }
    2895 
    2896                 for (j = 0; j < loop_cnt; j++) {
    2897                         if (amdgpu_ras_check_bad_page_unlock(con,
    2898                                 err_rec[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
    2899                                 continue;
    2900 
    2901                         if (!data->space_left &&
    2902                             amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
    2903                                 ret = -ENOMEM;
    2904                                 goto free;
    2905                         }
    2906 
    2907                         amdgpu_ras_reserve_page(adev, err_rec[j].retired_page);
    2908 
    2909                         memcpy(&data->bps[data->count], &(err_rec[j]),
    2910                                         sizeof(struct eeprom_table_record));
    2911                         data->count++;
    2912                         data->space_left--;
    2913                 }
    2914         }
    2915 
    2916 free:
    2917         if (from_rom)
    2918                 kfree(err_data.err_addr);
    2919 out:
    2920         mutex_unlock(&con->recovery_lock);
    2921 
    2922         return ret;
    2923 }

regards,
dan carpenter
