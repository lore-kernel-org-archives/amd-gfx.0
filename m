Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A3C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 16:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F7C10E045;
	Mon, 20 Jan 2025 16:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jaz26X/F";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC8F10E045
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkKQRcYKlk//5f2GM3/yGrWRUo65kr/ih0iiDXA92NjJq7yuEkbpo4at/tVwgM8ifi12uOGU6cojhHo+zhxWDiyvNPQEDfjLEWKQe+kCn+5fwAM3/XJ49XnrvIkYa269gA11W7lsHknmkWQjOtNwXtfoXOy+8j4h1o37v23KTSldfxq6TxstcgY2hg2jwKp734gAiWVKjQqtV7s4qFQtbNyBoGyVP/AEiBng2kp9ZuvlwJ+y64x1ijrZpwOZecUFmIhV0tA7wPPuItpv4HsCMjrGsNfFU1ds1W0MgOnxExknAkkLx9xSDAbRYfiJU6/uQJNVszq1acfio8ZHq/WiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boRaP4pULnc3Jt40vvwx9qFomdQcrl8gsLyCxRT4Jtc=;
 b=nVZu/91Lq1h2Czku/34dy5gunWZkqOLr1v6V9/u2+Xj61tXVVs28+sN5ArACkB0IZ53UNOvILIThzh7P2VUd9kjeO8SjMwIx7gta5bHo2l+B7IndW0OaDv06bETPmioDchT7k9wiTZMMY88PbQbQizRpgLzFyEhUcn3zqOmQE2AujJZvJCbJQtk4lGk08VaI1PKEDFw4jBVvH68s4o9xCuaUOfly1QQiBXI6yGXwSrtPDDXX7gOXf2Qc/3uAK64C9XEPMmGk4sTZ43kxcdCDT+X/p6Y5k/0RCrf/ctLI99GFbIHWr549phalfBSrH4EJFgcRhLpx9F7Qyu8B8ZxLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boRaP4pULnc3Jt40vvwx9qFomdQcrl8gsLyCxRT4Jtc=;
 b=jaz26X/FiX2J3OozbCTURrHTktIyTolKewfS51UUPktishxps7n08oYkqOb4d4wAWTm7sWKHNdC9rSCntIvihvWdOPKLWVrhF9Xs99Xj6yk/Nn08UtG1rW6WJvUoUJlkIod9TwK+do/j9tVTM0a9OMRB7Jg9T2y/v1fgkGv8UyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 16:30:24 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:30:24 +0000
Content-Type: multipart/alternative;
 boundary="------------CvKGCk5SQlygSE9OM07DSoTA"
Message-ID: <ea9dea25-e2e8-4ee1-bc4b-8a06af47cabc@amd.com>
Date: Mon, 20 Jan 2025 10:30:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change page discontinuity handling at
 svm_migrate_copy_to_vram
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, Emily.Deng@amd.com, felix.kuehling@amd.com
References: <20250115214001.335607-1-xiaogang.chen@amd.com>
 <8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com>
X-ClientProxiedBy: SN7PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:806:125::16) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: da5d8f49-76c5-4ec0-05a2-08dd396fbda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUhBaWp2VzlMaTE1OWpaMEkyYklXb3p2TVphMWIvTm1UbUNOUUZKaHhyMFBQ?=
 =?utf-8?B?ak50eGpBMDBSNmZCRTZCR1U5eXNVcWwzSFZFT0NMZjVEcmtGVWgvWFBGU0ov?=
 =?utf-8?B?QTJuRXllQzhKdWhreXQwT1NqQTQyd3RuMFVYRHFiSnJ5UDFTTGYvMUE3UFQv?=
 =?utf-8?B?RjZBY0lZUUJCZTBNU2k1YjRpMWJ2T0kxLzd4Y0VmUHczTDBmNnErMlJTYWJS?=
 =?utf-8?B?U0xUQXBDVXB2TFFqdlZXMG9LQjhYbG5EMVJxanN5NklYbWM0Z2V2NW5QT3FU?=
 =?utf-8?B?elZlT1VKQnlkaWV1R3QrWVNrZVBGNUtZMDhEMUJIUzZoZE1xVjNCZU5RWVRZ?=
 =?utf-8?B?aXBBeXJRTnQxRTZ2Mm44TFAvVzR1QnNLdGprVGxFTzc1NjZoSXpaclk2WkNq?=
 =?utf-8?B?MTdVZWxFeU1pWFZMVGJ0R0J5UnhNWnRtLzQ4SVl5RjhLOXBOb1doWmszV2da?=
 =?utf-8?B?aDRDMlo1MlI1MEViNWtidGJITncvT0RlTElTa0M2WmFYcHFGaTY2Qi93MnZP?=
 =?utf-8?B?c3QwSlRRcnROZ3gwZ1Vra0RtR290WGlUYVZFYTd4OXNET0FKTjZBOFR2Qjg1?=
 =?utf-8?B?dU5JbW5pZW9pYy9xdnlFMERDSjBHVEVDMzk2Uy9DdFVNWFZHbHhhSTRPZnZN?=
 =?utf-8?B?ellGQnNLVDNGU01Ldy8zdVVicDJrU3V5MjlFdXpncUpVRVZjN2w2WjNsa1Bk?=
 =?utf-8?B?SGhwa1dQVUFwMjlKOUt3SHl0RkZreTZQSS92SmtqVU9JMnVxWXdrMXNrR3gw?=
 =?utf-8?B?MzRLaEN2YTFXdWJRdGZ0Zk83VjZrZjBMZFk3R2ZOQ3BQbzlNZ2pjMDRwTDNh?=
 =?utf-8?B?R21yQTlEdzJiR0tPbWhSTk8vZXZ0OWdFVkg4L3FOOGFqeUNCQ0FYWWZJQWJz?=
 =?utf-8?B?MUdvUjRWL1QrSjNtVzFUaDdxeFhxTUxER3hDT3NmWTVFS2VjUnM2d0I5Tldk?=
 =?utf-8?B?U09VeUFvazZVdDBCdEdrVXRDbThPWHVoOWVxVlFnSDdQclIwN0dyTk9JMDM1?=
 =?utf-8?B?eEtTNVlFY0hseDF5TEdVWUFLaC9JRktFTkMwcW11V0NmZ1RMRjBrcmJCYXE3?=
 =?utf-8?B?MTNPcWtLR0M2N1NocUR2bDRvMGo3NlAweS96L0lIUkwzajJQZE1QT3BkTlVT?=
 =?utf-8?B?NGtkOHI2YndGOFFYR1lvbERieFgwTjRwQW91UzFPM3VjdFJMc3RrV21UcFpL?=
 =?utf-8?B?RWZnWmVSMDUwNS90UEF6Z3ovaDlRTVFncWtmYkFwVWI2R0xMTXJ5TytuZVNh?=
 =?utf-8?B?dERJRXZDREVxVlJGTldRUit0S2pDUGR3SVFyRUx3cUZDa2ZzeVRUNGFFV3c4?=
 =?utf-8?B?NFU5Q2c0R3J6cDRnTC9GVHpac1BzaDRQRmYyRUY5b2lxMk9NbW95TzRhN1g2?=
 =?utf-8?B?aTc5QVZnMU53WFlHQjhLNVg4VXFJdkFxaGpyNWRqUHEvd2YyV3N1ZFErUk9L?=
 =?utf-8?B?WjFWbEY2S0dpeGJWaWEvNGFLUmNZTHZUMnYvc3k4a0NJZTZSZUViZG5HamJp?=
 =?utf-8?B?aVI4Qm8zWEZxeFhCZDcvN0FOOGxJYlVDMXVVVllGSGh1cVNQYWJIcm5lTXBO?=
 =?utf-8?B?cEIya3V4bFhuemNHQkJWdXZDcGhGT055bnY0Tnh6QWZmNGNiR2N1WE92SnVX?=
 =?utf-8?B?K1U5T2N5L0xKamEwMDlqV1luV3AyWEE5cDlYMUZ5a1cwVGxSMDcyQVJGSFdC?=
 =?utf-8?B?ODZ6Wk4rTHZjblJOeWxjb294R3p3cXk2Wjg5dlVuL3ZOL2JUK1F1ZUM2WThH?=
 =?utf-8?B?WHdKekZLMEtoY21PZWVDcExWWXM1U253Q0xUdlVDenBKcHdsWXZlWWJ3dHZM?=
 =?utf-8?B?UjV4Z1E0eDhKQW1SK2ZQczdtRzM5M0pWZFY1bjNkekpwZVdxd25hSlFHVzdB?=
 =?utf-8?Q?6xfA+Bk4lY5rH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlY3OVdWSEQyTUNBSXMvUkNFS1FmZGQ5SHNhUmdlRVlhRGM3Y3k3TGhiL2Q3?=
 =?utf-8?B?OVVtQzgyUnNsUitpYTVlWWw5RFVocnlPdjBmcXJ0YUllbVBJaDE3UVgzRkJK?=
 =?utf-8?B?SDZORnUwSXc1Vk5rNHljT2pmNkNrWVlTMjF1OHAxZExkRWFlVUtId3oyd3Vl?=
 =?utf-8?B?emV6cGlCQnA5SkZVR3UzVjBHcGRma0pidnUxOUV4alRmeTdkVGVpMG1saHlw?=
 =?utf-8?B?S1hKaXpocmtRY2JKL2U0cDlWNnNtNVJYMXJlNzJ6MWJhVHl0NjUwMnRHUXU0?=
 =?utf-8?B?Qng4dGZJeWZkaHAyQUtCdHJoTmFJUWZNOXVzUTd1ZFFRWFBKbE4raVZzTndt?=
 =?utf-8?B?ekc2OHpuYVlNZ2VnRzV1M1N6RXp0SFVkSGRxZVVRSjFsRU5mNjVWME84Yysr?=
 =?utf-8?B?UlFzWHJwZThUWC9aRUV2OEtubThDUkRlUEYyYWFpaExnT0tjb3ZWL2VwdTN3?=
 =?utf-8?B?VitJS0ZubDBmZzc2ZmF2YTI4RG9mT0xaTnkzUk1qVmpkZzZrOEh3MUNmdzVz?=
 =?utf-8?B?YTBIUVlVWTFxSDBwSDFOdkVYMFM3MWFHb003RUx2cGY2eFo4bWx2aFc3Z1c2?=
 =?utf-8?B?bS82Ym5XVW04QjFRTjB2YlNOdE0rNmpuUEEyRmZJbzd5ck9VeVZPemZ1dVpJ?=
 =?utf-8?B?M0ZoY09UMjZHQjVyeStMWUtUZUZDOHcwVW4wRzlZcUdvOWZaa0oxcTFhYmpW?=
 =?utf-8?B?blFaaThHWUJnY0g4amVJWEg3T0lxVTNhblh0azFaMGRXeHAvNCtTSXYydEt2?=
 =?utf-8?B?U0tlZzM4bWVwemRpTy9OcjNtRXJDRVBaMjQvMUNTVlBHZlY5WkpSVVIzNUtl?=
 =?utf-8?B?c21ZdVo0NDdvZTN6b2tBblhvL1lpTFRmNWc2eVg3ZVJjd2ZIcm9CdnFTSXpJ?=
 =?utf-8?B?NnkvZ0VIcmxxKzBpWUhheFRIYjlLUDdObXlETm9ZQVA4OTNUS3RjbXY3ZENx?=
 =?utf-8?B?SW1ITWhnYldzK0RwN2VwMURHRFoxVlMyWG1CSThsQTk1a25uSUY4aFRtb3FX?=
 =?utf-8?B?VXZiVnpKZm8xMTREejY5cWR3dC9NMlpPdEUwREU4WHg3ZldCZkc2WWE1WmhU?=
 =?utf-8?B?TFcwSVJpODVKWVpMM3B2dG9TWWNJSFZXVmFsdXRXNDIvRFpjQVE2cUdYN2RO?=
 =?utf-8?B?czMvWXczNHVtdGgrTVg0b3N4cGZsWGg2Q2NlSTA4b1lqeXY3YXM3OEgwaHBz?=
 =?utf-8?B?L1lWdk1ZaHNqbEQvdDRUYUlGZXU0Y2UxS3lsVENXUERsSlhYY2F1R0FseGdX?=
 =?utf-8?B?c0tqUVN4Ykw0VUdzNlBoRGE2QnRhdzR2QXRmb1dZUDlEMnFvNDFUaVlJK1lY?=
 =?utf-8?B?TGhUSG5HcTFLZ1ZXeUM2cUhyM04xMDFhLytzaGpBZDVjTEtUU2dKNWo1Vy9T?=
 =?utf-8?B?VkV1YUVUYkFqK24rTitwdUJESkFRRm9lUUh2ZWUzQWpvWkM5NGpQa0hhN2dQ?=
 =?utf-8?B?ellPLy8zb1BFNSsvaTNhaXNFckFqS1R4b1pKdmNCeGwvUzViWGNIRnRVdHMx?=
 =?utf-8?B?TW1kK08xN3ZudnRPMDdUNGlxWXA2RGxhcTJCWUNERkU3VWNFem1yWHVKaXB6?=
 =?utf-8?B?a2EvYzNaWUZPWG5sVzZZWWUyZUJwTndnTU5rVGlEM2ppZE9nY3lUNDIxMTlw?=
 =?utf-8?B?QTNzQ2hGdDFDd2UvU2JQdnluQnRGdVFJTGczMlJnWlM1T3JjS3dyV1hqMTVz?=
 =?utf-8?B?LzdCODFrRnpKeVJEamtKQ2lCbXdJdC9pZko4QUs0U0tySTRVeS8rYkw0WUt2?=
 =?utf-8?B?bGdSQmxkMkhZTWV2UzhhODd0N3FSM3JLNTMvTWRBaEdxTkd2aVFnbWdQMUxn?=
 =?utf-8?B?RkN0bjUwRElUOWl3b1psZVZ1V2l5d1ZaSnlhcm5VYm5KOXNtMjIzaml3TUlH?=
 =?utf-8?B?bUg2bUw5czQ1dlpROGRuUzdWeC8vbDIrTnhySWZuWExLSDVpWHcyeXB0UHFh?=
 =?utf-8?B?NzVOWDRqNkhDTVhmTG5Cb3lxSlRaWURHNUw5SW9ZblpXc1IySHh0NmU0SlpX?=
 =?utf-8?B?eVlCMTI1VGl5Y3EyZWRsdGcvWCs4bHhYTDhlOEVqWGxBS3YzbElNcE9aR01I?=
 =?utf-8?B?WnZuenVjbGdFVFMzb09XZG9lSTZHVW50WE9JRXRHb1Eva3F1UVFqQnlmN0tI?=
 =?utf-8?Q?tbiM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5d8f49-76c5-4ec0-05a2-08dd396fbda6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:30:24.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrremV2tjQdXDIfBkTBkaG2/7B4DmSQzt5Nf4DgFlaZkq4LXXGSicBqAgwi0snLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
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

