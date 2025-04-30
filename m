Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5108C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 11:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9008810E75A;
	Wed, 30 Apr 2025 11:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0i3uJ+id";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA00010E75A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 11:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO6oYvI6VWkZCFJZbRI38Q/MgzF+KyfuGuoCwQlEdbbLGkpQveI4PHbE+jwlRB9tatAUM3bryRAPtzN6GJUEBLFlepyra/sIXGjnEJlTVVqP+82DDgegCQOLNmKOo8ILd2v32A5yd5GdFT4O2HJk5us6mWLWTl2D7Rf7p/xIDvi1rI5rkBmLlExMTULqztODcbN6ooPkS8cTdKzZwdA+PWbAaX7ZAmWL1Y7bEE1TUt9f2z1Agkc7gslsZ5A51hJLjuk/FI+Wo1a1VpVhGFmBn7UPCuuFgD/oIges6PVt9bfPV0qAsU+gNKk22FCtCWoiB897zkqrGmax7AMxjjwMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jLbBBamNjj4Cm8HtuUcBzZIrJHUEzD3+QFHNCWf0kQ=;
 b=GQLwsoFM4QjgqSXhmQmliQA8rF1Oind1iXCLkyDq1YEelTp7394bf3EnNT/VJx0utk/lBef72MjP3IY6fjsYazKGs59hL245SlnOe3kAMWU6VlPrJB3ZMjdFw0aDd+6GnMSMuDw5Mivks/Zcb5S4lwQ8n9u3Pshf5Y+JaYuinXioRXaL8VzhOjbQ9RmKUqpoE5quuqV3BIZNV4bzDZXPzL33lcUmxyO9/l+UbmjRaewpoD66kt2YgVMBlhlheD+eRaPrNk1Gydj0YZKRdKGxXXDyyvi13PCbVEq3V6IOuD9b9whoi3GCUF6O/EC/p4/ZT2/E+2t1O45Hl/PjR+k+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jLbBBamNjj4Cm8HtuUcBzZIrJHUEzD3+QFHNCWf0kQ=;
 b=0i3uJ+idboYoKXvoz/e19RVZaFL1e3e42XDFMdOLFz703r4oyd0S+FBrZD2sYq28hxze+4gPgvym1S9aVWnlQxqFbqVYJuBqkeRnxEdI4xTFKzbLeFhmfcexqntZDy8NbB2sX1NLA070qC4utPf0wFNWXA8NwPk/L87tqVv7MTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 11:56:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:56:47 +0000
