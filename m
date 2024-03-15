Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D00C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 10:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E16B11213F;
	Fri, 15 Mar 2024 10:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYAZq4b8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1C911213F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 10:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I24Y2It71oJlZw9Fl78fmrk6E/yphVYGuS+DRygaz/xwFkHCaPKcWdF8/ROFZV1KU2P4KES7Y/ngqkt/sU5LKxslgYXPiiMkZzPu8kXDewrZirh/8+kW3WiFmBWvbpnhKxueq77CTiyGvNWaC7FJ1cdQ9knZC+S/sRyvrvyI7h0PGkZj4qc7CTclGJpCqSr12UYulnNfDwUbh1uFCTyzsS5MvP+O5ajplPr/0+cv1z9Z2A08PcsGj3hicFVyrYmEmofx+Zl2Xz7nJ4Rt8Lnf8oD9u0Rz5cmLi5VrVRarGDdwp6x8heqHpHyiOnLG4JK05aACKfe+xDFAKOG+XFMTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjCrG6VIwBlZLqmSPCsdYTP+O2+Lsyu1UXRQzWIVXtY=;
 b=DgPz2mXSGkS7L3aJnm8l3RCsXtUwvEcSoyP6vxsSHKumHqwVHbq8IQ7hgl1JVS7g5xvEGlVocXXbx/0bZrO5fRgJrvEYFEQ1XyKiFS5H4ujkhYxzKZhy/ptOpC7OwINtXbEEkRKmOFPM8XWLaKXwhEL/YB2PhaHXOwbsOvxG6xVaGiN66rF0Y0RkCCLtqPn1N4kkh4VExxLF7r9GAUQDYjVLRuMqgrFyrk8I0KOjqMA25xe5r+7U6qB+Adee7wPv+M8Sw8NWCEDU4AABmWIOOrpSTpxT5ForJf6VWAJSLSDnxBUeX2OO9OQm0rZLGArTqJhUgA71etXzDMmHUNS8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjCrG6VIwBlZLqmSPCsdYTP+O2+Lsyu1UXRQzWIVXtY=;
 b=EYAZq4b8Sj+0YwwsC0FJLfproujYT9OXImpT2kiuW2XDFynRnpPAZZOEfbvpku9HaNLT4VGFMrNdGTp5djCBC6w0W22wos/3c256zZ2X2EszsaqBOivFSnAGsydui0h03W6pNsJ3rVncXWrL24gta018HXetEktmiSS1h9PFIdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.20; Fri, 15 Mar 2024 10:47:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 10:47:22 +0000
Message-ID: <9a6d4454-8071-4981-89c5-8ee55d5cb583@amd.com>
Date: Fri, 15 Mar 2024 16:17:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Content-Language: en-US
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com
References: <20240314165409.17657-1-Zhigang.Luo@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240314165409.17657-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6038b03e-f264-43b4-4cae-08dc44dd4b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/uCiURQ0hsLprAjrwRzMwEHGSEZ9NQMRvWHyadajnmb1RtdfZJ5rZDZljgaVSmbJPDpV9oOh34Kh3py/MyaCBy04onVs/vBd28vXX3eGA0Sbo1T5ho7fTsRJ91o5oW89mp0iNtqrpvhnNENa6YXEMNa6d7qpkqX+bsc15TFmTxPnWCxKvf48UWnUkQ8ryDTTPkq4qBosqTLaAky18tGwM0c2JQ4rvHFxNK0mvH+U/NPGBaazotWdLZxPt29R/UtAx/prSKENXzUII3JuLAG88sLkhM5hvgqaRxWlE3mQfGADql+uJV9dGHBWoYb228CZGPUZ2MegzB+gTp2tLDoq0fluau6b1NkNNobiLxsosE+fNNFm1l2IPvpJxIylcyh4+2DgO8mayg+Ysur5aMhc4AMSe2Q4/EWAk/f3KxJaC2CY+7R1X6k5ipWeCBVhBH8tfyIdYp4dqk7IEv4UjQe5qNJtSeFpJyniSuw5jcWPBShgKw+KfUvTcA6K4bjbkRYYe3soQNdr72NvPhg4SOEyaWED8vMoFJG2+tJWzw39A1un9rbYrKiVBdeuQrxmEse4IbT70S5NPyHYnwLq13KM7XsgZL1VnTSd/5YAfvuG0ex/3ysja+kEk3I3x41NTomeMMQdDKE6dBUnLabBhNwuAEiO5gdFx7L0EjWyc+WLT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzF2eEF5UTZxMStpN0NGMXZ2Y3RQMzJ1ejhob2JoNXRjQlFtNVlsM0VIWkE5?=
 =?utf-8?B?ZS9samFKdHV0UlROVER1MEd2QS82ZmQrbDlCdUI4Um9FSTBNSFFUSzlCYklM?=
 =?utf-8?B?ZVVzaW8xblc3b0ZFeS94aVI2bGxGSXFBSW9zY0tmYUtYRHVRZDYwSVZIY1lX?=
 =?utf-8?B?cmJWK3ptS2UzeWZuMjFEang5SGVHTEFLZ3JYcEJ3ejFjTjRyaUkzVVJTSGE2?=
 =?utf-8?B?Y05GZERsSWEwZFlkaDRwYlkxK2dwY1AwY0s3SWdkV3JnbjJUQ1RUbDZNZEQ2?=
 =?utf-8?B?cUtHME9NZW8xNUxzQmpBUlA3L2pPbWRacHBlaVk1U2ppY0t2OWpHV0JaWGQr?=
 =?utf-8?B?U3FDbGxhajAvT1RiYjRIb2tvZ3o0ejh3NUxXTmVYQ0lOd20wMXN3ZEVmcThM?=
 =?utf-8?B?SWVwUGFEb1RwemFVajBGZFFrM3RDdEU1MFB5TCs2d1V5VGZqZ2JzOHMxT1NF?=
 =?utf-8?B?ZllqMlIyT3dMVDkyUVF1SThDYVhJSkY1RkxmWnNmaGZycVQzS2l0dkxvb0ZP?=
 =?utf-8?B?eGxPd1ZFSjNOQXlQWXlkekFjR2ZvdjF6aFZRVktQSzNPRXdSZm9kWllXbnZL?=
 =?utf-8?B?UURXK0dDNHpuT05wQkZCZmJ6Nnk2SFRJUFVHQnJNK213MUZHNWJxaUtlMEhP?=
 =?utf-8?B?TitnSEk1OGMyOGEzMFh5QmsvaWJrUTA0VktOWWRDY2M0NHgwUFprV1hSUktl?=
 =?utf-8?B?cUNEcmdNVC9INU1lTEEvQ2JHakZzTE5HanQ1bTdiUEdBMTNBTGZKNjNZc0t0?=
 =?utf-8?B?U3VsV0laSjZ0QWhJOUx3RHBSa2FvNVpXbVY3T1ZieEI0YmVYSUQvY005Uldi?=
 =?utf-8?B?TThTMkhWaVU5WnR0VWNJUFY5MG1qK2diQXgwWVJ3a2lncCtUd000Q0J6SDRM?=
 =?utf-8?B?SWZSU1l2SklNL1A4RGZ2RUp4RG52MmpoWDQ4QUs5RlB2alE4TzFnRWFtbHJ0?=
 =?utf-8?B?N1g4bC8yUEZKWVhrdmRNZDBJK2J5MDNXODQ2U0xiOWxQZTJJMHc3SkdrZ0JG?=
 =?utf-8?B?dExONTZBdE1oOW11clNiSm1naG5SVURHK3l6dDlhRUx3c3M4MTQ5L1lXbkx2?=
 =?utf-8?B?ODY1d2tiZ3E4dlZyM1R2Nm1hcFBZaTdZTzZkSHZHbWhsTTB2M21Kc1FYcEkr?=
 =?utf-8?B?dDFMZmltV2tSTWVWMjQ2NTBNVER3TnVzcGpmRThsZGduQTlRemtlbkozV3pV?=
 =?utf-8?B?VmJKY1d1N2xRZWlQeElwcnVQTVcvOVRySUtpVWJaOFJhNjVtdTQ3T3BhWi9P?=
 =?utf-8?B?UGc5M29FN3RhRHZIUHg3aHNzemtOZUxCKzBDeHdnMnd0VWpKQ2ZlWDlUWllJ?=
 =?utf-8?B?b05VQWE3M3FmczUzTFZyZnRzdnE5WEl5ZkZwRzBjc2s1RHpTVGJidEZyVnpK?=
 =?utf-8?B?OU9sWnhhc2IvWGZ0a3E3S2RWbTVZSnFNNURZNWc3ZXVYanowK01kZEFETkNN?=
 =?utf-8?B?eVlNMDNWZnphS0NNaWJ6azAxdmNQZWsxdkJKMWhMMVI1VHdQc2pGTVpsMEtv?=
 =?utf-8?B?R2pnU3dIZXNEMExFcXFQckRpUzRZUlhyOXJSdzlxMEdjUDVnM2x6L1hPZTM5?=
 =?utf-8?B?ZDg4NnZGRTNpZnkralptODlYSUlTbktGaUhJaUNheS9JRGJnaFJST0ZHTkJT?=
 =?utf-8?B?RWNPaEVIY2pBMUhTRmtuNVVFWnZRN0N0VmtkeUZkR2ZJOUtHc2NvVlRsc21E?=
 =?utf-8?B?SzF5TUdHeWpnUUFyZlBaVnlqY1RNYzFIVjlJcnFzNmNHcFNpbVdBVEN1RXJF?=
 =?utf-8?B?L1pQMmllM2Fnd2E0NzZwQVI0VWdDek1mU2xqWEo1UnFjRy9HbytWVE0wMWdF?=
 =?utf-8?B?TkpRSklFYnVGaDlvemNJWW1wRXZJZHVtS1dId0xnV1hncm10WFBDRDhHZmVs?=
 =?utf-8?B?ZStzR2hPYkRtWG1wUFRNZHBNdXJ5WTJHRlplcnBsVnJNRTdMTXU0TS90WGMz?=
 =?utf-8?B?dUsyL1AwS25TRzBDMHNJeFA5NHdCa3UwVjV4dmhKT2Z4dHFoeXZhUU93TElV?=
 =?utf-8?B?bUZFQ2ZrMms5NVpNN05NazhuSVBKY2k2OU5URDMyZlRZWjhLNHJ4T0pzYkdN?=
 =?utf-8?B?a3ZBeC9Fa0taSHNaUlA3ZzRqYkord21aS2xIbEdBL0ZwNkF3WWRLOE94bFhT?=
 =?utf-8?Q?CNI3Fq5lzeVHVyAhAPclg3P9M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6038b03e-f264-43b4-4cae-08dc44dd4b30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:47:22.3230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6duiDbQSRZ3FMOKThtdNq3ak5Kd9hPI5tkvsOPUUuAXUsfI8AAWEyJnZtBzLafpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
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



On 3/14/2024 10:24 PM, Zhigang Luo wrote:
> if reading pf2vf data failed 5 times continuously, it means something is
> wrong. Need to trigger flr_work to recover the issue.
> 
> also use dev_err to print the error message to get which device has
> issue and add warning message if waiting IDH_FLR_NOTIFICATION_CMPL
> timeout.
> 
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: Ia7ce934d0c3068ad3934715c14bbffdfcbafc4c2
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 29 ++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 ++
>  5 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e9454e6e4cb..9bb04a56d020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -143,6 +143,8 @@ const char *amdgpu_asic_name[] = {
>  	"LAST",
>  };
>  
> +static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
> +
>  /**
>   * DOC: pcie_replay_count
>   *
> @@ -4972,6 +4974,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  retry:
>  	amdgpu_amdkfd_pre_reset(adev);
>  
> +	amdgpu_device_stop_pending_resets(adev);
> +
>  	if (from_hypervisor)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	else
> @@ -5689,11 +5693,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  			tmp_adev->asic_reset_res = r;
>  		}
>  
> -		/*
> -		 * Drop all pending non scheduler resets. Scheduler resets
> -		 * were already dropped during drm_sched_stop
> -		 */
> -		amdgpu_device_stop_pending_resets(tmp_adev);
> +		if (!amdgpu_sriov_vf(tmp_adev))
> +			/*
> +			* Drop all pending non scheduler resets. Scheduler resets
> +			* were already dropped during drm_sched_stop
> +			*/
> +			amdgpu_device_stop_pending_resets(tmp_adev);
>  	}
>  

