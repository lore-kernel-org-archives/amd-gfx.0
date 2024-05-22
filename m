Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D6EC25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 08:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962A010E868;
	Wed, 22 May 2024 08:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AxbP5pHz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18AC410E868
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 08:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSdAGxHrC0/gAASnCPyjpVTe0KB1AkcsTsf7LQFILfdpfxn9u0Ly4CgUgV4UaefqEfzLbyRQsBbvpyAe4LhPuBg36DZa7S09zwT6yWoolhN3EFlAe9ixwScWY2PhOKHxd3+7Ra5k+sQLikqSAuM6akXtixq+XmJ17inVI73UDVP92kCjzSvAhV4FLeyWDbBUA+pV2lyR4CKnZPazusnCyPUecr0HkbrKrkL8NlVZn9knjV1b2j0BWg/lgjAQPDkyGx7XJHl2GftYbZhMdGVWCpZn1Kyfxegg/Ukgfm1ZNnsJRxmWMNMsFwX2IKp9c3P8gTvpz0keGcXpMr6TwBUYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiQMfa3L0M0R8UnpLgcwNJUXob0tvoRgnz+d7kzb7oM=;
 b=BN3V+T3t5Y+f0GqUHJn3yqQBYqqH82bn50fLHUqh5jLFkKWG3xaFzcNa9u0Q1GGmeYPRisGjy0353/rsnl5PyW6aQvynjc58/z0XNPyERf/ADnm5brVtf7OzYsjDslOurcMJchBEIzcU7XCrJrX/uX/LNkSHWJoy4R5xtYJt8jHHG7UVcrMLn2mcm/d+d6KdCP/8BE28HzRWl76XhOiBcpm+CuWIIXd22DsmwssOmqoc0l2rXNYHYVMh1fvB+rAEmPvm9HteLFXCr/v8ZVAzfPENwl2yH3PYr0TtEigd8Hjb8PjJ6DdRuw83c9yhMGLarxyrqD/iAUFV9j8/g2dezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiQMfa3L0M0R8UnpLgcwNJUXob0tvoRgnz+d7kzb7oM=;
 b=AxbP5pHz7/pPoLBHnA4/1LBetBIuWEMZCIdDucz5cLwB00npqnKjnu3OxEK5AcUYXm2xGL9UWn2IP1oMLf47lVorEIDiLbpclS3GTQrqv7cRjJHBSdZktEDmhwj7uH9tfwvAAoEGSgKMkkafKHQr2qg+7YL5svFKXe7MZpk/DdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Wed, 22 May 2024 08:05:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 08:05:48 +0000
