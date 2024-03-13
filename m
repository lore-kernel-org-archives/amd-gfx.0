Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED0DC54E5D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 02:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3631E10EFB2;
	Wed, 13 Mar 2024 02:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d5X6TNY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776D810EFB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 02:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D959nYJESHg33uCuxVxQcI/WPBFqfgTSpOCZDRkM3wleCRn8TEZmw79YDT5AhGhm0y8Oh7Tbj04rtE2B5NbwQVF7zI7ppfFWd/V+h5cHLIuziBVwF7N/p6sLP0nflVU834lG+sxIswwfzaJY/mB8aqAuQw+/y0TisRW+rcywbTx1RPFQ6CZ2eDInySlbm5O7Q5Lbez7LduR4hxuUJeps0vuqkZFLANg4nd6shiAX6uQgzRLFnMhdBSa1hu0BIecaDnMqk3Jrq0UVzMU8ms3MxM/cXBWVnzER3s0/ri38wJYvJlACrKwFS/pOntqELb4IfRqvZSgDYMugCbkP99PfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMHrdel0KTfEAKxsQxb5fAy1q0GkhvHCr99WL739hRw=;
 b=MQxz4628/JXALgKDNKkPkiRDfg/K0+49xuV1Q5ks9KPA6zAeDls84k97C4QvENkUeKOCXr2lTB9IsMLobboPhmWtbkVqfjarlMKcwGv0zUYQBYBHKWNM2s7lV1LuuBut9tr2PV0Eb0l+TbhrX6wGEf8acK1muvYg866HVluyS9x6kHE75jzs7fBEajy0OgCDJrDJ51PCLtOQsGt/B64f2bDkpeephzIgoAJpawj2apsDxIH391C1hg61Ag/5YhkQcECQIERy2C5T2lwND9QlDcGIOz4RJ/e9oxMFWGUVxQrUtGQdFXhrLbxq9lzu5S9jvWw0MOxXSy2XwgWMjahaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMHrdel0KTfEAKxsQxb5fAy1q0GkhvHCr99WL739hRw=;
 b=5d5X6TNYn5515m+AJA11Sq9nh8t5mSvqUf9PtSMsYJpJgmrhcqQw1oPM/66xkMr60S/yyZ+KoS5zjjRtMA1ggUYEC3zvUuMDc2UI4CVUh2xEsoTrhhhkb/8qp3bDZeqweQAHTKyEVpytdUNuFiHx/fLf8hXdoAacNpgs9zabMSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Wed, 13 Mar
 2024 02:45:19 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7362.031; Wed, 13 Mar 2024
 02:45:19 +0000
Message-ID: <5a0fc9c5-13d3-465b-b0c3-2431f1bd0995@amd.com>
Date: Wed, 13 Mar 2024 10:45:10 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the ppfeature value
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240312105934.2291792-1-Jun.Ma2@amd.com>
 <636b1578-08d7-4a6f-a499-6dec02c58aa5@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <636b1578-08d7-4a6f-a499-6dec02c58aa5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d0edd6-800d-4e2d-9ab6-08dc43079f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iurwxpxNdmVY7b5QS7wRQ53ucLLUyC+PBhRzS8WTa/UBCCNgLpSQvDSvryGEChN1SKeFuhJ+Pd4q+zNS6GngAxpIuMxOuq6fTk2O7HuKotroq74+GxOjYwXYmmaqs2ywyzAUgZk6KNEd+b+DguNa1ObmW29vEzfTy1Yi+PZr0QEGD6s8ZAHftfWU2VnexSL10+4KGIUeb/QSPdkRRyXxohXgrX4jXC+IbeOmNPW/+E1CC7TRM5v4ILxnKb3VXKWMeAqAbRiiL59I2M9AgS2GQJOl2+LAZ44ly+JtDv9O+PE3vfkZpeFI/EiTepwvBnCUnpKM3/zGt7ruO5TvilcYGGqcDrDT/FcEd4LEzUcmya6AlspymJxJ4R5PEe2Qk8ieMutaubMA8bVQEXaAJGwq0qEr/+0CA8MJ/D+UfxEaahP8mr0YetXgwDM6TGSQULA6TvNO07NVnoU+K34+7M0p46+umcHJlW3D8Cr+0CxMHicYJh+0kQSlrK6zKvUJ57/sweF90zLS33F4ybWGExobDAg0ITAsXspanmy/i9m4ZcLnhuVBPfWdi7nwUM24qRNbhnYrrpsWtMsXfhhSfJzwIpSzadO+4eGxUKp4/Ua/qji/nqBPe0mzanMLH4X7/KiZn2/nbOvek4JyO2JLZPI56Rl3qsDZwsspK+uQ61gFmi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0N3YXNHVWV4aXVSY3BJWVZCczJKWmVmcG1IRjdDQS9MeXhKSThQWGRRbnFw?=
 =?utf-8?B?VWJQZWRuZCtSd3gyYlNSZ0NwbTV5MVRZZGFiejJ4Qm9YQUV0aFdSd2JaQ25T?=
 =?utf-8?B?T1cyZHMyYWl0V3FUZWxJUTZRR2tGWGV5Z0EyMGhMNlRPdExCUmlUVmRFM0da?=
 =?utf-8?B?aWNjWk8xdnVUOXUrMUg1T0RoZ2VTR2ROeFpmc0dFN1JoOFFwOHhlRzdGRTdL?=
 =?utf-8?B?dVBtNFNNZEFTLzJ6aEtGVWNNYkx4bWZYaHlHcmlYUFZQUjVzbDFKVlVzNVVz?=
 =?utf-8?B?SGZaa0k1cWYxWVplN0FWaTlUK0tLcXczMHM2aHJnbm5ZbkMvZTVNcFFIY2po?=
 =?utf-8?B?aldHMFRrSitWMG1XS250eXU5QnVIQmhURU0zV0x2aW1XTENxVmEvVWI4eUVR?=
 =?utf-8?B?eG41UGhTamxhSUpDNitHTDU4RDVaclFZMFBhRGk2NWlQWmFIN3JHSkVFWVBD?=
 =?utf-8?B?OEpKdGVSVnk2NUNaSUxjUHl3Vm5ITVpLQmtLdjRsaUR3Nk1qTTNqRmszWTFF?=
 =?utf-8?B?RE5rUHd6Mm0vbGFRbXJXNXNsOXVPNlpoTmdlZ1R1Mml1eEJTdUd6UENab1Zx?=
 =?utf-8?B?dytmM2JpZFRzWStaTmVMWWFlcUdpdEhNNmhpd0RkYWQ4S05wY2V6WWpjRXV2?=
 =?utf-8?B?UThMWGFDUzkzb09hZUt6MWZJamIxMnFuVFNKZEtnejVpcFZjUE4yV3pCZXUv?=
 =?utf-8?B?cGQyRXZPQysrWFE2cU1FYzdoM1F3UTA2NlZNbUxVSlVxcWFtbTdJOTVYb3pB?=
 =?utf-8?B?WWlETlNva3dEVi8wVDhWNVFySnVLVVZzQ0dsb2hHTnlIeE5XN0p4T3FVUGFr?=
 =?utf-8?B?d3hvRWZzK0tmcHIzcXVaZFQyemY5NUwzM0ZBb3dhSkxLNGdIYUhuZDRMMU5t?=
 =?utf-8?B?b1ozMGg2RjZwMTEyajlkK1VDbDd4MkRnMEF1ckExOHlTSDB2bWxYV3hPNE5L?=
 =?utf-8?B?L1JwQ0dpZnRvS3F1VEJKeEovWkYyaDlidnJJdEc1L01jT0NpdktzMzkvbmFk?=
 =?utf-8?B?NWZrTEoxeW9oTWE5dDZKb0lkTXN3aW5JWnJhQnBVK3lZYnpyTXM0ZmdLdGl1?=
 =?utf-8?B?ZjBvUDBYYktzNHNjOWVGcWRpTzd1Zkg0QURJQzRjelluTS9iTmpIb0xBZ2NX?=
 =?utf-8?B?UFhPS2FPeGFnNmtsQVN0OURwZGhMVTJSVDcrbGFQOXpOVURMRjdUeEEvMkh6?=
 =?utf-8?B?ZHQ1Qk9XWk8vVURTc3hMTW54cXJjQ29PME5HYTBjSkZBSFFuUjlqV2tab2kx?=
 =?utf-8?B?N2crTDBXdkdGbFR3YU5nQjRydXkrVVMralhOdy80Mk12Rm5jWi9hQTQweThI?=
 =?utf-8?B?YkhLeTkwZkxjWFo0MGk4YjV0cWR4OEd6eFdyYThNL3cxQWZxcWMwaE1RMWhU?=
 =?utf-8?B?NjBkK05FWVdPWGFMaEFVeDlaQTl5OG5aNG50YUJ6cW9JZnNyVjNXeEhKVzJ2?=
 =?utf-8?B?aEliTjFlQWN2MEZyTW9kK3VGVEwxM3IxaWxQNktXTjRWYVVDQXRTclhrcXhC?=
 =?utf-8?B?MmhhTnJLYVdlempjQWVEc0NYUVFWWTY2V3ZoQjRjckgyUkRLS1Y2QVA5VTZQ?=
 =?utf-8?B?YlkxVklKL1RpR1hjTEVaRDdieGFzWmhzOUxRWkpRTTRyYVk0S0lWUXdVS3lt?=
 =?utf-8?B?TVpZYkV1WHNXVjJJQktBa2ZPQkY5TUR3ZXk3R2cxWGMvWitzNDV1VXQzRzRr?=
 =?utf-8?B?bUtsZkJ3WGtMT0Y1TEhQTlhWSjV0d3FYcnVZSlY3Y0h3YUZ1cjkxdDF0YWdQ?=
 =?utf-8?B?M3d3eU5UaGhNMzZzNkw0R0hrZmxCNldyMDBtL3hUVUdsYjZpRlFvMU5VL2NX?=
 =?utf-8?B?T2RWSTBrdzJJelBsQjNYNkFHVXdMdkRvRUJxT244cXVDVG04TzJrNjZFbVUr?=
 =?utf-8?B?TUxNcTFPSXNBMXluNy9YU1FRNUVLKy9mQVhSNWdBamNDRmJoZkkwdkVvbHRa?=
 =?utf-8?B?ZHY0Rk1SYlJoYlA0WDROOEVQTWdZQXRhbUJaSXlObTRkSXc5OGRnVmE2MjJD?=
 =?utf-8?B?TXR6djVtbjhCd1JHMWR4cE82VVNoWm9RTVFWWDhtK21ML1p3MXlrNlNxL2xr?=
 =?utf-8?B?emxwa0xhNmpNOHlnN3VRLzR1aE5TRmJ4RnJ6c1hJUGM1ajBES0JQOWRydTFV?=
 =?utf-8?Q?uuQEKakYKGl6fPT41WiaMs0j+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d0edd6-800d-4e2d-9ab6-08dc43079f05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:45:19.4574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Auqw+myPd+tH/vxbequRZ1nRzJMKqNpKrIpc/4jn5Z1AzMgBhgMnIld+FcVfm5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
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