For better consistency - you may make this path common for both VF and
bare metal. Call this right before "skip_hw_reset" after a successful
reset. All pending reset jobs submitted may be cancelled at that point
once a succesful reset of the device/hive is completed.

Thanks,
Lijo

>  	/* Actual ASIC resets if needed.*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 7a4eae36778a..4e8364a46d4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -32,6 +32,7 @@
>  
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>  #include "vi.h"
>  #include "soc15.h"
>  #include "nv.h"
> @@ -424,7 +425,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  		return -EINVAL;
>  
>  	if (pf2vf_info->size > 1024) {
> -		DRM_ERROR("invalid pf2vf message size\n");
> +		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
>  		return -EINVAL;
>  	}
>  
> @@ -435,7 +436,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
>  			adev->virt.fw_reserve.checksum_key, checksum);
>  		if (checksum != checkval) {
> -			DRM_ERROR("invalid pf2vf message\n");
> +			dev_err(adev->dev,
> +				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
> +				checksum, checkval);
>  			return -EINVAL;
>  		}
>  
> @@ -449,7 +452,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
>  			0, checksum);
>  		if (checksum != checkval) {
> -			DRM_ERROR("invalid pf2vf message\n");
> +			dev_err(adev->dev,
> +				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
> +				checksum, checkval);
>  			return -EINVAL;
>  		}
>  
> @@ -485,7 +490,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>  			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
>  		break;
>  	default:
> -		DRM_ERROR("invalid pf2vf version\n");
> +		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
>  		return -EINVAL;
>  	}
>  
> @@ -584,8 +589,21 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>  	int ret;
>  
>  	ret = amdgpu_virt_read_pf2vf_data(adev);
> -	if (ret)
> +	if (ret) {
> +		adev->virt.vf2pf_update_retry_cnt++;
> +		if ((adev->virt.vf2pf_update_retry_cnt >= 5) &&
> +		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
> +			if (amdgpu_reset_domain_schedule(adev->reset_domain,
> +							  &adev->virt.flr_work))
> +				return;
> +			else
> +				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
> +		}
> +
>  		goto out;
> +	}
> +
> +	adev->virt.vf2pf_update_retry_cnt = 0;
>  	amdgpu_virt_write_vf2pf_data(adev);
>  
>  out:
> @@ -606,6 +624,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  	adev->virt.fw_reserve.p_pf2vf = NULL;
>  	adev->virt.fw_reserve.p_vf2pf = NULL;
>  	adev->virt.vf2pf_update_interval_ms = 0;
> +	adev->virt.vf2pf_update_retry_cnt = 0;
>  
>  	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
>  		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3f59b7b5523f..eedf5d44bf00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -257,6 +257,7 @@ struct amdgpu_virt {
>  	/* vf2pf message */
>  	struct delayed_work vf2pf_work;
>  	uint32_t vf2pf_update_interval_ms;
> +	int vf2pf_update_retry_cnt;
>  
>  	/* multimedia bandwidth config */
>  	bool     is_mm_bw_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index a2bd2c3b1ef9..0c7275bca8f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -276,6 +276,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>  		timeout -= 10;
>  	} while (timeout > 1);
>  
> +	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
> +
>  flr_done:
>  	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
>  	up_write(&adev->reset_domain->sem);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 77f5b55decf9..ee9aa2815d5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -309,6 +309,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>  		timeout -= 10;
>  	} while (timeout > 1);
>  
> +	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
> +
>  flr_done:
>  	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
>  	up_write(&adev->reset_domain->sem);
