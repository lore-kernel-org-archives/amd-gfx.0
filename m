Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C6ACCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB10310E969;
	Fri,  3 Oct 2025 18:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqsjxCUI";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C2D10E965
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD+c9+N0rZ/IC7e6AVF3FBg4B4WIl5vw9UYHW6WlKyc75nIXPQXzhP+KB7/m0K+cNV5Ezs8XQLYnWY/L3b/seZlvGgYzz48QB2gmB5QuRN5dMoF6n5mox41jrwuCdmDu0bmzmAu/u8k/uvPax4vUWY4YCoiZlrAaPTSl1f4UUSXMLMGVj6mxBqlDs79gFy/l9imLkaxFfaIeS+xXxFPrS0zYlHm4kq6S50SFUhzoa1WTsxVshzmnM7D+fNIP/nJCDRVLyjrEOrbX4LILlT8hVM7C+ou1IoCszpMQO79q+5fbeAad1JUF3+5f4r7injRXSPZepu4EQv0DuKIuUkvuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B0oK9peJ1xGnlF1zHUmkNhySLsRKnd37WtCocTsxCI=;
 b=pbHQ1bSuNTyTq9zwOFTkGJZ+LwbobW23Ywg6+H7w1ns7vDig2L80ncmrfJA6Id2gsRzXTJxUP0v/shrc3O9nsl800VFX1jMeaMI5TnlgtqaQnUiJMR1m1X4uFECUBHNQo83UGjiKg/NpgI74qzsoXfh+IyLBcClxoPYwoYFkGXifV16dkZuED+EWZMUWPZyZijcUINVEKO7mj2DO9gnckB+zsh4W+htJB4HMzLKDaMeGM4ROVgWbXZUEAgAiricsLyGAkxMVgbYyy9P7yw7odwlN1CnQ2nA8QjNP3vea/ujtpsjVit/pSteE+clXdIFEcTPWT2gpzPDgiAoNuatfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B0oK9peJ1xGnlF1zHUmkNhySLsRKnd37WtCocTsxCI=;
 b=BqsjxCUID65RGku5q9cWL3x6y4dKIEOWAG3mno63KYE1wzHZukgkLzmWa7iMr2ZuISuw7pPVs6o3tqAVosw42ZKs1dGozAeR1RTlq3inZVGay85vNF0Vm30wfcLb6ciM9xXnItNgwomtmgeyfbmuosesIoM/0J/dHYCSZ/4RpyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 18:27:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 18:27:14 +0000
