Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1370CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9388710E62C;
	Tue,  4 Nov 2025 15:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H90q1W4T";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21DA410E62C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDaYaYrqzjTpQBtqAeAPFQz6oQBFVyOyFg4Ybk/PIjX6qIUF/8W9RkPx0y5ZEkP+mmIwWxSNh9d+XV0xyo1OfOcYhwVM5a/5aen7YNCSwRLzAv73w1hbaLDGOJf6RLU7O8Czl45fbHvzSm9mUYrsFUHoF8YtZb8bN3uimie+1Och/mEoqfHU3h1Kj2wGnw4sCT1YaT2OIcAQIyX/hMKr+sAJwAQQyTfNG/hTtLIBoFdVrY5GQn2vteCpS8BWHPrXcVVz1xD1CXg4dwXrmB1S9RaYkIPm8Qc31ZQsCcLXA9LtUelb6yrB6FvSFw1+4+siQ7bufMVL9o70Sx5Vi24DyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o78Va4JkDkNV9srNJ4JoWAeC8AQxGW9kWTouUu4OPls=;
 b=IUsrZ8DH1ayM1zB2B1LgRUHgaGw2x/qy3udCohIdqMWaKpiyDBTidaj1ciEMhvLidTqrKyte3bRHp/LImkrTyIbqP0CTTLmNLnwVu6iZqjv6lz8JtTGLSF+CrvNMAx+4NZzRAjCOeOqbchHhMxuhfxoWzJ9+tOb6p019bYMsXoNd7kvmpp5v5ecBsZJcXT4LP+a/fnYh0NBdxP5Xpj+tMsiFMrRlodMNDzo3zIKa64aZlCNDVGEfGrDHhqhUsN6cCxlhWWT6dM/Z/sWXST6SI5eji+5EAUygasDNAMYcAbl8VvI1IvS46maj4co6/T3Ymkp8BQb1u9oO+etgqNJ+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o78Va4JkDkNV9srNJ4JoWAeC8AQxGW9kWTouUu4OPls=;
 b=H90q1W4TMXaDIy+d7Q8kISo2XoazZkt3NHyMh9KVbBLVEy0nzydVFdeGl+aHiTMpNiTpCxbhXHbqqo1Z2ER2F1/WLinCQwKSgTmkxFPeBpmeGTCCcoE+J5qlZjAA3QfH+hIFmgAamL6gaPrvmTjfD27SckAyMSR/wG+Vyg7En44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:29:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:29:43 +0000
