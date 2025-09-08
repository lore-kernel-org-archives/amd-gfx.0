Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3583CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 15:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8188010E04E;
	Mon,  8 Sep 2025 15:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3/uF+dL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E343410E04E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 15:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmyAW7sEQBXgI+gIwHOFVivNj9ClqbHxlEsyXJX/I+A9Y7cvpdwgIYLKUoKzlZiJq+Mpbsu5qDV8+ajXx3vtDrk+IElWkEVEkSI4dLzWNTaIr6oJGRekxq+NPYpkam2k5I2LCfHzrFfrQAS0JRCFxQZuHVgH0S3lcXi+SZWVWIkiHCzJ4b3c1tChnhQ6GNSygE0nrF85pOCo2trZE6KPU/UDfM4pP1rpGZBBzEjzq2VNhupWZk7v87ZpKWzlEY23LhcW4czsolNklYLfjm4qQMBq8T4e8r++Wf6w6NumgybFXurVHizv5J5J9glHtsGb3MY55JbJ5CpRNJuBmS3tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCVGlixToZuGCv8ZiKJlfX4qT4/Iij7FXSc8CHpmJYI=;
 b=bAa1+3L4dXws3s6ER2KmoMI2rpgfLIuSSoWtuNA0gLdwgDC8oUZBRnRHJp+ciYeEXo17Xvm+zAA8YsLI6nSKO7MDUlwlnir7S/tA2GzuIGZD/iUtyZ6LohugVSkHB6mLix/aXCw3Fc3x5VzGqe8JiB7Opz+c44XnqGiJPco9Jib7u3Yjou1NpxSLdiQBqg5phu1EPhkIu8zLxVxeQPFO1eci0GALsTXOgfE6EbuqpVTV6G9qQcjfKtLX0CukuE7m0x+x2s8AKmDRAm0HDGcJAm/mbh0FVSfcHDezDwz5f3USfrrPBwJAnui68RzZlZM4KUig4+cLgnEoZVNzX7h1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCVGlixToZuGCv8ZiKJlfX4qT4/Iij7FXSc8CHpmJYI=;
 b=q3/uF+dLUQ/FQEDVICbiOeZ2uEMU+FsnyKnCcDJoLTFoYHz0zJlk+7aKKMt2l6F+Gh3wNuKpFjCfbVGmMtstuaEMi4KkmYj51qJF7P/aSByE6WKcfSWQKLBCelFJWXf9aPpCmDfFcRLH63QUqnHxEPn1+6a2uP7D1n9jatrv0kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF316EEACD8.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:04:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 15:04:51 +0000
Message-ID: <4621dab1-97d6-47f7-bf60-3f1cbdf640ec@amd.com>
Date: Mon, 8 Sep 2025 17:04:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
References: <20250905124742.11305-1-christian.koenig@amd.com>
 <20250905124742.11305-2-christian.koenig@amd.com>
 <CADnq5_OmQkYaYSu-QYCXV7YcPLtbVsKqwsjwWt=coPoRcrvadg@mail.gmail.com>
 <CH0PR12MB537231D3E692E6028C057F0EF403A@CH0PR12MB5372.namprd12.prod.outlook.com>
 <8c919bc1-0ea5-4b73-b73f-657adb6a8f50@amd.com>
 <CADnq5_MnUN208f-ix-QyOGZcYnY2S-F3tvzpD4RWCZ1SGbWOaQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MnUN208f-ix-QyOGZcYnY2S-F3tvzpD4RWCZ1SGbWOaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a96336-19d7-4a90-41b6-08ddeee90f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUx4MzFrMFF4UzB5UzZuUzBtNkpKWWFTR1hDUEVoZTNDWTFFVTlUU21qMS9z?=
 =?utf-8?B?Qzc1YmU5V0VuQk5KTWFjKzVYKzJrSkdYdVI3eXVVajEvK3VzWlZyTEVuZ0dv?=
 =?utf-8?B?K21yMVB4MjdvL2EzWS84dG1wY1B2blBFTlZEMHR2T2FqcWRzM0N0NkxheVVp?=
 =?utf-8?B?TjlvT3FpRkVjNkNvOVB0VkJLSW00ODRLTnh6RFRkTldqY3dhR01lempLN2lj?=
 =?utf-8?B?bXlOZGp3TktCais4d0VnQll0TE45TTZHRk5XUGVQRHpwQjhmZ1FlZ1Fra1Nt?=
 =?utf-8?B?cWx0N1dPeG9rd2F6c3BRY1R6K0NKdndDOUlIdWVMZWlSeGtPY09kVSs4R01O?=
 =?utf-8?B?RnpwakVKZlU0djl6TXIzdTd6ODRSVnhPanozcWpMVG05ei9TYnhRdm82ZGYv?=
 =?utf-8?B?dk1iSTFneUV2dG5LbEhRZkFtTU14Vnp2OGwyMHZqTEo1bnhjb1N5ek1oK2li?=
 =?utf-8?B?RXVJS2oxSmsvTjdydUVtOWI2eit5cXYzeXUrMHVCa21YREw1YUxnMDdNRDNp?=
 =?utf-8?B?cWoybWZaR0NReTl4QTUxS3JHS2lIVStYK3ZGQklZWEJROVJWaE1ocUdkSVA4?=
 =?utf-8?B?U0I3TnFpY2hNaEhpa2VtRDhzeFE3K1JVZEY4Q1dZRHhFZTNzM3NEc3JOYjI2?=
 =?utf-8?B?bmgvQjI4R2xqeGpLY2VQdFMvc29ZWUdpc245TEJ3UkZNK25nTkZMZ1V5TnZl?=
 =?utf-8?B?UVQ0Y3FDeDErZnFPTzFHaEVzZmNubldsaDVvZEluODBXTkw5a0t5RzVtRmRn?=
 =?utf-8?B?YkhnKzBUd2FCR0ZGeGEwcllRaEc4OHJsNkZuUGFwZDlOcnAwMGJzSDN4QjZo?=
 =?utf-8?B?ekZlVEFvRU5ETHZZTjMxbEtoejhBbnBETE9zV0ovMUo5b2NBN3JpZVgxTGlE?=
 =?utf-8?B?bzlpZHh0YlR2Y0tnOHN5S0l4T2ZLUWR0SmlScFNHU2RGNDhUTERPQTlPRzlu?=
 =?utf-8?B?UXlVVGxEZVYvK25YQ3psZVpkMjFzaTFkMmYyZUVKYng0MWE3UnhxcEJGR1Vh?=
 =?utf-8?B?Y1hrWnhpaFVhODJGRkdTNFkyVi8rcGg2MWZIRWpsZmI2aitjWTNZR3JmZ0x0?=
 =?utf-8?B?OVE1aGRFN0xsY0lRQlhwWC95RmZIaEdtUVhVKzN5U3dKeXM5N0k2c3gvRDMz?=
 =?utf-8?B?OEE0bEVweURpQzE5aHBVbWcvSXZVWmlmY0c2WXNaSnVwN1RCM1NkQTM5YlY5?=
 =?utf-8?B?aWhiZHVOZHhQc1drRHlwRmxIdklhVEtCdU9qbVFKbmh6QnQ0M2dCSGVDWVBu?=
 =?utf-8?B?UDViWWxLTGJjeU1va3duS2NWVGs0T3h6cnU1KzlsbVdBWkJrelRUaTF0Y1JI?=
 =?utf-8?B?b1pKUFJpWlgzak1RczYzN1FZMmZQQzFnbnVuNWlwREdTR01TY1R0ZWVOYUd1?=
 =?utf-8?B?NHBxYURVc0JTRGlOYUFpYmxUMEgrck9nMkMrRmtocVRKQTRTZ0RsOHhHbXFn?=
 =?utf-8?B?L1duZEtKdUVXWm1jQitsTTFOUnJtbnI0YWFOQUZJMkcvaE1FaFVaRHNlYjNm?=
 =?utf-8?B?d3hCMlhmK2laVndGTkxkSUZoODMreXRQQldoUnQya2hjSmFBQnhxc3FvWW45?=
 =?utf-8?B?UUFZTUxXUS94TXpzb2dxMU0xaUtoaE5sTzd1alUxdmN2TGZZY3FOWDJybFhV?=
 =?utf-8?B?aWFCZVFQL3NBT2JMdVFUOFdudDV3UTVKYnhjSEF2MGdvbHR2aFlEV3A0eDcw?=
 =?utf-8?B?bU12SWE0ZGh0SUV0cks0TkpBY0p5SDl4NTRIL0NUcFp2OVBmNnJ1K2M1dFVR?=
 =?utf-8?B?MzhSSUJxSWRlSFdkRWY3ell3ZGVkNkVtSy8zc25GNG8xaDhiR2Jud3dJcXJz?=
 =?utf-8?B?VkJBTm52d3lQemF6MHBLRGVwL2NpMGl6M2VuWm1qOWNUYTN0dms0a0YvWjE3?=
 =?utf-8?B?MlhSKzNuQnM0ZEJXNGtFb3VVclVyNmc1S1AwbjFmWEdEbjhlNFlnZjF4Z0Fp?=
 =?utf-8?Q?HoNEzCxp2Cc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21NdWtZNko2dCszRVlBc1paS3FDTGdLWGNrd1FONGN5alRiS3k3MUMxcGc5?=
 =?utf-8?B?RXBnSWdlRVBGV0g2SWpXSEZoeFZzUkVlVjAwQnBqSFlJNEpjMG1NWWMwZmZI?=
 =?utf-8?B?dGFVNDR2UGFzbEF3eUlJZmNWeTVkK2NqVXNhOHgyeittOTIrUjlMMFk4Snpv?=
 =?utf-8?B?dUhNZWJVelg3WDhUZXVnSkZNdUNzc3pnR1ArMUx2SzEvNzV6SEhjeVVINTFD?=
 =?utf-8?B?dGFnUUloanFqTEVvVWswZjVQZVphSzJDTVBVUElnd3prQ1lKMTRXSWJTTEYv?=
 =?utf-8?B?NDNLVW9NbzRMZVhJKzhITjRDL1d6ZVVhN0dnZXF4QWoxQzEydk1BZHNJblNk?=
 =?utf-8?B?RlQrTVFocmx5WFB3T2VGRkFESWRjckxzWFFQSndIckhsaXE2ZytQVVk2MzlN?=
 =?utf-8?B?dXRpUkNpSFcvOGEvNHQ5QklJb2RyQ25iTVZET05EV01zNEdleFgxNktVL2JQ?=
 =?utf-8?B?K3lXNFRLS3BxM3VkQnVyU0N4bWhxTEwyNG9jRERDY2R4QytzREduUjM5VDZ3?=
 =?utf-8?B?eVM2Ty9UTXpERHd5TGgydWhEeTJIS2Z6OXo2RER0TXBDc0dYL0xtUUxQek9m?=
 =?utf-8?B?SFhiR2MrYzVranpwS0JEK05LRElhVDdVTTI4SGpPY1JxaGpKRDBzWFAydFBQ?=
 =?utf-8?B?b2VPaUF2U2NINTZZa2NyMkVJVHYvSWpkOHVyd0FpWXJxbkVMejI5ejd2c1lG?=
 =?utf-8?B?SXZwajI1VW9UWUdaUlVodjV0Mm4rNk13N0FwQlVwT3BIQWZlWlJWbGc4OCtz?=
 =?utf-8?B?b3BwVGZxSjFwS2MwMStpNkE5aGw5UmZCS0JUS2IwR09wMGZuV09qQXZRYzY0?=
 =?utf-8?B?bGpib2dsRVQzcVhtL2x4a3dyd1JKMlhQbk9iVzRWVi9GUC9JMHJHOXRGU2sr?=
 =?utf-8?B?aUJXZG1jcExNT3o0K0xqckhRTFlocTFFNTlFSFJWUEdiNFZ4anJDT3VTd2Vu?=
 =?utf-8?B?TTRSeWhkVjJBc3hqQVB4NGJ5cmJRN2J3bWl1Zlh1MVhhRFRvVFBIeFJGZ09p?=
 =?utf-8?B?ajVuVHA3SFFZSzNJOXRKQzdaQ055WXh3eVRIMGtPRFFKZlEwS21GWWYvU0Z1?=
 =?utf-8?B?MjNCZEpNV0NZVXRCOGl3YWpURWtWcDVPSmRGTkUwZzQ0cm9qckVickFENlhW?=
 =?utf-8?B?U1pvTXJsRGtJZWpSMWtVaFZlNWJEaGszL1lreXlLOFUrL2U4SlMwS24xZWE3?=
 =?utf-8?B?NlN4NXlGaEdkMGsrTTh5dWxyalZDL0hkdE9SNHdWS09vY1Y1c0R4R1M3QlJH?=
 =?utf-8?B?aEZZV1ZITXY2Q1ZUM0xFZ3dZczhibFRRS3ZpWEZ3amZWSC84NFJKOTZHTy81?=
 =?utf-8?B?MXdINzF4RnVaL0htdDB6Y0w1TzdZR2RzUEg2dFFqaDZkTTBHT29hZWtDYVBX?=
 =?utf-8?B?YzkvNlU5SDEvUitqVGZFTXJYaEVHUlBKWnA5eWhNK2tuQWd1VmRZdUNBSmVv?=
 =?utf-8?B?dzNTVEFDdi9uVVpxN0UySXRiTjluUXVRdE0xaXNrK3BLVEpzQzAxS1dBVVNp?=
 =?utf-8?B?aEl1Q0xaRDdxQ2xkQUpqM0NIRnV5b0ozZUFUZ3praEQrQll2ZVR6VlRxblhR?=
 =?utf-8?B?LzFNZlpzV0wyZWZPZ0VGRnlrUWZ2VGU3RWd5NWRkUk9DT1Mzc1lBYWZuTVZ1?=
 =?utf-8?B?a28wYjgyTHA2NzRoZVVmVW82ZDB5RTBFNEJ2OWVZT25XQ3lJNVFKNmhoLzNV?=
 =?utf-8?B?S25vRWE5Sk9xc3lBcTZMNStjUXB3YnJLajFqWXJ1ZmZWTmxmMTlVSG9mOTFH?=
 =?utf-8?B?UWhxVUd2R0R0bWo0QjZpaktuL2FMTTlrQ3R5aHRGc2xiT2FNeDNXVzNIaWdV?=
 =?utf-8?B?VFZ1SEp2QkpwQUlSYkF4TDFuV3lVV2lycUhuUjR4ZDQ3cmMwVkVoSDdFK0dl?=
 =?utf-8?B?cnIwMS93ZzEvYzFzcE5PeFpyTitvVi9semxBTUFmNFEycVZZSFM4RDVRK3dL?=
 =?utf-8?B?em80bE91Mmg4RUdmMzRWbFlwdDl0TUZGb0hQL1NjQk43SEdSQVdyRnVsVFQ1?=
 =?utf-8?B?WHBwVlVka0RKL3U5d25WUDA2L2tENHhodzJxWXJkbi9DY2cybEVHaVpNYkYy?=
 =?utf-8?B?ckVKMXBYc0kxL1UrUlpDWTd2eEliTlN0ZlRycXhEeGlGRGlkRnhSSmt5N0Ni?=
 =?utf-8?Q?SpBnyEfuL7iyQco7zBcwLelfT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a96336-19d7-4a90-41b6-08ddeee90f52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:04:51.0756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP+z2ybjn6NscEQ6vZXl+gRpvWDtNiukJUO4AWSfa/cF6zUR9CiV/LMvOCFGeYug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8
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

