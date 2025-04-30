Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686F8C3ABBA
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 12:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020B410E794;
	Wed, 30 Apr 2025 12:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POLWzROW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56AE510E790
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 12:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj7FE7vM16nSF8wzqToofX3ZJJLAQmz+W7La32I4AAI9Y0pUGlQuKmHf+6XdKXgElrDaMYn3mpoOesJOuq6VOT6GHlcKr6qaHCvSavaLfBdaVd10Myt4M/UbK5F1bkPpo3nTalUg1JTnQpnuvddJI3sw5oZRIpXCwB26zAD3ux+aGGdGmRA2shHACiqEW+YFS+PpwLL9dMMhioKu8efM29p8B0CTgqoUnbObKavQrBXAIEEjH8gANNQkkwscHguQCSERIXiG+Z7OZbJO1NVkKdKjRbJfdvkYh1VK9I4Lh+ykIZnl83iGf/Sh8OUoSiRssPp2VeXB7F16IxE9gTnmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeLGDjg2Sc5EnXMpw5EALOUQb/hDQnoBPj/PLJQZioI=;
 b=AIprVb2Kl+ivBifBEHitTPMS7A0cNH/UG8HqzJxoGcFON7AB3s+y9EX1eEtVkW2n2cYmnAaOprb33htL6Mag9LXGiChPh38Zt01LjpxlMPKZ1uviitxxED8AIxvi04/weHu4fxNn2x4EKpSSy11vp7fxejaisRDrWMIZCoKjSmez7scy9v0TClWMqLE87ilFHUlK5xJdSdah59ynm/8erVU5fmmiOIbkNS9RZKo8CaiYXaWpc0B++qV8bVcmkhflTTUzre8T1B/YSfjylOQVm20u4EIfPhMNtCYsblmp6tRYd9blzqQAaszg5Ro4j7bAU3n5A2ua5aZPNZVZ+PTwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeLGDjg2Sc5EnXMpw5EALOUQb/hDQnoBPj/PLJQZioI=;
 b=POLWzROWd+gsan9AY5Bn/omTtwhrhE2GXiO22qF7j9zUioMmvYLQeZkPXsafENXe5Y8WhO2utvgjIIyxAE25R7208KLdhzFTF/TOEkyaQNfEY4UIK35ONKYWBL+Td+t2pkrMF2NbumaBnzHOw8m7ASXioYtWMg7jwvw0CMjDadU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 12:51:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:51:19 +0000
