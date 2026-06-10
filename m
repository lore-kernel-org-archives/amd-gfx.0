Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7828CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 14:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8282D10E49D;
	Wed, 10 Jun 2026 14:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rNh4dKEA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441D510E49D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 14:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzPeB/vEdDf+JLoVdpEIuNQ9l40qUSIzTyD0PenrH7n0haHbRTiHqauEOyczkBhr+7s4EfpBvFoJw95F6CahwekaSSms2SBbZMtw62tiGMh/e9oMChzeNfxN3l/MFT/bl35IZQ1qQnGXTJoFELtRn8OTJXJr896h5V83Kumk2FVqYTcb5Ju/MMoOO/a4UEPKXfmvGuTvc8w/gAsnHUTdF/e1sp6lmLt+26SDnnvVzFm5aUWlywfmATk9A3vZrea49l9aFSmrucDoGsm8/aU9DG9O3RxuVQJ8Z8uqDYulo6yYAoZiLpX/E+1YQH4erRUbE9ZS9MtnOrmreqjiPPhYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvmKpmlDwYo28k1stBvgNdJw3EmBjJ5BoVhVQ3tZnSs=;
 b=iB+0tURilagzL3sKF/rAwe0SMJQHAy6K92QcyJqFsBa/1e39XmbnP1R09APb5rIX5mPqbK+6LwdGOjRzfCOlx8LdSvXVqzH/zTQEMfFvC1b2pq8OUGm6NGTZFHZ/uj/le4SsDXTo99usC1Rz0j4pZK8WaLNIB6Hdg/6PmVcyQjDDttnPdi6/A2+V7uzcWKqyD9ukeJjXRVzZtLH9AMF3MlvJ/9qbULoQdXgf5uIBk5hTIOPoqvXD3RC4aUJjtbs1Jw6ybwDkgpLkV/CBn9oqSny9WdONJ/xwquy5F46uOZ31Oq2OJLHP1rgk17Y1QH6j+6cfjR/gnaUJ0Wd2imA6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvmKpmlDwYo28k1stBvgNdJw3EmBjJ5BoVhVQ3tZnSs=;
 b=rNh4dKEAw+HK990fwbZrpBjD2ETjRFtzXpDNdZLZ2j6bq+9+hkADKWRLF69FSgqbkb82QdzFeHsB6/vF0utEgvgwbU7kFdzXI3muVpv54hgJf9VVCttSqQGjyOwJnvMOsDq53n2gBQ7uxEsLudKKCoR635TjpmslrGhqFSGguKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:46:13 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 14:46:12 +0000
