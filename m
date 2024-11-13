Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3513ED41C17
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D272910E69F;
	Wed, 13 Nov 2024 08:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCqmSdKm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007B410E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AER/MPHldvQmJzecuYaIwEweyQHDXtKk2kgdtzjFeE2uq+XQjjvqbxmmYchnetXn0zkWFroBxM1kcsfDrvEDO5tpJDCofe9aUpHt/sdkaw+t/PbvVktbc/Eucu27+rmw0ElZQx7xoRW4W0UZANqb8g/7OOPon1Hi5ZTXbcINwvkjeAZFAI+/3c3B4CMC1/LKDpWdeVcFsfJ20o4OhX9qG1PERdvyYNjB35z9JlrR6ON1SZCfcU7TqOP2xGpPtPd0woAOXEWJPjzYDlFfV41mHJqeLf/jo2xSVc5o7KtGnhzZq8hkx6BKsiegILFJQEnxoFqpD4E9J/BL0gpHlfgzjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxUG/xSI6Af+RS6Mbr7VWwFKCekYP3NRHO32xgVHQsc=;
 b=Gwdc3eWaLyN67lUDuPYv8snlNIglKwnCmzr4S0ny8wSsPRHXow6ftA7Sx7xqf1MGIv+GATy6MC9MQPLt/LQTZW0uenWzZwVW0ot4SLxF8+1ZX25GnJgAlh2EVfytxIGdGqwwGFmC3t5Rjhp7zMr8dVdqAr40w39gaUZhKIwVNXjouY6+AT6jwWNbXh18cH5tv979Joj+TzHfao+zAyL2RJZTXYBNTPwgPBKNQt2H3UvmR1SN7GtvGImxeSetDBYQ6MHlm2vOIPN1DhCtjMopKRYwIrLU0JHSyj6NkBb7oDUDKOKOhqkrp0v48BvGw2v3xP0DpeWvfgD1/TEa0fKtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxUG/xSI6Af+RS6Mbr7VWwFKCekYP3NRHO32xgVHQsc=;
 b=tCqmSdKmH3Y1Ikhq7exAW/lj+9S4JMQXd1NHfjoVAAxTfXDWTgDdjF9FV2wlxWM9kfe18vrHf0P9vFX9I55XPI+mqUA80XULMzvyhI3Vt0csxfeV3ISMJObX+N952RskhCJv74WdVf+moFlOSgv8LYJIQvTf+asdA7fA7DA+Dz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Wed, 13 Nov
 2024 08:56:00 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:55:59 +0000
