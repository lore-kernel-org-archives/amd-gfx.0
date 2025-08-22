Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB626CA0EFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 12:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA9110EAD8;
	Fri, 22 Aug 2025 12:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dPGAdFio";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B0C10EAD8
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 12:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgUNYDOG7gJ5hpNrL/JuMzsosFyCGO+TQw0BgJPVasxstWNrdqBYwH1sxnw+C2VZ2mJTVM5gtrYB8HOvoTIH39eT/nKInccODVUQMJtVi/cDMXPz3RnW+n684H5AJUBNbBav2v9JWxHkdoM5W87uSkOm6K0Q8a3EnaZagsZUeRSKfm1Y4hoCClYd1ZB+y4dR/TSo1Vec4MMRKtPRMl72Kcqr9bYBQPv3SeL0izLK7pzkgb51/Wz4bmZkrvd2K+5xMkjoq359QdJKfJ6MnFgimWjO9ZMYRJNrj13ZiXV0wCf4o8LZJ4lbRbNpl8DerAhp2Cw2PWBPw/yT+lRqaZSoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIvTmS5mg0ZuWkl+ZXmPwtnuB/SlN1lvRblFCIeViCk=;
 b=ZtBdK4QnbIURgabgAD0qThWaXrh2hn71A0KsQXyhdwIi7aNkNhriqu5HEkNNAFfT31JPdfrpDlqwxO4Ll4QTPAgdwu7SVYG5ReSsC2jmpgiAcrnN7YmZTfl97SLLIu2pvBfY4JKibZYwmbjLvCUljT0l1rB8z54yWKVJgedsWdJ8I+Py+1+22lMfeYpmE7iD2OD8JwYMrQ8nES2kKuDrFBYUjU2J8oF+PXRj7CHAEaAo4qxEsBWwJ2KEonchJtdIbuTZB8qEOHEUSvh9ED58sJLqGigbFf/1bgZ3jufJhXKjeQM2PY+O8giEt7j03rf8L7aGJ7KRULevSlEEBpqcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIvTmS5mg0ZuWkl+ZXmPwtnuB/SlN1lvRblFCIeViCk=;
 b=dPGAdFioYG9cr/3Ic8J0mcwuRb0xHef4G1hqio3va8eYHa9rIi8SrhId1KTngZgP1My4JvDjfFaCKkcDs6cLdCN/Pc9Wp7JarFT+hwnzom10Np7pFwRMi/o6uiDfnRGtATvcMyjyCslrTaA09XSMsKVQKH+yrmKKW1Uqi7ycQqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 12:04:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:04:56 +0000
Message-ID: <e8f1d33a-531d-4a08-9cc8-319c41416aca@amd.com>
Date: Fri, 22 Aug 2025 14:04:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14] Add CRIU support for amdgpu dmabuf
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, Christian.Koenig@amd.com, dcostantino@meta.com,
 sruffell@meta.com, mripard@kernel.org, tzimmermann@suse.de,
 Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:36e::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: b18e7a5e-a9a7-4a3e-f168-08dde1741c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVp5TSswZnB2cUhOSVhOZjdjRjVqUUZ1L3pZY0VvTlpVaTRMY1JQb01IN3VI?=
 =?utf-8?B?YXhsSXpYZExaN0VPaUh0Nmk0SWx4ZDBZUVY5ckxRNmF3UFhVRTE5SEVGOStJ?=
 =?utf-8?B?MkpNSUlvNVNid3VoVnZEYlZjWjNHTUFpNGM1dVgwOERVa0d4a2M1aUZ4cHRK?=
 =?utf-8?B?WmdTbllxODNnV0JZbXVic3BjOEJsdy91RndrcXRVcFhUNWh4VmJ0LzlwaGc0?=
 =?utf-8?B?R2hHSmc0QVZqdEk4T3YxUitvVlM2TjBxK1EwY3BnTWJ0OUNpTnR2UWE1MGJR?=
 =?utf-8?B?cHdiYy8weVV4anZZZW5IUzVCdGVIeWNoenZhcHY0ekNTd21lVVR5WDk4TEln?=
 =?utf-8?B?Z0JRaUlSZVFuY0gzdzAvWGZsOVM3REtxYlNPSFAwWHZmTms1emZZTjVrUkxa?=
 =?utf-8?B?eThOOHRFSGU3S0NZSnk5UW85c25PL2kyS2tWVjJ1UkROdU11SFVSWnZnb1Nt?=
 =?utf-8?B?cWgvTW9BbXlIZXNUWFlhRWNVZlNPL25HWFczRGFCWUVPM1hET0lkUitwM1VW?=
 =?utf-8?B?M3ZibWFuNWgrNzVXVmQrMFhMY1drM21uakd6SWRrcXpkd3Q1V1B0c3RpNGNO?=
 =?utf-8?B?eTg2SnpTYi81UUdBa0hPUHJRaXV0eFl3cGpJTWpiNzdhcGVJRVJCNkNIbC9p?=
 =?utf-8?B?dFZxVGJ2NUk5K0JtUUJWOHlRckNLYlpLSWpRL1hKV0tHZzZQY2ZQNTBBQnRo?=
 =?utf-8?B?NnQya0E4Umt5RmVRZFVmbXFhcitvTGVDcytldmdjYmlidys4Q29xSTRVZjhU?=
 =?utf-8?B?eHQwZ2ZqQi9qTFBiRnJVc0I1L055aTVkcXFxQTV4eUF5RHBDZ055Q0RjaVQ5?=
 =?utf-8?B?aGd2SXZoMnFaL2xsSElmcFRaWjFWVVpSQ29JdXI4QnNMRy9WRzhjTVRnc1ZY?=
 =?utf-8?B?M0xzWTc3YTRUZzFpNUtlbnRxK25BWmw4UWdwOEFNc0RJZVpyYktnTnl4Ujdq?=
 =?utf-8?B?ekZlNHViVXNvdHNob28ybjEzaEVzb3F3YXp1NU81OVFXbXE3NlRhV2hkcGhC?=
 =?utf-8?B?elNWb1g3Z3VNYm9IazN4ZmhiR21kZ0FmTHowQjBnS1lZREdqMFpJVWFYNFJE?=
 =?utf-8?B?M1YyenE4MGFXWGRicmVvelg0WTVodmY4Y1cwckRENmhNME0xZWV2MzR4OTV1?=
 =?utf-8?B?VkkxZlJsRTdKdHpFNXlnU2ZCVzBBZE83SEI2bnRsNWVyeE9iQTBUN20rdnZn?=
 =?utf-8?B?WHJhOVk1VG1hUmRsMkNGU2tvQXBoTUxEUTlCazdoUWxUcnZxamR5Q3JJZFRs?=
 =?utf-8?B?YWpJOXlOd0JQZ0Z5dHk2Q3MxMEExWTNRalpEVEFIbW1aNkI5RmhQTWNQVnda?=
 =?utf-8?B?UjdhUDByUktPTi9ZOVZneUJ3ZzdMU2hKeGxMdUkyVXN2dWhENGZPaS9Pd3p2?=
 =?utf-8?B?NGUwelQ1QldEbEVqdm95eGphZ0pyZWFUekNpSkxUb0p1cXZaaHdLOFp2MVkz?=
 =?utf-8?B?LzBaRERsR3o4WHBrV0lPRzBtZ0xrbFlOSUdIeVFLeEdZUEZET2FNOWpFblRF?=
 =?utf-8?B?UktEOWNuSjV4dGcwclo3QVh3b25TRkRDM08wWHFweU51SzhrL3I1SGJ4cTAv?=
 =?utf-8?B?YXdSZHVFZlhwcVBUdm1mMkdOVGFMTDk1WWJaZU9POWREVGh6NHd0cHJZZFNF?=
 =?utf-8?B?bFlJeVlWRDQ0MVFmMHU1S3hiUjVhL2FxQjVZcFJESXQ2TU1oTzBGdFVHZ2l2?=
 =?utf-8?B?a1FNczNtZlNPeVJXLzNYdFQ4SmJkMXFQQkdQekZWV3l4MjdoREY4NnZXRVFu?=
 =?utf-8?B?TmxMamFKRnNUanJlNzJtYkF2UzZEeklrOWg2bm1YcmE0WjdvcjFkR1hFK1pK?=
 =?utf-8?B?VndqeXcvK2tmVk5ObXdOalFRQWoyS2lHMVg2U1pkRm5jUE1RU1BGL2VQYnNZ?=
 =?utf-8?B?VEtRSWVBb2lmdmZ6RHNOVnhaMWFQU1ZBYVZocXlTSE0vbngya1NtRGVwZnpa?=
 =?utf-8?Q?9gvvOxIz93A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVJTnJ6ekVZY3Bsbjc3V1RKUDd5MjBhVjMzMmhzRWlybE9lQUlFK2xXWEJO?=
 =?utf-8?B?eS9ESXdUaWZzbk5sM0pPQ2tSSG1pbHdIM1BzU092ZDhveUdkc3NOTFkzSjNh?=
 =?utf-8?B?L1Z0RjJjUWovWG9yT052YVd3SGhDOUpqbVBHa2Z4clVoTjZoU21QYWJrak5Q?=
 =?utf-8?B?c2xJRnlnbHhrOU11aC83c0hnRml5b01KMFJjSWcvZjkrM290M0huUzExYjFq?=
 =?utf-8?B?bUY3ZGhPdjRsV2x2WkxOVlZCU0UxdUxMK01CL1E3TjFkUThVVnFWMnd5Wldy?=
 =?utf-8?B?RFFjQlBCOTRuZFZyRkxrZ29aY09aeWJxcTcxN3lUOVFlZENhNit5S3p0c3I5?=
 =?utf-8?B?TjVWdDRYL0dMd1JROFBzWkFFck43SEE4QjdZdk04THhhbFR2WElwRm40MGsv?=
 =?utf-8?B?cEloOW9BWlI4RWlUcEpFTUNvSWc0bFZSb25CRTNKbUhCSHVjSmdZL01pQTdT?=
 =?utf-8?B?WWNMRW9mUUt4M0hKaURvdDZKZm5MQ1JxbDF5NW1WNWpxUmFjK1EzY1gzeVpK?=
 =?utf-8?B?THorcnFGUHRvdVEzY2tCc1dXdHYreGxvV3VCNzBEVFNVZVJySStqMVNveGI5?=
 =?utf-8?B?QXpCaUJFcU4yT3k0eU9RRS9NNFZOK09iK2JsUWhadGVnVWpiTFBkc2FOUm85?=
 =?utf-8?B?dDdValdYRitMVERhdDF2VlhQMGZjNVlWNmdad29TeElqM1QxKzNaUndWM3Vw?=
 =?utf-8?B?dGxuRHYzTm1YZUhBdkJFOUdjVjVPODlOZ0dPbVZJQW1VaDlDKzlTYUllMDF5?=
 =?utf-8?B?d3I2aW5Ia0o5RU1jUTFtRkZ1UU1zcG83OVg1WGdHTWlsRFJZQ0dLcm1JeFJ1?=
 =?utf-8?B?ZTR3a2NGaFBsT3dXb2hYM2hjM1QxRkFuNmF1TjVIbHBIWkgxUWZGV3F5Q2hw?=
 =?utf-8?B?Nk9FMDBtd0xzN2tSRis5ZHBTL213OXI4SXc3Vm5wcGo5YlNwWlg5L2pNYjB6?=
 =?utf-8?B?d0ZkdXZOK0RyRGhtNml0U1EwSk1POUNzTlVMTk56MmNTZkxQUWNnc2d5UHJP?=
 =?utf-8?B?N0xJckJPRk00SHFhdG9YSzBPVHI4V2NYOHJWMkpKNUxjbGpWQ2Nha1hTd0M5?=
 =?utf-8?B?WXFZTCtGR3lKWXNteEpjTFhRWnMvSk1va0dPbnc2WkFVQ0tBY2E0eEtJNUFQ?=
 =?utf-8?B?QlArVHhONVJQcHk4ZWpoaHYrUEdnNUhmd2xZS0dqR0ZYaTFWZ0xROGwvRWhS?=
 =?utf-8?B?WmYzNmVubE1pNkdFak15aUp0UnRYZjBlc0JaWG1SbXZiMnNZdTJkMnNwanhm?=
 =?utf-8?B?MUY0WVpNQXpIT3V3ZkpqaWlmcFdjaktHWklNNGZVS0k5Z21ncHVRQVpxUlYr?=
 =?utf-8?B?Ujk5OEs0NHdtWVlTaGNyYlNHbzRwcG5xditqdVkzeWRSOXh0RUZsY0tTaGVI?=
 =?utf-8?B?NkZPaEFOaS84NkRXcllBWHEzTEpwVndEU1RtZG5LUitHS3lmWDZQYkpGc0g5?=
 =?utf-8?B?VGx1YU90R0wvMTgrZ05YNkl6UGVmZW9RTWs2c2JGK3h0TXd3MnluYXlHb0Vv?=
 =?utf-8?B?TFpGdkMzRjBDNVJsUHQ0a0E5TFo2WUNoVkxlQTMrekExWmFDQjZwemFSeitE?=
 =?utf-8?B?dWN6TTIxUFV6RVQwUFlmdHQ5aWJFQUUrcmQxbHRFUVgwWmppR3lXSkp4eS9n?=
 =?utf-8?B?ems0N2ZxTVIweTF1YVVIVHNIRFFTUmJVM3JNNGQyNW9XbkNJNkZJdEdweU82?=
 =?utf-8?B?eldpUEdMK0U0SlljRkVOdjNTRm9xL3RkTVI5NE9LcldOalMvckdpRiswOWd0?=
 =?utf-8?B?UXhpK0FvaGFGb3NwSjI3TGpMMlp2ZFo0Y3dCQWN5N1IzR29kam9SSGFrUkdi?=
 =?utf-8?B?V0pKb0ZtU2MyNnJBWkk1TnZrN2NvblVoK2oyN043ejhnazdGS1BOcXFQTUNB?=
 =?utf-8?B?QWY5ckpDYXg0ZitVZGFZTVoyS1paK3dqOEl3MDB6NHhBbEpIc1gyNTFsNlA1?=
 =?utf-8?B?Q3ZIckFiZklpM25SZFVnUnVkM0RSL0ZMM1pCM2NRWUEybHhvL1g2Mm9ZNCt5?=
 =?utf-8?B?R1BLNkxZYm1Za0VnSVRBMjBkc0R3QStKTFBwanNYSHIxSTN0eFN6WmVHdHA1?=
 =?utf-8?B?R2JUdFBsVG5RdUhKNVJoclVROFZEMGFUVVJVUWhMMTNVcWM4dEQ3K2p1TWpm?=
 =?utf-8?Q?hspn29OlKs+k/16NNBMMG/JqS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18e7a5e-a9a7-4a3e-f168-08dde1741c17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:04:56.3525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgBpGGGgUI0Q0Qw3SpcIpVma1GFVjwqTg2O7GUlK/0MxLQK8rH0zGrOupg6oV+B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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

Going over the whole thing once more I've found another design issue.

How do you re-create the CPU mappings of buffers?

As far as I can see the buffers end up on a different VMA and we don't have any way of restoring that at the moment.

See here as well https://www.kernel.org/doc/html/v4.15/gpu/drm-mm.html#vma-offset-manager

Regards,
Christian.

On 13.08.25 20:49, David Francis wrote:
> This patch series adds support for CRIU checkpointing of processes that
> share memory with the amdgpu dmabuf interface.
> 
> This v14 adds the coherence and uncached flags to gem create and fixes some
> formatting issues in amdgpu_drm.h
> 
> Accompanying CRIU changes:
> https://github.com/checkpoint-restore/criu/pull/2613
> 
> 

