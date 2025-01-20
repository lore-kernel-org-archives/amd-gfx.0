Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26650C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 14:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E9410E042;
	Mon, 20 Jan 2025 14:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eN8l2Udw";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B267910E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 09:19:36 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso2183976f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737364715; x=1737969515; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZosYWNMJVsmJIMpdriuqtZru3ZSj+/aM+wzcRtWl9jk=;
 b=eN8l2UdwprnvONX/vV5eEJVd8ykfVNAMAlphD2QTDU97tciqmchbh2yJzkhW9S/iT6
 tjK8M2hNunxV/OJ+wgNPo+7yUpeRMP/lCC0hivXRd+Xf1gd544hlzRfjeMJS0lWjhMpi
 Qm5MufaaOcau6q7axPXvLtvHa9Ip1jORsDuBldFfMiyFndb+i93BqIFnEb91IGHQXTr7
 PafVDSYm/pZdvkiwYH6Xfs7EB+Sqtrp9CSADig3MOTYdTvwSUJmgYvsWf+GDIR6qR/DI
 z7lWhPgbnqlpci2YdEkWW3lMtQD9YeX7vA/JuU0Q1n3IcZZfDRuYIpKyymcCfKF6E3DL
 hEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737364715; x=1737969515;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZosYWNMJVsmJIMpdriuqtZru3ZSj+/aM+wzcRtWl9jk=;
 b=mAikX4uHdtS9fnoSFGHC29RSVL8oIalVovYDt7EaFkHRwF/ccv1pqSL95WqLpzRWxD
 MQe+s/HGzvrzV1aBRFzakl5XTEHejiWscGQ9p090grjKcOtoP6HmjQuuGXzwklEzbG2E
 d2cy2xVOaTsWyAaBKMkuggq7uO0MAgb32QlS+LJKz0+DJh0vhEKkdlyGai6Xhjud7JLe
 VZqjTGiGJ8u82av2lMNeJUdP90o8qFZfIc/Z2q/2CakdXuGlDv75f05gMDSWpAI7iG+s
 asrEl/i2TBKvfd2yj9srP67L6HwfhiGT70KB58Bd8vsDYNguYSrPTMb2QQ51iO4vW4CO
 SKUA==
X-Gm-Message-State: AOJu0YwuqGvqrbsUAdpn9Pc69lvEx4SGDPWwAi+8k6GfGZH6RJtQ7n0q
 hygma+1kL6VkDE1eZaa0LK4GGHnGuW2Pn3Rdrkgnp4QTLbnOMxTmKgp3/y5vLZs=
X-Gm-Gg: ASbGnctCXd2tb0iaPpJ64GwX0uzKPVPvW9zyo5jLR15je0ZVwPq3Y4OkGHr1JqWS5x+
 9ckCWBY05ZsK3Ag1/HKe8euNiaavFV2gIHtwTbJGN9MSBnT6GBtyoOIB6a5j5O5l/n05ZBDj3kW
 S3GJvhw0ba+eem+QNJwvUtxNdHXWZLohSDQSsWK3HQfosJYLrAZwe8mbNqJRxwHW2jJ/M9LC6Kd
 4napidrdLHCtHUX56ZfzNaCaQnFM2FHypixtRmDmGpIyJ4n72xBN8+Be9hxNeGlOYU7ssnmbls=
X-Google-Smtp-Source: AGHT+IEsA5qD+BjEVqSprBVBp9ao/ZgpSWZ3jiWHgzni9Qd6l+Nz9oLww3rEIDY57//W8oZlQikAmg==
X-Received: by 2002:a05:6000:1faa:b0:386:1cd3:8a0e with SMTP id
 ffacd0b85a97d-38bf57c034emr13185041f8f.48.1737364715335; 
 Mon, 20 Jan 2025 01:18:35 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3215482sm9723028f8f.5.2025.01.20.01.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 01:18:34 -0800 (PST)
Date: Mon, 20 Jan 2025 12:18:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: cache gpu pcie link width
Message-ID: <f2a16c0a-09ca-46f4-8ca5-797d302dcfd9@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 20 Jan 2025 14:39:07 +0000
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

Hello Alex Deucher,

Commit 8fae3b201fee ("drm/amdgpu: cache gpu pcie link width") from
Jan 6, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6193 amdgpu_device_gpu_bandwidth()
	error: we previously assumed 'parent' could be null (see line 6180)

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    6170 static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
    6171                                         enum pci_bus_speed *speed,
    6172                                         enum pcie_link_width *width)
    6173 {
    6174         struct pci_dev *parent = adev->pdev;
    6175 
    6176         if (!speed || !width)
    6177                 return;
    6178 
    6179         parent = pci_upstream_bridge(parent);
    6180         if (parent && parent->vendor == PCI_VENDOR_ID_ATI) {
                     ^^^^^^
If parent is NULL

    6181                 /* use the upstream/downstream switches internal to dGPU */
    6182                 *speed = pcie_get_speed_cap(parent);
    6183                 *width = pcie_get_width_cap(parent);
    6184                 while ((parent = pci_upstream_bridge(parent))) {
    6185                         if (parent->vendor == PCI_VENDOR_ID_ATI) {
    6186                                 /* use the upstream/downstream switches internal to dGPU */
    6187                                 *speed = pcie_get_speed_cap(parent);
    6188                                 *width = pcie_get_width_cap(parent);
    6189                         }
    6190                 }
    6191         } else {
    6192                 /* use the device itself */
--> 6193                 *speed = pcie_get_speed_cap(parent);
                                                     ^^^^^^
Then we are toasted here.

    6194                 *width = pcie_get_width_cap(parent);
    6195         }
    6196 }

regards,
dan carpenter
