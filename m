Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BBC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A1810EC00;
	Fri, 14 Feb 2025 08:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FdbcCwal";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8590E10EC00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM4Q3Gz2XQsTuvlA1alWNF9ofZKA6XcNqHBR6Zn7BuBhFpj/jtpf90D2yc9pI2DylwxmvKbqwCa8vklGesvLzDniuLcEdII6eECb0OI4DWwfYAP5SPImIW1bECHhIia5m4G69cazR2Ku5/29DLI+9Gz5R9z2shA5WEZ9Wz6Ushs9Cwyl6/1fU+0K3p+tMKDhKK8Sa5lCY2a9nHWB4Ki6oaZRRCM2G4bIPe2eqJCtZ9b+tWH63o2j3HlpHWfegq92+l8Utef1NoUR4vn76JCTj7ehkuqBr5lXPiODtutyu0JcfxrB3MGUQUPA3jgo/N15GQ82BjjAlRKXPBmKoCYD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5kQcJxkOTcYMWhxj8rXosNpL2xeX8muZiJp2P25ZMM=;
 b=JzoR/l4Su6r1DEyxAGmNpW46gMGhb86HfPXEAOb0gUANqKMBjXgd2GAs2uaXH+h+0GJqA0DpmSr1qxKrygKTNSv1QdUOsvNoEbvZLWjmXa/KwFqiKmCFdehhCM6V9HnF2AJFId38fU3H+iCCnQpCRIJkZbU9OlpWzg9+OfGiB0I9TpqsIWKcMptHdC1HrwV8ZpTO2ZQhgrQFMnI3EWz2saL0MUTD2PXxyRxR/rrOmCwB9ji+9T/SbLT8nIdKdVrWZSiYexx7FugV18ZFUmn/z/NKE+GqGYzomAPT3h8ya782pTKyeTsGQoMvKVqR1dgIluBYJtDUT0sVW5VjGV8coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5kQcJxkOTcYMWhxj8rXosNpL2xeX8muZiJp2P25ZMM=;
 b=FdbcCwal680ytKutUwoJSvsrSQs+7QIPMUSZkiE9zK/Whb03NKOjZe0M7zPPxuLekx5gbzS4bk5VHCkBc38IvqYXpGaps6xOFjUCwTpI9YMio7NmiSZOmee75wRlJeTj1vEnPrws94l+V85I0LQbiw0MZmAYUnAb2TK34l0mjt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 08:47:28 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%5]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 08:47:28 +0000
