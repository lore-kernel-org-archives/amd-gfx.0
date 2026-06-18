Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC528CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7554210EC27;
	Thu, 18 Jun 2026 05:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KN1tZFNa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8F910EC27
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brcy0sMfeeU3L7e6W25BC6pQASqQvKzDjVjLHauZvIf1yeFYH7Au/DXu9skGEGxjELId73CYjsrFFCRDZDvt/RCS9AFhlxNSZIhDxSdV2Bh/jeTXq5NXLB5dp000nnVeIBKylTyunOrorjdtDwfTmlxpA0VuKIWQh5v+qasxQYvT9/lNTtlFYe0P2AYbIw0Hb1oTjZnu02yK5hiaR61mCsGHE2p8rIuPQlkk6VUEh67rjngXhl6/z2WyX5mjOyIxSBWFsJQisUwp5HRZU0lbunfCRAIv5Xq3i2aTfJaNW1iC8LDq+b8rz0HFJeWVF0uAqU97igVUJLqXm3uparQdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJgbMc9+BOe7EpXDwmz2opDuKLlpBJasrqzB6J9SPtM=;
 b=oQk0IdN/Zz+MNYOeufeCBOhQFwmfIIiEfkcJ6Ed2e0BrDkWbGJlT3JIcm7tWYFZuzuHKQVsRajS0J+Ar2+onYDQBrfM5U0JVQF7jiCC/O1riZZAfualajumBbALmWIQR814Ecn4z865eZjLpctHU01sEJkGJWgcR/UiaRcpYq8tO9OELWkiR92ulsoD6CaW21Sa0a7uNQIc/4j7ZBVJK8fx8wsAHFw1yw2+zM33XPNVSIXd2d0MjreEER5y50YriQwBCQzoOh+HHOCtLpn1HvGhDazPCkLS8XYrc1WMKB7MkvhF+RiwafhVFZ8j7z2a3SVkgq4F7LOJwN4nMXfAKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJgbMc9+BOe7EpXDwmz2opDuKLlpBJasrqzB6J9SPtM=;
 b=KN1tZFNaDgEMmOck6taJ/aERrpSz/8rN6QHcFlXRXsgUQKIpN/m0CBnkZ2SXmYkejvkK9ppXHm9Pdc0UgL8PXDL0hnvjMEid4CHUtFnAWpqnoqIFi2kQvEd51G8OnXoKRJGCOxukfsk6XfLLJ/+FgJ9vJLVgrB+esGEgXTAnL28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 05:46:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:46:33 +0000