Message-ID: <5f56c1c5-5bf9-42b9-b7c7-9e6508e803d0@amd.com>
Date: Wed, 30 Apr 2025 13:56:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/amdgpu: don't sync the user queue eviction
 fence
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430024054.4093239-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2347b629-2a27-4e54-bb1b-08dd87de156c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlpFTFg2RysrQUd6RXNQcC83QXBURjdkclk0MWxjblBTaHNMbWpsRnJXU0p1?=
 =?utf-8?B?RFA1alpXRDRGYmVNR3p4d2J3NndXemtkMXBGbDA5eGlST2ZtY0hKeGhOYno2?=
 =?utf-8?B?L3lXTGZ5ck1ZOGpKRTNtVy85Q2pNVFU5L1NDRDhPU2tZMHhJR1NsMG4xQi9k?=
 =?utf-8?B?WG9pMk1ib08yblR0QXZ6aUZCVFNXajhJTGVtYTM1VGo0RlJNOEs4V2NEWTZJ?=
 =?utf-8?B?anhMOU9JcDF2QVFGU0FySFVkekNjTWYwbW0rSkdBRWVteFpsV2RyMmJPdXdE?=
 =?utf-8?B?RDIxbHFqV3gvZ3JDSXhtb3U1Y2RaTTdiSzF0RmZHQUZJaFcxSVhSeFd6Ni9k?=
 =?utf-8?B?QVFKalZ6RnBENmp0QlcrZ3J5dGdxY3RaM05rbmJNT3FMWkpNbGY0RzR4cjJZ?=
 =?utf-8?B?WmdhRzZMOXU5QmNpdmcvdWhQVzkvck55TXhQNllTdmlDZC9mQld1SmlnbHZl?=
 =?utf-8?B?Q1M0MlJpYkQwS3Q1U1lMQlF5M0tvR21FYTRUdDNEOHRxYk5TN1lZQmEyTDhI?=
 =?utf-8?B?U3dMZXB4Y3FZcVV4blBESG9HWGwya0NWY2ozQ0VIbDkybGIrWWlPelJ5eVcy?=
 =?utf-8?B?Wmx5WDhZWWdNdHE1N3pTZi9STzhnNVJsa005WlJqeHBVOU5VOHYvY3l3SXpW?=
 =?utf-8?B?bm4yM1JqVEF5SHRkRE5SU05HOGNEbnlnRzhuclNKTGZnSnlFVFdqemo1eEps?=
 =?utf-8?B?S1FSSFkvVWYxNVlyT1krVy9KVUJ3TW5WallqaHh6cUloR3kwVnE1Zjg4a1FM?=
 =?utf-8?B?UC9MZXhrdEdBcitpM3RGMERKVkh0d3VEQ0tTN291a3pCVVM2bEJyYW1peDVX?=
 =?utf-8?B?anJmWVRUVHM4ZkhvenVUK1RRdGRRZ2hQOFZWcGphODc5V2wxVllJZFZEZkd4?=
 =?utf-8?B?TXlwUTEwVVo2cE41eUo4VmRuVENLbmtFTjVDeDROWUFiVCtlTWJ4M3daa0dG?=
 =?utf-8?B?ZkF4amlsMGZIZmxNQTBLeHJvTzRUaEw2S0t3ck1tQUZzQ2xkL1NTS0lyMExl?=
 =?utf-8?B?UVRLTTNaNDNpaERJNjRveDFLQ0JWcFVlWWE5RnZHeHB1b21UandGejlOckdX?=
 =?utf-8?B?NS90SUlrWk52OUVoRnBSWnZNQkFLdnE1ZDZqRjNCb01XbWJSMkErbG1hM0lI?=
 =?utf-8?B?V2lUakwyRlN3cUpkTzJTRGNiUzBsbFZ0bUZLVkM3c1JoLzNUUFBlcFBKNVlj?=
 =?utf-8?B?WHg0QlRKNUVISUJZT2svTDJLWXkvQ21Fd01Kc2oyZktPRk5FS0JsblZOaGx4?=
 =?utf-8?B?WFFiUWVKeUtTdmI5QlhaWEZKNnBhM3BDU0pwY2x5d0NQMSt0dmZNY0VmY24y?=
 =?utf-8?B?aTdRZlZmbTJTSUZOUGxLWXhkSVdjb0ZqMUNQYm0wd0tta0xNWitjOHhpVDV2?=
 =?utf-8?B?Uk93cUdNaTBHOEoyakFWQkE2SHBSUnZiMDRKRklpdkY1SjNhaGZDWDI1cXh5?=
 =?utf-8?B?bzNJS1dhS0V4T0tVZURRdjRNTVBleGJNVnk0RGNCUU03V0ZPZS9Ha3R2UExj?=
 =?utf-8?B?aEhqdWNRZVVpRlpWUk9yL3NRRERWZElmaXJyOTh3YTdGRTlRV1R1dnRSWG9l?=
 =?utf-8?B?eFlWQS9Ea2xnZzZXY0RKUHpPZWRwWnFkMmRjL2xTVE1ZRUV5MzN1QjRZaTFX?=
 =?utf-8?B?U2NGTVp5cUpvbEp0enR3VDhZUGZUaDg1S0JWbkR0azhWNTE5VDlaUGtnazlN?=
 =?utf-8?B?YTFwQ3VBRlcyT3F3QkhSaFBMYWNsYlJpVmR2eVpidkRxVHFtcFBGdEwxdVJ2?=
 =?utf-8?B?VXh2bnRoWXQwdzJFL1ZtVGFBeWgvbENyS2hydFdDd29ydnU4MGZtZnVrMDh6?=
 =?utf-8?B?WitnUzB1ZmFmK2JNOFE3UC84Zml0OVhJQStSYm45NW55QWpGTjN4Ymp5Zytp?=
 =?utf-8?B?NWhISVQ1WVFDcmVFZWYxcTRGeHIxUnN2eVRRWmQxZ3FTbnRybzVXbGVLOFhl?=
 =?utf-8?Q?YzE9ZTfnStI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29VcmkxMUFpajVBQWUxWXZncXlKSkZLcGs0NFZuZnJhR3dZK0hLSUYzcU8w?=
 =?utf-8?B?MVgxczV5eS8rYXIreWtUUGR2NjdVMXI0U1hEYTIzbzdlT3h3UEFGRGpxSzhT?=
 =?utf-8?B?bUErVWRPalBLMlZGa0dtYkk5QTRuMHFtd0VUN0IzYXdtenFQOEVHVE5BTkZG?=
 =?utf-8?B?dFhQRy9uOG1YbDdEUDQ1dHludzJONzZmR1UyWlRyWGZFeHp1RVkzRVJ1eGhC?=
 =?utf-8?B?dEh6RktZcFJoOUp6Z25jaGozYU9ucGgzc0s4REtyMTY0MStSa2pENk5JVmZx?=
 =?utf-8?B?dU5helFOcXJiSEY2TWlzMWM3TzVwdFFJSkV5TmxrUVdtdzVZWjJ5Tk00QnB2?=
 =?utf-8?B?M0g0SC9sRDQ0RStvY1F2cGNUdG5rMkl2QU1NRmtDTFVoaEgrVWV2RWVDQUhM?=
 =?utf-8?B?S3pBWjZjRTgwTzgzbndaZUhoem5oRXRFN25ISkhzUjRzNVlqR2g3SmZIQlFy?=
 =?utf-8?B?a3I1K2dTVHJLV1UwV2VGVElEeWJzOW9tN25laDU1UVBlcXBDR240RTFQUGVV?=
 =?utf-8?B?Y2t4MzdlN1NJNGNNY3BlOE1rUDM4WEtIY294NEFVUjNya2E3QU9XMnNJbFEy?=
 =?utf-8?B?NWJTdFFEdEVqOVZlaFJRSXZ4cm5ZMmw0RjZaZHF2VFlUNlc0bkV1SDJsQzVu?=
 =?utf-8?B?SDYxcldiNXZ3YXpieWtPRTVldGJpMDR2RmlpS29aWmlSUlNHSkVNcnRUeE55?=
 =?utf-8?B?bDdUY3ZSNHhQYlRoUnJQRFRLZldZRHJuc0lTTnZyUzJXN1FtRGpmN1ZGeU9N?=
 =?utf-8?B?anE2VXdrMTdFRXBHMGdreHA0a0dzcWwwUlVSRmZpWnVyUlg2Z05qMXg5Mms3?=
 =?utf-8?B?eTZVU3J4dXhwaW5vMW1Qa0poLzg3aGZWbXNucU0rRXdlR3VCbkZWbWsyT1Js?=
 =?utf-8?B?NXlHNjdxNExyRWIwVEVnMkgwWlFuYjByOUFYL1RLVFg5M0tUMGN0dzJBTFhz?=
 =?utf-8?B?SCtwNnUyVHRVOTkzUDUzbnUwZm9ucFFzMmZ1TG82dUZ4eUg5bTdzSzQzdlpq?=
 =?utf-8?B?YzQzY2lNTGh4Mmh6anB0N25hdHJvUzJ3dFpNQTliRklsdjg0ay9udXM0RXdO?=
 =?utf-8?B?K0V5ckMwQUNrM05qUitmK1pvek9TZ2VtYktJdVkvTmtSU2x5czkzV2FGbkla?=
 =?utf-8?B?SWpDK3hPeVNkTldMRStQdTdSaFpmdENJRjk3dkRxUm16NXB2QVVXRURLOENR?=
 =?utf-8?B?b3ZmMlM0NGZ2TmFHYi9qakNHcTdNZzlkUTQ4NTB6NGFlNG1YZXJVYmdPSk5H?=
 =?utf-8?B?S3lRY2R0QTRleDRldERyNlo5ZFJlbXJkTlM4TFQwVUZqaEFVTFl0Z1kvMEpl?=
 =?utf-8?B?aFBVODB2bFpocW8wME5BdmduZVdRcVl6NC9ONnRsMVNZWXY2eWJOM3BNSEQ4?=
 =?utf-8?B?bVoraFJEbDFJRE54ZGVwaXZnbjY2NGZWS0tFQWUwNTFWSEh3cEJaaVNrOXhs?=
 =?utf-8?B?ZWtJSTZQNk9scjFXc1NjU0pOb2FVZWNyVFdNZXU5SGdFOHMweFkvWXhGblRU?=
 =?utf-8?B?SWdUbE9TQWt4YnhhMnlpaFVkMEFNNGZBdGVxU1dRS3JKRXFJeTBZUEtzREM0?=
 =?utf-8?B?V0hqdEkwK3k3bllsYWRTMVZhYnhNb0NsNWhrcE9wNkgxUjAxZUxTcWxxNmti?=
 =?utf-8?B?alYwdVV5M0tMSk5qcEl0eHJONUpOcHpZOXBPSUJRK0hTNTlxbzNmOW1vVDJK?=
 =?utf-8?B?aWRVQTBWMk1TUVlpd0RKY01HVGtrTGw0aUNycTIzWWk3VmlwYk5kMXY2dHZo?=
 =?utf-8?B?MGVqS3NZSHVCMEFROTZVU3VQQkdDQlo2b2NjRGpXZTk3RDQ4dnByNFJjbFly?=
 =?utf-8?B?M1BBM05QUDdPMW1lQitjMWYwNksrZkRBVjRsVWNPTEdaNHpPWXhzWVFONUxN?=
 =?utf-8?B?MEJhd0w1VTRKUHVZSDZyYk90Q1FDRm12S3FkOXFQdTFpRlB1YjQ3b1JkTjZ1?=
 =?utf-8?B?ZzRBY2RnMHNNNXhKQjNwai9WcmJHTy92SmkvVndFNlJMRGZ5ckp3VXBlMEhS?=
 =?utf-8?B?NCtETU5tWkhIR0grU2J2Zkhpa2srRnRMVmZ1eXRYN0lrZzg0ZUFwZkZ2ZzZL?=
 =?utf-8?B?cWF4bzBuOHhOUktQZ202aHYzQlNNUWJwcUxBd2pZWmZ2L2txeGM5UmpTSUVG?=
 =?utf-8?Q?XuVvgiXJglgVq/3E0oRTMZfUT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2347b629-2a27-4e54-bb1b-08dd87de156c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:56:47.2717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZn5yT7NetmKT46BahtA103AW3OJy+FPPp/m9/hxSimQ199uRlEQx4T9oBZRgCiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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

