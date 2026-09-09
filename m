Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DC2C79FB7
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 20:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5FD10E1B6;
	Wed,  9 Sep 2026 20:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BUzWbe8n";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3458810E1B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 20:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u41pUKH7O5rsLLeXiGzOtXDYqW19YCndy0+hgVGcS0HWLdrc9/Fmjz9Ssw9JyH4YdaomB6UIYCBLBxtCMazESBy7w6lZfHSGLu1Cv00zrd3Y/qSx87/Zmy8lS5Qos7FIqYCOmS0RZFPfV0b0vh1nAoTbSEnLMp7/qLHPY+nut1MLbk1kFxlblkVR+EDnt2AhZWXh6VveG40kBJueRF79JeURMMbPHmt6cvsaLKU9NtSUUIn4luhM6QYre5FHPucporHZbIZBAv2Z9x2R9Nheh7fLTZnMVXnwpgBtFuzSgyvEefJrhVyYpMC6nnp57ytMDi/d5k3aHUT1m5gUVdELtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/76J8g8ZVoIWXoxdBPwXCMpnL7YRquktMvWeujPJJCk=;
 b=sKB9gsz28BR1ROCfhf0z0zObuG7Hjq6bBc/vuciXOvPdO9cc5uy+zvRIZt/4zyMsRXkPuewVHKSWeHciUj0gQS4mxArf+G/fFXYFSE0TJdUgkCCHk7g9/6B2rypLvzSVjxjftXssIoEcbfc27tp+ihkG6/QWiUzae9sEW/ks3eCrvtE/xkUn4BE931YS7y7J9U2mpkihRGRe1FEHP+8B+twNsuEmqXtTtXXcebQ9QtUVHzOGcxbN+rI4O1Lno5ZsfC0YuZynHtwymb35y8DIuexzKYg65D77Ct/NBU/UDApjVEXvmnZquBCB2IbovIboxmPi/uvU8Z0f4oaOML15SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/76J8g8ZVoIWXoxdBPwXCMpnL7YRquktMvWeujPJJCk=;
 b=BUzWbe8nsx52l1lCqmEnTEbUUdrKzkIRvsmqtH752VN48WZRbcGTr+NnX/Yc47KG+uUIt6K8gP42aF3LM2inz348/d/Yw3zfiUw9qzcn4LofWHJCHAUJcNRG3IaLJUtYHpJTd21vTmeKJKwJgkEqwv3wxJVyaB53j0gqxPOiqKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 20:34:34 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 20:34:27 +0000
