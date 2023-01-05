Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F8C3DA7D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 13:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D370710E734;
	Thu,  5 Jan 2023 13:58:08 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C917A10E734
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 13:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6xqMeNMoX4iGcZAuB+D5Jwee/ZbSP3NYv4KXYjaWcAQv/TxW/r9rW65+pF/N2FzPb2oQ4uhpwywY/iXWw0ioVt/HIH6F4kjto0LgWNvZ1X1l7DlTmTf1jLrizV4dq6nzP2Jum9u97/pIHgzPNpt358SQe2RfwJkq5roAdFsqznSvY1M8WHBE3tvIWDBuEyLz5IyViWsmBD563HJRv6PhLV3QotFg98ydiJGvNB07V9bw8ASu1CtX7iSaFucZcp6aHIbEoYvu4jhSDVuvJuTg3LVKGO6NWpCAmp0OBgh7bEktl9uzsP4rQibURr3+PIgjxBqU6jGg3Intyl0Y1hwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxPCIrhCj35x0UpWfXuZu4s2tjZx7vlx42kO/+ddvk4=;
 b=ocSTXzFZ3Q+p4sLmjwStsBt5A/h4L/8arSm7FkhHkkhShS1Ziee21w5Mh4MUOX3w/drz4Irqh79Iqv5vQ22kIu+VYFxfsDK4XCGxA3JnSHsRS6kVskMA09qqv3L3qmYB/XkjweVMVDItdMN31RET/x2q0u6CvbWLS8TLM9XICKpgDCaId3Y1RXFrbzzh9xj1im7mhgcie+tFzd6dG9hm4xUDQI0A9bJuyD0QEB3bKkLRjIHHFDew9/WqpOYedo0F14DH3Q/+4dp33Ka4Na3zVdWPexRdFftx+tv3jjkEMWLkY7xfYpYHZO3x4lhEpPGF62wgT7ThGZbMo5yGbkVHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxPCIrhCj35x0UpWfXuZu4s2tjZx7vlx42kO/+ddvk4=;
 b=ubt78bvPYKfSpTodf2CFdBKDF1eO1p8eYn1tl2/TL6kDU0AEmIcjlJSqAgLs+gKo35JOdoymfgV9Lk6thLxGoSozkTCRoo/RDIqUYemix3fIxmBG0+IocVXBA6yiz2ruhIa/9ANsmsm5FM899O9j/zVvqtVoHEkuJgqyXeXG37g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 13:58:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 13:58:04 +0000
