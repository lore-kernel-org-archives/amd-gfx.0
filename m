Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980F4CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 18:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2693610E06D;
	Thu, 28 Mar 2024 18:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B94AYK4x";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20E810E06D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 18:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPcoi2sHrqAAsMgrOl9VeF+spqPECdqP2NH/x4zzGFBAX/9f+SRf8v16TBoxNhlcDS9jRkdo4hrntqr481mhwbBOLDEQw6Qc5P0WwE5m0/bn9BkwWC56shuzao7B5hQZqWy1084TwrXYdJhGar2678lJ95aQWkIs91zPiQ1UQ4o22nLyXxzDOSQltOIz4n62KMcKA/y3lWc4F8Yc3i8YXdKhcT3Kx2He+jnpyHVWC5IbR/1+1xFjGRAzU4Qeqsj0u8K5FtFGVY9SKxtu53S3fv8iMohwPQlSCDyb9reDzGFmMJc9dhXq/8xEhiEC2O1XNNixI6f1/+TFoYZy230uDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiMBl3yG1g/W2mNnlJwJDBbxAycaJ4Vf5Mqusv7393A=;
 b=hSZz8wgM2tKv9LKRFOkMa+TAx/QWmLD6AiQVxAO5UQBwDTNZTIm86ZFhfvn9pGogqf9O82zd0cRPM102wOeTj+ebtj6r5HNY3Cbvhgfja0NFHIRZZMYEnr+/aur1xY8I/L8/CxSbPjh/9JfutMAI2GGlpUOZWIYmYGEv12uXJtu28yNTV57qUF/S/M53OBJdJwpkI9yNM/iIF7pnR/dsNc8bYVpdY+UBFiMJT9VuurvrMhUAsHPMxikpgiZAusdL0tnYLFxn7qypN/MSkswUstBVe0mCEr0gamTFd8wZH3C92Mz8k7jaAFNuY6hz4JLJTsqSiW0aiNnnTe4qbK+aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiMBl3yG1g/W2mNnlJwJDBbxAycaJ4Vf5Mqusv7393A=;
 b=B94AYK4xC1ukKBs+rgAQxzrhkIwuEGppsZ9+MAC8TxfRithS3ZTuZxCWKpzQ8bYK0iaHlkAWAo0XvVwulEMQP//jtG+8WappSduwOYvaRf8IIqelEvFDu8Ktyq2yy+QcpZXK89SWJmUmYPWaG4HD9Hk3SBXj42tHxPso3q+jrfs=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 18:32:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 18:32:39 +0000
Message-ID: <f02675b2-aa54-4c59-9324-059328770678@amd.com>
Date: Thu, 28 Mar 2024 14:32:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use vm_update_mode=0 as default in sriov for
 gfx10.3 onwards
