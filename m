Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B6606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lajUAK0o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5298010E4DE;
	Fri, 13 Nov 2026 13:01:34 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E83410E4DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URUbxMeSR95EX5becxnldHbjteO+/gbdL26vuaHE+Q8pc6hrWuuHfx3Hk5PzDL75bDoXpCt1+5ZFyORm4rmPYzYS+tTrbXDpSDHR1MfZ6/l+jd9dZL4Od7CK+cANmhPWyRDJDmpW+jaqxMOw+atoO1S/nNzCGwtLmxce4cw2H0c3s+MCJOIhzm1zZXIW+pUc+p9oz0emom3E5hni7myDJqQXXGiwTRlIsasrSJI2PwMicNUe3AzaynhqyAdsgZNuQ8+bxTnVCHYJ+mq17ADG1oBwQf9ExNnSVYbHo9kRzKCf6D12MIWQYGmUNj6IWncIZXt3qiuq8XMCuXsKevQ1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haDzY/XaZAaNLJpE8ijKW1n18ltmMyZVmcAmJl/Wt6Q=;
 b=jVDTjbizehCOjHVijDerBxv2hvELoBrWw54RnJDtEKqQSOkD+srjWUe7ejX8+7mzWAxX7C55QcBCnGlXU1K337cjbXxSLVISh0Zby1BVX3s8KvuFxjmsbwqvpvn9FZn7XXreVYodDSu/LJrCMlu44Bo204dw/P358rsM9Iw5xapGQV7IQN1ovce4SmOq5vmeFAzjsh8ATgTI0E1/k56/Vrd7eYsJRLlETLez631ctojloF30/uuar79dxUROxUWr1ozLbz7BdCXqlMaH/WgwAxzbGVp9/rSLPZeoX5a3apMIe66jU/p12YVwOC3DvkxzNo84KdAGuAXvq+RhJ/+qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haDzY/XaZAaNLJpE8ijKW1n18ltmMyZVmcAmJl/Wt6Q=;
 b=lajUAK0o16Nf+aq1iaSicQDrTot16Ap1uv0acGj6/YLUJFwljm8TUJEcjShn/Ij+kx2rebuPznmWWSaJr6Ga8cwN9tBNk/ENahG/e2HpVPjWN8Jk0dhrYFVPIyk17Dvl4S1xr3Os6bgkWJ3r2mkL3/2SsKRhgXxb1H25UEriVNU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:01:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 13:01:13 +0000
