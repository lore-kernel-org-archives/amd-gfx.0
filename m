Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D079DD767D8
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 15:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744F410E2E7;
	Thu, 31 Oct 2024 15:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uGODYBX3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1616B10E2E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 15:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n336JW6LxWMNmz5oU+xLx2tTbntrI0BpYmbn/kfx7n3Zlbj2VpLDUVJYC9CvJmk2OKCnBQ1ACS+fogfaCggTgDRVhGGyzCncMeBb2NrfgLsbW7zKIt0Lyl4pXGq/QoyOGyFHxMPjTbc4yYQgXFkz7IkD/7aIuTRFaU8VjD+IPUOFuG4bZchyd6fgvfl9dhq21hsO5UTuSJ2fKTaAWwrQGYWotuHyqetRyhCkEDzvezAT7kyCJYgMH4e/R9VyYC/IiDeaKdAO9F65LFTGHdqBYNMAnODInYwfKxbqIa/kkCbntpZ+QnCCwoztNF/AN7BDyhN3qp4dtvvTZ5xES6XMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuBuPDa6pc9WSQS/rQDq0d8jpvWcwn6wA2M52NrDE4A=;
 b=kPUh2xl0InCGeKzP0VsCKmRUv2KK3TCs93ab13wakFdrdasHE8GfS1HZmUkwhXE+OIeDcTEQ8LUQUZZlMsD4Oxh1a4A2AFAcZoEu8lJz1kyvqFsqrR+Xdx6ICRn+oBl0cejMhfr5vRmnPvcTdcCmCICl4+whzBK06OUmQxQuoEdaEgoAT5dpYcwe91MH7+SguYYnqvbE721j5RT/Y5+xStvW1gazwX4QH5DFSL4pVZ2rgaHYsp2XYrTtX5J3KhAJPndxRHROFQw7Ok/PnaQJSchOZkeaevU7nfiDkrVLozdbyOAh5oLPELgVsvnIsE1h3AY1/Dpsac9G2fYhnnzy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuBuPDa6pc9WSQS/rQDq0d8jpvWcwn6wA2M52NrDE4A=;
 b=uGODYBX34FEae+Dy1VPiL/z5PfqokLIadkzO5Z10zG+VZjyMpbe2iIl06VOOGuGkL72vrdSKARaYDI3PawAiqXajmZ6Ym3ZsK44m1Km5fxpQK9R0990yDEcKikwY7VU+0qFg4GA4sexInMe6ezxhI7J9sTMVGXqHbfh5XP57oqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 15:30:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:30:29 +0000
