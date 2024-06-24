Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E566C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 14:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7BB10E05D;
	Mon, 24 Jun 2024 14:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sUjJqTNO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ADD10E05D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 14:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2g+JqgYmLJgZMHhyRd5afH4zSksYFOGsrgk8d77CX+W30qxEjiQXJrDqFvn0m3zanM7uGEv7PsPO58s2mXkUces/QD0Z+5aL644+uX020EuA9/oCNTdOxcASBHlsoZd53NZFv8ZR+/ju/MqFyLvUNJcS+Q3n4HlE4camsw29F0NwkStD9mYaIQCpTHRjW9mKmKl0TXZsmEcI+Mg9zZt7d5UU6QFMymDZHxZOEJRuiuemwphgFubKKrp6n9vrJyn+0g0j873noJ7dbzrGQ2kLkDXzkcRYWcVWh1P7qKW4vz6DHj3aXA7/I21AwGFvO2hlXjRPi5pDt3HAyO77Gu3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqGEn7A6DwbWRTibAEmjzKrBoYNp3OTrc0RiU/2w7rc=;
 b=Jzgm7t3t1vSq0eGzCXOtMvvJF/PQf1OP3RfuB/MiD9TaumFxgjSXhhKnfoq3uBzKp/4FMCYxjg3sI9o4I4e8gwNT8L97B3pi4gjBNoTrlYKi9WfLQ9T/DrKU2HMgxwx8/ziULk+D4wVgN1ScMAqL/FerXoQt0cAHqvm0vRYuak3iLs/7wq1mo/h7V1djfSUwNj1ZTfBDsH5LOEDpFYiau4q6K5sMkJI9XKliAM4qyabLhNj40/Lga9eVnS18N2GE1OugQLl1o8ldK67I6s061qMF4Axhx3o5p0KvXK6gM7L6wkdhgQpFqJAnM3DguYylu+3HsCERqAnU/tAk8S0nUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqGEn7A6DwbWRTibAEmjzKrBoYNp3OTrc0RiU/2w7rc=;
 b=sUjJqTNOkBxnvB6Z/Vv8lqolnWf8bPGo9r8CbLj++qChguauM958XhRnKjGPHZr8pMQO04Y7sG+IF4tpcd5dYp3bDM90IJdfAShpl009/5UzahIvzjaYVzQ3KF/dqn4EdD6Wqn2vzDZ+Aix09Bm7+9Xps0JpLtHZoAKKs253TRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:07:33 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:07:33 +0000
