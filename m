Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E36D58CCE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0109010E362;
	Mon, 23 Mar 2026 04:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ls5Wdioj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C1D10E362
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0x5SCYwZ2TgsERLqfGBTRxA/2wLIo82OKFGdrcoB2vsBzkQaJ/OiQM81TLGdYk2OHflk80i4sRlYn7YXLOMJtTbbaFgpvVET3gUuORdKdppESJqZuzMJvUpIx64a8y9Yr4EkGHhvMM5uLwqAvefhO6QAkBL2WDx4JD2oz0mcZv496ve/sMzePMqABgunMm+52boRFj2dJslHZaoC2ivvhx7qK/Xs3T4uuVK9VNfUnbNsZCuQFxu0hksbrXEPMvSQ6Y7dsn7HIHOz5RQdc8wQlvlfGV1TEYWCRWKoykTScniK6kimn0uSvdDMVp6QyV5lJOZS06R6pBfAaFZrWgRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlt00tbwNof0jkOCAaIYD9xps0X8hS0Lf9wTaHNcYWE=;
 b=uaoswv51q4nsvk3BKkt0I40Uo3Xhyhfl8XDkxciSvYmWZImwf7k87mVik5LaATIajKLICQLVSqnd7u8tzoxQVzz2PLh/QOpP8U2I7wYUocQ5YxkJ5bN5SPxKw8AQZYx71qJAGd/iV7ucZjbJpuiaq8rwflJwvNMsorB7Q+q1L3d3O8LVwMDkE7rpI4405/i/PhFyc6gFbMZdPeEfW3fokUKEiMltcvXB8U7WY7JR9CaDbdQd4YXbove9I7Zt6nkjinMwrI7Pckd7Y38VpPHUxqkfLWLaQ9voQUhV2DMr250kpmPVcKVyyvvciTrHE/slc4SRf5e5PTXKm7jjm8YizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlt00tbwNof0jkOCAaIYD9xps0X8hS0Lf9wTaHNcYWE=;
 b=ls5WdiojkbXnoD5nZZh19v4/Qju+dMmCfrgt8ap6SZSP119iwj79+ztzvOBTE9r0g/oMeN2thggRnD7FxbZQjqVQx/CTg0MQJgtHefyImy1TrOUYvvnpXPTrNQfG4zaIFr4C3kaXtQfR5RMoZCKNoMZN2yH1pDSBQ1ezQiXjPI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 04:02:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 04:02:46 +0000
