Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B25C4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 14:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C0E2098B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 14:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ylkr2SDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C0E2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571676EA20;
	Thu, 19 Mar 2020 14:45:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41286EA20
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 14:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzFp/r6Qrwqw4XbE0Gxvq7fp2pyPqCsa+UHnSYY3yfslw1Uc3KHoWgSq7ySzHB75efJ0oabti+spNH3OpCSZqh/LbZfcOxlvPAPo9asn+f774CXEiwaBzOIOAMU0qsQBEJBUTMsyKelfcDa9o9ZTiREXvvsdg9q7fmS31SYucE74sOhpHgXzrw4XoOpFDmKJmmaay/aCfWUUVdeRKMhiauB+tGKt1579+i2G2yiLW2obNuYYD5lq8qsAWym1l+cq9rjXBBPNN6Kk9js8/2v0IPUsER3pV4KaTCB8zJTbB3dKifqnpG78bZ6T6nxEOF/x4pUL4YLXq0Yi10ETi3ekKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWzmlgjrBL5zygqfjzor560K5Atq3yxwMdwlDMNEiB0=;
 b=jfIwngn0aNj7mT3c20pO20Ly0fleDLXAe3w/8932dK9EZrham+Q7I1pifQqjUMFQIp2DEcq/Mat62iIc6Z39k+1S1DmfbXd5nI5K15yv6UqN8Cdp43KSdJSm6MfaA1creMe/KHPq3W0BefE2r29iYe1uve2dtHp/npWraWWsoHOrUIoZwHdoMUW5nY6cB23hVFNK/GLLG4fqZvPGlWpWJEQ91GJU83L9WLQ50BZnLGi2xmkJUVxx6bn7aV9/JIMguKSGZCIwYxzuvayWINvsgmDEtYnF4wBw45XACD2dNAmUS16UCrPeYqJRN+OInOQR+WWFKA+eIl+bj2cJmFde/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWzmlgjrBL5zygqfjzor560K5Atq3yxwMdwlDMNEiB0=;
 b=ylkr2SDoiEj9mOnNFX5WoeKXbeC0y2moQA0nsb4L56DGV78IrwkqPd8nIV+Gimw94uUnAmV5+tFTR9PX2HGpZbCzZVebLP8tg0VT7zDFh8lvuJHME19BIJlAa1zIBkO9jt3QQKlOV9A/muhfQPO+YTaR7HmQvnQEgD8fLmgMIqk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1760.namprd12.prod.outlook.com (2603:10b6:300:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 19 Mar
 2020 14:45:04 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 14:45:04 +0000
Subject: Re: [PATCH] Enable reading FRU chip via I2C v3
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200319141600.29898-1-kent.russell@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <ad0a3b4e-1cd9-a9c5-8f28-5813e8a16191@amd.com>
Date: Thu, 19 Mar 2020 10:45:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200319141600.29898-1-kent.russell@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YTBPR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Thu, 19 Mar 2020 14:45:04 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4060344c-0666-47df-2c41-08d7cc141c57
X-MS-TrafficTypeDiagnostic: MWHPR12MB1760:|MWHPR12MB1760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1760563563A3490680C68951EAF40@MWHPR12MB1760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(66946007)(186003)(66556008)(66476007)(26005)(16526019)(16576012)(316002)(30864003)(36756003)(6486002)(31686004)(956004)(53546011)(478600001)(2616005)(2906002)(5660300002)(31696002)(81156014)(86362001)(8676002)(81166006)(52116002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1760;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UR+kpkusUmeP1tSHUXw0W3QlSPUnQ3r/UrdF25/QSFrBrpDGiGV0BKGSVL1J+5VDFE27Sd21vnYL5i6AR3LuAypMQmshCjcQaQbEFpFFuYc2CG8TzkK36K1W1IHWewRjSrS7RZqUWYHXsgkJfzWvqGJyJZ/Iv5WpPzoVTAYP4ylmBlFSctZ+wAKy48ClpRcmTaxwrk802nlS6G8T7JuTa6uwP0IDbeqUccDT8CKTKkjrxWVlxC6t5MjxQfFgOMJg7Cpt62zvK3QPrKTFrnb/ql+1YlM7GawRwzsxeKM4Xs7mWw2o1tuDxPkkXos3nsSj8lZZZQo5UnRCPLyOrDXpOZZmDCoK77STiXkBHSeGmFrUokd+ftID9GNTqm5T/ehwLwE4aP1MQRw0eGeUi4OgaIHltbsqkQjNxXnNJMG7EiCjSiSjW0dCwaba+BcQ2eTw
X-MS-Exchange-AntiSpam-MessageData: COk9xnEys7zYxHJs7CsmqaCgF/u50pIWiO3Wbk9gf5BA/XtV1BcKssyE8MnD7FgXJ2qGKNY0wdatJRlSQey/1zOLMcBJIgfUeBE1s0iFUIrYAZHnCuYvTBGFhdn/Cvt2887M+Ad3OFmQm0MonisiJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4060344c-0666-47df-2c41-08d7cc141c57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 14:45:04.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMg3z9ITypCWPK9vAhmULk+ujxTzeBtultT6NEMbkoIMwACuqlvfd/WYiaiJ90qUA10/3j3U7PVlSPoYNb7ovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good to me.

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 3/19/20 10:16 AM, Kent Russell wrote:
> Allow for reading of information like manufacturer, product number
> and serial number from the FRU chip. Report the serial number as
> the new sysfs file serial_number. Note that this only works on
> server cards, as consumer cards do not feature the FRU chip, which
> contains this information.
>
> v2: Add documentation to amdgpu.rst, add helper functions,
>      rename functions for consistency, fix bad starting offset
> v3: Remove testing definitions
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   Documentation/gpu/amdgpu.rst                  |  24 +++
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  90 +++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 143 ++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  29 ++++
>   6 files changed, 292 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 0efede580039..d9ea09ec8e24 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -202,3 +202,27 @@ busy_percent
>   
>   .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>      :doc: busy_percent
> +
> +GPU Product Information
> +=======================
> +
> +Information about the GPU can be obtained on certain cards
> +via sysfs
> +
> +product_name
> +------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: product_name
> +
> +product_number
> +--------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: product_name
> +
> +serial_number
> +-------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +   :doc: serial_number
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index c2bbcdd9c875..210d57a4afc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
>   	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
> -	amdgpu_umc.o smu_v11_0_i2c.o
> +	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
>   
>   amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 87c2523076af..7dd74253e7b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -979,6 +979,11 @@ struct amdgpu_device {
>   
>   	bool                            pm_sysfs_en;
>   	bool                            ucode_sysfs_en;
> +
> +	/* Chip product information */
> +	char				product_number[16];
> +	char				product_name[32];
> +	char				serial[16];
>   };
>   
>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 729565f79cfe..80a654326190 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -64,6 +64,7 @@
>   #include "amdgpu_xgmi.h"
>   #include "amdgpu_ras.h"
>   #include "amdgpu_pmu.h"
> +#include "amdgpu_fru_eeprom.h"
>   
>   #include <linux/suspend.h>
>   #include <drm/task_barrier.h>
> @@ -137,6 +138,72 @@ static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
>   
>   static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
>   
> +/**
> + * DOC: product_name
> + *
> + * The amdgpu driver provides a sysfs API for reporting the product name
> + * for the device
> + * The file serial_number is used for this and returns the product name
> + * as returned from the FRU.
> + * NOTE: This is only available for certain server cards
> + */
> +
> +static ssize_t amdgpu_device_get_product_name(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_name);
> +}
> +
> +static DEVICE_ATTR(product_name, S_IRUGO,
> +		amdgpu_device_get_product_name, NULL);
> +
> +/**
> + * DOC: product_number
> + *
> + * The amdgpu driver provides a sysfs API for reporting the part number
> + * for the device
> + * The file serial_number is used for this and returns the part number
> + * as returned from the FRU.
> + * NOTE: This is only available for certain server cards
> + */
> +
> +static ssize_t amdgpu_device_get_product_number(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", adev->product_number);
> +}
> +
> +static DEVICE_ATTR(product_number, S_IRUGO,
> +		amdgpu_device_get_product_number, NULL);
> +
> +/**
> + * DOC: serial_number
> + *
> + * The amdgpu driver provides a sysfs API for reporting the serial number
> + * for the device
> + * The file serial_number is used for this and returns the serial number
> + * as returned from the FRU.
> + * NOTE: This is only available for certain server cards
> + */
> +
> +static ssize_t amdgpu_device_get_serial_number(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
> +}
> +
> +static DEVICE_ATTR(serial_number, S_IRUGO,
> +		amdgpu_device_get_serial_number, NULL);
> +
>   /**
>    * amdgpu_device_supports_boco - Is the device a dGPU with HG/PX power control
>    *
> @@ -1977,6 +2044,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   		amdgpu_xgmi_add_device(adev);
>   	amdgpu_amdkfd_device_init(adev);
>   
> +	amdgpu_fru_get_product_info(adev);
> +
>   init_failed:
>   	if (amdgpu_sriov_vf(adev))
>   		amdgpu_virt_release_full_gpu(adev, true);
> @@ -3188,6 +3257,24 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> +	r = device_create_file(adev->dev, &dev_attr_product_name);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create product_name");
> +		return r;
> +	}
> +
> +	r = device_create_file(adev->dev, &dev_attr_product_number);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create product_number");
> +		return r;
> +	}
> +
> +	r = device_create_file(adev->dev, &dev_attr_serial_number);
> +	if (r) {
> +		dev_err(adev->dev, "Could not create serial_number");
> +		return r;
> +	}
> +
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		r = amdgpu_pmu_init(adev);
>   	if (r)
> @@ -3270,6 +3357,9 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>   	if (adev->ucode_sysfs_en)
>   		amdgpu_ucode_sysfs_fini(adev);
> +	device_remove_file(adev->dev, &dev_attr_product_name);
> +	device_remove_file(adev->dev, &dev_attr_product_number);
> +	device_remove_file(adev->dev, &dev_attr_serial_number);
>   	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>   		amdgpu_pmu_fini(adev);
>   	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> new file mode 100644
> index 000000000000..990dee6e22d5
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_i2c.h"
> +#include "smu_v11_0_i2c.h"
> +#include "atom.h"
> +
> +#define I2C_PRODUCT_INFO_ADDR		0xAC
> +#define I2C_PRODUCT_INFO_ADDR_SIZE	0x2
> +#define I2C_PRODUCT_INFO_OFFSET		0xC0
> +
> +int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
> +			   unsigned char *buff)
> +{
> +	int ret, size;
> +	struct i2c_msg msg = {
> +			.addr   = I2C_PRODUCT_INFO_ADDR,
> +			.flags  = I2C_M_RD,
> +			.buf    = buff,
> +	};
> +	buff[0] = 0;
> +	buff[1] = addrptr;
> +	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + 1;
> +	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
> +
> +	if (ret < 1) {
> +		DRM_WARN("FRU: Failed to get size field");
> +		return ret;
> +	}
> +
> +	/* The size returned by the i2c requires subtraction of 0xC0 since the
> +	 * size apparently always reports as 0xC0+actual size.
> +	 */
> +	size = buff[2] - I2C_PRODUCT_INFO_OFFSET;
> +	/* Add 1 since address field was 1 byte */
> +	buff[1] = addrptr + 1;
> +
> +	msg.len = I2C_PRODUCT_INFO_ADDR_SIZE + size;
> +	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
> +
> +	if (ret < 1) {
> +		DRM_WARN("FRU: Failed to get data field");
> +		return ret;
> +	}
> +
> +	return size;
> +}
> +
> +int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
> +{
> +	unsigned char buff[32];
> +	int addrptr = 0, size = 0;
> +
> +	/* If algo exists, it means that the i2c_adapter's initialized */
> +	if (!adev->pm.smu_i2c.algo) {
> +		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
> +		return 0;
> +	}
> +
> +	/* There's a lot of repetition here. This is due to the FRU having
> +	 * variable-length fields. To get the information, we have to find the
> +	 * size of each field, and then keep reading along and reading along
> +	 * until we get all of the data that we want. We use addrptr to track
> +	 * the address as we go
> +	 */
> +
> +	/* The first fields are all of size 1-byte, from 0-7 are offsets that
> +	 * contain information that isn't useful to us.
> +	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
> +	 * and the language field, so just start from 0xb, manufacturer size
> +	 */
> +	addrptr = 0xb;
> +	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
> +	if (size < 1) {
> +		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
> +		return size;
> +	}
> +
> +	/* Increment the addrptr by the size of the field, and 1 due to the
> +	 * size field being 1 byte. This pattern continues below.
> +	 */
> +	addrptr += size + 1;
> +	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
> +	if (size < 1) {
> +		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
> +		return size;
> +	}
> +
> +	/* Start at 2 due to buff using fields 0 and 1 for the address */
> +	memcpy(adev->product_name, &buff[2], size);
> +	adev->product_name[size] = '\0';
> +
> +	addrptr += size + 1;
> +	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
> +	if (size < 1) {
> +		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
> +		return size;
> +	}
> +
> +	memcpy(adev->product_number, &buff[2], size);
> +	adev->product_number[size] = '\0';
> +
> +	addrptr += size + 1;
> +	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
> +
> +	if (size < 1) {
> +		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
> +		return size;
> +	}
> +
> +	addrptr += size + 1;
> +	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
> +
> +	if (size < 1) {
> +		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
> +		return size;
> +	}
> +
> +	memcpy(adev->serial, &buff[2], size);
> +	adev->serial[size] = '\0';
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> new file mode 100644
> index 000000000000..968115c97e33
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
> @@ -0,0 +1,29 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_PRODINFO_H__
> +#define __AMDGPU_PRODINFO_H__
> +
> +int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
> +
> +#endif  // __AMDGPU_PRODINFO_H__
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
