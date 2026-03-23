Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316CFD58CDC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C030010E307;
	Mon, 23 Mar 2026 06:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6+v6Ova";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D7D10E307
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1Zv6Hqa/HKSVUWjsM8Kwf4HKm9kgKRSVBP20ngPodxUX1zC4z4E8tBHY9/XXuZ8/XWmMDcDwD6JeKkLdBMxsF90mYTXxZV2vvzX69Txdmw/gx4OUAMsPPC+uhcK8BNE2k2GXuFmy4aO9c2xM5HwZ6RclqyjB7S9JbJopBXe05OBegg1CZ1dW/nFyPshiG2aoNo4tQkR3631GLNZacldnFITvqBs3gjzdGA6lotAUdA3kUinHKj9sOa/7W3irzS7pa7g0PXOp37u8gIptDvxmhXaefY+Sw28B32SG7MZOhr6XqzXXXPCWJ25H5EViwkKPy5zIA394oAHPKkKieP+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL+j0Jl48jzvbybp0OmS2IVDcIDn60kqdz/l6YXRD/Y=;
 b=ZILphDww6pP+sF6rliZLPUQAOZvgffdJlKs5IP4ff954pAOVxwlpBsPTTnmNz1tluM09wKJfdZuLj0vDktfA+dEPuSoGxK7AUzFYNfo23hAN/5zP1j1u185Wv0vCe6hdPvv6h9eXTZQ4H1Vp8u3pxeNfggFneZHUF3/4C03fZmwflmIZPv68UUHAY5qsZ+WIvtGtUMDdPgoXnh8L4FPC/5OFTO9cFiSiFl5NBAscE4L+oCavfb77SCi0Y0VuWIejJVuwk7dH2H6UdXLr69RaThiffl8wPA4WaeJDvU6/AxfYKbBMzptnDGj7VnTzFv8pFTwP4NoTzfFpnNciU6GK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL+j0Jl48jzvbybp0OmS2IVDcIDn60kqdz/l6YXRD/Y=;
 b=C6+v6OvaBHlkvHfQtAbzVVfoIQ2w/MPbanPlwcz/WmzVmy7rK/nTscktu+aD2QoOifApx7Jx2DyAc+wfv9pscltS0lWK/77twucNarIIdLLx0CPAN1uIk2fOLW/pLj6pGBvWoLIJJL8zSPq1v3pHldn4UKU5sgdb+lJp13GZDiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:23:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 06:23:42 +0000