Message-ID: <b12f7f67-725e-4fb5-87a8-8d9b68d5b387@amd.com>
Date: Thu, 18 Jun 2026 11:16:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: guard zero divisors in soc_v1_0 partition
 code
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260618053809.3138747-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260618053809.3138747-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 3996a84e-08c1-4c6a-b6d4-08deccfcf453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tOX/CU450/gIkX3/tJH/Zm0irw/5bUjlbbKQKpsRtjQ5FOJwLYps50LNcA0RPzbxfmEE0tKGg54rFX4CGMnQtmNQqvErgIsz9cRCOGiwe+ACU0goIgO4pAkG1jAvTECz7Pvx6Odp/jYjHbZ6QcPXvTp/kc2SnVQu+yck+4voE19rY993XEtf/npAQbhVSo7pw5gCTW5MS2Rn1bPoiCKGhZ4iJcVx5FPVMrHEenE/8eh1/TAcplvO+WmE+WJwHiJsb1rJ50acMhGRbEdLr1iW7FeCI00vKOroh4J5gGVu1sp/I6nKSq2Yn5hnJzvP4p75ZIX+aZVViZfcCWNBO7uULFkBUMXIFJ1fTwvSMZdkJIPgNlOZ37a8dG/wAElWSMh5xVIR3AbII3weOS5H+TajeWwN8s70Xik5NaMvuW8UQtzOyJFG/Nv9gEHy4jCG6uCcd/qVO3HVtUmH0zAwFY0GJgOQMpWwhfEDMh2DRASOzar59Q6xuS0k/IKjdLJqbCRQiwviAHvYCRzG+9YsdxNoXEPRU3Qe3xjstANYPbedIac6tgl38ttmyj1hK6FiCzEhK9ut5ADRX0stguBYW7bLjzAjq+E5BavmmVYQPX43QTaMukGhdIoyeznFqX+W1DkUP9GCcicQ/ctfhq0GspeRlPgEhaGwrbrolIbLDGcKTgWhx9RbFazFXFMzI0SSXcqM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNXb1BvL3RYN0FxdDJQWjRSWEUyWktBdHhNa3pjaTliZE1Fd1hCcytORzEz?=
 =?utf-8?B?UWlHQjBmK1dnS3NLNnJEK0ZwekJYc0VueEpGdUZPbE5CVkNsZGlIckVSclhR?=
 =?utf-8?B?c1Z5UnZIMWZmQjJ0eitsaDQ2TTh4QUtvUm45R3F1Q1A1SlVzaHlLWmZtWVhi?=
 =?utf-8?B?WlVEa2N4RmRDRSs2K3VKNTMyVDVHUTV3UGxUSWdVTklRcWxDRzVBaFBWV2hu?=
 =?utf-8?B?VjNMN3k5aEdDQlJWaVdBbVo2cHk4eDJDOFd4TGdRRjJ3LzhiWkFLbXp5ekdS?=
 =?utf-8?B?SzVXTkVBOWM3cTgvU3UvUDduc3YzUkJ0bHF4UmVONy94bGNadEJITDA1bTA5?=
 =?utf-8?B?T0VlQTVXdVNCOURtUWo5TENoYjVyaVRudHA0MW5nNnlnUGhJRTdZV2thNk9G?=
 =?utf-8?B?dG5sUDk2bjdWdnpiVXlJcFVMdHVvWWNUc0JGTUNZallDK1ExNkFtdm9HM3Rt?=
 =?utf-8?B?UVJ6SngwS2tHajRYcm1CdEtBMjFobzhCWXFUSjdXeC9iYTZkZXhrQzUzQUtC?=
 =?utf-8?B?eGV6Z1VOMkZUTVYwYnFuRGh0bnBpM0JxWHk2b1VjUUdaS0Z4dzZpYi9lbm9r?=
 =?utf-8?B?QWl6cWhFMHZXNW1WdnJxeTcwOG9lcGVLZkkyYnpYZEhQalRKY1YwQW4xa1M2?=
 =?utf-8?B?NWFxV0RhMHlSZ0JqaDFMQWRGMWlBNGczb0szcUpWS2kzNTVIRkZzSVJMMFp2?=
 =?utf-8?B?UHM5YnFOTWxlWWtHZlgyQ1VOd3Nxc3FZR3R3cXpHdkMycitzcFVVbkQrVEFI?=
 =?utf-8?B?b2tsOC9RQlFFMjN6ZHAvWG8xRmYwN0J1RVhZK0lXdDF1cGhJb2VQV3N6UVNX?=
 =?utf-8?B?KzFaMGFWN1FQakg5anA2KzlWTmRlZHBPYXBhRmUxaEQ3WFkwNER1Nms0R2lQ?=
 =?utf-8?B?MnRidUlKbXFXdkdSR0pCUHhtTWtydEFCOVp5MlJHTjY5ekQydDBUNW02T1c4?=
 =?utf-8?B?T0RKTlZHazZ3ckRZR0dFd2dKNTZOWmZpMEJvcyt1aHAxaFNrazFUT2lpdnk4?=
 =?utf-8?B?ZEFWYXN6eWNFUmFiSThURmdFMUQrVjdtYXhVTnlOLzlsRmU2N2IvaW5GcjRx?=
 =?utf-8?B?NjVVSWVMempVWXhScVB3RTJDdUd1RkRhaGFpM3d3NW94QU5LQUV3UXFKY281?=
 =?utf-8?B?bTFkckRha2cwc05EakFZc3BqVVRWLzlxbXJwYVI5K0pZdGV6ZVhTbVlFeEZr?=
 =?utf-8?B?Ui94RVY3V21aNllETnZPTm1XM0c4UkxreHRwNkFBMUtsUis3NHFGNFRGTExt?=
 =?utf-8?B?WENRRVZuSURsVTJiMWlnVVQ1S0k1NzIvS0ZQdEFlZFNoRGx0UDljV2tWbW1h?=
 =?utf-8?B?N2tGcU5EUWI5dngvMHlRQXhQeXphbGgzejRWYzNmYWphTkluOENxS3MrbEVl?=
 =?utf-8?B?aTMwa09aSGw0NllSc1oyYWxXcmkwS2M5ZjhTV3gxRURoNWVYbkVLeHQ4bXY4?=
 =?utf-8?B?U3V0OWtJTEdOcC93N2gxditQVjFtRE90WHh1dlB4R2JNL3UrWWJYUGQ3dS9i?=
 =?utf-8?B?Z1ovQWVacmd6eXpRdndRcjVYbjBMMzUvZno1Uy91VWhuQ3ZjeTRyZmFTNVNv?=
 =?utf-8?B?UVppZXJkcndneXNySlRueFNscFBFMUlhSzdvZ2UzREsyR2RQOWluSFNCUkhU?=
 =?utf-8?B?cXdZa0ZYd3VzRXFxQ1hYdDFBRHB4WUlDMW1IWjZLTnRlNzZtVkRDbDUyUFVo?=
 =?utf-8?B?OEhsRzhDQWExSVJMUi9mMm9MSUVZYnFkalo1c2gyWjdvL3Nxd2lUZ2twZGsx?=
 =?utf-8?B?RVlWb3VXUEdtL01GM0RaNjlNV1RYUURtaEtxcTNvWGVzR2pUalh2SlB2a1FL?=
 =?utf-8?B?QUJoUVdPeEpkVmJ2S1JtZG80SHIzWm9oQWU5MXAwRGZybDc0RngvLytDMW8x?=
 =?utf-8?B?MHJYbXVZTXFiVHVUc09OTVVqUzlxanA0Uk9tOUJqWWhXWEYxS2FaUlhMbE9l?=
 =?utf-8?B?SUlaaDlWQ0FvOTFHVkk2ckQxTTQwQ3N4bC9hUWM2N2RNVjVQRFIzd1B4bm44?=
 =?utf-8?B?YzZiaSttNm15dXhyTTJVMGE2WUI5eUl6NmpEb2MrTUpWOVNhSDQ2ZFJ1Mmhm?=
 =?utf-8?B?VGwyVUZOT3g1YmYvemFtS3gwa3N3TXFpZTFneDNmRU5HcWZSTDZWYldtanZ3?=
 =?utf-8?B?eGluRDdoQy9Cd2pxU2FrTFBheWNYTjRSRUd6QWF0MkxTcnlyeUxtdzNuUjdv?=
 =?utf-8?B?WkhwdUp3VWZVRXh4NS9NeGlUK2d0K3U2dXpmZjZub2hrWGE5OXFmTjg0M2FH?=
 =?utf-8?B?Y2d1RzFROHRKbDY3OEZra243eWVjVTR5aUo4dXJZYll4QnhvYUVwWVluaDlX?=
 =?utf-8?B?allwOVVCeWtyc3NsNXhjSm9ONzFmaWhFZG9PYnlpalVyMDl0a1QxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3996a84e-08c1-4c6a-b6d4-08deccfcf453
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:46:33.7848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7q2ehUCcl5T4H7TO4PTpmDnjxGb05fudSxqWXDa1G7L8LVG300VDLmIslsuaE8t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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



