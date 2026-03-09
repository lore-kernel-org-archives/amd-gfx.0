Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E329FCA195
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 21:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FF210E5CB;
	Mon,  9 Mar 2026 21:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GUhNiZtS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF4710E5CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 21:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSmFulmhlKw0SQU/URf2nyKJIwN5malgRLBOJqhxJR66lTuhvbCUTVYqyR9pCAxRU2qGH/wJWOZwDIVdultsFHHmKpuzJNEeZBLB/rVS/e0wm64esbylFqW7lZAURKsvFUCqe+zKnfQJbP7fYt17jDdMCydQ304vBKLtarIcA/+2Ee/EBMpBYzch+eAh1nL7GojIwMSe570UWyPFtSTVe74Ui9NA++NE/xrZHH2P6fS54K/gMefaZxDnGSsZrdnN7VNr/Prckytujv9ldWBeRr6KH/8O/BMgs09US+x84fTn38I2siD14W/NcH3F0UAJMdy2gczwJtO75xAxzV7xzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEmCMYhU4TSbrAnbdXR32IWdq9ZKoD29j1+qJcrcIFs=;
 b=wa1M2ui+0hh9E+MX/SSQTAYhurge+/ECEVhO0bD4p3qscfvz2OC+GcF0lIhOIwQixLCfOxyBIOnzTDfwKaALCE7oOzgeoqN61e01nezUdlssZ8k7pzxy01NuchD82HADa0dy+dTJ0911yOoZ03CN6IN2JXD0+oL4aYScnCxLMToULJNT2ExtVddumQGgbEvoWZp3u/E2EBl5VR2OWOJ0Olo0esJKyICfe6X1gxsABogwdvrbprchzIiFbrrU7fFYCuGEQnOH3RpaZhjlA6JC6YLp4igSvofWBQV+eJrRB7HlO4JE7yZ1FQJv96jgHVMrAzrXPM6Ejtnr2N69CujUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEmCMYhU4TSbrAnbdXR32IWdq9ZKoD29j1+qJcrcIFs=;
 b=GUhNiZtSVMmLxGK4OZIAKW+rree59/zryznX0kGumcx31Ba28/fhT6qsefd3ioa4M5fcjfd/w8z7NpS7XGLGJ5h3paTYMkLpgNKs8jbfSUiz99ZwHKvPFKO5ccf+euAJcMTztu1b6C57PuBuZdQppHdASVcxYRbO4/JhlWMyPGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Mon, 9 Mar
 2026 21:58:05 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 21:58:05 +0000
