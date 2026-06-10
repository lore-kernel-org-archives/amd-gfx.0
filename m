Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FDACD8CB2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 07:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE9110E748;
	Wed, 10 Jun 2026 07:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvutPPjR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A8010E748
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 07:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3461HRvZwlfuOuoImz7m10gwgyxEKwNtoOj4uA3F6iC7NHzqFWD9MuTaR8DvCtOApmbg9Oc4+dlhYwKb5Ptq52uC51NCXOtkU41aDmZq0hfHy1SJU92Jia9kMzLPWmrbV+Apk7I2fb6fn5HYLRNXYagN6xZycjSGCqqqo5tI4DwLI3DmFyeCZmsnQeAOPOuSd8DFE11064i9UQ0PfAvtUrIQNpKK2BJtRbJukyzabooTEIRD16KjydqDf06Hs2WpnxotbVvB4/KP8pJqx+uFIjNgocqSiGSROG120ssz8MKJEEadyYJbhChBQ/vMuwe4hnyXgkjSwjwrG3iPROQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgUo4GFo6so6oZtc3oCw7iHHgEx7mhOlgiitgeJmoM8=;
 b=n31DAcThy8HDC95WslKg1t4gzoCzT58YmOtcLb5D+CkQt5uketHppjADolQ16HAUnsHtNDK0pFpB99flVKV+jWQV/rLLNKi+uFDiQrVqVoK493zOOVRN8xWn68YP+It7tbCQJQTCILX+GkIA0754D+PLZpFmsHLmB4vb/AIwwcMsaZg0tv8dyUeOL5ZeXgWGvkINXTqzTsEH6JmUpskl6doLqgNCG0BF7jCx5BMo3B1oXy/EE9A1kPqhM+8q8VV6RxpK1TQuPv+Q70XUBjC2TUs7UIIR/DOQ9xSHgzP8dp+5X5K3juOAc57fuTmdA/Xz/AaWgtM/KN5TNkGJs7QSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgUo4GFo6so6oZtc3oCw7iHHgEx7mhOlgiitgeJmoM8=;
 b=GvutPPjRM8RjakPQdPvNciM/6dBGIdqRo2LqaIJaOU+JRAuzxbqIEu1A6AOr6r+1HylKwwuJsHzKVxKUlHuH4QyZwQxo7ryeogpTz87dXnVINZzjPXVDkvOylwcp5Tl2q/cL9CA5zpcXcrAiaaaeWYg9WAuDv+cJnRWn64jgWhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 10 Jun
 2026 07:00:06 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::18c4:be41:febf:7e45%3]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 07:00:06 +0000
