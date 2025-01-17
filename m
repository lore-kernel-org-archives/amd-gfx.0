Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6F6C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 06:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9F610EA56;
	Fri, 17 Jan 2025 06:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpyVZhXM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F40110EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 06:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNCjAR4GOOHuFSd2xLajKX+SOMFuWh/8GiS5eSAj2r4pBmgsTZw24HCziZYhhnTfpmyg62e+HoJebg/yG7a+KYgVm0YeTAve9wPsAoen3ODk6+fLemEg348tF1vn1Jx0p0yNoXhNOKBdU2g3E73KtMdoDOJ5Lbo8DirOEQnasKbQfzDRztL+HEABblX3ERIAQwSsc08Gp9P8aY+q56/lffZR1QUxFx7wvN8aFs1U20+/KTX3+jYsHC+lSm1zCLNT3yhbJ9ERbh0tEkGX6VKtuGUhnWmB0+g13VvIHaeg4XnxlVCnxVXDBgYRTtWw4EqO3W8mkF888kAj+lZeWU44+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qr1nHtq7J8AtTsGT48a5SF5tpNstwOD3O1ry0seLGLA=;
 b=a2AejnAC1gMFHG4JQL58swsQnqNV8KdvpylR3SGmM0PNsf3QMYP++MHRUJzi7jaj+MbDiD1B3aH7zHVWE411wxdxJaQQCk7oE1Z4G+BMVo922LlC2rTtsZf9IMKKwJ/6b8D3RcRNkorj3xWF34tRTISQNDNDv8rauNvF/Ocyiyj9t0A4jpJenxEt6cmyv067qiqYZ0fBDWSBkCYVKwd9O0xS4DFCbeVzMFHba6zOIbEuCrT5dtyzf/0iBiFBmMRYK9tXeA6Z9Uj2bX6WCC4TKkBIl2PSx8rnlb7mfzT5jR2jSUHSILsNKglnpHK6xEIfpimE8pviAOtw40OqERi4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qr1nHtq7J8AtTsGT48a5SF5tpNstwOD3O1ry0seLGLA=;
 b=XpyVZhXMUBY76iFWSnI6jADA2Vy533+uGM0vdyUAEpATO9nXAtMwykc5o/rFiK8yGGdaRpQY1hrf6YDOuef9WnFIa8baoahzFEOKwItAFH9IpR716V/Gku25inXY7T0Zmm1xWHo8HDnE3/yuj/bkujvDBARiq5HYX9c8Ojdu9YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 06:09:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 06:09:59 +0000
