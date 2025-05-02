Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95194C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 19:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21310E1B0;
	Fri,  2 May 2025 19:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47DZfQmz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF76410E1B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 19:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTggxS4LL0UEV4SJBTbJht+u13Nlw9+b0dPXMedBz1jVJTmTCThk0EVhwwaVfhLzDZcBDdiE6V8d2JuwNpHO60iIgE1uenpenvRp3kiTQzHAafqSppbq2dn7D6sx16gpudSTJAzBqpTD2/fJz07Jd4UHW5XS1scrbZYNXQN09d0abEAFQjD18CvmKRWhsHPAo1sj80F+rZdvS0d0Ck+Co/ZuNP6xXc0HTymyKAShnAHks1UkBmzhjsNUSg5F8uDEvgFB7cuv4tA/EAR8nTtnJYUx5Cp2RGyvHuqHiRbKgM6AI40YeWJL2NAtkm1nZf3qGCr55UQviC2+tGnEze/4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdfM/alXJClBZUC4xLKxrYPVAk/X4OZbL6A0AzUX87s=;
 b=yEbUbiw5XyCno47DbPfyn1vfp3Otr7vE7Z5sAvCwf7A9sDWjEm5Din+aMh0U88NpFw7YG+A04HENubSmUG73nNBwEUNA9LSLqgd4P2Xgq4owPN0OB+abmuHiEgBLgZp8FhFTYbfHbUnlPoPs4QlBPQ6cVT0SQKKF8d3dXsXfD4L6KdF7LAOpZWuJXCmK2Zy/nomxInkuwTOImkTt7M728SEIBKOLav5b4v5rIejfbZYCOGFPQGSF34ahGobInBaCikTwrkK9FwMOqQHJOwrDjINU+ngM03MTiSpt2R6q9TL26oZb0heqfNrsSup4HxIZi0Le41MxLzAG4khO5h8Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdfM/alXJClBZUC4xLKxrYPVAk/X4OZbL6A0AzUX87s=;
 b=47DZfQmzrEgzWoiAkuQhecIjGBisx/sTjbVKcjMqU44+Oh9Uq1EoCIkRvOJxLRDCRigBCKfNAsCdUHvb3C9jGjypkqxbVrtdvH+YwReeXFRBNOkSj8RJeMfghfdIbaU9PYQdpd5iCbeYP4bFLk7wtsIbTTz0gERc3eweqFONGPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 19:28:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 19:28:21 +0000
