Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B421CD3442
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 16:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60B689861;
	Thu,  7 May 2026 16:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqwbKHvZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2929289861
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 16:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGr7fQfYCvwl2rm/aTUsyNW69DULrMDDpock7zNG5RCN4vml4BQEeci8hO2bnK3k32EWa47ZZ88QQgmMrtjunf/Kgp7VSitIaxDM+7BUCBfLqSQIJJ1JCsDfdCmcNCKm5aGse1lxwEA/Z//ZrOICQTvHlbqbphKYbOnQPhyKwhRib+jjpv4Hfx0EnucljdzeMBL5umeT9oDydhsDVXi1+qnl5Typm585H+q3qBqK+dMcNpf39Hjl+VfkfgSDOYRyHSWSO6B6TVx4XZmI0uys0fZ4eBlhsHJqztv/6L1SJCO1jrglounWyzVA1sINexaLecXw70/tpPpXrjTQDq2kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+O4O0hjCcuRXOC8E5JUxo4dsYkuEJVP7F/ZnFAe8u4=;
 b=t9Qao/EtQ7+I+BPmepbbdRl5iFvZNzUHwNL4IMbpXn8itEHe4n3wWEbj6ECv+nC/8bStTyRXAlnRajj5VzUCW55n1c9CYSyt980Optu4UmxsCx4fREu6Xi10UtbheEohk8XSEYRxOdm6+vqIhWQR6OVFcwWSUdHHh0SMGpv/FN7Q1dqkBx3MyyCnlUw8ZZlcSlHY4erDga2KzS41D1mRVWhUIkB3khY0PVRSyB9iVxMjfCD2Jv6WMlM4wCcsDCo4wlZbP/tFyNcRnG8LyO+ujrfEe7BCwO0ATO/vHpaO1HCrwAmYswrqnIt6V6bxmJXVmJn/txxFNaNp+EIyhNEtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+O4O0hjCcuRXOC8E5JUxo4dsYkuEJVP7F/ZnFAe8u4=;
 b=xqwbKHvZHsx2bQ8l4K0soRUuUM5jvG477oGFxI+gG27XVq04PVpXdbhPOPqFlkOXQKcGEuEHJWLGhfWBgqcMaO0jWL76MFYAkdgsd0hFtenC/69mOazYF4INNox1w1PmDrRVAgkNE6Wjfn0YCxSNZQsanCL2kcaV1iY9b1NhcwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:07:53 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:07:52 +0000
Message-ID: <7f2279c3-b1c9-439f-a929-dcb211307dc7@amd.com>
Date: Thu, 7 May 2026 12:07:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/22] drm/amd/display: add HDMI 2.1 DSC over FRL
 support
To: amd-gfx@lists.freedesktop.org
References: <20260507155147.182540-1-harry.wentland@amd.com>
 <20260507155147.182540-23-harry.wentland@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260507155147.182540-23-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a1f620-bc69-46f9-e76d-08deac52cacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SB/Vn4lpR46L93EJhH7BVHocCZZNaTeniUB+J2DgcWN7gB7s09OoAyCp87g1uqQt5QEeY1LCBg+nqAubnIu4ocbbEJx+HTCt7lBY6qv01/bKu/Vx7+z8oQPP6LzXvuJeeNt2P13rlRozW1wor+Px6wgW6Hs8HQ3iuaGQkxy1cUuhdGyZt+ac+lf/atUNSzErAhQZ6S+jNRqsnDyVHFsCYyql5Ph3AqdMiOAGziieNK7REozZUkEIM7pehRG2q7l+CFxPCdmdt92rkkyra+At7eoDHvCJ89/pgPN5WiwDSFg8HHM5iPw0/3BeiVZ0e82nJ/oFBl4ZQvxTmTmxUDmFEk1qggCHrWWujf5vwbenNhWSdOaNitG/N1H1OtXNelx3UUvm2aRUSMc9H0JVepylmgpS0WYIQSq2k1BbbjMLXLlOQRBoOoUXSPkcJkeN54U+Hx9ezMtWPkcBV1hcRaTlQi+/4H2k1V/54pyYuxFnkjVEjHCww/KjTay8h8u2AevvD7ev6mAIjosYtDmc6aS8Od9PWcNn/Sd9AsaTEYkycZJEuV1ancwN/kgygHWF/qHgzQ7solKiHwKLVy80OjWFlsl0ZT71w+tq/1ojjSY2ovH+bjU5lQTgvuiq0aIEL30J5zETVPR479yxKWGsbRM14f4TEBD8+02WXIwogqiVKPJuYDEsk/+YysgoDK7Iuh8h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhjbVR2TnNzZHdBamhRdnorRitXU1BlSTVjbEZVcGdwalhLRys5LzBUcjJx?=
 =?utf-8?B?S2tJbGxkTzhHSG9LeG9CRm0raGRwM2RKZ1drNlhBWFBCZ3JJcHNnZHh4aUJG?=
 =?utf-8?B?dXM0SGZrcFhmbVo4RitZVUNVZUNETEhGRm5udWQ3SnpmbGVNK1QxZWlORFI5?=
 =?utf-8?B?UmlkQkRieWFNV3hWZ0NjVzdqVzdCdStKaEIvRnoxbHR6MExnTDk5ajc5T0VP?=
 =?utf-8?B?MDFDdkNUa3JMZzhRUVVJeFc3b282QjJXbVBxUzYwWFlTVkZaRXBCR2M5a1Bx?=
 =?utf-8?B?ckF0L0d0TG80djJndWd3eTlUYjlmL0FBeC9VMnk1RFNwSWRub0l3NTNtanlv?=
 =?utf-8?B?bnF2dkVLNHQvOEZ3Q3JMNXdBV2hWbXpRODl5SjBwWmxCcVYzVTJXa2V5YWpx?=
 =?utf-8?B?Sk9RZ0tnQUtSVFl2c1VzR0taYytVa3Npa3pSTEpwWjQ3T3ZLYXVCQUFNYnRR?=
 =?utf-8?B?M3ZvYStjcVJ1cXY1NHFINGZYdTRDVWRycSt1d3M1b2g4dEtPSnhvWXZCMFpu?=
 =?utf-8?B?R1NmTDlUdzlYZXlvUHdNRnZYYStYYTZZOERtdTY3cjRXcy9yNHdKMFBwb3lM?=
 =?utf-8?B?alJNTWZ6dVdvVmpad3NFcUM3R2Y1OEJka0NDWmJqQi9Kc2VJYVc4T0FqUFR1?=
 =?utf-8?B?ampiVTMxWnh3RmVFenBhcWtqZjBKaGZRcnp1Y1l6bHVHT3VPdngwdWplUXRI?=
 =?utf-8?B?SlJqMi9vdmZ6a2t2NDlKUVo1QlpRdDRBdEpoWG1pbCtJRkN1SkhOMGRxZkpp?=
 =?utf-8?B?NDlpR0RpcVlXNXczaG1aT1hyM1NoTDA5Nm1wVUZPVGVoNWk5TTc5V2gwUEZk?=
 =?utf-8?B?Q21nTG1CZUJCRGx5eDNEaHNteVRoRTRETUF6TXJMMWJUVkdQVXRsc1cxMk5T?=
 =?utf-8?B?Z0xvWk45SWFUNEJSQW8yWGpYTURCR20zUkttQUd3SGhMcitxdlk3aWNDSmk5?=
 =?utf-8?B?L0xoRjdOclJFcmNtcjJEcHBQVHpqTGp5c1BXSExQV0ZDZmVRTjA1SjZPUFdt?=
 =?utf-8?B?eFVMMHYycmdhZ08zV2Z6OWV6bEtSNUdDRVRkcGUwYmJMTTJtbFJHLytLNmxU?=
 =?utf-8?B?bFBKeldaSnRLdWd6eThlUnJpTXR2OTNyejZrZGNVbys4WVNRenRKN2tYQVhJ?=
 =?utf-8?B?Yk56NmlmZnE1ZkY2MTQwN0xWK1FLYkt1eVVUUVlUa0gzKzBtU2t6ZTljK05Z?=
 =?utf-8?B?dytVRzFKdlIxUHVzcFEzdzNSRWQwOFVWVmhXQi9EUmo2cE9FN2M0YWl5TS9K?=
 =?utf-8?B?UVpIMmM5aTVpUjUrUEpTcXJRdzdPQ2lSY0VqZDBYcEtGb3l2UXZ5NmtnNjkx?=
 =?utf-8?B?MjJtZUJKd0xEZ0EyY3R2bkErQ3lsVjZxT0ozamhzUlRFdVFQalhYbHRIcUVQ?=
 =?utf-8?B?WnhEdEpZcnpsNXVxVEdYSy9wc1crUjE0ZnNpTzNEUzlyQ21HZTZRaWJtdkxG?=
 =?utf-8?B?OGY5c1U2VVRORnRxVmZISDdidzlPbTR5R2xkS0VFQkF6MU14Y3lqK1F1V3N6?=
 =?utf-8?B?VVd2K0poelpkck9OUDBra2lkL3h6ZzFkOW40SEoxMkJLa3ovMUpkaHVuc3o4?=
 =?utf-8?B?SzJFUFE3NjZIamJHZkdHSi93Q2dZbk1nRmMxckZmNHdOK1FlWXYvd0JYVEVt?=
 =?utf-8?B?SXk2S2xqbWJabTk2NEhXSVNKRjV3NXF3K0FtdUJTaHNmMzBsNDJva21hY21N?=
 =?utf-8?B?OEM1YzE4TVFUaDNVVkl0UzZmaDBGdmxPQnZkaUV3YXY1Z3RuZEdJa1granM1?=
 =?utf-8?B?RzdNSU1qQStLVkNPZk1FZ0hDNEF2TVMxeUlhZXBVNjNZNTByQVZkY0pjQS9V?=
 =?utf-8?B?TkZEUU0xL1JERTB1Y0NUZnZGRnpwQ3RUaiszL0J5RFRVK1JnTmtNb1RvN2Fm?=
 =?utf-8?B?dWdkRGRzZ0Rqb28vRCsxdnk3S2o3MEk4Y0MrY1ZOcURieXc2bGxGSzlaaEhT?=
 =?utf-8?B?WkNWb1ByVWhSZS83TVRPTHF0VHJubndRcEh1ZkZoQ0VWcjlOaXRiTFZQZDB3?=
 =?utf-8?B?TTkvQkRsenRqKzhIbDNZd3Q0V2xOM0NCL1dTNmZadTFNNzlTdXhxay94aWFX?=
 =?utf-8?B?L3dtUjB2ZVU3aSs3WFgwSVlSLzRlL3hnNFVEN0k5QVFIWk01RVcza1ZWWllu?=
 =?utf-8?B?TWhJZTJiVXViZEJOZUNvWEM3c0ZQN3dPMXcxV05Kb3NSVVVrZ0hxQXNNTGg5?=
 =?utf-8?B?alg2cWxiOEVVNkpJMzYwMGViSUhabFlFWVZSTVRDcnRRbjlyQnY5Vk85S25Y?=
 =?utf-8?B?TlJkTUNncldjV1BudVlYNmc2N3dLTjJDa1ZpcnFmT2s4KzU4OUZHbkE4YjVV?=
 =?utf-8?B?RmV3WG1vWHY0VkZjdTZReHJ1SmR4ZWhUVmJQQnNGaHJXN3pzNGxIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a1f620-bc69-46f9-e76d-08deac52cacc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:07:52.6436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB7wIcIJ8rmZzi0Ot9M8U9wUrhh7vER63noDSyx0Zeo8Hu4eOkdAvhYKLA18jqKroQIxdUDEar8RXosv0orpdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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



On 2026-05-07 11:51, Harry Wentland wrote:
> Add all the bits to enable DSC over FRL.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  74 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  91 ++-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  12 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |  13 +
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  54 ++
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
>  drivers/gpu/drm/amd/display/dc/dc.h           |   7 +
>  drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   8 +
>  .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   2 +
>  .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  40 +-
>  .../dc/dml/dcn30/display_mode_vba_30.c        |   3 +
>  .../dc/dml/dcn31/display_mode_vba_31.c        |   3 +
>  .../dc/dml/dcn314/display_mode_vba_314.c      |   3 +
>  .../dc/dml/dcn32/display_mode_vba_util_32.c   |   3 +
>  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c | 197 +++++
>  .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |   9 +
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 704 ++++++++++++++++++
>  .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 105 +++
>  .../dcn401/dcn401_hpo_frl_stream_encoder.c    |   1 +
>  .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |   1 +
>  .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   9 +
>  .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 +
>  .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 +
>  .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
>  .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
>  .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
>  .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
>  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 +
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   1 +
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |   5 +
>  .../amd/display/dc/inc/hw/stream_encoder.h    |   4 +
>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  38 +
>  .../display/dc/link/protocols/link_hdmi_frl.c |  38 +
>  .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  30 +-
>  .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   1 +
>  .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
>  .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
>  .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
>  .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
>  .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
>  .../amd/display/dc/optc/dcn42/dcn42_optc.c    |   1 +
>  42 files changed, 1460 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index be4b66b00be9..007f099ffbb5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7323,12 +7323,30 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
>  
>  	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
>  	    sink->sink_signal == SIGNAL_TYPE_EDP)) {
> -		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE ||
> -			sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER)
> +		if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_NONE)
>  			dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
>  				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
>  				aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
>  				dsc_caps);
> +		else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
> +			if (aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT &&
> +					!aconnector->dsc_settings.dsc_force_disable_passthrough &&
> +					aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps > 0 &&
> +					sink->edid_caps.frl_dsc_support &&
> +					sink->edid_caps.max_frl_rate > 0 &&
> +					sink->edid_caps.frl_dsc_max_frl_rate > 0)
> +				dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps, dsc_caps);
> +			else
> +				dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
> +				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
> +				      aconnector->dc_link->dpcd_caps.dsc_caps.dsc_branch_decoder_caps.raw,
> +				      dsc_caps);
> +		}
> +	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
> +		if (sink->edid_caps.frl_dsc_support &&
> +				sink->edid_caps.max_frl_rate > 0 &&
> +				sink->edid_caps.frl_dsc_max_frl_rate > 0)
> +			dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc, &sink->edid_caps, dsc_caps);
>  	}
>  }
>  
> @@ -7402,6 +7420,10 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  	struct drm_connector *drm_connector = &aconnector->base;
>  	u32 link_bandwidth_kbps;
>  	struct dc *dc = sink->ctx->dc;
> +	const struct dc_hdmi_frl_link_settings *frl_verified_link_cap = NULL;
> +	u32 converter_bw_in_kbps;
> +	u32 sink_bw_in_kbps;
> +	u32 dsc_sink_bw_in_kbps;
>  	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
>  	u32 dsc_max_supported_bw_in_kbps;
>  	u32 max_dsc_target_bpp_limit_override =
> @@ -7440,8 +7462,18 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  		} else if (sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
>  			timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing,
>  					dc_link_get_highest_encoding_format(aconnector->dc_link));
> -			max_supported_bw_in_kbps = link_bandwidth_kbps;
> -			dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
> +			converter_bw_in_kbps = aconnector->dc_link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps;
> +			sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.max_frl_rate);
> +			dsc_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.frl_dsc_max_frl_rate);
> +
> +			if (dsc_caps->is_frl) {
> +				max_supported_bw_in_kbps = min(link_bandwidth_kbps, converter_bw_in_kbps);
> +				max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, sink_bw_in_kbps);
> +				dsc_max_supported_bw_in_kbps = min(max_supported_bw_in_kbps, dsc_sink_bw_in_kbps);
> +			} else {
> +				max_supported_bw_in_kbps = link_bandwidth_kbps;
> +				dsc_max_supported_bw_in_kbps = link_bandwidth_kbps;
> +			}
>  
>  			if (timing_bw_in_kbps > max_supported_bw_in_kbps &&
>  					max_supported_bw_in_kbps > 0 &&
> @@ -7454,11 +7486,41 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  						dc_link_get_highest_encoding_format(aconnector->dc_link),
>  						&stream->timing.dsc_cfg)) {
>  					stream->timing.flags.DSC = 1;
> -					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from DP-HDMI PCON\n",
> -									 __func__, drm_connector->name);
> +					drm_dbg_driver(drm_connector->dev, "%s: SST_DSC [%s] DSC is selected from %s\n",
> +							__func__, drm_connector->name,
> +							(dsc_caps->is_frl == 1) ? "HDMI FRL RX" : "DP-HDMI PCON");
>  				}
>  		}
>  	}
> +	else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_dsc_policy dsc_policy = {0};
> +
> +		frl_verified_link_cap = dc_link_get_frl_link_cap(stream->link);
> +		if (frl_verified_link_cap->frl_link_rate != HDMI_FRL_LINK_RATE_DISABLE &&
> +			aconnector->dc_link->frl_flags.force_frl_dsc) {
> +			dc_dsc_policy_set_enable_dsc_when_not_needed(true);
> +			dc_dsc_get_policy_for_timing(&stream->timing, 0, &dsc_policy, dc_link_get_highest_encoding_format(stream->link));
> +		}
> +
> +		timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing, DC_LINK_ENCODING_HDMI_FRL);
> +		link_bandwidth_kbps = dc_link_frl_bandwidth_kbps(stream->link, frl_verified_link_cap->frl_link_rate);
> +		dsc_sink_bw_in_kbps = dc_link_bw_kbps_from_raw_frl_link_rate_data(dc, sink->edid_caps.frl_dsc_max_frl_rate);
> +
> +		if ((timing_bw_in_kbps > link_bandwidth_kbps && dsc_sink_bw_in_kbps > 0) ||
> +		    (dsc_policy.enable_dsc_when_not_needed || dsc_options.force_dsc_when_not_needed)) {
> +			if (dc_dsc_compute_config(aconnector->dc_link->ctx->dc->res_pool->dscs[0],
> +					dsc_caps,
> +					&dsc_options,
> +					dsc_sink_bw_in_kbps,
> +					&stream->timing,
> +					dc_link_get_highest_encoding_format(aconnector->dc_link),
> +					&stream->timing.dsc_cfg)) {
> +				stream->timing.flags.DSC = 1;
> +				drm_dbg_driver(drm_connector->dev, "%s: HDMI_FRL_DSC [%s] DSC is selected from HDMI FRL RX\n",
> +						__func__, drm_connector->name);
> +			}
> +		}
> +	}
>  
>  	/* Overwrite the stream flag if DSC is enabled through debugfs */
>  	if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 05f9a01f223c..e14980271c96 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -178,8 +178,15 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>  
>  	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
>  
> -	if (edid_caps->edid_hdmi)
> +	if (edid_caps->edid_hdmi) {
>  		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
> +		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
> +		if (edid_caps->frl_dsc_support)
> +			drm_dbg_driver(connector->dev, "%s: HDMI_FRL_DSC [%s] frl_dsc_10bpc %d, frl_dsc_12bpc %d, frl_dsc_all_bpp %d, frl_dsc_native_420 %d, frl_dsc_max_slices %d, frl_dsc_max_frl_rate %d, frl_dsc_total_chunk_kbytes %d\n",
> +					__func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
> +					edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
> +					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
> +	}
>  
>  	apply_edid_quirks(dev, edid_buf, edid_caps);
>  
> @@ -896,8 +903,23 @@ bool dm_helpers_dp_write_dsc_enable(
>  		port = aconnector->mst_output_port;
>  
>  		if (enable) {
> -			if (port->passthrough_aux) {
> -				ret = drm_dp_dpcd_write(port->passthrough_aux,
> +			if (port->passthrough_aux
> +			    || (stream->timing.dsc_cfg.is_frl &&
> +				(!stream->sink->dsc_caps.dsc_dec_caps.is_frl ||
> +				(stream->sink->dsc_caps.dsc_dec_caps.is_frl &&
> +				aconnector->mst_downstream_port_present.fields.PORT_PRESENT &&
> +				aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE ==
> +				DOWN_STREAM_DETAILED_HDMI)))
> +			    ) {
> +				if (!stream->sink->dsc_caps.dsc_dec_caps.is_frl)
> +					/* DSC passthrough to DP receiver */
> +					enable_passthrough = DSC_DECODING;
> +				else if (aconnector->mst_downstream_port_present.fields.PORT_PRESENT &&
> +					 aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE ==
> +					 DOWN_STREAM_DETAILED_HDMI)
> +					/* DSC passthrough to FRL sink */
> +					enable_passthrough = DSC_PASSTHROUGH;
> +				ret = drm_dp_dpcd_write(&aconnector->mst_output_port->aux,
>  							DP_DSC_ENABLE,
>  							&enable_passthrough, 1);
>  				drm_dbg_dp(dev,
> @@ -921,8 +943,13 @@ bool dm_helpers_dp_write_dsc_enable(
>  				   "virtual dpcd",
>  				   ret);
>  
> -			if (port->passthrough_aux) {
> -				ret = drm_dp_dpcd_write(port->passthrough_aux,
> +			if (port->passthrough_aux
> +			    || (stream->timing.dsc_cfg.is_frl &&
> +				(!stream->sink->dsc_caps.dsc_dec_caps.is_frl ||
> +				 (aconnector->mst_downstream_port_present.fields.PORT_PRESENT &&
> +				  aconnector->mst_downstream_port_caps.bytes.byte0.bits.DWN_STRM_PORTX_TYPE ==
> +				  DOWN_STREAM_DETAILED_HDMI)))) {
> +				ret = drm_dp_dpcd_write(&aconnector->mst_output_port->aux,
>  							DP_DSC_ENABLE,
>  							&enable_passthrough, 1);
>  				drm_dbg_dp(dev,
> @@ -939,10 +966,22 @@ bool dm_helpers_dp_write_dsc_enable(
>  				   "SST_DSC Send DSC %s to SST RX\n",
>  				   enable_dsc ? "enable" : "disable");
>  		} else if (stream->sink->link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) {
> +			if (enable) {
> +				if (stream->timing.dsc_cfg.is_frl) {
> +					enable_dsc = DSC_PASSTHROUGH;
> +				} else {
> +					enable_dsc = DSC_DECODING;
> +				}
> +				drm_dbg_dp(dev,
> +					  "SST_DSC Sent DSC decoding enable to %s port, ret = %u\n",
> +					  (port->passthrough_aux) ?
> +					  "remote HDMI FRL RX" :
> +					  "DP-HDMI PCON", ret);
> +			} else {
> +				enable_dsc = DSC_DISABLE;
> +				drm_dbg_dp(dev, "SST_DSC Send DSC disable to DP-HDMI PCON\n");
> +			}
>  			ret = dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
> -			drm_dbg_dp(dev,
> -				   "SST_DSC Send DSC %s to DP-HDMI PCON\n",
> -				   enable_dsc ? "enable" : "disable");
>  		}
>  	}
>  
> @@ -1054,10 +1093,46 @@ static uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
>  	return max_frl_rate;
>  }
>  
> +static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
> +{
> +	uint8_t dsc_max_slices;
> +
> +	if ((max_slices == 1) && (clk_per_slice == 340))
> +		dsc_max_slices = 1;
> +	else if ((max_slices == 2) && (clk_per_slice == 340))
> +		dsc_max_slices = 2;
> +	else if ((max_slices == 4) && (clk_per_slice == 340))
> +		dsc_max_slices = 3;
> +	else if ((max_slices == 8) && (clk_per_slice == 340))
> +		dsc_max_slices = 4;
> +	else if ((max_slices == 8) && (clk_per_slice == 400))
> +		dsc_max_slices = 5;
> +	else if ((max_slices == 12) && (clk_per_slice == 400))
> +		dsc_max_slices = 6;
> +	else if ((max_slices == 16) && (clk_per_slice == 400))
> +		dsc_max_slices = 7;
> +	else
> +		dsc_max_slices = 0;
> +
> +	return dsc_max_slices;
> +}
> +
>  void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
>  {
>  	edid_caps->scdc_present = hdmi->scdc.supported;
>  	edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
> +	edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
> +	if (edid_caps->frl_dsc_support) {
> +		if (hdmi->dsc_cap.bpc_supported == 10)
> +			edid_caps->frl_dsc_10bpc = true;
> +		else if (hdmi->dsc_cap.bpc_supported == 12)
> +			edid_caps->frl_dsc_12bpc = true;
> +		edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
> +		edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
> +		edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
> +		edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
> +		edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
> +	}
>  }
>  
>  enum dc_edid_status dm_helpers_read_local_edid(
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 8e2a8c2c1d84..bc5a9e1663ba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -295,6 +295,17 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
>  	if (!aconnector->dsc_aux)
>  		return false;
>  
> +	if (port->passthrough_aux &&
> +	    aconnector->dc_link->dc->caps.dp_hdmi21_pcon_support &&
> +	    dc_sink->edid_caps.frl_dsc_support &&
> +	    dc_sink->edid_caps.max_frl_rate > 0 &&
> +	    dc_sink->edid_caps.frl_dsc_max_frl_rate > 0) {
> +		dc_dsc_parse_dsc_edid(aconnector->dc_link->ctx->dc,
> +				      &dc_sink->edid_caps, &dc_sink->dsc_caps.dsc_dec_caps);
> +		DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from FRL RX\n", __func__, aconnector->base.name);
> +		return true;
> +	} else {
> +		DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from DP-HDMI PCON\n", __func__, aconnector->base.name);
>  	if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DSC_SUPPORT, dsc_caps, 16) < 0)
>  		return false;
>  
> @@ -307,6 +318,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
>  				  &dc_sink->dsc_caps.dsc_dec_caps))
>  		return false;
>  
> +	}
>  	return true;
>  }
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index b4ad3ec0f029..517844a99451 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -4050,6 +4050,12 @@ static void add_link_update_dsc_config_sequence(
>  					pipe_ctx->stream_res.stream_enc,
>  					true, dsc_packed_pps, false);
>  		}
> +		else if (dc_is_hdmi_frl_signal(stream->signal)) {
> +			hwss_add_hpo_frl_stream_enc_set_dsc_config(seq_state,
> +				pipe_ctx->stream_res.hpo_frl_stream_enc,
> +				&stream->timing,
> +				dsc_packed_pps);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index c0c35d6653a5..ad01ffdc73c3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -1642,6 +1642,9 @@ void hwss_execute_sequence(struct dc *dc,
>  		case STREAM_ENC_DP_SET_DSC_PPS_INFO_PACKET:
>  			hwss_stream_enc_dp_set_dsc_pps_info_packet(params);
>  			break;
> +		case HPO_FRL_STREAM_ENC_SET_DSC_CONFIG:
> +			hwss_hpo_frl_stream_enc_set_dsc_config(params);
> +			break;
>  		case DP_TRACE_SOURCE_SEQUENCE:
>  			hwss_dp_trace_source_sequence(params);
>  			break;
> @@ -3734,6 +3737,16 @@ void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *par
>  			params->stream_enc_dp_set_dsc_pps_info_packet_params.pps_sdp_stream);
>  }
>  
> +void hwss_hpo_frl_stream_enc_set_dsc_config(union block_sequence_params *params)
> +{
> +	if (params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc &&
> +	    params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config)
> +		params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
> +			params->hpo_frl_stream_enc_set_dsc_config_params.hpo_frl_stream_enc,
> +			(struct dc_crtc_timing *)params->hpo_frl_stream_enc_set_dsc_config_params.timing,
> +			params->hpo_frl_stream_enc_set_dsc_config_params.dsc_packed_pps);
> +}
> +
>  void hwss_set_dmdata_attributes(union block_sequence_params *params)
>  {
>  	struct hubp *hubp = params->set_dmdata_attributes_params.hubp;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 2457b563e6c8..0815400468ed 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4592,6 +4592,38 @@ enum dc_status dc_validate_with_context(struct dc *dc,
>  }
>  
>  #if defined(CONFIG_DRM_AMD_DC_FP)
> +/**
> + * dc_update_modified_pix_clock_for_dsc_with_padding() - update pix_clk for dsc with padding
> + *
> + * @dc_stream_state: Pointer to the stream structure.
> + * @dc_crtc_timing: Pointer to the stream dc_crtc_timing structure.
> + * @dsc_padding_params: Pointer to the DSC padding parameters structure.
> + *
> + * This function updated the pix_clk for dsc with padding stored in pipe_ctx
> + * such that the OTG h_active time fits withing the expected compressed active
> + * time calculated according to HDMI spec. H_total is then increased to
> + * maintain the same OTG line time as before the increased pix_clk.
> + */
> +static void dc_update_modified_pix_clock_for_dsc_with_padding(const struct dc_stream_state *stream,
> +		const struct dc_crtc_timing *timing, struct dsc_padding_params *dsc_padding_params)
> +{
> +	DC_FP_START();
> +	frl_modified_pix_clock_for_dsc_padding(stream->link->frl_verified_link_cap.borrow_params.hc_active_target,
> +	stream->link->frl_verified_link_cap.borrow_params.hc_blank_target,
> +	stream->link->frl_verified_link_cap.frl_num_lanes,
> +	timing->pix_clk_100hz,
> +	stream->link->frl_verified_link_cap.frl_link_rate,
> +	timing->h_addressable,
> +	timing->h_border_left,
> +	timing->h_border_right,
> +	timing->h_total,
> +	(timing->h_addressable + dsc_padding_params->dsc_hactive_padding),
> +	&dsc_padding_params->dsc_pix_clk_100hz,
> +	&dsc_padding_params->dsc_htotal_padding);
> +	DC_FP_END();
> +
> +	dsc_padding_params->dsc_htotal_padding = dsc_padding_params->dsc_htotal_padding - timing->h_total;
> +}
>  #endif /* CONFIG_DRM_AMD_DC_FP */
>  
>  /**
> @@ -4618,6 +4650,28 @@ static void calculate_timing_params_for_dsc_with_padding(struct pipe_ctx *pipe_c
>  	if (stream)
>  		pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz = stream->timing.pix_clk_100hz;
>  
> +	uint32_t hactive;
> +	uint32_t ceil_slice_width;
> +	if (stream && stream->timing.flags.DSC) {
> +		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
> +
> +		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
> +		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
> +			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
> +
> +			/* If YCBCR420 slice width must be even */
> +			if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420 && ceil_slice_width % 2 != 0)
> +				ceil_slice_width++;
> +
> +			pipe_ctx->dsc_padding_params.dsc_hactive_padding =
> +				(uint8_t)(ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive);
> +
> +			if (stream->timing.h_total - hactive - pipe_ctx->dsc_padding_params.dsc_hactive_padding < 32)
> +				pipe_ctx->dsc_padding_params.dsc_hactive_padding = 0;
> +
> +			dc_update_modified_pix_clock_for_dsc_with_padding(stream, &stream->timing, &pipe_ctx->dsc_padding_params);
> +		}
> +	}
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index f694c6ad6e98..c1984ebe0ef1 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -99,7 +99,7 @@ void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink)
>  
>  		if (stream->link->frl_flags.force_frl_always ||
>  				stream->link->frl_flags.force_frl_max
> -				)
> +				|| stream->link->frl_flags.force_frl_dsc)
>  			stream->signal = SIGNAL_TYPE_HDMI_FRL;
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 965fa9830355..4c75595a5742 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -121,6 +121,12 @@ struct frl_cap_chk_params_fixed31_32 {
>  
>  	bool     compressed;              /* set to true if DSC is enabled */
>  	bool     bypass_hc_target_calc;   /* debug only */
> +	bool     allow_all_bpp;           /* dsc_all_bpp */
> +
> +	/* DSC parameters */
> +	int      slices;
> +	int      slice_width;
> +	struct fixed31_32   bpp_target;
>  	int      layout;
>  	int      acat;    /* not supported */
>  
> @@ -1151,6 +1157,7 @@ struct dc_debug_options {
>  	int  select_ffe;
>  	int  limit_ffe;
>  	bool force_frl_always;
> +	bool force_frl_dsc;
>  	bool force_frl_max;
>  	bool apply_vsdb_rcc_wa;
>  	bool enable_hdmi_idcc;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> index 101bce6b8de6..c0564167c587 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
> @@ -63,11 +63,19 @@ struct dc_dsc_config_options {
>  	bool force_dsc_when_not_needed;
>  };
>  
> +struct dc_dsc_primary_bpp {
> +	uint32_t vic;
> +	uint32_t target_bpp;
> +};
>  bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
>  		const uint8_t *dpcd_dsc_basic_data,
>  		const uint8_t *dpcd_dsc_ext_data,
>  		struct dsc_dec_dpcd_caps *dsc_sink_caps);
>  
> +bool dc_dsc_parse_dsc_edid(const struct dc *dc,
> +		const struct dc_edid_caps *edid_caps,
> +		struct dsc_dec_dpcd_caps *dsc_sink_caps);
> +
>  bool dc_dsc_compute_bandwidth_range(
>  		const struct display_stream_compressor *dsc,
>  		uint32_t dsc_min_slice_height_override,
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> index afd21eb6bbcd..5923a5f112a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> @@ -138,6 +138,7 @@ union hdmi_scdc_status_flags_data {
>  		uint8_t LANE3_LOCKED:1;
>  		uint8_t RESERVED:1;
>  		uint8_t FLT_READY:1;
> +		uint8_t DSC_DECODEFAIL:1;
>  	} fields;
>  };
>  
> @@ -270,6 +271,7 @@ struct dc_hdmi_frl_flags {
>  	int  select_ffe;
>  	int  limit_ffe;
>  	bool force_frl_always;
> +	bool force_frl_dsc;
>  	bool force_frl_max;
>  	bool apply_vsdb_rcc_wa;
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index 58479bea9976..523d8261be94 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -780,6 +780,38 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_link(struct hpo_frl_stream_encoder *e
>  		break;
>  	}
>  
> +	if (timing->flags.DSC &&
> +			(unsigned int)frl_link_settings->frl_link_rate > dsc_max_rate) {
> +		if (dsc_max_rate < HDMI_FRL_LINK_RATE_6GBPS_4LANE) {
> +			frl_params->lanes = 3;
> +		} else {
> +			frl_params->lanes = 4;
> +		}
> +
> +		switch (dsc_max_rate) {
> +		case HDMI_FRL_LINK_RATE_3GBPS:
> +			frl_params->r_bit_nominal = 3.0e9;
> +			break;
> +		case HDMI_FRL_LINK_RATE_6GBPS:
> +		case HDMI_FRL_LINK_RATE_6GBPS_4LANE:
> +			frl_params->r_bit_nominal = 6.0e9;
> +			break;
> +		case HDMI_FRL_LINK_RATE_8GBPS:
> +			frl_params->r_bit_nominal = 8.0e9;
> +			break;
> +		case HDMI_FRL_LINK_RATE_10GBPS:
> +		default:
> +			frl_params->r_bit_nominal = 10.0e9;
> +			break;
> +		case HDMI_FRL_LINK_RATE_12GBPS:
> +			frl_params->r_bit_nominal = 12.0e9;
> +			break;
> +		}
> +	}
> +
> +	if (timing->flags.DSC && timing->rid > 0)
> +		frl_params->is_ovt = true;
> +
>  	frl_params->f_pixel_clock_nominal = (double)timing->pix_clk_100hz * 100;
>  	frl_params->h_active = timing->h_addressable + timing->h_border_left + timing->h_border_right;
>  	frl_params->h_blank = timing->h_total - frl_params->h_active;
> @@ -795,6 +827,12 @@ void hpo_fpu_enc3_validate_hdmi_frl_output_timing(
>  
>  	if (timing->flags.DSC) {
>  		frl_params->compressed = true;
> +		frl_params->slices = timing->dsc_cfg.num_slices_h;
> +		frl_params->slice_width = (frl_params->h_active + frl_params->slices - 1) / frl_params->slices;
> +		// If YCBCR420 slice width must be even
> +		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && frl_params->slice_width % 2 != 0)
> +			frl_params->slice_width++;
> +		frl_params->bpp_target = timing->dsc_cfg.bits_per_pixel / 16.0;
>  	} else {
>  		frl_params->compressed = false;
>  	}
> @@ -826,5 +864,5 @@ enum frl_cap_chk_result frl_fpu_cap_chk_compressed(struct hpo_frl_stream_encoder
>  						   struct frl_cap_chk_intermediates *inter)
>  {
>  	(void)enc;
> -	return -5;
> +	return dml1_frl_cap_chk_compressed(params, inter);
>  }
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index b54d24cdfbe2..55db25437952 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -3358,6 +3358,9 @@ static double TruncToValidBPP(
>  	hdmifrlparams.h_active = HActive;
>  	hdmifrlparams.h_blank = HTotal - HActive;
>  	hdmifrlparams.compressed = DSCEnable;
> +	hdmifrlparams.slices = DSCSlices;
> +	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
> +	hdmifrlparams.bpp_target = DesiredBPP;
>  
>  	if (Format == dm_420) {
>  		NonDSCBPP0 = 12;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> index 96fdb3f6fa37..3216fd10ad04 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
> @@ -3665,6 +3665,9 @@ static double TruncToValidBPP(
>  	hdmifrlparams.h_active = HActive;
>  	hdmifrlparams.h_blank = HTotal - HActive;
>  	hdmifrlparams.compressed = DSCEnable;
> +	hdmifrlparams.slices = DSCSlices;
> +	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
> +	hdmifrlparams.bpp_target = DesiredBPP;
>  
>  	if (Format == dm_420) {
>  		NonDSCBPP0 = 12;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> index 50c217413abf..2f412cee57c7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> @@ -3771,6 +3771,9 @@ static double TruncToValidBPP(
>  	hdmifrlparams.h_active = HActive;
>  	hdmifrlparams.h_blank = HTotal - HActive;
>  	hdmifrlparams.compressed = DSCEnable;
> +	hdmifrlparams.slices = DSCSlices;
> +	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
> +	hdmifrlparams.bpp_target = DesiredBPP;
>  
>  	if (Format == dm_420) {
>  		NonDSCBPP0 = 12;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 530f6fdc8df3..2ddc30d08b73 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -1702,6 +1702,9 @@ double dml32_TruncToValidBPP(
>  	hdmifrlparams.h_blank = HTotal - HActive;
>  	hdmifrlparams.bpc = (int)(DesiredBPP / 3);
>  	hdmifrlparams.compressed = DSCEnable;
> +	hdmifrlparams.slices = DSCSlices;
> +	hdmifrlparams.slice_width = (int)dml_ceil((double) HActive / DSCSlices, 1.0);
> +	hdmifrlparams.bpp_target = DesiredBPP;
>  
>  	if (Format == dm_420) {
>  		NonDSCBPP0 = 12;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> index 9dde4e56f237..327d89b66613 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
> @@ -430,10 +430,207 @@ enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params
>  	return FRL_CAP_CHK_OK;
>  }
>  
> +enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
> +						    struct frl_cap_chk_intermediates *inter)
> +{
> +	enum frl_cap_chk_result res;
> +	int      c_frl_available;
> +#if defined(DEBUG_FRL_CAP_CHK)
> +	int      c_frl_active_available;
> +	int      c_frl_blank_available;
> +#endif
> +	int      bytes_target = 0;
> +	int      hc_active_target;
> +	int      hc_blank_target_est1;
> +	int      hc_blank_target_est2;
> +	int      hc_blank_target = 0;
> +	int      c_frl_actual_target_payload;
> +	double   utilization_targeted;
> +	double   margin_target;
> +	double   f_tb_average;
> +	double   t_active_ref;
> +	double   t_blank_ref;
> +	double   t_active_target;
> +	double   t_blank_target;
> +	double   tb_borrowed;
> +#ifdef DEBUG_FRL_CAP_CHK
> +	double   tb_delta;
> +	double   tb_delta_limit;
> +	int      tb_worst;
> +#endif
> +	int table_size_444 = ARRAY_SIZE(prim_format_444);
> +	int table_size_422 = ARRAY_SIZE(prim_format_422);
> +	int table_size_420 = ARRAY_SIZE(prim_format_420);
> +	int i;
> +	bool hc_active_blank_predefined = false;
> +
> +	dc_assert_fp_enabled();
> +
> +	res = dml1_frl_cap_chk_common(inter, params);
> +
> +	if (res != FRL_CAP_CHK_OK)
> +		return res;
> +
> +	c_frl_available        = (int)dml_floor((1 - inter->overhead_max) * inter->c_frl_line, 1);
> +#if defined(DEBUG_FRL_CAP_CHK)
> +	c_frl_active_available = dml_floor(c_frl_available * ((double)params->h_active / (params->h_active + params->h_blank)), 1);
> +	c_frl_blank_available  = dml_floor(c_frl_available * ((double)params->h_blank / (params->h_active + params->h_blank)), 1);
> +#endif
> +	bytes_target           = (int)(params->slices * dml_ceil(params->bpp_target * params->slice_width / 8.0, 1));
> +
> +	if (!params->bypass_hc_target_calc)
> +			hc_active_target = (int)dml_ceil(bytes_target / 3.0, 1);
> +	else
> +		hc_active_target = params->borrow_params.hc_active_target;
> +
> +	if (!params->allow_all_bpp && params->vic != 0) {
> +		if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_444) {
> +			for (i = 0; i < table_size_444 ; i++) {
> +				if (prim_format_444[i].vic == params->vic) {
> +					params->borrow_params.hc_active_target = prim_format_444[i].hc_active;
> +					params->borrow_params.hc_blank_target  = prim_format_444[i].hc_blank;
> +					hc_active_blank_predefined = true;
> +					break;
> +				}
> +			}
> +		} else if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_422) {
> +			for (i = 0; i < table_size_422 ; i++) {
> +				if (prim_format_422[i].vic == params->vic) {
> +					params->borrow_params.hc_active_target = prim_format_422[i].hc_active;
> +					params->borrow_params.hc_blank_target  = prim_format_422[i].hc_blank;
> +					hc_active_blank_predefined = true;
> +					break;
> +				}
> +			}
> +		} else if (params->pixel_encoding == HDMI_FRL_PIXEL_ENCODING_420) {
> +			for (i = 0; i < table_size_420 ; i++) {
> +				if (prim_format_420[i].vic == params->vic) {
> +					params->borrow_params.hc_active_target = prim_format_420[i].hc_active;
> +					params->borrow_params.hc_blank_target  = prim_format_420[i].hc_blank;
> +					hc_active_blank_predefined = true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (hc_active_blank_predefined) {
> +			hc_active_target = params->borrow_params.hc_active_target;
> +			hc_blank_target = params->borrow_params.hc_blank_target;
> +		}
> +	}
> +
> +	hc_blank_target_est1 = (int)dml_ceil(hc_active_target * ((double)params->h_blank / params->h_active), 1);
> +	hc_blank_target_est2 = (int)dml_max(hc_blank_target_est1, inter->blank_audio_min);
> +
> +	if (!hc_active_blank_predefined) {
> +		if (!params->bypass_hc_target_calc) {
> +			hc_blank_target = (int)(4 * dml_floor(dml_min(hc_blank_target_est2, c_frl_available - 3.0 / 2.0 * hc_active_target) / 4.0, 1));
> +
> +			params->borrow_params.hc_active_target = hc_active_target;
> +			params->borrow_params.hc_blank_target  = hc_blank_target;
> +		} else {
> +			hc_blank_target  = params->borrow_params.hc_blank_target;
> +		}
> +	}
> +
> +#ifdef DEBUG_FRL_CAP_CHK
> +	{
> +		frl_dump_var("%i", c_frl_available);
> +		frl_dump_var("%i", c_frl_active_available);
> +		frl_dump_var("%i", c_frl_blank_available);
> +		frl_dump_var("%i", bytes_target);
> +		frl_dump_var("%i", hc_active_target);
> +		frl_dump_var("%i", hc_blank_target_est1);
> +		frl_dump_var("%i", hc_blank_target_est2);
> +		frl_dump_var("%i", hc_blank_target);
> +	}
> +#endif
> +
> +	if (!(inter->blank_audio_min <= hc_blank_target)) {
> +		frl_dump_var("%i", inter->blank_audio_min);
> +		frl_dump_var("%i", hc_blank_target);
> +		return FRL_CAP_CHK_ERROR_AUDIO_BW;
> +	}
> +
> +	f_tb_average    = inter->f_pixel_clock_max / (params->h_active + params->h_blank) * (hc_active_target + hc_blank_target);
> +	t_active_ref    = inter->t_line * ((double)params->h_active / (params->h_active + params->h_blank));
> +	t_blank_ref     = inter->t_line - t_active_ref; // * ((double) params->h_blank / (params->h_active + params->h_blank));
> +	t_active_target = dml_max((hc_active_target / f_tb_average),
> +				  (3.0 / 2.0 * hc_active_target) /
> +				  (params->lanes * inter->r_frl_char_min * (1.0 - inter->overhead_max)));
> +	t_blank_target  = inter->t_line - t_active_target;
> +
> +	tb_borrowed     = t_active_target * f_tb_average - hc_active_target;
> +#ifdef DEBUG_FRL_CAP_CHK
> +	tb_delta        = dcn_bw_fabs(t_active_target - t_active_ref) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
> +
> +	{
> +		frl_dump_var("%le", f_tb_average);
> +		frl_dump_var("%le", t_active_ref);
> +		frl_dump_var("%le", t_blank_ref);
> +		frl_dump_var("%le", t_active_target);
> +		frl_dump_var("%le", t_blank_target);
> +		frl_dump_var("%le", tb_delta);
> +	}
> +#endif
> +
> +	if (t_blank_target - t_blank_ref > DBL_EPSILON) {
> +#ifdef DEBUG_FRL_CAP_CHK
> +		tb_delta_limit = (t_active_ref - hc_active_target / f_tb_average) * (hc_active_target + hc_blank_target_est1) / inter->t_line;
> +#endif
> +		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_ACTIVE;
> +	} else if (t_active_target - t_active_ref > DBL_EPSILON) {
> +#ifdef DEBUG_FRL_CAP_CHK
> +		tb_delta_limit = tb_delta;
> +#endif
> +		params->borrow_params.borrow_mode = FRL_BORROW_MODE_FROM_BLANK;
> +	} else {
> +#ifdef DEBUG_FRL_CAP_CHK
> +		tb_delta_limit = 0;
> +#endif
> +		params->borrow_params.borrow_mode = FRL_BORROW_MODE_NONE;
> +	}
> +
> +#ifdef DEBUG_FRL_CAP_CHK
> +	tb_worst = dml_ceil(dml_max(tb_borrowed, tb_delta_limit), 1);
> +
> +	{
> +		frl_dump_var("%le", tb_delta_limit);
> +		frl_dump_var("%le", tb_borrowed);
> +		frl_dump_var("%i", params->borrow_params.borrow_mode);
> +		frl_dump_var("%i", tb_worst);
> +	}
> +#endif
> +
> +	if (!(tb_borrowed <= TB_BORROWED_MAX))
> +		return FRL_CAP_CHK_ERROR_MAX_BORROW;
> +
> +	c_frl_actual_target_payload = (int)(dml_ceil(3.0 / 2.0 * hc_active_target, 1) + hc_blank_target);
> +	utilization_targeted        = c_frl_actual_target_payload / inter->c_frl_line;
> +	margin_target               = 1.0 - (utilization_targeted + inter->overhead_max);
> +
> +#ifdef DEBUG_FRL_CAP_CHK
> +	{
> +		frl_dump_var("%i",  c_frl_actual_target_payload);
> +		frl_dump_var("%le", utilization_targeted);
> +		frl_dump_var("%le", margin_target);
> +	}
> +#endif
> +
> +	// oversubscribed bandwidth relative to margin
> +	if (margin_target < 0 && dcn_bw_fabs(margin_target) > EPSILON)
> +		return FRL_CAP_CHK_ERROR_MARGIN;
> +
> +	return FRL_CAP_CHK_OK;
> +}
> +
>  enum frl_cap_chk_result dml1_frl_cap_chk(struct frl_cap_chk_params *params)
>  {
>  	struct frl_cap_chk_intermediates inter;
>  
> +	if (params->compressed)
> +		return dml1_frl_cap_chk_compressed(params, &inter);
> +
>  	return dml1_frl_cap_chk_inter(params, &inter);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
> index 545f498ea396..debe4c1dc0f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
> @@ -119,6 +119,13 @@ struct frl_cap_chk_params {
>  
>  	bool     compressed;              /* set to true if DSC is enabled */
>  	bool     bypass_hc_target_calc;   /* debug only */
> +	bool     allow_all_bpp;           /* dsc_all_bpp */
> +
> +	/* DSC parameters */
> +	int      slices;
> +	int      slice_width;
> +	double   bpp_target;
> +	bool     is_ovt;
>  	int      layout;
>  	int      acat;    /* not supported */
>  
> @@ -138,6 +145,8 @@ enum frl_cap_chk_result dml1_frl_cap_chk_common(struct frl_cap_chk_intermediates
>  enum frl_cap_chk_result dml1_frl_cap_chk_uncompressed(struct frl_cap_chk_params *params,
>  						      struct frl_cap_chk_intermediates *inter);
>  
> +enum frl_cap_chk_result dml1_frl_cap_chk_compressed(struct frl_cap_chk_params *params,
> +						    struct frl_cap_chk_intermediates *inter);
>  #endif
>  
>  void frl_modified_pix_clock_for_dsc_padding(const int hc_active_target,
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> index 8dfb6dd14eb2..c0f489ccf5e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -151,6 +151,166 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
>  	return kbps;
>  }
>  
> +const struct dc_dsc_primary_bpp prim_bpp_444[] = {
> +	/* VIC/BPP */
> +	{64,  192}, /* 1920x1080 @ 100 */
> +	{77,  192}, /* 1920x1080 @ 100 */
> +	{63,  192}, /* 1920x1080 @ 120 */
> +	{78,  192}, /* 1920x1080 @ 120 */
> +	{93,  192}, /* 3840x2160 @ 24 */
> +	{103, 192}, /* 3840x2160 @ 24 */
> +	{94,  192}, /* 3840x2160 @ 25 */
> +	{104, 192}, /* 3840x2160 @ 25 */
> +	{95,  192}, /* 3840x2160 @ 30 */
> +	{105, 192}, /* 3840x2160 @ 30 */
> +	{114, 192}, /* 3840x2160 @ 48 */
> +	{116, 192}, /* 3840x2160 @ 48 */
> +	{96,  192}, /* 3840x2160 @ 50 */
> +	{106, 192}, /* 3840x2160 @ 50 */
> +	{97,  192}, /* 3840x2160 @ 60 */
> +	{107, 192}, /* 3840x2160 @ 60 */
> +	{117, 192}, /* 3840x2160 @ 100 */
> +	{119, 192}, /* 3840x2160 @ 100 */
> +	{118, 192}, /* 3840x2160 @ 120 */
> +	{120, 192}, /* 3840x2160 @ 120 */
> +	{98,  192}, /* 4096x2160 @ 24 */
> +	{99,  192}, /* 4096x2160 @ 25 */
> +	{100, 192}, /* 4096x2160 @ 30 */
> +	{115, 192}, /* 4096x2160 @ 48 */
> +	{101, 192}, /* 4096x2160 @ 50 */
> +	{102, 192}, /* 4096x2160 @ 60 */
> +	{218, 192}, /* 4096x2160 @ 100 */
> +	{219, 192}, /* 4096x2160 @ 120 */
> +	{121, 192}, /* 5120x2160 @ 24 */
> +	{122, 192}, /* 5120x2160 @ 25 */
> +	{123, 192}, /* 5120x2160 @ 30 */
> +	{124, 192}, /* 5120x2160 @ 48 */
> +	{125, 192}, /* 5120x2160 @ 50 */
> +	{126, 173}, /* 5120x2160 @ 60 */
> +	{127, 192}, /* 5120x2160 @ 100 */
> +	{193, 175}, /* 5120x2160 @ 120 */
> +	{194, 192}, /* 7680x2160 @ 24 */
> +	{202, 192}, /* 7680x2160 @ 24 */
> +	{195, 192}, /* 7680x2160 @ 25 */
> +	{203, 192}, /* 7680x2160 @ 25 */
> +	{196, 192}, /* 7680x2160 @ 30 */
> +	{204, 192}, /* 7680x2160 @ 30 */
> +	{197, 157}, /* 7680x2160 @ 48 */
> +	{205, 157}, /* 7680x2160 @ 48 */
> +	{198, 157}, /* 7680x2160 @ 50 */
> +	{206, 157}, /* 7680x2160 @ 50 */
> +	{199, 159}, /* 7680x2160 @ 60 */
> +	{207, 159}, /* 7680x2160 @ 60 */
> +	{200, 134}, /* 7680x2160 @ 100 */
> +	{208, 134}, /* 7680x2160 @ 100 */
> +	{201, 130}, /* 7680x2160 @ 120 */
> +	{209, 130}, /* 7680x2160 @ 120 */
> +	{210, 182}, /* 10240x4320 @ 24 */
> +	{211, 181}, /* 10240x4320 @ 25 */
> +	{212, 177}, /* 10240x4320 @ 30 */
> +	{213, 163}, /* 10240x4320 @ 48 */
> +	{214, 162}, /* 10240x4320 @ 50 */
> +	{215, 157}, /* 10240x4320 @ 60 */
> +};
> +const struct dc_dsc_primary_bpp prim_bpp_422[] = {
> +	/* VIC/BPP */
> +	{114, 192}, /* 3840x2160 @ 48 */
> +	{116, 192}, /* 3840x2160 @ 48 */
> +	{96,  192}, /* 3840x2160 @ 50 */
> +	{106, 192}, /* 3840x2160 @ 50 */
> +	{97,  192}, /* 3840x2160 @ 60 */
> +	{107, 192}, /* 3840x2160 @ 60 */
> +	{117, 137}, /* 3840x2160 @ 100 */
> +	{119, 137}, /* 3840x2160 @ 100 */
> +	{118, 113}, /* 3840x2160 @ 120 */
> +	{120, 113}, /* 3840x2160 @ 120 */
> +	{115, 192}, /* 4096x2160 @ 48 */
> +	{101, 192}, /* 4096x2160 @ 50 */
> +	{102, 192}, /* 4096x2160 @ 60 */
> +	{218, 192}, /* 4096x2160 @ 100 */
> +	{219, 192}, /* 4096x2160 @ 120 */
> +	{121, 192}, /* 5120x2160 @ 24 */
> +	{122, 192}, /* 5120x2160 @ 25 */
> +	{123, 192}, /* 5120x2160 @ 30 */
> +	{124, 192}, /* 5120x2160 @ 48 */
> +	{125, 192}, /* 5120x2160 @ 50 */
> +	{126, 173}, /* 5120x2160 @ 60 */
> +	{127, 192}, /* 5120x2160 @ 100 */
> +	{193, 175}, /* 5120x2160 @ 120 */
> +	{194, 123}, /* 7680x2160 @ 24 */
> +	{202, 123}, /* 7680x2160 @ 24 */
> +	{195, 123}, /* 7680x2160 @ 25 */
> +	{203, 123}, /* 7680x2160 @ 25 */
> +	{196, 118}, /* 7680x2160 @ 30 */
> +	{204, 118}, /* 7680x2160 @ 30 */
> +	{197, 123}, /* 7680x2160 @ 48 */
> +	{205, 123}, /* 7680x2160 @ 48 */
> +	{198, 123}, /* 7680x2160 @ 50 */
> +	{206, 123}, /* 7680x2160 @ 50 */
> +	{199, 119}, /* 7680x2160 @ 60 */
> +	{207, 119}, /* 7680x2160 @ 60 */
> +	{200, 134}, /* 7680x2160 @ 100 */
> +	{208, 134}, /* 7680x2160 @ 100 */
> +	{201, 130}, /* 7680x2160 @ 120 */
> +	{209, 130}, /* 7680x2160 @ 120 */
> +	{210, 182}, /* 10240x4320 @ 24 */
> +	{211, 181}, /* 10240x4320 @ 25 */
> +	{212, 177}, /* 10240x4320 @ 30 */
> +	{213, 126}, /* 10240x4320 @ 48 */
> +	{214, 125}, /* 10240x4320 @ 50 */
> +	{215, 117}, /* 10240x4320 @ 60 */
> +	{216, 125}, /* 10240x4320 @ 100 */
> +	{217, 117}, /* 10240x4320 @ 120 */
> +};
> +
> +const struct dc_dsc_primary_bpp prim_bpp_420[] = {
> +	/* VIC/BPP */
> +	{114, 192}, /* 3840x2160 @ 48 */
> +	{116, 192}, /* 3840x2160 @ 48 */
> +	{96,  192}, /* 3840x2160 @ 50 */
> +	{106, 192}, /* 3840x2160 @ 50 */
> +	{97,  192}, /* 3840x2160 @ 60 */
> +	{107, 192}, /* 3840x2160 @ 60 */
> +	{117, 137}, /* 3840x2160 @ 100 */
> +	{119, 137}, /* 3840x2160 @ 100 */
> +	{118, 113}, /* 3840x2160 @ 120 */
> +	{120, 113}, /* 3840x2160 @ 120 */
> +	{115, 192}, /* 4096x2160 @ 48 */
> +	{101, 192}, /* 4096x2160 @ 50 */
> +	{102, 192}, /* 4096x2160 @ 60 */
> +	{218, 129}, /* 4096x2160 @ 100 */
> +	{219, 106}, /* 4096x2160 @ 120 */
> +	{124, 192}, /* 5120x2160 @ 48 */
> +	{125, 192}, /* 5120x2160 @ 50 */
> +	{126, 173}, /* 5120x2160 @ 60 */
> +	{127, 192}, /* 5120x2160 @ 100 */
> +	{193, 175}, /* 5120x2160 @ 120 */
> +	{194, 123}, /* 7680x4320 @ 24 */
> +	{202, 123}, /* 7680x4320 @ 24 */
> +	{195, 123}, /* 7680x4320 @ 25 */
> +	{203, 123}, /* 7680x4320 @ 25 */
> +	{196, 118}, /* 7680x4320 @ 30 */
> +	{204, 118}, /* 7680x4320 @ 30 */
> +	{197, 123}, /* 7680x4320 @ 48 */
> +	{205, 123}, /* 7680x4320 @ 48 */
> +	{198, 123}, /* 7680x4320 @ 50 */
> +	{206, 123}, /* 7680x4320 @ 50 */
> +	{199, 119}, /* 7680x4320 @ 60 */
> +	{207, 119}, /* 7680x4320 @ 60 */
> +	{200, 112}, /* 7680x4320 @ 100 */
> +	{208, 112}, /* 7680x4320 @ 100 */
> +	{201, 103}, /* 7680x4320 @ 120 */
> +	{209, 103}, /* 7680x4320 @ 120 */
> +	{210,  98}, /* 10240x4320 @ 24 */
> +	{211,  98}, /* 10240x4320 @ 25 */
> +	{212, 177}, /* 10240x4320 @ 30 */
> +	{213,  98}, /* 10240x4320 @ 48 */
> +	{214, 125}, /* 10240x4320 @ 50 */
> +	{215, 117}, /* 10240x4320 @ 60 */
> +	{216, 107}, /* 10240x4320 @ 100 */
> +	{217,  97}, /* 10240x4320 @ 120 */
> +};
> +
>  /* Forward Declerations */
>  static unsigned int get_min_dsc_slice_count_for_odm(
>  		const struct display_stream_compressor *dsc,
> @@ -194,6 +354,15 @@ static bool setup_dsc_config(
>  		int min_slice_count,
>  		struct dc_dsc_config *dsc_cfg);
>  
> +static bool convert_bandwidth_to_frl_params(
> +	int bandwidth_kbps,
> +	int *num_lanes,
> +	int *frl_rate);
> +
> +static uint32_t compute_bpp_x16_from_frl_params(
> +		const struct dc_crtc_timing *timing,
> +		const uint32_t num_slices_h,
> +		const struct dsc_enc_caps *dsc_caps);
>  static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_block_size)
>  {
>  
> @@ -328,6 +497,207 @@ static bool dsc_bpp_increment_div_from_dpcd(uint8_t bpp_increment_dpcd, uint32_t
>  
>  
>  
> +static bool get_vic_preset_bpp(
> +		const struct dc_crtc_timing *timing,
> +		int *preset_bpp)
> +{
> +	bool preset_found = false;
> +	uint32_t table_size_444 = ARRAY_SIZE(prim_bpp_444);
> +	uint32_t table_size_422 = ARRAY_SIZE(prim_bpp_422);
> +	uint32_t table_size_420 = ARRAY_SIZE(prim_bpp_420);
> +	uint32_t i;
> +	uint32_t vid_id;
> +
> +	if (timing->vic == 0 && timing->hdmi_vic == 0)
> +		return false;
> +
> +	vid_id = timing->vic;
> +	switch (timing->hdmi_vic) {
> +	case 1:
> +		vid_id = 95;
> +		break;
> +	case 2:
> +		vid_id = 94;
> +		break;
> +	case 3:
> +		vid_id = 93;
> +		break;
> +	case 4:
> +		vid_id = 98;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
> +			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
> +		for (i = 0; i < table_size_444 ; i++) {
> +			if (prim_bpp_444[i].vic == vid_id) {
> +				preset_found = true;
> +				*preset_bpp = prim_bpp_444[i].target_bpp;
> +				break;
> +			}
> +		}
> +	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
> +		for (i = 0; i < table_size_422 ; i++) {
> +			if (prim_bpp_422[i].vic == vid_id) {
> +				preset_found = true;
> +				*preset_bpp = prim_bpp_422[i].target_bpp;
> +				break;
> +			}
> +		}
> +	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
> +		for (i = 0; i < table_size_420 ; i++) {
> +			if (prim_bpp_420[i].vic == vid_id) {
> +				preset_found = true;
> +				*preset_bpp = prim_bpp_420[i].target_bpp;
> +				break;
> +			}
> +		}
> +	} else {
> +		return false;
> +	}
> +
> +	return preset_found;
> +}
> +
> +static int hdmi_dsc_get_num_slices(const struct dc_crtc_timing *timing)
> +{
> +	int k_slice_adjust = 1;
> +	int adj_pix_clk_mhz;
> +	int min_slices;
> +	int slice_target;
> +	int slice_width = timing->h_addressable;
> +	int h_ratio_adj_pix_clk_mhz;
> +
> +	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
> +			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444)
> +		k_slice_adjust = 2;
> +
> +	adj_pix_clk_mhz = k_slice_adjust * timing->pix_clk_100hz / 10000 / 2;
> +	h_ratio_adj_pix_clk_mhz = adj_pix_clk_mhz * timing->h_addressable / timing->h_total;
> +	if (adj_pix_clk_mhz <= 2720) {
> +		min_slices = adj_pix_clk_mhz / 340;
> +		if (adj_pix_clk_mhz % 340 != 0)
> +			min_slices++;
> +	} else if (adj_pix_clk_mhz <= 4800) {
> +		min_slices = adj_pix_clk_mhz / 400;
> +		if (adj_pix_clk_mhz % 400 != 0)
> +			min_slices++;
> +	} else if (h_ratio_adj_pix_clk_mhz <= 4800) {
> +		min_slices = h_ratio_adj_pix_clk_mhz / 600;
> +		if (h_ratio_adj_pix_clk_mhz % 600 != 0)
> +			min_slices++;
> +	} else {
> +		min_slices = h_ratio_adj_pix_clk_mhz / 900;
> +		if (h_ratio_adj_pix_clk_mhz % 900 != 0)
> +			min_slices++;
> +	}
> +
> +	do {
> +		if (min_slices <= 1)
> +			slice_target = 1;
> +		else if (min_slices <= 2)
> +			slice_target = 2;
> +		else if (min_slices <= 4)
> +			slice_target = 4;
> +		else if (min_slices <= 8)
> +			slice_target = 8;
> +		else if (min_slices <= 12)
> +			slice_target = 12;
> +		else if (min_slices <= 16)
> +			slice_target = 16;
> +		else
> +			return 0;
> +
> +		slice_width = timing->h_addressable / slice_target;
> +		min_slices++;
> +	} while (slice_width > 2720);
> +
> +	return slice_target;
> +}
> +
> +static int hdmi_dsc_get_bpp(const struct dc_crtc_timing *timing,
> +		const struct dsc_enc_caps *dsc_common_caps)
> +{
> +	int max_dsc_bpp, min_dsc_bpp;
> +	int target_bytes;
> +	bool bpp_found = false;
> +	int bpp_decrement_x16;
> +	int src_fractional_bpp = dsc_common_caps->bpp_increment_div;
> +	int bpp_target;
> +	int bpp_target_x16;
> +	int bpc_factor = 8;
> +	int slice_width;
> +	int num_slices;
> +	bool hdmi_all_bpp = dsc_common_caps->is_vic_all_bpp;
> +	int hdmi_max_chunk_bytes = dsc_common_caps->total_chunk_kbytes;
> +
> +	int preset_bpp;
> +	bool preset_found = false;
> +
> +	if (timing->display_color_depth == COLOR_DEPTH_101010)
> +		bpc_factor = 10;
> +	if (timing->display_color_depth == COLOR_DEPTH_121212)
> +		bpc_factor = 12;
> +
> +	/* Assuming: bpc as 8*/
> +	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
> +			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
> +		min_dsc_bpp = 8;
> +		max_dsc_bpp = 3 * bpc_factor;
> +	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
> +		min_dsc_bpp = 7;
> +		max_dsc_bpp = 2 * bpc_factor;
> +	} else {
> +		min_dsc_bpp = 6;
> +		max_dsc_bpp = 3 * bpc_factor / 2;
> +	}
> +
> +	if (!hdmi_all_bpp)
> +		max_dsc_bpp = min(max_dsc_bpp, 12);
> +
> +
> +	num_slices = hdmi_dsc_get_num_slices(timing);
> +	if (num_slices == 0)
> +		return 0;
> +
> +	slice_width = timing->h_addressable / num_slices;
> +
> +	bpp_target = max_dsc_bpp;
> +	bpp_decrement_x16 = 16 / src_fractional_bpp;
> +	bpp_target_x16 = (bpp_target * 16) - bpp_decrement_x16;
> +	if (!hdmi_all_bpp)
> +			bpp_target_x16 = (bpp_target * 16);
> +
> +	/* check if byte target is below allowed Kbytes */
> +	while (bpp_target_x16 > (min_dsc_bpp * 16)) {
> +		target_bytes = num_slices * slice_width * bpp_target_x16 / 16 / 8;
> +		if (target_bytes <= hdmi_max_chunk_bytes) {
> +			bpp_found = true;
> +			break;
> +		}
> +		bpp_target_x16 -= bpp_decrement_x16;
> +	}
> +
> +	if (bpp_found) {
> +		if (!hdmi_all_bpp) {
> +			/* Get preset bpp for CTA modes */
> +			preset_found = get_vic_preset_bpp(timing, &preset_bpp);
> +			if (preset_found) {
> +				bpp_target_x16 = preset_bpp;
> +				target_bytes =
> +						num_slices * slice_width * bpp_target_x16 / 16 / 8;
> +				if (target_bytes > hdmi_max_chunk_bytes)
> +					return 0;
> +			}
> +		}
> +		return bpp_target_x16;
> +	}
> +
> +	return 0;
> +}
> +
>  bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
>  		const uint8_t *dpcd_dsc_basic_data,
>  		const uint8_t *dpcd_dsc_branch_decoder_caps,
> @@ -450,6 +820,104 @@ bool dc_dsc_parse_dsc_dpcd(const struct dc *dc,
>  	dsc_sink_caps->is_dp = true;
>  	return true;
>  }
> +bool dc_dsc_parse_dsc_edid(const struct dc *dc, const struct dc_edid_caps *edid_caps,
> +		struct dsc_dec_dpcd_caps *dsc_sink_caps)
> +{
> +	(void)dc;
> +	dsc_sink_caps->is_dsc_supported = edid_caps->frl_dsc_support;
> +	if (!edid_caps->frl_dsc_support)
> +		return false;
> +
> +	dsc_sink_caps->dsc_version = 0x21;
> +	dsc_sink_caps->is_frl = true;
> +	dsc_sink_caps->is_dp = false;
> +
> +	switch (edid_caps->frl_dsc_max_slices) {
> +	case 0:
> +		break;
> +	case 1:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 340;
> +		dsc_sink_caps->throughput_mode_1_mps = 680;
> +		break;
> +	case 2:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 340;
> +		dsc_sink_caps->throughput_mode_1_mps = 680;
> +		break;
> +	case 3:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 340;
> +		dsc_sink_caps->throughput_mode_1_mps = 680;
> +		break;
> +	case 4:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 340;
> +		dsc_sink_caps->throughput_mode_1_mps = 680;
> +		break;
> +	case 5:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 400;
> +		dsc_sink_caps->throughput_mode_1_mps = 800;
> +		break;
> +	case 6:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 400;
> +		dsc_sink_caps->throughput_mode_1_mps = 800;
> +		break;
> +	case 7:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 600;
> +		dsc_sink_caps->throughput_mode_1_mps = 1200;
> +		break;
> +	case 8:
> +	default:
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_1 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_2 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_4 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_8 = 1;
> +		dsc_sink_caps->slice_caps1.bits.NUM_SLICES_12 = 1;
> +		dsc_sink_caps->throughput_mode_0_mps = 900;
> +		dsc_sink_caps->throughput_mode_1_mps = 1800;
> +		break;
> +	}
> +	dsc_sink_caps->lb_bit_depth = 13; //Table 7-25
> +	dsc_sink_caps->is_block_pred_supported = true; //Table 7-25
> +	dsc_sink_caps->color_formats.bits.RGB = 1;
> +	dsc_sink_caps->color_formats.bits.YCBCR_444 = 1;
> +	dsc_sink_caps->color_formats.bits.YCBCR_NATIVE_422 = 1;
> +	dsc_sink_caps->color_formats.bits.YCBCR_NATIVE_420 =
> +			(edid_caps->frl_dsc_native_420 == true) ? 1 : 0;
> +	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_8_BPC = 1;
> +	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_10_BPC =
> +			(edid_caps->frl_dsc_10bpc == true) ? 1 : 0;
> +	dsc_sink_caps->color_depth.bits.COLOR_DEPTH_12_BPC =
> +			(edid_caps->frl_dsc_12bpc == true) ? 1 : 0;
> +	dsc_sink_caps->max_slice_width = 2560;
> +	dsc_sink_caps->bpp_increment_div = 16; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
> +	dsc_sink_caps->is_vic_all_bpp = edid_caps->frl_dsc_all_bpp;
> +	dsc_sink_caps->total_chunk_kbytes =
> +			1024 * (1 + edid_caps->frl_dsc_total_chunk_kbytes);
> +
> +	return true;
> +}
>  
>  /* If DSC is possbile, get DSC bandwidth range based on [min_bpp, max_bpp] target bitrate range and
>   * timing's pixel clock and uncompressed bandwidth.
> @@ -757,6 +1225,9 @@ static bool intersect_dsc_caps(
>  	if (pixel_encoding == PIXEL_ENCODING_YCBCR422 || pixel_encoding == PIXEL_ENCODING_YCBCR420)
>  		dsc_common_caps->bpp_increment_div = min(dsc_common_caps->bpp_increment_div, (uint32_t)8);
>  
> +	dsc_common_caps->is_frl = dsc_sink_caps->is_frl;
> +	dsc_common_caps->is_vic_all_bpp = dsc_sink_caps->is_vic_all_bpp;
> +	dsc_common_caps->total_chunk_kbytes = dsc_sink_caps->total_chunk_kbytes;
>  	dsc_common_caps->edp_sink_max_bits_per_pixel = dsc_sink_caps->edp_max_bits_per_pixel;
>  	dsc_common_caps->is_dp = dsc_sink_caps->is_dp;
>  	return true;
> @@ -786,6 +1257,191 @@ static uint32_t compute_bpp_x16_from_target_bandwidth(
>  	return dc_fixpt_floor(bpp_x16);
>  }
>  
> +static bool convert_bandwidth_to_frl_params(
> +	int bandwidth_kbps,
> +	int *num_lanes,
> +	int *frl_rate)
> +{
> +	if (bandwidth_kbps == 0)
> +		return false;
> +
> +	switch (bandwidth_kbps) {
> +	case 9000000:
> +		*num_lanes = 3;
> +		*frl_rate = 3000;
> +		break;
> +	case 18000000:
> +		*num_lanes = 3;
> +		*frl_rate = 6000;
> +		break;
> +	case 24000000:
> +		*num_lanes = 4;
> +		*frl_rate = 6000;
> +		break;
> +	case 32000000:
> +		*num_lanes = 4;
> +		*frl_rate = 8000;
> +		break;
> +	case 40000000:
> +		*num_lanes = 4;
> +		*frl_rate = 10000;
> +		break;
> +	case 48000000:
> +		*num_lanes = 4;
> +		*frl_rate = 12000;
> +		break;
> +	default:
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static uint32_t compute_bpp_x16_from_frl_params(
> +		const struct dc_crtc_timing *timing,
> +		const uint32_t num_slices_h,
> +		const struct dsc_enc_caps *dsc_caps)
> +{
> +	struct fixed31_32 pixel_clock;
> +	uint32_t num_lanes = dsc_caps->num_lanes;
> +	uint32_t frl_rate = dsc_caps->frl_rate;
> +	uint32_t h_active = timing->h_addressable;
> +	uint32_t h_blank = timing->h_total - timing->h_addressable;
> +	uint32_t bpp_target_x16;
> +	struct fixed31_32 r_bit;
> +	uint32_t f_audio = 48000;
> +	struct fixed31_32 pixel_rate_tolerance;
> +	uint32_t audio_tolerance = 1000;
> +	uint32_t frl_bit_tolerance = 300;
> +	uint32_t acr_rate_max = 1500;
> +	uint32_t c_frl_cb = 510;
> +	uint32_t c_frl_sb;
> +	struct fixed31_32 overhead_sb;
> +	struct fixed31_32 overhead_rs;
> +	struct fixed31_32 overhead_map;
> +	struct fixed31_32 overhead_min;
> +	struct fixed31_32 overhead_m;
> +	struct fixed31_32 overhead_max;
> +	struct fixed31_32 pixel_clock_max;
> +	struct fixed31_32 t_line;
> +	struct fixed31_32 r_bit_min;
> +	struct fixed31_32 r_frl_char_min;
> +	struct fixed31_32 c_frl_line;
> +	uint32_t c_frl_line_int;
> +	struct fixed31_32 c_frl_available;
> +	uint32_t c_frl_av_int;
> +	struct fixed31_32 c_frl_active_av;
> +	struct fixed31_32 c_frl_blank_av;
> +	uint32_t acat_ap = 4;
> +	struct fixed31_32 r_ap;
> +	struct fixed31_32 max_audio_tol_rate;
> +	struct fixed31_32 avg_audio_packets_line;
> +	uint32_t avg_audio_packets_line_int;
> +	int hc_blank_audio_min;
> +	uint32_t bytes_target;
> +	uint32_t hc_active_target;
> +	uint32_t hc_blank_target_est1;
> +	uint32_t hc_blank_target_est2;
> +	struct fixed31_32 hc_blank_target_bandwidth;
> +	int hc_blank_target;
> +	uint32_t bpc_factor = 8;
> +	uint32_t min_dsc_bpp_x16;
> +	uint32_t max_dsc_bpp_x16;
> +	bool hdmi_all_bpp = dsc_caps->is_vic_all_bpp;
> +	uint32_t slice_width;
> +
> +	if (timing->display_color_depth == COLOR_DEPTH_101010)
> +		bpc_factor = 10;
> +	if (timing->display_color_depth == COLOR_DEPTH_121212)
> +		bpc_factor = 12;
> +
> +	/* Assuming: bpc as 8*/
> +	if (timing->pixel_encoding == PIXEL_ENCODING_RGB ||
> +			timing->pixel_encoding == PIXEL_ENCODING_YCBCR444) {
> +		min_dsc_bpp_x16 = 8 * 16;
> +		max_dsc_bpp_x16 = 3 * 16 * bpc_factor;
> +	} else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
> +		min_dsc_bpp_x16 = 7 * 16;
> +		max_dsc_bpp_x16 = 2 * 16 * bpc_factor;
> +	} else {
> +		min_dsc_bpp_x16 = 6 * 16;
> +		max_dsc_bpp_x16 = 3 * 16 * bpc_factor / 2;
> +	}
> +
> +	max_dsc_bpp_x16 = MIN(max_dsc_bpp_x16, 256);
> +	if (!hdmi_all_bpp)
> +		max_dsc_bpp_x16 = MIN(max_dsc_bpp_x16, 192);
> +
> +	c_frl_sb = 4 * c_frl_cb + num_lanes;
> +	pixel_clock = dc_fixpt_div_int(dc_fixpt_from_int(timing->pix_clk_100hz), 10000);
> +	r_bit = dc_fixpt_from_int(frl_rate);
> +	pixel_rate_tolerance = dc_fixpt_div_int(dc_fixpt_from_int(5), 1000);
> +	overhead_sb = dc_fixpt_div_int(dc_fixpt_from_int(num_lanes), c_frl_sb);
> +	overhead_rs = dc_fixpt_div_int(dc_fixpt_from_int(32), c_frl_sb);
> +	overhead_map = dc_fixpt_div_int(dc_fixpt_from_int(25), (c_frl_sb * 10));
> +	overhead_min = dc_fixpt_add(overhead_sb, overhead_rs);
> +	overhead_min = dc_fixpt_add(overhead_min, overhead_map);
> +	overhead_m = dc_fixpt_div_int(dc_fixpt_from_int(3), 1000);
> +	overhead_max = dc_fixpt_add(overhead_min, overhead_m);
> +	pixel_rate_tolerance = dc_fixpt_add_int(pixel_rate_tolerance, 1);
> +	pixel_clock_max = dc_fixpt_mul(pixel_clock, pixel_rate_tolerance);
> +	t_line = dc_fixpt_div(dc_fixpt_from_int(h_active + h_blank), pixel_clock_max);
> +	r_bit_min = dc_fixpt_div_int(dc_fixpt_from_int(frl_bit_tolerance), 1000000);
> +	r_bit_min = dc_fixpt_sub(dc_fixpt_from_int(1), r_bit_min);
> +	r_bit_min = dc_fixpt_mul(r_bit, r_bit_min);
> +	r_frl_char_min = dc_fixpt_div_int(r_bit_min, 18);
> +	c_frl_line = dc_fixpt_mul(t_line, r_frl_char_min);
> +	c_frl_line = dc_fixpt_mul_int(c_frl_line, num_lanes);
> +	c_frl_line_int = dc_fixpt_floor(c_frl_line);
> +	c_frl_available = dc_fixpt_sub(dc_fixpt_from_int(1), overhead_max);
> +	c_frl_available = dc_fixpt_mul_int(c_frl_available, c_frl_line_int);
> +	c_frl_av_int = dc_fixpt_floor(c_frl_available);
> +	c_frl_active_av = dc_fixpt_mul_int(dc_fixpt_from_int(c_frl_av_int), h_active);
> +	c_frl_active_av = dc_fixpt_div_int(c_frl_active_av, (h_active + h_blank));
> +	c_frl_blank_av = dc_fixpt_mul_int(dc_fixpt_from_int(c_frl_av_int), h_blank);
> +	c_frl_blank_av =  dc_fixpt_div_int(c_frl_blank_av, (h_active + h_blank));
> +	r_ap = dc_fixpt_max(dc_fixpt_from_int(192000),
> +			dc_fixpt_from_int(f_audio * acat_ap));
> +	r_ap = dc_fixpt_add(r_ap, dc_fixpt_from_int(2 * acr_rate_max));
> +	max_audio_tol_rate =  dc_fixpt_div_int(dc_fixpt_from_int(audio_tolerance), 1000000);
> +	max_audio_tol_rate =  dc_fixpt_add(dc_fixpt_from_int(1), max_audio_tol_rate);
> +	r_ap = dc_fixpt_mul(r_ap, max_audio_tol_rate);
> +	avg_audio_packets_line = dc_fixpt_mul(r_ap, t_line);
> +	avg_audio_packets_line = dc_fixpt_div_int(avg_audio_packets_line, 1000000);
> +	avg_audio_packets_line_int = dc_fixpt_ceil(avg_audio_packets_line);
> +	hc_blank_audio_min = 32 + 32 * avg_audio_packets_line_int;
> +	slice_width = dc_fixpt_ceil(dc_fixpt_div_int(
> +			dc_fixpt_from_int(h_active), num_slices_h));
> +
> +	/* Slice width for 420 must be even */
> +	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 && slice_width % 2 != 0) {
> +		slice_width++;
> +	}
> +
> +	for (uint32_t i = max_dsc_bpp_x16; i >= min_dsc_bpp_x16; i--) {
> +		bpp_target_x16 = i;
> +		bytes_target = num_slices_h * dc_fixpt_ceil(dc_fixpt_div_int(
> +				dc_fixpt_from_int(bpp_target_x16 * slice_width), 8 * 16));
> +		hc_active_target = dc_fixpt_ceil(dc_fixpt_div_int(
> +				dc_fixpt_from_int(bytes_target), 3));
> +		hc_blank_target_est1 = dc_fixpt_ceil(dc_fixpt_div_int(
> +				dc_fixpt_from_int(hc_active_target * h_blank), h_active));
> +		hc_blank_target_est2 = dc_fixpt_floor(dc_fixpt_max(
> +				dc_fixpt_from_int(hc_blank_target_est1),
> +				dc_fixpt_from_int(hc_blank_audio_min)));
> +		hc_blank_target_bandwidth = dc_fixpt_div_int(dc_fixpt_from_int(3), 2);
> +		hc_blank_target_bandwidth = dc_fixpt_mul(hc_blank_target_bandwidth,
> +				dc_fixpt_from_int(hc_active_target));
> +		hc_blank_target_bandwidth = dc_fixpt_sub(dc_fixpt_from_int(c_frl_av_int),
> +				hc_blank_target_bandwidth);
> +		hc_blank_target_bandwidth = dc_fixpt_min(hc_blank_target_bandwidth,
> +				dc_fixpt_from_int(hc_blank_target_est2));
> +		hc_blank_target_bandwidth = dc_fixpt_div_int(hc_blank_target_bandwidth, 4);
> +		hc_blank_target = dc_fixpt_floor(hc_blank_target_bandwidth) * 4;
> +		if (hc_blank_target >= hc_blank_audio_min)
> +			return bpp_target_x16;
> +	}
> +	return 0;
> +}
>  /* Decide DSC bandwidth range based on signal, timing, specs specific and input min and max
>   * requirements.
>   * The range output includes decided min/max target bpp, the respective bandwidth requirements
> @@ -812,6 +1468,30 @@ static bool decide_dsc_bandwidth_range(
>  			range->min_target_bpp_x16 = preferred_bpp_x16;
>  		}
>  	}
> +	else if (dsc_caps->is_frl) {
> +		uint32_t specs_preferred_bpp_x16 = hdmi_dsc_get_bpp(timing, dsc_caps);
> +		uint32_t specs_calculated_bpp_x16 = 0;
> +
> +		if (timing->vic) {
> +			/* For CTA timing, we should strictly follow HDMI spec. */
> +			range->max_target_bpp_x16 = specs_preferred_bpp_x16;
> +			if (dsc_caps->is_vic_all_bpp || dsc_caps->is_dp)
> +				range->min_target_bpp_x16 = min_bpp_x16;
> +			else
> +				range->min_target_bpp_x16 = specs_preferred_bpp_x16;
> +		} else {
> +			if (timing->vic == 0 && timing->hdmi_vic == 0)
> +				specs_calculated_bpp_x16 = compute_bpp_x16_from_frl_params(
> +						timing, num_slices_h, dsc_caps);
> +
> +			if (specs_calculated_bpp_x16 != 0)
> +				specs_preferred_bpp_x16 = MIN(specs_calculated_bpp_x16,
> +						specs_preferred_bpp_x16);
> +
> +			range->max_target_bpp_x16 = MIN(max_bpp_x16, specs_preferred_bpp_x16);
> +			range->min_target_bpp_x16 = min_bpp_x16;
> +		}
> +	}
>  	/* TODO - make this value generic to all signal types */
>  	else if (dsc_caps->edp_sink_max_bits_per_pixel) {
>  		/* apply max bpp limitation from edp sink */
> @@ -877,6 +1557,10 @@ static bool decide_dsc_target_bpp_x16(
>  					dsc_common_caps->bpp_increment_div,
>  					dsc_common_caps->is_dp);
>  		}
> +		/* Assign minimum bpp and validate TB borrow scenario later */
> +		if (target_bandwidth_kbps < range.min_kbps)
> +			if (dsc_common_caps->is_frl)
> +				*target_bpp_x16 = range.min_target_bpp_x16;
>  	}
>  
>  	return *target_bpp_x16 != 0;
> @@ -1061,6 +1745,8 @@ static bool setup_dsc_config(
>  	int pic_height;
>  	int slice_height;
>  	struct dc_dsc_policy policy;
> +	int num_lanes;
> +	int frl_rate;
>  
>  	memset(dsc_cfg, 0, sizeof(struct dc_dsc_config));
>  
> @@ -1078,6 +1764,11 @@ static bool setup_dsc_config(
>  	is_dsc_possible = intersect_dsc_caps(dsc_sink_caps, dsc_enc_caps, timing->pixel_encoding, &dsc_common_caps);
>  	if (!is_dsc_possible)
>  		goto done;
> +	if (convert_bandwidth_to_frl_params(
> +					target_bandwidth_kbps, &num_lanes, &frl_rate)) {
> +		dsc_common_caps.num_lanes = num_lanes;
> +		dsc_common_caps.frl_rate = frl_rate;
> +	}
>  
>  	sink_per_slice_throughput_mps = 0;
>  
> @@ -1201,6 +1892,8 @@ static bool setup_dsc_config(
>  		else
>  			is_dsc_possible = false;
>  	}
> +	if (dsc_sink_caps->is_frl)
> +		num_slices_h = hdmi_dsc_get_num_slices(timing);
>  	// When we force ODM, num dsc h slices must be divisible by num odm h slices
>  	switch (options->dsc_force_odm_hslice_override) {
>  	case 0:
> @@ -1279,6 +1972,11 @@ static bool setup_dsc_config(
>  	dsc_cfg->block_pred_enable = dsc_common_caps.is_block_pred_supported;
>  	dsc_cfg->linebuf_depth = dsc_common_caps.lb_bit_depth;
>  	dsc_cfg->version_minor = (dsc_common_caps.dsc_version & 0xf0) >> 4;
> +	dsc_cfg->is_frl = dsc_sink_caps->is_frl;
> +	if (dsc_cfg->is_frl)
> +		dsc_cfg->num_slices_h = num_slices_h;
> +	dsc_cfg->is_vic_all_bpp = dsc_sink_caps->is_vic_all_bpp;
> +	dsc_cfg->total_chunk_kbytes = dsc_sink_caps->total_chunk_kbytes;
>  	dsc_cfg->is_dp = dsc_sink_caps->is_dp;
>  
>  done:
> @@ -1405,6 +2103,12 @@ void dc_dsc_get_policy_for_timing(const struct dc_crtc_timing *timing,
>  		/* DP specs limits to 3 x bpc */
>  		policy->max_target_bpp = 3 * bpc;
>  		policy->ycbcr422_simple = true;
> +		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422 && link_encoding == DC_LINK_ENCODING_HDMI_FRL) {
> +			/* HDMI FRL YCbCr422 native support */
> +			policy->min_target_bpp = 7;
> +			policy->max_target_bpp = 2 * bpc;
> +			policy->ycbcr422_simple = false;
> +		}
>  		break;
>  	case PIXEL_ENCODING_YCBCR420:
>  		/* DP specs limits to 6 */
> diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
> index cd7d2bb661e5..cff5c95a771c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
> @@ -216,6 +216,16 @@ void hpo_enc3_set_hdmi_stream_attribute(struct hpo_frl_stream_encoder *enc,
>  		break;
>  	}
>  
> +	/* When compression active, CD/PP/Phase field shall be zero in GCP */
> +	if (crtc_timing->flags.DSC) {
> +		REG_UPDATE_2(HDMI_TB_ENC_PIXEL_FORMAT,
> +				HDMI_DEEP_COLOR_DEPTH, 0,
> +				HDMI_DEEP_COLOR_ENABLE, 0);
> +	} else {
> +		REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
> +			HDMI_DSC_MODE, 0);
> +	}
> +
>  	/* Configure ODM combine mode */
>  	switch (odm_combine_num_segments) {
>  	case 1:
> @@ -457,6 +467,94 @@ void hpo_enc3_update_hdmi_info_packet(struct dcn30_hpo_frl_stream_encoder *enc3,
>  	}
>  }
>  
> +void hpo_enc3_hdmi_set_dsc_config(
> +	struct hpo_frl_stream_encoder *enc,
> +	struct dc_crtc_timing *timing,
> +	uint8_t *dsc_packed_pps)
> +{
> +	struct dcn30_hpo_frl_stream_encoder *enc3 = DCN30_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
> +	enum optc_dsc_mode dsc_mode = OPTC_DSC_DISABLED;
> +	uint8_t i;
> +
> +	if (dsc_packed_pps) {
> +		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420 ||
> +				(timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
> +					&& !timing->dsc_cfg.ycbcr422_simple))
> +			dsc_mode = OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
> +		else
> +			dsc_mode = OPTC_DSC_ENABLED_444;
> +	}
> +
> +	REG_UPDATE(HDMI_STREAM_ENC_CLOCK_RAMP_ADJUSTER_FIFO_STATUS_CONTROL0,
> +			FIFO_DSC_MODE, dsc_mode);
> +
> +	REG_UPDATE(HDMI_TB_ENC_PIXEL_FORMAT,
> +			HDMI_DSC_MODE, dsc_mode);
> +
> +	/* 5 packets for hdmi 2.1, use generic packets 5-10 to transmit*/
> +	/* TODO: do we change new bit to 0 after first transmission? Do we set End bit when exiting dsc? */
> +	if (dsc_mode != OPTC_DSC_DISABLED) {
> +		struct dc_info_packet emp_packet = {0};
> +		uint32_t dsc_pic_width = timing->h_addressable + timing->h_border_left + timing->h_border_right;
> +		uint32_t h_back = timing->h_total - dsc_pic_width - timing->h_sync_width - timing->h_front_porch;
> +		/* HCactivebytes = Slices * ceil(SliceWidth * bpp/8)
> +		 * use ... + 15) / 16 to achieve ceil since bpp is stored as 16x actual value
> +		 */
> +		uint32_t h_cactive_bytes = timing->dsc_cfg.num_slices_h * (
> +				(dsc_pic_width / timing->dsc_cfg.num_slices_h * timing->dsc_cfg.bits_per_pixel / 8 + 15) / 16);
> +
> +		/* Packet 0 */
> +		emp_packet.valid = true;
> +		emp_packet.hb0 = 0x7F; /* Default */
> +		emp_packet.hb1 = (1 << 7); /* First */
> +		emp_packet.hb2 = 0; /* Sequence index */
> +		emp_packet.sb[0] = (1 << 1) | (1 << 2) | (1 << 7); /* Sync[1] = 1, VFR[2] = 1, New[7] = 1*/
> +		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
> +		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
> +		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
> +		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
> +		hpo_enc3_update_hdmi_info_packet(enc3, 5, &emp_packet);
> +
> +		/* Packets 1-3 */
> +		emp_packet.hb1 = 0; /* Not first or last*/
> +		for (i = 1; i < 4; i++) {
> +			emp_packet.hb2 = i; /* Sequence index */
> +			memcpy(&emp_packet.sb[0], &dsc_packed_pps[21 + 28 * (i - 1)], 28);
> +			hpo_enc3_update_hdmi_info_packet(enc3, 5 + i, &emp_packet);
> +		}
> +
> +		/* Packet 4 */
> +		emp_packet.hb2 = 4; /* Sequence index */
> +		memcpy(&emp_packet.sb[0], &dsc_packed_pps[105], 23);
> +		emp_packet.sb[23] = (uint8_t)timing->h_front_porch; /* Hfront[7:0] */
> +		emp_packet.sb[24] = (uint8_t)(timing->h_front_porch >> 8); /* Hfront[15:8] */
> +		emp_packet.sb[25] = (uint8_t)timing->h_sync_width; /* Hsync[7:0] */
> +		emp_packet.sb[26] = (uint8_t)(timing->h_sync_width >> 8); /* Hsync[15:8] */
> +		emp_packet.sb[27] = (uint8_t)h_back; /* Hback[7:0] */
> +		hpo_enc3_update_hdmi_info_packet(enc3, 9, &emp_packet);
> +
> +		/* Packet 5 */
> +		emp_packet.hb1 = (1 << 6); /* Last */
> +		emp_packet.hb2 = 5;
> +		emp_packet.sb[0] = (uint8_t)(h_back >> 8); /* Hback[15:8] */
> +		emp_packet.sb[1] = (uint8_t)h_cactive_bytes; /* HCactive_bytes[7:0] */
> +		emp_packet.sb[2] = (uint8_t)(h_cactive_bytes >> 8); /* HCactive_bytes[15:8] */
> +		hpo_enc3_update_hdmi_info_packet(enc3, 10, &emp_packet);
> +
> +		/* Packet 0 - Clear New[7] */
> +		emp_packet.valid = true;
> +		emp_packet.hb0 = 0x7F; /* Default */
> +		emp_packet.hb1 = (1 << 7); /* First */
> +		emp_packet.hb2 = 0; /* Sequence index */
> +		emp_packet.sb[0] = (1 << 1) | (1 << 2); /* Sync[1] = 1, VFR[2] = 1*/
> +		emp_packet.sb[2] = 1; /* Organization_ID = 1 (Vesa spec)*/
> +		emp_packet.sb[4] = 2; /* Data_Set_Tag(LSB) = 2*/
> +		emp_packet.sb[6] = 136; /* Data_Set_Length(LSB) = 136*/
> +		memcpy(&emp_packet.sb[7], dsc_packed_pps, 21);
> +		hpo_enc3_update_hdmi_info_packet(enc3, 5, &emp_packet);
> +	}
> +}
> +
>  void hpo_enc3_stop_hdmi_info_packets(
>  	struct hpo_frl_stream_encoder *enc)
>  {
> @@ -777,12 +875,18 @@ bool hpo_enc3_validate_hdmi_frl_output(
>  	default:
>  		break;
>  	}
> +	frl_params.allow_all_bpp = timing->dsc_cfg.is_vic_all_bpp;
>  	if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
>  		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_420;
>  	else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
>  		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_422;
>  	else
>  		frl_params.pixel_encoding = HDMI_FRL_PIXEL_ENCODING_444;
> +	/* DSC parameters */
> +	frl_params.bypass_hc_target_calc = false;
> +	DC_FP_START();
> +	hpo_fpu_enc3_validate_hdmi_frl_output_timing(timing, audio, &frl_params);
> +	DC_FP_END();
>  	/* Audio parameters */
>  	/* TODO: set Audio parameters */
>  
> @@ -910,6 +1014,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn30_str_enc_funcs = {
>  	.set_avmute			= enc3_stream_encoder_set_avmute,
>  	.validate_hdmi_frl_output	= hpo_enc3_validate_hdmi_frl_output,
>  	.read_state			= hpo_enc3_read_state,
> +	.hdmi_frl_set_dsc_config	= hpo_enc3_hdmi_set_dsc_config,
>  	.set_dynamic_metadata           = hpo_enc3_set_dynamic_metadata,
>  	.hdmi_frl_fifo_odm_enabled = hpo_enc3_fifo_odm_enabled,
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> index 27f7ffd89629..28cb14dc87b0 100644
> --- a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> @@ -879,6 +879,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn401_str_enc_funcs = {
>  	.hdmi_audio_disable		= hpo_enc401_hdmi_audio_disable,
>  	.set_avmute			= enc401_stream_encoder_set_avmute,
>  	.read_state			= hpo_enc401_read_state,
> +	.hdmi_frl_set_dsc_config	= hpo_enc401_hdmi_set_dsc_config,
>  	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
> index 0ec386347f80..d4f66e62c729 100644
> --- a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
> @@ -179,6 +179,7 @@ static const struct hpo_frl_stream_encoder_funcs dcn42_str_enc_funcs = {
>  	.hdmi_audio_disable		= hpo_enc42_hdmi_audio_disable,
>  	.set_avmute			= enc401_stream_encoder_set_avmute,
>  	.read_state			= hpo_enc401_read_state,
> +	.hdmi_frl_set_dsc_config	= hpo_enc401_hdmi_set_dsc_config,
>  	.set_dynamic_metadata           = hpo_enc401_set_dynamic_metadata,
>  };
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index cfca7af6cd1f..a416efcc9325 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -955,6 +955,15 @@ enum dc_status dcn30_setup_hdmi_frl_link(
>  	return status;
>  }
>  
> +void dcn30_hw_set_vstartup_dsc_frl(struct dc *dc,
> +		struct pipe_ctx *pipe_ctx)
> +{
> +	(void)dc;
> +	if (pipe_ctx->stream_res.tg->funcs->set_vstartup_dsc_frl)
> +		pipe_ctx->stream_res.tg->funcs->set_vstartup_dsc_frl(
> +			pipe_ctx->stream_res.tg);
> +}

And these aren't needed here. I'll send a v3.

Harry

> +
>  bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  {
>  	union dmub_rb_cmd cmd;
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> index 26c7386a8a36..cd151c75f59e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
> @@ -106,6 +106,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>  	.enable_dp_link_output = dce110_enable_dp_link_output,
>  	.disable_link_output = dce110_disable_link_output,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>  	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
>  	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
> index 23b30d6f3956..69b8e7030fa4 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
> @@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.set_backlight_level = dcn21_set_backlight_level,
>  	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>  	.set_pipe = dcn21_set_pipe,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
> index 98771fc443c7..8c50604a4895 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
> @@ -101,6 +101,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.set_backlight_level = dcn21_set_backlight_level,
>  	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>  	.set_pipe = dcn21_set_pipe,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> index 0b3e8512ebf1..203c4f7ecd2b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
> @@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.get_max_dispclk_mhz = dcn32_get_max_dispclk_mhz,
>  	.apply_idle_power_optimizations = dcn32_apply_idle_power_optimizations,
>  	.does_plane_fit_in_mall = NULL,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> index fc18d2207711..c0cefeff6e85 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> @@ -108,6 +108,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.set_backlight_level = dcn31_set_backlight_level,
>  	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>  	.set_pipe = dcn21_set_pipe,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> index 19ec5b4edfdc..a852a2345296 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
> @@ -101,6 +101,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.set_backlight_level = dcn31_set_backlight_level,
>  	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>  	.set_pipe = dcn21_set_pipe,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> index d24a352937b4..e1cc16aa207c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
> @@ -85,6 +85,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.apply_idle_power_optimizations = dcn401_apply_idle_power_optimizations,
>  	.does_plane_fit_in_mall = NULL,
>  	.set_backlight_level = dcn31_set_backlight_level,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> index 49c13611a518..e54d814b3ea9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
> @@ -86,6 +86,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
>  	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
>  	.calc_vupdate_position = dcn10_calc_vupdate_position,
>  	.setup_hdmi_frl_link = dcn30_setup_hdmi_frl_link,
> +	.set_vstartup_dsc_frl = dcn30_hw_set_vstartup_dsc_frl,
>  	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
>  	.does_plane_fit_in_mall = NULL,
>  	.set_backlight_level = dcn31_set_backlight_level,
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> index 7e65ccd11386..34e386e16d0c 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
> @@ -1437,6 +1437,9 @@ struct hw_sequencer_funcs {
>  	unsigned int (*get_max_dispclk_mhz)(struct dc *dc,
>  			struct dc_state *context);
>  
> +	void (*set_vstartup_dsc_frl)(struct dc *dc,
> +			struct pipe_ctx *pipe_ctx);
> +
>  	/* Idle Optimization Related */
>  	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
>  
> @@ -1710,6 +1713,8 @@ void hwss_hpo_dp_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_para
>  
>  void hwss_stream_enc_dp_set_dsc_pps_info_packet(union block_sequence_params *params);
>  
> +void hwss_hpo_frl_stream_enc_set_dsc_config(union block_sequence_params *params);
> +
>  void hwss_set_dmdata_attributes(union block_sequence_params *params);
>  
>  void hwss_dp_trace_source_sequence(union block_sequence_params *params);
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> index 1800b1929b16..570c45c7830f 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
> @@ -368,6 +368,10 @@ struct hpo_frl_stream_encoder {
>   * stream interfaces for setup the FRL stream encoder.
>   */
>  struct hpo_frl_stream_encoder_funcs {
> +	void (*hdmi_frl_set_dsc_config)(
> +		struct hpo_frl_stream_encoder *enc,
> +		struct dc_crtc_timing *timing,
> +		uint8_t *dsc_packed_pps);
>  	/**
>  	 * @hdmi_frl_enable:
>  	 *
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index ca56854dc9f1..1cd4a882f66d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -549,6 +549,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
>  
>  	/* dig front end */
>  	config.dig_fe = (uint8_t) pipe_ctx->stream_res.stream_enc->stream_enc_inst;
> +	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
> +		config.dig_fe = (uint8_t)pipe_ctx->stream_res.hpo_frl_stream_enc->stream_enc_inst;
>  
>  	/* stream encoder index */
>  	config.stream_enc_idx = (uint8_t)(pipe_ctx->stream_res.stream_enc->id - ENGINE_ID_DIGA);
> @@ -785,6 +787,22 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>  
>  			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
>  		}
> +		else if (dc_is_hdmi_frl_signal(stream->signal)) {
> +			uint8_t dsc_packed_pps[128];
> +			struct dc_crtc_timing patched_crtc_timing = stream->timing;
> +
> +			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
> +			dsc_optc_config_log(dsc, &dsc_optc_cfg);
> +
> +			/* if we are borrowing from hblank, h_addressable and  pic_width need to be adjusted */
> +			if (dc->debug.enable_hblank_borrow) {
> +				dsc_cfg.pic_width = stream->timing.h_addressable;
> +			}
> +
> +			dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
> +			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
> +					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
> +		}
>  
>  		/* Enable DSC in OPTC */
>  		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
> @@ -816,6 +834,9 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
>  							pipe_ctx->stream_res.stream_enc, false, NULL, true);
>  			}
>  		}
> +		else if (dc_is_hdmi_frl_signal(stream->signal))
> +			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
> +					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
>  
>  		/* disable DSC block */
>  		for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
> @@ -903,6 +924,12 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
>  						&dsc_packed_pps[0],
>  						immediate_update);
>  		}
> +		else if (dc_is_hdmi_frl_signal(stream->signal)) {
> +			//TODO: bring HDMI FRL in line with DP
> +			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
> +			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
> +					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, &dsc_packed_pps[0]);
> +		}
>  	} else {
>  		/* disable DSC PPS in stream encoder */
>  		memset(&stream->dsc_packed_pps[0], 0, sizeof(stream->dsc_packed_pps));
> @@ -917,6 +944,10 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
>  				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
>  						pipe_ctx->stream_res.stream_enc, false, NULL, true);
>  		}
> +		else if (dc_is_hdmi_frl_signal(stream->signal))
> +			//TODO: bring HDMI FRL in line with DP
> +			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
> +					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
>  	}
>  
>  	return true;
> @@ -2426,6 +2457,8 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
>  	if (pipe_ctx->stream->timing.flags.DSC) {
>  		if (dc_is_dp_signal(pipe_ctx->stream->signal))
>  			link_set_dsc_enable(pipe_ctx, false);
> +		else if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
> +			link_set_dsc_on_stream(pipe_ctx, false);
>  	}
>  	if (dp_is_128b_132b_signal(pipe_ctx)) {
>  		if (pipe_ctx->stream_res.tg->funcs->set_out_mux)
> @@ -2606,6 +2639,11 @@ void link_set_dpms_on(
>  		}
>  	}
>  
> +	if (pipe_ctx->stream->timing.flags.DSC &&
> +			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
> +			//TODO: bring HDMI FRL in line with DP
> +			link_set_dsc_on_stream(pipe_ctx, true);
> +
>  	/* turn off otg test pattern if enable */
>  	if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
>  		pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> index 6db1f07fdb79..decc3061c58c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> @@ -92,6 +92,25 @@ static void hdmi_return_preeshoot_and_deemphasis(struct dc_link *link,
>  	}
>  }
>  
> +static bool hdmi_frl_test_dsc_max_rate(struct ddc_service *ddc_service)
> +{
> +	uint8_t slave_address = HDMI_SCDC_ADDRESS;
> +	uint8_t offset = HDMI_SCDC_SOURCE_TEST_REQ;
> +	union hdmi_scdc_source_test_req test_req = {0};
> +
> +	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
> +
> +	link_query_ddc_data(ddc_service, slave_address,
> +					&offset, sizeof(offset), &test_req.byte,
> +					sizeof(test_req.byte));
> +	if (test_req.fields.DSC_FRL_MAX) {
> +		FRL_INFO("FRL TEST REQ:  DSC_FRL_MAX = 1");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  enum clock_source_id hdmi_frl_find_matching_phypll(
>  		struct dc_link *link)
>  {
> @@ -767,6 +786,9 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
>  			link->preferred_hdmi_frl_settings.force_frl_max ||
>  			link->ctx->dc->debug.force_frl_max ? true :
>  			hdmi_frl_test_max_rate(link->ddc);
> +	link->frl_flags.force_frl_dsc =
> +			link->ctx->dc->debug.force_frl_dsc ? true :
> +			hdmi_frl_test_dsc_max_rate(link->ddc);
>  	link->frl_flags.apply_vsdb_rcc_wa =
>  			link->ctx->dc->debug.apply_vsdb_rcc_wa;
>  
> @@ -778,8 +800,16 @@ void hdmi_frl_verify_link_cap(struct dc_link *link,
>  			link->frl_flags.force_frl_always = true;
>  
>  	if (!link->frl_flags.force_frl_max &&
> +			!link->frl_flags.force_frl_dsc &&
>  			link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
>  		link->frl_flags.force_frl_max = true;
> +		link->frl_flags.force_frl_dsc = true;
> +	}
> +
> +	if (link->frl_flags.force_frl_max &&
> +			!link->frl_flags.force_frl_dsc &&
> +			link->local_sink->edid_caps.panel_patch.hdmi_comp_auto) {
> +		link->frl_flags.force_frl_dsc = true;
>  	}
>  
>  	if (link->local_sink &&
> @@ -996,6 +1026,9 @@ void hdmi_frl_set_preferred_link_settings(struct dc *dc,
>  			resource_build_info_frame(pipe);
>  			link_stream->ctx->dc->hwss.update_info_frame(pipe);
>  
> +			if (link_stream->timing.flags.DSC)
> +				link_set_dsc_on_stream(pipe, true);
> +
>  			link_stream->ctx->dc->hwss.enable_audio_stream(pipe);
>  			link_stream->ctx->dc->hwss.enable_stream(pipe);
>  			link_stream->ctx->dc->hwss.unblank_stream(pipe,
> @@ -1104,6 +1137,10 @@ void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
>  		*frl_link_settings = stream->link->frl_verified_link_cap;
>  		return;
>  	}
> +	if (stream->link->frl_flags.force_frl_dsc) {
> +		*frl_link_settings = stream->link->frl_verified_link_cap;
> +		return;
> +	}
>  
>  	if (stream->link->local_sink)
>  		if (stream->link->local_sink->edid_caps.panel_patch.hdmi_spe_handling) {
> @@ -1126,6 +1163,7 @@ void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
>  	} while (!success);
>  
>  	*frl_link_settings = temp_settings;
> +	update_borrow_mode_from_dsc_padding(dsc_padding_params, &stream->timing, frl_link_settings);
>  }
>  
>  void hdmi_frl_write_read_request_enable(struct ddc_service *ddc_service)
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
> index d72574db1f07..78fd8d262de3 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.c
> @@ -189,7 +189,13 @@ void optc3_set_dsc_config(struct timing_generator *optc,
>  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>  
>  	optc2_set_dsc_config(optc, dsc_mode, dsc_bytes_per_pixel, dsc_slice_width);
> -	REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
> +
> +	if (dsc_mode != OPTC_DSC_DISABLED
> +			&& optc1->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 1);
> +	} else {
> +		REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
> +	}
>  }
>  
>  void optc3_set_odm_bypass(struct timing_generator *optc,
> @@ -314,6 +320,27 @@ bool optc3_get_pipe_update_pending(struct timing_generator *optc)
>  	return (flip_pending == 1 || dc_update_pending == 1);
>  }
>  
> +void optc3_set_vstartup_dsc_frl(struct timing_generator *optc)
> +{
> +	struct optc *optc1 = DCN10TG_FROM_TG(optc);
> +	unsigned int vblank_end = 0;
> +	unsigned int vstartup_start = 0;
> +
> +	REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_END, &vblank_end);
> +	REG_GET(OTG_VSTARTUP_PARAM, VSTARTUP_START, &vstartup_start);
> +
> +	/* In FRL+DSC mode the VSYNC is generated in OTG at start of HBALNK
> +	 * before frame start (VCOUNT=0 and HCOUNT=0). We need to program
> +	 *  VSTARTUP at least one line before frame start to ensure the VSYNC
> +	 *  will be generated in VRR mode. We need to program
> +	 *  VSTARTUP_START >= V_BLANK_END + 1.
> +	 *  When fullscreen = false,
> +	 *  global_sync will restore VSTARTUP_START to normal value
> +	 */
> +	if (vblank_end >= vstartup_start)
> +		REG_SET(OTG_VSTARTUP_PARAM, 0, VSTARTUP_START,
> +				vblank_end+1);
> +}
>  /**
>   * optc3_set_timing_double_buffer() - DRR double buffering control
>   *
> @@ -409,6 +436,7 @@ static const struct timing_generator_funcs dcn30_tg_funcs = {
>  		.get_optc_source = optc2_get_optc_source,
>  		.set_out_mux = optc3_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> index 16c5610b49ac..8a88867f4361 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> @@ -349,6 +349,7 @@ void optc3_triplebuffer_lock(struct timing_generator *optc);
>  void optc3_program_blank_color(struct timing_generator *optc,
>  		const struct tg_color *blank_color);
>  
> +void optc3_set_vstartup_dsc_frl(struct timing_generator *optc);
>  void optc3_set_vtotal_change_limit(struct timing_generator *optc,
>  		uint32_t limit);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> index 98aaa22ce81c..bbf703777f72 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
> @@ -500,6 +500,7 @@ static const struct timing_generator_funcs dcn31_tg_funcs = {
>  		.get_optc_source = optc2_get_optc_source,
>  		.set_out_mux = optc3_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
> index a7cf34937b2f..4d4b517575e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
> @@ -244,6 +244,7 @@ static const struct timing_generator_funcs dcn314_tg_funcs = {
>  		.get_optc_source = optc2_get_optc_source,
>  		.set_out_mux = optc3_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> index 60e546b69a05..99258b2fb14e 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
> @@ -354,6 +354,7 @@ static const struct timing_generator_funcs dcn32_tg_funcs = {
>  		.get_optc_source = optc2_get_optc_source,
>  		.set_out_mux = optc3_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> index a880e4a6d165..f6183c2e78e4 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> @@ -595,6 +595,7 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
>  		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
>  		.set_out_mux = optc3_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> index a6d76f451cf8..581517c9cec4 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> @@ -521,6 +521,7 @@ static const struct timing_generator_funcs dcn401_tg_funcs = {
>  		.get_optc_source = optc2_get_optc_source,
>  		.set_out_mux = optc401_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
> index ed66a2bbb8ae..f5280bc3c7ec 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
> @@ -250,6 +250,7 @@ static struct timing_generator_funcs dcn42_tg_funcs = {
>  		.wait_otg_disable = optc35_wait_otg_disable,
>  		.set_out_mux = optc401_set_out_mux,
>  		.set_drr_trigger_window = optc3_set_drr_trigger_window,
> +		.set_vstartup_dsc_frl = optc3_set_vstartup_dsc_frl,
>  		.set_vtotal_change_limit = optc3_set_vtotal_change_limit,
>  		.set_gsl = optc2_set_gsl,
>  		.set_gsl_source_select = optc2_set_gsl_source_select,

