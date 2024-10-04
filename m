Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E6ECF8844
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE6CA10EA25;
	Fri,  4 Oct 2024 14:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYbasbvk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C3310EA25
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXgXO5gCtEKCE7cv0ezVA3KsarJLkjs3T7Nt+o313DSvw1t6f3VQ1FcUNQTjMr+TLN2s45+YLAUkNlDMvese+YZyUuvDJIZhpRJhzZBLuzI4aHTOtl9cm0zTLpnsaUPgdO3r5C3sOzTyURvzBsmxMhLm4uU9YB9d8lB3Q0Tq58BC/hHqWog0JfxWK2c/jLL9wekxh/oLKYhS85YAWcSEWoN4rRTcuaBOkwDnXtsXKdNfcwGJelHkI7iXueb8HxMryIXBe1JlRxRI1/RBazxcc8dAjLK1jBSf4X20Gy+TmSvdZkmaYAsSa7nyM3FaYahHgWvTzpRHipK5RCGbo4b9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ0TD3ZIosHFTd+Oo5ePGDTFDffhLvo/7GSc+GPSKho=;
 b=YO2k1QNYU0bqehRi6YpuwAH4kj8NElxCgwR0ugFxUV49vpNj6GktRVWooacYGiPxxwXbiTDH86BuV/nWp3g5HEBDr5OM4S1fvdWJgSgVsr8F9eZAtrqs/luzDxb6Lm1alYCEmGvSeET02qRhk/J2TOoVU5bVFvMQBei4ne38DX+NajkgViVRos8ks7jR1d5JZNU+wa8rj+jr+0ay+ciUhrzaugEhVbKboNL/Zb4E1bghKt4nAIDUzZ4qXJryAk8to5YRdQrpqy61DuAe0kPKnyaCFtAVi9nCz60hBRgTLl/7Jqr5ESumPUTr+K7Kqq0iq8cjkt8H19xfy85YRpub8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ0TD3ZIosHFTd+Oo5ePGDTFDffhLvo/7GSc+GPSKho=;
 b=vYbasbvkKD35/SXHKSncxn3iKhfhrNdMdu6gTjbzBsI1LcqDeYMDwekjR/Sef4nH51AhZXt8amBwEQZOmLTTwy7TyAhjNPXbxho+XwwvFBtLLMf5FIUb2Vic4jxVdAlkKLGtZmZ2SHr3ap/jCv06UNXFJUO1ImIrg8fSu6zrFBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Fri, 4 Oct 2024 14:37:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:37:15 +0000
