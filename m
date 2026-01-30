Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B3E6BF0A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 18:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4898610EA4F;
	Fri, 30 Jan 2026 18:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBr9gqbW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0348510EA4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 18:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El8olf5egw3HFOBDhJYOoCMxiFKnq7WpCCKSZ2BiPVb6ikfMCLlFUM5el2VBcrBN5t3gHQoZZtOMUgnq80AZwZ+E0MtWkjUygHii5vIoK3fuZ1vPYGHaQD0kP1b2k/wFEP1h0XYohyifBmN+dY/82RKytVFb83Q8AxRFF1lYAjstenL7tlLlciS/Uhwg4gn7Em40ldwctlxav2RIrT6hsEh1H7ymQCGtO/KR6TbNX6XQ7eceHH9XEn5rfGEqIkN5tpDw4gm0TO6KvYAZ251wlsjYJe+5lw8FJJpzLM+Qv3XSwWtrqmMzzjmpzxWs6Y0iO7R1MlROC/zsxQ+t9vPDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Um5iddXRZDJqLk/nNmoeRnOxsH+5VdaT6t7fxTxqnjs=;
 b=NEm+5gqTKE51fzYRoH560wu4IX+CIydbPEHaSkbn7mfCzTnlrS/L9ShwRecqFf051+qlnRMgZc2p9/TxTdWaLE2gI3Wy5NqmVMJLcL/QZj0aL1MGIiV89Gd3FexCa5Mgx1mrEF4TlLDX9lCUqRTnjt3CuA0nLKf369FNRhEVNK5Xscqwwmx1R6xC+5udcTt/JwkHXh1RI93KB5PY+Z+ZlGArPtmdbDfIgUPYbkPaNP71CFwhC8NHjhA8XqkkZXq4TIdQGLowXd1OIe9wal+hAyu+OnYIlWofVyucopNncUYxsGxcR72YnMEzTdF/xfhMmujjWEYLgXT4BjikeqL7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Um5iddXRZDJqLk/nNmoeRnOxsH+5VdaT6t7fxTxqnjs=;
 b=fBr9gqbW7xiZ/YDoQ3enrAIm+a6zrBEgmxHoerqtFxkQhOcNGeaKHCn0V8yKJXAQMX+EhI2U2hzcJCI8sBAbaP80A0DaLVvovt64aMDMnGxdCRGIYNMDcUc+k1KcMNlfeCXPAfb8zRUNlroMlKRVpsQo9N/oiU9Cx9Nas+YN0FM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 18:47:17 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 18:47:17 +0000
