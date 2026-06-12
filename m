Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE79CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 11:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A15E10EA12;
	Fri, 12 Jun 2026 11:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSIr5Waa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD5D10EA12
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 11:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmcMfxR93ldlhMLU3rOriFiy2cimOUP9bzDLl9MnAdPKUspqev/D15FfyStVjxrm4LHonq8HZrQiGShiFrwWLWP5z7YpPog+MNnIxK/PRZKg03X8Z7mdle6GtTqwFH0AjhUOY4OYx/UQ/AR9KvFmrm8nGmzwDX6tpkq6DeMtB0U5c4bhR1uhOkxx3o0iiIy3GfDcj02eHjHDs1j6zbICs9LORadJkfpsQsoj8yT6ArAyl94Rm0BSXiC0OCQpkML2n6svwAmwujpPa6QmiAlzsv0GPvoMsSWzL7V2uQLZV14Wn9dnEKtqAz5evRTAPyVTCJM8ZENIEAJRkfm8GDoNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpgzVmpyizD645V1i7QhIsbLjaC7w3NFqMU36fO947U=;
 b=s2lfn4Hwex8jdJxUu35NZ9w7ZQk1BrVBNq+wpwXa+ZY/spj+dXD+LDxDAdWGnOnzi/IGhxX26vWCSV2EMSoWzgEw08AShL7Mn0KHwm1v9CI+s9wXyNEheJOzTKchHA9zMN2IBEpVpGwrqjOswe72r0jAISBAHh2TLCH4h8fyheh5q3jg6Yew2BMnqO1gbccWK3JMhLMzU7ZKu6vgad+d8JYW/xrd7ur1ZWy7yn47yS/OdEzYk/xDtb+hdx/YL7hPiz3M9b9QUMj6zonpmOxrRYLc+zz+OIy+1hY1OoHrJ4RITHcTvdvPxvwXxRLyWbUadRHhDhVAGvV25RSVY8jqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpgzVmpyizD645V1i7QhIsbLjaC7w3NFqMU36fO947U=;
 b=xSIr5WaarfPv3HNMhUI/Ji7686tJJUL1Kr8o5F1lDdTcU0Vh/dS078O85Y8ILAbVVkcq+Ec+rfrLUaKoJv0kmgpqoRgLjLMNYzbGwhCiLWRhTCyg5n9DOvIxkMA8TJLTxS0F6bjwhB8pEvYsWcHHMP7E6KyMNuuwXJFBghlUAeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 11:49:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 12 Jun 2026
 11:49:26 +0000
