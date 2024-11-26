Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6236D3B988
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 12:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FC810E3F0;
	Tue, 26 Nov 2024 12:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tIS22Hv2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65B1B10E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 12:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSP+Q7VsdwXvKB78HVOXHcadE+FeiKPNPfqR6kNjc+ueZRwF/2hCf9i3itVR6bOm5uWxn9cI9ka35Rp77eKV0n3EuerAEkJwyGwnKviSI3ty6VwStz//d3mrOuvNiy5svTG5CFRKSImjzQhZGGcIbTwY0qmYrWujCNQAIw0MieGsKxy9kV55o68tf81eWIePCdVXmosGWH1snV4EWohONzjqVDBe1a6d4dRq8QE6ibOVDljBiTaMw+awSB87A5F6FZjvA/E7PjYgTz+67W0WUu6XfIvXYRrAuIMaIt67lOXLmZT0f80YaYNzlkeBGOJKczf22wAeL5MziIRj+K5nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57rmnIOdarXLYyRX+PhjiYJi1voYlsTmZZ6ZPmcEIQg=;
 b=egxwhnPcWoOWMXfxM+A+rUmggh8+xx/UoXTPc/IY0rX8i1wUIK6pj5qVuwhWlRX+wvJ4i/RU6QNI0e33pL0FKx8jFDUyvCCzMXP+JP/ySdpAacRcJzZ5oad9D2P6CzkyvJSmOxdE0qqDAPh4WM5CQUtAp77glanZpPOCvoPDaSj+aBIixDGcfw4h+Tk+vjvGTyopcTFRXYZGEANGDwf9wMRVYAvNuiB6egXbljZomewX4fQMX/AFQZ1yvx2oKyhxStM8Mz1Sc93SPmM+SAduReeuK47Z+20bDuSDxY1GkwiWtniZs0mW1Ra1+HVe+Cv0bTjdrpBGt54nGVEHFo0LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57rmnIOdarXLYyRX+PhjiYJi1voYlsTmZZ6ZPmcEIQg=;
 b=tIS22Hv2Mm1tJg9X0hbjokfa1vWlKm97dTTyoeg8r/1Ct85damJVEAJ8WAsQLU+Skpmqnnl+YL2bYmxRqx0D7v4yTUAIszuGeBz4Yb6C5x2Us3d3mGs5sXqhUqyJ+NEQoTO48hfyUmU31RjZnyNb5hbjM2S6vrGbjlbE2Joz1sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 12:26:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 12:26:39 +0000