Message-ID: <1025b4b6-2d64-4391-8397-6500ce43830e@amd.com>
Date: Wed, 9 Sep 2026 16:34:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: amd-gfx@lists.freedesktop.org
References: <20260909201536.942624-1-Gang.Ba@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260909201536.942624-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: df6c1a15-96cd-44dc-0b08-08df0eb1bdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|10067099003|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: YOKTtxTyyhyRwRdLJsw9yQ21Pb+0lJJBYfShy4gb6kgUf7LQIaFbIw7TX0oXDcutpPkL9/1/8bWp3+HpTOlsRmVq4jVFLGh/s+Zu9mf9lo24ReO0mX65TH8LwbJEz7PU3PA3tpQ+M3FbcHQ4SXzxig07ap9SCBPMQyfyei2AlVw4NMD9FX4qEClsSzVfn1Mv1eNIXTpmz1/8iVX9AvhP9uolU3T5A9AHVrWMWIZLnljyXrAD6K657rw8JwpTF8lpRdhiEC5EJCYiffrMXgf/k7P7HpMVj+sLDCA15BWxhrziRKilgrvOUy94hd26iP3WrE63mKH1cmPwLuiLpWda53k5Ry1rhJBiSDcShuDYdE59hOcTJ/W0dxCmiIqsC/b2dg9IYP1rcD/nJBtFywPxrdZhpayzZmH3JJo+Q4yk6+qdoSua4r0H7y3DZWpTUr93Lzjrx32ZgVluCQmzsd8/9cX4zUjmy9J8axK2xD4SPkVXcLZd5mD0rEc6IfikmRY6srfl7gbN2CKMg+wKcJcnZsGBurWB1d6lRkjd6nbSE1P7zwaR/rr+RPN4uc3cAWxuC3EFcQMndXqQyz3Z6xVAhd2amd7/w9iuSOOy+EVaYMsL6Y5zsiRmV4PmAnOBqCvMAaAOQOQw2B3WKNJ7spv6cxZMRdf+ijyr8tA7zs+fy7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZvTHZ6bWZ6VUlUVXhZTWJxamhNU002RzBiRDF2WGtQNTVLNS9heThRbitX?=
 =?utf-8?B?eEtTUnNaWDdwaGJQZWVSVzlNSkhWSURXNWx4aDYwejYrbmsvWXQweUZkS09B?=
 =?utf-8?B?T0krdE05N0RBNElyVWxZMGlUS2Z3USt1VkdWY05FV3F6Tkg2ekFaaDJ4YlZD?=
 =?utf-8?B?VUY2TEhsMjBuNldUeUQvMGEyTEZrUDVYQmZMR2RYQzFxT3E5SlRzV3QvRkha?=
 =?utf-8?B?U3NtWmE1bXVKcVZSRTVaWWhQRkFLdXBqUDZ0NWl6VjB3cDhiNFVxbVc5ZVVx?=
 =?utf-8?B?amltOGZDSVJkMHlOdk80UzZ1dlBtVEhlSVVWMmwzaGV2T3ZzUXNWMkxUSnpF?=
 =?utf-8?B?UEpVWC9tNjY4VmM4aWhTMkZiSS9IRnd3dk1VdWYySTlEKzNJd0RTa0NCQ3Vy?=
 =?utf-8?B?MWowcHNZMWpNUGRNdmlNUGVvVzgzOStwK0VGbjI1VFFHSUw1OEZZNXlXL0l3?=
 =?utf-8?B?T3VUNGZ5WFFzOXdVcEZneitpb0lYL25GWnZjQ09URkVaK0N0N2l6V2ZKSjFC?=
 =?utf-8?B?dS9aMDFIc1REeVlNcFBZUlBjbzZ6KzRYQTRDV0I5cGxCdm5CODQ3UFVsODFs?=
 =?utf-8?B?Q2g4U1pSUWlYaTZrTE9BaUt3M0FZU0ZRYkdxWFNhK0JuUjdDM3BPaENncGZi?=
 =?utf-8?B?NUtFSm8rdFFweE5aSHV4N0dzbE5pQ3VwYVo4aDc0UU56aHVvdHozcDIyS3ZF?=
 =?utf-8?B?a1Uyb2xNU0MxVmlzOUhVZ2t5ZlpCVlVzWFpiT1BOT1NkZWVLMXlramRJbXlL?=
 =?utf-8?B?djJKcGJ4LzA4aFhQY1RzZTlyRTN1KytqY25MamY2aG1zTkpSMk91bWhTT3Ax?=
 =?utf-8?B?dVNPeTNpZHRUSzY4SDBTQlYybU96YTFVRjV3ekd0cmN0eG1QM3BoYUlmMU9V?=
 =?utf-8?B?UzhBb2FJcEJyNlhzeVdwRlBuaXNCRFdNS200MG1WREs1ZmZpVmpMbFFqbEda?=
 =?utf-8?B?d3oyYWpLRS9MWUY4Rlg3c2kzbzc4dlBmUEZIZXh4TXREblVGTDVIbThZOU9B?=
 =?utf-8?B?QlVqd1NVakx5TlNvK2lpOThDcGYzTWVkODZkZkphZTRuc0tzZm5MdUZtVTYy?=
 =?utf-8?B?MmxPb1lPNzFCYVFvYkdJUktkQStaYnlQelVGZ21JMUQ1NDlCdjEyM3NTS2hQ?=
 =?utf-8?B?OEhMT2I1VTFETWZFYmh6cGVPZnF4TEFQNU9Ua05sVE1saHhlaStEYjlra1Fr?=
 =?utf-8?B?Q0hHS2pjMW1ROVk2cFoxQ3hjZ29Ld3A5dzErYjQ5WFZiT2ppUUVvN2dMMDA0?=
 =?utf-8?B?Y256ZEpTM2lZWHk2Qjc3cHBSWXNRZll5V2pwS0xIRXpLamhYZFVwZ09uc0p5?=
 =?utf-8?B?NE85MnVGbk5hOHJoYkR1cGxpZVMyRWdRMnkxbkZVQmNnWDRXWkllQ2hGWUtC?=
 =?utf-8?B?Vmg0dDNNWnRDMU9hZGlGQ0gyU2ZzcWNjVEFqYkpZbUY4YndaMm9jVVZIK214?=
 =?utf-8?B?L1QvbmVaMEtJVC96dHcvV290ck80WGR1RytvTkJxRkxoVllKemFYbkNmVE5J?=
 =?utf-8?B?TDU1V0pMTndQYVNZUy9NR20ycnpOTTZobGlMUzNGeG83ZjliQkxmNTdFeHRI?=
 =?utf-8?B?eVBUbnFWN2U2UWkwM3dPRENLNytLeHpoQkV0dUVXb0F2Z2lVc3ErRHhJNnVM?=
 =?utf-8?B?UUJUWDI2SzJTcmQrU1JoQmU3amIwdHVHTkk4cDZQekxTbjJ1UlNZNVA3aCs2?=
 =?utf-8?B?WDVqTG5jdFVOc28wemFTNG8zTWlwNjMvQ3ptMkJPdVAvZ1lWS1VyUE9IbGhm?=
 =?utf-8?B?ZS9QZzVVelNudDhHM0I2d2JtVUhhRDlmMzQ0b2hnU2cvV0VubjAvWlJ0SXh5?=
 =?utf-8?B?bmhxekFYNVR1WkEzQjBtUUhMMHRpViswdzR6Mm40SDRkVlpmWFR6c3dkMkpy?=
 =?utf-8?B?c3VSbnNqKzkvbzExVExKcXIzdlNiejZJekh3US9iVlhJNGw4akxXa01oNkRH?=
 =?utf-8?B?aWpvUEZlU1dsZTBjZUNPN05BQnNyaVNlV2FWRUxLdlBuWTN5QmVVSHlBUDZt?=
 =?utf-8?B?OC9wSitRQ3VUTEJBeVNvTTFObUxEQU52YlYrVmR0M2hoM3o1Wk5sK0RETkpm?=
 =?utf-8?B?ZVp0emhFU25KdDY0LzlRU1B4WVRtYlZ0TG9rNlc1WjBnUzFXVk1mK1F5U2F6?=
 =?utf-8?B?cGRPTEorYmhXMzRUZnd4S2d6MVlBblFrRGU4OGN5VUhUcS9TZEU3NWNpVTJm?=
 =?utf-8?B?Z2RBNmZablhneEtJK1p2Q0o5SjkzRVZrL1RXU0hyQk5VL2w1NUMzVGRGTG4x?=
 =?utf-8?B?OU1IbmpjUWxzMS9xV1pnYjNqd2xlOUNiQlEwMHJUa21ycERubzlQYUhKZ1dY?=
 =?utf-8?B?NUlmK05jZ0hEbnZpbWtwTDFRQ3hxQlpOR05MNWk2bG9lTk5NaVArdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6c1a15-96cd-44dc-0b08-08df0eb1bdd8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:34:27.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73DCEi/S4mLaw9q+gDYuXPNlFUPS0qPO5m3pmPrsPyH1nnBp4nkcn2N3Quj2v6wf8XUB4GDBESMZZ3mqxmiNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
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

