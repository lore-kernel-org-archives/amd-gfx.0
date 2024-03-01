Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D30FC5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 14:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2624B10EEF6;
	Fri,  1 Mar 2024 14:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1g2ixS/I";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF8010EEF4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 14:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1URUPEVMTKVDrxkxYI2sWRJe6pFVQeTJRVV//adI+tCDy4NyT76bqMmRbHu/hFgsXCyiRy7o1zgqsoWXD6hVtfNhNqpIrsxX207PUAO6qMqdrncdkNwpJkJSBJJWFXWq7kdPJgHvf5z2xlnUUDq5F7TAStu/GIYTTRiYzQZ8euzIV+nkfH1hd8yKfLZt1C5k/JN9NSIIEJQSdvNh1xC/24cBNWDaLZp3/HVEK+1tdADbXWrc3KaAuApuasuCuF1RHBRGpveWV13iwjMHzLkWEknebqQD4ZOqqlAho/vbxN1LoyLTw7aikFolVdTc7VzwKOtZjVdB9WnMSIcMwZ/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZQopjdCNlNhA/EIc6RjBFo03UFAd9HXZaELxTvpFFQ=;
 b=JqaJD1Vz7buI0V7LAYcNjB2GKxqNJfakwid6BUW/YI9MCNuThtg9CSsOjNkCQGxbFPpQZnwfD/IfB4cMa2IqtBendIG5du6+GS92fzwVW9BVH+LnKm24bfn7zZU5OR3HWERgInLvlhQKGijWc5oOHi5NV/V7YFWXYuoy1mLHwyptmdIKw+KEX4Qf/r8HPGC0lToDNcXvttYl6m4SgSmdVr6LVv4iWXCkOuhpqWB/tkVfhlL7+MP5zsaeuWLk3Sn7L8dejhGVbr9zq7mYpwSHUDgfh7mMQwXePm4dfx9UcZPuT7JI94iSa0S7CMmURTigoVncAyX7NZHomF4dYIUolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZQopjdCNlNhA/EIc6RjBFo03UFAd9HXZaELxTvpFFQ=;
 b=1g2ixS/IGycly2XqPcw5Nqy6zg7urz+hPVjJYHcIoAVN3IWjPbJPn7kT1eXmMt2FkdK7TtwYoXkzZO1wLIjjRLiWg/LElviNyl5piey20OUewgdd9exOxbbz2I8yz5HV3O0KBxh/SyPjz/cr9xGZoXsOvz3S4tDEgHd8FGOxmMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 14:01:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 14:01:15 +0000
Message-ID: <cde9a11d-85d3-4b27-9237-452a6e2fd24b@amd.com>
Date: Fri, 1 Mar 2024 19:31:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix potential Spectre vulnerability in
 amdgpu_gfx_parse_disable_cu()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Nicolai_H=C3=A4hnle?=
 <nicolai.haehnle@amd.com>