Message-ID: <0322e365-527e-4842-ad6d-48cb4b694e05@amd.com>
Date: Wed, 22 May 2024 13:35:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: fix the inst passed to
 amdgpu_virt_rlcg_reg_rw
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240520160757.2557051-1-Victor.Zhao@amd.com>
 <DM6PR12MB43409CC6639FE333B7E424D0FAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
 <DS0PR12MB7804346B9171556B29C8B9D097EB2@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DM6PR12MB43403D6DB0CE7536EFABB44BFAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB43403D6DB0CE7536EFABB44BFAEB2@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 60962ba3-214d-45fa-5256-08dc7a35fd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFFNU3FkSGlRNXRabUVoZkk0dWNENDV6YjRwZUFJdHdvcW5yOWVRMkMxWCtV?=
 =?utf-8?B?dFJ4Y0xMMERzY3pQRjlucWpHYjIvQ0V3cFZUZEFJN2c5VHZ3cFhFWUFrTGZk?=
 =?utf-8?B?bmlqRy9kS09uYW9hbHZJVW5NWkNvVEpiMGtSZTVKQm85TDNnL2xiSk1mbEJp?=
 =?utf-8?B?SUhWenRBVWg1Rk5hczFVUnUrSWxFUnRNQlNISGZHaWliNk44bDRPdlpwY2ZS?=
 =?utf-8?B?aFo1WnBjOU8xUHJQWm5TeUFScGZBMTlaS3UzLzNZUms0QWZkY3h0NGxNZjJw?=
 =?utf-8?B?U05zUDVvZnh0NVVkN2pHNTVYQUxjZzR0VjZRZFVacXVNM3NXbFlqYzY2U0pV?=
 =?utf-8?B?VER6cFNadHh3cXMvVVpQbzhLeVc4QnBlMkhrRE5JMDVPc25nSk9kTThsV3R5?=
 =?utf-8?B?Y0oxYU1BeEhDSFNjbG1JYlJyRUhnUFB6UEpqVkM3WkFIMkcyMkVncm1uSnJC?=
 =?utf-8?B?Q05BeXYzS3Qwd1grOEhWcXBSODB2andabkNGM1RDOU9HM1RPdVJvWENJOGZt?=
 =?utf-8?B?c0hDb2c0SzFUM2hFN0pFVTgyUThhU1ZBRERVbjhLMjNpSk1FUGN4bkpucHNl?=
 =?utf-8?B?eEJrNDdYTzlGT0tDTWlER1VTSjJuR1A1bUhpMU1PNC9vV3Y0L3RScG02Nit2?=
 =?utf-8?B?Qk9Bd1ZDUFhYY1pDMFhVRElrNFVGanNUMmFwNVB3YmhmOGFXeUs3M1ZyYm1X?=
 =?utf-8?B?RHZYMTVNRzVXU21kbjNXTDFNb1hiZHIwbnNBSVNnSTdOV2VCOFg0SGN5dVhG?=
 =?utf-8?B?NU1YQmx1aGw1NFNtQWRKMXVxNUxQb0R2NEcvR2svOXhUYWZOa05rSmVzZjN1?=
 =?utf-8?B?U1FaUm4rckJqUjBxQjFVTkJJUzhRdkhQZVNqa01md2g1VnhNTzNQRno4NnJr?=
 =?utf-8?B?eVA1bzU4SXRFUGNZTnUzdHN2ZmlMZ2dlT3BYekZ4TWZGbGh2bXo4ZCtzQ2NO?=
 =?utf-8?B?YmhuekZiTG5Zcm5vNk13RDE3WE1vSWo4YVJ0ejMwV2t1aloxV0ZDY2w1cVlw?=
 =?utf-8?B?NklmM0VCdjVvdlJ4L0gzeFdMWnB2VmxjUUtvS0FUeEtEVEZkVDlLV2pUeWR1?=
 =?utf-8?B?V2RySlZVTDlWY2Q2c3hHQXdVQUpQR1V5TXQ2OXdSVEwzbTl6K0VXaE5xblQw?=
 =?utf-8?B?Y2lodDk3QnFPMnc4S2kyeHpLK01xNjIzSlQ3MERSY3pTbU42bTV3VndPWmZj?=
 =?utf-8?B?REk3YUVucHBnejJ3UlN3ZjYrMGRIWUduVHYvQThNNWZSdGJqQzM3YWxMYjha?=
 =?utf-8?B?Ym8zWGpTOWJ3amNobU56UWJobmN0OFk3SGluVXdRQis4WnZ5aFBiSW1NdHZF?=
 =?utf-8?B?UDFBNGxaaDRSL3R4M1ExWFlhcDhsTVNKcFIxWHFHWlZNRUpUZm5QNHVCWWZM?=
 =?utf-8?B?SlZSK0NEVENDakxqVXhWYW13NWVjTnlDWE50ZUk0K2hiTnFRZWNFSlMrMnZl?=
 =?utf-8?B?RmsrRCt3ZGFNU08rL2FEUEVhNWlSbFNnWkNWVG9DdUZIaTFucXorMDJkakRQ?=
 =?utf-8?B?eC9mZzI1R3d2b21SVkVpeTJDTzhkdnFONUNEWDU3WkVRckMwL1owU1ZVMHU0?=
 =?utf-8?B?clViYzV6OEZWY2hDd3BTVEtGV0NOTDlSK0daaEE0bEdmMGNMS241RjRBUlNN?=
 =?utf-8?B?SU43bm54MTArU3MyRTIrU3Z4SnZEWGhrUzFpVHhkK1h6cDhjVThHMHdFTTQ4?=
 =?utf-8?B?UHFSbE9IWnIwNTJiMnZ1ZlovaXIweTJYL1hPWG5adWxBN0ZkbzU4L0tBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGMrR0NETlFReE81U3pFejMrNUFSRGYwakxPRHpocklIUXpMbXlrWWdERFBp?=
 =?utf-8?B?RFR1NXl0cllmaWMzQzR6OSsvMnpjM3dwRDJYWjlhdUdSZ3BkMFN6WWlvRjFt?=
 =?utf-8?B?SThmbUtzcXZHL05ha29ib2ZvWUZlOGJ5a01Pb0RmSXFQLzlRZDBScnZwMTRN?=
 =?utf-8?B?dWFiclBiNFlha2Y5b0ZkeCtpVWNWK0VCeXlKR0tIR3hOd296NGVEaVdxdFVq?=
 =?utf-8?B?cXdSY2VwczFUaEJnOFFySVl4US92TUJ6SmhLQ3hDT2dZSzBsRWdqdG9OSURw?=
 =?utf-8?B?YTFUUTZlQ3VEQnQxMVNyQ082UUJodUkwOVlIcFhiRW5PTXd1VFEvQmVjM2Iy?=
 =?utf-8?B?cE52M3lVWXhJMEZ5Nm1uemxhMnFObWY5ZHdwQkZ4eEVSRTROUVFiV3BuMHdi?=
 =?utf-8?B?NjJaNVo3Si9yTmhTbzIyVlJVckVRazdIMFlvWDZkdEFuUHZlc3BmaVFlVHJk?=
 =?utf-8?B?UWZyYk15VlJVN1Z6YUZkUDNpdjZGTUVtbXg1bTBZTGZDSFlPVCtSakNHN0Ex?=
 =?utf-8?B?ZGVIQ1VKTnM5cG5uVmo0MXpWMVpqVmNKcm9lbWJDVVVCTEtFcWlvYWtnTEZ4?=
 =?utf-8?B?SnZDbjg3SmlsUUxlSnhmcnRJTXJqdXR5ZFhMMlZ2TFd5UXVjTkdoN0I1TmJR?=
 =?utf-8?B?YWx5V0VVWjFqbVdOUkRMRGFTVXdPMXZEc0ZsSGErZW9ENXNKQ1lYVHlwbjBT?=
 =?utf-8?B?eUpFOFpuRVU4UzB5Y3BOY1dLYXBPWVdmM0JDNSsrU291K24rNjBkdDRHa1h3?=
 =?utf-8?B?SUhHclZmKzNxSklOSzhWVjgzUU5tSGNvZXdWM1ZsNEdJKzN2L216dVc1RkdQ?=
 =?utf-8?B?S1JvQlh2V0VBWDZoblZPR25zdk1QTG5ldG1vNzBvUDhvNnhqYWpjSnE4UTBU?=
 =?utf-8?B?bTk5enUrM2ppVG5YODV0QkpUWWt3YlUvemp3aE83NUNzWkNrU2JRcFR5QmRM?=
 =?utf-8?B?cXNOSGRBNGdkek5admRlcUxKNy9pMG8zempWRjZvTnNrMkEwWFRXeDFQdUxN?=
 =?utf-8?B?dVJLakdHY0tlRm1uUGlXWmxNZjRTZ3JXRmd4N3Q5ZDhNK0RQVDg5eG9mZk1q?=
 =?utf-8?B?VFVYSjVlQk55SGJhaTU3K0RjRTFZMXB1RE91Zm1sWWl1eCtzVktBUmEyODhp?=
 =?utf-8?B?TTRRRDZyUVorR2N2TEN0Z2g2NU5wamNsT2V6c3hxK0NSNlpUTGJGWWdjMGk5?=
 =?utf-8?B?SWNaR014cjlHSE9yREI4SmFZaHRXd29wQURqbmRNSGZKQnZGdGRJbHd1THA1?=
 =?utf-8?B?Q1poU3VZcWVLRnFOMUZtbkhrNFQ5RWg0WjVJdWJKcHMvSDZka2dDZHJYYWxB?=
 =?utf-8?B?S0NFdFNsb2NTYVVwRnNQMEU3NS8xejA4bjNSczd3bGxjQnp4YWQ0TmhzdFVI?=
 =?utf-8?B?dDArMDRkUzJCenl3TjUyUytFbTdPbld5NUl6SzFOQlovN29WS0FyNGJXYVcy?=
 =?utf-8?B?VnBaZW1xRStGVEhkTENWRW5MN1IzLzh4MVBJWjhYVmpVZlAwZC9VVzR6V0c3?=
 =?utf-8?B?VXZ3VVY3WDRPcmF3V2FocjJpYk1DTlNNUHpkQ1lWTlIzWkl5bkhZNVV1RGhn?=
 =?utf-8?B?NXBLWnh5YjMzaDAvNFhvYnZQY0FNUXF6T3dTbGJtdGRuUnpSYkd3a0o4SkRI?=
 =?utf-8?B?b1hBb0tYcGl6U1NZTFlSWmxFZFU3TU9UcDJGMGM1UHJpRFozUXFKL1lGMElZ?=
 =?utf-8?B?RTFzTVZqbEtmaklaQmxrMytQTlVrWXI0TlZyYUtXcEZ3ZGZlYXJuS3I3Y1hv?=
 =?utf-8?B?RUpzaERJZzQrMXJ1NENGVlFSZUlwTzdBSUtEeFNPS0NtNHBjN05sTFlWeDNS?=
 =?utf-8?B?TkdadUJNWjNvcFM4REN3c0sweW8wV2dHaGV1YmZaWUFEUGZ4ZVZpbitpUEhs?=
 =?utf-8?B?U0lxbVFzL2R6aGRSUkt6eHJBR1dVNW5STy9LMEJpRFZWWGxWQVZjcVd6NVdk?=
 =?utf-8?B?bVNITUkxMk5WRmgyRCsrVzhxMFFua3gzR1lCeTRkL2JoYmdqN1U4aXMraXdp?=
 =?utf-8?B?bG1aYVp2MkswQnNqR0JNazNFcktGOHVVNGp4S21Lemk1TWJIRWh6eXdIVVdH?=
 =?utf-8?B?eWUyOG9nMmJqTE5oVDdtUHllOEUxc3FTRGo0UjhRUUNxZjVrMHpYUG9nMUNV?=
 =?utf-8?Q?cHBsWuMd/V7ReUWOUeVl8FCsI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60962ba3-214d-45fa-5256-08dc7a35fd15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 08:05:48.1292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edwyTecDgRemmGloKgFNLOpgPSSDh1mkM5Gf0I47Mct+H859E8zaXFPybYcAbiQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476
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