Date: Wed, 10 Jun 2026 14:59:47 +0800
From: Huang Rui <ray.huang@amd.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Huang Trigger <Trigger.Huang@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu/gfx9: Fix Ring and IB test fail after mode2
Message-ID: <aikLYxMZpzhcBKrf@amd.com>
References: <20260610055736.951241-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610055736.951241-1-Jiqian.Chen@amd.com>
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e1cf71-bcb9-4271-d059-08dec6bde726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jC5Pu32svLgPv1VzREhD587/bdIXI5Z5rznsJWGVSHeu/0tX7GTfi8yDF+NFIYR1Dl1zOFtMwG9pBFIZuWjuUSOcvpbDwEcgXvSx6yza2IUoaVufSm1wFGJDdsum4dJMX4PRGqIp/HX2upxQE3hwHfeQqNC/+/ENtx1mwZaibn1RbiBtYncdt95iC85LJ4ki+g5Ov2w9/abiDMCAlE9CylnqVgmcKQcLHmkhVtnGh9LrR0Tv89wnyEu73PoXUntYW8qTUgaSTF9aG0wdfyvUJQ8lAslpuRZJW28tC4bqYM502rXiW7GnKIOIZ+4YJ8Mr0Z4Xpz283oaJSOIMcmZvlxSah7rhPQM1ZQDRrnQl3W1Ja2a2p20HQ0OtbI9cFk9tprSGP5jooyqjJIUVE7Hi1Xg79MuKgwcbUSuI4ykcjIEkyJZYcygDgDz8FZnLMbDx5mc8UDDteXSKH+8dJwPMFDg57WCFyA0ME7zfvOT1Jj4C8HhYKaXL723Iv5LtBtO0Lfx0G9LxSsvKb5G/5zv1Epe9NEXgVk52KQTyhWM2oM5T98O1ZFqknsi4uHd+67Od+sl3qVW2xpwPL5luWAv7IaQFWkRU0dqBa2fJIIJCpiBAcOlW9+AxwdztriOisIHJmPgb/9U8RIH0gtbEBBn+tulQKklJA09afYi3Rq2ts8d87+a2/ADdYyIjjhg2tbJV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JMY2sVMtUJZ0Nr13x8aIGKUqZzcwvljke10lksHqFlE1UZPPAJpPaexx8fqG?=
 =?us-ascii?Q?G8pwG03D2JIg5QJpoiPmUPIAiUU3hbZDdUiqItEmw8M2+DNJekmFDr0gV8h9?=
 =?us-ascii?Q?XQ1yba7616hh/uoY8tlpKcREQORMVQ183r3A+TdwqdoWxYB33+M/plhmzfxa?=
 =?us-ascii?Q?Yx+yCbbJYpev8NKmE0D0M0ySGXe2WQtB3KqaHZIJPUOsRoZ7pV4EeEqgSXsL?=
 =?us-ascii?Q?99thPlABkYJ2MoAKs9gDX4HxoX7cmKFaV9ZwgHYZRM7NnwW7icnX5xHWChbi?=
 =?us-ascii?Q?SxkfPSpyiypGuzjGg1ElmqO2kf/Ksz22PA5HCqr7Rs0sP8hA1CKfDRWZi7cJ?=
 =?us-ascii?Q?NJcDkAwLH348EcSx4pTrtFMCWbfrbGILRWrlLK2EJ0skGhf8CGE/DdDXnjzZ?=
 =?us-ascii?Q?Lc4XRd7yHAg+73a0w3QSdRSTRo2kODUSTFbvdrO/F68dIjX95ig66uZi1Guy?=
 =?us-ascii?Q?NGAgRSupHO3mwWZyHMXd/+nfAU8FDP+A3lwBS8pg9eX4UM/wiiPhtEIxmRYr?=
 =?us-ascii?Q?w58TQDvdKuzzrc7o0qarhWMan/hqQaJSn5ReF2CLH8DNx6sYqT060FPkjVLc?=
 =?us-ascii?Q?qfZ81B0U26Q6vgwoXi9Lbov8FQ4w+trNN7LhGvvJ6Ne8tw6r+CTOMMNvkFDY?=
 =?us-ascii?Q?Q5jFaWodMwOp4bTsN4ako+d4d4R4tpmZlEmDciJ9ZHk13NDRtYg/Nx9mdbit?=
 =?us-ascii?Q?GoLbySCJpzFME0AnPN96w9cpHorIbGfu08bEskQJQbHdbeW/oSZweaEbRsQN?=
 =?us-ascii?Q?bbflegvkeSbSJI+KryCKz4uG86v41JahQacJrcQzqC4/1XoV/UmeSfQHB1le?=
 =?us-ascii?Q?4cxtHhMpZu4VISRyl3R4fMbVSYXVERWlEUGfaPdR/ibXIBB3SGcUajYNp6pe?=
 =?us-ascii?Q?TI67M4cTWF6HYRXTxOIJGQe4bLhWfoY/EOzeY7mJBWTC+63td+jZjjSqvNME?=
 =?us-ascii?Q?eqLa/YA9W4doIHCF7uPktfTvue34iVSA46goRvZkr04AShpQLxm0arQqMXNu?=
 =?us-ascii?Q?3glNZg3RUMSEGv/HqX73yqqvGaay11nvNPPYU2UD5GWu3wKLTwQlrV0os4Cn?=
 =?us-ascii?Q?TKcpKaM+4eIMh299u0cjw5fQLjJc67yDkRDitA6YBQD+QnkoX8dSFTb9b3yO?=
 =?us-ascii?Q?jvJJuxhjRBkEi6SZqvC6z6U+aDCZ3ObgGBIyg17QlWZUuRshWijLoikKKBWX?=
 =?us-ascii?Q?UHtuCmSRWavPg6EaDtGIdSOgiMrthXAr+DbfGEKEMwvMKcwdDnFtkM3Mw4ok?=
 =?us-ascii?Q?yxHa0SNCdPzH3heZIYBHhLdKFMXKYtpyjPRVMdhuND65iT2sXfRPLlXrmxWO?=
 =?us-ascii?Q?W57Ff3Qd2u82MDErUAaercifAwtGZR8VSXn0vbHvbjaLfI9xa+EmC+GhwpN8?=
 =?us-ascii?Q?0Xsrz1nq3F//11QjQNzonjxMmh7P1cJ1GYWjeifYvczJATwqEeZUX/vmCYvG?=
 =?us-ascii?Q?4K8rl4is82C0YxYGE4QClnHyJMu+358HqIuDDHf45Q/9Ch0sOs2ZnbRYYKd9?=
 =?us-ascii?Q?pl1Zdb7PzOUP25xZ4oFzg4+XXEM2izXzsUYjCZ5F9xkM2MfFSXtdyuxFlONz?=
 =?us-ascii?Q?BspMufPxcrp8yapLncwSiVXvqdyMC6IYKdLXzGAZGKxI2b7Jr8PG6ZPnXau3?=
 =?us-ascii?Q?vjIVo4ijy5MjhgaG9heja/pEp4XhcWjYKf10n3JrlJ02bFMmDngjCAZlkutO?=
 =?us-ascii?Q?lPUYKD7QRsj8JsUOitmFCpHif5shzUaKF2q6iPzMA+V6DoID+Q/M39Y7pNBL?=
 =?us-ascii?Q?x868fhAaZg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e1cf71-bcb9-4271-d059-08dec6bde726
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:00:06.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZP6g7mI9uy8pu0dAecvXfQf+QpESKt5cDu8UC98Nzjh5YrFUX5GzCGmMIZibRcq4aYdayo5iDfiOUAlJ0NIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

