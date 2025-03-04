Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEDFC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 14:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E108E10E5FC;
	Tue,  4 Mar 2025 14:37:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3lBINu1n";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1282210E5FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 14:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1ZXHRprlZYp2E1WBHxICacXDESqhh7Cyz9XlUTLbsUc5LuVWm9H3oXaa+EnHTvM7Et0ky9NbC+oL9jIHPVm1o0H9bnT+p5ePiHXx9vjo1aI+AApXRMZGawcHOibruGLuZfFptZpscvdy1jdBFIjLy99us5DMS03qHOcKCHgeP0r2EaciTdPRZB0mTuYhLd5IH7Q7hx8FK57OCb7fdwvVumniN0GkG9OPv8G+jMu03AMpulOA/dyYeo302ygKiBNfmwNdo64K3B5S51GJ6frgox5XzLdJ7WsJM1q+09YpXGe90IOH3jKEphTI5eMU57BU1hbYmy8NQhUw5PrRMtbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxzMJoJRTlTwRNU2q7BpDyoIcITtg6fFspSJt/QSito=;
 b=K5htcbnQjJrBuY2m5ANxZ3gAZqUcL/B4R2SZGD5HFYRNhOVKmeGWxahypzjtUfL4EuyycntFoqeenI+H5Gj6d1Q65iCKi05rVytPW9lm01nuFJ/+y6Ovb4qUj9TjM0XSOTHQhUJS5Uow4GtFvDUtbem6cydd3OyslfQSeOHBpT0nwziZLW0klNTbBCX1UcUZkJYluulZS3Y8phFx9RorGY6+r34gFGLGRAPYRuZidmZ4JNBAxHEvQsKAs6EMZwhCYv2Pq9fdhmm4KIsdXuPjHfpKfDvEU1OptpxlQ/b4U/s4oa0lf8/f7awWgqvsMVvGt5gCHrc7zLsernGlnmQdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxzMJoJRTlTwRNU2q7BpDyoIcITtg6fFspSJt/QSito=;
 b=3lBINu1no3Ym9jrUstEcc2Y5J4OEbdpQWImdNjWFhbs5J05Yi4s8H2tcSMKlw/Afrbc+5YZppoQDtjCRAhS4s90hnMIUt7uHO6W9yMbaZfcKoqSkBVxJzJnYnwRygQJrgx/wKqOjhM/DKc9vxX5JsLPx9X/VSptIPivZuaMpPNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 14:37:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 14:37:23 +0000
Message-ID: <8873a34a-4f00-4910-a8f0-6bf103cdf6e2@amd.com>
Date: Tue, 4 Mar 2025 20:07:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250304142040.3946594-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250304142040.3946594-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: f534cfba-9707-464a-0dbd-08dd5b2a13be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmdqdVpkYmdkdGpuOGtuTXRDZENORk1TSnhuc3RkVHR4NkIvZnJuaGRndTQr?=
 =?utf-8?B?Yk1xcjRtcWtBeVZsS3ZGd3M2N0FpNG5PVHVqT01IYzAyeVFIOEV2S2JMQ2Y0?=
 =?utf-8?B?SEdzYW5FWno5bVhyM3FabDZXMTFmYlB4UmZWcUVZeEx2RjdwSUFhS0Z1R2ZM?=
 =?utf-8?B?YnRxZ2R4K0oxTjh1QlBpbzd0S0tXMHRLSFdBakdESGU3ZS83MjJKODJRWEps?=
 =?utf-8?B?Ui9ZZzRRUS9BSlJ2Uys0NUZXazM2OVhFNjQrVzVaVGtRY2NZbmJXS3gvWHBS?=
 =?utf-8?B?eXV5c0srbzE3QTIya2JXMlRqdERzU2lXUTQ4Z0lvdUczeWJZSTVBamFIUFlm?=
 =?utf-8?B?UnVpN3l3L3lNUXU3d2hIdkZoeXdmbTVQdHlEZzF3cUl1cERLRWNKTmlPME54?=
 =?utf-8?B?TEFoWkFHQi82WE1NVjBUWlhkRDF5WnI3a0EzbHdlcFRhQ2IvRVRER3Y3NmNs?=
 =?utf-8?B?d1BKL243emZmRFlxWlpwUjNuQkpGQVlnNVFXUVBxT0c3eEJLMkN3Yyt0T3Zj?=
 =?utf-8?B?SkNWM0pOS2FzM2x1VDRPYzlsWDBZVEtvaHBoRlQ3bFdGR0dLSGhXZmt0ZktG?=
 =?utf-8?B?Tm1MeGovNUZmbHJvTkFPWnIrMUtSUCtUOVYyWmZvVXB3RGIrYTJwVWZIWnQv?=
 =?utf-8?B?K1V1VTBUWSszUDdMc09JWE1CVDBFMmRFSEswOHNHaEk0M1RWb1dTblJqS3Ax?=
 =?utf-8?B?Q0VjMGJPYmFxK1g1UnlFR2JLd3huQUxKMXBsREFlWEk4OUJoek05LytKZVh3?=
 =?utf-8?B?VWxocEdzY2szSG9URE9YYzBHR29aclF1UnAvTHN5ZHA4ZzR1eUszcWtCejQw?=
 =?utf-8?B?Y1R0U2xVYWtWVGJmYzBIT04xZGpSaVNxSy9GSVp2Y2J6Zlg0OEJMUHNneEJN?=
 =?utf-8?B?Q2N1ckdiVUprTjhZRlZ4elNGZTVoSU1FTlo5dGlNemVMaEl2WjBSVTBDVG5V?=
 =?utf-8?B?MzlQV2FncVRCaFpDQk1rVEFSMXBQaDZ6cGRqRmpqSEo0dzI5bWNobHBCdXVr?=
 =?utf-8?B?bjBXTXlCTTZNS0FRQ3c1ZkRJdTg5RHh4VGl3aGxheXF3d0lpaC96OWt0cXFQ?=
 =?utf-8?B?RkN0Z0lET2VScTMxcFdBWFhHNWR6aXFOcEpIbEgxY2RHTzh4Wk1RRnpwK3Jk?=
 =?utf-8?B?ZVVhQ1FieGx0cmFmM0VoRHNoS0ZySC9kMXM0RzFFSlZpTEpMRTM4REl3TUFl?=
 =?utf-8?B?ZEE1MnBObEtSQjcrdW5Nak8rSy9kZ21WdG5VaXNOYjdEbjU2SlZhVG42WkpU?=
 =?utf-8?B?andoYzlLM0M2MzNaV3A3a1FhREFzamt6REw4MnB2R0QzMDhJR1pURDloQVZT?=
 =?utf-8?B?OVhyRmZQdUFsaTkwQ0RmN2duQkt3MmdJbjZCVk9jZy9HNVNyUlIybUJOWkVJ?=
 =?utf-8?B?QlFXWXl5RWI2ZkRvTWdUbUJRanZZdlNoV1pDRXZXRzRScTlHYWFFa3ZVaWdV?=
 =?utf-8?B?REczMEVNNDJIb1RpYm13NTBUN09Xelc0T2h5M0xCTTNjN2RlWThOb2tTZERZ?=
 =?utf-8?B?UEFmZGIzcTFYa2pxaXoxQ1ozakszY2VIVWhhQTlqOG0zbnd0aHVQUndhUlFN?=
 =?utf-8?B?anRTeEx0UG82UVlEMlpqNkdYTVREc25IVWhzb3RaWlRySGNqQVEwSjkyd3lx?=
 =?utf-8?B?MDJwWFN3QnQ4SjYreTdGV3lLdXRzK2psNWdpd1RuU1FtQm9OczVmUWdNdWFt?=
 =?utf-8?B?N1gremMrQmFiMUZXTVkvZXZ5NzlqeTdXcDFyOUllYVNsS3dGN1BjSjg4NVRT?=
 =?utf-8?B?RUpTOTkvT0JMNlpBZVlrUVVYTUYxNi9ZbFJtOTdWd0pZam5RN0xPK3ByOFlT?=
 =?utf-8?B?U3pJVXRsaDlDQWFqVkE4VEVreUdTVmpSaGpzS0x0Uzh3dUNHZ1lhSmNTSXhx?=
 =?utf-8?Q?j61lSqD+2e4NZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkgzWk1kRzJ4TWNMUkxkbGozY2wvWTlRYUErQlRGV3ZTUGhWblNpOCs2bC80?=
 =?utf-8?B?cExoQjNac0wvT3h0R2grWU8wK28wNnZXNkoxc1lMUWVWRjRXaXN5V3JadjVP?=
 =?utf-8?B?SUJJWnU3NkI1M3ZwbE5tcTJ6aGp1cmYyZHdaUFpyTkVmeTdzUTZZRWhuQVpV?=
 =?utf-8?B?ei9OZVgydlVDWVordXNVMlR3N2Ntdytka3dLSit0K2ozc2huYVB1MlJ5cmVN?=
 =?utf-8?B?SnFwSVRaNEdZOGJTUWhWbVo4UE9VcSt0cGc1T1ZvaCtqNTVMUWgrMEEwKzVs?=
 =?utf-8?B?YnBKR2Erd05WNFRYNHZXNmlnZUpDYTQ2T2ZUVkhMS3ducGVsQVMzeFRjSDc2?=
 =?utf-8?B?aCtHQTVIeHBkcEwwSkxKTUtGRHF5bHJmK0l0WmpFRGpkYVE5cVkva0N4VFdx?=
 =?utf-8?B?Nm8vMkNPUWpzQXAzNkV3UllMWVYwNlQrNkdYM3NxSVhGdVRYNTljbElxd2tV?=
 =?utf-8?B?UUozbWorYWZlZThRSTBoVkVTZXVHVDFnZnpRSlVCci96N2FPSnltejJXNGgr?=
 =?utf-8?B?NUE2NjBiZEVjaTVKbEdxb0lJSUFDbytWdFR1VllyejVwVksyd1Z3WnlDRWJu?=
 =?utf-8?B?S0czbCtwU0R2ditsbjlZUDRWVHhMcUYxVkJkNk9nTmtxamY3ZW9abUxMUXZN?=
 =?utf-8?B?dU1nQS9NOEpQdis3ZDVOL2Q2d3ppcjNMR2hsU0JISjl2bEo2dmhMMFBvNlk3?=
 =?utf-8?B?cnJsYlRqZmNVeERHT05ub2FmTkhVcjhsUW5IWUJFd3ZkY1J1OFhkbDEvdjZp?=
 =?utf-8?B?eDdRV3NlbVh0VW9mQ1hTNi8zbVJCWFM0TFlONUlHN1BCMzFET28vMnNzb0Ns?=
 =?utf-8?B?V3cwNTNNU3NMRkV0eVc4UytmNCswMDN3M28zUk9NUCtIRnBpY2Fma01HdU1B?=
 =?utf-8?B?cmRGRllJcjNoQzZwQmVYbWFyYi9UdE00ajJ4aFJOSDFocWN3Z2hKZ2NBZWpv?=
 =?utf-8?B?bWpBK2hGbmVranFaMjJuVTk5Y0NLTXhiNkR3VGhma1Y5cWZMeUpIV1dUOUVl?=
 =?utf-8?B?dzBKNlB0M1Z3amljTWNNenI0SmNCQkdMT2xLMTlNSWJ3ckJ3Rmx6aHEwK1Fr?=
 =?utf-8?B?bDZaUVFpNFhhRFY0c05SemFLUncrTWErSWdWRkplaE80UGdtbWtxMnhxRTEy?=
 =?utf-8?B?emZiUlA3TGZBWit1RUppTWRodlJVTTZnMlVzVkxsL1lWTWxoUUN0SFp3cVRD?=
 =?utf-8?B?aTB2TzA4bmNzOE1SQjVvUVFoWWovUTI1Qk9WZFVLNnE2RkwxQ2UwODdOaVNK?=
 =?utf-8?B?NmtkU0hJT09GRk4zRGxpSC9JL3h6Q2RvaGVvcS9QS0hRZ2ExMllJSUZGNWxR?=
 =?utf-8?B?aElHazlneUx5eFlTK1Bydjc3YTlWV0UzdjEwR29TQmZnQnVxNG9hVE5PdUlQ?=
 =?utf-8?B?bXZpTnBJY3JiSzFha3hqa3pNNDVKeVAyVzJORjg3VXZrV2hCdW5pOUNWMDFH?=
 =?utf-8?B?RjM1amZjb1FSMjZkWjJGV25tTUlUNXR1RGJyT0pTOXR1ZURpT3R2QlB4N2pt?=
 =?utf-8?B?dkplUjJvbkw3Q29KRU9MMjJCUnYzb1pzRkpaK0Jqa2ZHUWU4aFN3OFRJbEdm?=
 =?utf-8?B?c05yQm1EYW93VzFPVVpsYmpGcThHRy9NK1BJZnpINE9xVkxCTjlEOEF2RjM5?=
 =?utf-8?B?SHFFUFRGTTJyaWFrZjhOeUU1TGg5V3ZsK01OSHlQdzUzdmRPK0ZlMGJ5NHVa?=
 =?utf-8?B?MEdKNGpzSERNQlJWaTU0dHFtT0V2b21XdnN1U3pSaU8raUlHQzdiM0c1eTVD?=
 =?utf-8?B?eDVYNXRONTRHWHlnTTdGOGQ0c2dFN2xwSnNZeFE0dFBCSE5rSC9iNmNBczJR?=
 =?utf-8?B?aWZranc2R0VaNXV5ZXpUZDBEMVhBemg1NG45UEluZWIrTUE0N3R4L1Fzekk4?=
 =?utf-8?B?bHl0VCtmVnpDTkZ4QWFlWFlLMHNkRDRGMnJhS1RLV2FxbDgwR2lLYmREWmFF?=
 =?utf-8?B?d1lWNmJ5S09DclpSS3hLZ21ZbmdTMmcrVHFOMjhadDdqV25mQ29qUEhyRldo?=
 =?utf-8?B?MTkySXd4VTV3SFF6SUJJdlgwYkJ6SS9VS3lvTEJ6RmltS21objEwSmtxSS9Q?=
 =?utf-8?B?dVdUTkhMZi82L1NOczdvVUVzSFBQcEVRMC9KUnRWNGcwTXBKclplNityRmVt?=
 =?utf-8?Q?8QQFPgEKNRxJkutWe95by3uU3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f534cfba-9707-464a-0dbd-08dd5b2a13be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:37:23.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0DHm98BCbIHqLogk8imvzeTqwr20+HCkk/NxCKe0HqZQRWYHdYtLI64l2XtCS83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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



