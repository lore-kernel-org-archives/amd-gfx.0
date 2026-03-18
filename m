Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C634FCD0AD
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 05:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C08410E5D7;
	Wed, 18 Mar 2026 05:20:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t0n6Kq8o";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9753310E5D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 05:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9fxyQ1oehZkzhgYq0CPATRq9Oqh6DZrA8qwpyzk09u6FaG1xP1+8Uw9WPVZEykT5ty1FjA/6NKDwhKFHWaizjeyX4OU38vE4OtHtnOi+WGldT4xw+yLBTUvonSylzd4j63IaESmGPIUWbMNx013/O5Dtdyhi75LnOuTH7myH2HguwLCQESLwBI08XKrRVGBDQuRISN9j/KTPgO3QlEYkHuz3hFM3WLGpCaX7uPYyDjLuqfsXtniMIE5/LG6EqQllJT4ORkyxxtJ1EXF3hdGUcKGcjYJtB90d+ulQKdPy5Hsj92HTQ3F6gvWLMxjs8AvQk1WrVAgXpTppVAcwCAR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGO6CRxDxVAJV1kY7RgwMPGD/lLzbCSn90X48xEfxYI=;
 b=SOQRlOB4T59IDnYeTAnGVg0S9k2dogTiMhfKXqTbp3oq+EaCcHyMPrcB3Ma69XmFPEapYHRtHQ9TUHYVKFDgBahvAbytJL5/hIse5uRTvF10SsfRne2UDlf6tkxkMUnd59lbozbgp1w9QEYX/g3Ky2UB/1j8cN91KL+aYsRzxPdyOnAp9U09H+96pLVwCe6z6RiEtjw2HtjVt6k+daqaDvsBsKrWe+34Boozs9/0KaQrVa/mP+ZzynvhwlOPLG/fzDS1dAU8AyuT7bRB/dWxJTALIphZzv++pzNUFDDyID2ElHvgSEXYehtb+2yXP2Dj6uprwm3wpgBwLFe3+nmCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGO6CRxDxVAJV1kY7RgwMPGD/lLzbCSn90X48xEfxYI=;
 b=t0n6Kq8oE1CYzrjjeWp5VD8OenL3v8nHimW/2WJfBvG8yctOlvAV+YwrYCK9/PsL5dbUzB19j8Nm4gVyIAM5VXa6eOi+NdmnorfYOv9l+Knp5xICVbT05ehbl7T3OFJXBegBz4Q7S/OxL1jJJ6FSoyW7dCAUlh1L4PcuBlrVFdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 05:20:54 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:20:54 +0000
Message-ID: <de329f70-259d-443c-9691-1a7e85cd266d@amd.com>
Date: Wed, 18 Mar 2026 10:50:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid NULL dereference in discovery topology
 coredump path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260318044734.1975271-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260318044734.1975271-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: a3988c31-fb64-48c8-cdc5-08de84ae1ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 71ZnzSbsPoSnogHer8DnTkHxfSM2oV5wwte230KiJlvbB9Dd3avWSGulk/3wk242XTkUrGVIVZk5TtROYlyMndHEiJUSlDInwSNjeVmHsc2E5xw45BwOxPujtlksHJGNKma/iIKRPAmTylKgjwY91G71B7gCM0s22+9NACP/sQRcsvNcrBpc+wBXvRzt09UxUfrC8eYH1WDNW40I3gyHsG0KRgsIwEqTaCWuXwYybMlxjhr4iTnVHspSEmJgH26Tdsxx3qmzROCNB4kHu4BYtJtwkcQnW8JpnRXSfLKQcGJiKbMaqi6EezrLEHIbnujJwwWvMegfOLQ/8brsCvKeBMiuL+eN0ef7mLHW5V/t4QJdNjis74SEtCaRaFMpk11tVW3RM/SXaBuwnbVN98JYOZSzIzsCQlrNujyfDRn4E+R5mVzPBCQykqqS80bp9ujt41XmduoCIKfhcJ3zY/y1QKKGdssXXbK9m0mmCdjFRgZwwqfn4ydUrli9CfNKMLxvZmjLZZsf61BNdfA6rUZJFdPk5FmCROUcV4g+feqdqLqyHRn9Fd7aflx1B+5NeQeNpWichch8fQTp4Z5qo48ZiZ72dSf+t9i6C/kuz7RW5c/rPq2Te68/oU+tI3rNXvUgmRT+HyU4zKYq2+FLLM4yocMwVpiXM6UbLnxTaRbcPtadTNdLkuy7EUDS2zsMqCGt1pWzo4aDsUI3v8jQCsb6IIvKTo34M3i3YGN+PXfHRhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0R2MzlMd3NYQlcyNU5CdVJxMGFOdnMwUHJGRUo4UlhVWUFWelg4MWtYMHJ0?=
 =?utf-8?B?QWZQbjhGY25GQlVxdDB3ZzJLek16K3ZEUFZzeS9VRTJwQWw4QTg0SXQydmpQ?=
 =?utf-8?B?dWdtV1lnRmgzRGVZSk1MdXZHY2ZocDdPamFheVBSaVFEejNIOEhiVCtsSWlW?=
 =?utf-8?B?b0NXazFWdGFjNitYOTFlUk1lOWFmY05RbUVPVzRpZXBHeEhTTER1ZEFDak5S?=
 =?utf-8?B?ekI0YmVIT1VDa3BkZ1l3NTQwRzI5MVpwVVNCNmJCWUtpaEVtSDFObjVZTEdU?=
 =?utf-8?B?MFBCVithUDlBckNEN3p6ZTQ1ZXdXYWpHY2szNThIWHhZRGMxb3dQTDJvdVI4?=
 =?utf-8?B?MStDY2JDd3NvWi9wUzd4dTVteGNReEZ2UEpkU2toNDZCekoxVFJEV2ZUOWZu?=
 =?utf-8?B?VFJJaVUzcW1KMkpXRDJ6TklkYzNIc2xLVUxOeGVSZmZZSS9YMEVUajQvYVky?=
 =?utf-8?B?TE96THRNbVNHS0xTQ093eUpwcUhLMCtoWlRIdjRUSEpveVFlRTl0aUo3Mkt3?=
 =?utf-8?B?K2dUN3BwaGQ3dHYzaDFGQ2dWQ3pESS8xcWFVdGZsRUF6U0daTDdPaHgybHJB?=
 =?utf-8?B?TTlVRlptakc2SlBWSTQ2a2ZhQUVXa1dCbCt5RkFWWHVWMzBQZWN1enlUZ3lq?=
 =?utf-8?B?UDA1MWhacGJvVVNnT1JzNUV4Sk1RSGsra0FsNm51QSs0MWZFTy9RWnVOY0lt?=
 =?utf-8?B?cGF5Si9QWE1VUHFZUXRJSUZncm80dzNKTktxeWl1K0tPdUF5RktFZHY1TVlx?=
 =?utf-8?B?SHkvaytWTVNuVE9KOHRCU0MySUFnam41QlNLcUhpK3RPOU5LOG9ESkhvdlVD?=
 =?utf-8?B?VUtQbFpLYWlGWXhlRE9kTk03RUdHbVhxdFFZVjBaNHhKK2R6Y1FJNng3M2hZ?=
 =?utf-8?B?RjBDdHh0aDJpbmRObFZvNVVRR0NjNnp3Y203WXpnV2xRL05kaVZyQmhSYXBG?=
 =?utf-8?B?b29FY2p0OTBackpocEg5eUhYcDdoeXhLTG9HSWNON2UyMU1PUEJGaEV0MFdP?=
 =?utf-8?B?VjdVaTNNZDREaklMM09HdERRTjdibkVHOEw4enI4dEVybUVRWDlYLzZwc2dV?=
 =?utf-8?B?YkkxSW1xaHVEcFF1VnY0RDJqQklVck1NQ3lVeWdpaG1tVlVMTjYvWnR4c0du?=
 =?utf-8?B?emtNRXBTT2FXd2tNamN2R0lWQ0d3ajd3Unh6MUp0Sy9sMUUyTTNObk5PY1lr?=
 =?utf-8?B?ZytoaWxCSmdJUGJ5SnRnaDhwMkZEOVNNdHpHbnRsZlZJejRGK3c3WWlsMm4x?=
 =?utf-8?B?TFRLMzMrTi80blFsZjRrMldmRStTMm43WWdKUCtKcW9qeW9FUHBmR1hDaXJ5?=
 =?utf-8?B?ZHJmQktBWjdtQTRNT2dTYWVkY1VybEJkcTRaNjU0K2tmaTc2K1E4MS9yNXdq?=
 =?utf-8?B?TER1bS9FWStiamdHeks1N3RVSm94cmRrV1UyNnB1WEhCSGNTNmMzTEM3QS93?=
 =?utf-8?B?ZDlwVG9laUxvSDFvcjRrSi9CYjVqN2ZzWElhTVhpN2txU2FsQlVteXRjdnFS?=
 =?utf-8?B?KzZsUHc1a2NrTW5HaFd4c1A4eFk4SGJDeVEzU3hLOXp2NS9PTFE5VE9uWEhX?=
 =?utf-8?B?TzNSSStoNDQvZEg5a1dsWlJOS1IyUTh5RjBKM29Hdi9JMnZQVzRmbCt4TVRG?=
 =?utf-8?B?am8xc3RNSFJ4U2ZnckFTbWRudlpESVpmT3V2V2hpWXhrczhKWjRaRDlvTE5G?=
 =?utf-8?B?MnZjMyszU1d1dDAzd3NEbkVBMHhJYTR5VVRuL29RLzRoQjVtSFJtWWx0YUtN?=
 =?utf-8?B?SG53MmtFT0NjMTg1blFxa0dYcHkrVVBTa3B3Uml5SzNsV2h5VGxpbUVWazdZ?=
 =?utf-8?B?SUVNZHFsOXBlMHYvZm1wRXdDWkUra0F0S2pXK2hnVit1WkpHaXZlZnZOZWJ3?=
 =?utf-8?B?WFBSY0lXZmwzK2V0WWx2eU8zUnVJQllxVHNxSkZxODRNRUxvaTRGaWZnbTJZ?=
 =?utf-8?B?MXN6cDRwWDk4Qis3eEhQU21oQSs1WGg5NkZsNy9pQ2xmdnlObjh4VjBYajFp?=
 =?utf-8?B?c2ZiakRFMWl0dnlNelpmdzJ5bnplQm5DMHlMQmpERGtKejBsZjI0V2NQcWNY?=
 =?utf-8?B?aTZNUC92dFAwVTFNbllIYnY1N1FhcXpoYXNoeFRqbEViZjNLai9Cd0JlNXBL?=
 =?utf-8?B?Y1EzVVNvUVpGU080MkNtMDc2VjJYSFNoL2tMaE4xMEtIVHdGMGI2cmh3VnZR?=
 =?utf-8?B?MUl3bktrZlpmazdvV0orakNZSGI5enI3OGs4M2FlWk93YkVmQWRQSHdRNHlS?=
 =?utf-8?B?TnZSeWlnYjZBblZRenZnVmZZNXNkM1dQakNhR2g5RExhcERnYkUvcDhBRzJX?=
 =?utf-8?B?M1VlNzZ3YUthTlBqRnlaV01QU2xWaFg3cldiTERvU2lTVkZNL1hEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3988c31-fb64-48c8-cdc5-08de84ae1ff3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 05:20:54.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8453hbD9JrITBzBCynh5mkzLc97BrOyaVtl1QudmT6HBt7rqKKuFndBkciuo48j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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



