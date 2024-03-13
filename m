Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5B4C54E5D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 03:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F9F10EA77;
	Wed, 13 Mar 2024 03:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYXhqIss";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB17B10EA77
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct/zTPQshrTMkxTmQTYeAQJPy0ZyABKWeEJPtVzz3er9kL0bhLecmiYUz74P9oyKjtQnuKOMTV6V/tIGfsCFCbmzzCbnORbB9F8wkKRvQvKsPUm3TnQTHuswHPQ+BZ+j21gYBhj30pNZEhVmn3nTrMLZYBIkz2MM4NgAyV04T391D+tGXdQ9V/PGLp8JEj2ENGksue4AV8zp6zHbxpmqmvbhDgxOy2iLLLWBnBQ+C0TCtHmv0ERkwsUEVn+6OXvnwbCHGCGtlnj9o1LnxfIXyaXnnGJUim2puP6FylfWLoTTaedLiw4RiMRT/NPPoZ8mGsnrkolDWi6LQOOhtccp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToVjPGcY5ST9znNfGkKWrFl2da2ot4rbQwrf7LQru9s=;
 b=f+DfsSKct4ctkgXYa2XZs0PpjbOPq6VJMFd6IZ1BK3Q2QRDJHnEUTVONCMIIu0+7366pHDaGC8R2mhPlm4uXdhWaAnIsXzsulVubVy32F7oy13LT3GIi4qnP6+NNlOcdWse605bV5JSm8KbMRzFC7HM271NDGXi5jCoQnLar3XRhHVvBgVamu/YZmFNzXxfltmx26iSPqhk7eSOEh72053/Yuh7CC3x4R2WmAB+BBEocakHB/BwYScoMYRuCXQkMYBVD2a1L9rwbJx2SWVc71/djHv3k+r5CkRgP/vrwevu3G268G4nY/in6U+Wbwi0JEB0NLhWW6qZKzb55JEynIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToVjPGcY5ST9znNfGkKWrFl2da2ot4rbQwrf7LQru9s=;
 b=CYXhqIss4P+b51AELNYYQmTxb+oeQF21OfpcqCAXsTdS7QZgfyHgl5KC17+9j2drsg//YaDPLZn5JelhpPzfrgDLZlNTaTXU9BvSmUFycCVIWEjwvdiNPUDNLHXA6lKbsjjm0meMli15ER2ncIaAGI0+JnHR9p67IWOXJ0mX4JI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Wed, 13 Mar
 2024 03:28:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 03:28:03 +0000