References: <20240301124551.4038626-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240301124551.4038626-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac740f4-2e97-49c2-5ddb-08dc39f80f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRq8qSKYtyzW6tlxZ+FyFW2F+VJapPZ6UZxU6iatR7oPEyaarTmqa7ONyrdrYQTKxLPut/Xpk9UjnuvtfswTXCIjPyyOhpf4ucit0wxmyTRxqAxvl1KCfKFswXiNdAgKnTuxxJhVWpgrPDayhFVE6ydjGzJsogSAzSAtH1a7y7S1CLwN8SPB6yjZ+tu9t6k5q7VYNspokeBoPAC2ksp3SVelZODK8QHKrYkGUHq23h+klNRvaJCTbZmzEZ/qSTHW5I+PLCleKiEpZ1A7GUvcDsBq11RULFIwBoc0nxoTO9ytlaD986nAtMbDQu6yiMYzHiAlGFS+NY3wLeovC1QUJ+P2DSlsXlgkn4no05ALrmyrA8aaYDNgvL21wGMywoe/20lQTPGiBmbnVoysNQqxv2O/WBaq1jJtl4aBoz4r5dLq4a3GBh0HJEYDUWbl6/Rvq4l/BVqWW0L5Oekvdob83OedMXVWRYfPI5O4jeRFhna1T7rGj5J9AhiM5qYZJ9FtfVhwkKQBJHZZH1/IbyBF/wnhWG9hEZwrDG3eFPAW3zHhN4gYajLbVQCclnEX4CnEmenFUetxv55aOcaK7zgRxFJBTQDOYVEI/ADicGScHZ+Xd8mK5tb8f4E7z+YQU8KyGaQES35ALoPozbec1tWh5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHR0V09SdmNCa1hnRjBVdVNKR1pSYzUvcmhuNzBCaFJwbERVZzR2eHE5aDJX?=
 =?utf-8?B?MjgyS3YzRUdxZTAxV1VZZDN2aDBBdlFoajNSOUJ1Tk42YmNoTnQ1UHRabDFP?=
 =?utf-8?B?RmJYUlpwcG5QeWRxUjhUY012UVVmQTB0OEpwWS93ZVFML1ZTSW5qNllQRjVt?=
 =?utf-8?B?Y01kaTc2dVNzcC93cmxRSGRWZ3A1S0swNUpKRGp5d0dkYlBsL002YzMxVVRm?=
 =?utf-8?B?QTJSR1Zhb0VTcTlXdmpzemMwZDd5OXB3bDhac2NRUTlmQ3V2WGphbURRemlm?=
 =?utf-8?B?aHRJQ2V2WkRrQ21Eb3VCUVI4UGxPWXRDZnk5NGNnMC83TkRTQ3h2V25uZmto?=
 =?utf-8?B?WEZ0Wkltc1I2Q0Vlc29tTlUyUnZwK0QzNWVnZU9MNEFRNzhuRW9zemxWQTI0?=
 =?utf-8?B?VUlvaFg0ZjdmZXBFRjlKLzhxNG56OU5hWlNZYzZsbWZuUjVIWHZqY2dmVTg0?=
 =?utf-8?B?TDhoa05ITkVpVkhONnY1NEF3UXVSUE5FZ2IwaWo4VkZya01zRzhidDJnUVp5?=
 =?utf-8?B?OU9NR2QzYmdpYWpwdStUQTIrY0lqNVJyU3Bqa0tNaUgvYXJ3RFpVY1lhaXBK?=
 =?utf-8?B?VmgwUjVtejEyU3FXdjFNQ25iOENCU3dVdjFJUnY0MmpIUi9WMlNDOFV3d3lL?=
 =?utf-8?B?Q0JkNldvQkRBd2JUM0Jac1hKeVVXV1FNODJLQS9HcjBYakRWYXR5NU01YVIx?=
 =?utf-8?B?NGRWTHNTeTkrU2VPYUxwYmxXT0ZsZkdDaG1FZXJid2NrTkJZTVhQaGJWSmJD?=
 =?utf-8?B?NWE0KzJ3K1hiSWtCcHgvSjlkNUs1UU5hNktOblprYWtFSlBKOFNRSjJIcUtK?=
 =?utf-8?B?V3U5ZjV6NVB0b1ZoNUZEeWdsSFpFUmNFQ01ia1VPWE5tbDhSTDhQY3Y1VXNv?=
 =?utf-8?B?TW42SXY3OWREMndFSVdGT01ISFVZcWJVN2o3TjZlY0ROZXlIQkQxYk9tbGta?=
 =?utf-8?B?Lzh0K0pzaEp5aUo2cGFGUUJTbHJOWmkvUEo0K3lpQ3pCaVFIN1FWY2F5Y2xV?=
 =?utf-8?B?b01OT2VodWxoelZPRVM0V1R6ZnN0M3FRZkZ0MXltRjU2eWlrTXVsbEpSVDdY?=
 =?utf-8?B?Wkp6TFJaUUZ4aUNXRzZZcUpGaEJPL1BGTEZlSlp1SnhIVlZYak9pMmxMeENW?=
 =?utf-8?B?MmJ5VXN5V0FEUE1wYWQyV2VJRE1QSldZZWc0V05NVkRDS1dtUVBCaWdjUFpX?=
 =?utf-8?B?Y3VicElJSVZXcnJuMnhPUnJVdmllQjVCQXNxWlF5eVl3MDRtUlBlS1JjWTJu?=
 =?utf-8?B?N2pMUXhxcmtLWUpxY3VBd280bUNKbXZmS3V0UkNhN1ZRSFZYekZYY3BHVFN2?=
 =?utf-8?B?UDVaTm9HaEV5SktWM2RqdmtuTm1iZGtaY1QzZDNWVHU0czVDdTd2N1dZR1F6?=
 =?utf-8?B?cDNHS3ZnY0UrZVNtTW9MQk5YWEd5L2gzaFY0cmJ2V1E4V0xxMDdkUksrV1Vi?=
 =?utf-8?B?bTRKTWJhQmVwUlM0WndGeVNRNkhsM1NEcnJYemUyWEpzMGVkSzJqallVQS8z?=
 =?utf-8?B?Z2FyTUR2RlNETjRMVytYRXRMUTdXNlUzekpZYjl1TEM5N1lnZVd6V3Y0MjBE?=
 =?utf-8?B?c3pOcE1nOW5hakRaWDhXaFk0Y3BQbElBRXRmbkRpMEEyR080bTE4YVdCMVZJ?=
 =?utf-8?B?N0NnakpMNEdOVkFqSThuV05SREhaKzd4V25KTVRveGQvOXFLQ1IrWDVzcWhq?=
 =?utf-8?B?U2Z3N2hkWFpKWlNZcGdjelptWHF5SC9LYkZxbWF3WHovMmpkSHY1aXNJVE5L?=
 =?utf-8?B?TXZhYy9tSmVMOC9FT3VvKzdPRHVyUmV3VVNmVk9oQzFOS3oxblJpSzBhWWZh?=
 =?utf-8?B?YzRqZWMxNGZ5QXc4amR3M1lqeER2Q3BKTzZPdGhNNEp5RHUyVnY3dUZTTGJm?=
 =?utf-8?B?Qi9yRnhGbEljeXJaaUFOdm5EVEFjbHBDZlBKQ2F3Y0lPYkVIVWY4cGlLLzNt?=
 =?utf-8?B?elk5ZFJOa2NFUFhQM3l4VXd2M0h2U2w3ekRFNW0zTDNkaFB1MzlyTStxN0xB?=
 =?utf-8?B?c2Jjd1JJdnd0elgwTnRlTGs2ckpzMEl6WTEvT3QralZ6MFZIZWZndUNFZ29R?=
 =?utf-8?B?WDVRalczYVl4Y240TktlRmFjdnROem5seHdCcmJmWmRQTEtxSmZFNGk2b0Q2?=
 =?utf-8?Q?OEdqAa0D/RHvx+g5DYBwlgt6t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac740f4-2e97-49c2-5ddb-08dc39f80f14
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:01:15.1195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg41aPQRZCN+BwcqYGB/nPvrcXNPJ6Ahtvbs2BVaWjfOsvxpZ7QW17Ar00f0ZpDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
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



On 3/1/2024 6:15 PM, Srinivasan Shanmugam wrote:
> The 'mask' array could be used in a way that would make the code
> vulnerable to a Spectre attack. The issue is likely related to the fact
> that the 'mask' array is being indexed using values that are derived
> from user input (the 'se' and 'sh' variables), which could potentially
> be manipulated by an attacker.
> 
> The array_index_nospec() function is typically used in these situations
> where an array index is derived from user input or other untrusted data.
> By sanitizing the index, it helps to ensure that even if an attacker can
> influence the index, they cannot use this to read sensitive data from
> other parts of the array or memory.
> 
> The array indices are now sanitized using the array_index_nospec()
> function, which ensures that the index cannot be greater than the size
> of the array, helping to mitigate Spectre attacks.
> 
> The array_index_nospec() function, takes two parameters: the array index
> and the maximum size of the array. It ensures that the array index is
> within the bounds of the array, i.e., it is less than the maximum size
> of the array.
> 
> If the array index is within bounds, the function returns the index. If
> the index is out of bounds, the function returns a safe index (usually
> 0) instead. This prevents out-of-bounds reads that could potentially be
> exploited in a speculative execution attack.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:136 amdgpu_gfx_parse_disable_cu() warn: potential spectre issue 'mask' [w]
> 
> Fixes: 6f8941a23088 ("drm/amdgpu: add disable_cu parameter")
> Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 4835d6d899e7..2ef31dbdbc3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include <linux/firmware.h>
> +#include <linux/nospec.h>
>  #include "amdgpu.h"
>  #include "amdgpu_gfx.h"
>  #include "amdgpu_rlc.h"
> @@ -132,8 +133,9 @@ void amdgpu_gfx_parse_disable_cu(unsigned int *mask, unsigned int max_se, unsign
>  		}
>  
>  		if (se < max_se && sh < max_sh && cu < 16) {

This check is already there which is equivalent to a case like -

int arr[A][B], then check if (i < A && j < B) before accessing arr[i][j].

I think smatch is missing this.

Thanks,
Lijo
> +			unsigned int index = array_index_nospec(se * max_sh + sh, max_se * max_sh);
>  			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
> -			mask[se * max_sh + sh] |= 1u << cu;
> +			mask[index] |= 1u << cu;
>  		} else {
>  			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
>  				  se, sh, cu);
