Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5A0C54E67
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 14:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917A810EFFC;
	Tue, 26 Mar 2024 14:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OZMKvWak";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2119.outbound.protection.outlook.com [40.107.96.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6508810EFFC
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 14:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmvbxYqLpLiNUmHqYuuJfw0P/zD/MG31KiumMJ1WlMNJWYmL0BbtkIkKjfuZRxn3LEDe15YnB/yLX356cNqFidiin0lIhhTFRG+BWUfI26/RtqcCk6DGi52rYoOI9+085RbCZ7380atsBwKDIA9ZkNhRgq9DMvQLVd0L7Sa7eLYgKNXnF7k+Mzb5FWS4G6wWrdEMcWCbXNJAHfc+Tix1Khhj9wFZfzkO+pNqJrPAprz6NoY4g3UXnCXr0QGFF+kbWrj21eVgCLdQLVs4kLB0M04JqSAG0gNtOj9zdzyors8zaKpfguaaJMHQYOp3VrBVDHxJLKHCKS5KVmzB0/bpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhlg5h/gv/6rTZTak3sp9EYyg9HvXdRtgFl0Nfoq/Ds=;
 b=CyDL7LcwcKD5tQjvN9kdrqdMgDvgXt7ZKpu5FCYEbDlTiygooHn7T1PFXx62Ar19+BzDAS/m6iJsR2rtvlvXdZ0MQ3XE2rNPg4o8jTj9bgUdUMYU2u81anXA8o1KqWHcBVUIP+ihJrhp2j3wY59qQBOFclSqR+50Hz8gH3I1EFiO0fSF5BEyUNMzQ3AOfYWW4z96dpr1p9EmVqt0qjZa0DTIlwUm6P0IlJrct0pcw2+tCWMxVKlFCXAXb+d2QR6a3NKVQq0HoV3xgh8T4oDvI1cCgBTAsIvSO0s5uMauaZhHhc28+9K+C4V1nxbIoaBENweNVN7tHZYQrJGmzffgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhlg5h/gv/6rTZTak3sp9EYyg9HvXdRtgFl0Nfoq/Ds=;
 b=OZMKvWak3YUGpuyLnCq7sHWFwcbGUXyO981g3UuyhwS+H8JAkR21SVU7fNfEuxWuvvqQs+gslaiCFLFIgm8x37CnFIi7WHucCKA/HDl3awKWMWQc0X0qRwoSFT5Ye3hrMqfjZC4n89d+U/oZId811M5RdNl8qOD2OCtOZd18rlY=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Tue, 26 Mar 2024 14:52:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:52:12 +0000
Message-ID: <2d1d030e-0b31-48f9-9fe3-a6dac2f19270@amd.com>
Date: Tue, 26 Mar 2024 20:22:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] amd/amdkfd: add a function to wait no process running
 in kfd