On 18-Jun-26 11:08 AM, Asad Kamal wrote:
> Abort driver load when num_mem_partitions is zero since operation is
> unreliable without valid memory partition info. Skip absent resources
> in soc_v1_0_get_xcp_res_info() to avoid divide-by-zero on firmware-
> reported zero instance counts.
> 
> v2: Remove redundant checks (Lijo)
> v3: Return error instead when num_mem_partitions is zero (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   | 4 +++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 2b557c9096df..8bc347b75de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1762,10 +1762,15 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
>   		valid = true;
>   	else
>   		valid = amdgpu_gmc_validate_partition_info(adev);
> -	if (!valid) {
> -		/* TODO: handle invalid case */
> +	if (!valid)
>   		dev_warn(adev->dev,
>   			 "Mem ranges not matching with hardware config\n");
> +
> +	if (!adev->gmc.num_mem_partitions) {
> +		dev_err(adev->dev, "num_mem_partitions is zero\n");
> +		kfree(adev->gmc.mem_partitions);
> +		adev->gmc.mem_partitions = NULL;
> +		return -EINVAL;
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> index 5f05c8e68297..f3f3fac435d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> @@ -600,8 +600,10 @@ static int soc_v1_0_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
>   	xcp_cfg->num_res = ARRAY_SIZE(max_res);
>   
>   	for (i = 0; i < xcp_cfg->num_res; i++) {
> -		res_lt_xcp = max_res[i] < num_xcp;
>   		xcp_cfg->xcp_res[i].id = i;
> +		if (!max_res[i])
> +			continue;
> +		res_lt_xcp = max_res[i] < num_xcp;
>   		xcp_cfg->xcp_res[i].num_inst =
>   			res_lt_xcp ? 1 : max_res[i] / num_xcp;
>   		xcp_cfg->xcp_res[i].num_inst =