Message-ID: <8509a66f-3a85-49b6-aaf1-e4ea20acee45@amd.com>
Date: Mon, 24 Jun 2024 10:07:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix Makefile copyright notices
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com
References: <20240624135809.3089648-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240624135809.3089648-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::10) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5089b825-de61-45a3-04d9-08dc9456fe3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bndLSkl5b1ZiKy9DczVtNW5lUTRVcmpvNFhPeE5XOEU3d3B1L1dEeFlNR3la?=
 =?utf-8?B?QXprU0lidXZtNUh2RXdFcTZqN1hXMHI2TGtBNGlua1FiZUM4VkRzMWU2QkQ3?=
 =?utf-8?B?YkN3NDcyaXM1aEo1UVM3TkE1VUQ0UHRxZ28rYSt2NU5LaWE0NmJjTzZBd1Yx?=
 =?utf-8?B?RFZIZXAwTVY0dy9XODE0RnBRRHVDdE1aRFZXNlYveWRzbHl4V3k2dC9QZlNp?=
 =?utf-8?B?OUh1S3pYSFRFUXdicG43Ullmb21RZFNsREZkQi9nZ29RN1NQMU85VFQ1N3Uy?=
 =?utf-8?B?M2FxS0lzeVNtc0dQenQrY0w2V2I1RUlLaFpKME5zNXZEc3lRR1Z4NVBiWWQr?=
 =?utf-8?B?NFBBSkJPWXkyMmRHcW4rQWxldlVXMytRUGh0NFgxbVpXb045T3ZTMjFDNVdr?=
 =?utf-8?B?SzhlL0xGRksrRzhyME40aC9Ta0hLUVk2WmNPdFVMS0drWGhNVk9iUnZiaEJC?=
 =?utf-8?B?V0c1dDJCS3FLRVVnckc2RUVnREhvdnM4cUFrME90TkVCUVZ0Vmk0TmlXZkZ3?=
 =?utf-8?B?b0xscm5OZmJldHV0eTRkZ1BIT3Vnbi9OWGEyY1cwRGUvWmFUdGY4Wi9HMmdU?=
 =?utf-8?B?dXFVT2pJd1VRWktNWUF1ME1lZlZvUFJmd044L25GaVMrR0YvM1B2bEJhaEhX?=
 =?utf-8?B?Q1hmNlI0TXkwQ010Rng1RXQ1ZWl4MHVLVTJXV0pTTk9kbTlWQTJ2T3Q2TFpi?=
 =?utf-8?B?RWFtZEQ4Q3ZwSWgwcEd0ZElEUE9yKzNKTzJsYnAxTXhEa1RvWmZWU3BqZFhr?=
 =?utf-8?B?NHZ2c0dwcGI0S1BnWDZiQkNJWmI5aDFtOWwvNlNwWXYycEgxWXpjUzRCY3N3?=
 =?utf-8?B?bnc3VXNVVEdjNDE4YXV0YktTOXRQTFJacjQ3TXYxa3F6QURXRTBUaHBadmxy?=
 =?utf-8?B?VTBzRUp0QmQ5Nk5FTXVROGdpMTROUjJlSW8xMFVxcWMreVQzbWRZWmtkK3hO?=
 =?utf-8?B?K2R5TTRhN3BkaTJmZHU0Vy9kWThSbnJmeU9sZS93M3o1Myt5RlFTem0zUXA4?=
 =?utf-8?B?MVEzSjY3QUxYYStxejV6R2paTGtieW85Mm91eDRyZU1FN2VFQnE3bTcvbGRi?=
 =?utf-8?B?VHFwSHdITWRoOW5Jc3BjbDJnQzA1dklPU0twSkpIdzlyNEpQSTcweWlYUUpC?=
 =?utf-8?B?QWxjbDF5ZTE2VXF1OGdQcFY4OFJUSjJzM0o4akxHUGpTSkpZVEVYbnZkcXlq?=
 =?utf-8?B?bFJJZS9XNUY0WklVRC9MdFNheW9GZ0F3bnNGNDMra0dNOThkblhPbG9zK1pV?=
 =?utf-8?B?MFVSM0N2TUg4WWwrZU9MLzd2ZGkwTDh5a1hDcGwrRndteXVYY0dWL2pZVGhF?=
 =?utf-8?B?N0psWVcyS0J0YWxueWRyQVh2dXVlSDhjNTFGQjV1Sk1vekphbGxubU1SMDdq?=
 =?utf-8?B?QzM1eStaMFprdWViWUR3aWpGMTQ1YXVIT1dtbDZsZDlsKzJhUm4yRmd1cCt2?=
 =?utf-8?B?bUttdnh0TjNENVg1cDlsMzYxZTUxT2h6QmorbUJxTmV6VXl4U0VSNzdjQjN3?=
 =?utf-8?B?V0JKVHphQVY5bTg3OWlpY01ta25vU2VUR1Z1SDUxbGNMdmM3MXcybHdjMFda?=
 =?utf-8?B?YlpyYXhnendsMjkxZUorbzVtcGorSjZMbld5NVp4cUdDdk12RTYrZ3JibGw1?=
 =?utf-8?B?Sm9TNVQ5ZWhYRHZJa0MvTVVTZmpWbmk0QlUxb1NGcnhyTVBZY1dqQ2pxeG9H?=
 =?utf-8?B?eTIvcGp1WmNvNVlaUVIxVHQ1NEZzaXZRa2VHZTlxQk8rbTJ0RG5WT09SUHZ1?=
 =?utf-8?Q?ay/08YE00zqg8w2HlT0zaFnyWWSh6r0tT4wSKtK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0JONzd5VUYzSGxHMDhJVEg4WG9SbVlPb2EwTEprWi9IODhqeGZwbTVqMzBP?=
 =?utf-8?B?T2dtcHJFREtWdm11N29iYmQvNkxiZm1md3lKVFhSOGNrM2huRkpqZVNSMDhU?=
 =?utf-8?B?bHZud1NpSFlSQkwwZjlaS3NzcEdRTEVZVmJVY2xGd1VidXFobnh3WTVTTURQ?=
 =?utf-8?B?eFJ1YncwSlFPeG1sZU5RV3NUb2JaZVlFbUwrVmtucGxFVDBFaDFpZmljd0c5?=
 =?utf-8?B?YnFqQ0tMZnYvRHA1b0lISXZLWVJIbng5ZkFXTWdYaHRnaGF1YkF3SEl6M1JI?=
 =?utf-8?B?VGNhbG1LWEhQZGxHblViRWw3am1Pd0Y1aC9MNm5kUENBM25PRG5qT1BJck0x?=
 =?utf-8?B?OG9GMHgyendWYzdRa282WVF1UzBtd1c1SG45NFRZV0liMG1MSmZsYlpYKzBy?=
 =?utf-8?B?bEw3MUUwZCtEemtUWnl2NzJXbVhGbUt5dnoxN2FHY1VORGxUUHVWY1JRbUVE?=
 =?utf-8?B?N1hnb09CeEZjSmpmd1lLSEUvZER5ejNsOEcwMDRSL2s1Mks0T0RvTElHa2tS?=
 =?utf-8?B?MkFmRmpqMThtYXBvQ0F3a3R4cGs5SWRpTzFDWU9jVG13Kys5WnFLWTZISndJ?=
 =?utf-8?B?aTRlOFhHb3cwQ2wxV2JtdVUvMG9BL2p1TWNYQkFsV1pYQjE2WW1BUGRlUnQy?=
 =?utf-8?B?VG51c21KMmc4N1lJanFrM0U3TURkTDhLTHl4U1p1K0draFJEZnMybVpMNUVV?=
 =?utf-8?B?MjlSKzhLdmwyVXZCa0FMTzFsaEg4dEd6aEVlU1BHUnhhV0xIREtraHp5T0cw?=
 =?utf-8?B?ejkrMXJXdEg5b0EzQXZqYjVSdVpVNDExUmZWUFVSUDFIUDR4d2tIcDdPMkJo?=
 =?utf-8?B?L1hCYnI0bHgrU1Y4RXoxQ2lDdXFtY25HUEEzQXFQbFdFQ2VGdUQ2N29WNjR1?=
 =?utf-8?B?d3JlaXdaQ1krUTJJNk4rR3RiMi83U2tHUzZyTWRDZkRnU1F1SFo0eTZ2T1F5?=
 =?utf-8?B?RWl3QUU2ZkVoeXFNYWswWGVYUFZ0OGd6aU80Z2FsQUhLbWpNdGk4YTk4bDhN?=
 =?utf-8?B?SGRxb3ZaQkc2RU1RVlNjVmhuejI1YitQYmtURlZCMFFiejNNcVlDV3orOWU2?=
 =?utf-8?B?cGxkdW92UG1YL05TNjQ5RlhEVmJxeUVHL2FicHRPeG1qZks0anpPZ25weE9D?=
 =?utf-8?B?VkZWVEIxSGhTZUdFTkpnMUpLeTM3Vjd2TmZZdDNieW1KcDN3OEpZcndtR3M4?=
 =?utf-8?B?SVJUaWVqa1FsSDVxaGJEYlBrcmVIMis4bDJqR0JwVitsUVJMSytBNUFNTUkz?=
 =?utf-8?B?dU8rWDdsdHdEZlY2VTh5MVB3UUs4QUw3anlVWmJrL1dVR2VOdHRtVmhlQ0s0?=
 =?utf-8?B?dGUyYmRjSkFRMUtHMFJVdmdQRXZoSkNZcHFGZlA0MnE3TGdoc0owZHpvNUZw?=
 =?utf-8?B?TTdsQzRkR3ExVkVkTlJwUzRHT0tXSmR1MDlWTE12cDdoUm5UNXFpWThnN1p4?=
 =?utf-8?B?UW1EZVh0ZzZnR09SblZaVzV3bmFoeGUwRUdVYnVKSjZlc0NobmdnTmQ5YXhp?=
 =?utf-8?B?RitrQ3B6MFlrV3B4dDUyNGxuMk9DYnNGTFdXQTlWRnc1MFZ6NXpiWnZOWXhq?=
 =?utf-8?B?UDB4cnd6Z0dZNU03aTZad2Vqb0d6MFUzZSsycHJIS25qV0xwU2ZsZ0ZMdTZO?=
 =?utf-8?B?VnJudTk3czROTUQ0TS9rRTlNREgvM2lLcVprK0hKYlZ6bU95Q1N0NmVkZzMw?=
 =?utf-8?B?ZnY1SHRxcUlWNGF0cW1SOVJRYXFFVi9qUW1TUDU4cUl0b0hnSS9YS1lldmE5?=
 =?utf-8?B?a3orT1FDclJRbTNJV3Z4ZXNXSERPZTRtcHlXaXlOOUQ1OXRORk5ieUpvU0Rk?=
 =?utf-8?B?NXV2aVZOZjFMQk9mSEYyZEZCd2NGWDA3djE0aTVSUVV0NXhISGdHV1dkaFkx?=
 =?utf-8?B?cGxKcnJkbGh4NGQzQjBxTnR3NlpZNEVLRnJMR3VnMkk5UTh0aFQzOSt3RlhR?=
 =?utf-8?B?KzU1Qi9UbzNlcFF4cmFjNlNNVWxMRiswdUo2ZVdFRnd4alFWaWFJdXRvMFRP?=
 =?utf-8?B?R1hzSklrYytodG5MQmdZMzV4OFp6Tmk4K3Z4ZXF3Y3JQemYyQmswU0JYN2cr?=
 =?utf-8?B?SS9QVmk1eVEySmFocmh1SVNydEJEYlN3S2dDcWhwUmdzNWVzRWZUZzVFVFgx?=
 =?utf-8?Q?d15w8DFheLbL8kPt3q/c8vGgH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5089b825-de61-45a3-04d9-08dc9456fe3c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:07:33.5049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO6+ftzQckmiN8eNqE3n/odEcxxJ6BjdSwm85el4ThG9m/bF0y5+mgl6gjwbjWgtI58tgiknQP9fY9e4VyWjiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