Message-ID: <63449d95-1ad1-468a-82f8-78d7da4c2c26@amd.com>
Date: Fri, 4 Oct 2024 20:07:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: partially revert powerplay `__counted_by`
 changes
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241003140614.3976582-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241003140614.3976582-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: e6735562-16a9-4885-6278-08dce4820a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUZaMHBqdHZQams1T3d4Z3RUSnlzUEpQbWpjN1gvaGlNQldSVGk0L1ZSd2la?=
 =?utf-8?B?eEpna25DWFV0ZzlWSmpzUGt3MWRjRTZXa1ZDR2wwRHZ4Y3hmdmU2a0prMUhm?=
 =?utf-8?B?ZTVOdmNnM0ZoMGpzdnVJTXpkNE5UdCtZVjNrL2FrZFY3YUc2ZVEySys2SWtQ?=
 =?utf-8?B?c0JPMHJNeVBKdzd2ZVo1QlF5NUNlZDRpRjNBcVJmbm1UTjN0UExGWHlEZEx5?=
 =?utf-8?B?NS9ZNWtGeHFodG91aXRuRlRjak1TeC9samNGOGpVOXoya1A3UmlzVWxpVHoy?=
 =?utf-8?B?RXh4cEprTU1PN0lwd3cvN2V4eS9maGV4RUtYSitmN0ordlhjenJ5czRXTHZ4?=
 =?utf-8?B?Mis1RE8va05rOEllejcxakhiTnBTUHBYbUhpU3JiL2luM3NPcDdLTkNmcENM?=
 =?utf-8?B?N2FPSjljZlRlTlNkOXAwazZSUjZzSlhqY2IyRjR1eS8xYU5Da01jMnVtL09S?=
 =?utf-8?B?QUFsdmhGaHRONDdTRHhtTi9vOGEveUFtdlIyMy93NkY0bnlPZEx5bE0wQjA4?=
 =?utf-8?B?T0Y5UElVT3MvZExERTROTlVadHhOMnloVmZ2dllNNWNvTFVhb1lLRDZ1WWxy?=
 =?utf-8?B?aUY3cWRObjRIU3UyVUJjc1pmZ0V1aHVzN04wNHJNL1o0enpRNldodUZpV3Zq?=
 =?utf-8?B?aWw1WlU4QjNqaHBWRS9uOWNpWTBOOWdYQjBXY3N0WmFkSHVqWmZLdVJYZVRV?=
 =?utf-8?B?QkE1MTJsRU5pb2gyU2x3Yyt0emloMWtvT1lLU29KRzVGRi9LNW5aUmdEcGpz?=
 =?utf-8?B?anRCcHFIUW13RVdoVzJyS2NFL2xwVUx3VEhTd2EzYXpkMFd3SEE1NzFhV1BF?=
 =?utf-8?B?L0tLODU3bTdRdlE4TnBYcFlSYm91dytTdzhOTERUNmJrQzBDWHNGK2YwNEU4?=
 =?utf-8?B?Wks4ZHRGVWFBdzkwN1FRVitsdWxDM1R0MEFwN1NEK2NORjJiUVFDa3FVeVFS?=
 =?utf-8?B?cDl3cVlLMXFlOVJqTWkxNEM3bnBJSlgxaWY4alp2SVFCS0lzdUxWektNaC93?=
 =?utf-8?B?c1NXU0xzeGlWM0Y4aDJUcVZiVkZOZjFYR0sra1BpV0FYTmNDOVIrS1dibUQr?=
 =?utf-8?B?N3hXbmxwcGVveEg5ZzZCd0lKcGFmMlVzVmNMYmhTdHArMnpMdWVOYU0xM0pj?=
 =?utf-8?B?aWRGT1BKdER1RXZ3NHNxVDUrdmxMVm5iRlZodGdYZ1Nkc3lNeTdwVVYrZE4y?=
 =?utf-8?B?WmtpWmtkOUxIMXJUNEFiZHRqUFNoQVgrSDNBeGF1RHRaOE5uSEp1VktodjND?=
 =?utf-8?B?eC9hSWxyR3hKTWhzd0NVQjcvbnpkM2FjdDljRE1CeWFhaks1UVJTN0VxbHN3?=
 =?utf-8?B?bTZtNDBFSHFjZ3ovQm93a0xBSVZYZ29zcjRxN1ZVSEowU2NjeFYwb3AwbERX?=
 =?utf-8?B?emJ6bUdKbnZGNmZ3WC91M0RqRm02UGFCd25oYW95ZGNjakZLamdyc2VjdnQw?=
 =?utf-8?B?WHVPamM0WkNXZTZiM0RucE9yaHJHYU1oRGR2RnZhTkRyVUdKT1RLeWxYc3lq?=
 =?utf-8?B?WUJLM2V4Wm5qMkJ3U1BDaDdoQmZGY0NhaHQwUllLbFlaRm5xZlo1M0UwQ2Fy?=
 =?utf-8?B?TGFFR0F2WkdCL3F4ZCtmU1RtQTB4MWw0TDNPMm14bUlETDA4elgrZFNmajJB?=
 =?utf-8?B?M1VPbW9HdXB2Zy94VW9RMVBYWXFHY3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZqa0dOZTBKK3lzSDMxRUNjMGpnWVlLN3F4amhmU01SdS83bGdURThLak9M?=
 =?utf-8?B?UGx4aE9vVmtvemxFQ2kwMVpSNFpxZ29UbjdVWFNOSjZjUjZiZGIvTG1kSzR5?=
 =?utf-8?B?aVZBS0NRbHh0bFl2dCtZbm8xT25RWWZNdEQwQVV0NWNHbWJjdXNPYmQ0aS9v?=
 =?utf-8?B?ejN4K29MeTZQSjY4enk5dW5QRHJBKzA1YnRNSXF3clJRejMwV1VTUEVaVHg0?=
 =?utf-8?B?ZW0ybytHRi9kV0w4cmtXMWEwbnF6Zk0zUjlSUEdZZGVmM2pDZEpXUi9mL2Zt?=
 =?utf-8?B?SmxoMmZnb2xTcmpKdTdjRzhwanBwUXpReW9paEhnVlN0V0dFQXBuQjJORDRm?=
 =?utf-8?B?N1NoZ0FiTjJNNGtvWUM0NDJhUmdsNUI1TkoyWkQ5YU1zRnpOTFlWdmtnTXMv?=
 =?utf-8?B?M0paQ1VPNlRud2JIaUdlL0Q1YzdLV3hRa2FJSUJxRU1VU1RBZ3VYV0FkS2t5?=
 =?utf-8?B?UCtNVjk5bGlvZXFxNzZZcVlUcWtNVm15d2U5aGxzWGNjaUVTYUI5MWg4OFd1?=
 =?utf-8?B?K1Q2UndpVndYb3BHZXJYNUxMcVcxdHJSQXRvalhoaVpBQ0JaeWtCODRFR09T?=
 =?utf-8?B?bFoxSjVXM2tKS2xQZXB4d21JaEtKMXp2bktCUEt1Qmsva3BvSkdqODRiN0sw?=
 =?utf-8?B?eldBNmN2V0Y5NEJSUGNWZHg0RGt2OUhZS1ZGSU5OKzNKSFhoZ3c2d0o0WDZk?=
 =?utf-8?B?UG1zam1MS05DM002TW5BaFpCYnJXckhNSDdLc1pERTlWTjFtNnBKb1V5Uncr?=
 =?utf-8?B?YVdYSUNpVjk0WmxTYkZxdjVUR01LNEwxNnBobjA4QlYyMXliRkJQcDVxc0hn?=
 =?utf-8?B?QUt4SnpERitkWXR5cC85Q002cWNsTjc3TVBMQ3hyN3ZjRzZBY3FtUEhWaXJw?=
 =?utf-8?B?WUJ0a2luNWYvQ1FWZThiY3NvK2pvN2sreXYvOUNxWU5odUJscXFqZTBkUUov?=
 =?utf-8?B?b2g1b1lsS2E3eU9QZUgrbmNxbzdNT25kSTVrdkx5NzV4dWJJYWs5YzhHMVBs?=
 =?utf-8?B?OEhSSkZIcWIwb20yQWhxNy9uSXVHVFlFZFIrcks4ZmhFZ0FSdHRqUTF4RkNR?=
 =?utf-8?B?NEgrUUgxcWt0aCt5UDdRMGIydEZXSzZlemJQKzZVRUw0VzJnaDBMNmRjZVpT?=
 =?utf-8?B?M3BKOEJvVWdXUzM1ZjZtZGlWRGc0NTNVOUtzeXdlTjRRYlIvMEI5S1dsbkNO?=
 =?utf-8?B?UklESm1LM3BMMHNPYmZrNFlha0h5cFB1eXNxcks5aDhjVmNvdnl2WVdkVW9M?=
 =?utf-8?B?cnM0V1laQ1IyemNweFAxSXFLNmxsSitsU2xyY3Z6UkZUOUxXeDZRYmpJbGdH?=
 =?utf-8?B?U1VPY1AwR3NJT0dTbkxSZlo3dEFKZGMvOG5SSllpQTdDRW1XbFAwNTNSQkNk?=
 =?utf-8?B?U25hS2F1Q0RheDMyNjBvZXYvVVFVVUt2RzllRU9JYkREWVVNWjI1UW5LQjNE?=
 =?utf-8?B?c2xVRitlWSt6ZWdITUYveHMySThQQUpLcEZ6T1FzemRwWHhLd1hWRXhFbEJl?=
 =?utf-8?B?RzF2ekJvbmhuTzFSMFErMzBPeDdHT3dSVHc1aldpT0FhdldVeGtVZnRPVHRI?=
 =?utf-8?B?ZzlnTXNYeUIxdHNoa09qUTNLcURoTlJPWmFnS1VtK1RKZ2ZFMHFlOU5Hd3hV?=
 =?utf-8?B?dTJuaUpqWUpZUm9BU0V6LzlUMGNxbzVJcFJ4ZzVhT1VWV25iUzZGd09ZZ3Zl?=
 =?utf-8?B?cXdKZ05ZR0FoRjcyb0MwMjh2b24rSmlURHBodVNtQzJPWElwWkpnRXFHT09s?=
 =?utf-8?B?c0ZKNE0rWFp2d3BxSVROU29TS1hKcVIvK2lWYTYrbU03c3AvUzdxSFNNVjVC?=
 =?utf-8?B?emVBZDl1OWxzODh5eS9nNlE4WnA3UGF5blRQbUk2UVlNemZCTGRyYmc4OVNS?=
 =?utf-8?B?WXNYOGlIaWNLcExCN1NQNGl4bVU2OUhPNlJaK09scmMwVnlxTW9BeE1XRjF6?=
 =?utf-8?B?YzZXdnhQRks4NE4wKyt4YVdlSVRTRU5aVDlqVVVQZUlDOXBZYUdyRmJnVGE1?=
 =?utf-8?B?TUpCVmZkUG5hTVVWU3dtNjlFMmdGeHZ0U1hQdC9UYlh1ZklHTW00dCtFamY3?=
 =?utf-8?B?Rlk3bm5Ram1IYzRDY3Y2WGJLV0lTZ1BjdVY4RnJodFRTVUtlUktjTzNoMTlL?=
 =?utf-8?Q?v6tY0Hdg0k2DHvXNtFDb+l/eW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6735562-16a9-4885-6278-08dce4820a77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:37:15.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efTxHwRX5+ojsWpdjZrEtXpscXqILLkuzBKvQ3Sr52Lqfwl/kOK6sPIH7FDBPZoz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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



On 10/3/2024 7:36 PM, Alex Deucher wrote:
> Partially revert
> commit 0ca9f757a0e2 ("drm/amd/pm: powerplay: Add `__counted_by` attribute for flexible arrays")
> 
> The count attribute for these arrays does not get set until
> after the arrays are allocated and populated leading to false
> UBSAN warnings.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3662
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 26 ++++++++++----------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 9118fcddbf11..227bf0e84a13 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -60,7 +60,7 @@ struct vi_dpm_level {
>  
>  struct vi_dpm_table {
>  	uint32_t count;
> -	struct vi_dpm_level dpm_level[] __counted_by(count);
> +	struct vi_dpm_level dpm_level[];
>  };
>  
>  #define PCIE_PERF_REQ_REMOVE_REGISTRY   0
> @@ -91,7 +91,7 @@ struct phm_set_power_state_input {
>  
>  struct phm_clock_array {
>  	uint32_t count;
> -	uint32_t values[] __counted_by(count);
> +	uint32_t values[];
>  };
>  
>  struct phm_clock_voltage_dependency_record {
> @@ -123,7 +123,7 @@ struct phm_acpclock_voltage_dependency_record {
>  
>  struct phm_clock_voltage_dependency_table {
>  	uint32_t count;
> -	struct phm_clock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_clock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_phase_shedding_limits_record {
> @@ -140,7 +140,7 @@ struct phm_uvd_clock_voltage_dependency_record {
>  
>  struct phm_uvd_clock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_uvd_clock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_uvd_clock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_acp_clock_voltage_dependency_record {
> @@ -150,7 +150,7 @@ struct phm_acp_clock_voltage_dependency_record {
>  
>  struct phm_acp_clock_voltage_dependency_table {
>  	uint32_t count;
> -	struct phm_acp_clock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_acp_clock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_vce_clock_voltage_dependency_record {
> @@ -161,32 +161,32 @@ struct phm_vce_clock_voltage_dependency_record {
>  
>  struct phm_phase_shedding_limits_table {
>  	uint32_t count;
> -	struct phm_phase_shedding_limits_record  entries[] __counted_by(count);
> +	struct phm_phase_shedding_limits_record  entries[];
>  };
>  
>  struct phm_vceclock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_vceclock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_vceclock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_uvdclock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_uvdclock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_uvdclock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_samuclock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_samuclock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_samuclock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_acpclock_voltage_dependency_table {
>  	uint32_t count;
> -	struct phm_acpclock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_acpclock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_vce_clock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_vce_clock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_vce_clock_voltage_dependency_record entries[];
>  };
>  
>  
> @@ -393,7 +393,7 @@ union phm_cac_leakage_record {
>  
>  struct phm_cac_leakage_table {
>  	uint32_t count;
> -	union phm_cac_leakage_record entries[] __counted_by(count);
> +	union phm_cac_leakage_record entries[];
>  };
>  
>  struct phm_samu_clock_voltage_dependency_record {
> @@ -404,7 +404,7 @@ struct phm_samu_clock_voltage_dependency_record {
>  
>  struct phm_samu_clock_voltage_dependency_table {
>  	uint8_t count;
> -	struct phm_samu_clock_voltage_dependency_record entries[] __counted_by(count);
> +	struct phm_samu_clock_voltage_dependency_record entries[];
>  };
>  
>  struct phm_cac_tdp_table {
