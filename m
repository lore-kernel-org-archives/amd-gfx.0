Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADF9C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE2510E769;
	Tue, 18 Apr 2023 11:49:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFB510E769
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Apr 2023 11:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/4H4mxt2UMjztYD963ypET+rYMbIUrzDuKDOxLQo+GRxigHNBMTET81tPyde5rO5ujQs/tEsr/hTVhnZDXY9V7m+BEMMcGs71MPfdQpqWHWX/QAYExoYga6wCEwqxsLx30Ki1HJ9Si3rc50Xvi1rfHrueOEG6GCIwwAKHX7CYvqR7+ctIHX1RTQ7LDJ6bDSdo7pGkh1s+v1yxLicabqUqMmTz3yLXU1c3ZpLEMyrXclVV+unZHqvz3Vm19hmKwHHSBW6sv/4Nt8d0vKnAshgF9U/wQcJc5KEiVUeHHLUAA8u2EADzo0K1AR8NarXm1gmu5sV+wKQetzl3cqXvyttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmGajj7sfLpwMe8r9kjHGkW1AWq7/I3wxMtuTl8Ljl4=;
 b=aq4A3TWumnb8vxXLzk+bu608CzdgwbunVXrcjx7HL7LpAyvd4z4Y59x+nXb4RrGhSpwncMq3z36qOF1jKsP2ntqhyAKsMgaTm/BzI/U5+OZz5Fvy4ca6h4fLKCr84BUtriy9dPmdH0tv4ZJzJTgyd21kXNOdol83zMQ9Ad7xrH89JGt4LR1bj4liYIGHswd/5YWOXvglSYRj0mlrWclldqEQtbRFfyZohHHjHeFMRNQzWlOSsNqqKg7clpwXlckDa2TVvMawvaKHV5xjpxN/wbC1+lFuA6Anu0bBTqFaXV6QXKq8XpYt1lV+IAO3plbDPltXq+tdX+TAtcbXqhv8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmGajj7sfLpwMe8r9kjHGkW1AWq7/I3wxMtuTl8Ljl4=;
 b=oFKWY7Rzol5pKzAG0V8rMwrWyfieDfgFdEZQ/UMJNe8H4gOJNbhGf0toeovIV5CNGFC7KBNbNJ6WhGfbZungVe8cUy+msGJCStJ4dv3RVgURv4M2LcTPGAYYL/yZjgkYrb5uMfpbS8yEFhsdoDUAAG4HWAsGsiIa8ETGsQt52Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 11:49:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 11:49:23 +0000
