Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2790C5475B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 02:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7DD1136AF;
	Thu,  7 Mar 2024 02:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2o0QJVCy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9CF1136B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 02:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS7AWb6/1sFd3Z1Qf8ctcTth6/bdqZdvLZNKbSfUq7ToIQqO/W5dUMviISGLKgoyRT6a79z2noPycOsdT2J5eKRfMASNuWrQ4Gzu3rgOsoKox8HZMHHQnN1dOec5CImIUIWjUDrlVih9sHf9RAkL3DFcWr4XdLHW8Ue4yMmHXaYqNQ7TVoLPp5X8qiYfQ+6yYUDOklrBXVMgbPtfbkc9AXoJj09bZAnvypHApJ3OWnJs06YVsAJXgzzppaygdlhj8sGddbYn5NWM1CHWKp8b6Ug6gu2A+pkBKMCX6wepLlxOkjVo0QGpwsPoLUb82NRBkxgEiDrth+iWe9OemESJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0iXSj2YIojTdlfjjCCpAaOPmngma7leOdOFw2BinoU=;
 b=hSatFCRmHiHJ6+wGhib3JazFy0+5unSYnObCTIR2aHA5MQmzjKMVld2F2XblXeoCTszpH3LKhd1HrYJVY4gr+p28MTPyxHpuD+CvfKOS9YErSO1DzLYIk0DD4KsHGQZ//pY+uVTJ4QkchdDTa8vXlG1us3dQ4XTbXssE9iLGRvFr2LH4zBwtsjlM9Y+T/yibz3k5bbXRrRJAkp5FtMiYjxBS721nJY/jP0yoMTi4ti6jG715h1AdeJKgz2Lcw4iA9N9VVcnZLfQvt18M0jxJ6Cg8JcxvpWa28VnGWgUKCwh5xDiydV6yuScg/gqbAcdvSoo65AzjMOgK+ILg01m0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0iXSj2YIojTdlfjjCCpAaOPmngma7leOdOFw2BinoU=;
 b=2o0QJVCyt3rEZmjjtHM/J2j0LAlpxxB24mCjVzXmkAaoLb6LWdgwOOX5RjYGyogph5VfL7WO+CJ15bln/Cg8AHtEG69QUEFn6pLfLRJgEUMP8X+f+ro6cE66Hm1U+YE8j6MLTcHKb3AnpYzAeOE+vUqEIBXXEHf/qXDSD6iUHzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:12:39 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7339.040; Thu, 7 Mar 2024
 02:12:39 +0000