On 2026-09-09 16:15, Gang Ba wrote:
> Fix a hardware RTL bug in the TCP XNACK scoreboard reset path where a wave
> receiving a no-retry FAULT from UTC and subsequently terminating may leave
> its scoreboard entry uncleared when reset events arrive back-to-back.
>
> This can cause a later, unrelated wave using the same slot to incorrectly
> inherit the XNACK error state, resulting in its VMEM operations being
> dropped even though the wave never faulted.
>
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  3 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 10 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       | 83 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h       |  1 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 59 +++++++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 +++++
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
>   9 files changed, 180 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 7e9f7a280c1b..98cd0435ced5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -193,5 +193,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
>   	.hqd_reset = kgd_gfx_v9_hqd_reset,
> -	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
> +	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
> +	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index b30ad9701bce..fc253260ade5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -37,6 +37,7 @@
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "gfx_v9_0.h"
> +#include "gfx_v9_4_2.h"
>   #include "amdgpu_amdkfd_gfx_v9.h"
>   #include <uapi/linux/kfd_ioctl.h>
>   
> @@ -1226,11 +1227,15 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
>   
>   uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
>   					  int engine, int queue)
> -
>   {
>   	return 0;
>   }
>   
> +void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev)
> +{
> +	gfx_v9_4_2_clean_fault(adev);
> +}
> +
>   const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -1261,5 +1266,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
>   	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
>   	.hqd_reset = kgd_gfx_v9_hqd_reset,
> -	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
> +	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
> +	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 9f43f16a1ace..dba7ace872de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -115,3 +115,4 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
>   			      unsigned int utimeout);
>   uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
>   					  int engine, int queue);
> +void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 8b84bba58752..344156bf20ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -343,6 +343,28 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
>   	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
>   };
>   
> +static const u32 fault_cleaner_compute_shader_aldebaran[] = {
> +	0xbe8000ff, 0x00001000, 0x80808100, 0x86000000, 0xbf85fffd, 0xbf810000
> +};
> +
> +const struct soc15_reg_entry fault_cleaner_init_regs_aldebaran[] = {
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 1 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xaf0000 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0xc8 },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0xea4fac },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
> +	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
> +};
> +
>   static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
>   				 struct amdgpu_ring *ring,
>   				 const u32 *shader_ptr, u32 shader_size,
> @@ -692,6 +714,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
>   	return r;
>   }
>   
> +static int gfx_v9_4_2_clean_shaders(struct amdgpu_device *adev)
> +{
> +	int r;
> +	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
> +	int wb_size = adev->gfx.config.max_shader_engines *
> +			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
> +	struct amdgpu_ib wb_ib;
> +	struct dma_fence *fence = NULL;
> +	u32 pattern = 0xa;
> +
> +	/* bail if the compute ring is not ready */
> +	if (!adev->gfx.compute_ring[0].sched.ready)
> +		return 0;
> +
> +	/* allocate the write-back buffer from IB */
> +	memset(&wb_ib, 0, sizeof(wb_ib));
> +	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
> +			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
> +	if (r) {
> +		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
> +		return r;
> +	}
> +	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
> +
> +	r = gfx_v9_4_2_run_shader(adev,
> +			&adev->gfx.compute_ring[0],
> +			fault_cleaner_compute_shader_aldebaran,
> +			sizeof(fault_cleaner_compute_shader_aldebaran),
> +			fault_cleaner_init_regs_aldebaran,
> +			ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
> +			adev->gfx.cu_info.number * 32,
> +			wb_ib.gpu_addr, pattern, &fence);
> +
> +	if (r) {
> +		dev_err(adev->dev, "failed to clear MI200\n");
> +		goto pro_end;
> +	}
> +
> +	/* wait for the GPU to finish processing the IB */
> +	r = dma_fence_wait(fence, false);
> +	if (r)
> +		dev_err(adev->dev, "timeout to clear MI200\n");
> +
> +pro_end:
> +	if (fence)
> +		dma_fence_put(fence);
> +	amdgpu_ib_free(&wb_ib, NULL);
> +
> +	if (r)
> +		dev_dbg(adev->dev, "Clean MI200 Failed\n");
> +	else
> +		dev_dbg(adev->dev, "Clean MI200 Successfully\n");
> +
> +	return r;
> +}
> +
> +void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev)
> +{
> +	gfx_v9_4_2_clean_shaders(adev);
> +}
> +
>   int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>   {
>   	/* only support when RAS is enabled */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> index a603724c1dfc..1cbade5ed657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
> @@ -30,6 +30,7 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
>   				      uint32_t die_id);
>   void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
>   void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
> +void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev);
>   int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
>   
>   extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 3ec6a73af22e..540fc205d20e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1504,6 +1504,63 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   	return retval;
>   }
>   
> +static int clean_process_queues_cpsch(struct device_queue_manager *dqm,
> +				      struct qcm_process_device *qpd)
> +{
> +	struct queue *q;
> +	struct kfd_process_device *pdd;
> +	int retval = 0;
> +
> +	dqm_lock(dqm);
> +	if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +		goto out;
> +
> +	pdd = qpd_to_pdd(qpd);
> +
> +	/* The debugger creates processes that temporarily have not acquired
> +	 * all VMs for all devices and has no VMs itself.
> +	 * Skip queue eviction on process eviction.
> +	 */
> +	if (!pdd->drm_priv)
> +		goto out;
> +
> +	pr_debug_ratelimited("Evicting process pid %d queues\n",
> +			    pdd->process->lead_thread->pid);
> +
> +	/* Mark all queues as evicted. Deactivate all active queues on
> +	 * the qpd.
> +	 */
> +	list_for_each_entry(q, &qpd->queues_list, list) {
> +		q->properties.is_evicted = true;
> +		if (!q->properties.is_active)
> +			continue;
> +
> +		q->properties.is_active = false;
> +		decrement_queue_count(dqm, qpd, q);
> +
> +		dqm_evict_mqd_bo(dqm, q);
> +	}
> +
> +	pdd->last_evict_timestamp = get_jiffies_64();
> +
> +	if (!down_read_trylock(&dqm->dev->adev->reset_domain->sem)) {
> +		retval =  -EIO;
> +		goto out;
> +	}
> +	
> +	retval = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
> +
> +	if (!retval) {
> +		dqm->dev->kfd2kgd->hqd_gfx_clean_fault(dqm->dev->adev);
> +		retval = map_queues_cpsch(dqm);
> +	}
> +	up_read(&dqm->dev->adev->reset_domain->sem);
> +
> +out:
> +	dqm_unlock(dqm);
> +	return retval;
> +}
> +
>   static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   					  struct qcm_process_device *qpd)
>   {
> @@ -3347,6 +3404,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
>   		dqm->ops.checkpoint_mqd = checkpoint_mqd;
>   		dqm->ops.set_perfcount = set_perfcount;
> +		dqm->ops.clean_process_queues_cpsch = clean_process_queues_cpsch;
>   		break;
>   	case KFD_SCHED_POLICY_NO_HWS:
>   		/* initialize dqm for no cp scheduling */
> @@ -3368,6 +3426,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
>   		dqm->ops.checkpoint_mqd = checkpoint_mqd;
>   		dqm->ops.set_perfcount = set_perfcount;
> +		dqm->ops.clean_process_queues_cpsch = clean_process_queues_cpsch;
>   		break;
>   	default:
>   		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 21cf3c16f3f9..f55f313d6cc2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -201,6 +201,8 @@ struct device_queue_manager_ops {
>   				  void *ctl_stack);
>   	void	(*set_perfcount)(struct device_queue_manager *dqm,
>   				  int enable);
> +	int (*clean_process_queues_cpsch)(struct device_queue_manager *dqm,
> +				    struct qcm_process_device *qpd);
>   };
>   
>   struct device_queue_manager_asic_ops {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 1688d8e595f2..9b48fe598597 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -359,6 +359,24 @@ static bool event_interrupt_isr_v9(struct kfd_node *dev,
>   		!amdgpu_no_queue_eviction_on_vm_fault);
>   }
>   
> +static void gfx942_clean_fault(uint16_t pasid)
> +{
> +	struct kfd_process *p;
> +	struct kfd_process_device *pdd = NULL;
> +	struct device_queue_manager *dqm;
> +
> +	p = kfd_lookup_process_by_pasid(pasid, &pdd);
> +
> +	if (!pdd)
> +		return;
> +
> +	/* To Clean the GFX on the faulting device	 */
> +	dqm = pdd->dev->dqm;
> +	dqm->ops.clean_process_queues_cpsch(dqm, &pdd->qpd);
> +
> +	kfd_unref_process(p);
> +}
> +
>   static void event_interrupt_wq_v9(struct kfd_node *dev,
>   					const uint32_t *ih_ring_entry)
>   {
> @@ -547,6 +565,11 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>   			return;
>   		}
>   
> +			/* GPR cleaner shader for MI2XX */
> +			if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
> +				gfx942_clean_fault(pasid);
It may break debugger, which needs to keep the GPU status for debugging 
purpose.

Regards,
Eric
> +
> +
>   		info.vmid = vmid;
>   		info.mc_id = client_id;
>   		info.page_addr = ih_ring_entry[4] |
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 01c2631bbdff..d749669f8e6d 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -343,6 +343,7 @@ struct kfd2kgd_calls {
>   	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
>   				    void *mqd, uint32_t num_sdma_queues_per_eng,
>   				    uint64_t *val);
> +	void (*hqd_gfx_clean_fault)(struct amdgpu_device *adev);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */

