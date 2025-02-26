Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF814C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 22:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3FD10E9E2;
	Wed, 26 Feb 2025 22:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mA5GtA0o";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33EF10E9E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 22:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1wqZLx8qcasHRAPj5lY20Lqgukc1dAdXUF0xlUzEYa3rcT3eaY8e7ptGMfFMyHY5Wxdpcies8ixO3k9MT9JwRRs9vfHPJDBYSYf4iOeB7tEokX+I/2YA2QNveYI62KvVz3QpLaHdgzEF9yCYQDrJUG+ESbE/DkvtsMiqEDiZAY029lNj/n3CGaT0tAmKacjmKKelNBrlWFa6Lyf2bThgvvlWJRvZm6elsu/J7W39BD8d684S8B/fjEgzuks8zZWPvCzIR5UGdt0Nu1hLvq2oE0iUpkKwbKd9sRa+9cjTUQ+nHCVQ/w3aLRhLUAWWjYpNuBlq9wsTb5FULFEswx81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWWq8U0O/8qydLow1QrBNwP3mmGNqKH0bax0stKveqc=;
 b=Ttg64cSdRhcSOg6aV3X/IIuzeYlINhkqjPo7MZSV4mtOUETqSaRrcsgR5DizNecDAblufG63XCreaokkfllBiWx7XjDrxjdcGLAwTCTG8zCDcHbnL49MV5txypThbgf+Klgc83ll+pviqchkK2GxEhBjzt8coZDQzYUE7zu/QBiob/ABERSlLXUMZsDjMRRNzjzMmFynfQa4Pui/VXalWI8fhSSZhcc7bfvRDUc+VD3xKMNJz0j4ObNJKoIUCXI6wGMR3feZw/DPz+7TmOQoWJ7zCurbAYcp20xn19LaEhYtY6+2YrixTc5Udcwt330NpkoMO/qHuNrot0ZVdEFVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWWq8U0O/8qydLow1QrBNwP3mmGNqKH0bax0stKveqc=;
 b=mA5GtA0oa2NcouwqVXNx6Y2jARnPRxzMctIzLDhkQw8Ah8+1MRNrfSrrlS74RLCylp4Dic/lQf2I5huaukMFxzu/T1f2UVPzm30pj3r6yhtZz9OsOdBgsw2P7IioZuJFiPwwnDADVFh73b/Xm8STijX9Yks64JwNVMNT58zB9uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PPFD78AA37BB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 22:15:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 22:15:18 +0000