Message-ID: <9c9c936f-72c8-4665-ab88-f10ca01559f0@amd.com>
Date: Mon, 23 Mar 2026 09:32:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn4.0.3: gate VCN reset on PSP FW for MP0
 13.0.6
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323012916.355223-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323012916.355223-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c2836d-ab87-4b5c-0f5e-08de88910a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: LBnViCImQL2RW1x5e2lGoBhEhFCjMI+4FUZJHecBRPYJ0EX13nL+QzlGDEdtgRjIZPgBEVEPKBUZv91cOCaB0ATtu4OGVnzOEBeJL0WTTaQZEhL8hhFkvqlQGfQmcwxY7oFjUp05i5xznDXAtwe3fRJIu5V3+GGzqckWJBIrzc7RbmoNbAPAkSF4TjW/0dUqActaPC+GP4yfDtWSSJYfi/5VsSgSw2cxs7DXmC0JTB9MsviQKSntZiLi5JKKQFeawTubOiMYaa1DxNH2V1mPn0FBijBToOtFFdCKCqji2ENkeVzmNdeEtJbtzCm7GtMtLqprHUBsdeWWxPoyvnPH/3X9Q2X7cMeQOmTY8VAn9iGOp1KrWakSFuS/XSFzQKbddA7QL1OesQlFihZi4c1XFdUbuGQUZ3FCvyuagAn3evYllJGG3B6ppJE5A9wlsxdWRCRuFAj1/9eW5XKh3tm8pZrxWebd82Lae3bAxhXIUP736xwoX2r9pU76Gqp8FwslpqhdG6ZngXTfjPUTHs7K6pE181mx/Ih9sZPjnWwoMWAeCk150xK8ISrsnCjqAB+qktbD5sUkEl+skPmWecV9EZWU9yuUKb2LxEnV7pb19NiquJb7nNdQcnpOS0HelAxaLlzXKmKWU+17lFZQKOYL2DHmuL0D5c71Am+Bw7MGzIQ4LWQogFMtJH7kMPUjjTqr1UchHtzc2idyYryCANgmiL02oe/+HrGp/0dICPixD2g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTgrd3BhakFrekk0bm1BendKa0JVNzhpN0IvK2ZsWjl0Q0k0NTNzdnZHSUJu?=
 =?utf-8?B?VGkwc3NrUU1oc3B4QU9USlpSR1l4bzM1M1drOWd4c2pQb2lXS3czRFBKV0Y0?=
 =?utf-8?B?TnRmOWxlSFBDTmhrSDRkQmx0bEtkWU9hNlBzQkJnZWlXY25aV0I2ZzVkK3BC?=
 =?utf-8?B?NmNaUUx6MGpvZ1dXcnFTb056b21VVUNVY2JjRFFUK0N2eFhXOHprRVNsVWs2?=
 =?utf-8?B?a0REVHlVdkVrOVNodDBPbXZZSDJYSlRGT2lKcUZyTGJuNEVGR3c1eFVqaURs?=
 =?utf-8?B?UGdqL0ZNa0NiU2o3Nzl4Njd0NVk1NkVqWVlZMnF4L01UNzZLejZpcFM3U3Az?=
 =?utf-8?B?bjA2UVhhLzB2SThjT2tKTUx3K2Q4RHlvNlZHd1EvNDlxMmNndVFyZ3hsN2ZL?=
 =?utf-8?B?cUd5MjlRVU5DZVAwK3o4U3lFWVJQSjFPcnpqdFR4aHFydU1WTjRoRzBHY2NQ?=
 =?utf-8?B?RHppN2Q4OUdla1QvNnFPbWQyZkFIUkdkN1pwVXI1Z1RUODVVRnRieE01REo0?=
 =?utf-8?B?N3R5OGJHQzdaV1Z0ZEJBVk1odzlnZUh3QlVhY2VKdkE2SFp0Y05oZFdMMlNO?=
 =?utf-8?B?bVlMTDZMa2cwSVpmcFBidjRZNnRhV2hSSklWSCswdUF6b3VQTGRHamd0Z1dz?=
 =?utf-8?B?MmpWMFM0dVZoZ0taMlRUM0RlTGZmaEd3ZjNqL0Y3WGM2Nnk5VXJsWHY5SHFG?=
 =?utf-8?B?MnpaTG1YMUNIWGZHV2Y2bksvNGpTMlBRVzBGTSszZ2JFUzdQNEhBVXZ6aDRV?=
 =?utf-8?B?U3Q2Tk9lM3BRS3RLQVZ2MnJscW50bVhLaDN5S1RaRnUvQXJlZTJYYUJ3YU5O?=
 =?utf-8?B?ZG1jL2NjbnJpRXAxTjJya2xjM1hoN1VGOTdlZGhEeEFtOGlYbDY3ZU1mRFdY?=
 =?utf-8?B?VkVTaERwdDkyL05tNVlvdmhDVTNaV3pWNlBpeGJFTFJ0MG5Ncmw4Z2xZRXRL?=
 =?utf-8?B?VTdMZ3FDZnAvMFBmYXRSMi80d2ZIVExlVm43MTVNZnUwRktieW9ibzJFU2dr?=
 =?utf-8?B?L2xxVzJ3QmZhaUJCTnIrc2hpT1k5RkZGKzBzV0xQaGs4Nlc3MlZHWG1hdGts?=
 =?utf-8?B?UEZrOXc4aFU4OXlYc1YyM0JORlUxck9iZ0FGYkl1bWJEQTE2QVcwNlN6RkRR?=
 =?utf-8?B?TFR6REE0SlFlVjdTVWt6WTJmQWo1TXVtaTI5d3dUNU9CVTdacnNjRGFjRnNC?=
 =?utf-8?B?d09TNllsZjV4OEJkMnlVWXNCdnNHSkVlN3lhR1A4V0U4M1hrTG5WMUh2M1Er?=
 =?utf-8?B?UVBYdW53VXRSVllEbVVibWVFeWNZaXUzVzlYUTlRRDVKbFlpbkpaTjVYSG1h?=
 =?utf-8?B?bm5NZisweEd2QTdYVEd4OXpzalhoL1BUQWcwZWsyemE4Sk1UM0V5NzVCLzhG?=
 =?utf-8?B?K08xTzE3UW0xSjRSYkRvSkJxVnV1ZnJXSGFmUmtRVEQycUs3UERIcHdDMlFk?=
 =?utf-8?B?Qi93aVBrQ2J0TVlmNkE2cDBMVnlRN09WSlk0Q1kxZTcrYnZVYjdjM3V0elJ3?=
 =?utf-8?B?a1JxYklySlBtVDdCVTdCTktsNnd1NTlhM0hRY3VCVCtURFJ6WUV5R1pHdFNX?=
 =?utf-8?B?d0orRXo5aEtmWld5R0pvalJQVHNOd3piN3FNRUZqc0ttcmpZNlZXS1U1cmN1?=
 =?utf-8?B?N2tXOUg5WHdOdktMdnVMTFRpdmlqeVBld21hVjFFUSswckVXOHFLSkpkMk5H?=
 =?utf-8?B?SU9UeTNSUXd6bHlDY09JM3VjaHdjWHN3WjFKemRIeUlpaU1tYkI5UDRFd1lw?=
 =?utf-8?B?bk1nc0J0dGp0K3k0Y2hXQW1JaWkrZ3B1VmNCVFgzZlVMZUtBd0N2YnQ4Uzhu?=
 =?utf-8?B?ZFpMRTQ2NE5QekFHRzJuQk9Lb2ZFdFpENjVOcU10ZTE4eHdVTWhUV1FSekdl?=
 =?utf-8?B?U0dSSUVTdWx2MTJPU3NXWkRncnkxckN1Y3A0MyszRDFMem56QnhKUGdHdmsx?=
 =?utf-8?B?ZmpOTlhkZHc4a1VvQ1EvV1ppWXl4M0xBR3g0QldFMlo4dmlNUmxQR3BRVEZV?=
 =?utf-8?B?V3Vrd3JnajRNMHJ6THNiQzZLelF5NEdITm44blcyVkZDRWhkbXBoSUduS3Bm?=
 =?utf-8?B?eVlxT1M0TEVXYmN2VjVRVDdFVlE5NVY4SU81WnlBekYxUEVIZUh1M3FDK0dz?=
 =?utf-8?B?OFJaUzJ6UGY0a3FMaGg5ajhTWCtqeFU1OG1HMENpUHlqWitIeDFrU2VwdnFS?=
 =?utf-8?B?LzdwUjBHdjZqTlVxQm9USnBQbGRLUGNlUlZrSno1NkN1NXhKQjdVRXJkaFZN?=
 =?utf-8?B?b0x2UkZ4SElwR3lOSzFvdmMyR2x3MVBxK09FdEtLN2Q1emw0R0Rwb3llaEtj?=
 =?utf-8?B?OXJ3bGlvY0pZd1VHYVNwV2VaY0xVbkZIemhBZGlrZEtSeUM1YmNndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2836d-ab87-4b5c-0f5e-08de88910a95
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 04:02:46.5653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC9VjNyDd+UoIsipqZmnKFtfyQKAV9hvPpkXp/iFsBoDrgAXOQGDz/3kPWLMxu5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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