Message-ID: <6a785683-4020-4d63-a8ff-1e357e9a7d96@amd.com>
Date: Wed, 10 Jun 2026 10:46:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
To: amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com
References: <20260610144012.61360-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260610144012.61360-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610::21)
 To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c0703-5d41-4057-43fb-08dec6ff0459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: R0UwwygFJBMdIQoT4fPDuKRMmsk5SiEahKfIb1qEg2YYFt72LdS7b7CS3qzhYfg8f3GutHLh9+bS8I+K5ia25xyH/+T24kJe9b7EAJah0TPKnhAGMw6vWD9q1CT9ATdUfgMerO79Kef2BQIdhrDWkfbELy5LgdMwVHpVEfBwY7DfTYecAhOoWAXvdrHQbfW8qZQ3Pbb7a4wXYAWPhxyfNphjM9wDJwYbsovNEWfkAPwZuM29b7ZFHnJ4akft0HNfxrjM+MxGCclNvix3IefOXH8dY437CIFdf9ckBouR/O0wDSyDKiITz3eCBIclfe9apBXjHAEk7OV1BA55teB7C3eXSrTtw/gXzTrlSSRPlwTLzPmPLZo3+KIQvIKYzMLn2UU2emfoppncDBDva+yb6gNIErYYj4lF4bgW6rH5l/WHGee90OoKPqQZgxEXoone61CTq1t30g0YTqvzjFtUGNL/tGiyOFqCAd+M+RQKyldIIcF/g8G/hGODVNYmwozYeZjqCe7pL2zmvRepI7mIIg0/3twpiurzkeLdC5cZy/iIT6vnFd9EW9clVg/p/UdcB9J+KsBiZNFSP5qHKLXkBfOwwhlk6Tlhyi4W3+P0GRvec3hsS31d75oFPvpdrF6vs3PQHDBBsebe3uCzQSGa7iYP2/cja6609PGlGlh1wdzp9wEvwjBjgV+BM269S2D/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1UMW5SQnJmMFE0ZkNCQSttL2NHcnYrMmY0MGNnaHlYU2tUOWNsQnZCTEYz?=
 =?utf-8?B?Q0RyOHIvUnIzbERYQURYdWtWUkNacHAvMUZXSCs3T2Z3OGtMd0pIN3JRY2Zr?=
 =?utf-8?B?dHlmMGYwNWZLZVJlWnQ3WmRkN01kK3k4UytFc2Z3V21qbEpWY3ozZC82YVlk?=
 =?utf-8?B?eU1WYkZtQldqYXJCVEs5cXNqaVNXS3VaMk14NVBKQ25IbDhlL2J5YzF3YW1j?=
 =?utf-8?B?QnRsSWRuWE1FNVowdnZ0QzVFQ2trcFhLY2lZamE4ZDhFcGdjMzF3SHlqVEFy?=
 =?utf-8?B?ajk5YmM2NzRBUi9CcWZmNm45SkNYUytXRVBsekJ2cXRQa3JNZ3U0UWdvVWZM?=
 =?utf-8?B?QkYyS0hMeDNtVjh6dStiUEMvNVdXSDNFYXZKQk90OVM5QkZjTllqUDNDQk1D?=
 =?utf-8?B?M3cvQWV6OTQ4cWRBL0lCZk1KTndFQmxQMmhBTVl5ZzdWeUVhcjhyNVVybWoy?=
 =?utf-8?B?cGI3YnVvWlR4T2dzdDl0VlpZVDI3WG1vNVU1dnBibVcwaXllc3QxSUdENDBp?=
 =?utf-8?B?ejZxUWZ6aFl4d0xlMWhqeGxlS2E4WXptc25QR1VSTDJveXYyeDU0eHJjTktJ?=
 =?utf-8?B?Yko1ZlcxOE5TY1ZvMzIvQk83Wk1BY1A3Z1hMZnRDQ0U2Q0lCU3g0QUEzOFpR?=
 =?utf-8?B?MjBzMlNmVjVqY3JDcmdCaytqNHBCaXVIOGtNSnU4UzArd2NySnpyTXEzMDVZ?=
 =?utf-8?B?Z2lOWnVYd0JpbHAzVStBYjdyUXJNVzFSQkg2YW1JempxSmZKVDJHWnpXbUlr?=
 =?utf-8?B?cEozcnlYSGpPT1VGRDRKY0RYZnlTVFMrNjRlaWVPNzRWeFFvTDZ1azQ2dXNq?=
 =?utf-8?B?dUJudGlES2NTdnZzbzd2M3h1azBGRTVYWkl2dlI5THgrMjl3SExQRmlITlZs?=
 =?utf-8?B?aHp3L1FGbVZ2UXlJN0d3d1VDTndrOWZnNmhrbDVLVS82dExCMy93SDNseGJt?=
 =?utf-8?B?WjZYZGNQUU9BTEIyWjA1emlWeG1VbEVBQW1kTlZKb2RQOStlMm9KdmJ3NktH?=
 =?utf-8?B?N0VPUDYySDc4ODBjSW9hY2dRbnBneVVwbFlTZWlYY1A3QkRxV0tmMStOUXJM?=
 =?utf-8?B?R2Jmd004c1VxSmZmWktwNVhzUEQwSUhERlNWb0JrN3B2aVcyYVVUdnZSYi8w?=
 =?utf-8?B?b3VuMk5aQXlUTlF3elg4VmU4d3owbnFoa0FFem9GeVNRWWlHK3ZEMEx2S3Iw?=
 =?utf-8?B?dXgzZnAyek95YVU0a28vaTIzN296eXlFKzY3M3pseEQ4WlgyRDdjNzhYd1gy?=
 =?utf-8?B?RkhFMHkxQ2I0NEtEWmlVMmxhSDMzdmtSK1VGdFoxVkp3ODZsdUN1bkhxYWpS?=
 =?utf-8?B?THdpRzMraHpPVXRINFZlZHd6eU1WM0U2Mi9GNXE3N3FqVDdkNEkwK3lOWEZk?=
 =?utf-8?B?enZqSFVzUlNkT1gxMHk2WXNwV0RhWXlqNENGZEtSMXlWa1ZXV1QyT1p4VzZK?=
 =?utf-8?B?b1dWMFNLdys3aGl2S2VkVGNZUnAzclRiSVRrSG96a2FuV2NKTS9CRERPT241?=
 =?utf-8?B?UkpUaFdLZkx3NkE2VlF5ZlRLNmlPdm9pRW1BK1JncEY4bVdQRXNrZ2FMNUR5?=
 =?utf-8?B?RjVBaHFwVm92Mk5TNHBRUGpZNDFFZDBqRjlqRk0xVTEzUVRVMkxucmllNG5x?=
 =?utf-8?B?UWo5UWhDNW9ONDBaSkhPTkVLaDUxNlgyZithck9vbS9pcGRyenFBbVI1L2Zj?=
 =?utf-8?B?elA2aGdUb2tkZ0JvMXNkdGpmRkZZVUo3d0FKLy9SNVNTVmZGajBoNHByUkFM?=
 =?utf-8?B?Y3JnME1JZ2NibVJMV3hFcm1uYk92TE96SUhwdXRBQm1tZ0hqWkFTdjhIZHhx?=
 =?utf-8?B?S2NXcFJJN2Ryb1Z4RTFUOUJQUmtCS2hFMGtOTnduRnAvSk0rdmZ2ZFdMdW8w?=
 =?utf-8?B?NUFrczJWeS9YRlIwdEZ1d2ZYL1pFVjZ6OGtRS1N3YjBIbElVcno3dkM4dUFh?=
 =?utf-8?B?ZlRkb2h5UHFIemM4S28xSG5DbklMaU1CZ3RlMHl4MEZoQzJqK21XUDZVYUNJ?=
 =?utf-8?B?dSt0ZDNXZzNISGwvRE5DV1BsVG5tYXIrRkVQVGU3Nmc1ODBydGsxczhQUWhB?=
 =?utf-8?B?dnZmMkxieDZzb2xWSXJWTS9RRDBCTnIzOXlBR2w1aTczTFdIdFlMb0JJaWZ0?=
 =?utf-8?B?Y09FOWZNSGRKdlM1ZDNoTWg1YnEvUE8rM3pPNm1zUjdTRTBFV2RycHRQOXUw?=
 =?utf-8?B?Y2p2N2NRamFNK1lTbE92dXE4ZmlmeVZQQkxQS0QzeTdVOWYyc25mMjdwT1RZ?=
 =?utf-8?B?SWpHdFRZTkdpTzdEMW15MTExQWE1ZFVhaW5sR1B4Q0c2MFVmUXRDa0ViSk4x?=
 =?utf-8?B?N0g2b3RYSmt6TGpXbXBydnQvQ3hsY2tYTDdLdEh1N3A5ZjZBRE1RUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c0703-5d41-4057-43fb-08dec6ff0459
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:46:12.6471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tH37JRKwW3GE2t2RAwfNogC5yP5lA+25jqOAZUYXMHzKIGYeYU0DjQ4PiCE++038WFSWjk0BnDKveWQePz+BFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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

