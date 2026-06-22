Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8198CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 13:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7003C89FA7;
	Mon, 22 Jun 2026 13:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5ah97nS";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C4C89FA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 13:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etDlSqmNEs/PXH5WBPvfF4069anjm/V5vdR5o5v/KOLU9f1wdd/K5wwZsIcfYMHdtMdzrrngzI1OYQJEWbXQ4kpF/mOmYPOoEZDYkooVmCcUF1m1uxSzawSIJggx4GflXsM9wzZ/UtX7h5nd0bFywYsPXueSiyBzHsE+aZXwwlI1xpb5nm0nh3eDqYLK9EzpyXFgSTOmZmGDYCpIwfJkmBTZ/2Xnsc4ZfqZrIQUTkrT+fll4ao7TOp+KokQvlny+/j4Sa+snz5FivI3JeBKdBXkSjjsF5/8uuUjQKdUD++MmVm4cEuTPIFMUyyBSEZryQi2CTD4hPDZuw2oeZW7gBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKYjDOZFvzHfXOQmh+vxvJlGLCNUD4kq7qjSxzPoGUQ=;
 b=jyARmLW3dmDi+AeegKK2fkmw3nRF+zTb8Bc0tj9wwcy0vihMwGvOBrXMYsjHvmHBhAT04VkSHyHZn6HintgaLSyvAySCd1s6YyERB4TGIqj2kaePeHx6Oj7htsxpJDkQX+uBpUjNPoiznNkz21JagF1H8YBGrCIozqLay4+zfC9B2By52OrEWB+5Bl8aO5VR59PPPBw2Dar8yVvtx7U+cGHh0/SMqDSu+ZNbmpmrAhY261IYFn3liALf3dlQ9nPnDOTth0qaPo6VFZlks2fDdLUnbRTqntiPZ+bQ4+N6Um7TEGemox3TTi5/+zLZ7NYXBeXXb8vuweT9cf9o+apLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKYjDOZFvzHfXOQmh+vxvJlGLCNUD4kq7qjSxzPoGUQ=;
 b=e5ah97nSyttyzcnofiXOpyRBOeeYAtWJXS0PuawFOvpto7JihqaAneJ8L+y7+fzFEy8ueTSRXhNOUpUZTYT6cUwKf8srNmMZ1/i7ZnqaWKcZsNxS6h4FOqz9EBxtksxzMb24eCqvNGMutTzBHX2oiC8P5EWws+54pxcZVdCg75c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 13:14:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 13:14:23 +0000
