Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C40BCCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 23:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0209010E0D9;
	Fri, 17 Oct 2025 23:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t++NzzAZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E3A10E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 23:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGE78mvXiLOA53h0WHX9cwvZ8bRcLaEEdD3c+XFz2TtLpu7FEvs3N+7SUMiHZzsPQk8ZA3EXRfwbtNJYNLi0EpTZY55bhYS1cn7FgRNWc/7KiK9Gyj/B0kVFaU24UTO4BuVaOaV3rI+FBaB260S5zJuBQaB1kDy+X2r6jB1IchO0NEJTH4l3Ax5Gyzlh+ui9pyci9p7YNEQot/yR8wuU4aRyx7EprPKG576TWz/DAM19+S7Xh16k/olxLBGMyy+TyiYI/1Nm4YKeBtwUll1o6YL0L2Uoq69FL9g1a/Cs/qsoBt8dwngQb5rwDf7Uk4UbW7N3LskfQ4jeQMBgpgziHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4b2/P0MM+UWuoeh6jg63i+jrrBQcOEMD/yZl0kvXWM=;
 b=LiDdCwhITTGxdJma51sRgsNvblbUTbuHODN6sS3BpJjGZdE244U/ZAjvnV0tOLnRd1yu/6lQLC2GgrYPq1bKNKGQnRP6C3bjv6MD/l4QBjALsNe1AONFNCQgg05v5CbDSVSSI+WxdTScQsVmMhZlHprBEJRtj2auSCghWy9GPFYvbZvzdccjoETCZrfSVtLQmQNsa/4ukDa/gWRF/Gw9Z4TQ4yZcRRC/DVfh8DwQ+Jpl0S/fjAlILn9PbZhKWEPiDMwDjw9YIHtgZ9XskZPH0F+Qex+RVbwTxRgYW3KtLq8jbuP/PgkdKt8kKvHqtA+ZRunFZlmX2j1yQAfaOrsHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4b2/P0MM+UWuoeh6jg63i+jrrBQcOEMD/yZl0kvXWM=;
 b=t++NzzAZXd3R5w4q2tXQyudsGHPGpJlzVNeDTTWRcTB8POFj3dRF4qkH/JaWXst/Cy6pCo3J121RLzNRcd5JFmqFI6i/pOfR8AT+Zp0hIpSHUPD6LK5SXCIzccxPrVsSN2O9bQAuImxxhY2q7CI+x1yi6/0eGqsESutajDGXbxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 23:32:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 23:32:22 +0000
