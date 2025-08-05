Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E3C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 04:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AB810E463;
	Tue,  5 Aug 2025 04:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dOt1yw2i";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5080810E463
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 04:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxu4NwNC1OmbEIXMCFQ5o6atWdMcL6wSgKBCe+toh9GseBLQTNLeg9Kt/OsP/FqqPKCTjeoslFStrlbWZe+4L5GcPDzpPsBBY6d8hwCsmf8ztukF2R/g/j0ZTvxOOJLV7cG7GIBipWta922FZ9bKo6noCUQJ7X1JXQ9YSSufXkXkIOvxWXZuIjRynE2yp2YKtx7w7UPG0UtaXdfFFx/hvKlrlr2wQYAM8rEaFzkBCtGpA9Rzlva9tlJnNKpP6HKnvGNIbhW5U0t711CGzpvysd4PbgkilpslgF7kB1WH7wnb2Dsk6YwyL7LDiroc8JvHdf+b9ZmFCfoC+ZUGrK1uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOOzp7mwe06JpHE5NV50h9mLvazU8fX1tfX3qSPSPcQ=;
 b=TdKZJCV/+lkHMWlQGZJQmoyM4o0uwHW1FE5js/1KVtSLG9Dgt1knLpCCItT9G7Zyt+ANZzD2EHxqSGJj6SycUJlHlb9mjCDTvxaTLW/X3JMrvHyBMs32T57pt7GA9tJKpXjkCp/wLmAsTQLiXCesYSEgtS62VTpqumx/4vHLG30qTT5RJWAsVoR4YUNtSAzi0i8ACKQF8FmpYY6xZK/5NNn2S9e/mGFp1nvjRFrof/uj1JpVfo4t5y4fv6MmuFrYo6Muod/ITOIKxIo5JvNl6CAyo9hFYRGt+gFhiXiSDOK2azuqaTAkNjJAVHytBq9OkNidezGIKqjOEVClHfLxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOOzp7mwe06JpHE5NV50h9mLvazU8fX1tfX3qSPSPcQ=;
 b=dOt1yw2ivPeMc4zCw9zcCWa41rqQL0dAZDgOO0cBJ4Ao9nnDWk9ly/HTmlAyzyeL325L3RUNLVnbSUirbS68Fqw7bwxQLswQ6AM5SyhekvjA9yGbvZ2ACNh1mKCbBlG+SGL3AF9N09Cwo1pVHZEZuEWE2q7qMNj0yvAeh+C3HIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 04:54:00 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 04:54:00 +0000
Message-ID: <973ede81-b9f0-4b5d-8c59-a7c461d171e1@amd.com>
Date: Tue, 5 Aug 2025 10:23:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] drm/amd/pm: Enable temperature metrics caps
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com
References: <20250804141757.643501-1-asad.kamal@amd.com>
 <20250804141757.643501-6-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250804141757.643501-6-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d960cd9-d17c-4503-33cc-08ddd3dc176c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWtXNGt5czFhbGFiTFpwQ2N0N3I5SG1aUW9tbVArNmRHM29Yc1VITTJyUjN6?=
 =?utf-8?B?SkdBcnVVM05FSktMUzN4YjZ6dEIva2xqWEpVSmVnR1dZRDJSWlJON1ZZbFNk?=
 =?utf-8?B?dDd3UzdhVTA4UnRKZG9YTjNkQ1l1aVNqV2V4R2JoalA0R2twZlBvUW9iWmVL?=
 =?utf-8?B?VkVkby9lN0VtcnRRblNseVJlM3NmTWhUQmVWZGdlV1VmS2g1UUcvOHdhWXdz?=
 =?utf-8?B?djBuRVo3WFRITC9SMkVZZUw4a0JIS1VUc3NSR2UxOE1kNjUvb3N5c0dIOG00?=
 =?utf-8?B?VUZIWVlmWllRcnNoOWJhUnp4cnZiZFFIdnJYcGhQYTk1c2tTZkdMRFNGUkZm?=
 =?utf-8?B?WWgrOXYwTEU2RkNQc3UzNEs4dmFjQk8vNTNmTzFkMTFTVzducHozeVY3Rkxz?=
 =?utf-8?B?Y21RTS8xWmhXQXpvL3pjZlVvNUFubnEyS1N5eEZHYVZPeFNXQ0JxVTNkSUpJ?=
 =?utf-8?B?Rk9IL09TYmlWR1hlaDk0eHpLcHNFdWU0eDVHamJVZU0vRjBRaE5mMXo2N043?=
 =?utf-8?B?NUJ4ZmdrZXRiUTBkeEFHSkpkdURDbHJiUitxekJUcjRadzRqcVN2UG1qUmNu?=
 =?utf-8?B?ZisrZkZIMC9ab2trZDF1WmdyN0xCZ2tPVisrWXRCeFZQcnVlaEhTMldLYnRv?=
 =?utf-8?B?M0FLTFpDMWY0aFphN1BEWjU0a1ZxZUptTDlpdzFqTEFuQU96cHlvejVjTlF3?=
 =?utf-8?B?cStsYzMyUXVRZHR1R0xCUGZKVklaKzlOeGFSSXU0YnJSb3AwQnMrMFVkL1lY?=
 =?utf-8?B?RnJ1cXgxQkE3NTZiNHI0dlB1QStWUitpc2tZakx6TDZtYS9ybXZjSU5pendD?=
 =?utf-8?B?TEFMSW5DUUFxb2cvMTRBUDBxdUVQSkwxSEV2Q0hSMkNyMzN0TjUxWmhWU2tW?=
 =?utf-8?B?b05wSkVUVk1oNWs0M2VuRkVuS1MrK3pBd3FPK0M5UjR1TFVmQnA4di81eVdz?=
 =?utf-8?B?eXB5VnNXUzQ1cmRtb0xjNks5NnlUSllYN0x4M3I4V2p0cGsvMm1nWC84RHhH?=
 =?utf-8?B?em95bmZ4RVBDYUtuVzVaWXR6QURQUlJsbERhNWh0ZGNLQ0lEZDdoaUZid2dw?=
 =?utf-8?B?azIxUkZtSE1FTUFlVGRpQURVMGZneGZaeUNKVWFocWZ6a2E3NTdITWRFS1Bv?=
 =?utf-8?B?YVFMS2tWVG1oMGRTdUZUZHlPVEMvWXR1cVRidFRCN3I5WTFRT2ErSDFMeDRC?=
 =?utf-8?B?YktqL2VRYkVoWDFCbmZGUEw4V3FQRWc4RzQ0eUc5Wk5JNTVhaWNEclcwSnhG?=
 =?utf-8?B?bjRRbWI1M0tWNjduUTFhTXoxT1VGWndoRVNoTTFHTmhzUGU2MU5vVFpiWkNi?=
 =?utf-8?B?VmlQTDYzMFljMXlqUkErVm0wcllnWEdKNzRXbW5tbkh4aUxnNFRVblNFSHBD?=
 =?utf-8?B?WXprT3lmMlJIc0xyaGJDOGpHZ3d5K296NXFSbmdiSEgvNzNPQzN3cVludUF0?=
 =?utf-8?B?QzUzWDEzSkNUeW1YNHJDZkw0dHYrKzNOei9wbVliMUVrdG5KM2VkWFhHOXVI?=
 =?utf-8?B?Q2VFVnZVa0l5Um5YQ25vRWRueEdjRzhKSUViTTZWdFB2ekNDTUFhQTNXTWpH?=
 =?utf-8?B?Y1FYNE9hcDZOTmppVFh5SlE1MExmeE5MaFZDRlRTUW8xWlRtbHBpZlJWL05B?=
 =?utf-8?B?S3BZK0JCSU1aNEw4TnNjMUNYVXo1VlljUVYvT0NJeDhrU3V4M1o1QitkcG16?=
 =?utf-8?B?b1Q0VWpDS1dMck5rSzZZaGM2OWhTdXJrQk9VT3BQam4wWVFPZWladG80MTZF?=
 =?utf-8?B?bFBnc3J1WlBqMnQwUUlGZjZ5NXFKL2dNM05pSk42RXZkdUpzVHVKdkx3ZzZx?=
 =?utf-8?B?NEJZVHFtNjVwa2kxRHZWaUNubGVmY2lCOFZtMTduT3VBQlZXOUhNK09TSGhP?=
 =?utf-8?B?NFdNRVcvRVk0cm9mQUduZnVVOVorSXBYcFBPUGsvd1A0VFZBYVFvRC9xRzRV?=
 =?utf-8?Q?0YDdQh3E4u0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0dCRTA1K1RYRFpoYXRSYldRbXB5bW5XSHQyTER6Zy9rektzaDBPNUlzQ2xh?=
 =?utf-8?B?TStCMDcrNzltREdCWWV6Sk9QcldNKzNoVDNQajJLQ1ZDMGtpWXpITWtUWnJO?=
 =?utf-8?B?WXZrdWdveEhOaGxIRW1HUDFLUE5MdW1relowYldmUFJRNGF3MUVXZ3gxQVVU?=
 =?utf-8?B?ejBiOVVlU1JuNWlyeFVhVENwRDMyWDFSd2VxY2RUemUzRDZ6Q1dLMjE5amNI?=
 =?utf-8?B?NE9XS2kwcDNvY0Y0cUZDckoxMDBtY2xHVnJnSnZqZmRrMVNPaEJ1bjg2WHJj?=
 =?utf-8?B?NnNIbCswdEtjRHdVWHl4anUrblE2M0xwQU9xUVU3QW1uRXhacjFGZXo5QXRv?=
 =?utf-8?B?d1k3Zlo0UGVkdVh3YUZqZ2cvYmVsaTJxZUYzTUhvZWVMY0NvZHNjU01MWGtU?=
 =?utf-8?B?OGlLY3l3bnFZQkZyOXVQOGdLcGowQnFTNVdybWdMMFJqS0JEeThNMm1KWkZz?=
 =?utf-8?B?ZHk5T2R5SnVmak5yNHNCQnh0Q0ZwQ1gxbGtwUWlXZk1qblE4WTY5NVVKMjZE?=
 =?utf-8?B?aGlibEg3S2Q3T1JsZ0o4NHlBR2hTR3d4ME9PeXFGYXNlaWVaemlORXoxSGZM?=
 =?utf-8?B?RFpQeVc5SEp4YXU1S2E1SE1pak9hNEpqODNqNUpuUlh1U0pINm4wdVFUM2Q0?=
 =?utf-8?B?UTl5WkVYSFcwb2RjVVNIcXRoUkpUMnBTdTVBK0FUdHBxbGFoV3NXSFVLRWF3?=
 =?utf-8?B?RVRUMmpYc2RQajE3VE9FSGFRMTdhNmpBU21QbE56QVU4b1ZmdVpDVlpIWjQx?=
 =?utf-8?B?MmIvcUpZWVAyd0xYdWtjSXVVcDhnT09KcWRZWi8waHpMdjhSc1lhQkZGQXpx?=
 =?utf-8?B?THNBMWwwYnUzZTVUbm1HZkZVYTE4NndtNTl4SUUwMEZjcVRTbG1nSzRoY1Rt?=
 =?utf-8?B?c1dGR0xzdXByOW1NWW94RGxzR0VPWmliVjVBY3h4WlNGNm1mcDVQMVZ1czhy?=
 =?utf-8?B?MjM1alFtTStndTEwalFQU1JTWGFHZG8yOStaZUNwOUdGNjV5RXBJR05DN0hS?=
 =?utf-8?B?eExzM0JHcERFelpQUTh2N0R4KzY3bXBIdGN3WFpiM2lvVlJFQy9MMVNkNXFq?=
 =?utf-8?B?OUY5M0hwMDZpdFJXRk1hbVRDQ1RJMG1lTVlIN2JEMVdpRmlaeG50UXZPeFdQ?=
 =?utf-8?B?d0kyeWJvUDA3ODFleXlpUlJXWlQ1T1p3SXkrT1VLamhtN0lDb01lTS9KSWtU?=
 =?utf-8?B?bVYxVGsvbEp5cDFPdEtQZm5hcnNQT3RJNk5CcDVXYXhVeDJLandoa3BId29R?=
 =?utf-8?B?S2txV0VVNUFRYXUyL1NFemdFdFI3VHprKzE4SkM1NW16Q3h5UWlZS2sxMEpw?=
 =?utf-8?B?d0NVMFRMTUR6cHBCdCt4U3lHSWJ0L2VLaWg4Q0ladTgya21BM3N6WWhTdUN5?=
 =?utf-8?B?RzhXa3g3b3ovTURWV3hxMjNUZ0Yrdkt1dXozZDl0ckE3YmZKaFpXdEYwQ0dJ?=
 =?utf-8?B?SHpFRWJYVDJvamlxYmNJQVVhdlF0UXpPOFdLQVJRZXVoOEd5THR2SjlXTzlT?=
 =?utf-8?B?VVNkdnhRMzU1Zzc3OG1LTXFDM09ndVk3Vjhkc2ZkczAxUWNVUXdXZ2xqcW1U?=
 =?utf-8?B?VjJtT1NYNnMvUHo4VzZJdkVXMlhqRFRHVDZZeWZPa3BvczZ0ajUzcWpLWGxr?=
 =?utf-8?B?d1ZXczd6ZDZZKzVKd1JtbGovbjE0c1l0Sk1jUm9tQzRkb3FXUnZLbzhNOWg3?=
 =?utf-8?B?VjFWMUVsb3p2WHdPZzdocUlMVTNtMUx2bGc4c0tqdXJlRVRId3M5YnNkYnIw?=
 =?utf-8?B?NXU0aXFQODlPeXBxazd3c3YrZU1QTFVKUTlSbFU1V1REUmZXek9UZUpIZjJz?=
 =?utf-8?B?eCs4UEJiMTZiUnZsbnd5cEIxS0JVdVB3M0pmVjQ1TU5QcUlOQUQ1S3d2V3E2?=
 =?utf-8?B?dUE4TTUyU0ZYL05Gbmxzczdubi9odDRWMHg3TEJEQ0xiRnR1SGYwK0pPYTN0?=
 =?utf-8?B?TlRTa1oramZDMlFaR29jMndGNmIxNGtSVUlSWWFQbitoYUx4REc1d0JDaGRn?=
 =?utf-8?B?amhNWWd5RkJ3WGhZTkpyT3BQM01uOFdSRmJ4bSt4dEFrbTk4UytBWlI5TDU2?=
 =?utf-8?B?TVZrMkNkNDhIdGJRL3dpTERHN3lWbXp2blpzcFY4bDV0S0hvNitTd21PNHU5?=
 =?utf-8?Q?8dT7hey9YJrxR+jK9T2UMCKsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d960cd9-d17c-4503-33cc-08ddd3dc176c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 04:54:00.0436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtcgTTNK3Q8LPydOoW2PSLuBhMc0T26DcS/rvs7Emdi89TEwVu/eP3vMnMGHSpKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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



On 8/4/2025 7:47 PM, Asad Kamal wrote:
> Enable temperature metrics caps for smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

A few inits in a couple of patches. With those fixed, series is


Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index c777c0e4ea11..d6b49d958938 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -350,6 +350,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
>  		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
>  		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
>  	}
> +
> +	if (fw_ver >= 0x04560700) {
> +		if (!amdgpu_sriov_vf(smu->adev))
> +			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
> +	}
>  }
>  
>  static void smu_v13_0_6_init_caps(struct smu_context *smu)