Message-ID: <9115a1de-57ae-4537-9487-3253de858057@amd.com>
Date: Fri, 30 Jan 2026 11:47:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-5-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260118173150.19790-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:303:dc::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: cf65de8a-0d0c-4cdb-5b5f-08de602ffd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WS9CaG9MU0RUdFJva1RBRndwS2dzNG5haHRWQzhXYTNENnBCQkplTFpaVVUr?=
 =?utf-8?B?R3BGTXQ5eFhyZGlNMlNZZkJNWGNPRmpudlFIWU05L0ZKcTdteEFaek9oRThX?=
 =?utf-8?B?R1RIb0RjckRYa00zOXAwY0FYTEVYM05QUFd2QTdRN1RjZytORjUwSGlQelpj?=
 =?utf-8?B?bDZiNHh2akQ5TFFXRHFpeHRETmw4aWhUR1RFcUpKU29UdklOb0hCc1NnaVgx?=
 =?utf-8?B?RkhjeWhiTkFOenA3YnNVL25PcnVGWjJWQ2FRZHdySmgwU0h0Qm5lcUt1QkVP?=
 =?utf-8?B?S0dVemZWNjJUUFhvUUYySkFpZFVGWGltVC9YWFRLc3NQaFYyV1poQXo0VnhZ?=
 =?utf-8?B?MGM5aEpuNW5DSEltb1dWZjlTMGwwajNuc3FiUmVTQ3FuN1FCTlBCbk5VZmVJ?=
 =?utf-8?B?MVpPN1U5VkxlSnhTVEM2NmJxUFAxRWFEZmZnYXY2OW5oYUkwUG12NURtTS9Z?=
 =?utf-8?B?NWhVenJtMzc4ditQQnpSS0pLZDk5TTNtKzNyNWJVZEdLdjhyd0N3eVFUUFJ6?=
 =?utf-8?B?VVprUXlkSkFWRkFZNXgyUlVpV3ZxeGFuSmpHYjJLVXRSaFptVS82ZXkybzJU?=
 =?utf-8?B?VDNmYkhyM1crdmVHMTVJUmd1bWtYS2V2YlJyQzhXTS8zNS9NUE1JeWlLN3Z4?=
 =?utf-8?B?SEZSV05XaWFXQTBWdmgrWXBHNVQxYjNKUHc3M242TmpZUlFJWXRsQkFEZWpl?=
 =?utf-8?B?WUE1c0lwejd6MzgzSHFtc1RoN01pU2lwR1VIYTM4RWVIWkxBMVNQalZPREwz?=
 =?utf-8?B?VlVEd2VORGgvdkxlOGxCRGVscEhPUDVjQTdpLzlTNG44dHcwUDIzSW9LM1pO?=
 =?utf-8?B?QmN5dURYQ3VwRE93cXR0QngxMGVObVY3eDdneWhFVDFYcGk0UCtKTjlaR2Ez?=
 =?utf-8?B?bFBIN1RFL05HQ3pJcitDajMwQldqMzI0RDdBNGxJRElKRnU1Mm5yQnhOZXJH?=
 =?utf-8?B?Rk9kZFUyMHdNV2pUK2dFaG5vMjdsckdzaktQTXNnalBWdU5GbFZuc0w4Z0to?=
 =?utf-8?B?R0ZJaDJiUU5PMHoyalpoa0N6WkRPOWtmdXVZWnVud05EQUpuTjhOc2pyQUI0?=
 =?utf-8?B?dHJNaFRzb2RUWUQ1QjhUUUhYUHIvQVlzM0JyQXZHaXRlR0M3aTdSb1JLTlda?=
 =?utf-8?B?RnBXei9zWXBXeWgyc2JqN2o1Ujd2dXpnZHhmQUhiZlNDKzY1NXYwYnRjdmox?=
 =?utf-8?B?aVZiMFFuWUdsUUNMUmkxcnRRSzhhaFN2dkdUemlBNjR2a1p6V0F6NjhKd1ox?=
 =?utf-8?B?VWNJVmg0ckZLUlJJM3dlZHRIcVNCTmhJdHBBdzZNVFdGWnNCK253ZGxVcUtS?=
 =?utf-8?B?TFBqMWVkeUFTZ3BkcldDS2Q2ZC9RR3d0Sm1vUFZZUlp4RitORTN4ejV5aGdQ?=
 =?utf-8?B?di9OMEVnb0RNWi8zR1FKKy9ONzBtNmlCcXRVNDJmSktFVWRoUUM3ZTYrVWJq?=
 =?utf-8?B?Y2x3NXRiYjZRQXFCMFYrK0gyYml0V2NYbjBrdzN4R0ZrcVpLWSt3VDlKZjdI?=
 =?utf-8?B?OUFzWXlpY1llUllkZTZRNk9LZ2kxUG9JYjBLSnJQbnNwN0tFUTZucUloLy9P?=
 =?utf-8?B?OWNIRU1lMERoeksxZEZtamFIbGNBMDUrWE1DdC9wUEMrRTF6MnhlMUIrRzNJ?=
 =?utf-8?B?d1U5cjBjcVM4OEhmcFFSMURpYTl5d21sY1YvSW5EVCt5SytITUhiZmVzMkQw?=
 =?utf-8?B?ZnI1ZXpaeFBXWGVtdW1sbEl1MzRRa3puaDhNa3A5ejYrSExIaUh3Tzk3eVRI?=
 =?utf-8?B?T0thdWwyTFRVZE4zTklhR0lVV1B2dzN4UmhXMEw1d2FJOHF0S0VuR1FrbWkw?=
 =?utf-8?B?RkJQeHoxYzMxYWY0MnYvR0IrUFpjOEhMZGVBbTdFcktxSFFQeHJrLzIvWGVk?=
 =?utf-8?B?cDMvU0VIcWZPV0U0Rm12V3hDZjJmZTRlQXFsNkZEblM2NnVjWnBGckZ2bnJp?=
 =?utf-8?B?YzZQT3Y5K2thZUFOSENLYW1VQ3NqMzJxTWkyeUw5cHhYeVQxU3A0Z29FZVZM?=
 =?utf-8?B?T1JqS3pzYWJtVlRBNWxaTzRFaGFJcG5odG9aeG5iWUxGcjJBRWF4ek4rTm0w?=
 =?utf-8?B?VzFKRE9nM2xGQW9pbUdkclJuVFpqSkZCNlZsZS9EZzlONUVQQ0hCMmExQ2RY?=
 =?utf-8?Q?wjWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFKZkgxY09HTmV4M2pUS1lCaEF6b3ZSbWR4K2oxYWZSM0lrbkdTSkpNVXdX?=
 =?utf-8?B?c0UzOHpCUzRMV3NLZEhpR290eGRpMjFOUlcxaHdxdWE0RTBtYnBvYlhQNDhK?=
 =?utf-8?B?RkNjOEpBOVc5REdEZWFYUHBid0ljZ2VGR1RPRVNRRW5KUld2U1UvbEI5K3hX?=
 =?utf-8?B?NGlEK2cwUC9qS1NrWEVrNk5LcUoyWUs5dDJ2RkQ5UXVuT0toYnRPaWJpRUhE?=
 =?utf-8?B?TXVVK0hVZUZOK2drb1grUmFXUjdrSndlZG81ZjBUVWZnRHVZc3ZORnl3Z3cw?=
 =?utf-8?B?L1p1M2pTWnlXcFRIekRUR1M2Ym1qeWVjUTZpckxvZU5weHVVTWIwTkRzWXBY?=
 =?utf-8?B?QW9yQlgrRnV6RDVGOHMwSnlYeEFTdGtjdGVQdTE5Y2t5WHZPZWxiUDl0bEpC?=
 =?utf-8?B?V0lQRDRJcVU3OHcvVlNwd0N6N2tNMUpjdEN0WXA1YWdTTVhKQWlRbDQ1SWhS?=
 =?utf-8?B?blVVYjdMaHc2eHBxanRPOStMY0RmSkd4RDMrMk9hTWRsdXpLc2VROHhZWWZ5?=
 =?utf-8?B?Y2U0RmhOK3FUQ3c3cUEwVm9TbklWOEVLQ0xzZHZYcEtBU29jczVLU0RweDcx?=
 =?utf-8?B?THFQQmYyMEhWMlNnL2hmeGZKU3ZCR2JBR2lGQ2NGblBEMTJucnZlRGhXUERz?=
 =?utf-8?B?VU83bktVeDdMMGFidEFDKyt5emFESW9nblczVktBeWdhSnhzNlRDTjhldTZr?=
 =?utf-8?B?WWhEUXJnSUJlaDBIS1ByMWdHbEhFelRMdUtwSFhHMWYzQXB4SDFYNkFoMDd0?=
 =?utf-8?B?M3V0VkNaL2QxMERXU25hQ0dpTWxocFh1OFBENUNLaHdSemRqZ2pLYlMrUTNp?=
 =?utf-8?B?bld3OGFkOThLa2RqMThobExrQk9ObUJuaDBlSEc0M1JXKy91NURWUWRrb3l6?=
 =?utf-8?B?RWVuQlRBcmdFaHh1akYxeWJ5RkY1ckhBemxFaU1IY0hBalNDalhGOS9jaTJj?=
 =?utf-8?B?VVNBZ3hkVXhPaGVCdkpqZCt2bWo1L2xVRG5PMENKa0JuKy80QkhLRC9CNTNw?=
 =?utf-8?B?Q2Y2TlpvMklLTm9UQ01JUEJucFE5ZGExM012enhJSmJHakNIZW9JSy9wYmdy?=
 =?utf-8?B?VVZsZlNPNmxwWW5aeFhDemZhUHNlNUozalF1dGk4bjg5WldlYmJNUEMyQVQ0?=
 =?utf-8?B?L1pwTFZIZzNibytzbDNjVmNUazRQVDJWSmlxeUZvcVYyS0tRbm56clcvRy9k?=
 =?utf-8?B?Nk1LUjRaRjg5dVU4akFrMzVuZUQwYVhNOUFRaTVuM3N6aFlVaG5jM3hON3M4?=
 =?utf-8?B?SGdsam84SmNVSU9IMVRrU1RaWUcrajJROXNIdmFrZG1hdEVqYVlZRm5BQlFB?=
 =?utf-8?B?Y0VpYzRhNlJDaFhvZXA4dnJGTUlVT3hUcGw2UkQrNGNRcHhXb2J5cnJqWjVX?=
 =?utf-8?B?QnhEVitUbmtqYUNnSUpIVUF3aVlhS0lIcGRmWmZORlo5ZlE4aVFFVndtN2xV?=
 =?utf-8?B?VThOZWFlTzNOUzVpZFg2Mk5tclJyYlJ3eTUwaGNpVW45REtQaWJ0MlFhUDlP?=
 =?utf-8?B?VVhFcEtrSm5NTUkyVDM4aDBMK0V5dVA0SUttdFAwWURTV21TRERod1Nta3M0?=
 =?utf-8?B?SzMrTmVxUjRHTUlIWHZXUE52VW16TVo2MlRGcjZEbXRDL0hzbUpBRFFHZklX?=
 =?utf-8?B?cG9sRy9YaVFwcm1FSFNoRWJzNDJKR1pJaXBEZk5DOUs0QmJGOTR1ZXRxeXdk?=
 =?utf-8?B?anFETEFnaU5vTW12dW15TFhmM3FPUktJNWNhRmZuVDE4RVZzQTFVZDNTT3FX?=
 =?utf-8?B?TEhKQzQ2YWZqSFVPa3RWaDNMcFBlc0szWm9ScjltdUNNNXBkWHhjNUxYQlpm?=
 =?utf-8?B?dGlCVzZ1V25hNjBJNXBQK0NlOHJPMXZoREFKRXJiZkhZWG1XNTdlL3IvRlJm?=
 =?utf-8?B?alloNWk3aUJvLzRYVm5KNXFodmFUY0lOZTU2YjhremZHNHZ6Qk5ieGxiSndD?=
 =?utf-8?B?akJOSExWVFI5aGZvQm1KZHdwSlZrVkM5czRMMm9RYkVQd243bkV0TEpaK3lQ?=
 =?utf-8?B?T2JJbjJIQlZsZDZIMEhYMTB0cWViYXRyRTJQVk45RUxweHEreGV3WEJKNEJD?=
 =?utf-8?B?bFdxOWp1MmtZN0hvVmxNRTAyL29vdy9jc0laV2Rpc2lTOG9sczRpYktPcUZt?=
 =?utf-8?B?dXNkdlphQnBhUjd3UXlLZ0grWmIrTGtDOHA5bHdFa0U0SC85cXc1Yk9ENEMr?=
 =?utf-8?B?UFREVGY2MVZnM0NoZlV4UEluT0pUOVdCeFY2TUlkM3RuSTNxWUtlWnJJOFFw?=
 =?utf-8?B?SVlsdUx4ckF4eGdrblZoRlIzRVZmLzJKQ05wcmtSYTJWMG91YVRPS2h0STF5?=
 =?utf-8?Q?AujZWS3QpgkRD6QGH5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf65de8a-0d0c-4cdb-5b5f-08de602ffd97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 18:47:17.0438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IA540gJYvzjHzGeV7i5tg88cFlys131mS4moR41dwLElCC6z2nRBC303qadtnS43yStGApei9DGBhqZ7OllUaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C
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



