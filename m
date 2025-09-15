Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85BCAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 01:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C885B10E278;
	Mon, 15 Sep 2025 01:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLhcpcz3";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EE210E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 01:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPyf60+3zoNFAFnGa5HpTRGGEQ438e+9vqCeOP+OP+x3JVphr9xj9yE8J/ei1WKyznILj1yHfByKybf1aftxkFoCh9UUtdOcTp/zmXEBsP0FRZzPK+LduKjo5Uw6o/Xrvk3ifrqjmZ+F/vyUHmljdVa6pH1UuQWm6nEfbcVISTnfvxqhUC8kvdHlD+kVcX4H9/UtD+b4iO6dCDBCGjMIiE3R3pmOQl2JNbusuCIOpX4tOLKx1qUbdQ5g7e7M4EPXiI9++wOE4eq1LwqyANCHWrYw8VvM5UqIr/58aXAg4J6LNKKmDLEfvqhLvJBKgBWxq0WozEznYFoIKbpDw9wh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJLdqX596Qx1ANtxq5q0C0LHxhOvdkmNib2xD3gJj4g=;
 b=nePDcsMZ/VCURiQe+qbkFPDR9GFUugjUxlj4sP9D8Oqfq1C9oSjbyAOhOjQHGe165MAN4uEOTIaI9nVZqg1pLKo69OFqqAVYo3ktQB+D3Gc8qItRYkH7a4qLq5kGFM31LMiJSIaju0t8BgYYDeuntL+ls7y3CQ+woqupkftWxZ32FcKK9Dc65T2EEBNmne43FuSDxiI1p1dCvPdGji4D49PM9rCYbnbxm3rAEDVhMkofVnfWypu21TcueHEeTP57v8ghYguKmoccklhjwQ+HhXjXBbc/qlsyFgiRjByU17Tt4BchhVXacusUKyjXoYpPnMmJ4mtYBiugEIKCyT2/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJLdqX596Qx1ANtxq5q0C0LHxhOvdkmNib2xD3gJj4g=;
 b=cLhcpcz3430lj7SYB4Zgbn1TIRp9S/OqThCpJkaUs9yluf+qSdaYBvw51Eg7eyqi7m7vT/x98EyRYrfwLBVSUckEDk/QT8vVYbRw3YJPtytZrl8G9n6pJL26F3vYyc2WxvZx+E/HNxZD1bVGvQH7JGfOhfA/xoq7Q7C+UZAsW98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 01:07:41 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 01:07:41 +0000
