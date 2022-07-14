Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B7BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 19:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36FE113FFC;
	Thu, 14 Jul 2022 19:32:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C882113FE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSbJXFjF+i75YaZNsq5sLkoJ2M1sbyk6xsNvgLvTtxf6PY+AbEMIuNmSfnMfFXu4h8+OHO+JginFneHSAoU1J+Ot6R8nb/txSHoV3HOg5qpNOcQWog9XWEJOQDxrobk5zVHA6lHA8kbFGy/AZf3GXF0r7dr1fcfbfYdc2h0AwqhYrM/mgltGUSqxh/wELM67mZEecFXhXIDM2jaCnLAttYuYAjtNmJsicTv7SYuVLb2FN+vi9FxOJxwrDBZemvgJxyBTRKGHc4wd8nbvDSdbHNcFiK/GpSOysvH9vPwrPukpAGL1vm7z/UA2+AALZyaxCTzUWb9nqU+vUYW6je+nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th/m/zYAOF6al+vU1fjqao0cpo08ru713Z768UqTsoA=;
 b=Wt0VR+7rqsmQTwIBTuLRndtJtws+QlmY33z7YBmBjsmD8c1fK7gX++d2GF2pzxQ3dFXIJSs3a/Y/IgWkc+AgYqJIkyt5bFSiskQ9s8ji4W5sLEHwCyG2HbyIkyjEsumwcejukrtWt2KjXRV54gbpgrniOzgMDrvsx4omDkxiHLYWtOfAEMS/oiC6U0Cib8H8IrFv+WzEqQpArjI6uWHv2nE16xsjz5D5XRQYIlQrE2543Ewwo3UAS/Ix8n3av7TUPNyCZd745xO3XxYji9mXaEWSB0+GXB8rIf+7Gw96hBn+6rmskEJDIFf0EBjwxKp8/ntc0d4umQkOxapyMVKHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th/m/zYAOF6al+vU1fjqao0cpo08ru713Z768UqTsoA=;
 b=doH35fDFAoAInt6pW8F7EjfGwQWDCg27DCFbI90hd8Wq6pDhZm9/nB3Ngcwv7T4IhNLJScw24Ib07m5dHJC4ABJE6mcrcT6Yn6FGDbmHA1Dt2OavgOymh8hJqk8IzCCrliJnOMaIH4FTMavZhslY4dNbmI09qUMpXUS4I/wzR+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Thu, 14 Jul 2022 19:32:22 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 19:32:21 +0000
Message-ID: <f35307cf-4dcc-5f94-1ed1-b98c19ebf4fa@amd.com>
Date: Thu, 14 Jul 2022 15:32:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 andrey.grodzovsky@amd.com, Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-10-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220714103902.7084-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3699a4d2-5490-40a2-7f77-08da65cf9261
X-MS-TrafficTypeDiagnostic: PH0PR12MB5419:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InnlIoBT43V0uN+LU/rVt7CfCBxuip7IOKrYNkKG4pN7LPiA0WyyOGKqZd728q/Fbrf8fJYUscExvsyxevQZs/7Bh/md/PfkdSdo9V2lb616Oz33w2RAHRFd0arB4CKfTIbY7iGvAlQyyUDW7WmEJHkn0bCnX4QehBjXvQVst49nifnDQOufSRxQpqjw8GTPMALDcCqtrd8uF5GMtz/4MY/LGYNP5L4SYuGQdRoI6BF0LeqRxvFVoaXSlyzPaVbSqFcQTNKZx/+M9wtV04JygFkMPCAD5adocGO+aWAPaFXXOAPryAxh2Q0JbdiBHwka/vbV5tv1J8AtXVX/Y6tKJJ9YQ+Tf7RkejZsJJQ17CKZ/Xnry3cz8vGv/QMHqM/fmsRSF//gaQvJ7+CEPE+5hFERPR5oMztVlzdo8OU34rGp6S2v5/+o4uijrH88z+1eTl+zqsLKDbHdGFvhIsY5FkS6vDQbzt54UXYlR5+rSIkMIbZ+P9seiy0DcaWzqMwNGqLlARa1auG/eroPGYfEhO7+zxixOfW8e90Ktmlinn3Zul9Bjl0sI7ZUSzsvFQ5NGysWytSAqS1AWEBgjry3cJITvI4/ZiWl8vstKgAyjgEV2W4j1wm/Ay9hOF4V2EiMpZpkMMqWJLlMnnThLrEEwl02pTFw7fXhMEza82j7pVdlidEIZjndm1bfFQuQ+3a0rZrOfc6oFnQHpM7sKMSl8hU/zJSP84WIQw9WgoCmokDWIdCHeIrsKNzy5YP32JWWL6OcjPCYNOJ7FNR7RlguzclDs8dYSFYlyMViMZLIkGkre6L5QmF5E3QTZ+7zwK10DfejKz1FdZUq+LC3qKFX5Wduaqag1FtC8Jk6HpNrLmoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(66574015)(86362001)(36756003)(38100700002)(31696002)(31686004)(186003)(83380400001)(2616005)(41300700001)(6512007)(6666004)(6486002)(478600001)(26005)(53546011)(5660300002)(316002)(6636002)(44832011)(6506007)(8936002)(4326008)(66476007)(66946007)(8676002)(66556008)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEpDc2NwOGxGcDNnUlFWUUVaWjZScFcxZldwTUNabjUyeEp4UkxwNnBITlpQ?=
 =?utf-8?B?R1ErVVMwT1RCcVFQTFJZTmNpSkxMc0Jua0FGaFVGSVowMGJtaFVxSXREa2RL?=
 =?utf-8?B?clZmdGZNVXZjNzhaMDF0Ny9GTHF2WFZtSGdOT3NPS0dOZ0MyaWZFdE01QmhN?=
 =?utf-8?B?UURjV1g0NHM0aDNqclBJWVhNcUtyWHhmUW1tRkVXSmhoaVlwZ29mWFFKSCti?=
 =?utf-8?B?VHJyejFXUWM0TlFob2NqQmtLaFQ3U3ZhNyt3TnRrU1F3anU2aFdRdUxVWTI4?=
 =?utf-8?B?bHh5ZmhFcHhLSWFRdXNvM0xnSmEzaXFFVjNTYVQrQnY4RUZ1QzN6VVI1YmtT?=
 =?utf-8?B?TDBzK3g3R2NCRDh6WHBoYWhSZkcwbVZjVUE1Qlh1ZVdOem5tcVd3b093eWFF?=
 =?utf-8?B?WUltamYwb3QxM0pZdUVJV2M0OElPRmhVRDR6SVR2cTNJUU9yVm82QUpQcU10?=
 =?utf-8?B?MWpXdGxtTG0xb3R6M25NeXh6RVM3UW1Ma1hoN3hJeXFRd0VVcCtITDRvdUx4?=
 =?utf-8?B?aUtpckNhZHJpU05GRzdkS09CRkcxdE01ay81TlJIMjhGOVNSVE1HS1hxVG5i?=
 =?utf-8?B?SDZMck1oNW54ZHF1dHZuelF1Q3R0T3orcUltcUZubC9SMytPKzJJRDRuYTdJ?=
 =?utf-8?B?dmYwWnE5VGM5NldLbDF1YUlTMjZtbXV5QVRyT0ZTYUs0NnhLbXcrNmx5WEY5?=
 =?utf-8?B?cmRYZWFhY0JvODg5Ym5rTHlWdCsyTjNtRGxtU2tOU01qRG5WMEcxanVxVVo3?=
 =?utf-8?B?QXd5a0R1c1AxL1djSnRRc3k3NTBZN0I4VXc4T0F6MnlYYXJUWEdxcGE0R2Mv?=
 =?utf-8?B?MGk5b0VYUDVpL05MdnBwS3pDci9kamVydk5TMHhhOVE3cS9vN0Vnb1BBbm9h?=
 =?utf-8?B?YlVuRWN3R3hKeE9UcjBuaWk4WXROVWhzWlQxUFprS25oT3pnN2kxT3FhMVlj?=
 =?utf-8?B?djh6bUQwdGw5bWo1dWhucXgySUd1eUpTOEZkREFBSHppTERtVXEvMkRvSlBT?=
 =?utf-8?B?TVZxV1cyVEdIdFJHTmg5dnZSQm9JcVFxa0xyRjA3T2J0UUZzMno1TVFrU3Bl?=
 =?utf-8?B?NmRtRHFQbEV3SnNNSUhibFBONXNISG5scmZBNlZRVmxQVXZMOHAzRDlLRTcz?=
 =?utf-8?B?Q3o0Ty9oalJxR25NV3hvQXc1WFZmbThIVjhPOThUeWdlMW9ocmE4bklLQXBX?=
 =?utf-8?B?RWhEQ3Y0QWlGMzZMeExCU3NwTjUvbTZJa2F4Z0U2NHJKVmJTMTNmeUc5US9B?=
 =?utf-8?B?K2p4OHp6WWpBWDhOUWlmQ3ZRZFZsbjZxNldjWG1ZVVdsVVJnaXcwekswdk9V?=
 =?utf-8?B?dlpoSjRLUG1pNVRDUjNaRTlkSWsyYi9ia1BsNjVKTTc1clJGYVhSMjBCaEVG?=
 =?utf-8?B?UHJJYjFpY25BRHhsSzFtVmtYdm9TbE0xQ3JFWXRTK0J0aG1iaytGWTk2Mi80?=
 =?utf-8?B?dUc1K3RGODhYakdvVGR3RWpwUW0rc2t0NmJUOUg5ME9FTXhFa0c4a0orVnNi?=
 =?utf-8?B?Q2FUaFZJTlhicHFXODcvemtpaEQzZnBFbmFmakdYZERYZUthN2g2NjBnN2RQ?=
 =?utf-8?B?RHdDdjlETllibU4zU3VhZjRySHE5Yk1wUVdSbzl1MFFQMlB4aFVTSm9OVE5U?=
 =?utf-8?B?VHZIbGJMeU9PZnphdi9WU2pqcFM3SG1ZV3lWdTFEZ0ZlbG1jbGcvbGgxeDRC?=
 =?utf-8?B?bEt3U3VVY3h6WGZOOXp6ZFFzMmJ1UFB0eWwyVXA4Wkp5a3VPanV1L3FtMjVY?=
 =?utf-8?B?S0VlcGFRcUVBQWVwcm41ekJZQlBBVlBXR0RtZ2Y0SEdBcG9kT0w1SmtPZVla?=
 =?utf-8?B?RjRIM3R4REFqY3N0enVCUGdWMjhRcFZjNTFzU0J0K0Y1ZDlkVGV0Z1M2bVFm?=
 =?utf-8?B?Vldxd0R6UjJ5eVhoSHNvcER3UlZQeW5zSVIrV28wMXNrdmg0RGsrNHFDUjc0?=
 =?utf-8?B?ZVoxU3h2RFphclZ3TWJ6SEhYd0hRb2hWRWtubTJNeHRCZGRXYko4enJiZUhK?=
 =?utf-8?B?TXM1M2tKZWl1REdSZG1Ed1h3WHZRMzM2M3BmSExCUVFqTFNDTnBLdTVHWm1h?=
 =?utf-8?B?YzNrMWRzVTQ1dnhnZHg4SUptNndwaUYyb21DSFRCUkMzSDRnS0c1MUp1UGdq?=
 =?utf-8?Q?dTzmWvdnHOXpOQT4CZLE/zvXp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3699a4d2-5490-40a2-7f77-08da65cf9261
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 19:32:21.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc+lTmqM80OmkZ2B1NBTIx6jOb+hSOPLf+YpK4HbEF3ZHWV0hQ8ZfZQdUKwvX0ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Inlined:

On 2022-07-14 06:39, Christian König wrote:
> Allows submitting jobs as gang which needs to run on multiple
> engines at the same time.
> 
> Basic idea is that we have a global gang submit fence representing when the
> gang leader is finally pushed to run on the hardware last.
> 
> Jobs submitted as gang are never re-submitted in case of a GPU reset since this
> won't work and will just deadlock the hardware immediately again.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 28 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  3 ++
>  4 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2871a3e3801f..19308db52984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -881,6 +881,7 @@ struct amdgpu_device {
>  	u64				fence_context;
>  	unsigned			num_rings;
>  	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
> +	struct dma_fence __rcu		*gang_submit;
>  	bool				ib_pool_ready;
>  	struct amdgpu_sa_manager	ib_pools[AMDGPU_IB_POOL_MAX];
>  	struct amdgpu_sched		gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
> @@ -1288,6 +1289,8 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
>  				u32 reg);
>  void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>  				u32 reg, u32 v);
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang);
>  
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e1c9587f659b..f80beb7208c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3499,6 +3499,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	adev->gmc.gart_size = 512 * 1024 * 1024;
>  	adev->accel_working = false;
>  	adev->num_rings = 0;
> +	RCU_INIT_POINTER(adev->gang_submit, dma_fence_get_stub());
>  	adev->mman.buffer_funcs = NULL;
>  	adev->mman.buffer_funcs_ring = NULL;
>  	adev->vm_manager.vm_pte_funcs = NULL;
> @@ -3979,6 +3980,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	release_firmware(adev->firmware.gpu_info_fw);
>  	adev->firmware.gpu_info_fw = NULL;
>  	adev->accel_working = false;
> +	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
>  
>  	amdgpu_reset_fini(adev);
>  
> @@ -5905,3 +5907,35 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
>  	(void)RREG32(data);
>  	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
>  }
> +
> +/**
> + * amdgpu_device_switch_gang - switch to a new gang
> + * @adev: amdgpu_device pointer
> + * @gang: the gang to switch to
> + *
> + * Try to switch to a new gang or return a reference to the current gang if that
> + * isn't possible.

If you're redoing this patch (as it seems you would given Andrey's comment),
I'd drop mentioning the return result as it makes it a bit confusing being at the end
and referring to something mentioned earlier in the sentence. Perhaps just this
would suffice:

     Try to switch to a new gang.

> + * Returns: Either NULL if we switched correctly or a reference to the existing
> + * gang.

Here you explain the return result, I'd drop the "Either" and say this:

     Returns NULL if we switched to the new gang, or a reference to
     the current gang.

No need for a semi-colon.

Regards,
Luben

> + */
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +					    struct dma_fence *gang)
> +{
> +	struct dma_fence *old = NULL;
> +
> +	do {
> +		dma_fence_put(old);
> +		old = dma_fence_get_rcu_safe(&adev->gang_submit);
> +
> +		if (old == gang)
> +			break;
> +
> +		if (!dma_fence_is_signaled(old))
> +			return old;
> +
> +	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
> +			 old, gang) != old);
> +
> +	dma_fence_put(old);
> +	return NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 3255b2fca611..f3a1fdbd41a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -180,11 +180,29 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  		kfree(job);
>  }
>  
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader)
> +{
> +	struct dma_fence *fence = &leader->base.s_fence->scheduled;
> +
> +	WARN_ON(job->gang_submit);
> +
> +	/*
> +	 * Don't add a reference when we are the gang leader to avoid circle
> +	 * dependency.
> +	 */
> +	if (job != leader)
> +		dma_fence_get(fence);
> +	job->gang_submit = fence;
> +}
> +
>  void amdgpu_job_free(struct amdgpu_job *job)
>  {
>  	amdgpu_job_free_resources(job);
>  	amdgpu_sync_free(&job->sync);
>  	amdgpu_sync_free(&job->sched_sync);
> +	if (job->gang_submit != &job->base.s_fence->scheduled)
> +		dma_fence_put(job->gang_submit);
>  
>  	/* only put the hw fence if has embedded fence */
>  	if (job->hw_fence.ops != NULL)
> @@ -258,12 +276,16 @@ static struct dma_fence *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>  		fence = amdgpu_sync_get_fence(&job->sync);
>  	}
>  
> +	if (!fence && !job->gang_submit)
> +		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
> +
>  	return fence;
>  }
>  
>  static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  {
>  	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
> +	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence = NULL, *finished;
>  	struct amdgpu_job *job;
>  	int r = 0;
> @@ -275,8 +297,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  
>  	trace_amdgpu_sched_run_job(job);
>  
> -	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
> -		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
> +	/* Skip job if VRAM is lost and never resubmit gangs */
> +	if (job->vram_lost_counter != atomic_read(&adev->vram_lost_counter) ||
> +	    (job->job_run_counter && job->gang_submit))
> +		dma_fence_set_error(finished, -ECANCELED);
>  
>  	if (finished->error < 0) {
>  		DRM_INFO("Skip scheduling IBs!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 0bab8fe0d419..615328130615 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -51,6 +51,7 @@ struct amdgpu_job {
>  	struct amdgpu_sync	sched_sync;
>  	struct dma_fence	hw_fence;
>  	struct dma_fence	*external_hw_fence;
> +	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
>  	bool                    vm_needs_flush;
> @@ -80,6 +81,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
>  void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
>  			      struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>  void amdgpu_job_free_resources(struct amdgpu_job *job);
> +void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> +				struct amdgpu_job *leader);
>  void amdgpu_job_free(struct amdgpu_job *job);
>  int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>  		      void *owner, struct dma_fence **f);

