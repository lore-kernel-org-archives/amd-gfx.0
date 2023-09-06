Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B9EB8FD2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 13:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2E310E651;
	Wed,  6 Sep 2023 13:25:08 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665BC10E184
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 09:39:52 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso2712121f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693993191; x=1694597991; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+umOskM6kL2Z0E4/XXUPFHvWCL6vtXkCEL6aTz+tIx0=;
 b=uoPRCpqs4EFNXnziWk9MQgGE9VTAJrQIGvxYawRSWuhzPe8vUjWjCC0NHttdQNxQ7v
 ZHnxxjAQ5NcdqGbWNMxvB36uXEplc/Cyn9ADympnr2padm5h+c+qAmiEdDGOERvPaPLQ
 xcwREdrciDfKvQPn2TXC/Yp5b3cO62QfF2WDYM+E5fzVuROp2mqbju3hqQYE8jTlsLhb
 LowA8jCcIguVkFsBjDEn1Hp10q9hcT/5oGqrkCmTdIbuPpNMGYmHuzd9WvrmnyKQWWSB
 tj2050I867MOKO6RBTBwskkEcH2fffu6qHg5k2zFlZQhUXbw38Zy2mAGEq6GOPtD4Itn
 L0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693993191; x=1694597991;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+umOskM6kL2Z0E4/XXUPFHvWCL6vtXkCEL6aTz+tIx0=;
 b=i/ovco1UV1xsEQFWrS3cj1JMG7dpn5WmlGrGTIWzUQ8i8YRc7pJvip40ArFn6IdJlh
 /w0hvaFotiV4oaFuITeiVSXecADBqK9tFlV27q/Djxc7x47fHEobqHcJ6/et2H6/z70M
 z2MLHsC3ugJa9JqBDQO33RZ4nS4jdwbxYCg4IqmNF4x8M4lYdWtK9ShUErDGB30m/WRw
 GijmrxWv2/yqAvRxQdb16DeGJfrdHj7gNx1/3dRs/7uwHcW04uCUkv1VphgvF1PVGnx+
 MXYVEgB3rFW2wwhQLLP/hDbvL50i0RTIpkxw75oEX1qHCF+YLOG5Qz8Mgo4QDpYt05on
 C70A==
X-Gm-Message-State: AOJu0Yxdhro7dUwhwvZbK8nM4vHJz5uxdy2cOihrEN2Yu+v65lAwdJJR
 cFYflYL8ex4fqxJUiQYl3lZpFKTn65rqYGaYDb0=
X-Google-Smtp-Source: AGHT+IFKnnCjQ1hb8/JMdKFG6Mgx1fqwOWaamjpfTjL8cD2U5tTL3NszqH2N93fX2AxGas2HeCMCHw==
X-Received: by 2002:adf:f291:0:b0:317:3f64:4901 with SMTP id
 k17-20020adff291000000b003173f644901mr2047436wro.41.1693993190776; 
 Wed, 06 Sep 2023 02:39:50 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d4e8d000000b0031c6cc74882sm19946439wru.107.2023.09.06.02.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:39:50 -0700 (PDT)
Date: Wed, 6 Sep 2023 12:39:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lang.Yu@amd.com
Subject: [bug report] drm/amdgpu: add selftest framework for UMSCH
Message-ID: <dd425f64-868a-470f-b78c-8bf6a7b7daa9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 06 Sep 2023 13:25:05 +0000
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

Hello Lang Yu,

The patch 5d5eac7e8303: "drm/amdgpu: add selftest framework for
UMSCH" from Jun 21, 2023 (linux-next), leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:338 setup_umsch_mm_test()
	warn: unsigned error codes 'test->pasid'

drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
    319 static int setup_umsch_mm_test(struct amdgpu_device *adev,
    320                           struct umsch_mm_test *test)
    321 {
    322         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
    323         int r;
    324 
    325         test->vm_cntx_cntl = hub->vm_cntx_cntl;
    326 
    327         test->vm = kzalloc(sizeof(*test->vm), GFP_KERNEL);
    328         if (!test->vm) {
    329                 r = -ENOMEM;
    330                 return r;
    331         }
    332 
    333         r = amdgpu_vm_init(adev, test->vm, -1);
    334         if (r)
    335                 goto error_free_vm;
    336 
    337         test->pasid = amdgpu_pasid_alloc(16);
--> 338         if (test->pasid < 0) {
                    ^^^^^^^^^^^^^^^
Unsigned can't be less than zero.

    339                 r = test->pasid;
    340                 goto error_fini_vm;
    341         }
    342 
    343         r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ctx_data),

regards,
dan carpenter