Message-ID: <042cb13c-e396-4767-b78f-963401ca0018@amd.com>
Date: Tue, 4 Nov 2025 16:29:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs (v2)
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-10-timur.kristof@gmail.com>
 <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
 <01cfdc57f76218039efb67226b9c08189f8a1b1e.camel@gmail.com>
 <CADnq5_ONzWm3uNNo2gdScuDRMjqtoJ5RfTOqna7aTSok_vEwuQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_ONzWm3uNNo2gdScuDRMjqtoJ5RfTOqna7aTSok_vEwuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:408:ea::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4a8dc2-a284-40ff-336c-08de1bb6fa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUk0aTg0dVpYbFZSaEMwdUtPVnF2ZW81T3ZKR2Q1M0FWcWduNTFiZlMrY3hz?=
 =?utf-8?B?SS9rNm9xc3hSU3F3TGdycFFnSFpNUmZEazFBR3FacjUrVU1nK3RJRFdqdmFR?=
 =?utf-8?B?OVhlcVllT0NHOUczZTRSMm9mWm11eGNKR28wd2pkN1RxT2hWV2ZHMGs4RERC?=
 =?utf-8?B?Qmp2MjRncm96UjgzR0lPOC9CbStZNHFtLzNQaERHSzF1QXVGS0MzeVNUVmRu?=
 =?utf-8?B?b3FEZDFseVNidEQ5d0FqaEYrVStJMFFGbjloSHhvZXBmb3o4RFJkSTM1WkhU?=
 =?utf-8?B?WDBsdlBlaG92MkFOSlgxdVVuQTE4bFB5V0wvcG9yOWVSREVJc3kzcnpucHhp?=
 =?utf-8?B?SlNKY3U2QnA2YnBoak9aL2grdGJyNG85WXAzT0NCNGtpYWlXMW1nSm1YMVFC?=
 =?utf-8?B?SnUvZzNyM01tdFp0QzlieEQyUjJQVWF6SzZsMlhVTHVlbU1xcUI4bmY2TDhG?=
 =?utf-8?B?V2dleTJBZ0s4aTU3NkVDQ2pyNStIZUkzNWx6dHMrUHZuSm03RTRLUmlacmxm?=
 =?utf-8?B?SUtDNi8zQ2tLOW1hcFk0SWZwTm1PakNDcFVWbklOc2prUjhPSzVkWCtSOGg2?=
 =?utf-8?B?UVlLU1Q5VWZXVW9hYjl0bnBqa1d0STFBVVczQU5oZzNPTzZSeXFIOEVCK3BN?=
 =?utf-8?B?RmxQTUZHVnJiQUdEYVJpd09wYi9oU01YWmFESHp2SC9WWHJ3MVBhc20yZnFl?=
 =?utf-8?B?cHRUL2wrUVVPNnJBUGNqcmFiN2Naa0JYbHo3d2N3cXFmTCt1U0RsbjlwYURB?=
 =?utf-8?B?TXNER0g1TUk0MDNlMjBJUWpUQ1BSRFpoUTBzcHY1VWtJR2IyajNMZk11NUJo?=
 =?utf-8?B?YlRYU3ZrNUVUcGkyNXkwT0graVlmRXA4MDhFZTBkWGJpQ09YSThkMXZ1THRR?=
 =?utf-8?B?cUdzTjh3N3hJdUlvQnJsaWRsYmo5d3BYdEoyMk1RWmdHVkM0c0pxUjlqNUhY?=
 =?utf-8?B?bFBQdU82azVDUUFRR3pkOXhIc2xiVmtyMmwvSmRZVm5wa1c3MDBoQnpGQzJ5?=
 =?utf-8?B?azFBcWxHMDZTVHB1MEVwUHpIMFA4OWxrSmllaW1udkJTRmNDNGJBcGRRZVFO?=
 =?utf-8?B?STJJRHNDQ0lZcksrekliQ0hrbnZ0ZWkrTFhNQk5ycEhSQkJnWFBSTDFJWGdp?=
 =?utf-8?B?ZGs1NE9HeTVuOWF0K2lDVjE1U2ZPUUFhNVdmbS9HRDNyd0w0SzlKYkUwMTM1?=
 =?utf-8?B?UmNuOThZQjJsa01qMURWWXYzMG8rNDg4S2tGQ2RDcUQ1M2NlakJYQ1VQakNp?=
 =?utf-8?B?NkxybndUZEFIcWhIZTZBM2NXQkphMGdjVjJkY3h3WTJDZ1haMjJrZC9sOFhh?=
 =?utf-8?B?V1Ztc0xXRmhGbkNXUno0VU1QN2x2MG83RVZSb3RZdnhVTXQvMzRSbTMweURR?=
 =?utf-8?B?bU1kOTJ3cVlrQkZKM3VYeDZhMWFkZVR1RUlheldRZlB4M21rSGo1M3ZWMTUy?=
 =?utf-8?B?bG5WVFFSRllieWg0c1FjZmtVK09zVGxJSDdlNnNFaWhGRFJ2dEV0N3g2TXZz?=
 =?utf-8?B?Yk1yVzdDZmk0Rmg1NUI2OXlONjRlWDFzS0ErbWRVUXJEWWhDeC9zdU1jQkJJ?=
 =?utf-8?B?b2FFR25tY2tOT2lCRTJJMTV1RFdOS0NpOXFlaXhaK2krQWpwWXNqN0J0MlRq?=
 =?utf-8?B?dEZJd1IzR2tTbmU0WEtHS3VMYzZGcjd6N0krUFoxbFpsNGtnRVNHaTUxNUhO?=
 =?utf-8?B?UkZRMXpDMEp2dHY4MU4ySlA4U0s4MEkvOEVlNmUrK3NqTnd0bWl5akovMUFS?=
 =?utf-8?B?Q202bVFxak4yVDV0VnlTMmw2Y2padDZoL01yZmF4VEo0NUxyaUNPTTJxaWw4?=
 =?utf-8?B?RnhHL25UMEJVM1h6clBhbUw0VTRQQUhybnFkNjd6Q1o1ZURKVGRiQ05ST3o5?=
 =?utf-8?B?bUhTbWVpNzBGV0MwSFlEeW1KTHBHT1Y1aVVHL09wUklHMFJua2QwcFJob25z?=
 =?utf-8?Q?A4SzO/NS5ejp+A81UAzdUCfB9ui2CiW0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZ4QVAxcXZFSFhIQVArUGFraDZqaWpXTG01a1UxSFNOZ3NmNkJscUI2Y1BT?=
 =?utf-8?B?MisrRk1kak4ybVUrTVFuS05welF3N25FYXdoeWNWMHloaDFpa1k5NGp5a1V6?=
 =?utf-8?B?V3hMZVJDbmxOWFJqSWYycTNIYVkwSk9LeWkrNHkzM3kxVCsxRWFoTXFXTy9v?=
 =?utf-8?B?VzJ5UFBBOTFTV3NFd3dHajBlR3FObGNQNWx1WGRMeGYrblRTdzNpVmt4VFVz?=
 =?utf-8?B?M1J2aXJMSlJmM0NlRVN4SHcvS2Noejl6U1NEcDlPVnRyWE5tRElpZzB3ajFo?=
 =?utf-8?B?NGZ5VURGMHR2a3djYW5YK1BGdnIxZ0hNYW5iTTYrVWhPU3Z3VEd4OTdFNDhT?=
 =?utf-8?B?VjAzM0cvZ2tERVFYc0dpTEtJTUtJNVVRM2lOczJCZ3g3RWhwQTIxWW5mV2o4?=
 =?utf-8?B?QWtRZnFoRkVBMjNyT3NuQzFqN3Q4c21Pb1plQjFWYm5tcU4zS1ZtOFdSaHVG?=
 =?utf-8?B?b0Z6S2l2dnR5RndKSDBoamZ1S1k0V1c0MUVRMjdkcmplSlZ4NFpjR2dleDQr?=
 =?utf-8?B?a3BoSzFCMmhRZEUxV3ZyK0J2bS9YWk94OERZZ2l6ZzAzSUNYeHRiTFJiMjFv?=
 =?utf-8?B?OUFCQldRa0JoZVdpVlI4MlRKMjhZNitjRnluWjB3WS84blFFcHNrZU9jRVZs?=
 =?utf-8?B?ZThockdsdzNGTUd2OEIrUHA0TXhZTXlibWM5cVA3Z0M2WGd6WE1WODJtOHVU?=
 =?utf-8?B?dGhvS0NLWXZndXp1VWpjemY5cklpN1NZWVJLSVFkMjZKQ1hlWG9qUHkzOTVG?=
 =?utf-8?B?N3p5N2hjRWxKMFRsUVRsTURlemRrZGxPRjRMeUc0VTdBSS8rdmdWOVUyQ2RR?=
 =?utf-8?B?QW5aSmhtQy8vQy85RjAzSHBLZUdMT3VXdFhVd0ErRFliOGhCLzBrSU5Gc1Jt?=
 =?utf-8?B?RDZvKzF1RWloL3FxTWxueTFELzlNYW1nWGIwUmo5U3dPWS9NWmpxZWVxbXpP?=
 =?utf-8?B?VjhCcTBQdTFPZW9QWHZKbWhJYy82dmF0YmNDRTJ0dU1YOXVKS2U1NDZXT0FO?=
 =?utf-8?B?SmFtb00wRnVTRDE2dm5QQmRuVnBoU3llQVFQbFhITjNHdEhRbFBJR3lVK1g0?=
 =?utf-8?B?bGtGR2IxQU1sTjB4bHNOamxaanlhSHc3Yy84UldPOGRKOVlHOUxWNU41bS9P?=
 =?utf-8?B?L042ekVQS0hkdWFpOExpaFFHcU9BY2NNREVnc0RRLzNOOElWUVZRL1NnQXVn?=
 =?utf-8?B?RXlRcmpzeDg4dVNyQUttQlU4MHZkRjFLSXo1aDFqeWgyM1drM0g4bmdFY0pw?=
 =?utf-8?B?YkJYYnVpN3ZTTjJhVkVFdzYrSFpiWXJYZUE4NUxGTysyRkJ4M2U3T2tqSFFH?=
 =?utf-8?B?S1poSC91b0Vid2RjOEcyci8rTGdTdUU1L0VrbmxmQWFmcHk2RzNxYTdiQVFC?=
 =?utf-8?B?b1hXTVZyaXFIMXV0WDc2bUM0c2dYMjdGVWlIOC9WbWVqdXNQRktQRUJzNTNE?=
 =?utf-8?B?bndvWWJVaDBtcDNVd2NJdmpqbW1FOVBBRUZxY1VlQXEyME82VDJKS0lTckZX?=
 =?utf-8?B?Wkh0OGhXTGNuMzJwZXArc1hIUmMxYmN4SUxnczFseE5Ga05uUjIyU1FBc1U1?=
 =?utf-8?B?V0NlN05qRHVjOCtnekVNbXFNZ0czNVFBNzZoZXZOUlhyUUFOaWtaQU1tVUg3?=
 =?utf-8?B?Y1F3Z2ZRcTRqc25YYWpQR09BMzl2dGs1RjJqczR1N1FURmY0c3RQMCtlZHFD?=
 =?utf-8?B?Q3pnUkVHbS9BRjNDV2VYZWhGMmJ6MUpRNXhtSW03TnJqK0ptSy9aWUNqQmNT?=
 =?utf-8?B?S0RTRDZqY0U0OW4rbFdEZDRvUk9SK2U1dHBJclV1bkdkM1dMbkhUQ3BxbUdV?=
 =?utf-8?B?enlNVU80SVl5WWJRUWtzenpPQWdPTlZQT09sQkh0dXZnR0FlZzJNMXhLRzhH?=
 =?utf-8?B?N3h3QU9VWW9PN3hUaW1jbGNNYU5zYUVsRVBJQUlTMmlXY2pDTHFrTG5IVEFN?=
 =?utf-8?B?cERmcmsyakdGTnE3VzBsQUhneEF1Zlg3TVBTalhGWEdmaEIyaUFYUEtQbjI5?=
 =?utf-8?B?Y3V0dEJ3THNaUmtMWkIzZ1lyVVE5eVpZMTB3N3M3a2JTbDVMamExd1dBQnph?=
 =?utf-8?B?bW9tT0ZhNjRueHNHWldJUlBwUGdkb09OOVFCd3I5blphV1hJSVoyWUdYN2ZO?=
 =?utf-8?Q?5Q8MWOJL0ixLGOgF6D5MCfeNP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4a8dc2-a284-40ff-336c-08de1bb6fa9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:29:43.7324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q30VsNTxkseX27lDnXUpH2Om5O4EzcE3+RJq/TDbb7jQwAag53WzUxJ7HhHqCbQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