Message-ID: <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
Date: Mon, 9 Mar 2026 16:58:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4e8d5b-46b5-4c73-3a30-08de7e26f112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: V4ZNllT5n0f2HRblXJnD+heOzbcJknUkpP4OzRhH7wENdqTMEm0Mvurf3jDg/DtJ8gByeEo6q6MMC1uqZaQim0VctbTOUyeyD0ub05Utq7DyMLEI1IJKoOG2hyeKPf/vzpTIUDbh3wcUd9IP8co39oeR/qBIAzpq2svQu6aKINzq3LIeqEcI8IwudVpbgXTtSB0LB5oepwRabruGBV5CnSIBPEs/dyfBAY5LOy1IpqFKQxKlcOFCGNgsrmz/B4Za8Giqj2v/WfNZXk1BcHQS1kgp/bGUqiPQoFzxQcoJlmENZSOd4zPaUd4UsI0RF3tW1Qtp5H16Me/Iz3G5lKw3L+luf86v3BEXUTgTHSS9aGBxobR5H7SnDb/nHcTGPoCwrkZdgDNt7UNMBYKIzbj7SWpu6fumirUUSoXPisofaUa88uIlKFLgDkm1otGc6CPJXzJvwMRebZ+WyrDlVLY0s8EAVBflYfRc82UquVqfRURpAUoNGZzeHCeHheT3bFFaPBLdMy5J6ApmMK3cnemjh87JQCivgkx2N/1tC0neb3MhCPST9hEGQHs4SlyWzG/6OdgRa88WJcNHXeBe5PsRhDkamImlCCaKOF7viqWWLSTp+MMHlgAWcq/tfdAOmlVSxQD6fPJIVXO+IIRlHlwJ8eDY4HZm8HDejeDAFevJvWMDYHZiOniBra2E/upE7M4KZTNmA6HEwoa9s2CI9jHZ9dQX1wpKcjmKkQ4HSYRG4kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEszTjkvYU1OZkR4YWRCRkpZc212NzlKdW1xZzlvT09VTXl1d0plWElnRFJE?=
 =?utf-8?B?Q2xWVFZCUm80dTQwUzBKcWpYRUgzSlQxdFFuNzlxbFptbm0wYjhtMG5wbTRq?=
 =?utf-8?B?RHhVTVpnYWlxaC9BdXdRck1kdDhMTDJBYnFOa1pRU0t6YjhlV0xhZG4rSnZm?=
 =?utf-8?B?c3JrN0dDK2VGVjdtenN4Y0E2VWJVNWhiaFZpVHZmVHJaeVhSUFUzWjVDQitD?=
 =?utf-8?B?YVM1UGFSRHlsYlVVdTZ0R3hmS1JXekdWWUNuWC9ieG5VMDhsaDQ0d3l5R09q?=
 =?utf-8?B?YlN2dFFLYXZrMFhUc3FyczJtZnRoelU3ZDM5bEVnaFNmN3hKUmRTRU9QQ2NP?=
 =?utf-8?B?Wk1aWjNBWXVQM2svRUNpRkxtWE5kSWtnU1NZSExWa2dIK21FUnhTUGFGQUsv?=
 =?utf-8?B?SFN6c01FU1g1TUxpbFNtc2Rhd2ZFbVcwbzRNa0UwTTRBYVcxNlBNZytzRm1u?=
 =?utf-8?B?czhFNEY5K2ZLaVQyY2lpRTlobC9wTWNqa29Gd29QcDBzRjRCM0FvT2xaSit0?=
 =?utf-8?B?Sm5wZnhZY1ZyWThZZ3hKbGZId1NmNUcxS3o4UjRNQWdSZ0IwUDVyRFA5Y1Rs?=
 =?utf-8?B?ZG90SUdjb214dEtodERMcUlkSytmcldHMkVjUmRGT0k5RHJYKzFiVFNadFJk?=
 =?utf-8?B?OGxoV2RvUE95NkY1ZU9kOXpTWlpjZmNBYjg5V1JqS2l3Z1VJejkvcTVMbkls?=
 =?utf-8?B?Ukpabko0M1ltckRTYThCMklQR29SUkNOcS9qSGpYODhxWjRzeUhQdGh2VGc1?=
 =?utf-8?B?UHZVS0M0VVdwU2NmZ0c4dTE0ajJiTWFrVUpCWXh5V2xBYWpLaVAxZFNURVpM?=
 =?utf-8?B?T1ZSQU56ZUhkTE5Ra2VpdGRCRENZODNTRzdBS2RFeXlMaEIyRUdSS0NXNHJO?=
 =?utf-8?B?SWJ5cE90dTVnb1NYZ2JlS1l1ckNXaGQ0N1lqdWx0dTVFKzRkeEdGV2REcklz?=
 =?utf-8?B?K0I0Umw5MGY4bE5tZlc3c3Z0YXczaEZlNFpkRmJNZTlnd1c5UDlXekY0TmlT?=
 =?utf-8?B?d0JmNnV1WVJlVVVEL2diQ1psY2tWYXhzd3NoZWo1ZG5aczd2cEM0amVuODNN?=
 =?utf-8?B?Mmp6OWxPLzlUWCtNcFNwRnlFbG5IcUZmT3Rjc0UrRCtnc2dQQ21wN2hYWi95?=
 =?utf-8?B?ZHJMYVdWYzRIUCt1U3M2bnZSdWFkbEdOUk5HaVNRMHpxYWRFNlJVcnhqWDZ2?=
 =?utf-8?B?NEk5ZHk2TWg2aGNvMXdGbFJWZXJYMnd5MVljNWRpRHZ0R3JTd1hoeDhRekpn?=
 =?utf-8?B?T3JMUmJNaEF1bFBtT051RFZ2aHVpMU9RSGhxakovaHR2OTJBUnRUUm1TdUdP?=
 =?utf-8?B?cm8wSWdTb2dsb2xOdWtDL3ZjK3hEL3pPRXQzRXBJRjJCMFpWQmRMdW5YU1hR?=
 =?utf-8?B?bWFFMmhSVnlZZCtDME1lWklBY3ZSY2RuSXk1aS9mYUkzdFNMSmFtYUNpOFBX?=
 =?utf-8?B?SzhVSVRkL3BoS3puMVRMZitwVDVmU2JITTBvTkVQTnRkNVFLNFJzZEZYaHcz?=
 =?utf-8?B?Rk1NSGJOVEFyZ0RiVjV3QkIvRzFiMFJ5elVyS05KOC9zdGhlMHdjejI1QmN4?=
 =?utf-8?B?Ry9mZkVkUlpCZjlQcytyV3RGd0NORmc5eVVGYU9UY1JxVVFwOUhrVW8vQXY2?=
 =?utf-8?B?TVJUZ1RYck5RbVppRmliMWkwUnNYQUMyNSt3VUN6WUlTZzRoVTAzeVhvRzdu?=
 =?utf-8?B?S255ZnMwempJTm0vdFJ3bGc4bW1ZZmdXK3JnSHNYREtJUG9keVpmR0Yyc0p6?=
 =?utf-8?B?L3lHL0kzenZHQ3Y5ZUE2a1pQUzg0WGhveHJGaUNpendqcFh5Rjc4YTRhZzZQ?=
 =?utf-8?B?NzhGVld0cmsxSHVFVURpNGtvZjhVUDV3RVhJQVI3c0lxTXo2UVdJeXJ5NVpC?=
 =?utf-8?B?YjRoRGkxM0p0dGRFNm5SNGw0RUJsV2JkV0I0VlVSZDdXejMyTHAvclJOVUx0?=
 =?utf-8?B?a1p4U0c1SG1FdjhMS2lNQU1rQ2ZMVnFEczhRVWttQjJHNGc5ZUVKSmQvT0h1?=
 =?utf-8?B?ZnhlRk05MmEzdmtrbkw1V24va1BRa2l2OXNaNjBnSWRrZGJCQXlaUkhPWFph?=
 =?utf-8?B?cHZTMWsyakFKYW1QbjZ5YVhzODlIdUZBT2dmOGdQWU5ZdGNudHBhV2craURn?=
 =?utf-8?B?R0JaemV3cktkOUxRakp0SndmZXRQTk1YcTFXaW5QSk96Z2syWksyeU9VcmVk?=
 =?utf-8?B?ZU5rVi84dHBKTkhlQXRpaTBPdXR6TERialA2bG5aNDBoYUlHa29XeWdHcjhT?=
 =?utf-8?B?UjFnd3RkMStLVEExMGtRdmU4SVg0MzlERDg2OGNMQThGVU8xUWpaS2JwdUxI?=
 =?utf-8?B?UlU0cUI5S2Q4YmxsNVpuN1RXcGlYWGVMOTlleGMvUVVTSW1ucUhUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e8d5b-46b5-4c73-3a30-08de7e26f112
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 21:58:05.3113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLiFeuUDZ3gBN0nCjjqV+kjbMhCrwXxVzErAS+tZDmbhXCwXRP/vAIHviiPsXv687QKRc6NXqlOpFVYd0bkG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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



On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
> Add NULL pointer checks for dev->type before accessing
> dev->type->name in ISP genpd add/remove functions to
> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
> ISP driver dependencies are loaded in correct order.
> 
> The regression was introduced in kernel v7.0 where MFD ISP
> device enumeration doesn't complete by the time it is added
> to gendp. The timing of ISP device enumeration has changed
> because of the changes in registering the device sources in
> the device hierarchy.

It's a little bit pedantic; but I /think/ there are two different 
problems here with two different root causes that both happened in 7.0-rc.

As a consequence I think you should have this split out as two separate 
patches in a series linked to a Fixes tag with the reason for each of them.

> 
> Co-developed-by: Bin Du <Bin.Du@amd.com>
> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 95d26f086d545..920595f0d22ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>   MODULE_AUTHOR(DRIVER_AUTHOR);
>   MODULE_DESCRIPTION(DRIVER_DESC);
>   MODULE_LICENSE("GPL and additional rights");
> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl-amdisp");
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index b3590b33cab9e..485ecdec96184 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to add\n");
>   		goto exit;
>   	}
> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>   		goto exit;
>   	}


