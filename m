Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80308E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 05:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8A010E04B;
	Fri,  6 Dec 2024 05:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="md+o2lql";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7367D10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 05:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc/Yc+/8aPUEj7jhLxZmTTR3DAoj1EVHXbzlPLgdlMOuf02OBt/Z9cUQ51NCeEBqhptB1F4Ewt+FAgIAqiDRXNuxiqHukz7j4Y0lZAU0tyCbUZiUWE34M3IyP+F8d1aHUCDOyT+nZCYSwbd9Q/xH9jQtDQ5x7PONWS+JtUOTzqOUqtSPKbG2684m3+ALQFaXz6QPSXn9jN4Xz/RP++llmSPqtWSytb+wHwmSanXDSfo3f6wL1Gz6BvhArnlCJJVSN6YqiWAY5bovHBrC5KFrgkMguh+dq9rYdspEAV4VHt6wgNNHzE5JwQ8IXo9NlRJVkmtSl7E5jjgvI6rmr0GwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBDCDNK58So3KM4L+9yKK+YHBE5eRE0kH24Ow6rmyPQ=;
 b=OLitygtqw0J06Yon/51xp/slTNCvm5QF7AD8cv2nzCfPl4Ml5TCwHyTNP7k9OnbHAkBSzIHrgYvyUfmnX/PadPsPIEGlVpU5USkKZPIUf849E4UezWCD3h+ixcyVreXh3vgoM+WIvv4ZLcfmsn/gmJrPSH/kPioc01ev4/kDSYqx5M6QrynaUmE9szxKUZKeCzlbQq4Kz0zpstdOd2ZmuExBrzrNF1SApIImaMrmlY0cXj6jFJxXgmiMVcjPtc6zVUjGDg/3f+r2o/ssyQlcYBDk1u1Zhpk5hJdgK5oC3yKRKco/jPlv8NHp7LxJdarYc0x7LxfN6ncW2nnMTEFsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBDCDNK58So3KM4L+9yKK+YHBE5eRE0kH24Ow6rmyPQ=;
 b=md+o2lqlDD4ehzkbYhUy+qwcosN105488dTNwVvKBTAOswOOuZKvgnqI8WLrau2EcZnAAkA6AQ28eKMCpUGOI0AolBAGrcf4nOjmYewjWVShOsynkt9ATQ+3UHp2APgDun+jUram2kGqn6Qro5QrAD2um78LOAcMmqowZHVuui8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:17:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:17:45 +0000
Message-ID: <6f18e09d-b523-4bdd-b435-8d02f54227fa@amd.com>
Date: Fri, 6 Dec 2024 10:47:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
To: Yuan Feng <yfeng1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241205224507.2272-1-yfeng1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241205224507.2272-1-yfeng1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 812326e7-dedf-460e-e31f-08dd15b550ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1JqKzVPb1MwZEZ1Rk51TmQ2NTlod1hyS1RVZjRXb1FOY1M2ZzhtY2xVMXo2?=
 =?utf-8?B?Q0dOUGdLQnI4VlZIS0hxMkthbVc4UnpDcWpJY1duNlo0QzdGUlJQRDh1N3E2?=
 =?utf-8?B?ajNSY1MwTjV0dmVXblUrK1RNMUpWcHJUU2xUVGVHR3ROR002MW5GQ29YM1JT?=
 =?utf-8?B?RWkwZlcvMzlWalRCei9Bd0dLeER0RkVyR1RJa3BwUzRpUGlyZ2h4UW42WlRT?=
 =?utf-8?B?RDJDMHpSa2hzakd3WTFVOUxMMy84MGNJNkRHL1d3UGZQWGFibExoMUVobDd1?=
 =?utf-8?B?MEI3SmlPYVRsSERBczIrOGZHamh1cHpodnJXd1hoWUpxb2dlUlFQcGYzWER5?=
 =?utf-8?B?d2srQVQ5N1puWkpzZ3MzcG5ZbVh3cHZ1cGhpM0tnR2hRajRoaWE2dVNvNm1O?=
 =?utf-8?B?bmh1aVhNaE1BVktYd2pKcFdWUHRoeWNvb2ZEc0FYczhLd3B4aEJHOWZ0ZXdF?=
 =?utf-8?B?WEc2RjZzYTFYZUxWQWdvb3hNTC9oSnoycE1VbytjTUJYZTNrZkdpRmh3Qmlh?=
 =?utf-8?B?K1Z4OFo5djNqcHN0Nkp3aFBZNWlKRDJ4YmloanJtTzNGL0VZSGN3dEpmeUxP?=
 =?utf-8?B?K2RuVEhFNjMxMnYwdnovTmh4OXF5M2FCU1NhZzNHaHlBYjdRbFZGbXhwanlS?=
 =?utf-8?B?MHlQYVpYQ2k0Y0J4allzMHVYaWt6T0taV3duUFllZ01vblZmZkhwK3I3S2g5?=
 =?utf-8?B?RWxlMVNUN0pRM3V0U0RnTmJjcFFKcmROY0xzUzhPY09DcDc5bWlsRVkxQmNR?=
 =?utf-8?B?bG1icmJPNThpT211NUFKYlc5MlRsVjZXcS9RMFZkWHc0U0RjNkNSMHNidVVv?=
 =?utf-8?B?RlNrNU9lWDZNWkxiMDlvMFZZK0t1R1dROFJJYWkrMklYWHh0QTFjUzlrWnFQ?=
 =?utf-8?B?QnpQVHR5ck83WGg1bWI5Ymp4UjJFSmlwQ2J4UXM5RUlHNXhJNHE3U0NGbFpR?=
 =?utf-8?B?V1ROTExYQWM4OWFkakJuWDR1WTVVb0xaR2JHaW5hNGRQblpVMmlvOWdWTU5y?=
 =?utf-8?B?LzBUMjRER1F2V2MxMU5sZnV0TU5wYllOanpsYlFRNUp0aTRNWDM3OWc1YXVM?=
 =?utf-8?B?eWtRTzN0dlBaSEpnc2pzZlVydEhFRWYyNmx2eUg2ZWtLVFNhdXBJUWRwS0xL?=
 =?utf-8?B?VTJaUCtzUHRsbUYrOEl2NFJPQjdlN3NORlFIYWhFMzFlK1pyK0d1MXZtenM0?=
 =?utf-8?B?T1A0QTlVdCthSTV3bFBySTRXUC9tYk5STldHZk5VNmMyb1Y5cmNNV0lob0l0?=
 =?utf-8?B?ZitDY2QrRmlXaWw3U0t3UU9kU2hvWWNQaFVoVHVYSjBlME5NdWt5clY1K3lI?=
 =?utf-8?B?QWRRT2tzOTRYbEkxejBkajlNL24xb24wT2RtM1lVaHpMMXI4bGpaanZobXJs?=
 =?utf-8?B?Vk9KbFdhKzU1bkpxc1UwQWhYNXJkOVhJTzFmQ1Fub3JydEs2T1EwZVpUNWpX?=
 =?utf-8?B?T0NYckw0YUxydWl1K0I0V0xJU2NRWTA5NnRERDNHQzNaOFNkRE5rVVc3RWRE?=
 =?utf-8?B?T1dJVmRMT1g2TTVCMHNkZFVOcG1aRVZlbTlCc2QrazhEYlNqVS9ER2xyWmw2?=
 =?utf-8?B?QlFEaEp6TUtTRGY3bE5tWDlBb3MxV0V2Q0VWbGR3ODQyNkFYcFJ5TEdLZ2dM?=
 =?utf-8?B?UXpqRVRITmI1L0xERmpWQWREU0YyV244Y1FaLzE0a0k4MlNlTy83L1VVcHYr?=
 =?utf-8?B?UEVodWxGUGI3blZqMmNqUW0weXlUY21QS1ZjaHlJVFRBQUExemtZZXh6YXJu?=
 =?utf-8?Q?pC781RE/7ll4+A3qZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRqTlIwbGZwYkNnTkI1NUoveUJwSVlPTVE2TnFBWGlvck1pdlhOdGJ6MmFD?=
 =?utf-8?B?ZTRPdXpXWUs4ZDNHWGNXd21OTWdGOFI5MnBJbTZwa1UvK0pCcFFEb1dObjJv?=
 =?utf-8?B?U1FoRlBwMFVQQXlyeGsveStZVWdGUmc0Y3lUSFFoZ2ZlZTlVRGpLN3g1Nmdz?=
 =?utf-8?B?ck5WdXp6VGN2UmxnSVkzbFEyYm4xWWZhN3Zaa05idy9zQXd4VE5nU0RVZy94?=
 =?utf-8?B?L3d5VHQ5YjBWbUVNK0REU0orQUJUNlAvNS85SXpOTUVTL3hKMmlsb05ObE1O?=
 =?utf-8?B?VHVNQisrejZ5Q3NySG5QWmhjd1VSWlhSek91QkU3QW53QWU1bHVrSzRMcDI4?=
 =?utf-8?B?ZkJEM015R0tMRm5iSlVWK21ja01hL2hSWjR4STkxZ2dqRFlETnFHMmk3THpv?=
 =?utf-8?B?TUNueXlqZ0lvYzByQ3lHTE5RdnVtdjNNSVFjcHl0ZlB6UVZSUGJaS09sNER2?=
 =?utf-8?B?YW15VHJQaTBUdmRreUZaNFFxYm5qRlhLMktMNVp2SWdaSWQraHdMTEZTT1F3?=
 =?utf-8?B?OEJmdHJuMXFhSzNCckxwVU5MRXZVa1F1QS9TWVFWUy94V2dYMEN0ak9TSUJX?=
 =?utf-8?B?U3NWZ2E0R2VLR2NsNWJRaWlpYko4MDA1ekFtNzgwajRHb1A1NFZzSXVsVmRG?=
 =?utf-8?B?elBLK21WMkVkM1I5clFJdkY4OVdSZk9yMjNlQmpTSEZJNVJQbHNIdVQ5SUFv?=
 =?utf-8?B?Q2c3WUlPUlY0ZkJTT3BUcEFkcURFSkpyY0FBZDNRS0s3NTJHR0pXVFhHNnpv?=
 =?utf-8?B?RVBBUmtLc0tLN0FjU2NGaDI1V25TY1gzaUVaZUZSY1Z2amE3R0I1ZE0zUnpi?=
 =?utf-8?B?VVlzUzlBNXJvUm94WXVReWhFdFB2S2lmMHFkbTBDRUFBaHZOZk9sbTVpVlRI?=
 =?utf-8?B?bEpjMk9JdTd1Nm80U1QvNU5tSnE5TE9RRGt0OEhDUmtlWnhDMGt4Vld6U1Z0?=
 =?utf-8?B?RlNlTjJGVkM3a2lUUDNxYUswenpvNEJKa01TSm5Vem81aEkyTXRmeVdTUGhP?=
 =?utf-8?B?cStkYXN1RzhkWWpZQ0dRRmMvYkZLQVVFUDZrWUoxd0ZIMmcxTmg0dHVzdGJI?=
 =?utf-8?B?cUM4M2NlTS9iY3dKWGhqMUgwbDA2TUYzY0V6NFFSSm9VQmFrVnNhS3VTbEpG?=
 =?utf-8?B?aVltYUFnNVN4MG53ODhYM2FRNGZRdDJRRGJLRXNiR2phU2ZYd1JWc2daQWQy?=
 =?utf-8?B?NE81djdpNVhYVEJGa0pWU00yeGdJN1BIZHNLYVNkSlJFYUlOWUtEVzJPRURD?=
 =?utf-8?B?VDRaQktvb2h2S2RSN1UwU2NZTkdpUDN5SW10MVJQQzJZcDZYVkFJVUdvUS9r?=
 =?utf-8?B?MXhWMTYrUC80MUZBR3Y2MmlSaHFkZXBLY0ZzRlY5VndQbmIrNHRzOWhFVVNS?=
 =?utf-8?B?ei8yUEVFeWpKWWNlbG9UUW9Sd0QzUEJmYzNsVFBneTdGcUlaRDNERGwrY205?=
 =?utf-8?B?ZG9JK3FnMUc4dlpYa3BGSkgrVzVDbTh4L1BkL2JkdkNpcU1YQ0VVYmVBQ0NX?=
 =?utf-8?B?TWRLcFNqN3htVEhRQXhRTExXTncrbENPYTdibkd1akMyMEJPa09VSWV5R1lj?=
 =?utf-8?B?b21zSUpBc01lR2ZKcUN5UE9ZZG5vTE5XQjNhMU1TcUZrbkhEK0NZNCtQOVNJ?=
 =?utf-8?B?NnV2MDJORkQzTEI5Rk1LaTYxTWpLVzNOckkzUHhaNU5NdVNIV0Z5WHdwMjM4?=
 =?utf-8?B?U25iNTZTckpaeXJHaEJFa2RTNDRaUm55Z3lJOU56ZDVtR0pkY3JObU1FdXZr?=
 =?utf-8?B?SHR0UVhTRzIwdFI4TVJ4Ty9rWkpJUHcwekdrTE5uSjJEcFVBejlzZFZ6azg4?=
 =?utf-8?B?QVdwaFFBOXJCcGl4SU83Z0NjSjZqbGF2bU1rUkVCMUpQNnBxU3BMUFlyV2wz?=
 =?utf-8?B?V0Q3TVM0ODkrNkJsVFd1dmlielNTdmwvVmYvNDh2TWdtRlNPYS9hUHNDVDMx?=
 =?utf-8?B?SkVmeXBTS0VFa1NvZXlmSVJVdXdGeDFYYUMya0RXV2FQY0hMQzdNcnJGbWF0?=
 =?utf-8?B?UjdCa01QeDlUeU1JbTV2cW9nK0d5TlBaeEE4TlI2ci95L25TbCtXa3ZzSmJq?=
 =?utf-8?B?ZVpuTEtEekdEbE04ck5qWjEvNjAvUk5rb2tRVjVOWGFZYThiS2pycGs3SzRE?=
 =?utf-8?Q?oQHMJL3gK296Bp7uPJS+hGRgw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812326e7-dedf-460e-e31f-08dd15b550ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:45.0866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRgIq16B08NL8L3IFsSKpB0/BcXC9wsl85Zn/30rHa3lphzrpBdBkbi/TL4uZduO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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



On 12/6/2024 4:15 AM, Yuan Feng wrote:
> On SRIOV, guest driver and host driver might deploy different versions of MEC firmware binaries that
> lead to potential compability issues cause system hang. To solve this, host and guest deploy MEC fw copies
> with two level jump table.
> 
> Signed-off-by: Yuan Feng <yfeng1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 03654bfda58a..f248449e93a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -45,6 +45,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_4_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
>  

This change needs to be done on top of
https://patchwork.freedesktop.org/patch/626097/ as that one adds support
for GFX 9.4.4 also.

Thanks,
Lijo

>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
> @@ -574,7 +575,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  {
>  	int err;
>  
> -	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +	if (amdgpu_sriov_vf(adev)) {
> +		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   "amdgpu/%s_sjt_mec.bin", chip_name);
> +
> +		if (err)
> +			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
> +				   		"amdgpu/%s_mec.bin", chip_name);
> +	}
> +	else
> +		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
>  				   "amdgpu/%s_mec.bin", chip_name);
>  	if (err)
>  		goto out;

