Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE97D172DE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 07:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8014710E277;
	Mon,  2 Feb 2026 07:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mNhPFKHE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1B910E277
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 07:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukV5V8Tn12ylw3RxJ+zdwHNassKVQGTmJyrAMQ96crFF2FNEmaNB4NMe2fEjJpihvQEFn/RPnOKWTPjiFyMlI94nZY4HfDMJElKKwwv9R77UIFq/vs1TrrIlHpICxYnmMrsOOnBPFemX6Al7E3gp1GlZuqBEq6lcXwwsSPSMSVEvgllvEELiyKJRbllrroOeHFYDWkILFXhzhGD0ejgQYt0WkUoVcgLFViUOHKUvEiajzTNB9doQw3iPv+km9Vjv4bcpHpIAHdBqvWxLYhdegvl+EVIZMa3uKIASJXp8jt/QFVX4NaSNrIBIxLPDzDlPjwYhUYPpTcuhghp9jouUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eUyQDPVNGZ8Ks4K5xGidOBlyAbispDEF293l7jTTrw=;
 b=coeam5V51P7i5zqQywY7uKGZqCHxW+oiyT5wvlmGRT04CiexWwv5/cbrWRDV+rn46fWT8dsqVPNXen5q27FZdZ7y603z7JeH1M4CvFWLx1kyJtuRm1QjMG9SkeiV9SdvQQroM+JHscbkTLMmARgefghRjKWd34EamLvyaHLw7vgORXtpmdLmmgEDpbU1zkEFZZKewT2r5DCAit16s5t3XozL1/CV7lKiVEu/BTHo32clNjU24z5idqiV1TSnEBmw1BS9f9AlYL8p8PoloH3BqWxVKF3yGtKbL1vuKsMUUmedhp3/LF7k3THt1meEP1VdVJm6Bl0eGFUctNoNNJXZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eUyQDPVNGZ8Ks4K5xGidOBlyAbispDEF293l7jTTrw=;
 b=mNhPFKHEbhBC7Rhx+FA0zO9AWh4civD+Md5k794+QP70hZA4bewI1R3vbdzdsw4oqdIULs/23sPcieH0EwznlZnjp373DZK8v7ut/qry1PloPMKFmsU0WS/mCWkT9sDv8EzWpn+rJ0WbYflmFwCUiX66tNkrKrYF9CiPPD574pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 07:12:02 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:12:02 +0000