Message-ID: <e3069b92-cf6d-4d31-9030-813e5ae8b8f3@amd.com>
Date: Fri, 17 Oct 2025 19:32:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 17/18] amdkfd: process debug trap ioctl only on a
 primary context
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-18-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251017084222.54721-18-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7553fda8-0458-4fc7-392a-08de0dd56c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0FaTENlZU1VaC9Gb0hMc2VWZ0lSR1lDVkxoSUN4N0tzVmhwS0VCL0ZqMmk0?=
 =?utf-8?B?UkZ6aDhiWDRvZWM1QVBnYjlpNkZEMGVJYUJhRlk0Y3RTYmpVdXY0NVJKdU5D?=
 =?utf-8?B?TVQ0Q1lzdTBVU0MrYjI2TTliNHRJWEM0aS8zRTBzeStETVRnUllhY0o3MXM2?=
 =?utf-8?B?S0hUYUR1UHJUMkVoaHBUKzU4aG5wUVJvSlltNUxSa1B4VUhCOG1PWVFMejN1?=
 =?utf-8?B?YlAxb1hiTXF4NXM4bEVKWXFRWUIwb2xRQ2taY1diSnRpNDg0UmNGSFRWbHhp?=
 =?utf-8?B?SUZQMnp1QXpaVGZjSVpOb2JIQ0VIMko3TWhFNFpTTmdDNkNDWWFldzFwK3VE?=
 =?utf-8?B?clAyY1lWSXRBdlE2NjhzNk8rZkQzeFdFUHlqUmZvNVZPN1lTWjlSRHIyWHd3?=
 =?utf-8?B?ak5CSkkwcm0xNnYzUTBEWWNWS1orZytQckg3TzA5bFJhUTg2MGlQRVBRUEJn?=
 =?utf-8?B?c1gxRFBXY0Z6VzBmZitOQUgwUHFTN29DcTNWaWJNMUF6Z0FYbUpzL2l2Z1Vo?=
 =?utf-8?B?N2V6NVpGamkxQUdXdzVjN1hISWNwMTZyRlo0eXdKRGxoanEvckI1VTZaODVJ?=
 =?utf-8?B?Z1hIMmdpUnltQ1BveTlYSHh4Q3A4WVp1clNFSEg1RHd1TmVWcVp0d0h5RHZj?=
 =?utf-8?B?YmNDZzI5a3JrQjg4NGtYZzlNUmRzKzRxbjFqS1lzTnJSSElTK3dPL2lBK25P?=
 =?utf-8?B?YlhSUXFtbVg1N0Jnb2lQT2ZQeTFPOTJBZ2hBUnRSOHJFbzQ2WFpvaVFwdUcx?=
 =?utf-8?B?OENtVnNrbmU4alpGdFlCcTNzRlZXWUJkWWxKM0xib0ZIajBQb3pMYm5CclFI?=
 =?utf-8?B?Nm1La0JzdkdyOVJwNjdGaHphTjFOL3RPbEF2OTVZZVdId0VuRGxBYWhtNUhr?=
 =?utf-8?B?RTU5cEtNUUwvdTNLUTg1aEJvd2ZBNXAvL2psaWkrRlBldUx0ZjRYbUJENnJU?=
 =?utf-8?B?VnhJNEVXcEREQ1FpdysxRGg0S0RqSmJ0T09ZdHJCUmRhZnk0UFpLTGRjTUZR?=
 =?utf-8?B?MzV2dmJXWGp0SzgweGprang5d21UZHYrZXRsMWh6V0tXeUl3SjN0cnZxYkFK?=
 =?utf-8?B?M3hLQ08yMVlMMWVOZGNIcW85K09Tbk16MmkvdjNRdW9oUzltYzhHU3U2Nkcr?=
 =?utf-8?B?clYzWVdtUHNrT3pLcm9HOXJmQkgvYWt3NU5MVVM0L3hzcWR6UGhkeGlsOXA1?=
 =?utf-8?B?eXJDNEhiclVmdElPMExFWXFRTlVPWDZqQW5yZDFLVWt4bmlyMG9CamJnS0Jv?=
 =?utf-8?B?K1hvVnRUYStYeTQvQ1E5TU50dUFrR2lVNThtZTFiTndIWGZkVmY5VDcyQUNm?=
 =?utf-8?B?YndmcXFjMzJwQ3dhT1BiMC9BT2tpUmxxdldsVmJwQ3NHNzIydUtreXZ0WTgz?=
 =?utf-8?B?SDZJck9kb05uRmhZM1FDbHVXODg5TXZqM0N2SEoveEpidDAraU5id2VFOEpV?=
 =?utf-8?B?WndzK1BRbnhaVFdBeElSbU8zMVh4eDIvNDZWVGkyc2Z5bE0wQmE0TDE5QTl6?=
 =?utf-8?B?L2gxYjhYdnBqR24yVFhoM1NDMW1xNk50U2M5eHRqa0dVMzk1MEo3YnVScjdK?=
 =?utf-8?B?UGtNM2hvbk9WZmJYTnBDUmdaZm9EaVgzYzdmOHR5dXAyczViU2lXVU1yNzFJ?=
 =?utf-8?B?cHZwcjRNRkxIZEYrOW5TNmQ2WWdLYStNVG05VmJuV2YranRrcUpaL290NmVS?=
 =?utf-8?B?ZktmNktmVU5oUWR3WTI3YjFSNVpOMkJkSTdQdG4vcFBnN2ppaktFMVdhQmlG?=
 =?utf-8?B?TDJTMGNzbTFiVEVxbVBWOStZK0JKVTYrcWxFOUUyL3NLVEhmdEdFamMvNWRZ?=
 =?utf-8?B?cjYvQW84TERmYUExMHRMVFUwTXBWVlRJS0N0SndHdHVrU3VlUC9LeVR2ZHFZ?=
 =?utf-8?B?TmNhNUV1b0xqZXVmRkRYZHdCaUhLV3didDJia1dXWnhlNW5aWmxXTUUyYW16?=
 =?utf-8?Q?lOJ7xoikKb8055VSm9dplVxDUC/aLd5Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5uN0RWQzRVMVErcWo4Tk9vWkEvT3BzenpYemx0NFY5eFZ2OFlNUUt3am5I?=
 =?utf-8?B?N2k5TnY1TDZPQWIyM0ZMR3RwWU5lZXhBNGFWak5tMElMc1hNZEs4UGNXVTNR?=
 =?utf-8?B?bE9qdm14TGtSTTBVMkF3ZmtnMkNlYmJtd3EyZk9ITUFTUTFBN29RTGo4b1Z2?=
 =?utf-8?B?bjIrN3VkbmdVVHV3elR1S3VVOU1lM2krUnRKbGhJVDFtd1JuSVE3QjFMYlZy?=
 =?utf-8?B?d0l2d1pjaUZEUW5BY0ZCdXJXQWprdjlKbDNKa2VkdzJ5U0lqL1o5QzZzT0lZ?=
 =?utf-8?B?MVZvZUQxdFVjdGNxRERnbXpxR090S004ZUdXcldIZlRUaWJGd3lsNlk1cC9y?=
 =?utf-8?B?aDRTRTBicWl4cm5Mc2lvQ3pobFhGV1IwR1JGd2RMMjdQOHA4Y3VIWnk2Z2JR?=
 =?utf-8?B?Mi9ieEhWOTlPbHJQcXprL1BwWTZsbGpPY0pyd3FTbHpMZ0tFeS9MalhGRm44?=
 =?utf-8?B?TXQ0WXJyME5xTVl4T29CQU1pNnRVZStDcW0rbVdlTFF3MmdOS2doTDhlRGY2?=
 =?utf-8?B?MVNXdzUzS1BQLzYrQXQxV092cHZHcHlpSjZOQVNaaE42Tko0MVVwQ2JKSWJp?=
 =?utf-8?B?cjg2WVZSbVIrTkJnQnRLRkM2RTBPOWYxWXozRCtjWFFkaTR3OXhNcy8rcnhr?=
 =?utf-8?B?a2Rlc0JrQWU5dXdNNnplNGJIa1dXdzRjOVhva1Z1aUxsdVYra0twMFlCUzQ5?=
 =?utf-8?B?ZUdIMkZRZW83L2Rhb2QycmhCVHJZMGtJOW53NjlYcElYMTJpSnlTZFd4WnQz?=
 =?utf-8?B?cXlRbkRRR1V4TDFoUXc3M3VlVXNNUURSUGR4QlN6WGRtQitrUWtEdHpOdTdZ?=
 =?utf-8?B?cUZ5UW9MVVE2WVV0V0xpdjY0TmJtSDNYWVFkZ1ZnbmpkZkxuWEdvb2dtZXJ3?=
 =?utf-8?B?Zm1veTl2QlI2aUd2b1BIaWhaWk1iUmdsVWp5QkZPQlBVWHJlOFE5bityeU1p?=
 =?utf-8?B?aDZjcXBSYzhMbVVoQlc5dFhxZG0yWWlzc3RrN3pRbzl2bjlVdkFienJ5UCtD?=
 =?utf-8?B?NVNPTGUxZkRucGxGbzd0Y3lQNW0wVlJTT0dkamZ6VHA2QkY2SXo2MUlCWnpz?=
 =?utf-8?B?V1hsL0drUUpFSkF6WmU4Vkdhclh4bW9SaW1BK285VzdaMGlidnJvOGRYYUV5?=
 =?utf-8?B?WXFEQVFFU2NWNGVJRStuNDl1L1lvZ3ZsQXdxREZqdXhOMTBMeW5hY0RacU15?=
 =?utf-8?B?bHlWTmVKWStYTzJpWTlTR2FPb2ZTTnBFRXpmbUh5bUEveUdiMktKa3FRcEdL?=
 =?utf-8?B?SmdTKzJtRm1qcnpFcm96Zm5DM1BsSHQxZlg1UTQxNFk1OW1pQUl2UmJwOXpq?=
 =?utf-8?B?RXhidjBFR3FwUk56U3lzWU83VVd6K3p1SkRabTErYjh4cGlxZE5uZUo4c2Zp?=
 =?utf-8?B?Q1BrbDdrY0dtS2ZRbUlmMVE1N3h1Nm1rTWVBeXVxcHQrNGVWbXFyMjB0bWhh?=
 =?utf-8?B?NFduMzJVcXNsRmgvUHlsWnRwTXBITU05blhLeENiTEJvSUdVelNSTjN2TXhK?=
 =?utf-8?B?L3NUR2hjSlVWdkprMThhUlEwcUlRWi9RaWVWY0FhcGpsenp6cWVqaWljcktS?=
 =?utf-8?B?Z3RicGsyNTkrb29OYlRhWEpNckE0UWwrcEFRZThIYkhzbFVUbEh0U0dSWHRm?=
 =?utf-8?B?ais2L3gzSy81RnUzQXJOcmdJQ3EwNzI0WFBwRVdGSEtBSHluUmlxMU5BSHg0?=
 =?utf-8?B?ZStrZWZuZ3JiL2lpcFVoVUZ4N2UrYUhUYkdrQWR6Sk1XMWhjdWIxaUhiaVN6?=
 =?utf-8?B?TU9MaHVGOUp4UmMxNHBacHBkUW12U3h5bjNrR2JtbkFaLzlqV0QvTHBLaTZG?=
 =?utf-8?B?Mkp4ZVNOS2JqQ1VGelI0eUFwNDI0SnJOVDc1T2x5RXl3UEdvY1JDdTl6aUl3?=
 =?utf-8?B?SzFmY3NMN0YyRVI0S1dGcjRtUGlnandQWDVYNzhYcm5qa1FFUGNmWjdOUHgv?=
 =?utf-8?B?ZnBMTi9ma1JWUitzMkIwTExYU3RmSDZFUXZFenAzTVlGSXFnaWRhb2NQMElB?=
 =?utf-8?B?RFNSYUlteTVhaUVPWnpTV3FGVmFjUTZLeDF4RXlUL2tPTmFmZ3FOWUNPQzU5?=
 =?utf-8?B?NGNpOUtRN2tqclFMbmt1Z3VveG01ZE5jVC9Qb0JZZ2pLNTF0YW9LMmpnVTVJ?=
 =?utf-8?Q?gboqAZ5jBsFcydOk5m+gYd1qg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553fda8-0458-4fc7-392a-08de0dd56c2a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 23:32:22.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mMXUab6jC+E5bDvD3aTJi45hzECqx7GJTelbpcwmmw3nL3kcgIkxleFaEQS78pfEUQN+tBzKlpTzYKM9PlYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418
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

On 2025-10-17 04:42, Zhu Lingshan wrote:
> Set_debug_trap ioctl should work on a specific kfd_process
> even when multiple contexts feature is implemented.
>
> For consistency, this commit allow set_debug_trap ioctl only work on the
> primary kfd process of a user space program
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 73de2de8be0f..7c02e8473622 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2964,6 +2964,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		target = kfd_lookup_process_by_pid(pid);
>   	}
>   
> +	if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
> +		pr_debug("Set debug trap ioctl not supported on non-primary kfd process\n");
> +		r = -EOPNOTSUPP;
> +		goto out;
> +	}
> +

This check should be after the IS_ERR_OR_NULL(target) check below. 
Otherwise you dereference a bogus pointer.

We should also check that the process calling the ioctl is a primary 
context (p->context_id == KFD_CONTEXT_ID_PRIMARY). You don't want to 
allow a guest process (using a secondary context) to debug another 
process running on the host, using any ptrace the privileges of the QEMU 
host process.

Regards,
   Felix


>   	if (IS_ERR_OR_NULL(target)) {
>   		pr_debug("Cannot find process PID %i to debug\n", args->pid);
>   		r = target ? PTR_ERR(target) : -ESRCH;
