Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD6C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1FB61456
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1FB61456
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2556E7EA;
	Thu,  1 Jul 2021 08:51:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6805B6E7EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 08:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT3V3vvDeXGT3DD1j5hLh0zeT7hXEv9fZ9jrWciHlenFMZEFIJau8UbdIwHgQvxq/jhGVaBOaRdycEPGmPlGseloBcw3uVRLsdYN7tlTS7y2t9quYvTOiGat0m+eZ5Jdz0OiQhipEjnPFqkzU1DtTXI08RLxjqL0VXuFsnq+j9DFaAAPuTjhtZcg3/Cl2MRJF0ehCPkoaMrXgHv6mwJz35YMf+0kO5PrdTaQp0e7LB2VkrS8B0ojHPOjnjXTfLe8DpiAK6eH8iR9MADWPFwVk+EzEHi9aFJA9SF4NaV+KzHuM3wufRE4p1zgGup5dh4h2XGTGqAtnb1d8LSMv351lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2IltaL+X/ILWGij8EEoLwvbEMXbxNgHxu6lEHuFYLI=;
 b=hKkgEAFZoGU8lKsfTMMmtV1mwwC+4OBYgL100PlH+AnnlhnjLJ9VsiOgOdGIolgKx5FmHOukeCeGnenxoDMDAtsNzaR47UvURZqK03R77WW9UwiR3A+jO4bDg18aTIE18CHJITKyBaf4V3u3WVtPyoyVGvFf1ecy25JbThf8+ZDRIYCVVHtvvcustPkluR0lRiRM1mnVtzQgJMecW4epRd3WJJPsMrqVpVtIxHSlnTXYmim0Qo8ZZFQuUSAXnTPspqg9k5+i9RlvXSyN5h18kyKGo/U778jwdnkrvmeKWCe4SAAsrvGnq47hVjv2fZtHTjd58LO70371tI6aRBpaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2IltaL+X/ILWGij8EEoLwvbEMXbxNgHxu6lEHuFYLI=;
 b=EoDS5ZeIHFylapbsqcA98HWeLl2RI8ReNf5RHXPFdIamHEwYidGZGR7/CP8tQ7e3iFAU8VWIiGUREUxiL0NDqIXnoOCNoFTEw8wOrHdikVi/qwJGHxkMewplZC1p01xcVdedNrZ4Irz45vIysOZ9HOaYbCWr7Bmj7E4YqMWYobM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 08:51:16 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 08:51:15 +0000
Subject: Re: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
To: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <db7e299f-902a-847c-f159-77be315aea69@amd.com>
Date: Thu, 1 Jul 2021 14:21:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 08:51:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6706cb-3ca0-42cb-e2f6-08d93c6d62d6
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51216C3E2EB4EBC3D7B1A38797009@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVpz6FZ+fgJKIBWw4uai1QWioZytQe/wJ+ilcQWAz1XZPwRfGN3B/aHi11feTJTEHdXNuHwD5iAmy4IM8donW/D9Oa5MdLEdzIfIzUpPxvkxXxcXZGLlS1wMlxCcGQGLyx+iB4pOhnOTgF5h6uHC1WvBwnAJqvVoEmefMVOXSH8kPUvdcbSnm4Jo7AlKM5vW8nD9cPCViwMjRb0CJijI+tHyP9iUGVP18nZtKRroyg/lhyCi8y/wxxUSdds8WbT7ykv53h3x7Kh2qfsq/NJxSqLkIetKDz9biGYV/NtItuON14v5e9zfz+CbA77tBQ9KLuAecIes+jRera26CuP0WfDWU2dFH6VNKqJUdxfjQ+6PzgeHg9DoUrnUVksns+4TUxxKN0x36MMm5v4wvQMw1uTKN4BLGX7L0+I7XSvBqHLRl7G8Ms5Pa7rKojkd+MgFDcLBCudD028uvOyjj1ghXG/lT5QDIUSqmBRmNVGIMf4wR7N9YWY4Ub7nbcm1yReH/X/LP1F1GOFUVTpllChr23TKF8F/v8dQ261ucCcFHwuOlHgzyUk/DJnYGUVnVQco2MQ7MyOtbLItGAM9kK34tksEHEWj2glr9nGNs6fAp2joRQJW8LVImugdLOagVSK3AxKDzETy7F0lYsL4J97v4WXOqNDGdQTJoSOBAdJJRfO8oqcJy+1hdV7pybREXY/QlHRk2CzB+qQGqebIXZSqp13jxvBGZyqgoXXxSDOKx80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(83380400001)(956004)(2616005)(53546011)(186003)(16526019)(26005)(36756003)(31686004)(6486002)(2906002)(66476007)(5660300002)(8936002)(478600001)(316002)(6666004)(86362001)(31696002)(38100700002)(8676002)(4326008)(66946007)(16576012)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG0veWJUMldBRXhTMWdrUEx0OFRKYVQ0U1QyeGNJOWZjSGVTK2c5NFluU0dm?=
 =?utf-8?B?cktpc0IxR1R2b1ppTDRZL01hT3BheTBybWNyTzRJS0VaTzFxOHBzc0ZPdENF?=
 =?utf-8?B?OHlISkxOL0MzTzFqY2g2R2tLV0VpaGhLSVE3SXE5ZXBSK3p3cEZKY2w4WDBB?=
 =?utf-8?B?VXE1NTFTU2VWdXpGYkZzR0J2QVp0OWYrYnVJemRiNTZGSHJaeTJMcXN6VzIw?=
 =?utf-8?B?d2JjQlByQUVCUk9HMFFFQVdPdXVpU0w2Nk8rVWw3THlJNkQwOTY5OUhlRjNH?=
 =?utf-8?B?Mnd1NUVoN0J1NEQvbzVhVTRTZlJjRlhYYk1tQWdKcWRNUTcyZ2lPOGhGMkQ5?=
 =?utf-8?B?ejl6cjlHTWdWMFdjSnVLZkhZS1A3NU05SW82WTUvWTR3YS9SM3NDdjQ4dDZP?=
 =?utf-8?B?ZS80Rjk0WDZlWCsyZmdJQTVVMi9WR2J6aWc2Y1JJYlJvSjhJQ3BVR3dGTDZF?=
 =?utf-8?B?ZUlyS2h3TS9wTkVHVFEvNjg1OWU2NlJYSkZuUDhrNGlEWk5KL3hXVWlFQnp1?=
 =?utf-8?B?ZkRGR1B5WE1EbHhnUXdIRkFidGpkUS9pQTdxbmxiQkZNRjZQR05UdkR6QW5F?=
 =?utf-8?B?d05sNkNmMXQ5K3ZFQVF4QW9QUTVnVUVJbFlVS1FDUTdieFJxSnkwN2FwT0hm?=
 =?utf-8?B?a3ZqWThJM2MyK293WlJHcTRpQnNGdEp1NmF4WjZYR2JQcFMrME84bzZVV2Vn?=
 =?utf-8?B?UldBT0NueXN2YUlRNEViNVFsZk1QZk42VkZpRVZYRWVCWHlNMnBSSEE4eHpk?=
 =?utf-8?B?cmxFL1FxZDkzMDNtK2QvcnpSZUEwY0NieTdCYVNCeUVwbWRtMndTbWIvOFVQ?=
 =?utf-8?B?THh6aXE4RzJtRnhValB0SXRZRWlYSHlQaERxMHhxOU9zOHBvYUJCUk1HK2Iv?=
 =?utf-8?B?aDVQWjBLTmRXODRYdjFJbzdQU0VkQ3gwZWRDanN4N1U5Y1drYjlqWnlEZkFy?=
 =?utf-8?B?Q2U3NWxLRSs4T1ppMW9hTGhBZVRCcDRnUEJKaU1OclN2aVNVa1FWdXpNTS9s?=
 =?utf-8?B?bTU3UWh3WmNmWWxWNWlkYTBrQmo4UEUxZk53ZTIxeTVrdEtJVnJtQXIwWkZU?=
 =?utf-8?B?K1NUcDRwSjVHYXdpYjZNaTgybWRveVZaS3VoYjNOVEZmSGVDMW0vMm1lYzFy?=
 =?utf-8?B?Z3JRTXJNNGozaXQvZE4yMm5seUwyZk81bnQ4QWQyMEs3T1pZMjhFVnpaZnZw?=
 =?utf-8?B?ZUV5UDRhakhOOWJNclg2U1pBUzBOcGdYcStmRmduNW5aN2xTbzhvdzRSTDFh?=
 =?utf-8?B?bHMzZUdpWldMdFQrTVEvRXdBSlhJUTh1MlVCdnRxNDRMYndOQTZBakg2VkNz?=
 =?utf-8?B?dlgyYmQ5eHRLTWJ4S1FyOERqMTZ4VUFQeDBQNmxwaWhqMUFROGE3R3JUQXpP?=
 =?utf-8?B?ejhRVUVaSS9JM044ZmcxMDVCaHNIelRDczljaTUvM29zMDNVaUJlaEtiMVpY?=
 =?utf-8?B?by8yRlNyMkxDdWpEc1dYZnJyamtWa0lsK3BKbXFQUWc3blNnelZQS3BTT08y?=
 =?utf-8?B?ajBLTWFjcEpRcGVPR2pObFJhY1ZvQ0U0TWVxdFVncldJMTA5ZzJ3NUZaSVBG?=
 =?utf-8?B?NVMrN1IzM1RIQ0NudENRdWhnYjBQM0RuQldIcE9LWHJzaUtRV0Urd01SVkpL?=
 =?utf-8?B?c250YW1VZW9yaVU2Tm1QeEJ6QnBibFp0U0VXcFZGYVZCNWIzSHBZUkFuVWEw?=
 =?utf-8?B?RDQwWjY1MXpTNGZrTlk0SlpuUmJVNzBpWXNBcTZBdDU3dGJZRDVUejJIQ2wz?=
 =?utf-8?Q?Ur3Gf9mrtt0WFXkFeaxvhId9I4Vfl0XCTBoNC/m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6706cb-3ca0-42cb-e2f6-08d93c6d62d6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:51:15.8222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpFZiDEaIPEEy8mMZVBPDIozV37NgExiw3AZtNtK1PDxjhGoEq0soUZU9OOUXNJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
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
Cc: Kevin1.Wang@amd.com, Aaron.Liu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

