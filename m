Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81883F5A8B6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 19:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D0310E735;
	Mon, 20 Apr 2026 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlvdi2vP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5271010E735
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 19:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teKdTmTdo/QU5c6pRtP3+3ks5h1GvAcigstoE/VYyj/M3tQ1wyWJX2oDLgg93BJMRqzVe6luwNo/UHqYLMPC+a167/GihNAOjhAJMwrHtSFTzx+xzDOBA9cfglb/00K5dy98CQ1eIE0iDY2pHgP+alAQv+ppwknKYhVA9N6mC2M6IDf4eYwADfC+3jt4S2Vfjha/aakxKwx4XUMqD86qJRxPUhRkxzpkQxL3G+y95X76SzLi1YJ5+i/PZnM9V4pMbdleSKFSbLG3nVHd2LRZT+rYckNij2ahuLqYz4wt0zAkfo/aPR/3L29ui6RC90x0FUXtBHTPW925vuotcibGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UWFEcGp96N8iYOuHy7gagYOcmsQe5T23hFqWXhtH74=;
 b=jaL2sMookWPiZqPOG88dQBx4m5rXLAQ23cnA6LXGC74CV6e5Ve8I0V+FL1xRKSXWwF4CwoAvZkLcZ5gAoL+9DsCE6r/iDUNcuA8HnoNQYXrEnwHvn6v4Lb2W7UVBzEXP99ePT1HYqnlZH560NqzWpp8XvHKkMY/nSpJEYtwl8qUNA7IPkl5b/D7kqRBJa5fNpK7PIoQjV0q8CVv0WuslsJoI8b6WxZDATeChSTWPMTCnSKX7CsKJ37hguM/gytMWMZSR4Fx0TNsyzw+Hd3zPxlg5Neta/Wz7hyh8h0IXeYnKmunPadfVOfH+E+5/IgNlszEP/15PM4C3j3dTy3MUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UWFEcGp96N8iYOuHy7gagYOcmsQe5T23hFqWXhtH74=;
 b=qlvdi2vPj5AsSRw8c9XMG2cY7lShlUV/bEtmRz/+2r1muMBZyPoWl2O1ZZ7c652OGp4X4ZDjvQIM/mS7hyuIKpX6lWrMdagYh6+4Sj6V43eKALvZVYc2JSxsXTO5qNvDn0zjHGcva3j9/rDXF/lMjlDygAIBwBgO1ZaKODYLNfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 19:27:12 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 19:27:12 +0000