Message-ID: <582131f2-88e7-48de-9778-5bb6220542b9@amd.com>
Date: Sun, 14 Sep 2025 19:07:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com
References: <20250825215631.628949-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250825215631.628949-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c90373-9cb2-43ff-de2d-08ddf3f444d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWNQd0pWdk9pTUd2dDNMaUhXNWtDTFZ1bk5qTllWMkI2ejRSZEZKQXlCWXhB?=
 =?utf-8?B?RHA5NVU0Y0FqcjdxT1FaM3dIRXk2bUhQcnpmKy9Fa1h5ZmJzOWRWR0hMSENO?=
 =?utf-8?B?R0RMOWNHLzUyTFlFZHo4MVdFSjJYM3VqV1lwM0JYWmpMQmpXS3FIaTdtSmh0?=
 =?utf-8?B?YUFjS3VrUU1lNFFEdVFwVGxwcUYyVG1vazcrQU1Td0xjWVFQaG1EaWJ2ejdw?=
 =?utf-8?B?Z1I2Tng5NnVYa0JZYTFGbEg2Y2xXTkU4akt1Ym55Z05jdE50a3ZaWElRRDY5?=
 =?utf-8?B?ZUJxWDVCRGdITWYzK0JWczdGZUtoSFFaNGRySXJUd0ZnaUlmdUxrOWFIN2V1?=
 =?utf-8?B?MDBwM0x5U3p6ZXU5SWNTanZIaWRSbGd6TWYwMnRxUWNteUlQbmVpbi9aODNL?=
 =?utf-8?B?Y0h5WXdqZDFpZVBiNkl1eUhyUnN1TWV2RDR5Z0YyRm1EOGZmL1l3RFVjWnlk?=
 =?utf-8?B?dzBMY0g1aXRYME0xMXo2ckNwSDlSdXpSeGYxK0kzK09MdTR5aGR2OUNUUVd5?=
 =?utf-8?B?ckF5SlZEazM1Sy9ObWF5SkZrcFRpbkIxMkdZbDFVbHh3eXI2S0FINU9RNW5o?=
 =?utf-8?B?eGNVU3VxYTBtb3VoZ2ozVEZUQUpDMk5IVGZXQXNQaGU4K3BFRVpRUVdIcUNm?=
 =?utf-8?B?ajNFS2NPYXYxeUNxNnVlMitFa3UxNFhzUDEveUNwZnE0TGZ3QWdSdGxZTm9o?=
 =?utf-8?B?YXY2RVA5L1gzRnRYNTFQbCtubGpZM2dUNy8rMXl1Tnppb1dxTjlFbERLaDNQ?=
 =?utf-8?B?a3VWZk5nZEJHUFFEUHQ5KzJ2RmN6VytNckQzQklyVFN5VU9wdnhVaU9nUjRS?=
 =?utf-8?B?K0JqMGtSeGtGVEtINTZoMWY5UWpIM1FWMFJZVnhtcVFPd0VLS292UWVpdmRN?=
 =?utf-8?B?VjhOQytLUWJGbndac04wQkphdVRYWm82ZUxVdUE0dHBvNDd1Nm5yL1puVTlZ?=
 =?utf-8?B?aVlCUWlOUmdZazNCbE1HWE1IYlYzSHYvQUZoMzFDR3JWSWpCK1dmVkluZ0pT?=
 =?utf-8?B?ek1CeEs5N0pEN2tmUit3bEFicEdRa0hvZ25uZjNDclpSSS80VitKSHdLcm11?=
 =?utf-8?B?SmZOYi93RjhJK05ReWVoTU5heUxnQ2txTTFySGtxaWlsV3FJbDJtVmx0NXhw?=
 =?utf-8?B?bHRvbXd5WVNiYUp4TEVzeGwveFBSdEc5U3I2YWN4M2RpaXBySDdGQjlkaDBj?=
 =?utf-8?B?RFBacW4rbUtnR0VnZG5mVkJuczV6NjFTd2I2QjRkamIxTHJQaVg4WFZhdFBw?=
 =?utf-8?B?ZUZvUXNBYWJyZnlrQ3NUbURFd0JuQVNjTGpVZGlxOS9oQUVBbUF4YitoN2hx?=
 =?utf-8?B?c0ltV2JJWDRPU28rdUdydnFnMUxSMUhMeVpIaWtLVXNETGJnVnh3Tnl0THVt?=
 =?utf-8?B?MzcydnQrWE8rNmxiR1ByRStJelA5THhwUm81N1doNFlLWDIrYXB0Y3BhbXUv?=
 =?utf-8?B?UXVqSU81YU1lYllqbXRkM25CeW15M3RQU0tLYlRpZmxJQmg1UGFvTnJsaVRw?=
 =?utf-8?B?cEkyRnpGL2JjcDg4SklmNFlYTWJBTnYyaUZyQmdQQjQyQmljTit6VTJTVnRQ?=
 =?utf-8?B?SnI0bGl3QUorbUgzMHlxZlFtYTk0T1crdmhHLy91RUpTVkl1cmdGTXluMmpa?=
 =?utf-8?B?V1A3Q2EzdjdBd1FCOER5RXVRb2JIbGlHZWQ5UTVUbWJPV0FGUy9hUG1zRXlC?=
 =?utf-8?B?azU4N201enJWQ2xOcG9tMU9MdjRHSUprajU1dm1NRTJPa01Sa0VteXBwRWhY?=
 =?utf-8?B?Z3VNMFVLczZjVUtJbTl5VERaZUVkdWMyZmd3dGQ5QWlFSWZ6OUFiemh1NGl4?=
 =?utf-8?B?QWZ5dUE0c0thdGR2S0hkaVNadzZsSUxGNkJSa0NPYmdEeEFMaEtKSGZkSU9Y?=
 =?utf-8?B?d3kzeUttcGlVSEJiR0NFMldWNkw0L0g3U2JSRDdXWFpodWJETCtabU00T1Jh?=
 =?utf-8?Q?n8IHwBIogGY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NxcnY0aVZTbFlRWmxScEtCOWZmY0RlV21iTDQ4Wmh6eTVZRDl0VGQyTFFk?=
 =?utf-8?B?REh6cXQ4VmpBMkg4SXVyYkpzSmQvNm1PZ0l6OHZuRDBOM3dJa2hFRVZDczFV?=
 =?utf-8?B?NmQvT2YyYjMxK3NDWFZOOGh4SmJYWEozbDhyMlA3RGpPaHJPUVZiYXFIeGdv?=
 =?utf-8?B?TjRMenRzUXQ4bzM1a0ZOSWdneWIvc3ZNMzNWcktaYjBHRXk3bmFiQ3ZiU0ly?=
 =?utf-8?B?RktMajRnV0xUeVRsYzNvYnBsN3BHMFhYTG42ZUZ1OXdvK3RvSCt1Q2d2VS9J?=
 =?utf-8?B?QUtnLzBWQS9La08vcm0vWnpCTG9IamNXN3MwN1NCU1RVaVdrcXZLNHRjS1E1?=
 =?utf-8?B?c2hyQnNMU2pBaHQ5NE5MTDNPNjgwZ3JuRGpERUE2OVJVZ2E0U2hnN3FFRFZs?=
 =?utf-8?B?NkxNakhrUUFjWmxtajN2WExmbWI0a0E1ZU9HakRXejhZQ291ejdKbnVQMWhu?=
 =?utf-8?B?dkJzUGF5em56eXVRWjk2WGlzWVgxV2NoSkpxTFhRMDZqOExWUE5Od1V0Mmd1?=
 =?utf-8?B?ZWJVc1FzYzVoYm9lSDFueklGZ3pydUFndXVCSUhUQkFVcEsranlBWjUwTXFR?=
 =?utf-8?B?NWh2ajRrc1d3akNpS2hFUmV5TW5PT2JxNlEzNTQwWjFaOEJDbnQ5QTdqaitv?=
 =?utf-8?B?bVFSMjc2Q1BFZHVvZE9wUXIzV3hxazBRb1loNWdFSmZwT1N3MzgvWHlmNHVy?=
 =?utf-8?B?MlJPakx4Q1FVdmJOR2RYbzVVTXh2aC8vUUxUZUJLN0s5MndWZitnbjBCeERl?=
 =?utf-8?B?RTh2NTl5VVZCR0p6R3NXL29OTEN6eFk0Y2t2NFI2U2ROSkFWeFI1Z3IvcmNI?=
 =?utf-8?B?enowRkJFdTBPcW8xSGNUR05meWxnbytaY1ppcTQ1NTMyTm9YWGNJR2lGanNB?=
 =?utf-8?B?UGxwdm1OMjF3VENuYXlIODE4bTl0NUFITHNURjJzRVB5YndVd2RRalM2anFQ?=
 =?utf-8?B?Q1N1bXBVTHFEeFB2RURJSWhBYy9PM3ozdk5RZ203QThVRlJldis3M21VdStU?=
 =?utf-8?B?N1hESmp0UVFWNWZUM01wTWNBSy8xNUhmbndMa3Z3eERRNnJaSi9wSmxUeldp?=
 =?utf-8?B?OTRwYm5TMXFPc1NFdlFIQnR1NDg5aDlVTDNYR28zY294QXNvU3p4bC8zVjVG?=
 =?utf-8?B?UGFJaEZaZlVrc3ZVNDFucld2MTN2SFZxdmVZMmZkVXQxNzJKWGpjMHdxUG5K?=
 =?utf-8?B?eXplaUIvZ3Mva3dOTDlWT2pVR3dCT3BlSEtLaythbENxT3QvQnkyYThnaGM4?=
 =?utf-8?B?MlY0RXBYMFVJMnpUTWpGbUtNbStKTkx4R0lzTzVqcnJITU12TXJNdGRnQ2pm?=
 =?utf-8?B?c1JBWGl3SmZZYUNtTEVwMUNpcXFZSkROMjdLVkhRTzJoRkdsL08xQU8raFY3?=
 =?utf-8?B?MTI3bWNqWTViU2tma0drUmk5cnRvc3RXMi9IKy9oT1NlYlJicXpuYWk0YWNj?=
 =?utf-8?B?cUcyaW04VkozOERYVlZ0OU93RFNXUlQzdUpkMXdFdmZBbk5LSGZ3cUVFRVVp?=
 =?utf-8?B?T3BrdkxMeVpabDg4YXJ3SEVnL0IzVjczUHNNRGlMbnhnMUVIeS9WNHNTMUUr?=
 =?utf-8?B?QjFTRUhXNnp0ZzM5ck4wbFFVUndNOGVkaW5ibnljRWlYMHRjU0lzL1pUUytU?=
 =?utf-8?B?amh5aFdJUTVlbFJmcEJUSm16Z2RtWmRMRGRRemNQbUowS3BBb0tTcHVWWjhD?=
 =?utf-8?B?Wmd1UkdMTzVjd245NDcvK2xMM3F4cTdKNGJnVFE3M3VudVM5ajBST3ZpSitq?=
 =?utf-8?B?b083WGYvNjdnTjNuZ0VQRFNkUU96MDJwMG1mc2xqcnFTZENERSsxbmxOTXhS?=
 =?utf-8?B?NytzaHZscUNCYk9kV3JxRGRwMURkWlU5TTJhQll3VndqNFc5Q3hXVWZZc2pK?=
 =?utf-8?B?UG1qVGlOSkVVWkk2TnQxTTh6UnFJeGNIQ09vVUNPOFpqZjVBc1R4eU4rT01I?=
 =?utf-8?B?cCtQdUFHWU9OWDI2K2YvcS9GVzdId2cxV3VhQUZ0SUR0VVpCR1RReFhkanFI?=
 =?utf-8?B?ZjVsTUVoVFZScWhTN0VMZitIZlRrcFVNdm04bVF6cHd2b29oYTMra2J3djBw?=
 =?utf-8?B?S0U3WUM4SmhuM1RZcG52QWc4UFB5ekhIUVIyMnpTNGMzd3dnaG52S1BTNFdz?=
 =?utf-8?Q?kzBo2LK6QbzlLTGbuf3DjK74x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c90373-9cb2-43ff-de2d-08ddf3f444d3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 01:07:41.0486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QdyGzmpIjdB7TrXFGaOCUKSkq0RMV664n4X27DhgwZ9ffd7YWnq6Rb6bd0/NZheM4qX7FFy1B7NlIsm0GANPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7
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

No regression found in DC promotion test.

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/25/25 15:56, Timur Kristóf wrote:
> Compared to the previous version of this series, v2 fixes
> the rebase conflicts on amd-staging-drm-next and includes
> an additional patch to address page flip timeouts when the
> displays are blanked.
> 
> Currently when using DC on DCE 6, it produces pageflip timeouts:
> 
> 1. When displays are blanked
> This is caused by (mistakenly) turning off the display engine
> clock on DCE 6.0 and 6.4 which is also the DP clock.
> 
> 2. After suspend/resume
> The root cause is that DC assumes that the VUPDATE interrupt
> is always present, when in fact it isn't supported by DCE 6,
> which also doesn't support VRR.
> 
> Finally, there is also a patch to disable fast boot mode
> on DCE 6. The rationale is that this already didn't work
> on DCE 8, and even if it did I have no means to test it.
> 
> Timur Kristóf (4):
>    drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
>    drm/amd/display: Disable fastboot on DCE 6 too
>    drm/amd/display: Disable VRR on DCE 6
>    drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
>   drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
>   drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
>   .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
>   6 files changed, 46 insertions(+), 20 deletions(-)
> 