On 1/18/26 10:31, Timur Kristóf wrote:
> dce60_clk_mgr was basically identical to dce_clk_mgr other than
> a few minor details. They can be all handled in the same file,
> reducing duplicated code and easing the maintenance burden for
> old DCE versions.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 ++++++--
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 142 ------------------
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -----
>   4 files changed, 52 insertions(+), 202 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 15cf13ec5302..9206eb8b0365 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -34,7 +34,6 @@
>   #include "dce110/dce110_clk_mgr.h"
>   #include "dce112/dce112_clk_mgr.h"
>   #include "dce120/dce120_clk_mgr.h"
> -#include "dce60/dce60_clk_mgr.h"
>   #include "dcn10/rv1_clk_mgr.h"
>   #include "dcn10/rv2_clk_mgr.h"
>   #include "dcn20/dcn20_clk_mgr.h"
> @@ -150,16 +149,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>   
>   	switch (asic_id.chip_family) {
>   #if defined(CONFIG_DRM_AMD_DC_SI)

The macro can be removed since it doesn't do anything anymore.

> -	case FAMILY_SI: {
> -		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
> -
> -		if (clk_mgr == NULL) {
> -			BREAK_TO_DEBUGGER();
> -			return NULL;
> -		}
> -		dce60_clk_mgr_construct(ctx, clk_mgr);
> -		return &clk_mgr->base;
> -	}
> +	case FAMILY_SI:
>   #endif
>   	case FAMILY_CI:
>   	case FAMILY_KV: {
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 6131ede2db7a..d02d03c154b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -62,6 +62,18 @@ static const struct clk_mgr_mask disp_clk_mask = {
>   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
> +/* Max clock values for each state indexed by "enum clocks_state": */
> +static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> +/* ClocksStateInvalid - should not be used */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateLow */
> +{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> +/* ClocksStateNominal */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> +/* ClocksStatePerformance */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
>   
>   /* Max clock values for each state indexed by "enum clocks_state": */
>   static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
> @@ -126,8 +138,25 @@ int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_r
>   	return dp_ref_clk_khz;
>   }
>   
> +static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> +{
> +	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> +	struct dc_context *ctx = clk_mgr_base->ctx;
> +	int dp_ref_clk_khz = 0;
> +
> +	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> +		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> +	else
> +		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> +
> +	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> +}
> +
>   int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>   {
> +	if (clk_mgr_base->ctx->dce_version <= DCE_VERSION_6_4)
> +		return dce60_get_dp_ref_freq_khz(clk_mgr_base);
> +
This should be moved down after variable declarations

>   	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>   	int dprefclk_wdivider;
>   	int dprefclk_src_sel;
> @@ -441,27 +470,37 @@ void dce_clk_mgr_construct(
>   	struct clk_mgr *base = &clk_mgr->base;
>   	struct dm_pp_static_clock_info static_clk_info = {0};
>   
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce80_max_clks_by_state,
> -		sizeof(dce80_max_clks_by_state));
> +	if (ctx->dce_version <= DCE_VERSION_6_4)
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce60_max_clks_by_state,
> +			sizeof(dce60_max_clks_by_state));
> +	else
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce80_max_clks_by_state,
> +			sizeof(dce80_max_clks_by_state));
> +
>   
>   	base->ctx = ctx;
>   	base->funcs = &dce_funcs;
>   
> -	clk_mgr->regs = &disp_clk_regs;
> -	clk_mgr->clk_mgr_shift = &disp_clk_shift;
> -	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> -	clk_mgr->dfs_bypass_disp_clk = 0;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		clk_mgr->regs = &disp_clk_regs;
> +		clk_mgr->clk_mgr_shift = &disp_clk_shift;
> +		clk_mgr->clk_mgr_mask = &disp_clk_mask;
> +	}
>   
> +	clk_mgr->dfs_bypass_disp_clk = 0;
>   	clk_mgr->dprefclk_ss_percentage = 0;
>   	clk_mgr->dprefclk_ss_divider = 1000;
>   	clk_mgr->ss_on_dprefclk = false;
>   
> -	if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> -		clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> -	else
> -		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> -	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> +			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> +		else
> +			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> +		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	}
>   
>   	base->clks.max_supported_dispclk_khz =
>   		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> @@ -469,4 +508,3 @@ void dce_clk_mgr_construct(
>   	dce_clock_read_integrated_info(clk_mgr);
>   	dce_clock_read_ss_info(clk_mgr);
>   }
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> deleted file mode 100644
> index 1fdf344efe1a..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#include "dccg.h"
> -#include "clk_mgr_internal.h"
> -#include "dce100/dce_clk_mgr.h"
> -#include "dce110/dce110_clk_mgr.h"
> -#include "dce60_clk_mgr.h"
> -#include "reg_helper.h"
> -#include "dmcu.h"
> -#include "core_types.h"
> -#include "dal_asic_id.h"
> -
> -/*
> - * Currently the register shifts and masks in this file are used for dce60
> - * which has no DPREFCLK_CNTL register
> - * TODO: remove this when DENTIST_DISPCLK_CNTL
> - * is moved to dccg, where it belongs
> - */
> -#include "dce/dce_6_0_d.h"
> -#include "dce/dce_6_0_sh_mask.h"
> -
> -/* Max clock values for each state indexed by "enum clocks_state": */
> -static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> -/* ClocksStateInvalid - should not be used */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateLow */
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> -/* ClocksStateNominal */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> -/* ClocksStatePerformance */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
> -
> -static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> -{
> -	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dc_context *ctx = clk_mgr_base->ctx;
> -	int dp_ref_clk_khz = 0;
> -
> -	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> -		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> -	else
> -		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> -
> -	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> -}
> -
> -static void dce60_pplib_apply_display_requirements(
> -	struct dc *dc,
> -	struct dc_state *context)
> -{
> -	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
> -
> -	dce110_fill_display_configs(context, pp_display_cfg);
> -
> -	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> -		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
> -}
> -
> -static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
> -			struct dc_state *context,
> -			bool safe_to_lower)
> -{
> -	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
> -	const int max_disp_clk =
> -		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
> -
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
> -	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
> -		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
> -		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> -	}
> -	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc, context);
> -}
> -
> -
> -
> -
> -
> -
> -
> -
> -static struct clk_mgr_funcs dce60_funcs = {
> -	.get_dp_ref_clk_frequency = dce60_get_dp_ref_freq_khz,
> -	.update_clocks = dce60_update_clocks
> -};
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr)
> -{
> -	struct clk_mgr *base = &clk_mgr->base;
> -
> -	dce_clk_mgr_construct(ctx, clk_mgr);
> -
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce60_max_clks_by_state,
> -		sizeof(dce60_max_clks_by_state));
> -
> -	clk_mgr->regs = NULL;
> -	clk_mgr->clk_mgr_shift = NULL;
> -	clk_mgr->clk_mgr_mask = NULL;
> -	clk_mgr->base.funcs = &dce60_funcs;
> -
> -	base->clks.max_supported_dispclk_khz =
> -		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -}
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> deleted file mode 100644
> index eca3e5168089..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
> -#define DAL_DC_DCE_DCE60_CLK_MGR_H_
> -
> -#include "dc.h"
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr_dce);
> -
> -#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */

