Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB909C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 13:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947D410E6D7;
	Fri, 16 Aug 2024 13:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cVgNh7Jw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7D410E6D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 13:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1WFs+myQmrRJBuueOZMchbbZHQGv0qYm7ATq/mMiOdG+xFViesPcxcQ8vcJHHGW75+52pzD3D472z/J2dX3ZOCJ78CDHt7rSUfHtu4pyMULscQaiteuq6TY/y4e5RcF2Zrlj/S3fpbuMexvXNscQNAIvgwd//WZWMDGeLPANBu16QRM30g1pXInSnAmbYb4rD5ar++2nnYQc0h4YmaOMGz4Gm2sNxmmdUNwVbA38b0B1puSJ4fsk+F7KWlRgpJqtxbk43G4JjLQ2PKmhjy5LVO8dzhc5Jv65T8ykATSW0Ze2/j9I70yXuzyD23dgFWh6bwLjg51bSw/sKK2AbLx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pEPk4WLE/I4NWvo9nP2SE/m52LVLdj05xNDfmRm3Gs=;
 b=MehUNCy3AYNUHtMvJrxYB7Vf0X4FmEmHRDiG+d2gpNV4lGazn7K1RVPNxuj/VjR/0/KkQqvmLYQqeEKjAzqLOl077ioGokJIjIk1XzQqee4umODA2Ytql39uYll/ixIG0C2cxGVeDPpNKnmrPt/1d8RLUzLWRWNnW7ZnenZnlE3//viyRFPZQs0zsE7I3lZre8kay9kOZhQ7J/Hqok6S+Ovk+oqylpbrOmcPmanlGbo5VVWOpi4AmXI04q2VTsxdtGkJGMIDcOIsz2ZbNVeIScZHVWnqqP/mk3af3EurbkaHbRMO+XaamrgTkQl9UqwPS1XO0+8Rnl7i5imxlPY+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pEPk4WLE/I4NWvo9nP2SE/m52LVLdj05xNDfmRm3Gs=;
 b=cVgNh7JwOBodZWSHehzlMJcIS5RzThIj+zlOEHyAqPYlrDXvdEMtwLXePniRscFnsjP/vQ+SLf58MoYQsfa/k8T0Mfl4EbUMOUKvFQs7eEh+b0rvQe3nYSBuvGQ8QrK58+yMveiSRQe3ZgjZIRip1RVK76gwQLofWDuf5GtXRW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:26:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 13:26:08 +0000
Message-ID: <8fd2282f-e985-4847-b9e3-2ecb36fa3988@amd.com>
Date: Fri, 16 Aug 2024 09:26:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
To: Rahul Jain <Rahul.Jain@amd.com>, ramesh.errabolu@amd.com,
 alexdeucher@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240816072951.87089-1-Rahul.Jain@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240816072951.87089-1-Rahul.Jain@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0161.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: dffac94c-ca55-4934-446a-08dcbdf6fcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUxJeFFZOGJVUk9uUFlHWXBFdytkZXF2cnMxTzJBYy9aNVlrWGkxdURIUktk?=
 =?utf-8?B?Tzc5a09XUDJhaEFsNmhZQnkrZkgybXBpRWVVaHBTeEczMlladjZ0ZHZ6YUNm?=
 =?utf-8?B?bVllcXcrT0d3SlZVWUdUSlB2dHRObkJOdE03M3MrRnVPVWFVRm43ZnRNak1U?=
 =?utf-8?B?cnI5YkE0K1A4QkZ0bVlYclF0SDNZUHIrRjZyUmhpZ3FYVWFKZ3ZQTSs2VDlM?=
 =?utf-8?B?cm5ibU1tZ3ZSN3JEd05tTzV5TGdKSVBPalJqYTdNa2J5dGFZeW1ZTldUWllk?=
 =?utf-8?B?aDdjK2wyd3ltUXkvT2xOeUpzeEJBSUlrUE1nZENiRXRxVzhmTTVhbEszem5j?=
 =?utf-8?B?Sm5wbWt5OGRVYjMvZmpEOXJFVkVkUnJhT1oxaktxek1MOVRsV2xXbzFzU3Nv?=
 =?utf-8?B?SVFDd2hOY3FyZWY5MnlOV2VXUm1iOVJhcW4vZDhJbUtNa2lGZnVDQzNDWFZo?=
 =?utf-8?B?WWxERFN2dWhJVitLSVpyN21pNTVNSnlGaE5OVUE3RHpZeXJPS2VvQ01xV0Ev?=
 =?utf-8?B?NVh0dmRnVk1JWCtWMXFMY1BQb3RETTAwc1pWZEVVdnNsNWRzTWx2bXkxVG9P?=
 =?utf-8?B?bGZHV0IxL2llL0JtdjFxQWhzWjlJUURITzBta0VGZVNpbDAxQTFjTEw4Q09D?=
 =?utf-8?B?ZXFZSW5YSkdad2FIcng3dmwxZ2tpQUJQYVhEWHVYTnk5WllHVGl6REtjS3Y1?=
 =?utf-8?B?aEdYb1gyeVJJOW40bEEyZzJ5MFhGN3Q1ME9jRVc1Z2E5WE4xeEFPSXdwVmZN?=
 =?utf-8?B?dVFuQUN4aGx5enZkME1CdXpDaGo1OXFtMFhNaFRvbnRkOHBub1ZSZmV4UjdC?=
 =?utf-8?B?cFp5cG9BZURVNXMxUWpZMU9Oc0hBUTZaY280dFQrK2J4T2oycGkyZXMySUt0?=
 =?utf-8?B?Y1JGN3lvYlB6clRWSU52UEJMVVVZNEJwZlhaOC9ZTyttUjN0ejVxNTRDejF0?=
 =?utf-8?B?bzgwZlJiSUtidWoyU3gycE9zMVQxUTZza1VqdXRFR0w4WWtIc0c5QU9FZnJa?=
 =?utf-8?B?amk1L1pkN21IMmFiTDZFUmp5YldTUklsVVhiRW83SnpldFNCbFV1OTVtVThr?=
 =?utf-8?B?SVdmMjFMSnhSazlPZnYvTWowZGJKMzZWb1Z5dVVHUlBPVTJIM2p5ZldFZ2Fq?=
 =?utf-8?B?NmI4OWNLN256UWpsblV1NGFUelFKRmtlUU03UjBob2g0KyszTXRhRnBVbUNI?=
 =?utf-8?B?WmtpWGJWTTZsMUlBN29LcTVyK1NNVXpoTFF6NW1UZkpvSkRtOG5QYzFBQ0Z5?=
 =?utf-8?B?SkRhajJHWlRWNENodE9IQUNJOVFRV2VHd2M3YTFOZDYvZEY3TDM5bnBLbXhz?=
 =?utf-8?B?WFJQZ2pqR1ZDSGF2ajdGWmVWczlScTJxNndtaVdyajBsVTc3SXRlY0JiMmVh?=
 =?utf-8?B?OHl1ZkVvR243YlNIYjdQbHZIbXFUZDJlRStxa21Hd2hqd2J3RnV4MEVWdkZQ?=
 =?utf-8?B?SVJMV0FsWkhFSmNxdG1MNjE0NW0xMlA2NURRcGw4MDVUUlN4TnBjRHZYN0VZ?=
 =?utf-8?B?d291YWNMNlhzL09MT1BSN0hZdFFGNisvNHMyamNKWWNZeWtxUERRa05sU0hQ?=
 =?utf-8?B?OXQ2VGpqSSsycDJBNVd0aWJ2TFpkbjZlSXQ0S3psd3JWa0F3bWgvTndaTkt5?=
 =?utf-8?B?VUI2aEJvSCtFdHZ5NkZPemhSZmFheTE4NXBGMEhmbGsyMUYrdjRJNCtMRUhR?=
 =?utf-8?B?NlhLYzQ0TDgzcWora211NmlHYzJrVmpMbHNweVFRWGtaWFlFem92dFlZSDky?=
 =?utf-8?B?cjVOcVhtSUlIR3h6ZmFKaDdINXlPZnJPZkFMMXJ2N3VVMWh3dkhhc2JBaGla?=
 =?utf-8?B?a1dGdjNaellXMzBNSzNlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUMzT2JqcU03Zy9WdWp5UThnV0JBVkl5NWo4SjZCcnpCMDhKeTErSkFwbE5a?=
 =?utf-8?B?aklpQjQ4N21wK0tpSytMMnZhcXFCT1NrVWlMQ2NlS2Y0Z1NyM2xrWnluQjFR?=
 =?utf-8?B?TU8yUW01L0Q2RTI3dW1CcGNsOGpXRW4vY2YzdG5FTzgyZ2xFSkxkTFExVDNz?=
 =?utf-8?B?ZitzcGtLS1Mzd2k3eFhoTmxHeWVRSDZjSXJTbnpvQ0NEelgzUHBJL1VRMk1H?=
 =?utf-8?B?eE5BV2tNK0JLN21HU0hLcXpkV01kSXhKZEtMZ2xwMXlybzUyNG4xbHNPUkd2?=
 =?utf-8?B?VnFmOG5wNTlNaG5TblVRaEFmOW5hd1ZlRi8zcjJKN2FJa1d1bGJ4bzhqQ1VG?=
 =?utf-8?B?M0p5VG4rRHpvb3ZpOXdtcEJyT0FLZWJIdXNmQ2Z3WWZIQmt0K2ZNTHQwWGhq?=
 =?utf-8?B?WEN4ZjRMb0Q1ZlBHU0tOREtMZU51NVNvTkZGRmtSeG1sS044THF4NG5lMlVh?=
 =?utf-8?B?SEdHMGFUZlZ6Z09Rb1F0c3FZREVHSVY2MmlGYmlaUmhOR2FmSTN6RUtvdmVI?=
 =?utf-8?B?NkRPaEFKS0haeXlNajVuT3JLRzdVeGQwZklQM2RXampIbmpVbS8yRFEzUE5r?=
 =?utf-8?B?ZTBNS1dNUFR2RDI0NjJkTW1nMFNMYjEreVNyVG9YZ2F4VGorRUJscDNTclhv?=
 =?utf-8?B?OE9UNlh2dWVwdFFvQmJQU3dZcEJ5UXozWWpuMmhHOGdxd2pvN3g1b2RsV1Bt?=
 =?utf-8?B?OG1Xa1pJUzZ1L1hrYzJXNU9aZkYxaWg1V1IvakNZZklMUGJxU3B0VGFiQzhy?=
 =?utf-8?B?K0t4cGg3ekErRXdDeDk3eklmT3lmVTB5MnZMK3VsNWpXK2JMcXRBeE1sTkhm?=
 =?utf-8?B?WFVWdStkVUk3dmZ6UzJGQmJGblVmS1c5TXBPT2gxeGxXNnZuVktWWVBtTnZV?=
 =?utf-8?B?QmxwU3pxWnI5S0xlWnRxblcrVFVtZUpBSHJyT0hFT2JPNkF6azJoOXZoNjlZ?=
 =?utf-8?B?N2ZMVzhESFpLWXdQd2NxaWY3Zk00dVl5U1BVckZRY0ZTNnFlVnpqbUJjVUpN?=
 =?utf-8?B?M3VjMTdxdDh3SVlqWEhjNzg0RG02S3J1Y05wSEYvWVk1Mk9QYlVLeUlnYWpE?=
 =?utf-8?B?YVVwcHdPYTE3ME1zZnU5LzZJaEQ3QjRXMWEwVUdTdm1JaWExN08zSGRGQUdx?=
 =?utf-8?B?SW4waThUUTdYd3NKRlF1RUFOVlNYUWphb0dyN2dPa3lreFd3WDhiYnp2WVdo?=
 =?utf-8?B?dHNGT0ZtY1ZWbTJ2VzZaUGs2Tk9qRzYxS2sxRFhEUDFad1JnUU1NcGFuSVVQ?=
 =?utf-8?B?aUx3WHYrNS9OZ3U3cVNNMGw2cmg2WXV4b0tTaGFXTGh3Nk1tQ2xNMjJaSVRL?=
 =?utf-8?B?RU01TkJmNjFKK0FEQTFNVmpMV25mTDhLMnR2WE9waDhRK254ZTFIUmg4UzBN?=
 =?utf-8?B?NDBBQ3ltRnRhWTBHM2NQWWhrRWtDNzkxOXM3N1BiU09hbzUxNy9KY0xiZmZh?=
 =?utf-8?B?c1RuenRLeEFhQnVaTEp1ZXVUdDlNK1NwQjZTUE00T2E4a2hqZytnZHMrMEly?=
 =?utf-8?B?d0RUcjhadDRkc2liakRPVndlRWcvWnIxMWdtOTdiZlBoMWxaWGlsekxjNmRk?=
 =?utf-8?B?eVltdllNMnFTQXVDN1RTQlhqVDR0cmwzVjRKSC9mNGppNGhkRUNNYkhwalR0?=
 =?utf-8?B?a2did1JCb2F0bHVPTUNZRjR3aDVhVVBCOFJncmN6VXNaV0ZGWkNxaEU3MmJF?=
 =?utf-8?B?bHNoQklDMVE3aHdEU0J4dFRXd0ZpeWdWU0JKVUQxSTU0YnE4ZmlLVjNDR2FR?=
 =?utf-8?B?QVlTMjU2VFBHdS9jSk54UkNnUG12QVgrWXdhSWtTS3hkRXEwMGdsMFdiL3FR?=
 =?utf-8?B?R2gwcGE0d0k3Njl5S1pVdkU1WjlHN3I2bkV6TnllWURnY2NMN0l2dGwrRG1Y?=
 =?utf-8?B?V0RHSUpDYVFYVEZSbndUa0RKenNiOGluWGFMWi9aT1ArT3VRQUZPcVVoSHhQ?=
 =?utf-8?B?ZHg4WWpTL29GRzZWK1RXU29sS0c1WVdIaWVoVUZaY3ZmTWZBaHg5N29SaG9t?=
 =?utf-8?B?K2tIUC9yL2ZCN1NPOGxsTnM1eWphdTAwd24rQjRsM3ljcUt4MUcydUJ1Qnkz?=
 =?utf-8?B?OTdsTnNXTkpqaFBDaTJYTE40QVlUTTFZUVA1OUdtYXVQL293SWNIZzdIQTU2?=
 =?utf-8?Q?UCPDtAFR8oLlYkGVoB2TyahJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffac94c-ca55-4934-446a-08dcbdf6fcaa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:26:08.0373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8jqKnfLpu1OcytMz1+B9PbtnJwsXlFw8xRFsYI3eCpjLl4hoAO5SB34rz101+XMJYAVQ0EzeYpJidImJM2PeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739
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


On 2024-08-16 3:29, Rahul Jain wrote:
> when trying to enable p2p the amdgpu_device_is_peer_accessible()
> checks the condition where address_mask overlaps the aper_base
> and hence returns 0, due to which the p2p disables for this platform
> 
> IOMMU should remap the BAR addresses so the device can access
> them. Hence check if peer_adev is remapping DMA
> 
> v5: (Felix, Alex)
> - fixing comment as per Alex feedback
> - refactor code as per Felix
> 
> v4: (Alex)
> - fix the comment and description
> 
> v3:
> - remove iommu_remap variable
> 
> v2: (Alex)
> - Fix as per review comments
> - add new function amdgpu_device_check_iommu_remap to check if iommu
>   remap
> 
> Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++++++++-----
>  1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a6b8d0ba4758..e03b3357ae09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3952,6 +3952,25 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>  		adev->ram_is_direct_mapped = true;
>  }
>  
> +/**
> + * amdgpu_device_check_iommu_remap - Check if DMA remapping is enabled.
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * return if IOMMU remapping bar address
> + */
> +static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
> +{
> +	struct iommu_domain *domain;
> +
> +	domain = iommu_get_domain_for_dev(adev->dev);
> +	if (domain && (domain->type == IOMMU_DOMAIN_DMA ||
> +		domain->type ==	IOMMU_DOMAIN_DMA_FQ))
> +		return true;
> +
> +	return false;
> +}
> +
>  static const struct attribute *amdgpu_dev_attributes[] = {
>  	&dev_attr_pcie_replay_count.attr,
>  	NULL
> @@ -6127,21 +6146,26 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev)
>  {
>  #ifdef CONFIG_HSA_AMD_P2P
> -	uint64_t address_mask = peer_adev->dev->dma_mask ?
> -		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> -	resource_size_t aper_limit =
> -		adev->gmc.aper_base + adev->gmc.aper_size - 1;
>  	bool p2p_access =
>  		!adev->gmc.xgmi.connected_to_cpu &&
>  		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
>  
> -	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
> -		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> -		!(adev->gmc.aper_base & address_mask ||
> -		  aper_limit & address_mask));
> -#else
> -	return false;
> +	bool is_large_bar = adev->gmc.visible_vram_size &&
> +		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
> +	bool p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
> +
> +	if (!p2p_addressable) {
> +		uint64_t address_mask = peer_adev->dev->dma_mask ?
> +			~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> +		resource_size_t aper_limit =
> +			adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +
> +		p2p_addressable = !(adev->gmc.aper_base & address_mask ||
> +				     aper_limit & address_mask);
> +	}
> +	return is_large_bar && p2p_access && p2p_addressable;
>  #endif
> +	return false;

You changed the #else into a #endif. Logically that's OK, but it may cause a compiler warning about unreachable code because the program can never reach the "return false;" statement when CONFIG_HSA_AMD_P2P is enabled. It's probably safer to leave the #else to make sure this compiles without warnings on current and future compilers.

With that fixed, this patch is
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

>  }
>  
>  int amdgpu_device_baco_enter(struct drm_device *dev)
