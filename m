Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A53CC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 01:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD95110FD45;
	Thu, 18 Apr 2024 01:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aicUEXsW";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2BE10FD45
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 01:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU8kZiQfpBRbMFgMnBOjaUnTsEL+bXylyu/GnmDvi6ZmkGunHBvJZdKfaGB1iTNrIYRMDKxcL83B9Tjg1g754f41+2YwhFQ2i7MrTjolL+pP8k1AzwJPvsy9imCFPLGpX5uC+PLbIMnmrKWFby7Ia8OrNPfrSm7W154z63KPjGZ9dwi5n8G5XRXTzwoT62sZ/8xXSPIoixjtJuDQwfvqeASenIXt/SX5W7BtvgdQ1v9wVuOESIfpgi/kzmsGe8UEMipiU4J7g0akwT6ZUYt5H3N0LYgoU1UQREYU1mgjFQchPJP3p4dF9TIUbxXwlGuPtqVRynPiA1YIhpIs43NSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsEAT7WkQrr0pkfIsqjoPLmp8IdYi/eHqonGjyNGs1U=;
 b=er/YOs527NYBZL7/67WbSPZzmELNaeKUaE1WBwaffs3A7T69heU647y38BAGmfIshr2/dpO7j4aTkjr3v0wDme/vrYQyS8M1kIRCCUWltlMLisYjDOwpQ7vn5BaywOmgbhW/btFbNZXNpKGEVqWxsZeTN5gIhFF5+gdMSI2KOO684kvtj5QiDCzT61uwg0TNM5TdvxnGmWR6A2NJ7CkwBi2tBnjELdEEG94nMHefnzXrLvHjAd8nEG+TkGmHH4PR0oCVHETejm0nn2scWwVyHVlBV/2y493nPno/pt60nxqZzNyPyVCogqQeGoQ+94woXu1tMIfZGwBgAxXZcJ+3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsEAT7WkQrr0pkfIsqjoPLmp8IdYi/eHqonGjyNGs1U=;
 b=aicUEXsWG6M3lIUvH6blFarcpSD9BuigXc6m+qyeGRfz1e0oTRX1uFbpmNuxdLCCqD/Ddxzs/T6dckPCfFeCa+gAszUvhSQYVGM0CEYD3s7Mhe0MrTKpaJOtjRYQToCUOX+DxxrQ877xD51i5tMwo272rBNCk4vB7oeWnxVdVW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 01:21:17 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 01:21:17 +0000
