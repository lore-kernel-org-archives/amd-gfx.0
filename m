Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD1606A334
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ULrSCd4m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D7F10EC0D;
	Tue, 20 Oct 2026 17:03:18 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1FE10EC0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 17:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6FrUThASHs9+umP88iwk+ypSK0DW85vXmdDWJvPZIlVLMRS963WtdqZnDxobNuTLAJx1NBXjBztNdZWIHI4mPLtTT/bZ7UaOs/rHZPPBV4obJ1rDM2AFKW9tJOx/WEmpo1dGv4vsDXae7L9lxdLMuJoBhUq0FYZY4FrzdjkZEYOw858rdruXM3Gzbrt1/E82v61uGtHFqD8eG9VZ3jhFVVrP6EN03kAynPPtfcQZbuYds8EzVxYfArOZXDSoDFA9CdA2lZSLgIoFIz3WBQ/ynLCvNkUGCKw8dTTfTPpmGig0h8y1q35+sZg5i1QM2IItfG+MccrnGPU89TKhoIPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcNvD8JCHCogbSU4IuODw2Z2l5ByFCLR9EKX0WdB4BA=;
 b=sDf5F26XxsxAn5m1owkCzyUmpNWdfARPDPgLz7giz0rQQ7TtX/c5Lq0cMY3Kbz/AIGZ0MpyX7weL08MIAu0JcXdIkTan+vebLHSb5V9zkyOVQUc2NooTS1pxggiWjQXlpv7X+3zdzbVZQk6Xu0h6wgasTAq94wm3d1Pxh2PNpe+Vqzf8ZzLg10zT2l7M54RKgOKGLUNwOvI4cnmxezm69YCDhusxSTb0OuuoBAdiWB2arGcsRbugoRvU4/q1BZ76JdQN5cn8kwvZVlfJFEUgF6QKaxCh+EpEuFMfPgpwH8Hm8ZpPdpHbj4n+0dFdAw6Q+usbC+I5K554uAfGL17osw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcNvD8JCHCogbSU4IuODw2Z2l5ByFCLR9EKX0WdB4BA=;
 b=ULrSCd4mpFTdgz/H0xfjG/MxUSQ1QtGqngeYeRocpUEGw4OUhSzd7nqPI3B42N6192qrUhKIReotooKLD4VZGYAHN2/ONcg+u8cUtJ2b1y3N37XD46HU5fLJMsjzFSgp0UYagQUJlYxARv6nGhtecnVV49P8yJIztMk/ac4FJos=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 17:03:09 +0000
Received: from IA1PR12MB6259.namprd12.prod.outlook.com
 ([fe80::ab75:3bfb:bfbf:5f9d]) by IA1PR12MB6259.namprd12.prod.outlook.com
 ([fe80::ab75:3bfb:bfbf:5f9d%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 17:03:08 +0000
Message-ID: <471555c7-1cf4-4bd9-8575-bf2bb6a58852@amd.com>
Date: Tue, 20 Oct 2026 13:03:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cancel idle work in hw_init failure paths for
 vcn/uvd/vce/jpeg
To: amd-gfx@lists.freedesktop.org
References: <20261019153942.4067-1-leo.liu@amd.com>
 <20261020152701.18355-1-leo.liu@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20261020152701.18355-1-leo.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To IA1PR12MB6259.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6259:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b22d2a-857d-441e-9a3e-08df2ecc041f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|4143699003|56012099006|261009223327099003|261009221727099003|260925021311599003|261009220027099003|260925021911599003|261009221227099003|261009223027099003|10067099003|260925022911599003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vBwrhLgNQb0k/G/M0SGfvuzrM00+nkMpxFUvuwm9eFKe6r5UTidMpJIYzLAHiBxO70PwtazheQENC4/4BcVA1Dv2es3w4yEgfhIrvbTDYWO/1kTUomC6HsimTyqB88cJ5Zqle094IsLVpyNmACfWlBaZWHJmoeKLad6YptHcpGp8QqoR4/Lrl4Dh+FBVoYclc7JRuyf4eS7Z4fFJp0Oq6eU/WIdJT7Q8n50rBb4SFWzhN9dhiaFsqGHCFJaCTgHEyCJzxje2ZvN+jaSp3KGsBdS9bYYPT/xOBLYtKs6ZUetfFP97mRVOCQRKmXaj049a5cA8cITemlkcgzrdKIEgQ/5rnbgggonbi9ypBp9cztDLLUM2bF5qB86xx4Olc0mxbBsJti65izXGDuwht/UucaNuaDWbe2BO7AglqDXfU2hP4WVREexmKCaP1E4RQ1bEOUxhi5eIGVazdD5lpFlH/39dS6Zu7M3vpNA8S7WaPXhfJScvxzpingkrbdNFntPUv9cUMRtke3FSxr5FqMBVV9t8UCwead+Xo2+cuXqo/oJgTPiz+AdqlDpJuXg+J7V+JGVu9S6SMjEAgbKeB8MH1Wgb3dH7QAIU5y1ALfCs0EbBa+maOaEL4E7pV8azqYNTe4TpoglDt1z1QoFuAidcg+FCe39X9aipx5ofc7fC7g4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6259.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(4143699003)(56012099006)(261009223327099003)(261009221727099003)(260925021311599003)(261009220027099003)(260925021911599003)(261009221227099003)(261009223027099003)(10067099003)(260925022911599003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhHUU5hdWs2YWdFdEJoREk3em5EV1RjWGRtalcyQ1kvaHl2eldMVFE1MjMx?=
 =?utf-8?B?M25DSGtOeWxuYUhjUzIvVG1GSGQ4TC9TNDd6a2I3L3FqOUxEZkxodFg5c2lE?=
 =?utf-8?B?eGJTeHMvZ2NyRWoyK3VoWjFsY00wZTUrNlgwQWE1RUNpQjc0SjRFMXlqc3pM?=
 =?utf-8?B?VE0vT1gvQ2h0N0VzUVJJbnAzakg2RGhSZklhUjBXRlM1V0R6REFCb01GQXpE?=
 =?utf-8?B?NHltc2VZbklLVFRpYXdoeWF0bi9FQWxRR1RFUlAzb3R6WGZWS0F0eDVWbWpX?=
 =?utf-8?B?TnR0M0dKNmdPOW5iYWZMYWQwdy83eXA3QVRxNUJ3SGUvallLajNpNk52OVpz?=
 =?utf-8?B?YWZGWklYVHQzSy9sUzYvRWVuSS9jK3N2ZEJ2WHh5Nm9SUGZTTVI3Y3pwWW9N?=
 =?utf-8?B?MjVrL01TbTI3KzVaMXhsd2FjOFNJTTFudkpQWFhqNTlRdkh0N1ZIOEUzWHdk?=
 =?utf-8?B?ZDRqaC9jUlA2ZTJGTzB4Z2J3djJoRll1VnVqTU40bDJuT2JHY0g3SFF2MW9y?=
 =?utf-8?B?L1VZV2pRcXp4SXZHdEZBdUhjSFp6RmY2azdkM3E2SkZIa2U2STNDOVFza3Rm?=
 =?utf-8?B?SHUyOVBBU1dxRTJTNUtaNFlQUzhmRUd5V2RGcDFadDQ4cm41d3JWRkwrZmhL?=
 =?utf-8?B?M05PVWxwTkI3T2NoSXJyY1lmODVFS1l3QjBEc0VUWWEvUHh0QWZmdG1ZVkd3?=
 =?utf-8?B?a1cza2dwYVp4L2FEdlFDNlFrWEZzQllhVDJUb0lHRmZQWjE5cFNzMVZsL1Na?=
 =?utf-8?B?djJIVzBqQWxXUE0vTVY0Zm1PNGU0WFYrMEQ2UTltS0lDaGtWTFRLUmQvLzVG?=
 =?utf-8?B?Wng1NStXejBNNTk1eGpla21OK2FVazUwOGJsMFRrYkVxck9NblAxNXZWTFlu?=
 =?utf-8?B?STdaV1lsb0RnRnVsdXBndmZoanVpSGQ0ajB6Y1AvcFZIbng2VTJiV0JMVXFL?=
 =?utf-8?B?Z3ZRSFYvUjU1Z2lCc0tmN0tnOFBHREIxYXRBdXFCeXgwZ3o3M2UvdkcrcGxL?=
 =?utf-8?B?S0pGZXNBTzBjRm9NQ0dSM0pIblloYUw4UXhGMWZUbjdhSTc0U0lERi9TQnlK?=
 =?utf-8?B?eTVlczRxWHNQZUkrbERQZjMwT1g4d0FRMjhLN21KOFpIVGN5RE1mWUUvWWFa?=
 =?utf-8?B?NHF1THM1ZHBNanoyVmtNTjN3WlgzRUc5OG1UajdrWkdrcEtQaWZQc0YxWVMv?=
 =?utf-8?B?U2xoV3BiNjg0ZG5uSGdTWThodkxOTm1QUVZEbnlVZDB4QjBwWDR4RzZOeXpX?=
 =?utf-8?B?VzlrZC96M2pET3pnYTZaZXJ0K2dzOUd6L1N5Q0tWNXdJVHpjOTlkT0RnRi9M?=
 =?utf-8?B?Z1c5OEp4MXUvcWlSNnJqNmlnVGNJaHJuTTlWVHJTdG1LN3FwVk5yUGVKdHIy?=
 =?utf-8?B?clhHNmNhQjNOblpHK2ROVVQyNlNkOWh5SFZlT0ZTcG1FNjl1VjJDUElxM2FO?=
 =?utf-8?B?SVBTM3FHY3lDZlVVVTBra1dKVTlHNExUTktBQTUrZDgxa2pweGlwMmhsNzND?=
 =?utf-8?B?bWIrNTJHTStGb1E3eWpzdlBJYjBHaWxLZ2hyN21qckpKdXVUaFJVNFR2ejBQ?=
 =?utf-8?B?QUgzNGhTY3F5Y2hwMlBHcldFeVNjVk9NU05yaFNUQnpYWmN6TEo1OVpsSVd0?=
 =?utf-8?B?Uy85aXFvK3M2MUUyQSt4QStnZnBTYWVFUnBOOWdVZFRTb2FwN0wyUTVuSFA5?=
 =?utf-8?B?dGg0alpYNzRSNlQyTmJZV3pZVGlxalhDOXdhOG9rcUh1UHVDVU45QStkS1Bk?=
 =?utf-8?B?MlUzK3h6cHM0bElpQmRYTjBKU1V5eXVmNnl3RkhpT3FHVkdzNHF3dmgvVHJk?=
 =?utf-8?B?QzhYTWlLcHduNnl1VnllMTQveUFORkZ5K0hTRFc0RGJHWEZXb1BETjg5RVZX?=
 =?utf-8?B?cGIvd2oreGZhdVI0TG1VWTZ1R0UzaFlBcHhhQWFvYlR5VENXU0ZmMTJrRUhD?=
 =?utf-8?B?TGNQdzhyQ2tZS1pPRnAveWJKVmNFMFFsTDZibTVseUhEcVRBNVp0bUZyVm1k?=
 =?utf-8?B?RE9YQ0p0SU1JR29MbWhFbHpWeVJpRkZRRXF6SEdNN1hyakU0OERyM0JVYzhj?=
 =?utf-8?B?MGVUTHgybWZtVmExUTBSWm56YWJlQmZwWUwydTZOT08weXE2bUQxdGJxUzJW?=
 =?utf-8?B?OXNtS1NJY0ljTjFuYU1IS2wyOTJwTGhpVFhIQjEvTElnQnFJLzFrMzN6YW1H?=
 =?utf-8?B?QVU0blZYVVpuMnZvQVlKbnQ2ejdNcUk2bnFBeEtid2V2dk5IeDAzdy8yeDh3?=
 =?utf-8?B?R3p6WnE2bURXTTFtd1VpWHp5aytwa1Y4Yk43SU9UZUxQQW83WnBiOEhESUxS?=
 =?utf-8?B?YmJEeW0yUStZekYxRTBYQjF1UmtPaDVvWGdNZFJPZHNVRmNGUlBJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b22d2a-857d-441e-9a3e-08df2ecc041f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:03:08.8440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EHPbauseYkdJmVGD/A1Uoy6rKS13gibrZI/ESuOq22iaNXfVZd7GRERJ9QhuhCDbe3SfNNgyv5jRdxMDr0Rfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Leo,

Besides the cleanup of the pending work, do we need to consider PG as 
well? I think it could potentially
cause more power consumption.

Regards,
David
On 2026-10-20 11:27, Leo Liu wrote:
> From: "Liu, Leo" <Leo.Liu+amdeng@amd.com>
>
> When hw_init() fails, amdgpu_device_ip_fini_early() skips hw_fini()
> because status.hw was never set.  For VCN, UVD (including UVD ENC), VCE,
> and JPEG, hw_fini() is where cancel_delayed_work_sync() is called.  Any
> idle work queued during the partial hw_init() is therefore left pending
> after sw_fini() frees the adev state the handler touches.
>
> Cancel the idle work in each hw_init() error path, immediately before
> returning the error, so that hw_fini() remains the sole cancel site on
> the normal teardown path with no duplication.
>
> Link: https://github.com/ROCm/amdgpu/issues/234
> Fixes: 416e1fab4752 ("drm/amdgpu: drop redundant cancel_delayed_work_sync call")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:Claude-Sonnet-4.6
> Signed-off-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c    |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c    |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  6 +++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 11 +++++++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    | 11 +++++++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    | 11 +++++++++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  9 ++++++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  9 ++++++++-
>   29 files changed, 166 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..c88cedfd4aa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -163,7 +163,11 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>   		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>   
> -	return amdgpu_ring_test_helper(ring);
> +	int r = amdgpu_ring_test_helper(ring);
> +
> +	if (r)
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..46293664fd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -221,10 +221,14 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..0e4dee12db11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -178,7 +178,11 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>   		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>   
> -	return amdgpu_ring_test_helper(ring);
> +	int r = amdgpu_ring_test_helper(ring);
> +
> +	if (r)
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..4e8eed2b62db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -204,10 +204,14 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..1925d3092d02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -435,12 +435,16 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   							VCN_JPEG_DB_CTRL__EN_MASK);
>   				r = amdgpu_ring_test_helper(ring);
>   				if (r)
> -					return r;
> +					goto error;
>   			}
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..a1496412810c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -232,10 +232,14 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   		ring = adev->jpeg.inst[i].ring_dec;
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..1a4594d5d952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -173,9 +173,13 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
> -		return r;
> +		goto error;
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..efdc537ec81e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -307,11 +307,15 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>   						    VCN_JPEG_DB_CTRL__EN_MASK);
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..eb3dc9558e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -280,11 +280,15 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
>   						    VCN_JPEG_DB_CTRL__EN_MASK);
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..0cbb2b8a7e78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -156,9 +156,13 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
> -		return r;
> +		goto error;
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index ff7128a11cad..97c265daa2bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -710,7 +710,9 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
>   	amdgpu_ring_commit(ring);
>   
>   done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>   		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index cf304b489d87..90b57a08d6dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -198,7 +198,9 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
>   	amdgpu_ring_commit(ring);
>   
>   done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>   		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 564d8fb58905..aa75b2691d57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -190,7 +190,9 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	amdgpu_ring_commit(ring);
>   
>   done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>   		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index dcb8487e22b1..3016227cf0ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -515,7 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	}
>   
>   done:
> -	if (!r) {
> +	if (r) {
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	} else {
>   		if (uvd_v6_0_enc_support(adev))
>   			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
>   		else
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 46222fc30be6..48eac56f758e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -583,7 +583,9 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	}
>   done:
> -	if (!r)
> +	if (r)
> +		cancel_delayed_work_sync(&adev->uvd.idle_work);
> +	else
>   		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index b1428f5bbc81..0ba9bab7c921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -651,12 +651,16 @@ static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vce.num_rings; i++) {
>   		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	dev_info(adev->dev, "VCE initialized successfully.\n");
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>   }
>   
>   static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index dd870ecac2a4..20a4cb6d17fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -483,12 +483,16 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vce.num_rings; i++) {
>   		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>   }
>   
>   static int vce_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index d5adccd3e689..7637305df7e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -482,12 +482,16 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vce.num_rings; i++) {
>   		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>   }
>   
>   static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index ee445d8abe47..4e1fbc7b50f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -533,12 +533,16 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vce.num_rings; i++) {
>   		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +	return r;
>   }
>   
>   static int vce_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..b3e63d6e79a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -252,18 +252,25 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
> -		return r;
> +		goto error_vcn;
>   
>   	for (i = 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error_vcn;
>   	}
>   
>   	ring = adev->jpeg.inst->ring_dec;
>   	r = amdgpu_ring_test_helper(ring);
> +	if (r)
> +		goto error_both;
> +	return 0;
>   
> +error_both:
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +error_vcn:
> +	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..12ac20484396 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -294,7 +294,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
> -		return r;
> +		goto error;
>   
>   	//Disable vcn decode for sriov
>   	if (amdgpu_sriov_vf(adev))
> @@ -304,10 +304,14 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..be198680334b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -481,18 +481,25 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   
>   			for (i = 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
>   				ring = &adev->vcn.inst[j].ring_enc[i];
>   				r = amdgpu_ring_test_helper(ring);
>   				if (r)
> -					return r;
> +					goto error;
>   			}
>   		}
>   	}
>   
>   	return r;
> +
> +error:
> +	for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
> +		if (!(adev->vcn.harvest_config & (1 << j)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[j].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..a532fe72ed75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -417,18 +417,25 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   
>   			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
>   				ring = &adev->vcn.inst[i].ring_enc[j];
>   				r = amdgpu_ring_test_helper(ring);
>   				if (r)
> -					return r;
> +					goto error;
>   			}
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..8345c45ec5df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -349,11 +349,18 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..a2d5b9901fef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -395,11 +395,18 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return r;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..86d766f0c61e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -303,10 +303,17 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..a4d0de29fd26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -267,10 +267,17 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   		r = amdgpu_ring_test_helper(ring);
>   		if (r)
> -			return r;
> +			goto error;
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..e64ca2bb05e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -342,11 +342,18 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..ebf98878c2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -257,11 +257,18 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
>   
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
> -				return r;
> +				goto error;
>   		}
>   	}
>   
>   	return 0;
> +
> +error:
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		if (!(adev->vcn.harvest_config & (1 << i)))
> +			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +	}
> +	return r;
>   }
>   
>   /**
