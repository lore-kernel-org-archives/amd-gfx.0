Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D1F513F7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 05:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FBB10E0F6;
	Fri,  6 Mar 2026 05:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SbkYuR68";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F3410E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 05:07:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytJ3stXmjKyxIU47wuURZdsOqgmv+fApMg0UtVbQfyAeW+CNWEgtX4wps/n5n+/ds8slWN4y4NjweX81UPfwNge+PCT9PvEglawW/fIxyG8X9gfkk/H8S7JYu2W1EVDLIrb3WT7yG+mAti2y1nWmUH6eLqnFV7SBT7ONDcpWlWGOFedo9ovHZI2vWMJqFIB6Q0eBFxEbJHXCotkk3djSf0zJaMpvJ+kyUHfdAGF9EbA1RW0N5nK7DRvfx3LQdMIVIz/zWiEwuRtr3tqaniCYg6nvR3dTa0BHLTTb2qFOhio7yKwzfpbO/NIeAeckRo4VJ/juM9D2VsANqaxjQRu54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFGaQS1Oa7LsK6k7lp+LMx6Hb8r2PJLc/F3fRlxqwY4=;
 b=y87fnD8jErWO1wbyY6mqoPPU3QZ5vCm0AvFQ+ug4U8KDMqLHJ4bMlodaFjRwSKUXkP27nMDAUWLPu3ekJdMO2zY71XkbG0YU7IFhjAOYROD1q1Z/dBs6FtmkmeQSsSBfxGLuOINLWj6bRBXCqGfcIp654Q0HjQ31OQSs1y6NdeWojqeGQrjnGe4XDd2auFFPZXgWlZTIYjdx8crVMgOyem2jSns34v7NPKpNamvL0Yuz6XjsfaChhZ/ir3EP9qnixHBz3wSAi3USKmi4Rr+HloZRpFyg73ucAaH7EcDWH8Bnt6zkB4DDC53fVfYGclbHzoBWZ43D8YhqgZ737cbRQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFGaQS1Oa7LsK6k7lp+LMx6Hb8r2PJLc/F3fRlxqwY4=;
 b=SbkYuR683QBhLTyNFMuL7e7WZHDjuS94mWpqL55sLPRm0hzDCs2dCZMDcqZ24zp7ZVio2ZnjuQ37LFfvR/5VtbkmtUkxXbCZF7A92C2uwRI+ZD905bZleLEYa4+Ju/X9eRURtJ2WYZKCONdRMECVRmEwIsXBnePqSzzmIM01tg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 05:07:32 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 05:07:32 +0000
