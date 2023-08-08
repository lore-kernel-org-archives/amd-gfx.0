Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363F0C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 17:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE4F10E3CE;
	Tue,  8 Aug 2023 17:37:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAE110E3E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 17:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg+rKQnUUOTmEyV4oy007/5B2ciOHjy87Xodzt1sHInRnLFlRS7sjoubernJUpHdjhsnqGCU1OODXWAFYM9jQc/7+Ooob68PzBt2JmPEAJs886lJEibX33ZTuwldx/F1S40Q5/bhqDfZ5GooRH1DtffO41kVHWyqJWsaNn0qIWomb3DUSzjDOCZaLhBouJLxipiJQ1EG9vCTzEDzigMaUHaW6H0rizFndFRXQ81irYUm92RzaOH377Jpk7o9zY/72+qtsUenwuO8Kqh5FX5/wacwOHlNQ8/Mi15wF0kPq5GRinZ6fuJbO24n8jdgxkcB+gz/1P8oXOrWCUBDcp86xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igFgYmlJOH5aa587e/T8h9C+TSzwQjRgEi+OSdHob38=;
 b=NJZEjpUMfcGxBlSqRJWWGh/Q+qTno8GbBY9nE1NlzSKI1YdCMtaVohisSox2A7tMQe351IiQh//ovpWkCbNZaWlS8/egixxWOqVPeYj4vSgb2B2vEPKGq2THegG9seAel3nXdGYsX1xbZJY552fT+L/EKHtOlS0dfZCDkoh4Vspz9ocpzvQ+lnFeyfrLnD45Ip+9q4LkGG0Si8qf4V43E/bdm9PgNeJntW0L9j2EUdw6ApaYDNAinqi51MFN7SoU9JJk5a2lrAzvux7LPPixpHh47jUz5lOTSL1ApIUXKRlkJWQy4ci+brkKepYftGkMssH4TXz9yhhshSh4bpoGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igFgYmlJOH5aa587e/T8h9C+TSzwQjRgEi+OSdHob38=;
 b=eanwuBwuSHQnyMkBTCB5HRZx5Z2UVG+N2ndoqfb3B17gz68fzPZ3jg0HipjlzRO6hgjw+5ltBku9+J7pv9qh0tMQhbSotvH5eaFrQA57ZX5YeXJaZP1y5co1Aik1JwVnzimmFOVa7+Gq5rhaXi7xtaduSQHahyAPiPl4TzYCCgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Tue, 8 Aug 2023 17:37:06 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:37:06 +0000
