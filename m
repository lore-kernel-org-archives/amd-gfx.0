Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54228D1AD53
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0623D10E6FC;
	Wed, 16 Oct 2024 13:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ARLxtx5/";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0B910E6F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1EG06V8EzW+D8mZ57GSDKN4n/GdpvMZmC2uuuO95YYmI8sn8JUlscMvBwB4D8wFLdssbttyEasN/jyTwHfA5sjAYiKrlPXVsVcfr51V0AcZBjNGNk3tXTjUxzX2RzB6eX83nLlFbzLrqu8QmtaUd4S4bx+W8vfF8BeytXRCYeZ6ugCKPYVakzfTvLW4wx2jRj48SUeKCdxy0ex9LB2ydPECjr7P8lLFzkf+qKY4HloCt3ZfFhXarI5MBBPRZiU6A8B9g1UckEi4sIbG1+3UxPynIUOaHSIx8g83wrG2c0lILRdYycvITiTLIbHMa/KhI+rHoqkj69w0clOT7Xif5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/T05hKuMS46TtafLXQkqfMCzOQjL4OKItGJ0DVGHuE=;
 b=RPziYvWPMnJ7TnokRWgP+95I8hU4t1+CTjVoEIXjjnOtCzcLPcea1uIN0BDXYXKXPNUElLsgfYThVs5w0+ips4nUtJp58+xj91i9bmcFxiSBj2Ega0x/N4i8GBbbOX/c5ISPpRtOxv9Lj8oW89ZIl7waVsk0cWvzE9l/cvwDx3qWBwdxBSoJifZa1luAWctZrtG5WC7uKsokxfq4coQx722IilTf1xMY4fHNmk2bJMVozsw960peWD78IYj1JXzfu+rnsZN5UXvbIr084zqOVAJD8AtN7+4hlSpVPqhNdpGqJEDMYPS6oScI2KXR2l+WWm0L/ArNXWT6xD5wbGxLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/T05hKuMS46TtafLXQkqfMCzOQjL4OKItGJ0DVGHuE=;
 b=ARLxtx5/gdOWj4A/9iITWQZyoBqrIosJw5zar5U2odeA2B2h1pMVMyrLujdb1kV9WReW4TQvurDHLv4Ora6SmFcvB6erM1CxA6/wrrziWI/EOgG1I4NCcijjTsJmFF+zpb52CMIcM0QzzAPW+7iCoh84ih+lO+AeRbvqpcaHIOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:16:26 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:16:26 +0000
Message-ID: <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
Date: Wed, 16 Oct 2024 15:16:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 sathishkumar.sundararaju@amd.com, sonny.jiang@amd.com,
 Hao Zhou <hao.zhou@amd.com>
References: <20241015062316.3050046-1-lijo.lazar@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241015062316.3050046-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c02074-63b0-4988-5b4f-08dcede4bd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlFqVFY3WXg0OHdHNSs2Zlg1b0RxMENkbTY1RDdhUkhzK3lpMlA2TE0zd3E4?=
 =?utf-8?B?SVFPdDVHV05WU1RHa3BsSitEYldIMndIdndQWUh5TmpCeWsva1d4VFpXMVdC?=
 =?utf-8?B?c3FhSHVlb0tqMWxkREpnRjhZbGMyWHUydGZIK0plb2cxa0VrbFVNdGdrZUt3?=
 =?utf-8?B?c2haaDZPTmxDWmRBajlUbTczaFU4bEV0VUE0bUxEdi9PSzNRamhRWXlhUzZx?=
 =?utf-8?B?dTd1R2ZUcm1mRUVQRVBDSmQ0Mm5PM3RlRjI5Z1dNdzgydERndU9TeTZpaFdG?=
 =?utf-8?B?eXZWakJ0RXhZR0l6Z0MxdmtKWGJ1WHY1NjZUSmQ1RVhDSC9SaG9meDgrNGlG?=
 =?utf-8?B?S0Ntd0wzRTNvL0Yyb255czdmbHIyV2YzYndTU0svbWdiNTloR0hyQWVYZ09z?=
 =?utf-8?B?MFdKditWTDVPQ3AzWkYzNis3dElPR21YNnNJRm5sWDNxWm15cWd0aVkxNmFF?=
 =?utf-8?B?aXFnUXR6TUpVSmplb1JKVzRoSDRGWjJjSld5dTdVTUsrYzRiZ0Qrbk1JRGIz?=
 =?utf-8?B?SEJYNG1pR2Q1ODY2cEp6M0N0Z3IrSkVtS0RvbHVOZElJZ3pVbHZEUkVkbTVY?=
 =?utf-8?B?cm4xWmlQQkxVWm4yY1IxYTNVTkRxbFRTSDdXRVhtdUpVL2hoRzd6Skp6ampp?=
 =?utf-8?B?b3pzMnJQWG1SYUZIeEc2Z0l3UHdERER2UXB3T3FhTjZsbXVhNFVWdEtLTDhO?=
 =?utf-8?B?M2czaW1PTkM2KzRPRFZGMUxNUUtPTXdKcVFJVkVxRzFEVVRwNFhWY2YwKzF0?=
 =?utf-8?B?ZDdmR1g5ZUpJWFhUQWoyOWVXM0hEZjdYc2I5bFcyeVJqV2lkckVZN3BPUlc4?=
 =?utf-8?B?bjFtUHZKU2E2VVUyUHp0dTR5VE1PSmV6MXNWUGRJL3c4eEJKWEZNa3ozeWVz?=
 =?utf-8?B?Wnl0d3VzVldqNHpaalVhNU1MVnpaWDZSUHBDNWxLeHIrM2syc1FuRHE3MHdn?=
 =?utf-8?B?UnpCRnBYcWF0U3h2bTVZekxzWXBkTUZMd3cwZVVRSDdoWkNJNlR0U3NlMTZM?=
 =?utf-8?B?RExGaTdjaGVlditYUEk5eE5saEdXaXpDMnJxMk1PNzE4Sk56Rkl1a3hVQzdP?=
 =?utf-8?B?VExGZzBxRmxGWnJmSEJwS1kvM1Z3UWlZeUI2ejU2QkU2and2bWgzb0hFZjJk?=
 =?utf-8?B?cjhFN1RrU3pZZm8wSzRhMHBGMzU4YmN2U3lxTWtIT2V1b3FZSnhHVnRlNWNu?=
 =?utf-8?B?d3NGYU03NWVlQzFvc3lJMytEWTk3UGFKOVBZYS9qMDlDVldoS3I3akhWU0hw?=
 =?utf-8?B?L0Yza0pvOFhYb3BpVHlYSXUrc1NpRXlENFU3YVVORjArcWtuOEUrbUZSaVdU?=
 =?utf-8?B?OEV5TFBmWmJVbjBnbVVTQ1g1cDYzRjFBSVRrSHlJTnRKZm5WTGMzODQ1MmlS?=
 =?utf-8?B?aWMxUGhPZnhlM0NYYytROG9LdTg1QlJhRnFaS2U2cXpsNnpkdlVLTHJtSGk0?=
 =?utf-8?B?R0xKMkpKRmpCQkVGMFZIOE1CWnRYdDFPM21lN0ErdTBoNTMybThiajJHQlB4?=
 =?utf-8?B?bmpEcGZvbCt4VGpVRmNqWHYwN2gwVXJ2UGhKamVsd0duayswZ3JkMGpQZ1hj?=
 =?utf-8?B?cjZON2hSc1paUDlGbmFzRjJzTkNvNGNvRGtaL2VrVUw3VGpCVzVuMno2RHlw?=
 =?utf-8?B?WUdZV0JNTWpYV2UvaUd3V0tvMVl5N0FNdnNUL3RRRHhMeFN4WUtKTlNiUEpJ?=
 =?utf-8?B?aVROYjZrajE5di9nTE5mL1FrQlFiNENsc3pVcHdsY3BaVkwvbmFCNUdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFQY2FRUDFhZCsrUDBob3hnQWRGVmpDLytHc3Z1N3RWUWE1Nm9xRDNuVXNM?=
 =?utf-8?B?SVlYZjA5Q0pQNEdDZEl1aGRQcHhKN04zdG42QTZLL28zeTVqWlF2dHRmcFFl?=
 =?utf-8?B?aGd4eGlidmNRY2lEREFtNG5sOUo5bnVGU04xVThPRzRsRkFUdThEQzUweGV2?=
 =?utf-8?B?MVN6NkFJcHNQMFhwNFA3aC9kWFovWldzKzRUU1laaHBGVHhPV3VGTlhwdDc0?=
 =?utf-8?B?djBXVUowS2RQcTgrSFo3ZERrOC9hV3Mza2l0S042MGhndkxYSGtKQkd5bGNq?=
 =?utf-8?B?dEdSTktudndndDU2OUFJMTNZbUMxVmRZbUl0M3ZNVDhuS0hHcTdzQldlSllX?=
 =?utf-8?B?OGlMbjlZVjNDSFhBdnpaNWhFN0lnN3k0VzJ3MlJRZnBKZlVkSHRnaENUcnE5?=
 =?utf-8?B?SGNnYWFURGJSckVSQVhVZFZWQU5CMG5VbnNjK0hJWkF3MEtFaFM4N2dHYW4y?=
 =?utf-8?B?RTRtRnk5cGU5aDMvdXRhOXQyaGtITmNteXBRSlhJM0tsZ0t5dk9sOWNYb0xU?=
 =?utf-8?B?VFBwSU9NcW1Bbk0zaDE5b1YxUllXRFozRFA1cENIZ2R4WUJteGFPNURlY2Rw?=
 =?utf-8?B?VEtLeVVCLys3WEJmMFdGZVFrbXNRUFR3K0ZUbFN5VG0vbUVuK1ZNUk5IV25E?=
 =?utf-8?B?YU5yOE9XRnpUb2tYZklXVEF1UzFoRTk4WG1tL0l6SGx0OThSSkkyUTJ2dW4v?=
 =?utf-8?B?empFMWxQVW1jeEh4SG95cXF5byt1aEJtL0ZxcXozVlpzU3p0OE9mVnljZGxT?=
 =?utf-8?B?RzRnaUxkbHRXRWZQQUJLTVh4TEJKRERpKzZUUXIybkJOampUa05XZ1NlUkh4?=
 =?utf-8?B?M08wczRJSlgrcFByWnN1bVpRbTduM29YL2FTV2VVYmJMMjN0VjBHYnF5QVo1?=
 =?utf-8?B?NFlML2I0ZkFCRjlLU3lnMXA0a29LN3Y0RHJyMzNTa3lVSkYwVUllejhZNVE1?=
 =?utf-8?B?YTB0akN0K1FGeUF1dFAxb1dhejljanNBZS9WMG5mYWZvQXI1UXFTUGZLU1Jh?=
 =?utf-8?B?OGhHczgyL29hNjFWbEQzNlA4Y1JkQ2ZVenJ2MHBLdW9TK3RJRTR5cU1iME0x?=
 =?utf-8?B?dXVWNFU1UmVyK3JqYUZ4MmZUWHdnclp4RnBnNG8wYzRSRnZFMDBBRzdQMzN6?=
 =?utf-8?B?Q21LUzB0TWFReDFRY1hoR2V4c2hIdUdJT0Iya2pVdXhvSUEyNFFtM1paaGhr?=
 =?utf-8?B?RzQzUTkwZExLT1dLSFRVWVFxQnlsM2t3UDRXUmxXbkxEclYxa1JkUkVqcFdn?=
 =?utf-8?B?bDJaMzVHUFdBUFBHdnQ4MWFPaVhRb1Q1TmtRaVEvaXU4bW5IZEZEMngrRTNW?=
 =?utf-8?B?ODFpUGtWQW51a0dVQkRhVStlY042bTVteTR4ZWxKRGozbXdRZ01jcDRLRlBG?=
 =?utf-8?B?Q0w5Y2FIeDlSb3ZEWUw2WmU5cWlHRnBLNnBBYjY3ZGZ2SXEvNkl6bjNpS3dN?=
 =?utf-8?B?NndSMnR5VEx6Y0ROb0RpWFN0RUJtWnlvU09yYmlzSXdQd3VqbG1JMWdYYUg2?=
 =?utf-8?B?UXR6VjFjMkE5NXM3STFXMncrNkhpTFc1WVNyQTVjNDdtZGRKSmE5S1liNzJR?=
 =?utf-8?B?Y2hUL0hqaWRWN0hZVk5wRmx6ZFY5c25lN0U3dGhZOGdmN1A0dmVrVUFvT1J0?=
 =?utf-8?B?Q0R4ZjRlTEtaZXU1T2R0Mjl5Mzg1YjhEeG5XNFBTMXVkSEZsT3ZFZER3S1JG?=
 =?utf-8?B?TkpjOEoySmxReXE4T1hjSXZGdmZxQnU2UjRobXBtUGQrNWJla1EzUGdpVkxN?=
 =?utf-8?B?aWU0bG9vSGtvc0NzdXNCQytSM1NiSEF2MkZDckNmWFRxdDFHWEZndGkvRnlQ?=
 =?utf-8?B?ZVpFdDQyT3pPY283OXIxUE9LdEQrYjFodndpenNoMzRmMFJDSEpGSmtMNWpJ?=
 =?utf-8?B?V0NlRTFtYnVXdk1uRldXQkIwZ0FLQjFWWUVDZjRpVXoyZlE4MTdicmNuUUJZ?=
 =?utf-8?B?d1BQOHJZN29TbTliQXBMd05BWnFiSllyOEJYczhjNHh5bVF1WmNjN1EzR1JS?=
 =?utf-8?B?YmxuVlZZMEphQm5jVTFjMXgvWTdrQjZLMFpiU2FxUWh5YmxCd0I4M2M2Uk5r?=
 =?utf-8?B?Y3VUaWdTalhEV0Q4cjBEVzVxaW9mbGVwTFYvWml2Ylh6WFdyb0I5d1VWeUIx?=
 =?utf-8?Q?1Z1pHPUs7q2AavgpX38TP1G64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c02074-63b0-4988-5b4f-08dcede4bd17
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:16:26.3419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4XWooq6vHf5O9SXNAp/fag6ZZLQ0ly3UM54ZrSFPzwBBMDb57OsbFQ0QhFchrN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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

Am 15.10.24 um 08:23 schrieb Lijo Lazar:
> VCN shared memory is in framebuffer and there are some flags initialized
> during sw_init. Ideally, such programming should be during hw_init.

IIRC that was intentionally not done during hw_init for some reason. 
@Leo do you remember why?

Regards,
Christian.

>
> Make sure the flags are saved during reset on initialization since that
> reset will affect frame buffer region. For clarity, separate it out to
> another function.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: Hao Zhou <hao.zhou@amd.com>
>
> Fixes: 1b665567fd6d ("drm/amdgpu: Add reset on init handler for XGMI")
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 26 ++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  1 +
>   3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 3e2724590dbf..ea1e128362a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -49,6 +49,12 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.hw = false;
>   	}
>   
> +	/* VCN FW shared region is in frambuffer, there are some flags
> +	 * initialized in that region during sw_init. Make sure the region is
> +	 * backed up.
> +	 */
> +	amdgpu_vcn_save_fw_shared_region(adev);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 43f44cc201cb..3a1e83fa3d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -294,21 +294,12 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
>   	return ret;
>   }
>   
> -int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> +int amdgpu_vcn_save_fw_shared_region(struct amdgpu_device *adev)
>   {
>   	unsigned int size;
>   	void *ptr;
>   	int i, idx;
>   
> -	bool in_ras_intr = amdgpu_ras_intr_triggered();
> -
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
> -	/* err_event_athub will corrupt VCPU buffer, so we need to
> -	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> -	if (in_ras_intr)
> -		return 0;
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> @@ -327,9 +318,24 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   			drm_dev_exit(idx);
>   		}
>   	}
> +
>   	return 0;
>   }
>   
> +int amdgpu_vcn_suspend(struct amdgpu_device *adev)
> +{
> +	bool in_ras_intr = amdgpu_ras_intr_triggered();
> +
> +	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +
> +	/* err_event_athub will corrupt VCPU buffer, so we need to
> +	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> +	if (in_ras_intr)
> +		return 0;
> +
> +	return amdgpu_vcn_save_fw_shared_region(adev);
> +}
> +
>   int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   {
>   	unsigned int size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 2a1f3dbb14d3..14713a5c6a28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -518,5 +518,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>   
>   int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
>   			       enum AMDGPU_UCODE_ID ucode_id);
> +int amdgpu_vcn_save_fw_shared_region(struct amdgpu_device *adev);
>   
>   #endif