Message-ID: <7305e3af-1960-4612-9dc5-fbf718b7fb7d@amd.com>
Date: Fri, 6 Mar 2026 10:37:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Fix more cases of NULL pointer deref at fini
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260305220540.1354776-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260305220540.1354776-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e57c27-ba8e-4ed0-7120-08de7b3e457b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: OrXc7L56aROrko9fLcKMvp+O5Vo+ulJmmoNPUkpQL63qX+g7tFKBImw8i2ei0iXUjczFa3MUYj7u0wSn3AbcdI8lQmI8ID9s/1VUjmbAM8zWCNA6ctw/wzlkXxcCudsql+x/74vbgvks0mJwlxjlIICROLoGJF0sfqc31S/Hcq0MYXc0D46ogbmDlNostsUpsN6pVo+4ueq2gAn+Z7dHc0IBwE9ZKk1MgYSW7c62T99bdojGGz0Qx0FACZXs86N5Eu5Bf1oDfvkar+ElcIWLma2+eGLDrHz2krBd+r+5BOkhgOFc/lZ0aLGpIxqfX9EeGIkv7jhOlGZWEeLwwPK7Iwq1S4OQupN6kdti0wtCTYzOkWhAP3vEQbhchyN0/JJKjgNyttXycvlrk0VOmeXF7X1SG+rbaLtN0KNfKIRDjDhQoFeP9g3o/xCDgtV7+28vQC3pU+EDpvwVLbQBz/4wMrOUpXQIezVE+TMEs8IZPzo5k2kwkeP5yyHx1off7yl3xL+5//Ccv6e/wH8rziUDT9wuG1b/BuOx5lr9Ix6YiRbtHBs8x29s+Q9gffMSVfgzZRfnKzPDkFEL1Q5S1jYdk20TYX1oX2PKWyAHKs8bBMUS3vBzDNh0KwAzssY1BfoGD4TnL+BAFztqYD6Vr54qajmgZxHk3Y44d/oDtY0SvUgQckkWe8SwPy2QvlaNdxPLOfqT5X+Kf9gkNIv15CetkbFsgk8OgG1T4fziS8j9dks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpOa0dyZFZNQXZuQlpiMVZjSDE1eWVwN3RKNEJEekt6ckNmUG5ScExZeE5a?=
 =?utf-8?B?blRiQXJrQ3dJcHA2Z0tNUVhmcEc5NE9rSnh2bVlCd1pnaFRVRmU1TUc0M2Mz?=
 =?utf-8?B?WGZmL0xNNDhPbTVZcCs0ajFUdUZCcGxBblIyUnVybDNTN294cys4RXE3UjZS?=
 =?utf-8?B?YU13bjFHTTllc1BlMXAxdklsSzk4V0NZU200a1RPLzRaTzFlUTJaT0FpNHB5?=
 =?utf-8?B?bTY1VC9zN2gzN01GZ1JLR2pwUW5NelJlK0hkSkdSbmpwcit4QmpWbGl3L3c0?=
 =?utf-8?B?eTdFQklsbzRsb2hXMjMwWmkxTVN4RjJvNVhLc3B0YmU0L2wxRmlrMUJTM2Mw?=
 =?utf-8?B?ay9UMDJXbUZhQ3lGd3RqSWZuZ3FtbEs2RlZHZHB1VVNYbkJucHpQYXVzU2g4?=
 =?utf-8?B?dlZuQXZ3cHFEVGZvYTJFSDlpRkcxcXlIZHpLOVBVSHNGWGx5Vk1EVitRZlJy?=
 =?utf-8?B?dVAwVGRlellscEpCbENhL1RnbHYzZGJHZ3RycUFFeGRLWVU0cG1XcHo0Vmxw?=
 =?utf-8?B?WXFKODU5TmdvMlRFRFIrRVkwMzB6NVBTa09kTjd4aE1BMUhGYjNmNDhqd1NG?=
 =?utf-8?B?aVk5OVdPSHE1ckQ4M3dZYXA5Q2FJbXNPMGpycjhGQTBiN0JhcFVzWVlWbE5B?=
 =?utf-8?B?NVU0ZCtsR3JFMzVGTjExbExGY25VU1pwVUZCSjhLdDVsYkNwWnZjMzFaYU04?=
 =?utf-8?B?WWw0OHkrVHpyWUNRTVBRSjJkR3BObVVSN3AwS0JYbGNaTmNwaWJsTmJmc014?=
 =?utf-8?B?b0ZCZmJCL09CbUxGOTNRdGJEUnlaT09VMzNlVEJiRkphR3Arc2hMa0k0ZFhV?=
 =?utf-8?B?aDN0RUZkQ2JCejcvQWNpVEdsRmMzQzNsT0p0SGc0RG80VHZaaDJLejBFZTRk?=
 =?utf-8?B?MzdYdDBuNko0ZmhhNHRPWlE2VUUyQlYyQStGRFJQMnNFeDlIVEpmUkZIUGNV?=
 =?utf-8?B?R0pUVmhVTmJLcVdrUDNLYldYSmdyMlRZOVRISlJ2cXJFVTV4cUxOQzZiSnNY?=
 =?utf-8?B?blc3NVkzeGdJN0FUQ1JidW9XZGdYQS96dXRLR0E1VmpWZVdoSVd0SzMzK2hk?=
 =?utf-8?B?UWNHMUlzSmwzc1RXYktDQ1loVHBRYi9HdnhsTnVERmYxWjNzUkJ4aW5naWtF?=
 =?utf-8?B?QVpZbUJFQkZwQWpGcWIyR3d1N3Q1Q0dnYWt5cUhneEMyZUgrZWdrQ092SU9y?=
 =?utf-8?B?NGlyNWpYMXJ1SllGUTR3c0VRTXBMZFVxY05HMUd5OHFhMHBBeUFBSHV5THlP?=
 =?utf-8?B?Y0ZnOCtNYXVkMi8yNlFQTy9TSUpzbFl3VS90ZjdIT3l2akNKanByT0VuSTh0?=
 =?utf-8?B?TERBbzFQcDVycDN6SS9sK2NHbUNXellQTzJyUk5icFV6aFdtbGs4OHdaRlZY?=
 =?utf-8?B?S09RT00wYVlDd3habjJwRVF4OTdxM2pyMGEyZFlETDZtY0FpaThza2Q0RkZw?=
 =?utf-8?B?SFovZ2pMZ0piYjZ3bkdOUmgycG8wMmhPLzhhYTcxUUVnL0xWcUhoTTVzdGhK?=
 =?utf-8?B?bnJqejI1bldZdXpPeG9HVDUySmZkZ1E1RWNKdDB0cE42NmE2Ukw4NHkwMGZQ?=
 =?utf-8?B?c05Hblhtb3FodEhsT2ZWUDN3MS96b0VBWTZXUUxTNnlvcjEyM2UyK1JETUhL?=
 =?utf-8?B?UWVIMk8zc25GOHNlRi9ISTdYMURhZlF0MFdNcGtKclFleE1od1pOZ3p4U1V3?=
 =?utf-8?B?UmpKMU5XUTBheStBcXlCUmorM1hRZ0x3dlgrcXRNdUI1RDhvY3hxbmdBY1hv?=
 =?utf-8?B?aXRYT29rMWQrcTdFWnhyQWxTM0NMMFdnRXllbWVISEhlK1JuaGttTFBJMDlx?=
 =?utf-8?B?VXJIOFAydlRhbXY3OVJxTldtZXFmZXdtRWtscTdtSlVXR2ZqdFZ5T1U5M0kz?=
 =?utf-8?B?OXFZL1dSa25MQUxrbUdxcFowM0tzaG5oR1Z6elpVaG9ub1M0WkxUNFliYktv?=
 =?utf-8?B?SVFrUkJ6Umh4VXFUZXUvajc5M0g2YTZJSzFabHZ1ZzVTbE1NRHlXTjN2eUl2?=
 =?utf-8?B?eEZWN3JyajZlcy8zY1JLaUhPM1dVNzhHbW5PUUJPNUR1WnlZQzhqQ2pURTdS?=
 =?utf-8?B?d3JueHF4Yi9xazdQdmxEOTdHQk1hVWtCcGljUFlXREpmTVA0bmJJYVlrbzhz?=
 =?utf-8?B?VGx2VDZIWlVmUDJ5cVZnMTRnUm9iL1ZoVnY3dVEyekhpalVuV3M0dHE2R2Ry?=
 =?utf-8?B?Uk9zN0F0akJ2eXBOSW9BdHJTczI4OFo1S3NxSmtBSUZxQlF0ZVltbmhUT0di?=
 =?utf-8?B?SVVZQzdOYU1XdFJ0R1hUbUFsSTVwRVAvKzhnUlJvVTBkb20rMit2S05GSGo3?=
 =?utf-8?B?TnRQajcrN1dYSjF4K1Q1YXNhWnNiSXFrTUd2RWVtZDQ3SE5qWlhLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e57c27-ba8e-4ed0-7120-08de7b3e457b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:07:32.1677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdXZjOYMxRuldp0PTbQpskjpVZRKUxPL8xz2XfbxgfsSepHeUz3XEuqYqNW6aRPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
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



On 06-Mar-26 3:35 AM, Mario Limonciello wrote:
> I found more case that a NULL version causes problems.
> Add NULL checks as applicable.
> 
> Fixes: 39fc2bc4da00 ("drm/amdgpu: Protect GPU register accesses in powergated state in some paths")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bc6f714e8763a..74cbe58484fe2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3463,6 +3463,9 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
> +	if (!ip_block->version)
> +		return;
> +

ip block versions are set during discovery phase itself. This is a very 
early init failure and ideally the fix should be not to call any fini 
for such an early failure.

Thanks,
Lijo

>   	if (!ip_block->version->funcs->hw_fini) {
>   		dev_err(adev->dev, "hw_fini of IP block <%s> not defined\n",
>   			ip_block->version->funcs->name);
> @@ -3496,6 +3499,8 @@ static void amdgpu_device_smu_fini_early(struct amdgpu_device *adev)
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		if (!adev->ip_blocks[i].status.hw)
>   			continue;
> +		if (!adev->ip_blocks[i].version)
> +			continue;
>   		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
>   			amdgpu_ip_block_hw_fini(&adev->ip_blocks[i]);
>   			break;

