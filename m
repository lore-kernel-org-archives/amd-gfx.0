Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9110C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 07:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC37110E061;
	Fri, 19 May 2023 07:12:12 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59AAB10E5D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:52:51 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f41d087b3bso28758825e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 23:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684479168; x=1687071168;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6j0HuL7/BsMUTdgO8ApRJZaLD86emsE3OvsZeTdmn4=;
 b=REdQRbjP6TBQ2+pE8hDr/krMFIDzIu99DJK3I5otAdGYJsJ43pJMCjgWgNg2EFvaQ/
 9QjPoKG5wCSNui6SIv/YmBZKx+nz51dA7V2vTax7tdqFlXNxSYzIRJgzahIV/mEsLkOX
 flfJE3xkCpnFJDZZsdylrm6owTFJ+nEOdgm8wJCSY70JqpBlo0J/N0M8hU/PKcMAIxMW
 ccMw3+k4EwKSlpNhr0vEpO/rMDXeIpIItdVW22SlJrVRFkv1yK9KG7PtUBCLHaWBL/h1
 pE9J/kkmUeG3NoKrQv7Ow8XqsrBW6wn5p+Cspp0tT+43kLA0Bx5Vm2vLtZJ2DNrcaLhi
 9M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684479168; x=1687071168;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6j0HuL7/BsMUTdgO8ApRJZaLD86emsE3OvsZeTdmn4=;
 b=UQJWEa6M0H6p5R2WUDR7sBe1zu3JzqAuYeUaBBJVCPPTHJ8qqpiOb0NxlD4YwExLL8
 l9a/8aFLqQVJZq6voLrXQ8fPhrLZ/limMR/FETqaBYthDUWm7tsipahXBGmwa77OBalA
 9x87RiL0Hsozjf18sKG/IMudnqwYNYTR2355h37QURJ33+pbZJbUJuRyfG+VzzOG3s+u
 7gEdXen9QlI1xrByyOREYoKU8dAxPbKoK6uqLZL4fjCQa3aBypu2kJ8gyyU4SejLepUa
 R1L/3ETH+hqueTLrOSi8XVBYwSt0roKAE9+nDpNQIeYDv3Hon3uA89y5jZP7pRbnIyl+
 ZtMA==
X-Gm-Message-State: AC+VfDz4VOJ3pieT2FmpEvHdqB1XQ68+t7XBiB02kpkAy4Kg/pEKwYjS
 QPksQviIqqeWdNh2ZK/+UZ5H25IaRnKpXrpMoVI=
X-Google-Smtp-Source: ACHHUZ4aB/7KuW6gGLqSZAoEqzvIq8wx+Pzlow6IKLxD1oiuJhrPWGUVcL35rpSN1BjfkXqlaGpZ1Q==
X-Received: by 2002:a7b:cc88:0:b0:3f1:8223:6683 with SMTP id
 p8-20020a7bcc88000000b003f182236683mr447514wma.40.1684479168517; 
 Thu, 18 May 2023 23:52:48 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 u8-20020a5d6ac8000000b003079ed1f0a0sm4281023wrw.44.2023.05.18.23.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 23:52:45 -0700 (PDT)
Date: Fri, 19 May 2023 09:52:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: eryk.brol@amd.com
Subject: [bug report] drm/amd/display: Add connector HPD trigger debugfs entry
Message-ID: <3e6fe012-1c2d-49af-ad3c-ecc89ab13254@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 19 May 2023 07:12:11 +0000
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

Hello Eryk Brol,

This is a semi-automatic email about new static checker warnings.

The patch 6f77b2ac6280: "drm/amd/display: Add connector HPD trigger
debugfs entry" from Aug 10, 2020, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c:1220 trigger_hotplug()
    warn: variable dereferenced before check 'aconnector' (see line 1210)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_debugfs.c
  1204  static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
  1205                                                          size_t size, loff_t *pos)
  1206  {
  1207          struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
  1208          struct drm_connector *connector = &aconnector->base;
                                                   ^^^^^^^^^^^^^^^^
Not a dereference.

  1209          struct dc_link *link = NULL;
  1210          struct drm_device *dev = connector->dev;
                                         ^^^^^^^^^^^^^^
Argh... dereference.

  1211          struct amdgpu_device *adev = drm_to_adev(dev);
  1212          enum dc_connection_type new_connection_type = dc_connection_none;
  1213          char *wr_buf = NULL;
  1214          uint32_t wr_buf_size = 42;
  1215          int max_param_num = 1;
  1216          long param[1] = {0};
  1217          uint8_t param_nums = 0;
  1218          bool ret = false;
  1219  
  1220          if (!aconnector || !aconnector->dc_link)
                    ^^^^^^^^^^^
Too late.  Dead already.

  1221                  return -EINVAL;
  1222  
  1223          if (size == 0)

regards,
dan carpenter