On 6/24/24 09:58, Alex Deucher wrote:
> Leftover copy pasta from original code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry.Wentland@amd.com

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn301/Makefile | 11 ++---------
>   drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 10 ++--------
>   drivers/gpu/drm/amd/display/dc/dcn314/Makefile | 11 ++---------
>   drivers/gpu/drm/amd/display/dc/dcn401/Makefile |  5 ++---
>   4 files changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> index fadf5e872e38..dc37dbf870df 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
> @@ -1,12 +1,5 @@
> -#
> -# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
> -#
> -#  All rights reserved.  This notice is intended as a precaution against
> -#  inadvertent publication and does not imply publication or any waiver
> -#  of confidentiality.  The year included in the foregoing notice is the
> -#  year of creation of the work.
> -#
> -#  Authors: AMD
> +# SPDX-License-Identifier: MIT
> +# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
>   #
>   # Makefile for dcn30.
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> index 62c8ab0e45aa..d9816313c3b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
> @@ -1,12 +1,6 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
>   #
> -# Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
> -#
> -#  All rights reserved.  This notice is intended as a precaution against
> -#  inadvertent publication and does not imply publication or any waiver
> -#  of confidentiality.  The year included in the foregoing notice is the
> -#  year of creation of the work.
> -#
> -#  Authors: AMD
>   #
>   # Makefile for dcn31.
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
> index cac756c75b7f..15fdcf7c6466 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
> @@ -1,12 +1,5 @@
> -#
> -# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
> -#
> -#  All rights reserved.  This notice is intended as a precaution against
> -#  inadvertent publication and does not imply publication or any waiver
> -#  of confidentiality.  The year included in the foregoing notice is the
> -#  year of creation of the work.
> -#
> -#  Authors: AMD
> +# SPDX-License-Identifier: MIT
> +# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
>   #
>   # Makefile for dcn314.
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
> index 2989e706bccf..ded1f3140beb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
> @@ -1,6 +1,5 @@
> -#
> -# Copyright © 2023 Advanced Micro Devices, Inc. All rights reserved.
> -#
> +# SPDX-License-Identifier: MIT
> +# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
>   
>   DCN401 += dcn401_dio_link_encoder.o
>   DCN401 += dcn401_dio_stream_encoder.o
-- 
Hamza

