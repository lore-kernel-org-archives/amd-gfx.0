Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D38C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 11:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A530C10E611;
	Tue, 17 Jun 2025 11:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+i5fuHl";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9831C10E60D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 11:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q++LLJAIdv5y+5jUN4jaQsWbavRwOu+tlXo6QAYxt5N+OKpmRzhbdZSqEKyjkgpgGd5tFaXRL8gPjJ/T3q6vIimreDcWbSPQtvL7W9B/aA8r3F79UWBJG/1serLdSePNZ+TKFdU0ntBrnyXD3zysK0atpAWqQRer5U3eg2gp9y3gDKqm5R9hqqU2XlvEfxKahQoWAE5LdPnKQ9uSIhqajerXRTWLqB1xp65z0KUTDfje3iegn9tJk3iKoav7JPXfF/uA1Api5SGov9fsxRabXpPmNFHQaufvlvjXBOB9NBYhlKAymQ4NSL2iIpwAF/qVaXbvbkew7R23aQAttlqY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96xS8brbjOXIVTPvE9nABDSrMwiUwE7R/u4dASn36oE=;
 b=LGrApI1HGF3TYxMvdvIGxAc3GLHhHC4nGCpCj69jqLeF6ip1Od1uGwsHya3Cd+EFxU5Ds8H0Jc6X11glLkftdBcJwqo7PU9k1t6NYEsKi0si0W/aYoZ1QLS9l5Bp/BPP1ZN+P1ef4LgGOXpklOejLQidSK/ylce1PnNDvrGkhyHj8YFlIKGMvoASqEm92gia+z0RRwZf2EWvUpve/F4GyZxb1ezBgwbejQr6VzraMrMXmPOA50r5UtY7hgTl2f7zQISor+YBb3S4qjFk/VEqechs+TEp3aK+O3d27NcdWt/c73+fpGPMLEPV9KECSaAKDXlGgLJq48u2vjD1LuBwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96xS8brbjOXIVTPvE9nABDSrMwiUwE7R/u4dASn36oE=;
 b=V+i5fuHlBQHk5CFr33TPrQIAssW1UNEYNTj7weZDcmN/l5sRbsHuYsmEJ97YOYyCJFh6iNMLOQbxrvzt2RmChUIunySHr6TdTYEhTN/I77NnO2uxiFS0JUcSTJIUiGARVOo7WBnCKtTLtZTNO8w05hbxfNxu7LlF8cfuUv4lhG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 11:51:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 17 Jun 2025
 11:51:00 +0000
