Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264DC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 23:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C70A10F775;
	Mon,  4 Mar 2024 23:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QfpRtc5X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68B910F775
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 23:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liqlR0dlXLbHKEpHaBkPcvrbu/4AXfeNm7n8U/5WrrRBiuZy74u2e0OL4n/cbQSmuU5upxnoLaen9GrhE8oCRmU7Pke4NZ4F5NZoO0dGuDDhOHi/EMd1si2c+50AF1tPA96CNTEDCML4z9ol6vcgHRaiZjog9KG5/bJX9rNvH3aZ2hprpFGj2sLY29tyq25PTZHiNh5vz0jOORgsiV4FZLjx3usrPs+5AgOFXvyeCE+lTuMDC0yLWzjpoK+3vW4f3ZAquIeu4phMa+Z+NNE0RX3+6jIdaOL5wg5HibNmpoz37NoFl775KqkoH0Ibf9wBXAwxRS0TzyXaWnCPOKg3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxORy50ZSbTjvyPqD9oMXsUpo5fI0S5YPLh/7Uz0o0Q=;
 b=CxyPSBeyjznf9++kfbfc9/PTRFUHg+7VdQ9wLh2wRZFq3VfArdEs5pTjw4crgs1Nin3r0Z4me0u3ay+ae+07QQRxOCasttTnjKWE3ELhD1FrpoYl5t0WiLRb+h2B50Np1kmmS5YjQhivJNznqo/x87jeo4ef1y8j/VHl5qvuBUwMRyiDaSQQxUcNSyj36LB+nQA79IJC7ytmuzD9B31yxcIh6YoiA2MdF5pFevrfuLZiQcI+jxyk3JvLnN6NkfQqLqo111k6ExwO8XKgLP12PKXPom0LVwlZn4xTZJOugRHTLbAiRcErDPMItVt1Z+iQU2CUc/L0/n62L6N3MFy6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxORy50ZSbTjvyPqD9oMXsUpo5fI0S5YPLh/7Uz0o0Q=;
 b=QfpRtc5Xcdw0Nkf3M3noU7oE9t8CmQNoF1OwnXA6MQPq6O3FdgCt4rfh6ZJRnoAARW5IVjK03M7MYZFdjLs3GqymkUiJC1XoTWbRPLwe+ut3P8nz9xx+dpXAQdLkz8XF3NcvyD4f7zchW9VW1Yh4zwhBK4VLhUAq0rxcVnSltN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 23:39:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 23:39:30 +0000