On 11/4/25 16:27, Alex Deucher wrote:
> On Tue, Nov 4, 2025 at 10:16 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> On Tue, 2025-11-04 at 14:44 +0100, Christian König wrote:
>>> On 11/3/25 23:23, Timur Kristóf wrote:
>>>> Some harvested chips may not have any IP blocks,
>>>> or we may not have the firmware for the IP blocks.
>>>> In these cases, the query should return that no video
>>>> codec is supported.
>>>>
>>>> v2:
>>>> - When codecs is NULL, treat that as empty codec list.
>>>
>>> I'm still not sure if returning an error instead wouldn't be better.
>>>
>>> @Alex and Leo what do you guys think?
>>>
>>> Regards,
>>> Christian.
>>
>> Returning an error from this function would indicate to userspace that
>> there was an error with querying the list of codecs.
>>
>> That is not what we want. We simply want to tell userspace that no
>> codecs are supported.
> 
> If the IP is harvested or if it's been disabled, we wouldn't be
> exposing any rings via drm_amdgpu_info_hw_ip so I don't think we need
> this.

Oh good point as well. But should we then return an error?

I think yes, because the HW isn't available at all and so querying the available codecs doesn't make sense in the first place.

Regards,
Christian.

> 
> Alex
> 
>>
>> Thanks & best regards,
>> Timur
>>
>>
>>>
>>>>
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
>>>>  drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
>>>>  drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
>>>>  drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
>>>>  4 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index b3e6b3fcdf2c..71eceac58fb6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
>>>> void *data, struct drm_file *filp)
>>>>                     -EFAULT : 0;
>>>>     }
>>>>     case AMDGPU_INFO_VIDEO_CAPS: {
>>>> -           const struct amdgpu_video_codecs *codecs;
>>>> +           const struct amdgpu_video_codecs *codecs = NULL;
>>>>             struct drm_amdgpu_info_video_caps *caps;
>>>> +           u32 codec_count;
>>>>             int r;
>>>>
>>>>             if (!adev->asic_funcs->query_video_codecs)
>>>> @@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
>>>> void *data, struct drm_file *filp)
>>>>             if (!caps)
>>>>                     return -ENOMEM;
>>>>
>>>> -           for (i = 0; i < codecs->codec_count; i++) {
>>>> +           codec_count = codecs ? codecs->codec_count : 0;
>>>> +
>>>> +           for (i = 0; i < codec_count; i++) {
>>>>                     int idx = codecs-
>>>>> codec_array[i].codec_type;
>>>>
>>>>                     switch (idx) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
>>>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>>>> index 9cd63b4177bf..b755238c2c3d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>>>> @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
>>>> cik_video_codecs_decode =
>>>>  static int cik_query_video_codecs(struct amdgpu_device *adev, bool
>>>> encode,
>>>>                               const struct amdgpu_video_codecs
>>>> **codecs)
>>>>  {
>>>> +   const enum amd_ip_block_type ip =
>>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
>>>> AMD_IP_BLOCK_TYPE_UVD;
>>>> +
>>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
>>>> +           return 0;
>>>> +
>>>>     switch (adev->asic_type) {
>>>>     case CHIP_BONAIRE:
>>>>     case CHIP_HAWAII:
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
>>>> b/drivers/gpu/drm/amd/amdgpu/si.c
>>>> index e0f139de7991..9468c03bdb1b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>>>> @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
>>>> hainan_video_codecs_decode =
>>>>  static int si_query_video_codecs(struct amdgpu_device *adev, bool
>>>> encode,
>>>>                              const struct amdgpu_video_codecs
>>>> **codecs)
>>>>  {
>>>> +   const enum amd_ip_block_type ip =
>>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
>>>> AMD_IP_BLOCK_TYPE_UVD;
>>>> +
>>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
>>>> +           return 0;
>>>> +
>>>>     switch (adev->asic_type) {
>>>>     case CHIP_VERDE:
>>>>     case CHIP_TAHITI:
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
>>>> index a611a7345125..f0e4193cf722 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
>>>> @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
>>>> cz_video_codecs_decode =
>>>>  static int vi_query_video_codecs(struct amdgpu_device *adev, bool
>>>> encode,
>>>>                              const struct amdgpu_video_codecs
>>>> **codecs)
>>>>  {
>>>> +   const enum amd_ip_block_type ip =
>>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
>>>> AMD_IP_BLOCK_TYPE_UVD;
>>>> +
>>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
>>>> +           return 0;
>>>> +
>>>>     switch (adev->asic_type) {
>>>>     case CHIP_TOPAZ:
>>>>             if (encode)

