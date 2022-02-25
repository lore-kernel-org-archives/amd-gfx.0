Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF49C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 04:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732C410E743;
	Fri, 25 Feb 2022 04:52:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E6C110E743
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 04:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvT7bAS6Dp1OAQygIpG6X9xxXoASts4i4IqgA5rQh8cc3QCj9J4ZshR+PK3jyd+TQCXXIiBC662L7Pji3F+tpL6LQFAfDxEO/11you81crINBYqQnfuoBYmH079pcvtS7jXACi+W5D08Tt4XRSxS0v7xzDh7UVqCCrDcj3NTDbP6mssBLBrnZPMp+SQ3EH29OWPI4ZsSHSO/VeUgalM8UQtPMXV5DyPCSZg6RpQLAQAy4XPl6owX2R3YqBCdusF+uRJ+xeYyQNwkSr31EYkjc3oxm+dYByysSL+ymVEWeDK6PHJ0AMED0m9nra51cefasX7EzrMXoRI8EapO6hOVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWVW1t2p2G3UqQ+LLrYRBp3ZAZmdBQx/b28zWKTso9E=;
 b=c9yAXJEClPJWt90mVKKCabOAip55SHwtLXZ5pSV4s3O8OZN2LXIFcb0zlzOUATv9p/GP/6fa/otboNOQmFSUCl+eHvoVDWzknxMWkE6wWGXKq9hRMs0i2wHz2fGoR995WVo23DLjp3GOGqtuMqN8Fg0fRJ0LPX21pNa2JpmJOdzENga6gtphpBgP2KaVQSSTKL536Y01WlsrO/FQ8x+txR5vIfxeiWv7CIEDYV0sq+tqMdnJ7MXREtNrVSAPU2YANG02QDQlPQc9DE1LoEvsdTqNp8JFk7a685013eRthxumxhuc5DhEYYXzCtTcLpqr+hrjejWepxf5Ec0EY/UhoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWVW1t2p2G3UqQ+LLrYRBp3ZAZmdBQx/b28zWKTso9E=;
 b=oM8eS2PZdBt6PvT2WX569UZ4U3SNekuhI5HLg8HmmR9PaWiO7REAzkmE/HrAmUK4/jb/L+/WXap5WSLgPWTb1kw5lQvuilXuFYIyZcSZ79012zrQOtPmAaxOBQ1MbZpYUgeByEyTcgkXYfn6L5mqja4vCKcc6iEXXBy3pzFmx3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Fri, 25 Feb 2022 04:52:31 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 04:52:31 +0000