Message-ID: <9001cbcf-299a-4f2f-b634-046d40d0df79@amd.com>
Date: Fri, 12 Jun 2026 13:49:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add parameter to allow skip specified PCI
 devices
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com
References: <20260612100321.452007-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612100321.452007-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1a309d-1848-428d-84a8-08dec878a720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: r7FPrBKFrgLqFbxiFT3tMpHHDME7QO42HncV7JQYeAj4hLKjD4jOOXL7Y5lHxPMhTZ9EjPgy508gMJmk4/slydFc8uQHJjzWo97ZFlGxJG2R0/prUXlkjqKmWSSdXRw3SZMXzm0z0P+Jb5C/SD0LqLMFZH9fdcpAWcymYG1nz2uP96RB7jApYBUq+p7GrNzYAtbXZDIkVy4/D3n3knCz9fKV37TwGGrL9aJrY4YT4sZazDrfobbOx1iHE9mbCVtiSVwjcjrZlh49Q0MD09EbAfi8dOcioiLW6mOWL7po3yuR4uvg1hU9UM8VBFZC4aREeMgqKhFNF4818znW8UO/3wmZtxIrBowVha4aztX8LAvACioeNd48NHjy+WAyQ0FRrZny4tVgv1uwTcXbFUTHVJ/l3bwneFnmnyhnmEyLOxJALLuFkdIpufLHyKPquxRt/X2J72MrA3q0/Mq59Bs/RsxhJunkm/rMZQ9UfQpb8LF/M6eSS7sKSu3prFTyvrbpFJxBaut4yehvDCINq22d64klxLrVwz/Xp+rHRcBGXlKgQf8cqu+dKHxGKRUgman7sHrZKDXMuiYutrtXYmgg1DdMCUvO+it82OaDYQngk6uuHmEhwWkE/OqpxzlRVPeuMYep4CtFqs5XWyw6xNTVxBiLmC4dwoIbJME5ChAjOfiFMryD4z/cmeHnVrejCdV8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJSdFRpS3FnVjAwcXVTTDBkckw3Q0RNdWR6VEs1VGhWeGEvR2hTbXQ1a2tu?=
 =?utf-8?B?MWV1OU9UaUZVM3NFcFB6SnZSN014VjRrSlQ4M1NwK3dESUdkSTdwalVzRTZy?=
 =?utf-8?B?UkpvZm1hOTNqWGZUUTROc2o0QjJ0MjlQL2p2TEFldDVSQ3hXclN2ZkVNc2xY?=
 =?utf-8?B?RmJKR1QyQzUzcGdRTmpOZTZIUnJrWThYWjZTakdUR0Y3V0FrQndjWkloeFVT?=
 =?utf-8?B?TGFQbWhwTWN5blBEYXFPMU5LNkN2Zm5venFVMVpsT3FZcTVpeXdkZ0hrRFRB?=
 =?utf-8?B?S0pkZnJiR3c4TWs4SjFzZ00zOWtodVQzME9HWnVhUkNVc0EreTRuTVN2TzJy?=
 =?utf-8?B?R05YTGJQSjltS1M4NFNtVUsrUUQ0ZVlzR2ZURDNKTzkrZmxIck9YNUphMlRk?=
 =?utf-8?B?SlYzMG9qdlFEQ1M3WTQzWFdUZUVoa1Z5R2dLSnFqLzE3NnRwWTRtR2JaZkdY?=
 =?utf-8?B?STZPS0RnNm93STg2ZWF3dy96L0dYa3hwY3k2MHI2Wnlqa0lrOS83eVUxa3Bp?=
 =?utf-8?B?RlR1ZEhBaDJubG1mR3NYMTkyaDNCK283ckZsc2R5bG03ZU9jODlObWhjLzRP?=
 =?utf-8?B?eWRJNDFYNzUxZjkwaG15bEdQbHdERkYrcFVvMjExSlNlY3hDOEZtaVo4c0hG?=
 =?utf-8?B?Y09hTm52eXYvbUJGQTJZQkJrNzFCeUZmTTVSYkRPcTlCY0dHR2tHUmx1bW1Y?=
 =?utf-8?B?MG5ZcWRLeWQ1c05qTGswSlAxcVpjbG9rbkFDa0Q1c0NnVE95M05ZQTBEWFZv?=
 =?utf-8?B?eVFVREk5L01pWlZYRFZTbFp6K1Z3THd2UlZZUWtBekxnelFxRzRDbDFXUVV2?=
 =?utf-8?B?SVplUEc4NVlOS0JiZlJZZnlqaVIyRk5WeWNEWDVZSkpoeVd1UVpzUEwxM1hN?=
 =?utf-8?B?VGU1czJYanE3dUdlU1VBVXBOdFJmdjc2YUhjZXBtY1NGU2NVeEE5dHp1L05B?=
 =?utf-8?B?T2htQmJXcXNqQlVwQ3lkM2p1Z2t4aEdmbi9EMmtEeG5LLzR3MEpsMUZlZVVz?=
 =?utf-8?B?UkxuRmZWMzRNRWdrMkFQODFHeWd0cE1Zc21GLzNaRUhSNkxnRXd2eVRlNjdQ?=
 =?utf-8?B?VE1ER0FaSE83ZUlJQjREQzQzV0RDbjdEcE9sNDZ1WHlVSldmRlRMSndUR1BE?=
 =?utf-8?B?bE0vZ0laSTdJNTBPaWovNmtyZVk1QWVQek9XbkpoNDFZUTcyZ25FVzJBMklH?=
 =?utf-8?B?YWRyd0play8wYU5UbzJqbzh0c3VTS1N3WFZ6aU5NQ1dFQXhyQzVrNGJzek5u?=
 =?utf-8?B?bjY5YS9yTEJRN3JsVlFsaTd5Y0hnYmxmOWhQSGdQL0ltUnd2WDlEeDV0di9K?=
 =?utf-8?B?UzYrOTZ0V2FnZFp4a0NYajJUT09KcDJiWjBNYVJsVXFUdWpjWmtNV3o4VnBo?=
 =?utf-8?B?Ukw1WmRXeU1iTVE4dGVHYWpjZjVkY2w0K1RWS0JVYUM5QnViQ0Y4clZYVHk5?=
 =?utf-8?B?ZjBzUCt2bW80RTA0ejJFZTVwOWZ0ZEQ0TFA4TVRKRG9jendpUnpGUTRId2JI?=
 =?utf-8?B?VjE5OFlHWkQ1OERUbHprbWw0N1lFTTRFd280UDFLTHpoR1FUdDVhN0tpTzRs?=
 =?utf-8?B?Lzd2bnlCZy9GNmZiVFQ2Q1RSZDVYRTZGNDNCOGhEVU5kaFZQbjQ2QVVGNDlh?=
 =?utf-8?B?bWM0ejg5R3gvRUhxaUpXMlVDZHVjK29ycVNKcFY4OWVBU3NDbGZEQXVjeXVs?=
 =?utf-8?B?KzVsZjh0UGVSSUthYXhGZ09JWW1GZEdIOHd5UGEyRXZiRFlBRWl2TXhIZ1Fm?=
 =?utf-8?B?U2Y3Szl3WXZwY011Yys4SlpmcGxIVnJZZmovV2JjUTUxSVc2ZXN3d0c1b0ZW?=
 =?utf-8?B?UTU4dTdES1poZW9Ra0V3VXVuK2w4SmcvKzIyaXk2NlFxWk0vbU9LbVhPYnkr?=
 =?utf-8?B?b1JWbFRMUnFiT3k5OXE0enNiRWo1Tnc0UWZ1VElBcmJSNlpsSUZpdjZNd3lP?=
 =?utf-8?B?WE9PaTArYzk2enpPdEVJNVVjVUoxWTVQU3YybldsOTJPUUEwSHoyZ1lVMi9h?=
 =?utf-8?B?ZGhGR0JTWDJGRlNCZzVhMWYxWUFFSmMvKzFwK1cxcC9qVXJSZE9YVU9RLzRm?=
 =?utf-8?B?dWNpdDJKY1JSQk5LMm02RlQvZUVkVjh2dVdCZXV4eHpFTlU3bjJsdGpkR0pL?=
 =?utf-8?B?dFlWZ0E3ZmtIVmMybk5WZ3FVRW9UemF3OHFlMzJPdHAxREZYSUROR2RhSzhT?=
 =?utf-8?B?Y21OUllDeWF0MG41ZjgrektpeHp6dFlFQXpmR2hmRjFtSVIxMXQvYnRjbUtQ?=
 =?utf-8?B?SkhYMzVJYmRSV1hDZjJ5cFh3NUQwSEl4b1Z1TkN5M2U5ekRML3VCKzVmaStx?=
 =?utf-8?Q?CJhIrlpupt6wpBC1q5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1a309d-1848-428d-84a8-08dec878a720
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:49:26.0060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAcdckEs4bVg1M2atfH0wzoAYOjNGIYYKjNg5WvNqz5Qp7WrBJHtZdb98DUE669q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