Message-ID: <85af42a8-25a0-5614-a35b-fdfba1b7589b@amd.com>
Date: Fri, 3 Oct 2025 14:27:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-3-Philip.Yang@amd.com>
 <DM4PR12MB656658906DDEEEA2D86AA64AE3E4A@DM4PR12MB6566.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <DM4PR12MB656658906DDEEEA2D86AA64AE3E4A@DM4PR12MB6566.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: b0af2bcb-0086-494a-6ef2-08de02aa7995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1lsWlN2VHM4NXU0aWRWeFJlQlJCZEhaNDBYWEhGRWJKeStrM1FwWkF5RnlB?=
 =?utf-8?B?SlJ5WHRESTd1ZWpJR0RYTWQxQkI3NkxTVzd4MWdSMkNERnFvTytsTmlUaGxH?=
 =?utf-8?B?RDVybFFKZFVxb21WV0RKK3ZjUmJuYndEcGwzSlNHL1RMVkJ3dEtHZTlWNHdT?=
 =?utf-8?B?QS9iZ1J6ZC85RzZHRjNxdjhhWE05ZXo1eSszNVZYaWVVZVNDeXBXMng5YzNV?=
 =?utf-8?B?c2ZqRFJmZ0ovcHVmbEtRdy96T3dYL1pUMjBwdEJpMER6elBlNG1EclArcWtx?=
 =?utf-8?B?U0I3ZGpWclFuY1hwQ3MxQ25iNzZpczVaZDlVaGhwMVZDdmRjVDVLZllrby93?=
 =?utf-8?B?YVdMRWlGbHd6THhic2FuNitPanZyQ2RZcUpaRWVvNms0SW5NdUh5ZXp0MzRU?=
 =?utf-8?B?ZXNQNjlvSENDKzhYNk1zUUxZN2hKY3VNRm9ZbGMwcWt2cy9BbEZKN2hmTFg4?=
 =?utf-8?B?dENSSDZDS1RrZXEwMEE4L2hNTzZhMmdwdEVqTlQwTFIvS2ZuWFVmUy92VWU5?=
 =?utf-8?B?MnJVZnhnWXJYMWsxMzFMM0xuSVJoTlBzd3Bzd2dFWU5jMWluN2lpNzJPeUFv?=
 =?utf-8?B?a3RUeGNvN1ZxUVF5bGdrVmlsUFphSEpvV0l2MjMwRkdFdVZoQ1NtbGwxUG92?=
 =?utf-8?B?Yys0ZldJL1Y2ZVV5WjczZXAwaVdlYXg2blN2bm5sUmNTOXdxd3dOUEQrZlJm?=
 =?utf-8?B?TWRIWXhvSUhCTC9hNGdJdm1ZQ0VnNm1wYnlYRHhzc3N6aGZYWEphaUE5Q05P?=
 =?utf-8?B?QWJXanhVYlFMQzFYVVY4VFhYODZ4QW4wcEJESXdTTDBCSkc0NmZXVFVyVGt5?=
 =?utf-8?B?dzRhMDY2RDlJZEp0akhoTXNUcGViTHZBcWppOVJuc3lpc25NY01MMElHSFdU?=
 =?utf-8?B?eTNQb29EM28rL1Zqb1RWYVRsaXRmOEs4LzA2NnlXWmZMb21nc0JsZ3FXd3hK?=
 =?utf-8?B?Tmo1NXJSZUhWaU04LzdPNklTc2hUR0NCNk01MUdEUjRlV1ZVRHdxVFVEWUZX?=
 =?utf-8?B?NDRmOFhoY01YeWpxVUFTaUJXZHg5UFJjQWhIeEJnT1pvNE16VUpJcmJnRUd4?=
 =?utf-8?B?UUVzYlFZdlVUaEYzeG8xL3BUVklEc3JDSTg5Z2Q2N3kyT0FwNGZwYVNaQWRV?=
 =?utf-8?B?M2owcm9VdjZzdTN0bjZncFhYZDRMMFYyV2lLa20zOXphMGxOMlJjRUFqdHBr?=
 =?utf-8?B?M0E0Y0l0OXhWOEMwOElZZUNUYUcxakk5WXFoVTd6VnJEMUp2djRrNkxTdWw0?=
 =?utf-8?B?NU1iNjJCRWk5bXZJQXhTdFJZZFJMeEJUSmExKzJRaHlNUVBNOTBoditkUUh4?=
 =?utf-8?B?Ui9XMWdSQzdqbVNxeGtLckwybG1oNEc0b0lMYWw5VXhiUDUzcThMZ2x6ZXhl?=
 =?utf-8?B?T1BNSkdKUDJnU2ltM0tzZGNTT29jQnZrTjRFbVA0ekhsWXJaK1hNOGdsWFpF?=
 =?utf-8?B?Sm9SLzJ2WGpobUhXUWZ5OU5rSnZmNHJpQUQrZlk5OVQ0K1ZraTBNY0c4TXJo?=
 =?utf-8?B?dThaeldZSDBLR2llVkRXMWJjd3g0aWs1R2FZbjNUTjgzYitGNHRxMkRXc3Vu?=
 =?utf-8?B?VGc0Z1FKVXc3RUFXWU01ZG5WdlR4NzlyY1VWZkZLcVJOL2pQUkE3anliWm5G?=
 =?utf-8?B?aUFpODZWSUxXYVcxNlQveUthTEkyTFRWOVI5T1U2MW9sLzNmUCtrWTJhZ3J3?=
 =?utf-8?B?SFBCNE9uWGZJY2hmaGEvT1lVaGJwSnhNTUtrdmNic0tCczJCK3NyZ2JuL1lm?=
 =?utf-8?B?NUcrSjBlSjZkTE5uUnlNd0d3ek9rWmVYWm4xVllud3ZjV1JLdk9QUXMzU29F?=
 =?utf-8?B?OE03N0hlTWdmcS9IK2VhVW5KTGxNdTJKd0JqbVZUb00vQXpPb0xXZ2h5V1dy?=
 =?utf-8?B?L2RIL2EyVFZya1BvNGVvQ1BVZTViYkZ0bmdnT1E3Qkd4NFo2TlZWbFB6Z1px?=
 =?utf-8?Q?KaALKaSCLYinkEbObQAu3zBt6DpHRKpR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmFFOVc5cHcvYlU0T3dYb3BteEUySEVHa0RLQlVGbmM3TjNESXRYazNMYU9p?=
 =?utf-8?B?czJtbDV5RTlYWWFMcG5OQzhkY2JRK0M1NU9yR01CMmFDU2xSMEx3VEZ0QTI3?=
 =?utf-8?B?amJ0eWp2NEg5ZDRoS1BQSmJkYXRWUXdybVBOd1YvK0FwdDhMK2R2Yy9mcFBG?=
 =?utf-8?B?NmhjMUxEQ05sVllPKzZ2ZmF0cFlYN1VTV1A5U1dLVCtOR0dSTUxRbWlJdzB2?=
 =?utf-8?B?RDJhalVMZ0dyK0hWbHIxWnUvQnY0RE0zZ2dCZXJnWVRKaGlaN3Nub2tvaXU1?=
 =?utf-8?B?cXNKZTZsNmtqTVRlRjU5dEl1YkhPbDNYSzB3OUNSSUo4Z0tVcHJwK1NwMGhi?=
 =?utf-8?B?TGV2VDdmOGw1d0FySmJxZDhKQVV3WlNaK3pKTTFHQVY0TUQ4Ukd1bWJPY0tR?=
 =?utf-8?B?dXhPY3k4ZCtHbVpLelI1b1VTaWhPNFZMRzE0NDVlZWRiTUdNWUdJNnEwcXBV?=
 =?utf-8?B?d2V2RjlXendLRFZoSm9CbkdtcUtIenhZMTIxMkhvUUpRVU5FUitNSVpUQVBO?=
 =?utf-8?B?MGtWbkZlOXJnZjMrb0xWNGxUUWh3U24vdGdHb2tyQ1FHS0ozeG1Rd0c1TUZx?=
 =?utf-8?B?SFhPcktkbU9wRmZsWjBjdlBXNGJ5bjcva3VIeDVhNXNFbGtHVmVKUENPdFNU?=
 =?utf-8?B?QnV5MTFXN3ZSQ2dOQWU4YmRNR3VvK3VvbVphQkIrU1hueS9YUUFmMElHZEp6?=
 =?utf-8?B?WmJSR0xQWGR0MU9adTlsY3hEdUY5cjlpOW9penNBZ1pBMmRaYjZCazJIRVpL?=
 =?utf-8?B?aTVydmZmMGpmbS9rMWJNazBDdkcreElpK0dROEltNDBVZnp2TjVSSVhyTlFh?=
 =?utf-8?B?SGhsZGQ5OS9DcnJ6MHAxZ3d4eXRkTWUrUkVDejdaTSswV095SDI5Umpmb3c4?=
 =?utf-8?B?alQzT3RtTmwyMDdOczRFaWFPTGVCeEdxRVRkSVI1ZDVMM1hHMGR1OUI5Zkh5?=
 =?utf-8?B?UVV5cDc4bHhlc2UvK1BOM1VmWEZETUNrNjFTeC9mZ01NVTA3S2tlVzluYmE4?=
 =?utf-8?B?cExrTFVNTmJYNFpmUVZsbzVObDFOUGdlTXhXVnF6M0VzbnE4ak16QUZiMDZ2?=
 =?utf-8?B?bFdFREJDeWNYTmQ3MXpReHFOL1lrWW9hSllXWFo0Smtzd0dSQXdiSnRKTzQ5?=
 =?utf-8?B?K2t5YkVkM0o5VnIrRWhOU01SdXJOSlUzZVRjMWs1eWpqYWFZdDNaU2FWMGpl?=
 =?utf-8?B?cmJLUTQ0a242QWhqazR2RW8wL2ttelAxOTFkaDVvREtUYWJDakpxRk5HSUh4?=
 =?utf-8?B?Y2FZaGdUMFp1WnBiN2lCbExnTTRpeTUwNktYNXZQbXlBVFIzOEtLUmJselZQ?=
 =?utf-8?B?ckxDNjhnTDJWZ3lpRy85ZDVPa0dOK3Yrb20zOHdqd0FQNnpZb1hyNFo1NWxr?=
 =?utf-8?B?N3E0bnpEUGRQb2VXN09ZWWdaelRXRTBsSis4NlJncmVmaTEvakNMMGs2aWw2?=
 =?utf-8?B?cDlvQWJVSmFQdWp0dFhySUNMYWV0WjBuRnloZ003dUI2ZkhtNitjOVBuVks3?=
 =?utf-8?B?ZHpvdlFmZ2hRRGZIMTVVd214OWkwVlE2NjlMN2tHSStXQ2JZMUJ1OFo4S0dz?=
 =?utf-8?B?Q0t3MmRmUHFLZW9Pb0luTnhMYlJCaE5nTUl1L3dHM0tnc0JPc3FhcGxLSlk4?=
 =?utf-8?B?SmJMNTZYa3RRU0doYzVmVDV0ZnVNZldDdzgzSllFL28vWjUyclJZOEJ5YXlX?=
 =?utf-8?B?OHA4VStOZmpTN1dhVWZraGlyUFJycFd1MjM2bE9wR3E4SFRGcjlNM3l1NjBq?=
 =?utf-8?B?cEtUbXNTTWR0dHg2QU82RVM4VEdGL2RaRXhxQzJHdzhWWVFMd3dpWGM2LzRS?=
 =?utf-8?B?QlBnSmFSM0k0SWtBeGJmMUdCN0VDdEc3c1JmZzhvOTA3MW1VM2g0ZkJWZURO?=
 =?utf-8?B?UURkM1NnWEVKWndkODVZb29PdEljMG1FR3NMNUpWWkxHQjM5aUE4Zk5IOVVy?=
 =?utf-8?B?YXkxaVdzNThlTmo0WGJJZDdRbjErVk5PZ2xpU2FYNkRtSGIrNHRoZGRKZGE5?=
 =?utf-8?B?ajY5L3d2U1pBczlNRnd2SlcrOWJYa2VPZXNxNkhJNUJNbXY0Uk83UEVObDRW?=
 =?utf-8?B?dTdqb1hMRWpvcWtLWmdudkhNT1dLZTFvVTRpTnBXOGd2NEZXNURhU0o3QkV0?=
 =?utf-8?Q?NKR8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0af2bcb-0086-494a-6ef2-08de02aa7995
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:27:14.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SnYf+NGizoH841p8y/raTbUzsD9x32/q/Z+ZPEdOnz6PmMADwHuJTWQva+XTHb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
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


On 2025-10-03 14:22, Chen, Xiaogang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> The MADV_FREE is handled at madvise_free_single_vma(madvise_dontneed_free) from madvise_vma_behavior at mm/madvice.c.
>
> It calls mmu_notifier_invalidate_range_start(&range) with MMU_NOTIFY_CLEAR to notify registered vm intervals. I am not sure how driver don't receive the notification. Is there something else cause the problem?

I cannot repro the vma not found issue with madvise MADV_FREE on Ubunut 
kernel 6.16, this issue reported on a customized older kernel version.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Friday, October 3, 2025 1:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
>
> If vma is not found, the application has freed the memory using madvise MADV_FREE, but driver don't receive the unmap from CPU MMU notifier callback, the memory is still mapped on GPUs. svm restore work will schedule the work to retry forever. Then user queues not resumed and cause application hangs to wait for queue finish.
>
> svm restore work should unmap the memory range from GPUs then resume queues. If GPU page fault happens on the unmapped address, it is application use-after-free bug.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 ++++++++++++++--------------
>   1 file changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0aadd20be56a..e87c9b3533b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>                  bool readonly;
>
>                  vma = vma_lookup(mm, addr);
> -               if (vma) {
> -                       readonly = !(vma->vm_flags & VM_WRITE);
> +               next = vma ? min(vma->vm_end, end) : end;
> +               npages = (next - addr) >> PAGE_SHIFT;
>
> -                       next = min(vma->vm_end, end);
> -                       npages = (next - addr) >> PAGE_SHIFT;
> +               if (!vma || !(vma->vm_flags & VM_READ)) {
>                          /* HMM requires at least READ permissions. If provided with PROT_NONE,
>                           * unmap the memory. If it's not already mapped, this is a no-op
>                           * If PROT_WRITE is provided without READ, warn first then unmap
> +                        * If vma is not found, addr is invalid, unmap from GPUs
>                           */
> -                       if (!(vma->vm_flags & VM_READ)) {
> -                               unsigned long e, s;
> -
> -                               svm_range_lock(prange);
> -                               if (vma->vm_flags & VM_WRITE)
> -                                       pr_debug("VM_WRITE without VM_READ is not supported");
> -                               s = max(addr >> PAGE_SHIFT, prange->start);
> -                               e = s + npages - 1;
> -                               r = svm_range_unmap_from_gpus(prange, s, e,
> -                                                      KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> -                               svm_range_unlock(prange);
> -                               /* If unmap returns non-zero, we'll bail on the next for loop
> -                                * iteration, so just leave r and continue
> -                                */
> -                               addr = next;
> -                               continue;
> -                       }
> +                       unsigned long e, s;
> +
> +                       svm_range_lock(prange);
> +                       if (!vma)
> +                               pr_debug("vma not found\n");
> +                       else if (vma->vm_flags & VM_WRITE)
> +                               pr_debug("VM_WRITE without VM_READ is not supported");
> +
> +                       s = max(addr >> PAGE_SHIFT, prange->start);
> +                       e = s + npages - 1;
> +                       r = svm_range_unmap_from_gpus(prange, s, e,
> +                                              KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
> +                       svm_range_unlock(prange);
> +                       /* If unmap returns non-zero, we'll bail on the next for loop
> +                        * iteration, so just leave r and continue
> +                        */
> +                       addr = next;
> +                       continue;
> +               }
>
> -                       hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> -                       if (unlikely(!hmm_range)) {
> -                               r = -ENOMEM;
> -                       } else {
> -                               WRITE_ONCE(p->svms.faulting_task, current);
> -                               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -                                                              readonly, owner,
> -                                                              hmm_range);
> -                               WRITE_ONCE(p->svms.faulting_task, NULL);
> -                               if (r) {
> -                                       kfree(hmm_range);
> -                                       hmm_range = NULL;
> -                                       pr_debug("failed %d to get svm range pages\n", r);
> -                               }
> -                       }
> +               readonly = !(vma->vm_flags & VM_WRITE);
> +
> +               hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> +               if (unlikely(!hmm_range)) {
> +                       r = -ENOMEM;
>                  } else {
> -                       r = -EFAULT;
> +                       WRITE_ONCE(p->svms.faulting_task, current);
> +                       r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> +                                                      readonly, owner,
> +                                                      hmm_range);
> +                       WRITE_ONCE(p->svms.faulting_task, NULL);
> +                       if (r) {
> +                               kfree(hmm_range);
> +                               hmm_range = NULL;
> +                               pr_debug("failed %d to get svm range pages\n", r);
> +                       }
>                  }
>
>                  if (!r) {
> --
> 2.49.0
>
