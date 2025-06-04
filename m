Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25B0C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 06:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DAB10E71F;
	Wed,  4 Jun 2025 06:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ys6OEqIZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7706910E6CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 06:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zW2yuraioFHZtLvzfBYPKvABgwucD5Wnse2OOgP6IdyWZEjfPS+o/IO24r0v6otJp5kjfCT0SYQH1Sl2nS2udT7qGpE3SQVawedUAfaB1mZwqSPdPTn6QtBnNYD70lRvDLqnvNeE3aykqmrHTlWiAMAjy3cGWF8xck77kQZuz3q5yriu/wEXVTo7+rhwZdgoISaW3miqfS31ShbbM9r0Qvb9tRFjVKFrbmTWqTLyK/kJvNXMa2JX9ZLAluTEAui0JvhVkyPsqYQ+Q00ZTESx0T4/UMNPs+gbylany2v8aQroef9KBAOf7MDmMHJJwRvT7F1TngC24PAh/2I+gHD4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gofX689UNfTq7b0mHglVU+/kJX+k5zVGGFFgB2B9t2Y=;
 b=nqZ8r5VKmR/AQk46oZ6ikUf/W5Sgn4g3Ij1yqBBgijIZBdeniKTS6avYZVy0nceDEPkdOMMXaUQyB3vwp3AM/aRyRL3O9S+IGgEkv1gW8QBG1jw0eT7J+uSUOaXtc9VUJ5zI0O8eWPMUb2uMn4qSKM8qEqIaHVlQJ37WDlYl2cBPjJML/2vs4+5IFs5Y3bXbwQ94yUTIWFIb8xwADsrUh+DVqpPJTq+DchBJOxXjf5312qZRWzMyyhPM2zjWGNzzl8x0gvcEw/cROX0fn4VQIKmbYOiWGwaJjB0YjeNHX+cg7eIso/eobxfX9VrgzeoRpkgp4cUmVoAuCaKBhqv13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gofX689UNfTq7b0mHglVU+/kJX+k5zVGGFFgB2B9t2Y=;
 b=Ys6OEqIZUk7FbJiMAWFIKfJU7hzIq1X7VbA2peMLVxWGK1CE8in6GfSUXE67JXucHMhNtU/UQMLHmaUwl97tKsP9XHSLbjLiMeCMP7/6mEG6MsPpn8D3RUFERpRBe11hr/kxJd1oXjfR/Le7TPhXr7COBjg4/wd9+TbCpnQ7y34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 06:54:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 06:54:26 +0000