Message-ID: <487f0345-3ff8-43c7-b26d-03e815c2d1f8@amd.com>
Date: Wed, 30 Apr 2025 14:51:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: update GPU addresses for SMU and PSP
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Jiang Liu <gerry@linux.alibaba.com>
References: <20250430101638.649274-1-guoqing.zhang@amd.com>
 <20250430101638.649274-3-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430101638.649274-3-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd250f1-7c5b-4412-ad73-08dd87e5b3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWkzVHFIclpHaGthYzZsTlR2eGREUWM1MGI2RTMrb2k5bjAvaUYvZGp1RVVP?=
 =?utf-8?B?NUtxem1YSUN2Ums4L3dWWWhiaHZoNksyNlUwUkJiNGpZWGdTcEZtUmJpR21q?=
 =?utf-8?B?N2JBT2g5QTlET3YvbDBCeUlGL0dOalVVaGtsSU9mTW0ybVJqTTJsYXBEVzZW?=
 =?utf-8?B?NURqczQwcERyc0lmS2RKbzZkQndURWdLZGZ4TnhLRkt6REFkZEtVRWtsallt?=
 =?utf-8?B?ckdySmIzYlQ5Z1g3M3JwWVd3NFJmTGg3WXA3cVhqRXNKNDNrcGJuWmd2UzIv?=
 =?utf-8?B?SkNXcm12Q05WNVkxRTBCZFY2cGZtczMyWkdpN2JDV21Lam94U0VXMm53c1NL?=
 =?utf-8?B?Z1AyRU1UcmE1aG1CSDRjY2hFWlV5NUJrMFdqcyt0c3ZEUW1HRVozTW0wUnM2?=
 =?utf-8?B?ZFc4THRFNzM4Z29sQzhVTmRVSERkK2Z2d3RuSU5IbVY3dDZjeHo5bDErWk5W?=
 =?utf-8?B?M1E3ejd1aVo1N2VpeFJ0RmNia00zYlhrRDQyK1pVOEgxK1ZCMHYvM1FIaXhP?=
 =?utf-8?B?Wm8zOWxjRS9sMndLTzhOYy9VMklrcjB2b2xjd3F1WkhjaHpGT2hrK3NRVjJy?=
 =?utf-8?B?UFU4eEt5d0VrV0E1OVpwYTE3aTVGS0ZNRVJsaFlUd1B1TTRDakZDbzcwSGIy?=
 =?utf-8?B?QkpPcG1SaXNyWHZlT2YwWDZKM2E5SDhJeGwxN3A2WE5LR1RYVCtIcS80OVdF?=
 =?utf-8?B?WWpxRVR6SzROd05GT0kweWh2OGd6YzgyMVhoblFNVys3WkpVN2pXWEdGVEZo?=
 =?utf-8?B?NnVGaWtXUTJmRDhucDYyNWdmM0JpUmlNNzJwN2o4eUlKamdjY2d6VXpvK1d4?=
 =?utf-8?B?K0NzTU91d0lqRHVLWEJoWk91QksvMGF6Rm92YUVNRjBnUy92TmRqakFtZTdK?=
 =?utf-8?B?R01mejdDc1Zib0dNK1l6cDdQYStYLzc0QnZ6azBMTTRVT1hGZTVDSVJCRjJR?=
 =?utf-8?B?SnN2WllDMHZGeTM3Z1NHVWRxMVVNbG42NzlYc3FOMks5UHpwS0RGak9zSHVZ?=
 =?utf-8?B?bVQvMGdHTDdNMnRSR1RSbG1tSXlWb1h6OGRyQVVpRmdUQnAvMnVyZFloKzJz?=
 =?utf-8?B?WUp2THFYVFJhRjBPSDV4Rnk1RjQ1RWl0aDRieCtKSWRDclR0OG1NZ1pCeWYz?=
 =?utf-8?B?TnY4a3ZOVWEyM3liYzB5U3hQa3lkelF4bURwR0hnTjRlbmlqRXJIcHpYYjFp?=
 =?utf-8?B?UVlmU1ZZRjBqNHFOOTRlM1BuVGoxaFhPaUtaSHp4VHBqOWdUaE5Fa2RtZm9n?=
 =?utf-8?B?bHVkNmVZdGU3N3RlaFdNMXc3OGxzZFZ3TEZyNEFKWkRmVEh1VEROT0lmWVFG?=
 =?utf-8?B?YjJXMDBZZ3BGb2pDZVVQdzAvaXh3RHh6aE1VZXh4ODIwSmNJbEpmRElUcmZ3?=
 =?utf-8?B?b25MakQ3c2Eza0dHdmVzSFRlN0Nucmd6SjFKR3QzR1dFNy9scHViTXo2dTVP?=
 =?utf-8?B?ZTduSEFqOFBXTFkwZlFHWjgza0ZJeDAxRG9qYmdGcU1TR001NURCcWM1dTdi?=
 =?utf-8?B?dDBFYmJmeXR1N0VPUEdXVEVrQ1MraTJKeGNtVUNFNjdTaXFXMDZCb3gzWStj?=
 =?utf-8?B?SFhnRk5qZGhFOThCenRDNVVKdTNLemk1c2dyL3RQUDJ2blJSQnA4MXUxbXhG?=
 =?utf-8?B?cis1K0NuUmcwVGZsbmtpUnRZVG5Pd2NmcGk0SUFqbm1uUktHWlB1Z0RqMWFU?=
 =?utf-8?B?dzRLWk1ybzdQMTNnb3pBUFNOaGI1VjV6b1Vrb0xCc1dMdU1jeElMazJONCty?=
 =?utf-8?B?MmQxMGM1cGpWM3dXYXVrYnhyeE9KcGhxZ2JSemJGWkF2NmZYMEVVY0FFSUJB?=
 =?utf-8?B?ZXhPYi9DdDRvcDhIMVNaK21VR2gyNm1COVBrMWtYNTBzeDdvUGltMTN4RUwy?=
 =?utf-8?B?S280RHhrbkJlc0xEcUg2UWNLSGlia3A3NFozZW9zUGttKzhYSDZIelZab3lZ?=
 =?utf-8?Q?gDDs/1CsjR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU0yRVprNmhpMEE3YXFyejloeHpjQ0Y5SjJtUGNkeWFCeVpNRjJMOFFxMDB5?=
 =?utf-8?B?a090YVN4ekkySHc4SFQxOFBTb1dua0tDUTk2dHJINkw2cG1TS24xdHFqeU5F?=
 =?utf-8?B?N2Q1L2FHSWlPQ1BKUGtId3c5Umk5QUg4UzdId0pGZEZIZDJFQzIvbDlzVksv?=
 =?utf-8?B?Q25WUXl4c1dVZ2NFR0VHUE9yTG5RRFkwVE5sdmlzWnoyNDdEZ2dzYndGOTY4?=
 =?utf-8?B?RkRnNG1NaG5pZlQ3aFVxbENHeHhJRkVFNlQwMWxhRzdKdzFPTFJqa0EydGFU?=
 =?utf-8?B?d2ovYlQxVEZGVWw0OEZTajZZWmxoYWY0QjBQWURpZ3MzNHN4anJCVE5MQjVh?=
 =?utf-8?B?WlVBQ0w2aGdXQ2VSaVMxODlOYkUyVEthaURISzBxU1hNS1FhZTdSYkZFRFp5?=
 =?utf-8?B?YjdPYWpqZ2l0aVlyYlU4UG50Ti8waStBbjNYdmc3YXVEb2lJQ3ZEdm1DNmw1?=
 =?utf-8?B?eFFpUHR5akdyWlNFOG4rMWZnWDBseG5TM2RySS9Ib2Q0M2dVSjh6OUVWOGF4?=
 =?utf-8?B?OEtxdjM1dUUzenpTV0hWSzQ4WWduRWU1MUhhOGxGcGxraVQ0UDE3czlBYzRV?=
 =?utf-8?B?a09nazNRSGlsQyt1dHRzZ1hJKzlrdUlEbkp3QTFURFU1SHQ5YmtSZi92VDdt?=
 =?utf-8?B?MGJpRXZHUkRvakJVaXVRdGduZ3JZME9CajZFTFp6Z0RZaUcrbC9aSitLKzhG?=
 =?utf-8?B?T0gzRTlRcEFvTnEwLy9EQzhkZ0FueEtIYU9yZ0VHRENjcHU5SGZNbkFKdkVT?=
 =?utf-8?B?eW5rQ0t6MUJsYXFIejNIV3JTT0JGSW84T0dlUmpkU0YyQ3ZwbU9ENzBObHJU?=
 =?utf-8?B?dXF5UVFXNFVybGZ1dW9Gb2tiQ09KSmdqVGFoeFNwaGc3WjQwNHJod2VQR1Rh?=
 =?utf-8?B?b0duRk52NlhrOEZ6emlwaGdtYS9oWHhkT3luc2tuMzNaZ3F4ZkZHL0tZNGhJ?=
 =?utf-8?B?Wlk3TGpxZlVjdWU0OGVXS3RMY3NobUdDK0pBTFdaR3cwSXJGdVB5dVNFaDJv?=
 =?utf-8?B?OFpDQ29LbldoT05QQ1JCNTRhVUY0OXhUdEg1ZHpFbzMxVlg2SnVrVFI3ZmdR?=
 =?utf-8?B?d1NjZm5pbDZ1K0JFYklOM0QvTFNzOGFMOWdyK2RyZEdsVE1sQUc5Yi91bXlU?=
 =?utf-8?B?Mll1aE5nNC8xV0pkclVOK1FqNmxaTTNPVjk2enQvL2pDWVJUVU5GUHNKUlZD?=
 =?utf-8?B?ZGFURERZOVF6WFdtYnRhdGZtUHdiT3Npam9ZR1JwbEw5R3FzTHYvMTRpRnlo?=
 =?utf-8?B?STNuMmg1N1RWTFJ4UGthQ3I1Ymk1a3J0c0U2QVJEUldDVmkrTlFKT01lUkRq?=
 =?utf-8?B?YjBxMVFkamQ3Y1ZvZEh2cUNOdEFlQUMwMlh6c3VmbHUySlBuYkVEeHF5ekpE?=
 =?utf-8?B?WndiU0l3T1VjUXdRYjQ1NkxZRUpETkROemZFeUphSUIwdDBucVU3TG5TQWNz?=
 =?utf-8?B?b0FuaDJJU2ZPWjRackttNUNnelUvV0RPeUg3SVZNUFlpTDJ5ek8zRFdmb0U5?=
 =?utf-8?B?bXhLdlBKbkFFYUNEUUsyZ0lnYnk0N253a1pCaFlhaUdJVkkyZGxGRWZaK3RF?=
 =?utf-8?B?eG5nSnVueXRCWjEvanNlT3pXN3Z3WjJ1RFNZV0FkZE1LUGgxaFVLMEhxWE9I?=
 =?utf-8?B?MkxUeWYxRSsza0VPa1NUV3g1blowMzdjaFgxQlVNVkczUEE1eW1mVERiRlZn?=
 =?utf-8?B?aWlvV0pvVmd0M215cW1EZDY5aEtXU1FUcGtSY3JrbmdGbVNmWGlEQ0VaaHA5?=
 =?utf-8?B?b1QrdG93eTFSRTFwZ3ROWGV2dnV3QlFUWmxrSnZwbjdhck5tb0FkV3JkY2dR?=
 =?utf-8?B?R3lZQkJaS0ZoT1B5dkdpc25vVzBIS0QyNTJTbVliSXNCVXpqc0l2OFF6THFs?=
 =?utf-8?B?WGI5TGlBbk5hY3BhQTlwUnBpbkhnWVBJSThaRkxabFRpSGhuV0ZUZWxHYVhG?=
 =?utf-8?B?RlpVMzU0REZ1Z2NmaVEzNldUSk10ZFdxUThKNDYwb3RqWHczNXYwbkdTTG1k?=
 =?utf-8?B?UlN4b2JNWWRaRzRianI3eUJBZC9aMXl0ZzE1Zk0veUZhcUZrckhHcmVOUDBl?=
 =?utf-8?B?Y0U5a1M4UFBmNnRhdXp0MFR0bEd6L2NFRE5OcUk2eUdHUnFFQi9YZVd6VkxO?=
 =?utf-8?Q?RiX0SX/EnL+9CUF1WjRCp9qSw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd250f1-7c5b-4412-ad73-08dd87e5b3ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:51:19.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzAk3PALQeCRw9abYdPGkoheHZANvRxfsDtvtsd+CDB+ynuOqBU1uFo+r4tGR4PO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