Message-ID: <d4413128-92d2-4711-ae46-36369a495868@amd.com>
Date: Mon, 4 Mar 2024 18:39:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Content-Language: en-US
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Gavin.Wan@amd.com
References: <20240304220504.367278-1-Ahmad.Rehman@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240304220504.367278-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::45) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: c75ce2cb-ef2e-4daf-f28c-08dc3ca45695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlzGh5KjMXBtwlh0rJGLn+za5SsO8AlC2OVLegSo6DtLTJyjsI/UN3SGrI77WgpTkcjApS+e/q6sb5vK0KHlIz/8buGvVcuK0lzxUv8gz70Hv/9Q72lg7JhFF8b9e2kED4Jz3fI5FXURkTjfSP8DOg0P8hUjzKDNxjnnU42Bsb3j2/OMs0vM7iqHx063bLLozRfSjb9djBUMfLUvp3Bvvi5tJHhiMXblLopoYfgzs3bOupwfzAoYwhnW4jOmQQxV8VsmJ5mUkJmd0NjDRVi1r62iJgGRD/+lmO93twinNghgifUF6mVTg4NLjyzPieMipT5nYLcYzeaq4T6aR0nzkdA50cqaTO6OktpyviYaitfHz+eEF3paKG+KzvN51xE+Nkzx5bRtrud69M5lYz/1obGHN29qV294R/pK1Dcs3wgi/eXHYIl1YE7V0Xg5HChOkvMc3I7gys7CcUIqJulG6JZPlSkDfHhXkbr5NAXuc+3M5Su+uiv8RYXsbweTTN3UUBsnVmxxwcL6icUfY1viuwJdOibJayE5ulaNHixErbBJcHAPjufYTA6I7kICUsY6G/11t2RqwgYsLjcYj3ZpBmsmakIBz5k6XX5hj7qQ0Za/SxUEG4JhFjlZDIVBZrs/S3z6kHS2D05av5WIAnKIJ4OvnLiDGWuqmKZdPoLrLyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpXbVZYNFRJYWR2ZVpTTTlTc2p0NElXZGh3RWFBcVFKdTlDYlJUY2VYNkhr?=
 =?utf-8?B?N1RWVGdEYW5RU0pqa2xZQk4vLzNNbktEQ2RMTlFORjVwWDMwOHdRZ2M0dmMx?=
 =?utf-8?B?Z1BrVitKWHJXZnRoUkt1WDJvNlBMNWowdG14WVROU1pnZFJxeStCUml0b2Vq?=
 =?utf-8?B?TWsxVWtza0lzZHhXL2JaMVQraVJsQW9zT3RwRDhjeHpEVCszSWtOZnMreFM5?=
 =?utf-8?B?WXFnZFlEWlpQOEFEbGxDdWFvZXZYNVhXOUZnc2JJellVUWFZcmRXLy8wb1dN?=
 =?utf-8?B?cUlBQkRoUm1LekJZaHN0ZERKTDZqUFFWQzVYbUNGc2J4ck1sbjg1MDhyZFlP?=
 =?utf-8?B?alA5c0dpMkUrdnd6bit3WjRDUG4zMUk1azI4TWtyV0xOVjNTR0pQU0lOV2dI?=
 =?utf-8?B?d2NaSXJYWUVYVGN3WjhtR1dwN25GOXBNL21QNWE1Y2FtY1dSQ0ZueGRZNkw0?=
 =?utf-8?B?RTMvcTQ5MVlLWG9sdnpoVlhzOTVCUk5vVXpEVmF4dWV0cDJycjFlNjE4OEZ6?=
 =?utf-8?B?TStBNFJvYUF2eUowNndZQjVqRkNnN0Fnd2lBZW9MSXNPdktPbUE4NmdGNTZo?=
 =?utf-8?B?MFVsbyt6NHpUWXAyT1RiSTZ4WFR2ZVNLczZOZWJvbHh0dFoxcGViS01MV2xw?=
 =?utf-8?B?TkNUQnN4YzRzTFRTL2FOci9XVzFUbUk2UEh5WmxLaVU5dE8vZmhQeWc2bUI2?=
 =?utf-8?B?Q3pZUjhaZkhaK3I5cTlrVml3dTVVWUxYc2s5MFJvdkZLNktZSHZoT3BSckEx?=
 =?utf-8?B?Mk12bW9TYjlBK1pnWDhNZ3hWeFFsOUNveUFBY3JjZUQ3Tm96QmpZdXcwYnp2?=
 =?utf-8?B?RHVoOXlRMHhkN0laZVd2MFg2Ym1qZC9XTVYwZUJYbCtKWnI4elloZ2hqeG9W?=
 =?utf-8?B?Y0JoVlZ4VzNBaDVpWi93WU84c2JFdndMMnNyWDFVMHppTWpLemVldW9DcFcz?=
 =?utf-8?B?TktWbUYyUjAvUVYyb0JRdFh2ekZNM3l4cW5QMFk2SkxQd0taSWJMSVRvQloz?=
 =?utf-8?B?QjhoSVVuY3Y1V0tuOThpclQ4bkdSVGRMeS9rL3ZxUzlPbG1FSzN0d1dZWW5O?=
 =?utf-8?B?UjNNYjAycWJzdnlDcWRMTHlqQWR0NWtkVTFIMllBKzNidEtVUVB2RU5Kdkgw?=
 =?utf-8?B?QzJMdXJvZVNObzlpcFFrQURUSXh4VFNpdVBadVY5bnFqK2htQ0d6cDJJREY4?=
 =?utf-8?B?dTVteFprekFZbmRrMDdzT0trNkN5R3NSS2x6cDhodkJ3ZmRSK2s1SEZ6SSt3?=
 =?utf-8?B?alRHUEEwczJsZ2IrbnZDQkxDbHFNb3dLVHFYaU1MSkxwSWRRRGZqdG1VQm1m?=
 =?utf-8?B?amVRWGVEYkdhckxvMWp4VU0ra0ZiZXphRFlialBLQnEwNExpME1nZitOUG14?=
 =?utf-8?B?WTVDZWN1VzJlcXViY1loN3pQN2ZGZnNRMHlDWkZnWnUwTDF4RUgvdXFHNUkx?=
 =?utf-8?B?MHVRZVFuUldmT3FtMHc2bVVKZUp1NU1DckhlUXVIZ1Q1NzZ5NXpiMFJBZTVK?=
 =?utf-8?B?VWc0THZXNUd0K09td0ljRjA2NEMzeU54SlpHWjFpSEl1Z2JuR1VBN1JzSERS?=
 =?utf-8?B?dUJrZllMR2J5ZEN3VGpyUTE3cncrQUhGczVVUGI1RTMwT0JiMzU1NnorY0Zj?=
 =?utf-8?B?YmRDMzY5dVBuVEt4MHdlTXlMbnVJRFIxeDdSbGZiUWFNMXhlOThjdFFYbGpy?=
 =?utf-8?B?Wi9pWklvcWlnbDBKQVMxdmV0QWo3MWlhRHJxR3ZwSjZ6YlFhcU9DaUFxc3I5?=
 =?utf-8?B?WDJXTzFYZzV6U05ZNTdpZjVZdHdIWTNFcEFnMG5pL1VjSlNjN0wxOXZnRHcx?=
 =?utf-8?B?ald0QmNjbFR5Vi9jenRQaDlUNWVzRWRnSVA5ak5memUzK1NMRXV3L3laSXVL?=
 =?utf-8?B?NjQ3dWxEZzlzMGZTSFV5TitoTnUvS3BqSHpuTzBIWGQySmNJUHpKODUzakF5?=
 =?utf-8?B?emVleXQ3SHlQMW5oaWRjWktxMll2dG1HZjA4S0hxbjFnbDJNdEprNmlSanY0?=
 =?utf-8?B?MHl4dmcrT1FIMVlFNDgzRGI1NlduWkc1OUhod1BFVC9tUnlCZStNOWdWY21l?=
 =?utf-8?B?S1BlL3B5ZzNYOE9DNUd3dWcwUE13NW91dnZESTNpSDZDNndpcXI4NjVveE9r?=
 =?utf-8?Q?nudkeu1tneS+L2Cbo+8TZRPrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75ce2cb-ef2e-4daf-f28c-08dc3ca45695
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:39:30.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLgPI27IGYo3t7vp35uvw+g4Zh1gPTtdGVwQTNWK1hoeSw377cNimFumUquCUbb5RcDlpDnOK+Zx44EfFNuQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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


On 2024-03-04 17:05, Ahmad Rehman wrote:
> In passthrough environment, when amdgpu is reloaded after unload, mode-1
> is triggered after initializing the necessary IPs, That init does not
> include KFD, and KFD init waits until the reset is completed. KFD init
> is called in the reset handler, but in this case, the zone device and
> drm client is not initialized, causing app to create kernel panic.
>
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 15b188aaf681..80b9642f2bc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>   	}
>   	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>   		adev = mgpu_info.gpu_ins[i].adev;
> -		if (!adev->kfd.init_complete)
> +		if (!adev->kfd.init_complete) {
> +			kgd2kfd_init_zone_device(adev);
>   			amdgpu_amdkfd_device_init(adev);
> +			amdgpu_amdkfd_drm_client_create(adev);
I don't see what's preventing the DRM client initialization in the 
reset-on-driver-load case. It only needs to be created once and that 
happens in amdgpu_pci_probe. Am I missing anything?

Regards,
   Felix


> +		}
>   		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>   	}
>   }