Message-ID: <689a4adf-812f-475e-8e33-c17893a05f1e@amd.com>
Date: Mon, 22 Jun 2026 15:14:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Support some Barco AMD based graphics adapters
To: Matthew Jacob <feralmatt@pm.me>
Cc: Matthew Jacob <mjacob@feralsw.com>, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org
References: <1b83ac6f-1018-3dee-c029-1b2ed78a8460@feralsw.com>
 <10397a2a-88cf-4070-aced-291e24785a8d@amd.com>
 <-OvmEF_NM5X1NJ1TKjZKl_nNHJhfQxE-zh4bIGMsBfCfSjyFJFc-sFkaYCXJZD4mhu1KKM0QJ7dbvMkzPJSzvkYhQixNHLNuRbSdNLnhjNU=@pm.me>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <-OvmEF_NM5X1NJ1TKjZKl_nNHJhfQxE-zh4bIGMsBfCfSjyFJFc-sFkaYCXJZD4mhu1KKM0QJ7dbvMkzPJSzvkYhQixNHLNuRbSdNLnhjNU=@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:208:32a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: af9b0a68-44b1-4bae-d7da-08ded0602cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5jix6Pg9JkWbmFd9QNfy2gbwQiiPSeBNn1zF6kNwQXyGzcf5tTxCSoN+fq70S43pStOKG7D5Cg3xXIAl2GKsyQyCHRVHcVMl2I7fnEi8WB/e/7cXhhrN2aMWfcTvebGyOu+fGLULbo2oYByZu6XFJ94BvMwU4LRrrl8oYL3km4/xgRASbC4/g5FraKQ5sa/fDa8JxaGfjE6llchwuisvzOx6HkQfkKDh8DhvaD8goUPP80NVvOeA2Tvpke8jKsHfMtiHG0IIAgAq1nTN/u3Q1aOkW4qjDobKfd3aWxPQMPvtJIzeAQNPf1Orq8M51OoPorpzdShVsuxzEiidZCL1yW8mDwgPYc8mE7Rv5saA20GUsU5II2uaiQoWBY0NwPBGNWJxizvkoqLf30jv8bw/42egoWxtc7EKXibyjd81X9MfOiYAVNWnSKIGwfEuKNwokNc8zcSTH1LipYBrCNDjfYyoUbAFPOS8uCUlltLqYt0JBpmAA/DJCbwkDhZDzVwhcjTjNoZCHmKY03NXraR+CFDsh0OlTuFW+Is+LS4petctgRNTmZ7gQyCNNUYyXhWt2jCEUyS2454n0p4O7k7sAMAqMrfyF2mmDGDTsjsAthIueHm5ltNS3PiOKUm/h0tvTxtzRrlHpaKIY1mbhM9Vj2L4luwNd7urnGCGwFdNbrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21qV3BhMFpWTy9OT2dxQWROMlBmSXZXdW9MQzlDbXp2RDUvN09MNGEzbEg5?=
 =?utf-8?B?d0E4Z2pyK0czNmpaZG42a3d4YVYyV0YzeW1LYUxiME93anpiTUN3VGYzYjJS?=
 =?utf-8?B?QTF4T3dLS1Voakc2YW9IOERDdEkzMUdVRHpORTlnRnVnd3U4Y1pqODRTR2wv?=
 =?utf-8?B?OGxzOUNydFZsMzJ1MERkZGJEUEovYnlmaVh2S2p1SmRkWWd5TWtlZ1l3OHpn?=
 =?utf-8?B?S2ZoTTB2MjZ2c2FuTzFLY0grSUlnT2FvaFhLcVZWMy9BdVp0TVdmck5QYkZa?=
 =?utf-8?B?Tk8zYWxlZEJMZWdFU3dUOGgrRXZrWndlbVdBKzBtNWY3cjl0UEpMbTV6VTVC?=
 =?utf-8?B?WUxuYmZTNU8xUndMWVlpQllOTWFYZ2ZodG1jR3YrTXBid0VyU0ROREh5QTA2?=
 =?utf-8?B?eFcxYlh3dmN0MVEyWWxhVEF3Z2FZR3FUTEQrb3o1RTFoa1BucVJWbUhnMHpC?=
 =?utf-8?B?dUlETW5idVVJRmdlYlg3UTlRT1NoeDNXUkkwejJxamtleFpiTFk4MVhGamFu?=
 =?utf-8?B?Qzd6Rm1ManQrNC9LcXA2S3lORVlCRSs1N3lhLys3bnNCeU80Z1JoVm1YRi9w?=
 =?utf-8?B?eWpiSVNOMTFhc29hWnQzRnJ4QlZPOGY1bE1EWDlVcFM1S0FqTmFYbTZocEFN?=
 =?utf-8?B?Njh4RmZtUnBqV3hVSGxhS08xM0xGMnVONWoycjdxbHlXeVBmM3RyWERvYmVy?=
 =?utf-8?B?NEVTdzFmUWpoRXQ4aUJ6alJLUzlsbHZ1SGN4YlB1WXhRWGNTUktHM2xUb1lo?=
 =?utf-8?B?cDErL1hoaUJXVnM5Q0JTNkh1N0x4UnRnNTQyZHNoSWI0aGpDaWtpa0NVWktD?=
 =?utf-8?B?SWNQRldsQjh5R2Z2NkJNZXRLQXRyeXF1KzJCQ0w1Z29UOGluYytxRUZ3SWdy?=
 =?utf-8?B?cEI5NWZKKytoYXZIeGdEN0JQVlVSR2lseXE1SDE1T3g4TGQzaU9uaFhuNVhq?=
 =?utf-8?B?NzdLUk15czBKQzA5Ukh1RGJZRUpEbGFWSVI3US9oR1F5Y2dUQVhxMTdjcjFq?=
 =?utf-8?B?ZTQyTElqczRDWTBJZlBTcitGUFk0NE11eUd5OWlmSkFoOEV5V21pUlh0Y3dG?=
 =?utf-8?B?SlVFREt4RmtHYUlZcExlTkUxMlE5ZXN0czBnZUpvUGlFby9WaVpwR1VtRk9q?=
 =?utf-8?B?S1hRaERiVlZZVXVBMmRITEpVQ3RlWjgrMmZXQUwzNVNUUk5iVmFpSisxN3hi?=
 =?utf-8?B?bTEwc0wzd24vbDAyUVNXdmFlbWV6eVRrY0hURlROWUF1Z2FsVWtDWHZpVHBl?=
 =?utf-8?B?di9QaGZzZ2JCZGNQSE1WYTJEdEE4UXZacXJVR3RmRTNiTHZJZ25QdWZ1d1k0?=
 =?utf-8?B?M0YzRXVWMGFtQU9FcFNhQ0loRmZIdkpieG90Zk1nWEh4N1FNUVRVczJjb3hk?=
 =?utf-8?B?bit5UUJEUlZPN05PR1A5Q242R0xHNUdUYmd4VXBCNWZDOTBTbEQrZHVMWVNE?=
 =?utf-8?B?ZnY3Wk1PNi9DdWF5QkY3VUxDaTJPT3hZS3pEQ21HR0VjVTJpczFUcDNzQkhR?=
 =?utf-8?B?RGVvV1l4ZVhRZWZQejZnQjFZWVdHQ042NTE4M1hXeWhyb1FzT0lDdVlHb1RP?=
 =?utf-8?B?TS93ZTBBeEM0SDZHOGdoc3ViN1dLUUt2d3hnOWFzbHNrVlVVNEtJWlczN3ps?=
 =?utf-8?B?VlpkTGx2RFo1dU92eFhlZ2NzUG16NnJRNFZyaGtlN1hDSDBING5xOXgrSGVh?=
 =?utf-8?B?TDRqREFKZmwvTmxDUjl3aFJyN1ZKeExtUEh6MmhyRk1FeDMxSC9ZRDVoRm1F?=
 =?utf-8?B?b0NUYVlLOTQvUGxsK0Z1MmM3MnIvekdIMzJjZXU4Vk4wcFdnSlNGb3pUdDZs?=
 =?utf-8?B?eVZiUE40OTV1U0lBWi9zYW9sa1dGbEdxcFNXelIxcXZsK1VDWlZHOE1MbFpP?=
 =?utf-8?B?bFh6QkRzM3hISTlxWXVieGQ5QjZpek9rQ2NvU3YrOWIzbzFaZ0xmWjgvMWZh?=
 =?utf-8?B?aEx3VndCVDc0aThaMkpxekpEZGoyU1JMTkV2L3UxU1JXcGRyeml4UzEzdjBQ?=
 =?utf-8?B?VzZRZ2pEdG40RVVpTy9VOEg5cGxGRU82ajdFTjdXS0VGbVVXNmQ1S3JDb0t4?=
 =?utf-8?B?QmpGWWhWU1NXZDgwRVUzZC9iSnp5d1dFOGJ3UzRlS0hMVU9EWTB5OU1KS2h2?=
 =?utf-8?B?NUkyZFg3NnZFZjZxci90amhucTRsOTkvSzNXTmFuVkFjUHFQWjZFSWwwUUFW?=
 =?utf-8?B?RmltU3ZBQjVlbTNoemwvcHNUSVpBeDVQN2p3dmhpaGVoUG50K1BXdU5IT04z?=
 =?utf-8?B?Qm9pQzhjSWVDR3FzMExLV3hSdmIzREltQ3RmOWtmZTRuZUhaK054ejRnUVZT?=
 =?utf-8?Q?gi1xoRYyooj2dtyQnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9b0a68-44b1-4bae-d7da-08ded0602cee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:14:23.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsqvIDAnPX/Q7firpVGww9MFP24GltbbGvCiuUFoHNiYZQ4rC4OefrtbIeg4dO72
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