On 4/30/25 12:16, Samuel Zhang wrote:
> add amdgpu_bo_fb_aper_addr() and update the cached GPU addresses to use
> the FB aperture address for SMU and PSP.
> 
> 2 reasons for this change:
> 1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is GART
> aperture address, it is not compatible with SMU and PSP, it need to updated
> to use FB aperture address.
> 2. Since FB aperture address will change after switching to new GPU
> index after hibernation, it need to be updated after resume.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 17 +++++++++++++++++
>  7 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index a2abddf3c110..ef6eaddc2ccb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -209,6 +209,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  	uint64_t vis_limit = (uint64_t)amdgpu_vis_vram_limit << 20;
>  	uint64_t limit = (uint64_t)amdgpu_vram_limit << 20;
>  
> +	mc->vram_offset = base;
>  	mc->vram_start = base;
>  	mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>  	if (limit < mc->real_vram_size)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index bd7fc123b8f9..291d96168a57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -251,6 +251,7 @@ struct amdgpu_gmc {
>  	 */
>  	u64			vram_start;
>  	u64			vram_end;
> +	u64			vram_offset;


Please don't add any new fields here. We should already have all the necessary information in that structure.


>  	/* FB region , it's same as local vram region in single GPU, in XGMI
>  	 * configuration, this region covers all GPUs in the same hive ,
>  	 * each GPU in the hive has the same view of this FB region .
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e794d546b61..ca29270f66d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1513,6 +1513,24 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>  	return amdgpu_bo_gpu_offset_no_check(bo);
>  }
>  
> +/**
> + * amdgpu_bo_fb_aper_addr - return FB aperture GPU offset of the VRAM bo
> + * @bo:	amdgpu VRAM buffer object for which we query the offset
> + *
> + * Returns:
> + * current FB aperture GPU offset of the object.
> + */
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	uint64_t offset;
> +
> +	WARN_ON_ONCE(bo->tbo.resource->mem_type != TTM_PL_VRAM);
> +
> +	offset = (bo->tbo.resource->start << PAGE_SHIFT) + adev->gmc.vram_offset;

Rather use fb_base + XGMI hive index here.

> +	return amdgpu_gmc_sign_extend(offset);
> +}
> +
>  /**
>   * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
>   * @bo:	amdgpu object for which we query the offset
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index dcce362bfad3..c8a63e38f5d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -320,6 +320,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
>  			     bool intr);
>  int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>  u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
> +u64 amdgpu_bo_fb_aper_addr(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index e1e658a97b36..bdab40b42983 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}
> +	if (psp->tmr_bo)
> +		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
>  
>  	return ret;
>  }
> @@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
>  	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
>  
> +	if (context->mem_context.shared_bo)
> +		context->mem_context.shared_mc_addr = amdgpu_bo_fb_aper_addr(context->mem_context.shared_bo);
> +

Rather put this into the psp_prep_ta_load_cmd_buf() function and remove the shared_mc_addr member.

Please double check other similar cases as well.

Apart from that this looks rather good to me,
Christian.


>  	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
>  		lower_32_bits(context->mem_context.shared_mc_addr);
>  	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
> @@ -2336,11 +2341,26 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> +static void psp_update_gpu_addresses(struct amdgpu_device *adev)
> +{
> +	struct psp_context *psp = &adev->psp;
> +
> +	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
> +		psp->fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(psp->fw_pri_bo);
> +		psp->fence_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->fence_buf_bo);
> +		psp->cmd_buf_mc_addr = amdgpu_bo_fb_aper_addr(psp->cmd_buf_bo);
> +	}
> +	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
> +		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_fb_aper_addr(adev->firmware.rbuf);
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
>  	int ret;
>  
> +	psp_update_gpu_addresses(adev);
> +
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if ((is_psp_fw_valid(psp->kdb)) &&
>  		    (psp->funcs->bootloader_load_kdb != NULL)) {
> @@ -3976,6 +3996,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>  	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
> @@ -4085,6 +4106,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>  	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
>  
>  	mutex_lock(&adev->psp.mutex);
> +	fw_pri_mc_addr = amdgpu_bo_fb_aper_addr(fw_buf_bo);
>  	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
>  	mutex_unlock(&adev->psp.mutex);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 3d9e9fdc10b4..f3b56c219e7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
>  		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
>  	}
>  
> +	if (adev->firmware.fw_buf)
> +		adev->firmware.fw_buf_mc = amdgpu_bo_fb_aper_addr(adev->firmware.fw_buf);
> +
>  	for (i = 0; i < adev->firmware.max_ucodes; i++) {
>  		ucode = &adev->firmware.ucode[i];
>  		if (ucode->fw) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 315b0856bf02..dfdda98cf0c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1000,6 +1000,21 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
>  	return 0;
>  }
>  
> +static void smu_update_gpu_addresses(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct smu_table *pm_status_table = smu_table->tables + SMU_TABLE_PMSTATUSLOG;
> +	struct smu_table *driver_table = &(smu_table->driver_table);
> +	struct smu_table *dummy_read_1_table = &smu_table->dummy_read_1_table;
> +
> +	if (pm_status_table->bo)
> +		pm_status_table->mc_address = amdgpu_bo_fb_aper_addr(pm_status_table->bo);
> +	if (driver_table->bo)
> +		driver_table->mc_address = amdgpu_bo_fb_aper_addr(driver_table->bo);
> +	if (dummy_read_1_table->bo)
> +		dummy_read_1_table->mc_address = amdgpu_bo_fb_aper_addr(dummy_read_1_table->bo);
> +}
> +
>  /**
>   * smu_alloc_memory_pool - allocate memory pool in the system memory
>   *
> @@ -1789,6 +1804,8 @@ static int smu_start_smc_engine(struct smu_context *smu)
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
> +	smu_update_gpu_addresses(smu);
> +
>  	smu->smc_fw_state = SMU_FW_INIT;
>  
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {

