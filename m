Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8308DC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 22:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0665C10EB56;
	Tue, 23 Apr 2024 22:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVD/aG5i";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A14310EB56
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 22:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxKMrHggEU2rK3XSzfz7PZ2V2We9bUoW28EHgFiCAIyUWd01fpeM0OoJcnsCSU5naennGyFQVL3bUGdTKtXhJeIlhq/+adCsSQ+YEe8ZTRomARhHW3Nc2lw+yj/OOKuYnSHG2NYQB2lMIoOToE4JWcdp1CUWBmueRCZdkAe7k2PGOKCinp2j01AWxiyGhmFtlve8JmhojF+D02j64qbEqtCwJIrNyCrEcYG2j6aDds8Yo8x7q9WiqIErac9IH2IBoTxzyxO7d0Ocga1rgIfd0aNauY1bJfAKwSphXrhdP2uJHLxsa3IGfrZfc/bh0Z61KQNgmAxgrX4Mo6INC3vTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbtaHO7BmDdh7Sc7TpAR3ZrrGHiCNMXIie5LtgTdyo4=;
 b=IFTcBmSQFj38+FhgjhUbstf6X69A6KzgxD7KUf/bObhdTIOBVfWIpKXl8xtABlPUQjeu2YIq1BMtAH9a3A326O2h//c9wHRNdcdXbWsXmY+msLZNKxZQtDKiqYb7MSGPodl8tcHpTIlO4YB0nUgHd0CjC0eRMIAeHD9DCZziPVnB79OQ9R0rbYIBbpAfGZAJkJpvde298fXfgQJgbVb1y7wNQhCg8TV2AHTN/fLIXNYEz17b0L/mQMRJWZXo+7DXnh3+t1SLopwgqL9Fb3XFsiq6WSO5j/qcA0sXkVDT62jlF7QMFa8oYt4iET2l6MoxujTn+yTWTT5K1OvMHvEBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbtaHO7BmDdh7Sc7TpAR3ZrrGHiCNMXIie5LtgTdyo4=;
 b=yVD/aG5iHsE0wb/OxIkcp+v0TxqZKTLnR7gO2f3F3pmGU3k+6nP6WmRjxuE1tl4EAjQbFR9VgUUYp8ttHwR0G/E5p7J+18GN7l4kgFdJwHqMSrI9PqwSaAcprL/wt+7ApPFywl748eQvfFKnE/3WkPlU9m6Dkd06LcnEjBPgehg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 22:17:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 22:17:42 +0000