On 3/12/2024 8:57 PM, Lazar, Lijo wrote:
> 
> 
> On 3/12/2024 4:29 PM, Ma Jun wrote:
>> Sometimes user may want to enable the od feature
>> by setting ppfeaturemask when loading amdgpu driver.
>> However,not all Asics support this feature.
>> So we need to restore the ppfeature value and print
>> a warning info.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 15 ++++++++++++---
>>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index f84bfed50681..d777056b2f9d 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -1548,12 +1548,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>>  	return ret;
>>  }
>>  
>> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>  {
>> +	bool od_support;
>> +
>>  	if (is_support_sw_smu(adev)) {
>>  		struct smu_context *smu = adev->powerplay.pp_handle;
>>  
>> -		return (smu->od_enabled || smu->is_apu);
>> +		od_support = (smu->od_enabled || smu->is_apu);
>>  	} else {
>>  		struct pp_hwmgr *hwmgr;
>>  
>> @@ -1566,8 +1568,15 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>  
>>  		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
>>  
>> -		return hwmgr->od_enabled;
>> +		od_support = hwmgr->od_enabled;
>> +	}
>> +
>> +	if (!od_support && (adev->pm.pp_feature & PP_OVERDRIVE_MASK)) {
>> +		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
>> +		DRM_WARN("overdrive feature is not supported\n");
>>  	}
>> +
>> +	return od_support;
> 
> Instead of doing this inside DPM API, suggest to keep it outside towards
> the end of initialization phase.
> 

This function is called before the driver creates the OD related sys interface,
which is almost the last initialization phase. I think there's probably not much
need to break the whole logic and call this function again anywhere else.

Regards,
Ma Jun

> Thanks,
> Lijo
> 
>>  }
>>  
>>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 621200e0823f..0635f9d3a61a 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -551,7 +551,7 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
>>  int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>>  				       void **addr,
>>  				       size_t *size);
>> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>>  			    const char *buf,
>>  			    size_t size);
