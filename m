Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3782C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D17610EE11;
	Thu, 23 May 2024 18:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnFFZ9Xx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F73310EE11
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtgBo3KxW2WHxYutRGLecFD32IwLU3pL7NgFcSGhgl+zuom6FYU5Q7WKkMASHz13YqaBKlpm4jPqJkRjX8c7MKpJhCvvJcIiYhMhW8VNUAQaLPw3gu5HO0VwmzqpUf5V0gJmtEbVtRqbkzft2L2BYpGr67cbtT6vHwh/Vn4Lo63XeeotQifHjEv7JooTSGJtZ2fPYZMSQrJ728MpUnPl8997Qj/xqoVPzY8HvyqhVoB6+trqBqISy8KEem5racf/tq4RsOXnRKzqvTHv/cW/jAk3KTJSAd6sidwWgNMMNVo7ajGGVPUI7ak4XtpJRk5OlXUXOIq+HrL3s4NL9xSmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuSlmavJgdr9hirgvvpGQBOQQdiJgHA22tLxrTLsA3M=;
 b=ellM7ciRZuZJz6F0IAxR2Y8fPKQyLK8nVDAv5uFj4tzkRSgrAqU4F5HFD7WtmAAmXC/UcwbJJzbncb8uhJ9CSWkr3u7Q8H2gWLSsSkeBiFwsoirNjyTmh51N3ucvlZx6Pz9asYFZz8Y68ZEPI2C83lqwO4+t2vBzWZTQ3DF8u2pBxXo1lqACtomU/Qvc2M1xssH5ME6g0Xm3lUobpkUTn3IMabpNYcr087/bCShc6BJFu9O4psTRn0oq5uo1+OetWUvkVaquRNGz8qjZtXpU0D3xGWNNt2IZJjFG/TMXFmi+pjDMNcZPc02RHFMH5kXkucKe725B2J61zlABu4Kgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuSlmavJgdr9hirgvvpGQBOQQdiJgHA22tLxrTLsA3M=;
 b=mnFFZ9XxiZ7AAosn198vj/axRInp9+1/ulmml4JphWL7fleyMagNWzOf3u/9lgI3y9zERRa48Y+L4pXLIgsT+YKjNSONQY/qTmNo++Xsm/gYkHWaEXmxXYcQkVyJ0/9cu9qV6rWoCF9HiG7fUnuNY0zmT4hljNHbObFn335HIik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 18:41:38 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 18:41:38 +0000
Message-ID: <d50603ea-cdd5-4390-9c43-a2e12d129c32@amd.com>
Date: Thu, 23 May 2024 19:41:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: Sync trap handler binary with source
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20240523140809.1135226-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b0672e-129f-4e74-fe2b-08dc7b57facf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDhiaXlzSGsxalFobE5HcUdIcHBPc0lDNE1JRmcwNnQxUGR5S3lCVmpTbS8z?=
 =?utf-8?B?ZVdkREVUZk1oaWdQK0RwV3kyTm5wNEE3Y3RMNldSOHVtc1lteGI5MTdwRmht?=
 =?utf-8?B?TTNjMXpjUCtZWDE3czdOeUFIbld4SVFmZ3VSOXpSTmhidjREVFFxUXc3YXRK?=
 =?utf-8?B?dUdkSUVOSkEyb0dzcXE5WmprU1lHVkZYejZadkRwUXUxUFhhNWRyZktrMXds?=
 =?utf-8?B?d3VzN2Z2SDlZKzFyVVYwQ2R6dTRnRVBJcG9iRFUrY2dHb1Z3bnNZeUd4WWI1?=
 =?utf-8?B?ZGFxak5rS1RHQmFSTXNwLzduSmNRcVpBZVdpcFdLMW1BbWU2RWliUTZtenY0?=
 =?utf-8?B?UlJzWjkxejNJTzNFNW1jSmNUR2tLNkpXK1lBRlRpalZKNDJqT05aanRhMk12?=
 =?utf-8?B?aUtDd01IU1cvblVheXY4dE1wa2RsTGQzRmh6Tzlpc3ZmRDZGZXRQeDJHN0hs?=
 =?utf-8?B?bWg2OGJIaStKOFVSWFN5VkJ2bXBhR1FpdW9aM2hOZlRoSXdabUhVZmFsdVpF?=
 =?utf-8?B?ckdML2lrbUVzTU85TXFmR2wzYjEvWE9mbm5wL0dTRWNGUHloMCttSXBJcG9r?=
 =?utf-8?B?RmZHdGg4RVV1R0syUkJhWUl2cC9GVFdJTDJDQVVUVFRoeklDbmlkZC9UR1du?=
 =?utf-8?B?ODZxY2M1Z1kxUklXUzR5TmxMWVY0WXhXU3RteWRIc1RVdXp1Y1c4R05lNUV4?=
 =?utf-8?B?dkhUZjh1OW9HUloyT3pEU2s1Z2syK2dDR3BBRlVTZkNsWkpXQmYrSWVEUVV1?=
 =?utf-8?B?T0g5L3FzUmhZYUVHMndTTkxZY05PdklHZXA0Y3JvM2VyazViVmZNRW5DcUo4?=
 =?utf-8?B?ZVpWYzNiVmJhQlpkd3EzUVFkRzZZV1Y0SDZKTXcxTTJtWTRpcVorcFVOTW93?=
 =?utf-8?B?VllRMzFXU2hLbWNBd3RTdUt2N1JIYys2M29HSCtHcjZKNWdLcURoM1BydVli?=
 =?utf-8?B?ZEhLYmM0WjRvbFh6M1EzM3REUCtFc0JVdmQvMTEzY3ErckhmRzBHaGxJVFRz?=
 =?utf-8?B?ZDJtRWdwRDA5YytHclY5OHRia0I1ME85VVNwZHVEK01yVDJIbGJiOVJ1aFNE?=
 =?utf-8?B?aUhDUDBoNXRzRmxUN2E4M1N0Z1o4UWtNdmg3Vzdmbi9Ha2d2NVpIeTB0YTRX?=
 =?utf-8?B?QUoyaGVjdG9aVE1KMStPSHVDYmpUZGkrcnNQeG9kVko5L2RTR0srVWliV2pl?=
 =?utf-8?B?MmMxQ3I5UWltY2VDRjg2SDhlQnVpWDhqSS82bDl5eWNkMVZjZ3ZlRUJ1VGsy?=
 =?utf-8?B?SFplZlBCNmV0Wk9IOGkwTE9CVSticEZneW1TSUFlZThKTW5EK2ZLNDdUQTdH?=
 =?utf-8?B?a01KMHdseWRUT09EdDlDc01FYkw4S1NxTzE4SnN2Qm9oMmZ2YlZ0N3I0S2x0?=
 =?utf-8?B?T2gvckdyZ0Y4ZVNxdDM1cUFzc01WYk8wSml4YWNkTks0RXA4b3FxZUQxS0sz?=
 =?utf-8?B?Wkt3SHB1N3FINkNnSWFSMGRlYWt0aERUditpMUFETTlWYXY5WVFKTW00VXZD?=
 =?utf-8?B?TnYzUDlmc1ROdEMvRnVpQy9FdXg2am1MS2FEcWhsVERTMjA2VEJ6ei9JdVBk?=
 =?utf-8?B?Z2k0Mi9QaldLZGs2eXJZbVJHdE0yQUlHUXNseVZkdGJQblBuL1U4SnlyZnhG?=
 =?utf-8?B?MzRTTzdGSWFOOVJmUThZdC9MQmxLQkFHYWJ0dk1hTDNHRkxxWXNmVXRvWFpm?=
 =?utf-8?B?TGJ1YWhPSmp6dDhCYzB1eitXQ3VOWktPVDRYWHFSUFVUSW1KRkZyc3pBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blFYYmxhTjhyTnV5bDJ0RWNQcFBuTjUySE5tbHpXbWxZN3B0YjVaVDQwQTlz?=
 =?utf-8?B?ME1mL2ZrOWRqb2NxSUo0TjQzQjFzb1NCWFBwNTRPT2FDeEprbktjOXo5NENV?=
 =?utf-8?B?eXZEM3BVSzB1WXR2WHVJV2wwUjhXaVdad1dONUU0R0hNZ2FmaFFIK3N4NTBN?=
 =?utf-8?B?Mnl6Z0dRZHNJeGVyS1Q4dlpJU3JzcVpLTjNnWUNOU2dvNHpzcklvS1lrYmQ3?=
 =?utf-8?B?WDg1WHlXTzFoN1FOSlVaSVhjNVdPMStzcXQxNjRJSkRwZjJTb00wR1RER0dp?=
 =?utf-8?B?R21QR3p0SDRLQzZuZ0RLaDZDMy9QOTBrVVoreURqczlTV1N4SnNGM3BBV3NB?=
 =?utf-8?B?NHV6TE1qWVY1ZkZYSDMzS3dFUW1NMGkvWFVvalBvbmJZOFBXSXZkZEFEcytq?=
 =?utf-8?B?MHFEMjI1OSt0VnFkWC9DY09GV2NrcmRZNkczNldYZW9kN1gySHg4c1NJK0xh?=
 =?utf-8?B?S0FwSDR3UUpzbFZNNkMzWXY1cDFIalIveVBCTExCL2RlUnpOTENodDgyOHVL?=
 =?utf-8?B?TTYrMUVSTXgxVlg5ZityMzRyR3lHU0RHOEJUQ0VJdXprUVZTV0VFMHZuVVVm?=
 =?utf-8?B?NitHczZWcVRockJTOTRUdjFWR1F6dUNSVHp4RzRCTlE4QjBLdWQzdld1dEF5?=
 =?utf-8?B?enVQZlVUZ1MzZnVkOVFhTXBMalpiZGNmWkQzdWsvTnIwZzFGajFuUXdXS0Ji?=
 =?utf-8?B?VjUzaEc4UGtoRmkvRDJlZGIvSzJ5NTR4ditBUXltSkRzUlZRNkhJb0hYKzZN?=
 =?utf-8?B?cG5lQkRSb2FTb3lrOEp3VnpkenBRcUViQ3E1dVBnUFBMc21OTy9ZWXVKT1hl?=
 =?utf-8?B?VDFVQmdIM3l0VDJQak55MFJHcEN1Z2l6WE4vbDlxM3BrLytOb29Bd015ZDlD?=
 =?utf-8?B?aUtLZjlnd0pzN3U4TmlDVkF1YTlJY3c5RHA5bFd5cWRRRTVmU3J3WkwzS1JW?=
 =?utf-8?B?bVEzQ3diWmI0eDlDNCszcTZXQ3ZBeURDVUFHc1ZFWG15d0gwR3M5alROT0FV?=
 =?utf-8?B?bGVOQjg0ejNJOXRHTlFjNGhacER4dWxTemFTVGlEckx6V2RIVS9DWFdKcFpk?=
 =?utf-8?B?RFlVUzgzTGJpMmd2VHFnV1NPTWdGWU5qbkZkQ3JvajJNKzRtdnkzaHlSNVg4?=
 =?utf-8?B?T21Uc1ViMnhxUVRDMTlTYjBqdmRscHQ0TUw4cmlkNzlzZjNTWnFqMjl4SlIz?=
 =?utf-8?B?Sy9wVHQvWU80M29iOFU1SWxvQjFCM2FPNjJFRGpES1MxcVNTUWdhaHNMczBq?=
 =?utf-8?B?dmVkcWhZNXJUZ3JON0hXVzZIbjBnQkcwVXFyVWc0NzRQRU8zaTEwVUNJaXdr?=
 =?utf-8?B?WWx5YVpockZEMWRqZ1BYODdsVXFuR0NCTVA2Yk9DRTlLT0o0T051cnltR2Yr?=
 =?utf-8?B?NXVqZnAvUnpQcTJ0S2pWQkVxTjlhR1NMeHRPOWkvOGk0UVhrWDBkWkVwYUI0?=
 =?utf-8?B?Q0YxY0NFMFlZRzZnVHZPOXBCVWp1R1VMNVcvVW5MYjNPbGpsWFlOSmlweVVv?=
 =?utf-8?B?WWZ3RnVISSs2QU92N2Q4SGQ3dWljaktVbjA1ZW5MZFhlNUJkMGQ4T3hvTzdX?=
 =?utf-8?B?ek9NRi9WOGtRY1phUWg1eFpXY1U5Y25QVmgrejZ2dWEvdkpxcHBGYlJKQ2U0?=
 =?utf-8?B?NjlqOElRODlmNUJXQkZVL3ljK29Ma0FPNFB1c2FXOWl1UDhUR0ZpRFE1YmlY?=
 =?utf-8?B?b0xOemlRM0g0eDdWT3dOU2dwTGwyMk1UczA1MnJucDQzNGZ0RTdPcisybUJx?=
 =?utf-8?B?Z0U4NmdoVFhDVjNSaEZaRUhwQzBqTDBZOUhpNkNrTUtoam1YTkNPQW9UU3M5?=
 =?utf-8?B?YzBTK3lBU01Zc2JVZ0JUaDhORWgrWEdWTSszZGZDbGJ3QWVOZzlQOHAycXFS?=
 =?utf-8?B?OFhJbENRTU1jWEhKZkRoN1U5b3RNamUybmVwbnV5NmVCdHFSbFR5UHdhd3RT?=
 =?utf-8?B?L3pDZUM5YURQWkY4dEZRcGlIZGJySGpnMnVzck9xZWRKZWFlQ3dHRUdqUUdW?=
 =?utf-8?B?RyttaUdjVHhJb3BaamZkWlh4ZFpackNNZTQ2T0R4M2Z1b0JYNmNSVzN1bGVQ?=
 =?utf-8?B?aWkwYWZ2Z0JZVGc2Z2RoYXlmUEtZOUJWYTNxRSt4VzM0VUY0QzZ5UVphaVBv?=
 =?utf-8?Q?PXaH3v19dwxxWHvLUeM3pPuXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0672e-129f-4e74-fe2b-08dc7b57facf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:41:38.2188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iR7RlCpFA3XYPTLJ6RdARO1DQjzmNowIDqFbOY/StFisbZUm9+afqs8AjQAPgrkvjkDwyfg08vSqnrWMIODnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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



On 23/05/2024 15:08, Jay Cornwall wrote:
> Source and binary have become mismatched during branch activity.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Thanks for doing this.

This matches what I have when rebuilding the trap handlers.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 57 ++++++++-----------
>   1 file changed, 24 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 73d3772cdb76..11d076eb770c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -718,12 +718,12 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xf4051ebd, 0xfa000008,
>   	0xbf8cc07f, 0x87ee6e6e,
>   	0xbf840001, 0xbe80206e,
> -	0x876eff6d, 0x01ff0000,
> -	0xbf850005, 0x8878ff78,
> -	0x00002000, 0x80ec886c,
> -	0x82ed806d, 0xbf820005,
> -	0x876eff6d, 0x01000000,
> -	0xbf850002, 0x806c846c,
> +	0x876eff6d, 0x00ff0000,
> +	0xbf850008, 0x876eff6d,
> +	0x01000000, 0xbf850007,
> +	0x8878ff78, 0x00002000,
> +	0x80ec886c, 0x82ed806d,
> +	0xbf820002, 0x806c846c,
>   	0x826d806d, 0x876dff6d,
>   	0x0000ffff, 0x907a8977,
>   	0x877bff7a, 0x003f8000,
> @@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xe0704000, 0x705d0000,
>   	0x807c817c, 0x8070ff70,
>   	0x00000080, 0xbf0a7b7c,
> -	0xbf85fff8, 0xbf820144,
> +	0xbf85fff8, 0xbf82013e,
>   	0xbef4037e, 0x8775ff7f,
>   	0x0000ffff, 0x8875ff75,
>   	0x00040000, 0xbef60380,
> @@ -1276,10 +1276,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x80788478, 0xbf8cc07f,
>   	0xb9eef815, 0xbefc036f,
>   	0xbefe0370, 0xbeff0371,
> -	0x876f7bff, 0x000003ff,
> -	0xb9ef4803, 0xb9f9f816,
> -	0x876f7bff, 0xfffff800,
> -	0x906f8b6f, 0xb9efa2c3,
> +	0xb9f9f816, 0xb9fbf803,
>   	0xb9f3f801, 0xb96e3a05,
>   	0x806e816e, 0xbf0d9972,
>   	0xbf850002, 0x8f6e896e,
> @@ -2309,12 +2306,12 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xf4051ebd, 0xfa000008,
>   	0xbf8cc07f, 0x87ee6e6e,
>   	0xbf840001, 0xbe80206e,
> -	0x876eff6d, 0x01ff0000,
> -	0xbf850005, 0x8878ff78,
> -	0x00002000, 0x80ec886c,
> -	0x82ed806d, 0xbf820005,
> -	0x876eff6d, 0x01000000,
> -	0xbf850002, 0x806c846c,
> +	0x876eff6d, 0x00ff0000,
> +	0xbf850008, 0x876eff6d,
> +	0x01000000, 0xbf850007,
> +	0x8878ff78, 0x00002000,
> +	0x80ec886c, 0x82ed806d,
> +	0xbf820002, 0x806c846c,
>   	0x826d806d, 0x876dff6d,
>   	0x0000ffff, 0x87fe7e7e,
>   	0x87ea6a6a, 0xb9f8f802,
> @@ -2549,7 +2546,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x705d0000, 0x807c817c,
>   	0x8070ff70, 0x00000080,
>   	0xbf0a7b7c, 0xbf85fff8,
> -	0xbf82013b, 0xbef4037e,
> +	0xbf820135, 0xbef4037e,
>   	0x8775ff7f, 0x0000ffff,
>   	0x8875ff75, 0x00040000,
>   	0xbef60380, 0xbef703ff,
> @@ -2688,10 +2685,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xf0000000, 0x80788478,
>   	0xbf8cc07f, 0xb9eef815,
>   	0xbefc036f, 0xbefe0370,
> -	0xbeff0371, 0x876f7bff,
> -	0x000003ff, 0xb9ef4803,
> -	0x876f7bff, 0xfffff800,
> -	0x906f8b6f, 0xb9efa2c3,
> +	0xbeff0371, 0xb9fbf803,
>   	0xb9f3f801, 0xb96e3a05,
>   	0x806e816e, 0xbf0d9972,
>   	0xbf850002, 0x8f6e896e,
> @@ -2749,11 +2743,11 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xf8000008, 0xbf89fc07,
>   	0x8bee6e6e, 0xbfa10001,
>   	0xbe80486e, 0x8b6eff6d,
> -	0x01ff0000, 0xbfa20005,
> -	0x8c78ff78, 0x00002000,
> -	0x80ec886c, 0x82ed806d,
> -	0xbfa00005, 0x8b6eff6d,
> -	0x01000000, 0xbfa20002,
> +	0x00ff0000, 0xbfa20008,
> +	0x8b6eff6d, 0x01000000,
> +	0xbfa20007, 0x8c78ff78,
> +	0x00002000, 0x80ec886c,
> +	0x82ed806d, 0xbfa00002,
>   	0x806c846c, 0x826d806d,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
> @@ -2988,7 +2982,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x701d0000, 0x807d817d,
>   	0x8070ff70, 0x00000080,
>   	0xbf0a7b7d, 0xbfa2fff8,
> -	0xbfa00146, 0xbef4007e,
> +	0xbfa00140, 0xbef4007e,
>   	0x8b75ff7f, 0x0000ffff,
>   	0x8c75ff75, 0x00040000,
>   	0xbef60080, 0xbef700ff,
> @@ -3130,10 +3124,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xf0000000, 0x80788478,
>   	0xbf89fc07, 0xb96ef815,
>   	0xbefd006f, 0xbefe0070,
> -	0xbeff0071, 0x8b6f7bff,
> -	0x000003ff, 0xb96f4803,
> -	0x8b6f7bff, 0xfffff800,
> -	0x856f8b6f, 0xb96fa2c3,
> +	0xbeff0071, 0xb97bf803,
>   	0xb973f801, 0xb8ee3b05,
>   	0x806e816e, 0xbf0d9972,
>   	0xbfa20002, 0x846e896e,
> @@ -4119,7 +4110,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
>   	0xb97af804, 0xbe804a6c,
> -	0xbfb00000, 0xbf9f0000,
> +	0xbfb10000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
>   };
