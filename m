Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3AFF512C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 17:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7F10E47C;
	Tue,  7 Apr 2026 17:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xm3VS7l4";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3F310E496
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 17:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQbrqbc+Kdv4L2czN7trHHrLn7SgB6n8HseermS52+EcNNoWu+WipwbhaOKTreXIDS0XPlvDLLewjirFZq6lg71Jx0KTnhN3hSF7kCnO0idwQF2SGfBZnYEu6nsrRt60N0Q3dYaXevTi0KDEHQQFLD7UIKIiymuYuyAL1x9wFLif6BrmGy9Mf5IfcWoB61XFClvxW1HktZJWiQg6OFm6tmJ0cUKMEnSnQdki2XxuHFnt67SHKvwkjMg+iMdw7R0X/XRBfpmZyOhRJgGlmhL1qlk6+PAk5Num4RpyWdbo9Gk9A65hl1f5wBCI4DbVy6/nENx07ZaQ5IQbUAYsusm5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04JDe82H/WDi3rAU+fMpDQqHydgtkU00moQGzdYt0JA=;
 b=UBjRzKwlz5LDLRBjudUhtoD+6rqjf/dX/TQ5Vzc3X9oXOpIK7lBK8pN2eWpCVNgJ7UsFrk0hMdG8tO0DnvF0gDPfzo74pD97XbqJSPwZsCAJw/MIPB+NoHj6HvBtLzd3hxK5KdVcI5JJ4AkmadNB6iRguLEp7DYtz5SQGUSDyrm6WbXiF++YL1KHVgOA/K7At9YA0L00pu2VVBR9oHyxVJZQDAVEyQeAVWLc2pQkV0rz7szTc5/23oBPlqKAJuCqzKISxt1UwaOEvwNJURGitPSUH73EZzg2DX16YRYvaOELpXSkiWH3HomTi776eij0pzyDwQDQfVH0OW8dE/QISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04JDe82H/WDi3rAU+fMpDQqHydgtkU00moQGzdYt0JA=;
 b=Xm3VS7l4ARUxLHY8l/9sLAsDyvYFVMOZhHAI+4tm6KHOqaVtvidVRAZJeB3OX1Lmo7oWzBl3hHnDtjQkg4VnXXVGff8u88GhNtEOTKfnfD3cbBk12jO5wQLw+NdFQFLujINZPhnOCF3GDLv+0fqgmVeCt96oL8uFfXV/8r7cI/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV9PR12MB9783.namprd12.prod.outlook.com (2603:10b6:408:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 17:07:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 17:07:26 +0000
Message-ID: <704f4e93-c237-422c-ae41-ff892a1c4a3e@amd.com>
Date: Tue, 7 Apr 2026 19:07:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v6]] drm/amdgpu: gate VM CPU HDP flush on reset lock;
 force-complete KIQ before VF reset
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Felix.Kuehling@amd.com, Alexander.Deucher@amd.com,
 jeffrey.chan@amd.com, zhigang.luo@amd.com, Harish.Kasiviswanathan@amd.com,
 Victor.Zhao@amd.com, David.YatSin@amd.com, Lokesh.Dhinakararam@amd.com