Message-ID: <fe31f2d0-77a7-4310-aa34-a5212234fd8b@amd.com>
Date: Wed, 13 Nov 2024 14:25:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: add the argument description for
 gpu_addr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241113081515.725326-1-sunil.khatri@amd.com>
 <20241113081515.725326-2-sunil.khatri@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20241113081515.725326-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::25) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 604e23da-8da3-4d2c-d7dc-08dd03c0fe7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDJ4NGgvYmNNSU1GWExCTmFES2tBcmllOXlJQ1cwSUQvV3lWU21iNFNQNHVJ?=
 =?utf-8?B?ZVYrYUxvb2p5U29LajdaSzlmZnFBTlFpNmp0ZUlWNHpYRFgwT3VOc1NXNTRu?=
 =?utf-8?B?aUJUM0tlMjZvQmxyTnBsYnRFL281ZjhXU3dlUjRoNGl6Z29SZXFRbUUxRy9X?=
 =?utf-8?B?b2RoWTZxTTV2aW5UekxhSlZtSGJWUytUdVJ0N3RxS0Z1YU1zd0R2dHJiQ3RN?=
 =?utf-8?B?SURxMllqaVQ5VVpjQ1EzV1hiMlRRblo3VEpKSzJUdjJ2dWxzWWVWRkRXeDdp?=
 =?utf-8?B?V2RUbzFkTWFPYlQ3SU5LSXkrS0JWcFBuMkZFK3dRcTNmSkZ4dWJHYW5icmNQ?=
 =?utf-8?B?WkxXc3JlRjgvWHVuYlFWRFpyS3dmMkRmMjZ4d0VGV0R6bkNsUWFGZi9NNkJz?=
 =?utf-8?B?UHV0SzFTTzY4Sjc4T0FabnlWL2tKUFlhRHR4WklSUER2WUdnbFdsWXNUOE0z?=
 =?utf-8?B?Rlhtd0Y4WVFTQnU4VmNjVWNHZDdnb3lueFdhTzRRU0VBT2Nqa2sweXFHSStR?=
 =?utf-8?B?RFNpMGc0Vi9iNEsxbWlmbnJQWmk5czl3QnE5djZmV2daazZQRWt2bER0eXBM?=
 =?utf-8?B?dWRtc0xrY0wrNmJmU0xnMHJ4V1dqa2VPVi9UWXNPVmNudTFvazByWWVkbkZn?=
 =?utf-8?B?MHBhOGtRNmhESkd2ZUZLZEhsY3ZyOC9uQXpVWTN3N3h3NHNYVldEYmNvTDEv?=
 =?utf-8?B?OW9VQmIvTXhQN0ZTTk5hK3hxYUZ0cFZ1VU11T0ZhWWZjaFNUa3hTSEZ6RC9E?=
 =?utf-8?B?Wk9wcmpnUmhjS3VwY1hMaUJ1VGVtRERFcUxqV2FkREZzZ1AyWFljM3lXOXll?=
 =?utf-8?B?bjF3Yks4TjVUQ0NSZUwzcy9GTEY1VC9GL0hQRjBLUXNyaGxsOUdiYTJtYU5j?=
 =?utf-8?B?MHUrb05Xck5Ma2pPQk9tUXNoakMvOFFNYW5ubFpSMS9tT2wyUUFQc055SEoz?=
 =?utf-8?B?RDFLb2JlZFljaTlSaFRlZnV1d0NOdDNLcHBONTIrRzhlOEJYS0ErSkxsVURP?=
 =?utf-8?B?SDhUZFBWbExWL1J0SXl3YXJVbzl2VnZJWktJSmNHU3BIYTJMcmJPWVlQRHpU?=
 =?utf-8?B?c2xiTzkwRm15MS9pZ1ZTdzBpakNLaXlDNGdxM2pVb1ZBM1U4cktrUDVzSmZW?=
 =?utf-8?B?ZzdZM3o4bnVMaXNUM3l3V215VW8vYVRQSDIxcHdjdUhnOHluM0hqWWFDL01P?=
 =?utf-8?B?c2VoUGtGWW9adTd6dm5oKzE5dEVpWTU2cGNyYUFiTlBSZ1VBUkM4UU53OGsx?=
 =?utf-8?B?NzJIb2Z4RDRVQUZMS09nNUMxOG1TTnZlREswWk4yYnFGS3I3SWNWTU45UnFj?=
 =?utf-8?B?VkU5ay9GeWdvTXFTSHJyNWM4K0FTSWhBTkppMGZRMGIraFA3MjdnQnpOMS9N?=
 =?utf-8?B?OWpzU1l1VENlbjlDTVg4cTNEOU9XbFhCVzJKUzh4TUlNZ1lPcEgxSjdmOXhN?=
 =?utf-8?B?ZjZWd3RtNEpJL010YXQ2ODJsNDh6ZnhCVEplWWJIc0JPNjhBaHJ0UjZpaDIy?=
 =?utf-8?B?aWRhTmlNYURWb1lSdmJ3UjNPZXJRT2ppakFEUjlHWjJoU082UkN4ajE5ckdU?=
 =?utf-8?B?RVlCTEdkZXo0TmZsakRINisxbm5kellKZ3JYTzRzSE9GTjlaT1RMRVNZMTVl?=
 =?utf-8?B?OTBkMmpRbDlkVk1zdFBaOXU5djBmUXVQNmN5S2p6YjlRcmRWSHZMYVhwZkFL?=
 =?utf-8?B?ZEZ3RnpTM2NlNFdRc2I1blBmdXoyLzVZNjcwaVQwTE5PNFVoQitCUE1nL3NG?=
 =?utf-8?Q?h2fZBDu1siYucd63xtO08qeGjAUi5MvyrPHZRpn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJnOVhzRzdyZ2pVdERkQmwwaSt0RUhwMGVLdUJSK2tEVWJSa1Q3MmhQWVJ0?=
 =?utf-8?B?Z2QybkVlV3d6Y0lWcVhLWHJURXlEd1VXTE1OalJubGtuNFI1eGJPZFNkUi9K?=
 =?utf-8?B?VUhNRit6Q0ErZFM1VmQ2b0RvZEQvdnFmYzJXSkZFTWtGRWl3Z3JjcW1rUFlR?=
 =?utf-8?B?dnNLeklXNHBPU0NCMjA2MklqQ0ZZZWlQMkdRQVRkdERWcHJWS3ppTlIwTDB4?=
 =?utf-8?B?Ymw5U1pFYk9ueUdDOTJRdHNNV2lWMFFJdTVZVitJZHBhcWJ6QlhGTzNEMUYx?=
 =?utf-8?B?ZGdFK2Q5c3A4UzVXZnBWMDJjbzNFdS9ZUmpMeno0NStMM3Nma2R6MG1DNVVs?=
 =?utf-8?B?K3NkSm5xcXBMTlQzZVhuNTJyazczaWVOUzhleFJkeDNBaVBlRlhXeXlOczlT?=
 =?utf-8?B?M0p4ZUYySFRWUW03bjkvdENjcm9nbVhCZmY4MHEzdEtaUGpaWEhUb0RLdldC?=
 =?utf-8?B?MVZQVXBvN0JBaG1oYnJyb0VUQnNtOTljODViOUFZY0ZBbDdyUjJHQ2JsWG44?=
 =?utf-8?B?MzNzR1NhdFZ6M3JTSndFdkJES2NqRXRHeE04S0Z6dkxmU1ZvcW9tYWt2SFlu?=
 =?utf-8?B?bzZ4YkMvM2txbDEvMGs5OWpXV1VzYTZicHpaSkQ3QlZhU2MzeVRXSkZhUVow?=
 =?utf-8?B?dnN1d1pMaTVZWFM0MXM2VzE0S1FZVXNyK0FUeEduY2JOZy84ZjR5aWF4RFho?=
 =?utf-8?B?bUpuRFNDTnVvREdWYWpOQVRUamR1VDZneWYxQS9ab0RjaVhERDJHWHMxUDcx?=
 =?utf-8?B?aGtGaXhVNG1KS0orNnVZdHF3Zzg3ZjV4RTdKM3VvdkNkZWt6aUlubm1mcHll?=
 =?utf-8?B?aDk1UWlYaUFtbXZ5dkx3eExydkFPemU2VmREZDU2bGQ0S3dkLy9UTGhHV083?=
 =?utf-8?B?VkhkK1owQmdjaVpkYm5qYlMwMWF3ZjVTTEFKdXBSVnNPMDhQM0kzQ3dEa3F2?=
 =?utf-8?B?ZDFDNmZ0N3ptRkZYSVdjaEpNL2l1UE1kemE3dXpMZ0pYeFd1YTVFNnFQWEhY?=
 =?utf-8?B?SXptMlNBUmcyczQ5RGZzQ0tUQjYvTm5BNjZ0QkV3ekFVVDVFRVVRZm1RMjR5?=
 =?utf-8?B?VFIxUjYwSWprTkdNWTM2NGNmbThxdGJTVS84Z3NRVzNVQ2tEaEpTbUVQRHpu?=
 =?utf-8?B?M3hnbVJkd3BKekQ0SUlWMTdlQVJuUUc0dUxlSG9Qb2RtaHY4M29ReVBtQ203?=
 =?utf-8?B?elVNNnJnUFJBcjlCSjZLdzAySytGWWtTbzlCUkxBV0VocTBDY2ZKOEFuMHFJ?=
 =?utf-8?B?cFZTeGtSNkt3OHhFelpYTE5kQkZiSm9tRFFPcExnd2I4c0dXZ0EzRnNNb0ZN?=
 =?utf-8?B?L2hVRVE0R2Z1SGxRYlBPekZmRnB1cXZqZmFsVGlMa2hLbDR5TUhueHJ5MVJM?=
 =?utf-8?B?YTdPd1FDNzhZSkNzaUFia0JqeHB2Q0NaYTAxOG1lMm0zSWlHYzVib0J3VWpw?=
 =?utf-8?B?VSswTmk2Y21QZjZmVGJldzJnZlZLSko5eUJQZzdxWjRMS3Z6YnBJQ3hOVVFr?=
 =?utf-8?B?dVdtMno3SXY0N0xRaDkxb1pIUXk0T1hCSk9aWEpBcTVOOHRwRzFFSmxDU2dM?=
 =?utf-8?B?cXdnSlhJVDd5ZENPTCtlVWgrTHZ1U2g3b0VlZERNdklzRWF2QkRsOVJKTndi?=
 =?utf-8?B?djN5bUIvU0Jpc0xRUFFBSGMrYVFKdC9naC9XeXlXbXdGMlVLM3lkbGszaCtq?=
 =?utf-8?B?ajFJZjM1Z3k3TWUwK2pOZ2krcml0emNGdEt0cWZBVlYvTzRvQWp6cVZ2a1NI?=
 =?utf-8?B?aEtObXlLaERod3ArSnIvKzk3akRTdFY4aGxlS1VDMk9yNmdnalEweTA5ckpC?=
 =?utf-8?B?ays0MHhLZ2NKeGtZSGVIdldhWXlVSGpEQ0gvVHdtUzAzOEpUME9RaGpMQzJM?=
 =?utf-8?B?UlBjb1dlam8zd3h4WWZsSGFLSHFxMmlkaGNXNXBHZmh0TTRFbE5WbUk3QjUx?=
 =?utf-8?B?bUV6clh0b3BUUzhlWXQzbXBRS2RjWUxSNHJIY0k1SDJDTTk1dlIyRTBxQWJ1?=
 =?utf-8?B?aW9jbHd3UlUxVkVTT0FrMm9STTlqajY0K0tibGF6MDluaE56eGNmeTBlRGJj?=
 =?utf-8?B?dDAwSDRMTWpZbmZSejE4REhuc3I0MkpOSUZVK0UxN3BDVEpsd1BITjVENGp3?=
 =?utf-8?Q?FSEei2GqhrafTnn23+dxQRA8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604e23da-8da3-4d2c-d7dc-08dd03c0fe7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 08:55:59.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC7UnTGKe4tQWzK5EEoidix73mXfVP7iQSyC6lgvqx1nvTu8l1+0CWYB0yfBWmykKd4vKB3J4JE9sQGADZywxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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



On 11/13/2024 1:45 PM, Sunil Khatri wrote:
> Add argument description for the input argument
> gpu_addr for amdgpu_device_ip_set_powergating_state.
for amdgpu_seq64_alloc?
>
> Fixes the warning raised by the compiler:
> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168:
> warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc
>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 0defad71044c..d392cb0cbf61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -157,6 +157,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    * @adev: amdgpu_device pointer
>    * @va: VA to access the seq in process address space
may be @gpu_addr description follows after the @va as per the input 
argument order in the function?

Regards,
Arun.
>    * @cpu_addr: CPU address to access the seq
> + * @gpu_addr: GPU address to access the seq
>    *
>    * Alloc a 64 bit memory from seq64 pool.
>    *