Found a mistake, please ignore it.

On 2026-06-10 10:40, Eric Huang wrote:
> since gfx 9.4.3 HW is calculating accumulated activity counter
> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
> will still keep the way to read from memory at rptr+8.
>
> v2: read dynamic counter directly from utilization register
> v3: add CPFW supported version check (Harish)
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 67 ++++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++-
>   .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 +
>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
>   6 files changed, 111 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index f46c59118304..24caf6061efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -584,6 +584,70 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
>   			ptl_state, fmt1, fmt2);
>   }
>   
> +static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
> +					void *mqd, uint32_t num_sdma_queues_per_eng,
> +					uint64_t *val)
> +{
> +	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
> +	uint32_t sdma_rlc_reg_offset;
> +	uint32_t sdma_rlc_rb_cntl;
> +	uint32_t engine_id, queue_id;
> +	uint32_t engines = adev->sdma.num_instances;
> +	uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
> +	bool found = false;
> +
> +	if (!m)
> +		return -EINVAL;
> +
> +	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
> +	    adev->gfx.mec_fw_version < 194) {
> +		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 5) &&
> +	    adev->gfx.mec_fw_version < 44) {
> +		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	/* SDMA doesn't support over-subscription, there must be
> +	 * a HQD associated with a MQD, so found must be true in
> +	 * the finding loop.
> +	 */
> +	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
> +		for (queue_id = 0; queue_id < num_sdma_queues_per_eng; queue_id++) {
> +			sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
> +						engine_id, queue_id);
> +			sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE);
> +			sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE_HI);
> +
> +			if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
> +			    m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
> +
> +	/* Read sdma activity counter from utilization register
> +	 * if hw queue is enabled, otherwise read from MQD.
> +	 */
> +	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
> +		*val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
> +			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
> +	else
> +		*val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
> +			m->sdmax_rlcx_utilization_lo;
> +
> +	return 0;
> +}
> +
>   const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
> @@ -623,5 +687,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
>   	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
>   	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
> -	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
> +	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
> +	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b934863312d0..2b9177427058 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1067,8 +1067,17 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val) :
> +				 -ENOTSUPP;
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> @@ -2728,8 +2737,18 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val) :
> +				 -ENOTSUPP;
> +
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0be2fd04e6d0..d17f064ea7b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
>   
>   struct temp_sdma_queue_list {
>   	uint64_t __user *rptr;
> +	void *mqd;
>   	uint64_t sdma_val;
>   	unsigned int queue_id;
>   	struct list_head list;
> @@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   		INIT_LIST_HEAD(&sdma_q->list);
>   		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
> +		sdma_q->mqd = q->mqd;
>   		sdma_q->queue_id = q->properties.queue_id;
>   		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>   	}
> @@ -193,7 +195,17 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>   		val = 0;
> -		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +		else
> +			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev,	sdma_q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&val) :
> +			      -ENOTSUPP;
> +
>   		if (ret) {
>   			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>   				 sdma_q->queue_id);
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> index ead81aeffd67..11c32e4274fa 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> @@ -493,6 +493,10 @@
>   #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
>   #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
>   #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
> +#define regSDMA_RLC0_UTILIZATION_LO                                                                     0x017c
> +#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX                                                            0
> +#define regSDMA_RLC0_UTILIZATION_HI                                                                     0x017d
> +#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX                                                            0
>   #define regSDMA_RLC1_RB_CNTL                                                                            0x0188
>   #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
>   #define regSDMA_RLC1_RB_BASE                                                                            0x0189
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d34c869b182f..2c91242caadc 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -361,6 +361,9 @@ struct kfd2kgd_calls {
>   			     uint32_t *ptl_state,
>   			     enum amdgpu_ptl_fmt *fmt1,
>   			     enum amdgpu_ptl_fmt *fmt2);
> +	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
> +				    void *mqd, uint32_t num_sdma_queues_per_eng,
> +				    uint64_t *val);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
> index a2f81b9c38af..e0d387f08576 100644
> --- a/drivers/gpu/drm/amd/include/v9_structs.h
> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>   	uint32_t sdmax_rlcx_midcmd_cntl;
>   	uint32_t reserved_42;
>   	uint32_t reserved_43;
> -	uint32_t reserved_44;
> -	uint32_t reserved_45;
> +	uint32_t sdmax_rlcx_utilization_lo;
> +	uint32_t sdmax_rlcx_utilization_hi;
>   	uint32_t reserved_46;
>   	uint32_t reserved_47;
>   	uint32_t reserved_48;

