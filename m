Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F916C8303F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 09:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C20810E321;
	Wed, 27 Aug 2025 09:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s2srr7pQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B13E10E321
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3QhrLn0WxxhExMDJpQpn0RreB4BLKFZyId9FavhgwBqhWBnsr2uMfOmZ6SQRyBiJFXW9DfPMF7JPK/tLeIIfj9+/MNhS0WrI/kKMm/eb2HQqiJ8as/HM9+v3bZPCNVsTRNJuXBGRynYe5Yx2Cc08JYi37xuXdr+ineKMcQzP8Oarosjuoo1ieTfZCVhDBXf23WyevoIHsM//MPGTkRq/iLNaXcNNNW6cfXSNtNryx8nWb0Y60rVdSPlqvqpMLeUzujfScMObqZlxrey7imaFO2uh5LOqCZmPAbuRFlzl7f9xa4id8Ryp0t7VxfzPzvPRUohHoU+ZYoKeDVK+4i6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J72SHl9wCB7JitrMGK9ErWj8Xq1jyIknAf83gY8N0GY=;
 b=Z7VsQJPOzywl++cdlCAdCZp5uK0JGTdeHfFiThnBA2DdwxDfXUmkPej915iMHMeUnNo1JWRNuAQVlJcvxpNfYoez90cqd9jvvAvnje0ZQrKsudDEZl2J0McLq8mIRWJx0ZLw3hUjoZYGZzyaF+22/cERhq3cjdrwWi5clmP92gUCNqkNLfCdvUYuLnsPJY9/D7UAN7kEnYJbg7XTOL36zArsKLSsZ+7+2q8Qcv4hOSDwYZT4K/dnQkLkHMhgiETb9nB2Z69x31TntdeuPLDEaFi8NH7ctZHMkjiEe2NW9WLoPsHwstNP6/XxhQq5prDWMsQtbUs6xTkdkzvnYfTV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J72SHl9wCB7JitrMGK9ErWj8Xq1jyIknAf83gY8N0GY=;
 b=s2srr7pQMp3Ym99H22yA7hO4LA0w3WxeLmC52YcHNZlfZxwxhwgSfcGW5yAfp3svuA2KDGrjzegSyY+XeVurrSegw3lpUE6sTnRycQjiC1cRYnatfIq1kPq6eedCw0pls+FyEi69n84HBeblyIsPieuQ7Yz+15rv5iiTbCwKFYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 09:21:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:21:59 +0000
Message-ID: <985d89af-9e78-402b-8604-32b340c876af@amd.com>
Date: Wed, 27 Aug 2025 11:21:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Disable gfx IB preemption with gang submit
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Cc: haijun.chang@amd.com, ZhenGuo.Yin@amd.com
References: <20250827043425.1944682-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250827043425.1944682-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc79c1b-cb63-4623-f5f0-08dde54b2cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjd5Rm9yRHo1RUdvR0VjQy9va0dadVY4Y1dQNkdEbkRiWGdXOTVkUlVkZW5Q?=
 =?utf-8?B?Q3R3NkxyaW9aVVVleFBac0Q3NXhLcDFKMjJhMFpVT2w4RmdzeUNRVWg4WXZ5?=
 =?utf-8?B?ZmkrcTVOd2J1NGovdFZmTlljL0p1YVNJVENYMFlYa3JHblpGT25jcklFNkdB?=
 =?utf-8?B?ajVCa2JsUzZNby8zYWVRblVjNE1ieVl5QzNlaWNRWHA5aDlWQ1kwd2g2QnNX?=
 =?utf-8?B?WXg5KzJHL3dWTk5ob0pMeXFHeGJpZlZTZ3pVNVVTdnkxclowb3dHTk0yWllI?=
 =?utf-8?B?VjhScGZnTk11T1owaWI0Sy9BK0FFVDdIYjg0b044b1o5Zmw3cXpCdm1sYWh2?=
 =?utf-8?B?TGIrbkNwZEQxREI1MGUrcWpSZDJxM1lzTnBEZEhteEIyaTBLKzlHYTl4YW5N?=
 =?utf-8?B?RVpxclBzbWI4UEREaDRHWVhmWjRKeFdxTjFmWU9mRkV4akhMcXZmM2EyV3BW?=
 =?utf-8?B?aUlkc3FnaytaZFljSVJ0YVAxQjZmNUErMHdrQW5mSS9DMDVtY0NzTzlDNEEv?=
 =?utf-8?B?YWQrL3o0WHZXdHRMM04rSVZKeTcxbm1aSjZxRUxGQ1NoVENCTkYvN0h1YnFm?=
 =?utf-8?B?OThOSEl1WnNqejFSWFFSUGxDVTk0T1ZhMmZlem0xTVNZODFEQXpMUS83R3M1?=
 =?utf-8?B?OHZFVFpRM2F1VXN3VTNITll3VDEwNXpudHRjOUp2Y0hUTnU1M2MwTkJ1YmhK?=
 =?utf-8?B?SzFGTmlCbnQ4bFFwYWFJbXpvTVBZYzJkY1BnUlgySlNsWTI4V1JkNnhDQVdT?=
 =?utf-8?B?NE0yV1dxK2hFQThrTGdqK1AzWVA5OWNPWTUxTForTTg2a25UT0tUY2VtR25V?=
 =?utf-8?B?UlNEeG5mTDFqMHd1T1N2bjAxazVuUzRBcHE3Rlc1dlhEenhOaXhEZCtoRm16?=
 =?utf-8?B?RWZYRnVuVkVqMjhLQVdXbHAxZTdUaTM1azNHQkUrcDlTNE5KUGFqUXpoNGRD?=
 =?utf-8?B?dzQrclVJQVQ0MjYzNURPekxTY2habmIra2VtamNqZVdzQ1lhVjQrTnpGZ2lr?=
 =?utf-8?B?dmQyclRWdGp4ZUJLTVNPdWg3S0pwS2VRQ3FzV3lpeXo5bU5nL2RJdDREWEdG?=
 =?utf-8?B?VEthQ1RGQjBBMHZLd2xvZWdLQnYwN2p2a2xHbDVqc3ZPYlhhK2pGdVdZbXla?=
 =?utf-8?B?THlGd1g3Y2Rsd0hRYytFNFJUVVl1dlNmYXQwZnAxcE5Xc3h5eTVFbWZzZGJz?=
 =?utf-8?B?eHdnSE1VM0dJNHcwKy8xYXNpVkVtc0lJdTVJYnBWdXgrMnNtYWp4Z3Q2eXFK?=
 =?utf-8?B?MUdaYkh4MUtWOHJ4OUNwcStQeUxoMWhlSDJMbndqK01CdXljanArRFdiR1Zh?=
 =?utf-8?B?MDFBU2ppek1zendNcVFjV2tRVnVFSlBCQnBHVkdjWUN2NEFDbW1UUnJhaEIv?=
 =?utf-8?B?RzkxMkRaL1Z6TXA4eVM4V0hsTlRjWE1kbExaTEhwUkx2UFZuSlgrUXJmQjFI?=
 =?utf-8?B?WjB5RkpoV2xrTEE3cVJGa3NyVDNzbXR0WVI0dTBXYzdnajdCbExOend0dEIz?=
 =?utf-8?B?YkpaWDZtaTF2TG03MFgzVWNEbTBVTGlzSmkxNFFtZmR1Nmd5cmQyRUJyZDFF?=
 =?utf-8?B?aytwc2tTWmhtZGxPUzB2SkZhaU43TW9QdkNVb1F4OXVnNExQbG1HWGx6TDBX?=
 =?utf-8?B?YlVEakZOajZ6VWI4Q082Z0p6c2hQNXhkRmRXN3cwMHdWSVVZa2JNSTVyeTJx?=
 =?utf-8?B?eXBOTUNkaVVIZEJhcm8rK3ZxNVZLUEh3ejBHeWxuTjJtYkRWMnpQNEF1azRh?=
 =?utf-8?B?WW9WTGlSc3RDOS8xUklqbzMxYW1UT2pNSjYybStGZnNkOG9Ub241TkFqaFQ3?=
 =?utf-8?B?a3pKUFRVTVE5ZGpGdUZJaCt3ZnJtWGNDemF1bmxSNnh5elFhTDhsNjFhNEJa?=
 =?utf-8?B?eXh5bE9tOElWQnllbkxiS0kxcytwLzUyRlduMTEzdUg2NnRnOUtWeFE0SHFW?=
 =?utf-8?Q?rCjszqhEObQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STMrbjN3MUNaVmVkcWx0M21hbTI2Z05BaFAwRG1iajh0TWhzaXBYd1p2SGlm?=
 =?utf-8?B?TmIrN1c3eW5veVpXODlKVXVVcmw5aVZCSDVXc3dNWSsxVWovNm1ZYStNdmZj?=
 =?utf-8?B?dXV1bm0xQnBURXVWRWVrS3VTOWRKVVQzTlJub2JNZDFwc0REdWlNd2R0a1NL?=
 =?utf-8?B?ZTQvVlFFOFZBaWZGd082eFV1TnpTRHJQVUtialBRNUJKM0taU0NHTnJrNysr?=
 =?utf-8?B?SkkvMGplc2JZb0lvcUFzaUF3Y0hycnU5czlibkIwdDlGdGxnUlhqcTVwb2hz?=
 =?utf-8?B?dlFTaHhzcnZ2bEZoS2dPam9Wd0psTWZuaVVwdnRQK1lES3dxUk8rdGdpN0Ix?=
 =?utf-8?B?czNLSlROOW5QYTZYNUlsOW9vVGUwNnRTZHNEOFVUVU5yZXN4Y2cvUGYxWWpG?=
 =?utf-8?B?Vk1jQVNKclFyb2F0amx5SUd2UVo0NWRYNGc5d2c3T0Y3eHZWYjYzdGI2R2Z6?=
 =?utf-8?B?dmpoYmNKOVdRai9CaC96dkFaM3hHL3N4b1liQjZLL2ZuUmc0NnVpdFhJSGdX?=
 =?utf-8?B?UDBodk4wL0NsUEFYSUVXWm54U0d6d05BK3pTTzlJdmR6Y0dBVzhMWmpqMWt5?=
 =?utf-8?B?M2RaQm1IeWhKemZBeFlVNGFrZzRxOXdaZ3g2dkZkMEV2Vi85ZkhIUGJ1US91?=
 =?utf-8?B?SURlWHlmS0VLZDJBQ2xuK01qZkNlbk0vMW4wcGtGOGhiRTBKdE10c2NHYjR0?=
 =?utf-8?B?cUNZWlE1TnZwOVhWYUtmd2Q4Z21hTXB6ZGRBNzRvRU5CckZoS2ViREJQbkk2?=
 =?utf-8?B?VHlkUm9aN0NxaUhLMkRFc2VGQ3ZySlUrbE85QUpVMmlYMGJvRVRTZmI3UlB0?=
 =?utf-8?B?ZFYvQmtLTEpNV2hJNDFSN0VmbEkwVkZ5K29ISmNMRmxSMzV4cXdhQTlrYk1B?=
 =?utf-8?B?NXdrWGRMV09McEdBSnI3MVhKVkJucGhrME41Nmp3ZWtkWTczY2lyK1Y4eE9V?=
 =?utf-8?B?Z3lmVm1UbFZ0YVVFZlJyY05LTDFISFkydjFOZkpub1EyL3J3YjVvaGJaeER3?=
 =?utf-8?B?a1ZhWU4vVXRubmYvL0Y4OEw0NGFpdFRZNUJ6NUU2TnZvK21LeHlxWmJEcTc0?=
 =?utf-8?B?cXVKR2h2RXpHOWRMcXhmTjlrVTdoaGJqWDlkTGgxVHl0anVXZEgwL3RNQ0Ft?=
 =?utf-8?B?dWhrUVhwbnppbHZBa0lIM05yeXFVRVYwbEszaGdGbTl5ajZEMzI3SUZiTUNq?=
 =?utf-8?B?czBFZUJLUjU5Ylh5azBkOHNXS3BHcnRwcjdqdUJzZ1g0VTdHTGV2ME10UGRS?=
 =?utf-8?B?bk9TTklxRThPK3BPcUh2M2dVY3pUZ3pUd1BDWWozSHEybmFaek41ekZCbmxU?=
 =?utf-8?B?eUh1NHNqRUJHSVFnYTNYNUM2NXNSR2tJckxiWHBTSysyc05OeTFtTU93WThW?=
 =?utf-8?B?ZXNCVHlsaUtTcFB6RVdFNkgvZ2ZDZFk2citMMWtEMWhseWp3M3Btd0FGdGRP?=
 =?utf-8?B?enZqVWEvUjFtRmlRTDljQXVrUXdtWjNKNUJERm5sdy9VZ0tlL2pxV1hXVnFy?=
 =?utf-8?B?VVE0U3ZFekt6NTJUelFPN1FXczhwN0RRSlhLblZoYzljQlBNcGtZSTJWbmVk?=
 =?utf-8?B?YnF0Tnl6cTVLOHFTNHhyMFNCUHZsZjcxcXAyNTlLQ3dKNW1PYlhQZjZabFAw?=
 =?utf-8?B?bVNJZU5Jd1ErOXArV0RCaUVoTnRkSGUvUkZ2YUdTUHN0S3MrcndsZktSTTlL?=
 =?utf-8?B?T3hzSVpuNXMvMWhhajVRdEo1T09nakg5OUtEQUpYeUNkUnR1NHhNaDJ5V3pq?=
 =?utf-8?B?eG9kUW02STd3bWtnY09sSFRpQUowR1ZkaXhLdDdqNERrcm9aSXlIY1JseUtW?=
 =?utf-8?B?TlNOem42Uzk4VUU5RTFwS1dLNGx0c0tMVEJlVGQrdis5YzdDRzExMDlVNUtT?=
 =?utf-8?B?bVR6SjhVRlJ2Rk53N0JhemRGd3RiYVp5cFRyVGhSSUpFMWR0bWkzeEkzd3c5?=
 =?utf-8?B?dlQ2M0VBNjNXcnhmNjV3dGszZzBWWWloeWtGb3l1dWxWOGJTdzU0VXJjNDRn?=
 =?utf-8?B?djZ6cERVUzRBVytVZkV2aEIxSmhUUTkwUkdqZ3JicFRrWEkwNzFZZUd3bXBo?=
 =?utf-8?B?RXBPZGlhWmVWUjlDQUlqRWt3V0pwK2tZa1oxeEtJNXd6TVI2YnRvRnJXSEZO?=
 =?utf-8?Q?DjrJbHjaa+/D2E/0v3V3AQlVA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc79c1b-cb63-4623-f5f0-08dde54b2cf0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:21:59.8244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOHrXo6nSdtccvksOwL3gLQrEDOetCuvrRmATMUFWSHKjJRDwVn6AhBiT9Fv5PmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
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

