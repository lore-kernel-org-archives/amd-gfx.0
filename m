Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8864FC5475B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 01:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB20F10F917;
	Mon,  4 Mar 2024 01:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zd7/StjF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6335E10F917
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 01:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5NjOHjRTEvyvHRGSGKzHJOs7bXmJ3dIuMCDFMK34Tfz0NRzsFJ2EDafUsA4plIoIJxc+UR2YC3qq3NoH69/HFSvfN0+9KGQOiEOdB9XymyMpwaTj55tQ9/FMffEgZx8T30Crp3b8c7lc9x76aNDfG5MyZ9PWpnD76scfQZBeYilH1TqXCjsqhg1P0d68KD0IKW/TpIHtIVsyu/ujYtNycZdAlW+GYiVov+g5/MlnqbjtPRrONIMbFr4Y4gDfq2PpkZSi4Ybc1gKjQIoPqwBIqdflwT4jTS4C8dD4xzeyncXlunsmaOKTzbtky/80P5jE3nbxKeMDFHd+IKbjJlThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjHEETVtttIN4y5Sxdxy0p7h933YRk6bpY4nrqR3WtM=;
 b=bcVr2E5VrIkVvUA7+tgGmoEFAXEuswiaFEw4h2+NZ0JzvYFz/65X3Cl18i2Cb1xKu0BGprMVs+Oebnhnragiu/4CAd0WZqDTMCNE2t1qZDdbMJZfGt9iqI9wTITcpoLoampvPG/so1nIIR9mn4UgV02WF+9ch476RIw+vWStt5Kt9rquSEHCyURoanEUOXflS9uiq75WKIj+C15BfdTjxAqQFvzSkv7LuvPhP5BE5kWNF4wDlGUX1aT1XyixQ++E0F9MKpxNJkqaqVkS59QufdGhE7Co4uO+g+2wthgUPmVF5Z+J1MFXUhnUdDQnAYyZoIBuETOlwG+i1B5dzm7fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjHEETVtttIN4y5Sxdxy0p7h933YRk6bpY4nrqR3WtM=;
 b=zd7/StjF+LVXZEjxk3d9mP17nOgcraiIBCnutSeUmkYynrSg6PnhfGT7C3cSUPRLgtTNeOnFvZAa2JGAcIPrj74O8YxlomcFgjr+9biqgSRV86JbznMGYHp0VXdyvx7qirMgtTMtDcp9FY9dBSoMt19cOUlSNDIUROESbxVDIz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 01:13:11 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7339.031; Mon, 4 Mar 2024
 01:13:11 +0000