Message-ID: <00003b2f-5f31-4bf3-828a-8d7eea792563@amd.com>
Date: Tue, 23 Apr 2024 18:17:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] drm/amdgpu: Support contiguous VRAM allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423152900.533-1-Philip.Yang@amd.com>
 <20240423152900.533-2-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240423152900.533-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a4c11-37a0-4f98-4490-08dc63e331ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGtVMWtRdjdSNFBGbmc4dHM2bG10MWxpZ2RjYXhzeExGOVd6QXZuSXdqUitW?=
 =?utf-8?B?UHlkU0ZxNXMxZGZQbS8xMFhqR1I1RDY4MkNROStNZDZod0MvQ0xBaFh4R1Jj?=
 =?utf-8?B?VFo2aWl5dUZnMDQ4WE91ZlF3T1Mwb3pPYUVZWWlhOXFsVGhmUUFJUGZGUlhR?=
 =?utf-8?B?ekh4eFlSbXdVNlBqQzIyUTk3eHBuSHUrM0JyNHNyTGVuNDZOeHRBaE9MdWh6?=
 =?utf-8?B?cTJMUHRSY1dYQ3lqR0NSaXNFem9pNDkrRnh5bnRlZ0VjL051eUtuQVg2c3k3?=
 =?utf-8?B?bnNsaXhXTWNOMkpCeHVaQlpVVEtFQVVjaEFsSExWRzRBZHoyblVRUE9nWGhR?=
 =?utf-8?B?cm5wN0lVTUZnaHhPLzRDcUJvZXZ3WlE4MWxHUmUyWmd4cHN4RTl4eUdDZmZ4?=
 =?utf-8?B?bDNDTWoxcVVyU0h5VWhzVnBKc3gxRW9QcHFYT3cwTkZHQUxtTk9BQjlINGN1?=
 =?utf-8?B?blJZMTVnRG1XZlAyS3NKTC9qaGVrbWp5eWZWTW5IVk90QzZTYzBOcWtpTVp1?=
 =?utf-8?B?NC9KT2lrWFpmZDJDdGlYSllVckVjZ1c2b2xocTl0WjBEWGkwallHOGtvNlA4?=
 =?utf-8?B?RC82b1lqb1c4cGFPVzJ5Q3h1Z3BlZHlQVU4rUUxOZTFiU3dEU0xTSk5DTGtM?=
 =?utf-8?B?ZVhaNFhQZm5HY3BqY25sQTR6TnZmZXJ5ZVlTeFFJOWVBZmdWWkZ0cm40dHpy?=
 =?utf-8?B?ZVQvYmZ4cTRIN3F4OTlQRkMrSDVkZGxXODBDTmNmSUxtNHArOWRWQnUzTkg3?=
 =?utf-8?B?OVpJNVZRZm9KZXIxMHRzZjdPRkdKZGZlNnY5Wkplb1dtN1U3ZDF6TnUyeEJp?=
 =?utf-8?B?UGZQOGVFd2tQTWhwblZ0UHRDTXFvL2djKzJKT04xSEpacEYxL2YxeERWbGwx?=
 =?utf-8?B?TWxVMHdrRDZKbTJvdlQxMUx1VE1kcnhTNjF2d1dSdkVtK2IwcjhjaWE4VzVE?=
 =?utf-8?B?Zm4ybXRqRk16eFFUcW1oVElmT2ZYT1M1L2FCeVRkQk4yZm84RFRKdFJjZXRW?=
 =?utf-8?B?RDRiUEVjYXI4aUdCMWRzYkZpUjZ1bFMxRWg5bzZEUWhSYlFPd25WempRNHhq?=
 =?utf-8?B?S1dDU0xoMnV0NGxVcWhtcGQyR2xtMXBDcHJkTmovVU1iSW1BSjYwaXlQczUx?=
 =?utf-8?B?N0lDZ2JkZTlVdlZhQThRaWlBVnpCcmhWYmNWU2QxOWk1RDR2YyszRmlHQ28w?=
 =?utf-8?B?UHo4d2RNOFhTMHA1STJWc3ZyRFpZS09ocFRWWUFMOXN0YUR3TEw4MDd5bHhr?=
 =?utf-8?B?aFFqcHFVOEhTY3RjbDM4cm5DYjE5dFJFTDFoRTQwWGwvNWRNVE5XOUFFS0Nh?=
 =?utf-8?B?ZWo2dUM1WkVYdHVoVmVNK3ZjOGdUSFFvL0pQSTJLbjJuWDFpUDhvQ0dCaDE1?=
 =?utf-8?B?ZUhEbnpNU3dKbWREVkIrN3RLb2loclNsMklpZW5hQ1Rza1h0M3k3YWpqZFc1?=
 =?utf-8?B?OUZjaW5SVU1QR1c4eDJZYmhtbjljTjRPQXJZcUdqMS9yS3ZnUWVvZ1FOSlMv?=
 =?utf-8?B?L0pWcUc2SC9xRFRFeFZ0eWpYQ1VhYnRyMWlIb0x4VitoWWF4NURXL2NVL0pp?=
 =?utf-8?B?aDNGMFJrWUtPbm51b3Q0cDZDOUJrc21ReDBFZ2FDM0J5OE55ZlA5dVpxc1Vt?=
 =?utf-8?B?RTVUY0x0UjJ3djBRMUVjc052U3lhZ1RVUDhtOHpjanptZUV0TXVGenJqNEdn?=
 =?utf-8?B?SUV2YkZmTlUxZTNDTGM2V0pJa29HY2Y2VEN5N1gvQWQ1aXhaNlYybEdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVo5WTd6Vng3ZFRyREhTV3BFSlZsN0FUdkhRZi9HOVl1UzJSemdhZ2x2SHA3?=
 =?utf-8?B?SGJyVnoxUktJb284eHNiUjNpZjV3Sy9zVGtBTGw5V0RDUTNVbEdYVVZMUFdH?=
 =?utf-8?B?VDc1SWdwMC9EMnQ0TVE3UWViZnFTcFRoUU5Ra1Y1TDdIcExTZGNRREpQbUta?=
 =?utf-8?B?YlczL0V6amlhZmRDVVJHY3pWaHhNbnlWUTNld05vUWM4TkI0RmJEbE52SHll?=
 =?utf-8?B?UnVYSjBKV2xEQnV6Y0NtY1piQU9yQnlub1FsZXhpUzcyWDJYSnZ1aVhhV2c0?=
 =?utf-8?B?Sk5hckU5L3hwVHNwU3hBSDhjbDErbkJYK1ZLaERLbS9KUlJuUUUzNFdiK3No?=
 =?utf-8?B?alZYa0lqaFYrL2lOemxvbGQrWnY0c0RLWGx2cjhEY3BudzQvOXlGM2cwcGth?=
 =?utf-8?B?bCtjSjdSdzNWOCszRi9ISmFUdlZxbzIyc2lkRE5vMlA2a0xwWC93c1JiRzgx?=
 =?utf-8?B?UGR6eXppNU5EU1lienBxRW5Ha3BkVHVHcE1qUDVidGpjNit5TnBmelVyTEFN?=
 =?utf-8?B?bm9RdjRpVmJ6NmNidnJ3dVNjQ1kxRHVwdWl2eExqdHZidlo5ZGxNaVBjbS9V?=
 =?utf-8?B?dGxMcE5UeW9HcnMzeHpxS1VsTGlpVDBWOWg0M04rU2ZzRCtkWUh5MEEwSXFH?=
 =?utf-8?B?SEdvRG1FTlFPS0t4UkhqU29YWGN2U1VKMmQyd2l4SkYxajJVQ1JMYURISURE?=
 =?utf-8?B?Qmk4OVVBZXhsWkVJMXA1K1VsRFVJZzVidXI5OUI2SFp3TitJeTg1YXVRYWRr?=
 =?utf-8?B?c2FFMysrenU2b2RVdnBOY1FoZUhQbUU3c0JhUjJRS1J6cHFMcjg1cHZsNkVo?=
 =?utf-8?B?NHUvT081bzA0UW9xNnE4SnJhL0tDeU1sSlN1VmF5YzRSRjdtZjFBUndKVk1n?=
 =?utf-8?B?YWlQaXNmdTl6Z2txajdHTGZhL1FQTStoZXZoL2lLSW5wcFVkUlRocDd5MFBX?=
 =?utf-8?B?YnhNVEpqa3VyTEMwVHc1MEFXWVdiVTJxNVRSSERLbEEyTVptK3o1L1VJdVhX?=
 =?utf-8?B?MVpjK1dMYjBIMFQwcncyQjRJRVFtcGEzSk5JQ2FqSkxqVW5DeFZGeUJEQWR0?=
 =?utf-8?B?WVVBUVowZ1UrUFZEdzBLMStYdHA2ZU1tQUhVZ2VNZ1NFMkRPZzRpdmNDM1Jr?=
 =?utf-8?B?YitKVUpGWGlrRG9XYi9LVzRGR0RBc0syTG80K3Z1K2tzRW9qR2dZN2lNS3BR?=
 =?utf-8?B?WVVUc1BmL1pzd1JGeFdaT2Q5UzZMQ242ODh1TzBxaTFDZ3g1UzZSWFlwaGNT?=
 =?utf-8?B?aDcyK2FhUWZFYlhuVnRuM3dhVGZjZ0NaNFY2QzN4MHUyd0VuTWtTSzQrY2F2?=
 =?utf-8?B?TGNicGU4K1U1bkxuc0FJekdEazhveXNUaFJwVmNhSXRodTNjL2o1YjQyd1NQ?=
 =?utf-8?B?WDkvbmtnMUU5TlhHbHFHNWNZN25tamRvOEdveXc1SUloaU5FVi9GTFRuUml6?=
 =?utf-8?B?eWRZQ1NlSG8zMFltQ0MrSlgwQUNwQVZJcnpHOGJpVG1GTkxOTmNZc0Q0VnJB?=
 =?utf-8?B?UDJtUlhyaGNhbkdtTmlIZXJvWGlXbWRuK3FLdVo5M28zU0hyNjZmYkFOaDUx?=
 =?utf-8?B?aFp5b2g3QXF1Uk96OTRxMjZqWlNyTWVKbmNlYlJJYmtpeHFGNXovUll2dndT?=
 =?utf-8?B?VHl4M3lxR1UyZlBsbmt4cUU4MnBCSVFoUGhycVNySnZ0MytmU3ZWL3BwcDJa?=
 =?utf-8?B?ZDZzcExrOVdlc3JRK2NLbGluQ21SblRDOXZxY2xETkwvZHNPY2UyUUkxS1Fs?=
 =?utf-8?B?VmIwTXRodXd3dmxwbGlYNC9DQkt2RDQySlNhY2VQbTNscDVrL0dNYXR3WXM5?=
 =?utf-8?B?Q2kxVVhaNHVZR3BKejBSQWlYL1lUNjlBK2ZOZnNlMHJSK2diZXFOUzFSM1ZV?=
 =?utf-8?B?Sk5ZYkxXZnMvNFlxMlhLejNLbUhXbXdEZWRwMzNaMU1hR1JVaFNrczFvZ2RJ?=
 =?utf-8?B?Uk5ON1pXYjJRT1Z2dTlwUHlLYXRiZ1lkckhMMTdyV2dvakNTK01hZnNsdXdq?=
 =?utf-8?B?L0tRS01HU3FaV003Y29kQzNnMzRLMWF6dGM5QWdDbS9DK3pycUFIMG83RG9B?=
 =?utf-8?B?R0x5d1FISE0vWXptbzdjTlYxQ1Jjdmt6dUlCdGE3dHc5T3JxQ042T3cwOVNM?=
 =?utf-8?Q?R8/mjh+jtnSURVst0xJHmP+7g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a4c11-37a0-4f98-4490-08dc63e331ba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:17:42.4398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvgvCCaXlVHA3LkXgh/ppuYT9kaysK1NHIahKzX3jqdyVpw9q+UpSqNHz3e2h32kHvJiL5D8zZmSOLhw4dDKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923
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


On 2024-04-23 11:28, Philip Yang wrote:
> RDMA device with limited scatter-gather ability requires contiguous VRAM
> buffer allocation for RDMA peer direct support.
>
> Add a new KFD alloc memory flag and store as bo alloc flag
> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export for RDMA
> peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag, and ask
> VRAM buddy allocator to get contiguous VRAM.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
>   include/uapi/linux/kfd_ioctl.h                   | 1 +
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 0ae9fd844623..ef9154043757 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1712,6 +1712,10 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
>   			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
> +
> +			/* For contiguous VRAM allocation */
> +			if (flags & KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
> +				alloc_flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		}
>   		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
>   					0 : fpriv->xcp_id;
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 2040a470ddb4..c1394c162d4e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT	(1 << 24)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT	(1 << 23)

If I understand it correctly, AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS was 
redefined to mean "best effort". Maybe we can drop the explicit 
"BEST_EFFORT" from this flag as well to keep the name to a reasonable 
length.

Regards,
   Felix


>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *
