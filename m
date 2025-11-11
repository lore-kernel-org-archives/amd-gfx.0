Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9136DCCFA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 15:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F6510E33F;
	Tue, 11 Nov 2025 15:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZeWOrG/6";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA6B10E33F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 15:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCrZj9BM8XWB8pI9PXBgxeT4zNwL0lv30sS7lN2CASpg5QUIjiTVeT0viiRako4Ih1UpRY9j1eUD+T+zXCjxBKLk/FDUbZXjkL247YlQhhkpNJJDlLuknrL+uQmCNVvtdGShqlD00jHXLmfmn5zjq8mcSlV4BOzfF+TELE6CpTQe9tVZSZfq9nFo39aX2eqyrd6v8jcR9blcMxCulS03KkeR2Ta9DPETINXMjjx9OX/n0QI4Rv4XMYoWkMtBM+e3pRLDzYKMgmldPxqClvkaSa6TgJ4ywk386kQiwX6R4fjnjVMD2Yxx8FFZD5UmGS/S5WsvAlSLryGWdV4SmtKKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2n4XilVGzH/HQaH3BzOcVTZlnDf5I9t0EGrgKb+bBw=;
 b=KjjK2306WBtjrqbMG8xzy1GwTbw9zYxLMpVHr7woG4UcuayFOEa8hA4nA7559MAKnBZCrnE+wilmIloPkxuvV0+a73fmM5bOH7vJPbAP97GyEAfmnsRKZHnF7yQdjyRUk4acuHhJlO4kf1DsmkJqJD8FljaQD+nPXiEkh4kGL5gZJw0lRHPaPKUT5hQcuIotbO3f1Mp0ipvu7/yNo+Tje7axCJU163HUaxfge9pupZQPmMqJWhEZSj5hlpafOFbuCYaVZSFFqPgKFYabEsq2WmoeQyNsEFK4YdLVmof4mwUcVkwZuNjq2rh92ohDI1VKXlwBy4QVMlv/tWAKbabhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2n4XilVGzH/HQaH3BzOcVTZlnDf5I9t0EGrgKb+bBw=;
 b=ZeWOrG/6yuQGEZ/9ChsQhFGVatftKBNxUGLkGCoBPMioJweV8SLs+7HNiyyEjgmTll7YZ+FOmupuGROdCDxr3XkR4SvA+Y9vIrUrQ5Y3Kha3S/bRlL7aX2iNhIY9jPgNJXDDniHOtHDwXJi+iP/OKi1Q/9z8wbMJ75rpTOvLKgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:21:29 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 15:21:27 +0000
Message-ID: <591ae54d-4ee6-a31e-8524-53d05f3e137d@amd.com>
Date: Tue, 11 Nov 2025 10:21:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Use huge page size to check split svm range
 alignment
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251110203007.246736-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251110203007.246736-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: cce779e8-7510-4c29-0169-08de2135fbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2dpb3hvUzR6L1U1VllLSFU2dUFuWFlsVUFmdkM1Z1ZJcGpldjNWZjJmNnRl?=
 =?utf-8?B?NFBidStSMVpxL3JoQlZsRmw2T2tCdjBPRzZMc1cwbWpZMzJjVkdVT0lia2p1?=
 =?utf-8?B?SHNXUWQ1VkRNREthMHlOUlNEVTU4Y3gxTU5MWFU0S3Rza1JsNzBrWVduZC9a?=
 =?utf-8?B?M3hwTkNEcVV5UVVDS1EwdEZlbG5kVmNjZVdVYVZMTll2RTVnNzVkV2Jxbm1n?=
 =?utf-8?B?Zjgyd013OS9yWkN1VG9xcTc4QmhZc3k5N1ZIYUMrN1BpeXczakRYVUJKZCts?=
 =?utf-8?B?bE5HZ20rMHBnY2ZiSU1KdXpXSk5vZnZSeEtyQjlXWGxaRmJpRHVyNFhZay9a?=
 =?utf-8?B?WU5kbkxSRXkwc1oyV3NLMythaUx2NFZGRzRUd0d4N3BKcnJpWjVnQ0VEL1dq?=
 =?utf-8?B?R0ZpQmlaVWlKVGRZRllEUTBDV2Vubm9mY2l4My9HeCttYUdaSThVTEJXNHlY?=
 =?utf-8?B?OGJ4VXc5TkJtbjU2aWh0eFYrQ0hyeFVtSW0vK2ZXTkcwYnlsdlVUcmdrYlJv?=
 =?utf-8?B?eVVhc0hIM2NiY01VRjRaRkR1d3ExNXBUS2haSWthdTJ3dDlCbXA2ZGptSXdq?=
 =?utf-8?B?bERzczQ4OTZqUTVMd21ibnRrTXErWE1VaitscnA4N21DMXJvQ3VKQVBkQVo3?=
 =?utf-8?B?L2U0R1ZrOGNwYVY3T012WmwvR0x3K3RSM2IxbjE5WWJSdDZ5Ylh6WTgyMzNs?=
 =?utf-8?B?RmxFaVJTcW5RNFgwY2NQcDM3c05kYmZQRVFRZ1lzRkF1aEl2elVUcEZXd085?=
 =?utf-8?B?VGtFZGlxNHhLcG9PY3RuRkgyZkFQK3N1QWc4dDViNDRxWmxQQWpmT1hJczNt?=
 =?utf-8?B?M28rNU5WblF6d25Uc1lObmgwcWZLbnFqcG1RRGZlU082cTA2SDcrdUZ0WHcy?=
 =?utf-8?B?MFBNcE12UmhYZnBnOVZBdnVRYnFiZlNuR1gvcmU0bTA0SnVnMXF3cUZXVmFm?=
 =?utf-8?B?aXlkZ3c1TVJ4dzZjWmc0R1BnZkh2VTBMS2JOTjN6MHVRWDhpSU1FRG1OSEdl?=
 =?utf-8?B?eG1nUGdMcE52YWp1eGwrMU1ZVzFSNFVnc3hRekYvRk8ySStwRThwREhnMWE0?=
 =?utf-8?B?Qjd1aXhBRUg1cktPR09TdjFmckxwODBHeDdhc3hYZ1FJR3VJdWZudi9CY3lQ?=
 =?utf-8?B?Y1NVanA2dThxUGFqdXJRaHMvUGxRS1hHYUkyQ045dXhScmJXMlRweDlhdGdI?=
 =?utf-8?B?Y2c3anRFYTZLMXYvREYxVDlTOEtPeDk2bWNaS25XdDJhbXlMK3owNUNWSE9D?=
 =?utf-8?B?QUhSTHk0Y01EU1IzZzJLakhLbXMwelRaYUVjN09VOWhWaU41RGRGQzlJZmhW?=
 =?utf-8?B?MVo5YnhrVERvWXErdEcyS0VSSno5ZGZ0MU1LWWJ5WWFtb1p0ZmZiMXZTNUgv?=
 =?utf-8?B?VFp4ZWFYUEVMTDdYZTdSdDRuUk9JMllKNVFyajduUnViL3dCckVyZFVOY2NC?=
 =?utf-8?B?aS9RN3BoZW1BTHFMYlNMTlhOSHlNVm41MCtQRENKODJCbUpaYnVVUmhwbGZI?=
 =?utf-8?B?Y0RuKytqQTJjaHNmWHFzeU5RUHYzOWxnaVhzNVE3eFFzaW10OUh4VWdreFRI?=
 =?utf-8?B?KzkvZDVRMG9RT2g2VlQwYTJ4aFZXeDBCWW5HZzRrOFptMkw2YVI0NHE4Tm55?=
 =?utf-8?B?WVVVSFlyR2p4WmNZRjhiaEF1WXNnM0hGWUhPV3BaWkRFb0RzWHhqc3lLVjNX?=
 =?utf-8?B?UC9FUzhoYWgyaHJ3S0J1VmZZcE1iandqQ1FXK3NxSG1pMnJFZ1Y5ait0Qk5h?=
 =?utf-8?B?dVVCQStwOHdjR2RkdUNKTzJieVpObHROc1NyQUNtUTlEQXI3Y25tclRnMkMx?=
 =?utf-8?B?Yy9rMGxpRGF1MzZrMzEvOHRqcUUwSGhZKzNCQ2twTStkZitIL3grZWNFaDFT?=
 =?utf-8?B?UmNTUk5ZNG1VKzRCdVJQMEVhTy9qRlQ1TEhUZDJwbExvQmN0Z1ZZa0tsZHZL?=
 =?utf-8?Q?qRmd7p7fNpep2KPAhMIbBjnqICRCoX1q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JhK0dudWZ6eTRjcnJhVVVJZVNGN0VRUzNvbzcrVVZZWjhDWE9SSk4wTy9t?=
 =?utf-8?B?ZFdjZ2taNTJ1YVdnbFM4MzlQOTR5RzRTOWJZZXFpNkFucVRjekowd3liUTRD?=
 =?utf-8?B?blVpaVFjVlE5Qm9IN1VGZWRTbmNKQitVVWVRZWhkRUVQZ1RIby9iV2xkdnFt?=
 =?utf-8?B?SXlGTDV6UE01TEg0dUlDK1hzMGRWTTJsMGZabFI5WWVCVHprdnlMOVNNSWky?=
 =?utf-8?B?Qk5ZK3pyQlJZRS91dTJ2cFNTNXBKdmlGdmpEREQ4QUhSRERMVUJOeFAvcjZE?=
 =?utf-8?B?cmdFN29lbXBsUW1XZzZnc25xWWpqMDNJNVNRTGdvQkZEazB5MkpoWHFaWDFM?=
 =?utf-8?B?bTZhMjBkYUxOTEZqaUZtRU5EOWpLUXRodVBQL2VYemdRR1dOcFNJbGdWQ2Vz?=
 =?utf-8?B?aWFVNzlMV0taSjJEU25zMjcwQ0tUZGpDTmplNHNWOXVueFpGOG14TFJka1ZD?=
 =?utf-8?B?Rk5ZZ2RUMjMxOEs1dlFsRVQ1M2hEUytPY0FsZGJKNy94NGxOdEdvbjc0bUU2?=
 =?utf-8?B?MTBMQTdQOGFiUGZ6VnZrVXhIdTl6Z25HTWJVOCszWmM1RnptSWlsVVpxQlhi?=
 =?utf-8?B?MlRESWV6Z1FpWUp2SVBoNjI2M0hUSUhJNTJsNzNsMkZ1UVNHdlRGTEwweUhB?=
 =?utf-8?B?NGU5Z0pKczh4eEVMQVpLUUU2aUdLVDdBOElpaWIzdm9iNGtLTlUyZEFsRzFU?=
 =?utf-8?B?UVNaUlRnc3NmdjZMdGRWeVZNNU9Lc0VINHBSaTdaV1dUT1lJMG4rS0ZQblMv?=
 =?utf-8?B?alRWb3ZHYzdjWDNIS3pXc3VWZUM5RnpBTjZ3M0dzamF4VlFjTW41L0ZEMGtJ?=
 =?utf-8?B?cW4xTERYczRpMUFsR0JUVmYxZXZzVHc3L082WW85bzdnWTdrRmJSdkJMK3dE?=
 =?utf-8?B?ZkZ5ZngvTkVVbkZVMGZqUHUydytpY3ovb01BSXQ5Wk5HSjgzTlpHZkFtTVVE?=
 =?utf-8?B?RzNnV29LOEIvelhLeXFhT2JRSmZwcEgyT0gxZFVNWGdWb1pXUm9HV213M2lX?=
 =?utf-8?B?N0c5REVvUm9Wb2pHM0orbExGSUJFZXRqOHNwcEIwUVM1czNLSHJWS3VYbVZU?=
 =?utf-8?B?dWY0RDdlRmtXZWg1MzVlL1VGalo2YlBQOGg3a3BRak9SdnJvZ1hmSndGQzA4?=
 =?utf-8?B?WEM2aXVmdjZheWVuekRJTmR0UTNadEUzaGV1b2RQTlJ1L21MSFNvOUVHZ1Ey?=
 =?utf-8?B?bTUxclpERko5eUVwOHhTRGx0ekJUVCtwSFNKQWdjSmgyQzRIbHhjSTNDczE2?=
 =?utf-8?B?UnAxNW0vZ3NlRGVWOHFTb01Vd09JUzFZSWFVbWE0OXhxMXlCL0l6Zk1ZZ3hV?=
 =?utf-8?B?dytoMkVvR2hkdHl4WTZ2UEFlYW5XS0tyY2c5K29MM0pZVFVKd05EdnZiL05l?=
 =?utf-8?B?eXVaeW42cW1RaGFtYzVidWFFQlRORWp4K2hTdTYrWU9PSkY4OEhOZE1KZHE2?=
 =?utf-8?B?aHprYURaY0FxZzZieFgyemVaQnYrSXAxV1BNaXQwdTJiNFBnRnBtSjlvMW5q?=
 =?utf-8?B?WXM4NWdxK2xlUGlGSWlwYWgwTFM4akoyaDcyalFiWTVGTWcxN0JWeWFURkZk?=
 =?utf-8?B?T2hWelNUQzR2UUFTVWdvR0hXOVBYbkF6Mk5sUE1KT3pqU1JCTE02akdnQXRh?=
 =?utf-8?B?c2FYZzVCZGlYV21RelVuZDJsZmIwcllQcWtTemduSVRuSjdmYkV6VEZiQW9n?=
 =?utf-8?B?c1FZeDQxYjdlclc5SGUvNmlzUzVXRTVEdE01eHVCUWVmZnlvQ0N3eWcrdHBw?=
 =?utf-8?B?YWVMdHY3Wlp0MEVUMjBIUjh1alZaSjNnSlVyb3ArMVgxNDlTWEpDVGdLTjZY?=
 =?utf-8?B?TW9oT2c2U0tXQU8xSmxvOCtHZTV2aUpJaXhyQnI2VEJmTmJUSFZ2T1pPQ2hq?=
 =?utf-8?B?K1hGd0VjWmdhR0VQMWVXeGg5NFFwemdGUW9wc290OUhGbE9GZ0YxK0c5OXZE?=
 =?utf-8?B?TVo3ZUEyakcwNUgwQVNYaEdYWkp5VitjNEpDUUpBNmU0RUZmQ2NsODlrSlcv?=
 =?utf-8?B?SWxKWlgwU0VGbTVwV1dXdzZSaDlJUkpEZjNTR00yMUtWNzFWY3kzOTQxV1Vt?=
 =?utf-8?B?ZXNPZzBaUTJOMWJtdWxObW9NKzE1aE1uSjZOenNDSU43N3dWcUlWa2NuWjB4?=
 =?utf-8?Q?E61g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce779e8-7510-4c29-0169-08de2135fbc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:21:27.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jFGrP3ZieevT3oIwPdC1RWDH31P4A6vbY8HDN4UzKAMc2dTZwVN5FtUtAsdpeBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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


On 2025-11-10 15:30, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)
>
> When split svm ranges that have been mapped using huge page should use huge
> page size(2MB) to check split range alignment, not prange->granularity that
> means migration granularity.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 521c14c7a789..3af85c232659 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1149,7 +1149,7 @@ svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>   
>   	if (!r) {
>   		list_add(&tail->list, insert_list);
> -		if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
> +		if (!IS_ALIGNED(new_last + 1, 512))
we should check the original prange size is larger than 512 pages
           if (!IS_ALIGNED(new_last + 1, 512) && tail->last - 
prange->start >= 512)
>   			list_add(&tail->update_list, remap_list);
>   	}
>   	return r;
> @@ -1164,7 +1164,7 @@ svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>   
>   	if (!r) {
>   		list_add(&head->list, insert_list);
> -		if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
> +		if (!IS_ALIGNED(new_start, 512))

if (!IS_ALIGNED(new_start, 512) && prange->last - head->start >= 512)

Regards,

Philip

>   			list_add(&head->update_list, remap_list);
>   	}
>   	return r;
