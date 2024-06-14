Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AC9C27C7B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 07:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CF910E20A;
	Mon, 17 Jun 2024 07:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JCvetCPT";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CBCD10EA93
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 17:32:45 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4218314a6c7so22079325e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718386364; x=1718991164; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MuiwrOWKydZxzbMQCLqt9aUARsxovDhCPETOH8YTwYM=;
 b=JCvetCPTkgahEoExqXFAD8OkNQTZQBA1CFTFuY7BnlVKWxpw5S0NEVSEKz8Kp9Ioq9
 hQ7C82bhlogSn3WvEAwUO/404fscxtie08Oesh/7zBRHHGb/tkKtScMnkCcP2UCGWV38
 IhCGYT8uYcPJNwJBVHCL5bjkhir/vKXDs0fHj3rVsTkiI8vv6Zxk5q7lYA3c9EhwX96T
 FyFyfxsufXzKRfhWBS3F9KonZ51jMt05iQ5g6xC5hzhPP35QFza8Ex8HBUl9FUqURH+L
 lPH0dwtkij1WtnAewcFcfM5KwjISgnG15//Mvwhp69tCiW8Osvvno7ayPrZR+5LojDRp
 fDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718386364; x=1718991164;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MuiwrOWKydZxzbMQCLqt9aUARsxovDhCPETOH8YTwYM=;
 b=A6mBBr37Gq74OlwDcX0m1jVHa2g7w5Nz105oXea3xgnp5cV71OSGC6U2bUjXfojgl2
 Px0PVIY/UflKdYagELYEXaRBoJoIpwwMMZNlH7oCFluY5grY3spsdKn7iIGAGo2Iy/sq
 v3teA6H3lnydVDy6dOVTzvh8SRcX/549tfjha3cLLlv0f58jTqPOQO2o91uuuIoXAfgd
 vlXuJYS0V+YBfriKbG8PP/8YJMCn88MbGc3BL2NbEntsUqWuJHfY38qEfP47S2rrF7Ls
 8JslbEePMfOwnVd9LmS6zg6OB5r/ET+6effB2hj04kZnaEDnYaLAQt9V6Cl5YNrEL/y+
 CW0A==
X-Gm-Message-State: AOJu0YyUhywQ7sqX5810BLADdGoM38jYprzoLYKiyUErf09FK2es4XLt
 3W9G+kQdb7b2sEReRu/DwPeqGXvA0krr8IJFl52UKoQZCmiPRCJQeorZKJTuFQs=
X-Google-Smtp-Source: AGHT+IHLfWhOPOk9PI+nGjgZ5O75BiVMZ69UXzYtuN6i9kl5WrecgTSpA1/kp0Qt21ECUjcwTNOIJA==
X-Received: by 2002:a05:600c:35c3:b0:422:760c:e8b9 with SMTP id
 5b1f17b1804b1-4230485a5b5mr29260565e9.35.1718386363662; 
 Fri, 14 Jun 2024 10:32:43 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e7469sm110740865e9.46.2024.06.14.10.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 10:32:43 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:32:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: add init support for GFX11 (v2)
Message-ID: <de2c1169-4787-4686-96eb-f5d7c1323494@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 17 Jun 2024 07:14:59 +0000
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

Hello Hawking Zhang,

Commit 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
from Apr 13, 2022 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4503 gfx_v11_0_hw_init()
	error: we previously assumed 'adev->gfx.imu.funcs' could be null (see line 4497)

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
    4491 static int gfx_v11_0_hw_init(void *handle)
    4492 {
    4493         int r;
    4494         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
    4495 
    4496         if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
    4497                 if (adev->gfx.imu.funcs) {
                             ^^^^^^^^^^^^^^^^^^^
Check for NULL

    4498                         /* RLC autoload sequence 1: Program rlc ram */
    4499                         if (adev->gfx.imu.funcs->program_rlc_ram)
    4500                                 adev->gfx.imu.funcs->program_rlc_ram(adev);
    4501                 }
    4502                 /* rlc autoload firmware */
--> 4503                 r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
                                                                    ^^^^
Unchecked dereference inside the function.  (Probably just delete the
NULL check?)

    4504                 if (r)
    4505                         return r;
    4506         } else {

regards,
dan carpenter