Message-ID: <ba923170-8d16-412e-81d5-a0d8384a751e@amd.com>
Date: Fri, 14 Feb 2025 09:47:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix crashes in enforce_isolation sysfs
 handling on non-supported systems
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250213175012.588986-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250213175012.588986-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 9221c859-e33d-49af-16b0-08dd4cd43627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0JzLzZkWnZyckhJY3YySVl6TXF1dFcwbFBCTDNtdVRHZTFpV3BNSlNnWDV5?=
 =?utf-8?B?UjE4N2hrU0RNWGJXUXhpVkpBTk91S3UrWFZFUS80Rmh6aHh4aTY3S2ZpU3pG?=
 =?utf-8?B?T21WVGt6QUJ4c1NsdHJxQmR4bnR2QWdKTi9MS0Vrcmk1RTJsRXphYklhWUtz?=
 =?utf-8?B?QnkwWHJmaitPaER6cW9TdStxbVUvL2RFYWZDWUVCMnRwdWNIS3VpUW9CNG5x?=
 =?utf-8?B?ZkhkMlhpRTRST2ZhNmZOOEFWWFhoMTI0RVo1UzBMZjJOME4rSDNhY2Z6M2o2?=
 =?utf-8?B?RnBPMlhWTHpOT2N3cWhVSEpuSzJidm5jWWZhQ2VELzlEZERSQ1ZVcFZONU5J?=
 =?utf-8?B?UmdwblcyR1c3ZDBtaVFIQW1rcyswUGhIZXloNDI4R1o4SnpWamo5QkhTZGFJ?=
 =?utf-8?B?THNkU3ZHMW1jWVUrd2daNkliUDZPT1QxcTl6N2hmTzNzYUZIU3JteklpYXVq?=
 =?utf-8?B?K2lEZE13Q244OUVDMTlnVmZkVE1QMHR1bzU4MENoeDRNTWs2SDZuM1hMRmhl?=
 =?utf-8?B?VGhaUGxyRyt3cVBuZkM0dzZ2bkYzVXJ4eUprTzhoc1cxVWE1Q3FxZnAvOTc1?=
 =?utf-8?B?QzhSdG1QdnJMSGFlSWFPSDJtR2x4TC9HdkRzaHRiZStKWnkvQld4K0ZlWTVI?=
 =?utf-8?B?dkhPZFJlTGU1YnBlRFdRbXZ3Y0JxdDViY1RQM0xMbTZ1cURtc0RIenRvdXBH?=
 =?utf-8?B?Witzd2xsYzM3a3ZaU2UxMzdHUURCNnM0aVZ5bTFEWUNHN29YVCs2NUxDWFNC?=
 =?utf-8?B?VUdJNVhJR3h0Q0RmQkhpcDVBemtFREJYMENlL3oyVkowS09KZk52Z1MxZFZY?=
 =?utf-8?B?MUl2YnFFYjUxeWhSMWlQaUxMQXBOV0l6cWhVTVM4ODI3bTZRRFUrV1Z6VGpB?=
 =?utf-8?B?TXAvbEF4VkRTR0lrWVJBNmY4aW14cHc0d3VNcGU4RFpNOGNsRXp1NnVUeE9B?=
 =?utf-8?B?ampPUElib2pPeU83djFibnRsZWV5cFRFRDc3dHVzUEhzOFZUL0h0eFFmTnQ1?=
 =?utf-8?B?U2RmRzN5S2NiVjlLMmxqNWpoZVUrblVJUXczQWpGVzBrM002YzdHTEtuckFC?=
 =?utf-8?B?ZEd5dnFKcHlSeS9oUXhCcVRvcW1SaTVDc2UvMXNtNnFzSEh0bXdtWjhldFM4?=
 =?utf-8?B?RG5ybDJqYTlLTHhrajdSd1ExQnZEeVhCbmJmQVJIclhDNXAwT3FZa3Ivb0Vx?=
 =?utf-8?B?azFpRFk1MitEakFiczFVb0hTN1IyUnh4SmR4UXNvNURla3paekdLQ0gvNTdZ?=
 =?utf-8?B?SU1FL3QvOWpNdEtBb2ZCdVphZ1NLS2JHSnVNMldwTzNtQ21vKzdyN09yR25y?=
 =?utf-8?B?R1FDR0dwTmg5eXFHVVV4QjJFT3FRVWhzaDNvcjVMUVlVYjFPTkx6VEVOTUpj?=
 =?utf-8?B?SStFQWVMWnV2Vml1Ym5iS2lsZG9pZ3lWMTk2d21EMnQzUkFWMVNYNTd2UVZZ?=
 =?utf-8?B?UWJZV3RBaENUMHRWK2FMencyK1JIRFJYZHpyc1l2QW11QWVXc0lreC91aUl4?=
 =?utf-8?B?MjFmZEZnNjBqMzBNYmY4aWtEM1pnekdtSTNMN0RkRUtOM2ZYd1NDMnhkaXdH?=
 =?utf-8?B?NEYyUElkQ0xxNVVoNFNrTHZlTXpHOVoxcWtsWFVTVmlsZ3paTWlKaDBaRkEx?=
 =?utf-8?B?ZHpXTEhoT1JCd0htZWJJU25wcmRVM2tqNkxYcGluTklocmFVa3kwcDZFd2Nn?=
 =?utf-8?B?V3J3RWI3bFpDNXVyY3B5NWZBbjBTdDdOcFZ1aXExbUpERnZ3NWNqai8vM3dj?=
 =?utf-8?B?dExqZC9QY2FISHNSWGF5cDA1OEpQOG1WWlBvcmFsMFNvR0RZUFFUMjZtb2lw?=
 =?utf-8?B?dmozTzcvRldCMVpJK1lCV3RUVzZ5ci80clhmR2RpREJxc3BDVXFabkhQNmN5?=
 =?utf-8?Q?L5AX87xeRZJUN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVVQZ0V5eXZZSWdsS3hXc2kwVkN1WHQ1WEtHWmUxUVNBNTc1NmFRZldjOGdw?=
 =?utf-8?B?YTNhWlhXNFY4Z1JCNkhnQllMMTY1aHRlNyt4Y2EvSTFON1dXcFB0K1lHZVBy?=
 =?utf-8?B?WCtRcFVqMURhcEd6cnJmNE1RSlNsbWowcVczVXJwWUxCZE5IVXB5UnBhb1VQ?=
 =?utf-8?B?bjNoMkVSVTBuRmlDalFJTHp0bDJUWDV5TVpmRXorNVNpRlZVUjZlUENnZ2hx?=
 =?utf-8?B?TlBsNkFocGgzVzZXajQ2RUUxR0Y5N1VGZy9USjQ3Z3dKRUxOMWFHL3J5aUM4?=
 =?utf-8?B?YnR6NGpQd1F6QWpIM3VjdGI3NDdZdEdBc1hGME00bnFYU2xWTHdtRVBYMDAw?=
 =?utf-8?B?bllXR3c2OUY2Qkg3MGJCRnRRaUIxNmxrWmtNY3Vqd2lHZEw3VDk2NTBMczM0?=
 =?utf-8?B?SS96b2g2MHhPT1U2VXZNTWxudUdWNW1LazFCSGpSQmlkUy9JbUZHZFphNm5z?=
 =?utf-8?B?eGxTTXRZaEs3Um1Ka2R2MUkyVjl1R3BrMkk1czFMN3ZtTm9Sc3NkSzFTclFy?=
 =?utf-8?B?NjBsZkNuZGw0TUM0dzRpMmNWV2RCTlVLZVd6R1lGdk94NGdoVVo2RVFUcnh5?=
 =?utf-8?B?OVcxajNBNWZ5cHNNaDByVEFGcnFlTGx6eWxQQTBWY1I4SHo3c0xSTWtkVGtu?=
 =?utf-8?B?RnR0cWQ0WEIzdDFDenNQK2dsZTY5SW5HYWo4aWVNa3VOMFppZmtHNDZyWUdX?=
 =?utf-8?B?VlJabm1IZWl4dTk4dmtvWGg0cjVYdXN1YitHbmdnQ05ZV21QYXVmS25zUXhJ?=
 =?utf-8?B?dDlsRkYwalNPUFY2VE1WVk4yVlhoVWpnOENkOUNKaExhd1JOUmdSSHU3T0tE?=
 =?utf-8?B?SGxocldLc2dWS0lDZGFOTDRLcFV2MFREUWk1eHZ0ajFwWE5sd3B0YXhsZlFz?=
 =?utf-8?B?cXFxandaL3NOTm9zcGwyRm1yUnQ0UUtrUkFMSDltbWZoUkNCYUtwd0prUE1q?=
 =?utf-8?B?dXNEZ1dkbUxCRU1TdU1kOVlMcEt2VDV3UEw5SXhjd2x6d1l2UlphRlFtTnJ4?=
 =?utf-8?B?WlZiaDdHWTMzZ2Rwd1VMcFZDd3VVUnYyUGdsNEJXbnUra1hFQk5JMUFsQjlR?=
 =?utf-8?B?ZVArUnZkbXUrc0prWlBWYlE2bS9GNEVyR1RPaFZrWjZHVld3V01ENnBoZndP?=
 =?utf-8?B?L1hnbzdoTmVFYVhxR2ZGVldCTFpFZDhTTWIvMDgwSWV5Y1NLTHFuaGxXc0RU?=
 =?utf-8?B?WmxVWHhwanArQ1BMdExWN1QxbUE0b1RLQ1ZrMWxJSUNFUy84VWxjK3plTzdI?=
 =?utf-8?B?SGVxQk9zVFREQktndk9XbzFGMUtrOWhQYVFWYldTR21NMEUzdHBsNVdybm5P?=
 =?utf-8?B?bGNjdDUxOVZ6NzhaNmdCNmNrWkdmNlJJVWl3VW9tc2tBTWh3NW1KbjBmMXNz?=
 =?utf-8?B?WHlhODh4TkxINEZsUU5TcFdxZnZjZk5WNXIxWkdJaCtQanl2dWVBQlBoYi8v?=
 =?utf-8?B?SVBBNzBJN3ZjWTlNWlVEbnJwMG8wM3ZWU2MyMkFYK29raER5Ui8ycHMraXFI?=
 =?utf-8?B?TkNpUTJzd0MzTlIwL1lqTFFXZlVYTEFjRHd1NWdwU3BaY3BSNXR3VUVSckVH?=
 =?utf-8?B?cXZtNnBQK210SE9ZeFVMbnJFVGxBeXYyeTBRY3BpTTNOeEYwU1lMYkVYNUVk?=
 =?utf-8?B?M3ZWYlJyNHVpcENvSXQ1Q3RTNWJyOEozaWNtTWRrNWZUUDBiejNRQS9iVW9j?=
 =?utf-8?B?TW00SGVQTGxsS2FwM0FqVVF0bExoNWROMHlnLzl1cHNnUWZXdUFlcGNaMmVK?=
 =?utf-8?B?amFpRHVMUEprVXRXa0F3V0tsYk1Gck5Vc2dWd3NNT3BEbmFtR1JjUVVxbldY?=
 =?utf-8?B?S3FtVVcxaE41VWFFanNGaEpGODRySW02RkZKTElqY3dEZE4yZ1FJSWRmbllQ?=
 =?utf-8?B?TkRRekovbVh1VzdhaVQ0d2tNUTVwWWdEN0J5a0ZzQWQvUWI2dXBhTi9UVzdu?=
 =?utf-8?B?VG9IcDRuWU5mQmRnSVg0TzRIeU42SU0vZVEwNUxFdFNxZkR4MnVlVDNhdHdI?=
 =?utf-8?B?aDRPRit3b0xReUxIZXBKaGltNEpuZlVqeGM5UVZ6bURXZW5yZ1gxaW1HcWpj?=
 =?utf-8?B?WUtScDJCc0hyR21TdEZIR09wbThWb1RCK1R1WEI3RHBybWNYZGJNb2NhdEw0?=
 =?utf-8?Q?O5tYYesLRVQgQ7+5EBSKg4Zxt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9221c859-e33d-49af-16b0-08dd4cd43627
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:47:28.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMJMTO8AdMsrWIrcdo6MG64vKfZSYHphOolUdJ7Z5UggtuwiCzTXKpyWTp9kn3ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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

Am 13.02.25 um 18:50 schrieb Srinivasan Shanmugam:
> By adding these NULL pointer checks and improving error handling, we can
> prevent crashes when the enforce_isolation sysfs file is accessed on
> non-supported systems.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 27f5318c3a26..bf0bf6382b65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1777,20 +1777,27 @@ static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return -EINVAL;
> +

NAK to that, enforce isolation should be available even without the cleaner shader.

Christian.

>  	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
>  	if (r)
>  		return r;
> -	if (adev->gfx.enable_cleaner_shader)
> -		r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
>  
> -	return r;
> +	r = device_create_file(adev->dev, &dev_attr_run_cleaner_shader);
> +	if (r)
> +		return r;
> +
> +	return 0;
>  }
>  
>  static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>  {
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return;
> +
>  	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
> -	if (adev->gfx.enable_cleaner_shader)
> -		device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
> +	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>  }
>  
>  static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)

