Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC3C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECC621D56
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Mq04T+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECC621D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74FE6E079;
	Wed,  4 Mar 2020 16:27:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589576E079
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTXgBzX8+Dq1YuUyE3KkUBKe4nE6imXQBhGrgTmiNGAC6R6xqyW8Kz0h0Ipc6yJ3hnEI4prqwV6Nn3kKcigPODDufaGNeVFpSA55jQf+drM7eE6NEGIuzT3odDozzekGSQ4yFQ7TC0fV1XfPB+ET8wFotB22PpYct2xIxyCt8gSMJ6hL2u7Qc1PSpClGPwbk0Juz2MlGrwF1q4xNN7jpxaA6sr3N8JOFrVl1NinwcVf6DR1AJoznD+G4ZkGNLv8b9DgegfJfJRnZ/lA+O5nNN/0s7qhhhzpeiBPe0Glab0uqEZTOpsfLXexiG1MBj8KDBiGrh2Q/rkZuFO+AwqdpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cnAYKh1shkkA85DEnHbMIrt2Eg+/owJOFhgRJQFMVU=;
 b=FMM7SYcSYflqqvT/Tw7cfHZDm3OycPyjCWwjIgvuW/rUMI/yjspDNSKoiG2IP9aKR6WfKFrKe3arly9a1NPF4SNHdT1Vrs9Eh1uOFfvxqxE4Sh4XVLqLqVA+VD4hIPBGMxcPnlM44bMCcCghtjWLvPgJDpD5GuMOJXIbHfoCREObsF3QngZObUAYkyeS2Oced3K0l35DGC78UGNuymYwgt4N7ACZ3qqGI4HUUPVjQIjh8lv9FPyGZ2l8rtpp/Isx1ynS/mX9VxLRU1s9Nj17adFtuPGpIOR3RbcQZozG5REJIbrktYZqmygjs2iyYqK+pJUUBtrPt2zXaaJmIj5qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cnAYKh1shkkA85DEnHbMIrt2Eg+/owJOFhgRJQFMVU=;
 b=1Mq04T+JbAdPfc1RfoodZmygDIwluo+q+4VV5fcBWdlE6kQO3UWUZZcGXGSAa6sYIlPhJG9dfWZLBStRJz1ZaeLLHomp3Vq5eBUU1sGBRBNNRN7KLvCDIlihg8Xj09mlLuN2As6bvjRx0sI+0323qWaorW0iGjmK6Ax+ndE65fk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3564.namprd12.prod.outlook.com (2603:10b6:5:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:27:39 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:27:39 +0000
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Add support for USBC PD FW download
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583339021-12298-4-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <14d3ba66-79b1-f5ab-a827-b684b07be3cc@amd.com>
Date: Wed, 4 Mar 2020 11:27:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583339021-12298-4-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Wed, 4 Mar 2020 16:27:38 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23c14542-5664-4d5a-0dff-08d7c058f480
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:|DM6PR12MB3564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35645F4C8A34E261118985D599E50@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(2616005)(956004)(66946007)(5660300002)(81156014)(86362001)(8936002)(16576012)(478600001)(52116002)(66556008)(2906002)(81166006)(36756003)(31696002)(66476007)(53546011)(316002)(6486002)(8676002)(4326008)(26005)(16526019)(186003)(31686004)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3564;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +29ONSZtPB8Kyh/3Bg21YNvR6cfz/qTobLNzaSWcNjoOiq08jYAUepFqlIcDj5F6OHUpJHwiVyiPccaNP+0qL1OqWs5RyLK2/swSnIE71kC+M67GZ/nM0HZTUwN09VDXA5jnWWKKIz0DThX08UGVP5lB+42vFsicI/GkvsQ12rub5127D2p5r3y92wQKPJAtxqoOQZKJgledX43SKRXFSptvj8m4APvkTehWKHTf1NIbWSSBYEeT4mp3VwmaE8SXyslx64yEI0UFuAk4bvtXE9XSKErFVYlmA/FN6XEdvzO86fDaWV7an/aG6cUDLT+9NCYFHkmqW5Eo5Pb7gS9MuzVrb+9a/i1Fski+hGJsJaweeWPGq3g68CZaV6F4aACU+ZJjI+pJQr5i0r6GXu0ogBno5TEvui+vcuaRfK/GlhqA1CoCvhJTLOykKJfEQ5s0
X-MS-Exchange-AntiSpam-MessageData: IDwK2IfncyvDl3puyCXksRxWJV+EsTQwZcVFoQPBdUavoPaUJOc+xEZTYKHSQo2TASWcyn+5sTB7Er4HKNcUHdIW1miez62gWTDz2o5XzJPHZWqPrDhaHy7yHy5ka6Y1GBMeJsAei/MknJ5o/EoAUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c14542-5664-4d5a-0dff-08d7c058f480
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:27:38.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE0tbvbIIikRtNySramSk3zoFU2ZqyHLWiZLN3eVCVKQb0NV48bx0FuiEjLDG77d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-03-04 11:23, Andrey Grodzovsky wrote:
> Starts USBC PD FW download and reads back the latest FW version.
> 
> v2:
> Move sysfs file creation to late init
> Add locking around PSP calls to avoid concurrent access to PSP's C2P registers
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d33f741..cff0fd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/dma-mapping.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_psp.h"
> @@ -38,6 +39,9 @@
>  
>  static void psp_set_funcs(struct amdgpu_device *adev);
>  
> +static int psp_sysfs_init(struct amdgpu_device *adev);
> +static void psp_sysfs_fini(struct amdgpu_device *adev);
> +
>  /*
>   * Due to DF Cstate management centralized to PMFW, the firmware
>   * loading sequence will be updated as below:
> @@ -113,6 +117,16 @@ static int psp_early_init(void *handle)
>  	return 0;
>  }
>  
> +static int psp_late_init(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	if (adev->asic_type == CHIP_NAVI10)
> +		return psp_sysfs_init(adev);
> +
> +	return 0;
> +}
> +
>  static int psp_sw_init(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -152,6 +166,10 @@ static int psp_sw_fini(void *handle)
>  		release_firmware(adev->psp.ta_fw);
>  		adev->psp.ta_fw = NULL;
>  	}
> +
> +	if (adev->asic_type == CHIP_NAVI10)
> +		psp_sysfs_fini(adev);
> +
>  	return 0;
>  }
>  
> @@ -1816,10 +1834,85 @@ static int psp_set_powergating_state(void *handle,
>  	return 0;
>  }
>  
> +static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +	uint32_t fw_ver;
> +	int ret;
> +
> +	mutex_lock(&adev->psp.mutex);
> +	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
> +	mutex_unlock(&adev->psp.mutex);
> +
> +	if (ret) {
> +		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
> +		return ret;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
> +}
> +
> +static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> +						       struct device_attribute *attr,
> +						       const char *buf,
> +						       size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +	void *cpu_addr;
> +	dma_addr_t dma_addr;
> +	int ret;
> +	char fw_name[100];
> +	const struct firmware *usbc_pd_fw;
> +
> +
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> +	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> +	if (ret)
> +		goto fail;
> +
> +	/* We need contiguous physical mem to place the FW  for psp to access */
> +	cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
> +
> +	ret = dma_mapping_error(adev->dev, dma_addr);
> +	if (ret)
> +		goto rel_buf;
> +
> +	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> +
> +	/*TODO Remove once PSP starts snooping CPU cache */
> +	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
> +
> +	mutex_lock(&adev->psp.mutex);
> +	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
> +	mutex_unlock(&adev->psp.mutex);
> +
> +rel_buf:
> +	dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
> +	release_firmware(usbc_pd_fw);
> +
> +fail:
> +	if (ret) {
> +		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
> +		return ret;
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
> +		   psp_usbc_pd_fw_sysfs_read,
> +		   psp_usbc_pd_fw_sysfs_write);
> +
> +
> +
>  const struct amd_ip_funcs psp_ip_funcs = {
>  	.name = "psp",
>  	.early_init = psp_early_init,
> -	.late_init = NULL,
> +	.late_init = psp_late_init,
>  	.sw_init = psp_sw_init,
>  	.sw_fini = psp_sw_fini,
>  	.hw_init = psp_hw_init,
> @@ -1834,6 +1927,21 @@ const struct amd_ip_funcs psp_ip_funcs = {
>  	.set_powergating_state = psp_set_powergating_state,
>  };
>  
> +static int psp_sysfs_init(struct amdgpu_device *adev)
> +{
> +	int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
> +
> +	if (ret)
> +		DRM_ERROR("Failed to create USBC PD FW control file!");
> +
> +	return ret;
> +}
> +
> +static void psp_sysfs_fini(struct amdgpu_device *adev)
> +{
> +	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
> +}
> +
>  static const struct amdgpu_psp_funcs psp_funcs = {
>  	.check_fw_loading_status = psp_check_fw_loading_status,
>  };
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