Content-Language: en-US
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com
References: <20240322195737.30795-1-Zhigang.Luo@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240322195737.30795-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7278:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEjbTtPaj1HktX1MfAEUxzx0oTrBHc+ilshI3JXtd2vMbjt6br+Pv5tAQ+hj8w7C/+G5sX7LYow1OPk+hsQt6xrl1Tu5p+g+MmxZaoiF0ZJbHQrjnE0tvfB/BJlL0v36/aIIfRBWzk8+5oWANaHN+/ch026agFiIWZYt9DA2ac0L+2xB9qPf/GsEdca+YoXRkkZRXLRKdNnKjiP4E1S1itOBuoMWUGNs+byde89EmgRJIaQtMEbqpbBugVDPf0ZiIH955IIctqnGXBUOJJXKWZr0vqfdJSD9snwzULcNwrDgszwVayOFLxmuqoqxPTmr+xAr5+jI9ThYnIxxGFfTOzxIQ+k0yiWAtoSr9zqvwEW9ogMaA6ZZT+YL3lx5oZlVoVfm8WrLcppo7LK8oNuoSsrZtar42afC+eXfwhYqNtMjYhiKeDmuK5pO8quQMaqhWQDRoLMu45QX6RAiovS3UqjAzrrba10H0tgCn9+LGseQes4SmPV0TBawdD4ccFk/byjPQhIRz7XR0j0G83hj1okwhP/hdqsqisPFkfJnsXgatK81IIPZAi1l+543bE1NH5aqVdg0bXBEZP0Bgvb1cFHj1ZiLOI5v9E7LCh3eXXEbDPSZNlVpcnuFkJR6BIGOkRhBalsvQREmrvXW5NXcRCeh9Po1PuYo9VCy7995Hno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05BTjlReW9HK0ZibGx2S1JnUUVsUXVxTVEzYmgyUENyQjkvWkdpQ1AwZW1Z?=
 =?utf-8?B?ditFWmlvOTBRK3RsRGUxT2V6ZTZxL1g5dzZ2czZraEgzUGpJbU9PTFlhSjRG?=
 =?utf-8?B?eFd1dkhwc2pvOTZlUWkwb0lNaHpHU0VFdGdack0wTHo1OGp5a1pWc2pMSHRX?=
 =?utf-8?B?c0NORFRvc3NDNSs5cEh2czhXWTN0cnp6cGtrRzA5bFNzbGtNRUhETkxjdWJv?=
 =?utf-8?B?dFFIRm55aHdDeW9CSjNDU1R2QjQ3VHlhVVM3R2FxMFpzSUFpWmNrK0dabGJ3?=
 =?utf-8?B?eVZWVkZqTFFYRFdFYkxWcGc2SElraEJuZ2x5MWNNK0VQNjVZSitpVlA5VENl?=
 =?utf-8?B?L2JKTFZxR0tiazFNQjZlb0tRT2ZuVUU2alUwS1Rqb0FNREJKWVpoM0gyZHRJ?=
 =?utf-8?B?QTF0NUlWZXNTQ3JHaVB5Ym00SkJTUnZZQjFMdlA1a2FzOCs1ZElRdjVqdm1Y?=
 =?utf-8?B?TkZQcmdZU0FXWlVvcmJwUGpWNW84NzVqSGs5WXBMOUVGMzdxVjNxc1ZvYnZJ?=
 =?utf-8?B?K3EralowRVJsaHB1NVhuK2NmL3M1NEZjVGZXRGpSMWh3Z2RTK0UvR09LZzRZ?=
 =?utf-8?B?dHRzd2s2dkt6NU80ekQwOFRTUWJQc29iU0RNMk9EOEY0OGpjNDhWVVdITWJU?=
 =?utf-8?B?eXNOMnA5UTZlR1JCbVhiZlUwVm9CUjY1NzladDJhRnNLSFNjUDI1WHl3dTNZ?=
 =?utf-8?B?a09NL1lDMldTRFNDQ3ZPcy83QU1zZ1hMZWhRdEFYQXpKNVpJd1RpRTUwY1c2?=
 =?utf-8?B?VWx5SXMrQ3lJWGdURjhTN3NhY1NoenVlODBVemtKU0ZHcEl6dytUVFlsU2hN?=
 =?utf-8?B?TXl0amErWGpYNEpRenZrb3FQV1Y1d0xOYnpUZGw0VGcwK29tNE13emhRTVl2?=
 =?utf-8?B?ZnF5N0gzZHZLejNpS2wzbG41UkswYk55TVdybHZtZm1XWnlWNUw5cTZHSjFH?=
 =?utf-8?B?bCtRT28yaVRXRWhTNHVTMnBsbGRPcU5rY2RlaWNZNzY4akpYSlpUWVQwNWVJ?=
 =?utf-8?B?cktJeW1scWR6a25yQXNEM0wrcURIMnBtU2M2MHFtWlR2RWRUWlYyN05pcnp5?=
 =?utf-8?B?MFMxdHNqcW1pTTVkV2E0US92Z3VaSXpUdnc4ZS9FcXhjOVhPWkJIV0pXUmdU?=
 =?utf-8?B?MGp2Rm8wblhnV0xmT3pqUHFIOFNUUmg0LzdmOHg1VHR4bi8ydWIxdXYyVjZZ?=
 =?utf-8?B?cFZ0RFpVcXJKbTM0ZHBJNW9BMXJVZ0FxVEk4OVFXb3U3TzU5c3ZlVy9YZGF1?=
 =?utf-8?B?dmFibERrQzFnRnV6TGdzNTNoekJ2bTdMdGtQalgzYk12VUovdnVmUHk5Y0R6?=
 =?utf-8?B?WUdGVmZyWkhUWG1Fc3l3WmIvTlVZQ1hmYlVxTk9ZSUQ1djJjZXVvNG96MGNy?=
 =?utf-8?B?NHJvMTFQNkRKMVZjSHIvTDdzZUJoSTMwVjdSNjk0S2dVdjR2ZnVwWkhPWUhY?=
 =?utf-8?B?U3Eyd2N5WHVkM2cyK3Fnem10VEJUQzFNaDN1Q2N2Vy9ZeFB1RkxCUVR6Y2lW?=
 =?utf-8?B?aDdZdHNmb3V0MWhEMEtMbjBIQW9aeDd3V1hjak5VTTJYWDR2T1g3REpaWm01?=
 =?utf-8?B?VFRFMTJrenA4WW55Nkp2SGJwMnFWaWlzQjNqblVXUGJJVjczV1BNcVl0c0p3?=
 =?utf-8?B?MTgwVWwySWJ0Z2k2M3hZODlUOXlxT0M3c1lLYVJRU3kxZVA1T1BMdzFMczl0?=
 =?utf-8?B?RnFvR3pSQTVjMWRCMGh1NUZvbVVIN1RTZnFPZUQrbUtqRkI5MXpVUWVUTTF3?=
 =?utf-8?B?eWZLNHZTL1VsK2Y4OTFuemRHUEw3VGFqMHgwaWZRRmZocjJYWi8yZ1VRN1Nx?=
 =?utf-8?B?YkVpTFB0T3ozbHZZVlZsaVNYQ0JKazRMWWFtT3MvcG9obmdXSnFjUkZyTVBu?=
 =?utf-8?B?cVNOQURaZVpVUlZROXhvYlBwVHZtVDBGcXRHQjRKOWczRWJxeHJBRWNXSW9m?=
 =?utf-8?B?T2dsQkdKb0NIbVgwUkhqbGozUm5keVBjak4zOGg4bXlkS2FFL1d2WHRNZDMr?=
 =?utf-8?B?M0JMeUJtc091bEppNTQ4aEhOQVo4WWUwdDJXV2FUSVlWSU5GZ3FrUkd2SWdw?=
 =?utf-8?B?aldoYlF6NThCRG9sZGZiMVEwMVBaVmRpa0ZKQ2FMMGcwSUUvNTRXRkswK2FP?=
 =?utf-8?Q?PxMjw773JOyj1pcI1X5+GKyY3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f1a3ca-27d0-4bc1-6e0c-08dc4da451b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:52:12.4252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/8/XQ4/RgPt3mPy+U9fyOpXyAdtAg6LONiOUrKxkU3x+im7lFJE1DiRdzu5k9J5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
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



