Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174EDC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D4610E87E;
	Thu,  6 Feb 2025 14:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c36cNOq8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576D710E87E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:51:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ1ouCjhCxJTL3FNMVzpkqOhQZAHlshyV5zcTjfZB5AHeLwnU+JlWppznDBVXJWbq5yRB6eg7kN/yvii4sdw/sSYp7kcIeYuclzgbkWf1+XK8pVrAQDYRBcCPmQukgfn1wa8WbtlVrcCdMRXIQ736xmaGq3RXfcIxiE0XmVnpXR2tCssWVRqOCubuATkqvn61vAWBjqzmoirx7khAHuVh8HlEIeR2YYiVtzlyS0ruIvrg2PmpSkwwjiOu1cH8XLvPHwtsJWmt32CfEIsQewAvbYqepnjK8LEvdBf6aSDm7/1oj8RynUBgE0aoTIB4Kxog4caVMq3MgZAm1pIDJ67aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RdtEmBm5fMzTrvXnLm9ZKeknCNLVfywQhjgr+l4bj4=;
 b=pUj3qL02dqh0GWq8IsKz87VWbBAgCdSxfOoBDKp6b4tOSiHbH6sa2v6Hf2M/9SAF8C+eVAuNtb6hLkc4aCosjeQp9IFHiv60zspHiPzbdXssM8PvvkiwmGkIidEU4ZtTSfGtHynbuyAQz6sjGoG1o4Norz0f1CIgG7nrMLMSUtnNPJNTTn+rDxG6QV6I5E/dJzQWhLTKVVK/eIITpVxdeBJx/1++FX/FbtY+x1GETkksIJIUjmep2XXnwL+Eq93+ndTLEs1Glp2pFhMC/36AhLP0WIZs7jXFuPSReA3vZrt0BKYgndaG3XKqEVEIpeSJm1z6kGtTi7ChXqZPBq3JjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RdtEmBm5fMzTrvXnLm9ZKeknCNLVfywQhjgr+l4bj4=;
 b=c36cNOq8AJoxwaE1OFeiTBouu9NwFjbBmGILTcCEhfSMEki/6LtaFSgaDsSl8H5+Gt5iohPMxTlJ6w3Ix+pjHFCTpvRb5OstTsz+GJYNFENI/wqAsq0Td+osEO8FfPRsDQLFecyhrlQe457DKJDxHEUDUV41Z+onC9GmIBUU+vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 14:51:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:51:06 +0000
Message-ID: <afca7790-5a0d-44bc-9d4c-9c3eaea078d9@amd.com>
Date: Thu, 6 Feb 2025 20:20:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/amdgpu/sdma5.2: use
 amdgpu_gfx_off_ctrl_immediate()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250203214349.1400867-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: a78f476b-e09d-47ee-29e6-08dd46bdaf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGtTLzNwM01HMGE0N1ZUQkxSVnZ0c3h6cG51YjdZYmhQK2Y4Z25NSkpTU21I?=
 =?utf-8?B?WGhITTFKQW5SZ0ljZ2lJUWZuNTMzSjhtLzFLOWtWQ2xJT0MvUUZraDNHL01R?=
 =?utf-8?B?TFZmT0I2ays0Y1RRaldaUnRtWWdMMHNod01ZU3Y0blUveWcwZThacUsyaXNQ?=
 =?utf-8?B?K0NGK0dpU0hxalUybEJSRDlxcHNCK21xWnZWZ01RYkJpNmt3VGZXM1FSSUlm?=
 =?utf-8?B?dzVacFJTMUpqRkd4a0hwV2tKdlllbTdjZGkySzJsZXVrSzR1SkV6cnBWZSt5?=
 =?utf-8?B?Qkttc25VTG1iSCtmV0FmY2JleUlycHlwMkNjeXR4Yng5TVN2UUtQek1aWUkw?=
 =?utf-8?B?M0Vrc3NGMG9Ray8rWFZEVmxmSGZ2cExCSlhFWktoaDNIbTdOYS8zMXB4Skc5?=
 =?utf-8?B?emEwQXpNVHlTTGlOTE40cnpJUmUrN1JtVE1HZ2lxT2Y1ZExkN1ZJUTdsenBu?=
 =?utf-8?B?NkR4dDEwZUZTV2MzZmMxM05zdnRnMDhOTWRhaTBPQ0lQQ0pXaVVPeHJGVGxC?=
 =?utf-8?B?UDZxRWtEWmxIb0pjMUdGVUl2RW9UK2ZMa2FTNHVxNk9wc1FHSHhEaG43VWFF?=
 =?utf-8?B?dEZzc3NvOUZCZFFKSnd5eno2akEzanRiVExtekZPN3l5aXRyd2Q4OHdWZU9o?=
 =?utf-8?B?OTZzaFhvaUNrWnhyNDVyS0tKQ1FvM1ZwNUkvVmZVSEpUSUN6NnhMY1RjY3Yr?=
 =?utf-8?B?djBJWk5oRFI1WGllTHhmN2tnZ3prNkhRWEQ2MTNhL3Ivalk0bVkxTzdtQTF6?=
 =?utf-8?B?Z3VPYnpQMitjaGhpK2pFbXQ4UFFqSUZPTXZoVUNISG9walBLSk9JMjBFbXlv?=
 =?utf-8?B?RUVZcmhtbkZFRStVWkFNWmdPeEZ1WGJnYTVCeUdjbFdjaTlzczduQy9zZmlB?=
 =?utf-8?B?L1JpWTh4SjA4NTNaZWJSU1BRNkRqQ29xOFE3M003WklTWG9NS0wzOWFXU09T?=
 =?utf-8?B?Tk1ZTithTGNPY2ZQM3ZSUmpOaFpJY1RXdzdsWDltMG8vOTVNME5JaGZsNkRR?=
 =?utf-8?B?WWtFQktHYmxnT2F2QUVYZWFjaHRXelZHYS9nYmxBdFFNOG0wMGp2bWtTNjJ6?=
 =?utf-8?B?NWRaVXhSTGsyWmpaV0FNVm5FT0NYWnBndW04czFpVjd5dmdOeld2VGdabU1i?=
 =?utf-8?B?d3EwSnFtSkZVYzJmSkQvZ2JUQ2w3VTFnTSt5L3VGbHVjMnAzVUtPNUhwbnlV?=
 =?utf-8?B?VU1QY2VzMFBxYmdHblExU2Y2VTg4MXFyZGhvaDlxLzVyM3FPYldmblNLUmNy?=
 =?utf-8?B?N0sxMVN0U0dkMlEzRVF4RDNiQkdmdFUrOUtaNTdGZGs3U1JLUnFHcTN1ZDhO?=
 =?utf-8?B?MmJaWVNyY1dXZUUzRkVmb1NHcjI1SVByUkNLWUVIV0wvVHhMUDk4c05VUTFC?=
 =?utf-8?B?OUtPVzF5V0Rjc3Q2TlhmT2M0Q2U2dVBKaTJ0a2xFVXM3TW9xeTNxcG1EaU45?=
 =?utf-8?B?TGZzNnV2SmltR2JWLzV3eWtCUytlY3h4aWxJWUJ1U3dDVEhvSFJwRzBMaDRa?=
 =?utf-8?B?Uy8rRjlLSGZOVjRjUUxGVFE3SmlvN0lmY090S0tZcmtSV3V0WFdjMjBUbTVt?=
 =?utf-8?B?ay90cE1ybDFyWlNvSUpmd2FBOWxJcktQSDcrNHRreDl4bmloZjhpZitYNFJX?=
 =?utf-8?B?UDIyZUM5ZE5wNksrZGxxNU1mR2pIZEN1dFFJbkZiMU8rQVFxSnpkL0ZEN2ll?=
 =?utf-8?B?UnNib3ViZGc4VE92SFF3VU9BdXFFV1BuYUtUdkUwSG10NjB4UUVFV21nOFJX?=
 =?utf-8?B?c1FXcE9PdmZnT2kwdXFnTzZMeWNNUXBreWpkWXZySUNiOTMwNU9mYk9lUHVL?=
 =?utf-8?B?eUZpOVFtZldJL2dkcU01Q1BOaTFuc2FHVHpkc1JkUHBJcWNRNWRqN2tzMUVo?=
 =?utf-8?Q?DwDYA9g1dakw0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGt6bTltektXRURVMXlUczhjNjUvUHdvQlV5bk9oaWx0SldCcC9selJ0cHAw?=
 =?utf-8?B?OFRJaW10d3JKY3d2dE5hR296c05zZG5hZnpPekdlaEJVeEZSL3dzcWI2MmlG?=
 =?utf-8?B?TENua3Y2b3hiK2M5NkhhWU0xdVJlU0VJU3I2d3k3Y3Nrbk5QQ3JESnAyRzI5?=
 =?utf-8?B?ckRSaWZXd3hlQ0pEVmpMbVRTREJ1b0NPc1oyNzNZdVNGSHpKa2xXM0p5MjVK?=
 =?utf-8?B?TVRZdmVCQWU4TVQ3aWtLa1lXNHIxT3JGRFNqUmJrMyswN0U0RXJMN3k4VDkv?=
 =?utf-8?B?SkIvU0J1UC9JVW9lZkJyWSswWTN6d2VLTE5yRjBBeUZEbGhGZkxXalloMWRN?=
 =?utf-8?B?eEx2c2huUERvQ3lid1g2NUV4Ukl0K1A2WDRuTWVSckdlbU92cDUvb1p1OHBB?=
 =?utf-8?B?cUgvdDVuYVRHNDJtMWRJUU00ZlJ1UE1mNkx3QTh3R3lEQnpiL2ZZVnp3cTFQ?=
 =?utf-8?B?MGhpemVTK3IwOUpFVXRKOGFkVXp4TTh1RS96aXNrbVdIR1RUOUNjTC82bmRV?=
 =?utf-8?B?cERBRjlFQjNqU1MxdDQzTkhmejVvaVA1QlJZeUlhNTRrUmdtbU56NnZ5Tm9K?=
 =?utf-8?B?M0kwQlhtSC9CYS95KzNRWWpwRlg3UVlGSm1VVklNR28xYXI0NE51MFhjVmxC?=
 =?utf-8?B?bW9lTlZXeEVYVCs2d091NmJzZnVCNkVCZWpJUFhqNWd5cndWcFJjR1lNR1U1?=
 =?utf-8?B?N2pkQURmSmE3WlVSWHBMRlVwa3NWWENhSjhxMzdtbitkUEZnUC9RdHZFZEU4?=
 =?utf-8?B?WitJNkt4bmlGb1k4bHFOMnp1ZmtzZHNYOXJVWW5jNFhmYTNFTVVmSkZnUmFo?=
 =?utf-8?B?UUIrYU1UaGI1dGFBQkJ3Ykd3QW1VN2srdWszdGI0V2pEaWpWL0d5NFVXQmZI?=
 =?utf-8?B?YTgwVWNPYXpFN1haS1I4SlBINlREd1QzZXdEVjJ1SW4wcXBaMnYxaFNHQUUx?=
 =?utf-8?B?T0NabGt2d3h4dUs4dms1eFMwZHpMQ3luWFpXWkpmOHFVQUFCTyt6aFRHdXhL?=
 =?utf-8?B?Q09kdmhuaXBwSlBETnkyRTlkNithZzhQdGQvUmRwakVjWEUwa2dmUkNCRjFF?=
 =?utf-8?B?dGJPMXduL0htVUhoYW9JMGtTUTRDeU1BekdpMkpydjlEMitWbUx5NDRxNFp4?=
 =?utf-8?B?MWwrYXZxZnlaZHhya0lYbHJWZysrZFlQZlJVbC94elFsbkU0SkpqVkg3YkZ3?=
 =?utf-8?B?RjVjYXBrcDZHZ2s1bkYzbit1TTNpNmRjUkQ5OUtLT0k5Qy9qdXI1SGM4bGJu?=
 =?utf-8?B?UGhzajBLaE03WXdxMFdhb1RReHl5Rmp6K0hYQ1RxTnpzdmxGNnowMDB1cmxp?=
 =?utf-8?B?eUlMM2Rwa3Nrb0prMHhZWjJlVStWQXcyYzdTZWNEZUZ1Z0E5VVBISlRvdVlV?=
 =?utf-8?B?d0JJWTdBOVAxNlZkS0lGRC9tSlJLcVJHbEkrK0g0VEFaSmIrVFd5QzdwdE92?=
 =?utf-8?B?cnNyNTFTdks0RndqQUFpcGJ3S1NDSXJ2RjY3TngvYm4zRjNJUlk5WFVwZ0pL?=
 =?utf-8?B?K2o3L3N5amRJZGtkTEJES3pweWFhSXVBRERPTC85WUlTMnNXR2IyVmVHM1RY?=
 =?utf-8?B?ZzVHU1VWeWJrTDdhY3prdW9uMFJHK09hMGNINzRXK3ppVTByRWx0TmgyTGF6?=
 =?utf-8?B?Q2NEcmVtV0graWk2cnpzOEU2VGR3MTZLcWFNSXFsaU5nRTFJQVJCNVBBb2Zh?=
 =?utf-8?B?TVpONkxkV1FPUmFzNlRFV25nZFdvazNYaHQrTkp1M0VaalFaaEJGY0JkWThP?=
 =?utf-8?B?QmJGNTFhRlJDUUhJeHY2aDJXV28wbHA3T25VNEU2K1RobHR5a3M3bFJJOGFF?=
 =?utf-8?B?UmNFd3h5VUM4Mk14eHh3UDVsMzRyRWswUUxwdkYvNG55aTYyVmFaaFliR1Rw?=
 =?utf-8?B?elFiVEdxOERpeGtSZnZYMHpSSGxCcHEvSjI5NUc3S3hFcDgyWHZ1U0NySTB5?=
 =?utf-8?B?NURrdTMxdVAyMTgvdzZSSTZaYzN6WFQwVy90eDhDckhwclprWldzVzhuTFJj?=
 =?utf-8?B?c25Ec3dhVFBjQnErdnFXa3U4c2xROG5DSFNaY3R3TEozZUJQYWxoSmltWlNV?=
 =?utf-8?B?SDNJeXBJbVIrd1JQSmg3aEQ2cG1PRFVRL1RGRk1GSWtjRXZpcGdtaG1DUnQ3?=
 =?utf-8?Q?zp0fj+FX1MY1k/+5QfHPARRc7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78f476b-e09d-47ee-29e6-08dd46bdaf1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:51:06.0703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iOquzB7tk9L50wTuwOoHLc+DvYY9FBxmjFYRswkwzx6g63foiOZ9YMdo53Hkzjj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027
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



On 2/4/2025 3:13 AM, Alex Deucher wrote:
> In begin_use/end_use use amdgpu_gfx_off_ctrl_immediate()
> rather than amdgpu_gfx_off_ctrl() as we don't need the
> extra delay before we allow gfxoff again.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Won't this cause unnecessary GFX allows since sdma jobs could also be
used for clearing the buffers?

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index b1818e87889a2..7f2e1962b5755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1882,7 +1882,7 @@ static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
>  	 * doorbells when entering PG.  If you remove this, update
>  	 * sdma_v5_2_ring_set_wptr() as well!
>  	 */
> -	amdgpu_gfx_off_ctrl(adev, false);
> +	amdgpu_gfx_off_ctrl_immediate(adev, false);
>  }
>  
>  static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> @@ -1893,7 +1893,7 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
>  	 * disallow GFXOFF in some cases leading to
>  	 * hangs in SDMA.  Allow GFXOFF when SDMA is complete.
>  	 */
> -	amdgpu_gfx_off_ctrl(adev, true);
> +	amdgpu_gfx_off_ctrl_immediate(adev, true);
>  }
>  
>  static void sdma_v5_2_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)

