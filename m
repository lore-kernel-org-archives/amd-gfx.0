Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A0DCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B18A10E53E;
	Mon, 22 Jun 2026 08:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJmEleEN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4992910E53B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5DuuwfKw5qd+DHvbIWlw74ZnuZ3dPcRf37W/8RRqNvRmvPp0QE1KJ/cJrLjajnANpqtT/rUFyw3GYuGKFiPLVNFWf1mXvT8VA04hTn4RlegkybmabUXbMQyJdBbUwUr4u95KRZnw8+o+YfIhQcG5ED8Iox7hW1W5gqk4cZmGztCxHuYxl7E9wnAVw1gbK46pEWxfU9JgzJUTL7WcqtFq3/DcKCQP6KizdNYKkjIOpL3gYMydERsxz0WgYqczVibprb1ZqgXyjVXIUM/d3cjOOg9ewrVtsFLWnEXi85Yy0MpbCa+GGzmTNoNwa0UJDUAfyJymasWfLFC4ARCT7m2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zCeBJ8zoQPaxjq1Tv7Qmy9svBdcBPms2rjrnrHMEVo=;
 b=dJPwBXwBOyJchpAOrqU9xAvO+uLmSrOdUcq7wFpY8AoMRXOErpSOo2Yx1lw0e3lydLVHGmy4CaQtkO5ZjUWfB/Q0wfxIPCnCvi93LZoIiBTEN2W5S6enR5BugNAAsl/68rUeUw0BLfKzlj4Q3gM9fiwBJEKBqKlFCxK6TT4BR1iGIphv1uDVDWJgHYbOjsXL9My05EAkPI3XsWystJqfMxwWn3APJldGDmcGGd+TuH/4U2wyVOm3dBEis5rgUkvN/lk+0gJUWEe++C20l0dboVlV+1H/Y25ex43jr4gvLoBHCMlUCyn4VXNJQw5wf5mfBlsaJas/POkKKIJ08ezwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zCeBJ8zoQPaxjq1Tv7Qmy9svBdcBPms2rjrnrHMEVo=;
 b=zJmEleENKcx9iUUxGnZ255vd+dpv8hUytOyWyEfcmtf6mpiyK9p4gRTTQh2/ovynwbuHD5F3wuii1Noh4rABrfgsDFNEgiUSQQ4nQ8qSk6v96pZumiKpOO4rOtOOhVdf95lGJzh+ZVCGZKUIFLVMIaor0q4x6aA9yKVFXlHCKLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 08:22:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 08:22:22 +0000
Message-ID: <10397a2a-88cf-4070-aced-291e24785a8d@amd.com>
Date: Mon, 22 Jun 2026 10:22:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Support some Barco AMD based graphics adapters
To: Matthew Jacob <mjacob@feralsw.com>, alexdeucher@gmail.com
Cc: amd-gfx@lists.freedesktop.org, feralmatt@pm.me
References: <1b83ac6f-1018-3dee-c029-1b2ed78a8460@feralsw.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1b83ac6f-1018-3dee-c029-1b2ed78a8460@feralsw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0430.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: f7022854-f7f6-4b6a-5e57-08ded037620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RK4f4iGVRC5a4I79ljvvRw4Z9bymY+VFfTup4a8zgPtrSGj8xIqJG5eoE4BubsVUPIgqd+wzib2iQ2DsmQaeMZf17aa0phjsVxrVWUP5rs6hk31JXH1mgMasVV8RVCTg6+YNtkdj6RtEGKgEQjKb/2ZcNNgn3csAqNvToFlQZ7T5wzeHFAROYoDmiKiGBZdna5cSZi2yW8Uu7NDXUQcZVxy8Di+aboC2bPw4ozv2m1EMD9LpHQBaeyn2IDBm0WlKktKWLH2/xQ1JhHH4L5PRIjCw4qLLpuDOAFWUtq2iIQ1gF9xV6PuGwbm/00HvSont9pl7RdGSXUF818Q71bpRDCVSzUjkFCIsyC10arLxKgelNoss4i1xZUDY5mGUS6GRPyeyaVZRzou3iBY3SgZxzR/+r2dfquJqLnFwKNQtpHgKXj26KZuitCpluaeZXkY8Ttx4qMWVlKtNSkx+8wbT99R1yxHbI4Aion+xeUGHGD5Fn2X7+L+vbqEUS3en6ecQkRJJ9q/AH1hO3/shlTcGvp0hbpyg0sfxV4Sy/8QP9Vkx8FornbgcD9YkPw5VToVwMKKGqDVOuIAtL0nl2x2qV2k0g6ccvNxdrXLhTKxUNElHoPNV+C8mYL/45OD7F0v1D63b31snND6OjNWzVVhpO58KsA1NANlKpH6um7FFLwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTI5N0xmMGlUcmpYbU5LTHVja2xvTmZ0ajZMK1lrTE5INFRmMVkxTEtlaEFu?=
 =?utf-8?B?K1dRODVMbTkrRW1XNlhNQXU5Y1ZZYXMrdzFpRFRkdzhUV3hma1BCazJheHZQ?=
 =?utf-8?B?RHJLSk92NFpuNmRReDg2bnY5MzdHSjVlVU4raWpQOVpqOUIrUWgrQzhJUlhP?=
 =?utf-8?B?NVZ3Qnp3eVVLaHVEbTAyUVEyM3l3NGkvbElIZlFJalBzUHl0QjkxL2FERU5U?=
 =?utf-8?B?a2J4Mk9qbjU1eFBGMWw5RHJmU1RtSm91SC9LZWI0VGduUElHcUo5Zm52SFov?=
 =?utf-8?B?WFdHR202blNaSGExWW82ZmJNbVBLNXFEdHhQeU9CTXN6SDhrSlltWU9TeXlz?=
 =?utf-8?B?RHA4ZDNpeW9xV3ZWeDVGRHltVU0zS1Y3VHZGSzBmYmZ3cll5TjRmc0Vrelk1?=
 =?utf-8?B?c3R3dGVQalYyR1k0YUs3M1BNMUpTd0psdTVESDdZeTJ4eHpTcmxKNlAvY3Ns?=
 =?utf-8?B?ZEFkS0FwbEF0VDVVbmw3QjZPZHRTNlYvckFDdW9VKzBzTTZ1QVlhZWFPazUy?=
 =?utf-8?B?cHJWU0tjTEo4K3MxZEpnMk9qRTZjVk9vTkNqK09Gd05wTXhJRGtybnQxUGxa?=
 =?utf-8?B?YkN0SnBRcWJ1V1MwcWloZTJRUnROOTZCSDhuNk82UjlEOWFLTlNoZlV3VGNB?=
 =?utf-8?B?ZXJEUTJIU2Zza2JkR3Ziekw0Snp6VndpbWlFeDlNcTZLS0RrL3dqdHNiSitl?=
 =?utf-8?B?NVZOaExmeE1VeTQ4b2IvRnZTVW5lK1hNZmFJOVZSNmEzaVM4bmNxcjRHK3VZ?=
 =?utf-8?B?SWNqellKWVk4MnZHdlZsajN4bnJpd1R2WURScktCcnJHVGQyVGR0L0cyWWxu?=
 =?utf-8?B?bjY5RU1oVEo1ZUdPbU1qTjRWMU9HUFdzSGhsNERCK1R0cEo3aDlCOFRDMVEw?=
 =?utf-8?B?V0pRWnFCK2pSMXRPbUxsV29ackptcEUzaWxiaDc3UU1UbE9jMDY4enNVaUk5?=
 =?utf-8?B?dmdFNURvakVsZjMvV25razN6NGR6MURPakxadEdkdFo5UExIVkNnZ24zVjJo?=
 =?utf-8?B?YTY1b2xtR1gwN3M0ZjRhYkNwb0VmY253cGVPd2x5a1UxVGFiUkZTZUFTbGRX?=
 =?utf-8?B?RGNPRGFpYU5Gc3Nqb083MkVsWkpjeFl1R0xTZzZlc3EyTUU1ekhLc1YwZTEy?=
 =?utf-8?B?TkxiUFhOdnRGNDVCWWcrU0R6MGplR3JHQ1BWVFhtTTZlV3FkVjl5a3NRRjhp?=
 =?utf-8?B?R1V0UldZTVVXazFLV3J0OFdIRUZVOVkzRGUxS2Nzc0dneUFRQ0JRSlZjL1dI?=
 =?utf-8?B?QjBxejIvM1N6UjlVejgvRkJrTmEvTi9jblNKMklXd3dXL0xkVWRqS0RRdHBi?=
 =?utf-8?B?aTlnR3d0MmFnL3dKczlqVVkrS1F3ekw5a0JlQVhkWEhiZnh5YThVc1lxdWV1?=
 =?utf-8?B?cWhLRVMyeDZNRkdNeVZwWDc1NHBVU1U3MnlBV1BRc1M4VlR1MS9uSGRIUzJV?=
 =?utf-8?B?UjF0dUhkMlB4MHBMVWs3L1pBNGVCWFVuQU5RMkNsaVRWYUgyNHV4QVdyTTAz?=
 =?utf-8?B?aEZPY05EMnllM0FxN21ISm1oNXpIZnVXWDUzZDhUNHVmLzN4eUF0MG13ZHFz?=
 =?utf-8?B?SWR4UElncitxTWkxV2hlbzJiclIrVG83RmJnSDlDRzlPYWM1c2JwTzRiV1lN?=
 =?utf-8?B?elhvMVhteDVPeC92NC9nSUxacFpEaVdJd3M5MTcxYlRlUVh6bVdZWi9wSG5q?=
 =?utf-8?B?N3V2ZGdyTDdXeGVsWHZPbVl4NWNPcVJIZzRtME9jcU1hUERDeVJLN0hxZVVE?=
 =?utf-8?B?VjZDL0ZLRi9LVWdONHpnb2lFaXlEZXhOUkUwZENWc2hIOWhISzA0RkswMG5q?=
 =?utf-8?B?cFI1TWZYeFFEMEswREZXQ3BueTZHT2YyMjJDamxtc3NPeGRSNDhTb2VSL0o4?=
 =?utf-8?B?ajBMQmxzdEFqSW1sZ2NIaE1lb2VoNStLdDREN2NRMm1SUnMxaXhnTEdKQkpx?=
 =?utf-8?B?UEdTZjB0WVpWNmdLc0hhRWVFeHJtOWJISXp3c0NyWWU5VXNKWk52S1J1TnRa?=
 =?utf-8?B?dTdraS9IZ0FpeWFNaUJEMk1yZkV5NjJQbklOR3BjVllvaUlQMlNEb1JHZWlm?=
 =?utf-8?B?cStFUXFudStPOWY2Z2ZOaW53dDIrek5ZNk5TUVFWTmM2eEtlZ09CR1RBcyti?=
 =?utf-8?B?azZaNSt6TnM2RU1mOHBOVUtmWmFXN1FLa1BFTkd1NjFQOW1aN1NsR3dpa1BB?=
 =?utf-8?B?Q1dxcDYxRURDRXM3LzlWRnh4dDV4Z3hBTkM0RytKTGdqN1JNTG1Ea0RCZndK?=
 =?utf-8?B?eDFsVG1naXhVRHl2V2F6cDFjVUhJa3ZXSEVOVklZcHQxeUh5SmdKM2t0VWVy?=
 =?utf-8?Q?s2f1s324PmtZxL+ar1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7022854-f7f6-4b6a-5e57-08ded037620f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:22:22.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eDLPefhCqTEV6iZxFRZAD5U6RdHZWIN2oKi8Kn2p2PfEyazw8y4wgdZ8st7xu3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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

On 6/19/26 20:45, Matthew Jacob wrote:
> 
> These adapters typically are only supported by Barco on the Windows
> platform. However, with these changes in the linux driver, multiple
> monitor support should work correctly.
> 
> Signed-off-by: Matthew Jacob <mjacob@feralsw.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 60debd543e44..e3ba168795cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1926,6 +1926,7 @@ static const struct pci_device_id pciidlist[] = {
>        {0x1002, 0x6646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
>        {0x1002, 0x6647, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE|AMD_IS_MOBILITY},
>        {0x1002, 0x6649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
> +       {0x1002, 0x664D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE}, // Barco MXRT-5600

Please no // style comments in kernel code.

Apart from that looks good to me, but I'm wondering if we shouldn't print a warning or similar.

It could be that those boards have non standard VBIOS changes and cause problems on Linux.

Regards,
Christian.

>        {0x1002, 0x6650, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>        {0x1002, 0x6651, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
>        {0x1002, 0x6658, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BONAIRE},
> @@ -1995,6 +1996,7 @@ static const struct pci_device_id pciidlist[] = {
>        {0x1002, 0x6930, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
>        {0x1002, 0x6938, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
>        {0x1002, 0x6939, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA},
> +       {0x1002, 0x693B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TONGA}, // Barco MXRT-7600
>        /* fiji */
>        {0x1002, 0x7300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_FIJI},
>        {0x1002, 0x730F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_FIJI},
> @@ -2023,6 +2025,7 @@ static const struct pci_device_id pciidlist[] = {
>        {0x1002, 0x67C4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>        {0x1002, 0x67C7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>        {0x1002, 0x67D0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
> +       {0x1002, 0x67D4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10}, // Tentative Barco MXRT-8750
>        {0x1002, 0x67DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>        {0x1002, 0x67C8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
>        {0x1002, 0x67C9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
> @@ -2036,6 +2039,7 @@ static const struct pci_device_id pciidlist[] = {
>        {0x1002, 0x6985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>        {0x1002, 0x6986, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>        {0x1002, 0x6987, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
> +       {0x1002, 0x698F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12}, // Tentative Barco MXRT-4700
>        {0x1002, 0x6995, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>        {0x1002, 0x6997, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
>        {0x1002, 0x699F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
> -- 
> 2.47.3
> 

