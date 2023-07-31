Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EA5C001E0
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABED10E335;
	Tue,  1 Aug 2023 08:27:47 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BBB10E1B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 07:24:01 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3176a439606so3698787f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690788239; x=1691393039;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GDv3qKhUocp9vQIpWuNn7A3ct9SRLnsAqxNrLpEWSRw=;
 b=VMXNVL2Oq3cPE0S2ntOlhyFyEA9jwQS8YC9UxUY2aNiHkwzvhu2lWnLXD/r6CD/EjE
 zlaxHRzpLLokCoS8OChhlzJh2NAr8gPIci5B79MpALVI25cnNf/RZ+ew3EESElp73Zkp
 as81F7GMLhBr2ytR+8BVs043cLVKCljn82aY9Ntr+zi5mAsJyPOuqKYIB1r/gjsIt+dH
 UoNVOxdJFbode0ZROeZhg/txEU6nMA1zTAal1ml/2SFYS7Nkrzchje7BNS/QRP/jjUhu
 C4vpktLVkvOvNeVmwhavMSiyWHjz5uC102aFh/+W3wxPcxMD/VHAe1OEFtRvSf4e+WaG
 3GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690788239; x=1691393039;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GDv3qKhUocp9vQIpWuNn7A3ct9SRLnsAqxNrLpEWSRw=;
 b=lqgBK0HJDpbZlgYGCR1sHjHJ2DoIB+sYv96XUoTLpfrz4WNThsyjljTfYEx4GCk/ht
 ysvHXl6MrrutYCo9ZVOi8Cpz9a5OzXEntj+GaANDMJGtKjBa9qzUz150+FdClhjwfY1n
 CkiOVhQPioJNvPmABj9aO5O9L7pJdy1z2N2EM7fj3aWEf3HdR6CFYH/5395IfAIvCAls
 NPsJXDwtQr7q3wGAHxvQmK7pyHsiCXSLULK6soD0VIUKvdPC5VmJdpq4VV241HFJeXbG
 VmyIWQlOSdlM9rfzZ/nUn75epTbquP9GnVbcwhIO0pJWwa9vMgronCCxO95hqTuRp+7y
 qDbA==
X-Gm-Message-State: ABy/qLa9Mpor64UduMjhcMYHFcOsPWlyhAV3uBWrplldkRox7FzO6TFs
 7hRpCDQnx50wqBSgjA2somdNGA==
X-Google-Smtp-Source: APBJJlG182tGjUCnhlcvquzg/NE6PvguLCvYMhO2Ef+vm+Kh2mNG2PzwyW3xLMduaAMev8+BZW2+EQ==
X-Received: by 2002:a5d:470e:0:b0:314:37e7:efb4 with SMTP id
 y14-20020a5d470e000000b0031437e7efb4mr5617503wrq.11.1690788239642; 
 Mon, 31 Jul 2023 00:23:59 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 y18-20020a5d6212000000b003143c6e09ccsm12199851wru.16.2023.07.31.00.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 00:23:59 -0700 (PDT)
Date: Mon, 31 Jul 2023 09:32:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: kevin1.wang@amd.com
Subject: [bug report] drm/amdgpu: optimize amdgpu device attribute code
Message-ID: <9ea841e4-325f-4076-8409-fbad9bb47196@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 01 Aug 2023 08:27:46 +0000
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

Hello Kevin Wang,

This is a semi-automatic email about new static checker warnings.

The patch 4e01847c38f7: "drm/amdgpu: optimize amdgpu device attribute 
code" from Apr 27, 2020, leads to the following Smatch complaint:

    ./drivers/gpu/drm/amd/pm/amdgpu_pm.c:2182 amdgpu_device_attr_create()
    warn: variable dereferenced before check 'attr' (see line 2175)

./drivers/gpu/drm/amd/pm/amdgpu_pm.c
  2174		struct device_attribute *dev_attr = &attr->dev_attr;
  2175		const char *name = dev_attr->attr.name;
                                   ^^^^^^^^^^
Dereferenced.

  2176		enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
  2177		struct amdgpu_device_attr_entry *attr_entry;
  2178	
  2179		int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
  2180				   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
  2181	
  2182		BUG_ON(!attr);

Checked to late.  Also doesn't checkpatch warn about this?  Calling
BUG_ON() here is not correct.

  2183	
  2184		attr_update = attr->attr_update ? attr->attr_update : default_attr_update;

regards,
dan carpenter