On Wed, Jun 10, 2026 at 01:57:36PM +0800, Jiqian Chen wrote:
> For Renior APU with gfx9, in some test scenarios with disabling
> ring_reset, like accessing an unmapped invalid address, it can
> trigger a gpu job timeout event, then driver uses Mode2 reset
> to reset GPU, but after Mode2, the CPC and CPF are still stuck,
> that causes compute Ring tests fail. What's more, the HQDs of
> MECs are still active, that causes MECs use stale HQDs when MECs
> are unhalted before driver restore MQDs, then causes compute IB
> tests fail.
> 
> So, add sequences to reset CPC and CPF after Mode2, and de-active
> HQDs of MECs before unhalting MECs and mapping compute queues.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> Hi all,
> 
> My board is Renior APU with gfx9, smu12. I run a testcase that
> accesses an invalid address to trigger a amdgpu_job_timedout()
> with disabling ring_reset, so that driver will call mode2 reset
> directly. After mode2 reset I found compute Ring tests and compute
> IB tests fail randomly on random compute ring.
> We checked the scan dump of GPU, we can see the CPC and CPF are
> still stuck, that may cause Compute Ring tests fail.
> I added printings in driver codes (gfx_v9_0_cp_resume), and found
> the HQDs of MECs are still active, that may cause MECs use stale
> HQDs when MECs are unhalted before mapping compute queues (restore
> MQDs to HQDs).
> So, I send this patch to fix above problems.
> There are two main changes of my patches:
> One is to reset CPC and CPF before resuming KCQ.
> Another is to disable HQDs beofre unhalting MECs.
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 40 ++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 47721d0c3781..dc0978bc312c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3944,7 +3944,8 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
>  
>  static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  {
> -	int r, i;
> +	u32 tmp;
> +	int r, i, j, k;
>  	struct amdgpu_ring *ring;
>  
>  	if (!(adev->flags & AMD_IS_APU))
> @@ -3967,6 +3968,43 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
>  		gfx_v9_0_cp_gfx_enable(adev, false);
>  	gfx_v9_0_cp_compute_enable(adev, false);
>  
> +	if ((adev->flags & AMD_IS_APU) &&
> +		(adev->apu_flags & AMD_APU_IS_RENOIR) && amdgpu_in_reset(adev)) {

It should be not only for Renoir, and I think it should be also for all
gfx9 based APU such as Raven, Picasso, etc.

Could you use AMD_RESET_METHOD_MODE2 of"enum amd_reset_method" as the check
condition? Because it is the issue of mode2 reset.

> +		/*
> +		 * CPC and CPF are still stuck after Mode2 reset, that causes later
> +		 * compute ring test fail and then loop Mode2 reset infinitely
> +		 */
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPC, 1);
> +		tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF, 1);
> +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		udelay(50);
> +
> +		tmp &= ~(GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK |
> +				GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK);
> +		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +		udelay(50);

It would be better to use a specific function to implement the register
programming like clearing CPC/CPF and also HQD_ACTIVE below.
gfx_v9_0_cp_resume() is high level function.

Thanks,
Ray

> +
> +		/*
> +		 * CP_HQD_ACTIVE survives Mode2 reset. Deactivate every MEC HQD to
> +		 * prevent MEC use stale HQD when MEC unhalted before restoring MQD.
> +		 * Otherwise, later compute IB test may fail
> +		 */
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> +					mutex_lock(&adev->srbm_mutex);
> +					soc15_grbm_select(adev, i + 1, j, k, 0, 0);
> +					WREG32_SOC15_RLC(GC, 0, mmCP_HQD_ACTIVE, 0);
> +					soc15_grbm_select(adev, 0, 0, 0, 0, 0);
> +					mutex_unlock(&adev->srbm_mutex);
> +				}
> +			}
> +		}
> +	}
> +
>  	r = gfx_v9_0_kiq_resume(adev);
>  	if (r)
>  		return r;
> -- 
> 2.39.5
> 
