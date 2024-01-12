Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204FAC4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 14:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A43910EB1C;
	Fri, 12 Jan 2024 14:37:35 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCAF10EAF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 14:29:40 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e68ca8ec8so3073805e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705069778; x=1705674578; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zc2S9jFc1tdc8vnKF9LZyXuxZA8/4RPjvT94YpZ5NUo=;
 b=wr1dsNwSdMpYw0K2SdU78Ti4zlGmt0n8M1/NYyFX97A7LN7t5Shq0BpMxaoBCjFl54
 lmnhNWCRYshBY7CdduAhwurtbZTzUt62NnA8xoUWNA3487u7952W859YoTZNJWq9vLue
 z7xuW28Auo2ELTx3fd92UijT+7S4Gglmx9sCi/kDCvAn9nJi9ELHhzfTWa5I8R8g6IlN
 YVwB+gyowl9moTCX/bvIJgQEG893Z90kW4FgQwCOT+6obwcJtTExIgtxOeq24/tYv1Zm
 gz7hV3qLhzzT3oq0XK39syaXjX6TrJ987DHLy+xhdW8gPeZcQqw86xoet2OjglesMee9
 g0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705069778; x=1705674578;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zc2S9jFc1tdc8vnKF9LZyXuxZA8/4RPjvT94YpZ5NUo=;
 b=JqOqnWzjRm+gtFbDCdSzYfCNON3W2Yb8YvheO5IyPqsbJBLxbop2PnTZbVpaOlMEtH
 20ADBawkyoSBgpx6/eQPwvGx3j4/wQg8T7012fLojap8N8FOzhPgsyaWTf1Ehd/vjSN2
 2mDYjz4W4MmB9er6Fr3NSfJq7JxYjq8q+SEzVf7mjoewIVkrBnsbmOdnxHT9qtQmtIEh
 Jq+Jok71ASeEC9a3SJ5a4F9tGTHotzuq05i9pNGUMO8kMuLsH+e5yRmvw7eNdifKkEC4
 Q8l2lCWn0nLuxEDnlWsCwjuE29A3GACVFtKk2vKpyoQMGAR/H0fAnPkxeiaC2pFBBBn3
 Rx+A==
X-Gm-Message-State: AOJu0YwxpTd3VzBUYyzx7f7k1rn/BngmFNXKb0YQKxhSIrbp5V8m5NNl
 x9aSdudIPmSzYTPPpXObBYeb00DdgPnBSw==
X-Google-Smtp-Source: AGHT+IEtGwGHJe/l5XL0J4j9NfILvcBrdtM1mw4dHKE3XVeof2gNkEgTfUrMYh0SmSkjDv5jHGn+aQ==
X-Received: by 2002:a05:600c:1e17:b0:40d:5bbf:71f2 with SMTP id
 ay23-20020a05600c1e1700b0040d5bbf71f2mr868195wmb.5.1705069778585; 
 Fri, 12 Jan 2024 06:29:38 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b0040e5951f199sm5834531wmq.34.2024.01.12.06.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 06:29:38 -0800 (PST)
Date: Fri, 12 Jan 2024 17:29:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: felix.kuehling@amd.com
Subject: [bug report] drm/amdgpu: Auto-validate DMABuf imports in compute VMs
Message-ID: <770273c0-fb73-4361-991f-c9b68cc92e52@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 12 Jan 2024 14:37:34 +0000
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

Hello Felix Kuehling,

This is a semi-automatic email about new static checker warnings.

    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1480 amdgpu_vm_handle_moved()
    warn: variable dereferenced before check 'bo_va->base.bo' (see line 1453)

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
  1452						 base.vm_status);
  1453			resv = bo_va->base.bo->tbo.base.resv;
                               ^^^^^^^^^^^^^^^^
Unchecked dereference

  1454			spin_unlock(&vm->status_lock);
  1455	
  1456			/* Try to reserve the BO to avoid clearing its ptes */
  1457			if (!adev->debug_vm && dma_resv_trylock(resv)) {
  1458				clear = false;
  1459				unlock = true;
  1460			/* The caller is already holding the reservation lock */
  1461			} else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
  1462				clear = false;
  1463				unlock = false;
  1464			/* Somebody else is using the BO right now */
  1465			} else {
  1466				clear = true;
  1467				unlock = false;
  1468			}
  1469	
  1470			r = amdgpu_vm_bo_update(adev, bo_va, clear);
  1471	
  1472			if (unlock)
  1473				dma_resv_unlock(resv);
  1474			if (r)
  1475				return r;
  1476	
  1477			/* Remember evicted DMABuf imports in compute VMs for later
  1478			 * validation
  1479			 */
  1480			if (vm->is_compute_context && bo_va->base.bo &&
                                                      ^^^^^^^^^^^^^^
The patch adds this NULL check but hopefully it's not required.

  1481			    bo_va->base.bo->tbo.base.import_attach &&
  1482			    (!bo_va->base.bo->tbo.resource ||

regards,
dan carpenter
