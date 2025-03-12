Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E27C28B2F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 15:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570C310E188;
	Wed, 12 Mar 2025 15:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CI7iLxEn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC97210E188
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 15:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNRE89/HamN2CFBiya37WWa6Ep/SsI+d7W8VUeEp1/fncJ0UggZK87N5C6ZHXzvqKNVFyPgmGCX8VSV/JA0AqhD0Pzl8orTKbI+NRhQiGJ/m17q+iRL1dr9LrE1SQOyLk5M+IkSMIDmCcD047EvmAVXyI8KXfFkEuBqGLRGD8jsTMNWKR5IBjx8xXZ4USE5JNtC1z6X3Pi3CNvj6OEaYr2n3C1EWo2AiTUtKmVnZ9B1vZia7ZjWlxXzlocWoOjcBZQU0xhBjbQlg+cuKNnscQRCj+HH/3armeglRaXpYjQ+nOq43nD/T96BEzGvtKeqyZT5OEFhVS85or/mwD93Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pog++VbTUlzQoCNmvsDAnulwG9oQh8yfxXGMaAEo3g=;
 b=jB3opLKP/89wlUiOqrl8LEmZpnEM/3x/WMu7WLDMio4FtFhGaaRq3rHHdxq6pNChxXnJ+Y8uLgluj6H5lu13XE2A8sn1vmafNmIKQX6RDFQhoSpPWGKOoWf70NsZlB5gm0apa+1MRZAhtwCDYNdHHI4ibcvtwevQ7KxSpenPRnKKQlSqAmshV0ebLfzdLtcelj+T6/ozLE7eCK3DFa8UzemC2OAa6jhVFzE/fFT2EQeXPQpDtWLqclRxAUIdLEz6Vt0e9GrROHbi5HOf6Ox64VedK1ZX4vce4iAOymY4YPRXuwN+xdsaQVTmzYi2LFdCnNW7Aq6I5AfAY1UVv7UvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pog++VbTUlzQoCNmvsDAnulwG9oQh8yfxXGMaAEo3g=;
 b=CI7iLxEnFdCRopOYj4AOSmM1uGmW4zPGK1qwGpsYTqr+DRfcxOQ+ybbQ2R5jj9iJ2dKR7hc8p1wqWJnZBDDAxvF/wmPXq+9JgTqbBfINP+CVyTs2YwRChlLoab8a+Le3tD4YzbgNRVNskbuyVXoUI6fmX5Fw/C17ZMTh8BGJ/Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:16:47 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:16:47 +0000
