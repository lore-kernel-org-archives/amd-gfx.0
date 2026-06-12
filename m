Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3875CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 12:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2210E44F;
	Fri, 12 Jun 2026 12:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/JJ0q1O";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C11510E44F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 12:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOgV6LWYykDBfbJ/TimAoEriEpRyWMuXeEAF7NxW5IAYRYhCEuNcd87Wvpu6nfA2+BerOLLa2iXTHhtF0cLZUA8rRgix+XQ2rae4YbZMDwm7nyepn9D8yNCd/cEutJAMQbqfKpJo04YY8yG/lkcTmMOZWzeoIeUg6RDDUMcEL2VHWNeQ6sptE7FLmNCbtzxDJnlnVXG5P6veae226lqlcnIaz8+5GIaC2wApUDNKWT2ku3LFzxxLbWQeHqA0POj/pA0t8SX+b8Egtj/V0BWpUgDdokaUBPgh/sY2CkNLHpAk/Q6FY1VBMmv7HGcbFfUM+M0XB6yrYA3bvTSTrDYWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YUGGS+IU31fNgkKIsFf4D4vfDk/iRyV0iKcn45/r8s=;
 b=tF6/6arUfWcm9z6Fp4s8rqJbBcZqsIsrsrj9VnVH+K4XLoNb98cCgGpAMy7QalMJSxxmZ7fYoKjtjmy+hut2m4K6vFbe5k9p4jitkOH7nDZS+bPRKZEQGHhQMRBNzN/mi4LJPNvDSQx9lw6w55jonvao/0eZUnjXHHI95HNio6MRfB1AOPttUg3Lf9U85w/gHxYzgYa0iWg0KYs6M8F3nvgdRpTiR6MTbfVit2JGPdjYboZI6gvcTGfURc7c8O2uKlyg5qJd7CLL0uwnWypEANqvLaGrc3GrkNxp8lfKuU1kB5KNNQQ8NVQIuAHazUR2aLbVHnPeHGT1QG25R96+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YUGGS+IU31fNgkKIsFf4D4vfDk/iRyV0iKcn45/r8s=;
 b=W/JJ0q1Oc+RP00WF3uj5h0E3mvpuDAODuCJvm8LOhBw6twkxCr1vEKbxa1AYtk7Gpi5EHGpgIFTByuXjE0QnLzx+Ju0rNKG6j+ArSghDmv8Pr6lqBAwOqvMpKDmofYzkJOv3ftjGKAvDGhdYuetlpuKeoX+RhzITgtDKmeiMqZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:46:49 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 12:46:48 +0000
Date: Fri, 12 Jun 2026 20:46:29 +0800
From: Huang Rui <ray.huang@amd.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Huang Trigger <Trigger.Huang@amd.com>
Subject: Re: [PATCH v3 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after
 mode2
Message-ID: <aiv/pVFgBDwZKWOM@amd.com>
References: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612092654.1632603-1-Jiqian.Chen@amd.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 956820df-109e-4b7f-90d6-08dec880aab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: LjcPxJFchgjdxdYU4DDJuCkukNVBbVS5U3fmeGBNNpvWNqDfka5wqOZAIaLVhcdFoCwuA2IN+aOIC8P6k1bQl5SEvFsMW8FIq4Ts7z5r2KUGbwBE/AKgTGNQ0na+7n2Qn/OQQZPgSU9X3p+RxXrN6yxRnnF2PlZ3K7UARzNtnwlGUo1coBd8otQXWvLXcvNfetVMOmz3S7mvPd0CfI5YLcpR4kG3QcidA+0dEUkuzlhP+vzSLaMb38MgM5jKCf8YJQCYOTqwkf/YgAoXuIkUACBU5cGW+/FOwMwpjrgCWL/FjjFYz+/oGulhe1eofUGIRqLZDjheygkM8wl8tqA/tX2hYoMbHcJIoaVEBjZ1FaBewZ3Xc6b0rYtfZEqzVxsHXIiNVzJrfMV0XozCVp+2LQ34AZ4VGBMGyuE78BMG3ghfvwvg70VOMb58Mh3lseXn8FMDjqJlCPcH8RyPpDsjRJHmHFItlnXWTcblQXYbJrF2JKK/5uUAYt634seBxaiQgcKTEz4AXHDi9hyWeelJSMSLo7Ltw9KLf5oUCIWWYk/L7n/QxxtRuWUrgbGlc0Z3fy6OsO/sicMLs8vev9r0ZTdGUW8MFnFEGjVv/xUym2CeaUwJpUIY1gATmbqL4DcRnwVFc3eN3Jyc0hh1vfU+OCK/EFjbxIet54tWtg1UH/F+Os46A2F2VXpSSWbHEdnh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rlS/u0qSDwDlLCpxI+KCYy6WWmXwMKN+68VCSYEOP2q+K4XTkOWYpQKJLw?=
 =?iso-8859-1?Q?NCzUlgULaH3n5Z2SeeTjxmlCebLXAjocyqb4m4WSDhm0EYWUdStlIxVG5P?=
 =?iso-8859-1?Q?WMdLxHwi6alDs6BYemg8xnN3zb0ulkT7yR1qzfWwe/SByi/oGGe5ZoM/IY?=
 =?iso-8859-1?Q?LiLs264GyxOnkO3L1lZBE/I4wVXKnri+XOvWCtDrrDNDGaKOvPo6zGiSz3?=
 =?iso-8859-1?Q?UHfplU+sZyZnMK55QbUul8nDKXOk6ry7jzV3zbDVTEipiBQrm8K0f+ONCC?=
 =?iso-8859-1?Q?KhrsCoESd6Ze86+nPPQwBPCWcxhpXLjECYuM8h4WqruEU7p786tn800onO?=
 =?iso-8859-1?Q?4PUfzlpO0s6zOqsg5VpC4jkgx4FQLp9ubn7kfEaSfrgLGxRZPf7nvrRNlO?=
 =?iso-8859-1?Q?zWQfsFfQJUVtOcECt3Y+RsLWEL65FcqixYd4iH9z+7eCAS6bMluHqXy/x+?=
 =?iso-8859-1?Q?ebgUHTlGaPgGQrt9aoTj1oluuLyD2ZznTxi11EEyD52BiYxrSLVAHqls5F?=
 =?iso-8859-1?Q?o38lfSp+xG3IjeINLa9h2YP7avArIfmOd071SzeP1V4aJKqL7WQE7e+ui8?=
 =?iso-8859-1?Q?rKOuqHxyscTs1fS0wwXD61lP8210DAY59sda5Ro9osRdzsb9CPbwstJkqU?=
 =?iso-8859-1?Q?x3szF3BmgvjdyHPUQoYJRt4pDHoOuEplHyr9JD8SOBhquLErztJzpGMxld?=
 =?iso-8859-1?Q?zwG2Al60RN2fL6aow9SEBZVpz1/Y9vHMVd6h8JDXHSNhBNTZ3YTpGextTj?=
 =?iso-8859-1?Q?XAsWsOzcBNKCmQGg/RpD8XdkfqtxwJc7W2bJqBTSkfQ4llEpsGcBgFhwT9?=
 =?iso-8859-1?Q?CvfI8gUWT0EO7yTVTB7CWSRN+e6pd4pfMsHeLX9if7gI5EVCOC3EI0Q0Dw?=
 =?iso-8859-1?Q?1HR4YYpr8UjqKTLk9AeEkPz77MXVN+U32yzEWPhngZo1CDyR1LJH0FVt0p?=
 =?iso-8859-1?Q?4y6chVik9RJpwF2UOFBhRi+cut1sO360h3Jp/NE5PG2yk3bgzzCbSvpO1L?=
 =?iso-8859-1?Q?qEREFptXUPK8eZiW6tqgsdhn4xE3upbwvdFR+euS3Xqux5UGx6pLO2l709?=
 =?iso-8859-1?Q?DnSL8g31MKxSqCZUKTCtGNNhGAJ2dcr/OXN2YtCtGSUFMAgQBubpMlmGSi?=
 =?iso-8859-1?Q?BVQ+wXOeXOIMZnE5I2kMqB3b5L5I0Xij553Nfa0rTHSW2B6iox97mytO/D?=
 =?iso-8859-1?Q?gB+eqKPjqE8rVVQuy+1hfRD1zCdahRa95dd6MT+tl708O1Zpfuknjp+YZh?=
 =?iso-8859-1?Q?ThVH5LbhI+K3Ky1UwM/Wyqf/bf2ayb76To52mviJqY0wWaw615TFunhrc/?=
 =?iso-8859-1?Q?kmiKTFJfI8+rESWhccyWgQI728Qn5L1rOaTpHVmQbbb1nvNWjNpfh7nbmj?=
 =?iso-8859-1?Q?Xiew+aJuyakfyZiMvzBBQaNy+3P/ciyhpDMIWy2xD2cgddsPsFY3jS+FTx?=
 =?iso-8859-1?Q?dcfej90TKUugQSjl9S7ZbmbpbrHUq+WL1sRXDpPtINInOtbsq6Pyyo/3wu?=
 =?iso-8859-1?Q?lfRMGESlsmGXUvpGQnGEKIxZ/Q3bD44mEMAMdd8CrhWG1adxfDSFGk9DU0?=
 =?iso-8859-1?Q?KlIJGa73ZFxweE9SmireihfIKsr3tCYV1st8IRGaAz2E9ZrMOxrjTGBPrO?=
 =?iso-8859-1?Q?4H5Lb1d9In2S+ZkPUL7bnRg/cNOKDKPbRFStDpHE+kg9Zn5htaLDQCPaHZ?=
 =?iso-8859-1?Q?2tBex9WcLTPg6BI0JZFLRwUiUwA7kQ1l36vOzNFs4iX11KnxXlbwp/eUcM?=
 =?iso-8859-1?Q?osazva1O3InoZ/aKoKMkpNFbp9rC5W6N2xvayVpIu40Td4M5qNmGC6AmHx?=
 =?iso-8859-1?Q?x5UDlgtkKg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956820df-109e-4b7f-90d6-08dec880aab0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:46:48.7797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwHSmlLH47iNatWjfOg2Nbtg9UFQy7fKm+NsaGXuu/sOynuTiyDv10r5RX6AL/ndAfE/mRPp/FPVV1QAvgTWyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

On Fri, Jun 12, 2026 at 05:26:54PM +0800, Jiqian Chen wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2 compute Ring test and IB test fail
> randomly. It because the HQDs of MECs are always active before or
> after Mode2, that causes MECs use stale HQDs when MECs are unhalted
> before driver restore MQDs, and causes CPC and CPF are still stuck
> after Mode2, then causes compute Ring and IB tests fail.
> 
> So, add sequences to deactivate HQDs of MECs in suspend IP function
> of the resetting process.
> 
> v2: Move all sequences into a new function gfx_v9_0_cp_mode2_clear_state (Ray Huang)
>     To check reset Mode2 method in the if condition (Ray Huang)
> v3: Move all sequences before Mode2 instead of after Mode2 (Timur Kristóf)
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
> v2->v3 changes:
> * Move all sequencess before Mode2 instead of after Mode2, and add a new
>   function gfx_v9_0_deactivate_kcq_hqd to do the disable compute HQDs
>   sequences.
>   Then the resetting CPC and CPF are not needed since we have already
>   move all sequences before Mode2 and they are not stuck
> 
> v1->v2 changes:
> * Move my sequences into a new function gfx_v9_0_cp_mode2_clear_state
> * Add reset Mode2 method check to the if condition that call my sequences
> 
> v1:
> Hi all,
> 
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
> 
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that caused Compute Ring tests fail.
> 
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restoring
> MQDs to HQDs).
> 
> So, I send this patch to fix above problems.
> There are two main changes of my patch:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 90bbddb45730..0c01701488e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4071,6 +4071,39 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	return r;
>  }
>  
> +static void gfx_v9_0_deactivate_kcq_hqd(struct amdgpu_device *adev)
> +{
> +	for (int i = 0; i < adev->gfx.num_compute_rings; i++) {
> +		u32 tmp;
> +		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> +
> +		mutex_lock(&adev->srbm_mutex);
> +		soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, 0);
> +		tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
> +		/* disable the queue if it's active */
> +		if (tmp & CP_HQD_ACTIVE__ACTIVE_MASK) {
> +			int j;
> +
> +			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 1);
> +			for (j = 0; j < adev->usec_timeout; j++) {
> +				tmp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
> +				if (!(tmp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +					break;
> +				udelay(1);
> +			}
> +			if (j == AMDGPU_MAX_USEC_TIMEOUT) {
> +				DRM_DEBUG("comp_%u_%u_%u dequeue request failed.\n",
> +							ring->me, ring->pipe, ring->queue);
> +				/* Manual disable if dequeue request times out */
> +				WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, 0);
> +			}
> +			WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, 0);
> +		}
> +		soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +	}
> +}
> +
>  static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> @@ -4095,6 +4128,10 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		return 0;
>  	}
>  
> +	if ((adev->flags & AMD_IS_APU) && amdgpu_in_reset(adev) &&
> +		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2)
> +		gfx_v9_0_deactivate_kcq_hqd(adev);
> +
>  	/* Use deinitialize sequence from CAIL when unbinding device from driver,
>  	 * otherwise KIQ is hanging when binding back
>  	 */
> -- 
> 2.39.5
> 