Message-ID: <1a020b2b-eaf2-4b37-95e9-4a5ee27c8dae@amd.com>
Date: Mon, 4 Mar 2024 09:13:02 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the error of pwm1_enable setting
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240301074506.2018577-1-Jun.Ma2@amd.com>
 <022e14b2-6937-4329-9bf5-7a3cfe8ffd42@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <022e14b2-6937-4329-9bf5-7a3cfe8ffd42@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ab6895-ee6c-4aa4-e5e8-08dc3be8425a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kS4DIddz2rbp5PEGNwdPvzn5vGkhQXZ0tIMeSQBmY8uIuXvcp0T06oB0PO643r2Ov/QiyPpom+MwYnC6Poag4OtJYWWLTKJldU866s4UDARcmO/6k+2zDbYz9uJzdRWsCLL/bM/dLPReZK0PeQQcp60rAJvls8Hl9UVd7bU7rXp5Nchy0n4HsjlGHqpnagFkeWd9DyMLoVafhosW0dAjI2ceOrH38V5DuP28P4U9pAHNSWEDL+jqAJtbpCQDQuf9s1EAaLVKppI4IT4BeKxqGD3sMA8bovmOyaASQZ44kmstl77/vlv7xtoGPptigtK3a8p55o3qZcZUm4sIqSOSA+6ob3XEG7Rgn6nk9tX+Odc6yzeNTEjvn6tHjoPBOr3y3jM6PvPHbaNKETCFlWLVkm3lyuNxQaKvNzQji0UE+5NwhlQuKEmHBMKeBgOoUJ4rmK4FLvLBQaJ6kQqXfEf6ed2hs7eVXk7ak1wH1FWcGmbrJBvkJKyRY/I+aPkA8Fwhn9TvImbJsqDsOmjcKANOpxvFe95PMP1E1/3qWRl7EHOoutGap2Dm9ugbGQknr7bqgWwLcOc5MGoYEZ4O3g43YjkLHOM3Qb2fvPPVpgosIKzoafNaWpGn5LPB6PtmTrYGjkzlmBVCrfu7JVfL9gljyGemtlP4eNlgWENbV2/xj2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxxSmlkR0Y4R3BDd1RjSzRjWlpweDNlMCtIYUFvM3V5bkpsNFpmZXJEUG5w?=
 =?utf-8?B?cFZRT2llNWRRdEZudmU5dENQT3VqSHZNVDNNbUZJa1RSSklMZit6Z3ZURVlo?=
 =?utf-8?B?dWRHSFVNeFZLMkw5c05oT1ZLVGU2M1hlNkZ2YkxvWWFhMjhqa3ZsS2xmRnRs?=
 =?utf-8?B?TmdRc3JvcS93SDRYUWJQOWR1TFRSTmlJemVSLzlSZjBCUGkybFNEWm9zSzR3?=
 =?utf-8?B?ZmJ3VXlKL25qUHZ1N0svWEJPdU9rYkV4ckNOMk1DN3U1UzBtMHZ0S1RodW8y?=
 =?utf-8?B?anhYNmlWMXk5ZDBIRytlR1J4L0w2b2kyKzdKcmxCTk1lS25FNU9TTEFhTFNy?=
 =?utf-8?B?b0paelVnbll1WTNERHZSVlhIRS93TEw4bHhTaVIwMkd0Nk5FSitxYzFWZDRE?=
 =?utf-8?B?OVRMd01kTkRnNkNvaUpkWTFUWXhKSEFXNkVXRUw2MWg5K1dYeTAxUkVzZm9p?=
 =?utf-8?B?ZVFIemNjS3dxSFFqK3BxdkxtbFkvcmdkRDFUUElQeTNHSGQ0SzlBTXFyZXp6?=
 =?utf-8?B?S3ZNZXpNa2lXZXl1SjRlTEowUlFnYTg3MEcvRVQ4Z2xubGVsOHdnbUdiMVVJ?=
 =?utf-8?B?c0NJcFBsMktVQjZVYWlaK2dEZnV4UGlzN2dRdmIyWGQ0dmhMM3JkR3VEa0sr?=
 =?utf-8?B?ZGZVNzh4SlJCeXZHRDRGM1Rnci9wYWhnSFpqMmZjQ0pySUFlcGJXRzAyeG5r?=
 =?utf-8?B?Ry9Hc2I5b1ZQY3lJZDdvLzFVUStkdVA0WW5DWFFlTFZTZnphOTBaMlFDK1BL?=
 =?utf-8?B?OFkweFZqOXI4c3VCY3ExSVRjUzdhbURhS0ZPeWFvRStNS1l3a0FRcC95aTV6?=
 =?utf-8?B?ZWNSUUFRMk1UNW8yZitXZjVzdEFUOHRnSnBHWlRlR2NQZXVGbkdwRlpMQ3Rn?=
 =?utf-8?B?QkJ0MFQ1eEVRQ0Yvb1pGTFFwODhtU0ZRZi8vcVpHRThrYmUxRDNWVWxPdmgw?=
 =?utf-8?B?YllocVhVRzI5ZXFhZ2QwbmkrOFpZZHptNkxBcldBdWRMTHE2RzFTeko2QzdQ?=
 =?utf-8?B?V2FRRXd6UXhPVTJ1UDZ5ZU5KYnVrQUhwOC9wSEtKbVl1b1ZFZXFXbXpzQnZp?=
 =?utf-8?B?TitYd0VUMGNjaEUwOEhRcWRQUW9lemZ0bE4wVm94eUxnSngrcmJabm5idVdK?=
 =?utf-8?B?Tzc2VjUwdXo5Ni9OS2dJMXU2eGU0MmsreHNQQVdFOE5XWmVvRU1LOVhRVzI0?=
 =?utf-8?B?NkZUS3JrY0JzalpTMEFZQzB0Y3Jhc0lzMmxmVytVRmYvd0I5d3U5T0Yva01t?=
 =?utf-8?B?V0RuSFI0em9GbS81RTZnTEcrR2tNNkphK3l5bGNoQno0c09Oc0YvRHhtU1o5?=
 =?utf-8?B?OTVjOWV6cGMyQ1QrbGY4OHU0eS81Ti9iTVlaOHk1dS9uNmJmQXRWbFoyQ0ZG?=
 =?utf-8?B?dERDRk5iRmNWQkFRYys0WlJPSnZ1NTZrRDdTdlNGTDRQRGg4VksrQ3FmRTdu?=
 =?utf-8?B?OEtkZDNkdi9PNWg2UEZvOE5YTjhUUXJQTWpsdjFzNmRGZGZXQXFKWW5YS3hv?=
 =?utf-8?B?a1oyeC9lSGdkZFhqZ0RRQk1jTHFRcVc3U0ZWK0RReDhtRWNwSE1reHNFNkl4?=
 =?utf-8?B?UkNqYTZTaU43OTdiU1ZubE5zcHV5OXJ1TUZibWFTYkpHR1hsMnhITjRNSk1a?=
 =?utf-8?B?b0k4Z0hFWXBoblFuRitTOCtRcVNkb2Q2c240VlNYTU1vUmFTK0ZEZzRHTTNv?=
 =?utf-8?B?T1JZUlJrcEZya1dlZ0NvYldFcDBKZ05WbVdNY1ZQOFBmTzNJeWNlZjBJOVRJ?=
 =?utf-8?B?MjRHS0drNHRrUE9qbmZRN0xIbko5b3JTRVdjU0FTalJ6WkM2Zk5Pc0E2S25Y?=
 =?utf-8?B?dFFnWXpEa01oSlFKS0xRMmZ3bDZTWXg2SWVnWlEvVVdEcU00MnJqNk5vSjcr?=
 =?utf-8?B?SjIyMnY4Q2RPRDVYTS9ObkQzMzNGTUsyWG1iNmV3WFFiTVJKZW9SMEZlUDhB?=
 =?utf-8?B?Tm1BeGJwMno5RlI1QmhzL1VLQWZ5Mi9rYUJyTWgvazN5b3lvNEY5MnRrQzJw?=
 =?utf-8?B?czROa21YYU5iWU5qbytWUGNwQms5dVBBUWtqY2Q0ZUp0NWVMNGFqc2xkU2Zv?=
 =?utf-8?B?UFRmaHB0OERFdU1ORjU5Qjh1SCs5S3FGTEtkNG40Qmd0a2hHeElqejNReGtH?=
 =?utf-8?Q?jLeMHBAZctrQw88c6xRPzvAwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ab6895-ee6c-4aa4-e5e8-08dc3be8425a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 01:13:11.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2Yjw25U9HQQs6VtWGDfNnBpNmA+N9GNkVMMFFLf9lGYsjEz0oo2JIjIjESnleZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882
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



On 3/1/2024 5:41 PM, Lazar, Lijo wrote:
> 
> 
> On 3/1/2024 1:15 PM, Ma Jun wrote:
>> Fix the pwm_mode value error which used for
>> pwm1_enable setting
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 9e70c41ad98f..7cc5cd7616b1 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2582,6 +2582,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>  	struct amdgpu_device *adev = dev_get_drvdata(dev);
>>  	int err, ret;
>>  	int value;
>> +	u32 pwm_mode;
>>  
> 
> You may move this declaration up to follow reverse Christmas tree order.

Thanks, will fix it when submit.

Regards,
Ma Jun
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Thanks,
> Lijo
>>  	if (amdgpu_in_reset(adev))
>>  		return -EPERM;
>> @@ -2592,13 +2593,22 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>>  	if (err)
>>  		return err;
>>  
>> +	if (value == 0)
>> +		pwm_mode = AMD_FAN_CTRL_NONE;
>> +	else if (value == 1)
>> +		pwm_mode = AMD_FAN_CTRL_MANUAL;
>> +	else if (value == 2)
>> +		pwm_mode = AMD_FAN_CTRL_AUTO;
>> +	else
>> +		return -EINVAL;
>> +
>>  	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>  	if (ret < 0) {
>>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>  		return ret;
>>  	}
>>  
>> -	ret = amdgpu_dpm_set_fan_control_mode(adev, value);
>> +	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>>  
>>  	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