Message-ID: <573c5293-be7e-452b-96ea-336673d12e26@amd.com>
Date: Wed, 12 Mar 2025 20:46:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/amdgpu: stop reserving VMIDs to enforce isolation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-6-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250307134816.1422-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::15) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6748bd53-4a73-4420-bec9-08dd6178e7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wmc1OVhLTUJ0QUEwYVJEOUx5dUkraW9BOThMVGdFYUI5NUcvTE1pVmVuaFNG?=
 =?utf-8?B?cW1sRFpiQTA2eDh0dXo1SWt0OTJCQ3N2RWVzbmZoU0psYXo4NmVrT2p5UGZ4?=
 =?utf-8?B?K3NRRGM2djhCQjdNaHlRMHlyYTFWMlRsUjJubE16bE9HUVFPVHI5SHFWTUdY?=
 =?utf-8?B?cUZzOHpMa0NPUDdibkNOb0crYlpGMFFNSW1OcDV6M2RxOUUrd3lwNllRcDBi?=
 =?utf-8?B?cStFek4zM1B5Tko0VmxSYkF1Q2pyMnlpdzRCcUE5TVQ5dldCMmd0ZzIwTHhh?=
 =?utf-8?B?UUhINDhaUzVxRWVIaGpvMzNZMTNZczRmNFhwTXZ3Y25TeFpjbDFuV3ljTGhj?=
 =?utf-8?B?dURrZW1DSDVjeWkwcWhsY052dU9zc250WFFLNzZBdEZCeENURkVzQW44clhD?=
 =?utf-8?B?RkJwZnp0czNhZVZIWDRpcjBZZ3hPWDFONjhOQVdob0Y2MlV0NEJHL1ZCa3Na?=
 =?utf-8?B?N3VrRjFoM0pqdlEvWVAxMUhCL0o4cjZ6TDNKVHhFZU93Mm9HZ3NzNUJYbnNp?=
 =?utf-8?B?b245TEdQcTFmUHYvNDMvSUxQUmRvN0FoWTdFSG9wUzdjTGFiWkJjZ2pOUXNG?=
 =?utf-8?B?NW1PM0d1UnhkSllqQ0RTQzM5UU50T2RSRzZZNEFleTFGQ2dWUU1OM2lsYVVU?=
 =?utf-8?B?NUFXbGpUVEZJUE1mQVNUVllodlBVNktVaWRUZ1R4NnNtTnQ2TUcyU2Z4S0Ur?=
 =?utf-8?B?RDBTTnp3amdtazJWM0p0M1o3QjJ5R2IrTmlLNjUxYzFZSEVmVlJleVUyOHJ3?=
 =?utf-8?B?RzFQaFFQQk1ydmVoNHViMXYzandPQWxTbW1jNTc2M3c0TUVWNlVoanQySEF5?=
 =?utf-8?B?UnhFWnNDRXNacHNPMmRCUEUrRzY2MkdOeGlWT3l4ODBUdEpOSUIwNElQL2ps?=
 =?utf-8?B?WUxFVnZTV0VoalFhbmZHMlhaQTUyOEtEWXpRaGFKdVZ1MDdWRWUwNmdZYzBw?=
 =?utf-8?B?dzFiNHVMSHdVMm9OYkJQMFZ4aWRiRHR0VVViMVFHeXVKZ2Uwc1hKSXY3VzBY?=
 =?utf-8?B?eTRRcm9TUnhwTDlCRmI3ZmdKZngzRmZYd2lrNHlGb2xYNERGenhzNXlQUmNH?=
 =?utf-8?B?SGRxWXpwNzg2YUFTQ04xM1hpTVBudmhuZEduY3hVZWxQeTJKSndjaDhMc1Fj?=
 =?utf-8?B?RGhEMFRxdmJBMk1XVVdvcXBtSlRRbVpXQzU5RUI1STBUVWxLOEZrdWNLVFlL?=
 =?utf-8?B?ZVZiaTVTbzNTT1krM3VibGtISXIvanRZZWJ2Ui9JVGsxOXp4UTFBTUpaOTNC?=
 =?utf-8?B?bzJqR0dnQnFwZTN0Vko0U2Q4Y0NmVC8vWVpTRDBpNkhzdzNyTTNUNXF1UlQ4?=
 =?utf-8?B?RkJzcFR0UmtJdk9QSHd6WEtVdWNaak8vOVRaOWtjUzdqeDFDUFg5cjJkbzQ1?=
 =?utf-8?B?YXcrZnZoemVaYWN2YUlSeERhOTNBR0dDeGtvNTNsZ1BHclVNVHByRTI2NkM5?=
 =?utf-8?B?cjN4M1VoNFN3dHBsOFo2cGpoZEFMZFo1T2k1OVR4RE5uWFlQekFoV0VZdlpl?=
 =?utf-8?B?ZW1hRU1HWElNZGoxN1dIWjNKaFIzS0lYOFIzUFFGMHB5ekdOWmJqNVpWOGd0?=
 =?utf-8?B?ME41aXd6bmFyQkE5YWZQcmpKWU1MRVd6ajRFdkRaWldNcDhhQzVRdVpMV3FI?=
 =?utf-8?B?Z2V3bnc2ZHJCTUVCdXZyOXZTcGQwRnJqN21xNmsvRDNrYnp2V2xwVHFIamov?=
 =?utf-8?B?eUdwSFNFZEZaT1NGV1Y2V2YvMGVoUFhmd01XSkxEdTdwQWRDQkFYUU5kM2Zt?=
 =?utf-8?B?SUFQRk0wRE1uakVrd2wxRmVlZFdPWGJIQTliQnlBODlYVFhaZFlSTVI3ZGdp?=
 =?utf-8?B?ZjZHUWpKZkxtbk52ZUc4alU1Y1VSSFEya21Va0pQRjZYVTNaK0YzMkRLQllW?=
 =?utf-8?Q?p/81zpwQYwJml?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWZqdXphYU1DTVh0TCtYdjFILzd4S25EU0pPdmRqbTRyYnZpcW5rN1J3VjdI?=
 =?utf-8?B?b2RPZUpCa2JsWU8xdHhQWExwUUg1OUpNbDRkeGhyWTFNQlFuaUQ3T3g1Z2hX?=
 =?utf-8?B?aWR5cWhNQ05IVXRoTy8yRWFnbUYzbTN2U0cvQzF0ekd1a0ROOTVEdXZvbWd6?=
 =?utf-8?B?MzVHNVVDUk1pMEl5cjZhZEtkdXBQY1FXbFJ6TnVuZEZSbFllVURqRGVLRU1o?=
 =?utf-8?B?d2VJK1dCcGZXNG9WM3JkM3lvMGFHS1pSUFhPRWkrdU53aVd0Q2IxbW00d0RI?=
 =?utf-8?B?K3VmeGxjR3l1dG9iRXUrUHZmWDlycnRQR2lFK0h0WkNDbUxPU0dwMFplcEdX?=
 =?utf-8?B?REJiU29tQjhNMzRJWmJQS2dVZzQ0bDYrN1pRdEY2ZFJEZmovWXg2OVJZUGQ4?=
 =?utf-8?B?dmlmTkdnTTl4T2xmVmpLVlNucGlrVjR6dnRXb1l4TytDVjVpbnE5T2VHR3hn?=
 =?utf-8?B?TThwd3FtWUFoVFIrKzhZcUF2cG1HZG9MVU9TalMyWnN1dlNqYXFtWlJjVU1l?=
 =?utf-8?B?WWhOenlab0wvMmFXOWx2OTRVWTlwZE1vaC8xd3R2QysxSTFyQ0VmUVl6eUVD?=
 =?utf-8?B?bnJTc2JKSlFQNUtRcHFYOG0zYUJRQWxqZitTVDd1dUxKQUwrRVYzTEtJMUlF?=
 =?utf-8?B?VTc5R3dPLzFjSHRjRDFhYmUrQXl3SlNXQ1BPQmN6TFU1STNOc2IwNTdQMDVV?=
 =?utf-8?B?N3NqcVFma3ZqTlp6clY3QjFWbWtyc1EwYnh4ejNvcks5STJWKytjS3IzZkdv?=
 =?utf-8?B?M2I2aWhjeDlzQXA3b0lKVUtGTzVLQVpQVGVseWZSR2NXQlNON3FKOG9sZHg4?=
 =?utf-8?B?YXpyc25UdFo5T2JrUDkwakxJSEpOVHRncHh0bDhlQ2NLRENYVE5rNm9pODZD?=
 =?utf-8?B?bFNUeHh6RlRLSzY0cXYwOHFWOUxFaEUzT01vdERWUk1kNXV6citLN256VFRi?=
 =?utf-8?B?VGNVYnVZbExjc1hIQW5NZXF4a0tTZ3JSS2JFVUJHWnY1ckVtV09HK2R3K0x1?=
 =?utf-8?B?amZqT0hyWDgxeWRYbi90NlFRWEZhT1l5QUYveVlOcUJXOXdvZW9PbEpCeHk0?=
 =?utf-8?B?N0FaNGticHJwc0JBZDhlekZXQ1o0RmVFcDE4VHMrYnRWQXZ5aFovQ2VGeWRo?=
 =?utf-8?B?VTdLSzlCUzV4elgyRFpEVXJFWHlTTDJ1ZjQybjhPQ3JPdkhrMi9ZYmdGMFhD?=
 =?utf-8?B?S0FuTytEdkNsd0JQQ21jdnE1N1ZKcHovUklCS2pDZWFDeFlIN3htVCt6bWdN?=
 =?utf-8?B?a1JXWThTSHZTZmtrL2ptUWtkMnh3OWtIZ0F4YXU3c0FrSG1VVjdUZU56TGVI?=
 =?utf-8?B?L3dSYXk5Ny9RdUxsL3NEMnJvQmNOeVREWVBQMmt4aWlQTUtIOW8vbWtvTkQ1?=
 =?utf-8?B?UG0vK01ocFRtUWtDTDhKbXNTWEdzSnJiTFZPQVFhdG1mbFpHNzdvbFYxUkk5?=
 =?utf-8?B?SHNzYjgrR3hhN1M2aXg0UEpkL3hpK1VWbklBdHVFN05UckxQK0ZVTFltQWZz?=
 =?utf-8?B?TUNBcTNIam5LY25aN1pWSWpucmpLU2FxWEVpa2F3SVZOYWZoeStzTmZoQm1t?=
 =?utf-8?B?M3BLeFdpcWVjcjR5Ky8wOXlkMVJ6enJqVEMrTmVldVlMTjUzV1cvZmhUQk5X?=
 =?utf-8?B?U2FiWUhjMEhuZE9WV2VaTEppZkRFb2xpVjZmYjgzMk1VRXRvL0RzQUZ6dFR1?=
 =?utf-8?B?ZVFHQUFqbkUzZVA2eG5HSW83K1AvRVV6OHIyL2FnZkZSVVdVa2IvYnI1SW0y?=
 =?utf-8?B?SFpMeHFzaUlKTVZ5eTNqRGVFaUw3bG1DNVdXUUFxRTFPOEhwek53bHBzWERS?=
 =?utf-8?B?VHVBUFZ3N3BRTEtJN1lyOG9ReS9xMGJYVS93YS9ESExTNHkxVVh5VVlrRVNP?=
 =?utf-8?B?OFUvcURMZUFJb29pS3RSWjF6WGJVVUlpNWlEemVEdUNUMmlZTHZkNTAxQUNa?=
 =?utf-8?B?M3J0SjI4MnF1TGd5RUFpZm9hTmRiWXNEeFBuMGtUMWNCZHZPRjRvS1ZIdHFQ?=
 =?utf-8?B?VlZYRWJwZWtDYWxlUGJlNVJVaktBYUhPMll3YlNsNXlkSmM5QnU3cnoyVHBh?=
 =?utf-8?B?OGVQK3ZYYmNlc05oVVdPcnB1WS84dncreHRXWjVYWG9mU0JDSFlaTFZtdjdu?=
 =?utf-8?Q?g73Ixu6jdSCvtTd/vmnvJvLrz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6748bd53-4a73-4420-bec9-08dd6178e7ef
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:16:47.4466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aL5CN6Nd49T0cxDsE0+dWQrrTqet9SPnQ7foHIFURqqV9YXfS56ubCgBwuOVvcVvVfQyE5RsYl+6mTniV21Eow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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


