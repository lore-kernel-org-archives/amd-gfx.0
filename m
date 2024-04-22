Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1CC07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8075112AA1;
	Mon, 22 Apr 2024 13:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8ajif/n";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFB4112AA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:01:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAM7CX/FUPzd+cgJO5hyHlZwf2jQHW7Xy2X9AYuMcfWlScxaOyPjPdZV6E8aTmk8wXA28Y2BN4/0SAdiCDVxk0bDz0062VtpQqXQ7DjpzrtBJbHPfrVjK0MnQjXICwUwkB+wngcbAYG0sAzMrJcE36BgtjbsKuKEsnoVbe+ZhDd5Pz5t1ed4JoO5oms7BrnA/ub5o49cpk/i5cLOCGJ5hBQyWCA4fOblZYD0+FwQt2GquzTCAsc6z9ah9Tlc57FZUf4w1148MWrmpf2bHFMOAO83c8G9+sXRqTtf9uKe+oQvYiBE606hEiLLMrUmoC0Zy5QpVCT9kIxEmSgpTmpMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXLj6esYzHecEzTc1J96BpXQjivu85ZOsAmqNztCG8w=;
 b=kFHhAALE5dGOZswr/9SN8twniMNiwKeyojHWFyek1W/64Ai1t9+50MzhsPIw3lgFqi9Iv9bTqdoB5mG5jzo/3z/M32rjS+tDX0o1be+KobiX56j5+pfT5rmxbD0ubSDGuJd/Usu3cspMgRta0fbMejVD4a1bHgOXH2l1jxO+GeNZGwjJYnh/tN5o4cxyDwYur+p+QeTEofPVMearHjFSJknQhG26FEbiOeUYIeTkaPhOHOC0H6HvnC/2XY/4Y5WZS1vvY6YEjhOMCX7efS+lsCTtEwN/moZ4I/IpUf2TUn1WmbKuSMUF1Bm9OmKwajuIDJ0JFC5/ju4XyF64sBKPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXLj6esYzHecEzTc1J96BpXQjivu85ZOsAmqNztCG8w=;
 b=v8ajif/nns/rSFd8ZsLT5UFn32y4kSY8ZtzpkXUGCTPbXYgxYCQRbh6r44aJuRxSycoEAmCBVJDAj3a+O29fUIdpn9FMIaH339U14RNHzXnwhAS56zKKnmzwS9/Mkwja2DoCbwntV5bwK/6xbKnSFAIRL+bgRzWAca20VIQeCzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:01:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:01:48 +0000
Message-ID: <53f1e368-5ca5-4630-9b66-0f807e885b62@amd.com>
Date: Mon, 22 Apr 2024 18:31:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix snprintf buffer size in
 smu_v14_0_init_microcode
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Li Ma <li.ma@amd.com>,
 Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