Message-ID: <6eab1714-ffef-41d4-a349-a2ac1e313044@amd.com>
Date: Wed, 4 Jun 2025 12:24:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Move the process suspend and resume out of
 full access
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250527104943.3020168-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250527104943.3020168-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: b9062180-9917-423d-331f-08dda334a4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1A1MGpXdHBWT0pncmtQQldKWlpDaEJZTkhOS1E2a0J5SlZ0dEgwbUtxcytz?=
 =?utf-8?B?NnpHTGV2ZGF5U3Z5Rmt6Umd5dFBUbGRNNWhVL2FnTWM0Q1hsVTdQcDg5SjNK?=
 =?utf-8?B?MUFhT0xha2ZiZ2JXc0xuSXFzRGRZMTQvVytMMVRWRWJMeHJ1NlNOTHg1WWJU?=
 =?utf-8?B?V1JHalBNWWlra2ZKTnByUlhrOStIVEFvcHpramNoeFdPNVVDYVNCVGZSVlow?=
 =?utf-8?B?dHBueVdXS0JPdFNrS2hFOEJ6dXRJaWVBVkVlcVpXM0FtRGhxRjB2dFRBNWlv?=
 =?utf-8?B?cXFwWno3WjFTRXB0U0cxdk9WOEJvOER0QUNkN29nQmV2c0YrUCtUZGoydDJR?=
 =?utf-8?B?Z1FMWWxhMmhTaGl3d1d2K0Eva09ZQzNIT0J3TDJCUGNtMGdDRHJqUkE5d01N?=
 =?utf-8?B?Y0k3NzVpZVlEamdLU0F3NDJnM0V1WXJuZVJzRlNwYUk4V2Zad0NHbWxkVWlX?=
 =?utf-8?B?TnZwV0lwYmd6WExPRGZaT2NpMDZkbFZ2M1pYeTlEcG1XUFF6ZHVGNDFZd3BY?=
 =?utf-8?B?OWlBbDV6NGpCTVdsV3phcERJTFZkZDcvbyt1anB5OU5IaXRCdTdUMXFnczh2?=
 =?utf-8?B?UFc4NVVtb2M5dzNNa2JEQ2NzZEtBaXB6T0plOTRSYThIMWJnRHJiZlRjRFZ1?=
 =?utf-8?B?TzhZWExsS1dMVTJtWDA5K0NmS2hSam1rQjdqNTRCOVVrb3d3Sm1VNjFqR2JS?=
 =?utf-8?B?SFpxT2VzOHdXaitXSG9ZNlVpWTFFRjdwOE12RGVMUXhPV1NCWDEwODFDMkt3?=
 =?utf-8?B?bWk1U09jMDYxTE5hMHRmTGdydnMwZlljcjNXc25TcmhOS2k2RDBsTkV3SXZS?=
 =?utf-8?B?ZGN3NGdkWHJsRDBrOU5FYTVaUkc4M0NSRnJRR3BwLzdqMnB4b1U3cXlma216?=
 =?utf-8?B?M1NzRHMrSUExTncyTFpKT0h5cSsvb1ZZQTdaVEVzak1ISnp6TGdEVmNIZnVS?=
 =?utf-8?B?ejhyUGlyczByNHRidGhtTHk2MlFtM3k5S0dUcWVURFdQM2EvcjZLWnNPczhP?=
 =?utf-8?B?SkFpMTlBNVA4ZVlGcXEwNHA0cU1MZGR0dzcrWDlwNGc2SWNNaHlWMXdOa29E?=
 =?utf-8?B?RWdMQzFCNU90dE4raFFsZUNXUGUrZnhPR0N4REUyUFdQbWViQU5oM25EdnVu?=
 =?utf-8?B?d2l4V3p6cVE0ZDhXTTZXRnZQdUpNRWY4djB1eDFEbVdrV2t3T3pzNHgxVnVy?=
 =?utf-8?B?VGpITzZKaktDRzBsT2w1b0VMaC9uVUl4Y3JyZ2M3OWVPdW9nUmt1SERHZVEr?=
 =?utf-8?B?RkJmcElqVlFxQ3IrUmxoakd0d1VVUDh2bHZldEltQmhDZ3BEelNBc2tZZWhL?=
 =?utf-8?B?UFBtbXZWZTFRTkFRaGVtSDZLUUsrK09tK2xncVNnNzNtcEg5bC9XdWF3Wkda?=
 =?utf-8?B?c3RIM25LSFp5N21SdHNpVDR5Q1hxaktKakpYbm9DQ1hGM3NQM3ZzR0RPWER6?=
 =?utf-8?B?R0p0bWZjYVZSNldVVmFWUndweStkNGZIODhhQXdJSGd6M2o5OGJTR1E1akd4?=
 =?utf-8?B?dUoxWncyZlFTcEVkMGRPUnhuWlBiWGk3RGlWV0UrQ3huRFhBSXdML25FZ1Ez?=
 =?utf-8?B?Q0ZicmVnUnNkRlVOSDdYeU81L0ZaV296NFcra1QyRmxuK21MdzRYSGdvdGsv?=
 =?utf-8?B?N21BUUt6ZzE2TVdCUklyNXVsU2pOVGUxNkt0aXdUbFp4SVpHOUU3ZHBtZlhL?=
 =?utf-8?B?UUgwR2E4MUV0Sm1PTmdjRUw1VmxNUC9sVjdzbnZKZkg0MHpOT3JCbGJ4dnRy?=
 =?utf-8?B?NVUwYjBsQzFLdnp4K3dRUGF2UGNHK3ZDYTBDVThUaTU4dlRFcnRGQkFwMnU3?=
 =?utf-8?B?WDdubDdtWWJSMm1ZeWhjZ1ZIeFYwYUhpVDZvY3ZVSFVoSlV0NkN5ZTkwdEtR?=
 =?utf-8?B?Rk9HOWJ5S1FlQU1oYmlKMkNZSlNxS0NYK05KVHNEWlZUbnRIZGg3b1RnRnV6?=
 =?utf-8?Q?DZ45hdcmUWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1ByeGIwR3o0TVlMSng0MHY2Q3ExcFp0aGUzeW5PWEUxZldVeU9RTktHblll?=
 =?utf-8?B?SDdlbklvekI4R21PZk1aWVk3TVpyRXUvcGhRaS8xM2VzSWhiZDhwNmxoT1VV?=
 =?utf-8?B?MkJndVc1eU00b1Z6aWNRWXNlRXVEbTQwZlRQalloU3AyK0hQTlRTRmVTdUJu?=
 =?utf-8?B?YStGYk9PYUNDaWFqTVh4cXVLdVdSaVVPRjBqTDNGamZpREEzWWJSeGpCV2Fy?=
 =?utf-8?B?dGxhSFBlbFZaSzNYWUpheHozWUY1QytJS2l2MVc3ZWVHNmN6SnhqMTZudm5N?=
 =?utf-8?B?M251djFZcUdEb2NLY0w0NTUvcE01amlXSC9OSDRiYVA5d1ZwM2FVYVpOYmYv?=
 =?utf-8?B?ZHNTN3REaEdxUUwyVzhZTkRSWnhJd0l0a2t0U09VczZiZ01IUGxJK05WWWVo?=
 =?utf-8?B?MS9EbE9kQjVFZkd5MkJWdDRRMnVadXlUdjJJdmo1MzduNmF1OUJwS0ZOdVUx?=
 =?utf-8?B?L2lGbjg3M0RmNGd1L2RPcHB2eFUrb2ZxeE9JMmpQd3Z1c2J0VytHUTR2dGVS?=
 =?utf-8?B?RlNpSmcxb2ZVdTBCcm5HTm1TRDEreTJPUkFCZGtPT1ZnaC96TWJJRGRFMjlE?=
 =?utf-8?B?UGJlYzVXVk1aSGlYeERDdmdQRE1PNUtYcDZjdTBlMHRnSUNNV1RIYURNb0hV?=
 =?utf-8?B?cmppOW5BbGhnZU81SVFVR1JGN1BLVEtQZWtKbnZiWCtjdFN0QXAzVERLVjhx?=
 =?utf-8?B?dTN5QWRZSXVUcFBKa1E0Y3B6ekVSMHh3Tm9NbEJWWkxyWkpmWUxGcGYzNUEr?=
 =?utf-8?B?TFR5RGUrR3VBQy9aaHQvVHZSdVFoYWY0WkFYOGUwSUpvZWtTQXBNN2Q3b2xq?=
 =?utf-8?B?eUpLZHZnb1BtZzRFQ0JBYXhRREJRTXZ3MEVkeFgzbmd3aGtoYy9vQWhlblk5?=
 =?utf-8?B?aVZaQWRFcWdLcEg5VWFVOWp0ZDRBb1lrMUdpOGtVNmczeUIvV2pZWjNwdU8x?=
 =?utf-8?B?dnl2SzhTMkpqTktLVkRTYWpod1VSandHVlNkT3k1bzRNWUd3THo1UnlOU1RI?=
 =?utf-8?B?c2pFWEtxd1hvWHNCMVhHaHFTN0RXbnRsMmMzcExPYnVNblF6S0E3YUl5TDZN?=
 =?utf-8?B?MXhNc0F5NFcrT1pHRlkwL0ltQVREclBWbVdaUW9QYnByZWZoQy9XdXhjSG9W?=
 =?utf-8?B?MWJvd24yRmUvRWlsUXZoNk1zY2daWmlBYTZmbGlMSjhKbTlyNzNRZ2VDQkdT?=
 =?utf-8?B?Sm9sbnBwWHVVdUxHSldhbkt6cmxkS0xOVmVnN0l1NUpLcEVidUNtU2tMcmVC?=
 =?utf-8?B?d1BGZWRjU3IzeUVNK2ptNG1nOENaSG96U0tydlVSbmtSaUtTOXNteFNmeGlp?=
 =?utf-8?B?a3ZLYjlaaFN6THJpWEREYWllRkRKekF5aE9lZjI1cDdlTEdERENFZnozeDcy?=
 =?utf-8?B?Z2JwMmN2YTJyNTVmL2xMZ0VxQ3U1VUtvUGxYMFpDOUhod1FGU0g2dXpoMGY4?=
 =?utf-8?B?OGdtU25EdGNIMm5zZmFSMC9LSUtMaUJ3azhGSEhJUGFQUXlkVXpxcjN5RE5n?=
 =?utf-8?B?RkNOWHR0a0ptRHVGOEFpSWo3RUVsblUyeVczaTdnbTBaTWdmWi9CUW9NZ1Av?=
 =?utf-8?B?cE5wUHUveUwrTFV3N2pBNnp0M2R3ak5pT2kza3lTdnhJWDdWQW82YnFVdmV6?=
 =?utf-8?B?d0NaU2JYbDBocG0wZVZHOTNEclhwbmV3dDAyWERicWV4aFRKY0krejZmRUFS?=
 =?utf-8?B?MVEra1o3cG1MOVhLTkNhcmZMcWRKQ3pGenptWDVOV0FIWlZEdVdWWGRXdUs3?=
 =?utf-8?B?ek9mUSswc0pNT1VmSnJYQnl2VU9kYnUrM09EeWFRMmQ5SXVsWHF2bStUempw?=
 =?utf-8?B?VWduaEpONVZvZVYvb01ibFV4TXoyRXFVSlRwUStYYmRvRVg4T25GZkN6RnBq?=
 =?utf-8?B?RXVQZE9MRkRWcjZXUzBDdjl0WXlKTDhvWkQ1cFEzWjFrQnVWcmdlbzByUldn?=
 =?utf-8?B?Y2t6RTd3amY2TlNucnU5eWtiZmhPYU5XU2JLNW1zRFpTb2RodkhHa21qQzgw?=
 =?utf-8?B?RXZCNUFWR1ZObmQvUG9iOEwrWUg0MFVNVktobHN3c05DcENkc0JZbE00d0lE?=
 =?utf-8?B?Q0dxMHYvVnNicjBtencvck5qUElFNjE3ZFA5QUtVcmhTOUFJQkpmWFFqYlRW?=
 =?utf-8?Q?wnR8ioyA76ZPUcMXoAntx2nAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9062180-9917-423d-331f-08dda334a4e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 06:54:25.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR7e6bmZPivHLArRcETZRvx0xVTAmYR/oh/e/u3Ub8M9jOaB9PaPCqNjhBS+vLLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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



On 5/27/2025 4:19 PM, Emily Deng wrote:
> For the suspend and resume process, exclusive access is not required.
> Therefore, it can be moved out of the full access section to reduce the
> duration of exclusive access.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>  4 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 4cec3a873995..ba07e9c6619d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>  	return r;
>  }
>  
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm)
> +{
> +	if (adev->kfd.dev)
> +		kgd2kfd_suspend_process(adev->kfd.dev, run_pm);
> +}
> +
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm)
> +{
> +	int r = 0;
> +
> +	if (adev->kfd.dev)
> +		r = kgd2kfd_resume_process(adev->kfd.dev, run_pm);
> +
> +	return r;
> +}
> +
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>  			    struct amdgpu_reset_context *reset_context)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b6ca41859b53..841ae8b75ab1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>  
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm);
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm);
>  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  			const void *ih_ring_entry);
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> @@ -413,6 +415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> +void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm);
> +int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  		      struct amdgpu_reset_context *reset_context);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
> @@ -463,6 +467,15 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  	return 0;
>  }
>  
> +static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +}
> +
> +static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	return 0;
> +}
> +
>  static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  				    struct amdgpu_reset_context *reset_context)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 625c416c7d45..6e29f8bd54bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5080,7 +5080,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	amdgpu_device_ip_suspend_phase1(adev);
>  
>  	if (!adev->in_s0ix) {
> -		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> +		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
>  		amdgpu_userq_suspend(adev);
>  	}
>  
> @@ -5097,6 +5097,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	if (amdgpu_sriov_vf(adev))
>  		amdgpu_virt_release_full_gpu(adev, false);
>  
> +	if (!adev->in_s0ix)
> +		amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
> +
>  	r = amdgpu_dpm_notify_rlc_state(adev, false);
>  	if (r)
>  		return r;
> @@ -5178,7 +5181,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	}
>  
>  	if (!adev->in_s0ix) {
> -		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
> +		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_runtime(adev) || adev->in_runpm);
>  		if (r)
>  			goto exit;
>  
> @@ -5199,6 +5202,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  		amdgpu_virt_release_full_gpu(adev, true);
>  	}
>  
> +	if (!adev->in_s0ix) {
> +		r = amdgpu_amdkfd_resume_process(adev, adev->in_runpm);

Generic logic is to suspend all processes which should also result in
stopping any submissions to hardware before proceeding with hardware
uninit. How is this different for a VF? Is there a different mechanism
done for a gracious suspend/hardware access prevention? Or, does that
result in abrupt errors in processes?

That aside, the refactor causes the call to be made twice on bare metal.

Thanks,
Lijo

> +		if (r)
> +			goto exit;
> +	}
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bf0854bd5555..22c6ef7c42b6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  	if (!kfd->init_complete)
>  		return;
>  
> -	/* for runtime suspend, skip locking kfd */
> -	if (!run_pm) {
> -		mutex_lock(&kfd_processes_mutex);
> -		/* For first KFD device suspend all the KFD processes */
> -		if (++kfd_locked == 1)
> -			kfd_suspend_all_processes();
> -		mutex_unlock(&kfd_processes_mutex);
> -	}
> -
> +	kgd2kfd_suspend_process(kfd, run_pm);
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
>  		node->dqm->ops.stop(node->dqm);
> @@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  			return ret;
>  	}
>  
> +	ret = kgd2kfd_resume_process(kfd, run_pm);
> +
> +	return ret;
> +}
> +
> +void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	struct kfd_node *node;
> +	int i;
> +
> +	if (!kfd->init_complete)
> +		return;
> +
> +	/* for runtime suspend, skip locking kfd */
> +	if (!run_pm) {
> +		mutex_lock(&kfd_processes_mutex);
> +		/* For first KFD device suspend all the KFD processes */
> +		if (++kfd_locked == 1)
> +			kfd_suspend_all_processes();
> +		mutex_unlock(&kfd_processes_mutex);
> +	}
> +}
> +
> +int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	int ret, i;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
>  	/* for runtime resume, skip unlocking kfd */
>  	if (!run_pm) {
>  		mutex_lock(&kfd_processes_mutex);

