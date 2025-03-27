Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189AC3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 18:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C92F10E932;
	Thu, 27 Mar 2025 18:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stQLLv5I";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8B610E936
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 18:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRYS/mnLE32R5+ql/G4yZIvCoU3IjhkbIgELAaU/l0V93bGfAc4YPE+d4EdUaj+W84gOAliA2tPMuLypDmzEng8/VcZJbcTU3x0xgo2csnGpJWGR3/rnjjATjTP+5uBf7noDRfYRQ1wp6Up4UGiYXSomhuGmIR02E29Qocu7Mwnz8wf44mpeKFm063YO4CQkS3utvj5s2dcFc9z1FNXPozJy9cwfZ3ZRlioAoHQAwqa0BsVF8jxRBsYDMurOBMZlkCOrpNJ8Qk9Af84RI3A84C3nRHy89ckGTCujRXLDtVczMhMdepJ+459YFGElOIoK0gKykyNfAMaXx8WXq1JFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbbFWjllZ7PeT97oaAUHsOhDNLttZbiuoguSbStzG48=;
 b=CcPemqRT7WAuQknh6vP+irkGRYkH3/obSOcoA4CgbyputJEJigVkbBny2m1U+MzIEK0ugwpQLf9ypXF4ppy3MQYo6xfRXCcI/Re5aa7rkfGrMtH9Mbg0qdnuTLzvbIWKqE8Pu6g9x76gSVWjQiSNT+nHBYR+oTHonekKglDieL/rd5GV6bnHRhb/DjfEQgLYeswsW49ef7JhMuIFfM5SDmAXz+NnrYLElwxDvw+sgogO9q/+6L1T1oOeCviUO8Kw/rBoGp4Z7XxMuCmAtjPcxyhIhIiw3VgaXq3eGwJAgKpHyoqvT+W5QSVc3MpQnB1cy9b8KrIFDlqU+8TZV5J79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbbFWjllZ7PeT97oaAUHsOhDNLttZbiuoguSbStzG48=;
 b=stQLLv5InI6g68Wk5AoJgOiPIRlHnIs4sfOB80gqJa9GCRKJ/yG9bWbmKdfd87nzHaYjARkOgweBak1+M3s35LMZwELVOH26rE7ehqiKi+Q69smlHQK0jcwp9XojFt/76xaXHSRhpkr1saYfflB5Xbp/NQwgJhgBXLsXaYQL/cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 18:25:15 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:25:15 +0000
Message-ID: <b5ad8370-b437-4ecf-ae47-223c3963cbc6@amd.com>
Date: Thu, 27 Mar 2025 14:25:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: limit sdma queue reset caps flagging for gfx9
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20250327155339.1756101-1-jonathan.kim@amd.com>
Content-Language: en-CA
From: "Belanger, David" <david.belanger@amd.com>
In-Reply-To: <20250327155339.1756101-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::43) To CH3PR12MB9395.namprd12.prod.outlook.com
 (2603:10b6:610:1ce::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9395:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 90420bce-2dce-472a-5ccb-08dd6d5cb865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjI2UUNMVis0VHRJTnpEWXhEdnQ1amtoYkxCWHh0VnpqTmJzTE9Oc2gwSTdR?=
 =?utf-8?B?SVBIaVlwOVI3aU94WUcycEpLV2FEclV0MFlHeWs4NnYzbTlXN1A1YWZaa3Bk?=
 =?utf-8?B?NXk2S3p5YUZsTk5OTmNhQVNOWGo3Yjh1R2ZjQ3BvM3huRWQxN0lneENjKytC?=
 =?utf-8?B?S1JGZjhoVXpCZlBPWmxtdklOTElHZzVENmJSRjhDMUpTajJSWGovUFZmY21q?=
 =?utf-8?B?MkZtZEFVTjdPK0wwZFRvWi9HVG5Xb2ZCcStmL1dBUktkV1h0c05OTENCbHZY?=
 =?utf-8?B?cGIxMHpWN08yV3BGaXhkQ3NwWnM4SlBVSkFxZC81cnlrbmZNekRqbU9SUGo5?=
 =?utf-8?B?SHZZT3lmV2hOUWpGZGYxVFJkdFhVTk0vSlZQUVpmV0M1U2dJVHBHMHZkdmdD?=
 =?utf-8?B?d2dzU1QrUmZOdW9GZGoyUWNpQVZ2QVFNMWk0cE1uNHNzY0NDcmpBcG16UWhh?=
 =?utf-8?B?NzREaW15WkQxdUFBM2psQjdFMXB1QS91a24rb3FtUS9acU5TeE9Zak9TSklX?=
 =?utf-8?B?cXZNb0FDaElXSjRSencxNmVOL2N5ek5EK3d5QUlnREZvMWx1RmdYYWxmWXFv?=
 =?utf-8?B?bWtRbmNxeWZtc3REVWhwSWFNTkJmaFdtK2Y4bitySklhUzRCbmNuSjkwdFlT?=
 =?utf-8?B?T2pWbGVoMWVMRXpCSlhpcGFmRitON2wxYkVwWUdrNmYyNVR0bUVURFdaQW9R?=
 =?utf-8?B?SGtkb2svZXNXd0ZxVlY3R0VyYitueEg5bGtoL2pKRzRkaUlNTWtURFk1Q1pR?=
 =?utf-8?B?Qkh5c0tGOFdTZE1PaXMvTlFIL090V1NuM2JBTzRkVzVadDdrUVk5NTRKWlUv?=
 =?utf-8?B?UEFUMGZSbUhGcE1GQVFSRE5Ed1N1MkNKVjlCZ1dNam83cXhYamxHOVAyaXVu?=
 =?utf-8?B?U3QzS3MxU3ZvR2g2Q1hpT1QrdXdHbWdSNnZ0NTd0aTdJNUt5dGFGYlFQMHln?=
 =?utf-8?B?UTRENURSOVR5VW9FR0NocGFTNG84cXdnR0lReHN0ZVoreW1mYk9ia2Z3VUJX?=
 =?utf-8?B?TnNOT2lFZi9TZmgrS2k5cXM4aGNqL1U0aVNFRzQ5TnZ4YUoxSWJRelZ0TzUr?=
 =?utf-8?B?VnRLdmkyVFdkcEVNYzNJS0lCdVdJeGlKdTFiTThDdnNBc05LdjhFdnRMVjRJ?=
 =?utf-8?B?K0RPR2JQdlNLZGsyL3Y2dmpTSjdNZVFxMzRBdklDRU5EK3JRT2lDS2lPcmx6?=
 =?utf-8?B?bDc3d3E2bXhoRG16ZnpqUngzeVpJTk9TdVV1OUxGTDQvTmZOUGNEdWszU1pB?=
 =?utf-8?B?SXdGTmRnR09rV1h0d1V3OGJiV1gwelprUjFXbVhLVWovVUs0WnNMblBvUjBO?=
 =?utf-8?B?cXFYWDM4bmNLSzIxeTBnTUMzTVhJQnY3bkF3b0RBdCtuZWxGZUtHTy82dXEy?=
 =?utf-8?B?TnN4M2NEbnJheXlDN2lBU1B4c21rTGsvZkpFZlliU2xRVHByM0pzZVJRUGlp?=
 =?utf-8?B?WmlmNzNZcmg3cm9qYXVyT2Z5N1B4VGlLaW1kem1Na1FhemRRdm0rc1NDZG96?=
 =?utf-8?B?ckRRQTNzY0JtWStkY2dyYzNsOGl3QVhrNFg0WldYWmlnWmNpM2k5VmhNc2Jy?=
 =?utf-8?B?UHc3bnhxaW1mRXI0WEZvUnNVSFhjb2YrWGYzc2dJbnNiS2pMZFdIcDh4U21V?=
 =?utf-8?B?SU1ULzd1bGVJdjNiUGtLeGFST2NTU1M2ZDUwTVlLalVSR3FKOVdqcDd1OUZI?=
 =?utf-8?B?clkrck9rTnpZSjgrTmQxNC9iYWtHT3N2OU81UWEwYWloUHh5bU1SWDZoY25i?=
 =?utf-8?B?RTBvckxHMlE0SWVEbE1TNmJrWW5yUkp6dnh3ZkNVZXBpZTRTb2J2aDM5eVJl?=
 =?utf-8?B?dWtnMFQ4dmFGVitsc3l5R0h1TTV2M0h2RStWUm50QzZoUXY4bkJGRVdaK0Y1?=
 =?utf-8?Q?ITWCDQZfmKJhA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVQaURnSHZabXUzR1N1M1g0VWZ2clZDd2c5ZjFmWEJ4WU0xQnJwZUFZSzVH?=
 =?utf-8?B?cU9zaW9tWmxicHdjQWNHbmFyRjBUZFJ0ajNvbmJicE4wSDJwWnhnZUszajFG?=
 =?utf-8?B?VWo0V08ybXVBcmZYYU83SEdCVTFTTWlEN3Bxb3orMllKZk9Sb0VSNW5JMVZs?=
 =?utf-8?B?VGRrSTRsMC9pZWVnWjNDbFRpZkt0bDFYWkJiQ0x1TGhaQ0NtczNwdnJ1Zm5o?=
 =?utf-8?B?Mi81REpPak5MS1V4c1dmdnVZUmRhN1pLS2ZFYkhUNndLVG1qR3l3TjQ2V1pV?=
 =?utf-8?B?dDUvbXY2dkcvbXpqSHRLR0dWeXZKS3ZUUUYzU3NKQ3RibXVKRFp3dmg2L1I4?=
 =?utf-8?B?clVPTUxRYU9PQjRIM3ZFdlAxYzFGajZPYWVod0NuL3BQSUd0dEVQSksrc0NG?=
 =?utf-8?B?WjF4RWNHaWJtWXFJTHM4K0NITWVKTVJJT2xZd0NvMStwVm4yOTRlT0thY1Rs?=
 =?utf-8?B?a25uUFZBR3VTSFJ1dnVuR1llTVAxN3BZVnBjcWNLR2swN2UwMi90cDFTdE1M?=
 =?utf-8?B?UW9SSEVNb21lYTExKzlsL29QaURHa1ZrYnF4dFBHMDF4emRJamtjS2M0bGxy?=
 =?utf-8?B?anorU05ubWRFS05ZdFJIUU8zQkU3TEN3RUZPaUJiNXU5ejVFQW5RSWJjdExm?=
 =?utf-8?B?Tkt6SC9OVjdCczI2bkl4a1JKNDhmYjFQcFcyNGtkQnNlTytVVm40c0YrcjE4?=
 =?utf-8?B?K1k1MWdnbGk3cDU5SU5qcStNcFlocWxxMndpL2RrUnBnU0hUTjUxbEVJQk8y?=
 =?utf-8?B?Rk5sODBmb0M3NFhEQy9aVXpQUEVhYU9OZDltYmFKNTlZYjZrYmovUVZHRXhS?=
 =?utf-8?B?WkcrUlN3Q2UvQlp4bFdISEYweHhnRm1XQ09xYjFlNmdrQ0pBYk0wZlVPbHlO?=
 =?utf-8?B?VHdsUVhIZ3lyL3dOU3RPZXNmTjFEaHEvNGs1b0hpUnBBVUo3REtZUEs1d3Rv?=
 =?utf-8?B?NkhFYmJZMzcwTXV4Vm5ZSDZLRVZlSTU2RHFUQnI3OGt5RndGUkdGV0tNd0RV?=
 =?utf-8?B?TGRTUGI1Sm9INFQ4SlZuektZUVhZU2VtZW5TU3BuQ0xJK2JpMm5Pc1ZLOVRC?=
 =?utf-8?B?QkhJUFNvb25uUEY0dkJwczFvVGJCVUFreFB5eUwzMnMvc0tBQnIxVWJodlBr?=
 =?utf-8?B?K2Y1VzI2SmdtVytMem9EbzNuQzVBZUpFaThDV3hHY3pxT1ovaXhvSDZiSVNm?=
 =?utf-8?B?WWFBQXVDVWhYVkhERzRPdXlrOGxXQXJRbi94em1VeHc0bGl5Ykg1MXpGT05l?=
 =?utf-8?B?dmlyR0syc01yMGkzcnYwQUttellSZ3lXZ2J0UXdxUEtENlJKNTNObS9jdlVq?=
 =?utf-8?B?S1QzUjcwZS9Nbkc1d3paZEZCaTZJQXRIWnJzKzBMQmdZZlFCRlV1UmpPbWVu?=
 =?utf-8?B?b2hYZ0hUbEVReHpxOGR0NFUzWGdydExJdmttQkFBY0dsYkdzRTFkR0U5aUtx?=
 =?utf-8?B?MDdnQVRERUlFOG80TGo3OHRIYUorLzlFSy9SV1UwMmVKSWVTbEVKZVhjcTdp?=
 =?utf-8?B?dldjaStLOWorc2lZaWtWWlBKc3N2QlJWUDNTUlF4OU9ZQWZsWitybThWYmpj?=
 =?utf-8?B?T3JpSE9PSGRWdU94QXp4NHNCUHRobHovdkg5c3d1ZWZQd0k4U0tZb0F3dmxQ?=
 =?utf-8?B?QUJoZ0ZOcEZCcVZ3ekJseTVyUElyOVVhNkE2dEx4NDZSb0QvMitFS1l6WHlG?=
 =?utf-8?B?bXp2c2FXMHBSZlYvajNaSmdnbVRkZmlKVlJpQXFzVTl6TlNJVnh1aXU3UGNr?=
 =?utf-8?B?bkVFaC82RFptTmE5YUNsMDZTclJCMWJ3NjJ3UEJEeVdlSWhiM1lQVmZvdXVL?=
 =?utf-8?B?QnhoQVNuakJYSDNBSXdkN3BnTGY1TCtaTmI3M0hueVNudXAzVGNkTUVoYWRY?=
 =?utf-8?B?alpSQ1JBWk5YS2VnSWd6RVpkd3h0NytiVU5oeklGOWwrM2JEcThZZWIzWWV5?=
 =?utf-8?B?ZlBORG5ac1lySDMxS1pyUXFXNWRxYXl0Wlp4NlArWHdUaEJMMXpoMGlQQ3JF?=
 =?utf-8?B?OXNtUTZxRytjQzJWZXBqdG9CMDAzcm16S3N5RDhCZjZOS1NTc01iQzc1UHZF?=
 =?utf-8?B?NU5KdjFDcGp4dEdEeWo3SnVMajJlaTV4UGwyaFJaRlRybmJNa1lPT0VxN2tI?=
 =?utf-8?Q?Q771agSO6FITiGW4oH6dYiBSF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90420bce-2dce-472a-5ccb-08dd6d5cb865
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:25:15.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxdyzS61wTEe5qy+PycMeEIYwV7Xdwu8T6FPNpB6IDIjhoZPu6WYW/HFyAdGuPVuOClQYJHydvLu75IpaO988A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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

Reviewed-by: David Belanger <david.belanger@amd.com>

On 3/27/2025 11:53 AM, Jonathan Kim wrote:
> ASICs post GFX 9 are being flagged as SDMA per queue reset supported
> in the KGD but KFD and scheduler FW currently have no support.
> Limit SDMA queue reset capabilities to GFX 9.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index e477d7509646..993eef5a4983 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1983,9 +1983,6 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>  	if (kfd_dbg_has_ttmps_always_setup(dev->gpu))
>  		dev->node_props.debug_prop |= HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
>  
> -	if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> -		dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
> -
>  	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
>  		if (KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 3) ||
>  		    KFD_GC_VERSION(dev->gpu) == IP_VERSION(9, 4, 4))
> @@ -2002,6 +1999,9 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
>  				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
>  
>  		dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
> +
> +		if (dev->gpu->adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> +			dev->node_props.capability2 |= HSA_CAP2_PER_SDMA_QUEUE_RESET_SUPPORTED;
>  	} else {
>  		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
>  					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;