Message-ID: <0f09dd84-12fb-4ba9-b533-f4eb1f37d24e@amd.com>
Date: Tue, 17 Jun 2025 13:50:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250617030815.5785-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 279d3a1c-cd8f-4021-9049-08ddad953ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTNiaE85VWNSQlpOWHBUVVB3QUtmNVFRQ1ZOVm9iQTNRMDdjM0EzaFB5dWJE?=
 =?utf-8?B?NE1nQW5MbmZwQ2xveTFnUzdzMlBMOWxpdUlvcFdZSGJiL29qTWJycXcwRDFY?=
 =?utf-8?B?TzJUSGhrMWlCZkIwZjd6NFVpUTQ0RXVadmZ4bE5PSzg4WlVpRmY2azhYS0kx?=
 =?utf-8?B?NGhnU2sydGFpblNLbjNDVGJmMW1DZHViK3FhVmg4RVRvVXZRUmdMdzZPYTF5?=
 =?utf-8?B?dlQ0WDhRNjE5VmM4RnJzNDlOaTV0NWJUS2VFMVlTQmNnVk9kdVFJZXB2cnJC?=
 =?utf-8?B?aGpmSUl6aXRlV0gzMVVMMDRpeFJadTA0eVAvbmd3UCthbUtqeDkzeEZ3allL?=
 =?utf-8?B?ZjdQbk9laStaVjFoMFE2ci9aNE5ZMVhpTHR6RkozeHNlUVJyYXBYanNzd0xE?=
 =?utf-8?B?R3dLTUFtNkIxWEZVdTdtcjl2SDNSUjdUTjUyVjlGWjkxRTBpeStscFdPU3Mz?=
 =?utf-8?B?a2lBaVJnYUVHbWlHNVN1eDY1TEEvcFF1a25HUTJxRWsyeGpoajF4R0p5Zkll?=
 =?utf-8?B?THhiVUFDMlorQy9WeEF3SUxnQXZESy9YNkJRczBjbEtkTUJNOFZPeEhnREJR?=
 =?utf-8?B?Y0VGVkZZR2xJbXlyUzdDbldqelQvVVF1elJ6YkFMc3BiOWNOdXFqeXlRS3RV?=
 =?utf-8?B?MGtqVWFGQXpiMzJWam1wSVB5QUV3Wk1rdFZBOXByTkVkdHlsVWIvdWthREh0?=
 =?utf-8?B?RFI1U3hjV2ZDQm9xcGtGRUcxNklnUks0YkJLZVV4QU9OUDR1TStKeUhBRlRq?=
 =?utf-8?B?RnhiL2NDTGFQalR3MlNpRFROTHRlRDdPTFR4czlXajl6WjM2cjRHSXpqamll?=
 =?utf-8?B?ZG1OUzNJMnMyVHVBcnVxenNUaHQxZVVFa3JpVXpHeUhwZCtzMnRNZ01MTXpx?=
 =?utf-8?B?cGdaRGVMalNObExXTkVPU2VoeFdhQ2t6VlZ6bzF0K2FVVXBZWFB4Y05ielY0?=
 =?utf-8?B?RXFvWWRQOU4rMjZyMHp1UEJZUURScXhOMlNSWWxYcGkzVEE3eW1JNmFjOWpz?=
 =?utf-8?B?dEYxT2VBazBYREJERUNPd0Rva2xKa0FLK2NkNW1LYVdlbUp6VkZza2JFS3BS?=
 =?utf-8?B?eGtvZWUxU3VpVGgzV253bFRzNDY2eWdYSndIVXZoNERoV2s2bU5YU3I5TWs4?=
 =?utf-8?B?QS9MbTZ0Nm8zKy8zZ082Uk9PbUE1K044TWQ2RmdNQ2hvSG1YaUFDdVp6ZUxM?=
 =?utf-8?B?c25HbnZyejZZMHBxbXkyZFFjeml4dVhOakUycmJ2cis4cTBPb3U1U0J0Lzhh?=
 =?utf-8?B?SitkTVhYVlU2VE5aOU9pZzV0aDkwOGZXajE1TTMyRDhsZTcvSENuMFAxUHZ4?=
 =?utf-8?B?aTBFS2xRNjNGV2kybDNXTXBxZ3dqSWxhU2dsUTFXMFdmMzllajRTUWwveFFH?=
 =?utf-8?B?Zlljc2I0cXhhYkpqVk1wbTFGYzIxRW1uUWFaZU4yRmIvUFU0VTdoSmJDQlpn?=
 =?utf-8?B?U2w1dEtlcUEzT0J3YU9xZzdGOVcybDJORjZWT3p1dTRIWDUxMEFmOWZ5Q0lW?=
 =?utf-8?B?Nk1lYzFNRlAwWWJJYlplWThQU0ptS1NzVUdickhVL0xQV3UwbWFxTVNkUVZ3?=
 =?utf-8?B?WDI0QkdqclprNVg2Sk4zYmZRWCthSnZiSnFCdlkxRDlhRVUvQVg2TnlNekls?=
 =?utf-8?B?ZFg4U2k5bS9RcEo1ZG5CdlVBUHhUSmNDTExmZjVKV1NmOERuWGxWZkNJSjNS?=
 =?utf-8?B?SGhaYWdxd1l6RGVyZkdtY0ZBa2FIZ05LdHcwd3lwVS9aRHZBM0FLQ2xlRGdX?=
 =?utf-8?B?MjlZQTM5V0pPZ0k0b1JobEtiVW5qMENkRVp0RUgrT2ZOdzgzc0VuYm1WUmtC?=
 =?utf-8?B?TVp0cEpRbG0xZ0dyTmZGR2J0cXZJK0M5dlBZd0VWSDVxc0d6bmJHZFFFVDhr?=
 =?utf-8?B?eTJtZWVudFo4WEtjSnpiWHBENHcvbVl2clZOS1RmU0pUTldMdjZmZzZqc0VR?=
 =?utf-8?Q?rMOJocIoZZs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBGcFBIZ1dRdWJwNkNmZjJNYUhDb1BveTg4eE5DNkdEaHA5RzAyb2UyYzQz?=
 =?utf-8?B?aElaZmRCcFdqZSt3QnNlaXVCVE1heXdKY1BNWm9IT0hCWTNOcUU2OUxUYis2?=
 =?utf-8?B?Wkp1eUFwRzYxc25iTkVhUnlrNFBsSkdsdHlUZFBLanJVRHo1NENvWGhFanVI?=
 =?utf-8?B?MFBjbm1KV1hOTE9ESGJOWHZHbjNJY3pnU1JWQzZUR0x3WjhrcmRSTXV4UFJl?=
 =?utf-8?B?b1dxR0JkUFNuUlJ5TFppY3BBNFdqUGwwTXlUbmNvcjBCMVlZM21TeTN3U1NN?=
 =?utf-8?B?MDJQV3RXVDM1K0pmcFlrUTkybWUzUmVwVHhaRUYxajdZL1pyTEJWUm56bU05?=
 =?utf-8?B?VEFPRVM5MkxKK1pUNklZWWFuZlRzTncraHhrSkdaK1Jyb1BlWHNDYnprN29x?=
 =?utf-8?B?NWUrZnU2NnRMTWdmeTQxVzg0aDVKeUV4cjZhRG9ZOUxPWkNVQUVJUUwwQko0?=
 =?utf-8?B?RlVaMW92ck9BWUIwZW4xQkVIckJwa1I0dFNQVFdaM2ppMUF6cm1NNmJxcXhq?=
 =?utf-8?B?YU0vMTIvU2xuY2oyNmlTK3lldE5ObnVkdDZSZHpJMHlNMEZiRGJBNVNhZFJ2?=
 =?utf-8?B?SUJ0NkFRZERXMUNCWVR3U1EzaFhsWUZjV2l2NlRsUVpqQ0cwaGF4ZzZyNC9L?=
 =?utf-8?B?a1RrSHdycFBXTW1qRHY0eEE5S1pkN0l1NFVsMGNzNklTTXB3WUNLK1YwTXdp?=
 =?utf-8?B?eHBvOUgxdmwrV3ZHcTlKQ1F5Ukh2akFPWWF5UkwxNGk1ZUR6UVV2VjJnZCsr?=
 =?utf-8?B?TU93alhBdDNrU1ZQSE1ZdzdNTmpxQ1pJbTI2WmxuS3lacFJqK1pKWDdZMUMx?=
 =?utf-8?B?d3krekZFRThLWjFEWDVueGozZVR2SkpueWVHMjNWT1hLMS8wZGl1OWtwaUpM?=
 =?utf-8?B?QitzMXBIdW1FbjcvSnNyOG1IZ2dwb282aFRwbm9ycjRZTDlnT1hjME5HYlhy?=
 =?utf-8?B?Rm85WVFneWRYSS9XeXV4a0NBUW04VlpUNGFqeVc2aVE4WW1nQ3NIbTdFMCtW?=
 =?utf-8?B?S1ViWEt2cldOUHVVaTh4REU2Z0lwMkZaZnJLK2hzQmY5b3pEczZUbmRTT2Ji?=
 =?utf-8?B?d2treVNENEZOQmh1eGk0YStkek1ReXI4b3dPeHJKRjJLRlhMb1k2SnU3ZTk3?=
 =?utf-8?B?cXBBOXNZSVc1N2thV0hvUHlidDdEa2JTWm1PbWRXZVN5ZVVBOGFScTlGcEFU?=
 =?utf-8?B?bVlyK2RYYVZHUkprYlhkbWRFZVViQ252WU1HaGtXZjh3VC9tMW9YTXlxOGds?=
 =?utf-8?B?WTF1TWRtRnZiKzlDbTRrRkRVdFBoQXlqcDZrNkZmRlpPd1JSZFE4eHpHbE16?=
 =?utf-8?B?Y0F0R0tMWGl2VDJaaGhEdXlyclVTeTRCS2tNcGJpNWtJME04MFoyUnlLSmlO?=
 =?utf-8?B?QTVWQ215U1Y2TFpsMzgvejllL1lyU0JCaHBLQXJzblczQkZuNHFDNVFVS3ZH?=
 =?utf-8?B?NjJkUEhwTE5QSCtkbWpBVDdDMkE4Y0p3TVpCVGd5TWV5QkZJdk5TMW1zQ3Mr?=
 =?utf-8?B?VDZMcElxcnp2LzhBRFFPZzhVK3hWdXRzZUI0TCtRQ3JMZVh4UjVhOUYwdW43?=
 =?utf-8?B?TmhqSEhBdytMVUtMUnpFQVZaRHB1QXdUT0FmY3RvYUFCbGoxQlJNT1hVSDNr?=
 =?utf-8?B?K3BrMVdqMjQxRWI4Z3YvUWg5TWRWOXVxVmpPOFFuMGFJSndxbVFmWHJkOGti?=
 =?utf-8?B?c3RwWEcvYnNHNGJkbVNvakRhb3BEMEtERjg0NjROdkYrUXR0eThHVGZvK1dB?=
 =?utf-8?B?Q2s5Yzh4TmEycitnZmVlLy9KVDZkbUFNWEo2VllkZml0MFVWUmhZR0dXM2g5?=
 =?utf-8?B?SktHd1d0MjV1aVRobzdwVmpqWjJuU09GVmU0dGxwZzk0NERwZUI4WUhnRlNi?=
 =?utf-8?B?dGdjcGVVUGJKTUpVU3JCWHNMRnFHL0g4b3l0a3hsSDhnNitibTAxcVFNUENQ?=
 =?utf-8?B?M3VjTXE5OW96R3ZHZFZnaWw3QlQ3NGp4enNYYU9YeFFrZ2ppSUpnU3F4U3Uw?=
 =?utf-8?B?WnpaV2ZjUFEvdkJQdENiZGcrWVZaZy9SRjBFK2RoYUgvWDF6MDlPaWVRaDdy?=
 =?utf-8?B?d2xXb0p3SENET3J6NmhOWWdwQUJDcTFmVTB3NkJPYUJudHdydzFWcW9KckFx?=
 =?utf-8?Q?EV8lS2v+/7ok2KSi7MCxDIMG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d3a1c-cd8f-4021-9049-08ddad953ab3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:51:00.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0PNarnGuqBtqvtKjUU4fMYtfcz/FtLwQCB2jAaO0vwI30/RAp9VPnk/jSYpb+EN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

On 6/17/25 05:07, Alex Deucher wrote:
> Missing the mutex init.
> 
> Fixes: e56d4bf57fab ("drm/amdgpu/: drm/amdgpu: Register the new sdma function pointers for sdma_v5_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 2d94aadc31149..37f4b5b4a098f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1399,6 +1399,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>  		adev->sdma.instance[i].funcs = &sdma_v5_0_sdma_funcs;
>  		ring = &adev->sdma.instance[i].ring;
>  		ring->ring_obj = NULL;