Message-ID: <b9884f1d-91fd-4b0c-9a81-acc5bd53c891@amd.com>
Date: Fri, 2 May 2025 14:28:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250501200931.358989-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0053.namprd12.prod.outlook.com
 (2603:10b6:802:20::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a95c3c-afc1-4f8b-dfec-08dd89af7f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3JJbVUrWE0rWU12NUJlZGl5NzJZNEVQVTh5TVZrRm5JUnllclhraS9vdTVX?=
 =?utf-8?B?MDB5T1d5Mnh6NVpjSzZ3a281NTA1QkQ3QnkxNThsQWxVeXFtVHljQk1JWmRT?=
 =?utf-8?B?Y3lFbUl0YzJabjBkSXJmY0c2VDh6VnBsZmxUeHZSTmxsejZEek9INksvN1pV?=
 =?utf-8?B?NmJuQjYvRDg4OWNyZDdHZXlCTnhTTHcrM2pXOXRYS2pTMUNKZDJjaFZsNDg1?=
 =?utf-8?B?UXQzbzlNcGIrVEd6V09qbDJJRURNRTFYM0JEb2tVd2txUG9SM0RRTGF5Yksy?=
 =?utf-8?B?Qmx3S0paUXNwNEpLVWlHR3pnOEpra0FkUFVSZHFmNXZZV0pZSDdRMHVtbEFw?=
 =?utf-8?B?YUtTZWJzeE1MWU9PVFBqTVVnRXRuTnNXZmF2RXRWdm9CVkxhRkRkWElFcU9S?=
 =?utf-8?B?aFl4ekEvTnRjVzNnbWRuWGg2V24vSlMxdE80RmdaTmVVUDlpUWhjRWIxNmYx?=
 =?utf-8?B?WGRXaFB3cUhZYUJ5LzJIR3lTZXpQOHkwUHVCajU2bGV1aklWeWZVNFI5YnJs?=
 =?utf-8?B?ajZ6bjV6enJrcjEydW1WUnFUL0Z0SDZIYW81Ti8ybXRHdERDeVB2ZjJjQXVN?=
 =?utf-8?B?dlFYNjZYUDVwYWVEdG5FcVpiWStHbHlRNmMvWk8zVC9jdGloYzVpUm9nT2tI?=
 =?utf-8?B?ZDF2d0RCZVFkRTgzcUFYQ01hLy9WMS84MEdCbEt5UXFRSURCUXBSc2Jzdmk2?=
 =?utf-8?B?WFhaOExLN25TbldqMGtRRnBtOE9lUVp4eXJPRmpoM0RvOEkvWktFblhmYXZi?=
 =?utf-8?B?bDMyZ3U3Y1BSUDgrVVlUVU1MRmcrY2xZSW5jRzVvdlljNlRxaXRPS3N4NFlp?=
 =?utf-8?B?S0YyNzhhMnlDM3dRM1BCektaMEkyZy96SnJJZ21ma1dsWXdOdEJtTWdzdC9X?=
 =?utf-8?B?c2NpSlU5WFlyZW1Vd041UDVyZnpFYVB0UjNVMml5TEo3eWgyc0dEemZ0bFpz?=
 =?utf-8?B?YjNVRVNFSURRVlVQNlRzbkZYTElQTVgwSTIvemV3MTFheXdnWnRjRlh3Wk4w?=
 =?utf-8?B?ZEluR0NWNE5YWjlpeVdWVlZrak1XUC9OTGRZNTNkaStibm93N0Vqb0R0Tmo0?=
 =?utf-8?B?czJtRnZFd3hvU01wUGZFWGNETGNzMjhOM2FXd2dTQ3BvRURrSDlxMlFsaTls?=
 =?utf-8?B?RTJKZkNsQWZEeExYMUZvbEVyMEU0b1NtSW5HRG4ycm9UcG1JZEhrV1h2SFlV?=
 =?utf-8?B?MU0yVXplZGllVDdiSU96Y2dISGtmKzI0dVdaampDVThTYlRabzQva3pzV3dG?=
 =?utf-8?B?NFJRRG91N25odjU1Q1JSZC96TFNTQlBlQjVmZjF6MUFIMzVVbXdnZG5jZ3cv?=
 =?utf-8?B?eE1zeW9FRU5oeUlRSXJDSWRjWkNtY2hZMWlmdmUveVZGbVV3VU9Uc2hIYmlr?=
 =?utf-8?B?SEY4bXpFWVhhVjlabGp0RXhOY0hwQ1I4QWRBa0tQV3N1eFZUMSs3S3RJR3p3?=
 =?utf-8?B?aUZVUjJsWUpiS1BKQmxvNHFzNjRDak9uTHVsRmdnVzc3V1hDc3BxR1AxRTI2?=
 =?utf-8?B?S2FOVkpJbks1T0QzbC9Yd2QwUlJSNmFmem1tSi9wZnEvdDJ6TXlQMWFJWEdM?=
 =?utf-8?B?WVdSS3ZmMlFyNVdneDNtNzFCTXpGTkpkblZjU1NYbjd1NWZDYnFZeU5jaUdS?=
 =?utf-8?B?QmowcFZUNUpUN20xN2NpRm1VSTVkMU9RVGttbkt0TExJRHFuNGlrMUNsM1Rx?=
 =?utf-8?B?dUducE1kREx2WWMzWHE1VjZjTzB2RmNEaVBOdkpHYVAwMlUvcytDRENsd0RF?=
 =?utf-8?B?eTBqVWt0N0QyMytFUlBUYkdZQTErM0lHRHN4WjA5Nm5MUnVXVUp1REFTN3hN?=
 =?utf-8?Q?cKihGzNS8JUqg6zyiXFxwBJbPozM5Fnnh7VqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NiWkFTRTkrNUUxd3lBNVhnWDFGMWlnZ0E3RndMak9Mam5Ta3JEK084Q2k5?=
 =?utf-8?B?M0RRK01GZzFmQXBMbFQ3UklhcGo4NFYydzJCT3N3ejZPaHBseWhITGdCNmhQ?=
 =?utf-8?B?dEY1Nlo1ZjV3U1hwTnMxWnJIT1pRREhvN2ZHdnBoREUra0lEdHVFV0UxcVR4?=
 =?utf-8?B?S3FPcTcvKytyOEhheTZsakNTbUs2NFNHQW9zWUlXLyszd3JPSS9iK1M4VUNz?=
 =?utf-8?B?dWErK1JyVDhGOW43Y3NsTkg4RzJ0K2lYclllRU0wNGU0a3lhWndNcEE3UHhz?=
 =?utf-8?B?QTZlYjlDclpnTHRVdWtlK0ZzVFA2M0oyQzkyWk5ncUdLcXdDSGxyYStNcGpR?=
 =?utf-8?B?VkR2UFQ2eTBkM0xvVkRoSHZVM2Rxc0xISUVVUWxWOXQ1Ykg1UDYvdndwdFNU?=
 =?utf-8?B?MkN3WHVOK0NWUWRmcmp5QVhtNlZVT2tJaEZWTlpqVnBsRjBYblZRTWFWV3JU?=
 =?utf-8?B?dzRlVmJNRFlWak1nVEZyNXZhOHFSbUdKSTFjV25HRUM1bTJQR3dzTmR3eXZ3?=
 =?utf-8?B?QklldGJWaFJmdU9YWGhDeEpEOHEzVWcwQ2NseTlRMnNwcHhLWVN4cDVEWUh6?=
 =?utf-8?B?bXkxUWFiUjBqa2dOdld6dEMwajU4ZjlFQlMwYi9TSVdIOTFYRmxTR0FaZ0hC?=
 =?utf-8?B?NVZha0xxcXdNOFMzQ0l5VEJaTWxqMC84MC90MkNVTTZZTVFWNzdwOXFYVnJD?=
 =?utf-8?B?TnNhTkVHa0FVUEVuVTdZNkZUOURCRG1zSTJOZzd0TmxqR1hLWCtFY0orQVpj?=
 =?utf-8?B?cTl2TENZODRKRHpMK01KMkFlWEJaOVBjL2RYdWpaM1F4VWwxRlhtMUZYMjZG?=
 =?utf-8?B?d0J0WWJxQldDY0xyaE1ySWExVWxWNjYxWktDbXNwWHVyT1Bzc1k1Sng5empB?=
 =?utf-8?B?WmJQNUNXVnlWTHN2V1N6akFSVEJDWERVZDFocmNrSTZQSC96bnhybkphaW0z?=
 =?utf-8?B?bGVZYzFOS2VGNUQ0eFB5a2tzL0g1dUh3YWxWZ0dxeWNXZjNIQ092alc4bkg5?=
 =?utf-8?B?K0pnWTRkMmFrb1NwR01oVWY3Um1qMXIwVEhZTnlQeEJ6SW00Sm12d2VnV0Rw?=
 =?utf-8?B?RndHL0Z0SWhlcUFQbmtWUUlHZGJUSWt2THNRYWlhMEJMVGQ1RHlzZEhZNlVH?=
 =?utf-8?B?VWtGVHdqUnZPYUJqWHJyUGoyUWJzZDJrSHFUUFJibnc5RG15b0ZBSy9USkRr?=
 =?utf-8?B?dUlnYUlJZEtpMmdlNFBPY3FnT0F4RDhoMDJXQmJLOUIzWWhNbDNIa0JpdHpB?=
 =?utf-8?B?eDRHeEs2eVVsNHFZRTQ0aUhaNm5LcitEdHdjUndjaEgrZGlROHJ0RWR6TE1n?=
 =?utf-8?B?L0xyekUzK1lUZmRtM3M1TWpBdUxEd20yalRqTnJ6d25mUG04VWd3elJ3K0po?=
 =?utf-8?B?K21GdERJbWxqL2dVSkFGR3lwUmxEQ3VvVmRkdEs5bUpkQXZVTVBsaWRscm9y?=
 =?utf-8?B?WGdYNGhKbnFLdklXNTEyb2FiNmlRa3ppRU1VOVI5bVhPa0RTOUxHN3lhbTZH?=
 =?utf-8?B?Unp2aU9UWmtuZ0VnR25LaS9qU0lGd0N6d0xQbnZ1cVQxTGtiWU15b0NHQVA4?=
 =?utf-8?B?UzUzYjFtcll2NDBPS0Vsem1kWVRPS0V3RmpkRzBkWGczVkRhOEhIbVA5MWVF?=
 =?utf-8?B?dU5YVVRMMHlVTDJLZSs2RWFsTGJWZ1ZKd00xUWtjMVNUSVJLMEgxeUVmaUxW?=
 =?utf-8?B?ZHJjL056MUEzNk1kZEdpVml4dytNYmpjNVNWWDRiT2RwTnZkUzljVVVaUU0y?=
 =?utf-8?B?R3lsRFFXazc3OE5UTmZmUWVqbUFEbWdNTytlYUhCTWU4QXhPMGVHQTRDVFYz?=
 =?utf-8?B?ZTV4czNFcU01dGlSSjNIdmRxVkJXTXlrMHc4M3E3czRTa3dsVWVFUk1hSUJx?=
 =?utf-8?B?YUQrL0dnRWx0b0dod3ppTVlHSU1Rd0RITkNrK1pSRnN3WTdNWC9LZitzWmxL?=
 =?utf-8?B?Z1VHQUJBaHViRlJvR21mUHFnV3drRERUY0xCQ0xIVW1nYmQ4S0wzakYrN0RJ?=
 =?utf-8?B?SzMvMFA5MGRxZlhyblFjVnJXdTZLU0N6Z2VjS29yRkpCYkZQRjdyazdQTmVN?=
 =?utf-8?B?R2JXV05Ca1JybStnRndoNHVqNHR5ZGdwK04wMnZ1VFNOUHR1ekE5TnFGelha?=
 =?utf-8?Q?3igyFV1Zt3xfZzXkzAhC+0c+I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a95c3c-afc1-4f8b-dfec-08dd89af7f86
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:28:21.0171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1bshdXqNGRR0ykkhsOmPGusI7ZHmiArn1eJvvBlCOxEwEVvqzkjpw0x3t/80mA1OgWhH0Hz6bnZGjhwwTiKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

On 5/1/2025 3:09 PM, Alex Deucher wrote:
> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
> the resource evictions properly in pm prepare based on whether
> we are suspending or hibernating.  Drop the eviction as processes
> are not frozen at this time, we we can end up getting stuck trying
> to evict VRAM while applications continue to submit work which
> causes the buffers to get pulled back into VRAM.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
>   2 files changed, 15 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71d95f16067a4..d232e4a26d7bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>    * @data: data
>    *
>    * This function is called when the system is about to suspend or hibernate.
> - * It is used to evict resources from the device before the system goes to
> - * sleep while there is still access to swap.
> + * It is used to set the appropriate flags so that eviction can be optimized
> + * in the pm prepare callback.
>    */
>   static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>   				     void *data)
>   {
>   	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
> -	int r;
>   
>   	switch (mode) {
>   	case PM_HIBERNATION_PREPARE:
>   		adev->in_s4 = true;
> -		fallthrough;
> +		break;
> +	case PM_POST_HIBERNATION:
> +		adev->in_s4 = false;
> +		break;
>   	case PM_SUSPEND_PREPARE:
> -		r = amdgpu_device_evict_resources(adev);
> -		/*
> -		 * This is considered non-fatal at this time because
> -		 * amdgpu_device_prepare() will also fatally evict resources.
> -		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
> -		 */
> -		if (r)
> -			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
> +		if (amdgpu_acpi_is_s0ix_active(adev))

I don't believe this is valid "this early".

pm_suspend()
->enter_state()
->->suspend_prepare()
->->-> Call notification chains for PM_SUSPEND_PREPARE
->->suspend_devices_and_enter()
->->-> Set pm_suspend_target_state

> +			adev->in_s0ix = true;
> +		else if (amdgpu_acpi_is_s3_active(adev))
> +			adev->in_s3 = true;
> +		break;
> +	case PM_POST_SUSPEND:
> +		adev->in_s0ix = adev->in_s3 = false;
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index cec041a556013..6599fb6313220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = true;
> -	else if (amdgpu_acpi_is_s3_active(adev))
> -		adev->in_s3 = true;
>   	if (!adev->in_s0ix && !adev->in_s3) {
>   		/* don't allow going deep first time followed by s2idle the next time */
>   		if (adev->last_suspend_state != PM_SUSPEND_ON &&
> @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	int r;
>   
>   	if (!adev->in_s0ix && !adev->in_s3)
>   		return 0;
> @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>   	if (!pci_device_is_present(adev->pdev))
>   		adev->no_hw_access = true;
>   
> -	r = amdgpu_device_resume(drm_dev, true);
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = false;
> -	else
> -		adev->in_s3 = false;
> -	return r;
> +	return amdgpu_device_resume(drm_dev, true);
>   }
>   
>   static int amdgpu_pmops_freeze(struct device *dev)
> @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
>   static int amdgpu_pmops_thaw(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -	int r;
>   
> -	r = amdgpu_device_resume(drm_dev, true);
> -	adev->in_s4 = false;
> -
> -	return r;
> +	return amdgpu_device_resume(drm_dev, true);
>   }
>   
>   static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>   static int amdgpu_pmops_restore(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct amdgpu_device *adev = drm_to_adev(drm_dev);
> -
> -	adev->in_s4 = false;
>   
>   	return amdgpu_device_resume(drm_dev, true);
>   }