Date: Fri, 25 Feb 2022 12:52:11 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH] drm/amd/pm: refine smu 13.0.5 pp table code
Message-ID: <Yhhge97jWmMpe/eo@amd.com>
References: <20220224144814.1997116-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224144814.1997116-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc0b84d3-5b57-46c6-4b64-08d9f81aa0f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35169BF2D0ED72131416C493EC3E9@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+I/TPjKXK224BLuufsvmCppPM9D9d9sTxbRYS8Gzn9axsovGWuVi8upZvURSY8jv5Oi5v3XaU+dqKfoU7QjXAcCBq6ZQu3gwHqqg3WAbTb2GIFcLmoUYBG50k6rAoU8NyEbkK7i1/rbnS8fbjMcfAOwo48yC4Lb9DTpWmIfb/a+FIrkYEJ1Noz8E1hUPLJvA60i2VcDwg1693UKC+QtEwKWxMy1OstaxThmYpi1hshZBZVEBL+IEu/rPcKJhIXhIux7CAs4Cb/KSzsLKPDxlXt45bV5AhI1Gmg7XDKx0g7U35WBAYRmc26gbABvJM1HnIP98SxqbnIJwIWj/VsH8YgbeNUaFB8TsMM73+lPY42SQgzQgUgtk7dZTrgRoH5s+mBcEomn12orQJG7320B+5Rb9BaaYsl4MNFpSh38T0IBkmV3AUQ+QnAUlKXi4FxybSJolqezrFYLo2wwXqByhg226oDUIhTPHmobh5ui2gIt4anFJPhx6LK9ptLMDjxDeuOvxqdMlbS+DwZOf9LGwuAwD+upsi8qLjaQsCeE/Oj/IujVObtrZMiNTgleAzJmXUkO2AqbsZScHMIiQvLsxSgdaxfpqNL7POmdbYmgkKbn2DAkHABkU4jIclhu/lRuV+dwK1DB04Fv5ptnAFDl2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(86362001)(30864003)(26005)(83380400001)(38100700002)(36756003)(186003)(8936002)(6486002)(508600001)(54906003)(6636002)(37006003)(6666004)(8676002)(6506007)(316002)(2906002)(4326008)(66476007)(66946007)(66556008)(6862004)(5660300002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tW5XKmalT+u/392yjS8QtcMKegNpp6FuKn93QutmAKwxnjaUnuskyOnvCAMc?=
 =?us-ascii?Q?W0j6QbB9axUrf3N+lbA/ATWl1bbzYbpZuvestlignPLfSjWcsndJF+OhtICi?=
 =?us-ascii?Q?eJF+7Re3dx4vMt/TcPMS1y/6Bi1whpgZlv9hjYUzuf/eyQbMpTOkQ5Wl30Bm?=
 =?us-ascii?Q?m4hfWT6HCEBzvLnQmtZt5bD1Ap7wQHcmJBZlktHMEjeq7Z4/wdzC3HY2JZaF?=
 =?us-ascii?Q?NMPFIw4jCb5BkL97oFLh0sbbV4jy0FC9ac7e6GHJXrOJSYN15KzKcyZloK/o?=
 =?us-ascii?Q?xiZ1XWeSdJi3sqclt4l8t/AsrlAF/2EaFkfp1BGqGrPN5sT7XS1Tk2d4jJ0K?=
 =?us-ascii?Q?p/xYbR0zePAXdeq5wQpBwFvRkGbY2mTuBl+0SYW/n8erL7EtiyDdKgBsOL/o?=
 =?us-ascii?Q?rIRC5JSpMe/qq1DrOcns4KJQxUWPoVOR1KpcbTu3ckmlycRyavqLy+atdAj/?=
 =?us-ascii?Q?nChkMCKNtUb7cJaXsWMdtNht0wDvK1NIBzU0Ky9r88vA0u1oJRvID/XC9qqN?=
 =?us-ascii?Q?CxvCk+xJrgGS3aCF3B/bX7mVNLMkSAWZisEstTp7v1fZhFiMAzJdKpOLPxMU?=
 =?us-ascii?Q?KKjxgr/5tnYH1mxjZZ8z95Wsb9uf2G2uJfAXi8417o6F0t5BxmYniRsmerNx?=
 =?us-ascii?Q?wm9+DbIPvtIVYSlE/TxWNNbDxkIoBl44KtKdwcIh9ZqJmMfU7ly3uaZAb6v3?=
 =?us-ascii?Q?TL6MO6hnQQmQNJ/+RkBkgZTVS2dPDdf0w0qP+81U/Kw49YpQziYC1ZTSHKNJ?=
 =?us-ascii?Q?dk4EOhRYuVyBHqfKIWFXS7w7SC/gZKW9svk8zosmmfTiKeiJ1GI7BdblLfpv?=
 =?us-ascii?Q?L7klKSWr31LNM5J4uJRBSpRWIYmO+A4eGOUPSUSHFUZBlxAZoLZmaCE017hQ?=
 =?us-ascii?Q?Xnungl4m3S58tNQRXNs7K8Ly/22lwLOVqpOm5sOzDm0n46WOYJRMIZahzxQZ?=
 =?us-ascii?Q?sR7oBF/tU7HwD54p6kWwuWYWKG/IxLOsD/aMFNF8/LxELcAL5Cgic8wUbu/h?=
 =?us-ascii?Q?bQ21sV5jfsBeLdHFm6yUJ1t0PYPPjbswNeuzkGK9y7uV6KR6vg/p0GQy+YYG?=
 =?us-ascii?Q?bX5XIwuHXQIWVDx1fWM2FfJmskUFv1S8D0jtQA1Xs1QzSG0mXml/kQpr4o72?=
 =?us-ascii?Q?sq136h9iZAFy1jCod9uKIBnQoFcegwfweXPzuPUEchT4kARpdK9klXLlPOx4?=
 =?us-ascii?Q?aS+gApNKD+DwRhu6NuYD6kzBE9JkzDiJHzG3K/x7jXiWur3cnBZSp0mDkilE?=
 =?us-ascii?Q?NLGd25pU3Z4WGPKsiPbWd/UIB7MG6ye/1TpUrMgEZ58EMLTpF16eAC9ptCTe?=
 =?us-ascii?Q?pJuzOZG8tq+r8dgYdsJMR/nYEdo+W+U/Kd1deawLdXKiUYvWsC0PDy2uS8Yl?=
 =?us-ascii?Q?Uyv3QtsZbOrbB2qfgVk+508hgy7cV7XPG2sOab1eeg09Gui7ZVjfQVZA0UAX?=
 =?us-ascii?Q?X2x1IB4Vt7X2+mdcX5Wfj+sk1ceWCctx0BjnBCKUEfs5UX5gzuP01eFWjkPC?=
 =?us-ascii?Q?Ff1MyvDFa6Y5VxUSZnhVqlFhS2i5wP0grLYz2HqiTFpZQ44Pq1Fmjwedk2Yo?=
 =?us-ascii?Q?ZAVlRj7jS4+vlu0wYaifh92eApithTG/TQrP+bl0rCGmIZrWkcXPahiXhJg9?=
 =?us-ascii?Q?URmOS88nbJncMFkjUwhGfqU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0b84d3-5b57-46c6-4b64-08d9f81aa0f3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 04:52:31.6678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OtrrsLXbiiaISnAm6/ItTWmSDGx0Ufbuz2P22jE55b5iEBicjnZ2XpIPTnN6mg8zpLnjihsH24SxPvhYpdZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 24, 2022 at 10:48:14PM +0800, Zhang, Yifan wrote:
> Based on smu 13.0.5 features, refine pp table code.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 134 ++++--------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |   1 +
>  2 files changed, 28 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> index 8ee5bcb60370..7bfac029e513 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
> @@ -57,8 +57,6 @@
>  static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
>  	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
> -	MSG_MAP(EnableGfxOff,             PPSMC_MSG_EnableGfxOff,		1),
> -	MSG_MAP(DisableGfxOff,                   PPSMC_MSG_DisableGfxOff,			1),
>  	MSG_MAP(PowerDownVcn,                    PPSMC_MSG_PowerDownVcn,			1),
>  	MSG_MAP(PowerUpVcn,                 PPSMC_MSG_PowerUpVcn,		1),
>  	MSG_MAP(SetHardMinVcn,                   PPSMC_MSG_SetHardMinVcn,			1),
> @@ -227,22 +225,6 @@ static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
>  	return !!(feature_enabled & SMC_DPM_FEATURE);
>  }
>  
> -static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
> -{
> -	/*
> -	struct amdgpu_device *adev = smu->adev;
> -	*/
> -	int ret = 0;
> -
> -	/* allow message will be sent after enable gfxoff on smu 13.0.5 */
> -	/*
> -	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
> -	if (ret)
> -		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
> -	*/
> -	return ret;
> -}
> -
>  static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
>  {
>  	int ret = 0;
> @@ -314,30 +296,6 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
>  	case METRICS_VOLTAGE_VDDSOC:
>  		*value = metrics->Voltage[1];
>  		break;
> -#if 0
> -	case METRICS_SS_APU_SHARE:
> -		/* return the percentage of APU power with respect to APU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> -		 */
> -		if (metrics->StapmOpnLimit > 0)
> -			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
> -		else
> -			*value = 0;
> -		break;
> -	case METRICS_SS_DGPU_SHARE:
> -		/* return the percentage of dGPU power with respect to dGPU's power limit.
> -		 * percentage is reported, this isn't boost value. Smartshift power
> -		 * boost/shift is only when the percentage is more than 100.
> -		 */
> -		if ((metrics->dGpuPower > 0) &&
> -		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
> -			*value = (metrics->dGpuPower * 100) /
> -				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
> -		else
> -			*value = 0;
> -		break;
> -#endif
>  	default:
>  		*value = UINT_MAX;
>  		break;
> @@ -503,12 +461,6 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
>  
>  	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
>  	gpu_metrics->temperature_soc = metrics.SocTemperature;
> -	/*
> -	memcpy(&gpu_metrics->temperature_core[0],
> -		&metrics.CoreTemperature[0],
> -		sizeof(uint16_t) * 8);
> -	gpu_metrics->temperature_l3[0] = metrics.L3Temperature;
> -	*/
>  
>  	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
>  	gpu_metrics->average_mm_activity = metrics.UvdActivity;
> @@ -516,28 +468,13 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
>  	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
>  	gpu_metrics->average_gfx_power = metrics.Power[0];
>  	gpu_metrics->average_soc_power = metrics.Power[1];
> -	/*
> -	memcpy(&gpu_metrics->average_core_power[0],
> -		&metrics.CorePower[0],
> -		sizeof(uint16_t) * 8);
> -	*/
> -
>  	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
>  	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
>  	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
>  	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
>  	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
>  	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
> -
> -	/*
> -	memcpy(&gpu_metrics->current_coreclk[0],
> -		&metrics.CoreFrequency[0],
> -		sizeof(uint16_t) * 8);
> -	gpu_metrics->current_l3clk[0] = metrics.L3Frequency;
> -	*/
> -
>  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> -
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>  
>  	*table = (void *)gpu_metrics;
> @@ -652,9 +589,11 @@ static int smu_v13_0_5_get_current_clk_freq(struct smu_context *smu,
>  	case SMU_MCLK:
>  		member_type = METRICS_AVERAGE_UCLK;
>  		break;
> -	case SMU_FCLK:
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
>  		return smu_cmn_send_smc_msg_with_param(smu,
> -				SMU_MSG_GetFclkFrequency, 0, value);
> +				SMU_MSG_GetGfxclkFrequency, 0, value);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -891,14 +830,6 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
>  		msg_set_min = SMU_MSG_SetHardMinGfxClk;
>  		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
>  		break;
> -	case SMU_FCLK:
> -		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
> -		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
> -		break;
> -	case SMU_SOCCLK:
> -		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
> -		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
> -		break;
>  	case SMU_VCLK:
>  	case SMU_DCLK:
>  		msg_set_min = SMU_MSG_SetHardMinVcn;
> @@ -925,6 +856,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>  {
>  	int i, size = 0, ret = 0;
>  	uint32_t cur_value = 0, value = 0, count = 0;
> +	uint32_t min = 0, max = 0;
>  
>  	smu_cmn_get_sysfs_buf(&buf, &size);
>  
> @@ -945,7 +877,6 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>  	case SMU_VCLK:
>  	case SMU_DCLK:
>  	case SMU_MCLK:
> -	case SMU_FCLK:
>  		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
>  		if (ret)
>  			goto print_clk_out;
> @@ -963,6 +894,27 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>  					cur_value == value ? "*" : "");
>  		}
>  		break;
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
> +		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
> +		if (ret)
> +			goto print_clk_out;
> +		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
> +		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
> +		if (cur_value  == max)
> +			i = 2;
> +		else if (cur_value == min)
> +			i = 0;
> +		else
> +			i = 1;
> +		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
> +				i == 0 ? "*" : "");
> +		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +				i == 1 ? cur_value : SMU_13_0_5_UMD_PSTATE_GFXCLK,
> +				i == 1 ? "*" : "");
> +		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
> +				i == 2 ? "*" : "");
> +		break;
>  	default:
>  		break;
>  	}
> @@ -971,6 +923,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
>  	return size;
>  }
>  
> +
>  static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
>  				enum smu_clk_type clk_type, uint32_t mask)
>  {
> @@ -982,8 +935,6 @@ static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
>  	soft_max_level = mask ? (fls(mask) - 1) : 0;
>  
>  	switch (clk_type) {
> -	case SMU_SOCCLK:
> -	case SMU_FCLK:
>  	case SMU_VCLK:
>  	case SMU_DCLK:
>  		ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
> @@ -1012,31 +963,19 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  	uint32_t sclk_min = 0, sclk_max = 0;
> -	uint32_t fclk_min = 0, fclk_max = 0;
> -	uint32_t socclk_min = 0, socclk_max = 0;
>  	int ret = 0;
>  
>  	switch (level) {
>  	case AMD_DPM_FORCED_LEVEL_HIGH:
>  		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
>  		sclk_min = sclk_max;
> -		fclk_min = fclk_max;
> -		socclk_min = socclk_max;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_LOW:
>  		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
>  		sclk_max = sclk_min;
> -		fclk_max = fclk_min;
> -		socclk_max = socclk_min;
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_AUTO:
>  		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
> -		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
>  		break;
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>  	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> @@ -1064,24 +1003,6 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
>  		smu->gfx_actual_soft_max_freq = sclk_max;
>  	}
>  
> -	if (fclk_min && fclk_max) {
> -		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
> -							    SMU_FCLK,
> -							    fclk_min,
> -							    fclk_max);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	if (socclk_min && socclk_max) {
> -		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
> -							    SMU_SOCCLK,
> -							    socclk_min,
> -							    socclk_max);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return ret;
>  }
>  
> @@ -1117,7 +1038,6 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
>  	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>  	.set_driver_table_location = smu_v13_0_set_driver_table_location,
>  	.gfx_off_control = smu_v13_0_gfx_off_control,
> -	.post_init = smu_v13_0_5_post_smu_init,
>  	.mode2_reset = smu_v13_0_5_mode2_reset,
>  	.get_dpm_ultimate_freq = smu_v13_0_5_get_dpm_ultimate_freq,
>  	.od_edit_dpm_table = smu_v13_0_5_od_edit_dpm_table,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
> index d2e872c93650..40bc0f8e6d61 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
> @@ -24,5 +24,6 @@
>  #define __SMU_V13_0_5_PPT_H__
>  
>  extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);
> +#define SMU_13_0_5_UMD_PSTATE_GFXCLK   1100
>  
>  #endif
> -- 
> 2.25.1
> 
