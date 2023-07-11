Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F92EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 07:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EB110E31D;
	Tue, 11 Jul 2023 07:20:57 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E428C10E31D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 06:59:58 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so58741845e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689058797; x=1691650797;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5c93+UQSjU96hXyZaMkQ2KpRiTYS97ov4RhE7NQ+PpA=;
 b=LFU3pcsSdYLGilj1hHj5yuPmcx5rpq7GD148xS3xaSeD91fUfrBncbZr5wb/m7hD6t
 3qGZjEWUtOGK76puE5CPlpgcmST1rE4IS7Dpo3epIrv18y0+rOZAdhwtv3dj3niX5D/X
 fVI1arXkfv7nalkoqyVSKnipnCP/FziiHxn2bJH7x6oe84VJXGOme+c1F4+42vPLqR8T
 j4AWb0NIRRGxmJA4ixXAEFxgUtcnruAmx1x04sYB7QU9623P/qP+Obj+TcIUBChBukn4
 S487tKbzwzGxowSQgEtUIPhwS2rVpmywEFRSe7YwauUt9rWyicKZ0FZ8HNpbLEQqKQbl
 BEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689058797; x=1691650797;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5c93+UQSjU96hXyZaMkQ2KpRiTYS97ov4RhE7NQ+PpA=;
 b=Exx7WjlRSE0bElkCZLlDR2lUosaO6t4O4Y1Y/57bxnkxVO+QUk8i7iIAvKFsHMPR6+
 0YVmIvN+XIjxUzARu9DgUWbNcF33kEgR/Oy3Ztpey4UtwSTozQrExuCPIhw6WVNE1ZXm
 t0fgiJ3vPllqvdOl8/jXnsn94Lfy7i9vsJvdIjDW2N5Ae+eVeXyolace32LTueofk3Lb
 ZBpmORElwEBi4yLcF1wgoMtdrn031MwOFWYIWmu+bQSzR3Zrze5GLteWg+608Ehvpiub
 cfURXTRfUzj2B43FcCf18oV+Nl7Xvnh0IIV7A/xxhi2Hs3UBxfiNDF25H8UXF95ZsdhK
 ue5w==
X-Gm-Message-State: ABy/qLYYjD3WnLOO+knUaRleb4PJ1yGNrscSoj9X2rxE714NxYaNhli8
 ClRI08N+HbRWZSaKhDUbh1w93A==
X-Google-Smtp-Source: APBJJlGKmLF4OZqmFcVhe0OWBS8QByfdrNaX0+HYd+P0fh3gYxHqMKSU+Fi8RVJS5jgK/azh8K06Pw==
X-Received: by 2002:a1c:e90a:0:b0:3fb:fb88:974b with SMTP id
 q10-20020a1ce90a000000b003fbfb88974bmr13554398wmc.6.1689058797296; 
 Mon, 10 Jul 2023 23:59:57 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 f15-20020a7bc8cf000000b003fbaa2903f4sm1620788wml.19.2023.07.10.23.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 23:59:55 -0700 (PDT)
Date: Tue, 11 Jul 2023 09:59:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jack.Xiao@amd.com
Subject: [bug report] drm/amdgpu/gfx11: add aggregated doorbell support
Message-ID: <89a9bae8-405c-45c9-a0fc-2ea79b4fca6a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 11 Jul 2023 07:20:56 +0000
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

Hello Jack Xiao,

The patch af019bef6d6f: "drm/amdgpu/gfx11: add aggregated doorbell
support" from Jul 11, 2022, leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:5193 gfx_v11_0_ring_set_wptr_gfx()
	warn: duplicate check '*is_queue_unmap'

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
    5166 static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
    5167 {
    5168         struct amdgpu_device *adev = ring->adev;
    5169         uint32_t *wptr_saved;
    5170         uint32_t *is_queue_unmap;
    5171         uint64_t aggregated_db_index;
    5172         uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
    5173         uint64_t wptr_tmp;
    5174 
    5175         if (ring->is_mes_queue) {
    5176                 wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
    5177                 is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
    5178                                               sizeof(uint32_t));
    5179                 aggregated_db_index =
    5180                         amdgpu_mes_get_aggregated_doorbell_index(adev,
    5181                                                                  ring->hw_prio);
    5182 
    5183                 wptr_tmp = ring->wptr & ring->buf_mask;
    5184                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
    5185                 *wptr_saved = wptr_tmp;
    5186                 /* assume doorbell always being used by mes mapped queue */
    5187                 if (*is_queue_unmap) {
                             ^^^^^^^^^^^^^^^
Non-zero here.

    5188                         WDOORBELL64(aggregated_db_index, wptr_tmp);
    5189                         WDOORBELL64(ring->doorbell_index, wptr_tmp);
    5190                 } else {
    5191                         WDOORBELL64(ring->doorbell_index, wptr_tmp);
    5192 
--> 5193                         if (*is_queue_unmap)
                                     ^^^^^^^^^^^^^^^
You would think it's zero here.  Although, possibly this value is
getting set in another thread?

    5194                                 WDOORBELL64(aggregated_db_index, wptr_tmp);
    5195                 }
    5196         } else {
    5197                 if (ring->use_doorbell) {
    5198                         /* XXX check if swapping is necessary on BE */
    5199                         atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
    5200                                      ring->wptr);
    5201                         WDOORBELL64(ring->doorbell_index, ring->wptr);
    5202                 } else {
    5203                         WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
    5204                                      lower_32_bits(ring->wptr));
    5205                         WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
    5206                                      upper_32_bits(ring->wptr));
    5207                 }
    5208         }
    5209 }

regards,
dan carpenter
