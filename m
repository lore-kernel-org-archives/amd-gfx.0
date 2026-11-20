Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE6A60A261A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x8Y+vrPP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F9510E32A;
	Fri, 20 Nov 2026 20:31:23 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB09910E2A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 20:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xivQhHO1nqa339K64zfLYrOHMnppGQ38vMvaBRE41SQvxd4G+cXA5D8Q1oYguuKzVHVIy61L/gDV8ZJ76BXwagiFfE8z57xbv4qMx1wZxroOm84qso7SrVKBeFAdork1IvFL78kWUqiKUxbGY0hn1VRoSHLWUtfyIc2snf2WmvfRiTAe6n+Hke0khuDYxmvY81cG/UUialYEWXsR7f16ZJZi+W157BuBX9U/+wYGWxHSNVu20z2SuKswlil9G4PEA1eRpvdZJv7WEBcR+yoIxj97mTJWRsLa+O/ZsQYlH8BzT23MhVQ/IU/R5YH/kc0FtnB/HrAE3k4Kzsg/NT7MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bN0f0vBEAJvBisiiqx4RiuRSIXzEANIt8ty0hEL6jXo=;
 b=M/YVFycCIfOEY1MZ+1e/Qcs11ledvDXWyWplnf0XeA5Sj/QHACLD9/Yh9dpwcmwek/cnQ8ACrvfs1gPNhMSVywyYNUpBrvkjIBI91alqJ8A82LuniH2CY3Ht8roKkGosbtKrhU4jgyKfnYYTF+Jr44LIyrfysnpxGsvUnGySvEgRE3UpypLOrVgURqzwA9fqOUJ1EXx5NVa6sycsq6/kIE8c32EXanUzt3N0nnIRrZTWnuqCUarOOwjKNr9Zri6m9HbAc4BusQDoJnt0cUv0z3UWbbXx/skzYnh3+EMDwyJ8f7siSuEJ9y0NBz0eUoHbJjZKCMosUXR7WealKBEkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bN0f0vBEAJvBisiiqx4RiuRSIXzEANIt8ty0hEL6jXo=;
 b=x8Y+vrPP864cZWmyMf2kN6ULKqlSOCnC0x6pq365MynZnicq8Z9VXH7JyzIOJaRJDykiJ+cdHf9Hy7SHlb0MEC0MRwtvEookZDGMtjvXSc/ZLhl5J5d50TqHbpflTCh3vxH0xdOJCpkI4VXdZaZbpRlkN+XSkScjhPSf55zHZBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8SPRMB0063.namprd12.prod.outlook.com (2603:10b6:408:242::10)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 20:31:11 +0000
Received: from LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0]) by LV8SPRMB0063.namprd12.prod.outlook.com
 ([fe80::6cb:fff:7dc4:2fc0%4]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 20:31:11 +0000
Content-Type: multipart/alternative;
 boundary="------------OQ80zvxWw7ZVCkWtcFcIRLPe"
Message-ID: <51c2d1d5-71f5-4b8e-91e5-974e8a28a8a3@amd.com>
Date: Fri, 20 Nov 2026 15:31:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: only flush the TLB of devices whose
 queues got suspended
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: YQZPR01CA0188.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::28) To LV8SPRMB0063.namprd12.prod.outlook.com
 (2603:10b6:408:242::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8SPRMB0063:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: daec17dc-3071-4309-cf05-08df47453729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|261021123027099003|10067099003|261102123227099003|261021135927099003|261022105027099003|261021121427099003|261026140227099003|56012099006|261009223027099003|261026121527099003|261028144727099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: SMZZRSzpx68ogAXuhVbmKZy4ElLcUDXs+7kot/OVbj0ts/oMFoL45UPGx9TUqBZMiOTOTS51SHI58+6lS629el5x3w/6jfTIVbemjtO0iwB9kNVY+J25xyD03wFIg3jCfZOXB17YbLA3n7kwdzFPsHl81HMXOeIkZ3MmcQ4ma9xUvi09zD4hZoUvSnpOHKG1j0lvP6h5nOD1Q3BzK1ovUFJ93lxXLkNVIJO7PVMc7rrjPJ0iVLQqCVEw+E2TpsGK5NOpXTPgIM2UA9ROcJ4HfqZLg8eG6dAl1jfpyQAQx2nI4emzeTxLz1N3EBhTEjTms92LiSfca+aJ7BHtmnWb7ogFSjHal1OShf22rFOL35hqfYrUwMTGbxB1vplfNf3MEDdVyH+tK9VGDODAD4b+e8sMKprRR6/Otzp5FLXLhP/XTFxCwJRBFenKnZQjIONaLLXkfIOsq6NZ+BtBBzmmiffIJ5HJIQwzqUe3HYU7GMmLHz2ntmLe7UNcn+purie0MlfsWzT+ATdQAlYaqv8zooyJS3Kz28nhMmvYSIHaHZhzIdHSdwhMAmYxJhQO/Kh+xJ9s/1JaKdhQuFUsuXwmtoSuzjdj0vCYKXO+5V/0NXhFbygRlluI2q4QzH7fczDvkQZO4qnH3XWI/5Fm78sHcs/3o3kgzixPjKQnzQUASFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8SPRMB0063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(261021123027099003)(10067099003)(261102123227099003)(261021135927099003)(261022105027099003)(261021121427099003)(261026140227099003)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1p1bmY4a0sxUzNEZXlkOFMrTXZuRjE3ZUt0ekREbmZLOFJPTkVVQld4aTlO?=
 =?utf-8?B?S0tvSTJ2bVEwdGk5WXFieVhqSzBuU2NYa05QWU01M2I5cWttNmFsZTVwbEpC?=
 =?utf-8?B?d3BEblJWR1FHcG8rU2k0WjJwc0haZlhSQ3RtVmFqbGVrTzgrdGpsK3Y3NmlZ?=
 =?utf-8?B?dDlrMEVsUlVrN0d6R0Y3aWNhRDFSODV6N0FjaFI1Z3RQSkptQm9paTg2bVFC?=
 =?utf-8?B?dStaODVIdkJoWFppM29ucVZRK1ZUdExpR1Z2ZC9CbG42T3YrenhKZzRPbXR2?=
 =?utf-8?B?OC82VnJhQ3c4T2JCbjJWQ2VIUHYwdjZURExjWndva09ZK1FWMVVhOFZITE1u?=
 =?utf-8?B?R2NMSUNFbjdiRUJpczBrYS9LVExqNWh3eDZYY0FlQVFjZ1I1MldoNnpCb0dN?=
 =?utf-8?B?dDBreWY2eWFKRDhpWmlKNlR3aTd0Z3ZLRFlLSm9TblZsNlJ4V1hNU0NBY25P?=
 =?utf-8?B?ZGRhUm5OL09taVAxQUY2bXhwSi9rTDBpcXU4U0gwazZNNCtDa1lJZExTcEtS?=
 =?utf-8?B?MWhjSkxzTm5FeG4xaW1SUFVwMElPa3loa2VUUUhtSDFhYjR0VjkwVG9MdHVu?=
 =?utf-8?B?S2pXZTVHUHZYSEkzZGZ6Qnh1bjg3SmZTVzlCV25UNHJuN3hoTVVQbEY2S1NK?=
 =?utf-8?B?NVlaOGF0TlM4eEtVeFFoRHQ0WVE3ODNOK29PK2NOaHNVc0dXMjcrQVphLzZl?=
 =?utf-8?B?TGczYndXZ1VScThBdmZkUmZCSHU4ZmowRjdQblVNSFRSNitBTmQ4TjR4TE10?=
 =?utf-8?B?Qk50R09ZRTNyRXhQVHRvZEwzcEVibGdUczNnTmNDckVSTzBVckJxKzBFWS9W?=
 =?utf-8?B?R2wxLzZ6cUFRbVRzeWFoeDRrZEh2OVIvOTI2ZVZUQ0hYZzlGWk5sU0tmUzBy?=
 =?utf-8?B?Wm1yTHljdlp0N2cveXhnRTFqS2Npc0wza1JIZGt0OEV6SmFFRjJzV0JtU0tH?=
 =?utf-8?B?bEkzTy90VlVMblJxL0Qxa0ZtQWxCOUNuNEg1ZHNHeG1jeUxXWDd2UUJDUzFp?=
 =?utf-8?B?NXExY2FkOURHWldqM2ZqeHd6dGs1bFZpRmZROU5pakpPK3hqdzhDK3d5MHZ4?=
 =?utf-8?B?OCthRnFBKy82UzZERG1DLzlHRmMzUTd4TXpxUVNSK25uYnpyamM1eTJhK3R1?=
 =?utf-8?B?Y243cUEyNnJOTWFsS0xVem55ZDdWK29kaGFGcGh6ZjN4bVp0MUlmOVdrenhr?=
 =?utf-8?B?aWQrenAvRmlBTStTTm03MnBLMG1nakVvSm9OVjNZR2pLelhIT1BtSU9HR3Uw?=
 =?utf-8?B?Z29kd3NicmhpakpXblQzcndQcVpLNklMcy9EdHFwam1lWkZLT3RnV0hVM2pT?=
 =?utf-8?B?K0RWbnZFeVRZQzdId0p4dlJHT1k3MjRIWFdNYk5uRndnL1hHd1U3clRvQ1Vj?=
 =?utf-8?B?WHFTVjQ2UnJJamxJK29QZEROa0NOZEJDcTlTdFdXd2swZS9qTlRGdXgwZ2Zy?=
 =?utf-8?B?UnIvTFBob0w3aVpoTnF0U2Q5ZllWSzVESjAzSjVFUk1KcWs3Rm5lK3ViQ3ZF?=
 =?utf-8?B?d0dOcFczNSswM3hjTTlhS3lQWWx3MEhmU3FIaUZRMmE5d1JTT1dpZHlkK3Iy?=
 =?utf-8?B?dWM1Wnd0MnpLa1F3L3Z1WVJ6ZmZEQlBTMXMwYjEvVGNmQTBXY1NSV3c2RkZM?=
 =?utf-8?B?R1Vieit1OTFlRzh1SXE3UndUaW1OVHBleHIrR3ZYOWxkbnd4WnJma1c2eFcz?=
 =?utf-8?B?dW9EeWhqamNRSkFYcFhEZDRhM3ZUd1IzajZJdTFsNCs3amY5RlpyZkZFeWZv?=
 =?utf-8?B?K085TSs1Zjl3d1RkbldTaWlLMXAxVDRvZitlaC9leHBxc0prSDdrcG80SVNq?=
 =?utf-8?B?NjhRQ3dkZW9PaTF0d1pKN0pjSURQOUlMdDBKQnBraXFPVU00SlptcE15WERL?=
 =?utf-8?B?T21QUzE4TVJ6R3hpakFQN3dzOTJiaVN3LzZBUGNlTXlabVRreUhhRVd2czFq?=
 =?utf-8?B?RGJlZEpia2d1b2RZZkFva3hvdjZERzRoWHRTRWk2NTRJMWlqNGdneENwLzg0?=
 =?utf-8?B?QW9Tamlrbk90dUwrMzNoM2xkaDZaMUROTzMxcVJHVFlpV1h6Rm1DNktqVkR5?=
 =?utf-8?B?MThUbEdQSmdrVmVEZGl0c2laZDB3b1pyTWhoa3hPVXZqNWdiRSt3dU5NM0VK?=
 =?utf-8?B?RFFLb2lFZFU5M1hCRnFLZ0VqcmFHdjlxQ2FuQXpCWm81SUNJSnJ1eVhiRkxM?=
 =?utf-8?B?aHlDNjhZSFVZcmU1L2FCcjNZaHJ6MWJrK0dESTlERnZWSDc2dStPMWk5TXRj?=
 =?utf-8?B?TVVXSmpmVXMzS2pucnJieWFMMWEvcWZidTR6Zzd2ZXdOUjNlQm9idHp1Z2VW?=
 =?utf-8?B?Z2x3UGVFOHFmZlRrYmVYYWR3WGR1V3dDalQ0V1JnS2s2QlhRMUtsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daec17dc-3071-4309-cf05-08df47453729
X-MS-Exchange-CrossTenant-AuthSource: LV8SPRMB0063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:31:11.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCHSYyScZr//OV3bXXJwmFBMYh2JPAzc60A+pgA26rcZsyOLK5csuRtV+dNj0DY7BqW2qDfDPeREurYDnMJouA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------OQ80zvxWw7ZVCkWtcFcIRLPe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-18 00:49, Jesse Zhang wrote:
> suspend_queues() goes through all devices of the process, and on MES does
> the debug memory fence and a heavy-weight TLB flush when total_suspended,
> the number of queues suspended so far on any device, is non-zero. On a
> later device without suspended queues that flushes the TLB of a VM the
> process may not even have: kfd_flush_tlb() dereferences pdd->drm_priv,
> which is NULL when the process never acquired a VM on that GPU.
>
> That is a process using only one GPU of a system with more, e.g. a dGPU
> plus the APU's iGPU, stopped by a debugger. On navi31 with the iGPU,
> a debugger suspending a compute queue of a ptraced child that only
> acquired the navi31 VM:
>
>    Oops: general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
>    RIP: 0010:suspend_queues+0x104b/0x1a80 [amdgpu]
>    Call Trace:
>     kfd_ioctl_set_debug_trap+0x1234/0x1720 [amdgpu]
>     kfd_ioctl+0x46a/0xb70 [amdgpu]
>
> and the debugger ends up in D state.
>
> Count the queues MES suspended per device and only fence and flush for
> those devices. With that the queue is suspended and resumed (status 0) and
> the kfdtest KFDDBGTest tests pass.
>
> Fixes: ff114e705d6a ("drm/amdkfd: Add TLB flush after MES queue eviction/suspension")
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b5d7d13f31a5..a50a49d6ed01 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3952,7 +3952,7 @@ int suspend_queues(struct kfd_process *p,
>   		struct device *dev = dqm->dev->adev->dev;
>   		struct qcm_process_device *qpd = &pdd->qpd;
>   		struct queue *q;
> -		int r, per_device_suspended = 0;
> +		int r, per_device_suspended = 0, mes_suspended = 0;
>   
>   		mutex_lock(&p->event_mutex);
>   		dqm_lock(dqm);
> @@ -3974,7 +3974,7 @@ int suspend_queues(struct kfd_process *p,
>   							~exception_clear_mask;
>   
>   					if (is_mes)
> -						total_suspended++;
> +						mes_suspended++;

I don't think you need a new variable. Just use per_device_suspended for 
both MES and HWS. That name is more meaningful anyway.


>   					else
>   						per_device_suspended++;
>   				} else if (err != -EBUSY) {
> @@ -3987,7 +3987,12 @@ int suspend_queues(struct kfd_process *p,
>   		if (!per_device_suspended) {

Then this condition becomes

if (!per_device_suspended || is_mes)

Regards,
   Felix


>   			dqm_unlock(dqm);
>   			mutex_unlock(&p->event_mutex);
> -			if (total_suspended) {
> +			/*
> +			 * Only for the queues of this device, the process may
> +			 * not even have a VM on the other devices.
> +			 */
> +			if (mes_suspended) {
> +				total_suspended += mes_suspended;
>   				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
>   				/* Heavy-weight TLB flush after MES suspends queues */
>   				kfd_flush_tlb(pdd);
--------------OQ80zvxWw7ZVCkWtcFcIRLPe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-11-18 00:49, Jesse Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261118055009.3005630-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">suspend_queues() goes through all devices of the process, and on MES does
the debug memory fence and a heavy-weight TLB flush when total_suspended,
the number of queues suspended so far on any device, is non-zero. On a
later device without suspended queues that flushes the TLB of a VM the
process may not even have: kfd_flush_tlb() dereferences pdd-&gt;drm_priv,
which is NULL when the process never acquired a VM on that GPU.

That is a process using only one GPU of a system with more, e.g. a dGPU
plus the APU's iGPU, stopped by a debugger. On navi31 with the iGPU,
a debugger suspending a compute queue of a ptraced child that only
acquired the navi31 VM:

  Oops: general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
  RIP: 0010:suspend_queues+0x104b/0x1a80 [amdgpu]
  Call Trace:
   kfd_ioctl_set_debug_trap+0x1234/0x1720 [amdgpu]
   kfd_ioctl+0x46a/0xb70 [amdgpu]

and the debugger ends up in D state.

Count the queues MES suspended per device and only fence and flush for
those devices. With that the queue is suspended and resumed (status 0) and
the kfdtest KFDDBGTest tests pass.

Fixes: ff114e705d6a (&quot;drm/amdkfd: Add TLB flush after MES queue eviction/suspension&quot;)
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b5d7d13f31a5..a50a49d6ed01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3952,7 +3952,7 @@ int suspend_queues(struct kfd_process *p,
 		struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
 		struct qcm_process_device *qpd = &amp;pdd-&gt;qpd;
 		struct queue *q;
-		int r, per_device_suspended = 0;
+		int r, per_device_suspended = 0, mes_suspended = 0;
 
 		mutex_lock(&amp;p-&gt;event_mutex);
 		dqm_lock(dqm);
@@ -3974,7 +3974,7 @@ int suspend_queues(struct kfd_process *p,
 							~exception_clear_mask;
 
 					if (is_mes)
-						total_suspended++;
+						mes_suspended++;</pre>
    </blockquote>
    <p>I don't think you need a new variable. Just use
      per_device_suspended for both MES and HWS. That name is more
      meaningful anyway.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261118055009.3005630-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 					else
 						per_device_suspended++;
 				} else if (err != -EBUSY) {
@@ -3987,7 +3987,12 @@ int suspend_queues(struct kfd_process *p,
 		if (!per_device_suspended) {</pre>
    </blockquote>
    <p>Then this condition becomes</p>
    <pre><font size="2">	if (!per_device_suspended || is_mes)
</font></pre>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261118055009.3005630-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 			dqm_unlock(dqm);
 			mutex_unlock(&amp;p-&gt;event_mutex);
-			if (total_suspended) {
+			/*
+			 * Only for the queues of this device, the process may
+			 * not even have a VM on the other devices.
+			 */
+			if (mes_suspended) {
+				total_suspended += mes_suspended;
 				amdgpu_amdkfd_debug_mem_fence(dqm-&gt;dev-&gt;adev);
 				/* Heavy-weight TLB flush after MES suspends queues */
 				kfd_flush_tlb(pdd);
</pre>
    </blockquote>
  </body>
</html>

--------------OQ80zvxWw7ZVCkWtcFcIRLPe--