On 27.08.25 06:34, Yifan Zha wrote:
> [Why]
> Gang submit has conflict with IB preemption which will
> break the synchronization between enginees.
> Specifically, MCBP is enabled default under SRIOV.
> It will causes gang submit use case failure.

Gang submit is broken by design on SRIOV.

As long as nobody comes up with an idea to fix this generally I will systematically reject all patches trying to mitigate the situation.

What we could do is to return an error on gang submit under SRIOV.

> 
> [How]
> Disable gfx IB preemption when it is gang submit.
> 
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 3 ++-
>  4 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 264183ab24ec..c4506be4d723 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8653,7 +8653,9 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  
>  	control |= ib->length_dw | (vmid << 24);
>  
> -	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ring->adev->gfx.mcbp &&
> +		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
> +		(job->gang_submit != &job->base.s_fence->scheduled)) {

That needs to be handled at the higher level.

>  		control |= INDIRECT_BUFFER_PRE_ENB(1);
>  
>  		if (flags & AMDGPU_IB_PREEMPTED)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 456ba758fa94..725b0e4d9bf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -2424,7 +2424,7 @@ static int gfx_v11_0_rlc_load_microcode(struct amdgpu_device *adev)
>  			if (version_minor == 3)
>  				gfx_v11_0_load_rlcp_rlcv_microcode(adev);
>  		}
> -		
> +