To: amd-gfx@lists.freedesktop.org, "Slivka, Danijel" <Danijel.Slivka@amd.com>
References: <20240328175900.161968-1-danijel.slivka@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240328175900.161968-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0337.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8020:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K0HYWyc6lalaAc6EIvlPSa4sOz+OZTn6+/rDqvUkS1bjqVevyz6HL2GcuzXqw3wLJkDjoX9rwAA2uVnGhcYeUjATGfWLaaTcUj61TQe75/Uy8lLr+bWWEpaiwhJnkcxtnaPYvLg+YcYmgDPbNCvhyFSMKlob0tGOOeqq1grqcBPjZ9Ip4uttozk7brziD7G9jEIBzzDfjePRpAFmNtc/aNsl5xuXYXv0g0MdhLnxEasAY+nU9aw1dnfut9CCkm/2F87itmTSKwB8tzre9EwcE9CJeXDrCuZmybp25quLBF6hSkWGl5QKjYDc1uENkpCZd/IJF8dJqgeCQ1T+MS9fss73zFcBso9u1es301fF/WxgkU160Tljs++2nF/BTeg7fbbGzl2SXtmsHIIJWh6BMX1z30ml0kYXIf+QJaTq0zxI8YcvSKS+WFxMYi3Y0GKiy4b52uxkD6kRSPoq/1I8R3JpN3yCDYVVQvJzMjCic3erQ/wDJqaUWcriPwYDQ6DSbDPKr9COdvCWKhzqX88YGG8sQjfY+g0L94Lt6pw6hwJxOld1T1v4amUAW8o0pmXZOFe2aG5ralYENlI5O1srhe6ehgvhMe7l7N9Nir3d9UjQOBhzfgQq8o02O2ETZpe7/LYS0oOvTxC2ZXzHZYd4V9AOnGK74GK/hkmzChRkys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtnaUhTUGJTYTRnOXhsN3VsVm1wcWZIY3BUUFRrL2JOZVJacFdiUlVDdUxX?=
 =?utf-8?B?ZlFPVENBSXB0aDdnaDl2VnhXNXB4bUdNbWJ1NjMrMHNRR3luWWxiOHNVRVg2?=
 =?utf-8?B?S28rQ0dkbUJ0ZnlXVWQyalJIWGFVSVFLTXVpVW5pWjhvdVJEMkhER0YreXNY?=
 =?utf-8?B?cndzc3NZUGdJTmsyaEVxTXd0MUdLY1c5TXpuaHJnQ0FkeFVuR045aVNlaFhu?=
 =?utf-8?B?d3JiOTd1WGRoN3NrN3d4ekxqVDQ2T0xnODcxK1ROWTF5elRrdTFuMFpxNnVD?=
 =?utf-8?B?VnFpUDE5bmRITXQyYk0zTjBqeDFmcGUrUUl1cVFLQkNMUThrbzcvNDNObVpF?=
 =?utf-8?B?eXhPQ1ZkcTZwV2RUbnBnNVdHZ0crVjlVSWJSZlNRSVBxOFp1RW5ReHNGWldj?=
 =?utf-8?B?UzZncEs4TE5ONzhYcWRDZm9FRGF6bzVyajZBZy91Sml0MkIwNFFKUlVzbzJn?=
 =?utf-8?B?R1VCN0pYYm03R2hYcVFHS2NXNUFCMHE3NUNLOVBnSFVBajEzNkIyckM0MzNx?=
 =?utf-8?B?Q2JMWDlWYWVYeW11V2FFZ0d0dXpoTktXYklqcXhNeHVIaVc3ekxHOXZueFlG?=
 =?utf-8?B?amViZ2R2TlFHdmx0eWw5MW5XMGd0MllwRTdmVjA3eHVIaElrZFhaSTM1d0E0?=
 =?utf-8?B?cWdYTTRGbjFGMEw1Z1NFTmpjTG5pUHlnWTY0U0l0RWwyVkJkVFRiYVFjU0dt?=
 =?utf-8?B?a3F2dzlpeFNNRG5rR3E3WklYZ0VJKzBrMm9QbThDV1dZRk9rRlN6SFJCQ3Vo?=
 =?utf-8?B?aHpNSU9GeURKSUtXWnZWU2g0cDFnemhKU0grV0pTeFRTQlJYODZZWndremV4?=
 =?utf-8?B?VWlyTUE2dlM5RFN1RUxqV1VWeG9DVUF6TXFZZzhUUkxvaFU3Sm04UVIzcndD?=
 =?utf-8?B?ZG42cndtbWpXblpDbWRnUldLS2daUVR6ampnUVh0STNLVHNpSk0xU0hndllF?=
 =?utf-8?B?K2JieU96d2xwYWJxWEpKTms3YjJrRkp6SGIzYzRjWUp0QjBDTnU1RlFHUGh1?=
 =?utf-8?B?bUVZNW53MmM3Y1dDYWJycldZSUZPNUNWTFdPdzdkOTcwTGdQRzRkaXVPT1lX?=
 =?utf-8?B?RTBmWEdLRzV2QU5uN1pJQlZJTDB2ZDUwRkhVR0FrV09ZWXJwRFppeVY0VWpY?=
 =?utf-8?B?RG9KVzFUakZCaE9ha0tQRDhqVzF4T25iS2xTeFBNanhGdzNPeU9MZ05iV0xi?=
 =?utf-8?B?RDZVVDlhOHU5US9LY2l0UGRRU2xyclh4bG1XV1k1S1p4N3RPVDN4UWxrOEo0?=
 =?utf-8?B?N1IrQ1ExOHZMd2g3TWoyNmlvc3V1Z2JzdlZTclBuRjdScEFnc0xlcFVVclZT?=
 =?utf-8?B?TWpLYmlGNFljVkhMMURBLy9TTGVTaGxqaGZmRGZxN2loTUhvMm16cTI1Q3dh?=
 =?utf-8?B?NmxPSjRRK21BbkNYbUVSeUs3VEhhNlJvSVNNNWZuWDE0TjZ3WFV3RDhsTjN6?=
 =?utf-8?B?dGRiRHBqdkVLeFFPSzV3bVJOWWoxZkJJK3hwa1JFRDFETlc0Q0VnaWwzQ05T?=
 =?utf-8?B?T2VFRVc4bXhuVVNETTNiUWFkd3czaDYwTHdTakFCdklTdEJGNjhTZ2FJTUZG?=
 =?utf-8?B?RnZmZGFkbWFlV0ZyalRWUUIyTTh1elNhUTN1SGZ5MDYwdUZjK05Pa2VQUUQ2?=
 =?utf-8?B?cmVvc1dLZlBrZVE0bWlvVVA1UGNqL3grOG04SWN4T2NXb0Y1RnduVWd6bUNJ?=
 =?utf-8?B?OXIvQ1JwMlNTNWR6T3d4QlJZNnNySTd1REdvUjBmeTRwYjN0L1R1UjZBU2lD?=
 =?utf-8?B?L2ZoU1IxeXhBRnZHUDh4NnNRa1BOZ1ppb0ppaDBsc0lyOW1oMmlxcjN0ejNo?=
 =?utf-8?B?aWtJekpwL1BFL2svUkVxTUJJRWY0ell2UVJSQVlOdWpBWjZXdVFRTnk1Ri9R?=
 =?utf-8?B?djhoSGFJdTBhbk54elBGdnI4dmU5VmI1dUo0azNCMVJ5NERneE9heVR6VHE0?=
 =?utf-8?B?VDVLYUc2MDQzT2hpMTEreENxdnNETG5vNWRwUThCdjNUM1BxK2RuSlBxdS9S?=
 =?utf-8?B?d0FBMW5jelkydnMwZkU2SXVtNGZQalMrWWtDOWZVd2sya3RFRkJYSlVYc1Z3?=
 =?utf-8?B?UEJoVEZOSndxUU1Fc3hzVlJpUjBQSWJCN0ZqdEQ1Q3pBK1RMdHIwWGIwUUpO?=
 =?utf-8?Q?sGg5bMGX8f4Y8iWj4h3SynFtG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b180946-8c19-4632-8069-08dc4f5572a4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 18:32:39.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /84kVo1nk0ZrxFpsxILDjiXSMyQ2fC6DiRn4/2UNuUXn6CWGacX/j/2uKHDqkmzXMTVts34fCPvKm5s9hIXNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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