References: <20260407162555.65833-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260407162555.65833-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV9PR12MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6263315e-dbbb-4519-ec12-08de94c824ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: /X4qAhWWCdEieVr1fAX2Dt3dgnauHDPa9t1wkXA4IFUeHeY6n67wIufUNRl1t+ux1Jf7wORaBZaJ4gL5xExbGjPkfr0iqvOednPLBDrTptMM/yNwjnjUSQbhWMXgEqGrKIAPqJE/JSCM1bz0DbKUVxi+l3kDTXq4beE0AbluErfKWIYnrNrjdHcckvCyx8FYt2me87clTpp844bNSErCMz+AXkXRo7K0K+QXHBNulOufydQ4A0qbT0kE8Dl7jO0Xr6HMfwZ5q1ED5ZeZwhAMd5jvuVGV5pffnJbYbuvy+C+VawwHlvwXlpTvzIFfhzPUtoez95vJ2eeod3ONqTjRTS3aLgh1NaeBSvZ3jA6JEDok06/w2dxPl+1c7j/NCIRZ5sdylhvdt+uuEaX2rKOJK/wi0I/jRtKm+Z1v/4M3Y5atRC8E4slH7sP/7+NUL3n3UXmiBK2lhHnqiIdEPV5a9aAAamX3z1eC5O0dOFoSGj3hJiOx5GeIjy3rj5cQewU8YLjzui2yk/6EeJm/Uc0RPCACuGwwWWaX7+ex/HBAyn1rWDVT2tBP/F8gYzUYgaRFHgHGb6JWkeftb93ytq0TK6P8l7qTp1UfUH/R2zxtNa2CSjZblY2iyrIcqAuNW1kP81EvEo/wqHt9VI1FUCApmF6EiHtIWpZYHq0J/szQbgtzYUyN/CZsRgiui5k4lxP9shAwI9i3C4UV/97PAdXlgfhCEnlQsMxPnepLYo3oqEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdFQjlZYVVqVVA2blFSL3FHNkxoUTdtQm1sb2RIellWVXgvSlRkTVE4OVc1?=
 =?utf-8?B?M3YyeHZ4Mi9mRUR4RklRRE5uU01TQnBDSlhJRVkvdng1VlVBdVdHaUFXN3Bn?=
 =?utf-8?B?ejRSOW0yUlRjem5jb2E1M2VIZlJFVGJRenhhUmVZajJsRkJVclJVcWRQYzUz?=
 =?utf-8?B?TjBiU0szaTZUd3htT3NqQkxibFlPUzJwMU0yWjhaUnZ4Vm1rbnp0QzZKRVpp?=
 =?utf-8?B?SVRsdWdkTmVtUDFIamJGeUlUUmtYL0g4NDdrNVNQOEhNSFd3WjZtbWl0cVpQ?=
 =?utf-8?B?RmlhQ2dKQWxSTTUyLzlibWtRcWJzWUJ6VFV1TGV4RTNWZU5SOU4rR2ltQ3Yy?=
 =?utf-8?B?czcvcTZ3c2ZNSlBvcHpPK09SVFVoU29mc2lYa3JoM2luN1JraEVmb2NyZHk3?=
 =?utf-8?B?TmpJU3RpVjdEU2RGb05MaGxUZHRRc0FwRko3VzV5cHVGcms5NUdzUU9waGxS?=
 =?utf-8?B?WWg1Sm90Y0VyQjQzSzJlakpNcmJzY2JQcStTemZzdG1UOHp1UVc4VGduZmpi?=
 =?utf-8?B?VjgrRnBnVFZoTCtYKzlDWUtabGxxOHp5RndRNTlCZktNL2tkMWpBVEppQzRW?=
 =?utf-8?B?bnFVYUVoR2hVWGhsTFQ0b0p4S2s4Ni9KRlgvaXFHMDBEU1JQQmlLVFM1ZmR2?=
 =?utf-8?B?anNBb21NVmx5N3NHZE80Qk43WlN3bEFxVG9WeVpFZW9ocnZ6QU5LZUNPaTVs?=
 =?utf-8?B?QVpSTFJ5bEJBRk1KMnlCSDE3Mlk1TktjbUNqUmVZaFBoQldPZm5IeG5zbHRy?=
 =?utf-8?B?MGhqc3paOG1SMHJmbTBDaVd1N01hS1ZmdU5taTh3cnJkbzRDQkI2OUJRSG9n?=
 =?utf-8?B?QS9sT01KNnVWaUZYaXpIdytmeXhsb0YvWXNhajk4T0MySTRHd0NwL05SUERK?=
 =?utf-8?B?ak45MzM4RVl6cDJCTGFQd3hHbm4wajFyQk9LM0QrbWNxMm9HMzVwWWZxKzF5?=
 =?utf-8?B?c25nU3p4VzBJQ1lpUmxSUTF1U0hQVFJHMWNIWStGQjI4WDEyUm85ZmFJRUtp?=
 =?utf-8?B?di90dDd5V2xjZzV2NE5Db0djdzdDaWZLTVZjbmhINmdqYjhMU3M1dFQzOXBJ?=
 =?utf-8?B?WVAxL3JsRkNNOURYUlpaSXByQ0FqNi9JVVhmQ1pwdmVQODd6RzliWDRBYkhX?=
 =?utf-8?B?RkVBZEsvcXg5akxWMlQzdVNVWnh2Q2l5d1JVYnlyajF2dkVRSTFYS2FkK0pU?=
 =?utf-8?B?eU1qUVNmd0ZXTXdBbEZOQTBtMWo5VU5ObDVNd0ZtT1kyZHNPR1BFSURyaC9q?=
 =?utf-8?B?TDE5OGIwWG5UcTNnWjBHclAxWWdqamNWN2NGZVpjRUdrTDRYaDZYOFVYSzFp?=
 =?utf-8?B?MmJIOWFBY3Vnc0ErRGZXMFpNdXpicFE0WFNLS2dXSnJHTmhCVVZxQjhtOU5r?=
 =?utf-8?B?bE0yeEVPWnp3MG9qOG1oQ2V1ZkRwTzR2Q2FkQWRxWU1EZmMrbk5XSWpjdkIx?=
 =?utf-8?B?aDAzYytEeS9SMVdjWDROaEdWWVRVZHVSRXUxd1NMTVdISE9KM1hDeHNibmtL?=
 =?utf-8?B?MzdaTmdHR1pIVFlSaUJpTWkvVDZwc1llamEvcytOV21rMVMzaFZnMGtjM3Nx?=
 =?utf-8?B?bHBCa3NVZTRiQ1QxZ2ZzU0V3ZlVLNWZWSGY5WWRETkVKaHNrU1FFTmRydmNS?=
 =?utf-8?B?ajhSTDVEekFLZUF5S0RhOXdUamRUTTBmUXdxVFVYWFVKR0V0eW9CTVByQnln?=
 =?utf-8?B?WWVQc0dscXE1VGowZStmQWd0MkFMcXdoQnFLTUJ6N25qTDlvSXlISzhvL2dQ?=
 =?utf-8?B?WkVNcFNCT2NKSTUzaFZKQ1NrM1RTZWtiZmZUa0syQ0xyYWw0YnNMY1FqTVpS?=
 =?utf-8?B?ZTFIbzZtRGlpQWV0NFJDb1E1NWFaeXVvckFJb24vMWFJSGxZdkV2MEVFTnBt?=
 =?utf-8?B?YUxoL0NKWFNOUzd6OG1mbTVmeGZyTStyS2o5bXpyL21Tcjdqa3lFK05lV2I1?=
 =?utf-8?B?SStFWWR6ZVd3T3Q1dzFkaWxNc2xLenNZQnBOZ1lCZVRYaG10c1Y4ZlYwOHlV?=
 =?utf-8?B?bDdzWFI5aGUwNERvZ01adktTSWZLU2Y4bGtHVGVmS3BVSXl4ZUxBTWF4WGll?=
 =?utf-8?B?WGw5NDREL1lRYVB5cnlhL3dLa29LSXVjdHZjelNIMHp5MXA1MXRGVkI5TU43?=
 =?utf-8?B?Q3pRT0QwNFZxNHdQNmxpNFhSa09FOFFkQThlUVJFVmpFZEY5MDhxSTNVN3lE?=
 =?utf-8?B?ZWlreThIYlNmWmQrUUpVb3FyaWpGeVZrZi9oeGR3eUtjLy82cUtzSldNd01O?=
 =?utf-8?B?UkJsbXpQN2dhZ3NKbEtjT29Zek9lTDFYTmE3YVBldE9zbG9zL0s5a1lvOW9r?=
 =?utf-8?Q?NS7iVtrUx1GWCiljZB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6263315e-dbbb-4519-ec12-08de94c824ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 17:07:26.6450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTCVMdpElIWzP21bgkzdh+IcrbpdOkyXik/KG376/jLbI7s86ucPGYMyH1LL7YCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9783
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

On 4/7/26 18:25, Chenglei Xie wrote:
> During GPU reset, the application could still run CPU page table updates. Each commit called
> amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
> That can advance sync_seq while the GPU is being reset,
> leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
> to time out on later KIQ use.
> 
> Fix:
> amdgpu_vm_cpu_commit():
>   Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
>   If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
>   access (including KIQ) runs during reset; state is re-established after reset.
> 
> amdgpu_virt_pre_reset():
>   After stopping the data exchange thread and setting MP1 FLR state, call
>   amdgpu_fence_driver_force_completion() on each initialized KIQ ring so pending
>   fences are signalled and writeback is aligned before reset proceeds.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 6974b1c5b56c2..0127b0d6c7277 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1188,9 +1188,20 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>  
>  void amdgpu_virt_pre_reset(struct amdgpu_device *adev)
>  {
> +	int i;
> +
>  	/* stop the data exchange thread */
>  	amdgpu_virt_fini_data_exchange(adev);
>  	amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
> +
> +	/* Force completion on KIQ ring fences so pending fences are signalled. */
> +	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
> +		struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
> +
> +		if (!ring->fence_drv.initialized)
> +			continue;
> +		amdgpu_fence_driver_force_completion(ring);

Well that is unrelated and clearly incorrect. The KIQ is re-initialized through a reset and should *NEVER* be force signaled.

> +	}
>  }
>  
>  void amdgpu_virt_post_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 22e2e5b473415..a9e33b7e87406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -21,6 +21,8 @@
>   */
>  
>  #include "amdgpu_vm.h"
> +#include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_trace.h"
>  
> @@ -108,11 +110,23 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>  				struct dma_fence **fence)
>  {
> +	struct amdgpu_device *adev = p->adev;
> +
>  	if (p->needs_flush)
>  		atomic64_inc(&p->vm->tlb_seq);
>  
>  	mb();
> -	amdgpu_device_flush_hdp(p->adev, NULL);
> +	/*
> +	 * While GPU reset holds reset_domain write lock, skip HDP flush entirely so
> +	 * no HDP-related HW access runs during reset;
> +	 * reset re-establishes consistent state afterward.
> +	 */

That comment explains what is done but not why.

Rather use something like this:

/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */

Regards,
Christian.

> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +
> +	amdgpu_device_flush_hdp(adev, NULL);
> +	up_read(&adev->reset_domain->sem);
> +
>  	return 0;
>  }
>  

