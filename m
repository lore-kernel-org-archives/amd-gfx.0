Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACFAEB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 13:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B1710E199;
	Fri, 21 Jul 2023 13:05:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3ADA10E1AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 13:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFE9p1dP+nsAhiJMbDNKCqjqsLLfdOK97XdHtsHtIIvaBvwrVLmYyl/nhhJH8JLBcFcHvaq1ym7bqmVRM3LvTs8virRjGkxD1Yxb96y+5FB3PYGV6vgSU8giDzTIqzoQgirgDOQ3ole0OUW3Spe0OEMVK8vaYXIQDPLJqAE5PtsMBSOOmeFsVtiBJLJO5XmWqPYD0RqKG/QfXEMCwwsTLuB8xkcgPVcCexuYHD9FXbBreyHFluvjBsFEMDdbuMyU2hRiy1y5deuybSIP/McNG1SdBTvVwL9G/k4s1xfHCIp6TalGRNQ11sCyP6UcdrYLjezPTzVnyhA6cvVlA39jvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otxpcT/xZHIgBvOqUq9/UVNEKAOaEKDo3ToW3d/1IRs=;
 b=PGPBh8GQU1CAZeHy9zqIokSobhntRSIM8o0HSMNgIAP18z8wYllun2+0UY77nHy0s6n1UJEvXRmTAEgcHRuYqK/YQLtP7urgwAGT7hCJvmfAZ0c/hcvwLvqG8ijSbHQiL7lc2I/aMYA7popX4e5cLfymNn/jqLhbmGHrn0yfbYGEAMRZaWz6FV/5sovQt1vhGiXaIT7POpUUtjhNUY0PORaVjkccQTh8MS5h2Xqwb7TxcpitQINUwoZ+RwIykpyS3mVZUnY7h/8aiEtmR1qEFQKBG0pCgNyBrjRfRHeHbZAtbUE6a8oNodaeFYYnPrEa+0V5WG7Fn0y0EkMs5UPKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otxpcT/xZHIgBvOqUq9/UVNEKAOaEKDo3ToW3d/1IRs=;
 b=RjF0oxHZvaDwUkh0dtNOtvgfmzkKJr2S+/k9kwc36b2+3R1+Q1soYIzxaYDnl/5Titj8dJq6byAEgYnUEs0qDcvh/vI2DGzvQKsnUp8uQnksWvaWGpX5GAm600lnPKchldIO6IKxCZ8YgoOr8xSer13mdAQHSo+hcDlOQusA7XE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 13:05:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::e30e:689d:405b:b3c2%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:05:41 +0000
Message-ID: <4bf34591-07a0-2cef-2fb3-47f9a31b6aee@amd.com>
Date: Fri, 21 Jul 2023 18:35:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/7] drm/amdgpu/vcn: sriov support for vcn_v4_0_3
Content-Language: en-US
To: Samir Dhume <samir.dhume@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230720191940.780187-1-samir.dhume@amd.com>
 <20230720191940.780187-3-samir.dhume@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230720191940.780187-3-samir.dhume@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: 219147a2-ceff-4c9a-6942-08db89eb2f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiXH+JJXJZBUraj0WLITycFkpcnQOz8MEYueOD6HLvckl7N0NGp99pEY+IAOjxl27MEySy2SjH17k9T/QUj8xpmzlvP/4CtJHn/KpuDfjKQlhmTbslbpcs6GBanOOGLs8cHRy8kY7NgCwpOlXjVmYYZ+4nSqt9qknjeVjzThBK41tzDC6XM76SdQwtJB6YE8d9Ha1U4KHyRvXL+RXeqwRmkrfgAQl9bdCxOLF48KqckXmlsHXxdglNCkqNvgMbU8jAw6rW3IwKiUWaGIY8wlXV6uEOjwFUXvEphM3n+QfrFFsgPuXLhxXl+4B1uu2rmoboVjz5NE28Suq3Iu+7e5tTryWIyave+sqOQs7Ji9BtgwdNc34eDUI5JaTtclxvkMj/7KUeZpdKLcJsx1id1kEtMOABI3hV9DAxJs5i0ZHVKsIrVH0GfUfRn3qIIacpoqb1mV7OgzABNCiDZI+JGDASPPDk5X6jhf5QG9crlY86P9fDxReNLla1BkyIRrc/7ufkCr/6O1iOkxCy0AP/jldnhdnwLR8z1E7Us2QRwQBhg+aSCjIADAKSXB8YYJ6Cv+FdM1s1SU0q4aD6y2vacgzM7ISZC7IEH6mQPW7YoFb1Yc9LjU/crHwZatMS1WvdpgYFd5yMeg5cMu8X2LTvfMFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(30864003)(83380400001)(2906002)(2616005)(31696002)(86362001)(36756003)(38100700002)(4326008)(316002)(66946007)(66556008)(66476007)(41300700001)(53546011)(26005)(186003)(6506007)(478600001)(31686004)(6512007)(6666004)(6486002)(5660300002)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hjM0hSNWlxYTA2Z1VNN0Fpai9BQzdBajQvRU8vTVBtK1JYdmkwTTgzL1Qw?=
 =?utf-8?B?VTNuaWNNSVRKTm1sYjcwRVB1M1RwLytIcUEzdmRFeFhkY2tLYjlla0RCS0lr?=
 =?utf-8?B?TDhObG9YSGVNUm5zbUNweHlCNi94K002WDdlcUZXL2dXUkJWRXNoTElkZldV?=
 =?utf-8?B?VC8rVnBRK0R5M3h1dWhWQmVib1JWREVDWStSa045VDVPenVhaXZ5endwVExQ?=
 =?utf-8?B?Y3B2eVB5eS85WTloQUJJb0pFRVBIS1lXTm14VDhUYjVFSE40alEwQ2hWMnpN?=
 =?utf-8?B?SUxydXV5MFJzVUJjT1c4cU5FelhWUmtVb2VyTjkvNm8wZTA5NXdleTJwR3J2?=
 =?utf-8?B?cUFlakhQVTJrM2REWkJXd0IvU2ViZlBZSk1ZcEZwMDhtVFdLUWx0UFpaOUhJ?=
 =?utf-8?B?ZThya2E2SmhKZVBpMmgvS0luVm9jbHlqQis5dngrd0FmR0ZwMGRuVjBsc3Vj?=
 =?utf-8?B?T3NQd0lWOHhGUE1pVkFFWFF4VUZWL2VUMHIwdXozWjB1NFd3djZQZExJK3hp?=
 =?utf-8?B?YTVkOWg0SnhPaWdXc2RNeVh3YmlyMUwya29wd2lXOUU0MGhxb0QxVGtpMzRJ?=
 =?utf-8?B?eTY1ZkdoR2lUcVROeHNWWW1OL0Z4STBqZDNQK3U1VTJPY1NOUGY2VVF4Vndl?=
 =?utf-8?B?TVRMRW1sMDJtY2J2eEdkMHdFcmI0ZUdraG5NbkdYclUrb1VDT1I2UFBZcXFS?=
 =?utf-8?B?dW5xR2VEK3dGOVNSS1NjdFNrYlgzdmk4WllUY1ViRXlwSDVrVS9YSy9rMnJ1?=
 =?utf-8?B?OERMS2FtM1JqUnVlQy9vRnF3SUJLNnhFWUNXWSt3MUZxSzN1WEM1Q1lXRTZ0?=
 =?utf-8?B?RGJxdGZWaFI5QU9YYmRaeTVXb2JlMnNQd0NGN2RhbThTd0FWVWFlV3R3d1Jq?=
 =?utf-8?B?QmpDdlRYOTJkMXU3WmdBZk1qK0doNS9SQ05KelRkeDI0bG10S2FFTWFpOTg5?=
 =?utf-8?B?MGRxZkVxc3JpRHU0TWc0T01rL2kwQW0rOVNjR3RkeElVaGFQL2RzNHpIYlR6?=
 =?utf-8?B?U0NlcU5ZNW1ldENrMGZqNUZRemdHQlFzWmtwVEp4Tk5JYlhBa05PQXhBVjFT?=
 =?utf-8?B?bVI3T3BUNmQxWVNWS0lxSHM2UHRGWERVa1ZJRDgvS3dvclg1Z3FBM3BheDJo?=
 =?utf-8?B?elNPNU9zd3VybHVmYi8xTFdZS2c1WGZpeTZCS0xNV0lTYmE5dVpxUnFxZFR2?=
 =?utf-8?B?TGxQSFR0YUtrdi9SNTVrV0RlcE9NanRhbGVpL2JLUHpweVFIQnJORVBPUVhZ?=
 =?utf-8?B?VUJzY08vcVRtNDdoK2dNWDhoK3N4SEVycG9PYkxpdjI0S29GL0NabHJsR2Vy?=
 =?utf-8?B?SkV6MmJBZFZLWlhncWZjR3ZCekpHNGpYTGN1R1dBR0IrNlZFQXFZNnVrWHhN?=
 =?utf-8?B?eVVGN25jVzFWd09tWW1seWhJWmdIOUR1UUN1N3ZmMW9qb0ZLR05pZ3JQNmJt?=
 =?utf-8?B?cjgwNVlreDlOOG1vMTdibEF3V1huUHRSeTFJcDg3diszNkF6bUd2T3FPZW1W?=
 =?utf-8?B?ZEdvNDhIeHNOcU8xdk1NZi9tUW5IaW0rRzF2K0E0cEgvb1EycitHODErdDl0?=
 =?utf-8?B?VWMzTG9tekE4dVlpT3hBVTVQY0N0NXB4UzdhdldPU1BkdEFsckVsQXhjWEpF?=
 =?utf-8?B?VVlqV1FTRkhnSEZqNGYxMHFnTE9WY0tSeFl5N2NFV2E0SDhGaEhKSzcvQkpD?=
 =?utf-8?B?RGdyTGNHc1lDQW85WmRaUXN0bkJhdExJTnJLNzFBditzTWF4Nm5pcGhWTUF4?=
 =?utf-8?B?Ynptb3hrNEc1dk0vUzlvUmFZYTZTSkNQWTNBMGd0eFQ3a2hLVFBhUnhOMmx6?=
 =?utf-8?B?TGVoenNSN3lnaWhYNkdNMVF6RE9BWU9LOUJwTUZyZ3FuYWIzMnBiUW9zQUh3?=
 =?utf-8?B?STBQNlNJNWNkZWdBZUg0K2k1cGRhVlFScVBsSzRrbWZFcWp5bGZFMUhUTlRG?=
 =?utf-8?B?VW9MZG9pOU9VeW5hRlJ6TXlrM1JjWGk1ZU94ZzZqNVJlUVdpMlNUdFI2Qjla?=
 =?utf-8?B?REgxOU1HbzVIMHU3Z1c2ejd4TWltNTBQNmJhVnBYNjY3TWhoTHFPYUM3SUo2?=
 =?utf-8?B?cVFGNklSbEl3dG0zUGVqbHAvWHhFVmdiN0ptRDU0dWFGVGtlL3VrL0Roa1Vp?=
 =?utf-8?Q?zrMWYrucEVc28JOXxc5pG+ioa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219147a2-ceff-4c9a-6942-08db89eb2f91
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 13:05:41.5296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CQghEC/SCGS7zVbnsYna0h6t0EL7yYvYxrzAgqPMvlbJpMx83w0fvV4krvBQWPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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
Cc: gavin.wan@amd.com, zhigang.luo@amd.com, guchun.chen@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/21/2023 12:49 AM, Samir Dhume wrote:
> initialization table handshake with mmsch
> 
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 261 +++++++++++++++++++++---
>   1 file changed, 237 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 411c1d802823..8650e3c6288d 100644
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
> +
>   	r = amdgpu_vcn_suspend(adev);
>   	if (r)
>   		return r;
> @@ -189,33 +197,50 @@ static int vcn_v4_0_3_hw_init(void *handle)
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
> +
> +		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;

In vcn v4.0.3 we have adev->vcn.num_vcn_inst as the actual number of vcn 
instances present and not the max possible number. Better to follow the 
same style 'vcn_inst = GET_INST(VCN, i)' for sriov mapping also. Any 
harvest mapping info is expected to be adjusted during initial parsing 
of IP instance discovery table.

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
> @@ -813,6 +838,194 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   	return 0;
>   }
>   
> +static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
> +{
> +	int i;
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
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;

Same comment here.

Thanks,
Lijo

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
> +		cache_addr = adev->vcn.inst[i].gpu_addr + offset;
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_OFFSET1), 0);
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
> +
> +		cache_addr = adev->vcn.inst[i].gpu_addr + offset +
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
> +		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +		rb_setup = &fw_shared->rb_setup;
> +
> +		ring_enc = &adev->vcn.inst[i].ring_enc[0];
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
> +			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> +		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
> +			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
> +			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
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
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
> +
> +		tmp = RREG32_SOC15(VCN, i, regMMSCH_VF_VMID);
> +		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
> +		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_VMID, tmp);
> +
> +		size = header.total_size;
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_CTX_SIZE, size);
> +
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP, 0);
> +
> +		param = 0x00000001;
> +		WREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_HOST, param);
> +		tmp = 0;
> +		timeout = 1000;
> +		resp = 0;
> +		expected = MMSCH_VF_MAILBOX_RESP__OK;
> +		while (resp != expected) {
> +			resp = RREG32_SOC15(VCN, i, regMMSCH_VF_MAILBOX_RESP);
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
