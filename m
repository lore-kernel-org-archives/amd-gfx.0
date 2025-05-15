Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F48C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 14:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029E110E8CE;
	Thu, 15 May 2025 14:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F2bbab0u";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D472610E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 14:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6Oh8VR+l/BQlPslpXd6mm3OlILbhqC3tbq7p6QMO3tzy7T0pV2vl9BwPw1MYLqGcKcUFp9QeM+VJzuZD6D9KXaErYz0ZWLuWC4pIvKcgg8MeYiSinfz44Q+bigCYNYTC2bsC5KbFACo05kYfZBT0Ar16GjX6BTCIwfd6dGWBBZx0gQePTsaUELO05XNqPhUSnZsVNH2A+n2J2VZxQLF/n9N8HdaOQH0lvp6Zhc7GCrIBxZCmrhVipHFDHQ5W7ouehR81FIhPO9Ke1tWLgBAa61H9y1GCuHwRoOymuxZ3FHxodWUJzTjnxg2obEnE2qRx2ITJu+Vs7QcfYt6LVt6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33ae6MFvaK8swCQPJk02buYZD9o/gxlnxqORXVgygBA=;
 b=QFL1mE38mWaCFW8iPVBgq1XPNrwt9JYnwNhQTbUikyVFny/DjVcfuyfIbS8eiJJmn1JhYrqLkZJHFj09qC1lxrqz1fjxh1aBcX63j3Nknyi/LYfyikB6bPgEaJbmSyMS9brsMgraZ0mwzkyYlvuol0AZf4pvhgX0GeBWXetbrfKJL5deLnCyXSAGAg3Ueb7GGZkH5GFpdn9hWaCIK3XTHKtny+1olcdkZ1X7cOS8XtrNXawHa7KEonNvdsTPA8nZvKObzsLGnAXbDYotYah9ACsS8u2VVokiWDHt7WREDSSxzOSHvxkOMMFQoDZlc62TlBnZFOj7To0FqrDM42kOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33ae6MFvaK8swCQPJk02buYZD9o/gxlnxqORXVgygBA=;
 b=F2bbab0uhj5r72pLdlKdN4z+qaw8Vtf/Z3nmsLZLCk5ZKwwqArUjP0CW9LwUHGj2d5urhauZpvTCK5z+r0Zc4z8Vz+QVYzNNbDbMZyubf4wdF9vFEVXwV50eXHoVs6xWHRFXWzKW+NOuCCe3SdExbXhAHnX10BTnQ++0rKuPRr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Thu, 15 May 2025 14:40:40 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:40:40 +0000
Message-ID: <10185695-34f8-4ed3-81d4-69ab109263f1@amd.com>
Date: Thu, 15 May 2025 09:40:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: amdgpu_vm_fini hold vm lock to access
 vm->va
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-3-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250514171004.4259-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::22) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7887a0-6cab-4ede-ef5a-08dd93be76f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajRoYTkzeHpPeDJuMDVvR2FFMGk5WjQ1VGJUWnluaERZcnhnMGtGS2wwQkRV?=
 =?utf-8?B?SG8zZlB6Nnh2RVVPR21IcTV5OEpFcXpDM1ZrYkVPckJEV3YzSjVVS3VZWU4y?=
 =?utf-8?B?OU1OSCtYTituNXlyVVcwdXl5Z3g3dndIdFpxa2poeEUyb2x0eUtqRjVWaXd5?=
 =?utf-8?B?NXJkUXM2UllzRUxFRkJBS1REeXVQVnd4TEc0OEZtczM3dStzTmliUW1lNk9I?=
 =?utf-8?B?M0o2V2pkRUZPYjVWaFZqekJRamNuL3RKMHVRTUk4TUpyMGZ0c2NQYzlvZWtJ?=
 =?utf-8?B?a1RkSy9WN0REK3VEQXpURE54cFJpZzRJYW1rU2VhZVNiTDY5elNsaWtwODlm?=
 =?utf-8?B?Yi9GK29xK2xUMnI3V3hNc3pRZURweTQ2SUlEN0F3QUN2eFJXNlJBNjZyeDJB?=
 =?utf-8?B?VUpiOGlYaXMyM3ZpT3dOZFFRSXg5bXJMTzdDSGNWeSsyeENkWTJ4WHBjSTNk?=
 =?utf-8?B?QzFOZFBmTEFlWG1oeW1rTW9qbkFVS0lNQ1B0ZHVOK3hSL0NxMlJQS3BDU1Rn?=
 =?utf-8?B?RnpLTHRxcllyaUJlQ3J3djJ3dzFRUG9hKzFCQzRGVzlXSVFncmFmQWMvSTJz?=
 =?utf-8?B?dStBdHFRTFN3VEJaaDZDODhMeVpPQ2VXZ2RSTUwxQjhiRXFxbllyWnFOcEdj?=
 =?utf-8?B?SFg1ZkVyUWt4NkZURUgxRzlhSENYMDM5aFk3L2FETmx6Mmt0bmVqUEF1cEdM?=
 =?utf-8?B?YklIMEdaaGUzWjJucFF6OEJjRk8xK1JaQU1VbUhWLzJvZFFob2FqR3hpbU01?=
 =?utf-8?B?VWdaTGlKRjBGQ0szUGpjMTRyMGs1bkNnWGRlWkxFb2VaSzRRT2xYcnRmUTg0?=
 =?utf-8?B?SVV3ZHFPSEl6OXZDZDRzeWVKWExzN0JhN0xrbUp1Si9hRDlxSmJqSmRMY0N6?=
 =?utf-8?B?ekRmc1hZb3ZOMEVWUlNTUi9oc1BiOTFFSEFTRGZxTWpudzVjdE11WmduYjhN?=
 =?utf-8?B?dURNR0c3cGxyVk9YdWlhQ1VYeVBlM2d1RVdJZjFLbFB5T25vWW5sR1hhbXF4?=
 =?utf-8?B?b09pM01qWkRoSnNyVXFvL0QwaHVxTW1IMnY4UEdDaDNiOHBHYVV3V2VQT1pq?=
 =?utf-8?B?eDdJQjRoem1zK1pGMVRnV0xJeW9NZGZkbkxVTy95WmZoYUhVMFQ5cTJGZkNp?=
 =?utf-8?B?THFOMmNGbENKRXdEcWdZR1Q3Ni95QitnNDVJcDdHN1pXTHZXaW9XZUgreTBz?=
 =?utf-8?B?ampHVjU5N1NoS00zTWFKeXVUdjlGRHJKQys2c1kydWxkb2Nac1lKdVozZWE2?=
 =?utf-8?B?ZU9pN09WejE0cWVmRldnY2E1TnB1bFNtbjUvbG9CRGVhSGhERmRpQ3lPRWlo?=
 =?utf-8?B?RXhFMnBaZytoc0NqZCsvVlNzVC9KU2ZYZEdRbUJFS0N6RytYa1dBK1FjWkgx?=
 =?utf-8?B?VzUzQlJQSjVlUDF2bmp6b0YxUFQ5UnhlaG14TmVTeTcweTNrU3J2MWNQMGZq?=
 =?utf-8?B?SkNCK2h5V3ErQnFNeEQ2Vzh6bmRmSXppRUNxNVI2VXh2dkI3T1RIYTRZNWdT?=
 =?utf-8?B?NkhjV0FGQmdHR29BaHFNRUo4WkpFWTBaYjNEN0tzRjlqdzlvaEYyT1NsUzhO?=
 =?utf-8?B?L3ZCVDV5MU9EZ1A5Z1ZwY1kxQnlQTHBtZVJ1bkZHcFY3WVlkYnFDWHd1Qm9h?=
 =?utf-8?B?dXdmdXlKRGhHZDl6U3ZjZm9sSGM1QjUrdWZodkk5ekNRZnFvNDdwY2FNdkds?=
 =?utf-8?B?UUtDN2ZNY0VPQ2tqSHo4TGwrQW9mb0xyQUZiamtNcUpvblptOTRjZzRUK0tQ?=
 =?utf-8?B?aHhOblRmeTFUMmxKZ0JneVlDYWpBZURrYUIzSStQUFhRb052K2xrL0lBOS9T?=
 =?utf-8?B?ajV1a3VjbytnWCtrNS9wU25xdjc5SW94aG9FUkF6ckVCeHdpWDQyWFh6ZE4z?=
 =?utf-8?B?a01mRTJVK01MQ2Z0YzlsdkFEY0xUdFdXdlZWRGhUeDlDQ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RCbzlmZCtRcmpURWlYSU1RTUR1OUR1TjM5RFVWUzNJMjA2Z091MW9Jc1F6?=
 =?utf-8?B?anlXWEFRSXVzeW4rWWdlaTJBMUpKVE8vdFliODUza1FReXM2NVdJcU84SXBD?=
 =?utf-8?B?akx5MXhQdVNJbVNPaWozclo4T3BrcjAydVljK0VyYjF1QWZsa0ZiRFZWZjFy?=
 =?utf-8?B?ZTdsSEMxZWs5Q2xXMUszM1FqdHlwd3NHVXhkSWtEL2QvcmxaSVNtY2t0Ulhw?=
 =?utf-8?B?YkNrQVFkeFJNcWEwVWZyZjBpaWp0QzhLb0VCcnVtRm9INzBqcGFoYmJPNHJl?=
 =?utf-8?B?RWhsMzJ3dUYvNmVTQkl0dHdBN1l6ZDh0Rk95SXIvbS9zZHd4TGp1T2JDNlJZ?=
 =?utf-8?B?eEdPdjFOUzJJUnIvVGdVb2oycHlzc20veWh1aGpJd1JsRjFFM2ZQNU4reGlX?=
 =?utf-8?B?aWQ2M0hDSzVSSHBaaVpuYWNZMFJBejZXYjVuT0NsS0g4Sng2d2FUTGMvcDNN?=
 =?utf-8?B?aG9VRXMrcGFCVTd3NVY5ZThqcS9ZZ3lQcmNLRXFBUDhjbyttMUx5aTFtanFx?=
 =?utf-8?B?Zy8vUC9KeitrVW9aMzJ2UXdQYU5KWThnYmdwYnA0UjczQW9OMHBzdHpVTlVO?=
 =?utf-8?B?WElRclJ1MzFRUVFxK2VVNTI2N2VNVkV5dTBQNUZONm9yU0hWWE1rYTZORlZ3?=
 =?utf-8?B?S29tVXpYQ3FxTVpPQzhzRHdUQlBrUlhkTVBZVFhSVjdLUkN0ZmZ5RTBzemZG?=
 =?utf-8?B?S2JySmxocGRTWWpvUGE1aDRrZERXdmhJeDlJYVVTODVuay9la3RjNXZQekhz?=
 =?utf-8?B?N1RUM25rcWVTeGdBVnQ1M2dVbWtid2loOE1CNkR4UVlnb3pKOTQ5cDJBYWpK?=
 =?utf-8?B?dzdYZjgwSDBFd1Y4Zi9BZS9nc212dTBlN09EOVNYV1dYcGcrUElybW5nKzVF?=
 =?utf-8?B?TTQ4YmlMQ05odjBJZUsxa1ZOQXNYNWlTaVdscEVQRWhFY1AvUHRjbHNHYm4w?=
 =?utf-8?B?YUU3UTNvS3ZNUFdoQ1JGT0FsbC9ia0F5Qk1LUG9uYkVvbk5ydHZxa0k1bytG?=
 =?utf-8?B?VGVQUFROaytBVW1RY25rNjFNb0dTV0FmTk1kSnBqMXpPNUdkOGR0OEc0ZGRF?=
 =?utf-8?B?bTI0TUc1akFTK1VCRFZxeU9mS0w4UGo3bzdiVHU3Y3RENG5DM1RqKzdXUEV2?=
 =?utf-8?B?aFo4L2VFUEJDcU0xMVpLUk1mdDV2bFN4YWs1Z000Z0l6QzdaSS9WcGw3dEpT?=
 =?utf-8?B?bWN6cUxUaVpOemxqUTZRQm52UnYzSzJyQ1hteGtWeno4dkowSkRVck9mTi9j?=
 =?utf-8?B?dWNqMjBKV01jZXc4VXp6Z05kK0dsSUU2OFZURWFmVll5ZVJoZDhJYS85YXIx?=
 =?utf-8?B?eUFMUkRFSmFHWGxvRWZnd1pNMnhra2dJd0xvV29FRXZjS2lFUVVWc2tVUkUw?=
 =?utf-8?B?UmxXbjJYTUc4STZCRlVHSGNKaXBQZ2hVcEg3aWN1cVpPTUtKVytSOU82WXJl?=
 =?utf-8?B?NDA1N1Zob01EaUNCVDF5Q1NGbFpyM1BiMWlWTEJTR2tmeEdkRGh4OVJud3lS?=
 =?utf-8?B?ajFpSUlYYkluUHNsQnAyM1BsM3V5SStIZlNKTi83ckpwSTM1OWFnc0ZsZ2sz?=
 =?utf-8?B?bHRSVk51MkFhdEhqeTNQNnd1eE16ZGlKWGVCSUl0NmNkRVkvN1RlYWtqMndQ?=
 =?utf-8?B?OXNjeHRibHRjUkFyMCs5Y1krYWtsVHFrZldpbGgwU1QrR2N4SitRSDRWc25h?=
 =?utf-8?B?SUg1cEFpZ2hiUmxyOHpoV3NuM0hJTXRtZml4M0g5US9Ma0txNGNtWGZzSFZC?=
 =?utf-8?B?cWVkZlN4UHBkd0dpZi83QnZiZTJ6TFZqVTVydkdDSkszRGRmaVFZVExES3J5?=
 =?utf-8?B?dUlwRGM2bmpLcWh2eDZWZkFEMzdGcERyRkkzVVJJSWlWRGFLRDdiamZwTmMz?=
 =?utf-8?B?cVBBWTcweVZjZ0NWU09KdE8rNkN4QmRxYnEyWVU0VzVtd09nc2E4QWVZYzlt?=
 =?utf-8?B?dGVaVlFubU83am1MM0NPekI2b2tvRmdndXN1VGtJWUtHTEU4dm5vbjVaaDdr?=
 =?utf-8?B?dU1WSXJXNExQZW8rZTFXUHFBQmg0NWllYmRhRkNwcnJIR2hwUjNUenpzRG9L?=
 =?utf-8?B?L2I5WkJvN09KWHVyVEVXSXVuYS9qSlZ5a2kwRVZBZVZVUHh6VXNRYWtqN3BJ?=
 =?utf-8?Q?KP+w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7887a0-6cab-4ede-ef5a-08dd93be76f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:40:40.7026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toROMV4pI2PGtQcujDPXi70ArzqdSOsjVdVwgdZARjGezJTLPuaodJ1NL/17ZP/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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


On 5/14/2025 12:10 PM, Philip Yang wrote:
> Move vm root bo unreserve after vm->va mapping free because we should
> hold vm lock to access vm->va.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..fb5baa6ec32d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2740,10 +2740,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	}
>   
>   	amdgpu_vm_pt_free_root(adev, vm);
> -	amdgpu_bo_unreserve(root);
> -	amdgpu_bo_unref(&root);
> -	WARN_ON(vm->root.bo);
> -
>   	amdgpu_vm_fini_entities(vm);
>   
>   	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
> @@ -2758,6 +2754,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   		kfree(mapping);
>   	}
>   
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +	WARN_ON(vm->root.bo);
> +

if the places of unresrved/unref vm root here do matter putting them at 
end of this function may look more reasonable.

Regards

Xiaogang


>   	dma_fence_put(vm->last_update);
>   
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