One minor comment below.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


On 7/1/2021 2:01 PM, Xiaomeng Hou wrote:
> Since there's nothing special in smu implementation for yellow carp,
> it's better to reuse the common smu_v13_0 interfaces and drop the
> specific smu_v13_0_1.c|h files.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   1 +
>   drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  57 ----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  26 ++
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 311 ------------------
>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  39 ++-
>   6 files changed, 59 insertions(+), 377 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
>   delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> index 6119a36b2cba..3fea2430dec0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
> @@ -26,6 +26,7 @@
>   #include "amdgpu_smu.h"
>   
>   #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
> +#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
>   #define SMU13_DRIVER_IF_VERSION_ALDE 0x07
>   
>   /* MP Apertures */
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
> deleted file mode 100644
> index b6c976a4d578..000000000000
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -/*
> - * Copyright 2020 Advanced Micro Devices, Inc.
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
> - */
> -#ifndef __SMU_V13_0_1_H__
> -#define __SMU_V13_0_1_H__
> -
> -#include "amdgpu_smu.h"
> -
> -#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF
> -#define SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3
> -
> -/* MP Apertures */
> -#define MP0_Public			0x03800000
> -#define MP0_SRAM			0x03900000
> -#define MP1_Public			0x03b00000
> -#define MP1_SRAM			0x03c00004
> -
> -/* address block */
> -#define smnMP1_FIRMWARE_FLAGS		0x3010024
> -
> -
> -#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
> -
> -int smu_v13_0_1_check_fw_status(struct smu_context *smu);
> -
> -int smu_v13_0_1_check_fw_version(struct smu_context *smu);
> -
> -int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
> -
> -int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);
> -
> -int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
> -
> -int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
> -
> -int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable);
> -#endif
> -#endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
> index 9b3a8503f5cd..d4c4c495762c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
> @@ -23,7 +23,7 @@
>   # Makefile for the 'smu manager' sub-component of powerplay.
>   # It provides the smu management services for the driver.
>   
> -SMU13_MGR = smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o yellow_carp_ppt.o
> +SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o
>   
>   AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a3dc7194aaf8..cbce982f2717 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -41,6 +41,8 @@
>   
>   #include "asic_reg/thm/thm_13_0_2_offset.h"
>   #include "asic_reg/thm/thm_13_0_2_sh_mask.h"
> +#include "asic_reg/mp/mp_13_0_1_offset.h"
> +#include "asic_reg/mp/mp_13_0_1_sh_mask.h"

If the offsets are same, are these files still needed or can they be not 
included/dropped completely?

Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