--------------CvKGCk5SQlygSE9OM07DSoTA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/20/2025 10:13 AM, Philip Yang wrote:
>
>
> On 2025-01-15 16:40, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> Current svm_migrate_copy_to_vram handles sys pages(src) and dst pages (vram)
>> discontinuation in different way. When src got discontinuity migrates j pages
>> that ith page is not migrated; When dst got discontinuity migrates j+1 pages
>> that ith page is migrated. That cause error path have to iterate all pages to
>> find which page got migrated before error happened. Also makes code more
>> difficult to read.
> error handling path loop from 0 -> mpages or i -> 0, to rollback 
> migrated pages, I think both way should handle similar number of pages.
same number to call svm_migrate_put_vram_page, the loop number is not 
same. The change is not about correctness, but make the code more 
straight forward to read. At error path a more logical way is rollback 
from the place where the error happened, instead browse all pages.
>> This patch handles src and dst page discontinuity in consistent way, has its
>> logic and error recovery straight forward.
>
> I feel that svm_migrate_copy_memory_gart move to the beginning of the 
> loop is harder to understand.
>
If you feel handle vram page discontinuation at beginning of loop is not 
natural we can put it after sys ram discontinuation handling. The 
purpose is handling src/dst page discontinuity in consistent way.


> Regards,
>
> Philip
>
>> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 68 ++++++++++++------------
>>   1 file changed, 35 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index d05d199b5e44..2ce78c77f203 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -299,6 +299,19 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>>   		struct page *spage;
>>   
>> +		/* accumulated pages more than current cursor's block has */
>> +		if (j >= (cursor.size >> PAGE_SHIFT)) {
>> +			r = svm_migrate_copy_memory_gart(adev, src + i - j,
>> +							 dst + i - j, j,
>> +							 FROM_RAM_TO_VRAM,
>> +							 mfence);
>> +			if (r)
>> +				goto out_free_vram_pages;
>> +
>> +			amdgpu_res_next(&cursor, j * PAGE_SIZE);
>> +			j = 0;
>> +		}
>> +
>>   		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>>   			dst[i] = cursor.start + (j << PAGE_SHIFT);
>>   			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> @@ -306,17 +319,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>   			mpages++;
>>   		}
>> +
>>   		spage = migrate_pfn_to_page(migrate->src[i]);
>> -		if (spage && !is_zone_device_page(spage)) {
>> -			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>> -					      DMA_BIDIRECTIONAL);
>> -			r = dma_mapping_error(dev, src[i]);
>> -			if (r) {
>> -				dev_err(dev, "%s: fail %d dma_map_page\n",
>> -					__func__, r);
>> -				goto out_free_vram_pages;
>> -			}
>> -		} else {
>> +		if (!spage || is_zone_device_page(spage)) {
>> +			/* sdma accumulated pages before src got gap */
>>   			if (j) {
>>   				r = svm_migrate_copy_memory_gart(
>>   						adev, src + i - j,
>> @@ -325,29 +331,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   						mfence);
>>   				if (r)
>>   					goto out_free_vram_pages;
>> -				amdgpu_res_next(&cursor, (j + 1) << PAGE_SHIFT);
>> +
>> +				amdgpu_res_next(&cursor, (j+1) << PAGE_SHIFT);
>>   				j = 0;
>> -			} else {
>> +			} else
>>   				amdgpu_res_next(&cursor, PAGE_SIZE);
>> -			}
>> +
>>   			continue;
>>   		}
>>   
>> -		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
>> -				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>> -
>> -		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
>> -			r = svm_migrate_copy_memory_gart(adev, src + i - j,
>> -							 dst + i - j, j + 1,
>> -							 FROM_RAM_TO_VRAM,
>> -							 mfence);
>> -			if (r)
>> -				goto out_free_vram_pages;
>> -			amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>> -			j = 0;
>> -		} else {
>> -			j++;
>> +		src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>> +				DMA_BIDIRECTIONAL);
>> +		r = dma_mapping_error(dev, src[i]);
>> +		if (r) {
>> +			dev_err(dev, "%s: fail %d dma_map_page\n", __func__, r);
>> +			goto out_free_vram_pages;
>>   		}
>> +
>> +		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
>> +							 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>> +		j++;
>>   	}
>>   
>>   	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
>> @@ -356,12 +359,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   out_free_vram_pages:
>>   	if (r) {
>>   		pr_debug("failed %d to copy memory to vram\n", r);
>> -		for (i = 0; i < npages && mpages; i++) {
>> -			if (!dst[i])
>> -				continue;
>> -			svm_migrate_put_vram_page(adev, dst[i]);
>> -			migrate->dst[i] = 0;
>> -			mpages--;
>> +		while (i--) {
>> +			if (migrate->dst[i]) {
>> +				svm_migrate_put_vram_page(adev, dst[i]);
>> +				migrate->dst[i] = 0;
>> +			}
>>   		}
>>   	}
>>   
--------------CvKGCk5SQlygSE9OM07DSoTA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/20/2025 10:13 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2025-01-15 16:40, Xiaogang.Chen
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com" moz-do-not-send="true">&lt;xiaogang.chen@amd.com&gt;</a>

Current svm_migrate_copy_to_vram handles sys pages(src) and dst pages (vram)
discontinuation in different way. When src got discontinuity migrates j pages
that ith page is not migrated; When dst got discontinuity migrates j+1 pages
that ith page is migrated. That cause error path have to iterate all pages to
find which page got migrated before error happened. Also makes code more
difficult to read.</pre>
      </blockquote>
      error handling path loop from 0 -&gt; mpages or i -&gt; 0, to
      rollback migrated pages, I think both way should handle similar
      number of pages.<br>
    </blockquote>
    same number to call <span style="white-space: pre-wrap">svm_migrate_put_vram_page, the loop number is not same. The change is not about correctness, but make the code more straight forward to read. At error path a more logical way is rollback from the place where the error happened, instead browse all pages.</span>
    <blockquote type="cite" cite="mid:8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com">
      <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">This patch handles src and dst page discontinuity in consistent way, has its
logic and error recovery straight forward.</pre>
      </blockquote>
      <p>I feel that svm_migrate_copy_memory_gart move to the beginning
        of the loop is harder to understand.</p>
    </blockquote>
    <p>If you feel handle vram page discontinuation at beginning of loop
      is not natural we can put it after sys ram discontinuation
      handling. The purpose is handling src/dst page discontinuity in
      consistent way. &nbsp; <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com">
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 68 ++++++++++++------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e44..2ce78c77f203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -299,6 +299,19 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
 		struct page *spage;
 
+		/* accumulated pages more than current cursor's block has */
+		if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
+			r = svm_migrate_copy_memory_gart(adev, src + i - j,
+							 dst + i - j, j,
+							 FROM_RAM_TO_VRAM,
+							 mfence);
+			if (r)
+				goto out_free_vram_pages;
+
+			amdgpu_res_next(&amp;cursor, j * PAGE_SIZE);
+			j = 0;
+		}
+
 		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