Message-ID: <1dcb8478-f139-dcd0-b57f-8c13afd2b410@amd.com>
Date: Wed, 26 Feb 2025 17:15:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: clamp queue size to minimum
Content-Language: en-US
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, jay.cornwall@amd.com
References: <20250226024132.613233-1-David.YatSin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250226024132.613233-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PPFD78AA37BB:EE_
X-MS-Office365-Filtering-Correlation-Id: d7567640-6aab-42d8-d0df-08dd56b30dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUU1K1NMaCtxcmQ3N1NiMmdwNVZNb3FLM1dmT0d2TWFRRG9wNDF1S2JRUU9C?=
 =?utf-8?B?d1pHalNEZTBpMUVKT1paMEF2a3Jacno2c3YrbUEvSGZkUk5uRDRmVXNNNEdZ?=
 =?utf-8?B?ZUlETlduOG5uQkQxRHJFSXhRRWtTSG4zcXBIRlBRREt4NlZoTU9scHlzaWVE?=
 =?utf-8?B?SWZoMEw3MlhLTk93T0dBSXlLSkd0aXFhVlpLVEpibS9CcSt1WWszZGwzY3lD?=
 =?utf-8?B?bDN3cEFMMUd1d2NvallVY0g2U2N1K2FQNUU1cXBhclZnY3VtNXpROGxhYm1C?=
 =?utf-8?B?ak1sWW5RbHoxNGNXTHBpYWd3RGlTUWNSeEdESVBzMWgrd1haWG5wNXBiS0o2?=
 =?utf-8?B?akRBWUhMM2I0MHZldS9BYy83ay9tYnBCMG9wMmh0TG9ENmVRRERmemJGSjJG?=
 =?utf-8?B?bGcwZ3c0L2taUFIxdXJLUm42SG1iSE5OZUxYK1VnQlZXZEhlU1UwRnNvMGhw?=
 =?utf-8?B?NjZMS25FWDBkVi91NFlGcEtuZTM2YmI4ZWpWQnJqQWVmdjV5QW9MY3FISkE5?=
 =?utf-8?B?NFlnU3gvRkJsQVNaTk5uMkg3Nlc5WG5oSW9QdWQ4RkdZdXBYMkpDd0NEb3ZM?=
 =?utf-8?B?M3lsbFNscFltVkhiZFBaZ0oxcTVqa2tnN0U0V1p2UXNVVSt5ZG5Xcllob2lQ?=
 =?utf-8?B?WWtHWTJEMzNhSTVOYmhuSGdoaVVBVG84Q2ZscU5tOVYrWlhMczlkUWpsak9h?=
 =?utf-8?B?empMSis4OE9tMWFydXlFSHNRUEtRMVpQMzVocFZLR2dXOHRIdCtDOUw1cldI?=
 =?utf-8?B?Yk9BMHVUSDdTU3ZsbmNCamQwVlRQZmo4VFNScWI3R2dqZWtBYllBNlhrQWZE?=
 =?utf-8?B?dkQxc1AybXB5M3R0dlozWUtIYnZpdzlaYm9WRkdyUE9Id2I4SE1WeGJFd2JB?=
 =?utf-8?B?THhHWm4rMVhTNnRkdWhnL3NMd2IwTDZMVnJMUjA5SnVhRXlVa3dTRmZkQTlj?=
 =?utf-8?B?eFh2TzJ1NDUrVWpTeDJRV0UrWEJ0ZDRLQ2JURCt1TU5MWFhWWCtyYTNLNTVu?=
 =?utf-8?B?NDNQNmttNmdJYnpOVWw5dG1nbSthaFZScnpxNFVhZ3VEam0zbUNHaVNlVjYx?=
 =?utf-8?B?dUo4bFU1blJNQkVNVWRhcVd0RWhqY2hXaTNtdjFPTkNucC9HUzBCcUhFSmRF?=
 =?utf-8?B?c2l2TXAyMlJvbVZNZkRPZU13bkhPaTlDNGJBaU5UMFdpYTZYNUhLdCtsZ0tx?=
 =?utf-8?B?dGN2SldMOE8yc2tSckFSNUdtcVU0ZDJGV2dIVUhkaitRZkpqZjdVNXdub0Jw?=
 =?utf-8?B?aFZCaFp3Nm8xeFVCT0hqY1BrMmJlYTNwclkyVzBYd1MzRHpuN0V1T1pScnVS?=
 =?utf-8?B?OWgrL2NBTk9YL1Y0NEVVeHZweVhTSVpOTituMVRhTDZ3L2ZRNytVdERwWVZU?=
 =?utf-8?B?d1VBTkdZbTRnckF3bzFnRlVuaTl0WkV0WlRtY2hGSU5XNloxNGJxTkxlMkNl?=
 =?utf-8?B?b0h3dCtaTEhSVjhaM09tZ2dIM1YzQ2d6ZmhPMnA3ekdPSXc2YU9kejRhb2Jo?=
 =?utf-8?B?WktGMDIrTCtWTnVhZTM5QzRmN1czR0FaamNuRWhoNHBWODVjOXVVSU1DNm94?=
 =?utf-8?B?RUIvUHA2c2N3RC8rVVVKSFZ4N1BHeFVMUjJCcTRsaXJzak9LOTJMRm1NeUJ6?=
 =?utf-8?B?N3hRRkZnZ3ZiTWoxUG9HVElmWnpQZFpCUno4cDl1VTdVNmRxQitlb3JwVm1U?=
 =?utf-8?B?eEl1U1ZnMlFIWm9PM1NYUEtRMXdtZUg1aldGT2dBcmhnNlYxRk9GUVNteVdF?=
 =?utf-8?B?UG1MMENaNHlFY3NpSkZIYmk3Ymd5dXVvWnBUZXNvTEJZNlZGT1dFSGVWNDBn?=
 =?utf-8?B?aGxVYjZlOTdDL2Y0aFdyTUlXMHRaNmg1bFlReXZRMzVZWEFJTWFmQUVKTlJh?=
 =?utf-8?Q?mMRL2DC07LqgG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slc0NGVlSjNhWEQwVWhnVWR5dzBhakFsS0VUYXdtOTFsNlh5d1VVdmp0ZTl3?=
 =?utf-8?B?UHpiTlpDcy9wbDhYVTRxZmR3TXlJVEErRGNpZ01xZ0dkTXRZTzkraHhKazFW?=
 =?utf-8?B?RGNXVFhta2k5SmxnSVloUUxSZ3lyZG8xSHNuMWh2OVIwd1JCWVhXeXRkRFkw?=
 =?utf-8?B?Nnpjc1k2TmN2Z0ZGcGFzKzdFQ1NBM2RmUFBHNmd0d1JxNHE1RWwwYk9lOUt0?=
 =?utf-8?B?aXY4TXNraENINXRoa2NXNlFkOE9nalZqUHRNOWhYTUxKdzlPcEllQWgrcVUx?=
 =?utf-8?B?dGJsancwejNzZkp0MDZza3VLSmp2Z2M3L0t5RVJlYkhnMEg0Y042Rjh5a2k0?=
 =?utf-8?B?c3lNQWx1QXZpWFhvQ1NVbThFK1RjUVBGeCt3OEFCQjlwV2VjVjdhVDN5eHA4?=
 =?utf-8?B?aitMWTJ5bFJRSkFFUzQxN2xzTDJUNXNBQ3U5N3A0TTRPYjJWaHR2dktPZVNV?=
 =?utf-8?B?TkNKWU9SY0RuYWxQSU5LTHBNNmJaNlJNMVBodnlIczNvZjJuempTN3ZkWWZH?=
 =?utf-8?B?TVJKU0t2SHg2R1hRcE1NQmxrZ2ZBa2p0ekhKY01xc08zcTFLd3hnUzkwWGF4?=
 =?utf-8?B?RjFPUlkyVUQ4UVZRMTdFaStiNGtwK09VTTY2YndQVmtvTWVHSFBkVk93THRB?=
 =?utf-8?B?RTRRWEdrWFJEVHJpK051Wlo3SG1mN2V1SURNSzJ3S3BnT3hqM0VHUVJWRUhM?=
 =?utf-8?B?ZWxUVE1oYjFueEd5RW1jMG0vclJMbzNFbndHMmExR21nc0Z5ZHVTRkR3UEVp?=
 =?utf-8?B?Ykx3cHBRazdpTW52QWI3M3FNR1NVdTBrZGNucnFmMDlZNkR4ZFdLWlFqS285?=
 =?utf-8?B?TWJhV2V4MCs0OXhqMFRVWnZVWjRxNm1OamdZcTVldWlsWm94RFAxVk5LZlhP?=
 =?utf-8?B?TDd1OXdKOW5rU3cxeCtGTTRlaVkwSEp0YlhhSVVXUHVaa2RwT0pNUFhQaG5h?=
 =?utf-8?B?VmhUTHo3dXlKU0tTcURGSU5zaEptaHVnQVFmOTlRV28xYVVmeHZZbmgzSUVw?=
 =?utf-8?B?ZStndGdKZ3llY1htMm54NTdUVWRMNWw5TW9GMkhyRUVqWEpyOXduUjRaV09C?=
 =?utf-8?B?OGdwcW1SUHNTSEJIMDVYdnZITEkySm9mRzFoMnYraXVmRFRYOEtJSzBMSEtx?=
 =?utf-8?B?cVhYekZKZitkanVIZEprVDlmVkR3ZlQ3b0ZabDh2aEk1cktRdEo2eXVlOGdE?=
 =?utf-8?B?NXczWHFNMTNyZ1kwaTJrSUxaOUxLYnhUcW9oSVFZeWJTa1ZUb0Y5bi9pYnZH?=
 =?utf-8?B?NFZIemFpdTc4NlZQeE1sZWlIOWhDemM5azhhRDdXNHVoOVhZZnhKZTJQUlpE?=
 =?utf-8?B?TW8zbWpUa0RkeUFMcWc2b0h1Qk84UEJYRktnRjEyQ3JvbXFBb3pDaDRlOS92?=
 =?utf-8?B?enZUbG03NnJsWjdlR2lxOEpZc1ltU3RJaisxemQyV0xEN29ZYmtUUjFLOHlu?=
 =?utf-8?B?b1BZQVlWcW56ZXFtek94cW16alVhVFRLVHJwUlNCMjFrSXU0OUhOb0Z5LzND?=
 =?utf-8?B?NGx1V1NmcGY0dU1sSGR1a1lvYVR2c2w5aU11TlNIbFV5c2lYbVNLcUtrRU4v?=
 =?utf-8?B?dEhtOXhqVVJ1M0U3elV0eitEaSt5TmlzcldRZjRUREY2ZWhEaU5BU3RBUWl5?=
 =?utf-8?B?NGIvdzYxZ3MrcGtabVptM3RrQ0c5Q2hSZmVHaFh0TlVYUXpucmV4VFZ5dWtj?=
 =?utf-8?B?ZmdrZmQwMGxKWnRiemtuVUJPWDljYUlBUEo0dlhhYkNOdUl1R1poRjZxTFA3?=
 =?utf-8?B?aEJ0aWNuc015MVBoSUZ6TWhSazBXRkJkdEkxb0FzZCs4RGhPc0hCVEIxUXc1?=
 =?utf-8?B?dnpFTEJZVXZtK2VBYXhKTDBWN203OURkMDFjSThDRm1ieWUzN0FQUEFVRzV6?=
 =?utf-8?B?dEpqK3JWa2laQ0NnQmRoNWJpZ2NpVWtOSlZadU5MOHlxS0l3YS9TQ3FGTlJY?=
 =?utf-8?B?YnlCTkNsQmQ4cjd5S3l4MmZKRVpna2dvZlBPcm1ld0g2QVVZU2FiWXNkVUkr?=
 =?utf-8?B?bEQ4L1FSU3ZpL28waXA0RTRMM2FOcEgrcGIzcTZFeHVML2xRMEh5N3VqNDBB?=
 =?utf-8?B?b0xUQmFJMGJ2Mnh0eWJqbGJMdzVmQXo5LzhWOVdzYWJkcEppVSszeExiV05D?=
 =?utf-8?Q?bvmw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7567640-6aab-42d8-d0df-08dd56b30dc5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:15:18.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //3wxHS9mbg3tG0zQxkbPbokpMe3rn7WJCwtlhZ89kEdg6JWYIe94D4acuo5NW0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD78AA37BB
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