On 5/22/2024 1:11 PM, Zhao, Victor wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo,
> 
> This patch alone is not working.
> Since in your approach amdgpu_virt_rlcg_reg_rw is taking logical xcc id, so all the read/write calls need to be fixed with it.
> For example, WREG32_SOC15_OFFSET. There will be bunch of places need to be fixed.
> 

That definitely looks complicated. Using physical index and passing the
same to amdgpu_virt_rlcg_reg_rw is better. The patch below is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks,
> Victor
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, May 22, 2024 2:14 PM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_reg_rw
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Victor,
> 
> Could you check if an approach like the attached one helps?
> 
> Thanks,
> Lijo
> -----Original Message-----
> From: Zhao, Victor <Victor.Zhao@amd.com>
> Sent: Wednesday, May 22, 2024 11:13 AM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_reg_rw
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi @Lazar, Lijo,
> 
> Can you help review this?
> 
> Thanks,
> Victor
> 
> -----Original Message-----
> From: Victor Zhao <Victor.Zhao@amd.com>
> Sent: Tuesday, May 21, 2024 12:08 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: fix the inst passed to amdgpu_virt_rlcg_reg_rw
> 
> the inst passed to amdgpu_virt_rlcg_reg_rw should be physical instance.
> Fix the miss matched code.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e72e774d17e6..e74789691070 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -679,7 +679,7 @@ uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
>                     amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
>                                                          GC_HWIP, false,
>                                                          &rlcg_flag)) {
> -                       ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag, xcc_id);
> +                       ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
> +rlcg_flag, GET_INST(GC, xcc_id));
>                 } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>                     amdgpu_sriov_runtime(adev) &&
>                     down_read_trylock(&adev->reset_domain->sem)) { @@ -810,7 +810,7 @@ void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
>                     amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags,
>                                                          GC_HWIP, true,
>                                                          &rlcg_flag)) {
> -                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag, xcc_id);
> +                       amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
> +GET_INST(GC, xcc_id));
>                 } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>                     amdgpu_sriov_runtime(adev) &&
>                     down_read_trylock(&adev->reset_domain->sem)) { diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 094c08cb98e7..350f6b6676f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -844,7 +844,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>         ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> 
>         if (vmhub >= AMDGPU_MMHUB0(0))
> -               inst = GET_INST(GC, 0);
> +               inst = 0;
>         else
>                 inst = vmhub;
> 
> @@ -876,9 +876,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>                 for (j = 0; j < adev->usec_timeout; j++) {
>                         /* a read return value of 1 means semaphore acquire */
>                         if (vmhub >= AMDGPU_MMHUB0(0))
> -                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
> +                               tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem,
> + GET_INST(GC, inst));
>                         else
> -                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
> +                               tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem,
> + GET_INST(GC, inst));
>                         if (tmp & 0x1)
>                                 break;
>                         udelay(1);
> @@ -889,9 +889,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>         }
> 
>         if (vmhub >= AMDGPU_MMHUB0(0))
> -               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
> +               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, GET_INST(GC,
> + inst));
>         else
> -               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
> +               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, GET_INST(GC,
> + inst));
> 
>         /*
>          * Issue a dummy read to wait for the ACK register to @@ -904,9 +904,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> 
>         for (j = 0; j < adev->usec_timeout; j++) {
>                 if (vmhub >= AMDGPU_MMHUB0(0))
> -                       tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
> +                       tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack,
> + GET_INST(GC, inst));
>                 else
> -                       tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
> +                       tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack,
> + GET_INST(GC, inst));
>                 if (tmp & (1 << vmid))
>                         break;
>                 udelay(1);
> @@ -919,9 +919,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>                  * write with 0 means semaphore release
>                  */
>                 if (vmhub >= AMDGPU_MMHUB0(0))
> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
> +                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0,
> + GET_INST(GC, inst));
>                 else
> -                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
> +                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, GET_INST(GC,
> + inst));
>         }
> 
>         spin_unlock(&adev->gmc.invalidate_lock);
> --
> 2.34.1
> 
> 
> 