Message-ID: <633e6872-7a5b-415e-a617-ecd2e59e83ae@amd.com>
Date: Fri, 17 Jan 2025 11:39:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 06/15] drm/amdgpu: enhance amdgpu_ras_pre_fini() to
 better support SR
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org,
 Tao Zhou <Tao.Zhou1@amd.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <d07f0c4ed71a8f4b3e6194881f7cc00826240951.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d07f0c4ed71a8f4b3e6194881f7cc00826240951.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1e4c32-7ee9-4972-14a9-08dd36bd9266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1dySUJWRFYxWVJnSVB3OWxKZEVSMzJXN1B4N2M0d3duQnVLODF2MFhFQ0di?=
 =?utf-8?B?Z3UrVjdsOXQ5TStYMmVselQrV1g4OFNLNllpczNTZVNTSDQ5U25sK3kvSFRu?=
 =?utf-8?B?eWM1YTk1UW41cUFzdVliUGd5V3djaDN6OEVYdmFZc1JzWXFoa3BmeSs4L0lV?=
 =?utf-8?B?V3FFRGcvSFFGdjE4V3NsbHlaKzNGdEtwNHJMOExCNzJaUWhpbGpwaTJ3andv?=
 =?utf-8?B?R0x6cnNWby9na0J4a1RQcDluL2dSK2RsZ2FTYndUSlB4TytrejNxKzd1eUY5?=
 =?utf-8?B?QmIxRjhyaWNMbjJBckROZDdKRU9WWlVCUnBseGxONUJPUk9HTldYbWM2REk4?=
 =?utf-8?B?U1pLWTRhLzJ1dW45L2dkR0xOSEl6YjVsbGtLVlV3Y25HWlNQeHhPKzcrVUNL?=
 =?utf-8?B?a2hmNWUyM0NKaE95UnBXaTZicjBmZXlCNm5XSFdlNU1pZWVQK2cyT1IxME4x?=
 =?utf-8?B?dENRVkVtcWpzNmdtU25hMUtXcURlbHZMV1p3cWlYSFRxTDlnSjYxamhlY0dP?=
 =?utf-8?B?bEVWaU1McmhIRjhLdFgvT2tvcUVKQ1NiQUkva251c2ZjT2l1TzNrWjZVNUxJ?=
 =?utf-8?B?aFhXYjhDb29xM2NRbmhuRDZaNTBYc2tma2RjYXlKUWhuTkxMRU9rTU13bGF5?=
 =?utf-8?B?SXJzMjFiRXI2V1YzNXp3bDUyQkdjSkE4T29ZSjVFSHJXYU9CR0ZUNVlzazhj?=
 =?utf-8?B?eHVHNTJ4TmN0T3JaWlRkSy96YUs4UjFrbzVEaXMvTk1ET1FUeWhaSVR2NU91?=
 =?utf-8?B?SkFKSEYwQzVlQXQ2dklRN1l0N2NTREtMU0RkTEpPMFl3dTI5U2VQekdGS0VL?=
 =?utf-8?B?d0ZlUmFhWU4wem94NHFmc3pISG8zeGVqRno2bmV6TXNaOElkU0xkRExZSFJC?=
 =?utf-8?B?c2NvN1I1UWl0WGQ2bDZwTWEzV3VKb2JsN2VRMExJbDJCMXJhTll1dVR5cFUy?=
 =?utf-8?B?emZCQmtxb3h6N08rRmxTYTk5UTgrWmdwaWI1bytZM2RTaGRNeWcwSW5SRzBi?=
 =?utf-8?B?TmR2T05RQkVJTlZWNndQYzZHNkhRaUdHZmZ2SHR6U0F6aTJHYjdmL3VIc2FI?=
 =?utf-8?B?NWUyR3pGM254WGZLMGV2K3dacGo3MkRrdm8zUmVnNjFQbHRjZ1JqRjgybEtG?=
 =?utf-8?B?NENybHVaQW9KeG1xbTluUVFDUVAyYTViL1UzTmJjRkllSDNWV0VxSzNscm5p?=
 =?utf-8?B?b1puVjRLanFMeGQ5bHFPUWZuRTJaZ3JqcTUrSU1EcXgrZEhGWTVxRzFZUUk4?=
 =?utf-8?B?dXNabi9kZjdWZ0lBTFhreW9hYmxLSmx3all6ck9RdnFrajh2WlF1K0JGTHJs?=
 =?utf-8?B?YWFtZUtXSGhtWC9ub0pabzlIdUZBTEoweXlhNGtsckluK3pYTWpiWGV4L1hv?=
 =?utf-8?B?WmVHa0Npd1pyQVNVL3E4ZVo0RVZLYkRmemtzUkMxZERZclNPS1ViYS9jWGRU?=
 =?utf-8?B?d0xyUk1hM0RLbnBXa3Y5YnRvZWVZR1gyZUxmWFFrQ0NKMVdSbnpGaWlTcWNy?=
 =?utf-8?B?Zmx1WHJONEdReVJiZ2s0OWQrKzdtdmxGemtQcjZYNk80NytSOFNraTc4REhW?=
 =?utf-8?B?ekttZEFJTmhUWnRXUlo5cFBDajZPL2ZsTFhHdC8xZUFleXJHcmZKNGxWSVc2?=
 =?utf-8?B?ZzZubUt2L1o4ajFVMVlJWkFTYjBHTW1kWkYxWDl3MHZJTjE3Z0Jpd1BGSXQ5?=
 =?utf-8?B?WC9pMTM5YzUvVGdVRXY1cld1eFBEaXJ0c3ZJcG0yRkNqVzRKT2p2Q2FPVWwx?=
 =?utf-8?B?d0tmNGtEMmh3T2h1YzEzSlVkcEZmcUxFTjlXdDFzQThLeUVxUEQzNHJLWjVT?=
 =?utf-8?B?dXFGQjl0VlVTaXhaWlFDbFhPejBGWm1PelRxdGdLZGhhMHdkK2RqQ1lBT2Vx?=
 =?utf-8?B?aTVIWFVkbXJCNGlWVTBaaFRHb2o1dWZtZW9nYWFhcnJ3STVYTWswb1V6Q2JK?=
 =?utf-8?Q?mNaKftAOwpw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym50VkZZTUorRzRXY09BMnpya2pMZGhnN3g1eWtla3JGYUw5eUN2Q0ZOQ21F?=
 =?utf-8?B?RitlSEd5cWNMUDRqZnJzT1F2dGlFYXZvdGZzSldENVFac3NGTU5IRkhIMEtZ?=
 =?utf-8?B?b2t0SDVpMlJZM2lBOGg5Wlc2WVJLemlxNUpKOEJRQzJTZy9HOFVvMmM1anRo?=
 =?utf-8?B?Wit0dEh4K2lQdGgrTCtBb1pQWU1zS1hqaEJqaFpjVDdQRXFVdHU4SjhmcWM0?=
 =?utf-8?B?cndSWnVBV1o5dXpBL05HT1Z6T3NLdG9rbHNTRjd0ZFY2b3UwSy9GZUo0U2lX?=
 =?utf-8?B?eWw1bWlLZXdSV2pPdks5YUZXOXNlOHhmcmx3WEhGR2NGZXM3Sy8ySEk2czIz?=
 =?utf-8?B?dkwvMEJ2UVhlay9sSEFJNTRWQm5ZcTlZdGZOZmZrRWpKRGpYaUxIV09vRUF3?=
 =?utf-8?B?ZENvQXVKQWpxcDArenRQUDZvT3dvY082d3NyVWlRZGhzOHBNM3BNTTBFcGpL?=
 =?utf-8?B?OTc3NWVDdGJzbVVOUFYwQjcwdkcxMW5IWDFraDhrRlM0VHJBTkNiRmhHNE9t?=
 =?utf-8?B?bEoxZUZzNDdkRlV4Nm9ZT2dqaFFRZW92V1VxV2F0VHpLMVgycnNQNWZ2V0M4?=
 =?utf-8?B?cHJCcVpvRVVNSFlqeVdnVmh6Q1dlLy93eWpUT3lBWTNxV0NOWDRUUTJHSGVM?=
 =?utf-8?B?NEVFNTlOVC8veWFHR2FWQTBNdlRLYnhocFNZdk5xNlorL2hQUWM2SXQxNUgz?=
 =?utf-8?B?eFo1UUtoSCtWdVNaM2k0M25LWWpqVDN3ay8vZ3oxbUpRcTUvTTMvZjlTczky?=
 =?utf-8?B?WVF4YWVlYTVhM1loY05ZMVMvRTU3K1pjcXd6ME9qUStHNGRTak1RQmtQN25J?=
 =?utf-8?B?ZTlYalNJbHFlWHJNTW9rZUtabEI2MXNOeDF4OE1ESWNsSzFBTXdtcERKZTBK?=
 =?utf-8?B?S2hNNEJRdEtLa20yQUp3N1lMc09jQWRKa0dTMGozMHRnZUZMWFVGbWhTZkYv?=
 =?utf-8?B?V2dEMzdtNDNsZ3NaVlVhcFdtUXRtWTVZZzJPOWxHZkl2TFpDN2w4dkFWNjlJ?=
 =?utf-8?B?c0E1T2c5SWtReDljbGhtVHBWeDJBRDlObEU2c2U4SGpWaG9zdGpjMk9TUGN2?=
 =?utf-8?B?R0NaZ1UwYUpaYzV1bU9SaGlCaXV5eFNLbHZ1WFQ5ZVdBUkFLUW1SVGRxU1hR?=
 =?utf-8?B?ckxRZFpxUzZ2d0FZenVndDlqR1JtbkpGK1MzUEhiMHBUWk5PeTQwbFJhSWZ4?=
 =?utf-8?B?WFZUN1N1YWtEa1BoZlFRT1htM2JVMXdlM3RINHlWekFUNzZyNTQrOVlkdW9F?=
 =?utf-8?B?UWNPV1pIV1hNdWkvZnBpM2JMK0pOWHllem11RGtkaW9tMVRpcGxIYTNwUGpJ?=
 =?utf-8?B?ZTlmQWRvbmh3T2RranNjM21jOVVyYmJEMEtxRnIwNldPbU1walJBQkJWTFdV?=
 =?utf-8?B?dXhMOEdPTDR1TS9NVUpLZE5XcEcxbTJ0Tyt2ZS9PN3o5K2JmTUJscUdCU2tX?=
 =?utf-8?B?SmdldFQ2Z3JWVWJjRnZ0aVdWdWRlYTVKRmZuQ3Q3WkR0TEZza2YzU3Uyd0tO?=
 =?utf-8?B?UDdHUDBJMy9TWC9uY1JiUW92QURRRjYyZ04yVkI4Skp3WExtZFFZRklJN1Fv?=
 =?utf-8?B?a1YrSzMvcklEbHg2dDZhcXgvR3QzSzIxaHc0TTFicUVCR2hSbkJzenVsTEpp?=
 =?utf-8?B?VkIzcU1aSkltUEVhbWJCT3phcFRGR1gzUE9sZG5TNitDR0l2RHZiUzVkek9k?=
 =?utf-8?B?bVFac0VGNHBiQnJtYldCSjQwKzFwREN0RFRuNnRWV1oxc2tjdlRBR2NBY0xR?=
 =?utf-8?B?WmNET09sNTJ0a01wZUY4Yjd4d1dnRHJpWCtIS3N4WUdqTmVzZFJJTytaME5X?=
 =?utf-8?B?bTlRMFp0anE0MFVyVzJJOUlVYmNNQjdTamxNTnlFUGVlQW9kejhlSFFQdUlY?=
 =?utf-8?B?amZBN1pSbDRwZWwzVGNQc2tYLzhPSlhqUitjNEw3Vk5DOHFxZEROc3RvYTlm?=
 =?utf-8?B?MlVWZVN6Qk1ocG5sUEJGV1VUc3VJNExpdkhGck9yTjVFNExUZDg3dFcvOVU5?=
 =?utf-8?B?VklOc25pSzVBUTFUQ0JTcmJLdERlZ29YajFURlgvb2s3ZWNiSUlOdVhkd05R?=
 =?utf-8?B?QVpaKzQ0V1hBdDFKaFYwSThjL0lRQjkzUzlTaEsxL0xvc004ekRVU09rWTlU?=
 =?utf-8?Q?uO8oi7FEAb5XzBQjjKSWGQAHA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1e4c32-7ee9-4972-14a9-08dd36bd9266
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 06:09:59.2588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HvtgFSW7ltCBymKKVFDj600wDRGNMBy/pfrq4DrMTFxUeo2ndQKN1CFAfViqpUF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Enhance amdgpu_ras_pre_fini() to better support suspend/resume by:
> 1) fix possible resource leakage. amdgpu_release_ras_context() only
>    kfree(con) but doesn't release resources associated with the con
>    object.
> 2) call amdgpu_ras_pre_fini() in amdgpu_device_suspend() to undo what
>    has been done by amdgpu_ras_late_init(), because amdgpu_device_resume()
>    will invoke amdgpu_ras_late_init() on resume.
> 3) move amdgpu_ras_recovery_fini() from amdgpu_ras_pre_fini() to
>    amdgpu_ras_fini()
> 4) move calling of `obj->ras_fini()` from amdgpu_ras_fini() to
>    amdgpu_ras_pre_fini().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 44 +++++++++++++---------
>  2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0a121aab5c74..2bfe113e17c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4613,6 +4613,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	return 0;
>  
>  release_ras_con:
> +	amdgpu_ras_pre_fini(adev);
> +	amdgpu_ras_fini(adev);
>  	if (amdgpu_sriov_vf(adev))
>  		amdgpu_virt_release_full_gpu(adev, true);
>  
> @@ -4627,8 +4629,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		adev->virt.ops = NULL;
>  		r = -EAGAIN;
>  	}
> -	amdgpu_release_ras_context(adev);
> -
>  failed:
>  	amdgpu_vf_error_trans_all(adev);
>  
> @@ -4921,6 +4921,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  
>  	cancel_delayed_work_sync(&adev->delayed_init_work);
>  
> +	/* disable ras feature must before hw fini */
> +	amdgpu_ras_pre_fini(adev);
>  	amdgpu_ras_suspend(adev);