On 6/12/26 12:03, Yang Wang wrote:
> Add the disable_pci_ids module parameter to let amdgpu skip selected
> PCI devices before normal device initialization starts.
> 
> This is useful on multi-GPU systems where only a subset of devices should
> be claimed by amdgpu, and for bring-up or debug cases where early probe of
> specific devices needs to be avoided.
> 
> The parameter accepts a comma-separated list of hex PCI IDs. The device
> ID is required, while the vendor ID and revision ID are optional:
> 
>   device ID
>   vendor ID:device ID
>   vendor ID:device ID:revision ID
> 
> For example:
>   # cat /proc/cmdline
>   amdgpu.disable_pci_ids=73bf,1002:7550:c0
> 
> Kernel log:
> [ 3327.298156] amdgpu 0000:63:00.0: skipping PCI device [1002:7550] (rev c0) by module parameter

You are re-implementing the functionality of vfio-pci.

Just use vfio-pci.ids=vendor_ID:device_ID for that.

Not sure if vfio-pci supports filtering by revision ID, but that should be easy to add if it doesn't.

Regards,
Christian.

> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 175 ++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 503bb64c1e55..48aded458987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -35,9 +35,11 @@
>  #include <linux/cc_platform.h>
>  #include <linux/console.h>
>  #include <linux/dynamic_debug.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/string.h>
>  #include <linux/suspend.h>
>  #include <linux/vga_switcheroo.h>
>  
> @@ -183,6 +185,7 @@ uint amdgpu_pg_mask = 0xffffffff;
>  uint amdgpu_sdma_phase_quantum = 32;
>  char *amdgpu_disable_cu;
>  char *amdgpu_virtual_display;
> +char amdgpu_disable_pci_ids[256];
>  int amdgpu_enforce_isolation = -1;
>  int amdgpu_modeset = -1;
>  
> @@ -564,6 +567,28 @@ MODULE_PARM_DESC(virtual_display,
>  		 "Enable virtual display feature (the virtual_display will be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
>  module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
>  
> +/**
> + * DOC: disable_pci_ids (string)
> + * Comma separated list of PCI IDs to skip during probe.
> + *
> + * This can be useful on multi-GPU systems where only a subset of devices
> + * should be claimed by amdgpu, or for bring-up and debug cases where early
> + * probe of specific devices needs to be avoided.
> + *
> + * The device ID is required. Vendor ID and revision ID are optional. Hex IDs
> + * with or without a 0x prefix are accepted. Valid formats are:
> + *
> + * - device ID
> + * - vendor ID:device ID
> + * - vendor ID:device ID:revision ID
> + *
> + * For example: disable_pci_ids=73bf,1002:73df:01.
> + */
> +MODULE_PARM_DESC(disable_pci_ids,
> +		 "Skip probing devices matching PCI ID patterns: device ID, vendor ID:device ID, or vendor ID:device ID:revision ID");
> +module_param_string(disable_pci_ids, amdgpu_disable_pci_ids,
> +		    sizeof(amdgpu_disable_pci_ids), 0444);
> +
>  /**
>   * DOC: lbpw (int)
>   * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable). The default is -1 (auto, enabled).
> @@ -2216,6 +2241,149 @@ static const struct amdgpu_asic_type_quirk asic_type_quirks[] = {
>  
>  static const struct drm_driver amdgpu_kms_driver;
>  
> +struct amdgpu_disabled_pci_id {
> +	u16 vendor;
> +	u16 device;
> +	u8 revision;
> +	bool has_vendor;
> +	bool has_revision;
> +};
> +
> +static int amdgpu_parse_disabled_pci_id_field(const char *str, u16 *id)
> +{
> +	if (!strncasecmp(str, "0x", 2))
> +		str += 2;
> +
> +	return kstrtou16(str, 16, id);
> +}
> +
> +static int amdgpu_parse_disabled_pci_revision(const char *str, u8 *revision)
> +{
> +	if (!strncasecmp(str, "0x", 2))
> +		str += 2;
> +
> +	return kstrtou8(str, 16, revision);
> +}
> +
> +static int amdgpu_parse_disabled_pci_id(const char *str,
> +					struct amdgpu_disabled_pci_id *id)
> +{
> +	char pci_id[32], *fields[3], *tmp;
> +	int count = 0;
> +
> +	strscpy(pci_id, str, sizeof(pci_id));
> +	tmp = pci_id;
> +
> +	while (tmp && count < ARRAY_SIZE(fields))
> +		fields[count++] = strsep(&tmp, ":");
> +
> +	if (tmp || !count)
> +		return -EINVAL;
> +
> +	id->has_vendor = false;
> +	id->has_revision = false;
> +
> +	switch (count) {
> +	case 1:
> +		if (!fields[0][0])
> +			return -EINVAL;
> +
> +		return amdgpu_parse_disabled_pci_id_field(fields[0],
> +							  &id->device);
> +	case 2:
> +		if (!fields[0][0] || !fields[1][0])
> +			return -EINVAL;
> +
> +		if (amdgpu_parse_disabled_pci_id_field(fields[0],
> +						       &id->vendor))
> +			return -EINVAL;
> +
> +		if (amdgpu_parse_disabled_pci_id_field(fields[1],
> +						       &id->device))
> +			return -EINVAL;
> +
> +		id->has_vendor = true;
> +		return 0;
> +	case 3:
> +		if (!fields[0][0] || !fields[1][0] || !fields[2][0])
> +			return -EINVAL;
> +
> +		if (amdgpu_parse_disabled_pci_id_field(fields[0],
> +						       &id->vendor))
> +			return -EINVAL;
> +
> +		if (amdgpu_parse_disabled_pci_id_field(fields[1],
> +						       &id->device))
> +			return -EINVAL;
> +
> +		if (amdgpu_parse_disabled_pci_revision(fields[2],
> +						       &id->revision))
> +			return -EINVAL;
> +
> +		id->has_vendor = true;
> +		id->has_revision = true;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool amdgpu_disabled_pci_id_match(struct pci_dev *pdev,
> +					 const struct amdgpu_disabled_pci_id *id)
> +{
> +	if (id->device != pdev->device)
> +		return false;
> +
> +	if (id->has_vendor && id->vendor != pdev->vendor)
> +		return false;
> +
> +	if (id->has_revision && id->revision != pdev->revision)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool amdgpu_device_id_disabled(struct pci_dev *pdev)
> +{
> +	const char *ids = amdgpu_disable_pci_ids;
> +	char id[32];
> +	struct amdgpu_disabled_pci_id pci_id;
> +	size_t len;
> +
> +	while (*ids) {
> +		ids += strspn(ids, ",; \t\n");
> +		if (!*ids)
> +			break;
> +
> +		len = strcspn(ids, ",; \t\n");
> +
> +		if (len >= sizeof(id)) {
> +			dev_warn(&pdev->dev,
> +				 "invalid disabled PCI id '%.*s'\n",
> +				 (int)len, ids);
> +			ids += len;
> +			continue;
> +		}
> +
> +		memcpy(id, ids, len);
> +		id[len] = '\0';
> +
> +		if (amdgpu_parse_disabled_pci_id(id, &pci_id)) {
> +			dev_warn(&pdev->dev,
> +				 "invalid disabled PCI id '%s'\n", id);
> +			ids += len;
> +			continue;
> +		}
> +
> +		if (amdgpu_disabled_pci_id_match(pdev, &pci_id))
> +			return true;
> +
> +		ids += len;
> +	}
> +
> +	return false;
> +}
> +
>  static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
>  {
>  	struct pci_dev *p = NULL;
> @@ -2389,6 +2557,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  			return -EINVAL;
>  	}
>  
> +	if (amdgpu_device_id_disabled(pdev)) {
> +		dev_info(&pdev->dev,
> +			 "skipping PCI device [%04x:%04x] (rev %02x) by module parameter\n",
> +			  pdev->vendor, pdev->device, pdev->revision);
> +		return -ENODEV;
> +	}
> +
>  	/* skip devices which are owned by radeon */
>  	for (i = 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
>  		if (amdgpu_unsupported_pciidlist[i] == pdev->device)