Message-ID: <0cce0ffc-2844-4fbb-9f8f-76d812d2936d@amd.com>
Date: Tue, 26 Nov 2024 17:56:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification
 callback support
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20241124190001.2633591-1-superm1@kernel.org>
 <20241124190001.2633591-2-superm1@kernel.org>
 <2ab89895-64a3-45fa-b6a9-37407ef6e3ab@amd.com>
 <4c939f50-a1c0-4476-9a16-ced6e6102aa2@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <4c939f50-a1c0-4476-9a16-ced6e6102aa2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: f22cbb67-c690-490d-a031-08dd0e159378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3NBMmFmdndLT0pMVFNUZkNabURPL1dTZGIwYVRNSlVXS1BNUHZDZDYzbURI?=
 =?utf-8?B?ZDZQTCs4V1htclNXcURadnpSYlVBRFp3anVqeE1lc1hrVEhxclBVVm50andv?=
 =?utf-8?B?MVo1Q0ZsWG1iOHlISVordjJzTnlWK1d5UjViaEtIUjRrUXBqdDkrOVhDeUxr?=
 =?utf-8?B?ZE1QZ0RCTmsrclY0OGp6MW94eXFhWmVIb2xqblNaakFVbC9iZW81cEFMOU5u?=
 =?utf-8?B?d250eGtyZnZ5WDByWmd4QXA0eG53MGF0d1ZQdzNiVVllVjlRS3NndmZMWFpC?=
 =?utf-8?B?TkRPMjgyY2Q3V3JSQWoxaTdlWlRPZVcrSmVPTHJhQ0Jsb3crdkVJUXNoT3h6?=
 =?utf-8?B?SlpmVkVFNmd1NFJwLzFoc2ZuczQ4V0hlRHFJYUcxMyt5ME1MN2oxcnBGRlhP?=
 =?utf-8?B?R1V3T2sxbGp0Yk5ZSVJMSngvMnNYeDVaZlJzUlAxLzZJSFFYWDl6VEs0VHE2?=
 =?utf-8?B?V2sxUDhZU1BLZktLMy9nV1ZFYnpCSm90SmJVdzJmVURxWmhOMU1Zd1N5UWhr?=
 =?utf-8?B?WFJwMlM5ZnJGU2ZWSGRIWWRGSmxTY0gvTVpjVkV5aDR3SzJ5LzdabEZvSTJN?=
 =?utf-8?B?QWpWbk5icy9FVkdJeFA1Zk9rc1hOSDNhdS9tK1c5NkpvL0RoVkpseEJQbUF0?=
 =?utf-8?B?dGRoZDJxUnpqNWtsS2E3UXBRNjlWQ3Awblp1WmxFZUU1NGlKQ05UR1VSM2hZ?=
 =?utf-8?B?a3pTVytITERjV0FzOXpqRk81YitMZnJQOUNaUE1wNDBiTlhtV0FpMHR5bWgw?=
 =?utf-8?B?dWJlU1ZENmk2M2tiRExIbWtOSnNocDBSVy8xZTZ4VDQ5a1RsU2dIRHdRL3R1?=
 =?utf-8?B?cTRZK3VsYStKL1p6Yjl6Nm5jNi84empGeVArZk1Kb1ErV0x4UTZZVFlVYitn?=
 =?utf-8?B?UXRoZ1FHY0xyNksxenNQZzZJRDVlSWFPL3Vyd05DQUIwVmFMRzJMVGZBMW5D?=
 =?utf-8?B?N0pOdmw4bEk3enBiTmtyZzRMUmlkSXY3N0xLY0FiRVlPMVlWU3NqVUdEa2Nw?=
 =?utf-8?B?YXFjU3Y0L3Avd3VlcUdPYW5PVUFwM0ZpemdDMHZGeFJIYXB1VEE2czVLMldJ?=
 =?utf-8?B?cDhVd0N1eGg4YlByNEZGU2dHYVppZ1R4aFN3WVFFa2lzc3VSd1BJSnd1ZDVM?=
 =?utf-8?B?WUJ2YTl4bmMvVjJYbWdQYW1XY2dMcVE3K2c1RUNRREFDakhidjNmQ1B1NjQx?=
 =?utf-8?B?WGRBVjR1RTd1N0k2N0NOQlNIcmpYc2xnU0VaL3lkdG5zMjVhY2d6UitFdkNQ?=
 =?utf-8?B?R0xkRnVOeFZFaTBBS25mcURwbUIyV1VWREpLNFRsUVhDdThKQUFLSWZxRWNF?=
 =?utf-8?B?QXJIMXM5YUpHekJwa0ZSdGNSWUpPNzVkUC9BbndCVStaWkd2VFBXMXNBQkxU?=
 =?utf-8?B?R1ZuaFM3dmV3VFVHNS9hTGVBUEFyMUlWdkErZEZKUjd0dzlKQ0dzZ0NpSTlU?=
 =?utf-8?B?S21XNzFEYlZ5cXRTWWpGQnZvLytaOU9naytiSUFTOGdXamxnZHdXUm10Snl6?=
 =?utf-8?B?S0tvU2IzTzIrM2RxK3hlQldzNWFkVkZ6RVc5MWJZSlhNdUZycUNwbmY3a1hE?=
 =?utf-8?B?aU9GTkxlMDhsakttYzNmY3dyVVdCaGJlMU5oZjBYdkJUYmpscUlLQUFrL1lV?=
 =?utf-8?B?NjZHUDB5czYrVE83bkpqK3JISkhyWE1jcUJXbE1CbmU4OVFkd25wdWZEaUVa?=
 =?utf-8?B?dGV4ZzZBa1Z4aFl3elFVZ1N1YlF5ZEtQSEJXS1RNallvQytpa0xud3NXaVN5?=
 =?utf-8?Q?A5Bhm4J7RYM4SJ3cbXapYkNmXF+SRbncMaiNWNq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDQwdVdUZUtSZXVXbVNHNHVYM3FtSjdYbUd1ZmJkNXgzM0ZYajkvSmJ3bTYz?=
 =?utf-8?B?YkpxajhTWEl1WnMrby9NMTFFck1SNTJpdlBUZjhKbzFnS3hYUVJpeHR5RTZs?=
 =?utf-8?B?Y2FQQ1FQSTJFS1F0ekZxQWxUUlZLVDBKUk5iMHEvaHRzQTlWYnEvREtISnZ4?=
 =?utf-8?B?NU9jaXkxa2Jac2FnU1hxNEw1clJoY0hPSE5CQXpRNmZhRzZwWjJWYnhKeXpW?=
 =?utf-8?B?N2o1UmM5OUJXaEVONEJpVmtGNmtFRm5FTGo5K0c0dGo3d0pIbzhSS0lVZzBF?=
 =?utf-8?B?NUVjOThidTZSSFdTaWYwZW9CMUUxdmFEbG1ZY252bUpuTFpDeUovVEtLdmNy?=
 =?utf-8?B?RjBPTWV2NDBwSW9KVTN3RmNVTExQandVd0xsZ3pub1ViYVE3VUVZdk4veGlN?=
 =?utf-8?B?Mk1EaHZlcSs1YVE1RDhjMkxGc1VMZzdNb2NsTVhGejJuaERHSjVWRzdpN2Iv?=
 =?utf-8?B?SGpvaHFpNVFkUkY2c3lVek9WOVJZZExjMXRSbHVYQm9lcmtrS0RlNTdadUV6?=
 =?utf-8?B?bXh0dVlLbElreFo4Vm44V3JMQWVUblNubDJ2MWYvbHBBYkk1Um5LQW9iNTJw?=
 =?utf-8?B?Z05yQ1M4RUE1d1NRRWdJcFlFSlNKcjErd1pBcHdrc3hTUFJ5SWpBVVZuT3JJ?=
 =?utf-8?B?SFlqTzRBeXBVRVVzY2R1Wi9SSzJza0hpZmVlV0NqK0tTWkw5Mk5KTVg0QjBq?=
 =?utf-8?B?dlNzZm13RFUzNFI2NHREb1BubXhWMUZKRjdKMGtQOEdQRGVYZkYyemFNd21v?=
 =?utf-8?B?S2IycWVJYXIyTStacFB3c0lsbTBvSEJEMTE0L1VxQXpodWJBNlBodlVIN2Z3?=
 =?utf-8?B?RENEdzB2UUpwQ1krQkgzOGJsaS91dTdiT2JIcjNzZERScTFhSXlJbkpnQTF4?=
 =?utf-8?B?UFBKWWh0ckJFQlUrclp6dFAyM2tLcnNmQkpSOWRtVFdqVitRZ0VHQjc3amxX?=
 =?utf-8?B?Z3JTYUxZb2RxL21MZkVhMU5aalVIcDJTYks2OXEwcVZzNzE4SGNUbXhEM2N0?=
 =?utf-8?B?bTRtNnpHQlZKZTNqRnRTdEsyYmxVb1VoVE5Ncy9qbXUvL2djQ2hBNkl5UUhX?=
 =?utf-8?B?QmpsRnJZSUVVV0RZZDBrd0VhMkcvbW9UZ2pRU2YxMCtpUUNpYW1UQ0g1cmt2?=
 =?utf-8?B?N2hBZHFWdUVjb1FrZ3RpcGsydnpMcEpZWFpWWjUxa2VLQWpDUEV4NzJBendB?=
 =?utf-8?B?cnJ2S3lhTTFEVVd4Nm1nL2RqWFpHbloxNnRNMllFelJYcWkyd3R3Nkc0Nldo?=
 =?utf-8?B?R0lKWnJlSVlLN3JtWGRQSk90ajJYVkV3L2wvV3UzWkl0YStUcFUzellJUGRN?=
 =?utf-8?B?bnVYSEFQWms3VEE2cUx3Q0NEWitrUXNmNmJpcEcyWUdGWUtWV3duWmJNZkRW?=
 =?utf-8?B?UGtFRElvOFJlMmdnNXNNRjZkWGNQRHhnc0NVeCtWb3IyaEpWZ3B3OEV5QURr?=
 =?utf-8?B?Y2I1MDhpTXVYeVMxYlhQSW16em9RQ2lXeFlGK29PTHlTNXZtTGFNMC8xcU14?=
 =?utf-8?B?YjlrbFVEN251M2daWEJKQU9VZzlwRVYwTHhWNXVydXY3Z01CT3FLOUVsUGtN?=
 =?utf-8?B?SDZPVWR5U1VUclpFbFY2MXBPSWg1NnliZzd3OVRCK1JyMTZSWGNoQ0RCWGZ6?=
 =?utf-8?B?a3NpUFFCUzI5bFpPSEFOMnhNN2JHamhEbllzQUUzeTVuSVBNRk92TGk4NTZG?=
 =?utf-8?B?V3NKeXFvRWRrV0ZLWVVoVHpjbWpsaVhEMUtLa1l6Zmtlb2UzWUduU285RkVY?=
 =?utf-8?B?d3Vvcnp4MkFsbXEyQldCV2dSOWkva1ExY1JmTTB2UGFMNmNBNytkMGRWRWhK?=
 =?utf-8?B?bFdkUGhIN0JtREtLcFF2M3owalkxNjdVUHYxSmRMcVZjTDQ2UGNtQ1RRM0pp?=
 =?utf-8?B?SWtPMWordkZnRWhjNlMzNXRsRVRxSFB5L20yb3FmTWZiRTVGTHNSRFZjTEc1?=
 =?utf-8?B?R2FsZjhQc3lQbGJCblB3dVJRdFdJSnk4ZGk1NU0xTk5aeHNidE5UTlVYazVT?=
 =?utf-8?B?cGsvL0I5eXhUenBDQTU4NEFkcmpwWWdYemFTcFdTN1NwNGoxa2ZxbGtuTUhU?=
 =?utf-8?B?d0QvcXA5ZGdGUGZGOXl2TzF6eGVsSWN1NVdKUklsVzFaWUtCZXc2ZVdSWWNU?=
 =?utf-8?Q?lIvu3CHak3qLlL3Oe4TOBF5NI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22cbb67-c690-490d-a031-08dd0e159378
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 12:26:39.2056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4LiMLwnHguxKiloOMMbHoeX+EhQIib+GukSRY9qb4YSUaZxCiPW1LvV0oVgMpAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131
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



On 11/25/2024 9:46 PM, Mario Limonciello wrote:
> 
> 
> On 11/25/24 08:59, Lazar, Lijo wrote:
>>
>>
>> On 11/25/2024 12:30 AM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
>>> In order to make suspend/resume more reliable we moved this into
>>> the pmops prepare() callback so that the suspend sequence would fail
>>> but the system could remain operational under high memory usage suspend.
>>>
>>> Another class of issues exist though where due to memory fragementation
>>> there isn't a large enough contiguous space and swap isn't accessible.
>>>
>>> Add support for a suspend/hibernate notification callback that could
>>> evict VRAM before tasks are frozen. This should allow paging out to swap
>>> if necessary.
>>>
>>> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v4:
>>>   * Make non fatal, drop patch 3
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>   2 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/
>>> amd/amdgpu/amdgpu.h
>>> index d8bc6da500161..79ec4ab8ecfc5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -879,6 +879,7 @@ struct amdgpu_device {
>>>       bool                need_swiotlb;
>>>       bool                accel_working;
>>>       struct notifier_block        acpi_nb;
>>> +    struct notifier_block        pm_nb;
>>>       struct amdgpu_i2c_chan        *i2c_bus[AMDGPU_MAX_I2C_BUS];
>>>       struct debugfs_blob_wrapper     debugfs_vbios_blob;
>>>       struct debugfs_blob_wrapper     debugfs_discovery_blob;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/
>>> gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 996e9c78384dd..56510ab4b6650 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -191,6 +191,8 @@ void amdgpu_set_init_level(struct amdgpu_device
>>> *adev,
>>>   }
>>>     static inline void amdgpu_device_stop_pending_resets(struct
>>> amdgpu_device *adev);
>>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb,
>>> unsigned long mode,
>>> +                     void *data);
>>>     /**
>>>    * DOC: pcie_replay_count
>>> @@ -4553,6 +4555,11 @@ int amdgpu_device_init(struct amdgpu_device
>>> *adev,
>>>         amdgpu_device_check_iommu_direct_map(adev);
>>>   +    adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>>> +    r = register_pm_notifier(&adev->pm_nb);
>>> +    if (r)
>>> +        goto failed;
>>> +
>>>       return 0;
>>>     release_ras_con:
>>> @@ -4617,6 +4624,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device
>>> *adev)
>>>           drain_workqueue(adev->mman.bdev.wq);
>>>       adev->shutdown = true;
>>>   +    unregister_pm_notifier(&adev->pm_nb);
>>> +
>>>       /* make sure IB test finished before entering exclusive mode
>>>        * to avoid preemption on IB test
>>>        */
>>> @@ -4748,6 +4757,42 @@ static int
>>> amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>>   /*
>>>    * Suspend & resume.
>>>    */
>>> +/**
>>> + * amdgpu_device_pm_notifier - Notification block for Suspend/
>>> Hibernate events
>>> + * @nb: notifier block
>>> + * @mode: suspend mode
>>> + * @data: data
>>> + *
>>> + * This function is called when the system is about to suspend or
>>> hibernate.
>>> + * It is used to evict resources from the device before the system
>>> goes to
>>> + * sleep while there is still access to swap.
>>> + */
>>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb,
>>> unsigned long mode,
>>> +                     void *data)
>>> +{
>>> +    struct amdgpu_device *adev = container_of(nb, struct
>>> amdgpu_device, pm_nb);
>>> +    int r;
>>> +
>>> +    switch (mode) {
>>> +    case PM_HIBERNATION_PREPARE:
>>> +        adev->in_s4 = true;
>>> +        fallthrough;
>>
>> Based on https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>
>> What if this callback takes care only of suspend case and leaves the
>> hibernate case to dpm_prepare callback?
> 
> Then hibernate would fail under memory pressure.
> 
> My take is this failure with hibernate is a userspace problem (whether
> userspace decides to freeze the tasks or not).  I think it's better that
> we /try/ to do the eviction and notify them if userspace should be changed.
> 

Hmm, the logic is kind of inconsistent now.

For dGPUs, evict is required for s0ix, s3, s4 and attempted twice.
For APUs, evict is required for s4, but attempted only once.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>> +    case PM_SUSPEND_PREPARE:
>>> +        r = amdgpu_device_evict_resources(adev);
>>> +        adev->in_s4 = false;
>>> +        /*
>>> +         * This is considered non-fatal at thie time because
>>> +         * amdgpu_device_prepare() will also evict resources.
>>> +         * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>> +         */
>>> +        if (r)
>>> +            drm_warn(adev_to_drm(adev), "Failed to evict resources,
>>> freeze active processes if problems occur\n");
>>> +        break;
>>> +    }
>>> +
>>> +    return NOTIFY_DONE;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_prepare - prepare for device suspend
>>>    *
>>
> 