Message-ID: <e505ace7-4606-e048-9ded-ce7f6ffa023e@amd.com>
Date: Thu, 5 Jan 2023 19:27:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
 support
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230105032259.2032789-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ba4ba1-30ed-4ce6-6acf-08daef24dd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2u6gGtMfZ4lHhn0eFmpCsrN9WcJ07urr4c08vdl+n1DoTVfCtHinR4+ism9roRbLkXW074fyXw9hPNm2HaYmO77gEfw04dNV2X4QXAtTrnbYCRB6u1BaggZWVsh+peienTiGlvN4BAOTs33n+hjLYO8gjG+OWLvrGG+VMKkEYmYgeUeRMJ8L0BfBg0VyjYRJ37dwOQzkUZ9K15bfnfH/ayjZmsOVml04e70qCjD9ZK9/JO5zTzkBzbslJpeApVONoj77tYNsuaDYNR5FPZ4LcarrKp0SaIsOL2t9WxuUKkY9sGGErZZL3htHzP+dMhfdHTvN/v4PnD9ofY90rOrfIZdLUUR7YKE+NrVllp/UAj5Tra/0XhtfpbD+f3kMtJm1AM5ZDUr9jZNb4i+gyKZKO6LmrRkrKVtcqfxXEEbVWqDRxYmCJrNBG2FAVWpTRCZ0H2DIm1E5gmFJHGhRoxwKwy937co/4o4jcU6LRuBGACPuIzZu1rdacY8r5+U9FIX63ttpjrAgS/DuohfdwvRUcHyWvw6motfeUllnKVg+U9rnK8p2uVLZdTBNnLRWzSKM/Qysn8B+avia8q0gfpfpH/LhmWX9/H55xCvlSYEsZxou+xHqMvhCHjyaId8Ir1rSbeN5j5FJAhP/ozbss9gl1g/x+McqHaJgYZu4lgiZgPRoyY5jPKHwSZTm0ZqarC8DP7TvL0HNXyP4wxsVUcVVUjGKmK8aEkV9LgEzo9z6AuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(6666004)(26005)(6512007)(186003)(6486002)(8936002)(83380400001)(478600001)(53546011)(6506007)(31686004)(66556008)(316002)(66946007)(36756003)(8676002)(2616005)(4326008)(66476007)(41300700001)(38100700002)(5660300002)(2906002)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGR5T3pPb2ZDdWZJTWcrZnRMcHBqUU5YMFNOV1hqcnZWQ2VpbmFaajc0TUx2?=
 =?utf-8?B?Vno1anZrWC9DQzZmbWsrY25nbVprV0tQYU9Jb2ErZmd4YzBCcnJXWWVuVnNp?=
 =?utf-8?B?SUJXNUFybkl6bkJLNjlmN2NGanJyNEMxRVBYdHFRQjBQYTZCWXVUN2d6VjlJ?=
 =?utf-8?B?cmZMd3M3OEx2OTI5akIvdVRrN3l6Mnc5TEczREg4YWtPcTlSaW9JWXlITVdn?=
 =?utf-8?B?M0JFMmNKTlpNQ1gyblpxZ3R2c2RuQXNPK3NrbndjMkxtSEsyb05MaFcwZW9C?=
 =?utf-8?B?bGlCek9rTnJ5MUJleEx1S3ErQThWcVk1S2FzSUlLczlzcGszK1hmVUZQNG81?=
 =?utf-8?B?WUludENPNloreEs1elBCTmRxdlVQeXFmQjNpN3VYTlpyODRVazJqcE4rVXdZ?=
 =?utf-8?B?bFV1RGtrRWtLbFV2MmZ0YlZCOCtieklDLzRUblIwNG9lbDZPUGNOYzBHMURp?=
 =?utf-8?B?Z2ozZDRoNnpHbnd2eUtlZHIvTVBRWjFDRFVYaUw4TTd3K3RBOGdpWGRpdjUz?=
 =?utf-8?B?Ukl6UHhvUU5Ja0IrM1RNbm1jcXd3QkxpaDU5VXBmOU9Eb2Q4c2k3S2dNL1I3?=
 =?utf-8?B?TDV4MGVGRTlwb1NMcGRXVHJ2cGw1eUVscjU4dlhnOWNOdXNhV0tIWmhVSDI1?=
 =?utf-8?B?QStkeWN6Vk9mNElpcTVwRUs1cWxpRHp1YjZrc2VSK1FxT0tEenVTYUNDbTM2?=
 =?utf-8?B?bXhQRTFGWU5JcmpDbjMzWW5KVjVuQUh5SnN1N2ZFblliOHpmMVhZVi91WmFj?=
 =?utf-8?B?UDVGNTJJdzFqQUE2bnpGci9wWENFSlZIeEZLa3NrVzBTdjlCL0VseUNVM2o5?=
 =?utf-8?B?YytLc2J1Y1pQSXJKMFpacTcwMUxTdWVkUS92elg2WGduQmtvY2pIL3V2ZEJr?=
 =?utf-8?B?anVlaVJTMmdIMjROQmtKTS95ZmZRNHdHMk1Lb0RDR2FZdEFIajZZYWlRTkdr?=
 =?utf-8?B?dzlocEtkTzhObU0vVCtXUXdMcks4cDQ2eW1qRFVqSkc0eUNuYkcvL3NNTVFW?=
 =?utf-8?B?bXhWcjAwMDNyT05PZlpoMWwyRDlpTTdNVTM0UE1CRE9UWmZGWEEwOWxOT0h4?=
 =?utf-8?B?YityODJNUFJETUx2elM0VkVVNTZUZG9IWHkraGN2S1o0ajNlQ2l5cG1XN1dx?=
 =?utf-8?B?ZVBtQ09xcEJkL0liQklyaVBVNlo2aWxsbHRIaDd6S0RHUExxSm9MV1BKU1ZL?=
 =?utf-8?B?K0drT2wyb1NlckdnMGFEcVJ2RFRTY2srUUtzMllac2RvcnA1Uk1lYk94OGIy?=
 =?utf-8?B?b2s1ZHEvajhFbTYrNTJTZlg5aEE0ODAxZ0J2V2VkbUlkWEQzaXNrU09xTVlu?=
 =?utf-8?B?SFBTU2dtTkNHZDRyTlRjMlVGcGlLVDRkSThOTVJTWlNhdDdKL1F1TzNGamxm?=
 =?utf-8?B?aVdyejNLZmlpSW5rZkpDZVZWdnp4a0JLQnNxcm1wbFhia1Z1RXRmSVpGaHB4?=
 =?utf-8?B?NEJFSkY1R2l4L21SZzlzQ0VmTVphb0MxU0UvY2hyTUlpV2ZGNk9hc0V2UWtl?=
 =?utf-8?B?UTgycEU2Vjl3V3Bpa2h6U3FEeFE1S3lTK1B5eEZUcmwwU2Z1YVFmYUVuUVlL?=
 =?utf-8?B?OHFNcDBNTmFONXRzSGRwbjVUMSszSkNIK2NqSUVXK3NoNER1QlRDVEdrc1lS?=
 =?utf-8?B?TEhsMHZ4UC9HSnJLdklpb0cyay9jY3ltWUl6a3RCcDE2c3hCakhodFE5THFS?=
 =?utf-8?B?N21yd0lUTlJ2REdkVllyYUhoZVZuZ3ZuUjhWNXFiOUlEZXlQNkhNZ2RKZ25o?=
 =?utf-8?B?Q0ZmMk9ycFkxWkNGTVcvTTdUYlNCaGdVeGVjY29LSzhhTzZZS1ZXM0ZxbzM3?=
 =?utf-8?B?Z3FmS1lQU0lacEJaM1BZcHg5MDBlTlRBY1JzekJNWmJKeGg1eVhLZ01mb05m?=
 =?utf-8?B?OUtxM2FPdzBKeVQ3NTBuY2VoNmdVZFZYRnprbkZ5OGY5dWJJYnQxVjJ1Y1pV?=
 =?utf-8?B?U1ZQTTYwYitOWWNsSTVDVkNrOW5kaHlHR3Jla0xOTTZ5akQ3VnB0U0xHNHox?=
 =?utf-8?B?Z3p2OFgrTzdkUU5keTNoU1R6N2Fxa0tYOWplbHBKZERKV1NmRXdqbHJMWFFC?=
 =?utf-8?B?Smk0NFNycFMzcTh5bDBTQzVUQXlqTCtVZmRFMENLSHltbitjRFcvMnlkYm1y?=
 =?utf-8?Q?s0XIRU9k4ynW+acuXE0YuK/mx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ba4ba1-30ed-4ce6-6acf-08daef24dd83
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 13:58:04.4647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QtAYIRwoMcx2/0yYsXuBORbBaLnICNWg8vmR8uh6TTeOVNvzIHHY8umYOfVm6nt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/5/2023 8:52 AM, Evan Quan wrote:
> Make the code more clean and readable with no real logics
> change.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200 ++++++++++++++---------------
>   1 file changed, 98 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index fb6a7d45693a..c69db29eea24 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			       uint32_t mask, enum amdgpu_device_attr_states *states)
>   {
>   	struct device_attribute *dev_attr = &attr->dev_attr;
> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> -	const char *attr_name = dev_attr->attr.name;
>   
>   	if (!(attr->flags & mask) ||
>   	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) & adev->pm.sysfs_if_supported))  {
> @@ -2016,112 +2013,14 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		return 0;
>   	}
>   
> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
> -
> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
> -		if (gc_ver < IP_VERSION(9, 0, 0))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
> -		    gc_ver == IP_VERSION(9, 4, 1) ||
> -		    gc_ver == IP_VERSION(9, 4, 2))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
> -		if (mp1_ver < IP_VERSION(10, 0, 0))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
> -		*states = ATTR_STATE_UNSUPPORTED;
> -		if (amdgpu_dpm_is_overdrive_supported(adev))
> -			*states = ATTR_STATE_SUPPORTED;
> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
> -		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
> -		/* PCIe Perf counters won't work on APU nodes */
> -		if (adev->flags & AMD_IS_APU)
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(unique_id)) {
> -		switch (gc_ver) {
> -		case IP_VERSION(9, 0, 1):
> -		case IP_VERSION(9, 4, 0):
> -		case IP_VERSION(9, 4, 1):
> -		case IP_VERSION(9, 4, 2):
> -		case IP_VERSION(10, 3, 0):
> -		case IP_VERSION(11, 0, 0):
> -			*states = ATTR_STATE_SUPPORTED;
> -			break;
> -		default:
> -			*states = ATTR_STATE_UNSUPPORTED;
> -		}
> -	} else if (DEVICE_ATTR_IS(pp_features)) {
> -		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0, 0))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
> -		if (gc_ver < IP_VERSION(9, 1, 0))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> -		      gc_ver == IP_VERSION(10, 3, 0) ||
> -		      gc_ver == IP_VERSION(10, 1, 2) ||
> -		      gc_ver == IP_VERSION(11, 0, 0) ||
> -		      gc_ver == IP_VERSION(11, 0, 2)))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> -		      gc_ver == IP_VERSION(10, 3, 0) ||
> -		      gc_ver == IP_VERSION(10, 1, 2) ||
> -		      gc_ver == IP_VERSION(11, 0, 0) ||
> -		      gc_ver == IP_VERSION(11, 0, 2)))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> -		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> -			*states = ATTR_STATE_UNSUPPORTED;
> -		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
> -			*states = ATTR_STATE_UNSUPPORTED;
> -	}
> -
> -	switch (gc_ver) {
> -	case IP_VERSION(9, 4, 1):
> -	case IP_VERSION(9, 4, 2):
> -		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
> -			dev_attr->attr.mode &= ~S_IWUGO;
> -			dev_attr->store = NULL;
> -		}
> -		break;
> -	case IP_VERSION(10, 3, 0):
> -		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
> -		    amdgpu_sriov_vf(adev)) {
> -			dev_attr->attr.mode &= ~0222;
> -			dev_attr->store = NULL;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> -		/* SMU MP1 does not support dcefclk level setting */
> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
> -			dev_attr->attr.mode &= ~S_IWUGO;
> -			dev_attr->store = NULL;
> -		}
> -	}
> -
> -	/* setting should not be allowed from VF if not in one VF mode */
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO)) {
>   		dev_attr->attr.mode &= ~S_IWUGO;
>   		dev_attr->store = NULL;
>   	}
>   
> -#undef DEVICE_ATTR_IS
> -
>   	return 0;
>   }
>   
> -
>   static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>   				     struct amdgpu_device_attr *attr,
>   				     uint32_t mask, struct list_head *attr_list)
> @@ -3411,6 +3310,101 @@ static const struct attribute_group *hwmon_groups[] = {
>   	NULL
>   };
>   
> +static void amdgpu_sysfs_if_support_check(struct amdgpu_device *adev)
> +{
> +	uint64_t *sysfs_if_supported = &adev->pm.sysfs_if_supported;
> +	umode_t *sysfs_if_attr_mode = adev->pm.sysfs_if_attr_mode;
> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> +	int i;
> +
> +	/* All but those specific ASICs support these */
> +	*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +	*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +				 BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
> +
> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
> +		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
> +
> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
> +			*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +		}
> +
> +		if (gc_ver < IP_VERSION(9, 0, 0))
> +			*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
> +						 BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
> +						 BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
> +	} else {
> +		switch (gc_ver) {
> +		case IP_VERSION(9, 4, 0):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +			break;
> +		case IP_VERSION(9, 4, 1):
> +		case IP_VERSION(9, 4, 2):
> +			*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +			/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
> +			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT] &= ~S_IWUGO;
> +			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT] &= ~S_IWUGO;
> +			sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &= ~S_IWUGO;
> +			break;
> +		case IP_VERSION(10, 1, 2):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
> +			break;
> +		case IP_VERSION(10, 3, 0):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
> +			if (amdgpu_sriov_vf(adev)) {
> +				*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
> +				sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFORMANCE_LEVEL_BIT] &= ~S_IWUGO;
> +			}
> +			break;
> +		case IP_VERSION(10, 3, 1):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
> +			break;
> +		case IP_VERSION(11, 0, 0):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
> +			break;
> +		case IP_VERSION(11, 0, 2):
> +			*sysfs_if_supported |= BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
> +					       BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (mp1_ver < IP_VERSION(10, 0, 0))
> +		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
> +

With this change, the IP version based checks need to be moved to 
respective smu_v* checks so that each IP version decides what is 
supported at which level (R/W) rather than consolidating it here. Only 
generic checks like amdgpu_sriov_is_pp_one_vf may be maintained here. 
That way it really helps.

Thanks,
Lijo

> +	if (adev->flags & AMD_IS_APU)
> +		*sysfs_if_supported &= ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
> +					 BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
> +					 BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
> +
> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
> +		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
> +
> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> +		*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
> +
> +	if (gc_ver >= IP_VERSION(10, 0, 0))
> +		sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT] &= ~S_IWUGO;
> +
> +	/* setting should not be allowed from VF if not in one VF mode */
> +	if (amdgpu_sriov_vf(adev) &&
> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
> +		for (i = 0; i < AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
> +	}
> +}
> +
>   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   {
>   	int ret;
> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   	if (adev->pm.dpm_enabled == 0)
>   		return 0;
>   
> +	amdgpu_sysfs_if_support_check(adev);
> +
>   	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>   								   DRIVER_NAME, adev,
>   								   hwmon_groups);