Message-ID: <097c4133-47d0-40c9-b441-cdd38b746c77@amd.com>
Date: Thu, 7 Mar 2024 10:12:29 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com, Yin Zhenguo <zhenguo.yin@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix NULL pointer dereference when set/get
 power limit
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240306102615.2117462-1-Jun.Ma2@amd.com>
 <c4362e69-e540-4cd8-b680-539dba82f806@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <c4362e69-e540-4cd8-b680-539dba82f806@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9192c413-0802-4828-f767-08dc3e4c1057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWiND69vDD+pMFzBzzPaMyPbpNGWYc/d4YXDgZxYe+GUC9mQpj+sNi8gcDjEcRDcDqGMeve9GRc6MWHu/P3E52ZOv3D0JSD4A31mPw9Io9lMjbRBXoLe45TzVStR6ELnm8ztTvNlMxmJoxQOS16MHKv2rNTqF/P2CTWoTC098Pcj/4a9u6D2dybbj4AhNEdkUoF53DiRvuc3Wd/irqxR6f5Ha9YN5fkrWmkjOY3f4Q50H2kqYZcTjKyphyGQHwhM5k9NaVOyISq2QpPuV5Ad6adCAtFTDppnmreQH/yvmk1ERz7QigkqdNawhYPS4abcaUZOVNKchk8vsG7ggNVYbdYh/otDJE+HhoOdCU3GJVNIDErOGOuwSzf7/FOeFFGCzdYgsGhVCNZ7iSOZai0oUiTNxHx/UdwYd7xqulI8Z4hgbFBnFLX6DumDhupLpUGmhzrqvJUQIBVueShJC8AGZGDyuTpxwKen0mUOIH4JenM2JmouvCEpK8QhDdQyPTG+GI8MWUlu4DD25RdDRoG+BfxZL103MzLqHtv1Vi82qOWHZ3xXFYi5c3c0dMjy0PtrNewi1hV6ScZuVClkqAz/EViSF3cJQ0kPJqS79PDY6ZrKHxQmkOxxwIJnmVbMti4QUEyYhudKX/swxCGxHFxOZgw/XcafN2dQ7i1whpCcbsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0l2cWs5aFRTaUYrM0NwYWJxQ242ODNVQ2RKSEFRMWhSM2Q5cWRMbHM2YXJa?=
 =?utf-8?B?QTYzQlFXWnZ3VnFXbjEzSUJNQnpNZ2c4dHY3aXRpRFZXdnQrNDhxbmJtcHhW?=
 =?utf-8?B?WFBKK29TU0orNjRmTW1VeTNPMk43UnR5dnR4Uy85LzhoUmhBRWpvckdlS2Vx?=
 =?utf-8?B?OEEzdGVpMmdadHVydVdRQS9XT2hkRmhqU0h3SUVKZWhRTHRCcC9KdmgxV3M3?=
 =?utf-8?B?bElFUU1jWnpyMXc4RUVhYmR3RHMwYmJIdkJNeS9vQVg5RmRBYXhBWTJPTEl5?=
 =?utf-8?B?V0RSRGo5bkdrWlFMaGNveGRYb2FTRGNiaGNIOTd6OFYwL2lLc2t6cFVOL1Np?=
 =?utf-8?B?d21KMDdMam1RbjZXaGltTmhiTUdMVE1PM3FqbEFqUnhCLzdVZTN6SENKQnFM?=
 =?utf-8?B?TC9CaFNrL1lnTXI2aExiOHNnQVdjQ2ZBVHpuNHh0ZFZveEZtWWtPTlljUlVW?=
 =?utf-8?B?SVRlazgvbEFGZnd3Y21CcERWZWdyV0RTdFlISWF5Y0traW1hdndacVQ1eHhl?=
 =?utf-8?B?Ukx2MXJ5SkVoN3dZdzlGVk90TTlsU2xYa3pqMTdiUW12NXBEZnNydEprbkEr?=
 =?utf-8?B?YVhrQ1Zqenk0OTlBRDE5VE15TkZGUnFIQUptWUpKY2NtSzBsYlpmOEpDbDZn?=
 =?utf-8?B?WEFtOVl5YnM1aGRUZjZFK21TbGNkVVcwa2E2ZzlHT1J3TGgxQ29xNTBwZm50?=
 =?utf-8?B?REN0WDJTMmxJbmFVUDdlNGlYTmRyVjk3Z0hZWW01SE5SYjBMNnYwOWRCWDFF?=
 =?utf-8?B?MWxac294dzJLVFFtbFNSSVgwZng0SG9VOGNSMUhBUjlVL3B3akh1bUN1UFVH?=
 =?utf-8?B?VlhGQ0o4eXNzbUlKbXpLSFZFWmFra0ZGNG5hZWFJYXJaVmNqRUVVQVoxSFly?=
 =?utf-8?B?czVyTk5wMGZyVmFrMGFPWlFMTC9sc0MreTRUdUZRUXFiNTRWNTlPRGlxY2FX?=
 =?utf-8?B?eW0xTmZHeGM3K2N5ampLWXJGaWhNeFN0Ui9BaEFYKzRibTdVQmwzdzBvQWV4?=
 =?utf-8?B?MU5HdWlLRmY1OUlmY0lEV2xkZXF0YUNJZDRRbWlRQlRMZTA5QkFsOG0rZzkv?=
 =?utf-8?B?d0Y1V3hMRDI0VlN0WXVjMWE3ZlM1ZSt1MVVxQXVFYVV5QUVqbUNEZlBqTmlX?=
 =?utf-8?B?MUJmcmZhVGNNd3pPL0taZVhPMHRyUmloWmJpUFhsbC9ZbWJpTFdZWDdjZ3BJ?=
 =?utf-8?B?NEdob0hhSEgwZzJ0WStNT2M3N09MMnRhY0JwSkUyaGluSmZiODJpcDNxWCt6?=
 =?utf-8?B?TW4wUk1jQzRKbzZNQy9KOUY4bnhyWVVJdVdqazFqMkhacjF1WDkyZUdvWGR1?=
 =?utf-8?B?Um9mSVpYQ09XL28wZmhmKzBFdDd0WWVadlFTZE9GNDdnVWdMeEM2ZFB2SWVK?=
 =?utf-8?B?OFR1cEdXT2NTbmpubmlCMTNrRzRUb1ZYYThkZUphUE1DTVQxR2E4YVZuRkZH?=
 =?utf-8?B?Y0pnSXRNbHZZb3hwYmJlb2hMV3ozdDd0Tm14SmlJaENPQ1JZVTJCNUNhOUZa?=
 =?utf-8?B?NnZsN1BaZERpRVZEVW82WWNmTjVPTzFVeEllK1JpS1ZLY1FBMTRFTmVVUElV?=
 =?utf-8?B?Wlo5Ync2SnYwclNFcFk2aEh1OEZpQ3pKTktmUnFvQmE4MVBuUmpPNjhMR01x?=
 =?utf-8?B?aG5OcC9XazBmT1FiMFBzRE12bUNkSjA2Ry96eDJSaWMyWmcwNm11WG5iWDIx?=
 =?utf-8?B?cFowVFlKS1ZZeE1uMlFrZCtEeUZyU2FuUnlta3RYWDh4K1lkTGxQNlU3UWk3?=
 =?utf-8?B?MTd2M1hCUThNVW83eStGeVVLRkRUTVk0Ui9DMTdTRFBtbG9EdzI3eEhyZEtR?=
 =?utf-8?B?ZTZxY2ZSTk5ESmc4bmw3OWdEbUl3YnV1TTJwaWxEb0cveW1RNHRuanhVN3Ir?=
 =?utf-8?B?emdFR2FZYmdBR1cvc3VxUUlDRk1JdUwxRTJwa1lTeFB0OGdmbm9XU09mRlRk?=
 =?utf-8?B?a3FaVjBkd01RMG1wVERuR0dxWlpGVGNrdDlRVGN6K0lyNE0wTkQrR2twTjhT?=
 =?utf-8?B?Rnd4UXl2VTNmVVNOOGpCNXFEdldPV1N1Vm41TTdyazkvY3V4T0pCNnQzZjNH?=
 =?utf-8?B?UVJrNzcvR0ZtR3V0SUpoVXZsV1h2M3NhcVdxMVdzOUVWTEVtb3djbU9nZ2NZ?=
 =?utf-8?Q?7D5L2DOmYFlnkOXTSHcr+c/Vl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9192c413-0802-4828-f767-08dc3e4c1057
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:12:39.5889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu4eSTDq3bYDBi6AeyQmOldufgkJk+DEs2yUxV9+5uGXVgSLRq1RpTmEx9778azB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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