Message-ID: <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
Date: Thu, 31 Oct 2024 11:30:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241031105059.251085-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 82047639-a228-4608-2796-08dcf9c0f3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFloa2FZbERDcHIwaXM1WFE0eW0wbTAydXR2T3JOL0FjVUJmZ3RoWEFWWFU3?=
 =?utf-8?B?bU5FSXoyOEwxa2NJaTM3dUkwOTA3UlRZdER1dXo5K2lzMTlHM05JNjduQmFi?=
 =?utf-8?B?cHZmTEhZS09OQVNsNUVkd0FZLzlONTdPQ1IyUGZFZVdiVmE5RFBEdzRNeWRh?=
 =?utf-8?B?cmN2U3c3aE5iaUJldVpaOERuUVNYbjAvdW5uaEFPU1hUTS9kRmlFaWRHYXNl?=
 =?utf-8?B?Q1Q3b1JrQnBkTk1PNTErZUJpWC9XUzEvWVFiLzNmYmppUXZnZjZDNWhzeTR3?=
 =?utf-8?B?TWY4Zzl4aDlsZTg5RFNPRE4ydTdTS1FPQXJQSmU1VDNxSUpEQ0I5aUFxbmp4?=
 =?utf-8?B?dmhhU0dURVNpNXUxY2FmVHBpdVVUVVIvR2VVaE4raUp2QzZ3UXBrbnkrRzdF?=
 =?utf-8?B?WHlvL3p2U0NZKzkzMEcxTisrelIzMUZadU80SVFXREtWRVRsTHR2V040bGQ1?=
 =?utf-8?B?eFBNRVRvdE9BQkJBd2ZocEdaQ0hVODBtYVNZWFk3MERJbnV0OWxUZnNielpn?=
 =?utf-8?B?d0pPNUM0Rm45SCtmYWNFQVcvL1hPSXZhK0NKOTB6UVpuK0c2dVRwUnI1VjB4?=
 =?utf-8?B?YWlwTHJxMURBQ0tXelNaTFNqS3FpQ2VqTGxoR01lM0hNS3U4MHhqNkdtenZT?=
 =?utf-8?B?ZmxGQWFmQW1EVEN6OHlXWHFVbFc4SG1OWU1wbkp6czF2UVEyTk5UTjJrNGRi?=
 =?utf-8?B?MEVzYU1ocUU0cS9vZUtoc1d3b0NpcllOYUhrb21mQ0hwZHdiWlgxWU9odW96?=
 =?utf-8?B?UC9XaEJUa25ubVgxOTlsZ3BXczhZbWczVVJReU5DcktrWS9LQzBvc0RCVU1W?=
 =?utf-8?B?VWFMajV3dkVPYi8zK0VJZTRKQWE2cmtCd2lOaCtVa0hFWHVSbE1DMDc4R1ds?=
 =?utf-8?B?MG9UNE1oZTJHdXZhODhhTWpFWFN1b0EwcGYzOTNlUzFIODQ5bDF2YWxRaEYz?=
 =?utf-8?B?ZFByZDF1NC82T1o0em1Bazg5dW9OemVTWWo1b1ZKUTRYMHZvdXg0aHByYkpx?=
 =?utf-8?B?ZlRDOWJIMTk5dWk0aU00YU85Q0FsLzNTbzlMcTFzYWVubnVrNkx5VlFvMjBo?=
 =?utf-8?B?Z25xQkZaZUlYZktlSnhobEFiakh2cEFJQUtHVnl5SUs5UEtmcmJRR1Y5OVk4?=
 =?utf-8?B?N3Vpd05vdVE4RTF0TkRzeHZuNzBMVkVsODhlSGJNK25sUkNkK0t6RzQ2eFg0?=
 =?utf-8?B?Y3JUWVZlS2wzajJZTUVldGFUK3lma2pTWHFSQitES0RmdjgwRDhNUmV3MTdX?=
 =?utf-8?B?S01VeU0zaXdaS1Eva0FrTllIdll1dngySVh0SXgxdmYvKy95S2VFY1B6WGlv?=
 =?utf-8?B?aUtqUjQxR05XNmpaZy81bDV0MHZUeTN0SFEwV3hNSHhnTDRoRzFsNmRnc0NU?=
 =?utf-8?B?a0RFd2dCdjRKRFlnODRxNXFubFN6M3lFK0gvbWV5cVl2K29qTzJncTBOL0lJ?=
 =?utf-8?B?U3A4bE00WldHeldLaFo3cFhWZnplL3I0SGFqbzVSNW1XK0MxbVdEaWd1aUhJ?=
 =?utf-8?B?dWFzK0FROVdpUzhwLzAvTXdjZmdkTUl3Y0tMT3E5aHV2TStscTRKWjZHOGcr?=
 =?utf-8?B?YzdaeUhXVVpHN0Y2WFVpTXlMZElTYXZTVGxubklUS2U3SHB0MWRZWGJubzND?=
 =?utf-8?B?SnJFRmcyTVdabGVjY1o4SWJWaW0vdU5jb0IzQWw3bkJ1UnY5MzF3dXBOYzN2?=
 =?utf-8?B?TmgyVDFFbmdYSXZUREltSDRiSEZlZHp2dXhjeEJnaDljK2FFTXltb0s5ajlL?=
 =?utf-8?Q?G4Z2xbW149Vvfmt5/5wz8RAfFckRRNJGZRAyQE3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmUycEQwejNUcmp5emxpYzZiZ0F5QVFUalk0MkhoZmhMRmkyWjZ6RThHbHBE?=
 =?utf-8?B?NGR1WlBPZ0J4QVQ0OWdoMHBWdnJ5cjIyY0g0WVdPb2d2QlFMNHpxMFIrRkt5?=
 =?utf-8?B?bzNhbDFSZFFKSWc2T2JXMXNqaFk0bkJjN0UxUXBubHVEeUI5TGd1U1pPQzg2?=
 =?utf-8?B?V3ExUjF2V0FUbWhNd1ExZE9BUFVvVDVIRXBmdmZDdEhqRlNYamRiaXJPOU96?=
 =?utf-8?B?bWczaXpvSU9lQ3U3c1F2bU8vSlVjM3cwaHhiaExHT09PV0M4WUQ1TlBpUVRx?=
 =?utf-8?B?Y090NUp6SlRHR1kvbU1tdFF6eVNNTHRCdisxWG9VTFRIeXFHdTlQLys4R2hy?=
 =?utf-8?B?R2gwUSs3c0NReGo0SnpyY01xdDJvMEl1d3BQaFJQelVuMUJKTUhVNndxRkF1?=
 =?utf-8?B?VWNNRjJ5NXptaUprYjhkV0N5eXdZQU8xRDV5VktaOVVXSEpDNmZPWmZFcE45?=
 =?utf-8?B?SXJIY0laSzJIYmRWNVdqcUxiYWIveEUxMmFqa3BxdThScDhkTnR3SHhCYjRx?=
 =?utf-8?B?ODVuV0dwRnZESGh1TVN5Wm0rUnpIUTg5VVBCZWlNU2FRRmwvWURDWEp0UzdW?=
 =?utf-8?B?TGtrZ0l5MlZOZUo2UnJDZnJXUS9FMzRneGpZelVIVzIxbVB3bW5BNlhzZXlW?=
 =?utf-8?B?OWltN1lNb0JodnMzdmpRVnhEYURDKzB5c1JMUFJtUXAwTjFKV21JZEZuTGEv?=
 =?utf-8?B?MlZWTFVaNHZIdlFCSGN3eHJydmJPcXltUnk1VUJ0dk1XRkNGQlI0VDhNQis2?=
 =?utf-8?B?Q2tNZjBFNlJwMDhTSnZOblN6aGNGV0t1WDg5L0tINHRoQ2RrQkxJbk5DZmh4?=
 =?utf-8?B?K1lxMUZ3WmNWaUN6RFBSVVp0WElWUUlqUVdLRmhjVmY1a3UzWnJBVm0veTZC?=
 =?utf-8?B?VHo4aXlUQ3Noa0ZHcHZRVmhOSHpZRHBRaGhRaERycXZaRjE5cTU4cllobjV5?=
 =?utf-8?B?ei82R3ZVR2hLQS8vNEVTWG5rVDJBUGN0aWFVM2FIdjY1bVhyaTYrTkxVZExu?=
 =?utf-8?B?Q0F3T0k1Z2VOM085MWhwNDJLQ1hiL1lacWJtbTdXVzdsWkIrZDZab1ZsYWZx?=
 =?utf-8?B?eWRWTXBSZGUzY3krVjBEazA1b0ZQVTg0Mm91eXc0K2VmcldpUFEyOGpwSm9u?=
 =?utf-8?B?cmJoV21vSTBySWFpb2haY0hoci8rcktPa0p4SkMvdU8waC8wZ2JLRE9FUlBO?=
 =?utf-8?B?U2VoSTAvWEtHbEtCUEhmUlZyVHRaOFIxYmZ5d2Vpc250bTd0Z0s4eWxDc2J3?=
 =?utf-8?B?a0wrbStxWTVYNHpYVjJFaU1kZk1ZU0dVTS9ZblZRdk42TVF2TzhMOXpwb3Fz?=
 =?utf-8?B?Z09NTDFVNGJEa3pxUXpIREtJSy9NR0p6cWZZOE1TUnFFSzRITE9aUmU0ZU1p?=
 =?utf-8?B?U3REOUxvRUNXQ21CSU4xNnQyMzhqRE1WclpNL1k2OW43cXFyK0gwRFhROUls?=
 =?utf-8?B?MHp1UklLcExucy80ZUdWeHY3ek1NREZJUFVSMFFCTlBGSVhUbXJRN3JzbS9Z?=
 =?utf-8?B?ckVVekk4RFd2K21uUXRzbmI2anBNQ2gvUmtleW9WTnBBL1dMZU5hYWE3cUMy?=
 =?utf-8?B?YWtJM0NrQkplNGNvTVlibER2SXhaWitwVHp0T2lEbU5VcmpTTHIxbGdiYTEy?=
 =?utf-8?B?SE05WUg2MmF6T2k4RW1TNEtoNitwczRQS3BNRDdjTkRzVC9HM1dzRG43dmd6?=
 =?utf-8?B?aU1QNER3Umd6ci91Y2lMdUxrUngvSE5Pd2J1bnVWVU1TZGo5N2o1Y0oxaFk2?=
 =?utf-8?B?OEN2cEQ0bWZ1K2dHMUdlb2lGRXpIZnY0WG12YTRpUDdFeC9zdm5Sckh6QUxn?=
 =?utf-8?B?K2FnYklOQWpwYndyUU1DYnkwOXRNZFlNWnpobnZqVll0MXlvOFZKaVBEUEM5?=
 =?utf-8?B?TVRoRHJyK1RuczJjZEpCYjhLQWxLRmdtaCswVEhsNW5KTkMrb1FqdUgwaXVI?=
 =?utf-8?B?VHJreDJOekJWY3ZaZnV0N2FMK2FDSVhodzl1OVB4VnY2K0w5QWgvekZUNU0v?=
 =?utf-8?B?NVhMUUlGZGUvQ3JnTDBGL0wwMEs3WjhOVnllVWYyREN2bEx2SzIycUNuZEk4?=
 =?utf-8?B?NzRDTUhKbjRqRjVHeWJNM3NXQTViWnp0d1BicjdPbkJvNzB5NjNIMUJXVFRV?=
 =?utf-8?Q?+HdAJ+pGA3rYniSiEXN1oM8YT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82047639-a228-4608-2796-08dcf9c0f3af
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:30:29.9008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kohrjVuYnlL6k8WLfz3ydT0QhGFVMhNmACLKnGjXuULxdKFf5Z7cWdE/8Yz+tZqx842zb6fFi4KSjSf4h/tAow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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



On 2024-10-31 6:50, Zhu Lingshan wrote:
> The ioctl functions may fail, causing the args unreliable.
> Therefore, the args should not be copied to user space.
> 
> The return code provides enough information for
> error handling in user space.
> 
> This commit checks the return code of the ioctl functions
> and handles errors appropriately when they fail.

I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.

Regards,
  Felix

> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3e6b4736a7fe..a184ca0023b5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	}
>  
>  	retcode = func(filep, process, kdata);
> +	if (retcode)
> +		goto err_retcode;
>  
>  	if (cmd & IOC_OUT)
>  		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>  	if (kdata != stack_kdata)
>  		kfree(kdata);
>  
> +err_retcode:
>  	if (retcode)
>  		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>  				nr, arg, retcode);