On 6/22/26 14:34, Matthew Jacob wrote:
> Sorry about the style. Do I need to resubmit?

No, no Alex will probably fix that up.

> 
> My experience with the boards so far has been fine. Without the change multiple monitors don't work correctly. With the change they do. Boot up in BIOS seems to operate correctly. Linux version testing has ranged from 5.15 through 6.12 and of course once top of tree recently.

Well that sounds promising, but somebody intentionally changed the FW/VBIOS to report a different PCI identifier so that standard AMD GPU drivers don't load.

People usually do that for a reason, so I would expect some difference the normal driver doesn't take into account.

Anyway it currently seems to improve the situation so I would say we should go with it, but if somebody reports issues we might as well revert it.

Regards,
Christian.

> 
> Normally I probably wouldn't have bothered to intrude with this change, but then the now widespread use of secure boot and the impracticality of disabling secure boot in the Kaiser fleet when booting USB keys practically means that I need to get this change rolled out so that at least Debian will pick it up and produce signed kernels.
> 
> 
> Wizard, 3rd Class
> 
> Sent from Proton Mail for Android.
> 
> -------- Original Message --------
> On Monday, 06/22/26 at 01:22 Christian König <christian.koenig@amd.com> wrote:
> On 6/19/26 20:45, Matthew Jacob wrote:
>>
>> These adapters typically are only supported by Barco on the Windows
>> platform. However, with these changes in the linux driver, multiple
>> monitor support should work correctly.
>>
>> Signed-off-by: Matthew Jacob <mjacob@feralsw.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 60debd543e44..e3ba168795cc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1926,6 +1926,7 @@ static const struct pci_device_id pciidlist[] = {
>>        {0x1002, 0x6646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
>>        {0x1002, 0x6647, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
>>        {0x1002, 0x6649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>> +       {0x1002, 0x664D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE}, // Barco MXRT-5600
> 
> Please no // style comments in kernel code.
> 
> Apart from that looks good to me, but I'm wondering if we shouldn't print a warning or similar.
> 
> It could be that those boards have non standard VBIOS changes and cause problems on Linux.
> 
> Regards,
> Christian.
> 
>>        {0x1002, 0x6650, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>>        {0x1002, 0x6651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>>        {0x1002, 0x6658, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>> @@ -1995,6 +1996,7 @@ static const struct pci_device_id pciidlist[] = {
>>        {0x1002, 0x6930, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
>>        {0x1002, 0x6938, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
>>        {0x1002, 0x6939, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
>> +       {0x1002, 0x693B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA}, // Barco MXRT-7600
>>        /* fiji */
>>        {0x1002, 0x7300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_FIJI},
>>        {0x1002, 0x730F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_FIJI},
>> @@ -2023,6 +2025,7 @@ static const struct pci_device_id pciidlist[] = {
>>        {0x1002, 0x67C4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>>        {0x1002, 0x67C7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>>        {0x1002, 0x67D0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>> +       {0x1002, 0x67D4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10}, // Tentative Barco MXRT-8750
>>        {0x1002, 0x67DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>>        {0x1002, 0x67C8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>>        {0x1002, 0x67C9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>> @@ -2036,6 +2039,7 @@ static const struct pci_device_id pciidlist[] = {
>>        {0x1002, 0x6985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>>        {0x1002, 0x6986, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>>        {0x1002, 0x6987, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>> +       {0x1002, 0x698F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12}, // Tentative Barco MXRT-4700
>>        {0x1002, 0x6995, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>>        {0x1002, 0x6997, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>>        {0x1002, 0x699F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>> --
>> 2.47.3
>>
> 
> 