Message-ID: <364339ef-bf20-46f9-89eb-1ff624e0e19d@amd.com>
Date: Mon, 23 Mar 2026 11:53:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: use DISCOVERY_TMR_SIZE in ACPI TMR
 fallback
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323060420.426580-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323060420.426580-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: dee5db5c-528e-45a5-30c7-08de88a4bab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: aYHGc8cwG8C5vqcVzcWNLbmr+HUR0fREBWPsLgzd1GgZM7ed3qqHi47DWZ5mOcxX5eHK3xe+Z2occF2zUQNyQ3c/05EGZKmxqs2tcMsC56ve95/qP5cXG1TuOOWnEf61dTLQLHhG4e6PSKM68DCwPxu2+A7BO7PNsr4ZfjSiSW6phOSZot13LXswMXePvFqSFhQ5zuCts4pTZ+aep83RrOERuTeFhOTJYey9cN559RGbQmxryK2n5jpEvP7KYjqOBRNmUXaLJHZ3waGwzit1oEFuHspkgv6GOt1QA8EHIML3yIAg/HL2cExwBokUIdkZQ9D2Nov2kAHjqmwOz0wrLfY/RRHf37VSSeFHa2bLpBYtH11Rk3YqFNfhS9AAUb5eXJ9ScYRWMcqOvqKKVIr0AQVv77kgPojhRxSEp4kXoMi+gRHVoM8Wan1Dw/iL9WISnUFde29j/rGRYlm4P6kiBZEEbFmSkoe7WAHrpgGWaGlrGtu3UIdpIXuFkfQm+FfOruuCxpB7CWJFS3nwYqMBCUXPyR+7WYHQFKpYQKslO81fDwUQLETf25CFhpsqOMStML6Vi9WHe6pV+gCnVnhSKhiIqlwdLuh06BMfeHEBEVcBqCNxNRpr9ZYShPKbkDPzxMXO8Q99DAQi2cx90gBmE9sI87iUv0hmvxei5wRiHve48SpU/ck0hXg+DcS/6n4rtslzhyfjZ3uEIEMaAhiX98iC94AGcWJo65CBNC4ll7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNRYklPU2hJbklzWmtyazh0NVprQjd5eWlxYk5OSWtrOUNLTlZjUDljNGdM?=
 =?utf-8?B?Z1dHUnA3QlV0VjdtdHl0VVV4NkQzbVZjZkJaWGtISFdYMjE3NG1FUDN0UXcx?=
 =?utf-8?B?czRhaGdmd2l1c05NVkk4aU1TVFo2eUJiQStuZHVXeWpNenJ6L0lmSUJnWGVp?=
 =?utf-8?B?Y1RsQUZPeDdPZmN0Qmh4Z1VoVzhKU0xhdEdOMGdNTDM1NEZoU2tpUDYrdk5z?=
 =?utf-8?B?Sm1rcU1kK1ltR1lkOFA3NnRNUC9uTkxLRWFua1U4YWtTNG5iVlZXNHorQ0c4?=
 =?utf-8?B?RGxOL2dmVG5rRUZVRXZCRmN5U3Rkbm1kTFByakZGdTU0azhRYmJ4dEpjTklW?=
 =?utf-8?B?UDllT3g2cG5zY0o1SHYzNGlrRlNET0Q3QXlKUkFKRjRwSXhLVW1iTEliM2Jz?=
 =?utf-8?B?azRZYVV6UHBvZnJBV3ZCOUlsN2JqQSsrdms0SlV2VThEK0lrdUJCeHVodVhk?=
 =?utf-8?B?WUtjVUZyY1J2dUNlMUg2VG5tMXFnZ1dqeGQ1OXQzcGk5UmgybCtpTVJDWU1E?=
 =?utf-8?B?OUxNL2ZjeHgyQkNRMmRaNVZtbjdSdnE5K2Mvd0xTb0NaNlRmdTVkYm1EZXB5?=
 =?utf-8?B?RXB0NE1xVGZ1RE5sSHlrcTlvdWhsT0VlUUxiYVZNTyt6TUwzakJIYUlRR1dR?=
 =?utf-8?B?Z2NiYnZhYkFpNDNwL1VTQWljc2lEMTh5dE9zNEUyL2xRMVRRc2Qzd2Fpa20x?=
 =?utf-8?B?NndaQXczZmw4RVJ0dGxUa0ZqcEJIZjRFQmI3Ny8yZG1LQmtmQnZhK0M2NHFN?=
 =?utf-8?B?SnNseE56bWVBTkV5ZmNBWHRIMWVUbjc1bHIxU3kvNE54dnNMNEkyS29vaWZx?=
 =?utf-8?B?bWRiS0pKeDhnTWsyOUJ0MGtpM0dKVU11U1ltcEY0Z0hLQ2RBeklLS2J2YSsv?=
 =?utf-8?B?WVdnNTFpRTZhNWRnMmxkS2JhWFg5QVJ1TGdlb0F4bGx5WGFxbldhK0xJcjNE?=
 =?utf-8?B?MFdySTVhdk1EVUQwYXhQZ3RPaWh2OFovbDJkRGZ4ciszdmpHNmY2WWZHRk9z?=
 =?utf-8?B?dzl5OUgreEJxeEd5b1FOaXZWYmxIZjMvcmF5T1JYbWRESzFGOEM0bDJQcFdC?=
 =?utf-8?B?eXpZUjdMTVkzWWV6ZEcwRkh1a0hhV3IyNTN2Mzh3OUN4VUNTWmRYSS9VUE0y?=
 =?utf-8?B?WVVSblZVMU5vKzhvZ09BMnJpTnVDbFdtekp5UmlCL1pNR213SmM1bE9xSm1M?=
 =?utf-8?B?dW81NTNDck0vRkFncnFqY24rZlRvUTlVQ1c2OTZIUllKTlluUk85OHB2WGdL?=
 =?utf-8?B?VHlsWmNaRklYelVpWkZHRHIvbTBhWXpKbVpFaktJbHd3eEdLL004UlRzZ3M3?=
 =?utf-8?B?clBLMUdPSTNrdUNWYVJKWUxXRnR3L1Qyam50U1VzN3QwQWFvc1haNm80bGVm?=
 =?utf-8?B?M21QSFhESkdTUFVkQkhrS2ZwTktjU0k5VCt6RXNvMEhrblBLN3d1QkoxWlN1?=
 =?utf-8?B?ZkJ5M3dyT2xSZ290QjdraWpES0pQbXo5VjkzbTJUNU56RXRRdTYyVjQ2blFN?=
 =?utf-8?B?QzhPcWxGU2dKWkF6ajgzSDAyWlpoc2NDR1dLeG5KYzFjTXBFWWFKMXE2SWlx?=
 =?utf-8?B?Vis2ZGZiLzRteUZrZEo4b0tuckh0dGNqYnVoT0t3VHJpSnhxcGk3ZWZrR1lx?=
 =?utf-8?B?UjlrMmFmT3NpQStUQ1ZqeXN5VjBUQnJsZ1hBR3VOQzdZMEpMQ3JoWThySEM4?=
 =?utf-8?B?Mi85TkpDN21IVXdyd0JUbDBmOGdwMGhIQzBlWFo3SEI3UUYxMmorM3BieHY2?=
 =?utf-8?B?N25rcXpscFhtMDRXL0crdjNWNURJVzVRclFjSzNTeXRsalVMcjhNU0g4eW8y?=
 =?utf-8?B?YWtlcE5WZkJGWUcvRnMxckcyT1pvTFZvMWErUmRTVzNxZ3ZEdGJVOUVUbVAz?=
 =?utf-8?B?MlRmWG4vK08wRk1CK3NEYkZ6TGlqbmpsODhKUlVNNzJFTjlQam5RNEdYQmo1?=
 =?utf-8?B?TVlrMXlZM0R5TWJXVk91YXZnYmVnWU54Skt0YUluc3llMU1XSnQyMWg3WUdq?=
 =?utf-8?B?bFB4aGRDcDc3QmNCQmtEcGVlSVpjWUc1OEYzaGoyWjdrK3I1ODdvSGo0TEcw?=
 =?utf-8?B?OS9DMUVnM29Db09qWTJBQ01hNWkrVUFKc3AyNGhPZUprVWgzY0swYWNGTCtq?=
 =?utf-8?B?ZnZtL1Uybkg0eFRhZStRL2ZxOUxxK0J1YmM4ZkszZlhZaEI2MXJzUHlUSXhs?=
 =?utf-8?B?OGRlVFRoamp1WkZscHMrdnRUWDYxTEl0b0hrckNhbHc2Z2tQS2Y2eWd0YjM4?=
 =?utf-8?B?SXZzYmFPRG5qVGNDcUZ4V296MWNTd2ZHb1M0RFhxY0o1YlVqU1NvNi9DR0dO?=
 =?utf-8?B?ZkZNOGJRLzRDeDVLakdyMUlZTXgzNHVRSjFuRitsU2wzUGYyVnBSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee5db5c-528e-45a5-30c7-08de88a4bab8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:23:42.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLDd8eUl5sSpQHO3S/5qrzXi91bXDS4eRo/JvxghCCyuTLcfGaAq5TDBnHRG1IDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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



On 23-Mar-26 11:33 AM, Jesse.Zhang wrote:
> amdgpu_acpi_get_tmr_info() returns the full TMR region size, not the IP
> discovery table size. Using tmr_size as discovery.size can lead to oversized
> allocations and probe failure.
> 
> In the ACPI fallback path, keep discovery.size as DISCOVERY_TMR_SIZE and only
> use ACPI data for offset calculation.
> 
> Fixes: 7055e5157742 ("drm/amdgpu: New interface to get IP discovery binary v3")
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f7f37d93d0ce..c42bd563467f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -324,7 +324,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
>   			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
>   			if (ret)
>   				return ret;
> -			adev->discovery.size = (u32)tmr_size;
> +			adev->discovery.size = DISCOVERY_TMR_SIZE;
>   			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
>   		}
>   	}

