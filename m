Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F1CCA471
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 06:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA9510E1A4;
	Thu,  9 Oct 2025 06:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HppMdVHk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8F610E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 06:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDnEG/qMifVUPghXiEeOEyGd6i+JRrP6n+TZSedJUO1MU/I/8K0QR0pk2nDMtxWyzT2xJ9jpIFx1S7SANgmy7F1uCpio4wCmcMNwI/9tXb4Gp/9dOYk8gj22zi0o5ogubb+jGIexQrf3e0dHpF3UQ3ClPsJode98jHwBK7Hs6oumVYxbIk3/jmxkEMuyGS2iMZDkXWdlmjryt4k7yrrOC91p28YcHJa2yxqOlflhvMHUCjdelkmuCOWj2OhbTXWU08ODko/6BUYnM441XtXZa/03YUn+io/EgB6YZUIOml8EcK/029B/zG0ihswUbAWZyEOpU9daq3jw5twHOmHYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=411nkhi0BFWGA7PT+bTiZ40tWy3fo1KEj4cyQbTa5fc=;
 b=fgMXwVX+2mtiqOFiiQH3pfBurYObVKM/snzYabCl+0OKPli5JssdRmuzzWNv8WdiH+/560Cy4sMa1v/Wy3hnkgUnYkqr+4Z8GIYlR7MLQH1ac7SV+PmN8tNCKy2MMWBPXNrntWWOeemZxW8S4m0nh61/TCooSqF5YB3SMqKtE1DQrO0QMxYqB9yLnr6QlQhumpMEqaXmXNa0UbRPrRacv78f2gONHhcWo9X8WiTgoka1Zh5A9V4ikhCpSJWA+KPufi+QEjY6G073UGyMsYmL2ixZB+v+mEJoBCXNAWY6mGXJ+6rTqX1ABY9oChKk+t5N4SEcF92bbpG8BjZHLjX4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=411nkhi0BFWGA7PT+bTiZ40tWy3fo1KEj4cyQbTa5fc=;
 b=HppMdVHk+9kDsA3ItHmJRWcV0jDHVbcU9+n03jI6n43cIRq8+rhlQro7r2I6aYdPxcRs61Dvy3ZXyz7RoDl+mhAk6iqLkR6w9P2URfD2/LKtK9GR++gT1T8Z5B0Or76TRBda1w9H5+nRpoe3FhsziO6/5MMrRPoK6wHTr4dIW1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:00:44 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 06:00:44 +0000
Content-Type: multipart/alternative;
 boundary="------------VEclJ2vZ580J0x0fegWy06sP"
Message-ID: <c42a04b3-bafa-448f-bf01-7c0e12f44e3a@amd.com>
Date: Thu, 9 Oct 2025 11:30:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: hide VRAM sysfs attributes on GPUs without
 VRAM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20251007091925.18470-1-christian.koenig@amd.com>
 <c729abf1-6147-4f24-b67e-95ee912ca330@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <c729abf1-6147-4f24-b67e-95ee912ca330@amd.com>
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 006087aa-9e1d-487a-7276-08de06f92ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnBoZmxRVFR2SFY0R2ZDRmVZT2NQVURnMktZU2lwWGZ3MUlEd0lkdFlOY1dY?=
 =?utf-8?B?WDZXNlREdXA5b0cxby9FWlZSQ21jWlRLMFJ5enVhQmZVTDJTcXd4a3BUa2F5?=
 =?utf-8?B?SHF3Y3NhOEZSYVowM01MK1NGUTYzUUZySzUzelI2am9hcmJaMUFWZVdWSmJD?=
 =?utf-8?B?ell2S1E5akNoUmcyU1pMVldJRFBsN2QxSWdhYXEwNzNTYzdxTHErWUpKYkd4?=
 =?utf-8?B?WHdqWFE4akZMZWFuNFEvWk9EWHFGMllPR0IrS0kvTkFya3UvUWdSRjNhVTlW?=
 =?utf-8?B?OEQ1RXJ3RWRNZ1AwcGNDanVWZysybGRTN09GblFaS0Y3Qk41Zm1TUjBZSjVz?=
 =?utf-8?B?WEpESk9Ya0g2ZmQ4cG5GbU5ZeHJMd0owU2FUWk05L25FRGNWTnExeFhFZjht?=
 =?utf-8?B?S0d0djVEVHNhcDJIYThwOXZTd0doMThzUUxLeWtpZVJvTVBGYkpkTHNhUGdv?=
 =?utf-8?B?MFhTeEdNNkNFQ3lCQzFHNGpYWURSUWJycDFpRjFycFRMSUFNMTNITEZrSGh3?=
 =?utf-8?B?VGdvekJtUm5TWXVHRDBtcmkrOUNBeWh0OTYzQ3Y5SnRCMnJva0pad0ViZUtL?=
 =?utf-8?B?OFJNMW5wU2lCZlpJZWZxdVNlcEF5Yy8wWjFXNVFQRVV6UFhJSXEvaW1Wc3Bm?=
 =?utf-8?B?a0JXbm8yMXk3MjQxaGw1NUYyRlMzdjZIelJ4SUwvSHNSNTFPR3VyTysvQlZz?=
 =?utf-8?B?K2YzWjBHRnBHeEFUeEtRZkxyNXRsTGFMMzl1bVZDMkFYeGdqb0lscHFpajRR?=
 =?utf-8?B?UlRZQkhJdFNLMXpxU3FvMldra2dQeG5jeHk0WFB3NmthK2ZGL2pXUEpyeE5a?=
 =?utf-8?B?OUVsSmZETzRvR1hMZ0x3SjIvUzIwQzFBZ0w4Rk9ibzBEUEJIN2JtQWhKa2ly?=
 =?utf-8?B?ZldubmZlRThBNjNHSFVpT0xPbnl1dzlhb3FoUWlpVzV6NG84dkNOeWNQcTFH?=
 =?utf-8?B?dDk1U1V1SnpHdHp5b1VNbEx5RzZvTUV3bnBGVGMwUG1mSmhOY0ZGTUxCdUdQ?=
 =?utf-8?B?a0hpNW1lYnByU0U3d0djWFdMdjY1M2hYbFdIUS9LRDB0bGl2Q3dOVENTQkVk?=
 =?utf-8?B?N3Q3QXc5QXRCV055MGFoRExSU1IzSkR5dmFPSkh6Y01tNHpWZTQrdFl6aWYz?=
 =?utf-8?B?SUlHUlR3dlZyaTNML0JBS25DRWdzcEoycS9WV3NSNkkrWHR6QmVEQjNIa21y?=
 =?utf-8?B?UkZnc3lXbGJWeGpzRUM2OGFWWkRVNjZBVmpPOUlXYytXdzlmeGFsUEpWMDBa?=
 =?utf-8?B?NzdwSFZ0NWlhK1J6WlVVUkhYckM1T0dPWUV6aFNDS29wUXFoS2tFWXlTY2xO?=
 =?utf-8?B?dEhsMjBmTVFIMVIwWWV4WmJjTHdaZXNoM3g1K1pRc0pPN3psRFlrc1ZEQkl3?=
 =?utf-8?B?K0FlTSt6blExc2hRbVNHcWRSSVhFNDg4Mnh0Nk9Yalc5anlQdy9rWk1aUVUr?=
 =?utf-8?B?ZUt5RFhCUnB3ZzdFMUdDTnREdDU4a3hqK3dzYytvZWJlSGRWNjlsVWR0K2lJ?=
 =?utf-8?B?Mnl5bzdRQmJKZmg5TFFzUi9OOHRmbThzSGJzYTNNRUdBRFpuVnFvNkRFT0Ns?=
 =?utf-8?B?K2dCckh5Zzg5MHJ2YTNxT0ZnR0RiMzYvQlVId3JHeWMwRS9ETWVIWWZUZFps?=
 =?utf-8?B?VEhrQzJhZ1M1NnhlSFVXNGY3YjBvUncwVlk4clJNTkk1aTZlTVZBaVZ4cWNq?=
 =?utf-8?B?blZDZ0ZEOGUrV25NdTBuVDhtV3Jxa3piZlBHR0dmZnJEMEdkQy96bFhtMUpZ?=
 =?utf-8?B?SUdmeE4yNnFrL1drci9lNHErVlgzd09MOXVETHFFTDhWK2FCWmRlbHUrR1VC?=
 =?utf-8?B?NmsyTDhQc3RTMVVwVDVseURuWDZOOEkzb3AzOStRY3hKalZpeDJldWNOa0pq?=
 =?utf-8?B?SjdjQVY5M0hWdlRPc25vRm1CVnp2VG9DMmIvR1lpdVhWUDhKcWdMOFE4Rlpq?=
 =?utf-8?Q?FgTUWdXwzpNqpZP67OqoN1TjRDSaefm1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDg3YUMyaDVGc0hleVB2azZFbm9MWEhsRHl3ZWNmdmN1eG1nc3lIa0V5WFZi?=
 =?utf-8?B?aGl4WWtpU29RSXFyN2xjaXlSb0FBUXJjRjlKanNXdWwreDdXYzVvR1IyNENo?=
 =?utf-8?B?aG9LN292Y09Ba0tNdGJIa2oxbXRNdlhudTZJck80YXp2RmtWTFZmOVdjTWNI?=
 =?utf-8?B?c1Z3VThSTDdhdnRQM3hwTUFBemJlaGxXM0lpSEF4dGlmL25ZM0RZWitpbmlO?=
 =?utf-8?B?WTVsN2MzcjN1aFp3dVRsL3ZITDBncWhITitPellGcG5uZEtsOXNTakZickty?=
 =?utf-8?B?MnFVdmRobEhoeWZXVXhLZ2xzaUpuV0hrWVZqSDU2NmVZdFBVb0JrUHNUOW5Y?=
 =?utf-8?B?NnIwQk9zWmh0QnRWWnNINmZaQm01MEtGQmw1ZnNjOGJBRktzeHlPeDd6WFEw?=
 =?utf-8?B?RGE0cUlFam0xOE5YOW5PNmk2cTROK1Y5WThGOEhRL1pFdVJMbUVoVHQzUnl1?=
 =?utf-8?B?VnZSUjlMeWlmaVh0eFJVVW9UZEw4bndyOFJrRUFyWmFUZHdmV2ZUWXhheXRk?=
 =?utf-8?B?TWhSd3hGa0dPeHZjUC9rQmJoTVR1dkJXQkFWVGFWRUR1aGlUd01uMi92cUJ1?=
 =?utf-8?B?K0tGbnBocUg1OXJTemw5WERzcDc5K0J2bHRPaHYveHBzSklGeHlLUjE1NXpG?=
 =?utf-8?B?aHQ3TzFaZ2VLTzVjWGFncWU1cUNKOWhTQjk0cHRZUmZPd0FIQWs2Rkw4c2Fm?=
 =?utf-8?B?eFI0a1NzN0VuYzNnS0RybmVjQXdxVVh3MFRybUVIa2M0SW5FbGpCYUVsY2hH?=
 =?utf-8?B?YjI4Q2EwWG5kVE5GdHFvRVJvUnJDbVFQZzBDSDJHd3pOQjh0YlJ4REdlRDR4?=
 =?utf-8?B?SEh1WC9CMkVsZWkvMzFnQWVpbU0yQlY5a05kUU5mWlUwc1gwVG51Ry8vWlJH?=
 =?utf-8?B?TTd0L0RROTdVYlZXMEJuWHRyZW9hYS9UZDUyTFpsQlFqQXhPY0Q3cE9reXp2?=
 =?utf-8?B?MVRpdFJ3WWp2eGh6NENwcS9xQnRYd01SR3FTZHJ6dStCd2xpTVhWcUhTd2Nz?=
 =?utf-8?B?S2JjTFRnZUIrZWRpUkoza2lrdTRuWUhqZnZleWRkRlB6OFJTK2w0YjZxWEVa?=
 =?utf-8?B?TitiaTRSRThhcGZLaFp3WUg0WkJXclNwM0xUd0FUL3pDZFo2T0VrZ1B6QzYy?=
 =?utf-8?B?REFVNzdhTFRpSXF6ZGpNWG44U0t2bkwzb0s0UmxRb25vODNpZmNLeThpNzBZ?=
 =?utf-8?B?OHZOQXZYajdjVGtuQVNaMm5QVnh2Wkxud1ZlU1paNHhza2ZjZy9hNEpIb0c3?=
 =?utf-8?B?RWJZQ3h5MmNsMllFVFlwRkd2V0JScHFacXJsTVFoNEJ2YSs3aTJyZkk5d0Jw?=
 =?utf-8?B?Nmt1YW0vSk9NM2dkQ0dnQXZuOFNNdEZFS3VlRldzN0dOUDhEUlNRa2gzZjVL?=
 =?utf-8?B?Zkl5K09oTjYwRkJtMm9wYWZvY3hTb0hGcjBTUk9PQUt4cDdGdnRhMy9LeElj?=
 =?utf-8?B?N0hsU3Rhbi9ORVFnWktFL2UrSmQvbkxWajJNVXIxZUljN3ZFYkJHS3RrZzRP?=
 =?utf-8?B?aFNhMFEzWnNKSHRweFhOTkEyVDk2cWhJbERXSitvQmRtUjlwTnl5L2RtZGlC?=
 =?utf-8?B?Q3dFWEY0YVR2TkszMDJZNlRNek54U0E4QUNDaU1QTzltVFRweDJ0UXhOUTFP?=
 =?utf-8?B?b2dJN1dWMnN2VHhDZGxjbmN4SElBRWJZY0hvbzlVZ1VLVnZTcHBDTEFjSFd6?=
 =?utf-8?B?bm51SHBQcXRFU090aDBEQlluWEZ5eVptL2dITlpFWGFvQ2hqK1ZTaE8yTFZU?=
 =?utf-8?B?cno2eDU1VmlpQkdtRFljcDVpWDhvUTVwaS9FYmhTZGhFZHc0dVk3RFZaSGh2?=
 =?utf-8?B?UmRVSWprYnRucW0wcURvT2JwQWc4M2h4UDVjTi82eFA5WFp4RVdtU2N1aVpw?=
 =?utf-8?B?VnpEeXpUTlBCZ09qNThRTDJ0bWhUZENLRWdMakdrR1doSzNMZXd2TU9uOEM3?=
 =?utf-8?B?SFFjZnEvdTUrNjJ4ZCtQcjFaNi8wdjU0NzVnMldRbmdUTE9JUjhiSGxnb1VZ?=
 =?utf-8?B?MkdFUXVRMXh5NjdnVWZHWEUzMUtPVERaQVQ1Z0d3Y0RCL1ZCKzNaYXpSNDlT?=
 =?utf-8?B?YXRkN0hma2MyaTV5bk1rK2o0bHQ3VTlPQlFZekQ1ZWtVZVBvYW9MZnVpTGhK?=
 =?utf-8?Q?fmB0QrOKN3fj/n4Qqrhm6Rmfc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006087aa-9e1d-487a-7276-08de06f92ef4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:00:44.2646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSXf+rvCWfMwr5trlxXtg3PofxI4h8KQJk1Z1mfYBe13c2BkvN+42LXDRtw0m4T4So4aiNJhbC4KEQFviE9ziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

--------------VEclJ2vZ580J0x0fegWy06sP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

No problem. The patch looks good.

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Thanks,
Arun.
On 10/8/2025 8:30 PM, Christian König wrote:
> Arun sorry I should have CCed you in the first place.
>
> Please take a look as well.
>
> Thanks,
> Christian.
>
> On 07.10.25 11:19, Christian König wrote:
>> Otherwise accessing them can cause a crash.
>>
>> Signed-off-by: Christian König<christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index a5adb2ed9b3c..9d934c07fa6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -234,6 +234,9 @@ static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
>>   	    !adev->gmc.vram_vendor)
>>   		return 0;
>>   
>> +	if (!ttm_resource_manager_used(&adev->mman.vram_mgr.manager))
>> +		return 0;
>> +
>>   	return attr->mode;
>>   }
>>   

--------------VEclJ2vZ580J0x0fegWy06sP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Christian,<br>
    <br>
    No problem. The patch looks good.<br>
    <br>
    Reviewed-by:
    Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;<br>
    <br>
    Thanks,<br>
    Arun.<br>
    <div class="moz-cite-prefix">On 10/8/2025 8:30 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c729abf1-6147-4f24-b67e-95ee912ca330@amd.com">
      <pre class="moz-quote-pre" wrap="">Arun sorry I should have CCed you in the first place.

Please take a look as well.

Thanks,
Christian.

On 07.10.25 11:19, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Otherwise accessing them can cause a crash.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index a5adb2ed9b3c..9d934c07fa6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -234,6 +234,9 @@ static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
 	    !adev-&gt;gmc.vram_vendor)
 		return 0;
 
+	if (!ttm_resource_manager_used(&amp;adev-&gt;mman.vram_mgr.manager))
+		return 0;
+
 	return attr-&gt;mode;
 }
 
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------VEclJ2vZ580J0x0fegWy06sP--