On 08.09.25 15:51, Alex Deucher wrote:
> On Mon, Sep 8, 2025 at 8:54 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 05.09.25 20:39, Liu, Shaoyun wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> I can confirm that during world switch the entire gfx block (including gfx, compute and sdma for gfx10+) been switched together .
>>
>> Yeah, but that simply doesn't work as expected.
>>
>> The problem is that the world switch can't preempt running gfx shaders and compute shaders only when CWSR is available.
>>
>> Now what world switch currently does is to wait for the gfx draw to finish, then pause the gfx queue and then other the compute queues.
>>
>> When gfx starts first that approach works, but when the compute queue runs first we then try to preempt a compute queue which is waiting for the gfx draw to start.
>>
>> Since we don't have CWSR for this compute queue this results in a lockup at the moment.
> 
> Compute queues can still preempt without CWSR, it's just dispatch
> level (like gfx) rather than instruction level preemption.

Yeah, exactly that's the problem.

It can happen that the compute dispatch is already running and waiting for the gfx dispatch to start.

But the gfx dispatch will never start because we are world switching and gfx has already been preempted.

If you preempt gfx first it can happen that compute dispatch waits for gfx.

If you preempt compute first it can happen that gfx dispatch waits for compute.

As far as I can see that is unsolvable with the current approach. We would either need CWSR for mesh shader compute dispatches or a global barrier for each submission.