On 3/4/2025 7:50 PM, Alex Deucher wrote:
> VCN 2.5 uses the PG callback to enable VCN DPM which is
> a global state.  As such, we need to make sure all instances
> are in the same state.  Use amdgpu_device_ip_set_powergating_state()
> rather than the per instance set_pg_state() callback.
> 
> Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle work handler")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 8d8b39e6d197a..b93102e9fb43e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -437,7 +437,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  	fences += fence[i];
>  
>  	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> +		/* VCN 2.5 PG is actually DPM enablement which is global so
> +		 * update all instances
> +		 */
> +		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +							       AMD_PG_STATE_GATE);

What about moving this logic to vcn_v2_5_set_pg_state? Apart from that,
the number of outstanding fences are counted only for the corresponding
instance. Won't this be problematic when multiple instances are active
and one of them gets to idle? May need a refcount as well.

Thanks,
Lijo


> +		else
> +			vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>  		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>  						    false);
>  		if (r)
> @@ -463,7 +470,14 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  	}
>  
>  	mutex_lock(&vcn_inst->vcn_pg_lock);
> -	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> +	/* VCN 2.5 PG is actually DPM enablement which is global so
> +	 * update all instances
> +	 */
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> +						       AMD_PG_STATE_UNGATE);
> +	else
> +		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>  
>  	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&

