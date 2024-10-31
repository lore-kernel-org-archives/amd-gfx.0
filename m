Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E22E6896B
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 09:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9985510E84C;
	Thu, 31 Oct 2024 09:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFkc1dSJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300C710E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 09:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikdY+q55nxwmUZpZBLR/IEbxszgPbKYW84+puAxy1IFHDSLdveh5KaTO/96t5pYvVZTtw8DGfq6lbsT7syBFuQS7icJFYwsS3F96xOBy3cBwbG9Hn8v5HNIXxf9NMpulNbLtdmPdz6BNrMaJGWcnrpALXN+Pfvb4KGwToa/NkAxGPE994hofouuqLolk7O7GQvUE9E+O8ZuGxnyRVunFPrRdRze8UqC5koqbsZJR+2iMtFIETeGy+MIlMirJbqcymhkhIPFqhhjoke0t2bDloI/G7Djz2FHceQYhnulSLE4QylANhYofaLxMkFAJM2WajcizSC1NZqaIf3e2b/FlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHRPKmGJkU4rYaP13aT7Msm0S3preaTN1JpEBUmBeeY=;
 b=tAn+TKDtX6iYr2TjBbDTpEdT/5BqRhrhBqcH8bDMlKuvSxdveRSf9tOXYYJq/z9urzUlVM9pGm3FZhqzbS9L7YGIj5qHPDgMattsqWJnKPhJtdP57ZzZXtY/9MUC4Fs8z9E+6CoJXXi9Oh7TeDVNYX4v1vDccEqwTjwkyHiiEsmXxAm65L8QW8X+bMriqMfXYy03IBjuVv3YvzB9w6QWGrql5ZDV6SPcGFUi4A1B4yPzPhGIWVQeCQJaPl2i8XBkaD6jdlip+D4DBxExUkRC6zjM7WiXs7Eq1/RNPcXeZ+OjNyUU91ZUYvQVZHLAFLsVnYFGDAzHOJBlH0tW77EK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHRPKmGJkU4rYaP13aT7Msm0S3preaTN1JpEBUmBeeY=;
 b=wFkc1dSJx/5nlnQQd3SdEAnbNoICkNcyRfq3TNj6P/uIuAnoonD8iRVN8iR+OOTGrwJcQIiRLH6ig9u7HwGO6HQXF0iLaLn3r4UV/h75Swfi5sVX133ykAJR0vpo6DN5LJ6hSabex1JoM/N/RxMjxqpRAultXgv6BOxlKl9KEwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Thu, 31 Oct
 2024 09:54:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8093.021; Thu, 31 Oct 2024
 09:54:01 +0000
Message-ID: <85a76c07-5a04-45da-af1c-08909c4ca578@amd.com>
Date: Thu, 31 Oct 2024 10:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: remove unused ip_dump from vcn device
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241029135020.2494491-1-sunil.khatri@amd.com>
 <20241029135020.2494491-10-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241029135020.2494491-10-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db9d66a-71ad-4ffd-9503-08dcf991f25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SitIcTFNRHdYYjNWb2dMcERDTWRVRXlXbzdzeFRCUWxwNzNVMlAyRDFOOVpH?=
 =?utf-8?B?Q0xZZjM1RnN4MG9IL2lOM0FMdFRvam9lbXJwYnZhL3hGVWFnRTFIZ2l5OHZ3?=
 =?utf-8?B?aEpqb1J0bmg4a1VaZDZyd1B2TXg3OXBGNjNYNmxQSHJGcTlVSUh6bDhkSG5S?=
 =?utf-8?B?SVpreTFtLzBYcmoyVG9mZGwxdXZyOFZ6N29JREpRM0EzMWJocWJoVlNrUkdj?=
 =?utf-8?B?UG9ETmpyL3Y1dFB6OVIrOEtySXE3M0ROWWZVK2Y1QjRwOXhwWGVtY1BTeWp1?=
 =?utf-8?B?bCs4QTNrMGhNNXNqb0ZMbUhHUHkwM2RPR05FRWRWNVhJWTR0SjBwTDNicjBG?=
 =?utf-8?B?RWRuT3Z4aWJNUUxnNCt3eDVpbjUyV0twT0I4M2FwaEp6WGthNDU2eDRGMDFi?=
 =?utf-8?B?MzZlelRtTWlvVDBaNXRBSzU4RXphbEVaa01ZcXF2UmVOS2pZamtZWkhLS2tY?=
 =?utf-8?B?Vk5SR1B0aWVUMG1FUXR4eHl4dnV2TyszM2g4anlNdmsrT3hGdVdiOVpyUFhP?=
 =?utf-8?B?UzNBaXNWbFk2NHBEdFZ4UitSR3o4dWQ4a1hmeDIvaksyaDl5anV2WmJQeml5?=
 =?utf-8?B?TEx3ZEEveHpjUjJOOE14WDl3Z0Q5K2xYc2hEcDE4cjVBWDFScmpBRC90MDB5?=
 =?utf-8?B?RFNUejFrbDVsYU9EVUl1M2VxSzk4UnlJYzdDM0lnSjl3YkhNSUNQQU4zTnFM?=
 =?utf-8?B?SVdDZkxZcTVLWHFYRmo5OHRJc2pCM0Y1YkMzZEN4QXpoNzIxK0ViNy9DbFNj?=
 =?utf-8?B?WnVYeCtwZWdrRjBqL29HT3lPUFQrTlNHeFNEQkg4M2tmQ0IvSGIxMVhoTTJL?=
 =?utf-8?B?SDJ0L2szSW45a3I3cFZhdFpSMkZ0UHo4Y3h2TFZMYnVLTm9tendLc1ppSG80?=
 =?utf-8?B?RkRobVJ6UGtFMWU2ZnM5eEhMU21lUFlFUDdpOXBHUXk0OGNMMWJWbURJL3J5?=
 =?utf-8?B?YnhLRXFLSWI5RVpkWFVWQktQcS94NDBwYll3U25xSXBWTDZ0ZDN1dkpwYU1v?=
 =?utf-8?B?R2dlMTkzVFNpQzZKaFJTVExHV2hQSVpkRlJpNUJRalA3N2JYdWZ6clJjTXBl?=
 =?utf-8?B?QW5ONGNSb1M4VDZ5VHl4MmhiWnpyZEFiT1VLQWZXZVlPcTNjVXlCQTNVdjNu?=
 =?utf-8?B?S1hVZkdKdVgvYnQvZXVZT1RaRGh0M1BucGxXT2I3S2FuYWN2akduU0dqRlFT?=
 =?utf-8?B?WDVISXEyZUR1ZHJEejRhRmViMnkwaFkzeE14NnJBS1grbWhzMHFuTVorK0dK?=
 =?utf-8?B?TzByTkpvcUFrR1pOL1ZyTm5ONjU3R1BJTXdBQk9UbHFEN3JZdGV5QkFWRFVT?=
 =?utf-8?B?Y2phNlBZQVgvMktKS1FKMXpLd2ZkenpjNW1pTE9rTE5UdXRuZ29CVmFMMXB5?=
 =?utf-8?B?eUN5dVlCck1QM2h3RkFaYWE2c0JjaFZpenBRaFpKRmRhMTU5eTU5QUx1eVZa?=
 =?utf-8?B?WUI4UmdQSURpUS9GU2ZKMDZURG9ObFhHVk9mcytUQnZaMkFQMW8zcm81TWMx?=
 =?utf-8?B?dE9jeXlpWWQ2YlhYeStpa1dsMmpwOHBXTjVVckF4OUt2R1NoQzg3a3Q0blY5?=
 =?utf-8?B?WE5ZcDdXSWpuQUZ4R1Q0Z0hYbDNNTXZFNVVDNjJYL0NWNU5mdE4vNmxhd045?=
 =?utf-8?B?aGE4bG0vcmZ0NWxQVDl2UkRkZDJ0RGZZbVJ5dkdWY2tMWjdPTE1iVUJOaU1y?=
 =?utf-8?B?dE1JM2YzdkU0K2k2b1d5Zm1mTnBIa1ZPUnZFcERXVzhwU09DMmVUWG92TjE1?=
 =?utf-8?Q?pZpGCP3pnr+/Y/L9O8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkpvLzhxa1NvSFA4TXAyRFNadm5COWx4c2tXaXFndEkwcVZpcDg1ZHpwOEcy?=
 =?utf-8?B?WVhYRUp2U042OGdXWC8xKyt6YWpFalhCQ1llR1UzWTdYZDIxeWtVNW1IY2x0?=
 =?utf-8?B?ZDQvNmtEOHVCMUtsVVZ5Y3FXU3V6ZEVpTGp4WDBkSnRKRTA3WTdaaEZtb0hM?=
 =?utf-8?B?SWtHTmtUUVNDajdVOHJLNldQTHd4TTdJZ1NXK2kwMWVycVVHVFN2V0tHT0hq?=
 =?utf-8?B?U3pQb2tOWnA4MTMrMlJmR1NyTXdFUS8xbloxc1ZjZldtemJoRE0xUWc5N2xC?=
 =?utf-8?B?MlJMV2o2Uk9KSkJTcGlHYUNwTUc3S3Y5bWs1Q05jd3R4NE5zY0hFSWR0M2ov?=
 =?utf-8?B?alVvT1FVSFUzWTZncjl1TEJhUEdLdVVmK2JKcWVGK3JlQy9xUEVEQml3Q2JS?=
 =?utf-8?B?d2trQ2FSR2QrWlh5U0Q2QitLZDNqSzkrVTE2TG14aEJyOTY5RE1PSFc4VlFt?=
 =?utf-8?B?VHZIVW0xNXNzVGd1WGdrbUl6NjF5YzNLUXRqdkVrRXVPUEF3VFgxcHF1bjVr?=
 =?utf-8?B?YytvbmdObVVaMTc4c0RRVjhDanpNMi8xeWpjVXlvOHdwckNZb3plRjBYSkZu?=
 =?utf-8?B?U0hDTmxmbjZ5YXdpdXY5SjZ2WE5jUGJMSFpGL0UxQW51YVVvNkZOQmlMdGcw?=
 =?utf-8?B?MXRsTFU5dUhacWpTRUx0MFB6U3JFZnpuMks1eXZzUXozdnBWTWpXdUZOSTFJ?=
 =?utf-8?B?d3dwMUZXdUhMR3YwMW5HZkp2blJlTnVOV3NEU3B3bit2WFkwK2MzM1FVQTMx?=
 =?utf-8?B?b25YbkxsK3JjTUZFdXNNVExmcnNqWWMyclpWSENxSkpHT040b2t1M2pnWndK?=
 =?utf-8?B?VnZ3aGZ1N09HTjRIR1Z3ZFhDNXVsdUt4SVVVemx5Z2dHbFQrcCtwamdMMHN2?=
 =?utf-8?B?Y0xUN1hydzBCUUt0NnUvSCtxTkRrYnNWRnQ5clI4VndxWkN2TlRuV0JFRHB6?=
 =?utf-8?B?V0g5ZUhCblJZaUh5dU1CeUxSVzdpd0d0Q1VCVFR3dVlFMllmajZHQWgwRHdV?=
 =?utf-8?B?SU0zV21NVjBjUnFFblp0eTEyYk03NXpDQ0FDd0pCcUlvMnNNekxPWmZ2TUd3?=
 =?utf-8?B?RkNBamFBTXJSMkNURDhzMFdmSVgvSGRSdzVYdmsyN2F3ZU5oMTVvWWV1Zy9p?=
 =?utf-8?B?RkhUallJS0JvQjRoY29WaWVXRVRUdWlINkk4OWFxR2Z0Q3dRVFRRMTlhRVVm?=
 =?utf-8?B?UzdibGFHenYvcDY5c1pVL1RUYUFuZ3NqelpkemF2ZWFvcHNYclB5d3NSODA1?=
 =?utf-8?B?OHVLZVhac0dnRVVDRHU0aDRqMk1YeWlWQ1E3R0pVMTVDMURkZW1oTUxLY0RX?=
 =?utf-8?B?WWFoUGJuZTE0aTk3MGNUMVdtR3lGaTZuMktlK2M5QUxXOS85UXdvVGhXV2pT?=
 =?utf-8?B?cDRDR2o3VjdyYWVQY3pjb1EwZjRrenlKdXNuVXF2RnpKd281SEtWbzVJY3R4?=
 =?utf-8?B?TTdzVFNFQ2FMVlMzVHpMQ2RjeFplSzZ2cWVFWUhTSHpQdmk3OFdlQ2tnbUps?=
 =?utf-8?B?Y2YyQ3ZZL1hFQjBNdGxjRDFWZ2Z2Um9QVEZBUkViT0JHUkNhQ3FUeVQ5eDFI?=
 =?utf-8?B?TWhOazBvV1N2dzhQampBL1BoVjN5NFozODJMZmg4anBBN2Q2Qi82a0JTWU50?=
 =?utf-8?B?WVlKUXY1c2xhcXVmMHRrbWl0YjdSbmZZVXV4dXhjSEw4THlEaDZhK2pwaTY2?=
 =?utf-8?B?L0tsb1NCZXZQRERHakx4Nm5RcmxndTViRTMzM0l6eG1ONGpqTnY1Ty9SWkND?=
 =?utf-8?B?NGd6ZWpDY2hac3JyN0dzMGR5Y2owb242NS9rNExxYnBON05iakxjM2ZCNTZl?=
 =?utf-8?B?YzRkODJrTHhlalVid3Fvc0hiVFlTY05GYjBnSHpxZUVHcmkxYVMxZTNudjdG?=
 =?utf-8?B?U2FEZU9jUW1xMDA0RzJuMjVsbGgyczI1TWNSZkJscWxtVks3T3p6RHArdTV1?=
 =?utf-8?B?ckcvOUlobHRQOWVQeWFRcTB3Tk1qejNBTXJoSDM1akoyWHBUR2dtTkVYS3Zq?=
 =?utf-8?B?ZUtNMld4UUwxYklDcGs5Y2tvdnZRMXNUZ0dsUzJLTjhOL2ZDRytaeUxPcEpi?=
 =?utf-8?B?S2REOXVFeGhFSG40TkU3bDdNV3YyUWk4VE9KaXdYRVhCdjhTZmFFeEIwcHZC?=
 =?utf-8?Q?d60fUHfOlZuJXtZgWgzQ1WH3N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9d66a-71ad-4ffd-9503-08dcf991f25d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:54:01.4347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxU4xhSUm7E+PiinIOruzziHrPmKkAKaMiu2xbwGLlKyCClYMFmzr00meRu+rat4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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

Am 29.10.24 um 14:50 schrieb Sunil Khatri:
> ip_dump pointer for the vcn has now moved to the
> per instance ip_block hence clean the old pointer
> from the vcn device.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

And Alex is right we should really look into moving the harvest config 
into the IP block state as well.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 6cd094ee8218..7aa52a04b488 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -332,9 +332,6 @@ struct amdgpu_vcn {
>   	uint16_t inst_mask;
>   	uint8_t	num_inst_per_aid;
>   	bool using_unified_queue;
> -
> -	/* IP reg dump */
> -	uint32_t		*ip_dump;
>   };
>   
>   struct amdgpu_fw_shared_rb_ptrs_struct {

