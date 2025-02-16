Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C0C021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 08:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C04E10E38D;
	Mon, 17 Feb 2025 08:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hUTP///4";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CB810E0A0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 21:28:09 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so699438766b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739741288; x=1740346088; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQvlM9mZvjqkw9EX7b5cV55HQP8W3N2z2QPsswnWMhQ=;
 b=hUTP///4qe3RohgPdAOVviYqS3d+oOzsqZLz5W5Bsoym0DR7WgNQAitXNJUWiCov2h
 eG+OKDGWLt0nGmY6TIfIrhsfWpAqfa6NtklhJzAaQb+mUXq0bCwxsLz/guxOYizxzgHV
 hvb96auYv00gj0YexheanNJzAc8JAFOdNbQdQWMQpgGuQsOjxszeNxyCXR6/Hz1LareE
 ggOXcnSo3CAWdCQAoDoennUXx8E7LFY0CusU+kbR6ytM7hTdM9PhTAHZqKwSzw3IfNgd
 xdEgZHOIIJ5G9Z2cYMvqxBBhW5YW0zUP0hVO5K4WD049TYRvfB9tPkRD10jGSh32L/nz
 Kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739741288; x=1740346088;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OQvlM9mZvjqkw9EX7b5cV55HQP8W3N2z2QPsswnWMhQ=;
 b=mb0lMb1PUSvW/7Rwf5pKlB53DCgqj43FLfUN17BJR11Qp8EhatSfnSlzYq0I5lNLMm
 r11kpfdmBRxBvgmZt0Vs+i4k6SKRFcXoFj3Mnzjwp7VmJAlaFUryumy/GqzX4aVNLu8R
 Bv43Rv9dOT8P3ur7D1WctAkJcv1fqUQzTImtp30d7FatwH7u+n6lj3qiGfGiOfVcc5eH
 r8xDqEAcgjb1Ashab95tIVXCi5C8Pu+1GFlxNQbP73P4BgqRkQS49odElf8GOrs6/FLe
 5UztnuQN2tho2CrNF9wgWY9ZvAWT/sFxWgdnySdwFalh/yDnKcdFmvtjGylu0oFledIq
 hBJw==
X-Gm-Message-State: AOJu0YyVBBJ06uRAFApD+b8uy8QMJ7OklOvpMbWq/V39ZbmtfOuYrdqo
 P/R6VSCD6LJUmKqA90DiHUQkx3M5pNbaBiwg1UaTbb8q+LpfKMfZgK2I67eMqcs=
X-Gm-Gg: ASbGnctFFj6JuIv+I+bBdkIZuSSzy8eMm1xPfXYVrdFUs6BcjLh+4oTq4QrDFoegP4v
 S3F9Gz9JvhNfb7oLQfz6qp8065OknpC/Zbd8+Z6pP4bZyrPixOV61w1MLdWnrTiSf49FhPowLfc
 eUL8HiQj50WzwU7QMeiVhxHaj9wpTCRc5TcGBcTwbXmJY8qxz9HOhww+2vBJW/dopMTaYw1WwS4
 tuZEykbTMto5yiOoW0oG6nbs5AOBuOQeZCUMpEiJnCsxdQrB9LdOgpCwLhZJ+o+juv6yioWgZy0
 FcD/bbCfH8tIj6V+0Unp
X-Google-Smtp-Source: AGHT+IEpQbjG3zn7EDFcNLYdTTWVfr87nLloEwaZhJ/Pai0WFFONLLMpJjs4jcMAtnse59G3UkK1VQ==
X-Received: by 2002:a17:907:2d88:b0:ab7:b896:b80c with SMTP id
 a640c23a62f3a-aba50fa0b94mr1280523866b.9.1739741288455; 
 Sun, 16 Feb 2025 13:28:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-aba5323225fsm763183466b.24.2025.02.16.13.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 13:28:07 -0800 (PST)
Date: Mon, 17 Feb 2025 00:28:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
Message-ID: <e9fafe58-6748-405f-a4e2-a2a60515367f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 17 Feb 2025 08:02:00 +0000
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

Hello Xiaogang Chen,

Commit 8544374c0f82 ("drm/amdkfd: Have kfd driver use same PASID
values from graphic driver") from Jan 13, 2025 (linux-next), leads to
the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1694 kfd_process_device_init_vm()
	warn: missing error code 'ret'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    1647 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
    1648                                struct file *drm_file)
    1649 {
    1650         struct amdgpu_fpriv *drv_priv;
    1651         struct amdgpu_vm *avm;
    1652         struct kfd_process *p;
    1653         struct dma_fence *ef;
    1654         struct kfd_node *dev;
    1655         int ret;
    1656 
    1657         if (!drm_file)
    1658                 return -EINVAL;
    1659 
    1660         if (pdd->drm_priv)
    1661                 return -EBUSY;
    1662 
    1663         ret = amdgpu_file_to_fpriv(drm_file, &drv_priv);
    1664         if (ret)
    1665                 return ret;
    1666         avm = &drv_priv->vm;
    1667 
    1668         p = pdd->process;
    1669         dev = pdd->dev;
    1670 
    1671         ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
    1672                                                      &p->kgd_process_info,
    1673                                                      p->ef ? NULL : &ef);
    1674         if (ret) {
    1675                 dev_err(dev->adev->dev, "Failed to create process VM object\n");
    1676                 return ret;
    1677         }
    1678 
    1679         if (!p->ef)
    1680                 RCU_INIT_POINTER(p->ef, ef);
    1681 
    1682         pdd->drm_priv = drm_file->private_data;
    1683 
    1684         ret = kfd_process_device_reserve_ib_mem(pdd);
    1685         if (ret)
    1686                 goto err_reserve_ib_mem;
    1687         ret = kfd_process_device_init_cwsr_dgpu(pdd);
    1688         if (ret)
    1689                 goto err_init_cwsr;
    1690 
    1691         if (unlikely(!avm->pasid)) {
    1692                 dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
    1693                                  avm);
--> 1694                 goto err_get_pasid;

ret = -EINVAL?

    1695         }
    1696 
    1697         pdd->pasid = avm->pasid;
    1698         pdd->drm_file = drm_file;
    1699 
    1700         return 0;
    1701 
    1702 err_get_pasid:
    1703         kfd_process_device_destroy_cwsr_dgpu(pdd);
    1704 err_init_cwsr:
    1705         kfd_process_device_destroy_ib_mem(pdd);
    1706 err_reserve_ib_mem:
    1707         pdd->drm_priv = NULL;
    1708         amdgpu_amdkfd_gpuvm_destroy_cb(dev->adev, avm);
    1709 
    1710         return ret;
    1711 }

regards,
dan carpenter