Message-ID: <4f5f5767-d295-4518-606e-91b22b4973ce@amd.com>
Date: Tue, 18 Apr 2023 13:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230418112913.1544565-1-HaoPing.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230418112913.1544565-1-HaoPing.Liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 83efdb47-dbde-4dcd-50e5-08db4002f390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyJenNDAdprt807GmMX2qfr5Sw4NifSfAFvRX+jmM3oz1pC6uq+Zj+eyrPIcJqze27X1J4lHqcxw+b2UUM3i4SqquByYInSInYnTdP9WsjrzKdBamoHDtRpmtuPQd0Dic3B1XqBj9p6XzEok1r6qVgXLKD0qP7DnqXYcSU4MKunlzTJtFv9P/scIzm/asPJczs/e34UWCigPtjNG7JMhg4loS0t9i2AKs9zRH5xWVc5eLAXHoSU+kSCHyxpOTmx6Od0u1LCSH+4DSjr3pDC6WZvvNN9vfkQ8Z3en3KdIHeMy7QaF/DA6jW2DcarBeHS6ED18yzKV6ApZjMmSSt/DlWTFIJpDMDKWXqmhs/rBVK4BPNFPlwxBsdz2JRbZGLjpxAWaD3884tKN3hpBTwgZwOfissStK6cYohka3gfYUavEvhqk1wd40h9bctUxl+2Fsx3p+F385sMnCqxWoWJSR99iSCvWWQ9RkAC9+lBZiHhl7/ORukAoJdby41zTQhcQKL8nVSWSxZrlwR3aWeiXK5NtWSZI3jBKhElONguoGLjYLOnwbyscudP4fWeeqHKoYDyhZcSNJ4ZdgFlqKeOkqyHiEZH0R2HTr9HskUMY065D/kF1Wvad7ygCmJgonzBl8ccI+zxbw/crv7af3YrmYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(478600001)(6666004)(38100700002)(8936002)(8676002)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007)(186003)(2906002)(36756003)(6506007)(26005)(6512007)(83380400001)(86362001)(31696002)(66574015)(31686004)(2616005)(5660300002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmd6REM1WXNjdzMyTzhMNWJlcVBuZSt5VjZ4OWh0L1VFUVhFMytiYnQwME1V?=
 =?utf-8?B?V2dHVVFxOXVSWWduOVFnSEJESTcxSUJyU2tIQXpZVkIrLzc0Y3hiNGMwQ1B4?=
 =?utf-8?B?MWpaU1JSMFZWd2dyVlo2SmZ0SjNYa0VGdjJPMFJNV256azBmZFZTa203Z3Ar?=
 =?utf-8?B?cVhPdCtybHBiTGpSWTVmMUFnYklVUzlPVzljQjVpM1k3UjlvcnpWZGt2bmY1?=
 =?utf-8?B?ZGdLcklUM2x6TmdqOFc4MUtRL05mQlBLR0Mydk1TVXJXd3Ivd3R1OHlERHNH?=
 =?utf-8?B?RTh6dFZiRG9TY2l6MUdiTGxZOUlYUExHYWpjRXBvRHcwUVYyUXpMRGxGY2NZ?=
 =?utf-8?B?Tlc2SGErUks2YkZnNlhweHVBWUlmblFHakY1UHpwendnWUFQRnpwNkY0ZFk2?=
 =?utf-8?B?czNaRGJHdHBYMm96MEdid1h6eFoyMkwzWE44dDllSVluL2JCQ1QyLytyczNw?=
 =?utf-8?B?S2VTSjBWWGlOclJWTStWejhFNFZsemlXN01lQmRMckZCR08vZ040Rmp0RmlM?=
 =?utf-8?B?RnlMR2pEVXc2YXBaQkovTHVOWjhkYmw3STNJN2FPeGFmTlA0bkpqT2toWmZY?=
 =?utf-8?B?ZVJCUkxhYzQzbFArR1JBTmRRdE1wendnNGtBWHAyUVd2QytTYVU0dGZDc1hu?=
 =?utf-8?B?RUp6RkNrM3FFSHd4aWlJZnNWQ0dwVjlqbVVLQkJpM3I1MzBYQkZzRW5JZDkz?=
 =?utf-8?B?Q3pVQ1k0aTh6ZmNTUzNtUUJLeGE2L1Z3ZkhoWEdKQ1RkOW9PQWVVcXFTOTd3?=
 =?utf-8?B?UW5yZTB1MjRaYzFEK25vbng0Zld2eUlQS21LbGNxS2lJV0xBWmpyRm5kSysr?=
 =?utf-8?B?ekhuUndSL3hqeDZmWXBUS3NzR3hiYXAxUDFKWi9IL1h4dzc4cjdvdzRMVlY5?=
 =?utf-8?B?TC8vVUkzY2hCaVpBenNiMlY5SDR5TlpBQWp3eC8zbldNVlJKWEZFUXdMK3Ny?=
 =?utf-8?B?azIyd2xBeE0vN1l5WTVpOTFtNXlRd2tpa3VIT29TRzA4VDNZN08wK0hMVVpL?=
 =?utf-8?B?VE9Xa0FrVmowSU9MaXhGRVUxQURFNUtnZ0IxSmxKZGhwSlZQWHBRZlp5SWNZ?=
 =?utf-8?B?UUNrU2lOVmlyRTRPT256TXNZVVFjelBoK0E4a1d5SzNhSytMdEc0OVAyVXlx?=
 =?utf-8?B?K01ZZzFBVHVmZUZDRk4yT1Q0MUw3aGpNR2F2VVRpYUd1MlRBeHFuTmlEQ09H?=
 =?utf-8?B?dFNZc1Q1NldEdk5EMmhJUGNZWE5JdEoxcWZUbFhVMHo5ZlMzUk92MWF0Zkto?=
 =?utf-8?B?Q1ZBTlJzbnhkZmRtM3hSRWZQRGROWWhVM3BOVUYwbndLb21TaDhST3VnYW5F?=
 =?utf-8?B?cHBPbEpxbVdUaWRpTXNteTJBZkd4ZDYwdkRVS1o0NXduWHJySVhkNitlODNs?=
 =?utf-8?B?NzNZMmMrYk9NVVNoaGRvbmtZK3ozQVlGVUtzUGVWZmtiY2dkdCtoMWxScXNa?=
 =?utf-8?B?cDU1VDVNUWRsYWgwMm5ENFdvQm05djdELzJJbTNVVS9mSncvU2pNR2xaOUNw?=
 =?utf-8?B?ZmhUbU1nOUc4Q1o3Rmk3c3YvRXRnQVd6bmVCSDFNaGNDV1h0Njl0UFp3Rkpy?=
 =?utf-8?B?UEs4TzZLNzA3UDF5ZSthSWxoWkNYUGNmOC9xekZabnI0aFdUczJBb1VMaTZi?=
 =?utf-8?B?emVOOVVBQnpMV2ZTNjVkaG9hWlVCNlRjZDE3QTZvTnBXWWVuYW4rdkU3anA0?=
 =?utf-8?B?OURjUGVsbW9VSEl2ZmE2TXhrVTF2K1Nrc3R2dGhnekpSY0w5Z1ZqakR3NS9z?=
 =?utf-8?B?bVVtaERMekxlL1h0aGJRaXJPK3liKy81NVZkVU5kcTRlamRVd2JVT2VpeENr?=
 =?utf-8?B?ZzE3MkROTXpkMDRycDhMNUJDRGU3TXJuMmw0YVdNRi9TUFlFR0xzdHdWa2hE?=
 =?utf-8?B?VW02eUxBSVNrZ2kzN0p5c2M5eEIwOGtzVGZ4aHhBNnZyYnRYcFJyYnVZYXJh?=
 =?utf-8?B?UndDZlBxek42S3RjNkQxN3lSWk90TFh4THhjWkZXSTFqQnY1SGpydkUxL0Mz?=
 =?utf-8?B?blZvaXlIcVprZDRnanNxQmFReTBmYnROMzlCbzB6bFBRbkxCNU9JTlN5djBs?=
 =?utf-8?B?eURHdkJ2YmMyK3dJazRIL1RHcTFtN1BCVnpkcTJjTUM2WlFpNzNKMGNSdUg0?=
 =?utf-8?Q?XaRY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83efdb47-dbde-4dcd-50e5-08db4002f390
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 11:49:22.8565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnbipP/CsvVE3Q0qCIMPjuT3Y9Hmiop4RDU386U3wDUn/d0dWWEAYCc5j2PmD06d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Cc: bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.04.23 um 13:29 schrieb Alan Liu:
> [Why]
> After gpu-reset, sometimes the driver fails to enable vblank irq,
> causing flip_done timed out and the desktop freezed.
>
> During gpu-reset, we disable and enable vblank irq in dm_suspend() and
> dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we check
> irqs' refcount and decide to enable or disable the irqs again.
>
> However, we have 2 sets of API for controling vblank irq, one is
> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> its own refcount and flag to store the state of vblank irq, and they
> are not synchronized.
>
> In drm we use the first API to control vblank irq but in
> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>
> The failure happens when vblank irq was enabled by dm_vblank_get()
> before gpu-reset, we have vblank->enabled true. However, during
> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper() vblank irq's state
> checked from amdgpu_irq_update() is DISABLED. So finally it disables
> vblank irq again. After gpu-reset, if there is a cursor plane commit,
> the driver will try to enable vblank irq by calling drm_vblank_enable(),
> but the vblank->enabled is still true, so it fails to turn on vblank
> irq and causes flip_done can't be completed in vblank irq handler and
> desktop become freezed.
>
> [How]
> Combining the 2 vblank control APIs by letting drm's API finally calls
> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> synchronized. Also add a check to prevent refcount from being less then
> 0 in amdgpu_irq_put().
>
> v2:
> - Add warning in amdgpu_irq_enable() if the irq is already disabled.
> - Call dc_interrupt_set() in dm_set_vblank() to avoid refcount change
>    if it is in gpu-reset.
>
> v3:
> - Improve commit message and code comments.
>
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c         |  3 +++
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 17 ++++++++++++++---
>   2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index a6aef488a822..c8413470e057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>   	if (!src->enabled_types || !src->funcs->set)
>   		return -EINVAL;
>   
> +	if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
> +		return -EINVAL;
> +
>   	if (atomic_dec_and_test(&src->enabled_types[type]))
>   		return amdgpu_irq_update(adev, src, type);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 1d924dc51a3e..e3762e806617 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -169,10 +169,21 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (rc)
>   		return rc;
>   
> -	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +	if (amdgpu_in_reset(adev)) {
> +		irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +		/* During gpu-reset we disable and then enable vblank irq, so
> +		 * don't use amdgpu_irq_get/put() to avoid refcount change.
> +		 */
> +		if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> +			rc = -EBUSY;
> +	} else {
> +		rc = (enable)
> +			? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
> +			: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
> +	}
>   
> -	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> -		return -EBUSY;
> +	if (rc)
> +		return rc;
>   
>   skip:
>   	if (amdgpu_in_reset(adev))