Message-ID: <050e8df9-3de7-4e59-82b4-27632127a3e1@amd.com>
Date: Wed, 13 Mar 2024 08:57:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the ppfeature value
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240312105934.2291792-1-Jun.Ma2@amd.com>
 <636b1578-08d7-4a6f-a499-6dec02c58aa5@amd.com>
 <5a0fc9c5-13d3-465b-b0c3-2431f1bd0995@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5a0fc9c5-13d3-465b-b0c3-2431f1bd0995@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: fc405381-d736-496b-287c-08dc430d96ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5WpmLPzj5JU4V+e8YzACRDPs6Nknx4mNLvmRGwacrozs4meAbdLp+7S7DoHtp2ETqLtFV3qyxz4Cor3hST3MTYKPUhFmasKUizlAlHLjQlWJecb/4L4FSEsN0F5GwSiu0sYn1niXQ2HJOBfVBtA51sblactzU/TxNOoZF5QcvdXiIx8NzcH30Jxr53OJljcobh9cXaoi1CkkJ/nzu+snrRNLP3Ph4kt6ILUUnDPZ9AlDFWuAcxLq+v6fnzbklBSwKDx0EMFXd2e5vDe24M7cqUgDzRZDpnOGscFdsYQ8npyJwSQthhenUeW58tf9o7rRwIzDfJ55wu1y1Km57JytZPZCvXlg//xYzbF5CRMjNfqHphp1qIZrqd9adIP4jXI8xIWuEOf6y+KPbbYhBtUHloiT6Hv2ta9vIJHce5W6oW6M9XSn9xBmMVRjIjp7XxZDmYmtizbe71tbVfnP0LeFL+kIQJWS3DUmUZQzICJjHyrS4huW4xbQAVhbVrByc+7sC0xq+vscYdUGb1LIZvt0INqdaCyNrwt7ApNbzEx2lHrnGUsSUBgxMjUVBnoP8DiKG7ie68gIJ2MWKlDUp8+SIfkMs7819DFeKojTTVFdOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hxVGRtNmR1QmpwWENYK21TbTRIVURQVjNTMHFoUlZQUGx0eU52NURRVXBG?=
 =?utf-8?B?OEFmRy9qMFl0N2ZXSE9zY0JIVktEVUF3aklnVldMQmlSV29DWVdERUpiaDNJ?=
 =?utf-8?B?UEp0Uk9YNXl1MjI5TmFVUEVXNGhNRkhBZTRaSGFWNlIxd3pxQWQ4SHBDSFVU?=
 =?utf-8?B?UUlXZk9JV3RvS1BnWTd1ZzZIcWRoRnZ6bHlWZlhYMUJNTUw5SFRwdnZXV0Nm?=
 =?utf-8?B?L2gwSGpvUENYR2RCdzRmdzhtT0t1Zmh5UlVXNWxNYytxdGJ5ODEyaGZ0Sk56?=
 =?utf-8?B?Ky9rYTZLVndmcHNucitrMXNSQ01uTzg4eUkxYlBkRVZvK1F0NVozM1l1djZN?=
 =?utf-8?B?U2FBRFFyZ0d1QnNjaERMQ0szcFRiQ2JzcEkxdktDcHVsWlR1djV5OCtkL3ZP?=
 =?utf-8?B?TFNMc0ZXakEwaDNDVDBydC9UN1VPUUFVNEQ1RmFLMTdsNkRzMCtHemU2ZDNP?=
 =?utf-8?B?NllUYlZBQ2dYRTc3Y1hhL08rSE9vT2tpK0NMVzN4WEdFay9NdFZsNVM0Mmcv?=
 =?utf-8?B?WHc5T08vTGNBRXZCQUprWEhuL2haWmpZSDFUeENDR0YzcWJmZkljWktHU01V?=
 =?utf-8?B?QWg5SzdneDBDWm9jWGVwRERMK2hHY2FyMlpWZUNWT240MmROVHpTdE9YL2N6?=
 =?utf-8?B?dVpPcklsNTE2amJrZFhCQ1hkM0hDUTBFaWZGTHk1UHZoOHB2RXRGbDFXVnVM?=
 =?utf-8?B?TGE4UkVjbXZ2d0xrTGgwMWJ1UUxJQXpabEVRVVUrZllBOWZaT0RYWDJ3WXFm?=
 =?utf-8?B?bHd4c2lGL1I1bmhuSXpNcDVEdlFoWEE5R1dSejhQa0pyZjcycy9BWG40Nnh3?=
 =?utf-8?B?ekhnc0EvbFdjUG91QXJTWUoyZCtaU2J4YTlrQVFIQTlRanRGbmIwcUFzOUVP?=
 =?utf-8?B?ZEVmeWZ1dTN0S3NicExUa1YzWTg3anhsbVl0TmRoZUErVFhPc2czc092YnJ4?=
 =?utf-8?B?YWl1alFsd05mRFNodXZQZ3BSMTB4R0F6N3FzbFljemdtd3FVT2ZSR2ZXNkNO?=
 =?utf-8?B?bjJZcHROTThMcFhNaTVkeWIxSWZYRWJObW1hY0VOWkhaTk1ucXU5MEdVZHJE?=
 =?utf-8?B?ZzJoZnMxRXI2T2JOelpuOHFkVzh0MXpjZ2s3d2JxT2JpQkthUU4yQzRBdlNZ?=
 =?utf-8?B?cUh2MGU0YmpjYVEyTzdFRVlnYjVDUUpqSEg2WGdweDRCL3loSThMMUV6c0o2?=
 =?utf-8?B?SXFLMWlNWWt6dFpOR2FCYi80eXJkaDJkM1FlZzJzQWw5YjcwTFlKemdTMTV1?=
 =?utf-8?B?VDBxR2E4eXlSWWNmeS8yQXB4RGRmaVNWMFpLbFZTV0pnZ1VRY0VBUHNpM01Q?=
 =?utf-8?B?dXp3NFdta24xTXphWU5Vdmwzbk8zL0xncEU2N05QUG1GWWE1bEpDbGhpb0xT?=
 =?utf-8?B?UTM5VCtlNWJoMFY5N2Y1RmZFd0RkKzhGdnRMNFdWMEYveGR2bit1MHA4L2JP?=
 =?utf-8?B?OHFnYkZIbnBZYmNKNmQ1dHp5NUxseUVKc3JRZno1ai90UzlOVm5TdmJ2bkIr?=
 =?utf-8?B?S1htV1VSVUQwOTBWZmJkVy9VTytscjVqMTJpeS9nOVZ5NzgrWjRsNXBLR3R0?=
 =?utf-8?B?bVRYNlNONGVQQXkxZTNCVTNIcWQvUlVHZGdsLzY2ajg2eDg4YnZkdXRVRkJV?=
 =?utf-8?B?WDIzVHVnRjNDb3ZLMHhQU0FlU3B4NzNWWWxlc1hya2VlUHhuaXZSbzMrRnIz?=
 =?utf-8?B?NHQrNkxBam5mc2RTMjFEb0FORVdOWE1DMG52Nkt3a2FPNzRqczFUN1hNK0Ny?=
 =?utf-8?B?aU01NUlzenhZYUFqN3EweHRZRkxhRDZQdm5wSTFUZTVaNDBWNmQrOUdvODV6?=
 =?utf-8?B?ck9HSnR2bWhtZW05ejNZY28zQTk1VEw3VUErZlQvMFBXdFNRQnJnUmJ3NVNW?=
 =?utf-8?B?ZEs3aDBJTU55WmxEMVJEcmpBV3B5SVFrMEJ4QjFBMTg5MlA3SmZjTXYrL0di?=
 =?utf-8?B?VkJzSkdIclRoU3FOVUlkVlVURllHTXRxYjNScktXT0VIeUFGTjdrUUpJUGRX?=
 =?utf-8?B?MWZhOExxbGlNZHFiQzlXMFVwU3duN0ZNR3JDbW1QMHpkK1dKcm9sL1hINWZ3?=
 =?utf-8?B?UzhtaHIrMFdreUxya1FndEpqMno2Yk41VzhhMUJ4ek93TlJVNTZyQlJORzQ5?=
 =?utf-8?Q?BEGFUmtK8cB2RDroC5FtBk4CW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc405381-d736-496b-287c-08dc430d96ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 03:28:02.9471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TydzSGyvl8aD17YzBUvxI0uR4S0RLOvJuKRgYz61LV4vCtmBym1kbXKiv+kYdIIC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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



On 3/13/2024 8:15 AM, Ma, Jun wrote:
> 
> 
> On 3/12/2024 8:57 PM, Lazar, Lijo wrote:
>>
>>
>> On 3/12/2024 4:29 PM, Ma Jun wrote:
>>> Sometimes user may want to enable the od feature
>>> by setting ppfeaturemask when loading amdgpu driver.
>>> However,not all Asics support this feature.
>>> So we need to restore the ppfeature value and print
>>> a warning info.
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 15 ++++++++++++---
>>>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
>>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index f84bfed50681..d777056b2f9d 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1548,12 +1548,14 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>>>  	return ret;
>>>  }
>>>  
>>> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>>  {
>>> +	bool od_support;
>>> +
>>>  	if (is_support_sw_smu(adev)) {
>>>  		struct smu_context *smu = adev->powerplay.pp_handle;
>>>  
>>> -		return (smu->od_enabled || smu->is_apu);
>>> +		od_support = (smu->od_enabled || smu->is_apu);
>>>  	} else {
>>>  		struct pp_hwmgr *hwmgr;
>>>  
>>> @@ -1566,8 +1568,15 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
>>>  
>>>  		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
>>>  
>>> -		return hwmgr->od_enabled;
>>> +		od_support = hwmgr->od_enabled;
>>> +	}
>>> +
>>> +	if (!od_support && (adev->pm.pp_feature & PP_OVERDRIVE_MASK)) {
>>> +		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
>>> +		DRM_WARN("overdrive feature is not supported\n");
>>>  	}
>>> +
>>> +	return od_support;
>>
>> Instead of doing this inside DPM API, suggest to keep it outside towards
>> the end of initialization phase.
>>
> 
> This function is called before the driver creates the OD related sys interface,
> which is almost the last initialization phase. I think there's probably not much
> need to break the whole logic and call this function again anywhere else.
> 
amdgpu_dpm_* are meant as APIs and not meant to do internal manipulation
of pp_feature with every invocation.

This is indeed not the right way to do this. There is already another
place during driver initialization -
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/pm/amdgpu_pm.c#L4277

This could be done even there.

Thanks,
Lijo

> Regards,
> Ma Jun
> 
>> Thanks,
>> Lijo
>>
>>>  }
>>>  
>>>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index 621200e0823f..0635f9d3a61a 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -551,7 +551,7 @@ int amdgpu_dpm_debugfs_print_current_performance_level(struct amdgpu_device *ade
>>>  int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
>>>  				       void **addr,
>>>  				       size_t *size);
>>> -int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>>> +bool amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev);
>>>  int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
>>>  			    const char *buf,
>>>  			    size_t size);