On 3/23/2024 1:27 AM, Zhigang Luo wrote:
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: I2a98d513c26107ac76ecf20e951c188afbc7ede6
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d5fde8adf19b..e02bfcec608b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -261,6 +261,26 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>  	return r;
>  }
>  
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev)
> +{
> +	unsigned long end_jiffies;
> +
> +	if (!adev->kfd.dev)
> +		return 0;
> +
> +	end_jiffies = msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) + jiffies;
> +	while (!kgd2kfd_is_processes_table_empty(adev->kfd.dev)) {
> +		if (time_after(jiffies, end_jiffies)) {
> +			dev_err(adev->dev, "wait no process running timeout\n");
> +
> +			return -ETIME;
> +		}
> +		schedule();
> +	}
> +
> +	return 0;
> +}
> +
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>  {
>  	int r = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index caee36e52a09..796e09abda69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -38,6 +38,8 @@
>  #include "amdgpu_vm.h"
>  #include "amdgpu_xcp.h"
>  
> +#define AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS 10000
> +
>  extern uint64_t amdgpu_amdkfd_total_mem_size;
>  
>  enum TLB_FLUSH_TYPE {
> @@ -169,7 +171,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle);
>  bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>  
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
> -
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device *adev);
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
>  
>  int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
> @@ -411,6 +413,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
>  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..2bec79e0c721 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -894,6 +894,17 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  	kfree(kfd);
>  }
>  
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd)
> +{
> +	bool is_empty;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	is_empty = hash_empty(kfd_processes_table);

This table is declared globally, but VF FLR is device specific. So you
may want to check if this is the right thing to do when there are
multiple VFs in a VM.

Thanks,
Lijo

> +	mutex_unlock(&kfd_processes_mutex);
> +
> +	return is_empty;
> +}
> +
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>  {
>  	struct kfd_node *node;