On 23-Mar-26 6:58 AM, Jesse.Zhang wrote:
> Add a PSP SOS firmware compatibility check before enabling VCN per-queue
> reset on vcn_v4_0_3.
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index e78526a4e521..7cc8f6389152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,26 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +static bool vcn_v4_0_3_is_psp_fw_reset_supported(struct amdgpu_device *adev)
> +{
> +	uint32_t fw_ver = adev->psp.sos.fw_version;
> +	uint32_t pgm = (fw_ver >> 8) & 0xFF;
> +
> +	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +	case IP_VERSION(13, 0, 6):
> +		/*
> +		 * FWDEV-159155: PSP SOS FW must be >= 0x0036015f for pgm 0x01
> +		 * before enabling VCN per-queue reset on MP0 13.0.6.
> +		 */
> +		if (pgm == 1)
> +			return adev->psp.sos.fw_version >= 0x0036015f;

The program check itself should be good enough.

Thanks,
Lijo

> +		else
> +			return true;
> +	default:
> +		return true;
> +	}
> +}
> +
>   static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -141,7 +161,9 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
>   	adev->vcn.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>   
> -	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
> +	if (amdgpu_dpm_reset_vcn_is_supported(adev) &&
> +	    vcn_v4_0_3_is_psp_fw_reset_supported(adev) &&
> +	    !amdgpu_sriov_vf(adev))
>   		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   
>   	return 0;

