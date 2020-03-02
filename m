Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2FC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C62C320732
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sMHADjJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62C320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C50589E8C;
	Mon,  2 Mar 2020 21:43:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B9589E8C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmlhNnIjwzxi/rx+zc5TD+zEmHao5XltmRy1JgG62B15UsRRjkPr6jhVCTU52VK4bAvF8p2kvS+LqrE8XP/byctpiwvfxxG1ps3kwtepjohhKOwPdQ+rnx4byMeYfdhvAko4NDTwFzleEO8qPKxrgBSTDwWrc/xO3o824f6GG/2j/8IHjkTacIWlthoTJ1tzs58WyP1a+FomxI3UV0XFFQX7bENTL0YdLN+dbRtoe5AqMQUE2BJPQkUng6rWvT4CCJ2mfGQ369eKu1g+4ZjCxyhPzUbjX9XCIFvG7HLEOiwAL+6ak3C1i5qAIIguWjwB6PksUMsuxPT21eSBKvFBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyLoRCkrpKQHW/0EJRcqneBLjrRn0iYEP9p5AodeL1U=;
 b=aFUB7QJ0LvWmShpaVK9jb8ka4+66FBAUQDd7qqiJwtezM5ia/ImnRbuo4+sgfp2UB+DEZ2Q+KG48ChF6l/C0tROyTrrjfIlUb6lv59loRCEFWrPxCKS7rxAE/wgEyw43bjyNSse5dgLAQybsIo4sEezumzEolLzd+DcvddOo0QFyuFkHIovZaXi6rc8RrrhNQj2F0Zxn7MEA0fd998U+tYXgu4b9C4BSL9cM1aROMS4USfN0MA20wHkcyyFuzIvwzTEO/hH23edr9eEi1gStq8sCZ+ZByHc5eBkndRJF997Z3aXRf5xGIOW1yKHqjaC4/dM1+7jKu6X8RN9LP8IPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyLoRCkrpKQHW/0EJRcqneBLjrRn0iYEP9p5AodeL1U=;
 b=sMHADjJMzfU2kThjbh4kM5wSz+pbd9CyUuD0FhWXzjun727b6s+XqnpswszS7cXV0TFeRvjqjLTIB8b4jGNO4hpHwZZj/AL6bRCB4YSxudmVaDvw3zzTBzNjam4KtgeRRINxsLqsgX6rI2i6Ka46Jx6D5CzYlMpqKJSylnZ9q/M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 21:42:59 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 21:42:59 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for USBC PD FW download
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-4-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <510a0218-1984-b675-a326-8be13a0a9c10@amd.com>
Date: Mon, 2 Mar 2020 16:42:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1583177061-3115-4-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 21:42:58 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea08fe32-a26f-436e-e9cf-08d7bef2acf6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3993:|DM6PR12MB3993:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3993C135B6B5E4746261574499E70@DM6PR12MB3993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(6486002)(8676002)(8936002)(81156014)(81166006)(66946007)(5660300002)(2616005)(66556008)(478600001)(4326008)(2906002)(316002)(956004)(66476007)(53546011)(6506007)(16526019)(52116002)(186003)(6512007)(26005)(86362001)(44832011)(31686004)(36756003)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3993;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8hTjMCqQ7dyBWGFSXAnR8013UP/5N0opDy4GAgE8IeootrKMwnyDKNcOA+icgJZUs+wkZJkMPygaqUicCy7a1IgMkosV7TEL5AunLbdLYza+iIQL/a4Ed6wCGIES1aTGcyziwVHn/Oy70dBySLUBLVe1ITgJJTp7Rg2y3lzq/mQL1ZbmkrNLkYSevYmAw5zYxhwU2HrjNf7I3vUfWsgh/uGfVbqhrHweT4uWKTt3EKnDPYQQbHe/smsRq1N7mfyl+YGu9hBNxHL64S1chW/X92oMC8RB96FtoGrm/3VSwpn4LoHkXcOCP0KBUYerzpCrXdAqqnsy5/FK1Nl1TYloIbKu8R7x1iNsT8DJe6HzB6roswRKa5i21B5BtZUu5H6J3v7fiFa0D0u+OQiVLZAmYDtUA6SYzNGxdXut+WvdA7P8YwHE8pmRxa/iBcRNo+o
X-MS-Exchange-AntiSpam-MessageData: dFtlokWf0TjHuUk60I2w0VmWziEkjmtVTzYpmKSiO7K03kkxfl2dUaRZI+EVS1DiG7Z1Mvtk2ZEizg/tQffL35ESicX5HRo/jL0Fqu1X3uVTawJo1MYhsjKa+vMDxAyD8yW15iJuICku3vZaCq9fBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea08fe32-a26f-436e-e9cf-08d7bef2acf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 21:42:59.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC+6rU98dFhD0eZiLNOBl3JqjlipPtDPt1jlhT27658672OrjnrRcZW9kZefhZ4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3993
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-02 2:24 p.m., Andrey Grodzovsky wrote:
> Starts USBC PD FW download and reads back the latest FW version.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 +++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d33f741..76630b9 100644
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
> @@ -94,6 +98,7 @@ static int psp_early_init(void *handle)
>  		psp->autoload_supported = false;
>  		break;
>  	case CHIP_NAVI10:
> +		psp_sysfs_init(adev);
>  	case CHIP_NAVI14:
>  	case CHIP_NAVI12:
>  		psp_v11_0_set_psp_funcs(psp);
> @@ -152,6 +157,10 @@ static int psp_sw_fini(void *handle)
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
> @@ -1816,6 +1825,76 @@ static int psp_set_powergating_state(void *handle,
>  	return 0;
>  }
>  
> +static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
> +						struct device_attribute *attr,
> +								char *buf)

Alignment of the parameters is off here. After applying your patch, the alignment
looks like the above.

> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = ddev->dev_private;
> +	uint32_t fw_ver;
> +	int ret;
> +
> +	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
> +	if (ret) {
> +		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
> +		return ret;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);

I'd rather print the firmware version in some fixed format,
like say "%08X" (in upper hex digits), since it is not an integer, but a fixed
string (8) of hexadecimal numbers.

It'll make it easy to copy-and-paste and the visual cue is there
when displayed to a screen. Even more so when visually compared,
say in a report of what was being tested and so on.

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
> +	int ret = 0;

No need to set "ret" to anything here. After all, you cannot predict
that "all will be well". Let the compiler prove that
it is never being used without being set.

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

"rel_buf" could also be the identifier of a string or a buffer.
But if you named it "Out_release_buf", then no one would ever confuse
it for a name of a variable (all lower case) or a macro (all upper-case).
Not a blocker, just style.

> +
> +	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> +
> +	/*TODO Remove once PSP starts snooping CPU cache */
> +	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));

Not a blocker, but it is easier to read a commment like this:

	/* TODO: Remove once PSP starts snooping the cache.
	 */
	cflush_cache_range(cpu_addr, ...);


> +
> +	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
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
> @@ -1834,6 +1913,21 @@ const struct amd_ip_funcs psp_ip_funcs = {
>  	.set_powergating_state = psp_set_powergating_state,
>  };
>  
> +static int psp_sysfs_init(struct amdgpu_device *adev)
> +{
> +	int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
> +
> +	 if (ret)
> +		 DRM_ERROR("Failed to create USBC PD FW control file!");

There's an extra space after the tab char in the above two lines--perhaps
from a cut-and-paste.

Regards,
Luben

> +
> +	 return ret;
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