Message-ID: <7b087ad3-e18d-407f-8e97-5ee35e564fd8@amd.com>
Date: Mon, 2 Feb 2026 12:41:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Put GPU CG/PG ungate in device_fini_hw and
 device_halt
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260202063151.2363659-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260202063151.2363659-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::17) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: f79f0003-2442-436c-e72f-08de622a5cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2JLdG9aYm1pMnQvMk00a21TTi9mYVBROCtUUXhiWGdCOU1JdnR0UkRtbEVD?=
 =?utf-8?B?ZjcrTGZhekxvVGtWZkJJR2NwNkRvT3gxanIzRUNlcG10ZWNadFd2dWgvSE1L?=
 =?utf-8?B?ZXRnWDNoR2pWMFd1US9DQTdNaXNyUU1iYnV3TmxudkdudGtHMlFmdzZSZnAr?=
 =?utf-8?B?WUV3YzV0aFZBdEtNT0Q3RTBORERzTFJ1dHJSR242UFNYVXVWS1NhcTBuNDZ4?=
 =?utf-8?B?Snd3b0V6d2kzT2FMRitGaXZpUzBlTnVkZ1ZuNmRGOHpzb0hjc0k0Y2lIMzBw?=
 =?utf-8?B?b3VOTXU1ZGlkRU1sR3ZtVjBRbDlhWkFqc0pwNk02cnpPcUsyVHVPRVBma1NV?=
 =?utf-8?B?Zzg3WDBCdnR5eXBoTEEyOGpWUnlWQlhYWk9ZdDV0R1VZeTJDbHJxK3pZQngx?=
 =?utf-8?B?bm1BTFBpTlFZYkJTakZpUnFWdnN3cHpUQ21naFlhekV6d2tDYXNuUW8rODJj?=
 =?utf-8?B?d1hhUWJRekJWY0hjN0R4OGZyQ1V2SGVPcW9rQTMzeS91aUhZU3hVTnNxaDdi?=
 =?utf-8?B?clNnWVoxaVdjOHdaZHVlM0FKSmp2ekk2TVNEcE01eHByeXpCVDVENE9iVEVl?=
 =?utf-8?B?QTdjOHdnOFlnTDZsYzJua2lNS2FuNVBxRUxmNHR5MVhxR3dFZm03Sm9jRGtZ?=
 =?utf-8?B?WHQwa3RyZHBEVnNhQ3NqQzYxVTVKdDZRbHBHTzZ1WHBVOTNkRjZpSmpnSWxa?=
 =?utf-8?B?Q0ZhQzhvUjV2QnRsR3N4cmQ2OVF3R3JUdHB6WDgrWkk2TENtVUdRT1FSUkhE?=
 =?utf-8?B?Z3cwRzRNTXhKZGc0aEpqZWE0QktyNnVRUjkzV0paUEdHaTZmdHZmUnJ0bzUx?=
 =?utf-8?B?ZW42M3VVMGhFcUJkVUw2d3kwMzFzYVFwb1UyWkZ4U1ovclV3RlJzNllJNnhL?=
 =?utf-8?B?T0VHNmlsQmhLSkRyRVhvQkFDb20xbWU0Y1hGY3NRUkpiTkk3YkRXRWxPT2F3?=
 =?utf-8?B?WDVhV0tZKzgzK05seGwzVkk2L09aZndDZVhWUzZoL2p5R2srQjZjckEzbmxx?=
 =?utf-8?B?ME84YWVrUlZoQ25BbTVCb21ESHI1ZHVMTDlZbUZNdUd1LzZLL3NzdHU3dFZj?=
 =?utf-8?B?c1YxZGdWUnR6NnRKRHpFZlZmc2VXenloMUxYUE5QK0R6UlBvQ1BTQjNOa0Zi?=
 =?utf-8?B?Wld6UnNPclNBVTRENzlHZUV3M2lEYk1VQVFIZzFiOXRMOURuYlZwSzdnUGZH?=
 =?utf-8?B?T1BKQytxdzg3SXhubFB6azNwMTk1dlNqUVYyV3pCSWFySDFGWkUvaklhMWN5?=
 =?utf-8?B?eVJIaEUvaExWTEFRcjBCaHhjVHhQcWM1SUtRb1JsK2MzdUhKY1VmUVpGc1hG?=
 =?utf-8?B?SzR4SGszckVDWHMwbTRlL2ZiREd6MlpOWFNEZlU4cFU5UGFZdVRBK0R4ZG90?=
 =?utf-8?B?WGtDVk8xYUs1aTB4NGwyVnZCLzBhZW5ScmhyQlVUUVY3cVNiOTBKZnVMZnV4?=
 =?utf-8?B?ZS9aWmZwbDlnVnVxdFQvZmhmNFZGdjVGYzgzdHVxdWZYbVpZMDNQK0tScVN5?=
 =?utf-8?B?V0tRWTVXMW1kclptQjEzZm0xSlZaU2tWcTByeWJYRXV6UXV4cWVhRE5ZZXJS?=
 =?utf-8?B?eS96dy94T1phdTY4ZTRZdisxWlZlQjRSbmRYOE9WYnlHZ1Nyd0RBaEp3VFJH?=
 =?utf-8?B?MWVVbnk5NXJFMnh1dTladFhyQXRZOTcwNEVKdHBvcU5EakdDWlJIRG9xbWZp?=
 =?utf-8?B?U01qRW0wd3dudUVDeHA2NkZhZWJlRkdRRUtSVzJDU1V5WTUwOXdtU1lWMEJK?=
 =?utf-8?B?NFRsT0thc0NLT3JJeWhuendvR3lnTW9KZVByYzFmOWRHbWxjSENhSVRLOHMx?=
 =?utf-8?B?UUlsVy9YbXJmelh6VFhobEJja0Rjb2w2RTRJU0ZWbFluK2RGU1IwdjlhNUwz?=
 =?utf-8?B?VGY5MGZ5Y1RIR01LZGhSQU1jQk1uOTZXWVJLWVpoSWhDc0Y3cVB0R2Z3YlQ5?=
 =?utf-8?B?RTM0ZTRyQ2RqeGIrZ2RLc1dabldoVzRObTVJN2d0c0N6UlpWcUVVSGZsU3lj?=
 =?utf-8?B?cG1WbHpuc1BVZ3NISmZqTjNidXA1alJWOTJOQm1jY2Z4ZHdjTTlXWVRTalRz?=
 =?utf-8?B?SFRzczRNamdaZGtQZmJqMTIvdmFUR0s5dG5DRmZ1cnNFQmx1aTZIWUtBNEcx?=
 =?utf-8?Q?gLqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHN2MkI5SUszUmFleHVHMFBBNXEyQVcyMDErOFNkV3oxcGduVjZMelNKMURp?=
 =?utf-8?B?MHZqZno0OWlFaXk2VFVnY3RZeldxRHNSWk5zZGtscTJjZmczRDFwTW1pQ1Fq?=
 =?utf-8?B?YXhjRkoyd29rZnMvV2NuK2Q1d0JWYkZPdFhxYTNmck9YVEpKUFpGcDdxZnFY?=
 =?utf-8?B?MG9zSVVldFVzNTBtRVZlaWpnQzg5V3FHY2tWdkRJOEtMMUpNRVJ2MEY0TVZ5?=
 =?utf-8?B?Q1JrWm9kMitqUi8wcXlEY2VsZjBqYkJ1RDBVeWFkbk4rOEVqSEtUVXBodTlK?=
 =?utf-8?B?LzdvWFZ6emszUlh6NzVQK1ZzRUE0Y3Q4MmozRFp1Y3V1WUR2STgvekJhOXhS?=
 =?utf-8?B?VGVQTHV6Ukw5OVdxcVNzSTBBN0hSYjJ1bEN0NjJ1WmNaam9KczVFV0RJd3o2?=
 =?utf-8?B?Q2RjMkxNL0pQWHJoa0kxSnhRc01MTDZkM0N5M1NRRlBlN1lQZkZQTWtRcGoz?=
 =?utf-8?B?QkwrSWFDRUN3YVI2VkpZaG4vUlpEeGUzTkpLRkkwK20yWk50REpQdVB6eENn?=
 =?utf-8?B?SWZ4RngzRURmMEZKYjBTRWhkTkY1NVBTTTFyT0I0NUVPNSs0U29YUnZVT1pZ?=
 =?utf-8?B?cWVZTmwxcG5vTHhyVjFUVER0eVNZZ3JjQ0NtT1FRYVhPU2RPVGZZMzErYnhP?=
 =?utf-8?B?VForR0trcjMveXBtTVFoTG1LZ0tnZmtGVno4NUJXS0QyNHZqM1ZkYW5qVWxy?=
 =?utf-8?B?K0ZFalNPR3VkSXJSd284cUh5WStqV0JkU3FvRWkyYmIyRDZwN0tpRjVMaXN4?=
 =?utf-8?B?MFFQN290L29kT0Y1TjNENzJnSERuYzhUUGlwT2NhcjFDVElnMS9FNFA1NGVp?=
 =?utf-8?B?M1doa3VjRGdKVzFXQVNLSkV0WUgwM1N4NkVZWFoxdE4xNmphdVZZbXlzbUZw?=
 =?utf-8?B?RGk3U0FPQWV1Y1RpLzB6ZlFTUDZVL0VZdVREZjRkNjhEOUlnZTl3dzF0YjA0?=
 =?utf-8?B?OUdSU1NVd3VpOVdSUFFnL3JkNVp4ODdaUm1IUkdDbW1vdDk5L3c5d3orK2Qw?=
 =?utf-8?B?dEpxSjM2V1NGM1J4T09mYlN6L09WV3hDYmlXUEwvVkRJdGorUW1rdmY4MUg3?=
 =?utf-8?B?NHh6Sm44bTJMamJRdENvc3MxRWdBR05uUGxsV2xiUVpHMEZwV0Y3eGJtNER5?=
 =?utf-8?B?dHA1VFo2U2FkcEF3UThxK3VrVjNKZ1grMDF0Mm9tVG9HMVd4Y1dXV2E4VE5U?=
 =?utf-8?B?bGNLckRFL2hYYlRGMjdPcTh2YnZtbUlUSk5DdTJ0UVF4ZDdlSzBhSmduRkVK?=
 =?utf-8?B?d0pSZnBUb2Z6bUZIWmhmOTRqcHVKL2w1MWowRVN2OXpnSmprMTlPZS8vdC9w?=
 =?utf-8?B?T2NsUEd5M01kQXZDRXZXQzRtNk5pbkxLc1ozWFhDaWR5K1JZVDZLblFuLzlu?=
 =?utf-8?B?VTNLTkcwL0lQVmJaUTdLMmFUSjV4VEpnNVV0U0RNSjFKYTRjWmc5VGhYUm5N?=
 =?utf-8?B?NHY2QnJDKzhaWnY2TFZNeDh2TlVPcy9ERDJqUkwydGxlSDd3TXlMNUZWZVpI?=
 =?utf-8?B?OFlUcm5yZWkyT2I0VC9PS1dqV0RJZ0xialpJSmlaZGpFWkhubXZwY213alVV?=
 =?utf-8?B?U0NxNlIzeENtMHhoZ2tJVmVIZFVjSGxxRkJjSTFXOVpvbDhTNUVDTHkvemQw?=
 =?utf-8?B?VmYvQWhPcC9Lc091Ly9uQ1dJM1M2Ulc4ZVVWQVVDZ0cySGkxSXRWd3B1OXk3?=
 =?utf-8?B?anplVFNEQVV6TEVrSmdhUFMzN0p3cmFHRWhoY05WV1YrWjUveFdWTHNZamMx?=
 =?utf-8?B?YzIxRkJZSVVkUmxHTXJzczhDNXYwVmIzaWI3VFVqR1NxZXpEL0dxNEpnNWpj?=
 =?utf-8?B?T3dQWkhDYTZUczV1T1pFckJ4QVZrNmNJTmFLeUFoRTJVdVN5TUh3bFhHR09G?=
 =?utf-8?B?ZXI1cHkyQlhaaXJrYTlZNHdQclVnWlZOZy9kYmx3amFnSkhvc2N2Wm14bVVW?=
 =?utf-8?B?SnpaQkg1eXBocmRWZll0ZTVjOWpkWlpXWW5TcFlzYmt6N3Z6bFEvbzcrMzRD?=
 =?utf-8?B?VUhsSDMwMFd5dTI2ODB3dVdMUmZGMFpTcEdCZVk1bXd0U2lybW1GZFR4Y1F5?=
 =?utf-8?B?M1ZOVnhDeTBEdUE2RkZSWU8vTXRwQlNSaGNOMkwwNnh3NGJEb0JTQnQwVXY0?=
 =?utf-8?B?N29IbjBDT1hBdEF3ZW53SlI0MVJzeGxKRys4enVNSFlwY2JWbFhWUGJQL2h5?=
 =?utf-8?B?Q0w4N1dzRU5CRVdnRFJzRW85YUVqNUlVWVFuaU9FSVluWkZnUmlMdE1FYUx0?=
 =?utf-8?B?aVBBZlVFZUlIenB0ZlZLQ05wYjZCTWlOY1UxR1ZrRlNwZnJSeG5mQmdnSGVl?=
 =?utf-8?B?LzZGY0tOejFOaU0yWWtFaCtrYTVCaU5LQkwwL1BmeDk1QnRMa1R6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79f0003-2442-436c-e72f-08de622a5cf0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 07:12:02.3675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNmP9Gd8lgx4AYefHMIzyWRACPZyTAfoUfBmKIRwD964PpoTLFejIjDkvMbbhSvp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886
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



On 02-Feb-26 12:01 PM, Yifan Zhang wrote:
> Protect GC registers in amdgpu_irq_disable_all() and amdgpu_fence_driver_hw_fini().
> 

Probably refine to keep it generic like "Protect all IP register 
accesses if in powergated state like gfxoff"

> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e69ab8a923e3..095730c7ef8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3506,9 +3506,6 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   		}
>   	}
>   
> -	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> -	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> -
>   	amdgpu_amdkfd_suspend(adev, true);
>   	amdgpu_amdkfd_teardown_processes(adev);
>   	amdgpu_userq_suspend(adev);
> @@ -4904,6 +4901,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_virt_fini_data_exchange(adev);
>   	}
>   
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
>   	/* disable all interrupts */
>   	amdgpu_irq_disable_all(adev);
>   	if (adev->mode_info.mode_config_initialized) {
> @@ -7362,6 +7362,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>   	amdgpu_xcp_dev_unplug(adev);
>   	drm_dev_unplug(ddev);
>   
> +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
>   	amdgpu_irq_disable_all(adev);
>   
>   	amdgpu_fence_driver_hw_fini(adev);