Message-ID: <94e7176c-4a3a-4a09-b49c-65d45005a9bd@amd.com>
Date: Thu, 18 Apr 2024 09:21:08 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com
Subject: Re: [PATCH] drm/amdgpu/pm: Remove gpu_od if it's an empty directory
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240417055335.118441-1-Jun.Ma2@amd.com>
 <add8419f-a691-4b4f-af93-4d6b47ffc375@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <add8419f-a691-4b4f-af93-4d6b47ffc375@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0119d8-a1a5-440d-ffe1-08dc5f45d895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YZaTrTfgA7S+Ov24KK3et5RKVS4w/nTrnFD/Boowg5p7mDQbWHdqXFyfJW+S1tLZEGsYj2v0Lbo7EhogVDiTFcJPEcEoPpgyytST+aYI78HSIeopPEAoenOB3rnI59JDP5LqF+S+xLuIeHG6Mq1uV2WzDIcaXC6ETdrLnK4MHWAMeFxFnmomZXv6HYAZr5bD3l6MV17cDHM2CpgpQTr83Y/kIDiiTd1VMHqFL1C01pKKYWvvAnLWoZauSivLiZxe0LSVemymyn/d/Yv1QD/5lmuM7SXcfjLzI6vAeFqdR2Y7Y3InDgIIP/s+TppV92HAfYXLXxjXPwg0oudgzyeSGepLrk39hYLVKWYnbvmFNjw9fD19MENaThkYPP1IXIcuSaYMxEujQ9zeGHCXwmip457jwZ3Po0/dXwmGdTj/JOMUy1dFVwkbx58nLpuORkeX4udbRePJ4wOkUDdZ38+NiRNYIfXs8/LcwtIsSqxh5+9G7ALC1XGCygsTdgB1q+T8+wwQHFMfwB/jvlzsHSXiSMD6X+6hLnREPtofy8Da5hLw4jjowauAtXipbM6ZBKnfnT8uN/rbTd3zbzF99Z7Zh6GwXYV1xa3OrMEuxY9H6NaNV7Y/GhkcS8cR8TCel2JlNJBXEnHGItQ1LQ6iGfXOG2vCA+ZnbJsEexVOn9Hs08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXdTKy9UK3lLU1B3S3RiNXMyWk9DSmZNdEsxM00vUVM4T0FuZkVWckhUWFhP?=
 =?utf-8?B?OW1Sa0c4OXRiNVU4VVIwMGMva0xxN1N3RHF4aFV0YmlSRXRIZ2NWWitVWXEr?=
 =?utf-8?B?QzJUa0VPM3VXeU05WHpEWmxIRmpzbWZLdFlQY3A1RU1UR2k4d3JwVnhwWkN2?=
 =?utf-8?B?SlFUdFY4T2RIT1JXdy9IYXNNYTdRbXlMTDJjSTYxcFUvU2pqUzBpRytpdVJU?=
 =?utf-8?B?NVRjQzVJa1Q3SWF0T1NhdHhKcHZWMXp4Nm1FTURxdjdYWjZNWk5IQ2JlblR3?=
 =?utf-8?B?VnVhR3MvZ25pVE9uUEhxRkpMTWhyNzlzaTNlK0J2WXczUmNRRnd3L0VzT1hQ?=
 =?utf-8?B?UjNyMDl2SFJHNkxYdm9pL3VBWmRSM0prM2lpZHprSVVFdG1oVGVaSDJMN3g4?=
 =?utf-8?B?NlJKQy9BMUliMXpCWW5Uc0tCZDc5V2x5Wm9MOWxlWjM2NXB5alFtc1FVeHRr?=
 =?utf-8?B?Zi9aZ3pabkFmMFlhZkdRR3dteDJnOWlMUFVIeElDTmhOckVmTnNvZDI0R3Vj?=
 =?utf-8?B?ZVU3emtGQzA3UXdtRFRZT1k4VTNSakMyTERwalhsTkNiYm1HTGN2Z0E2VTBq?=
 =?utf-8?B?U0F2U1hiQnZ0Q1F6WGVycXZ3NXRGWEF6M3dLR2lSMXRjSmYvOExTSTBTbjRR?=
 =?utf-8?B?UHZVajZvMVNMbk1MdE81clZxdk0rWjIrSUZSeHFQaDlSaWlPZ0ZZZEd3Q1g4?=
 =?utf-8?B?WEJwYVlSN0FVU0dtTlZqZEIvMTd1NXBtSXFKRzExb0RGZmlQcDBMNUo0V2NM?=
 =?utf-8?B?OWJTRnducUFpcTJvN0hqekxkMWg0eXdYZ1cyOXVvOXZ6bTAwdTNJMmRXaXBq?=
 =?utf-8?B?eFcrdTROYzJuSXRMb2QyQmRISTI5VmFkTlBCWFR3b252ditQOWoyWjZSSGVF?=
 =?utf-8?B?c3RIVU5UY0dPb3dpUEY3dFk3Qzg2WExTUWVaTXdZdS93RzQ0d1oybXBDdHBB?=
 =?utf-8?B?eG11YVpYWlFiNTJ5MXJ6UWUzNUtONmJJQ0NFQVYyVUdqYjN3WWRDK0lKZS9P?=
 =?utf-8?B?VmpTOTBHS3d5QVBRWnVUOElmR2Znck9ERXlLbkprOWFlUTJGYkhlTGdTTUV1?=
 =?utf-8?B?U0pwcWs1OHJKVEpxTzRhYVBCeXZzck5kVHpTRkRSeGZlVzJYQnpabUtpV0lR?=
 =?utf-8?B?N0htYVdDelZOVTdOemhoYTI4YmxqbnlBUW94TTllWGRnellOb2pzbFM5RGMy?=
 =?utf-8?B?Qkc2SDBWRmMwRzF6RFJCK1RQa2pzNVpqWUVKRjBNaXdQOVdGcDlmdzVtR3Js?=
 =?utf-8?B?OTJyZ0h2N0VIS0dsa1Y5Zk9xczBES0pMaTM1WUFzcXZUQmh4TSt4YUtsVzgz?=
 =?utf-8?B?K29VRGcxUmw0d21XckMvaEFDZHBTT3gxVk8rN1o1M2FBVSszTEljQllhd2k1?=
 =?utf-8?B?MStqYXI2WEZpaHp1K1IxTVZUMzJyc3psZFlIbUpmaVNSYUNCc0JKek5vc0hi?=
 =?utf-8?B?dDZSczFReFI5NStYNW1nWXREeGlTc1E0THhha3NBYTg1ejVDVjRUTks3U0Vw?=
 =?utf-8?B?bHBSWUhRMGZ2M216ditvbmtub3RMbGYxN25CalJ2Zmc2UGpMMnErS3IvNm1B?=
 =?utf-8?B?MEFNQUY2eEFFVVFsWE5zQ05keE4vNis4aERBRXBKY3A0MHNwV2x1cjVxQ1o4?=
 =?utf-8?B?cDh4aGJFQ0JFbDZrY0IvenJvWFNkdndsUnBZZTBHODZ3ZFVRVG5OSWU5TFo3?=
 =?utf-8?B?Z2hTY3h5cklUTzFWWUowek9PYzJWMitFQTFUQnFqbG5aeUp2bjgvRzcycys0?=
 =?utf-8?B?QTV2bmhWMkZ6QlhEbGVXUERYbGtEUzNMVVZnV0RUK3NCVUh0dndoazZLZVZO?=
 =?utf-8?B?TzdwWDVvRzZQcWdneEEwZDE5cGJHbVBLRzFWNUJrcTBvcmtuTGgxN3hPcEtL?=
 =?utf-8?B?Y3pHdUNPTTREb3J1VGp3YmJBRFZFM25QbENqRHZ1OC9kVk5kQ01Id3J0Tjdl?=
 =?utf-8?B?bGFDK3ovRWNNMzRYOTJaR3hxandoS1dmWFZmb3ZCRXF1bEtBVWhRODJ2NnNs?=
 =?utf-8?B?UWkzVm1NTHVHNENDQ3FiYzkwV2tFL2JHOVEvNk9ZOGVqNkhGc0NDOHhKK082?=
 =?utf-8?B?UkdKTDVaRlJqR3VaSy82dTA1TVh4WUFPOHhxTHRwQTltVkJoeURIdzFPQjY2?=
 =?utf-8?Q?jJcQZywfqpvvmyO8vo8Mk9O83?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0119d8-a1a5-440d-ffe1-08dc5f45d895
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 01:21:17.4076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GJGNNMPPXOBntr/7Yq9pfgPCJEaCyngUbOAtmQ/GrCxcen+onjPOQHticuGADvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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



On 4/17/2024 7:52 PM, Lazar, Lijo wrote:
> 
> 
> On 4/17/2024 11:23 AM, Ma Jun wrote:
>> gpu_od should be removed if it's an empty directory
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> Reported-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index a20e03e69d38..0c13e5520e77 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -4338,6 +4338,13 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * If gpu_od is the first member in the list, that means gpu_od is an
>> +	 * empty directory, so remove it.
>> +	 */
>> +	if (list_is_first(&top_set->entry, &adev->pm.od_kobj_list))
> 
> Instead of assuming any order, what about using "list_is_singular" - if
> this is the only entry in the list?
> 
Thanks, will update it when push.

Regards,
Ma Jun
> Thanks,
> Lijo
>> +		goto err_out;
>> +
>>  	return 0;
>>  
>>  err_out:
