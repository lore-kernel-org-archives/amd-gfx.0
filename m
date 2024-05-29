Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77FEC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13F61132DD;
	Wed, 29 May 2024 06:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipPqN1BP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 712861132DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeeQMLxxiuZUweJSZsclWV3gJEdXQtgTqAexryObUD1jAC8R2Qrof6YuXWI6sctrrlWndxrA9l0ZC3Mk6ZuYVNVlja6U4fY+93TFm84+8Gh0bkHnqEpyaH4kcnCInQJ8GGafn0giFbG2cGloMaiGWPNBm3DvAjN49wVv9eXJbGcQODOVisJ42DSJb0MC8ZQaESIkwIvO8KFlUXF/dh+sWqCCfd+HVqfaVs9cEEF1PyAVa4E3kOPt+izLaJHLbxtCRHQjRZCwOhLqQa4SuiMi/f8BepDEDKSm/kYAHcv7fbQosEmXPStL9nlU9Z9z09ZGxA4IYKkZGAbkrQz9oVB+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVmW1k5vZHOLscBmVhzd7w/VtStr8dk/ade7vMd2Hgw=;
 b=Klx0vjSfxcGwhjuR8Njnno1YUSRx3SVpuE8RzcSr3xISCY4z+++v5nQPQxz7gzERtIRlaBC5vJggBMsYcw2MFOrePMQAGlWXBfLhPihs1kLKKcepbvQXKL0yK6d2rKCgUBbpzJFgs9P5reDnP8ckyt1nt3B//19//+By7fIjViFK5qPX35bcEBDobCUHn8xoMeeHAGLoyil41qZQvL6zECX9bhOX/eI2jE+9z+8sHAXxeGwDabKXVxWWH6GLkbySu9T+QRwB+roiU/nDu3LXwzMs4m02HD9I8LSbY4mRbdRoY+tC2s3F+suJcLfBbDIy5JpZ2RifSaw+OL+fRUE9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVmW1k5vZHOLscBmVhzd7w/VtStr8dk/ade7vMd2Hgw=;
 b=ipPqN1BPO+YTHdAi/Gn9K+JwiJbsIlglxb3IBD9qBlJt6s4ySk/ct92FmWPu7L61ZkUDi6LlucY6q2SK8Wa7hce1v7ihJVxo0UF4q+djbmC3/e3TdX/wO4UOKyH8JRn8Yu8riYoRQgNhF9g1mgIU/Qf2KNcHeVv5BWpbgo6kmtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:46:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:46:13 +0000
Message-ID: <afc44a27-84cb-4c62-8d5f-e87e0a9c2a77@amd.com>
Date: Wed, 29 May 2024 08:46:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] drm/amdgpu: use helper in amdgpu_gart_unbind
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-8-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-8-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e52b11a-2766-437e-ff50-08dc7fab0820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHA1UGdGVFRtMlNFZUxManhLN2RoT1lDVDVkSVgvM0VLdWVqVFBEVElTSzhX?=
 =?utf-8?B?L01EZFJWUG9XMHg5ZXY3M1dWNTZwR2Flc2FCS1VxUEp3QUFqZWtrQ1krSERi?=
 =?utf-8?B?VkR4SFNoVTZwSEwxOVlVYjdjVkNrTWFZWi8xaGNaS0pJZW9ZU0VVWmZCRy9W?=
 =?utf-8?B?RlBmWFNjZVJycUdXYlppN3FTOUdBNzhxVEVuaTNBOU5BMzVUdXgva0VXcFo5?=
 =?utf-8?B?UXhPZExPMzcwUS9PUW9UWlB2ektNN2szRmxNdDJrWHlrYS9qNTNVRUtSTy9h?=
 =?utf-8?B?SnlDZkUxanhYam11VFlQcnRmV0FOV3VqR2c0dEZ0aXkwSDJOZHpKM0VjSVJp?=
 =?utf-8?B?QWtkTzZqVGZFd0x4dmtSSDF4OURwdk44RjVsbHBHbG81bE9HaFY0KzVWekVU?=
 =?utf-8?B?R09IYXBxMS9TejR1dUVvWnduWkhFb09qUWpieGtaU3lwSFVZcCtuTFF1ZXVm?=
 =?utf-8?B?NG1Nc3BBcUtMTThVeUFyWVhFd21rTUt1NEpXNE95N3Fycys3U2x1Q0xTQ01J?=
 =?utf-8?B?ZGdITFFZRmhrOVdOT2RCNHJCL1hWRTQ5V01UdlExVU1lSFJ3NGNzdkdjbG9E?=
 =?utf-8?B?Nm5aNkhmQUdVQXRoZGlsN1NpdjN4L0wrME9Rbis2bjVoTUZWWE15L1lqdmNV?=
 =?utf-8?B?OXVDZ1dFNk9aQTA2YkhSVVZmR3hjdGExVU8vVFkrdjRheFp6dCszUk1zTHo1?=
 =?utf-8?B?UTBIU1oydjB4Q2J4OUs4NVQwcGVXRTh4N2JpQTBzeGJyQ0RoclVTY0lZbE9X?=
 =?utf-8?B?QVQ1OTNkRjhreWlicVZtbTR5MHVRMXVoLzZZbGxDcEFTdVNDK2gwN3k5cTIw?=
 =?utf-8?B?Q2lFejRKenFuSTByM1lNZ3NlM0kzSHo4ckJpcHVQdG0rS2I4MGl4Q3ZZVTlt?=
 =?utf-8?B?WWNUTktCYWV1NDlwazRHVmVNVEJaUFFCT2NxOXNWU3VTWFhXdFJTTlRRYU8v?=
 =?utf-8?B?ZTcraDdqdmdGVWZkMTIyeG5XMDNPb0hMREh5aFYxbDk0MHI1QWJIOUVzZVdu?=
 =?utf-8?B?QU9ZLzNCdVNGaGttK0Erb2JJNVJtaituQXc5dzN1TGFtNzN2WUFIWlVkUlZY?=
 =?utf-8?B?eTlvY0YxWHczQjd0YVNhZ0o1aWJVYnRwN1gzRGZsbWtlMGtzL094RGNzMWRI?=
 =?utf-8?B?Z3VSQkw3YnVlT05VSWhRdXVXN1ZPUDBnUWRSZ3VPTEFseHo1R1hOdzNvM1lX?=
 =?utf-8?B?RWhIOEUrcVBSc25tSU9rclFrZUdwSFRNM1VPeHpRT3gyUzNsUTQxdlZSMmx4?=
 =?utf-8?B?b0xBU0VHVjVSYUE4WjBIRmZmL2pTVGdwNldhWUZZbG1DQmxpd2lWaHg0dEgz?=
 =?utf-8?B?OHpqWG82LzNwUnEwSHoyR0d4dWZoSExyMjZKcm8yYklxNXNrZU5PZ012SGtu?=
 =?utf-8?B?ZkE5OE92NVFzU2NueDNUaUEyb2o2MGhQSllmL2U3d0dJMUM2aHZoTXRxdnVr?=
 =?utf-8?B?cVlGMEMwR1FmZXU5cjhHeWN3dHpKU1h0aWRlU2cxc21xWW40K1hqQ0gvUW1T?=
 =?utf-8?B?aWpVRjVOZ29XdUVrdDJSSGZJa1NUVGNOWno5WkdKNUhkYjBtc1YyRmQ2TFlk?=
 =?utf-8?B?R3hjdjFQZGdDcmlYYUNLbk84ekJqSWQ0NlAreW1lU3puQndBYXE2b3dJWko1?=
 =?utf-8?B?S0NERzUxVHlmaGlPb3NFR2lhaG05ai93RmVKbU83QXNtT1h5Nk5kQzZFZWVP?=
 =?utf-8?B?VDhYSmlLa1N5dUtEM29zV2VwNldoWHMvckgvWVJCMVpVMDR3QTJFa0t3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZvclMxanoyN2pIQkV6UHczbytkdjRnMEE4amFxUG5PbDZBdUdsMXdQTnVh?=
 =?utf-8?B?Wjk4Sm56VzhtU2IxNnRlclNGa0ROUldENk1oT3R0RldqY1Q3TGZXWGFzVEJY?=
 =?utf-8?B?RlZnU0VEVkhZanM4TFFLaVV5SmdsMVFkeWEvdjZYUDJ2eVpnenE5OVgrVWFB?=
 =?utf-8?B?S2lEdU44d0dGQWQxNSt2QVhJS3hFNnNad3hSamJyd0NkM3VicTBSZTIzZjJm?=
 =?utf-8?B?ZmFuNUNEU3pkUDRad2ZxcCtxVjk3NE9YazhWeFN2TzlhMmpEd1VPNkxzK0l5?=
 =?utf-8?B?dHU4SDlDdnZ6VGxxcnlqanNDS2tWanhsd01MVE84dy9scTRjdVU4ditzODJD?=
 =?utf-8?B?dVNyLzlmdURqRlNYQ2ljMDVwSlg3UGs2eXJFVU1HWGxBNHhadnZLYWZaOERy?=
 =?utf-8?B?N1N5R3VBYjlZLzU1YjRrQmtGYmlnVkFDZ0M0M0lkdGJ3MWhnR0RZZnNCbGZO?=
 =?utf-8?B?QlptNmdGRU50NHVJQk1BVllVMXVGNS9YV3doVTRIb0ViemNUYmw0V1JiSTBC?=
 =?utf-8?B?WE5rM3UwMWVCMDZPalB4S1ZQY2dkQ3BwL1NaV3Jqbi9DVTlQTDdEQ3k3SXA0?=
 =?utf-8?B?Q2M2R3o2ZG93WFE4VlRweXJUS01SU2dRUFF0Vlk0NExSTmFVRHNFN3NxQXZj?=
 =?utf-8?B?azU5TUFUNHV0LzI1Mkkwa0p2RXlSUGcxV1dlVFcwQ0h4dWRtSUU5T0tFZkMv?=
 =?utf-8?B?eWJKb1RoazEwYXVKZDViamtpR2tZM2RlY3hvMm81cmNnTGh4Q3d4cWplNHBS?=
 =?utf-8?B?R1hyWGxjTHZLaDhkMEJDbDg3NGlvd2E3NU9YOUpuZHZLZHh2YjZZeUE1L2h5?=
 =?utf-8?B?VXRPVmI0eDF5OC9FejhGYWxCLzdVaS9vY3pWNXRMenlnUGUrTFdId2Nma09m?=
 =?utf-8?B?SWF2REJiM01tSEFhTmVWeHBvSVFab3RhYW0wdHUzRnFuTjZmSjRVaTJUWEo4?=
 =?utf-8?B?NlJ4UEZncVVYQ3MraUtPYjdFd0k1b28wUTlKcDRhUFBqcnFYVk53S1cwZlBx?=
 =?utf-8?B?dVBoUEs5d3dadEZud1g5MTlWRTZ6RHl1cCtTM1RHcVJUREVETXk1OFdpRmlU?=
 =?utf-8?B?RGk5UENDa0pDTitqZ3JIUVdKSlNWY3RNcVFlRlNENXAxY3ZtVjNTczI5OXQx?=
 =?utf-8?B?ZjQ1eGxHeDgrZ0hnUHR2b1RsbzFJYXJ1YkZCSlhsckZJejZxSE1BKytDbEJp?=
 =?utf-8?B?TjVMWGkrSWtMVElMMDZvNjVXdm1LV21HN2NkQlpjaE9tWjJSRjZaVUR1RmFC?=
 =?utf-8?B?NFUrbVc5aE13VzJKMWtHNm5TMWFPMnVaM3llcitOZTMycVFjWnFaT0ZQb0hW?=
 =?utf-8?B?UGdndzVQNTNDVFJsQVh6ME9RZ3Q3bXl1a0dCTFVUdWI2TE8ybTIvUWpzTVNr?=
 =?utf-8?B?OHpWV0EvMENMSWo1S2ZNTzBrdThOVXFrRUdPaFlRN2w3VGEvZ0taYlY3QVNx?=
 =?utf-8?B?YkpLNXJEUFdRd2J0aXVESlJtbWN0aWhnMEpadzh0TFk1a01yRVZxT0VXUHBN?=
 =?utf-8?B?UlhzQVVTZGkvNTU5WTNUVHh2bmc3M2czbGxPQmRJb01meEcvY1RnbFA5RXVl?=
 =?utf-8?B?bDJJaHBMNVVwWklWMjU2bmJSRVFqTXBIZjRWS2djb05oZXVtZHVocFlVZk0y?=
 =?utf-8?B?TlBGeWRmQWtIc3VrMndPTE52Zk4xMnJpNGE1UlMyOUdSRWU3Q3QwOThiSHh1?=
 =?utf-8?B?SWlLdW1lODBMREcvQVBCVWM2RmtSSUpkVVYrUHZWMk9DZXR0eDI4ZHp1a3d0?=
 =?utf-8?B?bFNkbVJKcm9oVHdzK2x0MDl3YXZ3VWVPUUhNUytOOVVMOGVLL2Jybk0rcHl6?=
 =?utf-8?B?QTlHcHJwZk5MSHE1WXR3VFI0YUVuQW82SEFLNHlwOEx6S0NEcENMMngyV3gv?=
 =?utf-8?B?ODkvdE1YNTFrQXdDK3VSajVRSWRSQkJjRHF0KzJXYmx4Wk45V1UvZC9nM01N?=
 =?utf-8?B?d0hYVXFha20yR25YRXNmVWpwd0x1anVPRGVCUFhhN0JtdFNoRmJLcnpISGRY?=
 =?utf-8?B?VTBnS0xCajlFOW9icEtqWG54Y2tpUmpTSXBCcGFjRndtTS9uZEFEMDRxbDlP?=
 =?utf-8?B?ODU2MTE5aDhYajZ5VHhDeUVYYThyZmFjOEIzVFVRUmZveEpDaUJkV29VdDJx?=
 =?utf-8?Q?e3aJ3Yifw9e7m3FJoyvsDxuVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e52b11a-2766-437e-ff50-08dc7fab0820
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:46:13.3594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr/yD7i4AHUkDYZVxtb++4l02y+VIphQGlCunAAKEaEBC9Nxa/yzw918iX6c7dAo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> When amdgpu_gart_invalidate_tlb helper is introduced this part was left
> out of the conversion. Avoid the code duplication here.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c623e23049d1..eb172388d99e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -325,10 +325,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>   			page_base += AMDGPU_GPU_PAGE_SIZE;
>   		}
>   	}
> -	mb();
> -	amdgpu_device_flush_hdp(adev, NULL);
> -	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
> -		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	amdgpu_gart_invalidate_tlb(adev);
>   
>   	drm_dev_exit(idx);
>   }

