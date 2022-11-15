Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A766C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 14:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563C410E3FB;
	Tue, 15 Nov 2022 14:04:03 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762B110E3C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 13:00:43 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id a14so24145702wru.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ma41XJunBhyIgsPx3H7ErRvUfPC4VUeu5EQ6kbxl/uk=;
 b=c+ZM938HZ+QENu55Aaq9JS6ysAGAAtOsB3XE/9+TCkYOOkFAssqR+Cckgppuf2nojI
 e8C0sC9bEl5DjKm6U8ckl3pKNcyBd/9FTv6v0gPT6G8v206xsUe5/EF3jGUsVrSAzg8W
 dUz1+ZLzYMqc167K1TLmCFAuso8VLUYOSlAJh8qYNNiXVBP3kbJd+L/j/qhlESjpgNtL
 06NSimVlGzDG8s3fH4mjwBQVJH+a/NZ+7MxUFNulMo9dTL4d7IXd2nyZdyu6BIk5Jtjz
 8YKYxTmxCJgDrfrVL2/ri4XW4wzk53JI9LIrg9Hmi91/XcSQ8EpxEeIuaNLvKsRZGy+a
 T7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ma41XJunBhyIgsPx3H7ErRvUfPC4VUeu5EQ6kbxl/uk=;
 b=MTlzt8APzcszf03F1SNXXOK39J0GeahWtvFwDimtuUtYfb6LCteOHLa2KCZVOtLoid
 i05CsnmlwK0jyRFIydKlr504EJaeqdh26tOV8L2KNuUaox3axb5S4RqJlNdu6DjRnyDS
 maNWP5iLhef5mrmoc0QH++fTABWSKuzNXhAzsr+6jYjJY35h21ikfiwSWZrtsZ8A9v4N
 m84JyrTTz9tK0j78F5gzT0i9es4A3agwsiKceXB+xLqzcPIoN61+lXsiW//7hizFq4vs
 78ouLpjajliwOsmr/q4VR9gpDr9VZ63niMX9VrzX+xhqeKh8G+L1tmIXwseeBHtQacyO
 Oprg==
X-Gm-Message-State: ANoB5pkvzFSgT0fIdcEL1VXrqpPvLPiFue5k7P3YyUzFlZPVW/XnG2yL
 sGSf31R2Gy+xX1hPtL0cL4orE/dnG/Zepw==
X-Google-Smtp-Source: AA0mqf4+9wNC5J+agA6G81kKbTC90VtD4T0ixbIRYVWaxtStVzLT26gxMfRQPgKostDl10gLJu4jJg==
X-Received: by 2002:a5d:4b0c:0:b0:236:6101:7b7d with SMTP id
 v12-20020a5d4b0c000000b0023661017b7dmr10412874wrq.484.1668517241730; 
 Tue, 15 Nov 2022 05:00:41 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 l16-20020a1c7910000000b003cfd4e6400csm11461635wme.19.2022.11.15.05.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Nov 2022 05:00:41 -0800 (PST)
Date: Tue, 15 Nov 2022 16:00:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jun.Ma2@amd.com
Subject: [bug report] drm/amdkfd: Fix the warning of array-index-out-of-bounds
Message-ID: <Y2oyylG+hW5tMWJN@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 15 Nov 2022 14:03:55 +0000
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

[ Ugh...  My email messed up and I have to Resend all my emails for the
  past two weeks. -dan ]

Hello Ma Jun,

The patch c0cc999f3c32: "drm/amdkfd: Fix the warning of
array-index-out-of-bounds" from Nov 2, 2022, leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2008 kfd_topology_add_device()
	warn: inconsistent returns '&topology_lock'.

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c
    1808 int kfd_topology_add_device(struct kfd_dev *gpu)
    1809 {
    1810         uint32_t gpu_id;
    1811         struct kfd_topology_device *dev;
    1812         struct kfd_cu_info cu_info;
    1813         int res = 0;
    1814         struct list_head temp_topology_device_list;
    1815         void *crat_image = NULL;
    1816         size_t image_size = 0;
    1817         int proximity_domain;
    1818         int i;
    1819         const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
    1820 
    1821         INIT_LIST_HEAD(&temp_topology_device_list);
    1822 
    1823         gpu_id = kfd_generate_gpu_id(gpu);
    1824         pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
    1825 
    1826         /* Check to see if this gpu device exists in the topology_device_list.
    1827          * If so, assign the gpu to that device,
    1828          * else create a Virtual CRAT for this gpu device and then parse that
    1829          * CRAT to create a new topology device. Once created assign the gpu to
    1830          * that topology device
    1831          */
    1832         down_write(&topology_lock);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
Takes the lock.

    1833         dev = kfd_assign_gpu(gpu);
    1834         if (!dev) {
    1835                 proximity_domain = ++topology_crat_proximity_domain;
    1836 
    1837                 res = kfd_create_crat_image_virtual(&crat_image, &image_size,
    1838                                                     COMPUTE_UNIT_GPU, gpu,
    1839                                                     proximity_domain);
    1840                 if (res) {
    1841                         pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
    1842                                gpu_id);
    1843                         topology_crat_proximity_domain--;
    1844                         return res;

Does not drop the lock.

    1845                 }
    1846 
    1847                 res = kfd_parse_crat_table(crat_image,
    1848                                            &temp_topology_device_list,
    1849                                            proximity_domain);
    1850                 if (res) {
    1851                         pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
    1852                                gpu_id);
    1853                         topology_crat_proximity_domain--;
    1854                         goto err;

Does not drop the lock.

    1855                 }
    1856 
    1857                 kfd_topology_update_device_list(&temp_topology_device_list,
    1858                         &topology_device_list);
    1859 
    1860                 dev = kfd_assign_gpu(gpu);
    1861                 if (WARN_ON(!dev)) {
    1862                         res = -ENODEV;
    1863                         goto err;

Does not drop the lock.

    1864                 }
    1865 
    1866                 /* Fill the cache affinity information here for the GPUs
    1867                  * using VCRAT
    1868                  */
    1869                 kfd_fill_cache_non_crat_info(dev, gpu);
    1870 
    1871                 /* Update the SYSFS tree, since we added another topology
    1872                  * device
    1873                  */
    1874                 res = kfd_topology_update_sysfs();
    1875                 if (!res)
    1876                         sys_props.generation_count++;
    1877                 else
    1878                         pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
    1879                                                 gpu_id, res);
    1880         }
    1881         up_write(&topology_lock);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^
Drops the lock.  The patch has some other locking changes which are
not explained in the commit message and seem unrelated to the out of
bounds issue.

    1882 
    1883         dev->gpu_id = gpu_id;
    1884         gpu->id = gpu_id;

regards,
dan carpenter