Unrelated white space change.

>  		return 0;
>  	}
>  
> @@ -3872,7 +3872,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
>  	}
>  
>  	memcpy(fw, fw_data, fw_size);
> -	
> +

Dito.

Regards,
Christian.

>  	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
>  	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
>  
> @@ -5855,7 +5855,9 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  
>  	control |= ib->length_dw | (vmid << 24);
>  
> -	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ring->adev->gfx.mcbp &&
> +		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
> +		(job->gang_submit != &job->base.s_fence->scheduled)) {
>  		control |= INDIRECT_BUFFER_PRE_ENB(1);
>  
>  		if (flags & AMDGPU_IB_PREEMPTED)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 367449d8061b..843761947b73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6051,7 +6051,9 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  
>  	control |= ib->length_dw | (vmid << 24);
>  
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ring->adev->gfx.mcbp &&
> +		(ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
> +		(job->gang_submit != &job->base.s_fence->scheduled)) {
>  		control |= INDIRECT_BUFFER_PRE_ENB(1);
>  
>  		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index a6ff9a137a83..47b10528e07b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5420,7 +5420,8 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>  
>  	control |= ib->length_dw | (vmid << 24);
>  
> -	if (ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
> +	if ((ib->flags & AMDGPU_IB_FLAG_PREEMPT) &&
> +		(job->gang_submit != &job->base.s_fence->scheduled)) {
>  		control |= INDIRECT_BUFFER_PRE_ENB(1);
>  
>  		if (flags & AMDGPU_IB_PREEMPTED)