Based on the usages above, it makes more sense to keep
amdgpu_ras_pre_fini as a static function and call in
ras_fini/ras_suspend (contain the calls at ras layer and avoid another
new public interface).

Copying Tao to take a look.

Thanks,
Lijo

>  
>  	amdgpu_device_ip_suspend_phase1(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7bbab7297c97..5ac63f9cffda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4270,42 +4270,49 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
>  int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_block_list *node, *tmp;
> +	struct amdgpu_ras_block_object *obj;
>  
> -	if (!adev->ras_enabled || !con)
> -		return 0;
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
> +		goto disable;
>  
> +	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
> +		obj = node->ras_obj;
> +		if (!obj)
> +			continue;
> +
> +		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
> +			continue;
> +
> +		if (obj->ras_fini)
> +			obj->ras_fini(adev, &obj->ras_comm);
> +		else
> +			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> +	}
>  
> +disable:
>  	/* Need disable ras on all IPs here before ip [hw/sw]fini */
> -	if (AMDGPU_RAS_GET_FEATURES(con->features))
> +	if (con && AMDGPU_RAS_GET_FEATURES(con->features))
>  		amdgpu_ras_disable_all_features(adev, 0);
> -	amdgpu_ras_recovery_fini(adev);
> +
>  	return 0;
>  }
>  
>  int amdgpu_ras_fini(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ras_block_list *ras_node, *tmp;
> -	struct amdgpu_ras_block_object *obj = NULL;
>  	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>  
>  	if (!adev->ras_enabled || !con)
> -		return 0;
> +		goto out_free_context;
>  
>  	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> -		if (ras_node->ras_obj) {
> -			obj = ras_node->ras_obj;
> -			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
> -			    obj->ras_fini)
> -				obj->ras_fini(adev, &obj->ras_comm);
> -			else
> -				amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
> -		}
> -
>  		/* Clear ras blocks from ras_list and free ras block list node */
>  		list_del(&ras_node->node);
>  		kfree(ras_node);
>  	}
>  
> +	amdgpu_ras_recovery_fini(adev);
>  	amdgpu_ras_fs_fini(adev);
>  	amdgpu_ras_interrupt_remove_all(adev);
>  
> @@ -4323,8 +4330,11 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
>  
>  	cancel_delayed_work_sync(&con->ras_counte_delay_work);
>  
> -	amdgpu_ras_set_context(adev, NULL);
> -	kfree(con);
> +out_free_context:
> +	if (con) {
> +		amdgpu_ras_set_context(adev, NULL);
> +		kfree(con);
> +	}
>  
>  	return 0;
>  }