@@ -306,17 +319,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 			mpages++;
 		}
+
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
-		if (spage &amp;&amp; !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
-					__func__, r);
-				goto out_free_vram_pages;
-			}
-		} else {
+		if (!spage || is_zone_device_page(spage)) {
+			/* sdma accumulated pages before src got gap */
 			if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
@@ -325,29 +331,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt; PAGE_SHIFT);
+
+				amdgpu_res_next(&amp;cursor, (j+1) &lt;&lt; PAGE_SHIFT);
 				j = 0;
-			} else {
+			} else
 				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
-			}
+
 			continue;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
-				     src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
-
-		if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
-			j = 0;
-		} else {
-			j++;
+		src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+				DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, src[i]);
+		if (r) {
+			dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
+			goto out_free_vram_pages;
 		}
+
+		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
+							 src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
+		j++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
@@ -356,12 +359,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);
-		for (i = 0; i &lt; npages &amp;&amp; mpages; i++) {
-			if (!dst[i])
-				continue;
-			svm_migrate_put_vram_page(adev, dst[i]);
-			migrate-&gt;dst[i] = 0;
-			mpages--;
+		while (i--) {
+			if (migrate-&gt;dst[i]) {
+				svm_migrate_put_vram_page(adev, dst[i]);
+				migrate-&gt;dst[i] = 0;
+			}
 		}
 	}
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CvKGCk5SQlygSE9OM07DSoTA--