Hi Lijo,

On 3/6/2024 7:16 PM, Lazar, Lijo wrote:
> 
> 
> On 3/6/2024 3:56 PM, Ma Jun wrote:
>> Because powerplay_table initialization is skipped under
>> sriov case, We set default lower and upper OD value to
>> avoid NULL pointer issue.
> 
> pp_od_clk_voltage is not enabled in SRIOV (except for GC 9.4.3 one VF
> mode). Since the interface is not available for SRIOV, a better fix may
> be to set smu->od_enabled itself to false for SRIOV.
> 
This is not about pp_od_clk_voltage and od_enabled. This problem only occurs
when getting power1_cap_* value, because we need to read the od_percent_lower
value from poweplay_table.

Regards,
Ma Jun
> Thanks,
> Lijo
> 
>>
>> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
>> ---
>>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 15 ++++++++++-----
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c  | 16 ++++++++++------
>>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 15 ++++++++++-----
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 15 ++++++++++-----
>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 15 ++++++++++-----
>>  5 files changed, 50 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> index 1d96eb274d72..42c5e6b103e8 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> @@ -1303,12 +1303,17 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled)
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		else
>> +			od_percent_upper = 0;
>>  
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +	} else {
>> +		od_percent_upper = 0;
>> +		od_percent_lower = 10;
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  							od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index ed189a3878eb..6cc2e2d27a0d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2356,13 +2356,17 @@ static int navi10_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled &&
>> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled && navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		else
>> +			od_percent_upper = 0;
>>  
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +	} else {
>> +		od_percent_upper = 0;
>> +		od_percent_lower = 10;
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index e2ad2b972ab0..5daeac2e6239 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -640,12 +640,17 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled)
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		else
>> +			od_percent_upper = 0;
>>  
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +	} else {
>> +		od_percent_upper = 0;
>> +		od_percent_lower = 10;
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index 215f7c91ca73..271151c518e1 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -2369,12 +2369,17 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled)
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +		else
>> +			od_percent_upper = 0;
>>  
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +	} else {
>> +		od_percent_upper = 0;
>> +		od_percent_lower = 10;
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> index 3dc7b60cb075..533a3c1ba41e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> @@ -2333,12 +2333,17 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled)
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		else
>> +			od_percent_upper = 0;
>>  
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +	} else {
>> +		od_percent_upper = 0;
>> +		od_percent_lower = 10;
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