Message-ID: <f46e79bb-a858-36b1-f69e-94f772ae5e75@amd.com>
Date: Tue, 8 Aug 2023 13:37:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/7] drm/amdgpu/vcn: Add MMSCH v4_0_3 support for sriov
To: Samir Dhume <samir.dhume@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230808162622.74937-1-samir.dhume@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20230808162622.74937-1-samir.dhume@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0472.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::15) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b395b4-7eb4-4a10-d16f-08db983615ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jqyd6TyfW3wxOC65JXFVG4f9tqRAFRbxJhuTMJsk58bChmkbJdffQX7XqQfPvE4/jonkUkHDTgxdQsLtXSENRhnr1eKlvkCYHvGUs0pO7lLAqqA+xExh3Y2m9EfFQFDpUMpbSYH3VRBwCKDQ+vaVxEc0MrWHJUgs+kFceJK7MPfEKTNLJ/jvHaARE6DU+aWAQKlka7KxxA2jkR/BhK2OfZeX99rZzTp3nQIGZWTFllCAIF5j7azKnHb2aAnMRMMJKW+ljWX/WTeEjIQ267DQvgsVAUFALE+G6BK9BqCAqSyMW+AZKy6NjUTndsWGkqm3vHZeXHVky+e/Oggf21723of8aTxosArSuiforccstwNiEdDMDGTd9Uv5NcpmoW3w6Uvpi1ufnyUeDfJFgZebIsEWjI9ePbz8hO2pvHJ98eKgJa6OIhmOAkNxv5PR9gfLaMz2J2GFb++CfDdBbWCiASZlF+ihJNZz367CU3V+YbiSVMlAfT4mNGUinYGg6z0d6h1g/GB/XwsLUkZM+DSg4FwZNQsclw0deWV7wAKft+0oba1dPWiwO4uHLfBlx9r/rMXG3Q5tscfCbOeLIPci6+/5242Uqv+aNTuSIPntY6/MG8t7zf1OlO/fQFccUnkd+vL8dIgW7GVNXtYV8yqgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(39860400002)(396003)(136003)(1800799003)(186006)(451199021)(2616005)(53546011)(36756003)(6506007)(26005)(6486002)(6512007)(6666004)(31686004)(478600001)(38100700002)(66476007)(66946007)(66556008)(4326008)(316002)(66899021)(41300700001)(8676002)(5660300002)(44832011)(8936002)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndnNVVwWm5XSXhUa1VWYzJoaUxLOGZzYUZKTlJLMTAvTWN6ZUN2bmxzVldV?=
 =?utf-8?B?V3Rqc1JyQnR2K09uRkdUZFlkTFFJSlBnUmh0cWg2dXJZNjNMbGxzenhLdkhz?=
 =?utf-8?B?d1hQRzdlbGxqMHR3RjRGbGF1ak5IM3JjdWJyM1cvU01tYVh3bHl2RHppanBp?=
 =?utf-8?B?TlhWT0NBU1VuR3h3N01qeUpqZ3k3bE1DZXVObWxKdk44WFNpWm1xeVFsL0V5?=
 =?utf-8?B?S1hIOWRrRG5HelhWSFl0dnVIZ1lQWjhBYjhEc1hFeWJ5a1cwOUxpZmd1eXVs?=
 =?utf-8?B?cGZwR01tTUNRYmt4ZlZSYmZRbVBuOEczdVR5ZkNjb0dPMVNSbG5XbjRjUzF3?=
 =?utf-8?B?RGV5RUFRNE1zbnM5MmxldjkzeE9pa1BleVZuTGJ1SWhPeWRKNmluRDNwWVo2?=
 =?utf-8?B?Si9ua0lmZG1LaUM0WVMzcmdlWUd6dXBkL2hOYnJaY1dkaERObVA5bDE1anZz?=
 =?utf-8?B?Wi9GV3hnaDZUNUhaL3VQTHhET3cxR1VaSGFrZHBBOUNRMUc3RjZOZGxndGtK?=
 =?utf-8?B?YXVWcEJibVEraXNqZWsvcTE0a1YzVXJ2b1BiRFZDdjVJRzlYR2xSYnRZMzh3?=
 =?utf-8?B?dWViWGhPU29hV1FWc3UwajJRNGkxOFgzbFpiYzR6UE5aeFlOVmxRelp4Q3JN?=
 =?utf-8?B?SmxyUnBqNWZLd2lkcXZmM1BDa2xMOUFMR0ljSDRDMG5tRFNKcUZnbDN3ZGwx?=
 =?utf-8?B?OEV5M3plZDE4RVQ3TkNBRE40TXhUSWsydXBwcVlDSC9QMkswdy9CYyt5bEQ4?=
 =?utf-8?B?OForRG5CYXhScmRuNzI3d2tXVkQ2WGhDMFNRSStTTlQzazZvWVlBSUtvYzZh?=
 =?utf-8?B?NXl3b1hPRVVYZkgzS0pGQUUyUm1HUVVyK0cvQXgxK3VmdkVsMFppM0R0L3Vo?=
 =?utf-8?B?NzgxN1dIT1Nrdk5xVkE1Nk44Z1AzdVNDWDZPY1JHSm9uckR4Q21ldS9WS1do?=
 =?utf-8?B?VXdXSUxlT3I0NkJRWE5tWDlKMVJNTDZUZVY3RWthd1VvQ3dXbUpjcFZDaWt3?=
 =?utf-8?B?UjNvYmdyUDhkVHViajdzTk4rRVJFMFZ2bFFFOHRhR21zQ3FIN2JRUERNakxy?=
 =?utf-8?B?RjhNV3hJZVZKZi9XT2RUSDBVVDA2aTEyZVNTNG9LZ3NrRkt4RTVCeHRpclV5?=
 =?utf-8?B?RlVUS2RDNDJFaXZVcTZ2OXNzS1pQUFo2Q2svbmhEU3RBeGxtTFFyVFE0aG9U?=
 =?utf-8?B?aWpQQjhkdzl4TlYrNFMvcjkxcEF1ZjhDd25EaHBTcjBlR2pCcERFWDA4MHhj?=
 =?utf-8?B?RWtqb0NiS29ZZ2IzNVVaUElreG4xT1VqWWJjNFlyR1hUOW1rUmkzOHdVQjYx?=
 =?utf-8?B?NkNCZmZOZ1VzRG52WUVjQk9MVEcxYUdTU2ltNFlGN3NlL08rQWxEZ0tvSWVC?=
 =?utf-8?B?OTkweEp4dC9hbW5kZnFURFgyK0RVay8wQWVmanlHS0crZ1ZmWHF6WWZQViti?=
 =?utf-8?B?c3FBWTdUeFhxTkhvZlZwMlAvNjBwSDg4L0NVOFJwNk05TDhMdlFJRUd4VzdO?=
 =?utf-8?B?Y0tRMUx4YUM1dGEzMGdROWljUlZIQWp6UUhxazFKU1dHeGJ6SCtGTFZ0U2RX?=
 =?utf-8?B?RHhsRFJXM2Roa2NZUjQ5SUJSQVpjVmZIZ3gxWUlRN0FsbDFOVkFHSHNGaEgr?=
 =?utf-8?B?R0J5U0t0UURPakFmMEhTZFFLOWNaMDNoY1UzcUVTMFR2QThFYnJDWitxVU51?=
 =?utf-8?B?a3plUjRYbEdjOUNMcEZvQlpFN2h4TDRoV0hqK1FqZzdZRUtTeFF2S0tmVlVr?=
 =?utf-8?B?anRUQmlwN0pnVjdmb3JLRmhqbms1cURIUFJ1YTNseThyMmw0dDFrTy9Lcktp?=
 =?utf-8?B?WGxEVFdMbCtGOFB6RzYvdVZtVU5qMzViNUkxbTdDOENUUEE5ZlBhb1RYdFZ5?=
 =?utf-8?B?U251dHdvM1NjWDF5YmRMV1FLdzExajRiNm9FYzh5b2F6dVRUM0Uzcy9wNUJo?=
 =?utf-8?B?dXRDSDRlcFVSS2lrd20wRG5QS1ZycjFtWWlBREtkTk1mMEN3K0tMYW1pUlZm?=
 =?utf-8?B?b0MzcTBBbUpSaXRuQWVCenF2UHFHSmYxUEFyd3QrSEVraGVUOFg4b0dpWkdv?=
 =?utf-8?B?UXVOV3dNVnM4OW1nYkFQS0xnL3J5bnYzSDlOY3k1MlQwZWt4ZVkzOTF6VnVx?=
 =?utf-8?Q?suxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b395b4-7eb4-4a10-d16f-08db983615ac
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:37:06.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEvtGJe92CS1cKfvYlE2IhLJZUGwL+/uFiFBtKg1pr+Ese+NNCP5vBUy39enV3QZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, emily.deng@amd.com, alexander.deucher@amd.com,
 frank.min@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series is:

Acked-by: Leo Liu <leo.liu@amd.com>.


On 2023-08-08 12:26, Samir Dhume wrote:
>      The structures are the same as v4_0 except for the
>      init header
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h | 37 +++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h
> new file mode 100644
> index 000000000000..db7eb5260295
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0_3.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __MMSCH_V4_0_3_H__
> +#define __MMSCH_V4_0_3_H__
> +
> +#include "amdgpu_vcn.h"
> +#include "mmsch_v4_0.h"
> +
> +struct mmsch_v4_0_3_init_header {
> +	uint32_t version;
> +	uint32_t total_size;
> +	struct mmsch_v4_0_table_info vcn0;
> +	struct mmsch_v4_0_table_info mjpegdec0[4];
> +	struct mmsch_v4_0_table_info mjpegdec1[4];
> +};
> +#endif
