Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BE7C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A2010E161;
	Thu, 23 May 2024 18:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qweMV8Kp";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D123510E161
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4QoRMXUgM1Zk9SF+JV2y0dI9whxGT96orAHdNPgZ9K22vQjy2Fa3zhojgiU4Mkhg5l2Cx0/cYBV5X5xuEw9UhqPRzlnZjyR4HVV434AMtdbD57SQDalPdThk8jChEmNUBONfkbktmyZwQUd3BiRUnH1McNFadYzfYwMwKzL8H+22nGsCy6eJbTUVef6N9GMYyRYpSCBzzWjluLGdcSL+MvWXzj/qD/khrF7Kdvxs/ObPmnqUuRJk7FU47QvGyKAiLwvfwhyeX/sSNbqXsnfpFIPlr5Sfj6Y5jGxG1e+J1Ll331++hEw1+2q6CQEygFZpIfp0tfC3/fiQTxJtbQxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVOnDq4LF5adU7aw9IBwzJYoWRzfkj154ZNt0Nj+oT8=;
 b=eCY0WhAFosWKg+NUwaxUzSlTWr8P542rTrI65YTXoFOmRsOJZKPZczU3cclKaqCaA7DZqcUY9qc7pjWEg3TzNyidaidjlkHZA2ByS5u7aRVTlKTEbsMdyxBI8UQrCA8S6r3pDuBJ9mHD36ZbKwESFFH497xhFUqtqemEWMt+sF+IdbMx3KCdKLgUn9gAJo6OgMFrWIUWBiACAUaCU3XJDQlgZ8QJqid78omLMDoTf+fkJq1eHAXwhAHJI5gVc8DWzHn40DAdU/vBVT51dOH2Q7HBEx27/zxnFac/o7fcOfWx9SHxt4vdsO87gOBGASxdh+IR+AjPoDdZHOdmjVO41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVOnDq4LF5adU7aw9IBwzJYoWRzfkj154ZNt0Nj+oT8=;
 b=qweMV8Kpp/N1eaOs/Agt/VVoSNM05K+p0ZpoTb9+3jceZVO2yIG7HGj9F+eLv9D+0SnoEhJkcz35zxsGYcdfyZDpX+zg5GI4rkeOAxMD37yvdnTn1ldXeKvds6W7xZ6E56RuFVyYWEfyxwtF2Kwu2LQAP9/bYdgT1PUpIk6MbOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 18:43:53 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::8c67:8cec:7c4a:ccaa%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 18:43:53 +0000
Message-ID: <ff00b70d-edb7-4d33-aec4-dd29f0f1c670@amd.com>
Date: Thu, 23 May 2024 19:43:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdkfd: Replace deprecated gfx12 trap handler
 instructions
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240523140809.1135226-1-jay.cornwall@amd.com>
 <20240523140809.1135226-2-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20240523140809.1135226-2-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: b87e80cf-ba03-40e3-316e-08dc7b584b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzBNdklOR2JuTjEvUFJnZnk4NEhFc0laYllMNXowTnQraXVRSnJHRG4yKzdC?=
 =?utf-8?B?T04yVVdnamYwVWxGYlV0a2tCalEyWXZybVpSOHRIUENzWnd1aWdtUlFscFRy?=
 =?utf-8?B?MEY5S2VHK29EbVFCSVkwdlp1WjhUdjBDOUFGK2JxRWNPa1I4a0d3T1RsU3Fo?=
 =?utf-8?B?TUxDQXRwRWZLd2RFK3Q5OFdmSjJ5a25CMS9TTGtodGhwZjJPMzY5d2N4SStQ?=
 =?utf-8?B?a1l2SDE5YTArRUxHUTJzS2xaYVplSHA1VXdjZy9TKzhCUUtLWXdna29ZZlVl?=
 =?utf-8?B?d1RpMVEwcDNNMDNwdXR6b09kRUM3UXd4NkNVYUdxY2ZUR0VwU1lpWExzQWZ5?=
 =?utf-8?B?Y3Z0K3ZBYWwwampNNW51NEZJVUg2eHI2SG83dFpQVU1iVThicFZydE9XOHl4?=
 =?utf-8?B?dUtVVmpsbmRpZ1ZsREF1a3FuTFRtUURoR2VMVVZ1aHloTTNES2NuTWdlbzhu?=
 =?utf-8?B?dkZqRnEvRDZWaks0SDA2a0ZuZklsWW50dkFCQjhqS1dHem81clFzcmxpVDlY?=
 =?utf-8?B?dlpLQ1I0S1grRHU4RkJOekpCUjBQWXRlU0lzTHR2UXNDNk9uOXlHZjJ0Z3U2?=
 =?utf-8?B?b1dpVE1naGpsOVFPd2NYVGUraHp3S3Mrc0U1WHF2SWRWVkNnT2xGRFFsTXNY?=
 =?utf-8?B?eCtISEplT2lhUmdhdjBJWE04ZXVwR2g3aTI0OFlnSU1YWk9uT05DQktlT0w1?=
 =?utf-8?B?cnhWUXNUTGREazNVOXNoMUpZTFVVUVlNVFg4eHYyQmZyQ2RwMkwzemJES3dH?=
 =?utf-8?B?bjFscnRLbGhuS21GbmFqZ3FHTUtLMnZFNVpBdjFoY2NHSkora1EzdWYyenZR?=
 =?utf-8?B?YXVvSjh4a3V2Rk9XVVU4d3hjVkozd0pqc2c5NHFlT3pEcDJtV3p0ckNCTTM0?=
 =?utf-8?B?Z3ZZUW91VFNIanFxVm02Y1NHd3luUzAwaHZwWWRBVHlNL1pvSEJaVVEyRW1i?=
 =?utf-8?B?YTQzUmlwam1rNDZVazM0Q0Q1VG9hQUt2dDU5ZFFNS2NjS0g4WmVMeWNnT3d0?=
 =?utf-8?B?NEt1cUxHNVp4UGZOVnd1cDRncVQ2SCtWMWVtVVRISXZ5RTE5MXFTcXRKVU1K?=
 =?utf-8?B?bEFKK3FMZ1dweFEvYVpHQlNCOFliY0oxaVdxaUhKQnc1Y2FpVVVSbjk1ZzJR?=
 =?utf-8?B?VkNZRnZBeEtpdXhuWVpHOFB3R25rRDF3cm10Y0FrUlRiSFJIam5LK2RXVUMr?=
 =?utf-8?B?bG5nODNOVFZOMVdxejVyVFBWbGthaGpzUlM0b2tETTYyTlM5VjlzbTRHVWpt?=
 =?utf-8?B?aTRORTVZejlOd2ROL1FKcm1iOG4renpaS25SQlJCSUM4M3FTek56M0Q4QXY5?=
 =?utf-8?B?eUhOZzNSNmpPcXJ0WWVEWndrYitGU1NVVjQ5RGMvenNISTRzdXBSQm8vNE9T?=
 =?utf-8?B?d21qcTBFZmpadlVqVGo0dlpJR1h4R3VTdlZFaFN5SWI0RVo3VStuTm9tL0dy?=
 =?utf-8?B?dUlkU2tJTThOOTF3NTFzYUZrTmR2RWxjRjhROUVhdWtWRUU2MDFHSUIvRkhu?=
 =?utf-8?B?U2lCNHFURnNUeWpVK085b05JTG53M3BWZXdSZnFUbFY2Y0JtRGh5NDRFbk04?=
 =?utf-8?B?UlFJZW5CVFBQSVBhOUFLOUxNVGNWa2pSRmpNY3lHakt5aENHa2ZNOHVGQ3dC?=
 =?utf-8?B?VkpTeWdMejlKT1p4MDVid2RDL25pRW5VcHRVVnI3ZXhWZWVxZ3p0a2dwTHhK?=
 =?utf-8?B?aFdRNDBYdDZkV3FOWnJGRFFrVHpBRVZUb1NIQU81RmlxUzZGdFRHTzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUtGbHlXdU1wdFUvcFhxMFRyYzY0Tnozd2h5NkV3MXRDOXFOOC9QTlhqT2lP?=
 =?utf-8?B?MGdlTHhYZCttOFJaSHhBU2JRUUNMRzZnU2ttZmZmekg5TXQ5d21HVXFScTQ0?=
 =?utf-8?B?emxLbWI3Uit6UnRwcll0QnIwR0pyV25JMFU5ekVKNG5PaVlmaW9SSTNFZ2Nr?=
 =?utf-8?B?ZnNFenNtUzFjZTJMUTJxa3Z6b2d5aVFkRnNqWDkyUXhUbExkeW91R2svYmdQ?=
 =?utf-8?B?TzNGT3ZuaGY2WWMyTFBVVm16VVRtck4xNjMzNXAySlhPT0ZNTGNBWHovbUVK?=
 =?utf-8?B?aFBQTjZGUGZqc3Vma3FrZ0VBaUVSbnFEeWdFZXJOVlpmZUlsTVZEWHphS1BU?=
 =?utf-8?B?Vis0SkloenA4YXJxWWZCdUwza21tWkhEZFJHWWxLZFhid0cwaUdDUFpBbmF6?=
 =?utf-8?B?TmMwV05Ra1FNVWVwSlVDek9RcDRZUGNUN0pXRmkwVjhJcnVva2F5WURQYWts?=
 =?utf-8?B?SXRQNUQyWGVtWlpaYkFveHVRUjdza25sWXdHdlBUWm9yUTZ2SkdGc1NaM1h1?=
 =?utf-8?B?ZGgyelJQcWFrNXN4V0Uybm1UZnlyVW5PZHF3UDZRRzlqV1VidGJlS1lnN0hh?=
 =?utf-8?B?T2plOHB5NW9vcEUxVlgvMlN6aXVSdzRTYjlPV0lvZi92NXQrcXlWeTJ1Ym9n?=
 =?utf-8?B?VitJdUlVQWMzVzd2KzdTZ1FpOWdEK2lWM0ZvZzlmSGNxN2RVKzltZUJ2Tmkz?=
 =?utf-8?B?RHhLVWJScVhQY3cvUzF6WDNPcUdoVGF3NWdxL1laZTVoR2QxZG1nejNkd0tZ?=
 =?utf-8?B?TGphN0ZaSzQzK1drS2o5SUx5ZUNrc3lsWkVPM29ZVnJQZXlvZ0p2d1VZUmtX?=
 =?utf-8?B?THBqNnhpaXRBTTBnZFVNU085TFVJZ05ycXpSY05ZRTZCdXdqMENTSS82ME5S?=
 =?utf-8?B?c2M0cExKSHFpSG5sOVBmYUNiSERVNGF3dWtKajV0Y1Y4NU9TOW1ZMERHZjBS?=
 =?utf-8?B?T1d0UldxWkxGY0NLUE4vY2RnZEZCUndJbXo5Z0g2RG5tWHdLSCs4QjZzTlc2?=
 =?utf-8?B?ekdZdXgvNDdxWUV3WWJOcHI1T1gvR1dITk5yK3QwSUFXSm5aNkQ1akxCUG9r?=
 =?utf-8?B?Zm44YjBGYmloanRSV2JPbUdqaGh5TCtBcUVSdU9vYWhiWDByTFhtUzZnMXpm?=
 =?utf-8?B?WXFMNjh6SktZOTJIZFcxTXQ3ZEQzcjU1akdmbkZQbXRDNFpHdG5wNDR2eHVX?=
 =?utf-8?B?R1VxaUFra1RySHlJRDRkUENuVk1jOGxsd09XazFyZ0tmNVhVQWttSDFDK3Bk?=
 =?utf-8?B?cDFlaGJmQ21nUDJVK21IN3VTWDJOZTAwOGhRUUxEOVVSQUZOQ01pR2ZlS0JD?=
 =?utf-8?B?MVpvMUNrekxjR2NXQVZXaEVIY0V0Y25BYVFaVFRvQVRPVno0NjZMOTViMkhY?=
 =?utf-8?B?V2VNMnpBMEx1Zm9QNE1MeFBOZGRVVE8rdDZRMDBhZEdmMkYyOXM5Zms1NVJ2?=
 =?utf-8?B?allnUUxhWHpNNm9XNis4blE0U1R6T01VN0s4VmlXU09sMXBGZVp5WVhvaWpN?=
 =?utf-8?B?UkRSQTBxeVdtRURlZHdsdmlsN3hzTVlmN1dXZTZQdGVXb0pUOXQ4em03Ukdz?=
 =?utf-8?B?RUxVMk9ic285Ty9objV6NGVtZmFQOGl5RXNZY1pCaG9QSWZ1YVdwU0dtN0RM?=
 =?utf-8?B?U0JpT1RBM2FDMkIyaE5mYXI0WGZMeEsyc2VobDk0dHo3MlpONVlydmNNbXNH?=
 =?utf-8?B?V1FraXJFaFEvQkp3SjduV3ZVNzJHN0pPLzRQb294WXRNZ2tSRTYrMXpuOWd2?=
 =?utf-8?B?eVdIdzZJOGlvNWttVm5PRWg1M0REVnZtblc3NEs3dzFiK1ZyRTZmVGNOQkti?=
 =?utf-8?B?TklyTEc2N1VjQ1F1VGRzRmhsdzJkeGdjNjVteVBTQzdmSmo4bXdNblpwU2tU?=
 =?utf-8?B?OHQyTkw4OC9pclZldHh4NzRBTGlCNGxJRmtSaERBL1piY2YyY3FrSDRKQVFt?=
 =?utf-8?B?cTI5OFA3Q2FSZXBwT05OVGVXK3VoMFNSUGN1VmhmcXJ3d0NLZHZSYWovYVM1?=
 =?utf-8?B?SkxWQi9oemxTVnBuWkpOankvcHhZRmdOdU5EVytrVkRTSndHTDBZV2hsTmEx?=
 =?utf-8?B?UzVpdC8vSnNMeHhaTXd6c1gzNmRuSWdKcXJSTlF2Mnl4QWQwcE5yaFduaTZt?=
 =?utf-8?Q?HdCUt75NAt296qMlpdNSTy5Gc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87e80cf-ba03-40e3-316e-08dc7b584b1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:43:52.9338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLm4y8Js2Dt4MGLIG2vgzWihm29ZnlhjK2ZE67hDuNY+mrAUN3UqdZWvyzpi+aZXUtXbtgITwrLVuIHHuT2rGA==
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
> Newer assemblers reject S_WAITCNT. All instances of S_WAITCNT can be
> replaced by S_WAITCNT 0 (< gfx12) or S_WAIT_IDLE (>= gfx12) since
> there is no concurrency of different memory instruction classes.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Thanks, that looks good to me.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 140 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  52 +++----
>   2 files changed, 97 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 11d076eb770c..d61b2c3bd0ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -711,12 +711,12 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xbf0d8f7b, 0xbf840002,
>   	0x887bff7b, 0xffff0000,
>   	0xf4011bbd, 0xfa000010,
> -	0xbf8cc07f, 0x8f6e976e,
> +	0xbf8c0000, 0x8f6e976e,
>   	0x8a77ff77, 0x00800000,
>   	0x88776e77, 0xf4051bbd,
> -	0xfa000000, 0xbf8cc07f,
> +	0xfa000000, 0xbf8c0000,
>   	0xf4051ebd, 0xfa000008,
> -	0xbf8cc07f, 0x87ee6e6e,
> +	0xbf8c0000, 0x87ee6e6e,
>   	0xbf840001, 0xbe80206e,
>   	0x876eff6d, 0x00ff0000,
>   	0xbf850008, 0x876eff6d,
> @@ -1185,7 +1185,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x785d0000, 0xe0304080,
>   	0x785d0100, 0xe0304100,
>   	0x785d0200, 0xe0304180,
> -	0x785d0300, 0xbf8c3f70,
> +	0x785d0300, 0xbf8c0000,
>   	0x7e008500, 0x7e028501,
>   	0x7e048502, 0x7e068503,
>   	0x807c847c, 0x8078ff78,
> @@ -1194,7 +1194,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x6e5d0000, 0xe0304080,
>   	0x6e5d0100, 0xe0304100,
>   	0x6e5d0200, 0xe0304180,
> -	0x6e5d0300, 0xbf8c3f70,
> +	0x6e5d0300, 0xbf8c0000,
>   	0xbf820034, 0xbef603ff,
>   	0x01000000, 0xbeee0378,
>   	0x8078ff78, 0x00000400,
> @@ -1203,7 +1203,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x785d0000, 0xe0304100,
>   	0x785d0100, 0xe0304200,
>   	0x785d0200, 0xe0304300,
> -	0x785d0300, 0xbf8c3f70,
> +	0x785d0300, 0xbf8c0000,
>   	0x7e008500, 0x7e028501,
>   	0x7e048502, 0x7e068503,
>   	0x807c847c, 0x8078ff78,
> @@ -1213,7 +1213,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x8f6f836f, 0x806f7c6f,
>   	0xbefe03c1, 0xbeff0380,
>   	0xe0304000, 0x785d0000,
> -	0xbf8c3f70, 0x7e008500,
> +	0xbf8c0000, 0x7e008500,
>   	0x807c817c, 0x8078ff78,
>   	0x00000080, 0xbf0a6f7c,
>   	0xbf85fff7, 0xbeff03c1,
> @@ -1221,7 +1221,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xe0304100, 0x6e5d0100,
>   	0xe0304200, 0x6e5d0200,
>   	0xe0304300, 0x6e5d0300,
> -	0xbf8c3f70, 0xb9783a05,
> +	0xbf8c0000, 0xb9783a05,
>   	0x80788178, 0xbf0d9972,
>   	0xbf850002, 0x8f788978,
>   	0xbf820001, 0x8f788a78,
> @@ -1232,16 +1232,16 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x01000000, 0xbefc03ff,
>   	0x0000006c, 0x80f89078,
>   	0xf429003a, 0xf0000000,
> -	0xbf8cc07f, 0x80fc847c,
> +	0xbf8c0000, 0x80fc847c,
>   	0xbf800000, 0xbe803100,
>   	0xbe823102, 0x80f8a078,
>   	0xf42d003a, 0xf0000000,
> -	0xbf8cc07f, 0x80fc887c,
> +	0xbf8c0000, 0x80fc887c,
>   	0xbf800000, 0xbe803100,
>   	0xbe823102, 0xbe843104,
>   	0xbe863106, 0x80f8c078,
>   	0xf431003a, 0xf0000000,
> -	0xbf8cc07f, 0x80fc907c,
> +	0xbf8c0000, 0x80fc907c,
>   	0xbf800000, 0xbe803100,
>   	0xbe823102, 0xbe843104,
>   	0xbe863106, 0xbe883108,
> @@ -1271,9 +1271,9 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0xf4211cfa, 0xf0000000,
>   	0x80788478, 0xf4211bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8cc07f, 0xb9eef814,
> +	0xbf8c0000, 0xb9eef814,
>   	0xf4211bba, 0xf0000000,
> -	0x80788478, 0xbf8cc07f,
> +	0x80788478, 0xbf8c0000,
>   	0xb9eef815, 0xbefc036f,
>   	0xbefe0370, 0xbeff0371,
>   	0xb9f9f816, 0xb9fbf803,
> @@ -1288,7 +1288,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>   	0x0000ffff, 0xf4091c37,
>   	0xfa000050, 0xf4091d37,
>   	0xfa000060, 0xf4011e77,
> -	0xfa000074, 0xbf8cc07f,
> +	0xfa000074, 0xbf8c0000,
>   	0x906e8977, 0x876fff6e,
>   	0x003f8000, 0x906e8677,
>   	0x876eff6e, 0x02000000,
> @@ -2299,12 +2299,12 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xbf0d8f7b, 0xbf840002,
>   	0x887bff7b, 0xffff0000,
>   	0xf4011bbd, 0xfa000010,
> -	0xbf8cc07f, 0x8f6e976e,
> +	0xbf8c0000, 0x8f6e976e,
>   	0x8a77ff77, 0x00800000,
>   	0x88776e77, 0xf4051bbd,
> -	0xfa000000, 0xbf8cc07f,
> +	0xfa000000, 0xbf8c0000,
>   	0xf4051ebd, 0xfa000008,
> -	0xbf8cc07f, 0x87ee6e6e,
> +	0xbf8c0000, 0x87ee6e6e,
>   	0xbf840001, 0xbe80206e,
>   	0x876eff6d, 0x00ff0000,
>   	0xbf850008, 0x876eff6d,
> @@ -2319,7 +2319,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x0000ffff, 0xbefa0380,
>   	0xb9fa0283, 0xbeee037e,
>   	0xbeef037f, 0xbefe0480,
> -	0xbf900004, 0xbf8cc07f,
> +	0xbf900004, 0xbf8c0000,
>   	0x877aff7f, 0x04000000,
>   	0x8f7a857a, 0x886d7a6d,
>   	0x7e008200, 0xbefa037e,
> @@ -2595,7 +2595,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xe0304080, 0x785d0100,
>   	0xe0304100, 0x785d0200,
>   	0xe0304180, 0x785d0300,
> -	0xbf8c3f70, 0x7e008500,
> +	0xbf8c0000, 0x7e008500,
>   	0x7e028501, 0x7e048502,
>   	0x7e068503, 0x807c847c,
>   	0x8078ff78, 0x00000200,
> @@ -2604,7 +2604,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xe0304080, 0x6e5d0100,
>   	0xe0304100, 0x6e5d0200,
>   	0xe0304180, 0x6e5d0300,
> -	0xbf8c3f70, 0xbf820034,
> +	0xbf8c0000, 0xbf820034,
>   	0xbef603ff, 0x01000000,
>   	0xbeee0378, 0x8078ff78,
>   	0x00000400, 0xbefc0384,
> @@ -2613,7 +2613,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xe0304100, 0x785d0100,
>   	0xe0304200, 0x785d0200,
>   	0xe0304300, 0x785d0300,
> -	0xbf8c3f70, 0x7e008500,
> +	0xbf8c0000, 0x7e008500,
>   	0x7e028501, 0x7e048502,
>   	0x7e068503, 0x807c847c,
>   	0x8078ff78, 0x00000400,
> @@ -2622,7 +2622,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xbf84000e, 0x8f6f836f,
>   	0x806f7c6f, 0xbefe03c1,
>   	0xbeff0380, 0xe0304000,
> -	0x785d0000, 0xbf8c3f70,
> +	0x785d0000, 0xbf8c0000,
>   	0x7e008500, 0x807c817c,
>   	0x8078ff78, 0x00000080,
>   	0xbf0a6f7c, 0xbf85fff7,
> @@ -2630,7 +2630,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x6e5d0000, 0xe0304100,
>   	0x6e5d0100, 0xe0304200,
>   	0x6e5d0200, 0xe0304300,
> -	0x6e5d0300, 0xbf8c3f70,
> +	0x6e5d0300, 0xbf8c0000,
>   	0xb9783a05, 0x80788178,
>   	0xbf0d9972, 0xbf850002,
>   	0x8f788978, 0xbf820001,
> @@ -2641,16 +2641,16 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0xbef603ff, 0x01000000,
>   	0xbefc03ff, 0x0000006c,
>   	0x80f89078, 0xf429003a,
> -	0xf0000000, 0xbf8cc07f,
> +	0xf0000000, 0xbf8c0000,
>   	0x80fc847c, 0xbf800000,
>   	0xbe803100, 0xbe823102,
>   	0x80f8a078, 0xf42d003a,
> -	0xf0000000, 0xbf8cc07f,
> +	0xf0000000, 0xbf8c0000,
>   	0x80fc887c, 0xbf800000,
>   	0xbe803100, 0xbe823102,
>   	0xbe843104, 0xbe863106,
>   	0x80f8c078, 0xf431003a,
> -	0xf0000000, 0xbf8cc07f,
> +	0xf0000000, 0xbf8c0000,
>   	0x80fc907c, 0xbf800000,
>   	0xbe803100, 0xbe823102,
>   	0xbe843104, 0xbe863106,
> @@ -2680,10 +2680,10 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x80788478, 0xf4211cfa,
>   	0xf0000000, 0x80788478,
>   	0xf4211bba, 0xf0000000,
> -	0x80788478, 0xbf8cc07f,
> +	0x80788478, 0xbf8c0000,
>   	0xb9eef814, 0xf4211bba,
>   	0xf0000000, 0x80788478,
> -	0xbf8cc07f, 0xb9eef815,
> +	0xbf8c0000, 0xb9eef815,
>   	0xbefc036f, 0xbefe0370,
>   	0xbeff0371, 0xb9fbf803,
>   	0xb9f3f801, 0xb96e3a05,
> @@ -2697,7 +2697,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>   	0x0000ffff, 0xf4091c37,
>   	0xfa000050, 0xf4091d37,
>   	0xfa000060, 0xf4011e77,
> -	0xfa000074, 0xbf8cc07f,
> +	0xfa000074, 0xbf8c0000,
>   	0x876dff6d, 0x0000ffff,
>   	0x87fe7e7e, 0x87ea6a6a,
>   	0xb9faf802, 0xbe80226c,
> @@ -2731,16 +2731,16 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x8b6eff6e, 0x00000800,
>   	0xbfa20003, 0x8b6eff7b,
>   	0x00000400, 0xbfa2002a,
> -	0xbefa4d82, 0xbf89fc07,
> +	0xbefa4d82, 0xbf890000,
>   	0x84fa887a, 0xbf0d8f7b,
>   	0xbfa10002, 0x8c7bff7b,
>   	0xffff0000, 0xf4005bbd,
> -	0xf8000010, 0xbf89fc07,
> +	0xf8000010, 0xbf890000,
>   	0x846e976e, 0x9177ff77,
>   	0x00800000, 0x8c776e77,
>   	0xf4045bbd, 0xf8000000,
> -	0xbf89fc07, 0xf4045ebd,
> -	0xf8000008, 0xbf89fc07,
> +	0xbf890000, 0xf4045ebd,
> +	0xf8000008, 0xbf890000,
>   	0x8bee6e6e, 0xbfa10001,
>   	0xbe80486e, 0x8b6eff6d,
>   	0x00ff0000, 0xbfa20008,
> @@ -2756,7 +2756,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xbefa0080, 0xb97a0283,
>   	0xbeee007e, 0xbeef007f,
>   	0xbefe0180, 0xbefe4d84,
> -	0xbf89fc07, 0x8b7aff7f,
> +	0xbf890000, 0x8b7aff7f,
>   	0x04000000, 0x847a857a,
>   	0x8c6d7a6d, 0xbefa007e,
>   	0x8b7bff7f, 0x0000ffff,
> @@ -3007,13 +3007,13 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x857d9972, 0x8b7d817d,
>   	0xbf06817d, 0xbefd0080,
>   	0xbfa2000c, 0xe0500000,
> -	0x781d0000, 0xbf8903f7,
> +	0x781d0000, 0xbf890000,
>   	0xdac00000, 0x00000000,
>   	0x807dff7d, 0x00000080,
>   	0x8078ff78, 0x00000080,
>   	0xbf0a6f7d, 0xbfa2fff5,
>   	0xbfa0000b, 0xe0500000,
> -	0x781d0000, 0xbf8903f7,
> +	0x781d0000, 0xbf890000,
>   	0xdac00000, 0x00000000,
>   	0x807dff7d, 0x00000100,
>   	0x8078ff78, 0x00000100,
> @@ -3034,7 +3034,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xe0505080, 0x781d0100,
>   	0xe0505100, 0x781d0200,
>   	0xe0505180, 0x781d0300,
> -	0xbf8903f7, 0x7e008500,
> +	0xbf890000, 0x7e008500,
>   	0x7e028501, 0x7e048502,
>   	0x7e068503, 0x807d847d,
>   	0x8078ff78, 0x00000200,
> @@ -3043,7 +3043,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xe0505080, 0x6e1d0100,
>   	0xe0505100, 0x6e1d0200,
>   	0xe0505180, 0x6e1d0300,
> -	0xbf8903f7, 0xbfa00034,
> +	0xbf890000, 0xbfa00034,
>   	0xbef600ff, 0x01000000,
>   	0xbeee0078, 0x8078ff78,
>   	0x00000400, 0xbefd0084,
> @@ -3052,7 +3052,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xe0505100, 0x781d0100,
>   	0xe0505200, 0x781d0200,
>   	0xe0505300, 0x781d0300,
> -	0xbf8903f7, 0x7e008500,
> +	0xbf890000, 0x7e008500,
>   	0x7e028501, 0x7e048502,
>   	0x7e068503, 0x807d847d,
>   	0x8078ff78, 0x00000400,
> @@ -3061,7 +3061,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xbfa1000e, 0x846f836f,
>   	0x806f7d6f, 0xbefe00c1,
>   	0xbeff0080, 0xe0505000,
> -	0x781d0000, 0xbf8903f7,
> +	0x781d0000, 0xbf890000,
>   	0x7e008500, 0x807d817d,
>   	0x8078ff78, 0x00000080,
>   	0xbf0a6f7d, 0xbfa2fff7,
> @@ -3069,7 +3069,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x6e1d0000, 0xe0505100,
>   	0x6e1d0100, 0xe0505200,
>   	0x6e1d0200, 0xe0505300,
> -	0x6e1d0300, 0xbf8903f7,
> +	0x6e1d0300, 0xbf890000,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
> @@ -3080,16 +3080,16 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0xbef600ff, 0x01000000,
>   	0xbefd00ff, 0x0000006c,
>   	0x80f89078, 0xf428403a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf890000,
>   	0x80fd847d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0x80f8a078, 0xf42c403a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf890000,
>   	0x80fd887d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0xbe844304, 0xbe864306,
>   	0x80f8c078, 0xf430403a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf890000,
>   	0x80fd907d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0xbe844304, 0xbe864306,
> @@ -3119,10 +3119,10 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x80788478, 0xf4205cfa,
>   	0xf0000000, 0x80788478,
>   	0xf4205bba, 0xf0000000,
> -	0x80788478, 0xbf89fc07,
> +	0x80788478, 0xbf890000,
>   	0xb96ef814, 0xf4205bba,
>   	0xf0000000, 0x80788478,
> -	0xbf89fc07, 0xb96ef815,
> +	0xbf890000, 0xb96ef815,
>   	0xbefd006f, 0xbefe0070,
>   	0xbeff0071, 0xb97bf803,
>   	0xb973f801, 0xb8ee3b05,
> @@ -3136,7 +3136,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>   	0x0000ffff, 0xf4085c37,
>   	0xf8000050, 0xf4085d37,
>   	0xf8000060, 0xf4005e77,
> -	0xf8000074, 0xbf89fc07,
> +	0xf8000074, 0xbf890000,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
>   	0xb8eef802, 0xbf0d866e,
> @@ -3657,16 +3657,16 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x8b6fff6f, 0x00000200,
>   	0xbfa20002, 0x8b6ea07b,
>   	0xbfa2002b, 0xbefa4d82,
> -	0xbf89fc07, 0x84fa887a,
> +	0xbf8a0000, 0x84fa887a,
>   	0xbf0d8f7b, 0xbfa10002,
>   	0x8c7bff7b, 0xffff0000,
>   	0xf4601bbd, 0xf8000010,
> -	0xbf89fc07, 0x846e976e,
> +	0xbf8a0000, 0x846e976e,
>   	0x9177ff77, 0x00800000,
>   	0x8c776e77, 0xf4603bbd,
> -	0xf8000000, 0xbf89fc07,
> +	0xf8000000, 0xbf8a0000,
>   	0xf4603ebd, 0xf8000008,
> -	0xbf89fc07, 0x8bee6e6e,
> +	0xbf8a0000, 0x8bee6e6e,
>   	0xbfa10001, 0xbe80486e,
>   	0x8b6eff6d, 0xf0000000,
>   	0xbfa20009, 0xb8eef811,
> @@ -3682,7 +3682,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xbefa0080, 0xb97a0151,
>   	0xbeee007e, 0xbeef007f,
>   	0xbefe0180, 0xbefe4d84,
> -	0xbf89fc07, 0x8b7aff7f,
> +	0xbf8a0000, 0x8b7aff7f,
>   	0x04000000, 0x847a857a,
>   	0x8c6d7a6d, 0xbefa007e,
>   	0x8b7bff7f, 0x0000ffff,
> @@ -3869,7 +3869,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00000080, 0xbf800000,
>   	0xbf800000, 0xbf800000,
>   	0xd8d80000, 0x01000000,
> -	0xbf890000, 0xc4068070,
> +	0xbf8a0000, 0xc4068070,
>   	0x008ce801, 0x00000000,
>   	0x807d037d, 0x80700370,
>   	0xd5250000, 0x0001ff00,
> @@ -3878,7 +3878,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xbe8300ff, 0x00000100,
>   	0xbf800000, 0xbf800000,
>   	0xbf800000, 0xd8d80000,
> -	0x01000000, 0xbf890000,
> +	0x01000000, 0xbf8a0000,
>   	0xc4068070, 0x008ce801,
>   	0x00000000, 0x807d037d,
>   	0x80700370, 0xd5250000,
> @@ -3954,14 +3954,14 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x8b7d817d, 0xbf06817d,
>   	0xbefd0080, 0xbfa2000d,
>   	0xc4050078, 0x0080e800,
> -	0x00000000, 0xbf8903f7,
> +	0x00000000, 0xbf8a0000,
>   	0xdac00000, 0x00000000,
>   	0x807dff7d, 0x00000080,
>   	0x8078ff78, 0x00000080,
>   	0xbf0a6f7d, 0xbfa2fff4,
>   	0xbfa0000c, 0xc4050078,
>   	0x0080e800, 0x00000000,
> -	0xbf8903f7, 0xdac00000,
> +	0xbf8a0000, 0xdac00000,
>   	0x00000000, 0x807dff7d,
>   	0x00000100, 0x8078ff78,
>   	0x00000100, 0xbf0a6f7d,
> @@ -3983,7 +3983,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00008000, 0xc4050078,
>   	0x008ce802, 0x00010000,
>   	0xc4050078, 0x008ce803,
> -	0x00018000, 0xbf8903f7,
> +	0x00018000, 0xbf8a0000,
>   	0x7e008500, 0x7e028501,
>   	0x7e048502, 0x7e068503,
>   	0x807d847d, 0x8078ff78,
> @@ -3994,7 +3994,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00008000, 0xc405006e,
>   	0x008ce802, 0x00010000,
>   	0xc405006e, 0x008ce803,
> -	0x00018000, 0xbf8903f7,
> +	0x00018000, 0xbf8a0000,
>   	0xbfa0003d, 0xbef600ff,
>   	0x01000000, 0xbeee0078,
>   	0x8078ff78, 0x00000400,
> @@ -4005,7 +4005,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00010000, 0xc4050078,
>   	0x008ce802, 0x00020000,
>   	0xc4050078, 0x008ce803,
> -	0x00030000, 0xbf8903f7,
> +	0x00030000, 0xbf8a0000,
>   	0x7e008500, 0x7e028501,
>   	0x7e048502, 0x7e068503,
>   	0x807d847d, 0x8078ff78,
> @@ -4015,7 +4015,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x846f836f, 0x806f7d6f,
>   	0xbefe00c1, 0xbeff0080,
>   	0xc4050078, 0x008ce800,
> -	0x00000000, 0xbf8903f7,
> +	0x00000000, 0xbf8a0000,
>   	0x7e008500, 0x807d817d,
>   	0x8078ff78, 0x00000080,
>   	0xbf0a6f7d, 0xbfa2fff6,
> @@ -4025,7 +4025,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x00010000, 0xc405006e,
>   	0x008ce802, 0x00020000,
>   	0xc405006e, 0x008ce803,
> -	0x00030000, 0xbf8903f7,
> +	0x00030000, 0xbf8a0000,
>   	0xb8f83b05, 0x80788178,
>   	0xbf0d9972, 0xbfa20002,
>   	0x84788978, 0xbfa00001,
> @@ -4036,16 +4036,16 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xbef600ff, 0x01000000,
>   	0xbefd00ff, 0x0000006c,
>   	0x80f89078, 0xf462403a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf8a0000,
>   	0x80fd847d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0x80f8a078, 0xf462603a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf8a0000,
>   	0x80fd887d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0xbe844304, 0xbe864306,
>   	0x80f8c078, 0xf462803a,
> -	0xf0000000, 0xbf89fc07,
> +	0xf0000000, 0xbf8a0000,
>   	0x80fd907d, 0xbf800000,
>   	0xbe804300, 0xbe824302,
>   	0xbe844304, 0xbe864306,
> @@ -4075,19 +4075,19 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x80788478, 0xf4621cfa,
>   	0xf0000000, 0x80788478,
>   	0xf4621bba, 0xf0000000,
> -	0x80788478, 0xbf89fc07,
> +	0x80788478, 0xbf8a0000,
>   	0xb96ef814, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf89fc07, 0xb96ef815,
> +	0xbf8a0000, 0xb96ef815,
>   	0xf4621bba, 0xf0000000,
> -	0x80788478, 0xbf89fc07,
> +	0x80788478, 0xbf8a0000,
>   	0xb96ef812, 0xf4621bba,
>   	0xf0000000, 0x80788478,
> -	0xbf89fc07, 0xb96ef813,
> +	0xbf8a0000, 0xb96ef813,
>   	0x8b6eff7f, 0x04000000,
>   	0xbfa1000d, 0x80788478,
>   	0xf4621bba, 0xf0000000,
> -	0x80788478, 0xbf89fc07,
> +	0x80788478, 0xbf8a0000,
>   	0xbf0d806e, 0xbfa10006,
>   	0x856e906e, 0x8b6e6e6e,
>   	0xbfa10003, 0xbe804ec1,
> @@ -4106,7 +4106,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x0000ffff, 0xf4605c37,
>   	0xf8000050, 0xf4605d37,
>   	0xf8000060, 0xf4601e77,
> -	0xf8000074, 0xbf89fc07,
> +	0xf8000074, 0xbf8a0000,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
>   	0xb97af804, 0xbe804a6c,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index cb619e49228c..77ae25b6753c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -55,9 +55,11 @@
>   #if ASIC_FAMILY < CHIP_GFX12
>   #define S_COHERENCE glc:1
>   #define V_COHERENCE slc:1 glc:1
> +#define S_WAITCNT_0 s_waitcnt 0
>   #else
>   #define S_COHERENCE scope:SCOPE_SYS
>   #define V_COHERENCE scope:SCOPE_SYS
> +#define S_WAITCNT_0 s_wait_idle
>   
>   #define HW_REG_SHADER_FLAT_SCRATCH_LO HW_REG_WAVE_SCRATCH_BASE_LO
>   #define HW_REG_SHADER_FLAT_SCRATCH_HI HW_REG_WAVE_SCRATCH_BASE_HI
> @@ -364,7 +366,7 @@ L_FETCH_2ND_TRAP:
>   	// ttmp12 holds SQ_WAVE_STATUS
>   #if HAVE_SENDMSG_RTN
>   	s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
> -	s_waitcnt       lgkmcnt(0)
> +	S_WAITCNT_0
>   #else
>   	s_getreg_b32	ttmp14, hwreg(HW_REG_SHADER_TMA_LO)
>   	s_getreg_b32	ttmp15, hwreg(HW_REG_SHADER_TMA_HI)
> @@ -377,15 +379,15 @@ L_FETCH_2ND_TRAP:
>   L_NO_SIGN_EXTEND_TMA:
>   
>   	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 S_COHERENCE		// debug trap enabled flag
> -	s_waitcnt       lgkmcnt(0)
> +	S_WAITCNT_0
>   	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
>   	s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
>   	s_or_b32        ttmp11, ttmp11, ttmp2
>   
>   	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 S_COHERENCE	// second-level TBA
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 S_COHERENCE	// second-level TMA
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_and_b64	[ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
>   	s_cbranch_scc0	L_NO_NEXT_TRAP						// second-level trap handler not been set
> @@ -460,7 +462,7 @@ L_SLEEP:
>   	s_sleep		0x2
>   	s_cbranch_execz	L_SLEEP
>   #else
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   #endif
>   
>   	// Save first_wave flag so we can clear high bits of save address.
> @@ -794,7 +796,7 @@ L_SAVE_LDS_W32:
>   
>   L_SAVE_LDS_LOOP_SQC_W32:
>   	ds_read_b32	v1, v0
> -	s_waitcnt	0
> +	S_WAITCNT_0
>   
>   	write_vgprs_to_mem_with_sqc_w32(v1, 1, s_save_buf_rsrc0, s_save_mem_offset)
>   
> @@ -814,7 +816,7 @@ L_SAVE_LDS_WITH_TCP_W32:
>   	s_nop		0
>   L_SAVE_LDS_LOOP_W32:
>   	ds_read_b32	v1, v0
> -	s_waitcnt	0
> +	S_WAITCNT_0
>   	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
>   
>   	s_add_u32	m0, m0, s3						//every buffer_store_lds does 128 bytes
> @@ -832,7 +834,7 @@ L_SAVE_LDS_W64:
>   
>   L_SAVE_LDS_LOOP_SQC_W64:
>   	ds_read_b32	v1, v0
> -	s_waitcnt	0
> +	S_WAITCNT_0
>   
>   	write_vgprs_to_mem_with_sqc_w64(v1, 1, s_save_buf_rsrc0, s_save_mem_offset)
>   
> @@ -852,7 +854,7 @@ L_SAVE_LDS_WITH_TCP_W64:
>   	s_nop		0
>   L_SAVE_LDS_LOOP_W64:
>   	ds_read_b32	v1, v0
> -	s_waitcnt	0
> +	S_WAITCNT_0
>   	buffer_store_dword	v1, v0, s_save_buf_rsrc0, s_save_mem_offset V_COHERENCE
>   
>   	s_add_u32	m0, m0, s3						//every buffer_store_lds does 256 bytes
> @@ -1073,7 +1075,7 @@ L_RESTORE_LDS_LOOP_W32:
>   	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1	// first 64DW
>   #else
>   	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   	ds_store_addtid_b32     v0
>   #endif
>   	s_add_u32	m0, m0, 128						// 128 DW
> @@ -1087,7 +1089,7 @@ L_RESTORE_LDS_LOOP_W64:
>   	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset lds:1	// first 64DW
>   #else
>   	buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   	ds_store_addtid_b32     v0
>   #endif
>   	s_add_u32	m0, m0, 256						// 256 DW
> @@ -1132,7 +1134,7 @@ L_RESTORE_VGPR_WAVE32_LOOP:
>   	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128
>   	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128*2
>   	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:128*3
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   	v_movreld_b32	v0, v0							//v[0+m0] = v0
>   	v_movreld_b32	v1, v1
>   	v_movreld_b32	v2, v2
> @@ -1147,7 +1149,7 @@ L_RESTORE_VGPR_WAVE32_LOOP:
>   	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128
>   	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128*2
>   	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:128*3
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_branch	L_RESTORE_SGPR
>   
> @@ -1166,7 +1168,7 @@ L_RESTORE_VGPR_WAVE64_LOOP:
>   	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256
>   	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256*2
>   	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE offset:256*3
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   	v_movreld_b32	v0, v0							//v[0+m0] = v0
>   	v_movreld_b32	v1, v1
>   	v_movreld_b32	v2, v2
> @@ -1189,7 +1191,7 @@ L_RESTORE_SHARED_VGPR:
>   	s_mov_b32	exec_hi, 0x00000000
>   L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
>   	buffer_load_dword	v0, v0, s_restore_buf_rsrc0, s_restore_mem_offset V_COHERENCE
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   	v_movreld_b32	v0, v0							//v[0+m0] = v0
>   	s_add_u32	m0, m0, 1						//next vgpr index
>   	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 128
> @@ -1204,7 +1206,7 @@ L_RESTORE_V0:
>   	buffer_load_dword	v1, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256
>   	buffer_load_dword	v2, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256*2
>   	buffer_load_dword	v3, v0, s_restore_buf_rsrc0, s_restore_mem_offset_save V_COHERENCE offset:256*3
> -	s_waitcnt	vmcnt(0)
> +	S_WAITCNT_0
>   
>   	/* restore SGPRs */
>   	//will be 2+8+16*6
> @@ -1221,7 +1223,7 @@ L_RESTORE_SGPR:
>   	s_mov_b32	m0, s_sgpr_save_num
>   
>   	read_4sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_sub_u32	m0, m0, 4						// Restore from S[0] to S[104]
>   	s_nop		0							// hazard SALU M0=> S_MOVREL
> @@ -1230,7 +1232,7 @@ L_RESTORE_SGPR:
>   	s_movreld_b64	s2, s2
>   
>   	read_8sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_sub_u32	m0, m0, 8						// Restore from S[0] to S[96]
>   	s_nop		0							// hazard SALU M0=> S_MOVREL
> @@ -1242,7 +1244,7 @@ L_RESTORE_SGPR:
>   
>    L_RESTORE_SGPR_LOOP:
>   	read_16sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_sub_u32	m0, m0, 16						// Restore from S[n] to S[0]
>   	s_nop		0							// hazard SALU M0=> S_MOVREL
> @@ -1291,22 +1293,22 @@ L_RESTORE_HWREG:
>   	read_hwreg_from_mem(s_restore_xnack_mask, s_restore_buf_rsrc0, s_restore_mem_offset)
>   	read_hwreg_from_mem(s_restore_mode, s_restore_buf_rsrc0, s_restore_mem_offset)
>   	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_setreg_b32	hwreg(HW_REG_SHADER_FLAT_SCRATCH_LO), s_restore_flat_scratch
>   
>   	read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)						//from now on, it is safe to restore STATUS and IB_STS
> +	S_WAITCNT_0
>   
>   	s_setreg_b32	hwreg(HW_REG_SHADER_FLAT_SCRATCH_HI), s_restore_flat_scratch
>   
>   #if ASIC_FAMILY >= CHIP_GFX12
>   	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
>   
>   	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
>   
>   	// Only the first wave needs to restore the workgroup barrier.
> @@ -1317,7 +1319,7 @@ L_RESTORE_HWREG:
>   	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
>   
>   	read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0, s_restore_mem_offset)
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
>   	s_cbranch_scc0	L_SKIP_BARRIER_RESTORE
> @@ -1364,7 +1366,7 @@ L_SKIP_BARRIER_RESTORE:
>   	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x50 S_COHERENCE
>   	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x60 S_COHERENCE
>   	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x74 S_COHERENCE
> -	s_waitcnt	lgkmcnt(0)
> +	S_WAITCNT_0
>   
>   #if HAVE_XNACK
>   	restore_ib_sts(s_restore_tmp, s_restore_m0)
