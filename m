Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C13107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1031B10E76F;
	Wed, 18 Mar 2026 10:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFuUI5QO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FDE10E76F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM+xe/A1qgiFCm3tMSnfeR/rfCRXQPlCIo8WW/XF2cD58wrnY3uJc8aBisogFvS2dUc4vmhusn5INpgt+BVV6/M0ANfjSMJk7f9lHiDsxS4iweV2QW/G3l3g1smvxgUqL1vmD7vT02woKBfTi+k7iZ5Oc2gd+Ch1kCct6fQQAr1BH4dWmLoClaUtXZnIMXRF9biP/4GHp3L1WqKbIhOh7LQyXta5q1mBzyyYNYCGKNyjqtgunAmcKlOdPfw9YCAvXfGTEfdL6Q1z6WeDxxsnjEzNTN/ufvKbH4IvNlxr46h+Z0fjuWHgtWsGaQ0/RYKvsb21jt7Q9aHVCk2QWMlNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gXIkFa0CiHyJLyLUFtCADxZMiJA1fVpf21fGlSLEC4=;
 b=nwEIDw7l0nwcDd1Mm7Lj4Z8mItIqsdZ2Qgc3fd9dZS0xwEv5W710NUAPSShkQSpKiZ1bdOoglJv2wRDTum/wvW0jYpRVxhXsC8Y9MpMgJcRzM7ck51z831nsF5oZQYruE0Jy8aXcJN4vluyb+jh7vuL5t6qy8MgMxRVbbbvMrMr5GdCr4zgX1y3nw/iZOSTExsk3uc3xcHBaTmh2dWMtMLrsWgT8hhzgS+RUq7+ijMFV9K0W6L7aGlEd4EY4clZYM0O7asSEX73xM8hw/Foo+LC/eFzU/cSLRRhT5rANE4B+yWrZGgg99A1rwyrzQagKzdCo0eEG1Y+9xJndt/yuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gXIkFa0CiHyJLyLUFtCADxZMiJA1fVpf21fGlSLEC4=;
 b=NFuUI5QOXsR4HJqMnE0CGt/XZwqG5YxGAIitsLEWkcqX+8Su1faz2e44GbUrFhFfctGyPxUcRyLoGQtoe5L4IW+7kX/krSVZBXuUEtAlAXMmKYz2m3K2C1SkVOXt8tlqiOYy0nLWCb0icJcOUSidC3YqZq9eHjaRaOyHLfyKA/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:33:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 10:33:45 +0000
Message-ID: <3d062269-15fd-4bc9-9d36-ce47a11137e3@amd.com>
Date: Wed, 18 Mar 2026 11:33:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:408:e5::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 355b92e3-c5ab-408c-c6fa-08de84d9d4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ukYwnLpKx0P9mMl15vZaJBToyRqlxHsJao3qSr9ZtPkfdCAcSeVyh2lx+1dHVnfTI3cpcUTOp55aMtHMDl4YrBMqGZS7Tml9qutHjKQWQ3kFISJJ1jWtoDfE6/7u9CfZqUr85KzB1iUsmYLNh0V3oF86Xq9mJb81OUkuzMH+/9+pOzRAN5j75ApNUzbMpWvrr/NOYby9OhpzxAPn4XlwSUKnsiZYL8SN1J9HXgH0KPPNyFKzuIGJFVoPyD5lawX49SWWBHVfDQcv133DWw3nwkKkv9JLzU6UDN7hu3MWhl/bAuEO/YpmuBVtpYAKoGd3qtgncs6plMPBWjajPo42odY3+D2pZs+tGrJHqZfBBURZAVqKMPHHp7CiDJZewuXcgBCbdH5pwwv478kDJheFbEZs5ufOZWCczJG29BwPUTSqiXSMHepQeafclNnUXxvSDkdNCbgn/vgfLxyGj6tbs6vbO6rsAt8PNhsiQ0tMlLcLS0rcUPejW7mY8Ec2sbP1b2YJgbni8EwjXSnwHTD9/OQYWkjxvQFjgdPAydA4y3qcK0Z8hUEZkY1+t/BS7o4Puvw5Sg1KmV+RigxWirFewol/Gi8dh0AEITBsk9C0rvmIfSfU7X0Zc4E/cTB39YLLQFJzE5XoCUkO0cRsQqw6sNo0gDSxUpqBJbYMtXa82OsiH15nqOwXJH6mdXRDtpM5r14zRDVkeMvRg+spooCuAejuH6Xd2PFgYDZFZb8pE+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnppMUcxRTZZTlR2ZHRDT3ZFTngvWHh1SFVFUkY5VkVpY0tTbTFFQXhlUjIv?=
 =?utf-8?B?aTJ2Z0xTZUdDNlZ2SVlDUE1QN21KOWg2bDVqcFM4NitSaElrNHNMRGpqTytD?=
 =?utf-8?B?VU9CZ0lTMURDendLdnVDOUg2VnozRFAwZG5sWC8ycHdCekhaZ0lYb2UrMVpx?=
 =?utf-8?B?NVR5Z1JleGl4UzlYYTI0QUF1K2ZrSlFNWU5LUFJyWVJ3c1ExdkNhSEZJeE5Y?=
 =?utf-8?B?SG93UHUvTEFMbi9Wd1hhcmpZRFlZdklRbFdsOWY0VDIrT0hKR1VHZ0gxZGJi?=
 =?utf-8?B?T2xUUGxkRjhPU2d3Mmo0eFB2S3VMVEV1ZDB0dkE4ZXBSODBOVEdMVmgzOU9i?=
 =?utf-8?B?c21RREVuZlhQRytNZHMvbG90MllVWExPK2JjU3Qxb2hhRkJ1bE1VV2Rhb2li?=
 =?utf-8?B?akpEdHJsdThqd1ZNek9nbTllYm1XSDBmQktpMWxwQ2tmTU8vdzliY0JNOVZQ?=
 =?utf-8?B?cXpLMWhvT1YvZzB2UE8zdXhmcWhSQmN4OWUxTEtqYUk2Q2tkaVJlejdqVzc2?=
 =?utf-8?B?Q1A0TzBqNGdQSWI0WThqYlo1Z1pleFJsVStENFNVUXdsQmw0ZEZtYmRiWW9h?=
 =?utf-8?B?dk1nekoxM1Yxdzk5cWxLMjZsOXdzdmgyaTBKcXNEMS8vb1pmYkdtNERwYUVF?=
 =?utf-8?B?RlZRdVBKR3FkKy9FSlB2RWV4c3BvbTM3MndMVHdDSnhORzhialVsUmJXbGds?=
 =?utf-8?B?cTZWYS9tcFI2RU9wNGdCY093eUg5OW1UNmpGS3AzTkkwclYyTUFVQ09RTWE3?=
 =?utf-8?B?bk5EYnV2OVNBelZIdTVFaDIxNkR1LzdYUUE1bE9QVkV6bERWcnNnbis1d1h6?=
 =?utf-8?B?NXJWNy9RQWVhRXNWOVIwbWZXU0tFbTJwd0l0ZFlqMk9XVVVmZ1A2RVBIS3kz?=
 =?utf-8?B?YklkNXIzVi80cGVaQmxXMUdtSDFzSHNhd2kxVXJKRndjRjJhOVJIV1hzUmx5?=
 =?utf-8?B?QVdVVndFREVyWmJ0b1E5TWkzTzM3Tm9DU2lyOUNvSmwvK2VsQ3NCMVFNVHVB?=
 =?utf-8?B?SDVoaXg4RU14aVRVdVRwNCtiQlgvTnk3cE9GcWRldVp0Tk1kK1I3cWpJWWFN?=
 =?utf-8?B?aHBpemk5RE54dGN2bzhoTFptYm5UNVZ2WURRY2I5Rkd3VU1Fci9RNkJMMElL?=
 =?utf-8?B?b2NyaGNKMk1TOTlvc05xOEJtSitycUtQSjhXbzZFbjVraStVakVyN1gyd2xj?=
 =?utf-8?B?R21idjV0RGwybTlGajlESitvSmxIczNyMjh2SzhLVHlMU21sUUdLTUdiaHNF?=
 =?utf-8?B?UXJmNnFXVjNCMG1HK3dZbnFTNEMxYVUxaXAyV3dIYjNpemZMSUhtRWlocFJ1?=
 =?utf-8?B?aW9DOUxmbmlVNi9hbk1FSjZKa0ozVjZzdXA1NWdSdXpOdG5mWVA3QjNxMWJY?=
 =?utf-8?B?bW9jNjhDcWIyN3pvREVjSW1KUHJBamxtbDRyd2VTL0pqRlhuZkRUOGIrWStn?=
 =?utf-8?B?T25OanR5U0JoZm95ZEZVbklKY2NTNURUcVFFNk0vTVBKeGhqeFVpakI1S05X?=
 =?utf-8?B?Z3U1Y3Z0TXdtc1llRDJvdWxqM2xaSDB2a3hGVnErMFVEaitTK2IxMXUveFgz?=
 =?utf-8?B?WEVGMlN5UE1tWS9rWkk4MVdFZ2pTQ3ltMmxhYldIVzduMkpVVGJScmlLc3Zs?=
 =?utf-8?B?ZDRGTXdDK3VIYzhrYnlFaVZUNmNBSHQreVIzYWpjdWpqOVRkc3hvam4rK1pH?=
 =?utf-8?B?dUlNdUd3bnBrRnZRaTk4Z2hpSDNYNkVwWHlLWGJmNVdjTlZUSGQ0bHd2YkdM?=
 =?utf-8?B?eEdWRG1iM2FUb1ljeENjVkNaMlZxekFFc3k3d2RBWDZtazllTEE2K0hMQVh5?=
 =?utf-8?B?ZGUvS0VXNXpHR0lnMUIvZmpidVNNMnhibml4amhPVkdYeXF2M1NmTElYR0Ja?=
 =?utf-8?B?ZEdBYkxndWFCdURQczFZMWpoNmplTXBNNFZDV1psV2N0N3BXK2kyckVtajJv?=
 =?utf-8?B?bGtoWmZjbmd2YkJTc0hQQkxVUnRGVnIvSzhHR1RyT1ZRN1l5RE14NUs3YlVz?=
 =?utf-8?B?QVNoV1ZSNjMyR3c5bldJLzJGMWhzMlJmR1VjZmNoUitWVGROV0F2Nkc0K2lh?=
 =?utf-8?B?V09rZE1NeStKZkhMSFBSVkZ2ZzBMNTZXd0RET0Fmck5qTjNDdi9XMXQ2OGN2?=
 =?utf-8?B?WFZlMTF3ZVlFTGFPbzZEN0pURnRuVnBYaEFZNDY5amJ4ZlMyNUlWcHpGODZ6?=
 =?utf-8?B?NVVnN3FXSUFpMlRBYi94bENPNjlmZjBnRGNBYzJTRys4cVhwUkVXK3RPUkE2?=
 =?utf-8?B?MWFIenFXWVNESnhVb1l4a2hMTlBkdmgyajhIa3lDVnZMOHR6dGF2OUw5VTZu?=
 =?utf-8?Q?VwkSrKClwjzQjnVs1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 355b92e3-c5ab-408c-c6fa-08de84d9d4fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:33:45.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/nj6/j9zdaTqp6AH2Ytf2Ibc6sao+Z87iEjjMP2rxaejdOFknOaUMxv8UgTuJFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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



On 3/18/26 11:30, Srinivasan Shanmugam wrote:
> When a GPU fault or timeout happens, the driver creates a devcoredump
> to collect debug information.
> 
> During this, amdgpu_devcoredump_format() calls
> amdgpu_discovery_dump() to print IP discovery data.
> 
> amdgpu_discovery_dump() uses:
>   adev->discovery.ip_top
> 
> and then accesses:
>   ip_top->die_kset
> 
> amdgpu_discovery_dump() uses adev->discovery.ip_top. However,
> ip_top may be NULL if the discovery topology was never initialized.
> 
> The current code does not check for this before using ip_top. As a
> result, when ip_top is NULL, the coredump worker crashes while taking
> the spinlock for ip_top->die_kset.
> 
> Fix this by checking for a missing ip_top before walking the discovery
> topology. If it is unavailable, print a short message in the dump and
> return safely.
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
> v2: Updated commit message - Clarified that ip_top is not freed, it can
>     just be NULL if discovery was not initialized. (Christian/Lijo)
> 
> v3: Removed the extra drm_warn() for sysfs init failure as sysfs already
>     reports errors. (Christian)
> 
> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in devcoredump")
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index f7f37d93d0ce..6be1f971a31a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  	struct list_head *el, *tmp;
>  	struct kset *die_kset;
>  
> +	if (!ip_top)
> +		return;
> +
>  	die_kset = &ip_top->die_kset;
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each_prev_safe(el, tmp, &die_kset->list) {
> @@ -1419,9 +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p)
>  	struct ip_hw_instance *ip_inst;
>  	int i = 0, j;
>  
> +	drm_printf(p, "\nHW IP Discovery\n");
> +
> +	if (!ip_top) {
> +		drm_printf(p, "ip discovery topology unavailable\n");
> +		return;
> +	}
> +
>  	die_kset = &ip_top->die_kset;
>  
> -	drm_printf(p, "\nHW IP Discovery\n");
>  	spin_lock(&die_kset->list_lock);
>  	list_for_each(el_die, &die_kset->list) {
>  		drm_printf(p, "die %d\n", i++);