Message-ID: <45233c92-9458-4a3f-9b1c-ae3a7ef807ea@amd.com>
Date: Fri, 13 Nov 2026 14:01:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: bring back the ring parameter for
 update_spm_vmid()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261112214802.1774412-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112214802.1774412-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: e10d0cda-0034-4790-29a7-08df41863175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Ipk1sFlSI96lYBTyGwHGVfrd9ArXh8fkx1MJvnAy761DBmsWnZC5fThjQyY5AzejLyxl3m43R0CmljHkIYCJ3aRXarFa1PLigJyP0hg8qMyCxHDpW4ZX+RN5wKT0t9IB28XSfYNOe3SYyH6iCyPi4pR61xljjwESJsqe4AbXdQ3k5t1T8HJUF70NvybqgXHlIzhgRTZHCFkcrXGg2R1c2ucn7nO0IeuDkqEExzJdc/Ni9sWBNPLbWjVeXNYe2vSLCxbZOyWQhKqpqcPEHjmN/JzO2lQiIBR0a7IH4or20HJhTOXhsd4HaVCRNxcoCUPbGbriNBpgV3H29nhxACnsEaN7X2SIg6v7cQjyP2fQX/qscnCPA0Pz7k94eKnjf1V5+YJi2Psx70Odl1KzXdRSizKapo4mIXH5BfTOb2r+/W2nzO1wy03DPX0Fp2qLEJWfTYkaNZjGRIr546omE0Hr8GAQx5CtNYEE1Rz9NPyIVK+ylZyEYn3XM9+O8eWd367OJgRGDazWBAa/8Ri9yp1Av6F420bgDgy3gr68eJcag00ap5GmW437rrMe901LTVcoauSn4MQUnysW5+PyLuSxADxNOh2ySRjfwIwLYDlr+TsJyWYwlC7R5WQbSxEv3qjKNc20SJ5gnYKSHSWOgoHIJwp6SeokhrIEz+0M4tf5yPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRCbEpZOFJzYndOeFFKVzBUVFh0VDl1NHpKKzU3eFBVUVcvckNOVVRmTXRs?=
 =?utf-8?B?eWk5eUFpUTZna21YQlpYZzd3ZU8wY1NpN0Rjc2tsdHB2TC9MQ2x3MldGTWs5?=
 =?utf-8?B?Q28rQ0ZDdFRpNnQvTUQySHJLdE13YTluVEdIVFMvN3NYelVSbGRzSy9CRjEy?=
 =?utf-8?B?T0tnMzdHNlN2R1VqeUtPSFV4UnYvZkNTTDN3K0FMN0M4M2FGMDd1RGFJR1cr?=
 =?utf-8?B?WFV0bmpmNXFaNWFmTmRyTzlQUUM5N2dENkRDbW45M2NKTUhzUEt0VjFRVCs0?=
 =?utf-8?B?R1BaWmhMdzZvU3NocXk3MjdBdXhOd0ZQUnV3UWhwV2MyRmhkbVoxVGJYT1F1?=
 =?utf-8?B?YmlOZ05tcENZckhPUEJBM3luMStycGJ0S0dFSTNzMktEcDgyMk5SU3dDbzl2?=
 =?utf-8?B?aWRPYmRpUVpiSzBFS0p1QXhNRThxVWFvQUhQbUxwTUJxeHYyR1Rqcm1YTGRD?=
 =?utf-8?B?MFZ1M2pGNXgvSTdWQlhDRGp5TmUwQm1HYVR1YjlxM0syZ3FYbjZKM05Pays4?=
 =?utf-8?B?dkFUZm5WK253TTk1SFVnVWp1ZzUzZGVBc2pXZUdoclduMG14bEwySkM4RENM?=
 =?utf-8?B?K3NuYVdTRnJ6cHUvbzZQa2Z2b2Fjc1Y3QzR0dWdMeUxZdS9USWlqZzRYSlBR?=
 =?utf-8?B?ZkFEQUhiYldveDdua1B3MElyRzNFYU56TC9tenFIVzRwbUdKeHgwMFRWV2pU?=
 =?utf-8?B?QnNvUmVUVGovUnpiRjF0Nm5wWVVMRDRJbHZ3TXFlUjc0THJWWnBKZEx4cnMz?=
 =?utf-8?B?MHBCQ3l0SnppcGFIVHFxNm1qYi9nT3dCYk1YMEdLcnMwbUVMcVFHQ0hPaFhr?=
 =?utf-8?B?czVpc1Q3Rk5YcmlObjZUSkducXcxdWJRVDUwVkIxWUQ3NmlYa0oxaHR3Z09a?=
 =?utf-8?B?SWZ3VTdtUWlWUitoK2tIS0hzNVFFSVVNSEcyaDFkVWM1VWh1clhKYmM1SlhC?=
 =?utf-8?B?L1JIa3RJNkl0VDJFbm1mSjc2d3lXVm43YklRWWVNMUYyTHdsR2t1MUtSMTJr?=
 =?utf-8?B?VHFpb1o5Ynp6RElaQVZVNDdndWFVRXNKU1NsNnhid2lEdktlUmg4K2xGMmxv?=
 =?utf-8?B?ejJzUTBBb0FlY1d3SzRWT1ZzSUFLYzJzSHduM0grS2t0VlpweUgwL05pbUU5?=
 =?utf-8?B?TlAzdzZCemdXS1RFSjlkR2hINy9rK1ppQmtrb2dCeTZJUlk1N1RpLzd3KzdC?=
 =?utf-8?B?ajYrTWFtV0xVT1VLckNyVGwrOXJyMDlEemNGWWtVRzE0d3lLNEJkLzRzTDRC?=
 =?utf-8?B?ZFV2RlNkVTQwTjlYb21Id3pxWjV3N1ZtRGpOaHNacFo5aTZtME5DQkVzb2xQ?=
 =?utf-8?B?T215cjd1bW5pVE5TMmtyeDRFR1dTVi9Ha3lkMXFHWmZCMnYvb3phR1R3cGhB?=
 =?utf-8?B?SFp1cTJnZmV3d0t4Nkl3TzhQTjhXMGVySE5oUHprSFpWMk45QWpRZzg5RnYw?=
 =?utf-8?B?WTZFUzhlQXRKMi9ha205TzNWVEo4SVFqamp0RVlkVFRTK2g2Y2lqZE4ybkFS?=
 =?utf-8?B?aDNoRVJEQmNrM0k0b2ErUEtQNDgwbzBQWnFDYUFOempXeGJMbGMxOWlhWEdI?=
 =?utf-8?B?SDllZ2JSQXlNMmErN21Pd2ZDWjRmc2Y0YUxIdnVVMFNQbDBQbElsY041TVk5?=
 =?utf-8?B?WjR5K1FuMDdia2tQRllZaFBST0hlWE5ZNlRvVWFsUVhSV3FEdUc1VlNrVkpn?=
 =?utf-8?B?aFNMSHBSRHpodTlDQkdVWFROOFhvM2VMNDJRekllU1YxakJMcDI2akZFNXdY?=
 =?utf-8?B?ZFZhZkY0czlaOW9hbGtUTnR2WSt0YkpsQ0JaL0JXTEdMK0FhY0Y2NzdsYk10?=
 =?utf-8?B?YTdVMXYybkJYYTlNNzVvdUhMY3BveVJVTG9COFpod0E5akFlR2g3ZnFQVVh1?=
 =?utf-8?B?aWJ0MXRBVld6S2R2OVhCNDRMbi83d29oQ3Z5dlJPSXBzbnpjaTFBM0dJZFlw?=
 =?utf-8?B?eE5zSVhWY0pOTDNSMm1JUWwwaEw2WFQvTzMxSHczTzY2UU5waGhmV3Zleld1?=
 =?utf-8?B?UmJtRVM3L3hZR1psV09zVnhLbzVpRUdtVHJaUVh1aHNXbVdsdytoSVFEQnl5?=
 =?utf-8?B?d2hLaUJzL0MxZnhrTks5M05rR1Y0bW9OQU1vZXR0TFpjdUluWnNRK2dVQ2VL?=
 =?utf-8?B?Tk92a2I5eTZiU3ltZUp5cnI0ZmFhMXlHNTl3Z3ZlVkhpRllvTC9IbStXTDhO?=
 =?utf-8?B?ZzZJSEt6R1FxSitQYmVlOW51eHpUWlR0dlVaWjl3NzRLQ0w3TzhRN28wSEJD?=
 =?utf-8?B?T3lid2dSekVxSWhnU3FjUzNpRXgweVpYR3puM1d6U3JXZGpvb0lLK0wxTThp?=
 =?utf-8?Q?8yzVmO8ycAI5hGt/9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10d0cda-0034-4790-29a7-08df41863175
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:01:12.3899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jEwDmUCmAS9stT0ULPAYnVHGiONYYHwHi8iTKinhzgAsuou8JKeRUD7tqcNmtMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 22:48, Alex Deucher wrote:
> This largely reverts commit 90b1b26bb030d6c666f8cad52cd3d8019d404ad9.
> 
> Not emitting the spm update via the ring causes CI flakeyness on
> gfx11.  Add back the SPM ring emission, but skip the MMIO path
> if ring is specified.
> 
> v2: drop ring code in gfx 12.1.  We aren't supporting KCQs on 12.1
> so the code is not used.
> 
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB path")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 16 +++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 15 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  7 ++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  4 ++--
>  11 files changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 324d25c77897a..1ff5d5cfb141d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -750,7 +750,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
>  	ring->reemit = true;
>  	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
>  	if (emit_spm_needed)
> -		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id,
> +		ring->adev->gfx.rlc.funcs->update_spm_vmid(ring->adev, ring->xcc_id, NULL,
>  							   ring->adev->vm_manager.spm_vmid);
>  	spin_lock_irqsave(&ring->fence_drv.lock, flags);
>  	do {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 6210edf1937aa..a24cdf5852a32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -213,7 +213,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		amdgpu_ring_emit_pipeline_sync(ring);
>  
>  	if (emit_spm_needed)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id,
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring,
>  						     adev->vm_manager.spm_vmid);
>  
>  	if (emit_gds_needed)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index e38a8ea02c520..2ae2c1d0f702b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -292,7 +292,7 @@ struct amdgpu_rlc_funcs {
>  	void (*reset)(struct amdgpu_device *adev);
>  	void (*start)(struct amdgpu_device *adev);
>  	void (*update_spm_vmid)(struct amdgpu_device *adev, int xcc_id,
> -			unsigned int vmid);
> +			struct amdgpu_ring *ring, unsigned vmid);
>  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7683e8a0a4380..f226758b15467 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8187,7 +8187,7 @@ static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..ac814c12d60f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -363,6 +363,7 @@ static void gfx_v11_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>  static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned int vmid);
>  static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2606,7 +2607,7 @@ static int gfx_v11_0_rlc_resume(struct amdgpu_device *adev)
>  	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
>  	 * once it runs, also after a GPU reset or a resume.
>  	 */
> -	gfx_v11_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +	gfx_v11_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -5615,12 +5616,21 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 reg, pre_data, data;
>  
> -	amdgpu_gfx_off_ctrl(adev, false);
>  	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +	if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
> +	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
> +		data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
>  	if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
>  		pre_data = RREG32_NO_KIQ(reg);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index df2fb09bbcd86..07f981f27bcc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -287,6 +287,7 @@ static void gfx_v12_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
>  static void gfx_v12_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned int vmid);
>  static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
>  static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
> @@ -2158,7 +2159,7 @@ static int gfx_v12_0_rlc_resume(struct amdgpu_device *adev)
>  	 * The RLC comes up with RLC_SPM_MC_CNTL cleared, program the SPM VMID
>  	 * once it runs, also after a GPU reset or a resume.
>  	 */
> -	gfx_v12_0_update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +	gfx_v12_0_update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -3978,12 +3979,22 @@ static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> +				      struct amdgpu_ring *ring,
>  				      unsigned vmid)
>  {
>  	u32 reg, data;
>  
> -	amdgpu_gfx_off_ctrl(adev, false);
>  	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
> +
> +	if (ring && amdgpu_sriov_is_pp_one_vf(adev) &&
> +	    ((ring->funcs->type == AMDGPU_RING_TYPE_GFX) ||
> +	     (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE))) {
> +		data = (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +		amdgpu_ring_emit_wreg(ring, reg, data);
> +		return;
> +	}
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		data = RREG32_NO_KIQ(reg);
>  	else
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c044..bf69d71e6b065 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -217,7 +217,7 @@ static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>  static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>  	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -				      unsigned int vmid);
> +				      struct amdgpu_ring *ring, unsigned vmid);
>  
>  static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
>  				   int mem_space, int opt, uint32_t addr0,
> @@ -1866,7 +1866,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* init spm vmid with 0xf */
> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, adev->vm_manager.spm_vmid);
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		gfx_v12_1_xcc_init_csb(adev, xcc_id);
> @@ -2945,7 +2945,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
>  
>  static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev,
>  				      int xcc_id,
> -				      unsigned int vmid)
> +				      struct amdgpu_ring *ring,
> +				      unsigned vmid)
>  {
>  	u32 reg, data;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 72c84b61fda16..43dea0810137b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3256,7 +3256,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -3483,7 +3483,7 @@ static int gfx_v7_0_rlc_resume(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 4666aa5b38c75..360a958f7577d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1276,7 +1276,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -5484,7 +5484,7 @@ static void gfx_v8_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
>  }
>  
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned vmid)
>  {
>  	u32 data;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..0b01801b0571b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5227,7 +5227,7 @@ static void gfx_v9_0_update_spm_vmid_internal(struct amdgpu_device *adev,
>  }
>  
>  static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> -		unsigned int vmid)
> +		struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	amdgpu_gfx_off_ctrl(adev, false);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index da031caa4e9e6..30c8b751849cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1397,7 +1397,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> @@ -1609,7 +1609,7 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
>  }
>  
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -					      int inst, unsigned int vmid)
> +					      int inst, struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	u32 reg, pre_data, data;
>  

