Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A07FCED26E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 06:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A2010E141;
	Tue,  8 Oct 2024 06:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYHZipuw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6497B10E141
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 06:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0bCyYimfVFKSqWLKTemYVAqt6EdiG1xyrEANgoPk3baxayuYuq8yoDAz+xbNberLtdx154Kuo0OVWnrXz9NJgcnxseWtsx89RjguoGgltQtmdCy5yFIR6JCGuz41q1rKQnmfSDTMfc+JeCmJgm1bfqzCkrZCS9WEjotFWry/GtMOIxcTahZjHGH6FBfQdukCgO3aVHQ2leIGv4ibCW/JB1apwn6gXgUKoBcflxV97YvjboVW0UiqlfJGfBvJsaEjFCqopTAiyBdvx7VNBBcQRiwpJUQ85YCHivCzGvR8/Okew4NuIucgnre4phMg5wF7Nyhh1JKSetG8k1aw+XI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsNHO+tnnmuelgWIiT2G+1B3US8JzSUNbfz3FL8oJls=;
 b=lxNaCkVhymbXCHcq0dtlBB+ASSv18xxs81qAWzYBLo+lY8ytndcUSyVprgHgT8+dhZuYMxfeM8RdMg9VraLceOaE+fsMLOSdR/NR/gi2DGUyO4gCXN172M7D0im/X8YPnZ0W416oGOJpNNaFjrhxesdStopdrseGhOVPvmKMvSQiW+CnQUV7VYyOqY+3OMCbMSX70gb3p3CY8KqTyIYVu3rjUF20FPOa+GtzgrPNFz95Wrawwzb9JHmWue60Rn6ijpHVdmM7Ivbpy7mygPXBKwxL/CYyRBV00SuXFDV02VVtaahxDS/Zm6nLZ88k4Tw80+lIrLN+YUbBzKfU5j0I0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsNHO+tnnmuelgWIiT2G+1B3US8JzSUNbfz3FL8oJls=;
 b=fYHZipuwDbv/LEVxcocSu0W0XLn3x1Da95jfscqoAX1cAYmRAYUqvUPN/hkO2TrcPgFNXZ2rXkcnZAW0ORcc4uGrqKk7nTHHPoI4T9klXG4rSEGvwBmvfJ90Dp9Tssw9bjqLmrp6qBBpKpz9KE6tY9w/Y4xA5MvCV86f1y6H7cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 06:28:45 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:28:45 +0000
Subject: Re: [PATCH v1] drm/amdgpu: Clean up duplicate ip_block object
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003134947.268245-1-sunil.khatri@amd.com>
 <8d52cdf0-5ed1-4945-82da-f9117885703c@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <675e34d1-e3fc-d151-c0a8-a7c569d4acb0@amd.com>
Date: Tue, 8 Oct 2024 11:58:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <8d52cdf0-5ed1-4945-82da-f9117885703c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: c974dfbe-2f23-4240-32cd-08dce7627602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTgzajdralhVcnhQUDhQVHM1VGt1VktLUDFZbWhmaWZLZEVtSWhkVkxUQWp0?=
 =?utf-8?B?bEhmQ3NjVDFZSkVETHludVhnbllhWTdsanNXb01wb0ZVcXlESnFZUGp6STZu?=
 =?utf-8?B?ckxueC85T0U3NTNFajhHVFhZZEFPeG93OGtnZnhnM0xMM1ZCOG9zeThHT2g3?=
 =?utf-8?B?L3c0WU1FOW4ycXpLRng1RDRoMzg4dTkrU0hJS3UwZWE1L0xDcEk1SklpV3cx?=
 =?utf-8?B?Z0ROekFnZWNKUTZYeEttaXhtS290Q2tuMVBpNi8vSGpOSjBjNmRWTnhtSEpK?=
 =?utf-8?B?eXNLZk0yR0JNZDFoOGszWFlMOWR0dE1vdzhFSWlnZDVOUFBwR0llV1V3U2o5?=
 =?utf-8?B?MktPNUlSSlN5eDFwMWVxTVVIVnYwU2Y1S2V1Y2FSNFpScE5ONERHZExhdGdt?=
 =?utf-8?B?eWxSaTE0N1o5OUFuK09BU0MwMFdheWhOdURESXNURTgvUmdCQnY3SG56Kyt5?=
 =?utf-8?B?UjdMU2toZE9nWmMwbHlyb3VRNG54YjVIS0hzTXpEblByOXFzR3Z6YzJ3S2gz?=
 =?utf-8?B?SjhnY2xlamJJTkk4dkllRGY1WElwMHE0ZElkRGt4ZW1zK3lySkQ0K2NsMno3?=
 =?utf-8?B?MXpCaHYyWThScFlabzFOMzdjNFVseTRtYXlGakl3NWVZTmt3Zmt4MGd5bFJO?=
 =?utf-8?B?SkVtbmJQRUR6YXMvZkJZd0crd1phcEFEc3Z3K1BaS0JVT3E3eURGQVZTYTc5?=
 =?utf-8?B?eVdmenlxdGkwaExETUJLOXdIR2FMdDkzb05YalB5cXZJWlJlWmtmeTByd3Nx?=
 =?utf-8?B?Z3k2a3paWnUwaUVkeU5rVERBWS95TGJPakVUd3c1ajQ4ZXZMNklZV1JRajU5?=
 =?utf-8?B?QzM4Y2piVlRvRktQc2k0OXNyRWgrby9WNGdZcnp4dVliZS9BbDN6UDZ0d2xv?=
 =?utf-8?B?Q3ovUnA1Y1F5ekh5cGNCZ3M1OG1Ib3NOZzBhTDFidkw2NVlyZVpxakRVeGVn?=
 =?utf-8?B?T1BkSXFZcHZ0b01TU1dDYUxwMHNmaWJTdnJmdmIwVFJVUDZURjE4TE04UU9j?=
 =?utf-8?B?blR6RStIdkJPcjd6cXN2Y3RhbWR4dE9kNnQ5OHVTRDJSZE15eGovQVcwOG9W?=
 =?utf-8?B?czhSU0J0R09zZkhhSCsyczkzRDNyTGhZOVBadTg0b1RHa1VFUWloUXdUQXM2?=
 =?utf-8?B?M01FYjQyZUQ3T3Y2Yjg3aU5RazdwOENnMVpobU9kNVE4OWgrMjk5ZEJYNlZh?=
 =?utf-8?B?TFhMM21aMmJPUWJtcHNRYW9Wa3FHZm43dEtyL0p2cFZucXlxOGlGQmFHaitn?=
 =?utf-8?B?Vnk5U1pHVGVveGlNUnM4VDdNM3JLb0w5Q3VydXdlcmp0bmtSVDNORmJuS3JB?=
 =?utf-8?B?RXlhMW9CRUFyeDBxNXFMU0U5Uk1QR0RFQk56cjM2UDZXQnJLTFdEYW9wcDFy?=
 =?utf-8?B?TVBMRVhZYWFrQnhjQzNGL2JPSVhmTVRBZnFsZXFxR0s5R0F4TmJ5NEZrbzhy?=
 =?utf-8?B?Z1Zwa2FpK0J5MktIZUxYR000NjkzNG52SXJxeVZ5ajJZZ2lUbFVLM2Jxc0Yv?=
 =?utf-8?B?TlVxUmlRd015S3FhbE5ZdXdKQUxLM1U3RjZEYlBGMExrbFlNUjBrU3RiNDUy?=
 =?utf-8?B?cFlidWRDWDFhZXhsdEFIdTFVUDRjckh3b1NLZ283ajNRYXQvV2hHclpMRzJj?=
 =?utf-8?B?WXpObFE5QVJJV3U2andMSDBjaDhnMXV4WmRnU0h0K3Z5TDhwOVNNV043K2Nx?=
 =?utf-8?B?dlUveTdNY213SG1iSUlERWFrWm1zOE1meGFXT28xOFZwUjBYUFVIZDdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pLQ2RZdnoxczZwNVB3WU5nK3ZmOTR4MFdObThGRmJ0RjJSVVdYRi9aSTln?=
 =?utf-8?B?YmF6OXlBTUx1R2ZzYlQ5UCtUcHRrTWU4d2tEKytOSzdsdHpmK3l0eGEvVlAz?=
 =?utf-8?B?a3p4TjZxd2Qxb1ZPNGZDVlQ1Ry9Tb2ViSGpLSlNZb2VQaXo3UEczaGxKZjZ0?=
 =?utf-8?B?c1BCK0VzQXBxQVl3YVZSWnF6RW94VEoxNTN6V0V6S3kxZGlqQ091RmhiNUx3?=
 =?utf-8?B?MXBBcGhXN003bXdLZ1JsejNIaTNXcVFORy9CUmljaUxSN0RrZm5yUVFTTGVy?=
 =?utf-8?B?MG1GQU04dmVOZ0QxclNVSFNOc3ZJdlhYUzBtcDloZC9KZlUwdmRQdWRwZmMw?=
 =?utf-8?B?TjVLS2Z3VkJrd1VidUVzTjlpRGp1OEFHQ2szaXM5dG93U21jUTB4NW82c3Yx?=
 =?utf-8?B?QkFXcVlxc1BCaDdSdW5EY1JTTlZEMkZVSlBoaTlHanNsS0dkcDg4SmlxVEVk?=
 =?utf-8?B?a3NwNXA5Tk9ycjExN3Qzc1p6amNLeGEyTmFBL1h2Y0ZyTmVNbjlQTHRFOHN4?=
 =?utf-8?B?RGdDZmVnTFFrRGR0RlRZRkI1ZGt1ZXJWdlA5UXdLak9xaUR6V2hva2tQY1B0?=
 =?utf-8?B?dERHSTQ0ZzJMTU0yRng1OFVWdExvM1ErTmF6bzR2QWIrNDNTZFFuQlhsYjRQ?=
 =?utf-8?B?dGpCWVV1Y2V0OGExd2JRcndmQTFpNjFNN3V5aWtSMFl2N0piK3RnQ2NSZEdX?=
 =?utf-8?B?anBOZXB1SkZrU1VVdmNZTENQSThDRnpVRlFnM2doYW9JUWp1RUVEYTFOZGpl?=
 =?utf-8?B?UWhqQi9PeTZRVVowT05Dc24rckdTWVFTSDNLVWp0eVp2bFQzV3YvVjNjOUNH?=
 =?utf-8?B?aWpPVDk4WWQzN1I0Wm9VWW54QnlmbWVLMVRIYityektsSHdYdXloZ0pFT2J3?=
 =?utf-8?B?SWY4a3k2ZlFwMmxibmIvdGg2Zlo4QnpMK3Y0UzZVK0E3QjBRVHE5QXRjNEsx?=
 =?utf-8?B?cUc5eDBoVGZPL0UvMC91cmQxdDNEOTFXd1FNWWc2VitFVFFDOUJPamtWWnYz?=
 =?utf-8?B?b2FkRnVkZnlQb0FZc2ZWa1F3VmNWaU5mUXdIQVlGcC9mRWtaaVlRRW9yS1pj?=
 =?utf-8?B?b2NxSmQ2RmxFWUhCbmtoY1h1MW1hTmtNNkRqUnRzKzhHdzN6Y1pUY09yT1F3?=
 =?utf-8?B?b2JuZG42WlI4YlVEc2NSOUJ3QUVCK2JZNngwRFJIQ0dxZllEek16SklZYTBs?=
 =?utf-8?B?YUxEL1l6RVp5NXRHQXY1Nks0K1RPMWhMcXFYcFd6dGZZOEFZSzRVcEpnL0hP?=
 =?utf-8?B?ZGtXN2VjcHFuUmFlZ1drYzRFWlBuRy91ZGJwQlBiMmM4VnRNbXNOMFJaWHFU?=
 =?utf-8?B?YzQ2di9DV2d4MUxUbWZ5VFpXNUdVeWVybFJidEh1OHdqVVhtTXUvWHBHSDJF?=
 =?utf-8?B?emNqdTBWSHVRT0h3bmlkUkVjSW13eVpUR3V3SlhmN1dhU2Z0M05HQTBTSFVu?=
 =?utf-8?B?VUpVSGJFMTNhN2pqeVlHMWZHdzBUQlQrdzd5TG9PUHpHVzIrZXJzYUNoTDVJ?=
 =?utf-8?B?SmRLZzQ0ajB6TTZFczh3dGRYTmF3SElKSTNYbUxkNFdzM1FjY1FqbSs5Ymgw?=
 =?utf-8?B?SmxGbGVyUERXckJCd25Xd0psVDF0WHhtMFBNWWQrQVFWSW9RZk1NTEFCcll6?=
 =?utf-8?B?TCtibkc2eUV3VWpMcWRZa3RneVhmMXBYTjVmTDVwdG83eEl2TjYxb0pkYmcy?=
 =?utf-8?B?a0ljQmdyV1FORVR4SDhaWnduN1F1MkR2c3ViOXg0ZVExVUF5OVFkUnlYSkFn?=
 =?utf-8?B?bW5qTkFpNElMcjNndUpUZ0NXTjdqeUwxZDJObTJGWVpJcE5JdnMvaDlhZVFC?=
 =?utf-8?B?OGZrTzh2dnJ3cy9TcjlBVEM5WDRKVE13M2Y0c0U1Uk84cWJqdFB2dGJHeTE1?=
 =?utf-8?B?SGJsSW1jemVGbm1ib3dHeGRoeWRCYzVNSENqaHBocmlhd1AxWDl6Wkw1Q3Bh?=
 =?utf-8?B?QUM0akJCdE1TRG5RRldOcU5VcUhmVVJNUVdHNXdta2RkbGJrbjR6ZHF5MmN3?=
 =?utf-8?B?bTlmcmlyc2hoN2srd2hweTFBSTZxQU1NTW5nYVNhRCtqZmFvQTlURHY4aE1k?=
 =?utf-8?B?Tlk5b1V6WjBZRXNHU25keDIyRjdQdllxNDRHclBzZXpVR2NUV3RqeStRV2lR?=
 =?utf-8?Q?PdETPBh/cAf4WZZ2cpDLi57+9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c974dfbe-2f23-4240-32cd-08dce7627602
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:28:45.5081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg+wnDJmgPuO5KbdeSeLH4nLlWPwv9ENTGRr06GAq6uGqF8tCHVCp9YGwhjJuCUFytC3DsgaM14+89mE+AnDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
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

Yes Already Pushed.

Thanks for the review.

On 10/8/2024 11:47 AM, Christian König wrote:
> Am 03.10.24 um 15:49 schrieb Sunil Khatri:
>> remove the duplicate ip_block object in the
>> isp_hw_init function.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>
> You probably already pushed this, but Reviewed-by: Christian König 
> <christian.koenig@amd.com> anyway.
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index 416e8b3fad79..adc0b80ca5db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -54,12 +54,6 @@ static int isp_hw_init(struct amdgpu_ip_block 
>> *ip_block)
>>       struct amdgpu_device *adev = ip_block->adev;
>>       struct amdgpu_isp *isp = &adev->isp;
>>   -    const struct amdgpu_ip_block *ip_block =
>> -        amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
>> -
>> -    if (!ip_block)
>> -        return -EINVAL;
>> -
>>       if (isp->funcs->hw_init != NULL)
>>           return isp->funcs->hw_init(isp);
>
