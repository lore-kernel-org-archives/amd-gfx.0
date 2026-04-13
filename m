Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E76F34C56
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0164310E48A;
	Mon, 13 Apr 2026 12:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h285AnFg";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B98610E37E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 08:38:50 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so66201405e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776069529; x=1776674329; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EKUvFy2J2g8UJyWz6jy96B4Vk39G6dksKLaiANnQ+cQ=;
 b=h285AnFglM/qSYjIvWb9yeP/GWifYekjshaotoNuV6UnBQ8ySHWwoxm8aA4jHz53Ip
 /sT+LWXDWcfE86BDRyL+WTyvrunsqqJ2qQLDbzWOkGyk9/Uf2ocN+ZlEPDahrPM1ugx5
 f5QA4YnshCuUkXk4xdDI0re0k12vfXNqzmaO/hQ3Bjd5eYu3CcqZzITAOk1sXOEyAfPd
 Zu4WCBXKXna6KGPRCERhtbb8q2QsAFYwb88/AL0PbSlYNupAVqRwgfPxm9w9z6D/hx+c
 SBOWptier3lTPYXuCLHGWWWQkCHaUJwXrQOUKMXZVyKQ1rP8S307i1Uym0qMYxJ/AWK+
 nDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776069529; x=1776674329;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKUvFy2J2g8UJyWz6jy96B4Vk39G6dksKLaiANnQ+cQ=;
 b=NEVG9lGYNez/DQAGpShxcPnC6fRHvEw3jxojNonX168uSdtryqXHIFyQY/yj9GNm+o
 uz1M+CEMM5hcTCQOliTy6HGs8FuiE5Ovyqt732l2yrs4/KI85Tdkk3MoAwSvw+bwOkdM
 +xohrCb80SKe+DsnkAJ7c16GAHUJuXIZXFs0Y7d82oRjaX290U2EtS40gxteD2j0vp7O
 nCJj61BxvRpPHB7JDlDH8FrA4H1q47dSIpY6+5vMlWG5SC9u2ZQnpsHQX2JuMNU/Yty5
 q4D1b2qxiwvRM1dMRg8EUkBQBglehtY2aPt/odmg3dsW00zV/DsXC9F186VjviDPnEF4
 UXig==
X-Gm-Message-State: AOJu0YwWeOIyLnNuWfl0qIx7aZMDnxp0uv9b0SCVuLLOfvbsTDAGemkX
 /ZuuO7BvjAT34vHILvvcdEb+NABwEb2XVTNYxYy8h7n0y+ha0HnYbsJBpAGpqQJk
X-Gm-Gg: AeBDieuvCVVh6C6aBvqZnSTvdVMV5xt6qXpfkR0Z1RR7pOZYiHYBjkpSbtVE/m1Jp6/
 Pw+8dW0TYaHVfTKFsxoXmy1AId5Q9EM8fCEwFTjtj/Ix419bkpSAfOs7RjCRD7ysHeKGTEi6GUK
 TIOU7IUtUyVYATQLC0/85ZM9GzHC3AZn2KPjEWXEh7Mw+zlKl+p+YqZgpywUsl/9ixwRuNvY7/Y
 brC6Uy3z+gdzLk6CeNzgxD3ZxHmrpKBF+WNmJd/Ilm9ixn3WTTBg1TPGUEcMHrkgcwvIxC6iCml
 zpL0RXVGeIYOdeq4rHQvPlp2VUecpg+MtNS8BSWb3sxjuLe5ovoHPG4mJc5jOaV+6Rqn3Bz5P6B
 nt3fH5rpT0IPzGXOZ6GmlKyQvj6tCB8IW1yBMcqpo+dXU+Lq94bz9vpv5L0P/wjP4eaibFJqQmD
 A8p6gZuxw7E7Iq5Wqfqy0=
X-Received: by 2002:a05:600c:c088:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-488d6843187mr122941275e9.18.1776069528534; 
 Mon, 13 Apr 2026 01:38:48 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d525c931sm304668265e9.0.2026.04.13.01.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 01:38:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:38:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/pm: Modify mode2 msg sequence on aldebaran
Message-ID: <adyrlBPbpWHAvn_w@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 13 Apr 2026 12:41:56 +0000
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

Hello Lijo Lazar,

Commit e42569d02acb ("drm/amd/pm: Modify mode2 msg sequence on
aldebaran") from Mar 16, 2021 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c:1861 aldebaran_mode2_reset()
	warn: missing error code here? '_dev_err()' failed. 'ret' = '0'

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/aldebaran_ppt.c
    1827 static int aldebaran_mode2_reset(struct smu_context *smu)
    1828 {
    1829         struct smu_msg_ctl *ctl = &smu->msg_ctl;
    1830         struct amdgpu_device *adev = smu->adev;
    1831         int ret = 0;
    1832         int timeout = 10;
    1833 
    1834         mutex_lock(&ctl->lock);
    1835 
    1836         if (smu->smc_fw_version >= 0x00441400) {
    1837                 ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
    1838                                                 SMU_RESET_MODE_2);
    1839                 if (ret)
    1840                         goto out;
    1841 
    1842                 /* This is similar to FLR, wait till max FLR timeout */
    1843                 msleep(100);
    1844                 dev_dbg(adev->dev, "restore config space...\n");
    1845                 /* Restore the config space saved during init */
    1846                 amdgpu_device_load_pci_state(adev->pdev);
    1847 
    1848                 dev_dbg(adev->dev, "wait for reset ack\n");
    1849                 while (ret == -ETIME && timeout)  {
    1850                         ret = smu_msg_wait_response(ctl, 0);
    1851                         /* Wait a bit more time for getting ACK */
    1852                         if (ret == -ETIME) {
    1853                                 --timeout;
    1854                                 usleep_range(500, 1000);
    1855                                 continue;
    1856                         }
    1857 
    1858                         if (ret != 1) {
    1859                                 dev_err(adev->dev, "failed to send mode2 message \tparam: 0x%08x response %#x\n",
    1860                                                 SMU_RESET_MODE_2, ret);
--> 1861                                 goto out;

Do we need to set an error code on this goto?  aldebaran_mode2_reset()
doesn't have a comment describing the returns...

    1862                         }
    1863                 }
    1864 
    1865         } else {
    1866                 dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
    1867                                 smu->smc_fw_version);
    1868         }
    1869 
    1870         if (ret == 1)
    1871                 ret = 0;
    1872 out:
    1873         mutex_unlock(&ctl->lock);
    1874 
    1875         return ret;
    1876 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