References: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
 <20240419154452.237393-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240419154452.237393-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: de74e476-ed8f-4e96-a776-08dc62cc5ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVFjaWk4aFp6UURTa0pNczIxeC9wWVV1WnM4dnlyMTZwQ3NUVXBYNEFaVkRY?=
 =?utf-8?B?RTk4Wk9yMkYxRWVoQmRHck9wL3M4WGlxcll1YlR3ZENoNE80a2hTOU51N0x3?=
 =?utf-8?B?R3ZienUycFAyKzlaSGJwNnlnZm9NdmxkT05acGkyOUJsRTJlVU9Hb3FFdGky?=
 =?utf-8?B?UWlhdWhLL0pTUGp4cUt3Mlh4THdQS3AzVXhvdmRXdkNQc2V1d3A5QWlYZW0y?=
 =?utf-8?B?TjVTdzdIcC83V09Ia1BUaUE2RDVGWml0ajQ0RGNkMXpLaTZyaE9WclNGMmM4?=
 =?utf-8?B?WE8zbXgxMXpLMnVBZ3hTOW45T3RDNG9JM1BwbVlZQTNXQ2tWbHFjVXdTeEpP?=
 =?utf-8?B?YlhvSkFRcGY5TDM2MGk4VC9oQWRDT0tGc2UrWlJ5Sm9adzhIVGVGeFFGbWlj?=
 =?utf-8?B?dUYvZUE3dVlydktmVytoTFZneVNPeEdKWDRzcjUvR3RpYnBzR3JwSmlnWGt3?=
 =?utf-8?B?d3pjejBRNG44bnczeStJZUZOYUgwZktKMkoxdGxMYzJJbXp1cFBuZHJaNStF?=
 =?utf-8?B?N0UrSEhVZlRuM2N2Tm5kWkFNdVovQys0eThWVGdhV3BHZDcxbXlldWZQcGNG?=
 =?utf-8?B?SW5WajBnVnV6TnV1NVUvWHEzQ1R2YnlpNHYwb1BVWXhwVTk4bWF3UTFqNGpP?=
 =?utf-8?B?SzQxTjVaS3lUSnJQRmkzOUhGLzkzNnhwcWRvRUJ5ZDNqN1J0bDlKYTdKOG5X?=
 =?utf-8?B?dFR4amtGZDlCMjNsYWg5VlhwZ2ovUzBoS05scktUcmpaaFFRUkxCT3ZhOVhr?=
 =?utf-8?B?YndvT2g0bVo4TW5rQU9qOXVhWDJyYUtzNzczOXBRODJOR1p6Y29lV3M4WGpY?=
 =?utf-8?B?YUF3ZVMxRWtIT3FrUUFQRTAybEVZNG83NVhKVXlINkx2cGgzcHhBU2djT0F0?=
 =?utf-8?B?d093YU5xY3h2Ry9qQnFkWWNLeVFXUEV5WFhGd1lIMFMrbnZqVnpOVy8wZldZ?=
 =?utf-8?B?TWJ5a2syT0pCTEwwS0F0c1FRcmFtQlBIS0hGYUp0TllNL1N2ejVOajU1L2Iy?=
 =?utf-8?B?ZHJOS1RsancwZU0zdTlrK3pURkU4T2VoZ3p6SzlFWkUwVTIrSlZFV3pNUko1?=
 =?utf-8?B?YnY0b1ExSkpYZjNFNW8zWjBmQ2FhNFlRVjgxWlJxZVU2bWxOUVdGeWxIT0tn?=
 =?utf-8?B?bEhzeGs1MW8xODUzWjJWVnYzcGkycEM4WkczdGl5Y1pVUTZoNENKUkIwbU1I?=
 =?utf-8?B?cUZrcTNIUWY4bzR3WFRReDgySnVnSFgzVWFGRG14WWxDUVRMVXBJRk9GdHN6?=
 =?utf-8?B?WjB2UVFwM1NPUW9IRFE1M2ttSlRFekkrNGRFS2p2d1VVa2RDZGV5d1JsUUg4?=
 =?utf-8?B?UFN3ajIvdU1XT2QybWFOemZDN2wxWUFoTEZtL1JkSnhpZjd5VlIzN1IrVWxJ?=
 =?utf-8?B?QzJJMEE5Vy9aelRjNENianUxdGttRG5xbnM2clg4V1RXVldoZVNSMzBpS3A5?=
 =?utf-8?B?bS96bi9lSjZvN1NzWlUxWlFoN0doKzRaOGt3RmNEeEsvaG1YN0t1M1ZXanhT?=
 =?utf-8?B?VVphR09rYkU3eGRpK3YxVVM4ZmJHOXFBUGt5dzVxZzNjOTJwSXNVT0xQQ3ZT?=
 =?utf-8?B?WnhqQlRpL1l2Kzl0S29ZdVJLb29nY3drdFhrVXFHR3luM0djMkZoVTJSUDFw?=
 =?utf-8?B?QWFQRkdrM0dVR2dNU1lSRm9GTDliQmt3OW10N0V0ZmpiKzZsOE4xcXhKc1RH?=
 =?utf-8?B?cUhMb2t2UXEzWURhNGtnR0JKSWFZTnArNTA5dkRZUkh3VjdHdWM3SXZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFQNFRRRU50SjVXdGVJQ09sQmEyS0U1QnJ0V1dvMHlLWk1BajFMY2w2eStt?=
 =?utf-8?B?dzhzenc3QXlaaHBWRjFkSS9CaEpOS2taZ2FDcFZYWHFDM3BpY1BsUHQzNEJP?=
 =?utf-8?B?SU41QWQ1MUs5UDZpSmRYTk92YlNidFNBOUttbzM5WDdoZC9PK0lCc0R3eXYv?=
 =?utf-8?B?RGlZTkllbmVQVlBUNHJMYWFqOGpwaGJkZE5wZElWQUpxQlVyMDdXMEhOVGhy?=
 =?utf-8?B?aFhPMEhzL2V2NjM2MkFkMytHb0VWSmRMaGxJRXZoRFJZKzhWL3UyNko0NmtH?=
 =?utf-8?B?NTR2bU9aYTdSaC9NTTBmQWtsUE0xd3RUM294ekRXbTRwa1FzMGJUUSt3SWNl?=
 =?utf-8?B?RDRMekUwZVROaGlwN3IwSWsyNm5ZazhzVmdhOEFyZ2VKSGtFN3Y2RUV2c0Q0?=
 =?utf-8?B?bnlMc2lubGFrYjNBQ2xodmM3NExrRXlWeDNvQWNIR21PR3A4azVmbW1PdFBj?=
 =?utf-8?B?Z1NVMm8wNU5TUFZ5N2RNMnlVQjIwOER5cU9ZOWk5VzJSd0pKS1A3ajNzOEFX?=
 =?utf-8?B?VHVBVjU5QzNPRGtsOEhSeEJkZHFxeVplZHU2ZzJ6SE40Z0tPYnlVeWRPRlFL?=
 =?utf-8?B?aGNmSnVWSitQdTE2d2M0eVgrVlFmUXlRWDhoZHYyNDgyLzdYdHdIWVdZNFhN?=
 =?utf-8?B?cHNWbkFEbDR2emlHbzNDK2RHeXlxTGtkSUtCYm9hTGsxMGVSV040UEo1VmNq?=
 =?utf-8?B?SVFUU3h5UjNSZUNYV3E4MDZPOEoyT2ozblNVelJKSnl0MlJ2TVZLK3ljbmFP?=
 =?utf-8?B?U0NDbFNFdFNuUGtLY2JQM1djUWRkZDh4Qy85YmhlenRGenNHak9IdFNjWkpv?=
 =?utf-8?B?aHYxQ3FGdGhucTVzd3A1WlV5Rnl5LzVvdjMvL21iRlIzVUdzU2RvTzNMeHEz?=
 =?utf-8?B?d0RrbmRKdzNDbGNmRjAydlZ5MUxkTS9qRUJERmI5Vm96VlFRelBRMkxHZGNY?=
 =?utf-8?B?S1JHczZoVUswV3duMVppK29SMHlZY1I4MUNiVTh5ZjhwblZmdVNyMVNGeXIv?=
 =?utf-8?B?czd3Z1A0Zy9nbXZDVHhNRzBJV2psK1V6UEttNWRTNlJIQkZxZy9yOEZrMyt0?=
 =?utf-8?B?V2poUC9EdmxMWGNoOXhRMWZ1Y3JlL2lPQ0pTVFJuaTgxSkFibFdPSk0rZVFP?=
 =?utf-8?B?aHlVKzVXSGlGcmYvRW8vK0RPdy9yczBJcTgvZ3ZsVE1qUEYxcldwUWtIdHNu?=
 =?utf-8?B?eTdlTjRDbTF0akZGbGNjemZia0pRWEhBR3NHYWNOKzh1WFV1NlNUanNjMzJa?=
 =?utf-8?B?SmoydG1uVjdjMWZocGZJeEVEa1VXTmw1Q2RQZlkwd1d3SW5HQy9jTWN0RGFU?=
 =?utf-8?B?RXE0SGQ5MUkwUGdZejgrRE5ETEREMVdQbWQ0ZmFkQ3VLNWY3QmdOYzNaVXBV?=
 =?utf-8?B?VXg3bllnVmlHUWFSc1BTN3YycUtLdmdwTi9tVkE1VUZhejhJT2V5ZS85Z29i?=
 =?utf-8?B?NktGSWpkVVBPakhqd25jZmJlQzFMaXI1RG8wNlpOOGRuZCtLUlk2eXNqcWpB?=
 =?utf-8?B?T2NyR2FUT1ZkZ2VVRGxVc3hQdUZxZCsrTlE5dC81R3didEpIUFc0Ni8xT25t?=
 =?utf-8?B?M0tCeGJzc0hLZ09FOUdCRE1weGJSdFptaldNMERmdzVWZjBJVXAwWTdLWW5j?=
 =?utf-8?B?UnYxZFhROXFjdVFQQ2s0L3U0bE43bU1RODZ1YVp4K2FXMWt4ZFhMSTJVMHUx?=
 =?utf-8?B?N1hsdkkxOTVzSSt2SzZIZy96ai9RcW5xWGNLRUYvTFZJL1VucTR3SnJ6Nlc4?=
 =?utf-8?B?YjgrK0dXeGIxbHpWM3lsdDZhdFV6R0c4VTVBSXE3OTVrZTlvUU4vMG1ycWZL?=
 =?utf-8?B?RXIya0dhb3V2cC9pRGd3T1Q5N2lMcmlUdUZ4cnZDLy80ZXVCSVZVRTJ3MVA1?=
 =?utf-8?B?YklxUHhmMStQaTNzaDdpZXQ0YnBPZHFhb0pkNXlYdWs2VXRXOCtjbTJNYXhm?=
 =?utf-8?B?cEk4Z2k0MGxMRWdFSmhpYUhWam51MTl3OEJKTGRvS0krNkJVSVdsOUpCN1gw?=
 =?utf-8?B?ZTlrenZwckVNcWRrckNTNWZrYThOd3lxblRab3hoWVNTN0lFcXNnLytyZlB0?=
 =?utf-8?B?ZncySWk0R0cyMUxxWklMeUJ1ZnhBRHM3S2p5NFJMZVUwemF3UHdLNUthb2hV?=
 =?utf-8?Q?46SeKVq1OpBrKkuxiwr0MRxLW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de74e476-ed8f-4e96-a776-08dc62cc5ec0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:01:48.6523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Jfy03A4uWhFLLdWZOTAjFI0CatRkNZCbiLYed/jQXcyMzsvDkgQL+a7novv110V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
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



On 4/19/2024 9:14 PM, Srinivasan Shanmugam wrote:
> This commit addresses buffer overflow in the smu_v14_0_init_microcode
> function. The issue was about the snprintf function writing more bytes
> into the fw_name buffer than it can hold.
> 
> The line of code is:
> 
> snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> 
> Here, snprintf is used to write a formatted string into fw_name. The
> format is "amdgpu/%s.bin", where %s is a placeholder for the string
> ucode_prefix. The sizeof(fw_name) argument tells snprintf the maximum
> number of bytes it can write into fw_name, including the
> null-terminating character. In the original code, fw_name is an array of
> 30 characters.
> 
> The string "amdgpu/%s.bin" could be up to 41 bytes long, which exceeds
> the 30 bytes allocated for fw_name. This is because %s could be replaced
> by ucode_prefix, which can be up to 29 characters long. Adding the 12
> characters from "amdgpu/" and ".bin", the total length could be 41
> characters.
> 
> To address this, the size of ucode_prefix has been reduced to 15
> characters. This ensures that the maximum length of the string written
> into fw_name does not exceed its capacity.
> 
> As smu_13/14 etc. don't follow legacy scheme ie.,
> amdgpu_ucode_legacy_naming
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c: In function ‘smu_v14_0_init_microcode’:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>    80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                    ^~       ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu14/smu_v14_0.c:80:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 30
>    80 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
> Cc: Li Ma <li.ma@amd.com>
> Cc: Likun Gao <Likun.Gao@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
> v4:
>  - Reduced ucode_prefix to 15 instead of fw_name size increasing as
>    smu_13/14 etc. don't follow legacy scheme ie.,
>    amdgpu_ucode_legacy_naming (Lijo) 
> 
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 7d2055b9d19f..68b9bf822e8d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -65,7 +65,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
>  	char fw_name[30];
> -	char ucode_prefix[30];
> +	char ucode_prefix[15];
>  	int err = 0;
>  	const struct smc_firmware_header_v1_0 *hdr;
>  	const struct common_firmware_header *header;