On 18-Mar-26 10:17 AM, Srinivasan Shanmugam wrote:
> When a GPU fault or timeout happens, the driver creates a devcoredump
> to collect debug information.
> 
> During this, amdgpu_devcoredump_format() calls
> amdgpu_discovery_dump() to print IP discovery data.
> 
> amdgpu_discovery_dump() uses:
>    adev->discovery.ip_top
> 
> and then accesses:
>    ip_top->die_kset
> 
> However, ip_top is not guaranteed to always be present.
> 
> ip_top is allocated separately in amdgpu_discovery_sysfs_init(),
> and it is explicitly set to NULL in ip_disc_release() during cleanup.
> At the same time, devcoredump generation runs asynchronously in a
> workqueue. This means the dump code can run after ip_top has already
> been freed or was never created.

This is the only possibility.

if (adev->discovery.bin)
	amdgpu_discovery_dump(coredump->adev, &p);

Otherwise, there is a bug in coredump logic. These files are for sysfs 
topology and they are expected to be deleted only during driver unload. 
If coredump is happening during unload, that is a logical issue in 
coredump logic.

Thanks,
Lijo

> 
> The current code does not check for this and directly uses ip_top.
> So when ip_top is NULL, it crashes while taking the spinlock:
> 
>    spin_lock(&ip_top->die_kset.list_lock)
> 
> This leads to a NULL pointer dereference in the coredump worker.
> 
> Fix this by adding a NULL check for ip_top before using it.
> 
> - If ip_top is NULL, print a message and skip the dump
> - Also add the same check in the cleanup path
> 
> This makes the coredump and cleanup paths safe even when the
> discovery topology is not available.
> 
> KASAN trace:
> [  522.228252] [IGT] amd_deadlock: starting subtest amdgpu-deadlock-sdma
> [  522.240681] [IGT] amd_deadlock: starting dynamic subtest amdgpu-deadlock-sdma
> 
> ...
> 
> [  522.952317] Write of size 4 at addr 0000000000000050 by task kworker/u129:5/5434
> [  522.937526] BUG: KASAN: null-ptr-deref in _raw_spin_lock+0x66/0xc0
> [  522.967659] Workqueue: events_unbound amdgpu_devcoredump_deferred_work [amdgpu]
> 
> ...
> 
> [  522.969445] Call Trace:
> [  522.969508]  _raw_spin_lock+0x66/0xc0
> [  522.969518]  ? __pfx__raw_spin_lock+0x10/0x10
> [  522.969534]  amdgpu_discovery_dump+0x61/0x530 [amdgpu]
> [  522.971346]  ? pick_next_task_fair+0x3f6/0x1c60
> [  522.971363]  amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu]
> [  522.973188]  ? __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu]
> [  522.975012]  ? psi_task_switch+0x2b5/0x9b0
> [  522.975027]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  522.975198]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  522.975366]  ? __schedule+0x113c/0x38d0
> [  522.975381]  amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
> 
> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f7f37d93d0ce..40ce95a604ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>   	struct list_head *el, *tmp;
>   	struct kset *die_kset;
>   
> +	if (!ip_top)
> +		return;
> +
>   	die_kset = &ip_top->die_kset;
>   	spin_lock(&die_kset->list_lock);
>   	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> @@ -1419,9 +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
>   	struct ip_hw_instance *ip_inst;
>   	int i = 0, j;
>   
> +	drm_printf(p, "\nHW IP Discovery\n");
> +
> +	if (!ip_top) {
> +		drm_printf(p, "ip discovery topology unavailable\n");
> +		return;
> +	}
> +
>   	die_kset = &ip_top->die_kset;
>   
> -	drm_printf(p, "\nHW IP Discovery\n");
>   	spin_lock(&die_kset->list_lock);
>   	list_for_each(el_die, &die_kset->list) {
>   		drm_printf(p, "die %d\n", i++);
> @@ -3028,7 +3037,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	}
>   
>   	amdgpu_discovery_init_soc_config(adev);
> -	amdgpu_discovery_sysfs_init(adev);
> +	r = amdgpu_discovery_sysfs_init(adev);
> +	if (r)
> +		drm_warn(&adev->ddev,
> +			 "ip discovery sysfs init failed: %d\n", r);
>   
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(9, 0, 1):

