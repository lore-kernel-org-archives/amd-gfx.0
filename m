Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1350BCD3430
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Sep 2024 13:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD7810E5AE;
	Tue,  3 Sep 2024 13:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0jqvomn5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3B710E5AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Sep 2024 13:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xij6P8Ms2l2nknthHY7psVxz3teBCy6sNk7GCOnFqavn16+6xR287T1S15ZZwGiPXE5uS/WmIRtrgZ5R4Q8QaznRwAfpXcw4bZn1lqI5tUKagZPdFpRxaeDXH43db034IjAYcusuhgwH/VCFXC2jvYSxG7N1L3I2t3SLSXu35Qy8txAp8NL8svnQlcAZutrQ0Gog1jRDMmuwgcg/0LrhEuEmc3n2KCtK7oiJc8HT9Bsa9W4VS7DmVjh4sB/GDipEt5/MXWeGBsiaQ1eKANb/J+oa30o8jzAfKYENsygMRkPSmsKfFQTAUpCkJI+ZyyJ6knqP/I1NoG6F5vGYwB3d4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXODyoBavia8EEJsp4LU6D36A4SrrQdTRcc93KpRtwE=;
 b=AZ0Kg4s9uq1rHvEI1X7OmcU84fhgQ+zrdOj2SKPKIbc8Rlr9/p6pDroNGN38d0K/Vri3E5mWGhb4c1nYTqLA6sG5oqyLHnrkGmIQwhw7JcSvFZce+uVCpRhriapy+1HDxIGTln4yvrYxorLvTO/TZuRpw64CBRlcMJgJ2eazGaGQNGmndB81ACgEZ7+xmyYbcBSV1nKElUoGqF63VbIHWyorqp1rgkdyFz/qUYdXGnpr5BikaeZB2jLwWKfx/a6px1YLB8GoKRWY359ppsFecNTJMIvyctCBZFW5BVv5PhhT0st5knGMukrkPIX0fjjNTq6pwEQx45y8ZO52GSLi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXODyoBavia8EEJsp4LU6D36A4SrrQdTRcc93KpRtwE=;
 b=0jqvomn5Ze+3JkAOCWeomd9FZgmpjpQ1y/xInK+6VP7uDtbKioq3zKYiK/Dn1JQfe4VJvTEB8+6FX0v2zJJrYcMXNJPxiLNKdnR1esIK7za4uShsb86j5TfXduZv59ioQRVdj2RCEik6PQL0B1ist7fE0SaKbmittFYwG74jwwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:29:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:29:16 +0000
Message-ID: <5e54cb90-c896-43cc-b0c9-0a0bc9d75a99@amd.com>
Date: Tue, 3 Sep 2024 15:29:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix a call trace when unload amdgpu driver
To: Asher Song <Asher.Song@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, felix.kuehling@amd.com,
 thomas.hellstrom@linux.intel.com
Cc: bob.zhou@amd.com
References: <20240903123136.555278-1-Asher.Song@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240903123136.555278-1-Asher.Song@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a78eb5-06e8-4c39-7cbd-08dccc1c6807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlNSYkx3Wk11Snp3TTNPaUtaOWxwZkM1VkhpM1V6TGFGUlVjYVAvcUdiWWRG?=
 =?utf-8?B?K3pmeDNtaExXRExOeE9LMkUvQXlXL3Bmc0dxcmJ2TytpZ3l2aERFSGxIaFMw?=
 =?utf-8?B?ckV6ZUZVZStFTXNqZElESkFYRURyVEZDdCt5YnRCNU9FNWVuNWo1UXlOR2ll?=
 =?utf-8?B?ODRkVlF5SHp2SnpWTEJLbzdqKy9raFI3eWY5K1puQWFIOFNJZFR0SWc2MlFu?=
 =?utf-8?B?dU9ESnZXUWpvWDgwUmUxZnE1Mlp2ZUU2RDJ2SytoaEVlZWNDNVU1eWU5Tm1u?=
 =?utf-8?B?RHVRQ0o4bFlKY0kvU1U1TGRuNHhQTGtxYmFoR3BPd092NjVlWmFGcERMOHJh?=
 =?utf-8?B?emJrUWlpbEVMNGQxN2k2cjlLRy9ZY09oKzFyV2R5RGRVSHloVEo0eHdDK3pC?=
 =?utf-8?B?cXpwT3l5eHI4bWRXTCtJVWRHU0FEeWgrZUdTNGFvY0l2UWtmUUJYdWsxR3c5?=
 =?utf-8?B?cVlnZWVlOHlrMjQ3TTNTTnpyanBpS3M4d0lQaGk5NEVLUU5MQjFpVWF1T05p?=
 =?utf-8?B?aS9aWTI0YjRKUThPZnZ2Qnc3Y1NRb2VORzNYUE12b3Y5OXI0dk9aaDE0azJM?=
 =?utf-8?B?SEtCemUrdXVBdFB6aEVXajlIK1FtcVBXend1STJLU2dBbU9kdmFhbE9pWVY0?=
 =?utf-8?B?U0ZwVVJvcUNQUlRwaThvS3grcVc3VXR0TmI3Y056NEJLVEZ3Q0UxcEZ6Z3RU?=
 =?utf-8?B?WStEMEVyOS9IeTBGQmgzTEptTkd6WFJjUDN4K3VZRGUrWGV3dmErRW1tZ2lE?=
 =?utf-8?B?RTcyY0pnUndkVHFJZkowdFhrMFFtRk5TQjhoSlkwUytySW9rdzQzV1U0aTlJ?=
 =?utf-8?B?S3FlWFJJTXg3YWRpVmdiN0dYMTltREozRE5MbnhOZENKVkNFaFkzOG9NSXc4?=
 =?utf-8?B?bnRIdjN4V3E1b05DRjUzbURJRVRwVVJiS3gxcWl0U0lQanBRbm90NFZSRHVx?=
 =?utf-8?B?c281RGdtK1lMWnlKQWRocWlFb0tsZWFFQ2FnaTBLL2RCd2VGWDBwV2N1b1Bz?=
 =?utf-8?B?YU13NldjYkgyWitiTGordEdTNlN1OTZqTElPOU10TVBPTGMxbUVYMFlLSXRI?=
 =?utf-8?B?cFpITU53ODFjODNGN2d2b29iSUYvb2oyZTZFY0JvL2pObWQ2cUFzenp3cWkx?=
 =?utf-8?B?Tys2OFdHckxyL2RQdjRzMTBxdjJRS1N1U2Q1Yi9kdFlXajY1eW5UOVAvZXlN?=
 =?utf-8?B?K2pManpibjBycUd4RHltMzRGVTBpSVcwVDl5Z2pwbnFNb2VUV0xhVStJQnlk?=
 =?utf-8?B?SU14a0VqRldKUEdzcUJ4dHVoa2FyUnJpQ0ZGNEo5ZlNKMmhGTmt2dFV2Yjh2?=
 =?utf-8?B?aU41VnhkUk11VDVGVnRKY0xDQVFGOEVTV3p5ZkJZSlBremJiRFZDRjhFUDk5?=
 =?utf-8?B?U3VSV25lS1FFbnl0VFQzZ3YxNkRJc1pkWTVEdHkreWovM3Q5ZG8rclZ1VWNN?=
 =?utf-8?B?VFFNYnN5dVpIV3NVeStnZ0JqbHhnL3BwNnhpaDJobXo3cWRraXk1UkpTL2tx?=
 =?utf-8?B?WEVvdEE4VWNSSUp6ZE1IeHRCYTNCQXhaN0FqS0JQaDNLQ2FqM0I0MENtZ2lB?=
 =?utf-8?B?L1EyUnFFZXNiZHBhVWFUWGtmRVMyMFlFR2pOZlFZVUNYRUZlME56YjA3T3ZI?=
 =?utf-8?B?RTRxQTVjZjFxMnk5SUwxWFBTWDRLWGc4VUhYQ1BXUndvRUU1WGNTQi9JRC9C?=
 =?utf-8?B?azVJQ1U1S2V0K1R5M0xNSGJkZnVRQ1I0RVNYT1hPNk1ZdkE5Tm1GUnVicDRm?=
 =?utf-8?B?eld2dEN0QUJYUEYvMTlRU3J1bHRQZ2F0QWh1TDBtOTYvVHpva2l1MUpYeE5k?=
 =?utf-8?B?VG9Ob3ZFWURMZ0o2bk9iQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNPNjdEcHhPOC9aU3Z2THpSd2tIcWJLQU01T1lIbUVYOEZMbTVlZWs1dFRq?=
 =?utf-8?B?L0tnUU9nb0I3UitOaXgwMnA0NzRyT0lRbWNZVnNCbEwyUFBZMEdKYTQ2T29R?=
 =?utf-8?B?eTZSZ2tJNlpVbHBWUG5tUUVDUDY1elUxQjlzNW9MUHdIaEpjYXd1RDJWZ2Qv?=
 =?utf-8?B?UEFwZldCWE9vZlppM1d6NG01SHdaTW8xSjBQYUJnb3RXWDI5cElTQytQSkl6?=
 =?utf-8?B?d0xBK3lvcWY0Q3ZHU0VwS3FFeEVGMUc4TXYrRFFTT2ZHc29XbVRBeUNKditi?=
 =?utf-8?B?aUgrWTNzTVVHK3RzVkVtUlpLNTV3dW01VTh1L0h6NUFzdTd2UGRXeUhPQ0Na?=
 =?utf-8?B?UjBKTVA5RDVPQkZZWXdXakE2WHdJOHBDUUhpQTNFSExxZThiRThPYmtXOFA3?=
 =?utf-8?B?TStaVW90Mjc3SUFiQU5lMlhlRHVpVzQzWkJPYzg3TE5CSS9jUU1kdkw4czI0?=
 =?utf-8?B?Rjc5ckg2d0JoaUU3K0xQbDBhMTRReVNBenZRYmFtZWZZWm5yU25pMXZWTEkz?=
 =?utf-8?B?NjhtM2ZmR3VrZk1RRlFrcmxYdjBsVko0NVZ4dWJrUldMRkttSjRGUWtoaGh1?=
 =?utf-8?B?YTMzL0NQS3ZLRXF6VnM0ZS9jb2h0NkdRUVdGUUFNNGo5bDl4L1ZyNzMvVzBq?=
 =?utf-8?B?UzBhM2ZINjlsYVVRc1ZGSGVpTHJKRjhHTXRWUExyNXJpbm1tRzNvY1FrcTBB?=
 =?utf-8?B?WHZsVmFJaGNYck9sSFhiRkE3OUQyZmdDVGVJb1JlM0N1WnJERVJsWTd5dHlt?=
 =?utf-8?B?eGJjS2NyVzlGaDgwaDJpZXd0R3VUb0hvU1FzVGJuYjB4MWNmVDh5dTlRMDQw?=
 =?utf-8?B?cit1Sk85YlZvRHhDUzFaZHdMMnJjZ0Q1dFN1c3FqaDh0Y0dHSTI5VWFmNndO?=
 =?utf-8?B?QWh4N0hPOFNjU203OW1NTkIyR2lKVVAyWGNJcldjQ1hTb2VSY3JJMXpjMFVp?=
 =?utf-8?B?RVRQRDdvZ1IrUGcwZy9KU24yUTkyaWI3NTFCbm1URHJVY0xwcm8yMTJ1V3dQ?=
 =?utf-8?B?RjFhdTBIMnZMVWRHd1NCSE1yRDd0Sk9PQmI3cG5GQjZlZ28zbXR5dUpyUEkw?=
 =?utf-8?B?aHdqTDNTaTk2Q1pUQnE0bGRtZ3JXWUlVQ0FyeW5sWHB4SUJQZnFYSGxpRGho?=
 =?utf-8?B?alFhcXZxMFdqWXk4WlZiTHdscjY5dEplb00xYlF4UEFYOUVkMXVOK2NLbUdJ?=
 =?utf-8?B?MndzVFlKSjhqR04zdVRyYnZQT0t6UkpBbmpIUHhqOXkxbVF1VzdSZHVsUFp4?=
 =?utf-8?B?ZHkvbDMrT2dPVlZhTStFVkI3TTcvbjdUcGFUMjRFdXFTYnhJd1IzMExsU3hB?=
 =?utf-8?B?cmhZWVdXcnMzQVpDdmlOVjlrbXZwU1ZOdEdRNjRsNHg3UXdjdDY3azBxejNp?=
 =?utf-8?B?NWt3Nld2WkhZSllEcVR1Zk1lQnhCb3dVT1Z1cDkxaDYxTTY1K21yaGprbHZR?=
 =?utf-8?B?T0NXaDlrd3VIZEp5OGV6OW1leXZUKy9VdEVOZHVYbzZ4TkFVOFBSSDUwV1Z3?=
 =?utf-8?B?THNkTGFCcW4zQkluK1hxRjlzTTZpNEVOSVI4SzVYUUhqRzI3TlNZVXMxKy9x?=
 =?utf-8?B?c2dqdEJuL3dZUng0cm9vTUJsY0lpQndpazRZcitnQ1NHL2p4KzFiOEMwRk5I?=
 =?utf-8?B?bnhOaGdvOGlGM0dTSzdmZU1YUk83SWxxcEc3RTM1Njd5QUs5WG94RWE2WW84?=
 =?utf-8?B?UXhQb3ZqRERTVmttb2VMcXc3R1lsR3F2VEZpaWhQbE55OGFxdGV0UmMyTW1x?=
 =?utf-8?B?cWFiNml6eDlIZnhhbGs0VVp6Z1NMVGQxMnNLSEVzZStjOUQ0NmdOUlA1VStn?=
 =?utf-8?B?ejNxcDVuQVhpTnE5K0xsd2lJejVMaVhDSTM3RWtyQzZ6OWFUVU5aUGtSZjVp?=
 =?utf-8?B?c2t5MDQ3S29SMUtZV2RqYlRwYnB4ajlCL3Q2TTVpZ21rT1FZU2N2dEJGUHBx?=
 =?utf-8?B?Tmd6bVg1U1FwOVVmOHYzZkkzdnVrSVdzbEJFMm9pT0xyYjF5UkJBS2UxNVVM?=
 =?utf-8?B?MVFsR094Q3RLRWNhYXNESWxEaEMxRnRJQVkzOVVmSmNLTUFKaGZINTZqRDJw?=
 =?utf-8?B?V2h1U2k4a0djMkNZMzRXcVJVOVowcVRVR0pKRzhGeSs2aVJ3bVpLRmtzV05G?=
 =?utf-8?Q?sP8s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a78eb5-06e8-4c39-7cbd-08dccc1c6807
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:29:16.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHVgBEYUX8H2txxYu22WN8ltHiLWcj3eR7/Wfd7oxxwh2y1lnrPJPeanF5nhrFNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

Am 03.09.24 um 14:31 schrieb Asher Song:
> In some APUs, the bo type of GART page table is ttm_bo_type_sg.
> Those type BOs is released by bo->delayed_delete which is added in
> ttm_device->wq, not released immediately.
>
> To make sure all the ttm_resource is released before ttm_resource_manager
> is finilized, drain the workqueue in ttm_device.
>
> Fixes:d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path for imported bos")
> Acked-by: Christian König <christian.koenig@amd.com>

The correct tag is Suggested-by.

> Signed-off-by: Asher Song <Asher.Song@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0a5c8d97787a..99017e426618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2216,6 +2216,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>   	if (!adev->gmc.real_vram_size) {
>   		dev_info(adev->dev, "Put GART in system memory for APU free\n");
>   		amdgpu_gart_table_ram_free(adev);
> +		drain_workqueue(adev->mman.bdev.wq);

That is certainly incorrectly placed in the gmc_v9_0_sw_fini(). That 
should be somewhere in amdgpu_ttm.c

Regards,
Christian.

>   	} else {
>   		amdgpu_gart_table_vram_free(adev);
>   	}