On 2024-03-28 13:59, Danijel Slivka wrote:
> Apply this rule to all newer asics in sriov case.
> For asic with VF MMIO access protection avoid using CPU for VM table updates.
> CPU pagetable updates have issues with HDP flush as VF MMIO access protection
> blocks write to BIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL register
> during sriov runtime.

Please mention that you moved the check to amdgpu_device_init to ensure 
that it runs after amdgpu_device_ip_early_init where the IP versions are 
discovered.


>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ------
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 12dc71a6b5db..59ee902a1eaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4072,6 +4072,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* Enable TMZ based on IP_VERSION */
>   	amdgpu_gmc_tmz_set(adev);
>   
> +	if (amdgpu_sriov_vf(adev) &&
> +		(amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 3, 0)))

Please fix the indentation. The second line should be aligned with the 
open parenthesis from the previous line. You could also remove the extra 
parentheses around the comparison. They're not needed, and IMO they make 
the code less readable.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +		/* VF MMIO access (except mailbox range) from CPU
> +		 * will be blocked during sriov runtime
> +		 */
> +		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
> +
>   	amdgpu_gmc_noretry_set(adev);
>   	/* Need to get xgmi info early to decide the reset behavior*/
>   	if (adev->gmc.xgmi.supported) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index aed60aaf1a55..6f01de220c44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -724,12 +724,6 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>   	}
>   
> -	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
> -		/* VF MMIO access (except mailbox range) from CPU
> -		 * will be blocked during sriov runtime
> -		 */
> -		adev->virt.caps |= AMDGPU_VF_MMIO_ACCESS_PROTECT;
> -
>   	/* we have the ability to check now */
>   	if (amdgpu_sriov_vf(adev)) {
>   		switch (adev->asic_type) {