On 2025-02-25 21:41, David Yat Sin wrote:
> If queue size is less than minimum, clamp it to minimum to prevent
> underflow when writing queue mqd.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 ++++
>   include/uapi/linux/kfd_ioctl.h           | 2 ++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 433de9e9a77e..e90c3d1c8f8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -212,6 +212,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   		return -EINVAL;
>   	}
>   
> +	args->ring_size = max(args->ring_size, KFD_MIN_QUEUE_RING_SIZE);
> +
>   	if (!access_ok((const void __user *) args->read_pointer_address,
>   			sizeof(uint32_t))) {
>   		pr_err("Can't access read pointer\n");
> @@ -461,6 +463,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>   		return -EINVAL;
>   	}
>   
> +	args->ring_size = max(args->ring_size, KFD_MIN_QUEUE_RING_SIZE);
> +
>   	properties.queue_address = args->ring_base_address;
>   	properties.queue_size = args->ring_size;
>   	properties.queue_percent = args->queue_percentage & 0xFF;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index fa9f9846b88e..b0160b09987c 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -62,6 +62,8 @@ struct kfd_ioctl_get_version_args {
>   #define KFD_MAX_QUEUE_PERCENTAGE	100
>   #define KFD_MAX_QUEUE_PRIORITY		15
>   
> +#define KFD_MIN_QUEUE_RING_SIZE		1024
> +

Maybe set to 4096, because hsaKmtAllocMemory and hsaKmtMapMemoryToGPU 
requires page_align size, it is impossible to use 1KB ring buffer.

This can pass user queue validation now because we skip the ring_bo size 
checking as (expected_size >> AMDGPU_GPU_PAGE_SHIFT) is 0.

Regards,

Philip

>   struct kfd_ioctl_create_queue_args {
>   	__u64 ring_base_address;	/* to KFD */
>   	__u64 write_pointer_address;	/* from KFD */