On 3/7/2025 7:18 PM, Christian König wrote:
> That was quite troublesome for gang submit. Completely drop this
> approach and enforce the isolation separately.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  9 +--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 11 +++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  3 +--
>   4 files changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 2ce0c6a152a6..4375e5019418 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1111,7 +1111,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			struct drm_gpu_scheduler *sched = entity->rq->sched;
>   			struct amdgpu_ring *ring = to_amdgpu_ring(sched);
>   
> -			if (amdgpu_vmid_uses_reserved(adev, vm, ring->vm_hub))
> +			if (amdgpu_vmid_uses_reserved(vm, ring->vm_hub))
>   				return -EINVAL;
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a194bf3347cb..9e5f6b11d923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1665,15 +1665,8 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>   	}
>   
>   	mutex_lock(&adev->enforce_isolation_mutex);
> -	for (i = 0; i < num_partitions; i++) {
> -		if (adev->enforce_isolation[i] && !partition_values[i])
> -			/* Going from enabled to disabled */
> -			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i));
> -		else if (!adev->enforce_isolation[i] && partition_values[i])
> -			/* Going from disabled to enabled */
> -			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
> +	for (i = 0; i < num_partitions; i++)
>   		adev->enforce_isolation[i] = partition_values[i];
> -	}
>   	mutex_unlock(&adev->enforce_isolation_mutex);
>   
>   	amdgpu_mes_update_enforce_isolation(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 92ab821afc06..4c4e087230ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -411,7 +411,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   	if (r || !idle)
>   		goto error;
>   
> -	if (amdgpu_vmid_uses_reserved(adev, vm, vmhub)) {
> +	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
>   		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
>   		if (r || !id)

Any Null checks here, needs to be considered?

if fence was expected to be valid after a failed call
         if (fence) {
             dma_fence_put(fence);
         }

>   			goto error;
> @@ -464,19 +464,14 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>   
>   /*
>    * amdgpu_vmid_uses_reserved - check if a VM will use a reserved VMID
> - * @adev: amdgpu_device pointer
>    * @vm: the VM to check
>    * @vmhub: the VMHUB which will be used
>    *
>    * Returns: True if the VM will use a reserved VMID.
>    */
> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm, unsigned int vmhub)
> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>   {
> -	return vm->reserved_vmid[vmhub] ||
> -		(adev->enforce_isolation[(vm->root.bo->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
> -					 vm->root.bo->xcp_id : 0] &&
> -		 AMDGPU_IS_GFXHUB(vmhub));
> +	return vm->reserved_vmid[vmhub];
>   }
>   
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 4012fb2dd08a..240fa6751260 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -78,8 +78,7 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>   
>   bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>   			       struct amdgpu_vmid *id);
> -bool amdgpu_vmid_uses_reserved(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm, unsigned int vmhub);
> +bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
>   int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
>   				unsigned vmhub);
>   void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