Otherwise the hypervisor simply lacks the information and handling for executing a world switch when gang submit is used.

Regards,
Christian. 

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards
>>> Shaoyun.liu
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>>> Sent: Friday, September 5, 2025 9:32 AM
>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; timur.kristof@gmail.com
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
>>>
>>> On Fri, Sep 5, 2025 at 8:47 AM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>
>>>> Gang submission means that the kernel driver guarantees that multiple
>>>> submissions are executed on the HW at the same time on different engines.
>>>>
>>>> Background is that those submissions then depend on each other and
>>>> each can't finish stand alone.
>>>>
>>>> SRIOV now uses world switch to preempt submissions on the engines to
>>>> allow sharing the HW resources between multiple VFs.
>>>>
>>>> The problem is now that the SRIOV world switch can't know about such
>>>> inter dependencies and will cause a timeout if it waits for a
>>>> partially running gang submission.
>>>>
>>>> To conclude SRIOV and gang submissions are fundamentally incompatible
>>>> at the moment. For now just disable them.
>>>
>>> Are you sure about this?  Thinking about this more, most gang submissions are between gfx and compute.  The entire GC block (gfx, compute, and sdma on gfx10+) gets preempted on world switch so all of the active queues would be preempted.  Everything gets resumed when the VF gets switched back.  VCN/JPEG gets switched independently so that could be a problem if you have a gang with VCN and GC, but I think all gangs within GC should in theory be ok.
>>>
>>> Alex
>>>
>>>>
>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 2ac9729e4c86..434a551365c7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>>>>                 }
>>>>         }
>>>>
>>>> -       if (!p->gang_size) {
>>>> +       if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size
>>>> + > 1)) {
>>>>                 ret = -EINVAL;
>>>>                 goto free_all_kdata;
>>>>         }
>>>> --
>>>> 2.43.0
>>>>
>>