Message-ID: <2a90cc74-2151-4e8d-bebf-232dd66ba8e1@amd.com>
Date: Mon, 20 Apr 2026 14:27:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Export ip_discovery sysfs on probe failure
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Ryan.Fechney@amd.com
References: <20260406212442.2321667-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260406212442.2321667-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:806:122::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf56f3b-90ef-44b3-a429-08de9f12d123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: G3k0hxe2dsUGDywk13Uw/MVzM/ZkMiYEX0Fa5Akb8XKSfFv0QoOds2XPQ6V+XeuEOrc/pWqahO1SU06r5Dp8zA0SlRcj1jrkEllUyUz8h2SgDiJvrMvdZCYs3lsehONKkaaWW9IbEcSCdTv4MyTZ9ZtJCRw0m5PjhA+HahGEtKm3TE4w3uudDF/c07gY2VJsGmiKrd+1ndBEvvCCXLpInbytjiaqY36rmZo/g167PirMkL1hP3Uypg65Ib4j/hh89QPUQOGuhP9ZUVp8DR13Gl708BtdAg3fxwIKwU5Th58ohgpkoGrjRo5nprULhxHsGzG/oehja66Nl4/XeArT/RsLZzhy32Bdjwa3tJZw/OMTJLnh/R2OUrxdz34FxaZzWKRrhIwFvmSrjd9ocwMUXwEIb9QXWkpT3qQN0EIS0esfB3n6i6T/XU8CX9Mprr4Nv5D3afAgjK08wR5blQcFWBFjCvVwRUp+/+GxIkHwHmkohv92oTd2G8NyLBYYyNF6+T4YlrRSJm/8QtvBJCee9wCRL/31YQpVi9+gjaZhslXL4FRPxR7wxjJ3GYXNCTz1jMZ7jSMZcGPceNSEWSldsZSH8a7UHUNaEyYC12cSK6GE+TNdYBG+c30L9/pWyyH2WkBan8C5/qwhLInMnEqjFk59+OTxR0egpIXilWZzgLqUeU6kSfHG1YAa2w8lEYGtb4ImAF8p/ucqgXuUZqPor8KGmoj6Imsn74hcVGVxYoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHhaV1J1UTZmTDlzNkIxUE0vK3VTMVRGaTNHL3hac3lQSWZTU01MUGRaQzVK?=
 =?utf-8?B?dmVxYXZmY21ZRE5xNUVsTXMxUWRoRjlEKytBT3VPaUNCckVITUFwbEdtRlNu?=
 =?utf-8?B?ditpV2lMMjR5N1N1bVpZUUR5R1dkMFdLK0ZGSXAxRlBaaFFPSmRIVjZESDI2?=
 =?utf-8?B?aFVkUWpWRDQrODJGSnBMVXljOUxWNDl1N2JVU3E0TG4zcXZGb1pyU295THZm?=
 =?utf-8?B?S2gwbHVZenpOTGdVRlprbDg5SEs1SXNsQjJaSk1Jclp1bUF3Z0NJVG1pWUk3?=
 =?utf-8?B?bXNzWUdlMGRDVXgwbStKVVJENWp5Y1laRWo2L3BES2FFSDVXb3BnM2I0RGg1?=
 =?utf-8?B?WmlzeVFFbGpuSEpwbldZaFJPVzdJLzl3Qk1UQTJUN2h3NWgrQ3Yvd29Bd3JN?=
 =?utf-8?B?L0VhNXIrRUFJdVpFZFpGdm9zamVYOVk2T2NrckMzWkppZkNWQkVHZnFPS2Vv?=
 =?utf-8?B?Zjc0N3BQSVZGU3kwWnR2MGJoMDlaZXdhT29jcFNMV1NLOUNaNXUxcDNzZ3d6?=
 =?utf-8?B?RVNMMW8vWDBqRk0xNnI1bGxjN3lYaEVhdE9qMFB2STVnZnBzOXUwQ2tRc3Rq?=
 =?utf-8?B?aWVRYUlTRjVmQU5SSEI3Z3NWT29PMFp1bnoxVnhqcFY0akZQT2V0MlFLeWRB?=
 =?utf-8?B?OTB4MHJCcjk3VVB2blg3aU56TEwrck9NM1JyRThSVmhZMWtpZDdwdjJNU2pz?=
 =?utf-8?B?VmNaMW83dFlVSndwRTBVWTZZY1lROTY3UExLT2Y0ZDR5di9peVovZ0ZHbGUw?=
 =?utf-8?B?NzhiOUhrOHEyaEpYM1ZRMmN3eWtla3J0ZElReHpKTVVGNGI5ZlVlZ1RxVzVt?=
 =?utf-8?B?WGFPSSt1NDFZOTVKd1ZFMTZTdXJsOEhVazBPRHo3T3I2NCtWSkhZUjROMG84?=
 =?utf-8?B?L1VsUGxtRHNoc0E0cEZSMDlqM0NMdGRmVTBhek4xSElERENXQVE2NndHdzZv?=
 =?utf-8?B?dThTK1ZYRW5Bc2ZpMVNNZndMQW9Va2VuTXZDUTdGaTZuYThiVnRiYmdiTHFJ?=
 =?utf-8?B?VUJJNm9IOGZpc3d2VWZkelhvUndKSW9WRmlhL1V3MHdlMGNPZU5kT0Jqc3hj?=
 =?utf-8?B?aHYzejUxazBYTWxFL0UxaURvVjY1VkJsQXlkRzNvWlhoc2FlQTZPYm54L2hh?=
 =?utf-8?B?UnVQK1JqcmlobnNsM2MvdXp3LyttNTEzbzI0d2FxY1U1T0N4aWlWWGRWTGNz?=
 =?utf-8?B?ZUVFdTd4TjhOb1Y3V3lvRXgzeW14dUVZcmE4K2s1R05IelVuOVhyWFdtb1Vh?=
 =?utf-8?B?TWd3b243YUpYem9aQkF4TEZ3S2E5Nlp6UUZvMTM4V1hzbkQ1OUJkU052U0R6?=
 =?utf-8?B?WlQvZXh0QW5PUExzcTV1cFBRMHhXRGtVSTlibHpYWFU0T1djU2d3UFQ3UHgv?=
 =?utf-8?B?aVN5RFB0SFV1V0I5aVcyeDhsYUtzeVBSN01oSFdzY3lJdTFITU8yZ2lWbkFj?=
 =?utf-8?B?RkIxK1Zmd2gzY3ErQm41QVZ6NHhtbDM2cFZJbVlIWkxTMGdjVXNuVDM5UnVM?=
 =?utf-8?B?T3BRQU50ZlJ4TktGOHRoSVlibm43Q21JKytUcUxWazdIa05hUzRkNG9NQ0du?=
 =?utf-8?B?NHkyNjJxQU5qb1I5bXJXSGxGN3h4ZjdCVHk0NDJvQnllWUtleVBGZ3dNb1Zh?=
 =?utf-8?B?MlNwM29vcVJUSVNydDRRTUVlSHNWNjBCTkMzZWZsdjlhaVhlb3ArLytVQ1Bj?=
 =?utf-8?B?eHN6V2U4TDgzOVQ4dk5hejl4amJ2UWo1cGM1aytJUU0yR3hSZ3owaUpkdEpy?=
 =?utf-8?B?cVpxYytMcTYraDhDZkM4YU5Kd1Y0TlE2MzUwRU9XbTBjS0QvNDhDOURFcE9x?=
 =?utf-8?B?UENjeFg3aWczaWRrOTcxaGtIZC9zRXJKRzFrNnUwaXdVY0NVTlJLMDFYeTB6?=
 =?utf-8?B?bk00M2NGQWhieW1Mc1VvWTFhQTRUV2JwcWxVQ09sc0Q2NTZUWE8xUzZKbThy?=
 =?utf-8?B?ZTFxMlFHdUN6R2FNZUcvTzhnQ0E2NERmcTN3TXF4ZG1vdkZIYXQvay9qcE9t?=
 =?utf-8?B?cng3QmpoYjA5djR0VHNJV1lkY2FtOExwK09rUUkzMnErMGFwSnRrZFVIeW9q?=
 =?utf-8?B?U3NKLzlacmdHais1TFdnNVJRV0Q0eklRM3hiS2s5REhZZjlic1VHN2dKQzYv?=
 =?utf-8?B?elA5RnhnTFdEQ1ZjV2pRMTFmVkJvQUNodCt3VktYemF3dW5ZYVBZMUFVU2pZ?=
 =?utf-8?B?a0NMOEd1ZGFDWkxuNXdtMFpBNlhueTJqQTdwSGR6NXEwTkI4OFlTRnN6bU5V?=
 =?utf-8?B?UkozYldOV2RVSmxUVUZlc2sweVVDekVBNHBRNjI4bzR2YzU0MUxlZUFNZU1a?=
 =?utf-8?B?UU91WFc4c21qNTYwd2lURVdCcGUzNW15TCsrRE5JSTNlTTRWZVlaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf56f3b-90ef-44b3-a429-08de9f12d123
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:27:12.7024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT1fUPFZ6cQUf4mEsUWtrQKkGL0obyq5cRrJJptMkylDXYSwsdV4UOyL0abndpPkkC1kYhTOTpVAbl8G9Lpg6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354
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



