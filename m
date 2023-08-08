Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85798C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 12:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F32010E3DE;
	Tue,  8 Aug 2023 12:28:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDC6A10E3DE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 12:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHU7oHDmmaQ71OvDsaiaXjMy9Xi48xM5/dWU1+GSNEt8Dq0FEVkmQcpsIJzq3zyJOG90IpQUUenR9004c0w8kH5FVTvUNuZTJIe7CCox2t5R22dKyhFqVso1zRSaR7TC/NU2siKXINW07wSRyU1LjqJ22fLVWXYqzVvhFopApFKDMjC1X7a3pfOg0Mp3kD3HRtcOBj1CigtHl+7o6noRtNiqHrGf986nIcgVkQN7MKi/s5YggTT/P3tx6AOF0ns9pbN7V5n7igddvEXg4dyItJWP1IMgg62UEU003KVTR+OCpAGyekVg1nWy+mWYGsc6abYpeiKmTToqqDVEzsDPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di1x1xilpOEUQYWnYsdTJ2lsHnZgFFEFl7SMDDF59hs=;
 b=L1iWReen+j5ob7zEl7QsxPq2Qt8ZEPf6rZkaXwVkQIgqptjNzmItM9qF/efN58bwXki2HDmC4/617MYdFROxSbzbE6oEuG905qLJlKiaKYyAnGh6Lzt+4wi3ccHjfNferTfjTR5e5gGweK8sjrtpzz/+Gj8ZyCv2GxNHvx97Ofgk+CpX9fkq3b4I8Nqm3OC3cvGlmdWUazoVxcHOmGda6PtTWlW2w01bsblIiNZ5ykyYPMMJunP8+a9uqHfc7v4YCzR5DSIqbneyux96UTEIxxYUhy0L6e+NRa2ilD6BTq0zw0KXjK0309CBmXj7ymPy7VsVrzFh9sV8hPSxR5ZVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di1x1xilpOEUQYWnYsdTJ2lsHnZgFFEFl7SMDDF59hs=;
 b=SNUDGAMCbByRdGzMYGUIbIpylw//8PuPnYMh/pg8xMcgvV917K87R0yvYT6hmtOFdQ/KQHK8i58A6y5JBB58NaaF/t2Kmn6yN6mgcTCcnpD+Qk+A6ep8z0MMY1mGgCWSIQSPlxNClmQkryrhcL+CVuGu8qIXrkwu/WMBYhlP0cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Tue, 8 Aug 2023 12:28:49 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:28:49 +0000
Message-ID: <3a3702a4-7151-1b5a-732c-fe4ba98ae5ad@amd.com>
Date: Tue, 8 Aug 2023 08:28:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
To: Samir Dhume <samir.dhume@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230728191541.1778424-1-samir.dhume@amd.com>
 <20230728191541.1778424-3-samir.dhume@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20230728191541.1778424-3-samir.dhume@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0281.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::26) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d64a0a0-2800-4b45-2ec5-08db980b0415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qVdlKt0Alnaf2agX5suZFl/PDRFNUEoYXtkNtuDsGvx/6QDOiK1krvNNHb4ADvjjd9zavgsEmcnmOnct3rbD6Xc8tl67jsR/GKB7ujAc7Og1bLQwVF6m9ugsijjefPQmJNPs0DzjqiCGmWtb0Bljpqa5nD8wzQHxXf9cal4NiJzJljn+th88HZxo9vxwGW204jaf2PGqYbuUYyaFYyw0LgXKHHciLex9TtXFdJ+31Yk1fD57YxWpk5plJ3Y3k6i4hzSdi6v2GK2PX20GPDJhn7qljdVdg7ztj1FnEpwBkG5EX4RxxkdG9S3Q9fE6n++8DpaQFGrwrjpegGU9Cxr/Ke/wL79T4CJMUNnxQMgHpDedsiOjbOQjb2XauSbEDJ7srBJ+MJmkvUKUsKKHm1bIwgN195OCT9SVwEeOddr9+YM1GVXZx3QhbaR295OUlkpvxUAccMPH5ahs6T3RsPS4HczG/Ux6Tcp+yiTBROe6bUhE8ttoS9JfD+F9tKXqJm/VgksZj44no26Tl0B6VDRRMhaNC6pz/QCx4gV4p2/jVmlc1JYLCt2IIHNEFUa7A96KB0cb/mRGQ6RZAxrU0xPUn9XQQfLbXzfiLU18CeJ4ToMI9TMkdF5RyOhljeuBc9GSkLmdOvtnQ3hLo9ceZlXhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(1800799003)(186006)(451199021)(36756003)(86362001)(31696002)(83380400001)(38100700002)(6486002)(6512007)(6666004)(6506007)(53546011)(31686004)(26005)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(30864003)(2906002)(5660300002)(44832011)(2616005)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGUzQU1pL0NWblFpQnowN0QrcVA2WnN1SW9yaWFqWUhiTmVneVJ2Rk96WGlm?=
 =?utf-8?B?c0d1c1BTcFZVKzdibldmUnF0cDRjY3hOZjYyam9rYWNYU0JIWWZTL0hkRmhJ?=
 =?utf-8?B?RERGTUk5MVZqblY3MUlaV0xYQmhIWkx5UzAwNnhCOW9oSWZ6b3cvYXlTcVRm?=
 =?utf-8?B?eTNHNHZWeXNWYldxd0tkREhNZzQvY0tjREF5RnNzSVdFZGN2dUV3TzF4a0Ur?=
 =?utf-8?B?RkFvT0tIYnRSVENPRXBzQUlCamEyV0NZMDBaT29XVGtFajVscysyaG5UVXJm?=
 =?utf-8?B?STZNOXFBWG9UTVZhU09ESGNpcE1NaGFzVzdJamFMRXJRL1ErdHI0dER0VnZa?=
 =?utf-8?B?M0o4bENlWklaMTlJbG9NaGJ2Z05nSWVQb1JGVkRET3FyZjAyeldpdnFjdlpn?=
 =?utf-8?B?Ym9aenVmTUVxUGExWHZoYkY1enB5TzBUNFFjdkpHNEdEQWI1UWl4Z0dUQm5J?=
 =?utf-8?B?UDhoTVN0OXlrTnV3QURvdjF0aUE0Y1JkZWp4Y0IvRHkyV0VqQ0hjQkQ0cHUy?=
 =?utf-8?B?THJhakdJNGhQU1VlUElUQk1NZVlrem9vemo2ZXp1ZjRCMWpNWTRsT2o2SFdW?=
 =?utf-8?B?a1M1ZThSdlgvY2JKSDRyUUZJRkhGT3g5ZjdLUGdnSml2VGZERlpDYmQ2ditl?=
 =?utf-8?B?MTUvUzZnWXQyaW9FZWhNOFM5WVJ4SmhYdnhwcnh0SjNvSnJUZ3NmRHdyNVZj?=
 =?utf-8?B?U3hXUmI0QVBudklaQUphWUs4T0VIWWpEVzlidFRybzFycXhqRWZ2a3JjL1Yx?=
 =?utf-8?B?bis4NE5QSU9udERoMWc4a3puemgzMmFiemFIUlBJaE5vbk9yYzRZZ3o2aGNH?=
 =?utf-8?B?V2t5bDcyWGM4YjFUYnIzQWNPRTlqT2s1a3NZRDByc01WR2llN0N3RUdiQWpq?=
 =?utf-8?B?ZE81K21pSWpQelBHWmt2SS9PZzE2alQ3ZmVsMWlreTM0Mi9qak02KzluczdL?=
 =?utf-8?B?UTViRG1EN1FYcTBBeS9GTEJQYUdORDFWSWo3OGs3M2hwSmc3ODZxK1lwbVph?=
 =?utf-8?B?T2JiMHg2OHJOa3hYcUgrdU9VcU51N0dsRGwramFCTGIwSVVGZ08rZmRXS3VW?=
 =?utf-8?B?VVFPTEtDQk5sRnVZeDRrbm1IVE5RaC9LNTY1VXlxcTV2QVVHUDZJMko0cE50?=
 =?utf-8?B?RDFGQUNvQ3dBNnU3NGphcWxjUVRFdHlxQWZ0Z3h2U1VNd3pLVlh5ZFVmaHNJ?=
 =?utf-8?B?dnp0bkEzWnJkckVFOFRGVkF0M1QwcVFGRlpuL2ZOUFdwQXlkY1FPWkpLcXdX?=
 =?utf-8?B?MTQvaUVBYXNnSThUcnNqdzNBLzhOSXZlTEZkakwrWDgzeHo1dk1QUks4djcy?=
 =?utf-8?B?dldSNDVKUGlVQUhFazh0ZGIrRHhqNDd6cG55cldma2drMkUwV2kxRkVVdWQv?=
 =?utf-8?B?RW9ZYVNxdHd6Q3kzVThJcWc2MDl4d0dDYlRqdG95MGJlNVgwWHp0NVFvTmlU?=
 =?utf-8?B?UUI0Z1c2TEk2aWRVM0wvblNIVWswYnZvVVlveHJLUE5DcVFsWlBvQzJNM1FL?=
 =?utf-8?B?T1ZqMENMdTI3d2hNcm1ZdEN2dXVycVBROXpqQzBFTU5qWThFQWZielFGbDJF?=
 =?utf-8?B?YkYvNGV0ZFJ4ckVGUFVZYzdORWRMeUVLVDZiUjd4Qyt0bzJHU05ab0RSOFN6?=
 =?utf-8?B?MmpoNWJVSXNLM3JSZlR0VUIrQzhNeGp1ZjBVNzd6VHMrT0ZnNFNKVVZJRk5Q?=
 =?utf-8?B?VzhvUE5MWDdKQ21Yd2FJMzNwL2tZVTlrS21vUS9OSmMyTXUyWmdBQ3d3WG4x?=
 =?utf-8?B?bm9Za2wxSmFXTWFud2ZzL0ZJVVRzTDkwb3F3OHN2cHAwcmY2OUVSU25Hd0hz?=
 =?utf-8?B?MUFDZUxSbElQYWpid3J1amlxRHBoallnbmM0citVQnpMZU1qN1JzK1lKVXNs?=
 =?utf-8?B?K2lDaGhlUkxYbjNaRFNNQVZYRVVnMC83ejdUMk1KK2QzTDVPVWxaZFRJQmVY?=
 =?utf-8?B?ZFczUWhQcmI3WUNpL2U3MkNJLy9zNEF2MTZYS2tZcXovVXh1N0JmZGs5cGpE?=
 =?utf-8?B?bXhLS25yeFo4dFluVFVXcERjSmdNK0gvT3pISlFpWStpU1crM21wczVmSkly?=
 =?utf-8?B?VTV5dWlpOHBGSzNIc3VoT0gydU5Bd0JPdWRKd3lESW85WXNyVE9KdjNPVkRq?=
 =?utf-8?Q?z76I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d64a0a0-2800-4b45-2ec5-08db980b0415
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:28:48.9253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HYTa5XK432KQBVp5fxqw4dNKopVoHpk9bg4LQ44iA3Kw+vUiHW5s23UIf/QN/L5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, frank.min@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-28 15:15, Samir Dhume wrote:
> initialization table handshake with mmsch
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 257 +++++++++++++++++++++---
>   1 file changed, 233 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 411c1d802823..b978265b2d77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -31,6 +31,7 @@
>   #include "soc15d.h"
>   #include "soc15_hw_ip.h"
>   #include "vcn_v2_0.h"
> +#include "mmsch_v4_0_3.h"
>   
>   #include "vcn/vcn_4_0_3_offset.h"
>   #include "vcn/vcn_4_0_3_sh_mask.h"
> @@ -44,6 +45,7 @@
>   #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
>   #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
>   
> +static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_3_set_powergating_state(void *handle,
> @@ -130,6 +132,10 @@ static int vcn_v4_0_3_sw_init(void *handle)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>   	}
>   
> +	r = amdgpu_virt_alloc_mm_table(adev);

Since this function is not for bare-metal, please move amdgpu_sriov_vf() 
check from inside of the function to here, to avoid confusion.


> +	if (r)
> +		return r;
> +
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>   		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
>   
> @@ -167,6 +173,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>   		drm_dev_exit(idx);
>   	}
>   
> +	amdgpu_virt_free_mm_table(adev);

Same as above.


Regards,

Leo



> +
>   	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
> @@ -189,33 +197,47 @@ static int vcn_v4_0_3_hw_init(void *handle)
>   	struct amdgpu_ring *ring;
>   	int i, r, vcn_inst;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		vcn_inst = GET_INST(VCN, i);
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> +	if (amdgpu_sriov_vf(adev)) {
> +		r = vcn_v4_0_3_start_sriov(adev);
> +		if (r)
> +			goto done;
>   
> -		if (ring->use_doorbell) {
> -			adev->nbio.funcs->vcn_doorbell_range(
> -				adev, ring->use_doorbell,
> -				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					9 * vcn_inst,
> -				adev->vcn.inst[i].aid_id);
> -
> -			WREG32_SOC15(
> -				VCN, GET_INST(VCN, ring->me),
> -				regVCN_RB1_DB_CTRL,
> -				ring->doorbell_index
> -						<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -					VCN_RB1_DB_CTRL__EN_MASK);
> -
> -			/* Read DB_CTRL to flush the write DB_CTRL command. */
> -			RREG32_SOC15(
> -				VCN, GET_INST(VCN, ring->me),
> -				regVCN_RB1_DB_CTRL);
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +			ring->wptr = 0;
> +			ring->wptr_old = 0;
> +			vcn_v4_0_3_unified_ring_set_wptr(ring);
> +			ring->sched.ready = true;
>   		}
> +	} else {
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			vcn_inst = GET_INST(VCN, i);
> +			ring = &adev->vcn.inst[i].ring_enc[0];
> +
> +			if (ring->use_doorbell) {
> +				adev->nbio.funcs->vcn_doorbell_range(
> +					adev, ring->use_doorbell,
> +					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +						9 * vcn_inst,
> +					adev->vcn.inst[i].aid_id);
> +
> +				WREG32_SOC15(
> +					VCN, GET_INST(VCN, ring->me),
> +					regVCN_RB1_DB_CTRL,
> +					ring->doorbell_index
> +							<< VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +						VCN_RB1_DB_CTRL__EN_MASK);
> +
> +				/* Read DB_CTRL to flush the write DB_CTRL command. */
> +				RREG32_SOC15(
> +					VCN, GET_INST(VCN, ring->me),
> +					regVCN_RB1_DB_CTRL);
> +			}
>   
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			goto done;
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				goto done;
> +		}
>   	}
>   
>   done:
> @@ -813,6 +835,193 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   	return 0;
>   }
>   
> +static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
> +{
> +	int i, vcn_inst;
> +	struct amdgpu_ring *ring_enc;
> +	uint64_t cache_addr;
> +	uint64_t rb_enc_addr;
> +	uint64_t ctx_addr;
> +	uint32_t param, resp, expected;
> +	uint32_t offset, cache_size;
> +	uint32_t tmp, timeout;
> +
> +	struct amdgpu_mm_table *table = &adev->virt.mm_table;
> +	uint32_t *table_loc;
> +	uint32_t table_size;
> +	uint32_t size, size_dw;
> +	uint32_t init_status;
> +	uint32_t enabled_vcn;
> +
> +	struct mmsch_v4_0_cmd_direct_write
> +		direct_wt = { {0} };
> +	struct mmsch_v4_0_cmd_direct_read_modify_write
> +		direct_rd_mod_wt = { {0} };
> +	struct mmsch_v4_0_cmd_end end = { {0} };
> +	struct mmsch_v4_0_3_init_header header;
> +
> +	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
> +
> +	direct_wt.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_WRITE;
> +	direct_rd_mod_wt.cmd_header.command_type =
> +		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
> +	end.cmd_header.command_type = MMSCH_COMMAND__END;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		vcn_inst = GET_INST(VCN, i);
> +
> +		memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header));
> +		header.version = MMSCH_VERSION;
> +		header.total_size = sizeof(struct mmsch_v4_0_3_init_header) >> 2;
> +
> +		table_loc = (uint32_t *)table->cpu_addr;
> +		table_loc += header.total_size;
> +
> +		table_size = 0;
> +
> +		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
> +			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
> +
> +		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
> +
> +		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
> +
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
> +
> +			offset = 0;
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_VCPU_CACHE_OFFSET0), 0);
> +		} else {
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> +				lower_32_bits(adev->vcn.inst[i].gpu_addr));
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> +				upper_32_bits(adev->vcn.inst[i].gpu_addr));
> +			offset = cache_size;
> +			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +				regUVD_VCPU_CACHE_OFFSET0),
> +				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> +		}
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_SIZE0),
> +			cache_size);
> +
> +		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset;
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_OFFSET1), 0);
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
> +
> +		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset +
> +			AMDGPU_VCN_STACK_SIZE;
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW), lower_32_bits(cache_addr));
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_OFFSET2), 0);
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE);
> +
> +		fw_shared = adev->vcn.inst[vcn_inst].fw_shared.cpu_addr;
> +		rb_setup = &fw_shared->rb_setup;
> +
> +		ring_enc = &adev->vcn.inst[vcn_inst].ring_enc[0];
> +		ring_enc->wptr = 0;
> +		rb_enc_addr = ring_enc->gpu_addr;
> +
> +		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
> +		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
> +		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
> +		rb_setup->rb_size = ring_enc->ring_size / 4;
> +		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> +
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
> +			lower_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
> +			upper_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_NONCACHE_SIZE0),
> +			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
> +		MMSCH_V4_0_INSERT_END();
> +
> +		header.vcn0.init_status = 0;
> +		header.vcn0.table_offset = header.total_size;
> +		header.vcn0.table_size = table_size;
> +		header.total_size += table_size;
> +
> +		/* Send init table to mmsch */
> +		size = sizeof(struct mmsch_v4_0_3_init_header);
> +		table_loc = (uint32_t *)table->cpu_addr;
> +		memcpy((void *)table_loc, &header, size);
> +
> +		ctx_addr = table->gpu_addr;
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
> +
> +		tmp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID);
> +		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID, tmp);
> +
> +		size = header.total_size;
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_SIZE, size);
> +
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP, 0);
> +
> +		param = 0x00000001;
> +		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_HOST, param);
> +		tmp = 0;
> +		timeout = 1000;
> +		resp = 0;
> +		expected = MMSCH_VF_MAILBOX_RESP__OK;
> +		while (resp != expected) {
> +			resp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP);
> +			if (resp != 0)
> +				break;
> +
> +			udelay(10);
> +			tmp = tmp + 10;
> +			if (tmp >= timeout) {
> +				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
> +					" waiting for regMMSCH_VF_MAILBOX_RESP "\
> +					"(expected=0x%08x, readback=0x%08x)\n",
> +					tmp, expected, resp);
> +				return -EBUSY;
> +			}
> +		}
> +
> +		enabled_vcn = amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, 0) ? 1 : 0;
> +		init_status = ((struct mmsch_v4_0_3_init_header *)(table_loc))->vcn0.init_status;
> +		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
> +					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
> +			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
> +				"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * vcn_v4_0_3_start - VCN start
>    *
