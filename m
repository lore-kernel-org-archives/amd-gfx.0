Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411E7C369A9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E339610E9AB;
	Thu, 10 Apr 2025 13:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DRMU8Oec";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D77E10E309
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 08:46:54 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so55962515e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744188412; x=1744793212; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4OzH9YwLXWPPugPuWyfNy8OfCZxBMvD1de7nAngTy4M=;
 b=DRMU8OecM/9/Z/7EpeVSM68Y6zVh0Hc0CAFI/gkCLbJ/l06/AoVszIoAM5SVXBpVAN
 Is+a5tBySCyZNTRQEkixJcx1mjSip8c0O6QV3SDW2NHjAI7u+rvYIcxelD4ODM/+Dz+a
 46c3Ev7cwxgbAjGj5BKgUSECb99gBpvaZoXEij1d/wXRil/tV+5UcISyTRbE34+3fCtg
 Xd85slcLjJW2iTlYZbr564hRHgxf/z/dwBL7i6Cz/DU8b2zBqIU6GTFoP1ylZYz+uSCj
 vizmomcDlqtuVM0+UORqRsykykT5X5L4QtCd2V/J+py2zd9ZrUKju5XOga3GGtqEy2/i
 AxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744188412; x=1744793212;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4OzH9YwLXWPPugPuWyfNy8OfCZxBMvD1de7nAngTy4M=;
 b=rGJAwMqxxknqWAf5/kZ4TDvQKeMrQvWtw8HDwQz3QvF9Cxg1VSVbCMEo31V1G+FLru
 XXVf8ydgzdH+Y9AEkfZgtKq0djYvRq3ok+xPI+3BKeJhNQhOukW9ieviFLHqEJDXxmbV
 pA1E7mvhAELPLiG6MYfLpzN5m+u1QxgLeBYbFb4lzH+miA4n9KmtzUmfQ6pfaijw2SKc
 RCMF7quT5kobkedc0goSRmKWTyAqyKqqLZHzXoTGC6R2yk0SwJNEABbkstSldtGH/IIH
 sAD+dgchcTIrB6BwVscLvKQQ1UkP5RNZKJL19pDXshZi/o04szAyzVs7VJpAP40cjWei
 QzQA==
X-Gm-Message-State: AOJu0YxtaAzqMCdPioJtzEM1PYasML+7gIBO8xGBWASnqs+mWsiRSotf
 s3n8l1rL6Wj7G6we5LAc8DSWDYnQZ7N6YDo1W/LnbBMsQJaHvW+d3l9N03f5qDw=
X-Gm-Gg: ASbGncvYLRyiZ8IrNgOBI1ktsaD2bZIh/Ht1wDNd2rWac+XI5zAd2NN9IpqBubIFzXC
 YjoomgOMCVeYaZsn1vjMlGrtxEhdI13emlGsKIQ2GaeHMpJAwB0f2zgh2bvUDzlU0sHflFzHLGl
 J1b3k27Z9c6qs010J+3sQAWTIMBo69+vQ2ledb+9N9731XOUUb2TZHdOog42J8wtZ816givrWVR
 UHS25ZuRYGB78espx2MJxRraGTbK1PcNSlDuNCtBT17e1nhh11sN0K6XNU+FpoTiVQNOUv3ejTq
 z80v2gweV/+wE6qBbQLsYyJ1LySW4dxf/5xThmEfuuryzg==
X-Google-Smtp-Source: AGHT+IEgjSsiil3k2mighLToTN7rxETZ7M6ku/D6xblpxHB81KuZ3F8CJtBjqFCuTMyr0rTm3Wyxug==
X-Received: by 2002:a05:6000:400a:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39d87aa7f5emr1672599f8f.17.1744188412603; 
 Wed, 09 Apr 2025 01:46:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39d8938a4dasm959289f8f.48.2025.04.09.01.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 01:46:52 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:46:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ce Sun <cesun102@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Multi-GPU DPC recovery support
Message-ID: <ecb6666e-7ef0-4dbc-ad11-df9ca16fac43@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:31 +0000
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

Hello Ce Sun,

Commit 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")
from Mar 21, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
	warn: iterator used outside loop: 'tmp_adev'

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    6753 pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
    6754 {
    6755         struct drm_device *dev = pci_get_drvdata(pdev);
    6756         struct amdgpu_device *adev = drm_to_adev(dev);
    6757         struct amdgpu_reset_context reset_context;
    6758         struct amdgpu_device *tmp_adev = NULL;
    6759         struct amdgpu_hive_info *hive = NULL;
    6760         struct list_head device_list;
    6761         int r = 0, i;
    6762         u32 memsize;
    6763 
    6764         /* PCI error slot reset should be skipped During RAS recovery */
    6765         if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
    6766             amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
    6767             amdgpu_ras_in_recovery(adev))
    6768                 return PCI_ERS_RESULT_RECOVERED;
    6769 
    6770         dev_info(adev->dev, "PCI error: slot reset callback!!\n");
    6771 
    6772         memset(&reset_context, 0, sizeof(reset_context));
    6773 
    6774         /* wait for asic to come out of reset */
    6775         msleep(700);
    6776 
    6777         /* Restore PCI confspace */
    6778         amdgpu_device_load_pci_state(pdev);
    6779 
    6780         /* confirm  ASIC came out of reset */
    6781         for (i = 0; i < adev->usec_timeout; i++) {
    6782                 memsize = amdgpu_asic_get_config_memsize(adev);
    6783 
    6784                 if (memsize != 0xffffffff)
    6785                         break;
    6786                 udelay(1);
    6787         }
    6788         if (memsize == 0xffffffff) {
    6789                 r = -ETIME;
    6790                 goto out;
    6791         }
    6792 
    6793         reset_context.method = AMD_RESET_METHOD_NONE;
    6794         reset_context.reset_req_dev = adev;
    6795         set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
    6796         set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
    6797         INIT_LIST_HEAD(&device_list);
    6798 
    6799         hive = amdgpu_get_xgmi_hive(adev);
    6800         if (hive) {
    6801                 mutex_lock(&hive->hive_lock);
    6802                 reset_context.hive = hive;
    6803                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
    6804                         tmp_adev->pcie_reset_ctx.in_link_reset = true;
    6805                         list_add_tail(&tmp_adev->reset_list, &device_list);
    6806                 }

tmp_adev is an invalid non-NULL pointer.

    6807         } else {
    6808                 set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
    6809                 list_add_tail(&adev->reset_list, &device_list);
    6810         }
    6811 
    6812         r = amdgpu_device_asic_reset(adev, &device_list, &reset_context);
    6813 out:
    6814         if (!r) {
    6815                 if (amdgpu_device_cache_pci_state(adev->pdev))
    6816                         pci_restore_state(adev->pdev);
    6817                 dev_info(adev->dev, "PCIe error recovery succeeded\n");
    6818         } else {
    6819                 dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
--> 6820                 if (tmp_adev) {

This looks like it might have been intentional but it would be more
readable to check if (hive) {

    6821                         list_for_each_entry(tmp_adev, &device_list, reset_list)
    6822                                 amdgpu_device_unset_mp1_state(tmp_adev);
    6823                         amdgpu_device_unlock_reset_domain(adev->reset_domain);
    6824                 }
    6825         }
    6826 
    6827         if (hive) {
    6828                 mutex_unlock(&hive->hive_lock);
    6829                 amdgpu_put_xgmi_hive(hive);
    6830         }
    6831 
    6832         return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
    6833 }

regards,
dan carpenter