On 4/6/26 16:24, Mario Limonciello wrote:
> When driver probe fails (missing firmware, unsupported hardware, etc.),
> the entire device is torn down including the ip_discovery sysfs folder,
> preventing users from identifying what hardware is present.
> 
> Export ip_discovery sysfs even when probe fails by creating it early
> in the probe flow and tying its lifetime to the PCI device rather than
> the driver. The sysfs folder persists across probe failures and module
> reloads, but is cleaned up on driver unbind.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

ping?

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 248 ++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>   3 files changed, 234 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index af3d2fd61cf3f..f88cffa56c6ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -22,6 +22,7 @@
>    */
>   
>   #include <linux/firmware.h>
> +#include <linux/kernfs.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_discovery.h"
> @@ -139,6 +140,26 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
>   #define mmMM_INDEX_HI		0x6
>   #define mmMM_DATA		0x1
>   
> +struct ip_discovery_top {
> +	struct kobject kobj;
> +	struct kset die_kset;
> +	struct pci_dev *pdev;
> +	struct amdgpu_device *adev;
> +	uint8_t *discovery_bin;
> +	uint32_t bin_size;
> +	bool standalone_mode;
> +};
> +
> +/* List to track early-initialized ip_discovery_top entries */
> +struct early_ip_discovery {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +	struct ip_discovery_top *ip_top;
> +};
> +
> +static LIST_HEAD(early_ip_discovery_list);
> +static DEFINE_MUTEX(early_ip_discovery_mutex);
> +
>   static const char *hw_id_names[HW_ID_MAX] = {
>   	[MP1_HWID]		= "MP1",
>   	[MP2_HWID]		= "MP2",
> @@ -676,7 +697,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);
>   
>   void amdgpu_discovery_fini(struct amdgpu_device *adev)
>   {
> -	amdgpu_discovery_sysfs_fini(adev);
> +	if (adev->discovery.ip_top && !adev->discovery.ip_top->standalone_mode)
> +		amdgpu_discovery_sysfs_fini(adev);
> +
>   	kfree(adev->discovery.bin);
>   	adev->discovery.bin = NULL;
>   }
> @@ -685,15 +708,17 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
>   					uint8_t instance, uint16_t hw_id)
>   {
>   	if (instance >= HWIP_MAX_INSTANCE) {
> -		dev_err(adev->dev,
> -			"Unexpected instance_number (%d) from ip discovery blob\n",
> -			instance);
> +		if (adev)
> +			dev_err(adev->dev,
> +				"Unexpected instance_number (%d) from ip discovery blob\n",
> +				instance);
>   		return -EINVAL;
>   	}
>   	if (hw_id >= HW_ID_MAX) {
> -		dev_err(adev->dev,
> -			"Unexpected hw_id (%d) from ip discovery blob\n",
> -			hw_id);
> +		if (adev)
> +			dev_err(adev->dev,
> +				"Unexpected hw_id (%d) from ip discovery blob\n",
> +				hw_id);
>   		return -EINVAL;
>   	}
>   
> @@ -1056,12 +1081,6 @@ static const struct kobj_type ip_discovery_ktype = {
>   	.sysfs_ops = &kobj_sysfs_ops,
>   };
>   
> -struct ip_discovery_top {
> -	struct kobject kobj;    /* ip_discovery/ */
> -	struct kset die_kset;   /* ip_discovery/die/, contains ip_die_entry */
> -	struct amdgpu_device *adev;
> -};
> -
>   static void die_kobj_release(struct kobject *kobj)
>   {
>   	struct ip_discovery_top *ip_top = container_of(to_kset(kobj),
> @@ -1077,8 +1096,14 @@ static void ip_disc_release(struct kobject *kobj)
>   						       kobj);
>   	struct amdgpu_device *adev = ip_top->adev;
>   
> +	/* In standalone mode, discovery_bin is managed by devm and will be
> +	 * freed automatically when the PCI device is removed. Do not manually
> +	 * free it here to avoid double-free.
> +	 */
> +
>   	kfree(ip_top);
> -	adev->discovery.ip_top = NULL;
> +	if (adev)
> +		adev->discovery.ip_top = NULL;
>   }
>   
>   static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
> @@ -1086,6 +1111,10 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
>   {
>   	uint8_t harvest = 0;
>   
> +	/* In early init mode (adev == NULL), harvest info is not available */
> +	if (!adev)
> +		return 0;
> +
>   	/* Until a uniform way is figured, get mask based on hwid */
>   	switch (hw_id) {
>   	case VCN_HWID:
> @@ -1114,11 +1143,14 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
>   }
>   
>   static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
> +				      struct ip_discovery_top *ip_top,
>   				      struct ip_die_entry *ip_die_entry,
>   				      const size_t _ip_offset, const int num_ips,
>   				      bool reg_base_64)
>   {
> -	uint8_t *discovery_bin = adev->discovery.bin;
> +	uint8_t *discovery_bin = ip_top->standalone_mode ?
> +				 ip_top->discovery_bin :
> +				 adev->discovery.bin;
>   	int ii, jj, kk, res;
>   	uint16_t hw_id;
>   	uint8_t inst;
> @@ -1220,10 +1252,12 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
> +static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
> +					  struct ip_discovery_top *ip_top)
>   {
> -	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
> -	uint8_t *discovery_bin = adev->discovery.bin;
> +	uint8_t *discovery_bin = ip_top->standalone_mode ?
> +				 ip_top->discovery_bin :
> +				 adev->discovery.bin;
>   	struct binary_header *bhdr;
>   	struct ip_discovery_header *ihdr;
>   	struct die_header *dhdr;
> @@ -1270,7 +1304,8 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
>   			return res;
>   		}
>   
> -		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips, !!ihdr->base_addr_64_bit);
> +		amdgpu_discovery_sysfs_ips(adev, ip_top, ip_die_entry, ip_offset,
> +					   num_ips, !!ihdr->base_addr_64_bit);
>   	}
>   
>   	return 0;
> @@ -1286,12 +1321,30 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   	if (!discovery_bin)
>   		return -EINVAL;
>   
> +	/* If early init already created sysfs in standalone mode, skip normal init */
> +	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
> +		return 0;
> +
>   	ip_top = kzalloc_obj(*ip_top);
>   	if (!ip_top)
>   		return -ENOMEM;
>   
>   	ip_top->adev = adev;
> -	adev->discovery.ip_top = ip_top;
> +
> +	/* Check if ip_discovery already exists before creating.
> +	 * This shouldn't normally happen but handle it gracefully.
> +	 */
> +	if (adev->dev->kobj.sd) {
> +		struct kernfs_node *existing;
> +
> +		existing = kernfs_find_and_get(adev->dev->kobj.sd, "ip_discovery");
> +		if (existing) {
> +			kernfs_put(existing);
> +			kfree(ip_top);
> +			return 0;
> +		}
> +	}
> +
>   	res = kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
>   				   &adev->dev->kobj, "ip_discovery");
>   	if (res) {
> @@ -1299,6 +1352,8 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   		goto Err;
>   	}
>   
> +	adev->discovery.ip_top = ip_top;
> +
>   	die_kset = &ip_top->die_kset;
>   	kobject_set_name(&die_kset->kobj, "%s", "die");
>   	die_kset->kobj.parent = &ip_top->kobj;
> @@ -1313,7 +1368,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
>   	ip_hw_instance_attrs[ii] = NULL;
>   
> -	res = amdgpu_discovery_sysfs_recurse(adev);
> +	res = amdgpu_discovery_sysfs_recurse(adev, ip_top);
>   
>   	return res;
>   Err:
> @@ -1366,6 +1421,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>   	struct list_head *el, *tmp;
>   	struct kset *die_kset;
>   
> +	if (!ip_top)
> +		return;
> +
>   	die_kset = &ip_top->die_kset;
>   	spin_lock(&die_kset->list_lock);
>   	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> @@ -1379,6 +1437,151 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>   	kobject_put(&ip_top->kobj);
>   }
>   
> +int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev, struct pci_dev *pdev)
> +{
> +	struct ip_discovery_top *ip_top;
> +	struct early_ip_discovery *early_entry, *tmp;
> +	struct kset *die_kset;
> +	uint8_t *discovery_bin;
> +	int res, ii;
> +
> +	if (!adev || !adev->discovery.bin)
> +		return -EINVAL;
> +
> +	if (adev->discovery.ip_top)
> +		return 0;
> +
> +	mutex_lock(&early_ip_discovery_mutex);
> +	list_for_each_entry_safe(early_entry, tmp, &early_ip_discovery_list, list) {
> +		if (early_entry->pdev == pdev) {
> +			adev->discovery.ip_top = early_entry->ip_top;
> +			early_entry->ip_top->adev = adev;
> +			mutex_unlock(&early_ip_discovery_mutex);
> +			return 0;
> +		}
> +	}
> +	mutex_unlock(&early_ip_discovery_mutex);
> +
> +	discovery_bin = adev->discovery.bin;
> +
> +	early_entry = kzalloc_obj(*early_entry);
> +	if (!early_entry)
> +		return -ENOMEM;
> +
> +	ip_top = kzalloc_obj(*ip_top);
> +	if (!ip_top) {
> +		kfree(early_entry);
> +		return -ENOMEM;
> +	}
> +
> +	ip_top->discovery_bin = devm_kmemdup(&pdev->dev, discovery_bin,
> +					     DISCOVERY_TMR_SIZE, GFP_KERNEL);
> +	if (!ip_top->discovery_bin) {
> +		kfree(ip_top);
> +		kfree(early_entry);
> +		return -ENOMEM;
> +	}
> +
> +	ip_top->bin_size = DISCOVERY_TMR_SIZE;
> +	ip_top->pdev = pdev;
> +	ip_top->adev = adev;
> +	ip_top->standalone_mode = true;
> +
> +	/* Check if ip_discovery already exists (from previous probe attempt).
> +	 * This can happen if the module was unloaded and reloaded but the
> +	 * sysfs persisted (tied to PCI device lifetime).
> +	 */
> +	if (pdev->dev.kobj.sd) {
> +		struct kernfs_node *existing;
> +
> +		existing = kernfs_find_and_get(pdev->dev.kobj.sd, "ip_discovery");
> +		if (existing) {
> +			kernfs_put(existing);
> +			kfree(ip_top);
> +			kfree(early_entry);
> +			return 0;
> +		}
> +	}
> +
> +	res = kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
> +				   &pdev->dev.kobj, "ip_discovery");
> +	if (res)
> +		goto err_put_kobj;
> +
> +	adev->discovery.ip_top = ip_top;
> +
> +	die_kset = &ip_top->die_kset;
> +	kobject_set_name(&die_kset->kobj, "%s", "die");
> +	die_kset->kobj.parent = &ip_top->kobj;
> +	die_kset->kobj.ktype = &die_kobj_ktype;
> +	res = kset_register(&ip_top->die_kset);
> +	if (res)
> +		goto err_put_die_kset;
> +
> +	for (ii = 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> +		ip_hw_instance_attrs[ii] = &ip_hw_attr[ii].attr;
> +	ip_hw_instance_attrs[ii] = NULL;
> +
> +	res = amdgpu_discovery_sysfs_recurse(NULL, ip_top);
> +	if (res)
> +		goto err_put_die_kset;
> +
> +	early_entry->pdev = pdev;
> +	early_entry->ip_top = ip_top;
> +	mutex_lock(&early_ip_discovery_mutex);
> +	list_add(&early_entry->list, &early_ip_discovery_list);
> +	mutex_unlock(&early_ip_discovery_mutex);
> +
> +	return 0;
> +
> +err_put_die_kset:
> +	kobject_put(&ip_top->die_kset.kobj);
> +err_put_kobj:
> +	kobject_put(&ip_top->kobj);
> +	kfree(early_entry);
> +	adev->discovery.ip_top = NULL;
> +	return res;
> +}
> +
> +void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev)
> +{
> +	struct early_ip_discovery *entry, *tmp_entry;
> +	struct ip_discovery_top *ip_top = NULL;
> +	struct list_head *el, *tmp;
> +	struct kset *die_kset;
> +
> +	/* Find the entry in our tracking list */
> +	mutex_lock(&early_ip_discovery_mutex);
> +	list_for_each_entry_safe(entry, tmp_entry, &early_ip_discovery_list, list) {
> +		if (entry->pdev == pdev) {
> +			ip_top = entry->ip_top;
> +			list_del(&entry->list);
> +			kfree(entry);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&early_ip_discovery_mutex);
> +
> +	if (!ip_top)
> +		return;
> +
> +	/* Clean up sysfs hierarchy */
> +	die_kset = &ip_top->die_kset;
> +
> +	spin_lock(&die_kset->list_lock);
> +	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> +		list_del_init(el);
> +		spin_unlock(&die_kset->list_lock);
> +		amdgpu_discovery_sysfs_die_free(to_ip_die_entry(list_to_kobj(el)));
> +		spin_lock(&die_kset->list_lock);
> +	}
> +	spin_unlock(&die_kset->list_lock);
> +
> +	kobject_put(&ip_top->die_kset.kobj);
> +	kobject_put(&ip_top->kobj);
> +	/* ip_top itself will be freed by kobject_put via ip_disc_release */
> +}
> +
>   /* ================================================== */
>   
>   static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
> @@ -1403,6 +1606,9 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   	r = amdgpu_discovery_init(adev);
>   	if (r)
>   		return r;
> +
> +	amdgpu_discovery_sysfs_early_init(adev, adev->pdev);
> +
>   	discovery_bin = adev->discovery.bin;
>   	wafl_ver = 0;
>   	adev->gfx.xcc_mask = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 4ce04486cc319..05a19cfe83988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -47,4 +47,9 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>   				  struct amdgpu_gmc_memrange **ranges,
>   				  int *range_cnt, bool refresh);
>   
> +/* Early sysfs functions for persistent ip_discovery export */
> +int amdgpu_discovery_sysfs_early_init(struct amdgpu_device *adev,
> +				       struct pci_dev *pdev);
> +void amdgpu_discovery_sysfs_early_fini(struct pci_dev *pdev);
> +
>   #endif /* __AMDGPU_DISCOVERY__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 95d26f086d545..acfebb33b0e6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2562,6 +2562,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   
>   	amdgpu_driver_unload_kms(dev);
>   
> +	amdgpu_discovery_sysfs_early_fini(pdev);
> +
>   	/*
>   	 * Flush any in flight DMA operations from device.
>   	 * Clear the Bus Master Enable bit and then wait on the PCIe Device