On 4/30/25 04:40, Prike Liang wrote:
> Don't return and sync the user queue eviction fence;
> otherwise, the eviction fence will be returned as a
> dependent fence during VM update and refer to the fence
> result in leakage.

Please drop that patch, it shouldn't be needed any more after the changes in patch #1.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |  4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index d86e611a9ff4..6c9b2b43a929 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -224,6 +224,17 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	dma_fence_put(stub);
>  }
>  
> +bool amdgpu_eviction_fence_valid(struct dma_fence *f)
> +{
> +
> +	if(!f)
> +		return false;
> +	if (f->ops == &amdgpu_eviction_fence_ops)
> +		return true;
> +
> +	return false;
> +}
> +
>  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	/* This needs to be done one time per open */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index fcd867b7147d..d4e1975cac71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -42,6 +42,7 @@ struct amdgpu_eviction_fence_mgr {
>  };
>  
>  /* Eviction fence helper functions */
> +bool amdgpu_eviction_fence_valid(struct dma_fence *f);
>  struct amdgpu_eviction_fence *
>  amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index d6ae9974c952..8ac685eb1be1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -185,6 +185,10 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
>  {
>  	void *fence_owner = amdgpu_sync_get_owner(f);
>  
> +	/* don't sync the kgd userq eviction fence*/
> +	if(amdgpu_eviction_fence_valid(f))
> +		return false;
> +
>  	/* Always sync to moves, no matter what */
>  	if (fence_owner == AMDGPU_FENCE_OWNER_UNDEFINED)
>  		return true;

